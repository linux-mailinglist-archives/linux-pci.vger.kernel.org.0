Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBA3196915
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 21:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgC1UKw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 16:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbgC1UKv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Mar 2020 16:10:51 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9828620714;
        Sat, 28 Mar 2020 20:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585426251;
        bh=y5yzLi3cb1TQJa0h0JpfhGNefpfRVZxhnABTprP5yQc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hAGlvt8T4EJg4UU1MojX93lTAVwTYsR0tw/vkobToKchqRTDUpt0l4orZNU/RZoMa
         hmYrAyUh5VOGiGHsln+5sAZSAp8zTDc9aZDUcsc+yCkaHb8cqglq+IA6I0opPgBazf
         VhpB/BlVGIhRubwZS2joBE4j4xNPhf3e2gpShGqg=
Date:   Sat, 28 Mar 2020 15:10:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Reduce severity of log message
Message-ID: <20200328201049.GA106845@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323035530.11569-1-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 23, 2020 at 04:55:30PM +1300, Chris Packham wrote:
> When the UEFI/BIOS or bootloader has not initialised a PCIe device we
> would get the following message.
> 
>   kern.warning: pci 0000:00:01.0: ASPM: current common clock configuration is broken, reconfiguring
> 
> "warning" and "broken" are slightly misleading. On an embedded system it
> is quite possible for the bootloader to avoid configuring PCIe devices
> if they are not needed.
> 
> Downgrade the message to pci_info() and change "broken" to
> "inconsistent" since we fix up the inconsistency in the code immediately
> following the message (and emit an error if that fails).
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied to pci/aspm for v5.7, thanks!

> ---
> I'm updating a system from an older kernel to the latest and our tests flagged
> this error message. I don't believe it's actually an error since our bootloader
> doesn't touch the PCI bus (infact the kernel releases the reset to that
> particular device before the PCI bus scan).
> 
>  drivers/pci/pcie/aspm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 0dcd44308228..3a165ab3413b 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -273,7 +273,7 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>  		}
>  		if (consistent)
>  			return;
> -		pci_warn(parent, "ASPM: current common clock configuration is broken, reconfiguring\n");
> +		pci_info(parent, "ASPM: current common clock configuration is inconsistent, reconfiguring\n");
>  	}
>  
>  	/* Configure downstream component, all functions */
> -- 
> 2.25.1
> 

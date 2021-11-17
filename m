Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7374454E54
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 21:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbhKQUPq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 15:15:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231429AbhKQUPq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 15:15:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA21661A02;
        Wed, 17 Nov 2021 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637179967;
        bh=904k1QZHkAzDkH8p/NTXmVnMiM16fjvDv4rwfiAd0tw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pYV1mCKBdiYayyLyQDWR03NiyHn3HA1Xwise2m/GJf78mXdAd5GEOlXgRmc29Tygj
         3vSrP/lOQRxJaUQfS5do0gP14yjoBPEwqRByWLXTQ8610bx3JDgbEqPAn8QfH+dNp8
         44KU0J0LvraiTm45Gz/GJFIdYpRWqOSMveaUbbp8Zvw3IcrHLRyhARHXE2T5aztIBh
         jUJEZBezcBXULMao2/KT6+XUXwqti/7sgnW6piccaz5mfkolDwORsYY5r3zU2psiD7
         oV9uS+lL5vFIx2ptQpgiGfwjxpsGagR96QehVWQZbQ9Wb/GoS0SXL0sbsyBpXir2eZ
         xdlh+ZexkKOYA==
Date:   Wed, 17 Nov 2021 14:12:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, kernel-team@android.com,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH] PCI: apple: Reset the port for 100ms on probe
Message-ID: <20211117201245.GA1768803@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117160053.232158-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Pali]

On Wed, Nov 17, 2021 at 04:00:53PM +0000, Marc Zyngier wrote:
> While the Apple PCIe driver works correctly when directly booted
> from the firmware, it fails to initialise when the kernel is booted
> from a bootloader using PCIe such as u-boot.
> 
> That's beacuse we're missing a proper reset of the port (we only
> clear the reset, but never assert it).

s/beacuse/because/

> Bring the port back to life by wiggling the #PERST pin for 100ms
> (as per the spec).

I cc'd Pali because I think he's interested in consolidating or
somehow rationalizing delays like this.

If we have a specific spec reference here, I think it would help that
effort.  I *think* it's PCIe r5.0, sec 6.6.1, which mentions the 100ms
along with some additional constraints, like waiting 100ms after Link
training completes for ports that support > 5.0 GT/s, whether
Readiness Notifications are used, and CRS Software Visiblity.

> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/pcie-apple.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 1bf4d75b61be..bbea5f6e0a68 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -543,6 +543,9 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Hold #PERST for 100ms as per the spec */
> +	gpiod_set_value(reset, 0);
> +	msleep(100);
>  	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
>  	gpiod_set_value(reset, 1);
>  
> -- 
> 2.30.2
> 

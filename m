Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C13F46C09F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 17:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbhLGQ0d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 11:26:33 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54508 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbhLGQ0d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 11:26:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BF5EECE1C1D;
        Tue,  7 Dec 2021 16:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B26BC341C1;
        Tue,  7 Dec 2021 16:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638894179;
        bh=J8QNuptCRMd5FPz3sYAxGk59NtvnPv/BN3NdiOYbym8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rm1+9y3P//iqR/ITy9maM963Sskw8m0oJfvWK2EEs1y+/CTy6C9o/y1lEn0dUP+AZ
         AajiJaIlEVhQrRTdoL/ir417yGdqSMr1jxcKPsB6COnYaE0IsvxN2/5DYjWNS3eht/
         4OgIt85RvmWm37ulTCpw2Ugf9Hxmoxd9FJdEbAWlsfKFrNzObAGUHsyRBeTrJV5VTK
         f2/eCAdCfsjcIa+0DqqRsTnSCH3kqyIDu35kmiOVE/wPJ86JV2gA5QCFGsGgsQMUNV
         XblxC6rzvJeGo/BHRGOwoPRfsoxv0vFxNY/zN1x/0cd9zQ3LN3/esS8cWG/GA5Jmcu
         O4RtyJLyldrhQ==
Date:   Tue, 7 Dec 2021 10:22:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Luca Ceresoli <luca@lucaceresoli.net>, kernel-team@android.com
Subject: Re: [PATCH v3 1/3] PCI: apple: Follow the PCIe specifications when
 resetting the port
Message-ID: <20211207162257.GA44468@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211123180636.80558-2-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 23, 2021 at 06:06:34PM +0000, Marc Zyngier wrote:
> While the Apple PCIe driver works correctly when directly booted
> from the firmware, it fails to initialise when the kernel is booted
> from a bootloader using PCIe such as u-boot.
> 
> That's beacuse we're missing a proper reset of the port (we only
> clear the reset, but never assert it).
> 
> The PCIe spec requirements are two-fold:
> 
> - #PERST must be asserted before setting up the clocks, and
>   stay asserted for at least 100us (Tperst-clk).
> 
> - Once #PERST is deasserted, the OS must wait for at least 100ms
>   "from the end of a Conventional Reset" before we can start talking
>   to the devices

Unless somebody objects, I'll s/#PERST/PERST#/ to match the spec
usage, both here and in the comments below.

I also notice gpiod_get_from_of_node(..., "#PERST") earlier in
apple_pcie_setup_port().  If it wouldn't break anything, I'd like to
change that, too.

> Implementing this results in a booting system.
> 
> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> Acked-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/pcie-apple.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 1bf4d75b61be..957960a733c4 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -539,13 +539,23 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  
>  	rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);
>  
> +	/* Engage #PERST before setting up the clock */
> +	gpiod_set_value(reset, 0);
> +
>  	ret = apple_pcie_setup_refclk(pcie, port);
>  	if (ret < 0)
>  		return ret;
>  
> +	/* The minimal Tperst-clk value is 100us (PCIe CMS r2.0, 2.6.2) */
> +	usleep_range(100, 200);

Spec says "min 100us from REFCLK stable before PERST# inactive".  So I
guess when apple_pcie_setup_refclk() returns, we know REFCLK is
already stable?

> +	/* Deassert #PERST */
>  	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
>  	gpiod_set_value(reset, 1);
>  
> +	/* Wait for 100ms after #PERST deassertion (PCIe r2.0, 6.6.1) */
> +	msleep(100);

Does this port support speeds greater than 5 GT/s?  If so, 6.6.1 says
we need "100ms after Link training completes," not just after
deasserting PERST#.

I'll update this citation to "PCIe r5.0, 6.6.1" to reference the
current spec.

>  	ret = readl_relaxed_poll_timeout(port->base + PORT_STATUS, stat,
>  					 stat & PORT_STATUS_READY, 100, 250000);
>  	if (ret < 0) {
> -- 
> 2.30.2
> 

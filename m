Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881BB1C07F7
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 22:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgD3Ucz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 16:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgD3Ucz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 16:32:55 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 630C020731;
        Thu, 30 Apr 2020 20:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588278774;
        bh=zzOnZ2B7AsiXDdVWneijt0yscUPJzfIVROepioX7gdA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zd5B1ASeI/cKNjmR9Kf5s0atSdNzjmUWfNULcGEiUguAUlByj0/PuGPATMJIx9jHv
         WCAH+L+iFs5BnjP2mGyb5l94EBqey4Zj0mSzBEZGBt1rtwBurlaMNpQ4opqZkzjKPx
         C3AKyYptt/ieWhnd4glH2ZPvpWjAI2QT7vwx6c+w=
Date:   Thu, 30 Apr 2020 15:32:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] PCI: brcmstb: enable CRS
Message-ID: <20200430203252.GA62266@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430185522.4116-3-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 02:55:20PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Configuration Retry Request Status is off by default on this
> PCIe controller.  Turn it on.

Are you talking about CRS itself, i.e., the ability of a Root Port to
deal with Completions with Configuration Retry Request Status?  That
really shouldn't be switchable in the hardware since it's a required
feature for all PCIe devices.

Or are you talking about CRS Software Visibility, which is controlled
by a bit in the PCIe Root Control register?  That *should* be managed
by the PCI core in pci_enable_crs().  Does that generic method of
controlling it not work for this device?

It looks like maybe the latter, since the generic:

  #define  PCI_EXP_RTCTL_CRSSVE   0x0010

matches your new PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL_RC_CRS_EN_MASK.

If pci_enable_crs() doesn't work on this device, it sounds like a
hardware defect that we need to work around, but I'm not sure that
just enabling it unconditionally here is the right thing.

> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 5b0dec5971b8..2bc913c0262c 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -34,6 +34,9 @@
>  #define BRCM_PCIE_CAP_REGS				0x00ac
>  
>  /* Broadcom STB PCIe Register Offsets */
> +#define PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL			0x00c8
> +#define  PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL_RC_CRS_EN_MASK	0x10
> +
>  #define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1				0x0188
>  #define  PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK	0xc
>  #define  PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN			0x0
> @@ -827,6 +830,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  		 pci_speed_string(pcie_link_speed[cls]), nlw,
>  		 ssc_good ? "(SSC)" : "(!SSC)");
>  
> +	/* Enable configuration request retry (CRS) */
> +	tmp = readl(base + PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL);
> +	u32p_replace_bits(&tmp, 1,
> +			  PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL_RC_CRS_EN_MASK);
> +	writel(tmp, base + PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL);
> +
>  	/* PCIe->SCB endian mode for BAR */
>  	tmp = readl(base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
>  	u32p_replace_bits(&tmp, PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN,
> -- 
> 2.17.1
> 

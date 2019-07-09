Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807896378D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 16:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfGIOOb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 10:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfGIOOb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jul 2019 10:14:31 -0400
Received: from localhost (249.sub-174-234-174.myvzw.com [174.234.174.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 175D92080C;
        Tue,  9 Jul 2019 14:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562681670;
        bh=aByOK+zzVwLPzmHerWij80ctxh6Sgg+/BIZzdxbJl4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AGNoPj52haojTKl83cHZhTcXgNZoRA03liHpBu8SHLapzLI5hKhvptQB/VzjqI+Gd
         81+/WoF2FUAEVmTEC+Gps7rhtlY6ZjvnZdmu5exXK6xN+a6GL3lPXvn8ULTA6Zon/Y
         0RpkAvPpzrniAx4NnJlh0LbdktlTQk6jN6IdViro=
Date:   Tue, 9 Jul 2019 09:14:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V12 01/12] PCI: Add #defines for some of PCIe spec r4.0
 features
Message-ID: <20190709141427.GB35486@google.com>
References: <20190701124010.7484-1-vidyas@nvidia.com>
 <20190701124010.7484-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701124010.7484-2-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 01, 2019 at 06:09:59PM +0530, Vidya Sagar wrote:
> Add #defines only for the Data Link Feature and Physical Layer 16.0 GT/s
> features.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Please include spec references in the commit log, e.g., PCIe r5.0, sec
7.7.4, for Data Link Feature and sec 7.7.5 for Physical Layer 16 GT/s.

>  include/uapi/linux/pci_regs.h | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f28e562d7ca8..1c79f6a097d2 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -713,7 +713,9 @@
>  #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
>  #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
>  #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
> +#define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
> +#define PCI_EXT_CAP_ID_PL	0x26	/* Physical Layer 16.0 GT/s */

Maybe PCI_EXT_CAP_ID_PL_16GT so there's a little more hint of what
this is for?

> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL
>  
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> @@ -1053,4 +1055,22 @@
>  #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /* LTR_L1.2_THRESHOLD_Scale */
>  #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register */
>  
> +/* Data Link Feature */
> +#define PCI_DLF_CAP		0x04	/* Capabilities Register */
> +#define  PCI_DLF_LOCAL_DLF_SUP_MASK	0x007fffff  /* Local Data Link Feature Supported */
> +#define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link Feature Exchange Enable */
> +#define PCI_DLF_STS		0x08	/* Status Register */
> +#define  PCI_DLF_REMOTE_DLF_SUP_MASK	0x007fffff  /* Remote Data Link Feature Supported */
> +#define  PCI_DLF_REMOTE_DLF_SUP_VALID	0x80000000  /* Remote Data Link Feature Support Valid */

I'm a little bit ambivalent about adding #defines that aren't used.  I
personally would probably just add the things we use, so the header
file gives a clue about what's currently implemented.  But I guess
either way is fine.

> +/* Physical Layer 16.0 GT/s */
> +#define PCI_PL_16GT_CAP		0x04	/* Capabilities Register */
> +#define PCI_PL_16GT_CTRL	0x08	/* Control Register */
> +#define PCI_PL_16GT_STS		0x0c	/* Status Register */
> +#define PCI_PL_16GT_LDPM_STS	0x10	/* Local Data Parity Mismatch Status Register */
> +#define PCI_PL_16GT_FRDPM_STS	0x14	/* First Retimer Data Parity Mismatch Status Register */
> +#define PCI_PL_16GT_SRDPM_STS	0x18	/* Second Retimer Data Parity Mismatch Status Register */
> +#define PCI_PL_16GT_RSVD	0x1C	/* Reserved */

Use lower-case hex consistently here.  There's no global consistency
in this file, but we can at least be consistent in each section.  But
I'm even more hesitant about included unused #defines for "reserved"
fields, so if you drop this it would take care of both :)

> +#define PCI_PL_16GT_LE_CTRL	0x20	/* Lane Equalization Control Register */

This is the only register you actually use.  You defined a local
PL16G_CAP_OFF_DSP_16G_TX_PRESET_MASK for this register.  Shouldn't
that be defined here instead of in
drivers/pci/controller/dwc/pcie-tegra194.c?

>  #endif /* LINUX_PCI_REGS_H */
> -- 
> 2.17.1
> 

Return-Path: <linux-pci+bounces-257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCF07FE3F6
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 00:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0EF282217
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 23:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C7D219FE;
	Wed, 29 Nov 2023 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnIiSLEM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C64CB35
	for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 23:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F03C433C7;
	Wed, 29 Nov 2023 23:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701299102;
	bh=ocnpT9HbgoTcC5a8ITcicRwRnx95E5RHNz/6+ZrSLlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AnIiSLEMSOsbbOwI9AX9kFI+ng7eelLPkos5NdJYXOYA8o03CznL1MP1/jL0tDZgw
	 8CIv+rL05MAh3w6tDVJtSm6ee+0Y2ddsyEqMckcT9HTmX2UosylQ54eHJpJtAGmhb9
	 rJ6VadFKmAHUWeNTTF83miklRCOBDIoHYhgaU9lQFOkpSCqY0W7eYnbsvjhPIRcaBJ
	 5zRp/AoRhIo33jNmY9TBZZnCeLk96H/GSMKJ/kzNTjRfgTuMcwek+FDeI+4D7cXlWN
	 ZjA2EKj8fSnwPCP7DZEZzpW+U5ftqbj/1mnq8jQd2h301hBQCWE1Hw2zH4Aum5zz37
	 wBI10eEFBvpWg==
Date: Wed, 29 Nov 2023 17:05:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Harry Song <jundongsong1@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/RTR: Add RTR capability structure register
 definitions
Message-ID: <20231129230501.GA443118@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126071420.4207-1-jundongsong1@gmail.com>

On Sun, Nov 26, 2023 at 03:14:20PM +0800, Harry Song wrote:
> Add RTR(Readiness Time Reporting) capability structure register
> definitions for use in subsequent patches.
> See the PCIe r3.1 spec, sec 7.35.

Please use the current spec revision, e.g., r6.0 or r6.1.

Deferring this for now; please include it in the same series as the
subsequent patches that use these definitions.

Thanks for working on this!

> Signed-off-by: Harry Song <jundongsong1@gmail.com>
> ---
>  include/uapi/linux/pci_regs.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 85ab12788..47db4915b 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -734,6 +734,7 @@
>  #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
>  #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
>  #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
> +#define PCI_EXT_CAP_ID_RTR	0x22	/* Readiness Time Reporting */
>  #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
>  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> @@ -1065,6 +1066,14 @@
>  #define  PCI_PTM_CTRL_ENABLE		0x00000001  /* PTM enable */
>  #define  PCI_PTM_CTRL_ROOT		0x00000002  /* Root select */
>  
> +/* Readiness Time Reporting */
> +#define PCI_RTR_CAP			0x04	    /* RTR Capability */
> +#define  PCI_RTR_RST_TIME_MASK		0xFFF	    /* RTR Reset Time Mask */

These register fields are not called "masks" in the spec; let's try
to make them match the spec terminology.

Add leading zeroes to these values so the constant matches the width
of the register, as is done for other similar values in this file.

> +#define  PCI_RTR_DLUP_TIME_MASK		0xFFF000    /* RTR Downstream Link UP Time Mask */
> +#define PCI_RTR_CAP2			0x08	    /* RTR Capability 2 */

PCI_RTR_CAP and PCI_RTR_CAP2 are called "Readiness Time Reporting 1
Register" and "Readiness Time Reporting 2 Register" in the spec, so
calling them _CAP and "Capability" is confusing.

> +#define  PCI_RTR_FLR_TIME_MASK		0xFFF	    /* RTR Function Level Reset Time Mask */
> +#define  PCI_RTR_D3_TO_D0_TIME_MASK	0xFFF000    /* RTR D3-hot To D0 Time Mask */
> +
>  /* ASPM L1 PM Substates */
>  #define PCI_L1SS_CAP		0x04	/* Capabilities Register */
>  #define  PCI_L1SS_CAP_PCIPM_L1_2	0x00000001  /* PCI-PM L1.2 Supported */
> -- 
> 2.17.1
> 


Return-Path: <linux-pci+bounces-33583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C29B1DF3B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 00:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9069958393C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 22:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171D41D6DDD;
	Thu,  7 Aug 2025 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oH0Z+OaL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF03E1C8633;
	Thu,  7 Aug 2025 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754604419; cv=none; b=Yh/Wh77/6SH8yydrF7VyG3PZNKVaOYomgZnCg87q2HmMYVtJJOYtIN+ksStjC4X4IncSZX4CqSZ5RNMxnjCdisIj+z41MXfYCmO7vF1l69rFYzTWVHPa6VIApIvvZImfQkwbt5jQSVrzjsiiJIbMM2ZKyTRS5FdN0+nz+Hm9a8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754604419; c=relaxed/simple;
	bh=1SWxxfi61RujHsu60gIIs45W2VXsmKVDVQQiD1um0cg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ran1yEtNKO5N+3PYsBu9vVDKEU6FFMrh2//KwLO/PpGiBc8Mw9Cx0a7ycrixiB+SHrlbGHcEzVjw9xRL07nHJ35sw2VQUQJzE3S5ib9LKVjLYagxNk6LXRhSi3aqmWivFjwp887Q8NGOiIGi8p0rsvRrc5EtjcBuXaTGmOT542c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oH0Z+OaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45420C4CEEB;
	Thu,  7 Aug 2025 22:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754604418;
	bh=1SWxxfi61RujHsu60gIIs45W2VXsmKVDVQQiD1um0cg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oH0Z+OaLZOmV+fFy6/TagyO1FMXPmamR/gtjVpF3M+wb3LCDQnF7Fgyr3rhArTVEa
	 +lEn6ZoykEvueSwHa6z9/HptkVvU0XO6q0dEB/GivqsrD7nyPSXS9X5boAu7Y+Y2c1
	 PF8PM2m9t1YCZs1c+/xNMekFoCWxCUWMqMC46F8Of8ABAb/t4khx4MCTu+X08lLF3h
	 W/SGQAsWSem0rJrYQbumhMWgtjc/tRm8HqCZnC4BGJgPEAJsD/bG+WZ52xIEXGQtT5
	 inoqL4rqK1iLZf2nimkpbY+a9XwaaP8lklkFaGEdLMsNCy2PYsOQL6o3HT4qrT+mUG
	 nZxizCIQEpCtw==
Date: Thu, 7 Aug 2025 17:06:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 06/10] PCI: Add PCIe Device 3 Extended Capability
 enumeration
Message-ID: <20250807220656.GA64413@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717183358.1332417-7-dan.j.williams@intel.com>

On Thu, Jul 17, 2025 at 11:33:54AM -0700, Dan Williams wrote:
> PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
> enumerates new link capabilities and status added for Gen 6 devices. One

s/ added for Gen 6 devices//

I know the "Gen 6 device" terminology is pervasive, but the spec
suggests avoiding it because it's so ambiguous.

> of the link details enumerated in that register block is the "Segment
> Captured" status in the Device Status 3 register. That status is
> relevant for enabling IDE (Integrity & Data Encryption) whereby
> Selective IDE streams can be limited to a given Requester ID range
> within a given segment.
> 
> If a device has captured its Segment value then it knows that PCIe Flit
> Mode is enabled via all links in the path that a configuration write
> traversed. IDE establishment requires that "Segment Base" in
> IDE RID Association Register 2 (PCIe 6.2 Section 7.9.26.5.4.2) be
> programmed if the RID association mechanism is in effect.
> 
> When / if IDE + Flit Mode capable devices arrive, the PCI core needs to
> setup the segment base when using the RID association facility, but no
> known deployments today depend on this.

So far this mentions a lot of facts, but only the subject hints at
what it does.  I guess it just captures the Flit Mode status, inferred
by Segment Captured?

I'm OK with basically just saying *that*, and moving some of the
implications to places where we depend on them.

> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/pci/probe.c           | 12 ++++++++++++
>  include/linux/pci.h           |  1 +
>  include/uapi/linux/pci_regs.h |  7 +++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e19e7a926423..9ed25035a06d 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2271,6 +2271,17 @@ int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
>  	return 0;
>  }
>  
> +static void pci_dev3_init(struct pci_dev *pdev)
> +{
> +	u16 cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DEV3);
> +	u32 val = 0;
> +
> +	if (!cap)
> +		return;
> +	pci_read_config_dword(pdev, cap + PCI_DEV3_STA, &val);
> +	pdev->fm_enabled = !!(val & PCI_DEV3_STA_SEGMENT);
> +}
> +
>  /**
>   * pcie_relaxed_ordering_enabled - Probe for PCIe relaxed ordering enable
>   * @dev: PCI device to query
> @@ -2625,6 +2636,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_doe_init(dev);		/* Data Object Exchange */
>  	pci_tph_init(dev);		/* TLP Processing Hints */
>  	pci_rebar_init(dev);		/* Resizable BAR */
> +	pci_dev3_init(dev);		/* Device 3 capabilities */
>  	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
>  
>  	pcie_report_downtraining(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0e5703fad0f6..a7353df51fea 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -444,6 +444,7 @@ struct pci_dev {
>  	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
>  	unsigned int	pri_enabled:1;		/* Page Request Interface */
>  	unsigned int	tph_enabled:1;		/* TLP Processing Hints */
> +	unsigned int	fm_enabled:1;		/* Flit Mode (segment captured) */
>  	unsigned int	is_managed:1;		/* Managed via devres */
>  	unsigned int	is_msi_managed:1;	/* MSI release via devres installed */
>  	unsigned int	needs_freset:1;		/* Requires fundamental reset */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 1b991a88c19c..2d49a4786a9f 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -751,6 +751,7 @@
>  #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> +#define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
>  #define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
>  #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
>  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
> @@ -1227,6 +1228,12 @@
>  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
>  
> +/* Device 3 Extended Capability */
> +#define PCI_DEV3_CAP		0x4	/* Device 3 Capabilities Register */
> +#define PCI_DEV3_CTL		0x8	/* Device 3 Control Register */
> +#define PCI_DEV3_STA		0xc	/* Device 3 Status Register */
> +#define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */
> +
>  /* Compute Express Link (CXL r3.1, sec 8.1.5) */
>  #define PCI_DVSEC_CXL_PORT				3
>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
> -- 
> 2.50.1
> 


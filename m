Return-Path: <linux-pci+bounces-189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B53C7FA8A2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 19:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044422815C1
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 18:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF123A8FE;
	Mon, 27 Nov 2023 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EF8FoycW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A97419A
	for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 10:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701108635; x=1732644635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vCbrR4pG+hgSkD3swhB+XYqmPRGFr/ibMuVqmdV0NDU=;
  b=EF8FoycWwM0zy9g0TvO1evataDrdPUePpocyiOA1+xpL8NEm+kujHgMU
   9YKClTBElPcq0JdmbupWfCV5cFA1GfHel17J8JUVRA6g2NSqav9dYNlrd
   ssUebEZsGAvzqcEZeMS72j2TpSJm3Prc5UYw05AABKMXa2XVw0EToXkpZ
   45nrWEhuTbY++MulFkk7iqocZnMGfNfmczTokoWhOxWu/xkROQ4g0eQm2
   xFXdv/rU8AnRol17/cxTy2UBmtpehH3ppFhixa+iC/45h29JZRUcV2neb
   n62Wy/V3IocYdRQDOf2AifnfaZEgO28/BNTApRfx/AtKBCRLS6XfOczJ5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="389914959"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="389914959"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 10:10:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="838792191"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="838792191"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 10:10:20 -0800
Date: Mon, 27 Nov 2023 10:07:55 -0800
From: Ashok Raj <ashok_raj@linux.intel.com>
To: Harry Song <jundongsong1@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] PCI/RTR: Add RTR capability structure register
 definitions
Message-ID: <ZWTa++lOsIJ2C4xu@araj-dh-work.jf.intel.com>
References: <20231126071420.4207-1-jundongsong1@gmail.com>
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

Are the other patches coming later? It would make sense to add this as the
first patch with a series if possible.  

> 
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
> +#define  PCI_RTR_DLUP_TIME_MASK		0xFFF000    /* RTR Downstream Link UP Time Mask */
> +#define PCI_RTR_CAP2			0x08	    /* RTR Capability 2 */

RTR_CAP and RTR_CAP2 seems odd. Can you call it RTR_CAP1 and RTR_CAP2
instead?

Did you leave out the bit31 indicating the fields are valid?

> +#define  PCI_RTR_FLR_TIME_MASK		0xFFF	    /* RTR Function Level Reset Time Mask */
> +#define  PCI_RTR_D3_TO_D0_TIME_MASK	0xFFF000    /* RTR D3-hot To D0 Time Mask */

Should ^^ be aligned to previous line?

> +
>  /* ASPM L1 PM Substates */
>  #define PCI_L1SS_CAP		0x04	/* Capabilities Register */
>  #define  PCI_L1SS_CAP_PCIPM_L1_2	0x00000001  /* PCI-PM L1.2 Supported */
> -- 
> 2.17.1
> 
 


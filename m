Return-Path: <linux-pci+bounces-35279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B62B3EA7B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 17:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 095C04E2DC7
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFBB30C608;
	Mon,  1 Sep 2025 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGIvI9AR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060011DF271
	for <linux-pci@vger.kernel.org>; Mon,  1 Sep 2025 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740046; cv=none; b=WO2r2BywBxqncY9anuZg1MyvHzxU++hmsJWFpoe6k7PwT5sCrF9Hi6N2mspXGUcx2boqjWfmo8PtRDAeUItbWXW1akzKPZTMj/x/CQJVmlEJK8d79gWjQRBeyxiBjW6FkayStHLt7C5vwP5HyJzBU5vDPORtLjgiC7Qz9XXhWxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740046; c=relaxed/simple;
	bh=mel0sP1S1UZU3Xkn/7UnF8o+gUk0oxpwGtXR4J6IJ+g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jW7YvPy90Jq3qOAJWuMO9J0SjD805vcejRXdL9APMcUWrbP+qkRn0F13xJEO+ItEt912gkJiOownjUwciIqRO3FIEB6Ir6CUe3e3C6y6DNmUHcfAmQCQ+B2aoNM0/DY78WhM6v7tf9z6ymkjg8CJkRYbZDqx5yIk35GfV3AlBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGIvI9AR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660E4C4CEF0;
	Mon,  1 Sep 2025 15:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756740045;
	bh=mel0sP1S1UZU3Xkn/7UnF8o+gUk0oxpwGtXR4J6IJ+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CGIvI9ARWQzSHMZs2628PIHsARqcZ9TczW4GcSf5zDL6rEtTv0g4j6awo17XMxCj1
	 iT1xMU9XmJooZfUaxeCb+vOZYlqWVzvzIrEVIOoTc+ygUNxgKJ/B/hqxWsyK9VLo8h
	 fyeslylBNNzUag6aXyfLRwQriWt2lMJ6bzbTGEGLI9uPIVrT4cdVhtOrK65HDGo3fs
	 E7TIEeshmA1iShgtkpHVJbGS9SrDzVpx/zn/0OzsvWor5814LHYUjRisOljUK2M6rh
	 Hf4QL0bP5G3b0RDnOLXnU9aims+hwKKYSrUHap4pwocxBTDY1U3VlVHbrNGyiKGl1P
	 SvDVUWDensJ3w==
Date: Mon, 1 Sep 2025 10:20:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Print TLP Log for errors introduced since PCIe
 r1.1
Message-ID: <20250901152044.GA1114640@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f707caf1260bd8f15012bb032f7da9a9b898aba.1756712066.git.lukas@wunner.de>

On Mon, Sep 01, 2025 at 09:44:52AM +0200, Lukas Wunner wrote:
> When reporting an error, the AER driver prints the TLP Header / Prefix Log
> only for errors enumerated in the AER_LOG_TLP_MASKS macro.
> 
> The macro was never amended since its introduction in 2006 with commit
> 6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriver").
> At the time, PCIe r1.1 was the latest spec revision.
> 
> Amend the macro with errors defined since then to avoid omitting the TLP
> Header / Prefix Log for newer errors.
> 
> The order of the errors in AER_LOG_TLP_MASKS follows PCIe r1.1 sec 6.2.7
> rather than 7.10.2, because only the former documents for which errors a
> TLP Header / Prefix is logged.  Retain this order.  The section number is
> still 6.2.7 in today's PCIe r7.0.
> 
> For Completion Timeouts, the TLP Header / Prefix is only logged if the
> Completion Timeout Prefix / Header Log Capable bit is set in the AER
> Capabilities and Control register.  Introduce a tlp_header_logged() helper
> to check whether the TLP Header / Prefix Log is populated and use it in
> the two places which currently match against AER_LOG_TLP_MASKS directly.
> 
> For Uncorrectable Internal Errors, logging of the TLP Header / Prefix is
> optional per PCIe r7.0 sec 6.2.7.  If needed, drivers could indicate
> through a flag whether devices are capable and tlp_header_logged() could
> then check that flag.
> 
> pcitools introduced macros for newer errors with commit 144b0911cc0b
> ("ls-ecaps: extend decode support for more fields for AER CE and UE
> status"):
>   https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/commit/?id=144b0911cc0b
> 
> Unfortunately some of those macros are overly long:
>   PCI_ERR_UNC_POISONED_TLP_EGRESS
>   PCI_ERR_UNC_DMWR_REQ_EGRESS_BLOCKED
>   PCI_ERR_UNC_IDE_CHECK
>   PCI_ERR_UNC_MISR_IDE_TLP
>   PCI_ERR_UNC_PCRC_CHECK
>   PCI_ERR_UNC_TLP_XLAT_EGRESS_BLOCKED
> 
> This seems unsuitable for <linux/pci_regs.h>, so shorten to:
>   PCI_ERR_UNC_POISON_BLK
>   PCI_ERR_UNC_DMWR_BLK
>   PCI_ERR_UNC_IDE_CHECK
>   PCI_ERR_UNC_MISR_IDE
>   PCI_ERR_UNC_PCRC_CHECK
>   PCI_ERR_UNC_XLAT_BLK
> 
> Note that some of the existing macros in <linux/pci_regs.h> do not match
> exactly with pcitools (e.g. PCI_ERR_UNC_SDES versus PCI_ERR_UNC_SURPDN),
> so it does not seem mandatory for them to be identical.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/aer for v6.18, thanks, Lukas!

> ---
>  drivers/pci/pcie/aer.c        | 30 +++++++++++++++++++++++++++---
>  include/uapi/linux/pci_regs.h |  8 ++++++++
>  2 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 15ed541..62c74b5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -96,11 +96,21 @@ struct aer_info {
>  };
>  
>  #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
> +					PCI_ERR_UNC_POISON_BLK |	\
>  					PCI_ERR_UNC_ECRC|		\
>  					PCI_ERR_UNC_UNSUP|		\
>  					PCI_ERR_UNC_COMP_ABORT|		\
>  					PCI_ERR_UNC_UNX_COMP|		\
> -					PCI_ERR_UNC_MALF_TLP)
> +					PCI_ERR_UNC_ACSV |		\
> +					PCI_ERR_UNC_MCBTLP |		\
> +					PCI_ERR_UNC_ATOMEG |		\
> +					PCI_ERR_UNC_DMWR_BLK |		\
> +					PCI_ERR_UNC_XLAT_BLK |		\
> +					PCI_ERR_UNC_TLPPRE |		\
> +					PCI_ERR_UNC_MALF_TLP |		\
> +					PCI_ERR_UNC_IDE_CHECK |		\
> +					PCI_ERR_UNC_MISR_IDE |		\
> +					PCI_ERR_UNC_PCRC_CHECK)
>  
>  #define SYSTEM_ERROR_INTR_ON_MESG_MASK	(PCI_EXP_RTCTL_SECEE|	\
>  					PCI_EXP_RTCTL_SENFEE|	\
> @@ -796,6 +806,20 @@ static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
>  	}
>  }
>  
> +static bool tlp_header_logged(u32 status, u32 capctl)
> +{
> +	/* Errors for which a header is always logged (PCIe r7.0 sec 6.2.7) */
> +	if (status & AER_LOG_TLP_MASKS)
> +		return true;
> +
> +	/* Completion Timeout header is only logged on capable devices */
> +	if (status & PCI_ERR_UNC_COMP_TIME &&
> +	    capctl & PCI_ERR_CAP_COMP_TIME_LOG)
> +		return true;
> +
> +	return false;
> +}
> +
>  static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	const char **strings;
> @@ -910,7 +934,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		status = aer->uncor_status;
>  		mask = aer->uncor_mask;
>  		info.level = KERN_ERR;
> -		tlp_header_valid = status & AER_LOG_TLP_MASKS;
> +		tlp_header_valid = tlp_header_logged(status, aer->cap_control);
>  	}
>  
>  	info.status = status;
> @@ -1401,7 +1425,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
>  		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &aercc);
>  		info->first_error = PCI_ERR_CAP_FEP(aercc);
>  
> -		if (info->status & AER_LOG_TLP_MASKS) {
> +		if (tlp_header_logged(info->status, aercc)) {
>  			info->tlp_header_valid = 1;
>  			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG,
>  					  aer + PCI_ERR_PREFIX_LOG,
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f5b1774..d2e1bbb 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -776,6 +776,13 @@
>  #define  PCI_ERR_UNC_MCBTLP	0x00800000	/* MC blocked TLP */
>  #define  PCI_ERR_UNC_ATOMEG	0x01000000	/* Atomic egress blocked */
>  #define  PCI_ERR_UNC_TLPPRE	0x02000000	/* TLP prefix blocked */
> +#define  PCI_ERR_UNC_POISON_BLK	0x04000000	/* Poisoned TLP Egress Blocked */
> +#define  PCI_ERR_UNC_DMWR_BLK	0x08000000	/* DMWr Request Egress Blocked */
> +#define  PCI_ERR_UNC_IDE_CHECK	0x10000000	/* IDE Check Failed */
> +#define  PCI_ERR_UNC_MISR_IDE	0x20000000	/* Misrouted IDE TLP */
> +#define  PCI_ERR_UNC_PCRC_CHECK	0x40000000	/* PCRC Check Failed */
> +#define  PCI_ERR_UNC_XLAT_BLK	0x80000000	/* TLP Translation Egress Blocked */
> +
>  #define PCI_ERR_UNCOR_MASK	0x08	/* Uncorrectable Error Mask */
>  	/* Same bits as above */
>  #define PCI_ERR_UNCOR_SEVER	0x0c	/* Uncorrectable Error Severity */
> @@ -798,6 +805,7 @@
>  #define  PCI_ERR_CAP_ECRC_CHKC		0x00000080 /* ECRC Check Capable */
>  #define  PCI_ERR_CAP_ECRC_CHKE		0x00000100 /* ECRC Check Enable */
>  #define  PCI_ERR_CAP_PREFIX_LOG_PRESENT	0x00000800 /* TLP Prefix Log Present */
> +#define  PCI_ERR_CAP_COMP_TIME_LOG	0x00001000 /* Completion Timeout Prefix/Header Log Capable */
>  #define  PCI_ERR_CAP_TLP_LOG_FLIT	0x00040000 /* TLP was logged in Flit Mode */
>  #define  PCI_ERR_CAP_TLP_LOG_SIZE	0x00f80000 /* Logged TLP Size (only in Flit mode) */
>  #define PCI_ERR_HEADER_LOG	0x1c	/* Header Log Register (16 bytes) */
> -- 
> 2.50.1
> 


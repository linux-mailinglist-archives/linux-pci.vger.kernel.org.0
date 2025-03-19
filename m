Return-Path: <linux-pci+bounces-24186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C94A69BF3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 23:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87191892661
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 22:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04722144C8;
	Wed, 19 Mar 2025 22:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbR9KpmN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55551BD9C7
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 22:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422882; cv=none; b=k5vqAcr145AZZaxKYz66w4ZsgHHbkMz5gpMwUaU9o1vCyt0+EX8KSh07QRl1j4aGP1Azs0JJzq5FZ0TOH+mE9kozs93ZdkOuzv6gPtTw+FpH26LNbGiylOqVPhze247gXix9deU3nGp/p7fBhnASycUunTTJRF+T+sZWbLbOjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422882; c=relaxed/simple;
	bh=aHwaF2XqOo84yuDl4agNQt2TLSqtrIugjXKLgx3OoYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eLteBqyhaUdhacb4x45UrRoiX6AQ+FzOsC8KnniiOqTJvrG5jl8gRayEEaxYC85NF+HWAW0XrS3U8/4R62MkJyvs88Y+jL0Xmqa+vsYWIl8ks93s1xxQi9MhhUiJbV1SYbPNcgD+NEDV/noYezTxs2kxlwKx9vdxoYfHkmjPhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbR9KpmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E357C4CEE4;
	Wed, 19 Mar 2025 22:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742422882;
	bh=aHwaF2XqOo84yuDl4agNQt2TLSqtrIugjXKLgx3OoYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MbR9KpmNYIjE4m91Y+DsaIb2+bKU33FkGQSFgby/5Xm1sUqapjUGeWEwrjCj0IiyL
	 hc8ntsxv0qbTtiLkcufmkJg5anoq9RHppxqhuHdg3gWB1GTNBbdLxr51u/0LhUGBS9
	 k/15jZx5F+c7USdlk4pz2hXS5l3XRWGbm9RhIKoRyJ6wIMwbIpgftCKqddByUbN66b
	 GBWsdqlSRF/nuOWam7JNnRbXhSCVyYlivc/AtLmM5Sfv6gC6R88xJXJ6LBdT5kITGp
	 8h2jltJWMTFNUVKaq1z/GXAH0V7k6nB5d2pEwX4mirrK18X5lW2wqlkpA32TSmoltv
	 U9NWXQYNXAvsw==
Date: Wed, 19 Mar 2025 17:21:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Pan-Doh <pandoh@google.com>,
	Terry Bowman <terry.bowman@amd.com>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Liu Xinpeng <liuxp11@chinatelecom.cn>,
	Darren Hart <darren@os.amperecomputing.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] PCI/AER: Consolidate CXL and native AER reporting paths
Message-ID: <20250319222120.GA1064967@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bcb8c9a7b38ce3bdaca5a64fe76f08b0b337511.1742202797.git.karolina.stolarek@oracle.com>

[+cc ACPI APEI reviewers and more CXL folks]

On Mon, Mar 17, 2025 at 10:14:46AM +0000, Karolina Stolarek wrote:
> Make CXL devices use aer_print_error() when reporting AER errors.
> Add a helper function to populate aer_err_info struct before logging
> an error. Move struct aer_err_info definition to the aer.h header
> to make it visible to CXL.

Previously, pci_print_aer() was used by both CXL (via
cxl_handle_rdport_errors()) and by ACPI GHES via aer_recover_queue()
and aer_recover_work_func(), right?

And after this patch, they would use aer_print_error() like native 
AER, native DPC, and the ACPI EDR DPC path?

If it changes the GHES path, I think we should mention that in the
subject and commit log as well.

I think this consolidation is a good thing, because I don't think we
should log errors differently just because we learned about them via a
different path.  

But I think this also changes the text we put in dmesg, which is
potentially disruptive to users and scripts that consume it, so I
think we should include a comparison of the previous and new text in
the commit log.

Eventually would like an ack from the CXL and GHES folks before
merging, but I have a couple more questions below.

> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> ---
> The patch was tested on the top of Terry Bowman's series[1], with
> a setup as outlined in the cover letter, and rebased on the top
> of pci-next, with no functional changes.
> 
> [1] -
> https://lore.kernel.org/linux-pci/20250211192444.2292833-1-terry.bowman@amd.com
> 
>  drivers/cxl/core/pci.c |  5 +++-
>  drivers/pci/pci.h      | 23 ----------------
>  drivers/pci/pcie/aer.c | 60 ++++++++++++++++++------------------------
>  include/linux/aer.h    | 25 ++++++++++++++++--
>  4 files changed, 52 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 013b869b66cb..217f13c30bde 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -871,6 +871,7 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	struct aer_capability_regs aer_regs;
> +	struct aer_err_info info;
>  	struct cxl_dport *dport;
>  	int severity;
>  
> @@ -885,7 +886,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>  		return;
>  
> -	pci_print_aer(pdev, severity, &aer_regs);
> +	memset(&info, 0, sizeof(info));
> +	populate_aer_err_info(&info, severity, &aer_regs);

Maybe the memset() should go inside populate_aer_err_info() to avoid
potential error in the callers?  I'm guessing we don't envision a case
where "info" already contains data that needs to be preserved?

Both GHES and CXL start with struct aer_capability_regs from
include/linux/aer.h, so instead of also exposing struct aer_err_info
to the world, maybe we should have a logging interface like
aer_recover_queue() that takes a struct aer_capability_regs pointer
that CXL could use?  Or maybe it could use aer_recover_queue()
directly?

> +	aer_print_error(pdev, &info);
>  
>  	if (severity == AER_CORRECTABLE)
>  		cxl_handle_rdport_cor_ras(cxlds, dport);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9e0378fa30ac..b799c2ff7b85 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -561,30 +561,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
>  #ifdef CONFIG_PCIEAER
>  #include <linux/aer.h>
>  
> -#define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
> -
> -struct aer_err_info {
> -	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
> -	int error_dev_num;
> -
> -	unsigned int id:16;
> -
> -	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
> -	unsigned int __pad1:5;
> -	unsigned int multi_error_valid:1;
> -
> -	unsigned int first_error:5;
> -	unsigned int __pad2:2;
> -	unsigned int tlp_header_valid:1;
> -
> -	unsigned int status;		/* COR/UNCOR Error Status */
> -	unsigned int mask;		/* COR/UNCOR Error Mask */
> -	struct pcie_tlp_log tlp;	/* TLP Header */
> -};
> -
>  int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
> -void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
> -
>  int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>  		      unsigned int tlp_len, bool flit,
>  		      struct pcie_tlp_log *log);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a1cf8c7ef628..411450ff981e 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -760,47 +760,33 @@ int cper_severity_to_aer(int cper_severity)
>  EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>  #endif
>  
> -void pci_print_aer(struct pci_dev *dev, int aer_severity,
> -		   struct aer_capability_regs *aer)
> +void populate_aer_err_info(struct aer_err_info *info, int aer_severity,
> +			   struct aer_capability_regs *regs)
>  {
> -	int layer, agent, tlp_header_valid = 0;
> -	u32 status, mask;
> -	struct aer_err_info info;
> +	int tlp_header_valid;
> +
> +	info->severity = aer_severity;
> +	info->first_error = PCI_ERR_CAP_FEP(regs->cap_control);
>  
>  	if (aer_severity == AER_CORRECTABLE) {
> -		status = aer->cor_status;
> -		mask = aer->cor_mask;
> +		info->id = regs->cor_err_source;
> +		info->status = regs->cor_status;
> +		info->mask = regs->cor_mask;
>  	} else {
> -		status = aer->uncor_status;
> -		mask = aer->uncor_mask;
> -		tlp_header_valid = status & AER_LOG_TLP_MASKS;
> +		info->id = regs->uncor_err_source;
> +		info->status = regs->uncor_status;
> +		info->mask = regs->uncor_mask;
> +		tlp_header_valid = info->status & AER_LOG_TLP_MASKS;
> +
> +		if (tlp_header_valid) {
> +			info->tlp_header_valid = tlp_header_valid;
> +			info->tlp = regs->header_log;
> +		}
>  	}
> +}
> +EXPORT_SYMBOL_NS_GPL(populate_aer_err_info, "CXL");
>  
> -	layer = AER_GET_LAYER_ERROR(aer_severity, status);
> -	agent = AER_GET_AGENT(aer_severity, status);
> -
> -	memset(&info, 0, sizeof(info));
> -	info.severity = aer_severity;
> -	info.status = status;
> -	info.mask = mask;
> -	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
> -
> -	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> -	__aer_print_error(dev, &info);
> -	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
> -		aer_error_layer[layer], aer_agent_string[agent]);
> -
> -	if (aer_severity != AER_CORRECTABLE)
> -		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
> -			aer->uncor_severity);
> -
> -	if (tlp_header_valid)
> -		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
>  
> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> -			aer_severity, tlp_header_valid, &aer->header_log);
> -}
> -EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>  
>  /**
>   * add_error_device - list device to be handled
> @@ -1136,6 +1122,7 @@ static void aer_recover_work_func(struct work_struct *work)
>  {
>  	struct aer_recover_entry entry;
>  	struct pci_dev *pdev;
> +	struct aer_err_info info;
>  
>  	while (kfifo_get(&aer_recover_ring, &entry)) {
>  		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
> @@ -1146,7 +1133,10 @@ static void aer_recover_work_func(struct work_struct *work)
>  			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
>  			continue;
>  		}
> -		pci_print_aer(pdev, entry.severity, entry.regs);
> +
> +		memset(&info, 0, sizeof(info));
> +		populate_aer_err_info(&info, entry.severity, entry.regs);
> +		aer_print_error(pdev, &info);
>  
>  		/*
>  		 * Memory for aer_capability_regs(entry.regs) is being
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 02940be66324..ab408ec18e85 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -53,6 +53,26 @@ struct aer_capability_regs {
>  	u16 uncor_err_source;
>  };
>  
> +#define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
> +struct aer_err_info {
> +	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
> +	int error_dev_num;
> +
> +	unsigned int id:16;
> +
> +	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
> +	unsigned int __pad1:5;
> +	unsigned int multi_error_valid:1;
> +
> +	unsigned int first_error:5;
> +	unsigned int __pad2:2;
> +	unsigned int tlp_header_valid:1;
> +
> +	unsigned int status;		/* COR/UNCOR Error Status */
> +	unsigned int mask;		/* COR/UNCOR Error Mask */
> +	struct pcie_tlp_log tlp;	/* TLP Header */
> +};
> +
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> @@ -64,8 +84,9 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  #endif
>  
> -void pci_print_aer(struct pci_dev *dev, int aer_severity,
> -		    struct aer_capability_regs *aer);
> +void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
> +void populate_aer_err_info(struct aer_err_info *info, int aer_severity,
> +			   struct aer_capability_regs *regs);
>  int cper_severity_to_aer(int cper_severity);
>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  		       int severity, struct aer_capability_regs *aer_regs);
> -- 
> 2.43.5
> 


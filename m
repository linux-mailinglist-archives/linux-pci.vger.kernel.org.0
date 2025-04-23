Return-Path: <linux-pci+bounces-26613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FC7A9997E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 22:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295611B83EC4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB38268C73;
	Wed, 23 Apr 2025 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwQdKPre"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2139F2673A5;
	Wed, 23 Apr 2025 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745440305; cv=none; b=N75eSt+5NoInpGf9NX415/uJEaqpC6Nm6gH2bhn8cXLNBHe1RBCfRw+ySG5CvY9LcSpkhmwzsASmtkNmuJKShlfbsuwhczL7IUt/+VbcWi9MjeGQSX//DNO+d0Kpcs1zMgSoWxDSN3cUgOC5o00lQQuJd+tdM8A6lZYLW1ZDidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745440305; c=relaxed/simple;
	bh=sdH9DfsumybijEPv6nEjkMCI0xiJIyMrHI8wkvWKjIE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Et9fZXymyCIx9KVHiB+4PARKdEcQMkbYce9X+WH/QGG029kH8g7lEupinH+nNbdheb6Kyyk8Bcn2eS4/nR5LU7IWxPL0AJ6Q21Lc8e8XOiIZjdQSJnvwyAvbG5pktrzfGfDYsI/1p9zreTysBLJOoWv/i0hcmvuBhaGinCMrGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwQdKPre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE9CC4CEE2;
	Wed, 23 Apr 2025 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745440304;
	bh=sdH9DfsumybijEPv6nEjkMCI0xiJIyMrHI8wkvWKjIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dwQdKPreceeLuEcZ/eiHS5XfDm3IL1B1L8ok4n9wtPTne5mTEVG/Y2tFtHw4pCWYa
	 kI6NlrAlD42cR49N9wtVGL1KhtLFSaNDJgXxMPxKciW++V7XVo5kz86nqAVJO9jhGD
	 KzNl+XqqoWshlRj7+pczP8m7LMbCyKIfsYiVXiXd1ueCsbvKiYz+XLozVXnUbVSkpQ
	 uypjekvs5aml0SAgI4ZwMrwLaRhz+Cw4LTvy+CL6qKmkemqOGE5tBDrvNybT24qRkZ
	 r67ucZy9S2krnelvXFlKtRVQlPWkEjmb/U6EBSJ0a5xmIL/2mmY1Uo2ke4M7lhK3tW
	 jR5rmeeRoP8jA==
Date: Wed, 23 Apr 2025 15:31:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jon Pan-Doh <pandoh@google.com>,
	Terry Bowman <terry.bowman@amd.com>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Liu Xinpeng <liuxp11@chinatelecom.cn>,
	Darren Hart <darren@os.amperecomputing.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: Consolidate CXL, ACPI GHES and native AER
 reporting paths
Message-ID: <20250423203143.GA442813@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c51f0f8b-99c2-49df-9112-650b3c5382f4@oracle.com>

On Wed, Apr 23, 2025 at 03:52:27PM +0200, Karolina Stolarek wrote:
> On 25/03/2025 16:07, Karolina Stolarek wrote:
> > Currently, CXL and GHES feature use pci_print_aer() function to
> > log AER errors. Its implementation is pretty similar to aer_print_error(),
> > duplicating the way how native PCIe devices report errors. We shouldn't
> > log messages differently only because they are coming from a different
> > code path.
> > 
> > Make CXL devices and GHES to call aer_print_error() when reporting
> > AER errors. Add a wrapper, aer_print_platform_error(), that translates
> > aer_capabilities_regs to aer_err_info so we can use pci_print_aer()
> > function.
> > 
> > Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> > ---
> > v2:
> >    - Don't expose aer_err_info to the world; as aer_recover_queue()
> >      is tightly connected to the ghes code, introduce a wrapper for
> >      aer_print_error()
> >    - Move aer_err_info memset to the wrapper, don't expect the
> >      caller to clean it for us
> > 
> >    I'm still working on the logs; in the meantime, I think, we can
> >    continue reviewing the patch.
> 
> I wasn't able to produce logs for the CXL path (that is, Restricted CXL
> Device, as CXL1.1 devices not supported by the driver due to a missing
> functionality; confirmed by Terry) and faced issues when trying to inject
> errors via GHES. Is the lack of logs a blocker for this patch? I tested
> other CXL scenarios and my changes didn't cause regression, as far as I
> know.

Yes, I do think we need to say something about the output format
changes.

I assume you're trying GHES on machines that actually do
firmware-first error handling, right?  I found several GHES logs by
searching the web for "APEI Generic Hardware Error Source" "PCIe
error".  The majority were Dell boxes.

If you can't produce actual logs for comparison, I think we can take
info from a sample log somebody has posted and synthesize what the
changes would be after this patch.

> >   drivers/cxl/core/pci.c |  2 +-
> >   drivers/pci/pcie/aer.c | 64 ++++++++++++++++++++----------------------
> >   include/linux/aer.h    |  4 +--
> >   3 files changed, 33 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 013b869b66cb..9ba711365388 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -885,7 +885,7 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> >   	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
> >   		return;
> > -	pci_print_aer(pdev, severity, &aer_regs);
> > +	aer_print_platform_error(pdev, severity, &aer_regs);
> >   	if (severity == AER_CORRECTABLE)
> >   		cxl_handle_rdport_cor_ras(cxlds, dport);
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index a1cf8c7ef628..ec34bc9b2332 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -760,47 +760,42 @@ int cper_severity_to_aer(int cper_severity)
> >   EXPORT_SYMBOL_GPL(cper_severity_to_aer);
> >   #endif
> > -void pci_print_aer(struct pci_dev *dev, int aer_severity,
> > -		   struct aer_capability_regs *aer)
> > +static void populate_aer_err_info(struct aer_err_info *info, int severity,
> > +				  struct aer_capability_regs *aer_regs)
> >   {
> > -	int layer, agent, tlp_header_valid = 0;
> > -	u32 status, mask;
> > -	struct aer_err_info info;
> > -
> > -	if (aer_severity == AER_CORRECTABLE) {
> > -		status = aer->cor_status;
> > -		mask = aer->cor_mask;
> > -	} else {
> > -		status = aer->uncor_status;
> > -		mask = aer->uncor_mask;
> > -		tlp_header_valid = status & AER_LOG_TLP_MASKS;
> > -	}
> > -
> > -	layer = AER_GET_LAYER_ERROR(aer_severity, status);
> > -	agent = AER_GET_AGENT(aer_severity, status);
> > +	int tlp_header_valid;
> >   	memset(&info, 0, sizeof(info));
> > -	info.severity = aer_severity;
> > -	info.status = status;
> > -	info.mask = mask;
> > -	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
> > -	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> > -	__aer_print_error(dev, &info);
> > -	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
> > -		aer_error_layer[layer], aer_agent_string[agent]);
> > +	info->severity = severity;
> > +	info->first_error = PCI_ERR_CAP_FEP(aer_regs->cap_control);
> > -	if (aer_severity != AER_CORRECTABLE)
> > -		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
> > -			aer->uncor_severity);
> > +	if (severity == AER_CORRECTABLE) {
> > +		info->id = aer_regs->cor_err_source;
> > +		info->status = aer_regs->cor_status;
> > +		info->mask = aer_regs->cor_mask;
> > +	} else {
> > +		info->id = aer_regs->uncor_err_source;
> > +		info->status = aer_regs->uncor_status;
> > +		info->mask = aer_regs->uncor_mask;
> > +		tlp_header_valid = info->status & AER_LOG_TLP_MASKS;
> > +
> > +		if (tlp_header_valid) {
> > +			info->tlp_header_valid = tlp_header_valid;
> > +			info->tlp = aer_regs->header_log;
> > +		}
> > +	}
> > +}
> > -	if (tlp_header_valid)
> > -		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
> > +void aer_print_platform_error(struct pci_dev *pdev, int severity,
> > +			      struct aer_capability_regs *aer_regs)
> > +{
> > +	struct aer_err_info info;
> > -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> > -			aer_severity, tlp_header_valid, &aer->header_log);
> > +	populate_aer_err_info(&info, severity, aer_regs);
> > +	aer_print_error(pdev, &info);
> >   }
> > -EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
> > +EXPORT_SYMBOL_NS_GPL(aer_print_platform_error, "CXL");
> >   /**
> >    * add_error_device - list device to be handled
> > @@ -1146,7 +1141,8 @@ static void aer_recover_work_func(struct work_struct *work)
> >   			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
> >   			continue;
> >   		}
> > -		pci_print_aer(pdev, entry.severity, entry.regs);
> > +
> > +		aer_print_platform_error(pdev, entry.severity, entry.regs);
> >   		/*
> >   		 * Memory for aer_capability_regs(entry.regs) is being
> > diff --git a/include/linux/aer.h b/include/linux/aer.h
> > index 02940be66324..5593352dfb51 100644
> > --- a/include/linux/aer.h
> > +++ b/include/linux/aer.h
> > @@ -64,8 +64,8 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
> >   static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> >   #endif
> > -void pci_print_aer(struct pci_dev *dev, int aer_severity,
> > -		    struct aer_capability_regs *aer);
> > +void aer_print_platform_error(struct pci_dev *pdev, int severity,
> > +			      struct aer_capability_regs *aer_regs);
> >   int cper_severity_to_aer(int cper_severity);
> >   void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
> >   		       int severity, struct aer_capability_regs *aer_regs);
> 


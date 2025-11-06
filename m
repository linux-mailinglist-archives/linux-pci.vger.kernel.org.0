Return-Path: <linux-pci+bounces-40462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B5BC39729
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 08:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902B11A40913
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 07:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A095F295516;
	Thu,  6 Nov 2025 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5MizLFS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DA921D00A
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415361; cv=none; b=dZd3ylpqWQtyBkuoV4MSOycslXDy1vEaq4ff0TdS6dUkFOluPXPPzLxvQZJMWpZ1khos5ddeEyyY3Y41o6+9DQhNbt5/wVhbMBpWo2oApz8bvOngk9szpDgi0BJUOyrR5Jpa4Ogr4cACzdYp7RSOk6gtGREJ5P9aT5NJFM88ZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415361; c=relaxed/simple;
	bh=7fr0FGmy2TGAjLSMYF4Kc3wKuxrdsBuMItL2A+ZjXAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYIXD9yWOr9tjQ5fUH6EJl0ufyHyfohD5uPTAw8xitGF4Mowk1fKIa1kXDki0YqUmnJrlZZv58SHbZPUp2zI0ZWKCwO8wbKY10wQQKGe8A9bTlJH6Z/dC17XQYiHE9JUQJoJNYgLDfB4xUNHFnP9A0wHF6mi0cofg/HvQ/io7So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5MizLFS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762415359; x=1793951359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7fr0FGmy2TGAjLSMYF4Kc3wKuxrdsBuMItL2A+ZjXAc=;
  b=R5MizLFS1Hd0Z4iwKgt5XEKetG5YTP6YQtgbiRqtw9cIjkuL+mb3m4lQ
   r5O/8rnFeS9gmOFgYqHTXVzTBghU+/Q0jYv3FwgbsF1yY44GwelRlWtMs
   P8TsPhs1LzmdLnfd6YFg4cG+KP9buBUY186IllWBhKlY2lwxcRQWQ/NJD
   X3JinraaG8B4tVsHmzzsxkdp/FZslZMBef7S7Cjg8SK/R1xgXr7uBvyfS
   r8gAvj+Y1ycQEuExpMkpMLEFVwql02PqqhV1JNFkr6tzxm+kjHNazJVEt
   nRNEswewtwjFzHZSdsfG4G/we6DbAOSxovGBFt2UJMy6eEh0QLdT5PR04
   w==;
X-CSE-ConnectionGUID: ld3bm3xnQiC0HCStvUuOXw==
X-CSE-MsgGUID: hyW9QPj2SwCCUB1+zRr0DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="82175706"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="82175706"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 23:49:18 -0800
X-CSE-ConnectionGUID: tPp/aWGlSqCWbNFtUhVpmQ==
X-CSE-MsgGUID: 2k8FFwewTr+aqRxU4cRCLA==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 05 Nov 2025 23:49:17 -0800
Date: Thu, 6 Nov 2025 15:35:06 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, xin@zytor.com, chao.gao@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: Re: [RFC PATCH 22/27] coco/tdx-host: Implement SPDM session setup
Message-ID: <aQxPqjCUAMYwTvkI@yilunxu-OptiPlex-7050>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
 <20250919142237.418648-23-dan.j.williams@intel.com>
 <20251030113622.00001e2b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030113622.00001e2b@huawei.com>

> > +struct spdm_config_info_t {
> > +	u32 vmm_spdm_cap;
> > +#define SPDM_CAP_HBEAT          BIT(13)
> > +#define SPDM_CAP_KEY_UPD        BIT(14)
> > +	u8 spdm_session_policy;
> > +	u8 certificate_slot_mask;
> > +	u8 raw_bitstream_requested;
> > +	u8 reserved[];
> Given the only use in here that I can immediately spot is on the
> stack with nothing in reserved (so zero size) + you then memcpy that into
> another buffer, why bother having reserved in this declaration?

I'll delete the reserved.

> > +} __packed;
> > +
> >  static struct pci_tsm_ops tdx_link_ops;
> >  
> >  static struct pci_tsm *tdx_link_pf0_probe(struct tsm_dev *tsm_dev,
> >  					  struct pci_dev *pdev)
> >  {
> > +	const struct spdm_config_info_t spdm_config_info = {
> > +		/* use a default configuration, may require user input later */
> > +		.vmm_spdm_cap = SPDM_CAP_KEY_UPD,
> > +		.certificate_slot_mask = 0xff,
> > +	};
> >  	int rc;
> >  
> >  	struct tdx_link *tlink __free(kfree) =
> > @@ -176,6 +423,29 @@ static struct pci_tsm *tdx_link_pf0_probe(struct tsm_dev *tsm_dev,
> >  	if (rc)
> >  		return NULL;
> >  
> > +	tlink->func_id = tdisp_func_id(pdev);
> > +
> > +	struct page *in_msg_page __free(__free_page) =
> > +		alloc_page(GFP_KERNEL | __GFP_ZERO);
> > +	if (!in_msg_page)
> > +		return NULL;
> > +
> > +	struct page *out_msg_page __free(__free_page) =
> > +		alloc_page(GFP_KERNEL | __GFP_ZERO);
> > +	if (!out_msg_page)
> > +		return NULL;
> > +
> > +	struct page *spdm_conf __free(__free_page) =
> > +		alloc_page(GFP_KERNEL | __GFP_ZERO);
> > +	if (!spdm_conf)
> > +		return NULL;
> > +
> > +	memcpy(page_address(spdm_conf), &spdm_config_info, sizeof(spdm_config_info));
> > +
> > +	tlink->in_msg = no_free_ptr(in_msg_page);
> > +	tlink->out_msg = no_free_ptr(out_msg_page);
> > +	tlink->spdm_conf = no_free_ptr(spdm_conf);
> > +
> >  	return &no_free_ptr(tlink)->pci.base_tsm;
> >  }
> >  
> > @@ -183,6 +453,9 @@ static void tdx_link_pf0_remove(struct pci_tsm *tsm)
> >  {
> >  	struct tdx_link *tlink = to_tdx_link(tsm);
> >  
> > +	__free_page(tlink->in_msg);
> > +	__free_page(tlink->out_msg);
> > +	__free_page(tlink->spdm_conf);
> Trivial but I'd prefer to see these freed in reverse order of allocation
> of where they are set. Just makes reviewing a tiny bit easier as the code
> evolves.

Will do.

> 
> >  	pci_tsm_pf0_destructor(&tlink->pci);
> >  	kfree(tlink);
> >  }
> 


Return-Path: <linux-pci+bounces-41359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05406C625F4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 06:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 969244E3D63
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 05:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9ED265CA7;
	Mon, 17 Nov 2025 05:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkLj2TT4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2E5284886
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 05:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763356298; cv=none; b=QuxxLqQ/qAm6O1Y7IPMkFlK1SoMd+roDNeSrlj+Kid9VnybaIc76+YrrFFIxsdqHYwMrSDgQYkAs/MU5mSWRspa45aDxsotdIhe5BkU/C9qyj1V+pDbelWIJg6gUYPXGatPBLp2rjtfInTs0VyxSlIArqwnfmOHZhf0gvse4IIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763356298; c=relaxed/simple;
	bh=MGyyMgQNRMj89rmL2Aope18G1ElVNFRh1ZCxZUFgYHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ot3wON4UvCKG8QgYDqO6XmnqjU3YjUoSgnvCGExzsiLcY/R1VeIw0k7IoRNkbZ1ss2KUZdQWNIP/AJQDtGUcnOu1P2Eusmy4mK7BOPpeEqu+NYyHi7HLQoNBU8Ejxn3subePg/hG1PoDDfzBzHwFk1d641B+XmayJg618yvXzt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkLj2TT4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763356296; x=1794892296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MGyyMgQNRMj89rmL2Aope18G1ElVNFRh1ZCxZUFgYHI=;
  b=kkLj2TT4ZA6gYHYawf9yv+PicBKefANBSyp/ymn4ltctrU0YJ/qppZAU
   tt7rx3BNO6hVQ5/6trsuiCblX6phUYZow+5GvXAH52at4yqOVi8DgGVcS
   RaXgb/foDlA922GyXoPC61F3+WriGQTI9zxJaTrbgWPEkJ1IDvJOpQHf/
   igGLVYn2hWbJ8dTIwYvZkCKiOT9Xp1K2+cD5iF0VJEXK95tWaB8yTnLtb
   Dwz5et/PtS/VByrntcPJoEGtnHJi9Ug3ozGsuzbTSNKHquQD5iibPKBQj
   ihK+jqCMrO28isZe94cqCWyAGkHGxlqCwOZHXkQuEkKcJlyiJUGwf0nk+
   w==;
X-CSE-ConnectionGUID: 2Wb1ffIHQzC+GISgrogyzA==
X-CSE-MsgGUID: AFRrjsPzSGSz+a0MTnnZaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="65060278"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="65060278"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 21:11:36 -0800
X-CSE-ConnectionGUID: 5vAUe8wMSjiBhRceq0e0+g==
X-CSE-MsgGUID: GgHZzgH5Q2mkbGpnyCrAMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="194803453"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 16 Nov 2025 21:11:34 -0800
Date: Mon, 17 Nov 2025 12:56:52 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: dan.j.williams@intel.com
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	xin@zytor.com, chao.gao@intel.com
Subject: Re: [RFC PATCH 20/27] coco/tdx-host: Add connect()/disconnect()
 handlers prototype
Message-ID: <aRqrFKV/5hinDiYg@yilunxu-OptiPlex-7050>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
 <20250919142237.418648-21-dan.j.williams@intel.com>
 <20251030112055.00001fcb@huawei.com>
 <69093bf7d6ee_74f59100fe@dwillia2-mobl4.notmuch>
 <aQwvsbZy50ac+xid@yilunxu-OptiPlex-7050>
 <69128889c6c2d_1d911009f@dwillia2-mobl4.notmuch>
 <aRVHpdQ637ltYJku@yilunxu-OptiPlex-7050>
 <69178ebd69506_10154100a9@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69178ebd69506_10154100a9@dwillia2-mobl4.notmuch>

On Fri, Nov 14, 2025 at 12:19:09PM -0800, dan.j.williams@intel.com wrote:
> Xu Yilun wrote:
> [..]
> > IOW, I like this current piece of code cause it is in perfect balance.
> > I don't have to change the mindset much for code design. I get the benifit
> > of auto-cleanup, and the local cleanup handlers (tlink_spdm, tlink_ide)
> > are cheap but clearly tell me what will happen if any step fails.
> 
> I think in this case of conflicting minor preferences the tie goes to
> the submitter. While I personally think the discipline of clearly
> delineating objects and ownerships yields maintainability benefits, I
> also do not hate the model of "extend existing object with scope based
> setup".
> 
> So,
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> 
> > > > 	if (IS_ERR(tlink_spdm)) {
> > > > 		pci_err(pdev, "fail to setup spdm session\n");
> > > > 		return PTR_ERR(tlink_spdm);
> > > > 	}
> > > > 
> > > > 	struct tdx_link *tlink_ide __free(tdx_ide_stream_teardown) =
> > > > 		tdx_ide_stream_setup(tlink);
> > > > 	if (IS_ERR(tlink_ide)) {
> > > > 		pci_err(pdev, "fail to setup ide stream\n");
> > > > 		return PTR_ERR(tlink_ide);
> > > > 	}
> > > 
> > > No strict need for scope-based cleanup if this is the last resource
> > > acquisition,
> > 
> > So if we don't do auto-cleanup for the last one, do we still need a
> > structure for that? If not,
> > 
> >  struct tdx_link {
> > 	struct tdx_spdm *spdm;
> > 	
> > 	int ide_stream_field1;
> > 	int ide_stream_field2;
> > 	...
> >  }
> > 
> > seems so wierd.
> 
> Yeah, a little clunky.
> 
> > > but maybe there are other PCI/TSM core things to do that
> > > are not shown.
> > 
> > There is no following items for now but I think cleanup for the last one
> > is good. Otherwise we may face with the same problem as goto, that we
> > see unrelated changes (add cleanup for previous one) when we add a new
> > step.
> 
> Again, this is a case of I still disagree with shipping the dead code,

OK. Will delete the last scope-based cleanup

> but not enough to NAK your preference.


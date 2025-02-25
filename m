Return-Path: <linux-pci+bounces-22279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9733A43344
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 03:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D7C189B1CD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 02:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E69D823DE;
	Tue, 25 Feb 2025 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="co7s+qpN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86892BD1B
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 02:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740451616; cv=none; b=H4eyOSfC7Xi2P8OuLT1S0SiEke+XuCyNZRJXwVHHRxwN12jUWdQBBNdEO5/V6law5Cte7PNLV/220xlBGIrJqq82OW0oEOKkkI4B1BhiAxGwxTpyggcVTEBvBaw6wfv2boyILnJOv+xVK7tFDKnOR4m+wBm11m7R/dWDHqbge+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740451616; c=relaxed/simple;
	bh=K4CKz1HpeSnfMxIkZrJ+rGIzZxTZDZwy5GYE34lRw78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ej5qE0T/j+7kgGwuxeIifeGoX1tpWwomwbraUPAvCFLTSqhfKK4WG8CJ5cuza/8Q6F0B66gvqv1C3rBBWBsKZ80sK6G78wLiqa5zIjD5nULBmGAgOlEhyMWnvpg3TRrJ9wH8g0aITq2uoa6WfANckOCpE5ufFuBozFbxlv4fbD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=co7s+qpN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740451615; x=1771987615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K4CKz1HpeSnfMxIkZrJ+rGIzZxTZDZwy5GYE34lRw78=;
  b=co7s+qpNVbYoiMkvPcLoUi/kNJ0mSv26WlXGavWwxUyKj0aXeKTw2xWB
   p1KD2Jsj3x7EFRaZdmeTo7Rsh8ziXzDn1P5PGYasmmRjIL9L4WLYEeuQP
   TBHFKp/3XsmDlePlBJ6xAqjuSG0Bvk9VeQmuh5w1sV8v+2ZTR0wZJEFE1
   y5XtFh8D3tSaknjFNbP/qK3yStDvSU7YbOTObNFyPisz3ALOvizaGrgPW
   FFza74NuhdRHScewf42cxNoJCZAgm/9HLIrAKw3FVK5sGpdn8JERdHrlc
   Xdr/G6B2fhc5EPmSgmlrr9cXxNqwNMw1gZMCvseGGb4XBEXsLMZEhEyqy
   A==;
X-CSE-ConnectionGUID: 3q+BYj4bRmO3qPW2oblWIA==
X-CSE-MsgGUID: NMlc/IOKTWKVn8nHOUZxFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="45021492"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="45021492"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 18:46:54 -0800
X-CSE-ConnectionGUID: ibR/pwbQTGCOnvCzXcPr5g==
X-CSE-MsgGUID: r/3z5co4SCmSzW4cSAjWhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="139491021"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 24 Feb 2025 18:46:52 -0800
Date: Tue, 25 Feb 2025 10:45:05 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <Z70usZ0PTYL7/xb6@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
 <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
 <Z32H2Tzd1UHCQEt5@yilunxu-OptiPlex-7050>
 <67bcf19bd1c7a_1c530f29449@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67bcf19bd1c7a_1c530f29449@dwillia2-xfh.jf.intel.com.notmuch>

On Mon, Feb 24, 2025 at 02:24:27PM -0800, Dan Williams wrote:
> Xu Yilun wrote:
> [..]
> > > 
> > > Oh, when we do this, the root port gets the same devid_start/end as the
> > > device which is not correct, what should be there, the rootport bdfn? Need
> > 
> > "Indicates the lowest/highest value RID in the range
> > associated with this Stream ID at the IDE *Partner* Port"
> > 
> > My understanding is that device should fill the RP bdfn, and the RP
> > should fill the device bdfn for RID association registers. Same for Addr
> > association registers.
> 
> So you expect that the endpoint programs RPs and Peer-to-Peer RIDs in
> its association register? That makes sense, although I feel like once

Yes.

> Peer-to-Peer operation is considered the RID association loses
> effectiveness because it is difficult to capture a constrained range in
> that case.
> 
> We can start with that for RID as our best current understanding and
> circle back later if it causes problems. As for address association I am

That's OK.

> not sure Linux needs to worry about it in the first implementation. The

For Intel, yes on RP side. Intel TDX Module requires OS to input ONE
address association range on IDE stream create to setup RP.

Thanks,
Yilun

> mechanism is too coarse to keep up with IOMMU entries for the device. If
> it already needs to be overspecified might as well disable it.


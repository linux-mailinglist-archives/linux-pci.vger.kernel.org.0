Return-Path: <linux-pci+bounces-41045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FA5C55818
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 04:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA4AB34BEF2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 03:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB2267386;
	Thu, 13 Nov 2025 03:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MsMYvCQE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F99263F28
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763003151; cv=none; b=P4GrrGhhoCk6LYh8RiqueFpUCAS7YOkNFAhQS+2VzIQBp40lKYclmxKWZGpGykfZWH2U7V+Xpf2YK2g1stpLgsaJLZXgYViWDHgV0ApV1xO90T+pzukw+Y9RNzz3esjRMd7A5l9g5Fp8nVYf0m2QmnXT34FoaK0wJGXZMnQndIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763003151; c=relaxed/simple;
	bh=OPZiwCZiR/3E+pQMnVYSdp1L5WAWONyGq2M+EGz6XbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxxzSlPRbzjPspSTHVjPbSeTR+FISYf0JNeIazyDBtVYr05NKqncozQSSAn6C5qaRe+8QKcY+qGgH48VBf/SY/DEiRsRq6vDGxjyYneA38y78bfa9PJetfN8cT9cD1GGoST0F+tCyRBk8Rl6pDJ5+vSRtJzMXRSmjZsB/ya2qfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MsMYvCQE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763003149; x=1794539149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OPZiwCZiR/3E+pQMnVYSdp1L5WAWONyGq2M+EGz6XbQ=;
  b=MsMYvCQELa5jYGkRfxZBQyYTT9ehlDwX3EoBeA7Y+dTYmrQA6vTqyeI4
   Z+0KyMTOCAL/AXPFm8jL+LPNF3GwzymlW7WlQk7uPE6fcoxuuZm+J/sFM
   gJowygyLz7//QHV1d2E+RWg34IQS4C3uBDy1Ohepmbb51vCeUFlKvkIA7
   elJqjKwpHTcB8I9AVyRYGHvetyLr6UrV6fmrwOZvGFOusDO/ylQ2Acd1c
   Sounz+H+aC5HtyFPQrNGz0uhq989WwKUu7vy9QgWgufUR/2xHmrmQ9++K
   /MQTpiYQ/GP0AIf/oQ4PWyK+ZoTrrkoXe1UorF0fDxRs8pS7GbJNCf/U4
   A==;
X-CSE-ConnectionGUID: IMxvFRgtR+66T7rD8htK3A==
X-CSE-MsgGUID: 9qWdSQQ4RJ6PIzRmlhtO+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64785785"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="64785785"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 19:05:49 -0800
X-CSE-ConnectionGUID: KL+SABqfT521X9nnvRySsg==
X-CSE-MsgGUID: rvb/MIsjQBqqRt0iRAf32g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="194371065"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 12 Nov 2025 19:05:47 -0800
Date: Thu, 13 Nov 2025 10:51:17 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: dan.j.williams@intel.com
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	xin@zytor.com, chao.gao@intel.com
Subject: Re: [RFC PATCH 20/27] coco/tdx-host: Add connect()/disconnect()
 handlers prototype
Message-ID: <aRVHpdQ637ltYJku@yilunxu-OptiPlex-7050>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
 <20250919142237.418648-21-dan.j.williams@intel.com>
 <20251030112055.00001fcb@huawei.com>
 <69093bf7d6ee_74f59100fe@dwillia2-mobl4.notmuch>
 <aQwvsbZy50ac+xid@yilunxu-OptiPlex-7050>
 <69128889c6c2d_1d911009f@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69128889c6c2d_1d911009f@dwillia2-mobl4.notmuch>

On Mon, Nov 10, 2025 at 04:51:21PM -0800, dan.j.williams@intel.com wrote:
> Xu Yilun wrote:
> > On Mon, Nov 03, 2025 at 03:34:15PM -0800, dan.j.williams@intel.com wrote:
> > > Jonathan Cameron wrote:
> > > > On Fri, 19 Sep 2025 07:22:29 -0700
> > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > > 
> > > > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > > > 
> > > > > Add basic skeleton for connect()/disconnect() handlers. The major steps
> > > > > are SPDM setup first and then IDE selective stream setup.
> > > > > 
> > > > > No detailed TDX Connect implementation.
> > > > > 
> > > > > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > Feels like use of __free() in here is inappropriate to me.
> > > > 
> > > > > ---
> > > > >  drivers/virt/coco/tdx-host/tdx-host.c | 49 ++++++++++++++++++++++++++-
> > > > >  1 file changed, 48 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> > > > > index f5a869443b15..0d052a1acf62 100644
> > > > > --- a/drivers/virt/coco/tdx-host/tdx-host.c
> > > > > +++ b/drivers/virt/coco/tdx-host/tdx-host.c
> > > > > @@ -104,13 +104,60 @@ static int __maybe_unused tdx_spdm_msg_exchange(struct tdx_link *tlink,
> > > > >  	return ret;
> > > > 
> > > > > +
> > > > > +static void __tdx_link_disconnect(struct tdx_link *tlink)
> > > > > +{
> > > > > +	tdx_ide_stream_teardown(tlink);
> > > > > +	tdx_spdm_session_teardown(tlink);
> > > > > +}
> > > > > +
> > > > > +DEFINE_FREE(__tdx_link_disconnect, struct tdx_link *, if (_T) __tdx_link_disconnect(_T))
> > > > > +
> > > > >  static int tdx_link_connect(struct pci_dev *pdev)
> > > > >  {
> > > > > -	return -ENXIO;
> > > > > +	struct tdx_link *tlink = to_tdx_link(pdev->tsm);
> > > > > +	int ret;
> > > > > +
> > > > > +	struct tdx_link *__tlink __free(__tdx_link_disconnect) = tlink;
> > > > I'm not a fan on an ownership pass like this just for purposes of cleaning up.
> > > 
> > > Yeah this needs a rethink. The session and the stream are independent
> > > resources. It can be a composite object that encapsulates both
> > > resources, but not tlink directly.
> > > 
> > > ...chalk this up to RFC expediency.
> > > 
> > > > I'd be a bit happier if you could make it
> > > > 	struct tdx_link *tlink __free(__tdx_link_disconnect) = to_tdx_link(pdev->dsm);
> > > > 
> > > > but I still don't really like it.  I think I'd just not use __free and stick
> > > > to traditional cleanup in via a goto. 
> > > 
> > > I would not go that far, but certainly I can see that being preferable
> > > than reusing the existing base 'struct tdx_link *' as the cleanup
> > > variable.
> > 
> > The latest implementation internally is as follows. tlink_spdm &
> > tlink_ide represent independent resources though they point to the same
> > instance. I'm already comfortable about this code:
> > 
> > static int tdx_link_connect(struct pci_dev *pdev)
> > {
> > 	struct tdx_link *tlink = to_tdx_link(pdev->tsm);
> > 
> > 	struct tdx_link *tlink_spdm __free(tdx_spdm_session_teardown) =
> > 		tdx_spdm_session_setup(tlink);
> 
> The question I have is why does tdx_spdm_session_setup() return a
> 'struct tdx_link' instance and not a new 'struct tdx_spdm' object to
> represent the new resources that were acquired? 'struct tdx_link' is
> base infrastructure created by ->probe(). Perhaps 'struct tdx_spdm'
> could be:
> 
> struct tdx_spdm {
>        u64 spdm_id;
>        struct page *spdm_conf;
>        struct tdx_page_array *spdm_mt;
> }
> 
> ...and then tdx_link becomes:
> 
> struct tdx_link {
> 	...
> 	struct tdx_spdm spdm;
> };
> 
> ...and you can do:
> 
>        struct tdx_spdm *spdm __free(tdx_spdm_session_teardown) =
>                tdx_spdm_session_setup(tlink);
> 
> tlink->spdm = *no_free_ptr(spdm);
> 
> ...to assign it back to the preallocated space in @tlink, or make
> it dynamically allocated.
> 
> struct tdx_link {
> 	...
> 	struct tdx_spdm *spdm;
> };
> 
> tlink->spdm = no_free_ptr(spdm);

It works for sure. I have also thought about this solution, but dropped.
I don't wanna see the usage of auto-cleanup impose too much influences
to the code/structure design, even if it shows better modularity.

It is normal in kernel that a base structure contains several
sub-features and we just group them with blank lines. Some fields may be
used accoss 1-2 features and doesn't have a clear owner. If we ask for
strict structure/flow design for auto-cleanup, people may reluctant to
switch to auto-cleanup, thought is it over-engineering?

IOW, I like this current piece of code cause it is in perfect balance.
I don't have to change the mindset much for code design. I get the benifit
of auto-cleanup, and the local cleanup handlers (tlink_spdm, tlink_ide)
are cheap but clearly tell me what will happen if any step fails.

> 
> > 	if (IS_ERR(tlink_spdm)) {
> > 		pci_err(pdev, "fail to setup spdm session\n");
> > 		return PTR_ERR(tlink_spdm);
> > 	}
> > 
> > 	struct tdx_link *tlink_ide __free(tdx_ide_stream_teardown) =
> > 		tdx_ide_stream_setup(tlink);
> > 	if (IS_ERR(tlink_ide)) {
> > 		pci_err(pdev, "fail to setup ide stream\n");
> > 		return PTR_ERR(tlink_ide);
> > 	}
> 
> No strict need for scope-based cleanup if this is the last resource
> acquisition,

So if we don't do auto-cleanup for the last one, do we still need a
structure for that? If not,

 struct tdx_link {
	struct tdx_spdm *spdm;
	
	int ide_stream_field1;
	int ide_stream_field2;
	...
 }

seems so wierd.

> but maybe there are other PCI/TSM core things to do that
> are not shown.

There is no following items for now but I think cleanup for the last one
is good. Otherwise we may face with the same problem as goto, that we
see unrelated changes (add cleanup for previous one) when we add a new
step.

Thanks,
Yilun



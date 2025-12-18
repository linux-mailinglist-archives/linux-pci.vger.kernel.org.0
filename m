Return-Path: <linux-pci+bounces-43308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C64ACCC536
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 15:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62D863003D97
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 14:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80531156236;
	Thu, 18 Dec 2025 14:46:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B3A2D4801;
	Thu, 18 Dec 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766069177; cv=none; b=Lg6v0HwpqXSVOm9pbyz+GMW1jGfOeaug3FsZxnoSdVxoE+KMUWdIFYhqVDLXt4xIoEtKB74SfNwnQ/6LdZyREVr9AiqQnodBek5L1I63dZdmnwd8x9zIdYXCUB6zyA8keq8ZzWPqlFXKRcFMNuh9+OhE0WeaUlrLmnTllDgVdBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766069177; c=relaxed/simple;
	bh=cVzwCu8jRUMwqIVEyQDV1dazRNbIggMfwNrucUtTSAY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gt+1lxPfZitWrNUBZk0awCpnzrb4hvOH4TQWmHAmY7XB/J93f0sRlKvK+M7MLcfx/XRMqnGn3YLKQpbd5sTIfx2AQ+t6APP4+0+7tPISdi1nnJCJsn3LyLRB8EB9vf82ENgpMDptIzigdFkmoEpjH1B3ooADAsq/rr4XqYOZR9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXD432qCRzJ46Cj;
	Thu, 18 Dec 2025 22:45:39 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8013540565;
	Thu, 18 Dec 2025 22:46:10 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Dec
 2025 14:46:09 +0000
Date: Thu, 18 Dec 2025 14:46:08 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<alison.schofield@intel.com>, <terry.bowman@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-pci@vger.kernel.org>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 6/6] cxl/mem: Introduce cxl_memdev_attach for
 CXL-dependent operation
Message-ID: <20251218144608.0000238c@huawei.com>
In-Reply-To: <6942d9d46e09e_1cee10089@dwillia2-mobl4.notmuch>
References: <20251216005616.3090129-1-dan.j.williams@intel.com>
	<20251216005616.3090129-7-dan.j.williams@intel.com>
	<20251217155712.000012da@huawei.com>
	<6942d9d46e09e_1cee10089@dwillia2-mobl4.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 17 Dec 2025 08:27:00 -0800
dan.j.williams@intel.com wrote:

> Jonathan Cameron wrote:
> > On Mon, 15 Dec 2025 16:56:16 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > Unlike the cxl_pci class driver that opportunistically enables memory
> > > expansion with no other dependent functionality, CXL accelerator drivers
> > > have distinct PCIe-only and CXL-enhanced operation states. If CXL is
> > > available some additional coherent memory/cache operations can be enabled,
> > > otherwise traditional DMA+MMIO over PCIe/CXL.io is a fallback.
> > > 
> > > Allow for a driver to pass a routine to be called in cxl_mem_probe()
> > > context. This ability is inspired by and mirrors the semantics of
> > > faux_device_create(). It allows for the caller to run CXL-topology
> > > attach-dependent logic on behalf of the caller.  
> > 
> > This seems confusing.   
> 
> Is faux_device_create() confusing?

Just to be clear this question is all about the word 'caller' being repeated
in that sentence. Not about the code itself or anything else in the explanation
or flow. 

This comment that reads very oddly to me and I think means something very
different from what is going on here.

> 
> > The caller is running logic for the caller?  It can do that whenever
> > it likes!  One of those is presumably callee  
> 
> No, it cannot execute CXL topology attach dependendent functionality in
> the device's initial probe context synchronous with the device-attach
> event "whenever it likes".

I'm still lost. Why 'caller to run' ... 'on behalf of the caller.'  In this case
caller is in both cases the function calling cxl_memdev_alloc()?

Maybe something like

"This arranges for CXL-topology attach-dependent logic to be run later, on behalf of
the caller."

Though that kind of repeats what follows, so maybe just drop the sentence.

> 
> > > The probe callback runs after the port topology is successfully attached
> > > for the given memdev.
> > > 
> > > Additionally the presence of @cxlmd->attach indicates that the accelerator
> > > driver be detached when CXL operation ends. This conceptually makes a CXL
> > > link loss event mirror a PCIe link loss event which results in triggering
> > > the ->remove() callback of affected devices+drivers. A driver can re-attach
> > > to recover back to PCIe-only operation. Live recovery, i.e. without a  
> > > ->remove()/->probe() cycle, is left as a future consideration.    

> > > @@ -1081,6 +1093,18 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
> > >  {
> > >  	int rc;
> > >  
> > > +	/*  
> > 
> > The general approach is fine but is the function name appropriate for this
> > new stuff?  Naturally I'm not suggesting the bikeshed should be any particular
> > alternative color just maybe not the current blue.  
> 
> The _autoremove() verb appears multiple times in the subsystem, not sure
> why it is raising bikeshed concerns now. Please send a new proposal if
> "autoremove" is not jibing.

It felt like a stretch given the additional code that is not about registering
autoremove for later, but doing it now under some circumstances.  Ah well I don't
care that much what it's called.

Jonathan




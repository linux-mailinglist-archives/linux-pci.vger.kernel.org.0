Return-Path: <linux-pci+bounces-43357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 247F4CCF64B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 11:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE865301D632
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C435F309F0E;
	Fri, 19 Dec 2025 10:27:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2D3081BE;
	Fri, 19 Dec 2025 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140020; cv=none; b=dGFvId6qida3l2zVnACx0ScbEI1pV33EY4AMFMuCOaka7uwQwYpxhwwMTnxgByGL2XvRZlipNrrB3/c/VTaOYfZTrM8nKWEnQHN3E2A+tv/+XljIOgYQb1bN6pWHgwiURtfnxZQfdHpyp6M1v1MLET0oyTLedCOE8LkiOLyLH70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140020; c=relaxed/simple;
	bh=s7w3+0u8YJxJZ5Tv8/HVjgV6HKoHPOt+K52XivPpl24=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvfeW1henUFMLjXc1RDy2Js/leY2B82WA41dJBd1jo5KqyPlx4AOiO0tWJlSY/ywMoCrd3pb5OW8lSZW1AwS9++4goeeIgeOP+YV4+IzpXRNB9soYyF0BVlAiyaNOT+Bh4hfBkyHOHKbctODCQr/Jou6iKsxEvOMuS6+E55hlBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXkGT1YDGzHnHG5;
	Fri, 19 Dec 2025 18:26:25 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 298674056C;
	Fri, 19 Dec 2025 18:26:54 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 10:26:53 +0000
Date: Fri, 19 Dec 2025 10:26:51 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<alison.schofield@intel.com>, <terry.bowman@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-pci@vger.kernel.org>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 6/6] cxl/mem: Introduce cxl_memdev_attach for
 CXL-dependent operation
Message-ID: <20251219102651.00005da1@huawei.com>
In-Reply-To: <69445af227f36_1cee1009e@dwillia2-mobl4.notmuch>
References: <20251216005616.3090129-1-dan.j.williams@intel.com>
	<20251216005616.3090129-7-dan.j.williams@intel.com>
	<20251217155712.000012da@huawei.com>
	<6942d9d46e09e_1cee10089@dwillia2-mobl4.notmuch>
	<20251218144608.0000238c@huawei.com>
	<69445af227f36_1cee1009e@dwillia2-mobl4.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 18 Dec 2025 11:50:10 -0800
<dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Wed, 17 Dec 2025 08:27:00 -0800
> > dan.j.williams@intel.com wrote:
> >   
> > > Jonathan Cameron wrote:  
> > > > On Mon, 15 Dec 2025 16:56:16 -0800
> > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > >     
> > > > > Unlike the cxl_pci class driver that opportunistically enables memory
> > > > > expansion with no other dependent functionality, CXL accelerator drivers
> > > > > have distinct PCIe-only and CXL-enhanced operation states. If CXL is
> > > > > available some additional coherent memory/cache operations can be enabled,
> > > > > otherwise traditional DMA+MMIO over PCIe/CXL.io is a fallback.
> > > > > 
> > > > > Allow for a driver to pass a routine to be called in cxl_mem_probe()
> > > > > context. This ability is inspired by and mirrors the semantics of
> > > > > faux_device_create(). It allows for the caller to run CXL-topology
> > > > > attach-dependent logic on behalf of the caller.    
> > > > 
> > > > This seems confusing.     
> > > 
> > > Is faux_device_create() confusing?  
> > 
> > Just to be clear this question is all about the word 'caller' being repeated
> > in that sentence. Not about the code itself or anything else in the explanation
> > or flow.   
> 
> Oh, sorry, I took it as the design was confusing.

I should have been clearer!

> 
> > This comment that reads very oddly to me and I think means something very
> > different from what is going on here.
> >   
> > >   
> > > > The caller is running logic for the caller?  It can do that whenever
> > > > it likes!  One of those is presumably callee    
> > > 
> > > No, it cannot execute CXL topology attach dependendent functionality in
> > > the device's initial probe context synchronous with the device-attach
> > > event "whenever it likes".  
> > 
> > I'm still lost. Why 'caller to run' ... 'on behalf of the caller.'  In this case
> > caller is in both cases the function calling cxl_memdev_alloc()?
> > 
> > Maybe something like
> > 
> > "This arranges for CXL-topology attach-dependent logic to be run later, on behalf of
> > the caller."
> > 
> > Though that kind of repeats what follows, so maybe just drop the sentence.  
> 
> How about this reworked changelog?
> 
> ---
> 
> Unlike the cxl_pci class driver that opportunistically enables memory
> expansion with no other dependent functionality, CXL accelerator drivers
> have distinct PCIe-only and CXL-enhanced operation states. If CXL is
> available some additional coherent memory/cache operations can be enabled,
> otherwise traditional DMA+MMIO over PCIe/CXL.io is a fallback.
> 
> This constitutes a new mode of operation where the caller of
> devm_cxl_add_memdev() wants to make a "go/no-go" decision about running
> in CXL accelerated mode or falling back to PCIe-only operation. Part of
> that decision making process likely also includes additional
> CXL-acceleration-specific resource setup. Encapsulate both of those
> requirements into 'struct cxl_memdev_attach' that provides a ->probe()
> callback. The probe callback runs in cxl_mem_probe() context, after the
> port topology is successfully attached for the given memdev. It supports
> a contract where, upon successful return from devm_cxl_add_memdev(),
> everything needed for CXL accelerated operation has been enabled.
> 
> Additionally the presence of @cxlmd->attach indicates that the accelerator
> driver be detached when CXL operation ends. This conceptually makes a CXL
> link loss event mirror a PCIe link loss event which results in triggering
> the ->remove() callback of affected devices+drivers. A driver can re-attach
> to recover back to PCIe-only operation. Live recovery, i.e. without a
> ->remove()/->probe() cycle, is left as a future consideration.  
Nice.  Thanks for the rewrite.

> 
> ---
> 
> > > > > @@ -1081,6 +1093,18 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
> > > > >  {
> > > > >  	int rc;
> > > > >  
> > > > > +	/*    
> > > > 
> > > > The general approach is fine but is the function name appropriate for this
> > > > new stuff?  Naturally I'm not suggesting the bikeshed should be any particular
> > > > alternative color just maybe not the current blue.    
> > > 
> > > The _autoremove() verb appears multiple times in the subsystem, not sure
> > > why it is raising bikeshed concerns now. Please send a new proposal if
> > > "autoremove" is not jibing.  
> > 
> > It felt like a stretch given the additional code that is not about registering
> > autoremove for later, but doing it now under some circumstances.  Ah well I don't
> > care that much what it's called.  
> 
> It is the same semantic as devm_add_action_or_reset() in that if the
> "add_action" fails then the "reset" is triggered.
> 
> Yes, there is additional code that validates that the device to be
> registered for removal is attached to its driver. That organization
> supports having a single handoff from scoped-based cleanup to devm based
> cleanup.
> 
> If you can think of a better organization and name I am open to hearing
> options, but nothing better is immediately jumping out at me.
> 
Let's go with current naming.  I don't like the only options I can come up
with either.  If inspiration strikes we can always change it later.

Jonathan






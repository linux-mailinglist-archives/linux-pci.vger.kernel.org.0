Return-Path: <linux-pci+bounces-4874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EC887E3CF
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 07:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290061F21462
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97491CA89;
	Mon, 18 Mar 2024 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CvqwcEs3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XUSpkHQF"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5C20313
	for <linux-pci@vger.kernel.org>; Mon, 18 Mar 2024 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710744303; cv=none; b=VmQi6vJkxvrFhDMWrU70tH+2ObJ3SynvWGRjZ8ctNw0j5y8esp2dB74EJH9HBpwR7JXMWVykEV0sck/hioeg+a5XX5IZ0v+wll5n8F07XzDD7mncog2dtGWv/FCjf4AfNp1Lq6O1PjzoJbe3J6xp5roeK+ZDP+th2hNrOeTP35w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710744303; c=relaxed/simple;
	bh=JR4jUAUOr7WdVnumi0SyuWQnxtfUPAh61LkqxwojaSc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=gn0REHY+LBp6z9z0PEPkxDT7DOSLVCYPxe5nfGj2Z3RHsfKWialbxpbn+buvaArvVlqXHoxrB9VtPDvUNDcdbHFt8lCOlfr1coMdhJ9JHxOu7JeMwgZzWwwDnt4T0Vtkag3DOk0egtDWhb7CGXGTSn8USagMtb7lRXoEFNU0jEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CvqwcEs3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XUSpkHQF; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5EF8511400C8;
	Mon, 18 Mar 2024 02:45:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 18 Mar 2024 02:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710744300; x=1710830700; bh=LNIo9Nut2J
	mDP8ZQV3UML1WPYh5IHSy0jvolq6BWASE=; b=CvqwcEs3LL5Bm68uQHZ35/1Av4
	nArY/YWC+TjPJlPz/uNmeJQ9cElanYW/jGQQ8yBfYs8psSnbmutBVCjtIAkxfuEh
	i28F5K+gaE+xa+V3WxsHoi4nzRDRyfngaoTVpgIDFkbQ2679fJXYzcKW3udIV/Rh
	UHlJDJL/cCxPW0Qwt0QcOGUPzban41aWZtTrQwJuKITxpZ4vFUzmvW6aW+N+QKyG
	80jyAVD6fh1TvarFz2HzVd1UvPCCgvp+zOTZ01DsQjrO3zb9vubWbfUq8w3bckBJ
	DQryxdxjLd+T03U3/QlKZmbkgWKFvklO5A/R7sLzVvV0VFHMe159S8MmhTCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710744300; x=1710830700; bh=LNIo9Nut2JmDP8ZQV3UML1WPYh5I
	HSy0jvolq6BWASE=; b=XUSpkHQFd8S9zXl/rKjLYf03u6hYv39Pt50LPRyfQUH2
	XEH4QLTh4dhpoYSQidPUIYR6l5/7ZsrjrgMIRAHcnJVXf6JQCpaI14SLtqPmcAfA
	lKUUDY5dkfvsGFkDog1548PcBTuEk8O5hVZbg5bPzc9Mt+zu/xQ0hm4SFpcdCWdP
	95qeyPCw7PT0oJ8YdgSUNgKEdbZQkbbcm+TvstaBXQTfvhYEO0xbVLrR6QdvKRGa
	10Z5g9YJuqr+GmW7BAvNyMK5gIaS5uVlYDll/dz2LjJr/vQzL990FvZgtiEOye8s
	AqDgtafae1TsRpyB9tYGkFIpfRE8T8LouzrdWkkscA==
X-ME-Sender: <xms:6-L3ZQw_5ULCjhX1Fs_aDlj4LI-fZ3vP1uGw2TaPOIRy4eLV5_n4iQ>
    <xme:6-L3ZUS8RkHu1TKQNDykKXcZczpU9gRD5K8FeI-3B8cIpkQyy5To5i0fUG3Esi_V7
    fzvKQlTZ_JsM2-LwTs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeeigddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:6-L3ZSWZU9bsfvvCFX7gYDTjbTKK8ti0r6WjwPDrl-6ozwR7peDsPw>
    <xmx:6-L3ZejeLuYX8V3m0F-r2jKH_fpp0gCBRtmVYOD6Uk9pbvdKuPWN3w>
    <xmx:6-L3ZSAdXQiY4KqVe7y4oF5ArUmw214HtGAaRgn5fGN1Iz-g7bV3_A>
    <xmx:6-L3ZfLCNlK4KFi4n5cLkmsDDSfcoKWiPy3LBpr1YacpHwZGDJ748w>
    <xmx:7OL3ZauJ2e21vIKztmIcbBXa_rHXfiY1Qrvk9J4H7s-cX0ND7gabDQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A7855B6008D; Mon, 18 Mar 2024 02:44:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20798a83-b2e6-4ecd-8e83-e39514b685a8@app.fastmail.com>
In-Reply-To: <20240318043058.GB2748@thinkpad>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-10-cassel@kernel.org> <20240315064408.GI3375@thinkpad>
 <9173aa22-4c15-40ec-bf70-39d25eebe4c2@app.fastmail.com>
 <20240318043058.GB2748@thinkpad>
Date: Mon, 18 Mar 2024 07:44:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>
Cc: "Niklas Cassel" <cassel@kernel.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Shradha Todi" <shradha.t@samsung.com>,
 "Damien Le Moal" <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 9/9] PCI: endpoint: Set prefetch when allocating memory for
 64-bit BARs
Content-Type: text/plain

On Mon, Mar 18, 2024, at 05:30, Manivannan Sadhasivam wrote:
> On Fri, Mar 15, 2024 at 06:29:52PM +0100, Arnd Bergmann wrote:
>> On Fri, Mar 15, 2024, at 07:44, Manivannan Sadhasivam wrote:
>> > On Wed, Mar 13, 2024 at 11:58:01AM +0100, Niklas Cassel wrote:
>
> But I'm not sure I got the answer I was looking for. So let me rephrase my
> question a bit.
>
> For BAR memory, PCIe spec states that,
>
> 'A PCI Express Function requesting Memory Space through a BAR must set the BAR's
> Prefetchable bit unless the range contains locations with read side effects or
> locations in which the Function does not tolerate write merging'
>
> So here, spec refers the backing memory allocated on the endpoint side as the
> 'range' i.e, the BAR memory allocated on the host that gets mapped on the
> endpoint.
>
> Currently on the endpoint side, we use dma_alloc_coherent() to allocate the
> memory for each BAR and map it using iATU.
>
> So I want to know if the memory range allocated in the endpoint through
> dma_alloc_coherent() satisfies the above two conditions in PCIe spec on all
> architectures:
>
> 1. No Read side effects
> 2. Tolerates write merging
>
> I believe the reason why we are allocating the coherent memory on the endpoint
> first up is not all PCIe controllers are DMA coherent as you said above.

As far as I can tell, we never have read side effects for memory
backed BARs, but the write merging is something that depends on
how the memory is used:

If you have anything in that memory that relies on ordering,
you probably want to map it as coherent on the endpoint side,
and non-prefetchable on the host controller side, and then
use the normal rmb()/wmb() barriers on both ends between
serialized accesses. An example of this would be having blocks
of data separate from metadata that says whether the data is
valid.

If you don't care about ordering on that level, I would use
dma_map_sg() on the endpoint side and prefetchable mapping on
the host side, with the endpoint using dma_sync_*() to pass
buffer ownership between the two sides, as controlled by some
other communication method (non-prefetchable BAR, MSI, ...).

     Arnd


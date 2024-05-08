Return-Path: <linux-pci+bounces-7267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADDC8C0509
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 21:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9251C208C3
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 19:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5AC12D75D;
	Wed,  8 May 2024 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F5qR6IOK"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0CFD534;
	Wed,  8 May 2024 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196625; cv=none; b=MbSclgfZ64FUQt50UX0N61su0DBjorZb1luk+uvpmfN2wTNvZ71mq/31mzdL1lP44tzcMYP2sv09PhxX3zYfyuFAVG5G5/nvP8TxXQMHQzd1srkzebiVbLypIV7lUwMKMRIPQfnAmMrHpp246O0ukdi1g2gnhcOnpq8bSsKa38k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196625; c=relaxed/simple;
	bh=w5k+yxn9zC7TL2YBMW5JBZXfSMdrbXnisSZwM2mWRnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+SZu2KcuQTKv7dd270QMwyZrxP4gSCsDjXnS62n1AVvVSuuQaddKsUKPeUkQ9dfJnI8eqXJM/cc1Nd5UOqqWAatvHqlDM/snSkaTUd8qSozbvh5O/SS+DM+AkfYSPNJ21zXV9QAQJQB0Gpwiv+Q2JTca2ROAepfQtT5WS6nIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F5qR6IOK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QWFSSKGbHla6mEPQaFgDSzLdUE17xeXPLekr1H3HReM=; b=F5qR6IOKs/Ad9M4W3Ci1MobTou
	PkZ/eWYbJnPgKeKc/8oNakuG4g8yYzyh2b69xGCes0r1i3eSNdMeKAb1jCmi/PqkE/xmIPwE8zEvy
	o0xX/OmtNr+H41aTN4xfv6DM3k/UTmx/wU91GVIO7+4bzmxO8tc5+3NCgtmuPUFFFOKXFgYiV5nTg
	sZPYxRF7zo3KrssOHM9ALfNmk4qFYBj5ievIcn4HsQ1/5VTxeVzgeNKawBla864XsWX/tb8UyYO0U
	MeVZU3EOfWxXKTp9cwIxWw1k4cy64rvN41s1vSZVPo5c5s9VKuS7A/vJG0AymlW5z6Be+6RjHOtNT
	38NdCBTA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4mzV-0000000GklA-35eN;
	Wed, 08 May 2024 19:30:13 +0000
Date: Wed, 8 May 2024 12:30:13 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Adam Manzanares <a.manzanares@samsung.com>, Song Liu <song@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	Fan Ni <fan.ni@samsung.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"gourry.memverge@gmail.com" <gourry.memverge@gmail.com>,
	"wj28.lee@gmail.com" <wj28.lee@gmail.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
	"shradha.t@samsung.com" <shradha.t@samsung.com>,
	Jim Harris <jim.harris@samsung.com>,
	"mhocko@suse.com" <mhocko@suse.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] CXL Development Discussions
Message-ID: <ZjvSxTvu_SHWVCVK@bombadil.infradead.org>
References: <CGME20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f@uscas1p2.samsung.com>
 <9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
 <66396c1938726_2f63a29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zjp4DtkCFGOiFA6X@bombadil.infradead.org>
 <48a26545-5d41-47f4-95a6-e55395b63c66@nmtadam.samsung>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48a26545-5d41-47f4-95a6-e55395b63c66@nmtadam.samsung>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, May 08, 2024 at 06:38:36PM +0000, Adam Manzanares wrote:
> On Tue, May 07, 2024 at 11:50:54AM -0700, Luis Chamberlain wrote:
> > On Mon, May 06, 2024 at 04:47:37PM -0700, Dan Williams wrote:
> > > For testing I think it is an "all of the above plus hardware testing if
> > > possible" situation. My hope is to get to a point where CXL patchwork
> > > lights up "S/W/F" columns with backend tests similar to NETDEV
> > > patchwork:
> > > 
> > > https://patchwork.kernel.org/project/netdevbpf/list/
> > > 
> > > There are some initial discussions about how to do this likely we can
> > > grab some folks to discuss more.
> > > 
> > > I think Paul and Song would be useful to have for this discussion.
> > 
> > I think everyone and their aunt wants this to happen for their subsystem,
> > so a separate session to hear about how to get there would be nice.
> 
> +1

Song, at last year's LSFMM you had mentioned the above work by ebpf folks
with patchwork integration. While it is great, I am not sure if folks
realize the amount of work required to get the above up and running and
then to maintain it. So I was wondering if perhaps at this year's LSFMM
if we can have a lightning talk or BoF to review just that and give
people clarity about the effort required to do get this going and
maintaining it. Its clear not only CXL folks would be interested, but
also filesystems and likely block layer folks. Would you be up to help
review that with folks with a lightning talk or BoF session? Would there
be anyone else who can talk about that?

  Luis


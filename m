Return-Path: <linux-pci+bounces-3348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3928517C9
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 16:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B071F227D7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 15:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7163C092;
	Mon, 12 Feb 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPlz6UWx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338E63BB55;
	Mon, 12 Feb 2024 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751082; cv=none; b=sybPjuQUhTJKiaW36NWtvxHsb56N0xjqe/AcAZwa05Zyl2FDQjyPFO0tf9Ew/6VVPoTFbbLdcRpks7vr59GctATc2qEOPKQW4kXuUOKLJ2vLS/pAtpsaCYCJuSkTf64VfxBDD0aSWZ0hMcwUOEhdV7617ZibCdn+c2tPy4q3Hl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751082; c=relaxed/simple;
	bh=BnrZ9C/Bz7X3B9Yi4bgBJOnu5VZLUMUOMzuMSBtlbnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTpq+jvMBY2ju5raMrxoAVfwtvYMSzRQXC5Vi8oWj2AUq0iPcVaLgw1ZpJAmFUYQzmC0rn+ZBFDFHxoI4wp1HGJuAJv105jo7Dx+/TaN8v9JHT0R8sQywAogV9y4qC1TodsnaBc+jtRRwpBBn+gL2qULRbxFdQ512+3hzNA83yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPlz6UWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D59BC433C7;
	Mon, 12 Feb 2024 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707751081;
	bh=BnrZ9C/Bz7X3B9Yi4bgBJOnu5VZLUMUOMzuMSBtlbnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPlz6UWxUe1nOoduQZ4F4RiW8KQVZHi78f31ao3a+oiglfPu4nC8xR7kSwoqi7uMr
	 xIkdeZPFwiiUdEFbh1i9uwmKyEJXKk1gt++c3OGowESDC6OXEiYhSDM1W/sL0nX2Ia
	 RW3xmNp1+GPx/7+VAhW4I3VjT4z8g0719N105OmJf1tPJVJOOeh5QEAgWTUB6Ayu0m
	 DeOb5buNIe6M8gf1EzdukQS79FJAj7TcIUdCYbBeHUWTnthAxWyL599ynaBE2sauUW
	 wgjfDIvhnw8hEnRTv1ouppO2PfAFbIrE0n8cDnL70REuxS4qT6deV5GwTnlZ6gClW0
	 q06nXa8K/l0TQ==
Date: Mon, 12 Feb 2024 08:17:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jim Harris <jim.harris@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"pierre.cregut@orange.com" <pierre.cregut@orange.com>
Subject: Re: [PATCH v2 2/2] pci/iov: fix kobject_uevent() ordering in
 sriov_enable()
Message-ID: <Zco2pmQWR49V9Imw@kbusch-mbp.mynextlight.net>
References: <170752254154.1693615.9176696143128338408.stgit@bgt-140510-bm01.eng.stellus.in>
 <CGME20240209235218uscas1p2d0978af6623037fa1b9358a2ad2320c5@uscas1p2.samsung.com>
 <170752273749.1693615.1293677023514112939.stgit@bgt-140510-bm01.eng.stellus.in>
 <d9c89ad1-990d-4a4c-a16d-27d978673e57@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9c89ad1-990d-4a4c-a16d-27d978673e57@linux.intel.com>

On Fri, Feb 09, 2024 at 07:22:17PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 2/9/24 3:52 PM, Jim Harris wrote:
> > @@ -677,8 +677,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> >  	if (rc)
> >  		goto err_pcibios;
> >  
> > -	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
> >  	iov->num_VFs = nr_virtfn;
> > +	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);

Since it's accessed unlocked now, I *think* this wants appropriate
barriers to ensure the order is observed the same on all CPUs. Something
like 'smp_store_release(&iov->num_VFs, nr_virtfn)' for writing it, and
use 'smp_load_acquire()' on the read-side.


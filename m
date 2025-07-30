Return-Path: <linux-pci+bounces-33177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE92B1610B
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 15:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D0CA7B4F6E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06F2295D90;
	Wed, 30 Jul 2025 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DpcJM/S3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E3DDC1;
	Wed, 30 Jul 2025 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880882; cv=none; b=uGTt0k93w/LYItR5IxP8/qoXBzvzz84i1nhEZ1PgEA1j2asE7/7EDN2IeF56yg09oCGi7r6PYp0rSi+awxlgs0Cw1iKItAlJ3VtCeuU6Ap9SY1ABbRR7W71oCnCmBMSbbacwK6MHbFVRSUVB3M6qwpf11T1kHv9Qfn+4PA8oB08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880882; c=relaxed/simple;
	bh=pcptWvpGnZ0zEXWJBDt0MWQbVsZGKk578TFASBUhd5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DK7DgRYmPwZQ8sIM/lLB+5MHUh+coJeKeLFNyO7aLAHB5eY4kx2TjM3Hv6u5UYELqnIB5VKtdPjL9G/6vCTlcEdTtirwFwwL7FvwO9gBeZqTpN4pYITPnleN6itapuFDLn3uiJCu77+JXUG/GYiuqowc4jb+1hSN8WVAwwLPMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DpcJM/S3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64768C4CEE7;
	Wed, 30 Jul 2025 13:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753880882;
	bh=pcptWvpGnZ0zEXWJBDt0MWQbVsZGKk578TFASBUhd5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpcJM/S3elZXvUohTZx6U84otLPd04tg6T+kNqTSjUWSV+OAaj6Kzwu+/klfkdoDS
	 O8DeIC1aFKSuL7hhkTv189VYrWrGpLVXbnUXZWN1PWWBKS65ccLGbPNYIFhhqUisEi
	 erVkIlidrLqiK6omApXBNwHSr8r5SAMR/p2IopAk=
Date: Wed, 30 Jul 2025 15:07:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
Message-ID: <2025073035-bulginess-rematch-b92e@gregkh>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730132333.00006fbf@huawei.com>

On Wed, Jul 30, 2025 at 01:23:33PM +0100, Jonathan Cameron wrote:
> On Wed, 30 Jul 2025 11:38:27 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Wed, 30 Jul 2025 14:12:26 +0530
> > "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> wrote:
> > 
> > > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > >   
> > > > On Tue, Jul 29, 2025 at 06:10:45PM +0100, Jonathan Cameron wrote:
> > > >    
> > > >> > +static struct platform_device cca_host_dev = {    
> > > >> Hmm. Greg is getting increasingly (and correctly in my view) grumpy with
> > > >> platform devices being registered with no underlying resources etc as glue
> > > >> layers.  Maybe some of that will come later.    
> > > >
> > > > Is faux_device a better choice? I admit to not knowing entirely what
> > > > it is for..  
> > 
> > I'll go with a cautious yes to faux_device. This case of a glue device
> > with no resources and no reason to be on a particular bus was definitely
> > the intent but I'm not 100% sure without trying it that we don't run
> > into any problems.
> > 
> > Not that many examples yet, but cpuidle-psci.c looks like a vaguely similar
> > case to this one.  
> > 
> > All it really does is move the location of the device and
> > smash together the device registration with probe/remove.
> > That means the device disappears if probe() fails, which is cleaner
> > in many ways than leaving a pointless stub behind.
> > 
> > Maybe it isn't appropriate it if is actually useful to rmmod/modprobe the
> > driver. 
> > 
> > +CC Greg on basis I may have wrong end of the stick ;)
> This time with at least one less typo in Greg's email address.

Yes, use faux_device if you need/want a struct device to represent
something in the tree and it does NOT have any real platform resources
behind it.  That's explicitly what it was designed for.

thanks,

greg k-h


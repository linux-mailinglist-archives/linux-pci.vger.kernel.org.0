Return-Path: <linux-pci+bounces-37805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 166DDBCCF21
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 14:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485CC1A6619C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7D32ED843;
	Fri, 10 Oct 2025 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gCxelIpC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6432D0629;
	Fri, 10 Oct 2025 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099933; cv=none; b=LwqSOnXCJf6gRmXbheyndDKaShbZBwcAZpjydESEPlEGqWpW+D26zVnHpX5nPJ3GFfOZYRaTErRvKDOTIafFJUgB3bfXYUVwvfX4Shvq+IoJpZyebEd2/ojGgkJTCr7rRb0mukwnz2zsxSehCXT70de0I7tx1ENiBbHffXSC16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099933; c=relaxed/simple;
	bh=p2dq1+BYCl83wtRQDI4S8QRU072WIE+qdJpzYKgqGwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5TOJ/IekRUMTqfFwNJl4edVWp0LCd/8xdN7QzpDDOFZo+sgAg3KrHYWfQPcfFQE67JGeYTBkSkgcJSf03RZzxA8g53LloLmGh6s2UHqlZMhBYqpjgKTnxnBCqrmZwhc+MPnAeLZged0gT7EHGshTTEwI3o9W/2yTVAgcee19XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gCxelIpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87526C4CEF1;
	Fri, 10 Oct 2025 12:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760099933;
	bh=p2dq1+BYCl83wtRQDI4S8QRU072WIE+qdJpzYKgqGwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCxelIpCywnl2nZ+0zzEYviCt/IR7PSgK9ywEfdoWQn+oAPWP7F11LRUhgwqcpVge
	 VRUUfQbpTeDkgpT6ATNWtNlJNzpyVp3Ok6k/i3dDGVy/2vxfxa+aX2gebckUC0W++P
	 daAx7QgJQ2VIKINmVs97v+NZSTJ9hvGWv5Wb1mjk=
Date: Fri, 10 Oct 2025 14:38:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
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
Message-ID: <2025101020-tiara-procreate-e56f@gregkh>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>

On Fri, Oct 10, 2025 at 07:10:58AM -0500, Jeremy Linton wrote:
> Hi,
> 
> 
> On 7/30/25 8:07 AM, Greg KH wrote:
> > On Wed, Jul 30, 2025 at 01:23:33PM +0100, Jonathan Cameron wrote:
> > > On Wed, 30 Jul 2025 11:38:27 +0100
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > 
> > > > On Wed, 30 Jul 2025 14:12:26 +0530
> > > > "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> wrote:
> > > > 
> > > > > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > > > > > On Tue, Jul 29, 2025 at 06:10:45PM +0100, Jonathan Cameron wrote:
> > > > > > > > +static struct platform_device cca_host_dev = {
> > > > > > > Hmm. Greg is getting increasingly (and correctly in my view) grumpy with
> > > > > > > platform devices being registered with no underlying resources etc as glue
> > > > > > > layers.  Maybe some of that will come later.
> > > > > > 
> > > > > > Is faux_device a better choice? I admit to not knowing entirely what
> > > > > > it is for..
> > > > 
> > > > I'll go with a cautious yes to faux_device. This case of a glue device
> > > > with no resources and no reason to be on a particular bus was definitely
> > > > the intent but I'm not 100% sure without trying it that we don't run
> > > > into any problems.
> > > > 
> > > > Not that many examples yet, but cpuidle-psci.c looks like a vaguely similar
> > > > case to this one.
> > > > 
> > > > All it really does is move the location of the device and
> > > > smash together the device registration with probe/remove.
> > > > That means the device disappears if probe() fails, which is cleaner
> > > > in many ways than leaving a pointless stub behind.
> > > > 
> > > > Maybe it isn't appropriate it if is actually useful to rmmod/modprobe the
> > > > driver.
> > > > 
> > > > +CC Greg on basis I may have wrong end of the stick ;)
> > > This time with at least one less typo in Greg's email address.
> > 
> > Yes, use faux_device if you need/want a struct device to represent
> > something in the tree and it does NOT have any real platform resources
> > behind it.  That's explicitly what it was designed for.
> 
> Right, but this code is intended to trigger the kmod/userspace module
> loader.

Why?

> AFAIK, the faux device is currently missing a faux_device_id in
> mod_devicetable, alias matching logic in file2alias, and probably a few
> other things which keeps it from performing this function.

How would a faux device ever expect to get auto-loaded?  That's not what
is supposed to be happening here at all.

If you have real hardware backing something, then use the real driver
type.  that is NOT a faux driver, which is, as the name says, for "fake"
devices that you wish to add to the device/driver tree.

thanks,

greg k-h


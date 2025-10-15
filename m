Return-Path: <linux-pci+bounces-38191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38014BDDE46
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 11:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68EB3C39B8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB26292B4B;
	Wed, 15 Oct 2025 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NuJVyRiE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D468270553;
	Wed, 15 Oct 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522309; cv=none; b=peeVcLn9bbzM9X59dlIBS3mbOjwDJbM6z9FAH8n60iKTFZr1/RVDVOjIqpN2M7JytR6Qyjyaa/yrYw5gmwVmxS7SdMtU9ANOqSDi4tEASOAvguexEQi2NPrJd2z2z5/5OZxMGxqWZtApvxcwPE8deLLDvA38hV43zvYPw0fnoDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522309; c=relaxed/simple;
	bh=9m1OgdKe7aoT3hGMYXt+sJFe5ZoCP4FhhcvhmKlNVWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLAoTJSHuT3WFBRgJx9DFyWCGSciQGwC5+tIkAt3VYf213Bvz4Svw2uIjfkgqn/Mpm4u+WZl42mXQUxBsFNNF228ApTKF00g82AO7Qiy/IBsUn0LPpW5RQGbhyO+qIevGX03Bj1Hbm0FXWU9yFnlcTE5gEHt+Xpqr5syJJBnXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NuJVyRiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3143BC4CEF8;
	Wed, 15 Oct 2025 09:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760522308;
	bh=9m1OgdKe7aoT3hGMYXt+sJFe5ZoCP4FhhcvhmKlNVWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NuJVyRiE5VNqiLDy9T2/dT7PG/8mj7//4rswQ4XcBnKFJ2h5A91DsWhPEEerOtd33
	 CB+7wLQZhwYP7Hst6MYfoPrGJVRHI3GtPCthYAnV0sI8Yn/KeIds2rHZ8vw2xqEzKR
	 V+Cl5AKZbVyvuuI9qK1BCxbQaIrGzEpYhb70yuJA=
Date: Wed, 15 Oct 2025 11:58:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Jeremy Linton <jeremy.linton@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
Message-ID: <2025101523-evil-dole-66a3@gregkh>
References: <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
 <yq5a347kmqzn.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5a347kmqzn.fsf@kernel.org>

On Wed, Oct 15, 2025 at 03:22:28PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Fri, Oct 10, 2025 at 07:10:58AM -0500, Jeremy Linton wrote:
> >> > Yes, use faux_device if you need/want a struct device to represent
> >> > something in the tree and it does NOT have any real platform resources
> >> > behind it.  That's explicitly what it was designed for.
> >> 
> >> Right, but this code is intended to trigger the kmod/userspace module
> >> loader.
> >
> > Faux devices are not intended to be bound, it says so right on the label:
> >
> >  * A "simple" faux bus that allows devices to be created and added
> >  * automatically to it.  This is to be used whenever you need to create a
> >  * device that is not associated with any "real" system resources, and do
> >  * not want to have to deal with a bus/driver binding logic.  It is
> >                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
> >  * intended to be very simple, with only a create and a destroy function
> >  * available.
> >
> > auxiliary_device is quite similar to faux except it is intended to be
> > bound to drivers, supports module autoloading and so on.
> >
> > What you have here is the platform firmware provides the ARM SMC
> > (Secure Monitor Call Calling Convention) interface which is a generic
> > function call multiplexer between the OS and ARM firmware.
> >
> > Then we have things like the TSM subsystem that want to load a driver
> > to use calls over SMC if the underlying platform firmware supports the
> > RSI group of SMC APIs. You'd have a TSM subsystem driver that uses the
> > RSI call group over SMC that autobinds when the RSI call group is
> > detected when the SMC is first discovered.
> >
> > So you could use auxiliary_device, you'd consider SMC itself to be the
> > shared HW block and all the auxiliary drivers are per-subsystem
> > aspects of that shared SMC interface. It is not a terrible fit for
> > what it was intended for at least.
> >
> 
> IIUC, auxiliary_device needs a parent device, and the documentation
> explains that it’s intended for cases where a large driver is split into
> multiple dependent smaller ones.
> 
> If we want to use auxiliary_device for this case, what would serve as
> the parent device?

The real device that has the resources you wish to share access to.  Are
there physical resources here you are sharing?  If so, that device is
the parent.  If there is no such thing, then just make a bunch of faux
devices and be done with it :)

thanks,

greg k-h


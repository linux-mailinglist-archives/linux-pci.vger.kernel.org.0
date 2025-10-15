Return-Path: <linux-pci+bounces-38205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 837B7BDE5A3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 13:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC37D4FCC8E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 11:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8E3326D53;
	Wed, 15 Oct 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lt7YCPGf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E102326D4B;
	Wed, 15 Oct 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529462; cv=none; b=cTaScsRRvfR1iJNqK4PXYkdHBO9onZPkv1tHQ7e2CXgUd/NAJm2VicjBrrUG7DQCTDgCtRyOMWW448f4Qts/i2eGV6oUE6dpeR9uO3jXCSvkWIjblainPTYkJlRpVFmlI3JEV0tecKwscrzNLHS1WRuWxtMnNN9C58aHJn+m3vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529462; c=relaxed/simple;
	bh=ITnl1Ixrn/9uFYahs1nyx1kHy9PHO6avdkREAF2GEgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjU8Am0dX3s5edfV6ZGku7HJYp5tnG8/ppRwlmZepa7toMphMbpGtAs6v4VOkOLko9l5RYPSP+DB6BLVZCb9uu5DcNOSPUR7kfEtafPmjHgeSAY95k+lk4oKrpGYcUrfWBsruPG+viqQLFWwdOjcB0/RRFwoSGtYH132qU+D59k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lt7YCPGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B281C19421;
	Wed, 15 Oct 2025 11:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760529461;
	bh=ITnl1Ixrn/9uFYahs1nyx1kHy9PHO6avdkREAF2GEgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lt7YCPGfS8UpQn46FIW5N7YqNrIcf0HpUWWH+8bhEI65Gi4YU4gmHhF0kEgTx8Gkb
	 MFRoD/k8f+XHelZ4dpctt2bNRALKEz8DCSd+OwYu1KVA28qgjFt4VLiZ0Y5TPMHEOu
	 5uLTv5PzPdZsUfVcAsCEl7Wa6CllczIYecXAW2c0=
Date: Wed, 15 Oct 2025 13:57:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
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
Message-ID: <2025101534-frosty-shank-00b1@gregkh>
References: <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
 <yq5a347kmqzn.fsf@kernel.org>
 <2025101523-evil-dole-66a3@gregkh>
 <20251015115044.GE3938986@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251015115044.GE3938986@ziepe.ca>

On Wed, Oct 15, 2025 at 08:50:44AM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 15, 2025 at 11:58:25AM +0200, Greg KH wrote:
> > On Wed, Oct 15, 2025 at 03:22:28PM +0530, Aneesh Kumar K.V wrote:
> > > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > > 
> > > > On Fri, Oct 10, 2025 at 07:10:58AM -0500, Jeremy Linton wrote:
> > > >> > Yes, use faux_device if you need/want a struct device to represent
> > > >> > something in the tree and it does NOT have any real platform resources
> > > >> > behind it.  That's explicitly what it was designed for.
> > > >> 
> > > >> Right, but this code is intended to trigger the kmod/userspace module
> > > >> loader.
> > > >
> > > > Faux devices are not intended to be bound, it says so right on the label:
> > > >
> > > >  * A "simple" faux bus that allows devices to be created and added
> > > >  * automatically to it.  This is to be used whenever you need to create a
> > > >  * device that is not associated with any "real" system resources, and do
> > > >  * not want to have to deal with a bus/driver binding logic.  It is
> > > >                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > >  * intended to be very simple, with only a create and a destroy function
> > > >  * available.
> > > >
> > > > auxiliary_device is quite similar to faux except it is intended to be
> > > > bound to drivers, supports module autoloading and so on.
> > > >
> > > > What you have here is the platform firmware provides the ARM SMC
> > > > (Secure Monitor Call Calling Convention) interface which is a generic
> > > > function call multiplexer between the OS and ARM firmware.
> > > >
> > > > Then we have things like the TSM subsystem that want to load a driver
> > > > to use calls over SMC if the underlying platform firmware supports the
> > > > RSI group of SMC APIs. You'd have a TSM subsystem driver that uses the
> > > > RSI call group over SMC that autobinds when the RSI call group is
> > > > detected when the SMC is first discovered.
> > > >
> > > > So you could use auxiliary_device, you'd consider SMC itself to be the
> > > > shared HW block and all the auxiliary drivers are per-subsystem
> > > > aspects of that shared SMC interface. It is not a terrible fit for
> > > > what it was intended for at least.
> > > >
> > > 
> > > IIUC, auxiliary_device needs a parent device, and the documentation
> > > explains that it’s intended for cases where a large driver is split into
> > > multiple dependent smaller ones.
> 
> Which is the case here, you have a SMC interface that you want to
> fracture into multiple subsystems.
> 
> > > If we want to use auxiliary_device for this case, what would serve as
> > > the parent device?
> 
> You probably need to make a platform device for the discovered PSCI
> interface from the firmware. Looks like DT will already have one, ACPI
> could invent one..
>  
> > The real device that has the resources you wish to share access to.  Are
> > there physical resources here you are sharing?  If so, that device is
> > the parent.  If there is no such thing, then just make a bunch of faux
> > devices and be done with it :)
> 
> At the very bottom of the stack it looks like the PSCI interface is
> discovered first through DT/ACPI. The PSCI interface has RPCs that are
> then used to discover if SMC/etc/etc are present and along the way it
> makes platform devices to plug in subsystems to it based on what it
> can discover.

Great, so you have a real platform device down there at the "root" of
all of this, that is doleing out resources to other "child" drivers.

> It is just not sharing "resources" in the traditional sense, PSCI has
> no registers or interrupts, yet it is a service provided by the
> platform firmare.

Great, so it's a real firmware device, use that as a platform device and
use the resources available there.

> Again faux devices don't serve the need here to load modules and do
> driver binding.

If this really is a firmware thing, and you have a firmware device, then
I am confused why this was even brought up at all?  Use a real platform
device, with the resources that are needed to talk to this platform
device and you should be fine.

BUT, if you are making child devices that are NOT actually talking to
the firmware, then make it a faux device and deal with the fact that you
can't load modules because it's a fake device that no hardware
definition is there for :)

Does that make sense?

thanks,

greg k-h


Return-Path: <linux-pci+bounces-38204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A04FBDE555
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 13:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C053919C4B9D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 11:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC222322DB7;
	Wed, 15 Oct 2025 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e2c1oMHL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF53233FE
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529048; cv=none; b=hVWMWeHDQ9WAaF56CyXSk8mmBEG8/iphh7Apx4AtPbSwgfsEHAj+GZBJcrQBB7o5Ti8eMGlmpGjybDziRbUcke6VSre+pzM4i2mhCGRtYaT727wHtzVV4ofVoKmG8fxGXGFZp43eikp20Zzd0xSmjaAOwuMK2RAlc7FURxoC0yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529048; c=relaxed/simple;
	bh=tmowLdt/N2nbXuZaInudOLZY9PCI7SbE+aZIEDGepoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmDsSvz5xDbo5lO2EF2F+epJBqF7ZoxFA8i+o/a5fL+pHXH9+u4GaTAAZmlWlVZcXtgGe1pK5Hz5p7Ht9iYJE6CAMl35n1/7pdYdEbcJvvGl0Ox2bW0uRdHHr9X2EWkazSlkQUVcyfG7ZY2Bv75gwSgm6B+0ECkJYkoKnb9eKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e2c1oMHL; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-43f494764a2so3428030b6e.0
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 04:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760529046; x=1761133846; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vHmKb0ZIzx4zdIs4Lr+2KFKimyOcsEmfGR6+OHZivpc=;
        b=e2c1oMHLRoMsONACHvkGo89STMQDv1H2DDH7z25YhyiSVBLk6In+ilLNIbmmI6V/rg
         b+BiXsOnkfG/vQ/99VuKAB5ZkCuguagHNO24qE+6hPDTfRf81lLGQOA0QS77Z/Xd+fRp
         lOnKwDAFW1wXkIgFKaD8K35yU8WbW2M5PPAfcneZVv3bMkI84YxqTfv4HVInxFQZFkAc
         6KLFfb9FBBTgzp2f0RI/ZJ+6xYlLry2wsquidfueaiD33ccXHbRjZ2QvBQ1HJI5y6/nD
         12uFaMuWNJIU9A8eEDakC81AdhcAhzmzBoDbAhyHHdDaOKY8KatZ6L63H1aBfNm0V9R7
         mo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760529046; x=1761133846;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHmKb0ZIzx4zdIs4Lr+2KFKimyOcsEmfGR6+OHZivpc=;
        b=aQbYLJ9O7Z0lOxmYjl1ZB47L8h1i84mKY9+1BMwJc6JrnRqwuV2h1tbeHZeTRc+qUR
         SmQtVoPZQ1mm31DG387glKU9NrzYFnJrLofatmOSnK2mWNffJdGl0UxAV1BEUu7YXm7U
         KWVQiQCmxMLrDqpD6h47uMbKkS2WX87evCNaG9YbMQ6T9EWuBF5n6YSeMYBQ1PiaIHcq
         RUOx6ypW3kIZT9cJ2wbdZkUEjd9Enjm8WV3LYtWkROTVcQdXBx9XsmI87e2nqwnqlYSE
         RnweZYZ90YfgykEWvYJf4Tv7gtOJJIRcQx1v/OZjBM7rBI1RyaDs2JmQfc8pMnUz97Ih
         gZfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkK/9k31/lQUQd/hGLQrEdxDV0rwhDwiFsH6JI4DEqWbTW03QyE9QlrL5tcxVj7SQDLvFLLBcAQQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcodqXesJzlTRngiKKVfDsWu+qwKGocOu1o+03jx9tiqH6MqXC
	TAHhoOUaF6XHiQr9CaLetAGt6zxerWN4HJflC8HtYp3VDAscbsh9t+Mi0v4AuZ81/vI=
X-Gm-Gg: ASbGncuCitc/46H0VNKTS+XFsmFnl1H2OXE7W3h45p5Q+0d4abVGs/8TZEE65LzyZxx
	e2FdPe4ChlyphajuSQB4CJGCIzjz1rzJXPEZf92282xZWN3BjrKWiPtnOmVDWY70hRFgoFBLqJm
	UFelTXRWNH8n3oZn5W22Zb+41PZG1eV52sU7nNWXsd6m+S0O5SmjAN0gE8XfGhhRhQlO+C8F0m8
	gOgMVX2QpE3zSLGDYib6wERMeaPRt7+HnX4flGlyAPD2E0/uGaPE8IENn2sZASPNMo6DvqSTB60
	NT3XrZvUsGbLj9dOxc6tdIsu1ld0mF9aXRik63LrbHAnOs2/ebrD8oTbwAV/H9spnXLUKo4OG6H
	HJl8SXLde+CKuGJMnMh2uNgOFxw==
X-Google-Smtp-Source: AGHT+IF06YM32w1B97BvNmrLzOYC8WHnzl3Ay7SwG+FkmHKb9v+2SSicrsaLo8CLc8NQ8NePlRs7aQ==
X-Received: by 2002:a05:6808:4486:b0:43f:5f5f:370e with SMTP id 5614622812f47-4417b2f0ca9mr13602594b6e.19.1760529045662;
        Wed, 15 Oct 2025 04:50:45 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441ca023222sm2814641b6e.11.2025.10.15.04.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 04:50:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v901k-0000000HOR5-14cb;
	Wed, 15 Oct 2025 08:50:44 -0300
Date: Wed, 15 Oct 2025 08:50:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <20251015115044.GE3938986@ziepe.ca>
References: <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
 <yq5a347kmqzn.fsf@kernel.org>
 <2025101523-evil-dole-66a3@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025101523-evil-dole-66a3@gregkh>

On Wed, Oct 15, 2025 at 11:58:25AM +0200, Greg KH wrote:
> On Wed, Oct 15, 2025 at 03:22:28PM +0530, Aneesh Kumar K.V wrote:
> > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > 
> > > On Fri, Oct 10, 2025 at 07:10:58AM -0500, Jeremy Linton wrote:
> > >> > Yes, use faux_device if you need/want a struct device to represent
> > >> > something in the tree and it does NOT have any real platform resources
> > >> > behind it.  That's explicitly what it was designed for.
> > >> 
> > >> Right, but this code is intended to trigger the kmod/userspace module
> > >> loader.
> > >
> > > Faux devices are not intended to be bound, it says so right on the label:
> > >
> > >  * A "simple" faux bus that allows devices to be created and added
> > >  * automatically to it.  This is to be used whenever you need to create a
> > >  * device that is not associated with any "real" system resources, and do
> > >  * not want to have to deal with a bus/driver binding logic.  It is
> > >                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >  * intended to be very simple, with only a create and a destroy function
> > >  * available.
> > >
> > > auxiliary_device is quite similar to faux except it is intended to be
> > > bound to drivers, supports module autoloading and so on.
> > >
> > > What you have here is the platform firmware provides the ARM SMC
> > > (Secure Monitor Call Calling Convention) interface which is a generic
> > > function call multiplexer between the OS and ARM firmware.
> > >
> > > Then we have things like the TSM subsystem that want to load a driver
> > > to use calls over SMC if the underlying platform firmware supports the
> > > RSI group of SMC APIs. You'd have a TSM subsystem driver that uses the
> > > RSI call group over SMC that autobinds when the RSI call group is
> > > detected when the SMC is first discovered.
> > >
> > > So you could use auxiliary_device, you'd consider SMC itself to be the
> > > shared HW block and all the auxiliary drivers are per-subsystem
> > > aspects of that shared SMC interface. It is not a terrible fit for
> > > what it was intended for at least.
> > >
> > 
> > IIUC, auxiliary_device needs a parent device, and the documentation
> > explains that it’s intended for cases where a large driver is split into
> > multiple dependent smaller ones.

Which is the case here, you have a SMC interface that you want to
fracture into multiple subsystems.

> > If we want to use auxiliary_device for this case, what would serve as
> > the parent device?

You probably need to make a platform device for the discovered PSCI
interface from the firmware. Looks like DT will already have one, ACPI
could invent one..
 
> The real device that has the resources you wish to share access to.  Are
> there physical resources here you are sharing?  If so, that device is
> the parent.  If there is no such thing, then just make a bunch of faux
> devices and be done with it :)

At the very bottom of the stack it looks like the PSCI interface is
discovered first through DT/ACPI. The PSCI interface has RPCs that are
then used to discover if SMC/etc/etc are present and along the way it
makes platform devices to plug in subsystems to it based on what it
can discover.

It is just not sharing "resources" in the traditional sense, PSCI has
no registers or interrupts, yet it is a service provided by the
platform firmare.

Again faux devices don't serve the need here to load modules and do
driver binding.

Jason


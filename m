Return-Path: <linux-pci+bounces-33272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02C7B17E52
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 10:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 302D27AD768
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 08:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856B121FF44;
	Fri,  1 Aug 2025 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pMP5k6YB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77621B9F5;
	Fri,  1 Aug 2025 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037095; cv=none; b=QlJPDD8maKuzf2aDaX4SGp/dDWJv/fPTbuPDT9ywH7LLH26Lx9j6nrhQjcu7doQvSrIGIH74Dlwpu0my86bXD0dF3jeqc/QyiCgzlVw7NFIJAc7nT6tANF0G0M2MwTUqrkbkbj0Df1g/suEOo1S9HL+hDa7TFXTMmNVvAs+K2ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037095; c=relaxed/simple;
	bh=5scCGip/FFvGOCm9mLa0Uv56JbL7TQeCcOdQaylPTI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ir58aMFMMHFOTUsET7Lm/BWtFSDDkuXLm039gt/8GVC3409JW2hGQal0sshJUEBsPA58EGC21nfHFn28g16S8VHFQBqLNAnW1Sl+reYkDcsrUJMo7yxLDcsO4wm2YGtTUO5ZgJ/a+M04EF7M3BSeF42J7Cdfkqhg/9gkoamBHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pMP5k6YB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F88C4CEE7;
	Fri,  1 Aug 2025 08:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754037094;
	bh=5scCGip/FFvGOCm9mLa0Uv56JbL7TQeCcOdQaylPTI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pMP5k6YBLG+KPAlawMA+Mj/merfSzH2TqBI3GGIQEPD5nDw5e93uRVkyDyYyWHN5g
	 gM4BluqBjK5n4E1jdD9PpmGZanbYjRgnVyocKiRReciEFEGjAq2z92AClK4YePx9yZ
	 eSjYODSWEu0nRSpSkKw/dJcI8prJ+XZbeofLlJGI=
Date: Fri, 1 Aug 2025 10:31:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
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
Message-ID: <2025080153-flattery-panic-1057@gregkh>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250731121133.GP26511@ziepe.ca>
 <20250731142250.00005651@huawei.com>
 <20250731164603.GX26511@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731164603.GX26511@ziepe.ca>

On Thu, Jul 31, 2025 at 01:46:03PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 31, 2025 at 02:22:50PM +0100, Jonathan Cameron wrote:
> 
> > If you mean create a class device with no parent, that's also something
> > we are slowly trying to fix.  Reminds me that fixing up more perf devices
> > is still on my todo list.
> 
> IIRC if you create a class device with no parent it gets placed on the
> virtual bus...
> 
> Do you mean we should not do that?
> 
> > Should be a child of something, so maybe that is a good reason for a
> > faux_device here if there is nothing else to use.
> 
> Don't see such a big difference to have it be the child of a faux
> device on the faux bus than to just be directly on the virtual bus?

Either is fine, but just never use a platform device for a
non-platform-resource-backed device please.

thanks,

greg k-h


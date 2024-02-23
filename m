Return-Path: <linux-pci+bounces-3913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CC8860C19
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 09:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEEF81F26E5B
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 08:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E84718042;
	Fri, 23 Feb 2024 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAwv5aw+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69B1B59E
	for <linux-pci@vger.kernel.org>; Fri, 23 Feb 2024 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676401; cv=none; b=foOmjxra5dA7qZGDKJvnxrdukqtZKyQ9RHJ66IDKkDBSuJIBrygH7TjFLzzFQF7Hza1h55J0cA2XfPCuruc+jr/JeQKA6ObrXxSvBidaIHVN0kIWhUFfMqI1112vgp6atcclAEaB+4MZchtXVxCsd+TGU4UBv5QJLETveErw4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676401; c=relaxed/simple;
	bh=TUNny1HvUeftZKLUoDkacQhlF4J6gUc6wrtk141dWvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khKLc+gH+99GvON0vvH2ztaEfRCIDtGMHgX5K6R3yrCINgc0BHt/S5sSCqD34pPkcOxVIHxlOBca5awE60/5GlEqkXQL1Yv0p9YHjsF+yZ9NVhk7Kl+u0P6/zb/aqgJlo49e6wIuQTP9lgTrt3+xZCDXIQ8tv8BlMOBMzV1UQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AAwv5aw+; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d2531294faso9704441fa.2
        for <linux-pci@vger.kernel.org>; Fri, 23 Feb 2024 00:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708676397; x=1709281197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RuXtCNYwsGpKXgRbUJ3unXSyq/4b1iF/r5Hh+ijkmfI=;
        b=AAwv5aw+os1H1u0oapgzqqOZT8HTSva6VCyff0pOa5DI0xaUgmbaCKe74X2qxvM+83
         Cb6wN5zxVdVi0PpmwLsXyuXmRAY/pb/DdRKIdj/FlEQOnHSEEqctimED2qOoNisnUyxo
         Jry4Bk4FFYDkDnt0PS5LoLcK7HdLIzcF9qkaxr80uDOEmQoGVvF3ZbHIj2TeLQNfE4rR
         J6gcuDedYGbJQ50NgGmBOEeOogJk1qchCxjvvOfLz3GEAoPryiTkp/oHURgp+exPca4J
         ACORYHI7FobFXkVcKzE0RZAohd/tP8JBxsjo+OTMs4s1USgg9Luv9hXEpnOQWQgJCJ6h
         pWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708676397; x=1709281197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuXtCNYwsGpKXgRbUJ3unXSyq/4b1iF/r5Hh+ijkmfI=;
        b=KyUpP4oTd9Z8rgZtG5736G6/JaaSL08Mod8xO/M0H+STOGIvoDj+D07iF/2LlM6YHo
         RHo+KPD+q+0XLbf0FPmB7BgksyAVp9x0TamvjLx2H7X+1xAH+7cTalfxy7deC8ICrICk
         KxoFm4XOryNhmdNjJoceggjtLJo1gVIEbEjDLBVFcPYZjgGNubpOS7RMNK5iZL2SxO9A
         vj2CNoQj9+eNq1wsb20AtovPgYyPEI6OVq++wL7toT+tly/7IhxfxOdAhjLQWulxOV/p
         pYiB5LxZk7caq4HGlq0XZJHNqigwV8U33Hp2voS+ujkrs2OJG93mZRPsExFNwpR1VCd0
         lhqA==
X-Forwarded-Encrypted: i=1; AJvYcCUPR3fikEpDCzZbbjLl5LnVPtkHHYkAl+dmHz0mJGAWE74IZhHjMwWbDLavuZaWcZ38czXlU60Cv+5A/Ew+ngC+JMUFl3fN1oHM
X-Gm-Message-State: AOJu0Ywk6WaS0pHAmcea2/pOrDuzoNACNRE/gkT1JR7AbRcoTYvmGTyO
	C1iSGqoCeFq5VRDGUwHZ4AmadAHrW44tp++SySb4WNHXGuZmGjeCk6NjoonrDgw=
X-Google-Smtp-Source: AGHT+IG3BQ8JqlqrAtOJFM04gbsnYyOURpj+vfRT2z52l3Z/d44ORUjRCHQO4AUweAm1jwyo0GRCjA==
X-Received: by 2002:a05:651c:1061:b0:2d2:313c:3c0 with SMTP id y1-20020a05651c106100b002d2313c03c0mr738681ljm.27.1708676396701;
        Fri, 23 Feb 2024 00:19:56 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id f16-20020a5d50d0000000b0033d449f5f65sm1890058wrt.4.2024.02.23.00.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:19:56 -0800 (PST)
Date: Fri, 23 Feb 2024 11:19:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
	jgg@ziepe.ca, kevin.tian@intel.com, dwmw2@infradead.org,
	will@kernel.org, lukas@wunner.de, yi.l.liu@intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 3/3] iommu/vt-d: improve ITE fault handling if target
 device isn't valid
Message-ID: <f779be97-66c2-4520-91f2-a9a54e84017c@moroto.mountain>
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
 <20240222090251.2849702-4-haifeng.zhao@linux.intel.com>
 <c655cd15-c883-483b-b698-b1b7ae360388@moroto.mountain>
 <2d1788da-521c-4531-a159-81d2fb801d6c@linux.intel.com>
 <039a19e5-d1ff-47ae-aa35-3347c08acc13@moroto.mountain>
 <31ee6660-ad4a-40b8-8503-ebc3ed06dd16@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31ee6660-ad4a-40b8-8503-ebc3ed06dd16@linux.intel.com>

On Fri, Feb 23, 2024 at 03:32:52PM +0800, Ethan Zhao wrote:
> On 2/23/2024 2:08 PM, Dan Carpenter wrote:
> > On Fri, Feb 23, 2024 at 10:29:28AM +0800, Ethan Zhao wrote:
> > > > > @@ -1326,6 +1336,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
> > > > >    			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
> > > > >    		} while (head != tail);
> > > > > +		/*
> > > > > +		 * If got ITE, we need to check if the sid of ITE is one of the
> > > > > +		 * current valid ATS invalidation target devices, if no, or the
> > > > > +		 * target device isn't presnet, don't try this request anymore.
> > > > > +		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
> > > > > +		 */
> > > > This comment is kind of confusing.
> > > Really confusing ? this is typo there, resnet-> "present"
> > > 
> > Reading this comment again, the part about zero ite_sid values is
> > actually useful, but what does "old" mean in "old VT-d device".  How old
> > is it?  One year old?
> 
> I recite the description from Intel VT-d spec here
> 
> "A value of 0 in this field indicates that this is an older version of DMA
> remapping hardware which does not provide additional details about
> the Invalidation Time-out Error"
> 

This is good.  Put that in the comment.  Otherwise it's not clear.  I
assumed "old" meant released or something.


> At least, the Intel VT-d spec 4.0 released 2022 June says the same thing.
> as to how old, I didn't find docs older than that, really out of my radar.
> 
> > 
> > > > /*
> > > >    * If we have an ITE, then we need to check whether the sid of the ITE
> > > >    * is in the rbtree (meaning it is probed and not released), and that
> > > >    * the PCI device is present.
> > > >    */
> > > > 
> > > > My comment is slightly shorter but I think it has the necessary
> > > > information.
> > > > 
> > > > > +		if (ite_sid) {
> > > > > +			dev = device_rbtree_find(iommu, ite_sid);
> > > > > +			if (!dev || !dev_is_pci(dev))
> > > > > +				return -ETIMEDOUT;
> > > > -ETIMEDOUT is weird.  The callers don't care which error code we return.
> > > > Change this to -ENODEV or something
> > > -ETIMEDOUT means prior ATS invalidation request hit timeout fault, and the
> > > caller really cares about the returned value.
> > > 
> > I don't really care about the return value and if you say it should be
> > -ETIMEDOUT, then you're the expert.  However, I don't see anything in
> > linux-next which cares about the return values except -EAGAIN.
> > This function is only called from qi_submit_sync() which checks for
> > -EAGAIN.  Then I did a git grep.
> > 
> > $ git grep qi_submit_sync
> > drivers/iommu/intel/dmar.c:int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
> > drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/iommu.h:int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
> > drivers/iommu/intel/iommu.h: * Options used in qi_submit_sync:
> > drivers/iommu/intel/irq_remapping.c:    return qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/pasid.c:    qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/svm.c:      qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
> > drivers/iommu/intel/svm.c:      qi_submit_sync(iommu, &desc, 1, 0);
> > drivers/iommu/intel/svm.c:              qi_submit_sync(iommu, &desc, 1, 0);
> > 
> > Only qi_flush_iec() in irq_remapping.c cares about the return.  Then I
> > traced those callers back and nothing cares about -ETIMEOUT.
> > 
> > Are you refering to patches that haven't ben merged yet?
> 
> Yes, patches under working, not the code running on your boxes.
> 
> -ETIMEOUT & -ENODEV, they both describe the error that is happenning, someone
> prefers -ETIMEOUT, they would like to know the request was timeout, and someone
> perfers -ENODEV, they know the target device is gone, ever existed.

Okay.  I obviously can't comment on patches that I haven't seen but,
sure, it sounds reasonable.

> 
> > > > > +			pdev = to_pci_dev(dev);
> > > > > +			if (!pci_device_is_present(pdev) &&
> > > > > +				ite_sid == pci_dev_id(pci_physfn(pdev)))
> > > > The && confused me, but then I realized that probably "ite_sid ==
> > > > pci_dev_id(pci_physfn(pdev))" is always true.  Can we delete that part?
> > > Here is the fault handling, just double confirm nothing else goes wrong --
> > > beyond the assumption.
> > > 
> > Basically for that to ever be != it would need some kind of memory
> > corruption?  I feel like in that situation, the more conservative thing
> > is to give up.  If the PCI device is not present then just give up.
> 
> memory corruption, buggy BIOS tables, faked request ...something out
> of imagination, after confirmed the device is what it claimed to be, if
> not present, then give up to retry the request.

This is not correct.  We looked up the device based on the ite_sid so
we know what the device id is, unless we experience catastrophic memory
corruption.

+                       dev = device_rbtree_find(iommu, ite_sid);
                                                        ^^^^^^^
We looked it up here.

+                       if (!dev || !dev_is_pci(dev))
+                               return -ETIMEDOUT;
+                       pdev = to_pci_dev(dev);
+                       if (!pci_device_is_present(pdev) &&
+                               ite_sid == pci_dev_id(pci_physfn(pdev)))
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Unless the device_rbtree_find() is returning garbage then these things
must be true.

+                               return -ETIMEDOUT;

I tried to double check how we were storing devices into the rbtree,
but then I discovered that the device_rbtree_find() doesn't exist in
linux-next and this patch breaks the build.

This is very frustrating thing.  But let's say a buggy BIOS could mess
up the rbtree.  In that situation, we would still want to change the &&
to an ||.  If the divice is not present and^W or the rbtree is corrupted
then return an error.  But don't do this.  If the memory is corrupted we
are already screwed and there is no way the system can really recover
in any reasonable way.

regards,
dan carpenter



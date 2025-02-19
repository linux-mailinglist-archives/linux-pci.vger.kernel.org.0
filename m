Return-Path: <linux-pci+bounces-21834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3F3A3C799
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 19:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6572189AAB5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6642B215779;
	Wed, 19 Feb 2025 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PmypkfxN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC64214A6E
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989775; cv=none; b=q8TgDDmpYwJkERxXovpZr8IPSSnpnbckAt6t7uvaPlSoksZyuK2FR2lJu0dBYlBCSyhaNdRN1ttrYOq0nmzzcHmD+tJYjbHOzBfhEQXqRMcu/cACTLiMTpUmFrixNfPR177o9lDFSdh14NQ2rNLRDRFSoLVt+ndfFG4wJXFkw1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989775; c=relaxed/simple;
	bh=hNvfVR0ZZ2UFjzAGnYJWeJC+N+Q90ykly/lra30oclk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdxK5+ml/2ACQpCCdn/3+CvWRnacHRQiTVae76lUxqepEokJM1YBWGFEIG6Ul+xPWQgQvUs1xNS2aN4E/Fuzjo2IMlf/rwp0ebllC5V1geRqT0GfWWDgOa0Tu6z/fSewkovM//SE1YJbuF/z1W4N4+8dbOz0iF4otVRZQSts4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PmypkfxN; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7be3f230436so5116785a.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 10:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739989772; x=1740594572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tKMJ3X6Jzp+wNnNxZ3cTu3f1diCv42/eMEvkIcSBFc4=;
        b=PmypkfxNzF+1Ps74JyQib0woINIH5uY8g24xF+LDigxh14LIjFyLE4tKpMD43Pz3GO
         MCBNVELcQ9qeJ+GlKdR7zSCCGPr5akM/moSmVRLGvpsA3lIROeti2Jl9tXfBJjTItK2c
         yYlpknRMhmSE3bcZl9cojpPBNKSOi05sL9qzJqVAxnCzwH/w6Eg81YPgtoHaXrEVyOLH
         RjsUJ3bO6J01LTuSmO2En+JrIvAWh9IuI6FvwT+9z1E/9lMuv0FO08vAjWaH5cdSmKHX
         SB4tUgyMVmlq2LuYol7f5Mo4ZcjHP+FdRq9UMqrZw9INshSXW5yUndjpcLxwQXQMMVhe
         oV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739989772; x=1740594572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKMJ3X6Jzp+wNnNxZ3cTu3f1diCv42/eMEvkIcSBFc4=;
        b=kRKJ+VldeSRs0LDZd60XS6uDuxbR536bHWvGcBvRyqm/tLKh2jqxIbAa7kb6NALnX6
         LHwxFq4FmYws0yWtrT1ExvNOrdKaf7fPXGoDBhsi3By1GJZrdrc8KSQBC7bL1z6QX9uV
         s/gHapkilQixBsIQTy32GvOTlgSdyzAbT07pUfcwB2ADrta6ZvDP+sbH/mrcnp5bSVMH
         3/Mu5gQhu+tZh8HXxeclsxSI1e00RS7USMeiQNmxUW1Wq4xJz6sM8lT8+r5oR7rl+KzA
         nBgO97KnQhqm6vq5w1xc3tHH874urb2UlLcMUhUT25JC/Xblckig0rKC0mRlgob0+D7K
         EtPw==
X-Forwarded-Encrypted: i=1; AJvYcCXN0CwsGbCfN9wAg+VQOf+lj4ximuajJvhqE2/BWHq9FHprCLONoLdy4HSdJVfOmuFW1Q8eZFOBm9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQw0UMijmGbYxeafSmjaOQkVbedvmvJXoDqm4bTt6xMLGD83j
	sZpk3/5aWR7Vz7l1+DAv2zXU3EGr4aGqtGC2bS8LlF4ymJIo28U6c9WNgfUvzfo=
X-Gm-Gg: ASbGnctvavzbQOvgVIAAed9007Bg+4en/XQFMDBP3KTnlFAFU50P6bVZJPSt9uKNIZH
	NN35nd1ZGO9eqDgkTjHrN90zQYkL/mavK2wQnrOqZbFz3U5X37cRAzSRLHiJsMC7iIXwWelpy9U
	woG/DosYYlF3+qW2nbbki8jHhtSLJIwLyTsXPmSqbuEFBpm/0Jt2pIjmkcrtk9h0h1tEeWTCNL4
	qfictrkB/ZP6ETvRbkSnibmLdObMWJgnwZQ0khGfXElyTdwsv4Yb0biFIsz4Dk7ePv0R+VX6iGi
	oIJ6jWJLavITKNL8MkWQs6zJPVNZDHd2dC3iGZ7/ITXk6U8J4b389gi4sN8B9BmH
X-Google-Smtp-Source: AGHT+IG6vD9GMzJFRgKV5tkVvAkzSXjZzf3sKuYbia/+L+uYcxerEW/IEbYH+D0NjcMpo2cEEaQ1ow==
X-Received: by 2002:a05:620a:1787:b0:7be:5bc1:9460 with SMTP id af79cd13be357-7c08aa9ab2dmr2845829285a.35.1739989765100;
        Wed, 19 Feb 2025 10:29:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a609cb1bsm303023085a.111.2025.02.19.10.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:29:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkop2-000000009V2-07PN;
	Wed, 19 Feb 2025 14:29:24 -0400
Date: Wed, 19 Feb 2025 14:29:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH 2/2] iommu: Get DT/ACPI parsing into the proper probe path
Message-ID: <20250219182924.GN3696814@ziepe.ca>
References: <cover.1739486121.git.robin.murphy@arm.com>
 <c2f0ae276fd5a18e1653bae8bb0c51670e35b283.1739486121.git.robin.murphy@arm.com>
 <20250214201435.GF3696814@ziepe.ca>
 <4a7823b2-2634-4148-8446-ad01a09b6880@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a7823b2-2634-4148-8446-ad01a09b6880@arm.com>

On Mon, Feb 17, 2025 at 03:00:46PM +0000, Robin Murphy wrote:
> On 14/02/2025 8:14 pm, Jason Gunthorpe wrote:
> > On Thu, Feb 13, 2025 at 11:49:00PM +0000, Robin Murphy wrote:
> > 
> > > much just calling the same path twice. At client driver probe time,
> > > dev->driver is obviously set; conversely at device_add(), or a
> > > subsequent bus_iommu_probe(), any device waiting for an IOMMU really
> > 
> > Could you put the dev->driver test into iommu_device_use_default_domain()?
> > 
> > It looks like many of the cases are just guarding that call.
> > 
> > > should *not* have a driver already, so we can use that as a condition to
> > > disambiguate the two cases, and avoid recursing back into the IOMMU core
> > > at the wrong times.
> > 
> > Which sounds like this:
> > 
> > > +		mutex_unlock(&iommu_probe_device_lock);
> > > +		dev->bus->dma_configure(dev);
> > > +		mutex_lock(&iommu_probe_device_lock);
> > > +	}
> > 
> > Shouldn't call iommu_device_use_default_domain() ?
> 
> Semantically it shouldn't really be called at this stage, but it won't be
> anyway since "to_<x>_driver(NULL)->driver_managed_dma" is not false -
> trouble is it's also not true ;)

That case in PCI I understood, but the other cases seemed like they
would be OK, especially if group is NULL

> > This is the test I mean, if iommu_group is set then
> > dev->iommu->iommu_dev->ops is supposed to be valid too. It seems like
> > it should be done earlier..
> 
> Yeah, looking at it now I'm really not sure why this ended up in this order
> - I guess I was effectively adding the dma_configure() call to the front of
> the existing iommu_fwspec_ops() check, and then I moved the lockdep_assert()
> up to make more sense. But then the ops check probably should have been
> after the group check to begin with, for much the same reasoning as above.
> I'll sort that out for v2.

I guess check it at the top and then check it again after re-locking.

> > > +	 * And if we do now see any replay calls, they would indicate someone
> > > +	 * misusing the dma_configure path outside bus code.
> > > +	 */
> > > +	if (dev_iommu_fwspec_get(dev) && dev->driver)
> > > +		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
> > 
> > WARN_ON_ONCE or dump_stack() to get the stack trace out?
> 
> Indeed, hence dev_WARN() (!= dev_warn())

Oh, I've never seen that variation before!

Jason


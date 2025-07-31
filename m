Return-Path: <linux-pci+bounces-33233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 771D1B170EA
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 14:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9288E58604C
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 12:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ADD22A7EF;
	Thu, 31 Jul 2025 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AKd/qGQk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092861E32BE
	for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753963899; cv=none; b=SLgTZu9Vc/ux6P6ED6xMwJe5JTins+4obqQf+u2EDe6gO7ydhW8lITmq1FgiJzBkl025s/sF7CrBpWM1/q5yl4JCy9PbjJmpPmIkiUlbUT43YEzwbNd59C06M2xtfUfigPTCj3NsOFT718l44Am/FrupNDUDv9NzpIN3pGdJaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753963899; c=relaxed/simple;
	bh=S1wXea6GSEkJsxBK8lGgS5pwcy7cCkvMsy6PmRLU7EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWWiYk36uISvq2JMWOEHpkpF/j2zV8JgksskZlyZaCnN9+W8L4ohnOYb75FVxmMwHMlolmzPhYL9ligTad2yzDQXh4vmmARDytptEDjokI82sDACBDYMukvWB7HSNsSsbE2iNWMaub6jz9eb2pi+XYotJyjhcYvXDWVWNFcTgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AKd/qGQk; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7073075c767so4242176d6.3
        for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753963895; x=1754568695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6GiA2tw+gwtAnjFcFPQpD5ne+ingC66pFHpYZpZzeYY=;
        b=AKd/qGQkrW7llFLuy8w6v46LybV1HsN2BzpFEcDfLnUnzvRugDxTeNQxZhpTw0dgRt
         73qcuHnZzyXM8iG98NgzCBpneeqm6MZ6Rxb3marhpnHxp9b5uP1N07BLIiE1FW47Cc2+
         JfD7dvroX5zjrb8gNk1Dr75gG6Cjy69CWqfqBNtY31luS93sVMyDK5BmGm+nGdJ2PLzE
         PCw9MC9xws0Zf2zmVQq4CODt11ZIQHK1igoSNKFpoP6MPlhEiQXogPiUzqTdJvscRS9j
         aWeYTpok9+aNo3ruTuze7VJ/IbDpF8kJ+iKLwqc/twJvwOwfzCUuFS9G8P31/oHkTlLl
         ZMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753963895; x=1754568695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GiA2tw+gwtAnjFcFPQpD5ne+ingC66pFHpYZpZzeYY=;
        b=eQROenOF4g85DPopyLBnT9NHXZ5wnEq+8tGmNuq8JsYlWpEahSi1gkdC5WquGEff7B
         pOV76n23imqVf/z0nofy2BJ5d99t/Q/cR6+1bYRFP/RoAbGVga5kjaJDwnzUHw+8xd0G
         gk9YSXIq6Q6REiqc1qcC0d83KwTJJU1T7sRusAQIriVoy3RbSxqn0XDDbDkGP7H4ZY11
         5IvZdcaG3io0diJK4iNs/e5tJeK/anVqTZPj3iq8FMnN3oNzT8WhJbokLVujTCdDGvvU
         7hyv/xzbf4pB6hzcNSl3zk8VrL8HdlK0h5AWhQrW94cg30Fi2hxsHGhg94uvdknyAK62
         KgEw==
X-Forwarded-Encrypted: i=1; AJvYcCX85FACNzIwoKOqudvk73ZnvY12liN2Iigcd0Jj6bhLWpg3BBuncGA57hKM/3JvnjluFQIw9xFTfPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfgDPV8jPSB36x5A7CTk/mCloQfdAPmuWev3AZLMzKSu7xOxNv
	V8ipqeDXYwsQ3q6yZ6KPrzsJkT9mtkilKXck9fIMEZShjMkC+WhfktVd5hatK15lbNY=
X-Gm-Gg: ASbGnctEKSNFNwvsUxRImhmaRzUivYPu8biPCdf2aUsRo20VvpaGJSNyOLHJgKj9tTh
	0G87/c4LvtMQ4SmWtsBeZ/s4gFY29WTPftS9luoZ4JleU5dqdYeS+1EHsKbiWPoxV696KdC/3tt
	BzfdY1+7Mi4V1OzhMcHJrrFv7KForGLeXbXHuuM23J9GDVKA7UzNNN/fBslQOxjtR++cofEvQCZ
	VZgewNCNyqmP/ze8qhWtcaLAQEuSpsxv7ZM9mXS26ZFdjNFHreazsbv3HIpqEdvfgfJINVIe9T1
	iYOoynv8Q4mSnia2dLKj/HgC3Y6OjkCdoxafaJ7t5DiyurEeLy4+QLNlxrz4VUbg/SJO03M12VG
	zzFQcKUYyctold+H02bysPgYMjakm7jkkSlgtaiiFPzC3GPwqD/lQwnvKg3schmcW5s2INCfpXw
	v2uiQ=
X-Google-Smtp-Source: AGHT+IHjUvGatsM+Nj0UuwSVsL9Oyl4RA08oAzeUsK3Cyb+xVgspshhI3seh3MnRe0x10Mxp0AXXeA==
X-Received: by 2002:a05:6214:4118:b0:706:fa53:9d4f with SMTP id 6a1803df08f44-70766dc979fmr80279936d6.3.1753963894472;
        Thu, 31 Jul 2025 05:11:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cea1782sm6330876d6.93.2025.07.31.05.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:11:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhS8D-00000000oUc-0rT4;
	Thu, 31 Jul 2025 09:11:33 -0300
Date: Thu, 31 Jul 2025 09:11:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, gregkh@linuxfounation.org
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
Message-ID: <20250731121133.GP26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730113827.000032b8@huawei.com>

On Wed, Jul 30, 2025 at 11:38:27AM +0100, Jonathan Cameron wrote:
> On Wed, 30 Jul 2025 14:12:26 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> wrote:
> 
> > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > 
> > > On Tue, Jul 29, 2025 at 06:10:45PM +0100, Jonathan Cameron wrote:
> > >  
> > >> > +static struct platform_device cca_host_dev = {  
> > >> Hmm. Greg is getting increasingly (and correctly in my view) grumpy with
> > >> platform devices being registered with no underlying resources etc as glue
> > >> layers.  Maybe some of that will come later.  
> > >
> > > Is faux_device a better choice? I admit to not knowing entirely what
> > > it is for..
> 
> I'll go with a cautious yes to faux_device. This case of a glue device
> with no resources and no reason to be on a particular bus was definitely
> the intent but I'm not 100% sure without trying it that we don't run
> into any problems.
> 
> Not that many examples yet, but cpuidle-psci.c looks like a vaguely similar
> case to this one.  
> 
> All it really does is move the location of the device and
> smash together the device registration with probe/remove.
> That means the device disappears if probe() fails, which is cleaner
> in many ways than leaving a pointless stub behind.
> 
> Maybe it isn't appropriate it if is actually useful to rmmod/modprobe the
> driver. 

Yeah, exactly. Can a TSM driver even be modular? If it has to be built
in then there is no reason to do this:

> > The goal is to have tsm class device to be parented by the platform
> > device.

IMHO the only real point of that is to trigger module autoloading.

Otherwise the tsm core should accept NULL as the parent pointer during
registration, it probably already does..

Jason


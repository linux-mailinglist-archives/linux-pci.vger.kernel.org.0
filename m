Return-Path: <linux-pci+bounces-33176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8307FB1607A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 14:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B558C18C7011
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 12:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151C32874F2;
	Wed, 30 Jul 2025 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="K2QgADKq"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112A4239E70;
	Wed, 30 Jul 2025 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879291; cv=none; b=Zkt8QpUlK1sFw9LHLdWWZh90/sZ5QBxJZwnuqpbX2lFyD3wpC7VEY9pMP3GEmho3sq1hj5TMu2NeVbyT2xSLSXEqMRb4mIgINfFkssK4Y+YW8jHpEpf68vayGcH/WVRK2PxdxqX5WTo9vQgonSDEj2XnDFwzeZA//Q9K5jqjwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879291; c=relaxed/simple;
	bh=hSKWeK4jIQ3ltENJO1Y4xgSkz64IbO0gBUihPvo7dgA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vm/Cdb59N1nFzaPjkGJbSUARPhbJBbUWKIc5EIjIQb248+++7k2TKfsUj9iTN/icLNXrViqFwl3RP6XGl0ieRm5Mw2vi42crfle8nnCjQIlGVxbFTIGK7zW+xi2wqeXQUVhFA0ICDpi/EwR9bwzP03nOM2I2TEwqSpV9gBMnNhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=K2QgADKq; arc=none smtp.client-ip=119.8.177.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CjzPqR7WdKZ/KoF+pD8LVi/4ga/Gs/KbgPgLLPosQEs=;
	b=K2QgADKq9tMmsmbfL4rl638FrPpN4nk5oYriQPy859Lg55Xy9BhLrO0d+wSVdUfNgEIXOYzWB
	0hEqfMggEl7S+FOdkgzd1fS3H25j/wl4lKPlTH2doy5B52ArJKCOcNdcQU7HjaretVdz/i9Z+7p
	SukiSAmVspurrK57xq/tuaI=
Received: from frasgout.his.huawei.com (unknown [172.18.146.37])
	by sinmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4bsWYR5Npdz1vp4j;
	Wed, 30 Jul 2025 20:22:03 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsWVL6psBz6L4xm;
	Wed, 30 Jul 2025 20:19:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C96351402F3;
	Wed, 30 Jul 2025 20:23:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 14:23:34 +0200
Date: Wed, 30 Jul 2025 13:23:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven
 Price <steven.price@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc
 Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm
 platform device
Message-ID: <20250730132333.00006fbf@huawei.com>
In-Reply-To: <20250730113827.000032b8@huawei.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-12-aneesh.kumar@kernel.org>
	<20250729181045.0000100b@huawei.com>
	<20250729231948.GJ26511@ziepe.ca>
	<yq5aqzxy9ij1.fsf@kernel.org>
	<20250730113827.000032b8@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Jul 2025 11:38:27 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

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
> 
> +CC Greg on basis I may have wrong end of the stick ;)
This time with at least one less typo in Greg's email address.

> 
> > >
> > > But alternatively, why do we need a dummy "hw" struct device at all?
> > > Typically a subsystem like TSM should be structured to create its own
> > > struct devices..
> > >
> > > I would expect this to just call 'register tsm' ?
> > >    
> > 
> > The goal is to have tsm class device to be parented by the platform
> > device.  
> 
> > 
> > # ls -al
> > total 0
> > drwxr-xr-x    2 root     root             0 Jan 13 06:07 .
> > drwxr-xr-x   23 root     root             0 Jan  1 00:00 ..
> > lrwxrwxrwx    1 root     root             0 Jan 13 06:07 tsm0 -> ../../devices/platform/arm-rmi-dev/tsm/tsm0
> > # pwd
> > /sys/class/tsm
> > 
> > -aneesh
> >   
> 
> 



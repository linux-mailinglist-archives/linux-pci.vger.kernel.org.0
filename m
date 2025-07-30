Return-Path: <linux-pci+bounces-33169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF901B15E55
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 12:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA89F3B3A64
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 10:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F27B26FDB6;
	Wed, 30 Jul 2025 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jt6RaZC7"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D322318;
	Wed, 30 Jul 2025 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871919; cv=none; b=NgZbsvBVdNzi4ACcINAQAQHzCob6SZnWL9Ba6bDiZaoZnxYe3T28OBluPN+n3Nty5pTeN5EzVA7dXaSPjKbWXQgyGe8XVEKbrwBS1Cur8NOPYgCUUWPvI6U2rJZ1icaMGD6lnb1Eiabwj+wEEoEb/3G0WskyUOr4wT4vn9+y3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871919; c=relaxed/simple;
	bh=a1bFVUSJNuMaRBg/bFJOzqjeINTdV1R6gNaDS47j1+4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CreBKhGttmNP3EzNkxLgT4nXVqTzOwidPxqwZO3vhLt2SDks9dJf9a43i9kQcoWgiAG0avdve7Vxrdrsvt/iSSXT8rS2YAWVRqAgL2k3aFd/3qdrj+Dfika64qDq1aiq2y1vlqnjOJnlaxChJh3xoPz7vtcARfIpCBCVAChLM58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jt6RaZC7; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gLqk2qxCFUARFWqQEVNpkMZmoZM/0ZAoR38yaf9PwTU=;
	b=jt6RaZC7kIjJyJMVlCOtACitLf8JL40ho9fTX8wMm/KMbpSmLAopP6PA1ORQpfIJgUqiyEf58
	awdwdE0ECUeLW8vBz8YHG9RExOffdJhGEVtH7xnC/HBrmcYxVQKbOGujrZX6y9il/BzciNFEiOa
	3FtP7EJ/5/BiFiJHq0atJT4=
Received: from frasgout.his.huawei.com (unknown [172.18.146.35])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4bsTDD75dnzMljM;
	Wed, 30 Jul 2025 18:37:00 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsTD636jqz6H8Rn;
	Wed, 30 Jul 2025 18:36:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 370CA1402F3;
	Wed, 30 Jul 2025 18:38:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 12:38:29 +0200
Date: Wed, 30 Jul 2025 11:38:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven
 Price <steven.price@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc
 Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, <gregkh@linuxfounation.org>
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm
 platform device
Message-ID: <20250730113827.000032b8@huawei.com>
In-Reply-To: <yq5aqzxy9ij1.fsf@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-12-aneesh.kumar@kernel.org>
	<20250729181045.0000100b@huawei.com>
	<20250729231948.GJ26511@ziepe.ca>
	<yq5aqzxy9ij1.fsf@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Jul 2025 14:12:26 +0530
"Aneesh Kumar K.V" <aneesh.kumar@kernel.org> wrote:

> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Tue, Jul 29, 2025 at 06:10:45PM +0100, Jonathan Cameron wrote:
> >  
> >> > +static struct platform_device cca_host_dev = {  
> >> Hmm. Greg is getting increasingly (and correctly in my view) grumpy with
> >> platform devices being registered with no underlying resources etc as glue
> >> layers.  Maybe some of that will come later.  
> >
> > Is faux_device a better choice? I admit to not knowing entirely what
> > it is for..

I'll go with a cautious yes to faux_device. This case of a glue device
with no resources and no reason to be on a particular bus was definitely
the intent but I'm not 100% sure without trying it that we don't run
into any problems.

Not that many examples yet, but cpuidle-psci.c looks like a vaguely similar
case to this one.  

All it really does is move the location of the device and
smash together the device registration with probe/remove.
That means the device disappears if probe() fails, which is cleaner
in many ways than leaving a pointless stub behind.

Maybe it isn't appropriate it if is actually useful to rmmod/modprobe the
driver. 

+CC Greg on basis I may have wrong end of the stick ;)

> >
> > But alternatively, why do we need a dummy "hw" struct device at all?
> > Typically a subsystem like TSM should be structured to create its own
> > struct devices..
> >
> > I would expect this to just call 'register tsm' ?
> >  
> 
> The goal is to have tsm class device to be parented by the platform
> device.

> 
> # ls -al
> total 0
> drwxr-xr-x    2 root     root             0 Jan 13 06:07 .
> drwxr-xr-x   23 root     root             0 Jan  1 00:00 ..
> lrwxrwxrwx    1 root     root             0 Jan 13 06:07 tsm0 -> ../../devices/platform/arm-rmi-dev/tsm/tsm0
> # pwd
> /sys/class/tsm
> 
> -aneesh
> 



Return-Path: <linux-pci+bounces-14966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6AD9A9633
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 04:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B7AAB2175D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 02:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F6E1EB31;
	Tue, 22 Oct 2024 02:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Rz8gYN0g"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FE712FF9C
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563713; cv=none; b=COW9IhA6PsMnnwGONzx1jHKD1SlcARVkDxQftnYLs0GEW3xJCkhKFH/CaJel2YVm5u1oroFvW2zZpSrHyRsK8QW7oTajnorHv+sjVWxoyHdC/Nb+EcgC1hcjPs05N9U3aY5aHUDyAS2qQHzFZMV/SdONnlF9idQrlxRCXTUZYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563713; c=relaxed/simple;
	bh=UakvcDz641vDh5tkQynLPjIuTfPRbUkFjde93YGjako=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U94OuQMXeINPpeyuJZ8i6Le1OvUcGqOKWezBvQsa9d5ZdnoKGSPqd/+qPP5OL34eRJpgM5zNDI9No8SD1jFvnqJ4YbEwRxUD3lWHS4XiFbi3lTF0KE2WEUJIcCd1ISWZDOyVwy4BrnVLf9NrxaBRAH2GTN5XmWQfEK5jBKzLads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Rz8gYN0g; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729563707; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oMMrk2hyn5xmSfP1Vj/5TY3D5MtejSBs1Jctu1cP2i8=;
	b=Rz8gYN0gn0SDD+ZpL8We9ND2cVz2ED9Oe78cOV3DDGo0JrIA5Zu+g0bmXn1cLHvSxzJ17z8GjDYb7SL+50PHVgLrVegLXA1XPAJS2ETc/kfoV4AO8FwUv6XU7lYFVD7OLLnLP1kt0PJdicPGibB8T62Kewer5UBrt4DUHuUB1iE=
Received: from 30.178.82.41(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHgEUFA_1729563706 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Oct 2024 10:21:47 +0800
Message-ID: <ece5af0f-4512-4119-90d8-faa3af5bb4ef@linux.alibaba.com>
Date: Tue, 22 Oct 2024 10:21:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] PCI: optimize proc sequential file read
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
 linux-pci@vger.kernel.org
References: <20241018222213.GA764583@bhelgaas>
 <757d1cda-875b-4135-8b3e-110154a9543e@linux.alibaba.com>
 <2024102148-helium-elk-b100@gregkh>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <2024102148-helium-elk-b100@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/10/21 19:04, Greg KH 写道:
> On Mon, Oct 21, 2024 at 10:04:03AM +0800, Guixin Liu wrote:
>>> This proc interface feels inherently racy.  We keep track of the
>>> current item (n) in a struct seq_file, but I don't think there's
>>> anything to prevent a pci_dev hot-add or -remove between calls to
>>> pci_seq_start().
>> Yes, maybe lost some information this time.
>>> Is the proc interface the only place to get this information?  If
>>> there's a way to get it from sysfs, maybe that is better and we don't
>>> need to spend effort optimizing the less-desirable path?
>> This is the situation I encountered: in scenarios of rapid container
>>
>> scaling, when a container is started, it executes lscpu to traverse
>>
>> the /proc/bus/pci/devices file, or the container process directly
>>
>> traverses this file. When many containers are being started at once,
>>
>> it causes numerous containers to wait due to the locks on the klist
>>
>> used for traversing pci_dev, which greatly reduces the efficiency of
>>
>> container scaling and also causes other CPUs to become unresponsive.
>>
>>
>> User-space programs, including Docker, are clients that we cannot easily
>> modify.
>>
>> Therefore, I attempted to accelerate pci_seq_start() within the kernel.
>>
>> This indeed resulted in the need for more code to maintain, as we must
>>
>> ensure both fast access and ordering. Initially, I considered directly
>>
>> modifying the klist in the driver base module, but such changes would
>>
>> impact other drivers as well.
> I am not opposed to any driver core changes where we iterate over lists
> of objects on a bus, but usually that's not a real "hot path" that
> matters.  Also, you need to keep the lists in a specific order, which I
> do not think an xarray will do very well (or at least not the last time
> I looked at it, I could be wrong.)
>
> I understand your need to want to make 'lspci' faster, but by default,
> 'lspci' does not access the proc files, I thought it went through sysfs.
> Why not just fix the userspace tool instead if that's the real issue?
>
> Just because you can modify the kernel, doesn't mean you should, often
> the better solution is to fix userspace from doing something dumb, and
> if it is doing something dumb, then let it and have it deal with the
> consequences :)
>
> thanks,
>
> greg k-h

Actually, lscpu may access PCI proc files and could potentially iterate 
three times.

You can see this in the lscpu source code within the function

lscpu_read_virtualization()->has_pci_device(). We've previously 
optimized it to

combine those three iterations into one, as reflected in this PR:

https://github.com/util-linux/util-linux/pull/3177.


Additionally, many of our clients’ tools and programs also access PCI proc

files, but we are not allowed to modify that part; they do not provide us

with the source code. Clients tend to perceive that the kernel performance

we provide is subpar(That's why we have stopped giving 'lscpu' direct 
access to sysfs).

We have already implemented such optimizations in our operating system and

achieved significant performance benefits. If this patch can be accepted 
into

the community, it would be great for more people to benefit from it.

Best Regards,

Guixin Liu




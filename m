Return-Path: <linux-pci+bounces-25625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B71A84196
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 13:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2219E475A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 11:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70732836A5;
	Thu, 10 Apr 2025 11:19:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6ACF8210F53;
	Thu, 10 Apr 2025 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283974; cv=none; b=k+ChDi6TkB3wTtKYS6H6IQLLFn3mtbNEtQ61Xmug/6D5hbOz3+rLICBh6IAM4Mfo62TID/X/fIwfZf04M1NB/kFiLiNYz8Uhq+9bX/M2o9blZe12GmHADqe03m6Gwolbp63FOydZNRUW4YxGQYc3F/kR+9ka8hwxQ/aEx4/EOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283974; c=relaxed/simple;
	bh=OqmBd5UpR5yv56v4G7LNpC/RAu44u1ax067TpUGFo/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=CgqoLFM9N/lQItbvjSvm5juN2HqNiigxLE32hqCZgwv9DxWsbM868Crld9p0sUSAZb1Xqtu0cL++jhbe0WuGhNHaK9C4keBtEJ2HlfS82YxR5+RA6c9iS1mzRKKmQ5bVru9Bt+59C8s7fWkDHXwygD68+3C6C+YZbMnjrLlyXy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 1E3E8604DE322;
	Thu, 10 Apr 2025 19:19:18 +0800 (CST)
Message-ID: <4a967093-97e2-401f-a0ea-9d7447d518c4@nfschina.com>
Date: Thu, 10 Apr 2025 19:19:17 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "PCI: Fix reference leak in
 pci_register_host_bridge()"
Content-Language: en-US
To: Xiangwei Li <liwei728@huawei.com>
Cc: linux-kernel@vger.kernel.org, make24@iscas.ac.cn, bhelgaas@google.com,
 linux-pci@vger.kernel.org, bobo.shaobowang@huawei.com,
 wangxiongfeng2@huawei.com
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <20250410032842.246396-1-liwei728@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/4/10 11:28, Xiangwei Li wrote:
> This reverts commit 804443c1f27883926de94c849d91f5b7d7d696e9.
>
> The newly added logic incorrectly sets bus_registered to true even when
> device_register returns an error, this is incorrect.
>
> When device_register fails, there is no need to release the reference count,
I think you missed some thing about device_register(). This patch is wrong.

device_register()
     -> device_initialize()
               -> kobject_init()
                     -> kobject_init_internal()
                         -> kref_init(&kobj->kref);  //set 
kref->refcount to 1
                            ^^^^^^^^^^^^^^^^^^^^^

device_register() only  fails when device_add() fails, and 
kerf->refcount can be 1
at this time ,  so we need to call put_deivce() to release  memory.
> and there are no direct error-handling operations following its execution.
>
> Therefore, this patch is meaningless and should be reverted.
>
> Fixes: 804443c1f278 ("PCI: Fix reference leak in pci_register_host_bridge()")
> Signed-off-by: Xiangwei Li <liwei728@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>


Return-Path: <linux-pci+bounces-1264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1DB81B496
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 12:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3D128607F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 11:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362CA6BB21;
	Thu, 21 Dec 2023 11:02:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C216BB59;
	Thu, 21 Dec 2023 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 552F92F4;
	Thu, 21 Dec 2023 03:02:52 -0800 (PST)
Received: from [10.57.85.225] (unknown [10.57.85.225])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1CB93F5A1;
	Thu, 21 Dec 2023 03:02:05 -0800 (PST)
Message-ID: <6f49be01-89e3-4407-9813-51d62e723947@arm.com>
Date: Thu, 21 Dec 2023 11:01:56 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
To: Lukas Wunner <lukas@wunner.de>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
 baolu.lu@linux.intel.com, dwmw2@infradead.org, will@kernel.org,
 linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Haorong Ye <yehaorong@bytedance.com>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
 <20231213104417.GA31964@wunner.de>
 <3b7742c4-bbae-4a78-a5a6-30df936a17d4@arm.com>
 <20231221104254.GB12714@wunner.de>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231221104254.GB12714@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-21 10:42 am, Lukas Wunner wrote:
> On Wed, Dec 13, 2023 at 11:54:05AM +0000, Robin Murphy wrote:
>> I think if we want to ensure ATCs are invalidated on hot-unplug we need an
>> additional pre-removal notifier to take care of that, and that step would
>> then want to distinguish between an orderly removal where cleaning up is
>> somewhat meaningful, and a surprise removal where it definitely isn't.
> 
> Even if a user starts the process for orderly removal, the device may be
> surprise-removed *during* that process.  So we cannot assume that the
> device is actually accessible if orderly removal has been initiated.
> If the form factor supports surprise removal, the device may be gone
> at any time.

Sure, whatever we do there's always going to be some unavoidable 
time-of-check-to-time-of-use race window so we can never guarantee that 
sending a request to the device will succeed. I was just making the 
point that if we *have* already detected a surprise removal, then 
cleaning up its leftover driver model state should still generate a 
BUS_NOTIFY_REMOVE_DEVICE call, but in that case we can know there's no 
point trying to send any requests to the device that's already gone.

Thanks,
Robin.


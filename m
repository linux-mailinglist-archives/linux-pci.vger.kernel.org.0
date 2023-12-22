Return-Path: <linux-pci+bounces-1280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 291DD81C361
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 04:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA029287CF2
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 03:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F75AEDF;
	Fri, 22 Dec 2023 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kR7GdQSK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F878F49;
	Fri, 22 Dec 2023 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703215225; x=1734751225;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zwvJZipX1RTKD4/apP3DQT5aXdl1Ua3N+TL6Z4LeVts=;
  b=kR7GdQSKpDF9xKZp+Zp6qw2mcy2fbJAu/7b4G2nsYCFhZUQDKV2A0RJ/
   cQPV12uSzzk57ggl/Azb+vD0TawyaHDpefVsgl7xmA80q+jvxYKURGnQg
   rmN20ryA9ut6bLjYn067LAvErK0TFUJfcd8lqOoL+ElfZyrnCpKl92U9q
   j/NZrQmOIJMzIw9rmHWVTwxK9dpLyD5QSoVwZmZYu1kHwq7SzYfcenQtY
   Yz+e9tSiZFCprUXfM7P8iqKxGolEPvpBXwBnPcPuOaJnAKVkVucZ3IFhN
   2Fo7uIliMUOmzsAYw2MC1s7UB2i7wUewf3Ghxu4oBL7VTIojFxtKEijP2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3307293"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="3307293"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 19:20:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="805820544"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="805820544"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.36]) ([10.93.26.36])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 19:20:20 -0800
Message-ID: <589b2dbc-325b-404f-a387-b1c99a064d15@linux.intel.com>
Date: Fri, 22 Dec 2023 11:20:18 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
To: Lukas Wunner <lukas@wunner.de>, Robin Murphy <robin.murphy@arm.com>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Haorong Ye <yehaorong@bytedance.com>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
 <20231213104417.GA31964@wunner.de>
 <3b7742c4-bbae-4a78-a5a6-30df936a17d4@arm.com>
 <20231221104254.GB12714@wunner.de>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20231221104254.GB12714@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/21/2023 6:42 PM, Lukas Wunner wrote:
> On Wed, Dec 13, 2023 at 11:54:05AM +0000, Robin Murphy wrote:
>> I think if we want to ensure ATCs are invalidated on hot-unplug we need an
>> additional pre-removal notifier to take care of that, and that step would
>> then want to distinguish between an orderly removal where cleaning up is
>> somewhat meaningful, and a surprise removal where it definitely isn't.
> Even if a user starts the process for orderly removal, the device may be
> surprise-removed *during* that process.  So we cannot assume that the
> device is actually accessible if orderly removal has been initiated.
> If the form factor supports surprise removal, the device may be gone

There is no hardware lock to prevent user powerring-off/removing

the supprise-removal capable device before issuing ATS invalidation

request but after checking device connection state, the no target

request still possibly be sent.


Thanks,

Ethan

> at any time.
>
> Thanks,
>
> Lukas
>


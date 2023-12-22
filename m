Return-Path: <linux-pci+bounces-1278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D29781C301
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 03:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE44288052
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 02:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64292A5D;
	Fri, 22 Dec 2023 02:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+XQnHno"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17167A53;
	Fri, 22 Dec 2023 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703210911; x=1734746911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DSVSCWBNbZmmn4RDurqEzwZcdKkAE1nXmdh2D3wt+wc=;
  b=X+XQnHnoS3GzII8s7/ab8R8YSjkhiWR//VIOtnacHk2nhOldpDEHnx5W
   ZYCrxXsNn/FOX5QbGQ+06LJwPkxlQvhclpxoIcjQnLnZztrfuowOm539d
   2qMqrpkIQfFwNoWWpYQxCDGAOcVw2JCrbkpiucfKMJW3obj/Q+5p0gk6L
   h4ILJb1g42xwWJxygWYAZcvuqlQg0xVGVQqW8j0/lAA2zkQeepk/mGVJx
   7FtF3OkmNpwEOzMjV51Rv+n7ORJQs9S4k3Vdk930khf225wyflKZeF/yh
   BaOrBEBknOBfEipbL71U1NrEQeiPWImS7E/7A3QRcxu8kiXt76wiKRxw9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="460396356"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="460396356"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 18:08:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="753131359"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="753131359"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.36]) ([10.93.26.36])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 18:08:27 -0800
Message-ID: <8fbd1a86-1ef5-4679-a4d9-b4faee2eda64@linux.intel.com>
Date: Fri, 22 Dec 2023 10:08:24 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231220005153.3984502-1-haifeng.zhao@linux.intel.com>
 <20231220005153.3984502-3-haifeng.zhao@linux.intel.com>
 <20231221103940.GA12714@wunner.de> <20231221110138.GA27755@wunner.de>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20231221110138.GA27755@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/21/2023 7:01 PM, Lukas Wunner wrote:
> On Thu, Dec 21, 2023 at 11:39:40AM +0100, Lukas Wunner wrote:
>> On Tue, Dec 19, 2023 at 07:51:53PM -0500, Ethan Zhao wrote:
>>> For those endpoint devices connect to system via hotplug capable ports,
>>> users could request a warm reset to the device by flapping device's link
>>> through setting the slot's link control register, as pciehpt_ist() DLLSC
>>> interrupt sequence response, pciehp will unload the device driver and
>>> then power it off. thus cause an IOMMU devTLB flush request for device to
>>> be sent and a long time completion/timeout waiting in interrupt context.
>> I think the problem is in the "waiting in interrupt context".
> I'm wondering whether Intel IOMMUs possibly have a (perhaps undocumented)
> capability to reduce the Invalidate Completion Timeout to a sane value?
> Could you check whether that's supported?

It is not about Intel vt-d's capability per my understanding, it is the 
third

party PCIe switch's capability, they are not aware of  ATS transation at 
all,

if its downstream port endpoint device is removed/powered-off/link-down,

it couldn't feedback the upstream iommu a fault/completion/timeout for

ATS transaction breakage reason.  While the root port could (verified).

>
> Granted, the Implementation Note you've pointed to allows 1 sec + 50%,
  1 min (60 sec)+50%
> but that's not even a "must", it's a "should".  So devices are free to

I could happen if blindly wait here, so we should avoid such case.


Thanks,

Ethan

> take even longer.  We have to cut off at *some* point.
>
> Thanks,
>
> Lukas


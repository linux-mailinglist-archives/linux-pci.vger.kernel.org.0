Return-Path: <linux-pci+bounces-1543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A378381FE93
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 10:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84BA5B20CD1
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADB61096C;
	Fri, 29 Dec 2023 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZ932hBb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6938110A00;
	Fri, 29 Dec 2023 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703841877; x=1735377877;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6eyA6I/IA06zG3oVXU054nozNu51dK0BuoClY9Ax83c=;
  b=cZ932hBb1BOhdSUp3sXeQOHKmSERypV755ey1Qv2fPDoo3aKaMhRljYd
   rHqOKIYXkVKoIZhe4aJbAkdlOcuzHrYnsAppNJYe99moK+e9E4QkCLSGh
   SjccqHHnikekaMVMFXx468kSUrr7by9+3CaqgR4qgOCRAIigMnNsZ851c
   H2j03GX9nq4wWyfi47z0om6jsJ8w5jJ0l2suSe2gz4bLzOoftTb9s/sXB
   SABAyPiN2avw2XyfBDvrQRZIC4Qdl7tDUdTdFTbm25BcjvbfRJ7xnBjP1
   nCFg004nLbvdWLbKccT4zWEJPlhsf3LR+2uK6qxhiv42UJ5WT4od0mGBj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="399414616"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="399414616"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 01:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="13238090"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.117]) ([10.93.26.117])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 01:24:34 -0800
Message-ID: <b1ac7e4c-e59f-43c8-a914-415a511beccc@linux.intel.com>
Date: Fri, 29 Dec 2023 17:24:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 5/5] iommu/vt-d: don't loop for timeout ATS
 Invalidation request forever
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "lukas@wunner.de" <lukas@wunner.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231228001646.587653-1-haifeng.zhao@linux.intel.com>
 <20231228001646.587653-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB527651C1A108721CFF057BCF8C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bb3a8a4c-6dad-4347-9076-0f28d1e23de3@linux.intel.com>
 <BN9PR11MB5276E70591021395F1ED90D28C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <BN9PR11MB5276E70591021395F1ED90D28C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/29/2023 4:17 PM, Tian, Kevin wrote:
>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> Sent: Thursday, December 28, 2023 9:10 PM
>>
>> On 12/28/2023 4:38 PM, Tian, Kevin wrote:
>>>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>>>> Sent: Thursday, December 28, 2023 8:17 AM
>>>>
>>>>
>>>> -	if (rc == -EAGAIN)
>>>> +	if (rc == -EAGAIN && type !=QI_DIOTLB_TYPE && type !=
>>>> QI_DEIOTLB_TYPE)
>>>>    		goto restart;
>>>>
>>> this change is moot.
>>>
>>> -EAGAIN is set only when hardware detects a ATS invalidation completion
>>> timeout in qi_check_fault(). so above just essentially kills the restart logic.
>> This change is intended to break the restar login when device-TLB
>>
>> invalidation timeout happens, we don't know how long the ITE took
>>
>> if the device is just no reponse.
> if in the end the agreement is to remove the restart logic, then do it.
>
> it's not good to introduce a change which essentially kills the restart
> logic but still keeps the related code.

Here, the device-TLB invalidation, depends on devcies response,

no one could make sure the what the third party adapters will act.

but for those invalidation issued to iommu itself, should be more

likely to survive ?

Anyway, would like to see more comments.


Thanks,

Ethan



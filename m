Return-Path: <linux-pci+bounces-1544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0F181FEB0
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 10:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A57DB20D44
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC4010A18;
	Fri, 29 Dec 2023 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABdgmjKW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632210A01;
	Fri, 29 Dec 2023 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703842136; x=1735378136;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fCPGi4wYrtRpwAnUyry4tOS8qG9qYsY1PjjUZyEwZvI=;
  b=ABdgmjKW6y6CSsJIMgtycW6ICicIOI1dpCNjPkqAexLX6CiWmza1yD2m
   0K7Iat1MZpJjp6/Iru800SKlUppKci0qJUdfvjiJJGoz59XpGQ//Nr2Nh
   NtBE5pIkHHJ29u9VvYfegfIJED/abwVXJ1LehmiUVmsWv5FQwBVeIRosK
   i6XYo6Ne4JlQzWrsKqWpyF6AGd91xjAqmdxbApVI/079D7ODmwBMJQI8M
   FcfcazLjU2+Xl8yr87tWSsoPPOqN/DaIMrEqXihRADxL/DCO0q2L68cqy
   SBqgS6pFgaknlrcSPLcttksJMFFNNkdoRN7YqJoSvfE3C7Z5h/HXT886R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="460951865"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="460951865"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 01:28:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="849175048"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="849175048"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.117]) ([10.93.26.117])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 01:28:52 -0800
Message-ID: <9c10b57e-bdc3-4cfa-944d-21f5bcf2f4f2@linux.intel.com>
Date: Fri, 29 Dec 2023 17:28:50 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 0/5] fix vt-d hard lockup when hotplug ATS capable
 device
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
References: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
 <BN9PR11MB527685C387DDD5FA4B189B3C8C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <BN9PR11MB527685C387DDD5FA4B189B3C8C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/29/2023 4:18 PM, Tian, Kevin wrote:
>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> Sent: Friday, December 29, 2023 1:02 AM
>>
>> change log:
>> v10:
>> - refactor qi_submit_sync() and its callers to get pci_dev instance, as
>>    Kevin pointed out add target_flush_dev to iommu is not right.
> let's not rush for new versions when there are still opens unclosed in
> previous one (and considering most related folks are in vacation).

Just have some hours these days to make it in well shape.

Okay, let's think, and wait for new comments.


Thanks,

Ethan



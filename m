Return-Path: <linux-pci+bounces-1984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBB482955B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 09:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950D21F264BB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E24381D2;
	Wed, 10 Jan 2024 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxEaITTX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D7B3B187;
	Wed, 10 Jan 2024 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704876474; x=1736412474;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hje+oh1f6Ond+bPDUXiY/R1MUpvhv24EHAttcOoZil0=;
  b=IxEaITTXmNKg8KXA6ofNVnG0Kp1ZCF2vqN1av2ejyM1IENDpyJ2U8uk6
   qdSIPFzkQhGK9sYJ8GlPGW92q9gDu8Cxhjw0GDlQIoJv4zc1vbF60CY2J
   2uQQel7qla/r/ZURoeS0+aqVIM15r1W44otNI68BdQ991vieYELlAmMKH
   nrOHO1IU7UKM+/HEbtCJh9D1FQ9SQlZOsH6y1b1Jgvi2C7Wy73h57sQnb
   DAIiZzArMvTpI/CrXryws7k9NLj2nYqBjRKN8g4kTXgKA5MngviZMEY/s
   N8mGp2C8uBVSQLJPWxWmEk5ZuIJ1u6ZzrNHqU5cBzelMaEmdKE58RY8j1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5539065"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5539065"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 00:47:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1113378098"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="1113378098"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.11.157]) ([10.93.11.157])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 00:47:48 -0800
Message-ID: <f8a7c91d-5d46-4ba0-95ad-d07ab81efd75@linux.intel.com>
Date: Wed, 10 Jan 2024 16:47:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 3/5] PCI: make pci_dev_is_disconnected() helper
 public for other drivers
To: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
 bhelgaas@google.com, dwmw2@infradead.org, will@kernel.org,
 robin.murphy@arm.com, lukas@wunner.de
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231228170504.720794-1-haifeng.zhao@linux.intel.com>
 <8250acd8-4013-487d-9b31-102334ff316a@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <8250acd8-4013-487d-9b31-102334ff316a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/10/2024 1:25 PM, Baolu Lu wrote:
> On 12/29/23 1:05 AM, Ethan Zhao wrote:
>> Make pci_dev_is_disconnected() public so that it can be called from
>> Intel VT-d driver to quickly fix/workaround the surprise removal
>> unplug hang issue for those ATS capable devices on PCIe switch 
>> downstream
>> hotplug capable ports.
>>
>> Beside pci_device_is_present() function, this one has no config space
>> space access, so is light enough to optimize the normal pure surprise
>> removal and safe removal flow.
>>
>> Tested-by: Haorong Ye<yehaorong@bytedance.com>
>> Signed-off-by: Ethan Zhao<haifeng.zhao@linux.intel.com>
>> ---
>>   drivers/pci/pci.h   | 5 -----
>>   include/linux/pci.h | 5 +++++
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> This should be moved before PATCH 2/5? Otherwise, PATCH 2/5 couldn't be

Seems the order was mixed when send-email was abort by network connection

and sent again.

[3/5] &[4/5]  goes to upset.  though the subject order is right.

anyway will resend in next version.


Thanks,

Ethan

> compiled.
>
> Best regards,
> baolu


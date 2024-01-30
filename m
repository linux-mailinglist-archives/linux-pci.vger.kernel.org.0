Return-Path: <linux-pci+bounces-2756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A761841B69
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 06:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DFD1F24E69
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 05:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A4C381B8;
	Tue, 30 Jan 2024 05:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQkwIiIq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAD381AA;
	Tue, 30 Jan 2024 05:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706592363; cv=none; b=kvme2pA/fH4Ry/i4fkr+fp01sMrHCCPtnEqrEbmIMSoN4D7IFnokZxV5HgbSR1NP8gX1elKomIuXVIn2iSEs7Guol5rhziouXnufg7tXTe1WSOSpu7SK0D1LHpcGMnbkt3LXo/NVE/Fwyi/EORRxnzueufSNzy/nDgAq3QVVmtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706592363; c=relaxed/simple;
	bh=vjtakvY70G3Id+ynUb/AKoj3dsosmWFYfLGhqV8vgI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InRoqsOToJw3PjSeoF7TS+gv1revckSwudFA7pQSHkkma+8xSp9etFo718At3BA2l0Vw7lVb3hyv6WnSxItT+2f6Ig7ybUag7q3lx6xpVJdVLR0OQBpKLlxRzFiDG542/wpkI1mDGOsKU2szXdJ71Aj0athv+7pRC2JHNhI04QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQkwIiIq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706592362; x=1738128362;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vjtakvY70G3Id+ynUb/AKoj3dsosmWFYfLGhqV8vgI0=;
  b=bQkwIiIqqtc0n1VB+3EoJ0uEHwg1FKF6lNtznd6Ddw0v4dikGQU5+2nZ
   1qdQQbxcpL3DW8OPaHrpoDOyQU26/P0Zmu70LJS9vt0184dmfoosinD9P
   pk28BQce6/bzySDkE9V13QwoHxTfgsovWjnK+8BJIveS3hjm9NpUs1Wkx
   khbt3VvVJSg/0YMPCPKQES6dM/Z1AxO3SEQf0A6V6iqtcMh/WujCfBB0w
   y1/JJDGhmZ10REusa8sa+7Vter6zjyg68/Cbk1azPqncf6Ru4hMVvFL6/
   ctNmrn5zARfKdmLseFLfhz8MQlLxmX5LQv+9lMXADQbWCwITPPxzXiyR/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3033147"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3033147"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 21:26:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="22324254"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.238.130.190]) ([10.238.130.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 21:25:57 -0800
Message-ID: <67f6d362-845a-44d7-b4f5-f7d589bc5300@linux.intel.com>
Date: Tue, 30 Jan 2024 13:25:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/5] PCI: make pci_dev_is_disconnected() helper public
 for other drivers
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "will@kernel.org" <will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haorong Ye <yehaorong@bytedance.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-2-haifeng.zhao@linux.intel.com>
 <BN9PR11MB5276B0ADF497AEE3D990824A8C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <BN9PR11MB5276B0ADF497AEE3D990824A8C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/29/2024 4:50 PM, Tian, Kevin wrote:
>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> Sent: Monday, January 29, 2024 11:49 AM
>>
>> Make pci_dev_is_disconnected() public so that it can be called from
>> Intel VT-d driver to quickly fix/workaround the surprise removal
>> unplug hang issue for those ATS capable devices on PCIe switch downstream
>> hotplug capable ports.
>>
>> Beside pci_device_is_present() function, this one has no config space
> s/Beside/Unlike/
>
>> space access, so is light enough to optimize the normal pure surprise
>> removal and safe removal flow.
> somehow this paragraph belongs to the patch using it. The 1st paragraph
> is sufficient for the reason of exposure.

pci_device_is_present() is aleardy exported symbol, why not just use it ?

Also try to make it clear, the difference and justification.


Thanks,
Ethan



Return-Path: <linux-pci+bounces-2755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D75841B64
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 06:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBD628A7F0
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 05:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399C23771E;
	Tue, 30 Jan 2024 05:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnZBm0kw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74B381AB;
	Tue, 30 Jan 2024 05:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706592192; cv=none; b=kdzzHtFUlH3nQK7tDFONnGNLJm0gXvCpRbTu5ZhImkHym/G+ZwgY4F1SwUxE8jEMGB+3H/Yncb/trmZc+Wz2388CNHzknxZZ4oJAsyE1gCJySyZjqLRLaUq2taeR9w0N/cJBDfhiWuMj0H7HQlvF1TlaT7QYtbQj/QgjYzWyFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706592192; c=relaxed/simple;
	bh=2chnDtx7fC/xK0UK9k7nOkhmZ+WTIJOelHVHg2jjY5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2Tc8wa6AXxvRsTEwHAeTl8+EP39lhovGpPbgFIOQtCS0QcuofJTvaFv9jM2CcY2dI/I46rQ0E+rapLzE54MZpAt1zIUDvYJWI7XRSgsHgAvpwm+jk4nIM9KuKgjk+EISF9IpuZsVvDNoQpyYTTE3xMWgduSV9byzJMwdpXpgMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnZBm0kw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706592190; x=1738128190;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2chnDtx7fC/xK0UK9k7nOkhmZ+WTIJOelHVHg2jjY5I=;
  b=nnZBm0kwI57oJFXABhnxKd2tONYOyOYq4CvJZJY6BO3uZP+e74pdOeMt
   joLJVQcitipcNSBRHCIY54IGHzh2EoDzPPadW6KWwsgFwEyo224Uz0ksz
   9evpynKd8L+4x6wb0tDK41MzPpHuHtW3uyarqILe+J2cuogJJvZnZorj/
   dIy0XfqxRqXFSZ4M/ij4og8YL222ZvjAluHae4qzrX6rIyLjvi2OXf4FL
   bEmTuQ9VL2k4IIEjGDXKKWXXaxMpYsCa/7WLX1DCKzsggDL5oZqltVCLD
   kH7o817iK54WpFogRtCbX4QadVnR5eUo+qylZEGrxwybbrz05goAhwCLH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="9813240"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="9813240"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 21:23:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3545275"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.238.130.190]) ([10.238.130.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 21:23:07 -0800
Message-ID: <bd317a41-a8c9-4029-9ec6-9076fa5aad92@linux.intel.com>
Date: Tue, 30 Jan 2024 13:23:04 +0800
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

Beside means 'comparing with' here, perhaps it is not clear enough

or there is syntax error if used here ?



Thanks,

Ethan

>
>> space access, so is light enough to optimize the normal pure surprise
>> removal and safe removal flow.
> somehow this paragraph belongs to the patch using it. The 1st paragraph
> is sufficient for the reason of exposure.


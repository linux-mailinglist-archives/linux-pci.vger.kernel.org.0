Return-Path: <linux-pci+bounces-1282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D633181C3B2
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 04:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3571F25969
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 03:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F276184C;
	Fri, 22 Dec 2023 03:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aRdWCV88"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D806A6132;
	Fri, 22 Dec 2023 03:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703217397; x=1734753397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o7QSLUEbtgt1NDLSckikpa9KW0RO6SIhmgcDLdrx9To=;
  b=aRdWCV88/gnSN0wNudTrT4wjogy+FjjHhayo+tcWJf6Z2Eqb2SBlHk2D
   AOimk6SKHY3ncUd2iAwcI7X9tsDMuQN+0bzw7IDqHiYVXd8vzHuBJ2x1w
   ADvcqv8ly/8kWUHPa9TP+FuxVWdcUJEKrLkHgWKMBhqEygd6WLE/jhXAc
   oBTevF0Vc91gkFTJf6AgS2NOf4+zkH+cVfqyPscznMxszweWInhr1DBB0
   9G0SCE8CUz2oOob1rki3cMjAAWtDmCNbdKTMSciJIBeZy+lG6s3ZrHSYG
   aRHbLty//0dzt4qDZSEwOVZ7rL+Y4tjYrOP1Z6AaXsBKhdMblw2TTBSnk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="462510410"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="462510410"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 19:56:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="1108339667"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="1108339667"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.36]) ([10.93.26.36])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 19:56:34 -0800
Message-ID: <02619a5c-842c-4441-85cb-0f7151705a5d@linux.intel.com>
Date: Fri, 22 Dec 2023 11:56:31 +0800
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
>
> Granted, the Implementation Note you've pointed to allows 1 sec + 50%,
> but that's not even a "must", it's a "should".  So devices are free to
> take even longer.  We have to cut off at *some* point.

I really "expected" there is interrrupt signal to iommu hardware when

the PCIe swtich downstream device 'gone', or some internal polling

/heartbeating the endpoint device for ATS breaking,

but so far seems there are only hotplug interrupts to downstream

control.

...

How to define the point "some" msec to timeout while software

break out the waiting loop ?  or polling if the target is gone ?


Thanks,

Ethan



>
> Thanks,
>
> Lukas


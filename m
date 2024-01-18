Return-Path: <linux-pci+bounces-2305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 575D8831165
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 03:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E832D1F22BFC
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 02:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DA533D3;
	Thu, 18 Jan 2024 02:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbA6c1Ez"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811605395;
	Thu, 18 Jan 2024 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705544781; cv=none; b=Kz+JNSZ0/B2QyuFNBJS/UNeT2qaQWPtd/gCAObqWRa5OofJYnH2VhpaWQAe0sl/6zUDke1rVqnvKEmg+QcPBVMQVky7MQ9sfLf1QDYCb/d3qMP9Ij0f6e4INAuqJTiok4W6EfgVgdnoGXGJ0lUYBzb+6bi11qZHFpqdI6z8gwUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705544781; c=relaxed/simple;
	bh=5Bw7dRRUpNawFEvYMYeCuZvjZQTPeDem38vHl1yuut8=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=QTht0o+eS8vmlW/KUucJZ4i6vwcxeWaLHUfD/NndIs5zNQJHqe4NrZRFPGlIB+5v6sxCtYuM7UUGA5XrdYGgS9xe/Xq77rT6xA3IpFQ6fTAi6tk4vDV25qA5aBypg+duly1gzIyk/IheVKRh5H3I+tvzH9FLP8Ys/a3gi9qsTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbA6c1Ez; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705544781; x=1737080781;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5Bw7dRRUpNawFEvYMYeCuZvjZQTPeDem38vHl1yuut8=;
  b=LbA6c1Ezu0JEaItnNUq8W7kB6myyuREYsUwShHI/0QxquHBTT3dGP8c6
   XKDGEKPQbEwEcaw5X2cTIZXdL9tEHsTAl4RQmclutlGd29HvTLwlml5yk
   vXWtxzd5rTpIYfkJO94+CtYIDUbvOZwbqldz0T/NGEqf6khqLfPnenTXg
   78sH2mpHSkszSWGqjSIWCoirGLOkDmVlb0cUMmHq73t+/C1qfr7+/EtpL
   o3B+3cNyxldzCrcb8lA/mPs6ZCq337ACKZSvRaA1IQs/zPHId8e9uX67w
   arlazk51hNwW7/DAZW3OOKrjucMBvWrAoSkA1afFJTgzFAvgkQn8Tds5A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7701020"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7701020"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 18:26:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="874947974"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="874947974"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.254.215.192]) ([10.254.215.192])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 18:26:16 -0800
Message-ID: <9cc2010f-269c-4d23-b284-6fe4162f8810@linux.intel.com>
Date: Thu, 18 Jan 2024 10:26:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 0/5] fix vt-d hard lockup when hotplug ATS capable
 device
To: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
 bhelgaas@google.com, dwmw2@infradead.org, will@kernel.org,
 robin.murphy@arm.com, lukas@wunner.de
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
 <1a2a4069-c737-4a3c-a2f6-cce06823331b@linux.intel.com>
 <3ee904e9-8a93-4bd9-8df7-6294885589e4@linux.intel.com>
 <42f7848a-0262-4871-b5dc-0e87beebfd11@linux.intel.com>
 <dcd27bc8-5eca-41ae-bb86-fd8e657ccfed@linux.intel.com>
 <d72d0a12-f3a4-4b4d-8b3b-5e59937a21d3@linux.intel.com>
 <5a9c38ec-1dc2-40d3-99eb-02b87be660a6@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <5a9c38ec-1dc2-40d3-99eb-02b87be660a6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/18/2024 8:46 AM, Baolu Lu wrote:
> On 1/17/24 5:00 PM, Ethan Zhao wrote:
>> +       /*
>> +        * If the ATS invalidation target device is gone this moment 
>> (surprise
>> +        * removed, died, no response) don't try this request again. 
>> this
>> +        * request will not get valid result anymore. but the request 
>> was
>> +        * already submitted to hardware and we predict to get a ITE in
>> +        * followed batch of request, if so, it will get handled then.
>> +        */
>> +       if (target_pdev && !pci_device_is_present(target_pdev))
>> +               return -EINVAL;
>
> Again, we should not ignore the error triggered by the current request.
> Do not leave it to the next one. The WAIT descriptor is a fence. Handle
> everything within its boundary.

  We didn't set fence bit to every ATS invalidation wait descriptor,

only the intel_drain_pasid_prq() queue a drain page requests with FN

sit, but that is not called in hotplug removal path.


Thanks,

Ethan



>
> Best regards,
> baolu


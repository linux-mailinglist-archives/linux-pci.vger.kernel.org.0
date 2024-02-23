Return-Path: <linux-pci+bounces-3911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE323860B5E
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 08:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F63B22C80
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4574D1171E;
	Fri, 23 Feb 2024 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFgCtHd3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD298134D1;
	Fri, 23 Feb 2024 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708673728; cv=none; b=W8IJIcbvqyl8ewkZ73vI/SFQe42dB17I2MTPH8eOh0E8LUFtOea8PqQyS0dQiiFxf0asvRjZAf8ZjnGvOuH15n/Tt6q1wwFb7zUhPqzAe+AWsvaC8Xiw9gvd1a5e7d6m2kJivjgzyXJ8Mkdm/qRT6eKXNWS+tPfvCQEt6nnotuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708673728; c=relaxed/simple;
	bh=eBnTWhjdcjzGBQGM4lj/0XFmDSyQvrKqnnc7evSd3sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onYoiq/ey6pHFa33+t/tBh3mUEENX5CGKXxaF9iKfoFNxV8svSnbZmcjW4PvS+o7+/NdEwD0yAx3+LCZc0D1F9ct36Q2Kyj5liw/tuk8QHG1GjWDhoYdlJjv6OhPtgaSY7AmH1PkvqAWNqy4voeBE8Hz69irPgKRhgK0XHTBn2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFgCtHd3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708673727; x=1740209727;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eBnTWhjdcjzGBQGM4lj/0XFmDSyQvrKqnnc7evSd3sk=;
  b=IFgCtHd3EYv/t5XQdcDaJI11Dg75gjMZzPi8/a9VfBO6/FtGlJl7yKle
   vaMhga0n8MKBWvG4fO+sknRotVAVkEXLpCVnMIfXpNu+qk9MxUUl1Tt5F
   eTQxGr/FxCnvmYlun9Rt8ZseD2NyltRNLabg/5ExQSmpB/jnS89iVDN+h
   tcHpoW9w4eH3XFepTcTDY5mrf2TwzCe0KHS8Go8V1iBXXfjG6lU1YkFhi
   D5TngbwpH6F7knQY1opATdDiK2ltu82bULf9lY9ctMU6JokpuTesHW+hi
   KWnwgxrDETShdrPVE+BavqsKgpEJ/VjCFBpnzwpzat8sx78jr2gP1zEVT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6760655"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6760655"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 23:35:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5833025"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.255.30.59]) ([10.255.30.59])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 23:35:20 -0800
Message-ID: <c241efc5-9baf-4069-8fe5-d156fd281601@linux.intel.com>
Date: Fri, 23 Feb 2024 15:35:16 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/3] PCI: make pci_dev_is_disconnected() helper public
 for other drivers
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Baolu Lu <baolu.lu@linux.intel.com>
Cc: bhelgaas@google.com, robin.murphy@arm.com, jgg@ziepe.ca,
 kevin.tian@intel.com, dwmw2@infradead.org, will@kernel.org, lukas@wunner.de,
 yi.l.liu@intel.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, Haorong Ye <yehaorong@bytedance.com>
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
 <20240222090251.2849702-2-haifeng.zhao@linux.intel.com>
 <9c4637d5-6496-4c68-b2db-4be1e56ca746@linux.intel.com>
 <88915639-b6cc-43f7-9ac7-8e2dde982757@moroto.mountain>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <88915639-b6cc-43f7-9ac7-8e2dde982757@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/23/2024 2:47 PM, Dan Carpenter wrote:
> I'm not a PCI maintainer, but first two patches seem good to me.  For
> the third patch, my complaints were really minor.  Let's just add a
> Fixes tag for sure, the rest is okay.
>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks Dan.

>
> regards,
> dan carpenter
>


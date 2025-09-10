Return-Path: <linux-pci+bounces-35837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAADB51EDD
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 19:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5801B27469
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B983277B8;
	Wed, 10 Sep 2025 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSDCH3Pv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E880327A03;
	Wed, 10 Sep 2025 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525218; cv=none; b=SiAmnUh5cT8rqJ4MiwBdXg5KSADvLDn8QUG/J8g7UC7csoJFytL4j9K9I4L4ghI8LL6w0xtTYCDkpNvUBDKExdd4qANbkjk6uunKSkljiJDyoP0ZMvdl5y66u1Yp8wRzco/YKGfboB7xwfDpXQcTGuVJXvlg+D+7xoXM8iySJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525218; c=relaxed/simple;
	bh=VLEnz8T/xKPJiUeITjefR9pqPNUwdIGHAeC4WN78Rjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smi9ewMYOSJHIfL4bFqrLZUq9ciiupMFH+Iy8Kk47KnNp7uf9N1UzJYAz/cTvZekgYJ4W7hM5oCCo5sxNwM8+NQaQp9Aqfl4SknS+4q3bOiSy0ygSF+Lm1QoLKeRaToS/qOrftbpfYsm/DBBbcxrAjOuJwqfgZqTOJP6Y/D/eS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSDCH3Pv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757525216; x=1789061216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VLEnz8T/xKPJiUeITjefR9pqPNUwdIGHAeC4WN78Rjg=;
  b=DSDCH3Pv7TPfEiyLmVFB6cFu0/agJnpzQnjbVIUi9+m14iX8S2VGEIcD
   mG+z4ZrAEgTg6VkKaIf0fyNjJHhFNX4rjdXOjFuMSRpe/SWYbLFPfqfmf
   jjLtml38lckI88P4/H0fsdic14o0rC302E0053hgjYDKWVwx5rCfGaJe2
   9ibEFr9/fLrQec7tSzH7Oc2/zfqZFKCcbz6LJx2+EfTtX9IE1SmUaIdq7
   AAW+lpjp8iUdMOoh7t7BwVppEbFDqNF8dlcUW1dMrLSK5P5tHqMyEAywc
   BtAwSb0GcqaxTffaIc57AxlAmDVBfWH7MW3qCJ5oleSl+m418GR/t4y4u
   A==;
X-CSE-ConnectionGUID: it7TFVUzRu+fQR4fDIpWpA==
X-CSE-MsgGUID: zZVGyhFUTSGfu5FNWCK/LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="58886745"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="58886745"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 10:26:56 -0700
X-CSE-ConnectionGUID: 4IZZ7PCMTRasyYdluzHq2Q==
X-CSE-MsgGUID: rfMYjKdPTxap3/X6RS6DJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="174263345"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.110.219]) ([10.125.110.219])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 10:26:54 -0700
Message-ID: <289a86f6-d305-468f-b33f-8301bc546c3a@intel.com>
Date: Wed, 10 Sep 2025 10:26:53 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/23] CXL/AER: Introduce rch_aer.c into AER driver
 for handling CXL RCH errors
To: "Bowman, Terry" <terry.bowman@amd.com>, Lukas Wunner <lukas@wunner.de>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dan.j.williams@intel.com,
 bhelgaas@google.com, shiju.jose@huawei.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-7-terry.bowman@amd.com>
 <9e01d94c-7990-4599-9eee-ac0f337d6e2d@intel.com> <aLFnKbWtacLUsjAi@wunner.de>
 <d7d395e1-b5f2-4897-a6f0-4d503e0fcb66@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <d7d395e1-b5f2-4897-a6f0-4d503e0fcb66@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/10/25 10:01 AM, Bowman, Terry wrote:
> 
> 
> On 8/29/2025 3:39 AM, Lukas Wunner wrote:
>> On Thu, Aug 28, 2025 at 01:53:35PM -0700, Dave Jiang wrote:
>>> On 8/26/25 6:35 PM, Terry Bowman wrote:
>>>>  drivers/cxl/Kconfig        |   9 +++-
>>>>  drivers/cxl/core/ras.c     |   3 ++
>>>>  drivers/pci/pci.h          |  20 +++++++
>>>>  drivers/pci/pcie/Makefile  |   1 +
>>>>  drivers/pci/pcie/aer.c     | 108 +++----------------------------------
>>>>  drivers/pci/pcie/rch_aer.c |  99 ++++++++++++++++++++++++++++++++++
>>> I wonder if this should be cxl_rch_aer.c to be clear that it's cxl
>>> related code.
>> I'd prefer an "aer_" prefix at the beginning of filenames,
>> but maybe that's just me...
>>
>> Thanks,
>>
>> Lukas
> You guys let me know what to rename it to. I'm fine with either 
> change: cxl_rch_aer.c or aer_cxl_rch.c.

I'll defer to Lukas since this is in drivers/pci.

DJ

> 
> We also have the VH analog of this file currently named pcie/cxl_aer.c. 
> This is introduced in patch 17, CXL/AER: 
> 'Introduce cxl_aer.c into AER driver for forwarding CXL errors'.
> 
> We may need to make similar change to the VH file name as well to 
> be consistent.
> 
> Regards,
> Terry



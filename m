Return-Path: <linux-pci+bounces-5643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDAF897CF9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 02:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0375928DAA4
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 00:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07DA647;
	Thu,  4 Apr 2024 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNk0s02C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E837E;
	Thu,  4 Apr 2024 00:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189963; cv=none; b=f+7TX2qfYSvNFjnr8WJfd4jo9Lx1Ebo6yPT1ubrREmiosJWV/6KUs2KBiFGR+gM1ZPjFp1xizpmWD/iD+xzrIUJYyjYjMufFBDO3/utNu7h1zh7gesAJMK1iO/BF6GG3NIDM4ld0W25gK2n4RcIm/NSQscPv+02cKZ3MmlVF1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189963; c=relaxed/simple;
	bh=4nErTsXLF3f1A4dpb/io9Y8zNiDT/BT8J02PjoHYHKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPo0A31IWPeBEZ42WMccACdWmawd2SF/q4i2NCWYdsqmt8Rglb2FCO6m2J+gWmugYXej15pTUxvzzY+aH7pJzonzf/BwTIfvAvA9f8CL4CfXfFJ40yTdSo1OyHMk4LKpIkHPgOPaS8jR4GmiKySEdsJ+DhmBN/QJDo10Xw/yZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNk0s02C; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712189961; x=1743725961;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4nErTsXLF3f1A4dpb/io9Y8zNiDT/BT8J02PjoHYHKQ=;
  b=dNk0s02C3cSXAnCRDdXbDht1dU1R+6fJQndDBfun/D40sgum+V1D7lLy
   QwWivyHpf0QqYbPtcIvh/CVpapyf6ux21pFHoUF2bQ9jTXTIPPcSsmKVP
   fBDN5ME0WF/FAZPoyw85YHzQDIeHqQ1RtPAMOePlM5DdhXWq5pVwywRdQ
   D3TsyVupP9Db4rDqg4Vb1k1BDCPMYXQ/0c8cbJS8bF892N8M+Atzz5UCU
   j0raEwGVUNMiyvPezUtqzTRIZydtV3lWoiA7fZb/wMzNlqroYAdwiobkl
   K0JPsl1Vw7s/2U6UZSLEBu7A+Zdg8qVMLUL9+An8kKb4jUCImlPDEz4Ra
   A==;
X-CSE-ConnectionGUID: wS7racpqTPK3KjUQUhhn1Q==
X-CSE-MsgGUID: siVzhCWSRdqLrvIqQii/PA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7568333"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7568333"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 17:19:20 -0700
X-CSE-ConnectionGUID: FGmd87A4QcSRWrYXbPzzWA==
X-CSE-MsgGUID: W34hMiZBRrS5xt9D3JjExA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="23104491"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.162.81]) ([10.213.162.81])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 17:19:18 -0700
Message-ID: <8d8fb4e5-0fec-4dbd-9452-fdeae2c395d1@intel.com>
Date: Wed, 3 Apr 2024 17:19:18 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] PCI: Add check for CXL Secondary Bus Reset
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 bhelgaas@google.com
References: <20240402234848.3287160-1-dave.jiang@intel.com>
 <20240402234848.3287160-3-dave.jiang@intel.com> <Zg0SwGmelNpY__5f@wunner.de>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Zg0SwGmelNpY__5f@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/3/24 1:26 AM, Lukas Wunner wrote:
> On Tue, Apr 02, 2024 at 04:45:30PM -0700, Dave Jiang wrote:
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4927,10 +4927,55 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>>  }
>>  
>> +static int cxl_port_dvsec(struct pci_dev *dev)
>> +{
>> +	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>> +					 PCI_DVSEC_CXL_PORT);
>> +}
> 
> Hm, seems a bit odd that this returns an int even though
> pci_find_dvsec_capability() returns a u16 and all the callers
> of cxl_port_dvsec() seem to assign the return value to a u16
> as well.  Is the "int" on purpose?

Should be u16. Oversight. Thanks.
> 
> Thanks,
> 
> Lukas


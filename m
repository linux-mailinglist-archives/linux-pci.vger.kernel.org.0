Return-Path: <linux-pci+bounces-4805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1689887B809
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 07:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE22D1F221C5
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 06:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94544A05;
	Thu, 14 Mar 2024 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHYM2GFc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1134A03
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710398761; cv=none; b=XzE9zij1c+YipKOgrRshttNCseWsP5xGLO+4HX7fRKvZX3ajfNOJN5/qMinUB7okkO30fIHUFiOsYv5e94btvMkY8xcikhNfx1fIAzZ73v3LX7s2sqyeUKfghmxBJusjFxtSqy929UFQaJDee3L/9H31pzsxG7wIXZ4JYWLmKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710398761; c=relaxed/simple;
	bh=3akQJ45fbBJ5/c7Zkgj7O+fa4NlNR24ywtRjPw4TmvE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RienedVfLier2JtbD5yjw4sGp3q/vLPJ596wP8+riTlj7Xgk5ynXa7Y5+klTqZQ9UcMaim8+Mce3xc97Kc5IoqNX3LRqn58iST7qhkdCRqsOSDIdwggX6B/6sm3iDjGLs3j8v3e4LgcynGYgO0pEEXOs6bhN2ixIjB1OutYLz70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHYM2GFc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710398760; x=1741934760;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=3akQJ45fbBJ5/c7Zkgj7O+fa4NlNR24ywtRjPw4TmvE=;
  b=KHYM2GFcTR9Uuu7Of/qAz+oeXYGYVzY+4a3dlBKhCuFh/lKZO/4uXN5J
   KHuWipY2/Kt4GDfv4diwlgL+mVadCcQ98XZ0t3xDtZGPvwp7Nk14eZqzX
   /KNYx35pFsmY2PiYtBhQ5cvcmaQ1jBr9J5vfZbIw01JaTNMLYXVdKOcwc
   CMcrEfYaJaYERke2LHkLeP3gvEM3E1mpeVrJhUVeO/qJAL1eMFzSHjxAy
   r6JNBBPTtSocVvjIBOuDRfWmwSPJc5qeMaZzGbrpOMfIcdb178aXwlYU6
   BVReuVrj5z8DS2GwH3svY6qJtBJ62dsYxcMhj5DLaYwksoXoTWarqJi7N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5395659"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="5395659"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 23:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="43235378"
Received: from oozturk-mobl3.amr.corp.intel.com (HELO [10.209.75.221]) ([10.209.75.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 23:45:59 -0700
Message-ID: <8ba11abc-4b72-480a-ba45-5d6ac80a57c5@linux.intel.com>
Date: Wed, 13 Mar 2024 23:45:58 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [drivers/pci] Possible memleak in pci_bus_set_aer_ops
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: zzjas98@gmail.com, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, chenyuan0y@gmail.com
References: <ZfJe4GZGpEQq7WIa@zijie-lab>
 <518813f8-294f-461c-b0dc-e980893a9ebf@linux.intel.com>
In-Reply-To: <518813f8-294f-461c-b0dc-e980893a9ebf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/13/24 7:40 PM, Kuppuswamy Sathyanarayanan wrote:
> On 3/13/24 7:20 PM, Zijie Zhao wrote:
>> Dear PCI Developers,
>>
>> We are curious whether the function `pci_bus_set_aer_ops` might have a memory leak.
>>
>> The function is https://elixir.bootlin.com/linux/v6.8/source/drivers/pci/pcie/aer_inject.c#L297
>> and the relevant code is
>> ```
>> static int pci_bus_set_aer_ops(struct pci_bus *bus)
>> {
>> 	struct pci_ops *ops;
>> 	struct pci_bus_ops *bus_ops;
>> 	unsigned long flags;
>>
>> 	bus_ops = kmalloc(sizeof(*bus_ops), GFP_KERNEL);
>> 	if (!bus_ops)
>> 		return -ENOMEM;
>> 	ops = pci_bus_set_ops(bus, &aer_inj_pci_ops);
>> 	spin_lock_irqsave(&inject_lock, flags);
>> 	if (ops == &aer_inj_pci_ops)
>> 		goto out;
>> 	pci_bus_ops_init(bus_ops, bus, ops);
>> 	list_add(&bus_ops->list, &pci_bus_ops_list);
>> 	bus_ops = NULL;
>> out:
>> 	spin_unlock_irqrestore(&inject_lock, flags);
>> 	kfree(bus_ops);
>> 	return 0;
>> }
>> ```
>>
>> Here if the goto statement does not jump to `out`, the `bus_ops` will be assigned with `NULL` and then `kfree(bus_ops)` will not free the allocated memory.
>>
>> Please kindly correct us if we missed any key information. Looking forward to your response!
> I think it is a valid issue that needs to be fixed. If you would like, please send a patch to fix it.

Sorry, I misread it. I think it is not a issue. For a valid case, the bus_ops is
added to pci_bus_ops_list, which is freed in module exit function. Ignore
my previous comments.

>
>> Best,
>> Zijie
>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



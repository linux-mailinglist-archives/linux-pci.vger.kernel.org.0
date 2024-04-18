Return-Path: <linux-pci+bounces-6454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D48AA1F9
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 20:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD491C213CA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 18:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2AB83A07;
	Thu, 18 Apr 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqXT1EUO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE921779A4
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464737; cv=none; b=ElriGStYc6NP5cihU7F/gcTpQZMAMsIu/0pIJpvlB8U17vimTA4W04roUU+GTVTTrDepoIxOFgDgvqPnNaLqR2+2ECOCI1VYPST0yAsmCQVMXwjIHBEWLe1XI6uMDuJwLXT1MwvYcpHzOoj39DTp+huVJwgQSsQNkbe7HCWar4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464737; c=relaxed/simple;
	bh=r6X1lv6bV15KuHX2XeSSORrOTn3Rqcrl6KPtq7TNrug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZzIOEMN6vuOBOW5JPkGWRBDrZZuzGBv65ZEhZn7D5xiyYqTK493Iux7cSucLXvte1jO2cufRv08qWIueRqV2uUCJ2DYv8ITKXDR24JpKS66DfL122tJNK6+F52CmOCM4ldsMDzmYM+loBvNK3lw0hOsXIrONbXOPTkxpca7PCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqXT1EUO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-418e4cd1ffaso7458755e9.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713464734; x=1714069534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vM3k3RSVni1L4pkiafqumEdaRSzWkkxn3RTLK2ldM1g=;
        b=QqXT1EUOlNMq0wNzoA7KJcHjjuNx3/RYI4PWruFiDvSRfZcLCek54k8baHvabvpQ+w
         yH1T0xz36wAiuVwgMgIF1Sn5fPD/JcJXhPsVSsPZ32Wc3NajP85ufiDDpDMkQVTEBM8Y
         rxqIbB5GZsHEYrEKDFy/CMdhNG50lZbyqq6Q+ggR6JyNd+rVlhu7Zv7WbuvuvCnRfbOZ
         T45rUYIEhEGj5vIIbJjxXn4+Cs0M+FamKvjpERw7EBCCnooaj8LuM5wFfD/WE0h0zJUr
         SK8X6P5cGTlvSGrgk/0EO2D8ms8pfwoqi9qJ2I9vjZifOhqHNWzqAePUsBwp/P6X4fPL
         zrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713464734; x=1714069534;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM3k3RSVni1L4pkiafqumEdaRSzWkkxn3RTLK2ldM1g=;
        b=wJg9QFENCEj6fgqQVygwSVSHv6jdo9XHHupotkf53NdYguxq+yUZUzkl/KMVAXG3vX
         OdA+/T6CgomwIMjTMuxhEMLRwJ/61WnH13x5JBeR1l8gTfxMcTBJk1ReyY6N1MBDqPO/
         tHeSVZBB18hdxD0bIxjiwzm3pkuZBUyCgvre4+/w0GxDygPMLmevdKY1X9xHbe96pyjw
         EtkaWdxAgbTpTPQOQwCu80+W+fDxz+uq2zcnGMTJKmQ7Wf6V6BF9yxKUXvnGOIEsfZbe
         dYp5EZe0IPn5O1dz6Wa06tWLbS8lAyfiCCWGlh4SQhsgmwevgrYKU5j3cQYdNG90Bajd
         S1jw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0iBTTGI87J50fDjVa4hDxdLRMbOUuQETghSsADKqxbdEFRxIlGWb4wR5ygJzPBxHAjX+nZDLfs7rDYchEln90eQplrV72cWI
X-Gm-Message-State: AOJu0YwY92/QX9ud6RrpFU12Ol/taPq0f6l1hKLkrkWkqQ3eY1mPlyge
	6oLnyUYPgPctVZ9AfP2OxY+oh1RHrNYiKAo7JJBRa/Rko2uH8fk5
X-Google-Smtp-Source: AGHT+IET6f03mvAWkYbLnGG48fnMNh4btThymMX01kMWFBpcdlyBJL2LEKEZf+MBpqqQCF7y8sOg2g==
X-Received: by 2002:a05:600c:5024:b0:418:ed13:302d with SMTP id n36-20020a05600c502400b00418ed13302dmr1711313wmr.26.1713464733446;
        Thu, 18 Apr 2024 11:25:33 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7a7c:3800:e468:94af:626f:f554? (dynamic-2a01-0c22-7a7c-3800-e468-94af-626f-f554.c22.pool.telefonica.de. [2a01:c22:7a7c:3800:e468:94af:626f:f554])
        by smtp.googlemail.com with ESMTPSA id r13-20020a05600c458d00b00417f65f148esm7402575wmo.31.2024.04.18.11.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 11:25:32 -0700 (PDT)
Message-ID: <a72af5e7-fff9-49bb-b1ff-1038bc04157c@gmail.com>
Date: Thu, 18 Apr 2024 20:25:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Annotate pci_cache_line_size variables as
 __ro_after_init
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20240417155014.GA204365@bhelgaas>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240417155014.GA204365@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.04.2024 17:50, Bjorn Helgaas wrote:
> On Sat, Apr 13, 2024 at 11:05:52PM +0200, Heiner Kallweit wrote:
>> Annotate both variables as __ro_after_init, enforcing that they can't
>> be changed after the init phase.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/pci/pci.c   | 4 ++--
>>  include/linux/pci.h | 4 ++--
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 5f8edba78..e7ac4474b 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -142,8 +142,8 @@ enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
>>   * the dfl or actual value as it sees fit.  Don't forget this is
>>   * measured in 32-bit words, not bytes.
>>   */
>> -u8 pci_dfl_cache_line_size = L1_CACHE_BYTES >> 2;
>> -u8 pci_cache_line_size;
>> +u8 pci_dfl_cache_line_size __ro_after_init = L1_CACHE_BYTES >> 2;
>> +u8 pci_cache_line_size __ro_after_init;
>>  
>>  /*
>>   * If we set up a device for bus mastering, we need to check the latency
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 69b10f2fb..cf63be0c9 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -2334,8 +2334,8 @@ extern int pci_pci_problems;
>>  
>>  extern unsigned long pci_cardbus_io_size;
>>  extern unsigned long pci_cardbus_mem_size;
>> -extern u8 pci_dfl_cache_line_size;
>> -extern u8 pci_cache_line_size;
>> +extern u8 pci_dfl_cache_line_size __ro_after_init;
>> +extern u8 pci_cache_line_size __ro_after_init;
> 
> Is __ro_after_init required on the declaration, too?  I see a few uses
> in .h files, but not very many, and I would think it would be a linker
> thing that applies to the definition, where space is allocated.
> 
You're right, it's not needed on the declaration. I'll submit a v2.

>>  /* Architecture-specific versions may override these (weak) */
>>  void pcibios_disable_device(struct pci_dev *dev);
>> -- 
>> 2.44.0
>>



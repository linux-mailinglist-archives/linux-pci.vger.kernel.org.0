Return-Path: <linux-pci+bounces-13484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4775A985268
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 07:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0381F24FC5
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 05:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9700114B075;
	Wed, 25 Sep 2024 05:30:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F7F1514CB;
	Wed, 25 Sep 2024 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242206; cv=none; b=jdYR++rNniBnR1rpxrBRh0F8S8rLZad/uf4W/GrljIkPhtWUCseI5ki74SUgxOP9qnx34+czrf+52Meer52sOiuGPyzZL7klONTXwxLLnhAkKibU+RpGKX9GR8h3UOTqdK2A+s5+fTQegY60CZleIe9hVFAs+fR/1MK2namNTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242206; c=relaxed/simple;
	bh=o0Ao4ZilaUp2dcY/sC41jiPqy+7EujwpI9Yfw5PcBQE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FxYvxki+6z81bQFH+F3E8xuwdO96DYq9HF943YxhlI2ZLD7IsZHotELwYxih0ZoSJS0OMhwXNYMEX1vcesZWmJbTiATFGKIOrado5r89deVVfJdBAq2BURymBI+dBRlcmoR1qii1GO8pdswJ5oBmcY8c58NMYjsGbWa3IJ/V1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a93a1cda54dso54598266b.2;
        Tue, 24 Sep 2024 22:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727242203; x=1727847003;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALn1HVNf/hT2yAkZkwD36MDV/I6QOfaDiw2O0GS4YLg=;
        b=ETJ1DJQpv7b/gShJ9K0tRbA/NPEUvd4+Ho5jiSsyNgt2IPbfeyc7S71dNEZtZMpSPO
         bGKRq4h58dNA2+IO2dly+Fi/nCGbEGW7445i0AfQv4faY7lAZH+kz/e1YJ+wAY2eOkG8
         pasl3xosy//xjXzZW8E/l8ECJP3/7LgN/xVz4cPEfDJ7hjsRDvUmkQE9xZLol/0DQbon
         6grN3YzJpflznAwriZ9MOLzZgna7G2V+B2fVCfdMZ0JlYvZrk7GGZRD2m5iNe5jjHJcm
         2L/kw3kmVMtWfE+f8BQv+iRG094UsxiIM9TgWnyRC3QjGsQgz5SvXOl2+F1TT4Z6ax68
         W0Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVi/68xYiL244bUHMetFGmuD1yq2EDpgy1NH/wjy59k7tSzRYp7zz9os1Ptg7UDRiJ5f8CzpRgZ0pw=@vger.kernel.org, AJvYcCX9db/69Ex/Tiy3qA6whsuKaG94ZarR4/SVB89UcdeGV7J0RLXQbNfhZXmiddQ/F6bbbV/IBEXyX5UJ@vger.kernel.org, AJvYcCXH/R8wvURHp2jgkXozmD46HLfpPv53DcDW2BYPKfklw7OapE7CWquzMpxTeugn7+6d7iuaYUcUITGq2lXj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx29V12079y0W8em/3ESXX3W4gq+lp2tlVOI36RXog2q9hOGeNH
	MONrD13IgHxHUKXec2J3JkOOvd2bXMeWWkYEM8eHbCGpG2FYJXlY
X-Google-Smtp-Source: AGHT+IEk6hl9O6U9FgYshFoRiU2rvZihWJtAOJtstG1esXBfEjZBBNDkQK1UsqoCuRLo13T/0E++kw==
X-Received: by 2002:a17:906:dac8:b0:a8d:2a46:6068 with SMTP id a640c23a62f3a-a93a03c2dc8mr127117466b.39.1727242202898;
        Tue, 24 Sep 2024 22:30:02 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f7b41sm166771666b.162.2024.09.24.22.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 22:30:02 -0700 (PDT)
Message-ID: <3cbd6ddb-1984-4055-9d29-297b4633fc41@kernel.org>
Date: Wed, 25 Sep 2024 07:29:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] PCI: Extend ACS configurability
From: Jiri Slaby <jirislaby@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>, corbet@lwn.net, bhelgaas@google.com,
 galshalom@nvidia.com, leonro@nvidia.com, jgg@nvidia.com, treding@nvidia.com,
 jonathanh@nvidia.com
Cc: mmoshrefjava@nvidia.com, shahafs@nvidia.com, vsethi@nvidia.com,
 sdonthineni@nvidia.com, jan@nvidia.com, tdave@nvidia.com,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kthota@nvidia.com, mmaddireddy@nvidia.com,
 sagar.tv@gmail.com, vliaskovitis@suse.com
References: <20240523063528.199908-1-vidyas@nvidia.com>
 <20240625153150.159310-1-vidyas@nvidia.com>
 <e89107da-ac99-4d3a-9527-a4df9986e120@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <e89107da-ac99-4d3a-9527-a4df9986e120@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25. 09. 24, 7:06, Jiri Slaby wrote:
>> @@ -1047,23 +1066,33 @@ static void pci_std_enable_acs(struct pci_dev 
>> *dev)
>>    */
>>   static void pci_enable_acs(struct pci_dev *dev)
>>   {
>> -    if (!pci_acs_enable)
>> -        goto disable_acs_redir;
>> +    struct pci_acs caps;
>> +    int pos;
>> +
>> +    pos = dev->acs_cap;
>> +    if (!pos)
>> +        return;
>> -    if (!pci_dev_specific_enable_acs(dev))
>> -        goto disable_acs_redir;
>> +    pci_read_config_word(dev, pos + PCI_ACS_CAP, &caps.cap);
>> +    pci_read_config_word(dev, pos + PCI_ACS_CTRL, &caps.ctrl);
>> +    caps.fw_ctrl = caps.ctrl;
>> -    pci_std_enable_acs(dev);
>> +    /* If an iommu is present we start with kernel default caps */
>> +    if (pci_acs_enable) {

AFAIU pci_acs_enable is set from iommus' code via pci_request_acs(). 
Which is much later than when bridges are initialized here, right?

>> +        if (pci_dev_specific_enable_acs(dev))
>> +            pci_std_enable_acs(dev, &caps);

So this is never called, IMO.

>> +    }

thanks,
-- 
js
suse labs



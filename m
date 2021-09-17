Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2498B40EED8
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 03:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242408AbhIQBiV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 21:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbhIQBiV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 21:38:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44188C061574;
        Thu, 16 Sep 2021 18:37:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso8851023pjh.5;
        Thu, 16 Sep 2021 18:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZJv0T0RMe21MF4kWcF0/B2W1/ozbKhtMFKhIRKl9ZMo=;
        b=N/ot3EgDydF6p6/5n5AZkrhZktc26nOO0YKnIe1UIs+06S+gWNs69fqS1lOWK03WG9
         ODaroI/6MJP8sjdjuAlPvMJQ5njetx+D+SmIrnNLBet/U1W1Arx2bdJLpsikWx+R5UUi
         NRsNQ+RyEAUAEzkMdXIGsw6wh9BCrM5aT4ufsgh+IxvPbrKPf3MDofL7DFPqHyKImpVM
         Yj3oRuA5WPxikyrBVxlcNj0R9y0fJrPNiRNyk2Jz31kptqtcItBybh6AWZUEe0KyL7sp
         KeBIWUql0iJmpTznEp0QxYimonoNhHQHZoAHz4Wd25EPuOI4l9VggeIZeQgbM7blIfAY
         D3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZJv0T0RMe21MF4kWcF0/B2W1/ozbKhtMFKhIRKl9ZMo=;
        b=KySWsRyLUDAVjYOnK7ftRL3g66URTrVPeU3FOTCc8JGZmOLcfRdOq2PpmlDe4llBVm
         +SA0H4087bHudO7Je9e29tAgknsp9M4LFm1Bjv3wxPmgmokMd+TItLbQs/2VFc1Z1/nm
         EUl0ZdM7At0R3nkQp0M5SzAoAGrlDGUbsqxpWVGx2uZld1BtaUhHU9OgdmZ/aWzelHmX
         Wt2Uvf1ChviOZwOkOoZ91aq+ks0gfLRQ0t3TYYkwf5yKo2Hm8EnkA7FqbhizHzuZCbiQ
         PyznU8IFgFkZFE4YrsJq4sBZyVkRoj6H13CTsl/Q+OYvaVtYFHuDskm+Gj4u+yN+2Ihz
         Ga0w==
X-Gm-Message-State: AOAM530XhQSSFyJ0+GlRoE9lH3z9zKAh4sdOonnr3Lt9aDhZNRYl0WV7
        ChHZBVtj5f30t9orZZADTLNw35Uozhk=
X-Google-Smtp-Source: ABdhPJwgmYnSHaM1HyOi/D04wtFhz3epJkyk/Oamgu87tZU4ZDV1ogTNRla9ogCm+ib0JPdBdRZ1jQ==
X-Received: by 2002:a17:90b:224b:: with SMTP id hk11mr17871337pjb.231.1631842619577;
        Thu, 16 Sep 2021 18:36:59 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.115])
        by smtp.gmail.com with ESMTPSA id 132sm4176111pfy.190.2021.09.16.18.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 18:36:59 -0700 (PDT)
Subject: Re: [PATCH v3] PCI: vmd: Assign a number to each VMD controller
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     jonathan.derrick@intel.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1631675273-1934-1-git-send-email-brookxu.cn@gmail.com>
 <20210916225755.GA1511623@rocinante>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <b87f7a38-d147-3da6-0352-ad2df7a5f55f@gmail.com>
Date:   Fri, 17 Sep 2021 09:36:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210916225755.GA1511623@rocinante>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Krzysztof Wilczyński wrote on 2021/9/17 6:57 上午:
> Hi Xu,
> 
> Thank you for sending the patch over!
> 
> A small nitpick below, so feel free to ignore it.
> 
> [...] 
>> @@ -769,28 +773,48 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>  {
>>  	unsigned long features = (unsigned long) id->driver_data;
>>  	struct vmd_dev *vmd;
>> -	int err;
>> +	int err = 0;
>>  
>> -	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
>> -		return -ENOMEM;
>> +	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20)) {
>> +		err = -ENOMEM;
>> +		goto out;
>> +	}
>>  
>>  	vmd = devm_kzalloc(&dev->dev, sizeof(*vmd), GFP_KERNEL);
>> -	if (!vmd)
>> -		return -ENOMEM;
>> +	if (!vmd) {
>> +		err = -ENOMEM;
>> +		goto out;
>> +	}
> 
> I assume that you changed the above to use the newly added "out" label to
> be consistent given that you also have the other label, but since there is
> no clean-up to be done here, do we need this additional label?
> 
>>  	vmd->dev = dev;
>> +	vmd->instance = ida_simple_get(&vmd_instance_ida, 0, 0, GFP_KERNEL);
>> +	if (vmd->instance < 0) {
>> +		err = vmd->instance;
>> +		goto out;
>> +	}
> 
> Similarly to here to the above, no clean-up to be done, and you could just
> return immediately here.
> 
> What do you think?
> 

Thanks, I think we can do this.

> Also, I think we might have lost a "Reviewed-by" from Jon Derrick somewhere
> along the way.  Given that you only updated the commit log and the subject
> like, it probably still applies (unless Jon would like to give his seal of
> approval again).
> 

Thanks, my mistake here.

> 	Krzysztof
> 

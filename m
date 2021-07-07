Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7888D3BEB92
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 17:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhGGPvk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jul 2021 11:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhGGPv1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jul 2021 11:51:27 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22609C061765
        for <linux-pci@vger.kernel.org>; Wed,  7 Jul 2021 08:48:24 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id h9so3881755oih.4
        for <linux-pci@vger.kernel.org>; Wed, 07 Jul 2021 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+unQYKYyP/qB8RKVeN42/wrINKmtK3Dqhd2TBpHNwsc=;
        b=Ry9XHykDtOxI6hcOPrAqEFsaEyntEnmKtOzicfdpkZNvQ83OMdkHZ5kOdjDREeGVQT
         rrunWX9iRY9LlLqoBTd9ZX5rQDYktYmtYFiJhfB2nna81acOkrKCE+4xnUGEfrhvMg8D
         RXMOkEeqfLjRLASS1HGuBoBkBm4JZN4eiOWQTNkTm8193JA/Hz7qELYxGMPUD0U7XWzD
         n1ITwqlBeJ5F262bhNW/WY7QS9j4Iu5pbv3pZBdAT4yMLkKPOXH+QTThpKg+qY49CU4d
         lWPDUM8PJFB3GGlBVLaBjLa2PPLPGhuEShmBnmDUXmi+Syfbf5mVZMsiqKCre748hT3O
         q+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+unQYKYyP/qB8RKVeN42/wrINKmtK3Dqhd2TBpHNwsc=;
        b=Pr1fzrHql6q9goFWuHfr37ZwtVsZWmPl03ZnBsf/+0rp+aYc/Q/4g5xDfs9EYFApi3
         v3NwaDKHafhMg1jxzuwZMH5dcYO2v6YxgOnbmcO5ax1OVAZapgC1dng9y2nKE1O31qqx
         tFx9ndITZHmMUNi4QLrvPyg2pY/z6Sz/FYTl6S/E+NnfE4IlUSsU5R+nLxZq9m1m04VV
         S/fgNFMvBuf9btIqK9Qo2seNZOeL4tbBI07sING1NTvz5TnGA3qSjQmsuoZWwd5vx3cI
         QrPjyEScMDhuOgvo1Px/qv3irD3JJvKU9Isio79RghTxZWzvKRpeEcSEgWVM1OnIWYs3
         Tb4w==
X-Gm-Message-State: AOAM530RsBmC0IMotQOTifxcV4GCkYYiy2jSV68byCpFO38LsarPw6l8
        HSWwg+eewxx5JYjHOokcP3cDLj7HTmQvlw==
X-Google-Smtp-Source: ABdhPJwDeiO7uXEYGbe3/gqEdoaeP6cqbLVuUeG8dnX6n+i2JG2qg9fmk7WTmyHRHr2v8/7x6gIgpg==
X-Received: by 2002:aca:d60f:: with SMTP id n15mr16828247oig.176.1625672902924;
        Wed, 07 Jul 2021 08:48:22 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:e852:d886:7122:8d36? (2603-8081-2802-9dfb-e852-d886-7122-8d36.res6.spectrum.com. [2603:8081:2802:9dfb:e852:d886:7122:8d36])
        by smtp.gmail.com with ESMTPSA id m21sm1630542oov.43.2021.07.07.08.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 08:48:22 -0700 (PDT)
Subject: Re: [PATCH v2] PCI/portdrv: Use link bandwidth notification
 capability bit
From:   stuart hayes <stuart.w.hayes@gmail.com>
To:     Krzysztof Wilczy??ski <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
References: <20210512213314.7778-1-stuart.w.hayes@gmail.com>
 <20210514130303.GD9537@rocinante.localdomain>
 <20210514130845.GA26314@wunner.de>
 <20210514131701.GE9537@rocinante.localdomain>
 <53c92c86-5fd9-5db4-eacf-954f1f07cecb@gmail.com>
Message-ID: <692d2bb1-a4fe-5ba4-8576-761096338775@gmail.com>
Date:   Wed, 7 Jul 2021 10:48:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <53c92c86-5fd9-5db4-eacf-954f1f07cecb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/26/2021 8:12 PM, stuart hayes wrote:
> 
> 
> On 5/14/2021 8:17 AM, Krzysztof Wilczy??ski wrote:
>> Hi Lukas,
>>
>> [...]
>>>> I was wondering - is this fix connected to an issue filled in Bugzilla
>>>> or does it fix a known commit that introduced this problem?  Basically,
>>>> I am trying to see whether a "Fixes:" would be in order.
>>>
>>> The fix is for a driver which has been removed from the tree (for now),
>>> including in stable kernels.  The fix will prevent an issue that will
>>> occur once the driver is re-introduced (once we've found a way to
>>> overcome the issues that led to its removal).  A Fixes tag is thus
>>> uncalled for.
>>
>> Thank you for adding more details.  Much appreciated.
>>
>> Krzysztof
>>
> 
> I made the patch because it was causing the config space for a 
> downstream port to not get restored when a DPC event occurred, and all 
> the NVMe drives under it disappeared.  I found that myself, though--I'm 
> not aware of anyone else reporting the issue.

Any chance this might get accepted?  I'm not sure if it just got 
forgotten, or if there's a problem with it.  Thanks!  --Stuart

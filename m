Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57546610921
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 06:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJ1EAy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 00:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiJ1EAw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 00:00:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E973E43E70;
        Thu, 27 Oct 2022 21:00:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so3429558pjd.4;
        Thu, 27 Oct 2022 21:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/sY8/XuQ70nuVCzQi7NxMpbTZgfzD5+fQZtTGl0LGY=;
        b=NKHh8W6HOJE8Z9Qv8QMMb0IesHBCvPBqNLNkieOKDzTCqM8IeP1zBXxpA33gLwH2e8
         4EhE4TWVWuVdVQd1LyBupuRMuDWFyTONwLaIn7aPVUX45x+gVYlXTJxSQsqt8JaAr/3r
         Fhg0nSW6lYkjEmEgc/zVyaRhlRK/6GraEXtHEKHi7MuT4XNwQa/3ENrQiCTPwgTqrDMi
         pVjX9UyYgtEQdQW5mABoycIab8rdQqGl5npnql9Bp0C2g/t+S4pXm+rKZlY86XAwV/39
         zNJwpcxuE/NnF0ZeTZSTG95lB9/UvBKuHg8olAo4oYLRhy3Gyi6VVux85F4hbRsxZrC6
         ZCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/sY8/XuQ70nuVCzQi7NxMpbTZgfzD5+fQZtTGl0LGY=;
        b=kXEtzRY6HLcp4SRL6EMvuSPgg2j2AaqLXOGpK9aQG3kI583kXkMS2BiZFtElDnxBtG
         dF2SYtEWij8+C8ay89NW6cgjXijfpiZ1Om3qiWLot1KC5cM/PPIG7aw/jpgONRDIS2lo
         NoWOHxdCP/e9pGLQ/JT390W8QLpxJJGeEVD4Tjnk0g+PMVrjp98KjPknkExGbcs0tizG
         fHCXJbjVwjv/oCCfImZPL+cAPHdbHit6plPDlVcefkg7iyx1AjyUrSx3bLYmhguhwa62
         VbQi0s4S0XGtiNAEGZ4xmgiJF+IHdbsBc79p6uCgaek47FBz7T923FghYbQvWi5lWcdf
         ntQg==
X-Gm-Message-State: ACrzQf1wY2oj1rMl/HiOhfc+eZLfvw8OrxQhtrf2G6yuMDqOUasxvVVz
        Dd82FFrHbz4epAQJ8BVmCirP+1cJZ8k=
X-Google-Smtp-Source: AMsMyM4vUAzx7LnBm3SO32s0BgWuHbjvkZCvlajvhGr9CII4v2hhcjPgWI1f6Ad7mv1VPT1JeL1Rbw==
X-Received: by 2002:a17:903:2447:b0:186:e200:6109 with SMTP id l7-20020a170903244700b00186e2006109mr10657759pls.104.1666929648462;
        Thu, 27 Oct 2022 21:00:48 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-58.three.co.id. [116.206.28.58])
        by smtp.gmail.com with ESMTPSA id z7-20020a626507000000b0056bd6b14144sm1886987pfb.180.2022.10.27.21.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 21:00:48 -0700 (PDT)
Message-ID: <8d97d668-b967-563b-28d0-54982b1bbeb0@gmail.com>
Date:   Fri, 28 Oct 2022 11:00:43 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] PCI: Add vendor ID for Quectel and Cinterion
To:     Slark Xiao <slark_xiao@163.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028023711.4196-1-slark_xiao@163.com>
 <Y1tRu3SFMrS3su56@debian.me>
 <9ec6b2e.17e9.1841cbcf83b.Coremail.slark_xiao@163.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <9ec6b2e.17e9.1841cbcf83b.Coremail.slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/28/22 10:57, Slark Xiao wrote:
> At 2022-10-28 11:51:23, "Bagas Sanjaya" <bagasdotme@gmail.com> wrote:
>> On Fri, Oct 28, 2022 at 10:37:11AM +0800, Slark Xiao wrote:
>>> In MHI driver, there are some companies product still do not have their
>>>  own PCI vendor macro. So we add it here to make the code neat. Ref ID
>>>  could be found in link https://pcisig.com/membership/member-companies
>>>  and https://pciids.sourceforge.net/pci.ids . Thales use Cinterion as
>>> their IOT modem card's trademark. So you will find 0x1269 belongs to
>>> Thales. Actually, Cinterion belongs to Gemalto, and Gemalto belongs to
>>>  Thales.
>>>
>>
>> The patch description is confusing me.
>>
>> What about below instead?
>>
>> ```
>> Add missing vendor ID for Cinterion (which is 0x1269).
>> ```

Oops, I mean also for Quectel (0x1eac).

>>
> As you said 0x1269 belongs to Thales (not Cinterion), So I write it about the details.
> 
>>> Signed-off-by: Slark Xiao <slark_xiao@163.com>
>>> ---
>>>  include/linux/pci_ids.h | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>>> index b362d90eb9b0..9e2b6286f53f 100644
>>> --- a/include/linux/pci_ids.h
>>> +++ b/include/linux/pci_ids.h
>>> @@ -1765,6 +1765,8 @@
>>>  #define PCI_VENDOR_ID_SATSAGEM		0x1267
>>>  #define PCI_DEVICE_ID_SATSAGEM_NICCY	0x1016
>>>  
>>> +#define PCI_VENDOR_ID_CINTERION		0x1269	/* Celluar Modules*/
>>> +
>>>  #define PCI_VENDOR_ID_ENSONIQ		0x1274
>>>  #define PCI_DEVICE_ID_ENSONIQ_CT5880	0x5880
>>>  #define PCI_DEVICE_ID_ENSONIQ_ES1370	0x5000
>>> @@ -2585,6 +2587,8 @@
>>>  #define PCI_VENDOR_ID_TEKRAM		0x1de1
>>>  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
>>>  
>>> +#define PCI_VENDOR_ID_QUECTEL		0x1eac
>>> +
>>
>> Why pourring in Quectel ID while this patch is about Cinterion?
>>
>> Thanks. 
>>
> Patch title is for 2 vendors,  Quectel and Cinterion. May I add 2 different VID at the 
> same time?

Ah! I don't see the patch subject.

Next time, please just send plain-text email, not HTML.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara


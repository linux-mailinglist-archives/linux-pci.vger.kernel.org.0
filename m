Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADFB2EB1A9
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 18:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbhAERoi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jan 2021 12:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbhAERoh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jan 2021 12:44:37 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E52EC061574
        for <linux-pci@vger.kernel.org>; Tue,  5 Jan 2021 09:43:57 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a12so19118wrv.8
        for <linux-pci@vger.kernel.org>; Tue, 05 Jan 2021 09:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wjwOLmhj+xEBMawy/YbEyEBud/PyuENSGJe8w9Q/w8w=;
        b=lQw20GP51nkGoF3WYCzdqokac6V7w/h4HybpWDY0ihMaxHjh2oKVp6E5pjAJ/LxT1/
         RqcYNDOLs1O16Ukrl2VYU0b4oO/50tJKXjUAxD5nx7vYgf4aiY5jUwwMNcRlHJ7eD1Iu
         gStWl5uu8RdLCUvopyhcO9i7M/bgRyG8efZ4CHDsqq911o0su/NE3xylJlwHiBJtb2uG
         5E53W5HNrdIqJlDr8gQNAFXct1HftkOu0THkyGupCJCCNspeW6Ny4aH+0GoyJCSMIJ9I
         D4JcjKuSNP9dYoUy8NsDRm+ylkNREymChNGpvFV2fC/+h8xo8H8MvDeBeefcVQM8p/MO
         bKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=wjwOLmhj+xEBMawy/YbEyEBud/PyuENSGJe8w9Q/w8w=;
        b=FyPl4tlsWlvTdT77MGsMjuoPE1lxzb9yIawcENaLx9CaVAICJA9ZxSF9/PkAOn+F7d
         szr0e0npOXGxRqG7woFuvjpw7qqR5mBcR8hjXS7i2kUpfou31ZGRc+ceF2COvy12Gzj/
         KKboD9iP9neElMgnLq/k4GsLScpI1IH3snciBLPB/w6bL3jAnqzHja/HNp8VQzobPdBO
         3PV5demKg0BSjla5pjPGBSJjFSnl+PKApf4Ju/ZGByI4/JVlR4tr6AJrO+Bz3ZidNkGF
         EQRhNfJ3O/EmoqzsU5S3wLcNGnIIqK3FSoO74Hw5xokawM06w77n2HTFQxhqwPDD++ih
         trhQ==
X-Gm-Message-State: AOAM532dU2Q7d4l/uxE/fIYbOthfcALZUu3oKuPXsEdruE+2grIY4f1c
        jzBF1+kYAYagHVWUKK9ceMxBrYfq/kI=
X-Google-Smtp-Source: ABdhPJwJ/MUQKlLbFaTFkNVz7ByMjvFjYaUERQj1mY1aHWCgsYLf2CNkqFbyB/dI4yG4e5FpuWDxAw==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr679320wrm.1.1609868635827;
        Tue, 05 Jan 2021 09:43:55 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id f9sm632899wrw.81.2021.01.05.09.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 09:43:55 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 4/4] PCI: add a REBAR size quirk for Sapphire RX 5600 XT
 Pulse.
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, devspam@moreofthesa.me.uk,
        Linux PCI <linux-pci@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
References: <20210105134404.1545-1-christian.koenig@amd.com>
 <20210105134404.1545-5-christian.koenig@amd.com>
 <CAKb7UvhUXKTVp9bXmbkU4VR8WQVZ16LNvk8QKkqiOUTKC8DVQg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <21a04206-c198-f358-d7ca-b0f04f5b7a2f@gmail.com>
Date:   Tue, 5 Jan 2021 18:43:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKb7UvhUXKTVp9bXmbkU4VR8WQVZ16LNvk8QKkqiOUTKC8DVQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 05.01.21 um 17:11 schrieb Ilia Mirkin:
> On Tue, Jan 5, 2021 at 8:44 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Otherwise the CPU can't fully access the BAR.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/pci/pci.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 16216186b51c..b66e4703c214 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3577,7 +3577,14 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>>                  return 0;
>>
>>          pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
>> -       return (cap & PCI_REBAR_CAP_SIZES) >> 4;
>> +       cap = (cap & PCI_REBAR_CAP_SIZES) >> 4;
>> +
>> +       /* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
>> +       if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
>> +           bar == 0 && cap == 0x700)
>> +               cap == 0x7f00;
> Perhaps you meant cap = 0x7f00?

Ups, indeed! Thanks for pointing that out.

Christian.

>
>> +
>> +       return cap;
>>   }
>>   EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
>>
>> --
>> 2.25.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel


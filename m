Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FE964B70B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 15:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiLMOM4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 09:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbiLMOM2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 09:12:28 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0F1CB0D
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2022 06:11:14 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id i20so5293474qtw.9
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2022 06:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fx9eNOICfd+nfcl2r684T2r2UsiBc+1a2zdfdcR0gMQ=;
        b=I7GeHzrtZRQeAnhVZatKVxSBwAwWUWQtXcryzAjGEM0rtmNUrw/xWx7hKf25DnqxE0
         9PjUZ1SQmZ+CLjin8ErngVPe2ceRgt7joJ3P0DWcT2WioAfQiEJiNo/lXx/c79/PrWfC
         VOH97q+gpPLT4fduE3QPjcTTrfqYfHfnXkhFSNCd77wTYoEpl+mi9sA6O9lrdMf/kpDF
         CwRpWFu3qX5AamhoDC22tZ5DOzPBtrTVJybAyj4oW/mG45G2djLKwRqMnL/CotS4XZo4
         GMTfDEfQcBD+DEMLG60qXUnIoA1E+pgh6/fD29ffDpJ3FrLUz+n+4KBESoQ5lTSU72y7
         3zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fx9eNOICfd+nfcl2r684T2r2UsiBc+1a2zdfdcR0gMQ=;
        b=lvysZNrMNBX+yHYY3OFzsojF4PsSsMV/TUqqlOIJJ+wLTwcaw6RQ4gf0KpjPAPDTfE
         eAy3B3Z/5dM+NsUAjgJ7gZBF+hi3owfq5f2zX8g11Hlfbk+f2Uv++9powllgHSIxV5SK
         YKwCpSlIW7dk/qSK/MO9c1icl5uEDdKWDC9h6Vdfjr7cIqktcxRWU7vlEnrLOtzgHtlN
         TUd+Ud7UzF4cQp4mazchRzavZFE9VMqj/izZ31IfLEz7NeIrrkKlv82qLcskFcWpWayQ
         sqjwkeGxzRgJEFr7ImATr7D43YEDBS8gjXTyplGRCTQ0NamaHhNtuKLtTylRIox0TLh5
         1sog==
X-Gm-Message-State: ANoB5pmRr9TQ+0xzcsiyivSeR3HUAsqWG7m073J3bxef9ajHldIl4T1S
        pjHmeR4oS84rBTw7sE1YxXu3Cg==
X-Google-Smtp-Source: AA0mqf4BgITG7RNHrcTMdpLR5jyi5KhL5r16mb1G3UH3xSg7N+AzNLPl06ihMh/bigw59iaxzxBoBg==
X-Received: by 2002:ac8:5189:0:b0:3a7:f86a:a516 with SMTP id c9-20020ac85189000000b003a7f86aa516mr29577467qtn.10.1670940673590;
        Tue, 13 Dec 2022 06:11:13 -0800 (PST)
Received: from [10.230.45.5] ([38.32.73.2])
        by smtp.gmail.com with ESMTPSA id gc11-20020a05622a59cb00b003a7f3c4dcdfsm7581650qtb.47.2022.12.13.06.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 06:11:13 -0800 (PST)
Message-ID: <35208ffe-0aee-b055-0ed7-99b6414af6da@ixsystems.com>
Date:   Tue, 13 Dec 2022 09:11:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: pci_bus_distribute_available_resources() is wrong?
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Nick Wolff <nwolff@ixsystems.com>,
        Bjorn Helgaas <bjorn@helgaas.com>, linux-pci@vger.kernel.org
References: <2ec11223-edb3-5f5c-62cd-3532d92de0a4@ixsystems.com>
 <CAErSpo7WrAg5D4xyv0SycoDc1etSspU_TL6XMAK4STYrXDrGNQ@mail.gmail.com>
 <6053736d-1923-41e7-def9-7585ce1772d9@ixsystems.com>
 <Y5gSfJd0H4rKXe9H@black.fi.intel.com>
From:   Alexander Motin <mav@ixsystems.com>
In-Reply-To: <Y5gSfJd0H4rKXe9H@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13.12.2022 00:49, Mika Westerberg wrote:
> On Mon, Dec 12, 2022 at 04:10:16PM -0500, Alexander Motin wrote:
>> On 12.12.2022 15:32, Bjorn Helgaas wrote:
>>> On Mon, Dec 12, 2022 at 1:36 PM Alexander Motin <mav@ixsystems.com> wrote:
>>>> In my AMD NTB case PCI topology looks this way:
>>>>
>>>> +-[0000:80]-+-00.0
>>>> |           +-01.1-[81-83]----00.0-[82-83]----00.0-[83]--+-00.0 Dummy
>>>> |           |                                            \-00.1 NTB
>>>>
>>>> 80:01.1 is the root bridge where the hot-plug happens.  The 81:00.0
>>>> bridge in addition to memory windows has small 16KB BAR.  But since it
>>>> is the only bridge on the bus, the function passes all available
>>>> resources down to its children.  As result, that BAR fails to allocate.
>>>>     And while that BAR seems not really needed, in some cases the
>>>> allocation error makes whole memory window to be disabled, that ends up
>>>> in NTB device driver attach failure.
> 
> Just out of the curiosity, is this PCIe or PCI topology?

All PCIe: hot-plug root <-> upstream <-> downstream <-> two endpoints.

>>> Mika is working on what sounds like the same problem.  His current
>>> patch series is at
>>> https://lore.kernel.org/linux-pci/20221130112221.66612-1-mika.westerberg@linux.intel.com/
>>>
>>> We would appreciate your comments and testing as that series is developed.
>>
>> Thank you, Bjorn.  This definitely looks related, but as you've already
>> noted in your review there, present patch does not handle BARs of the bridge
>> itself, that I have in my case.  I'd be happy to test the updated patch.
>> Please keep me in a loop.
>>
>> I also agree with your comment that the same should be done in case of
>> multiple bridges.  I am generally not sure the cases of single bridge or not
>> having hot-plug on this level should be any specific.
> 
> Yeah, I'm working on a new version of the patch series that should take
> these into consideration. The challenge is that the code has been used
> with the Thunderbolt/USB4 PCIe tunneling for some time already and we
> don't want to break that either.
> 
> I'm also more than happy to test any patches regarding this if someone
> else wants to work on it ;-)

I was kind of ready to dive in, I hate hacks and tunables to workaround 
bugs.  But as I have told, I see this code first time, so my solutions 
may appear not right.  But I'll help as I can, if needed.

-- 
Alexander Motin

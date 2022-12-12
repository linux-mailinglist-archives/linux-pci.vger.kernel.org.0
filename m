Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA6264A939
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 22:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiLLVKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 16:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiLLVKU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 16:10:20 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F8812AD2
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 13:10:18 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id cg5so10142469qtb.12
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 13:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZElR/i3qIpvoamHe5o1flBC7ahh+gLiU83zIQ0+fqY=;
        b=dg+nllr9m+0N1y5HDs+3GUcTUOrQFuaIvcQ+dG6gMJrHFmXKyg1Q5/VPIT0WsgyyVY
         ISmhfKVp2ZAzeUMfTdVhps1fj/AjT0cWHrNXQWLmE5Z0M2DF381Q3Yffr/BKIrZlREIb
         qT6nWJw7EzQXjxhEGkwtZO/70kj6UfGHufuz1PrXHn2O+OXlarBiGQf2mdH/FwoqXCiS
         /uNkKAC7NE1AZCsJTvTAnRWrH00oOvtXzlSMIyA9jdIK7Me52jKRMvYzkxAilfZz5KcJ
         wZbaJTiZx/i6ywc9L6J+tEoE4lBQpdjbkVLw7TIUUWLQmO6YyQeVZ5ggZs11RAqBwXO3
         NQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZElR/i3qIpvoamHe5o1flBC7ahh+gLiU83zIQ0+fqY=;
        b=zESHcD36qNZ60O1gavG/658ezgv8xCI8KyopufXNXBGMybIqpiW6KW/BIt8qXjvMXZ
         4hwvaSr+Bxq7HYz1nAFVHSdy0jS0JLAeYiDKzYc9Kt/oey1dYtRPMgrmuxtGroJyyejZ
         PdURrLfBqSqouH0F3E933LVWT2pt0pQZfIx5JweDqcjKiY6DNe+h0gIdUci04z10135Z
         V6GmkpwgQ1oH953xqtqXo2oDxoruW+VV4UExda6ScCXHWRm7EGV2z9JZ4JJFG4Llmq+4
         c+jmsqHX4+wHXPrrK0qlIxX8nrYLFX/y6YIu9tvSPyJPXsEA8DOC58RhhHZVMWv+moT1
         xbfA==
X-Gm-Message-State: ANoB5pkUtMzwy7ooNt1huP2UBVK81pA3OcX7eX0qndgeI3l1TpUSdOEY
        z8l5KWHXHMk1HwTLorQ+p556/Q==
X-Google-Smtp-Source: AA0mqf7In6ZQ5yyysnIVIDDvXqHuOd/NsxV1nP77BH329wuavYSh3ByT357k+n9yeGqnegFqCbwA9g==
X-Received: by 2002:a05:622a:2487:b0:39c:da21:f1a2 with SMTP id cn7-20020a05622a248700b0039cda21f1a2mr28881631qtb.3.1670879417980;
        Mon, 12 Dec 2022 13:10:17 -0800 (PST)
Received: from [10.230.45.5] ([38.32.73.2])
        by smtp.gmail.com with ESMTPSA id x1-20020ac85381000000b003a7eceb8cbasm6304209qtp.90.2022.12.12.13.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 13:10:17 -0800 (PST)
Message-ID: <6053736d-1923-41e7-def9-7585ce1772d9@ixsystems.com>
Date:   Mon, 12 Dec 2022 16:10:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: pci_bus_distribute_available_resources() is wrong?
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Nick Wolff <nwolff@ixsystems.com>,
        Bjorn Helgaas <bjorn@helgaas.com>, linux-pci@vger.kernel.org
References: <2ec11223-edb3-5f5c-62cd-3532d92de0a4@ixsystems.com>
 <CAErSpo7WrAg5D4xyv0SycoDc1etSspU_TL6XMAK4STYrXDrGNQ@mail.gmail.com>
From:   Alexander Motin <mav@ixsystems.com>
In-Reply-To: <CAErSpo7WrAg5D4xyv0SycoDc1etSspU_TL6XMAK4STYrXDrGNQ@mail.gmail.com>
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

On 12.12.2022 15:32, Bjorn Helgaas wrote:
> On Mon, Dec 12, 2022 at 1:36 PM Alexander Motin <mav@ixsystems.com> wrote:
>> Hi,
>>
>> I am writing to you three as the authors of Linux
>> drivers/pci/setup-bus.c pci_bus_distribute_available_resources()
>> function.  Trying to debug PCI hot-plug issue on passive side of AMD NTB
>> I hit this function, behavior of which I looks very suspicious to me,
>> which I believe cause resource allocation problems we observe.
>>
>> As I see, this function distributes extra size of parent memory window
>> of hot-plug PCI bridge between memory windows of child bridges.  It
>> probably makes some sense, but I see a problem in the fact that the
>> function only looks on children bridge memory windows, but not any other
>> resources (of bridges or other devices that may be there).
>>
>> In my AMD NTB case PCI topology looks this way:
>>
>> +-[0000:80]-+-00.0
>> |           +-01.1-[81-83]----00.0-[82-83]----00.0-[83]--+-00.0 Dummy
>> |           |                                            \-00.1 NTB
>>
>> 80:01.1 is the root bridge where the hot-plug happens.  The 81:00.0
>> bridge in addition to memory windows has small 16KB BAR.  But since it
>> is the only bridge on the bus, the function passes all available
>> resources down to its children.  As result, that BAR fails to allocate.
>>    And while that BAR seems not really needed, in some cases the
>> allocation error makes whole memory window to be disabled, that ends up
>> in NTB device driver attach failure.
> 
> Mika is working on what sounds like the same problem.  His current
> patch series is at
> https://lore.kernel.org/linux-pci/20221130112221.66612-1-mika.westerberg@linux.intel.com/
> 
> We would appreciate your comments and testing as that series is developed.

Thank you, Bjorn.  This definitely looks related, but as you've already 
noted in your review there, present patch does not handle BARs of the 
bridge itself, that I have in my case.  I'd be happy to test the updated 
patch.  Please keep me in a loop.

I also agree with your comment that the same should be done in case of 
multiple bridges.  I am generally not sure the cases of single bridge or 
not having hot-plug on this level should be any specific.

>> It may be rare to see PCI bridges with BARs, but I know that at least
>> some PLX bridges also have BARs for configuration purposes.  Also I
>> suppose the same problem would happen if there are other device on the
>> bus aside of the bridge.
>>
>> I've tried to disable pci_bus_distribute_available_resources(), and it
>> fixed the problem.  But I suppose it may cause problems in cases for
>> which this function was developed (hot-plug of JBOD supporting
>> hot-plug?).  Am I right?
>>
>> I would appreciate your feedback on this issue.  I am new to this code
>> area of Linux and not sure how to better fix this, but the way the code
>> is written now looks very wrong to me.
>>
>> Thanks.
>>
>> --
>> Alexander Motin

-- 
Alexander Motin

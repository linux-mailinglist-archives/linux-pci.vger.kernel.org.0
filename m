Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43563113513
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2019 19:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfLDSgm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Dec 2019 13:36:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38730 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbfLDSgm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Dec 2019 13:36:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so845104wmi.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Dec 2019 10:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wK9NstZxWCZ4fUNQKTAEIPBZ++U8z5OdNqnEeiQMgbs=;
        b=TBoXeX0LWp6vtluo0nZrXJ+HWtp6RtDGftL1htkZ25cbrFAgcczcvS6SGQxLQ/S9DF
         U6C+bJHCD9Nw5DYneQ5qat7aDKfmutIcMCWejKtLDLpb1WQGzCauCHqoCOTKbO7g7Seu
         LC6j8E+J3jdAHjZ2AfyyQ7Cb+CO2t6UECM2cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wK9NstZxWCZ4fUNQKTAEIPBZ++U8z5OdNqnEeiQMgbs=;
        b=cF78Ef3na0FE+bRPIYRM33GatB9XutLmYBeN4VklMgv+T5nIo0zZlVCOpQBZPCCTFQ
         5CFuZqJVuB2Njh0xArvB6Y2mnQ3S6+/QQYNTuEngoAOv54ls9idVHwVsQWtKeI1ijsT3
         Wt9ttgWRKalzoXrWiSlyZNqhIZSB0rABfhg8hY2kCnl9XIFuyzvUgvx2h6gK3lp86nQ8
         8vkVPObCMpTQacan9NyV6aMpRyp+o7GpbHn4KgO8eINT4q3+jr3xgMhi35aMRVrFG9is
         ZC0p2pzM8g/Mrf+WCm4Iqo70/PK2GwA3VyR3IglbeyeRYFveGsANoUuOsclsdBPYQZ8f
         A0eg==
X-Gm-Message-State: APjAAAXnNY0VsCxkjsx97JkykID6b6xNSJVec/2alE8EGnGiNi/eZAVX
        Rtktl5UTtle1uAWJmNI/VgKxHw==
X-Google-Smtp-Source: APXvYqz+06y7g6bDkQSJIocMFzOIfNFtedSXUAM0Vi8Dq5sgC91y+7beIJR+jMAFvOyXeJK38vDwgg==
X-Received: by 2002:a1c:7f4e:: with SMTP id a75mr1044364wmd.128.1575484598710;
        Wed, 04 Dec 2019 10:36:38 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id n1sm9145299wrw.52.2019.12.04.10.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 10:36:37 -0800 (PST)
Subject: Re: [PATCH v3 2/6] PCI: iproc: Add INTx support with better modeling
To:     Andrew Murray <andrew.murray@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1575349026-8743-1-git-send-email-srinath.mannam@broadcom.com>
 <1575349026-8743-3-git-send-email-srinath.mannam@broadcom.com>
 <20191203155514.GE18399@e119886-lin.cambridge.arm.com>
 <CAHp75Vf7d=Gw24MTq2q3BKspkLEDDM24GVK4Zh_4zfZEzVuZjw@mail.gmail.com>
 <40fffa66-4b06-a851-84c2-4de36d5c6777@broadcom.com>
 <CAHp75VfyKAg4OhzUa4swGXOGTvJ5fVO8mhGSG=5HAUP__M-URQ@mail.gmail.com>
 <20191204160729.GJ18399@e119886-lin.cambridge.arm.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <d07d22bc-5ec2-8a0f-22af-6eb89cd68e55@broadcom.com>
Date:   Wed, 4 Dec 2019 10:36:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191204160729.GJ18399@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/4/19 8:07 AM, Andrew Murray wrote:
> On Wed, Dec 04, 2019 at 10:29:51AM +0200, Andy Shevchenko wrote:
>> On Wed, Dec 4, 2019 at 12:09 AM Ray Jui <ray.jui@broadcom.com> wrote:
>>> On 12/3/19 11:27 AM, Andy Shevchenko wrote:
>>>> On Tue, Dec 3, 2019 at 5:55 PM Andrew Murray <andrew.murray@arm.com> wrote:
>>>>> On Tue, Dec 03, 2019 at 10:27:02AM +0530, Srinath Mannam wrote:
>>>>
>>>>>> +     /* go through INTx A, B, C, D until all interrupts are handled */
>>>>>> +     do {
>>>>>> +             status = iproc_pcie_read_reg(pcie, IPROC_PCIE_INTX_CSR);
>>>>>
>>>>> By performing this read once and outside of the do/while loop you may improve
>>>>> performance. I wonder how probable it is to get another INTx whilst handling
>>>>> one?
>>>>
>>>> May I ask how it can be improved?
>>>> One read will be needed any way, and so does this code.
>>>>
>>>
>>> I guess the current code will cause the IPROC_PCIE_INTX_CSR register to
>>> be read TWICE, if it's ever set to start with.
>>>
>>> But then if we do it outside of the while loop, if we ever receive an
>>> interrupt while servicing one, the interrupt will still need to be
>>> serviced, and in this case, it will cause additional context switch
>>> overhead by going out and back in the interrupt context.
> 
> Yes it's a trade off - if you dropped the do/while loop and thus had a single
> read you'd reduce the overhead on interrupt handling in every case except
> where another INTx is received whilst in this function. But as you point out
> each time that does happen you'll pay the penalty of a context switch.
>

Exactly, it's a tradeoff between: 1) saving one register read (which is 
likely in the 10th of nanosecond range) in all INTx handling; and 2) 
saving context switches (which is likely in 10th of microsecond range) 
in cases when we have multiple INTx when servicing it.

The current implementation takes 2), which I thought it makes sense.

> I don't have any knowledge of this platform so I have no idea if such a change
> would be good/bad or material. However I thought I'd point it out. Looking at
> the other controller drivers, some handle in a loop and some don't.
> 
> 
>>>
>>> My take is that it's probably more ideal to leave this portion of code
>>> as it is.
>>
>> Can't we simple drop a do-while completely and leave only
>> for_each_set_bit() loop?
>>

Like both Andrew and I pointed out. There's a tradeoff here. Could you 
please help to justify why you favor 1) than 2)?

> 
> I'm happy either way.
> 
> Thanks,
> 
> Andrew Murray
> 
>>>
>>>>>> +             for_each_set_bit(bit, &status, PCI_NUM_INTX) {
>>>>>> +                     virq = irq_find_mapping(pcie->irq_domain, bit);
>>>>>> +                     if (virq)
>>>>>> +                             generic_handle_irq(virq);
>>>>>> +                     else
>>>>>> +                             dev_err(dev, "unexpected INTx%u\n", bit);
>>>>>> +             }
>>>>>> +     } while ((status & SYS_RC_INTX_MASK) != 0);
>>>>
>>
>>
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD90580565
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 22:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbiGYUTA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 16:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiGYUS7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 16:18:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234CBBBE;
        Mon, 25 Jul 2022 13:18:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c3so11395478pfb.13;
        Mon, 25 Jul 2022 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=olf53UeogxTstZS2RbTCodhGf9jpAy+ey+tMVtH2a7Y=;
        b=Nn+LuUkUFgcWFbdTzJIZ98XM4XKFfJixXUreDZ0aXqQG2yVkINdtWdAdCMZWl1f+1P
         Hiw6G+yS3Tvzs0+x/w20m+jzTJrG5dlaLFdNHUF6ZMx5dsEzQWkI3HrIpLREvgvFZqVD
         f9ceinAKbmPifdBESWUiRbZcBo9Hqv2sVsf1azOeEP5o9nWjSjG3saTWPEWIl8Lqr/SC
         4Yl2+MGMqMD9mpCP5Wn/D4h9w+KLse8VhsDY+43ppfA5UBUpU9rw21A18wbt3C9qQJZj
         m0qpKyXeMVB2KSw311gjcVeO/1zgd6I6czUBEEu5vw4oJiG9x3M8XsPV43nLyBth280R
         bYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=olf53UeogxTstZS2RbTCodhGf9jpAy+ey+tMVtH2a7Y=;
        b=5e8GXOODfPku6d1HryKPXKMhqVn2mmAat8gpjs1b1BayvHv61m1MLyBRvdR9nmTPYM
         2n8KNtIHW8G1MB+6WR+yoYmOTW5c9lh9bcnAaVDnFBDN9lhBPfxN5HlNRex/1+g6vOUB
         m2t4ivjTYghjybEQ1OtQP0fR7Fa4Q8VOPUvRPjK2/an94F1uHJRK0X7lBDYOvGiUJWkk
         6bnA3WvLh/ZlajUoyJ5PAD1gyBaPtPRTBIo20B2rZTR2wAGgMOPhNu9zhjtU2KQWGHwh
         J83dySEbsQ9MpEP3cKioB+p0+ukrtXT90+WQ0To7blnQ0duwEHnDdN1ywJlggMNsfj6c
         kjCg==
X-Gm-Message-State: AJIora+VcSN+wcIIUxKeKebq7RLlyIZfJ3CEzFJxyGJl9GJBwqGTuHB8
        TYePDvwIF5oRTmTvYAeWIaw=
X-Google-Smtp-Source: AGRyM1uXWD5oxtPMXz49Cfg0lK9RSrHoOz7tiYiVb46JM/Fx1ZxuTsdLG4OLMQtPeqifqk/K+y7r8w==
X-Received: by 2002:a63:696:0:b0:41a:1c20:bf5f with SMTP id 144-20020a630696000000b0041a1c20bf5fmr12435298pgg.402.1658780338430;
        Mon, 25 Jul 2022 13:18:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o63-20020a625a42000000b0052ba70ea97esm9990995pfb.30.2022.07.25.13.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 13:18:57 -0700 (PDT)
Message-ID: <1e71ad64-f5bc-2581-87b8-9bd0932a7875@gmail.com>
Date:   Mon, 25 Jul 2022 13:18:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        linux-kernel@vger.kernel.org
References: <87k085xekg.wl-maz@kernel.org> <20220722171706.GA1911557@bhelgaas>
 <877d42df5t.wl-maz@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <877d42df5t.wl-maz@kernel.org>
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

On 7/24/22 02:38, Marc Zyngier wrote:
> On Fri, 22 Jul 2022 18:17:06 +0100,
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> On Fri, Jul 22, 2022 at 06:06:07PM +0100, Marc Zyngier wrote:
>>> On Fri, 22 Jul 2022 15:39:05 +0100,
>>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>
>>>> [+cc Marc, can you clarify when we need irq_dispose_mapping()?]
>>>
>>> In general, interrupt controllers should not have to discard mappings
>>> themselves, just like they rarely create mappings themselves. That's
>>> usually a different layer that has created it (DT, for example).
>>>
>>> The problem is that these mappings persist even if the interrupt has
>>> been released by the driver (it called free_irq()), and the IRQ number
>>> can be further reused. The client driver could dispose of the mapping
>>> after having released the IRQ, but nobody does that in practice.
>>>
>>> From the point of view of the controller, there is no simple way to
>>> tell when an interrupt is "unused". And even if a driver was
>>> overzealous and called irq_dispose_mapping() on all the possible
>>> mappings (and made sure no mapping could be created in parallel), this
>>> could result in a bunch of dangling pointers should a client driver
>>> still have the interrupt requested.
>>>
>>> Fixing this is pretty hard, as IRQ descriptors are leaky (you can
>>> either have a pointer to one, or just an IRQ number -- they are
>>> strictly equivalent). So in general, being able to remove an interrupt
>>> controller driver is at best fragile, and I'm trying not to get more
>>> of this in the tree.
>>
>> Thank you!
>>
>> How do we identify an interrupt controller driver?  Apparently some of
>> these PCIe controller drivers also include an interrupt controller
>> driver, but I don't know what to look for to find them.
> 
> If you see a struct irq_chip somewhere, this is an interrupt
> controller.  And yes, most of the PCIe RC drivers will have some sort
> of interrupt controller driver for INTx support, as well as MSI when
> the RC doesn't/cannot rely on the platform providing one.
> 
> It means that these PCIe RC drivers probably shouldn't be removable if
> built as modules. Which I don't think is a big problem. You want
> modularity to reduce the size of the kernel image and only load the
> drivers the platform actually requires, saving memory in the process.
> And for something as fundamental as an interrupt controller (and PCIe
> in general), you probably want to keep it around for the lifetime of
> the machine.

No disagreement, however being able to fully remove and load the module again ensures that you bring the hardware and software in a sane state every time, i.e.: it does help find actual bugs in either implementations. It's also a faster turn around time if you are working on that specific subsystem in avoid rebooting the kernel needlessly (that puts a lot of faith into not crashing the kernel, still).
-- 
Florian

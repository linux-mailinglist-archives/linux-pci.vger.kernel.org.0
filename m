Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E407C827F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 11:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjJMJwo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 05:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjJMJwn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 05:52:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711CBA9
        for <linux-pci@vger.kernel.org>; Fri, 13 Oct 2023 02:52:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32d569e73acso1774418f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Oct 2023 02:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697190759; x=1697795559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5FxkPhY8PvdxDUjhcFXE9F6Xtdw5ZXN999DW1QK8Nyc=;
        b=lgBOh+gcgTxhJUEGjLuDqWedqk9Fd1c6bcHSHRwSfZgkofHMxDs385FJbZwoomDRzc
         TkCNNM0IVJLRoXnsAo44VY+tnNwiWPGrv1A60jLxYss9T/10KkHummSwR68W3kL3MZdG
         dThyURK/gm3RGX5f6BQZP7sZs6Dd8s1Sb1bDiik86ZDWOfQ0MXvBV2KWq8+blfW375ZP
         8d8hhOde2rxRmlAQmr7EXWndbPEIdHdUYc0cz5eJmrdYWLkn+/BC9PTNbiM+32yyRD8+
         a4bFLwBnCXA7JwxgpkNc5ZkA6wpiu2VkZpWGeo2mAs2rLEEHOPPmZ3sjWSXHnZi/9Opg
         ruFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697190759; x=1697795559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5FxkPhY8PvdxDUjhcFXE9F6Xtdw5ZXN999DW1QK8Nyc=;
        b=FO7NsUXGRq2nlVyMPZjYLmHjoG/CFXMjQtb0p7EaSEXSeTEeuzMp1xGfwtX4DDmngn
         64suS95gIuMCxwJBqWFiue8FFvhqVtb+WA6Lttyhs80SBnieorxHvFWRAO54lRH7uuju
         IzGZzCWxGEL3sV9hhLV41FhRTUA61Q10yPSPoYGCpQ2z6lIbl1s9/Z2nijug0m1DsyNp
         eSsn9FBMLXNSOutFCXRvgSaWk7bU16ztI0XQIlXzRScpcxTlqJlco0K/9PpixJ4TWylD
         rrcyGDbAFo5JJkb3PvcNg0QtXSGbZ7pY9aZCacZiNVuOTkF6eElfr4h4Xks21JsYtofs
         k3rw==
X-Gm-Message-State: AOJu0Yyi+HzBh/MuUhSkf+LaeLMNdME4QwrUcDucX+P7FUfnNMiJbfMd
        lGoNzycWsOa7Ti1DaFHx4mh/Vg==
X-Google-Smtp-Source: AGHT+IFa51+3/J8OTpoR8VcKmoz0SzIMvteDMrUo8/A0a1KY7iCHTzp6Jje0bJxKSD1urOV1oqMKfg==
X-Received: by 2002:a5d:52c9:0:b0:317:67bf:3376 with SMTP id r9-20020a5d52c9000000b0031767bf3376mr21980185wrv.57.1697190758726;
        Fri, 13 Oct 2023 02:52:38 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d678a000000b0032d9f32b96csm695921wru.62.2023.10.13.02.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 02:52:38 -0700 (PDT)
Message-ID: <4abb7906-1e5a-4a4d-91c9-0e90c027867a@baylibre.com>
Date:   Fri, 13 Oct 2023 11:52:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: mediatek-gen3: Fix translation window
To:     =?UTF-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>, "robh@kernel.org" <robh@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
        =?UTF-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <Chuanjia.Liu@mediatek.com>,
        =?UTF-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>,
        =?UTF-8?B?UWl6aG9uZyBDaGVuZyAo56iL5ZWf5b+gKQ==?= 
        <Qizhong.Cheng@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>
References: <20231011122633.31559-1-jianjun.wang@mediatek.com>
 <899c7275-ccca-43bb-b1ae-a3403dd18622@baylibre.com>
 <088559162e5ec4e2d6d38d8a5707c6e0e12f5ac6.camel@mediatek.com>
 <54ed1269-8699-4531-abc6-09b602adece9@baylibre.com>
 <930f6df4-3267-59df-ad75-244f5b9cee84@collabora.com>
 <2e9766db-da12-42e6-80a8-b9ef6f2de724@baylibre.com>
 <3dd20c59969a312607cb4bdb58643c8d2ffa9f86.camel@mediatek.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <3dd20c59969a312607cb4bdb58643c8d2ffa9f86.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 13/10/2023 04:52, Jianjun Wang (王建军) wrote:
> On Thu, 2023-10-12 at 15:30 +0200, Alexandre Mergnat wrote:
>>   
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  
>> 
>> On 12/10/2023 14:52, AngeloGioacchino Del Regno wrote:
>> > Il 12/10/23 12:27, Alexandre Mergnat ha scritto:
>> >>
>> >>
>> >> On 12/10/2023 08:17, Jianjun Wang (王建军) wrote:
>> >>> On Wed, 2023-10-11 at 17:38 +0200, Alexandre Mergnat wrote:
>> >>>> External email : Please do not click links or open attachments
>> until
>> >>>> you have verified the sender or the content.
>> >>>>
>> >>>>
>> >>>> On 11/10/2023 14:26, Jianjun Wang wrote:
>> >>>> > The size of translation table should be a power of 2, using
>> fls()
>> >>>> cannot > get the proper value when the size is not a power of 2.
>> For
>> >>>> example, > fls(0x3e00000) - 1 = 25, hence the PCIe translation 
>> >>>> window size
>> >>>> will be > set to 0x2000000 instead of the expected size
>> 0x3e00000. Fix
>> >>>> translation > window by splitting the MMIO space to multiple
>> tables 
>> >>>> if its size
>> >>>> is not > a power of 2.
>> >>>>
>> >>>> Hi Jianjun,
>> >>>>
>> >>>> I've no knowledge in PCIE, so maybe what my suggestion is
>> stupid:
>> >>>>
>> >>>> Is it mandatory to fit the translation table size with 0x3e00000
>> (in 
>> >>>> this example) ?
>> >>>> I'm asking because you can have an issue by reaching the
>> maximum 
>> >>>> translation table number.
>> >>>>
>> >>>> Is it possible to just use only one table with the power of 2
>> size
>> >>>> above 0x3e00000 => 0x4000000 ( fls(0x3e00000) = 26 = 0x4000000).
>> The
>> >>>> downside of this method is wasting allocation space. AFAIK I
>> already 
>> >>>> see this kind of method for memory protection/allocation in
>> embedded 
>> >>>> systems,
>> >>>> so I'm wondering if this method is safer than using multiple
>> table for
>> >>>> only one size which isn't a power of 2.
>> >>>
>> >>> Hi Alexandre,
>> >>>
>> >>> It's not mandatory to fit the translation table size with
>> 0x3e00000,
>> >>> and yes we can use only one table with the power of 2 size to
>> prevent
>> >>> this.
>> >>>
>> >>> For MediaTek's SoCs, the MMIO space range for each PCIe port is
>> fixed,
>> >>> and it will always be a power of 2, most of them will be 64MB.
>> The
>> >>> reason we have the size which isn't a power of 2 is that we
>> reserve an
>> >>> IO space for compatible purpose, some older devices may still use
>> IO
>> >>> space.
>> >>>
>> >>> Take MT8195 as an example, its MMIO size is 64MB, and the
>> declaration
>> >>> in the DT is like:
>> >>> ranges = <0x81000000 0 0x20000000 0x0 0x20000000 0 0x200000>,
>> >>>           <0x82000000 0 0x20200000 0x0 0x20200000 0 0x3e00000>;
>> >>>
>> >>> The MMIO space is splited to 2MB IO space and 62MB MEM space,
>> that's
>> >>> cause the current risk of the MEM space range, its actual
>> available MEM
>> >>> space is 32MB. But it still works for now because most of the
>> devices
>> >>> only require a very small amount of MEM space and will not reach
>> ranges
>> >>> higher than 32MB.
>> >>>
>> >>> So for the concern of reaching the maximum translation table
>> number, I
>> >>> think maybe we can just print the warning message instead of
>> return
>> >>> error code, since it still works but have some limitations(MEM
>> space
>> >>> not set as DT expected).
>> >>>
>> >>
>> >> Ok understood, thanks for your explanation.
>> >> Then, IMHO, you should use only one table with the power of 2
>> size 
>> >> above to make the code simpler, efficient, robust, more readable
>> and 
>> >> avoid confusion about the warning.
>> >>
>> >> This is what is done for pci-mvebu.c AFAII.
>> >>
>> >> If you prefer waiting another reviewer with a better PCIE
>> expertise 
>> >> than me, it's ok for me. With the information I have currently, I 
>> >> prefer to not approve the current implementation because, from my
>> PoV, 
>> >> it introduce unnecessary complexity.
>> >>
>> > 
>> >  From what I understand, using only one table with a size that is
>> a 
>> > power of two
>> > won't let us use the entire MMIO space, hence the only solution to
>> allow 
>> > using
>> > the entire range is to split to more than one table.
>> 
>> You can take the power of 2 above, which is directly returned by
>> fls().
>> That let us use the entire MMIO space.
>> In this example, if your size is 0x3e00000, the you will allow
>> 0x4000000.
> 
> Take the power of 2 above size is a solution, but another concern will
> be the flexibility. With this patch, we can split the MMIO space to
> multiple ranges like:
> ranges = <0x82000000 0 0x20000000 0x0 0x20000000 0 0x100000>,
>           <0x81000000 0 0x20100000 0x0 0x20100000 0 0x300000>,
>           <0x82000000 0 0x20300000 0x0 0x20300000 0 0x3c00000>;
> Not sure if that can really happen, but it will have overlap ranges
> when take the power of 2 above.

Yes, you can avoid overlap by changing the next start address to fit the 
previous allocated range. If that isn't possible or introduce too much 
complexity compared to your solution, then your implementation could be 
the best from my PoV. :)


-- 
Regards,
Alexandre

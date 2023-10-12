Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20907C6B14
	for <lists+linux-pci@lfdr.de>; Thu, 12 Oct 2023 12:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343796AbjJLK1g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Oct 2023 06:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343654AbjJLK1f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 06:27:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFAEB7
        for <linux-pci@vger.kernel.org>; Thu, 12 Oct 2023 03:27:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3226b8de467so703950f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 12 Oct 2023 03:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697106451; x=1697711251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmBkcHAkPFx5rOPRPDBllwN3fSbL73RuCNWurkhctsI=;
        b=TUrVWWG6cj8ZcvlpltH25cb5xQCnlI5AwNjQkVaUfUj99Ox+OR8LJ+GAiDUQJoh/iU
         K68C2Jm7QhZrO8LwSy5vWB4o1sXv8H7WNkTxegdu1jJmnEKybgt89ywQKBQnkpZdA3Yb
         jAmk/ME8XcMRm2rQwBy1g/o0JvgiwnCqDTkeXrpzmf2X1VfVmUvojc7LgwAYFGE4trmv
         AvR3sz8Yyu1B3nJvwCzatEO/erJ5HDzhXrtV9vRKIzsrvsDAX8ZA3QWSwc13v80vnDmM
         /7N7atwjf+yCyKXf3PBHyBv0bscMbVFvjfSASQDsNsPotFuFvu5eqTga+k4gj/6NaiLz
         Y7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697106451; x=1697711251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmBkcHAkPFx5rOPRPDBllwN3fSbL73RuCNWurkhctsI=;
        b=B+Mv0hwimuDpxl7NXeXuu4nyDrjMm9WMN++PgA0E5bBg+IWaCM+pIvDauwWDJS3PAF
         85B2hH6/YXs/KXAigORqrL2RfMW+BHUb9Fhzp909jc69t+S6dHRXWTy0LcVY0WFrJxV5
         U46OaknPu0zNj/VXI7arOQOnBwUnRnjg/N4+QBekUx0yc36TyZjvxaEOcBe/VIquzL60
         XuzXv4dfM8exZm3jYRdZMV5fSglkzeCt5Wjb+p1Hrp5o8rDSG+UEhw8IZMPYcxljz5KN
         AuCLA/DKeMTfxXO24RmCkWSuM8097vxTEDp/xWkTHZooyv9g0Q43EKc8/0Wlai2CHWuv
         ge8Q==
X-Gm-Message-State: AOJu0YyQ9NJzZMJT5v+p4AFVoxOkIRXUaGHNUsYFbx8AhgehJTklCiBQ
        hWLQC/LWbwI2bqahkBVUke7W3w==
X-Google-Smtp-Source: AGHT+IHI1GZ3O+8Vul/1ATMdkAYGJnPS9jhdVvjZ8iYcdUltF97CUA2PT7IYjpRMObjiWrOl4/DhyQ==
X-Received: by 2002:a05:6000:91:b0:317:5f13:5c2f with SMTP id m17-20020a056000009100b003175f135c2fmr19207742wrx.0.1697106451193;
        Thu, 12 Oct 2023 03:27:31 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id f16-20020adfdb50000000b0031ff89af0e4sm17968546wrj.99.2023.10.12.03.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 03:27:30 -0700 (PDT)
Message-ID: <54ed1269-8699-4531-abc6-09b602adece9@baylibre.com>
Date:   Thu, 12 Oct 2023 12:27:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: mediatek-gen3: Fix translation window
Content-Language: en-US
To:     =?UTF-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>, "robh@kernel.org" <robh@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
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
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <088559162e5ec4e2d6d38d8a5707c6e0e12f5ac6.camel@mediatek.com>
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



On 12/10/2023 08:17, Jianjun Wang (王建军) wrote:
> On Wed, 2023-10-11 at 17:38 +0200, Alexandre Mergnat wrote:
>>   
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  
>> 
>> On 11/10/2023 14:26, Jianjun Wang wrote:
>> > The size of translation table should be a power of 2, using fls()
>> cannot 
>> > get the proper value when the size is not a power of 2. For
>> example, 
>> > fls(0x3e00000) - 1 = 25, hence the PCIe translation window size
>> will be 
>> > set to 0x2000000 instead of the expected size 0x3e00000. Fix
>> translation 
>> > window by splitting the MMIO space to multiple tables if its size
>> is not 
>> > a power of 2.
>> 
>> Hi Jianjun,
>> 
>> I've no knowledge in PCIE, so maybe what my suggestion is stupid:
>> 
>> Is it mandatory to fit the translation table size with 0x3e00000 (in 
>> this example) ?
>> I'm asking because you can have an issue by reaching the maximum 
>> translation table number.
>> 
>> Is it possible to just use only one table with the power of 2 size
>> above 
>> 0x3e00000 => 0x4000000 ( fls(0x3e00000) = 26 = 0x4000000). The
>> downside 
>> of this method is wasting allocation space. AFAIK I already see this 
>> kind of method for memory protection/allocation in embedded systems,
>> so 
>> I'm wondering if this method is safer than using multiple table for
>> only 
>> one size which isn't a power of 2.
> 
> Hi Alexandre,
> 
> It's not mandatory to fit the translation table size with 0x3e00000,
> and yes we can use only one table with the power of 2 size to prevent
> this.
> 
> For MediaTek's SoCs, the MMIO space range for each PCIe port is fixed,
> and it will always be a power of 2, most of them will be 64MB. The
> reason we have the size which isn't a power of 2 is that we reserve an
> IO space for compatible purpose, some older devices may still use IO
> space.
> 
> Take MT8195 as an example, its MMIO size is 64MB, and the declaration
> in the DT is like:
> ranges = <0x81000000 0 0x20000000 0x0 0x20000000 0 0x200000>,
>           <0x82000000 0 0x20200000 0x0 0x20200000 0 0x3e00000>;
> 
> The MMIO space is splited to 2MB IO space and 62MB MEM space, that's
> cause the current risk of the MEM space range, its actual available MEM
> space is 32MB. But it still works for now because most of the devices
> only require a very small amount of MEM space and will not reach ranges
> higher than 32MB.
> 
> So for the concern of reaching the maximum translation table number, I
> think maybe we can just print the warning message instead of return
> error code, since it still works but have some limitations(MEM space
> not set as DT expected).
> 

Ok understood, thanks for your explanation.
Then, IMHO, you should use only one table with the power of 2 size above 
to make the code simpler, efficient, robust, more readable and avoid 
confusion about the warning.

This is what is done for pci-mvebu.c AFAII.

If you prefer waiting another reviewer with a better PCIE expertise than 
me, it's ok for me. With the information I have currently, I prefer to 
not approve the current implementation because, from my PoV, it 
introduce unnecessary complexity.

Thanks


-- 
Regards,
Alexandre

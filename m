Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DEE4EA808
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 08:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiC2Gnw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 02:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiC2Gnv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 02:43:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E98249C59;
        Mon, 28 Mar 2022 23:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4183161512;
        Tue, 29 Mar 2022 06:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC09C2BBE4;
        Tue, 29 Mar 2022 06:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648536126;
        bh=KcEfxDe9kAuDSImnqtYl4PiodQh5LDPDefrNdl/cgeY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hsjansLgElHV/CJ6UrvWUBFL9ehiJ8W+cyFqgsqeICUkD3gqmTsAqKN5yX+sW0hyF
         f9HJWY0TpFwLGUg+qR+O7vd1JTJ84MnWNOI4gvtiQpDzgUGNiqMO8vfajPdD8M3GTW
         +QQNzk8AB0NkU37mPoNkmB2/Wt8mOKzFbEWs4wcbaUOOlKVlMTaCIHVx2d7+139sBm
         kiZuWC4T2LrEE0BNsDb1mM0q72qxfRk6k4NLC2kMI4WtOQA0qkszfEd0c4pKajMyxH
         EJ6tKbNMpP5KGr+5jfT6iVPQcfKAjBG0Pd4V42i87Io+fFb5Qil6sz0OzHPosEZ4dy
         VvIIcistU0Z0w==
Message-ID: <6dec8b28-5e6e-b53b-6351-aaa797d9078d@kernel.org>
Date:   Tue, 29 Mar 2022 08:41:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
Content-Language: en-US
To:     wangseok.lee@samsung.com,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        =?UTF-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
References: <fd3478ba-ebb9-c1bf-1823-dc03de80b76e@kernel.org>
 <564c7092-d6a3-7766-d83f-9762075d055f@kernel.org>
 <0716d9e4-24e1-d16c-162c-00a8664296e1@kernel.org>
 <20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p7>
 <20220328090200epcms2p8637d2a2e09a3a627be776586b80c8adf@epcms2p8>
 <20220328112918epcms2p44bfdd6ef74c14f04bae6a475054860b6@epcms2p4>
 <CGME20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p1>
 <20220329034949epcms2p1717d820646c878f314b03e07c2d092ba@epcms2p1>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220329034949epcms2p1717d820646c878f314b03e07c2d092ba@epcms2p1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/03/2022 05:49, 이왕석 wrote:
>> --------- Original Message ---------
>> Sender : Krzysztof Kozlowski <krzk@kernel.org>
>> Date : 2022-03-28 20:44 (GMT+9)
>> Title : Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
>>
>> On 28/03/2022 13:29, 이왕석 wrote:
>>>>  --------- Original Message ---------
>>>>  Sender : Krzysztof Kozlowski <krzk@kernel.org>
>>>>  Date : 2022-03-28 18:38 (GMT+9)
>>>>  Title : Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
>>>>
>>>>  On 28/03/2022 11:02, 이왕석 wrote:
>>>>>>   --------- Original Message ---------
>>>>>>   Sender : Krzysztof Kozlowski <krzk@kernel.org>
>>>>>>   Date : 2022-03-28 16:12 (GMT+9)
>>>>>>   Title : Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
>>>>>>
>>>>>>   On 28/03/2022 03:44, 이왕석 wrote:
>>>>>>>    This series patches include newly PCIe support for Axis ARTPEC-8 SoC.
>>>>>>>    ARTPEC-8 is the SoC platform of Axis Communications.
>>>>>>>    PCIe controller driver and phy driver have been newly added.
>>>>>>>    There is also a new MAINTAINER in the addition of phy driver.
>>>>>>>    PCIe controller is designed based on Design-Ware PCIe controller IP
>>>>>>>    and PCIe phy is desinged based on SAMSUNG PHY IP.
>>>>>>>    It also includes modifications to the Design-Ware controller driver to 
>>>>>>>    run the 64bit-based ARTPEC-8 PCIe controller driver.
>>>>>>>    It consists of 6 patches in total.
>>>>>>>    
>>>>>>>    This series has been tested on AXIS SW bring-up board 
>>>>>>>    with ARTPEC-8 chipset.
>>>>>>
>>>>>>   You lost mail threading. This makes reading this difficult for us. Plus
>>>>>>   you sent something non-applicable (patch #2), so please resend.
>>>>>>
>>>>>>   Knowing recent Samsung reluctance to extend existing drivers and always
>>>>>>   duplicate, please provide description/analysis why this driver cannot be
>>>>>>   combined with existing driver. The answer like: we need several syscon
>>>>>>   because we do not implement other frameworks (like interconnect) are not
>>>>>>   valid.
>>>>>>
>>>>>>   Best regards,
>>>>>>   Krzysztof
>>>>>   
>>>>>   Hello, Krzysztof
>>>>>   Thanks for your review.
>>>>>   
>>>>>   patch#2 was sent to the wrong format so sent again.
>>>>>   Sorry for causing confusion.
>>>>   
>>>>  The first sending was HTML. Second was broken text, so still not working.
>>>>
>>>>  Please resend everything with proper threading.
>>>  
>>>  Hello, Krzysztof
>>>  
>>>  I sent patch#2 three times.
>>>  due to the influence of the email system,
>>>  there was something wrong with the first and second mails.
>>>  Sorry for causing confusion.
>>>  Did you receive the third patch i sent you?
>>
>> Maybe, I don't know. It's not threaded so it's difficult to find it
>> among other 100 emails...
> 
> I think you also received a normal patch# 2.
> 
>>>   
>>>>>   This patch is specialized in Artpec-8, 
>>>>>   the SoC Platform of Axis Communication, and is newly applied.
>>>>>   Since the target SoC platform is different from the driver previously 
>>>>>   used by Samsung, it is difficult to merge with the existing driver.
>>>>
>>>>  Recently I always saw such answers and sometimes it was true, sometimes
>>>>  not. What is exactly different?
>>>>
>>>>  Best regards,
>>>>  Krzysztof
>>>  
>>>  The main reason this patch should be added is that
>>>  this patch is not the driver applied to exynos platform.
>>
>> Still this does not explain why you need separate driver.
> 
> PCIe driver of artpec-8 is not available in exynos platform.
> because the PCIe of artpec and exynos have very different 
> hardware in SoC design.
> Not only it is the SoC different, 
> but the hardware design of PCIe is also different.
> Therefore, we are using driver's compatible 
> as axis, artpec8-pcie rather than samsung, artpec8-pcie.

You keep repeating the same over and over. What is different? Drivers
can support different devices, I already wrote it. Just because device
is different does not mean it should have separate driver.

> 
>>>  Because the SoC platform is different, 
>>>  the IP configuration of PCIe is also different.
>>
>> What is exactly different? Usually drivers can support IP blocks with
>> some differences...
>>
>>>  We will organize a driver for Artpec-8 platform and 
>>>  if there is no special reason, maintain this 
>>>  without adding it from the next series.
>>
>> I don't understand this.
>>
>>
>> Best regards,
>> Krzysztof
> 
> Also, as you know,
> exynos driver is designed according to exynos SoC platform,
> so both function and variable names start with exynos.

That's hardly a problem...

> Compared to the existing exynos driver, 
> you can see that the structure and type of function are different.

No, I cannot see it. You coded the driver that way, you can code it in
other way.

> For this reason, it is difficult to use the existing exynos driver 
> for artpec.

Naming of functions and structures is not making it difficult. That's
not the reason.

> Our idea is to register a new PCIe driver for artpec-8 SoC platform 
> and maintain it in the future.

We also want to maintain Exynos PCIe driver in the future.

Best regards,
Krzysztof

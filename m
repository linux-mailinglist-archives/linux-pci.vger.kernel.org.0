Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328B04E9592
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 13:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbiC1LqW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 07:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243565AbiC1LpD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 07:45:03 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6126558821;
        Mon, 28 Mar 2022 04:40:48 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id y10so16531502edv.7;
        Mon, 28 Mar 2022 04:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eDubNeR8lpKK3svP84YhB5WCBn4ignuIyXSpyYoO2K4=;
        b=byZLHwsuKWsAWI5hf82R49vORLptruO5rxh9QO92bvEvdWcaIdwakSxbMbdK5rLRh3
         lm8XFSI7w+DV0EiAc+hzV7nK8gfvPwuDR8qPscGT36u6rVmKF3+npyb3Mx2KjhoaHTeX
         iqKlXHjEad2kDsTH7TP2NhwbMgFP3kTcwh6wqu0sqOrStF94TqJi0dXPyKYVG0CDNjQJ
         csEwunw9ZzcH7FEU9Qx0m1cE3OCUGLUVUpnpgli45GM6uXj5Zp7mY708RrNKs4PPyJvH
         j4eaPJVlblOLsGDez14QCRfI5FQWy5Ua6B7BQ9pkASCA5gXPxxxqlAVW0+uLm+a77id8
         618w==
X-Gm-Message-State: AOAM5306odNl9yTT4ocHOocqj3Rb+Q4YYrONita8sSgFvmon5LUlvhQ5
        MXWKudoOmerYh2H37t+4H4E=
X-Google-Smtp-Source: ABdhPJz4zSei/ored2fJWGSc6ht4oW/5m5HsFDCl4Z5ds/QUVoxsSJ2wzA/cQ6qtCavbiz4YtEhqwg==
X-Received: by 2002:aa7:cb93:0:b0:415:d57a:4603 with SMTP id r19-20020aa7cb93000000b00415d57a4603mr15378617edt.62.1648467614194;
        Mon, 28 Mar 2022 04:40:14 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id hs12-20020a1709073e8c00b006dfdfdac005sm5836373ejc.174.2022.03.28.04.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 04:40:13 -0700 (PDT)
Message-ID: <fd3478ba-ebb9-c1bf-1823-dc03de80b76e@kernel.org>
Date:   Mon, 28 Mar 2022 13:40:11 +0200
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
References: <564c7092-d6a3-7766-d83f-9762075d055f@kernel.org>
 <0716d9e4-24e1-d16c-162c-00a8664296e1@kernel.org>
 <20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p7>
 <20220328090200epcms2p8637d2a2e09a3a627be776586b80c8adf@epcms2p8>
 <CGME20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p4>
 <20220328112918epcms2p44bfdd6ef74c14f04bae6a475054860b6@epcms2p4>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220328112918epcms2p44bfdd6ef74c14f04bae6a475054860b6@epcms2p4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/03/2022 13:29, 이왕석 wrote:
>> --------- Original Message ---------
>> Sender : Krzysztof Kozlowski <krzk@kernel.org>
>> Date : 2022-03-28 18:38 (GMT+9)
>> Title : Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
>>
>> On 28/03/2022 11:02, 이왕석 wrote:
>>>>  --------- Original Message ---------
>>>>  Sender : Krzysztof Kozlowski <krzk@kernel.org>
>>>>  Date : 2022-03-28 16:12 (GMT+9)
>>>>  Title : Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
>>>>
>>>>  On 28/03/2022 03:44, 이왕석 wrote:
>>>>>   This series patches include newly PCIe support for Axis ARTPEC-8 SoC.
>>>>>   ARTPEC-8 is the SoC platform of Axis Communications.
>>>>>   PCIe controller driver and phy driver have been newly added.
>>>>>   There is also a new MAINTAINER in the addition of phy driver.
>>>>>   PCIe controller is designed based on Design-Ware PCIe controller IP
>>>>>   and PCIe phy is desinged based on SAMSUNG PHY IP.
>>>>>   It also includes modifications to the Design-Ware controller driver to 
>>>>>   run the 64bit-based ARTPEC-8 PCIe controller driver.
>>>>>   It consists of 6 patches in total.
>>>>>   
>>>>>   This series has been tested on AXIS SW bring-up board 
>>>>>   with ARTPEC-8 chipset.
>>>>
>>>>  You lost mail threading. This makes reading this difficult for us. Plus
>>>>  you sent something non-applicable (patch #2), so please resend.
>>>>
>>>>  Knowing recent Samsung reluctance to extend existing drivers and always
>>>>  duplicate, please provide description/analysis why this driver cannot be
>>>>  combined with existing driver. The answer like: we need several syscon
>>>>  because we do not implement other frameworks (like interconnect) are not
>>>>  valid.
>>>>
>>>>  Best regards,
>>>>  Krzysztof
>>>  
>>>  Hello, Krzysztof
>>>  Thanks for your review.
>>>  
>>>  patch#2 was sent to the wrong format so sent again.
>>>  Sorry for causing confusion.
>>  
>> The first sending was HTML. Second was broken text, so still not working.
>>
>> Please resend everything with proper threading.
> 
> Hello, Krzysztof
> 
> I sent patch#2 three times.
> due to the influence of the email system,
> there was something wrong with the first and second mails.
> Sorry for causing confusion.
> Did you receive the third patch i sent you?

Maybe, I don't know. It's not threaded so it's difficult to find it
among other 100 emails...

>  
>>>  This patch is specialized in Artpec-8, 
>>>  the SoC Platform of Axis Communication, and is newly applied.
>>>  Since the target SoC platform is different from the driver previously 
>>>  used by Samsung, it is difficult to merge with the existing driver.
>>
>> Recently I always saw such answers and sometimes it was true, sometimes
>> not. What is exactly different?
>>
>> Best regards,
>> Krzysztof
> 
> The main reason this patch should be added is that
> this patch is not the driver applied to exynos platform.

Still this does not explain why you need separate driver.

> Because the SoC platform is different, 
> the IP configuration of PCIe is also different.

What is exactly different? Usually drivers can support IP blocks with
some differences...

> We will organize a driver for Artpec-8 platform and 
> if there is no special reason, maintain this 
> without adding it from the next series.

I don't understand this.


Best regards,
Krzysztof

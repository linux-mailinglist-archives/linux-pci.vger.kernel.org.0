Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FC54E9186
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 11:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbiC1Jjo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 05:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbiC1Jjo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 05:39:44 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FB8541B1;
        Mon, 28 Mar 2022 02:38:03 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id yy13so27413881ejb.2;
        Mon, 28 Mar 2022 02:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DrPaEMfDat9GUeQRRHhxK3bi9z/y1g5nfYZpdXBeJh0=;
        b=Q3OiKon3Vg93LsG1eTgqGoot1xXNCnEGl3I9Huxn6T9UdbK40VKGH8Dy+yV2FRe62p
         qD6xx7HhVkxyx4oRUJre9KCoC2srEWfkZ6DZLfCMfl5DCpXBejJ5uF6/22L6p/tJ2wOn
         morxrPBls7C545b92zEsutJ9TJXdRQ2h3+ub/1uXTyEXSh90iBlvawTm7gxY+kPAMQmr
         Eq9LX6MVCssWoH23aR+MTZf9aoV0VdvgPRQTWNQXOWTvGPOe50McBLpSUDq06vxbKUJT
         cHgsg7MsH1lwcHat7JBrjUD+9kqduJpIPElhfShKWT7XqtAcRqJy5gLi7bsvZY7Dj+v7
         j7IA==
X-Gm-Message-State: AOAM531GSr15buJCCmJOZfM/xwejTQVy1AMH074WxORaYt0BqOR0fyK+
        BBviwZmrNXO6gtpyebhvcW8=
X-Google-Smtp-Source: ABdhPJwLsldpE5WWlbufSSBwZw6+SgXRr/UdYD3h5M6meozH4epky2mYxDMbkRWCkKh6Y8bzyTb+Yw==
X-Received: by 2002:a17:906:a046:b0:6b9:20c:47c1 with SMTP id bg6-20020a170906a04600b006b9020c47c1mr26357100ejb.615.1648460282232;
        Mon, 28 Mar 2022 02:38:02 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id k12-20020aa7c38c000000b0041939d9ccd0sm6775331edq.81.2022.03.28.02.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 02:38:01 -0700 (PDT)
Message-ID: <564c7092-d6a3-7766-d83f-9762075d055f@kernel.org>
Date:   Mon, 28 Mar 2022 11:38:00 +0200
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
References: <0716d9e4-24e1-d16c-162c-00a8664296e1@kernel.org>
 <20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p7>
 <CGME20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p8>
 <20220328090200epcms2p8637d2a2e09a3a627be776586b80c8adf@epcms2p8>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220328090200epcms2p8637d2a2e09a3a627be776586b80c8adf@epcms2p8>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/03/2022 11:02, 이왕석 wrote:
>> --------- Original Message ---------
>> Sender : Krzysztof Kozlowski <krzk@kernel.org>
>> Date : 2022-03-28 16:12 (GMT+9)
>> Title : Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
>>
>> On 28/03/2022 03:44, 이왕석 wrote:
>>>  This series patches include newly PCIe support for Axis ARTPEC-8 SoC.
>>>  ARTPEC-8 is the SoC platform of Axis Communications.
>>>  PCIe controller driver and phy driver have been newly added.
>>>  There is also a new MAINTAINER in the addition of phy driver.
>>>  PCIe controller is designed based on Design-Ware PCIe controller IP
>>>  and PCIe phy is desinged based on SAMSUNG PHY IP.
>>>  It also includes modifications to the Design-Ware controller driver to 
>>>  run the 64bit-based ARTPEC-8 PCIe controller driver.
>>>  It consists of 6 patches in total.
>>>  
>>>  This series has been tested on AXIS SW bring-up board 
>>>  with ARTPEC-8 chipset.
>>
>> You lost mail threading. This makes reading this difficult for us. Plus
>> you sent something non-applicable (patch #2), so please resend.
>>
>> Knowing recent Samsung reluctance to extend existing drivers and always
>> duplicate, please provide description/analysis why this driver cannot be
>> combined with existing driver. The answer like: we need several syscon
>> because we do not implement other frameworks (like interconnect) are not
>> valid.
>>
>> Best regards,
>> Krzysztof
> 
> Hello, Krzysztof
> Thanks for your review.
> 
> patch#2 was sent to the wrong format so sent again.
> Sorry for causing confusion.

The first sending was HTML. Second was broken text, so still not working.

Please resend everything with proper threading.


> This patch is specialized in Artpec-8, 
> the SoC Platform of Axis Communication, and is newly applied.
> Since the target SoC platform is different from the driver previously 
> used by Samsung, it is difficult to merge with the existing driver.

Recently I always saw such answers and sometimes it was true, sometimes
not. What is exactly different?

Best regards,
Krzysztof

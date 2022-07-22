Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E1E57E5B3
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 19:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbiGVRgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 13:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiGVRgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 13:36:07 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E67A8D5EC
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2022 10:36:06 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r14so6242236ljp.2
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2022 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=siI7/lD81kyWLQyF5/WV8DbZeAWnZDkinKrf8vJZ9AQ=;
        b=G2yZ9ZDC+GHFFgMKdqoofXT8fAAOL5E/soGuGLEBu11gQckoorXPxw9IS78d2w1qiR
         f31mMLqaAf4UmprVakQTiPZ5Qv4YTwjY1LYXNIioKuzGx0rRrYNC1RoHDk19kYLUUECt
         uB40RencH11PrSF5EjoGNepdrL/jgL/XAmqW+fuN3SdzMyz5ej2YqGydCYhh4ruoxnxs
         5a25dzgWSJpS3ZSqClnzkjAGZWTiVH9HnRxYDc+6CBzbiW6zkOonAaE+/PbOsaRWDlur
         BR7YEmEKzVSy1wdsWwvcy/o2YQKOPkGIWx2kvXEmGcNBP2fr66F2WSLa32EI7o4YvmlP
         0+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=siI7/lD81kyWLQyF5/WV8DbZeAWnZDkinKrf8vJZ9AQ=;
        b=dw3MzGWYIc2miFlC28AcuidJIiNtkyckxYXWUr42ZtvQ9AnU8CIMCC9yX7xdkrvCGf
         +4RzJOyhrtBltbpXCJ+M2mb/6gBgWBWVVVtH1MZXyfUP1iJQi+4dyyzakeI9onOH83mH
         IbS17lzSzas+Nv+/SFDswFhlSADqQ16LR0kiyWHT+EabegrrwqoGa70Rvsk+beXvhLay
         +mblocfbBEl4tmh6n5j03uTftYWeq8huCQf+rCSF+36ohMH/C7FcyPMbSdC5eGn5QdoY
         Y0TQzi9xoOaWgrXo+q3HeTP3DdN5/BLKxv2lxpLNe24ylCmLOqIYnN3S6ZOCzkfNY8Gd
         CZnQ==
X-Gm-Message-State: AJIora/w9KJSBkMy/Ah31rnC2PvvxvhGIDCds5HfTAbXIWo5/LST1IAN
        5Rkl/0ybWHBq/l+nwcrNs4MLSw==
X-Google-Smtp-Source: AGRyM1ugHJdaM+Sgsif3zEWtynxobA/cIJhsISRhil968uqOXy7mRTTqFcH/dcHqHHvr3AyxCeLIrQ==
X-Received: by 2002:a2e:bc17:0:b0:25d:50b7:74fa with SMTP id b23-20020a2ebc17000000b0025d50b774famr377988ljf.444.1658511364370;
        Fri, 22 Jul 2022 10:36:04 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id c23-20020a056512325700b0048374164e22sm1159225lfr.193.2022.07.22.10.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:36:03 -0700 (PDT)
Message-ID: <4133c99a-b6a1-6a17-0ad8-f3bf6f8ab176@linaro.org>
Date:   Fri, 22 Jul 2022 19:36:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     wangseok.lee@samsung.com,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
References: <20220721205819.GA1753070@bhelgaas>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220721205819.GA1753070@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/07/2022 22:58, Bjorn Helgaas wrote:
> On Thu, Jul 21, 2022 at 11:04:00AM +0200, Krzysztof Kozlowski wrote:
>> On 20/07/2022 08:01, Wangseok Lee wrote:
>>> Add support Axis, ARTPEC-8 SoC. ARTPEC-8 is the SoC platform of Axis
>>> Communications. This is based on arm64 and support GEN4 & 2lane. This
>>> PCIe controller is based on DesignWare Hardware core and uses DesignWare
>>> core functions to implement the driver. "pcie-artpec6. c" supports artpec6
>>> and artpec7 H/W. artpec8 can not be expanded because H/W configuration is
>>> completely different from artpec6/7. PHY and sub controller are different.
>>>
>>> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
>>> Signed-off-by: Jaeho Cho <jaeho79.cho@samsung.com>
>>> ---
>>> v3->v4 :
>>> -Remove unnecessary enum type
>>> -Fix indentation
>>>
>>
>> Thanks for the changes. This starts to look good, however I am not going
>> to ack it. This is also not a strong NAK, as I would respect Bjorn and
>> other maintainers decision.
>>
>> I don't like the approach of creating only Artpec-8 specific driver.
>> Samsung heavily reuses its block in all Exynos devices. Now it re-uses
>> them for other designs as well. Therefore, even if merging with existing
>> Exynos PCIe driver is not feasible (we had such discussions), I expect
>> this to cover all Samsung Foundry PCIe devices. From all current designs
>> up to future licensed blocks, including some new Samsung Exynos SoC. Or
>> at least be ready for it.
> 
> I would certainly prefer fewer drivers but I don't know enough about
> the underlying IP and the places it's integrated to to know what's
> practical.  The only way I could figure that out would be by manually
> comparing the drivers for similarity.  I assume/expect all driver
> authors are doing that.

Merging with existing Exynos PCIe driver (and phy) might be indeed
tricky, as existing one does not support that much as here. However I
really expect that all current designs from Samsung - Exynos SoC, Artpec
and for other customers - have very similar PCIe thus this should be a
generic, new generation Samsung PCIe driver. If designed that way, also
the naming should be back Samsung specific, no Axis/Artpec.

Best regards,
Krzysztof

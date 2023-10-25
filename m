Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0607D6CEA
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 15:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjJYNQ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 09:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjJYNQ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 09:16:56 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3849133;
        Wed, 25 Oct 2023 06:16:53 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41cc537ed54so36850601cf.2;
        Wed, 25 Oct 2023 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698239813; x=1698844613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1tU5kbwVb+Wg1uvhO3+D2ibDL+pMHtlvIijrkuaPh8=;
        b=JztT+RB5tT9OlVCWDTDHrk8Yb+mSxQGALK/XRzNVQ6Uai4dbyc4lOxSADoG1tjvg3/
         1Oz9hBZSd1LbPvqKLtANYd9hsSSEhbRvLRBmG/VEMua51TfZi/Lq/9JNgfsfVm4mLK2z
         uHybcIwIPPdQRwtsee0u0prDHLQwcQHlButJulpCLb8QJWxrdqb6NkfKvFDrIfxKa97F
         3LpLMTuhSjtpu1dGiXEybaSidDKCWVFMOQqJV+hwFPvgVsYc6zNyUNRYenUJOLhFX50E
         5jXXsVhRS6r7o4T4eRvCxRhskMd97iPJMBj9NH5vqX8awtOYbST1unPib0bHwC6QPY4u
         xs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698239813; x=1698844613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1tU5kbwVb+Wg1uvhO3+D2ibDL+pMHtlvIijrkuaPh8=;
        b=MJjZZFkTAzcKG5RK8lbTrZz7ZAfUAwXYz8P9ged/IxhpB3exi4zfglrl4KoJsTI0xf
         YI7CThxWVdT4Ay7w73pfdabl57wtzszasenSe1Cz8kYrA6avUNOxoX2uIjubwj0JFUdG
         Z1eq5LQzAhhd/8tg6J16F5aTE8ZF1qIERVk8YFQCllfxq/qaiU3r3TK/9NeNqLq/uOt4
         h70N8BG6WQqJ4HZvngea9nlGeozBvNXrQYHD8Pvpvvswx9jLyLrQLr/mkzIM/0TJbjpH
         HiDBZp6ph3bWjyPNxP5/Tcrrj+3cNxdnRG5l6YjMFsQKnRFvPHRLO/O0JbvOkK+QT+Ba
         QZGg==
X-Gm-Message-State: AOJu0Yyj9DnhhIfJfYEgRFZywojeJETWmvXRbnHR8Z24SHHk2dPw7WSA
        Giy7YJs7OSVHzkU88wYsb+g=
X-Google-Smtp-Source: AGHT+IGDdTkY4rbUQVfZKtiVec1opfPoUHwbLgxu9buNeZQ8XoSBU+I/OT31DE12H3tKf3Lub14xEg==
X-Received: by 2002:ac8:5715:0:b0:418:11ee:6315 with SMTP id 21-20020ac85715000000b0041811ee6315mr16789523qtw.43.1698239812806;
        Wed, 25 Oct 2023 06:16:52 -0700 (PDT)
Received: from [192.168.20.212] (cpe-107-15-246-199.nc.res.rr.com. [107.15.246.199])
        by smtp.gmail.com with ESMTPSA id g3-20020ac842c3000000b0041977932fc6sm4188578qtm.18.2023.10.25.06.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 06:16:52 -0700 (PDT)
Message-ID: <c84f0999-5de0-1161-4061-75aa2795d45a@gmail.com>
Date:   Wed, 25 Oct 2023 09:16:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v9 01/20] dt-bindings: PCI: Add PLDA XpressRICH PCIe host
 common properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>
Cc:     Minda Chen <minda.chen@starfivetech.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20231020104341.63157-1-minda.chen@starfivetech.com>
 <20231020104341.63157-2-minda.chen@starfivetech.com>
 <8ced1915-7b94-4abc-bd8b-cb4bf027fa01@linaro.org>
 <bd441e1d-73ae-4abc-8eb2-877419acb2df@starfivetech.com>
 <97e2decd-f6a3-91cb-6ca7-539f53b686f3@gmail.com>
 <20231025-dotted-almighty-ae489e9eb764@spud>
 <3d7a2dba-53f6-4625-8981-fbeb469418c1@linaro.org>
Content-Language: en-US
From:   John Clark <inindev@gmail.com>
In-Reply-To: <3d7a2dba-53f6-4625-8981-fbeb469418c1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

That is correct, I tested the entire series against Linux 6.6-rc7 and 
confirmed that pcie/nvme/usb work on the VisionFive2 device. I was 
unable to test the Microchip side of the equation. I will be more clear 
as to what I verified if I comment in the future.

John Clark


On 10/25/23 6:41 AM, Krzysztof Kozlowski wrote:
> On 25/10/2023 12:28, Conor Dooley wrote:
>> Hi John,
>>
>> On Mon, Oct 23, 2023 at 11:09:50PM -0400, John Clark wrote:
>>>> On 2023/10/20 19:04, Krzysztof Kozlowski wrote:
>>>>> On 20/10/2023 12:43, Minda Chen wrote:
>>>>>> Add PLDA XpressRICH PCIe host common properties dt-binding doc.
>>>>>> Microchip PolarFire PCIe host using PLDA IP.
>>>>>> Move common properties from Microchip PolarFire PCIe host
>>>>>> to PLDA files.
>>>>>>
>>>>>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>>>>>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>>>>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>>>> ---
>>>>>>    .../bindings/pci/microchip,pcie-host.yaml     | 55 +-------------
>>>>>>    .../pci/plda,xpressrich3-axi-common.yaml      | 75 +++++++++++++++++++
>>>>> Where was this patch reviewed?
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>> This Conor's review tag. v2 : https://patchwork.kernel.org/project/linux-pci/patch/20230727103949.26149-2-minda.chen@starfivetech.com/
>>>> This is Rob's review tag v3: https://patchwork.kernel.org/project/linux-pci/patch/20230814082016.104181-2-minda.chen@starfivetech.com/
>>> Tested-by: John Clark <inindev@gmail.com>:
>>> https://github.com/inindev/visionfive2/tree/main/kernel/patches
>> I suspect you don't mean that you tested this individual dt-binding, but
>> rather that you tested the whole series. If so, you should probably
>> provide this tested-by against the cover-letter instead of this bindings
>> patch.
> Yeah, otherwise I would like to hear how do you test bindings (other
> than dt_binding_check which is something similar to testing as compiling
> code).
>
> Best regards,
> Krzysztof
>

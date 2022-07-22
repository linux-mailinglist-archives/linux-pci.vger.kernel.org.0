Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F157DD12
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiGVJE1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 05:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiGVJE0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 05:04:26 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725047D1E8
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2022 02:04:24 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y11so6609923lfs.6
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2022 02:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=l3h9J6UBwtKZvJITANmcz+24NubjgVssRtaWr316TZs=;
        b=mirn+CGqVXafmKCSE26H4UOWDduWcnDa1FtZoLehw1N8nxaLCn+AZTl0tCocMNRkMl
         9jHl8872M72LJOGhgi+2bxsYa7R/Ow5nJPcX85G4FteaQlUCyyp/ScmU05UVqinn6Q0T
         DPCz6N/vqp2UqZKa1QcZceEQ9y+craPhLT4VabCGwNU3V6NhR56mkCL9Ub0PXOmgR6yr
         vVdx0n3HyGk+mBUXEBoA1zVALL0WUVm7pl7V0EafzwLIGdcJMe/hIGFmmcfTejYU+FKH
         pxJeMWG6nk1izMokmiYi6SAcWpOweO02it7CmwLhtJUXVl5dtlm49OajBLWycLIyFmER
         fUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=l3h9J6UBwtKZvJITANmcz+24NubjgVssRtaWr316TZs=;
        b=lfF7MESMIGLcW9o18CVhP2+M2kBE4zhhppTVSQhPS+KVOZazOboLFoTecSbsw8Zu9/
         7t50yuIFZexYqPWKGjc2qlkQHDtb9rfF75osUVVLBsJGP3WdrQkcqUYBNXj6pPWJFLsS
         uC8aiSIuXnhlLavRh1QlPHEBNINoExcxvztJgp9mekoF1SZMXx4d5Gsm3kQjRTaVMxlF
         EAw0tVWTqlMKIKcfPYeRRnvno/YYU7+ESSmi4KhM5tp2lZkd5GE4/qUzj6r3XTIvM6n0
         nNArj8Lc8MbrL2NqL0QdE/d0jQfPNJKq0e5wvGzS7b+Dqad8sGS2vXjE08U0NmhkhcFU
         mV1g==
X-Gm-Message-State: AJIora8vwKoKJLyjqiXshL7pyzXlgZUEsGPVgEXe7cmFKVS9/kLJMSTC
        UMCMQUqIxhjaPBj6eJ138TjsoQ==
X-Google-Smtp-Source: AGRyM1uKGad0HYgW1xNRavLGPomXqqpMS6YPuafQWGsFlmZ49umoCJNqxnl9rMo/IIJozjp4rrkX5w==
X-Received: by 2002:ac2:5084:0:b0:48a:6e29:bf8 with SMTP id f4-20020ac25084000000b0048a6e290bf8mr971373lfm.572.1658480662753;
        Fri, 22 Jul 2022 02:04:22 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o18-20020ac24c52000000b0047f933622c8sm942056lfk.163.2022.07.22.02.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 02:04:22 -0700 (PDT)
Message-ID: <53dfe37d-c976-0ffe-dd46-48b681144c6c@linaro.org>
Date:   Fri, 22 Jul 2022 12:04:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v17 0/6] PCI: dwc: Fix higher MSI vectors handling
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
References: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
 <84004850-026a-980d-6c9c-3668182fc458@linaro.org>
In-Reply-To: <84004850-026a-980d-6c9c-3668182fc458@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/07/2022 14:58, Dmitry Baryshkov wrote:
> On 07/07/2022 16:47, Dmitry Baryshkov wrote:
>> I have replied with my Tested-by to the patch at [2], which has landed
>> in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
>> Add support for handling MSIs from 8 endpoints"). However lately I
>> noticed that during the tests I still had 'pcie_pme=nomsi', so the
>> device was not forced to use higher MSI vectors.
>>
>> After removing this option I noticed that hight MSI vectors are not
>> delivered on tested platforms. After additional research I stumbled upon
>> a patch in msm-4.14 ([1]), which describes that each group of MSI
>> vectors is mapped to the separate interrupt. Implement corresponding
>> mapping.
> 
> [skipped]
> 
> Gracious ping. Does this series stand a chance of getting into 5.20?

Bjorn, please excuse my insistence. Given that it's not merged (yet), 
probably it will not make it into 5.20. Is there anything preventing it 
from being accepted for 5.21?

dwc patches were reviewed by Rob, Mani and Johan. Stanimir has acked the 
bindings patch.

The dts patch should probably go via the arm-soc tree (together with 
additional patches adding multiple MSI IRQs to other Qualcomm SoCs).

> 
>> Dmitry Baryshkov (6):
>>    PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
>>    PCI: dwc: Convert msi_irq to the array
>>    PCI: dwc: split MSI IRQ parsing/allocation to a separate function
>>    PCI: dwc: Handle MSIs routed to multiple GIC interrupts
>>    dt-bindings: PCI: qcom: Support additional MSI interrupts
>>    arm64: dts: qcom: sm8250: provide additional MSI interrupts
>>
>>   .../devicetree/bindings/pci/qcom,pcie.yaml    |  51 +++++-
>>   arch/arm64/boot/dts/qcom/sm8250.dtsi          |  12 +-
>>   drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
>>   drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
>>   .../pci/controller/dwc/pcie-designware-host.c | 164 +++++++++++++-----
>>   drivers/pci/controller/dwc/pcie-designware.h  |   2 +-
>>   drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
>>   drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
>>   drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
>>   9 files changed, 185 insertions(+), 54 deletions(-)
>>
> 
> 


-- 
With best wishes
Dmitry

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF60574CA3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 13:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbiGNL6w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 07:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbiGNL6v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 07:58:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26680240BE
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 04:58:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bp17so2421679lfb.3
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=XZ6zcs78xTBMoBW41xhfPl8mgcyOXJXlS8VDvhn/FaA=;
        b=QrW+48G78oGpbq+WOxe6wyGen22tAhMqgzvsIpr++kA0ByojlU4fVPCdDnQM0h9hl4
         LQ8hPvkqA22lIusPYp7JldtRnZQU3bAu9eVTUIyQryhgafMImP1lqWyA+9PaEYwvSpuF
         sZZ3ohSyWVgw9OARxWuTc6ImU9RaGlvBKGtXRVIIBE+M44PueNU4GpT/4TFRUJX3fOES
         kKwGa8tzpP1zbB1hCrjAHZOyx3vLzgnmOHU9WtriEMtnrrAhQu/K/6WCckEBTkESZIG9
         3064EiIuaGNXX/pOEB0l9eDPtem/rCaQlcBrhsVdvNJXbyrExvFF267xCchAIDQIXilq
         ou+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=XZ6zcs78xTBMoBW41xhfPl8mgcyOXJXlS8VDvhn/FaA=;
        b=c0gthRXRaNORcFslR/lhomprXNilwLcCNULkZ2rhDBuU7FKpGXl+/A/5Kj2eBRqqDZ
         kFU+mBzry1qPbB9opHO2kPSjBo01uYAwbc8YL5L+bRBBdqrOKqG4bLRiMAfrI0CygbrW
         DpnxcJyJucJGWfELRKAQMYS0CrvyWu+yg1+wdArO6s8VM1ZdgrQ8y0/0KAyP8QMrP4e0
         SwixkxGusH7Urxb5FYgkFvvDRt9YztUIeD66C90AuHOOkBjHAkI7nyKyBXAEa8VWCEP4
         tPD4UplTP62AsFYlkK1TM5s7J1ttKICCAGwlIGuGSz5+VR+mUwwstdmARSpycEBJ/MCU
         3wgQ==
X-Gm-Message-State: AJIora9Zjtuq0VJ2Z68QSZKEyowbPWavvkFW1YGRCToqpo5/yCl+BNv+
        bITAH1EFpr8VpuBKCeo6tRtrIw==
X-Google-Smtp-Source: AGRyM1tMzHQzW7BqLoNxHkx2+lnmWwhQ1bMGpdOMMs2Qr7nWdRusNUS6b3tyiC3Kycct0IxRGRnr8w==
X-Received: by 2002:a05:6512:21d2:b0:47f:9f53:f729 with SMTP id d18-20020a05651221d200b0047f9f53f729mr5178922lft.378.1657799928521;
        Thu, 14 Jul 2022 04:58:48 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651c118900b0025d620892cdsm240170ljo.107.2022.07.14.04.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 04:58:48 -0700 (PDT)
Message-ID: <84004850-026a-980d-6c9c-3668182fc458@linaro.org>
Date:   Thu, 14 Jul 2022 14:58:47 +0300
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
In-Reply-To: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/07/2022 16:47, Dmitry Baryshkov wrote:
> I have replied with my Tested-by to the patch at [2], which has landed
> in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
> Add support for handling MSIs from 8 endpoints"). However lately I
> noticed that during the tests I still had 'pcie_pme=nomsi', so the
> device was not forced to use higher MSI vectors.
> 
> After removing this option I noticed that hight MSI vectors are not
> delivered on tested platforms. After additional research I stumbled upon
> a patch in msm-4.14 ([1]), which describes that each group of MSI
> vectors is mapped to the separate interrupt. Implement corresponding
> mapping.

[skipped]

Gracious ping. Does this series stand a chance of getting into 5.20?

> Dmitry Baryshkov (6):
>    PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
>    PCI: dwc: Convert msi_irq to the array
>    PCI: dwc: split MSI IRQ parsing/allocation to a separate function
>    PCI: dwc: Handle MSIs routed to multiple GIC interrupts
>    dt-bindings: PCI: qcom: Support additional MSI interrupts
>    arm64: dts: qcom: sm8250: provide additional MSI interrupts
> 
>   .../devicetree/bindings/pci/qcom,pcie.yaml    |  51 +++++-
>   arch/arm64/boot/dts/qcom/sm8250.dtsi          |  12 +-
>   drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
>   drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
>   .../pci/controller/dwc/pcie-designware-host.c | 164 +++++++++++++-----
>   drivers/pci/controller/dwc/pcie-designware.h  |   2 +-
>   drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
>   drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
>   drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
>   9 files changed, 185 insertions(+), 54 deletions(-)
> 
	

-- 
With best wishes
Dmitry

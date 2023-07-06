Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9987495C3
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 08:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjGFGkC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 02:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjGFGkC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 02:40:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B684919B
        for <linux-pci@vger.kernel.org>; Wed,  5 Jul 2023 23:40:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9926623e367so38052966b.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Jul 2023 23:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688625599; x=1691217599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9Lr53a5FzMbobQOgcXx29sEThYjNb3OAfuRJxgypPU=;
        b=Ojsi/JZ2g42ODEl29O6Pe/nx0eWsLXYUZDLKLcox6/D0JuG4qR5UQSxNxb47yDQSHU
         4XFMl0nVmZrttdjJyzgT01Lpa8NMss+siHLDEiOmFQ8Rd0BDDLQ9vECwNsz54L34X+Cd
         ksAlmljSp//0vJufJftwlDcMJuldV2hVMBwjwyWBFHj39WykdbUcfs9RSuAmQ5cb0YaO
         w9W/r5P+XBRugc5H+NH8vujIz7dQBFt24FVboN7SnobBkw/KRP9TcOpbntcKW8+1UIoj
         RzbQPCnksoaDLWd9pQleLLFTr19oGDwNoEvQEzAJ5gcyasS4YWsX1V1j51uv4mrrKXvS
         XPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688625599; x=1691217599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9Lr53a5FzMbobQOgcXx29sEThYjNb3OAfuRJxgypPU=;
        b=FWvyl189WhuLDhhRiRjzhIMusL4A8kBFdQCxwOOsl6t4eQPeUvrPVY/wsqPgGYKDkk
         vIYhzFaIKuUYaa+rzUd5C7a9OrXtzvswd6m7XxMnZf0xrNtML642apa2dQ8fF6vRhZA1
         W9D42zzqUnFi16fc0RD5eddE/50T9ljTtCUbU1aw0RAQzcGGpykZT4ftyH+qb3KIp1L6
         9gSy1e3YxBxfpir12ulLwqzrSsYKxrMJJTVzbijXbM9EyeHEkivu5prN8uBSOI1RL9LW
         x8uQdBVEev2K0rshANfcEr609Yfze8Zff1jBET9Nj6TFPwkmi89CvikUIbSdhEQ8YeyV
         4+dA==
X-Gm-Message-State: ABy/qLb5lpGMasl5pO5ZJ34Pqj9NAsx/ress7zDosZq8Kbea7Kd95p4H
        bxxGiQtIWQ5qSwyQGm7qjMvcig==
X-Google-Smtp-Source: APBJJlFe3mJbYP5HOYEAflyYq1r1hjT3H2KqDuSD93Sbb4Ats7EOFA2VltdFwHu3Zsd0znCxRd1y2g==
X-Received: by 2002:a17:906:2a48:b0:988:c3f9:3ad6 with SMTP id k8-20020a1709062a4800b00988c3f93ad6mr540685eje.42.1688625599228;
        Wed, 05 Jul 2023 23:39:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id r11-20020a17090638cb00b00993a508b818sm399619ejd.1.2023.07.05.23.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 23:39:58 -0700 (PDT)
Message-ID: <a450e2e8-307d-49e9-d76d-de397b801a96@linaro.org>
Date:   Thu, 6 Jul 2023 08:39:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/6] arm64: qcom: sa8775p: add support for PCIe
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <20230705084606.GF11854@thinkpad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230705084606.GF11854@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/07/2023 10:46, Manivannan Sadhasivam wrote:
> On Wed, Jul 05, 2023 at 01:47:05PM +0530, Mrinmay Sarkar wrote:
>> Update the relavent DT bindings for PCIe, add new config to the phy
>> driver add pcie and phy nodes to the .dtsi file and enable then in 
>> board .dts file for the sa8775p-ride platform.
>>
>> Mrinmay Sarkar (6):
>>   dt-bindings: PCI: qcom: Add sa8775p compatible
>>   dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe PHY
>>   PCI: qcom: Add support for sa8775p SoC
>>   phy: qcom-qmp-pcie: add support for sa8775p
>>   arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes
>>   arm64: dts: qcom: sa8775p-ride: enable pcie nodes
> 
> Please note that the dts patches should come before driver patches.
>

Why? DTS is always independent thus usually put at the end of patchset
or better separate. It is the first time I hear that DTS should be
before driver.

Best regards,
Krzysztof


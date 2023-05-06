Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467B46F91C7
	for <lists+linux-pci@lfdr.de>; Sat,  6 May 2023 14:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjEFMBR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 May 2023 08:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjEFMBP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 May 2023 08:01:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8720A24B
        for <linux-pci@vger.kernel.org>; Sat,  6 May 2023 05:01:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso3200174e87.0
        for <linux-pci@vger.kernel.org>; Sat, 06 May 2023 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683374472; x=1685966472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Cf5CasgT8e62WAHreBlxmaiulGbi8dcackHO3X1L2I=;
        b=OTFoc+PzwweLZmpXQgJa+nrtLRrFzuqA94bbUj9IMizuHxapFKgIEeFpAnERD6bodU
         Y2LVErYXwX7E6/zj5FlXEVQmxdCC5ZjWDNSAihSlTaI64k3abqVj4+yfdCEqPanCLkBU
         wqmwxYOfquWjZNlZAIdrgENGODFqr9s4WkU1foby8vacwJtPJFhnNAtR0JxvY7sPHjG4
         NKcHNymHxVp6x57zS22eZAgsepMM+UBo2qvSGzJc0lVxI/DFHXPGDxooiECMKZScpRHK
         4kAp5W3wj3Mm+1MyX08Trmvcbuhfg2808hfgWkCqpO+vgglL//WMNMxBDe1uMLwxkCUH
         NMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683374472; x=1685966472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Cf5CasgT8e62WAHreBlxmaiulGbi8dcackHO3X1L2I=;
        b=YmfJojmgSOPJhvZDf3CzrtOw818ESqzcuk2D30lmoJmidY38hyr4+newZyXrg1c55a
         a7tR8lO7+a6jUfaE7AIGeQz78NBUoFO3/f7irpkYBBbeRxQ5RP33wkFfkxkELfjAq0w0
         RZV63CkSJSYgJLvuZ4US12wBFK50M2I2T7L4CVzLDQp2y5ZjsUqi1CrR2Ec+ZRbBg2oo
         kr9HMwD8EV1zEcLYew3Udk1j6XkvUIlDixeCwmD+M346Qmqk6pL44DkqP2DLUFddlvl4
         CNqtU4X6eT/aqHf4q+CxxhDwqM88ZeI5l/OTjhuMI9tHOxZGSDBqpi7qIbw5ZjsOAtOE
         Ulcw==
X-Gm-Message-State: AC+VfDxImVL24Rb0a3SwrjN7ojePwUl6d6ZGRe5CI7O5CDXi+4W3JKh9
        iogPR1ePxw1DUW/a7BelxRaCB2URrH2eYWq2Lss=
X-Google-Smtp-Source: ACHHUZ4ngoZwz6ziSD+8RiL4sMcAOFm+arrurOtssAzn1SCBLoLnT+kIlNyji7UdqaXGMuOzYloffA==
X-Received: by 2002:a19:c218:0:b0:4ed:b048:b98a with SMTP id l24-20020a19c218000000b004edb048b98amr1162527lfc.6.1683374471976;
        Sat, 06 May 2023 05:01:11 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id p4-20020a2e7404000000b002ac538a4e6dsm357896ljc.131.2023.05.06.05.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 05:01:11 -0700 (PDT)
Message-ID: <870ea899-b405-8061-93fe-cf50de595808@linaro.org>
Date:   Sat, 6 May 2023 15:01:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/8] PCI: qcom: Do not advertise hotplug capability for
 IPs v2.7.0 and v1.9.0
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com
References: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
 <20230506073139.8789-4-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230506073139.8789-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/05/2023 10:31, Manivannan Sadhasivam wrote:
> SoCs making use of Qcom PCIe controller IPs v2.7.0 and v1.9.0 do not
> support hotplug functionality. But the hotplug capability bit is set by
> default in the hardware. This causes the kernel PCI core to register
> hotplug service for the controller and send hotplug commands to it. But
> those commands will timeout generating messages as below during boot and
> suspend/resume.
> 
> [    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
> [    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
> [    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
> [    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)
> 
> This not only spams the console output but also induces a delay of a
> couple of seconds. To fix this issue, let's clear the HPC bit in
> PCI_EXP_SLTCAP register as a part of the post init sequence to not
> advertise the hotplug capability for the controller.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@gmail.com>

-- 
With best wishes
Dmitry


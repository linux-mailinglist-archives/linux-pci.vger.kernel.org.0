Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E188F6F925E
	for <lists+linux-pci@lfdr.de>; Sat,  6 May 2023 16:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjEFOBv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 May 2023 10:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjEFOBt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 May 2023 10:01:49 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4244493
        for <linux-pci@vger.kernel.org>; Sat,  6 May 2023 07:01:47 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ac8d9399d5so13768811fa.1
        for <linux-pci@vger.kernel.org>; Sat, 06 May 2023 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683381706; x=1685973706;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y4DzjlZSH6nUvcn3yg/CmFvBAUv8qZ8KUHAYOuwz40M=;
        b=TlKVg/Q9RGDcTgVwI1FpDsBjFqZjY++atrfrGLMQ4Kbzt+enaSvf2ffa8XyiZt09pK
         QZvmextn3fHLuSZxUjHSqCJ/sQV4El3jv8GW7tMXo/95tqFB3M3fx1FMjpOkdHhRCXPV
         OXVt6d1ZmPxP9PeQLayCmoBc3WA/WTCuqsITyeFdRCiGGWxIHMy3H5h7FogD4r3Ydb2Z
         eyLfucARANW/ZWeZ1y2lpZ8CXIaf16nVRt89JvU/sim94EesrY8oDlVR/YmlYw9SOPFw
         n0/l8tBJyR2koo0hiUvpgd0da/rkT8ETY+3NEbszDCst5gTasqiXdf0+YU01Bj009Xs5
         XBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683381706; x=1685973706;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4DzjlZSH6nUvcn3yg/CmFvBAUv8qZ8KUHAYOuwz40M=;
        b=hVFDgcnnFxZlAfkKLC39daQ/kh8epL3lP4q3Bv6GFTCrg8pt8sn+5kiSa/iT/SlAmu
         qqcH8HWYyLHWL3SbNBdptbr8//R7/gE0/6r8g5nQcNCB87jUAWTO4/dfA9gxmMSez6wp
         fu/0XQGidtPNWQ7HowBrW9mEZREqyPhPskvBdvO62X9OJYlAxfocod8CXZTD2cBLxf3g
         iNyyLB3VKtd1ryR1pwf9zuayA1PYQPapdcFxGxXJzj5DXHh9lgFRLy5bUniZYCe7vylo
         +FewrNlDaHWm2zWESD7Uq78fau1OOH1a+4yCn441ILYuvaEMiJ60NcVQCJ8OYigF5x6Y
         ECHw==
X-Gm-Message-State: AC+VfDyAb50Io7p5Rje6DSDIeHPSSnGIxmyl/qiZGqeQzA3V9P/iq7T7
        UlY/btMqKpoMYSw3geP4LJfPvw==
X-Google-Smtp-Source: ACHHUZ6kydKKYDxYP/jL4fIKX7Ow4JqB/L+OWGR4KGqCG7BzxOGJfABXqLnZiwRDfcjFlowDL+SzDA==
X-Received: by 2002:a2e:9d47:0:b0:2ac:bd28:d457 with SMTP id y7-20020a2e9d47000000b002acbd28d457mr494079ljj.14.1683381705805;
        Sat, 06 May 2023 07:01:45 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id x13-20020a2e9c8d000000b002ac833114besm400487lji.47.2023.05.06.07.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 07:01:45 -0700 (PDT)
Message-ID: <0e5f9f6b-eb67-38f8-2719-06aa8fe296bd@linaro.org>
Date:   Sat, 6 May 2023 16:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 5/8] PCI: qcom: Do not advertise hotplug capability for IP
 v2.3.2
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org, quic_srichara@quicinc.com
References: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
 <20230506073139.8789-6-manivannan.sadhasivam@linaro.org>
 <bc3ce44f-745a-bbad-32ac-67f8baa49483@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <bc3ce44f-745a-bbad-32ac-67f8baa49483@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6.05.2023 14:04, Dmitry Baryshkov wrote:
> On 06/05/2023 10:31, Manivannan Sadhasivam wrote:
>> SoCs making use of Qcom PCIe controller IP v2.3.2 do not support hotplug
>> functionality. But the hotplug capability bit is set by default in the
>> hardware. This causes the kernel PCI core to register hotplug service for
>> the controller and send hotplug commands to it. But those commands will
>> timeout generating messages as below during boot and suspend/resume.
>>
>> [    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
>> [    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
>> [    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
>> [    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)
>>
>> This not only spams the console output but also induces a delay of a
>> couple of seconds. To fix this issue, let's clear the HPC bit in
>> PCI_EXP_SLTCAP register as a part of the post init sequence to not
>> advertise the hotplug capability for the controller.
>>
>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 3d5b3ce9e2da..33353be396ec 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -579,6 +579,8 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
>>     static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
>>   {
>> +    struct dw_pcie *pci = pcie->pci;
>> +    u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>>       u32 val;
>>         /* enable PCIe clocks and resets */
>> @@ -602,6 +604,14 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
>>       val |= EN;
>>       writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>>   +    dw_pcie_dbi_ro_wr_en(pci);
>> +
>> +    val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
>> +    val &= ~PCI_EXP_SLTCAP_HPC;
>> +    writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
>> +
>> +    dw_pcie_dbi_ro_wr_dis(pci);
>> +
> 
> Seeing this code again and again makes me wonder if we should have a separate function for this.
Moreover, is there no generic rmw type function for readl+writel?

Konrad
> 

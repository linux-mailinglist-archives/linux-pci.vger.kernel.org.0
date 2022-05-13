Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65969526244
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 14:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359843AbiEMMsP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 08:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359236AbiEMMsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 08:48:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199F2369CB
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 05:48:13 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i10so14279457lfg.13
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qp6U6LDtAzJAv4pVaRxyFauwAW/SMB8YrlxJPXucXdk=;
        b=GfxRCdYt4d0NvgjNJJ3/i0YA0koKliMxUUCWYUv88fyDmFhuC3opmOsvihojk5Aufs
         KCCAoc3rc0BTbFB1r+viroJPZxjsTG35nKFYsSrzI2Iqv8lPmA7SkLNFlg19pACgq/No
         X58wpmBQGYVA6qRMxRVr538HuJ5ME+eetZvHxS4EdCmJalo7iRBm0yfd2NenM1kmmu0j
         aPeC1WpN/NecFSM+SImGgeFHLUWbsrVkPq6dNAe+fPXejqZznW2DbM0M2n26MRIUBN/w
         5cfonSd9yKaDowhlYUoyJQtQB0xYVRkqDHwXE660Tdd5m6VhmmJVio9/1icWFs8tDhO0
         EP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qp6U6LDtAzJAv4pVaRxyFauwAW/SMB8YrlxJPXucXdk=;
        b=kwavutdyPDxfI0VnQcvKS1ZMwCV/nx5E4Xug7LM9mFV6bu8/GdLo65Kq9k1O66Dbe7
         8a9ApQG1eanzCRSVZ6NP2YewTXD9SQx84wd508f2pw2s88/nH+RdDTU3XeN7YJINgQmX
         hoZdbGkcYgd4EIQn0iBJgnuEbWU577UR8xrVcyjGlhGJvFEUUbvjkt/Zb5n8GxoV87oO
         JJcjFoJT7dfSmA0lJUMxyTUUS1axbf+l8Sbs0+MjpTifkyMcbdop5NdkOsl1jFRKg35n
         H+4HNwT7VFoy9FJ4kylkb9a2E2COrZL/fVNvTSZl8vRuHrxpMiOfm40tCqCKKP0XPzOF
         SEdw==
X-Gm-Message-State: AOAM533OidcXEJXTA3hE8sJKTqAlwhcas3+Rhoop2tKJb1X9SVyVJH/o
        Aq9+MISN6gop8W2T7CaAHk0yoA==
X-Google-Smtp-Source: ABdhPJx4lcoptje+cxJATAsXrmMdq66+leY1YvyLqv0s4kCYyV5+Ep2rTJANhSlFa2G1Z/reAPUqLw==
X-Received: by 2002:ac2:54a1:0:b0:471:fa39:406d with SMTP id w1-20020ac254a1000000b00471fa39406dmr3410759lfk.640.1652446091461;
        Fri, 13 May 2022 05:48:11 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b3-20020ac25e83000000b0047255d210e8sm371273lfq.23.2022.05.13.05.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 05:48:10 -0700 (PDT)
Message-ID: <cf16d72a-33d5-07ca-3e6c-0fd87cb74c1a@linaro.org>
Date:   Fri, 13 May 2022 15:48:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v8 07/10] PCI: qcom: Handle MSIs routed to multiple GIC
 interrupts
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
 <20220512104545.2204523-8-dmitry.baryshkov@linaro.org>
 <Yn5STCN4smibLubA@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Yn5STCN4smibLubA@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/05/2022 15:42, Johan Hovold wrote:
> On Thu, May 12, 2022 at 01:45:42PM +0300, Dmitry Baryshkov wrote:
>> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
>> separate GIC interrupt. Thus, to receive higher MSI vectors properly,
>> declare that the host should use split MSI IRQ handling on these
>> platforms.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 2e5464edc36e..f79752d1d680 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -194,6 +194,7 @@ struct qcom_pcie_ops {
>>   
>>   struct qcom_pcie_cfg {
>>   	const struct qcom_pcie_ops *ops;
>> +	unsigned int has_split_msi_irq:1;
>>   	unsigned int pipe_clk_need_muxing:1;
>>   	unsigned int has_tbu_clk:1;
>>   	unsigned int has_ddrss_sf_tbu_clk:1;
> 
>> @@ -1592,6 +1599,11 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   
>>   	pcie->cfg = pcie_cfg;
>>   
>> +	if (pcie->cfg->has_split_msi_irq) {
>> +		pp->num_vectors = MAX_MSI_IRQS;
>> +		pp->has_split_msi_irq = true;
>> +	}
> 
> If all qcom platform that can support more than 32 MSI require multiple
> IRQs, how about adding num_vectors to the config instead and set
> pp->has_split_msi_irq when cfg->num_vectors is set (or unconditionally
> if you remove the corresponding warning you just added to the dwc host
> code)?
> 
> At least some sc8280xp seem to only support 128 MSI (using 4 IRQs).

Nice idea, let's do this.

> 
>> +
>>   	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>>   	if (IS_ERR(pcie->reset)) {
>>   		ret = PTR_ERR(pcie->reset);
> 
> Johan


-- 
With best wishes
Dmitry

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653B1553A08
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 21:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352715AbiFUTKw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 15:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiFUTKu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 15:10:50 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E0320F43
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 12:10:49 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c4so23935129lfj.12
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i29BTqmsCMU84u5F3MslriTPhy40bdELmGBDgd2AGXM=;
        b=ICbNBUW+MOM6OjqyGA60V1mhIwo0IXYbfAP3+J4C70erV48B+86ajHJzii7XyY9Psp
         NtAUm4Djm65zV3KSlpVoizGewNWVq8m62FnehitL4XWmOSMe4cBQ3VmnELorB3rZonZL
         dV0fBn5YwoBnaceYHGgX1EC//rV3pIyuKQx4uswPcJ7VLhmEST+lhFvRuMgDCOI+2Rhc
         STItEQeghGVEympg21etdLX9jpCOU5T1qh4MWrErPwMZxYTY0hWbdonVYYhAVDXyUaFA
         zTbW/YLZ62nWcGmUKmBM9yCjfThhspAQxj2rcD3VIcN8kI0R1nylAU4uIH6g+AwEJFu4
         xA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i29BTqmsCMU84u5F3MslriTPhy40bdELmGBDgd2AGXM=;
        b=MANv2MaB1G2ZjRJCqmpxR0bjI63gdnW1jao4xT0avC3sBg9JziwImt5sXc49h1kJ3X
         /6cTEt9mAzbgZwF3K5WiXKHAePRBZCaOq9uFdqSOWRowguwW5jjl5fTNkt67QEf8oIYz
         ImJ366b4MqIYu27mBohlRTTug+isz0gQ1UbAic8QnVQk3tlNJdKDXOspIN4G+DUtQBbl
         +r9Xz8qYyUqV6Tyb7XI2JT3UZ1iv9TlpZi6O6VnYfQTkwQ46Iox39CBI3bTiii6zMbYd
         lvDyGv6AvpQ4laWLJGh2KVxuy6AsPeYEdHtciDT+uuNqKsjH1WGKRQ/Yr3sdFzCegbQ8
         yMPA==
X-Gm-Message-State: AJIora/aESydykoqgeg+fRhQKwoQpa8lecUULM8jL0eGdKHcR3bQVAs3
        CzvV/ZBokQdqxuRXBLBh9hqh20sSuDbM5w==
X-Google-Smtp-Source: AGRyM1vL0TtajUeOJQp8Cv92b2RohmGgmEB5vAE5GUDt1QgCdEp4vQrPb9fWqQ+25Y7t06djoyVBCw==
X-Received: by 2002:a05:6512:3b1e:b0:47d:c338:9c07 with SMTP id f30-20020a0565123b1e00b0047dc3389c07mr18282905lfv.186.1655838646118;
        Tue, 21 Jun 2022 12:10:46 -0700 (PDT)
Received: from [192.168.43.7] ([188.162.64.230])
        by smtp.gmail.com with ESMTPSA id x5-20020a056512078500b0047f77729723sm673737lfr.43.2022.06.21.12.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 12:10:45 -0700 (PDT)
Message-ID: <e51f48ce-1561-1593-3442-d09a4c48c70e@linaro.org>
Date:   Tue, 21 Jun 2022 22:10:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] PCI: qcom: fix IPQ8074 Gen2 support
Content-Language: en-GB
To:     Robert Marko <robimarko@gmail.com>
Cc:     svarbanov@mm-sol.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lpieralisi@kernel.org, Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        johan+linaro@kernel.org
References: <20220621112330.448754-1-robimarko@gmail.com>
 <CAA8EJpoPJKVteUdsxOVH5THH_vqwBrdSn=hkbW4oWmpw+Mjdmg@mail.gmail.com>
 <CAOX2RU4N26weZU4bBTsJ+zuDZnNoW6_UxNKwfSii0LDed9p1_A@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAOX2RU4N26weZU4bBTsJ+zuDZnNoW6_UxNKwfSii0LDed9p1_A@mail.gmail.com>
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

On 21/06/2022 21:53, Robert Marko wrote:
> On Tue, 21 Jun 2022 at 19:29, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Tue, 21 Jun 2022 at 14:23, Robert Marko <robimarko@gmail.com> wrote:
>>>
>>> IPQ8074 has one Gen2 and one Gen3 port, currently the Gen2 port will
>>> cause the system to hang as its using DBI registers in the .init
>>> and those are only accesible after phy_power_on().
>>>
>>> So solve this by splitting the DBI read/writes to .post_init.
>>>
>>> Fixes: a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code")
>>
>> Any elaboration for the Fixes tag? I think the follow one is more
>> logical, isn't it?
>>
>> Fixes: 5d76117f070d ("PCI: qcom: Add support for IPQ8074 PCIe controller")
> 
> Hi,
> My logic was that it was working before the commit a0fd361db8e5 as it
> moved PHY init
> later and indirectly broke IPQ8074 gen2.

Ack, thanks for the explanation.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Regards,
> Robert
>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>>> Changes in v2:
>>> * Rebase onto next-20220621
>>> ---
>>>   drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++++++++++-----------
>>>   1 file changed, 28 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index 51fed83484af..da6d79d61397 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -1061,9 +1061,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
>>>          struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
>>>          struct dw_pcie *pci = pcie->pci;
>>>          struct device *dev = pci->dev;
>>> -       u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>>>          int i, ret;
>>> -       u32 val;
>>>
>>>          for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
>>>                  ret = reset_control_assert(res->rst[i]);
>>> @@ -1120,6 +1118,33 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
>>>                  goto err_clk_aux;
>>>          }
>>>
>>> +       return 0;
>>> +
>>> +err_clk_aux:
>>> +       clk_disable_unprepare(res->ahb_clk);
>>> +err_clk_ahb:
>>> +       clk_disable_unprepare(res->axi_s_clk);
>>> +err_clk_axi_s:
>>> +       clk_disable_unprepare(res->axi_m_clk);
>>> +err_clk_axi_m:
>>> +       clk_disable_unprepare(res->iface);
>>> +err_clk_iface:
>>> +       /*
>>> +        * Not checking for failure, will anyway return
>>> +        * the original failure in 'ret'.
>>> +        */
>>> +       for (i = 0; i < ARRAY_SIZE(res->rst); i++)
>>> +               reset_control_assert(res->rst[i]);
>>> +
>>> +       return ret;
>>> +}
>>> +
>>> +static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
>>> +{
>>> +       struct dw_pcie *pci = pcie->pci;
>>> +       u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>>> +       u32 val;
>>> +
>>>          writel(SLV_ADDR_SPACE_SZ,
>>>                  pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
>>>
>>> @@ -1147,24 +1172,6 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
>>>                  PCI_EXP_DEVCTL2);
>>>
>>>          return 0;
>>> -
>>> -err_clk_aux:
>>> -       clk_disable_unprepare(res->ahb_clk);
>>> -err_clk_ahb:
>>> -       clk_disable_unprepare(res->axi_s_clk);
>>> -err_clk_axi_s:
>>> -       clk_disable_unprepare(res->axi_m_clk);
>>> -err_clk_axi_m:
>>> -       clk_disable_unprepare(res->iface);
>>> -err_clk_iface:
>>> -       /*
>>> -        * Not checking for failure, will anyway return
>>> -        * the original failure in 'ret'.
>>> -        */
>>> -       for (i = 0; i < ARRAY_SIZE(res->rst); i++)
>>> -               reset_control_assert(res->rst[i]);
>>> -
>>> -       return ret;
>>>   }
>>>
>>>   static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>>> @@ -1598,6 +1605,7 @@ static const struct qcom_pcie_ops ops_2_4_0 = {
>>>   static const struct qcom_pcie_ops ops_2_3_3 = {
>>>          .get_resources = qcom_pcie_get_resources_2_3_3,
>>>          .init = qcom_pcie_init_2_3_3,
>>> +       .post_init = qcom_pcie_post_init_2_3_3,
>>>          .deinit = qcom_pcie_deinit_2_3_3,
>>>          .ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>>>   };
>>> --
>>> 2.36.1
>>>
>>
>>
>> --
>> With best wishes
>> Dmitry


-- 
With best wishes
Dmitry

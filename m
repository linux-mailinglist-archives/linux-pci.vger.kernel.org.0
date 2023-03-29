Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DD16CD9DF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 15:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjC2NER (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 09:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC2NEQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 09:04:16 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE36A4
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2023 06:04:13 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e9so769299ljq.4
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2023 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680095052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gK6jCpWS6XZzlwCBse9a1W1MSJWJSORYpFBcbQQ1ryM=;
        b=ObzUHix/WjxC5bQHVz7xyD1NBSbC4zo49uWu6QPiVZ7UtnZfWb5nkb5lMS0iV+5ku2
         LLNlJmq5Qs7R/GFGebZ5QpON/BhCjAYrT0WyYY40IEjicb/EvwKRJMIbZAudrRP4OyvI
         CMiDupUrEtE7wTQ4xRnUEIpf6cG4pSgWU5x7HB8XlN2pENAU2A/AcVYtlRufwLOwSg2i
         kdAqP5LZiUM9i8N5NmOv4hXYuvNrj/g7o7oj8ROeWLNp8tYkCg/7nKATBLbNjLpUTfov
         ZsDOzEf4P8ehqnJyUmMFivv/mgyBjRdWI37V77tT9c1jss9nYhBn3CUWLvSk0hO9zSlP
         ibtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680095052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gK6jCpWS6XZzlwCBse9a1W1MSJWJSORYpFBcbQQ1ryM=;
        b=aQcq4x8QLJKieokATuOU24S/SWtFKaATvjhFI7RNbgf5babRBbGM9qqHo1kOMrrMGt
         OzG+/jC0a4LD5wFt1bras5IPvswXftu8BRZ7rOSJhtwITANwyHzFc11ALYugWCZSc/+F
         RbemvbSh/nZcMl99W684oTbVfYxHqla3Rg2+4BJ6J6c0zAlkArV9mAacqE/2R7kRZdgu
         u2KyHAmCVbhnCePvsSt6a47SumDQmCmjNutmaepWcN8YzOcBe9ir56VBHv5zWdxXHgFA
         3iRTXAtbLAaNghvyjxb1n3MtKE/BN9CPgN4C6Wb+ltHDTIVZO/n029Sj0bctMq4Q7Zcn
         mYhQ==
X-Gm-Message-State: AAQBX9dGNuf2AG0nCEWOOjwJ13huC95u49vNYwPlxiK5k3vl2a3EJU2o
        VNo0+79hbzVYCXs36akRuripX8iCNo5WsgG0mkY=
X-Google-Smtp-Source: AKy350ZDSe2usqvbDxH0GB/1U1JaD7v7CuKSwNu6clb8QTqhBF3xT0WcREkdQgAOd0io9ri98s2gWw==
X-Received: by 2002:a2e:320a:0:b0:298:b03d:5715 with SMTP id y10-20020a2e320a000000b00298b03d5715mr6306176ljy.25.1680095052252;
        Wed, 29 Mar 2023 06:04:12 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002a483f01d9csm1929207ljb.85.2023.03.29.06.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 06:04:11 -0700 (PDT)
Message-ID: <4518f47f-fde7-be87-6cc0-a034d76e886c@linaro.org>
Date:   Wed, 29 Mar 2023 15:04:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [EXT] [PATCH v3 1/1] PCI: qcom: Add support for system suspend
 and resume
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Frank Li <frank.li@nxp.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_krichai@quicinc.com" <quic_krichai@quicinc.com>,
        "johan+linaro@kernel.org" <johan+linaro@kernel.org>,
        "steev@kali.org" <steev@kali.org>,
        "mka@chromium.org" <mka@chromium.org>, Dhruva Gole <d-gole@ti.com>
References: <20230327133824.29136-1-manivannan.sadhasivam@linaro.org>
 <20230327133824.29136-2-manivannan.sadhasivam@linaro.org>
 <AM6PR04MB4838C84574BE534DDB0428D0888B9@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <20230329130237.GC5575@thinkpad>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230329130237.GC5575@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 29.03.2023 15:02, Manivannan Sadhasivam wrote:
> On Mon, Mar 27, 2023 at 03:29:54PM +0000, Frank Li wrote:
>>
>>
>>> -----Original Message-----
>>> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> Sent: Monday, March 27, 2023 8:38 AM
>>> To: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org
>>> Cc: andersson@kernel.org; konrad.dybcio@linaro.org;
>>> bhelgaas@google.com; linux-pci@vger.kernel.org; linux-arm-
>>> msm@vger.kernel.org; linux-kernel@vger.kernel.org;
>>> quic_krichai@quicinc.com; johan+linaro@kernel.org; steev@kali.org;
>>> mka@chromium.org; Manivannan Sadhasivam
>>> <manivannan.sadhasivam@linaro.org>; Dhruva Gole <d-gole@ti.com>
>>> Subject: [EXT] [PATCH v3 1/1] PCI: qcom: Add support for system suspend
>>> and resume
>>>
>>> Caution: EXT Email
>>>
>>> During the system suspend, vote for minimal interconnect bandwidth and
>>> also turn OFF the resources like clock and PHY if there are no active
>>> devices connected to the controller. For the controllers with active
>>> devices, the resources are kept ON as removing the resources will
>>> trigger access violation during the late end of suspend cycle as kernel
>>> tries to access the config space of PCIe devices to mask the MSIs.
>>
>> I remember I met similar problem before. It is relate ASPM settings of NVME.
>> NVME try to use L1.2 at suspend to save restore time. 
>>
>> It should be user decided if PCI enter L1.2( for better resume time) or L2
>> For batter power saving.  If NVME disable ASPM,  NVME driver will free
>> Msi irq before enter suspend,  so not issue access config space by MSI
>> Irq disable function. 
>>
> 
> The NVMe driver will only shutdown the device if ASPM is completely disabled in
> the kernel. They also take powerdown path for some Intel platforms though. For
> others, they keep the device in power on state and expect power saving with
> ASPM.
> 
>> This is just general comment. It is not specific for this patches.  Many platform
>> Will face the similar problem.  Maybe need better solution to handle
>> L2/L3 for better power saving in future. 
>>
> 
> The only argument I hear from them is that, when the NVMe device gets powered
> down during suspend, then it may detoriate the life time of it as the suspend
> cycle is going to be high.
I think I asked that question before, but.. Do we know what Windows/macOS do?

Konrad
> 
> - Mani
> 
>> Frank Li
>>  
>>>
>>> Also, it is not desirable to put the link into L2/L3 state as that
>>> implies VDD supply will be removed and the devices may go into powerdown
>>> state. This will affect the lifetime of storage devices like NVMe.
>>>
>>> And finally, during resume, turn ON the resources if the controller was
>>> truly suspended (resources OFF) and update the interconnect bandwidth
>>> based on PCIe Gen speed.
>>>
>>> Suggested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>> Acked-by: Dhruva Gole <d-gole@ti.com>
>>> Signed-off-by: Manivannan Sadhasivam
>>> <manivannan.sadhasivam@linaro.org>
>>> ---
>>>  drivers/pci/controller/dwc/pcie-qcom.c | 62 ++++++++++++++++++++++++++
>>>  1 file changed, 62 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
>>> b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index a232b04af048..f33df536d9be 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -227,6 +227,7 @@ struct qcom_pcie {
>>>         struct gpio_desc *reset;
>>>         struct icc_path *icc_mem;
>>>         const struct qcom_pcie_cfg *cfg;
>>> +       bool suspended;
>>>  };
>>>
>>>  #define to_qcom_pcie(x)                dev_get_drvdata((x)->dev)
>>> @@ -1820,6 +1821,62 @@ static int qcom_pcie_probe(struct
>>> platform_device *pdev)
>>>         return ret;
>>>  }
>>>
>>> +static int qcom_pcie_suspend_noirq(struct device *dev)
>>> +{
>>> +       struct qcom_pcie *pcie = dev_get_drvdata(dev);
>>> +       int ret;
>>> +
>>> +       /*
>>> +        * Set minimum bandwidth required to keep data path functional during
>>> +        * suspend.
>>> +        */
>>> +       ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));
>>> +       if (ret) {
>>> +               dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
>>> +               return ret;
>>> +       }
>>> +
>>> +       /*
>>> +        * Turn OFF the resources only for controllers without active PCIe
>>> +        * devices. For controllers with active devices, the resources are kept
>>> +        * ON and the link is expected to be in L0/L1 (sub)states.
>>> +        *
>>> +        * Turning OFF the resources for controllers with active PCIe devices
>>> +        * will trigger access violation during the end of the suspend cycle,
>>> +        * as kernel tries to access the PCIe devices config space for masking
>>> +        * MSIs.
>>> +        *
>>> +        * Also, it is not desirable to put the link into L2/L3 state as that
>>> +        * implies VDD supply will be removed and the devices may go into
>>> +        * powerdown state. This will affect the lifetime of the storage devices
>>> +        * like NVMe.
>>> +        */
>>> +       if (!dw_pcie_link_up(pcie->pci)) {
>>> +               qcom_pcie_host_deinit(&pcie->pci->pp);
>>> +               pcie->suspended = true;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int qcom_pcie_resume_noirq(struct device *dev)
>>> +{
>>> +       struct qcom_pcie *pcie = dev_get_drvdata(dev);
>>> +       int ret;
>>> +
>>> +       if (pcie->suspended) {
>>> +               ret = qcom_pcie_host_init(&pcie->pci->pp);
>>> +               if (ret)
>>> +                       return ret;
>>> +
>>> +               pcie->suspended = false;
>>> +       }
>>> +
>>> +       qcom_pcie_icc_update(pcie);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>  static const struct of_device_id qcom_pcie_match[] = {
>>>         { .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
>>>         { .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
>>> @@ -1856,12 +1913,17 @@
>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302,
>>> qcom_fixup_class);
>>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000,
>>> qcom_fixup_class);
>>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001,
>>> qcom_fixup_class);
>>>
>>> +static const struct dev_pm_ops qcom_pcie_pm_ops = {
>>> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_suspend_noirq,
>>> qcom_pcie_resume_noirq)
>>> +};
>>> +
>>>  static struct platform_driver qcom_pcie_driver = {
>>>         .probe = qcom_pcie_probe,
>>>         .driver = {
>>>                 .name = "qcom-pcie",
>>>                 .suppress_bind_attrs = true,
>>>                 .of_match_table = qcom_pcie_match,
>>> +               .pm = &qcom_pcie_pm_ops,
>>>         },
>>>  };
>>>  builtin_platform_driver(qcom_pcie_driver);
>>> --
>>> 2.25.1
>>
> 

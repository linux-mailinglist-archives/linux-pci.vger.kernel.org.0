Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34866CD9CC
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 14:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjC2M7c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 08:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjC2M73 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 08:59:29 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3264C0D
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2023 05:59:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h9so16027461ljq.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2023 05:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680094750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DN7nLDKC0wq8dGrzJBNXiUHRCnSTtTOjORw0FU5XSS8=;
        b=jOan5d/H+H/ao9TG7rZDuvTaXYlnqSsbenccBNzTKS//NceetxK8PRWvGUPkmmQCp7
         vyoVlpl19UsE4PmF7Va6mJkZk6H5ht/69J9dta8ZqjWcnqFh6TUgpdv1b/MezuczWE2A
         tCvXoqg6J4eBXPqMsiloPoXEKauGQhALHACo3qZbFVOx/QcsN0hd36/oV6BZfhBpngSe
         jy0L8L/lYHZd4atKvxVOywlEmyrzYUk8IADLVy9q0YX1pKvd5ObCmeXybX+dHpna5ulr
         cFl1r5ct70si99tEgaOyhUGVJeoQbLAZ35dV6dX/n/3ytS0jnhXGgrsgqlBD+mOxgsVq
         02FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680094750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DN7nLDKC0wq8dGrzJBNXiUHRCnSTtTOjORw0FU5XSS8=;
        b=PPyFvYMPfPbQBPWWL4rmLo9wS2+anJbdTHkyx8XnpldYum6T4/yno6wG4JD6td7Tmv
         /f8BSog7Zs81sVM1LsS3XWMuzsE4XwK9o3+iaPLIuN8oSz8VlxGsJpvXHep51KYqJoGD
         BMZLm1x6nA2Qyl7kwtusKxvTS7n1qYFJBTEobdUWbs1npp5HSCFV6Q5tmVZ00+vZwsUd
         iZW0q8aSJPFgnJbsX/XW/CB+bAtex39I5LNA4WkTpUU0/QtNDlC/Ym2wKXyXxmeHlOmC
         ekwmltPhRhH5qK8rt8wWNnFZMfnHzuaSCkpN6ke/slmo+Hr5CeVZqJxciaMMLpWFQozL
         Bspg==
X-Gm-Message-State: AAQBX9c6JfL283jKjrFRJlkFDPMFMmIHYDCsuDS9vBZ67+w4RUwZNEJG
        IY3CB6YAx/R0EQwVItV962eImg==
X-Google-Smtp-Source: AKy350bhOm/sYJy3xwAQ36O7mp2DARw2I2S/mlwa5XlM84lIVivjftmZ/BG1cNMc9bWCts/HJPsPjA==
X-Received: by 2002:a2e:874e:0:b0:2a2:79e9:decc with SMTP id q14-20020a2e874e000000b002a279e9deccmr5909956ljj.53.1680094750388;
        Wed, 29 Mar 2023 05:59:10 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id z26-20020a05651c023a00b00295b842c2dbsm5504119ljn.133.2023.03.29.05.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 05:59:10 -0700 (PDT)
Message-ID: <097f4778-9f8e-67a8-85bc-14f4be3dadc0@linaro.org>
Date:   Wed, 29 Mar 2023 14:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/1] PCI: qcom: Add support for system suspend and
 resume
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        andersson@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
        johan+linaro@kernel.org, steev@kali.org, mka@chromium.org,
        Dhruva Gole <d-gole@ti.com>
References: <20230327133824.29136-1-manivannan.sadhasivam@linaro.org>
 <20230327133824.29136-2-manivannan.sadhasivam@linaro.org>
 <ZCQLWzqKPrusMro+@hovoldconsulting.com> <20230329125232.GB5575@thinkpad>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230329125232.GB5575@thinkpad>
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



On 29.03.2023 14:52, Manivannan Sadhasivam wrote:
> On Wed, Mar 29, 2023 at 11:56:43AM +0200, Johan Hovold wrote:
>> On Mon, Mar 27, 2023 at 07:08:24PM +0530, Manivannan Sadhasivam wrote:
>>> During the system suspend, vote for minimal interconnect bandwidth and
>>> also turn OFF the resources like clock and PHY if there are no active
>>> devices connected to the controller. For the controllers with active
>>> devices, the resources are kept ON as removing the resources will
>>> trigger access violation during the late end of suspend cycle as kernel
>>> tries to access the config space of PCIe devices to mask the MSIs.
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
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>  drivers/pci/controller/dwc/pcie-qcom.c | 62 ++++++++++++++++++++++++++
>>>  1 file changed, 62 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index a232b04af048..f33df536d9be 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -227,6 +227,7 @@ struct qcom_pcie {
>>>  	struct gpio_desc *reset;
>>>  	struct icc_path *icc_mem;
>>>  	const struct qcom_pcie_cfg *cfg;
>>> +	bool suspended;
>>>  };
>>>  
>>>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>>> @@ -1820,6 +1821,62 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>>  	return ret;
>>>  }
>>>  
>>> +static int qcom_pcie_suspend_noirq(struct device *dev)
>>> +{
>>> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>>> +	int ret;
>>> +
>>> +	/*
>>> +	 * Set minimum bandwidth required to keep data path functional during
>>> +	 * suspend.
>>> +	 */
>>> +	ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));
>>
>> This isn't really the minimum bandwidth you're setting here.
>>
>> I think you said off list that you didn't see real impact reducing the
>> bandwidth, but have you tried requesting the real minimum which would be
>> kBps_to_icc(1)?
>>
>> Doing so works fine here with both the CRD and X13s and may result in
>> some further power savings.
>>
> 
> No, we shouldn't be setting random value as the bandwidth. Reason is, these
> values are computed by the bus team based on the requirement of the interconnect
> paths (clock, voltage etc...) with actual PCIe Gen speeds.
Should it then be variable, based on the current link gen?

Konrad
I don't know about
> the potential implication even if it happens to work.
> 
> - Mani
> 
>>> +	if (ret) {
>>> +		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
>>> +		return ret;
>>> +	}
>>
>> Johan
> 

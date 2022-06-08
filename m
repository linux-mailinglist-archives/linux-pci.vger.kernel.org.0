Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF1F542BA2
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 11:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiFHJgN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 05:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiFHJfn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 05:35:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA09125594
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 01:58:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w20so10531624lfa.11
        for <linux-pci@vger.kernel.org>; Wed, 08 Jun 2022 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/pGSw391BzRvIqn5v5qVcewQbHvJEoL3fOObdtgaFK0=;
        b=oC7CCyVjF74wVjB91MELdLfDquFJF+e71AY29y4+HXEC0zAM8BGSxcCk2cZongbUIo
         InExNfmJz0ZAKxNrzdrqIRIMqbWn30o4jNun14+GlQsZXW3nmEPjkuxExcepbkGx/lAn
         moe+7kpbNE1pMb22DGMrSALHVTQmak92Z7iHyi5gWfQSwNk/zwsYn8BpE++IRj6oFJ42
         8Nu0j/AAe+U2ZaXzTcEXoaoYIY7UmZn6JS1LADrVimrSnIBZjjDswx/1VUDu46m1p96O
         WBjTiJWzyDsVb9zLb9A9aOPwJgKcnDXGSUOejnnqfkZNNfy/an7Dg4JdFc01TYuYsA62
         jybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/pGSw391BzRvIqn5v5qVcewQbHvJEoL3fOObdtgaFK0=;
        b=AlVfbAJnjIv/EoZ7P8kEjpNW0aDfo9Rgh2ujvIlroG3hopOikMC64A+0Hv58CKvagk
         PUfZbU0EWrBLO2xH4lNjb/Ch45jsr2Kuzc3jq4iu5rMoXO6up5jRdOw7QAKg3iNbOok7
         zva1/yjI9sgvT4u460LMJnWPgV97B5BipO1byyWUjA8R0O0z8MocWxpNf+Rw4daH/Wm4
         fZaaYL8/pHCFMrceXFqTjzb4n812t/Br7F4UcJ3u343I/jgl6rWxnfGf4RQyBhrsIFW4
         4ptykDTtSy7I6njm+89wjd4xsVflhKfNVQbAM0Me093e4X+dpw1PRREK+0YDXkQvWilV
         q8xQ==
X-Gm-Message-State: AOAM532nEq0y/DgzAVHg8eSEit1f030+MObHwLx1I9CnMDW/D+V9qyRZ
        2WrysRXVPipdZ3o2jJVUD6dp2A==
X-Google-Smtp-Source: ABdhPJw/yCbkKMV9QBiCoHF7IaP7UTuYj5YEkWOQvgTGiEg+NlmnvvzasV2gV5cuC7t6mAQwDIoaRQ==
X-Received: by 2002:a05:6512:3284:b0:479:d2:4792 with SMTP id p4-20020a056512328400b0047900d24792mr23532874lfe.357.1654678728005;
        Wed, 08 Jun 2022 01:58:48 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p9-20020a056512312900b004794a78bfe7sm1196198lfd.6.2022.06.08.01.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:58:47 -0700 (PDT)
Message-ID: <58f1282d-3c13-59b3-84e6-0cf39f846dd1@linaro.org>
Date:   Wed, 8 Jun 2022 11:58:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v13 4/7] PCI: dwc: Handle MSIs routed to multiple GIC
 interrupts
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
References: <20220603074137.1849892-1-dmitry.baryshkov@linaro.org>
 <20220603074137.1849892-5-dmitry.baryshkov@linaro.org>
 <Yp4q5S7WIYbYEdHc@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Yp4q5S7WIYbYEdHc@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/06/2022 19:27, Johan Hovold wrote:
> On Fri, Jun 03, 2022 at 10:41:34AM +0300, Dmitry Baryshkov wrote:
>> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
>> separate GIC interrupt. Implement support for such configurations by
>> parsing "msi0" ... "msiN" interrupts and attaching them to the chained
>> handler.
>>
>> Note, that if DT doesn't list an array of MSI interrupts and uses single
>> "msi" IRQ, the driver will limit the amount of supported MSI vectors
>> accordingly (to 32).
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   .../pci/controller/dwc/pcie-designware-host.c | 63 +++++++++++++++++--
>>   1 file changed, 59 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 85c1160792e1..d1f9e20df903 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -289,6 +289,46 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
>>   	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
>>   }
>>   
>> +static int dw_pcie_parse_split_msi_irq(struct pcie_port *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct device *dev = pci->dev;
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	int irq;
>> +	u32 ctrl, max_vectors;
>> +
>> +	/* Parse as many IRQs as described in the devicetree. */
>> +	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
>> +		char *msi_name = "msiX";
>> +
>> +		msi_name[3] = '0' + ctrl;
> 
> This oopses here as the string constant is read only:
> 
> 	[   19.787973] Unable to handle kernel write to read-only memory at virtual address ffffaa14f831afd3
> 
> Did you not test the series before posting?

Interesting enough the posted series works for me. Maybe I have a 
different set of debugging options. But thanks for spotting this. I'll 
post v14.

> 
> You need to define msi_name as:
> 
> 	char msi_name[] = "msiX";
> 
>> +		irq = platform_get_irq_byname_optional(pdev, msi_name);
>> +		if (irq == -ENXIO)
>> +			break;
>> +		if (irq < 0)
>> +			return dev_err_probe(dev, irq,
>> +					     "Failed to parse MSI IRQ '%s'\n",
>> +					     msi_name);
>> +
>> +		pp->msi_irq[ctrl] = irq;
>> +	}
> 
> Johan


-- 
With best wishes
Dmitry

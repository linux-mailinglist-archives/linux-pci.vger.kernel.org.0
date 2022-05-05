Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E5E51BB55
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 11:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351192AbiEEJE4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 05:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351253AbiEEJEz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 05:04:55 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117404BB8B
        for <linux-pci@vger.kernel.org>; Thu,  5 May 2022 02:01:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id t25so4748791ljd.6
        for <linux-pci@vger.kernel.org>; Thu, 05 May 2022 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nyIBkdlH8U+DPOrC3RC5Dq9VLCYMkjKzwYlgP0rAk1k=;
        b=Q51CwriF+iL8MVkMj8c/hXTpY68rIgy1NAf3Jy8TmZX+/aNLKmfUv8M95nnjvvCVxl
         fXkU2+pLhQWLdolAwSi5To8Ncu1aVqoZK/fRUuwkivLNnmXcJaPVSHyvMxIYlxEysn1r
         wPQ++uPSuVpMhoaiknaXxdFNlPV0R7j3kJ5VdQlyYmkpnqm+wTWwC1RKW/ydEuDCxx4Y
         kGGS13Cz+5C5PcaQmwHYq7U+rufZzVZbBqw05Lw8F7fu0qNzr7PEN3hidFA2YhP966wr
         sh8N0fv3k6OqN2FHEdZGP9mafe/sW0DdU9xtrjok3yAh3DjK9redRVEaZKkkRV8zU/yK
         sY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nyIBkdlH8U+DPOrC3RC5Dq9VLCYMkjKzwYlgP0rAk1k=;
        b=BnWenghTrCK7Qb1DB/qcBYhK/4E2iIN8V2mPopfuEAEB3XTs2yslRXchwfIbBx9t79
         F1CBOU6Plw3Cav4NKEMKkWxpDKuisUGNSnGKqcBxWtCYmaaHDiCLfrk3ejt15avHQA83
         wvJU7N9wACxOZrG1SMSkqEksqK0kcUA1keDhQEXmiHg+Rq9EzozwreVgJ26bgu1gD3Vb
         mFWmwimt0wjoIa6kSOVx9kqA49ZfhS5MpbDCoM+U9jmR5flXypMq5miLQhYAWduXzJcL
         JXtxRaD9QisVTMmCm84cNqErWp2ftn3KJiTBcHMo/aUshw+M92ZXtkMXdR6xrQzscWOH
         MO4g==
X-Gm-Message-State: AOAM530GBfYpbue0H/oRaq+6JDCnEnBh50hZp9ve1XBvAi3d4/jbUmsY
        /tVIzO7nfcJYlCB6MD61C3voPA==
X-Google-Smtp-Source: ABdhPJzn8SSdzkNetfVnZx3IjWLHvwKHt1Q/uwWpSdXtsT7FpWUxIXOsp23Xbpd7c5RQIs82SPqAgg==
X-Received: by 2002:a2e:a448:0:b0:24c:8fe8:f3c6 with SMTP id v8-20020a2ea448000000b0024c8fe8f3c6mr15491045ljn.115.1651741267222;
        Thu, 05 May 2022 02:01:07 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bp20-20020a056512159400b0047255d211d5sm131056lfb.260.2022.05.05.02.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 02:01:06 -0700 (PDT)
Message-ID: <73cebbb5-518c-e3b9-85d4-f81cda28ae07@linaro.org>
Date:   Thu, 5 May 2022 12:01:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 5/7] PCI: qcom: Handle MSI IRQs properly
Content-Language: en-GB
To:     Bjorn Helgaas <helgaas@kernel.org>
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
References: <20220429224732.GA111265@bhelgaas>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220429224732.GA111265@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/04/2022 01:47, Bjorn Helgaas wrote:
> In subject, "Handle MSI IRQs properly" really doesn't tell us anything
> useful.  The existing MSI support handles some MSI IRQs "properly," so
> we should say something specific about the improvements here, like
> "Handle multiple MSI groups" or "Handle MSIs routed to multiple GIC
> interrupts" or "Handle split MSI IRQs" or similar.
> 
> On Sat, Apr 30, 2022 at 12:42:48AM +0300, Dmitry Baryshkov wrote:
>> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
>> separate GIC interrupt. Thus to receive higher MSI vectors properly,
>> add separate msi_host_init()/msi_host_deinit() handling additional host
>> IRQs.
> 
>> +static void qcom_chained_msi_isr(struct irq_desc *desc)
>> +{
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	int irq = irq_desc_get_irq(desc);
>> +	struct pcie_port *pp;
>> +	int idx, pos;
>> +	unsigned long val;
>> +	u32 status, num_ctrls;
>> +	struct dw_pcie *pci;
>> +	struct qcom_pcie *pcie;
>> +
>> +	chained_irq_enter(chip, desc);
>> +
>> +	pp = irq_desc_get_handler_data(desc);
>> +	pci = to_dw_pcie_from_pp(pp);
>> +	pcie = to_qcom_pcie(pci);
>> +
>> +	/*
>> +	 * Unlike generic dw_handle_msi_irq we can determine, which group of
>> +	 * MSIs triggered the IRQ, so process just single group.
> 
> Parens and punctuation touch-up:
> 
>    Unlike generic dw_handle_msi_irq(), we can determine which group of
>    MSIs triggered the IRQ, so process just that group.
> 
>> +	 */
>> +	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
>> +
>> +	for (idx = 0; idx < num_ctrls; idx++) {
>> +		if (pcie->msi_irqs[idx] == irq)
>> +			break;
>> +	}
> 
> Since this is basically an enhanced clone of dw_handle_msi_irq(), it
> would be nice to use the same variable names ("i" instead of "idx")
> so it's not gratuitously different.
> 
> Actually, I wonder if you could enhance dw_handle_msi_irq() slightly
> so you could use it directly, e.g.,
> 
>      struct dw_pcie_host_ops {
>        ...
>        void (*msi_host_deinit)(struct pcie_port *pp);
>   +    bool (*msi_in_block)(struct pcie_port *pp, int irq, int i);
>      };
> 
>      dw_handle_msi_irq(...)
>      {
>        ...
> 
>        for (i = 0; i < num_ctrls; i++) {
>   +      if (pp->ops->msi_in_block && !pp->ops->msi_in_block(pp, irq, i))
>   +        continue;
> 
> 	status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS ...);
> 	...
> 
>   +  bool qcom_pcie_msi_in_block(struct pcie_port *pp, int irq, int i)
>   +  {
>   +    ...
>   +    pci = to_dw_pcie_from_pp(pp);
>   +    pcie = to_qcom_pcie(pci);
>   +
>   +    if (pcie->msi_irqs[i] == irq)
>   +      return true;
>   +
>   +    return false;
>   +  }
> 
> Maybe that's more complicated than it's worth.

I think it will complicate the IRQ handler unnecessary. Just using a 
separate handler seems simpler.

> 
>> +
>> +	if (WARN_ON_ONCE(unlikely(idx == num_ctrls)))
>> +		goto out;
>> +
>> +	status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
>> +				   (idx * MSI_REG_CTRL_BLOCK_SIZE));
>> +	if (!status)
>> +		goto out;
>> +
>> +	val = status;
>> +	pos = 0;
>> +	while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
>> +				    pos)) != MAX_MSI_IRQS_PER_CTRL) {
>> +		generic_handle_domain_irq(pp->irq_domain,
>> +					  (idx * MAX_MSI_IRQS_PER_CTRL) +
>> +					  pos);
>> +		pos++;
>> +	}
>> +
>> +out:
>> +	chained_irq_exit(chip, desc);
>> +}


-- 
With best wishes
Dmitry

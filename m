Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA00536BDD
	for <lists+linux-pci@lfdr.de>; Sat, 28 May 2022 11:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244603AbiE1JTs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 May 2022 05:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348569AbiE1JTr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 May 2022 05:19:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41101DA5B;
        Sat, 28 May 2022 02:19:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso6373899pjg.0;
        Sat, 28 May 2022 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qyK+J/hMtuTUruA03PI6DqGG/StA1icCX4LUIGhocgc=;
        b=qH8W6PWPfinC6W1dsB4Sh5n9Avx4kcrU4u9XphkM2vutqAIZIZfuxvSgEku6RuyGUH
         xOsWr5B0fZM8kd/Eyvujie2EKIuzLNSvPL4su90pOnHxFOjEO2H+GvM31W5sps0oh+6n
         d7iDS3eoURZkBgQy/jIwy6CmdOQzQ8cy4jM50sBNNrO94vuz9img9JYhu3hlHHYe7In7
         9QanKQQDiRaZme05dowaMoHM/gXt1IbuU/YCXEfGGndC17K6Cs4tH14v6H0IyslLkThB
         BFH6/y/UyDRBfFU98RUxJy9LYGwIWObnh7sErMYOv+x48u8/U83Vf557WibMsF6K5g0M
         EU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qyK+J/hMtuTUruA03PI6DqGG/StA1icCX4LUIGhocgc=;
        b=aBlNhVg/6GXQ0lXUpFSoiN4T1zeuMxuFQi4cyDDHeCHOjgoDz304r6qh4yvEIeCNIO
         8n5M69oHBsa3+YNN241K9FX1f5KbMwOtdcB480UaotBMGcA66txrkh5HM4RWh5ryKeGK
         WbxwxgbZ7pUkEgeLmrgXFxt7ALifftSta++HzDeHt6mNbze0BQwzVfQMMRz53qBlYYNy
         r0WpTtk13ud2uZa9ZlmFhL3MaWg8+49UoBBFVGzioNNgzCmxlZbVoQPZra1yO8/XkkHv
         y63D94UWaYcXljPicVQyMtGDWvKUj3oPyQG+u1ixRysfB5f549GSZqlSbk7uu0NMhnIF
         KBRw==
X-Gm-Message-State: AOAM531uAiCkSzo7MfbcA9IkBw4QPS10K6O9r9Lu9iDZvYQeVBPgvWsc
        cpvyvoh0B3sveGd5y40p9oU=
X-Google-Smtp-Source: ABdhPJz8YrzZDOOQcB3GYgrLZBT1lADYS4fKl4Nj0eDpS1sI6mRcXpUiCWa3V+ND/KF5ciK8FwKHEA==
X-Received: by 2002:a17:90b:314b:b0:1e0:5517:1730 with SMTP id ip11-20020a17090b314b00b001e055171730mr12521555pjb.57.1653729584100;
        Sat, 28 May 2022 02:19:44 -0700 (PDT)
Received: from [172.16.4.4] ([219.142.146.208])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001639e80eb55sm2742984plh.139.2022.05.28.02.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 02:19:43 -0700 (PDT)
Message-ID: <bd03ca71-1875-2e94-8040-533034f76ee5@gmail.com>
Date:   Sat, 28 May 2022 17:19:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] PCI: mediatek-gen3: Fix refcount leak in
 mtk_pcie_init_irq_domains
Content-Language: en-US
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     bhelgaas@google.com, jianjun.wang@mediatek.com, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, matthias.bgg@gmail.com, maz@kernel.org,
        robh@kernel.org, ryder.lee@mediatek.com
References: <20220526110246.53502-1-linmq006@gmail.com>
 <20220527084525.7170-1-miles.chen@mediatek.com>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <20220527084525.7170-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Miles,

On 2022/5/27 16:45, Miles Chen wrote:
> Hi Miaoqian,
>
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> ---
>> drivers/pci/controller/pcie-mediatek-gen3.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
>> index 3e8d70bfabc6..da8e9db0abdf 100644
>> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
>> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
>> @@ -600,6 +600,7 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
>> 						  &intx_domain_ops, pcie);
>> 	if (!pcie->intx_domain) {
>> 		dev_err(dev, "failed to create INTx IRQ domain\n");
>> +		of_node_put(intc_node);
>> 		return -ENODEV;
>> 	}
> Thanks for doing this.
>
> I checked mtk_pcie_init_irq_domains() and there are multiple exit paths like
> err_msi_domain and err_msi_bottom_domain and the normal path which also
> need of_node_put(intc_node).

Thanks for your reply,

I didn't add of_node_put() in other paths because I am not sure if the reference passed through irq_domain_add_linear(), since intc_node is passed to irq_domain_add_linear().

__irq_domain_add() keeps &node->fwnode in the irq_domain structure.

and use fwnode_handle_get() to get the reference of fwnode, but I still uncertain.

If the reference don't needed anymore after irq_domain_add_linear(),

your suggestion looks fine, and I will submit v2.

> Maybe we can move the of_node_put(intc_node) to #54 below and cover
> all possible paths?
>
>
> cheers,
> Miles
>
> e.g.,
>
> static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
> {
> 	struct device *dev = pcie->dev;
> 	struct device_node *intc_node, *node = dev->of_node;
> 	int ret;
>
> 	raw_spin_lock_init(&pcie->irq_lock);
>
> 	/* Setup INTx */
> 	intc_node = of_get_child_by_name(node, "interrupt-controller");
> 	if (!intc_node) {
> 		dev_err(dev, "missing interrupt-controller node\n");
> 		return -ENODEV;
> 	}
>
> 	pcie->intx_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
> 						  &intx_domain_ops, pcie);
> 	of_node_put(intc_node);
> 	if (!pcie->intx_domain) {
> 		dev_err(dev, "failed to create INTx IRQ domain\n");
> 		return -ENODEV;
> 	}
>
> 	/* Setup MSI */
> 	mutex_init(&pcie->lock);
>
> 	pcie->msi_bottom_domain = irq_domain_add_linear(node, PCIE_MSI_IRQS_NUM,
> 				  &mtk_msi_bottom_domain_ops, pcie);
> 	if (!pcie->msi_bottom_domain) {
> 		dev_err(dev, "failed to create MSI bottom domain\n");
> 		ret = -ENODEV;
> 		goto err_msi_bottom_domain;
> 	}
>
> 	pcie->msi_domain = pci_msi_create_irq_domain(dev->fwnode,
> 						     &mtk_msi_domain_info,
> 						     pcie->msi_bottom_domain);
> 	if (!pcie->msi_domain) {
> 		dev_err(dev, "failed to create MSI domain\n");
> 		ret = -ENODEV;
> 		goto err_msi_domain;
> 	}
>
> 	return 0;
>
> err_msi_domain:
> 	irq_domain_remove(pcie->msi_bottom_domain);
> err_msi_bottom_domain:
> 	irq_domain_remove(pcie->intx_domain);
>
> 	return ret;
> }
>> -- 
>> 2.25.1
>

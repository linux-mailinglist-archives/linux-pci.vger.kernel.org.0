Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E1D5392E2
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 16:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbiEaOBm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 10:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbiEaOBl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 10:01:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E24B2E;
        Tue, 31 May 2022 07:01:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so2800757pju.1;
        Tue, 31 May 2022 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Mrb04JIXyqFQ3QOJ4ljFjUENecQCixeg6qU8fHaKeZk=;
        b=obmR59m0Y0vY2NPUoD6WSZci9Ko+JC2tIToDAe4VBgkSuyXRWScFXBhpc/TGFu4ZJH
         0KqnwtrlMx0ODAJTwmUvhk0Mf3fffWaH68i6GXQhUfFygeCHcsr5dTR+RSX4O/6fGyC1
         s7GNfZ27SlwB8Sb4JaplTUwawtiFdoQ6go/zaaKo5JZAy1Az4Wh4t6ybDfhbnysvEv5E
         BOmLvezqVqTiu76Upwot5elJ/4u3bE2w4OYD3hV35WoSNgNCAsciv7CotPOVbHiCxkD+
         opMEQwLjyw4R3HMJpMxGDw1rcWV1jKhHwSCvTtvidbwWZif+Es7otGe4KP/UqS6lIQFJ
         KRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Mrb04JIXyqFQ3QOJ4ljFjUENecQCixeg6qU8fHaKeZk=;
        b=m6O5Emo3Qb7kP72Cm32kqU1Utfl2YzA7FaZAGsS5R1sVbzVWc5gC/bD9ogQ+1AIw3j
         SD1apj3Mf/3w/qH9K0/dlx2ZsVQOw+npJmBq77quZgPPDOwEOrYbK2O8o27fXOTgadZi
         evjYBSjicjKj6Ngs05zrbQOEjwH8PGml7dBMU5IJvEkLVaUCOBiiZtF/XIeio+PiraUw
         k7/c1OG8Pd3W3eSC4q4RJSNOUahyOoXffT79Hm7r5vB6RlEAT7hRh6j0wkqwV0r8vTLK
         T/Ak1l8EHEsA2yu1CcEIQEkQD1izlu0DeyAPRzgwf7hb7d1gzMAGd8z7vDriZvcj2twz
         Eetg==
X-Gm-Message-State: AOAM532pESMoW/68nbnZ8doMqDoTnbYNHFLhslKTAV98rtz/fJuxgcbm
        lmkXWwDZEmhBN8JI7yVZ8tY=
X-Google-Smtp-Source: ABdhPJzFnIkAf7SzEujOh3vbwx4zBDuoIj5QBUHpQkAIlLjI2rtJTa7RIM9vMNmPLUHXlHMlt1UTug==
X-Received: by 2002:a17:90a:9318:b0:1e0:b957:ffda with SMTP id p24-20020a17090a931800b001e0b957ffdamr29249871pjo.199.1654005699256;
        Tue, 31 May 2022 07:01:39 -0700 (PDT)
Received: from [172.16.4.4] ([219.142.146.208])
        by smtp.gmail.com with ESMTPSA id d5-20020aa78685000000b0050dc76281e6sm10642401pfo.192.2022.05.31.07.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 07:01:38 -0700 (PDT)
Message-ID: <d6ba61ed-7a78-126a-de0d-e3e88c51bbd9@gmail.com>
Date:   Tue, 31 May 2022 22:01:32 +0800
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
References: <6cf820cf-a2e7-c93e-3c00-08bc366f2eb2@gmail.com>
 <20220530073556.1831-1-miles.chen@mediatek.com>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <20220530073556.1831-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Miles

On 2022/5/30 15:35, Miles Chen wrote:
> Hi Miaoqian,
>
>> Hi, Miles
>>
>> On 2022/5/30 10:19, Miles Chen wrote:
>>> Hi Miaoqian,
>>>
>>>>>> 						  &intx_domain_ops, pcie);
>>>>>> 	if (!pcie->intx_domain) {
>>>>>> 		dev_err(dev, "failed to create INTx IRQ domain\n");
>>>>>> +		of_node_put(intc_node);
>>>>>> 		return -ENODEV;
>>>>>> 	}
>>>>> Thanks for doing this.
>>>>>
>>>>> I checked mtk_pcie_init_irq_domains() and there are multiple exit paths like
>>>>> err_msi_domain and err_msi_bottom_domain and the normal path which also
>>>>> need of_node_put(intc_node).
>>>> Thanks for your reply,
>>>>
>>>> I didn't add of_node_put() in other paths because I am not sure if the reference passed through irq_domain_add_linear(), since intc_node is passed to irq_domain_add_linear().
>>>>
>>>> __irq_domain_add() keeps &node->fwnode in the irq_domain structure.
>>>>
>>>> and use fwnode_handle_get() to get the reference of fwnode, but I still uncertain.
>>>>
>>>> If the reference don't needed anymore after irq_domain_add_linear(),
>>>>
>>>> your suggestion looks fine, and I will submit v2.
>>> Thanks for your reply, I think we can do similar things like
>>> rtl8365mb_irq_setup() in drivers/net/dsa/realtek/rtl8365mb.c
>> I checked rtl8365mb_irq_setup(), it calls of_node_put() by goto statement for error paths.
>>
>> and calls of_node_put() before return 0 in normal path. I didn't see the same problem.
> Sorry for the confusing. I meant that we can do the same thing - 
> it calls of_node_put() by goto statement for error paths
> and calls of_node_put() before return 0 in normal path. :-)

I'll sent a v2 for this: https://lore.kernel.org/all/20220530064807.34534-1-linmq006@gmail.com/

following your original suggestion.

> Thanks,
> Miles

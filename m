Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD10537559
	for <lists+linux-pci@lfdr.de>; Mon, 30 May 2022 09:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiE3GyO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 May 2022 02:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiE3GyL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 May 2022 02:54:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F3F694B0;
        Sun, 29 May 2022 23:54:10 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f4so9349973pgf.4;
        Sun, 29 May 2022 23:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iESY+LOtFkT1tRhY+yUwneh6az/zE+XpNPtKwgmfOF0=;
        b=UutOl45RVEUG86jQjCRG5VNZVf97ECO7wiy4dg0Ux8XAp7Y9LOKIdFWMuR3rkQ44A8
         CbAWzPT5cU+9COykCTDzsgadZ2bh9+4yIietOhJrQVcdDRlYt+D8RicmUSfLocBYpEHU
         9qkKF9xNVTbN2M9r34WHOM0k7baVMDvolyRBkCqn5Z6zpRQp10iuqPIL57HmdH2aFdLw
         JSEiZ1TyxyLuqGkH/L8paSBfff2WT4FWoJAPmuqXfa7WGjIiY6ymG0NOe9vl5kSr709K
         +wONuVqxob9BUVttYvmg/bZaKtks3mgJrjsGLMfQCT/mPsfxJaAmUV+GA+Q+sWzlABtG
         M+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iESY+LOtFkT1tRhY+yUwneh6az/zE+XpNPtKwgmfOF0=;
        b=fyq9201rx+Y3WrP9ebhsV3s1KUneByjvdaLAaqT+2e1kFUC5W8mOYRcrQO3FCXFEZB
         CwUim4HD0y5THXMBq56XLhrYTXtzDNGXkKQOQH93Ma06f20MX8odaXjfRbqYtQzTOAMG
         gI9FbvV8P5jgt/HAhSTCBSHqrC6vH0fPlRIa79BamO+n28kWGi+UILN+7fiOeqNJZo27
         kVGFqiwVR5liA/H/0w2Oqk3b2WoMS4lG+nnhuSbJDyTJ/OWQuoyhbxWZbZYvTGeVINFs
         lYIRDlzu2J6eJouqkf8sOXvylnjDx1vsIqr3j1fmGi0U+R6nexhFU5Nz998f3w23smXD
         1sew==
X-Gm-Message-State: AOAM531Vn2zl1HNCVCg1jMV/ig2+8zbiI05G1iFxfi2lDGIl1XMe4LuF
        bt2TAgmUTEvXrypPLRco2jU=
X-Google-Smtp-Source: ABdhPJzZgk01VHqO2Rts4xhDHg9A0sROZcZTZHHDlsl1d2P81YaoOZ34p4dZJkXYNxJI+xOHAsPyPg==
X-Received: by 2002:a63:86c7:0:b0:3fb:efc1:a53e with SMTP id x190-20020a6386c7000000b003fbefc1a53emr6398595pgd.220.1653893649798;
        Sun, 29 May 2022 23:54:09 -0700 (PDT)
Received: from [172.16.4.4] ([219.142.146.208])
        by smtp.gmail.com with ESMTPSA id d24-20020a170902729800b00161ea00350bsm8322920pll.277.2022.05.29.23.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 23:54:09 -0700 (PDT)
Message-ID: <6cf820cf-a2e7-c93e-3c00-08bc366f2eb2@gmail.com>
Date:   Mon, 30 May 2022 14:54:03 +0800
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
References: <bd03ca71-1875-2e94-8040-533034f76ee5@gmail.com>
 <20220530021923.31601-1-miles.chen@mediatek.com>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <20220530021923.31601-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Miles

On 2022/5/30 10:19, Miles Chen wrote:
> Hi Miaoqian,
>
>>>> 						  &intx_domain_ops, pcie);
>>>> 	if (!pcie->intx_domain) {
>>>> 		dev_err(dev, "failed to create INTx IRQ domain\n");
>>>> +		of_node_put(intc_node);
>>>> 		return -ENODEV;
>>>> 	}
>>> Thanks for doing this.
>>>
>>> I checked mtk_pcie_init_irq_domains() and there are multiple exit paths like
>>> err_msi_domain and err_msi_bottom_domain and the normal path which also
>>> need of_node_put(intc_node).
>> Thanks for your reply,
>>
>> I didn't add of_node_put() in other paths because I am not sure if the reference passed through irq_domain_add_linear(), since intc_node is passed to irq_domain_add_linear().
>>
>> __irq_domain_add() keeps &node->fwnode in the irq_domain structure.
>>
>> and use fwnode_handle_get() to get the reference of fwnode, but I still uncertain.
>>
>> If the reference don't needed anymore after irq_domain_add_linear(),
>>
>> your suggestion looks fine, and I will submit v2.
>
> Thanks for your reply, I think we can do similar things like
> rtl8365mb_irq_setup() in drivers/net/dsa/realtek/rtl8365mb.c

I checked rtl8365mb_irq_setup(), it calls of_node_put() by goto statement for error paths.

and calls of_node_put() before return 0 in normal path. I didn't see the same problem.

> Thanks,
> Miles

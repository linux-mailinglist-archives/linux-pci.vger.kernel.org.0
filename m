Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11E3729119
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 09:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbjFIHaS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 03:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238791AbjFIH3x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 03:29:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B37A30D0;
        Fri,  9 Jun 2023 00:29:41 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 25C306606F2A;
        Fri,  9 Jun 2023 08:29:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686295779;
        bh=PRbx+c11bbggGiBNDUqRcT41XRfir2GfxWZ740uanE4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y/M8YLKhHUIk0lyKmOMoE91zv+WLS+IQnS6wispM55ImFEp0zT5UzgR5IbvnTnUhy
         CddTUpyrCVBYfVL0rOuVNXGlMOgWVVMq+QFEtEABVtBYYCzET4nDTmS1FEw72EZ+Mk
         oDBKyS6Ytw8RThDhtyCYJhw7OsTICp7cLQqi72nHqc2ssXvB5z5hsf+OB10c8WgcaI
         0FOPtxX+ZNKv7Uerz9tfRrm4lPokHlzTop0LIUKiqisDyw1eZRfza+Sc/ZhEfli4ay
         5ki+YHL71d9WrP6+WzNxkOsxmdMcuG24srVT36XdSK31SKjbZilRJjGD8da16rf3Cw
         YNxIj97ttJFqw==
Message-ID: <a5597b19-eca8-10b0-1fe4-8f6e1d1d1adf@collabora.com>
Date:   Fri, 9 Jun 2023 09:29:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] PCI: mediatek-gen3: Stop acquiring spinlocks in
 {suspend,resume}_noirq
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230608171507.GA1204894@bhelgaas>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230608171507.GA1204894@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 08/06/23 19:15, Bjorn Helgaas ha scritto:
> On Thu, May 04, 2023 at 01:35:08PM +0200, AngeloGioacchino Del Regno wrote:
>> In mtk_pcie_suspend_noirq() and mtk_pcie_resume_noirq() we are,
>> respectively, disabling and enabling generation of interrupts and
>> then saving and restoring the enabled interrupts register: since
>> we're using noirq PM callbacks, that can be safely done without
>> holding any spin lock.
> 
> Tangent: it's annoying that pcie-mediatek.c and pcie-mediatek-gen3.c
> use identical "mtk_pcie_suspend_noirq()" names.  That makes browsing
> harder than it needs to be.  But I see that you refer to
> mediatek-gen3.
> 
>> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
>> @@ -963,8 +963,6 @@ static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
>>   {
>>   	int i;
>>   
>> -	raw_spin_lock(&pcie->irq_lock);
>> -
>>   	pcie->saved_irq_state = readl_relaxed(pcie->base + PCIE_INT_ENABLE_REG);
>>   
>>   	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
>> @@ -973,16 +971,12 @@ static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
>>   		msi_set->saved_irq_state = readl_relaxed(msi_set->base +
>>   					   PCIE_MSI_SET_ENABLE_OFFSET);
>>   	}
>> -
>> -	raw_spin_unlock(&pcie->irq_lock);
>>   }
> 
> Jianjun added mtk_pcie_irq_save() and mtk_pcie_irq_restore() with
> d537dc125f07 ("PCI: mediatek-gen3: Add system PM support").
> 
> I suggest looking at other drivers and structuring mediatek-gen3
> similarly, including using similar function names.  No other drivers
> have a .*_pcie_irq_save() function.  Several have .*_pcie_host_init(),
> and some of those do include some IRQ setup.
> 
> Bjorn

Hello Bjorn,
thanks for the feedback!

Yes, I of course refer to the Gen3 driver... I'll check other drivers and
will try to improve the consistency of this one with the others as soon as
I have some bandwidth to perform the job.

Thanks again,
Angelo

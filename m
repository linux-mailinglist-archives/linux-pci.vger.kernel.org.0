Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5B86B962F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 14:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjCNN2e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 09:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCNN1x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 09:27:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C926A1DF;
        Tue, 14 Mar 2023 06:25:32 -0700 (PDT)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6C51C660036A;
        Tue, 14 Mar 2023 13:25:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678800330;
        bh=3Q9Wk1fkKtkxc1DaKV294b/HrXukUV6KK5bXqHC2FLQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Yhq4ySgX78GYfKdhwkJ4cf+2fmyAhwykSsKt51YyCkCKw4x2zGEnFzMme38fWlbEQ
         0k+opx9wQfa+7o0Z9w95XUbbOy/1dq8Z1rwY+e47dwsZqKfQpCY8nu+jymSUawLqxP
         ohqk6g9CQmZUY0sW4OSUbTVOzDeJf6ygS3AW32qN6iEN/KmQdznlpC5PdFUjr7k/bD
         D7YYvFn4bzsKAQLD2ETwiLvF/IL78rg+dG93m9ZhWAWnA6aVYbKaM8gNdex5nxnjPh
         DWG+9OKAArr1ikA0myJ6WAaSnO5OuGnXO2L+ZiT9X905vkugTZNbeOtMit77e3EoTF
         IeDkeL3BFYZYw==
Message-ID: <93e4d83d-9559-c987-d93b-c49572413275@collabora.com>
Date:   Tue, 14 Mar 2023 13:25:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/7] irqchip/gic-v3: Add a DMA Non-Coherent flag
To:     Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, kernel@collabora.com
References: <20230310080518.78054-1-lucas.tanure@collabora.com>
 <20230310080518.78054-2-lucas.tanure@collabora.com>
 <CAMdYzYpL7V6udw=T7ZChTFi0xOj1tb-5CVHb84u1pL4kj3eDZA@mail.gmail.com>
 <3db23e11-5fac-f36e-c89e-93c4e8ac2d98@arm.com>
Content-Language: en-US
From:   Lucas Tanure <lucas.tanure@collabora.com>
In-Reply-To: <3db23e11-5fac-f36e-c89e-93c4e8ac2d98@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10-03-2023 12:04, Robin Murphy wrote:
> On 2023-03-10 11:41, Peter Geis wrote:
>> On Fri, Mar 10, 2023 at 3:05 AM Lucas Tanure 
>> <lucas.tanure@collabora.com> wrote:
>>>
>>> The GIC600 integration in RK356x, used in rk3588, doesn't support
>>> any of the shareability or cacheability attributes, and requires
>>> both values to be set to 0b00 for all the ITS and Redistributor
>>> tables.
>>>
>>> This is loosely based on prior work from XiaoDong Huang and
>>> Peter Geis fixing this issue specifically for Rockchip 356x.
>>
>> Good Morning,
>>
>> Since the gic is using dma, would it be reasonable to have all memory
>> allocations be requested with the GFP_DMA flag? Otherwise this doesn't
>> fully solve the problem for rk356x, where only the lower 4GB range is
>> DMA capable, but this tends to get allocated in the upper 4GB on 8GB
>> boards.
> 
> Not really, because there's no fixed definition of what GFP_DMA actually 
> means, and it may mean nothing (same for GFP_DMA32, which may or may not 
> be meaningful depending on kernel config and platform topology). Drivers 
> should really use the DMA API allocation functions if they care about 
> what they get, which comes back round to the notion from years ago of 
> converting the ITS driver to a regular platform driver, so it can 
> benefit from regular DT concepts like "dma-ranges" automatically.
> 
> Thanks,
> Robin.
> 
I am looking how to do that conversion to platform driver.
But about the communication between irq-gic-v3-its and irq-gic-v3.
Should irq-gic-v3-its be a MFD child of irq-gic-v3?
Or use the component bind/unbind framework?

>>
>> Very Respectfully,
>> Peter Geis
>>
>>>
>>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>>> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
>>> ---
>>>   drivers/irqchip/irq-gic-v3-its.c | 22 ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>>> b/drivers/irqchip/irq-gic-v3-its.c
>>> index 973ede0197e3..1c334dfeb647 100644
>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>> @@ -42,6 +42,7 @@
>>>   #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING          (1ULL << 0)
>>>   #define ITS_FLAGS_WORKAROUND_CAVIUM_22375      (1ULL << 1)
>>>   #define ITS_FLAGS_WORKAROUND_CAVIUM_23144      (1ULL << 2)
>>> +#define ITS_FLAGS_DMA_NON_COHERENT             (1ULL << 3)
>>>
>>>   #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING    (1 << 0)
>>>   #define RDIST_FLAGS_RD_TABLES_PREALLOCATED     (1 << 1)
>>> @@ -2359,6 +2360,13 @@ static int its_setup_baser(struct its_node 
>>> *its, struct its_baser *baser,
>>>          its_write_baser(its, baser, val);
>>>          tmp = baser->val;
>>>
>>> +       if (its->flags & ITS_FLAGS_DMA_NON_COHERENT) {
>>> +               if (tmp & GITS_BASER_SHAREABILITY_MASK)
>>> +                       tmp &= ~GITS_BASER_SHAREABILITY_MASK;
>>> +               else
>>> +                       gic_flush_dcache_to_poc(base, 
>>> PAGE_ORDER_TO_SIZE(order));
>>> +       }
>>> +
>>>          if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
>>>                  /*
>>>                   * Shareability didn't stick. Just use
>>> @@ -3055,6 +3063,7 @@ static u64 its_clear_vpend_valid(void __iomem 
>>> *vlpi_base, u64 clr, u64 set)
>>>
>>>   static void its_cpu_init_lpis(void)
>>>   {
>>> +       struct its_node *its = list_first_entry(&its_nodes, struct 
>>> its_node, entry);
>>>          void __iomem *rbase = gic_data_rdist_rd_base();
>>>          struct page *pend_page;
>>>          phys_addr_t paddr;
>>> @@ -3096,6 +3105,9 @@ static void its_cpu_init_lpis(void)
>>>          gicr_write_propbaser(val, rbase + GICR_PROPBASER);
>>>          tmp = gicr_read_propbaser(rbase + GICR_PROPBASER);
>>>
>>> +       if (its->flags & ITS_FLAGS_DMA_NON_COHERENT)
>>> +               tmp &= ~GICR_PROPBASER_SHAREABILITY_MASK;
>>> +
>>>          if ((tmp ^ val) & GICR_PROPBASER_SHAREABILITY_MASK) {
>>>                  if (!(tmp & GICR_PROPBASER_SHAREABILITY_MASK)) {
>>>                          /*
>>> @@ -3120,6 +3132,9 @@ static void its_cpu_init_lpis(void)
>>>          gicr_write_pendbaser(val, rbase + GICR_PENDBASER);
>>>          tmp = gicr_read_pendbaser(rbase + GICR_PENDBASER);
>>>
>>> +       if (its->flags & ITS_FLAGS_DMA_NON_COHERENT)
>>> +               tmp &= ~GICR_PENDBASER_SHAREABILITY_MASK;
>>> +
>>>          if (!(tmp & GICR_PENDBASER_SHAREABILITY_MASK)) {
>>>                  /*
>>>                   * The HW reports non-shareable, we must remove the
>>> @@ -5005,6 +5020,7 @@ static int __init 
>>> its_compute_its_list_map(struct resource *res,
>>>   static int __init its_probe_one(struct resource *res,
>>>                                  struct fwnode_handle *handle, int 
>>> numa_node)
>>>   {
>>> +       struct device_node *np = to_of_node(handle);
>>>          struct its_node *its;
>>>          void __iomem *its_base;
>>>          u64 baser, tmp, typer;
>>> @@ -5076,6 +5092,9 @@ static int __init its_probe_one(struct resource 
>>> *res,
>>>          its->get_msi_base = its_irq_get_msi_base;
>>>          its->msi_domain_flags = IRQ_DOMAIN_FLAG_MSI_REMAP;
>>>
>>> +       if (np && !of_dma_is_coherent(np))
>>> +               its->flags |= ITS_FLAGS_DMA_NON_COHERENT;
>>> +
>>>          its_enable_quirks(its);
>>>
>>>          err = its_alloc_tables(its);
>>> @@ -5095,6 +5114,9 @@ static int __init its_probe_one(struct resource 
>>> *res,
>>>          gits_write_cbaser(baser, its->base + GITS_CBASER);
>>>          tmp = gits_read_cbaser(its->base + GITS_CBASER);
>>>
>>> +       if (its->flags & ITS_FLAGS_DMA_NON_COHERENT)
>>> +               tmp &= ~GITS_CBASER_SHAREABILITY_MASK;
>>> +
>>>          if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
>>>                  if (!(tmp & GITS_CBASER_SHAREABILITY_MASK)) {
>>>                          /*
>>> -- 
>>> 2.39.2
>>>


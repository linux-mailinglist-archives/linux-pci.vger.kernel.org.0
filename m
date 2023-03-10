Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C0F6B3E9F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 13:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCJMEe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 07:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCJMEd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 07:04:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CED9EA014;
        Fri, 10 Mar 2023 04:04:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14FC8C14;
        Fri, 10 Mar 2023 04:05:14 -0800 (PST)
Received: from [10.57.90.67] (unknown [10.57.90.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 647FD3F5A1;
        Fri, 10 Mar 2023 04:04:27 -0800 (PST)
Message-ID: <3db23e11-5fac-f36e-c89e-93c4e8ac2d98@arm.com>
Date:   Fri, 10 Mar 2023 12:04:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/7] irqchip/gic-v3: Add a DMA Non-Coherent flag
Content-Language: en-GB
To:     Peter Geis <pgwipeout@gmail.com>,
        Lucas Tanure <lucas.tanure@collabora.com>
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
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAMdYzYpL7V6udw=T7ZChTFi0xOj1tb-5CVHb84u1pL4kj3eDZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-03-10 11:41, Peter Geis wrote:
> On Fri, Mar 10, 2023 at 3:05 AM Lucas Tanure <lucas.tanure@collabora.com> wrote:
>>
>> The GIC600 integration in RK356x, used in rk3588, doesn't support
>> any of the shareability or cacheability attributes, and requires
>> both values to be set to 0b00 for all the ITS and Redistributor
>> tables.
>>
>> This is loosely based on prior work from XiaoDong Huang and
>> Peter Geis fixing this issue specifically for Rockchip 356x.
> 
> Good Morning,
> 
> Since the gic is using dma, would it be reasonable to have all memory
> allocations be requested with the GFP_DMA flag? Otherwise this doesn't
> fully solve the problem for rk356x, where only the lower 4GB range is
> DMA capable, but this tends to get allocated in the upper 4GB on 8GB
> boards.

Not really, because there's no fixed definition of what GFP_DMA actually 
means, and it may mean nothing (same for GFP_DMA32, which may or may not 
be meaningful depending on kernel config and platform topology). Drivers 
should really use the DMA API allocation functions if they care about 
what they get, which comes back round to the notion from years ago of 
converting the ITS driver to a regular platform driver, so it can 
benefit from regular DT concepts like "dma-ranges" automatically.

Thanks,
Robin.

> 
> Very Respectfully,
> Peter Geis
> 
>>
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 973ede0197e3..1c334dfeb647 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -42,6 +42,7 @@
>>   #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING          (1ULL << 0)
>>   #define ITS_FLAGS_WORKAROUND_CAVIUM_22375      (1ULL << 1)
>>   #define ITS_FLAGS_WORKAROUND_CAVIUM_23144      (1ULL << 2)
>> +#define ITS_FLAGS_DMA_NON_COHERENT             (1ULL << 3)
>>
>>   #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING    (1 << 0)
>>   #define RDIST_FLAGS_RD_TABLES_PREALLOCATED     (1 << 1)
>> @@ -2359,6 +2360,13 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
>>          its_write_baser(its, baser, val);
>>          tmp = baser->val;
>>
>> +       if (its->flags & ITS_FLAGS_DMA_NON_COHERENT) {
>> +               if (tmp & GITS_BASER_SHAREABILITY_MASK)
>> +                       tmp &= ~GITS_BASER_SHAREABILITY_MASK;
>> +               else
>> +                       gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
>> +       }
>> +
>>          if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
>>                  /*
>>                   * Shareability didn't stick. Just use
>> @@ -3055,6 +3063,7 @@ static u64 its_clear_vpend_valid(void __iomem *vlpi_base, u64 clr, u64 set)
>>
>>   static void its_cpu_init_lpis(void)
>>   {
>> +       struct its_node *its = list_first_entry(&its_nodes, struct its_node, entry);
>>          void __iomem *rbase = gic_data_rdist_rd_base();
>>          struct page *pend_page;
>>          phys_addr_t paddr;
>> @@ -3096,6 +3105,9 @@ static void its_cpu_init_lpis(void)
>>          gicr_write_propbaser(val, rbase + GICR_PROPBASER);
>>          tmp = gicr_read_propbaser(rbase + GICR_PROPBASER);
>>
>> +       if (its->flags & ITS_FLAGS_DMA_NON_COHERENT)
>> +               tmp &= ~GICR_PROPBASER_SHAREABILITY_MASK;
>> +
>>          if ((tmp ^ val) & GICR_PROPBASER_SHAREABILITY_MASK) {
>>                  if (!(tmp & GICR_PROPBASER_SHAREABILITY_MASK)) {
>>                          /*
>> @@ -3120,6 +3132,9 @@ static void its_cpu_init_lpis(void)
>>          gicr_write_pendbaser(val, rbase + GICR_PENDBASER);
>>          tmp = gicr_read_pendbaser(rbase + GICR_PENDBASER);
>>
>> +       if (its->flags & ITS_FLAGS_DMA_NON_COHERENT)
>> +               tmp &= ~GICR_PENDBASER_SHAREABILITY_MASK;
>> +
>>          if (!(tmp & GICR_PENDBASER_SHAREABILITY_MASK)) {
>>                  /*
>>                   * The HW reports non-shareable, we must remove the
>> @@ -5005,6 +5020,7 @@ static int __init its_compute_its_list_map(struct resource *res,
>>   static int __init its_probe_one(struct resource *res,
>>                                  struct fwnode_handle *handle, int numa_node)
>>   {
>> +       struct device_node *np = to_of_node(handle);
>>          struct its_node *its;
>>          void __iomem *its_base;
>>          u64 baser, tmp, typer;
>> @@ -5076,6 +5092,9 @@ static int __init its_probe_one(struct resource *res,
>>          its->get_msi_base = its_irq_get_msi_base;
>>          its->msi_domain_flags = IRQ_DOMAIN_FLAG_MSI_REMAP;
>>
>> +       if (np && !of_dma_is_coherent(np))
>> +               its->flags |= ITS_FLAGS_DMA_NON_COHERENT;
>> +
>>          its_enable_quirks(its);
>>
>>          err = its_alloc_tables(its);
>> @@ -5095,6 +5114,9 @@ static int __init its_probe_one(struct resource *res,
>>          gits_write_cbaser(baser, its->base + GITS_CBASER);
>>          tmp = gits_read_cbaser(its->base + GITS_CBASER);
>>
>> +       if (its->flags & ITS_FLAGS_DMA_NON_COHERENT)
>> +               tmp &= ~GITS_CBASER_SHAREABILITY_MASK;
>> +
>>          if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
>>                  if (!(tmp & GITS_CBASER_SHAREABILITY_MASK)) {
>>                          /*
>> --
>> 2.39.2
>>

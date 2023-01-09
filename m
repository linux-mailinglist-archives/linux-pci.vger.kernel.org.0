Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1789D66306F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 20:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbjAITdp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 14:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbjAITdj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 14:33:39 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C027963B3
        for <linux-pci@vger.kernel.org>; Mon,  9 Jan 2023 11:33:37 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id i188so9779806vsi.8
        for <linux-pci@vger.kernel.org>; Mon, 09 Jan 2023 11:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dgdyy1Z+2Ju0e/iq2YUL8oWPCTY8WT7CrnDhBmYlAlE=;
        b=E3McBq2WdP1Lf4LD+7yIgDucHzaT5l4hO5iiIyTjirBB09dOKzWcUrABIWjjy5HOi8
         TjStmVdNG+hIURknB2kZfIpfQ1RB8mFI9a16hq5ND3OUzptGWdFOrdeAqFKGdCKVRG5t
         a+Q4QbONHdWMyN8kxv55XP4czHEmCY4GCWnfKt35Z3BeK+//a07BadJxPaanmF44FL0s
         dDeXj5ZIXBDBaqfA/6j1/i2t6NI4pc6Tn4ScEtWOx0eGCGCcxAsN14gnue+AlXzdzwOd
         /vLoXJMyTjRASVnJYe8nUH797TEoMpWPBEIZdGEK4sbEUHszT9dRq1fL5MVJz974MpgW
         x1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgdyy1Z+2Ju0e/iq2YUL8oWPCTY8WT7CrnDhBmYlAlE=;
        b=gp8M5feOa2oKRGDo685rsNvSI6eWytLTYPw7NIabyXv3C8LeqWk3wPeFmZbJJc1z9i
         FKzG4eLICBYN9HyNKRPDiLytj1gHqo6TqCSyswVaR7Zo47F+ZR17CN4m7k1J9EHiYv2p
         CTD+XeBSpmpjIZeHXEmPO3IB4HpLVskKhzGni7ku6/Bugq2hvPoQknEL4gFRRbZpXQ65
         tCAjjYZaXuXYpBCcMAWXMJe4KUz5wPFxIkThfCNAMhxzn5BQVaVgI1Vp8YwHUPvbEDAh
         KKc/HoD4BTNMQRFjngQA2/tvTnyEdeFuklc4g2/clnMKASQ6c/RvcYHo4CvBsWIp2tnF
         ceag==
X-Gm-Message-State: AFqh2krlZx5+xZA1urtsLeFg3lYUBcusmE9Ke8kbuU56iR0eEsCNDsv+
        tPASPXSvGUzDhthK4U7/wwODeQ==
X-Google-Smtp-Source: AMrXdXuFuCSXBOKrUBc5j0eF98pQltbB0QQo2a8nMINqZlwM06BmUHyjS9S68V/wjOweCJicr48CZw==
X-Received: by 2002:a05:6102:3c8d:b0:3b0:d65c:3d02 with SMTP id c13-20020a0561023c8d00b003b0d65c3d02mr36907265vsv.21.1673292816648;
        Mon, 09 Jan 2023 11:33:36 -0800 (PST)
Received: from [10.230.45.5] ([38.32.73.2])
        by smtp.gmail.com with ESMTPSA id v7-20020a05620a440700b006fb112f512csm5865306qkp.74.2023.01.09.11.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 11:33:36 -0800 (PST)
Message-ID: <7bdef8bb-7a5e-2b5d-35ba-56cefb38d91f@ixsystems.com>
Date:   Mon, 9 Jan 2023 14:33:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 1/2] PCI: Take other bus devices into account when
 distributing resources
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
References: <20230104091635.63331-1-mika.westerberg@linux.intel.com>
 <20230104091635.63331-2-mika.westerberg@linux.intel.com>
From:   Alexander Motin <mav@ixsystems.com>
In-Reply-To: <20230104091635.63331-2-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04.01.2023 04:16, Mika Westerberg wrote:
> A PCI bridge may reside on a bus with other devices as well. The
> resource distribution code does not take this into account properly and
> therefore it expands the bridge resource windows too much, not leaving
> space for the other devices (or functions of a multifunction device) and
> this leads to an issue that Jonathan reported. He runs QEMU with the
> following topology (QEMU parameters):
> 
>   -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2  \
>   -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on \
>   -device e1000,bus=root_port13,addr=0.1                         \
>   -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3    \
>   -device e1000,bus=fun1
> 
> The first e1000 NIC here is another function in the switch upstream
> port. This leads to following errors:
> 
>    pci 0000:00:04.0: bridge window [mem 0x10200000-0x103fffff] to [bus 02-04]
>    pci 0000:02:00.0: bridge window [mem 0x10200000-0x103fffff] to [bus 03-04]
>    pci 0000:02:00.1: BAR 0: failed to assign [mem size 0x00020000]
>    e1000 0000:02:00.1: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
> 
> Fix this by taking into account the device BARs on the bus, including
> the ones belonging to bridges themselves.
> 
> Link: https://lore.kernel.org/linux-pci/20221014124553.0000696f@huawei.com/
> Link: https://lore.kernel.org/linux-pci/6053736d-1923-41e7-def9-7585ce1772d9@ixsystems.com/
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reported-by: Alexander Motin <mav@ixsystems.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>   drivers/pci/setup-bus.c | 205 +++++++++++++++++++++++++---------------
>   1 file changed, 129 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index b4096598dbcb..cf6a7bdf2427 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1750,6 +1750,7 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
>   				 resource_size_t new_size)
>   {
>   	resource_size_t add_size, size = resource_size(res);
> +	resource_size_t min_size;
>   
>   	if (res->parent)
>   		return;
> @@ -1757,30 +1758,87 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
>   	if (!new_size)
>   		return;
>   
> +	/* Minimum granularity of a bridge bridge window */
> +	min_size = window_alignment(bridge->bus, res->flags);
> +
>   	if (new_size > size) {
>   		add_size = new_size - size;
> +		if (add_size < min_size)
> +			return;
>   		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
>   			&add_size);
>   	} else if (new_size < size) {
>   		add_size = size - new_size;
> +		if (add_size < min_size)
> +			return;

May be I don't understand something, but in what situation it may 
happen, and won't it be a problem if you silently do nothing here, while 
the calling code will use the passed new_size as-is?

>   		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
>   			&add_size);
> +	} else {
> +		return;
>   	}
>   
>   	res->end = res->start + new_size - 1;
>   	remove_from_list(add_list, res);
>   }
>   
> +static void reduce_dev_resources(struct pci_dev *dev, struct resource *io,
> +				 struct resource *mmio,
> +				 struct resource *mmio_pref)
> +{
> +	int i;
> +
> +	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +		struct resource *res = &dev->resource[i];
> +		resource_size_t align, tmp, size;
> +
> +		size = resource_size(res);
> +		if (!size)
> +			continue;
> +
> +		align = pci_resource_alignment(dev, res);
> +
> +		if (resource_type(res) == IORESOURCE_IO) {
> +			align = align ? ALIGN(io->start, align) - io->start : 0;
> +			tmp = align + size;
> +			io->start = min(io->start + tmp, io->end + 1);
> +		} else if (resource_type(res) == IORESOURCE_MEM) {
> +			if (res->flags & IORESOURCE_PREFETCH) {
> +				align = align ? ALIGN(mmio_pref->start, align) -
> +						mmio_pref->start : 0;
> +				tmp = align + size;
> +				mmio_pref->start = min(mmio_pref->start + tmp,
> +						       mmio_pref->end + 1);
> +			} else {
> +				align = align ? ALIGN(mmio->start, align) -
> +						mmio->start : 0;
> +				tmp = align + size;
> +				mmio->start = min(mmio->start + tmp,
> +						  mmio->end + 1);
> +			}
> +		}
> +	}
> +}
> +
> +/*
> + * io, mmio and mmio_pref contain the total amount of bridge window
> + * space available. This includes the minimal space needed to cover all
> + * the existing devices on the bus and the possible extra space that can
> + * be shared with the bridges.
> + *
> + * The resource space consumed by bus->self (the bridge) is already
> + * reduced.
> + */
>   static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>   					    struct list_head *add_list,
>   					    struct resource io,
>   					    struct resource mmio,
>   					    struct resource mmio_pref)
>   {
> +	resource_size_t io_align, mmio_align, mmio_pref_align;
> +	resource_size_t io_per_b, mmio_per_b, mmio_pref_per_b;
>   	unsigned int normal_bridges = 0, hotplug_bridges = 0;
>   	struct resource *io_res, *mmio_res, *mmio_pref_res;
>   	struct pci_dev *dev, *bridge = bus->self;
> -	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
>   
>   	io_res = &bridge->resource[PCI_BRIDGE_IO_WINDOW];
>   	mmio_res = &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
> @@ -1790,17 +1848,17 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>   	 * The alignment of this bridge is yet to be considered, hence it must
>   	 * be done now before extending its bridge window.
>   	 */
> -	align = pci_resource_alignment(bridge, io_res);
> -	if (!io_res->parent && align)
> -		io.start = min(ALIGN(io.start, align), io.end + 1);
> +	io_align = pci_resource_alignment(bridge, io_res);
> +	if (!io_res->parent && io_align)
> +		io.start = min(ALIGN(io.start, io_align), io.end + 1);
>   
> -	align = pci_resource_alignment(bridge, mmio_res);
> -	if (!mmio_res->parent && align)
> -		mmio.start = min(ALIGN(mmio.start, align), mmio.end + 1);
> +	mmio_align = pci_resource_alignment(bridge, mmio_res);
> +	if (!mmio_res->parent && mmio_align)
> +		mmio.start = min(ALIGN(mmio.start, mmio_align), mmio.end + 1);
>   
> -	align = pci_resource_alignment(bridge, mmio_pref_res);
> -	if (!mmio_pref_res->parent && align)
> -		mmio_pref.start = min(ALIGN(mmio_pref.start, align),
> +	mmio_pref_align = pci_resource_alignment(bridge, mmio_pref_res);
> +	if (!mmio_pref_res->parent && mmio_pref_align)
> +		mmio_pref.start = min(ALIGN(mmio_pref.start, mmio_pref_align),
>   			mmio_pref.end + 1);
>   
>   	/*
> @@ -1824,94 +1882,89 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>   			normal_bridges++;
>   	}
>   
> -	/*
> -	 * There is only one bridge on the bus so it gets all available
> -	 * resources which it can then distribute to the possible hotplug
> -	 * bridges below.
> -	 */
> -	if (hotplug_bridges + normal_bridges == 1) {
> -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> -		if (dev->subordinate)
> -			pci_bus_distribute_available_resources(dev->subordinate,
> -				add_list, io, mmio, mmio_pref);
> -		return;
> -	}
> -
> -	if (hotplug_bridges == 0)
> +	if (!(hotplug_bridges + normal_bridges))
>   		return;
>   
>   	/*
>   	 * Calculate the total amount of extra resource space we can
> -	 * pass to bridges below this one.  This is basically the
> -	 * extra space reduced by the minimal required space for the
> -	 * non-hotplug bridges.
> +	 * pass to bridges below this one. This is basically the extra
> +	 * space reduced by the minimal required space for the bridge
> +	 * windows and device BARs on this bus.
>   	 */
> -	for_each_pci_bridge(dev, bus) {
> -		resource_size_t used_size;
> -		struct resource *res;
> -
> -		if (dev->is_hotplug_bridge)
> -			continue;
> -
> -		/*
> -		 * Reduce the available resource space by what the
> -		 * bridge and devices below it occupy.
> -		 */
> -		res = &dev->resource[PCI_BRIDGE_IO_WINDOW];
> -		align = pci_resource_alignment(dev, res);
> -		align = align ? ALIGN(io.start, align) - io.start : 0;
> -		used_size = align + resource_size(res);
> -		if (!res->parent)
> -			io.start = min(io.start + used_size, io.end + 1);
> -
> -		res = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
> -		align = pci_resource_alignment(dev, res);
> -		align = align ? ALIGN(mmio.start, align) - mmio.start : 0;
> -		used_size = align + resource_size(res);
> -		if (!res->parent)
> -			mmio.start = min(mmio.start + used_size, mmio.end + 1);
> +	list_for_each_entry(dev, &bus->devices, bus_list)
> +		reduce_dev_resources(dev, &io, &mmio, &mmio_pref);
>   
> -		res = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> -		align = pci_resource_alignment(dev, res);
> -		align = align ? ALIGN(mmio_pref.start, align) -
> -			mmio_pref.start : 0;
> -		used_size = align + resource_size(res);
> -		if (!res->parent)
> -			mmio_pref.start = min(mmio_pref.start + used_size,
> -				mmio_pref.end + 1);
> +	/*
> +	 * If there is at least one hotplug bridge on this bus it gets
> +	 * all the extra resource space that was left after the
> +	 * reductions above.
> +	 *
> +	 * If there are no hotplug bridges the extra resource space is
> +	 * split between non-hotplug bridges. This is to allow possible
> +	 * hotplug bridges below them to get the extra space as well.
> +	 */
> +	if (hotplug_bridges) {
> +		io_per_b = div64_ul(resource_size(&io), hotplug_bridges);
> +		mmio_per_b = div64_ul(resource_size(&mmio), hotplug_bridges);
> +		mmio_pref_per_b = div64_ul(resource_size(&mmio_pref),
> +					   hotplug_bridges);
> +	} else {
> +		io_per_b = div64_ul(resource_size(&io), normal_bridges);
> +		mmio_per_b = div64_ul(resource_size(&mmio), normal_bridges);
> +		mmio_pref_per_b = div64_ul(resource_size(&mmio_pref),
> +					   normal_bridges);
>   	}
>   
> -	io_per_hp = div64_ul(resource_size(&io), hotplug_bridges);
> -	mmio_per_hp = div64_ul(resource_size(&mmio), hotplug_bridges);
> -	mmio_pref_per_hp = div64_ul(resource_size(&mmio_pref),
> -		hotplug_bridges);
> -
>   	/*
> -	 * Go over devices on this bus and distribute the remaining
> -	 * resource space between hotplug bridges.
> +	 * Make sure the split resource space is properly aligned for
> +	 * bridge windows (align it down to avoid going above what is
> +	 * available).
>   	 */
> +	if (io_align)
> +		io_per_b = ALIGN_DOWN(io_per_b, io_align);
> +	if (mmio_align)
> +		mmio_per_b = ALIGN_DOWN(mmio_per_b, mmio_align);
> +	if (mmio_pref_align)
> +		mmio_pref_per_b = ALIGN_DOWN(mmio_pref_per_b, mmio_align);

If I understand it right, you are applying alignment requirements of the 
parent bridge to the windows of its children.  I don't have examples of 
any bridge with different alignment, but shouldn't we better get and use 
proper alignment inside the loop below?

> +
>   	for_each_pci_bridge(dev, bus) {
> +		resource_size_t allocated_io, allocated_mmio, allocated_mmio_pref;
> +		const struct resource *res;
>   		struct pci_bus *b;
>   
>   		b = dev->subordinate;
> -		if (!b || !dev->is_hotplug_bridge)
> +		if (!b)
> +			continue;
> +		if (hotplug_bridges && !dev->is_hotplug_bridge)
>   			continue;
>   
> +		io.end = io.start + io_per_b - 1;
>   		/*
> -		 * Distribute available extra resources equally between
> -		 * hotplug-capable downstream ports taking alignment into
> -		 * account.
> +		 * The x_per_b holds the extra resource space that can
> +		 * be added for each bridge but there is the minimal
> +		 * already reserved as well so adjust x.start down
> +		 * accordingly to cover the whole space.
>   		 */
> -		io.end = io.start + io_per_hp - 1;
> -		mmio.end = mmio.start + mmio_per_hp - 1;
> -		mmio_pref.end = mmio_pref.start + mmio_pref_per_hp - 1;
> +		res = &dev->resource[PCI_BRIDGE_IO_WINDOW];
> +		allocated_io = resource_size(res);
> +		io.start -= allocated_io;
> +
> +		mmio.end = mmio.start + mmio_per_b - 1;
> +		res = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
> +		allocated_mmio = resource_size(res);
> +		mmio.start -= allocated_mmio;
> +
> +		mmio_pref.end = mmio_pref.start + mmio_pref_per_b - 1;
> +		res = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> +		allocated_mmio_pref = resource_size(res);
> +		mmio_pref.start -= allocated_mmio_pref;
>   
>   		pci_bus_distribute_available_resources(b, add_list, io, mmio,
>   						       mmio_pref);
>   
> -		io.start += io_per_hp;
> -		mmio.start += mmio_per_hp;
> -		mmio_pref.start += mmio_pref_per_hp;
> +		io.start += allocated_io + io_per_b;
> +		mmio.start += allocated_mmio + mmio_per_b;
> +		mmio_pref.start += allocated_mmio_pref + mmio_pref_per_b;
>   	}
>   }
>   

-- 
Alexander Motin

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA3E5703C9
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 15:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiGKNFA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 09:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiGKNE4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 09:04:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15112F01C;
        Mon, 11 Jul 2022 06:04:52 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LhPDV1dqczhYyb;
        Mon, 11 Jul 2022 21:02:18 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 21:04:50 +0800
CC:     <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v6] PCI: Make sure the bus bridge powered on when scanning
 bus
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
References: <20220606130003.54603-1-yangyicong@hisilicon.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <f0f5b360-2442-589b-d7d5-8f93a207f509@huawei.com>
Date:   Mon, 11 Jul 2022 21:04:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220606130003.54603-1-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

a gentle ping...will it be considered for this window?

Thanks.

On 2022/6/6 21:00, Yicong Yang wrote:
> A bridge in a non-D0 power state does not forward config accesses to
> its secondary side (PCIe r6.0, sec 5.3.1). Make sure the bridge is
> in D0 while we enumerate devices below it.
> 
> The case can be produced when the bridge is runtime-suspended (either
> in D3hot or D3cold) like below:
> 
> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan
> 
> 0000:80:00.0 is a Root Port and it is runtime-suspended, so the
> configuration space of 0000:81:00.1 is unreachable in rescan
> and the device cannot be enumerated.
> 
> Power up the bridge when scanning the child bus and allow it to
> suspend again by adding pm_runtime_get_sync()/pm_runtime_put()
> in pci_scan_child_bus_extend().
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> Change since v5:
> - Tweak the commit message suggested by Bjorn
> Link: https://lore.kernel.org/linux-pci/20220525141930.GA290827@bhelgaas/
> 
> Change since v4:
> - rephrase the commit suggested by Rafael
> Link: https://lore.kernel.org/lkml/20220422080404.27724-1-yangyicong@hisilicon.com/
> 
> Change since v3:
> - retain the pm_runtime_*() calls in pci_scan_bridge_extend() as Rafael points
>   out that it's necessary when the brigde is in D3cold
> Link: https://lore.kernel.org/linux-pci/20220414123736.34150-1-yangyicong@hisilicon.com/
> 
> Change since v2:
> - just rebase it on v5.18-rc2
> Link: https://lore.kernel.org/linux-pci/1601029386-4928-1-git-send-email-yangyicong@hisilicon.com/
> 
> Change since v1:
> - use an intermediate variable *bridge as suggested
> - remove the pm_runtime_*() calls in pci_scan_bridge_extend()
> Link: https://lore.kernel.org/linux-pci/1596022223-4765-1-git-send-email-yangyicong@hisilicon.com/
> 
>  drivers/pci/probe.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..b108e72b6586 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2859,11 +2859,20 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
>  	unsigned int start = bus->busn_res.start;
>  	unsigned int devfn, fn, cmax, max = start;
> +	struct pci_dev *bridge = bus->self;
>  	struct pci_dev *dev;
>  	int nr_devs;
>  
>  	dev_dbg(&bus->dev, "scanning bus\n");
>  
> +	/*
> +	 * Make sure the bus bridge is powered on, otherwise we may not be
> +	 * able to scan the devices as we may fail to access the configuration
> +	 * space of subordinates.
> +	 */
> +	if (bridge)
> +		pm_runtime_get_sync(&bridge->dev);
> +
>  	/* Go find them, Rover! */
>  	for (devfn = 0; devfn < 256; devfn += 8) {
>  		nr_devs = pci_scan_slot(bus, devfn);
> @@ -2976,6 +2985,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  		}
>  	}
>  
> +	if (bridge)
> +		pm_runtime_put(&bridge->dev);
> +
>  	/*
>  	 * We've scanned the bus and so we know all about what's on
>  	 * the other side of any bridges that may be on this bus plus
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FC251BFAD
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 14:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358748AbiEEMqO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 08:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377588AbiEEMqO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 08:46:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5248A55364;
        Thu,  5 May 2022 05:42:34 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KvCwc1CLKz1JBr3;
        Thu,  5 May 2022 20:40:48 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 20:41:52 +0800
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v5] PCI: Make sure the bus bridge powered on when scanning
 bus
To:     Yicong Yang <yangyicong@hisilicon.com>, <bhelgaas@google.com>,
        <rafael@kernel.org>, <linux-pci@vger.kernel.org>
References: <20220424020710.17589-1-yangyicong@hisilicon.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <39c4793e-836f-0d94-4a0e-b3c76b1a8ce2@huawei.com>
Date:   Thu, 5 May 2022 20:41:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220424020710.17589-1-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Any comment? Is it ok to take this?

Thanks.

On 2022/4/24 10:07, Yicong Yang wrote:
> When the bus bridge is runtime suspended, we'll fail to rescan
> the devices through sysfs as we cannot access the configuration
> space correctly when the bridge is in D3hot.
> It can be reproduced like:
> 
> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan
> 
> 0000:80:00.0 is a Root Port and it is runtime-suspended, so
> 0000:81:00.1 is unreachable after a rescan.
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

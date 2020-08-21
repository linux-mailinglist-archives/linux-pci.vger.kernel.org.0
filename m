Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E62124D1CD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 11:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgHUJyi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 05:54:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10297 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727046AbgHUJyg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Aug 2020 05:54:36 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 63EF62C38079FF1C2D30;
        Fri, 21 Aug 2020 17:54:30 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 21 Aug 2020
 17:54:22 +0800
Subject: Re: [PATCH] PCI: Make sure the bus bridge powered on when scanning
 bus
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <1596022223-4765-1-git-send-email-yangyicong@hisilicon.com>
CC:     <linuxarm@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <97366524-d5dd-6eb2-7abc-871627b20821@hisilicon.com>
Date:   Fri, 21 Aug 2020 17:54:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1596022223-4765-1-git-send-email-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

gentle ping ...

Any comments on this or is it possible to be merged?


On 2020/7/29 19:30, Yicong Yang wrote:
> When the bus bridge is runtime suspended, we'll fail to rescan
> the devices through sysfs as we cannot access the configuration
> space correctly when the bridge is in D3hot.
> It can be reproduced like:
>
> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan
>
> 0000:80:00.0 is root port and is runtime suspended and we cannot
> get 0000:81:00.1 after rescan.
>
> Make bridge powered on when scanning the child bus, by adding
> pm_runtime_get_sync()/pm_runtime_put() in pci_scan_child_bus_extend().
>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/pci/probe.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2f66988..5bb502b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2795,6 +2795,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  
>  	dev_dbg(&bus->dev, "scanning bus\n");
>  
> +	/*
> +	 * Make sure the bus bridge is powered on, otherwise we may not be
> +	 * able to scan the devices as we may fail to access the configuration
> +	 * space of subordinates.
> +	 */
> +	if (bus->self)
> +		pm_runtime_get_sync(&bus->self->dev);
> +
>  	/* Go find them, Rover! */
>  	for (devfn = 0; devfn < 256; devfn += 8) {
>  		nr_devs = pci_scan_slot(bus, devfn);
> @@ -2907,6 +2915,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  		}
>  	}
>  
> +	if (bus->self)
> +		pm_runtime_put(&bus->self->dev);
> +
>  	/*
>  	 * We've scanned the bus and so we know all about what's on
>  	 * the other side of any bridges that may be on this bus plus


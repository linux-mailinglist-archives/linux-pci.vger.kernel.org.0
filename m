Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C3D508D5D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 18:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380612AbiDTQfj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 12:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380542AbiDTQfj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 12:35:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3334477D;
        Wed, 20 Apr 2022 09:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C123061A15;
        Wed, 20 Apr 2022 16:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50B4C385A8;
        Wed, 20 Apr 2022 16:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650472371;
        bh=PKoMbzxs1jAqbWrI4BDBNRwBDYIIy5G49keGciMb3ms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SI4kaMcEMZ6i7oO8ym6ohIaj94G8elOXuhFwyqi0csSsxFdLiSjiwHGBuSh7YWhu+
         8IPhIJyqKqIarfF7RbfUNw3m97l93gho5VSJTTL1zP+0lEHq4s7pUz08hwl+cCHH8L
         elHbECcZTWLjx5cDyrEYVAEu97isMbgChbKgkHJycQT+4gIs73b7fyN28oV1KZSVP5
         priQ7R4mB36C6urAvsZL04DvLZv/AjsDC7ON6mQzoHOQm4ZaWvhd6DW1dx2sTTGFuS
         J9x4ql0ltvdHdlV3btaNj+LxYDm8SdjC9l+hr2Mf7YlfF9Eim05FXPh95Jok2WFmCq
         8yPkj4q4YXdVA==
Date:   Wed, 20 Apr 2022 11:32:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        prime.zeng@huawei.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Make sure the bus bridge powered on when
 scanning bus
Message-ID: <20220420163249.GA1305194@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414123736.34150-1-yangyicong@hisilicon.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, linux-pm, since I'd really like his ack/review]

On Thu, Apr 14, 2022 at 08:37:36PM +0800, Yicong Yang wrote:
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
> A similar issue is met and solved by
> d963f6512e15 ("PCI: Power on bridges before scanning new devices")
> which rescan the devices through /sys/bus/pci/devices/0000:80:00.0/rescan.
> The callstack is like:
> 
> dev_rescan_restore()
>   pci_rescan_bus()
>     pci_scan_bridge_extend()
>       pci_scan_child_bus_extend() /* will wake up the bridge with this patch */
> 
> With this patch the issue is also resolved, so let's remove the calls of
> pm_runtime_*() in pci_scan_bridge_extend().
> 
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> Change since v2:
> - just rebase it on v5.18-rc2
> Link: https://lore.kernel.org/linux-pci/1601029386-4928-1-git-send-email-yangyicong@hisilicon.com/
> 
> Change since v1:
> - use an intermediate variable *bridge as suggested
> - remove the pm_runtime_*() calls in pci_scan_bridge_extend()
> Link: https://lore.kernel.org/linux-pci/1596022223-4765-1-git-send-email-yangyicong@hisilicon.com/
> 
>  drivers/pci/probe.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..2ca6b4b708e3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1257,12 +1257,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  	u8 fixed_sec, fixed_sub;
>  	int next_busnr;
>  
> -	/*
> -	 * Make sure the bridge is powered on to be able to access config
> -	 * space of devices below it.
> -	 */
> -	pm_runtime_get_sync(&dev->dev);
> -
>  	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
>  	primary = buses & 0xFF;
>  	secondary = (buses >> 8) & 0xFF;
> @@ -1464,8 +1458,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  out:
>  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
>  
> -	pm_runtime_put(&dev->dev);
> -
>  	return max;
>  }
>  
> @@ -2859,11 +2851,19 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
>  	unsigned int start = bus->busn_res.start;
>  	unsigned int devfn, fn, cmax, max = start;
> -	struct pci_dev *dev;
> +	struct pci_dev *dev, *bridge = bus->self;
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
> @@ -2976,6 +2976,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  		}
>  	}
>  
> +	if (bridge)
> +		pm_runtime_put(&bridge->dev);
> +
>  	/*
>  	 * We've scanned the bus and so we know all about what's on
>  	 * the other side of any bridges that may be on this bus plus
> -- 
> 2.24.0
> 

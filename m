Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41C85332C0
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 22:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241766AbiEXU6w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 May 2022 16:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241776AbiEXU6t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2022 16:58:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA334AE2D;
        Tue, 24 May 2022 13:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 954D2CE1D57;
        Tue, 24 May 2022 20:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DA6C34100;
        Tue, 24 May 2022 20:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653425925;
        bh=co8rmso/X/9KSryJdR6dHk17tc5T5WiA0FcvA4bAgWo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qxov/uCEnvuyYCwQB6yKH37c+PrG3ORg97DLE/3mRnqtSs68wwRDShxraD4nkZDqw
         GEpL/5SYaiSzFvdam6vNCn0EI9qAIOwDlSyf2Op4PwxznHdshGcNEuKD5FemBcT3sx
         qzZO8Ho4rnWPtv4STbswUgAkqFLr75SNrKEsPfwnLT++mqyAbrOThenAdUEOZaGu6l
         EqlegieAVBuyv94I8FuakXb2EuB0YgHwuJIrtwWE5JYDKklbxzB8bHbj7A3ims7SAk
         VMy/K3PQ4WG4icmqgOx9vqPzhIrUGmxkC8CFg/5EOmWqkq7xGpcStMq8V4YGElcFM/
         lybtYoq5kHB/w==
Date:   Tue, 24 May 2022 15:58:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RESEND PATCH v5] PCI: Make sure the bus bridge powered on when
 scanning bus
Message-ID: <20220524205842.GA269611@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517124319.47125-1-yangyicong@hisilicon.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 17, 2022 at 08:43:19PM +0800, Yicong Yang wrote:
> When the bus bridge is runtime suspended, we'll fail to rescan
> the devices through sysfs as we cannot access the configuration
> space correctly when the bridge is in D3hot.

Is the "D3hot" above a typo?  I think devices are supposed to respond
to config accesses when in D3hot.  PCIe r6.0, sec 5.3.1.4.1:

  Configuration and Message requests are the only TLPs accepted by a
  Function in the D3Hot state. ...

  Functions that are in D3Hot are permitted to be transitioned by
  software (writing to their PMCSR PowerState field) to the D0active
  state or the D0uninitialized state. Functions that are in D3Hot must
  respond to Configuration Space accesses as long as power and clock
  are supplied so that they can be returned to D0 by software.

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
> -- 
> 2.24.0
> 

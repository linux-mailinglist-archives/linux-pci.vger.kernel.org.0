Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC344F9FB4
	for <lists+linux-pci@lfdr.de>; Sat,  9 Apr 2022 00:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiDHWrX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 18:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiDHWrW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 18:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73737114B;
        Fri,  8 Apr 2022 15:45:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1777362100;
        Fri,  8 Apr 2022 22:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C72C385A3;
        Fri,  8 Apr 2022 22:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649457916;
        bh=RY4LlTaIHI+Gt4S1FZe8//DTJqSqTADK8QF8Y/5p1M0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HeQg39pUKAiyD/yzmF/QklSoTW72IMlo/n6VcxsTdY2N/naNNXbbNb0Xqi0BBA9xj
         sZ6fPa96E9Z2ar4ReajWZHpwKAwmVz6tKtas8CtIQkcFAZoHvBwJ/1gclKcySeU3ze
         3i/KGY7HGom8/x6Gj4qWRRsONvbF0LnhM8ZqLEENzRad+ebnQtkPYa915EGSwQiK/T
         kKvigZs/5foY4bI1st6UDXJGROOQrG9E9QpjSFh8Rqr8xlO1aSYuLQWBnpa8ljyF+0
         8tNo+TZwGcnciYyIqprZnzp6TmE7qNjT9XC9BhCkHBBMPoYv4B99PGWKcqoLhBd5oS
         h5Da3HWycuTiA==
Date:   Fri, 8 Apr 2022 17:45:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] PCI: Extend isolated function probing to s390
Message-ID: <20220408224514.GA353445@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404095346.2324666-1-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 04, 2022 at 11:53:45AM +0200, Niklas Schnelle wrote:
> Like the jailhouse hypervisor s390's PCI architecture allows passing
> isolated PCI functions to an OS instance. As of now this is was not
> utilized even with multi-function support as the s390 PCI code makes
> sure that only virtual PCI busses including a function with devfn 0 are
> presented to the PCI subsystem. A subsequent change will remove this
> restriction.
> 
> Allow probing such functions by replacing the existing check for
> jailhouse_paravirt() with a new hypervisor_isolated_pci_functions()
> helper.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

I'm OK with the idea of generalizing this Jailhouse test, but I wonder
if this check should be in pci_scan_slot() rather than in
pci_scan_child_bus_extend().

I think the idea is that pci_scan_slot() should find all the functions
of a device (a.k.a. "slot"), so it's a little weird to have a loop
calling pci_scan_single_device() for each function in both places.

Currently we never call pcie_aspm_init_link_state() for these
Jailhouse or s390 functions.  Maybe that's OK (and I think
pci_scan_slot() is the wrong place to initialize ASPM anyway) but if
we could move the Jailhouse/s390 checking to pci_scan_slot(), it would
at least remove the inconsistency.

I'm thinking something along the lines of the patch below.  I'm sure
Jan considered this originally, so maybe there's some reason this
won't work.

Bjorn

> ---
>  drivers/pci/probe.c        | 4 ++--
>  include/linux/hypervisor.h | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..e8fd89a1f984 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2869,11 +2869,11 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  		nr_devs = pci_scan_slot(bus, devfn);
>  
>  		/*
> -		 * The Jailhouse hypervisor may pass individual functions of a
> +		 * Some hypervisors may pass individual functions of a
>  		 * multi-function device to a guest without passing function 0.
>  		 * Look for them as well.
>  		 */
> -		if (jailhouse_paravirt() && nr_devs == 0) {
> +		if (hypervisor_isolated_pci_functions() && nr_devs == 0) {
>  			for (fn = 1; fn < 8; fn++) {
>  				dev = pci_scan_single_device(bus, devfn + fn);
>  				if (dev)
> diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
> index fc08b433c856..52abd459f9a3 100644
> --- a/include/linux/hypervisor.h
> +++ b/include/linux/hypervisor.h
> @@ -32,4 +32,13 @@ static inline bool jailhouse_paravirt(void)
>  
>  #endif /* !CONFIG_X86 */
>  
> +static inline bool hypervisor_isolated_pci_functions(void)
> +{
> +	if (IS_ENABLED(CONFIG_S390))
> +		return true;
> +	else
> +		return jailhouse_paravirt();
> +}
> +
> +
>  #endif /* __LINUX_HYPEVISOR_H */
> -- 
> 2.32.0
> 


diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..83e4885e0698 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2650,9 +2650,9 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 		return 0; /* Already scanned the entire slot */
 
 	dev = pci_scan_single_device(bus, devfn);
-	if (!dev)
+	if (!dev && !jailhouse_paravirt())
 		return 0;
-	if (!pci_dev_is_added(dev))
+	if (dev && !pci_dev_is_added(dev))
 		nr++;
 
 	for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn)) {
@@ -2858,30 +2858,16 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 {
 	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
 	unsigned int start = bus->busn_res.start;
-	unsigned int devfn, fn, cmax, max = start;
+	unsigned int devfn, cmax, max = start;
 	struct pci_dev *dev;
 	int nr_devs;
 
 	dev_dbg(&bus->dev, "scanning bus\n");
 
 	/* Go find them, Rover! */
-	for (devfn = 0; devfn < 256; devfn += 8) {
+	for (devfn = 0; devfn < 256; devfn += 8)
 		nr_devs = pci_scan_slot(bus, devfn);
 
-		/*
-		 * The Jailhouse hypervisor may pass individual functions of a
-		 * multi-function device to a guest without passing function 0.
-		 * Look for them as well.
-		 */
-		if (jailhouse_paravirt() && nr_devs == 0) {
-			for (fn = 1; fn < 8; fn++) {
-				dev = pci_scan_single_device(bus, devfn + fn);
-				if (dev)
-					dev->multifunction = 1;
-			}
-		}
-	}
-
 	/* Reserve buses for SR-IOV capability */
 	used_buses = pci_iov_bus_range(bus);
 	max += used_buses;

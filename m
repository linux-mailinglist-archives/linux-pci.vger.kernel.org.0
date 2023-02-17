Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F7A69B65E
	for <lists+linux-pci@lfdr.de>; Sat, 18 Feb 2023 00:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjBQXQ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Feb 2023 18:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjBQXQ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2023 18:16:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEA95CF05;
        Fri, 17 Feb 2023 15:16:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C237E62069;
        Fri, 17 Feb 2023 23:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC243C433EF;
        Fri, 17 Feb 2023 23:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676675705;
        bh=byNkcvjTVrhZmBQeXX4eg96uidFMAt9CRXf+/5g7jmQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i+dyYMQfaZaIV1MSPjeoxGW7/kGQRsELGc6+eH9/pJisN5GlHWOxZZPufsniv9a+h
         SaiV5XBOW9vK3H/4EVKj1zPWhj/6NKB/VuHcwAjN8s2sX104jq0qFaPFrMsHJQjaOn
         fbfY6eT4mFHBMHVzLgiNg9wE31Lm/EwJ8g2+z3rmzrkoz3ekzacrtXeJPpiayEXz2e
         bZrsU76D0onPaH2jplLx0EYxpit5zoYjBq9lbMywIoWoek6l45GLyx+c7rJLkJfWFl
         dGMuY8AcvGZJFgtBF45/ngSv0Wbg8r3/Ic5/ihzngga605no7167hQSzqc67fDkVbL
         HSjLs31GxqUww==
Date:   Fri, 17 Feb 2023 17:15:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: s390: Fix use-after-free of PCI bus
 resources with s390 per-function hotplug
Message-ID: <20230217231503.GA3425666@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214094911.3776032-1-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 14, 2023 at 10:49:10AM +0100, Niklas Schnelle wrote:
> On s390 PCI functions may be hotplugged individually even when they
> belong to a multi-function device. In particular on an SR-IOV device VFs
> may be removed and later re-added.

Is there something special about the SR-IOV/VF case that relates to
this problem?  If not, it might be unnecessary distraction to mention
it.

> In commit a50297cf8235 ("s390/pci: separate zbus creation from
> scanning") it was missed however that struct pci_bus and struct
> zpci_bus's resource list retained a reference to the PCI functions MMIO
> resources even though those resources are released and freed on
> hot-unplug. These stale resources may subsequently be claimed when the
> PCI function re-appears resulting in use-after-free.

Lifetimes of all these resources definitely aren't obvious to me.

So I guess the critical thing here is the new
pci_bus_remove_resource() in zpci_cleanup_bus_resources(), which
removes (and kfrees when necessary) the resource from
pci_bus->resources.

I'm not clear on where the zpci_bus resource list comes in.  I guess
we kalloc resources in zpci_setup_bus_resources(), and the current
code adds them to zpci_bus->resources and copies them onto the pci_bus
list.

The new code does not add them to zpci_bus->resources at all, and only
adds them to the pci_bus resource list.  Right?  I guess maybe that's
what the "no need to add the MMIO resources at all" below refers to?

> One idea of fixing this use-after-free in s390 specific code that was
> investigated was to simply keep resources around from the moment a PCI
> function first appeared until the whole virtual PCI bus created for
> a multi-function device disappears. The problem with this however is
> that due to the requirement of artificial MMIO addreesses (address
> cookies) we will then need extra logic and tracking in struct zpci_bus
> to keep these compatible for re-use. At the same time the MMIO resources
> semantically belong to the PCI function so tying their lifecycle to the
> function seems more logical.
> 
> Instead a simpler approach is to remove the resources of an individually
> hot-unplugged PCI function from the PCI bus's resource list while
> keeping the resources of other PCI functions on the PCI bus untouched.

Do we currently never kfree the pci_bus resource list until we free
the whole pci_bus via release_pcibus_dev()?  Does a remove + add just
allocate more resources that are probably duplicates of what the
pci_bus already had?

> This is done by introducing pci_bus_remove_resource() to remove an
> individual resource. Similarly the resource also needs to be removed
> from the struct zpci_bus's resource list. It turns out however, that
> there is really no need to add the MMIO resources at all and instead we
> can simply use the zpci_bar_struct's resource pointer directly.
> 
> Fixes: a50297cf8235 ("s390/pci: separate zbus creation from scanning")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Other random questions unrelated to this patch:

  - zpci_bus_create_pci_bus() calls pci_bus_add_devices().  Isn't that
    pointless?  AFAICT, the bus->devices list is empty then.

  - What about zpci_bus_scan_device()?  Why does it call both
    pci_bus_add_device() and pci_bus_add_devices()?  The latter will
    just call the former, so it looks redundant.  And the latter is
    locked but not the former?

  - Struct zpci_bus has a "resources" list.  I guess this contains the
    &zbus->bus_resource put there in zpci_bus_alloc(), plus an entry
    for every BAR of every device on the bus (I guess you'd never see
    an actual PCI-to-PCI bridge on s390?), kalloc'ed in
    zpci_setup_bus_resources()?

    What happens when zpci_bus_release() calls
    pci_free_resource_list() on &zbus->resources?  It looks like that
    ultimately calls kfree(), which is OK for the
    zpci_setup_bus_resources() stuff, but what about the
    zbus->bus_resource that was not kalloc'ed?

> ---
>  arch/s390/pci/pci.c     | 16 ++++++++++------
>  arch/s390/pci/pci_bus.c | 12 +++++-------
>  arch/s390/pci/pci_bus.h |  3 +--
>  drivers/pci/bus.c       | 23 +++++++++++++++++++++++
>  include/linux/pci.h     |  1 +
>  5 files changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index ef38b1514c77..e16afacc8fd1 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -544,8 +544,7 @@ static struct resource *__alloc_res(struct zpci_dev *zdev, unsigned long start,
>  	return r;
>  }
>  
> -int zpci_setup_bus_resources(struct zpci_dev *zdev,
> -			     struct list_head *resources)
> +int zpci_setup_bus_resources(struct zpci_dev *zdev)
>  {
>  	unsigned long addr, size, flags;
>  	struct resource *res;
> @@ -581,7 +580,6 @@ int zpci_setup_bus_resources(struct zpci_dev *zdev,
>  			return -ENOMEM;
>  		}
>  		zdev->bars[i].res = res;
> -		pci_add_resource(resources, res);
>  	}
>  	zdev->has_resources = 1;
>  
> @@ -590,17 +588,23 @@ int zpci_setup_bus_resources(struct zpci_dev *zdev,
>  
>  static void zpci_cleanup_bus_resources(struct zpci_dev *zdev)
>  {
> +	struct resource *res;
>  	int i;
>  
> +	pci_lock_rescan_remove();

What exactly is this protecting?  This doesn't seem like quite the
right place since we're not adding/removing a pci_dev here.  Is this
to protect the bus->resources list in pci_bus_remove_resource()?

>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		if (!zdev->bars[i].size || !zdev->bars[i].res)
> +		res = zdev->bars[i].res;
> +		if (!res)
>  			continue;
>  
> +		release_resource(res);
> +		pci_bus_remove_resource(zdev->zbus->bus, res);
>  		zpci_free_iomap(zdev, zdev->bars[i].map_idx);
> -		release_resource(zdev->bars[i].res);
> -		kfree(zdev->bars[i].res);
> +		zdev->bars[i].res = NULL;
> +		kfree(res);
>  	}
>  	zdev->has_resources = 0;
> +	pci_unlock_rescan_remove();
>  }
>  
>  int pcibios_device_add(struct pci_dev *pdev)
> diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> index 6a8da1b742ae..a99926af2b69 100644
> --- a/arch/s390/pci/pci_bus.c
> +++ b/arch/s390/pci/pci_bus.c
> @@ -41,9 +41,7 @@ static int zpci_nb_devices;
>   */
>  static int zpci_bus_prepare_device(struct zpci_dev *zdev)
>  {
> -	struct resource_entry *window, *n;
> -	struct resource *res;
> -	int rc;
> +	int rc, i;
>  
>  	if (!zdev_enabled(zdev)) {
>  		rc = zpci_enable_device(zdev);
> @@ -57,10 +55,10 @@ static int zpci_bus_prepare_device(struct zpci_dev *zdev)
>  	}
>  
>  	if (!zdev->has_resources) {
> -		zpci_setup_bus_resources(zdev, &zdev->zbus->resources);
> -		resource_list_for_each_entry_safe(window, n, &zdev->zbus->resources) {
> -			res = window->res;
> -			pci_bus_add_resource(zdev->zbus->bus, res, 0);
> +		zpci_setup_bus_resources(zdev);
> +		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +			if (zdev->bars[i].res)
> +				pci_bus_add_resource(zdev->zbus->bus, zdev->bars[i].res, 0);
>  		}
>  	}
>  
> diff --git a/arch/s390/pci/pci_bus.h b/arch/s390/pci/pci_bus.h
> index e96c9860e064..af9f0ac79a1b 100644
> --- a/arch/s390/pci/pci_bus.h
> +++ b/arch/s390/pci/pci_bus.h
> @@ -30,8 +30,7 @@ static inline void zpci_zdev_get(struct zpci_dev *zdev)
>  
>  int zpci_alloc_domain(int domain);
>  void zpci_free_domain(int domain);
> -int zpci_setup_bus_resources(struct zpci_dev *zdev,
> -			     struct list_head *resources);
> +int zpci_setup_bus_resources(struct zpci_dev *zdev);
>  
>  static inline struct zpci_dev *zdev_from_bus(struct pci_bus *bus,
>  					     unsigned int devfn)
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 83ae838ceb5f..f021f1d4af9f 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -76,6 +76,29 @@ struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n)
>  }
>  EXPORT_SYMBOL_GPL(pci_bus_resource_n);
>  
> +void pci_bus_remove_resource(struct pci_bus *bus, struct resource *res)
> +{
> +	struct pci_bus_resource *bus_res, *tmp;
> +	int i;
> +
> +	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
> +		if (bus->resource[i] == res) {
> +			bus->resource[i] = NULL;
> +			return;
> +		}
> +	}
> +
> +	list_for_each_entry_safe(bus_res, tmp, &bus->resources, list) {
> +		if (bus_res->res == res) {
> +			list_del(&bus_res->list);
> +			kfree(bus_res);
> +			return;
> +		}
> +	}
> +	return;
> +

Superfluous "return" and blank line.

> +}
> +
>  void pci_bus_remove_resources(struct pci_bus *bus)
>  {
>  	int i;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index adffd65e84b4..3b1974e2ec73 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1436,6 +1436,7 @@ void pci_bus_add_resource(struct pci_bus *bus, struct resource *res,
>  			  unsigned int flags);
>  struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n);
>  void pci_bus_remove_resources(struct pci_bus *bus);
> +void pci_bus_remove_resource(struct pci_bus *bus, struct resource *res);
>  int devm_request_pci_bus_resources(struct device *dev,
>  				   struct list_head *resources);
>  
> -- 
> 2.37.2
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84059B9AE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 08:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiHVGj5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 02:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiHVGj4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 02:39:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F80167C7;
        Sun, 21 Aug 2022 23:39:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD378B80E63;
        Mon, 22 Aug 2022 06:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE80C433D6;
        Mon, 22 Aug 2022 06:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661150392;
        bh=FYeeln7MD1PMWNGLgC9aTBjMD/5cUjyXE6S27TWGNnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SNErhu1LiQo2e9M0QXmu6A/YbAbTfTHsSXW63Gi9G1c/B4dq0J6tKFX37a0pQ3WA9
         5efCU0Ec0B3Sjfe7sdfVpPV/Lb2G8l98glxO3M0JOAmU0g8KIAjOsVJlrwNil/wIil
         TCIvjOdLoeatesFLqqu9i6+YFNKctrR3wadIrwVY=
Date:   Mon, 22 Aug 2022 08:39:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Allow drivers to request exclusive config
 regions
Message-ID: <YwMktMqN0oFgCeZn@kroah.com>
References: <20220822005237.540039-1-ira.weiny@intel.com>
 <20220822005237.540039-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822005237.540039-2-ira.weiny@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 21, 2022 at 08:52:36PM -0400, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> PCI config space access from user space has traditionally been
> unrestricted with writes being an understood risk for device operation.
> 
> Unfortunately, device breakage or odd behavior from config writes lacks
> indicators that can leave driver writers confused when evaluating
> failures.  This is especially true with the new PCIe Data Object
> Exchange (DOE) mailbox protocol where backdoor shenanigans from user
> space through things such as vendor defined protocols may affect device
> operation without complete breakage.

What userspace tools are out there messing with PCI config space through
userspace on these devices today?  How is this the kernel's fault if
someone runs such a thing?

> A prior proposal restricted read and writes completely.[1]  Greg and
> Bjorn pointed out that proposal is flawed for a couple of reasons.
> First, lspci should always be allowed and should not interfere with any
> device operation.  Second, setpci is a valuable tool that is sometimes
> necessary and it should not be completely restricted.[2]  Finally
> methods exist for full lock of device access if required.
> 
> Even though access should not be restricted it would be nice for driver
> writers to be able to flag critical parts of the config space such that
> interference from user space can be detected.
> 
> Introduce pci_request_config_region_exclusive() to mark exclusive config
> regions.  Such regions trigger a warning and kernel taint if accessed
> via user space.
> 
> [1] https://lore.kernel.org/all/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/
> [2] https://lore.kernel.org/all/YF8NGeGv9vYcMfTV@kroah.com/
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from[1]:
> 	Change name to pci_request_config_region_exclusive()
> 	Don't flag reads at all.
> 	Allow writes with a warn and taint of the kernel.
> 	Update commit message
> 	Forward port to latest tree.
> ---
>  drivers/pci/pci-sysfs.c |  6 ++++++
>  drivers/pci/probe.c     |  6 ++++++
>  include/linux/ioport.h  |  2 ++
>  include/linux/pci.h     | 16 ++++++++++++++++
>  kernel/resource.c       | 13 ++++++++-----
>  5 files changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index fc804e08e3cb..de41d761bdf5 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -755,6 +755,12 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
>  	if (ret)
>  		return ret;
>  
> +	if (resource_is_exclusive(&dev->config_resource, off,
> +				  count)) {
> +		pci_warn(dev, "Write to restricted range %llx detected", off);

Will this allow any user to spam the kernel log from userspace?  You
might want to rate-limit it, right?

> +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +	}
> +
>  	if (off > dev->cfg_size)
>  		return 0;
>  	if (off + count > dev->cfg_size) {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6280e780a48c..d81d7457058b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2303,6 +2303,12 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>  	INIT_LIST_HEAD(&dev->bus_list);
>  	dev->dev.type = &pci_dev_type;
>  	dev->bus = pci_bus_get(bus);
> +	dev->config_resource = (struct resource) {
> +		.name = "PCI Config",
> +		.start = 0,
> +		.end = -1,
> +	};
> +
>  #ifdef CONFIG_PCI_MSI
>  	raw_spin_lock_init(&dev->msi_lock);
>  #endif
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 616b683563a9..cf1de55d14da 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -312,6 +312,8 @@ extern void __devm_release_region(struct device *dev, struct resource *parent,
>  				  resource_size_t start, resource_size_t n);
>  extern int iomem_map_sanity_check(resource_size_t addr, unsigned long size);
>  extern bool iomem_is_exclusive(u64 addr);
> +extern bool resource_is_exclusive(struct resource *resource, u64 addr,
> +				  resource_size_t size);
>  
>  extern int
>  walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 81a57b498f22..dde37bfa0ca5 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -409,6 +409,7 @@ struct pci_dev {
>  	 */
>  	unsigned int	irq;
>  	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
> +	struct resource config_resource;		 /* driver exclusive config ranges */

So the driver only gets 1 range to mark this way?

What are the ranges for typical devices that have this problem?

This still feels very odd to me, how far do we have to go to protect
userspace from doing bad things on systems when they have the
permissions and access to do those bad things?

What are you trying to protect yourself from, bogus bug reports by
people doing bad things and then blaming you?  That's easy to handle,
just ignore them :)

thanks,

greg k-h

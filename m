Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7BD5ECC6D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 20:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiI0Svx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 14:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiI0Svv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 14:51:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E4AF960C;
        Tue, 27 Sep 2022 11:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0D7AB81D46;
        Tue, 27 Sep 2022 18:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189ADC433B5;
        Tue, 27 Sep 2022 18:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664304705;
        bh=wvIRpCei9UAW/m7e7nDOK0fCjU9adRHG1qDyFRvCdkU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mWYqmPcEr7H8CBlLGbK+TdJQVLLKRkk5j3rPDDebkPv7sp/OxJZinj3E1dJsEDRT6
         dEFQVtYBi1nsBnUDq5/uIghATPWWeBE9Lgcgx/dt1D6xxJUBjYzVyl8893Ma+dwR6R
         UqCXCBVdszv3g+ZjbARtojnljoFxj3N7T4GRUhB+g46aeDGHc6crxcJhG31s4e6zED
         YTp3Q1AOLuuXhHjl8/6tTneM77ViB9mqEgbOWkzeGYq4uwlD8nc37xA8GNBmHLLukS
         Dk73jCHeRErQKnSJ9/DUMjjEdy1QH2f38FJQNuoK99de5I7v/0JI/JE6uISNEFtOau
         QgsAouTp7jpJQ==
Date:   Tue, 27 Sep 2022 13:51:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V3 1/2] PCI: Allow drivers to request exclusive config
 regions
Message-ID: <20220927185143.GA1721047@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926215711.2893286-2-ira.weiny@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 02:57:10PM -0700, ira.weiny@intel.com wrote:
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
> 
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
> Create pci_warn_once() to restrict the user from spamming the log.
> 
> [1] https://lore.kernel.org/all/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/
> [2] https://lore.kernel.org/all/YF8NGeGv9vYcMfTV@kroah.com/
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> 
> ---
> Changes from V2:
> 	Greg: s/config_resource/driver_exclusive_resource/
> 	Jonathan: don't reformat the pci_*() messages
> 
> Changes from V1:
> 	Greg and Dan:
> 		Create and use pci_warn_once() to keep the user from spamming
> 	Dan:
> 		Clarify the warn message
> 
> Changes from[1]:
> 	Change name to pci_request_config_region_exclusive()
> 	Don't flag reads at all.
> 	Allow writes with a warn and taint of the kernel.
> 	Update commit message
> 	Forward port to latest tree.
> ---
>  drivers/pci/pci-sysfs.c |  7 +++++++
>  drivers/pci/probe.c     |  6 ++++++
>  include/linux/ioport.h  |  2 ++
>  include/linux/pci.h     | 17 +++++++++++++++++
>  kernel/resource.c       | 13 ++++++++-----
>  5 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index fc804e08e3cb..7354e135e646 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -755,6 +755,13 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
>  	if (ret)
>  		return ret;
>  
> +	if (resource_is_exclusive(&dev->driver_exclusive_resource, off,
> +				  count)) {
> +		pci_warn_once(dev, "%s: Unexpected write to kernel-exclusive config offset %llx",
> +			      current->comm, off);
> +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +	}
> +
>  	if (off > dev->cfg_size)
>  		return 0;
>  	if (off + count > dev->cfg_size) {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index c5286b027f00..e16ce452cc1e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2306,6 +2306,12 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>  	INIT_LIST_HEAD(&dev->bus_list);
>  	dev->dev.type = &pci_dev_type;
>  	dev->bus = pci_bus_get(bus);
> +	dev->driver_exclusive_resource = (struct resource) {
> +		.name = "PCI Exclusive",
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
> index 060af91bafcd..d75347114307 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -409,6 +409,7 @@ struct pci_dev {
>  	 */
>  	unsigned int	irq;
>  	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
> +	struct resource driver_exclusive_resource;	 /* driver exclusive resource ranges */
>  
>  	bool		match_driver;		/* Skip attaching driver */
>  
> @@ -1406,6 +1407,21 @@ int pci_request_selected_regions(struct pci_dev *, int, const char *);
>  int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
>  void pci_release_selected_regions(struct pci_dev *, int);
>  
> +static inline __must_check struct resource *
> +pci_request_config_region_exclusive(struct pci_dev *pdev, unsigned int offset,
> +				    unsigned int len, const char *name)
> +{
> +	return __request_region(&pdev->driver_exclusive_resource, offset, len,
> +				name, IORESOURCE_EXCLUSIVE);
> +}
> +
> +static inline void pci_release_config_region(struct pci_dev *pdev,
> +					     unsigned int offset,
> +					     unsigned int len)
> +{
> +	__release_region(&pdev->driver_exclusive_resource, offset, len);
> +}
> +
>  /* drivers/pci/bus.c */
>  void pci_add_resource(struct list_head *resources, struct resource *res);
>  void pci_add_resource_offset(struct list_head *resources, struct resource *res,
> @@ -2481,6 +2497,7 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
>  #define pci_crit(pdev, fmt, arg...)	dev_crit(&(pdev)->dev, fmt, ##arg)
>  #define pci_err(pdev, fmt, arg...)	dev_err(&(pdev)->dev, fmt, ##arg)
>  #define pci_warn(pdev, fmt, arg...)	dev_warn(&(pdev)->dev, fmt, ##arg)
> +#define pci_warn_once(pdev, fmt, arg...) dev_warn_once(&(pdev)->dev, fmt, ##arg)
>  #define pci_notice(pdev, fmt, arg...)	dev_notice(&(pdev)->dev, fmt, ##arg)
>  #define pci_info(pdev, fmt, arg...)	dev_info(&(pdev)->dev, fmt, ##arg)
>  #define pci_dbg(pdev, fmt, arg...)	dev_dbg(&(pdev)->dev, fmt, ##arg)
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 4c5e80b92f2f..82ed54cd1f0d 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1707,18 +1707,15 @@ static int strict_iomem_checks;
>   *
>   * Returns true if exclusive to the kernel, otherwise returns false.
>   */
> -bool iomem_is_exclusive(u64 addr)
> +bool resource_is_exclusive(struct resource *root, u64 addr, resource_size_t size)
>  {
>  	const unsigned int exclusive_system_ram = IORESOURCE_SYSTEM_RAM |
>  						  IORESOURCE_EXCLUSIVE;
>  	bool skip_children = false, err = false;
> -	int size = PAGE_SIZE;
>  	struct resource *p;
>  
> -	addr = addr & PAGE_MASK;
> -
>  	read_lock(&resource_lock);
> -	for_each_resource(&iomem_resource, p, skip_children) {
> +	for_each_resource(root, p, skip_children) {
>  		if (p->start >= addr + size)
>  			break;
>  		if (p->end < addr) {
> @@ -1757,6 +1754,12 @@ bool iomem_is_exclusive(u64 addr)
>  	return err;
>  }
>  
> +bool iomem_is_exclusive(u64 addr)
> +{
> +	return resource_is_exclusive(&iomem_resource, addr & PAGE_MASK,
> +				     PAGE_SIZE);
> +}
> +
>  struct resource_entry *resource_list_create_entry(struct resource *res,
>  						  size_t extra_size)
>  {
> -- 
> 2.37.2
> 

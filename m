Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFEC7D001D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 18:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjJSQ6l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 12:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbjJSQ6e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 12:58:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC81218A;
        Thu, 19 Oct 2023 09:58:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D55FC433C7;
        Thu, 19 Oct 2023 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697734711;
        bh=QugkIlOHBfXektMHRvIJe+wO60NTqX/NU/UNS74VBI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jov/sh88htAadIO7EEItuISUc1wvppFjGe+mybyr0YeZIrEiTPyUvjjQAJYII+8ZD
         23JftL5enMHdUBp/t0lUsP4rGbF+QUFz5C3TNtRMHhj3OFoLeAzG3/lcTBcxSP6Hks
         L3ER4ydxuyFAQ/jFLNfLLZcYTmdk56R76kudEbSsQiNtL/Mn9ew8hEtFTDHA4Ci37J
         rN3mxPJixPAk0gh3ihV3MTxiqL4LDp4ZzPuAOsmV9V4LMo7lauJbW0Ab1KNbXF68iO
         gnHeDxOHw1XES5XhA4Z1FfxhKF3S1ELt0G62lYvFaqeJ5xXWQyY0stnoTdpc7PKRmz
         qikj1DEkzZfgA==
Date:   Thu, 19 Oct 2023 11:58:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v9 2/3] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20231019165829.GA1381099@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013034158.2745127-2-alistair.francis@wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 13, 2023 at 01:41:57PM +1000, Alistair Francis wrote:
> The PCIe 6 specification added support for the Data Object Exchange (DOE).
> When DOE is supported the DOE Discovery Feature must be implemented per
> PCIe r6.1 sec 6.30.1.1. The protocol allows a requester to obtain
> information about the other DOE features supported by the device.
> ...

> +static umode_t pci_doe_sysfs_attr_is_visible(struct kobject *kobj,
> +					     struct attribute *a, int n)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index, j;
> +	void *entry;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		xa_for_each(&doe_mb->feats, j, entry)
> +			return a->mode;
> +	}
> +
> +	return 0;

The nested loops that don't test anything look a little weird and
maybe I'm missing something, but this looks like it returns a->mode if
any mailbox with a feature exists, and 0 otherwise.

Is that the same as this:

  if (pdev->doe_mbs)
    return a->mode;

  return 0;

since it sounds like a mailbox must support at least one feature?

> +}
> +
> +static struct attribute *pci_dev_doe_feature_attrs[] = {
> +	NULL,
> +};
> +
> +const struct attribute_group pci_dev_doe_feature_group = {
> +	.name	= "doe_features",
> +	.attrs	= pci_dev_doe_feature_attrs,
> +	.is_visible = pci_doe_sysfs_attr_is_visible,
> +};
> +
> +static ssize_t pci_doe_sysfs_feature_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", attr->attr.name);
> +}
> +
> +static void pci_doe_sysfs_feature_remove(struct pci_dev *pdev,
> +					 struct pci_doe_mb *doe_mb)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_attribute *attrs = doe_mb->sysfs_attrs;
> +	unsigned long i;
> +	void *entry;
> +
> +	if (!attrs)
> +		return;
> +
> +	doe_mb->sysfs_attrs = NULL;
> +	xa_for_each(&doe_mb->feats, i, entry) {
> +		if (attrs[i].show)
> +			sysfs_remove_file_from_group(&dev->kobj, &attrs[i].attr,
> +						     pci_dev_doe_feature_group.name);
> +		kfree(attrs[i].attr.name);
> +	}
> +	kfree(attrs);
> +}
> +
> +static int pci_doe_sysfs_feature_populate(struct pci_dev *pdev,
> +					  struct pci_doe_mb *doe_mb)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_attribute *attrs;
> +	unsigned long num_features = 0;
> +	unsigned long vid, type;
> +	unsigned long i;
> +	void *entry;
> +	int ret;
> +
> +	xa_for_each(&doe_mb->feats, i, entry)
> +		num_features++;
> +
> +	attrs = kcalloc(num_features, sizeof(*attrs), GFP_KERNEL);
> +	if (!attrs)
> +		return -ENOMEM;
> +
> +	doe_mb->sysfs_attrs = attrs;
> +	xa_for_each(&doe_mb->feats, i, entry) {
> +		sysfs_attr_init(&attrs[i].attr);
> +		vid = xa_to_value(entry) >> 8;
> +		type = xa_to_value(entry) & 0xFF;
> +		attrs[i].attr.name = kasprintf(GFP_KERNEL,
> +					       "0x%04lX:%02lX", vid, type);

What's the rationale for using "0x" on the vendor ID but not on the
type?  "0x1234:10" hints that the "10" might be decimal since it lacks
"0x".

Suggest lower-case "%04lx:%02lx" either way.

FWIW, there's no "0x" prefix on the hex vendor IDs in "lspci -n"
output and dmesg messages like this:

  pci 0000:01:00.0: [10de:13b6] type 00

> +		if (!attrs[i].attr.name) {
> +			ret = -ENOMEM;
> +			goto fail;
> +		}
> +
> +		attrs[i].attr.mode = 0444;
> +		attrs[i].show = pci_doe_sysfs_feature_show;
> +
> +		ret = sysfs_add_file_to_group(&dev->kobj, &attrs[i].attr,
> +					      pci_dev_doe_feature_group.name);
> +		if (ret) {
> +			attrs[i].show = NULL;
> +			goto fail;
> +		}
> +	}
> +
> +	return 0;
> +
> +fail:
> +	pci_doe_sysfs_feature_remove(pdev, doe_mb);
> +	return ret;

Not sure we should treat this failure this seriously.  Looks like it
will prevent creation of the BAR resource files, and possibly even
abort pci_sysfs_init() early.  I think the pci_dev will still be
usable (lacking DOE sysfs) even if this fails.

> +}
> +
> +void pci_doe_sysfs_teardown(struct pci_dev *pdev)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		pci_doe_sysfs_feature_remove(pdev, doe_mb);
> +	}
> +}
> +
> +int pci_doe_sysfs_init(struct pci_dev *pdev)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +	int ret;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		ret = pci_doe_sysfs_feature_populate(pdev, doe_mb);
> +		if (ret)
> +			return ret;
> +	}

I agree with Lukas that pci_create_resource_files() is not the right
place to call this.

I try hard to avoid calling *anything* from the
pci_create_sysfs_dev_files() path because it has the nasty
"sysfs_initialized" check and the associated pci_sysfs_init()
initcall.

It's so much cleaner when we can set up static attributes that are
automatically added in the device_add() path.  I don't know whether
that's possible.  I see lots of discussion with Greg KH that might be
related, but I'm not sure.

I do know that we enumerate the mailboxes and features during
pci_init_capabilities(), which happens before device_add(), so the
information about which attributes should be present is at least
*available* early enough:

  pci_host_probe
    pci_scan_root_bus_bridge
      ...
        pci_scan_single_device
          pci_device_add
            pci_init_capabilities
              pci_doe_init
                while (pci_find_next_ext_capability(PCI_EXT_CAP_ID_DOE))
                  pci_doe_create_mb
                    pci_doe_cache_features
                      pci_doe_discovery
                      xa_insert(&doe_mb->feats)   <--
            device_add
              device_add_attrs
                device_add_groups
    pci_bus_add_devices
      pci_bus_add_device
        pci_create_sysfs_dev_files
          ...
            pci_doe_sysfs_init                    <--
              xa_for_each(&pdev->doe_mbs)
                pci_doe_sysfs_feature_populate
                  xa_for_each(&doe_mb->feats)
                    sysfs_add_file_to_group(pci_dev_doe_feature_group.name)

Is it feasible to build an attribute group in pci_doe_init() and add
it to dev->groups so device_add() will automatically add them?

It looks like __power_supply_register() does something like that:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/power/supply/power_supply_core.c?id=v6.5#n1375

> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -22,4 +22,6 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
>  	    const void *request, size_t request_sz,
>  	    void *response, size_t response_sz);
>  
> +int pci_doe_sysfs_init(struct pci_dev *pci_dev);
> +void pci_doe_sysfs_teardown(struct pci_dev *pdev);

These declarations look like they should be in drivers/pci/pci.h as
well.  I don't think anything outside the PCI core should need these.

Bjorn

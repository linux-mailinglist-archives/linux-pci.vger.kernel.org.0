Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADACF673A3D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 14:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjASNbN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 08:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjASNbM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 08:31:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A5A78AA9;
        Thu, 19 Jan 2023 05:31:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A83C4614F3;
        Thu, 19 Jan 2023 13:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A76C433F1;
        Thu, 19 Jan 2023 13:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674135070;
        bh=1C5iBDotVEYXC8xrZFFlV/8PeXsdnhrKITxBNvrg7l8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hw5UOJgmJ12jZ3+KHLwR2OvPoMfVSFPrCLGBzKlYCbMrI+nIVssocfQuhbOpK9inf
         c6rbiiLIC3U2zOuKdZl5rH/Ud3sam8Rlb1yQ5f7bJph/kqf5dcA8hrfOu/bxnq/qnh
         NaS3pb8RcTPFuUpA+KbVuLqNU0TiDCN9qMbICsAk=
Date:   Thu, 19 Jan 2023 14:31:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-fpga@vger.kernel.org, lukas@wunner.de, kabel@kernel.org,
        mani@kernel.org, pali@kernel.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, jgg@ziepe.ca,
        ira.weiny@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, keescook@chromium.org, rafael@kernel.org,
        russell.h.weight@intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        lee@kernel.org, matthew.gerlach@linux.intel.com
Subject: Re: [PATCH v1 01/12] PCI: hotplug: add new callbacks on
 hotplug_slot_ops
Message-ID: <Y8lGG39I0By5d5wh@kroah.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
 <20230119013602.607466-2-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230119013602.607466-2-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 18, 2023 at 08:35:51PM -0500, Tianfei Zhang wrote:
> To reprogram an PCIe-based FPGA card, a new image is
> burned into FLASH on the card and then the card BMC is
> triggered to reboot the card and load the new image.
> 
> Two new operation callbacks are defined in hotplug_slot_ops
> to trigger the reprogramming of an FPGA-based PCIe card:
> 
>   - available_images: Optional: available FPGA images
>   - image_load: Optional: trigger the FPGA to load a new image
> 
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/hotplug/pci_hotplug_core.c | 88 ++++++++++++++++++++++++++
>  include/linux/pci_hotplug.h            |  5 ++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
> index 058d5937d8a9..2b14b6513a03 100644
> --- a/drivers/pci/hotplug/pci_hotplug_core.c
> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
> @@ -231,6 +231,52 @@ static struct pci_slot_attribute hotplug_slot_attr_test = {
>  	.store = test_write_file
>  };
>  
> +static ssize_t available_images_read_file(struct pci_slot *pci_slot, char *buf)
> +{
> +	struct hotplug_slot *slot = pci_slot->hotplug;
> +	ssize_t count = 0;
> +
> +	if (!try_module_get(slot->owner))
> +		return -ENODEV;
> +
> +	if (slot->ops->available_images(slot, buf))
> +		count = slot->ops->available_images(slot, buf);
> +
> +	module_put(slot->owner);
> +
> +	return count;
> +}
> +
> +static struct pci_slot_attribute hotplug_slot_attr_available_images = {
> +	.attr = { .name = "available_images", .mode = 0444 },
> +	.show = available_images_read_file,

If you name things properly, you can use the correct macros and not have
to open-code any of this :(

> +static ssize_t image_load_write_file(struct pci_slot *pci_slot,
> +				     const char *buf, size_t count)
> +{
> +	struct hotplug_slot *slot = pci_slot->hotplug;
> +	int retval = 0;
> +
> +	if (!try_module_get(slot->owner))
> +		return -ENODEV;
> +
> +	if (slot->ops->image_load)
> +		retval = slot->ops->image_load(slot, buf);
> +
> +	module_put(slot->owner);
> +
> +	if (retval)
> +		return retval;
> +
> +	return count;
> +}
> +
> +static struct pci_slot_attribute hotplug_slot_attr_image_load = {
> +	.attr = { .name = "image_load", .mode = 0644 },
> +	.store = image_load_write_file,

Same here, don't open-code this.

> +};
> +
>  static bool has_power_file(struct pci_slot *pci_slot)
>  {
>  	struct hotplug_slot *slot = pci_slot->hotplug;
> @@ -289,6 +335,20 @@ static bool has_test_file(struct pci_slot *pci_slot)
>  	return false;
>  }
>  
> +static bool has_available_images_file(struct pci_slot *pci_slot)
> +{
> +	struct hotplug_slot *slot = pci_slot->hotplug;
> +
> +	return slot && slot->ops && slot->ops->available_images;
> +}
> +
> +static bool has_image_load_file(struct pci_slot *pci_slot)
> +{
> +	struct hotplug_slot *slot = pci_slot->hotplug;
> +
> +	return slot && slot->ops && slot->ops->image_load;
> +}
> +
>  static int fs_add_slot(struct pci_slot *pci_slot)
>  {
>  	int retval = 0;
> @@ -331,8 +391,30 @@ static int fs_add_slot(struct pci_slot *pci_slot)
>  			goto exit_test;
>  	}
>  
> +	if (has_available_images_file(pci_slot)) {
> +		retval = sysfs_create_file(&pci_slot->kobj,
> +					   &hotplug_slot_attr_available_images.attr);
> +		if (retval)
> +			goto exit_available_images;
> +	}
> +
> +	if (has_image_load_file(pci_slot)) {
> +		retval = sysfs_create_file(&pci_slot->kobj,
> +					   &hotplug_slot_attr_image_load.attr);
> +		if (retval)
> +			goto exit_image_load;
> +	}
> +
>  	goto exit;
>  
> +exit_image_load:
> +	if (has_adapter_file(pci_slot))
> +		sysfs_remove_file(&pci_slot->kobj,
> +				  &hotplug_slot_attr_available_images.attr);
> +exit_available_images:
> +	if (has_adapter_file(pci_slot))
> +		sysfs_remove_file(&pci_slot->kobj,
> +				  &hotplug_slot_attr_test.attr);
>  exit_test:
>  	if (has_adapter_file(pci_slot))
>  		sysfs_remove_file(&pci_slot->kobj,
> @@ -372,6 +454,12 @@ static void fs_remove_slot(struct pci_slot *pci_slot)
>  	if (has_test_file(pci_slot))
>  		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_test.attr);
>  
> +	if (has_available_images_file(pci_slot))
> +		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_available_images.attr);
> +
> +	if (has_image_load_file(pci_slot))
> +		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_image_load.attr);
> +

Ick no, please just make this an attribute group that properly shows or
does not show, the attribute when created.  Do not manually add
individual sysfs files.

Yes, I know the existing code does this, so it's not really your fault,
but let's not persist in making this code even messier.  Convert to a
group first and then your new files will be added automagically without
having to care about anything here at all.

thanks,

greg k-h

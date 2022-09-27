Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E25ED154
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 01:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiI0X60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 19:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiI0X6Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 19:58:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3268EB0882
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 16:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6B6BB81E57
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 23:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EA8C433C1;
        Tue, 27 Sep 2022 23:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664323101;
        bh=fCBtFd/p72vyqH22o4m1T+dFq4GzarF+6+SlZv1MLQA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jApjyK6oogKIwf53t6ELqrO9cyxdkC2+rjh6i21JHCp24zy6I9v1EnLkcAPniR1Fu
         snn9ZBn1ZU9DPEQU2yWFUvN9JWN/eFrOBdVxXmH8e/wQrorug29f8EPidPFzcitm/C
         Lt8v4iImJ9b2E4tEp/Sql4mRdctwbKt2wJujbGx7dDbhmSpchdlQrvWdUmfclxIWL+
         sxWcnJKCEcd3IAkaaVs/lZvzfDrNUW2SA6mp7kokTGMwrF7kMjbL9uqHyMpy3ERgM/
         WlYkxgBSrp5D93pM3Qk4EkhQD3IXRUuZZIIl4XCDFSBBKHPDUkY0l8SNFPcuKUdAb7
         tm5wLboRy8BYA==
Date:   Tue, 27 Sep 2022 18:58:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        bhelgaas@google.com
Subject: Re: [PATCH v2] PCI: Expose PCIe Resizable BAR support via sysfs
Message-ID: <20220927235819.GA1753306@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <166336088796.3597940.14973499936692558556.stgit@omen>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 16, 2022 at 02:44:48PM -0600, Alex Williamson wrote:
> This proposes a simple sysfs interface to Resizable BAR support,
> largely for the purposes of assigning such devices to a VM through
> VFIO.  Resizable BARs present a difficult feature to expose to a VM
> through emulation, as resizing a BAR is done on the host.  It can
> fail, and often does, but we have no means via emulation of a PCIe
> REBAR capability to handle the error cases.
> 
> A vfio-pci specific ioctl interface is also cumbersome as there are
> often multiple devices within the same bridge aperture and handling
> them is a challenge.  In the interface proposed here, expanding a
> BAR potentially requires such devices to be soft-removed during the
> resize operation and rescanned after, in order for all the necessary
> resources to be released.  A pci-sysfs interface is also more
> universal than a vfio specific interface.
> 
> Please see the ABI documentation update for usage.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Krzysztof Wilczyński <kw@linux.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied with Christian's Reviewed-by to pci/rebar for v6.1, thanks,
Alex!

> ---
> 
> v2:
>  - Convert to static attributes with is_visible callback
>  - Include aperture driver removal for console drivers
>  - Remove and recreate resourceN attributes
>  - Expand ABI description
>  - Drop 2nd field in show attribute
> 
>  Documentation/ABI/testing/sysfs-bus-pci |   33 +++++++++
>  drivers/pci/pci-sysfs.c                 |  108 +++++++++++++++++++++++++++++++
>  2 files changed, 141 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 6fc2c2efe8ab..ba9a5482436f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -457,3 +457,36 @@ Description:
>  
>  		The file is writable if the PF is bound to a driver that
>  		implements ->sriov_set_msix_vec_count().
> +
> +What:		/sys/bus/pci/devices/.../resourceN_resize
> +Date:		September 2022
> +Contact:	Alex Williamson <alex.williamson@redhat.com>
> +Description:
> +		These files provide an interface to PCIe Resizable BAR support.
> +		A file is created for each BAR resource (N) supported by the
> +		PCIe Resizable BAR extended capability of the device.  Reading
> +		each file exposes the bitmap of available resources sizes:
> +
> +		# cat resource1_resize
> +		00000000000001c0
> +
> +		The bitmap represents supported resources sizes for the BAR,
> +		where bit0 = 1MB, bit1 = 2MB, bit2 = 4MB, etc.  In the above
> +		example the devices supports 64MB, 128MB, and 256MB BAR sizes.
> +
> +		When writing the file, the user provides the bit position of
> +		the desired resource size, for example:
> +
> +		# echo 7 > resource1_resize
> +
> +		This indicates to set the size value corresponding to bit 7,
> +		128MB.  The resulting size is 2 ^ (bit# + 20).  This definition
> +		matches the PCIe specification of this capability.
> +
> +		In order to make use of resouce resizing, all PCI drivers must
> +		be unbound from the device and peer devices under the same
> +		parent bridge may need to be soft removed.  In the case of
> +		VGA devices, writing a resize value will remove low level
> +		console drivers from the device.  Raw users of pci-sysfs
> +		resourceN attributes must be terminated prior to resizing.
> +		Success of the resizing operation is not a guaranteed.
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 9ac92e6a2397..f0298a8b08d9 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -28,6 +28,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/msi.h>
>  #include <linux/of.h>
> +#include <linux/aperture.h>
>  #include "pci.h"
>  
>  static int sysfs_initialized;	/* = 0 */
> @@ -1379,6 +1380,112 @@ static const struct attribute_group pci_dev_reset_attr_group = {
>  	.is_visible = pci_dev_reset_attr_is_visible,
>  };
>  
> +#define pci_dev_resource_resize_attr(n)					\
> +static ssize_t resource##n##_resize_show(struct device *dev,		\
> +					 struct device_attribute *attr,	\
> +					 char * buf)			\
> +{									\
> +	struct pci_dev *pdev = to_pci_dev(dev);				\
> +	ssize_t ret;							\
> +									\
> +	pci_config_pm_runtime_get(pdev);				\
> +									\
> +	ret = sysfs_emit(buf, "%016llx\n",				\
> +			 (u64)pci_rebar_get_possible_sizes(pdev, n));	\
> +									\
> +	pci_config_pm_runtime_put(pdev);				\
> +									\
> +	return ret;							\
> +}									\
> +									\
> +static ssize_t resource##n##_resize_store(struct device *dev,		\
> +					  struct device_attribute *attr,\
> +					  const char *buf, size_t count)\
> +{									\
> +	struct pci_dev *pdev = to_pci_dev(dev);				\
> +	unsigned long size, flags;					\
> +	int ret, i;							\
> +	u16 cmd;							\
> +									\
> +	if (kstrtoul(buf, 0, &size) < 0)				\
> +		return -EINVAL;						\
> +									\
> +	device_lock(dev);						\
> +	if (dev->driver) {						\
> +		ret = -EBUSY;						\
> +		goto unlock;						\
> +	}								\
> +									\
> +	pci_config_pm_runtime_get(pdev);				\
> +									\
> +	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA) {		\
> +		ret = aperture_remove_conflicting_pci_devices(pdev,	\
> +						"resourceN_resize");	\
> +		if (ret)						\
> +			goto pm_put;					\
> +	}								\
> +									\
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);			\
> +	pci_write_config_word(pdev, PCI_COMMAND,			\
> +			      cmd & ~PCI_COMMAND_MEMORY);		\
> +									\
> +	flags = pci_resource_flags(pdev, n);				\
> +									\
> +	pci_remove_resource_files(pdev);				\
> +									\
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {			\
> +		if (pci_resource_len(pdev, i) &&			\
> +		    pci_resource_flags(pdev, i) == flags)		\
> +			pci_release_resource(pdev, i);			\
> +	}								\
> +									\
> +	ret = pci_resize_resource(pdev, n, size);			\
> +									\
> +	pci_assign_unassigned_bus_resources(pdev->bus);			\
> +									\
> +	if (pci_create_resource_files(pdev))				\
> +		pci_warn(pdev, "Failed to recreate resource files after BAR resizing\n");\
> +									\
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);			\
> +pm_put:									\
> +	pci_config_pm_runtime_put(pdev);				\
> +unlock:									\
> +	device_unlock(dev);						\
> +									\
> +	return ret ? ret : count;					\
> +}									\
> +static DEVICE_ATTR_RW(resource##n##_resize)
> +
> +pci_dev_resource_resize_attr(0);
> +pci_dev_resource_resize_attr(1);
> +pci_dev_resource_resize_attr(2);
> +pci_dev_resource_resize_attr(3);
> +pci_dev_resource_resize_attr(4);
> +pci_dev_resource_resize_attr(5);
> +
> +static struct attribute *resource_resize_attrs[] = {
> +	&dev_attr_resource0_resize.attr,
> +	&dev_attr_resource1_resize.attr,
> +	&dev_attr_resource2_resize.attr,
> +	&dev_attr_resource3_resize.attr,
> +	&dev_attr_resource4_resize.attr,
> +	&dev_attr_resource5_resize.attr,
> +	NULL,
> +};
> +
> +static umode_t resource_resize_is_visible(struct kobject *kobj,
> +					  struct attribute *a, int n)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +
> +	return pci_rebar_get_current_size(pdev, n) < 0 ? 0 : a->mode;
> +}
> +
> +static const struct attribute_group pci_dev_resource_resize_group = {
> +	.attrs = resource_resize_attrs,
> +	.is_visible = resource_resize_is_visible,
> +};
> +
>  int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
>  {
>  	if (!sysfs_initialized)
> @@ -1500,6 +1607,7 @@ const struct attribute_group *pci_dev_groups[] = {
>  #ifdef CONFIG_ACPI
>  	&pci_dev_acpi_attr_group,
>  #endif
> +	&pci_dev_resource_resize_group,
>  	NULL,
>  };
>  
> 
> 

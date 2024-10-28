Return-Path: <linux-pci+bounces-15497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB039B3D32
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 22:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DD69B228A7
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 21:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87BF1E1338;
	Mon, 28 Oct 2024 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIT6NBc8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941DD1E0DA7
	for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152209; cv=none; b=mfR3bqWsSdhr30u1qXUhpzv/BHAEMniNEjI4auFw1s0fbnFng2vK89otaDs4112CvjYvottQYIGv+Z8D0xRJcFjkCDfPxlU75RtE55GeJ4ZcLluDVn37zXl0wVOS3BpFUSDMWvjMlRp+R77i4+RBEoP8VR+iEKfi9eozmdJxYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152209; c=relaxed/simple;
	bh=UgLtVPiDhZj25vMRNESVS0ZVOdavlT6ItmK858muKAY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dPhSJjBIEbqExcrHigryFi5m7guC8nMwuAx2QPBjL4XCYJ4czMW4m/LPgdDSkjWOjYxY+8o5Y9KWrhTWcA8o6WfoTsFwocV1HBtdIjsaO+GqXaIDE6IjrQSvxlUylTREHfI/92OB7Uf8vWqbBN0WarbRlCPCA5F4HToIQ/L2aIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIT6NBc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01077C4CEE4;
	Mon, 28 Oct 2024 21:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152209;
	bh=UgLtVPiDhZj25vMRNESVS0ZVOdavlT6ItmK858muKAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UIT6NBc850y9LgEccv6NqlTFIQUoBvrFZd9fFeH1z25elJqtYdVNQlUcto0jOx91i
	 5DAjwdJe4nj5G+QIzRRddHBURBt6MAYGyyuwWtYTTwcLyvWP6MzsHhPMK6OnsQbN/z
	 29nQKMSaw0SYXBSAe+GQCJyZX7TCgVeTBzzDoBOHyBhwNNxv2YOJF8gZmFIFQ5kZAy
	 aJZWg6yrStVVkA03I7r3g8VxpEs+JtpN8jo1Fx+V0yUEGeBCl9YsNkiaxtOt3cOAdA
	 3/QyNlaos7MozKbzl7WI6BjMmT6HD0hdbfBfuOddDbknQmk4S+d0JcfYffVF41ES0f
	 JpuZ33b9LdcAQ==
Date: Mon, 28 Oct 2024 16:50:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: Re: [RFC PATCH v1 2/3] PCI: vmd: Add VMD PCH rootbus support
Message-ID: <20241028215007.GA1119652@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025150153.983306-3-szymon.durawa@linux.intel.com>

On Fri, Oct 25, 2024 at 05:01:52PM +0200, Szymon Durawa wrote:
> Starting from Intel Arrow Lake VMD enhacement introduces separate
> rotbus for PCH. It means that all 3 MMIO BARs exposed by VMD are

enhancement
root bus

Does VMD still have only 3 MMIO BARs?  VMD_RES_PCH_* suggests more
BARs.

> shared now between CPU IOC and PCH. This patch adds PCH bus
> enumeration and MMIO management for devices with VMD enhancement
> support.

s/This patch adds/Add/

We already had bus enumeration and MMIO management.

It'd be nice to have something specific about what changes with PCH.
A different fixed root bus number?  Multiple root buses?  Additional
BARs in the VMD endpoint?

If possible, describe this in generic PCIe topology terms, not in
Intel-speak (IOC, PCH, etc).

> +#define VMD_PRIMARY_PCH_BUS 0x80
> +#define VMD_BUSRANGE0 0xC8
> +#define VMD_BUSRANGE1 0xCC
> +#define VMD_MEMBAR1_OFFSET 0xD0
> +#define VMD_MEMBAR2_OFFSET1 0xD8
> +#define VMD_MEMBAR2_OFFSET2 0xDC

This file (mostly) uses lower-case hex; match that style.

> +#define VMD_BUS_END(busr) ((busr >> 8) & 0xff)
> +#define VMD_BUS_START(busr) (busr & 0x00ff)
> +
>  #define MB2_SHADOW_OFFSET	0x2000
>  #define MB2_SHADOW_SIZE		16
>  
> @@ -38,11 +47,15 @@ enum vmd_resource {
>  	VMD_RES_CFGBAR = 0,
>  	VMD_RES_MBAR_1, /*VMD Resource MemBAR 1 */
>  	VMD_RES_MBAR_2, /*VMD Resource MemBAR 2 */
> +	VMD_RES_PCH_CFGBAR,
> +	VMD_RES_PCH_MBAR_1, /*VMD Resource PCH MemBAR 1 */
> +	VMD_RES_PCH_MBAR_2, /*VMD Resource PCH MemBAR 2 */

Space after "/*".

> +static inline u8 vmd_has_pch_rootbus(struct vmd_dev *vmd)
> +{
> +	return vmd->busn_start[VMD_BUS_1] != 0;

Seems a little weird to learn this by testing whether this kzalloc'ed
field has been set.  Could easily save the driver_data pointer or just
the "features" value in struct vmd_dev.

> +		case 3:
> +			if (!(features & VMD_FEAT_HAS_PCH_ROOTBUS)) {
> +				pci_err(dev, "VMD Bus Restriction detected type %d, but PCH Rootbus is not supported, aborting.\n",
> +					BUS_RESTRICT_CFG(reg));
> +				return -ENODEV;
> +			}
> +
> +			/* IOC start bus */
> +			vmd->busn_start[VMD_BUS_0] = 224;
> +			/* PCH start bus */
> +			vmd->busn_start[VMD_BUS_1] = 225;

Seems like these magic numbers could have #defines.  I see we've been
using 128 and 224 already, and this basically adds 225.

> +static int vmd_create_pch_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
> +			      resource_size_t *offset)
> +{
> +	LIST_HEAD(resources_pch);
> +
> +	pci_add_resource(&resources_pch, &vmd->resources[VMD_RES_PCH_CFGBAR]);
> +	pci_add_resource_offset(&resources_pch,
> +				&vmd->resources[VMD_RES_PCH_MBAR_1], offset[0]);
> +	pci_add_resource_offset(&resources_pch,
> +				&vmd->resources[VMD_RES_PCH_MBAR_2], offset[1]);
> +
> +	vmd->bus[VMD_BUS_1] = pci_create_root_bus(&vmd->dev->dev,
> +						  vmd->busn_start[VMD_BUS_1],
> +						  &vmd_ops, sd, &resources_pch);
> +
> +	if (!vmd->bus[VMD_BUS_1]) {
> +		pci_free_resource_list(&resources_pch);
> +		pci_stop_root_bus(vmd->bus[VMD_BUS_1]);
> +		pci_remove_root_bus(vmd->bus[VMD_BUS_1]);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * primary bus is not set by pci_create_root_bus(), it is updated here
> +	 */
> +	vmd->bus[VMD_BUS_1]->primary = VMD_PRIMARY_PCH_BUS;
> +
> +	vmd_copy_host_bridge_flags(
> +		pci_find_host_bridge(vmd->dev->bus),
> +		to_pci_host_bridge(vmd->bus[VMD_BUS_1]->bridge));
> +
> +	if (vmd->irq_domain)
> +		dev_set_msi_domain(&vmd->bus[VMD_BUS_1]->dev,
> +				   vmd->irq_domain);
> +	else
> +		dev_set_msi_domain(&vmd->bus[VMD_BUS_1]->dev,
> +				   dev_get_msi_domain(&vmd->dev->dev));
> +
> +	return 0;

This looks a lot like parts of vmd_enable_domain().  Could this be
factored out into a helper function that could be used for both
VMD_BUS_0 and VMD_BUS_1?

Why is vmd_attach_resource() is different between them?  Why is
sysfs_create_link() is different?

Bjorn


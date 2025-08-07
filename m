Return-Path: <linux-pci+bounces-33591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D0EB1DF6D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 00:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522693BE2A9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BE2220696;
	Thu,  7 Aug 2025 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ieng9ANQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA1219A79;
	Thu,  7 Aug 2025 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754606848; cv=none; b=ga64dN5UqUpxqsRlO+49d3qkhpHp5rQthbf12nitx5QW0RhxHAFn+hvyusFxFYYqXPVt9iyzlc8AkTz2tntR0qwMYBas/KOFHGzltHUHiipxlwflpaEbHK2SrifQxL0NqQUa2yxlE5HfrM24xOiLRr8SUGrwDxx87mPv+sRZFK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754606848; c=relaxed/simple;
	bh=k9cCHxrPqFlLO8n/xdlItfKZmsZ4lhJyShLlj5tKe20=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pOU7J0VZBKeWLyD9qLAPvLBnUtHd7na0kVicvg+YGypalfFk4jpDPhgeByZuT1VXp9dDSO/XvYVft8PRczNgT1aqzbhdRGvMWxN2d2x7ZrQlZf3PTcZ9ppbdWMXGiA0NDRBVyaUvHaN1+OrIMnNzUYRTWE5B0pzHlVVBaJF9u0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ieng9ANQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18485C4CEEB;
	Thu,  7 Aug 2025 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754606848;
	bh=k9cCHxrPqFlLO8n/xdlItfKZmsZ4lhJyShLlj5tKe20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ieng9ANQGptKKritD1IXb2wbAf28Ucxe6k/Ues4tu6QDeMuzFcc7OwnKm1TOjVvJA
	 xM/bis00JzwMZwXjBb+xHTJVxpTs3YXFubbRalk3brlW8wxOPj+ceWQbtfQyxLJhaM
	 baglNVpitWHOh3/cVv7Zb0MS7PyO3B228pW3azrAzVJsBRHZKveIl2aNHhoDd3zCsb
	 NEFTwT3K+IvMEsD139WGlilDPz/HxndPRWKJUrXw9ef/72tah9ti3fQW5l+Rccp1GJ
	 hSxu3Du6W64n7f61otSQSbwhVuHUhA2cpDOpEINzBZG0gWGJNmd0gh4iFl03RH/m6s
	 4pPZSyswVN1Sw==
Date: Thu, 7 Aug 2025 17:47:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Yilun Xu <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 07/10] PCI/IDE: Add IDE establishment helpers
Message-ID: <20250807224726.GA66698@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717183358.1332417-8-dan.j.williams@intel.com>

On Thu, Jul 17, 2025 at 11:33:55AM -0700, Dan Williams wrote:
> There are two components to establishing an encrypted link, provisioning
> the stream in Partner Port config-space, and programming the keys into
> the link layer via IDE_KM (IDE Key Management). This new library,
> drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
> driver, is saved for later.
> 
> With the platform TSM implementations of SEV-TIO and TDX Connect in mind
> this library abstracts small differences in those implementations. For
> example, TDX Connect handles Root Port register setup while SEV-TIO
> expects System Software to update the Root Port registers. This is the
> rationale for fine-grained 'setup' + 'enable' verbs.
> 
> The other design detail for TSM-coordinated IDE establishment is that
> the TSM may manage allocation of Stream IDs, this is why the Stream ID
> value is passed in to pci_ide_stream_setup().
> 
> The flow is:
> 
> pci_ide_stream_alloc()
>   Allocate a Selective IDE Stream Register Block in each Partner Port
>   (Endpoint + Root Port), and reserve a host bridge / platform stream
>   slot. Gather Partner Port specific stream settings like Requester ID.
> pci_ide_stream_register()
>   Publish the stream in sysfs after allocating a Stream ID. In the TSM
>   case the TSM allocates the Stream ID for the Partner Port pair.
> pci_ide_stream_setup()
>   Program the stream settings to a Partner Port. Caller is responsible
>   for optionally calling this for the Root Port as well if the TSM
>   implementation requires it.
> pci_ide_stream_enable()
>   Try to run the stream after IDE_KM.
> 
> In support of system administrators auditing where platform, Root Port,
> and Endpoint IDE stream resources are being spent, the allocated stream
> is reflected as a symlink from the host bridge to the endpoint with the
> name:
> 
>     stream%d.%d.%d
> 
> Where the tuple of integers reflects the allocated platform, Root Port,
> and Endpoint stream index (Selective IDE Stream Register Block) values.
> 
> Thanks to Wu Hao for a draft implementation of this infrastructure.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Yilun Xu <yilun.xu@linux.intel.com>
> Signed-off-by: Yilun Xu <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  .../ABI/testing/sysfs-devices-pci-host-bridge |  16 +
>  drivers/pci/ide.c                             | 422 ++++++++++++++++++
>  include/linux/pci-ide.h                       |  70 +++
>  include/linux/pci.h                           |   6 +
>  4 files changed, 514 insertions(+)
>  create mode 100644 include/linux/pci-ide.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> index 8c3a652799f1..c67d7c30efa0 100644
> --- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> @@ -17,3 +17,19 @@ Description:
>  		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00). See
>  		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
>  		format.
> +
> +What:		pciDDDD:BB/streamH.R.E
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a platform has established a secure connection, PCIe
> +		IDE, between two Partner Ports, this symlink appears. The
> +		primary function is to account the stream slot / resources
> +		consumed in each of the (H)ost bridge, (R)oot Port and
> +		(E)ndpoint that will be freed when invoking the tsm/disconnect
> +		flow. The link points to the endpoint PCI device in the
> +		Selective IDE Stream. "R" and "E" represent the assigned
> +		Selective IDE Stream Register Block in the Root Port and
> +		Endpoint, and "H" represents a platform specific pool of stream
> +		resources shared by the Root Ports in a host bridge. See
> +		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
> +		format.
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index e15937cdb2a4..cdc773a8b381 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -5,6 +5,8 @@
>  
>  #define dev_fmt(fmt) "PCI/IDE: " fmt
>  #include <linux/pci.h>
> +#include <linux/sysfs.h>
> +#include <linux/pci-ide.h>
>  #include <linux/bitfield.h>
>  #include "pci.h"
>  
> @@ -24,6 +26,13 @@ static int __sel_ide_offset(u16 ide_cap, u8 nr_link_ide, u8 stream_index,
>  	return offset;
>  }
>  
> +static int sel_ide_offset(struct pci_dev *pdev,
> +			  struct pci_ide_partner *settings)
> +{
> +	return __sel_ide_offset(pdev->ide_cap, pdev->nr_link_ide,
> +				settings->stream_index, pdev->nr_ide_mem);
> +}
> +
>  void pci_ide_init(struct pci_dev *pdev)
>  {
>  	u8 nr_link_ide, nr_ide_mem, nr_streams;
> @@ -89,5 +98,418 @@ void pci_ide_init(struct pci_dev *pdev)
>  
>  	pdev->ide_cap = ide_cap;
>  	pdev->nr_link_ide = nr_link_ide;
> +	pdev->nr_sel_ide = nr_streams;
>  	pdev->nr_ide_mem = nr_ide_mem;
>  }
> +
> +struct stream_index {
> +	unsigned long *map;
> +	u8 max, stream_index;
> +};
> +
> +static void free_stream_index(struct stream_index *stream)
> +{
> +	clear_bit_unlock(stream->stream_index, stream->map);
> +}
> +
> +DEFINE_FREE(free_stream, struct stream_index *, if (_T) free_stream_index(_T))
> +static struct stream_index *alloc_stream_index(unsigned long *map, u8 max,
> +					       struct stream_index *stream)
> +{
> +	if (!max)
> +		return NULL;
> +
> +	do {
> +		u8 stream_index = find_first_zero_bit(map, max);
> +
> +		if (stream_index == max)
> +			return NULL;
> +		if (!test_and_set_bit_lock(stream_index, map)) {
> +			*stream = (struct stream_index) {
> +				.map = map,
> +				.max = max,
> +				.stream_index = stream_index,
> +			};
> +			return stream;
> +		}
> +		/* collided with another stream acquisition */
> +	} while (1);
> +}
> +
> +/**
> + * pci_ide_stream_alloc() - Reserve stream indices and probe for settings
> + * @pdev: IDE capable PCIe Endpoint Physical Function
> + *
> + * Retrieve the Requester ID range of @pdev for programming its Root
> + * Port IDE RID Association registers, and conversely retrieve the
> + * Requester ID of the Root Port for programming @pdev's IDE RID
> + * Association registers.
> + *
> + * Allocate a Selective IDE Stream Register Block instance per port.
> + *
> + * Allocate a platform stream resource from the associated host bridge.
> + * Retrieve stream association parameters for Requester ID range and
> + * address range restrictions for the stream.
> + */
> +struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
> +{
> +	/* EP, RP, + HB Stream allocation */
> +	struct stream_index __stream[PCI_IDE_HB + 1];
> +	struct pci_host_bridge *hb;
> +	struct pci_dev *rp;
> +	int num_vf, rid_end;
> +
> +	if (!pci_is_pcie(pdev))
> +		return NULL;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return NULL;
> +
> +	if (!pdev->ide_cap)
> +		return NULL;
> +
> +	/*
> +	 * Catch buggy PCI platform initialization (missing
> +	 * pci_ide_init_nr_streams())
> +	 */
> +	hb = pci_find_host_bridge(pdev->bus);
> +	if (WARN_ON_ONCE(!hb->nr_ide_streams))
> +		return NULL;
> +
> +	struct pci_ide *ide __free(kfree) = kzalloc(sizeof(*ide), GFP_KERNEL);
> +	if (!ide)
> +		return NULL;
> +
> +	struct stream_index *hb_stream __free(free_stream) = alloc_stream_index(
> +		hb->ide_stream_map, hb->nr_ide_streams, &__stream[PCI_IDE_HB]);
> +	if (!hb_stream)
> +		return NULL;
> +
> +	rp = pcie_find_root_port(pdev);
> +	struct stream_index *rp_stream __free(free_stream) = alloc_stream_index(
> +		rp->ide_stream_map, rp->nr_sel_ide, &__stream[PCI_IDE_RP]);
> +	if (!rp_stream)
> +		return NULL;
> +
> +	struct stream_index *ep_stream __free(free_stream) = alloc_stream_index(
> +		pdev->ide_stream_map, pdev->nr_sel_ide, &__stream[PCI_IDE_EP]);
> +	if (!ep_stream)
> +		return NULL;
> +
> +	/* for SR-IOV case, cover all VFs */
> +	num_vf = pci_num_vf(pdev);
> +	if (num_vf)
> +		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
> +				    pci_iov_virtfn_devfn(pdev, num_vf));
> +	else
> +		rid_end = pci_dev_id(pdev);
> +
> +	*ide = (struct pci_ide) {
> +		.pdev = pdev,
> +		.partner = {
> +			[PCI_IDE_EP] = {
> +				.rid_start = pci_dev_id(rp),
> +				.rid_end = pci_dev_id(rp),
> +				.stream_index = no_free_ptr(ep_stream)->stream_index,
> +			},
> +			[PCI_IDE_RP] = {
> +				.rid_start = pci_dev_id(pdev),
> +				.rid_end = rid_end,
> +				.stream_index = no_free_ptr(rp_stream)->stream_index,
> +			},
> +		},
> +		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
> +		.stream_id = -1,
> +	};
> +
> +	return_ptr(ide);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_alloc);
> +
> +/**
> + * pci_ide_stream_free() - unwind pci_ide_stream_alloc()
> + * @ide: idle IDE settings descriptor
> + *
> + * Free all of the stream index (register block) allocations acquired by
> + * pci_ide_stream_alloc(). The stream represented by @ide is assumed to
> + * be unregistered and not instantiated in any device.
> + */
> +void pci_ide_stream_free(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +
> +	clear_bit_unlock(ide->partner[PCI_IDE_EP].stream_index,
> +			 pdev->ide_stream_map);
> +	clear_bit_unlock(ide->partner[PCI_IDE_RP].stream_index,
> +			 rp->ide_stream_map);
> +	clear_bit_unlock(ide->host_bridge_stream, hb->ide_stream_map);
> +	kfree(ide);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_free);
> +
> +/**
> + * pci_ide_stream_release() - unwind and release an @ide context
> + * @ide: partially or fully registered IDE settings descriptor
> + *
> + * In support of automatic cleanup of IDE setup routines perform IDE
> + * teardown in expected reverse order of setup and with respect to which
> + * aspects of IDE setup have successfully completed.
> + *
> + * Be careful that setup order mirrors this shutdown order. Otherwise,
> + * open code releasing the IDE context.
> + */
> +void pci_ide_stream_release(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +
> +	if (ide->partner[PCI_IDE_RP].enable)
> +		pci_ide_stream_disable(rp, ide);
> +
> +	if (ide->partner[PCI_IDE_EP].enable)
> +		pci_ide_stream_disable(pdev, ide);
> +
> +	if (ide->partner[PCI_IDE_RP].setup)
> +		pci_ide_stream_teardown(rp, ide);
> +
> +	if (ide->partner[PCI_IDE_EP].setup)
> +		pci_ide_stream_teardown(pdev, ide);
> +
> +	if (ide->name)
> +		pci_ide_stream_unregister(ide);
> +
> +	pci_ide_stream_free(ide);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_release);
> +
> +/**
> + * pci_ide_stream_register() - Prepare to activate an IDE Stream
> + * @ide: IDE settings descriptor
> + *
> + * After a Stream ID has been acquired for @ide, record the presence of
> + * the stream in sysfs. The expectation is that @ide is immutable while
> + * registered.
> + */
> +int pci_ide_stream_register(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +	u8 ep_stream, rp_stream;
> +	int rc;
> +
> +	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
> +		pci_err(pdev, "Setup fail: Invalid Stream ID: %d\n", ide->stream_id);
> +		return -ENXIO;
> +	}
> +
> +	ep_stream = ide->partner[PCI_IDE_EP].stream_index;
> +	rp_stream = ide->partner[PCI_IDE_RP].stream_index;
> +	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "stream%d.%d.%d",
> +						   ide->host_bridge_stream,
> +						   rp_stream, ep_stream);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, name);
> +	if (rc)
> +		return rc;
> +
> +	ide->name = no_free_ptr(name);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_register);
> +
> +/**
> + * pci_ide_stream_unregister() - unwind pci_ide_stream_register()
> + * @ide: idle IDE settings descriptor
> + *
> + * In preparation for freeing @ide, remove sysfs enumeration for the
> + * stream.
> + */
> +void pci_ide_stream_unregister(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +
> +	sysfs_remove_link(&hb->dev.kobj, ide->name);
> +	kfree(ide->name);
> +	ide->name = NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_unregister);
> +
> +int pci_ide_domain(struct pci_dev *pdev)
> +{
> +	if (pdev->fm_enabled)
> +		return pci_domain_nr(pdev->bus);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_domain);
> +
> +struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	if (!pci_is_pcie(pdev)) {
> +		pci_warn_once(pdev, "not a PCIe device\n");
> +		return NULL;
> +	}
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		if (pdev != ide->pdev) {
> +			pci_warn_once(pdev, "setup expected Endpoint: %s\n", pci_name(ide->pdev));
> +			return NULL;
> +		}
> +		return &ide->partner[PCI_IDE_EP];
> +	case PCI_EXP_TYPE_ROOT_PORT: {
> +		struct pci_dev *rp = pcie_find_root_port(ide->pdev);
> +
> +		if (pdev != rp) {
> +			pci_warn_once(pdev, "setup expected Root Port: %s\n",
> +				      pci_name(rp));
> +			return NULL;
> +		}
> +		return &ide->partner[PCI_IDE_RP];
> +	}
> +	default:
> +		pci_warn_once(pdev, "invalid device type\n");
> +		return NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_to_settings);
> +
> +static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide, int pos,
> +			    bool enable)
> +{
> +	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_EN, enable);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
> +}
> +
> +/**
> + * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered IDE settings descriptor
> + *
> + * When @pdev is a PCI_EXP_TYPE_ENDPOINT then the PCI_IDE_EP partner
> + * settings are written to @pdev's Selective IDE Stream register block,
> + * and when @pdev is a PCI_EXP_TYPE_ROOT_PORT, the PCI_IDE_RP settings
> + * are selected.
> + */
> +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, settings->rid_end);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> +	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, settings->rid_start) |
> +	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, pci_ide_domain(pdev));
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> +
> +	/*
> +	 * Setup control register early for devices that expect
> +	 * stream_id is set during key programming.
> +	 */
> +	set_ide_sel_ctl(pdev, ide, pos, false);
> +	settings->setup = 1;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
> +
> +/**
> + * pci_ide_stream_teardown() - disable the stream and clear all settings
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered IDE settings descriptor
> + *
> + * For stream destruction, zero all registers that may have been written
> + * by pci_ide_stream_setup(). Consider pci_ide_stream_disable() to leave
> + * settings in place while temporarily disabling the stream.
> + */
> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
> +	settings->setup = 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_teardown);
> +
> +/**
> + * pci_ide_stream_enable() - try to enable a Selective IDE Stream
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered and setup IDE settings descriptor
> + *
> + * Activate the stream by writing to the Selective IDE Stream Control
> + * Register, report whether the state successfully transitioned to
> + * secure mode. Note that the state may go "insecure" at any point after
> + * this check, but that is handled via asynchronous error reporting.
> + */
> +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return -ENXIO;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	set_ide_sel_ctl(pdev, ide, pos, true);
> +
> +	pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
> +	if (FIELD_GET(PCI_IDE_SEL_STS_STATE_MASK, val) !=
> +	    PCI_IDE_SEL_STS_STATE_SECURE) {
> +		set_ide_sel_ctl(pdev, ide, pos, false);
> +		return -ENXIO;
> +	}
> +
> +	settings->enable = 1;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_enable);
> +
> +/**
> + * pci_ide_stream_disable() - disable a Selective IDE Stream
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered and setup IDE settings descriptor
> + *
> + * Clear the Selective IDE Stream Control Register, but leave all other
> + * registers untouched.
> + */
> +void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +	settings->enable = 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> new file mode 100644
> index 000000000000..89c1ef0de841
> --- /dev/null
> +++ b/include/linux/pci-ide.h
> @@ -0,0 +1,70 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> +
> +#ifndef __PCI_IDE_H__
> +#define __PCI_IDE_H__
> +
> +enum pci_ide_partner_select {
> +	PCI_IDE_EP,
> +	PCI_IDE_RP,
> +	PCI_IDE_PARTNER_MAX,
> +	/*
> +	 * In addition to the resources in each partner port the
> +	 * platform / host-bridge additionally has a Stream ID pool that
> +	 * it shares across root ports. Let pci_ide_stream_alloc() use
> +	 * the alloc_stream_index() helper as endpoints and root ports.
> +	 */
> +	PCI_IDE_HB = PCI_IDE_PARTNER_MAX,
> +};
> +
> +/**
> + * struct pci_ide_partner - Per port pair Selective IDE Stream settings
> + * @rid_start: Partner Port Requester ID range start
> + * @rid_start: Partner Port Requester ID range end
> + * @stream_index: Selective IDE Stream Register Block selection
> + * @setup: flag to track whether to run pci_ide_stream_teardown for this parnter slot
> + * @enable: flag whether to run pci_ide_stream_disable for this parnter slot
> + */
> +struct pci_ide_partner {
> +	u16 rid_start;
> +	u16 rid_end;
> +	u8 stream_index;
> +	unsigned int setup:1;
> +	unsigned int enable:1;
> +};
> +
> +/**
> + * struct pci_ide - PCIe Selective IDE Stream descriptor
> + * @pdev: PCIe Endpoint in the pci_ide_partner pair
> + * @partner: Per-partner settings
> + * @host_bridge_stream: track platform Stream ID
> + * @stream_id: unique Stream ID (within Partner Port pairing)
> + * @name: name of the established Selective IDE Stream in sysfs
> + *
> + * Negative @stream_id values indicate "uninitialized" on the
> + * expectation that with TSM established IDE the TSM owns the stream_id
> + * allocation.
> + */
> +struct pci_ide {
> +	struct pci_dev *pdev;
> +	struct pci_ide_partner partner[PCI_IDE_PARTNER_MAX];
> +	u8 host_bridge_stream;
> +	int stream_id;
> +	const char *name;
> +};
> +
> +int pci_ide_domain(struct pci_dev *pdev);
> +struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide);
> +struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
> +void pci_ide_stream_free(struct pci_ide *ide);
> +int  pci_ide_stream_register(struct pci_ide *ide);
> +void pci_ide_stream_unregister(struct pci_ide *ide);
> +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide);
> +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_stream_release(struct pci_ide *ide);
> +DEFINE_FREE(pci_ide_stream_release, struct pci_ide *, if (_T) pci_ide_stream_release(_T))
> +#endif /* __PCI_IDE_H__ */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a7353df51fea..cc83ae274601 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -538,6 +538,8 @@ struct pci_dev {
>  	u16		ide_cap;	/* Link Integrity & Data Encryption */
>  	u8		nr_ide_mem;	/* Address association resources for streams */
>  	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
> +	u8		nr_sel_ide;	/* Selective Stream count (register block allocator) */
> +	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
>  	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
>  	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
>  #endif
> @@ -607,6 +609,10 @@ struct pci_host_bridge {
>  	int		domain_nr;
>  	struct list_head windows;	/* resource_entry */
>  	struct list_head dma_ranges;	/* dma ranges resource list */
> +#ifdef CONFIG_PCI_IDE
> +	u8 nr_ide_streams;		/* Track available vs in-use streams */
> +	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
> +#endif
>  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>  	int (*map_irq)(const struct pci_dev *, u8, u8);
>  	void (*release_fn)(struct pci_host_bridge *);
> -- 
> 2.50.1
> 


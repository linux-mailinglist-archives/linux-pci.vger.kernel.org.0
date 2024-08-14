Return-Path: <linux-pci+bounces-11682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4C19524F3
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 23:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55388B23664
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 21:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0384A1C7B9F;
	Wed, 14 Aug 2024 21:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbOP4YxA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B4E1C579B
	for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2024 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672172; cv=none; b=OdD9KCuHdrR6ly4lDZ5fMGFwtz0zBtmO/oIRmmCg76FFi0ehGtm7+ftcE9X0hXrAlPYtgizUSpxzXMZ6BSlV+SoUCSRDoSQY2d3yTRSPPhw9IqH9SF74vCRaDQcZMeopgBZpIja7KuT97dj5MDPppIKFkYSZPOvnXZaUFxdgO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672172; c=relaxed/simple;
	bh=IJdWgjQXxvBMKvDMNNrGBEu8socBYNX1yfFX9H9rqrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tbDxpPmqpLHEuBLLnj/0rhZ22bs8eepx60zm1J6MFWUna3s1EmBPHRzi7+y5lC415GdsMjjqOYTfjJiu0Oao2zkN+AIt130czpXuGvvHNeyfBHdKKJtYkaIUTHzq4X8qxVe6ixMSsZ/OLL8dJn/L+FHnedS0qx15YQRGJV0FY6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbOP4YxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3776EC32786;
	Wed, 14 Aug 2024 21:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723672172;
	bh=IJdWgjQXxvBMKvDMNNrGBEu8socBYNX1yfFX9H9rqrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kbOP4YxAodh0HA+gNSBUm0Z9Ti32s+bCgjhGj4j6EcaL7dBgYaeyHOIfpvGEguTNl
	 49Bn5eM2pKU5navV7J+fQzYMs/RraUHfF5M90U/uV3VllGyzl99Halomky0fTvb+xd
	 hPb2I5vNLLGZiUhSc+b1uFDUgCkocI5QJ8I9ryvhnQkkqTfgz8nPh8pJiUeu4WMDPt
	 3i9I+vf5Xfy8RM2qj7Vj0TpbXPCQYDg+0KYIFWFf2v/03wZ8rYHOpIw2HEyBOVKdSU
	 1aw86PxMrCribWvyXuc4Du6Q6NwVf9kBaYgdYDHObo8fwbgkYjSNrR2irD+i6+yW9p
	 Mf4+pi3E9OcVQ==
Date: Wed, 14 Aug 2024 16:49:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240814214930.GA5507@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814122900.13525-3-mariusz.tkaczyk@linux.intel.com>

On Wed, Aug 14, 2024 at 02:28:59PM +0200, Mariusz Tkaczyk wrote:
> Native PCIe Enclosure Management (NPEM, PCIe r6.1 sec 6.28) allows
> managing LED in storage enclosures. NPEM is indication oriented
> and it does not give direct access to LED. Although each of
> the indications *could* represent an individual LED, multiple
> indications could also be represented as a single,
> multi-color LED or a single LED blinking in a specific interval.
> The specification leaves that open.
> ...

> Driver is projected to be exclusive NPEM extended capability manager.
> It waits up to 1 second after imposing new request, it doesn't verify if
> controller is busy before write, assuming that mutex lock gives protection
> from concurrent updates. 

> Driver is not registered if _DSM LED management
> is available.

IMO we should drop this sentence (more details below).

> NPEM is a PCIe extended capability so it should be registered in
> pcie_init_capabilities() but it is not possible due to LED dependency.
> Parent pci_device must be added earlier for led_classdev_register()
> to be successful. NPEM does not require configuration on kernel side, it
> is safe to register LED devices later.
> 
> Link: https://members.pcisig.com/wg/PCI-SIG/document/19849 [1]

I can update this myself, no need to repost just for this, but I think
these links are pointless because they're useless except for PCI-SIG
members, and I don't want to rely them being permalinks anyway.

A reference like "PCIe r6.1" is universally and permanently
meaningful.

> +struct npem {
> +	struct pci_dev *dev;
> +	const struct npem_ops *ops;
> +	struct mutex lock;
> +	u16 pos;
> +	u32 supported_indications;
> +	u32 active_indications;
> +
> +	/*
> +	 * Use lazy loading for active_indications to not play with initcalls.
> +	 * It is needed to allow _DSM initialization on DELL platforms, where
> +	 * ACPI_IPMI must be loaded first.
> +	 */
> +	unsigned int active_inds_initialized:1;

What's going on here?  I hope we can at least move this to the _DSM
patch since it seems related to that, not to the NPEM capability.  I
don't understand the initcall reference or what "lazy loading" means.

Is there some existing ACPI ordering that guarantees ACPI_IPMI happens
first?  Why do we need some Dell-specific thing here?

What is ACPI_IPMI?  I guess it refers to the "acpi_ipmi" module,
acpi_ipmi.c?

> +#define DSM_GUID GUID_INIT(0x5d524d9d, 0xfff9, 0x4d4b,  0x8c, 0xb7, 0x74, 0x7e,\
> +			   0xd5, 0x1e, 0x19, 0x4d)
> +#define GET_SUPPORTED_STATES_DSM	1
> +#define GET_STATE_DSM			2
> +#define SET_STATE_DSM			3
> +
> +static const guid_t dsm_guid = DSM_GUID;
> +
> +static bool npem_has_dsm(struct pci_dev *pdev)
> +{
> +	acpi_handle handle;
> +
> +	handle = ACPI_HANDLE(&pdev->dev);
> +	if (!handle)
> +		return false;
> +
> +	return acpi_check_dsm(handle, &dsm_guid, 0x1,
> +			      BIT(GET_SUPPORTED_STATES_DSM) |
> +			      BIT(GET_STATE_DSM) | BIT(SET_STATE_DSM));
> +}

> +void pci_npem_create(struct pci_dev *dev)
> +{
> +	const struct npem_ops *ops = &npem_ops;
> +	int pos = 0, ret;
> +	u32 cap;
> +
> +	if (!npem_has_dsm(dev)) {
> +		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_NPEM);
> +		if (pos == 0)
> +			return;
> +
> +		if (pci_read_config_dword(dev, pos + PCI_NPEM_CAP, &cap) != 0 ||
> +		    (cap & PCI_NPEM_CAP_CAPABLE) == 0)
> +			return;
> +	} else {
> +		/*
> +		 * OS should use the DSM for LED control if it is available
> +		 * PCI Firmware Spec r3.3 sec 4.7.
> +		 */
> +		return;
> +	}

I know this is sort of a transient state since the next patch adds
full _DSM support, but I do think (a) the fact that NPEM will stop
working simply because firmware adds _DSM support is unexpected
behavior, and (b) npem_has_dsm() and the other ACPI-related stuff
would fit better in the next patch.  It's a little strange to have
them mixed here.

> +++ b/include/uapi/linux/pci_regs.h
> ...

> +#define PCI_NPEM_CAP	0x04 /* NPEM capability register */
> +#define	 PCI_NPEM_CAP_CAPABLE		0x00000001 /* NPEM Capable */
> +
> +#define PCI_NPEM_CTRL	0x08 /* NPEM control register */
> +#define	 PCI_NPEM_CTRL_ENABLE		0x00000001 /* NPEM Enable */

Spaces instead of tabs after #define, as you did below (mostly), would
make the diff prettier.

> +#define  PCI_NPEM_CMD_RESET		0x00000002 /* NPEM Reset Command */
> +#define  PCI_NPEM_IND_OK		0x00000004 /* NPEM indication OK */
> +#define  PCI_NPEM_IND_LOCATE		0x00000008 /* NPEM indication Locate */
> ...

> +#define PCI_NPEM_STATUS	0x0c /* NPEM status register */
> +#define	 PCI_NPEM_STATUS_CC		0x00000001 /* NPEM Command completed */

Ditto.

Bjorn


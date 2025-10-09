Return-Path: <linux-pci+bounces-37760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88653BC9771
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 16:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF6B3BCEFD
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37CD2E8DF5;
	Thu,  9 Oct 2025 14:17:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F61260590;
	Thu,  9 Oct 2025 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019464; cv=none; b=krUu82SIcmz4g0dbkcLT7j0OPbnVTedCpEdSDfQK+o+o//gouBqySVYF9BxXoUcHbNyJ/MGG7FBd1zciXMldXw3drWIV/P/JHn/aW1/iL89rOCcr2m2w7rJEiympERiIXQCIsMC08zcLIcF17siTqSaVf8Gjiw4MD6G4BKrkPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019464; c=relaxed/simple;
	bh=H8+grDY8t7OnptbJxsbjpMKVSDaeAt6L4pI7ouKl/Eo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDCqgsbO22SAdIu3meq8QzuzGfwEyVU+XdtxHyfaHg1JBtWK5sKCrL5rmUN2mgXatQoNpJhWXBC/DhGMgxYUz0yWsdUXEv8gqppbKjg8WOWILPrBeOO9tfyB/CReOzwWBXImGEwJlYxJsyECfcDeG2GOKIgB6fy05wWHWebIF04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cjBj26gg3z6L4rs;
	Thu,  9 Oct 2025 22:15:02 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B5EE21400CA;
	Thu,  9 Oct 2025 22:17:38 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Oct
 2025 15:17:37 +0100
Date: Thu, 9 Oct 2025 15:17:36 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Evangelos Petrongonas <epetron@amazon.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, David
 Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, Chris Li
	<chrisl@kernel.org>, Jason Miu <jasonmiu@google.com>, "Pratyush Yadav"
	<pratyush@kernel.org>, Stanislav Spassov <stanspas@amazon.de>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: Re: [RFC PATCH 03/13] pci: pcsc: infer cacheability of PCI
 capabilities
Message-ID: <20251009151736.00002f45@huawei.com>
In-Reply-To: <fb2f262e4733a56bf0ebd9ef5c9325880aea05cd.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
	<fb2f262e4733a56bf0ebd9ef5c9325880aea05cd.1759312886.git.epetron@amazon.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 3 Oct 2025 09:00:39 +0000
Evangelos Petrongonas <epetron@amazon.de> wrote:

> Implement cacheability inference for PCI capabilities to
> determine which configuration space registers can be safely cached.
> 
> The first 64 bytes of PCI configuration space follow a standardized
> format, allowing straightforward cacheability determination. For
> capability-specific registers, the implementation traverses the PCI
> capability list to identify supported capabilities.
> 
> Cacheable registers are identified for the following capabilities:
> - Power Management (PM)
> - Message Signaled Interrupts (MSI)
> - Message Signaled Interrupts Extensions (MSI-X)
> - PCI Express
> - PCI Advanced Features (AF)
> - Enhanced Allocation (EA)
> - Vital Product Data (VPD)
> - Vendor Specific
> 
> The implementation pre-populates the cache with known values including
> device/vendor IDs and header type to avoid unnecessary configuration
> space reads during initialization.
> 
> We are currently not caching the Command/Status registers.
> 
> The cacheability of all capabilities apart from MSI, are straightforward
> and can be deduced from the spec. Regarding MSI the MSI flags are read
> and based on this, the cacheability is inferred.
> 
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> Signed-off-by: Stanislav Spassov <stanspas@amazon.de>

A few minor things below.

> +
> +static void infer_capabilities_pointers(struct pci_dev *dev)
> +{
> +	u8 pos, cap_id, next_cap;
> +	u32 val;
> +	int i;
> +
> +	if (pcsc_hw_config_read(dev->bus, dev->devfn, PCI_CAPABILITY_LIST, 1,
> +				&val) != PCIBIOS_SUCCESSFUL)
> +		return;
> +
> +	pos = (val & 0xFF) & ~0x3;

Given single byte read, shouldn't need the 0xFF masking.
Might be worth setting val = 0 at declaration though so that the compiler
can see it is assigned if we reach here.


> +
> +	while (pos) {
> +		if (pos < 0x40 || pos > 0xFE)
> +			break;
> +
> +		pos &= ~0x3;

I couldn't immediately find a spec statement of the bottom two bits being 0 for
the next capability pointers.  (There is one for the PCI_CAPABILITY_LIST)

> +		if (pcsc_hw_config_read(dev->bus, dev->devfn, pos, 2, &val) !=
> +		    PCIBIOS_SUCCESSFUL)
> +			break;
> +
> +		cap_id = val & 0xFF; /* PCI_CAP_LIST_ID */
> +		next_cap = (val >> 8) & 0xFF; /* PCI_CAP_LIST_NEXT */
> +
> +		bitmap_set(dev->pcsc->cachable_bitmask, pos, 2);
> +		pcsc_update_byte(dev, pos, cap_id); /* PCI_CAP_LIST_ID */
> +		pcsc_update_byte(dev, pos + 1,
> +				 next_cap); /* PCI_CAP_LIST_NEXT */

Could you do something like moving the bitmap_set before the pcsc_hw_config_read() and
cal pcsc_cached_config_read() to fill the cache directly during the read?

> +
> +		pci_dbg(dev, "Capability ID %#x found at %#x\n", cap_id, pos);
> +
> +		/* Check if this is a supported capability and infer cacheability */
> +		for (i = 0; i < ARRAY_SIZE(PCSC_SUPPORTED_CAPABILITIES); i++) {
> +			if (cap_id == PCSC_SUPPORTED_CAPABILITIES[i]) {
> +				infer_capability_cacheability(dev, pos, cap_id);
> +				break;
> +			}
> +		}
> +
> +		/* Move to next capability */
> +		pos = next_cap;
> +	}
> +}
> +
> +static void infer_cacheability(struct pci_dev *dev)
> +{
> +	if (WARN_ON(!dev || !dev->pcsc || !dev->pcsc->cfg_space))
> +		return;
> +
> +	bitmap_zero(dev->pcsc->cachable_bitmask, PCSC_CFG_SPC_SIZE);
> +
> +	/* Type 0 Configuration Space Header */
> +	if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
Unless you plan to add type 1 very soon I'd flip the logic to reduce
indent of the code that follows.


> +		/*
> +		 * Mark cacheable registers in the PCI configuration space header.
> +		 * We cache read-only and rarely changing registers:
> +		 * - PCI_VENDOR_ID, PCI_DEVICE_ID (0x00-0x03)
> +		 * - PCI_CLASS_REVISION through PCI_CAPABILITY_LIST (0x08-0x34)
> +		 *   Includes: CLASS_REVISION, CACHE_LINE_SIZE, LATENCY_TIMER,
> +		 *   HEADER_TYPE, BIST, BASE_ADDRESS_0-5, CARDBUS_CIS,
> +		 *   SUBSYSTEM_VENDOR_ID, SUBSYSTEM_ID, ROM_ADDRESS, CAPABILITY_LIST
> +		 * - PCI_INTERRUPT_LINE through PCI_MAX_LAT (0x3c-0x3f)
> +		 *   Includes: INTERRUPT_LINE, INTERRUPT_PIN, MIN_GNT, MAX_LAT
> +		 */
> +		bitmap_set(dev->pcsc->cachable_bitmask, PCI_VENDOR_ID, 4);
> +		bitmap_set(dev->pcsc->cachable_bitmask, PCI_CLASS_REVISION, 45);
For this large range can you derive that 45 as something like

PCI_CAPABILITY_LIST - PCI_CLASS_REVISION + 1

Same applies for the other multifield bitmap sets


> +		bitmap_set(dev->pcsc->cachable_bitmask, PCI_INTERRUPT_LINE, 4);
> +
> +		/* Pre populate the cache with the values that we already know */

I'm curious - do you have perf numbers to show it's worth writing these 5 bytes
directly into the cache? Feels like complexity that maybe doesn't belong there
in initial patch but should come along later in a patch with numbers to support
the small amount of extra complexity.

> +		pcsc_update_byte(dev, PCI_HEADER_TYPE,
> +				 dev->hdr_type |
> +					 (dev->multifunction ? 0x80 : 0));
> +
> +		/*
> +		 * SR-IOV VFs must return 0xFFFF (PCI_ANY_ID) for vendor/device ID
> +		 * registers per PCIe spec.
> +		 */
> +		if (dev->is_virtfn) {
> +			pcsc_update_byte(dev, PCI_VENDOR_ID, 0xFF);
> +			pcsc_update_byte(dev, PCI_VENDOR_ID + 1, 0xFF);
> +			pcsc_update_byte(dev, PCI_DEVICE_ID, 0xFF);
> +			pcsc_update_byte(dev, PCI_DEVICE_ID + 1, 0xFF);
> +		} else {
> +			if (dev->vendor != PCI_ANY_ID) {
> +				pcsc_update_byte(dev, PCI_VENDOR_ID,
> +						 dev->vendor & 0xFF);
> +				pcsc_update_byte(dev, PCI_VENDOR_ID + 1,
> +						 (dev->vendor >> 8) & 0xFF);
> +			}
> +			if (dev->device != PCI_ANY_ID) {
> +				pcsc_update_byte(dev, PCI_DEVICE_ID,
> +						 dev->device & 0xFF);
> +				pcsc_update_byte(dev, PCI_DEVICE_ID + 1,
> +						 (dev->device >> 8) & 0xFF);
> +			}
> +		}
> +
> +		infer_capabilities_pointers(dev);
> +	}
> +}




Return-Path: <linux-pci+bounces-20575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A45A22D99
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 14:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2213C1680B4
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 13:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7928819;
	Thu, 30 Jan 2025 13:21:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270EE1BEF85
	for <linux-pci@vger.kernel.org>; Thu, 30 Jan 2025 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738243298; cv=none; b=N+4E5SEnXDyY1Xmjvvb3VLjFgWL8HG1us/VBHwbZq0+JQJmwnOz4AR/K7ncfyF1cerk/D6Wa4gJzuZtG55aeZhxcfQLROpRAnH8Cg803gMjYahf+54ESjgllm34p8CTvFt699rUlLG+nsBpLhpJV4hHOZOzYhcAjIpi1yUwGFyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738243298; c=relaxed/simple;
	bh=31Y1emdzOrUShI0eVABfQbVoSQkTdZAiLpsoJ9BbLDU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkXAtGF7B7wJk7Jf6j1hve4hH2smjgPz+DpAbeOsRBNi8vWCweC4bYSkfvIFsIzlodkRo4eeXdN1x7ge/Mv2iLvyJO3HwJQp2ivx99YFqKHAGcrd8X11Dx6cGHe6sNGe7xQTlm2kKs3hgyF7hJfj/sl/iU2qh5pyho8q6Ibqmxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkKP95qptz6M4SL;
	Thu, 30 Jan 2025 21:19:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BAD0A1400D4;
	Thu, 30 Jan 2025 21:21:32 +0800 (CST)
Received: from localhost (10.47.30.69) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 30 Jan
 2025 14:21:32 +0100
Date: Thu, 30 Jan 2025 13:21:29 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 06/11] samples/devsec: PCI device-security bus /
 endpoint sample
Message-ID: <20250130132129.000027ad@huawei.com>
In-Reply-To: <173343743095.1074769.17985181033044298157.stgit@dwillia2-xfh.jf.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
	<173343743095.1074769.17985181033044298157.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 05 Dec 2024 14:23:51 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Establish just enough emulated PCI infrastructure to register a sample
> TSM (platform security manager) driver and have it discover an IDE + TEE
> (link encryption + device-interface security protocol (TDISP)) capable
> device.
> 
> Use the existing a CONFIG_PCI_BRIDGE_EMUL to emulate an IDE capable root
> port, and open code the emulation of an endpoint device via simulated
> configuration cycle responses.
> 
> The devsec_tsm driver responds to the PCI core TSM operations as if it
> successfully exercised the given interface security protocol message.
> 
> The devsec_bus and devsec_tsm drivers can be loaded in either order to
> reflect cases like SEV-TIO where the TSM is PCI-device firmware, and
> cases like TDX Connect where the TSM is a software agent running on the
> host CPU.
> 
> Follow-on patches add common code for TSM managed IDE establishment. For
> now, just successfully complete setup and teardown of the DSM (device
> security manager) context as a building block for management of TDI
> (trusted device interface) instances.
> 
>  # modprobe devsec_bus
>     devsec_bus devsec_bus: PCI host bridge to bus 10000:00
>     pci_bus 10000:00: root bus resource [bus 00-01]
>     pci_bus 10000:00: root bus resource [mem 0xf000000000-0xffffffffff 64bit]
>     pci 10000:00:00.0: [8086:7075] type 01 class 0x060400 PCIe Root Port
>     pci 10000:00:00.0: PCI bridge to [bus 00]
>     pci 10000:00:00.0:   bridge window [io  0x0000-0x0fff]
>     pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
>     pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
>     pci 10000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>     pci 10000:01:00.0: [8086:ffff] type 00 class 0x000000 PCIe Endpoint
>     pci 10000:01:00.0: BAR 0 [mem 0xf000000000-0xf0001fffff 64bit pref]
>     pci_doe_abort: pci 10000:01:00.0: DOE: [100] Issuing Abort
>     pci_doe_cache_protocols: pci 10000:01:00.0: DOE: [100] Found protocol 0 vid: 1 prot: 1
>     pci 10000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
>     pci 10000:00:00.0: PCI bridge to [bus 01]
>     pci_bus 10000:01: busn_res: [bus 01] end is updated to 01
>  # modprobe devsec_tsm
>     devsec_tsm_pci_probe: pci 10000:01:00.0: devsec: tsm enabled
>     __pci_tsm_init: pci 10000:01:00.0: TSM: Device security capabilities detected ( ide tee ), TSM attach
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Hi Dan,

A few minor comments as I was reading this. Mostly just trying
to get my head around it hence they are all fairly superficial things.

Jonathan

> diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
> new file mode 100644
> index 000000000000..47dbe4e1b648
> --- /dev/null
> +++ b/samples/devsec/bus.c


> +static void destroy_iomem_pool(void *data)

There is a devm_gen_pool_create you can probably use.

> +{
> +	struct devsec *devsec = data;
> +
> +	gen_pool_destroy(devsec->iomem_pool);
> +}
> +
> +static void destroy_bus(void *data)
> +{
> +	struct devsec *devsec = data;
> +
> +	pci_stop_root_bus(devsec->bus);
> +	pci_remove_root_bus(devsec->bus);
> +}
> +
> +static void destroy_devs(void *data)
> +{
> +	struct devsec *devsec = data;
> +	int i;
> +
> +	for (i = ARRAY_SIZE(devsec->devsec_devs) - 1; i >= 0; i--) {
> +		struct devsec_dev *devsec_dev = devsec->devsec_devs[i];
> +
> +		if (!devsec_dev)
> +			continue;
> +		gen_pool_free(devsec->iomem_pool, devsec_dev->mmio_range.start,
> +			      range_len(&devsec_dev->mmio_range));
> +		kfree(devsec_dev);
> +		devsec->devsec_devs[i] = NULL;
> +	}
> +}
> +

> +#define MMIO_SIZE SZ_2M
> +
> +static int alloc_devs(struct devsec *devsec)
> +{
> +	struct device *dev = devsec->dev;
> +	int i, rc;
> +
> +	rc = devm_add_action_or_reset(dev, destroy_devs, devsec);
> +	if (rc)
> +		return rc;
> +
> +	for (i = 0; i < ARRAY_SIZE(devsec->devsec_devs); i++) {
> +		struct devsec_dev *devsec_dev __free(kfree) =
> +			kzalloc(sizeof(*devsec_dev), GFP_KERNEL);
> +		struct genpool_data_align data = {
> +			.align = MMIO_SIZE,
> +		};
> +		u64 phys;
> +
> +		if (!devsec_dev)
> +			return -ENOMEM;
> +
> +		phys = gen_pool_alloc_algo(devsec->iomem_pool, MMIO_SIZE,
> +					   gen_pool_first_fit_align, &data);
> +		if (!phys)
> +			return -ENOMEM;
> +
> +		devsec_dev->mmio_range = (struct range) {
> +			.start = phys,
> +			.end = phys + MMIO_SIZE - 1,
> +		};
> +		init_dev_cfg(devsec_dev);
> +		devsec->devsec_devs[i] = no_free_ptr(devsec_dev);

Similar to the case below. I'd rather see a per dev devm_ cleanup
than relying on unified cleanup and that array having null entrees.
Should end up easier to follow.  Might require devsec dev to have
a reference back to the pool though.


> +	}
> +
> +	return 0;
> +}
> +
> +static void destroy_ports(void *data)
> +{
> +	struct devsec *devsec = data;
> +	int i;
> +
> +	for (i = ARRAY_SIZE(devsec->devsec_ports) - 1; i >= 0; i--) {
> +		struct devsec_port *devsec_port = devsec->devsec_ports[i];
> +
> +		if (!devsec_port)
> +			continue;
> +		pci_bridge_emul_cleanup(&devsec_port->bridge);
> +		kfree(devsec_port);
> +		devsec->devsec_ports[i] = NULL;

Is this necessary? If so it wrecks suggestion to do per port devres cleanup.
I don't think it is necessary though as we really should be touching that
array after this function is done.


> +	}
> +}


> +static int init_port(struct devsec_port *devsec_port)
> +{
> +	struct pci_bridge_emul *bridge = &devsec_port->bridge;
> +	int rc;
> +
> +	bridge->conf.vendor = cpu_to_le16(0x8086);
> +	bridge->conf.device = cpu_to_le16(0x7075);
> +	bridge->subsystem_vendor_id = cpu_to_le16(0x8086);
> +	bridge->conf.class_revision = cpu_to_le32(0x1);
> +
> +	bridge->conf.pref_mem_base = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
> +	bridge->conf.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
> +
> +	bridge->has_pcie = true;
> +	bridge->pcie_conf.devcap = cpu_to_le16(PCI_EXP_DEVCAP_FLR);
> +	bridge->pcie_conf.lnksta = cpu_to_le16(PCI_EXP_LNKSTA_CLS_2_5GB);
> +
> +	bridge->data = devsec_port;
> +	bridge->ops = &devsec_bridge_ops;
Maybe 
	*bridge = (struct pci_bridge_emul) {
	};
appropriate here. 	
> +
> +	init_ide(&devsec_port->ide);
> +
> +	rc = pci_bridge_emul_init(bridge, 0);

return pci_bridge_emul_init() unless a later patch is going to add more here.

> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}
> +
> +static int alloc_ports(struct devsec *devsec)
> +{
> +	struct device *dev = devsec->dev;
> +	int i, rc;
> +
> +	rc = devm_add_action_or_reset(dev, destroy_ports, devsec);
> +	if (rc)
> +		return rc;
> +
> +	for (i = 0; i < ARRAY_SIZE(devsec->devsec_ports); i++) {
> +		struct devsec_port *devsec_port __free(kfree) =
> +			kzalloc(sizeof(*devsec_port), GFP_KERNEL);
> +
> +		if (!devsec_port)
> +			return -ENOMEM;
> +
> +		rc = init_port(devsec_port);
> +		if (rc)
> +			return rc;

I'd prefer to see a per port devm cleanup registered so that you don't
have to register that before anything has happened leaving it only
loosely associated with what it is doing.


> +		devsec->devsec_ports[i] = no_free_ptr(devsec_port);
> +	}
> +
> +	return 0;
> +}


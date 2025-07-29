Return-Path: <linux-pci+bounces-33122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EB9B15011
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 17:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC09F18A35F5
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0983013C3F2;
	Tue, 29 Jul 2025 15:16:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4E0101E6;
	Tue, 29 Jul 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753802212; cv=none; b=myv5kM198BgOE/s6WgCM9ul9jYGz9Chunn9fK1C/xuTbFNULibNWvkLGSszKJ7ZONG6a7AaBEkuJ2FjTZT7IaRZYe+RW/P7Kp9tVxsFnB2SXXcPILYJ/IZANMqbjlgYpm9BrwKdPOEAZloLRzn8BNPt47hS4CopiRKvhmmNm+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753802212; c=relaxed/simple;
	bh=V2owKkmxso8ky64gkK84N96b5AuZo8LdM/hJidy3RL4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVHaGpoVCu0eKjZPHCvDhsf/KoLLMZSvXxuzFiqSb3YRmgEOh/Ux2qwUctpN2Fbrfm052QePCQtF18RTuxmUHPOqqxms+2uhKXO5GqmDiVW82mR6pMKCXjIsUvuAic8MebRg6jOx0qqqumXfXrSV0MEYqdGkGWypAVvW4JTH4tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4brzRg5JyCz6H8f2;
	Tue, 29 Jul 2025 23:15:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 60379140372;
	Tue, 29 Jul 2025 23:16:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Jul
 2025 17:16:45 +0200
Date: Tue, 29 Jul 2025 16:16:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 05/10] samples/devsec: Introduce a PCI
 device-security bus + endpoint sample
Message-ID: <20250729161643.000023e7@huawei.com>
In-Reply-To: <20250717183358.1332417-6-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
	<20250717183358.1332417-6-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Jul 2025 11:33:53 -0700
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

A fairly superficial review.  Too much staring at code today
to check the emulation was right and have any chance of spotting bugs!

> diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
> new file mode 100644
> index 000000000000..675e185fcf79
> --- /dev/null
> +++ b/samples/devsec/bus.c
> @@ -0,0 +1,708 @@

> +static int alloc_devs(struct devsec *devsec)
> +{
> +	struct device *dev = devsec->dev;

Similar to below.  Maybe use it inline.

> +
> +	for (int i = 0; i < ARRAY_SIZE(devsec->devsec_devs); i++) {
> +		struct devsec_dev *devsec_dev = devsec_dev_alloc(devsec);
> +		int rc;
> +
> +		if (IS_ERR(devsec_dev))
> +			return PTR_ERR(devsec_dev);
> +		rc = devm_add_action_or_reset(dev, destroy_devsec_dev,
> +					      devsec_dev);
> +		if (rc)
> +			return rc;
> +		devsec->devsec_devs[i] = devsec_dev;
> +	}
> +
> +	return 0;
> +}


> +static int init_port(struct devsec_port *devsec_port)
> +{
> +	struct pci_bridge_emul *bridge = &devsec_port->bridge;
> +
> +	*bridge = (struct pci_bridge_emul) {
> +		.conf = {
> +			.vendor = cpu_to_le16(0x8086),
> +			.device = cpu_to_le16(0x7075),

Emulating something real?  If not maybe we should get an ID from another space
(or reserve this one ;)

> +			.class_revision = cpu_to_le32(0x1),
> +			.pref_mem_base = cpu_to_le16(PCI_PREF_RANGE_TYPE_64),
> +			.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64),
> +		},


> +{
> +	struct device *dev = devsec->dev;

Only used once. I'd move it down there.

> +
> +	for (int i = 0; i < ARRAY_SIZE(devsec->devsec_ports); i++) {
> +		struct devsec_port *devsec_port = devsec_port_alloc();
> +		int rc;
> +
> +		if (IS_ERR(devsec_port))
> +			return PTR_ERR(devsec_port);
> +		rc = devm_add_action_or_reset(dev, destroy_port, devsec_port);
> +		if (rc)
> +			return rc;
> +		devsec->devsec_ports[i] = devsec_port;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init devsec_bus_probe(struct platform_device *pdev)
> +{
> +	int rc;
> +	struct devsec *devsec;
> +	u64 mmio_size = SZ_64G;
> +	struct devsec_sysdata *sd;
> +	struct pci_host_bridge *hb;
> +	struct device *dev = &pdev->dev;
> +	u64 mmio_start = iomem_resource.end + 1 - SZ_64G;
> +
> +	hb = devm_pci_alloc_host_bridge(
> +		dev, sizeof(*devsec) - sizeof(struct pci_host_bridge));

I'd move dev up a line.

> +	if (!hb)
> +		return -ENOMEM;



> diff --git a/samples/devsec/tsm.c b/samples/devsec/tsm.c
> new file mode 100644
> index 000000000000..a4705212a7e4
> --- /dev/null
> +++ b/samples/devsec/tsm.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024 - 2025 Intel Corporation. All rights reserved. */

> +
> +static const struct pci_tsm_ops *__devsec_pci_ops;
> +
> +static struct pci_tsm *devsec_tsm_pf0_probe(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	struct devsec_tsm_pf0 *devsec_tsm __free(kfree) =
> +		kzalloc(sizeof(*devsec_tsm), GFP_KERNEL);
> +	if (!devsec_tsm)
> +		return NULL;
> +
> +	rc = pci_tsm_pf0_constructor(pdev, &devsec_tsm->pci, __devsec_pci_ops);

As below. I'm not seeing why we can't use &devsec_pci_ops directly here.

> +	if (rc)
> +		return NULL;
> +
> +	pci_dbg(pdev, "tsm enabled\n");
> +	return &no_free_ptr(devsec_tsm)->pci.tsm;
> +}
> +
> +static struct pci_tsm *devsec_tsm_fn_probe(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	struct devsec_tsm_fn *devsec_tsm __free(kfree) =
> +		kzalloc(sizeof(*devsec_tsm), GFP_KERNEL);
> +	if (!devsec_tsm)
> +		return NULL;
> +
> +	rc = pci_tsm_constructor(pdev, &devsec_tsm->pci, __devsec_pci_ops);

here as well.

> +	if (rc)
> +		return NULL;
> +
> +	pci_dbg(pdev, "tsm (sub-function) enabled\n");
> +	return &no_free_ptr(devsec_tsm)->pci;
> +}

> +static struct pci_tsm_ops devsec_pci_ops = {
> +	.probe = devsec_tsm_pci_probe,
> +	.remove = devsec_tsm_pci_remove,
> +	.connect = devsec_tsm_connect,
> +	.disconnect = devsec_tsm_disconnect,
> +};
> +
> +static void devsec_tsm_remove(void *tsm_dev)
> +{
> +	tsm_unregister(tsm_dev);
> +}
> +
> +static int devsec_tsm_probe(struct faux_device *fdev)
> +{
> +	struct tsm_dev *tsm_dev;
> +
> +	tsm_dev = tsm_register(&fdev->dev, NULL, &devsec_pci_ops);
> +	if (IS_ERR(tsm_dev))
> +		return PTR_ERR(tsm_dev);
> +
> +	return devm_add_action_or_reset(&fdev->dev, devsec_tsm_remove,
> +					tsm_dev);
> +}
> +
> +static struct faux_device *devsec_tsm;
> +
> +static const struct faux_device_ops devsec_device_ops = {
> +	.probe = devsec_tsm_probe,
> +};
> +
> +static int __init devsec_tsm_init(void)
> +{
> +	__devsec_pci_ops = &devsec_pci_ops;

I'm not immediately grasping why this global is needed.
You never check if it's set, so why not just move definition of devsec_pci_ops
early enough that can be directly used everywhere.


> +	devsec_tsm = faux_device_create("devsec_tsm", NULL, &devsec_device_ops);
> +	if (!devsec_tsm)
> +		return -ENOMEM;
> +	return 0;
> +}
> +module_init(devsec_tsm_init);
> +
> +static void __exit devsec_tsm_exit(void)
> +{
> +	faux_device_destroy(devsec_tsm);
> +}
> +module_exit(devsec_tsm_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Device Security Sample Infrastructure: Platform TSM Driver");



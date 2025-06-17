Return-Path: <linux-pci+bounces-29925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B69DADCD8E
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 15:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA23404968
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 13:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C37923535C;
	Tue, 17 Jun 2025 13:30:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF6B2DE1E2
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167008; cv=none; b=YMG4dJXPU8cX1tdViASI40lSlh4SZoJnffD5qVecG4nwo/pKVR5Wup7c+UT/Uvt/ukCjgxaEOzwfboeeQ7srlrIk4k/SX2PIwYh4JztVoomUIBfof+cLYB7cz8N2J298a8P99I0IE6rhq+m8/ueSoMHDx9vDnX1lINiNnuoelgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167008; c=relaxed/simple;
	bh=Wi3gE3vcVy0Lfzxtq7VpKBD1rpoD4aF5cqyZdIfnEaQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEyF2bZRNMhVX2hgDYzrSuJKwHMz4EzmS5Nw0a1so0+OYENe71JePU1arAzYBOFrKcfYj7kLcpEQlzmuHOO2qk1RK9NeW3STORk1wNRCTqa6KR/JydgleX57ZhwheuMKxG8023QVVq6DEnqkVlzs63hOiUrjaRZc17TSUA004F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bM7555Rfwz6H7Gh;
	Tue, 17 Jun 2025 21:29:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 73D2C1402FE;
	Tue, 17 Jun 2025 21:30:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 17 Jun
 2025 15:30:02 +0200
Date: Tue, 17 Jun 2025 14:30:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Xu
 Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 06/13] samples/devsec: Introduce a PCI
 device-security bus + endpoint sample
Message-ID: <20250617143000.00001d05@huawei.com>
In-Reply-To: <20250516054732.2055093-7-dan.j.williams@intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
	<20250516054732.2055093-7-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 15 May 2025 22:47:25 -0700
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

Interesting bit of emulation.  Only real question I have
is whether you can switch from platform devices to faux bus?



> diff --git a/samples/devsec/tsm.c b/samples/devsec/tsm.c
> new file mode 100644
> index 000000000000..7a8d33dc54c6
> --- /dev/null
> +++ b/samples/devsec/tsm.c
> @@ -0,0 +1,143 @@

> +static const struct pci_tsm_ops devsec_pci_ops = {
> +	.probe = devsec_tsm_pci_probe,
> +	.remove = devsec_tsm_pci_remove,
> +	.connect = devsec_tsm_connect,
> +	.disconnect = devsec_tsm_disconnect,
> +};
> +
> +static void devsec_tsm_remove(void *tsm_core)
> +{
> +	tsm_unregister(tsm_core);
> +}
> +
> +static int devsec_tsm_probe(struct platform_device *pdev)
> +{
> +	struct tsm_core_dev *tsm_core;
> +
> +	tsm_core = tsm_register(&pdev->dev, NULL, &devsec_pci_ops);
> +	if (IS_ERR(tsm_core))
> +		return PTR_ERR(tsm_core);
> +
> +	return devm_add_action_or_reset(&pdev->dev, devsec_tsm_remove,
> +					tsm_core);
> +}
> +
> +static struct platform_driver devsec_tsm_driver = {
> +	.driver = {
> +		.name = "devsec_tsm",
> +	},
> +};
> +
> +static struct platform_device *devsec_tsm;
> +
> +static int __init devsec_tsm_init(void)
> +{

Could this use the faux bus stuff or does it need to be a platform
device for some reason?  That support may well have crossed with this work.


> +	struct platform_device_info devsec_tsm_info = {
> +		.name = "devsec_tsm",
> +		.id = -1,
> +	};
> +	int rc;
> +
> +	devsec_tsm = platform_device_register_full(&devsec_tsm_info);
> +	if (IS_ERR(devsec_tsm))
> +		return PTR_ERR(devsec_tsm);
> +
> +	rc = platform_driver_probe(&devsec_tsm_driver, devsec_tsm_probe);
> +	if (rc)
> +		platform_device_unregister(devsec_tsm);
> +	return rc;
> +}
> +module_init(devsec_tsm_init);
> +
> +static void __exit devsec_tsm_exit(void)
> +{
> +	platform_driver_unregister(&devsec_tsm_driver);
> +	platform_device_unregister(devsec_tsm);
> +}
> +module_exit(devsec_tsm_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Device Security Sample Infrastructure: Platform TSM Driver");



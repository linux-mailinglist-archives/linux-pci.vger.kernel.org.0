Return-Path: <linux-pci+bounces-33194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A31D3B1634F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 17:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FAE562B0D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32662DC335;
	Wed, 30 Jul 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DfO/sSgX"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF92DAFB4;
	Wed, 30 Jul 2025 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753887999; cv=none; b=Xdf1xBwmPHUyXk8EprfyXEnPV9rai9pdaEzzhgac0EK7zWPreX4FBVJBX0AjfBYLnwOpKzcrIYk5UyWgB9W68Dr7q9uu7gMDgGkql1jTNRUgnjW5bjbIMM6pUiortuoHKjHXgetPYHE/fIGGSOptXvOY4+TmbA0On/TxiSS/fH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753887999; c=relaxed/simple;
	bh=e0BDVRCEM875gKP6x03MM6K+lMJmv3rgI0YZ6tQXhdU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THjO989iiQQHdz76r8g5ZpCu0Rtp72g2G2f+ZIvJvxBkDOXL2qHzye0QLMKy05nfkQU3WpbfySsXBHyXqmprLYglv8+hO0M98MDLwjsJxoVvwo9XVsihpiMyId43RP9Ls85VQi6EJrYuWZuKjXQSJGB9t+MQP6RoqKkCfi7tTT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DfO/sSgX; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aXXisiL7xkRknewE1Ig2ymROYafvAI7Ag6jJJ99yA+E=;
	b=DfO/sSgXD4dDPESETdYv1zGjBjSQU28Lz6FJ0MBd2SYXBqWE/uqfo6xnAI7aDBF0oQjN4q+H6
	e//5VPRYRPKrCKsu2NmYrQWRaKM2flzpuha5C0/6bgfKdhWwQYoSURATlTbNAfuxL6AvvkEL4bR
	es+Mj/3KBAmvSHFqU9/bnRc=
Received: from frasgout.his.huawei.com (unknown [172.18.146.35])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4bsb9R3ZQhzMlVH;
	Wed, 30 Jul 2025 23:04:59 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsb9J5bG9z6H7JQ;
	Wed, 30 Jul 2025 23:04:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D5D191402F4;
	Wed, 30 Jul 2025 23:06:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 17:06:27 +0200
Date: Wed, 30 Jul 2025 16:06:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 34/38] coco: guest: arm64: Validate mmio range
 found in the interface report
Message-ID: <20250730160626.00003fee@huawei.com>
In-Reply-To: <20250728135216.48084-35-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-35-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Jul 2025 19:22:11 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> This starts the sequence to transition the realm device to the TDISP RUN
> state by writing 1 to 'tsm/accept'.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Just some trivial stuff.


> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
> index 47b379318e7c..936f844880de 100644
> --- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
> @@ -215,3 +215,135 @@ int rsi_device_lock(struct pci_dev *pdev)
>  
>  	return ret;
>  }

> +
> +int rsi_update_interface_report(struct pci_dev *pdev, bool validate)
> +{
> +	int ret;
> +	struct resource *r;
> +	int msix_tbl_bar, msix_pba_bar;
> +	unsigned int range_id;
> +	unsigned long mmio_start_phys;
> +	unsigned long mmio_flags = 0; /* non coherent, not limited order */
> +	struct pci_tdisp_mmio_range *mmio_range;
> +	struct pci_tdisp_device_interface_report *interface_report;
> +	struct cca_guest_dsc *dsm = to_cca_guest_dsc(pdev);
> +	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
> +		PCI_DEVID(pdev->bus->number, pdev->devfn);
> +
> +
Single line.
> +	interface_report = (struct pci_tdisp_device_interface_report *)dsm->interface_report;
> +	mmio_range = (struct pci_tdisp_mmio_range *)(interface_report + 1);
> +
> +
Single line

> +	msix_tbl_bar = get_msix_bar(pdev, PCI_MSIX_TABLE);
> +	msix_pba_bar = get_msix_bar(pdev, PCI_MSIX_PBA);
> +
> +	for (int i = 0; i < interface_report->mmio_range_count; i++, mmio_range++) {
> +
> +		/*FIXME!! units in 4K size*/
> +		range_id = FIELD_GET(TSM_INTF_REPORT_MMIO_RANGE_ID, mmio_range->range_attributes);
> +
> +		/* no secure interrupts */
> +		if (msix_tbl_bar != -1 && range_id == msix_tbl_bar) {

That first condition can get hiked out of the loop.

> +			pr_info("Skipping misx table\n");
> +			continue;
> +		}
> +
> +		if (msix_pba_bar != -1 && range_id == msix_pba_bar) {

Likewise.

> +			pr_info("Skipping misx pba\n");
> +			continue;
> +		}
> +
> +		r = pci_resource_n(pdev, range_id);
> +
> +		if (r->end == r->start ||
> +		    ((r->end - r->start + 1) & ~PAGE_MASK) || !mmio_range->num_pages) {
resource_size() 
> +			pci_warn(pdev, "Skipping broken range [%d] #%d %d pages, %llx..%llx\n",
> +				i, range_id, mmio_range->num_pages, r->start, r->end);
> +			continue;
> +		}
> +
> +		if (FIELD_GET(TSM_INTF_REPORT_MMIO_IS_NON_TEE, mmio_range->range_attributes)) {
> +			pci_info(pdev, "Skipping non-TEE range [%d] #%d %d pages, %llx..%llx\n",
> +				 i, range_id, mmio_range->num_pages, r->start, r->end);
> +			continue;
> +		}
> +
> +		/* No secure interrupts, we should not find this set, ignore for now. */
> +		if (FIELD_GET(TSM_INTF_REPORT_MMIO_MSIX_TABLE, mmio_range->range_attributes) ||
> +		    FIELD_GET(TSM_INTF_REPORT_MMIO_PBA, mmio_range->range_attributes)) {
> +			pci_info(pdev, "Skipping MSIX (%ld/%ld) range [%d] #%d %d pages, %llx..%llx\n",
> +				 FIELD_GET(TSM_INTF_REPORT_MMIO_MSIX_TABLE, mmio_range->range_attributes),
> +				 FIELD_GET(TSM_INTF_REPORT_MMIO_PBA, mmio_range->range_attributes),
> +				 i, range_id, mmio_range->num_pages, r->start, r->end);
> +			continue;
> +		}
> +
> +		mmio_start_phys = mmio_range->first_page;
> +		if (validate)
> +			ret = rsi_validate_dev_mapping(vdev_id, dsm->instance_id,
> +						       r->start, r->end + 1,
> +						       mmio_start_phys << 12, mmio_flags);
> +		else
> +			ret = rsi_invalidate_dev_mapping(r->start, r->end + 1);
> +		if (ret) {
> +			pci_err(pdev, "failed to set protection attributes for the address range\n");
> +			return -EIO;
> +		}
> +	}
> +	return 0;
> +}




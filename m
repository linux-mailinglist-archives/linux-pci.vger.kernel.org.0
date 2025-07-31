Return-Path: <linux-pci+bounces-33230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82AEB16FB6
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 12:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BCC3B27ED
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 10:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13F6221720;
	Thu, 31 Jul 2025 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eVACV8He"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B42113B284;
	Thu, 31 Jul 2025 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753958443; cv=none; b=Xv2/V4m0jkLc5t1ifIJBer1zK2eSY88gs1mk44WX63Yi8SHzB+a93IWHIWdUm8PLa2pBPszuI/W+sAoLjtFQ6UnF6alo9MZCXflB8z6h6Fb8n0g55kB6xeeri/w/pJ0AO9HGRViPhTCxnHh2CaLhRV709z5+HD6o35m6sfNZ9Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753958443; c=relaxed/simple;
	bh=+wJssKv4e7UyzpwRDkCiJ5WGBV31Ks8I2JWVKGV7Pns=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMXCwtA43A/wjv8gsPRo5n8hq+szAVkCxG9OaaTA/CouCKe25nhcKAg0zUwvNxux6v0MLxTBoHVTdERoLE6u1xovmR0C98rYbxih2PbQqdwCuzrRvD0z96D7JStcGXQCdW8a98HSCXNdPypdyTiijOEAtM5bD5ckM2NZ+bqxi4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eVACV8He; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=b8FdFV7RBSfnH3zcisKWjNGIFNA1AIhN1FHFQh4X284=;
	b=eVACV8HeH5ntk82EoCcT+opWY0Lv6x5aXTKbwhLSwEgX4IueO/vghmWDhPXOxEse4k7sXJKoH
	qw8lnlpXgwE52aUHa6UBdl0AjxIcwHKW2jdwq+X3UyCQKwBRGC4/XlDfDzmBB8xffyghetKYQ9c
	be3XQikWpzrAS7XaC21vI1Q=
Received: from frasgout.his.huawei.com (unknown [172.18.146.37])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4bt5D83M2szN121;
	Thu, 31 Jul 2025 18:39:04 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt58z3Mtkz6HJfg;
	Thu, 31 Jul 2025 18:36:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F344314038F;
	Thu, 31 Jul 2025 18:40:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 12:40:34 +0200
Date: Thu, 31 Jul 2025 11:40:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 35/38] coco: guest: arm64: Add Realm device start
 and stop support
Message-ID: <20250731114032.00007c72@huawei.com>
In-Reply-To: <20250728135216.48084-36-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-36-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Jul 2025 19:22:12 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Writing 1 to 'tsm/acceept' will initiate the TDISP RUN sequence.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

A few more trivial things on this first read through.

Jonathan

> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
> index 936f844880de..64034d220e02 100644
> --- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c

> +int rsi_device_stop(struct pci_dev *pdev)
> +{
> +	int ret;
> +	struct cca_guest_dsc *dsm = to_cca_guest_dsc(pdev);
> +	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
> +		PCI_DEVID(pdev->bus->number, pdev->devfn);

Feels like this occurs so often we should add a helper.
Can't be completely generic as pci_domain_nr can have more bits
than I guess we are assuming here, but we can have something for
use in the rsi code.


> +
> +	ret = rsi_rdev_stop(pdev, vdev_id, dsm->instance_id);
> +	if (ret != RSI_SUCCESS) {
> +		pci_err(pdev, "failed to stop the device (%u)\n", ret);
> +		return -EIO;
> +	}
>  	return 0;
>  }
> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
> index 0d6e1c0ada4a..71ee1edb832e 100644
> --- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
> @@ -54,5 +54,5 @@ static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)
>  int rsi_update_interface_report(struct pci_dev *pdev, bool validate);
>  int rsi_device_lock(struct pci_dev *pdev);
>  int rsi_device_start(struct pci_dev *pdev);
> -

Tidy this up.

> +int rsi_device_stop(struct pci_dev *pdev);
>  #endif



Return-Path: <linux-pci+bounces-41823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81340C75D93
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 19:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12A31343CA7
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6542F49ED;
	Thu, 20 Nov 2025 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1zEuB+jc"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC69C2D9ED5;
	Thu, 20 Nov 2025 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661289; cv=none; b=s961LGMjdHxVlzn0sn0ZH9j2rbWxhK9hNnT6/0Ebzjqh7SB51hrCR5joVU4V3OdymplzceIz90pO/MJmeEhJVochWWvMpfxQ7phLOFJYYgU5s+Z6J5m3oWLouwPXz2yN6uI9Ca8OAsNJJFMqkgB8kZDd8E7ZaZo9UuLKZLJoa8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661289; c=relaxed/simple;
	bh=l5VRGH5N34nOjC59Zz+JSsnAUatmUupK2xCEqlmb0Tg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUdTO7rh+p0Sje7D814kpmAi5TaZaA6BJS3J4KcqXYNJWuH6Jdj4xAkjMuhCHUMeTTH6opuVgWfUccqeYcYmDP4D//l4ltcCjw3uG5HPu4yWE/+AkzUs/K+r1kuVh+o3ZSG6AGgUlePaREpzwUV+Dp9jCSg/dTvWNLpbH1CoBkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1zEuB+jc; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bGTbEdfXnZ45UfzPZ3sRDaWh9GTZ9aGekJ2lAIsF/20=;
	b=1zEuB+jcnafeF3Ea4IyvkBekKoxjfL4g4LMSxVnZxwZVDEkXy29ycRlN5qjXCBPK4+vDgs2j+
	Py9MKyY0Ye8PMq9Yu2y0hTHO9Ocq3bhSR2kFK6k9bt0YlQu+Z6VZFgZWSgPOLFjGMtOdkppPaN+
	v4SKaKcrAGjZgrjIqiP2VZU=
Received: from frasgout.his.huawei.com (unknown [172.18.146.33])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dC5YZ19X2z1P6lv;
	Fri, 21 Nov 2025 01:53:21 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC5Z46FbYzJ46B9;
	Fri, 21 Nov 2025 01:53:48 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B2C841402FD;
	Fri, 21 Nov 2025 01:54:34 +0800 (CST)
Received: from localhost (10.48.159.58) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 20 Nov
 2025 17:54:33 +0000
Date: Thu, 20 Nov 2025 17:54:32 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, <aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven Price
	<steven.price@arm.com>, Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon
	<will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH v2 08/11] coco: guest: arm64: Add support for fetching
 and verifying device info
Message-ID: <20251120175432.00004af8@huawei.com>
In-Reply-To: <20251117140007.122062-9-aneesh.kumar@kernel.org>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
	<20251117140007.122062-9-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 17 Nov 2025 19:30:04 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> RSI_RDEV_GET_INFO returns different digest hash values, which can be
> compared with host cached values to ensure the host didn't tamper with
> the cached data.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
> index c70fb7dd4838..c6b92f4ae9c5 100644
> --- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c

> +
> +static int verify_digests(struct cca_guest_dsc *dsc)
> +{
> +	u8 digest[SHA512_DIGEST_SIZE];
> +	size_t digest_size;
> +	void (*digest_func)(const u8 *data, size_t len, u8 *out);
> +
> +	struct pci_dev *pdev = dsc->pci.base_tsm.pdev;
> +	struct {
> +		uint8_t *report;
> +		size_t size;
> +		uint8_t *digest;
> +	} reports[] = {
> +		{
> +			dsc->interface_report,
> +			dsc->interface_report_size,
> +			dsc->dev_info.report_digest
> +		},
> +		{
> +			dsc->certificate,
> +			dsc->certificate_size,
> +			dsc->dev_info.cert_digest
> +		},
> +		{
> +			dsc->measurements,
> +			dsc->measurements_size,
> +			dsc->dev_info.meas_digest
> +		}
> +	};
> +
> +	switch (dsc->dev_info.hash_algo) {
> +	case RSI_HASH_SHA_256:
> +		digest_func = sha256;
> +		digest_size = SHA256_DIGEST_SIZE;
> +		break;
> +
> +	case RSI_HASH_SHA_512:
> +		digest_func = sha512;
> +		digest_size = SHA512_DIGEST_SIZE;
> +		break;
> +	default:
> +		pci_err(pdev, "Unknown realm hash algorithm!\n");
> +		return -EINVAL;
> +	}
> +
> +	for (int i = 0; i < ARRAY_SIZE(reports); i++) {
> +

I'd drop this blank line as it doesn't for me at least enhance readability
and I don't recall it being particularly common to have one here
in kernel code.

> +		digest_func(reports[i].report, reports[i].size, digest);
> +		if (memcmp(reports[i].digest, digest, digest_size)) {
> +			pci_err(pdev, "Invalid digest\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	pci_dbg(pdev, "Successfully verified the digests\n");
> +	return 0;
> +}
> +
> +int cca_device_verify_and_accept(struct pci_dev *pdev)
> +{
> +	int ret;
> +	int vdev_id = rsi_vdev_id(pdev);
> +	struct rsi_vdevice_info *dev_info;
> +	struct cca_guest_dsc *dsc = to_cca_guest_dsc(pdev);
> +
> +	/* Now make a host call to copy the interface report to guest. */
> +	ret = rhi_read_cached_object(vdev_id, RHI_DA_OBJECT_INTERFACE_REPORT,
> +				     &dsc->interface_report, &dsc->interface_report_size);
> +	if (ret) {
> +		pci_err(pdev, "failed to get interface report from the host (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = rhi_read_cached_object(vdev_id, RHI_DA_OBJECT_CERTIFICATE,
> +				     &dsc->certificate, &dsc->certificate_size);
> +	if (ret) {
> +		pci_err(pdev, "failed to get device certificate from the host (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = rhi_read_cached_object(vdev_id, RHI_DA_OBJECT_MEASUREMENT,
> +				     &dsc->measurements, &dsc->measurements_size);
> +	if (ret) {
> +		pci_err(pdev, "failed to get device certificate from the host (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	/* RMM expects sizeof(*dev_info) = 512 bytes aligned address */
> +	BUILD_BUG_ON(sizeof(*dev_info) != 512);
> +	dev_info = kmalloc(sizeof(*dev_info), GFP_KERNEL);
> +	if (!dev_info)
> +		return -ENOMEM;
> +
> +	if (rsi_vdev_get_info(vdev_id, virt_to_phys(dev_info))) {
> +		pci_err(pdev, "failed to get device digests (%d)\n", ret);
> +		kfree(dev_info);

Could use __free for that and not worry that we free it a little later than
last place we need it.

> +		return -EIO;
> +	}
> +
> +	dsc->dev_info.cert_id       = dev_info->cert_id;
> +	dsc->dev_info.hash_algo     = dev_info->hash_algo;
> +	dsc->dev_info.lock_nonce    = dev_info->lock_nonce;
> +	dsc->dev_info.meas_nonce    = dev_info->meas_nonce;
> +	dsc->dev_info.report_nonce  = dev_info->report_nonce;
> +	memcpy(dsc->dev_info.cert_digest, dev_info->cert_digest, SHA512_DIGEST_SIZE);
> +	memcpy(dsc->dev_info.meas_digest, dev_info->meas_digest, SHA512_DIGEST_SIZE);
> +	memcpy(dsc->dev_info.report_digest, dev_info->report_digest, SHA512_DIGEST_SIZE);

So copy everything other than flags.  Any reason why not flags?
> +
> +	kfree(dev_info);
> +	/*
> +	 * Verify that the digests of the provided reports match with the
> +	 * digests from RMM
> +	 */
> +	ret = verify_digests(dsc);
> +	if (ret) {
> +		pci_err(pdev, "device digest validation failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = cca_apply_interface_report_mappings(pdev, true);
> +	if (ret) {
> +		pci_err(pdev, "failed to validate the interface report\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}



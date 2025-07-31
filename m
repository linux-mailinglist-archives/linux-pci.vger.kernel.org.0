Return-Path: <linux-pci+bounces-33229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10247B16FB0
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 12:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310327AD220
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 10:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A5621FF2B;
	Thu, 31 Jul 2025 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OvXrFtiw"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863D413B284;
	Thu, 31 Jul 2025 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753958233; cv=none; b=STaz8wmstNCUd/MMUO/7ZpVxMuCI06cIRnL4heev627lQDZ42/qg/xAd0s1cBeQwta6qg2YaXuAO2I5m+8nk65kHSr5+W5dLq2ZUFnt7Cpbbmi+z95WJ0y7BsDU/eGjs3YQyYq3gLRn3JlYQVhikyw8NFoKSgBk4Y41o/cpF3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753958233; c=relaxed/simple;
	bh=n8kdXuvkITb7dSsdwMl/jIfFuSCy67bmGzkFT7H/+xA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gp2V4VJpLGUISDhAzrN6n2vGgsGfcW5/iNSnjvW698MSakhHHRiVlZLKJZ+aiOLXyMZ40DQEQ21tANw/dOnWyUAG1lLBaR6UXH6khZyPXqpICDZMIAi+VqhQCYgncwyPsoZoYnl5CF8vUFQlRJvRMGzXZHpEIXjhNAViK1G9cFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OvXrFtiw; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=juPk2yOqadzK9Sii9GoGsYY5Ugm7qaT2GBZVqIJL5Vg=;
	b=OvXrFtiwL0sLHhYD/qqHmA2s++xvn5CV58bMpfTOpXXSLNwu/KCJHg//GhjOz6TAmW9a/TWW9
	/q3LdhZVMhj4vQo+XcCPnPtBEqWFeM7PO03JiOxbnt4V62ZIpdKB5vrqNkUpqRGQF6kOliK+WhO
	8rTAjTDkjNtLaA9WDzFgMss=
Received: from frasgout.his.huawei.com (unknown [172.18.146.37])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4bt57y47cGzN1Ch;
	Thu, 31 Jul 2025 18:35:26 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt54n3cCmz6HJgQ;
	Thu, 31 Jul 2025 18:32:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 01F1A1400DB;
	Thu, 31 Jul 2025 18:36:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 12:36:55 +0200
Date: Thu, 31 Jul 2025 11:36:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 38/38] coco: guest: arm64: Add support for
 fetching device info
Message-ID: <20250731113653.000000cd@huawei.com>
In-Reply-To: <20250728135216.48084-39-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-39-aneesh.kumar@kernel.org>
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

On Mon, 28 Jul 2025 19:22:15 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> RSI_RDEV_GET_INFO returns different digest hash values, which can be
> compared with host cached values to ensure the host didn't tamper with
> the cached data.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Hi Aneesh

A few comments on this one

Jonathan

> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
> index 6222b10964ee..a1bb225adb4c 100644
> --- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
> @@ -6,6 +6,7 @@
>  #include <linux/pci.h>
>  #include <linux/mem_encrypt.h>
>  #include <asm/rsi_cmds.h>
> +#include <crypto/hash.h>
>  
>  #include "rsi-da.h"
>  
> @@ -186,11 +187,102 @@ rsi_rdev_get_measurements(struct pci_dev *pdev, unsigned long vdev_id,
>  	return RSI_SUCCESS;
>  }
>  
> +static int verify_digests(struct cca_guest_dsc *dsm)
> +{
> +	int i;
> +	int ret;
> +	u8 digest[SHA512_DIGEST_SIZE];
> +	int sdesc_size;
> +	size_t digest_size;
> +	char *hash_alg_name;
> +	struct shash_desc *shash;
> +	struct crypto_shash *alg;
> +	struct pci_dev *pdev = dsm->pci.tsm.pdev;
> +	struct {
> +		uint8_t *report;
> +		size_t size;
> +		uint8_t *digest;
> +	} reports[] = {
> +		{
> +			dsm->interface_report,
> +			dsm->interface_report_size,
> +			dsm->dev_info.report_digest
> +		},
> +		{
> +			dsm->certificate,
> +			dsm->certificate_size,
> +			dsm->dev_info.cert_digest
> +		},
> +		{
> +			dsm->measurements,
> +			dsm->measurements_size,
> +			dsm->dev_info.meas_digest
> +		}
> +	};
> +
> +
> +	if (dsm->dev_info.hash_algo == RSI_HASH_SHA_256) {

This to me smells like a place that will need switch sooner or
later, maybe just do it now.

> +		hash_alg_name = "sha256";
> +		digest_size = SHA256_DIGEST_SIZE;
> +	} else if (dsm->dev_info.hash_algo == RSI_HASH_SHA_512) {
> +		hash_alg_name = "sha512";
> +		digest_size = SHA512_DIGEST_SIZE;
> +	} else {
> +		pci_err(pdev, "unknown realm hash algorithm!\n");
> +		ret = -EINVAL;

return -EINVAL;

> +		goto err_out;
> +	}
> +
> +	alg = crypto_alloc_shash(hash_alg_name, 0, 0);
As below - I'd spin a DEFINE_FREE() for this to simplify error
paths in here and remove the labels that had me confused briefly.

> +	if (IS_ERR(alg)) {
> +		pci_err(pdev, "cannot allocate %s\n", hash_alg_name);
> +		return PTR_ERR(alg);
> +	}
> +
> +	sdesc_size = sizeof(struct shash_desc) + crypto_shash_descsize(alg);

Not common in crypto so perhaps just leave this as you have it.

	sdesc_size = struct_size(struct shash_dec, __ctx, crypto_shash_desc_size(alg));

is more informative on what is going on here.


> +	shash = kzalloc(sdesc_size, GFP_KERNEL);
> +	if (!shash) {
> +		pci_err(pdev, "cannot allocate sdesc\n");
> +		ret = -ENOMEM;
> +		goto err_free_shash;
> +	}
> +	shash->tfm = alg;
> +
> +	for (i = 0; i < ARRAY_SIZE(reports); i++) {
> +		ret = crypto_shash_digest(shash, reports[i].report,
> +					  reports[i].size, digest);

To me a bit marginal on whether this loop and the structures above
are beneficial over straight line code.

> +		if (ret) {
> +			pci_err(pdev, "failed to compute digest, %d\n", ret);
> +			goto err_free_sdesc;
> +		}
> +
> +		if (memcmp(reports[i].digest, digest, digest_size)) {
> +			pci_err(pdev, "invalid digest\n");
> +			ret = -EINVAL;
> +			goto err_free_sdesc;
> +		}
> +	}
> +
> +	kfree(shash);
> +	crypto_free_shash(alg);
> +
> +	pci_info(pdev, "Successfully verified the digests\n");

debug.

> +	return 0;
> +
> +err_free_sdesc:
I'd tweak these labels if you keep them. This isn't freeing the sdesc.

> +	kfree(shash);
Looks perfect for some __free() magic dust.
> +err_free_shash:
> +	crypto_free_shash(alg);

DEFINE_FREE() needed for this but looks pretty uncontroversial.

> +err_out:
As below. I'd not do this.

> +	return ret;
> +}
> +
>  int rsi_device_lock(struct pci_dev *pdev)
>  {
>  	unsigned long ret;
>  	unsigned long tdisp_version;
>  	struct rsi_device_measurements_params *rsi_dev_meas;
> +	struct rsi_device_info *dev_info;
>  	struct cca_guest_dsc *dsm = to_cca_guest_dsc(pdev);
>  	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
>  		PCI_DEVID(pdev->bus->number, pdev->devfn);
> @@ -252,8 +344,44 @@ int rsi_device_lock(struct pci_dev *pdev)
>  		return -EIO;
>  	}
>  
> +	/* RMM expects sizeof(dev_info) (512 bytes) aligned address */
> +	dev_info = kmalloc(sizeof(*dev_info), GFP_KERNEL);

Use a __free(kfree) here (and direct returns on errors) given it's freed
in all paths and we don't care if it is freed before or after verifying the digests.

I'm being slow today, but what in that enforces the alignment?  I guess
it's that the structure happens to be big enough that it happens naturally?

I'd allocate max(512, sizeof(*dev_info)) to make it explicitly the case.

> +	if (!dev_info) {
> +		ret = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	ret = rsi_rdev_get_info(vdev_id, dsm->instance_id, virt_to_phys(dev_info));
> +	if (ret != RSI_SUCCESS) {
> +		pci_err(pdev, "failed to get device digests (%lu)\n", ret);
> +		ret = -EIO;
> +		kfree(dev_info);
> +		goto err_out;
> +	}
> +
> +	dsm->dev_info.attest_type   = dev_info->attest_type;
> +	dsm->dev_info.cert_id       = dev_info->cert_id;
> +	dsm->dev_info.hash_algo     = dev_info->hash_algo;
> +	memcpy(dsm->dev_info.cert_digest, dev_info->cert_digest, SHA512_DIGEST_SIZE);
> +	memcpy(dsm->dev_info.meas_digest, dev_info->meas_digest, SHA512_DIGEST_SIZE);
> +	memcpy(dsm->dev_info.report_digest, dev_info->report_digest, SHA512_DIGEST_SIZE);
> +

Can't you memcpy the whole thing in one go?

> +	kfree(dev_info);
> +	/*
> +	 * Verify that the digests of the provided reports match with the
> +	 * digests from RMM
> +	 */
> +	ret = verify_digests(dsm);
> +	if (ret) {
> +		pci_err(pdev, "device digest validation failed (%ld)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +err_out:
I'll always grumble about these.  To me it always makes the code
less readable. Some others disagree though ;( 
>  	return ret;
>  }
> +

Looks like this should have been in an earlier patch.

>  static inline unsigned long rsi_rdev_start(struct pci_dev *pdev,
>  					   unsigned long vdev_id, unsigned long inst_id)
>  {
> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
> index f26156d9be81..e8953b8e85a3 100644
> --- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
> @@ -10,6 +10,7 @@
>  #include <linux/pci-tsm.h>
>  #include <asm/rsi_smc.h>
>  #include <asm/rhi.h>
> +#include <crypto/sha2.h>
>  
>  struct pci_tdisp_device_interface_report {
>  	u16 interface_info;
> @@ -33,6 +34,17 @@ struct pci_tdisp_mmio_range {
>  #define TSM_INTF_REPORT_MMIO_RESERVED		GENMASK(15, 4)
>  #define TSM_INTF_REPORT_MMIO_RANGE_ID		GENMASK(31, 16)
>  
> +struct dsm_device_info {
> +	u64 flags;
> +	u64 attest_type;
> +	u64 cert_id;
> +	u64 hash_algo;
> +	u8 cert_digest[SHA512_DIGEST_SIZE];
> +	u8 meas_digest[SHA512_DIGEST_SIZE];
> +	u8 report_digest[SHA512_DIGEST_SIZE];
> +};
> +

One probably enough.

> +
>  struct cca_guest_dsc {
>  	struct pci_tsm_pf0 pci;
>  	unsigned long instance_id;
> @@ -42,6 +54,7 @@ struct cca_guest_dsc {
>  	int certificate_size;
>  	void *measurements;
>  	int measurements_size;
> +	struct dsm_device_info dev_info;
>  };
>  
>  static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)



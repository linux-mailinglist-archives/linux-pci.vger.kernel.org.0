Return-Path: <linux-pci+bounces-33188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E61DB162DF
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 16:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D3C1701F6
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 14:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB142C3265;
	Wed, 30 Jul 2025 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gU968hKq"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B082284B37;
	Wed, 30 Jul 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885953; cv=none; b=QLjD9zOwfRmsHMIrum40YQW8B8n/aPViBSqXmwbeSdg6BvqocARwjU720My5+2tiHccWox4xHgZNpihUHNvG6M5OU9533lkwif+1/0u0CWwqwaBCwjwg481FDzAcksCmVhu9RZVsyuIPQNUIrJdDJxYIBF2CH1AUNsOAs2LM39w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885953; c=relaxed/simple;
	bh=gXeaMQKhbbLV+XDhyUGbP7yFSizyKb6o3AmRd0dDE8w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/qIGim9BFo2CugGVCLnxH2tYT0CSPk9o1G8I30Fp4UipqvIfEqmkbYqwol4AeEFqWf6tCc42J9yalOJVSBKOpzCvg5kNPD5r/ZOgNsBjKNIzActkL3J/U3R8Zc+4sgtYqut9cQSNn13193+BlFgR3uGrNS82y7QsyrOEC+wyIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gU968hKq; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4937AmRvhXpOfhqlM5MINHlko1YxCrPtTXjJt0WkGfA=;
	b=gU968hKq8baK8Gq5MVmNxs/0rdDVVd3KOvY8reyJ5SqCg+iwxQOz7QY8aSz6uwLR5he/e/Psb
	kZW4UjX4fyds80AwAXS8p8upjQi/fg60bY00IQPWHwKrlHVDR1Yrx0vF8jCEx+Sf34Srk2t8pb+
	xIJ/vdQWIr2jieJHB6VEyqA=
Received: from frasgout.his.huawei.com (unknown [172.18.146.35])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4bsZQH31G9z1P6lR;
	Wed, 30 Jul 2025 22:31:03 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsZPz0vj6z6M50h;
	Wed, 30 Jul 2025 22:30:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CC161402EA;
	Wed, 30 Jul 2025 22:32:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 16:32:22 +0200
Date: Wed, 30 Jul 2025 15:32:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 25/38] cca: guest: arm64: Realm device lock
 support
Message-ID: <20250730153220.00006866@huawei.com>
In-Reply-To: <20250728135216.48084-26-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-26-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Jul 2025 19:22:02 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Writing 1 to 'tsm/lock' will initiate the TDISP lock sequence.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/arm64/include/asm/rsi_cmds.h         | 32 +++++++++++++-
>  arch/arm64/include/asm/rsi_smc.h          |  5 +++
>  drivers/virt/coco/arm-cca-guest/Makefile  |  2 +-
>  drivers/virt/coco/arm-cca-guest/arm-cca.c | 18 ++++++++
>  drivers/virt/coco/arm-cca-guest/rsi-da.c  | 52 +++++++++++++++++++++++
>  drivers/virt/coco/arm-cca-guest/rsi-da.h  |  3 +-
>  6 files changed, 108 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/virt/coco/arm-cca-guest/rsi-da.c
> 
> diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
> index d4834baeef1b..b9c4b8ff5631 100644
> --- a/arch/arm64/include/asm/rsi_cmds.h
> +++ b/arch/arm64/include/asm/rsi_cmds.h
> @@ -172,8 +172,36 @@ static inline int rsi_features(unsigned long index, unsigned long *out)
>  
>  	arm_smccc_1_1_invoke(SMC_RSI_FEATURES, index, &res);
>  
> -	if (out)
> -		*out = res.a1;
> +	*out = res.a1;
> +	return res.a0;

Seems unrelated change. 

> +}
> +

> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
> new file mode 100644
> index 000000000000..097cf52ee199
> --- /dev/null
> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
> @@ -0,0 +1,52 @@

> +int rsi_device_lock(struct pci_dev *pdev)
> +{
> +	unsigned long ret;
> +	struct cca_guest_dsc *dsm = to_cca_guest_dsc(pdev);
> +	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
> +		PCI_DEVID(pdev->bus->number, pdev->devfn);
> +
> +	ret = rsi_rdev_get_instance_id(vdev_id, &dsm->instance_id);
> +	if (ret != RSI_SUCCESS) {
> +		pci_err(pdev, "failed to get the device instance id (%lu)\n", ret);
> +		return -EIO;
> +	}
> +
> +	ret = rsi_rdev_lock(pdev, vdev_id, dsm->instance_id);
> +	if (ret != RSI_SUCCESS) {
> +		pci_err(pdev, "failed to lock the device (%lu)\n", ret);
> +		return -EIO;
> +	}
> +
> +	return ret;
return 0? 

You carefully overwrite other error codes. I assume RSI_SUCCESS == 0 but
even better to just return 0 directly in the good path.

> +}
> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
> index 8a4d5f1b0263..f12430c7d792 100644
> --- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
> @@ -10,9 +10,9 @@
>  #include <linux/pci-tsm.h>
>  #include <asm/rsi_smc.h>
>  
> -

Push back to earlier patch where I comment on this.

>  struct cca_guest_dsc {
>  	struct pci_tsm_pf0 pci;
> +	unsigned long instance_id;
>  };
>  
>  static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)
> @@ -24,4 +24,5 @@ static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)
>  	return container_of(tsm, struct cca_guest_dsc, pci.tsm);
>  }
>  
> +int rsi_device_lock(struct pci_dev *pdev);
>  #endif



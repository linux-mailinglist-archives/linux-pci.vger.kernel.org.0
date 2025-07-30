Return-Path: <linux-pci+bounces-33187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C616AB162B4
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 16:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDEC1AA1A28
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 14:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874DD263F4E;
	Wed, 30 Jul 2025 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2b7kOfIR"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92D86347;
	Wed, 30 Jul 2025 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885585; cv=none; b=bVp/xZO0Qox3NpZTUr3tlUTwMBPxClfG/GOhpIKrbzfUZP9oNhkkxqGS8P1NAz77+uo2L7flFqR/mhKR0Te/2DlFLnFQiejiCQxk2IjmEP6rx3zgUOwg21ya5T37XSNwUizgt4mCz5WCCOBxwuoi49G9655MHZkB0JvxxlWWUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885585; c=relaxed/simple;
	bh=4qswW8WhvGodzqSLo2JRvYAuiu1UOUxIzGXRU9qS+IY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lxn+GGwOa18UEQahyP9Ndn7FdjitZpO46X6XL75T3LGmAMgvDnLCDjyEgTbzRTrcFRklQqs97gpFkS6gyf+AAh4N8cPLXu3zrowLqJxWDeDjpJdfIpcB2ppR/CPT7PLeI19O92rssgpdRgx0R68edOy0i4jXnxAagBDKS+Pci8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2b7kOfIR; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BXWT0pMWf57VZg5wdxBTEeaOVNrgaFHwi0FtH4lgSnc=;
	b=2b7kOfIRjuUO3oLl9LWIOsbq5YgAxnXsstMygL3CmfwW5dFbuzgBcV0pVTDKmdR4ZnnhLGejh
	sABsrwlhSBnIwT56nyXrt7h+Z8bFG8t07gECRGPRTc8opll9T92Ti+x/dW4QDYDlFSeieHtZ05V
	T13EqrN31dk0mu9IwND2UuQ=
Received: from frasgout.his.huawei.com (unknown [172.18.146.37])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4bsZH205KYzN0LH;
	Wed, 30 Jul 2025 22:24:45 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsZCt2xXqz6GD6W;
	Wed, 30 Jul 2025 22:22:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 809611402F4;
	Wed, 30 Jul 2025 22:26:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 16:26:14 +0200
Date: Wed, 30 Jul 2025 15:26:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 24/38] arm64: CCA: Register guest tsm callback
Message-ID: <20250730152613.00006693@huawei.com>
In-Reply-To: <20250728135216.48084-25-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-25-aneesh.kumar@kernel.org>
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

On Mon, 28 Jul 2025 19:22:01 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Register the TSM callback if the DA feature is supported by RSI.
> 
> Additionally, adjust the build order so that the TSM class is created
> before the arm-cca-guest driver initialization.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
See below.

> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
> index bf9ea99e2aa1..ef06c083990a 100644
> --- a/arch/arm64/kernel/rsi.c
> +++ b/arch/arm64/kernel/rsi.c
> @@ -15,6 +15,7 @@
>  #include <asm/rsi.h>
>  
>  static struct realm_config config;
> +static unsigned long rsi_feat_reg0;
>  
>  unsigned long prot_ns_shared;
>  EXPORT_SYMBOL(prot_ns_shared);
> @@ -22,6 +23,12 @@ EXPORT_SYMBOL(prot_ns_shared);
>  DEFINE_STATIC_KEY_FALSE_RO(rsi_present);
>  EXPORT_SYMBOL(rsi_present);
>  
> +bool rsi_has_da_feature(void)
> +{
> +	return !!u64_get_bits(rsi_feat_reg0, RSI_FEATURE_REGISTER_0_DA);

!! not needed.

> +}
> +EXPORT_SYMBOL_GPL(rsi_has_da_feature);


> diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
> index 547fc2c79f7d..3adbbd67e06e 100644
> --- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
> @@ -1,6 +1,6 @@

>  static int cca_guest_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -200,11 +256,22 @@ static int cca_guest_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  
>  	ret = tsm_report_register(&arm_cca_tsm_report_ops, NULL);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		pr_err("Error %d registering with TSM\n", ret);
> +		goto err_out;
> +	}
>  
>  	ret = devm_add_action_or_reset(&pdev->dev, unregister_cca_tsm_report, NULL);
> +	if (ret < 0) {
> +		pr_err("Error %d registering devm action\n", ret);
> +		unregister_cca_tsm_report(NULL);
> +		goto err_out;
> +	}
> +
> +	if (rsi_has_da_feature())
> +		ret = cca_tsm_register(pdev);
Why do we not need to call unregister_cca_tsm_report()
if this fails?

>  
> +err_out:
I'd just return above.

>  	return ret;
>  }
>  
> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
> new file mode 100644
> index 000000000000..8a4d5f1b0263
> --- /dev/null
> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 ARM Ltd.
> + */
> +
> +#ifndef RSI_DA_H_
> +#define RSI_DA_H_
> +
> +#include <linux/pci.h>
> +#include <linux/pci-tsm.h>
> +#include <asm/rsi_smc.h>
> +
One blank line probably enough.
> +
> +struct cca_guest_dsc {
> +	struct pci_tsm_pf0 pci;
> +};
> +
> +static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)
> +{
> +	struct pci_tsm *tsm = pdev->tsm;
> +
> +	if (!tsm)
> +		return NULL;
> +	return container_of(tsm, struct cca_guest_dsc, pci.tsm);
> +}
> +
> +#endif



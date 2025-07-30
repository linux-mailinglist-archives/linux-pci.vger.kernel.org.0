Return-Path: <linux-pci+bounces-33186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90C7B16295
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 16:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBA23B3458
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDBC2D7813;
	Wed, 30 Jul 2025 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EwFj+Caw"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B64B2D662D;
	Wed, 30 Jul 2025 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885335; cv=none; b=aJdxeoOl/4fEFK2HzPJuxA4yAUe4qQndj2qZ/HDU9G2WBREi/3R81mBNdwuM/AXJyj5Z5YrSFKePfjhRLmRfkMw5RP0T1uNWzYr3xnbtLt77giofi6cugyLJO8LvEmFfG7igFF+97WvtcIDTBgRvAwDjCA/rQ8ZzSNZ9p9FjAEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885335; c=relaxed/simple;
	bh=ziJsckLEM2I5AF2Aul78AZRLY6jD/nWj91lvuYCDLEE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsgYAPijOikGDESR+NfN52S3/M/tytfwweM+LzjcdRHtJ9G5lsjRQTLy/N7w+REnycymgnxbhgVFwjR5Y14i8rDFUPKG6ITfWuOA0W/jyJ0rlgK/HBFwYEnC4b/AQHWFZU1nbR+drS5p9+SkLV5jqlPypyHZBrQy6AWP7CkA7jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EwFj+Caw; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=X2ji885GQe0L7ZN7L9kgbnFKWFRnTG3aqtsrjn70EdE=;
	b=EwFj+CawQ52xOcx6jjmnB0b9ahvO51+oeQdA6FHqqKwEqF48HlteK7txDeghYVBHUvTt/WPKt
	0NxGUgQa33HwPyjmNjKIypKDP3tB39n4cnkea6X/08zsJ84T2niDBZvwpYI771/vwXsBEqbKUAZ
	ZIzI55FyQ+UQwLwxXR8VkQ0=
Received: from frasgout.his.huawei.com (unknown [172.18.146.35])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4bsZBD6bqqzN04T;
	Wed, 30 Jul 2025 22:20:36 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsZB62rbBz6M4Wk;
	Wed, 30 Jul 2025 22:20:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6EC5314038F;
	Wed, 30 Jul 2025 22:22:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 16:22:05 +0200
Date: Wed, 30 Jul 2025 15:22:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 23/38] coco: guest: arm64: Update arm CCA guest
 driver
Message-ID: <20250730152204.00006f79@huawei.com>
In-Reply-To: <20250728135216.48084-24-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-24-aneesh.kumar@kernel.org>
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

On Mon, 28 Jul 2025 19:22:00 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> This patch includes renaming changes to simplify the registration of a
> TSM backend in the next patch. There are no functional changes in this
> update.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

> index 0c9ea24a200c..547fc2c79f7d 100644
> --- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c

> +static int cca_guest_probe(struct platform_device *pdev)
...
> +	ret = devm_add_action_or_reset(&pdev->dev, unregister_cca_tsm_report, NULL);
>  
> -/**
> - * arm_cca_guest_exit - unregister with the Trusted Security Module (TSM)
> - * interface.
> - */
> -static void __exit arm_cca_guest_exit(void)
> -{
> -	tsm_report_unregister(&arm_cca_tsm_ops);
> +	return ret;

	return devm_add_action_or_reset()

Mind you, Jason probably won't like this ;)
>  }


>  MODULE_AUTHOR("Sami Mujawar <sami.mujawar@arm.com>");
> -MODULE_DESCRIPTION("Arm CCA Guest TSM Driver");
> +MODULE_DESCRIPTION("Arm CCA Guest TSM driver");

Is this D/d worth the noise?

>  MODULE_LICENSE("GPL");



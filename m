Return-Path: <linux-pci+bounces-33134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E73B151D9
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 19:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25198544A17
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227EE294A02;
	Tue, 29 Jul 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MVY3Xv0N"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE69286897;
	Tue, 29 Jul 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753809059; cv=none; b=e6QB3zMr1cWYP2OTXvPVz5CvRjwDzSxYe0ek2mlQN1/ZSu5MyOIH9xmy3kiv/Fo+Qc5n8/ELqtWtO7ngS6+eH4LcMSP+h9xf01z7ul7YePkV1z7CRreHhzyOwxDX8gDh//EoeYPKoUjgz03FPcTDQU77uHybps5pZxA+feZF+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753809059; c=relaxed/simple;
	bh=lpj8yln12s6tF/HAtx1l3MJ0jfxZCiy7T6r3KTDjbuM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V50qWfQD4AQxuZoke56eyWIX241tHGeN4K6hqBigj1S42RAiekh5vJYn2Mxb+yYFMbbJBqxAMZtIcPg7YgAdV226jJL2kbVuVaBkl9MusYHINK8FrXrvG1pD+8+cmayRRAdIHEa1vCn30sMKpHRE/MEGlIDIVx+zp+8pN4DxVQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MVY3Xv0N; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ubaFSY6OLb5tYu8oo6HDrctpmXTKZt8bDey8GhnaWek=;
	b=MVY3Xv0NauhEezwk1r2T9VQzMDQ7pkmVixQ/JOOeOw5Zzyd0g3xXLZuddEZ7yRlsM3ZNpih7m
	X5aOmOOUxJNWlcttNNzZPLxAb4z6Y1z5eoZPe0itmovSwBegyj+ToZR889anwjAQunD44Ew5EXM
	DrVcSW/X+bN6DbixPJ0znF4=
Received: from frasgout.his.huawei.com (unknown [172.18.146.37])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4bs1zY05KHz1P6lF;
	Wed, 30 Jul 2025 01:09:28 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bs1wG0DdBz6L4yZ;
	Wed, 30 Jul 2025 01:06:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9685F1402EA;
	Wed, 30 Jul 2025 01:10:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Jul
 2025 19:10:47 +0200
Date: Tue, 29 Jul 2025 18:10:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm
 platform device
Message-ID: <20250729181045.0000100b@huawei.com>
In-Reply-To: <20250728135216.48084-12-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-12-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Jul 2025 19:21:48 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Register a platform device if the CCA DA feature is supported.
> A driver for this platform device will further drive the CCA DA workflow.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Few trivial things

> diff --git a/arch/arm64/kvm/rme.c b/arch/arm64/kvm/rme.c
> index ec8093ec2da3..d1c147aba2ed 100644
> --- a/arch/arm64/kvm/rme.c
> +++ b/arch/arm64/kvm/rme.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/kvm_host.h>
> +#include <linux/platform_device.h>
>  
>  #include <asm/kvm_emulate.h>
>  #include <asm/kvm_mmu.h>
> @@ -1724,6 +1725,18 @@ int kvm_init_realm_vm(struct kvm *kvm)
>  	return 0;
>  }
>  
> +static struct platform_device cca_host_dev = {
Hmm. Greg is getting increasingly (and correctly in my view) grumpy with
platform devices being registered with no underlying resources etc as glue
layers.  Maybe some of that will come later. 
> +	.name = RMI_DEV_NAME,
> +	.id = PLATFORM_DEVID_NONE

Add trailing comma. More than possible something else will be added after this.

> +};
> +
> +static void rmm_tsm_init(void)
> +{
> +	if (!platform_device_register(&cca_host_dev))
> +		pr_info("CCA host DA platform device initialized.\n");

Noisy as we should be able to tell that in a bunch of other ways.

> +
Excess blank line.
> +}



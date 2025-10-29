Return-Path: <linux-pci+bounces-39685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F2EC1C396
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FFC3509576
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AC7347FF9;
	Wed, 29 Oct 2025 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SXRlpokc"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71163446B5;
	Wed, 29 Oct 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755966; cv=none; b=bDXXkQE4FtKUdfp5tALFX15uyV0eJMNu0fcv+OK/u6kNqZSO8WPRqd73QSL0lLJ4pIWsPhRS5TATGo1e7hwSjogGIqo3c5l1LtQnIvPYsXsyjP2tS/P4dR+X4smww6snmWkGDvGomwx6DnMxZqeOvx2OOoHQAZGdJt6dKKWeDts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755966; c=relaxed/simple;
	bh=R/XBmN72AWlHH+5TUzfXRncpX7TfMzhwtGlEAzMthFM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTyHyhjxdLZBZJnDSBNTHkCDRkyOHTnuGMhmdnepqGrH1Zv+x+r5yM8tFLfSyLl8VA0nJOXhq/Z2JiZ76G+0vQPSU/xM8pLlzjfKws4IqqilSeOyjz8D53W4sPQuG3+3XJlQEsKVZRSWi1Pz2amjMGhAG7STAur8E9/xJB3ELj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SXRlpokc; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gDpScrLfjAz7w+zkzftTI0/uhsgvu01n2ST4dvnPHU8=;
	b=SXRlpokc2MEHJiX0Rtds4jw/vMLytQ6GUp3bv0CSgY2ffj7vjFrxeD2BA6gMXiBHY+hqdikFO
	U/dxGGlQrxQffWcY8kCK4IK6NWsYFhptAC9zTfmftGLvwFXSbM9OXD9ZJy3UaxeM6pKmwagH144
	oG/gDSdIwlvCCCrP0HS53+g=
Received: from frasgout.his.huawei.com (unknown [172.18.146.36])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cxXy03dZXz1P6jy;
	Thu, 30 Oct 2025 00:39:04 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cxXw24PPRz6L4sK;
	Thu, 30 Oct 2025 00:37:22 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FABB1401DC;
	Thu, 30 Oct 2025 00:39:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 16:39:08 +0000
Date: Wed, 29 Oct 2025 16:39:06 +0000
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
Subject: Re: [PATCH RESEND v2 01/12] KVM: arm64: RMI: Export
 kvm_has_da_feature
Message-ID: <20251029163906.000041e2@huawei.com>
In-Reply-To: <20251027095602.1154418-2-aneesh.kumar@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
	<20251027095602.1154418-2-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 27 Oct 2025 15:25:51 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

Hi Aneesh,

Great to see this support - this review might be a little superficial as
I think it's first time I've looked at this and I'll be getting my head around
it whilst reviewing.

Small process thing:
Always include a stand alone description in here.  Some git clients
don't put the patch title near the commit text. Add something like

Export kvm_has_da_feature() for use in later patches.

> This will be used in later patches
Patch title made me think this was exporting something that already existed.
Probably better to say  Add kvm_has_da_feature() helper for use in later patches
or something like that.

> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_rmi.h | 1 +
>  arch/arm64/include/asm/rmi_smc.h | 1 +
>  arch/arm64/kvm/rmi.c             | 6 ++++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_rmi.h b/arch/arm64/include/asm/kvm_rmi.h
> index 1b2cdaac6c50..a967061af6ed 100644
> --- a/arch/arm64/include/asm/kvm_rmi.h
> +++ b/arch/arm64/include/asm/kvm_rmi.h
> @@ -90,6 +90,7 @@ u32 kvm_realm_ipa_limit(void);
>  u32 kvm_realm_vgic_nr_lr(void);
>  u8 kvm_realm_max_pmu_counters(void);
>  unsigned int kvm_realm_sve_max_vl(void);
> +bool kvm_has_da_feature(void);
>  
>  u64 kvm_realm_reset_id_aa64dfr0_el1(const struct kvm_vcpu *vcpu, u64 val);
>  
> diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
> index 1000368f1bca..2ea657a87402 100644
> --- a/arch/arm64/include/asm/rmi_smc.h
> +++ b/arch/arm64/include/asm/rmi_smc.h
> @@ -87,6 +87,7 @@ enum rmi_ripas {
>  #define RMI_FEATURE_REGISTER_0_GICV3_NUM_LRS	GENMASK(37, 34)
>  #define RMI_FEATURE_REGISTER_0_MAX_RECS_ORDER	GENMASK(41, 38)
>  #define RMI_FEATURE_REGISTER_0_Reserved		GENMASK(63, 42)
> +#define RMI_FEATURE_REGISTER_0_DA		BIT(42)

Guess you want to be updating Reserved as seems bit 42 isn't any more.

>  
>  #define RMI_REALM_PARAM_FLAG_LPA2		BIT(0)
>  #define RMI_REALM_PARAM_FLAG_SVE		BIT(1)
> diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
> index 478a73e0b35a..08f3d2362dfd 100644
> --- a/arch/arm64/kvm/rmi.c
> +++ b/arch/arm64/kvm/rmi.c
> @@ -1738,6 +1738,12 @@ int kvm_init_realm_vm(struct kvm *kvm)
>  	return 0;
>  }
>  
> +bool kvm_has_da_feature(void)
> +{
> +	return rmi_has_feature(RMI_FEATURE_REGISTER_0_DA);
> +}
> +EXPORT_SYMBOL_GPL(kvm_has_da_feature);
> +
>  void kvm_init_rmi(void)
>  {
>  	/* Only 4k page size on the host is supported */



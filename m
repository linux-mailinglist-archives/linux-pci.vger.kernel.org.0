Return-Path: <linux-pci+bounces-39413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 515F1C0CDCE
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 11:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6855C4F2976
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989A71E1DFC;
	Mon, 27 Oct 2025 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvypO9YL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036F1DE4E1;
	Mon, 27 Oct 2025 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559446; cv=none; b=M9X9t4dWyFOen0NuHXh6zxfTuU+2fVLysOC/kbZy2mXvc9Uvj/RvHw/SIskwmIl4I8FWDnnwd16sGcCCuYWau28jkBav1qfbI+5lhbZcriAYJ+tg9RK6WmN55mhx/1fKXqj//rooEIYvxaAkMKLSz76DcX1LXko6WgI9YQYEwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559446; c=relaxed/simple;
	bh=FEYyRZalr4maxs1O5gjP6c07nUsJ1QW2+RR+Es6ITdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WgNKHgX+mDrAve91Tkfu3GrA2shf9+Ui86IpGT9RpbWBLmmREfeLKL+TXbM5P5KxkmCMPX0dir2kWepVqZxmPKqoD0jEqv/1N7tY+5HpwGo7kBmxjeqp2xoF6YgAvlw4YWJ6fCr1TGC9p5bXoL9UOsUTLIkw7fBHvSC3KnTCr/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvypO9YL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9696C4CEF1;
	Mon, 27 Oct 2025 10:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761559445;
	bh=FEYyRZalr4maxs1O5gjP6c07nUsJ1QW2+RR+Es6ITdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YvypO9YLTOGII68Cfo8hyfMsCsNmD3b7glgVKpGE1svHuDNRdoqjFVCHjWGeuCXHH
	 lhWBYD2vO40TC5nn7oZPZlvgndboLeSgjAHLJp9+UofQJak0gGLY69VihVYNCMo5ph
	 MONSZFN+iMHKfV8W71hDnZ9HG+JjK6Zlr/yj6pE8qlNULcDZQ6poJ5kOKDsgv61R9L
	 RidTwdw5w1bA/fiAC4BnXa97Gog/ZGwVQL4vZFN+ZkUEwaznotUzk8bpPYGWFqZJJz
	 RvxmQqFHyFPATiX9MGf/U/Z2juImn2cEVAwuHkjZgH/EX88j42wGDvUC2gfVjM4VU4
	 OTV58vHHiul8Q==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH 01/12] KVM: arm64: RMI: Export kvm_has_da_feature
In-Reply-To: <20251027094916.1153143-1-aneesh.kumar@kernel.org>
References: <20251027094916.1153143-1-aneesh.kumar@kernel.org>
Date: Mon, 27 Oct 2025 15:33:57 +0530
Message-ID: <yq5awm4goe42.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Kindly ignore this series. The correct one can be found https://lore.kernel.org/all/20251027095602.1154418-1-aneesh.kumar@kernel.org

-aneesh

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> This will be used in later patches
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
> -- 
> 2.43.0


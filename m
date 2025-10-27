Return-Path: <linux-pci+bounces-39386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE447C0CC84
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B5374F82B2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB492F656F;
	Mon, 27 Oct 2025 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsRUe0dM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF22F49E4;
	Mon, 27 Oct 2025 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558692; cv=none; b=YcoWWmh1VQxpaBKKo9ozMBexaBmR+IDhT0rhEWTQJ5oHwalmF1sUcYfgfj7T6UJjmpND2WmHwJ1Jk4KKYZNv/FYQ0DTLv1I+CW4pzVaOQeCb+2k1PO6x4z+XCl/wjFS1VUwfOhkCSQT0Z9f2P6ghjQ8PW1ask+2xm1etYigF8iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558692; c=relaxed/simple;
	bh=sYVeDu9M+oOjuuqkIzrIaSA25SCHmjEU+UGiJsr+pIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAbPdLwNt+dyhFQKGdgaNr9WwQaH/dZ7dvEGH638RvSpixyOxoc1d3vIghZHVrd6yx4iF9WQEczYYWNgJNa83vVHfNruVvpxjKvJ88UjKJx80pOENXmjFD4vHo/HZ+LGS8T0cMAvtRJRvQjFLbE8UQkBiO5u0QE6L1dLBVaMGCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsRUe0dM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D2CC113D0;
	Mon, 27 Oct 2025 09:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761558692;
	bh=sYVeDu9M+oOjuuqkIzrIaSA25SCHmjEU+UGiJsr+pIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UsRUe0dMiHv2tAIJuwV1o9JmVOUVDmc1Ps8eMoz98fd5DYmFsmrgJfb0SbK/WHPzO
	 9cE8tf7JiM9wLwmJuWvfcZatHpcpu1QoYYdZPS5qZH74xGa7x/+dv8k/GqYirjbcMG
	 l18Q3Pk/V9vl9W1/SKttqfu4O8n/tghQim32kQ/XYzXj3UCk8w/04FFWzzkZJc7Rce
	 h9tyf4Q4K5EDKgYoPfWz8CL3Loea7N3/wXND+9GuTvAxrjtXtP/CRyBI6IgsoTi6ho
	 NMPb/nbu+g5ccOjECGIosowKmoWpP6Tg0aKtlQik+KglNlc1vlgNNJfAnP2pcxfU8D
	 905/kNEDD8tkw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH v2 03/12] coco: guest: arm64: Drop dummy RSI platform device stub
Date: Mon, 27 Oct 2025 15:19:07 +0530
Message-ID: <20251027094916.1153143-16-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027094916.1153143-1-aneesh.kumar@kernel.org>
References: <20251027094916.1153143-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SMCCC firmware driver now creates the `arm-smccc` platform device
and also creates the CCA auxiliary devices once the RSI ABI is
discovered. This makes the arch-specific arm64_create_dummy_rsi_dev()
helper redundant. Remove the arm-cca-dev platform device registration
and let the SMCCC probe manage the RSI device.

systemd match on platform:arm-cca-dev for confidential vm detection [1].
Losing the platform device registration can break that. Keeping this
removal in its own change makes it easy to revert if that regression
blocks the rollout.

[1] https://lore.kernel.org/all/4a7d84b2-2ec4-4773-a2d5-7b63d5c683cf@arm.com

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/kernel/rsi.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index 5d711942e543..1b716d18b80e 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -158,18 +158,3 @@ void __init arm64_rsi_init(void)
 
 	static_branch_enable(&rsi_present);
 }
-
-static struct platform_device rsi_dev = {
-	.name = "arm-cca-dev",
-	.id = PLATFORM_DEVID_NONE
-};
-
-static int __init arm64_create_dummy_rsi_dev(void)
-{
-	if (is_realm_world() &&
-	    platform_device_register(&rsi_dev))
-		pr_err("failed to register rsi platform device\n");
-	return 0;
-}
-
-arch_initcall(arm64_create_dummy_rsi_dev)
-- 
2.43.0



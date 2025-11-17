Return-Path: <linux-pci+bounces-41417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A76BC648EE
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B693ABBCC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE54334697;
	Mon, 17 Nov 2025 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvfAZuCq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5066C2AEF5;
	Mon, 17 Nov 2025 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388089; cv=none; b=YN3bOY05RpO6sjHQBM1/JcCgjyLoPqMviAx+nFThMUXtzBlsL/Sw0Aql5LDmRFYrQsd/wMUp5E7FPt4G+dUAczmJF/xLQzDGOMx1D2kf753h5efGLXHQZVV1YR1LV7G6+ZZ0gsiOLRe5k5L4WO1TXDvCw9KvDTbvywQFKJ4/z4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388089; c=relaxed/simple;
	bh=25Bn9luUHaEILb28FwLfgiOYmlbDL1Rt6LCuV8FfZHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJNdwqmRieGjkchnENJWTYp9fzln6GjYSEu/ZUOb57yAi77E+GpOFP32rRCnQ/M7m9pIPvy2tGxezGJeKDpg+w4YF0xr/CAq8N1AyQOqYr7ZPEf0Jj0Q8Cnretp2tm7kihu1xwH1VCtDq69haaDmXGGawdWfOoGcFFTTEGDcSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvfAZuCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48250C4CEFB;
	Mon, 17 Nov 2025 14:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763388088;
	bh=25Bn9luUHaEILb28FwLfgiOYmlbDL1Rt6LCuV8FfZHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvfAZuCqeBlalF6IWqTv9tpoZgvmmsuX4m9OBg8dZWz1wcOCHXPJIK0IMNJFHltbi
	 JjJwhGaAZA13niNoYjenKvHBHvmCPxwfZjgpWEP8Ro7XjVvXNvhbvhc+WCRpT2N0to
	 tzxODcInJIHJkeqV6mh1s8zQZgd1qg6+56x+4HNHxKOaR0zCvsqfzDbF3vrqHdVPa9
	 jazGTMJQ7Fyjfnzd6EaoPbb1pAqwHDrvXqOSFG7yT3/cE37pndzUZ78D3ug+Y1MKNE
	 IFyTmvcU0xmJEDE9WBGoqbp/rdWLvB5c3Srm2x6Xft4W+Q1bB2kNiicf4fTwTqwrXQ
	 lOEI9MeQEeSqg==
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
Subject: [PATCH v2 10/11] coco: arm64: dma: Update force_dma_unencrypted for accepted devices
Date: Mon, 17 Nov 2025 19:30:06 +0530
Message-ID: <20251117140007.122062-11-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117140007.122062-1-aneesh.kumar@kernel.org>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This change updates the DMA behavior for accepted devices by assuming
they access only private memory. Currently, the DMA API does not provide
a mechanism for allocating shared memory that can be accessed by both
the secure realm and the non-secure host.

Accepted devices are therefore expected to operate entirely within the
private memory space. As of now, there is no API in the DMA layer that
allows such devices to explicitly request shared memory allocations for
coherent data exchange with the host.

If future use cases require accepted devices to interact with shared
memory— for example, for host-device communication, we will need to
extend the DMA interface to support such allocation semantics. This
commit lays the groundwork for that by clearly defining the current
assumption and isolating the enforcement to force_dma_unencrypted.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/mem_encrypt.h |  6 +-----
 arch/arm64/mm/mem_encrypt.c          | 10 ++++++++++
 include/linux/swiotlb.h              |  5 +++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
index 314b2b52025f..d77c10cd5b79 100644
--- a/arch/arm64/include/asm/mem_encrypt.h
+++ b/arch/arm64/include/asm/mem_encrypt.h
@@ -15,14 +15,10 @@ int arm64_mem_crypt_ops_register(const struct arm64_mem_crypt_ops *ops);
 
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
+bool force_dma_unencrypted(struct device *dev);
 
 int realm_register_memory_enc_ops(void);
 
-static inline bool force_dma_unencrypted(struct device *dev)
-{
-	return is_realm_world();
-}
-
 /*
  * For Arm CCA guests, canonical addresses are "encrypted", so no changes
  * required for dma_addr_encrypted().
diff --git a/arch/arm64/mm/mem_encrypt.c b/arch/arm64/mm/mem_encrypt.c
index ee3c0ab04384..645c099fd551 100644
--- a/arch/arm64/mm/mem_encrypt.c
+++ b/arch/arm64/mm/mem_encrypt.c
@@ -17,6 +17,7 @@
 #include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/mm.h>
+#include <linux/device.h>
 
 #include <asm/mem_encrypt.h>
 
@@ -48,3 +49,12 @@ int set_memory_decrypted(unsigned long addr, int numpages)
 	return crypt_ops->decrypt(addr, numpages);
 }
 EXPORT_SYMBOL_GPL(set_memory_decrypted);
+
+bool force_dma_unencrypted(struct device *dev)
+{
+	if (device_cc_accepted(dev))
+		return false;
+
+	return is_realm_world();
+}
+EXPORT_SYMBOL_GPL(force_dma_unencrypted);
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..b27de03f2466 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -173,6 +173,11 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 
+	if (device_cc_accepted(dev)) {
+		dev_warn_once(dev, "(TIO) Disable SWIOTLB");
+		return false;
+	}
+
 	return mem && mem->force_bounce;
 }
 
-- 
2.43.0



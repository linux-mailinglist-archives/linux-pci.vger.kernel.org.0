Return-Path: <linux-pci+bounces-41416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47795C6490A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 040FF4F211C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385A0333422;
	Mon, 17 Nov 2025 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BamaMTuo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A9B2AEF5;
	Mon, 17 Nov 2025 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388082; cv=none; b=tIMCcltNnYE//ey5C3Pfp2CDwq7ld9dHbSYNLk2V6buXlQYtiFpLUIipgXkYlMXmi3qcVgm/Zhdpo0oWFJI6GoufO7H7V1nf7c6ou44KDbn27qBBzff5L8GjcCn1hGCafJmOpABl9tgJOlAB5tJJPkNGjxHPC22lIDo4kZdDjow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388082; c=relaxed/simple;
	bh=B5XujU80VCitHl868sDLkNEi4u6xgE/QMAq3p56uXoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdrk4BTymTPg4BYOh9gWnLc0z6y/3F1/+biK2LGDcxmpVWS+IqzXpzitYKy0aGEs/IA9WXf8oZAD83cTi/MdzyTyOLqIbfBqHLFCC44oRs8u5W1Yql3eFp8ygyWAYFCmL925UZCX6p2OoHy9z1akMwd2jHGBuORbGNnJWlP2TrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BamaMTuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36154C19425;
	Mon, 17 Nov 2025 14:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763388081;
	bh=B5XujU80VCitHl868sDLkNEi4u6xgE/QMAq3p56uXoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BamaMTuo+p74Jicr+te81SqW0vwT+EFTGy26KJ6EpajI7wbZj92bFfl+afOVM7h3J
	 ifVXt4PjD1AvT3OPbFq2MOVAn/W9H6QK66zPmS/I4ceaH6LXQjw3toAPhXow2y8I4R
	 agw9jxW7rLE/pOoeo7QgJjQAS56HhCJoSSVdWS/v5eBt8HY/UbSPK4kNK2w2UekMGj
	 r4yvWCUMism0V0I7WzzvnqUR6GnIPrNMzwABO6TqDe2dNw3gfDSFFfW6ZkdhpdffZE
	 c5a62bvDobXvjWA4PJ1/RPnAdf4LBPhNYzLdglH84HTU+vNFUpxAx4uUODhid6o3g7
	 Em5s5eJb+xrPQ==
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
Subject: [PATCH v2 09/11] coco: guest: arm64: Wire Realm TDISP RUN/STOP transitions into guest driver
Date: Mon, 17 Nov 2025 19:30:05 +0530
Message-ID: <20251117140007.122062-10-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117140007.122062-1-aneesh.kumar@kernel.org>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach the Arm CCA guest driver how to transition a Realm device between
RUN and STOP states. The new helpers issue the RSI START/STOP calls,
poll with CONTINUE until completion, and surface errors back to the TSM.
The PCI TSM accept/unlock paths now invoke these helpers so writing `1`
to `tsm/accept` correctly kicks off the TDISP RUN sequence and unlock
tears it back down.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/virt/coco/arm-cca-guest/arm-cca.c | 13 +++++++++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.c  |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
index e86c3ad355f8..46cc0fdefe34 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
@@ -239,9 +239,22 @@ static void cca_tsm_unlock(struct pci_tsm *tsm)
 	kfree(cca_dsc);
 }
 
+static int cca_tsm_accept(struct pci_dev *pdev)
+{
+	int ret;
+
+	ret = cca_device_verify_and_accept(pdev);
+	if (ret) {
+		pci_err(pdev, "failed to transition the device to run state (%d)\n", ret);
+		return -EIO;
+	}
+	return 0;
+}
+
 static struct pci_tsm_ops cca_devsec_pci_ops = {
 	.lock = cca_tsm_lock,
 	.unlock = cca_tsm_unlock,
+	.accept	 = cca_tsm_accept,
 };
 
 static void cca_devsec_tsm_remove(void *tsm_dev)
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
index c6b92f4ae9c5..4852a03dd17d 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
@@ -331,5 +331,10 @@ int cca_device_verify_and_accept(struct pci_dev *pdev)
 		return -EIO;
 	}
 
+	ret = rhi_vdev_set_tdi_state(pdev, RHI_DA_TDI_CONFIG_RUN);
+	if (ret) {
+		pci_err(pdev, "failed to switch the device (%u) to RUN state\n", ret);
+		return -EIO;
+	}
 	return 0;
 }
-- 
2.43.0



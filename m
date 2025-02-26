Return-Path: <linux-pci+bounces-22431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF9EA45E82
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 13:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD7416F0A7
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 12:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D084212B23;
	Wed, 26 Feb 2025 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urJwoLVk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E630419259A;
	Wed, 26 Feb 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572050; cv=none; b=b7UBpbAV/4E5I7RqqN5mEFxDPkWEk7uEBy8NppywPuWHUVwb0+Zt2pnn9dSMgtGudhWOF3kDTUIibkvliUF8jibQ4IXY06H5WZEcBVbrtcvQoUuEwuakuK+etWY9JMBFHfTfAVzIK3M7v84DGRXrr5o6+J4D/oAlKfiLV5Lp73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572050; c=relaxed/simple;
	bh=ETRpRF6zS/RqwlTVKCW9Ele7+fcfb4ScQmrOMgU3u0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Awo0Mp9ygDFATTYi8W7+siu7UaqQZ178Q6YvPtyttRKEE0e+xm4gm430B4RDtmpuqpx5Q8n0D98cNLZfJ4E8M5CZ04ivcyvkHv1XYK7UbTSiMAyLMtBN8S523aTr5ZH4oalE+9uOucKQyMV68OhMhgryUcGjmd2fcuxDKHkn/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urJwoLVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2D3C4CED6;
	Wed, 26 Feb 2025 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740572049;
	bh=ETRpRF6zS/RqwlTVKCW9Ele7+fcfb4ScQmrOMgU3u0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urJwoLVkQdJxnStXZZvyQ7+gPRG9DliysatBcfJ82MOxj7E2qvf+99ml9WJ+o0+jp
	 nJM9Wo/l+HggqH9bqqTwJesgbasSzrfrN2tUWKW9JCkNk7CHiFPRK46ki3fV1Glxuf
	 iVOVh22ESJay+qFN5ttlLjd/gwNYV/XzSTOyoSlTaLwlvzXNwUk4r8m8EzZi8Ixlvi
	 FZWU5PtHxeWwO0lUmq3LN++Dx7z33iNGP5hE5In4Mpt3qCpzez0Z/ciiEUnJakCPdf
	 yRW0O96Q0def40Qh5wxEFvlgLgGQEmbWyD/tQsn/CTWTTVmc0f/wv2xXCp9k5wxg35
	 qU9Hm+yoxmAuA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	gregkh@linuxfoundation.org,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH 6/7] tsm: Allow tsm connect ops to be used for multiple operations
Date: Wed, 26 Feb 2025 17:43:22 +0530
Message-ID: <20250226121323.577328-6-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226121323.577328-1-aneesh.kumar@kernel.org>
References: <yq5a4j0gc3fp.fsf@kernel.org>
 <20250226121323.577328-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The connect sysfs file will be used in the guest for TDISP locking and
transitioning the device to the run state.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/pci/tsm.c       | 16 +++++++---------
 include/linux/pci-tsm.h |  4 +++-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index a0deddac6767..3251dc5eeef8 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -45,7 +45,7 @@ static int pci_tsm_disconnect(struct pci_dev *pdev)
 	return 0;
 }
 
-static int pci_tsm_connect(struct pci_dev *pdev)
+static int pci_tsm_connect(struct pci_dev *pdev, int new_state)
 {
 	struct pci_tsm *pci_tsm = pdev->tsm;
 	int rc;
@@ -53,15 +53,13 @@ static int pci_tsm_connect(struct pci_dev *pdev)
 	lockdep_assert_held(&pci_tsm_rwsem);
 
 	scoped_cond_guard(mutex_intr, return -EINTR, &pci_tsm->lock) {
-		if (pci_tsm->state >= PCI_TSM_CONNECT)
-			return 0;
+
 		if (pci_tsm->state < PCI_TSM_INIT)
 			return -ENXIO;
 
-		rc = tsm_ops->connect(pdev);
+		rc = tsm_ops->connect(pdev, new_state);
 		if (rc)
 			return rc;
-		pci_tsm->state = PCI_TSM_CONNECT;
 	}
 	return 0;
 }
@@ -70,16 +68,16 @@ static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t len)
 {
 	int rc;
-	bool connect;
+	int connect;
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	rc = kstrtobool(buf, &connect);
+	rc = kstrtoint(buf, 0, &connect);
 	if (rc)
 		return rc;
 
 	scoped_cond_guard(rwsem_read_intr, return -EINTR, &pci_tsm_rwsem) {
 		if (connect)
-			rc = pci_tsm_connect(pdev);
+			rc = pci_tsm_connect(pdev, connect);
 		else
 			rc = pci_tsm_disconnect(pdev);
 		if (rc)
@@ -97,7 +95,7 @@ static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
 	scoped_cond_guard(rwsem_read_intr, return -EINTR, &pci_tsm_rwsem) {
 		if (!pdev->tsm)
 			return -ENXIO;
-		connect_status = pdev->tsm->state >= PCI_TSM_CONNECT;
+		connect_status = pdev->tsm->state;
 	}
 	return sysfs_emit(buf, "%d\n", connect_status);
 }
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 774496d7b37e..6ad2081a329d 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -19,6 +19,8 @@ enum pci_tsm_state {
 	PCI_TSM_INIT,
 	PCI_TSM_CONNECT,
 	PCI_TSM_BOUND,
+	PCI_TSM_LOCKED,
+	PCI_TSM_RUN,
 };
 
 /**
@@ -49,7 +51,7 @@ struct pci_tsm {
 struct pci_tsm_ops {
 	struct pci_dsm *(*probe)(struct pci_dev *pdev);
 	void (*remove)(struct pci_dsm *dsm);
-	int (*connect)(struct pci_dev *pdev);
+	int (*connect)(struct pci_dev *pdev, int new_state);
 	void (*disconnect)(struct pci_dev *pdev);
 	int (*bind)(struct vfio_device *vfio_dev, u32 guest_rid);
 	void (*unbind)(struct vfio_device *vfio_dev);
-- 
2.43.0



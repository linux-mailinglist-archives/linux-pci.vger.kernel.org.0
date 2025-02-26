Return-Path: <linux-pci+bounces-22432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A1FA45EA4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 13:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24693B85EB
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 12:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0BC219E86;
	Wed, 26 Feb 2025 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9vMXv3z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51640219A68;
	Wed, 26 Feb 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572054; cv=none; b=DLKEFsReQk0b7O/EhOlthAjAg+MRGbY+OgwvcANGxgdM2kgcbMz5Ib/rMIVZoKLMDVZwB54Y9DZrHnqiPLYug4mXGFqQhRyHt91czbmUmqgtQ3OgbRCiQfjAUrLYA9SSXZGO6DU0SUEqqjn6QkRGwDLo69SlM/5gDZYpXO2yHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572054; c=relaxed/simple;
	bh=X3g14IPFE/X2jaQdjdKAHuaxUnhkth6PXatSD/gyOOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HASx3It1EjJCCywmQo+C5+2173I+BwByewuOWHsxw26VCR8AY8GgNuVigrEs+n2KrJFt2EAh+FpchLhHwvlj5F3hwSbQzGJ0jqo/PtxYxbPgjB/jOVQFMMLHOFkI8fvf0mJcT56ccc4V+VWII11WVD8vJ7XlAe7V1lC8A0/gRJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9vMXv3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09656C4CEE8;
	Wed, 26 Feb 2025 12:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740572053;
	bh=X3g14IPFE/X2jaQdjdKAHuaxUnhkth6PXatSD/gyOOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9vMXv3zdEHy+LQKvlm3OoYE/OEOj3ZJv9dxEUGG4KZLYTeAqonH68gFXheqw1NU7
	 2+WIrhgdT+SX+nnesZK+g35HfNZdUu+FH55lUNuu5GdoKi3aslw6dnWONopQeUpoff
	 pscRnM9f0mVIWuy1xXx3ZWMgyzEqiPNJrO8lPzYG1+mCrtOJYneo4f4jHOTCun9UTx
	 G6PnmFAQ7cuMRJdyT14YbbiL7YMvdGkhi36kCeuXOMZjDsphcquDYPXLsyzQJpuE53
	 K15SfCPVep562O685kh6I0JFaXVHUCC5Cky5/3UdkMyjlVs/NTx5sHgpt7V3BdC74h
	 oQjWEAEXkHXfA==
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
Subject: [RFC PATCH 7/7] tsm: Add secure SPDM support
Date: Wed, 26 Feb 2025 17:43:23 +0530
Message-ID: <20250226121323.577328-7-aneesh.kumar@kernel.org>
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

Add secure doe mailbox support

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/pci/tsm.c       | 24 +++++++++++++++++++-----
 include/linux/pci-tsm.h |  1 +
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 3251dc5eeef8..cb251497ca68 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -194,12 +194,16 @@ static void __pci_tsm_init(struct pci_dev *pdev)
 		return;
 
 	mutex_init(&pci_tsm->lock);
-	pci_tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+	pci_tsm->doe_mb 	= pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
 					       PCI_DOE_PROTO_CMA);
-	pci_info(pdev, "Device security capabilities detected (%s%s%s)\n",
+	pci_tsm->doe_secure_mb 	= pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+					       PCI_DOE_PROTO_SSESSION);
+
+	pci_info(pdev, "Device security capabilities detected (%s%s%s%s)\n",
 		 pdev->ide_cap ? " ide" : "",
 		 tee_cap ? " tee" : "",
-		 pci_tsm->doe_mb ? " doe" : "");
+		 pci_tsm->doe_mb ? " doe" : "",
+		 pci_tsm->doe_secure_mb ? " secure-doe" : "");
 
 	pci_tsm->state = PCI_TSM_INIT;
 	pci_tsm->dsm = no_free_ptr(dsm);
@@ -277,10 +281,20 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
 			 const void *req, size_t req_sz, void *resp,
 			 size_t resp_sz)
 {
-	if (!pdev->tsm || !pdev->tsm->doe_mb)
+	struct pci_doe_mb *mb = NULL;
+
+	if (!pdev->tsm)
+		return -ENXIO;
+
+	if (type == PCI_DOE_PROTO_CMA)
+		mb = pdev->tsm->doe_mb;
+	else if (type == PCI_DOE_PROTO_SSESSION)
+		mb = pdev->tsm->doe_secure_mb;
+
+	if (!mb)
 		return -ENXIO;
 
-	return pci_doe(pdev->tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req,
+	return pci_doe(mb, PCI_VENDOR_ID_PCI_SIG, type, req,
 		       req_sz, resp, resp_sz);
 }
 EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 6ad2081a329d..815da9c3fc50 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -34,6 +34,7 @@ struct pci_tsm {
 	enum pci_tsm_state state;
 	struct mutex lock;
 	struct pci_doe_mb *doe_mb;
+	struct pci_doe_mb *doe_secure_mb;
 	struct pci_dsm *dsm;
 };
 
-- 
2.43.0



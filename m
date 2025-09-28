Return-Path: <linux-pci+bounces-37164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E80BA6936
	for <lists+linux-pci@lfdr.de>; Sun, 28 Sep 2025 08:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28283AE7BE
	for <lists+linux-pci@lfdr.de>; Sun, 28 Sep 2025 06:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F73C29B8D0;
	Sun, 28 Sep 2025 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKkk89gD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7141029AB1D;
	Sun, 28 Sep 2025 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759041620; cv=none; b=LmjZ0vgeTqosk4ijQqTpOmHN4efBRSrbMcxb+M4MRTXzq7e1rcf1MftrsODdrwm36YGtJQlJrA+0Q39RunLWNEX+4eJueawLqi/Tb7CLRNwzZcN6Lhg9YqHjyjC1BDS5/QU/iYNZdlJRBJwcM2ZEivBl8cVzaB6RAgFAVI1xmX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759041620; c=relaxed/simple;
	bh=qsbwJQQL7BDBZsPlfUXxgitah970J+393ry2NZtZapg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mMpQcHA8qEaxxMFRFGHe9j790NDXLIgz9jjKb/Wc9qb9YNmd643HC6faLhaTM/vdcPLsfbwDQXVPsHEFftgnXK5LjQLBLpoSA8Agvyg2Nkvelz4hV8wFp/nyeLQG2R3cRiR/ESBRqGLSDNDBV/7IcMn+pODfpREMSFiHshWMxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKkk89gD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759041619; x=1790577619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qsbwJQQL7BDBZsPlfUXxgitah970J+393ry2NZtZapg=;
  b=XKkk89gDguWO6rxGSEABKKLPmJX+5ZW865WCCz6zqPA/W+eElh24oV3T
   JxBsZWrEtQRm3rrId61DlLZecOz+Sbmh6ICoCZQCwfNNrv7UfPGQLmXmk
   uDeexY0D3BJ9SJl1qRxWQkxZVoaDp8EwpIX1MiRtkuL7EuS+afiBgIL94
   7uv7Ugx9GsBbN+CyI7gLGzAllwJor5CdFLphhuwaeQJ48LS2nFjDZdW5z
   pw4JiRwYZe/mICLlDHvD0m2skP5vFSalnsn1/rfbLidUCulCEqpXfIutT
   xf8+uLCgoEqG1GFMxuWfbufp68oTtsjlyW25tsbj7glFed9A5gOg0ctHE
   A==;
X-CSE-ConnectionGUID: fZ/4rpKsR327BCPyhD5Y5Q==
X-CSE-MsgGUID: Hay836/rS827KbdkvRwrxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61228531"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61228531"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 23:40:18 -0700
X-CSE-ConnectionGUID: JkkdvK2bRP6cnrkTikKkXg==
X-CSE-MsgGUID: 9vMjIjxQSc2Cp7nMKHeR8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="177088848"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 27 Sep 2025 23:40:15 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dan.j.williams@intel.com
Cc: yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	aneesh.kumar@kernel.org,
	bhelgaas@google.com,
	aik@amd.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI/IDE: Add/export mini helpers for platform TSM drivers
Date: Sun, 28 Sep 2025 14:27:54 +0800
Message-Id: <20250928062756.2188329-2-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250928062756.2188329-1-yilun.xu@linux.intel.com>
References: <20250928062756.2188329-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These mini helpers are mainly for platform TSM drivers to setup root
port side configuration. Root port side IDE settings may require
platform specific firmware calls (e.g. TDX Connect [1]) so could not use
pci_ide_stream_setup(), but may still share these mini helpers cause
they also refer to definitions in IDE specification.

[1]: https://lore.kernel.org/linux-coco/20250919142237.418648-28-dan.j.williams@intel.com/

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 include/linux/pci-ide.h | 6 ++++++
 drivers/pci/ide.c       | 8 +++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index a30f9460b04a..5adbd8b81f65 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -6,6 +6,11 @@
 #ifndef __PCI_IDE_H__
 #define __PCI_IDE_H__
 
+#define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
+	(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
+	 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, (base)) | \
+	 FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, (domain)))
+
 enum pci_ide_partner_select {
 	PCI_IDE_EP,
 	PCI_IDE_RP,
@@ -61,6 +66,7 @@ struct pci_ide {
 	struct tsm_dev *tsm_dev;
 };
 
+int pci_ide_domain(struct pci_dev *pdev);
 struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide);
 struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
 void pci_ide_stream_free(struct pci_ide *ide);
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 10603f2d2319..7633b8e52399 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -345,12 +345,13 @@ void pci_ide_stream_unregister(struct pci_ide *ide)
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_unregister);
 
-static int pci_ide_domain(struct pci_dev *pdev)
+int pci_ide_domain(struct pci_dev *pdev)
 {
 	if (pdev->fm_enabled)
 		return pci_domain_nr(pdev->bus);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_ide_domain);
 
 struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide)
 {
@@ -420,10 +421,7 @@ void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
 	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
 
-	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
-	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
-	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
-
+	val = PREP_PCI_IDE_SEL_RID_2(settings->rid_start, pci_ide_domain(pdev));
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
 
 	/*
-- 
2.25.1



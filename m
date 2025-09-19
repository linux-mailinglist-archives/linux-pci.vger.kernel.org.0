Return-Path: <linux-pci+bounces-36501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE634B89E42
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2341582662
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18168314D39;
	Fri, 19 Sep 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqxPQGZf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337A314B89
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291771; cv=none; b=lFgSipGegBgFmJ+vXhwmLooUJ6955GSKrWDftGWG2oE5OJSuCICtnTeBALE05VHcIvx21fFlHs4S89oxv0XrQiI46r1zepXX/VHF8Th7Z+IbnF0z0GaQoh05tpjbrQVaJRigrYLPvSWPvNpWcZ/nf6Tb/xi99ckqmE398TM0LmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291771; c=relaxed/simple;
	bh=CCNFXsE0RIVS86QkMcedA/aTg7vD86GJNyGOz/BbTws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEyHeVpt3tGS1a9/r8dQHF5ULMiy5N41x3r07p2XPwnyLbT+yC3uWl0PucakX2HYqJdYn9uAJSCfxgaO3r+F3ICbYB+OyhO3UMPqC1/62j5AhE4fDxBT2JV4GqPxkaEjqw2NLbRCXXURQKnmzwMJBj/Rzn48XuM4s6N+Jd/iAeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqxPQGZf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291769; x=1789827769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CCNFXsE0RIVS86QkMcedA/aTg7vD86GJNyGOz/BbTws=;
  b=ZqxPQGZf2MNVZLRGE6IGBMuAllEi4D+XCx04VmdnY3y9F7kD+rZDck4L
   +BZbx7iZqkxEJhKA68NO2ja7TKkR96FBIYhSldZxKi3PJlDyloXG+yZJT
   m/v7hs4cKWqMF2by3r9biahqCEArFTFIo9h7+DlNaysCJvLc0gRDK/bdH
   mi2V50IBPdU2EEho8ym3nYYVb8oaj2nKoymfsPjvs+2poPFPH+P3KIBup
   UQSLG8Tng5iCrBN1ZKaVn4suVI4VA7EYhT/pxiyBuimVMQ54XcJxpivdH
   AF1CkAa5iXvRfrhJgNcbLInFZAZU0n4/bvfYLvzST0oEilZNaqHEfE/Ns
   w==;
X-CSE-ConnectionGUID: 4dJbALjERb6gq5TZ02kyvA==
X-CSE-MsgGUID: BV9EKwDdQmaeS0abXVxwng==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750566"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750566"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:40 -0700
X-CSE-ConnectionGUID: tJSaQHV1TXa2zWIAwX3+4w==
X-CSE-MsgGUID: ouxQZ9iPTh+HE/G7GdIuBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655053"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 20/27] coco/tdx-host: Add connect()/disconnect() handlers prototype
Date: Fri, 19 Sep 2025 07:22:29 -0700
Message-ID: <20250919142237.418648-21-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919142237.418648-1-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Yilun <yilun.xu@linux.intel.com>

Add basic skeleton for connect()/disconnect() handlers. The major steps
are SPDM setup first and then IDE selective stream setup.

No detailed TDX Connect implementation.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/virt/coco/tdx-host/tdx-host.c | 49 ++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index f5a869443b15..0d052a1acf62 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -104,13 +104,60 @@ static int __maybe_unused tdx_spdm_msg_exchange(struct tdx_link *tlink,
 	return ret;
 }
 
+static void tdx_spdm_session_teardown(struct tdx_link *tlink)
+{
+}
+
+static int tdx_spdm_session_setup(struct tdx_link *tlink)
+{
+	return -EOPNOTSUPP;
+}
+
+static void tdx_ide_stream_teardown(struct tdx_link *tlink)
+{
+}
+
+static int tdx_ide_stream_setup(struct tdx_link *tlink)
+{
+	return -EOPNOTSUPP;
+}
+
+static void __tdx_link_disconnect(struct tdx_link *tlink)
+{
+	tdx_ide_stream_teardown(tlink);
+	tdx_spdm_session_teardown(tlink);
+}
+
+DEFINE_FREE(__tdx_link_disconnect, struct tdx_link *, if (_T) __tdx_link_disconnect(_T))
+
 static int tdx_link_connect(struct pci_dev *pdev)
 {
-	return -ENXIO;
+	struct tdx_link *tlink = to_tdx_link(pdev->tsm);
+	int ret;
+
+	struct tdx_link *__tlink __free(__tdx_link_disconnect) = tlink;
+	ret = tdx_spdm_session_setup(tlink);
+	if (ret) {
+		pci_err(pdev, "fail to setup spdm session\n");
+		return ret;
+	}
+
+	ret = tdx_ide_stream_setup(tlink);
+	if (ret) {
+		pci_err(pdev, "fail to setup ide stream\n");
+		return ret;
+	}
+
+	tlink = no_free_ptr(__tlink);
+
+	return 0;
 }
 
 static void tdx_link_disconnect(struct pci_dev *pdev)
 {
+	struct tdx_link *tlink = to_tdx_link(pdev->tsm);
+
+	__tdx_link_disconnect(tlink);
 }
 
 static struct pci_tsm_ops tdx_link_ops;
-- 
2.51.0



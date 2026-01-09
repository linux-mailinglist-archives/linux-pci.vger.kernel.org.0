Return-Path: <linux-pci+bounces-44322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A151D0733D
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 06:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAF42300C9B5
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 05:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201CD1F1534;
	Fri,  9 Jan 2026 05:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nS+CAAEx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E041D88D7;
	Fri,  9 Jan 2026 05:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767936583; cv=none; b=HCQGmXg6nzwjSmKEl47Hj4P3T5uU8r16E8tihMM+Eq0CRl7QRwH+ad2vS8ZiMA6bftNF/o1wPefYc+C/g4X2Z+No2jX2LY4tN9ExlFJNsZmLygRI/UTNeM6bAaJRkWuxB63paZAY3+HELHUwmFo2sgsWkZueUmGWneoup0XU2s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767936583; c=relaxed/simple;
	bh=+0w56qn2Ot2YzxrPBPeB7CCk+RvW3j6N2Smby0YTKdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mtu7SU9BhAIxfmCi2SvaFUhwLcbnv59T8XA6sv1xodRa37fngEOY/UGBswME7+kP9NlIvJENtqKOjY+wvmoJVf+3tBgUFa8RzB+opI8CukyxVlFo2M/QSDys+7A9EmOi9wqIveFdXcDs6Rj6mHEbS7+Cn8JRy3sZ6ip4mDBDsWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nS+CAAEx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767936582; x=1799472582;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+0w56qn2Ot2YzxrPBPeB7CCk+RvW3j6N2Smby0YTKdw=;
  b=nS+CAAEx5v6jr1YSg3xTvNcNVmJVE9EZNB0zYu3MGILDe59iSgI4OeCw
   yHVYNzamEH/m7fIwLBFt64pS0e0XKeH5i5AUg9AbpwVz1EAhNj2upKTEK
   IuklxRYjxKjy43HFXDE9ylFmL0UKGIZEevnXRkmQreh96bIKYtlwDTTf0
   PI/jdkaVBSFmgjF8JKS+vSRKiKkN0xtJP/Y7gAw5257eauYVoIFzSFybQ
   VNkR4WgvuopbZm0w/2/p2neM/yyb6vfZfy5KWcNy43YQNXz4om1xBdDx+
   G+FUnGwflHMaHyHtKyVGOFSYc2F7TG03coZcx5H92QQGNneDLzMJXYjFk
   w==;
X-CSE-ConnectionGUID: iAlYuNv7SiWLlEdwUd8Ytg==
X-CSE-MsgGUID: Tx7dybmzRsCO4pisD+nZxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="86735674"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="86735674"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 21:29:42 -0800
X-CSE-ConnectionGUID: NEF8T6CpR7q9aW5dvxCVTA==
X-CSE-MsgGUID: euHBE5q/TUqvH3HA2wDyUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="207918893"
Received: from indlpbc065983.iind.intel.com ([10.49.120.87])
  by orviesa004.jf.intel.com with ESMTP; 08 Jan 2026 21:29:39 -0800
From: George Abraham P <george.abraham.p@intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	giovanni.cabiddu@intel.com,
	George Abraham P <george.abraham.p@intel.com>
Subject: [PATCH V2 RESEND] PCI/TPH: Skip Root Port completer check for RC_END devices
Date: Fri,  9 Jan 2026 10:59:23 +0530
Message-Id: <20260109052923.1170070-1-george.abraham.p@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Root Complex Integrated Endpoint devices (PCI_EXP_TYPE_RC_END) are
directly integrated into the root complex and do not have an
associated Root Port in the traditional PCIe hierarchy. The current
TPH implementation incorrectly attempts to find and check a Root Port's
TPH completer capability for these devices.

Add a check to skip Root Port completer type verification for RC_END
devices, allowing them to use their full TPH requester capability
without being limited by a non-existent Root Port's completer support.

For RC_END devices, the root complex itself acts as the TPH completer,
and this relationship is handled differently than the standard
endpoint-to-Root-Port model.

Fixes: f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")
Signed-off-by: George Abraham P <george.abraham.p@intel.com>
---
v1->v2:
  - Added "Fixes:" tag to link the commit hash that introduced the code
---
 drivers/pci/tph.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index ca4f97be7538..e896b3958281 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -407,10 +407,13 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 	else
 		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
 
-	rp_req_type = get_rp_completer_type(pdev);
+	/* Check if the device is behind a Root Port */
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END) {
+		rp_req_type = get_rp_completer_type(pdev);
 
-	/* Final req_type is the smallest value of two */
-	pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
+		/* Final req_type is the smallest value of two */
+		pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
+	}
 
 	if (pdev->tph_req_type == PCI_TPH_REQ_DISABLE)
 		return -EINVAL;
-- 
2.40.1



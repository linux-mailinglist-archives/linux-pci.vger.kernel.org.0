Return-Path: <linux-pci+bounces-38309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C74BE21EB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 10:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8A684E760D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0E3302CDB;
	Thu, 16 Oct 2025 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bm2wKjpw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11852E6CC1;
	Thu, 16 Oct 2025 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760602790; cv=none; b=DYKz+mxS67K6KXAPxi45Co5B4u/WC6PxsY3q7JOARN5k7Feyx53xz8GhpEl/OFid2nNYRnXxXdWsJr+GPt9NPyAjBvJhHreO7tDDYRXijT8bn68OzcehPvfrhmMO7hr0CbRunSfXlIF2KxwcIItgOIDaHc+DEqVrb+EoMfY00lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760602790; c=relaxed/simple;
	bh=phziaBzu5TmnfxZiqaD7haduT9CScO0pUfgGcsEyWSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O0IMA54O89I5Vl973jcO+cJ550P2+4qnXgbXISrIJASbIPLuRfHSOERi6UOXWeL091Cexxx8WTZo6B2Fa/hK35sPbS9ljUMVVcrldoXutdAVv+5hK57GXgRSJb+iEND/8ySS2+hfnK65dzqj+Pl5BOIc4eVXIpGmC9V+TfBi4d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bm2wKjpw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760602789; x=1792138789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=phziaBzu5TmnfxZiqaD7haduT9CScO0pUfgGcsEyWSg=;
  b=bm2wKjpwM/I7YeDK3oeziSLCNtBwFr65YjKvzgMPPhQKlVSyxkTFcH8B
   upvnPVX1VViM9OJ6bVrSps5obBC/yIO4YtVuXqGiKMZLGfvhQ0Yy0nOpX
   O1vUxztVmhNbisO9t6NTJJDf3Kqft0O4n+PpdmWtZYZqS/Ys9mDtj0JvF
   u8GzsNy6eh9wXp2SB8Z2zQQidAjz3hp5y5N5q6kbVzJUNHKC7KQpfwIu1
   aqSyThJqS1g8BkhHA6iC7veM/vFLDG2aIE86zmT3qnHOTvYYwf52C6uD5
   GPcddslOV9vz4lf8z4dr9wyQML2BDSG/YP/FYKLFeCnVwgdKip/HXoATB
   g==;
X-CSE-ConnectionGUID: NvjcrZx4Ry21Jly8TrUQ3w==
X-CSE-MsgGUID: a1jjBLcNQQOnL65U1c0NdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="80424562"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="80424562"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 01:19:48 -0700
X-CSE-ConnectionGUID: snuU1N5ORYeeF0g89tkc0A==
X-CSE-MsgGUID: NdAwm5aqTSOfB0Tq6NR6QA==
X-ExtLoop1: 1
Received: from indlpbc065983.iind.intel.com ([10.49.120.87])
  by fmviesa003.fm.intel.com with ESMTP; 16 Oct 2025 01:19:46 -0700
From: George Abraham P <george.abraham.p@intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	giovanni.cabiddu@intel.com,
	George Abraham P <george.abraham.p@intel.com>
Subject: [PATCH V2] PCI/TPH: Skip Root Port completer check for RC_END devices
Date: Thu, 16 Oct 2025 13:50:23 +0530
Message-Id: <20251016082022.1173533-1-george.abraham.p@intel.com>
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

 drivers/pci/tph.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index cc64f93709a4..c61456d24f61 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -397,10 +397,13 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
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

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.40.1



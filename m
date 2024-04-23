Return-Path: <linux-pci+bounces-6572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D618AE781
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 15:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FE61C23525
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 13:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DE11353FE;
	Tue, 23 Apr 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmh/McVv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594B1332AC;
	Tue, 23 Apr 2024 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877726; cv=none; b=ljTQlCsb3myGXnahe5qgkg52kKnF0rqvDUVk+mE1fAZuALCu2Na/UzCbLWSKUd0ScFKVvf4ZpMYHlERb6c2xmDligf7HvkQ9G0okzRTIMBRPurcFvGgDuy+sad0oOCg0rVQrNA/W+RkS2QFZ/uBt+PJkAoUKBa06HmWYZrSkG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877726; c=relaxed/simple;
	bh=0javZ2j999g9iU8XTTAmvcG1Aa3PwZaNEsEiMn6UubY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=b6jgxEYvnhKto/4zNJ2/RmQCzoioRboBdr11vrkJ9vYicCkzyZA7C/1CIMkw3NT1RzdMqNiIbLwq3jLYQdDlD+WCxvWmcGB9dgCakBQhFxcVV0YukwSCxbeCHFTvXPbbahh60c1x3PGpUn8JCM7WY06WfJxeNZp6DvFwj09Gjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmh/McVv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713877724; x=1745413724;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0javZ2j999g9iU8XTTAmvcG1Aa3PwZaNEsEiMn6UubY=;
  b=jmh/McVvo/88r77xffkhKOXnwZhf2Sz0i+oYpBBiTQgpGBKqiEAibEFr
   xzBeXlhE5ByuhaQVCb8yjkEDijwYZU8YGadvWgz8iQ8cfmM71Yk116RJm
   cEg7+z7bLTNydHbb99ypEajw+xQb24eG8a5CSIW6mpYwPcX1HZJQ9Kt+9
   5h3mlcA8seo20M1YYhznUdpkm5W6lNpKlSTqOsbS3cuMXje8BL67hTzGc
   TDc1+puB5byb2dnLH26fsWtJHwiIQmE2jiLCt9SDiKH+76alkmTuBxlLc
   +1/Anv3OChBpEg2ccnFOK2zbV0O+2Dod0Iy89hO7WTR3KMBna+qUDEmi2
   w==;
X-CSE-ConnectionGUID: fWrYVPJUSG26/AJ3X7ErAw==
X-CSE-MsgGUID: xlj6emHvQYmXWfFSFK3VrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20008195"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20008195"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:08:43 -0700
X-CSE-ConnectionGUID: woc7n2+zTle0SV7BOSVICw==
X-CSE-MsgGUID: W8H3GzlpR/2eskxSM+UJbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24399524"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.40])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:08:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/2] PCI: Use the correct bit in Link Training not active check
Date: Tue, 23 Apr 2024 16:08:19 +0300
Message-Id: <20240423130820.43824-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two changes were made into link retraining logic independent of each
other.

The commit e7e39756363a ("PCI/ASPM: Avoid link retraining race") added
check to ensure no Link Training is currently active into
pcie_retrain_link() to address the Implementation Note in PCIe r6.1 sec
7.5.3.7. At that time pcie_wait_for_retrain() only checked for Link
Training (LT) bit being cleared.

The commit 680e9c47a229 ("PCI: Add support for polling DLLLA to
pcie_retrain_link()") generalized pcie_wait_for_retrain() into
pcie_wait_for_link_status() which can wait either for LT or Data Link
Layer Link Active (DLLLA) bit with 'use_lt' argument and supporting
waiting for either cleared or set using 'active' argument.

In the merge commit commit 1abb47390350 ("Merge branch
'pci/enumeration'"), those two divergent branches converged. The merge
changed LT bit checking added in the commit e7e39756363a ("PCI/ASPM:
Avoid link retraining race") to now wait for completion of any ongoing
Link Training using DLLLA bit being set if 'use_lt' is false.

When 'use_lt' is false, the pseudo-code steps of what occurs in
pcie_retrain_link():

	1. Wait for DLLLA=1
	2. Trigger link to retrain
	3. Wait for DLLLA=1

Step 3 waits for the link to come up from the retraining triggered by
Step 2. As Step 1 is supposed to wait for any ongoing retraining to
end, using DLLLA also for it does not make sense because link training
being active is still indicated using LT bit, not with DLLLA.

Correct the pcie_wait_for_link_status() parameters in Step 1 to only
wait for LT=0 to ensure there is no ongoing Link Training.

This only impacts the Target Speed quirk, which is the only case where
waiting for DLLLA bit is used. It currently works in the problematic
case by means of link training getting initiated by hardware repeatedly
and respecting the new link parameters set by the caller, which then
make training succeed and bring the link up, setting DLLLA and causing
pcie_wait_for_link_status() to return success. We are not supposed to
rely on luck and need to make sure that LT transitioned through the
inactive state though before we initiate link training by hand via RL
(Retrain Link) bit.

Fixes: 1abb47390350 ("Merge branch 'pci/enumeration'")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v2:
- Improve commit message

NOTE: Maciej NAK'ed the v1 of this patch but has since retracted his
NAK.

Maciej, if possible, could you please test this with your HW?

---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4288..70b8c87055cb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4629,7 +4629,7 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 	 * avoid LTSSM race as recommended in Implementation Note at the
 	 * end of PCIe r6.0.1 sec 7.5.3.7.
 	 */
-	rc = pcie_wait_for_link_status(pdev, use_lt, !use_lt);
+	rc = pcie_wait_for_link_status(pdev, true, false);
 	if (rc)
 		return rc;
 
-- 
2.39.2



Return-Path: <linux-pci+bounces-4330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD9686E409
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 16:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCA61F22EBC
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D37541A81;
	Fri,  1 Mar 2024 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJS1yyVt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD543987B;
	Fri,  1 Mar 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305616; cv=none; b=jZlAZoeKBqOtLwS7HwYdi/j3VF7Zh05J7Roz/qRu+aJDNG9x1VjfAoveZtRzrC/8FGeGS8QvagAQiA9yPV01oorwjdL12w0CT9ViurZbrn2qdney7wnM3dW8VcuM01WjNVp6sFuUK0tCPiXFkoF/oSf3qDCFwgVC7MFDDWGyawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305616; c=relaxed/simple;
	bh=klUhEQf+5iLq5itvvFsd/lwIyvrv5Jo42w7y/66wJTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=deL0wUW9IAUW6II5xwnSxYftEf4AbAbLbeejihdcPtxdOMqPL5DTQRzA+tKq3dbm/G5V/Dln4iDvp1A6dEjeSUm3Gs29oScQjOf6IAOwiEgMebh+sZhvWFXg5UIAd90BqVILBgAbyBy6nt55TCH6m+hppjiDx0X4jrgi+WtKKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJS1yyVt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709305615; x=1740841615;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=klUhEQf+5iLq5itvvFsd/lwIyvrv5Jo42w7y/66wJTE=;
  b=GJS1yyVtCuZjQOntjEmzmoBQRtwG8TSYApn9cRqAEm8xIdsV+Ec9K1C7
   ngm+aKpIfkTFw4r5+QekX1yqOkOEX4Xut+Mt6fBU8XaWJqkFqQ/AxaEgS
   2GvX198Fo9ShLT8N+nlr6ouP1Qfw1p75ewgzzvWeHPOS/3Q6CdUgg760T
   aTLDENhsrtBmhhdyNbwItLxUdSbvldxahfMXHTtebBNpY7KpKcnFFFNIR
   aeT/WDxkchMSB0j2ZgMRrj8xzqVJoIJ5TxcHh7snaKzdkYVljyTLkCuwe
   wO+dpegsBoKftJT3ihE+fSC0bp5LExqtw3xF5K9+1DdMLY968gCkGeTOy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7659659"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7659659"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 07:06:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8279225"
Received: from ybaron-mobl.ger.corp.intel.com (HELO localhost) ([10.94.249.66])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 07:06:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Maciej W . Rozycki" <macro@orcam.me.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Use the correct bit in Link Training not active check
Date: Fri,  1 Mar 2024 17:06:41 +0200
Message-Id: <20240301150641.4037-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Besides Link Training bit, pcie_retrain_link() can also be asked to
wait for Data Link Layer Link Active bit (PCIe r6.1 sec 7.5.3.8) using
'use_lt' parameter since the merge commit 1abb47390350 ("Merge branch
'pci/enumeration'").

pcie_retrain_link() first tries to ensure Link Training is not
currently active (see Implementation Note in PCIe r6.1 sec 7.5.3.7)
which must always check Link Training bit regardless of 'use_lt'.
Correct the pcie_wait_for_link_status() parameters to only wait for
the correct bit to ensure there is no ongoing Link Training.

Since waiting for Data Link Layer Link Active bit is only used for the
Target Speed quirk, this only impacts the case when the quirk attempts
to restore speed to higher than 2.5 GT/s (The link is Up at that point
so pcie_retrain_link() will fail).

Fixes: 1abb47390350 ("Merge branch 'pci/enumeration'")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d8f11a078924..251a0c66c8cb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5016,7 +5016,7 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 	 * avoid LTSSM race as recommended in Implementation Note at the
 	 * end of PCIe r6.0.1 sec 7.5.3.7.
 	 */
-	rc = pcie_wait_for_link_status(pdev, use_lt, !use_lt);
+	rc = pcie_wait_for_link_status(pdev, true, false);
 	if (rc)
 		return rc;
 
-- 
2.39.2



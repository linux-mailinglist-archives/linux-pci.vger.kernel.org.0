Return-Path: <linux-pci+bounces-4995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DD2886C4D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 13:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9109B24EA5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 12:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356254502E;
	Fri, 22 Mar 2024 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVGCCVpJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C264502B;
	Fri, 22 Mar 2024 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111224; cv=none; b=Q3x/TQ0fQ05sJgJSqIe5rtQ+q9TWBISOu5yTSrWCT9d3PmDZoa1fiqQJBp+3MvI+RjR+Xl5++ge4QpA+Po9I0Y0C/XSuTxuacm1mnmb9f18jYZ3R/99xKKeh4UV7QgSq92aMazr7QQf+HA6k96wvtM6u474nQifRgZy3n+L5XrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111224; c=relaxed/simple;
	bh=rKJH0cMhl2rdDAcqYQpxuR3bOt42lSv3aYu8/7XXITc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNOZLtNe8vDDqfS8FAS32kBx0MZ3w8Z9Jjdnti3szg3LDtzSOM5d5dXhPH88Bef7JObLTNOpu65JvsTaNlUow3jGf87HZzz1A0g+EwXfLVlFPNl9GWwYuHRKnoJ3vVqSH264Qf4PnV0+i2WSA9AtOFRtdbhBg7AfVINuTqx79/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVGCCVpJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711111222; x=1742647222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rKJH0cMhl2rdDAcqYQpxuR3bOt42lSv3aYu8/7XXITc=;
  b=mVGCCVpJwL6F0UPaMdvALMB0sfLdvpNmyRmK19/fBUlhn/YiQwadV7Mj
   bN09BOIT08nT09FlI3xDnsiU/su/BOlb4XnEBb2NaR95/8af0glLffYAe
   h51Y9wfRdijIApTaJviuEe1D6eQC05eNESEpqV9XRED/1Suy1oVbzcRME
   6/JeB9XLXxzTnGsRkUwZZp603vK5mKYPzG10hoXMibk3pnMbTJCoCZw5m
   YUbrwp+lK073nEkVrWSoZ3WJt4pxSONg30QAn/6PMBjpwLBmwQfVx0vUS
   imL5+gp/nQTbnNp+RpRFbYaoRP6K643GXQlBAEnp4RjfIv9ow8Ff5wcf9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6011690"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="6011690"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 05:40:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="15325388"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.18])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 05:40:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] PCI/ASPM: Cleanup ASPM disable/enable mask calculation
Date: Fri, 22 Mar 2024 14:39:52 +0200
Message-Id: <20240322123952.6384-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322123952.6384-1-ilpo.jarvinen@linux.intel.com>
References: <20240322123952.6384-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With only one set of defines remaining, state can be almost used as is
to set ->aspm_disable/default. Only CLKPM and L1 PM substates need
special handling.

Remove unnecessary if conditions that can use the state variable bits
directly. Move the ASPM mask calculation code into
pci_calc_aspm_{disable,enable}_mask() helpers which makes it easier to
alter state variable directly.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 51 +++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 505af49f48de..14d13fc519d8 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1323,6 +1323,28 @@ static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
 	return bridge->link_state;
 }
 
+static u8 pci_calc_aspm_disable_mask(int state)
+{
+	state &= ~PCIE_LINK_STATE_CLKPM;
+
+	/* L1 PM substates require L1 */
+	if (state & PCIE_LINK_STATE_L1)
+		state |= PCIE_LINK_STATE_L1SS;
+
+	return state;
+}
+
+static u8 pci_calc_aspm_enable_mask(int state)
+{
+	state &= ~PCIE_LINK_STATE_CLKPM;
+
+	/* L1 PM substates require L1 */
+	if (state & PCIE_LINK_STATE_L1SS)
+		state |= PCIE_LINK_STATE_L1;
+
+	return state;
+}
+
 static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
@@ -1345,19 +1367,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked
 	if (!locked)
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
-	if (state & PCIE_LINK_STATE_L0S)
-		link->aspm_disable |= PCIE_LINK_STATE_L0S;
-	if (state & PCIE_LINK_STATE_L1)
-		/* L1 PM substates require L1 */
-		link->aspm_disable |= PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1SS;
-	if (state & PCIE_LINK_STATE_L1_1)
-		link->aspm_disable |= PCIE_LINK_STATE_L1_1;
-	if (state & PCIE_LINK_STATE_L1_2)
-		link->aspm_disable |= PCIE_LINK_STATE_L1_2;
-	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
-		link->aspm_disable |= PCIE_LINK_STATE_L1_1_PCIPM;
-	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
-		link->aspm_disable |= PCIE_LINK_STATE_L1_2_PCIPM;
+	link->aspm_disable |= pci_calc_aspm_disable_mask(state);
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	if (state & PCIE_LINK_STATE_CLKPM)
@@ -1413,20 +1423,7 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 	if (!locked)
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
-	link->aspm_default = 0;
-	if (state & PCIE_LINK_STATE_L0S)
-		link->aspm_default |= PCIE_LINK_STATE_L0S;
-	if (state & PCIE_LINK_STATE_L1)
-		link->aspm_default |= PCIE_LINK_STATE_L1;
-	/* L1 PM substates require L1 */
-	if (state & PCIE_LINK_STATE_L1_1)
-		link->aspm_default |= PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1;
-	if (state & PCIE_LINK_STATE_L1_2)
-		link->aspm_default |= PCIE_LINK_STATE_L1_2 | PCIE_LINK_STATE_L1;
-	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
-		link->aspm_default |= PCIE_LINK_STATE_L1_1_PCIPM | PCIE_LINK_STATE_L1;
-	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
-		link->aspm_default |= PCIE_LINK_STATE_L1_2_PCIPM | PCIE_LINK_STATE_L1;
+	link->aspm_default = pci_calc_aspm_enable_mask(state);
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
-- 
2.39.2



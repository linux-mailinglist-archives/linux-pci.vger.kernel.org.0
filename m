Return-Path: <linux-pci+bounces-196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 078937FB0E3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 05:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C08BB20FBE
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 04:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B09D5693;
	Tue, 28 Nov 2023 04:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C5yI5L+1"
X-Original-To: linux-pci@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15AE1A7;
	Mon, 27 Nov 2023 20:20:39 -0800 (PST)
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id AFDAE6602F24;
	Tue, 28 Nov 2023 04:20:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701145238;
	bh=7fSxGDZnsW945OhHzdjD18pn6g61ZX1COA3nPM0NjiM=;
	h=From:To:Cc:Subject:Date:From;
	b=C5yI5L+1A3s+ANaTjlz99sBe5M4MdamPv7frzOVtYF88ed02w+MlGFfbRmM7I9Otp
	 Wj3/6y4U8wZRyF0JowkRmUCM/kAFWUMTlFyWwwEAHVm5oVUR7geeP4df2yZXNlg2c3
	 A/8kN5ADGf/nHDMMkCLVygU8iDqvTqotquY0Ogcf3/HFa0AsBycBTYr+ePkQoGfoFn
	 GGs6ns4UFim+o/ZISQkpU+S/RQDZ4G2ZdXopvAleHNKh5nEOMobKzlz5xn2mncB5zQ
	 N4k/APQQTKwsjeuixlKsAXUWTzGDeieE3wDs0tT9aKSYVLjQsYEW1zsK1eDMbiTMD5
	 Rv2EvAnrJcxuA==
From: Vignesh Raman <vignesh.raman@collabora.com>
To: intel-gfx@lists.freedesktop.org
Cc: helen.koike@collabora.com,
	daniels@collabora.com,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: qcom: Fix compile error
Date: Tue, 28 Nov 2023 09:50:26 +0530
Message-Id: <20231128042026.130442-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a2458d8f618a ("PCI/ASPM: pci_enable_link_state: Add argument
to acquire bus lock") has added an argument to acquire bus lock
in pci_enable_link_state, but qcom_pcie_enable_aspm calls it
without this argument, resulting in below build error.

drivers/pci/controller/dwc/pcie-qcom.c:973:9: error: too few arguments to function 'pci_enable_link_state'

This commit fixes the compilation error by passing the sem argument
to pci_enable_link_state in the qcom_pcie_enable_aspm function.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6902e97719d1..e846e3531d8e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -970,7 +970,7 @@ static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
 {
 	/* Downstream devices need to be in D0 state before enabling PCI PM substates */
 	pci_set_power_state(pdev, PCI_D0);
-	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
+	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL, false);
 
 	return 0;
 }
-- 
2.40.1



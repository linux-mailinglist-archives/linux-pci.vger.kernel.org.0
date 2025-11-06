Return-Path: <linux-pci+bounces-40536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CFDC3D15F
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 19:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663283B2137
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 18:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04079266581;
	Thu,  6 Nov 2025 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rO3Eqy1A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01DE29B8D0;
	Thu,  6 Nov 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762454213; cv=none; b=MgzqetbhKGFyQno4IXcWcuUTt0vnCxtzjnoyng7br/yiKkh1AIec+sZ/sOKLgywqxcwBt6jaaNT5POhz8HW+6Y0vxpVDfCOn2TvyKcuTn1OS/ma8pKX4GxMu9VnvffhHt8bS5mDNMw1vvY/mRAniUP3O6lMedkuoYCvsUuhnJ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762454213; c=relaxed/simple;
	bh=WZNwtxVV2uegNUg0XelyPK7YX+WuqMbWLKaUnuqlRTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A421q0MT/dEQCufR5NcjyPZUOEZMsPNAsQTnsNGzCRH8yBLHu14Gnqy0PJG7GJOZUHwcfd4MBdDRZlsngWDdtkb2ZY1Pu/gDeYqboeYW0AAWtN9NMcrR15wL20E66Wx52EELMmXzjrTFBe1j/hFIDvH/YheZkRlzVgV2xBdQCzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rO3Eqy1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4714FC4CEF7;
	Thu,  6 Nov 2025 18:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762454213;
	bh=WZNwtxVV2uegNUg0XelyPK7YX+WuqMbWLKaUnuqlRTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rO3Eqy1A5ms4ZtKiqqFF/KKhlZiVemD/ehVK4HQrTdhA0IzDdc+cAYp88fW/XmBLB
	 qp4PB5+MEOdUSp12T5bQ9tMiGbTJ6gp5IZI9NuTWF0Zy0dd7B6BaGmCXSI3a6jIbwd
	 MsqSlwEVnS3uFqKEU1qkScx9kRyWwILAgpKKBePTiqd2SKU89MfPLlaN+d/Bt1pYqy
	 M/ItazlaE/y7tEar6lx6WawE6Eimz9CfmE+9Bd0kTKG8zVhYyZxi2q2i6ZSlHxl8uF
	 4qAPsRBP/5GZiRTVxABF05VhdqDFtMtP1n6Pnm9igpi06GEeAevhoMWtaQi0UCsC1V
	 qsKWM/V5adPJg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	luigi burdo <intermediadc@hotmail.com>,
	Al <al@datazap.net>,
	Roland <rol7and@gmx.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au,
	linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports
Date: Thu,  6 Nov 2025 12:36:39 -0600
Message-ID: <20251106183643.1963801-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106183643.1963801-1-helgaas@kernel.org>
References: <20251106183643.1963801-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Christian reported that f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and
ASPM states for devicetree platforms") broke booting on the A-EON X5000.

Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
Fixes: df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms"
)
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..44e780718953 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2525,6 +2525,18 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
 
+/*
+ * Remove ASPM L0s and L1 support from cached copy of Link Capabilities so
+ * aspm.c won't try to enable them.
+ */
+static void quirk_disable_aspm_l0s_l1_cap(struct pci_dev *dev)
+{
+	dev->lnkcap &= ~PCI_EXP_LNKCAP_ASPM_L0S;
+	dev->lnkcap &= ~PCI_EXP_LNKCAP_ASPM_L1;
+	pci_info(dev, "ASPM: L0s L1 removed from Link Capabilities to work around device defect\n");
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1_cap);
+
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
  * Link bit cleared after starting the link retrain process to allow this
-- 
2.43.0



Return-Path: <linux-pci+bounces-40950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC88C50614
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 03:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BA854E6327
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 02:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B4853363;
	Wed, 12 Nov 2025 02:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TrgaOfLv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m32120.qiye.163.com (mail-m32120.qiye.163.com [220.197.32.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD7242D7C
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 02:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762916340; cv=none; b=anf0ZzysoOf7GbUN8NAVzqb9ZyUl5KjZOo4IPxGUCeV5SdUi3Dzf3mfLMhuo1oh8wI6SWXxLxHx/8GnGlSB1ZR29dbLhaFiIk+TFCHnd1ftTLUIYm3+i84RK0k0+dPACKl0Nu7D+saWFB1kR3hEBsN63O2gHePIHPCDcR7LtI3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762916340; c=relaxed/simple;
	bh=f9CfTd2H8m1AqoVPkFI9HE1i1z9exXud3Q1qdlZlF+E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ON5Ty6MgxGv9J3+DrAPa2RkJLhMWyGiLeRk4riWXHpSQZbL3H465HDyx4LOzu3d/3EUZhf4k3R+rpW9r4/+vhf2laErLdOJtUBKTDzJsRFg7S7s9MXllqkRDEbrzwLRQ1X+lk7sKUxt/Rn53VejG8WQkMWSm7klC4c573b5FQ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TrgaOfLv; arc=none smtp.client-ip=220.197.32.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 294424fbd;
	Wed, 12 Nov 2025 10:58:48 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] PCI: Add ASPM quirk for Hi1105 PCIe Wi-Fi
Date: Wed, 12 Nov 2025 10:58:39 +0800
Message-Id: <1762916319-139532-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9a760062a309cckunm82ff7532bf1d3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMaSlZDQkhDSEkZTkNDTBpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=TrgaOfLvIRUQFZreYxfvjdyklqd9B2itT9h2x0/Ts0Dit+AXz75iXsZ1pRbWspajV0moaInsYvh4NYHGI+1WQUVbIzmW6ZfWKYC2gZ9QNmZOb1/0xwxy4XCVEnMsZ1Y6JckGvWLGmA7oSxLGihnSESGCzoZqHPxZOGN/WB57M5o=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=j7R0p6M0GjwxfqiBf+MIYN5EweUcZiPYzJ3OEPIBnH4=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

This Wi-Fi advertises the L0s and L1 capabilities but actually
it doesn't support them. This's comfirmed by Hisilicon team in
actual productization.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2:
- rebase on linux-next
- use DECLARE_PCI_FIXUP_HEADER(Bjorn)

 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44e7807..24c2788 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2536,6 +2536,7 @@ static void quirk_disable_aspm_l0s_l1_cap(struct pci_dev *dev)
 	pci_info(dev, "ASPM: L0s L1 removed from Link Capabilities to work around device defect\n");
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1_cap);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1_cap);
 
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
-- 
2.7.4



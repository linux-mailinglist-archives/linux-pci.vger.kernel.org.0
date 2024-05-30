Return-Path: <linux-pci+bounces-8074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412A88D478A
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 10:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E9B1C21877
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 08:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49407406F;
	Thu, 30 May 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pEI9ecVH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19AA6F30A;
	Thu, 30 May 2024 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059184; cv=none; b=NvnQaa48Wq7HmNSCVLiU8pM863oOxUj+wdRFksxmpIXFvL+UgCLkv7z46q5XfQI0AMulwicBm4sOIzhnYRDQRkww4csU6zthdl3B2Ti2RhjZYZSc0/hMoWWEDlo2ha0BFfLT71UNEepI5Ns4iahhp7pxXyf86XSxKUmPvIgRBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059184; c=relaxed/simple;
	bh=zcF8ynwfqox6lFxPsAnNwptrPXvGztX8lAU2EObi2J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcKzY1yxF1ndTZS9uz4dpQxbsvucjKka+k7gep+mQxhBsEEdkj4kYKRqXPtAGTir20uwXuLV2b54VTpmqYrK5kFW294YWFo+WMS6kDzXXPI8Go3vETl64c1x+vw0MoyTBvyMXqDX/vxuoSAAZjFtvVfv8GA8MaIR4M9nO2ztbHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pEI9ecVH; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (1.general.khfeng.us.vpn [10.172.68.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BE5F940F62;
	Thu, 30 May 2024 08:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717059180;
	bh=4vdjuyTFJSa1yvWPwCMbJNz87HxC5Wp+l/buNmOANr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=pEI9ecVHNzV6y71mg4De+Vrswoxdj0S4+0ENDn0XxEDAVz80hj8K5CnUIjnkheY1D
	 vjXOftX0sKOISXQ101kPgGL6w1kbw3kk+93JbU8AVUuQnj7Uxy1EbsPnb913iqJVrh
	 bRirUCTT6g5rz+eftvlSDce0jK+1rZt802WbSlRTg18eeWVJ1XwTVtVBdv/DotwP1O
	 xkvxUvsQp6E7+2pTBHi/Qmy7OCXurvzIOxDJrPiXRAisjz8VhfyFQiggqP16lM696R
	 w9lSzo/klwhK+w/oOimobujvmWoVd6eJa2ZxkSLZ8dQn4Ckw5IXDF25DWeZx030YRI
	 wgkLAgavYaFOw==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev,
	ilpo.jarvinen@linux.intel.com,
	david.e.box@linux.intel.com,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/2] PCI: vmd: Let OS control ASPM for devices under VMD domain
Date: Thu, 30 May 2024 16:52:27 +0800
Message-ID: <20240530085227.91168-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530085227.91168-1-kai.heng.feng@canonical.com>
References: <20240530085227.91168-1-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel SoC cannot reach lower power states when mapped VMD PCIe bridges
and NVMe devices don't have ASPM configured.

So set aspm_os_control attribute to let OS really enable ASPM for those
devices.

Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR")
Link: https://lore.kernel.org/linux-pm/218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com/
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/controller/vmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..1dbc525c473f 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -751,6 +751,8 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
 		return 0;
 
+	pdev->aspm_os_control = 1;
+
 	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
-- 
2.43.0



Return-Path: <linux-pci+bounces-7102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9858BC6AC
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 07:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA1CFB20D7D
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 05:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9262045944;
	Mon,  6 May 2024 05:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="szvGy2CX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1D41EEE9;
	Mon,  6 May 2024 05:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714972762; cv=none; b=iIfWXBTCaZkAPvQBjCn79/Ku9hveRD/6tfHIUc5z2iXDBw/+WvhOR5LDl45MlEozv8EreplneSWKdxhq5Kd+DfZ7CQpMzL0OSncKBCEIScgQU69GBT1+cctbZt1QzOkG+N2qQGT6rP1DmZUs5mh+mN5SKQLG9mYumIVN8jvyyQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714972762; c=relaxed/simple;
	bh=06dEbMSkhU9EKB1BJ/UZAAMDB1nCMvvV1Dugt5xzYHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bgkIRczWHYKEZ3TSFkJQn3zWdSrr3ElknG110sOXwDZz7PHhzUI3GsdIBWWe+5cdobkeZAhzoi6LjFtB4pKW5ICfxeGRuhqJ2vQDjLrWxPtkNtUKBxyxgbvginkM3ZBzMpIARN8b0JKVpuiYmXZaYNNEy1TwZCZkJ3O8hwsWR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=szvGy2CX; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7FE463FA40;
	Mon,  6 May 2024 05:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714972752;
	bh=Qnp0PiHfp/IWPOg0CPvvM5+8flE+F+e1B4j4lhgtslo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=szvGy2CXefq21TLJk28pDEqa4UKl21fkOjhZTWOh+zcKI4o/wJA6lw0z7y16r63HL
	 p4nUbeiVNbLVSDobRQiyoAElWdh0mHDGrNOXw+qn1ScqSZgnmlVGFnnBiQBAV+kBHF
	 dtD1xiNkhph5LDB2nOvPt14+PXVUEJYp/hdkx+RvYu8hVtIpgwlzt41fKtArPrCkDS
	 y3KZkQwnamr+DW36U5p7nm4/9f91V2tC6JLsuMpWeAsYCKGh14v7IIlYah1ZRMxZOA
	 zCpnS/xgLACUT1Tn2In8KxsPg4b/4UVcOnRn2Fp9C65tivX6LDK2KTJWHG0113XBfa
	 khfxe3A+iAOaA==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] PCI/ASPM: Fix a typo in ASPM restoring logic
Date: Mon,  6 May 2024 13:16:02 +0800
Message-Id: <20240506051602.1990743-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's a typo that makes parent device uses child LNKCTL value and vice
versa. This causes Micron NVMe to trigger a reboot upon system resume.

Correct the typo to fix the issue.

Fixes: 64dbb2d70744 ("PCI/ASPM: Disable L1 before configuring L1 Substates")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/aspm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 2428d278e015..47761c7ef267 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -177,8 +177,8 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
 	/* Restore L0s/L1 if they were enabled */
 	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, clnkctl) ||
 	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, plnkctl)) {
-		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, clnkctl);
-		pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, plnkctl);
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, plnkctl);
+		pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, clnkctl);
 	}
 }
 
-- 
2.34.1



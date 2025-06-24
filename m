Return-Path: <linux-pci+bounces-30566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CB0AE731D
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 01:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399543BEF48
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 23:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1722D26B763;
	Tue, 24 Jun 2025 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g3okBWmN"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACFC26A1CC;
	Tue, 24 Jun 2025 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807586; cv=none; b=I1LV58aVK1Tn/iaxVeby6POD76lgXeuNeB2n/yqF87iajDHjP8TBU2feiDycTOgqGcwTRnd6bs2whfTHxyzFSf7a33F1izXxTPhaEY2ILhZ59xrYuzr0YDg27cWs9gU8Hnldw1hhzbhD3V/Z2qhAxeQaRqhOJSdaou2FBj+Rcmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807586; c=relaxed/simple;
	bh=AFaRBAZ+oKpjRIG0fymIIkcHut2SQDdgBKnw0N3xxWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cxh+coqPEpCHG4vo44l8DmMgvALEY2N0TPM0BbwZnj2x5cGLhKNuecF/QSuz2J0kX97yhj9RWaRVUNq3X5tNEiRVm4IYBgmqAoOtPCYqT/XLENGwfEP2+eVDoyGTkQ7ExgBcmnp2J59W14XY4icxCPCLytVB566Tu2Si1mDqw0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g3okBWmN; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B2397C000906;
	Tue, 24 Jun 2025 16:26:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B2397C000906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1750807577;
	bh=AFaRBAZ+oKpjRIG0fymIIkcHut2SQDdgBKnw0N3xxWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3okBWmNI307l/bBrVrjznONQaBk/uAeKeOorcWIMaSX7IM9vzZ4ySesOq7LEaPeD
	 dLk88pUV74NjS43t2N1pV03sZ04JTwPNYZJe2kEO41ECiQrWkuytNA7SgGXmjaR8Da
	 5f9pZHVySBVkSIjD8NHELBFhChhSu1COal30g+0Y=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 72A0718000853;
	Tue, 24 Jun 2025 16:26:17 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-pci@vger.kernel.org (open list:BROADCOM STB PCIE DRIVER)
Subject: [PATCH 2/2] PCI: brcmstb: Replace open coded value with PCIE_T_RRS_READY_MS
Date: Tue, 24 Jun 2025 16:19:23 -0700
Message-ID: <20250624231923.990361-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624231923.990361-1-florian.fainelli@broadcom.com>
References: <20250624231923.990361-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The delay that we are waiting on in brcm_pcie_start_link() is
PCIE_T_RRS_READY_MS, use it.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 92887b394eb4..7fa2087e85db 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1337,7 +1337,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	 * Wait for 100ms after PERST# deassertion; see PCIe CEM specification
 	 * sections 2.2, PCIe r5.0, 6.6.1.
 	 */
-	msleep(100);
+	msleep(PCIE_T_RRS_READY_MS);
 
 	/*
 	 * Give the RC/EP even more time to wake up, before trying to
-- 
2.43.0



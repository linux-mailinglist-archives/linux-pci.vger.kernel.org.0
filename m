Return-Path: <linux-pci+bounces-27292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEC6AACC4D
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 19:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99884C2A80
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 17:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BC8286400;
	Tue,  6 May 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ku9j4yB8"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D1207E03;
	Tue,  6 May 2025 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552955; cv=none; b=c+Np8V3vcboA06QfP4WsQMpqbwGiY4yYphyqd/NH6/pCVTlWOa3FGm8A3cv4Z32iXuzWA8WPdUHKS9zigtdUSmb/NAZiVAoPyCIX7AguaX/Ryk4p8cCrP28LkHqiS23A219ddgZVlrYNZBUgnGGFfShlWE5tqRyTFyyEkvcGBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552955; c=relaxed/simple;
	bh=YbY4BzhwwS0Bs97W2qpZD/tuPkcUHS6xrK4/be/t7fU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gJy7tIt7xkDcEQizQTOGmGw6NJIwkTR23TWup36/aW1ykTx/KqUwGlChNz4KEXI7eZu4utQvCJdVHUhG3cPzL36fEJa8aMO9UzuWTt7auUlElEFRPH6EDkbR5zal2Pudw1AEvGhqpTCuIRIKhTjiZ+MfBZsk98WfpH0B51JdOLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ku9j4yB8; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=E2ofU
	gHGCmm1xPAFMa2TsfZAr9ZO/RTFbitpv1wF7q0=; b=Ku9j4yB8bqcIRuacRvWR2
	JmqYyIcdjVdeDw7VRI/f0VgCY0YZPTpP9YQozV+v2lbGUxY2nWzm2qVQnm3ho2KB
	qrt7Yh80LPSDE0W/9+clgmoKqToBOBc1F4xRGPla4e7usfiCGeuccj6O4tLsV4KU
	1ONqvuJ38aJWQwWfzPt1Ik=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAX_U4ySBpoVmZeEw--.15363S4;
	Wed, 07 May 2025 01:34:45 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de,
	manivannan.sadhasivam@linaro.org,
	yue.wang@Amlogic.com
Cc: pali@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 2/3] PCI: dwc: Remove redundant MPS configuration
Date: Wed,  7 May 2025 01:34:38 +0800
Message-Id: <20250506173439.292460-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250506173439.292460-1-18255117159@163.com>
References: <20250506173439.292460-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAX_U4ySBpoVmZeEw--.15363S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4xuw4xXFWDJw43WF4xtFb_yoW8Cr1fpF
	y3Xrsa9F18Jr45WF4qkan5Cay3tasxCry7JF9Ig3yfuFyayFsrXa4ayFWSkFyxXrW293WS
	kr98K3y8C3W5trUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRn2-nUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOghFo2gaREltegABs9

The Meson PCIe controller driver manually configures maximum payload
size (MPS) through meson_set_max_payload, duplicating functionality now
centralized in the PCI core.  Deprecating redundant code simplifies the
driver and aligns it with the consolidated MPS management strategy,
improving long-term maintainability.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index db9482a113e9..126f38ed453d 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -261,22 +261,6 @@ static int meson_size_to_payload(struct meson_pcie *mp, int size)
 	return fls(size) - 8;
 }
 
-static void meson_set_max_payload(struct meson_pcie *mp, int size)
-{
-	struct dw_pcie *pci = &mp->pci;
-	u32 val;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	int max_payload_size = meson_size_to_payload(mp, size);
-
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
-	val &= ~PCI_EXP_DEVCTL_PAYLOAD;
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
-
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
-	val |= PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size);
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
-}
-
 static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
 {
 	struct dw_pcie *pci = &mp->pci;
@@ -381,7 +365,6 @@ static int meson_pcie_host_init(struct dw_pcie_rp *pp)
 
 	pp->bridge->ops = &meson_pci_ops;
 
-	meson_set_max_payload(mp, MAX_PAYLOAD_SIZE);
 	meson_set_max_rd_req_size(mp, MAX_READ_REQ_SIZE);
 
 	return 0;
-- 
2.25.1



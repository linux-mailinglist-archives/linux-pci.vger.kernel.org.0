Return-Path: <linux-pci+bounces-35981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D67B54390
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 09:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B6C3AF5DA
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 07:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87A421D5BC;
	Fri, 12 Sep 2025 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZLzye4Xl"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB0C282E1
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757661173; cv=none; b=aFqYnrE7ulSWr7I5cpq1Lz0SE0L8pHaPPCAspnkcUry1E4wVGYvj9Pl/kgHuVoEmp7WH7gq9IDWzvUHib8NLzsqcEVNaXHdivlYtrgOHk1L51SFU8pzUs6Y2Wa2I7TrzB2UTZSjZvuJfHMgiDVBonrx5nmpl1GQFlAAlpSQ9N70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757661173; c=relaxed/simple;
	bh=TGaSZwZKWXgiEtZ4EPIDcmCn/0UJk9FlpHak7BluG+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftgYIKTl0TwxJHW8LqF3ZFwqc+EipDw64plikm3ViaL1pS8ThVuCYBRQ+kG4GLQLZzk50BMj63vz8wLM0KcsBWand8zSxMav93EjDAeFn8oRNe1AnzP8WweothtEwkSrI9NQTKOZOLGngPbqMK2SHVJogabFwO92WnObBeRgELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZLzye4Xl; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757661171; x=1789197171;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TGaSZwZKWXgiEtZ4EPIDcmCn/0UJk9FlpHak7BluG+Q=;
  b=ZLzye4XlzxGF0npERjyGmtx6PBbm+eNqg8zDiTkN6htHNZI5ZWFdLunX
   vSs4Y68g11mTbwiwzhy4//NvFrd9lChQ4KKNJ/75TtHop5EyG0ZqYV+gr
   6VGPNe0fXCnpNmnv1h4l3xPBH2RhY0HTZbHPa4NmGf+bWwRDsy5kAN9/8
   7baUvfQcAQSz2XrZ5hfmdbXRMPwrxOKt/5CfSeECj8fcM4KhQ+nv2svUp
   Oz6IhXZRdg1myrq4/3py8LGDJ8jxkV9XMi77xCAlrfIakvHIC5NQBQ6XK
   uft5wgG1DcbgsDW/wwrvGz10vAKrZb4O04Obbzrc/YvrTPAnJ4ScCShSk
   w==;
X-CSE-ConnectionGUID: N0fmtbtSQwG3Gs9F57JtBQ==
X-CSE-MsgGUID: hNdtBrUISwGP5BjzP+TuYg==
X-IronPort-AV: E=Sophos;i="6.18,259,1751212800"; 
   d="scan'208";a="118117146"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2025 15:11:42 +0800
IronPort-SDR: 68c3c7ae_J1fhQoutcsNT2wwxBZF1vLN2yyxHmoQEV4PHqU8nmBb2sZS
 avIPPaiXY+JA4ZQQ3LJUZcbhg+mHWcjjL7pFNwA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2025 00:11:43 -0700
WDCIronportException: Internal
Received: from wdap-u7myouusf5.ad.shared (HELO shinmob.wdc.com) ([10.224.173.217])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Sep 2025 00:11:41 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] PCI: endpoint: pci-epf-test: NULL check dma channels before release
Date: Fri, 12 Sep 2025 16:11:40 +0900
Message-ID: <20250912071140.649968-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When endpoint controller driver is immature, the fields dma_chan_tx and
dma_chan_rx of the struct pci_epf_test could be NULL even after epf
initialization. However, pci_epf_test_clean_dma_chan() assumes that they
are always non-NULL valid values, and causes kernel panic when the
fields are NULL. To avoid the kernel panic, NULL check the fields before
release.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index e091193bd8a8..1c29d5dd4382 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -301,15 +301,20 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 	if (!epf_test->dma_supported)
 		return;
 
-	dma_release_channel(epf_test->dma_chan_tx);
-	if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
+	if (epf_test->dma_chan_tx) {
+		dma_release_channel(epf_test->dma_chan_tx);
+		if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
+			epf_test->dma_chan_tx = NULL;
+			epf_test->dma_chan_rx = NULL;
+			return;
+		}
 		epf_test->dma_chan_tx = NULL;
-		epf_test->dma_chan_rx = NULL;
-		return;
 	}
 
-	dma_release_channel(epf_test->dma_chan_rx);
-	epf_test->dma_chan_rx = NULL;
+	if (epf_test->dma_chan_rx) {
+		dma_release_channel(epf_test->dma_chan_rx);
+		epf_test->dma_chan_rx = NULL;
+	}
 }
 
 static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
-- 
2.51.0



Return-Path: <linux-pci+bounces-5211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 178D488D4CD
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 03:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD9AB2274B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 02:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2DB208B6;
	Wed, 27 Mar 2024 02:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ijg/jTDo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDBB219F6;
	Wed, 27 Mar 2024 02:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711508043; cv=none; b=Yth93AzHxZU7PewUM6RQNICwZAymL6AgyWtawXS2Qta57N0DpXQHZCxrW3yVJ0T9ltHi5U4LRnASlwFpVOpnmtThC4BzZSFmwZyWhuJMixnVNk+ix5v3ehe0rnLlStphV8VB4BNNjvVatisdqyqFl9QbBrBEs0kIEikYC8ii+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711508043; c=relaxed/simple;
	bh=Q1j9pJBcvMzujaDJm52zTaii4iN4bh/6kCaErJvNBlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=escgfU+3y8e39Aa1NNmADQgRmEgk+NjA8dKZsfGuwFaeq7EqioNzJv5mn226R7HAAS2hbVTZv/EhdaffW/9sDUJKYn+O2m4k6HERG5raTsBsbk/OpHlm8R/L2Do1//dadMRO3Vl5g4xAxQoQcdd8Pvn1FygrwwMb9GyKOeWFaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ijg/jTDo; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5EB833F32A;
	Wed, 27 Mar 2024 02:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711507557;
	bh=j58MgSplRPE44rJWeTTHvQAcR+gfJiFFf0zeSDSS9kY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=ijg/jTDo4q0tv/ifcfRFGnnR81OgMzcMqVqtPC7rJB27pdWI1GoM8/si+Nq1aEcmY
	 ajlA0q0o7VBt//RlcunjBRsi89apoDdawHwbIjbruDqcTgv9hYaoXme7QyVqonYZHn
	 k/I/o0MfrmN2JlAxN8FhgvmEIu825wcVQBpOnTRwD7MqNDaqFmZ+2oDTtqsHkO59E+
	 KjUMqePd7IZpnFxg7Env6pY9auG267B+tgS9QOkbhe2K1+m28AzXNn9j7czzKTKlo+
	 N+tD4Pl8flt9iF/xQg97kyWrk7m3q95JUuRbWb2u503ckybdw+miVuo3QZxn5Wwgrf
	 1SpRatLuDMAXg==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH v3] PCI: Mask replay timer timeout of GL975x's rootport
Date: Wed, 27 Mar 2024 10:45:09 +0800
Message-Id: <20240327024509.1071189-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Any access to GL975x's config space, like `lspci -vv` or
pci_save_state(), can still trigger the replay timer timeout error even
after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the replay
timer timeout of AER"), albeit with a lower reproduce rate.

The AER interrupt can prevent the system from suspending, or can flood
the kernel message. So mask the replay timer timeout to resolve the
issue.

Cc: Victor Shih <victor.shih@genesyslogic.com.tw>
Cc: Ben Chuang <benchuanggli@gmail.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/quirks.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ea476252280a..7ad7141e1c54 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6223,3 +6223,22 @@ static void pci_fixup_d3cold_delay_1sec(struct pci_dev *pdev)
 	pdev->d3cold_delay = 1000;
 }
 DECLARE_PCI_FIXUP_FINAL(0x5555, 0x0004, pci_fixup_d3cold_delay_1sec);
+
+#ifdef CONFIG_PCIEAER
+static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(pdev);
+	u32 val;
+
+	if (!parent || !parent->aer_cap)
+		return;
+
+	pci_info(pdev, "Mask AER due to hardware defect");
+
+	pci_read_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, &val);
+	val |= PCI_ERR_COR_REP_TIMER;
+	pci_write_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, val);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
+#endif
-- 
2.34.1



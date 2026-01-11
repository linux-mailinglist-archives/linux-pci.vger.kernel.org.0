Return-Path: <linux-pci+bounces-44436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE9DD0E230
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jan 2026 09:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16688300A9C2
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jan 2026 08:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303FA3168E5;
	Sun, 11 Jan 2026 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Gv4OnBaX"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF030AACD;
	Sun, 11 Jan 2026 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768118843; cv=pass; b=HrNCl3uP4j0c+bg+pEyuvniHJ8WcFEB6DK6zMt0MfAbTk+wOkxSPPqJ1oOeeSYpib71M70yk3i2OaOTWpVYhR5NHxbWqtdyQAjSNsa1AMjfb2H7y0skuEV7vohpcVx3rcn6dIEPwLcn211jHqVFQ0xOnPYT3ISbD9bVzGggIdbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768118843; c=relaxed/simple;
	bh=2m1xKvGvnkr787OxH/73OG/B/kR3BOrrl8Obx2OlRKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uXJm3c0VR/fhaJ+A1C644YSfu72XC7KSZP+8It1+e0x6t794KO74L/Trn730p6408ERp2oyELyP5gpY14I1lbu+slLq+6U7TjMjj3gkioCo4yAssNzCjuMcRJZfvWvZh9Zj+cVq4AGKe7MqRt833g6BX6AVPB+OdiKV9IWL05g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Gv4OnBaX; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1768118837; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=m982K58XhxL8/JDiNx2XdWhzqRR4cCR8WzeIMflNg6qTCuBMh9pn19O1kRL69MeXB+btYZ3V8qtJkZxa3o1m3ihXJnO3fX2GiAemHu/O7lYf5IVhL3FvDbi5jNbwkxL2SLsodynd1hzm6EB0h6ysJrwGAhycJzVto2nLhuNwewQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768118837; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AhXRgb6SBeNXL+K6/f8ppZuQNNLD9KnvuKFxLKnj5Rw=; 
	b=oLVelxMNNwpJwcaJM7/Er0CD6b2dIVC8bnTU4nfgHpMMSMouocXlFu3rOlJ9WaeFapT0Akld0IRHc/8oSii+sJgbyhSBeA0aqFCslrKFk++s8Y3U5mF+1AGIZML0gsnKBftobnMbcM5oZIf1TJ8Pn0m9TW/8TdcaD8pGRk6WOtM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768118837;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=AhXRgb6SBeNXL+K6/f8ppZuQNNLD9KnvuKFxLKnj5Rw=;
	b=Gv4OnBaX0Kw1Rj5iQmKuT0GaYRBOF52H0J+Rf/6He48u7l2lJb9T9+6B9ZUjG3Ys
	aHEChc31r4gseXJsoUYl+xBobGzFs1HeQt0IWy0TnHpESTccgKR618E+GH/3AbxKVhl
	SSOsxPtT7DhlfW3SDP73i7hsN5rHIQA8HMuY7eDE=
Received: by mx.zohomail.com with SMTPS id 1768118834795881.4056456748672;
	Sun, 11 Jan 2026 00:07:14 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dan.j.williams@intel.com
Cc: linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH 1/1] PCI/IDE: Fix using wrong VF ID for RID range calculation
Date: Sun, 11 Jan 2026 16:06:31 +0800
Message-Id: <20260111080631.506487-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112276a6de86c53343c88ba28bfb80000d2a041fc2cd5e7c1284e1a4eb0842d8a656c488e8b5e7baea8:zu08011227a46711a3e3dc0b0eebf68b9f0000688efb6d724a0eb0e1b38199ff2400d162c8361e4c43f44671:rf08011232eed5501723d7abbd35169f420000f21a98e211a40aafa6cda30b6efff7c07521edf30f3a45bdd919609a4dd05dab61b93c7f:ZohoMail
X-ZohoMailClient: External

When allocate a new IDE stream for a pci device in SR-IOV case, the RID
range of the new IDE stream should cover all VFs of the device. VF id
range of a pci device is [0 - (num_VFs - 1)], so should use (num_VFs - )
as the last VF's ID.

Fixes: 1e4d2ff3ae45 ("PCI/IDE: Add IDE establishment helpers")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/pci/ide.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 26f7cc94ec31..9629f3ceb213 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -283,8 +283,8 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
 	/* for SR-IOV case, cover all VFs */
 	num_vf = pci_num_vf(pdev);
 	if (num_vf)
-		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
-				    pci_iov_virtfn_devfn(pdev, num_vf));
+		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf - 1),
+				    pci_iov_virtfn_devfn(pdev, num_vf - 1));
 	else
 		rid_end = pci_dev_id(pdev);
 
-- 
2.34.1



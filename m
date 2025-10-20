Return-Path: <linux-pci+bounces-38697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F4DBEF1A9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 04:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E1F3E3759
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 02:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9521B185;
	Mon, 20 Oct 2025 02:37:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0141117A2F0
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 02:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760927857; cv=none; b=A5dPbdy2hiQpxU9PpxEEAOgAVIUYE+0cQylJbtqNLWc5HJxWDMTmyTXGfBhl8DAfh6FVBu2vNNDLvsY5Z8edWFJt8O7RVlyxZL99I3itYo1Q4w1OyOmZSWK/nW1NCSTytQrltHYvtA+xi5ygKrz9Ggvj/r3CDWEtturgxeCYM0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760927857; c=relaxed/simple;
	bh=hDFziiIPZ3+kS2P8QdPhhom5xfgysVXCS6BmOWMpzaM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PBwyIJ9mL1DHKm9JfBtwNaGA8Z2QPscZAqnfFs28OlJw6ioorKjfGfim2ulkhl0x2XV2FNG3VzPdehIpd+FCPuvfXSxNQ0ziPfvRuoc7FwT78GkMa51dl5MhtCOFr69/V956HjpE8fPltw8KsnsiftX8BxkpD5Urb/PpZIF8M9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: QvWlSdX4T/qSrLfjElPQng==
X-CSE-MsgGUID: Iq1a9ouDT5WttFvaahc78w==
X-IronPort-AV: E=Sophos;i="6.19,241,1754928000"; 
   d="scan'208";a="130000054"
From: weipengliang <weipengliang@xiaomi.com>
To: <weipengliang@xiaomi.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI/ASPM: Avoid restore error L1ss cap.data to parent downstream PCIe port
Date: Mon, 20 Oct 2025 10:36:58 +0800
Message-ID: <20251020023658.2294-1-weipengliang@xiaomi.com>
X-Mailer: git-send-email 2.47.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX01.mioffice.cn (10.237.8.121) To YZ-MBX11.mioffice.cn
 (10.237.88.131)

The function pci_restore_aspm_l1ss_state will restore L1ss cap.data
in the upstream resume flow, to both downstream & upstream port.
When the upstream port is suspended and the suspend flow is interrupted,
the downstream port has not been suspended yet, so the L1ss cap.data is
not correct. Expectially the first Suspend/Reusme flow, the downstrem
L1ss cap.data will be initialize to zero.
When the Suspend/Resume flow is interrupted the time between
upstream port has suspended but the downstream port hasn't,
it will restore zero to the downstream port in the
upstream port Resume flow.

Signed-off-by: weipengliang <weipengliang@xiaomi.com>
---
 drivers/pci/pcie/aspm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7cc8281e7011..173e0eb10b0d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -97,6 +97,9 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 	if (!pdev->l1ss || !parent->l1ss)
 		return;
 
+	if (!parent->state_saved)
+		return;
+
 	/*
 	 * Save L1 substate configuration. The ASPM L0s/L1 configuration
 	 * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
-- 
2.47.1.windows.1



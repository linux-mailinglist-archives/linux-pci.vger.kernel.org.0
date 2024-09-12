Return-Path: <linux-pci+bounces-13135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA4E9773E7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 23:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCC41F25366
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 21:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477C01C2431;
	Thu, 12 Sep 2024 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEy08+wi"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95E1C2424
	for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 21:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726178023; cv=none; b=ArZNYfXBaUOxl1HR+MQK7uXB7qk2MT5RaFzrwpe3umj7tYE8+tPTCHGGIwa+ytft8sntzq52rqB+0kPnIO8P4/8s+yttKcu6AY/nrBZYaYY2t/InwAJ+heXHGFcdtblkaJiRQpT7Eb30KTiZ7X9hx7XuhJnTYJx+Xv5rQqa1ELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726178023; c=relaxed/simple;
	bh=SSD3CXbSmy5PMYo/XtCxFdAXqVnofETmogiXlkTiyWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Elx0tx+nqBuhagoh9/WRiJTPEnL+hNYbH2zYI/LkX3TjnkX61/la8x17N7ZtWb/w6WynH9LW06bd7FZt+lonDm7R+VyGRCc65rxjgsmAZRAF9vFCaqEtxgu3c3hL7BYt5ai+N0CZ48mzutZtQXzjlpSYayODn4URVn5gEH8AAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEy08+wi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726178020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kDBigamses4Q63edfd4mL7Y1CXoU8nV/VK3fhNy/pi4=;
	b=WEy08+wiqS1PHO3Z4Y44iZjrOMcI98FITR2bcyz99sn4tkoGwOTA4tz9UfGXDWVAss+QFJ
	ULc8RPawLMbqiISoWCX3uwO0oMbywtrFsWagExVJCRDkg8wdPOnbl+X1dylwaM22iWqN3N
	ZWYdB/+Yg/vktVkwGdwlOBOmuv0sjRA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-mKut3Ej0MQmCAhVoEnXrfg-1; Thu,
 12 Sep 2024 17:53:37 -0400
X-MC-Unique: mKut3Ej0MQmCAhVoEnXrfg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5D8019560B4;
	Thu, 12 Sep 2024 21:53:36 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.8.21])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49ACB1956096;
	Thu, 12 Sep 2024 21:53:35 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: helgaas@kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	delineshev@outlook.com
Subject: [PATCH] PCI: Mark Creative Labs EMU20k2 INTx masking as broken
Date: Thu, 12 Sep 2024 15:53:27 -0600
Message-ID: <20240912215331.839220-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

As reported in the link below, a user indicates this device generates
spurious interrupts when used with vfio-pci unless DisINTx masking
support is disabled.  Quirk the device to mark INTx masking as broken.

Reported-by: zdravko delineshev <delineshev@outlook.com>
Closes: https://lore.kernel.org/all/VI1PR10MB8207C507DB5420AB4C7281E0DB9A2@VI1PR10MB8207.EURPRD10.PROD.OUTLOOK.COM/
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

FWIW, a web search has a couple other hits of users experiencing
problems trying to assign this device which seems to corroborate this
most recent report.

 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a2ce4e08edf5..c7596e9aabb0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3608,6 +3608,8 @@ DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
 			quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004, /* Ceton InfiniTV4 */
 			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CREATIVE, PCI_DEVICE_ID_CREATIVE_20K2,
+			quirk_broken_intx_masking);
 
 /*
  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
-- 
2.46.0



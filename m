Return-Path: <linux-pci+bounces-2495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4578398FA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 20:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6161F2D2FA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 19:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFBC823A8;
	Tue, 23 Jan 2024 18:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddRhw6eZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C6085C69
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036209; cv=none; b=ueaJgO13DOuMI2ESBym+wJdKgf3Dpn6IvS0T0jETMep8kn9QXnzUXyC57vaJVAUn2JnYLShEAX9EVBLXTDG3rOSWAh4X8bWy+XlOFsD+1vQ5AdzbSzh9Y/vGDjcOmOrpp1pjorRFqZd9RJTu4yKzotuHAa4873lka2yBhkaLBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036209; c=relaxed/simple;
	bh=qSfcqTgi80cGyZFL7Fdh0Wbjh0Z12CZZDhoQAka/lr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lO/3P3c2DPwm0Ik3NMnGdNrhvMNov8AswM0SiVCaMUfBqIN7roFLiMv76bXUaKbfqyMuYml4SlvXr7fGG7ILLu453W67O219pC4x1lqDo2BiE1vEsGQm4PeYkd538TsirKHvGqxLH3gLxOTFUYczu19hr4KGBdJy/WXNTyVmpSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddRhw6eZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706036206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xGc+rsyj3BH1TNg1iP09uGhIjOCkKzn+qg59sLt6VDg=;
	b=ddRhw6eZtswIzRHzbLaB9N3/BcoYMPWwV8beF83xYigExz4VwMyT/SXrgNN2uLJ2Cnl6AL
	QGFzfjmThIsK3x/cP3hXZkR6LR9roXw5OWN29Uk9akaVzWA2jBylFLu1RqShow4kKMHpPY
	mDzSlf3DVH4M33GgroD4GZauKK/NPgs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-KFDufQFTNUaXcXL28HrTzQ-1; Tue, 23 Jan 2024 13:56:43 -0500
X-MC-Unique: KFDufQFTNUaXcXL28HrTzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFB1D185A785;
	Tue, 23 Jan 2024 18:56:42 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.17.210])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 025D951D5;
	Tue, 23 Jan 2024 18:56:41 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org,
	lukas@wunner.de,
	mika.westerberg@linux.intel.com,
	rafael@kernel.org,
	sanath.s@amd.com
Subject: [PATCH] PCI: Fix active state requirement in PME polling
Date: Tue, 23 Jan 2024 11:55:31 -0700
Message-ID: <20240123185548.1040096-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The commit noted in fixes added a bogus requirement that runtime PM
managed devices need to be in the RPM_ACTIVE state for PME polling.
In fact, only devices in low power states should be polled.

However there's still a requirement that the device config space must
be accessible, which has implications for both the current state of
the polled device and the parent bridge, when present.  It's not
sufficient to assume the bridge remains in D0 and cases have been
observed where the bridge passes the D0 test, but the PM state
indicates RPM_SUSPENDING and config space of the polled device becomes
inaccessible during pci_pme_wakeup().

Therefore, since the bridge is already effectively required to be in
the RPM_ACTIVE state, formalize this in the code and elevate the PM
usage count to maintain the state while polling the subordinate
device.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Fixes: d3fcd7360338 ("PCI: Fix runtime PM race with PME polling")
Reported-by: Sanath S <sanath.s@amd.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218360
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bdbf8a94b4d0..764d7c977ef4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2433,29 +2433,36 @@ static void pci_pme_list_scan(struct work_struct *work)
 		if (pdev->pme_poll) {
 			struct pci_dev *bridge = pdev->bus->self;
 			struct device *dev = &pdev->dev;
-			int pm_status;
+			struct device *bdev = bridge ? &bridge->dev : NULL;
+			int bref = 0;
 
 			/*
-			 * If bridge is in low power state, the
-			 * configuration space of subordinate devices
-			 * may be not accessible
+			 * If we have a bridge, it should be in an active/D0
+			 * state or the configuration space of subordinate
+			 * devices may not be accessible or stable over the
+			 * course of the call.
 			 */
-			if (bridge && bridge->current_state != PCI_D0)
-				continue;
+			if (bdev) {
+				bref = pm_runtime_get_if_active(bdev, true);
+				if (!bref)
+					continue;
+
+				if (bridge->current_state != PCI_D0)
+					goto put_bridge;
+			}
 
 			/*
-			 * If the device is in a low power state it
-			 * should not be polled either.
+			 * The device itself should be suspended but config
+			 * space must be accessible, therefore it cannot be in
+			 * D3cold.
 			 */
-			pm_status = pm_runtime_get_if_active(dev, true);
-			if (!pm_status)
-				continue;
-
-			if (pdev->current_state != PCI_D3cold)
+			if (pm_runtime_suspended(dev) &&
+			    pdev->current_state != PCI_D3cold)
 				pci_pme_wakeup(pdev, NULL);
 
-			if (pm_status > 0)
-				pm_runtime_put(dev);
+put_bridge:
+			if (bref > 0)
+				pm_runtime_put(bdev);
 		} else {
 			list_del(&pme_dev->list);
 			kfree(pme_dev);
-- 
2.43.0



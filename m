Return-Path: <linux-pci+bounces-29385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35373AD472A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 02:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25CED7AA7C8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 00:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE15F2907;
	Wed, 11 Jun 2025 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JQ6Oi4PE"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A0D383;
	Wed, 11 Jun 2025 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749600355; cv=none; b=TFgcmTF/cyde+NPbhrYGZlFVrOQIjkmqLMyJcOa6TcIXNCRoLmA2ng4g/hXX+eMDDI0dMcf0umL9Uygw2amFioy3x6I1Y4vAHDnrhzJXfMYkbAlegmOp9pwb/WHq/ANiFPWsLASwOe+utBP3vOLnJcuk9r9mNLxYcszpJbepPPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749600355; c=relaxed/simple;
	bh=b4oqUIuuT9QIxmlnAXvpRAJ9pHBh7e8M4gmMrsOQu7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+uBTPexreEG+biHeCVftOKEQvQDaBhbGoQAiG4MH4jV6zVIkZJ3mW1tCEiV0iRA6dfgDw/m5zTuLhpDeiqbGmTqYiLLNo22hDwia1m+SYapjS8ychf/i4/Xd+Ygo6DWTm+5OTXDE3qu37zxj/i5DQkw/6tzff2D/9deBGBY638=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JQ6Oi4PE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-grwhy-1BDK8.redmond.corp.microsoft.com (unknown [70.37.26.40])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0F4562115180;
	Tue, 10 Jun 2025 17:05:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F4562115180
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749600354;
	bh=MG8SB5YlpIi3EYSTf0CCvOyJ7qETS9P1He4KAA7rXL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQ6Oi4PE7HfrXDbqHEsD536z/l3MUoUnfZU0fQXDxh78juA57GWBCYZePkCIbSHaR
	 xjPSaybHU0ID+GOy8OAT6ZlKm0cSKgGecjSTFUvAsI9o2Dyh+pNrB8Yxr+u+bu9PdM
	 mxPzGQD/zTWe3EnHRgKCbQUa7ntia7sc7tb9CcJ4=
From: grwhyte@linux.microsoft.com
To: linux-pci@vger.kernel.org
Cc: shyamsaini@linux.microsoft.com,
	code@tyhicks.com,
	Okaya@kernel.org,
	bhelgaas@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] PCI: Add flr_delay parameter to pci_dev struct
Date: Wed, 11 Jun 2025 00:05:51 +0000
Message-Id: <20250611000552.1989795-2-grwhyte@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611000552.1989795-1-grwhyte@linux.microsoft.com>
References: <20250611000552.1989795-1-grwhyte@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Graham Whyte <grwhyte@linux.microsoft.com>

Add a new flr_delay member of the pci_dev struct to allow customization of
the delay after FLR for devices that do not support immediate readiness.

Signed-off-by: Graham Whyte <grwhyte@linux.microsoft.com>
---
 drivers/pci/pci.c   | 8 ++++++--
 drivers/pci/pci.h   | 2 ++
 include/linux/pci.h | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9448d55113b..04f2660df7c4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3233,6 +3233,8 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->bridge_d3 = pci_bridge_d3_possible(dev);
 	dev->d3cold_allowed = true;
 
+	dev->flr_delay = PCI_FLR_DELAY;
+
 	dev->d1_support = false;
 	dev->d2_support = false;
 	if (!pci_no_d1d2(dev)) {
@@ -4529,9 +4531,11 @@ int pcie_flr(struct pci_dev *dev)
 	/*
 	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
 	 * 100ms, but may silently discard requests while the FLR is in
-	 * progress.  Wait 100ms before trying to access the device.
+	 * progress.  Wait 100ms before trying to access the device, unless
+	 * otherwise modified if the device supports a faster reset.
+	 * Use usleep_range to support delays under 20ms.
 	 */
-	msleep(100);
+	usleep_range(dev->flr_delay, dev->flr_delay+1);
 
 	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..abc1cf6e6d9b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -135,6 +135,8 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
 #define PCI_PM_D3HOT_WAIT       10	/* msec */
 #define PCI_PM_D3COLD_WAIT      100	/* msec */
 
+#define PCI_FLR_DELAY           100000 /* usec */
+
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
 void pci_refresh_power_state(struct pci_dev *dev);
 int pci_power_up(struct pci_dev *dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f392..4c9989037ed1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -402,6 +402,7 @@ struct pci_dev {
 						   bit manually */
 	unsigned int	d3hot_delay;	/* D3hot->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
+	unsigned int    flr_delay;      /* pci post flr sleep time in us */
 
 	u16		l1ss;		/* L1SS Capability pointer */
 #ifdef CONFIG_PCIEASPM
-- 
2.25.1



Return-Path: <linux-pci+bounces-13636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5085E98A075
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 13:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831051C23E2A
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 11:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB01191F8D;
	Mon, 30 Sep 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="JA+dFkfm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58094193075;
	Mon, 30 Sep 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695314; cv=none; b=PelkwJasKRDftRE2UunpkEc+OxIqusBXxkCyPYKYg0MipeB1XWeVYmyPQ3vLA9af6Qzq3v6ZE00y2k8dGW4YI6ner+CN/ZgF5Nn3f/GJpd5aSrOGbgJjFzruppnjBiAcTcu3iCXdFAp/q8Cz5R2hyFcvyTnXAw2CenlC3em66sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695314; c=relaxed/simple;
	bh=ieHab2mv9Pq37/mgO09mTpBb15m1Bl2fs+EoNTFEra0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KYBXUgNgjEfeGtUFKtRLORMd2Ni92XWXeWfq1RJph1XJbLhF4oXySPFBVhHDhuv5P1PDHsxfeEVNkWi2bnAk4F+6s5nKh/ZAxvc6QOklE647a2YoVpzaZbNe61U5S1NWDd1IBJoBUDBkX+m/HFf/FiWT+9xV1sCKJPpj6aCos8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=JA+dFkfm; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6EzkqpV2uXffqH1jAjXqr0uIlkSmjX1koVTgGN49H6I=;
  b=JA+dFkfmZBf2pgs3mjfiFnQKYkjFUa682knp4V5jR9QOuo2Is9WMM/rn
   F5MCk8Pp0tVaYQ7IcaOrsekBmyGlv0ZQ6X1WUdTqt3TTb8lCDlksBjcb6
   0hQL6kUTUwHCrX/P7lRqGM3Gl/BlDwGG6i+BgYyKryQvblVJdvrlQUa8U
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956895"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:27 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 22/35] PCI: hotplug: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:08 +0200
Message-Id: <20240930112121.95324-23-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/pci/hotplug/pci_hotplug_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 058d5937d8a9..db09d4992e6e 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -388,8 +388,8 @@ static struct hotplug_slot *get_slot_from_name(const char *name)
 
 /**
  * __pci_hp_register - register a hotplug_slot with the PCI hotplug subsystem
- * @bus: bus this slot is on
  * @slot: pointer to the &struct hotplug_slot to register
+ * @bus: bus this slot is on
  * @devnr: device number
  * @name: name registered with kobject core
  * @owner: caller module owner



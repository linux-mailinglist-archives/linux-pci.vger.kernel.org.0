Return-Path: <linux-pci+bounces-18991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 889499FBA20
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 08:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E6D1640EC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 07:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2A51487E1;
	Tue, 24 Dec 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qRKrMYqA"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C2742049;
	Tue, 24 Dec 2024 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735024648; cv=none; b=VCk2qVv/nawpFbFN2zcuSkiZwaRG7BZ4TIsxRRq4ovNRMGjBhdBn95nxSM+e5TWXLO2PYy8UvqcClh+m8Z4coxUqlPA7J3jIgiaZmUPb5gd+EwrN/F4BduGC8VhVJxegS0IE9iWusoB8LzD9M/f+qx2/z1jt0Led5PyGn3hhNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735024648; c=relaxed/simple;
	bh=9+tXIZ3mXnKDoT+JrNUteSPE/HF4WoOH4WhtFzMnYj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=paQJ4geCNucUjxfi0DhSs9MXuqQHlWPntxMMFtDdk083DwOkP4ibIHPuTW/GQguh4K30vSTyGHBxzZAXyEIqztNwR9hhdPcNORuX8qC3gvHv7nY5T6Fi9kycA+OWxf8Yi/g1mgd9AQ6aiWLhKBp9AKdmBgLgMLnrf4uCcU/IgX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qRKrMYqA; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sHxrY
	o+EMtDjV2zRM4wtSEtY1RzeCEoC9OhX7FDEO1s=; b=qRKrMYqAPP7aLDzR3CI+7
	qVqSCJPsWqUxklcVAtue1dFGUPHi7DzBke39vqOYU4frUO3IcbNoefr1a6C8A7x7
	YXX3Lm234owMdzUyTE6olGKv5xFAOoqnoZCmsdB2ElC1Vh4f5xzqqtM8/v9vqNt9
	knId5pZKi4MpAoqWuG7jKA=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDHD3vdX2pnMfWbDg--.10900S4;
	Tue, 24 Dec 2024 15:16:55 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: bhelgaas@google.com,
	yinghai@kernel.org,
	rafael.j.wysocki@intel.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] PCI: fix reference leak in pci_alloc_child_bus()
Date: Tue, 24 Dec 2024 15:16:43 +0800
Message-Id: <20241224071643.3762325-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDHD3vdX2pnMfWbDg--.10900S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWxGr1fCr1UKw1rZw15CFg_yoWfKrgE93
	W09F97Wr4Dt3WxKw1ayr13Z392k3WDZrZ3WrW0qF1xZa43Xrs8ZF9rZry8Jw4j9anrCr98
	Aa4jqrn29F1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRXyCLJUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbizR+-C2dqV-6xYAAAsT

When device_register(&child->dev) failed, calling put_device() to
explicitly release child->dev. Otherwise, it could cause double free
problem.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 4f535093cf8f ("PCI: Put pci_dev in device tree as early as possible")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v2:
- modified the patch as suggestions.
---
 drivers/pci/probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2e81ab0f5a25..a61070ce5f88 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1174,7 +1174,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 add_dev:
 	pci_set_bus_msi_domain(child);
 	ret = device_register(&child->dev);
-	WARN_ON(ret < 0);
+	if (WARN_ON(ret < 0)) {
+		put_device(&child->dev);
+		return ERR_PTR(ret);
+	}
 
 	pcibios_add_bus(child);
 
-- 
2.25.1



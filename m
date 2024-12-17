Return-Path: <linux-pci+bounces-18573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C2B9F415B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 04:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817B41889596
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 03:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879DC136353;
	Tue, 17 Dec 2024 03:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kCpRFeaR"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54434A23;
	Tue, 17 Dec 2024 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734407811; cv=none; b=lXD964oHURWhuGnz9jD75nQR7FUloP89EAuY1RZtz2N+8RZiYwb6vvtVRMXLZj5cIdJspBZocPQRXEtwOc0zccklMGBY6ZJdqlbGqpfNjHtq5UNnHbmJWW18F7YLeU7wn47zudup85CPRIiOuZ/yLeMxSIJXgWV5RJ8lr1YF4yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734407811; c=relaxed/simple;
	bh=arZH8wml6AT9zJI+tM6LObAj292jKK9legVNPvfwbaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MMEXHq1ZikT8JZ7hbk2W0ugK7PgFEdi0LJ+LH57GPY+nNRQI6/FzBovP42FRgs7K56hVx0V2wlHWGh/VVOFIG3Z+8Vw92g0sZVAF++iOy5HMp9Lx45P0NfrGcMW7P3XjLF70HDK/ctDqmH5fo/zLIc1KBsdtMlq49kvyGOvM/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kCpRFeaR; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=tTzf7
	6yZq9yXiN59rqqtrq/Asv5rbCSWbmTGGzC2TiI=; b=kCpRFeaRtMfwYlihLQaSM
	mFwAuNmhmOrhgmzFwgW+eRkaSolr59cemsipfvp0y8SQWgjBRTFP+D5XkY9KiAUE
	6vCTT9HHM+Bmb9RW8SfLYAP1XIKYnCM7IurpOLpLhdvI01mWwVMy/bPhGIYUkcwM
	YbWIdYOijoMRwSpWuNjkzo=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC3z3rn9WBnjJxUBA--.60828S4;
	Tue, 17 Dec 2024 11:54:21 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: bhelgaas@google.com,
	rafael.j.wysocki@intel.com,
	yinghai@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: fix reference leak in pci_alloc_child_bus()
Date: Tue, 17 Dec 2024 11:54:13 +0800
Message-Id: <20241217035413.2892000-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3z3rn9WBnjJxUBA--.60828S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWxGr1fCr1UKw1rZw15CFg_yoWfWrcE93
	W09F97Wr4UK3WxKw1ayw13Z392k3WDZrZ3urW8tF1fZa43Zr4q9F17Zry8Cw4qganrCr98
	Aa4jvr1vkr1UWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWGQhUUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbizRa4C2dg7-GeEgAAs9

When device_register(&child->dev) failed, calling put_device() to
explicitly release child->dev. Otherwise, it could cause double free
problem.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 4f535093cf8f ("PCI: Put pci_dev in device tree as early as possible")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/pci/probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2e81ab0f5a25..d3146c588d7f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1174,7 +1174,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 add_dev:
 	pci_set_bus_msi_domain(child);
 	ret = device_register(&child->dev);
-	WARN_ON(ret < 0);
+	if (ret) {
+		WARN_ON(ret < 0);
+		put_device(&child->dev);
+	}
 
 	pcibios_add_bus(child);
 
-- 
2.25.1



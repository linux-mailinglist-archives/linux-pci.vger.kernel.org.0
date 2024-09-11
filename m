Return-Path: <linux-pci+bounces-13024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BD097485A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 04:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4D4286EBA
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 02:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE02628DB3;
	Wed, 11 Sep 2024 02:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OOB5qYis"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF1A10A0E;
	Wed, 11 Sep 2024 02:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023114; cv=none; b=UH0J5O1pk+ElgFQgN5cWyCXOpc+7LLYhgKYlRBHBU6EBPAoLLPchvKQ4DbVe7s5IwN7UfsIgiyO8y+V1/tktpfTyHakt+uMVZsG17EO3OMV+xlJ2c7XHorXavrvUk/IuZURKEVmzEEu4K0rznn7bKaFBY4ApnaVfyEY00Z0N0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023114; c=relaxed/simple;
	bh=9RZETYlLoaBlirj8L6uudP2LhEP7WvyysHkTBqlbSs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IECrHm5qgWXi28pj5joHK0J7jvbJ995vrufqb2lBawCQmRGzmE2/moRabhdxh+6/Pa6BqmlG7bjib4+h6L9jkNXJb6xlzX7FyL4eBkWEICoz6+Pc0wQwL4yWFusSq0b8feTC1XInQr83qGs0OdnfqUFywHErEubcDoXN+UFhUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OOB5qYis; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=XcfM8
	rMwEbHhMHFUtYHnV/45MtNbvG78hwxW37VYfJI=; b=OOB5qYis6GL/Zff4J0vc1
	oaMCoNB7F+Ztc4nTZx1VpJ75RSTeKlXTBf2P77w3JlusD4zVm6ZB4a89V7mHHuIB
	EuUlXgRFXOQNoEt+cXR465hWnUWbW2od4jKj/qnyvZ8PyK7BtS3G3PKtHM9K+FjI
	VJA7wWM8LrBSjTD1G1+TZE=
Received: from iZbp1asjb3cy8ks0srf007Z.. (unknown [120.26.85.94])
	by gzsmtp3 (Coremail) with SMTP id sigvCgCnu8CkBeFmDgjmBQ--.5195S2;
	Wed, 11 Sep 2024 10:51:17 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	james.quinlan@broadcom.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH] PCI: brcmstb: Fix control flow issue
Date: Wed, 11 Sep 2024 10:50:59 +0800
Message-Id: <20240911025058.51588-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:sigvCgCnu8CkBeFmDgjmBQ--.5195S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFy7Jr17KrykJF1UZF4fKrg_yoWDKrc_ua
	4j9FnrGFWq9r9ag3sFvw45tFWfCa42qrnIq3Z5t3WfAasIyrn2qr1kZrZxG3W8Gr4UJrn7
	AF1jvr1rCFykAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjByIUUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRQVXamXAo1cH2QAAsy

The type of "num_inbound_wins" is "u8", so the less-than-zero
comparison of an unsigned value is never true.

Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 55311dc47615..3e4572c3eeb1 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1090,9 +1090,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
-	num_inbound_wins = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
-	if (num_inbound_wins < 0)
-		return num_inbound_wins;
+	ret = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
+	if (ret < 0)
+		return ret;
+
+	num_inbound_wins = (u8)ret;
 
 	set_inbound_win_registers(pcie, inbound_wins, num_inbound_wins);
 
-- 
2.39.2



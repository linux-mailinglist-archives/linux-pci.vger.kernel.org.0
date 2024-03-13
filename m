Return-Path: <linux-pci+bounces-4773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93CA87A542
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 10:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8529F2813D7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 09:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E704B28399;
	Wed, 13 Mar 2024 09:51:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from vm3.sequanux.org (static.68.236.76.144.clients.your-server.de [144.76.236.68])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7EB2E636;
	Wed, 13 Mar 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.236.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323469; cv=none; b=ldq98eeyR87LjEigRx2Dbm2GxYIoqoOF4KteH8DwiOpfLk97j+AZkn9CXeBcBaxy1ANxM+snH2OgrPL7bO11v3JiOUKsx90FziqetU0wJGAeb8VKykYaCs4iPx8M7jU8R+ldwLhFeUTOTyXqtIyYhbMenWZiYgEKcbXjH30ewG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323469; c=relaxed/simple;
	bh=uXuPE3VKA7NxuaIY5UcFuFsMWM4D2G9o+mMSlbTcRfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwcrbJvaPiSKGjaoSv1IYnb753WYTg+39sblaI5scDhN9m5YGkhSDq9yetEZMRqyEd7vj9kvt9TsGPzxMp2nZPzOY7fRS4vU90Qr0KY9yM+eje3ipZj5Yl9QJnke+f6fv4FN+GJOPkk3sCMcayMfhetEncBLewMS1YdlFq7eADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=seagate.com; spf=pass smtp.mailfrom=sequanux.org; arc=none smtp.client-ip=144.76.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sequanux.org
Received: from localhost (localhost.localdomain [127.0.0.1])
	by vm3.sequanux.org (Postfix) with ESMTP id C4572108B3E;
	Wed, 13 Mar 2024 10:50:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
	by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lBvAo3xPwqFl; Wed, 13 Mar 2024 10:49:55 +0100 (CET)
Received: from localhost (88-167-49-193.subs.proxad.net [88.167.49.193])
	by vm3.sequanux.org (Postfix) with ESMTPSA id 45F3A108ADB;
	Wed, 13 Mar 2024 10:49:55 +0100 (CET)
From: Simon Guinot <simon.guinot@seagate.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Maciej W . Rozycki" <macro@orcam.me.uk>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Guinot <simon.guinot@seagate.com>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: fix link retrain status in pcie_wait_for_link_delay()
Date: Wed, 13 Mar 2024 10:49:38 +0100
Message-ID: <20240313094938.484113-1-simon.guinot@seagate.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code in pcie_wait_for_link_delay() handles the value
returned by pcie_failed_link_retrain() as an integer, expecting 0
when the link has been successfully retrained. The issue is that
pcie_failed_link_retrain() returns a boolean: "true" if the link
has been successfully retrained and "false" otherwise. This leads
pcie_wait_for_link_delay() to return an incorrect "active link"
status when pcie_failed_link_retrain() is called.

This patch fixes the check of the value returned by
pcie_failed_link_retrain() in pcie_wait_for_link_delay().

Note that this bug induces abnormal timeout delays when a PCI device
is unplugged (around 60 seconds per bridge / secondary bus removed).

Cc: stable@vger.kernel.org
Fixes: 1abb47390350 ("Merge branch 'pci/enumeration'")
Signed-off-by: Simon Guinot <simon.guinot@seagate.com>
---
 drivers/pci/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ccee56615f78..7ec91b4c5d03 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5101,9 +5101,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 		msleep(20);
 	rc = pcie_wait_for_link_status(pdev, false, active);
 	if (active) {
-		if (rc)
-			rc = pcie_failed_link_retrain(pdev);
-		if (rc)
+		if (rc && !pcie_failed_link_retrain(pdev))
 			return false;
 
 		msleep(delay);
-- 
2.43.0



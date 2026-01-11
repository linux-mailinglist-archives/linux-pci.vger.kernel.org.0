Return-Path: <linux-pci+bounces-44435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3ECD0E1F7
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jan 2026 08:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36144300660A
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jan 2026 07:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBA7257423;
	Sun, 11 Jan 2026 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="bdhzIPZQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A7C250C06;
	Sun, 11 Jan 2026 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768117135; cv=pass; b=Rkm8/kAXXoSs5zV8Whawl19DiLa3tnpuuamJFFX4gDqZR+qIAWWnbgTJ8thlFaN9rRuK+fmi2N4dn848NzuQPH8rn64jTMFSLAjN05SmdbT6NDwYS7ZrSw0BGg44KLbCAgvPfKD+k2LaWESbNex6Gmmc4iwgL83tJuknolTpzDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768117135; c=relaxed/simple;
	bh=qFP3QIZpz2GVO6OFem1qWqhJ9hdu4IrMCPU9teOB+5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nv8OD2GnGGwKGxWaw2SzUPPTUqqZXbgIIhO8A6INeI6tCEeFFDk/iHDxYYcj4SiUd90/gSG7bSLkg74dW2V4gXJQBnNOuvZWnYENawU4z3o7IyEMNV6Q7xOUUYLp3cMUbKbT/MMNKF0spMuYuM0hpx0UEvh8oBvXBVZlswnNyvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=bdhzIPZQ; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1768117129; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QUGnjDtFoMN3u2jE10dBs6j1EYidAdwcalVUiklqtiK+A/Q+NdFubao8ljN9OcuAQsZ/S1egvayU9M6jcKHqbpg+KRaBIX2wSOepxQa0UvCMrSXKjGIaaNAVkhaMA2AbNqQ0+80Kx7JAmqQ9JOO5iA/nwWkQdA4Ywb25Mcegx6E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768117129; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QDrIhAeKJui/DEXRJtly1VvU3Jb9pvZaZDDR4BNVDrQ=; 
	b=gN5hPgkj7mcnFNel4vkTZHjWGcoKAa00RBAAkF7yrC+4phpRZGvxXRI4MbWCMflOtfejVMq+WVEQ5+hezKLXHyHSWOho8ows37ox4V+SdEL2PXScu3xU3UsFFv/OBjNkcWXk7S2dzXZ+7+pMRIw/mXZfi/PNE1/o0Mfh8ruVwbQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768117129;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=QDrIhAeKJui/DEXRJtly1VvU3Jb9pvZaZDDR4BNVDrQ=;
	b=bdhzIPZQTxOzov7ccyj8f6m8s7Zq5UJf05Qgv9MyDY7r/b/8CTgLIVBdxaEs4N2Q
	hfd4SVW40v7YH7EUUlkeJIMBLNeJaZtXspzsuSkkcjSS7UCsrXs9p9HtR4ED0jJ8Xpy
	Kyuf85qfCz6RFLVQWjvo3462+L2PONaZj2IhUijA=
Received: by mx.zohomail.com with SMTPS id 1768117125456560.8214843784988;
	Sat, 10 Jan 2026 23:38:45 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dan.j.williams@intel.com
Cc: linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH 1/1] PCI/IDE: Fix reading a wrong reg for unused sel stream initialization
Date: Sun, 11 Jan 2026 15:38:23 +0800
Message-Id: <20260111073823.486665-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227efd45e7aa253df03a5321344000030c5b9857f10fff8da6b3a82c1944ef512470b5dea8b8c3a87:zu08011227aa66b4faafa3813863fd1e6d00008aaf58facbae80da1243eedbae44fda1786bb5bb851dd1b074:rf0801122b3271035a8c9170a1fe0bd4e7000005b158552355fabc6f4d1c2847e229cb387b276593d9b881d806f5d2ab:ZohoMail
X-ZohoMailClient: External

During pci_ide_init(), it will write PCI_ID_RESERVED_STREAM_ID into all
unused selective IDE stream blocks. In a selective IDE stream block, IDE
stream ID field is in selective IDE stream control register instead of
selective IDE stream capability register.

Fixes: 079115370d00 ("PCI/IDE: Initialize an ID for all IDE streams")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/pci/ide.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index f0ef474e1a0d..26f7cc94ec31 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -168,7 +168,7 @@ void pci_ide_init(struct pci_dev *pdev)
 	for (u16 i = 0; i < nr_streams; i++) {
 		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
 
-		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
+		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CTL, &val);
 		if (val & PCI_IDE_SEL_CTL_EN)
 			continue;
 		val &= ~PCI_IDE_SEL_CTL_ID;
-- 
2.34.1



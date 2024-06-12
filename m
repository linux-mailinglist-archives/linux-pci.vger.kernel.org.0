Return-Path: <linux-pci+bounces-8654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A137904F35
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 11:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61521F228BA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DDD16DEB4;
	Wed, 12 Jun 2024 09:25:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id DDFD816DEBD;
	Wed, 12 Jun 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184305; cv=none; b=JCLJ8Va843RcUmoKmhV6ydc4neZ2iPETRRuTaKJCPlCLOEh4XWnEFaJNu9bnwRDfkOtcsgQ8bQGrDSGcd7fk6VA+1YdS8TwVIAHam+cgMIcdBtkB7Kj0eL9CjoAZk67lIarefm8TLOxksjcvKDdgNHWfssjPNfEABlNFtuAMVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184305; c=relaxed/simple;
	bh=y/Id/6mYGNFx79wmtV6dsWicXfmEWQHuHrwffEPyyjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N0rSFWfwQcRBSLmYZn1/172199anQt7yRKUXdkVYZT0BAN25EOW/7IKY3C4DNkOFz12+Oj6euQ3GPPmyy9yzphbKIdQP0afqbwgsuQeY1nF5u/mxZPPGP10p2KYder5CJUf7l3PhOXs2QlbTaVcn8151J81bTQcXRY2KPpmOLHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 96FED60230176;
	Wed, 12 Jun 2024 17:24:49 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: jgross@suse.com,
	bhelgaas@google.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?x86:=20pci:=20xen:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20ret?=
Date: Wed, 12 Jun 2024 17:24:06 +0800
Message-Id: <20240612092406.39007-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ret is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 arch/x86/pci/xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 652cd53e77f6..67cb9dc9b2e7 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -267,7 +267,7 @@ static bool __read_mostly pci_seg_supported = true;
 
 static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
-	int ret = 0;
+	int ret;
 	struct msi_desc *msidesc;
 
 	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_NOTASSOCIATED) {
@@ -353,7 +353,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 bool xen_initdom_restore_msi(struct pci_dev *dev)
 {
-	int ret = 0;
+	int ret;
 
 	if (!xen_initial_domain())
 		return true;
-- 
2.18.2



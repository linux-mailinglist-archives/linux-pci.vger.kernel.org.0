Return-Path: <linux-pci+bounces-10199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE4F92F87D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 11:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D5D1C20CC1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 09:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D7414F109;
	Fri, 12 Jul 2024 09:55:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C2E158862;
	Fri, 12 Jul 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778117; cv=none; b=qlOiMzpdQOKJxpuConhSvdDYIcPyx+CFBcOhLZROrSzVL3D6u5pVDkFfY7WzaG4uoq792qHAC97n0o3vbBuNcWcbLhv+lIynh4gWX9VtCft2H+ltLPMWqWe4mP37PrEBhZGIL03cPSHyzo1MZFdunsIXFFzTUWmi0BiS2cXdn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778117; c=relaxed/simple;
	bh=iJgyElM1/pCaQWMPuPOElKf2CgYLrCM9dalPOtcCNOA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nchOfJMQC9CzRxe2eHcizdpdd3WKybbeyxCDG6T2NtKypvt0CbnjuOe2qvRLYysU0BnJ6xkS9v38RtJR2K7b9oBfXXSSoIujobQYTj7w9DGOwcT6x/rrGqiTPMYhfc1kaNxkUgaag3spClLusTEX3jh426R/1fhMqeZVL+grRzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.111] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <adiupina@astralinux.ru>)
	id 1sSBvU-000fCI-5b; Fri, 12 Jul 2024 11:46:48 +0300
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.232.141])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4WL4vz0csjz1c00g;
	Fri, 12 Jul 2024 11:46:55 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] PCI: kirin: Fix buffer overflow
Date: Fri, 12 Jul 2024 11:43:09 +0300
Message-Id: <20240712084309.13248-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgrucffihhuphhinhgruceorgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeduleetfeehffekueeuffektefgudfgffeutdefudfghedvieffheehleeuieehteenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudejjedrvdefvddrudegudenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdqfedtvdeiledtrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepuddtrddujeejrddvfedvrddugedumeehledtjeeipdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehsohhnghigihgrohifvghisehhihhsihhlihgtohhnrdgtohhmpdhrtghpthhtoheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtohepfigrnhhgsghinhhghhhuiheshhhishhilhhitghonhdrtghomhdprhgtphhtthhopehlphhivghrrghlihhsiheskhgvrhhnvghlrdhorhhgpdhrtghpth
 htohepkhifsehlihhnuhigrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhgthhgvhhgrsgdohhhurgifvghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhgnecuffhrrdghvggsucetnhhtihhsphgrmhemucenucfvrghgshem
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1720716691#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12048491, Updated: 2024-Jul-12 06:59:55 UTC]

In kirin_pcie_parse_port() pcie->num_slots is compared to
pcie->gpio_id_reset size (MAX_PCI_SLOTS). Need to fix
condition to pcie->num_slots >= MAX_PCI_SLOTS to
avoid out of bounds array access.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b22dbbb24571 ("PCI: kirin: Support PERST# GPIOs for HiKey970 external PEX 8606 bridge")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index d5523f302102..5ef3384c137d 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -413,7 +413,7 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 				continue;
 
 			pcie->num_slots++;
-			if (pcie->num_slots > MAX_PCI_SLOTS) {
+			if (pcie->num_slots >= MAX_PCI_SLOTS) {
 				dev_err(dev, "Too many PCI slots!\n");
 				ret = -EINVAL;
 				goto put_node;
-- 
2.30.2



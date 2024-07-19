Return-Path: <linux-pci+bounces-10549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB0D9377B4
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C618E1C21411
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 12:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC2512D76F;
	Fri, 19 Jul 2024 12:22:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5813BC12;
	Fri, 19 Jul 2024 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391766; cv=none; b=aFgEZKZjV4bkaBP4IC2gNtdvzX0LY92KLbU2M+i4hU530BYTn93+ERGn3z+FsObGTOj3GT4Ymlatp3zZnkIvNM0nRgBSMGzG36Fjm2KL7L3xM57iA4LyttQ8XifpMu22GRwgrWa8EVOPPdr5pzhSqcgKbmp6PXzWVSqBG77+XXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391766; c=relaxed/simple;
	bh=bxR3nS1VZl0CDwdrPeM6b2Wn4hUOxC+NEBSLsWj4C0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rihfd1TMYt8HEP4wdHfj/SV8exQnHB/HPShL11zpelfH82nxvTaOt/3jVJWB9UOwC5YSWFx6r1+MoTYAUZCH4gXt7rbwP6z6xrttEX1PEhiykb7CVti1HFHg2M0pbZVZ1GOj1uNJfg/Gy3lo0irFO9Er9pIrxjH/0QkXJlIko8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.109] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <adiupina@astralinux.ru>)
	id 1sUmcY-002HTS-Db; Fri, 19 Jul 2024 15:21:58 +0300
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.234.121])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4WQTM82WHFzkWJv;
	Fri, 19 Jul 2024 15:22:12 +0300 (MSK)
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
Subject: [PATCH v2] PCI: kirin: Fix buffer overflow
Date: Fri, 19 Jul 2024 15:21:53 +0300
Message-Id: <20240719122153.1987-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240712110756.3abe1806@foz.lan>
References: 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgrucffihhuphhinhgruceorgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeefkedufedvkeffuedtgfdugeeutdegvdffffejfffgleffieduhfejvdelffdvudenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudejjedrvdefgedruddvudenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdqfedtvdeiledtrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepuddtrddujeejrddvfeegrdduvddumeehudejkedtpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehsohhnghigihgrohifvghisehhihhsihhlihgtohhnrdgtohhmpdhrtghpthhtoheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtohepfigrnhhgsghinhhghhhuiheshhhishhilhhitghonhdrtghomhdprhgtphhtthhopehlphhivghrrghlihhsiheskhgvrhhnvghlrdhorhhgpdhrtg
 hpthhtohepkhifsehlihhnuhigrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhgthhgvhhgrsgdohhhurgifvghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhgnecuffhrrdghvggsucetnhhtihhsphgrmhemucenucfvrghgshem
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1721386332#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12057070, Updated: 2024-Jul-19 10:47:19 UTC]

In kirin_pcie_parse_port() pcie->num_slots is compared to
pcie->gpio_id_reset size (MAX_PCI_SLOTS). Need to fix
condition to pcie->num_slots + 1 >= MAX_PCI_SLOTS and move
pcie->num_slots increment lower to avoid out-of-bounds
array access.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b22dbbb24571 ("PCI: kirin: Support PERST# GPIOs for HiKey970 external PEX 8606 bridge")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
v2: some changes
 drivers/pci/controller/dwc/pcie-kirin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index d5523f302102..deab1e653b9a 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -412,12 +412,12 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 			if (pcie->gpio_id_reset[i] < 0)
 				continue;
 
-			pcie->num_slots++;
-			if (pcie->num_slots > MAX_PCI_SLOTS) {
+			if (pcie->num_slots + 1 >= MAX_PCI_SLOTS) {
 				dev_err(dev, "Too many PCI slots!\n");
 				ret = -EINVAL;
 				goto put_node;
 			}
+			pcie->num_slots++;
 
 			ret = of_pci_get_devfn(child);
 			if (ret < 0) {
-- 
2.30.2



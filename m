Return-Path: <linux-pci+bounces-10268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C021D931616
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 15:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751B21F2222F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFBF18E752;
	Mon, 15 Jul 2024 13:51:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D541741CF;
	Mon, 15 Jul 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051466; cv=none; b=edSVs+eGqAm4LJzZuyIRCPa+fInXXDCDbpO7+6K5DCVUjuRcDgthyVimH3Ioqf0h5INbdeleFRdnqZgrys/KrfBt7F/LyDmNgQwrhu11NPIGQ7Qk6ecIvgyQdnmqexL9foCoIdSUVk+Ky4jWXS8evJmk0zKXoJ7U/X8BawReNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051466; c=relaxed/simple;
	bh=/VJ+tO1EzK72NliTLYlR895MqeLFIMWZ2yIPHOPHy+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fQ3eXKww98fGufYjnA0kuxQNwFy+O+wBh2lwc5sXBPQvGjy+tWaOAkG0gEeqbUToVuJkqdM63M0VenphXu7uLIPVSRB6HXCe43wyvqSudw8HKNIpHd6mPBFTfRYkyx9Tn4ddjNzqwTfWKe8qHNO7VTXACz/hPp8xWgy2l+4BE80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.111] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <abelova@astralinux.ru>)
	id 1sTM5p-001e26-OJ; Mon, 15 Jul 2024 16:50:17 +0300
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [185.155.16.139])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4WN3Vq5zDxz1c00g;
	Mon, 15 Jul 2024 16:50:27 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH RFC] PCI: kirin: prevent buffer overflow in kirin_pcie_parse_port
Date: Mon, 15 Jul 2024 16:49:17 +0300
Message-Id: <20240715134917.14760-1-abelova@astralinux.ru>
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
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhgrshhtrghsihgruceuvghlohhvrgcuoegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeffvddvueehvedvgfeivdeuvdduteeulefgfeehieffgfehtedutdfgveefvdeiheenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedukeehrdduheehrdduiedrudefleenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdquddtiedtiedvrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepudekhedrudehhedrudeirddufeelmedvudekvdehpdhmrghilhhfrhhomheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepshhonhhggihirghofigviheshhhishhilhhitghonhdrtghomhdprhgtphhtthhopegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtohepfigrnhhgsghinhhghhhuiheshhhishhilhhitghonhdrtghomhdprhgtphhtthhopehlphhivghrrghlihhsiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
 ifsehlihhnuhigrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhgthhgvhhgrsgdohhhurgifvghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhgnecuffhrrdghvggsucetnhhtihhsphgrmhemucenucfvrghgshem
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1721042446#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12051090, Updated: 2024-Jul-15 12:02:51 UTC]

If pcie->num_slots = MAX_PCI_SLOTS, i equals MAX_PCI_SLOTS
during the next iteration. Then pcie->gpio_id_reset is accessed
by invalid index. Strengthen check on pcie->num_slots to
prevent this.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b22dbbb24571 ("PCI: kirin: Support PERST# GPIOs for HiKey970 external PEX 8606 bridge")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
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



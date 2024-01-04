Return-Path: <linux-pci+bounces-1688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB5B824943
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 20:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E420F1F22EA4
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 19:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC396241EF;
	Thu,  4 Jan 2024 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VG1fTf00"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF082C1A8
	for <linux-pci@vger.kernel.org>; Thu,  4 Jan 2024 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id LTlmr0sApT1UwLTlnrLohA; Thu, 04 Jan 2024 20:52:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704397969;
	bh=27dEHxVblqRTmzTZNOjf3Gz5VvfI9uGlpElf6m2975Y=;
	h=From:To:Cc:Subject:Date;
	b=VG1fTf00F44jamkjYhcZD4fxQltM1JJRDg1foif2iDelfGbansTjbmPbE5KRFG7pB
	 ZsX3svidGOVGFB2dwRhBMkJ6APdV1YJYkbUmAZvywmdRuvGT4WXpi/ZfudQz0PImwI
	 FYVC6k+skJWAQLwG5VsMwPc3R8Tg2PH+M933Nb+rf/eNdc79IB1UaDES4Po7STOhD9
	 iLJeaPvbd8URy695x5dve5mGGutCn6WDhjS96+MnaKjMqyyIOfmDoaVFFu13qRK3PT
	 7JXfgd+7/HwqjXeQ0HVgqLg6VJIgVVLDFDYmuXG5e/beDjPtJzAtrBPh+yIAvCd/Fs
	 DEd0+k/kIyR5Q==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 04 Jan 2024 20:52:49 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Eric Dumazet <edumazet@google.com>
Cc: alexis.lothore@bootlin.com,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/P2PDMA: Fix a sleeping issue in a RCU read section
Date: Thu,  4 Jan 2024 20:52:35 +0100
Message-Id: <02d9ec4a10235def0e764ff1f5be881ba12e16e8.1704397858.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not allowed to sleep within a RCU read section, so use GFP_ATOMIC
instead of GFP_KERNEL here.

Fixes: ae21f835a5bd ("PCI/P2PDMA: Finish RCU conversion of pdev->p2pdma")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative.
It is based on a discussion related to another patch. See [1].

It also matches the doc, IIUC. See [2]

[1]: https://lore.kernel.org/all/20240104143925.194295-3-alexis.lothore@bootlin.com/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/RCU/whatisRCU.rst#n161
---
 drivers/pci/p2pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 0c361561b855..4f47a13cb500 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -661,7 +661,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	p2pdma = rcu_dereference(provider->p2pdma);
 	if (p2pdma)
 		xa_store(&p2pdma->map_types, map_types_idx(client),
-			 xa_mk_value(map_type), GFP_KERNEL);
+			 xa_mk_value(map_type), GFP_ATOMIC);
 	rcu_read_unlock();
 	return map_type;
 }
-- 
2.34.1



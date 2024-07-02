Return-Path: <linux-pci+bounces-9601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C061292464C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 19:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D87C284027
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 17:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3E71BD00C;
	Tue,  2 Jul 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dehl02sl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0485263D;
	Tue,  2 Jul 2024 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941614; cv=none; b=jRYfbj04qYJ+fHs2nb3Fw9rynBM8zQRDUWIb+3+QMDUnO0eeqiZZa4LrULc5bocoeI3GXwu690RYw/SyCoa/LXOCnzjDVYJbTHKKHgeIJCddtut3poj6Ried2xWeXkcdmv5QzqPGKGIVpeWll7x8aLU6U99j59kMO5tw3/47hwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941614; c=relaxed/simple;
	bh=4j4GNVQr5opjEZRmGefLrNlSuzcnLcQvhwYiSey2+3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tpZQeT146RgIcoBU3VBKEYus+4Tj4fPnoGY2tOc+rqNOGvQROEo8UiKV6lAkr0LhDXGiwn0w5Vk8IiHuBotcXmj7AetB1SVxwF6qtr9SgVPXnLDMK7vlqdeeaSlAuW0UmMeaN6KdkZraIi1+aRwsB+xta9P52UKoPYyRyRy142k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dehl02sl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7675C116B1;
	Tue,  2 Jul 2024 17:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719941613;
	bh=4j4GNVQr5opjEZRmGefLrNlSuzcnLcQvhwYiSey2+3s=;
	h=From:To:Cc:Subject:Date:From;
	b=Dehl02slIB5zW97q15CrYsnx7M9ox/nTrm95yti7+WWj7oLuNtjwC8zT9ak7ulQGU
	 /7s6v53YAmAUGCmE8f1ynLVqTgjlRWS2PAVtEk9eRhVQNbDtHVDGGX2aTLeOf36pZn
	 PN7gKwtBffLrX6X6578xfAiqDwbP2fKl2K5btX3j0qHa4TeWAwAVSOSr7S8RIanBHn
	 M7c3cOOfEZbb3da+QJaIHHrPCbRW9GGwKrrkyc8BcnayCyYJyEuSibPOq9Pyh0m/Cr
	 sR9ndMBmg9ZkOXMlzQLZUZPIys26bYyQgGMdDBwNkjkD8E079JocKlJnFkBK/8n46L
	 AkQDb7QQ7d1dQ==
From: superm1@kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Amit Pundir <amit.pundir@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Praveenkumar Patil <PraveenKumar.Patil@amd.com>
Subject: [PATCH] PCI/pwrctl: Decrease message about child OF nodes to debug
Date: Tue,  2 Jul 2024 12:32:55 -0500
Message-ID: <20240702173255.39932-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

commit 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF
nodes of the port node") introduced a new error message about populating
OF nodes. This message isn't relevant on non-OF platforms, so downgrade
it to debug instead.

Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD, SM8650-QRD & SM8650-HDK
Cc: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T
Reported-by: Praveenkumar Patil <PraveenKumar.Patil@amd.com>
Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index e4735428814d..f21c4ec979b5 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -354,7 +354,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
 					      &dev->dev);
 		if (retval)
-			pci_err(dev, "failed to populate child OF nodes (%d)\n",
+			pci_dbg(dev, "failed to populate child OF nodes (%d)\n",
 				retval);
 	}
 }
-- 
2.43.0



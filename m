Return-Path: <linux-pci+bounces-9605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95AF92470A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 20:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4A71C24D4E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 18:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CDF1C2326;
	Tue,  2 Jul 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkbw+xiu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D154155335;
	Tue,  2 Jul 2024 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943726; cv=none; b=ltU9TbCUlKHNeCtZ9clRFvtXxxVrxvFvqnEdSkvDt9IugEIJhrbg5dF4APtLPsefYaDr+ySktvwrLJSK1XJ9u/Pzy4LXZmqnf6JPgnppvbAYB7gFk34aD7lH/VNlCatb4bU8VnqMMSfgwcQNK9DP4Z9uMqevyj3ZJPfi1sntOJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943726; c=relaxed/simple;
	bh=IUi3uSUZQAw5Riqhu+TgA8XxfGbUroM8JamWvkf8Q9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJspw96O6Sb57NL38I+PsIlMA9RCsEYZsFcOYcehI09QtuuWJbG/lGvb01QOVIno0AkEf2TYYWe60HY+y2GtS4dNHQYZn+BxLQGQSYijyt1TIO5GHuJN8V/GyNWpoUOaE/cgwDd8VbBjXiUtxbcoTF2Fcl80wu8tk0ZV5ygDAHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkbw+xiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26ADC116B1;
	Tue,  2 Jul 2024 18:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719943725;
	bh=IUi3uSUZQAw5Riqhu+TgA8XxfGbUroM8JamWvkf8Q9Y=;
	h=From:To:Cc:Subject:Date:From;
	b=lkbw+xiuQO6qiM6yI2X3gfphX9kbv/0Cn5e745lM9SaTuogVWG/G2XGZlyLpaNbxg
	 GoQNvZBqhM6wCLziFEPT8wOLUeNiTHvaMx+JHEKTsHpforWwGzw5y2inZ8pBHPkWWs
	 ESMGPJNmcSaBPtkdrq17qvC40ACXQ0yTiFbINNSV30DmoX5YzW4Sluu8DPIV5DGdUM
	 jFJSlr/VG73ZgixnVMhEgxWdwxG+MA5D94+/Xh+Hg/O+eIew3FrqPVQd1uLkGSa5ZV
	 WXoJ+baalpziO+/9vMD3hW3HkWntMprsMcXQo2zYKiX7evlE/Q+GWb0kIedbO/RT8/
	 fqNfF9OQWJPmA==
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
Subject: [PATCH v2] PCI/pwrctl: Don't show error when missing OF nodes
Date: Tue,  2 Jul 2024 13:08:39 -0500
Message-ID: <20240702180839.71491-1-superm1@kernel.org>
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
OF nodes. This message isn't relevant on non-OF platforms and
of_platform_populate() returns -ENODEV in this case, so don't show the
message on non-OF platforms.

Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD, SM8650-QRD & SM8650-HDK
Cc: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T
Reported-by: Praveenkumar Patil <PraveenKumar.Patil@amd.com>
Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Catch -ENODEV case instead (Bartosz)
---
 drivers/pci/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index e4735428814d..231bc796ba04 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -353,7 +353,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	if (pci_is_bridge(dev)) {
 		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
 					      &dev->dev);
-		if (retval)
+		if (retval && retval != -ENODEV)
 			pci_err(dev, "failed to populate child OF nodes (%d)\n",
 				retval);
 	}
-- 
2.43.0



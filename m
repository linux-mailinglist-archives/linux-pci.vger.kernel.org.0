Return-Path: <linux-pci+bounces-27220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BB7AAAA10
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 03:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094771888479
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 01:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FBF2DA824;
	Mon,  5 May 2025 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYDHKV1+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C4435F7DB;
	Mon,  5 May 2025 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485247; cv=none; b=gXL3J/JiWVKtI1WIoJBHLGQwjGx/lp8AuTx+oumr1581S8oFoMnJEso5W9yzJSadT+3CJdGxu4B1jKqa9OGw3kWv8FgPsit7NJsP/+WQY0sui8CEUn/Hqtmdm8EprjdMRwreDgVOp5LnDK8fpngblSEa3mCHAcRDjZH36LRymIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485247; c=relaxed/simple;
	bh=aSd5hagqSaRt+Za6bQY+Lb0/Aw8Qrfh70/kF32BdePM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=av43rCSZu9LXZtLRY2/uutf7DsOb+/NgkgchdQSuM7vhMWQ8VpD1DwLEi950BPhlFJdj6zaMC3iwceiGHPUt6RVe1BUgo1h0093z7cCIoxyry2kjHuGhVntjlkN3gILtQoHdzMsaT5y3fiRZcydr/2iBZrTerYuwFl6ZHXGZkHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYDHKV1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1D3C4CEF4;
	Mon,  5 May 2025 22:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485246;
	bh=aSd5hagqSaRt+Za6bQY+Lb0/Aw8Qrfh70/kF32BdePM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYDHKV1+iyeW7h5bmUSbBe2x0o7rnFYH45MbfUjocYhOFjYsAOUxEa1Jn6WxnlW3b
	 75PCcJ1B17ijpbZHQD/ZZ5J6IAaVCJP8T/1MitY6n12Hh1TUklnQjlRp3QGASA6Qq1
	 i9LcAiuv4DWbZv25EqyP7/Qakt1UMORNyO/TunHFu5xqTffwGTxBI6Y2yJmlpciHRo
	 gU0wUIpWPLvWufxAJQ9ZCon5NuPFpahkwQ0F2Wx24rAdjlzdlK61fJ1STgYNVxEecQ
	 M2ZuZP6YAo8jczI2ZPMBhrg6VXVqDP6SpeHwWn0pKOX0of/bwDFXuqwZ/g9B4XH5+h
	 uCJ8DWd99g2Nw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stanimir Varbanov <svarbanov@suse.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Ivan T . Ivanov" <iivanov@suse.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jim2101024@gmail.com,
	nsaenz@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 233/486] PCI: brcmstb: Add a softdep to MIP MSI-X driver
Date: Mon,  5 May 2025 18:35:09 -0400
Message-Id: <20250505223922.2682012-233-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Stanimir Varbanov <svarbanov@suse.de>

[ Upstream commit 2294059118c550464dd8906286324d90c33b152b ]

Then the brcmstb PCIe driver and MIP MSI-X interrupt controller
drivers are built as modules there could be a race in probing.

To avoid this, add a softdep to MIP driver to guarantee that
MIP driver will be load first.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Ivan T. Ivanov <iivanov@suse.de>
Link: https://lore.kernel.org/r/20250224083559.47645-5-svarbanov@suse.de
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 32ffb0c14c3ca..81f085cebf627 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1947,3 +1947,4 @@ module_platform_driver(brcm_pcie_driver);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Broadcom STB PCIe RC driver");
 MODULE_AUTHOR("Broadcom");
+MODULE_SOFTDEP("pre: irq_bcm2712_mip");
-- 
2.39.5



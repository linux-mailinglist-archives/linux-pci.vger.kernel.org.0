Return-Path: <linux-pci+bounces-27211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1FDAAA56C
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 01:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0F13A746E
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 23:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A4428BAAA;
	Mon,  5 May 2025 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq5Ouzo3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F1127A129;
	Mon,  5 May 2025 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484160; cv=none; b=CmDTY5FEuYneDQ/NIGTQ/D1YF63GlxVPoG8vVLjptd6qqqoixC37viJLSkurMuewfbZ2bhVvLIH09z5HrvZ+W8kJhbwzrirDTadGAzzsTctlaNUibi0hLTnVIhdHWwifeMqt91FdZS2DxnVD25ZPYwwbIYru7qK1VtOBdNNxzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484160; c=relaxed/simple;
	bh=Z9HB7iTaGh8+A2xdZVVazaRVXRFenN7A9Qx9x6F2uho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+iYbvWKpLeCmMJM/qMmHfrr67DdKGomEllL2dsycRT1A5Fq0spNXsINxUF2Nc2bVYNkNnGlOlySU5Hu7gReQvgj1hN/DEXtqCcS28RWALf+xv9lF+UfjiN80eqRgtpV8PpGifN2bPJoDbEHonwf6BNIWIoLJvO9Kw7eZozEB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bq5Ouzo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDCEC4CEE4;
	Mon,  5 May 2025 22:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484160;
	bh=Z9HB7iTaGh8+A2xdZVVazaRVXRFenN7A9Qx9x6F2uho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bq5Ouzo3j4CfWduVMLxq12pADMVm+eB/w50qD5+3hCHCr0HsLEzwORgtB1nQiLcgR
	 2ooi4fw33XnXgzxtXgTYs9jYC9DhsOq9e2KsHgHqMBYWemRfGnPzk9XZUs9OhiqTNY
	 73cWLGxHnep4CbJCsZFH7dZQRYroXW3BgWjoKInPvvMbdEvtQz9gUF5jTCn8d0ibCv
	 VE21zteQKe3SyklCtaHCqPnA7r65CW707ZxT/QwRbFERcgTaU4CkYOdOExotxzvL+N
	 bXnIN4mKjXgwJw99z270ost/6eMqWCgH3z9AbXk6ieIA5iNstPQF7JFsnqPD/qrZnF
	 aR5wzxyIbMAEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lukas Wunner <lukas@wunner.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 382/642] PCI/pwrctrl: Move pci_pwrctrl_unregister() to pci_destroy_dev()
Date: Mon,  5 May 2025 18:09:58 -0400
Message-Id: <20250505221419.2672473-382-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit 2d923930f2e3fe1ecf060169f57980da819a191f ]

The PCI core will try to access the devices even after pci_stop_dev()
for things like Data Object Exchange (DOE), ASPM, etc.

So, move pci_pwrctrl_unregister() to the near end of pci_destroy_dev()
to make sure that the devices are powered down only after the PCI core
is done with them.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20250116-pci-pwrctrl-slot-v3-2-827473c8fbf4@linaro.org
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/remove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index efc37fcb73e24..58859f9d92f73 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -41,7 +41,6 @@ static void pci_stop_dev(struct pci_dev *dev)
 	if (!pci_dev_test_and_clear_added(dev))
 		return;
 
-	pci_pwrctrl_unregister(&dev->dev);
 	device_release_driver(&dev->dev);
 	pci_proc_detach_device(dev);
 	pci_remove_sysfs_dev_files(dev);
@@ -64,6 +63,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	pci_doe_destroy(dev);
 	pcie_aspm_exit_link_state(dev);
 	pci_bridge_d3_update(dev);
+	pci_pwrctrl_unregister(&dev->dev);
 	pci_free_resources(dev);
 	put_device(&dev->dev);
 }
-- 
2.39.5



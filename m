Return-Path: <linux-pci+bounces-19965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFE9A13BC4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A63CC7A2F03
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 14:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D5622B8AB;
	Thu, 16 Jan 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqoBfa4m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B4E22B5BC;
	Thu, 16 Jan 2025 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036560; cv=none; b=L+usuHGz0R3MOAkD3Aay7p2uQxQGEHoTNpJLfCn8pib/FBp4UPvykkdQ3mJcdHQpP6zNvrqu4+InMAE9HhzmJc7viGp6+0mXU2A2761yHurgeniHF/zpf0Iy5S/oYsfThheLuDdUdpkjwaB17IuNd1kWgKZR4JzNpAxg4sD48CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036560; c=relaxed/simple;
	bh=pJh5AXQbg+1t0rZcEXAK+EutSUZovxAeK8iPRrFkzhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1lsKJl6YqEugYAkbbnDHPsSH5zXJwj7ZaV3+WBPpYuPEmxxOHJAolRcDGbKna89ocQfuceAwZihYfoTkAljlBI69fRct1jAFhiTsOo9ghBOlWlhMEAOO0jyAlsXDT7x1Fe8H27jr6GTxwym5XU6/DQjuKLEE+gc6x9UxwTE134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqoBfa4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97454C4CEE1;
	Thu, 16 Jan 2025 14:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737036559;
	bh=pJh5AXQbg+1t0rZcEXAK+EutSUZovxAeK8iPRrFkzhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bqoBfa4m1EFBx3JKZ4mHvMyyN74QfKzCEnrKxUjXyr1SvUn0CyrzZbYkgKKMIE7yt
	 fjyx0qWLyn6LD3RcAeXg/QYc+z3gcRUcYbGiLRLkUZTDicpoRNbEPYBgXrNXQ303iV
	 JoRfyNLVLvLksROEj0pWkO+4w8/FG5I655wQEVcd3YHZvU+hjDGkBYnfsjHqG/PHNr
	 Fe8Pz07MNFREN7kmqX/yqf2cA++UNvIrLI46SrVXqdioeK4K9h4YmFUnhMpfPzrHph
	 /++rFMwADjvrd6+A9CRS3MwU+STeKPJ/sN4rL3H+isUOHqN1THXBz1Ym0xqbck7DCz
	 cewEfTSUchPRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86539C02183;
	Thu, 16 Jan 2025 14:09:19 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 16 Jan 2025 19:39:12 +0530
Subject: [PATCH v3 2/5] PCI/pwrctrl: Move pci_pwrctrl_unregister() to
 pci_destroy_dev()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-pci-pwrctrl-slot-v3-2-827473c8fbf4@linaro.org>
References: <20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org>
In-Reply-To: <20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lukas Wunner <lukas@wunner.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=R/h8mRffg4ftb0mSxAjhuMkQ2AXNpRy+KTjYeuy7GyY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBniRMMOWMQy8+n9GIwCMLzD7wUlVwcsEa099OMM
 3k4LrMp4qSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ4kTDAAKCRBVnxHm/pHO
 9fz3B/41s7dYud9Tcx8ri0aE9DFjyc7ivSLEw3hvTLDaM5fCfyUm/2yHb7XvUmp3DbMBB3lZW/n
 AHWZ+8yyUFj0CY74T9LbYWvmkJ0cQr4iwEf3yFJ7gsdCFb1upPxEtmshzWE5EhOiPDkmzlvXyGv
 EmYs4d2VTZaPEHS01+zStRE0JiFQp7TXu9INhxhvfa/NDshfkppWi1OcXcmm9nPhCHHWaroFWM3
 Nw3A+/d8Z5TsWHBj0SQHaCUiN+xQP+zbPzCM0/1UHrIFoE+Ae0o1TEvh56WZO/k9Uk+8moIEZC6
 AzBd5h4ih3U9xKPDJSbnUu4GxPoefXlr5OHoLpT6+/xrtPti
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

PCI core will try to access the devices even after pci_stop_dev() for
things like Data Object Exchange (DOE), ASPM etc... So move
pci_pwrctrl_unregister() to the near end of pci_destroy_dev() to make sure
that the devices are powered down only after the PCI core is done with
them.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/remove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index efc37fcb73e2..58859f9d92f7 100644
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
2.25.1




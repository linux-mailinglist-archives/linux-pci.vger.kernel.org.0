Return-Path: <linux-pci+bounces-11164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E59457CE
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 07:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8DD1C2173C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 05:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAAD446AF;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCw4Hw5j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D620335C0;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578119; cv=none; b=I7IMlAPxH/KAtpaqhD2rrdHwxfOxrc8qTRqLtJ+Xvn7RsWhU/p8mQWioXBnzF0tdHSi8HEFW20X7TmWUf0WIrictcO9gA4brIufw1CE0DiryAtX3ZtCAWK19E1s3UICt72TC2PbkJ/mvmjezvzpRsRbyNm7MbJnuNhYjNJjqrG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578119; c=relaxed/simple;
	bh=z+/bbibB7haQjY5NkNZVL8klnDC2hXm8Zfuofz+R8Ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WT7naYxei9YWWqC4vB6l/IKUW1yXF2P9FaVXix7XQ33yG94/4k+Xyj4xd+8Bf170ghA43q5zlk/oMFUybJv2k47d+CqZ74CmXshZlENcEftxR2tDClQwIIxEgG0hdJozNPt6jEncxzndDZ3mum/53JPESpeEJ30OLT7L6gUx28c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCw4Hw5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3770BC4AF09;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722578119;
	bh=z+/bbibB7haQjY5NkNZVL8klnDC2hXm8Zfuofz+R8Ck=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hCw4Hw5jNu6juv04ldDJZhw/ATOY4zG3uUbhheVWMf3X8fm5Q6U23ITrT538xVIDR
	 VDcyySVuZc0PRHDlB9gRY4QayXqJO+cSF8h5QnSVmk21jXFXNWbC2ZSm6kFf5RfUgg
	 LO8GBHw05lCa904ZaZfq2651Ra7Pp5vebqF5+dB7xhUPVed+01zNvqtYHPg2ykGa53
	 rGPZ3VucFk7btTBjc51chIqVLCAObkIK+Ckte6IwftgV9kSiyHJelp0r7pYgwuDsB1
	 8Ki0zNkcRZUGTkRpKKhtA99Gfc4SKLjUdXqJPCXYyyoDqxr+kiwE/bURKuDPtFBDD5
	 VEFCfPnkWsdLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23401C52D72;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Fri, 02 Aug 2024 11:25:00 +0530
Subject: [PATCH v5 1/4] PCI/portdrv: Make use of pci_dev::bridge_d3 for
 checking the D3 possibility
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-pci-bridge-d3-v5-1-2426dd9e8e27@linaro.org>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
In-Reply-To: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, lukas@wunner.de, 
 mika.westerberg@linux.intel.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Hsin-Yi Wang <hsinyi@chromium.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=yht1diuW60Yop5/MJv61ZmShJUebX/GlA7kDcmFMjJk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmrHTC/WwYy2qeJjZ533ltqs4myHg2ephLfnjaa
 88YaDf3/OaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqx0wgAKCRBVnxHm/pHO
 9ajrCACDX9M1OQiUvAHCdt5y/BA9vHawznd1tH4hTb3nJK8n/6kNEfLMDhmwA8MSkNfE1c9v9lj
 ECeeyKSLzwztu4Fi1/mgf2sK1UZwHrhTz3aozN4Ll7G13WXkMBYTtKHniV+vZXpVX/BV25rZR8y
 saJbDjOS+H6g8iiydB32M1mvUN/bZLE48kWjT+FPw5sHKsOCVIAlY4WzcXNeUnuO6k6i0K4XaZx
 KiNj7YAr0GUinezr9e1e9zeJgzPry+a6FWPaZ6hY8vgOThxKPOvQRtt2U/MV0O/ibEVHYnEjG52
 jfv65jm1/C5VMXdRKjTSndaSQKRVp8UIcpA69FZiEA0bMaR1
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

PCI core is already caching the value of pci_bridge_d3_possible() in
pci_dev::bridge_d3 during pci_pm_init(). Since the value is not going to
change, let's make use of the cached value.

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pcie/portdrv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 14a4b89a3b83..1f02e5d7b2e9 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -702,7 +702,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
 					   DPM_FLAG_SMART_SUSPEND);
 
-	if (pci_bridge_d3_possible(dev)) {
+	if (dev->bridge_d3) {
 		/*
 		 * Keep the port resumed 100ms to make sure things like
 		 * config space accesses from userspace (lspci) will not
@@ -720,7 +720,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
-	if (pci_bridge_d3_possible(dev)) {
+	if (dev->bridge_d3) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);
@@ -733,7 +733,7 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 
 static void pcie_portdrv_shutdown(struct pci_dev *dev)
 {
-	if (pci_bridge_d3_possible(dev)) {
+	if (dev->bridge_d3) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);

-- 
2.25.1




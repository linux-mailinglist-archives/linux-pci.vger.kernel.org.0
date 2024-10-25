Return-Path: <linux-pci+bounces-15274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA63E9AFB93
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 09:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821A51F23F38
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 07:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794621C7274;
	Fri, 25 Oct 2024 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7ra5R3S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472521C4622;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842903; cv=none; b=BbKxldvZ2uVfv/2QPu8sCqs5ubwy11mEOdxRfJIKBxbaJ5U12RNQATSsB9Molkvs+BvxpO4FkHuW3P/de8aRS7f0LWHR5uutLLSfjzzE7eV26hrQVehCdgtmIjtILvBCZWOFL1ctG7rlB2FyxH8WnPAM2N5bT3cTQtlWh9m4cGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842903; c=relaxed/simple;
	bh=oQKJemLv+DazWWrWtxj8bo8GJRraMiPexo9TrSDVMUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ADUNO1fR3fwRD1oCOI4WNlOdnUTw7wzZYGAtHqk8/AJE/mT8IoeM7Uv1b/O4T7xebvTQ2kd9+urTgI7aA+iHjz6zYw+qJ0PHm6zn/U2/fw/RpwzJkp+zVOnAHc7QfR5VWFevicNHMEidj+/V8FFM8Z7mewY5F78SvWBDtjNoTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7ra5R3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABD3AC4CEEB;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729842902;
	bh=oQKJemLv+DazWWrWtxj8bo8GJRraMiPexo9TrSDVMUw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X7ra5R3SxN/kvMECqGOUhOGf5mwqrNhRmBJAWYAmPMZKSGQ49Hr3QSX0QOXS9Fuft
	 xzjUJSotuqXmXcoLJoS2A7yMayCa+VAHLbEGe/n0EzwUTdB14RvmzkNjFBK6if0aV0
	 pWE9Qvi0Fjh1qy+TwC/+UQPXP1uA591FLbpzmqO1c7qY/L+YeTeBwj/V1+SBPdoZbn
	 IBtOPr3cns8vdLiH50NRKcj9X61S6D4vHviVV6gg10Oax9D44fPgskp4ceVvzTMErA
	 Cec/RifNnTPnQVk5n2hOBQ4vTiTd3a9Byq1UygcZk54h391toN8a0B1AJVtUVcU87i
	 JoXJpBaeb4VVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AF2D1171F;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Fri, 25 Oct 2024 13:24:55 +0530
Subject: [PATCH v2 5/5] PCI/pwrctl: Remove pwrctl device without iterating
 over all children of pwrctl parent
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-pci-pwrctl-rework-v2-5-568756156cbe@linaro.org>
References: <20241025-pci-pwrctl-rework-v2-0-568756156cbe@linaro.org>
In-Reply-To: <20241025-pci-pwrctl-rework-v2-0-568756156cbe@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krishna chaitanya chundru <quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2043;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=ZMmwlwCRSzjhOUE5z4PNfZQoS9fl60qTZUGrmIa0oTI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnG07UrEI+ygFFYRiJquOhxF3/HIbsroWH7tQhL
 aK5AVibzrqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZxtO1AAKCRBVnxHm/pHO
 9RnwB/0Wzu1JRJdjBTy8WSMsnT+5odUgmGM2uRrgVJHOE75GND9wNiKEqdu3tffLo3uQIe4l+QN
 q2huoKlgRmUe88U77wsCXrHnZBdLjwByElTa4uP1CoSJfC7RJvx9a+2+BtWVezy4ufj0FYN/Ca/
 kC75FJPe4y8bCWDgA20i2nbRfZ1kUi56iOGrhN9QOUg4UHPaa7bewh0WAyDGsp5TcIE/Bz8gg41
 PbB0Q+ucWngtUGqsttOdjhn+CMjo+udGDfJgdC+aI2VdRbd1OYdgUe4xbMSuKwgkd65wmEXq1g2
 V+n8/BxngjXH+alX4zivvBwsnFiU42THzJRmBsptvG0Dk3b9
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

There is no need to iterate over all children of the pwrctl device parent
to remove the pwrctl device. Since the pwrctl device associated with the
PCI device can be found using of_find_device_by_node() API, use it directly
instead.

If any pwrctl devices lying around without getting associated with the PCI
devices, then those will be removed once their parent device gets removed.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/remove.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index e4ce1145aa3e..3dd9b3024956 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -17,16 +17,16 @@ static void pci_free_resources(struct pci_dev *dev)
 	}
 }
 
-static int pci_pwrctl_unregister(struct device *dev, void *data)
+static void pci_pwrctl_unregister(struct device *dev)
 {
-	struct device_node *pci_node = data, *plat_node = dev_of_node(dev);
+	struct platform_device *pdev;
 
-	if (dev_is_platform(dev) && plat_node && plat_node == pci_node) {
-		of_device_unregister(to_platform_device(dev));
-		of_node_clear_flag(plat_node, OF_POPULATED);
-	}
+	pdev = of_find_device_by_node(dev_of_node(dev));
+	if (!pdev)
+		return;
 
-	return 0;
+	of_device_unregister(pdev);
+	of_node_clear_flag(dev_of_node(dev), OF_POPULATED);
 }
 
 static void pci_stop_dev(struct pci_dev *dev)
@@ -34,8 +34,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 	pci_pme_active(dev, false);
 
 	if (pci_dev_is_added(dev)) {
-		device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
-				      pci_pwrctl_unregister);
+		pci_pwrctl_unregister(&dev->dev);
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);

-- 
2.25.1




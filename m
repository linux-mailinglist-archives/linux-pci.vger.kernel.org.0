Return-Path: <linux-pci+bounces-15002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847289AA013
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 12:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE55B22EED
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89D819C54F;
	Tue, 22 Oct 2024 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyPlxy5c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56019C543;
	Tue, 22 Oct 2024 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592883; cv=none; b=TUBljE1w1IKa7ysAK0fD8xfsXuvhDAN8ZmosRNBBcffsi3S9ieVLOQZ+7r3e8y92zBNFaIMenMnp4K9+UhP3UqzJEnZv3KdJrhsTJnMjWI+nrXbxoL7cIuK+G0v55DZCtV93NYq4icVow/pVSgsirx2gUZzbziPaunYCXFu+MJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592883; c=relaxed/simple;
	bh=jPx+IRUONoAgH3KFjgYaCrDCw64YdeqQ3+EqFJXljGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SywjKgeS4IKZbL8jtYafaTu2+z48v2mj7f0Am0hTfh7GTHTrQac9ycpn+fhylotmITk9hu/MRjB26a/VdCz6vcQtH9pRsejmKC1xklg/lV653LeI8tRvR3uncliJC2u0VVewm29eOm6UJmJBeXP1wHb0hGtY6k62E/NMku1hMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyPlxy5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82BFAC4CEEB;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729592883;
	bh=jPx+IRUONoAgH3KFjgYaCrDCw64YdeqQ3+EqFJXljGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iyPlxy5cEym5z4dc5fuFg0Hs1iBgHTGF+Mzq7b7hxHgnmiWLEDpaDwcKmqkxIRF0v
	 3glK1uFH24QFWFpU3stuYIGPyrVVrkOXgsZ3PHLjXCdjCBKIj9ZOha8WdKEpP8Y06F
	 /3vSajHOZ9Lu2z9WbM7YDohEVZHQjbZ9pI5sVtI5syUPE1wsGDpaWMIe63XIsfKLjm
	 Sa4q/mVXsckKYKtxbBex8tAUBFHnUpF9MTge8S8itJbLsPECkVNufGLpjOc9FRRKQU
	 D2slIuLxUe/URAVFj6w4ZTYF7CF14CYnEC97Nm3/mxVZ+GRUPyXQdISU+Zdj6M3Zmf
	 CATtDb6UpHlpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9F9D1CDD7;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 22 Oct 2024 15:57:33 +0530
Subject: [PATCH 5/5] PCI/pwrctl: Remove pwrctl device without iterating
 over all children of pwrctl parent
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-pci-pwrctl-rework-v1-5-94a7e90f58c5@linaro.org>
References: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org>
In-Reply-To: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=Fx4nsEA2QZpP1ERShZZ8bZw3IQBN6+Um75DdA2nrjyg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnF34v/nlnaSD9lCRQmkUSbC0gN51VH+Ya8loNI
 VZhLq3xK7eJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZxd+LwAKCRBVnxHm/pHO
 9WpUCACKafJIXVlw/tZAI/sQS1x6dJE+i6hX9zJsxTo/DczSyuwA6FHOswiX8NHCLJZyYTyspGt
 rFNtE5+WOuWGABNRXUvTZLGAOJZljL1UHYFJMkPRzuLUfFhTPjuEJ2aXkYTFz6tJaaAoah74P8r
 hUrkZve4eH0d3qRD3NDeZuwBIhT0ZyGPN9j32ESnqYhBhyuY6vxemjBM38NAWSDFc5gUdSBufzA
 Lwa8k652Feas0X9FUPl+RrPjjq/Yot8oDfpSiKhAnPQNYLinqbLfb6vrAbphM9VMDRv35P01xNY
 lgPl05mHeyzVat+aw1w4oGVinO277ji4pUNpIEanlGGfbcHs
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




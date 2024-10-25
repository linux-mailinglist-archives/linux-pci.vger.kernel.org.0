Return-Path: <linux-pci+bounces-15272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D2C9AFB91
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 09:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A361C20627
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 07:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FF51C0DF0;
	Fri, 25 Oct 2024 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ0RqoOI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB3E1B6CFE;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842903; cv=none; b=or8NnwriOZpp4WkTjGNnhNLc0Vu2j8KLceSCcCFQ71d3D6faD6x2wdJFpU4/tOsk76eFDfNIJERcUKnkwrOrIlfmgIstiOQHNL8IiQnpQzVqah9nyOkXYNGsR/+jDdt5RS2yJsgcHubysBR0iMDJq84lfOotnzdAQvNz8utlxzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842903; c=relaxed/simple;
	bh=6Zz1+8UQ+gRQtPQcE4dfRWTCnVCr+rCSzukMsoj9POE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U70uvcBOzIk3n7U8uhcmFS4q108iwwAW2zcD86ebjVMxVopygEvYqa4Geo4QOEaDHlgrzZmUbIQGYruKmzU4nNbhWiK8WoeRPbUIQw64KeUQxKSMT4euXBmO+s7D4USs7xqkQD4Z9G5CgRJ5rf1/o6Uxv8jW1J4Hjh5OCmhgAEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ0RqoOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90C4AC4CEE7;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729842902;
	bh=6Zz1+8UQ+gRQtPQcE4dfRWTCnVCr+rCSzukMsoj9POE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SQ0RqoOIr87KvANry/zUAp9ZA6OkgbDppGDtluRjzfx2t/P3KTEycgK8AMo7JSI37
	 Puj4ZkQmltU/BogYSD72vY3C8kFNCK6poLvZgc4SmDVJ4gJBvhEdPR9HkhuNJhsAMf
	 ga43RXhRR7CeRdwm3D8NXuzyTVDQwe+krCbX7YJjhTyBIEYoLqnfFzQbymRZpFWaX6
	 2KFg+Yq3aajQk1oUPlmTzkewFBjfLaEBv0rfAptBTDYyVHF08p8tHZq2OYC2jHIMd6
	 YffKmtxrXDpb++j+zZ0fEGccI1x0/UUN/H2wFKhZ+L5Mf4chRDqpKAJrsroeM/hcuQ
	 9zIb6EJvCYBIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B34D1171E;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Fri, 25 Oct 2024 13:24:53 +0530
Subject: [PATCH v2 3/5] PCI/pwrctl: Ensure that the pwrctl drivers are
 probed before the PCI client drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-pci-pwrctl-rework-v2-3-568756156cbe@linaro.org>
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
 stable+noautosel@kernel.org, 
 Krishna chaitanya chundru <quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4495;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=EJwi7MnIXTiK0r2tSMkrSv6SfPORpF4ib++0r7C5Cos=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnG07TEwDFEenaEuGI5bs1sqUfLij27545ROkPN
 0E7ShticvaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZxtO0wAKCRBVnxHm/pHO
 9fATB/96vzhoyKSQV7mMp+b6r2+6EacrN1wXaVge7+aNs0+A7bbfPVzO+IU80zvzW+qh+9m0DPC
 Zz/FRJ1zkI+l8fysyN+FyB6V3aQE2z+aW+P4RvtBK6uWn70g2qA6vCZxmzkWzAizweqv6Hd6vtZ
 VgviJIj9jPUCrrwV8l5on/HTHnZdpem2MOP/lvsAgsQ6xQynvjsGFKn7t9rGumgGXMWmsVcgy0w
 xJB446sqaGIbcoSgvrblmzRVaxB0nU8PWb5Rqsn5q6u9fkAK+CKzJGPmLvNm1r+uy+Kajqdu/gN
 uuoiiISy+yzFjbC7oA+ufMV+g9aMqjwQpwVzXXF2TTefYEw3
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

As per the kernel device driver model, pwrctl device is the supplier for
the PCI device. But the device link that enforces the supplier-consumer
relationship is created inside the pwrctl driver currently. Due to this,
the driver model doesn't prevent probing of the PCI client drivers before
probing the corresponding pwrctl drivers. This may lead to a race condition
if the PCI device was already powered on by the bootloader (before the
pwrctl driver).

If the bootloader did not power on the PCI device, this wouldn't create any
problem as the pwrctl driver will be the one powering on the device, so the
PCI client driver always gets probed afterward. But if the device was
already powered on, then the device will be seen by the PCI core and the
PCI client driver may get probed before its pwrctl driver. This creates a
race condition as the pwrctl driver may change the device power state while
the device is being accessed by the client driver.

One such issue was already reported on the Qcom X13s platform with the
WLAN device and fixed with a hack in the WCN pwrseq driver by the 'commit
a9aaf1ff88a8 ("power: sequencing: request the WLAN enable GPIO as-is")'.

But a cleaner way to fix the above mentioned race condition would be to
ensure that the pwrctl drivers are always probed before the client drivers.
This is achieved by creating the device link between pwrctl device and PCI
device before device_attach() in pci_bus_add_device().

Note that there is no need to explicitly remove the device link as that
will be taken care by the driver core when the PCI device gets removed.

Cc: stable+noautosel@kernel.org # Depends on power supply check
Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/bus.c         | 26 +++++++++++++++++++-------
 drivers/pci/pwrctl/core.c | 10 ----------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 02a492aa5f17..645bbb75f8f9 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -345,13 +345,6 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
 
-	dev->match_driver = !dn || of_device_is_available(dn);
-	retval = device_attach(&dev->dev);
-	if (retval < 0 && retval != -EPROBE_DEFER)
-		pci_warn(dev, "device attach failed (%d)\n", retval);
-
-	pci_dev_assign_added(dev, true);
-
 	if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
 		for_each_available_child_of_node_scoped(dn, child) {
 			/*
@@ -370,6 +363,25 @@ void pci_bus_add_device(struct pci_dev *dev)
 				pci_err(dev, "failed to create OF node: %s\n", child->name);
 		}
 	}
+
+	/*
+	 * Create a device link between the PCI device and pwrctl device (if
+	 * exists). This ensures that the pwrctl drivers are probed before the
+	 * PCI client drivers.
+	 */
+	pdev = of_find_device_by_node(dn);
+	if (pdev) {
+		if (!device_link_add(&dev->dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
+			pci_err(dev, "failed to add device link between %s and %s\n",
+				dev_name(&dev->dev), pdev->name);
+	}
+
+	dev->match_driver = !dn || of_device_is_available(dn);
+	retval = device_attach(&dev->dev);
+	if (retval < 0 && retval != -EPROBE_DEFER)
+		pci_warn(dev, "device attach failed (%d)\n", retval);
+
+	pci_dev_assign_added(dev, true);
 }
 EXPORT_SYMBOL_GPL(pci_bus_add_device);
 
diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c
index 01d913b60316..bb5a23712434 100644
--- a/drivers/pci/pwrctl/core.c
+++ b/drivers/pci/pwrctl/core.c
@@ -33,16 +33,6 @@ static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
 		 */
 		dev->of_node_reused = true;
 		break;
-	case BUS_NOTIFY_BOUND_DRIVER:
-		pwrctl->link = device_link_add(dev, pwrctl->dev,
-					       DL_FLAG_AUTOREMOVE_CONSUMER);
-		if (!pwrctl->link)
-			dev_err(pwrctl->dev, "Failed to add device link\n");
-		break;
-	case BUS_NOTIFY_UNBOUND_DRIVER:
-		if (pwrctl->link)
-			device_link_remove(dev, pwrctl->dev);
-		break;
 	}
 
 	return NOTIFY_DONE;

-- 
2.25.1




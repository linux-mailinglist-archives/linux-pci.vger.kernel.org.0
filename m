Return-Path: <linux-pci+bounces-18019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A799EAD3C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 10:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95D32904FB
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 09:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AE22080EF;
	Tue, 10 Dec 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa7rQcJR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC523DEB6;
	Tue, 10 Dec 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824556; cv=none; b=HHmRYMH4SaHclfUEruapHFRffzcdpsAeunV1ynyTT9pBkmZzjMb8/xr88JyWanhLMjGeLYlrcPGHPENjC+VggbaqR2KQTjhuATkeN/UuHA9+tAI8tq7nf4qW6LR8N0j8/uA+tlt5dF/0/rBQLP+bePC8kLJR7ajfP06tKwRj5FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824556; c=relaxed/simple;
	bh=8EXhHjh7XDhfsmA26ijCHfMrUBpp+GShZeAm7FYBi9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QY6/OzVlTruVnnEHMFf6MJ5iZArydaSkAJVvnB6PnpoGrUvI50ZdkD7y19GBvo3yqqaX6QZdnAbCHKqK45uA7ks6qrWFTK/MReDRuGETZCVvN0Npeqn0N8iI6C9o8KKNwijz2x0u4MKhvsKH/mD3Ms0/UTQ64Ei8cIXG/z9qQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa7rQcJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DC42C4CEE3;
	Tue, 10 Dec 2024 09:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733824555;
	bh=8EXhHjh7XDhfsmA26ijCHfMrUBpp+GShZeAm7FYBi9M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Xa7rQcJRE/Yb9KjlR2znp4DDy7vRdk5maCGNAmnc0rOjhawqorWYUFBcBp6gIWamp
	 0XL2xuTY7A/WPGev0GYLTf1mtU0ol2qUF5zQfEqQHaXpvT1vFVdF9dlcsE+wPMCWTU
	 VTyXoBOxwrbehOmjhY83KRb53DyN2B3VT2WfO6Rf0QXRMlPIUhFSv8JEkm0Cs4Np+0
	 uxxsI3wM+AQxZKXOpk3qO6XwhFM4nwgBejbO1btSYE3RGXfWiLgmyii0XFVJsRAnYD
	 yehXa6v9xi/lsATBwhyhAvMIMdMVLx6OoYGGUGkzaMBZQbyznciGh1sBoWpnbGdbvO
	 gmdV8zK9vOQzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FF8E77181;
	Tue, 10 Dec 2024 09:55:55 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 10 Dec 2024 15:25:25 +0530
Subject: [PATCH 2/4] PCI/pwrctrl: Move pci_pwrctrl_unregister() to
 pci_destroy_dev()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-pci-pwrctrl-slot-v1-2-eae45e488040@linaro.org>
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
In-Reply-To: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Qiang Yu <quic_qianyu@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lukas Wunner <lukas@wunner.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=AayP0uLiPqt9crxsUCoYXhcBPjoCZ1TdOHW8vyCvx84=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnWBAo0ccwM9RwPmxonJZbhJqQZ/aygLDUZl/ho
 zzelFF38iaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ1gQKAAKCRBVnxHm/pHO
 9ZRSB/9NkA7rMJDFCACTjRyMDLunQF78A/Py/7vGsmzIRWlriF3rwvg8Zn59bTAyFjcrmPezP2j
 iglCPGrVcbwDjDuCGb0rInMbEBj/hwFyITq6FQEeZjE3ryXMqZZwjKXFBi6qhLIYY11Ias4y2M1
 Le3mJBEigq9t0wOZVmrIkYVoUokAfHTtDJ6HWlyXRabI2pzKNETFu61qCgVmdHAjsTyf98TV340
 iXVA6tsUnm3ZWk9NvLG740865eD7uTK73FsZ44XRFxeWey/60+05stSiNAL8Uzq/y9SvCGeOCvA
 R2GQ+y7DVlO61DKQu80mpbj8uDWTLdyIlebhFN7mTAjw4BVk
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




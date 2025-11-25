Return-Path: <linux-pci+bounces-42029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A871C84AA8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 12:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB6C3AAE1D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 11:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE8E3168FC;
	Tue, 25 Nov 2025 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZ6Ap7dj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ADE314D16;
	Tue, 25 Nov 2025 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069153; cv=none; b=IR/jddrDo8nsFLCvRqOKqx5bHIZoMAxMi4RtJ+V5D9apDjajif1yGmh3mdFN22wxBDqp2SfpcLee6m0jdYVhmL2lzmpqqkcsSd6GqEChHPdbrEi0szd4+gBlUv0bEv/iKbwEIZYnv27tt4q2YAuCE0fiNgfE7SId1Bnhtj89ydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069153; c=relaxed/simple;
	bh=YgTp47gBWwTxTZqUXWkk7rXcnJqKSr28f/BoeQqfZ2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZvI9Rkvtnyf6iMy9xJ3PXBia7zJGJYZMw92TFpAW8b+TP3TkcWm+NL2hfFL7I4XFTM7EL5JLWxJe/6qXag2coNlAtQCMUiOe1AeAFOaKRCjkx14Tocgd1CRwYmzpa+aU77mGPRVAS2wMfamaSw2IyAES1ESn/Yw5MFzvugGguaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZ6Ap7dj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B288CC19423;
	Tue, 25 Nov 2025 11:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764069152;
	bh=YgTp47gBWwTxTZqUXWkk7rXcnJqKSr28f/BoeQqfZ2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YZ6Ap7djRf4vX9QfBYDYkVtsQ92W4KfxcH/BfSib6TRaJ/uWS0iPgH6UpXsZ8lPvc
	 qasv8ejxSMPI1rNXtR+Ju3/BnDkzysAqkUyNVTvSnP4wZl5SdIqse8+hebTSZhKGbC
	 o7h5V8J8bLAusJIvnwESnOkUQimQg6071lYpRWC9IRWuIGKQKn8sra7kHny3u4vixy
	 6b2etMAw+LeJEU8+J9+kisDF7qqY46k50UH+XAargZUx6pqQ8qDf4wQaatXQ28As5v
	 Zr0ka9U56aPPXb1fkYDO8CG7Zj2e+G5agGeZ3ndoVdzhI3KlaQCP+uVosU38R4/EGi
	 WY5O8VD+Ugdgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F6DCFD368;
	Tue, 25 Nov 2025 11:12:32 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 25 Nov 2025 16:42:28 +0530
Subject: [PATCH v3 3/4] PCI/pwrctrl: Create pwrctrl device if the graph
 port is found
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-pci-m2-v3-3-c528042aea47@oss.qualcomm.com>
References: <20251125-pci-m2-v3-0-c528042aea47@oss.qualcomm.com>
In-Reply-To: <20251125-pci-m2-v3-0-c528042aea47@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-pm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=85qx2Om/7njPst0xF59AZpGkw5zpMb/2p4I8tf0rGZI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJY8d8dHupd6VCH/oWWZ7QPaB9MbZJaUhUHcND
 zboN2Jf2ECJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSWPHQAKCRBVnxHm/pHO
 9TkcB/9SuTMoRU5JJS6C646WFkzzsHd2Ulg4rKImNms7pLcqqyrc6/P7U0Bco+g0Cax4FvkIJzy
 iF/h8h/aXc+tjDqcq//6cF6mYbyfUxH22QfN0ePqMWbFkQ8TbV/mVKwLOqjexHCzX3AtMvuUuhi
 xKOUsCwhpKncFXKZ4lFt76UehmJiKM8bfEW0G6ILwrcuSmrIFs3osDINLRceMHuN2/54MEb1iYf
 y07jsNw+NtFtNEBcQ4MaXNK1Dg3p2xrjlG9jT3Dsfw8Fo1hFo5q9pedfto3QmEcuQyFsq8VBkUm
 AEqmE7RCcFuAw/UEp4ZiWk5C7HcNKIV0lzQdlrQc61jzdTEv
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

The devicetree node of the PCIe Root Port/Slot could have the graph port
to link the PCIe M.2 connector node. Since the M.2 connectors are modelled
as Power Sequencing devices, they need to be controlled by the pwrctrl
driver as like the Root Port/Slot supplies.

Hence, create the pwrctrl device if the graph port is found in the node.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c83e75a0ec12..9c8669e2fe72 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
+#include <linux/of_graph.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -2555,7 +2556,7 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
 	 * not. This is decided based on at least one of the power supplies
 	 * being defined in the devicetree node of the device.
 	 */
-	if (!of_pci_supply_present(np)) {
+	if (!of_pci_supply_present(np) && !of_graph_is_present(np)) {
 		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
 		goto err_put_of_node;
 	}

-- 
2.48.1




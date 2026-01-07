Return-Path: <linux-pci+bounces-44144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E45CFC910
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 09:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 197FF30B9B93
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 08:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F73292B44;
	Wed,  7 Jan 2026 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdUKYL+F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC02868B2;
	Wed,  7 Jan 2026 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773521; cv=none; b=TSrdldCosBKhWa/xjBvc/6pBiLvQ7R+oTgc9THxvB7CLJlfzBukMAnl+Svio6/kkcO1GFRa80mIGHpNQAw7bH1jZnpdsYgMY2hb54VRbDCreE7QgebCOEj91rsl4RcoDXg6jOxu29tswfrYomwZqrtiSNfWnjxipjJQ3BbUKyDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773521; c=relaxed/simple;
	bh=NXcrBc6SPdJUDN1PP5t6mB2NTOJ+7GwZ9k2MbvSSQH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rJazFTK4DR5x5/rYq7+L6ltZY9gPm6unximEcfKHt/nxH0gfRwNG0lxlfNnDC5ZxAlu9QK+6VDmmDhNVoQlRt9jiXcYXxXYAe6YDoWiElRFUJ847r6XvP+gnWzGsmZ1CDUpSUGyj5+HJr8i7/0rle54YkeMfwi+b7k9txuDLDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdUKYL+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D12F5C2BCB8;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767773520;
	bh=NXcrBc6SPdJUDN1PP5t6mB2NTOJ+7GwZ9k2MbvSSQH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DdUKYL+FWUByWwEyOibeYFiCVgWXuNFy4iSn38RUjXHap0uVBYuydTeksJTHXVY2z
	 DnW/GrMHJtYUBYOlIPBjEg0D4xmUtZAJ9YzMA2QfaNuMKvkBotsvbXvlD2QakI6ZNB
	 IczBX7mCWoubt7ia+VFB0sF8r2Sy1wGhwKlgumVHcwo85qlUulXrhA4Q2/xpsogNOO
	 1PvUbTX4yxrtuPe8A/SffYhSuuHoU3Aostf1moWD1gsWZmfJOfTGXGFTLd9EO/Qikg
	 pPmybPaF/3Sljp2uNPCmmLlLiNjrHJOeLsx19GDn3qgGnRT5fuSzGZUw2a9QOC9JNb
	 ht87IkITXZKrA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5648CF6BF4;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 07 Jan 2026 13:41:59 +0530
Subject: [PATCH v4 6/6] PCI: dwc: Skip failure during
 dw_pcie_resume_noirq() if no device is available
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-pci-dwc-suspend-rework-v4-6-9b5f3c72df0a@oss.qualcomm.com>
References: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
In-Reply-To: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
 Shawn Lin <shawn.lin@rock-chips.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2136;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=A+dYXc5n837LUvYZ/2oH3XrvOeQd2MIwA/IwRECz2uo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpXhVOUjSqOMt6oipJjhHgmBL0+vEUiOzLr77dK
 o/yZ0+6BlCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaV4VTgAKCRBVnxHm/pHO
 9SdDB/sGCaPHvWbzjXbEQqHunIZGnTeF+jfGN8X1HvypQRxSWaoCrN9PnHi7fF7M+jLrmu4Vqei
 m0LaOVq3Giiu0o6UW2kqQWcYlNjZRQXvKH9VkTX+fAgE+guRIXtiKQXmfcuyhxggZtgvJSyVP7t
 B3AsEKuKKTzyCCEGQrX/uIEgpVs56RfU5u4tSFJKbdiqchedKmuz7DDghmf7/VIJcBFQLQW1Xwq
 PPPDUx30SHfrnCzcrbGNSS7ECaJxbjE9cGPE9D9eS06eeQznMAhBdi/v1ivyAPWRbx4qQrOQG/1
 54RUjRClQzvsILf5oV6wviHq4rb2mi7WLJiYEuEKedS4t79I
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

If there is no device attached to any of the Root Ports available under the
Root bus before suspend and during resume, then there is no point in
returning failure.

So skip returning failure so that the resume succeeds and allow the device
to get attached later.

If there was a device before suspend and not available during resume, then
propagate the error to indicate that the device got removed during suspend.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ccde12b85463..c30a2ed324cd 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 static struct pci_ops dw_pcie_ops;
@@ -1227,6 +1228,7 @@ EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
 
 int dw_pcie_resume_noirq(struct dw_pcie *pci)
 {
+	struct dw_pcie_rp *pp = &pci->pp;
 	int ret;
 
 	if (!pci->suspended)
@@ -1234,23 +1236,28 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 
 	pci->suspended = false;
 
-	if (pci->pp.ops->init) {
-		ret = pci->pp.ops->init(&pci->pp);
+	if (pp->ops->init) {
+		ret = pp->ops->init(pp);
 		if (ret) {
 			dev_err(pci->dev, "Host init failed: %d\n", ret);
 			return ret;
 		}
 	}
 
-	dw_pcie_setup_rc(&pci->pp);
+	dw_pcie_setup_rc(pp);
 
 	ret = dw_pcie_start_link(pci);
 	if (ret)
 		return ret;
 
 	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
-		return ret;
+	/*
+	 * Skip failure if there is no device attached to the bus now and before
+	 * suspend. But the error should be returned if a device was attached
+	 * before suspend and not available now.
+	 */
+	if (ret == -ENODEV && !pci_root_ports_have_device(pp->bridge->bus))
+		return 0;
 
 	return ret;
 }

-- 
2.48.1




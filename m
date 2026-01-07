Return-Path: <linux-pci+bounces-44145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CABACCFC882
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 09:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DACC4304DACF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 08:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9523328E571;
	Wed,  7 Jan 2026 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urW+Ljg+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE622868AD;
	Wed,  7 Jan 2026 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773521; cv=none; b=meNIxSp8Bm6kfQXCyknEBW9s+1kwS1GQYU6YFXQ3pufqik11R9aR0IgPp3FbQmNIPT8vhvI+pd7NBIDAHR6i9p/hx+gaODqE9HGkp7egQBqxLbMmsaXkh84vCTRk+sxzeks0oYrZkQAfuW7oefiiri14ilXhSGFibuK4rXPpgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773521; c=relaxed/simple;
	bh=Z0Pgoi0Qlqa+YgrQg2kILANNAwZXLcX16MIbV8LfX28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=blfK73oGcFq28Khb5OtqAENmtyQTES3FHWg8Zh0ttDX8g1J6DzekkSRsLmtt6gvKDm3LqVfUDbRi8VNTjIlFqcy9vwmySDWVmM6Pcgpm0VdwLZQyWjDHChzvKtw5aOEPefYeM43twiGFkQE4ciV0LBE5nxu2P0YDCxrjxqEI8cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urW+Ljg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDC91C2BCB3;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767773520;
	bh=Z0Pgoi0Qlqa+YgrQg2kILANNAwZXLcX16MIbV8LfX28=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=urW+Ljg+S4QqvwojLPLKIoJF+HDHNXsv6aqzJgYWmrV6bkUwKEqiBT4XZMiTAIVO4
	 aSm9aZxgsgsRBcMVk5bWgKp1qFWDoHmUd9vp9hWHurrDN2lr3IInD5VFclHvEkWOWY
	 zHCXTxrSe9Mq9UgWsvtFfLsWVeOKAxWKfgqSm4BsHOddcp3mdLOb8iHOC+K7G+UD7n
	 5jI5AcdfEZxIMAvsRouvpEnoEWLChjEiSnOg3LJeKjJtGDIjiJ2BFjpPchgmuyXHhg
	 zR/nrE9jSEk7xvwKLKN7DSmWbqi6ItRaZR+NrpBiJ7IqkdY+vEG/5KAcPk2iqhj7ec
	 nLRZxEKW0USnQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68FBCF6BFB;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 07 Jan 2026 13:41:58 +0530
Subject: [PATCH v4 5/6] PCI: host-common: Add an API to check for any
 device under the Root Ports
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-pci-dwc-suspend-rework-v4-5-9b5f3c72df0a@oss.qualcomm.com>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=kAXCOvQycBkgZ3T8qsZnSaD6+NhiYd0ZqipWoNSX5Vk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpXhVOYVIGdtRi+M4F8h7//2lgXAskLXBIFa2BF
 GLD3I535hmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaV4VTgAKCRBVnxHm/pHO
 9QveB/9DZrJ+fECJFPzH8rdLobYA+GeygfYwGeFxZv6tJnR09GgwnZ3A6QIPjEW3HGsmy++ZRA9
 95FDwS/bDYvmjU1cscQ8ULSEHOPLkWny0xTgjjJrnd2ji8i9bVyWflYa3FZWYyTb3eP30ajFdBo
 22Uq3RJa2rkcf8/2k3Xxu+X0G1cBOE3RUMFqaativBvyveclwgz1+IQAE62eFkP+aAk4KMC1hRX
 N5AIzJH6SqaFPeJNh4xs+bj7AAW/vc06Q0mh8jhdtd9EJZLg5ctzOpgqOuuwof3+8tvPPy6PCn2
 Z8SC1idM0irQ+T27K3kQ6jTKVPHhLzGBcGlPWkRgd5YKOnbW
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Some controller drivers need to check if there is any device available
under the Root Ports. So add an API that returns 'true' if a device is
found under any of the Root Ports, 'false' otherwise.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/pci-host-common.c | 21 +++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index c473e7c03bac..a88622203227 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -17,6 +17,27 @@
 
 #include "pci-host-common.h"
 
+/**
+ * pci_root_ports_have_device - Check if the Root Ports under the Root bus have
+ *				any device underneath
+ * @root_bus: Root bus to check for
+ *
+ * Return: true if a device is found, false otherwise
+ */
+bool pci_root_ports_have_device(struct pci_bus *root_bus)
+{
+	struct pci_bus *child;
+
+	/* Iterate over the Root Port busses and look for any device */
+	list_for_each_entry(child, &root_bus->children, node) {
+		if (!list_empty(&child->devices))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pci_root_ports_have_device);
+
 static void gen_pci_unmap_cfg(void *ptr)
 {
 	pci_ecam_free((struct pci_config_window *)ptr);
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index b5075d4bd7eb..8088faf94282 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -20,4 +20,6 @@ void pci_host_common_remove(struct platform_device *pdev);
 
 struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
 	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
+
+bool pci_root_ports_have_device(struct pci_bus *root_bus);
 #endif

-- 
2.48.1




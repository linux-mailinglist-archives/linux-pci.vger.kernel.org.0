Return-Path: <linux-pci+bounces-32159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CF2B06129
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 16:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661B01889D69
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 14:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7072285C9F;
	Tue, 15 Jul 2025 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSOPpAqA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2D285404;
	Tue, 15 Jul 2025 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589271; cv=none; b=PnQ6dKhsL8lgOWOvinZ3Unk0b7KfsNsDEVSGA/1blvOm8Xn5KLJFJIC5UyjCMA3oK2DbJRMvZPpFfkQRHLp4BxOC6T9htASlBePaelDJ0Z8raWe2RyjDx+2ncW4urJaL7lcxtVl9ZKvpXR7KYtQN/JrFhiFkQnhyjWKBWcOg9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589271; c=relaxed/simple;
	bh=HUiqe9BfJu8+IE5qBDSonrm/7cSZb3FrNqj6ffWbMIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cBNWgtS0knOkcUEeQvQuX57f2Yi+PSOWu2UZ4aDnpp2Fafq26Y2Lepxmi/GslhjPBxJ4AjhEZbnwtV0FkcctSZThJcBldcV+XYFWVOGqYvlYXfvT639LTaAAvF5d2SD/9iiw/YKeHbdE5KEauLJkTHMxSN7R4w3E2pyFypyu4bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSOPpAqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08581C4CEF8;
	Tue, 15 Jul 2025 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752589271;
	bh=HUiqe9BfJu8+IE5qBDSonrm/7cSZb3FrNqj6ffWbMIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cSOPpAqAU6Kde3IQHaYWfRC1pHrB6jAYvqgThr6JdD9Ew4kffLWBRluaazgz5Gqa9
	 W8s9IzIewr++ugD6yGjta08xl2b3O8/jtBOfDHLJW47SHtqu5J11sMlYZGryVQr6To
	 GbZj3/DZPzu4+BrUrsqIY5wWlU1QPw0XIPHigvCm60WSw1SwRs/ldDLF6zEJSEY/8+
	 VPBbElVM6/vj2XoO+Ie3ymB2t7I+XFQ/XHxWiUIkVSdOJNxJuA4+czOIPEPH9hNCEz
	 ujjwEZSvRhHcslsgsznPRI86LJeLHJnuY65YyP0m4zUtNu9m/V+hbBeZxA2PL2F2tR
	 GIHjjEaZClLsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF759C83F2D;
	Tue, 15 Jul 2025 14:21:10 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 15 Jul 2025 19:51:05 +0530
Subject: [PATCH v6 2/4] PCI: host-common: Add link down handling for Root
 Ports
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-pci-port-reset-v6-2-6f9cce94e7bb@oss.qualcomm.com>
References: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
In-Reply-To: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Niklas Cassel <cassel@kernel.org>, 
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 mani@kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4883;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=yclKXg12a4Ms/Jc9pFHjTrFPlwGCKmI6VWDeeqlj8XE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBodmPUesZqzIw510tKLlbnICAV2RA0RCl15yWpa
 AkTWHG8fIqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaHZj1AAKCRBVnxHm/pHO
 9dMPCACpNns3R+yAsxZwXke3SJFVnnZNTmZk9e3XJZNXxBvOmDY3pXwmKOH2mjAf3Wyz6y4jBvR
 lSDlRFXz/+BSPaZbQH6QD3WKSwwIPTCnJCeE2kjR8mf3pQ3XBpGjPNtXZ9waTI5p4eVgn7DgtvY
 v8rY9FgrSqh1dk5yY1XqCi6KSUxP4mSd9BUdB0nSyN3A+/DKhwHuhYiJsg685g2+QsoYCh2wR4Y
 riOaWlurn7idL8rwXGt16wKX1ZWQiq9/OaOzbDIoN16sRqRAMOBzQlPviLPxeHB4XpPhCTag/aF
 h9bI6uBHzbzSxgCxjDVKkqU959ySUJMjGG5Q1UA9bWvD2Xjl
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <mani@kernel.org>

The PCI link, when down, needs to be recovered to bring it back. But on
some platforms, that cannot be done in a generic way as link recovery
procedure is platform specific. So add a new API
pci_host_handle_link_down() that could be called by the host bridge drivers
for a specific Root Port when the link goes down.

The API accepts the 'pci_dev' corresponding to the Root Port which observed
the link down event. If CONFIG_PCIEAER is enabled, the API calls
pcie_do_recovery() function with 'pci_channel_io_frozen' as the state. This
will result in the execution of the AER Fatal error handling code. Since
the link down recovery is pretty much the same as AER Fatal error handling,
pcie_do_recovery() helper is reused here. First, the AER error_detected()
callback will be triggered for the bridge and then for the downstream
devices. Finally, pci_host_reset_root_port() will be called for the Root
Port, which will reset the Root Port using 'reset_root_port' callback to
recover the link. Once that's done, resume message will be broadcasted to
the bridge and the downstream devices, indicating successful link recovery.

But if CONFIG_PCIEAER is not enabled in the kernel, only
pci_host_reset_root_port() API will be called, which will in turn call
pci_bus_error_reset() to just reset the Root Port as there is no way we
could inform the drivers about link recovery.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/pci-host-common.c | 33 ++++++++++++++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h |  1 +
 drivers/pci/pci.c                        |  1 +
 drivers/pci/pcie/err.c                   |  1 +
 4 files changed, 36 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index b0992325dd65f0da8e216ec8a2153af365225d1d..51eacb6cb57443338e995f17afd3b2564bbd1f83 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -12,9 +12,11 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
+#include "../pci.h"
 #include "pci-host-common.h"
 
 static void gen_pci_unmap_cfg(void *ptr)
@@ -104,5 +106,36 @@ void pci_host_common_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_host_common_remove);
 
+static pci_ers_result_t pci_host_reset_root_port(struct pci_dev *dev)
+{
+	int ret;
+
+	ret = pci_bus_error_reset(dev);
+	if (ret) {
+		pci_err(dev, "Failed to reset Root Port: %d\n", ret);
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	pci_info(dev, "Root Port has been reset\n");
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void pci_host_recover_root_port(struct pci_dev *port)
+{
+#if IS_ENABLED(CONFIG_PCIEAER)
+	pcie_do_recovery(port, pci_channel_io_frozen, pci_host_reset_root_port);
+#else
+	pci_host_reset_root_port(port);
+#endif
+}
+
+void pci_host_handle_link_down(struct pci_dev *port)
+{
+	pci_info(port, "Recovering Root Port due to Link Down\n");
+	pci_host_recover_root_port(port);
+}
+EXPORT_SYMBOL_GPL(pci_host_handle_link_down);
+
 MODULE_DESCRIPTION("Common library for PCI host controller drivers");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index 65bd9e032353827221a6af59858c46fdbe5916bf..cb0a07c8773ec87838164e994b34a62d2c8118be 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -16,5 +16,6 @@ int pci_host_common_probe(struct platform_device *pdev);
 int pci_host_common_init(struct platform_device *pdev,
 			 const struct pci_ecam_ops *ops);
 void pci_host_common_remove(struct platform_device *pdev);
+void pci_host_handle_link_down(struct pci_dev *port);
 
 #endif
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b29264aa2be33b18a58b3b3db1d1fb0f6483e5e8..39310422634a9551efc8aded565b7cc30f4989d0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5768,6 +5768,7 @@ int pci_bus_error_reset(struct pci_dev *bridge)
 	mutex_unlock(&pci_slot_mutex);
 	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
 }
+EXPORT_SYMBOL_GPL(pci_bus_error_reset);
 
 /**
  * pci_probe_reset_bus - probe whether a PCI bus can be reset
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index b834fc0d705938540d3d7d3d8739770c09fe7cf1..3e3084bb7cb7fa06b526e6fab60e77927aba0ad0 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -270,3 +270,4 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	return status;
 }
+EXPORT_SYMBOL_GPL(pcie_do_recovery);

-- 
2.45.2




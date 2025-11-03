Return-Path: <linux-pci+bounces-40149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B6AC2E4F7
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 23:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BE71897029
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 22:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB50627FB10;
	Mon,  3 Nov 2025 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J97+TEyO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEFD2517AA;
	Mon,  3 Nov 2025 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210007; cv=none; b=TpDw5WathYI+JxrVP3gT3kNnzyTdQdteXiKLHVZ4pUPUYYKa4pfbjqiYIVS9iouku32Z21x7w2XFCD0lHEm4lRNdx54Z0bt2i6UV5N40z7uuetLRBCwEy9DXk1zpgU4V+vGc8iPBfLlGhMM140NOSCH3r6tb3QbC32ONCxtjWNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210007; c=relaxed/simple;
	bh=JLjtv9YZug8pp1yUnLYZQqhdepsYSEGWLJwVOeuywOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ORZ76V1Rr797iaO1vZ2wNvts9ekRUYfXRwuGhGvrYLSRTw1GjOVs8zvwNPyrUQStirMldEMIwTDM03PDUEVPjU4+pCQWhqEA3R8LPdCTvVh2W3OMrvRFoo4aFZSy7D7vUUVsOhfRDTrpV34VovDC4f02RUJZQjrwfoppQeypoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J97+TEyO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762210005; x=1793746005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JLjtv9YZug8pp1yUnLYZQqhdepsYSEGWLJwVOeuywOE=;
  b=J97+TEyO9z2drgsMyq+EzFh6OdtZhnyCcoJjtWBD6X/aE2G1gc+H1dZT
   9sZkaU8cPn2FqeDsWknYRQZDK4wyeskD6vAU4OjXD9vpVDLu+jFPh0782
   OxWFS/dIun52XtgBSCXd8hQLb9tSKjoBaHfeXEJ+jDsAWCO2shDd9QdzC
   I38w+G+jx3+caHrrh+j9pAWDl2A+t9LbHFtHzi53QdTobWMhnbUMyfqAI
   kMWeosHZg+AnZnl9dC7Ji0cZgkhnm5Ljlp5xalKaxxeKi06Ip/u79whl4
   mvZeDILIReNwq91doPj9btMHrOnxWy854vj8l+VFFF2iVALebotDv6Swl
   w==;
X-CSE-ConnectionGUID: +KC/+cqsTUeelRPpBu/a0g==
X-CSE-MsgGUID: pl893NqTSlWfiTsQQTyWDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="74900059"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="74900059"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 14:46:45 -0800
X-CSE-ConnectionGUID: BaPMsI+kRbuBCJAZZ8g3sA==
X-CSE-MsgGUID: 1J8AqLpYSdmnA3qhghhccw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="187304426"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Nov 2025 14:46:44 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Madhu Chittim <madhu.chittim@intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Marek Landowski <marek.landowski@intel.com>
Subject: [PATCH net-next] idpf: add support for IDPF PCI programming interface
Date: Mon,  3 Nov 2025 14:46:30 -0800
Message-ID: <20251103224631.595527-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

At present IDPF supports only 0x1452 and 0x145C as PF and VF device IDs
on our current generation hardware. Future hardware exposes a new set of
device IDs for each generation. To avoid adding a new device ID for each
generation and to make the driver forward and backward compatible,
make use of the IDPF PCI programming interface to load the driver.

Write and read the VF_ARQBAL mailbox register to find if the current
device is a PF or a VF.

PCI SIG allocated a new programming interface for the IDPF compliant
ethernet network controller devices. It can be found at:
https://members.pcisig.com/wg/PCI-SIG/document/20113
with the document titled as 'PCI Code and ID Assignment Revision 1.16'
or any latest revisions.

Tested this patch by doing a simple driver load/unload on Intel IPU E2000
hardware which supports 0x1452 and 0x145C device IDs and new hardware
which supports the IDPF PCI programming interface.

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Marek Landowski <marek.landowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
IWL: https://lore.kernel.org/intel-wired-lan/20250926184533.1872683-1-madhu.chittim@intel.com/

 drivers/net/ethernet/intel/idpf/idpf_main.c | 105 ++++++++++++++++----
 1 file changed, 88 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 8c46481d2e1f..7a06eaf46a08 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -3,15 +3,93 @@
 
 #include "idpf.h"
 #include "idpf_devids.h"
+#include "idpf_lan_vf_regs.h"
 #include "idpf_virtchnl.h"
 
 #define DRV_SUMMARY	"Intel(R) Infrastructure Data Path Function Linux Driver"
 
+#define IDPF_NETWORK_ETHERNET_PROGIF				0x01
+#define IDPF_CLASS_NETWORK_ETHERNET_PROGIF			\
+	(PCI_CLASS_NETWORK_ETHERNET << 8 | IDPF_NETWORK_ETHERNET_PROGIF)
+#define IDPF_VF_TEST_VAL		0xfeed0000u
+
 MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_IMPORT_NS("LIBETH");
 MODULE_IMPORT_NS("LIBETH_XDP");
 MODULE_LICENSE("GPL");
 
+/**
+ * idpf_get_device_type - Helper to find if it is a VF or PF device
+ * @pdev: PCI device information struct
+ *
+ * Return: PF/VF device ID or -%errno on failure.
+ */
+static int idpf_get_device_type(struct pci_dev *pdev)
+{
+	void __iomem *addr;
+	int ret;
+
+	addr = ioremap(pci_resource_start(pdev, 0) + VF_ARQBAL, 4);
+	if (!addr) {
+		pci_err(pdev, "Failed to allocate BAR0 mbx region\n");
+		return -EIO;
+	}
+
+	writel(IDPF_VF_TEST_VAL, addr);
+	if (readl(addr) == IDPF_VF_TEST_VAL)
+		ret = IDPF_DEV_ID_VF;
+	else
+		ret = IDPF_DEV_ID_PF;
+
+	iounmap(addr);
+
+	return ret;
+}
+
+/**
+ * idpf_dev_init - Initialize device specific parameters
+ * @adapter: adapter to initialize
+ * @ent: entry in idpf_pci_tbl
+ *
+ * Return: %0 on success, -%errno on failure.
+ */
+static int idpf_dev_init(struct idpf_adapter *adapter,
+			 const struct pci_device_id *ent)
+{
+	int ret;
+
+	if (ent->class == IDPF_CLASS_NETWORK_ETHERNET_PROGIF) {
+		ret = idpf_get_device_type(adapter->pdev);
+		switch (ret) {
+		case IDPF_DEV_ID_VF:
+			idpf_vf_dev_ops_init(adapter);
+			adapter->crc_enable = true;
+			break;
+		case IDPF_DEV_ID_PF:
+			idpf_dev_ops_init(adapter);
+			break;
+		default:
+			return ret;
+		}
+
+		return 0;
+	}
+
+	switch (ent->device) {
+	case IDPF_DEV_ID_PF:
+		idpf_dev_ops_init(adapter);
+		break;
+	case IDPF_DEV_ID_VF:
+		idpf_vf_dev_ops_init(adapter);
+		adapter->crc_enable = true;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 /**
  * idpf_remove - Device removal routine
  * @pdev: PCI device information struct
@@ -165,21 +243,6 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->req_tx_splitq = true;
 	adapter->req_rx_splitq = true;
 
-	switch (ent->device) {
-	case IDPF_DEV_ID_PF:
-		idpf_dev_ops_init(adapter);
-		break;
-	case IDPF_DEV_ID_VF:
-		idpf_vf_dev_ops_init(adapter);
-		adapter->crc_enable = true;
-		break;
-	default:
-		err = -ENODEV;
-		dev_err(&pdev->dev, "Unexpected dev ID 0x%x in idpf probe\n",
-			ent->device);
-		goto err_free;
-	}
-
 	adapter->pdev = pdev;
 	err = pcim_enable_device(pdev);
 	if (err)
@@ -259,11 +322,18 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* setup msglvl */
 	adapter->msg_enable = netif_msg_init(-1, IDPF_AVAIL_NETIF_M);
 
+	err = idpf_dev_init(adapter, ent);
+	if (err) {
+		dev_err(&pdev->dev, "Unexpected dev ID 0x%x in idpf probe\n",
+			ent->device);
+		goto destroy_vc_event_wq;
+	}
+
 	err = idpf_cfg_hw(adapter);
 	if (err) {
 		dev_err(dev, "Failed to configure HW structure for adapter: %d\n",
 			err);
-		goto err_cfg_hw;
+		goto destroy_vc_event_wq;
 	}
 
 	mutex_init(&adapter->vport_ctrl_lock);
@@ -284,7 +354,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
-err_cfg_hw:
+destroy_vc_event_wq:
 	destroy_workqueue(adapter->vc_event_wq);
 err_vc_event_wq_alloc:
 	destroy_workqueue(adapter->stats_wq);
@@ -304,6 +374,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 static const struct pci_device_id idpf_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, IDPF_DEV_ID_PF)},
 	{ PCI_VDEVICE(INTEL, IDPF_DEV_ID_VF)},
+	{ PCI_DEVICE_CLASS(IDPF_CLASS_NETWORK_ETHERNET_PROGIF, ~0)},
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(pci, idpf_pci_tbl);
-- 
2.47.1



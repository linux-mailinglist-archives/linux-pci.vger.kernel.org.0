Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4E566633F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 20:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjAKTF7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 14:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbjAKTF5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 14:05:57 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20901B01;
        Wed, 11 Jan 2023 11:05:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kubdJqDUqAlNPEGd7J/wAJRGsM/3hM9JjDQ8iFpsJ66VG+bmLp1kVk+Qe/ZjzlPKrARGbGxpt0u/zg5vwE4kMihKUtIq2sUgGtuuUaeEAVm07uvVkxUFD2My1LG26knaoi/wA28ZqC1e/xsN9U03+8wPaJpwlZymzeWSiaRqGEWdGfsTVffp89Z0V0KfIl0znKpITyD13/KnunC+u5SGXBQyS0qi7E5dP2erbh3TNbHr+SZaWToMqQtySJbl1DdZULPJmfYOiXi82cAl2xqhzGdkRaRLy42DNQoPQStZpCbXqWVd1Rh99S/Dq2Pc6oOOz64wfl3OkjdqJ/rn8JNMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlGtpj1hFMlePbUiz2GjxUz+0VUauZy4uNYRZ77KOXI=;
 b=RoTf8GFxq3OM/Xp+trBvn/XFcBbgJBEJnjJgXPGKanvinVCKyl5+I2Dlz+li5VkjBuxOREXW/M8rlo504usjgf4qr891EPml/OzJMkFZ8JhctZTBGc2zkKzsdgv7CQs7p9RB+YaCUP2hnwJcyFQpph/xGWGQ716+AENViQONjDQHjS777C8S5IE2iZFfu8FYHH/Gw4MqAdijVVFBqxKbKO+6QqmjGwblElPrn9wj9tpoi0JLdJ1qmrN4LFIkaaZgXDMaf1VDcC8c5Eeu8rM/ykUhhe1O/TvbECnEflumZixgdUvX4x/hGTNYRJm4MBiWo1lTccuNvIPaVTmpmX/fwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlGtpj1hFMlePbUiz2GjxUz+0VUauZy4uNYRZ77KOXI=;
 b=uDagvio6qJSjt7F6M9oD0kMjN02zUUI0FFbxDmNbOAOm9AzI4QTmImnvDP9klBCwuZLwg3bsevkAzaGMmgPjH5vk05o+7RNA/AcTtjyF5FovqSIXOVe58GrcLuqQS7jvgYS2d1DfiTVHThMdUfFRm67KJjDc0JERwwPXoWo6jg3983HZ3nNp40liYbds+xEQMMJRaPs+TE5sp7//q7AJj7U2SYcYSEpJCiGfRr5PRtlEydIJrgBFw3iC2ICam8q0DSo8BB0VjVR7yKK7Pqtu5Qjx82anYVwI+6CnsjZBNkL1BIP6JR7OtVUsmE+eqRDSdFJZrBdqdT5Oo5gQw90Lxg==
Received: from BN9PR03CA0202.namprd03.prod.outlook.com (2603:10b6:408:f9::27)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 19:05:54 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::cc) by BN9PR03CA0202.outlook.office365.com
 (2603:10b6:408:f9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Wed, 11 Jan 2023 19:05:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Wed, 11 Jan 2023 19:05:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 11:05:41 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 11:05:41 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 11 Jan 2023 11:05:38 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vsethi@nvidia.com>, <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2] PCI: pciehp: Disable ACS Source Validation during hot-remove
Date:   Thu, 12 Jan 2023 00:35:33 +0530
Message-ID: <20230111190533.29979-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230111145206.23919-1-vidyas@nvidia.com>
References: <20230111145206.23919-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 9908a17e-aa7c-4e5f-d0c9-08daf406dcef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrLke1T1/4GBmu/cVh9AYXT9HRFb7y4Ht9cULDhkRPDqXS0EM1eeVk4OQFA1YOkE3L53uzMq6d7S5AH89wqV3C84IkrBbT9/e0WPvaeXVVfWLTUeV1PAIeiKj3Q5iR5VFMswOVk9mocSiMpM2nJOKlNrdSWkgFmM5kA7nnbQruRP7G4rS3AGHj1QWsJaH6R9q+NrqOXcSHdFApCe8qGCmxggJhTCGlXZBuw4oOCQkL0+LQSfiqNRfZPJsCrrkLkyPjHz9wVP9QpjealvK0GJ6B0QyqreoZgqAsVyd5xmwLCQPfWOviG6lJvHuXGXYpjmLn0a1YGkI74ZESBVooYdUWcCwnqBrMJ2dYFW75JpW2o/FomKBR0JE0JTzwEo1X2CHE9CW42P/M0zpqyhzDrlZW1SOYpt5Iwr4etPhC1v7r8IBTSMol2gwOz3GbLLtxP/XGj4NLRszrQnDvA2yhMEQztbkIaVlwVIw+M4HtZX4nqX30QzpJfXyubxovbNrxGh3r3GyVkzl2PjPpYheNIZ/RdtELqIzI6IP4teaeVckx1QhphaVPyH6sz2Plkli5fPHjtyV4CiBVbruI2KtimB0JNOivjqXTV4jyemIl+P2avCwJ5MY39Ph1gIF1qqOXuDhLmeuPZcVtoj/Lydplj/+eXapKi1BzbS7ZqbCYDZ4Y+pavJ1uGZAHAk+ZQx57w2t1UH7F6ZkaNu73cH8oV9+lw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(40460700003)(1076003)(426003)(36860700001)(41300700001)(36756003)(110136005)(54906003)(4326008)(316002)(2616005)(70206006)(8676002)(336012)(70586007)(86362001)(82310400005)(7636003)(356005)(8936002)(82740400003)(83380400001)(6636002)(5660300002)(47076005)(40480700001)(2906002)(7696005)(186003)(6666004)(478600001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 19:05:53.8156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9908a17e-aa7c-4e5f-d0c9-08daf406dcef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe 6.0, 6.12.1.1 specifies that downstream devices are permitted to
send upstream messages before they have been assigned a bus number and
such messages have a Requester ID with Bus number set to 00h.
If the Downstrem port has ACS Source Validation enabled, these messages
will be detected as ACS violation error.
Hence, disable ACS Source Validation in the bridge device during
hot-remove operation and re-enable it after enumeration of the
downstream hierarchy but before binding the respective device drivers.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
v2:
* Fixed build issues

 drivers/pci/hotplug/pciehp_pci.c | 13 ++++++++++++-
 drivers/pci/pci.c                | 22 ++++++++++++++++++++++
 include/linux/pci.h              |  6 ++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index d17f3bf36f70..ad90bcf3f621 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -63,6 +63,7 @@ int pciehp_configure_device(struct controller *ctrl)
 
 	pci_assign_unassigned_bridge_resources(bridge);
 	pcie_bus_configure_settings(parent);
+	pci_configure_acs_sv(bridge, true);
 	pci_bus_add_devices(parent);
 
  out:
@@ -117,6 +118,16 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 		}
 		pci_dev_put(dev);
 	}
-
+	/*
+	 * PCIe 6.0, 6.12.1.1 specifies that downstream devices are permitted
+	 * to send upstream messages before they have been assigned a bus
+	 * number and such messages have a Requester ID with Bus number
+	 * set to 00h. If the Downstrem port has ACS Source Validation enabled,
+	 * these messages will be detected as ACS violation error.
+	 * Hence, disable ACS Source Validation here and re-enable it after
+	 * enumeration of the downstream hierarchy and before binding the
+	 * respective device drivers in pciehp_configure_device().
+	 */
+	pci_configure_acs_sv(ctrl->pcie->port, false);
 	pci_unlock_rescan_remove();
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..9cefaf814f49 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -991,6 +991,28 @@ static void pci_enable_acs(struct pci_dev *dev)
 	pci_disable_acs_redir(dev);
 }
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE
+void pci_configure_acs_sv(struct pci_dev *dev, bool flag)
+{
+	u16 cap;
+	u16 ctrl;
+
+	if (!pci_acs_enable || !dev->acs_cap)
+		return;
+
+	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CAP, &cap);
+	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &ctrl);
+
+	if (flag)
+		ctrl |= (cap & PCI_ACS_SV);
+	else
+		ctrl &= ~(cap & PCI_ACS_SV);
+
+	pci_write_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, ctrl);
+}
+EXPORT_SYMBOL_GPL(pci_configure_acs_sv);
+#endif
+
 /**
  * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
  * @dev: PCI device to have its BARs restored
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 060af91bafcd..edf516e39764 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2239,6 +2239,12 @@ void pci_hp_create_module_link(struct pci_slot *pci_slot);
 void pci_hp_remove_module_link(struct pci_slot *pci_slot);
 #endif
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE
+void pci_configure_acs_sv(struct pci_dev *dev, bool flag);
+#else
+static inline void pci_configure_acs_sv(struct pci_dev *dev, bool flag) { }
+#endif
+
 /**
  * pci_pcie_cap - get the saved PCIe capability offset
  * @dev: PCI device
-- 
2.17.1


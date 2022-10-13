Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0F45FE13D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiJMSaa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiJMS3z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:29:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052875F7D;
        Thu, 13 Oct 2022 11:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0pNJ6HQflBerQqdtcPn9y8XOZrVvvoO647FTQHzehOeiTJVRv0+21HKbxxECRmmDm0YJ+2aRKxZaHYSiYz8mLvBB47e0odlXCxETPZQMedZZpl9fkca0+Dp3wGDOGuTintvALJ7GLCT6s35PT1ufye4PNpmQ75eoQyDES5xhuurKOOzy8rd+YNwjlDaoYBlt2Tcha8GeH7OW6b6a+bMgjtoIUQ3gvXMxWOfgxaYtR8+6nNomCWp+koJrZWnWGRnWrTHYeCzwpRkAhEFV+mepPfbD53sDiVWmx9kOs/hES55WacKYT6yuMd1al5tfzJ0iDwJvMHVWtnj9DGH6Vayyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsA4uQ01EdG+ilnai4rK6DBD0JGZanSoznoK5UreRrY=;
 b=AONtkKEkg+un6kxYtN6XMDGmZVCBnHghKrhGquZ6+rseWIVMkAzWwoWxRA1z7hqZEUCMQVvhUucb3mgemnX4MxWXQhdOPteDwRtEpAx0m6mlJ7I/OVM199Uzl4GMPefSUN+yFXxCPtQr2XWCiRE63CDrbU9H0+pjbKydMDggdgAicYU1G5ApmRGtg6cEnzFD+PZutsTlZ31zYDNbT5IBDtQhuAr+giwDq1r/FHOJC/L934A//efqbuTo7d+WGuaCvPVFZ01jqJ/brxdZAQbVuHGntIGUMNjar0lGLQ7B7Jebg9Kfj/uJFWM1nvv8f4ysBcU+IHlVtcxdxxm9xXHryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsA4uQ01EdG+ilnai4rK6DBD0JGZanSoznoK5UreRrY=;
 b=BF2C3Qmol6z6Z2gv3IuWdogdykD94wiJ2/Ol8ax0v8E73qGJykafzqTf04BhoMA3GTpVxv+oMBQV7GthBEL6BTj/pfHOhgz2aeDLAbdWiRX0S5h3DSCf+goCs+zhrpJKQU09R/e2suelY7+szEI33NKoQh9Mj9ZgaOsxTJRYJ2e9nbihL+iasHlZ+2Tq76Qy3oatlVIdGna0YrdM6H6zbO/3gjHPZUNbRreccFrVHrjdLtrQHQ6HqS9sN9uIhMH3p9vwI0VzwFCitYIcvVCv7EtJZbQ0KNx0I7gy/wY9gDKlcyXVtC4Yt0W6XOJoQ0vgEY3z5XIuEYlVYnoOqvp/+Q==
Received: from MN2PR17CA0029.namprd17.prod.outlook.com (2603:10b6:208:15e::42)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 18:18:52 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:15e:cafe::91) by MN2PR17CA0029.outlook.office365.com
 (2603:10b6:208:15e::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 18:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Thu, 13 Oct 2022 18:18:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:18:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 11:18:33 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:18:29 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <mani@kernel.org>, <kishon@ti.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 2/4] PCI: dwc: Add a DWC wrapper to pci_epc_deinit_notify()
Date:   Thu, 13 Oct 2022 23:48:13 +0530
Message-ID: <20221013181815.2133-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013181815.2133-1-vidyas@nvidia.com>
References: <20221013181815.2133-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f97d747-93e6-4f22-6b45-08daad47616b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuaNDDcFR0Q8CfqSyaSevcpOIoaJboFc7/FFs2JPBRtnvETkAaqwqCBJCQ6+C8ZSfY2/7FjK1FUTcA5o1z5ax/Ud+LCjt9A50XgFwnKDBaIyu7VDoRdkjUuRtKSZXAUzYgq3oeKvyAoTu9bmtyXrfkkj3x5O0m29EwyQiWhRnbHC58YKhVlDiD0Vrf6r2+zSr/ZhX2bY/VmYmbqAGZ0g7dOZMjCf6/52XRS6yY92rpF8NjjuDEey1RS/BV/HRRPUflaeY7XCNNOljQx19Y85rbrn6fwqcZkwWf0/t8aiJv6o+HplPOmOOYJbTskzk7jEWEocyUnbWK/YCzt/zqVg6X8YMvJNP9kAT6NoYU3VZxTTSMqzkC0FUxtfW0clzXGi1MrO7x6YRDqvsXnnG2WuNq+jktZTv761DElAqblczGbPDyRxuM5PC7yT4tAsWLS1CPPRLBrGOyTFJeOMRTBguPpEAytUKppvWyJWcs6aAl8iRIT8SOWiLi9Sntk5ugaG4S56ZhCumVeY6S7qK0J7CLG9Z/TQSC87FLdDSLRyOoSGJtrPUDGmYeH2HZ5figbd0QFSkzftwKZlQt3iQdbc5TEgNRLhScgdc0y20gzaNb2OxKG12dqnT76DvAF2ev8hT2fh97GquYV6Emwfm8df7g+NE8ORXEDS8ArGjRgRXgponiXI5zbe7+CP17//vFWOVEzxpA/qxO6TbDGD+bAPbSwxtM5vnciwBBGB1mXjekjKFI+U/lVrPEoidKIolHVBlZ3JNJcEztbiTUPXZ8ZKCg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(2616005)(1076003)(186003)(426003)(336012)(7416002)(47076005)(356005)(82740400003)(41300700001)(36860700001)(5660300002)(8936002)(2906002)(4326008)(7636003)(40480700001)(110136005)(40460700003)(8676002)(26005)(7696005)(316002)(82310400005)(478600001)(6666004)(54906003)(70206006)(70586007)(83380400001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:18:51.2715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f97d747-93e6-4f22-6b45-08daad47616b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a wrapper for the pci_epc_deinit_notify() at the DWC layer for all
the DesignWare based platform controller drivers to invoke during their
respective endpoint controllers deinitialization.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Reworded the commit message

 drivers/pci/controller/dwc/pcie-designware-ep.c | 8 ++++++++
 drivers/pci/controller/dwc/pcie-designware.h    | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f300ea2f7bf7..fd11c2e68fef 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -737,6 +737,14 @@ int dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
 
+void dw_pcie_ep_deinit_notify(struct dw_pcie_ep *ep)
+{
+	struct pci_epc *epc = ep->epc;
+
+	pci_epc_deinit_notify(epc);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit_notify);
+
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	int ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7252513956b7..0f3ab39c5281 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -469,6 +469,7 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
+void dw_pcie_ep_deinit_notify(struct dw_pcie_ep *ep);
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
@@ -495,6 +496,10 @@ static inline int dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
 	return 0;
 }
 
+static inline void dw_pcie_ep_deinit_notify(struct dw_pcie_ep *ep)
+{
+}
+
 static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
 }
-- 
2.17.1


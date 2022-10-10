Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C7F5F9D78
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 13:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJJLUd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 07:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiJJLU0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 07:20:26 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F46B3ED57;
        Mon, 10 Oct 2022 04:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBZLJADoWpX/fnmb6Q4BSSX5U8eaLuU033/HRnlT3uRiaS/RUlPSoW+7Kf1yiGLMRnX8p76cRhuYy2ZFn3UKFhmVCM3r6Cd8VlckieBv5rGs2ko8LMn+IAmqacbgh06YZWjz/9EzSQYlkl8nZgCI7KS2792etExoFiUaPnBa/2r85hKCMwUVSkqmyk5AA3MPUg0jZmkN+BbZkd0qMWsKjuej8H91kKsnt+du+o1qGRnaxRFgNWLL9jpQoLJZsM0wceAplBgd8Lq02qItUmL89y8ifmzU4d7QZqvXuZy+tscby5xvIjHnoomV4fLtdchxvAktpSED+zVCH7cBy4RgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PKYm2+RokvDB36j+UmQZlu+NVHYjm6RltJ0EJ+ndJA=;
 b=cFnWHV+P/ZZ9nr04jvg+6GFbyUrKLVf/luTLay+BWYOfRFCZt0iQJuUo2YPW2/Hn42vKPSMimo3lccdRN9AaXpVaoFwv+14g8t/g0wjAkcmt0U1oOnBeHQyaKYN5kfP+ePlB+Mhw7o+0yXcffXcpNEqoHJKLwwrEB9dhEkibW6Fp4HgyaHhNIu4XnZ29brBoR48WXQu+jc8XOcxJ6FayslobEpTGaK9BsYRLjR8FDNxPW/b/9yr1/8dqhsaUTYy72fieCyOf+rJ3f+9EAxAQmnm8k3wzFr0+GrW7NmHedXgHiJmXhbuCtTKt8nXFVkkXvICYQSCViDqZuQ+F6YG7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PKYm2+RokvDB36j+UmQZlu+NVHYjm6RltJ0EJ+ndJA=;
 b=h0Ds+EtMFbKA7a55/7am90/yTHX2+1AjHHRosH9YTUfxRW7r8tiEqp26JqdHgEZjd5HyVIqBW1VerMYbNrpPn7F7C+j0UIR8QNM9imlTppJLBttQ/vUG6PGDab/RYNlHzlaBsLCnNvrKyMIYpuIWf6PVlBP78Jrfpqt3SrFw07MUZA7WKKJTx7ZzdMCcrsHpP9hNlMs1Yt40IFD94BXHgPIQDnee6BBTy0xzYDf5X6LwbiELHQTcEIdIsnSKHFAUFRbdUkqiC/D3WqM/9eftuDJvBbj3K2mIiEVUOuwJBR4uv64wiFd9ght37o2PTRBdFea1UAFm8b1X0IYLRqMh8w==
Received: from CY5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:930:8::43)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.30; Mon, 10 Oct
 2022 11:20:22 +0000
Received: from CY4PEPF0000B8ED.namprd05.prod.outlook.com
 (2603:10b6:930:8:cafe::39) by CY5PR03CA0015.outlook.office365.com
 (2603:10b6:930:8::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 11:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000B8ED.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Mon, 10 Oct 2022 11:20:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 10 Oct
 2022 04:20:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 04:20:05 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 10 Oct 2022 04:20:01 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <mani@kernel.org>, <kishon@ti.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 1/3] PCI: endpoint: Add CORE_DEINIT callback support
Date:   Mon, 10 Oct 2022 16:49:51 +0530
Message-ID: <20221010111953.5422-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221010111953.5422-1-vidyas@nvidia.com>
References: <20221010111953.5422-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8ED:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: b67f5d4f-fcf2-47de-bc4e-08daaab16c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HHs+INUe3Enek6VwxDHmxkXYdl8cXio5y6swCzKAWRZTKkDuAUEr4l8kNqCKc2g/a0lD4YdnYQypSP1iJvVoHbMc6ePfkaD2ofPxEduTeHi0A+8zYr72Hm9nNUbVjurmNXbxILuuaDauaijBZxkXiU/H4OmvJUOiZL12D8fWOTRyc6EBx4hFYCH+EVYFCvD0W7yanP4ZqcEUnlArheuNUbVSl3AvcpYgnf/rTETk6lfTpoo/AqhZ6udbtkTK75khjmblgdtaytRJ3c6ip6soRv9sY8vCDTEXbjpPslr8mDhoEIIiNxdyyCR4Ov5sRnUeQHJ8THsU3iNE5GCGpmzDOx49du9NJBFsxYv9bt0CJfdXTHar5M6FQelVu3MaZV3Jsi+ias4MspCLGxIw102tWSdQG/TZoC/dk6MbR2lGr2zliSvkq22kG3PdSUtEjAT985qBkRsXtMJ6SdNQzNuLTFOC7LQJdrVgGRutq0IU0tqzd38j4FxlXJCsA4YemX02EjhesKZmYjptjGonnozgTkXsUqqYxO88zuR4D8yRNxBIra5vmJ6LUu/ExEV8jQjSqbZ3YE72uK1Ri6dNX2GDXtTUAR4YCrr3pYDXi9sC3NEtOReXnjxMOIZ6MXyWSwrYiAlSZnks9o67RNP4XBRkOWtIkKa5wKMN5hhZC14sznzDJaYbPRGjJchHfKehr9tQ3AJDdYyHPfV1XicM91fXz8h+KBsHgxHgAcnsnW/WN7h0qbBolUcv++CedivmM9VKisXe/g/mQakq+Xc546JDQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(7416002)(426003)(5660300002)(47076005)(41300700001)(2906002)(4326008)(316002)(336012)(6666004)(356005)(82740400003)(7636003)(70206006)(40460700003)(54906003)(40480700001)(110136005)(26005)(7696005)(8676002)(70586007)(478600001)(83380400001)(8936002)(86362001)(82310400005)(186003)(36860700001)(36756003)(2616005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 11:20:22.3727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b67f5d4f-fcf2-47de-bc4e-08daaab16c12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Function driver needs to clean up the hardware resources and stop all the
running processes accessing the hardware during the endpoint controller
deinitialization. Add core_deinit() callback support for the endpoint
function driver to do the same.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 26 ++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 5dac1496cf16..689450f01f75 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -732,6 +732,32 @@ void pci_epc_init_notify(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_init_notify);
 
+/**
+ * pci_epc_deinit_notify() - Notify the EPF device that EPC device's core
+ *			     deinitialization is scheduled.
+ * @epc: the EPC device whose core deinitialization is scheduled
+ *
+ * Invoke to Notify the EPF device that the EPC device's deinitialization
+ * is scheduled.
+ */
+void pci_epc_deinit_notify(struct pci_epc *epc)
+{
+	struct pci_epf *epf;
+
+	if (!epc || IS_ERR(epc))
+		return;
+
+	mutex_lock(&epc->list_lock);
+	list_for_each_entry(epf, &epc->pci_epf, list) {
+		mutex_lock(&epf->lock);
+		if (epf->event_ops->core_deinit)
+			epf->event_ops->core_deinit(epf);
+		mutex_unlock(&epf->lock);
+	}
+	mutex_unlock(&epc->list_lock);
+}
+EXPORT_SYMBOL_GPL(pci_epc_deinit_notify);
+
 /**
  * pci_epc_destroy() - destroy the EPC device
  * @epc: the EPC device that has to be destroyed
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 301bb0e53707..b95dc4b3e302 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -204,6 +204,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 		    enum pci_epc_interface_type type);
 void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
+void pci_epc_deinit_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index a215dc8ce693..fa51579951db 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -70,10 +70,12 @@ struct pci_epf_ops {
 /**
  * struct pci_epf_event_ops - Callbacks for capturing the EPC events
  * @core_init: Callback for the EPC initialization complete event
+ * @core_deinit: Callback for the EPC deinitialization schedule event
  * @link_up: Callback for the EPC link up event
  */
 struct pci_epc_event_ops {
 	int (*core_init)(struct pci_epf *epf);
+	int (*core_deinit)(struct pci_epf *epf);
 	int (*link_up)(struct pci_epf *epf);
 };
 
-- 
2.17.1


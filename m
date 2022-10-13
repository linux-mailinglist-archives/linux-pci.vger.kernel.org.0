Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56405FE13F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiJMSai (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiJMSaA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:30:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE03182C78;
        Thu, 13 Oct 2022 11:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF4abMpEEpJm3oc2xaX/CkOcuPFNXitfphtL4b0XTjqWawFbL/UfwW3puQD/uCFMCHApFKe6RXkKQH/DGTImouwRaPdRjtN+7mh85rPx7eojZUMB9L+iEQ3hyuv09F/bmzQH2oHEYiNAIl2Aa54ZQMyJ82XVH17M0jMMbnZ+J3/u0fLbBu5L2EN0gwZAByq7iy4XQ2vmoO0M/Qwlc9KPCz5FDcL/HN4QMZ725Q6krbEX0G/Ejc/k1RUD0EUb5ca9vH4ecPDARiDNtfQk2SKAT35fEzdTzLNcZ5xr59EmnH4AZbcKXQ6jTogp0r8/zVVQkjM4E0iJaOGdqGHd/uNy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3cy18Z3zPwKeR82/S2tMeEOQVTTzj1T9s1HDYRLS5g=;
 b=eC9ST6jx8qkMqnTOPN332cPFlK3atWcSX122ukVDTvpTWshb8eca3G/yruQKdyVnVkC+tr/cWFCZCEkc80mtUbXJxvmRLXzpdv2MrlFh6IXeXQSze2VY9r4QzF0RwH3fYQ52Fg1OoRwMFxZUoSxCcxi9WW6o+4dwlnFWKOmmjuZbrOqfL817MkDbrImSkdFf502xe+QrLBenRizVLo5Y4O5K0m2jjyJNvER7ODGS9FxcJHdvkXGyeG46scAp4KDZxF8Bsgvykw3eaiTv2efopsO8WCQD8SiBjqIfYE+zkUVq9ZF3gH89zR55EaOnmQgcLye+NTwSKUq0og2ju1AB7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3cy18Z3zPwKeR82/S2tMeEOQVTTzj1T9s1HDYRLS5g=;
 b=hOdUDO1VLeaqAykWwCcq9e2GzAzinu5ZHk0JR+dNE/I4bDKlSQW/Jd+JJ8BMY9FAc+8UFdHX1ynGkNv7Tk24SOWaG3B540XBdERx7BNFxQKB/YeknYNg6BvpUyAQFy0FlAEghjtxQ+QRdkvTKorY//zg9LgL/qSaDVKurvERHdUuTMFbbfTkaYFh0OUHiGmRk3W5pFzskLIVTPJreYN94oDMWZNipWHtOOeBHCywq7ZKHxrx+MPP5xla1vuMTlUQL/FVtDVQhO0C5cR/aAbBojybmyEex3njsgLxQErAFnNZP0ESbQV2uiH6Lv/1Z/qQ5jCgyl8NbebVGXZ9CoL8Mw==
Received: from MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22; Thu, 13 Oct
 2022 18:18:48 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:208:e8:cafe::e1) by MN2PR20CA0032.outlook.office365.com
 (2603:10b6:208:e8::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22 via Frontend
 Transport; Thu, 13 Oct 2022 18:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Thu, 13 Oct 2022 18:18:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:18:27 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 11:18:27 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:18:23 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <mani@kernel.org>, <kishon@ti.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 1/4] PCI: endpoint: Add core_deinit() callback support
Date:   Thu, 13 Oct 2022 23:48:12 +0530
Message-ID: <20221013181815.2133-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013181815.2133-1-vidyas@nvidia.com>
References: <20221013181815.2133-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f80a3fe-7389-45c7-b950-08daad475f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xyfLdC1ghsCjwj2KttnmouswCn7SIO0rxAV3BQU75eEa+nbPgt8dKxv22FRPSgyJysE8JU4i8shTxhtUiUlD/FTYQnE0cn8in3gT0vOvnxzs7fp8m5D+9oAmmn1DyhNXZUqnk0LcMoqkOpHqcrEKfdgbVlyhD9fo3d0jCy+LNPHmsNYoqvJqiIUb1blz8Ga7M76DZbfy87CXRutJr1EgqewMyVSM2SQo11/G4AJTIZOqJ+F7CXQsI3Ly8IM00I52DLF8J7fodWdZXpzqv0LZ1IZe0P9GVrD50xY6ljj0uEraWXDeor1FFZdh1C8MYYZ0Qb6BhzVqgI+HdJHdtNre9DYSMWyLWp/33Dk6T4flMnVdN8JkxAY5RlhMgW0srQOe9qLqSJmT6KK8N6Tl030jfYOE7K85ezIan0h7Y5UyKm88ByOzcquh4TRVS/HqaWYa+E/DYDaS8M7XvheMuCQOJyu5Y8GvRRIWhR8HhQjx+oAE7TpPqof3XH1F9xDyz/vk4czlV7ePqbON52HiaxJBeW1Ff6EmzhPbB/KxVWevzJNxk0YJDjItQux5lM/3cJSHV5gb7QW9SQAkWgVlPq/fBFa1yRd8fst7B+p9kApg0MhO1E8Lor3hphD8TkAft5i6lEIwwnrAswEqAUlSLpDRt11C4wqkIOnEkPupTUtjSylkBQOBvvkvAY7OLld9Vww03d2/E1aCP4dMb84r/IxIZoiyfHPGpZIOU1lsTAUvIJ1IoJ/WwCXU/j2vEdtxFtqDP4Ni/WIQNWKTbmTPm59lyg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(478600001)(7696005)(26005)(70206006)(70586007)(82740400003)(8676002)(5660300002)(41300700001)(36756003)(54906003)(316002)(110136005)(86362001)(6666004)(4326008)(40460700003)(7636003)(47076005)(40480700001)(186003)(426003)(2616005)(36860700001)(83380400001)(1076003)(356005)(336012)(82310400005)(8936002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:18:47.2365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f80a3fe-7389-45c7-b950-08daad475f03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The endpoint function driver should undo the things done in core_init()
and stop hardware access before deinitializing the controller. Add
core_deinit() callback support for function driver to do this cleanup.
This core_deinit() callback should be invoked by the controller driver
before deinitializing the controller.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Reworded the commit message

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


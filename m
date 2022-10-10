Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5CD5F9D79
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 13:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiJJLUe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 07:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiJJLU3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 07:20:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1350B4B0D1;
        Mon, 10 Oct 2022 04:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXnTY4jkluqP0cYwLmtQlFRFKZfZ92KY+BtChzTtTKw/wqlgFV7nige3xLbgfIm+k9/u4Kjfe4JxwjKj/G6wgz+3uvHAyIX7NDBrKfWNbRmDFof+Yd5n2gThPE49AmeP/vWmxUSzMET7IkXTDUgIJAPDup9cXX4z+8IbaGPhhbQQ5dwzewWXsdO+MwvfwgtOfFJj968wnB7IHlyrG33xhxaaFiQuzw+GK4pZ5J79NmVYjtTSaKuH0nDObwWfq4Byh5Dsu1p7Jk7KNBoUMzz8rvv9FFNa3u3vH899goWkn1lohIsPR8eiNZ9SMZyHoAYnl6QycgfoU8yWBn81Pf8qNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuVFhITOYzpkLWs84c5wgbEXOl2NbFeerQuf7zSu6Xo=;
 b=dxmFR+ggbLE6yOpzXhl1414Po5rR93jjwO1m8651U8HkOIaKPN5YWK/Eqsrf3KVZetmtwuJ9sjGc+DM0+TJlZMyPk1mPWcEMiX5Vq9nvMDChwnINOAe2DD1m+7oSXZvrMM9pEjno7svLsItvREs2kRnI/4YD8TqMLmp9wfTM7jiPKq8Js2qdUSFfbsFGYItQQ8/deebbgiBc1CQWxni8RPQENCg3B6ObrTgnpCy29fcDP7L6Yul3Vg3D1atgpu5pyVqG/fJZrJsuyHyZoA666ivREr8Fw1B7bwa7dzAapIx9O8zP+ap97sb4/kDd4OMBEeZZC0TCjWI8BAmUXAEVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuVFhITOYzpkLWs84c5wgbEXOl2NbFeerQuf7zSu6Xo=;
 b=ZhK4mK7nBAU3YC+gH3qdHBbbVo0Pv9NSmFS7lFPuIE5E5NUPUp7YmmGKKifkT16H+QHbKqc33Kutwz9Fj4fqemSMjzJ+n0+imJbWNCoXUWaBRGqqRuaRJ0FqmaJ2wG/3x9iB6fiphgE2dxO2eFhqMZwpO/+pI6w2U0t8/wovdpxFGubEytFRglflwDgK745QeWM8T2dhyOsv22EctWtcLPHnHv/A3CN2T1WRpZKixVrTfspEND9xFROUXpDP2ITQUjGlu20FBgWwW9pNMW/1BdBAPrunkvJiLgkz4jpCAqt4+ryU2v3PW0LOFy6qsmBiPBeC1U9wubsGzGcL2dOk/g==
Received: from MW4PR02CA0026.namprd02.prod.outlook.com (2603:10b6:303:16d::25)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Mon, 10 Oct
 2022 11:20:24 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::e6) by MW4PR02CA0026.outlook.office365.com
 (2603:10b6:303:16d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 11:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 11:20:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 10 Oct
 2022 04:20:11 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 04:20:11 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 10 Oct 2022 04:20:07 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <mani@kernel.org>, <kishon@ti.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 2/3] PCIe: dwc: Add a DWC wrapper to pci_epc_deinit_notify()
Date:   Mon, 10 Oct 2022 16:49:52 +0530
Message-ID: <20221010111953.5422-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221010111953.5422-1-vidyas@nvidia.com>
References: <20221010111953.5422-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT100:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 239f6153-f2e6-4a04-ae2e-08daaab16cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N7dJXJmzbrGsd+lEZE9pINIdgCNC7SLibUlo/HXgrAjCgWfmEM0aHhkOau0CVc+b5jgZ19/8JraKsByF/OnquUc7WUJ78jJ6e8J4yV3OCd8lzC0gxiXJDe0ibtimxS36JIc52G4D/BRpNE4+MPW38STmKFnU5v7hmE3njSPqfykL9rgZ/bmFygae01cGdj89YOaXiN5JNLMKwhOuXbqIJMGxyFYgRv9U0jZPoRzrtVisrw0sItnUeD+3nx5zw5m75kbf/jVWVhUvVg0M1QjE51vziuRVznkbUyWGCWoimDIaMZirZv+NUG0hEWvj+xlPv2eNqKZx6yU283+amv38S7Urx0sSFM8nxFZY4O5Ui6cMe7kzpUNmT/Mr84WXdpR5nlO6JeRYxyPWJd2V4bz5k6oajaXEmfWXWf1q3Hh0swbhZlHlhhHqsv/OBysYGMY8YwStxGM8DDPmDO8ezFFbvmlcGu8Zi9eTlzY18jY8bFGkVneyANF8tepJBf7MRQGDSBU5s0LCZOMzAS8k/XfNOkWyqkBH6otlNPJirWhENBpE4hCyXN6aJX0KKPns/FvmqWK9lz7JbqKCxxlCTbymqhb3Egb6c7EYJjTJ18x+Xkq86egkaa30pGyYnYbT2zR2pyJK7VVXAr/rH7601BcKVPz2nWBLUXnabblDCQvgJsbdVFgsBVmlP+Tx9zQ5Xgn8nsVMvnvAcVIMz+Vn9rAWwFaMoGs6ikP4G4VgB8avERgOJQDnrJWZIuUJwapcfe9VgKdNCnsMsSE9hhPgV1Dajw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(47076005)(356005)(316002)(478600001)(82740400003)(6666004)(40480700001)(7696005)(26005)(426003)(186003)(336012)(40460700003)(36756003)(1076003)(5660300002)(2616005)(8936002)(7416002)(41300700001)(54906003)(2906002)(70206006)(82310400005)(110136005)(7636003)(8676002)(86362001)(36860700001)(4326008)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 11:20:23.7744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 239f6153-f2e6-4a04-ae2e-08daaab16cdc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a wrapper for the pci_epc_deinit_notify() at the DWC layer for all DWC
host controller drivers to invoke during the endpoint controller
deinitilization.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 8 ++++++++
 drivers/pci/controller/dwc/pcie-designware.h    | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 297d8b306ab8..d39ccb9ca7d0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -742,6 +742,14 @@ int dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
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
index b00bee4b782c..f948b73e8c6f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -469,6 +469,7 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
+void dw_pcie_ep_deinit_notify(struct dw_pcie_ep *ep);
 void dw_pcie_ep_deinit(struct dw_pcie_ep *ep);
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
@@ -496,6 +497,10 @@ static inline int dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
 	return 0;
 }
 
+static inline void dw_pcie_ep_deinit_notify(struct dw_pcie_ep *ep)
+{
+}
+
 static inline void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
 {
 }
-- 
2.17.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB265EA65D
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 14:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbiIZMmb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 08:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbiIZMmN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 08:42:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80AD118DF8;
        Mon, 26 Sep 2022 04:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXmSbJ6+59tDUKFsLLSZvv9VWpwWVwfBXxR7IDvqizVeRZCPjgK2AOGG9VsJ3N1r5dLw4au4lv9LZazTjUZGFZjrHie7ZJD1MAPirstgibnh1WQAAyl1IW0+xu/uKWzxIgNRBJfNozajHG5G92/C0aDyqc/QHILZlttUI+qkOdxYzVJVo4+q3MrhETsgFgwoJ4x3MjLdpCiSlUGAXqL/XPTXIYooI5x5z4rRkb59xFQoeUudJv31yoIcOpDUSeysHzomrbyieZ7nwnjBK/TVlCN2ryvQyaWMW/XIZ1lclqcucE53uS5zmwV6+Xx/aPtob+v037WTdgQ71/shrOlPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/IDJL5lchkbKzafc/TdmZqhIOAXfNrZjJMh3PSv89g=;
 b=d560LALZBxiHjB6LwlvgjuQB4gso1p4mqMAS1MaxWOXhniET+FTE84QiVTR1WiYTo9o6+dtDFMS9pHtnOBTqNT8GOeCUGOYNnQZPvEg2JNqrRaX5Yqu56epmpYc3B1hNvDCmV52HHwh5d8ITxr6iNFGUwhHRYwoxrGpE2zKis4fi53+WZ5JOubwT/NkNAN5wLKKxW/sCl3Lw4Li9+quKQfDVZ2Cu/++4ApklTxl1Wec3FOEVFzmpfXP/SKso+y5u0gc4xHBiSLEu+v7XooclvD2wO0RyTb/wFx1n6estXzKzYnfWSAR1kndt6IVhoo+VV8TmUDpp18YzRZD/A3CPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/IDJL5lchkbKzafc/TdmZqhIOAXfNrZjJMh3PSv89g=;
 b=WRxZDXLypM0jENZOV5h6CSU2LTOWVd+w5/urvhj3Ubs2sF/X4g7GLlMDl264HMO27VxgSXE1WtQMIyCy2nW+Ou5NEjKNL4ZhFw4FaH9wDzOQE7ND3RyVUq1SSkOxpMrbrGmySd7h64t0a84Ag9RGIZ5eO8BcvmsR8fEnLDSC8C33ypxx42JPn/TQo/p4ZHOA1QlacDKtdwD8yRfTxoxHwWzKvjPHIfD9XGRDvs2xGofdOFDKB1LuuHvHqxM2CvCaihAQYHnj5SybaMLoL5PJzw2rmjwyUXZunYghO/vL5hJIjCY+IRqk10auClK7ZQg6Nol28Qrrl1pUHs5Er7Wp1g==
Received: from DM6PR13CA0046.namprd13.prod.outlook.com (2603:10b6:5:134::23)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 11:10:42 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::fe) by DM6PR13CA0046.outlook.office365.com
 (2603:10b6:5:134::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.13 via Frontend
 Transport; Mon, 26 Sep 2022 11:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 11:10:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 04:10:29 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 04:10:29 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 04:10:26 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 1/2] PCI: Add PCI_PTM_CAP_RES macro
Date:   Mon, 26 Sep 2022 16:40:16 +0530
Message-ID: <20220926111017.12655-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926111017.12655-1-vidyas@nvidia.com>
References: <20220926111017.12655-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2d9f9a-9b36-44b1-ac27-08da9fafc0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04S+AC7zgOtqEK8VwgRMZFGU3xa0TAWhHsJxdkNH/bEyRfVfMWmwEHzr4mt8AeCrlBJnUo857JAt4Nfy3xmT7aU0ulbB72BO0BXE6wW7ko+EwwpNui5KDxY0xEBL5kVH8Le3J5kMwfwVlO94oo87gFWQsuMD2iMDuGX39RCRlm8w7imrr9pjMfn5RnVnEKd0kQAK5zSjeq32zYKlijkgd2kohSCPNH5fK7UfJSHXeiq+hL5KNdqNeklXtsacH6EP0x4+1CiIFtF2qE1RySfmdFD7w2quPygtNqTOZnhIAiqmK+f49jyfDc+3Q0GRG1SUXFVJg7JI/LguicUMThMJyuU6skRNul5C7mulXk/6JQ76tvpCZrrWD8VCXZ6onKvlNppf+9vKusjD0NNoxGsabi9ntyTjzcHXvhh7yzu5yygBrMIj3RhpdtFTiZXXcnEMbfn1DRboWCN6FhclK3dpSyN+UIA1321Sh8tJNVP7mObEYwvwerFV7cX7hC8T/LxwUDph/vahxr9V/ChTbByddUJLONmPF9c+4IZ2UpwcVaJ6QmrVXEKjVWKfZLqUqzcI6CaqnEfldfqBqQanT+BvWYABkbQybNTvKhpjHyHQ9XFswJ18Y9cGxny8KBuL/jvL51LaVfOsNzbk2H6ZKlbgLdSSn0719ZutAHWwqKoy2nNF54g9BhsgYPZ1vYhhPVaZBbNyHdKKdqtNupethpQPYlPo4aYOgnyF72zqOIOxDTa9X07APmDt74RHI0zR+2krN87XjDQiq7jPjbIUoXf4zw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(86362001)(82740400003)(356005)(7636003)(2906002)(7696005)(478600001)(40480700001)(26005)(54906003)(110136005)(36860700001)(8936002)(4744005)(40460700003)(5660300002)(426003)(47076005)(2616005)(70586007)(8676002)(70206006)(316002)(6666004)(4326008)(41300700001)(83380400001)(82310400005)(336012)(186003)(1076003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 11:10:42.7188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2d9f9a-9b36-44b1-ac27-08da9fafc0c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add macro defining Responder capable bit in Precision Time Measurement
capability register.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
---
V2:
* Added "Reviewed-by: Jingoo Han <jingoohan1@gmail.com>"

 include/uapi/linux/pci_regs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 57b8e2ffb1dd..1c3591c8e09e 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1058,6 +1058,7 @@
 /* Precision Time Measurement */
 #define PCI_PTM_CAP			0x04	    /* PTM Capability */
 #define  PCI_PTM_CAP_REQ		0x00000001  /* Requester capable */
+#define  PCI_PTM_CAP_RES		0x00000002  /* Responder capable */
 #define  PCI_PTM_CAP_ROOT		0x00000004  /* Root capable */
 #define  PCI_PTM_GRANULARITY_MASK	0x0000FF00  /* Clock granularity */
 #define PCI_PTM_CTRL			0x08	    /* PTM Control */
-- 
2.17.1


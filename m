Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C76A314CDE
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 11:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhBIKXJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 05:23:09 -0500
Received: from mail-dm6nam12on2084.outbound.protection.outlook.com ([40.107.243.84]:2784
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231274AbhBIKVD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Feb 2021 05:21:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZeD4T8ARZrzJRtX6LslvkQP3bO+4X8cnxfMQkERkol4QxJ4srBgxvb+XO+0LOdLMe8DDD/Qi0wDGCccZswdX4qxN6XsUAHt+gfq0/ms5qz1zlXDmYCIbWJ3cA07bnOvx8FCpHsOnYwjnjJb32LInR5xMvsi6LjvID1GP3vxpNm2kKhxRDVlSMkT4rjcXN8DwZFeip4WfkntBWXryN+Kue7B5cuo70OXZPDGeJMO94C/zJL4eAX8J44ncLqfukt3TsS08YmU8dNf995FtiO0yrgZVMU+2X0MTAPilXonfvO9X4/0WzvOdED4clmYpN0gxg2pU61NpKN97s7dBcRjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8+mSReKVu5/l/FJ8ALBYjnmeqXn2KGoeugFYsbdO3o=;
 b=n9rgI1wcuSeogkR2ilpfjuGwjKpThzmCxQWJB4QRx9stmQYP78hDz9qdVEFuzMDERHl8QdMC1Nw6d6kgMgEtRmyRCPm9DJD+BQXPPdySzu018yp4uR2ZE04nPwmbwa4uxSSCF31ADHII007ijI0Dt30Yk/UB80cf64c1jawQh4n27qNehXG7Sp8YHBefQFpD6bWSzcQoJZCXoD+TLqk6RWN5XMn9n3pLGSAwzi48Zjvxo0A+b+0DPgAmQuM6M3POs1jjKPVS7fjvSyUzCCaxxKODgPYn6TEBKRmUhKdYjsq0CcIa7xhxDzJYhk3upIWtEJ2aJ6Nut2BGxA8yYUIQQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8+mSReKVu5/l/FJ8ALBYjnmeqXn2KGoeugFYsbdO3o=;
 b=TKVEodIFumr+UonP3YxRdBD2q09/TC/g7Ewtipo1IzNPU5qKQNztiyWHvQdvbqOGA7lbr/ojfjF/f3Ums3JLcvyr3eW/NT9Prxt/ucnM2bxmwl5LqH+xtDWyGGFKJAEsNenEmp2Rg+UTah8cat6NkivgelR00a/ezW1Qcl42vdU=
Received: from SN7PR04CA0254.namprd04.prod.outlook.com (2603:10b6:806:f3::19)
 by BY5PR02MB6898.namprd02.prod.outlook.com (2603:10b6:a03:23c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Tue, 9 Feb
 2021 10:20:11 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:f3:cafe::7c) by SN7PR04CA0254.outlook.office365.com
 (2603:10b6:806:f3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Tue, 9 Feb 2021 10:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Tue, 9 Feb 2021 10:20:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 9 Feb 2021 02:20:06 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 9 Feb 2021 02:20:06 -0800
Envelope-to: bharat.kumar.gogada@xilinx.com,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=53404 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1l9Q7p-00007p-QG; Tue, 09 Feb 2021 02:20:06 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 2/2] PCI: xilinx-nwl: Add optional "dma-coherent" property
Date:   Tue, 9 Feb 2021 15:49:55 +0530
Message-ID: <20210209101955.8836-2-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210209101955.8836-1-bharat.kumar.gogada@xilinx.com>
References: <20210209101955.8836-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62348d22-ab17-4737-8520-08d8cce44861
X-MS-TrafficTypeDiagnostic: BY5PR02MB6898:
X-Microsoft-Antispam-PRVS: <BY5PR02MB68982735191252BBBCAEABBBA58E9@BY5PR02MB6898.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XqtpnInFK5U7RjGt5tzuUG1+3nPf/cFMO0t7KWy2pXWdjgw2Jiux7QBv89n0wr0k1zikydqAlWPRkszr9tNSldNcg8g2GnW4RaZaZAyM6Aq9/QhhYRyRmvMeE0nIciC+ZcmcXn00+4vE5xlUzbtCKvuLIIok9LbmSdWhDiHYLuLDYi9OFmUFhBLq6lmkN+ImPWCQHks1Alire8iiCBdLQNi4C3wlB6hHNIrhy9vH3zmSaAZhcEVDZ5S534Ahn5ZJ91Watv525lH6Zx0q4uLh53lyoqJC5SUrTg1BwLT22Fxy2uR3q03fH/kLJlUlhCV6OHswdRtoLuoiZL++1oM5I0DntP2EFnE4lQlF/uEdwJZgOr2ZfWnizPtg/qCLNavUbyBlgGXFbqsws7DJ6k70F1zs4MmVwCiDk4dPCCP64WJOLLM/cHuK9c4cIRWWS8YvlwxmnwvSvE9XuCqjW1dPCvEfFANURtIs8Es6iOXfpl/B5cNskgwuOAzPtNJLOWUETWtupbUMSMQdf0TmC9P9rTzq3rLw9Vo6ZRpGscQgyucWDAOsBZ8gXEoo32o8vtoJC90vJLMNMioepqnHnF66Bg7Ev/1trceDXKkQjysEJ7IxqXGFnQnwIlBeMj1epZLfZLFkpz6KYDXpzUrUJ7yhg20gDgmgx7YIja8h7ZKOveQ9PESeDTUKPeVV3QDxmIl2
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(36840700001)(103116003)(478600001)(107886003)(26005)(186003)(36906005)(6666004)(36756003)(9786002)(8676002)(70206006)(82740400003)(7636003)(70586007)(82310400003)(5660300002)(426003)(110136005)(336012)(316002)(7696005)(2906002)(54906003)(4326008)(4744005)(8936002)(36860700001)(356005)(2616005)(47076005)(1076003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 10:20:11.1035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62348d22-ab17-4737-8520-08d8cce44861
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6898
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add optional dma-coherent property to support coherent PCIe DMA traffic.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
index 01bf7fdf4c19..2d677e90a7e2 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
@@ -33,6 +33,8 @@ Required properties:
 	- #address-cells: specifies the number of cells needed to encode an
 		address. The value must be 0.
 
+Optional properties:
+- dma-coherent: present if DMA operations are coherent
 
 Example:
 ++++++++
-- 
2.17.1


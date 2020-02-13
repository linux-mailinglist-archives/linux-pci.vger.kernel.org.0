Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0C3C15B833
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 05:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgBMEKW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 23:10:22 -0500
Received: from mail-eopbgr150041.outbound.protection.outlook.com ([40.107.15.41]:53076
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729440AbgBMEKV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 23:10:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBVWim0ERruTt1IHdthcwGefz3vJO31clXcKFXpvGktYmDG8puY3f6asxqa9NTYOMdlbq7j39R8pqVFFLxo4rtu9YZbRCe2TYVnlArNBrLZpfYn4sY95MSQxoet0rAlrLUVL3+uznkXXMqFAP3A/tOQS6DN3jGxdx+BYEgg9F06tcXtGdidaPJ8Nps3s1YhkCivigGcQ23jQklxx1EioaAYeg0+odJuTLgxPuSyKufkqh+1SppfLrWb9huW+gvxMeAgnStdm6nb9AxEJO3Oni+V5B4l+I1byJ/rTMjB6Ma0y4DPa6F+Zr/108wf2kCCTpJ6sKoTLmwLRmz6RmkWmnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HBKnD0XYZKzk7ezC2fT2JojLNDrzBwdkzJf98xSmo8=;
 b=n8Q931c0qUMkscmeCu7I8NXPUqXaCN1jueSrq7EwPjCPFaKtnyW3LtI8rBj8xfY2EVGdgAuznM9VhEOOYSurNB5uvapcjYoJLMFWvuMnPLfvXZcG9dX9Ga1atf93PjRp9zW2ve+nh2PoSJdQ3PGTjAdnszNwwTtOfiB2sLKt00TAdc/xXGL549WUK29e6GROGnF/pI077KCH6rpLe4vlRvCwYAqmFWJfuZAgt812OS31l3jabA0QyXlywe5EMMpMtg519biXgKC6mXXmsoe5TTJoHEZugeSLnU/vSJuhZe4kE+KhM1QO4W3LOqg7EjUQW35HRAI4vi0cSxf2gpPBzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HBKnD0XYZKzk7ezC2fT2JojLNDrzBwdkzJf98xSmo8=;
 b=stFxB5NijvFRQWipM1k94Dx+0N+yWGRTiCoA40U57ftFQP5ePksigmRCrPohkN7VCgmapgGgVLFVX8csCakhT5/eA7r0Au2R3z00mjQI9FpjUOU5YkVQ9PT7zfW/a8lrbxDyoLpUGjUuo1tgBOWLgnOzHvERN6IjrwXkBWoTKt4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7084.eurprd04.prod.outlook.com (52.135.63.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 04:10:18 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 04:10:18 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv10 06/13] PCI: mobiveil: Add callback function for link up check
Date:   Thu, 13 Feb 2020 12:06:37 +0800
Message-Id: <20200213040644.45858-7-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.73) by HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Thu, 13 Feb 2020 04:10:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1793579-74c2-447f-7918-08d7b03aa2dd
X-MS-TrafficTypeDiagnostic: DB8PR04MB7084:|DB8PR04MB7084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7084AE525B3B8A9893278AAF841A0@DB8PR04MB7084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(36756003)(6506007)(5660300002)(26005)(66476007)(7416002)(66556008)(66946007)(6512007)(4326008)(52116002)(6666004)(16526019)(86362001)(478600001)(1076003)(2616005)(956004)(6486002)(69590400006)(81156014)(8676002)(81166006)(8936002)(186003)(2906002)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7084;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /OOCjhBd7++CTM1PwdyfVsdyqa6jFLOvbaQdr47hcpYTNS1jf0KAeeI7F20GMBPbOcxXJUf3OHIk7BR1kVLPDokKA7PH4CyqVIP/0b04Q6eNBmtD4Drp5PoQ9As9RqNAmAfqaXeAXgQp7HOd5P2ckFtPnWqFxwamzlip5CDuD/BexELugiohdx7kHNQS/uiIrEa5R2dwp0J+VZFuQcuPydJWmct7eHNGfwjcxwM/9HY37FcA1fzkV/rQ8NitgYpIvQh93rdrRj4DAvlG+fN/6hWm2lAPPvlxOI7LKs6xeudUNw28XgruWd1y9QgQl7m20rWx8fNUqYzANuuefGxpD1BPBXHCAodCegVm2a3sYSHdxx8U2jZTRjB1oGPax3tEpPsfBBHaXcR/aFJto6N1uU9AERTmFi8KwLtgZAg0HlKd3SFMq/6nWGWKaqmzUBDPkZHv0jIMh8ZB/3mlhGkUbd2TQgNWwiTQUZ/hTiA2zpDd8yTyB27WDeH7ciFVOf2qvFEDlYbV8XmbHeTHhvLqquYEFKIUXK1Sm0PePYr7h2eEz14HIheuACQ54d0cyA3KVindyFc1Cr0Zky+kyetqTQ==
X-MS-Exchange-AntiSpam-MessageData: ay2q2twe+wSOcTzhEevd87UR78ToDduVJZ+H+GUN27NLcPnHFZMzvVBPzp8SwFPu9/wKnPTDH8GhNMYGrQO8v6yWFEIZCET98k1dIe/3LJ6pf+BxF1rPiq/AhD5QAQO3GQrbdbcpn3wbgixxkr0LOg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1793579-74c2-447f-7918-08d7b03aa2dd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 04:10:18.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XD2ayD5tXLjxcyV9trezWGkmEf/Slx3jGMH9PlmZPkcAplxyRkvx08WJvgXvxCwHUxEqX0cWTrxakbuep7URSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7084
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The platforms, in which the Mobiveil GPEX is integrated,
may have their specific mechanism to check link up status.
This patch is to enable these platforms to implement theirs.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
V10:
 - No change

 drivers/pci/controller/mobiveil/pcie-mobiveil.c | 3 +++
 drivers/pci/controller/mobiveil/pcie-mobiveil.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
index 2773f823c9ea..b9ed2d95641c 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -125,6 +125,9 @@ void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off,
 
 bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
 {
+	if (pcie->ops->link_up)
+		return pcie->ops->link_up(pcie);
+
 	return (mobiveil_csr_readl(pcie, LTSSM_STATUS) &
 		LTSSM_STATUS_L0_MASK) == LTSSM_STATUS_L0;
 }
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index 0e6b5468c026..346bf79a581b 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -148,6 +148,10 @@ struct mobiveil_root_port {
 	struct pci_host_bridge *bridge;
 };
 
+struct mobiveil_pab_ops {
+	int (*link_up)(struct mobiveil_pcie *pcie);
+};
+
 struct mobiveil_pcie {
 	struct platform_device *pdev;
 	void __iomem *csr_axi_slave_base;	/* root port config base */
@@ -157,6 +161,7 @@ struct mobiveil_pcie {
 	int ppio_wins;
 	int ob_wins_configured;		/* configured outbound windows */
 	int ib_wins_configured;		/* configured inbound windows */
+	const struct mobiveil_pab_ops *ops;
 	struct mobiveil_root_port rp;
 };
 
-- 
2.17.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF8415B838
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 05:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgBMEKn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 23:10:43 -0500
Received: from mail-eopbgr150052.outbound.protection.outlook.com ([40.107.15.52]:3891
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729440AbgBMEKn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 23:10:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGJBcHn8a/UNjClXgU63s12NsmBAyVQcsEdx+uwM9caDuzi7TRI7AYglw5o9oPw0H98KnLtwawYIYKr1PtxiB2tiIl68gKB8U1oYwtQLRlYyk4mB1n+FTQuWGbSqgzSCwZJFWjmrNLCtgtx+9kP00o67uAjW6SMplMTzYGm9Ycx/z6fV6Nx8W0OycMZeGy/bMT6EP8z8adJR+KlrtbpGoqHTi6r7zlNqSjUCW6sYfi+UlsqYPcSbpq6HtA53Eyad9+EudYKFNisVFZqEAkrOFekHdkP8quKSMVUn4DfnSiqIl3LdNDbeAO04DVvBE1Ek/KYr1fz0MsUU2UM+hu5h2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6fZFNV5LPZPD1GnnXvOvEftm5p9jFYYgEFw+TTkWKg=;
 b=n38UdBaPZwfs1Bkh93r+2/Dl6/YaefMQdlFBS5HVyg0ZRz2pvXHhrKrwlq3SKmA0NpJz1oCbXo1U3rNDxh78lj9pkCJtzKOyrbFTLGSW0PzlYHIMkg/7KarUV5pz+YF05AoU2knoP4wGMzHdYlUfLQg2Hw8qYDrSc//z64750XHX4OH8pXLzaBi5ZT/ntAxrx/uZgDcr5BzE8WI9wMUQ3nqfJcpjuWhWUD1+CJ+zNB+pRhvLeXvh3UtwTZLsV49XZMs8t7zOLBdf/dTE61yVYU/bAljkc/HWd+oNh5z780PHwVvnoZQTbDajjmzopkIg3OKXCcSAegvD7XNSjoMzQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6fZFNV5LPZPD1GnnXvOvEftm5p9jFYYgEFw+TTkWKg=;
 b=G2BcHIWAYeYVZ8eg8mROf0WEoplz4lGgWJjJDek4cnljbNH3O6ZOY3wz4JJBinJx3JEKBcFwNSoAzsUJie5lQ0TKQR4ONb9mNJtKg55oUBuq3lthyvOPJsadkHQvDekQMZqBK2rS4xRHSljIcvxKWsOCBicXKz1FwCpnUvObsyA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7084.eurprd04.prod.outlook.com (52.135.63.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 04:10:37 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 04:10:37 +0000
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
Subject: [PATCHv10 09/13] PCI: mobiveil: Add Header Type field check
Date:   Thu, 13 Feb 2020 12:06:40 +0800
Message-Id: <20200213040644.45858-10-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.73) by HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Thu, 13 Feb 2020 04:10:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2edaf9d7-1977-4c6a-5860-08d7b03aae31
X-MS-TrafficTypeDiagnostic: DB8PR04MB7084:|DB8PR04MB7084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB70849708B37108FF6FB3EA51841A0@DB8PR04MB7084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(36756003)(6506007)(5660300002)(26005)(66476007)(7416002)(66556008)(66946007)(6512007)(4326008)(52116002)(6666004)(16526019)(86362001)(478600001)(1076003)(2616005)(956004)(6486002)(69590400006)(81156014)(8676002)(81166006)(8936002)(186003)(2906002)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7084;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6eveqEXt9qYu0QQVxphrflg58f/GfCVDGYQjPuuV2tD5Ew3pQ/Ot7Mj876cT1pzlNpBlZHPDl3xZdVQq9Ght6N+NB4sLWLkmsKkihdApw1cVztd/qUPTvcaNj/WDt2gm06ZWhwRkAOjns9zZnLtexJp5dktr3SlGs0WixlL2xfsQp+03o6g6g1V3CnlRE7B2Lrh1NwZaXBkScgp0ACRMU9wQSNVd56EcKITpH2mfmExUMECDEK/GA4XQTBmE5+KF3QnkdBHdsUUGm0wKOMpLOx2MYHGmxB3KPW1zZYPEhzBqPFiN65b6Jv2EXey7zzF2BaQFyWIWuvXDAc21u7/5FgSZsFoDCvYI/eX/YRwxoFqUs++JmG/LxAtENAQvjboLYiTd8TX16uTsPEZu1iBUl/qFqLNInfc49u9fVuioBu7o7xEOG2LKL55dPsTKrPr4ti8EupRvFwDNPjkQbzP1M51VtUOGJYbaLprRkJY7OJuVaymQtlL9rYCkKtKIYz/IB5+6w2XcPS7yZUpU3swy0o5n6JoyIIsb5B41GTpp9WZVDuCmWm5wyTCYlViL85kXVK6NJMow/wKGJjLrnoo6kQ==
X-MS-Exchange-AntiSpam-MessageData: lIhaoNWi5vLA4E6ds4wdo1MQPfcghhrI3PYcRJ7ifIDoWkIZKsznca4Wn5qYPTuGCHrwW1JE2Oikq3YegfK4i7YlBpmV3oR1sR+SvaehJJ91nqxVgDHxwIU/ZFKsa5JBi335CQKvG1WR9MxaP61VOA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edaf9d7-1977-4c6a-5860-08d7b03aae31
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 04:10:37.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IFCvyoj6LZwuqOgolRlQzMDU7VgQ+okzNZfxVo1oApUNMr/8dO+59QW3gbaRmYI6yM94X3RIK3RMggXLSztAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7084
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Check the Header Type and exit from the host driver initialization if
it is not in host mode.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V10:
 - New patch separated from #10 of v9.

 .../pci/controller/mobiveil/pcie-mobiveil-host.c    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 44dd641fede3..db7028788d91 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -554,6 +554,16 @@ static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
 	return mobiveil_pcie_integrated_interrupt_init(pcie);
 }
 
+static bool mobiveil_pcie_is_bridge(struct mobiveil_pcie *pcie)
+{
+	u32 header_type;
+
+	header_type = mobiveil_csr_readb(pcie, PCI_HEADER_TYPE);
+	header_type &= 0x7f;
+
+	return header_type == PCI_HEADER_TYPE_BRIDGE;
+}
+
 int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 {
 	struct mobiveil_root_port *rp = &pcie->rp;
@@ -569,6 +579,9 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 		return ret;
 	}
 
+	if (!mobiveil_pcie_is_bridge(pcie))
+		return -ENODEV;
+
 	/* parse the host bridge base addresses from the device tree file */
 	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
 					      &bridge->dma_ranges, NULL);
-- 
2.17.1


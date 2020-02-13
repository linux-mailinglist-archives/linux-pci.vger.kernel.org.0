Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 218CB15B836
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 05:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgBMEKj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 23:10:39 -0500
Received: from mail-eopbgr150052.outbound.protection.outlook.com ([40.107.15.52]:3891
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729440AbgBMEKj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 23:10:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvYEM4a+5txHe59yV4AMGqjXp4o7aFaG2VAN4Gwh0U7WmD3Cih8BkfwxBZm+JQjtCevYNqG3NtmKuWmzF6zno2x9F1yZzfoLky+QuPwXZXVpYASafp31GGLTuj3vHOuXbLb47YPwQnx4+/5xoOI4VhDZi90dsvXyUP87HBamAfKJw0exOEdqK92Ur8Rw60UNvyo7EroMOBA/5N0Utagqdr67EUtp+vDRvfNAWzvVL6mGjItQwdJ+OsnvGWJ2g69v0JDCi2QfJSwaFma46xtwnP1ffuDmywBYWPzQz4Qeq7p1kWhvH4DbEzOGBKOYjd0TvRDTTJcn0qsxvlx+BQciDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JMir1P226kcojabsBH0nfNQxL1nlhjvqqFPWRBkEXU=;
 b=Wilw/KZrO4c7GvLA3JPihzvxQgOQ7/4SHb8+TgJ1/zpqhecaI8e/2FwuisUaJPW2j3KqRpUxqU4wb4uCKFCaCTB7+/te0rOBXrEW1lnRpnXuwGRGCIMG0nPeP3lhfcUQd/C6F3iH9uIf+ghm1SsYgeKeDXo+JCCkzAnftH0s0EuJEhzvnUjHbpuYjTOOEhtqOWr6S+z2NwyAeD7lQTyIjvByRBKHcTKvwUD94BQp904onIljPs3uOYAESAmqzgsPvixcPlElHJE1ssaE9++hlo44e0Sf0P8rpVBjoqIqHtlXFed52SgNdvEH4NBa5Nh2AM+bcieOMh45KvFLPi7I4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JMir1P226kcojabsBH0nfNQxL1nlhjvqqFPWRBkEXU=;
 b=VRMLRujq8GWIKHAj0AC9OpCU0Ck2kJ7fmwRnqUV/mP8p5pgSC0dLvpuBc5g4xw+xvRbkpSRQ61Viu9JrsilZmNhUEuP4LnPv5XdzcmnFJWuTvraCi/Q15qSngkGFgLtPbGItiZwW6vMfhd1xJxufvSzhUNVJe7rYmAb4qULbo5g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7084.eurprd04.prod.outlook.com (52.135.63.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 04:10:25 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 04:10:25 +0000
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
Subject: [PATCHv10 07/13] PCI: mobiveil: Allow mobiveil_host_init() to be used to re-init host
Date:   Thu, 13 Feb 2020 12:06:38 +0800
Message-Id: <20200213040644.45858-8-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.73) by HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Thu, 13 Feb 2020 04:10:19 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b94ebc0-3ab5-4e56-3f4a-08d7b03aa6b0
X-MS-TrafficTypeDiagnostic: DB8PR04MB7084:|DB8PR04MB7084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB708409074A5B8C3C35A297D7841A0@DB8PR04MB7084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(36756003)(6506007)(5660300002)(26005)(66476007)(7416002)(66556008)(66946007)(6512007)(4326008)(52116002)(6666004)(16526019)(86362001)(478600001)(1076003)(2616005)(956004)(6486002)(69590400006)(81156014)(8676002)(81166006)(8936002)(186003)(2906002)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7084;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WV6224jvt9QicXBCUwTwEdJzAGJgSPXx4THsilJ+0D/9/YSsp8XmQC7FTfOsUIiLxZh/LEo+OaVoSmrxlGm7eWHxR1jx2OeK+N+sajdhOH1zeNTEPPc8TPoh7T6rqsmyNUmyt1yIW4weK962ZOZ9qrIXfsm/t2FSID1Qg4aLy9OQG+xNTm95j85UzqWbxu4K6usGdk6qKQOQOt+kpA46lvby5dxPVA6FggVRfZr/UXrZBcssp6NtvNuF8XqaDZoILClltdQZgF5KqSuppj9Oe8/4QWoZqKc4ke+5sfell2eKZgEIeTdh0+QTtIyn92v7Re4VoeT0EyzJQIMb61MiKLClzhI39MdjgNUkGIUirMXyJUQyDWoULciBl9NCodwu4qZ9NDJd1j00QcaGnYVGbRA3MzsL/T43V3fLYpwjgMq3O0n8iu/qTbMsQiAEvBhgsUhHe8CCe+m6gJR5y8zZZTMI8FbpT4IfucIpynOyHdWjelKtXo8w7AIPjabKJpZ6LlbVC+Mbwi1h5siwhDHmM38zt4I43hGRwAuGXlzo7TCGt7W6AZPGIonjZwgawEuSjQrrHbxcNF0t2YMDbtj3bQ==
X-MS-Exchange-AntiSpam-MessageData: EgV8tJKKLiqwm6OdK5kg5V8NGD46GzY39v0DbZowbpUXiocQGnf3KUhb9FWTwn7Vbcr3coqXGh/UUJayeu4UNkxxmP9c1oEWvc0AzwUukQXR3F0Uujq9FytzC5BKsh0JqWeT5J1+sitsTMJ78hwjRQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b94ebc0-3ab5-4e56-3f4a-08d7b03aa6b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 04:10:25.0293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Dmc2Pym73RNxRgPETzVgK7YPSn5LeIS69/7kdlFhazAZGMmdtgI18EbNz+3JrhAf4NQ2SRH3dq6FbQVIcmfKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7084
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Allow the mobiveil_host_init() function to be used to re-init
host controller's PAB and GPEX CSR register block, as NXP
integrated Mobiveil IP has to reset and then re-init the PAB
and GPEX CSR registers upon hot-reset.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V10:
 - Refined the subject and change log.

 .../controller/mobiveil/pcie-mobiveil-host.c  | 19 ++++++++++++-------
 .../pci/controller/mobiveil/pcie-mobiveil.h   |  1 +
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 53ab8412a1de..44dd641fede3 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -221,18 +221,23 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
 	writel_relaxed(1, pcie->apb_csr_base + MSI_ENABLE_OFFSET);
 }
 
-static int mobiveil_host_init(struct mobiveil_pcie *pcie)
+int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit)
 {
 	struct mobiveil_root_port *rp = &pcie->rp;
 	struct pci_host_bridge *bridge = rp->bridge;
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
 
-	/* setup bus numbers */
-	value = mobiveil_csr_readl(pcie, PCI_PRIMARY_BUS);
-	value &= 0xff000000;
-	value |= 0x00ff0100;
-	mobiveil_csr_writel(pcie, value, PCI_PRIMARY_BUS);
+	pcie->ib_wins_configured = 0;
+	pcie->ob_wins_configured = 0;
+
+	if (!reinit) {
+		/* setup bus numbers */
+		value = mobiveil_csr_readl(pcie, PCI_PRIMARY_BUS);
+		value &= 0xff000000;
+		value |= 0x00ff0100;
+		mobiveil_csr_writel(pcie, value, PCI_PRIMARY_BUS);
+	}
 
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
@@ -576,7 +581,7 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 	 * configure all inbound and outbound windows and prepare the RC for
 	 * config access
 	 */
-	ret = mobiveil_host_init(pcie);
+	ret = mobiveil_host_init(pcie, false);
 	if (ret) {
 		dev_err(dev, "Failed to initialize host\n");
 		return ret;
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index 346bf79a581b..623c5f0c4441 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -166,6 +166,7 @@ struct mobiveil_pcie {
 };
 
 int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie);
+int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit);
 bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie);
 int mobiveil_bringup_link(struct mobiveil_pcie *pcie);
 void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
-- 
2.17.1


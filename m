Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846983DD637
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 14:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbhHBM7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 08:59:09 -0400
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:37728
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233862AbhHBM7I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 08:59:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+cE+MxViPek7fN/nZOuTQ8uPeY3GuMN+HPL7SXzp9cR6Itce6w5Cn4XhvEQVArUJMidEn25mMmQYIvSsjquF8kOPDhZM+AxZMeFdQjStlYv7Woc1TGdI5mPPfzwUOY4xtGgVqpJVqnLJwtgbqkYKmeMFhyf9um6Obs6tbZhsZ8ytyX3laetsqhgCFr2EnLfHwYmhgmiQehXPxwgs7tzxzaKK4NheP4VpzVP8+LjqkMJtgxQ1FCv64QFnI02ZqY/sPAACKOCzgWrawSQcO/p9/D2bKrevQr1EPa0Js3hiwgUsQh9Jg7X3FJmskqi9Snkis7sJoYvUbYMAT7v58ZLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elF+gUZZbDHy8dzKKKso/rwGO9GihzH8aEPEOh4MQng=;
 b=OICW8zhI170j3wP0Kcw2UfmXoEKiG5uU9Wsy0xaaEdozqhBhzRDgcTNVfK20DluHVtIcr+frnC6pB7mPqLWiOO0U+toe+r9FwYUvUKlBtyYZs6pAweO2d88ChkyLurTVITerVkogtEUbvRXrQIo/yi2eMW3lC//b6vmJ7Ewu2TJlOgvlsV7+zN6Z4JvKamzhGylh9kdEr+7ikPSxO1Mc70gA92EU7RuYdArEqkKG+dtb+jnHUTaZIITCZxcObyxO2XxnvPKIUBjq9U+KTNTQ6Djl28NNiuBW9+Ji0vtnq1udxnG0IXW1iknomRAypvhBThNkCWLNY3QIaxdsthgqZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elF+gUZZbDHy8dzKKKso/rwGO9GihzH8aEPEOh4MQng=;
 b=inXq9P5IC7UblvtVfRMXdNi9aGwKh6i/VFDWoXKS0sKzjetHvuB7p/HpUzTbQ+HLnnePILE5V+SkdNRuiP/H2j8UzfkKJOfPfXqIWLYbz1RIbiOHchFYcsMGZ4nAgXkG0VhO6l28vWaYz2FfytHQ29AEtylyIvebmpfICG609U4=
Received: from MW2PR16CA0006.namprd16.prod.outlook.com (2603:10b6:907::19) by
 BN8PR12MB3233.namprd12.prod.outlook.com (2603:10b6:408:9f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Mon, 2 Aug 2021 12:58:56 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::f6) by MW2PR16CA0006.outlook.office365.com
 (2603:10b6:907::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Mon, 2 Aug 2021 12:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 12:58:56 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 2 Aug
 2021 07:58:52 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <mika.westerberg@linux.intel.com>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <bhelgaas@google.com>,
        <YehezkelShB@gmail.com>
CC:     <Basavaraj.Natikar@amd.com>, <linux-usb@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH 4/4] thunderbolt: Fix port linking by checking all adapters
Date:   Mon, 2 Aug 2021 07:58:20 -0500
Message-ID: <1627909100-83338-5-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
References: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc6ff003-13ac-44cc-1abc-08d955b549bd
X-MS-TrafficTypeDiagnostic: BN8PR12MB3233:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3233927746DA855616ECB85DE5EF9@BN8PR12MB3233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDrHXj8qNfK+Y3c6YXDmUeaBKGGV1fR8jTaThc8f/ftUAucughJQdErsCpz/X6F+ensYnSXz3Rmujf3oqlzzQIUDsE5HxNJ6xxewUHS+YBjH0q97qqp1+O0XBgA3y+q/LPvWklSTRgaVKgbHKmYMgWtLIMhtpQbJP7hxmXzvNenkMZZBkeSt+jsIHWSCIRFaCo2lH4uQdf3EcIau6qAX/DmTu0uCNmTjYkD3wF1SfXnSLWDEfvWzYj6RoUMxYBBJbpbZmBm63SR5T1HCni85zR9mdG+O3izMnUGB08Fmauz5zTY+E+XFMXSw7k5UN4ndrJ3rxX+q1qxCJeuHwyKMx/6g2gSfESx93FpWTFGUQb4Ws8c7SJNn3JnXa+DveOACufEMje0MvjfhsD5LRrrjVBd4ccaXg3ZVeix2veP/nTXz/FzUAI/FlPU6oqWJ/SDX5Y6d8Rh5T8G/+/XLqHchomO+411JKcl6F4sF2/pN7KN3lt9T8VFucr4cFfvhESTxp22NKC+/nzcnHR7+bD7F17YHoFryGYxGtGuVtOlWiPFi7vj0/avGxSXYtswaCdYOgO4Fj7UXJ87aoBKl0I+i35hEoaoCDkZItJfzgseJVSIf3J2Aymo9FAq6IMFEEgUnMmcYOypQi632SdUQbRArK+D9J/xp7MxUdqtlVc5foQ3AVNkzNBznfsLkIYtSI2QQ5ZDgOTwEWy1aBPbJTh6CHvTcr4bvfyWw6XvfGIxMtGQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(47076005)(82740400003)(110136005)(7696005)(83380400001)(478600001)(2906002)(82310400003)(54906003)(5660300002)(70206006)(4326008)(70586007)(8676002)(8936002)(426003)(26005)(186003)(16526019)(356005)(336012)(36860700001)(36756003)(2616005)(66574015)(81166007)(316002)(86362001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 12:58:56.2568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6ff003-13ac-44cc-1abc-08d955b549bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3233
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

In tb_switch_default_link_ports(), while linking of ports,
only odd-numbered ports (1,3,5..) are considered and even-numbered
ports are not considered.

AMD host router has lane adapters at 2 & 3 and link ports at
adapter-2 is not considered due to which lane bonding gets disabled.

Hence added a fix such that all ports are considered during
linking of ports.

Fixes: 0d46c08d1ed4 ("thunderbolt: Add default linking between lane adapters if not provided by DROM")
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/thunderbolt/switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index effbfe4..8b2fe67 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2456,7 +2456,7 @@ static void tb_switch_default_link_ports(struct tb_switch *sw)
 {
 	int i;
 
-	for (i = 1; i <= sw->config.max_port_number; i += 2) {
+	for (i = 1; i <= sw->config.max_port_number; i++) {
 		struct tb_port *port = &sw->ports[i];
 		struct tb_port *subordinate;
 
-- 
2.7.4


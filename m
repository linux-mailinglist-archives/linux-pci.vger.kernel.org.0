Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8782776D864
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 22:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjHBUKo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 16:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjHBUKn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 16:10:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B071734;
        Wed,  2 Aug 2023 13:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SK3ijI13GQhoEcZbYepTcCT7/7GKoRYWE6Kl9kHC1ugefOLwezUksbCI6Jxw63ckjdZkJaIbJlpQmcO8ciRfW3Hl+9u6s3LxB/yE/nEZXUmDvsLwmJYp9QvrtVXEJRmVHl1itnUpkOlYc9DA3CKrGTyx+2opeT0SqwhYASk6ro9yHC/KaqAzpyxCfdAi5sWGWJDNsfhF/9XVwgO51Pm6Owy+YSayFc+SEurpTC7cC8sLZianAVuswKy7C1AcISVP/ilTXSHirLVz0ixkjVDBHg1ncR6/rKeKrbaRu6TLGzgAgmXKjOgbZ6nb9wioA4LEoqiu7qO1v0QIa1jY3jHH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3vLZQAndQUrsGXw591fgzQ/18EKgSFlfr/n0oMklM0=;
 b=hvgGmgQrn7GgjonnhXqrNcCy6KMa9FvshEf3BdQo84cz4KA1By4SP+Bfp4WHwmDHTs2Qyqx5PJE2tqTFDdLli0LkBA9Q67zEKr7H8FSNTmLfHEzMV+OX8jmGqNsZMNpRc6NM+oMdRa3Eq69HQF9htFt81CePGDG8sBvaSivCNOQMHhJGPguUtLRxdN0CngZuecGAlBUZ5ai6iBGNfYxt/mK505khmFawvKFQLqodgtTW6c7OfhUgGPFqt4GjSuPx3/uzyuHnQe+eOA1vKlGi77w0nnn4nPVjV+gFEJ9xveDfTFUlYktKVUsMXgSWolYNhUjMapwuVxyb6GBdfVuNqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3vLZQAndQUrsGXw591fgzQ/18EKgSFlfr/n0oMklM0=;
 b=CL5WTUFoMjI87mW0wzxEFiva2bWMh7AdYiDzgR9dpL8Xo+8baUZExY2sxCjjsh0vrOIN4mKKqEvwY9TuoC2/bAifBXdOmOm2gOL6waVogCUxegLhmONG6M8THV18lvz4gmZ8m4ODlJuiHFrwlucvbQ2ekZnjJm8ANUMbzFKdiLM=
Received: from MW4PR04CA0323.namprd04.prod.outlook.com (2603:10b6:303:82::28)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 20:10:39 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:82:cafe::5) by MW4PR04CA0323.outlook.office365.com
 (2603:10b6:303:82::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 20:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.5 via Frontend Transport; Wed, 2 Aug 2023 20:10:38 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 15:10:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Iain Lane <iain@orangesquash.org.uk>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v8 1/2] ACPI: Add comments to clarify some #ifdef statements
Date:   Wed, 2 Aug 2023 15:10:12 -0500
Message-ID: <20230802201013.910-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802201013.910-1-mario.limonciello@amd.com>
References: <20230802201013.910-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 772e70ed-344c-470f-cc25-08db93948a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1pT14d6aZ8s9M8p9V3IcO+5JXZuZr9xJJHesAcu6qhSs/joP3f1tz3zK2aW5GM637LvfRmrXE7z5rq6eQUKjC4NA/TGe/omwnQ0zurou64kjsjKDsylrlB3ftd6T9X5LD/iIPytRM51ywD9JrT9mSolGTue2kbBZ6JfoXY+3BwhNtTLoAvcBNGPPsi3rSG5riTCilToZtQq433OqSm3fQ03ZvGzYiQKc9Vd1FSZ+CF5Y9ou0u6w4MeHJRdCmdHThR7miF8eGHvr8uhLtL+sRrm4x1m8pKbjY5oelH76le8qp6B22z3bjlA136Qsn739g35Ei4LyUUBgMvXdkN33c8ihiGDerMViM0pIkzYF4/TxuOZCGSbli0UJ/iNR9VaimF8ThC4EbYQ6Etq1SfpfHEbSRNn28lkZ561Vspx+ow482eWDVs8PTyPDeQXGFCOMX6lO/oSDvT9f2oC1tZD+maA5oUdw+XRP29nt3RU7D6E7AKXzoi+Z8Y/ryqe3p/+hxYj/8jcuQA3srx+zBjipahC0J0FgFNRrHkUGofGw4v34usFjRvShx0Q6cNzyhEmUYIPtARgzGDaO2hrL3YBl2vempokA3V5XWIADGRrwcCyd+AwHPr2hqL5IOQZtemMiLsn4KOrtM97G5UO18mEnbswZzrS0UufsHapqwyN8KgjqzE4zbW7kSgRKk35bocE8sBnTJvr2revbHUmubvDHp3q5hlY5Q2GV1MLMBOku/Tkg90jvYA8WvyRezN+JXEWueCORIt4YZsggumlH0r3EuUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(8936002)(8676002)(4744005)(47076005)(5660300002)(316002)(41300700001)(44832011)(4326008)(70206006)(2906002)(70586007)(478600001)(40460700003)(1076003)(81166007)(26005)(2616005)(110136005)(54906003)(40480700001)(36860700001)(83380400001)(86362001)(7696005)(6666004)(356005)(82740400003)(336012)(186003)(36756003)(426003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 20:10:38.4694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 772e70ed-344c-470f-cc25-08db93948a56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With nested #ifdef statements it's sometimes difficult to tell
which code goes with which statement.  One comment was wrong,
so fix it and add another comment to clarify another.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 include/linux/acpi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 641dc48439873..0d5277b7c6323 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1117,10 +1117,10 @@ static inline void arch_reserve_mem_area(acpi_physical_address addr,
 					  size_t size)
 {
 }
-#endif /* CONFIG_X86 */
+#endif /* CONFIG_IA64 */
 #else
 #define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
-#endif
+#endif /* CONFIG_ACPI */
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
 int acpi_dev_suspend(struct device *dev, bool wakeup);
-- 
2.34.1


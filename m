Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC0DF42229
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 12:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfFLKSZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 06:18:25 -0400
Received: from mail-eopbgr710043.outbound.protection.outlook.com ([40.107.71.43]:51904
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727068AbfFLKSY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 06:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ww0h4Y4wwqCr7hq535Bf8l55yWkFHzZbMgT7dFq35A=;
 b=kuRRr2Bf3GV4MbEZnZyaq91emvWQmVrt0VmgTbG1zIBYYVqQ8D4RhfovqI/Lqte80a9NAuQLvYlsUWnXxaOzNKvlE10IsVdySKow7NH3SVcwIECIdNw9G7TvFp/SySGf2Xj7fG476DYBJqG/EzzstxSGHpPCz5SvKtaSPxha05U=
Received: from MWHPR0201CA0023.namprd02.prod.outlook.com
 (2603:10b6:301:74::36) by DM6PR02MB4938.namprd02.prod.outlook.com
 (2603:10b6:5:11::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.17; Wed, 12 Jun
 2019 10:18:20 +0000
Received: from CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by MWHPR0201CA0023.outlook.office365.com
 (2603:10b6:301:74::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.15 via Frontend
 Transport; Wed, 12 Jun 2019 10:18:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT062.mail.protection.outlook.com (10.152.75.60) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Wed, 12 Jun 2019 10:18:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1hb0Kg-0005W0-S5; Wed, 12 Jun 2019 03:18:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1hb0Kb-0005wx-Oj; Wed, 12 Jun 2019 03:18:13 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x5CAI94P020337;
        Wed, 12 Jun 2019 03:18:09 -0700
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1hb0KW-0005un-KI; Wed, 12 Jun 2019 03:18:09 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com
Cc:     marc.zyngier@arm.com, bhelgaas@google.com,
        linux-arm-kernel@lists.infradead.org, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v4] PCI: xilinx-nwl: Fix Multi MSI data programming
Date:   Wed, 12 Jun 2019 15:47:59 +0530
Message-Id: <1560334679-9206-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(199004)(189003)(106002)(48376002)(70206006)(50466002)(63266004)(9786002)(2906002)(26005)(50226002)(47776003)(478600001)(316002)(77096007)(126002)(36386004)(476003)(4326008)(2616005)(107886003)(14444005)(186003)(81166006)(8936002)(7696005)(356004)(486006)(81156014)(8676002)(6666004)(51416003)(16586007)(336012)(70586007)(5660300002)(36756003)(305945005)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4938;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34f1684d-7705-4e57-0e8d-08d6ef1f4abe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM6PR02MB4938;
X-MS-TrafficTypeDiagnostic: DM6PR02MB4938:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4938DCF10BA1118EC15D9769A5EC0@DM6PR02MB4938.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0066D63CE6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: W8rnwIyfJ+6DmiH11JqnQa8Gati5tROpk/cZoFkG3vyu8M37jg4ygANpf+Fk8v63aADq+HMfgVyM98K4pMuMOptMh6cPhhNb3k6VwIUqOV3LhCidCxue2m8f07ZK18yfh/lcOl3XqBTkzxE6Axvs5Anmqs39RUTB/NqEy1Ocn913v78z2f2tbTP74Hf2C3rp7zUAgah+FGqWUY41/cF50xJuCdgf/mjqeD+lp390liKAJSOI1IB5gfz13O9jaQC5s8BWYGdOebOOGnmv7zDzst5qba2xDwEQSJJaDAT4VG1uJHfmbhbmiK/OZFqap2/4Gm11m4tjGgGm56+M8IIv+jtsGPFfrQDJ5bBlQjBOC0cb1hvGxWdbZxH3PxI41WDYTekwWtZWOIWBiGgZPpwieKSEmx8MdxHUTiyXT7IYx0Y=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2019 10:18:19.3122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f1684d-7705-4e57-0e8d-08d6ef1f4abe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4938
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current Multi MSI data programming fails if multiple end points
requesting MSI and multi MSI are connected with switch, i.e the current
multi MSI data being given is not considering the number of vectors
being requested in case of multi MSI.
Ex: Two EP's connected via switch, EP1 requesting single MSI first,
EP2 requesting Multi MSI of count four. The current code gives
MSI data 0x0 to EP1 and 0x1 to EP2, but EP2 can modify lower two bits
due to which EP2 also sends interrupt with MSI data 0x0 which results
in always invoking virq of EP1 due to which EP2 MSI interrupt never
gets handled.

Fix Multi MSI data programming with required alignment by
using number of vectors being requested.

Fixes: ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe
Host Controller")

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
V4:
 - Using a different bitmap registration API whcih serves single and multi
   MSI requests.
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 81538d7..a9e07b8 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -483,15 +483,13 @@ static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	int i;
 
 	mutex_lock(&msi->lock);
-	bit = bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
-					 nr_irqs, 0);
-	if (bit >= INT_PCI_MSI_NR) {
+	bit = bitmap_find_free_region(msi->bitmap, INT_PCI_MSI_NR,
+				      get_count_order(nr_irqs));
+	if (bit < 0) {
 		mutex_unlock(&msi->lock);
 		return -ENOSPC;
 	}
 
-	bitmap_set(msi->bitmap, bit, nr_irqs);
-
 	for (i = 0; i < nr_irqs; i++) {
 		irq_domain_set_info(domain, virq + i, bit + i, &nwl_irq_chip,
 				domain->host_data, handle_simple_irq,
@@ -509,7 +507,8 @@ static void nwl_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 	struct nwl_msi *msi = &pcie->msi;
 
 	mutex_lock(&msi->lock);
-	bitmap_clear(msi->bitmap, data->hwirq, nr_irqs);
+	bitmap_release_region(msi->bitmap, data->hwirq,
+			      get_count_order(nr_irqs));
 	mutex_unlock(&msi->lock);
 }
 
-- 
2.7.4


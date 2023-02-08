Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1168F74A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 19:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBHSnw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 13:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBHSnv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 13:43:51 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2094.outbound.protection.outlook.com [40.107.237.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CC944B6;
        Wed,  8 Feb 2023 10:43:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiqXVm8GoUOxJK8yz6Cm3CrGmOfbmcHmc2bSH3PihfVF2HllkLSRrcMvnsqg3KTNjSXT86BmcJb0iWYi8bVWp/eYyG2+MHPrEGDk3tyL/69ufPIfGX9zKkHMRC2oyqiamn7r7SwLAX4tVdRzuibXrM/NhBwWplla0xKRAAJtNsBPpcRh2kd6kANDCCn90yJ4VqdF8McCQxhhGmwzlH74yiCf0eVC0S/wHdOd4ySLugKkGERzUrrdbDqhSST9uMKYHTIidMXg2oflKcH6wb+Eg0PLn3Jgoe/d5kvoIPuKufMJhTiQXj9Q5sQIKY6ceKd3PkXDboPlI48AmdebrhdLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PduJKKTXFIsfNhRg08c2oah3aHxiHm73GdqFmMecpjY=;
 b=EsupisavtW831g2i/PtjV7dY98k5JlWr9opwrdEsV0aZLJJmPh7ZXCBihKd8l1ttJQMQlByiVgzP2qBVza46g6trWVN6eVyFOKT8cXsVMzhniAzvKMjTIsNw5RboarYuziExFaIAs8M5t96oqujJjtx0E/pwk+bRQbJagx2h0MYgaCC2+TFikDBbhfS63dLzRjiqs3IfnLj+g/X7EtI8vM1YoD4jTWG+4Oh82GUAS7LNpy0DuOZa1iM7Qf+fxz0Lv/aq2cmyomiEEOX8gr1cFtD4BNUrs1mXqAbsRpxz5tVD28tTa5Agh2cthX35HIi72cFzDV17pnuN5qnJMexdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PduJKKTXFIsfNhRg08c2oah3aHxiHm73GdqFmMecpjY=;
 b=ptaOipxrZaMw9TXTiG7+7wEMWUw5cvCrszmpAVXQG9D6wdYVma6TOOhfZY5yvTZ1qLolLqCuU4vlfajrPQNLrmRIHcgRYA3jvLEWvOQ8ZtWxUV0nhl7f+Q2lRlZwFCxrsiDMz4Wn4LAQ2EkfGbHasSdUJY1otOg60nM13rlWUPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 BYAPR01MB5176.prod.exchangelabs.com (2603:10b6:a03:76::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Wed, 8 Feb 2023 18:43:41 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6b5b:1242:818c:e70d]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6b5b:1242:818c:e70d%3]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 18:43:40 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Cc:     jean-philippe@linaro.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [PATCH] PCI/ATS:  Allow to enable ATS on VFs even if it is not enabled on PF
Date:   Wed,  8 Feb 2023 10:43:21 -0800
Message-Id: <20230208184321.867666-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0036.namprd05.prod.outlook.com
 (2603:10b6:803:40::49) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|BYAPR01MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: ef94d597-c804-4cae-101d-08db0a0465a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+hTav5A1mx27QRXvAteRdZ/zFI5HQIG32Kn7VtbL9tWa7NXb+cH8fQ+BPNkJ2d8hYYiMz8no3CisrMhBZX+AT1pGywN8Z5MvnvJMWyU5OPFtLGu8Vxzu4p6Ws2MvFjJQrFcWoOxVXbO+K0bZqzcMdg0m/h4YrooGalBDEyVkZ24HhpRj4tXvN5dG5Pwwp70tDZkVAUvrliWZDW2vwnkY5BbCYQZhBXx94Ab1BOf0u12LIPJmHMlgk0z1cuWZPjh3c0fvGRvDjKy4lbCLZpCUw6r145nEk4NANJuR1Ujk6hGvc9At7HT1UQvMCjt0JHVL1gljwI7tOgRB8+UuGswioFsiSoVfb75h3DRaWiN6Gcu2D/rdDtkx1itg+9MvtBu3/imzH+ZbCEOIZzCEdFeeJye44IYwuasdbZQhsxXSJZBXYAysDFuBRJxPUusI5oW3yocnYE6tINiQq5GNkwsv7uwBEaOZgF9djxR35NwUYTS5BlDlaTJ4X9kmycSxrEAWUoF0+a+++XrF69Do2c/Od8TRoTdQ9uMXh9pWtPidHUQeCp8L5jrsDe1TWPEdBs42Usuw47ooUIk6rbGCyE65W/y4zK3EXAAMZSYtpgZCd5hQMywTKC+DgX0nyIo3XCtE0MerG173FJXH0gAMjc8Iu6/8SaIUQMKeChMCnndblybpS7DvnSU6gGpRYFQ6tmA1cQEK3LdM/bBWM6oloOqow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39850400004)(346002)(376002)(451199018)(8936002)(4326008)(38100700002)(478600001)(38350700002)(6486002)(6512007)(2616005)(186003)(26005)(52116002)(6666004)(107886003)(6506007)(1076003)(41300700001)(5660300002)(316002)(8676002)(86362001)(66946007)(66556008)(66476007)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D+5FJUp9Gva8CD3G0rJ/rtJBvd/Gvim6t2RZjMZtsrvO8uh95uiTumllv6Z3?=
 =?us-ascii?Q?CPxHhTWp7u1d4fleLvBqcPT/rCzAiaorEZ7cItc81f1IPEQd/xytb1TcTjGK?=
 =?us-ascii?Q?4sYCV2DWTU9rTj9Y/ddv3D/heWqoXuJU39QqwmL3fFpCTYNM1IPkoemzmWab?=
 =?us-ascii?Q?HtMyd2ADW4s7sMpGFWUThpHMwSxlq9SU8oKzifH7l1aJjrbl321wnawZVQsy?=
 =?us-ascii?Q?KCBRuEHq5tLdZCn52SWBirBhbeFgLd+pZRk+IyrSAyw8iOSJh6/f0dThKtGZ?=
 =?us-ascii?Q?BXK1azkdOe/bhOGZaO+PKXQX787qliqMEFOq4ntRdbbNKlQal8K2GWI0/qjZ?=
 =?us-ascii?Q?x0MzTi2hyhmkxJgLU/GHRb5gNohmqQMphqNK426Mwf5tQQAwT97otQnS+FMY?=
 =?us-ascii?Q?C78PzCMoeuDEhJzgLAdFOuZp004sxS3EjMjMNDMwhHxsKZit3MTrGfSHbHtp?=
 =?us-ascii?Q?lDQafwqWsNVfHsZvVGSlQr4i13OC79e4/9fqrgzk1+utD/2hiLzOf8x0tbhp?=
 =?us-ascii?Q?LsVvXGDrqGfbP9f+im1Nbq2wRY7ztxGHuunf9qWZd3g2UL/TNkJxnOjHBtq0?=
 =?us-ascii?Q?c8HXWr1/xfBtB/ziiXIdzhx4PPU0iBMWGOmvchtbWO+xJY+JWUsGFWsJZvDr?=
 =?us-ascii?Q?ZW00lCGIce4+EpM+kT7/wjJpt0FUQ48YbgPGqdUBR7+RRxXn14ACTxTL856a?=
 =?us-ascii?Q?qek2hpEBG4rGywlkD4JGdQ7hO2OIzkukoORluRhktUTyRJfv+oxJuBPk6hkr?=
 =?us-ascii?Q?s3caqyMsomAgrP78sH0jgjXOZCPfWvII74fKmgtB9eJoak2RHhJeidB6kcue?=
 =?us-ascii?Q?y0Tokc4WF+PmIc8omxu99PID6JEwj+edqFRtq1ZDLgQ1qH65Bj+lXbV+BGgR?=
 =?us-ascii?Q?8iRw4JVNU1JcnW9RGLGU339X7zFjSMBANCNAl5Q8NXpqbsWO3Qraf2Tdz6Vo?=
 =?us-ascii?Q?/7v+K5esU1bqsgJsjVXfmyY1fJaYiv1kOicuFhYNHOQnyZ9S17RAQLgkDJxq?=
 =?us-ascii?Q?rtyqJA6DDOY/iAZ28jKh3S8f8rCX2ip2UTTIlPYD+Xogp3+Pp8FEdYJmIJbB?=
 =?us-ascii?Q?7mXA1SeHs/rri75L3PeJKZHK4mMq23brDHQK5ypTTSv+Jkh9UJPy5dkhBI3b?=
 =?us-ascii?Q?28BBztYf79Ai9OXBZy1X2Pfa9RehLAOdF/tyyrVZlXUSISaASO6RuZ4e8SGn?=
 =?us-ascii?Q?9EjIadG2rvKJYjiB1WyyPoFvOj14H5bmllWdktysaVG459PFxsDk/jSQjEAW?=
 =?us-ascii?Q?qhDPeFZk5IILpATwGQIpqfvEsfJopU953OeFE4Mtucn+agl22em8DGCgOdKs?=
 =?us-ascii?Q?9/OzsLPlEyrS7xXTCvYlDNMsqQuK4zUdOo+XMOnjRNqSQCCxfQaR/K9FN13M?=
 =?us-ascii?Q?DtCjJtbz7Sm9efanIFNyRFQQz5sobyWZGG4H6rCVuctXDtsTMrQpsNLSX2kV?=
 =?us-ascii?Q?F5yTrpbR2v+6NR799MkFCQNnTCL6pABn+lW7PCIPR1TZehGT9R3i/ElhQ7oB?=
 =?us-ascii?Q?HEhLxr7ajLWS8EkL3MzCpcakn8qyboBI2KPsG05w52Dkk7/T9yffRQwgpUMA?=
 =?us-ascii?Q?BVq9tQOgMttQ80M5WsDqiMM4oYkpU7cmAWSsjriK3nUMxcEd3kAU5Wsw7ZDx?=
 =?us-ascii?Q?UhKBeL+sun3sFjUKHcGk1qk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef94d597-c804-4cae-101d-08db0a0465a2
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 18:43:40.7462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fznqysSwWkWUguFZ9vEb3wCu43X2us7bw/pTyTuAIcGvkYnNYN0ol5qzKtNXibBu7NPZbdvXo2oVfnqIhKB2q8LQL4yJRjTOP+EkO07KHNuHzFbeepVWC1QOdmzk3sU8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5176
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As per PCIe specification(section 10.5), If a VF implements an
ATS capability, its associated PF must implement an ATS capability.
The ATS Capabilities in VFs and their associated PFs are permitted to
be enabled independently.
Also, it states that the Smallest Translation Unit (STU) for VFs must be
hardwired to Zero and the associated PF's value applies to VFs STU.

The current code allows to enable ATS on VFs only if it is already
enabled on associated PF, which is not necessary as per the specification.

It is only required to have valid STU programmed on PF to enable
ATS on VFs. Adding code to write the first VFs STU to a PF's STU
when PFs ATS is not enabled.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 drivers/pci/ats.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index f9cc2e10b676..a97ec67201d1 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -67,13 +67,20 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	if (ps < PCI_ATS_MIN_STU)
 		return -EINVAL;
 
-	/*
-	 * Note that enabling ATS on a VF fails unless it's already enabled
-	 * with the same STU on the PF.
-	 */
 	ctrl = PCI_ATS_CTRL_ENABLE;
 	if (dev->is_virtfn) {
 		pdev = pci_physfn(dev);
+
+		if (!pdev->ats_enabled &&
+				(pdev->ats_stu < PCI_ATS_MIN_STU)) {
+			u16 ctrl2;
+
+			/* Associated PF's STU value applies to VFs. */
+			pdev->ats_stu = ps;
+			ctrl2 = PCI_ATS_CTRL_STU(pdev->ats_stu - PCI_ATS_MIN_STU);
+			pci_write_config_word(pdev, pdev->ats_cap + PCI_ATS_CTRL, ctrl2);
+		}
+
 		if (pdev->ats_stu != ps)
 			return -EINVAL;
 	} else {
-- 
2.39.1


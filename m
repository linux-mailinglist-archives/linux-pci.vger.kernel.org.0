Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CC77C9E87
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 07:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjJPFLm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 01:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjJPFLk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 01:11:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B89E5;
        Sun, 15 Oct 2023 22:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iO9QGUBO89CanFBCnsxViPZpyv6LtmI7GxJbE6S59pmmzhLhtsk86zMeTa1bRomKBnWKSW8GsG07kg3XaB6GY5WnJqwjca15EvMC9ks//PK0l1AQTUvomAyoZJot8i/ar9rCoTPhLBrHyuHXDEGfgEvjNRKNAGxtjR1MBswA6w7VtpCpyQ42/i37u93iDYR/+pkT+RXyHDK6OQMmJn1nVVp29b3SXlSBTs2WnVITV9td/2wU3arhOrAS+pQryyb78Qm82DeWH2r9McrY6b3aZ+pGFikPukSdfwY0JE52msRAFhIPTPK1TTnyBW3k1LQyjAqRsalARe8ylrDHp1Cfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3ilyPbCZMc9D4qzJENbNGKw8ecAZQwX+PvbXf06TO8=;
 b=M/l6nzZYw8RIwFSnkJYLGYiKXkaZpItq+xNG9Z+U3hgDMLXtmy/H1ssxXIU3p7jYn/0wdBpA1pXSjEExP7KsgiJOeIhaim3HJgeRRfUtcHwyaGQQF0gaEYdVc2tOJYmeDJmEdf0bePhdwBFFusRGx0yWT5bz1bFI089UdjcrzhY+Uvmsv5KieUktvLPeCOqQmBGMWs9b0UKrdi3ZRJzKm11h7oTiCfPsZiYOZoQITMsoAM5xPKamsp87Dz790s03LDF+GCSzfRAW4iiystKTmvNXScYNLtCE4pbXVmh8rno619FxzpBgMOmwDWFQYtt6Yr7MzoOfAOUBypOhNAFwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3ilyPbCZMc9D4qzJENbNGKw8ecAZQwX+PvbXf06TO8=;
 b=N+52h1W1BoLGHPalTtZDe5GVvmrwdQDQPcDMGEILihZsSBTwkI10yDGCoSa42x8e0dQEgZs5MdrffIjv2+b7cu6ir08sXhpC04aSlKlMHaaN4CfG8XzvTcKEU1l2KEp+qNCqlKZsmxMruLj6FWqzSyegPdGjV0lNfI7iaAzGs8I=
Received: from CH2PR17CA0006.namprd17.prod.outlook.com (2603:10b6:610:53::16)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 05:11:36 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::f8) by CH2PR17CA0006.outlook.office365.com
 (2603:10b6:610:53::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 05:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 05:11:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 00:11:34 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 00:11:31 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <colnor+dt@kernel.org>, <thippeswamy.havalige@amd.com>,
        <michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>
Subject: [PATCH v5 RESEND 1/4] PCI: xilinx-nwl: Remove unnecessary code which updates primary, secondary and sub-ordinate bus numbers
Date:   Mon, 16 Oct 2023 10:40:59 +0530
Message-ID: <20231016051102.1180432-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016051102.1180432-1-thippeswamy.havalige@amd.com>
References: <20231016051102.1180432-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4945ec-d718-4243-8c73-08dbce065ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLgmH3bpYoM9rVbA5ck/MTTOfKW2nJ2593KHZ0A5gcTwxL1FEmmvDyT2qk4Uwr85w7tQpuWWvRplyhfMBYPwwkauNIbVhkFdWWlhApMcSXMJCDTt7O60XbQ0/P8cFo9VmgcJOgvZ4yVCyFA1pbJu3IJOAUaDlmEPWh6jA3OjSxTb/63aUkCN6pZo7XXu8hmApbxN/biAhPNJJ7csqmk62IcAdJZR0BqlCLlYRbaet6AiOskKKolS20aP7K3A/QVSUs5HAQO3p8GhJ7qeZBVctlVjF0888ajivCF3jI5WtRcPbTaQ77Pzmo4KHLBvpYg8Bj8qeQGRLPQ7aQaodg7WL/SVFxwuX0qjivxWu/i3HxHbmTY1/4TQSJW1jqMYn6nLgD2zRYoXXx6Vzgsd/5Xl0XYhzrqX8T0AOfy+CLlGtLqYUAzzrGYVGi9XlKvkY+mPXEVoeRv0MMz+dNOW5qZahVHnwBobvVU/sV0GFUNT6o4NrUicH4etQWQjX/PsUOZkuDd7Uhzmz3ysFjHMyqiA2tx4O9CQaNd/f2kroUakTIZJkOkiXiRGf8d16iFJIYVh4EF8d9EdMeAzY1BcnUKtqsJvj9idgzNO4XrTA2yyGFKKxnoAUG3Z12DMy7mmTZyEoYfEW9VHx9M/6vk0EEnxpcLe9wgXBZiKaLwElFKY0o+Wq8fjaGDkySGUkd+9ogdzhJJiVX4+JXJrhylARrutxMNIE+ectH+MgQjWY8TT+RqbcepKxINJWttKmVrZwadz2urfoLYOJ/rZtRPsRWrm15/wJpoRcowBK9mprCkzXb8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(110136005)(2906002)(7416002)(41300700001)(81166007)(40480700001)(356005)(86362001)(15650500001)(478600001)(36756003)(54906003)(70206006)(70586007)(36860700001)(6666004)(316002)(8676002)(8936002)(40460700003)(44832011)(336012)(426003)(82740400003)(26005)(1076003)(2616005)(83380400001)(4326008)(47076005)(5660300002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:11:35.7764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4945ec-d718-4243-8c73-08dbce065ed4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The primary,secondary and sub-ordinate bus number registers are updated by
Linux PCI core, so remove code which updates respective fields of type 1
header.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
changes in v5:
- None
changes in v4:
- None
changes in v3:
- Remove unnecessary period at end of subject line.
- Updated commit message.
changes in v2:
- Code increasing ECAM Size value is added into a seperate patch.
- Modified commit messages.
changes in v1:
- Modified commit messages.
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 176686bdb15c..d8a3a08be1d5 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -166,7 +166,6 @@ struct nwl_pcie {
 	int irq_intx;
 	int irq_misc;
 	u32 ecam_value;
-	u8 last_busno;
 	struct nwl_msi msi;
 	struct irq_domain *legacy_irq_domain;
 	struct clk *clk;
@@ -625,7 +624,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	u32 breg_val, ecam_val, first_busno = 0;
+	u32 breg_val, ecam_val;
 	int err;
 
 	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
@@ -683,15 +682,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	nwl_bridge_writel(pcie, upper_32_bits(pcie->phys_ecam_base),
 			  E_ECAM_BASE_HI);
 
-	/* Get bus range */
-	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CONTROL);
-	pcie->last_busno = (ecam_val & E_ECAM_SIZE_LOC) >> E_ECAM_SIZE_SHIFT;
-	/* Write primary, secondary and subordinate bus numbers */
-	ecam_val = first_busno;
-	ecam_val |= (first_busno + 1) << 8;
-	ecam_val |= (pcie->last_busno << E_ECAM_SIZE_SHIFT);
-	writel(ecam_val, (pcie->ecam_base + PCI_PRIMARY_BUS));
-
 	if (nwl_pcie_link_up(pcie))
 		dev_info(dev, "Link is UP\n");
 	else
-- 
2.25.1


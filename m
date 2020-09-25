Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699AC2782F0
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 10:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgIYIjo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 04:39:44 -0400
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com ([40.107.92.42]:61984
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727063AbgIYIjl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 04:39:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyEszmAcRDBGTMziqo/djcp/gC7S5RTBeOEeqVPhW64NSOHTZWGDykOKfuga/bh5F6HUw1ZfZfsJIjAR6gU54TrnV93qbS4nZ8aqrnUcoqdVsDz1TY68kl7s/DQpdNjpM1Tjb1YOugZ407eUjAI1CwUiH4CxHDVlARnFBh3b0155dsxMwesSqwIlrnUQHd/wZiM6H7pWorn5Yol6L4p0R3smeezn94mpwb42dJVZALtqZs9OR/ezjR1R5txx2rDHJDIcf/ll2lWfY2SzENVdE3LhaGFRFm9/879dIaQ8n0pYwmm2mpyFSf2xF/69ivtXVEFRf7p3u7Z5KLQ4m1V/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LyujvwjubjZQCkGKok0Rhl5YMoy8V6vBC189Wwv8ys=;
 b=GV7IXuDZbWHsv1jCtO/icqg5SSMDkXT+ckchIceCFbuprZ1XZIeeGUleAK6jarTMTM58Gp6Us/p3meckVFLGmQ+w94BjC4hRIRmYVQbTwr5d+Ve1LuSfS1t7rvmgKaSBURScmQJkhnR6FLsa7l7aqOWl9MfOOIqVjfTpWhLB6nhixrhCUXbEM4xd/lG6fmZy6yiVNNx2ZSTzjjwMs5flJIP2AQnVPWJYF/mdmpNRHZHYtPls49/kb9gzb/RNHWt5RHXxgkcbqkbTVSofQrdb0pGhgvmv+91O+Hd/2p86Zyz5legrOmj1bvXfCY/F4crrCqL2BChuSYfgio2KHAEszw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LyujvwjubjZQCkGKok0Rhl5YMoy8V6vBC189Wwv8ys=;
 b=eqB/WJdI4EYiM7UZ2wLI8i9V9x+iPql25xRQ1ShXe+88TE7De2BXvaxSMGC3XjI1paJ1lqMGtiZOPWK8PfKlhxTfTMI58Y2KG0tXkr6jddKSL+liaLXqh+oflLuXxilQfglWmAWWR09XKtNIwyrJbvYdVQeFLKbvqC4NdfLyiJk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4697.namprd03.prod.outlook.com (2603:10b6:5:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Fri, 25 Sep
 2020 08:39:39 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3391.028; Fri, 25 Sep 2020
 08:39:39 +0000
Date:   Fri, 25 Sep 2020 16:37:49 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is
 disabled
Message-ID: <20200925163749.4a45b8fa@xhacker.debian>
In-Reply-To: <20200925163435.680b8e08@xhacker.debian>
References: <20200925163435.680b8e08@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::31) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR0101CA0019.apcprd01.prod.exchangelabs.com (2603:1096:404:92::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Fri, 25 Sep 2020 08:39:36 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 081aa458-0b19-47d6-1de4-08d8612e8a39
X-MS-TrafficTypeDiagnostic: DM6PR03MB4697:
X-Microsoft-Antispam-PRVS: <DM6PR03MB46973B3F72A4A2BC7B9EA8B1ED360@DM6PR03MB4697.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdBV/ULiVtbN3p9BWDIcRCjpJu+QWskIV69kMoC5CA1H49ZlaqJ0dk3Yp26pO36d5QoQdgZKRUKO4sFOMddHKWX8236xU0HIjtf0BQ5l46bgcX4/SmXzR6yQ4+08X5/90jQ7CCn95FxAlFjQIFxuCin7zePJ1d63Tm+G6q2ASkLXtRfpnri2LLjlwlHcvMk8OSujIJFD4+6OTeTgsmSijfk2YaVTFZco2SFQC9vmoCqK1Z8sgMbzCvG2hpGVsYEK4IvB4XZG2uCvYbYou2Ltvgmbp0o+8cTuOmcr5WnwkZrYpBhbE0XJj41JyqVXIZQZDVdF3laFpz830sQ3VX7V/kTvQT1jlVRc9n3R6Oc7Fnvxop+1d7QsV6cLgpJCRV/R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(396003)(366004)(376002)(6506007)(52116002)(6666004)(110136005)(4326008)(4744005)(478600001)(7696005)(83380400001)(26005)(66476007)(66946007)(8676002)(1076003)(956004)(316002)(9686003)(86362001)(8936002)(66556008)(5660300002)(16526019)(2906002)(186003)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: es5IZmBsZoOQGK6SKahlzpB01itTBRopctb0hbqOti/GmIdYkjYy21fKYuW7wAcWLixMh24cosj0US6cSJhXU7F2Wofdvv90tRBsKiovp/JUTCXPWZRn0rmKyiuaNtKcZMe/UklONLir8jo1yAQa0Yrkeh5ZOwF3vOq4IXPSIELbFhtN2vWuLYkgEyrYM0EHP2a1Xfq8dtEqNT98twbDtk3bIjKmkS5d4hhusVHcijjRIKkrHQNjUIIiACzJslrmgWMfWzrCuF04GYAX7rsLnlDIz3uoGbn09p06uUPNbJULxsl5uvpYNPqVm0EN8mB3RJftygFzQMkKql2Yyfq0yW7LcH1szOk/UUj7uOB3JW43bhjEz0ZUORsfYXGQGVYCx+oAi0vTU99PiQqudDWZ57QaLeUh5CYoUGfEvzHRBl5+Bz1ip+RjZHUXlOkNjIuLoCj8KgJ6bOlWBhnqqNLtk+NTJEQjGkew7pBQWkpX/oEDKV5av/+HRGafe6eYNaP+yzEvmHoTAbCF43QH+BTLe2fhvgDKlKTVhb8K6udCnm506eTCddmYWzLIhAg2FxayEukevJJDLqntX7dC8voR+HUtt9EZZDmGsi7dDy+/mQNb0QImBTPTIYRKMYPHusjD7+AN2nYhLkqYGYK2ah/EoQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081aa458-0b19-47d6-1de4-08d8612e8a39
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 08:39:39.1072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6FiBwE0KxLMcZ5UPZRROoGnRalAWUKwmaXYQ58Gf4Hb773lT3KACdO8W0IiAzGeTVdv/xEOgXkp2mZgu9GgNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4697
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If MSI is disabled, there's no need to program PCIE_MSI_INTR0_MASK
and PCIE_MSI_INTR0_ENABLE registers.

Fixes: 7c5925afbc58 ("PCI: dwc: Move MSI IRQs allocation to IRQ domainshierarchical API")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9dafecba347f..f08f4d97f321 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -632,7 +632,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	dw_pcie_setup(pci);
 
-	if (!pp->ops->msi_host_init) {
+	if (pci_msi_enabled() && !pp->ops->msi_host_init) {
 		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 
 		/* Initialize IRQ Status array */
-- 
2.28.0


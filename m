Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD7227DDA3
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 03:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgI3BQt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 21:16:49 -0400
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com ([40.107.243.63]:47712
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729540AbgI3BQs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 21:16:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNpsYZ3zVQHCV00WdeXAE3uoEJk+UbJZ6AwzP1/4MZevv44nhMeIdXrLiCZKGRkhwTQYslZWVlOWKMJTVANChJkUj5EZC05+M3FaIPqUjJ8KoEiV1f874jgdGnqUWY+VCspbbSCVtp9ev9Sw6HrScVjYpxMq+G/EzvokcF7PdPNrR6O0MnLSF2rGGlcgpAHgRGXg0JGx5xrdCvf7wVI4EgVhTLeS2S6XY5BtYBx35FDHkgf979J4xhK9+vWDJM03QlWJkbK4UCnaD6l11j4JqJozSS9RhO9CTtVIu4aTNOnZDqrVeK7F5vbWO9hJn4cxFG/MsAcnOiITLOwTx0whvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4Dr/myu4aYvLHvWM34Ci8ASe+TTHr7hwue49ZswzPU=;
 b=DzWTwRSRRGYXJfukakmGN9y6qvjX/jFtJOh7/DD9vMZo4TyCvWkht8Bh8DfwTqtzwrSNPmRPFMk8t87NQWVdz3j/FiWch3MAoeyQVKJLKHuY6TaLKl+fL8gGMFowVxluQzIsSkl6u+Vn8p+ogegfw9fKN0FyDlLehSjZz20RoFlaMbPl3QCL6GWiKisGBWSijKYIXF90GApLgat5hGrQeYpwVgNt5MOMg86rPby+XB6MmcVAbFAFL7ZI3EplqcrMckrl2pgT0F3uZHep8H+geGSZdFTcUgAlJl1ImFNOyDlpR1Ptvt1TVQiN2aMl0GLzDZEcPitlbmelCnevWdP+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4Dr/myu4aYvLHvWM34Ci8ASe+TTHr7hwue49ZswzPU=;
 b=oQGqniW7Qm7YX8bzUZ0y7k8OqFslVLS4tm4xgqz/5vUM8y6xOE24VJwk3JUbL3X8kTpBXqxuSTID5WtmRBLRQ8f4n02XWTkILXRPTcL5M/HWsQoR2xxvMOf1xvqvaFR1kCs+mvh2on/z37PMJb6jac+xHWHPzDlLu4nVZyMyBxI=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB5145.namprd03.prod.outlook.com (2603:10b6:5:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Wed, 30 Sep
 2020 01:16:47 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 01:16:46 +0000
Date:   Wed, 30 Sep 2020 09:12:30 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is
 disabled
Message-ID: <20200930091230.279c59d2@xhacker.debian>
In-Reply-To: <20200930091205.792d6c7c@xhacker.debian>
References: <20200930091205.792d6c7c@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18 via Frontend Transport; Wed, 30 Sep 2020 01:16:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dacbafe9-39b0-4816-a1f4-08d864de7fde
X-MS-TrafficTypeDiagnostic: DM6PR03MB5145:
X-Microsoft-Antispam-PRVS: <DM6PR03MB5145A47350B97AC11B98D1E7ED330@DM6PR03MB5145.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBo0rIvrfWLLzjdChMNrKu5PxKIvhYX80DNQCYvWFQByq9T3deBQo/ZdLU/OHQf9dbvfp+j29lhI+lHRvF4s0BjiI6cFCbpqHe6LL2Um3ZTGJNPBuVzvR1Yqn/qlFYj73/r2e9+8QItvhxkTmCQh+sHAz//E9ccJGW5hqm+QCrs/PsRVAvNe/W/8ZJDOEewTPqivPUFUblccrgy3DZZLOWizJ66oADV2m75NZztESqFjBqCeKSkgg0lWBfB6lMdDLo6D4CKfZ4TeKM9QAeRYqjvrKjfVIXM3rOwVxMkDswwwQwi0m/jSe89YnWvpQW72I+gVVx/QnnjfZ7+apBo12A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39840400004)(366004)(396003)(6506007)(956004)(55016002)(5660300002)(6666004)(8676002)(4326008)(8936002)(83380400001)(478600001)(110136005)(316002)(66946007)(66556008)(66476007)(86362001)(1076003)(7416002)(186003)(7696005)(4744005)(9686003)(2906002)(16526019)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mVkng9HK5YnA9bufwAV91B2NXyQ/61KaWHks7v+JgBe3BqGp243h9e6Q2kbtDdpjMlSyuciDBKkSjnH0ZKWxhNfhqcuMDQ5t3ZblBSE3NvpNPa4tcGxu4ENzzYyk1GpDCFxRjkH7rihugOlII+u5m+3Nn40HepB2dbm7iCMCAOu7zNu/AsiYe0LJbbLt5qrt7MY1sbHy0i30VB+v29XRjBjNU4vUQ/P7UYolIgKSO/gXRDK89RY13U6vQq08VfB5U75xCwr9Pcj7oT1+ZqRjAa4j0mUz6Vy6RSnXbyt/sQoMvT5tDd4JpHMMS9W84WtC0jxuWFTdvbL3Y74nz+sZ3jmXMn6i4LDvVlzdBL0sYK7cjPtJcQKpK5ZLXuUPLYhQWPomD0VLgQpYnOoAly8K0EMLJnsg3CBd+tEPkn/YLkRKmD/uHWZrtlbV38TZ36kWxlUdNdlQCQ25fqjpwiiGevnR0PqOOk/rnAoRkDXXKHaPThD+Vh7sMs3YI+uTmT36V49LbKyTxMZpTha2ktrbeuW/944qZSNq73uQ8sUIx6XfwKVwsnifViEjv/yTlxJluDgb1p64sIxW7aD0AlwjP2mCfsRgh0VsxVAJgjm+pH44DkNxy5iF/ZRn3twwhobd3vuX3F9Hrmjm77HRPPU8CQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dacbafe9-39b0-4816-a1f4-08d864de7fde
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 01:16:46.7717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnfrVLc2asxvbBXYpJd7bQuWgm8DDKzFW9WcYlsYdQ3/PgggwcmfxejfjBqIoKR25m5S3cgYCtjEldwtt8mPog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5145
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If MSI is disabled, there's no need to program PCIE_MSI_INTR0_MASK
and PCIE_MSI_INTR0_ENABLE registers.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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


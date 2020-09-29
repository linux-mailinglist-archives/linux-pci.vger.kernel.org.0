Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C6927C27B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 12:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgI2Kfp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 06:35:45 -0400
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:54625
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgI2Kfp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 06:35:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4Hi+0615D7mFqoXWVXWd52p7HcRnFU2AgPYn3RaHsMX0OhtnD2IFaUdgSdnF9i25zhgkcxOo9vnlmtl/oNHj1qwnKMmxcKhycMFDEGbuzfFdNKv9yc5DEDg5k6GLQYJxijbqaJXozS+MLDA5RcYlIeplItWRbSYs5giMgGLTicl90CsnhMvGBY92Xegr+uIwghcOtvpC0YJNps9IhCYon3BpSJ7eCFt4AT78DcQ+wziBJpcHCh+wbscKVkOY9dCqWDlVf8Zx80xRCU2acF0Py+l3nwq77efxPiUiDljmVevcVtakrXDPfGfTVp2I2bCCq0o+S9EjsrxvFZf4JJ8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4Dr/myu4aYvLHvWM34Ci8ASe+TTHr7hwue49ZswzPU=;
 b=cTaKz6FV0VByDcGRXjkJF4/updhwEbN8GWILftTbUQbDjxY5zUEBHVPvQ0XkVak0ggE5Rhvp0r7ilJC0dPK8xAay2KyBcKayowuRxXvtIS0T96TU8S79y8M7Lq6P/nr57dCooN4SlKTNwbeCdo/XY8I5tDbC43WQBmclcEhm8UJ4e1vN5vUlf2GmaMXL507DzOrhrKSOUtqTd/zSV4GoaeOTBdKcQKARbTbpqAw+TNHOP/a/O1X3cR+ow3GGe0ap9yYwQRjtcRs09ORAkMD5uV10foDJYaf8SYDhL4U07W/wjdeZZcIbzhYkrgPj7LWP+Ih/s09zI+1d4elaWbLFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4Dr/myu4aYvLHvWM34Ci8ASe+TTHr7hwue49ZswzPU=;
 b=otScLvx3mcluuhUoSFOzs0N8HGfekuvlQZ34vKo6o8fk5xi/6PLxhb8sfJFfH3A9jdEWkUkrmHQVHkHx9YSGfznM5B5T3PSeL++kp93DgK0jjlFeTc0Id1TyV/0CxrQGXirLZidNMmqyzqwqAlRd5NrMnzhflCgVnGsL9MrQ6yE=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB5292.namprd03.prod.outlook.com (2603:10b6:5:240::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 10:35:43 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 10:35:43 +0000
Date:   Tue, 29 Sep 2020 18:34:31 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is
 disabled
Message-ID: <20200929183431.0efda17c@xhacker.debian>
In-Reply-To: <20200929183403.060d1853@xhacker.debian>
References: <20200929183403.060d1853@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYBP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::13) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYBP286CA0025.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:10a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 10:35:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66449bdc-4263-4fd2-328d-08d864636aba
X-MS-TrafficTypeDiagnostic: DM6PR03MB5292:
X-Microsoft-Antispam-PRVS: <DM6PR03MB5292F93971393CD6158CB3E1ED320@DM6PR03MB5292.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mp4DVuxuITue4kiJqXsU3TvzxJFcJsJaVhFmEx8iwHzqbsSwrBLErR5lGNSB2/r72lzunkG2vGqcaBU/3YolFOld5TuirKXPXmHK9AYZtPwJOCELhT1EEqkXogaR1nOn7b1lxRZ8MFYGN8pYo9RkePx8oN8TaNBwKWO15KeSM0OBP3tSDZojWhwfkadEjUMHuYj4UuzwzdTNiEw0gHHyd2d1NpnYA2+eV/rLVB6cmrbyEjXJrrfhnwh8N2I2fo8G2wnxeAvloTGYuEWHaDCBrnNXabZB+updQqtQk4IHnLeyNbJj2OgvNQfy3eBdKv4856uqLK7f2wPHVueZMZO1eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(39860400002)(366004)(4326008)(6506007)(186003)(8936002)(16526019)(26005)(55016002)(9686003)(8676002)(7696005)(52116002)(86362001)(66946007)(66556008)(66476007)(478600001)(5660300002)(1076003)(4744005)(6666004)(956004)(110136005)(316002)(2906002)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: A7eff9x2FZvV2hNZ747ORp+g+J7bkT0tL/4fZvOj+H83ZA9gXKiBua6s478znB9i1VpNuF4hVF+28MxCAJxqA4S3QzITm0XdZLoJjTcKe8CmQmMeu82TBN7/pD+874h5nx/VIzAEtEcXD+ky3cMcvA/mNeMoGfdVwsfZh6YqtlqHW+AzycACL1ZdhFRclQ61YmBG/yQN/yZDpQbDTGbS5gdwiF149jmb082gSKEtuPYjXYoqJhLk4VgUPJZqim70aNfN2JtrtxifMcc+GSXRzFD2UEWiM1jIk9L1hC/e+r+tteES5OjdaAP5BYBsiIzd63y7v8YX9fVzcOYJ+pgBALc1H3Dmon+9PLOvN1yacfvnzZnpDIiA2SN9C5lAqbj1Cc1gNKkrG7Aji7BXUikAWTR0cIy4LhZNVYxHdBMcutxQdHReXONN0ZtYS/GTlj5RUgGt2uabqf/0TdAadhIs9Sr4Mz6Tzvtb3SdnwbANFIfqH6z2+5mO+t5Px4C9JtvZ7OwyavxRnmAURe54w29DmXLmhp8COOkPv09sETGXpuoM7AJ1azPLozd2+8ejv/dSyitduG+THv5jc8T9xEPmsXzPyA+l7UQOlenP7tEmUQlqBbF8WMaUVxeTyMWLd+hdK2yJK8+Z+UaW6HObI8iWhA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66449bdc-4263-4fd2-328d-08d864636aba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 10:35:43.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyXCbNL6bXQIn9cn8+HlXIqhCeMfsq1ZvqsfKlea2BYoj3DJc3H5FimIilPyYl3cF1juKmoPTX1yTrl5068Zlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5292
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


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1ED0283302
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 11:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgJEJQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 05:16:50 -0400
Received: from mail-eopbgr680081.outbound.protection.outlook.com ([40.107.68.81]:49939
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbgJEJQu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Oct 2020 05:16:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLe9DEwMcf5+bwqNTYeJJkGxl2Ntb8Fmn4oCIn/XOLeM8XN8PTDKDlYbuX3KFUB6K3zxesxmUqrrL/YxzAWR9pKtBuSIRPGGe2UyEukl6MqZKo7kexeenh59U454azPNC4NPk4W3eGLud2SYgiqOEFzly5vsIgNKPVMqn4+qDLU24jKBYTbNzFSjbXcjkN8BlejLnGL+UHogxsjOoEAuV1lSGGki8UiDjtVMxZvt2WTjJPrhmt1dhUdY5W1idATKTnCXsVAj6QCtzNN8oiSiRwA1xqHFMines+d5TMQNJsUnfaRQOpXa2mfIUXnmrdaEkWE+eA3Xawdc2LYAJD4hpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECZRctN+O108XAOkiGEksdZCMGTb5t6HY4e92TF/9fw=;
 b=MaVEewFX00md8B0Iw09q+6x4Up9GJYMV7agqwXkZ5f3Zbva4sQ9Ofec1GOOYt9lyTYKbOxENWmIoOH9oQOrdoVwM22EN1qcE4gUDDsN6gnrnXRLVGNkd1gFjbV4kn7Vpfrh2XP7phYaSXLSJxYWpAT8Rag9rskPBS0C4rC4Jse+aeuNt9DQId+x5yr+xTYFwbuzYGAifXxWeMtfeF0wqwv5ek/2r/grviG595uGa8t52MAVKlTXdeWdcBOfvXg/7bL00gi0OjKNgwVlX7qrGMVxSdophlRT0Xdl0vKy+FAi+mGsfRreRWDW8hpJg4D5jQAdZ5YIGcscchjYgnkrOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECZRctN+O108XAOkiGEksdZCMGTb5t6HY4e92TF/9fw=;
 b=HtoOZOVYiBjh+Cv6FRJnmKUiM+gwlHx1N+n04lTPHQuYV77pbmZL01z76RwTRMp+B48cU00BP5UuGj9xqY9rY9E73Kuk/fKvMN4YkWWoreR/V9BnT3SzSyrk0kLBTD4R1y3h6SWIrBKpwsWcraFyRPiVY6Xc6KA7z1r9Qdb3xNM=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DS7PR03MB5560.namprd03.prod.outlook.com (2603:10b6:5:2d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 09:16:47 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 09:16:47 +0000
Date:   Mon, 5 Oct 2020 17:03:43 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH dwc-next 3/3] PCI: dwc: imx6: Remove useless dw_pcie_ops
Message-ID: <20201005170343.49ced6ac@xhacker.debian>
In-Reply-To: <20201005165657.0fd31b10@xhacker.debian>
References: <20201005165657.0fd31b10@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0070.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::34) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0070.jpnprd01.prod.outlook.com (2603:1096:404:2b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Mon, 5 Oct 2020 09:16:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 240f642e-9721-4ffd-b548-08d8690f62e5
X-MS-TrafficTypeDiagnostic: DS7PR03MB5560:
X-Microsoft-Antispam-PRVS: <DS7PR03MB5560415844837F351391696CED0C0@DS7PR03MB5560.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MwF9SBQ4SPZ8YeDebxA26X0YTxRGMZtJY1808S5yu6jV6J/DQqJl3PXie909pY/j1FcjggCPvUDCz0b6frj/lOg56nngUdsbaNXcFWkRcsCMaCMVTL/EnHOtu3fxteQuNIS1Bq4+kDQQIljlaVymI6ApS0cpF4o4PxmTcAawxMUJsgMl3ernFxKReKuJSZ0fgwC2sW5N4qNLJHps9KZLuc+kCtJvdWy3w7q1xxtB0WounMbwgLa6u2HmaI8d5yYfZOrAMeaok/xvXDLjw5Pf6Hs93FHiaXUnPbH3zkpYIo0SRhYzWv8AB/8/iSBK02d/Drh65+Pze3eXGsxxW6Om/UCr/8dwE3THvoyukbHwVZNMGe3IYh6vnIrexHPalIU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(396003)(346002)(376002)(136003)(2906002)(8936002)(9686003)(16526019)(66946007)(66556008)(66476007)(186003)(26005)(8676002)(7416002)(55016002)(83380400001)(1076003)(5660300002)(478600001)(52116002)(7696005)(316002)(110136005)(6506007)(4326008)(956004)(86362001)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eqjjfcoqPiSq48ZEuFk1N2ZEKhGa5c3Zoue70FvbvH5wINNW8Vxff8ycHRYtAAVh+ZUH0KwE8zoEgbvUzumw7+q18vZ1QvzZM8b5kpXOvrmZufHp9G6sVsmyl/mL3uhwKrGXQLWsfM6sM47/HO+OrHnfUJ85KplC7byYTE7ZYeBvlN4vOLJ4Rb1cnfXLmq4Wwhoz1wBkFvhU3kc/refIRkZBMUSbjMEe/Fc80f1wMnsBEYAV3Hb1ekkxjOVlc5lAPi1ie19LpToqw02Gbuw9o7EZSCFLFeJVFj31N/BDhpIjbV5GGQHFSX4zaaeQ1ZMobMK8kG77QX31mpUHwTGschJ3CsM3yGlEV96vLG7y8t021G+gYpxfYEs7VfEIT9YQgfsTmO2vnQWSw2S+4rlHwVqXhxuw7geBTWubI+U0tB1a5kuBsZuQO0SQq7nUft6B4sIJN3tYHP4MyA/VS77ERl8zhPOorOylyruJPofOXuzf6Is46NEvk3L6d4a/bTl77Y+fL1qrdqPAEk4cuGdr0tjM/T15kTs+QOBolR8XCXyNy9JZAvfQyk5g+Wmi/sb2DErbwVu3hVBRKRvjLgGkf/zCrSTiSFfwWRUVQYw1OGaY89ZUq07Nsr78nH9PkHaPvPZxFeH8PragQNzuQLjyYw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240f642e-9721-4ffd-b548-08d8690f62e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 09:16:47.9441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wnj0iiSFbxgMHk3C9vaxuruH0p4qo9UgTCwpW8d2oj1InqZhkBWKnkErVJuDXuPXuMnYV/4YTNCfza/Tr+6MBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5560
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We have removed the dw_pcie_ops always exists assumption in dwc
core driver, we can remove the useless dw_pcie_ops now.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 337c74cbdfdb..72f8bc7d878c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -870,10 +870,6 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 	return 0;
 }
 
-static const struct dw_pcie_ops dw_pcie_ops = {
-	/* No special ops needed, but pcie-designware still expects this struct */
-};
-
 #ifdef CONFIG_PM_SLEEP
 static void imx6_pcie_ltssm_disable(struct device *dev)
 {
@@ -1013,7 +1009,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
 
 	imx6_pcie->pci = pci;
 	imx6_pcie->drvdata = of_device_get_match_data(dev);
-- 
2.28.0


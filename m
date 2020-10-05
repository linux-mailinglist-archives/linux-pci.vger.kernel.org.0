Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81DA283300
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 11:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgJEJQk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 05:16:40 -0400
Received: from mail-eopbgr680053.outbound.protection.outlook.com ([40.107.68.53]:57843
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbgJEJQj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Oct 2020 05:16:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ly6732tWUQ5zbeEJBo/VMoyqqoycYalCdIw4xLu+1d9kxFVyGc5/uL9aZq+jSGnh2+Z4DNL+qlQAXUcOza1m0cvMjgOMEWcQqAry5MzFEwEnc3w/0Pbi0FwPGaVOzKnxZGJ99jxOigHzqm2nO5/KUTg2gcJRbE9gG8UNtHSTITofgq8inzclHdQ6fAMd4rOnovVCD6eg5smr7ZWhZmAhzTT+TsV4AFSrLzql+9QSjZL7PKQwYXGDivcmrLKZG1WuzuCl8xPtyRLXf4xX5Ei0OralWvDt/bA8Ys+MjnBVTWH5SwfT45q1lfkBrlx8dVP4tjJGJTyYbWSHg94Xv0k4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGXBUboTiCCQic9XHlxf0IEpm2dc4XrxLTGozKlcyv8=;
 b=I4WGm83C6DqPwA6iUmQMH7/Hssmvb+SS/QLXaN8SST6VF40JcxRTzfNU+FeVAQp/8uws2aCToXiIPXTBPqFy4jCt2OJ3D1MQ0APZRtFTrRTFrGVYFDIPOZKsD76Rjeu9tL1hku1eT1sHI+9w/HHnuyiAkH5FLMx5QtglC4Pl4N7fsl723CQIqU+rixq3TB4SbHUePKFFaf+13XY0fWgrjQyqp+c/vOnnEBcFAP/sXxRI30RyD5IxtYdBKKKKrrcybw2wvprbmp0ZvX1BLhGU9owAOVlYxf4CwzuHPnnqbUfwVf1odDD39RfvJBLQMdMXTzfnpJVAL3io5pp47Hg2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGXBUboTiCCQic9XHlxf0IEpm2dc4XrxLTGozKlcyv8=;
 b=Pot7Mxu2LyBSpBtkfTAETdTm0uaivqsR2sP9ERqhcU3YeuBJ+HKPhwWyP7FWS2g+X7GvqA5zX2Z5/APNAnoYUs5oyb6E/eR4JLVq3y/AdcTsHE+6DxlHqnf16thCCSq4CtUzmHAA+my5ipYaiRt1sn9Cqt3mkqieuhc3jwyT220=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DS7PR03MB5560.namprd03.prod.outlook.com (2603:10b6:5:2d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 09:16:37 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 09:16:37 +0000
Date:   Mon, 5 Oct 2020 16:57:53 +0800
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
Subject: [PATCH dwc-next 2/3] PCI: dwc: al: Remove useless dw_pcie_ops
Message-ID: <20201005165753.2f98b3fd@xhacker.debian>
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
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0070.jpnprd01.prod.outlook.com (2603:1096:404:2b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Mon, 5 Oct 2020 09:16:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72568b87-76d9-4e50-9105-08d8690f5c50
X-MS-TrafficTypeDiagnostic: DS7PR03MB5560:
X-Microsoft-Antispam-PRVS: <DS7PR03MB55601F10840ACEAF997A9F02ED0C0@DS7PR03MB5560.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEGSRvdnM2vzJDvwaNd8J4zJhExmFRQISkZKvblGQshG6d/vdPeVJXrIwVz1mMwXwPdv76NPKsebeUAHcZ95r9+NGgYKLSXRAcT+9mXoXZFIN22+VR5IxNt6zqZp0OqcwpR4OTccrR5Lq3ejJMULI2ap+MaUiKqwsak3e3KUWcFzbo7ZsH+SvySmohjJcJTrbEflhqOEHczOqN4aSsWM2fLyCGnv1GA9bEee5MEKiCnhVKht7NeXxErMwAwvszR95ntUSkB1sKHZ5d5/vZYOn0NTsdlgsRGoEE+p3wEk27Nhf66P0pkNgvWt/rKoi8dzs5RhCFx1ykGwDjTnp7321woGzgFefDKykJkJ55rUQV8GQtpjfmu7Ei6u2s2b9CdT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(8936002)(9686003)(16526019)(66946007)(66556008)(66476007)(186003)(26005)(8676002)(7416002)(55016002)(83380400001)(4744005)(1076003)(5660300002)(6666004)(498600001)(52116002)(7696005)(110136005)(6506007)(4326008)(956004)(86362001)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: c4gnWpUI0Dais8w9DChT7uLMgcW/O2wsihBp09UzcX7uF5zrwqIBmmcIJG4VRRwaPNUi1U/U5wWQyJ8YjzuotTQqlfllc7UeMSiBh+RTajrC16Y2Odlyz9yfDAwtdGW7KrEr6LWtrBNQ+kxreFztffw6u+lR8QGOvklP3U8DhRlV1Dqw1szEj1jKf9OIjJ/zo6u7rdmyzqD+fCLOsY2yCOlovq1Zpcpb9/5ZeGrCSULYcmGuO+JgbIXGaophq8XMNIkQV6Vp9in/czRjCSAV6lWliGaciHk7KH/8zh7v6ACoS6lCdBderstIW3vixqcDwIhjlefnpj5YMhDUugCOi7AkRH70wC/OEnOhT+T5I/GbvkB36CKxdXC1pZ7Lj+F6uPE0n6/MQY89YWaeBJu+JbTrC4vmaZGewHboJROEP2Vh0wagZC96Wss32q60zsURi8FfdHRvydOGpbDWcZAWHLN870mP88DYadXHORaBQ6jjznNCwXR/bjjRU58UsX7DpqIL4XDigt4FKVxRrzoOARyTyYpu916fojI2i735LN0Xo7qfBEyikkYTU6A3F0sxw3MsvY16V4O7QznEDzxYIgEIemZZJ2gVIxECjnWlBg5I5le1cYOdVekI2BKbWiETDrOO6qrbw+lFa3NSdwCpnQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72568b87-76d9-4e50-9105-08d8690f5c50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 09:16:36.9563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qf1WKywWZqS36flVD9pEfiofQ7xSyWdZFfe1H37BebSgbAXUh5nUN4GcwkpqB2epiEEsb+rr27g7ev8zkZGCdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5560
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We have removed the dw_pcie_ops always exists assumption in dwc
core driver, we can remove the useless dw_pcie_ops now.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-al.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index f973fbca90cf..a1fe1b847ef1 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -339,9 +339,6 @@ static int al_add_pcie_port(struct pcie_port *pp,
 	return 0;
 }
 
-static const struct dw_pcie_ops dw_pcie_ops = {
-};
-
 static int al_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -360,7 +357,6 @@ static int al_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
 
 	al_pcie->pci = pci;
 	al_pcie->dev = dev;
-- 
2.28.0


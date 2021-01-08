Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D98D2EEF99
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 10:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbhAHJ2Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 04:28:16 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:61006
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728267AbhAHJ2O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 04:28:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwEVeVChonCnQiFNsyUwhdH2Qjf452Byr65jV6ZyDysBnntmSXC05FsVRUpzvAHJBcJ3wSepV4K5VFMBTaWHbYv0zDGdevu40ZEtY3XIgPyG7Cp1tNG/poJuRquGdT5krX6i1gflsMp4A4yr/mBG/GuFiauMqIhjsklIRDB47WEJDTu/gfbmtUyjdUo2Ion0S9nBdmFybNmxsjj7KexxiNx92QE7bgm8kMyLn1otudrIAMFWg8MSlHpcvZFPHOpmUBVVOdiA5MvJGOW/TjsH1HfV5MvmgsuQZq+Y9yuuR3UMKi+epQIADUleOkCm99oSXlhW5qUD/Ht+bDjwvyeBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEDIeGc2J338to9wJLaNFMxFFkKi0V8i1t18JtsTxNs=;
 b=R/JG7xAQm78fMmSrYsY4Df7YlnHe4bNz3wvsXf0W6utVXdgLx4ltyYl0Pm2X4U4l2juxlm+gd+FRF6UhDGVk5HccMFzB003l/Secii2vGVcWzvQSsab333PWPWgWOhbRaDxK3a1WMXtxBz+rfyRThxXlXmEqs7AQ1ziMNGisYqB9gCfvSyl0ZfoHf+ZjryMPRuWMwFm+0l8Y/N2SEJohpRpn1o2k23jMd3ctTPD0p9Qrfu+J534nEgxrMrwoltgLtFXL70v5/6UlLBfKo2o9Cp82o0psc6icZCSepJoz2F3hj7kk2wtaFaPeFgqR3o2/+InRWGibdI4btEN/Avz0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEDIeGc2J338to9wJLaNFMxFFkKi0V8i1t18JtsTxNs=;
 b=aJipFkg4ugadrnsiHDelhRkoqbi/yyopEdplq0YUTiyYthxhVlcyLO6W1irgjA2ETwNBBk46dKToQAs4CFZV1MF10wQSE+TBNfP9FB9ldr4ZbSsw0d+yiJ6OVc/b7tyNbBThYhl8RYq56Xw9UvtGiJs78A9VU0R19ZyOBz3WkFE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2652.eurprd04.prod.outlook.com (2603:10a6:3:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 8 Jan
 2021 09:27:23 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d%4]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 09:27:22 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 0/7] PCI: layerscape: Add power management support
Date:   Fri,  8 Jan 2021 17:36:03 +0800
Message-Id: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::29) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 09:27:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a54c75f9-acb2-4187-faa8-08d8b3b79a6d
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2652E60D5FB765F1B7501E4184AE0@HE1PR0401MB2652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYU2BujIadtlep5Aqjbq/N1hOK1Q5PmncI9QAw6PlnZRyfQDhsaadkAyocEQ9PQlTY3d6Qb1gxt6loOMINPx0bOzsmgkuWcFzpUR0wfO5AwMTh7qBHXMCPX1KupvKiW7dEr7Tvtb/bziMFN15IzbIREhe6R+fNXpgtM82yMYI3MnjxtVCjoQxB3A3WTrk9Ye1HH+ppxna8feOh/2Gp9ZyyPO4BaQNhRef/lOAguLbyVXLllB7JosZW2F0MebYOC1Ujjuja/EQJRfTpYQmso80IbgGSkjjil/uMbdtRXEV/A+CnTsHXxCPE/jtjPy47eoWP0UikeuSNA0/jvbbvWClb52TkcYBUBQUGCotgpODceuFKZ63HzLXeYx9B6aPIZaaR6AhkBNmdNA+JLERwv3vvKXMKrZlq1xRA2UVXQLxOYLYm8wRAPl91SfbSjyXQ3aHSYijTQyQOvuTVbXP1JJhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(316002)(478600001)(6506007)(6486002)(4326008)(52116002)(2616005)(36756003)(69590400011)(8936002)(66556008)(956004)(921005)(6512007)(1076003)(66476007)(5660300002)(66946007)(26005)(2906002)(6666004)(16526019)(8676002)(83380400001)(186003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GiexpPvLUFgrL1wlwYpBPuihkhP4oPN+HXC/LbgR3C7ty+zIWkbtkr1aoDez?=
 =?us-ascii?Q?tJjDyCbcAIwHmFisbLyJSgz/350g3gRwHSXgSTvWGTENFtkGhUftH7Wb78ZZ?=
 =?us-ascii?Q?KUxH4MVxizGTgOnGQ6nDIee4/gcVL5vgIWujK4KTDqJemtCe92B48Dfv65SB?=
 =?us-ascii?Q?fHanT78iKSDgLN9hTo8TFC2mu5a/7o//P3hxzCSRtp99mCeX0JCwAWF0OlsY?=
 =?us-ascii?Q?kNV0GyCw4fhfmTGgIKUaqTRuQEwmjvtCr0N9es9qSYL8GW816/SZMOR8OOWO?=
 =?us-ascii?Q?WxzdzEZzEZzeVm2F6jdoZ47Hid4pR7y+7dRxOOGGrTl18G0DCryCvYVbwjpB?=
 =?us-ascii?Q?gqiE4nXE4HA6veFtlwVtq3GLIB7DawPbtrBw5ik89YSRlVtNHzS4J8vdDbvP?=
 =?us-ascii?Q?DA/4rd9YQpz+pQkEUJlwpW8PEu0LCxmEfo9oHCJXpdACo57xSV25kCWlX7tI?=
 =?us-ascii?Q?5mlaDzNkmy9HiUsfPVStSz0vnFooaiVZ3L82K1ygDd/gsbazCS/yoninnzn1?=
 =?us-ascii?Q?ZkmQB8eWajPVwJWaQE1Ko9AlSF/Lbi+eYa1WsNtlTai81A7lqJKpYLDmW3Mn?=
 =?us-ascii?Q?ZO72dTn8BHohTlRcLjb/bSRBQWjBEvyKoxeNzhA6cNU20iO+cs+ceniQMUyQ?=
 =?us-ascii?Q?n9ZviKnRJrWs0kPFOlUkGfBb7aKAZ++ZyCVuSz5oATumy7lY3DfYgTJN1D10?=
 =?us-ascii?Q?Xrn6Lpz0hdt+bq7Paz8BROcxwToKY8tdI84VWYbLDj8E0MSpKm401hWS+jvc?=
 =?us-ascii?Q?p05F++0d6sJsy+O43BzllsRY/7VkzqOFGOVVlT7zIgvlLbcthHZ/wOYCINCA?=
 =?us-ascii?Q?StUxaYUIGoLqyOkTu1feEHRfLdU7WR1KG/1eAZG72rlUHaRN3UYYftjvXzLn?=
 =?us-ascii?Q?0+BMPM3HGqBFHTfzp/FAuf9OLskoQptI61AAcrb1Sh6ocS5TsPPeM2id1PHH?=
 =?us-ascii?Q?zPQgo1liuG+leR8i9cGBQt5VOHtZgBa1D9Ypmy0vhC0u+loAJIJFHw8ry5rA?=
 =?us-ascii?Q?xY5Z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 09:27:22.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: a54c75f9-acb2-4187-faa8-08d8b3b79a6d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwdlAfF1ue7ugSmw8Z/uVL6xY+xBngcEWux+YLglO5Ar7CvOV5Md9Iq8VJNHXe+GFBnBDg1luNrw4FNO0fcYLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2652
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch series is to add PCIe power management support for NXP
Layerscape platfroms.

Hou Zhiqiang (7):
  PCI: dwc: Fix a bug of the case dw_pci->ops is NULL
  PCI: layerscape: Change to use the DWC common link-up check function
  dt-bindings: pci: layerscape-pci: Add a optional property big-endian
  arm64: dts: layerscape: Add big-endian property for PCIe nodes
  dt-bindings: pci: layerscape-pci: Update the description of SCFG
    property
  arm64: dts: ls1043a: Add SCFG phandle for PCIe nodes
  PCI: layerscape: Add power management support

 .../bindings/pci/layerscape-pci.txt           |   6 +-
 .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |   1 +
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   6 +
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   3 +
 drivers/pci/controller/dwc/pci-layerscape.c   | 448 ++++++++++++++----
 .../pci/controller/dwc/pcie-designware-host.c |   2 +-
 drivers/pci/controller/dwc/pcie-designware.c  |  14 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 8 files changed, 376 insertions(+), 105 deletions(-)

-- 
2.17.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA21354F34
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 10:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhDFI6i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 04:58:38 -0400
Received: from mail-db8eur05on2048.outbound.protection.outlook.com ([40.107.20.48]:36960
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230032AbhDFI6g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 04:58:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMqYBe3enOVTE65wdqkGXkxXVThr7D6+//0Ncp8/FjbKP8wwNBD/meHvHIe0oezeUI+e3Kcq15PWNXpPusQSqU8EyWvp4Yim4oTRka6csSkmmAvfDpgAu7xPYa2WZpKsCWmVY9GSsP//yP93pGuNl3BAUHnV1n6AWCUIIlco+eTTRVjSADbtRaUx+BTbOfcW6TU/THIgdTxFYvNls3TSX7DerUT6C1jD6DLj7PpyPj2aP5oWIx9/SbPCQzkWyUa666ceUJWYjQ8Gl3TbIPDB2v/a9jvznehjf0qvjXsqEJe8oLS2Daiu0VoOwa2CMTMLeBJqOgZilQL24Q53MEyPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmGwXOt7x6JOVfmZskL+T29VygRihfeYT/BA2pD6rPA=;
 b=Rop1rZEZao60Kq4Flne/fEpNPfweC8ZRNqfDgrSEE4nXTpEjs8gjTH7832YXg6MZ4+oSvvNfgFwA5ClAkkIEftdzgzCSpOlB61ciM5fJIwZWjbnwVjjZmy++He/KBdrk0+TYHBan0wD2tgL0tLkH31PnBqsxkGaA3fWAat+aZuknS+Eq9vRWCUQOhp4oN36TEM1lxjMmPnsbyefDOTveZ4XzPWlbp0IEjDYrlKWZmk2Yb80kDWj+SYXQP7g70OMpbG8OL40KXu4tnFHOI/TV5lh/NUGdOk/sWHbSd6HCXvfG5EDznWxh4r5owBC13515A35NZwXZJmLDMRgVEv5k0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmGwXOt7x6JOVfmZskL+T29VygRihfeYT/BA2pD6rPA=;
 b=egNZ8BNfh/a2vzg9mXzG0654r48xJdPc1uBxEZZDqdDspDADIepfxrRO46RdPvt1ljYZn46ZptcGaekyW2U/oIzbSEo4A5NPuEWsgMpwio97GshfkZLbPvB2A3xWS4lTVZUdebh4YlooqLbnoMDmzAHgAZP44qw5yO61Sl6iOUA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3083.eurprd04.prod.outlook.com (2603:10a6:7:21::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 08:58:25 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 08:58:24 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv4 0/6] PCI: layerscape: Add power management support
Date:   Tue,  6 Apr 2021 17:04:43 +0800
Message-Id: <20210406090449.36352-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by HK2PR06CA0001.apcprd06.prod.outlook.com (2603:1096:202:2e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Tue, 6 Apr 2021 08:58:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4635149e-9e82-48cd-43f7-08d8f8da22bc
X-MS-TrafficTypeDiagnostic: HE1PR04MB3083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR04MB3083D4F9BD5F286F25FD108584769@HE1PR04MB3083.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nlsvse8u6Kk769NqMEWBNPvWovC5vRdEcCcB5dx6QAEOs5pFprGrLLQKFLAMi+l1SZyx2YqjoAmTJh4MsfvmWt77XoDbTHYGpQMuXy+qlyuIIRd1KovbzM2CcN6Th9jP/9pu/yME6l3g+v9NKXxx5Dx4P2sGNk5aD1IHYtn9CKFkw/NiX5N/7bYK4uQvdpeI8izaP8EJI45xP97xn/tk+iRIxvXxZPK9SdViczFB9ztmVLR8gSRjWzSdUU4YskfdxUqqjUNb1nS6FoXndgPFlV7+OjXK3EA9C2fNhNbAME36UWj0CmFveviP3K9vhrQrNpDYqua6TPqxZGg1xAdoRXjxTj6aj18izq/uqkb2+eVVg6GyY2VQt4Zlv238fUPSLCU/RuErX8Dkkp6ReMlRp94xcgV4C06Z81CIkZ0MCyYH9D+qNLQFo561m3VZxL4YM4ccwJUN1dnn4ZnAHtJs6J8ftX33UyPbY7MBxiReRMdIrP01NQaTTPxBYvJ//wRgGAYcKmHdlFqFz96wIU6PplRYG6M/rOdtThu0esi4HQXkdcEf5QBXs5kGL1Czz+8aukVZVCdyNtZD0felShhOfF45JkFZgXATWnE7yCrjeKGLlU/un7alnCQe1InnHyhCsIw5uZn6lt25+WbXbjn7JiXrKOaZZnLjkwxNXd+zjKw6QrFyf4xkMv7SAn2gFaeAv3xUJrrwOYTpH45pWblggvzEb5g/swxKd37osQXEQtOu5coKokWSfnUvXHXBajAC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(66476007)(66556008)(478600001)(956004)(36756003)(66946007)(8936002)(4744005)(921005)(52116002)(16526019)(38350700001)(6512007)(5660300002)(6486002)(8676002)(86362001)(6506007)(316002)(1076003)(2906002)(6666004)(69590400012)(186003)(83380400001)(2616005)(26005)(38100700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JSdvJKavkP8dUh/P79lVJetZ5Ebq3KG71NgrpYhXysij9b3cT0vl7DVRDg8x?=
 =?us-ascii?Q?9TjIfH3Oq99QCCe7gc8+SVvyuH1ty0bW8ioBFu2kUCNROX0vI7zaYcKR31g0?=
 =?us-ascii?Q?z8U/vWwurFQqOfhBNfpYu+PduBuuql8aF086zwIasnT0lUnApxpwwZ52h/Up?=
 =?us-ascii?Q?OtAT1N91R9XOGZzDg9zpjt09e8hIXkjcq7VBwlxf772XzjlfnkT6kk2pDvCH?=
 =?us-ascii?Q?d4mBOkaVA5vAGvik0UDX2AElIeDcgCGvpCXokkFCgdKDJhdgiadZnVme0r1W?=
 =?us-ascii?Q?RMU89OV4HhkhgIZ0k+SDcoMgzmkgSo4LjKsnkvad09OhviMnI8s/rPygM+3O?=
 =?us-ascii?Q?bEzKUhN9+SpXxpborP1uV716h3g0fmVP2BymZGNT/968nN3Jk3hYlmvGDLKD?=
 =?us-ascii?Q?3UZB7rI7rJe3C3zCmkmO9ZEjlDUWBO0hA/DfnjHDR61JD67jL+YlbxMF4y5g?=
 =?us-ascii?Q?QHHaUFglI0VqAQmlE82kbVzWR/+ZEcYmh5MObjgMVJ+dhDrh93me9Elqvg3K?=
 =?us-ascii?Q?PjcLg5+2Lz8uorP83yzyl0+O/BJuDE+WdfqkOoUyZlSB+EcgrkrQJkhoK2V/?=
 =?us-ascii?Q?bmPQLryL4bi/rw5rf3BTXoEUU3hMXk4ADRE0zs23X6oInN+1mqZmT5dHPJk4?=
 =?us-ascii?Q?lR3jcg/GXHVeXyGNuwa9mMMmvOKaDYUnP3gJwE0w8A4xhyFM+4D7loZu5u0H?=
 =?us-ascii?Q?dcMVedMgXr6XJoTvEKXWHkGgPQRNnffDQvnW9Xgvq7TTSIwWZhSIbkX52Vgk?=
 =?us-ascii?Q?NTAzj03PO3e1ElDRKkdzz+Ku+WI/GdDW7zSvfIt5OPu2+yGLWkYX1FSJHvMO?=
 =?us-ascii?Q?mQJ6i4mMHzPz+S8f5DZg/ruCA60qAQjnzyJsE4aClZB+zX7DUGuJyptyAD4L?=
 =?us-ascii?Q?JmXSvO7OUfIcx5+Zy/coi21kkIIuesD64/zLKM4VjXFw2sB2pbNRWMPGi1Jc?=
 =?us-ascii?Q?e4uFlssPgU87CJmSooGAPcU9FMZAdXJ9JOzZHTc8aib+4S2LxveNfQWSGfgV?=
 =?us-ascii?Q?Q8ns2xGIBnhn7/8bip/wUkykuHxQEiPCI4tkOoSVu5TZgOwCXNaUM/Pjq4VD?=
 =?us-ascii?Q?WdlmFwb0VF7nq7K3h6gj57tHTFKlUqDVeB8RVXuNrfGo71DnPHwkPGF08uYc?=
 =?us-ascii?Q?Wnl2J79xFjrDlxDUByGQnkK4IvGNTozEJD7RagryUGBPpAUAOsoJ3TLSFKsK?=
 =?us-ascii?Q?45UychECs5efAJtXdK0VtqHUX88qoKyJecsl87xWD0p90RzhzZujLIRu2Lek?=
 =?us-ascii?Q?5pwk6HNMCtTdir+mJd4TdbeHEA81qvKS6yyxRuwmZsGbt4CnhEN56lVMqZ6m?=
 =?us-ascii?Q?YNWO7dc+vGW9iCvHjFsC8vdT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4635149e-9e82-48cd-43f7-08d8f8da22bc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 08:58:24.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLNNJuk79y2MilKNMe2ReMsT8pmfI+C5dgntybXLU9LZuSM4tRlcYkS18sCPUkcndR5l59LUGWBXuHLPwz2M5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3083
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch series is to add PCIe power management support for NXP
Layerscape platforms.

Hou Zhiqiang (6):
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
 drivers/pci/controller/dwc/pci-layerscape.c   | 450 ++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 6 files changed, 370 insertions(+), 97 deletions(-)

-- 
2.17.1


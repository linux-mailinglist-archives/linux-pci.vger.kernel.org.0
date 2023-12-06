Return-Path: <linux-pci+bounces-584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 270A4807453
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 17:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1B6281ABC
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D0F4642B;
	Wed,  6 Dec 2023 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T+wEGe33"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74429D69;
	Wed,  6 Dec 2023 08:00:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+Ttk3+ryreRo9R0FD1JdXFUGklMIuXV8cXHMVVaE8FHorQEbhdenbJ6YVRTdQKxMOgjWKXIcVAqTYgvLW92ob9R6nFJUh19ue1ZHKMxklEt03MSbzASfo8/D0JLmFeX4UsN9yLYPqR9bHSmKWc88kgh2jIWDCERaObk5i3WuLejS6fYTIhBbNtJ+hcIyX3mS796bn6t5KBC/LvkgEk3IUorcmdePBm0loko4MXtn3J9FuU4TTNJfBhn2hvs7JNRxS2297acwxC6n6/NQtirg58fkqDknJ8kTyzS+AgWMou5xL4HkbU8z2rG3ohPGovOT7ItB4XV/7fE4H2VgUVdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vAPk8rLYB2qIAgJMrpBFjAz8szAdUaf1T5N6p7VHnE=;
 b=buaA3eaV4+bwSPxpPB5lFc+YmVu6YD5EwLouFNIeK37Uz2x9lwNFwX0+3Er2F9Ocwt1hpeqRSM2/Ctkev3rJocQWtXs2l3njiLoRPzl3zo5DfaLtAHN2TAC8E6VADQeJWWupmTesvg11xVq3lYN8M0niD2gS4eQ2GG1z/oy+53Yb/aWcHzGiH2L1xd7kZ40tBfBbPHjqjOklEOoV9v/EbFHmVcBGTUrgmTr2DJZApJeK5g8kDfo3id2K0m4MNiiR2f61Y+qGtm+d7KWRQ/CspAfRTETwTB/tNdj7kJ5xrBPuWUEAoQr/I/8oLNAtcw7IEDlO1VpzFQC+zGekzsnJzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vAPk8rLYB2qIAgJMrpBFjAz8szAdUaf1T5N6p7VHnE=;
 b=T+wEGe33FzUvnTSwYnfKRF5z84tzewhH2APkdkuCixVrvGEik8JfVSsEhrTJe5donGEtTd9zKhmhbtEqQCO8eFYeq516vIHaI+7NgidKIPtcDyNJAAHcrpVnX4oKmLRm0qDX/6xL7/hJ+Y3ofvExPg9GVOTWS7Pt2kGG8kQts+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8123.eurprd04.prod.outlook.com (2603:10a6:10:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 16:00:02 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 16:00:02 +0000
From: Frank Li <Frank.Li@nxp.com>
To: imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR IMX6),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR IMX6),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 8/9] dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
Date: Wed,  6 Dec 2023 10:59:02 -0500
Message-Id: <20231206155903.566194-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206155903.566194-1-Frank.Li@nxp.com>
References: <20231206155903.566194-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 90770d59-fe95-4316-def0-08dbf674678c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KMQ1puP4Wm9TcVt3VCOqUKW039icdzrRd6vNqmF6CfBE7Xh2VpZWif//UQK5w1YYnlr0Ta1y84YIUTGTTpTpXdpm89vK68D0HTVH3WUMkTABSaUiOnTpD6UXBxEF8DDyCHZGlfCtwto3Od49sgB7hOZkgyeErrKzecLMtPEnuz27s1cFMVX5v53jI8cdYGoeTBP9YkdYZKevq36pF2+cOsYX2TMQLhG/CgcgVDyl+RWAGMHGt1+PhjrTtkZRTh7godgGxkeiAriHLVL5456+hbONYQ60kD8HuxGY3NBzPJirS7+93bcTLBKo5ghOpzOfAH8Dh3sz9fqaFE66oblQ73vqYD9Pg4HnsLQKdTWjjESWu0HbXsVb+Jn45DIbmoboc2r+6mXGC5GRqkKlCbxDKqFvL52Kv5I8dBIiGToSiENeovBqRMRsYQ1npYikupWYdkYwGiir4yTfETGz1vMMS6iu1qKCSPx5VS4oYGNaYXuhQvJemyP1lFJk7cj2OK7S1Fka/TULlKuNnnKmx6mWK2jWMNkfOou1PJ0k171Hl6t7mk2vA/jOACnbyj0NqdKZCjBzBS6gN4H1Xzy80DYAJszz8duiBxwqwao0um0FFno79lQnQkKs/A/mR7jq+4zpEYcZbz8DknEAIA5AvnuhOxjZ92CkhS2uPVKQPt1g0+U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1076003)(41300700001)(36756003)(52116002)(6506007)(2616005)(26005)(6512007)(478600001)(4744005)(921008)(38350700005)(6486002)(7416002)(316002)(66946007)(66556008)(66476007)(86362001)(38100700002)(110136005)(2906002)(8936002)(8676002)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w6XcewcbrVLPgXQ6pmb6/xNZ2Ysqf7ru/+lHds9Jw0D+bP3xweFGmPE7bBpR?=
 =?us-ascii?Q?lNjEQ3ZYdNul9zpUTCJcD839ZKsAO2kAXi+NxvoF9LsRjdloyA/JkAE0spy5?=
 =?us-ascii?Q?sqW0yao3bWP8aPuNwx76NtBaGZUJQ1Rr4bHWTSl+60rad15qzTiNa/KMh8P8?=
 =?us-ascii?Q?PYRgFBzKsJB/Qct3GF9Y1q0TOsTaJk5CayeOUIBDwnKj2Zdy9LIpOziwEccS?=
 =?us-ascii?Q?dD/7qjzgcb83XaCNm9M84h5+W3r8TwdcB4Iwo+iy3iEa8JtMJvhFwNc7XmuD?=
 =?us-ascii?Q?mtppRGGe95u8fQHLRzsvNKgZrUdryzHegJoCoInQpchlZk4hju2fNsuDQ9st?=
 =?us-ascii?Q?d6MIXdlHOgpzjQzJtPotSmrAXKuoWYWmFgjwly3q09J8lPcvkJdfsVmEuFml?=
 =?us-ascii?Q?omX87twS1XXdKPObm+Q0TbNF2drqBAXSNdO9bYVlCUYfuiLCbDeyist0luAy?=
 =?us-ascii?Q?P32IUqhT6C7ttFcE7hXZUgGx4lQjjMVBsOAEx8xDou1uJ19X+7rntFpMePLa?=
 =?us-ascii?Q?KaGRdXSg7AeziO0FAF6mwdtMSLJmwPKX6D/VQ/OFf5Baz/N6iF/7DKWupAnf?=
 =?us-ascii?Q?+EOdCAXjW2sqDyy0SLWCfBhdAtd1rY4xlW0V5crvtk24d0+oW+ngB0CoZjaN?=
 =?us-ascii?Q?Y6bdTLoZaH96K8XUSJ5tBI2LtPrfMZNhaYiUv7iZ9fUXfTArXuOu6CJapo9R?=
 =?us-ascii?Q?fAkzeBbqyVnyONVGs41QvZK4QFI2LqAKqJxj0J+lQpa0QFL6CHhD2R71GXyL?=
 =?us-ascii?Q?WEybIxRyIsKACK17VHYVEbBYtsELPkzm+6OCNtJW++CrXkn20+u+39NLfcPK?=
 =?us-ascii?Q?h1uw4AnjCSVmsc9Cj/qokIeggmRi9rPzZO87dW35AxP9HuAISaGX8nSg6/j4?=
 =?us-ascii?Q?kA+YCLZDMqa+YOPrFCkmOMTMUqww21NeX/yTGy0MY7lucpC8goXIb6ZiXQo3?=
 =?us-ascii?Q?RekK2cpTc5AXb72xZnbKNGlsGT/5UdGg9amd31MvfwsZn5+u8kKXlWGxhEGh?=
 =?us-ascii?Q?OnkSM5QHUBPl5+NUxVTwXoeqTlISXu309THJaAnjez8MkzcQpIBzMAl0XzC0?=
 =?us-ascii?Q?9tbowboBEOYj3Ug/O2lWBOL8FdKC3XYG1QZvYB3HgewkMSzU2/z8EBOwRADm?=
 =?us-ascii?Q?rBJmM1+jOus1hyoMnOstCcRZCnZS9pvzSgA3o7X2W/Mv3CYC17p/iG3XySiY?=
 =?us-ascii?Q?jZkGeLMaaWvosBuCXmP5O1tzEOOTj9IgPwvCUYN0azdVC1LTP3udhVf15bAz?=
 =?us-ascii?Q?/8aIqx2dn/EIijkDxofk4+NEozsueGkicwKuj46M1MWLxB+AxN4KmUWDC6Hh?=
 =?us-ascii?Q?2+rwXKh8Gv19cWvKOjwjzQxpaLg4yA1cBNf3N+mewYlwGa8bCyfrr5jTjSbO?=
 =?us-ascii?Q?8l8G8tWIj0BUtuPDhxReDJv1bdhHvZvrpl6gWhxlHgI2OOKKNzY4h6iHQgVb?=
 =?us-ascii?Q?rYObsu52Gieq2EB+XkXt8i4+soYMlr9bfDzLZF4AJSZFr82mLVgdMza9Ku/e?=
 =?us-ascii?Q?hIieqRfr8t4dK1CYmNAYKAXWDzx1cCGEjrgqg4ta58OZ4pl3rf8TDXIELyQS?=
 =?us-ascii?Q?A0fRhZJC/whssaLxayU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90770d59-fe95-4316-def0-08dbf674678c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 16:00:02.0098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AZz3cwSLt2SgKIAs/uFl44CGl+lgi5eyx1Y4hkKFO6krwA2vxtXKed+tus+8oD8wTfqGCR0Mi+af9coWshq/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8123

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 81bbb8728f0f..723335767843 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -29,6 +29,7 @@ properties:
       - fsl,imx8mq-pcie
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
+      - fsl,imx95-pcie
 
   reg:
     items:
-- 
2.34.1



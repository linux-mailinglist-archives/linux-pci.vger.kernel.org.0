Return-Path: <linux-pci+bounces-25974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC891A8B005
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A0216C59A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 06:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3610622C355;
	Wed, 16 Apr 2025 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E6p3fYyi"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF80F1A3144;
	Wed, 16 Apr 2025 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783760; cv=fail; b=MXyMNDJY/KXKeayKnkm5QHDYcFpXbL0zMFqM8QiXSuGwj9VNKNzQ0tdHS6qPHBrKH0CghOAdjuuswwydjDpnCqte2QfhkSJ+kJoMJ8bawpIxmmQ2Mo7WrafZJg5N6DqZp2lvpfz7nTpzHa/fzpTA0qk7ZxeYA+Wm1R6cuIlgVSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783760; c=relaxed/simple;
	bh=OJaVlGIuZuLfuK43ca5IGo9AF0hfYb1Tipgg1k3Vhzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bhaVIdHAo1KzrwdDgpR8eh65LMzyVQ6eNJiaH5l3QjZeW7Um3x74j3VmX88tDFlUJysmFIVwwmLovw1J1y1uabBwcGxP8b2zJWyTqpTehSytIKaOx4C9kVyVtBNTkzJgsk1yN5InusQRfXAdp+Lj23ntl1CqDutxMuF3ija0jfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E6p3fYyi; arc=fail smtp.client-ip=52.101.70.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pt0xkWLn2KeLRf1EfayY0iAOnkrSsq9AxUDbyTydlL/jWe1pOnnBpHYv4NCKB6ZtuMc3ZvRcAD56aD/vRtdSQXu7Vq7dXwIX2uTLPFAERiTvdAyqzEXVufaPV+FkAiA2E5cnas600owxAumYycgs7tNjHt7MBG2gRkF/lqN16B6YLTMPF1bamBajCEdBOFC2JKQ2kVvvIIS71oh+Nfy9K/XMqo05ncrn1aCZL7swMAKwTHrM4yv+l1IcUXAEF3xs5DozDQlktz3HlBdaTKXtRryV++/U5xGG9p9e7urqyJLjqIjqEvDmKrVhzvRZDmEyHlO8NmYBvrkneIsadk6eJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzkuEuF3vxATR0qlAIIOxYhvBuAcc3gluQRBVeS2DXE=;
 b=iSnRBElDdkiDfmOX5jDXnNc41zDJVF6A5OgG7QnhSEBd5N87qKgj12ctQI/+3iPAsFDTugHARn7Tf2DiTRdI9vs6bETaeY7C069qrm7s0pVhhENJHI7s7WktRxNIxG7/nqad9jFbcQPwARlANphwHQnkU+OTLM+irFZ6ZemLN1CjYXc6p7UxR64k2/8aoYXJlub3kt2Xka7IwhsVdFcJB360zzadURWEzuqu1bMFVfOE1wfoDVz/7uI3ARDMiASiZBpbt9I3sK8BFLHDJYBcz4rTxDv0RsrTFOjPO4qcl9uoGweYztVGFTsheVl6UmzjtdM2E+s9Z5lK3p8n/9j+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzkuEuF3vxATR0qlAIIOxYhvBuAcc3gluQRBVeS2DXE=;
 b=E6p3fYyiv5Jgmiko0xtMqxGOrUbdvMLOREbsTddcQwt5lDwyftZz9/Vt0bjOj6+Hw+vA2ptFPePfXtbrD/ryyl+KqJ4YhwVeLWEOAOv1ZDG8CAY8jgIdq7hYxTbdh2cAUJksX6+KxRQNe1HaeEn9oUR/KxKoNe8cJ+6FolEFc/hM8CU4URujXi1RuINMOX4s068+i1Snt+HUeEPGtsGY0d36cg6GKZuf4bd7ohIAH4L6ChoSlfiC/MYpahMxbe2xoDyFqss6BAtQeaJAMtz31VePRRJNCq7KPDVxOyXCtErP7cCIIOnxMIuRItnA+F1fyEzvtVVK0aecoYQ7I0Zrkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 06:09:15 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 06:09:15 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 1/7] PCI: imx6: Start link directly when workaround is not required
Date: Wed, 16 Apr 2025 14:06:42 +0800
Message-Id: <20250416060648.3628972-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250416060648.3628972-1-hongxing.zhu@nxp.com>
References: <20250416060648.3628972-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: e9905f27-bf92-4ca1-f8de-08dd7cad36ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9rgLh54MR4qE3wIFLLdJHMiDbjIPGqBkzAsMSsb44uXmqpce7gaZtP3jUYBS?=
 =?us-ascii?Q?UCoCocqYWsc7F2TTYjUoHVtoPBQbVN5eQcMkQuGPBQkVW6E3g0JBsHobX9RV?=
 =?us-ascii?Q?42Z7IKdeP066n743Saz4L1mS9dXWeUVJz7L/ByxquYnD9QV1aSMjWUi576il?=
 =?us-ascii?Q?Dt41aaoMTI+u9R5bxWXMRolY8iOnrimBaOQnCI3SXDVEiJPTEu8zW+M03zTs?=
 =?us-ascii?Q?eJpqqal7GCJYi/dcJbIFf2vz0xXXcdLwSZ+WQO1RFHbQL8gJec3TMC9q5ekS?=
 =?us-ascii?Q?jBzdpBI8K6h7X7l+KHPjlVF58IV398YGZ5gpdzLGCtFXhm7mEuqrVpus5VU7?=
 =?us-ascii?Q?eJnz6XgF26wEvecJVcY1FT9TmZOf9OKXoXNneGgIbVRNQHfdntbXLfiZNZDY?=
 =?us-ascii?Q?7kLA9obTxfcMs9Uw8Y4bb3OHbNIgrVhLq0ph6rKbSGJkmLQaNF4oysR3r3xj?=
 =?us-ascii?Q?zQrPZHC5UL17cnd3x2mXqkvHdirR+3dsHemCy1SlQ6ltBXAZQiL48qTTKcQE?=
 =?us-ascii?Q?nTojNF4AOu1NQKOFnHW9dpEywhBhkiBAKrj+ZbP2oCr88HwfPy6rICUJxb5w?=
 =?us-ascii?Q?Q77MT0/6/7TVVNeI8ep+NmP16tB3jVdiiov0S1msOFQJ3457YpP+9stTFjyi?=
 =?us-ascii?Q?fjUiuZsFW9hv64ZJjGherMt4+NigfrRL8DVXfmVKc0dRMD9QeB6r0TOdmQp0?=
 =?us-ascii?Q?npyTafcPhILq3ThF5Eb4pL8Mt+AOgLvLngEGY9pzBeTPZpqEATzUoTLVutof?=
 =?us-ascii?Q?D5Y1XsG7B1pLltifx+VpVW8P/0BvZhf4KQSAfcoMPos/9Bf6dEWsy2xeaISZ?=
 =?us-ascii?Q?ry4KnwOCkqQEnKNpcR39pIojQUZTH+XfPFuG2VK2G3VlgYeM5J3QvAPzJ8tA?=
 =?us-ascii?Q?NBoFpqx2PlSTKYZpfuZTu5gjMXSc+cuBHEqB+/kt5KwP5EtK2HTpFS/gpINs?=
 =?us-ascii?Q?klFK3RC4DA50WrGIvusuKhQX3fLbuToYKbH5BaBIyJ26CM+dfgPc5aqQt0hM?=
 =?us-ascii?Q?hIelm9Ya42eoxDlLIBmLiVGQ1Lv9HUT4sShWey4g0m+FRXvrUUk/X6tZTOCz?=
 =?us-ascii?Q?Udc+XixbWMIbkHkJiGDTIR0iVlA5THetPtmQOfB8DrmxOYCddh9V2GZqRb1b?=
 =?us-ascii?Q?mVisw8KOhWDz354Ue1xa5D4rtqtl+HoL4uKxqBjymD3eN5zcuJs2Yf0vrYwo?=
 =?us-ascii?Q?uQKjpVnZiB5Y8q08cx3upLDjLisRfQModfmxCOsYEQArbzir/bWEvOQW3Ygm?=
 =?us-ascii?Q?jsmhxzy9+cFGMnkMdMur1JbzD9ZFEywsAjbYLUpYzF56QtS94rKFG8bxaa/f?=
 =?us-ascii?Q?YAGfITuL25v8wpTIR06uaR6vvYVtXjf2E+1wj4rHliwtXxJtFMLI3cFKXyr2?=
 =?us-ascii?Q?52qzVAaFNnBbEdhvEH5U+c7a/FdVTswZ1PkY9kyPH+pwVPr/T54UaJ/gmSKU?=
 =?us-ascii?Q?tx0VoL+5TeDaa6/Nv0uBgQnqbApTfX9ZY3jIQphGqv7d3FCR0hyUHMNaP586?=
 =?us-ascii?Q?IQnYeJGllBfEyhc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bqn6O0uTi1V21Y2b+TmkUICb2f5HQl+D8aJU72BnAT76mFkzU+tl95cDCuD5?=
 =?us-ascii?Q?Q6vFnMKnBDBo8/4K/CKrG6ga77UMQyqxp21qVDezXECwfmHDWhhX+bvqNsaC?=
 =?us-ascii?Q?4hXC8siu2mfYw2Dh1jAvDJiQ+PgexsCLsxIIvnQ4DLK87nGi2Bd53EKY2JEl?=
 =?us-ascii?Q?aKi437m5SILIxI4IIukLxhBE53v0BJi0zUqwXhhxjQHbxTivHlsyUuNfAzUM?=
 =?us-ascii?Q?oDiRBXGws4OFt+sliXIA9AhmoIDIPoSB01lcpFQDCFEDQJ2h8Rr8KT1x6Xt8?=
 =?us-ascii?Q?4/029LCtRZwmdJLUNmZOJcflBc5HFUEPy8ucBLoey7so9nYB5PpH0l+v5d2d?=
 =?us-ascii?Q?FvFPHCUUvgwUzIK0aD5IuqXj1QsPxGWc2YA23OULdD/KIYcuXs+7VZoghskw?=
 =?us-ascii?Q?sLmWyO8GIoqE0rSyxjXsImeQP91dlynWS9CNa2WASwy2PKQWYSdup/gz+5JE?=
 =?us-ascii?Q?oP4Cb2J7vuqVErnuxMcWBIEDgcd7Is+vEaod/T8AiYPN39BmSQ8uh/2sZy2V?=
 =?us-ascii?Q?ug0h2CtWjsGXI7LaK7tt/1Ff2kkZlFOqE1lcRTJ6BD8cXLR58aO3Z5pGqECG?=
 =?us-ascii?Q?O55rb/KpfN1bGLcSc8Ygoo/HsY51LWrE+u7zFNaob8X7BU3M8OWTc1us+DQE?=
 =?us-ascii?Q?vnbjarYHiB0zSkqfldgLzAJNt/m4DmyiCg9LqagB8G4m6gg936tBrqHaS5ei?=
 =?us-ascii?Q?upqOEPWQl6PyOJ31hVM9XZS77sufTtXN0VqT6zjxUHA9EuNt7PPulV/sPuFx?=
 =?us-ascii?Q?6fmHAKXRp0JogZC6Q+iy5CYXqGwhwzFJ2Vr//sdgJq97xEejVvFM7UfwrGQx?=
 =?us-ascii?Q?p0TYhGMJsiNBo58YqCIUYcAPa0anvZ5h93OYHO2l+NnKvv0rxhDCWcYTcait?=
 =?us-ascii?Q?hkDc3/ZH1aD/xrYHV0tklZK1HCrFYsisX66E35KCvoIBq2zzz7U+CQyznkYI?=
 =?us-ascii?Q?QsmIzMwTATITyoJuM6enDce8y523+CyZF4sZQxLDeFW10dTU3k70RhAupYDI?=
 =?us-ascii?Q?3/J3jRTkS2m1LkBshfcHDkdEeweXQ59pg4+NHznvtTjEGNS8AoPTqXA6ogqe?=
 =?us-ascii?Q?mSj6lUaB7R8T+k9DuYu9lRXxIRLJzRgpPNNJ9a2NV9sDl/OcRxc98UoYCurw?=
 =?us-ascii?Q?vGmRgZHKtHDL8Mb7Jf7vJBj5vhXfqM+4Arr8uHknP5zJohmfPVFdUPyVK63i?=
 =?us-ascii?Q?ns1m8EzNgV8m5o6wX0VcztsWmypHJeIotMomsH1mh5qzo52419lAmSRHS1HY?=
 =?us-ascii?Q?U1FM0pFDbJZValA4+Z+yTCN9J3Pf+GtCtZguhT28rB9f3tPrfj7r8AgUZ+0X?=
 =?us-ascii?Q?QveIAmcZchtzZ4ewGUP5pKpcyk/L/JupA1UN/gUF61YXN2cBtFW2aRxKqXlr?=
 =?us-ascii?Q?FQxV+5BpVtpS839lqvGDRXKuBMsfASsmlBOmkiGiJMF67madF4gVWYnG0jgR?=
 =?us-ascii?Q?XCW5zUvMBXt6Df/ek6irI64oIpLsSR5lQxIQAlUWKxS8BcjIrkVpmhiEj6PA?=
 =?us-ascii?Q?9JFwwdxzpFT+rhNEnoHu6NuhJ7KKhQ9oCTb0WcqqrgTd9ykbG5bxeI/YhrHo?=
 =?us-ascii?Q?hLAYAUUhsOpFK1qWsZKAF1KY1Mb5Et5VPO1Jv9gR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9905f27-bf92-4ca1-f8de-08dd7cad36ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 06:09:15.2782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rruZPn7sKNCRHDpyiB4vQDAJERfQDsYMY+gbDk7BR3mhPtejoBInO7SjIwrGANaJo7SkoZes68eprJ7tpd0FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

The current link setup procedure is one workaround to detect the device
behind PCIe switches on some i.MX6 platforms.

To describe more accurately, change the flag name from
IMX_PCIE_FLAG_IMX_SPEED_CHANGE to IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND.

Start PCIe link directly when this flag is not set on i.MX7 or later
platforms to simple and speed up link training.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 34 +++++++++++----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5f267dd261b5..a4c0714c6468 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -91,7 +91,7 @@ enum imx_pcie_variants {
 };
 
 #define IMX_PCIE_FLAG_IMX_PHY			BIT(0)
-#define IMX_PCIE_FLAG_IMX_SPEED_CHANGE		BIT(1)
+#define IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND	BIT(1)
 #define IMX_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
 #define IMX_PCIE_FLAG_HAS_PHYDRV		BIT(3)
 #define IMX_PCIE_FLAG_HAS_APP_RESET		BIT(4)
@@ -860,6 +860,12 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 	u32 tmp;
 	int ret;
 
+	if (!(imx_pcie->drvdata->flags &
+	    IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND)) {
+		imx_pcie_ltssm_enable(dev);
+		return 0;
+	}
+
 	/*
 	 * Force Gen1 operation when starting the link.  In case the link is
 	 * started in Gen2 mode, there is a possibility the devices on the
@@ -896,22 +902,10 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 		dw_pcie_dbi_ro_wr_dis(pci);
 
-		if (imx_pcie->drvdata->flags &
-		    IMX_PCIE_FLAG_IMX_SPEED_CHANGE) {
-
-			/*
-			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
-			 * from i.MX6 family when no link speed transition
-			 * occurs and we go Gen1 -> yep, Gen1. The difference
-			 * is that, in such case, it will not be cleared by HW
-			 * which will cause the following code to report false
-			 * failure.
-			 */
-			ret = imx_pcie_wait_for_speed_change(imx_pcie);
-			if (ret) {
-				dev_err(dev, "Failed to bring link up!\n");
-				goto err_reset_phy;
-			}
+		ret = imx_pcie_wait_for_speed_change(imx_pcie);
+		if (ret) {
+			dev_err(dev, "Failed to bring link up!\n");
+			goto err_reset_phy;
 		}
 
 		/* Make sure link training is finished as well! */
@@ -1649,7 +1643,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
@@ -1665,7 +1659,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6SX] = {
 		.variant = IMX6SX,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,
@@ -1680,7 +1674,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6QP] = {
 		.variant = IMX6QP,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
-- 
2.37.1



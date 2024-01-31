Return-Path: <linux-pci+bounces-2846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 799DA84322C
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 01:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80DB1F2172E
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 00:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15070A29;
	Wed, 31 Jan 2024 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cih+Wo82"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020BC376;
	Wed, 31 Jan 2024 00:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661961; cv=fail; b=oBLAEudnEWxed7xVp60zwVVA/waeowaw+v2obbNPzV+BFmigju6A1ghpVic8TVqzNDrSjQE9eRk7Dc7MU1guFijnM/wX004EiJFlUAlDS7CQnefHFfxkOkVmhCTDRToyIi7MF6OBxXwTCCSRUnWXL5s33aRvNEa4BkVZZDhko0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661961; c=relaxed/simple;
	bh=Z26ijTWu9kklFNv4mpRxio96+rSVE8fsb1NKDPiRJ24=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MriQqIBROSmHYoyppZbw9Nv/7WhO7sBNYVO6PnuhJZ2dEHc1ujCsPyLWnNL9wgP3yX3PVtcTZteeBuG8LhYr6Kds47k5UX3TQKz5eQJBPhdeMW8ztldddvIVBA/qt30DuJcvLkkQ5HAEG++guXCat5JB+GpGQREZFblgXulPiKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cih+Wo82; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzpcGAuvmA1BtySWm4gjM/FBGtywz+7LRK2BSWTmFde2pP3SSYyYsXAvWnKNTUCee25sMYmk0x+cqy+LesYxQdPURwr2R6L9+PYqK+elmNhiHsK2eDRmgqfjJ3EpujSl9h4YU4KcN1Hv/gEgNoY7fMHjmn7TJkgDXQnXPQm6CtUhZuErVAtiLdMvoWhdUFAOeCssTaM0vAe9372CiU9ZjPGLnX4avnnU0AVGut3bbxVwapi7bpsGCOfQZ4xj3AL8a4soG7rPf0YFvsC6qqm+s1lhC1JnpIjPjwx/Y3+TyGNbCARqOeC9MDtrLunijQVo3z/eXL7aw0y1ZVBaH9XJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBW2xTui5wC0cl8OR4//w42EY7bam5XH3e1go2MU8so=;
 b=fLr+GfG3r5HFhic22SM7mSOgeO0rdrb9oI4sJJAmSa0DCUEtEz9pYjaElx8MSB45bcJpuONknhMyZLdJoLCXHShhBiyXtfuZJeUKggnJ7DpsrIwneyIsXXnGklAbBk+3o3iWq7PhGZsjJAhpDVoIjeqSSHVpUKbTuXBwVmW6CqH+2ZZW7uyh94Nu50YEAJD1AvKQGQEQkofVyTTqpBuygzhosUhzGLgKiMyb3kyN9MUvWMen5OjDyo0ZDD73xuxwmcbk4wig0qFD3/Rb1ZkoUaVXBjRCfmLEXLRCUMel/7JCsj/ENoEJpSDKaoDMcl1yl/L2lFeXVk3NpXNcTtwimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBW2xTui5wC0cl8OR4//w42EY7bam5XH3e1go2MU8so=;
 b=Cih+Wo82sCvkf9dCL8vhC0qXUhT6Id5RFn/sBiMSFruEhTbj4mhP3cm1K8iBmRy2+dobuCdorMaT2Brk71jMPZC3/JC20a5NduHQWGDny3MTv4QNVJJ2J/J1/PppN2xI9eixospxH43IaF8oBn28A+JQ8BFk8TVPBve9fHCYKJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6877.eurprd04.prod.outlook.com (2603:10a6:803:131::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 00:45:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 00:45:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 30 Jan 2024 19:45:26 -0500
Subject: [PATCH 1/6] PCI: Add INTx Mechanism Messages macros
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-pme_msg-v1-1-d52b0add5c7c@nxp.com>
References: <20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com>
In-Reply-To: <20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706661950; l=1517;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nE4jamYScnOg48L0dd/XRhLRFGfRIOfGIfMx2QdWz0Q=;
 b=RqwGnuCNaXST5/Dit4b0X6oAf7e1wjFwvVNSezKlg6vlCFQgmQBP4G/DcUDf0QaWrx7cN+NHv
 QMvL1X/bFNoAQHjhaSbCyGF+yMOnBiBUisTkXeE20YgwZtZNCA6NfZ/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 465de1ed-765c-408a-382c-08dc21f5fd00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DW9BFTyQn6C8ABo9KG08meeN59qHKOb3kZR9wKWdZFv74yCql66DaqWo59iWwhafqFwcTue2Qny+4SEJmvo6DB7ENjvyg6d/n6aYj2P4Nhk/f1prGBXIlE3CmXj/nplc+6B86qHppBac9ybmPibv7PLQw2+oo8lCp/HGTQmW3rEPhaAU15AUEs43hhtmxYAF1kKRLQQVIczrF8ZLV5AHS4Wz3QayDKtcKVj8r6eEOouP7yvdY79PQCRxISga0JmpgxfGjxWuigAyOnPOgi+XOLQZmc+iIZqffkELg8xuOOnCTQ98d2OqwF4Mu3Vu6kxflrQf0c44aYaG90EpYM0ow/pYrFy2LQVsNqRea7Qz6T6SpwXC6zeu44+GKbiNr8psHKlyG7uObS7Hc/IHWdPAxG2NwuNCXzME42BcdENZf1JM2KgiiKOyrV14OY6tT7FV+6OH6K+RqIDqpeCE7FkUqftHs14623frS4W8BG/rAZvSKJ4XO5TJr0zPjvzvRsbaFldup9Ainc6ywewjnLORYkLnpZJf88S6je19GC3Oid7V116aB4AAojwptRylabpNTb0c4XNZn3x0LJhY1wGacly2S0D3K9H5ZcEBACxmEvc7eqKY6HwYqEOUWcvaRbR8CzKl8pmtHoZ95WMa6E5S8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(921011)(26005)(36756003)(316002)(66476007)(38350700005)(6512007)(52116002)(478600001)(83380400001)(2616005)(6666004)(6486002)(6506007)(38100700002)(86362001)(5660300002)(7416002)(2906002)(66556008)(54906003)(66946007)(15650500001)(8676002)(8936002)(4326008)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3FiTmtOWVRINVp1YTJ3SCtqeDBlSmRzQXFwOEZYb2NnNUl3REF4WTJ3MDVt?=
 =?utf-8?B?TE5JU1d1RE1hbkZVN3BOUFBZSlZIWjlPSURDSnhWTytEMFNpOFdIa3liWVU3?=
 =?utf-8?B?T29Ba1ZLdDlKbm1MNzJ6cG4xRHMvalo1MWZIM3dRd25VMUVBZ3lrY3VUbVJa?=
 =?utf-8?B?Mk1zNUtCM1JDd3NqcWE4WmJJWm9MdUQyYWJLZlo2WUFYd2x3aWVNaFphcWor?=
 =?utf-8?B?Mlh4Z2F5RG9kYU1LSFZuVG9BL0RJRWlzQVpvTWQzd0FjZmFnMjZtZEpxNXBL?=
 =?utf-8?B?eVVwbk5RREtUbnVtRlpvaXZtenJPcTl1R1dseXZUdWJ1cnIzNWVSR2RyK0xp?=
 =?utf-8?B?UkxGWnpVa2JnRmpHSXRmQlR6aWRQMWdmRC8rKzQ1MnZwTWFmWlBsTDB3MkJt?=
 =?utf-8?B?MzVERG00SXp4azN2a1JkSzNIQWx6bHZFY2QrYmw2TDFkZk1tV1ZGY1k4TDZm?=
 =?utf-8?B?TVhGMk5SWjVmS1FtWTljR3FBbjliYXc1THphaW8rVWRkTE1oNEpjQXY4QjlR?=
 =?utf-8?B?OHdaSXFYWGxSaFB2VDRMM2NTY0dvZjFzOHE4WWdMUW9pOUhKTnI5NVRQM2pr?=
 =?utf-8?B?OUNlUUorNkdBU2ViUGpMY2lmNlkwQytrZDRISkZRemsva3hlOTV3eFM4NXBz?=
 =?utf-8?B?SzI2QjZGK3Bhc256V1daVVozZEFXYkMxNFl2K0oxUGUvYk5JL3ZkUE5nc2Rr?=
 =?utf-8?B?S0dqY2RDektoNWRpRlBxK1VNNVE0ZnJ2WThqYXNtRE9aQ1NhWmtXb1hrNVh1?=
 =?utf-8?B?QVZJVEsrb2JlakNpVTVaZXhVTWhFcFYzZU56K3pvS2ZqOWFNQlJwR2NncXkx?=
 =?utf-8?B?Wmwxd1ZBY3g5MXkyK0NmT053MHBUZVhBTVRKUWtWSVQxWGRQRjQ1OGtXZ0Na?=
 =?utf-8?B?bmM2WU1PVVhVbHNDcE5aQWU4SjREQzkxOTgveTBpQmQzd2dsbjZhYVNoL3Yr?=
 =?utf-8?B?Qk9PT2pnZFBKRllFQkFJQjNiNDh3blFRdlNCNjBzYklVUG5EdkFTVCsveTQy?=
 =?utf-8?B?YVdOL1laL2pzZVNzbmQrQWFwQXYyQTlxK2RCVHF5UjUrT2pQc1Y1S2dOZlc4?=
 =?utf-8?B?UjUvb0EvQ2dnTUdpSVpyQlJ5UXIwYmFqTVJoblVqQ3FKOEpnbnYzQS9TUkEx?=
 =?utf-8?B?NEI4cFRNZUIwK2ZxMzBZaXJucVB4QUIzTHoyZWV2Mmo5NUhuZW1oSlg4QS9E?=
 =?utf-8?B?dmFvbi83WVVFNDVpWkVXQ0dTeEcyMWp0VmNRcldQdm5jSHZYTHpxRzRScEx5?=
 =?utf-8?B?bXhuczF0ckp1SWlDSncwSUh3VUpJeUpwZjhkWUthS0JZc2FqZy8ySVV1MlF0?=
 =?utf-8?B?YkwvNUlDeDJaaGwwUyt6VklHWHlJK2V3S1kxZUh1RUZQUWZ4K0Jyazdjd0tC?=
 =?utf-8?B?bUd3K2Y4eUVDV1F2UDVNTEpEWCtpbEp5ZHpydkE4OEcxeXkyeFRmTHByZXVq?=
 =?utf-8?B?VEJTMzcxMEdjR0dITGNPMWpENjdSOFJpaEg5RnY4RVZac3hKOVBJSFJKczA0?=
 =?utf-8?B?enh5NFFMVHM3UTVDbDAxYUxIOXFUeVR5M1E5dzFVYkNNV0FvNHBnd1QyZ0VU?=
 =?utf-8?B?N0d1OHFCREVkaEQ4STBEcVkwaW9haGd0Q1I3MktYL1IyRzJZeE01MmFVaU4r?=
 =?utf-8?B?MVRnNGllVk1Ha0NoMk5kd3pvUlA5Y1VKOWU5am9QN2xheCtzeXRadk9WVHVC?=
 =?utf-8?B?TGVZaXZ3ODVpYld4Snh0WS90ZVRhSmY1MEJGWWZjMHA0WnhrL2kxeTdNWEUx?=
 =?utf-8?B?U2E2VUpDK1pPUGlJM0c4VzlaQndSS0FZamtaYjhCdUcwbkpmeThIYkMzR1FN?=
 =?utf-8?B?WUZVQUU2dm85TlVMYUM0NEhQT1hmcHEwWmNlTmtiSmNQRkJCMERud1BiRDB2?=
 =?utf-8?B?V3p0RjNUZHBOZDZaWG14NW9yVXMzWUNJVVpTNmxNVFhtK0tlRloyd1hvS1lv?=
 =?utf-8?B?S0UvTVNxNHE4aDFlUElXQXZORWlPVUhXTmJySDJHWVV2a3JqS09Tejl2ei95?=
 =?utf-8?B?TXZKR2JyTDBENW8wSE1CQksvanFZOEJyN0FZVXcrVjBzbVJBVU9jY3phRzFH?=
 =?utf-8?B?RW1KMStwczI1c0FmWXJMS1d0aWhqWmRxM1VHMmhFTmgvZytKbnpzVGZJMmFO?=
 =?utf-8?Q?isSZiPXeFOKf+7mKeLucf6Hl4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465de1ed-765c-408a-382c-08dc21f5fd00
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 00:45:57.5901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mC4l68TIXkZWUUkudpz0K3m4N3CMmP4M/VRJsyY5NQIVziVPjgPKlYMX8NdhI0RyZW/FYZl2VBtHrzE7bM7KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6877

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add "Message Routing" and "INTx Mechanism Messages" macros to enable
a PCIe driver to send messages for INTx Interrupt Signaling.

The "Message Routing" is from Table 2-17, and the "INTx Mechanism
Messages" is from Table 2-18 on the PCI Express Base Specification,
Rev. 4.0 Version 1.0.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2336a8d1edab2..fe42f5d10b010 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -22,6 +22,24 @@
  */
 #define PCIE_PME_TO_L2_TIMEOUT_US	10000
 
+/* Message Routing (r[2:0]) */
+#define PCI_MSG_TYPE_R_RC	0
+#define PCI_MSG_TYPE_R_ADDR	1
+#define PCI_MSG_TYPE_R_ID	2
+#define PCI_MSG_TYPE_R_BC	3
+#define PCI_MSG_TYPE_R_LOCAL	4
+#define PCI_MSG_TYPE_R_GATHER	5
+
+/* INTx Mechanism Messages */
+#define PCI_MSG_CODE_ASSERT_INTA	0x20
+#define PCI_MSG_CODE_ASSERT_INTB	0x21
+#define PCI_MSG_CODE_ASSERT_INTC	0x22
+#define PCI_MSG_CODE_ASSERT_INTD	0x23
+#define PCI_MSG_CODE_DEASSERT_INTA	0x24
+#define PCI_MSG_CODE_DEASSERT_INTB	0x25
+#define PCI_MSG_CODE_DEASSERT_INTC	0x26
+#define PCI_MSG_CODE_DEASSERT_INTD	0x27
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 

-- 
2.34.1



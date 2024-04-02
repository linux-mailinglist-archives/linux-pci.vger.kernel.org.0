Return-Path: <linux-pci+bounces-5553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D178956FE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223E11C225F3
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 14:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6972A13665E;
	Tue,  2 Apr 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nv06wxJA"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2139.outbound.protection.outlook.com [40.107.105.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196412C814;
	Tue,  2 Apr 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068499; cv=fail; b=pj4ZMcf3h3PEwQp3gHVOMTyD9VF5YiCmavIIb/7uE/moWPGJuvN60fQiNdPJRTk3a+8IYv9GFB8BS+FuYeUVHSVb2mMvRwVE5ifohKhNoaQFfTna5R9N25yVRtSicooUmuD7hRpq5yKNzQdbZwYdF8qbyFsnhlHncmDRc9Cj8xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068499; c=relaxed/simple;
	bh=W5Ja/aOtHcr7fQ+ZC5kV8MpJGt4HFMAXp5sPXdyeNFg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rJucS3gAfW4KhNkrUUM8eWX5ZnBxf/MDjT/TvPP2146qbLHquBy1+gx51XfFjgcHC5WEQQozTmhVRaJd5XawX13JYnNr538ySXLeWBrGCD62Gw7zn8vMO8h1dkIMaYEVDOk4lMUbq16CT9NAyO1I/W2dueaf6mLvbs7pk6u575c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nv06wxJA; arc=fail smtp.client-ip=40.107.105.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrG58nKmYfQZ6ZyXn3rd8fyaogPMvxY6qhrs2zqCwHl4/lk3P9AFPIEALSkeV4SsHbKrCQCIWCeULFX4a8bN7njiOAbFEhMPaBjNVF4UrBabZo4WVP33GUDbmjwTobPLo8xYFQW5e6dRuvsZe+TKB1aelYYGpO778Yq6NPfwJ67kLfik48xm6iGTiDlF3pQ7duPLgcuI3dIjGI1ML9RCG2ZUoIaD23e7u0AX3LGGah/JzNvH4ko8AxiVUpkFD/9Aehpx6JUOvWfmr7cuZGda9+/qPSGfB9B0FXrYUB7z07bvfL5etFNBZR9uk4/SUklrO7ZQoM6fo4t3ofYU5vIN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hT9OuiFh234KpH0JqKQ6bxALCRu9jXU7vD0g8Ik8Mo=;
 b=VfQI1nD+zHHJ4W9TevzC+uWhiPUxWzr0a2OWaGX/jvlY0NMFdx9eE3xWF9JijzYRMC/1WHe5qXc8WbP0kG0RPhXTF7FNAE/419gSUWossteK1OU862ySWD06W5Yw4TEZ8YY6lpmF/Z+BqAYfYfs2xen86xh8m3v8A7utVapbUq0XjQqhcZ7trQ8SKX5iVqu5iPJ87tdLiw5+ubKDcrc8dotdqEctOYLTrjVFcFeZWwPVkZFQXS8TaqGp9xSghUJMrvNadLUUYXw++7DokymVQaQ4akQlmNqEkImxWV4ZuSvjk5bE8eTdw/Nkn3klG5KjeO+NZSJZBWjIcXpZ6fL8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hT9OuiFh234KpH0JqKQ6bxALCRu9jXU7vD0g8Ik8Mo=;
 b=Nv06wxJA6eEzeHP0f8y8kcmRRggEu+7mFBXR7g1I+TbnJxOd4kmzKXhfXRI2qPhMReqKUZxPNM6mDJHVmypzzFbdnCB7GH56uTEJ7OEky9OYoO/tvmIbatJS7OG4RFmSpW7r5nWjtYFYpQI8EMQX20tWEFqsxLy2VP6gfUt6rj4=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 2 Apr
 2024 14:34:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:34:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 10:33:47 -0400
Subject: [PATCH v3 11/11] PCI: imx6: Add i.MX8Q PCIe support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pci2_upstream-v3-11-803414bdb430@nxp.com>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
In-Reply-To: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712068432; l=6004;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1InHHTt94Qoa5DZtH+PuBX0T7azBh9B1HU0Tvhzx7eM=;
 b=5R3vKC3lwVauaZflM6UtT6VhwD5mbC5po79wmuYX/9cp3gE7+apXI6AtIR2Glza1ywkAI3RvD
 q8FD+vCs6XqDzuegSj1PnZa+VD4vZUb4AjtjCW+21EPTRXz0H2QTUlk
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+fhuaRh9n3Ea41/EmXveTOJMNUMI9/ntXVZ6PiHcjZYkxNfBF4NjrJ8Z3Pk8gJghn0RsvsnJ1FvvBM17s3NJwItcQhLn+cKBs1nFQ3nIIsem+2wLsIhZQz5ZuHQk5clH0DLbU6o4IsQBDoFClDGOW6gyKORPaM4gYk+IplmRWkwsSSmxW7XNNbQX9eE+DqFdAaNGkDQX02n5/rPn+JE+7WPfQSZGbcPWI3/jgt2j9YK3NRV+l/PhLq1cjx5pSmqXFyEA7+A76bSI7SbQ1TeaACuVVKZI26YBxG5L1HvdRU64gYUOPBkm2zPsyJ8os7/qVn2xHkAbqptSJ2/jwOwmQe1nwGDSOklS5ssWq3GTsF062MnUCb/BQVETkJ1PmLIqm8R9SO7fG680fXN1zyVwsjW6MG17f5kzXtEmlSpxkvEti89+yhV8VkmHzBA6Cklf1yKVmRUdyMiJzdv+jUalmvxQ5W1qFmyyah++4VK+B9nGbSR/sBXdBpC43Tox3GxvjFt9DJlo+W6A+CZKMXOZNPjIiOrJFNeWjaOWxX6fFwGvJQLZS84N0V7zqytqtsBWFxu2/cs5cdwNCJ0sY2JMv8mtVICDJPjEPlRljAm9OIqgfhobpT1hPe2Y+NFIvnjjknyUlGQhCCjj+OkL3UuVFGm21xTHqgCrcUMfHPYm6Ob7bHG2N2c437lN6CyBF3lbLk9mjrtj89rDKjw5/mCEZ4PmbIPcPMwY1Cv9qA6GuR0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(376005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWFKaGlOU21zYktHd08zc2ZYUnFLS3g5SXpIanRzelpvL3BETzdUZE9IYWZT?=
 =?utf-8?B?N1ZHMDVIemVnK01hWDd3UDgrTEN2dkZ1MThycG5xNThSVjhwb3hUa2o2Ylhi?=
 =?utf-8?B?eTNFWElhWnJLS1BPR2s1aVljVHFaVjV3YVVISm80dmQ1T1RoaUszczV4RG5E?=
 =?utf-8?B?SG9VM3g5cmx1eVoraUUyMHlSVjIwTExuNWdydmlUcnhtWDE3RFBDUW9PdXgw?=
 =?utf-8?B?c0pnd3FhOWU5UzhJaDIrNFoySE9jZWx1dmovSEFTY3FjK2ltaUJlM0JuTWlD?=
 =?utf-8?B?azhOVGg5eG0rajBJdTJ6MDhpVmJnaU9lMUQwWE1aTzh6MCtCcVVCYVV0Vm1U?=
 =?utf-8?B?RG80NzdQTTBOZjJwaHVTOURDTUlxbGlGNHlyTVljV0UwV3ZDbVNEKzF6VWxl?=
 =?utf-8?B?eUx2NWJ1cDI1UzFncHNWUUdPeU1qazVjN0FLSDRtSTdvZFdXam5ESmRXU0Rs?=
 =?utf-8?B?R1laTitOc21TdEpld2l3RjFXRW1KWFhycktuNWJ3QWQzRlUxL2haYWlkazM0?=
 =?utf-8?B?M21RL0xrQU9hc25hZnY4dHk4TGVMV3hza0J6U3NybGJUeDVqN3BWbjVSdHp0?=
 =?utf-8?B?NXZidStwOER2RmdqRGJjRTdORld6cE5UdTZpbXhab0NoYmttRVJaaUx2QlU3?=
 =?utf-8?B?SERLR1FvT0VoNXo4aFlLd00xS3Rid2s4WUNUd210NDJ4b1BFTjZMM1NYS2VW?=
 =?utf-8?B?SFExdUg2UU9MR084a1NSMXVTTnRXbjRWcWdmWWJ2bm5sRlEyRFBZVjk1VnJl?=
 =?utf-8?B?a000MGFjYnFvTzhmbjhoVVA2UThoS1NmaHg3WFZEbVFHRml5c1pVa3Y4elhR?=
 =?utf-8?B?Q0FrR1NhaGR3M1pjTlZyanhJbHBWYTk2em9xNjUweXBQTVdyaUQ5OVJqWmtZ?=
 =?utf-8?B?VXlMem1FQ0VQcDlDMWduQ21wWklXelp6cEkyeHhUQ0tyRkJtQ0hsVTZodHll?=
 =?utf-8?B?OUQ0SGgzbzdBckE4NVN5akRmTHQ3TFo0YnU0ZDducGoyVnZCVncwSFlFcC93?=
 =?utf-8?B?NHFCRXlwTy9mOGtBQmFpNlVIYjdGb2dLaURyU1diZkdEUjdPai9VbEdYSlUy?=
 =?utf-8?B?TUNZS3pneDJ3WDJEZHFnNHF5WGY4TjlKaTBQMGNaVnNwbXp0dEg1MFgwa0w5?=
 =?utf-8?B?aVEza2l0Sklld0NJQWRsVmV6b3VmbFB0dWlnejlBNnVoaVk5OHlPZEgvSDla?=
 =?utf-8?B?V2pxOEFvbFVFbk00UWE0bGhFcW9ndlF1VWZKNUJuR3ZYK2lkVFBZZU5EK25G?=
 =?utf-8?B?VmdzWUo2RWpMYXJRaTN2a01hdlpsYklVRzFBZXdIRFpyN3ExK1ZqUEs5a3Ra?=
 =?utf-8?B?WFJGRGlZTU5iT00rN1VlR2pjUmpmRUQ0RzdqN2IxM0VTUnVGc3BHVTFXMzZt?=
 =?utf-8?B?RmUrMTFrT3VBZ1BmQlhUWS9xbFJoRmFmZGZoMFRBRVVDWHlrbzdqQ3pMSGJa?=
 =?utf-8?B?UTd5ZDBNbVZKUnllVGN3R2lBbFdlay94QWU0RGlGMWM4VkswSFVoK1RuK2Zm?=
 =?utf-8?B?Q2hwY3FSSEEwTmRMRnNuVmhnMXlFMDA0cXptOWVhSkN0OWFnMEdyWlk3U1ZI?=
 =?utf-8?B?cXQ5NmtYcW1DWkF2dG9OT05RZEtEOE8xZm9rK3ozSUc4RUpKOFBrNWpTMlZz?=
 =?utf-8?B?bm54a05qV2Z4TU5jeGkvN2lEMEdidWM1RmF0UkprU3F6UjBUazRhOWNuOGRo?=
 =?utf-8?B?NUgxd3RPNHkzSjBXZGQ0aHVIOEdCSlB3Vlg1TmtUREY0TVJ6OHVEWFlveXdG?=
 =?utf-8?B?elYvWjNJT0g3Y1FPcXM0UFlOUjhlNkI5U0RrMmoxQll3S21ROHFSSmhiTFI2?=
 =?utf-8?B?UVdKbFpLb21tcjNBUkJsR3hxaGRLaTZKaUJDaHVRTUNYVW92cWVrcVRyY3JP?=
 =?utf-8?B?Rldack9SeElNQlFJcnpyMWhBbjJGaVl1WFpJcGdEVkxmK0t4eGVuTHp6OHlv?=
 =?utf-8?B?ZHRyaWk2REloeVBNMGdiOFBLZ2k4WFBNUmtzSTFzTkU3emNhZk8wSDJHdFN2?=
 =?utf-8?B?aVBHdGJXaStwMUxCZ2NlN0lpZytNMGpSRmZsZ080eENyMjlxekxuS2VBUUN5?=
 =?utf-8?B?QW9Md1JFMmVkUkcyWWdGd3dkRENWUnpndk1wNlJBYy8yUndrRmRvVXFXa3p4?=
 =?utf-8?Q?d4IM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b0d47b-6166-4878-c832-08dc53220f67
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:34:53.3416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urDcbSTbUEo8ulVIIZwqYpGxGXgKPSE+de5NHMz2eHfSMY/vGcop8Jefu7zeHIJ2HAxrwCjf5v0X1Gw4U/TX8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9986

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX8Q (i.MX8QM, i.MX8QXP and i.MX8DXL) PCIe support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-imx.c | 54 +++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
index 378808262d16b..af7c79e869e70 100644
--- a/drivers/pci/controller/dwc/pcie-imx.c
+++ b/drivers/pci/controller/dwc/pcie-imx.c
@@ -30,6 +30,7 @@
 #include <linux/interrupt.h>
 #include <linux/reset.h>
 #include <linux/phy/phy.h>
+#include <linux/phy/pcie.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
@@ -81,6 +82,7 @@ enum imx_pcie_variants {
 	IMX8MQ,
 	IMX8MM,
 	IMX8MP,
+	IMX8Q,
 	IMX95,
 	IMX8MQ_EP,
 	IMX8MM_EP,
@@ -96,6 +98,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
+#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
 
 #define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
 
@@ -132,6 +135,7 @@ struct imx_pcie {
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
+	u32			local_addr;
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
 	struct reset_control	*turnoff_reset;
@@ -402,6 +406,10 @@ static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
 	if (!drvdata->mode_mask[id])
 		id = 0;
 
+	/* If mode_mask is 0, means use phy driver to set mode */
+	if (!drvdata->mode_mask[id])
+		return;
+
 	mask = drvdata->mode_mask[id];
 	val = mode << (ffs(mask) - 1);
 
@@ -957,6 +965,7 @@ static void imx_pcie_ltssm_enable(struct device *dev)
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 
+	phy_set_speed(imx_pcie->phy, PCI_EXP_LNKCAP_SLS_2_5GB);
 	if (drvdata->ltssm_mask)
 		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
 				   drvdata->ltssm_mask);
@@ -969,6 +978,7 @@ static void imx_pcie_ltssm_disable(struct device *dev)
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 
+	phy_set_speed(imx_pcie->phy, 0);
 	if (drvdata->ltssm_mask)
 		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off,
 				   drvdata->ltssm_mask, 0);
@@ -1104,6 +1114,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_clk_disable;
 		}
 
+		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		if (ret) {
+			dev_err(dev, "unable to set pcie PHY mode\n");
+			goto err_phy_off;
+		}
+
 		ret = phy_power_on(imx_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");
@@ -1154,6 +1170,28 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
+{
+	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
+	struct dw_pcie_ep *ep = &pcie->ep;
+	struct dw_pcie_rp *pp = &pcie->pp;
+	struct resource_entry *entry;
+	unsigned int offset;
+
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
+		return cpu_addr;
+
+	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
+		offset = ep->phys_base;
+	} else {
+		entry = resource_list_first_type(&pp->bridge->windows,
+						 IORESOURCE_MEM);
+		offset = entry->res->start;
+	}
+
+	return (cpu_addr + imx_pcie->local_addr - offset);
+}
+
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
@@ -1162,6 +1200,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
+	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1481,6 +1520,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
 					     "Failed to get PCIEPHY reset control\n");
 	}
 
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_CPU_ADDR_FIXUP)) {
+		ret = of_property_read_u32(node, "fsl,local-address", &imx_pcie->local_addr);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to get local-address");
+	}
+
 	switch (imx_pcie->drvdata->variant) {
 	case IMX8MQ:
 	case IMX8MQ_EP:
@@ -1605,6 +1650,7 @@ static const char * const imx6q_clks[] = {"pcie_bus", "pcie", "pcie_phy"};
 static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
 static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
 static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
+static const char * const imx8q_clks[] = {"mstr", "slv", "dbi"};
 
 static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
@@ -1708,6 +1754,13 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
+	[IMX8Q] = {
+		.variant = IMX8Q,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
+			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
+		.clk_names = imx8q_clks,
+		.clks_cnt = ARRAY_SIZE(imx8q_clks),
+	},
 	[IMX95] = {
 		.variant = IMX95,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES,
@@ -1785,6 +1838,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx8q-pcie", .data = &drvdata[IMX8Q], },
 	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },

-- 
2.34.1



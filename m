Return-Path: <linux-pci+bounces-30174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF30AE0191
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 11:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AE83BB119
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 09:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4327A22D79F;
	Thu, 19 Jun 2025 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S5Hvj91J"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F427A13A;
	Thu, 19 Jun 2025 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750324487; cv=fail; b=GB0Jq3HXCZ3UDypjtJKFbKC6dspfrEdPL0OatnXX8iw7CYvoeNVIFYQrAk1k7sSkJdyOsiujXZ5qxALYp4aJUJBTh9p41+BDQDfLCHMB1A47l6W+tqnQZirARUMgvP7jTvgLLg5Z64Dq5vKkAMesCJQ+b8Wm64Q50SkJmyDsExs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750324487; c=relaxed/simple;
	bh=lMYquXVFAfygkQnCg3XPENftDUr36L20TvKmfw52GCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J21Se+KVuNbjYtp3YPxofafNeg+rV9KpDImPS42VvdbbsFK0xp9thHIw+skOjDYQrf1Xg0kLT1IQd2JFkB8w18WIGzgSlsJwnku2EFUXPCz+AuXz53as1xslrmXVyUomgixQ1eXPW3Rmb0stIa5c99HrAsdVmMJ/9EXPGCSJ4RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S5Hvj91J; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPV5x3bjO1aua9Q9iLwodMaGFA3pt4DI4zkotNP3dGij/TpGFWnTNzoJsxBcOJUx0kgcKxFpxaFqmgM33fd2COJbIhZ92XXFOoVWj9ewaOmks9JPACI0rT6AKR8gEh6+DcbQFxqtL37SFfwfKqAxGn44ZqmhyaKarFodbz19xtnpuOZ+aQW4r9WfW6VzTTl0p4jfMtVQQfY/cle+DxufVl2h/7P9cCi00/Q2xPlipK1XOrrC5w9zkzuaxe64piGpnBaN9MDVb+4+gFO2avPdAvc689Frr60ATDllVW+D3aLXc9tpLmzNStdNwSLbD4HQHN2QarOJKeJpQ7DDXIFZhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flF1sNfjgukXPc6Zwx5msy6jj1vAw0R7GpR0xxfoi6A=;
 b=cL6/YiIwZpGIEAo291ZxC7htuckWgegFWwUKHMzKW1WnCUZvtluDIH1dnknWU9m74+E7bydG66rNHuldZdHIPV6JbdRsrLrR0/KSgRi1VwZUOwHAfReSofEobITZLZtCK9KSae2wBq7TGmPjTIfBo4WeqKr9zRbmb++8CZOvhuWQQnE/8sHIuMryb+1Ai3XRx83ZWaxw5kC4hvguC7yAgq+KBW7ZBC52JUi+7j18ozyYo1eDLztd50yNt9HFD9YDKAVbI+6HWcyFKfb7A98HXhNSHOvWDjSbrud03UwrdvoshNSqWwsuc4jJHYbID3AAWOiI8vRnOSdQlAmBobcUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flF1sNfjgukXPc6Zwx5msy6jj1vAw0R7GpR0xxfoi6A=;
 b=S5Hvj91JuzOSWtz0A6aX+pGhYKddysjvadpon5ewbywyOYvzMR78xtBeU54kmenxadsCuXXNXUX0Asica2kBi0UVStQmvVhT+1FRsnCk4UV1cClYnYDXUR8SH0WVv9S3aXibqXqqoR+6y4kogLqE4RLCJDXFLcfc1m/A3A8T6M4sVNRQaie/n2QQ63Zh8XOJHOy02vczSHQ7rnnNIR1OQlwJYR9o0m0KWiOE4AYMmA0GFYw/Bd8fkdzKUB1cVUM4pEpBWCeNjEFYvZ9D+J5iyKwOrE2WdxiFblE/JlzoIAvKXr7d21ng6k1WIePlGVMB9qRk89Kzo3eOPm+Dmf/WKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBAPR04MB7429.eurprd04.prod.outlook.com (2603:10a6:10:1a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Thu, 19 Jun
 2025 09:14:42 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 09:14:41 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
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
Subject: [PATCH v3 5/5] PCI: dwc: Don't return error when wait for link up
Date: Thu, 19 Jun 2025 17:12:14 +0800
Message-Id: <20250619091214.400222-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250619091214.400222-1-hongxing.zhu@nxp.com>
References: <20250619091214.400222-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DBAPR04MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 81981523-8aca-46a0-bbd8-08ddaf11b965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LaWw56i4XaShSOb9JH7cVOnocFZ3S4Ctn8lCVpvyzDq86/m2rXcz5s8dR8vk?=
 =?us-ascii?Q?NkgoqmWCoWZfpqpKwiO+YGn9XcKI/V7vIr7nHOEuNy7fPkbx4zq53kJeZ9gC?=
 =?us-ascii?Q?twRR4bLqX30Ls145k6T2rEcRtvO9dexksZPXDBXxDerPlx7VRoVFhepL0WWW?=
 =?us-ascii?Q?hL5VEG57Vs+m7+Blj+uX1S17c+c12MGDQEkSK0JDY7K3VTJfJdf9SjclW74y?=
 =?us-ascii?Q?cRMhqxPGKH/qaSEgabbY1rJ7zhsVkjKik6T2QHKlVACXIe4xgXqmvncASSGX?=
 =?us-ascii?Q?zAoOVMO78pTmdFw3ZaS68tC2isWc4exAatfgcYwnUH3hfMbTRBDdcCIlfzmi?=
 =?us-ascii?Q?CKLSECzPs5fjmLesUiBnuBUp0lypBl6H9rQPcBEdoC3NXmGIsuZtw5ghu6/6?=
 =?us-ascii?Q?JnCJ/DnSjqzdvDfqN0BMUAFR1jJJf6CPjkBH+/YeA/AfTgsvKBhCUXeijEQ0?=
 =?us-ascii?Q?jos8aRDq+JfzkzFYesQ+/CV6GO5A15laZLl+Q26O100FbbH8QMSKCtq5CLB/?=
 =?us-ascii?Q?+/bW+lrAzjGKVoA7lkNA7eWRr8tQ+OPE3xKWztjS/f1u6iWxwFtXZ3OGKZQa?=
 =?us-ascii?Q?zV5L91P4/swQD4I5/qyRtL1AVPJBMjc1QTvHHcgoMf5pEcK7r9qq7/ilv8j+?=
 =?us-ascii?Q?W1Y10tpnz4+7Cpnk+DrWLUp+YxvfNazALo7I8NH0ov3mxejRfDV93JG9QTN9?=
 =?us-ascii?Q?FLRE8IXRuE9s0IPtMVncXsWPZlZ1d72DX+V8Sr2PhME4C5yP7gxnHDskw074?=
 =?us-ascii?Q?SasfwaA/JSdFcEkqeYw6YjXupw6YomN0P/1NgxBokSBBfb/iY8upF3VLhg/E?=
 =?us-ascii?Q?dmPNQYczcjwJkKhm6FOPnSTEMsaOka35iX5W6ijOPf8oqQN/0ZeY3U7C0JrS?=
 =?us-ascii?Q?QuwGBowr3p+DGzw2Z9zg5BU6SicMZZJOaCa6u2HHyCeKlVWoqiPlWhhzl0Yo?=
 =?us-ascii?Q?yGPZ3Zrfm6rI9iK41gCygTeX6AaHzkTUR3Da3FkgkfwIxgSrj31GtmTrtWu2?=
 =?us-ascii?Q?0pjrJwQcpt37K1cPAEIT3s8Mb7odiUYbQ6j7+NEMYZQic93uXZvcozIMuJ4+?=
 =?us-ascii?Q?/DHZHgEILoXdh8hQn/RoxadhQHVshycRqYyyPbAMv/v1LMsbZ0tHjVzKsP7B?=
 =?us-ascii?Q?Om4YavqV6rr5eygjwCYdeu+/ruMRA3dWF7QlqnXEOZU4HLDg+jTUt3i5KEXz?=
 =?us-ascii?Q?rdE793E+Ar/CHwhNAGwqccaFAjaIegb/JFbTvdaJSI6tVyv4vPU3Kud+MHZT?=
 =?us-ascii?Q?mzhSlSr7FVtYCLzNxHLlFiv4bq5LbiIANPuvO2CBGfURQrNBqpjSAwcNVa9E?=
 =?us-ascii?Q?5fDFt+j+S3rciWJkZO84vkwCFyrnepBk6JkAE78JZeNZNF8c0vyc4SYzlb8x?=
 =?us-ascii?Q?JpBg+/5NCSQkOYzpwHWny3NK/g0W9fwt3stNNdz6iGWGaDBru/S2BPXjBYPH?=
 =?us-ascii?Q?GBc1pbG6WwHxnP3MxDuz9sVnh7x2Nx8cGx84hYMPelIyIp26KvaWOkjMHJxA?=
 =?us-ascii?Q?1glqjqwF0pykoJs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UTwW8l4LLbSSQEy1YU3spriw95VKSPJt3YEns6EqPv7vYPmfb9I76CFdOTBl?=
 =?us-ascii?Q?I12pCbxNp82lt486+UoG0WQoCdONPUNgQTqQwqacPdVxRG4HXNtepkb1aZY7?=
 =?us-ascii?Q?0k+sW+ADNH8fW8x+m2c4+d6GIfTU3UO1lkO/L4oVpBVXSF0bWPVTG2BCP34F?=
 =?us-ascii?Q?3H4c+pNP4p2caNPEoPhA44KRj5K0A+XcbzGGY2a00BkTOBMWf26yKCnNY0rI?=
 =?us-ascii?Q?boIuiZVQOKyLR9arbYJQTtxu6Sn4ovD4hlV4+iuy75kbgEUWRtl/A2zlvLMv?=
 =?us-ascii?Q?Jt/huySa48fFgFR/CTMwSjoOoZrc0bdnUV+iqiQjZT/VdNoZhfMt27phvQ/5?=
 =?us-ascii?Q?PtSzzlhlMJ5MCIeeYLPwNFnc2VmT3XZbU0wVV+F/6bQOaShL+FEgVNg0it0Z?=
 =?us-ascii?Q?SwO+dzubTfZcHcN4hxAXEdxcNnhqiQgolI0M045oV2jz+sUe8UsR5inoxC+X?=
 =?us-ascii?Q?NlgqocW62ToWABfBXx3kLPwalHtG1htacCb02HuSsoForPmgQ9VJQCm7FNnn?=
 =?us-ascii?Q?IWzOqdi2Qt17b6OtEAzs9/T3jujFuGP60OdY/rzfgx/e0Q+bIJIMgJx7iuHh?=
 =?us-ascii?Q?4lFnhTTov03SiY/Zm8aXrBtCDwFhYT0wgGM4XhBPhGGZqKoYiQQSb/R4Hog+?=
 =?us-ascii?Q?fGEAn5Tp6kn48KhC40tjLN0x863lUzUD+ICiZmsweBt3ls9UJ0KaG3HOfRKk?=
 =?us-ascii?Q?CC3hDcEZ06Q7R9/rhloIqgHkIfhI3YljX6yxWVTZ67l6bkEFzWnvfrQ3bECl?=
 =?us-ascii?Q?8sC82jvHAAHCPRCd3Tz+IJ3EzjnPHx8AuXGMOHw5ETpi/HwabGrY7KYD7Tej?=
 =?us-ascii?Q?nEPmPUTZi84w4jXLf10k5ntvx9ydvHAUg+y81dXM/iRIMFj0LcW9cflZic43?=
 =?us-ascii?Q?w3c5DSi0gvrawSqLf5lEqYgWIhaFbAdov1fueVIfdvTy+nd1Zm+MYGxyeWCA?=
 =?us-ascii?Q?utbDkKPrmBgoDxnxvYtXORQ+m5ux53pqbPKqVJviJ21iC4kHLaqW/SSa5UU0?=
 =?us-ascii?Q?4Q8zy1MLcebC5lyAMNQrnpBOAqLyXVoGfEztYLOQBI5vmxjwUNewkKM/uaT8?=
 =?us-ascii?Q?8hVJuCS7znvdXNomdu7W/j7rD8fitfS/y+G81TBJnW3zBBPHXIsoQt+N4P5A?=
 =?us-ascii?Q?ZRluNarXh+Uclj6JGBHsk6Q0jicukq+J3pNmMobxMGKCDTd1PyJRAk24t+Fp?=
 =?us-ascii?Q?pGOkvOeuPxbSZndoEApIGnfkt7P1PKRZ063+pkDgY94BBUheHxS0DGd9GL2e?=
 =?us-ascii?Q?dEjx5i3OZbr2TVtjpSURaZBRk0hVPYFSrR/pJC+C87CCRpYTef605xRs5PE4?=
 =?us-ascii?Q?SvTI32QhxeJl0aYuPpZI9J267AeaJiCGVmW9YwXNrpwpSLahC9FhMQKwJq/i?=
 =?us-ascii?Q?WbubBtSwbPnytKZnhEvLRjwwl1a0ymHwEdIeF4CrhwdtwJ3YXDDkPgOcLc0q?=
 =?us-ascii?Q?o+GwIP4vCBMZt9H/WheGsPZg23cl4n62x3yUkq2EXJmNz/2sPkTLP+rLXdvD?=
 =?us-ascii?Q?fLZukm+erO4ymd0AuZsh0G8NKm96y2ZKPeyd4jfjgLnXqC8ZLpnQTuzUuOji?=
 =?us-ascii?Q?p4AemfSR7u9b+8b2G4+zHOHPssOfwFXRqP6fdfmY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81981523-8aca-46a0-bbd8-08ddaf11b965
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:14:41.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSm8vnkgV+3IMdMQ48IjvV9HP44nihVaXKg7WJ7o9JOe8S7/jgJhfE7Pyl3YpvKeG+YsLeBkyKQ0jJSZND4ILQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7429

When waiting for the PCIe link to come up, both link up and link down
are valid results depending on the device state. Do not return an error,
as the outcome has already been reported in dw_pcie_wait_for_link().

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 228484e3ea4a..fe6997c9c1d5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1108,9 +1108,7 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
-	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
-		return ret;
+	dw_pcie_wait_for_link(pci);
 
 	return ret;
 }
-- 
2.37.1



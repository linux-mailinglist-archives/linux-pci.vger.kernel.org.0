Return-Path: <linux-pci+bounces-25204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65156A79B6D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3E7189170A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 05:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7449919E7ED;
	Thu,  3 Apr 2025 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K4k0vH2o"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44068199EB0;
	Thu,  3 Apr 2025 05:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658860; cv=fail; b=SONtECvOT18AD1D8Hyn0iYu2sb1/E+zJAAlxisIxYgy0SP+xLgojjZtAc3vLuPyIZDiykZfkbWd9GTveJXM4ceVpy1R8rM4qnYrLh+jM7188kRCXzUq8oJBkz24MvSEgztZ8w4Dt64RpU7KKUbuMuZ4H8LeYVhvDfeZeazhBe/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658860; c=relaxed/simple;
	bh=2xUmL+reTLcNCLqiRJj23ozs2CedwPB/gMsm7SrXBSs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tefsOGtPr4GGE1OmwYlj3MXXY5Y0EC0MJU6ZTH3I5QZFDXlXNV0EgKDAe3EHlfSVpY1uh4a4nm1OCzjAPF9JjnGnQ9RROhkVIfBp+o7Xzebpxb2tKLF9FVni5ZZBPmZv5SzvdXupFTK5zHYy2yG+kqaVvgXdktlBj6eOynGT2Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K4k0vH2o; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMhZDoQuT4OmilAbnTUIp2lClt/mc6eARqLNEehgfWUSOvxDTookGDLrdtQedFeiszvjJaQ0uuHB1I+Wpho7ki19GNzFIgnjNYK+PFHg8uC4VMAl/yk2WvsQC9dt8N2tskwjxGLbpovZHlf2Pf1y5U0zWond8ykQuAffYJdL4sZqjjEATjHI3k/oPo6ofbesOI/AcuT3xiuUCJ2ZgKqOff39fpPzHNXb8jxp1lPX3uaWdmvmtYCQyjC8jJUMX9XyuEr7gHRnIlGNu4KKLCK/nERSwFkp1cPjwU7GFuUWEoqUwk2F/uAQ6Edj96dIuzd2U5xKNdK4SZk/ivNZl5Et2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ewz8ljq277zr8E/LZfmRcXw5mbk4Jkpzh5oRH9JzZ1E=;
 b=KJKL9lMUK1V8NdCqwUVJHb7AHIk38g5TbwxZfN3js6bG0iXCr8Xq1FehFiQSVROB6en5E49rsGWuQDnlckFKO+3AKIhgammYeHeo4Q/ylQqVMmYm2OIdHWH382acL0fXpBfGW4trPzaRz3rvluGuSjwvNIpbTH6HccZ94jZUbwwNtyWnuGIJjp1BzFwFMVBiL6Z0G69NZjO/Wyf0yyYrSW4gSSL0OYaFcuo1SYfO+ghuwaHy8omouCTVk2dc04J0WvueBprL5DNInVwNHR1uU/lGxEWOjF/Nbn6qONJfCPWRy7NKdSxyXjKTrAPR58L30kk5/I6LBvLXKogg6X3yvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ewz8ljq277zr8E/LZfmRcXw5mbk4Jkpzh5oRH9JzZ1E=;
 b=K4k0vH2osha7RCSW1//64WOiJpX7iQeu1EmKVv9EBnXqe4nRfg4e9nrHpAo2YGY8wlypC5x3cuO6cjqPa6utvPZ8sPUwWmv92oYOmgaf3Ctljj/QZKeQ3Fani6A/fDvxwbhCFFYNNcOsG/eK7egQsJQ6OGbwEAtLUN0l0qLSp7DSxAp/3wJcSCk0RE5G2euFRWxlLrwtwlUtAewCe4ZXCPlJbLhYZ/D1p8040io1/tL6vZkh5QPBQ1+M99YuuzqT4StTlfp5jbz6ZyHt+kBkaPfX8pWh6z/s8A+niyCkTgwjmZkXSaa2bwl8Q3jC9ZQpxpEH45X7L6pdjy7+wI4FIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Thu, 3 Apr
 2025 05:40:55 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 05:40:55 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] Add some enhancements for i.MX95 PCIe
Date: Thu,  3 Apr 2025 13:39:30 +0800
Message-Id: <20250403053937.765849-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::13) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 69fdbac8-7ced-47a1-c674-08dd72721a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Id/R01ZUJCFDuJq2DjDq7rel4feq5Ql6FKDTNgGrq8K1VU1saVRsCUQ/T3SM?=
 =?us-ascii?Q?fb7xVbcX5wnhfHnN2oFV4stZx16BbKmUxE72+ky5l7zwHDNKUbGz5X16n4a/?=
 =?us-ascii?Q?mb+Rn787jq84tAzjzE3aUPFss8h7sU6rs6A+/rr7oCPN9tyFhpqld7eHO+Ho?=
 =?us-ascii?Q?z2IQa3NRO5Hb1XVzlOmMe46XPQ6jvcgAPgNcreKgXCwUP+WOhVxeUu+IzS7E?=
 =?us-ascii?Q?YCAnnsmYkwd+y/bojgQFnyA6WMyStYPsDdHKEhgXw3CnrekorYWC87qYHnQo?=
 =?us-ascii?Q?2OlUGStZO96WM/xwPk7cIzEquCXCifw0IdD/abpBE2Fk/b66nz8yJ7hFF6fb?=
 =?us-ascii?Q?u+o2o2KSWVIXnOmaxGO7EchCuNaLhpS8iqIGHQe3xePPZXf7iO2TBdXN+S/o?=
 =?us-ascii?Q?/HcTuWJ+AKffXBsJKh3vx7tgrheY6b/70bIHOhs8X0dq7WCtscFP7R90BlGo?=
 =?us-ascii?Q?iuK3b9yMTdUKPtIl7LOx3YFGKyk0ZZZ5VhpQXy+ODIogsvRqj660t71BGQ+2?=
 =?us-ascii?Q?/P7lY9iyMkK1LI3zDxwSzZ6lcM3kPNM7HS9OtWUnO0G6ldGHzrW64wjJLEKE?=
 =?us-ascii?Q?OCizRBHWtVNmqc9kSKk4YCtTuWIUjofA/At+hAZym3OGzROFAavOeJYP2dt3?=
 =?us-ascii?Q?1f5sJr0beTMoaFOKaNggBSbm5GYt/62iCQQ/7n+erFD2gRuhoeEVTZSuVrgm?=
 =?us-ascii?Q?xQAX3JjCI6NLHX3FN3IRVFRgpj7G5Fl6ERTYnXQP0FEZPOp6D+qxKggYJQRv?=
 =?us-ascii?Q?TYXnDcFYhR7PpmOYIPfzO/zDSHO4FlzjlXL0NzJw/J9U31mjDRuUL7NDCFDx?=
 =?us-ascii?Q?eJ0t5mmNgn074El0xNN2BoM+230eAF+vLzEtcemcr9hO7zROLLKgt7Eb9tMC?=
 =?us-ascii?Q?3Hc9K921DzHh/so0UEcvVVKTAvw6hpRIWRvDd0aD9SAtNi2ahkvECRI1uSvx?=
 =?us-ascii?Q?/H7jQkMc8FrM5ZYy5DbOtV29D2CwRj/ZBNi/NPWs4Bewyj08tqNdDQOCX33x?=
 =?us-ascii?Q?+iw8Vb7px1SShha2deNxpzezTvFJIRm3umAPGjyOsfSLFWsyjBz0ZU13iqvG?=
 =?us-ascii?Q?iX/4tHcObb4F6xXjVqnG8DRzNa0LYIJVJEdM7W78FzI93ngfd05gg+TiicPB?=
 =?us-ascii?Q?++vcOZh4rHDesqddfXZBnPgKN2zQSJ0rqWGcap4Dv7I+pnljxvPvyZFxHvom?=
 =?us-ascii?Q?Jp8fG84xNGw9qjbYhSysEetSA+SeYQI3gYa4VLsbymWjHRrYdX4aVXgUKTxO?=
 =?us-ascii?Q?nScQveoFSE4RMQrTascf0YcCq6SVYmPl6QOWP+9smVxvikXdKY3IRLlvqO6X?=
 =?us-ascii?Q?ROplMy14LpPc4fEfJ+VQB5pIeqq+ySAoYCfEmF4I4VYp66zWYUcBnt4oRNQs?=
 =?us-ascii?Q?pu0nvUSw2g5V7PXETyM+4ekS6x9CnbfgRV+FpQOVkPvO/uC2FZUWoryAZvL/?=
 =?us-ascii?Q?pYl0NO/TK4g+B4ERNiTpY/xByRryMSN34cu8VDH4qFgKTCqjBRAbxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4SQ+yNlP29ErXmkt8MEc+lUBlyxG9kPUbd4tQTGUBTXp9C22roFDB5qbhCR0?=
 =?us-ascii?Q?T2ReSzFF26qO1BvvnDTfM+ioP1P3RJTZFKmlnKly4vA1PMguBw6Vrhk7Ntt9?=
 =?us-ascii?Q?vebIMv8fYmRMtIxJOxfZvbdVAFKADNs5lqaBYtRPrGWN+DlCOci1CQMz41Nh?=
 =?us-ascii?Q?VY4S/TGZ1LLnuLaJUUuc9TYYlmqJtoNXDCTtELWYaUZzKleQoApgaywijKeI?=
 =?us-ascii?Q?Df0s6INysEtWG3Aebjdtc2YwpmrI+FYNZZWg8L6Hy7d6/69nOhBKGQpcpPa+?=
 =?us-ascii?Q?c6vP7FyfPn5Pw4cKQbs5iVAezAe9G/VNhJlABxOwvu2dYWBGXRK1L59Foc1V?=
 =?us-ascii?Q?Uh2hN+jjm85Du67YbHJBJ0ivOWSXB6zaq4DXSlWQHBUEQRSY21xfpUFk2pKc?=
 =?us-ascii?Q?SalsOTTav3dpoqNJ+hkdJnPBXWT5dzUur3Ay2cJ5bLZgoTffG5ZwUATz/QuP?=
 =?us-ascii?Q?Sa+In4aWCFEepRFv7bgCMbQlmE3PEQhAq0F9ZWPoRgOYm7p2pryR/QT1OJ2X?=
 =?us-ascii?Q?VcK3sIQwO2ZYJgsBGEPfbj26FXN0KKybvxy4I4eg46xgIZfrvCRbz1DA7OrH?=
 =?us-ascii?Q?rPIm7yqflO0D0iFCwKduZHP2aPj3lm5nSqymCNmETNln+sEwNhW1i/PObmqh?=
 =?us-ascii?Q?B0U7lnGIcSQYpxZZh6J7oDQeOw0OH5/Xls3Mb36HHstY70x9Rti38X/jRaqY?=
 =?us-ascii?Q?cu79GILidVvboQwZ/AAQv+6caCeVzVRcPyylTp2CYYGNJj0BJscypq0eVE2o?=
 =?us-ascii?Q?RUJsPLrqNe9pqpvaeyN3x8NejfHidi0aZ0bYUQhBOxRjKfREUBt43KlzTpx6?=
 =?us-ascii?Q?wZgXeldEBTc3R64dTDWfa/Oji9ddxBXVmompiZGB3+g8R4T7t44hHR2/Le+J?=
 =?us-ascii?Q?nNGXw+0+biMWTf5Nh8KIjH51jQupZ/zVtTL4AZnfantUrNkN5Us24rYioQft?=
 =?us-ascii?Q?SCCZLsdYsxkzy+HM4K7+K9wv0M7TBzrqOgBXpFEtqQ6Tmtvmr9Wtpp7rsKmD?=
 =?us-ascii?Q?PTzLe3IQexRNWMgXKS17DmugudtX/VlYezFVb52imSk5enMD2yjqT9ageGaF?=
 =?us-ascii?Q?dNAnpIOfmUyWCDARD38g1I81bWBZZvK/UF6OKq0hS6nCVU8zsfZk3g9Y68Kt?=
 =?us-ascii?Q?LV+B2AGvZKqm0uL7IT0aXFGbSRYoQMRhV6e23QjIY6/97KBg1ZThVseYzzhm?=
 =?us-ascii?Q?aWxpr3ETgYNV7F2wr/BX3GsA6REAqzIbGi1+9p8aJwqk7mk/1pJoR8tX+DXO?=
 =?us-ascii?Q?+zcV0+F0A64LcEb7O9AeZRWaHWlvZ5OHPRClDCl1WdKckjlfAYIDfqJz/XOb?=
 =?us-ascii?Q?4+vhlTbPuWYinKpzMgnEWJkQD15SZJUUC8nV2i3kWYbjzaRp+gciOUHjL4R5?=
 =?us-ascii?Q?WZcypjkmBD2o/w1CzfMkvu9vgyPu3b0mk1oAIC8fL7MhITICYilCLxp8ONeR?=
 =?us-ascii?Q?58CNf65+Q7e8YkS0eL32zAE7C0pHCIl4AN6eWC2dvluYY3DcB1klN57KuF83?=
 =?us-ascii?Q?1r/Hq992L7LJie0q01PDHw7ihn27Sp11Mb6+WpcU280a3YLL/xi35hWbcVqT?=
 =?us-ascii?Q?92zFbRUHopNYxS8YgBEwzZLQI8iSG8V6A5EVoycS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fdbac8-7ced-47a1-c674-08dd72721a49
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 05:40:55.1918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0W6GsFMas+0WFMmFP9/y51TeqtK/eMBn919WwCzIr3zLWpuWd0zg4tCBWR1dHskA2OBR2S2PeR+xKXo7KMi1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145

v4 changes:
- Add another patch to skip one dw_pcie_wait_for_link() in the workaround link
  training refer to Mani' suggestion.
- Rephrase the comments in "PCI: imx6: Toggle the cold reset for i.MX95 PCIe".
- Correct the error return in "PCI: imx6: Add PLL clock lock check for i.MX95 PCIe".
- Collect and add the Reviewd-by tags.

v3 changes:
- Correct the typo error in first patch, and update the commit message of
  #1 and #6 pathes.
- Use a quirk flag to specify the errata workaround contained in post_init.

v2 changes:
- Correct typo error, and update commit message.
- Replace regmap_update_bits() by regmap_set_bits/regmap_clear_bits.
- Use post_init callback of dw_pcie_host_ops.
- Add one more PLL lock check patch.
- Reformat LUT save and restore functions.

[PATCH v4 1/7] PCI: imx6: Start link directly when workaround is not
[PATCH v4 2/7] PCI: imx6: Skip one dw_pcie_wait_for_link() in
[PATCH v4 3/7] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
[PATCH v4 4/7] PCI: imx6: Workaround i.MX95 PCIe may not exit L23
[PATCH v4 5/7] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s
[PATCH v4 6/7] PCI: imx6: Add PLL clock lock check for i.MX95 PCIe
[PATCH v4 7/7] PCI: imx6: Save and restore the LUT setting for i.MX95

drivers/pci/controller/dwc/pci-imx6.c | 212 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
1 file changed, 179 insertions(+), 33 deletions(-)



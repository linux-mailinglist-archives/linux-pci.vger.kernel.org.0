Return-Path: <linux-pci+bounces-31747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A91AFDE57
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 05:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B554E83E9
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 03:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B19321CC6D;
	Wed,  9 Jul 2025 03:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fDMugoIq"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011044.outbound.protection.outlook.com [40.107.130.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB321A43B;
	Wed,  9 Jul 2025 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032381; cv=fail; b=NYpOy0kw5/lVCd1Y+tTzKe9nozyNG0oB/o8p64ekngxOBf1o3H6ZJ936vJSqlpuCpISkTCvAfPgMLctiNUluOPXlSV1/AsITmfliQ5WWff7rv1vgE7+xw9rcO6Z9GazVkWKvjPqD4vJHSRC0kUgPcHDe3MG+bNWAAlJORk3zf+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032381; c=relaxed/simple;
	bh=f2RhM6v9PVt5y7sbkqz+YhjM2JHwP+uFZW3vebtHOCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NzleSMZ7csQBfD0LFjNKyQrwMogZxvhRiFuVDbQbHsXF+1UXHRoz6GF4Ia0eg4U+pjgdogYVmxI1f1O53OuqPU4rLbF61Hga8QXyRtUp39R9kPGi657QZWexZyenLfbFs8dnhuv5C5mGQp0gjxUiGV+mMiNQ6xXleOo92805OBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fDMugoIq; arc=fail smtp.client-ip=40.107.130.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqhmK5X9VwRAIvuY+tYtm/3kJUxkLrVPltMnRLkj4+DU1jIoIsbvZQlZbVNr/3RoQTzGOmYyFFr8RbQR2OSEMpyyo683A/A022v91sPOP+Yv9rWNOCqxQrvICzZ0SSKg2EqEuGCKC/PA/3gb4MkjLASaG7glFPH4EIOVg6mrcDTq9Krdc/dZrsdpb9TuHyL3LCFG01khF3tkRrlgPjBnGKK8JgFwvhcBgOdrZFQ/dbU1Ih4eOfw255WDBRSPXRhB06GFAFtTkw95TDGz+999fMpNvwKlVlIgexypZq6+z+pW2s6LDOQwWQTRf1u4oealBWK2F9mthxmz+fT8cIQ54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCr53NFRh6XPfL7ts5a6Ne6RlThstIKSwSob1kUloI4=;
 b=t2wm7kUxDPPHd5EzwmL1vNkLWu0O3xgv9pchiX5cOERXMrf0bII0jM1p9VN1n90BdmQPXq6C6OEAiKD3L6/b7GVQ2Vy0wii7iJ4XKZ/wo1/O4nRYV3TnrxGhDEmlek+PVymPj6rCcVt/nMojb+PyBBh8MIh5v7Ks8O3Cvp0Y7chM/wQrEnrJPzyOtsZzeMa9iKbXOUwHfbtLcoolEpN0d7jpKzj/WQFfnXbpICASpZb7rPGcZxcjknWfV7QssVYrruyPFEj9udxnUBmd0Wh5I3SaZA6GIjnK/b7/yrecgG3/9L6IamBgAp/3BsRjg4M12ggI3sWdtseX664VdOv1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCr53NFRh6XPfL7ts5a6Ne6RlThstIKSwSob1kUloI4=;
 b=fDMugoIqvMQ4a9GVwTazc3IzmGHvB0frjV4xhsir0OWoyVsmIH9fB6k4DaclT8fi0UIUUqRfNZNpwHlp/7AXH54ngq11is9jYfC8GNLFEedd+QDsx1hRI6a7p6WKuqd64sbSnI583WElj07/j7U0BRsN7foFbMDrP78H836UgB0hOaxz8qw3v1xTxFhTOFF73faj7xpZ0JDOffGaIsoVTrL6FSB52iBzgt1eKSUwgK/VXLAfpFtPab99rgrM+LFRE8EolIJHwkGhxWNnOPfOJdA828wh4wPx/8uFXLIeqSAUMp7uJQWpIjEEdGdFbp+g3yBGgRkA8ZsaznxUhnY7NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 03:39:33 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 03:39:33 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
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
	Tim Harvey <tharvey@gateworks.com>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 1/2] PCI: imx6: Remove apps_reset toggle in _core_reset functions
Date: Wed,  9 Jul 2025 11:37:21 +0800
Message-Id: <20250709033722.2924372-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250709033722.2924372-1-hongxing.zhu@nxp.com>
References: <20250709033722.2924372-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::24) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS1PR04MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d1ced9-22a0-4545-5261-08ddbe9a384f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?7OAu2L9oBLZZt+mEXBy2f3XOdUgFPxPs5JGvKqrINaYNRfQYNn5prL4Nsi1T?=
 =?us-ascii?Q?hxVJV5innwWz/RumGfgm7RNG3laK6T0sbrA27Gdh+kxvJJ0NX3UKRFluQCbp?=
 =?us-ascii?Q?I9jjDbSje2JrpmJYiSHVPXWWJVY+JhwKK8R0yMsFFrc1YgQXGmMEzLzruv1Q?=
 =?us-ascii?Q?0wM9/KEhTuJv/x98X+C+2ojfwZ/ZGbJ8Infpln7upB+wOYX9xj/HTOb0c4ow?=
 =?us-ascii?Q?xhi4/xoJfqwrzqTxPknqDSzH6OuwptbE1oPlQf2Xjgp1/0PLOdFpYWEgd0bq?=
 =?us-ascii?Q?P+op+UT3iChXRLilJrZkSgXqVfgYGg81VRL+2fUnG+63/Ya+yCrJnfpP8iN0?=
 =?us-ascii?Q?1R7IsmLffV6bQo4XY+sSPhE0fheoVqP9E3dVkyKuUnABTsmop7nrea3Jv91l?=
 =?us-ascii?Q?jubx68XqiohxftXDCFyoEuSOYka2jK3syR0dMPvfmq9P9tM/sLRQKLB5FSoN?=
 =?us-ascii?Q?IWuKYwkE9tPUZ+rK3LtCmFGVL7H+Y7lX/coifKZtdYWRci+LkkXIKglYnQNP?=
 =?us-ascii?Q?ljmyqSa0nb7Po6IIFOL8CZ3yGdXjgh0oMuUJTKpTrz49EuKj7IRXEA6B8zMU?=
 =?us-ascii?Q?0Y5xPWdEFkskZJ4g9zguIw5GDkGd/o66bJiZ8SLwNhRLParnryp7PlnOa8fj?=
 =?us-ascii?Q?OMs5F3Efxo3klN5rbe6rRvhEeojq4vJavjXQGSKYaNd8s3voI7GOEVyUvju5?=
 =?us-ascii?Q?UcWi8PhmdshEcuN6eCyeufHmOA+AgFA1f+FTsfJG46mdxldfSCILmFgNpPp/?=
 =?us-ascii?Q?ZgTD1VqCzgtbUndRN4ll4L45U8UOCj0G1Uhy5jk2pM0BaWTmKpsQ8TlDAy97?=
 =?us-ascii?Q?kC5XjaVcpziH/Tb23/EUJ/VJ8PC2I+Vqh3jTqJ8OOiq2xeX03x4/7rTFMLSU?=
 =?us-ascii?Q?QhqZQqxuxXHBW0D0NPibXUUh+21vIIuLA0VUN/JW9VPWj8Ww4I0i1Q5BT81E?=
 =?us-ascii?Q?t4GJ0iLCsgQ/oNEP5IXJzbYCIP6w8T7MYz5MEP1YxxvqvBvEuUJlQlJT1P6G?=
 =?us-ascii?Q?EGEpG8gN89ZKceVEHNv0isXpoNq1wiP/41azHM3gjC0BlmzcxG0nkkshOg1u?=
 =?us-ascii?Q?kljA/xKRikgrTF/iW6z5q3ktrzX8ocaKyT631YMRxtO8yaT97/a8nzHalKR/?=
 =?us-ascii?Q?NQqWXEKYAs/ln1T7GzWdf/PYusbX7prCiEoGIMmiQE/Zl9CHi5BM733PiW/I?=
 =?us-ascii?Q?m3vJsCt/nyO8bE80XduSynZYdXa7GriRaLNHS2f+C+JqBZi2RDPlQnuE6LvT?=
 =?us-ascii?Q?Z3/iuw/mVwu70B+ddC0ojdzv9vGFVMNM9hrNzr+FxKHETEBhqGv2RkxhLIuT?=
 =?us-ascii?Q?f8WAB5Pu7Z+Q9pTtNywHWQDikmp3j8likjfXRfk+02Y9nx0U8BEBUatW/p75?=
 =?us-ascii?Q?/Xlj5Krk7XjEwYsO0i19oujp7+6/eWrnSHteQBqE4kqPlpMDLdKDV2UCKDsC?=
 =?us-ascii?Q?V7GoO95Ueg052hGPfho4fg06c37qQf9K?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?3aakcZj6ZNErFAFY7b2hEtr6i06GwCTCyPJ5tglC8/g+9yFqlSODTnULaJaZ?=
 =?us-ascii?Q?FZyp9h7XQdHXahUsR9fetNBZ9jTdaXSHLUpXGyTVKU2fHR4RpsLtieu/8Sg4?=
 =?us-ascii?Q?sdpJxGl/0S6dUZ8O1y/NubaYT8g1ZozfXPzAU3S8ZFTL9R95R/lVQPd9+Xz2?=
 =?us-ascii?Q?xjv8N+aBGMP2K2xOAX1ReIaIFAvfRx2MUF399V+Np8mvjuPo9V6/av7g2Bda?=
 =?us-ascii?Q?sDP5fmoWAsILJNA44luqLzwh8NCgkFZiuJzRG9av5j84eegWUa821Lbt81lm?=
 =?us-ascii?Q?M4nQQxoqqMWrAgx+885+S4zJ2fdSUB7Oqs6/dxm32+dNxgdMkb2ALM51Etfi?=
 =?us-ascii?Q?o4JURjdaZH6Dh/p7S04SuwvltqcIktJDFKMRG8Z2sAmR1cv6bPWYVkwrSAPJ?=
 =?us-ascii?Q?SOcwlbZqz2x6kZujzUZM9of1sGWSJMzecYs5JqYGEWjXwbYUUseHgAayTTdE?=
 =?us-ascii?Q?ls90g/YrYT/HPxHxX3dvlaVOlZoeuXFJOMmIoGjkt4hO1GoObQ0JQ4tEWcL4?=
 =?us-ascii?Q?aOLdVqFl6unnDgmf7Xk74i7DNNvTr9ack+4A/IoogMf4pdEgvGzlnmsWvMIx?=
 =?us-ascii?Q?cjKqUMNREIlAkHInAtwII2KHp48Rvt8aHst8J9OBlPEhwqZ1qXi57kjIEpIM?=
 =?us-ascii?Q?Iu9CQ5CTKGh29KNAQeCjnwcxZ7GOMtXRx+Xda6utf5U0GvLym+azXYVDoUf0?=
 =?us-ascii?Q?BGY4jhHaYfdZ1MwbMJIQT96OXkbDRfnJz9UKXaTk1KiTb8/rPRSNrl06yncl?=
 =?us-ascii?Q?s3aGjOipSwWrxU2gIrmtPgV2ojqLpRDyXe0Q4HomKxdO/FV9PaPwPsHc3GRI?=
 =?us-ascii?Q?lI42qAWDaX7Rar1wJFy7hqn/qTfiPQg0bxADuE83hymuWhdWD3hTj8odx6r9?=
 =?us-ascii?Q?OVpi7I2zJ+fug9MuvTb0KJqn75nPKM6fDWIwtdPow8i31/48ozqXzOQslwek?=
 =?us-ascii?Q?p7KttfRCmxxDOMJMbHB+U3GHoxByavEPfv+PchS7RtBkiOHR5wsNr54HtK9P?=
 =?us-ascii?Q?fFn3+aXP6iopYz8hoYksgWD60VPJbIcqVt8GrudcMHAhqsLExvoCHLZ+iMkJ?=
 =?us-ascii?Q?groFem1ACXmHbISyPTtmHrBxU/1hr+tl/VwEdjKioWmplbeQ0IdHZjoJGXRz?=
 =?us-ascii?Q?/6jjYgdoxqUiIjOuupS3IVbF3of5/ceu0HpKI8s43SdXxeJzS5WtdRINkXnI?=
 =?us-ascii?Q?3mV3rNTG1DSzjSq/zzKjAMTg7G209UlTogFhrIiC47wqe+CP8W0DthzURsrw?=
 =?us-ascii?Q?dXQq3Sp1Y3MfTQ+qygMAz9Dt+Xby5l2AX0TPZrIDdQkYwMiKMWgjZy2Nh6/d?=
 =?us-ascii?Q?lenLaFMx/+f+8ghwOMqZ7YmX9/NVflJE+uD7oEqARcW0E9RRKDHD/la49asT?=
 =?us-ascii?Q?zr59/r6fDT2rs/NJPNV/VEPADk4/GkvuqV6Pu8uUy1agvSNg3lwLjE9eP+jb?=
 =?us-ascii?Q?aDeh1eCTzr0I157mNQzu0/chEun1JIhXjUg1pPfBTagroes9GKCkZP1kZMSn?=
 =?us-ascii?Q?Sk0+PHPpTUY1PV9cBpUIcUMp0vApTnonR0p04u3RTSFrWWkkoiWTw+MbyVBf?=
 =?us-ascii?Q?rBwS1XvwFcHGFe6C8a+vXITkXUMlg+oZpGAkps2w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d1ced9-22a0-4545-5261-08ddbe9a384f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 03:39:33.8495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8CgJiBqUYZjCw15jgb1R1kzAGkDHypWlMM40rAlfOt8uxMV6wkD7afHjeZq6xIMlTdC2B4KGX3+SqsdIbrW0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9358

apps_reset is LTSSM_EN on i.MX7, i.MX8MQ, i.MX8MM and i.MX8MP platforms.
Since the assertion/de-assertion of apps_reset(LTSSM_EN bit) had been
wrappered in imx_pcie_ltssm_enable() and imx_pcie_ltssm_disable();

Remove apps_reset toggle in imx_pcie_assert_core_reset() and
imx_pcie_deassert_core_reset() functions. Use imx_pcie_ltssm_enable()
and imx_pcie_ltssm_disable() to configure apps_reset directly.

Fix fail to enumerate reliably PI7C9X2G608GP (hotplug) at i.MX8MM, which
reported By Tim.

Only i.MX7D, i.MX8MQ, i.MX8MM, and i.MX8MP have the apps_reset. With
this change, the assertion/deassertion of LTSSM_EN bit are unified into
imx_pcie_ltssm_enable() and imx_pcie_ltssm_disable() functions, and
aligned with other i.MX platforms.

Reported-by: Tim Harvey <tharvey@gateworks.com>
Closes: https://lore.kernel.org/all/CAJ+vNU3ohR2YKTwC4xoYrc1z-neDoH2TTZcMHDy+poj9=jSy+w@mail.gmail.com/
Fixes: ef61c7d8d032 ("PCI: imx6: Deassert apps_reset in imx_pcie_deassert_core_reset()")
Cc: stable@vger.kernel.org
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Tim Harvey <tharvey@gateworks.com> # imx8mp-venice-gw74xx (i.MX8MP + hotplug capable switch)
---
 drivers/pci/controller/dwc/pci-imx6.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 9754cc6e09b9..f5f2ac638f4b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -860,7 +860,6 @@ static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_assert(imx_pcie->pciephy_reset);
-	reset_control_assert(imx_pcie->apps_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, true);
@@ -872,7 +871,6 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_deassert(imx_pcie->pciephy_reset);
-	reset_control_deassert(imx_pcie->apps_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, false);
@@ -1247,6 +1245,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	/* Make sure that PCIe LTSSM is cleared */
+	imx_pcie_ltssm_disable(dev);
+
 	ret = imx_pcie_deassert_core_reset(imx_pcie);
 	if (ret < 0) {
 		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
-- 
2.37.1



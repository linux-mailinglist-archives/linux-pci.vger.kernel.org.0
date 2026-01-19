Return-Path: <linux-pci+bounces-45164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F12D3A456
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 11:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F46B30D62D9
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120F83570BA;
	Mon, 19 Jan 2026 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DqeKQFB5"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215B035771A;
	Mon, 19 Jan 2026 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817034; cv=fail; b=gAMyYZhtkwYwtQupc+06uswQxvlr7QDwQewdHx2IWNHxq7RzJGActGqMYxltUQPQWNZteFTB2TH0PjCurhY0ZPdryZ9ecmXsW1vggQMS8Od5ab7MN6us9U8vCSv2k5BuPwMqZT8zZsmXfi/VpUdzstdziCdTn0nLIR7Xt367wK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817034; c=relaxed/simple;
	bh=KtEM0PYzvgFrZhB1fZ+qgmmW+sN416pVIKPK5gyBLbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bgfRBArmcTSUbRtWQP3Mg2d+lR8cGtX9p6WYRYrGAGBMu+MpNKZMgpqONARMcdM+gPkJClDWrTGSxddFiGdkx+5p/2mhxev0gk8tZ5m4ZQMdhaQ9SIRuqTqAbEAOYvWi2rHv2SmChlnLH2teOvbgjY7UC9B9lx5kw8gij2kScdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DqeKQFB5; arc=fail smtp.client-ip=40.107.162.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egXFPQF4dBLKZdjqppEHW3sPqu1BWKM2h6uzsKJivSjiGlt3JdGZHxo1U8zjv4r79bZLW/L3by35t4QM265Pn7Umk8uAzBQjUvxtheRxt5o36ytvzwu6FG+vRMNV+eOlVE2p6oFih1cIphDfnfeQhrwHE8fpY3ww32CxPvqVptlgg/axY24MMqiDdgowxSNCB+VRrGz1eoAECEGgfuQxE6OuiDnezzSjOy5GwmDdw4GZdH30nO6StS/Klm0PwEqZfsVVNisK417zbHBKJGdIAigOHb/jOWAlDJPh/+dAJwwpa6ZlBZk1Ar3FLqTmL/cuzXn04FVpbbVZeHtjG+rO/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uQ9Nbhw4j6Cl5iF1YviyVobLc/VRI/vXHkrAUWZ3tk=;
 b=nRExcHoJmZTWBYlJkGTQUi0wj4zgSjcBUqXfIRR/0Q4YgaP+4HzPNdbIJEcQzhD6DzKS87m5x30AUKy7ieCgSyov+9UaWTDQZ7z/IkADomBPye+B2Hsrop6rCEe/AnflgVPI1XSs908UrTOQ4s8R8bTN0Z4B6RZnUkK+zu0rJlQLmFgBFDbOWj65bjucOh/epQX03jfO/YWhnEHJTTCd0YSm5QDo1SjHPO/7HgVy8GZVZrhpoHr7LLzN0NFIMU/q72zl755lvbwrfwgqauaGfJruDf5nrBBNbLiHEMISei9ADe4s/L2wvWMqASF3FP2eb0ZmDwoyjKJhGOAm9EZ9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uQ9Nbhw4j6Cl5iF1YviyVobLc/VRI/vXHkrAUWZ3tk=;
 b=DqeKQFB5nOiMyPw9s4AVZtoUEJrJ49jGyD0Fk4NBClg0pn5OngMJ81mbz/Z4nHV+YXM0xwMDdWnUgJABO8bnHjz9xBh6E8cPaIAlfmTjffp45KIYdcOWwuvgfYHUos0zlM0PqT5Z7n7lBqu83fmFhTCFIJf7b2euxoop35wdvY0rXD7DX55YMZnToWf8UM+vGhUdwVUd/QcaxyMFIisJTMUHP9NsqWnOroJPrCvVSjwUz417o64pB/GLPf284QhjnlhNDUCdgzP5YS0C7Olqoj7D2tf/EiI+NqQPnP+F4R23NEb0FHYDqOvnni9xP9qo1ka04ok+zOF9GwpPzrIb8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VI1PR04MB7088.eurprd04.prod.outlook.com
 (2603:10a6:800:11d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 10:03:49 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:03:49 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] PCI: imx6: Add support for parsing the reset property in new Root Port binding
Date: Mon, 19 Jan 2026 18:02:27 +0800
Message-Id: <20260119100235.1173839-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260119100235.1173839-1-sherry.sun@nxp.com>
References: <20260119100235.1173839-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf0893e-dfa3-41f3-8c6c-08de57420a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NsrAkTwIfxpNEgVAS0+NKEo0qbcepVrnA89GxLGJ5m6EvSId8dTzNZV9DR+J?=
 =?us-ascii?Q?bYLX0z+p5RM3uqJSKfE1vn/K3jDSKtiqBZFUP38umuZST7ijSGjrAbRgMA/k?=
 =?us-ascii?Q?I7XeiinJJ9jT1ZULqcrGc7AD0hJeJcY6fblTAdx5+FYu+5G71lPbw74uLOYp?=
 =?us-ascii?Q?JRJh/Jl5RgyBtAr+XuWabMxSZ3eguWRVl7HF1k54Dpb2A4EDrGgMq2mU+mnQ?=
 =?us-ascii?Q?tSSCWzJCa4zMA0TBkXdCx71XQcpWnkdeRREmRhj4Z/2yXrMcRXCjCdRPPcLz?=
 =?us-ascii?Q?+/OjUEaVpAJuUFu1M3jOchWWF7muhMcLQDTFnJd8fze/rYj6+hJU5uLmrvsK?=
 =?us-ascii?Q?oncg49nYclEVAHh+AIz7vZPYKZH9VaRFILL/3BVoaVlHx1GrbqxIv4bX32CD?=
 =?us-ascii?Q?vcDYg1AFcXrkz/RBSKkPp6IJtgWmMZLokdS/caPFIfAZenZR/cgcUl5D1p7i?=
 =?us-ascii?Q?W22+DE1onD2tPSWYmfcIkKkGhjSBl4v0PmyhQWEWpOLtiHh9Jk+9E51nrBY5?=
 =?us-ascii?Q?tEF2viDpiE8hpnjETKSDNqTYOn8iVC+CrmKNQohZos1hE9Onz7QMQr2HDyFL?=
 =?us-ascii?Q?cN6wrqZJO0zGpXvCOf+LxIYHarNaaWV1LfZDrSq4Pb9HENsw2ZIZU3vLee0j?=
 =?us-ascii?Q?2C8GsGesPaMLnOnG+3moqFCCytFrbfkHfSWy/61pqcLXxhTARRCzYYuOnoQI?=
 =?us-ascii?Q?nu9eBzxjjdmfwoJgXnzVKdk19v/x+AR62lRoUlLpY4f8AnQszLpkfE5CT/wn?=
 =?us-ascii?Q?0mx+VWxDKZIeML9HgcUI3eySv++JwFK9YD3r0kV7Ra14TIhY7T3pvhHieq0T?=
 =?us-ascii?Q?ZQgAf6wiv9/95rCGTLaCnd419qZneJmfB0q1avdhtck/RkTKHy76KdX9NN2f?=
 =?us-ascii?Q?PvLRNkkz2X59t+PaxZhVyI8bYkMQzkKX84q94Mk3VqA8cd4iqpOlDdJCI6gb?=
 =?us-ascii?Q?Z0g+B/4qBGuTjXkAqPokdQjgdSFxvYwE+u5wsVMUid+LQV3vCnW8oh9mt8ms?=
 =?us-ascii?Q?wpM9gyU3apfIrFV3Pvt3CoUE02LVzuNv2XoivR9BL0W5gyVl3qSbnEw49nnP?=
 =?us-ascii?Q?hJPTMsmXYPLP9N/ACg3kPkqm16ZtdMg36jrQZPAg02pBT3gSmMFxdR+jyjzO?=
 =?us-ascii?Q?lj30QlzFAcmm2dwiHhr63xRDJox8fmEQ7SlHwt5uHrI2ru8hG5gLkNht5yxX?=
 =?us-ascii?Q?cyei86vsAxjBsOdb2XbYZKgq7OM+EXncPH3odjL3CB3Ees+2qUjOkuCCPrY5?=
 =?us-ascii?Q?wnMbR2VjDLwF63cldH4XzxDDwHIkF1saI9e6N8cjjbufAUdh/aJwx553qcnH?=
 =?us-ascii?Q?ET5S3igMrxoLQcIqhBfq++z/lWTQ27JxPvXMYPhz7TGlvQWvbeb9sDJyF4UI?=
 =?us-ascii?Q?CJxrSg7SwH9sV0+OlmtRvnOXVwvZ04jX25f53W21b4N3dRfmtg86ljEaz08Y?=
 =?us-ascii?Q?+D3EsxzfhwFxeHafEJ1MoCs/0Lcm8sKCmYU8pikvwOwuWJXu7o8pvjnNECdN?=
 =?us-ascii?Q?quOhhtGGOG0kZDZNlzfZvBjTlCC+PGBiP+xpSpcYgBzXv0elA3B3ktSyMWcu?=
 =?us-ascii?Q?gLNdTvGGQkVQtXduWbi2LxcFx76mOv6gcRCALwMjEK+DE3oGw1x4SkuzjGfi?=
 =?us-ascii?Q?va0yrjh008FsKVhbzL6bFMkJodr12P5gg6nI6WS0PTLO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QazWNlLUOiRpTH4xcrxupdOrbUFUUATZvvqbBqFBQ1JpBJkY+k1YpkCaISjE?=
 =?us-ascii?Q?Iic/DHnBDav36n4h7y8NMxmX5JfLX4ZJxexiDMONSJDMbjy03xATDJ1Ej6x4?=
 =?us-ascii?Q?SYtgaWsXn62tkOXGaLQtl/Eg3Ev+v8NRAcGEry1kUxTuCHckwaWQBz1biWvm?=
 =?us-ascii?Q?p8uPMiLpO0gFCNCylO5txRhpI//M7L3HvkNQdaqPck8GEVMyRRmSxvtAbXaw?=
 =?us-ascii?Q?3qL+b2Yc4YRFm+hu4K3V0fO89MRtHTiT6PYGokGQcP5f5NWS30YlpqbpFJqc?=
 =?us-ascii?Q?KLZ/NKdqt8W6O156fFRHMZIsX2BHTBFWB3zfYwkXHEV1wy4OD8awYw/UKEa/?=
 =?us-ascii?Q?ry3U7++gTcz2JFej2tu9thJKGqkyWuT9N/MldcyvppITpH/TYxaiAFWNOnDO?=
 =?us-ascii?Q?lgtkuXL8tCS+vVkijGLM1SYkyDkVPgvcrbKwk05gLSFwSA7Mpikz9TLv7sJR?=
 =?us-ascii?Q?7M431ZPsHxYDnBcbrEwvxnRD8ub6t7EAFw1CxtoDh3VuiO1tCJzhfLRVRUjH?=
 =?us-ascii?Q?zyvqCzKcm7/m2GoXWPGo0q0FmQj9Vj2ZZ6TBZcamc49Ofov/ygUGVZTLpH9A?=
 =?us-ascii?Q?iafbW4axi0lIQ9hUFi+zy1W7jn6UtoXfSEVXZgxefcx3zzZtQB7HfBgDsv+Z?=
 =?us-ascii?Q?l8s/XTWYcpuraaPZuo8m4h+DlxKspUVr2h6I8CIzn4oZydnmG0t1yoK7cwTG?=
 =?us-ascii?Q?t2CBi5N3AeiC6QNyKAitcpHgTlmPqzwN1jytHNeEf4TbfpNw6ihg+hPuLdF4?=
 =?us-ascii?Q?AEJ8gJTUNsjyzp4eswt77QcBGNjoOd4/P0GdBRE0jfw6Z9tzgYVdanqkEmpW?=
 =?us-ascii?Q?DrRos7jxP31bNKcjgjsXDIB+0e+zlc9ZRKLS7mnoy159LbvaN1RMYj60ENrh?=
 =?us-ascii?Q?YvIdPjSZWLD1IQ9nnliGxKPTDATfMa2wm/N55fb/Ouh2vJeyT+TXvH2PwTgv?=
 =?us-ascii?Q?zRZZxaiiQFSKiXwa1VvNGnxtZatp9vcvSt6W3vZIRMoJf4GIbqhL261u4cqg?=
 =?us-ascii?Q?FXiY2cR7i07tPhVpSjc3OnnwQ95pctjvlperL/eVyAHQVy8TlkZj7K+D0Vv5?=
 =?us-ascii?Q?XFscWADotVoTq44f3cHkJbXTqxGyBUqFB4doNApKiaBTcjSG0YswBX7vWPN0?=
 =?us-ascii?Q?/Wkxo5fZesAqWaUkG0kBXO8rRcrW6t1VFvyzevr/tqiiSkjtQwpIbO/4vuMa?=
 =?us-ascii?Q?HN4N2hmQREL3Sy/hqy2b539b3ebWah95PjTSBYvmUB31gYbnMRJIqTEx7/6z?=
 =?us-ascii?Q?6OZL2sgKgp73JDRh0nsI5SqnrZJMKct1yz8pFk7LjY/Hw68Crx8vurOLlU2b?=
 =?us-ascii?Q?Pj8QPuD1UciIRr1slIH4Xc9nI2mKCG8+1wVjdkSQhnXWliUhYw4IRqaKWXpV?=
 =?us-ascii?Q?OR3p+GZ88i8X3PE9CbzTNIYbmFpyLmSxWV9WiG//PEpvvoQ5ZAaBbD9c2lNF?=
 =?us-ascii?Q?KGR5I+xxf4K6liR1zFoFM1FE8ma4KCxevSfSQ1qjg5Bddvmt8T9ChVDFauxQ?=
 =?us-ascii?Q?TsoC5pCS7/BiezyLyv7bb7o83ZhczFJM/hDyQFkiCZM58BZEkYO78Z7HAHd9?=
 =?us-ascii?Q?tkasm3vIPCRGtR07JnxGC8pupB09hRHY3RH8Rllx9M5L/a3IWtZ2bxWm8GWL?=
 =?us-ascii?Q?fg9hqoDpMxFMtNhjZqLMxIxOaSg85r7GYzdDyD3yTLUlD7tMCj3NOE3xq8tY?=
 =?us-ascii?Q?8GYasZ340ihkoH/lr5YfJvJMi0soIW02utjQgtr127klcb26t/tOCiyRmrJi?=
 =?us-ascii?Q?zl2FmsQEfg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf0893e-dfa3-41f3-8c6c-08de57420a97
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:03:49.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPr8pQSW6xTLEjECwjO8opDTkB/NMOWQPyuYgo6u5hC+RV7TjfqEI3G3MyKfxGRNHGlG8ps5NvD1wwFHnTNRRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

DT binding allows specifying 'reset' property in both host bridge and
Root Port nodes, but specifying in the host bridge node is marked as
deprecated. So add support for parsing the new binding that uses
'reset-gpios' property for PERST#.

To maintain DT backwards compatibility, fallback to the legacy method of
parsing the host bridge node if the reset property is not present in the
Root Port node.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 128 +++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1d8677d7de04..0592b24071bc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -147,10 +147,15 @@ struct imx_lut_data {
 	u32 data2;
 };
 
+struct imx_pcie_port {
+	struct list_head	list;
+	struct gpio_desc	*reset;
+};
+
 struct imx_pcie {
 	struct dw_pcie		*pci;
-	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
+	struct list_head	ports;
 	int			num_clks;
 	bool			supports_clkreq;
 	bool			enable_ext_refclk;
@@ -896,29 +901,35 @@ static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
+	struct imx_pcie_port *port;
+
 	reset_control_assert(imx_pcie->pciephy_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, true);
 
 	/* Some boards don't have PCIe reset GPIO. */
-	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
+	list_for_each_entry(port, &imx_pcie->ports, list)
+		gpiod_set_value_cansleep(port->reset, 1);
 }
 
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
+	struct imx_pcie_port *port;
+
 	reset_control_deassert(imx_pcie->pciephy_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, false);
 
 	/* Some boards don't have PCIe reset GPIO. */
-	if (imx_pcie->reset_gpiod) {
-		msleep(100);
-		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
-		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
-		msleep(100);
-	}
+	list_for_each_entry(port, &imx_pcie->ports, list)
+		if (port->reset) {
+			msleep(100);
+			gpiod_set_value_cansleep(port->reset, 0);
+			/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
+			msleep(100);
+		}
 
 	return 0;
 }
@@ -1638,6 +1649,81 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
 				  imx_pcie_resume_noirq)
 };
 
+static int imx_pcie_parse_port(struct imx_pcie *pcie, struct device_node *node)
+{
+	struct device *dev = pcie->pci->dev;
+	struct imx_pcie_port *port;
+	struct gpio_desc *reset;
+
+	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
+				      "reset", GPIOD_OUT_HIGH, "PCIe reset");
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->reset = reset;
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &pcie->ports);
+
+	return 0;
+}
+
+static int imx_pcie_parse_ports(struct imx_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	struct imx_pcie_port *port, *tmp;
+	int ret = -ENOENT;
+
+	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
+		if (!of_node_is_type(of_port, "pci"))
+			continue;
+		ret = imx_pcie_parse_port(pcie, of_port);
+		if (ret)
+			goto err_port_del;
+	}
+
+	return ret;
+
+err_port_del:
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		list_del(&port->list);
+
+	return ret;
+}
+
+static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	struct imx_pcie_port *port;
+	struct gpio_desc *reset;
+
+	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->reset = reset;
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &pcie->ports);
+
+	return 0;
+}
+
+static void imx_pcie_delete_ports(void *data)
+{
+	struct imx_pcie *pcie = data;
+	struct imx_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		list_del(&port->list);
+}
+
 static int imx_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1656,6 +1742,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&imx_pcie->ports);
+
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 
@@ -1684,12 +1772,24 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx_pcie->phy_base);
 	}
 
-	/* Fetch GPIOs */
-	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(imx_pcie->reset_gpiod))
-		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
-				     "unable to get reset gpio\n");
-	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
+	ret = imx_pcie_parse_ports(imx_pcie);
+	if (ret) {
+		if (ret != -ENOENT)
+			return dev_err_probe(dev, ret, "Failed to parse Root Port: %d\n", ret);
+
+		/*
+		 * In the case of properties not populated in Root Port node,
+		 * fallback to the legacy method of parsing the Host Bridge
+		 * node. This is to maintain DT backwards compatibility.
+		 */
+		ret = imx_pcie_parse_legacy_binding(imx_pcie);
+		if (ret)
+			return dev_err_probe(dev, ret, "Unable to get reset gpio: %d\n", ret);
+	}
+
+	ret = devm_add_action_or_reset(dev, imx_pcie_delete_ports, imx_pcie);
+	if (ret)
+		return ret;
 
 	/* Fetch clocks */
 	imx_pcie->num_clks = devm_clk_bulk_get_all(dev, &imx_pcie->clks);
-- 
2.37.1



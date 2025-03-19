Return-Path: <linux-pci+bounces-24122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C84AA68E1F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 14:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA6A4246C0
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07BC20D519;
	Wed, 19 Mar 2025 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DJEFZAsW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF352566F2;
	Wed, 19 Mar 2025 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391849; cv=fail; b=H/hYl5/ojgUaoZXRHu9CIBHT8RNVBufdd8dZt7AMb3Ni8WgRBTgvkLMEhFAtGHiOva+XuROIrf72QS2uKP3CPuZgSvUsy6rU5uEbvcFLQ7p7h2q0PTnrh1jVF7UuDMNVM1iuZCWs4tNsbzI4KnGp68NXOaHZz4Vzl65WRjMvqpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391849; c=relaxed/simple;
	bh=OZNQd07iZb9RgG/cH1Lgn0ltPU0Zya2cWc5DX88P4e8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bbz2Wqt5R7yJ9p43XVKp68w2UAh8xfQN+ubEtuX8UPGmlE2JwsrUPXLfQ+Vp+UK0IQUbzRJjsTukn1J5ag7T6OdYVYd1cSR7/tPZ4jsknaQkjLTOlnY63nPxDRQ6FSgumFcKMA6sW0dPug/8bfFFeAisKsxde5d6pLQa+Xp19KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DJEFZAsW; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRHEvUym45xgTVbh78UhlLUjsUGL5DRhEk9twcDWqzsVf8n5DK/WRsZEpN1BNK6TaEZpwKiYhh30dUdBs7dflGIqIeIJ2AniJOZvW2mkPfAH8JkuKOoha1NLzFigHldllc8hqch0cTnxh0d0VgpZuhg9eo2Z8fFXnioJaKaK8k2uP14M9gUOn2mkhydVbuIESHy6l66F+6Hcq3PYhS1HMYFnaMUL6T82EXAKXNhWo77bTo7JRq7pnErEivuH57ctZfOYbPBiER9j9UHBqAqIyv3rCV2hsGOj1TaFTOJXmuAe5hM5TaP7Qnr2PWrXNlyYbrIUYD0ETa0VTXjp445VWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WG1FZF6Vht9BufOQWA0z5++9x2Zf0P627AoDZO87yK4=;
 b=DZpyvFn0follXhJyDl5VKY1udd8WjTKVjsPqFOTpA24ZFYtLPCFKDb854uyQTzt6hUn4CGPQL8VUy/eI2yf7ufSPoe2ZgOASss8iTeMTDqw2J1zavLSse+sJ1loCETq/H412D42JhLekp1eE0Y7bbpxIpT6v06utlt7Icy8jtFl9wdZSZK35FfOJ3DL+JcjzhHsZpS4xhE3sWeZzyautLoMQ91cdMy65ONm/OcsuVXJadoWYD0YXxeHrBk4/Ecy/+fd8/2+At4+5B218/JSPP0j9CuHfUvo0jPW/6NrIWmYGL/EPGTR/aXz/m2Fw64CMdhNzlp0R9pf/vqFtc9iObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG1FZF6Vht9BufOQWA0z5++9x2Zf0P627AoDZO87yK4=;
 b=DJEFZAsWt4h6cQcNS4yb7zEVrWesdNb6ATpv4FEn3/j5ccNmDiRH39NBvcH9g5Qoc2mcrFeg2PBHB2fr+uez8cRDNDbY7o/ZyDweudgcZCSIYPcSqt4RPd6PFKXw8HdckZvlm6tPFGt8tgLeRC1YkZBN3HNB7IH69WxiD/OCGm586dFPdUg91iy+9JWeIh/OaE5ileZ19KlPGiXGsNw+DNKVU4pzcYtsL1LjUUVxJ6fXph/QE008FgQswdhKzBTjnNd+PxTA/+SuCYOi9QxuBaxiki2OHjJ3S5wjXK4coy1sotgbg9n9vCfahoXZZ9FUhw4NmLtyBtfr3WcdL+7zUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by AS8PR04MB8787.eurprd04.prod.outlook.com (2603:10a6:20b:42e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 13:44:05 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 13:44:05 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kw@linux.com,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: dwc: don't assume the ops field in dw_pcie always exists
Date: Wed, 19 Mar 2025 15:43:39 +0200
Message-Id: <20250319134339.3114817-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0051.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::28) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|AS8PR04MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bae61d3-b787-4b60-2b66-08dd66ec1d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aDXU+XisLBRYf8KOb+yS0Q8yEa71wJPSBDqBiceyou51moaUQydz6RLwV6am?=
 =?us-ascii?Q?RddbqcO16DIHeR6dVmcJenQFk+BUdwwynia4iMesWdvqKzfoQC0bUz3F1Czd?=
 =?us-ascii?Q?HWSjE6sNTSr0LVZB2jEwQK4D8UZQnjzqhJzQM5x7+bNbqdpOW2my3ooF5SW5?=
 =?us-ascii?Q?4FLTJ1yqZBqFHxqFt30QS7ydkyz/8sc+xNzOVObAArRIa9HGgHZ89y+S8R2t?=
 =?us-ascii?Q?dXL8OJ1+ASnp1yPROjiCHMZJBr6IqrUOWSGXWi9JH5tJ3PSAYkoMf/sDDllf?=
 =?us-ascii?Q?po6ejOrdMnS9Bb6vL5tZu1zMX8u5jO0Wqti69US5pVZFKMc/b7TtoRwazyid?=
 =?us-ascii?Q?eiOcjh0KFUumEDC25TMXrwE/Knsz/xVoiaa/kNLEB2Sxm/vxYdlaeMkoIVPF?=
 =?us-ascii?Q?tT18+k0gC5KQ0OiY/IYz4b5+bUwXUAL7HHHDmBNuuUwexcxpF3DaANZU4q2r?=
 =?us-ascii?Q?9HQyqxJytYeIzitHL5cqhEoynztJmdLTSihoehxLct6cRrU898kVDvVV1jMe?=
 =?us-ascii?Q?jErZpTiNFvQBPeweq3TeO8/euljexXn15WVXqW32/zyC3bi0Ia6QD8+sb8Ag?=
 =?us-ascii?Q?xX7AGZLBQ80Ff4M0lwRh6PkqX+DWC9BuzCuU+kFHD1dsZt6h2g5xpyOfGilv?=
 =?us-ascii?Q?cjdqqoZKDvgNDLIGp/GQO8PfklzNlG6yexgfwMSZq5aeLcv+R9B5uA81kf2V?=
 =?us-ascii?Q?/qtb4ILM8VcS94al9RFyJp/nIBotfTJJWs6ptjrIJ4CvjLaotv3Ddnbaoqqu?=
 =?us-ascii?Q?rVR9txl5WhtC0nUygpoQzwJLplA47daBquuLODr0B61vE0c91/FFhigrK6Vm?=
 =?us-ascii?Q?z3q0XUcnctcXTki8kpWFUQ6fwREndmkRkGF/XBKlJuX0AGaaQJESnNJm0AaR?=
 =?us-ascii?Q?CtNj0B95ZnXFz0ssmMcImf435aRQeysNv2s61ibFiSqeTVSDPbR9n6ZJjWus?=
 =?us-ascii?Q?Il2FgEJxD5SPBn05iAKUrFycuRoVsvwE8gbIqqqpQuEurMCBZccyXBriKV7f?=
 =?us-ascii?Q?tm+9rFdsjEXuPm9KQNWr0qfj3v1Knhuqhtnr2pi7jtie014c+2iBVppgzyae?=
 =?us-ascii?Q?LKvxrGCN+IQVwYfoRTkoWWPKivWExp/7K1DgHTVY8yce+aLUTH1RWfXz6jk/?=
 =?us-ascii?Q?RuZ07LxJpAbMB3CqNVMiTWWm0SIst6djcRlNhEODO6AwNXUoJptl6pq7SL4Y?=
 =?us-ascii?Q?rSwhvJdV0gQ0Op/e7fc3ANVwWhElUo3+DbeBFLjyL66S1278gQie6iTkE0q8?=
 =?us-ascii?Q?XPKgIjAwf0QvyqiorfvPv9S6cqDebHOmjltOwW5G7dPVnh0It1xSrzqz4G/B?=
 =?us-ascii?Q?Om9sPtIO7phLRx0z2S+B76BfRnZOrpDjkCEOlHIQJVQ4j/OnHB3T2MXHxhEt?=
 =?us-ascii?Q?52CflgiS5w/I+Fg+Vx/bSkGZZ9m0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I93Jswb9j68GxC0LUxBzAjzNu9/E+E/poGbU8zNmoiQwznjInr4YEwtPMGC+?=
 =?us-ascii?Q?L75jnDENSigdHUKRHKFkN0RTmGFOsd6IuJEmtXwXcqUBfANQaNhEfGD3QFDr?=
 =?us-ascii?Q?CZDprIKBqiqlzQPigA1tlFqi2orSFCxLe3rnFJHjg6RHOyFNOM1QOXjq2K6A?=
 =?us-ascii?Q?rhmBLJv0fml3Oam4EWz28Ch7MdvB7YDYL7M+YP95vpY7P8GhwWzS9BaxH0Ii?=
 =?us-ascii?Q?18Hzoio724VrUN6PjE+fsp2SsdfNmrOgtnnM/KWdg2AJLSNAz5pihq2i8sfk?=
 =?us-ascii?Q?ulgMLnsZFUEiulFVnUeg/oj5j1dsmXr7NkM0dH8ZHNWV9PbfTAR1FeXHSRhy?=
 =?us-ascii?Q?s4Md39Rc4HJ1Yi9jvIJSZ5ZmUASuv0EtbPzRgDUXhw6q7up2gxVSVjVsZUSq?=
 =?us-ascii?Q?lHgNLBwWNGj+JmZHLL/3oxALIpf7T/rBh1xl13SqKcQkso2fMouPfuscbfJI?=
 =?us-ascii?Q?XAk7Qyd4PwiOOuE/pZyZS70IuiuB4zcZ4/3pqs/4DNP+f7b91BT1LDAbrUuk?=
 =?us-ascii?Q?4oBd+0O7ngCdXwHso+IB6HD0bcnB5EXYdb42PapU5vyYdC999uaoFSdV/pmX?=
 =?us-ascii?Q?U0+smLyROEYODI4Gf1rmSDkb/xmkcGDs8G4oXijIk6d1ey3mjpM6DhPXXXxe?=
 =?us-ascii?Q?ZM+iEfH1ETK0vCX3kYjlrLK9pj2dKnPLUxZpRg/XKgMqYl9XW4+Lpiw38DKV?=
 =?us-ascii?Q?H63cXSyswvhpkCquj0pEBw9A4vIOORucZpyUccR4mN0fSYZY9wfYFi87xx9c?=
 =?us-ascii?Q?idJ1yi9tK8km/DiMD/YjeSoErCBn9oscszK4fyPxxZ7w1BNcpis53zEHKh4o?=
 =?us-ascii?Q?cWwWMdO3z7pA84A6ptNvsC7a3dvvrv1iAqLGqs94KB8OF1bujLpw6a1oks+j?=
 =?us-ascii?Q?kCDO2vFdbwKozoVNbPYgCbNpC9BNf/azc/Ouf9CxswZPwoXOZ1FHorAA6PtR?=
 =?us-ascii?Q?9zOH+BHYkyVU4cgHHyCkFwFC6+A7VhnDtmRvDaGpbEXrq9u80P0K1qDAMsUo?=
 =?us-ascii?Q?U3298wBWy1g3JfRn5dI2vxQS9W/C5F7zK3jdjtD86rHUp5UI2AVwBLor/J/T?=
 =?us-ascii?Q?bPz1zLA3px4fOtsMX+Xs9w62OiF3PaGoTOuRvrciadg15JkmlQabbVrEtzJm?=
 =?us-ascii?Q?c4o/6MUekBp1fvg9q1Y5klBzvBqC5rRPSDAWn+XFSrYMarXCUxhanP8lasY6?=
 =?us-ascii?Q?FE3L2X/rl3HOKgRTQ3p6L5WxYtiBYbeLlqaEGcfhCmrvZV05kWR9uBjVqWmf?=
 =?us-ascii?Q?VidTFPYx3x7WlmvEkksIq1mMQN1jPJjci4KZRKF6qCpmeItEeLFLSi/Z41DW?=
 =?us-ascii?Q?rshat7J2Y7tW5X3n+1QpKrBHce4BoLejA97sy2Cx8+am2ZDUsIbHcrylZv/S?=
 =?us-ascii?Q?5bP3e0Fi7auESAn2aQJfN/zIDBKGE0B0sUu4dggKNPFNkoIl8PIsskXYUWjo?=
 =?us-ascii?Q?dfjz35LO9wytVJuD6qKJgULg/B9Skemv2DZ4mSDsl8eLIewsm4D8JKjnwa1X?=
 =?us-ascii?Q?KSxffKJe6zr+GDn7abddbrlfZj2SFvP607wMF0/lScJON+wMXmJ8Sevfx7xa?=
 =?us-ascii?Q?IQ5VkC1DGYsnnGfO6JH84JnCQzJQBtbl2dnHOJSs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bae61d3-b787-4b60-2b66-08dd66ec1d78
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 13:44:05.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EksY/Z52WCkoyASMf+ch+QFXYLAPtZBFoEaxgB5RRX4Z18QgZ4PQ113jbPk3YectQn75sWp6evY1r03H7bVvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8787

The blamed commit assumes that the ops field from dw_pcie is always
populated. This is not the case for the layerscape-pcie driver which
does not provide a dw_pcie_ops structure. The newly added
dw_pcie_parent_bus_offset() function tries to dereference pci->ops
which, in this case, is NULL.

Fix this by first checking if pci->ops is valid before dereferencing it.

Fixes: ed6509230934 ("PCI: dwc: Add dw_pcie_parent_bus_offset() checking and debug")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index e68e2aac210f..b5fd44c0d6ad 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1170,7 +1170,7 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
 
 	of_property_read_reg(np, index, &reg_addr, NULL);
 
-	fixup = pci->ops->cpu_addr_fixup;
+	fixup = pci->ops ? pci->ops->cpu_addr_fixup : 0;
 	if (fixup) {
 		fixup_addr = fixup(pci, cpu_phy_addr);
 		if (reg_addr == fixup_addr) {
-- 
2.34.1



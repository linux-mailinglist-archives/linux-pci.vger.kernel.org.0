Return-Path: <linux-pci+bounces-42929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4277CB4EB2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 07:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F77B30010DF
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 06:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06616285C8C;
	Thu, 11 Dec 2025 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gnqf+no8"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010060.outbound.protection.outlook.com [52.101.84.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7127E7EC;
	Thu, 11 Dec 2025 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765435742; cv=fail; b=VW3/ZfncQhte3nX7QN610k+gjVk4MLInu+6NRxWciCqO+jtVmaUMUcSfdMQbDc/1zQItd9IgZ8WWZXxYp/aaWPMedz7i0pipxQkTul2Wuo/GgnfFWDqnPY9W05Ix0VjhcCuNn8tkpGfe1DfbCnOu2U9MUivgx//1lh6i7CTp8fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765435742; c=relaxed/simple;
	bh=N23FRLjDLpmymcco6XfwcNFVtSOXidD4eV9Cx7i/l8c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=naalJckVhSEZzloSo3X9GbQuXOtSeYDen7Usz7jSYvopjyONNTtkmbfHtwtoXGLy7TAjahbZK9/JylQ61ZNP0PLSGomVHSvNGCO0YiN8ZDzcTZn42KO1WRAsV95RsHFF13KdnuH/BPI0E/EsIZ24myuVOzDskYcorcXwjdX8RC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gnqf+no8; arc=fail smtp.client-ip=52.101.84.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhiQScFlnucc2xlfdPMs4lLMHkEpwNnzs3ezRr75cwaeBMdZ7e21GSjvYC5iDeklIOsNLWiJDKIDlVSkGo45Kd6iOIcLJeT082cQF/jYxQWvqAeepazvl2d0HJoO3YMp+LnC98dG7e+piA6cJ45RLlevek8AV/dJcsmqNbndD7S6ITHBj4o9nKSbZEuw/m5q+Apt29HoWMNakz2Aa4jIbBAegSnL0bTVBg+hCJZeX3pKrx87m3nc86TIIh3ri3PoflNpb36oePzVschTBOubZns6Y9rzoKLQqx4MSldC7WGXoAaZjQlHyKiu+ywUNQxNTulhf8AOW1piKSP5NlRGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do6x0+4aGJNxFyLNXcDaxmuLHLq5MUdu3CmSqKyS46Q=;
 b=cSDnI0zErqzEMylSGjP4SOX8GTDW9vB24xvDRsMNZSvRTNre9zts3DLekswS13UidqfmWIGzstiOATkcUCT7UMJ734fIiseweg5Fyx4fSKFimSLzKMQLJ7mg7AOH18mflrsUciHTW0aVZORSDjpzw+EK5CDXAzY1PUmOh6vwXH2FZYQ393+SqAWn1MVlkSTvxOvF9MgW0ideZdD4BsN5oqawWc3bcHjvpPx0OWVB7Q1RFcScGkcn4qY9zogfsEyAO0VBczqobUB80sKoEg/v1C1eeViXg4QCaz3/BsqhFaetRlKwB0etA/MG8JGnFphgXqToAUegq9+ruD1Dav+3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do6x0+4aGJNxFyLNXcDaxmuLHLq5MUdu3CmSqKyS46Q=;
 b=gnqf+no8cbLsj9WmuN2sjJ8Ro0RER8r3mh9PpDgIj+toG0Tajskng+lMb5WdQ7oaMKLFPpQUIph28ZPkMdM9MX0jW9t1ZGFVmX3UVKEbWGZ5L21lCA/XqbZ2aEBdjAchFck44q5/Safyk39+smG/5dEir+9aviYWezH7kgBVhDtdhB0umOSNS7+oqgagdtHhMKGrVYjKSuM/kz0acADl8bVkUgwAcepyzsk9xAd3YW8pp6WR/Wk9F8KEkCTIUaekrmwHaKEH02tUzcS5I2mG6I2naPN2Pyf9k80GkQ428yqbUlm4qdyAc9trBXUbnOX+PznA4TV3wUBx/NrQ7SUe/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV4PR04MB11944.eurprd04.prod.outlook.com (2603:10a6:150:2ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 06:48:55 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 06:48:55 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/4] PCI: imx6: Add external reference clock mode support
Date: Thu, 11 Dec 2025 14:48:17 +0800
Message-Id: <20251211064821.2707001-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV4PR04MB11944:EE_
X-MS-Office365-Filtering-Correlation-Id: c54145d5-cfb3-4230-5451-08de38815a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nLQtylVA/MfdFjyx90e3PPO6xbVvb1TOidrquiOpcSp23RmEQR9OQ3ruLMrH?=
 =?us-ascii?Q?CM15UMBd4muhYi7MdYYCaOYQhX3f9TnWGQVg9WDeYrNLBEBnole37OD53d30?=
 =?us-ascii?Q?MQg8x42r0HfsSA8Gp3v/ZYnRd/JjcsxJaIVdVmPiqPc3dc6+FL5X5JMCk9mD?=
 =?us-ascii?Q?hehfWKA2f6J+5QWB8i70Zicz28DQyjRkCfYiYj9/9ujvgg82VDCJYBmd4PPS?=
 =?us-ascii?Q?O8C/tQv5yiG7KIZ1DuBV6zH2uvaKRBpmh0xJWwUfWgwo3k6rER68zI11asPd?=
 =?us-ascii?Q?9/gArqCwUU3S3c2cH2lqMG51om2lFHxcf2YLcC8KkV2evY2IqXE2h2M7g47R?=
 =?us-ascii?Q?0iKEedv7JvH9+J4ixg0hSgbRUyd2o9Bb+GNqNA3Ep4cHxlQb2tCifoAxCQAQ?=
 =?us-ascii?Q?ugb2y0/oNvDJo9PksoN5TbU11HlGOcqMFLSZuzj1bjrAp2UTEZ3iAd3I3thm?=
 =?us-ascii?Q?7jJDUFVnIO2UEIPxDIwf3210fNqtk2cODn1f8obBctIxQf/y4SwMK1GMIXQz?=
 =?us-ascii?Q?vq/8VIZCCwtjpVnPN6gKdgUtyn5s7m4rQQW94VIfpNB9byIKOrHsfQHul6Vy?=
 =?us-ascii?Q?DS6KUvEV8wcPJNfEYzpzVVbBkMdPTNrL3Sv6HeUlQGYXdEYwW/6ZIqjQRK6x?=
 =?us-ascii?Q?yHrS98gDjb279TeCeOhwwepx++rTG1r3+X0Ijs6pSOr3Z0VYuollKSAQXU9m?=
 =?us-ascii?Q?2fZ5so7ixacJAJunUOkDM9NAgh47ZviD0ESL1NtoRVubAa3N1pNY2l0XpLQe?=
 =?us-ascii?Q?9SS5GEVfVMfaBZml2RJYmh8t0V1r5UrApF034WbCuvugXjBMxzl6gCfLYtWv?=
 =?us-ascii?Q?7Fqh45zn1lZGE2PiOpUJxdBT3JEfduO2RYL7jxemv2jFf6EDWZUTrNf7/Ju5?=
 =?us-ascii?Q?Cllmq4dZGk937AGaSRwxTz9A3hnRWHbJaEbEg5CPl5F2MH0g37nZC+1VfiJd?=
 =?us-ascii?Q?laZOdCN9nlptiDdgK10yKANpCb/7NEnYOMBYRKBbaoSQFydmgYVGFsIZ3TWs?=
 =?us-ascii?Q?xbKy8T+WSbXPRxvohdrM5w/XzN3Zff1uamIIenMWYErHgmbn5Rv3wDp6zK5x?=
 =?us-ascii?Q?Z8EBlRdRyMdDun9bZT6xKb8bLl7YXzjwz2WiyEPbV0x7wfQMLPxpSX6O/dS3?=
 =?us-ascii?Q?gCJmThkOWUTLUSZcKRxqzizT3PxNheypJI724Yzk5UTW9I67vS0C4q2n5VFq?=
 =?us-ascii?Q?TTbAozGhSA8kHfFZP6un7+VPdPdp3Twz9tBig5FSQ0GdS1gBfpiXzaclv1Qx?=
 =?us-ascii?Q?hVgh1gIWeYz2rxBkQjYolRv8gQMtz91Jt8nZdta8CXTN8nf/gPQRZA8s6fGH?=
 =?us-ascii?Q?aRxVczU6uFObb4AOcHLdneiHWAv1u05JZzC6jWS/0KHfx/UjmGHpXtmqkfRe?=
 =?us-ascii?Q?Dz1w9rI3jiQr+d+9vT/5ffoUmHyU36GLnxZT/k6ppo/aRorMA7Oh4kXnmXf/?=
 =?us-ascii?Q?1rKh9xnX3bO8duStODZm+g0Sx6ErAP4iz0o0FImEnCjCwRJrtGVf2G+xxEzw?=
 =?us-ascii?Q?fFQDhyiEBbI34SQNvZreXCslzuZB3m+yV8jpzi67CAtyxP9ccPolw5rO5hg0?=
 =?us-ascii?Q?KlEe9D0rgbS9QfQ2km0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6aSEm/7ws0ZA71ZzbAtj2bzk1+v/pm+tweB3P2h7bZDgOPwKEB75tmBjdRkF?=
 =?us-ascii?Q?whrn4VsLgDB5ny+fiIPRf+HMDEN+uJt4xhA0O765YjieTAwf62OofMkmM+1e?=
 =?us-ascii?Q?Q/gZmi22bp9Viq4ZEop2BCwKnlPBfMaeLNTxXhV5sfY5a6wIXAOCtfXBDMvK?=
 =?us-ascii?Q?8CNGClP0YtZhEp7Gvm3qE9uEChsHR45G1MQotAgYtyLMM8XEmtAA2EEF/Ljl?=
 =?us-ascii?Q?6OcUFaBkOviW8nLpZOtw4QH5FA4GvO+vLyuMwWDtT4+jXIsvuA1OEtRiFhad?=
 =?us-ascii?Q?voy4M69iYSidFwGZRYzbolDevi6xJ72d6R/VBrHMV0GlTcXBF3hdilAv1Ogl?=
 =?us-ascii?Q?VexbYwGl1iGJ5fjwaWnLJJVOjMMVGHEuOjUlz4mUYpnlcfnOJ/Y6F+dYWvec?=
 =?us-ascii?Q?3JM8U/5KW4ettR0+Xcn2yj6tn4hVdYYAlyy7cAORCvobBPVUSlfu5w1XVdeq?=
 =?us-ascii?Q?lT9kY1WG6/oaKRsdTis+hqp0V+WjsdCipLhYGZI7WrG+xPAKPXO+y54qRjJa?=
 =?us-ascii?Q?4Ddvh6AS3f8mhrvHIql/6OVBz2zQiHVPyaBcGlA9QyztWtZqL9aIFLjpK9jV?=
 =?us-ascii?Q?RDifqS7/z4rW8mxxtqDvrpqTAyvJEMG61Ro2w4BF3LGjh8AUdEbYxWpETN8H?=
 =?us-ascii?Q?S2PClxds9fSp9uOR9S0PV8+uoGqqCxh8uZbamcR7IUz2Boc4q3KjjlQ/ZCmx?=
 =?us-ascii?Q?iRxFcJlw1yVWq5ZWcHk5ms2xDgksSyHo4hsXFCiA3oYiHfScpzTe0W8MoOJu?=
 =?us-ascii?Q?9oxxZpvuNn1P/AHey1SufcsgkSJ7Bhy6LpgTcgjuOt7UeQgqf7BF2zfY3ath?=
 =?us-ascii?Q?Gr3+YuK6jID+ZavOkvV4frJZiHYjHeOJ9W035ihUpkLul6aaF3kjCyRYnGrb?=
 =?us-ascii?Q?ZdbH7W/MrscWNUzzIZv0sz1iFeC2Oq3ZCGMAnqx4pQyEZIN9rJM1IE4ICIxu?=
 =?us-ascii?Q?HQFZMmIPo2CFxkIr5uq5UkZY4JVtSD5VoxmDS8P5hyZJVRZC3U4hcuqaruAS?=
 =?us-ascii?Q?LsahEuT7yaDZ5a8wbttUoQlgJwGi95t/nO3bQWmwCsJ8OWy07viq9J0PVnOS?=
 =?us-ascii?Q?Rk39Cbgs+OymOusxBUx/E5nlkf2S5il1RysjVm+2TuDbvCOidjQm/gkQTsFa?=
 =?us-ascii?Q?AmKwW47nQSD+6AlQBwKMLsrJitODOduImW0ObdjA/LRJo5CPjRoKeY2OWIdI?=
 =?us-ascii?Q?e4bzJ4lSEQYWqrGP25qCfD//BqYTDmKVsYYJtHRrCUSSMrfuY6STnzMezDKF?=
 =?us-ascii?Q?Y71qNSefBuAns6N6djYkrw5ufJTdfzXbnUla438MHT5K8i5rPyhAtY/eIvA5?=
 =?us-ascii?Q?e6SZjlyElcXpUb3qoTJrOACPuG3cmE4J5bFBlpvydw9M+qeryTXwENKW2ojg?=
 =?us-ascii?Q?Q21LJ+nH3ce8prbnAWnKCunDIYFkl4MyDzvGrWBwb/BmcuJY4ddYMFqsGsiD?=
 =?us-ascii?Q?X+VIZNRCICeqrJHW/x1VMJbtIDr1XF1GZKBXn0GD2LWLF1u6URl25nLuvf4G?=
 =?us-ascii?Q?5RM/6kBtOuN1HU9hkaUIKAeJPVJJeHjX04PTq53WEvl+JPYk0Dns9azRPG5k?=
 =?us-ascii?Q?XgG383M4Rvb1nx50HxXEtai8K2HNOQyNwYRWLDn5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54145d5-cfb3-4230-5451-08de38815a96
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 06:48:55.7198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xE4hCZdJI8Hz/XXMU+hAatiLxkSUjf1n74k6l67pI9zH0UwaZX+TwII3ei39R/UyS0EWOOCbH6DKGT+8QCCXHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11944

I'm really sorry to send this version patch-set late, because that I was
engaged in other emergent tasks in the past weeks. And didn't have time
to continue this topic. Now, I have chance to continue doing this again.
Sorry to bring the inconvenience to the patch review.

i.MX95 PCIes have two reference clock inputs: one from internal PLL.
It's wired inside chip and present as "ref" clock. It's not an optional
clock. The other from off chip crystal oscillator. The "extref" clock
refers to a reference clock from an external crystal oscillator through
the CLKIN_N/P pair PADs. It is an optional clock, relied on the board
design.

Add additional optional external reference clock input for i.MX95 PCIes.

Main change in v10:
Thanks for Krzysztof's kindly review. 
- Change the miniItem of i.MX95 PCIe clocks from '4' to '5', since the "ref"
  clock is not optional. Update the commit message to describe why an
  additional optinal external reference clock input is added for i.MX95 PCIe.
- Add a new patch to fix the dtbs_check error after changing the miniItem of
  i.MX95 PCIe clocks in timx95-tqma9596sa-mb-smarc-2.dts.

Main change in v9:
Thanks for Conor's kindly review.
- Enlarge the maxItem of clocks for i.MX95 PCIe.
https://lore.kernel.org/imx/20251031031907.1390870-1-hongxing.zhu@nxp.com/

Main change in v8:
- Rebase to v6.18-rc1.
- No need to initialize bool parameter to the deault value "false" refer
  to Mani' comments in v7
https://lore.kernel.org/imx/20251024024013.775836-1-hongxing.zhu@nxp.com/

Main change in v7:
- Refine the subjects and commit message refer to Bjorn's comments.
https://lore.kernel.org/imx/20250918032555.3987157-1-hongxing.zhu@nxp.com/

Main change in v6:
- Refer to Krzysztof's comments, let i.MX95 PCIes has the "ref" clock
  since it is wired actually, and add one more optional "extref" clock
  for i.MX95 PCIes.
https://lore.kernel.org/imx/20250917045238.1048484-1-hongxing.zhu@nxp.com/

Main change in v5:
- Update the commit message of first patch refer to Bjorn's comments.
- Correct the typo error and update the description of property in the
  first patch.
https://lore.kernel.org/imx/20250915035348.3252353-1-hongxing.zhu@nxp.com/

Main change in v4:
- Add one more reference clock "extref" to be onhalf the reference clock
  that comes from external crystal oscillator.
https://lore.kernel.org/imx/20250626073804.3113757-1-hongxing.zhu@nxp.com/

Main change in v3:
- Update the logic check external reference clock mode is enabled or
  not in the driver codes.
https://lore.kernel.org/imx/20250620031350.674442-1-hongxing.zhu@nxp.com/

Main change in v2:
- Fix yamllint warning.
- Refine the driver codes.
https://lore.kernel.org/imx/20250619091004.338419-1-hongxing.zhu@nxp.com/

[PATCH v10 1/4] dt-bindings: PCI: dwc: Add external reference clock
[PATCH v10 2/4] dt-bindings: PCI: pci-imx6: Add external reference
[PATCH v10 3/4] PCI: imx6: Add external reference clock input mode
[PATCH v10 4/4] arm64: dt: imx95: Add the missed ref clock for

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml      |  7 +++++--
Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml |  6 ++++++
arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts  | 10 ++++++----
drivers/pci/controller/dwc/pci-imx6.c                          | 19 ++++++++++++-------
4 files changed, 29 insertions(+), 13 deletions(-)



Return-Path: <linux-pci+bounces-13302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C555B97CF13
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 00:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470DB1F21250
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 22:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B31B3748;
	Thu, 19 Sep 2024 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fxaUeYTN"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ACE1B2EE8;
	Thu, 19 Sep 2024 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726783440; cv=fail; b=m225fZW1TKPWwqJoxW4KUmbj+mWhdLtPcgMl5zb9qcJr7V/75PR7KHbcV/3RobByEL/pzBNQUfwzig44OBNqcm2S3G+tLB7u11SHHjgsQ39Jo8aoSfnRPjI0jV/8cycN8UWjV6z8b3H5ohR+Jb3e27535c86v5ba18HJtZQplXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726783440; c=relaxed/simple;
	bh=pqmHLOp270r3Lg0dZcu6Ad8vOAObt7oeCavzpzR28l4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D5sH+znWx+N8V+liX1ISzwPZFo7VH+t2VtfcYHdT4p0L6Y1ZXABf9fQCVBwSbpzuBFGnmOa+zewzuOm/rWB57Qv/RMb7rbIl/uyHzEU/h/LaUrNXsjK3Uw1TfihdMQDthLdE9mr/yQGGQ5Cxnktf8eJHvSdIJzLdp3Dbo8AsV9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fxaUeYTN; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=no2alClRqpyd9TffVnBNIP6iash1/idYBZ3TMZPBbHSa63PKtQCgUrBv2rXwgWAgqRVR1fHCfbJ0mti/c9AZi0H7ORSwM+YhiMTLIrG3nAUnm09XYlUdk1O7TozZh2CgVL6bKTP9oZ1cJb6eGnzS5VZk9B4Obgj7N60a1V6o0Q5goemQyLoYkOjN46oXEp9NnE3suoueIFOFX7c9xfP5RqTsNELlMDCjW+bVjx9xgCShI8mkXiXuDeF18XkYIVaNuZuChosiyyOQV36rK+09jlkz0AG0zF7dXUaxyz7GlP0suhxpcNGZinLUrZ9jredk+yyYriYkjAACrxzg3YpElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QROpkGzwVN6caHukFab/T91TO4qYylTTgKvj7Kefc14=;
 b=fUP6Wy1sMmd2WfNDfI6zKU4eZvdZggVbuLFgueY5Sw+5G64stXbKsvL6KqPIWNCC92Fxs8/sCRLJC1Tfikv9Eoq6vRMhLBv8wzHBvvAasVFJd6qQLIC76ZmdTtsyVDCNKo5tks/DDsmDQM5kcMgdeWqwAnB+505s3kyxOeez5R//wE6YwVXBWo4HiNzxaDwC0F0jOJMIIbCG6PO5T0IsR9to6eq2WoIc2NwzZ+woxm3PghJ869s0NBBJi27jTuUyNu8XAtn4FmQdsIo8zNqXX0qFGpkZt8dOurqbqyIrqXMokEcfFU2pIjVDVo/dEHnft38tysbRNrZ0jXcqJkExIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QROpkGzwVN6caHukFab/T91TO4qYylTTgKvj7Kefc14=;
 b=fxaUeYTNTP/sGtuWgLykX3DUYIpiwOsSo6JMGA2hYXLm4VJv4vuikZ07QboFN+/6NcRoxcRmoaN3PnP7U372TU9NfhYUOQX/uyvTEqve8wmP4WyXSKLZLfcO7SCUJj94Dw3ChawH3KEtBqJXGpHtvRBqhJyULUIOKhvRouFkg0IBU7bsYGdPsVe2X3mvuBTLz+F0obUwPBml1Y84aR2Og4HtXqGiid4/gRd25ADyzIm5OuL201weWcaqeVt/RxlUjbpph8vK6KN+ZUDlIak+JbhzjqL0NGMbAILgaBVlGAPUM1fMy5ofqKR6T3nXpw/Mbkqb8I7o6PjKPxMq798KfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9849.eurprd04.prod.outlook.com (2603:10a6:150:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 22:03:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 22:03:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 19 Sep 2024 18:03:03 -0400
Subject: [PATCH 3/9] of: address: Add device type pci-ep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-pcie_ep_range-v1-3-b3e9d62780b7@nxp.com>
References: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
In-Reply-To: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726783409; l=2478;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pqmHLOp270r3Lg0dZcu6Ad8vOAObt7oeCavzpzR28l4=;
 b=YANOTCiuI/shJqjrJ9FMH+UFmsQ5Pjz7U44rV4eeX5yQXPB0Vt5QptcXtKGvSf+a+4TlFgJZ8
 2ZKa6P7M/FfB655Yt89iT+NGfw+OacYtUG/6T2aNYf4pHYfdrt6Fag+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9849:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c991625-c0fa-4009-0b15-08dcd8f6f335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b04zTlZCTjEwQTdFRThZMGtvS085OHFGdmloL0xxd2Yxc1dlOTE4eHlzVGtQ?=
 =?utf-8?B?WlIyUGtqbzVNWHVRdzB5K2lQdUV6WXk0MnhIRENzVUloOTkzYnpERnVidkI0?=
 =?utf-8?B?MTRyM2M4RFhSVkhiRVovSHpPR0VJTzBvaW9OZWlyZm81a3BEdjZYaGJKUFYy?=
 =?utf-8?B?MktlOHE5WVZxZUxTUjJId1hCVCt6c3Rhb1RNRlpPZTJnVzhna0ZPRFY3SDJh?=
 =?utf-8?B?cnZLZkR4VnRQd0hibGUyODF4UFM2LzlpZXhacDhBQVUxU3paTnpkV1o4a2Rt?=
 =?utf-8?B?cHBWK3hJREVrSmVDWTZZZ1Vic2lYaUdodmtrS05nYW9sWDNiVm1WVWMrdnpX?=
 =?utf-8?B?Z0h6Q1RTZ24wamduQ0t3MG0xSHYyRTJKYzQzMWpmNG1LaHZISFR6TDhrbkFz?=
 =?utf-8?B?L3M5ejg2WkRDN09HMk1rNmExM3kxalBKdjRwc0FpeEhsNCswbCtnS01RdmRH?=
 =?utf-8?B?T3pFbVg0aDExbGtiS2JINlRIc04zMlEzWU1WajMxS0tGcmJnTnVabWhHQjBQ?=
 =?utf-8?B?REl2SU5uWlAzRHFmYUtWWG1nVXZQalAzcEpmdXRaR2NuUjlTaXZFcUxVWTI0?=
 =?utf-8?B?MmcveHdWMUE5RHYxcWc4SmRoR0M2bGRsV0szQ3Nwb3FvSG5MY3FaRzA5VEhl?=
 =?utf-8?B?WWlMcko0c053SmdoMjZZdFE0K2dVSHhQZVVDNG52alo5UndETG1JTWRvNzFT?=
 =?utf-8?B?QUovTW15NUdHNi9WeUhJTHhaOE1yNk9seGh6YWs3Mkc5RGkvYWRBemFZSzJz?=
 =?utf-8?B?c0hUUHlGa1orUk9xdUhPdVN2encrM2RmQUhkRklCZXVBM29NOTNyUnFCVjNl?=
 =?utf-8?B?R1ZHZXgrU0NLUTF2dnBhT1RvQXpldzRNd3lYRUtDTCtGQUpSeG5iZm5TZmhI?=
 =?utf-8?B?MmRLZXgvV0wxUlFESVNWL1B4dVJpMllBOWxXWXRHcHJvYWRUdkdaYjlDcENN?=
 =?utf-8?B?QUJjRlg4ZmpXVG5PbXp6cHdpN2QwQUZKVFVVVVNyTjJSS0ZNQnlMRGcyTGk4?=
 =?utf-8?B?Q2gyR05ZSnZCMERPbVB0TitodFZvVFZzeEluS2lMS1VKNXpqMFJTOVFLTk9K?=
 =?utf-8?B?SFovZ1NkY2w0d3JxRFJzTVdYcUhZcDZ1RnRmdjdlalliL2lET0paQkpZL0cz?=
 =?utf-8?B?MWtaTm9oSFBuTi9NZ2V5Z2E1U0k0d1VtUXNlQVNKQU52NGZicE9aR3BCaVRw?=
 =?utf-8?B?T096OWJiU3FLamRuL1BBRkNvRGQ1bW9ZelBzVzA5ZDNTVGozL3g5aTUzRnF0?=
 =?utf-8?B?WXllZmpKSEQ0ZkVxVWZhcFAzVy93Ti9Zd2daTk52bUxuM2Z1dFQrQ3ltM01o?=
 =?utf-8?B?a00wNE4zWHZFTGp1dWt1cjk3UFIyTm5TcXRlL3Rpc0JMM2JmMk80blVJaGQ4?=
 =?utf-8?B?Q3ozWDZtdnFMdmFVcWYwaklUZ0ZESWxEYjloM2RXQVh5RkhFMktVVStPRjBm?=
 =?utf-8?B?KzYzL1VPbFBBYitibjhVVytHRVU0TVR4UUtVd2FvTFR5R1hHYUpteVB3WE16?=
 =?utf-8?B?U1RwOWU3K0tQd3VOd3I3RTc3MzlzU0U5ZDR2VURuTVgwOUdaQW5uS1hwVFVR?=
 =?utf-8?B?alZMTHFlUDZaNVFxeTVjMjIwMHdLVG1ZMVg0d3JUVVBGS2xVb3VzcmxLeVQv?=
 =?utf-8?B?ckdZaFc5VU9TUE0remtIeWFHWk5JZUZsSWJORko2ZDlxdGhZRHFDdjNiMVIx?=
 =?utf-8?B?SnRINzhFaTBwNWNyeXZEZ3NhOUxJN3VMUXZnVGJ1b1NuaS9MR1lOaG5IbXFK?=
 =?utf-8?B?Vjc0S3p0eXdvdjYxNlJjYkcvU3g2eFV2NzZyaDRCVG9zUU1QbExOZy85OG1n?=
 =?utf-8?B?SG9ZS2lkcjYzTFU3cmNLU0ovaXgxZlpZNnQxdXgwQ2wvdEtzNkQvYUZ2K1Qz?=
 =?utf-8?B?d2ZpV1pWbmlSZ2VCMDArRU5Mb1hTQWtLcmdpRHgyTGZnam9NV1hvSFdJRmVv?=
 =?utf-8?Q?V3BTeEX+P4M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDhYb2lWdW01WHRiMWNsSVFQSWRwcXp1c2Mrd083cmF2WFVGd2FycndOOURU?=
 =?utf-8?B?Z3pmVFkwblFpeHZ1MmNmL20yVHo3bjllRjlMVGQrTWlrd2dsYXlsL0thZUxk?=
 =?utf-8?B?eW55NjFncVdyRlpOK0Y1cGc3K1liV3dENTNZdVh4SVA3bkRiSWtaMWFiNXZ6?=
 =?utf-8?B?TUwybWxENUxKUktpMTIzN2pTMmJPVGxFeXlYb2lWOHFIa2NHK1FHeFhvRWN2?=
 =?utf-8?B?SDZ0S0ltZGV5L2dJb2ZKNzVXM3g5SVBEY2NjMEl0emQ1eFFKVklZSWFUWFc0?=
 =?utf-8?B?cnAvTUhLajZGL1M3cHZML1VwaGZmRTEwbTR6emM1aCs0OTZQMURZb3BXTTNS?=
 =?utf-8?B?aFl5K3hwUThaZzJQSDVMSnVXM0dyVFloWDdEazFPM1BETEZOMUlxcm53UU9J?=
 =?utf-8?B?dnBSSk9EVjFvdTZIRzVVQ0xKc2h2ckpxUWJIN3NTUVNwU3FDNUJsMWpscG1r?=
 =?utf-8?B?VThDcFJtYXFlM0phMEF0aEdDWmlFNVoxdENkN3VJbDdaTXJJWXZHNVVTVWxh?=
 =?utf-8?B?am1NZVBHaDVadDhSbFdneEEzMmdZRDVUV2xNTGx5Q1ZXY3VkR2RMaEk4R1ky?=
 =?utf-8?B?V0FSK21uYlNCYytGT3dLWGJLd1B2RXZ2VklaeFlTUE94ckpIeFEvdzg0S01W?=
 =?utf-8?B?bUtweWVIMUV6d1VvQmZOTHptMG8xdUJHRTdzTDIyQ2dDSVZnTi9weitlV2Vr?=
 =?utf-8?B?R0o0K29Ic1VVQkl1NTJEbWc3c29ZYmJhSDZZNWdNMXRWZDJvSEV5K0E2ckV4?=
 =?utf-8?B?QThZQWUwODQrd1o5MHBRb1hZL0FXYkZDbm5oVjl1N2dBVVJYWXhQM0Y2di9p?=
 =?utf-8?B?VUYwRVowSFZ0dk1TaXkza2Mwb3lyRk5FYWQrZFRhQ3VINmVKdTVYak5xbUZU?=
 =?utf-8?B?dlBLTWhkQlpHRENFR2VtMllkVVFuYzg4TVdWK2lFemVzQlVSWXlKbWQySkty?=
 =?utf-8?B?czQxU3pBOXJacnVHaWJGbnhXTFlTWGtOZnUwbHlZQXhXQmZnMnNNUzdRTGRU?=
 =?utf-8?B?a2JtMGM5WTlnYlBUR3Baa2NJQTVjR1RqQWVrODBEMDF0ZjIvQTJOclcyOElh?=
 =?utf-8?B?ajZ0ZWt0WXEzbWxybkVoOXdOcWdzNEZJaHNnT2dKSm1hb1E4YURaQkN5QWtv?=
 =?utf-8?B?WWJyWElmODc0SldQQlBkeGJQTlY5L05ITXZwUGZrZGxqK2RwQUNraFRxYklG?=
 =?utf-8?B?em02TmljY3FLd3V3ZUZoVm9ZZHlEMTlzTS9OVG02V1RoODJUc28zSm9NZnd1?=
 =?utf-8?B?Vjh0Zy9oM1NzSm9vdEdlM2grNGtyRnNHSS9tRUZDWUU5QVV3MjRuQmxGa2Zy?=
 =?utf-8?B?dHdDbkJBYm8yeHpIY285U0VaZ2xMMHV0YmNQWjMwbUtSR0ZXQ1dQOGVlSElB?=
 =?utf-8?B?ZitCQnBNdzF6cko4U3hMbmxoTEE1aEVGQm1nZ2M1UnN0dFVpNHRuUjlnNEVa?=
 =?utf-8?B?WFAwWDNLaGJRQVNnMURYRVIwNVJYalBTVUpMZnF6SzJqU1grQUR1VWQyajBY?=
 =?utf-8?B?Q3BJNjhpa2JqeFpSSkJHdVNaV3JJcGFTNmNwbzluSlR1KzE4NmptbU5kK25T?=
 =?utf-8?B?SmliSW9EbS9jUS9YV1krV3NQcnZRZjFsU240MW12OTlLRGdQdnBYQWMvUHly?=
 =?utf-8?B?NkM2Sm56K21Dc1JqQzdtaU5vQVFDdHhHaFJocHpFU2NWcWVZNnlidlp1U0VG?=
 =?utf-8?B?ZXVobTMvckNVb0p1MzYzK0pBWm5aZlBITnZ3QUlnMnB6UXZjWWRQWnZrNFFJ?=
 =?utf-8?B?VlhONEpYakY3MnlscFZ5TnQrU1hsRHlSNTltTllXM1MwdURyZjdidHdxSG1l?=
 =?utf-8?B?cSttV3ZlbmNqbFJzRXVjWWk5VjdndVVsd09sRkh1SjIyZEl6TDFNREJPNGta?=
 =?utf-8?B?b0pKZnY4QVgyRXNSZFlZM0hHKzRPZ0Z3bjluQ0lrdzdhcG43QisvT0NtdTJT?=
 =?utf-8?B?cm1waFdJK0dHNkVWSERnUXBVNTgzb3VEVHRWMWtYai9DWUgxMGxyTnJVdlJ2?=
 =?utf-8?B?QXBwQ2pQM0pubkdYNTZmMU55ZUlNL2ZzaUNXLzh1ZU5sV3RvSW9OelkrUWRB?=
 =?utf-8?B?OU43V1dnZDgxWnFNU2FxOXF1QnZQRFdXbGlnckxSODZ4M2FYR3pIMXpnSXlD?=
 =?utf-8?Q?/fBvvwAPuvzRRicVGEz9LDMN8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c991625-c0fa-4009-0b15-08dcd8f6f335
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 22:03:53.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvaPKQcvn42W9ReyXO44uOh8Xafk6c+XLS1fdtxDkob3YrvN8EyHfLWuMQgREbHsF9+ZyWrkwAAwIhVjKDztug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9849

The PCI bus device tree supports 'ranges' properties that indicate how to
convert PCI addresses to CPU addresses. Many PCI controllers are dual-role
controllers, supporting both Root Complex (RC) and Endpoint (EP) modes. The
EP side also needs similar information for proper address translation.

Add device type 'pci-ep' and use the same PCI address parser function to
parser PCI EP's ranges property.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/of/address.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index d886f16df8a6e..c98e212d53dc1 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -117,13 +117,13 @@ static int of_bus_default_flags_translate(__be32 *addr, u64 offset, int na)
 	return of_bus_default_translate(addr + 1, offset, na - 1);
 }
 
-#ifdef CONFIG_PCI
+#if defined(CONFIG_PCI) || defined(CONFIG_PCI_ENDPOINT)
 static unsigned int of_bus_pci_get_flags(const __be32 *addr)
 {
 	unsigned int flags = 0;
 	u32 w = be32_to_cpup(addr);
 
-	if (!IS_ENABLED(CONFIG_PCI))
+	if (!IS_ENABLED(CONFIG_PCI) && !IS_ENABLED(CONFIG_PCI_ENDPOINT))
 		return 0;
 
 	switch((w >> 24) & 0x03) {
@@ -172,6 +172,11 @@ static int of_bus_pci_match(struct device_node *np)
 		of_node_is_pcie(np, "pcie");
 }
 
+static int of_bus_pci_ep_match(struct device_node *np)
+{
+	return of_node_is_type(np, "pci-ep") || of_node_is_pcie(np, "pcie-ep");
+}
+
 static void of_bus_pci_count_cells(struct device_node *np,
 				   int *addrc, int *sizec)
 {
@@ -196,7 +201,7 @@ static u64 of_bus_pci_map(__be32 *addr, const __be32 *range, int na, int ns,
 	return of_bus_default_map(addr, range, na, ns, pna, fna);
 }
 
-#endif /* CONFIG_PCI */
+#endif /* CONFIG_PCI || CONFIG_PCI_ENDPOINT */
 
 static int __of_address_resource_bounds(struct resource *r, u64 start, u64 size)
 {
@@ -354,6 +359,19 @@ static struct of_bus of_busses[] = {
 		.get_flags = of_bus_pci_get_flags,
 	},
 #endif /* CONFIG_PCI */
+#ifdef CONFIG_PCI_ENDPOINT
+	/* PCI Endpoint */
+	{
+		.name = "pci-ep",
+		.addresses = "assigned-addresses",
+		.match = of_bus_pci_ep_match,
+		.count_cells = of_bus_pci_count_cells,
+		.map = of_bus_pci_map,
+		.translate = of_bus_default_flags_translate,
+		.flag_cells = 1,
+		.get_flags = of_bus_pci_get_flags,
+	},
+#endif /* CONFIG_PCI_EP */
 	/* ISA */
 	{
 		.name = "isa",

-- 
2.34.1



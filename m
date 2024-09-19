Return-Path: <linux-pci+bounces-13308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CA997CF27
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 00:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC854B22E38
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 22:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548611B5303;
	Thu, 19 Sep 2024 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dblvluHU"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540C61B4C5F;
	Thu, 19 Sep 2024 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726783476; cv=fail; b=LzjHdIgkRPgZ2P9ugasY3TAvOh6b33dOV5qZ22e2JHb2/6e4zx/VZDHtoGQpfA3eIGSMrajNhip8gUglDI+zN+FcUd4Udf/fDdUQaHLvkpn6jO3hVpPRsRdY6Zf/ZQoJzhtYdW9TpVGPn65TEGSb2je+yCkY6Ly3tJf7F2V97gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726783476; c=relaxed/simple;
	bh=3CxHSPzOMZdooiHhXBbUJeOq+L0OzXqE4BV6aNSmV6w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nB2mdTQOecw8+EqbHMr159+NwpJZD7dfvJGnwESO4wlvIa2rZJeAj26vLauUCdRHag+yXAz2rHcTNKkdxPpHal86PnnAXI8TcrLgCFJ35d7cD4xLTGdbfI03Ue70GwIWifu84bLax03Xw5mYsd9XEDLqOpGqT6KlwRpCUN8nN5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dblvluHU; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clbKMLlrdDxV7nDbcwjsq9xfqj+ELuoJOpHO5KeicsRBiMKuxG4tSgRGeyYgY9KPClbDT/EwHuHJiBb1Lm7/ScsCJyCxfTtxtIcA9nfUIY/GWHJ9yzv2DRD2NCsEaRLyY7KlCMUFI6tTjydY3Up+BVpXVwHVdUv9YCBnPPIGSr+Nfi3+pg7AycGIxo0x1RO8RwY4hTkfCJHUB6AjBDm/lXaw2Bt965+StGnVjNsfTuYnymSe9kkiqAJPGJ4DnJsW5pR85gGHMcFmU09Fx5Zua3LxSxpJz/1wpGJd1UE47la5HVNHh+AZp5qnS6B1ucm68f2+e4yJh6e7MlklSTKfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TI/+hz4zadbRPbk/iDobP7lBSIpozrAa1jkmXmREWUU=;
 b=cjcAwYctPBqHLgsjoxVu35MGtLUzc3tTu7ntIt8kQ3uI3DQpsYelJs9/7l+qBgLQOBXXcypdUcIc3Ryl/LoJCXRWg72L0ZAJ5upLpfhN81vCx8v5JRdG2uSxPRKeAtpDg6yjGA8e57IvfCYNIgnZCS5rfzks5zQnX1UQ/aJ0A14VdWO0VCLzcT/ZiriwwEZ7Y0C2OkY+t0QQFgXtmploN79aKmJKxGGCZObtYUNZqTM792A6dbCiVuvhOb31nvB2uPrYTKxagkpWLCdXmpbLJkjWYXSbpiOZnQV+OhjawKayfJcgv17Puq3DOCz1iT0Jn2cQ5hcUR9S1Teqbuvd+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI/+hz4zadbRPbk/iDobP7lBSIpozrAa1jkmXmREWUU=;
 b=dblvluHU4Oo8Ypr94/ZKBxEx1ecF+3DE9owxQYOBmzNjZCOL7+smGwuVLsdSWuSrPxFUTqlFIwpLe+kpVg8ooHYXblcq1GRFlhJWZIUzTajwZL/OXBSJlr2dMShSLY4GL1pP8SD6IVnex/UV9ifikrGbQhvJOrSLgMylZtCBzMmZM6gRHBgIhQt5I1ogYZ5BdBQ25LONVfQn5fkaC3oZEAKQW6/mhy3bpWMUFvcnxqYo7Igi3anQ+sbpLWArsvGBlQjWw0yz2Mt/ApgaXbCM8jwPgtWHRt9GDyCNvO+Tp10M15bDepeWtW+QLMITmqP9DySvjyGTXg627roU92q/yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9849.eurprd04.prod.outlook.com (2603:10a6:150:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 22:04:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 22:04:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 19 Sep 2024 18:03:09 -0400
Subject: [PATCH 9/9] PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-pcie_ep_range-v1-9-b3e9d62780b7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726783409; l=2369;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3CxHSPzOMZdooiHhXBbUJeOq+L0OzXqE4BV6aNSmV6w=;
 b=0nELTgmm7NYH3c0iwq01NuI/BzkMh1HQYQ0c4FpHrbs4t4Eyl7JQUfoVJauL8o/hlWr8DxmAL
 ouCcUNfHf+NCblLtizXrBtgxv9Fyux+SjzEWOzhBhaEy4X68ZT0+Fdh
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
X-MS-Office365-Filtering-Correlation-Id: 6e832cc8-947c-432d-484b-08dcd8f709d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGdLZlV1OWtvRmtncnd1SGhDcVpsdnFOOWl5MmFhWG1wa0g2MlYvSDBQSER0?=
 =?utf-8?B?Z3NNR2F1eGtuZ0ZLZGdkRW1TNjFwWEMwWUtaQi95NmV1SE45L0lpdlZTVU5M?=
 =?utf-8?B?eVpFeXRPak9ySTJSYVlycy94WFc3VlZ3SUpUUloxejdONVMwWk9vUEVpNUdo?=
 =?utf-8?B?SDVveVNmQ1JndUdDMWduVDB1Tm9OUnlLa0t1VzQzM29oSXg0TGRnQ0EwYmx3?=
 =?utf-8?B?K1JaSWVneElKQzRpbzRlYy9JcGZiWmEwVEVvdDNPOGJGaWVsVzhrTXA4Ky9r?=
 =?utf-8?B?SE9aQzkyWVFjT0RpZEVBRC9vREx0SG5VQnYyUDBVSC9mTVVnSFlsOTVFekZN?=
 =?utf-8?B?ZUJ4QThrMWdYMXJZTHFzeHZDU2xHV0lXS0hWOHJLYXp3S1VKaEFqMVVRVG5X?=
 =?utf-8?B?TjNPR2xCbndoRGpkdGZkbWgvT0NoV1h3UHp6Vzd5c3pvZTFkZXBPUzZsRGVk?=
 =?utf-8?B?NzBYK1Rwb2ZFWEs1QUQxaExoZGh1NmFGcGpTMXIrS1lqNlVFVkhEdVVhbjAz?=
 =?utf-8?B?bDV0Q0ViQWVoa2d2SVRhVjYycFQySjVNS0xvZHdTUS9yc0lOUFpNdTJKRVlv?=
 =?utf-8?B?dFNtbU1pWFBEbEVMKzFEYWpOMmhzTmJhL1lLeHd2L3A2MjBBSThEeHdmc1Mr?=
 =?utf-8?B?QzlvbE0yVXZOK0RQSytlVkhzVEJwaHM5QUdXSURZWlN1a010MXVQdzVEQnBs?=
 =?utf-8?B?bjRmVExnVmZHdU5xZEJJMkdkVUZkbjQwZmlHbG01WGltTFFvbHZKWmg1Zmhi?=
 =?utf-8?B?WjZheVJMOHdpWE95T1lFVmF3TU5jVlE1enpVdzdUWllqOFBFeUZieGJVTG90?=
 =?utf-8?B?WWEybjYzVnk0QmxIWm8zNWtnQms2QzRibGhVS2JQVnFOZjFVY0x3OTJ5OXRa?=
 =?utf-8?B?c3Q2dDBrZ3prRGdYMnNwZHZiU3ZZcC9sSldVL3dzZkM5ZENEbEVrOHVFa3A2?=
 =?utf-8?B?bVRCYVdCUFg4RGFjamY0U0l5UjFwa3dWR3FIMG05dkNtUFdnWlBLWVRFd2Vt?=
 =?utf-8?B?YUV4S0p2cS9WdWJuYVdLbUwyYnNwb0ZPMU1aczczZXprNUJMUnRmUWlxVllI?=
 =?utf-8?B?MUN4SUhCM1hFZHdlaWxKSkZNaGk5SUFVdDExaUFZK0JmeHRsTHNFYmdUTklW?=
 =?utf-8?B?cXUvSVJBc2M0MG5NWWxFNVFTN2lpWnJFZ0RFbVlaQXFmenhoMTRabEtyNEtM?=
 =?utf-8?B?K2REVEhrWUpLemdEa1NkeUtsQ2tCS1dGS1dubHRuNDFtV04zQVptNWVpZmlZ?=
 =?utf-8?B?ZjQrSzFBeVlxSEhaYmlrOGFmL0FyVDJDY0FSVnRNaHc5UnVpMXp1N01aa01I?=
 =?utf-8?B?cWVrSkp4bEFLNCs3cFM1WVlKV1c3WmhaajFkT3lsWjlJOWcxMU9kVk4yQU5k?=
 =?utf-8?B?bURldlRBTzVkM0QxNWpPNk8rMmw5SmowRzBBc1Z3VmFnbDRMemhISm5ldmla?=
 =?utf-8?B?MWt2MlVwNXhObXN2dDExbTNISGg4aGNLSE5TaWZkSXdydENEYnlkMmJleVZX?=
 =?utf-8?B?d1Y3Mmx4SVBrOC9ueEl4VU1SUDBWeVZBUitaUGxqWllpdlh1aXlWa2RYNk81?=
 =?utf-8?B?L2U3NmdqSk9FSVRpRXJQQTJ5M3hOYUV3L1k1UU5hWUtDNEplTHBkQTBPemdI?=
 =?utf-8?B?MTQvYTc1SXdNUUplNXNvV1BWM01WK01jR2gzajVDNHRFelpuUWI0SHExZ21F?=
 =?utf-8?B?QjMrVWtMQ24zVEUxVWppdXZMbHF6R1hML21zQXJzSWRsOUgycXRhQWhtNjBW?=
 =?utf-8?B?bkxEa09LRnBlT0xvYWFjWmJ0cm0xMHVPejFyV21wbWlQTGJQRnB3Q0lRMHVw?=
 =?utf-8?B?VURPRHlKdDY2aUFFRmlTZkhuRk1CazdzQ0lKRWJoTGN0ekx0NFNsVFM0VUhp?=
 =?utf-8?B?bHJDeVVrdXhEeFYxTG1IcVNBS1VPc3d5UmpxRmIwbVhTTW9YVDVoblJnM01B?=
 =?utf-8?Q?zaxOkl779ms=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHJjNW5MZVM0Y1J3Qyt0YjhWb1RNWnNBdURkTmRnNHdLMmZVOTFBY1dMWC9Y?=
 =?utf-8?B?aW5iNlkrbG16YWRIV3FvSWl6MDgvRFZmLzBYZGtoVkZtODhhdGg0OUYwMVEx?=
 =?utf-8?B?RjRpNENSbW5LTTdlRVZOVFlwM1RTdElmcUhHdm5hNXg3MWxpUGdPeFEvTml1?=
 =?utf-8?B?L1g1VVNsb2xSZklKVzNFZFRqRFpvOHZxV0E4MzU0WWVmK1JVbDNVUmRoSzNs?=
 =?utf-8?B?YUlWMHZRUE53djFlaUJKamFEeGgzcDRGQnNTUk1WVnJ6SmlXdVhJb3BiaWQw?=
 =?utf-8?B?K1hhSXg2SEJ2cHlxUzJ5NWRKOWZ3eUNMZlZYc0hnK1VEMGwvRm5XdjFDdXFT?=
 =?utf-8?B?ZUtldk45WmI2NXUwWk8va1ZBeEhqZEwxcDNtc2l5dWkwM2hvYlIwSEY1bHdX?=
 =?utf-8?B?bWdYT0w3dzdNM2xEa1ZLdEpUSURsMEpqdlRDM2lGdEllR0dHYlV4cXF0TVhw?=
 =?utf-8?B?ckpKdENhTG84Vy81aXlsKzBmSDFibXdQZHJwblFwL0FNUld6TDROMGE3cVJj?=
 =?utf-8?B?SkMyaTJWUHVYU0EvMWtiZDRSTDN6S1M0Ujl1K0I2c1BJa21XOU5NVjFiRlF2?=
 =?utf-8?B?ZVRjdlphWVNLVTdndVJxUFgveDJVYWFxQzJ2L2tQOUJzaUhJckt6cjdWT2JS?=
 =?utf-8?B?R0thZXhFZTBPSVZMSGVPc2Y3cnQ2STJtOGRUTUk5SmUyNFRoTVVLSXlPUUJ1?=
 =?utf-8?B?c2hZa0N6ajZpWFU0aTNPUXJuOHZNT0FMdXl6VTlFZXZ2Z3d4a1k3ZW5WK1hl?=
 =?utf-8?B?UEtoQkFGc2VxenFLcjlCUE4xZFl1d0RJZUJROHBTMkYxTGl6RzZCcG9WblZu?=
 =?utf-8?B?dlVMTEVNZGNpVk5JQ2VJa3J6eWFWNzV6TldtMGw4a2MzSDRGb0xLbC9DMllR?=
 =?utf-8?B?akliK2lWVXZRN3F6d2gwL1F5WUR4WjVqUjlVYmU1RzVYMGJlN3JOTmIyWmhF?=
 =?utf-8?B?aGU1NXE5aFB5OUFoaEpnWTEyZUlmRXIyNGpDWURVK0k3eHgra2NJc1FVRWxt?=
 =?utf-8?B?V2FUMDQyR2tDV0dVMXNyNjdLcGtJR09JOU54MlVQTG9LMndQMGdCMnM0UVhx?=
 =?utf-8?B?UjJEbHJTcVZWUXJFVk1TS1l1b2JDSnNVNkRVa2xSSUcwZ2M2NVprTGZTVFNn?=
 =?utf-8?B?bm1EWFd5UGE1bDBDVkpBeWtSSi9IVlJUZmZ1L3RQS21qek5UUldNM0RCeTZl?=
 =?utf-8?B?MUhGdm1kZzFhT3B3cVRnVGQrRTdqNHc5U2w0LzdzQnJJVmhQTGN1SHF5VTZS?=
 =?utf-8?B?eUhmaTNteGN3Y2k3aGp6WHNCTGhWS2JZRzA1ZWtTWXBUNXkvaEN1eE1IY0NW?=
 =?utf-8?B?eks0UkpUa0xEdlZDbUZtODBXQThCRnFTN0IveVFqZE9tZnpBbFR0b2g1UzlP?=
 =?utf-8?B?VFhSMkRWaUNBTm1ZTnZEaldhVE54WE4rY0pXMzhCOUxBSWFoZThZbEFDUWdH?=
 =?utf-8?B?bW51N1lqQXpLZFZFREhvcW5vVmFoMmtValVkbFl1Ym16bDNpVDN0NTltdlJG?=
 =?utf-8?B?djg5SndsSi9VZm54TEtWcU1xVlFncDdwV3g3cUFZVVQ2WlUraGp6b0JkeGtR?=
 =?utf-8?B?dG1xVStvTndjNVJnaUNSQVNMZHBmSnlEM1ArNmlhOHErbytSOVdpaGRFTWQ5?=
 =?utf-8?B?NE15VXVmTDRVK2N3LytrMHlUM0JZaWtlZG5DN0QySmNpa0NqZ3FPeHdvQUNX?=
 =?utf-8?B?SjdGV29scVNWNk16cTFqd3dYcU42U051aTNOTE5tcnN2RGpqVStzc1ZPcUVs?=
 =?utf-8?B?WEJtKzY5eWk2Nzd1dG1xMDZ5dEtESnYrOE95WHQ1aTlOR1djb2J1bWE1OVFu?=
 =?utf-8?B?LzMwc0pETHVBVnQvWk1IMTVZeGpZZnk3cGs5YlJHSTFNR3RBVXRxODV0R09F?=
 =?utf-8?B?WEk0Qlp3aWRFcU1rRHlrdGN1QkgzdFdFanRlS1dPanhhYVJGYXV4N2VnVWxy?=
 =?utf-8?B?S05ZNTR4S0tTZDVSbGFXUkdsWUVjR2cvNlBYY2F3bVQyTkZOclNQdjlXeDRY?=
 =?utf-8?B?L0Z3em02cXcydW9hUVp5d1ovcytvQkMvUGhUdXBJenMybFhPR3kwbUoxZjFw?=
 =?utf-8?B?TGIzZ1IzSGxKMFh5amdta3JPMWs0eSsvQTFSakNnb0JNSDFyWm0yNThQUmIx?=
 =?utf-8?Q?HL12slR5k18fn86jcAm//Lhag?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e832cc8-947c-432d-484b-08dcd8f709d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 22:04:31.4232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hozC1GG9I+qVBmIFXFq8zLAsCTuxes5zLlXWdE16N2McvRnBySvcnKjX7eI7TEwxUaQOSEs+xuKg60Q9NFGG1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9849

Add support for i.MX8Q series (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe
Endpoint (EP). On i.MX8Q platforms, the PCI bus addresses differ from the
CPU addresses. The DesignWare (DWC) driver already handles this in the
common code by using the 'ranges' property in the Device Tree (DT) file.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index bdc2b372e6c13..1e58c24137e7f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -70,6 +70,7 @@ enum imx_pcie_variants {
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
+	IMX8Q_EP,
 	IMX95_EP,
 };
 
@@ -1079,6 +1080,16 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.align = SZ_64K,
 };
 
+static const struct pci_epc_features imx8q_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_5] = { .type = BAR_RESERVED, },
+	.align = SZ_64K,
+};
+
 /*
  * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
  * ================================================================================================
@@ -1645,6 +1656,14 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.epc_features = &imx8m_pcie_epc_features,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
+	[IMX8Q_EP] = {
+		.variant = IMX8Q_EP,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
+		.mode = DW_PCIE_EP_TYPE,
+		.epc_features = &imx8q_pcie_epc_features,
+		.clk_names = imx8q_clks,
+		.clks_cnt = ARRAY_SIZE(imx8q_clks),
+	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
@@ -1674,6 +1693,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
+	{ .compatible = "fsl,imx8q-pcie-ep", .data = &drvdata[IMX8Q_EP], },
 	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
 	{},
 };

-- 
2.34.1



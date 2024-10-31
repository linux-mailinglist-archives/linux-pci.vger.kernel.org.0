Return-Path: <linux-pci+bounces-15736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C789B8019
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7881F2288A
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339281C9EDD;
	Thu, 31 Oct 2024 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MPVfBtPv"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92671C9EC6;
	Thu, 31 Oct 2024 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392063; cv=fail; b=AIxQ6xcI3JlYLQJ8IxFwh88U0AAqf+/0OISBBfbfrbTLJG+CWZ4y7QBYJVNWRE314LpqFZNkZxAkbL5DL4UrvOQTYGzyOPoe44iJSj9GsjQHst30PtthvuS9iXU6PuPN0CUHBVQauVQQd5FPIlCn3PE3ICnnMNsP6mC1jXVG0E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392063; c=relaxed/simple;
	bh=QXAZUTo25wHxfm2hPmZ2UTgDrVKcvTZyNirR6BThLKo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=K8w40xb2v3Yn96LLK/w44L5Cvl1WaGneav04vHlQJch+SCcjrqXSVyKsR0LqX6JpPnjIfbF97qoEpR4uvue8Gv6wYEkK1KFSZRj+xk07qWGJ19qEtn7N+bu09znMeBgYAUzBaU6T8InQLzAUdHjxK0CKAJkqNEBfwL6GoDhIrDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MPVfBtPv; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUxCIuKqdmCDTModtyCkmeEz2bnXhTbBBsIcfio1iyA8hTZS7PPGJuXe7WMJiff6Fas17ecGSpOgypYlTHG3Srp2txVyV8MBwVI2iP47262I/ztsB3mQlzA7m8J3J6/oLmqDo/1t3K4eKtghwBK2RtMS3v0jMG44I1jof6YiTWzE6LvBwLt7VJZ+mViMilpsvrUsraDKTsVbtMakKVykFRHgFUvxQm6PvVU4xnQBRx65KQutqEV4ohQbMtRejof/37mF4tbqOWMTJpUkVm7gnDThI58VT4MtBUCcFSoSmGbapTAjW07fNLvjPBVZXCRsbcKE0xHg9XcT6FwL0J0v+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XsfDMu3OuLSSl5vBa2X1Qbhd1a7N+LYSe23dI9037Y=;
 b=PI1CHFsL3qF4WTopF3MlBfYI0/Fuz93szg/Ura9QW4JzcENEqyrjHrkbkj4XTK6Dj7JVMMqljvAmt1PzqHj9EPysH4Lkym2fPKO3BlN7FoxL7JGo6zuRzgvMD31rN1BpfUVHI7j8Iglzon4KY12CxGgW5A8V9c60WY0ZFupZ+5gdvashc+FahN3FASGAaI78dAhL6vWSKGYDR6CROOahyqyKpsfsTf6Vrw3ANdASXKXS0iwIRXV9ck4dqyvOMoOXnpstwLvWNacRMqRAmriJ/B8UfDaEflhY3VZCO7zhlgu5JD9f9Tk44480HiGqABs/oZuSh/rJ7ib6ARwr/4fFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XsfDMu3OuLSSl5vBa2X1Qbhd1a7N+LYSe23dI9037Y=;
 b=MPVfBtPvQyXmC1OCKcgIjhxQ+3e3lZMkNCXPjTEF2gxDH1zOD/xRr7be/u0ZJAWo+GkD0ZmHJDLwrElXIsGafqYi0V+1nyWep0O8UIBPwZKW5+VKC4cEq/66S++8Qot62ivihejNAmCuUENHeZeYFU3PYvO/xh3szpkncqx4PksbdgpES4h8yiOg2YRx25YmW38GmlIoBNLALk/hn1veIULG2gMqpbJgCJn02j+Vca4mocBlyaNn9SZPJjT1NKWGgo1M9ZBPzbWtMUrxneeSaESP6edH00TN75eWW5p0UG7+JezSfeb9Wq486AxAgxuc8Pbe7ycOWESYyhHh3O5KGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB11081.eurprd04.prod.outlook.com (2603:10a6:102:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 16:27:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 16:27:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 31 Oct 2024 12:27:04 -0400
Subject: [PATCH v4 5/5] tools: PCI: Add 'B' option for test doorbell
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-ep-msi-v4-5-717da2d99b28@nxp.com>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
In-Reply-To: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730392028; l=1804;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=QXAZUTo25wHxfm2hPmZ2UTgDrVKcvTZyNirR6BThLKo=;
 b=BQijpRRjBWhkiRVjXCG9igHmC6uR8sz0/GFvhgRsJ8HN54IWhy9aDPakxpCM3SJFG892FIb6I
 iQgBv1l3WBqBuS4OdfyuX4I+xZ2jOX9dUmetDCRJ3QQKjqqe4LkrSfi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB11081:EE_
X-MS-Office365-Filtering-Correlation-Id: 345de0ef-540f-42a2-754f-08dcf9c8eafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVJyUW5IYmZja2E3THZ2ci9nSmxleFBMdEpyeFM5cGdQOXQrUk8raHJqZUdJ?=
 =?utf-8?B?djc5VDl4QWJRODdqTS9wRXpOcHlKRllieEdXbzdQNnV1MEtWa3EzMUp3aFhk?=
 =?utf-8?B?V1ZrRjU4U1BSNVl4ZzBEbkF3Q0lwcmNxc3puNzZsUWlYOW9sdGZEZGlxWDBn?=
 =?utf-8?B?NzErS1F0RjJnbWN3TGdLNWVmQTh5U2djT2J6U3AxamV5QnpTb2RQOS9NZEJD?=
 =?utf-8?B?Q0hFWUl5Yy9oa2dmdmNYdFVON2FyeE5zWVhGMmtMVUlMZ09zbVNFcGo2VzdY?=
 =?utf-8?B?cnFOWFVTMDVQRmpPYlpSWHhyMlBwVGJvTldpdFh3Z0hDb0xNVFl5dEtvTFB0?=
 =?utf-8?B?dDNVMUdJa082TWcyMC84aEVnemcvcVp1Mmp6cVBtdy8vcUFXbDM0Si92V0Vw?=
 =?utf-8?B?ZTlRK01PUTI5RmQzOGQyOTJ6dWNXcFF5OGtzUFZ1L2NPTDFtQ0RRWVV4NXRN?=
 =?utf-8?B?NjNEUGpDTGxrclpvZ2VOWE00ZzNIMVVBUXpNU0RLK3ZLbXdPUG9DUlZpa3E0?=
 =?utf-8?B?MlFiT0VrelpXZThWTTNiY2xCVGdCdFBTNXgzRi9EejFRQlV1WFFsRnhVaXo0?=
 =?utf-8?B?bjBIazZoNkNQVFRaWU1pUmtxV2EvUzRqVDNjYVlaWEk4ZGp1SmRBWGZpTG5D?=
 =?utf-8?B?LzNyUzF3dWx6RmFYNEVMSmZtVGJITk9KQ3Nid3hoRFJtaTUzTkxKcFdHQ05C?=
 =?utf-8?B?ak1IaUtYc01IUU5SSjQzYlRSK24wUG5mRHBXYnA0eTF0d1JqaEt1bGdhNTJt?=
 =?utf-8?B?WnZkZmtwaVNwOTMwMXZkY2ZYN0R6SElPTEtZendzTXl4MHRDSjRiUTN0TFRh?=
 =?utf-8?B?dk0rN1piSDVGZTNocXZhc0xhVmxRWFFtd0dMSG5OaGl2ZTNyMy9BSW5MbEF2?=
 =?utf-8?B?eW9DcVNSMkl6ZGxRTVA1SjR2YytKelBoclE2VWRGQytMTi84b3hYT0lMWVhi?=
 =?utf-8?B?UHNwYm15RGRtTmg4clNKWVpRMkwwTnBnamJ1MXJKQXBhekZ6REwxYTdDWmhG?=
 =?utf-8?B?dWpnc1VJbGl6Zk5HQWNGT01zQ1NUeVVnMkEzakpNTmgzL1gwaTFXVURyNCsy?=
 =?utf-8?B?OHk3MnhYcVVqbTRqU1g5WFYwN2hZTlRmck1BKzNvNEpqSVUyM1A4ZGxTS0ha?=
 =?utf-8?B?Yjd1TjdtWFVJSVV3eFZBbkJpRW9VQ1YrS3RJU1IxdnZtN3hhTkZaTEJUTlVy?=
 =?utf-8?B?eW9XTEk1cjh6SjZpbVExTDBUY3dPSFN4dmFuclZXTW9SL2dTT0ZOVTZid3JE?=
 =?utf-8?B?dzc1L2FhMnhFdlpCbnRPcUtoaWJVWXVqSFAzbU8vQUpQZzZSSmYza3NZREJY?=
 =?utf-8?B?NHVrQ09ZR3U2bVNLZlRQc2hmdktHLzdCbk96Q0NBeW9ZbWM2dWZkUUVXSDB2?=
 =?utf-8?B?dHJJSms5TFRmTkZyZWR0akpPK3o5M2d0czhVWHR6QjNmRjd3VFRxMGxZMWJH?=
 =?utf-8?B?dFVlMWQ4L054TzZRRW1zVm1XeTU5dFplSXNrMHJDUmEwKzRoeWx3ZnZBSS8v?=
 =?utf-8?B?M2FiWFFGNlFFYTZiL1hZcFBtNmJhWGVPTFN4L2JnWE10S1hlTWE5K1FtOG5w?=
 =?utf-8?B?aVJKNWQvMnVFV01aN0czMDNJZWZlcGczc2x6U0VLRTRKVDJjMFhlWXhaVHlk?=
 =?utf-8?B?M21WTzIwUlQ2c1FrZVhjbW1IejNQVFRCUlJQT3hEZmpnNzNIeklqM1VxMlVE?=
 =?utf-8?B?cGl3c3RmS0tNclVXNHBRcnNVSEpUK0VwZXFUMjVRSmRBeFhNV1VKQ1VTV3Bz?=
 =?utf-8?B?Q0RXeTQzb29YNVZmcVphUnNGdlAvUFh3YzdlaUhIUmxZRk84bm9vU0E3RWxk?=
 =?utf-8?Q?9N25jCC4rfen0jOa0lFzBZsCp+vfqJUsM1EBA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkwralhHSUt0RlAvNXhieXV4TXkxYk1xZWlVdVlmTi9udkNMRjlFTEdGTnhC?=
 =?utf-8?B?di9ET2g2cDNGbkFkNVJBS0p3U3dzbjVlMENkd2RhUUF5a1ZxNlJxMFpmWDFQ?=
 =?utf-8?B?YUdjQWxKT1ZRczhHd25mcmVxa0MwQkYyemtDL2Q5MHA2eitkcHk0NndCcnZi?=
 =?utf-8?B?NE1LcGhhakh4dmgxZmNYTWhhSWJiN1ltdi9BdmhJVG1EL2FnVFJ5TGRRby81?=
 =?utf-8?B?alJzWXhnUVp0MlBURE9jNXRJNkhhZGtVb3o1Nk1CUUVIU3o3S2Q5ZUR2Yk4r?=
 =?utf-8?B?RVZmVFlJOTVsQ2VCcXE0UnI5NzM5UHRESlRvU2tmdnRPQmlQbFQwaFpRSS9P?=
 =?utf-8?B?SGduOUdmSklkdnhCZWNsUCt5L0R4SVJ4VkFyWC9TSUxhMUwzN2Mra29XMzg3?=
 =?utf-8?B?bmUxV3FhdndkRkIxNHB2dXMwK1hKUWN0ZTdoa2NMcndBSk1SRms1M2tpUGhS?=
 =?utf-8?B?NTIwbXN5OHA3UjlkcHpIY0lkQWM5b0lXMkhWbUI5KzJqYU5TbjJRYXFRTHFy?=
 =?utf-8?B?TnR0OXVDRFYyUHU2VzV5eWNaS3dubnBkOW56NXNtMWN4SmZZdFN2RFhncWR2?=
 =?utf-8?B?V3ZxTkRhelhDdS9PZzBFMnUzYTJJazdjbHp6TVNad2RJSnhLdFVTYjdnMmdQ?=
 =?utf-8?B?OTBZTlF5M3Y5akNsMkJ0T1duTDFJci8rbjNlWDZuS0c2cXVPRXc2bzI5Wmwz?=
 =?utf-8?B?U1dzQkticnZxak8vaHRwa054OWtrdVNhY2NTT25KV2VKS0RWTlphSHlOQXow?=
 =?utf-8?B?eUdWYkpIcXcybi94SGFjdFRRQWwzbCtNV0pCWFNLTVYxZmM3Mm9ENk5XRlMx?=
 =?utf-8?B?ZExBbHlYdWJZVk1IdlJPNUVhVGoyclQyN2hHNjNQR2lWZGRGZzdYa1JmVktX?=
 =?utf-8?B?ZmhJL2xLUEN3RjV3SThiVitWaDRnWktzOWlkaDRMdit2OG1ZcU5nTXpiZTN2?=
 =?utf-8?B?eW1CYkJjeU51cGc1eStpUTRoTGxhaGphOGZPOSt0WWlJc1JXS01uUFdqaXBy?=
 =?utf-8?B?dVJLRmZLZTdjclZEdmFWRm1NYU1OV1JuVFlzR3NGTHhqN0wzZStMOTZ3RDdB?=
 =?utf-8?B?K1lNNk9DL1ZCTmp5UnhJMERzNkZBaWtpNnhXa1RwQUpSakRUemxYQks0VjVn?=
 =?utf-8?B?NW1hMEJwZ3V6U0o3NWkzbTczVnVZN1ZHbVRoaW1UbEU0MUFUVTVGcEhiYkJv?=
 =?utf-8?B?ZUczQXhPaTloZjlVY2l0dTh0UWc1WmdlVHRMbEhVOWc5YUFBVFJPNzVxL281?=
 =?utf-8?B?UDM3am5zNzZaQjR1cEhkSStYektmd25jYmxCNytFN3llNE10ZFBLM2R5ay9W?=
 =?utf-8?B?TS9KWUVoR29qaFk1bUhpdTZvd2V1bEIyNGJQamJlejVPaVdOcGE5c01lV1pB?=
 =?utf-8?B?VHFLdmpQSVBGMWh3clBPU3hvQUdtSmpjZ1hyL2lBSXYyQ2w5Yi9KSTY4WkdR?=
 =?utf-8?B?a3JnUjRqUVdSVjJ4MTI2SXQvbXp5cjFabTBrL1YwcmlEbVVzVFNhME9OSm9V?=
 =?utf-8?B?V1JsMXlmNjBVc1ZlZjVEQllhbGI1RUpNSlVoY3VvenV2dTFmWnZJUnRyT2J3?=
 =?utf-8?B?amYzaG04K0RJWmU3Y0tld0w2WkdzNCs2ZmZuV0NDSDRZV2JvdDVaZnJGaWVS?=
 =?utf-8?B?Wk1hcnBoQU54WEJyWXAxV3FtYzNVbkxtVVdaVE9PQ0prQ3VSS0xJZ2pVSmJ3?=
 =?utf-8?B?QzBxU2hMa1RZNlNGWENYWS9qb2JqVE55V3g5U2NzRWZtZnVpcWhhMUhpdExo?=
 =?utf-8?B?YXlCZ1I3dGtMS2hLSDNvK1NjMFFqQ0NPNXRILzh5YXQ5NmQ1cFE3ekx1K2Zn?=
 =?utf-8?B?bkVpRFRCS0hjUEVCZ2dobDQrb3RKZEpFekI1ekx6K0YzT1JmQ2dNOXFwT1J4?=
 =?utf-8?B?NjJDS3dIdmVoWXJxRDI2dkFHeExtTlo4N25ZdVBvTXRCbzYwR2hSUTlpbzlm?=
 =?utf-8?B?MUNScmNmRnA2R3ZzajdwYngvU2N0MGlJd3cxci90VGtWZ2NXcFNVV3FJUUpi?=
 =?utf-8?B?S1R0QytvU0g1amF3dHR3Wm5vRWpqYnF0NjI0MkdkY3R3VEZ2QWUzYkxaSkVk?=
 =?utf-8?B?dDVzWGI4Qk5ocWhOOWhPRDJ6eHZ1R3VjVWV4VXF6OUV5cjZRNUF6VG1QNjI5?=
 =?utf-8?Q?csFI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345de0ef-540f-42a2-754f-08dcf9c8eafb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:27:31.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFGAb8Ivl5lUQGVialAs8G0BY+IwyQ2FWqlS3p48nGxmhyL/aYCtND+8lBvErXyt4LxDzWS0+zOdfUs2KMwlkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11081

Add doorbell test support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- none
---
 tools/pci/pcitest.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 470258009ddc2..bbe26ebbfd945 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -34,6 +34,7 @@ struct pci_test {
 	bool		copy;
 	unsigned long	size;
 	bool		use_dma;
+	bool		doorbell;
 };
 
 static int run_test(struct pci_test *test)
@@ -147,6 +148,15 @@ static int run_test(struct pci_test *test)
 			fprintf(stdout, "%s\n", result[ret]);
 	}
 
+	if (test->doorbell) {
+		ret = ioctl(fd, PCITEST_DOORBELL, 0);
+		fprintf(stdout, "Ringing doorbell on the EP\t\t");
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
 	fflush(stdout);
 	close(fd);
 	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
@@ -172,7 +182,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:deIlhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:BdeIlhrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -222,6 +232,9 @@ int main(int argc, char **argv)
 	case 'd':
 		test->use_dma = true;
 		continue;
+	case 'B':
+		test->doorbell = true;
+		continue;
 	case 'h':
 	default:
 usage:
@@ -241,6 +254,7 @@ int main(int argc, char **argv)
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
 			"\t-s <size>		Size of buffer {default: 100KB}\n"
+			"\t-B			Doorbell test\n"
 			"\t-h			Print this help message\n",
 			argv[0]);
 		return -EINVAL;

-- 
2.34.1



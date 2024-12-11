Return-Path: <linux-pci+bounces-18188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24ED9ED804
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 22:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4826D169ECC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 21:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BF323A19E;
	Wed, 11 Dec 2024 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LQnoO+l1"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAB423A19A;
	Wed, 11 Dec 2024 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950706; cv=fail; b=gjM1Nfp5t89oLpic3Ysy3rMLXR3tvnH5q8Hf3iOa+eeXMLZ9s0xCF7mnmgRn4/FoSW/ETGYEnixFC0YWF5Mu5LMmOaPhGStDAUUmUNKTDJZvB3qFkQnmRdUpWRn5QtBVqlCZDjO0COYGXiFzXMP7kRWsDOvW2/nf6k8GMQApuKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950706; c=relaxed/simple;
	bh=04o8LvhgcqnX+pJqL3zaiO6sBmMiaAG+qaGRFs84x70=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OVO7uPgRXm9BpXJZSAHnUI8mCYHhy3/tHSMNndVVPhOFQiwksS5ZiP5AEeer1Erry7xGk2BiOgwkS3iCl+ztBkTtcbRLoi5gkDavnZy8CTGdQVPNwe3tRV7a+pWKT/wUbUtVP3vmYeVNzQmPAkySLjOlTuUusTL9PnhALx/E4rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LQnoO+l1; arc=fail smtp.client-ip=40.107.104.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COTJ7rskr2zHJMgsM8N1axEoimLxnBwW8tx6BvpSt63Xcq3OVF/EHlVReF83lg1n0SaUQi5SfsfMjC0z+aQOtH1BOLzOEdnctjj4QHc3XK6FA+Yqo5kJD3Slne4bG0FdxgSjNHevqFEn/1FooE3AuuagI4ZbV8QpgDVBK0e75f6AYV4EYqbUw7gw//3I8XDLFFxTKrjvMbfaQVNxkMkWAb/fpMrIKUN9WjqmZC4xoMZ+rogcdq9a498S1Ub5Z3Q07kVTgFkmnlH8OSBWofUPB8r4lJanmWs9JUvDNYCarwKAHjv8R2nTLxFhMRUORiNjKkk5YJnQaJzb0WzYpyn+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUfOoPgd7QzvV0XqY7bT7dT8x4B/BnsNnIWzUIpaNGg=;
 b=RBtG/J02M+pOFJA8l9H6KfqIG7FVWlpNNlBCaWUodmB+bI3kO6hkb0aWIdePx/GzWUlZsdfaK138Qty1OppUmNARMjbNpJLlEkiittrqT1l9AV1j4ik+MKoZGm+XehhupdoW/z1UTWm4vDXBd/T8B3S/Z8SR8YU0N6fRqseoHFafI49jGv72jgOHcONsn07SWRG09yqQRL7lcpmhwlVTWOm9Vk8lxyGpLyRZ+X/DEgYOFxJTosVLKSHlZmanAxBv2HZ1aJCAe+efyVsvN8dZuzLaZtDOpmYs75TY8fGHdSpRXvUMfAokw4KT11mrfTbJs+A/dUIZmY5OhGj4LkII7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUfOoPgd7QzvV0XqY7bT7dT8x4B/BnsNnIWzUIpaNGg=;
 b=LQnoO+l1o1X2u+PLvm094ZeTk5qZBdjM6NIblFnfEiTQtj2hICaGFsnYwEvLFP26Ed45bbwDL5tdOATHy7Wvgb3IwP1xKI64eR1QX0hFDPUkh3SVMf/pMU38sngePUWaOi3uJyot7gJIOIQVWRXG9ih1buGBbfFGDzBEDfA87JTjJa6D9ASQHebic9PqJHLr517NssJLa+F1jSswfpLSyMyR/RPEgEAzbnteIcHH3M5j7MZ71XGek5/pjJXxXvGDDX136iwgJxf4FbojQy7noTbUtP4wio8cGK0CHqXnu6QivhgJuAk0Y7xvjYLgdfLASAsgWaBRa6VEBmgF4jx0Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7139.eurprd04.prod.outlook.com (2603:10a6:208:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 20:58:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 20:58:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 11 Dec 2024 15:57:36 -0500
Subject: [PATCH v12 8/9] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-ep-msi-v12-8-33d4532fa520@nxp.com>
References: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
In-Reply-To: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733950663; l=5981;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=04o8LvhgcqnX+pJqL3zaiO6sBmMiaAG+qaGRFs84x70=;
 b=o9THKM1FJ1ALGXrUdJMBKl5faPEvR8P2Saya/aNWf0aFH2hPH/sQ7Jda8LeCquwk22LC70lzH
 dJ0jxOYf3KVAaMFAGYHOyye8fRVChQgQTmSTFyOOgq5rCKj11SD5Mpf
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: de14f161-19a4-47f1-bb74-08dd1a268c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlFpUzZleTlIMHF4clZ2ZTZPSWdNVzI0bTk1QVdvYkRkRTRiZWoxK1pWRDda?=
 =?utf-8?B?amJDU1JGdXZyRVZQRCt3THBaR1dWTSs0S2NZTlVOdkJiWkY4a1RTRHcvVzRz?=
 =?utf-8?B?bG9zSTlmektVMnl6Yy9uRkJ5angwR2luZnZXRjRSUUNQelFYTHVnY2NVdkpq?=
 =?utf-8?B?TzJZSGhyN3dQc1VSc2dyeThPcTF0WjRoK01LNWNlUS9iL2hQd0RNd2wwS1di?=
 =?utf-8?B?RnVPODZkWVFkZ3VTQWhMQ2ZpdHpkKzUvZ0JlWTIrc0RKend1TFI2KzYvWjgw?=
 =?utf-8?B?SVVjemxxK0ZzczlTR0t2cjM2L09NWnNKTzdnM0N5L2p3bkxHRWpkUzluaXRp?=
 =?utf-8?B?TUk0RkVyOGQxSXY4OHlhT2VDdWUvQzdGTHV0Q3craVY4clRXY3hQVDNMa2dK?=
 =?utf-8?B?WFVuL1FubHBsak02NkptYzBIWlViWUU1c0d5VGxFZlJsU2dHdEhtdTZzZndV?=
 =?utf-8?B?Sm1mZTFmNm9yUkNwWDdybGY0ZWRvbndHZmZOKytqbjNBVXdMUVNvdFB3TU03?=
 =?utf-8?B?RkgvZE40RlFneTkzMlUxS3dKQW16dW9zV2dTOVJYT3ZxSWtGbDhhd3BEWTQx?=
 =?utf-8?B?ZGFyRjZFTjl3dzJiNTMvbTJGTVo4OGZiTW82OE1JR3FYdUNOYUhYekcvT2lu?=
 =?utf-8?B?N2ZGUUV1NllqMVFWZ0hwTjEvL2g5RzRrRFJhdWNMajBxZDN1LzNndGMveHRi?=
 =?utf-8?B?VXRTcnEzNmY2dDliR0FCSGkvU2prcEovSVRHUzcyRHBkYU1CM1J6OXZleDNn?=
 =?utf-8?B?Q3c4bVVHUDB1QjFiY0tjM0xHdGFCelhJSlVNVzlZWlVBWGN4bHZnakQ0NFov?=
 =?utf-8?B?bXNmd2JObmYrMkFjM3Z2NEtQWGZvUmJOVkF4ZDFMRi94SFNsZ1dEejJmaSta?=
 =?utf-8?B?cTh0TEgzZnZNcmJ2cm1nRGI5ZkJPWXI4MW94R1R3MmNxNmJmSkpNM1YxK21N?=
 =?utf-8?B?eUplQ3orUFd5Mnc4ZVp2UTFGbHE2aHNyVWJ5bDNma0ZjaHA4US8wQjVFK2tw?=
 =?utf-8?B?VGN5SURvSFMrbUVOUS8xVjdTVG1NWStxVkFYd1d2bWpobGRNUnBzc2VudWhM?=
 =?utf-8?B?cVUycTUvRGREaktBL3Y3L0prNzVwZEsrcTMvREFsNkZiWHJZekdqdW4rVnJl?=
 =?utf-8?B?aEdDY0VsRnA0VjZlbktpSkdSdSs4Mm0wVHRsNTIxNzFDdmUxdFpBZHp4a0k4?=
 =?utf-8?B?VGNxYWlBUkZRZHJnUFJVaFVHZGtEdVB6SVE2K2NWUGQzTlVsT3hjMS9POHBu?=
 =?utf-8?B?S0xCa0tIZTN0ZmNFN1p2WldDajBzNWpMZW1USXJhMjh1YThtbGFEL1VKVzl4?=
 =?utf-8?B?dXd1Zk04RW9vRVRVazRjWC9JS0hDMDdJOUFmT2JpVytKTGtjdlp3MjRsenJB?=
 =?utf-8?B?NFdGV2VQVjNwMkRlMHdCUitFMUFCUnB5cE8ya1NnZkd4Q3dLWmpnY0lLbGpy?=
 =?utf-8?B?ZURsK3hUT21FTnhYVThWZ3Y0RVNZcVNrSTdRUlRIQ2Rod0N2MXN3Z0piTVFn?=
 =?utf-8?B?b0xuNVoxNzFkaXU2dWJwT0FOTGh4cTdPQU9Dc1pjV1E3dDlHSmZKdG5yaktm?=
 =?utf-8?B?QUpGNmdtYWJ5eHQvbmV5Vkd1STFzeG4vZHNxTGlrN1FiREJ0L3owaHJ2OE5T?=
 =?utf-8?B?ZytQOFhpc1dQYTZ2TFBFRVFBbzhZZExVMmRhdmNEU3gwMUFvSytHdnZlTmtt?=
 =?utf-8?B?RXdRa1dRaUdncU1EelRqSTBFWXlKWHU2RmFGZFRPYlRyM0pHK25hT1lkN3dt?=
 =?utf-8?B?NU1WTzRETSs3MHVnMURibE5RamxZQUQwb3NtdnZ0Sy9jd0tOS3dVREVyZ2V6?=
 =?utf-8?B?ZGZNWHBsSWRKa3dlRjRMdUluZTNvTDNlRXovWlg5bEJsdUF0Y0NvdjdDQkI2?=
 =?utf-8?B?ZGM1aWZ6U2tDMG50azRldnQ2Wi91V0V2a2FMYk9kWk9DNjRCWWEzN2IyOUM0?=
 =?utf-8?Q?sJ2iLOVsfN4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkZyNURMQjVoWmUrdlJlbjQzMDM5K0RLTmxUQXVJY1Nvb3dOUUhSQUpONzA3?=
 =?utf-8?B?RFZZcFN1b2hnZFNSYXM2M1QwcDhLR0xaYjJEbWtKSks1WFlpb3ZReldLemI4?=
 =?utf-8?B?V1lKMnpuT05Ybk1aN0o5UW9oeEtuTzB0bXJmWDJPVGhESnFia3JtOU40WXZC?=
 =?utf-8?B?RFN3VjA2K0VlZGU5ekhjQU9HWCtEcGpDNk81RjFlSWZDb0xCTEsvbnFQV2p4?=
 =?utf-8?B?cHN1NUx2K0M3ckh1WlkwKzdyTzhBUHVSNER4aHhNK2UvZTQvODE2b2I4T1Zq?=
 =?utf-8?B?SE0zR2Ura2RTNTFkYmFZUkltMzlPRkZYUWFKdEpNMVYwSzFSRkpoVnlwL1Fl?=
 =?utf-8?B?d1hacmNFMmgvR05WOHlIRjVWa2dtMmR2cFZja21yc1o3dWhRblh4ZmMrV3ow?=
 =?utf-8?B?V0M4TVZQRms2VHpGSm5tUnAvUnd2TVJibktUZWNyNktCdjAxeXREd3RNaGlU?=
 =?utf-8?B?Z1B2aVh3OUhPRDdWa1Zwa3hSdzh6WXBhRG44WFpRVytjK3VHMk1ueFN0bVRI?=
 =?utf-8?B?MXk3d0lyYlVQNDFyWHJsbVVvQ1lIdHZyWmF5ZHlPc0wxT1NGSTRLVzJiZzZv?=
 =?utf-8?B?YzliWFdjNE8rbXVsN0xQR1NucEJEd2c2NGJNR1FKS2RNZmV3dytrTGlMRlN2?=
 =?utf-8?B?UXBORVM4cUY4eDhEdW5YMlhpUUI0dDdYMGUrb0JURzVsdENaSGg1Q0VVeWdz?=
 =?utf-8?B?eExnOEFXYnZaWXBLZmt1RkFONkIvMDZLTGcvTDZpMnJEUmxBNkcrUjB0Z0g3?=
 =?utf-8?B?M2dzRlMrZ0N0bHdKcmxnbnhtdTNzMzRzcXNWLzVIMk5jZXRYZTliNE9xY0Q3?=
 =?utf-8?B?S24zbmxBL2wxTjhYU0dlbUhtbkl1NGlyWDFhZ3diV3JweURTQXdOdU9XVXZO?=
 =?utf-8?B?djZGRkt6bCtFbTJTTFhFYm1BVzgvcDdrNUJobVd5R0RxTm9OelB5REs1TW5O?=
 =?utf-8?B?dG5DdUx4RXQ5bkltWU1zNjFzV21DNFEzV0RGMXZGK3A1b1pnb0lNM0s4emI3?=
 =?utf-8?B?eU1BK3pUSVlRZlRGcStXUmc5ZUJxQUpyc3JrQndkZHRma0grU1JzZEUxUGxE?=
 =?utf-8?B?Y04zWUpCZ1MxaDhKc3RGdGNCekxEeURSS2MxdHE1UnAra3JoOUpQUE5YZDlN?=
 =?utf-8?B?TVVkbWJQL3BCenJYUjBPTHEzMU9WQXN6dExuMHNxbEQrMGFWMUhLYWNCL0hR?=
 =?utf-8?B?ZXJFNjExeEEyYzFMeWRhMnpMcjlpbG5CdnlXVUdqejROVFlCL21iaWFuckVn?=
 =?utf-8?B?d1lVNmN1YWNMV2lvVHd1NVpCNTROOGV6Y0YvQmJaNjMxMUZEVHZBQ29wSzFl?=
 =?utf-8?B?YmdJT2VCWVlpRGdGN2NsSkxqK2RNUnExM25qU2ZnRjc3NXRHekgydHdpZk1T?=
 =?utf-8?B?a2ZaM2xqcW1TNE52OHhDdEk3UzJlSXBaZk5SUXZqRXlLVHh2eFhKYnBCYlB5?=
 =?utf-8?B?b1RXZlFWcndkUEF3MmtFVTlZejNpcjgxVmptR0t4Z2ZWU2hneFVsZnVsakJi?=
 =?utf-8?B?K096VVZ5Y3hQd0N1bzNreGtTVU93YVRGU2xPa0V4WEgxY254TG90M2lmZDZl?=
 =?utf-8?B?T1JPZmlxQmI3cE40MFpFREk2U1ZibnN0dngzV3lFMDhzQ3ZERVRxRG9EaDky?=
 =?utf-8?B?M20xT084dzRzUFA3dGlZeVZRNHV2cER4OTRtZTRrcHdmU1MvRGRUN0NKT0Mx?=
 =?utf-8?B?ZnFIYTNDTVplR0tGNXUxemozaEgxaFBvNHIrNUNEL0FGaUJpRWhSRFdVTnNk?=
 =?utf-8?B?a3VGUGVaOFpubkN1dzJSWjBxL1A5cDZMNncxMmtLM3grM1YwdFdKNzFVWS9G?=
 =?utf-8?B?QU43TnBoby9FM29GbHI3VGMrRkdxc1g4djg4YStIa0hiTEJVbVd5YkN3Y2lU?=
 =?utf-8?B?N01tYlpRUVMyTVJWVnZZME5tRWxkQU9ldUZLRDBnbHpVZ3F2dGFjd01UL0Ro?=
 =?utf-8?B?SmNma1RJWCt6dTZucXpJbk1hYlJsaUc1RG44cFNOY1lpZGREZG10Y0M1Wm1s?=
 =?utf-8?B?WkFoWTlWT0QxRUdPT2ErS2xIK0s2TnJsM3dtV2V0YjlLVWFTbjVIWG96SzV2?=
 =?utf-8?B?RVlLeGd4bXozdi82WlVuNnp3aGd4UXRKMXdKd0FzckkvOFlEeTd1VlhRdDcz?=
 =?utf-8?Q?+8V3DQag2GI2d3whTR4v4mj8S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de14f161-19a4-47f1-bb74-08dd1a268c51
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:58:22.2635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xf5HYn82wiVBTzk01WXTtkfpga7Yrs4rjfAycQR1tKG7Iz3nJlwoKmOLp5ttvv1KLqVKjoZY4ccjU/M6m1Ry8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7139

Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
and PCIE_ENDPOINT_TEST_DB_DATA.

Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
address provided by PCI_ENDPOINT_TEST_DB_OFFSET and wait for endpoint
feedback.

Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
to enable EP side's doorbell support and avoid compatible problem, which
host side driver miss-match with endpoint side function driver. See below
table:

		Host side new driver	Host side old driver
EP: new driver		S			F
EP: old driver		F			F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v9 to v12
- none

Change from v8 to v9
- change PCITEST_DOORBELL to 0xa

Change form v6 to v8
- none

Change from v5 to v6
- %s/PCI_ENDPOINT_TEST_DB_ADDR/PCI_ENDPOINT_TEST_DB_OFFSET/g

Change from v4 to v5
- remove unused varible
- add irq_type at pci_endpoint_test_doorbell();

change from v3 to v4
- Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- Remove new DID requirement.
---
 drivers/misc/pci_endpoint_test.c | 80 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 81 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee2..b3f36b6ba8ba2 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -42,6 +42,8 @@
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
+#define COMMAND_ENABLE_DOORBELL			BIT(6)
+#define COMMAND_DISABLE_DOORBELL		BIT(7)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -53,6 +55,11 @@
 #define STATUS_IRQ_RAISED			BIT(6)
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
+#define STATUS_DOORBELL_SUCCESS			BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -67,6 +74,10 @@
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
+#define PCI_ENDPOINT_TEST_DB_BAR		0x30
+#define PCI_ENDPOINT_TEST_DB_OFFSET		0x34
+#define PCI_ENDPOINT_TEST_DB_DATA		0x38
+
 #define FLAG_USE_DMA				BIT(0)
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
@@ -108,6 +119,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -746,6 +758,71 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
+static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	int irq_type = test->irq_type;
+	enum pci_barno bar;
+	u32 data, status;
+	u32 addr;
+
+	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		return false;
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_ENABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_DOORBELL_ENABLE_FAIL) {
+		dev_err(dev, "Failed to enable doorbell\n");
+		return false;
+	}
+
+	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
+	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_OFFSET);
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	writel(data, test->bar[bar] + addr);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		dev_err(dev, "Endpoint have not received Doorbell\n");
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_DISABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (status & STATUS_DOORBELL_DISABLE_FAIL) {
+		dev_err(dev, "Failed to disable doorbell\n");
+		return false;
+	}
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		return false;
+
+	return true;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -793,6 +870,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index 94b46b043b536..b82e7f2ed937d 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -20,6 +20,7 @@
 #define PCITEST_MSIX		_IOW('P', 0x7, int)
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
+#define PCITEST_DOORBELL	_IO('P', 0xa)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
 
 #define PCITEST_FLAGS_USE_DMA	0x00000001

-- 
2.34.1



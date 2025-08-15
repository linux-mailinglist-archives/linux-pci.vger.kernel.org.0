Return-Path: <linux-pci+bounces-34122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EECB2884B
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 00:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100F61CE0882
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 22:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2D6246766;
	Fri, 15 Aug 2025 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CmlzGnhe"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA79243370;
	Fri, 15 Aug 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755296504; cv=fail; b=CDO7vLH0danxfMN9LurBaUhUbfnSbqAv9DRQ8GIymUNZ5AKfqtcBguYvWzsFXEL1Sh5hp7r5169sIKiKk0NjRKg6ObrS5NzjOAtgxGntoHU48QdXfW1Z46yC3CyF3HiETxRuqtVzH/i7UZ7d5pDtI+itWWLdvpDnQcOSclUcGf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755296504; c=relaxed/simple;
	bh=MqzmwyArZfAvOi+P6AZYS835aPYyoeKgtaDcNuVnmeI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=XMQ39LgggvBuHN3IOR35Y2DPeGFrH86ESYOZnRxGvzYOPqV+y4qOmMwfeD4xAATCLZtfSxrGPPouZnV19WWdMntBw/riIEeGgUPqwOQDl1Sx5Zm1f2XyPjTbJKwkyuS+lFOfDX6Cqxy5phBoeYnRGbHd7qGF944Nqcig/Dv/yzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CmlzGnhe; arc=fail smtp.client-ip=40.107.130.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wjy2eEYchtNJVGkRlPPpKTR/WhJGTZvMIHUxFS/Yiwkz6U4Rn2yO8fizpVt2lD2Fr6PjD600kiYLf2i91/f9dI9kvdgMgMq+cl6JXFmzNqz+3V2uuIK20i0xDqrxoukbBF6FWChaMT/i8JmJQacalD0rExddFd020q75F2pV2yY1olOKeRZm6qsb2DVM1U5fH9RVohhj8jeparmkThbpdgb2mruwvZpzjV2lr7P5TEEd4pwkUa0jV8C7XS1q+uaPHW/5nDUwRhlxEeeLanLQBQfX1YzAdOCPuFFzWULnvcoCkQG7WnlxTK4IUemRj4jOMNUo0Hb/c6gLJEcAyF0Qsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLJpKuRHqVI3faSCTItdeCY+wbtxacVNsD0g4nJs2UY=;
 b=kepb1BsdHMidze32kcx3zqFnneFTz2+bqoVvDl4Xo+D/AJqMAwsHW7pDv+Kf0aA0Sx/ysKh2Pw0evVn/+vJEPdf12+vshb0C33TLZ1bT6lX4d7wwuVjSFlTWq9S53czQNM0dHDN5S5EfwQBNGVNEuktkaEsr8SqLGZkOiOcZz6XgWP+kpSDe7PbjdI0iTWothneXDbVJjGavLEqUSPpurgNalr56A47XMRfzoFA+0qKCKJrAjZNsV8234G76YL6MtuH7zuvPVgc2ma6h+qz6iJAD4H4CNEROuUd4RYHC3mL9ACQTPAqqVufSgo9zbDA/BfR3C6I0Gr3g6dhxtv/4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLJpKuRHqVI3faSCTItdeCY+wbtxacVNsD0g4nJs2UY=;
 b=CmlzGnhea0wyeo0jIrJH2Y4G4BhTWIo13OXkFeFURFLJDb6eZ+l3OFEqhJnzRrCM6yawXDZ5gueNwv9MaRtH6Sw2gjRXVT13CRTZzgJfma7baNuWwsZWEHWebmSfxwTEtMqI3i1jAarDQqUCPG+3yipu28C52TbbAQFgBfOTyABJalkBfELlG/27mHpaqfJwuAlAB68XWw0fyujBiZAK+OSVD1w5m++YXhEtQtzZuBunJNPUrU2/C6bTHg5sRBizVcSRS3KQLwCCl0HG/fFk7Rb1VpQ5h/y59F5a/fUbfZfODwdhlfN4A2NhCJzHkH2WL7LM9/2+RjO08NMDdus0ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6949.eurprd04.prod.outlook.com (2603:10a6:20b:102::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Fri, 15 Aug
 2025 22:21:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 22:21:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/2] pci: endpoint: vntb: add MSI doorbell support
Date: Fri, 15 Aug 2025 18:20:52 -0400
Message-Id: <20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMSyn2gC/x3MQQqAIBBA0avIrBNUyKKrRITmWAOloRGBdPek5
 Vv8XyBjIswwsAIJb8oUQ4VsGCybCStyctWghGpFLxW/w2XnI9PsYkwW951bL7w1i3badVC7M6G
 n53+O0/t+0KbgDGMAAAA=
X-Change-ID: 20250812-vntb_msi_doorbell-bf0fbac6d6d7
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755296496; l=1029;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MqzmwyArZfAvOi+P6AZYS835aPYyoeKgtaDcNuVnmeI=;
 b=6rM2Olb244GoVVHZ1Y5U1IhW9RkfP5zdIwLHRmsySWcgOpczgvh3AA6ML0n1Ryf7EQQWNNh9a
 OXliIGGfbciCYmorgBqGa8AclCF1CkZttIlYB9HxhXHarb9Ev5TEi40
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: c51ca44f-9a82-44fe-d3d1-08dddc4a1a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXRvTTg1L08xZUJxQzJBdjNxRWdGZlNGNWIxOWt0NHE1TzFEOE5SL013L09j?=
 =?utf-8?B?aElCdW9QZ2Z6STBkT3NqTDhGZE1sYytzUEtOb1F0MC9LZ3lkTm9rU0tIbnRr?=
 =?utf-8?B?K2ZVMUZSWHNuQjhNOXQ0MnJzaTdObzVyR2xiYTgwMm1VT0lJS3lwaFdKRjZH?=
 =?utf-8?B?SGxXM3B4azlubnMxZTdZR1pBOGlqSVBOZTRRYmpzYkJYNUNqUURGaTI5Ylc2?=
 =?utf-8?B?Kzh6YXFzblBOL2VrSHEyQi8vcnFEWWNORDZCK1BKOTY5RXE0OFJFS3VoUU9T?=
 =?utf-8?B?VERMS3hmWEhyb2J5bHFXZ29GeVFtWTAwSWtLOGY1R3V1dURTaEdLbzRvZHdK?=
 =?utf-8?B?cnM4c21HOTVKaFcyTlZqYUNabTVzK25vMHpSRSsyL041SUJjalB2VzFkaWJr?=
 =?utf-8?B?eVhLQk9sMm1VaDY0Ykp3NUFqSDlZdS95VUs0OW5BT3o3UVhFSUFMZVFXWS9a?=
 =?utf-8?B?eWNNaVhlK0dDVmhzKzRGSGZYVjBycVFYTGU0cUVyT2FrTzhnSnNiYm9Cbnp3?=
 =?utf-8?B?TDJNUWhacUJnbFRkNkRzOUVMbDBmZ211YWlDRE1QYmF4VjJyR0JiZ0lhVW1P?=
 =?utf-8?B?dXNUQU1GM0VMV3ZtQVcvQi9hSG1ZdnpZUmtCMXl0TURkeXl3aFlFVklISC9E?=
 =?utf-8?B?SHUwRVo3eGhXWlJ2NEZKeUpXS3Z5QnVkZTJVS3QrdjJySDROcFg3ZlpENlQ3?=
 =?utf-8?B?aXVXOE56dGN0NmoyQzNWYVNhZUZmYWhkbXVqcFpKMCs5T1NpbHkwOFpka1oz?=
 =?utf-8?B?bWVQUzg4SWw3d2IvZUlML05YZmR2Y2YzMHNwdDA1RGdTMllyUjU5VzhoYURI?=
 =?utf-8?B?TWlTUnBoVW9ucDkvSUp0OXlJT1l3NEs3ZStidW5ZSXdQUHp6dzMvL1lyN1do?=
 =?utf-8?B?NW1FY2tveUhVaURVM0w5dE1ZR3pRYXhsQnFmVjNKWmlwVnZOU2l0TzZhSlU2?=
 =?utf-8?B?ay95UXlvcTBkUGxTdC9iNjZQK3F5ZHB5OHQ1T0pDSzh2dm14WGdINjBIWnJt?=
 =?utf-8?B?TlBHb2szSXpZek00R3NoM3lzYkVsNmdHNEVuNzRyMjBveUgxZlgwTklIYnpM?=
 =?utf-8?B?RHJHRkIvZy9JRFdjZkhGa2s3WVVNTG9FbnJtR3ZHM3VOay9PVytZVGdvNnBE?=
 =?utf-8?B?WWYyTEFaaVQ3M0dxei9kbENORnJtTGxKZkF4dzlGenFGUXYvOGdLdXhsOU5t?=
 =?utf-8?B?VUhidnVjRWwyZFNBUXA0QVE1cGhOOWU4UzZDT0Y0cGxDMUJlNkJOV2V6Y1lR?=
 =?utf-8?B?dGt4eDNDQ1JmeFF1Y3IyV0JGZ0tibDJJckZMTFdNZWtZTlI2dXpZb2ovbHFy?=
 =?utf-8?B?SXZpZXdqRnBFcGlNL2FhM1FGNFBzcHFwaHdOWTc3a3hlekd1aC9nR0Nhclg1?=
 =?utf-8?B?MEd3QnlqZGpEL2Q1SDRXb0hwcnNZVnREWmpMdnFvVVRrSGNGZ3NudXppV25t?=
 =?utf-8?B?SmljMytCa3BvbkVTTVFORkQydEFKOHZiOXJlQkRRODNmNUk3TGJhUmxUQ2or?=
 =?utf-8?B?WHhvLzdsNTQ5TU5kMWxNaURMQmVTQUxHSDJDNWpyN2Qvd2lPNjNQQUJ2S1h4?=
 =?utf-8?B?SGU5anA5bTVOOWtvaXFUanhRSkl6YUFwODh5cXVLYUxIS1hxNWVZN2JqSGV4?=
 =?utf-8?B?Mk1uaE1nZXowVTRZQzZkS0VUaDBHZ3JGS0h2ckVldFNsSERvaHlOQTJjdVpR?=
 =?utf-8?B?MngvTkJzdEYzbE1wcWhoSklacWd2REFxQmFSeXpEQkoyZTFMR1UwZGgrYzlZ?=
 =?utf-8?B?UzlwUXdoUlhnZGdtcFpIcDZBV0ZVN0t5OHIyOHg2WTRqU0JxZmlKSWZpN3Ax?=
 =?utf-8?B?UURCYTRnbC9HN29tM3V1c3hwaUZac3czMG9FS3hqVExlVDZTaVhqZDlxQkNi?=
 =?utf-8?B?U3pvYWRyQXIvdUJ6blp6WURuMFkybVBHdUZock9RVHRMR0VmSXZkeUd4ekVC?=
 =?utf-8?B?YThmeDJZemYveGRmZ2IzdGRET3FDOUh2UDU2WXU0eUhkZG9WM1dmcjE3RWdE?=
 =?utf-8?B?OXMrY24vdnZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGoxUTF3ZUFTVXU0Qm1KZi9nVnYrejJBUUVrbU1lK2tTdXk1d1YwczZZcW1R?=
 =?utf-8?B?WFhteDMwbzhXYmN5eU16YjZGSC96OXBYZmNvZVBPQjYvdzVtcUZ6ZWlvYzFJ?=
 =?utf-8?B?ZGo0dGMvdDBTVlhvODRFczJzL2NNMkR3b2Z0MnhrUC9JWHd0ZC9uZFJ3empw?=
 =?utf-8?B?WnBGYVU1TnA0YVZrQXVCWHJEdFVCMW01Tmlib21KalBEemtnU1pjcXozT2Z1?=
 =?utf-8?B?MGFEMkI2eHhEYThqclNyVDhtZTVFcFJiWlVDcUVZc1NZVHd1NjBmVXJubEd1?=
 =?utf-8?B?aDlKSzJGWFd5cWdxTGliUHp4UlR6dndPbHkyYjRObzg4SXh1L1RHVDBoeURR?=
 =?utf-8?B?NEIrOURVKzE0UG9OU0FnNUtwNmhwR2kxUVNZc1pDWmx2dDVjSk5VQzVWMjBW?=
 =?utf-8?B?KzRRa3dWQjVER3I1Ylk3S0RnWVQ3MktYVmJMMC9lZ2hjOUFUMUQ2cjc5QTZX?=
 =?utf-8?B?Rmg4UGlaQTNLVXBmM3lKT1pmcUVnblFmQS9WSWxzczRoQnp1Y1RnTGtnOWtv?=
 =?utf-8?B?U3lIQmx2L0RtdENJMzRuc09ZdXVEU09iTWVhK3lNTngzM0FmVWhCMDlucm9H?=
 =?utf-8?B?b3l2MkU4ZEJPSTBORk05STJuZXJ5dFgxbm5vREhxVHpyV2pjWGplbWJXdVRC?=
 =?utf-8?B?ZWkybXhUbXcwY1NXcWVkMmVLVFhFQXE0a3o1ZWk5bG5LZnRoNTlkeVdVVko4?=
 =?utf-8?B?OEgwZDE1eDBadEhyMEgwNXh6N292R0VuNUQzOGR4NU10Y2RzSFFXODBybHhB?=
 =?utf-8?B?QlczK2RQSGsrOWowN3VuUS9DTnZMdGhHSGdkaGpyTzl4RmNmU3pPeTBSNkQ3?=
 =?utf-8?B?Y0N6VGtSK1F4c2F0SEpHY2txcE9adEtuME00NGVZeDBjOGZFSWJpeEpEdWNL?=
 =?utf-8?B?WUxlTHlENkFValJTakJBSExJcUxkakhlL2x5ZTZMQWpldmdvUm0wM0NwZWdM?=
 =?utf-8?B?ZFhJVzlndERsZmllYWwzU2tLUFFnV3o1Mno4Nk9ybFIvN0gzTFNUVE56Q0VK?=
 =?utf-8?B?UExrRDFuYzlmZXhDUDkrbFlIMFZmU1VsUTJKeXpFT3dFMG5QemsyY09QZk5h?=
 =?utf-8?B?MUhRVlhjOFRWc3R5WVEyZDFhWFQ5RU5QM2tHQ2VWRjRaRmpyYXV3L2RQZElR?=
 =?utf-8?B?T2VGNlk0VzBWa3ZUcW9WZVdDeVZLaVpxbHFKNnAvWFFNd3ZUQytPdEF4MjVI?=
 =?utf-8?B?TDlmb2lNdTZ3UzI4UHpHZERmSjBkMmJ3d0piZ2NFdDk2MUo1VUwycGdpalBK?=
 =?utf-8?B?ZUljYUZadGkzeUw1QXB0WU5lOWd2a1ZBRjlRYXVxSjZmMDBXMTBldWI2UlJM?=
 =?utf-8?B?UUs0U2VOUzRGMXZRSkEySGwrckgwdXVBd2xET3BQMm9JYXUzeXVZM000TVAw?=
 =?utf-8?B?K2RtdG9qVnprZi9wNFBmOGtRNDNZQnFIa2prN0o2dlF2SnhTL0lSVWZXSlRy?=
 =?utf-8?B?cFRlMUt0MWI2ZkErbFBMQ1kwRXNmQStDS0NNcU94ajV4MFM0TnpRYjZTVzhZ?=
 =?utf-8?B?ZUZWampIRnY3Z0VLUXRHUit6WWpDalZna1VHd1A5dEl1dGN1cTdZSzI2LzVm?=
 =?utf-8?B?WVBBUGtEQW9MZy9WMkRYRkdzdW5jT0orTEdrR2c3YlVQWlprdnN1d0NPMFlr?=
 =?utf-8?B?ZzdoOU5YSFUweFpGcUVWYWl4SlZYQWIxUzNXNkRaY2tZTTY2YXVRN2c4MW95?=
 =?utf-8?B?VkR0TzliS2ZQL2wyQWprTzRVODFsQlRuTjFSSHprbmUxRUc0WjRld2x3ZjFV?=
 =?utf-8?B?bFlHZWdXWHlYSkNYT1JtZW5rRUF6ekJlK0lmamgvQWtnNEZaTjBpdS9VRnJr?=
 =?utf-8?B?QUs3bGs1R2g2WFp5cXdvRU5RZEoza0QxVGZURGUzdzhLbDh5b3VIdW84dUJL?=
 =?utf-8?B?WGNLbGFYSHQ1c1p4dHZobUhoOURKSHpLZVR6QnJTT09TUXRmUGhpNnJ6TXlD?=
 =?utf-8?B?V1hkUkN6ZjhyWVQ5eUw3NncxOEEvMk4vaHR0QTY3U2kzcXhVdmh6YUJKUWZx?=
 =?utf-8?B?Z0FHZEp0aVZkcVNSUjNxc2x4a1NkRWo4QWYrWUdtRTRBc2sxNVBBR0VvWUpn?=
 =?utf-8?B?VmRmZ3hZNDc4N2E1TUgzRXFLUEFoSGNYWFhXTW1UanBYUXVyN0JrUkpHbWZD?=
 =?utf-8?Q?C8v49QMedpZREzOefd7WJMVVm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51ca44f-9a82-44fe-d3d1-08dddc4a1a6c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 22:21:38.8152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+VVLJXId6mTNmtbT9ClC3scv1D7pPwTcNgQbOhHkkBjHmobVSAM2uO2s11J1vr1k+vATZ9Ha50nE0sOxR3GQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6949

Since commit 1c3b002c6bf68 PCI: endpoint: Add RC-to-EP doorbell support
using platform MSI controller, PCI EP can get notification from Host.

VNTB use this feature to reduce ping latency.

The first patch impove epf core API to allow set any MMIO address to specfic
bar.

The second patch add MSI doorbell support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (2):
      PCI: endpoint: Enhance pci_epf_alloc_space() and rename to pci_epf_set_inbound_space()
      PCI: endpoint: pci-epf-vntb: Add MSI doorbell support

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 153 +++++++++++++++++++++++---
 drivers/pci/endpoint/pci-epf-core.c           |  69 +++++++++---
 include/linux/pci-epc.h                       |   5 -
 include/linux/pci-epf.h                       |  35 +++++-
 4 files changed, 223 insertions(+), 39 deletions(-)
---
base-commit: c2a282d1fccc53a989da61a5da4f03c9d67ee99a
change-id: 20250812-vntb_msi_doorbell-bf0fbac6d6d7

Best regards,
--
Frank Li <Frank.Li@nxp.com>



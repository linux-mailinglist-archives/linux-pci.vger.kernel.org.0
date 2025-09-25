Return-Path: <linux-pci+bounces-37012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8A4BA0BBC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 19:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76497325C0D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2DF30C34E;
	Thu, 25 Sep 2025 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kj0aYkIk"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798930B516;
	Thu, 25 Sep 2025 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819735; cv=fail; b=hiaOyUwU76Lhk6qDaj9hwMhwNTTBsPcnhBwqT+xf5r2+y+QxWtx02JK0id4uIeP3IyeCZrQnJ0X7ABP6ALpZrTLhYHWkpSALzT7vfC1c0U8nSQ7NijpmjlxgHxsj7Mjx2BGEn3tRnydlux2+OTbLU7rKFe2SDuSiwxnXfQsXbho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819735; c=relaxed/simple;
	bh=n7+HBmsxS2hjy6NHFW4wwkwO63xBQi9K/HkBISFlVg0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=o1kq6OpyHsMN/NlG7jTKwxXykhSz8molmzWCbq7FZPyhOgTSj5pEkkle3WD69ppDMJ/Bnf5bFmohJE/NTLRfFJXsC257KXZwSnduxCv7mA+72t0bdW72HSBbMWNUzPSbEz+NJCMkxJl7wJAL5Kj5JRuT5NQcm4L/o+aBf8RK5wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kj0aYkIk; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEI86iesEia+REXf0AZUEtEWXX80vZHzdvr5iWIPTJgEb0rGzT5/IRwwbuETp31EAplVEQo/r2ZmI1F+2lJEtF5azfQ18Sspf0tD0xNrQi1wnzkLltQrBOk5SufwykDu6OtsmE8UTh12fPyQYwmjTz2IBHqvw1onf9fcNOykqQDDEhfK2tLiugfSr1loEvVFcoY6+j3/qINpNwVS8qPlOtQK7SgLYIiEgDcltL4M/3rqbAM9RBNVljNv1FOqlJSHtTg35wKKwdTNwpHNQnO2ixBaCfMM2FNw6mXb3XhEpUn8/FzklrAeK0eEi4euhryoQmyRfYtWZnFquRRnSEeuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2KsjECl1vAnfDHcCCRB9dpu0+0u4IzCI6UceU2lX9c=;
 b=IFeRTgUAbDvvfQx5c8UHbzQ0WOHAZgFYu1aaDRSEz861zp9x9iqyJyKhjpfCVaK+OyzG0fz5tfOTeqIMI7hiI+htE4QW1C7O9/Mk5Y43mIdKomYFGGRb6ab0P7rnSJ0Iz4/p6YTQosh0lfKmne6lkgcCq45NjRAIRggnwH+gosoYqYu15kpS7p9qspd+c77dhrXvZKKkbV/QDRWq6/EIteO71W3tPsG5pGkVUKiEPNToGgSV2eB6Nz3IESsHqhWu4tX8fLGB0S5Rhyd72uCNjfTL935UZdN4HV7a+KmZRl0lpivfrHwaXS5Hgpt0iU1DQcNGXSDR7hW4/cLnN8iSHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2KsjECl1vAnfDHcCCRB9dpu0+0u4IzCI6UceU2lX9c=;
 b=kj0aYkIkt+mEtu7ETTlJtf3lt7g1MTfxRmM7b3Q8O7Xt5iljTi1Pe6vyy/CmGcx87LFUyRC6E+w06MjcqHvYSE+Yr1HTAAAsnA47EN6T9oPghKf4YV/MkdTiv+9zBffXfhQ6LBkR+LangB+Eq/t7xvFTN8iZKvp81bS4sNJJwmkGRsEsxctBaDgpQQwagdBSihjgwYZ3tgaN0wfK97DPkNX+BNMxwPHTHW/AnVNDwSutnkwQor2qybSKNJgRxF/trpYeRnTg0Q2wflfQ6R+GTh07dm08o+8FrVN8usdVB2881KNnawTAX8s/xzNdYdIDI7taisvR9VlJ90t4cecxMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 17:02:11 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 17:02:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Sep 2025 13:01:48 -0400
Subject: [PATCH v3 2/3] PCI: endpoint: Add API pci_epf_assign_bar_space()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-vntb_msi_doorbell-v3-2-ae0b0c93caae@nxp.com>
References: <20250925-vntb_msi_doorbell-v3-0-ae0b0c93caae@nxp.com>
In-Reply-To: <20250925-vntb_msi_doorbell-v3-0-ae0b0c93caae@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758819722; l=4952;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=n7+HBmsxS2hjy6NHFW4wwkwO63xBQi9K/HkBISFlVg0=;
 b=d4NFAlNy5ZTmUl1nvDjLJ9DlctHk7F0dW+xZbIvaL0zv2kKVdIkbW68j24mnyyLZXnI42xuHl
 LZUdPIJH9byDvsidxSVNjXAYYvynk94Djzb6+iZezT4J2AybZ1EErO4
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::12) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: c39877b2-36d0-49db-3aaa-08ddfc5544a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVkvWGVrVEtmaVBzcDdXSTRhT1lGTE1kaUw4UEwvTUhDQ1N6L3haQTVGekQv?=
 =?utf-8?B?dXFnMkdWNTZXN3B1T09jMTRmMWhERXZ1YWZ2U0RnZHRybmFjYnR6UVMrc1hz?=
 =?utf-8?B?aXRSSFdZcXFhT3JPRFdGWWRMWmtrcUZML01qaXBMSVNwSTZwSkozUGlYTlFt?=
 =?utf-8?B?Zmx3Q1liV3lTUTZCNTVZYlZoY2NFM25NU2RJbnAwY21sTmxZOUJBaTNWOU4y?=
 =?utf-8?B?RXNTN1ZlYkpQY0VpenRSSDRwU3J2WFpkOHhVanhoYWkwczYzM0Q3M251Skor?=
 =?utf-8?B?RlNPTFVqVU5FNEM5Ry9WZm5FSjNsK3VLdDhtS3dpbVRBT2hianBhT0lyWTdE?=
 =?utf-8?B?TWY0NDNsdTl6Ujk2YmNOdG9JTHhTSEkwMm5LVkZ2aTVVREdqdE1NR05EbUt0?=
 =?utf-8?B?SW52cytQeEZGSjJHR0E0S3JMZVRSMjRzV3hzSVEwaC9zY2RNVUdHQnNWd0Rt?=
 =?utf-8?B?S1VKaUFwZEJtQjNxY05vWm9IZk03amd6SDBHZ1lCMWY4c0xmK2x1SlpVNWxi?=
 =?utf-8?B?OTFRRyttOGE1ZlkvTnl2TkdYTTlJNnhTK2RpSnhaYmV2SWptVStxZkZLR3F2?=
 =?utf-8?B?QWpqRWpMVXByNHFkby9idkhlVVpZRDMzQkpOV2d1b0wvNThWWjY1WVRYcTQv?=
 =?utf-8?B?ckFrU3l6TzJNTmdma25mMG5uUWxOLy8wS3RWNzZQdGhIUUVud1FJWlQ0MjEr?=
 =?utf-8?B?RWt0R2lvUk94cDZ5Q3JIUUZCZFBQWE5jQmV4aE5Nb01mSzUxOXZOSy9wNjZH?=
 =?utf-8?B?d0dmZ3BPcmh3dXFOY2tyZW1xR1ZmV1BMWmpESlFIeXpXeGVZcHhYMnA4QlpJ?=
 =?utf-8?B?ekROa2FIT0Nvb2N2SjhkWU9UYWxXMlNHN0pQYUx5L1dVQktmaHZyVVBwa1JX?=
 =?utf-8?B?dURNMmh5UWxET0JZWlRSVFMrU3dEYUlWbk1ZclhGbjFqTTMyUFNvT3NuZGZi?=
 =?utf-8?B?cmxTeEw4R3RSVUJmVkhYZnpjVjZBaC91czkvS3FVT01nY0hGNmN6U3hza3Fz?=
 =?utf-8?B?NXNTTkxFblNwV0hMbkk0WTVGcDNURDE5R2tIYWNWKy9xZVFaUDZVRW0rdzB2?=
 =?utf-8?B?U3hXaTRQajlieVdMRENsNnlhbVNOcElLZ1pjUVRUWnd5Zi96cjBSRmVybTQx?=
 =?utf-8?B?KzFkWnJZZVBrWTJIeU5GV1dEREtscDBhRERjQkJnWEVzYVNoT0Z4MS9hQ3E4?=
 =?utf-8?B?dlhNUC8yMWdQU1hZWHJRRmw0Z3ZteGlCNlBVdG5qUWZLMnlKUmZKL0dPVFFt?=
 =?utf-8?B?TjdITGp6SWRBY0RsMTh1cEpZOWNhR2FYWmJlZGxrc1Z3VmQ4Ump0K1VHL28r?=
 =?utf-8?B?L3J1cEJxYUg2N3dtOW5KK0ZPRGRGTjliV0VNKzdMR1JMN3d0YXhsR0NTSmNu?=
 =?utf-8?B?MHAvcDNZVUJDc3ByWFFOT0FPYnFqTFkwblpqdkE2UldCbVhLU29tWml3d0N2?=
 =?utf-8?B?VDJrY2MySWs0QndKKzlVV081VWxZeVNQTkpvUWZyVnIrYlowN0RxMm8zNkxB?=
 =?utf-8?B?dGVzK2RleFUrRnR5eEgrY2h4YWYvWk1xTDZkZkRIRGxxVmZBOWY4SkYzQndh?=
 =?utf-8?B?dCt0QmdSUy9NVjduQU5jVEluSHpRVm02OU1haXhwK2xGd2xtNllHYnZXaVBI?=
 =?utf-8?B?TnlkZDR5Ty9lUXp1YWVwdnRTNjZxd1k1TTFhblN5anJncW55OU5uOEp4ZnJG?=
 =?utf-8?B?S2FDODR6VWIyZDBlV05ocHh0WGFBZ1dwbFg4RitwTkxxTDUzS1ZJZ2dnOFQ5?=
 =?utf-8?B?bUV6REkwTzZtd3JvSDl4alo5a1dLZmt3a0lqY0xvaFlkMDZnMjlqRU5zL3NH?=
 =?utf-8?B?ZWVkZ2x6THd1S2VFQ1k5V0dlckhFMURHazJRNWFWZ0FlQllwT2taY1RDbktn?=
 =?utf-8?B?ckpHSWpBTVJKOXhxWWsvSEgwSUNJUm9QbjdRSkprMWJOQzEyNE0zdiswTlIy?=
 =?utf-8?B?VFJRRHh6anZnbVBSUy9aOGwrV2h1djZNdVdXZVNDK0YwN1lkNTJIUnh6U1d4?=
 =?utf-8?B?bGVqYkk4dEZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2dSd1NyRXcyZFlsb1F3dXEwT211SFo0YVRWcEdSbUh3YU5IYSt4cjZidjUy?=
 =?utf-8?B?MkVGUnJIa2xaSmtuNTdRRjdVL1JJcWdWN1pZbm9QMm56OThxeUw0bzArTXBC?=
 =?utf-8?B?aDZ3eW8yYmxNa28vVmo2YVFVeTREQVpTRUJZTDY1cERucUN3L3hJTlhzMlZ1?=
 =?utf-8?B?bStMSXFLYlJ2YjN5M1A5Sjh6d3FZZWhLQUFZT1d4RkIzZHUvU2pORkNvbFBi?=
 =?utf-8?B?a3U2blZ0a21ud2JDQlNabGNhZktscnFhL3pYRGVEVGRBem5wVERkQXBORm1Y?=
 =?utf-8?B?aE5XK01CSUlidVdCbFhnZVN6MFNWbFVyM3FGVGpGVm5yaXZxM3l2eWNMbUpx?=
 =?utf-8?B?SFE2aWVBbnVGQWs3M1U1VEhGS2sxVTEvV0l6ZG5UbDhvREl1TGs2c2RDRzNI?=
 =?utf-8?B?NnlDRFhpTDlXVDF2ZzJodnpzNWZUenVwYVdWSWkwTURLZDJIMnZWVE9KRlgv?=
 =?utf-8?B?RXZIbDBKNFB3SHNiZG16ajFQamlIQVFDZ1BtWnFvdWVMamovWWMrRmwveGFY?=
 =?utf-8?B?WklDeFJReWFGb1ZJSHhzdkVuUEpyeFoxaExXZkQvY2xWVyszaGVBMnVvZW9O?=
 =?utf-8?B?UllKQ3grTHNleWhYWk1IOTNhMzRmZm94S0llZkVJZEFjN0orM0lqK3RHUWUr?=
 =?utf-8?B?dUpPd3JKK2d6WlY2ZTcrMmdodkFzaVR4ajlVQWRYOFpwRUNLT09XMk1IaTRM?=
 =?utf-8?B?YXorZFZDd2lONHQxbW5jUzN4Vis1bUFFNjBRSkVYYjBVRnJ4N2ovSjQ3ZW5Z?=
 =?utf-8?B?Q1JrWHU2ckhSTGRVd2VBOW5ZWk1uOFpNeDV4Qytsbnh2SXl5SnZVRlJLLzIz?=
 =?utf-8?B?SkFjUzgyMmVkQVVKdjVmaE95Rld3cnkrSW5RR1pjRDZoSlgzNFA3NE9seFVV?=
 =?utf-8?B?Q2RNd2pteTlreUtxZm4ySGZSWmhBaEN2anhKdE9Yc0hXM296NkUvQUpBUjd0?=
 =?utf-8?B?MzNOTmx5MURUeFAxbDlDSHIzOGJ4bzR1Kzl6MXlQNjZFaURwVVFqTXJsZ2hK?=
 =?utf-8?B?a0FwdGhlREVDRHhyUGd5LzYyYkdQakQrVlF0aXd3WjVHcENxN0x4OVFTM1Nt?=
 =?utf-8?B?dSt1OW5aSlZ1SHRRZVNyLzIxTU85SlMwQzNNLzJyNktYVndmd1BwTWMzVXU4?=
 =?utf-8?B?RC93QXdUZWhoVlN1UnU2K05HdU5yZG1meC9GTVc5T1Y1am1ISk1vbEsyNXd3?=
 =?utf-8?B?SWdVRTRoMG1PblVzUlV0TzlTSFd5Mk9sajRYQXZZcWFwc1RoOTljOHd4dVpM?=
 =?utf-8?B?QWJaaFh3Z0UyU0tOMzFhT2w0T3lobTMwbXdBWEwzSCtWLy9YVEk5bVhRanhx?=
 =?utf-8?B?VndvOVR0b1RtVGtRL1p0ZHdTQzU3RmNFeTFZbCs4OXUxZHJEeEFxOTdaQ2hh?=
 =?utf-8?B?VVZEWDE5bGk3V3IvRE0wN0poUlkrV0Q2QUdtenViZmpCZHlMUTR2aCtiMXV4?=
 =?utf-8?B?TW42aW80N1dGNENiWStDTStNRVdGRUg1cys3Q0FpbVZ3c0lkdGUxYkE4ZjdW?=
 =?utf-8?B?cTlyMzB6ODdMaDl1L0pPaGJkTStGQjZMSXpTaTIvZWFxYXZCMkhjeXdoN1Bq?=
 =?utf-8?B?akp2UUNtVE5IQVdDcGhGSzNyZzZYTjNjQXJ4ZlhwWlVmN0RsNU8wcG9jVGx2?=
 =?utf-8?B?c1VhVHRDempoaG03MWd5UnZISlkwWXBNSDdDMk5ldm5YSGVIdTVjeVg5ZnRr?=
 =?utf-8?B?WUJZSnExRmFEdWxXL2xMK2xiZUVhM3QzeGt3TWp3cHhrNVdYY3BTTUtMRWlQ?=
 =?utf-8?B?YnlrQys1T0krVk40VngyTVhobGpmSlNyNGUwUG1SZ2JJR3BlTlFrcE5PdjdP?=
 =?utf-8?B?dk4ydFNCdzVYMDdXb0l5WTQraWNady9PZ0lncDg2ejB3WndabjVHNnJwVVk4?=
 =?utf-8?B?RnBhNE8xZG5DTXUxeE1RZDVTUmhYZjdScTlmdkNHUVJwUWxXZWhCZkVVb1Iz?=
 =?utf-8?B?QkdkcTduZE1NNGk5VEdwRFI4S0Q2VEpaTlgyeENxUmNQVW40bWFJMkdaWTVO?=
 =?utf-8?B?SzVGekhFRDA0MUVSVlVBcnNMR2cyTnZoWkJabndWN3ZDY1lqdnpjSlYrTmV0?=
 =?utf-8?B?Sjk4N2Y5QklJdXF2eDMxdDZQQlhaY3MvekMrSlY5aU13aHRmb0hXT3VsMVBp?=
 =?utf-8?Q?wuTSu3atGQ+VtBcPs/MzhUoZV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39877b2-36d0-49db-3aaa-08ddfc5544a5
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:02:11.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1T+LNaTQPGrmYwwonDbLIccc4SZ9ciV3g+2urz5aMZZj3TF2tuAO9GmfD9/dSzKTc/pd+VlVrLajD/Ie+21Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6871

Add pci_epf_assign_bar_space() to allow setting any physical address as
inbound memory space, such as an MSI message base address.

Since PCI BAR size must be a power of two, the input MMIO range
[inbound_addr, inbound_addr + size) is mapped by finding n such that
[base, base + 2^n) covers the range. The base address is also required
to be aligned to 2^n.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
chagne in v3.
- update function name to pci_epf_assign_bar_space()
- s/allocated/assigned/
- add check when align down input address to memory align require, may not
bar's size can't cover required ragion.

change in v2
- add new API pci_epf_set_inbound_space()
- fix bits 8 * size_of(dma_addr_t);
---
 drivers/pci/endpoint/pci-epf-core.c | 84 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  6 +++
 2 files changed, 90 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 2cd0257831f9885a4381c087ed8f3326f5960966..b5c33708358130b2d056ecb7e7cb602a76360875 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -350,6 +350,90 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
 
+/**
+ * pci_epf_assign_bar_space() - Assign PCI EPF BAR space
+ * @epf: the EPF device to whom allocate the memory
+ * @size: the size of the memory that has to be assigned
+ * @bar: the BAR number corresponding to the assigned register space
+ * @epc_features: the features provided by the EPC specific to this EPF
+ * @type: Identifies if the assignment is for primary EPC or secondary EPC
+ * @bar_addr: Address to be assigned for the @bar
+ *
+ * Invoke to assigned memory for the PCI EPF register space.
+ * Flag PCI_BASE_ADDRESS_MEM_TYPE_64 will automatically get set if the BAR
+ * can only be a 64-bit BAR, or if the requested size is larger than 2 GB.
+ */
+int pci_epf_assign_bar_space(struct pci_epf *epf, size_t size,
+			     enum pci_barno bar,
+			     const struct pci_epc_features *epc_features,
+			     enum pci_epc_interface_type type,
+			     dma_addr_t bar_addr)
+{
+	size_t aligned_bar_size, aligned_mem_size;
+	struct pci_epf_bar *epf_bar;
+	struct pci_epc *epc;
+	dma_addr_t limit;
+	int pos;
+
+	if (!size)
+		return -EINVAL;
+
+	limit = bar_addr + size - 1;
+
+	/*
+	 *  Bits:		15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
+	 *  bar_addr:		U  U  U  U  U  U  0 X X X X X X X X X
+	 *  limit:		U  U  U  U  U  U  1 X X X X X X X X X
+	 *
+	 *  U means address bits have not change in Range [bar_addr, limit]
+	 *  X means bit 0 or 1.
+	 *
+	 *  bar_addr^limit	0  0  0  0  0  0  1 X X X X X X X X X
+	 *  Find first bit 1 pos from MSB, 2 ^ pos windows will cover
+	 *  [bar_Addr, limit] range.
+	 */
+	for (pos = 8 * sizeof(dma_addr_t) - 1; pos > 0; pos--)
+		if ((limit ^ bar_addr) & BIT_ULL(pos))
+			break;
+
+	if (pos == 8 * sizeof(dma_addr_t) - 1)
+		return -EINVAL;
+
+	if (pci_epf_get_bar_required_size(epf, BIT_ULL(pos + 1),
+					  &aligned_bar_size,
+					  &aligned_mem_size, bar,
+					  epc_features, type))
+		return -ENOMEM;
+
+	if (size == 0)
+		return -EINVAL;
+
+	if (type == PRIMARY_INTERFACE) {
+		epc = epf->epc;
+		epf_bar = epf->bar;
+	} else {
+		epc = epf->sec_epc;
+		epf_bar = epf->sec_epc_bar;
+	}
+
+	epf_bar[bar].phys_addr = ALIGN_DOWN(bar_addr, aligned_mem_size);
+
+	if (epf_bar[bar].phys_addr + aligned_bar_size < limit)
+		return -ENOMEM;
+
+	epf_bar[bar].addr = NULL;
+	epf_bar[bar].size = aligned_bar_size;
+	epf_bar[bar].aligned_size = aligned_mem_size;
+	epf_bar[bar].barno = bar;
+	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+	else
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_assign_bar_space);
+
 static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 {
 	struct config_group *group, *tmp;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 2e85504ba2baf93827224884ca19ae2bd0e6906b..d2cdcc06d366ce61db0d7633105965e50cb49a7b 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -242,6 +242,12 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
 
+int pci_epf_assign_bar_space(struct pci_epf *epf, size_t size,
+			     enum pci_barno bar,
+			     const struct pci_epc_features *epc_features,
+			     enum pci_epc_interface_type type,
+			     dma_addr_t inbound_addr);
+
 int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
 			       u64 addr, dma_addr_t *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);

-- 
2.34.1



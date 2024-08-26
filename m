Return-Path: <linux-pci+bounces-12224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E3595FBD5
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 23:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD0AFB22F8B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 21:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF6719B3D8;
	Mon, 26 Aug 2024 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZBuUliYV"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B20219D074;
	Mon, 26 Aug 2024 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708374; cv=fail; b=iJBVJdPVG7CunjTDCPxszwredjWN13FVoAfQ6/WZLoZhPQ2izsyCu7caPXZJe2BHBc9b2XTrKdoUj5vtXoi8XgPavJKlKFmxX7TZkVnOSMaC27kwnn7IdIw9VH5m4QmEC7s6wj/DgWFVrzXdfoV5ub1h53pyVFAn5dOI7dXKWUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708374; c=relaxed/simple;
	bh=2kZ3aVNV96S5jPJPen/3/5i2TDjwI9Zl/lyNLEiI/aw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=H6aoZZzLXWuHAumijaERfgeV7h0mJCmijCGOKf0tHszRBh86/FRxj2Hea8NLamLGXgMsT54+FOhuK3KKwm4EGA4nmbNzw/V215eCNQtZ1sTgLZl3tzDnIpW10owIE4rxGkVJlwp77oJG/4OS5ONh+rp6tXdFp1LyIUIaoXb2K9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZBuUliYV; arc=fail smtp.client-ip=52.101.65.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umPCCDc3A4KdxpJNQoxE8qOQQVCSSWJZeHAEfOgihDHHlHzKH+UORU5XJ++TNn13mKHp86I6iy7xeTwxKru7IhPvAXC54hDQCpueJbr2HXQZwCkbZZrG0TEz8LlnpQN02FkYK5xgukQE7NQuFFdNFABrqMoQof0tl4f9hj6TUOja4x4dwHr4GLLY9TyyEiuby8Z92naQTZv4c6GNvRLbNFCixQKvSGWFdO28mXi8GA053y8v2RoCP63J2YKIJb8vCmh69ngqHLEYmHDtBx4rnZL6w8FFZcJdb74NB+O+YhEcs0WeL6+ilrZCqnNc0p1hsdrDcV5/JKpBv9LpuqK90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaSfsdOYObiB5SlYdLhswyhojE4sTGaTKQJIqSVnjpo=;
 b=M6VmPfjKom+cU2hjUQHEEAWKhFSthQhhDygCCHzBkbofpPniVcR0qx4s4EPDwNWLk4N9FgI4SEqsMZdngrzNymug3X2+Lk7CKRVbaH2WM59zO2N++uSrpVCIp65WdbOjJwIuUjuSS/1e6s0qlTsIl1tWPbdix0+3jPzIk0dRr/HdyeMLHFr10Syj0D06yHI0mkSx6/+DRDadIjydTj51g1jkkco9Y+JdBqBULd3fMQQzWYUe4lZNlHDbdkXRwazIGT/N014sLC9FGQ2477XCWQME8uzvY6gw0Ysot4hHEWtAAWYo0p95O/eTurqm5Jni0Z4xDGyIkUvRjPbxgVO4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaSfsdOYObiB5SlYdLhswyhojE4sTGaTKQJIqSVnjpo=;
 b=ZBuUliYVoOYWzD7+Wl1Hm0Gu1Gwnhxbaeeqw5n0zjHOnt4st0ee3m9ojvsYYxttfF6AJP33Ra2ABtGxGso2XN3B4YrxjjM1ZJidYiHJL8AwYK4081CFS8iE1vAonExS9vry1fPpy09wMfHUsuCkYh0DE9of8pCi/bb1608zrhWx+SWhxk++gTV9y/NyEuUgQpyYDLZlS5g1/E18DTW2RY2NmzG3W6ubAo3tPT7t1LZ4k4C9gmv808q3yxsBSx40Ox7PxtwMzNGhUPpgln7l5yusBxlISgKXRggIwAFFttH2SNFWWFVQ9LH8gHE2ImhgQcwYZAw6sHPzB48kaTZY4Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9360.eurprd04.prod.outlook.com (2603:10a6:20b:4da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 21:39:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 21:39:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 26 Aug 2024 17:38:33 -0400
Subject: [PATCH 2/3] arm64: dts: fsl-lx2160a: add rev2 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-2160r2-v1-2-106340d538d6@nxp.com>
References: <20240826-2160r2-v1-0-106340d538d6@nxp.com>
In-Reply-To: <20240826-2160r2-v1-0-106340d538d6@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Olof Johansson <olof@lixom.net>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724708357; l=6343;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=2kZ3aVNV96S5jPJPen/3/5i2TDjwI9Zl/lyNLEiI/aw=;
 b=zCQMu6wQRucjssqOV/Ld6rZsto9tjcORSNFLSTNwJp3Shy1fRCRouMHctNSIXpwIWjIBHiyQq
 RK8wHrNusB0DW4dU4tdHca38Z/uPTw9MrzEuYh96QvVGKOaNcCd3Kki
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: f09e0f54-dbec-4a77-dd11-08dcc617901c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0w0NmVQNUxNL1oxWU1IMEtzZWQrMHNHcEFTcHhiUHoxeHZ2S3RYTjMrMWdD?=
 =?utf-8?B?NWIzYml4c3BOTUt5MVJJazBNYzY0VlYzSTBXVGZRaUdPb04xZk9EMGY0UnlV?=
 =?utf-8?B?bjFCYXdOTjIxMEl6T3BLVDZuK2tBZW42MHJNcXdpMGVQdlJBeXA4ZmJwODVN?=
 =?utf-8?B?bXpXZ25zWjVPMXRZS2s5Z1RycGZCOXpuNEVpS2VicGNoaHIzV3RBUTQ2cmR5?=
 =?utf-8?B?WVdWcC9NSEN0b1J4NGN3K2Q4Vm45OXE4enQvRlJncmo4VEFNTm1odlh1cE9S?=
 =?utf-8?B?em85QTQrRm43TkJEME5hQk5TNHhST3QxNzZpQ3pFN2twZit5ZzZwUlhRZmtT?=
 =?utf-8?B?cXdVWjI5RGVRakxhT0NVbGdJTXg4WGZuV2hSS0V0Y0o3Y04yMDBWQmR0MUZv?=
 =?utf-8?B?eGJzRUphbFNkWjRnS1ozR3ZScjhlWTVwSXlDTzc3ZTN6VTlnRmMxcnc4dWJG?=
 =?utf-8?B?Y0dMN25kejZGVkhHUVNrT0pYUDZLcWpTSzJzdWQwRWhZaERQTUhCK3g4SEhr?=
 =?utf-8?B?RHpnL3B5UXV0Z2kxZFBKYWg2RkxTeldYdWVVcmNZQkNZcG9iaXI4eDBRbDFY?=
 =?utf-8?B?ZWVnTFYrekdRaWxndjcwaWM1ZElPYzhOd1ladTdhR3V5K1pPVkJMbmVTdm5X?=
 =?utf-8?B?VUUzM0pQaEdVZnp4NHRTcFd2ek5XQzY0OHc5V0hTS21yRUpkamxpUU9ySnJw?=
 =?utf-8?B?QmM1aFJxV0JuQzZEdEtYU0h6YTlaSUdSVGtYUk5UN2dndXJaYmVWYXphdUJB?=
 =?utf-8?B?bWxCdmF5UTl1Z0pITVY4SlFTdHlremNqRXpEajgzMG9nV3k0b0pjTWpTSU4v?=
 =?utf-8?B?ZU5RNFc5YnFzV1NnQjNsNnR4Wk9HaXE3Z25JSmpiV0lTNWJJUU5aTGMxMEV1?=
 =?utf-8?B?bjZwYnpuSnlCZkExM1VOOU5DMUtyVUtieEVpV0ZGU29HTTE1d1Y2YkU4ZWM2?=
 =?utf-8?B?M1c2RzNUdHhmUTQrdnFxR0lHUUFhcW0wcDhoOGQ1cEE3SUFDdGtBYkZwUDR1?=
 =?utf-8?B?T00xZXkxYnRwRmJwdVFxVDZ6enZCbUpJdjBjOTFUd3ZuSkJGd3N1RkxDYnpP?=
 =?utf-8?B?Q2FOempxVUNjNlh3aGZsSG93ZXV0VURyeWFTcWZBelZDWlNHb1JXaHd1T0dO?=
 =?utf-8?B?SjJ5M1YwRDhacHMvTGpHNlJoQzd5SUpMWUFBY0luWE9CeW9uNE5zME1jL05q?=
 =?utf-8?B?U0pBS3gvR1VNdUVoQ3ppSTRhZm9VazVCS2hUVGlUMjhBOXVKNEZOUkhwQXpE?=
 =?utf-8?B?aVdiWTJuVmgvSGJxVkFDek9IMHVPY0JnOHNGSHp0Si9ncVZNY3pIbVlaNUFy?=
 =?utf-8?B?bGJRbGlVTzJhLzdpR3hpZVhrRUVTOGR5cjU3djQzSXRqWHBkWkZnUkhBKzI5?=
 =?utf-8?B?ekFWa2l1YkJFdUF2T2NzYW5WeHQ1MmJMOHFKcFRMcm9GNWRzZ2NwMkNpMUVy?=
 =?utf-8?B?SWtWVHVtZmxNQjFSZ1V2WExFNVBxWUZQS2hYWFU0V3VrRURtTXRHN0xjNENi?=
 =?utf-8?B?bkpLTzIyRUhxR1RhZ2tVQUlJK2hqRkMwMUdITlN6eVMyRVFQL01HVW5ocXJU?=
 =?utf-8?B?UnhYbFVmTnZnQzIvYlpYL3U4SnBqd2diVmZtZEhTdnpXWjU0OXBBWjllZTJw?=
 =?utf-8?B?MnRRVVhaclQ1K2MvUjdrR21zdDB0c1B0ZWg4eEIzMUl4ZGV4dTlCamZpdzBa?=
 =?utf-8?B?Q0hIVDJ2c0V4a0srSlZldERlb0x4eFJpNk84czF1UjNoRVBRaVNDUkZxTnV0?=
 =?utf-8?B?RUhyQ1NtK1FTckZaMXVnT3F1TmI5RnNFckJTVTR3N242Nyt5Mms3NTVvS0tM?=
 =?utf-8?B?NWdpY2I1bWZiQmdiVFpHcWtoYVp5Z29wVTArZ2dlRlMzVXdWY1kvTFZTOHBS?=
 =?utf-8?B?RzN3NGg1elRJRC9uOG14bVNwdnJTVEpCRU91K00wdi9XQUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YThSOUI0ZldrOXNjZi9FMjJOeVVSajhGQUpDWmx0d1hRNWs5TjdycjZsZ091?=
 =?utf-8?B?b3dKTk5za3U0dTEvQSttazlkbmxTd0xMV3JxNm1zeHRnUFp6S1F3NVQ1ZFpi?=
 =?utf-8?B?dy9hb3o5YXpxMnJtc0JRUjFBbUcvQWVsa0ZmbC93K0ptYlNrYUQ2ZFhrU0Z1?=
 =?utf-8?B?YTgxdzNPTk9jaElOTVFKYnNjVnN3a1RJa2tjeTYzMk5JbUEzK095L1F2VHBE?=
 =?utf-8?B?RkFjMnRHY3J4eWw0T2dVQmhvRFRLVW9PcEtNbnpEZ1NMTzA4OGpMUmt5MFgv?=
 =?utf-8?B?bnQ3Q1YveXpCNWJ6Tlc0Yjllc1hYclk5TS9JbXQ1Z0tTWUxUTzk1SnJEUjgw?=
 =?utf-8?B?K3QzOU0vZUU5VGtyeWVuZ3hrR0NIZjVPazZXNm1tS3UxZWtlUURwd084K2t1?=
 =?utf-8?B?L0JPVDRHOHFlNlA0ckdWQmFkSmtITXZJNCtHKy9ldzJOaUZXS0loZ1NORVU4?=
 =?utf-8?B?d2tySSttSHFpRzdvUUlnWVdGMXM2ZGFZUHNLbUJvWjFBVWhmSlVvb2tFQVhL?=
 =?utf-8?B?MTdzOWlkdlVYZWhaZnlmNG9qaS8xOXBzWS8yTVJMamorWWNicjk1VnZndEJG?=
 =?utf-8?B?bDVwTGV2RE4xY1BBN2J1NnRacWJzZVFuZ2VBVlNWZDNkZ1NoTXBzeUI4WVRx?=
 =?utf-8?B?eU1kckwydmhkdThqUWNZTktDUmltZ2M0bWFpbnJuaitVdHRZd0dPU3hVbFBy?=
 =?utf-8?B?Tkg0d3Q1dk1OQkJFMEdFRVZPa2NacWZmMWc1WjRhOGtxcy9yM1RPcGI1ZzFm?=
 =?utf-8?B?RGtacFYzUWUxc2xwUkRMenlMQkxHeGdoQTJsK016eWp5V1RlSUpoV1kwcHUw?=
 =?utf-8?B?TS96aVhzY0JwaS8rdnhrU0FqcU5JbGIxN010QUZ2b3JjSmxUcWpjNVpKNG9o?=
 =?utf-8?B?bTMyQWFtbitZU2g5emlvR1JtWVJHdVJaYmlJUkhVMy8zMjFvS01ITUo3RW1V?=
 =?utf-8?B?aVV1MC9CZzJEdnhlcGlmM3lzejd1Vm84emRzUU1id2JMcFBYa3hlQUhRMk9V?=
 =?utf-8?B?eDl4ckxISHU2R05mTnFralBlaVI0c3ZIYURIZ1VDdVIyb0F0bGMvN0pQd0lH?=
 =?utf-8?B?M3huRDg4ZzhNSys2TVIwUnp2akFYTW1OcDU0Z1craUM5RFd6Z0JSV2dvQ1ZT?=
 =?utf-8?B?bVh3ZWlvS3NIT1JkNFpXVVVlaUVralZaR3dNWllabjlSelYrK2sxaTZrWlMx?=
 =?utf-8?B?NWJlYklUTlhlUlVBbmZUb1drWXhtNUpzTW5PbUx0c3Ntb2NoZWIrZ2FBWmg5?=
 =?utf-8?B?Uk92UDlzWDMyNnRESVF5cmJmTllrY00rSzN1dEdBcEZyTCtNODdJamtzYlNa?=
 =?utf-8?B?RExLUk1CeU96U0huZFFEeVJMdG5VdzlFeXBoNS9PUW9Hd200cE1ELzgrOGNB?=
 =?utf-8?B?K0JQUlpQSHlkTkQzUGNzZnBQWGtpNVVzSmR0YWgrcnFzUGhreHExZlJieW1M?=
 =?utf-8?B?SlZ5L2lweDRIUlM3WmRTdVEzQmptN0xYSlU0TEFyQUtZTWU3Z2FBWTV0dGhk?=
 =?utf-8?B?QlJMem9VK0Q4SjF6ZjFacmVzMFIvazA1Um9ScUdjWE9xbWQ4L2VQRkhvZ3BX?=
 =?utf-8?B?NWlWQ1g5ekJvbGkwUWt3WDRTandqbm9qalhNOGxhQXRRMk82Y1ZoR3lOT2VH?=
 =?utf-8?B?dzFUL1REVWNZdGU1NXZlYTFIWTJoUGNIcHhDWU9WbGZEUDFEQXFUMGFMazQw?=
 =?utf-8?B?OGZDcE5tR05jd3NaNkpXWUpxTUtWbklOWUVhY2cyOWhScUpaS1VYVFlTRlRC?=
 =?utf-8?B?bUJEalU5TkhSOW9rSnZKczc2TDJ1MDNQMzV4UmIrZjlZcnJBRXF0S2tZWHFa?=
 =?utf-8?B?RFJpVVFYT00yRWwwckhhZkgrNTNudlR4Z0VBLzQ2QjdVeUlub1Y1a1BmMWdj?=
 =?utf-8?B?cVZXQldUMmZQalp0TVdxRVN1TU5wd2V4UERrSzdNengyQ1pyNVRxZlE5QVJI?=
 =?utf-8?B?S2Vremt1ckg3S3Q5cENNYnEwQzBlU1pOU1RwSVNGK1VqOUVmU0IxODFZODJQ?=
 =?utf-8?B?ZmtmRE5uQVVOVC9hRlpRTjgxVGNqV0V4cHBuaThYVFNVeWM5RHFkcnNGcnhz?=
 =?utf-8?B?MW53dlNwUWc5WEtwSnBMOE51N1VpTUh5eHljdjB2RDJ3eFBqcWhaNXdiSXNF?=
 =?utf-8?Q?WMshDVQC6krcvCIP9tMHHiQ68?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09e0f54-dbec-4a77-dd11-08dcc617901c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 21:39:28.4966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkQhc7UtRxqvWsn5A5wWU/V7/0u5+2QFQVYYiJacdOdvPQAoMyBGK9X+jhpwaAfX52t4ocj6UXcNpP7sdTgttg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9360

Add rev2 dtsi. Although uboot fixup can change compatible string
fsl,lx2160a-pcie to fsl,ls2088a-pcie since 2019, it is quite confused and
should correctly reflect hardware status. So add fsl-lx2160a-rev2.dtsi to
overwrite pcie's compatible string.

Add PCIe EP nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-lx2160a-rev2.dtsi | 170 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   2 +-
 2 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rev2.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rev2.dtsi
new file mode 100644
index 0000000000000..432e54f6f7ae5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rev2.dtsi
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree file for LX2160 REV2
+//
+// Copyright 2025 NXP
+
+/dts-v1/;
+
+#include "fsl-lx2160a.dtsi"
+
+&pcie1 {
+	compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
+	reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+	      0x80 0x00000000 0x0 0x00002000>; /* configuration space */
+	reg-names = "regs", "config";
+
+	ranges = <0x81000000 0x0 0x00000000 0x80 0x00010000 0x0 0x00010000
+		  0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;
+
+	interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "intr";
+
+	/delete-property/ apio-wins;
+	/delete-property/ ppio-wins;
+};
+
+&pcie2 {
+	compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
+	reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
+	       0x88 0x00000000 0x0 0x00002000>; /* configuration space */
+	reg-names = "regs", "config";
+
+	ranges = <0x81000000 0x0 0x00000000 0x88 0x00010000 0x0 0x00010000
+		  0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>;
+
+	interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "intr";
+
+	/delete-property/ apio-wins;
+	/delete-property/ ppio-wins;
+};
+
+&pcie3 {
+	compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
+	reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
+	       0x90 0x00000000 0x0 0x00002000>; /* configuration space */
+	reg-names = "regs", "config";
+
+	ranges = <0x81000000 0x0 0x00000000 0x90 0x00010000 0x0 0x00010000
+		  0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>;
+
+	interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "intr";
+
+	/delete-property/ apio-wins;
+	/delete-property/ ppio-wins;
+};
+
+
+&pcie4 {
+	compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
+	reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
+	       0x98 0x00000000 0x0 0x00002000>; /* configuration space */
+	reg-names = "regs", "config";
+
+	ranges = <0x81000000 0x0 0x00000000 0x98 0x00010000 0x0 0x00010000
+		  0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>;
+
+	interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "intr";
+
+	/delete-property/ apio-wins;
+	/delete-property/ ppio-wins;
+};
+
+&pcie5 {
+	compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
+	reg = <0x00 0x03800000 0x0 0x00100000   /* controller registers */
+	       0xa0 0x00000000 0x0 0x00002000>; /* configuration space */
+	reg-names = "regs", "config";
+
+	ranges = <0x81000000 0x0 0x00000000 0xa0 0x00010000 0x0 0x00010000
+		  0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>;
+
+	interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "intr";
+
+	/delete-property/ apio-wins;
+	/delete-property/ ppio-wins;
+};
+
+&pcie6 {
+	compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
+	reg = <0x00 0x03900000 0x0 0x00100000   /* controller registers */
+	       0xa8 0x00000000 0x0 0x00002000>; /* configuration space */
+	reg-names = "regs", "config";
+
+	ranges = <0x81000000 0x0 0x00000000 0xa8 0x00010000 0x0 0x00010000
+		  0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>;
+
+	interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "intr";
+
+	/delete-property/ apio-wins;
+	/delete-property/ ppio-wins;
+};
+
+&soc {
+	pcie_ep1: pcie-ep@3400000 {
+		compatible = "fsl,lx2160ar2-pcie-ep";
+		reg = <0x00 0x03400000 0x0 0x00100000
+		       0x80 0x00000000 0x8 0x00000000>;
+		reg-names = "regs", "addr_space";
+		num-ob-windows = <8>;
+		num-ib-windows = <8>;
+		status = "disabled";
+	};
+
+	pcie_ep2: pcie-ep@3500000 {
+		compatible = "fsl,lx2160ar2-pcie-ep";
+		reg = <0x00 0x03500000 0x0 0x00100000
+		       0x88 0x00000000 0x8 0x00000000>;
+		reg-names = "regs", "addr_space";
+		num-ob-windows = <8>;
+		num-ib-windows = <8>;
+		status = "disabled";
+	};
+
+	pcie_ep3: pcie-ep@3600000 {
+		compatible = "fsl,lx2160ar2-pcie-ep";
+		reg = <0x00 0x03600000 0x0 0x00100000
+		       0x90 0x00000000 0x8 0x00000000>;
+		reg-names = "regs", "addr_space";
+		num-ob-windows = <256>;
+		num-ib-windows = <24>;
+		status = "disabled";
+	};
+
+	pcie_ep4: pcie-ep@3700000 {
+		compatible = "fsl,lx2160ar2-pcie-ep";
+		reg = <0x00 0x03700000 0x0 0x00100000
+		       0x98 0x00000000 0x8 0x00000000>;
+		reg-names = "regs", "addr_space";
+		num-ob-windows = <8>;
+		num-ib-windows = <8>;
+		status = "disabled";
+	};
+
+
+	pcie_ep5: pcie-ep@3800000 {
+		compatible = "fsl,lx2160ar2-pcie-ep";
+		reg = <0x00 0x03800000 0x0 0x00100000
+		       0xa0 0x00000000 0x8 0x00000000>;
+		reg-names = "regs", "addr_space";
+		num-ob-windows = <256>;
+		num-ib-windows = <24>;
+		status = "disabled";
+	};
+
+	pcie_ep6: pcie-ep@3900000 {
+		compatible = "fsl,lx2160ar2-pcie-ep";
+		reg = <0x00 0x03900000 0x0 0x00100000
+		       0xa8 0x00000000 0x8 0x00000000>;
+		reg-names = "regs", "addr_space";
+		num-ob-windows = <8>;
+		num-ib-windows = <8>;
+		status = "disabled";
+	};
+};
+
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 26c7ca31e22e7..b2dea03e1b8ec 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -613,7 +613,7 @@ cluster2-3-crit {
 		};
 	};
 
-	soc {
+	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;

-- 
2.34.1



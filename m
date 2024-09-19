Return-Path: <linux-pci+bounces-13299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD47997CF0A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 00:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D80A1F2317F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 22:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92EA1B2EE3;
	Thu, 19 Sep 2024 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PlOKsvuE"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2065.outbound.protection.outlook.com [40.107.247.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCCC1B2ECB;
	Thu, 19 Sep 2024 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726783420; cv=fail; b=Sgd1opC3F2w474rvPUNb01Hg3M7UWagisE5qXkDwxWUsFFil9/+qdTKjQNUIuwFu81PZtVFD065WzRBO1wHNLNSSbrLrzmDf7pho+h9kHOCbCtILa4J+2qNwHaXz1wMIqdQx6D79BT8hkhIfRc7LXigyUL7yv3FRyHfXkcp5QlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726783420; c=relaxed/simple;
	bh=vDo0CTqtXkW2vkHMQRmkJR3TexBHqAnWrGWuqBuQVvg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=I3HKhDsWfzHed3kvFKJ0mLsa6JESLW5nVCZF2AXl5C8bg9DLfeGEQZ2XT7YmqZRCZfUUj9i4w6Mpv4kro2Aot4YK2/FabsR/hhN83szWz9yWzvVOvGHrtHB5ldT99flzllwRPWnxJx/bAx4D5UFDEN+gjBIcpzcS7lVdoYJffMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PlOKsvuE; arc=fail smtp.client-ip=40.107.247.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYj4sKsPjhvr2tbwUyGchCUDYK3At7VVosFmz0IIJoBI7nMujCrVlqsjjz3B7MrPQ23Aal+ojWIZxrwCWsFCJ/HsTp7pcwO07rywyKONcAnfLeVDdboviuI2KnxtwNUVU7mnYZcuUK9xMQzPMJA/8hLDusRjmxCZtDQzp/4w7eygboGIiLZxowPilhAQpsqxEASUnEnHxEpWQzPx5ejJzbQmF0UHXulBGDQkC8SHAMfQ9KpEp1XUEDIOvxzzr41LPtmcRBr1wuRdJP8XBwo3VBXsuvnscdrcURb/pG3rLZ6M6X7P72WXvtCTPP2Jz89L4BSflLIbet0xtDGvDj3lWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5hyEexqSJM3L1dF/wpAUvlH8NDjFDFwAw0HSKX5rIo=;
 b=Iyx94DMLfmLwFqj/j3cNsGTDTKATJVcueBdAZrz002ny+XoFNpRB5dFbKi/AeA0HonqPuiVKpcBkbyaAMWRkAhJbLLy97JN0e7Ft3cMuwxC5S/Tvf3KzqjBNOB7jcx9qMQrHENPdd/TH2pQgD9LdhETHghJjooXN5BHTpLYUJfAs0EPnjhUcPaZPaYVN3hSR82im6je925wYuvAXCMIfp0Tx9U6eEkvx7q92v4t5ETuF4+BPVrcCxryZDUyLfYRoXXFVmtFcW55Zivh/LjtYdIpitf+INXzvDiwXHLrdsIhYocf+FzKYWj5infXs9DpCMv2s9CReM+Ac5EtR+hdzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5hyEexqSJM3L1dF/wpAUvlH8NDjFDFwAw0HSKX5rIo=;
 b=PlOKsvuEW7EB8Q3j8VWZT/gyLGJ2FOL3cZ+az7O6TJJHWOI2/EQkNbaTrrRPyuxcdyivVqcwDd8IQhJjcnuwEgsnGz9dUfyH/e8MvU6AFsfrqcAEabWwFw5ilynkUu4ZVkLJhN/VdIg4yYgJKK7r2OrHxhnwSCX61bT4/1U4jzAzT/0LxC4U2k7Uz3NEy8q2ZIqjelczegpZhK5jr+GC4kXr7Vvv6m2BDRGGgmmDTnO+H9oWhKBfENu8/5Em975IHdFA921HpYMAyXjCQIYBYWdGsxoNhtsmEL7uNkJzIK5AM/vkA6xitudYYGmi4FYhWa06pwTg/EhxyRSo7YlBAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6965.eurprd04.prod.outlook.com (2603:10a6:20b:104::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 22:03:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 22:03:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/9] PCI-EP: Add 'ranges' support for PCI endpoint devices
Date: Thu, 19 Sep 2024 18:03:00 -0400
Message-Id: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJSf7GYC/x2MUQqAIBAFryL7XaBWkF0lQsJetT8mK0QQ3T3xc
 xhmXsoQRqZJvSS4OfMVC5hGUTjXeKDlrTBZbXvtzNimwPBIXqrswxAGdFrDOCpNEuz81N+8fN8
 PoJIo118AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726783409; l=3664;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=vDo0CTqtXkW2vkHMQRmkJR3TexBHqAnWrGWuqBuQVvg=;
 b=I6GHA1h9s7oxVcrQiepOky1wY4WBDAWvoAELK38hjFatMhxl9TjQCU1qH4K8R9CQEa5XC9FWP
 tqewaEtk+C9BmZMg1Jyx1bXGQfTgiNoGmybMsfQZMxwN39pFMw6cMBf
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: bf423d20-649e-4aac-8ed2-08dcd8f6e848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUludHpwTDhVOVJkSnZraGVQUnZqK2dSZ0IvTXIzbjA5UzVLa29NbkJ0bkVO?=
 =?utf-8?B?OEFpc2YzTnQraHU1VW5ielBuVmVRVyt4eWJLL1h1Q2kxODdMcHpmazFjNVpU?=
 =?utf-8?B?bjBGemF0SFR1SFJJK0ZJM2lCUEZYeFY1NHpleEV5UkYrNGtKWEJ3dXlvM0JI?=
 =?utf-8?B?bUJQZ29TUWIwbk9oUUhIek90akFmaXVDcXk4cDNYaUZMOVBNTlQwVndpUmd6?=
 =?utf-8?B?YkRDSTJxUHZBc1FCMlBBL3pmMC83SXV4bTRwYnFJZndrWlZ5WnVzQ2EyZW1h?=
 =?utf-8?B?ZWF0Qk4vTDNSYlM5NWJ2bVFjVStOWWc2akJEWm80V2JJdGNYRVVaaytTVEVK?=
 =?utf-8?B?cytPbWlIVlc1N3FMTXJHWWlzbHRnNFBKTTQxZzJLT2dUNy9OWkdpSlNRcFEv?=
 =?utf-8?B?dGJ1Z3M1Nm1ZZThUS1Rkei9LcjV4dnZRVHdrbnZQNzZQbk5UQXVWa0NlYlpQ?=
 =?utf-8?B?QXJQSDBkWThnSW1Bc2pkTW81V1RiNG83cGUvZUhsQVl6Z1FqKzFPUFQ2VDdD?=
 =?utf-8?B?VmNYL3VhNnZhL3NJZnIyVUFzMW9SUGJxbkw3TEMzWFBteUl6YkpONnVaMXFK?=
 =?utf-8?B?OHJ4VS82ZEdGZlZEZW4yN2ZCWXJ3Qy9yMXR0aVc0bEhVSEhnS28zZjM0OEZr?=
 =?utf-8?B?SGtoeUxJc2RmV1J2cmh2VW1sT3BSaWJPNTAvb2RaZEprZUNjUHQvYzduMHBF?=
 =?utf-8?B?dXBHaTZOWnpoQkRncWc2M2IxVzBRb0R3cjhxdUNUUkdGZk5DbEh4WVhzOGlV?=
 =?utf-8?B?NVlJZDhyVkF1S1pINUJTUmxEUGE1VzBtSW5sVXlwb1l4WC9NQm11VU1CRTQ4?=
 =?utf-8?B?UnE5OWsyNUZVbEJhMUNMbkxhaWRXMDZlNzhVbmYrVmZCb2JaSHcxTm5nWkZo?=
 =?utf-8?B?NGhZYjZoYmR2NG9JdWkwYmtmYUtQdXNiZjBPZVNyV2hmU0FGLzVuZGtwWFpJ?=
 =?utf-8?B?K01jbm9VSWgzdjN1T1h6dndxR3QwWUxZQmIrdkNqTWhSMkg4RkpPbzE0alpt?=
 =?utf-8?B?TEhPUHJETllWOHdiN0k4LzN1aFhQRGwybVo0d2FSd25nOWQvQUhDcWh5MkU0?=
 =?utf-8?B?aC9HTVF5ckNtT3cvRWFaQk1DQ1krUlNWa3VBU1hpdEs4d2dvRHg2cXhXSHJs?=
 =?utf-8?B?SEJ5d3NWOHAvNCtQYWE4a0YvVDdyd05kTDJTdFhaOHBxdTZyU2tjVnNlSVNq?=
 =?utf-8?B?NHl1dWhEaW1iYi9XZDRtNmZSNTVMMFFjemhFZkZnaTJiaEFmV052Ynl6M2N5?=
 =?utf-8?B?V0k5Ti9IODlhTmJ4WE1GMXhjK0E4Sjhwc2hrUnRSZEVuWHZCMG8xNEdRMHV0?=
 =?utf-8?B?YTJ1UE02UzVIaitZaklrOU12ZE4xZ2ZQdHV0aDNMZElueVNtdHhzY2R3c29G?=
 =?utf-8?B?K09wR2JuT1RlWnlPR2tja0s3Yk8ydmh5ckRhOEVVNFlvN0xsOEkyeEhIcmJa?=
 =?utf-8?B?RUk2SGRpN0RGa3dydWpsc2Q2U3pXTS9OcXZaZEpUenBOcGtwNGdYVjJFZUdq?=
 =?utf-8?B?YU9XWmJSaE5sRDNheVB2a2loUlplMUpzMVFqcHFQQk9BRy9HMDZ5K2VwRWQ1?=
 =?utf-8?B?T2NkTXNqSDZucitnTmxaY201bG13NXdyUlVxSGx6UHJvcFA5R1BwVHpRSkdO?=
 =?utf-8?B?QlY3ZEhBSGlKQ3FyU3pHQlRoRGNMNGMvSUFIblhlWTFkVDR1REJUb3h4YXB2?=
 =?utf-8?B?aTdYQWZQTEZXQ2VZV0VVOUxiZHNVNnd6VXVPU2pNLzVSM0RvaFN3bURrS0RT?=
 =?utf-8?B?R3VMclhpVVZxVUVtQVZUalhYSFdvbmE3dmNHdHVEQkxJRzdPU1ZLUVF3NjJz?=
 =?utf-8?B?aUpiTy9SN2VMME14QXFsVFVtTkhsc1lDb2lDeHJSeTJ4SnNmbHJkc3hWdm9Q?=
 =?utf-8?B?dEFrZURlcWVjSXhUVnVpNnRSZmdMMGswOFphY1pUb2p3YXgvZUQwaWpuc2lz?=
 =?utf-8?Q?nDtFKu6VXBM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVBGcE9mWHlGdGZ5MTA5NkFGUWx5VEpPbmhFSzQwUndwY0xtOUhZSk1vdnM2?=
 =?utf-8?B?VGhKaEJiQXkrV01VZWFTRVppTEQ0VTJMRkNQc0hRbnl1WkxaT2dBNC9tMzlZ?=
 =?utf-8?B?elNEdG1LaTRqMGRXME1CZU1oWXhUbVdrcGoxaGdVWGN2c09RUDBCTVhETDBq?=
 =?utf-8?B?OU96MmtpNzIyS290Z1BYWVNRdDZLTkpXNXU1MUlDS3ZwMGs1RExuci9jWjFE?=
 =?utf-8?B?OEdMVzkzdnZoS29ITjRiQXZjbkNjdGVHbzZOeWpkeG9jQWU5aDBSOFIySkI1?=
 =?utf-8?B?L0tNdHNzQWJhd09aZUF5TTFJTzZKajdxb3QyZDRISG5nUEdqVGg3cVlmTm9m?=
 =?utf-8?B?YlNqLzYySVBRTWg3RFhRRlBpNCtqeGhhYjRURWdzOFVWZE5aWHIya0ROckls?=
 =?utf-8?B?UVc2OUNqLzhpSnRzaDhNVGZZQkVpY2VVT1lsRXVDcDYra2xqY2huYkRFc0NR?=
 =?utf-8?B?clhmSnpVVlduTVd3bElaNUYzNjJMdGpJYlN3Rk5DSHFpdU9XRlFuc3hsZkd4?=
 =?utf-8?B?ME9UNEN6dERSb1NYZ2hubUxEOGhBc1B4djJLRHJUYnZsWDgxRVJuc1ZFZExk?=
 =?utf-8?B?Um9NRy9HU29YREl3bkhmNWR5allNL216bE9GcHJCblc4cDVoQVNldHp0bmtv?=
 =?utf-8?B?VlMyc2doMnJJS2hvY2JacStiSXVZbWhXRmRYVU4vUWUrVlNidHdHbEpxZVJV?=
 =?utf-8?B?Ni9QdTJnbDcwQmZvRktsc0E5ZDJNMDZtUERvZ1FOQnZzYU5aaVpVblBDS2pV?=
 =?utf-8?B?MERvRmtGSHAvN2xKQW44ZEd4QlNZL1ltallJN3RBTnhxc0xTSkxPSzVvVE5y?=
 =?utf-8?B?Nk9nNHErMngxWm9zRGxmTFlGYXBYWEV4R2w2QVlFdjNPOVcyVll5WmRlOEVR?=
 =?utf-8?B?SFM0N1VGZi9GOXYvMis5NnJIWjMwcU9PNE5RaXFmK1JjS05ZMzB3TGhpWGM4?=
 =?utf-8?B?NGFBQis2YytWTWg3WEZKbnptTG9WRDNYMEcvdEowNmdrOStzRFdjcWJ4MDlL?=
 =?utf-8?B?U1daYU1yT1Y5Q0g3WlUybkg1dUJWRE45R0xydVBtK0E1QkpGVHFrNkxaQXk4?=
 =?utf-8?B?bmx2SGFwTFNmTW9RS1ZleFpCMDBuY2g2LzVCd1VvTmJ3dnYzQWNHK0p3NU00?=
 =?utf-8?B?ejFsY1R3M20yQzZwVkNKS085RUxoUEJxQzVyMThUcml3NHE3cVJ4ZHJ4dFEv?=
 =?utf-8?B?KzZHZ252empRM3k0VEhWNVdqT2tYUmFlTVlJUzhrSUlkV082VGRiMUN6NDNH?=
 =?utf-8?B?dWFiTUxnYSt0T1o1OTNoLzFWRkpsU0xhandrT1NCWXVkMHZBNHZpdG5uNUpq?=
 =?utf-8?B?eTVML25iRzBMZ0ZCaVNWZ2kvdzdZSk9RWitFRkNCNENlbmc1YWR0OEhRZnc0?=
 =?utf-8?B?L1NYMUhKYXNEaU01Y0psU2xtejRtMzZVNStFWWNYSFpKcUI3YjVNQ1dLa29M?=
 =?utf-8?B?SG5FR1NHbGJlOTgyZldtcGs5dnh4U3pmTXNGOEx5U01MajZGU29lNUQrdEV2?=
 =?utf-8?B?MnNlYzNQMGN2MWFUL25iV0RHV3ZES3RCcjBMQkd1L1oxZGZ3dnFySjV5RERD?=
 =?utf-8?B?NmFQclR5TDNuMEpPUEZ1QytoTHkvcWFYc2dHZktsb1FPZ2VLY0x1N1FQRWVE?=
 =?utf-8?B?aDhXRFZnOUwvYkRUblBWdXNYWm9neE5GSi9XcEswK2dwRmJzVXphbnd4RVk5?=
 =?utf-8?B?V1NSaWNXWDZ4cmxvZGlkVm5lamt1WXhtV0ZCZHRnUmZvUGpVT1RUV1ZjNHFN?=
 =?utf-8?B?ZVY3NU1rbmJiL01mS0R0OFZrb3BJZXJNeUdTUUpxaDAycytVbzZKN2FuY2di?=
 =?utf-8?B?dDdQdVVqdjBOaTQ4MWF2czFQV1dXZXJ2aDNRaEFGL0JRUXg0K0ZxeFd3YlY3?=
 =?utf-8?B?VnVTVGQwSUxKMFpYbWIvM0JMRS94U2g2L3dLWUt0R2tNR2lxMUk4YjZSUWE5?=
 =?utf-8?B?S3E3YWFFZXNOQU5aNEUyandzNTkvbytGMjRWS3huUFFDaHA5VG1BZUEvNjVV?=
 =?utf-8?B?UFY2V0J3WHI1Qk1BakxPU1Fqa1dTejdkL3VaenFEdFV0bFRLVmpnWHBGVXZO?=
 =?utf-8?B?UHErN25aajJjVjIwcXREV1h5bi9HSUh6TWhnejd2UDVTNnlCTjNjcGJhZ1Ju?=
 =?utf-8?Q?2cW2E+68ZxG2z2ydo3fWpuj8Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf423d20-649e-4aac-8ed2-08dcd8f6e848
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 22:03:35.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksc92cuzfDh9UvMJ62no/s2yZ5MfO8SYD0IwnJjH6WkhgJ/czYuhP8D0NBQ27/XVYp9dHpYiYaVm0GbJwYg5Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6965

The PCI bus device tree supports 'ranges' properties that indicate
how to convert PCI addresses to CPU addresses. Many PCI controllers
are dual-role controllers, supporting both Root Complex (RC) and
Endpoint (EP) modes. The EP side also needs similar information for
proper address translation.

This commit introduces several changes to add 'ranges' support for
PCI endpoint devices:

1. **Modify of_address.c**: Add support for the new `device_type`
   "pci-ep", enabling it to parse 'ranges' using the same functions
   as for PCI devices.

2. **Update DesignWare PCIe EP driver**: Enhance the driver to
   support 'ranges' when 'addr_space' is missing, maintaining
   compatibility with existing drivers.

3. **Update binding documentation**: Modify the device tree bindings
   to include 'ranges' support and make 'addr_space' an optional
   entry in 'reg-names'.

4. **Add i.MX8QXP EP support**: Incorporate support for the
   i.MX8QXP PCIe EP in the driver.

i.MX8QXP PCIe dts is upstreaming.  Below is pcie-ep part.

pcieb_ep: pcie-ep@5f010000 {
                compatible = "fsl,imx8q-pcie-ep";
                reg = <0x5f010000 0x00010000>;
                reg-names = "dbi";
                #address-cells = <3>;
                #size-cells = <2>;
                device_type = "pci-ep";
                ranges = <0x82000000 0 0x80000000 0x70000000 0 0x10000000>;
                num-lanes = <1>;
                interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
                interrupt-names = "dma";
                clocks = <&pcieb_lpcg IMX_LPCG_CLK_6>,
                         <&pcieb_lpcg IMX_LPCG_CLK_4>,
                         <&pcieb_lpcg IMX_LPCG_CLK_5>;
                clock-names = "dbi", "mstr", "slv";
                power-domains = <&pd IMX_SC_R_PCIE_B>;
                fsl,max-link-speed = <3>;
                num-ib-windows = <6>;
                num-ob-windows = <6>;
                status = "disabled";
};

These changes improve PCIe EP support by allowing proper address
translation using 'ranges', ensuring compatibility with devices that
rely on this information.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (9):
      dt-bindings: PCI: pci-ep: Document 'ranges' property
      of: address: Add argument 'name' for of_node_is_pcie()
      of: address: Add device type pci-ep
      dt-bindings: PCI: snps,dw-pcie-ep: 'addr_space' not required if 'ranges' present
      PCI: dwc: ep: Replace phys_base and addr_size with range
      PCI: dwc: ep: Use 'ranges' from DT if 'addr_space' is missing
      dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
      PCI: imx6: Pass correct sub mode when calling phy_set_mode_ext()
      PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support

 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 42 +++++++++++++++++++++-
 Documentation/devicetree/bindings/pci/pci-ep.yaml  | 30 ++++++++++++++++
 .../bindings/pci/snps,dw-pcie-common.yaml          |  4 +--
 .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml   | 21 ++++++++---
 drivers/of/address.c                               | 30 ++++++++++++----
 drivers/pci/controller/dwc/pci-imx6.c              | 24 ++++++++++++-
 drivers/pci/controller/dwc/pcie-artpec6.c          |  2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 23 ++++++++----
 drivers/pci/controller/dwc/pcie-designware.h       |  4 +--
 9 files changed, 157 insertions(+), 23 deletions(-)
---
base-commit: 909eac36208b70a22fd0d1c3097e3af98dca7599
change-id: 20240918-pcie_ep_range-4c5c5e300e19

Best regards,
---
Frank Li <Frank.Li@nxp.com>



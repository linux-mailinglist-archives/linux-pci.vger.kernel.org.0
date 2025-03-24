Return-Path: <linux-pci+bounces-24539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28873A6DEF3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 16:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B2C7A2853
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A3A33062;
	Mon, 24 Mar 2025 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="zSpNY2EB"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022119.outbound.protection.outlook.com [52.101.66.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92781DDE9;
	Mon, 24 Mar 2025 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831232; cv=fail; b=apab0w2zXAWzbMEqUagDZhDRfxJDJFyHuO4Beppx3MhuRwUFphZ/rXJF3IC1GpPddk65iagPeQiu6Kp7r+2uY0euTS6mAvw8EN2Wntwyh2RYiYuvm8Q+4U0f1uGEIDSvnizV8LMkBAsBvv4TcligDT9Qia8ZV0iRd13TS3pJ7u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831232; c=relaxed/simple;
	bh=FR2UYcEZ3rFa3q9iGFr5iH5kJyrbdxE+W0scHzTFjGk=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GT2Jar6oEwoYUlyqprNWMLnbS3ljMV1Pa964uSvb3RaaaN5hUsgOF3zaB+yJmXZfnHVBayeO4O3uGmE6mc+jsxOf39gGaOZSNfE0jMZAHmereNO/tUVRwuAHGh11bUawO8KCWvxZ48IK7tEOw98p/Zjc+HbjDJMIm8X++7fLBmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=zSpNY2EB; arc=fail smtp.client-ip=52.101.66.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5px27ztwpWIFZJoRDQDAPtmH730f1DCzR+r8mwVoYstsPZjyUNWVhSCTUs74QOVH6ZUmd3Qok9MurrDYLtdog5/XS9hodMzeuvAtUSsS+Ybr4uJ2rKNURSeR7NErSdg6PnpMZnfurEHFmyjh6sv/t7X1TnFoyHtUdiAlC/9G2kZMieOPw9ZwyCpSQ7uWhlC3HcqC2xEhjCo/oK+ML3dWSvmOYRrXi2LurRp2QQlAg6q65EUaIOGsYZXmac2/N4upUoXP0aL70bcztM/54h2Go9Bc3oM9+Y57aR//YRwWRtfkALnG1HZOQ16OPOD9+Nu5YCm8dzDbKipgUIUbQRMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+prPsFn1iWaSFHGIzuAw8AEj5MDCbnVehFeVVI3FHdk=;
 b=Veo54tBONpq1W9v55J77zCZ9Gsz9Ncgoi6rEbTqx4HLF56zHb2vlzyhHWC5p41QUmsrHA+WYE5t3d7zNYhC/uLZ2pAd7AaGcZOBUBRFuIQ8ZO/05PfwjlE15sz1ZgB8ExyixII8XFISNj3IcLsRhKA3KV4G3RSIKk49h1GTiPmUCh0xS79Ryg2Ntxm0fy3o6iz8l0BrcTAfma/z+tF7OXTa+UytcOoj91MfaOvyaWrUBzZWBf/cfTCfqpc0T+wkG/m64d9aEBJ0T6TbO9ia1O8B7G7NWVPfJ3doZQbNZZbpQtWV0J+Sf9WkmIBn/1N5m09KdPJe0imgD9XbXC7RfRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=linaro.org smtp.mailfrom=topic.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=topic.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+prPsFn1iWaSFHGIzuAw8AEj5MDCbnVehFeVVI3FHdk=;
 b=zSpNY2EBxzJqyYECywZADAoqN0mEmZsdAhWPeCyd2RNLJKUWUtYqQOAqAmYlEur1bScCNHXX2hfMdeR0hug5wLuC2c5pqgb/FgUpULEeuASFb3tF2woBsOD2+JKocM+T8sCc/HiMk/fckqV+hM4eCkKcqCGeY6aTY4u0LbIoW2t9hUNUQSKtw+5dA8p+rYqZioquymkg5jSHfXiA1MDgwjfXZS83OP8pRBjyQANzhMEfZIZEDzMH8SuxMQbNrzlBcpgj5MvVH8X3jxPN75bBKqqicuGdXSFUqL9s7WpHQudwenit3WWHSYlGMaauNUvsvhzJT2pxL70c6bQCRW/8KA==
Received: from DU2PR04CA0295.eurprd04.prod.outlook.com (2603:10a6:10:28c::30)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 15:47:01 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::d2) by DU2PR04CA0295.outlook.office365.com
 (2603:10a6:10:28c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.38 via Frontend Transport; Mon,
 24 Mar 2025 15:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 15:47:01 +0000
Received: from OSPPR02CU001.outbound.protection.outlook.com (40.93.81.78) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 24 Mar 2025 15:46:58 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PA2PR04MB10335.eurprd04.prod.outlook.com (2603:10a6:102:419::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 15:46:56 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 15:46:56 +0000
Message-ID: <0e7637a0-8b8f-4aa7-be46-1e7b8ac07a45@topic.nl>
Date: Mon, 24 Mar 2025 16:46:55 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] pcie-xilinx: Support reset GPIO and wait for link-up
 status
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c4ab15e9-561e-402d-bf39-9e852485e4fa@emailsignatures365.codetwo.com>
 <20250314145933.27902-1-mike.looijmans@topic.nl>
 <vazbdawfo4jnct4rdokknxwvknespcf33jzrmobsnecbxnrbjn@kbvxvhrow4fn>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <vazbdawfo4jnct4rdokknxwvknespcf33jzrmobsnecbxnrbjn@kbvxvhrow4fn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR03CA0106.eurprd03.prod.outlook.com
 (2603:10a6:208:69::47) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|PA2PR04MB10335:EE_|DU2PEPF00028D11:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: a308cd06-6d4a-4620-cba1-08dd6aeb1e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RXQyZjQrT21TemZYZ3g3NE80MlhkcEovU0tiUEVaNXZyY1IwbXFuQkYybVhS?=
 =?utf-8?B?ajdxWS9hWWxyQlpEbyt5SVZTZFBVMFBWOXF2VERVbmIrcDU3WEFXUjZFcTRX?=
 =?utf-8?B?WUNnUEZMVHViUDVoR1QxaHBXVTg3WmVqQlpVRjRkd0FseU5GdFF4YjMxWXRv?=
 =?utf-8?B?R2ZEcXRIaXI4NTNQNVIyNmtKbnBxUjVKTjNYWGVtRFFGZmJKQk1kc0I0M2hP?=
 =?utf-8?B?VUJvLzdGbzd1MGFnRVFrZ1NuODBYU3BzcDIzaTZZMXlzSENFQmJ1bW9YYkxt?=
 =?utf-8?B?T3pjME5pdDFxdS85TnQxbHV5T0xTQVdNNEVjaXlUM2diK05Cc0NlSkJ1eE5D?=
 =?utf-8?B?OXlFT0VXVzVOMmVRMWd0bjZ0STByaFFnSG50NGdRbUNEUGE2UXdQN3ArUmpH?=
 =?utf-8?B?UkdCNGVmdlBOdCsza3dsendzaGUyb21kYmFnUnIvaDIyWEdyNS9sS0RWUEhk?=
 =?utf-8?B?cGYrMU9iL1RxOEZ1MDZacHNmOHJRVUFNWHlvaWZIWFRITlhVdTVRdUFqbnBI?=
 =?utf-8?B?R3cwUGhvWE9Kb1Y0SThhNzU4aSt1QVY1aGlEWlVlUmdoMUJTZUsrTytYSFhT?=
 =?utf-8?B?Uk9QODdmZ3l3NHRXaWxrUktSOWNiamV2Yzc2ZllXeVpRUlp2OTdwemZtT1ZY?=
 =?utf-8?B?SFIvVW83Myt3Mm1yK2xuUEZhckRLa3hpUjVEbUhydGhsZVZwOXF4UFBid2pk?=
 =?utf-8?B?WVAxM2xtUkR5bTA0NCsvWmR5V1NhMUl6a0NjYUQ0TzBXZjZ0UitNeE1CdEFm?=
 =?utf-8?B?UXdBSHQrVzJlb2VaQjdabGN2MXJpR3VQdVh4V3pIQWpMZm9saHF3dk9uRkcw?=
 =?utf-8?B?c1o4MC9vZDljbEIwMzZ0UTZ2NTRKQkplbS9FSkQ0VVg2Z0owdUVDandiZ2wx?=
 =?utf-8?B?d1AzU0J5ejluaGZDRkp5aWdqM0lkQVJNYWRxYzNPN0diTHBjRSs0aDNyTk5s?=
 =?utf-8?B?WXF3MDc5RG9LcDZ0RDNDcGx1U3hBV1U5U2JJRHl5Unl5UXVDZmlGMmEwUmxY?=
 =?utf-8?B?YVdMbUlIQzVPcmxIOGY5YUNRdkRqd1o3dTBJcUdEZXlWbGlIUkd1MEJWOW9r?=
 =?utf-8?B?alh2WktrN1JwK2ducGdha2ZrVlAvK0p5elFkNVBoak1VbUhoR1diejhYUTJX?=
 =?utf-8?B?ZmFTcW9lK01Sa3l0dHROK1MzbTdVVzJBSzZXelV2T09TZE1oMHRnbFNnOGpm?=
 =?utf-8?B?ZkFKak9ncjFCMkY3b0IrSU1WT3o4ZFpLNU1VOElteFM1ejluYmtwckQxbTRw?=
 =?utf-8?B?aHA0ZFFYZnVHdndLR1J5NzNRUjZyNDBKWDBMcmFiL01WQ0pjcnFMcXBwZ1RD?=
 =?utf-8?B?bkNVU0Q3cThWQmNMcDByc3RIZ3hhY3lyd3dSOWI4WmZtV3VJTWZQWW5ITDBZ?=
 =?utf-8?B?d21XY2NPTVlNUldNNUNkYmNUWkltNDlyZmdsK2lic045YXRETU4zc202dzY4?=
 =?utf-8?B?ZU80bDQzcG9DZnpWUHcyN285SVFsay81NnF4YnZrYVp4ME0zR3ducWVSVnJW?=
 =?utf-8?B?T0FLYjZQb2tpZXJDaHZ2Qm9UUG45SitmVlJGYjFvSmVkc2djZDZCSWJhNDkw?=
 =?utf-8?B?TnF2aFJDMGdUMWZDYVA0WFVOR0duY24vM09GUEpFRHhHTldra0RRaTRwTUpj?=
 =?utf-8?B?SzRYWDB0cDZIWlBnQy9VK0szQnFlSEdqM3VXZndpZnFtUG4zb3ppUlZ6SHJB?=
 =?utf-8?B?R3NKWFZIeUt2QXRLNjFaUHdZRGJNNmxTMEVDOGRpYmU2QzYxdlhleitZaFAw?=
 =?utf-8?B?UlpqOWJLMXp0OVdjUDVKNDdLZjVoL2haUGhhV3FneHR0NzgxWU1FTFZYK3ZC?=
 =?utf-8?B?enVKazR4TlB3em05NHMzU2VsT1IzUmVuU2trbUowWDVQOFY5VmFlYVhVR2tR?=
 =?utf-8?B?Z2pKWTJKTXpTSHViMTRlNmVGNjdrc1hpWEFkU1RGbzQzRXI2cTBBeUNzYjha?=
 =?utf-8?Q?j/8ccwGoceQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10335
X-CodeTwo-MessageID: cf5c4ae1-71aa-45d2-affe-b0717ecd2c91.20250324154658@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c738b0bd-68e3-439a-d6e4-08dd6aeb1b4b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|1800799024|82310400026|376014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2xVVGhHZ3VKbi9QeHNoanRhMm1oYVk5UXJNTXZuMUk0SVp0Tkd1Q0NRdUtY?=
 =?utf-8?B?M2VpYW5MbU1DdSs0YzNXcGg2am1WSWlYTE02Q09WZnZBcVlrQkhlbldtdjVZ?=
 =?utf-8?B?bE14NmhUWGtQRFhxY3dwZEhReTZWeWs5MGtmUG5mM3l6djZIZExBTmNodVRK?=
 =?utf-8?B?UEN3a0JwQXpmSHpaUllNMEJqM2NYeElMYVc2V2VHMi9GbmExRTBpbnYyRGNj?=
 =?utf-8?B?U2Nrb3pVRjcyRXlESWxlR1FiR3BIY3lob1hEYnF2bEc0ZFM4eUJYRzF4bHhJ?=
 =?utf-8?B?OW5MWithS1hxdlF3Q21SU1JHZlZDSVA4QmdPTlFMd3Z5NTZRNzM1cDFjOGJ0?=
 =?utf-8?B?czdSOG5VZW1mQUdLcU1jQ1YxRjM3RTlTdDE0QmRBOTdjOGxveHZsTXZoUmFz?=
 =?utf-8?B?TGt1OENxQS9lLzQyeUpYV2NBaGtVd1NCYUZRZWx0Vlk5WUFLYWNUQjJyR1Bh?=
 =?utf-8?B?NHAyU0wxZTFMN1pNK1k3RHR3Umg5dlpuYmhZeFRzQk5MR25xaDBpb05zVEVU?=
 =?utf-8?B?WVFZbkxrbUQ3WW5pUWczaUJ0MEdtNjFicEl3eUtOMXhsZEZiRU41ZUkzR1ZH?=
 =?utf-8?B?bzl3TDhYN2hGV2hVaGhoKzNSeHNzN09DN2pXNTJabW54WEM4Q1Y1UEZMZm5s?=
 =?utf-8?B?MDNqRGpxU3hZSktvMVNOQ0h4Z3NXWm5UTnBtV05kY2tCZ3hORDA4d1dOWENJ?=
 =?utf-8?B?SVoraUVoT1NCVUVVNUh0elJZWkRUMExEa3NGVENPbXNjblNSNVJLOENyZWRk?=
 =?utf-8?B?c1B6SzczVGRKQ0hmVWxpNnZId3k3Z0pveFpsN29oQ0ZRYi9pa1pxZ1VoUkV3?=
 =?utf-8?B?d2I4MTlSemF1cFM4eTlqekY4cEJXcEhFOVl6dVJBcTFZdllQY2tYcHN2T0Qz?=
 =?utf-8?B?ME8wakptdW1xYUsreEFxaThxeU5Xb0lKOUZqcFg3ZS9lMzAvNXZMOFEvUDlj?=
 =?utf-8?B?Mnl4aDNmOXJTR2ZrcFI4L1NncC94WjZlMmlvR1BtZXl4QWFMd0kzQXRXT3FU?=
 =?utf-8?B?c3Y0U2NCUTIvZk5wRXZLRU9zSEJGQTJoMUViWU1RN09MbUhFUHRlMDJkYXFt?=
 =?utf-8?B?aTY4TFAzY2JPaXRld1Q3L3VEY0RNV0tuUDVQYVlDbFFJZlYzcDN3YmZTQlo5?=
 =?utf-8?B?MmJTZktaY1dSZlc1K1RJQ205Q3BIYms0SEF5eHI3eW9DMGE3NVpQVjRvT25K?=
 =?utf-8?B?cnYzanhxM2VEWVZ3ZzVOZm5Yc2xLbXROWUZsdEZEcGhkc1c2SVBZaHpsMUNk?=
 =?utf-8?B?Kys1bUMxKzRaZ3ovMUpnQ25yQThvSC8rWWhEaGxGc1dwK1N5TURpbmo1amp2?=
 =?utf-8?B?YVp2N1ZkOUh3bS9FYllLSjlLaWkwdFBJc3NIbDB3amZ4U1g2Sm55Z2daQ0Jv?=
 =?utf-8?B?ejUxcmorQjRjdDdRby9tTTRkcmttaHhpU0xicWMzM3Zlcmo0Qnc5Rm1FbEtn?=
 =?utf-8?B?R2ZVOW1wQ2RyblduVjZsZVlxUGV0ODZMT0V6U1drS25BUDRYb01rSy9sMCsz?=
 =?utf-8?B?eUwrRHUvNXB3U0RBc05oeDVKUnQ0WUlVVXBHYzJIM3pveGxyRXNHa3pwVnRG?=
 =?utf-8?B?YTg4VWRFcFR6VnpZQks1d0dSL05VdFh0QzYxNXNjVDhQMzkwQVEvVndaVE9X?=
 =?utf-8?B?UDNTcGRwKzdmSGVzUlU4c3dwY1NNdFZwcTJWZWl1UDlsTXNob0pxOVFlc0gv?=
 =?utf-8?B?aFdwTm9HNWN5Qk95cmI1bkNoTFgzZFhxczNya0J0a283YklYZ09Bb1BBZDUv?=
 =?utf-8?B?K1pKbmRjUkJxdmxNcTlvalgzbzFqdW9kZjZTTHJyd2FYUWw0eHd5S1FDajhj?=
 =?utf-8?B?d3VweEsxZWpTdVg2TnU4bldsN05pTVNQcFBHemplTThzZTlXWmJPMDdNUVNT?=
 =?utf-8?B?c21WcDRkNEtLUGkxVXc0TGZORlpsSGkvMmVOMWxiOUQvVkMveHFXUUw1c1RM?=
 =?utf-8?B?QzlDb1MrOWRYMXVnWmdKSStNenVzOWtBUGhoSjRWWGsremRFVDFqZkZsZE9a?=
 =?utf-8?B?YzFsR0k2NmdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(1800799024)(82310400026)(376014)(35042699022);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 15:47:01.1571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a308cd06-6d4a-4620-cba1-08dd6aeb1e45
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

On 24-03-2025 08:49, Manivannan Sadhasivam wrote:
> On Fri, Mar 14, 2025 at 03:59:02PM +0100, Mike Looijmans wrote:
>> Support providing the PERST reset signal through a devicetree binding.
> Where is the bindings change?

Will add in v2


>> Thus the system no longer relies on external components to perform the
>> bus reset.
>>
> There is a similar series for the CPM controller:
> https://lore.kernel.org/linux-pci/20250318092648.2298280-1-sai.krishna.mu=
sham@amd.com/
>
> Please take a look for reference.

Seems similar indeed. (You may have noticed we've actually been using=20
this patch for a few years)


>> When the driver loads, the transceiver may still be in the state of
>> setting up a link. Wait for that to complete before continuing. This
>> fixes that the PCIe core does not work when loading the PL bitstream
>> from userspace. There's only milliseconds between the FPGA boot and the
>> core initializing in that case, and the link won't be up yet. The design
>> works when the FPGA was programmed in the bootloader, as that will give
>> the system hundreds of milliseconds to boot.
>>
>> As the PCIe spec mentions about 120 ms time to establish a link, we'll
>> allow up to 200ms before giving up.
>>
> This should be a separate change/patch.

Indeed, this is a separate issue, I'll split it in two parts.


>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>
>>   drivers/pci/controller/pcie-xilinx.c | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controll=
er/pcie-xilinx.c
>> index 0b534f73a942..cd09deba0ddc 100644
>> --- a/drivers/pci/controller/pcie-xilinx.c
>> +++ b/drivers/pci/controller/pcie-xilinx.c
>> @@ -15,8 +15,10 @@
>>   #include <linux/irqdomain.h>
>>   #include <linux/kernel.h>
>>   #include <linux/init.h>
>> +#include <linux/iopoll.h>
>>   #include <linux/msi.h>
>>   #include <linux/of_address.h>
>> +#include <linux/of_gpio.h>
>>   #include <linux/of_pci.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/of_irq.h>
>> @@ -126,6 +128,14 @@ static inline bool xilinx_pcie_link_up(struct xilin=
x_pcie *pcie)
>>   		XILINX_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
>>   }
>>  =20
>> +static int xilinx_pci_wait_link_up(struct xilinx_pcie *pcie)
>> +{
>> +	u32 val;
>> +
>> +	return readl_poll_timeout(pcie->reg_base + XILINX_PCIE_REG_PSCR, val,
>> +			(val & XILINX_PCIE_REG_PSCR_LNKUP), 2000, 200000);
>> +}
>> +
>>   /**
>>    * xilinx_pcie_clear_err_interrupts - Clear Error Interrupts
>>    * @pcie: PCIe port information
>> @@ -492,8 +502,21 @@ static int xilinx_pcie_init_irq_domain(struct xilin=
x_pcie *pcie)
>>   static void xilinx_pcie_init_port(struct xilinx_pcie *pcie)
>>   {
>>   	struct device *dev =3D pcie->dev;
>> +	struct gpio_desc *perst_gpio;
>> +
>> +	perst_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(perst_gpio)) {
>> +		dev_err(dev, "gpio request failed: %d\n", PTR_ERR(perst_gpio));
>> +		perst_gpio =3D NULL;
> No. If the GPIO is defined in DT and there is a problem in acquiring it, =
you
> should return the error.

Agree. And also, this should be moved to probe() so it can handle=20
deferred properly.


>> +	}
>> +
>> +	if (perst_gpio) {
> This check is not needed as gpiod_set_value_cansleep() can accept NULL.

The check is to prevent the extra "sleep" calls. If the reset was=20
performed externally (some bootloader or POR logic) the sleep calls=20
should be skipped.


> - Mani
Thanks for your feedback.

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl





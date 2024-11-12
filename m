Return-Path: <linux-pci+bounces-16583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEBF9C6012
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 19:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B92C0B82B08
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185CF2144C4;
	Tue, 12 Nov 2024 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h4EMPc5G"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C7214414;
	Tue, 12 Nov 2024 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433724; cv=fail; b=XhTWHntV8FYQtJNomt6R33MBxtsgbBYmkTI1AD2bJDRrWNfIWTWEJ/oCb15qh4vF2ZmWxtEnSFGLoMzH5z8vQd6+Dk1FStBmoicBMPvx1u7jxrHcaX5f40VAvAchMzHfOMsxSoPhU6qUx5WJSjVrCuW5P1Gmb7HjsHubS3dNBsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433724; c=relaxed/simple;
	bh=61Lz+aGDQkYpdiQf7LVfcFjngzuH5VC8R5EMQvdL0Ao=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HsgDpI8gMgklKkrYfNhIeV6qKLkVh+iHp5jZOp8GK9dj7BWitjzkCmmgSnkTIjFKxW0o3MIOpt90J6bd5qa/UMb4mrP+hkpNksPxbPWuerRg30qrZ30UkzF4gG36k5dakyQsR7U32ObFe1L9a0XdUWeRQx8ALoLtl+8KKu6/lDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h4EMPc5G; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBL1lA1iUKa/zM1+ZDwCL8k7JiJ0yFQvcoVL0MeD1z9gpBS/o9j2IvPzVsur9BIIGkC8DmudhbZ+ssTncwaf278ksP/pFxmTZHzfqH0dgwvbjo1ofcOS8pBY5eSY30SGDmTdczzsNLCDav82g5USm7LRZ90WWBHMNzVq6Qja73XchIWQTmNTZF0aauNddkKf/LVybMn32HEAqt/9ZiHz4sB9nScnD8VLtYziXmLZW7cYvwSVoQ3icWaN9buTJWMdXoZWQi3l/nEUPjZftl/BRIbSl6g1KWoIxdBJ/SfHoF8REf6o3qvmsFz5gJgSfsPmQ/+sdqn0pZWhyNPS4Y1ykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBHqw5apHMvrrXufyd1Q/VZQPQg6/TA5tygGYqkmzJc=;
 b=iEMfnG4C9eEBrIC6DEQpluLW51MctiamrXVRoE3kbHVQtxsIOhsLc3c8N0L7jLztk/6BP72JwV69BPVO9nd/fNttnKSb6QAL/w4ZBqTWGYms4av79QRpvXD7Fma2uZhmOwmfs2Vvwi/KqrLpvQVAyuVNq/1i3g1arYOEnTfYD51D6lZ0L3azYW5MxOmTgr6E69MO+lo7cXKFl8tg1Ogn7Nay6uJT5ffiYFtbpDiabPqhPf0/LB6FqZRNOl8C5eIk9rhqpqL5e2rV/TCDD2x1MxPw08S8NKUr4J4XT+5l6blYHh1HCzHOwmiZcd7BhjiC9DeXS0Z0lO7J824xqrJUPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBHqw5apHMvrrXufyd1Q/VZQPQg6/TA5tygGYqkmzJc=;
 b=h4EMPc5G/OaGpSPvriP85Yd/7zGBaNLnbBIN0glCiMUpefrZGfhcJnIXyvN/aREknF+RLaQSM5Yaxe0gjSpstFJskg9Uzbd1GrZv3e8AnU38Sp/sy2h7D+SqrbORZ2LBtjkh9htO6o6EbUOeyuSW9tdKkW2T085U+8Dkv7+cWJrBgwprwsTJfYZemkQolf/RNBbkJk2OGH/90tnIj6I/Fj19c88yLLnpzO9FIecF55FjuN1dIPno9ZF/dY0BYwJUcdmh/YUZC8SrZ+dd/xyIaCDADuY2Aq1FEyo0XYnsHnvcvP/BNBugwWW8l9v//ZQHGPMn0oQo9bKe3LTT9ZL5Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 17:48:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 17:48:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 Nov 2024 12:48:14 -0500
Subject: [PATCH v6 1/5] PCI: endpoint: Add pci_epc_get_fn() API for
 customizable filtering
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-ep-msi-v6-1-45f9722e3c2a@nxp.com>
References: <20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com>
In-Reply-To: <20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731433711; l=3147;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=61Lz+aGDQkYpdiQf7LVfcFjngzuH5VC8R5EMQvdL0Ao=;
 b=JfBGlLbUICVEhgeq1pCm2JEL5YtsQO+gOFr9hG95EmvmL14CIRu9p//oyfgLDJIvgJx9XO7Ko
 5WY02KqrduVAkmrx0gA9rBrV1uF/bcJAWy8H3QdO/CChFUV6On2trZ6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:a03:331::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbb45f0-b439-4e87-6e5d-08dd03423d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVoxRk0xd2JFaCtseVJHVTFDWlhKbWJ4bDlnU01yajViYmU5NGZoUG5RQ2tL?=
 =?utf-8?B?R0VwbHYxaXFaSXBzZmFveU41K0NtZUc2Y2p3V2ord0FFY3FGNURZdVozWFZi?=
 =?utf-8?B?TUIxWmFLRU5NVXZSZ3RNTWxXbVlNM3dtbnA5a2tiaS85Q3dFR1VuRUtHeVVj?=
 =?utf-8?B?ZzA5L1VYQ3I4T2JNM2Zjc0cweHFjLzdsTWFyelpMeDltbnZpc1BRS1JydXda?=
 =?utf-8?B?Z0RlMGtDbnZrQ3BTNkY1cUpYZ2xSdVRHbTl3ekpwWTVJeE52ZHI0R0d1VmJI?=
 =?utf-8?B?WElMSVVTdW5pNUVXVS9OOEtRSjNlUittb2lZTTR1ZDQ2aFVPbVFCZFd2TDZU?=
 =?utf-8?B?L0Y2cHUwMmVxZFkyOTdId0c2TG1pd2IvVHl6dTFFTUhqbnZ5eHdURHlrcEt6?=
 =?utf-8?B?Nk1IUTVCQTFnYWVhQ3BESTU5RkdGaVN3eTJkbFdkMXNnVEVJT1gvTEZ1ZGZz?=
 =?utf-8?B?anhRZG93d2N2azkzbEZrQWNPWkJCZXJQdWtLcWVZeDZ5bEV0aUVXM3FFaXZV?=
 =?utf-8?B?TkVHUHFqcFF1SFN3QmxUcTlsdnhWY3UxemNaQUQwR2lwSXF2N3hWV1dhUlhV?=
 =?utf-8?B?bHE5NGVEYUw5WEMwMFB5VjA0dEt6amNUTGtJS05BV1dFN1RPdTNPRXhVM1l3?=
 =?utf-8?B?eTUrc1VUNUluTDdrdDdTUGI3VXIyWXdJZU9NVFkwUUpsamNLemptRWhwZ1h4?=
 =?utf-8?B?R0o4MjhVQ1lreEkyUkhiUk53aFZyZ1QwZ05leXk0NlVYcGtQVmFVR2gzRFNM?=
 =?utf-8?B?V3lSUU9WMmVPWmY4UmhCVjBoNHVmRzVvNzdNV2YwaE5IeUl2OXJ5dEVTZkl0?=
 =?utf-8?B?OXVtUU5pY2lvaHBaU0FySG9DemtBVll3SGJVclFZMDhZbFY5NGJQOVEyMEI2?=
 =?utf-8?B?cElxM0RyQ1F5eWxrV3BKREVBT1F6d2w1c016OUgzQ0VNaDJGYkdDekRKZGJt?=
 =?utf-8?B?cHI1WmphS3Z2OGJhSHloK2MrSmRrTDV2T0xwcmdwTGVKZGlxSFNWYW53UGw5?=
 =?utf-8?B?bzZCd1hZTEdqQlhYeHFZYTVpR05QczhHdFRkN29sV1M3V3lOS29GazI0aFgv?=
 =?utf-8?B?cmNJZGRsK0JOUjhlN1V6R1Zmb2o2Mk1KZGFIVnhtbUkvdnZlb3ZpbXJ3S1Qy?=
 =?utf-8?B?d1dGeDFvaUt5eVBGc3hGdmlxc0JML2F0cEFabVdxRU4rYlk0MktXTGw4c2Zy?=
 =?utf-8?B?bVRFNXNtZ2hXcVVnTzBQa0dwdk54bzQvWDhXRnh3MFQ5cmJyT01HZ29vSDY2?=
 =?utf-8?B?b3V3ZUt5TVRlMFFXdy80WE1uTjZPZlQ5aVM4Y2tKTnZyWDcwbFlIbm1WNmVL?=
 =?utf-8?B?WXlXY3NybW9vT1ljZ3YzaFFXK2ordDNhRTF6RGFHNjhZc1dsMVBwSTZGL2h1?=
 =?utf-8?B?Wnl6UU9kNzJzdmhHVlR0TXFnZmVwSjJjMmVmTHV6OFZLVGtiSkovdFFtaS9R?=
 =?utf-8?B?OTFuUTNRZVhkWndJbWh2OFVZZVVQUVR3L2IvK1J1NFozV1Ixam1rU0dNcExk?=
 =?utf-8?B?MmZpeVgyMXl2Y2F3eklTYkVMcHUvZ3hzSVNvMzU3ZW5jYi9NUmROenN0YVlD?=
 =?utf-8?B?WTh3Y01lTzRtNDllRmdkSTNEaTRmc215VlNtRm80UGthSEtJUE9xd09HbzBM?=
 =?utf-8?B?RXNHUDlHdFVCOGdFS1Y4eEdEelFZaUpuS2hSU1JLcWVWOTM2MnYzZGZaMkFP?=
 =?utf-8?B?eDRUWkxpOTJkUGkvMk9OMkNldk9VNnpQR0dyLzBweTZMWnkxK2dOamRoU2dP?=
 =?utf-8?B?b2Q0QmJMQ2pmbDZFNWlVME9ZaUNFbk9MQzc1d21adDdWZURpMTY3TlF0Ym9t?=
 =?utf-8?Q?JZeet8hxaAwAcgzcy9xu3RXgupvh9RAefJ0mA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUVKSC9LT2VVaXFVYWNLUWgremNhNUswaUN4Y3c3dlI2cFRGajVzUVZNZDh4?=
 =?utf-8?B?REF5SnhyU1VENm14ZTBPM21zOFZDcWRmL0cxUGVPOGhrZVpVRi9OYUhNcElF?=
 =?utf-8?B?ZFA4WDZKS3JIVjBpamw5emdZOHAwTkR1ZVg5RlFtMDlMQzJQSTA5ai92TmUz?=
 =?utf-8?B?ejQ0WjM5UzgrRU1UbWkxQTlyVlpnVWI3TnBSc2E0RzVYS2d4V1Vmc1N2dWFs?=
 =?utf-8?B?WEtEQTEvYWJKR3hoZWlVV2ZLMlBWazNyVDZvL3JtNEw1by9rMTZMSk1hSUpx?=
 =?utf-8?B?a1hzVHhYK1p1eWdreE1lYVBqWndZTDRSWGxqWjIxTUpabENpZlpyQ2JiSXVM?=
 =?utf-8?B?Q1FOdzFsZFlhUmFRU0ZqaWNqUGhWbU9VUUsxb1BER093cTUzdmpYWkNkSTE1?=
 =?utf-8?B?S0xSUndsWTBzYUZuUmR1K0dHRk5lQlRUeUFDaU9sY0R5Tk11UlU0eW4vajZn?=
 =?utf-8?B?VUJuaUhyWnRnYmJjZFFBSVg2OGNqanJBd1BSN1lVWWZZN1R0MEcyajF3ZHBN?=
 =?utf-8?B?a3N3QitWSk4zVTJBaUlMS0FsQnVpTUx4UXJNUTRPZlN6aVZGcDA2c1NSUXNM?=
 =?utf-8?B?Z2hYam5GYlo1bndrUVNpR0VyVVd1S0lyTHV6TGN2TzVVY0hFR2REUEI0Z2JI?=
 =?utf-8?B?OEEyanRXbVQwcGdZbTJCRElhNS9rQWJvVUgydWR6VU5YcDJPN1pUMDdPa3ZC?=
 =?utf-8?B?U1BUbWNsdWdhWVJWMEN1bVMwcThIcDVwOXYzNWwzMVlXODZKOUh6YWlYWGlu?=
 =?utf-8?B?UjNaT0I2aXBLbFpXN1VEK2paRmUxS3NLYmo4ZWcxKytiQStobGlhdU9jL2tJ?=
 =?utf-8?B?TUluSkltOWFQR3E2dUNPaTg0UG85YmF6ckZxa2wyT3hvemhneHJXSTAwZnpl?=
 =?utf-8?B?Rkl0VytQbkNJLzJjSnlMaTBIcVBqN2hmNC9NWVJOc09QM05oS2Q4TlYybWQz?=
 =?utf-8?B?akt6NmlVOXF6eEZHbjB2cVVBVkZVengrNmNSR0FRV2hZb202TEgxSlBKT2JM?=
 =?utf-8?B?eUh6VCtZU004bTlaQmlIOG0rOHVMcWtVSFdrSzBXa0U3dHg1bjVIUWdpVDRZ?=
 =?utf-8?B?WU1JVGlweTE5a3ViR2kxeUg4YUVlMU9vaHdpNWxvWDY3MHkwcDlMbE5oKzIr?=
 =?utf-8?B?RzlTK3V5bFpPMlVrR0VMaE9MZlc2d3ZBbS9mWXBhSUN0NG5pdGswZlQvQ3E3?=
 =?utf-8?B?dzlVb0hUN3pUcDlqK1MraE1IbXdRay9VZmM1UUxaZSs1S3NncmFOb3hSeFZq?=
 =?utf-8?B?MFFHMHdxVzJ5c0xkTFNBako4YjVQVjRZL3pnR3h3dkZ4d0FCRHBMT0xUVUF3?=
 =?utf-8?B?NDgwQkRHZWNaQm9lQ1h0ZWRNR2RzOGRZdHp6TU9nNnhwQkVRWnRreExta2x2?=
 =?utf-8?B?ZTlRbENoYUFoSWtUR3NrSTJMSEpFUlBtNGRza3dnZ0ZHdzF3Sm8zLy92alMx?=
 =?utf-8?B?THBOZzhJNW9JZTRGSFljM3J3SmRSdkN6OXhDRDBRS3ZqOTh6cWNjdktKQlVk?=
 =?utf-8?B?QU1jYVlMWGI2MktPSzloTEZOejFpTVFuQitMMDlmcDhqcHBoRGJZN3NXWmlW?=
 =?utf-8?B?Nk95ME1mT1BSYUVzNkZWb3Uza29uaXB3UERSeklDZjVpOVhwMTlQZ2xvaHdH?=
 =?utf-8?B?WERPTjE0Yk5KeGMwS3U2SkJ1U0JoQVBzQXZiRWQwSDRiT2tRYy9LVnFoUGZm?=
 =?utf-8?B?bUp0RXdxR2k5N0N5N3ZoWVBoSmRiY1h5ZGNURWdUblgvalFyTU5KMW5pZlVx?=
 =?utf-8?B?WE0zZmd5bFNnQ1d4QzBnenpCVm5MaHdmaDI5R3Q4TmlUUmlISisvdDcyWVFt?=
 =?utf-8?B?OVgwazJsNURnbnpyM3haM29NL3VGN2h6MzB4T2tuM0tpT1RXZ1ZHcUhISG5L?=
 =?utf-8?B?b0lzSEJxR29BRWFnc0w1V1g2Yk02YzN4alhnYnRNTi93Ky9zQUhrTkp1V2hJ?=
 =?utf-8?B?M2FjWU40WXJJRml6NWZDMmoycEs5Q2hYaEIrbTdSd2hKblhzQnJsRWZFTlF6?=
 =?utf-8?B?T3JWZEU4T1RFeUc0ejQ5Vlk1UVJkemx2b0YzeXUvaHlXQXBEbFRTSDJXS2E1?=
 =?utf-8?B?ZkJxaUNDTTlpTEpaQnRUZ3VMRU92OE5JY2xDaHRVb3pVcmg0OFZQNnJFSkg4?=
 =?utf-8?Q?JrgY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbb45f0-b439-4e87-6e5d-08dd03423d84
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 17:48:39.2573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQGL0p8n/m5JTwcLA6YgLIT7HH/XFQUKEJUauZjfPOCLMSPgpP1yh/n87DvHHWmcvZxdNTWrZzq7V0JaVxsYhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

Introduce the pci_epc_get_fn() API, allowing a custom filter callback
function to be passed. Reimplement pci_epc_get() using pci_epc_get_fn()
with a match name callback. Prepare the codebase for adding RC-to-EP
doorbell support.

Add DEFINE_FREE(pci_epc_put) to implement scope based auto cleanup.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v6
- none
---
 drivers/pci/endpoint/pci-epc-core.c | 23 +++++++++++++++++++++--
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index bed7c7d1fe3c3..f5538c007678e 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -48,6 +48,11 @@ void pci_epc_put(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_put);
 
+static bool pci_epc_match_name(struct device *dev, void *name)
+{
+	return strcmp(dev_name(dev), name) == 0;
+}
+
 /**
  * pci_epc_get() - get the PCI endpoint controller
  * @epc_name: device name of the endpoint controller
@@ -56,6 +61,20 @@ EXPORT_SYMBOL_GPL(pci_epc_put);
  * endpoint controller
  */
 struct pci_epc *pci_epc_get(const char *epc_name)
+{
+	return pci_epc_get_fn(pci_epc_match_name, (void *)epc_name);
+}
+EXPORT_SYMBOL_GPL(pci_epc_get);
+
+/**
+ * pci_epc_get_fn() - get the PCI endpoint controller
+ * @fn: callback match filter function, return true when matched
+ * @param: parameter for callback function fn
+ *
+ * Invoke to get struct pci_epc * corresponding to the device name of the
+ * endpoint controller
+ */
+struct pci_epc *pci_epc_get_fn(bool (*fn)(struct device *dev, void *param), void *param)
 {
 	int ret = -EINVAL;
 	struct pci_epc *epc;
@@ -64,7 +83,7 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 
 	class_dev_iter_init(&iter, &pci_epc_class, NULL, NULL);
 	while ((dev = class_dev_iter_next(&iter))) {
-		if (strcmp(epc_name, dev_name(dev)))
+		if (!fn(dev, param))
 			continue;
 
 		epc = to_pci_epc(dev);
@@ -82,7 +101,7 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 	class_dev_iter_exit(&iter);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(pci_epc_get);
+EXPORT_SYMBOL_GPL(pci_epc_get_fn);
 
 /**
  * pci_epc_get_first_free_bar() - helper to get first unreserved BAR
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index de8cc3658220b..d3d3b8c914614 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -300,7 +300,9 @@ pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 					 *epc_features, enum pci_barno bar);
 struct pci_epc *pci_epc_get(const char *epc_name);
+struct pci_epc *pci_epc_get_fn(bool (*fn)(struct device *dev, void *param), void *param);
 void pci_epc_put(struct pci_epc *epc);
+DEFINE_FREE(pci_epc_put, void *, if (!(_T)) pci_epc_put(_T))
 
 int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
 		     size_t size, size_t page_size);

-- 
2.34.1



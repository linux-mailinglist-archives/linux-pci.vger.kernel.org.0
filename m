Return-Path: <linux-pci+bounces-16971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA4E9CFF4D
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 15:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49231B25ED0
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 14:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982B781732;
	Sat, 16 Nov 2024 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VYLo6CEC"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013052.outbound.protection.outlook.com [52.101.67.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B297BB0A;
	Sat, 16 Nov 2024 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768073; cv=fail; b=ZCunFCx89ebGRRMv9vCBKFc1yGYdCIOOVgd2YKslVPX5fvMzkujh+7lJKOy8oSjWEZGriVRYWBjaxUV59wdhMmqoKeBCS8adY16KGsimG102O3eCteSM0DRC9fOOH9ySTES6J6QKO8OrlxAFXTSFn5mif9RYN36ETeOeC75FyUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768073; c=relaxed/simple;
	bh=/7Pai0goKHvPIK+tBY0qEDaD68qr8tke0aMwrO4/bPg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ATyqAq4f8LrmuOqAEVKJgASa1jxaViVkDhRhi3BDxRWzLNoxUDhnX7JepnK+KXRpWD7RLEHeEyQeETzmDTGxLooggYz7td7OVbG7hBphajH+Trmf6lara5Tr82W+8hcuRDQgmV0s+p5l9nHp/UwzGzkE8H20QWvuoWrmTWkmK9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VYLo6CEC; arc=fail smtp.client-ip=52.101.67.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cG9PPusefQ5OmzuxUgymceolTmwb2bgqaYcJPBMg9qUJi6OSp8tfiIfuu9GWIh1QfWvVkdA3nOR2LLD2qf3yV07NEv3QCgIF3RWXRvZiqfCSAkPFlnNy8dLVjDOJZ10bQxopPaLH8tw+oWX+ahZWNlr4/iTv4MtyJ2grgqMPHKy1R9bHxXW+1B2y92SGt47QnliY7Tm6DsyClnY1FWB8U1vlSsBsy2zv7unbycILeketJdP2EBi49QXkRM/wyKChiku97UzNxEYPaMNhqI/NfBOXlv33Q96A3GE29FDvpLMp5oaWeCeGFo4LUbEsY0Duhnod46ad0nO+QaMe9P0FPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sA9ZGGwKCFVa3/DR6CR6X7jz2TH0pu4avIrpxeaQ+U=;
 b=NL4KMSl8o1A2OcMzEKlRHwSd11bKtRQnXQKHMTEKhL/itMgJAQJVlAmjS9I6zZuzE/rLYaGtfwpf1EwUHcJbYroXG3fWJlLQfzEdbA9XZ7dl5l9+1O5GnODiwWGyWi7q+eXB3TqRiMx3+JGwuv/c/08Wsc1kE+tLfQbBCytqEpjtTt+qRAQK7jQwMKQUY8z1IoQs9VV6KMhDWK4qKkdyroVxbdRiIP6Gr8pVleRI8J0cMRsEsz4CpmIZBKjT80bX77ebuh2D04vzkqiiBkHBpKBRyg9qYSx2F8KtqNRWgU5VeV/6ZV+uDu2EkF1ZJ6BQh3L4HZdYTfJ5aUQHY1f/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sA9ZGGwKCFVa3/DR6CR6X7jz2TH0pu4avIrpxeaQ+U=;
 b=VYLo6CECcQITJTotF/xsVEFajkV1DBcCoae8tEgpnI5TG4qfWMq8ay+6N9+7rYpSWoVG2Ud6iiNGU4GJoCEBOxzfV7s2ocPlOOUwRKyr8HxZ9cnfLB2N1esJXqTBc7KcJHQVdtLwNFqfgm48WvRoQA9y5svcNyzjU1aKF7vLI2VIzOISdDb1OH5LvBLAOG4grmtma1ApRSjqsNG1x/ZLRSNtYAjhBlIRN5pmI8scxik9eUqWu4VtivzHNlaE5hIk1rt9tjDlM1qCNS0cr0iQY9vCz0lAwfK952r2PKISxH+gmoorL5RDUsQWKIxeK1gdgJkkRLLZVoy+0NvqgoFQrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7265.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Sat, 16 Nov
 2024 14:41:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Sat, 16 Nov 2024
 14:41:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sat, 16 Nov 2024 09:40:42 -0500
Subject: [PATCH v8 2/6] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241116-ep-msi-v8-2-6f1f68ffd1bb@nxp.com>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
In-Reply-To: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731768057; l=6297;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/7Pai0goKHvPIK+tBY0qEDaD68qr8tke0aMwrO4/bPg=;
 b=aolckxJBE7NIPP15dDaja5aOivqFX0rMvEJ8oN4Hfa2HiMT43Xbadu4x5MwNsXYQhI7hH5Bcz
 FOhmx3bYlXpCsw5gwKb0AWcFpsBYTJIddaRZFz3EOrNtMS612sVDdNt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad3b6f4-3474-4720-7133-08dd064cb565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VllOTGtORy9PdFpDTmdCTXQrTEZyQ04wRWlJQjIxZW96OGJoNG5Id21aTThP?=
 =?utf-8?B?TU5mb1ZnOWNycTNhSDRnU0RWRUIxejBQTVNxTElqL29YbGdwdXBGeEpybTVh?=
 =?utf-8?B?V1NLYk90eVRDdEhHTjZwQSt4N2RMZEwyY1JNbkxaTjNodWF1a2RwMHI4c2JC?=
 =?utf-8?B?cXl3NHN0TTVTcnNhMkduVUNrWklrK2dNM3kzd0I0bEZTMFFIME1HWEpna1Ni?=
 =?utf-8?B?bDBvcVBnUjI2clBzZ1dzeHI2TkwraXRySGlJdWxjbVV2OXk3VVdtaUx1WFlQ?=
 =?utf-8?B?Mk9NNHd3dWFWeHpLZDR4am5admtJOWxEajRiUVZVbFlDdkFDVS9NUlh5L2hJ?=
 =?utf-8?B?RmppdGlhOWpvMDRYWVlZUjI1Qm1TcTltOXN2N0dTSWs0Sm8vb3VCRXdPREVs?=
 =?utf-8?B?OEVvc0ZyZWIwamtYMFdGaHZ5QTJYYkh6SE9xdmdrN0YybnlJMnBlZkZSRlVj?=
 =?utf-8?B?WE9FSi90TGsySmJuZDl6Sk5JeW05STU5S0daRlRUSUdQa0YxYzNlL2tNbXJJ?=
 =?utf-8?B?SUo4dnlobXJLYTBSbUE3YnRRNTJlUFNzVVJLMEVJbXQ1aDFRRERZaitObnRJ?=
 =?utf-8?B?SHlZTU5EeFB4RUIzY1g3VFNpYlpTNC9Ma21INjdpRFc1bGhtWFhHbjF2VEZi?=
 =?utf-8?B?VzdLeDhQcERURGtqL0FxM0RwT2k4QzRubmM2c1d4RUlRNHR2MnlkckFjY1VY?=
 =?utf-8?B?bVVnd2pueFhtNmJxZ2d4UjUyR0JiVVExWnozRFdkNXBWTHlDdFBWc0VzaThY?=
 =?utf-8?B?ZG0xcHNsbHlmMFNadXNpcTZwTXUxaTBlL2srbnE0Y3MrQUsraFV5OC9VcVEw?=
 =?utf-8?B?c0FOZ00wckZ5UnpSczk4aDlzQVV0ZkhkNDNJREYrZEtjRTRTSkRFRFdRLytM?=
 =?utf-8?B?TEthR2xZZ0ExTGY1akh3MUFhZUlFTHF4NTliazZ6K0g4WFdRYWNORmQ4TDhK?=
 =?utf-8?B?c1RLTDV5UW0ydjVoQVZuR1l2aVRMTWphVEdkWVh4ZUdoamZ2RmtzNElrWTJ1?=
 =?utf-8?B?UDR2Nk9FVEhZTWdNMlMyMGpWaFlrckJDd0YrSXFvcGNVWTQ2NzBKYTVwbHZk?=
 =?utf-8?B?b3ppZTNYRTVXY0tYTG5MNHhQSEJOR3pkc25MRklqWndqVEdJdEVBRCs3VE14?=
 =?utf-8?B?UzRWczZaM0ROcjFRSStCc1ZCeWt4dDZXdk8rcXQwTlB0N1oxMzB4dnV4WUpB?=
 =?utf-8?B?ZjJ0amFzK1NlTFMrYStmK3pwYnVIMCtaaFJKVzcwNmVXUlB0TytWRlFyQnRh?=
 =?utf-8?B?bUVIeWhFUHNoakMzRlkvc1FDWkczam12eGN2Ym5sQzJUMHNRb0NuZ3Z2NEVH?=
 =?utf-8?B?a3h6NWNyblEwR0JoOFdxM2VRaUR3OVpFeDBRZlNpK01VWTlQdzlLb2IwM2Fh?=
 =?utf-8?B?d3A5bU5OVFZ6UWJKQkRyZHk5Q2JCdnRiUlFBdVhiZ0hsMytYSGhZZGRwZEhN?=
 =?utf-8?B?QTZ3eVo1dFBQNW5KbW1LTTJPWlRkMHBZQnJkL3Q1TlBuYmZuK0x0MldLWTlX?=
 =?utf-8?B?OURMQ1Z0Tk1QSHErUmwrc2NqekNQNzdaUjF5NlhyNGhvbjErREFLUU9FLzFn?=
 =?utf-8?B?UjcrK2JZVzZzbWZPWU5UcUVqMUEyZ3hkakdOcXl0UHNFQTY0VHRPQmd3eEFT?=
 =?utf-8?B?bGZpZFQ4TXZPUFU4QmZnbW9KZng3cFlVR2VjcXpOelNqS2xjTVpEZ3JMK3hG?=
 =?utf-8?B?QVlNUDhzV0NFbWNaczJ1QlNSN0htRllOeTVHVnkrdGVEZTZWZ2FwanAydm1v?=
 =?utf-8?B?d3VqOHJPanNyN1VqL1NiUzlBZHpLUnZBN0J2MFhhNlhJblQ4WUVsaTEvRFFx?=
 =?utf-8?Q?Z8NyQjeqZOYXb6x4bXUv4os5RFFJXj6S1/8/s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1g5ZktKRVVxaDB5Y01VeW1xOHR4d2podXBjT3BvVnhHRllnMlBJdTlQejBp?=
 =?utf-8?B?TG9FdXMzRU5wVkhnU0lBZnlqbGhOSTh6cWhmSW1HcXg0dEEwcTBXSk1sdVBr?=
 =?utf-8?B?dzFiL2xjelJ6enlNbmNmcFU3bEduMjA5Q29tSXdzU3k0OVdsSkZwdzhjUFdK?=
 =?utf-8?B?dzJROTB4V0x3M2lOS1RIQmRSYWdLQS84QUJ6YnRPSWFsZGxYd3lBRVFGQ2hP?=
 =?utf-8?B?dFZIdzdUUHRyQjJIekF6NE4wUUNwdGdqL2ZrdUMvb2x2dURnSVFxOGZzZStu?=
 =?utf-8?B?WVJpWmc4SDAxMjdaQTFSNzMxYndDMFVxZ2I0UVhQcEZ0Um1LK0VQRFJHc2Vx?=
 =?utf-8?B?M1JWSmtxVFFGY2Q0cGh4L0VxRFZJWWJMVG10QTUrcXEyMTFFRlV1TWN3bTNv?=
 =?utf-8?B?QU1BMTdmbkkrUlJIL01nSU93a24vYVZIcDM2SEt3dWhiVFRsalhiM1hKOENi?=
 =?utf-8?B?TURLaWpLdzQvRURZbWxyaFVtZy9yRGxoMFI0S0h1TEljaFdpOXZXWSs0THhC?=
 =?utf-8?B?REYwS1pCVVMyMTdRMisrd09sTWpvNWJrR1NhYjlxbFhXRFVraG9hOFpNM3Qr?=
 =?utf-8?B?Wm9ZMVFFekpvQUxZZTVDRjdKV2F5akNRQXhzZFQ1N3lacDZ0WmorUlFQTkZC?=
 =?utf-8?B?cTFya3JGT0hnaUhSYkZKKys0RHFhUTBIMDR2VGE5Q2N3T0V0WnE4eFFTazVo?=
 =?utf-8?B?enhWd0FtaTI3SHdZdXhjQTRXWU1UenVTS0NNVkNZbXNBWWVRQ2lmaU4zNzh6?=
 =?utf-8?B?Rm04MDlsRFZ1bXJMR3NRT004dTRyRmRoREpGVXBENG5kU3ZMdXYzcHVZYjZX?=
 =?utf-8?B?YkFZQklMZ0ZBV0MvbjJQbVRUUml2VlY1RHRXc1pXRGkyZDRIdDVRd2N6Z094?=
 =?utf-8?B?MlFzcU5aMUhWRVJGVm9jcWJRWHBkdjNNa0t2eW01ejh5VnZjREpDQW5EM09p?=
 =?utf-8?B?a09SUjh0ZUFySHBsUytNMElQcVE5Z2JGZjF1SXZmM29Tc21CTG5hZnpiL29h?=
 =?utf-8?B?YU4yM3dmYVVtMkZqeUZacUk3V3JoejZsOUVBa2FQTzY5QVBNbjJtbUExbVF2?=
 =?utf-8?B?QUxzTU5rZGcvcmVRSU9ManhnUWxlMXdURTY5Q1BPZWxWbGM3L1lvU05JSlJy?=
 =?utf-8?B?Y3NlM3d5aC9yeU9QNWVNNHlPVjJseTNyWWhtdHJkK0JIZjdMemFQT1BpbTZ1?=
 =?utf-8?B?bFhWTFVqdWlpdk1aRmt2Wm5Yd3RsOGFUN01TQ0thMEJrQWwrTmp1ekgzajNL?=
 =?utf-8?B?ZVpNQXFjTlFLVmZCbzhOSWgrOHVGQXNNekxhcnFsUHVtVTA5a25meWVsMU5E?=
 =?utf-8?B?K24wRnJITG85Zzd3ZTF5U0tjSlA0Y3hoU3puakl6K2lYYWM2Rk5heGZPT0I4?=
 =?utf-8?B?Y1F6UmpRMXorME4xMjR4UmR3U2xELytrUUFVZUFwZ3NmUkhsRFhONnRYWUFZ?=
 =?utf-8?B?a0cvL0N6OVA3UU9XWVlFa1diTXJuNFpJekRVNXc4YzZWMzUwWVRCL2tOdFBZ?=
 =?utf-8?B?a1YyWllZTXZVd21xUHFvY1pPbkRYUEgzODBtWlF5NHNxV0dyRDJ3a3hsc2xL?=
 =?utf-8?B?QktzZk5SdkZFVllZb3JLejM0Rys4enpvMzBPOS9FNnVkaXdIeS9KKzVJcXl4?=
 =?utf-8?B?WCszamxDWkhVNGVWSndRbE44YnN1TnlLWTBuZjgzMkVYNmtVY3llSTA1Rzh2?=
 =?utf-8?B?WDJnY21NaFdsR2RPM0VUMFc1akpoSUxFdlJGdDExcm9pbnRnZURNWVF0NmNG?=
 =?utf-8?B?UnZRSE1oQVltckh6K1lKK3dtc0NaQ09lQjFPbHRZV1lFN3MyeU1ZUkhTRWNp?=
 =?utf-8?B?Vlpndkl1UmUrMnF0elcvN0pwUUg3K2FFd1pXM1BRSWFaQWhaL3ZsZTBJVW44?=
 =?utf-8?B?aCtkVzZBV2szUlhITklReDZsdk5ubDhzOUhCZjREZW9rcDR3Z1VSeDJCZjhU?=
 =?utf-8?B?NHBFS3RXYnVlVHE0d0NGUzhBUGp6cGZ1YTh3Slc0dVI5U05SbVFMUWFyRXVY?=
 =?utf-8?B?LzZRZ3Y1R3liU2pDYS9iT0xQU20xaWVPZVZ0Yk5tdmFpQWxQVEVUai9DaG12?=
 =?utf-8?B?SSt0T1dpM3BrZVJSUVgzK1NqbkNhQTgrNzBHSlAyUWdVVDZzZjdIU3dJMmYy?=
 =?utf-8?Q?flyM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad3b6f4-3474-4720-7133-08dd064cb565
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 14:41:08.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMeSCH2ur+wcKpQgYegsA4kG8+vP5dDwZLlh5/jrzByZ3/iv1kiKQSVlaGRac9ZXA0tYhq5hNDj5w7jFkKdrdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7265

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v5 to v8
-none

Change from v4 to v5
- Remove request_irq() in pci_epc_alloc_doorbell() and leave to EP function
driver, so ep function driver can register differece call back function for
difference doorbell events and set irq affinity to differece CPU core.
- Improve error message when MSI allocate failure.

Change from v3 to v4
- msi change to use msi_get_virq() avoid use msi_for_each_desc().
- add new struct for pci_epf_doorbell_msg to msi msg,virq and irq name.
- move mutex lock to epc function
- initialize variable at declear place.
- passdown epf to epc*() function to simplify code.
---
 drivers/pci/endpoint/Makefile     |  2 +-
 drivers/pci/endpoint/pci-ep-msi.c | 99 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        | 15 ++++++
 include/linux/pci-epf.h           | 16 +++++++
 4 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b06..a1ccce440c2c5 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
-					   pci-epc-mem.o functions/
+					   pci-epc-mem.o pci-ep-msi.o functions/
diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
new file mode 100644
index 0000000000000..7868a529dce37
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint *Controller* (EPC) MSI library
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
+#include <linux/pci-ep-msi.h>
+
+static bool pci_epc_match_parent(struct device *dev, void *param)
+{
+	return dev->parent == param;
+}
+
+static void pci_epc_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct pci_epc *epc __free(pci_epc_put) = NULL;
+	struct pci_epf *epf;
+
+	epc = pci_epc_get_fn(pci_epc_match_parent, desc->dev);
+	if (!epc)
+		return;
+
+	/* Only support one EPF for doorbell */
+	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
+
+	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
+		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
+}
+
+static void pci_epc_free_doorbell(struct pci_epc *epc, struct pci_epf *epf)
+{
+	guard(mutex)(&epc->lock);
+
+	platform_device_msi_free_irqs_all(epc->dev.parent);
+}
+
+static int pci_epc_alloc_doorbell(struct pci_epc *epc, struct pci_epf *epf)
+{
+	struct device *dev = epc->dev.parent;
+	u16 num_db = epf->num_db;
+	int i = 0;
+	int ret;
+
+	guard(mutex)(&epc->lock);
+
+	ret = platform_device_msi_init_and_alloc_irqs(dev, num_db, pci_epc_write_msi_msg);
+	if (ret) {
+		dev_err(dev, "Failed to allocate MSI, may miss 'msi-parent' at your DTS\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_db; i++)
+		epf->db_msg[i].virq = msi_get_virq(dev, i);
+
+	return 0;
+};
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	void *msg;
+	int ret;
+
+	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+
+	ret = pci_epc_alloc_doorbell(epc, epf);
+	if (ret)
+		kfree(msg);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
+
+void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+	struct pci_epc *epc = epf->epc;
+
+	pci_epc_free_doorbell(epc, epf);
+
+	kfree(epf->db_msg);
+	epf->db_msg = NULL;
+	epf->num_db = 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
diff --git a/include/linux/pci-ep-msi.h b/include/linux/pci-ep-msi.h
new file mode 100644
index 0000000000000..f0cfecf491199
--- /dev/null
+++ b/include/linux/pci-ep-msi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Endpoint *Function* side MSI header file
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#ifndef __PCI_EP_MSI__
+#define __PCI_EP_MSI__
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
+void pci_epf_free_doorbell(struct pci_epf *epf);
+
+#endif /* __PCI_EP_MSI__ */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 18a3aeb62ae4e..5374e6515ffa0 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -12,6 +12,7 @@
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/msi.h>
 #include <linux/pci.h>
 
 struct pci_epf;
@@ -125,6 +126,17 @@ struct pci_epf_bar {
 	int		flags;
 };
 
+/**
+ * struct pci_epf_doorbell_msg - represents doorbell message
+ * @msi_msg: MSI message
+ * @virq: irq number of this doorbell MSI message
+ * @name: irq name for doorbell interrupt
+ */
+struct pci_epf_doorbell_msg {
+	struct msi_msg msg;
+	int virq;
+};
+
 /**
  * struct pci_epf - represents the PCI EPF device
  * @dev: the PCI EPF device
@@ -152,6 +164,8 @@ struct pci_epf_bar {
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
  * @event_ops: Callbacks for capturing the EPC events
+ * @db_msg: data for MSI from RC side
+ * @num_db: number of doorbells
  */
 struct pci_epf {
 	struct device		dev;
@@ -182,6 +196,8 @@ struct pci_epf {
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
 	const struct pci_epc_event_ops *event_ops;
+	struct pci_epf_doorbell_msg *db_msg;
+	u16 num_db;
 };
 
 /**

-- 
2.34.1



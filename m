Return-Path: <linux-pci+bounces-37295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BA3BAE8E9
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 22:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6C8194296E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA98B296BBF;
	Tue, 30 Sep 2025 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lTD6zoM5"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBDF289821;
	Tue, 30 Sep 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759264805; cv=fail; b=ZYrAXMwOHVIwrlpDN/ByO4BGz/A2EJfZIbf48hBS0EC2Dw/pRd3UgwqYzYQw+NjCs5ENKXzWz27/1xrDlTzAzqOSWqMBVP7xpWKKLzXCtKfIssPB+stiEtf1usO+74UgKYYArPdODQGt/xk+2961WTXaQPmUIyiQbEuO5OATgV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759264805; c=relaxed/simple;
	bh=Cj+RN7is4qGa/62A4wVwq6dpqg/IKkxlmwiXTG7Xvm0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Xlysla8RgxlsGmbi8SKrDYXpzggll7ldiIZCLtdTgWruwDxtBU3yy5jilj6GX1TkdAxC6EWBoG518PnPTDe0SBnKopDvgtUc1I4ZxEyQ2FfHpK3u4uDIr0F0aS3jm6L9UEQpJFS/fQbdTfsVjRKGCultnUW91MtMXQdNlUW5A5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lTD6zoM5; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fv6Tlpw2vlG9mqAfpNv9jHyhpbTfuTSydum8xVOHOHo/WE73/dFOOKVSu9smfoU5HW1J0WteFDBEOlZfL/l7teLSlELE284R9cnj3FVLHv49zzaTAH00Tlog7Ghx/ShmxKyfSc2oxN6Xmu1vAVi6UI98jWlLiMHssgWFRxU1f4j9ulFxT21qI/yHGVZMqW+41UIF8cmuyjDQ+R1RHj5N0Ac4E5mhcjzFEPaIGX+GpNY5f9oIu3zXVihLUXiLldq5auaH5IyfyZ0VdElHH1ac5lLbwVKG9jVp9egDvgO42oRkaiXEHiv2nNK2JIZtEKDIDq/GOv6/ihLzjKHFSGWB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHWbRAiC8i5izt1HSGsiS/oW5+fUUvuFdDDyNEx7tsM=;
 b=jNczHyXH+wkdJtedNocbzBv8ZMv/We6L37/A360JIwg1pX2JVEe8ApZrkC+ZmTgxfMkPKoFEdGrrxqY2wIiA7L1sjw9tjlgK3E8/WXBYY9iOLfUOjFwxm57r18TbPxmxySV4/wIRQEqZ6EaCdSZydz5oniVCznqt484nSBNKSYiBHpEtWeec636XFKbX6/OiTQnl0vHz2X2Jk4E2SFbi0uM1EJ97ot1x6iWWI5CfbwO696xw77Veou3Z50d5DLzaq+pyWopsf1vlM/VcJxAl3LMDD2F6JnXL1Rs7GXXqTzgT7dMES6tVwfZpTlIft3CqYeL82GPOFn1vMzvJcqA0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHWbRAiC8i5izt1HSGsiS/oW5+fUUvuFdDDyNEx7tsM=;
 b=lTD6zoM5+osjj+9qBkdbXtcZKNI8L/Dxc6KTWg2pOgOJ6aHpc1S1UkEmOEg7of8qZLt0Z+/Lws2NtpbZRUITxxvw2WACyB/OhmqLYoKBr+vAqbsJUMuPgtjVFydTWuf5rBgUwWfWCZSvKnCB1eXW/T/tycMJPHRTyG/24nnf9fqalniaeWr9MefhEDs91NeuovkjR7+M7AdLCZWeYvA2Gup7nPhNmC1wEYFw1VRzBxRHHri5damQNxCjBEwVSe11aQDErxdMaEpR9LdXs3VYenlsQX2id1qzGj12WvEfcTign/GHIWku88GZamUcYfTnfQSCjYdPef7mMzmibbdqvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 20:40:00 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 20:40:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 30 Sep 2025 16:39:38 -0400
Subject: [PATCH v4 2/3] PCI: endpoint: Add API pci_epf_assign_bar_space()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-vntb_msi_doorbell-v4-2-ea2c94c6ff2e@nxp.com>
References: <20250930-vntb_msi_doorbell-v4-0-ea2c94c6ff2e@nxp.com>
In-Reply-To: <20250930-vntb_msi_doorbell-v4-0-ea2c94c6ff2e@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759264791; l=4917;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Cj+RN7is4qGa/62A4wVwq6dpqg/IKkxlmwiXTG7Xvm0=;
 b=VVuSkuFKcnrArFI8+eEQxvCERznuW1b5J5B2gbMHvG+v3Cct1PWiQvnHApruKHSrIBeZFfNKG
 k+EGjS/i+KBAaesRZRf6i/YTa1O7a9obMVSdjssFSNUX3sNiFJhcjbJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DBAPR04MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: dde34ba5-68ec-4cf0-70c7-08de00618645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmNWVHdhMWNIbnRIUkVVU3JvT01iMXdVTmwwaE9RNXFOZU9LMC9NTUozTkkw?=
 =?utf-8?B?RDFPZ2RoYlhPZlU0UktzZXFJdy9WWGl2ME9WWFoxNmpZQWFlUEdvNlJqdnMz?=
 =?utf-8?B?b21Nc1QyRFVRSFhVT1F0VW1xSGVNK2RrL0gyMEp2Nm1HUXRpM2VCRXpHazRI?=
 =?utf-8?B?eXZCTW1LL0tscWRJMDI3TW8rWDJORkNZYUJRT2QyOGUzVkpjL3FRaGZrNEdI?=
 =?utf-8?B?VERkcFZtRm9aVjFsZm5XSTlVUEtBMUUyUnltZTNqZEx2NDJpdy8wNUZRTnVB?=
 =?utf-8?B?bHRxam9RalBLVk1tUktGdUl2ck5RbjNOWW4yYlJCMThVbExIeStYelVCWTlu?=
 =?utf-8?B?YlBFMW1rUW9OQjJmUFlweURHTk5leFZ2SE5ISkNtM3phQTVtaDd5Uit6cDBp?=
 =?utf-8?B?Ylk5N0p5bDZzeG84UFlmSFR0ckNhNDJoUVdUazRDSWR4S2QwUXpFclJESjJ6?=
 =?utf-8?B?WEtZeUhkb2RMS1dCclhibEtDcmdVa0dFV0loVnNhNS9sWFhna0xSckxYelda?=
 =?utf-8?B?bkdzcysrMGttU0ZWQ21XMG1wSzRvbXlyWkk0ZDdGdnlBUXlzQ2ZubUg2Zitv?=
 =?utf-8?B?eDUvdEdTaUNlQ2RlejFKMitkRUo0VXpPSjNWdHQ2WG9RdkZ5aGRpODZWOFlz?=
 =?utf-8?B?NjAwclBHYWlLQjZ2M3B2dmlGdXBJTzNNRTMvaHlvbG1WLzNGT2tkZzZLWmpZ?=
 =?utf-8?B?ZW5PUjZZUXo5cUN0NzNTL2pKT0c2SFNrOFVLL005MjJnRHZrMzdLV2x6eWlT?=
 =?utf-8?B?U3VrbkZnOTd4U1p3S0xpeFVwRFVWa2xtV0VReUxXZmZtYmd2b2ZKeVF2UFZR?=
 =?utf-8?B?R1VuVlA2R3ZKUHdwbHpWUmVxNHVmUDhKRDAxam00S1Y0Q0R4eTRQUkZkUWF6?=
 =?utf-8?B?RDJRbVpPRlE0UW9JNWxEZ1FONW8vc1ErUFVvSUE2SXVENGdPaGM3R0JORWxV?=
 =?utf-8?B?b3lPa3kydU9jQko1SzJTQWg5dktVaG1yWmlOYngrQktHSWR3ZERCNUMwUjh6?=
 =?utf-8?B?K1RDVnFWQVkzUUdRWjh6YWtiVE5hWEh0YUQ5cTBhYXdIWU5jZTJ2KzdKcWtK?=
 =?utf-8?B?SzBhdmRZN0lycGM2My9rK29SMzZGeVcxaWR3d29tRzJMUFM5YnFsUGVFdDFi?=
 =?utf-8?B?SnQ5bElyWEcrZWNvNFBMVzhxUVFSQUVySVQ5YmIweXZIbDhCL3FlNGhOQXFt?=
 =?utf-8?B?YWVTREVsQVpVbGRsSjRsUGMra0xjUDhXalo0TjEyQ2NWb0hsbG5qTzFLVm8v?=
 =?utf-8?B?UUtuS3krS0hLTnJrTlpCNUw0RW1JMGdBRTg2cElqZHdvVk52MzlCdU5NNWdK?=
 =?utf-8?B?d3BXcXNIenI5cms0MlNvYzZhdGJHZ3BYczZ6UXgzWXk5eDRVcHdrRnlKSXpk?=
 =?utf-8?B?K3dHa1pySlE5Mm94eXlhazd5WjZmUTQvYnVjb0UwenNWcDZVWlZ3em96Y2xW?=
 =?utf-8?B?VlRiN2NxL2NyalMzSXphdDd5cTYxcEJyVDFFMllyVEpwWGUyb2hjekdZSkFq?=
 =?utf-8?B?aWY3ZU9LeTJuN3NJdTRFemFueWFvVHVETm4xYWNnUW1Nd3JkaTV1QzUxL1Fa?=
 =?utf-8?B?bk5ZTzA5dkN4Z0dmcjE0Uk5pZU9uYzRvYkh3N3Y4V1RwT1ZZQ2FFUWRUeGJu?=
 =?utf-8?B?enMwVzFnRXZ4UUNIUFQ3Uk5vdXRkaVJyR2RpOC9rWnRDOGZyZ1FWZW55VjJo?=
 =?utf-8?B?TWFQbERXT21zL09kUm5BUSs2VmIwVjVGSURGMmRMNG9NN0FCdS81ekI1Snho?=
 =?utf-8?B?UEgyZ29JYzFFTzVJWFdENmI5SmZXS0ordG8xbFYxZXIvR2dhd0E5bXhVTDZY?=
 =?utf-8?B?eUF0Y3VMdXF0aGlEQysvSUJ4VkpqV2VVVGYybG95eDdzckltSm1mQkg2a09r?=
 =?utf-8?B?UDBWSXNleVpCL0JxeGxyTTBUSUZmRC9mZEZpUGx6MHhkbkRkcjJuOHc5V3Vn?=
 =?utf-8?B?dEVWTUN0WHhPY1lhaFBWQThHbForS3V5KzRabVVkeGRIM2xrR0VUaHA4bUI2?=
 =?utf-8?B?Yk1ORTNXb3hNR3FXWGpKTnNpN3pVQ2R1MFBPSFdUQkZmeEovT0pMdThQRWFC?=
 =?utf-8?Q?dHeeu3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUhmQkRsTEpkZ295U0pqQ3NyaEtBZkVmakZ4NGJRaXBCVmlqdFlTTTZDVG03?=
 =?utf-8?B?LzhGM2lQeEVpRHBHUjVkYStiWTFnNXdBQVcwR29FSTJNQUNCdjkwOTNrZzhC?=
 =?utf-8?B?Ni9DRGpBaFlxZGdVZUxINmNIbUkyeTVzYTVHS1lJUWM0ZHJTTE9NbE9sUVND?=
 =?utf-8?B?eW9sOW5LUktQcitWbDBUaUxDL3lnUUJXdjBrWU92OTJ6NFZrcVJoWWUvTHNU?=
 =?utf-8?B?Rk9wQVludHhTWWFMR2Q1QkhzMUljbUZLd0tkUHZWd1NmMjU3UDFpVGpSZ1NU?=
 =?utf-8?B?LzBBaGpNMVZTandHREg4ajVNa280V2JrZEQyZHBSR2JSeE4wb0lCbXBJKzNV?=
 =?utf-8?B?QTI1SHhhZElpcENkQ3l5U0ZScHVSTVpZUXNwemNzdWpPeXN6aG91YUFUZHdt?=
 =?utf-8?B?MjZGRWdCSmY0TkF5NVRUMjFhS1ZNZmFvR25YblNQUFFVWGc5OXF4VFRCeWg4?=
 =?utf-8?B?ZmZiYWRNNjh1MCtUQlVXSFFycFUzMDk1c0RRekprNmxCUGc5TEo5MG5vSUtI?=
 =?utf-8?B?QUNoSi9OaWs2LzhDNzVraExDYjBHYW1GUU8xNThrZDU1Vy9vTGs0WmtaUXhl?=
 =?utf-8?B?OTZHTWhCVUFLalhsMk9mdDlNaTRwT0trM25za1JtN3JJYks4V0FSQ1BRZng0?=
 =?utf-8?B?UnpZMlJQajdlZ040OW92R2Q0UC9QM05Uc3c0VjVCK1YyNUw0aVMyVnNSNjZX?=
 =?utf-8?B?UjFnT2h1SzY2SXgzVzlxeHRJM0JaWW55QzdHR0NyVWIzU0pxcXN6cERxVk03?=
 =?utf-8?B?bVd3V05xenhVSzJnMThHbUorNE5QcWZIODhsdmVzOU5WTlBWTHlYdGwrSnpz?=
 =?utf-8?B?dE5wOTBzQ2I5YmxMcktmc1ZpMHRIUkxuVmtjb05aL0lQR2E4eit6Yndta2RB?=
 =?utf-8?B?dklpTHZBVFltMkdNWHh6bCtvNXpqSFlRQ25SK1RncFY0algyMHJyUWtOT2Ju?=
 =?utf-8?B?QmF3WVk4dkpTQjNHdmlpWWlVZE9IbUhWL2Y3UmdsQU9ERFB6ZjIxK0VmRXRj?=
 =?utf-8?B?dmJndlVXYytvb0tSWCt0dzBibno4akFlRkViSWtBU09JMnVwVFd2THZSMGYv?=
 =?utf-8?B?QldqUkpuUC9qdWVxcVVWM0thNStOVFk3L2s0Y015em0ya0l3b2FnQnYzUE40?=
 =?utf-8?B?Yng4NEo0TTNZSlBrOUNFSGp2amFxR3dGc2k0Z29yejRIRnN2UVdpOGdwdS9x?=
 =?utf-8?B?SjU1NER2cFpCSHViZUNIcDh6bFI2SGhKQ0QvME9LY3RJWHArdDRIVkR3dEU1?=
 =?utf-8?B?bzcxWmN2azdBaFRXbXJHV2dzUHNta3MzOStHUXFjeUVTdXlVOEFyNlVPWjZ1?=
 =?utf-8?B?RVgyUkdPVDBSeWJROWdBRmNLRnBQSEt2VW9NQ3N1Wk9JckQzcmtTR0hGYTJE?=
 =?utf-8?B?cDI4My9xNXd4UUcvVEdMM1FRTHhvSEtzZ2NGOWN4TEprcjArNENxalk4VXdu?=
 =?utf-8?B?QlpWQlFxcXQyUFRHeXZmdTZBUWFvYUNxR0xDRk1HZTFQajl0QjBoNC9QTmlO?=
 =?utf-8?B?RnRmV3NoREJxb1VFaHpkb0RkNnMwNm9XaVhhSTVIMk8zUnhmNTMzOEhkR3M3?=
 =?utf-8?B?VlFNTFlETGR1M1RwUndFaGdwTGxNSklzUGFSQlp4VWx5TDhyODJnMk9lcVJ1?=
 =?utf-8?B?akN4dkJneVBxcnEyTVhRai9DbTk0cGx0YS9Na2JVZVJyeXFWRUJaS0Mwb3BK?=
 =?utf-8?B?Njd1ZGRuQzZIWTMxRnAveFY1RW8vcGlka1FJcWF2MGtqdXJ5clRkbjB4eThS?=
 =?utf-8?B?WSs3ZXBoMWcwb254ZFNabXQzSzN4NUhLMWM1RW1HRkw5cUNxdEFlNTc3NCsx?=
 =?utf-8?B?R3NNSjJkWlFKQmtINUg1d0sreWdiTG85eGQyc2x0ZjhjZFQ5T2lNRDJJeUJy?=
 =?utf-8?B?ZkRVQmwzbGpwZG5tdWRIZjJhb3ZXdDltV1IwT2VDY2ZJMW9FTzlHaXQ0aWdQ?=
 =?utf-8?B?K0d1RFVxcGgxNU1pLzRIN0lxenJxNDE0a1g3cDltU0w3Tm5oYUFMN1o2ckp4?=
 =?utf-8?B?a2dYTjVnS3dGMDJHUkpNODVjYllwWmF6eTRGLzA1T0kyc3kyUDR5b0Z3U0ND?=
 =?utf-8?B?WGVmWm1FOEpXa05GV1Yyc2hQZDRDRXZxdVlNOVovVjE4UHlTN1FkWmpldU0w?=
 =?utf-8?Q?T1SQrljq7B9uQWI/QdAK0dSp6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde34ba5-68ec-4cf0-70c7-08de00618645
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 20:39:59.9792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fv2qlqEhd03vRKSvoDzBt2d9aCKeKItqy3MZg44TOfc3QNAXLdRxUj3RwhB17hblqnyJLNtPmPUWP0lwKPdcFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366

Add pci_epf_assign_bar_space() to allow setting any physical address as
inbound memory space, such as an MSI message base address.

Since PCI BAR size must be a power of two, the input MMIO range
[inbound_addr, inbound_addr + size) is mapped by finding n such that
[base, base + 2^n) covers the range. The base address is also required
to be aligned to 2^n.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- use size for bar size.

chagne in v3.
- update function name to pci_epf_assign_bar_space()
- s/allocated/assigned/
- add check when align down input address to memory align require, may not
bar's size can't cover required ragion.

change in v2
- add new API pci_epf_set_inbound_space()
- fix bits 8 * size_of(dma_addr_t);
---
 drivers/pci/endpoint/pci-epf-core.c | 80 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  6 +++
 2 files changed, 86 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index db0420f601d81de426a3e805c7fc309de58d54b7..d0b8a02c1de988873d28ede76800d5d4e9810827 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -349,6 +349,86 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
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
+	size_t bar_size, aligned_mem_size;
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
+	bar_size = BIT_ULL(pos + 1);
+	if (pci_epf_get_bar_required_size(epf, &bar_size, &aligned_mem_size,
+					  bar, epc_features, type))
+		return -ENOMEM;
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
+	if (epf_bar[bar].phys_addr + bar_size < limit)
+		return -ENOMEM;
+
+	epf_bar[bar].addr = NULL;
+	epf_bar[bar].size = bar_size;
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



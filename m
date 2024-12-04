Return-Path: <linux-pci+bounces-17714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 198D79E48E9
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 00:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8434C163E10
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6867B2066C3;
	Wed,  4 Dec 2024 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YtKU66a5"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2089.outbound.protection.outlook.com [40.107.249.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E0207DE2;
	Wed,  4 Dec 2024 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354781; cv=fail; b=jXMqIP/COhDeH4XPWE+wJfuzuClVRZpZfMdDq9NzccUsF4RsZ85JgYlYtbgilRWIWg2QUU/S6EDdInDAhAtoXi3ABQ85pkCBzNOlqtiXrLo9rRpEyD+7gwnwNbtDaUszEn7az21BpahIWjb1Wehw84zTH31IAfvhla6/2zpb3HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354781; c=relaxed/simple;
	bh=ndCsNl7CzN6Fgn0Kp89Q1LtC1gKv1xdWwtoLPsqn874=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=EUxsUXcH3+wfPD+aCXDwmD3IveynCMfxVlxxNJYMaDt10dkH8mYAh+P8Eoa+jILcfPkNYJcKaY0r9ukyD6stnpikEtwOcXAddA4ACPLVKR9S9gKIys40QUp6PuVRbeBDiVEfrD6yBVMi/0qQDrsR0nEVS++VDJY4nSnRAriRCp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YtKU66a5; arc=fail smtp.client-ip=40.107.249.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ri/3bUT8PAjDEBOg16+ZSnbyo91nwBiA58G8LUlW66N/33v5JU7jPpoebDND+VH2KfBJahEF1WVYEer5WVOEohscdSb9nbpnKPw053Yjrtco62VE75ikkK+Wyyz+puydVKqxIGP951iXGW9YopHrV9ZEeQzXmUQYYTt0ZnPEtYZAizeD0eNODezdlxP7337LWpmNHp9szBEltg3S90WwVJeXDOFCQVxEFFQKdZ4cmD/Pijme9aNKnVruSZd9svwHFdIssq7aHeqf/jX5YkM24yJpDdYGo+6qyDqqUbnTf32SAFQ5XTjpcYhndTk4g0Tbjy1TsV7BuAg1nMwOFuD+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au0gmyzBByXMX9kk9x9rwBQKfT1Y9pshosRUmRms4M0=;
 b=dDtgM0MGUz7VgRMOGC/xW0u6i4uMA3m5jzLU9nALRxoTMWRfT41fiv+N3VnopmiQx5amkSvXc50b+v9div6HDIf7F5kwBfthZn7RFjr2H5t35hmPIoaSFLXLCykQJ7oZq9TqRmd0RJAOUOffZGbwMAEvqhu7asltaB4hxLkz4EnM5XBMudD84ew350PrBgGGFZAPwCWDLXoaqmRVfPmxCUPubKJrdW6MDhc/ZHyNxvKYnEtErX1EHlD7I1iMFYj5VRbMd3MIGulV82Qv0+/kNLxAe/Cp+scXXYyk7TcpqZEAWJAL5rvBHqmncPXmBx45omi9TW1OlFncZx4WwOhAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au0gmyzBByXMX9kk9x9rwBQKfT1Y9pshosRUmRms4M0=;
 b=YtKU66a5GS0a1qw7qb+5T9q8ljR/jz7h3sqRb65BxB/TEaG7FcRsJQ1Eiv9bf7VivJGMKonEfWcmNuyUphPk/Oah87UOCvnodADpF5+qxzqySGY0FtEc00KnPwE5WCGFifG941VcmCC3U6dNMEGbdUwbFa+UIOAumZ7u7eEhaWnkTgpbl5D5vrYYCsK/FdMPZRKHPBRA9fYdjhD0RKmJER/kHlNmuUwRGiZcG3buZQ2nUdxH6rRprlSpo9U90yHNtN2EVFI+CM5spTZJtm7iL0vWXQMc99J5N1s75nu3H4neUdN3jYCeID9YhBI+Y0Qft7wXT+21UjS+OKvDbrDGIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11006.eurprd04.prod.outlook.com (2603:10a6:10:58a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 23:26:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 23:26:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v10 0/7] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Wed, 04 Dec 2024 18:25:50 -0500
Message-Id: <20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP7kUGcC/13PS27DIBCA4atErEvF8Car3qPKAhhoWMS27MpKF
 fnuwZGC7S5nxPdreJApjSVN5Hx6kDHNZSp9VwdgHycSr777SbRgXRDOuAQGjKaB3qZCbZDRByE
 ChETq42FMudxfpe9Lna9l+u3Hv1d4Fuv2nVDvxCwoozFhtM6DjuC/uvvwGfsbWQOz3CEBDcmKD
 Bj0HJ0L3B6R2hAw25CqyIN0CiJDxswR6R0C3pCuSKrsDOdJRP7vPLNHsiFTEUofjfc5II9HZPd
 IN2Qr0hmytjkjhHBEbkOciYbc+ifNMESRQSFuaFmWJ7ORz5XZAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733354769; l=8442;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ndCsNl7CzN6Fgn0Kp89Q1LtC1gKv1xdWwtoLPsqn874=;
 b=ILm4DKj5EZzMS+iAluuDbx4E4V+D6/l9gx92p+0d8AMpI66uZjgjwWMoIqN+6TI0mXU7m2A4c
 d3dl8btJIsnDsP2DMiqTK/mkp0Zi3UHq+b7Jt1ekpCvFj9d9H2uDrNZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11006:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf8f125-e4c2-4b1b-9c03-08dd14bb0b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmFmSmdMVFBoN2RsSmJYNENPZklET3dSbXRMdUxQdllhcDZubGVzbTdqam43?=
 =?utf-8?B?MU5DemVlRm1pR0tZdnVYdGdBSFpHaXhwa2lZMnJ2WE9YNllRY3lTem1KUTRU?=
 =?utf-8?B?Rm80RHhoN2pWSHVOQ05uSVFVelJlVlhBVERBckNyQ1FpMDcyZWNOQ2h4Z3JL?=
 =?utf-8?B?bTByYXU3ZkJSUDh0WjJDRC93WjVIMCtYMk02T0NMOFd3enFsSzRrVjZFcXdR?=
 =?utf-8?B?bm9XaTVvdldVYkd0QTNPc0tzNWpjRXpBSXhKVFc2R2xpYVdJRFgxTUVyZEwy?=
 =?utf-8?B?MWc5QTB5dXRSZFNZMDdMWGczTkplYWhpSldBYVR4U25RQVRzWnhESjYyeFlD?=
 =?utf-8?B?QnpMR3NxRUlvSFJPZ2tJZlFUM2tWTmNRUVhIOEZIVW9HcFpRNURUaU9pNmI2?=
 =?utf-8?B?YTVRaEtOOEExQzd1dnN0Yk9DU3dvKzgvMlllSnh2T2NBQmJOTWQyVkhGdEx2?=
 =?utf-8?B?M3VMOUJyYUw5akdWekFSOVJBMXVId2ppU2IzcUUrT0hyc24ydG9XZkxoNmdO?=
 =?utf-8?B?WUlNL1dHbnpranVXamFqem1HQjVwaFlGS0FQb0QvVk0yNm43ZFF5SXNaQzJM?=
 =?utf-8?B?N2NsZ1I1RUZheEJ2WFl2b2hKV0hiYjVPdkRnZUpDSkJOa3l3UitLZFhXd1Nu?=
 =?utf-8?B?eXhPNTI0bTRVNWQzTTdiSG5JVDRROVFMNHBoNE5acGZNejRhRGhabGNoN29D?=
 =?utf-8?B?Y3kxTHRSZGdLb1paR1pVcjk5amJNQWllc3ZKRkRhZjdzK2JGNVJ4blR0Mmdy?=
 =?utf-8?B?UWNhQk56bnlmbzlzMU5MOG9MOUxEdkFlR1g0N1B3M0czR0tnQ0pwNnZUbWFk?=
 =?utf-8?B?VHozYXBvb2JMTmVpLzBpaGtVYmlBVHRSTTl2NUdTNjJKS0RRcFk4dDErZE52?=
 =?utf-8?B?USszUTZ5dkwydUZSWktXU0s0SUVKZXBuQTNnajk0ejVaKzluY2QzWVhXaHpM?=
 =?utf-8?B?RmVqMEJkVUk3Q0gwb09SVFhXM25mam4rcjVzYm9NU29jL3dwMklrazFWQldp?=
 =?utf-8?B?cU9PanpMWFVNWDY4MTJmakloaWxlZ2FVTVZPUEtFMzRxK1BOZ0k2L3BXVk1L?=
 =?utf-8?B?QldBN2FmaGZBSGEyVEFoWmEvVm5XekYwUTl3QXc5WDdQdUkyREhEMCtNZGF6?=
 =?utf-8?B?c3daanc0dXBHWDI0ZHh0Tld2NXZFRE16d3BsSDZRU3RPbkJqSVhZUDhIRUp4?=
 =?utf-8?B?MmFkVFd1RU14OHd6dnlYQUdwODMzVmZINFd1Z1RYVk5QTjhtekcwMFhrMUJm?=
 =?utf-8?B?OXZyR2IzaEMyMURmR0l6MCtDVFF5ZnlKWHd4b01YeXNwbmlWYkJKU1djMHA2?=
 =?utf-8?B?WHpZYXk4dHovZFNYUFowU2lwODFmNXZYa3NCRDE0Q2RhYXkyT1B5UERER1Yr?=
 =?utf-8?B?cTNVR3Urc3JhcFJQaThaR1ZHcWxoa1dnYjNDenMxUDNzL2V5QU5pOXVIblVt?=
 =?utf-8?B?c2RabFl5VUZxakFaNUJ2K1dtc2RYUWxpN2xkSUZtdHplcHdDdnBkWWtxY05P?=
 =?utf-8?B?V2V6Vm1JOEQvcHQ1WUJKRmRKQngwSG5pTHgrVGM2aUZ3OU5QWWRwN1dzOURs?=
 =?utf-8?B?S0wzZm5QS1VoRThsYW5sUEJaMHozMWI3KzR1M0lITzd6ZTBMVCtVdW1mcTVI?=
 =?utf-8?B?NjhNRGNQdE00cWhNMWs1cHhTMkJ1S202RnQ5N0poSjBsc1NPSjMvTTR3dld5?=
 =?utf-8?B?clN6SHEvMFExRG4xRVM1QjdBVk9nMzZCQzIxR1E0MERhOEVPaDdwaFlqeVd1?=
 =?utf-8?B?MzAxdkliS055MDFGT3hqTi9uNUZWRzJhZmJSd01GTmxEMUxHbUlHUnMxWkQ5?=
 =?utf-8?B?ZDNXeGx1Q2d6T3RveUppMnVhV29RMXlmYk9uY0E4QnBaVDRLdVZEdWVMZWVE?=
 =?utf-8?B?S0tseHV1K25nOUc2QXcrcXBqSzFSUnc2VGNPLzgrMTgvc0RucFZIUnpkeFFX?=
 =?utf-8?Q?nnbGHibhkkM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlRxQVo3a3d3a2JtbTk4dDFJOEEwNytxY3I5ZmE4UmlUT0RCSFhHS2VQMHli?=
 =?utf-8?B?SEtDL2pxRVlMNVlyOTBORTBhcFRKbW4xSURSM21pZTErbFkvcUR1M0V0UWwx?=
 =?utf-8?B?NEhjUXlWTmZRTStiTndaR250bGFBVWZLcWNDQ3BFclR6UHNjNzdrR0EvNk1u?=
 =?utf-8?B?VktOUnJBamI3b1VIeW5qcS9DZFM1em1vSUI1bDlNY25aVWpuQzNoWE91ZzFR?=
 =?utf-8?B?WENaVS9ZeDRMTUpxVm5ic0k0VnhiTmlIb243Mm5GOEozTGNvbms0dEFxanBF?=
 =?utf-8?B?aVlIVEY5T3FzQVZwNjJXMFN5S3dNQTFXd3JaVUYyVVpBcFQ0WllldW5OSFZF?=
 =?utf-8?B?R2txWFFsVXJybFNJWi9vT25uMmhmWVNmNjhqMGFnT3dNU2JZbUNFUEVibmJK?=
 =?utf-8?B?amsySkRQY2pGaDFocjlCa0ptYU1VbExsU05pQlJvN0lzaTVIUmRkZGVIblNF?=
 =?utf-8?B?OEU0Q2w4MHlQL0lBUkFJczN2U0N2alBMTUxtb0tIZGxsUkNsM0d4bEU3N1hG?=
 =?utf-8?B?R3ErR2RVeW9USVYrY29FVG5scDhCeFJRVm5HTmoycXJ0TmZGWkJJTFl2dXlz?=
 =?utf-8?B?MVh4Z0FGYTdOMFZRT29nN1VDeVFFWkNwOEdBM0VrUmNtM1g0M2hsSHAxbkhj?=
 =?utf-8?B?WnpEL1d0eUlKVUpTWmRYV2hBREJqcGhQaEtYdWJjWU5FeGZCdXFXNnUxZEpy?=
 =?utf-8?B?UGgrNlliM1pjTkNZeTJ1VE1YcnBUK3pmY2s3UmJnWWZjdkNKK25XNncwYjdh?=
 =?utf-8?B?Rk5sejNWRTNLS29JYjZRcFJyMUJDbG1tUUVBNW9Lc0taQktuUVR0c0crUldB?=
 =?utf-8?B?VjQvRnJjcURVbE8yZjN0SEQzWER0NUNNMHpVRy9lREc5c2J4OHdVQTFxaFRQ?=
 =?utf-8?B?TW5rTEtTdmcwMGlUK1lyKy8vVC9zS1RER2d6ak1ndGt3Tklaa0ZVYmowenQr?=
 =?utf-8?B?d2JGVlZ1dUNJK0I3dzFmV1hpazlCQ01aYWxzSWhBc2RBNjdXZkQ2LzdMVzNS?=
 =?utf-8?B?V0xVMGhQY0l2S1kzbFpwOFJacXBEZ2h3Q0RIbnJuV1lDbWFQME82UDg3aFBO?=
 =?utf-8?B?NWFDWjlNRnF5bXM2L1pMZDAzN28xRFNLQlh6KzdCRFhCRjhuTjFNVUNNdVhh?=
 =?utf-8?B?OUxySTlhRENQWDN2dlVGT3FVb3NBS0d3bkwraDNxODVQcENxL25ZZGIyc1Bk?=
 =?utf-8?B?ZDhoeHltMFBpTjh1YURFYk5pUE9WY2ZHUnIxcGV2cHlJVEJBaE5FZ0Y3emo3?=
 =?utf-8?B?YThSNy9SMHdsdklhSUxwTDEyd0lxWTlmZHYvdjdKc0tjYkFZa1lhdnhtNmVD?=
 =?utf-8?B?NUVETWVjU1RwTyttS3BGYktEVEtkMkNQOG92aEhyc0srMGg3US9Ld2NJelly?=
 =?utf-8?B?SzJFOExMRGxnNDBwenRGSG8xa3I5SzlvU0tlK2NRMXowOFhxZkh0L2RoUlYy?=
 =?utf-8?B?aWRGbTFDOHZyRmdMVmQxRG14aE9CMzM0UHpjMjk0ZjBrWHFISkxHd21rZ3E1?=
 =?utf-8?B?QkFyVkFyT0hQYm1LZlYvVjZBMmlHM3Y0U1AwbmlMOVdjRE1rOWk0Qjdpb1FR?=
 =?utf-8?B?cjlTNTNLYU85dHF0RjNiOTlIUHFUNUJIdGUzb2Vjc1RKbGt3NHM0N1VHaytk?=
 =?utf-8?B?UzY1ZE9JdENxU1Nvd053U01wTmo0VVZHellsejVZZWIrdXRidXJXRjJuRzZS?=
 =?utf-8?B?Q3lKYllXWVhxU0Y0UmNSdkJlL3ViYmdPZXVLUnY5bjRZZWk0Lys5Mk5pc2Zx?=
 =?utf-8?B?amRXeHRhb084SU5HbXJCamtzZmtzRmd5MzBwNm8rN04vN0M0SHdSRlZQcnlD?=
 =?utf-8?B?UzViTllUTG1jRStiYWE2SjVIbVBFY0V0dW05WmlSWGtEOUs0V3gyeHg0TkJW?=
 =?utf-8?B?UW01NnhhSWRuQnZyOEVWSnVxUWtQMGxKNmNqcGhHU1lyalh2RTQ1VmJTdDVt?=
 =?utf-8?B?OVo3aWozNnpPTWR0SjBHMlVrZHRRRzg1ekZUVVBQWUYrMHRMOFVseHJnUnZ2?=
 =?utf-8?B?WDNPK3BjT0w0c0taZ24wRHplcFNzclVhVnkrYzE3cVNTYWN0czNrSWtPVWxS?=
 =?utf-8?B?d2NRK2RBQm1HNUJJc2FIcmdyaVd5S1ljTktrbmJXc1dOeDlHMWkzMGY3L1Zu?=
 =?utf-8?Q?GZnA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf8f125-e4c2-4b1b-9c03-08dd14bb0b84
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 23:26:14.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvP0pJ5m6qqEJO0FpGucl2ZlNIfQQ9uesSmw8tTAaaqnTMjLAfRm7YZU7a+bjMZjL/5IRCczo51iX2ckDk5IuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11006

┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

Original patch only target to vntb driver. But actually it is common
method.

This patches add new API to pci-epf-core, so any EP driver can use it.

Previous v2 discussion here.
https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/

Changes in v10:

Thomas Gleixner:
	There are big change in pci-ep-msi.c. I am sure if go on the
corrent path. The key improvement is remove only 1 function devices's
limitation.

	I use new patch for imutable check, which relative additional
feature compared to base enablement patch.

- Remove patch Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Add new patch irqchip/gic-v3-its: Avoid overwriting msi_prepare callback if provided by msi_domain_info
- Remove only support 1 endpoint function limiation.
- Create one MSI domain for each endpoint function devices.
- Use "msi-map" in pci ep controler node, instead of of msi-parent. first
argument is
	(func_no << 8 | vfunc_no)

- Link to v9: https://lore.kernel.org/r/20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com

Changes in v9
- Add patch platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Remove patch PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
- Remove API pci_epf_align_inbound_addr_lo_hi
- Move doorbell_alloc in to doorbell_enable function.
- Link to v8: https://lore.kernel.org/r/20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com

Changes in v8:
- update helper function name to pci_epf_align_inbound_addr()
- Link to v7: https://lore.kernel.org/r/20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com

Changes in v7:
- Add helper function pci_epf_align_addr();
- Link to v6: https://lore.kernel.org/r/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com

Changes in v6:
- change doorbell_addr to doorbell_offset
- use round_down()
- add Niklas's test by tag
- rebase to pci/endpoint
- Link to v5: https://lore.kernel.org/r/20241108-ep-msi-v5-0-a14951c0d007@nxp.com

Changes in v5:
- Move request_irq to epf test function driver for more flexiable user case
- Add fixed size bar handler
- Some minor improvememtn to see each patches's changelog.
- Link to v4: https://lore.kernel.org/r/20241031-ep-msi-v4-0-717da2d99b28@nxp.com

Changes in v4:
- Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
- Use new method to avoid compatible problem.
  Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
  pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
driver don't support new command, so failure return, not side effect.
  After test, DOORBELL_DISABLE command send out to recover original map, so
pcitest bar test can pass as normal.
- Other detail change see each patches's change log
- Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com

Change from v2 to v3
- Fixed manivannan's comments
- Move common part to pci-ep-msi.c and pci-ep-msi.h
- rebase to 6.12-rc1
- use RevID to distingiush old version

mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
^^^^^^ to enable platform msi support.
ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep

- use new device ID, which identify support doorbell to avoid broken
compatility.

    Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
    keep the same behavior as before.

           EP side             RC with old driver      RC with new driver
    PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
    Other device ID             doorbell disabled*       doorbell disabled*

    * Behavior remains unchanged.

Change from v1 to v2
- Add missed patch for endpont/pci-epf-test.c
- Move alloc and free to epc driver from epf.
- Provide general help function for EPC driver to alloc platform msi irq.
- Fixed manivannan's comments.

To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: Niklas Cassel <cassel@kernel.org>
Cc: dlemoal@kernel.org
Cc: jdmason@kudzu.us
To: Rafael J. Wysocki <rafael@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
To: Anup Patel <apatel@ventanamicro.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (7):
      irqchip/gic-v3-its: Avoid overwriting msi_prepare callback if provided by msi_domain_info
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check
      PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      tools: PCI: Add 'B' option for test doorbell

 drivers/irqchip/irq-gic-v3-its-msi-parent.c   |   3 +-
 drivers/misc/pci_endpoint_test.c              |  80 +++++++++++++
 drivers/pci/endpoint/Makefile                 |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 132 ++++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c             | 156 ++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c           |  44 ++++++++
 include/linux/msi.h                           |   2 +
 include/linux/pci-ep-msi.h                    |  15 +++
 include/linux/pci-epf.h                       |  19 ++++
 include/uapi/linux/pcitest.h                  |   1 +
 tools/pci/pcitest.c                           |  16 ++-
 11 files changed, 467 insertions(+), 3 deletions(-)
---
base-commit: f134785ecf3bd881a10f83dccacdcea2ac45e673
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>



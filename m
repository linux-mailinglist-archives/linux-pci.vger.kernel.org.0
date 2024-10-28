Return-Path: <linux-pci+bounces-15484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3339B39FA
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 20:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E54D282D88
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 19:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CF81E0091;
	Mon, 28 Oct 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i44CfLEA"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17F61DFE3D;
	Mon, 28 Oct 2024 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142378; cv=fail; b=HI1E+I2CoyQ/+bxFyktCp5avYhfhfvYUj24xRp+9Q1kcMSaB1/2/2hYymGUY0VD31STivd3hIjB7LwCxYbSgxlpnHdxzo/yWasSFSRgWUmU7cHIkVVPc3FGlsbEE6kU8CFx/z9+LUYAfWy61/U8fX5/SE2wD5VssYDrGxqacgyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142378; c=relaxed/simple;
	bh=1rSpPrZTOLMx4xcaG4Itd6ReEroEzwhMtX2XtNZo75A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=u2MAgySjgJ0OeepLKgTJhjsKiqcAlhqD+8Lji0WkM4e9Yy/+SgpHJHNvMKprYGoBDoMc2PLXRWZIUPMLg5zsRFGklydNJ4cJEEnBcLaKyTigbWK0g7lsQO51oycWUWJe8pBP0GGdPTBp6y3Va6liYiMCeS0eqzjiqRzCs9gLy8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i44CfLEA; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYdR31S7JxRhwuB2Qa+v1lkJ5lEnSOpyh+o/d4iIoKQmdj3Vxj3PMFHJ9iqEVUO+4Myl5fapCCJg6szdamK0ISgbtwIyaEjAOVkbWTWgn3DUUJ0+vANxGzCMDAf9N8f3C7y5MYRuXnnmomKW7Rs52er2kLq/c9TDycwHFS/xw22b5x7MqcXPMq1ei34lXaVcAdaXXEKRITC48lChj0PvhNhFoCFqGaSwuW2jjiJ9ac9Ne0K/DsCtukBYHTdlqQwdkJ5Rtw+tT7jrnjwSJKhz3jGyEMQ0NyjCMnLc6yVafrsn7F4QqtFXcg98NttEOP/top+zF8xXUkitq7qzFRDbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/JXxzlgrGYw0PU9k1GSfpOM2XBdolyCC6yjHKtj9mc=;
 b=U56AaNicLTW7w20oCYSoDMhA9/kzpNpJLAHudHvbTaHVTgxAp+vcjMhVB/UvHoB9ICcvzhfyWFvb+Ud0bJqWBPWbKh38N5yclpCQzY0ZEGzS4giuHRuuzwtLs/kHQul3WhMF54dtSS45aoNQBJNlujSxOg/0BEHdMV8hnaRa3WGrfGKKl7NBuApP8fqp0IfA/q7aTb/v/85mgoGDTjcr560VQ7zSG30y3ODji8MmlUKancXIlcNyMI7+zxhFZkBd31HGXO+2Vd3kd8ZM+9Y1ktpgHrJF58DgLBeQ5ZARxnA6NxOKxLfUvG0liNyQibPNihmbPFJcB52IZTRc3ubs1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/JXxzlgrGYw0PU9k1GSfpOM2XBdolyCC6yjHKtj9mc=;
 b=i44CfLEATVuAKr9NkEo5nIT8nyAN0O3131/VQOW+g+pNar4yLiviiHDj4fqxtWQT3NVTQlwTU0sQWbhRrBon4gP4MvU0GoKld3jJFHAfawcO2t/WhpPa+SB0Bm8z3QECX/4wHt6j6Ye9OnsJV1JYOAyqYB3FffytSE5p7/NiQYash93aa+tNn2mqSLaM6BdRiTRwsUrqrlu0TGWf308qRBEjAN5VWLJLVDt+qUM44ggoLCBBaxrh8DsyqkeG93KSxXa82mMe4baL3pM6ELmvr8IzfuxT7cmTdnUPyPM7qQH4IVLpdw3ynBBqly3eMiP3CVd/ccTRu4ZaLk1GCmFYqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 19:06:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 19:06:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 28 Oct 2024 15:05:55 -0400
Subject: [PATCH v6 1/7] of: address: Add parent_bus_addr to struct
 of_pci_range
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241028-pci_fixup_addr-v6-1-ebebcd8fd4ff@nxp.com>
References: <20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com>
In-Reply-To: <20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730142363; l=4762;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1rSpPrZTOLMx4xcaG4Itd6ReEroEzwhMtX2XtNZo75A=;
 b=J6JHDGWw7+6ttmVw93GRpH/jRwLln1TzuZg5mAkybhPYDvZQ+fEG8f+9RhzC56plqOFdcImic
 T2IfknfXeVzDnLRpqG3P3EcsV5ohLwEU6D/ZNYt0B17KM190FvUOY4/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: b7335a89-7173-47e9-2c42-08dcf7839706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGZueXJmb1JHS0JTMHVicWdEbFVJQWlaKzZudDhoZHNWcFhPL1RFZExtQ1R0?=
 =?utf-8?B?dFpTN2dGRVhDTWorQUkxN0NUdWVINGJYZHpjbUxkbWhlV2padHgvR3JqQ1Nr?=
 =?utf-8?B?ZWhvL0N0WEhidTJydzR1ZzQ1NEIya1dUY3BBd3NwYlN3RkdTazRZSk14d2xG?=
 =?utf-8?B?Z0hKK1R0VjN6OWZKbDBzazlMSnEreHFtRU0rbjlmMFZrOWI3aUIxOWFQMitZ?=
 =?utf-8?B?ZjZySENVV0FYR2NMNWJtT3Z5VmJNeVpmWTRRdWVldTNPOUNvMWhJYmYyaU1N?=
 =?utf-8?B?RUFTMWdGVGxJcTdQbElwNjQ0ZGNSTml3cVI1TklkaFkyc0lmeTdCQ3p2bEFJ?=
 =?utf-8?B?Zm5ORlRiTnZNTDNSSjk4dUNGL2gxN1Z5Lzh0V0NjcW8wcjhwcjY2RmZUd24r?=
 =?utf-8?B?N0w5VEVrY2VhcWlHVlpyelJoYlMzU0EzVXpIVGc1SHhYQnFVUW55ZUZLSEU1?=
 =?utf-8?B?bHRad1h6NXlhc0JWYWZlYkljdVA2YS96bFlQNVZPUHdLTU9TN0hTbjhhTnpt?=
 =?utf-8?B?OU1EMFN1SlF5RlV4VWVxZXUyVnV5citoU1NnVy9yRkJxVzltb2V2VUpsendP?=
 =?utf-8?B?aUw5dGtaWWd2WDBiUVFKQ041M3RnRCtORTVMTENoK2lSdXZtV25nZUx1QmhF?=
 =?utf-8?B?NXl6SGxsUTc4dHhJNGRjZ25RSm95OVozbkZkdHpxTDVpSkx6ek5TVFk5S1Q3?=
 =?utf-8?B?NjdXUkFzRG5SbkVtNHV3elgxVlphb2dGSE5YeFNHaTIxQS9ieVBhRHFUTS9r?=
 =?utf-8?B?SlpoZjlGVlBDQnFoekdMTGlVY2xOajBLN3kzZ1Ivb1RqSnRTRHhVWnNkU3Q3?=
 =?utf-8?B?V3h6bmtRTGJMTkpMUXhSTGpBblkvanBZZ04vYWZNdVY3THdGZVFEbG1vNkw3?=
 =?utf-8?B?RWc1WEhHYmNFczl2WTk0bTdDN0NDZ3I0N3NsQS94SktIZmRiaGswRFMzb2o5?=
 =?utf-8?B?N01rWDYxTkl2M1pvRE9iZnZUMEp2TFZlK0lmdGtTTERDcjdOTEZVMktKTi9F?=
 =?utf-8?B?aDdZTE9FekdFMEt1ZWU2ZlZ0QlJ6Z1ZLc1FCMitqUS9KcFd0Z1k0ajBQcVpr?=
 =?utf-8?B?dEwrWjFSaldNY3hSRlFxcytxaWczbEdacHcrS2xRV2czeTVwVG85TnJtaXF4?=
 =?utf-8?B?cUdCemd6dVk5WkhJaDI5Sjc5cThUbmNLY0JGa0hoTitmWlNBZi9JMUY0c2lZ?=
 =?utf-8?B?cG1YalVGRzBXZlFqOWttcGNSUEFPMVNqZEFZd0RNUE14YUZMaWlHL1NBTmZQ?=
 =?utf-8?B?UGcySld6OU9TMnI5aXpWK0xPbmladlRIZ1hCNytpTmoxU2Z4R0l2QWVxd0ha?=
 =?utf-8?B?OWgvMGJVdHMzYUNad0JvQ0YzYjY0RlN5aEs5TkhIVUNQYlFTRDJaaE1JRVJu?=
 =?utf-8?B?ZDVOV0NCN3M2YmRxUExyMEErbDc3eVNzTUsweXd2WEU2aTNFWnNRdzlBRXY0?=
 =?utf-8?B?MW8zK2Y1UVoydld1SGs5bko5Um5RUUZ3TmJUQWtsS0YvTXIzYmtkcFE0YkZr?=
 =?utf-8?B?WWtwbnZwTnFBaVQ5QUFBcFFmNDQ5OXlxdTlpRk9LUCtMeGNjS2ZGS2JZemxh?=
 =?utf-8?B?YVZTQVNZeEJHVEpMcWVrcDVwN0VHdkRtNWhzNWJETmN0UnNKRFNBUmRQZEQy?=
 =?utf-8?B?ejBKcEZGRk81K2lzVk5PWTR1bTJOeUtUdFlEd1VlTDNtMTNMeGx5RFJnT1gw?=
 =?utf-8?B?dUhzRmQ5enBDVUgxSVl6SmlTZkNGVjd6QytYdCsvN2lleXpURmU2eVdrWWtw?=
 =?utf-8?B?RlN0bGJDQkJBUjdDT0dCVDZJUWkzWWJudXhLVG5XYjd3VzRQendqR2krSnB0?=
 =?utf-8?B?OWNjaWJRUzVGUkhuWkZTamNBV1V6Zm1MdFBYdVExOWlmUUl6UDBveXJaSHFx?=
 =?utf-8?Q?DmSYgp99UliHY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d25heHlBNllZeE8xbzNVRk1ZVG9rRkdhdElPZDdsR0NIcnVyK2ROZ1BGdm5j?=
 =?utf-8?B?c0tvRHQ4NjNxQjJ1MWVaLzkwZTNNUjhDQm9XajR0c2hKbkk5U2FhVTJaRUFo?=
 =?utf-8?B?cWFqeWVwc0tqT1Y1enJzR0pwT29SZzZEY3BpTTRyeGdabTJoRW1EU2RCb1JL?=
 =?utf-8?B?bEh0bEtPNDhQYXlOZzRhR3ppY1JaM0swSXJQZ2oyRWhhSW8reGNwMU5NNVcz?=
 =?utf-8?B?K3UwN3lTK01FOEp4ZVd5amFOem1Xb3pwYlFweG1vK1JNUkY0T0Y0N1RaQU9r?=
 =?utf-8?B?M0c1MXlSNkc4VTRUSHgwa245T3hROERyOEsrQ202TEViVmRJKzJValNQTVpt?=
 =?utf-8?B?dFdhSFozb1FGaHdnYXdrMWQzNFlNamFZR0F1T290dHZVV2d1RmxKdG5UNjFP?=
 =?utf-8?B?LzluQXdjWFF3cm1FcnhHSmJIdGluQURKbCtRbmdTUnMva1FSUFlINEE5ZHlS?=
 =?utf-8?B?aDJscjdyV2dxZkdTdUp6VVlOdW9WV2NwT2s5S21acDkrV28rdXlvYk95dGc1?=
 =?utf-8?B?RGhQOFlhb3l4V3JPb3FOY0hHcWhkNkZLeHlULzZyYXJvdTh3SWt0b0ZsR0x4?=
 =?utf-8?B?aUtHWHRwZDAyYi81azloS0c4akt1RXpqaVpBVjJLd1FSYXpuaExEYUw3dmho?=
 =?utf-8?B?OUhaN0dDOHZZZ2RiODEyUFdvdlc3Ri9TK1k0MyswcU9jek85WjE1TzJsQlNU?=
 =?utf-8?B?RWZIR2xFSkg5MTREMndXQjVjUXhGbitSRm1BZEpBcmh2b3l5eUFkam1QZUJr?=
 =?utf-8?B?OEZSTm8rNFNZOXpmM0l5dzkvYmZGcHYxMGhaRkJ1SkxPL0hiMnF0OG9WQ2xt?=
 =?utf-8?B?UXRxNGRsdTF6MDgzU2FpbUZlUzNxNkRhdFBzZmZ0Zy83VzBNMis2Zno0UGpy?=
 =?utf-8?B?Mk5KTVlnLzVCdkxERXgzYm9QelB3dGt6UHpQUmZ2NHdOakJDaW1pNDBTL25a?=
 =?utf-8?B?TmFseldTaWNwWWJNZXdJMjZYbnM1MUlxeHl4aEVZQ2NxaXlIZEpwemZvb25P?=
 =?utf-8?B?SWxVeWNBS2h2MGkvTDJRcjNVS1kyVkNDajVoSXNoSVdLQ3NSM2dranpJbnBC?=
 =?utf-8?B?ZGRmKzZVZlFlOFlzZlpqNkNkR1NubWMrWGJxMjFkMFNQTDBmQTBNTWVJUU1R?=
 =?utf-8?B?eFhId2JkczlXYlpvL1JxVXozL0Ruelh4Nlowei80YWo2WWwrVDY4aFdZeFFv?=
 =?utf-8?B?NzRCc3hHNTF6VzF6Y0RTVDhxaDlJRGIra0E5b1p5U2JyQ2JXYmdiK2YyWEZs?=
 =?utf-8?B?V2RWMklHMkZWbGZZaFo5c3cvSU9sOWJ0NEVORVNFTVVrQlExRTBKSVd2S1JX?=
 =?utf-8?B?bGpYTFkrYnFlZnI4OXVLRW9mOHB3eit5VnFoYzFqZ1JSUGxyRlNlVUFML1Ft?=
 =?utf-8?B?ZjhvT2VRU0RGUnpub3B0c0Y0SmZQRjVGdm5VSDZJVUh2Ry9SbmdIRHh5d2lH?=
 =?utf-8?B?WnFjMXZjRmlRejZUUk1UWElKdkg3RXpQYWxpQVhIcmNWaVNraWhxMmtOMHQw?=
 =?utf-8?B?NFl0dmhnN3N0Snk3TUlxcU9VWG5qbi8vUzJ1amhvNENteWJ6ZVpQZXFIMzV4?=
 =?utf-8?B?V3ZNanN6TVpNK0pXVm5WNFFqdEYybVoxdFdYOWJIQUlsaC91ZDJMVU9lTFov?=
 =?utf-8?B?TVRQMXNoaTdPM1BkQnRkTVBsMnZqVWFabkh2OHY0N3RpY2dsRUV0VFpnZDY4?=
 =?utf-8?B?VXVQL00wQjIxWXgvdktFSTE2cFM3WGUvRlF2aVc4WStyNm13U1YzbWIzSmFr?=
 =?utf-8?B?ZU9FRTVQazFmZUN0VnhGNTluQlFHcSsyUHNiTUcxNURYemE1djV0cU53eXRI?=
 =?utf-8?B?VUZhUzhwTGY2end2NHZUTnJScjdualZqL0l0OGIyT0wrRlM4eVNXeVk1U1JU?=
 =?utf-8?B?N2tmcmE1d21XTVhDTVB3cnBLdzRZd2VWbDJ4L0JIOTBNN1JleEhmZUYyaTFF?=
 =?utf-8?B?TmU4dTBtSnlRb2hFajZBTzZTTm9pbGVSaGtnWUtyUTIxSUh2UnBWYmtvZklT?=
 =?utf-8?B?MWtvbnU5UUlXMEhBWlFaNlROeG1mY05CNVdNOUJjMlpjQ0p6aTN1cGlxSE5E?=
 =?utf-8?B?K0JrUVV2dnpGcHhML3EvNk9CMDE0Y2xrYXBXeDN0Y1lxeTNnZTNVcVpWbUhG?=
 =?utf-8?Q?Vs8CHeTntbm1NC3nusIImSUTY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7335a89-7173-47e9-2c42-08dcf7839706
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:06:12.7368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPbyIgtpRxiIuPXYjon8GAYaJTu9MplsXJ9SzDQ6HYMWKdghiBYsKb3CdfLRghskuAAnussHAy4ILdy9nppsYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

Introduce field 'parent_bus_addr' in struct of_pci_range to retrieve parent
bus address information.

Refer to the diagram below to understand that the bus fabric in some
systems (like i.MX8QXP) does not use a 1:1 address map between input and
output.

Currently, many controller drivers use .cpu_addr_fixup() callback hardcodes
that translation in the code, e.g., "cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR"
(drivers/pci/controller/cadence/pcie-cadence-plat.c),
"cpu_addr + BUS_IATU_OFFSET"(drivers/pci/controller/dwc/pcie-intel-gw.c),
etc, even though those translations *should* be described via DT.

The .cpu_addr_fixup() can be eliminated if DT correct reflect hardware
behavior and driver use 'parent_bus_addr' in struct of_pci_range.

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff8_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► CfgSpace  ─┼────────────►
             BUS Fabric         │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

bus@5f000000 {
        compatible = "simple-bus";
        #address-cells = <1>;
        #size-cells = <1>;
        ranges = <0x80000000 0x0 0x70000000 0x10000000>;

        pcie@5f010000 {
                compatible = "fsl,imx8q-pcie";
                reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
                reg-names = "dbi", "config";
                #address-cells = <3>;
                #size-cells = <2>;
                device_type = "pci";
                bus-range = <0x00 0xff>;
                ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
                         <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
	...
	};
};

'parent_bus_addr' in struct of_pci_range can indicate above diagram internal
address (IA) address information.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
-none

Change from v4 to v5
- remove confused  <0x5f000000 0x0 0x5f000000 0x21000000>
- change address order to 7ff8_0000, 7ff0_0000, 7000_0000
- In commit message use parent bus addres

Change from v3 to v4
- improve commit message by driver source code path.

Change from v2 to v3
- cpu_untranslate_addr -> parent_bus_addr
- Add Rob's review tag
  I changed commit message base on Bjorn, if you have concern about review
added tag, let me know.

Change from v1 to v2
- add parent_bus_addr in struct of_pci_range, instead adding new API.
---
 drivers/of/address.c       | 2 ++
 include/linux/of_address.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 286f0c161e332..1a0229ee4e0b2 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -811,6 +811,8 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	else
 		range->cpu_addr = of_translate_address(parser->node,
 				parser->range + na);
+
+	range->parent_bus_addr = of_read_number(parser->range + na, parser->pna);
 	range->size = of_read_number(parser->range + parser->pna + na, ns);
 
 	parser->range += np;
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 26a19daf0d092..13dd79186d02c 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -26,6 +26,7 @@ struct of_pci_range {
 		u64 bus_addr;
 	};
 	u64 cpu_addr;
+	u64 parent_bus_addr;
 	u64 size;
 	u32 flags;
 };

-- 
2.34.1



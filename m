Return-Path: <linux-pci+bounces-5542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED9C8956CD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726001C22233
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725F58662E;
	Tue,  2 Apr 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rnB84iME"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2120.outbound.protection.outlook.com [40.107.21.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16E85262;
	Tue,  2 Apr 2024 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068443; cv=fail; b=kSPJYo1PelVK8KQozaEPePkl4c8PrnW8Rmk/PR577E9OAGAArd7OUw7S3aCW3aYkYhc90UuG98HU7OkwJQhRdfChiz4BSykT52k+oXfQQjhRGc1DjxYYlCmo4Jp/MuEi9gVX7iT7UjTvUzSPGdxK9LJPvCgi7ooSOez6wASLa1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068443; c=relaxed/simple;
	bh=g0TnLssf6ZO/VS4hksqxYpwW9GwlcB36cQW12l9OG0Y=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=KC/xAooQfPaYjNEIGjNSXxmkDUOmlaQzoDXDeBAFsaGvFcuyGveVUeBdsWDnijI3RMUXWntEH+HiVk5gXNbsZDHSctKCufAQZTJ6vUkrJ40Mxnv3XAkYL8IhBt4mhgFvYUkr6DvG4MiPqI70XFBi7ku4WbpD1Kwhf9lESedmq0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rnB84iME; arc=fail smtp.client-ip=40.107.21.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uk+onZuHgkMKP24Uyt0Nrk0A4DNqgCIiitjoPfY1hSFfIWWelMNBre4Hu8JmRG4ooXRaDmnPSD5aCg+ldLsGhZ5Dbw5GFHnrjiiIidkgjo1Ck8VV31yi9e0E2ppEjtsZ6LyE8l7T6D3z2cIywzAPFATtLLwY8F8iTqDdn1sP3QKkvb+jZpMBJp3qguE1J/2kCghVTK1ZAIMuPksrKSXC+2VFAN0sQ1ywOJcgUuSfagZz12CyF6Fh6QIXpGDdSrZ0gf7rqhRvKMy3jT3RB03jG4BjBxoiOExwPccpduPJmFzyVKTja5vfJDLx6PwjRlAEftdLgjsb2QUWqoCgbrJz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2xBhOE5xCX03MkkfZ7geeWDcK1LxfnKQHQchpUyzq0=;
 b=AkVwgkgPL9ZKKpE9Z8wyDNIXZfiRTop7fFSURaIveLNZA15IdPlP1i3lspvezQXXBXaA6ySJjFgtpZ2ltxeMv+RtQgdmsaR+xtnHAfhOUbCTgEUlSzqxbyJcMMoypiuFouMf4Jem84pyNO26lStNZN5JD/rl2IAoLfxjmuA8ZM5NQHNuu2c75kkf8BCEFgODYKvDZUcneHR0eDAPlsqOMex81PNb6QuRN+zp9DSQewboRkma+mWsF3ZksugjBkz1Jt7J7u1XkozTmKmSVeeyEf/TuYNk8E0y0jC2qBs82da4nKVxAcDqNOcLpznrwT6Zqfll09I5YeV8yAFrtVrswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2xBhOE5xCX03MkkfZ7geeWDcK1LxfnKQHQchpUyzq0=;
 b=rnB84iMEGYxNxglnAP8oISAINxxM90Jbin3GPzkt+mHPMtTUJECqp/rGqIdISXHdf1HuO0FE/P7MO2cCLq04TDA0V7b5Z40pINrefRJsshUjtTvwCd0VWf2SXqhaa3oEG6sppzjo58NnEfm/yC93qEB2fBItIM0XfC6dYsZaZDk=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10036.eurprd04.prod.outlook.com (2603:10a6:10:4c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:33:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:33:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 00/11] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Date: Tue, 02 Apr 2024 10:33:36 -0400
Message-Id: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEAXDGYC/3XM0QqDIBiG4VsJj+f4/S1bO9p9jDFMbXlQijZpR
 Pc+6yQY7PD74HkXEk2wJpJrsZBgko3WjXnwU0FUL8eXoVbnTRCwBMSaemXx+fZxCkYOFJTWrJG
 sYoKTbHwwnZ333v2Rd2/j5MJnzye2vf9KiVGgbVNhd+GcCxC3cfZn5QaydRIelkP5azFbqaFWl
 WmFFvVh13X9Amxz9SrkAAAA
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Jason Liu <jason.hui.liu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712068432; l=3642;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=g0TnLssf6ZO/VS4hksqxYpwW9GwlcB36cQW12l9OG0Y=;
 b=4df7Z1o9zd1ydMWO9SVVnPWYP7Y8vJ/5WfHNlo0BXhqBScVNh/Il6iGUN4SRbyvdHnEdcNQBa
 0fp/vFc9WIrBnMwKzjIbJtZgX9JaFZLI+n2fHp3GaOQIPgp/Ca/8zjB
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB10036:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yp30ENuvDzxxqSrmv7ktovbUkmj/a8Gcfpvii4Xljfr+cdMlTdLv99KGua+bxLR4ya6XgnEkR0XO73tDwV7RJd1pyAfkQJiJTn8yaUzzl6RfhwcIKtsGtEp+lC4TtQ4yVV+Mt49PFSVOXD2VdQYISjDJZscDJenQqyEIt/6WiMEyRbkm2qfeeHLa0XOcz87tTH6iyOdttXAe4J6yw3OQ2KTL6VJVS1M4z9dX0REpDHWqCCOFoZJWbWxseD2hHrZ9PIjEXXiiP04P0Khs72oMmRVh22lNHNXBCGDwdX2rLUwbRji518FpRQrqfT+Rz813x1hFESvbR3an5jv7fFWYv78l3ZP68i28ZZVFiTrS34XMqUI7C2QWHgBxK1xL1JEGWnl0AfVUyIDqxKOfHDevKCcAjV/ZIZGJrLlQly9YODqA3Ocw+0Or1ufVY2IBwhjc9ol4qbEeSMC2UyG1F4s6F45Xd3IlpmGQ5vB8oz2Cagrxy1xIZhzqTAssdKvh/TnnWZPLRCYU6PWrOGOYjT8yT4ncMLPpJSc9zNc/vXU1J+OkTNnkf2yvZUc618O+spaPWfuZodRS2RuTmNzq7Wl3YxSywjvVaXN86loXYjRJV8qs0yPEn/P089LNwLQmRDUVNAGbi+sxwmydHJWQG9Cl/YezUS+ILalbju21k1K9/WMEgAkLwd7A/h/Zj9zEZ9lL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(52116005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUFUQ1RqZVdZOTBRMDZhcFI4d0RhbTlDbjdlUWdKNUVMVlJGakJqNmJJRmRv?=
 =?utf-8?B?bi9VVzBzZkt4bzErVC8vR08rb3FYd0trdjJIODFwaFYzbllubG00SnRuS01u?=
 =?utf-8?B?Vkx2K0MxeTlDTnpkc3JUZlF5OUdDRVo3Y0VkWHByOEp0ZnFQejVEZnBNWUl4?=
 =?utf-8?B?RHZHQ2dQbGNPSklnbU1VTGFQY1M1K3dJQWx2UG5MWTIwWTEvUUs1THZ2cHZo?=
 =?utf-8?B?Ykx1UGIrME5qY0ZpUEkweWdnQ2p2MHpzR1VGWkU1TTlWRk9IWXVVMSttNWd3?=
 =?utf-8?B?WXB6cjZzUmkzNkJjU3p1OEVSRDlRMnFoekdvY01zM0NFbERsM0tJaTNwOWdi?=
 =?utf-8?B?R3l0TnYvMWMrOWFtaEFxbEQ3emZhRFlyRXRkWHZ0MFBkU0xrV1RuWlMrTDIv?=
 =?utf-8?B?UWdNbHlQOFhaSlBSRkhCTjMxKy92bW85dkphWkduaXd4YVhuZm1vWjEwenhT?=
 =?utf-8?B?UUZnbGxzdW8zVHRoNzN0eDR3SlJxMEw2c08zRXcxYWlNWDJJdUVjdHY2OHQ0?=
 =?utf-8?B?Q3hGRU4wWTd2aWhEM2VvektBbkR0TFJWUmdGaW5IV1VXUUQ4dmNIV1dna3U2?=
 =?utf-8?B?SHJjbFdzeEl0UERJYkZjSEo1U3NDWUduMGVNR3ZEekRtaGN2bkRtWFdja0RI?=
 =?utf-8?B?cU1YWkZoZ1BKL2dydThXTmdIanlqZDJTRkMzbUFGaVdVZkcwaWpRMURleFcv?=
 =?utf-8?B?WTlkTCtWM1ZpZ2Zub0JIMGZmaTQ3dWovNjNudng2Wml1V09IWHkwQkV1NUhi?=
 =?utf-8?B?WWhreEpLWGxMS1NmRUxOQmJuTWt2cGlQT0ZpdHhhTzdFWEl3Nmw0ellQQmxQ?=
 =?utf-8?B?TXlBNkc3RmlYWnpnZ2hkM01DRE9DMTRoODVrRFlPaXFZS1h5V1FISWVnS29Y?=
 =?utf-8?B?OWJMSDNqMTUvSzNTb0ZPaUhWTUtsMkxMbCs2bGJpM0p1KytveWg2bm1WRXJM?=
 =?utf-8?B?SlF2VCs0OFNtUStlRXR3OTF1Mzh2ZmdVMEVkVTBCbXRNL2NJc1lieVY5VGpi?=
 =?utf-8?B?NjhyUzJuM255YUpQNG1zU3diNHhWNGhrWUg1RXZZUno0YTcyb3EwRVNVdGtw?=
 =?utf-8?B?VFZFdkx5cW41NFhHVGVVUVowTE9DRzI5bjhTVjJ4RUc4S0JiTFNiTDZEVGJY?=
 =?utf-8?B?WnpGNFJ6cVR6dkszLzBsMGV6QW9BOXd4MGtTUWVoc1hOK1VlYlA4QVA1ZG5D?=
 =?utf-8?B?eHVkMzdIc0tqdXZybUE1N3BXNWdyK3R0NjJHV2RRQUdWcXhNeHE3WXFKUUJ6?=
 =?utf-8?B?WVJqSEdseUpJckdQbzQ4MkZjdldzOHBxTVk1bU5jeWwyRzVwMjllOFVneSt3?=
 =?utf-8?B?aVhYN2dCNWVRaVlxa0R4a3hlV3E4a2pzSGVFTU05OEIyeUxPV0pCNHVtWFZJ?=
 =?utf-8?B?WHBZZ0taamRJc1hOQ1VIMk9sNHgvMHdpREg2RFZES0dTU0pidGxJcitid2NP?=
 =?utf-8?B?SzVrcHNXUjFsMk9pMXU1emFnSnVqaDJ5cjJXTTJrbkVjRFNvUVJ3Um9JT005?=
 =?utf-8?B?ZnBnRllQQVFVd0hsM0JMd3hOSXh6N3JEZGc1M3hNeXltYkhhYVJYNUg1aEFl?=
 =?utf-8?B?YkVtYUxtbkM5M2YzS3M4WXhKVUhxRlczRnNBTXFLOXlRaitxd3htdXhxQ3pR?=
 =?utf-8?B?T0FRY3RCdEtDQ1RDellzNXUvY1FEQnFST2FsaHk2cFQ4eE1yK05Wamt6eEpk?=
 =?utf-8?B?S3VmbjBmSjE4cVYyQWxWdjk3YTh5T0l6RDk5YVByckIwVUl1L3JHeTRaN3Zz?=
 =?utf-8?B?SncwOUxqcUVoL1pnZkRIZnQ2aWZYczJrbFFabW93KzhFcElUNFp2UnpYSmMx?=
 =?utf-8?B?SEN4aTFvY2I4blZGV1AvRDIvcVU1OHJDSVkxTjFINmx5MmdyWko1OXE2bzJm?=
 =?utf-8?B?WGlwcmRUc3luY1pGTnNETldqY0lXdkZvVGNMbUFOdTZhbzhobDdwc3JtYld0?=
 =?utf-8?B?SWY2RFB3dWdkcUNuSmk5L3hTMll2TUpMVVkzVitjdEk3b3hJeWYrYm5FRHF3?=
 =?utf-8?B?WnV3aXNoMjFvUlRucTlvZ25tTVd4UWRVRml6b25MOGlrZ0J6VmNZejVKM05m?=
 =?utf-8?B?NjY1Zld1Qk9kWWFSaktSdGNpL3RqSnJpUFljVHZBVDNSTkF0WDBUdzh0SEFV?=
 =?utf-8?Q?W1OpEaU356GRThxqDH1sDimAc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bec597d-fb01-4b2b-1d51-08dc5321ee01
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:33:57.2796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /w1xinqMeR6qJ/wV/ycfHGw8ZXZY76fcGjbTTSI0rkv1rxzdu6/lysqGjU2ulVhC+hoQ4hhkURc1YwTZo+b+yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10036

Fixed 8mp EP mode problem.

imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid     
confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to        
pci-imx.c to avoid confuse.                                                

Using callback to reduce switch case for core reset and refclk.            

Add imx95 iommux and its stream id information.                            

Base on linux-pci/controller/imx

To: Richard Zhu <hongxing.zhu@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: NXP Linux Team <linux-imx@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>

Changes in v3:
- Add an EP fixed patch
  PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
  PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
- Add 8qxp rc support
dt-bing yaml pass binding check
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx6q-pcie.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dtb

- Link to v2: https://lore.kernel.org/r/20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com

Changes in v2:
- remove file to 'pcie-imx.c'
- keep CONFIG unchange.
- Link to v1: https://lore.kernel.org/r/20240227-pci2_upstream-v1-0-b952f8333606@nxp.com

---
Frank Li (7):
      PCI: imx6: Rename imx6_* with imx_*
      PCI: imx6: Rename pci-imx6.c to pcie-imx.c
      MAINTAINERS: pci: imx: update imx6* to imx* since rename driver file
      PCI: imx: Simplify switch-case logic by involve set_ref_clk callback
      PCI: imx: Simplify switch-case logic by involve core_reset callback
      PCI: imx: Config look up table(LUT) to support MSI ITS and IOMMU for i.MX95
      PCI: imx: Consolidate redundant if-checks

Richard Zhu (4):
      PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
      PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
      dt-bindings: imx6q-pcie: Add i.MX8Q pcie compatible string
      PCI: imx6: Add i.MX8Q PCIe support

 .../bindings/pci/fsl,imx6q-pcie-common.yaml        |    5 +
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   18 +
 MAINTAINERS                                        |    4 +-
 drivers/pci/controller/dwc/Makefile                |    2 +-
 .../pci/controller/dwc/{pci-imx6.c => pcie-imx.c}  | 1173 ++++++++++++--------
 5 files changed, 727 insertions(+), 475 deletions(-)
---
base-commit: 2e45e73eebd43365cb585c49b3a671dcfae6b5b5
change-id: 20240227-pci2_upstream-0cdd19a15163

Best regards,
---
Frank Li <Frank.Li@nxp.com>



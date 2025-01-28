Return-Path: <linux-pci+bounces-20509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 196C3A213EF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 23:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0974A188480F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 22:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F921F55FC;
	Tue, 28 Jan 2025 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BUCbGoHU"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE6B1F55E3;
	Tue, 28 Jan 2025 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102133; cv=fail; b=nyQqediQPR/FG1eaD357OoXs+EEe1omMz9ur6fvZmi6inK19cs2J1swSlywZLqMI09SuNGIPqkjeHIkotbWPFx4oqeDVaZHesrCBTvQlyoTWPhr8vQoV4eenZzymw1B3eVYtMQyDiPu5vaX/Gyk5mZlQrhJlDm6o5C7YnxTuyHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102133; c=relaxed/simple;
	bh=02IqYa+1YrbDOfvh4y1Vhp/mynerMSdKgPWbl1z+Sjk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aoOCLpDOp1MqDaBWrfC6CmgdGmKy1g0KxajrntX/ud/YYyuRhQr0m8o9b+rEaZhEr12/AxzTaQbZSjvejWdwlOKqqD0n8HOSPNVUOkH24P7i/36Ry6bcNBNmxAztiCCYaABU3m9ibHGQNKtidz1F38FQR5TjAoJofTpXD6xF2o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BUCbGoHU; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/WgAqi/K5PS/k/ZbAIpkKrOWJyS+VJDBEvEonH+SyeaM5WGXbZfqUDMYSauq9EorfXkQ6a/sN1d/24GyZVrKLmB9cZZexuWi3JixHnEE+7V4d9vlS8ix4ueP2ArbMVsRziCROOb/4lTdbrXnwt0krfIGDEItPSV/wq8MKGBDI9X26AaqSWzR4f2fBWT5Bj44d5miiMycfFQdC19PLvC1F+/l3TokreXLxSyjuRqxjEDSueeWozRHTA0uv6B8L+pkUPstnnvUTeeS1MclpbsJEEACPQ3YEb2Xz2gbGqNoGrVDVEs3Z4GplWQaUtZSCQOyTiuS8/nhmzsTTepePjbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fSCFufz+vLfv0iVWwiZZozCv5CsPviKj77WcAlKDHg=;
 b=L5/Mf2Vv4UTVO4DiWOFuazrKYK+xV2tC97t6WaJFHuY6dtQa79X5vikdxQvDTcrPuLEoqo0RhQuLtu7V125LqX1VAi8ekmTXdeW2t6sMdmLa8qFchEqeZZd+af95/ZRf4mQ/8QSW4GudxmwnGBWjAVRu+hAZlXnB4VujaJLuJrlGP06IpfTpfeRAcc/2OdzhHCnUVL+l/UOBt4pHlubOfip9osDlxlNf4tqOO7Lf477TcgBgdqkUvu0AcSQSMVLABJ8eg2I+INghyix5ywb4Oz+73CTiZMzETW1gngaEFIRgsb99N6Un3uUOYVziUR7PkpbiAgkKzoff5xyzo8uj1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fSCFufz+vLfv0iVWwiZZozCv5CsPviKj77WcAlKDHg=;
 b=BUCbGoHUJP9YECc6vyeWAt0X17snr1fGiarcgJLyCTCjH+wcQTYf4EfDf8HXCHwEu55SAARnNsOMngjyYiaK0R5GZ1FhKt5idywyzUojxTTRTxao0kLvpkOOUXRecujDMFDjpBGe7iIs4sTfEoppidWpeE7uV7HCI5aFITzrKFnN9D5gYg+jysGeo0rRLs36Uf3b8yMcHXet7j6sJnur5lGmLzXhE8qCfvvXDBN05DvjsqYAdZAqlZLt0ldXEo0T67xnqbwQJp1knI+U1mNjl5gIni1AkjHtn7reH4i6Qz7GJdIzLrey4R2CL4WGZA4sV5XkvLqIDW/hQhlfTEfUcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8555.eurprd04.prod.outlook.com (2603:10a6:20b:436::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Tue, 28 Jan
 2025 22:08:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 22:08:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Jan 2025 17:07:38 -0500
Subject: [PATCH v9 5/7] PCI: dwc: ep: Add parent_bus_addr for outbound
 window
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250128-pci_fixup_addr-v9-5-3c4bb506f665@nxp.com>
References: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>
In-Reply-To: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>
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
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738102099; l=6514;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=02IqYa+1YrbDOfvh4y1Vhp/mynerMSdKgPWbl1z+Sjk=;
 b=truqNOct702hD9EFPO4up2i49kvg/juEc/NJjYHKaQdvpgPegJqxYQtaFMzEH3dSD9ak8SZo+
 3rKNXAawLBBAPbjyvH1NtsHgH5NV5xmif5kpH3mwljG9xPFlplBP2JN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8657a6-001d-42c4-a57d-08dd3fe8572c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2d4b1liSWlBbU9RQlkrbG9JRVlpQkhnZnRWNmtNSFhtOUpBOVpsSGxTSmtS?=
 =?utf-8?B?RTJoR0xGdTIrdGxaWFZXajRWQytBeGdQcWxpUXorb0huOGhVT0R3UkVLVkw3?=
 =?utf-8?B?bXROTDFWdjg1THhYcXlOc3VESnVvRW1sZERJNkhvOTEvREJad3UrZ3M2TnRK?=
 =?utf-8?B?NWdFOGl3bDdzOUY2dXg5MkNWOGdrQkpCaW9FNDA4cDgzRlI1Nnh0Q0k1TExE?=
 =?utf-8?B?L0FPaGZCb3doVVFwSXBVZkhBSXB0dkFhVjdEb1M1RmZTWFdLejNOekpmWCtI?=
 =?utf-8?B?TSszc2R4SGZmdkg1QjJjL0J1Vk1IcUxQT3ZBd21zZkh2WTU1ZEMzdE1jTWk2?=
 =?utf-8?B?MEZGMkZyZXUwMEVoaUxLbkhhaVF3TVRNdkx5U3BvU2g5eFJoZGV4TEtlbTZK?=
 =?utf-8?B?MHQ1bTB3NFFUUU5aSkMvdDJtZytqaFVWMWpEbU1MTTVJUTlPOUE0RUpVYlJS?=
 =?utf-8?B?ZEhTK0dtMityZXl5ZjJIUmVBZjBhekh1dnRFYWdqMWJrRHlLTEJpVXlOamxv?=
 =?utf-8?B?K0MwRUh0ZFprTnZqZDU0SDJxNW5QRU95VTRUb1hYd1YwbjQ0UlBaUXhWWTF0?=
 =?utf-8?B?R1BkcndibVV3SmRuRVlBVUJKdmNlMlVES2t3Y3VXMFdNcHNrMWo1M0QzNjdF?=
 =?utf-8?B?THlJN1BrVEFqdXBxdEw5L3FDVTNzYU1SUzBRd21YY2JOVWJEZHZqS25DUm9H?=
 =?utf-8?B?bE1oczJJWTZnVHlFMGRKcnlCMkh5VnZlMnN5NGFkZ0xnd3IrNk9tb2RybHBq?=
 =?utf-8?B?N2ZJa2hFbk91ckNYNjhFeFlnZ056Ty9DTW1oYk0zVG0zanlGclV5Y29lTkZX?=
 =?utf-8?B?WDdOaEtHOWo5RXhLKzcxcmp2YjlpVWFUbVVWbGRqZE1OUGZPTmlqMnRYVTQx?=
 =?utf-8?B?M2tXSFRaRTQ5M1FxNnF0Q0ZKYWZFMzJRSjhoVG9KOWw4SlYzZjh6MjNYbm50?=
 =?utf-8?B?TEl4QXdUUTJ5c2ZOQ2FuZlBqRmF4TzlaY0lWemRvTzU5V2ptbU5yYjNnR04x?=
 =?utf-8?B?U3IxdWJlWGxtL2g2Mks3K0ljR3UvbXo3c0NGajJKRU8ycytmKzZCdGJPOUYz?=
 =?utf-8?B?V1d1QWxON2kwVXREY2ZwV0Zmbi9QN3JiWFJFTEVKdjNzRENSS2oyckcrbmJ1?=
 =?utf-8?B?Y1ludWlidm4zN0RmNks5Y3BsVGxVRE41RGV5Z1d0MjhCbUF6Ni84SUprK21U?=
 =?utf-8?B?d0RjWHJUSXM4TGVHZHRnalVFRFRjdk1ISU1mSjNkTW9rWWkzaC94Z2c3ZHFR?=
 =?utf-8?B?ZWVqUCtaTEJUcTVxZ3U5d1Fpc2pDVENTSHAwWlFyRDlSNkFsRUczVlVVaW5O?=
 =?utf-8?B?c0xzb2YzbUhNREtKT1E1QjFGVk9tK0puekpjM2kwYzdlbDNibXJwSWhNblpR?=
 =?utf-8?B?VXZnL0hiYTVZYVR4UXhMOU9YTTYrOG9hb2ZJY2Z5MEViLzJucWozV284RzBY?=
 =?utf-8?B?dFVzakVWTzJNNmpTZDcwL05HKzR3NmpDSDM0ZDRRbkowTWtkazR2N0djSk5D?=
 =?utf-8?B?NjVtakJ3eW9sZi9sTmg2cG90d1RDRU55T1dyTFlUN0hSWHJMMnZKLzQ3bkJr?=
 =?utf-8?B?c0lKdktBMTJoVWhsdDVHcWFoUzQzdVJyanFIZWZ0K2RPdGFsa253b1J4VnVy?=
 =?utf-8?B?cXZTdzVUSTZBUDhLdWlVS2lEblRNcXV1elNWZUg4Y0lEcmdNcWNCM2wrR3JU?=
 =?utf-8?B?SG9UYjZyeXlZWkFidjBHbFZQMGk0cXdkcnpiWU1jZUt4cFdEZyt3WkdLTysz?=
 =?utf-8?B?RzdTM2VDaEo1TGFaWGJyZGtHQjM0cFc0cWMwQzVRTUJzWFUwS052cGtMWHp2?=
 =?utf-8?B?WUh6R3FtNFdlK3Zsa2lMTWtjRXFBUm9lWTJDSVJXdGt1ZnZZNFZRbjRQbE1K?=
 =?utf-8?B?bFE4UjJCQjJGRnZadjN2RTR0OWNMYUs3MWUva0g0cFlhazlwYXl2dFRPVHgw?=
 =?utf-8?B?dk13dG9Qc0FqcWpVV1ZIbHREYURXTmFFKzVibHpjR3AwQ3g4ay9QQzFQQjBy?=
 =?utf-8?B?N1hvNjlyUTBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0NSa2NUR2dLa2orR09mQktSL08wUUlpVllUSktVaHlMTStKTzRTRDJ6eTdx?=
 =?utf-8?B?VFRvWmJ3TCttaC9YNEIybHYvekFvYUxiZ2dlV2gvNGsyYytBQWY4YmtoRDBZ?=
 =?utf-8?B?R0ZUdnBxU1I3WUtDbzY5djhIQzRmRkVNSUJlZHhiTGFBU2M4S2VzSEF2T0NM?=
 =?utf-8?B?Y0RGQVdOMWJSS0krUTZoL2lSTTk3aWJQY3RwUFM5M2M2amYyd2lEdHVtQTR2?=
 =?utf-8?B?aWZJSDJ4QjlzUXpKUW1hSFhUVXlsbVdCN0hBMU9FNnNTS0d6SlJjU2k0eThU?=
 =?utf-8?B?UlI2SUFxS2Vlb0Q3L0Y5RU1tT0szb3dIWmVtcU01K2tUVk15dmVPYWc5UWVY?=
 =?utf-8?B?bjZENEJpa05HakhuWmpNbU1KMmpLSVdVT0d1UndENlIrMVEvVnhLUEdlQW1r?=
 =?utf-8?B?RlZwcW5IUHdjbzVqZVpKUjViVTF5UlI3RHFtQ1B4MW44dXk2SVFYai9nSllp?=
 =?utf-8?B?aEkwTkNRNDkrOFMwZjAxa1Y0SWxIcWxaWThMU25tSUNmaXdzamlzMitHV1dT?=
 =?utf-8?B?a1Z5N0lRejdyTHZYcjROczhaRGs4TG56TWV5WnhQeFZkZWxXUlhaY2M3N1V2?=
 =?utf-8?B?ZXJCV2RNTHcwR3VCQ1FoQy9Gb0V5cDZ4WFc0S2kyblhoVFJoQjRrQ0pSKzVa?=
 =?utf-8?B?cmxXUHM5bDRyd2ZzMkMwV2pFbzZxeTZNVzQxK05iU25XcFhDWVUyZXc4cURz?=
 =?utf-8?B?MkltbERkUHZrSVdGWW1IYnE1Nm1jbUpaMWljSFk3NU9BMy9ZOXk4Z25uYnNt?=
 =?utf-8?B?aXlFa0xGRzZocHlHNEo0V2JVTU55N0haN1FUcWpqZDBGZVlUSTdxUGxUdURj?=
 =?utf-8?B?YzV1cS9zc1hUOVp5TUFoMGVrYisxZ25GZzQyV2Y3ZGtmYXVKbWk2YUovTEVr?=
 =?utf-8?B?bzRSQlFxYytlZWY3Y1U0RmROMDlsaFhIcGxYMG9jRjBRQ0J2VjFyYUN4WjdZ?=
 =?utf-8?B?anF2Vno2a2UybVIvQ0Y3M0dhV1pJUFVCNktqZE1sRktMVE9DdFhSaWNUTFJ6?=
 =?utf-8?B?S0NSN3gvcUJ1UWJ5OGlGWFdxMWppMDlVaGgxWEorQ2g5TVRxWWthbmNFejJK?=
 =?utf-8?B?M0dSQ0Z2QzFIYnZqWGMwL1crZHdITTQ5UVBJT0N5Qm1IZE5VbmdKTGp3anV3?=
 =?utf-8?B?dnZLeWFlM01TUVRJc0w1RkNuRU1BZkgwd2pGMVFxdWg3djJNbForcndQbDNP?=
 =?utf-8?B?OFNKa1l4N3AyZHVkV29Ec2I5K0NkdHB0OXV0clNzRDFxazNGTDNHc0luUWZ4?=
 =?utf-8?B?UFVJNUxTcWhQcnJyMTdUcVJJN1FJTjlVWTVyNXlBM1pnMzNKWnlsZEw0djBs?=
 =?utf-8?B?c3V4R0NGYWdyQWpJNGtpbzlEUmlOSHh2L0V0VGZpcDA2M0tZNC8wRUNOUGFT?=
 =?utf-8?B?NnVRWldvRnpmems0N3pJZmFEVkQzc2pEN2drbkpQK1NXM281UFFEVDBvYWht?=
 =?utf-8?B?b3oraU1MVE1aR0FZb05YT1lTeVRlbm5iYUM5c3VTbDMvTElaWFNOaFoxUGJq?=
 =?utf-8?B?MkpQdTZLeWEvOENkZ2R1aTdSZkJiV3hubC9Ja0UrcHRmdG9QYVZjSW5qVVFa?=
 =?utf-8?B?ejZvR1c3QnpQWGN0LzVMa2lzV2Y2SEZ2WnlkZ2VXM1JwUG1PQXJKZUg3VWQ2?=
 =?utf-8?B?NVlSd3dKODJSa2N6cXJEZGpNK2FESjlURXp6YnJKdWt2NG5tN08rTFZ5cnVI?=
 =?utf-8?B?SHdHUjNXTWNsbE9kMUZvWWhuRHNGVldlN1pGOWVJazJ5Q2E5OGVaT09UZHNP?=
 =?utf-8?B?OCtyMUhjeXRvYVNsOHZsaHIvb0YxbmlMZ2c5UVFZdHpzWlBxeG93TTUrUDlt?=
 =?utf-8?B?YXMyM1J2UjZxamZvS2drRGNBQ3kyTmdvb3B3YzY0ZE9HZmFWcjJxTmZrd0p2?=
 =?utf-8?B?WHhXQlROR1JsYUczZnc3THlGSVlveFIvUGIzQWZUYXhsMmdicjdzZHEvY1E4?=
 =?utf-8?B?aXA1ZE5WdEZpTFlIdVlOU2FSNFhQRkVyblFiTnoxbHJGb0hoUnhBSEZBc1pj?=
 =?utf-8?B?VG9Xam8xRVlhL05RN3M4VXo1cWsveUFUUDNOeGxZR1hJdjRLdkt6VjRReFZi?=
 =?utf-8?B?QkJ4SXJBa1V1dGM0T3VZTUVFMFFmQXBHUGR5VWc0STkvSXlLVHljMk5IRmRj?=
 =?utf-8?Q?XegVnuWM3uRaw4HAXix7NWK38?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8657a6-001d-42c4-a57d-08dd3fe8572c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 22:08:48.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNSXr/qY5uWadYiuU5CQGsNZP4MF/IoV8+6uEFTReTl5XOfZtrqFUsmwFg5yqOYrGGJxUp5VYXJAs6XPqjGgfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8555

                   Endpoint
  ┌───────────────────────────────────────────────┐
  │                             pcie-ep@5f010000  │
  │                             ┌────────────────┐│
  │                             │   Endpoint     ││
  │                             │   PCIe         ││
  │                             │   Controller   ││
  │           bus@5f000000      │                ││
  │           ┌──────────┐      │                ││
  │           │          │ Outbound Transfer     ││
  │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
  ││     │    │  Fabric  │Bus   │                ││PCI Addr
  ││ CPU ├───►│          │Addr  │                ││0xA000_0000
  ││     │CPU │          │0x8000_0000            ││
  │└─────┘Addr└──────────┘      │                ││
  │       0x7000_0000           └────────────────┘│
  └───────────────────────────────────────────────┘

Use 'ranges' property in DT to configure the iATU outbound window address.
The bus fabric generally passes the same address to the PCIe EP controller,
but some bus fabrics map the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000, Bus
fabric map it to 0x8000_0000. ATU should use bus address 0x8000_0000 as
input address and map to PCI address 0xA000_0000 (dynamic alloc and assign
from pci device driver in host side).

Previously, 'cpu_addr_fixup()' was used to handle address conversion. Now,
the device tree provides this information, preferring a common method.

bus@5f000000 {
	compatible = "simple-bus";
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

	pcie-ep@5f010000 {
		reg = <0x80000000 0x10000000>;
		reg-names ="addr_space";
		...
	};
	...
};

'ranges' in bus@5f000000 descript how address map from CPU address to bus
address.

Use `of_property_read_reg()` to obtain the bus address and set it to the
ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().

Use 'use_parent_dt_ranges' to indicate device tree reflect correctly bus
address translation in case break compatibility.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v8 to v9
- change bus_addr_base to parent_bus_addr
- fix dw_pcie_find_index() address compare, which cause atu allocate
failure when run many time test.

Change from v7 to v8
- Add Mani's reviewedby tag
- s/convert/map in commit message
- update comments for of_property_read_reg()
- use 'use_parent_dt_ranges'

Change from v6 to v7
- none

Change from v5 to v6
- update diagram
- Add comments for of_property_read_reg()
- Remove unrelated 0x5f00_0000 in commit message

Change from v3 to v4
- change parent_bus_addr to u64 to fix 32bit build error
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230328.BTHareG1-lkp@intel.com/

Change from v2 to v3
- Add using_dtbus_info to control if use device tree bus ranges
information.
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 21 +++++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h    |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 80ac2f9e88eb5..d0d6c4e8df80c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -9,6 +9,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include "pcie-designware.h"
@@ -279,11 +280,12 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 			      u32 *atu_index)
 {
+	phys_addr_t parent_bus_addr = addr - ep->phys_base + ep->parent_bus_addr;
 	u32 index;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	for (index = 0; index < pci->num_ob_windows; index++) {
-		if (ep->outbound_addr[index] != addr)
+		if (ep->outbound_addr[index] != parent_bus_addr)
 			continue;
 		*atu_index = index;
 		return 0;
@@ -333,7 +335,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	atu.func_no = func_no;
 	atu.type = PCIE_ATU_TYPE_MEM;
-	atu.parent_bus_addr = addr;
+	atu.parent_bus_addr = addr - ep->phys_base + ep->parent_bus_addr;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
 	ret = dw_pcie_ep_outbound_atu(ep, &atu);
@@ -901,6 +903,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
+	int index;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -913,6 +916,20 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -EINVAL;
 
 	ep->phys_base = res->start;
+	ep->parent_bus_addr = ep->phys_base;
+
+	if (pci->use_parent_dt_ranges) {
+		index = of_property_match_string(np, "reg-names", "addr_space");
+		if (index < 0)
+			return -EINVAL;
+
+		/*
+		 * Get the untranslated bus address from devicetree to use it
+		 * as the iATU CPU address in dw_pcie_ep_map_addr().
+		 */
+		of_property_read_reg(np, index, &ep->parent_bus_addr, NULL);
+	}
+
 	ep->addr_size = resource_size(res);
 
 	if (ep->ops->pre_init)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 483911ab9e629..3d9bf2b43bcf2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -413,6 +413,7 @@ struct dw_pcie_ep {
 	struct list_head	func_list;
 	const struct dw_pcie_ep_ops *ops;
 	phys_addr_t		phys_base;
+	u64			parent_bus_addr;
 	size_t			addr_size;
 	size_t			page_size;
 	u8			bar_to_atu[PCI_STD_NUM_BARS];

-- 
2.34.1



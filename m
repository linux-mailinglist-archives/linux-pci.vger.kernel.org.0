Return-Path: <linux-pci+bounces-13464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF3E984D1E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 23:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0831F241A1
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 21:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB7C1494D9;
	Tue, 24 Sep 2024 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lcs6s+n7"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013032.outbound.protection.outlook.com [52.101.67.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEAC1ABED1;
	Tue, 24 Sep 2024 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214898; cv=fail; b=KhPnhoLwqcvbk9r/wx2Pfk1nAZjlWmIAfhfdq8RH7JUmzE4fIyUNyw2PdJFYXfseXlrPpBr8GaGpuNoIViY+qb110XJIY5Pw8TZROlhgIVfUEd9F4u/BT6Y7hc8NvTWI5dMuT8EHy5VDHfe8D5aUJtQrk3mQNw0bAlar4VoDfT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214898; c=relaxed/simple;
	bh=WtubovOE5VC0USN3mA9HgJEJll0OGg/alCRBKftPknw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BBXIyii6g8NyrLDZBlVb2u7jTAK8gU6HDPOaggzvaBubpWVgf0HHSjdve4732G2Uv0yPKDz79kOHCN47jgq4DSmMbgZ8KGLB8S4x3amEmBToCkIDtRfrSWYm7nlmWRlVOeYbyDxHvlMO0PntgawidsDGkHQl1/71eOMXVmqqBFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lcs6s+n7; arc=fail smtp.client-ip=52.101.67.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAUL5LrMa4hzomudfHPahg2RgLgZUxLkNzkdA9YEjnkePpiHRancwlPVaFpnmtHFm/7b6/xC6qrhLP07+5dJsbpV5TCf+MC1xRkl2snT/T4SR6a39cckJmRnYXVsbMRa/bEWWkfws69Ox3cgHGmLWG/mP9VU2OVa0eKWmrJhv/GkocGtLdevtxpVXEDiub5Ict8hExLQZZXcQRxZGsw7e0Y9ZkM+OFJ4tSHicp++b3VywiV22E4qmmMcFpydE/eZeL4RGemATwYHktin3cDMNtmzkfYtX+m1WltuQ73023jHUYl4XC5g8Lw+kqkbN47RWIs6oiQ5dGhw1BauPXXtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0xL+G0rT5ezWJiBDM9Zvqas10zfxi7UAPdA8m0uBAw=;
 b=hJytZS0NbqmRRpAX3+2vwCqUESXbHH9IHxazwrByjHJEZX9hl56RzELl3i7DZJn/y4tzazjgI7cT6NbzS2CjJFF702j8QpeVzeKe8v5MwmtEMwf1ZmOi16b7o9GNYS+oKOI1r1vXX/zRgBDdr0SR1wz6klKHxAQwTGRGIAOAZEs58c9eaeWOkQoQ26yvdALBIpHusb/uYZO7r496asnv3TIQanTJQYcBxwHkqMps2WgtrY3w+7QUU9Sa+jSRtShIEwUQjY0FZbh0fu+msTtsMCoIyedkB8cKM/Fr9qK+fBiofM+G+pYNPQ6aHEGeXhpSpe3WZFfdQ+8RGoz+6WTmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0xL+G0rT5ezWJiBDM9Zvqas10zfxi7UAPdA8m0uBAw=;
 b=Lcs6s+n7VlyVkwdbgo8IYh5ANlg5l4tkdKuURGPArns7e9fQxz1oKiv6w38Idqq10nSPIQHdWlhqwkbJ6vNY/BkJ8qWNTArWaB3usPZPV6OO38l2YYctCTPK5X+TKOAlQL+wp71sULodT536VXninZ0QEVQhVgdKNnC3S+4OrMzkWg7v1Df5pctx/mju0sGqMH8yg40VrGp/dsN3FiKv/fL2iMQ9JTvZTtMidlDzHxvf71zxAdV6V511dJQCjamhHf7J3/EPzWmJ2PkEvOlS+CQV4sxVlL2Wg6klwtw4plKW/qYG+VIHwDXJtLmpxEqxbNYY0Etng+rxYbhjZiii6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7953.eurprd04.prod.outlook.com (2603:10a6:20b:246::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 21:54:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 21:54:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 24 Sep 2024 17:54:21 -0400
Subject: [PATCH 3/3] PCI: imx6: Remove cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-pci_fixup_addr-v1-3-57d14a91ec4f@nxp.com>
References: <20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com>
In-Reply-To: <20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727214875; l=2111;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WtubovOE5VC0USN3mA9HgJEJll0OGg/alCRBKftPknw=;
 b=w88E2ZJalyQxG5SyBTHH8T8yrLFR0ECBixQoDGMPXB7lRVy+ZZWpjl1jCvOtTjIb0ImFIDIQU
 SUD4LJd3LTmDTcgw9MqRgJoSxJhZyeeOEVumzrwqv/wxBPCUy4U1/+B
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: cbac7874-735a-47de-483b-08dcdce3856f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDFoVHZENW94TEZ1MkliSmlZSXluV2RqWXNFL1JRQXg4KytxYXRrd1RUSDFm?=
 =?utf-8?B?Q282TlpCd01BTFJwK056SWViL0NYM2tDbWNpY1RtZEJRYUdCSUE5d2hhcDNF?=
 =?utf-8?B?TkIyai8wVUY2bkEzM0UwOHhsUlRONHc3TjNPZlU4Ymxobjd3WUhxa2RrM3pB?=
 =?utf-8?B?Q291bVdDN1hvTkdKU003QlpIZ0U1ZDdOU21CeGs3cytWUEhYdVpuM3JxRUhP?=
 =?utf-8?B?RWdyK281aW1EdEpQYUNWUkRZTW0zU2c0ZnZlMy9LQ2laZ3FNZ01XYmRzQjVh?=
 =?utf-8?B?SU1nR2ttYjVxYjNYa3NGbncxYlhXLzA0d2dTWTBkTVRwYjkyRTdXbk8vU3VX?=
 =?utf-8?B?V29IbmZpOVNHRkN5aTlpT3pEeVRNMCtrQUdYa3N0M1A5d0YzaUorbHF0Y0RK?=
 =?utf-8?B?N2x0dVAvMzNEcndndXoxc2RhVFJNNDBsbyt3d1RLanU1MWh2M29TOVBoSzlD?=
 =?utf-8?B?Q2l6UW1LbDE4eE5BdWNxdklZQzI3ajdZS3NHQ1NzdjdMY1NEUUNWc1V1Q0ND?=
 =?utf-8?B?T1o4aHNYT3NZcEF1T0FiOFcrTmRad0E4NHhmNDRYNTVwUTZJTEJrZUE4R3VI?=
 =?utf-8?B?ZDA1cmlZRC9VVXEwbzB2MFczbTA1bWR3KzVKcHI3YmwrUlR2OWI3SFFuSHZq?=
 =?utf-8?B?S3pvSDVCQVdRQUJ3RlpvbVNqSnBRKy9pUlcxcFg2djBwMXJvS2FOVE1jbFJX?=
 =?utf-8?B?RVFJb094cjJZRzVCYUJZYmRTVUJ6K3FwaGE4Q3B3bUJjK1dtNERCdHlxeitG?=
 =?utf-8?B?NTdTZ01vR3VoV3NCK0Z1UWZreW83L1JIVFN1TzJTeXdNV1dSWGk3emNJMHRU?=
 =?utf-8?B?alFRSXpDSVlZNmwvRHV5Z3VaWVE5SUM4OTJTUmgzYXBpY1VzR2F6L0RzMWc0?=
 =?utf-8?B?NVhwSmcrWFlmRmVFVmVZNm0vc3hjMTRrcTlpRCszTXJGR3BZeHUwV0hONi92?=
 =?utf-8?B?QXRoNVJDSEhSbUhxOGRvZUo0Z1l0eHM1NzQ0Q1laYnBTa3J6ZUZCaDY3NFhu?=
 =?utf-8?B?YkJPdDlQN2hrL21IeEZEWkJxdjdZaVFoKzZnS2R0RzNOUVZzOW1Yc2MrQ3Bj?=
 =?utf-8?B?b3RBZlp4OWROUHREWTljNm5ZODY4WmQrc0puNVlWeFdhcmZJc0tIK1B5S0Ev?=
 =?utf-8?B?cldFZ2U5RHVDMUpveWIySmMzamhhYkRQMitxcFJOT1c1SzdmSmFBdVRkK2xM?=
 =?utf-8?B?aFlXV1VEVTRTOFdzb0g5c1l0eXFWN3AveXcwTmxkRVEzVktUVlJQZ3ptWTdM?=
 =?utf-8?B?ckJDWTBmMnl3NzlmNmlkYVBzNW0vWlNOS0JLSUVtSkF0Q1o4SldzSVE1OU50?=
 =?utf-8?B?d2JKSWhib1BvczYwNnVsdHQvZnc0K0FjbDB3NTVHZk9Yc2VzTDY4eTBCcmdH?=
 =?utf-8?B?ZEViRGZkMWJmNjIwclRQTDN1VHM5M25CUFdubThaeUZyWUJNMDlkVWFHSHpV?=
 =?utf-8?B?eTlPSk90bUp4Z3FqVGJ2QXNSTm1WandUNnhsVVpvNlhHQ3NSS2gzU2cyQnJ4?=
 =?utf-8?B?QThVVDdxWStUMDVRRmRFM1NnYW5zdjRRd0ZWSDRGTjhQWTFBUWt5NVZwdHdT?=
 =?utf-8?B?QmY4cVdGRnFJRktiajk0eDF1SElwVld4aGwxbGhQY25hWWQyU2lTaEE2ZFUz?=
 =?utf-8?B?bXk0ZEFaS1NQb0tmOFRDdDFudU5zeG52dWVhbEhkc29VMEtlb0pIT29FRFpj?=
 =?utf-8?B?UlFqZlVCTlQvLzRzeGpWYXQyWmdqYTdiVCt1ZUdKelYwcGxHQlZySHV1eDFK?=
 =?utf-8?B?Qy8ySXkxM3JhNjMySUhQT3ZQMmpENi9CelAwbzlWUkI3am9DamVDdTdQV09L?=
 =?utf-8?B?LzI3SHdoZmJIbDloUE5TNDljVFU3YUxQUzhIQ0hGaVZjL2R6Sm1rdXJLSUVn?=
 =?utf-8?B?K1NBWmI4akJUUnJlUCtzQlU0SThMMVdwQU1kZWFTdWF1ZGUrNjFtSUFWcTNX?=
 =?utf-8?Q?uzaCOao7kv4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzFNclFtNTJOUkdXTEZuRUx0bFM1TnNWcmczc000WGNoOUtuK2F3ZVU1MjVZ?=
 =?utf-8?B?M0JPSzhhTWVCZDY4WTJFS1dwYjZSNFlmdzkwMzR1ZVZFWVVmbzA2K3hsVGRt?=
 =?utf-8?B?d2Q0OWp1TTZldGRTdmQ0MldnQ2pPa3pzZnVzQkMxaWw5dkFNUWRKY3NJY3lF?=
 =?utf-8?B?aGcrQjhqdStCQXNqRDIxZDhTNlBwQTZqblM4MVRwOUQ1QjVla1M2QW8xYllX?=
 =?utf-8?B?eEVrbVFLWWF2TGpwRGNINGoyb1BJYjBaY0VPN2hFUHRqY1ZPQmQ3UXIyQWxu?=
 =?utf-8?B?eDFPMkRBcmxXT0Y3ZVN4VmxWKzU1RHpWdlg2WHNUYW9VSnErZ2ZaSHhvS1pZ?=
 =?utf-8?B?QkVEeDM2M21yOGpUc3NNUGo4dDVNdjc3VG02OEJWdUhueE15Nkh5MXpBTGk3?=
 =?utf-8?B?VFRURysrT1Q1c2lPQThlZWNhR05Bc2t2dy9sNjNqWC9rYkpienhIbEhGb2FW?=
 =?utf-8?B?a3ZERXEzeVFxZm9sZUQvZERkejBzWXlnaFZYcGNEQlBYeVdTWDZDckhzQVd4?=
 =?utf-8?B?dHgzLzhRbnpJdmh6b3kwaUdRZVpOY2haQ0dlSnVFS2xRYlRkT1pxZVlqdDZI?=
 =?utf-8?B?NHVDT1NhUGZZdm16cW5rVXJhc2RFdytUZllzUFRDcVpYWXNRV1NwemtPU2sy?=
 =?utf-8?B?bzVzMVpDWHg2aE85Z2VQRjg1L1cxK3dPcndvY0JhQjM2TEh5bENSU1hwaGNq?=
 =?utf-8?B?QTlBRWE1V04yaDlDMEVxUitZZXdTWDdpNms0NVpvam9PVitaMFhFZmdVbnlQ?=
 =?utf-8?B?QU5oRGNEbjYrRTJxZjIzTUVSbVN3VDVuTzdMeWdvcE5Ma3dxV25xRitTTXZL?=
 =?utf-8?B?ZUVNdDZQVGNNNXFBRit5WUJmRGhWNlQwZzBJc0lqbnB1MVlXUWxiQU1zTWxU?=
 =?utf-8?B?SWJSY2FlaE1CWVM5S0Z4akhTNzcxVUUvODZLeWt5TjVSUmVHTXBHWTd5Q3lj?=
 =?utf-8?B?clBneHNIYzRrQkFYN2RtNERURGdsUTNBSlBTMWl3UlRUb2lsUUM0NW5WUE95?=
 =?utf-8?B?R1JQM0czRUF0VjFZcituWXh4cG1la25hc0tuSXQrY241dlc2bzloNlRxaWEx?=
 =?utf-8?B?dVNuVVdud05qbFhMdTcyL0JOdzFkQ1Z5YzhvNm0xeTRIYjRMQjdMbHZ1TENM?=
 =?utf-8?B?SjdzMlRmTTdRclB1bVRUNi9KZC9xRTN3VGtPZEd0Zlpvb2szUW8rSThHYXR6?=
 =?utf-8?B?WEJHUVNOQmtMWUVNYlZ3Y1JqbERvSFI4WjF5cHNmaTQ1c2dUZkpIbHJSUW1n?=
 =?utf-8?B?cFpoc3J4bnovNDV5bGRrd1ZUNXJaMGN5ZG1TakZvTXEzSjFLMk1ENFliUUtZ?=
 =?utf-8?B?N2VlREpWbFNwbWtOTlR5clJ2RHBpZzdmSzJRU2I3dXA3eGF1WEtrVTlLOTYz?=
 =?utf-8?B?Yk5OVGFlL1ozc0xDUWdicHJORS82QzllNE13QUxaczF5a2k0UlAwQzBVd1Zv?=
 =?utf-8?B?VVVpaXhoSnhPMm1GamJGMTdmbkVmOHR3RHRYVGxOUWF6a3gwdzcyQ3hMQmRD?=
 =?utf-8?B?TEo5TXRaZVF2dWFNMWVKNVExYnpsYU5CZWg5eG9vWmpGcE1pZWRrWG1FTEkr?=
 =?utf-8?B?b2ZIYUtxYlVqVkFvSkVwcjJHdGpXQWgvTmlueEZrSWk4RXBxWlpPM3VjdjNy?=
 =?utf-8?B?ZTBOaXM1U0tkMzhYZ3RiSU8wajN2NC9lakJ0OTFaelVkcVkrQUMyei9IUXBq?=
 =?utf-8?B?allhV0V5VFZIR25vKzZXK09pZjNhMEtsUzdLQ0krZUtXMW5YcmNtWTFIOVM1?=
 =?utf-8?B?a2oyVUxodVdrNUtQS2ljdmpSOU1raFlodDkzdklLL3haRWJIRjIzQk9TMEc1?=
 =?utf-8?B?WE9mVFNoeFN2K2tJL1JxeGlwUjRqL1dEUjNaRHNZeGV6ZlBGMitFVm4rcVB6?=
 =?utf-8?B?TjlaNzlIeFRnZkVBR1ArRHNUS0xYUGVmK2RTTFpEZXMzV3JrTUwvZTQ3MlNp?=
 =?utf-8?B?cjUrRTRnVzNiOHRwdEswelJlTFZRaEtJcDdDZ0wxNjdwcnk2M1g3SExHbUZG?=
 =?utf-8?B?U2QyckRyV1ZSaEljb3pKbzBEY3NhUVJoZzdVc1k2MDVNY1loYlhEaThjd3hV?=
 =?utf-8?B?S3dwWGM5azVIS21zYVBMUmlrVlBOenRZQkw0K1V2MnRQcFlCT05ZNlZZbW1H?=
 =?utf-8?Q?sw0k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbac7874-735a-47de-483b-08dcdce3856f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 21:54:53.5103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OynFQzY98+nuIvM7W6eUxVTH451xHgpo1EjfzGaduWJy2AkmuMZhJLIJtikKc6eTtiDUVL+Lc0z9bzgN2kvcuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7953

Remove cpu_addr_fixup() because dwc common driver already handle address
translate.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1e58c24137e7f..76174b3a0388c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -82,7 +82,6 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
-#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1015,22 +1014,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
-static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
-{
-	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
-	struct dw_pcie_rp *pp = &pcie->pp;
-	struct resource_entry *entry;
-
-	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
-		return cpu_addr;
-
-	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
-	if (!entry)
-		return cpu_addr;
-
-	return cpu_addr - entry->offset;
-}
-
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
@@ -1039,7 +1022,6 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
-	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1598,8 +1580,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	},
 	[IMX8Q] = {
 		.variant = IMX8Q,
-		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
-			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
 		.clk_names = imx8q_clks,
 		.clks_cnt = ARRAY_SIZE(imx8q_clks),
 	},

-- 
2.34.1



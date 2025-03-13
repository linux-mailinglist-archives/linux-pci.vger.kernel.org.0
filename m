Return-Path: <linux-pci+bounces-23661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B14A5FA46
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54386880549
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1CF26A1D4;
	Thu, 13 Mar 2025 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gfTDTDoa"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9735826A1B2;
	Thu, 13 Mar 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880373; cv=fail; b=e9s8a4LU0MN41I7kM+TuIo+Wt7s3xcK0A6k/BOzU3whKJY8B5CPAsGYOlzZXkeLi7wRse2PoQL5iPW9JuwLyKEedT6pONxrUuj6fRiqnNb1Dfokw9GDrURsOt7A/g69fFPbSwbnj1Z5Hjo/LFj3pJn0pf+A2foNzdA0WcQS3PBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880373; c=relaxed/simple;
	bh=WktRzlW4auLU1QYWmCfEe7UHuQCDd9plPz0/brqDyKk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jRIUGGTVix31UHUXXzE8PuCLTS1eIpxdc7itwQDfqQ7HJ9trfay0u7cH3wFK1kkA4jgKZTgDuZSAYgBRh175vxiV3cdpKNOKSn/0E1HfOB3z3TxncjRDVW565uMezpgfcVABHhhx+UcESWbLoed/ijAcD4/pHEB3pe/YEBF9bJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gfTDTDoa; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFwVG/45tZKyQse9xgmLGXz01UPdYTPi2VDTwU19dnAXuInCX4bPcqhxu7LoHB9QnAMiGWjoDzrfVGhDgX4VRqDAtAtbtcnY+OmNWTGlajaW2cDGPo1eoNzA3tBDfJ9PR0og/bU04l4r+znx78+sCVqZhXO6tDcM3KbHvXBsIq6sra05K/9KIvnKuZBpTX0U3Q2GA3r0XcCHOdlQ+rw0nqivkLtGkCtINalmN8rzYFxw4ksnWpaSt1vpBfZAljME9aA0+4jeVwYwJtGmCssKK9nhEX/KmrPOdc4WQ66GhjFKocIh9GAkYa5tmSp/GiOu8N8H7rJhN6e/ZvF+vKmyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m262o4h6ra51Rb6Iz/mlzUtPdhX6n9We7m777bDr2MA=;
 b=XeSlPuyfl7ZVDSqBaepWkNA7Ha349QKaXqWOlXEZO4+gdzwj/blyU1+lPUj/cZtvHKXTLvQ6XA+cV5QdZaLlvnOyHDxLkl2t5QQWkRyPyZE7XkG9Q7279HQmi5WeDPD3pNrvzBXSSjs1Oa4tXHnUT6zLWUxClEIFTpMboOrF8jEfAlvCRYKRtJ5tuS9N3bBJZ6cpuF+k+S+W7D+1Lxa+HoJm16mV5GKa/3qbzoBod5bwEvCdk7/a/Pl95xhpgElra4ThOqRdEBjMUY5am6hSuK4JyaLRJBREJS/QNC7yh4m+ZAtYh251I4MH6/QZesmFwMcxEv71yXmMFoIhJvJH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m262o4h6ra51Rb6Iz/mlzUtPdhX6n9We7m777bDr2MA=;
 b=gfTDTDoaipJeuMocF0wXLZmnywyL/XNaLAYf1FKyJlPsiWidfqhZuzkSd/6CJN+E64QyYj6wxvGRDQ8IrpoozClLqqWBxXu+Te9BxAqumst9HLu4l/7/w5BHtefwA/eOPZWb0lYXTl30zLuGqC1Axjekn3o6Weh6EpmP5wMAta89+X+avHcKE+uZ9lu7aGjVSTIxuS6Ajh6fYs9FISSqSUil5P8mAp0bT55GnJ0iUuwZ8/ia5xbVa+qlbjHili0uqYA02VTXVropj4nQdYzbEittsDnh1pLJQ2Iq+OMj6DcC6Nffayt+WwJ6JrjbeUjSVbKtuHVbchM115B6eQwG7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10316.eurprd04.prod.outlook.com (2603:10a6:10:567::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 15:39:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:39:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Mar 2025 11:38:45 -0400
Subject: [PATCH v11 09/11] PCI: dwc: Use parent_bus_offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pci_fixup_addr-v11-9-01d2313502ab@nxp.com>
References: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
In-Reply-To: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741880335; l=4863;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ijnbbqkrbm2zGBkdDkKnT9lKB0pwFgDMV6ng/ql8F3c=;
 b=SGvzDpP9fJQr/iK7ZCsthLVSBVTLUGdJMnpdbGMVwkGYQ8nnA6bBcwr1g4ABl303p9V/AMi4R
 9SjFKUzCENaCn25C0YrHgX5IPey2P3AIPvenbhpzPtxxY5BCa11eidO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:806:22::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10316:EE_
X-MS-Office365-Filtering-Correlation-Id: 546c8954-3c9b-41d8-e08d-08dd62453dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG5FREZYOEFMTmhhOTFtcFlJYm1WU0Z5NW9VQnNYKzlubkNVUmJId3daRTVX?=
 =?utf-8?B?eVFvRzhBN2xidW0rTmVDc3pSc2E5S01hSDFjaHVNWU1hVVM1REtRTVRzMWZ1?=
 =?utf-8?B?RWVwNGswSFo3VzlhTzlPWnFVbkljTHFUUWpQaGNiMjN2TVpvMEF6THJ1amdt?=
 =?utf-8?B?QmNVNzVORElqYk1zQk1KL1o5a1hCNm1aVzN6WHRTZ3U4QlpsV0djRGh6TjdW?=
 =?utf-8?B?dE1relAvRitUR0NEb2FZOHZuWVg5ZHZqK2UxUXVwT3l2VlZjSFgxWHNaM0tL?=
 =?utf-8?B?RDJ4WFdCYytnYXY0MXp6eUlFc20zZWZvcTlDK0NKQzc2emhkOS8rSEwyRlVq?=
 =?utf-8?B?R1FlSlZ4REhuYnd3YzlYVFhBWXduWURXOEUzektYVTVmRDY2STZOaFYyaG1Z?=
 =?utf-8?B?ZmJ6U3AxODlMMGw2UVlaZVpLYkdGVFNqcUl2b2NzOGxCNzNZa2x1LzVEdmow?=
 =?utf-8?B?VytlcmNRNkhML1hGYjZtbDcxZjZ3aXRlazdlU1ltQUs3bEZPbFpTN3hiS3My?=
 =?utf-8?B?V0FKbGRBbDR0SkRKU3lJTDdOYmtDNTg4cnVVanNhTEhGMEFFTWRGdFhNdUVl?=
 =?utf-8?B?czB6UC9zeDBJSldnRDlQRHY0UXVUQnU2SkMxZ3hJbytOU1Q1dGxDanl6ZldD?=
 =?utf-8?B?a0k3SnB1cGNwbHZTcGJOQWVITGpHOVdWMHJDZ1NiRkRJUXJ3NlRCOEtHY0tx?=
 =?utf-8?B?aEtwczVxaTZ3YklqTFBsRit2WHBneVJBTHhXZ2V5VmticjE5bkxsWEs4ZGpr?=
 =?utf-8?B?Ui9iSnhEaVdJOEQvVlNFTlVFWmg1RHR2Q3dYUzFRdU03ZU4xTTZieDhwNVly?=
 =?utf-8?B?ZGtMckxBaDd1OXFLMmZnd0JBdUN1NFVGSWJ3UUFQaWdRY2N3c3lnMmlqS1dE?=
 =?utf-8?B?cTNsQTJyRHplUjdWb3BMRUUvbW1NdFJNazlBaUxZa2Y4VE0yK21kTmVLQnY2?=
 =?utf-8?B?cWNaZDRPU2JUaXkzNVBrQWhXbHFiUVFVejl6dE9wZStKZDZWeFRBMEQxelo2?=
 =?utf-8?B?bUZlVzRBTGhMa2g1Y0p6N3BRUzVGeVN4UzBuTStKTGpQVlBkR3UrV3JWKzNj?=
 =?utf-8?B?ZmNTb2ZibkJrOW1mOW9JKzBqQ1dPeFUxbk8xQlNpeVNmVTRPcU9rdlFtYlRB?=
 =?utf-8?B?bXZoYm1GM09CSm9LUHZzOXRDSUJYOGNBVHhTckxmK3luOTJLQnVlRTN6bVhB?=
 =?utf-8?B?ZDZYRjZvQTVSM2wzN3gxWG14QlVwWmVrWi9sdTJPMW94WkdGQlVnZElQV2p3?=
 =?utf-8?B?QklXZUlsdk1sNVJzMmk1THpOU2g2a1VBLy9CVC9UOTR2NVRmVnZzMUxnTFVT?=
 =?utf-8?B?V2xrb2o2LzVXOTBnTnliQ0ZQTWd2ZlRnY2diei9qTXluQStBS2xZOTFBQzRF?=
 =?utf-8?B?YitwOWc3V2wzVkZBMXYzNjFDM3NCdXdZU3R2RDdUb0VKTG5PZVRjS1hLYkla?=
 =?utf-8?B?QzBraWZzRHM3dHJ1Zzh5REhqWVJNbUNoMTI3SEdlMDB2dHJWYzgxbmY5TWpa?=
 =?utf-8?B?RFJCYjNKR00xZjNvMUl5VFRRQ3A2QzZsTkN2UEhVZUhza3FlbS9BbEhVZzhq?=
 =?utf-8?B?T08rVUlUR1lqQXlES2p1cE82T0FRbGdvSHpjWGVvQTk2aFFGYmd2cllvcVpX?=
 =?utf-8?B?TW1SZzJCVmVHQzRoLzhBcDZLRm83bktYUlNwbFhMQVQ2c0w3NGpJRkRlMkFw?=
 =?utf-8?B?UDJETUF3UldKRDFFdExiV2pHWXdNVFBQYjk4dE1xSlhsMmVxbWVNS2RyYUti?=
 =?utf-8?B?U3lZZTZqc2tuL2dCMk02SG54ZldXcW9kNHRyc1pUdW5Xa1lWMUFnZmplMkZE?=
 =?utf-8?B?MjRsTkV0Y25kSWhjSktRQm1FS1JkL1g4b3lVaHlpODVRVVo3VkNyWXF6cis3?=
 =?utf-8?B?TTR1QndQOFVHZ1JjekFiNVVYUUJCc1JWdFpzRUNJK2hZNjFENDFnaXRidXJ1?=
 =?utf-8?B?azFPZXQ5d0dNQ2Qwem9MTExmSkxwSWE4SHdQTmxRR2hoTXM2MFgyWDU0WXlr?=
 =?utf-8?B?TnI5bm9BZ3ZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUtiVld5SVBkNU5oTVBQeWYwdFlRWUFXOEo5YWZJbHBxZUh1MXZNZmIySDd2?=
 =?utf-8?B?S0U1TTZBdktVOTVxTURKTVlnNkdLVVlCNU1lOHlxM1E1dUpKN1JYS3NCd1Vy?=
 =?utf-8?B?ZzFjbGszT1I1KzZCRWdkWFJ5VmlKTEFhd2ZjU1lTZDhhbnNxYnM3MUFmRGlu?=
 =?utf-8?B?am1YOC9LRUtKK2tFT3cwSFpOOEtsWll2Qk9DY0Q5V1BHcytkdEtTbmZMYXlN?=
 =?utf-8?B?YmR0MU9ZZWdVY2FmczFjckJGYjU3SllmaTlidlF6VTZ1TFNERnlZdkFtNmdt?=
 =?utf-8?B?U01TbHNnaDFmQmtSd0J4YkJnL0tvN0ZnTGNtNVBsR2RzK1F1WGFjN1hxWEdm?=
 =?utf-8?B?OWQzQW16dlROeVp6bUZGZnp0aXp0K3V4eCticlF1TVdHM3BuRy85bmczUjVx?=
 =?utf-8?B?UmF2VFdISW5IckgvRXdOUHlZQzIxMEt6ZUxiSDR5WkRSZ0tDYzZiV25qaFA1?=
 =?utf-8?B?VXpjeGx6OWhkZjZiV09aSit5U21zMlJRdzFYVGJzTXM2V3VkZWRiWlVmM2l4?=
 =?utf-8?B?VVZTck9zV1JHMGhqeE1tSk5IN2RHWFFSTzBybUlOcXhmaTU3dzRJRE84aVFI?=
 =?utf-8?B?Q3RXaG9OYkJrZG52SnpoeE9HdUZNb1djTUZjbCtNSmIrVEJMNHArdURiRUdW?=
 =?utf-8?B?L0NaVUdCRTlGdzhLdzZyVkxaamdHTFNQaUszblRyTUxaRDQraUdTMndhY01i?=
 =?utf-8?B?b1l6ayswcWhScWttRlF6a3Qrd3B6ZCtVc0ErVyswSndNbENDQnRSczJ2YUJm?=
 =?utf-8?B?Sk5MTFY0ajRDUXIyZGdPemh6NytRMnI5aHZVMWhxZU9PNVdXbVRacGhZQ2U1?=
 =?utf-8?B?dkt3d3BlWWpWY0Rodmh2MGo3c0RMRDZCSi8yZnpidXh4WDNYSjBSYUNzR3hL?=
 =?utf-8?B?RU5mTnp3WGRkTkNLQzE4cTJIZU4wYVp5Z2FIL3VyNzBWcVJyd0YrUDFhWUZs?=
 =?utf-8?B?NUdQQ2I5NjNiTE45YjFNMzJTM1R4cHN2MnlldEJwNGJzbkNZVnZDZ3JZL2pq?=
 =?utf-8?B?UFB6YVNsQWRPMXdJVGwrZnhNUXNaa1JwN0JtTXByMi9lTjd2RFdVYVNzOTJR?=
 =?utf-8?B?bUlBaEhWcHkxMk1GcG5vRjJPWmRsWWxNMjBuOFJJOVlIODVmc2RrQnFJVVIw?=
 =?utf-8?B?S2U4dzFoWXBVMzdnenpUL0xKb2h6R0xoRjZJS0pHZmZkdUgyQ1JGWW5ZN2J3?=
 =?utf-8?B?U2JWdzliS3ZIRDlBQWJEalp6N24yTzZJYnF6eHRRc2tudUZBaGM2QXU3aEcv?=
 =?utf-8?B?OWpDNEpjZFVOWGhvOWkzRE5aYS9iUmJLc3EzWDZUUEVhQ0dhVlZSbkY2dGcz?=
 =?utf-8?B?WU8xSkdENThncTFUc21BRmFkeDlSdVpMeEdja0lxTGRnbVptZ2VOWExlSmdk?=
 =?utf-8?B?SlQvQmg0THorZWtKaU9zTXRESzV6YjhLVlpNekd1REpITVV0OXY2UGtTSytC?=
 =?utf-8?B?ekppMy9uYUdrZEhrdkFiYlVGT0poKzBoMW1hUjFwNWtUUEFNYlZ2ZTdSaVQ3?=
 =?utf-8?B?dlFMZkFsUEJXVGdxRlJiNlRhZ2FPZnVIZ3lNZXNSbHpvdjllOFpDWkI0bk0x?=
 =?utf-8?B?UXAvalA5eVM3Mk9IYm5uU1c4LzVjTm4wUXdBTFZFTUVFcVErRUUvc2xNb1B6?=
 =?utf-8?B?ZnBUUyt2bXNGTlFKcDRKd0lKNTE1VWFoQXdxUHpGMUZTNGxQd1dpei9kNlgz?=
 =?utf-8?B?Y1NTVUt2SmRzaVNCbVZCbnA1RG0rSGVYSkUvZUFQMFF5VCtKNlFzUHg2Vm9O?=
 =?utf-8?B?SEJ6UGZCOVM2c2sybitKUzBVcStsUDRDenZTSmZGRDZ6UUJEUW1aM0trRnEr?=
 =?utf-8?B?dEZsL25rTC96RVQveWJlZ0FXODhwTVZoME1ybXUrb1d1OThieWRkbjRuT1RV?=
 =?utf-8?B?UFRZc1JxWG1iNUZwd3FMc1lLZzBtREJnUjZyS2RGSnFOZ0tGYUlXbTk5Z0Rm?=
 =?utf-8?B?M29zeHBPek9LSmFhaVVPemkzWjVxWXRUUVpOWElZejl6c2dXSll2cjBPUlFP?=
 =?utf-8?B?aWREVGsyM0ZoQXo1dllVeXFnNGl1TVJWMUtmeTRyNEt6ODhSb1pQaFVqYk5t?=
 =?utf-8?B?MTI0cGs2ZVJjd1ZDUVJWMDhscXFhRjNOT2drV2pKd0hKQ0pndnJFMWNsNGJC?=
 =?utf-8?Q?KhI3udBq3zWqCA6vfcc40KwY2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546c8954-3c9b-41d8-e08d-08dd62453dd0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:39:28.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dehnrPJgq5DRDXgSAWtJf95OeGJ6w0HZU86Xe36wQFwc7dzI02vBdZV3W7JandyWITQl4OkyizFu/3pakFjogA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10316

From: Bjorn Helgaas <bhelgaas@google.com>

We know the parent_bus_offset, either computed from a DT reg property (the
offset is the CPU physical addr - the 'config'/'addr_space' address on the
parent bus) or from a .cpu_addr_fixup() (which may have used a host bridge
window offset).

Apply that parent_bus_offset instead of calling .cpu_addr_fixup() again.

This assumes that all intermediate addresses are at the same offset from
the CPU physical addresses.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v10 to v11
- none

change from v9 to v10
v9: https://lore.kernel.org/linux-pci/20250307233744.440476-5-helgaas@kernel.org/#R
- pp -> pci
- add ep side support
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  5 +++--
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
 drivers/pci/controller/dwc/pcie-designware.c      |  3 ---
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 4ecddab131b33..e333855633a77 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -314,7 +314,8 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	ret = dw_pcie_find_index(ep, addr, &atu_index);
+	ret = dw_pcie_find_index(ep, addr - pci->parent_bus_offset,
+				 &atu_index);
 	if (ret < 0)
 		return;
 
@@ -333,7 +334,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	atu.func_no = func_no;
 	atu.type = PCIE_ATU_TYPE_MEM;
-	atu.parent_bus_addr = addr;
+	atu.parent_bus_addr = addr - pci->parent_bus_offset;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
 	ret = dw_pcie_ep_outbound_atu(ep, &atu);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 482d8ff751526..3e7df3d2ac269 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -637,7 +637,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 		type = PCIE_ATU_TYPE_CFG1;
 
 	atu.type = type;
-	atu.parent_bus_addr = pp->cfg0_base;
+	atu.parent_bus_addr = pp->cfg0_base - pci->parent_bus_offset;
 	atu.pci_addr = busdev;
 	atu.size = pp->cfg0_size;
 
@@ -662,7 +662,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.parent_bus_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -688,7 +688,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.parent_bus_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -757,7 +757,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 		atu.index = i;
 		atu.type = PCIE_ATU_TYPE_MEM;
-		atu.parent_bus_addr = entry->res->start;
+		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
 		atu.pci_addr = entry->res->start - entry->offset;
 
 		/* Adjust iATU size if MSG TLP region was allocated before */
@@ -779,7 +779,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (pci->num_ob_windows > ++i) {
 			atu.index = i;
 			atu.type = PCIE_ATU_TYPE_IO;
-			atu.parent_bus_addr = pp->io_base;
+			atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
 			atu.pci_addr = pp->io_bus_addr;
 			atu.size = pp->io_size;
 
@@ -923,7 +923,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	atu.size = resource_size(pci->pp.msg_res);
 	atu.index = pci->pp.msg_atu_index;
 
-	atu.parent_bus_addr = pci->pp.msg_res->start;
+	atu.parent_bus_addr = pci->pp.msg_res->start - pci->parent_bus_offset;
 
 	ret = dw_pcie_prog_outbound_atu(pci, &atu);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index f17a25fe55a5b..8b546131b97f6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -475,9 +475,6 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	u32 retries, val;
 	u64 limit_addr;
 
-	if (pci->ops && pci->ops->cpu_addr_fixup)
-		parent_bus_addr = pci->ops->cpu_addr_fixup(pci, parent_bus_addr);
-
 	limit_addr = parent_bus_addr + atu->size - 1;
 
 	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||

-- 
2.34.1



Return-Path: <linux-pci+bounces-13579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449C29877CD
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 18:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66AD11C21FDB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123F315F41B;
	Thu, 26 Sep 2024 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tl8R6/YS"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0531E15ECD5;
	Thu, 26 Sep 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369282; cv=fail; b=A+wAIe/Y0ZgfuEDARsT4o2ahWVvYYuLVrAfyn9OmKfGrE1qJNKltKFDJGinFi62Kt4BXYON7CAn30crXg7J0T1nq/yrVO0dweN/SF6Gni6RXXEyL6NKJhYo2eSvhr4itJy27cP9AF8A16qYJM0aF2xgNtDplPws+k6y/bqrlNSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369282; c=relaxed/simple;
	bh=4/d0yg3ZdSKNs2s1itIqRF0QpsFqrvue8dPnBf8tBgc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=X/ClUE5IT2MM7VUFKCx+r+Kfk0cSYz06ODq8uSfT3j/lDkxw+My8HlDj/OuHktk2Dg6dAI7+PmA2tlUZKc3wCQKFcKAh0baJqdagDBy54QmHdSE/RIIuufImODGZVoNovgwoxn8OkEYn5yyBsYpIDiqSD2QlyxiKbod8VFW/jkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tl8R6/YS; arc=fail smtp.client-ip=52.101.65.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tisRnGIQnMEjIuOaBsQ4+JC46vxaUkiB1lVQ4YD9Qgzf1KWCIWuwLO5VlgczObOsNOSDINBnc8rKHPxPws0gD7TgkVpUd01Q7kYmto60zN/QDlDL0hbOtEiHLXp7LxKcwhreBWW8Ta0hTJb/WSSWQUSdQik3/nlr+E4zJerhF/pImBVDIyBv/LsevLtzA0EIIrXls2JJ7jMOjsYdDO7hTeVgJOP/O/5W2R6hjiZOdqgR5XAOg+fpDOxqUhCYpLLs+RyBvlcv18JLj2vfNcIGsf8nHS3VUrc5WLVuU+I0v01lFZKYBajYd2On6OfucifOhSRw6kt2jPOH2jUjPzU9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3sjUEiO0k6XvVJ5cZBVFtq9FPmyCSr88/w4nn+7UwE=;
 b=mp1thGO84cQe6yeI7h0eZdRVkp03v+3j/LdISUCI9Lo6CHCNHOs5noREOoKLog71SJD5hK8JVYbzS/rYgsRdL6qqbmcAfBWIsrWkFiIRtkxI6NckuVyaHGXYu0fjJsnc/z5l9+Oi+2poAEOsIaNPHD8SsMxaqlJWSxWVWqb9lSfhL1ae11vX1szgx6zOXXB1+3nVCzGIQ3Yi1ee5kH2dDHxdACaJ6hD3fR5fnjDW+8hgLcXs6EC+zM5VDkbnnqRPJ5EHbaYtaRIzSgIeSESIn6Az+zH3dn+v06S0KXjwAofTgDmlcFbcsJXZsr0y2tbDXoYX0p8XCmJlC2tOn760mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3sjUEiO0k6XvVJ5cZBVFtq9FPmyCSr88/w4nn+7UwE=;
 b=Tl8R6/YSGywfGQqBOcE8Fp5aDj6+EaO37PyJFxZn7wk2y7eCa5hEjJkzuu3UBxko84rAENnkiVO284/td18PLzqUsz333tfWrVWKwfeHLP0YeoAPHhLMS7DRrnvJD4uR1AqPMKYkklw6tsEHqSo4stzY4vAgWQYMRKsdQd52g1K3ipdKQCXv1ZCcOZ2LQFkxvpCtnkNywL5U+j78DSSu9dvZszQHKzYlKmozBC3yWYPFLxAXsX8GteC2U/9H3ObLXHV5em9ZOM+6/Xc406zwVAL21ZDWZK3DtCsViuJTxjxmwfNHLXSJi8WkaDhMxgWLq38xT4Y5UZpjXeCy4uhxJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 16:47:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 16:47:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 26 Sep 2024 12:47:15 -0400
Subject: [PATCH v2 3/3] PCI: imx6: Remove cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-pci_fixup_addr-v2-3-e4524541edf4@nxp.com>
References: <20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com>
In-Reply-To: <20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727369253; l=2425;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4/d0yg3ZdSKNs2s1itIqRF0QpsFqrvue8dPnBf8tBgc=;
 b=zZHDFYAhGGWKyUhoHuATdR5ysX824C1DL/YF7b+wIDIvCapIU/OuP7hI1gAbndbgQBS0rdr90
 V/SaJACMKmYCkugvMdR/u5QABb252bjqTOojl5g9CgeAkBBmorFNoPx
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:334::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cfa33e-f0db-4847-665b-08dcde4af644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3cxOGhJYVh3M2pCQVdONkp6RlBnMGgyaTJ4a2pwYS85c3RXS2Vrdmg5aTFU?=
 =?utf-8?B?QmZuTWRBQ2NDNEMzSlVSdWJqRUFtVkZzalg5ZXc3Z01GdzA2NGI4ZFFQbzNE?=
 =?utf-8?B?TndWcnc5dWRZS2NDc1BtZWtJNmlnRzc3WTlscGVidUJFVU1yVUpBS3ZMbUFW?=
 =?utf-8?B?a2dKTmFSL1lkZW5SUHczN0JjNWhxV3gydjJpcGxRQ3RSWHVyejdLWDN3TkU0?=
 =?utf-8?B?UGZiNzZQeFB1Q0JucXQyaDB1NHk3VTQ4QmwzcGhYM0ZIY3Qzd3B1MWNscDhw?=
 =?utf-8?B?c2xLbUVzSzI5eWRLMmorWEljY2VHeEl6UjByak1XbldzL2VXaGl0VmpwSDN5?=
 =?utf-8?B?bVZONWRBdmpJeFc1V0Fia1VVSU9OTWlPK0xVN1hvTGNmZVpGRUJGRS95SmFK?=
 =?utf-8?B?L2FuRXp2a1pTRVBNZTBLR3lENmRSTmoyV1pJUldwb24wcVNnSnFNbDFlSjZN?=
 =?utf-8?B?M0w3eWJvdTFTaS8vOHNBSHhlU1N5eXpJclhxM1ppeTIvUzE0dTVZYlJ3c2xG?=
 =?utf-8?B?Mi9YRGZ3WTk3QmoraHJwTUNFeHN0b1FHQ0pLRlhXM3pFbFpXYVFTTTgxZXJR?=
 =?utf-8?B?MDZLWlFxVDRUT1hNVDdLcjRxSGF5eS9IZy9hK1FPUmpUMW81enVHektRUXNr?=
 =?utf-8?B?eWpnd3U2K0xjVG9iSi9tOUx4VUhXd3dGTk9zNXZycmZ3Mm5PVHQ2dS9pMVlz?=
 =?utf-8?B?Tk5taG1Gbmg1QVRrOE9jUEdBVHREOUJYWjZ2Vm1vTkFGelVZb2V6ZXN0Tm1j?=
 =?utf-8?B?KzFvTDMyV0l5bnhkc2ljL3RoblBTVW51bWhIb2k1WDNvdjVWZHFmUzlLTkc5?=
 =?utf-8?B?MFh3QzV4M3plTlRTamJsdHVleGZLc0lrZzh5ZlNLVGV2U2hlREp2MlZjeDd6?=
 =?utf-8?B?UVhSRUtuN2hXL0ttOVpmczJhOVVrbDRYVGdxQnBlWXZOY2FRS3pyNXp1WWY4?=
 =?utf-8?B?V1lRRU16VEIwa1pEVDNnb0dNTDlySDhhMnZEdTdlVVVtbVFtbkRFOEptTUJN?=
 =?utf-8?B?TkZ0UUk3cHlkT3JILzU1RjJGK3pvQTN0MTVpYVFJOWROZUFydlBEKzNYMkxl?=
 =?utf-8?B?azM0emMyN3pmTWYzekJ2dHJnRjdta2QwUjlTSHg5aWpVOFlWR2dldGJQK1d5?=
 =?utf-8?B?T1laZk04V3RsNlZrZWo2M2UzR3JzS1lrTnh2VGZBalg0Q0ZTT3RVb1FYTHNm?=
 =?utf-8?B?bHBPZ3hhT1kwN0lDUzRXK2R2QW9xd1FKZW5Iem9XaXpyemVoZWVFRnFlM0FQ?=
 =?utf-8?B?cW9qSm9NV09GdjZOZlR6eHViR3ZLZWN5R1VndW9Dd05rOG9iY3J6elpNaXlj?=
 =?utf-8?B?SFE4K0RjQnFvYkhhbCtwMVpmKzU4YmQzbkRmbTdqWWZHNUw4RWVsWUhBOStq?=
 =?utf-8?B?TjlkUUVxLzNyVnVEL2o2RnQ3SUpsMm9UZUMzMWhvMGlPZFhpdFZHdFRXekoz?=
 =?utf-8?B?WEZvS3B0MFVoNkxYdGM2QW5YSExwaWUvV0E2cVhrMHdZQi9jWi84L3hqK1lz?=
 =?utf-8?B?Q1krK0R5REZKbUVEU0RiM0xuMFVKcERDdzBMQTJNYyswc1NVbXJaSVN0dHRu?=
 =?utf-8?B?cS9tYlJqS0tjUGVyQU1ubXd5a3JHaXhRZ0hDaVBMQ2s5NStsTVV5SXJsSmJC?=
 =?utf-8?B?eGtNMmJ5Rm1Pd3RtQzNrT1RTaFpKVnkzeFB5cTFIUGREN2NCQXJFcHlsakl2?=
 =?utf-8?B?Zld0VHozR08rM3dXVXJtbjU3UzlHc2x0RnRvUmhkaEQ2TEFtTUdyY2dtOWRl?=
 =?utf-8?B?TURYT2lDNWRleFVOWHp1VUV6WGVnc0pRTnozcU5MOEdlTnR1ZDRuOCtDVW14?=
 =?utf-8?B?RTFndllkUUtLQjY4SERJcmhBYy9mS0pLaWhoMzZScGVJS0VYSENHeVc5c0Qx?=
 =?utf-8?B?WXhsQ1VMZnpybDg2Q0l1TkcydUkyemVYTUpNNldJTHlJNHBqUEk5aWN4ZzVq?=
 =?utf-8?Q?P1VD0xdCgg4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHlvaE1GL3NUY0doV2JmcEx0dVU4dFYzTG1aVWVpUEk5dVpESXczRGhoSk1L?=
 =?utf-8?B?ZVNlTUtLeUZSdVNPcnBvUDVrWlJJK2dqK253ZmZRMFQzTXp5bWxjRFVESXd5?=
 =?utf-8?B?ZVAxS2FxY1BwUjlTb1JCWGRLMEdSVDQ2TU1yV3B2dmExTElJbjNzVFpJdG1S?=
 =?utf-8?B?QmFkdUJGN1lKODdhWGVOZDdXaFFsQytOWnp0cjRsdnJBakNQSFpvQld6c000?=
 =?utf-8?B?MUk3ejVoSHRyaXB4Ynl3OFUxV0dCNTN2ZThCbXhTVFVPUmhvVTBYdkNDY0My?=
 =?utf-8?B?VVhnbXduTWtiRXJMMGRaMndmZnZnYWhPdi83eWN0YW4ySkxWU0txSWdyeWdk?=
 =?utf-8?B?bnkrT2d0MWNLUjZLZFhYVEJqVHBKcTVEc3Z0TTk2bmFKb3B2Zm9DdzBvMmM3?=
 =?utf-8?B?VFBZNDQrcWRzSEhQQTNkOG4zT0t0aUJvNG5EcWNHRUhOWEZXazFjK2p4NWE1?=
 =?utf-8?B?a01BUHo1STU1UW9ReXlKcmtwdVpSa3JQQmNuQ0VkYWx4eHV2V2w5RkFYS2I0?=
 =?utf-8?B?Mzk1eEgzZTU2NWt0V2dYaUdiK0l2eVpiUzhFZ2pJV2tqZWZscTNzbExuNHhG?=
 =?utf-8?B?Mm1UdWNmaXJLSzNGa3dyVDVOSUhuWVg5K2ZySFdMalpRTmNsb3FmWklIM09W?=
 =?utf-8?B?OVlDemZ1TGxJVEVyU2VrWTRoT1dxd2lDU0RSeTh5WTlpdXBKc2NhV01ac2Vt?=
 =?utf-8?B?S0FJTUh5N2JyV202a0tGRjUyTGZoUWhoYlZYcUNhYTY1ZWxzMlJ5b3I0YmZR?=
 =?utf-8?B?eUZLUzl5U0s5RVBSblN4elo0WmRjU1dWVVZwNFZoK3R1RjY0WjhSRHNEL2tP?=
 =?utf-8?B?Q2dHdHM3TFIxTFErcDhBVStvbnovdXdrdW1xV1h1SitiUGZXQWxwbG9FYkJO?=
 =?utf-8?B?T3ZPT3BOZjg0eW5xbTIvNFlrRTJnZjBFVkZ2d3VGdnQrdjUzSHU2T2x0UnhM?=
 =?utf-8?B?M2pSSTNWMkxLYWM4UHlTWmlkQURKR0hTVFVCRUxDcURITURiS1hOMnBFWEc3?=
 =?utf-8?B?cmdlbE1GZ3F3SXhmSUE0UHk1cnRwNDVaeldNSS9yL1JWUWVaUXFKTGgvbTly?=
 =?utf-8?B?UXFNOHRuYlFJOXZPZkR6YVFiWkFVd1hZUjEvQ3dFTUFWS1RkSjVZM2FJbEZl?=
 =?utf-8?B?bXVZNjBaWi9HUVhNZWhPL3JFOUtNT1JvZm9JMnJJQ3ZwNUJuRGo4UGEza09h?=
 =?utf-8?B?a21jQVFST2p5V3p2NHI5VGFFaGErMU41N2NjYWQ5Y0tHOUdhanFweFJlb1Ri?=
 =?utf-8?B?MmswMkQ3N1VIMWJ3SkVZZVhOeHA4ekFNUnpoT0RYdVNxY251SzFhQ2tTWkhw?=
 =?utf-8?B?ZEZCUXhobXBWMm1UeDJPZTFYQnlIaWpVUFE1QVlhZmdIQ1lSZ2UyQ3NFQ0tt?=
 =?utf-8?B?eGhsVkVMRWNyWEg0ZWNiMVhMVDk4ZzVwQ3FWMWZIdi9wZzBKWXJYcHhtM2Rk?=
 =?utf-8?B?M3JCd0pweWhuT0cvWGtZSlFwQ2F6QjBZWGpJVVRFKy9xVEN6YkVxN2RxbDd4?=
 =?utf-8?B?NWZ4TmFNY3p6RWRMcEZEQ3lsSVdUR1Q2SmVlcnE2Q0ZoaExaOTdrVGNPNE5y?=
 =?utf-8?B?NmdhUzZOL0FkOFU4TkxYaDhibmVNSHFveDZBZVNyS2pLeDBjTnh5MlE5SG5V?=
 =?utf-8?B?Sk1YRmNNNm5QZWl6cDVKaWIrRTJYRzlkWk43bll6UURnaDhETklQSld4ZXd2?=
 =?utf-8?B?S0FyQW5mU1RMSzJCVnUxWnRTdlZPaWgrZlV0LzlCMC9nQjN6L3daTTVTTHI4?=
 =?utf-8?B?azFqQ0pYZzdwMlcrRUN4N2VmUEkzc2xqdXArQWJ3by96L243Y0NMWnN6Z0sv?=
 =?utf-8?B?d0YxdTMwTTd6Tk82TWNsSklDRkZoNTM3S0U2bjNLc2JJdGcrZ21ycU5VUWdJ?=
 =?utf-8?B?eWpUaGtCKysvK1k0RDZ5ZlRkaEVWK2Ezejh5dGhNckR4Q0d5bS8wbFhiKzdt?=
 =?utf-8?B?bUE4aitTY0MyZkpDc3RNU2NXd2NPMXdnWGdHV0xkUk9BcGxkZnhMZ1RjSnpX?=
 =?utf-8?B?bVZjZTNwRWNSUUM1Y3M5M2c0blBuVlk2M1Q0c055dmV3TGtKcHhwQnF6SFM1?=
 =?utf-8?B?YWo5dkZ3L2UrbjVJQkNxa29PZGhyTWpJajZmeUh2enAxSitGcldjcnZHT1Bt?=
 =?utf-8?Q?ARHmdmqNiAsiLfyw4ZWF3iOJC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cfa33e-f0db-4847-665b-08dcde4af644
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 16:47:52.4273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NUM92ugVr8PLu+XZZweApbySUOvqzuCCDKuYNpM3KH2dZR09ohflUTFB5+4rEFFsNk+oy60M5+EjAWU7vpiGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7768

Remove cpu_addr_fixup() because dwc common driver already handle address
translate.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- set using_dtbus_info true
---
 drivers/pci/controller/dwc/pci-imx6.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1e58c24137e7f..94f3411352bf0 100644
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
@@ -1459,6 +1441,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->using_dtbus_info = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
@@ -1598,8 +1581,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
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



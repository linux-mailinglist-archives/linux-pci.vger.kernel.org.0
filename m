Return-Path: <linux-pci+bounces-14592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F06E99FAEE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 00:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1BA2836B3
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 22:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A513A1B6CF7;
	Tue, 15 Oct 2024 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XM2y38Qp"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013029.outbound.protection.outlook.com [52.101.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44361B0F2D;
	Tue, 15 Oct 2024 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030086; cv=fail; b=ntZzAr/mPHOJfjlg1kkG5AUGNWAc1SRD4Pb3MY3YuuvYMzJlQdU3XhODJk1zopucwPZxPLhR/NinY8y2Gl+jQsXz+AMzWRTcowOhDthzMKeZ32aDbK6oQAJuRM5BEGODT+RhzS5LVlT06SglyqLgyje14+RSywy/YWO3cccxsJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030086; c=relaxed/simple;
	bh=dpRuTumZhFUVbKPOdmtAMQ5zSKVcrdkbzwxxi6fJUz8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cmwufRgKtCezf12njk6VPKZs+UFu57O/wBo+HxCf/nLblHnWDkM2sQL7NVO5n3xUivZdtQ6/M5gmusUFNVNY2a8Gjf+QUYZWfnG229wBICZagGNCEseOzJ4vqDo7xNjwichxVTa0V856tXyEHNqsL/0TUAZOkLe6Er8/syEUaCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XM2y38Qp; arc=fail smtp.client-ip=52.101.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohBqd6KkVhftuO4VqhKCJENTeM4OPsaX/TSbDOIq4NHj5ufQV7ls84wbuDhB4jCbLjMNTuveU5lRJcR9MBYSpSqQj2q9xrNZzJkIbhclxph8gl6x41//Qx1DB73nAndplYNQR9OSE+jF644oftwDdx2DiEB8vwndBpN/GxSXQyG8wiiChN1NhlmFH21/5A92yhRhO7/mnzqmRq28K48gThjMd6bx7AYhleGNaHFC2xVwg8MHY+SwtenTSF8J0A0s+kO4xKBPNnMKzkiIt5vA2hEYlmmuYCSSxZ2eedxzp/Acytkt972YlKceeiWbhhnuFXtnJLMbS7LP1wVUiJn3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swW1eyLF2wHdo0B2Hb3YfQpGGihq8nZ9DTnuN6C2Omg=;
 b=o/AlepONR9l6KxO8iKKKCVDpC3+HMcZSFw/eRxOFiaJIV+Fr7hosyzH9FTGDHW/AWeT22bsL44Sm8Eq04unSTJhFsPmlFrkAMTvEfq+Wdgzb2/31hL06NvinTgJuPs4h2Pjbpd3Wii1RpDtDzeIdC8Se60Gs0jtjmcJYlYJzoOpp4KW9/xGgIYQoos4WECXaXxGhJ/JM7+JugDo69NUle98L7KzzDfGQD0AN0Wz8xJShgnoN2qOycFW3xOxQFBrUv5LzL/B6q1zhWSeK4o4vVKfjB+Qk9PIBOaghTC1Qt3goDiAN9ehn5WZHIViYScaJ7Su+HGYkspey+WcUWM4vEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swW1eyLF2wHdo0B2Hb3YfQpGGihq8nZ9DTnuN6C2Omg=;
 b=XM2y38Qp8zevU7ORrcX11DucfhVs5Yp3PaFwyEV7Gh6RAJHmp7mw3umEAPiU4ltBJ7+ppoO47fi4O27IssCKYQudc8HOZKZmk9/JBqgVhvjTsKWZy2ON8uhkalGLuhk/8/ZFyxx9ejOmRv6JT0IezktEDN9tt9vFP6gl31HxgdqmbZnoUbRgjxeFeUxIMPSxQ5CIRqomVSzySDsZMN9iLzX0kmtRcnseS8AKwagMB6BPVIaP60AJvlBc9o/BvlkjzXxshV+VyKRoLguf/AkbCwZ0nQNzJOyZ+wEzZbIIOPh0hCOohtUxNf/BGJl0VDIiER3zwRO5X15nFB50gRTfrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7788.eurprd04.prod.outlook.com (2603:10a6:10:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 22:08:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 22:08:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 15 Oct 2024 18:07:14 -0400
Subject: [PATCH v3 1/6] genirq/msi: Add cleanup guard define for
 msi_lock_descs()/msi_unlock_descs()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-ep-msi-v3-1-cedc89a16c1a@nxp.com>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
In-Reply-To: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729030073; l=791;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dpRuTumZhFUVbKPOdmtAMQ5zSKVcrdkbzwxxi6fJUz8=;
 b=5WhOgWPZ4IGIHmznpYsjRFzEk+lVGdt0p3vms3BedG0LqO+CX5RpnQWxJ6ypDWH8zAPX4BuyQ
 ZOwIThBonCUATNAwpQ8x8Lse5nQaq11Z7nx6ERwk3vmVGnYDa2vZ8e8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8c6dab-3e34-412b-bd6c-08dced65d5c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGJ6ckswM0hZT2pGRXZkZEo3aDJkK1Y5RGJ5b0JFV3B6NHA0UVRxQ0NWN2hp?=
 =?utf-8?B?QVVPREtUMG9qOVlDenJGNDJCMkNyRENEZU9jTExPZzVUQWxQNGEyM0RjWWRu?=
 =?utf-8?B?QlNCZUdOYWFGQ0dKMVJCTEJTYnlZUVVDSldLZU1BMzkwNTdIQklTYTVac1Er?=
 =?utf-8?B?RUlaeVVFMUluS3JLbHBnRnB2RWlTbmpRQWptQnUxaHQ0b0MyS3c3czFQTmFx?=
 =?utf-8?B?UXdobzdtUGd3dVVCbENoa08rMEtPd0R6TUorK1VsYllaUnI2aXM0ekxvTk5n?=
 =?utf-8?B?YnNMd09vOVBPam1aaldJdUdBNk5nLzdBYWoyV2RoL0ZhMk8vc2tPSG1RM093?=
 =?utf-8?B?OHdBdnIyNHA0UXAzcS9lcnJ3M0Q1U0doZ0NYeXF4MGxsbDBYZjAzdVlNMCs0?=
 =?utf-8?B?c0ZMQWJaT3VEb1Urbk9XczFMYXhDU0tLVkcrSjRULy8rNmh5K2k2bmZyQVha?=
 =?utf-8?B?Z1g2WXN6R0pYczVPeDViWm9PYklFZUpBZE5DS2tGTzFqNXpLWUp4c1pybmxE?=
 =?utf-8?B?TjhmK2VrWXFjTmRsYTMvZHc4MWwwVHR3cTFoMUkzd2gyK2NkaThKMndBVnAy?=
 =?utf-8?B?T1dDUDl5V3Faejd6VUhCQ2lQSDk2S2FEejlEd2Z5T25oYlJaZkRmUmErbmpo?=
 =?utf-8?B?eTk4c0QwNU9EU0N5Tm9rMlUveHV2cG8xQ2gvQ0F4V29rQlR3elVGMGJKYzZ3?=
 =?utf-8?B?aHBzTWNiWVJRS3Z2ZXN5UStGTFQ2WXJBVjZnSWhkeHNleGRzUURhS0ZQbGha?=
 =?utf-8?B?K3IrSmF0RURsV3NNR1Y3V3IzMisyZC9HbC8rR0lZVGRuaUFZUjc4Y2NwSEpU?=
 =?utf-8?B?OWZJUGpLRk9wRXhtS2kvZC9ScWZUcWtiamJvY0M2YmhaWWUzRnd4NlR2OTZZ?=
 =?utf-8?B?ejUvMHJaTkhkdHZ4cEx5ekpOUGxhQlJDMmo2ZmljRUYzQ0xNcVRVOE5lOHZL?=
 =?utf-8?B?V3lYaGxjeFV2NEhiaEhNaC9xUmZjeUZITmNzUGVVd1g3bERWZzVESHBMWi83?=
 =?utf-8?B?MlJEMFJFN3I2ZkpVZUJvamdhRFpSTzIvMm1CNnU5UVRQVDB1ay9na25yNmta?=
 =?utf-8?B?N0g4UCt2aGhKQ0NyOXF4QUFSMU9YK1hWcHhRUHE0WWdOSjBQdmU2M2s3Tllq?=
 =?utf-8?B?QjRZSWU5RnF0enhEZUkycHRQUGFJRzZyZnZhY01xbEppYUJrN2hsQVFBQmpm?=
 =?utf-8?B?RXFuaTZ1MVdYU2R4T3NEeVY3SEpsMS8yZzNVdE9rSTNMWFBYZDhWazhDRFNt?=
 =?utf-8?B?NEhTaFpZWlpXTGpqK1pnSzlKazg5QnAzajNMcE1FZzJ2ZHNOYXcwNnhGK1BG?=
 =?utf-8?B?WkgzU1VWVkYyOEUxdW9BdStLcnZpdnhob0wySUE5WU9ZVUtVSXNBREhXaitM?=
 =?utf-8?B?WU5CaWRrK2xQZGJZWVlxNUZQbmZXSHJOdUVzVnR3aHQ5dkpub0hocjdIcGhX?=
 =?utf-8?B?TndQS0ErS1BrMUY0TG1INFdNL2pJWVVUY3M4R1lEeFZ4Y1g0REdCdktYUWVQ?=
 =?utf-8?B?dHk2K3NrM3U2QkFxWDlWVjduMlRvMHJRQmdrYkdYT2hoWFZwL3ptcW5jOGpr?=
 =?utf-8?B?cXo2Sml3V3ZMeDJDZkU3SlhKNW95dGptUndZdGY0TWR2ZW5lbkM1Z05aazhN?=
 =?utf-8?B?U1htUHVtQkFXYVF1UVRoZlQ3am4xZkYyanFROFdjQmJSbXVaVlJiSjE3QU1F?=
 =?utf-8?B?MDdBSXdRaGtZS0RYZWRIRzN6OXNxYjVyc2NBZFppNkk4bXNNamtpOWtaaFVn?=
 =?utf-8?B?STRwTGN1OCtFVjVabVRnbG0yYStOY01vT3JrVVdRcnBudDhCZWppaCtobWFQ?=
 =?utf-8?B?Nk5IMXhyVmlQS0dTUE8xdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXFWMG5XbG9LRTZaSUl0UDVNNHRSb29XUVNEdHhtbE9oSU5FWko2ZUp5OG84?=
 =?utf-8?B?S25YTVFRMVJ3Q0VYZXNzRHB2S2JnM2RCNHFGTTYyNGlTRWdWVU81ZFZzTjhD?=
 =?utf-8?B?SVk5b0NIWHpqYzZtdm5hOTVCTmplZG01aXY3Qm9OaEl2bHZvT1VKRjRTa1VM?=
 =?utf-8?B?TTZhSUZFTkEwcElUUERqSldZdmhXQWZuaGlHUDhIV2k4bUpsaFR5TE1BWXZG?=
 =?utf-8?B?NE96eFdDYnIvakpKdnJ3cXBuMTYzTngzTGZYU090dk9FTklwazcxUFJOZHQ0?=
 =?utf-8?B?OXo0cE05VE43QlBIbitqeGFFOURxSTV6bkZzVi9hdmRETTMrVFpYeWs4ZFYw?=
 =?utf-8?B?MXlpZEVIdzBrNWU2Y3hTc0FuR1JBQjI4Z3haNlpmbEtGUUdhNERJWVVnbVg3?=
 =?utf-8?B?aTMyYzBWd3M2VUdKMkJDSitXcHNHY3dDc1NnMVBqdmUrSGVpWk4vTDlVSDVD?=
 =?utf-8?B?UW10MzdidktJc24xNTJtQm4rb2JFeXU5ck5ocXorcFY0NHlJb2JRaXVXaXRh?=
 =?utf-8?B?SFlRUHJxVmVhKzJaRU1hRDhmaWVqWU52ZVdiTlpoMDk1czArcWtDa1ljaGhB?=
 =?utf-8?B?a29BV0VSQkhjb1lIUFVCeGJvaDFzWnlHRDM2OEZ5N0IxRVdjYjNmS25mdVNv?=
 =?utf-8?B?QUhrUGZGNnpEUWlqYjRtSTZrNzF0bWhvZytORkhZZDBkQWYwbWtZSWJkM29S?=
 =?utf-8?B?TlZXbFowN0tFQlEyUDlNU2MrY240WE85Y1o2c1JPUkUrZVdQT2ZGL3IwWWFL?=
 =?utf-8?B?NExiY2cvVlRGdk9ZaWJsSjNLSG8zUk90MlFhUDlDa2g3bnhVdjBPbFZETzg2?=
 =?utf-8?B?OHovVUdRaTgrM2F5TXVhNEdUVTdsK1hqMVBIR1ZHbjUyNnRiMFlOdjRMVHNK?=
 =?utf-8?B?dUNnTGNMTGxjT2FadnZ6R0xXWlFaTVhRY3ZReUN5dzQwWktkMUp2VndnOVpx?=
 =?utf-8?B?RTVvY3hRUWxKem1XTUYwbDNQTlpNQkpkdEpKR2VKYVVpUHJwbDlvYnpUaFZD?=
 =?utf-8?B?QzM5K0wwcHBGT0xNMUNoblBSb3BrNmtMU0d3YVJQb3NpQzVVSS94MUdMMXN1?=
 =?utf-8?B?aHg5UUVvdmpwUkdsYSs1aTE1UGQzcW9lNnZVQld1ZHhDV0hwcUEzenJlUGFm?=
 =?utf-8?B?eURGQkh6SVZHbHNGY0JvbXVkMG1zK080TklXUjRNQWxpK3RTUzVhLzYwS2xn?=
 =?utf-8?B?dk0rckpEdzlvWVRjVDBzTHNQRHNXeW5FUDNkYXBYM3pzQythS0ZqYU5MbW4z?=
 =?utf-8?B?WlR0TTM4dERIRmlObGswbWhTVlJDcTFxalFKbVNRdFBPbDRzd1hyY1Fmb1FP?=
 =?utf-8?B?aWx3VVBia25LWExYK3BCdWg0eHhGZWdVRmFCR0R3cFlYV2xuNCs2R25tdllU?=
 =?utf-8?B?bXRNTzJmUFFKdVNvNk16aG1teFNqQkY4dnBXQmtiZTB5OFZHUkk5UE1qZStC?=
 =?utf-8?B?dWFPSy9VWmVsN0VxTXk5NGRra3l6S2ovQzRsRm0vVlNlcTAzRGNzTjFJUjJm?=
 =?utf-8?B?eEk4Z1ZZK3lPa2x6cjRNRjYyN3ZEUWVEQ0ZhVlJ3WC9FRUZ1blV5SDJHaFhZ?=
 =?utf-8?B?eXF5ZUVNR3hWdExVMHg3ckMxSGV2Wnd2VnYvVlAzSTVjazJUcFFtL2l5SDQ1?=
 =?utf-8?B?SnJIL0FRWE5YZHV3YW5VK3Zwa1JYbXo1cmRVUlluQ2JWcmJZWE1GVkZxRzVP?=
 =?utf-8?B?VGpFcnZkWnhNNURidkpmYjlEeEo2SWhnejhCbnZ0bFJobWFPTWdxQzdwdTZQ?=
 =?utf-8?B?Wjh0ZTc3WXR1bGtYWWZPSmxoQkFtd01sT0lLNm1WMkhCMmpjREYrczlDQ0Y3?=
 =?utf-8?B?MXI4RithVXlsOFNPQVBTYTlRZDhTbXBKK1VMMnQ0TG9OMjJWaVVmdlRxZUsr?=
 =?utf-8?B?KzlkV0tLMHREWnJ0T3pCWFFZMzZxdEg1M2JiOENjbWN4VlVDT05YeXFBd0xX?=
 =?utf-8?B?bUdzUkdLL2FYOXNWeFBrN28yV2NyQ3F5TlpDUkgyWDJHWHk3SHpwVUFqMGhG?=
 =?utf-8?B?MkRMMnlTRGV0VGdJR1JSN0lLVnFsMkRwSWI1U2ZLTk9FYWtuNG0rQUpwTkU3?=
 =?utf-8?B?aU9wSnlqMkxxSy9OZTRTK1ZKcEk1enM0VFd5VGpHMFdIay9ZYkNubks4RkNk?=
 =?utf-8?Q?jOP4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8c6dab-3e34-412b-bd6c-08dced65d5c9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 22:08:01.4871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/42s0zFaX077BEkWmrLTbTPnk1OTKQ5RgpI7lcd+j1yblzq8jCCRrJvt/XBA0IxHOgEUQ2SGDurKjuo0bVijA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7788

Add a cleanup DEFINE_GUARD macro for msi_lock_descs() and
msi_unlock_descs() to simplify lock and unlock operations in error path.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/msi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index b10093c4d00ea..0b6cb7f303887 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -228,6 +228,8 @@ int msi_setup_device_data(struct device *dev);
 void msi_lock_descs(struct device *dev);
 void msi_unlock_descs(struct device *dev);
 
+DEFINE_GUARD(msi_descs, struct device *, msi_lock_descs(_T), msi_unlock_descs(_T))
+
 struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domid,
 				       enum msi_desc_filter filter);
 

-- 
2.34.1



Return-Path: <linux-pci+bounces-13300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813A197CF0D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 00:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2F61F23C91
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 22:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A895A1B2EC1;
	Thu, 19 Sep 2024 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QXRLFQQa"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2084.outbound.protection.outlook.com [40.107.241.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7A81B29CF;
	Thu, 19 Sep 2024 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726783426; cv=fail; b=eafVQXszUSNijx6aQlYQwTrTmNjAYbiLtlJDRRxw3a04rLqPUjjdHnj43jCLdvpkqwXMI2BDYzmq3s0aFRxwMVNbkxLr6u5H5/je0jEEdPnEW6AQmY9npCzqEo46uN9ZZeX4KS7O/cDXo3IC877Av/J0Lp0bSY7TgxEyECbM164=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726783426; c=relaxed/simple;
	bh=Joeh5ILISqH6dXaQEB03rw2ORJ0Vtdkmkn6ixa3NYsQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CblsQn6mF5KwADdQCtKhTzDih27bywqqSevVGIUReL/kwpXt/PIWfvKf9YgwmUOQ5DgvOP0MoCYPXoOUOONZzux32KpbX3KAtWkfJ3W44QFNokWYI+WXQxHe90zFZcR7zhAKS4ncFti9oGs+B5KLBZsXLyoG4EqpsNMkpAg3ibo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QXRLFQQa; arc=fail smtp.client-ip=40.107.241.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyLXK1AOe5YitHVCuYO522aAG8+3h/PWRwP4uQuLcbBBZbMvXKdphgu8OSYqFKa6oBLlG7VV3eHgEIyenz25Em7+i31uDch4vGpS86MFexnt3THQJ8SKhVz4OjYkvaUZRA4cpX8/MPNuROErasl+8q1tW1+lU/pnhKXl+UNit5Cih/z2Z4XkkV51iN5qFxMb1ZDRSWYGaqleDSJI2TCsm8TNDeGu8PEG8D9381/vtCJz/BqTE4s+3NeXF0It1lWq13A/4zaS1q+VGNdMiR86prhkykERZ++3nQziIgSgKwFdK9GWijW5hI+TnLdGqAxqdgGpSqeakwKk434H/JJy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdskRDGseKh1PSivh2HmCqLJU1/ZnHANExAHf6ygLhs=;
 b=o6y6EtcH6021fGVW7qsUG9yit04aEWefzLsTM7vT2ad3uZ99ZmPKQZ9oGuLtSjfv/r33jMKuVH8Qm+n5lcQMm/J6StCv4+2GeOT9UwvS/235nTdfELYhN6ulhCiEQPghZocwh9Izt51/1UvEfV0SxVvXwSm4bYqsw9J11bBcQXHMwaKZnHNCQ65be/gQpClP+bxCYifIJi7USOj3EBqbb9pNYuo0DWGqYjlk7r28xxBuxISnXZwaTZEoVwegOBGufDvjMudzvpwKualNs0aBxwAejQUIfOS9h/WVMbr3LlHTW4gp0gTOyUveGfMJSKsOusPdUWpuEcrF13BYMTWnqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdskRDGseKh1PSivh2HmCqLJU1/ZnHANExAHf6ygLhs=;
 b=QXRLFQQa5racaPa0EDCfCsZ2/R98dg53BXmZs46m8gn61eK5QfP3pv173BLy5uZN8hA/ow6H7fOBQ6peLw9qZW3qT9duz0vBpS7pBkLadXJkhMLZus1k+MKDjqsvl3Oriu7ZY8bbtI9ClI8VApWz52xY3IOVuTiVe+xPzQUxVtRpInn1l0aq3JM8OUmxCrp/hJPG0hCUbORnEwbt1Nwx810dcqdzUnkoevKQiZy7aMuCvBKy1nWk3o+dHELHWPeWQbCfmFtHLKZ7f148b93FjxY55Ak6oDAItEYIHAWt6XHT6fgZpi8AS0oVqO2WJS6xeYyQOKzb3HP01gn+hiSxvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6965.eurprd04.prod.outlook.com (2603:10a6:20b:104::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 22:03:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 22:03:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 19 Sep 2024 18:03:01 -0400
Subject: [PATCH 1/9] dt-bindings: PCI: pci-ep: Document 'ranges' property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-pcie_ep_range-v1-1-b3e9d62780b7@nxp.com>
References: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
In-Reply-To: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726783409; l=1981;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Joeh5ILISqH6dXaQEB03rw2ORJ0Vtdkmkn6ixa3NYsQ=;
 b=Cb/aWmRHcy7CNArIv19ubX8Us30zWIc63ZKRFd3jnipeSgJfQmMZK4KErclw3ZWzTRJ4wF08U
 WDr/VDKl6L0B53p89s1HNuXRvua/n5KOmYay6G5OXZ+yP5qD9Mwames
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a47cfac-0466-4c49-ab99-08dcd8f6ec03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFNRVmsvbUpjY0F4K2I2ZTFnYjV3Y25JaUtrS3V2c3ZvYzI0Y1Z0YThjeHg5?=
 =?utf-8?B?QlFWVTloLzJhTmxGUzJ5bEg1MWFoQkVINDRjZmFOeVhQdzlyUkE0eTdqUitw?=
 =?utf-8?B?QUxJbllRa2NtR3lvMlpMN1E2TXh5WGZyanNKY0xtK1V6YU13UG5KL2xOSCs4?=
 =?utf-8?B?NzRiemdrZnNET2dQdVhPblF2OEdybVFjZlo3dTNvYnhkZ3Jsb1VDc1JadWFR?=
 =?utf-8?B?R0hWblZtZFFCSWd2d25KcisxbExrblRiWkJrM0dMbW1JZTBuZGxFeFlDS1Ax?=
 =?utf-8?B?d01UTkRqZkhtdkFLcVhxM1U4WldycnIwT0JyWWpBV21uOXdrVEpxYjlWbmFG?=
 =?utf-8?B?QmpsR3RFNFg5VytNUGQ5MW5McHd6aTJNL2M3Nno4NXdqL2llM2NCYW1Dc0Ry?=
 =?utf-8?B?cUZ0WWQ2T05nbTRLNStGek9HSUpEcjdWS0FVeUM1YVJOVFhwbno5THZKUGVC?=
 =?utf-8?B?YjhSam53QTYzNG5xTm1abDFOVXpxelVWZ3p1WExKd284V0h2MlJadTlCSkFh?=
 =?utf-8?B?K2NuNHcrakZyUUgraHFseW9vUEpFVTh6K2E4NHh4N25XVDBnVEsyK0RYRWlK?=
 =?utf-8?B?bFZudUpRZ3NmSDVqWHhnakZ6WXFHSkE5NWhVajUyajdzYys5djcwREJiNzFI?=
 =?utf-8?B?Tlp4Wi9vZUJ6K0QzalRsTVJkUHVmQ3ZMMEp0d2t4VUpEYjlNeFpxRkpkT3lQ?=
 =?utf-8?B?ZnhNc2F1M0x4N2dBVWxJdFpHTzMxcW95eFRxeVRTaTVwWDBFeXo5dHRpQ2tV?=
 =?utf-8?B?YUxERTBPSmZCUnZKYUlUVERBZTEwRWtnRlVxd3l6RmxvZ0taTE14cVcycWt1?=
 =?utf-8?B?S2NoS3NnQUFTY0NOT1dZV1hackhpdHJBaDVGd1NOZWdxU2pSczYyRFMrLzhp?=
 =?utf-8?B?OURWSFlYU0twQ092dVMveFQ1TjVtSjBBZUo2UU9DTWtraDVjdzJVQ3M1TnJq?=
 =?utf-8?B?VXY2SG5KcWJMYkVvbFo2VFd2L3V4L25ndEVKTmpGbTlCaWw1RHlVU3I0RUtY?=
 =?utf-8?B?disvZkYxdXBXWUpCWDRTSmx3dmtRblNCSUN6TGZVaEUxeWtzY0dHSEN6MDlu?=
 =?utf-8?B?ZkJDalowM3A4cEppWDd3cmU2R2lVVWI5RTdOWTF4SDJ6ajhQczlxT3REODAz?=
 =?utf-8?B?Q3RHZTlyaGJOblBpYmE0UGw1YjQzbnZ3QXEybGdJQkpUTXViWmpUMDNmR0FU?=
 =?utf-8?B?bkhYWnZBYTRYa1VVdStDQTRReVlpYzd2cVJEaUx5MlVFOXFqRW5VSUpYYXA5?=
 =?utf-8?B?QllYZklKMHRYVnRKeHlUTGdqelRkSDQwWi9XWlBhY3MyT0Uyc3JqRDhHSkpr?=
 =?utf-8?B?bHJ2L0drMyszS3p1SWlZZlJJbEY0UnRIYlFpd3dMelpVcVNkOE1UemJINzlR?=
 =?utf-8?B?L1RPOTlkNTlIV0ltdlhSck95MUo4SkU3MlA5a3F2L3RuczBkNm5TTnpxYmpP?=
 =?utf-8?B?ajlZZTV3bXg0Zlh2MTgwU0JOYVlYZzJQVDhQUGpGeXRzVllOVnRNZ2N0Uk0z?=
 =?utf-8?B?MFJXTGRBZmFuMTVDR2JvQ1hPeXlhMHFzYkdZaE1GVTFiY1FiRE1mSC80a0h4?=
 =?utf-8?B?SjdVa0xteGcvVzZSQXJZSkovS3FINjloakRqV3NmeGJ3bnI4QUF5ZmlUaGsy?=
 =?utf-8?B?MmtDUmVVdWRmdWhHYyt0eW15cktCLzd3L2ZZcTBMdU5RSDlRejBXTVd6NWly?=
 =?utf-8?B?UkhiQXFZZkkrNlYxVzhRcmR3NkozYWh5WEV0RVBFaUpSWngxd3NBZ3gya0VV?=
 =?utf-8?B?cGpEbmtIcXBLcmJOM0FYZ3ZsR3dzdDA1RENHTGFYcEdRU3RYWTJ0bVB5bDVt?=
 =?utf-8?B?YzBZbE5OQWhyeGtlU3pQbVhlYk0vSVlCZ0VtSi9DZ1VjWS9FdjE1TW1iREZI?=
 =?utf-8?B?NjhTSnRnM29sVUh6NHlkVXVuZjl5SWd6dUpyeEtUdTN5YlhrWnlPQ0tkc0U5?=
 =?utf-8?Q?+kcKjDfp5co=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OCt5UVBvLzByOFlPTG8xc0UwTWpXSEpjQWVWcTB6QkQ0SzAvZG9WcmxvNlI1?=
 =?utf-8?B?WjQ1RmdnUGh6bllXbHZhSkNBbG5wUjhCQy8zajFDTDVGTWJuT3BPZHF2RnlQ?=
 =?utf-8?B?c1hKcm04QzZacWFSTHRjRHpuY3daQ1BtUFRibFNqUnBEdUlVUkRPZzVCalN5?=
 =?utf-8?B?STZSbHpvTzVjcDFNb2l6UUhhTVBKMGtZZWNzUGhpRnNucW5INHFJTUhDZXZD?=
 =?utf-8?B?eXFzbXdlanBzeFdSam1sakRwdFZMYm0raVhMYjk5VDIybnM1bE5rcXVxejlJ?=
 =?utf-8?B?Yzd5NExId3V3dHhkTGFwV1hkSlp3b21PT081MU8rbTRPOFRUZGJiTUk0bEpH?=
 =?utf-8?B?bkFJS0tRRlNENnVIaEtuQi9SeFM5R3U1alBMWFoxZ2p4TnQrbnd0UFd1RXN5?=
 =?utf-8?B?bTA5WDBzRjdnNHFaeGozbXFYYnJTR2xSWWp5VDZ4QkNyVEJZblBUdmhIdTR4?=
 =?utf-8?B?eC9JWWQ4bWlYd1FwQ2o3cW1BbjFqVk9lU1p0UVZBYklaeEVkc1VtWUl6aWk2?=
 =?utf-8?B?MWZLSnZMMHoydDdpVDFuV3hjSW8xMjUwSGR3bHAwYmhFdy84VGVreDJyUmZt?=
 =?utf-8?B?V0pVb0FWVnFzV0tDWDl2OFY4SFJSdGNqUjA0d2NacEZLRHpaaGprWVZQUHdW?=
 =?utf-8?B?VzQwajBFaVhqRFI0VFg2a3NkVlhhalFVanhkYW1EejQ2TW1kNU1NenhnTy80?=
 =?utf-8?B?RWJuZG1FVmFBSkE2K2QwNVUzZENxNTBQWFJ6YnQ0TTM0elhuV2NvNWdUNHVu?=
 =?utf-8?B?RVdNOTBJZ29WNnlhV0grdzdGWFZyTjd2SGw4TTRNb3pGWjB1KzNrSitSRFBq?=
 =?utf-8?B?UTRFaHF4TXc0R2VzTkRLaU51aVRNa2haenBodU1BU2VzRXFheVVYaDR5MGtK?=
 =?utf-8?B?R3hUa212RUZPa283VFd3enNnU25aVEgzazcwSzVlMW5jVkQ1Y0FmTCtwZC9Y?=
 =?utf-8?B?QmxBTHh1RmFDT0FwbWtEcnZpVlRFRjhjNC9pYTJXRlFLYXpGWnBvSTUzNXFO?=
 =?utf-8?B?MGI4UTcxSm5wRElnb0RXZXFsYTY5VmFLaGtJUWQ1bHdub05TZ1EwNGVUaDBX?=
 =?utf-8?B?akxzSlR4U2NjMnhHcWUrSjM4Y3FTRHdpOG5GRSs2bStmaVorTE9QYTRkcEo3?=
 =?utf-8?B?bXBBS1RUMzhFZnN1S2JZV1N5VkRDNWtTTm5uTU8zN0tzTkFJdXdFQVJQVnli?=
 =?utf-8?B?UTFaZWVPd0IzNHp0UkI1S1lYMmdXd2d4Njd5U2c5ZHJlLy9kWTlSVUM3SWd2?=
 =?utf-8?B?ZUN1VGljeGJoYUNZVUdXYWRJQ0hRTTI3cWQwR1ZCZ1dyejlkWXdLRmwxcWdu?=
 =?utf-8?B?dmZURzdvaEd2RE9tTTJzeWhTa3Y0RE1FamFqT1N3bjh6QjhQZnBFVFhkSjZz?=
 =?utf-8?B?b3JwSndpMzNvTzNob0FvMFAxNWoxbGk3RmJxNEEyTHMwY1RRcjVRVGNxZWIx?=
 =?utf-8?B?RCt5aEZJdkVhOXBlWE12TDBjYTJ0VEZyWDNWcW9wNSt6Yzh4UjVWelZHb3dk?=
 =?utf-8?B?U05LNDdKOW1MdzcrSm41NkhHLzlPYUxhN1F0SCtpYnlzdUVwdk9SUUxSbkJk?=
 =?utf-8?B?TnhjcUx1TVkyNjNhNXNTNUU0Mkh6VlFTNmljeXNYWnpPdTRzb1VVZFgwMW5S?=
 =?utf-8?B?bzMxT082Vi9GU2xzQUtJRFhoS2ozSWhDMmV1RTd4ZGtGOGZxMStRaGFZNm5u?=
 =?utf-8?B?a3FZbVFReFlZNHFMQkdZbGl0SE1qL3VPMW9YeDJ4VTRvZEp2Q2U3S21PLzll?=
 =?utf-8?B?Nnp5V2N0RmM5bjU0c09ZLzI4V1ZnU0pEem1sakFoUVBMemplREp5ek51N0RH?=
 =?utf-8?B?UjRoUXdBaWtHTDVqeVB1ZnVWcVRuSVBUZGZ0MnY1Yk5teWlWSWJlNUpka0ty?=
 =?utf-8?B?dXB2dUtldjFZQ3d6NUN0Q2Exd3AyckdGRDZUY25mLzRLNjFHOW1FVHl3QnhV?=
 =?utf-8?B?K3h0Zkk4dGloRUpsa1N3RHFMZFlpZ2JZdll2MFBEWWRWbG5OQmU0WFZIei9M?=
 =?utf-8?B?Q3ZBbzBTMG0wQUQrc0EyUXh3eHdLUmljYXhZVWhvc3JQTjgyUHp0U2lWMDZI?=
 =?utf-8?B?d3ZuZUN3bmJPSHBSV1lHR01MTW0xVzVCMzdxanRiY3oxWEl1SWhLNTlsVVBO?=
 =?utf-8?Q?O/wvyhalQo7brkg549stQiG+K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a47cfac-0466-4c49-ab99-08dcd8f6ec03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 22:03:41.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deIWz3qd4ih+0TEhPiQY5YIOW0+EbuXCI/gj2xnQSQRwz6tz4Lkr2sOr9IEfG9blC7Jo4116trk/6JCV083RFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6965

The PCI bus device tree supports 'ranges' properties that indicate how to
convert PCI addresses to CPU addresses. Many PCI controllers are dual-role
controllers, supporting both Root Complex (RC) and Endpoint (EP) modes. The
EP side also needs similar information for proper address translation.

Add 'ranges' property for pcie-ep, which format is same as PCI's ranges.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/pci/pci-ep.yaml | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
index f75000e3093db..2de00d2bf7326 100644
--- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
@@ -17,6 +17,26 @@ properties:
   $nodename:
     pattern: "^pcie-ep@"
 
+  ranges:
+    description:
+      Outbound memory regions, which is extend reg 'addr_space' if pci bus
+      address is not equal cpu address or there are more one outbound
+      memory regions.
+    oneOf:
+      - type: boolean
+      - minItems: 1
+        maxItems: 32    # Should be enough
+        items:
+          minItems: 5
+          maxItems: 8
+          additionalItems: true
+          items:
+            - enum:
+                - 0x42000000
+                - 0x43000000
+                - 0x82000000
+                - 0x83000000
+
   max-functions:
     description: Maximum number of functions that can be configured
     $ref: /schemas/types.yaml#/definitions/uint8
@@ -42,6 +62,16 @@ properties:
     default: 1
     maximum: 16
 
+  device_type:
+    $ref: /schemas/types.yaml#/definitions/string
+    const: pci-ep
+
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 2
+
   linux,pci-domain:
     description:
       If present this property assigns a fixed PCI domain number to a PCI

-- 
2.34.1



Return-Path: <linux-pci+bounces-23652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2171A5FA24
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1014D188FDBB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9F6267738;
	Thu, 13 Mar 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SBjkTvN0"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7FE282FA;
	Thu, 13 Mar 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880344; cv=fail; b=iHSJiodeCecU18MIFJxpkk3x8nnBXhT6dM1/b5rpNLN1N76A4mY9vCLv67ziWKOa7dVCHKk1dbmy+YEZ9P5tfvsy9JqXwCsrY+8EMropRhy8pRqO0ofDtWQWAZcNC/zUSGqPc3f1bGjWkNBwOinbi8TOIyFaNhCRFEAQi1KBogQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880344; c=relaxed/simple;
	bh=bsVAvtMPXhtzXgtL6Wb6Sy7O0pN0v30cPUA3opxY/2c=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ItxVwZA+ybDkdkhSra+s5sfbOEZmf79DnHtJ805QMkfb25fAUZijeI7Xpw6WLUiP6KOke1CoNOGQ/7nsR2JYNT95PAjYTezDl/QYAklNdWGvaBKakx9YGNTl+sJM7T8yDFG+c+FOFgrhPu/0Pu1RWGFfGT6ttrvm9yYM3icJ0FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SBjkTvN0; arc=fail smtp.client-ip=52.101.70.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UA/pxpmt/fMMgwCQJs9WJCtD20RT4sNxyKTLFKjlIIciu/OjPKBuP0nS/biof4ueXnNwkfuLqvzyY8ewSiTW4YA4KbcuD/O6WjojOm1G0Vi5LGpR7RC7gBJMpOT92GS8MmgUAkNN7C2vvoyxLInBEETGiCi2XCSmHtgwh+BFje/wgPQbNuocOto3jEtEYLYZNpFlwNoouhEYbVpXG/3gZ0shyhaI7FBk9c5TZPqg+VQY709Du5AP5ep1TI6YC/pWMe//jeGV3kiH7YcoUMdGNsv2agDFuPYKPmdRWaFCAMljLd6nrqBTy012v0ZLU9c9hVt+9AH5ZPQelOsSLqAcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lK5YeNREMBVecH24ZGiSIonHbvkzk+LL7nXsLemZt80=;
 b=LsdRqH6vXRTkaQNo+M/zZUFUFi5zSR6t0X7hl3iJQWNRQCM90Uj9DwZaHM2Rx9sAORN/A2CrA2JizkspTJvEBgsA3sXhWE/XBkO3tbVsjCcjjHIuhOjjDhr7wFwN9liBKdgWCW+FiR4bLMch5l7PRxJnfBcim5wDhtnHc2Pq8FXC1l0BYgpsVcLRhC7x6FFSXK9+HsPvPnlpxKwpjNoCyZluZI1e1gT0gHAtRxB7sujkpRwBj9PgB+yGtfa1b1x2S597IDW5cD+7NB+d0kB+7tUwntvp2yBsvLraONnOEsL4o5OB9KCbaxluo0vkRwsLu6wP+TWk1XvmUYfbHbh6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK5YeNREMBVecH24ZGiSIonHbvkzk+LL7nXsLemZt80=;
 b=SBjkTvN02HETKv3j9tB/4WT/Do4DujJxUByAh0FeNgOreyS/w5+XuK+zSV3alew7vSzIh5+nZlU7wXL20by21aiJAyZaOUs7onQZQsY+Oo+0uqzR7034u6WBojS4NmQyvExLLfTAdGKy7VOQAVo7H7WZ1lV6bCGNHMZTpeyYaUlzMiOVj4f3jSkJapHC4k5VOtyQjOETP5gLoB7ELFgztlC4dKTuYrozmkKyNUS2T0ilmMcRkinzWr8FySdkOFEgOA9i0NeNP4go5p2sAAbykLWT1JrVinBFLtR3b9pSTSLLDiMrmSqd2vu+Pqi2K7OsdugwjFqeToMqwJLCyzHVtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8119.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 15:38:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:38:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v11 00/11] PCI: Use device bus range info to cleanup RC
 Host/EP pci_fixup_addr()
Date: Thu, 13 Mar 2025 11:38:36 -0400
Message-Id: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPz70mcC/3XSyU7DMBAA0F+pfCZoxvZ44cR/IFTFG82BJkogK
 qr670wqQZMajjPWm8X2WUx57PIknnZnMea5m7r+yAHiw07EQ3t8y02XOCEkSA1e6maI3b50p89
 h36Y0Nq0j44oPISgtGA1j5tNrxZdXjg/d9NGPX9cGMy7Zf0vN2EBDNqFuPeaoy/PxNDzG/l0sh
 Wa5xqbCknHWJDVpzKnoLVYrrKDCirGDnC0okiXaLda/GAFchTVjSZkkgCEb4hbTCiNVmBjHnIh
 MdCQtbLFZYVl3NsvOIYeYXEm63F2YXWNfYbvsrBBSlLoEeze2u2HEGrtlbB1KS+iVdG6L/Q8mw
 D/G9owV60BgijG0xQg3zePVvwSY8zOmtkRPkPDGL5fLN+B6N6fSAgAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741880335; l=11419;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bsVAvtMPXhtzXgtL6Wb6Sy7O0pN0v30cPUA3opxY/2c=;
 b=iPqQqSuVkro+QkCP+3xdwK0rrJvnEzWHUqQYwkC/dG69I47vFa1nX86z4xiZ/Y0H8MIUVQXW2
 eQPEZthWTkqBLzzOjhF12XqP0DuLywOX7o2fe88lFG7qTUevaD6dzoK
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 08772614-7550-46f6-a704-08dd62452be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXZPVzE3Rzh5WnFDQWxPTERqVHVNSkx0YjNWUzhEd0lvY2JPeS8vNjhIdWlZ?=
 =?utf-8?B?NkttTVFqbGIwblZpd1U3VU1TWFVNdzBxWnRaa1FYaUwwcjhjRmdCSk9oQ2pT?=
 =?utf-8?B?S1BQWm44V25vdWFoZHMyV2Jpb1hHQllURS9idDdPbDF1aVJsY2dPdktUV2Fu?=
 =?utf-8?B?L2JnWXMvYndPUW9OM3JkNGxHTG5zam5oQUJNK3AvM1Q5blNLa3YremNZc1Nw?=
 =?utf-8?B?YTBjM25TTTd6Z0xIa2I4Nm1oTDJZYXJXMmswSSt4Y3IwMUc2bWQ5TEpyV1Vl?=
 =?utf-8?B?Ukhubk5FOTRwNS9ONDFmV2c1NlpablNPMEJ1ekxyc2JhZEhGYXBFcG85VEll?=
 =?utf-8?B?aTV4TTFCU1JadGg2cXAyVlEvd1B5d2FaSmdDTFFRODJRS0RzVlowUHM4dW05?=
 =?utf-8?B?S1pyYWlESTZoeUpSQ3h2dC81MmdWVUNTM3gxcUUyVXRNUVk2eitkaVRuRktz?=
 =?utf-8?B?V2lOcmZmUkNtUGlPQXZYdzBIMTZ3K3lYVndkWVJudlJWNHBtdXY2Z2tJRWFC?=
 =?utf-8?B?dEx5U2k2QzIrc3UxY2M2ODlpTUJ1MXd0UTdNZzBUeWQ4eW1DdHUwVnhaa0lB?=
 =?utf-8?B?L1J3SjZVNzRTeTFmUFhMTlc5TzZaZHJJRVUwalJ0dmhTcnFHbFkvMk54L0Mz?=
 =?utf-8?B?OTNTOWRuQzg5Q1I4ZVFBOHJBbnBNMEtkOEFhazRLZW96V2lYRDJLbGk3VTBX?=
 =?utf-8?B?Wk9nQkZ4OUt1dGUySXBocThjRTV1SWtmZXV2K3pTV2t0cFZGUERTbHY0dnYw?=
 =?utf-8?B?SGVYL3EycUJZT21YKzBLalluUXlmcnhIM2Z2ejlHNnMyZGRyUThhdDNEWkRj?=
 =?utf-8?B?aFR4OGJETVRzSERuZUovR3FVbUJhbFFaWkFaRTQ2R2hLOHlWTjlMVlhjbmd5?=
 =?utf-8?B?ZHZHTTVRbkN5d0J0ZTR0dlFhNTBacHFQNkpQY0F6TXFUc3E3WGErZEZITzdj?=
 =?utf-8?B?bUJYUmFyb0VLcTY0QTlLZTVCRnk1NnVSbE1WV1B3VHJKK1UvQTFZdVg3djN0?=
 =?utf-8?B?YlhuQ0NGeTBOTjNpVDJUWXJtRVRtSHhydTBGRE4wZnVmejRTeW90QUZMM1pJ?=
 =?utf-8?B?UWRya2dJOUp3T3NWTGhaWXZjRGVaQjJlV1ljSGJtVWVnWEt1dEl4TFQrK2xB?=
 =?utf-8?B?S1JZZXByS3dLMFFhVVVVYTE1Nnc5L0hrakVkZ29SVzgyNDFmQWk2ZlViSzVa?=
 =?utf-8?B?ZFIxelNOc2JldndVSVpuS0lSeGFGRFhjd2ljcU9EdjB1TDk4TSs1end6STRJ?=
 =?utf-8?B?c1JVQk5hbVVHU0xpaCtZME1BcjFGakl4anNpQWF6ZWcxV3J4My85UUhJLzBk?=
 =?utf-8?B?UnZSclFPZTBCWkZtNk5KRXRsNzdITit2UjZBQVhBN2tzMnJGNDNaRWFERVRK?=
 =?utf-8?B?ay9rNUhONmdzMnh0NTdiVC9ITVB0R2w4dXNlODdYSk5TSWY2bWozZUlQczhN?=
 =?utf-8?B?RkNEY0lYNm5TN2E4OW9pd1FZVnY5aWpFOWxBdnl4bUhLUFhQSjd1STMwK0Jv?=
 =?utf-8?B?U0xPbG0rZnVzY3V1VVlmNUVEWWNYYkhrck5LVkRMeVN3TFdCNlFpOWRoQkJu?=
 =?utf-8?B?eGhLMC9QT2lBYzRsZ2hyVGxEUnVIekNoR3lMMGNCZDQ3NXE0eDkxQ0NQdjdp?=
 =?utf-8?B?TllySHFPeGVPNDlualJwRUdpT3hpQWpuekpqOVhvTHc2Y2w4R3FCTEI0SGxo?=
 =?utf-8?B?L1lGTkpTYVJ1R0d5VllTdldleWlSR3JzS3FOTERNZGxiSVlQd1NEWFE5NEtu?=
 =?utf-8?B?WWZwa2ljbzhjZklleVM1a1FwZVFSZUwzSFQ3STBpRFdPWkR1d3JNQmRocFUx?=
 =?utf-8?B?TllRekZUSVFhZ25rVzlPdWxTY05MNlpCcFZPd2dWeXQ0NjMwUDl2Y2RXREJ6?=
 =?utf-8?B?dWNja3FMSi9zUEx1ZmxLN002VC9BYnBHYkxJQWR4MEl0Vnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?citPcHg0ZlVsZU0rNG5TVEVhTE9rNHBzK3pKSkU4NDF2U2oxbm9mSjlqdHVz?=
 =?utf-8?B?cU1hMnVFc01TRzR2aXIydEZPeGg3VUIvTG1wUE9YaElDdExqNlZueTlzNlZh?=
 =?utf-8?B?ZzRlSDNzUTFTZVJHYWpqejlPL3JhamxpdHhQdG1FeTdOdlRhN2p5QUtSU0Qx?=
 =?utf-8?B?MFo3SDliRDhQN215dExCMmcyWCtiTlRBVnphTktUWThZTEUweVM1Y3JOVTVh?=
 =?utf-8?B?ZDJ6WlcwcDU5QTQxZUlaUjNyYTcvd3pOVjNZYkN1SGR3bXd4WVN0YVFzbVdN?=
 =?utf-8?B?eWxMTW9xK2UvMGpVN2I4MWVhdisramYrOVppYmM4SWFNQnJSQUExenZFVzVW?=
 =?utf-8?B?cmZBZW5qYWlFYVhTaHZsTmY1SUY5NUloSm5KZjJYbWZXNHV4REYzczFwWksv?=
 =?utf-8?B?V2RPWC9mZ0dPT0daTElJQXdEeUc0Zmt6bE1CWWpXQkZLak9oZ01QVVVVT2J5?=
 =?utf-8?B?Zk5Ic000dmpyZFlrRHNKbVlHNSsxTEdncFFValRsVHNsVEp5dVRsbGg1OW1Y?=
 =?utf-8?B?U3d5ZkhjNlJ0NTFWUWRsYml0RjN2cExnclNCeDZ4R1ZDVWVwb2UwdlRmdXd4?=
 =?utf-8?B?MzBqZDlVTk1kSTNabktLdmdvRkdKN09yKzQ2dzU0M1J5Y1kxbCt3OG9jQmpz?=
 =?utf-8?B?L1g3dUJsV0lwMktkUkVpVHRhRmRoYy9XRXhHa2lDRmVEM2dRYlBPQmdLa2Ry?=
 =?utf-8?B?SFhhUGM2WU1HcDlQR0JTR2RmTlZGZHZ3aERXZnliNUlQVkJja3ZvckxuZ2V4?=
 =?utf-8?B?T0M2NVlkU0w3czE5T1pZVE9rTUh5WThiYlVhLzVKdy80eEh3YmloY3dIY2FW?=
 =?utf-8?B?Wng3bTB5R1NvWjhjL3FkdmtIODd5UTU4WUYxOEN2Q21sKzU3YWo5UVpPZjZO?=
 =?utf-8?B?QXNBVE4wVHFITnZtR21wTHZtMVRTdHNSY1BKbkREUzlzUVBoUU1NS3ZsRjJC?=
 =?utf-8?B?clU2d1c4akNWK24zWGo2VXBOK1BISU1lVm9uVmovYjkrUmZGa0lYLzh1aFJZ?=
 =?utf-8?B?aTBJMG01WGtDb2JEVzVmQTh0RUJqTTFRVXMwTTYzU1Q0MWF0UVd6YlByQkxz?=
 =?utf-8?B?cjUxU2NhUEF5N0x5MkpTZ3NqMW1Pb2FYNU5INVhLeW9GcUNXQzZIdFlIVEtY?=
 =?utf-8?B?WjFZVWxVY2o4Z3VpQjJ2c1l0MDhhZ0pSTEo5bW4zRlJvSHgzTVRua2JGUnhJ?=
 =?utf-8?B?eCtTNFk2SmtaV25MY2JDNzIyV1cvcTF5UzhhVHlPSGEwb3dvTjB2YWVxVHpD?=
 =?utf-8?B?cld6NXBoalZGejkrS2ZqY1JyelJMM24rWkNyYk00UHBnVGd6YWREWlhkdlps?=
 =?utf-8?B?cEpGRUp0V04vd3YyZ3Qwc29Hd050RXNkUURPaFRVcm9QQ3dUcVhuU2UzM1hm?=
 =?utf-8?B?WWptZWdSSUR1ZjZ3Z3B1cjUvb2d3bzMyT2xHWVNKSk9SUVUxMDRqekVRQ0JT?=
 =?utf-8?B?a3hxbHpHdlhiRHk5VGhlWUQ1Qlp0UzFaUjdnSmZ3ZEIrelo3SkhNRU5hMUNX?=
 =?utf-8?B?Y1lvdFh5dnhSaDY5cDVFbXlJRGVxTkY2bFZkdUFqVGpWMkxrRVY1c3Zpc2hZ?=
 =?utf-8?B?bWpscjd0c0VMTjVwNmY4dUJYdTJoUVoweEo0dUpjdEJoemVpSXlmNERvazJQ?=
 =?utf-8?B?WkVSS2g1eXV4SW41UHd6L1FZNGc1Vk1LZ1hqakFFZWtXUnJWY2hhSGFHVWly?=
 =?utf-8?B?MFRoL01FQXJFdmxnUGxyTnFUQ2Y4WjFkYTB1dklzOVA2aDF2NGlBeXplT0xU?=
 =?utf-8?B?T2h1TkhObVd3ejZKZml6SWpGdzB0d2lyU3FRdksvcFlIU3FLM05nUHd2VEtK?=
 =?utf-8?B?UEJWUXdhZWJJY2ZITFMxNWFISGoxTklWelZXSGw4b1JsZCtlR2I5RTYrYVVR?=
 =?utf-8?B?NFRrNjlVQ2pLVVlhaEkzeDI2b1lDSjhJUUpETWxJMXJ6SVNIVWl3N3h6Y0ww?=
 =?utf-8?B?SGFqT2xWWHZkUEVoOGNPZWpJbGdhWFV4MXcwZElaVEdpbGI4STBKQ0ozQ05q?=
 =?utf-8?B?QWdmSXNIK2VmekdobjNVNkJ4OVdjaUR5ajFqbXVEa2JQY2NiNVBtdHI3MXpB?=
 =?utf-8?B?OHdqTHJvSVNSN3VCYjFpbzNxYkMzMVdpcXY1OUNJbld4ekVuZ1RJdUp1T1gr?=
 =?utf-8?Q?RCYQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08772614-7550-46f6-a704-08dd62452be9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:38:58.6976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTi6TD/ZpZnxaMnRBmO5FS1lat3ElxcSXGKOF8djfFi+mdRem0QKXW4L728Z/1TaZ3AjP2NOmixOKr7y40llKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8119

== RC side:

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

Current dwc implimemnt, pci_fixup_addr() call back is needed when bus
fabric convert cpu address before send to PCIe controller.

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

Device tree already can descript all address translate. Some hardware
driver implement fixup function by mask some bits of cpu address. Last
pci-imx6.c are little bit better by fetch memory resource's offset to do
fixup.

static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
{
	...
	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
	return cpu_addr - entry->offset;
}

But it is not good by using IORESOURCE_MEM to fix up io/cfg address map
although address translate is the same as IORESOURCE_MEM.

This patches to fetch untranslate range information for PCIe controller
(pcie@5f010000: ranges). So current config ATU without cpu_fixup_addr().

== EP side:

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

bus@5f000000 {
        compatible = "simple-bus";
        ranges = <0x80000000 0x0 0x70000000 0x10000000>;

        pcie-ep@5f010000 {
                reg = <0x5f010000 0x00010000>,
                      <0x80000000 0x10000000>;
                reg-names = "dbi", "addr_space";
                ...                ^^^^
        };
        ...
};

Add `bus_addr_base` to configure the outbound window address for CPU write.
The BUS fabric generally passes the same address to the PCIe EP controller,
but some BUS fabrics convert the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000,
Bus fabric convert it to 0x8000_0000. ATU should use BUS address
0x8000_0000 as input address and convert to PCI address 0xA000_0000.

Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
the device tree provides this information.

The both pave the road to eliminate ugle cpu_fixup_addr() callback function.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v11:
- Add patch for Move devm_pci_alloc_host_bridge() to the beginning of dw_pcie_host_init()
- move PCI: dwc: ep: Ensure proper iteration over outbound map windows
ahead PCI: dwc: Use parent_bus_offset  to avoid broken bisect for some platfrom
- other  detail change each patches's change log.
- Link to v10: https://lore.kernel.org/r/20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com

Changes in v10:
- Remove patch PCI: Add parent_bus_offset to resource_entry because it
is detect by reg-names["config"] and reg-names["space_addr"];

- using Bjorn suggest method
https://lore.kernel.org/linux-pci/20250307233744.440476-1-helgaas@kernel.org/
- other detail change each patches's change log.
- PCI: dwc: Move cfg0 setup to dw_pcie_cfg0_setup() is not necessary, but
nice clean up, so keep it.

- Still keep use_parent_dt_ranges in case some platform without cpu_addr_fixup,
which use fake address transation at DTB. If no one report warning for
sometime, we can remove it safely. Bjoin, if you think this case is rare,
you can remove it.

- Link to v9: https://lore.kernel.org/r/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com

Changes in v9:
- There are some change in patches, if need drop review-tags, let me known.
- DTS part: https://lore.kernel.org/imx/20250128211559.1582598-2-Frank.Li@nxp.com/T/#u
- Keep "use_parent_dt_ranges" flags because need below combine logic

cpu_addr_fixup  use_parent_dt_ranges
NULL		X			No difference.
!NULL		true			Use device tree parent_address informaion [1]
!NULL		false			Keep use lagency method	[2]

Generally DTS is in different maintainer tree. It need two steps to cleanup
cpu_address_fixup() to avoid function block.
1. Update dts, which reflect the correct bus fabric behavior.
2. set "use_parent_dt_ranges" to true, then remove "cpu_address_fixup()" callback
in platform driver.

Bjorn's comments in https://lore.kernel.org/imx/20250123190900.GA650360@bhelgaas/

> After all cpu_address_fixup() removed, we can remove use_parent_dt_ranges
> in one clean up patches.
>
>
  ...
>  dw_pcie_rd_other_conf
>  dw_pcie_wr_other_conf
>    dw_pcie_prog_outbound_atu() only called if pp->cfg0_io_shared,
>    after an ECAM map via dw_pcie_other_conf_map_bus() and subsequent
>    successful access; atu.cpu_addr came from pp->io_base, set by
>    dw_pcie_host_init() from pci_pio_to_address(), which I'm pretty
>    sure returns a CPU address.

io_base is parent_bus_address

>    So this still looks wrong to me.  In addition, I think doing the
>    ATU setup in *_map() and restore in *rd/wr_other_conf() is ugly
>    and looks unreliable.

....

>  dw_pcie_pme_turn_off
>    atu.cpu_addr came from pp.msg_res, set by
>    dw_pcie_host_request_msg_tlp_res() to a CPU address at the end of
>    the first MMIO bridge window.  This one also looks wrong to me.

Fixed at this version.

- Link to v8: https://lore.kernel.org/r/20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com

Changes in v8:
- Add mani's review tages
- use rename use_dt_ranges to use_parent_dt_ranges
- Add dev_warn_once to reminder to fix their dt file and remove
cpu_fixup_addr() callback.
- rename dw_pcie_get_untranslate_addr() to dw_pcie_get_parent_addr()
- Link to v7: https://lore.kernel.org/r/20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com

Changes in v7:
- fix
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410291546.kvgEWJv7-lkp@intel.com/
- Link to v6: https://lore.kernel.org/r/20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com

Changes in v6:
- merge RC and EP to one thread!
- Link to v5: https://lore.kernel.org/r/20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com

Changes in v5:
- update address order in diagram patches.
- remove confused 0x5f00_0000 range
- update patch1's commit message.
- Link to v4: https://lore.kernel.org/r/20241008-pci_fixup_addr-v4-0-25e5200657bc@nxp.com

Changes in v4:
- Improve commit message by add driver source code path.
- Link to v3: https://lore.kernel.org/r/20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com

Changes in v3:
- see each patch
- Link to v2: https://lore.kernel.org/r/20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com

Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com

---
Bjorn Helgaas (3):
      PCI: dwc: Move cfg0 setup to dw_pcie_cfg0_setup()
      PCI: dwc: Add helper dw_pcie_init_parent_bus_offset()
      PCI: dwc: Use parent_bus_offset

Frank Li (8):
      PCI: dwc: Use resource start as iomap() input in dw_pcie_pme_turn_off()
      PCI: dwc: Rename cpu_addr to parent_bus_addr for ATU configuration
      PCI: dwc: Move devm_pci_alloc_host_bridge() to the beginning of dw_pcie_host_init()
      PCI: dwc: Use devicetree 'ranges' property to get rid of cpu_addr_fixup() callback
      PCI: dwc: ep: Add parent_bus_addr for outbound window
      PCI: dwc: ep: Ensure proper iteration over outbound map windows
      PCI: dwc: Print warning message when cpu_addr_fixup() exists
      PCI: imx6: Remove cpu_addr_fixup()

 drivers/pci/controller/dwc/pci-imx6.c             | 18 +----
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 21 ++++--
 drivers/pci/controller/dwc/pcie-designware-host.c | 75 +++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.c      | 85 ++++++++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h      | 19 ++++-
 5 files changed, 146 insertions(+), 72 deletions(-)
---
base-commit: 5fcc194143ce5918ea0790a16323a844c5ab9499
change-id: 20240924-pci_fixup_addr-a8568f9bbb34

Best regards,
---
Frank Li <Frank.Li@nxp.com>



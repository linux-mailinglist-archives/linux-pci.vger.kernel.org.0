Return-Path: <linux-pci+bounces-14595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1DE99FAF4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 00:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AEAAB21284
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 22:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE541DACA6;
	Tue, 15 Oct 2024 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U5b+XHpY"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C2E1D6DB1;
	Tue, 15 Oct 2024 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030096; cv=fail; b=ZeEhZrrw6zjFSTFhbkYP9Lb4BnQuI/yDj0mqMzggidBCYMqEXNjTDZNRX53TvKiTM/rovv30bxJr9kEFMbJ+jroTPOZJ8efeHNBWGMhf4MLMjQHESq7VwZzED8B10G0Q5HKQxXYDx5I6ocY+iVE0z5jhAJD4+s9kTHAC3hEeDCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030096; c=relaxed/simple;
	bh=vg1b8fZ0ikOaTJqSjYHEd0OEjyDNFXGxJ24NF7GoDWk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HXqUXEL7nSYVe86D5R4Nlb9026Jo9avxurky2bwdb54stTqyl+5SawbPVSILJBZY9xUQGpQaYAGnKO132rrWegh4n27GH9xJpnJ597OcEWKVkdG8gx6iTPt+XXrKnPZJzS3p85OawYGK9jNXM2nc6ZyRJsPaPNEYnsIkppXE+l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U5b+XHpY; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXpFabaRDe3aAvALoj85336gmfzK3IS+cSAJyWvAKiJRVwXyVdXi0fZIFEgWJObduNVy+27GWjugt0HBFejnyhAXDsI070heIEdhydH+XPeGM+EwfDHpLYwAIwy3m4GrlXqB7btBadpbJOYtQsgLZWNcf5Ctv+fNTuGrcXLfU1T/S8DgaLIpvyb29O2frzn/kd5uSTt2FlLJdjIevN7lJCXFfmC6LostboKFRLsQ0paAgX1PAEcQYTjIkdtFSzRuud3WbA5aM9W2Rtv8QClK5wOioitjjp9T0jNNPXnygTmo5D4A1551mPnIbP8qE+cwIcexMPbhAaqFiFnP8Zl0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e233vooloI8RoJJfdyVli25FRPVZrIal9Vo3c9mUtok=;
 b=MrvqnqlPNufN9bsl3jMkYBfXIH6E7mXiT7D7mFDjZJPqVEJaoYajjcEr6XDsbcVrEjmKUWgGdZhkwsX+VUuCy0bKXvM/6HETMk+TpJsSUuyH35WB32cosoY3tzFAEUr2OecWgKNzRSH5C8UayZJGEDsCNqKW9L7mBQwjbTz6AwPFjVPvZWtogusAV6MzhArS0FyPXY3jkahbibPqPaFU4bpfoZf1FY6jKioxc3J/MTv1Tdgy34ZTKmCT8bPSl2VGR2Ujcxh4C19d/g2LG1dkwAZQsiRWKqnhs+PvXSGoi1x2TulxiRLS8FrxCTfGk/79AUiOTs5ZWAN8C1w7AxB6qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e233vooloI8RoJJfdyVli25FRPVZrIal9Vo3c9mUtok=;
 b=U5b+XHpYvkhPIG95cHwg8OqhAjkc2xIkHxbhmwqJiu55VUoBW95qFt1W0o8YHYYdH12Zv97VHzey8Snkn0hFxpuq9bqyF6hTBNJqlEgEK+HsEB09pIpLA8KgrBQdMOJwWWl1/9dLeCd82rgXmijPnTzRLWeUNwWlCh8NCApfYEau/4Hp9hiPIZ6UmbfcKecAY4huKXScdghe8Xi/QL6Ui+cJNiWCEFHOptuzd0pzSlRLt53bSH9rTrZhkChv927hL3q9f9c4QCliQLlczKJqmGOKD6mwM6xbZc9f3N357QM7XO2TkF9cJyFmvn61nydNDE4arlBuCXrkYBUtn6pVkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7788.eurprd04.prod.outlook.com (2603:10a6:10:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 22:08:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 22:08:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 15 Oct 2024 18:07:17 -0400
Subject: [PATCH v3 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-ep-msi-v3-4-cedc89a16c1a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729030073; l=5157;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=vg1b8fZ0ikOaTJqSjYHEd0OEjyDNFXGxJ24NF7GoDWk=;
 b=tm3dItJmYQGV/xS43LPWjmHikztC3AnbZl7D7Z+wQ3GrxC1/3sRNYLjPHJlmaGUdvqnaCXsGB
 tfP5d/mPvPAB011H898pLmyGcExmW6jX9AtvG4AGGYhgiwoL8shSIpx
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
X-MS-Office365-Filtering-Correlation-Id: 1288cba9-37db-4f32-6560-08dced65dcdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzc5bjlBTkhuVlJBZnNMVm03NWtzeldjdkNCZVRoUUNTbmFnd1VGQ0VhTXg5?=
 =?utf-8?B?VlVweEZ6OTlvNXcvaWh2eW9nTEdiRStza2FaR2tlVkQ2c1UzSFhQc3k1NVdt?=
 =?utf-8?B?dFArNnlZYk5PS1htck9yNWMvV0JlS3JBWHV3bU13UkNtb0wzakE3di9VaXV2?=
 =?utf-8?B?eEVzOFUyeEpFaDBTRkpDa0Jiay9pTTk0YWRGdzhjWFVSZUtySHB4MHBVdmRM?=
 =?utf-8?B?WnJpNUdmMTlGbTFXUWxsQ0lNaFErWnovUXRzVENSdUN3V0xaK0I3TnVFdGJ3?=
 =?utf-8?B?aEVUWkZCaWV4eGQ4ZzBLV2xaODNvOVJmeGt2cm1xdVI4NTNWR3BoeVpGd2V1?=
 =?utf-8?B?NGtLaCtBMXo1WWhIdFNaZUtFaWRDUGFlMjRXOTliWkQvMnZBajV0RHNibm5D?=
 =?utf-8?B?cEltTmZBRzZ5MGIzSGorMzFwNGRRVXpvU1ZRamVSVm1hL0M5SUxzWVBxN1VK?=
 =?utf-8?B?ekJLcHZzVEI1NFFwSjg1aEw4SXc3Y0VucUVJM09WWnlHZW5IalNnK0o5UWM0?=
 =?utf-8?B?czliQ3FTTzhXdlh4SHpnQUJhOW1ES3lDQ09ySFRnNlB6cE1XNU9NUVdROTVM?=
 =?utf-8?B?cFRPSXJJZkJyRFJwK2xyc0RSMXBPd3o3d0l0Sm1iUUNrSSsreldkQ0xtcVBk?=
 =?utf-8?B?a3p0T0VRMlFHQmxhYmwyN3IvL3pYaU1JSHFZdXFZaEJlOGxhN2hvUE9TNktV?=
 =?utf-8?B?VEw2YjZlNTFza2NBYkJtREc0WlI5eDlHYXYyQTh2RFNWRW9Fd0JSTU1WTjNq?=
 =?utf-8?B?TnN1Mi9QcC8vME5ocnFJRmtmc1BOSDBNRllBRXNqaVNRN0w4TzlmV0hTVTNW?=
 =?utf-8?B?ODZYWnUyTktEUzJ5YXRiTzg0dGplV2lmME55WkRkRWF4aDlIUWZ6emtJZ2wx?=
 =?utf-8?B?OHM5d0hIRmJoWjI1N2NrY0ZCUXl1RUpMQ1RTQlFkbFlXUEhuRVlWenJxTmlL?=
 =?utf-8?B?eU4yZkxiQ2s0NWJNNE1YaWQ3all4SnhoT1BqVzY0YnZqWkk1b3BqK1RDTElX?=
 =?utf-8?B?bnRSSzA0N2prdXBNRjMyQkdzak8wQ2ZUV1Uvb3lkaGkvYjBwRVVTVWk1TTI2?=
 =?utf-8?B?LzJJMkxJYmV4ZUxUdTR5eVpuZ2FkWklaUDlvdjB3cXJ5TGIxWmVJSjlWeHNy?=
 =?utf-8?B?empVYzlZL2xjUTdwVlFpa1FjeHI4VERObVVieDlvNzRWcWNJTVArSEtDTHZl?=
 =?utf-8?B?NVI4bEFLZ0ZleDc5TWpkTEJ1YkxUMjNzcVlZbHF4Z2VGOCtyUmVJUHpiWXhW?=
 =?utf-8?B?TjFFeDdJTTFvN0E2RXpieWRDdW1KemFCZUQwVTNVZlU5L3MvVm93ak40Q3h3?=
 =?utf-8?B?dDNpRFgvRTNQR3kzaDJTanNEZTVIakhKTjFaOWRSaW9sd1F3UElxUjVYRkUr?=
 =?utf-8?B?WEhTbURaQm81b0paL1ZRdkdiU0RlNEhBNWNFaVJydmV1b1ZUcEp3MFZFblZZ?=
 =?utf-8?B?TzJhR3oxenNVOWQ3cy9rdm1LUlc5QW5DZVQzN1dCVW5YYWZ0VFpqa2xnbXZr?=
 =?utf-8?B?OGlVblpsbHdmVDlBeEhzYTRSRDBjaWJkN0JkbVNycWtNSHNiWHdhYXRnRG9k?=
 =?utf-8?B?elJncC9MT3F5WW91cnZkN0Q0cFJWNzlNbVlhQ216bjNhYXhEQ0Y2eGxrUUJ1?=
 =?utf-8?B?WjF2NlczRmJwUUtmM0g1eTRRRG01VHBPQUZuZXZhZTdCR2ozUWZmQ29TQitw?=
 =?utf-8?B?V3dTMjR2RDJtcE1VMW43NzhNY08xRFJQSW5TR0YrQUNtclgwNGQ0NndFcFZD?=
 =?utf-8?B?SWJtdUlZdm83RmtrRDNoMi9XaHdpYU40dFhXc3YwQjlvTGRmdERXQmpkU1JC?=
 =?utf-8?B?c1RTZ1dqTFZSNXhOQ3p5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckxrR3dtdVErbVA0cDVKT3REQnBXMEtPaXlaRVlvMkhOR2wwSUdpZkcyOHVE?=
 =?utf-8?B?b3VkZ3VjdWhidFc3elVaR0xVQ0R2ZndaWTZZenZWSlNHcGxFMFhBSWRmdmtr?=
 =?utf-8?B?YVNQb2toQm92MHBSU1dIUFNpUlFIRWRESFRxZFltekF3SGd5UXpuNUtpejdN?=
 =?utf-8?B?NnRtWXdZWDdyWWd1MzJTektoTDJkbFljTTZ6VmhVNUM1TFB2dlVyTVV6REto?=
 =?utf-8?B?bVROeld4emVVZWNReCtMUnN4dGNjTXdqK09SR21HMUNOS01ORVV1dHVxMXNL?=
 =?utf-8?B?U3lQV2xCaWVEc1VaN3NXRWcxNjZzem9zR2NXY3NyTW9wZHJFVkFWbnJzU25Q?=
 =?utf-8?B?eW1YWU5vU0pua3RlY2o1dFU1M0pzeUZxc1B5djZ2RFVnRmRwM3JnVng3QUNT?=
 =?utf-8?B?eHdmT3hPYnJlTU1SVzI4Ni93Mis1OVhqY1BTK2pUQWY5bC9CVDUvMnMvSnE5?=
 =?utf-8?B?VDAzdnJoUnpYeHlrUDlRYmVGakVyTkFTQmZvVXkyTmFZcStycitSSFZSSWR3?=
 =?utf-8?B?VkNQVVQwTjIveFMxRXJjTVB5UHB1NCtlQ2pEOGxCRjVoVEtGeERxM1JmeFkv?=
 =?utf-8?B?ZE9xaWp2K3Bkb0NOamhxMnQweEFxZTJjWEVBU3VDbU96TWIvUkdFWnVTLy9o?=
 =?utf-8?B?b2RmajIvclNaekV6L09UOU4wc2JTdmpGSzc3aklTOVpsNjdJM0kzazN0bEVp?=
 =?utf-8?B?Um9IT2xwYnNXM0lLUTVXRTNBTWl3Wk1tZmxjUVJYdENhZEF5N2ZBQmVacEdE?=
 =?utf-8?B?dmttRFVjcVErNmZlUUFZM1VoK1F3L2RyTUhPNC83THRpTDJzYkx0SnU2OWI3?=
 =?utf-8?B?cWxUbGU4M2x5d2cwcVZyWnAyYVBOZTFMajg2RUlwZ1ZRWkhOempJQzF3M3Rs?=
 =?utf-8?B?ZHVHb1pva3J4bm9NWnY4cFIvc0Rtd1hBcHZGUnFsZkROVnVFQzIrRWRwOFE1?=
 =?utf-8?B?U2RpYjA4ZUZPZkJwSjN0dXZ0VDNXMU94NVlpOU9qMXpTM2hEQlVVRzBrUkRQ?=
 =?utf-8?B?STRScnRYUUFkOFJkcFJYWktMUkNYS0J2cHVzMFI4NVhHdTFqNW1GWktvMmM1?=
 =?utf-8?B?VERaVGtvaWttMlVrcHNEZGJlTm9sK044dXpMNWxmTHF6cDh3TzE5UHUvUTJo?=
 =?utf-8?B?M2Q3NFFZb0IzckR0TVA5a1hXajFiSG5pbldmMjUrcVFSclJnaCsvVzU2bTcx?=
 =?utf-8?B?bUlveFFwMUsyamZCYWI2MXVaeTNtc3FDaExhRmJBa1U5TENKWVdjRk9mUnNB?=
 =?utf-8?B?S0RXdUp4MVBzN0NUcC91RURSNEpweWJoQllUZmFoTURKVGdmdWljcUtTcnEr?=
 =?utf-8?B?dWlRQ1NwaW90M05ZNnRCVEJ0T2JqbVBCQVlTSENpK1FxQ1g1Rk1VZi9Ocmd2?=
 =?utf-8?B?eEFnckEwbnZsbTJvWGUxekpQMEpZL1V5aTY5WkNjb3UvSVhHb3h5WXYvbHVF?=
 =?utf-8?B?cjZrYkhQMGREdll1TGlUN3NiemczUlptVzFOUzBwTkNIcUdVZUZDVWF4R0xL?=
 =?utf-8?B?WEhXK0Iwenl5eEc5V1pCazFwdEhOY1hvUndjWk83QlVJczJxbHFFNGNSRlpH?=
 =?utf-8?B?UlFqNEhYZUlmc3hpR0VhakRidXlaektZeUwzaFBMYnYzUlRKWDg1eHNSenk1?=
 =?utf-8?B?SldCSFQzV0pFaW9iSTlTZU9BMFRFdkFyZDJmYkNsRGwvYXN1ZXpRVzcrUlBL?=
 =?utf-8?B?WFFxUkUxQTRROHVTWitwaVZkWURjQ1FUYVpwWXBKM1JYTlVRbzI2ejJaTGtQ?=
 =?utf-8?B?elR1cE1mT05OcC9iTTFlUXlPd2VKcXczOW1lWnNEb1Vzd1VEdUV0S2hVcGlJ?=
 =?utf-8?B?M3NPaVlzRC8yS29zMTA0RzJibDkxaU45bEZINlJveHJsalJrMysyNGtoNEo5?=
 =?utf-8?B?VTFXV2kycXNUR2Z4Tlo1emk1S01XNU9qZm9ER2RCY2JrZjVMV01SbU9SY0xy?=
 =?utf-8?B?emloVFFYQWdwZHBWajN5Tytib3VtR1lMVHh0aVowYXk2RExneG01MmpmMnRo?=
 =?utf-8?B?U3pEWXhKQXppUUY1RzBudDRZOE16c0xKQUNUdFVJS3E5TitkRmR5UE8rTWIz?=
 =?utf-8?B?MmU3eGJIbldieWo2eG9OYWJIaDVqVDJNZXl0RGRDeVZIL0d3K0VMRFFhL2Zo?=
 =?utf-8?Q?sItE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1288cba9-37db-4f32-6560-08dced65dcdb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 22:08:13.3583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbGAvhfc3XY3p3nmM4S4nagpL7gAQW+47MTtUJmvTofozIv7+cxFRfDbbM/0oLHwWygRe73zhbca7YzxIoohEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7788

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a
doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set doorbell_done in the doorbell callback to indicate completion.

To avoid broken compatibility, use new PID/VID and set RevID bigger than 0.
So only new pcitest program can distinguish with/without doorbell support
and avoid wrongly write test data to doorbell bar.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 58 ++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7c2ed6eae53ad..c054d621353a6 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,12 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci_regs.h>
 
 #define IRQ_TYPE_INTX			0
@@ -39,6 +41,7 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -50,6 +53,7 @@ struct pci_epf_test {
 	void			*reg[PCI_STD_NUM_BARS];
 	struct pci_epf		*epf;
 	enum pci_barno		test_reg_bar;
+	enum pci_barno		doorbell_bar;
 	size_t			msix_table_offset;
 	struct delayed_work	cmd_handler;
 	struct dma_chan		*dma_chan_tx;
@@ -74,6 +78,9 @@ struct pci_epf_test_reg {
 	u32	irq_type;
 	u32	irq_number;
 	u32	flags;
+	u32	doorbell_bar;
+	u32	doorbell_addr;
+	u32	doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -695,7 +702,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
-		if (!epf_test->reg[bar])
+		if (!epf_test->reg[bar] && bar != epf_test->doorbell_bar)
 			continue;
 
 		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
@@ -810,11 +817,24 @@ static int pci_epf_test_link_down(struct pci_epf *epf)
 	return 0;
 }
 
+static int pci_epf_test_doorbell(struct pci_epf *epf, int index)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+
+	reg->status |= STATUS_DOORBELL_SUCCESS;
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return 0;
+}
+
 static const struct pci_epc_event_ops pci_epf_test_event_ops = {
 	.epc_init = pci_epf_test_epc_init,
 	.epc_deinit = pci_epf_test_epc_deinit,
 	.link_up = pci_epf_test_link_up,
 	.link_down = pci_epf_test_link_down,
+	.doorbell = pci_epf_test_doorbell,
 };
 
 static int pci_epf_test_alloc_space(struct pci_epf *epf)
@@ -853,7 +873,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		if (bar == NO_BAR)
 			break;
 
-		if (bar == test_reg_bar)
+		if (bar == test_reg_bar || bar == epf_test->doorbell_bar)
 			continue;
 
 		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
@@ -887,7 +907,11 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	const struct pci_epc_features *epc_features;
 	enum pci_barno test_reg_bar = BAR_0;
+	enum pci_barno doorbell_bar = NO_BAR;
 	struct pci_epc *epc = epf->epc;
+	struct msi_msg *msg;
+	u64 doorbell_addr;
+	u32 align;
 
 	if (WARN_ON_ONCE(!epc))
 		return -EINVAL;
@@ -905,10 +929,40 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	epf_test->test_reg_bar = test_reg_bar;
 	epf_test->epc_features = epc_features;
 
+	align = epc_features->align;
+	align = align ? align : 128;
+
+	/* Only revid >=1 support RC-to-EP Door bell */
+	ret = epf->header->revid > 0 ?  pci_epf_alloc_doorbell(epf, 1) : -EINVAL;
+	if (!ret) {
+		msg = epf->msg;
+		doorbell_bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);
+
+		if (doorbell_bar > 0) {
+			epf_test->doorbell_bar = doorbell_bar;
+			doorbell_addr = msg->address_hi;
+			doorbell_addr <<= 32;
+			doorbell_addr |= msg->address_lo;
+			epf->bar[doorbell_bar].phys_addr = round_down(doorbell_addr, align);
+			epf->bar[doorbell_bar].barno = doorbell_bar;
+			epf->bar[doorbell_bar].size = align;
+		} else {
+			pci_epf_free_doorbell(epf);
+		}
+	}
+
 	ret = pci_epf_test_alloc_space(epf);
 	if (ret)
 		return ret;
 
+	if (doorbell_bar > 0) {
+		struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+
+		reg->doorbell_addr = doorbell_addr & (align - 1);
+		reg->doorbell_data = msg->data;
+		reg->doorbell_bar = doorbell_bar;
+	}
+
 	return 0;
 }
 

-- 
2.34.1



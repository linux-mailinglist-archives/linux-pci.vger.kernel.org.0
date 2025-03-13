Return-Path: <linux-pci+bounces-23659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1EDA5FA3E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B4E421821
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7C426A0D1;
	Thu, 13 Mar 2025 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bZyn3V9J"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5722C26A0BD;
	Thu, 13 Mar 2025 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880367; cv=fail; b=FmlZ8kRf1RkayGwtPxvPCXFpk0kveHUaCneGwn1kRtOomhwjfC76Zgpt/VAGSL2XVlc4Hwj1X/bg04QCakSh+CdqLMHjpEovH9jJ8ag9fyrMEbVHvcgDD5kukSSXxWUKUVpRRf/11h+Lr9paaYbPTHboqa1FtXhWW8s3zJGz5Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880367; c=relaxed/simple;
	bh=Rva6x6BqQ3w51ZOz28D8ROpdqiDdrolL2qHkT0k4n2Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AP7pnipqzQcB3clSYcUwzgl9xuv8kG9NRbLNM/gg6gmuhoSjjUoWwn8qrM8J37V7q/do7K0VFmZgsbR4eiyGOSc+FXUNuQeDz0yp35TymgZDyCBSQH9pA6xv8ZdEad7hXvllzk8iCgMu1Wmxlo4BMHHKnYYwwTRLu2gV0gnjOow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bZyn3V9J; arc=fail smtp.client-ip=40.107.162.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAcpw1dEyPJRcOSWJvMZzhE/PAxqbQ6j1CIITKAPYLML/UlPoc/M9eT50NYXfThVN8L4qLmRjvJ5nQwAquEoqRF4c+Qy0Dsp7YnIx0fMtfsSIGErcPr0hZC+jb7WPjKs3heWmsq7oBvaKQdSWZYI0L0P3r1bt/UlfzvToJ7bAsFA8YDsVU85OJIG01EtYoH7XBmdTUwola56p3wm7ti5PupaLvVRVKMv1vgSSmG2+EM7WD+3OPhhtp+woZ0w1QrlgTsas4hfeKpXAijUUHMy4tZAEEM+MvEh+LUlTsnCkxurfgmATsBMallE2Xpev7yqHOYjS2rH+izl7MJrlQogwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Jg7Bqg99+PumfB7K6+m5LS4LnRMYTqE+QdU6HQVXQA=;
 b=j1/G5uxT7O8vOBd83Y0AUdRRT+UXg3k/X2wV/b8G31Z5G3XUuVFtthAJ0mpG33hOnyqiyTVXh68uNSZyg3yt/+k9wSgJNI6uBBRuUV55QUMv+ctU9FgwjTbhZFfrUajvcomOL16ZS29MAHwHyIIfhtSLaq5kt6THstGw2sS3oHbwBJiFxPWayZMBQvtZfkWesRSMHK5FzMf5i5hb1Pxc3vtFR9rBuQXsIJv1fadehKIWPOfBe4KpO41HKyJ8aIPaEnLGsMIC4YHnvKboN9RUQ4ms+M6JmVyI5GZvJ1mgE26JCh4dU+DuN4S48iNMqfUj0DZoyKDziEXfrljEw84PkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Jg7Bqg99+PumfB7K6+m5LS4LnRMYTqE+QdU6HQVXQA=;
 b=bZyn3V9J7ajsbGQPHFYLngDr7XhpKoz03+mSpPxxDrrPAFyMcBeenB6fk2gRcFwfXvkQ5soaWLKGr2qwjeEP4Z/7GRvv7xghi2jnwT2o3ee1chBqj4QAdeFtA1VbE/WlhanPx/spGxLfNq5ow1Q32tsN5A6nrp1dSnmpd8Ep6LPxOIvT/AgmDZ/u28x3PgN/mwLfis0SeC+CVslE7BissBNyTSoqfZoA6A35AsuZ9hjp11ETkV2AUToeVRDnUI+G3p719ubKaeelJj1m+VMOKj1nwuaXuzLd8OApYB5eYg/uBhE2fJf/498+C6MJXvs0SWWbsuHrA442Z7ai1xW+vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10316.eurprd04.prod.outlook.com (2603:10a6:10:567::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 15:39:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:39:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Mar 2025 11:38:43 -0400
Subject: [PATCH v11 07/11] PCI: dwc: ep: Add parent_bus_addr for outbound
 window
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-pci_fixup_addr-v11-7-01d2313502ab@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741880335; l=4533;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Rva6x6BqQ3w51ZOz28D8ROpdqiDdrolL2qHkT0k4n2Q=;
 b=RdzZQ0V6glV6tIZglOmaxAC40oo//Gn1GTnLIgoEplCSYDp+IMwjGc/wkV5SIHnjEpue5YGa5
 dmuCEWOXdW2Byg8qJorLV8W7TNXcj5R92Vcfk3r+EPWKPmsN3MWTfAN
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
X-MS-Office365-Filtering-Correlation-Id: 7a3f9495-c2a7-40df-f1a5-08dd624539f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0x1UlNrcnA3SU9LOCsyR1k4c2d6R253VzdYYnJ3aFoyN0FvMDVaMWxaRmla?=
 =?utf-8?B?SVF3Vmt0SmcxSXVra2pKS2R3UW5JL0NMNjVXWE1nNTJ2ZEhvRW9CVlBza1E5?=
 =?utf-8?B?MGZnWWtwMHJ4SzNkUklnamdmYXo1VDUyL2NEZmUwUERJdk1RTFk0OEl4QVg1?=
 =?utf-8?B?OUZvbFFHRmdDS0I3Zjh4a3RQajlyT2lDWGtGeFlJT2sxNzRyUGc2OXVDYjhK?=
 =?utf-8?B?SStNb1BWMU5nbXN0UUhyZ0x0Y0xXVEVhVG9ESy9PaGpWTzZ3N0hDNVZ0YnVU?=
 =?utf-8?B?c3B5clgzazBNV3VLVG1kdklXMFFwLysvTzlzZUhZc0FLMjdvNVV0T29QOExs?=
 =?utf-8?B?Z3MrNmdCTnFkZVRMNituZW1KTXBaN2ZPTlJwQzFwczZVMHk1Q1lSL0xadlcv?=
 =?utf-8?B?V1J4Q3RKUDBBcFNiSWlwV2t6bHlrbUNaYzhnMEc5QWZ4ZmcvY2d1cUV4bkRn?=
 =?utf-8?B?Vi9DcEVEMXEvUGxoZUlZMmMweDZIb1RrVUVPSDVXN21TVjM0a3RmZGUwSitU?=
 =?utf-8?B?dlhZbTY5SmkyVGxXc0FNUTErNndUVGhhYjV0czV6OUZ6ZVVsWVo5L1AyQ0Z4?=
 =?utf-8?B?ek1zYkY3cnQ2aUpZaTJXVERvaGRMc01lR1g2WGdoODNMTC9mWDVmdm9DQ0ti?=
 =?utf-8?B?Q2JWRmoxWUxzZUhBN0srZE5tbWRzRStkaEZIa20vVDJ2WnllaitGZCs0akwz?=
 =?utf-8?B?UkZucGY3emRteVpIVEJ2TWZmck9wTDFVUkNjYkhpK0pYcmxxWlp3bVhTSVhF?=
 =?utf-8?B?QlJtS0o2MFAzakJiNi95WDJrczFEclMwbHlMWDZRN3l2VzhhaXgvYlAreVh4?=
 =?utf-8?B?UTVNU20xSDBjZUZia3Jma3pOR0ordzdTN1RZM216M3pjZklqb1h4d3hablFQ?=
 =?utf-8?B?bjFYS0ZROGJlSk9TSEd5d3BmdzEyNkhaVGxJNTB4V3R6RmVMcTBRa09sWjZU?=
 =?utf-8?B?UEJGenk0eEgwaDMrSG5DNUlKd0x6SFJrWjNQRGt0NEdUTG1DRUl2V1dRV2Nz?=
 =?utf-8?B?YW16Z1FROVMwcWM1RWR4NFBQT0gwbHk4eWZEUzVWZDZmM3Z3QXhwbXppRDJ6?=
 =?utf-8?B?Ty9xaVJPOW1TUDk1K2oyc3hocU5qV01QQ093c2l0Zi91eHlYcndTV1YxVVd3?=
 =?utf-8?B?YUxpeEN6Y2haR0dOdkgvbFNjVzF1b01HblZRaVE4cGFXL3l6ZTVxRnI1QXpP?=
 =?utf-8?B?MUlwNVhWVFg4bVBUUnc4T1BNSlRITk8xK0tPSzU2OFUrbTBuLzFDQVNidVNO?=
 =?utf-8?B?Y0NTQzlFYmEzcVJjbTNoN0ZBeW1iR3NqN0Rib3grUDZaalVRWDFneUtLTkR1?=
 =?utf-8?B?UG15a0NpOFM1SnN1WTFwSUFoZUtvWlVpWnVzVFRhSDg0emo4aHdFSnYzQ2xx?=
 =?utf-8?B?MUVrdUNxa2d3dXV3SG82c05iUUFEZUdMOEhmRVd5bjliM21sTi9UM09NNEhs?=
 =?utf-8?B?eExsQnozcm9HNVE3RXlFWFZES2pIVUxGN0cwSmk1Z2U0RkhBb29hdmVQZFJm?=
 =?utf-8?B?T1ZRelNjcnVPeWZoMUpreVJTQjkybVFCa3JMb2t4RC93WWxhUDg5NlJaOXhx?=
 =?utf-8?B?aVNUcGNXTTk3WWIvem42Rm9aVGhwN3IvTkxvaVZsSTBzSnVtMno3bzBWaElJ?=
 =?utf-8?B?ajJ4OWxZeC91LzFwbTg0Mmdhb0pjNEFTK0gvMTBrdDV2KzZpR1FMVEYrc3pH?=
 =?utf-8?B?M3Rnc1dRQ0hDckVZQ2tQcXZyZW94OXRodi9JSnZINFY4TW9Zd0hjYnRGWXFV?=
 =?utf-8?B?NVBjNHJDdUxkRjQwREI2UXJMMzlWcVVYc1FVbVRtZktLWEhHQ1lJalE2VXZW?=
 =?utf-8?B?WEhkS0FRSThwNGJWQ3VBNGg0b0dKY3JBc20zRnBlYm1PQWtGZTkvVEpPL05Y?=
 =?utf-8?B?UGh4dlU1SUpFZmZSbUkydGRDTzRuMWdycitrSXFsM1NtWmY3MzhONE1OVXg4?=
 =?utf-8?B?eWFQWkFZT21KNmVPV0s5ZDFSTlNxZDAzbmc3Zk5rcWF0d0pjd2Z3bmVjSDlY?=
 =?utf-8?B?VVJoN1l3VFJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3N5Tlk5MTM1SVVsZVNlMzBFVGUvSjdaRVdscjlQYzdDVDhaTzNYNFZESms1?=
 =?utf-8?B?WFVSbGt0NTJGMWFaeVg4bXlGdXZEdnRoVFBya1Z1MUMwY0Zod3o5c1NaRnBj?=
 =?utf-8?B?WEQvbHBJWFZZWmNSdWJCZGk4S1JKeVh5dk8rTUZYNjFWekc0bWJBSVRCdWRW?=
 =?utf-8?B?dTZYOEtCUVNjNDBNK2tFZ3h1UjZYT1lvOXNxdUlncUpIOXFHcktieUZUazdl?=
 =?utf-8?B?alJvY3N0QlZKdlpTMXdxUDZPSkd5NDYvYU9yZld4VXN5U05EL3dZc0VhL0t0?=
 =?utf-8?B?MzlEcU5CWFhJSlNJNVBlNkhLVUJRaEw3YndzQTQrWGNGMzJaa1VqVVZGTFJP?=
 =?utf-8?B?RmRZL0g3R3NMZXpjZGxhbHN0ZTdvZWRtcFpDWE1QbzdrTEloMUdpZXFWQnpQ?=
 =?utf-8?B?S0lPbXZYTkIwVDdqR0JINGdEanMvRW1BblRGUlBOK3RqK2NEb01RcE51d1BP?=
 =?utf-8?B?SjgzM1V4Z3M2a2NXQW1PL0R4Q21maCtDV2hZejFUM0F5ZHZWVlJtNUZOc0tG?=
 =?utf-8?B?WkZrREF2bHZ5eDZZUGZtaXZNaXpvTEVxVXViUlIxTmRGdVlodVNjM1IxcHAw?=
 =?utf-8?B?NGNTT1orMjRxS0tZY0xoQjBrNVdET1RMUStaU3ZaV24xNnIrSkFmOFRmWVMx?=
 =?utf-8?B?dGJKOVl0QUJCSzJET2tCTVFhTzkvSHBkc1VnVm5POXM4OTNKcytBbUN5M1h4?=
 =?utf-8?B?YW9mL09sYktSSzRVcDdWNHh2V2RHT0YzdXpURHorSFJKeUZNWHJiNFc5VWhE?=
 =?utf-8?B?d3hqalVaaTRnaFBVeDU1WWJBVVNBKzdxeDRGeE5wQmllais0OEpCR3ZrU2pQ?=
 =?utf-8?B?aDVHQUs0NHJzOGFrT0pnYUt0UG9aeHQwSVhSOXNrZUZwY3hoeXhORmJpTFVX?=
 =?utf-8?B?OVp6UnFGWEpVbm5ZK3dMcWRkSmJ1cDJnUmhCenFrL2tETGR3cFdVbHprdDhm?=
 =?utf-8?B?SjNpb2UrRGpXMXZvaXJsTThDdUVIUHlwSWZJSzU2MHFNanpPQXJsSHAzQnd4?=
 =?utf-8?B?eGQybXNRM2t4MFRBZEtacENOM1BpRTk2RUxaOVh3OTZyaG1aUU9WZnp6ejBu?=
 =?utf-8?B?cnpFUEo5MTBZc1NSc293eFVocStBb0xSNVplV0hNOTgrQmlUaTZPQWlnZ0FX?=
 =?utf-8?B?MU13c0UvNmJiQlpqMVJtYyszZGRlNktTTFkwMytWT1YzQnVlRk1CTExsUCt3?=
 =?utf-8?B?aWpWbTM5OWFNZ3JjN09RamdPMzh3ZHVuVTNPUXhyU01JTEhwaEN4MFFSWWtF?=
 =?utf-8?B?aUZtcS8rUkg3V3JIWkRGMmNiMEo4aXJ4SmFibG1LckxtTEJqR2lMUGxhd2pL?=
 =?utf-8?B?em5BV0poMDJ3WGRWN21TbTNOMHI3NTlBUDlpZWF1QTkvRGJtdHRHOFpoeUlE?=
 =?utf-8?B?MjBGeGx0NnNTWEJNdFUxK0F4WDJwU2MyWllYZ05vY1czdXNPcm9CQW1aNU00?=
 =?utf-8?B?SmFodk1JU2c4bUt0UXB0MzNWbnk4amZ1R1JNTEt0a01UK29RQmNrYjFKckpD?=
 =?utf-8?B?SGxvbEppNFluZmlFcmJQK2FqUFJ0bnNkVFJMd1Z5eWRzUXNDYTA4Y2szaWNj?=
 =?utf-8?B?M3FtaVVwRTk2THB0YnpHZ295Q2p3VEx3UXE1YXIzdUltRWY1eGhKalZSZnRp?=
 =?utf-8?B?cFRjTENSZ09ra3AraDNvQnVoajJmTEI5alpyMElUSXdoWEVOdmpyeWdxMDcz?=
 =?utf-8?B?aUdTUmFpOXpHaUhhelk5SXlQZTJ5Z0pLc2huMkwrdHd0U3R2UnJNc2VMRWt5?=
 =?utf-8?B?MkF4S05scVRKRWcrZFltdnNwTHZYeXYwb0pjT1M0NWNDRXdqN3dpQmMwWS9C?=
 =?utf-8?B?cXhzZzRhQmVoOXNXbHFRd0RlMzdGM0hOUjRENnpkRUZZRGdWdG1lcDRYd3lU?=
 =?utf-8?B?VFUrQjNRbURRQXdJUHA0S1RMVHZHRE9OOERudnFDUFcyL05Bdms5bU9sb3lk?=
 =?utf-8?B?NnZYRy93NUVPVjhPU2I3VTQ5Rmg2aHlnRG9kYVB6L0dMVGpZOTZCbE1JMVpp?=
 =?utf-8?B?emJ1NCt1QUJWa042VlpUUjdOTnBTNkNTbTYzNk1jbXNMWmRiK2NJSWIrVFBR?=
 =?utf-8?B?TDQzYlg3SmtPVWxSY1hTT0FoVjFZQ0R6UG9STEgzeGE4VGxsTWl5WFBReW5t?=
 =?utf-8?Q?jNMFBmyzsHil9kNXj/lCYRiaj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3f9495-c2a7-40df-f1a5-08dd624539f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:39:22.2884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCTOZu9olrO3tBdan+NbOR+awDjYCWh5ToaAami5mdgg1fFm4PMliuCvzyyfWpZ6ncc0p23is7kufHFQhPDuNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10316

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

Use reg-name "addr_space" to detect parent_bus_addr_offset.

Just set parent_bus_offset, but doesn't use it, so no functional change
intended yet.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v10 to v11
- none

Change from v9 to v10
- drop mani's review tag because big change.
- call help funciton dw_pcie_init_parent_bus_offset().

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
 drivers/pci/controller/dwc/pcie-designware-ep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 80ac2f9e88eb5..d69d76c150d92 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -915,6 +915,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->phys_base = res->start;
 	ep->addr_size = resource_size(res);
 
+	/*
+	 * artpec6_pcie_cpu_addr_fixup() use ep->phys_base. so call
+	 * dw_pcie_init_parent_bus_offset after init ep->phys_base.
+	 */
+	ret = dw_pcie_init_parent_bus_offset(pci, "addr_space", ep->phys_base);
+	if (ret)
+		return ret;
+
 	if (ep->ops->pre_init)
 		ep->ops->pre_init(ep);
 

-- 
2.34.1



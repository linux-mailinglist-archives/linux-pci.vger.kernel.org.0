Return-Path: <linux-pci+bounces-16195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 897129BFE49
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 07:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013201F219B7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 06:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E571192D73;
	Thu,  7 Nov 2024 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E0x8pZPf"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8DF192B85;
	Thu,  7 Nov 2024 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730960188; cv=fail; b=P28tMJCOaJGMCU3+wMYNkTUWnxc+ts5ooDdcpcQh1W82Ia53g9cg+CaX6PCbCnZWTyBqcxuXVGTnZViZ2OqpoXbrb/fdYZ7KuQtJl9KcqeO77kgvkLyVsJ0RF9XTUu8Uan3/szBjCIzezTZe4VUqIkUJqf2CPQbRx+qwNVEG6Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730960188; c=relaxed/simple;
	bh=2E9Bbtyv6HHcKM97I6sSqxdyWWW21d02PYHDRNp6AOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t9Elm6YpBrJw7Hul5bPVRW6CULpA16tlPgARKouD+1K0cFvpTUwhFSkDfl71rhCb6j0qjueBBRdqi0X/fdjZkEqDbx62Lwk+zduUYg4ZgcUEtgTi6zlqrXSvGLxvw7JmPS7LP7bSbnVzjQykoQjAfUrq464NAe1J9Q8bgFRrxBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E0x8pZPf; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZkS3jxOdZsWNnp/4BfG34PbA9J9ALskMeRG3glx6RJlgR6FSfXvgnyAj2KX2/GFEUXSfaxxkZKjLgLfF6BGsqmLiiG5jaYjbDBlVHnrikuwrxHKssFHTbgSDdOF2n2VbDvWiboFLPkXc7pZ5p99GnXGjjUPv6N6TbfDrPieR0+fRNVSga9USs/YPt5JKfjHMW7UrN0EtYRaOUnNrYQUYXmygvndtrjeJZY9MJE2Mdrm2k9nFyC8cskIpT8Mjeqif+BfK7AT2olqVN6OcjUaUBjR//BKSn9gqtOqUKYRhFWALElxQMOnNMRe4Zga495uFy9l+1Cwg1WRZK8QkJRQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2E9Bbtyv6HHcKM97I6sSqxdyWWW21d02PYHDRNp6AOE=;
 b=bkvK+1TsHwdh5NCEYBWMX/2ij170ljeB84PdEUtlkdOmV6WrfUuqbAU1X1IwvZ+TaNFBKCDzXRfjQB5ipMsZ+Y5ktJY5o2gfkS7j5ADkS/tzp9wpBtgliBW8dByI1fRTjh7ZegMXpqLkHdwYeY/t18jb7LH8oDWyLJKIDCTqCnB3WhwMAvWFZ4jdELgJhOiWReWYT4kZ2LeUvlbuI2BOe/oeKseETgVkMuTc9zbhQElbX9+VTt6h0KxfDqvjzSlAAdh5I+RznFqYt8ScLaHwo3LJdgdF0r/BlnlvB3UX2Bjfwg12K1lCmRzsemaez+xHwx9Rye/rstLGg0w57gUyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E9Bbtyv6HHcKM97I6sSqxdyWWW21d02PYHDRNp6AOE=;
 b=E0x8pZPf/DbUW3y4dZp/K62WdnF3OA3UaEqFj5PHpzFGROhqpOIzJXudB015PAZYDNNL6zMQ573th4MLYkSMWtiEPe0PaDY4EhfYP4Ixo/KYznqwxvFeHqseZFdKOJUYOZiCGicQRg2cGnmqra5y+bBEZtYlk/YPW5jgZO4RyMeancM5QtRcYQMa8+e2t2Qu3Ekb0/44fpSe7kedZ/gBImux3mt/ErjVtJLLKX4Rsday2Svo62qKhFCt0jhFJKHrU70VLUTLHryEE+wpSEZ/JiCFXNpY6P1wnJ+RpIDBPJkZlRoJAficFjpEOllrM9dWzpo2xfP3ylzXlz4IsWNc4Q==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8687.eurprd04.prod.outlook.com (2603:10a6:102:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 06:16:23 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 06:16:23 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "kwilczynski@kernel.org" <kwilczynski@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, Frank Li <frank.li@nxp.com>, "mani@kernel.org"
	<mani@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Thread-Topic: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Thread-Index: AQHa3AEqv5bRdDxqKkSUwsC4eegPdrKp/GuAgAAjY0CAAV7kgIAAfShQ
Date: Thu, 7 Nov 2024 06:16:23 +0000
Message-ID:
 <AS8PR04MB8676C98C4001DDC4851035B18C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References:
 <AS8PR04MB8676998092241543AEABFAAB8C532@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20241106222933.GA1543549@bhelgaas>
In-Reply-To: <20241106222933.GA1543549@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PAXPR04MB8687:EE_
x-ms-office365-filtering-correlation-id: cd28d8e6-6a4f-4125-dab5-08dcfef3b420
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDk3Yk5telRZZWNHTHpiU1RoZ0ZhV0lOQjIxM3VxUUFLRXJ1aFB5b3dLZU1j?=
 =?utf-8?B?S3NWMUNGWmZZR2dpbEU3NVRMdzBxaVNyZXNmZDFxVlpYbzZRL2YrZzNhWTh1?=
 =?utf-8?B?VHBhWXlCZUpRelRTaVZldE1rTXF4WFlXWG45VjVsa0M2RmcybFd2SHJ0Y2hD?=
 =?utf-8?B?MlNiY0lBMDNZUkNaTXFmSGN3WnVkZE5URm1kNWduek5TNkgyK0pCaDFvTTV2?=
 =?utf-8?B?eE5PSlZmZEYyTnkzUnVrM3VLTDlPZmtuOGNHL2pxeWFuSzdlNEJGUlMvaUtM?=
 =?utf-8?B?OFQrbzdIelVMV25xSlpMR3JYclREUzdqSDk3QnUvNFpUb3FORFdZOGhxdmpK?=
 =?utf-8?B?UkszM3dyeWhUejZMRCtsU0JXN3l6b1BtZFFKR054NmxrUmtYWlMydmtqK3R2?=
 =?utf-8?B?ZW12OG0ydnRuRVk4TXkvQUpnVHFuUHVOb29sLy94cUZnR3F5UWJET2FlS2R5?=
 =?utf-8?B?cTNFRWZ4R2MwVUo0aUtCOTFjSzFrbCtDblZYemJnZEdCRFlVS1J4TS9iVjhB?=
 =?utf-8?B?R05HQW5tZDV1R1hWS3U1amNMREdnYUM0b2lOVThOZ2ttNjNIVXd6K3p0TFlM?=
 =?utf-8?B?KyswcE1ncyt0Mm5UdnhLRGIrb1EyOUFPeHNyWjh3TTA5STZqOEZRMk12b1J0?=
 =?utf-8?B?QmYybGhUc2t5TDNXemY5L0Q4dHZkL1pEYjRCT2Nlb24zdkRCZlVRVVJIM1Jq?=
 =?utf-8?B?Q3RzeDRhNU5jODR3b3Q3TDZuSXBqM3pTQXNHUUxmRXdWVm1rVExhVHR0NVJv?=
 =?utf-8?B?NldlUUl1ZzJZK0hKNHhGUlF4OGJ2UU11UFQvYi9UWGhES0RwOSs0YXNMc3Zj?=
 =?utf-8?B?anh0ZU1MdEp4T3YwSE1DL2FleTR0MXlzOTFPKzFzbXpvTi92MTE0dU1qbytC?=
 =?utf-8?B?aEdlTU5ZWktFOVlrYVNPQm9ZNmNLeW1IT0NyZy9YcTJoYk1Xei9OZGEzNytw?=
 =?utf-8?B?S3dxUWU3VkRuMWQvc09TYm1ZeTVvTmZkOCs3UkRKRGJ4dGNOZ3FjVEg4SFFW?=
 =?utf-8?B?a2NaMTBOMEhmNnM1NmxoMGJnL2lTQ0dBSU12RVN3QUJJRStOdlp0dHdTNlpY?=
 =?utf-8?B?eDlXSlV1YnJ4YU4zNmticTMzSHR4Zzg2dU9FajBPMnE0VGpGYVdpUFRjVG9n?=
 =?utf-8?B?cExQY3hJZ3MvaWE4ZmtoaXlrcEMrOUlIbmpUUDhPNVlML3J0dFFPUm1XR3FO?=
 =?utf-8?B?dWdGc3h3cWdkRThjSmd5ZUhteEFKUEJKeVNIQmdqMm1MRnhJUUpqMlBmMHdK?=
 =?utf-8?B?cUE0aytEdzVVcWdRSjhBK2pCNGRBZGRmdE9TbytoeFlMMlVFVnovejdxN0FB?=
 =?utf-8?B?dG5NZDFrM3FhSW1uUVV4YnBrMXNmdEFPdHMvRjhFNkw5QWNUa1FxS2xTeFVC?=
 =?utf-8?B?UlVmbHQ1YlRiTklFQkk3N0RoSlEybTdueWZyMUxNUm1VOVNML0NqcFJjd05r?=
 =?utf-8?B?ZGdnTWh0MHc1d3FoM3hVMkwrWGd5ZnhrN1JGdDN5TTFPbWl4Z0VtcWZ5VC9n?=
 =?utf-8?B?STRZZk9pNTZtQVRnUm5ZV0o1ZDE3K3VOVVRwZFgwcnk2bUoyaG5zUnVqTy9P?=
 =?utf-8?B?NExoRTlCUEdCd21pRTFDeEZpRFlMa1pPZzQwNC9CbktLbXVabCs4WXoyY21v?=
 =?utf-8?B?ZmlJWGRubE1Bdjhra1EwT2ZvVEU0RGxqRUxlNUh0ZHhlZmlvMEU3U29XeHAy?=
 =?utf-8?B?eldhbFp2anluSThFQ3Q1aldNc3lUMlFMczd5QzlTWGgzMU9yRGlPNDkvT2Vz?=
 =?utf-8?B?TEFXNURTelJ2eDJ0UGNwWFpxWU5NUnhmRUpQZnBwMDZIeVRvNjlpdFk2VWp4?=
 =?utf-8?Q?WkSc/L5ZCZuCOhQ5OV8UMHDanCzdDa166mnPQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGpLSUhJWGJCeVNsTFlUS2RmZkVLeit1RHRtSjZkMWhkNWxQVTJqRlBwZGxY?=
 =?utf-8?B?bWpPSFVLV2NteFUwb3Z4SUxZNU5pc1loNHo0VmIvQ3FYZm52M25VOVpyc0VM?=
 =?utf-8?B?SjUxVFY3dWUzVkFaaFJ2aGNKclhocFZCSGpFMHh2M3RhMVdQOG44WlFBTWgw?=
 =?utf-8?B?NmRYbmFMZ3FIUzRTOCtVbXZna1l0VC9XTmZuRlhYbzVJTFRHcFpxNFZKaGQr?=
 =?utf-8?B?OVBsZnEzUXF6ZTZnaHlOdEQxUkwyZUg1NjBOZzJxRGN4MGtQM1pxeE91eDZN?=
 =?utf-8?B?V1V3Z0xYSG56ODVseVpXL3grSG5ydExLTm9Yd3h3R2xTVjN0YWRTQjFRVFdZ?=
 =?utf-8?B?aTVBcVY3WCswQmhZbmdCS0JsenA3L0UzbURmWDlrRlkrb2N5Qmd1U3BEV3dE?=
 =?utf-8?B?Njl1b1NuWGZPV215UWU4ZTIwSm8rWjN6Qkh5anBoWVB6cUhkZE4yNUJna0k2?=
 =?utf-8?B?Wjh2WXVSRnphbnQrcXYvaFUrTXVYYUhadFF5ZG1jOEtZSitqbWNDbFFMZmtn?=
 =?utf-8?B?R3pRa1pBMXoyS2VHRi9XeFd3UVVjM1pGUTUvQS95S3A1TTBvUkE3ZmZZa2M5?=
 =?utf-8?B?L1hzRzMvMGVkbENsNElKTXNLOWp2MmdCbS9HRXd6SjF0cGVydWEvZHFnSnN2?=
 =?utf-8?B?bWc3NEZKTkNmU0NkYW1wQ25LYlR0OUM1cStLWVpTVm15THA4NGFuL09hb2pK?=
 =?utf-8?B?TjVCcytHZEVkVm1IeXc3YmtBRnhtbFA3NFNkYnBiYTlKR2xPODliTDBOYkI1?=
 =?utf-8?B?cHQ2YUtFeHljRzJVK0FMV2lZNjVOYnU3MUdBUTZHeTR0K1BMellOWkVvSzNt?=
 =?utf-8?B?MTVWcmp2a21sd2ZrZ2NiaW5HZ3o2R2tBNks0MWNpTkZzNERKNUNla1BVY2hI?=
 =?utf-8?B?bWlsUU5RQllJUDNsMThKeEdydDc5U1ZoZklNaFZYVElhMmplTXJFR1FQazQ1?=
 =?utf-8?B?NzlRWHZZQkxKV2RPWlF0MkZ0K1kwTktoRTFERTZ3QkxyT2VvdThMdlhWMFJj?=
 =?utf-8?B?UHJTYkdCbmtJUW1oNGtROWNQdGU4UDcySkRiWEpSaGJOVXV5MVZWRGswYWN0?=
 =?utf-8?B?Yk1IWVJ1LzF1MFZhSHRjUXo5TWs0U2pvOEI5SVJRSER6aTNCOTBMYlM2YzM3?=
 =?utf-8?B?S3lvUkZzN09GbXcvWUpPb0NmYURVUGEyUTh1Q2hsR0RuVjlzL3E1MUt5aDBa?=
 =?utf-8?B?MEdSWDRiYlVoM2FiNXh0Z0NNaWhUbGJyUTFJamdRMDluWWNYcUtwUWlJSEYy?=
 =?utf-8?B?ZXRZZDBIOXNyRmpzdVRDOFE4azJnOC9ta21nbGo3VXZVUjRhVGtlRmJscVNo?=
 =?utf-8?B?UFI5R3lwaGgrQ3pUTk40R0c4OFk5OFFSSGxaaUZJZXRxWm8vcWJvYmZLRXJi?=
 =?utf-8?B?cGFaUnNONlp6TmJUblNqMEFxY09JRmIxOGsvVWE3MXBoVnJGd1RmQndrTGFX?=
 =?utf-8?B?d3A5MUJScFp4c3BPMCsvaGd0M2R0SjVseEN2SXNTY0Jrd2tRcDN1U0dzOHQw?=
 =?utf-8?B?R1dLQTFmSHp3Q243SzNpbHlXTkoxajRGd2RwZ0VLWGJFekVhV2Q1SGlTWU1k?=
 =?utf-8?B?NjlXN0xzUjk4dC9ZZ29WQ3R5NVVrTC8xTXlWYnBqVWlFRU94aHZDaStSUGo0?=
 =?utf-8?B?VWlFUVJUeEozZGJzNzlpaEorRDJIcHgwbDRGWExjZXFQdjJ1ekdWQWVJY1VJ?=
 =?utf-8?B?dEQ5MFBCRFlMV1ZEM04rYmlMbnh3VmkwOXZQV0JxUUwxeGRyU2p0UHNIY2xp?=
 =?utf-8?B?YUp1V3Q3L2IxRnB6SHZnWC9TL1hYVE1IMkdyYTN0N2Y5QlNvWFQ4M0VFUXBt?=
 =?utf-8?B?aTlQTEd5aWErbmplZlVzdmYzRkRwL3p2VEVORTJnZ0NIVmo4OEFEZVpPL2x1?=
 =?utf-8?B?RVFtdGpqaWh2MEE5ak5vSk54UEVNUFJmcnJQaTh0em5XQkU0bTRPVU43ZnRP?=
 =?utf-8?B?TDdFT3VUVUxMN2FVTkl4cHVrVUtVcHE5SmM3YkZydVdsbDRSMDhqL05jR0lm?=
 =?utf-8?B?VFdLMlR0b25RSHQ1SUtEZnJlVjFPVEN1eUpzU2RiWEZlb1hmU1pGYWZWWjdG?=
 =?utf-8?B?R2NMWVlEU0dCUlZ6cENJZFFuVWFvVTRreGdHcGZVT1R3N1dlUlVoNDRPdCtY?=
 =?utf-8?Q?Uc9IVdUFRptRCzVE2fOC28Frn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd28d8e6-6a4f-4125-dab5-08dcfef3b420
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 06:16:23.1970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0x1bEVtR5p72Qal0jaxsOnXs7cQSdvVJ2L4c9yXaBx0nJCWjCuoEdyj/8URYzLu1TuqqJbD8y5KzOXUdonEYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8687

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTlubQxMeaciDfml6UgNjozMA0KPiBUbzogSG9u
Z3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGt3aWxjenluc2tpQGtlcm5l
bC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207
IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgbWFuaUBrZXJuZWwub3JnOw0KPiBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsg
aW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBQQ0k6IGR3Yzog
Rml4IHJlc3VtZSBmYWlsdXJlIGlmIG5vIEVQIGlzIGNvbm5lY3RlZCBhdA0KPiBzb21lIHBsYXRm
b3Jtcw0KPiANCj4gT24gV2VkLCBOb3YgMDYsIDIwMjQgYXQgMDE6NTk6NDFBTSArMDAwMCwgSG9u
Z3hpbmcgWmh1IHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+
IEZyb206IEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IDIw
MjTlubQxMeaciDbml6UgNzoyNw0KPiA+ID4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1
QG54cC5jb20+DQo+ID4gPiBDYzoga3dpbGN6eW5za2lAa2VybmVsLm9yZzsgYmhlbGdhYXNAZ29v
Z2xlLmNvbTsNCj4gPiA+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IEZyYW5rIExpIDxmcmFu
ay5saUBueHAuY29tPjsNCj4gPiA+IG1hbmlAa2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2Vy
bmVsLm9yZzsNCj4gPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4g
PiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsN
Cj4gPiA+IGlteEBsaXN0cy5saW51eC5kZXYNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJd
IFBDSTogZHdjOiBGaXggcmVzdW1lIGZhaWx1cmUgaWYgbm8gRVAgaXMNCj4gPiA+IGNvbm5lY3Rl
ZCBhdCBzb21lIHBsYXRmb3Jtcw0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgSnVsIDIyLCAyMDI0IGF0
IDAyOjE1OjEzUE0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+ID4gPiBUaGUgZHdfcGNp
ZV9zdXNwZW5kX25vaXJxKCkgZnVuY3Rpb24gY3VycmVudGx5IHJldHVybnMgc3VjY2Vzcw0KPiA+
ID4gPiBkaXJlY3RseSBpZiBubyBlbmRwb2ludCAoRVApIGRldmljZSBpcyBjb25uZWN0ZWQuIEhv
d2V2ZXIsIG9uIHNvbWUNCj4gPiA+ID4gcGxhdGZvcm1zLCBwb3dlciBsb3NzIG9jY3VycyBkdXJp
bmcgc3VzcGVuZCwgY2F1c2luZyBkd19yZXN1bWUoKQ0KPiA+ID4gPiB0byBkbyBub3RoaW5nIGlu
IHRoaXMgY2FzZS4NCj4gPiA+ID4gVGhpcyByZXN1bHRzIGluIGEgc3lzdGVtIGhhbHQgYmVjYXVz
ZSB0aGUgRFdDIGNvbnRyb2xsZXIgaXMgbm90DQo+ID4gPiA+IGluaXRpYWxpemVkIGFmdGVyIHBv
d2VyLW9uIGR1cmluZyByZXN1bWUuDQo+IA0KPiA+ID4gPiBAQCAtOTMzLDIzICs5MzMsMjMgQEAg
aW50IGR3X3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZHdfcGNpZQ0KPiAqcGNpKQ0KPiA+ID4g
PiAgCWlmIChkd19wY2llX3JlYWR3X2RiaShwY2ksIG9mZnNldCArIFBDSV9FWFBfTE5LQ1RMKSAm
DQo+ID4gPiBQQ0lfRVhQX0xOS0NUTF9BU1BNX0wxKQ0KPiA+ID4gPiAgCQlyZXR1cm4gMDsNCj4g
PiA+ID4NCj4gPiA+ID4gLQlpZiAoZHdfcGNpZV9nZXRfbHRzc20ocGNpKSA8PSBEV19QQ0lFX0xU
U1NNX0RFVEVDVF9BQ1QpDQo+ID4gPiA+IC0JCXJldHVybiAwOw0KPiA+ID4gPiAtDQo+ID4gPiA+
IC0JaWYgKHBjaS0+cHAub3BzLT5wbWVfdHVybl9vZmYpDQo+ID4gPiA+IC0JCXBjaS0+cHAub3Bz
LT5wbWVfdHVybl9vZmYoJnBjaS0+cHApOw0KPiA+ID4gPiAtCWVsc2UNCj4gPiA+ID4gLQkJcmV0
ID0gZHdfcGNpZV9wbWVfdHVybl9vZmYocGNpKTsNCj4gPiA+ID4gKwlpZiAoZHdfcGNpZV9nZXRf
bHRzc20ocGNpKSA+IERXX1BDSUVfTFRTU01fREVURUNUX0FDVCkgew0KPiA+ID4gPiArCQkvKiBP
bmx5IHNlbmQgb3V0IFBNRV9UVVJOX09GRiB3aGVuIFBDSUUgbGluayBpcyB1cCAqLw0KPiA+ID4g
PiArCQlpZiAocGNpLT5wcC5vcHMtPnBtZV90dXJuX29mZikNCj4gPiA+ID4gKwkJCXBjaS0+cHAu
b3BzLT5wbWVfdHVybl9vZmYoJnBjaS0+cHApOw0KPiA+ID4gPiArCQllbHNlDQo+ID4gPiA+ICsJ
CQlyZXQgPSBkd19wY2llX3BtZV90dXJuX29mZihwY2kpOw0KPiA+ID4NCj4gPiA+IFRoaXMgbG9v
a3MgcG9zc2libHkgcmFjeSBzaW5jZSB0aGUgbGluayBjYW4gZ28gZG93biBhdCBhbnkgcG9pbnQu
DQo+ID4NCj4gPiBXaGVuIGxpbmsgaXMgZG93biBhbmQgd2l0aG91dCB0aGlzIGNvbW1pdCBjaGFu
Z2VzLA0KPiA+IGR3X3BjaWVfc3VzcGVuZF9ub2lycSgpIHJldHVybiBkaXJlY3RseSwgYW5kIHRo
ZSBQTUVfVFVSTl9PRkYgd291bGRuJ3QNCj4gPiBiZSBraWNrZWQgb2ZmLg0KPiANCj4gUmlnaHQs
IHRoYXQncyB0aGUgY29kZSBjaGFuZ2UuDQo+IA0KPiA+IEkgY2hhbmdlIHRoZSBiZWhhdmlvciB0
byBpc3N1ZSB0aGUgUE1FX1RVUk5fT0ZGIHdoZW4gbGluayBpcyB1cCBoZXJlLg0KPiANCj4gQnV0
IEkgZG9uJ3QgdGhpbmsgeW91IHJlc3BvbmRlZCB0byB0aGUgcmFjZSBxdWVzdGlvbi4gIFdoYXQg
aGFwcGVucyBoZXJlPw0KPiANCj4gICBpZiAoZHdfcGNpZV9nZXRfbHRzc20ocGNpKSA+IERXX1BD
SUVfTFRTU01fREVURUNUX0FDVCkgew0KPiAgICAgLS0+IGxpbmsgZ29lcyBkb3duIGhlcmUgPC0t
DQo+ICAgICBwY2ktPnBwLm9wcy0+cG1lX3R1cm5fb2ZmKCZwY2ktPnBwKTsNCj4gDQo+IFlvdSBk
ZWNpZGUgdGhlIExUU1NNIGlzIGFjdGl2ZSBhbmQgdGhlIGxpbmsgaXMgdXAuICBUaGVuIHRoZSBs
aW5rIGdvZXMgZG93bi4NCj4gVGhlbiB5b3Ugc2VuZCBQTUVfVHVybl9vZmYuICBOb3cgd2hhdD8N
Cj4gDQo+IElmIGl0J3Mgc2FmZSB0byB0cnkgdG8gc2VuZCBQTUVfVHVybl9vZmYgcmVnYXJkbGVz
cyBvZiB3aGV0aGVyIHRoZSBsaW5rIGlzIHVwIG9yDQo+IGRvd24sIHRoZXJlIHdvdWxkIGJlIG5v
IG5lZWQgdG8gdGVzdCB0aGUgTFRTU00gc3RhdGUuDQpJIG1hZGUgYSBsb2NhbCB0ZXN0cyBvbiBp
Lk1YOTUvaS5NWDhRTS9pLk1YOE1QL2kuTVg4TU0vaS5NWDhNUSwgYW5kDQpjb25maXJtIHRoYXQg
aXQncyBzYWZlIHRvIHNlbmQgUE1FX1RVUk5fT0ZGIGFsdGhvdWdoIHRoZSBsaW5rIGlzIGRvd24u
DQpZb3UncmUgcmlnaHQuIEl0J3Mgbm8gbmVlZCB0byB0ZXN0IExUU1NNIHN0YXRlIGhlcmUuDQpT
byBkbyB0aGUgTDIgcG9sbCBsaXN0ZWQgYWJvdmUgYWZ0ZXIgUE1FX1RVUk5fT0ZGIGlzIHNlbnQu
DQoNClNpbmNlIHRoZSA2LjEzIG1lcmdlIHdpbmRvdyBpcyBhbG1vc3QgY2xvc2VkLg0KSG93IGFi
b3V0IEkgcHJlcGFyZSBhbm90aGVyIEZpeCBwYXRjaCB0byBkbyB0aGUgZm9sbG93aW5nIGl0ZW1z
IGZvciBpbmNvbWluZw0KNi4xND8NCi0gQmVmb3JlIHNlbmRpbmcgUE1FX1RVUk5fT0ZGLCBkb24n
dCB0ZXN0IHRoZSBMVFNTTSBzdGF0Lg0KLSBSZW1vdmUgdGhlIEwyIHN0YXQgcG9sbCwgYWZ0ZXIg
c2VuZGluZyBQTUVfVFVSTl9PRkYuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiAN
Cj4gQmpvcm4NCg==


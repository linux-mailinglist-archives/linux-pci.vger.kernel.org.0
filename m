Return-Path: <linux-pci+bounces-14260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07F9999DA8
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 09:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CCA1F24167
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 07:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7AE1EABDC;
	Fri, 11 Oct 2024 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V8SSvZkG"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C76933F7;
	Fri, 11 Oct 2024 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630977; cv=fail; b=dmhhxt2UBvCmO5Uo4hDWSAWoBUjQ5LN1kJNBPrOiQCyZ9oIOh+suK/D6lLXu8d+7HxmjnYBdqiShDmtCTpP+YZHDx6xHSuYm81EhRfpZOJ+apjUR4zyKyO7RCqRzhNm6CnnhxzcVcuhRkKD5dzf/oxeCi0NbnLu6tO+orZidzcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630977; c=relaxed/simple;
	bh=fVDLVhiJSOHqlSeUApQtNIDsaZHzV+OmQ74fFn1QAvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jTB66GYW+r9oKsj/Z3622X7IvZhTzDc36fkY5VWlKrXLeUKmjVQ+l8LAA9bkg1PTsa7Lt5MiVAswo1lBNfj9K1Vd5R7RJpdH4UVykuNCgbGqCfv7mRuZC8pq5aCaRlRTf3DGmmIOfKs6x5xjEWlNhwOJEiQQXy00cybglfOqCWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V8SSvZkG; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVnF+uX44xJ2bRAksZ263B6B8u4dEmQs03r0T3/6cweIPwGXfJUw8uX0rWzuK7vLlURnz7ngqT0zKGCGmj/VdOxW+XZFk0AUoEuGDB/C5FFZBzXBMzw/+/4ERYZLuue3WCYDbF+c/ULhsIwzIRzmkNwknwpqIHhQsDdoKXHTHA0nY0BLPXhG/t1MiRNrXj287NkIiWKribFvGeIFbzyvSD0XfeMtKmIpjF/mNka00xO8TrPjx3sAuAfV6Qjze2Ar0B0Hg4sAK1V8xFCXKz5q2ugJwRvoNzzrHRSW9kNpj03aSSZPRPXAV6asDNhMcGHayKtIi5WAqFV18snnHCtO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVDLVhiJSOHqlSeUApQtNIDsaZHzV+OmQ74fFn1QAvQ=;
 b=s5RNOrVOc/T0DvuMPBEgy8blXnkuGe7DTs6nB62PbZsZzuBB+0hLGOyMQlGlh4WHPyYSzlm8SBC94JI7cVME7ekVDwBso3D2VS8OSuqW/1+Ht1tY4+yDer8Xhs1nv3hDvt7HO+UM/eVvQ1LBXrBw2KDwAInzPu2r3wyLfZqeFgTmMpka/tfTDdQV5+Wsb5xPzrde+PD/oiSkyMmpVGQ+xT7F92BFKS/7lUVXcYU69aJzuWlaBHsizWnnjsVf/cA1DbCV/tdB5Jd3aaaA86AxdrmgyR9OoFsDiZJRIlR/0csIXpWccJt3xI1QiA0lf+Yc8QRBMHr52gj0pLnI8bVTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVDLVhiJSOHqlSeUApQtNIDsaZHzV+OmQ74fFn1QAvQ=;
 b=V8SSvZkGrPml6P7HNvie4NtnIvNN/fiILdR02ObkhQG3A9t9iZrfaNwQzE8LyMrxlnuQlXBxAdJANY+N/mgLCXB3QohGAIznHX2aAyq4EtfJ3zutj6klk8AUb5WMshJkP8B4hlSfGuKB8WEaqYWvSocvz/u7TBbTSnvLjMgKnkc13wFBJZo09nz9oXi/NONPDyTtnw3Ab6MGm+G+k9aWaRJ3QdAiGmb83axbEYeywT6YechQTHHQclZp8cfAm6d8AvL6z3Tlml02N+U09LDsupL/Po2Kr7g0KDVXXweeIR5fR8wQ8j3CI9q7e+9vrL6pTRXFViw35faoxSqJ+rgcrw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10286.eurprd04.prod.outlook.com (2603:10a6:800:21e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 07:16:11 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Fri, 11 Oct 2024
 07:16:11 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH net-next 10/11] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Topic: [PATCH net-next 10/11] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Index:
 AQHbGjMCRp6WYylLaEyKPUuJKhwhaLJ+sHIAgAClOHCAAMZUgIAAsT0wgAAluQCAADHJ8A==
Date: Fri, 11 Oct 2024 07:16:11 +0000
Message-ID:
 <PAXPR04MB8510C470D0CFB89EB618580888792@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-11-wei.fang@nxp.com>
 <ZwbANHg93hecW+7c@lizhi-Precision-Tower-5810>
 <PAXPR04MB85100EB2E98527FCC4BAF89B88782@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <ZwfxK+vm2HCXAKHG@lizhi-Precision-Tower-5810>
 <PAXPR04MB85102605C8B2FCE52783BD5288792@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <ZwilfpoFFHgcVr4K@lizhi-Precision-Tower-5810>
In-Reply-To: <ZwilfpoFFHgcVr4K@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB10286:EE_
x-ms-office365-filtering-correlation-id: 6d8440af-f56a-463c-f248-08dce9c495e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZmxlamV2Nm1yNVFDY1hWUC9rUldoUEYwejc5MzY5N0x0R0RTQnJ1ME1IVGN2?=
 =?utf-8?B?Q0ZaWDRvQXM0VnFKVURDb0RqSVFwTFNMQzBwNHNVRU1GU2hpWjR2NXN6QkdO?=
 =?utf-8?B?TUR1Nk91cWRTNmlSeUFrMjYxNTV2SWNXN0Uyakp6dUMyNmR6ZSsrT3hZNWh1?=
 =?utf-8?B?V1BNYmxYTnpENGoyWXVBcDRUUEZkTWVRaEx3ME5KNHdBRGxXUEtabVh0MkFO?=
 =?utf-8?B?S3pnTjZXMm5VRithVFVHaCtscTRmUTNnMitLSExUZWpuR1JMcm13cUtCK1Jp?=
 =?utf-8?B?bWl1M1JtZGlnbVdSNkpQVnI2R0xpUlljQ2VCcGxmZ0tBbWhkOElmQTUrYXdm?=
 =?utf-8?B?UHZ2M3pjWVhQY29QUGJJL2VELzYvRWZRbUthMXpUcmtHZTE2OU0vTjc0bExO?=
 =?utf-8?B?c2hRV1dMenFtc0FiY3pzOG9tdzhHNnFKWFlVVS9uMTJMb0d3elJaU3hRc2xT?=
 =?utf-8?B?dkF0RWZyazJFa3lTOWg4TklVcXNmU2JBWW9oemE1UTJVR2haUHA4ODBJcGph?=
 =?utf-8?B?SUR0K2JZOThGbjNvMmU1OFRIV2tFK05mQnpwVXFodWxFREFaWDQ4eHQ2Rms1?=
 =?utf-8?B?U3ZLOXJmWDZJWkkrWnlxVVltcWVhdlJRL2QvekVRMkl1VEl1cFFrdUhEMXU3?=
 =?utf-8?B?Nldzd2F0OGxNMVNqcXdsUDV5NzBvRmdIWXVkYXNUczRjWFVDcXFJUFhId0tN?=
 =?utf-8?B?ZjVEZHZUS2J2bDJmNFMvWmRWQ3ltMURvQjgxbnVmbTBDTldxdG0rRlgwT3ls?=
 =?utf-8?B?NkNlMXpVUDF2SldWbHF6RERCZ0tUSDVINTluK0VqYnNaRnQxNVh4U0xaaWE5?=
 =?utf-8?B?LzAwMm1BWFJWaFRLYkxKOUF6SnZ1TFFGK2x4YmZiMUtZQlJkMDBPcVcveUNo?=
 =?utf-8?B?TEJtZFFnd2RZSTZhN2tJRXI5Qkkrb0pRdzg5cXhKRmlSQkhMVlY4WE42V2hC?=
 =?utf-8?B?dTR4QnBXNUYxTHFjV0FVRE1oNjFzUHVHMUpjTVRJbnhqNkwvSkRvR3pnVEZq?=
 =?utf-8?B?SW4vTEM5SEoxVU45V3hqMHhXNEhqSkRMa3oyVjlSR3NpUlJEL1hHV0xob3hC?=
 =?utf-8?B?RnlqWWsyT09Wb3IwdVBTaUE4ZXpsSVVPbjJxT212SjJGVnBhRjFwcmZLd3d1?=
 =?utf-8?B?TUQ2UnpqNEVZT29lVDRDdHdHSjdYQmVaZkszQzZGWk51QnJKREpwY2JFeWJF?=
 =?utf-8?B?UGpkOHRIaStmZlMzWUNOUVlpVWN6RjB1QmRUNWpDNWpnemZITHZjL0h0Zm9C?=
 =?utf-8?B?WGdwZ1h4SzBkRVY3b2hVdHBrdUYzb0U5eVkrZ1NLdXNvMm5RdmZ0ano2Z0FE?=
 =?utf-8?B?Wndsd2RlOFdEVU4zb3d5VDEvU3F3YlU5NFg1TVFXZU9yU2p4R0pqTDYxdWVE?=
 =?utf-8?B?UXgxa2xPRTE5Qkwzb1U2eXkva1BUbWZQT1kveW1YclR5SWdHcUVQK3B2REhS?=
 =?utf-8?B?aWY3Q09DeWZUVzlnUk9rZjRScXpINFQ2Njg5K2YyYVNBc1NveHBXYThSMVJQ?=
 =?utf-8?B?dmlpL2xiaDV0VElDOUNhVlVUVVVyTnprL3J4ZlJ2M3VVYWU3USs1NWxOWHh6?=
 =?utf-8?B?V3c2U1FtV0twTXBKZzNacEhsd3UvanI3NUNyVUYxNGMrcVhubHE3VGh3VElW?=
 =?utf-8?B?bEhIeWZqdjROTUZFZTRRQ2Ntdy9vVEhua3VmSytvdmVtWjM0V2JURTZzdzdu?=
 =?utf-8?B?NHlKUDB0RlIvV0JCdm03UUl2enVTbDdTZFJHNTRLa1FOazg3L0tFN05qdkda?=
 =?utf-8?B?UDU1TDFEc3ptTlBWd1FLd285MmE2bjNlSWRMMlQ0cEhzNitvdllEWjlDRWFD?=
 =?utf-8?B?S1lwRXprejV5U2UxT0NNZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEt3RlJQR0VQS3BoWkt6MHpqV0dNQStMRGd4RGVRTWo2N1FKTUZUdHhYS2pj?=
 =?utf-8?B?cVZyeU9mWWtaclFyWTIwZzc5Z2R5Vi9mVDFJMGtnUTRyaHNhU0hWcFV6VjF0?=
 =?utf-8?B?N1hEV1cwbUJUYlNYZHRDVzhTQ1QvdnZ4MndmZHVJeWd2YlgvNmZsMVIxK0JX?=
 =?utf-8?B?THlIR01jRHRXaHZTMjBnc0F3UWVvUUFqaktsbVpEYlpqYjZEVG1LTFh5N3ZV?=
 =?utf-8?B?RE1RNFlmUnh5Um1ZcXJlUE9vOHhlRCtuMHltdTJ0QUQydy95VlhzU3RSWkxt?=
 =?utf-8?B?MjU1M2NkWkR4aXN6STQzbW00UE5LYmRLQzhLOFY4Y0FvendJZVBpSVJtd2NR?=
 =?utf-8?B?MFFpL1hoOVN6Umlxb3BqSzhneGh1S2pLYndjZWhCWlROSHhTRDRvSUFxME9H?=
 =?utf-8?B?b0VTVU5YUFpyWEdIbGU5QlQ0ZDNFTSt5ZTlGZE42VlArMWpDVHZOTEpmYlBC?=
 =?utf-8?B?ZFZvbEVPRXpRSHBDMklreDFTMW9iMnFHaTVPZHh1MkplZytrZVRwK1hSZUVF?=
 =?utf-8?B?RXk2eURyaG91V0FnL21zZHkxVGR6bWNVcFNyMTNCelA0NXpmZlc1TkJWV3Fm?=
 =?utf-8?B?LytOTkZTQXVWWGhITE9xQUJrYiszRHdtd2pEbHY0YUVRdUE0NnY2c0N0TjQx?=
 =?utf-8?B?dk5qc3ZkQk5CSUprSXJ5WHZxZ2dIeStMMGFPZ0owajY3aytlcjcxM3JQQWRB?=
 =?utf-8?B?QmxlaHB2eWwxcm1IYUl2Uk96YWVMZCtHd09sakYxZ3hrYzBONjNwcmVqRkt6?=
 =?utf-8?B?OFZmRWZMQzZTdUpGQmY0UG9iVjYyTVdaYVV2MjVJWW5FdldwL2p2SUFZOEFo?=
 =?utf-8?B?alYvQW1Sdk53K3QxdnZneTd4UlVuRkNaNTV6K0tGVW9EdkdPR3pQYzR0MU9q?=
 =?utf-8?B?VGxmOFdKbFR1alRLSXVmY1B5c1o1K2NURElDOXRlY3UrWUZBc0w5VjQxdjhh?=
 =?utf-8?B?YlZGZUo1QkZTbW5NdmxqTVVITG5DbS9EN3NpOGtRcUZiTjk0Z0N0NnlCVmIy?=
 =?utf-8?B?TGVKVmxnUVVCRFc3UFExaG90S3U3eFB2ekVtWDArN08yN2pwcjAzZk0wNnB1?=
 =?utf-8?B?Z2FOOU44L2dqM3BSRER6cGowTjI1Q2xSdGk0eHExVGpsT2pmRmFWek1iN1hG?=
 =?utf-8?B?TXRrOGFEL1NiaUpZRmRreTlIcG9uTDJzTkpGa05MOVBCWmFYK1M5dXM3VjBa?=
 =?utf-8?B?c2ZVY3lVRnFRQkJCc1B2UURFSlNiZkdKaklTOFBiUnkzNlpKSklDQTBWR3c2?=
 =?utf-8?B?RHdXcDhGUEZzZTFjS1FORENZcmRRWGhrM2hFRnZUUGtFb29aY0hNcFgwRXFn?=
 =?utf-8?B?NU5Qa3VSL1pVTXdHeGFVdS9Ha2g1WjJ0STdyeG1QSGNSMEduR29iZlowS1VT?=
 =?utf-8?B?NWtNZG9hVmY5blU4NU9nb2dCVnB6YUVHUHNxSnM4MjEzdDNQb0NnR2wwTDhk?=
 =?utf-8?B?V0JuVlJGN0hiUTk2d3RnNGpUNlgyQmU2cUNLcmVvYjlHSHl5cFhCcDd1WVE3?=
 =?utf-8?B?TU52dm81OENud3JEdVJoYzFyNFlIaXE2dDlDSU81NmdTd1Z4UFgwY0Y5VElC?=
 =?utf-8?B?QXMwUXZlYzJoY0RMZi9IT29uRWU0WE9SZ0tMSlcxTjdMOFVWV0s0OXQ1TU5L?=
 =?utf-8?B?UzV2U2hpQ3g2alFEems1L3NiM3pSTlNwcVI1QWlscDRpT0UzQWQ3L1BZR0VQ?=
 =?utf-8?B?ZEkyQUNmRjVRQUJWSUN4STFQZm9nZnZQeUVwZ0JNclJjSFFpb21EazNKVWdF?=
 =?utf-8?B?Wk5RZHIxWWMzTU51SE1aelRVYlRXYSszNmRtQU1jeUdmb3dJT0RqRFNRN0F0?=
 =?utf-8?B?ODJQSmpQK0g4Qk5lRmw4TkhWcCtVWG04cExqSW50UjhBbEUzQ3o2TWIwVFFR?=
 =?utf-8?B?bGdkUDc4YUkrQVk0UWhNR2JkQXRQajJ6bExxNkF4ZlJGQlQwSnRJYWhzREVL?=
 =?utf-8?B?dUlSbGlUbkpnWk5JTittZUZ3bWZxSUhZN3Q4RDdmVnJvbUJuUmpQK1huZEFL?=
 =?utf-8?B?SXBHUWt2QjJjZ3E1U3l2Uys0bzlaRExvLzN3RXhGN3ozUW9oVjZTSDNIOUVO?=
 =?utf-8?B?MkxXeVhURGJtK2JSVkV5dXJnMUMvbTZkTElBKzZMWENQbEVOK0NJSCtIcFYz?=
 =?utf-8?Q?gL0w=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8440af-f56a-463c-f248-08dce9c495e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 07:16:11.7665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpX3DlHs4ToWf8tnlO2Vu+iBLY5AqKLggUZl9v9cb+hK0PB+On3UGD39Bqd+JFFIfohJ8cUUCmelXbOJpwOkOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10286

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNOW5tDEw5pyIMTHml6UgMTI6MTINCj4gVG86IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRA
Z29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgcm9iaEBr
ZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IFZs
YWRpbWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+OyBDbGF1ZGl1DQo+IE1hbm9p
bCA8Y2xhdWRpdS5tYW5vaWxAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhw
LmNvbT47DQo+IGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldTsgbGludXhAYXJtbGludXgub3Jn
LnVrOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIG5ldC1uZXh0IDEwLzExXSBuZXQ6IGVuZXRjOiBhZGQgcHJlbGltaW5hcnkg
c3VwcG9ydCBmb3INCj4gaS5NWDk1IEVORVRDIFBGDQo+IA0KPiBPbiBGcmksIE9jdCAxMSwgMjAy
NCBhdCAwMjowMjowM0FNICswMDAwLCBXZWkgRmFuZyB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT4N
Cj4gPiA+IFNlbnQ6IDIwMjTlubQxMOaciDEw5pelIDIzOjIyDQo+ID4gPiBUbzogV2VpIEZhbmcg
PHdlaS5mYW5nQG54cC5jb20+DQo+ID4gPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiA+ID4gcGFiZW5pQHJlZGhhdC5jb207
IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOw0KPiA+ID4gY29ub3IrZHRAa2Vy
bmVsLm9yZzsgVmxhZGltaXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47DQo+IENs
YXVkaXUNCj4gPiA+IE1hbm9pbCA8Y2xhdWRpdS5tYW5vaWxAbnhwLmNvbT47IENsYXJrIFdhbmcN
Cj4gPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47DQo+ID4gPiBjaHJpc3RvcGhlLmxlcm95QGNzZ3Jv
dXAuZXU7IGxpbnV4QGFybWxpbnV4Lm9yZy51azsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4g
PiA+IGlteEBsaXN0cy5saW51eC5kZXY7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQt
bmV4dCAxMC8xMV0gbmV0OiBlbmV0YzogYWRkIHByZWxpbWluYXJ5IHN1cHBvcnQgZm9yDQo+ID4g
PiBpLk1YOTUgRU5FVEMgUEYNCj4gPiA+DQo+ID4gPiBPbiBUaHUsIE9jdCAxMCwgMjAyNCBhdCAw
NDo1OTo0NUFNICswMDAwLCBXZWkgRmFuZyB3cm90ZToNCj4gPiA+ID4gPiBPbiBXZWQsIE9jdCAw
OSwgMjAyNCBhdCAwNTo1MToxNVBNICswODAwLCBXZWkgRmFuZyB3cm90ZToNCj4gPiA+ID4gPiA+
IFRoZSBpLk1YOTUgRU5FVEMgaGFzIGJlZW4gdXBncmFkZWQgdG8gcmV2aXNpb24gNC4xLCB3aGlj
aCBpcyB2ZXJ5DQo+ID4gPiA+ID4gPiBkaWZmZXJlbnQgZnJvbSB0aGUgTFMxMDI4QSBFTkVUQyAo
cmV2aXNpb24gMS4wKSBleGNlcHQgZm9yIHRoZSBTSQ0KPiA+ID4gPiA+ID4gcGFydC4gVGhlcmVm
b3JlLCB0aGUgZnNsLWVuZXRjIGRyaXZlciBpcyBpbmNvbXBhdGlibGUgd2l0aCBpLk1YOTUNCj4g
PiA+ID4gPiA+IEVORVRDIFBGLiBTbyB3ZSBkZXZlbG9wZWQgdGhlIG54cC1lbmV0YzQgZHJpdmVy
IGZvciBpLk1YOTUgRU5FVEMNCj4gPiA+ID4gPiAgICAgICAgICAgICBTbyBhZGQgbmV3IG54cC1l
bmV0YzQgZHJpdmVyIGZvciBpLk1YOTUgRU5FVEMgUEYgd2l0aA0KPiA+ID4gPiA+IG1ham9yIHJl
dmlzaW9uIDQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFBGLCBhbmQgdGhpcyBkcml2ZXIgd2ls
bCBiZSB1c2VkIHRvIHN1cHBvcnQgdGhlIEVORVRDIFBGIHdpdGgNCj4gPiA+ID4gPiA+IG1ham9y
IHJldmlzaW9uIDQgaW4gdGhlIGZ1dHVyZS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmgNCj4g
PiA+ID4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5oDQo+
ID4gPiA+ID4gPiBpbmRleCA5NzUyNGRmYTIzNGMuLjdmMWVhMTFjMzNhMCAxMDA2NDQNCj4gPiA+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5o
DQo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMv
ZW5ldGMuaA0KPiA+ID4gPiA+ID4gQEAgLTE0LDYgKzE0LDcgQEANCj4gPiA+ID4gPiA+ICAjaW5j
bHVkZSA8bmV0L3hkcC5oPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAjaW5jbHVkZSAiZW5l
dGNfaHcuaCINCj4gPiA+ID4gPiA+ICsjaW5jbHVkZSAiZW5ldGM0X2h3LmgiDQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gICNkZWZpbmUgRU5FVENfU0lfQUxJR04JMzINCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiArc3RhdGljIGlubGluZSBib29sIGlzX2VuZXRjX3JldjEoc3RydWN0IGVuZXRj
X3NpICpzaSkgew0KPiA+ID4gPiA+ID4gKwlyZXR1cm4gc2ktPnBkZXYtPnJldmlzaW9uID09IEVO
RVRDX1JFVjE7IH0NCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICtzdGF0aWMgaW5saW5lIGJv
b2wgaXNfZW5ldGNfcmV2NChzdHJ1Y3QgZW5ldGNfc2kgKnNpKSB7DQo+ID4gPiA+ID4gPiArCXJl
dHVybiBzaS0+cGRldi0+cmV2aXNpb24gPT0gRU5FVENfUkVWNDsgfQ0KPiA+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gQWN0dWFsbHksIEkgc3VnZ2VzdCB5b3UgY2hlY2sgZmVhdHVy
ZXMsIGluc3RlYWQgb2YgY2hlY2sgdmVyc2lvbiBudW1iZXIuDQo+ID4gPiA+ID4NCj4gPiA+ID4g
VGhpcyBpcyBtYWlubHkgdXNlZCB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIEVORVRDIHYxIGFuZCBF
TkVUQyB2NCBpbg0KPiA+ID4gPiB0aGUgZ2VuZXJhbCBpbnRlcmZhY2VzLiBTZWUgZW5ldGNfZXRo
dG9vbC5jLg0KPiA+ID4NCj4gPiA+IFN1Z2dlc3QgdXNlIGZsYWdzLCBzdWNoIGFzLCBJU19TVVBQ
T1JUX0VUSFRPT0wuDQo+ID4gPg0KPiA+ID4gb3RoZXJ3aXNlLCB5b3VyIGNoZWNrIG1heSBiZWNv
bWUgY29tcGxleCBpbiBmdXR1cmUuDQo+ID4gPg0KPiA+ID4gSWYgdXNlIGZsYWdzLCB5b3UganVz
dCBjaGFuZ2UgaWQgdGFibGUgaW4gZnV0dXJlLg0KPiA+DQo+ID4gZW5ldGNfZXRodG9vbCBqdXN0
IGlzIGFuIGV4YW1wbGUsIEkgbWVhbnQgdGhhdCB0aGUgRU5FVEN2NCBhbmQgRU5FVEN2MQ0KPiA+
IHVzZSBzb21lIGNvbW1vbiBkcml2ZXJzLCBsaWtlIGVuZWN0X3BmX2NvbW1vbiwgZW5ldGMtY29y
ZSwgc28gZGlmZmVyZW50DQo+ID4gaGFyZHdhcmUgdmVyc2lvbnMgaGF2ZSBkaWZmZXJlbnQgbG9n
aWMsIHRoYXQncyBhbGwuDQo+IA0KPiBNeSBtZWFucyBpcyB0aGF0IGF2b2lkIHVzZSB2MVx2MiB0
byBkaXN0aW5naXVzaCBpdCBhbmQgdXNlIHN1cHBvcnRlZA0KPiBmZWF0dXJlcyBpbiBkaWZmZXJl
bmNlIHZlcnNpb24gZm9yIGV4YW1wbGU6DQoNCkkgdGhpbmsgeW91IG1pc3VuZGVyc3Rvb2Qgd2hh
dCBJIG1lYW50LiBUaGlzIGlzIG5vdCB0byBkaXN0aW5ndWlzaCBkaWZmZXJlbnQNCmZlYXR1cmVz
IHN1cHBvcnRlZCBieSBkaWZmZXJlbnQgdmVyc2lvbnMgb2YgaGFyZHdhcmUuIEluIGZhY3QsIHRo
ZSBmdW5jdGlvbnMNCm9mIHRoZSB0d28gdmVyc2lvbnMgb2YgZW5ldGMgYXJlIGJhc2ljYWxseSB0
aGUgc2FtZSwgYnV0IHRoZSBoYXJkd2FyZQ0KaW1wbGVtZW50YXRpb25zIGFyZSBkaWZmZXJlbnQs
IHNvIHRoZSBjb2RlIGxvZ2ljIG9mIHR3byBoYXJkd2FyZSBpcyBkaWZmZXJlbnQuDQpUYWtlIDgw
Mi4xIFFidSBhcyBhbiBleGFtcGxlLiBUaGUgZW5ldGNfc2V0X21tKCkgaW50ZXJmYWNlIGRpcmVj
dGx5IHJldHVybnMNCiJ1bnN1cHBvcnRlZCIgZm9yIGVuZXRjIHY0LCBidXQgdGhpcyBkb2VzIG5v
dCBtZWFuIHRoYXQgZW5ldGMgdjQgaXMgcmVhbGx5IG5vdA0Kc3VwcG9ydGVkLiBJdCdzIGp1c3Qg
dGhhdCBmb3IgdGhlIGN1cnJlbnQgcGF0Y2gsIHdlIGhhdmUgbm90IGFkZGVkIHN1cHBvcnQgeWV0
Lg0KQW5kIHdlIHdpbGwgYWRkIHRoZSBRYnUgc3VwcG9ydCBmb3IgZW5ldGMgdjQgaW4gdGhlIGZ1
dHVyZSBhbmQgYWRkIHNvbWUNCmRpZmZlcmVudCBjb25maWd1cmF0aW9ucyBmb3IgZW5ldGMgdjQu
DQoNCj4gDQo+IEVORVRDX0ZFQVRVUkVfMSwgRU5FVENfRkVBVFVSRV8yLCBFTkVUQ19GRUFUVVJF
XzMsDQo+IEVORVRDX0ZFQVRVUkVfNC4NCj4gDQo+IHsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lE
X05YUDIsIFBDSV9ERVZJQ0VfSURfTlhQMl9FTkVUQ19QRikNCj4gICAuZHJpdmVyX2RhdGEgPSBF
TkVUQ19GRUFUVVJFXzEgfCAgRU5FVENfRkVBVFVSRV8yIHwNCj4gRU5FVENfRkVBVFVSRV80DQo+
ICAgUENJX0RFVklDRSguLi4uKQ0KPiAgIC5kcml2ZXJfZGF0YSA9IEVORVRDX0ZFQVRVUkVfMSB8
IEVORVRDX0ZFQVRVUkVfMywNCj4gICBQQ0lfREVWSUNFKC4uLikNCj4gICAuZHJpdmVyX2RhdGEg
PSBFTkVUQ19GRUFUVVJFXzQsDQo+ICkNCj4gDQo+IEl0IHdpbGwgYmUgZWFzeSB0byBrbm93IHRo
ZSBkaWZmZXJlbmNlIGJldHdlZW4gZGlmZmVyZW5jZSB2ZXJzaW9uLiBZb3VyIGlmDQo+IGNoZWNr
IGxvZ2ljIHdpbGwgYmUgc2ltcGxlLg0KPiANCj4gaWYgKGRyaXZlcl9kYXRhICYgRU5FVENfRkVB
VFVSRV8xKQ0KPiAgIC4uLi4NCj4gDQo+IG90aGVyd2lzZQ0KPiAgICBpZiAodmVycyA9PSAxIHx8
IHZlcnMgPT0gMiB8fCB2ZXIgPT0gNSksIHdoaWNoIGRpc3RyaWJ1dGUgdG8gZGlmZmVyZW5jZQ0K
PiBwbGFjZXMgaW4gd2hvbGUgY29kZS4NCj4gDQo+IEl0IGlzIHJlYWwgaGFyZCB0byBrbm93IGhh
cmR3YXJlIGRpZmZlcmVuY2VzIGJldHdlZW4gdmVyc2lvbiBpbiBmdXR1cmUuDQo+IA0KPiBZb3Ug
Y2FuIHJlZiBkcml2ZXJzL21pc2MvcGNpX2VuZHBvaW50X3Rlc3QuYw0KPiANCj4gRnJhbmsNCj4g
DQo+ID4NCj4gPiA+DQo+ID4gPiB7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9OWFAyLCBQQ0lf
REVWSUNFX0lEX05YUDJfRU5FVENfUEYpLA0KPiA+ID4gICAuZHJpdmVyX2RhdGEgPSBJU19TVVBQ
T1JUX0VUSFRPT0wgfCAuLi4uIH0sDQo+ID4gPg0KPiA+ID4gRnJhbmsNCj4gPiA+ID4NCj4gPiA+
ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMv
ZW5ldGM0X3BmLmMNCj4gPiA+ID4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9l
bmV0Yy9lbmV0YzRfcGYuYw0KPiA+ID4gPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+
ID4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZTM4YWRlNzYyNjBiDQo+ID4gPiA+ID4gPiAtLS0g
L2Rldi9udWxsDQo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2Nh
bGUvZW5ldGMvZW5ldGM0X3BmLmMNCj4gPiA+ID4gPiA+IEBAIC0wLDAgKzEsNzYxIEBADQo+ID4g
PiA+ID4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wKyBPUiBCU0QtMy1D
bGF1c2UpDQo+ID4gPiA+ID4gPiArLyogQ29weXJpZ2h0IDIwMjQgTlhQICovDQo+ID4gPiA+ID4g
PiArI2luY2x1ZGUgPGxpbnV4L3VuYWxpZ25lZC5oPg0KPiA+ID4gPiA+ID4gKyNpbmNsdWRlIDxs
aW51eC9tb2R1bGUuaD4NCj4gPiA+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvb2ZfbmV0Lmg+DQo+
ID4gPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+DQo+ID4gPiA+ID4gPiAr
I2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+ID4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9waW5j
dHJsL2NvbnN1bWVyLmg+ICNpbmNsdWRlDQo+ID4gPiA+ID4gPiArPGxpbnV4L2ZzbC9uZXRjX2ds
b2JhbC5oPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gc29ydCBoZWFkZXJzLg0KPiA+ID4gPiA+DQo+
ID4gPiA+DQo+ID4gPiA+IFN1cmUNCj4gPiA+ID4NCj4gPiA+ID4gPiA+ICtzdGF0aWMgaW50IGVu
ZXRjNF9wZl9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4gPiA+ID4gPiA+ICsJCQkgICBj
b25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqZW50KSB7DQo+ID4gPiA+ID4gPiArCXN0cnVjdCBk
ZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gPiA+ID4gPiArCXN0cnVjdCBlbmV0Y19zaSAq
c2k7DQo+ID4gPiA+ID4gPiArCXN0cnVjdCBlbmV0Y19wZiAqcGY7DQo+ID4gPiA+ID4gPiArCWlu
dCBlcnI7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArCWVyciA9IGVuZXRjX3BjaV9wcm9i
ZShwZGV2LCBLQlVJTERfTU9ETkFNRSwgc2l6ZW9mKCpwZikpOw0KPiA+ID4gPiA+ID4gKwlpZiAo
ZXJyKSB7DQo+ID4gPiA+ID4gPiArCQlkZXZfZXJyKGRldiwgIlBDSWUgcHJvYmluZyBmYWlsZWRc
biIpOw0KPiA+ID4gPiA+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IHVz
ZSBkZXZfZXJyX3Byb2JlKCkNCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBPa2F5DQo+ID4g
PiA+DQo+ID4gPiA+ID4gPiArCX0NCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsJLyogc2kg
aXMgdGhlIHByaXZhdGUgZGF0YS4gKi8NCj4gPiA+ID4gPiA+ICsJc2kgPSBwY2lfZ2V0X2RydmRh
dGEocGRldik7DQo+ID4gPiA+ID4gPiArCWlmICghc2ktPmh3LnBvcnQgfHwgIXNpLT5ody5nbG9i
YWwpIHsNCj4gPiA+ID4gPiA+ICsJCWVyciA9IC1FTk9ERVY7DQo+ID4gPiA+ID4gPiArCQlkZXZf
ZXJyKGRldiwgIkNvdWxkbid0IG1hcCBQRiBvbmx5IHNwYWNlIVxuIik7DQo+ID4gPiA+ID4gPiAr
CQlnb3RvIGVycl9lbmV0Y19wY2lfcHJvYmU7DQo+ID4gPiA+ID4gPiArCX0NCj4gPiA+ID4gPiA+
ICsNCj4gPiA+ID4gPiA+ICsJZXJyID0gZW5ldGM0X3BmX3N0cnVjdF9pbml0KHNpKTsNCj4gPiA+
ID4gPiA+ICsJaWYgKGVycikNCj4gPiA+ID4gPiA+ICsJCWdvdG8gZXJyX3BmX3N0cnVjdF9pbml0
Ow0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKwlwZiA9IGVuZXRjX3NpX3ByaXYoc2kpOw0K
PiA+ID4gPiA+ID4gKwllcnIgPSBlbmV0YzRfcGZfaW5pdChwZik7DQo+ID4gPiA+ID4gPiArCWlm
IChlcnIpDQo+ID4gPiA+ID4gPiArCQlnb3RvIGVycl9wZl9pbml0Ow0KPiA+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ID4gKwlwaW5jdHJsX3BtX3NlbGVjdF9kZWZhdWx0X3N0YXRlKGRldik7DQo+ID4g
PiA+ID4gPiArCWVuZXRjX2dldF9zaV9jYXBzKHNpKTsNCj4gPiA+ID4gPiA+ICsJZXJyID0gZW5l
dGM0X3BmX25ldGRldl9jcmVhdGUoc2kpOw0KPiA+ID4gPiA+ID4gKwlpZiAoZXJyKQ0KPiA+ID4g
PiA+ID4gKwkJZ290byBlcnJfbmV0ZGV2X2NyZWF0ZTsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiA+ICsJcmV0dXJuIDA7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArZXJyX25ldGRldl9j
cmVhdGU6DQo+ID4gPiA+ID4gPiArZXJyX3BmX2luaXQ6DQo+ID4gPiA+ID4gPiArZXJyX3BmX3N0
cnVjdF9pbml0Og0KPiA+ID4gPiA+ID4gK2Vycl9lbmV0Y19wY2lfcHJvYmU6DQo+ID4gPiA+ID4g
PiArCWVuZXRjX3BjaV9yZW1vdmUocGRldik7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiB5b3UgY2Fu
IHVzZSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoKSB0byByZW1vdmUgdGhlc2UgZ290byBsYWJl
bHMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gU3Vic2VxdWVudCBwYXRjaGVzIHdpbGwgaGF2ZSBjb3Jy
ZXNwb25kaW5nIHByb2Nlc3NpbmcgZm9yIHRoZXNlDQo+ID4gPiA+IGxhYmVscywgc28gSSBkb24n
dCB3YW50IHRvIGFkZCB0b28gbWFueSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQgKCkuDQo=


Return-Path: <linux-pci+bounces-14878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265439A4583
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 20:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CD71C22F35
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 18:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A32A2040B3;
	Fri, 18 Oct 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="etKR9qwH"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E32040B8;
	Fri, 18 Oct 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275031; cv=fail; b=N+pRWe51Z9R/zO5pHjQlf+MKmGQq2Owsl65+cZLX1AMTUD9WNXue8th26zs3XQX1y2hAkNYm95sLHpONPxLl8yVZ45jTzegfStW92EhWjWG6/TUdW0AmkaHxkWqpfbbwb90Z7K7nFREAmF5PYQSftTLZ2Qk0XHl51Eu3pTyCv9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275031; c=relaxed/simple;
	bh=ZozVP3WkdUGiAGq/yP54V52+bLeRcMaUjhX9+epZwx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TgPXMgQNO8/R9p5xqUk4XpTCaIXoFAggecPzIEn52PtcOeH5jtFyqBcJ6mjaYFU8MYGnCndAJEufECbMLYrdO661RvKTudj/KUedpo6s8AaXwKVnoG6ObSrtAoDvl7N+Yq/X6FOxZY9HzFJzs0isPdHcEPyN+KZGtOtbKsgiVOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=etKR9qwH; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdIIyRdSxa1o7ejjZ+KwkGMwo4ruNE1Y5D4ZEhlC9sOSKqUS1zbVV5kAQqH+1QMWgX0U8TAkJ3cDiRXA6PlHmfnhstB7SRsreUAARMW62z2nZVpeUS9hFa7h1gmDa6kp6e/tCJobmjgAkXscXrQH7mUXHkzGV3XkbAyeDIEfMqW6Eo7lm4bX5UIK2Bpjgt821b1M3EsH5ybigMHcY2eXYi4RxI5AbqIMLhlguQuXU9aYZyzPo8b1LOo2JZX8oVowf2vxIIUA2KXA9tBzFnaALfxfHCdEpSmFNjyDLf/IdRzNpljuhjV/qFJTOGLc6WUxm42+66uL7bwE8bat7pGrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3lt9sf88FKBHTbHa2PyNqkX21oY/8tPcFhhHr65WiI=;
 b=ckI3j//vhgCttSf5/HECoIl6TVVnnZIg27rFtNgaIVVukKB0oMndUTgYhTGoR1PJlkj+vqB6RfI6ANy/jTulFsxvi7Ni86pJZJw7jzju9czo7jFFSmck+VjYAJiJLjzI6OY5wSjf30fdf792B7/8YFxtdOalJlD8SvZvuf7Nf8xSF+De5iu4IHGUGx9GlueWna7Ljf21ub1LmYBD6kBJW7uOzdW0y3Gj0SLZw0hX7eGoQk628KvJpXHmr4u3uUQlaMVIYmUENtVpIB10fXWKaObjedzBlJV/DyAb/7F4zpXr+ZYZ+KWs/whXKvIixXqoDiw9IIUwqujdVnMYyf4dvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3lt9sf88FKBHTbHa2PyNqkX21oY/8tPcFhhHr65WiI=;
 b=etKR9qwH5xHVDwaktw1PPMFWD7R0Wm8oL44RfGOVw+zk8timmWdlUIbKeQ9GZ+gWy46tzQDcrMeXvF2uydidY5ibM1b/eJ3oxOLfVeof6gtbdh+canmv+93RVfWA0HINsx/MH/Jp+lwNr/vQfncHGW3AHvFdC5y5cgfSE3FY68iZPAVVTSL3zjzZ0lcSW4OjUsccHj3w7MSsZPglWmaPfcSAukVO06HPzOKU6iHfn5/zAIcQSUHtlIpLIw70m8TkqHdNQmb9oHya1lBZPh2lvw5JgsxV3jcKTKGBK+TUv9t7rkXsj8NUzPzoaA+JEOgLptt1okIumoxnxzUMKtR4Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9999.eurprd04.prod.outlook.com (2603:10a6:20b:67f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 18:10:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 18:10:26 +0000
Date: Fri, 18 Oct 2024 14:10:15 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 12/13] net: enetc: add preliminary support
 for i.MX95 ENETC PF
Message-ID: <ZxKkhykJ5joWZxaR@lizhi-Precision-Tower-5810>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-13-wei.fang@nxp.com>
 <ZxFCcbDqXHdkW18c@lizhi-Precision-Tower-5810>
 <PAXPR04MB8510E7AD1EEAFD9332DAE29788402@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB8510A1664D3CFAACD71872AB88402@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB8510A1664D3CFAACD71872AB88402@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9999:EE_
X-MS-Office365-Filtering-Correlation-Id: d9aee64b-8acb-4896-bc3b-08dcefa02422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1ZaRzJkRGxHRnFJeHlvWFNOL0FTMDlCWE4wbUVNTTZmY1d4VVdNWExqeTdx?=
 =?utf-8?B?LzZXTEZ3NXhpYXJ4NlZpR1pjbWNQaHBsSkVwK3h1VGNha2V5TVNLQVRPdFdR?=
 =?utf-8?B?aWV4alF4eWVjQ2c4VDJEVE93VkhzcUJUcW1lUlJYZVhNeTZFVFhURDBTcGJ3?=
 =?utf-8?B?NlpPY1R1OXo4bGgyR21TNVZoYXVjM01qZEVvUFh4QnRZY1J0NCt4UC9TZG1D?=
 =?utf-8?B?U3ZiaFkrU2lobGpOOGd0OVhYM2IweFZjcVpubCtLVlFrNjF5UEJxYVlhS3Nw?=
 =?utf-8?B?Vnl3bi8rVXk3Z0taQytQdGZ6ekNaaFBkcXE5WWk0WlVGRHFJZ1JNU2RsSmZZ?=
 =?utf-8?B?MnYyMEtLOTUraEdoWGUvZUpmYUt0RHJGcVQxSU84LzI5S0R4VGxNRTZRcldQ?=
 =?utf-8?B?dU1ZMDN2R3RtYVIxM3ovVmIzdW02WDNOaW9wSVE5ak80K0lZNXFMYlU5RTJu?=
 =?utf-8?B?NE5VNG94TU9YZEl1eGh4d3lNMW9MRWF4c1gxS3FDUW4rcm1KMFdjbjBQSHpN?=
 =?utf-8?B?cnhEb1FpNExpY2FmajNCNlZzOFdOZW44NUtiZ2MvL1dxTW8veXpzWkhaZmZX?=
 =?utf-8?B?dHIwKzVHbFFycmhFTVY0MzFXWGlUelRQdmVzVDRRWERyNW55Y1NyZnpBbE1E?=
 =?utf-8?B?UjdYejNuVVhQVTRMVTZLSWVQVlRFNVg2czF1UXpsdWw1d3hHZWFqRUV5dnlU?=
 =?utf-8?B?U1lwenlxeEpCL1V0QzdpSUlxRVMxYmZnT1A4b2dHRVNSV0NxejVsbms3N1lP?=
 =?utf-8?B?R2RhK1Y2eTJncTRGb2J6dlFSMFJDa05jK3I2VjBuWlkvS3NsaW1FdWkxZVhp?=
 =?utf-8?B?RGp1b2x5SDlyWkdxbVgrVUZlZFFoN2xZS3MrRXpuaWRnRHpjMDBFSVY2T1N2?=
 =?utf-8?B?bm1RMVJnTDUreXZLeHVuRkJ5eTVQMFlBMjF0U2pKKzYyVWJhcFBCZDlQcE1Z?=
 =?utf-8?B?Y042WlhoYnRHd1czZlJrbjhRRGNZVnBVZ2pwd1hvTXhQVHFOT28rRm8veW10?=
 =?utf-8?B?Rm1BRTZ6UTJCVGtwVStKeW9iNXQyV1BKNEI4Q1FxelNRSlJOV00zdmVMbDlY?=
 =?utf-8?B?eEhuTFc4U1FzNjdKVGpYNTF0QjFvV3hOT2dvVk5pSnFXKzBiNWFRZUlVMlJK?=
 =?utf-8?B?Z1QrTUpqbDVPT1N1NGZGUG04YXhMZG8ram12WEpMTitNUHEzN21nLzc1dWJh?=
 =?utf-8?B?djdZSWRreGlrSVFTQmR2aForN0p1ejFhMjdKM3FiUndDdzJPcUk3UGtkcFU1?=
 =?utf-8?B?WjhqNEE2OWg1azFWQldOUDBPZnpIak1yaUdFaHprTzBJK251VkJyNXlDNnc1?=
 =?utf-8?B?MmE2YjNYZVJveG9zUFczUDF1NHltRy9wdWZWUXFxZklVZDliKzFqOUtSSGdL?=
 =?utf-8?B?ZWpObTdXWis5VDVaNnNQQXNnVXkrazR1VENmMlpnakVVSjB2RlBwWXJTRlVG?=
 =?utf-8?B?eUhuRnBxLzhGUmxCUTlkWUJZNkY4Z1Q2dlZDUlFURjdmNGx5R29ZaUo0aERv?=
 =?utf-8?B?cUE3bnF3UU53WUxQeFhDNlMrOUlOcHo2bmJpQXpram1KamxhZ3VjVXlzSTRX?=
 =?utf-8?B?dkh3djZoOGhaVXVRNVczNm4xUmFvUFp4SnNDbHFtV0M4VmJ3QSs5am5MejZD?=
 =?utf-8?B?cC9hWjdTZlMzTmwxdGNOL0xZbVd5UW9OWXZNYzRQTnNRUXZIUFdnN3ZUWGVt?=
 =?utf-8?B?VXE4YlhNK1ZUV3dKV3AyVXNqcDcwdXQyeEpqd0lXaWNsTS9FS1dtQ1pKMXJa?=
 =?utf-8?B?UFpUakNMZjdHcTBLWnRxaWpOMndFK0NEbDdZenNxWnNmeFl6OXc2NzJWbzlO?=
 =?utf-8?Q?Yzb22L6uIUhT9O9Lznfb0nimIxj3RdEX8eazo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEpXNUZ6aXpGdzVVVDE5RVhaelMrRGU1Y1B3ZFA5M1hmWnBxMldPZnVUenJs?=
 =?utf-8?B?dzhIY2lCZEpwSUlWZlJoMkxtbnNLVGR6cmIrN3lKWjhkZGNlbERpWHY5SXM3?=
 =?utf-8?B?YnZncWpLOWIwWWlLZ1FXWnhSVWpxdmJ0TGk2alZaZ3JZbndGUVpQcnByWkl0?=
 =?utf-8?B?SzNlZ3hSc0xJVTN0MVRLY1BuWlVQVVU3U2swVjhtUTNjS29ZTzBwSmhJZXAv?=
 =?utf-8?B?N0lwVUVHR3ZPam5haWV0bktVd0d4YUJ2OE04c0JYbHp5bDJTVXhydU1yR2ZS?=
 =?utf-8?B?enc2MWM5TEx0empudEhmeEc0OGV1YmNwOWNuMk5Kckp6cEhkeVJwRDhiazZm?=
 =?utf-8?B?QjR6aWo0Y20xWjQrVU85TjA5aVYxa1o2SWJMOUVveFpqY3ZsYTk4MnMwUUsx?=
 =?utf-8?B?bFBxbjJJVWJNZ0FyRFVxMmRpSmRZTUE4N0RmbGlGNnZxSGJ6SjBtRGpiaGZl?=
 =?utf-8?B?WlE4SHdubW4rR1l3YnM2OFkxUllzOURSeFE2VmNqSkVRaVcyWllQNzZ6RFoz?=
 =?utf-8?B?SUxvOGxORnpqeWR4Q0YwNWxoV25hc3A5QlZYK2RQWTBVT3VZSHJ0Qm1JOHdG?=
 =?utf-8?B?UmFDRlVRNGFwZEM1QUhBc3UvRE1jaFhGRURxcy9vOG5rU05oWThPenVBS2tE?=
 =?utf-8?B?TlFrY0tPMkpJT3hHalRnWEg0TmE4THVFc3NDWm5acnpMTUZOa2hMWFA2dEdN?=
 =?utf-8?B?Q2g5REkyVG02MFo3a1J5VmExRDRKaHlRQWlET2JreWM5Mm9MZWJYWmxYSkZU?=
 =?utf-8?B?YWE4elJwZmdxY3FPdVBGRm1DQ2d4R1NQTGJEV1V4U1JkN2pzL2dPR0dpQnJo?=
 =?utf-8?B?cmUwS1FheFJnb2luQWtoemZIZWduT0NuaFdCU3JmQnRqS0pqWStzTmN0MUVS?=
 =?utf-8?B?M1QwR2YyYTlhZVF3S2hadWNHQzJFcWJha0NVK3UydDVwVGtjbVJrdHIxQzJi?=
 =?utf-8?B?b2d2anBKN1ZMdXVwSzU0a2VJVzcwbm1vbnpUTGoxZDBOb0p6SlViYVZieWlC?=
 =?utf-8?B?VndvaFVKZUFNVGZibytWTEhrKzNnYmhTL2lPaXZWUTd1S0lvblh1K2p4a3JL?=
 =?utf-8?B?eDNwS2RJc05iQW9qK2ZXMFlTTnpuekdBTHZXa3BVdjhlYS9XcEZLUm5qRHh6?=
 =?utf-8?B?Y0s0NEgvRDArdFZrVHVkSytpSzJFNlVuWWdXeTlrYzNRZmlVMmd5ZVp3aVoy?=
 =?utf-8?B?V0IySHhxUjZ2dDgrVVQzMzBlUVJUVkpUeXRzS1hsZmRQemNkV0xLT1BudmZB?=
 =?utf-8?B?OFFuOFdBR3puUUNHa08xSmlHTUE5c2piemt2MFRwQ3pOSWVlMFhsd3JwN1VP?=
 =?utf-8?B?enN0VDVWcHBVbDNzcHN6WFBqQnJ5QlB2UmViQnJQL2R2U3ZlYm8rbVcrREM4?=
 =?utf-8?B?U3BHNVM5TkNKZTMxV3l0WGJwZFNUOWtxNW55RHVIRG1oM0RJdlMwZzJjOS9m?=
 =?utf-8?B?NTNWQUNJdnNrT2tUZ3BjNTA1ZE4yUTlPejAyNUlDa3RDSGJUK2xySVFyRHJU?=
 =?utf-8?B?Y3pUQ0pKcUhPUzVKZWlTU21PcEhobnN6UDN1anB5UUgvL2RYMGQ4dXdZajQ2?=
 =?utf-8?B?ajJqVkdwakJESnpQUXcyWVFldEJxR1JjcDNkcncrY2xmb2x4Zi9UZWY2ZXpl?=
 =?utf-8?B?bjdzVVZPQlpuL1NVblkwdGR1ajlBaCs5OVptUUVpdmU2NThJN0playtVU1Q3?=
 =?utf-8?B?SCtFYTBCd0RTOXZMb3N1cWRlMHhxYW8xSU83UnI4bTJKOFVwL0hWcGhTZmQy?=
 =?utf-8?B?ZkJnK1k4aElLVFcxc3pSQXhTbC8zSFg4UytaaGRxKzVhOHN0MlNyNWxXVENH?=
 =?utf-8?B?YlE4aGtyS3o3ZUt1aTVXa2pySGliaVE5Vit6aE9tR1ZwRzVTc05Wa2NYSkNu?=
 =?utf-8?B?TE90ek9SOEE5RWhGTlFZdkFrRkt5UitETVMrTFBQVTcwSUhuc1R0NE1LNGY1?=
 =?utf-8?B?UFB2S0pIV2tCdzlvYnFORHhkVGFrTldoa0lKaS91eHJObWMvY3JXcTMxSGJ2?=
 =?utf-8?B?OHhBUjdMRDgzaUd1NkRaLzNkQ2sreTZaZms2TmREZThHVnpuVUpOMncvakli?=
 =?utf-8?B?Y3hKbTl3MXJqczNCZWI2ZUk1Qy9sc3QrQkZ6YlVDSXd2VUt2b1p2RC9JQms2?=
 =?utf-8?Q?xlMQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9aee64b-8acb-4896-bc3b-08dcefa02422
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 18:10:26.1067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcE9ylPTsQBA4JKQUy83lS/R7Xgwm/Vk2FdDaWVPUj8++OgMJeF1qPlWYRy0QAuiZu5Qjri53V42Uyn1agpt4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9999

On Fri, Oct 18, 2024 at 03:05:52AM +0000, Wei Fang wrote:
> > -----Original Message-----
> > From: Wei Fang
> > Sent: 2024年10月18日 10:04
> > To: Frank Li <frank.li@nxp.com>
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; Vladimir Oltean <vladimir.oltean@nxp.com>; Claudiu
> > Manoil <claudiu.manoil@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> > christophe.leroy@csgroup.eu; linux@armlinux.org.uk; bhelgaas@google.com;
> > horms@kernel.org; imx@lists.linux.dev; netdev@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-pci@vger.kernel.org
> > Subject: RE: [PATCH v3 net-next 12/13] net: enetc: add preliminary support for
> > i.MX95 ENETC PF
> >
> > [...]
> > > > @@ -1721,14 +1724,25 @@ void enetc_get_si_caps(struct enetc_si *si)
> > > >  	struct enetc_hw *hw = &si->hw;
> > > >  	u32 val;
> > > >
> > > > +	if (is_enetc_rev1(si))
> > > > +		si->clk_freq = ENETC_CLK;
> > > > +	else
> > > > +		si->clk_freq = ENETC_CLK_333M;
> > >
> > > can you use clk_gate_rate() to get frequency instead of hardcode here.
> >
> > clk_gate_rate() is not possible to be used here, enetc_get_si_caps() is shared
> > by PF and VFs, but VF does not have DT node. Second, LS1028A and S32
> > platform do not use the clocks property.

It should be set when pf probe.

enetc4_pf_netdev_create()
{
	...
	priv->ref_clk = devm_clk_get_optional(dev, "ref");

	I am sure if it is "ref" clock.

	if (ref_clk)
		si->clk_freq = clk_get_rate(ref_clk);
	else
		si->clk_freq = ENETC_CLK; //default one for old LS1028A.

	Next time, it may be become 444MHz, 555Mhz...
}

> >
> > > Or you should use standard PCIe version information.
> > >
> >
> > What do you mean standard PCIe version? is_enetc_rev1() gets the revision
> > from struct pci_dev:: revision, my understanding is that this is the revision
> > provided by PCIe.
> >
> > [...]
> > > > +
> > > > @@ -593,6 +620,9 @@ static int enetc_get_rxnfc(struct net_device *ndev,
> > > struct ethtool_rxnfc *rxnfc,
> > > >  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> > > >  	int i, j;
> > > >
> > > > +	if (is_enetc_rev4(priv->si))
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > >  	switch (rxnfc->cmd) {
> > > >  	case ETHTOOL_GRXRINGS:
> > > >  		rxnfc->data = priv->num_rx_rings;
> > > > @@ -643,6 +673,9 @@ static int enetc_set_rxnfc(struct net_device *ndev,
> > > struct ethtool_rxnfc *rxnfc)
> > > >  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> > > >  	int err;
> > > >
> > > > +	if (is_enetc_rev4(priv->si))
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > >  	switch (rxnfc->cmd) {
> > > >  	case ETHTOOL_SRXCLSRLINS:
> > > >  		if (rxnfc->fs.location >= priv->si->num_fs_entries) @@ -678,6
> > > > +711,9 @@ static u32 enetc_get_rxfh_key_size(struct net_device *ndev)
> > > > {
> > > >  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> > > >
> > > > @@ -843,8 +890,12 @@ static int enetc_set_coalesce(struct net_device
> > > > *ndev,  static int enetc_get_ts_info(struct net_device *ndev,
> > > >  			     struct kernel_ethtool_ts_info *info)  {
> > > > +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> > > >  	int *phc_idx;
> > > >
> > > > +	if (is_enetc_rev4(priv->si))
> > > > +		return -EOPNOTSUPP;
> > > > +
> > >
> > > Can you just not set enetc_pf_ethtool_ops if it is imx95 instead of check each
> > > ethtools function? or use difference enetc_pf_ethtool_ops for imx95?
> > >
> >
> > For the first question, in the current patch, i.MX95 already supports some
> > ethtool interfaces, so there is no need to remove them.
> >
> > For the second question, for LS1028A and i.MX95, the logic of these ethtool
> > interfaces is basically the same, the difference is the hardware operation part.
> > It's just that support for i.MX95 has not yet been added. Both the current
> > approach and the approach you suggested will eventually merge into using the
> > same enetc_pf_ethtool_ops, so I don't think there is much practical point in
> > switching to the approach you mentioned.
>
> I thought about it again, your suggestion is more reasonable and easier to
> understand. I will merge the two enetc_pf_ethtool_ops into one after I
> complete the support of all ethtool interfaces of i.MX95. Thanks.


Return-Path: <linux-pci+bounces-14126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9DD997B35
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 05:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88EE1C22068
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 03:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9128D183CC1;
	Thu, 10 Oct 2024 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OfKnOz/R"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7C0139D07;
	Thu, 10 Oct 2024 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728530740; cv=fail; b=LQLZhx99oLwEwfoa74vv/x8ApFkuedL9CPYcWDnUCYwDy5mBSiygF752itHsyFyj9LFz2TAt63mfmgo5NSAvcrDG22ny8Amniv2i4lw62BOIp/vDMlpj4pj4hS8Ayp3jSkvWxi/jlQRjncQCeMm2TYZoGlv1LEshHsKW+VUSJ4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728530740; c=relaxed/simple;
	bh=hVnUKfOXvH4mEhqI/3u2DNr8B+4L8J4StCUngNqwO5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mwMj+Nj1LTnYX33+8t15tc7/T+GWg8vIm/m2ss461mGndXyMq6hDo2a9Ay9nThYMTha5sKTlItRcGkz8hmItYq7kvGkai1bfforxSR+A/85CkIm+1pbxNZYmhdVEAgglMnSKVbwq8FVcpcLQO0TAlMtmLTLWYXUzpKYQblZDynY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OfKnOz/R; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5ZeCgyM87XR7UBoAA4AOH1GrYndR0Tm8PEnWhEB6jmPzlF0d4PcMtHAyeZ2KnhxBod4LdWGLp+nq0TWfpw55t8QVBljy5+cztiZT+N9RdgFNKTYbNgcSd9gfdBDdTMJ12sgixW95BtiuvTiObPi9q6WETGSCgDNY04aRQhqILX+lb/6Yvgc0Oz9tAQNdP6MV5cOgPJ5uaqTrEObDnS5PpnWBgGNX15JlU6+Ds0ztBTOWrcfBc6TNujiXlazGGnYxmExAC9jT9FB0hHQaFOGn8QrtiHIEgKwVqQ6N23LrkQx+03LNLMjgl1vC+hISUXj1l/Nk0yx2aw9XHf1T+NUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVnUKfOXvH4mEhqI/3u2DNr8B+4L8J4StCUngNqwO5s=;
 b=KK5U+tOp+ULuoc68jUDKkLvI/W5trNW6QseO4/Asxv++rAmFBb8yztlf6Ju7tJKogvnJqnUUEaY1nJo68KbzQFKmlmB12M8bTXdjwhECECooT4d4c5pBK2v79HcDbc+Z9EBYG6Xti32NcMhBVhFLvZ9dlgIGGuc5VDbXG7BKeTfBLOw/VhTtdpMvR+XB7Z8aIVvJoC1r6d+LXsMemz1dTR1dXU6Lajxi+bJWNmiOhBhw97dafkcrhzX6KfilLr9JKCCJm3XtPlIFTpT1Cr3F29Hd90epe/U4rPKZxgbFZh5Wkpf64EDdPcMrmtB6BDgARnmnn+mgsA+G8WDJR0Mw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVnUKfOXvH4mEhqI/3u2DNr8B+4L8J4StCUngNqwO5s=;
 b=OfKnOz/RRgYVnWBtcRM9NDQs5yGC5WX7h4DM3gkLSoljRmgnR45C3zVGu7C45yt2yUTB6WwZYjTmAtFsJfjMMXVh15Jecajcr3zGvUxSFrk8tUfUmBUWXoDOyAzwbH0VN75FHlQGFVt/7EnAVjvGrLzDI59672DeE3AQaF6OB48QhMV8NqXcgl2bdcGjYS2YbMxpQW7DeGMj26MdvnhIJ1b6uXYbrJ69ropul8lopKgjh+7I/Id73GtoXeNYByG0vB594iROQvIN3UD4l6XqSYi1BdCy6xpVzN8efI8fzgEWD4WAwwwI4gVXjFfrrIJ/p1mJRKyssTUpIcXKsxaiIw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9220.eurprd04.prod.outlook.com (2603:10a6:102:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 10 Oct
 2024 03:25:35 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 03:25:35 +0000
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
Subject: RE: [PATCH net-next 09/11] net: enetc: optimize the allocation of
 tx_bdr
Thread-Topic: [PATCH net-next 09/11] net: enetc: optimize the allocation of
 tx_bdr
Thread-Index: AQHbGjL/kyAaoSumUEqeVlRA0V9KurJ+q/+AgACnn/A=
Date: Thu, 10 Oct 2024 03:25:35 +0000
Message-ID:
 <PAXPR04MB85103B9DD47E83FB72CBAE5388782@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-10-wei.fang@nxp.com>
 <Zwa8eU+YDuseXmK7@lizhi-Precision-Tower-5810>
In-Reply-To: <Zwa8eU+YDuseXmK7@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB9220:EE_
x-ms-office365-filtering-correlation-id: c9dffd0b-1e90-4ab9-3f70-08dce8db344a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?TjA3SFhyamhxZGFPUm04U0g1bkpOTnc3VG5MUDdZUXlHbXFLVlNZc00rTHZW?=
 =?gb2312?B?ZmphM2R1QW5acWcvVlRGcHN0YkkvdmZxdVM5Q2JZUDZTR2JFaXdMTENoUjhU?=
 =?gb2312?B?UTRmSFdxMGFBNDhrQnIvT0VHVUFmV2MxUC9Pek5Fd212aUpSUFhUdjh4cDRO?=
 =?gb2312?B?SE0wZ3QvemJZb0NReTB2SjVrTm94N1BqbmpTZ0RjWjVZa2w0ZWNwcGk3MlAr?=
 =?gb2312?B?ZFpCWWZCVlRmMSs3cER5blUwNFFWcVFaK3hYQTY1ZjNEVVZ5VWVmWGtmMUJh?=
 =?gb2312?B?NlVNcEVlQkl2a1JTaFA2dmxWanh5MzhVYnhvSGtGa3EweTNCMjhaQ29paDFr?=
 =?gb2312?B?NERGRlNpNWp4b0NwKzFiTkswV0FGQ3BHMVlHdUdiMFFRZTFVbERhTzFnUzNH?=
 =?gb2312?B?TU16MFZYaDAzdk9WS2t1VTdFNzlXWmVnaXY2R01FZnlJeDZCeWx6UmJrTXkr?=
 =?gb2312?B?d0UvVUE2Lzkyc05EYm53VXZqakUwOTdZV0FBeHpQTUJ0OWFaUit5d2ExVXo4?=
 =?gb2312?B?WFdGSm5BVDYxLzdlQXlUeHk2ejArRWYwaUs4QmhiVmwxVU81c0VqdWdmNUNI?=
 =?gb2312?B?endidUgrQWdpbTFaZ0FqamZpUGNvbGJEUjVhRDBVK3pxUzdid0NHTEYzblBr?=
 =?gb2312?B?MVMwdnk1NkZ1ajNsWkpZKzJoQTU2RG4xM29EcEttMUFOZmJvMkpES3lwOGJq?=
 =?gb2312?B?R1JuYnZoeDNJRGJtdkNiMStvUnhpYng4d2VsYU1qWGtWdUw5N21DdVZXc3FQ?=
 =?gb2312?B?RnhWdXprVmlCaVFxcWpaVDhzNG15eGcwR0ZGYlc0SU50bGN4aEpiTUtLQzZs?=
 =?gb2312?B?cEMvbGFEQkhPQm9mTDBkMCtEQnFlZC9QYnBvNjVhbmJvVEt3bE4yeXNVTFhE?=
 =?gb2312?B?M3RRbXB6dGtrZjMwUU9kTnNML1E0MlRSWlc1eDR4OVdBc29JYWMvUkFUNEJu?=
 =?gb2312?B?aDdHdFoveHRXSExUUFdCdVc1V2JrRzFlc29pMjMzczlDVi8ySnpNblM1Y0hk?=
 =?gb2312?B?UWMxd0xFSG9YZndKYVdac0JEZEdHUnduOFB3K3BVYUpRL0ZQWkdwWlNrSGtB?=
 =?gb2312?B?d3o0Tng2Ylk2bFJhSEFLNUt0bno3V1lpOUFyM2tmazJRRE1jRWV1a0ZYaFNv?=
 =?gb2312?B?c2N5NG1xY0JZVmtRbllSTHBtYXJiSTJsSXhweTFWT2RJaWJFZmdRa09xa2dx?=
 =?gb2312?B?L3UyMU9Oc2xlM0EvTUxibCtGUGZtOFF4NlEzSjlDOWFPRDFTK1kzZ2hiZWU3?=
 =?gb2312?B?V3dyS0lQOU5NVzU3ekg4NWxjd1ArS2NqTmNOZlM5WGxKVU1TaW1oUFVHRkdM?=
 =?gb2312?B?bEp1dnRlbGpLQTZrMWpoZWdVSVJ4SVkxL3lSdUYrTWRiRFZqbW5SQlNJc2Vp?=
 =?gb2312?B?bUZGcEdPSXVtclNMTk1CN3N4NlZNNWV6SkRwS29ieXhiRjVPSmMremJOUm4y?=
 =?gb2312?B?TXVFY1NWaSt2MVZCbm9NU1YxQ2JPcjkwenpyZStxZm5pQXRoNjhMeERHS1Yx?=
 =?gb2312?B?bDlNK1pROGtaZWtQMnJXYXNmekZ5a2hPL3h6YkxXVGFFaEJvY2hRcEJaSjQz?=
 =?gb2312?B?a3FUVFZNK3NHTjVnQmwxREJ3YkNQanprREVwcnFURXBKUDBveXAyODgzWnlY?=
 =?gb2312?B?Y2JPcTdlTmhGSUFVNjYwUzZHVE5pVkFoMjJYM3Q1dGdvRDhpMWJKUUV5cHNu?=
 =?gb2312?B?bVYxVXIwL1NRaDBEM3BROFBvMzI4cXJpdzVkc3VkRTZsM0ZzRW15TDJzbHNL?=
 =?gb2312?B?VGJTajRvTXJvTnJ3WlNZOW5JVVIvVlVnUTdwY1ZFVlZLcTlNUC9rbkg4cWhV?=
 =?gb2312?B?OFdMNkFUbGVBQUJJbzRxQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UkxyQXRnbmxXcG5mdVhyaTMzTzFPc21WWHI4N2dmNmh0Zys3bE9sT3BCZXUx?=
 =?gb2312?B?NXVJYVdEWUpXby84WGRRS3lRdk02SXZtOStBdmpZMmw2WkVQOWxCbzFPRlUz?=
 =?gb2312?B?eGFvaFNvYXNlb1VrT1NsTTNmQ0JGNng3bndVNmZKTjBlNE0vOTlqVy80Q1k2?=
 =?gb2312?B?b1UyWExZM1YyNm5rb24xTU4zcmlmcEZHOW50WnNUcXcrY2Y0Y2VjUHpWRUg1?=
 =?gb2312?B?dkFTcVVpdTd5WXpUaktDSkNGaFBNN2NTVExDcnhuR0pWT0ZRU0gxQmRTamtL?=
 =?gb2312?B?a0RzdlFicmhXOXlKTC85eTJjSWlVMjlWdDlVeEowa1hLcXRhVWk0UmRkT0Yw?=
 =?gb2312?B?Qi8wM21oNXJhNklVMVliY2hGTU1MczhySUlVc1VwZUd1eWdRQjZlMjFoMHZD?=
 =?gb2312?B?M0hDK1BabGJiYXRaeUN1NmxUckNOVnBHclpkOWNJV3lvd2Q1TllUSDlFL2Q3?=
 =?gb2312?B?SjNXcXQ0bkRPYXdick83cy8wL2h5RVhXQlVlRXB3ZFRYNXF5NXNVcm9RaXBa?=
 =?gb2312?B?a1daMUdmVHd2Q1JJR0lyWHZ3cXlhUFJNZmY0ZmEyNThvR0kvb3FkOXYrOXcy?=
 =?gb2312?B?MDh4ZnNnWFc3eFVCNWladkxGRWNNVjY4UXZocHVLZXJJNlZvYUFXM3ErR3Zt?=
 =?gb2312?B?Q2p5UEJRT1RzR0xYaFB2V0tjRjBKUnRlRGQ1N2wxSkRoRGlEclF2a1psKzM4?=
 =?gb2312?B?N3Fmd0t5cEtseW5EUUhNWlVRb0orR0dZZFFzbk5vb1NPOHNUeHliVnpSbTlF?=
 =?gb2312?B?VllMK3B3MTZCZ1Q2T3Z4MnNleGJxelhnN2pBZktRbHlQTy9CbDJkSlRiQm1J?=
 =?gb2312?B?dzdEUmdzOEdpSHJPaDBmdXZwdVZHcG5aR2I1bFpNZHhKRTR5K3I2T1o5YXpj?=
 =?gb2312?B?UDcwWEJ1ck0xSGN4ZGpkcXZHNkU5UGgycU94NzRhRTRqd3NhWWhIMVU2MGp6?=
 =?gb2312?B?Z01QcllwRGdQM3hnbUhqcFFzUC9ZS3hLem81ckJldnJ2dUJxWUFTMmxCTGhS?=
 =?gb2312?B?dHIyN3VZNENYd1dWVDk5SHVyYWdBZFY1U2lqRnpNTXBvTStQQlZ2R2xXMmN1?=
 =?gb2312?B?Y0k2UnpVWGZMbmRYNjBxTlRidkZuQmpJL0hzdTY3VUR3eHJqZmREVjdEaDVB?=
 =?gb2312?B?bi9VYTRhZ2M3Rk42WmFVMGpsdmF2Qllod2VWMDZwcnRaaHRNN3JJamVUbDg4?=
 =?gb2312?B?ZkFXQWkra25XbXFNZ0MyZHZvMHRQa0Ird05MSVZJT0pWczBJR1lOeDhETkIw?=
 =?gb2312?B?M0lNbldWZE13ajlZMmxjOGNzTVF5K05abmhQOWg4TjlSTk44djlKbUVsTG9G?=
 =?gb2312?B?YjVsTURRRnNQemYwanJOTWlueWg3OTFQU2NGUldueEo3QnFFbk1HNHZ6eEFi?=
 =?gb2312?B?MDQ3a0JRaU5HM01YaHJEejcvaWFGdnlhVWNPWWpJQy8zb2luckRHUDFoK0JH?=
 =?gb2312?B?ZHkwWnAyS0JDQUV2RkRxL0pVclRRUC9WWVdTUjcweXdWT1ErcVBMRzNXNUcy?=
 =?gb2312?B?a3hCalRPRFVRdnY1VHFYMFBGVC8xMllrOUxobnVVVC80c1lrVnNjc0RRKzRL?=
 =?gb2312?B?RDZ5VVNMemNYelFKd29peVFpMWlubXU1cEpCSE1zVWFOOGRCa0MwSWNlREVP?=
 =?gb2312?B?K09jWE1vcEh2aFhyc2g2MVE0ek12SktZc3dFS3I2d2x2NXdDL0owOFBORWw3?=
 =?gb2312?B?enQwTXZia0xCTjlOc21Hc0JzODZma0ZNRWtlUzZIMS9JdmhWR3JWTzFtU0hP?=
 =?gb2312?B?SG9ZbmxWUGVXeWY1a0w5YXF2OFgwbjFYUmg3RHd3b3FlaFVHaXpuOWRqVzdE?=
 =?gb2312?B?N2syWVBVMk9iNElncnlyamRDUHZGRXl1bnBwY1ZBTlh3d085MEdsaDc5Vmhx?=
 =?gb2312?B?NXhrM0FkME13VVBUQjl6andENXJEUC9DYkdYL0RJNkRRNzNRUHFHMVBJcUpD?=
 =?gb2312?B?MGREQ2xMOVM4MVFPcGVLUWxsSkU3WHlRN3FmVjZwWTlqUHhjeEtMM2xHdmVN?=
 =?gb2312?B?MFZzTjlUTkZHVWtJSGpZV3JRR3QxaDVrQUtyazVOQStzSTZYRWhEK1diUXN4?=
 =?gb2312?B?dHNhOFhlRnB4dFJJcnZEdzd0NExYeG5uZlcweUFMSTlUM3BYS25LUHhIY2dh?=
 =?gb2312?Q?6WF0=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dffd0b-1e90-4ab9-3f70-08dce8db344a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 03:25:35.2179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ejuq/k7LnBcBlgua/en02S9nEcFwqyV97/I83NQL8B/AgV3t13MG/+gQHqhMh+iLHdEirPCMlE4YI3ox7N+ITw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9220

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjEwyNUgMToyNQ0KPiBUbzogV2VpIEZhbmcgPHdl
aS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29n
bGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyByb2JoQGtlcm5l
bC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgVmxhZGlt
aXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47IENsYXVkaXUNCj4gTWFub2lsIDxj
bGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29t
PjsNCj4gY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1OyBsaW51eEBhcm1saW51eC5vcmcudWs7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggbmV0LW5leHQgMDkvMTFdIG5ldDogZW5ldGM6IG9wdGltaXplIHRoZSBhbGxvY2F0
aW9uIG9mDQo+IHR4X2Jkcg0KPiANCj4gT24gV2VkLCBPY3QgMDksIDIwMjQgYXQgMDU6NTE6MTRQ
TSArMDgwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gRnJvbTogQ2xhcmsgV2FuZyA8eGlhb25pbmcu
d2FuZ0BueHAuY29tPg0KPiA+DQo+ID4gVGhlcmUgaXMgYSBzaXR1YXRpb24gd2hlcmUgbnVtX3R4
X3JpbmdzIGNhbm5vdCBiZSBkaXZpZGVkIGJ5DQo+ID4gYmRyX2ludF9udW0uIEZvciBleGFtcGxl
LCBudW1fdHhfcmluZ3MgaXMgOCBhbmQgYmRyX2ludF9udW0NCj4gPiBpcyAzLiBBY2NvcmRpbmcg
dG8gdGhlIHByZXZpb3VzIGxvZ2ljLCB0aGlzIHJlc3VsdHMgaW4gdHdvDQo+ID4gdHhfYmRyIGNv
cnJlc3BvbmRpbmcgbWVtb3JpZXMgbm90IGJlaW5nIGFsbG9jYXRlZCwgc28gd2hlbg0KPiA+IHNl
bmRpbmcgcGFja2V0cyB0byB0eCBCRCByaW5nIDYgb3IgNywgd2lsZCBwb2ludGVycyB3aWxsIGJl
DQo+ID4gYWNjZXNzZWQuIE9mIGNvdXJzZSwgdGhpcyBpc3N1ZSBkb2VzIG5vdCBleGlzdCBmb3Ig
TFMxMDI4QSwNCj4gPiBiZWNhdXNlIGl0cyBudW1fdHhfcmluZ3MgaXMgOCwgYW5kIGJkcl9pbnRf
bnVtIGlzIGVpdGhlciAxDQo+ID4gb3IgMi4gU28gdGhlcmUgaXMgbm8gc2l0dWF0aW9uIHdoZXJl
IGl0IGNhbm5vdCBiZSBkaXZpZGVkLg0KPiA+IEhvd2V2ZXIsIHRoZXJlIGlzIGEgcmlzayBmb3Ig
dGhlIHVwY29taW5nIGkuTVg5NSwgc28gdGhlDQo+ID4gYWxsb2NhdGlvbiBvZiB0eF9iZHIgaXMg
b3B0aW1pemVkIHRvIGVuc3VyZSB0aGF0IGVhY2ggdHhfYmRyDQo+ID4gY2FuIGJlIGFsbG9jYXRl
ZCB0byB0aGUgY29ycmVzcG9uZGluZyBtZW1vcnkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBD
bGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2Vp
IEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IENsYXVkaXUgTWFub2ls
IDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9ldGhl
cm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuYyB8IDEyMSArKysrKysrKysrLS0tLS0tLS0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspLCA1OSBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMv
ZW5ldGMuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5j
DQo+ID4gaW5kZXggMDMyZDhlYWRkMDAzLi5iODRjODhhNzY3NjIgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmMNCj4gPiArKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+IEBAIC0yOTY1
LDEzICsyOTY1LDcwIEBAIGludCBlbmV0Y19pb2N0bChzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwg
c3RydWN0DQo+IGlmcmVxICpycSwgaW50IGNtZCkNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9M
X0dQTChlbmV0Y19pb2N0bCk7DQo+ID4NCj4gPiArc3RhdGljIGludCBlbmV0Y19iZHJfaW5pdChz
dHJ1Y3QgZW5ldGNfbmRldl9wcml2ICpwcml2LCBpbnQgaSwgaW50IHZfdHhfcmluZ3MpDQo+ID4g
K3sNCj4gPiArCXN0cnVjdCBlbmV0Y19pbnRfdmVjdG9yICp2IF9fZnJlZShrZnJlZSk7DQo+ID4g
KwlzdHJ1Y3QgZW5ldGNfYmRyICpiZHI7DQo+ID4gKwlpbnQgaiwgZXJyOw0KPiA+ICsNCj4gPiAr
CXYgPSBremFsbG9jKHN0cnVjdF9zaXplKHYsIHR4X3JpbmcsIHZfdHhfcmluZ3MpLCBHRlBfS0VS
TkVMKTsNCj4gPiArCWlmICghdikNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4g
KwliZHIgPSAmdi0+cnhfcmluZzsNCj4gPiArCWJkci0+aW5kZXggPSBpOw0KPiA+ICsJYmRyLT5u
ZGV2ID0gcHJpdi0+bmRldjsNCj4gPiArCWJkci0+ZGV2ID0gcHJpdi0+ZGV2Ow0KPiA+ICsJYmRy
LT5iZF9jb3VudCA9IHByaXYtPnJ4X2JkX2NvdW50Ow0KPiA+ICsJYmRyLT5idWZmZXJfb2Zmc2V0
ID0gRU5FVENfUlhCX1BBRDsNCj4gPiArCXByaXYtPnJ4X3JpbmdbaV0gPSBiZHI7DQo+ID4gKw0K
PiA+ICsJZXJyID0geGRwX3J4cV9pbmZvX3JlZygmYmRyLT54ZHAucnhxLCBwcml2LT5uZGV2LCBp
LCAwKTsNCj4gPiArCWlmIChlcnIpDQo+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiArDQo+ID4gKwll
cnIgPSB4ZHBfcnhxX2luZm9fcmVnX21lbV9tb2RlbCgmYmRyLT54ZHAucnhxLA0KPiA+ICsJCQkJ
CSBNRU1fVFlQRV9QQUdFX1NIQVJFRCwgTlVMTCk7DQo+ID4gKwlpZiAoZXJyKSB7DQo+ID4gKwkJ
eGRwX3J4cV9pbmZvX3VucmVnKCZiZHItPnhkcC5yeHEpOw0KPiA+ICsJCXJldHVybiBlcnI7DQo+
ID4gKwl9DQo+ID4gKw0KPiA+ICsJLyogaW5pdCBkZWZhdWx0cyBmb3IgYWRhcHRpdmUgSUMgKi8N
Cj4gPiArCWlmIChwcml2LT5pY19tb2RlICYgRU5FVENfSUNfUlhfQURBUFRJVkUpIHsNCj4gPiAr
CQl2LT5yeF9pY3R0ID0gMHgxOw0KPiA+ICsJCXYtPnJ4X2RpbV9lbiA9IHRydWU7DQo+ID4gKwl9
DQo+ID4gKwlJTklUX1dPUksoJnYtPnJ4X2RpbS53b3JrLCBlbmV0Y19yeF9kaW1fd29yayk7DQo+
ID4gKwluZXRpZl9uYXBpX2FkZChwcml2LT5uZGV2LCAmdi0+bmFwaSwgZW5ldGNfcG9sbCk7DQo+
ID4gKwl2LT5jb3VudF90eF9yaW5ncyA9IHZfdHhfcmluZ3M7DQo+ID4gKw0KPiA+ICsJZm9yIChq
ID0gMDsgaiA8IHZfdHhfcmluZ3M7IGorKykgew0KPiA+ICsJCWludCBpZHg7DQo+ID4gKw0KPiA+
ICsJCS8qIGRlZmF1bHQgdHggcmluZyBtYXBwaW5nIHBvbGljeSAqLw0KPiA+ICsJCWlkeCA9IHBy
aXYtPmJkcl9pbnRfbnVtICogaiArIGk7DQo+ID4gKwkJX19zZXRfYml0KGlkeCwgJnYtPnR4X3Jp
bmdzX21hcCk7DQo+ID4gKwkJYmRyID0gJnYtPnR4X3Jpbmdbal07DQo+ID4gKwkJYmRyLT5pbmRl
eCA9IGlkeDsNCj4gPiArCQliZHItPm5kZXYgPSBwcml2LT5uZGV2Ow0KPiA+ICsJCWJkci0+ZGV2
ID0gcHJpdi0+ZGV2Ow0KPiA+ICsJCWJkci0+YmRfY291bnQgPSBwcml2LT50eF9iZF9jb3VudDsN
Cj4gPiArCQlwcml2LT50eF9yaW5nW2lkeF0gPSBiZHI7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJ
cHJpdi0+aW50X3ZlY3RvcltpXSA9IG5vX2ZyZWVfcHRyKHYpOw0KPiA+ICsNCj4gPiArCXJldHVy
biAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBpbnQgZW5ldGNfYWxsb2NfbXNpeChzdHJ1Y3QgZW5l
dGNfbmRldl9wcml2ICpwcml2KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9
IHByaXYtPnNpLT5wZGV2Ow0KPiA+ICsJaW50IHZfdHhfcmluZ3MsIHZfcmVtYWluZGVyOw0KPiA+
ICAJaW50IG51bV9zdGFja190eF9xdWV1ZXM7DQo+ID4gIAlpbnQgZmlyc3RfeGRwX3R4X3Jpbmc7
DQo+ID4gIAlpbnQgaSwgbiwgZXJyLCBudmVjOw0KPiA+IC0JaW50IHZfdHhfcmluZ3M7DQo+ID4N
Cj4gPiAgCW52ZWMgPSBFTkVUQ19CRFJfSU5UX0JBU0VfSURYICsgcHJpdi0+YmRyX2ludF9udW07
DQo+ID4gIAkvKiBhbGxvY2F0ZSBNU0lYIGZvciBib3RoIG1lc3NhZ2luZyBhbmQgUngvVHggaW50
ZXJydXB0cyAqLw0KPiA+IEBAIC0yOTg1LDY1ICszMDQyLDExIEBAIGludCBlbmV0Y19hbGxvY19t
c2l4KHN0cnVjdCBlbmV0Y19uZGV2X3ByaXYNCj4gKnByaXYpDQo+ID4NCj4gPiAgCS8qICMgb2Yg
dHggcmluZ3MgcGVyIGludCB2ZWN0b3IgKi8NCj4gPiAgCXZfdHhfcmluZ3MgPSBwcml2LT5udW1f
dHhfcmluZ3MgLyBwcml2LT5iZHJfaW50X251bTsNCj4gPiArCXZfcmVtYWluZGVyID0gcHJpdi0+
bnVtX3R4X3JpbmdzICUgcHJpdi0+YmRyX2ludF9udW07DQo+ID4NCj4gPiAtCWZvciAoaSA9IDA7
IGkgPCBwcml2LT5iZHJfaW50X251bTsgaSsrKSB7DQo+ID4gLQkJc3RydWN0IGVuZXRjX2ludF92
ZWN0b3IgKnY7DQo+ID4gLQkJc3RydWN0IGVuZXRjX2JkciAqYmRyOw0KPiA+IC0JCWludCBqOw0K
PiA+IC0NCj4gPiAtCQl2ID0ga3phbGxvYyhzdHJ1Y3Rfc2l6ZSh2LCB0eF9yaW5nLCB2X3R4X3Jp
bmdzKSwgR0ZQX0tFUk5FTCk7DQo+ID4gLQkJaWYgKCF2KSB7DQo+ID4gLQkJCWVyciA9IC1FTk9N
RU07DQo+ID4gLQkJCWdvdG8gZmFpbDsNCj4gPiAtCQl9DQo+ID4gLQ0KPiA+IC0JCXByaXYtPmlu
dF92ZWN0b3JbaV0gPSB2Ow0KPiA+IC0NCj4gPiAtCQliZHIgPSAmdi0+cnhfcmluZzsNCj4gPiAt
CQliZHItPmluZGV4ID0gaTsNCj4gPiAtCQliZHItPm5kZXYgPSBwcml2LT5uZGV2Ow0KPiA+IC0J
CWJkci0+ZGV2ID0gcHJpdi0+ZGV2Ow0KPiA+IC0JCWJkci0+YmRfY291bnQgPSBwcml2LT5yeF9i
ZF9jb3VudDsNCj4gPiAtCQliZHItPmJ1ZmZlcl9vZmZzZXQgPSBFTkVUQ19SWEJfUEFEOw0KPiA+
IC0JCXByaXYtPnJ4X3JpbmdbaV0gPSBiZHI7DQo+ID4gLQ0KPiA+IC0JCWVyciA9IHhkcF9yeHFf
aW5mb19yZWcoJmJkci0+eGRwLnJ4cSwgcHJpdi0+bmRldiwgaSwgMCk7DQo+ID4gLQkJaWYgKGVy
cikgew0KPiA+IC0JCQlrZnJlZSh2KTsNCj4gPiAtCQkJZ290byBmYWlsOw0KPiA+IC0JCX0NCj4g
PiAtDQo+ID4gLQkJZXJyID0geGRwX3J4cV9pbmZvX3JlZ19tZW1fbW9kZWwoJmJkci0+eGRwLnJ4
cSwNCj4gPiAtCQkJCQkJIE1FTV9UWVBFX1BBR0VfU0hBUkVELCBOVUxMKTsNCj4gPiAtCQlpZiAo
ZXJyKSB7DQo+ID4gLQkJCXhkcF9yeHFfaW5mb191bnJlZygmYmRyLT54ZHAucnhxKTsNCj4gPiAt
CQkJa2ZyZWUodik7DQo+ID4gLQkJCWdvdG8gZmFpbDsNCj4gPiAtCQl9DQo+ID4gLQ0KPiA+IC0J
CS8qIGluaXQgZGVmYXVsdHMgZm9yIGFkYXB0aXZlIElDICovDQo+ID4gLQkJaWYgKHByaXYtPmlj
X21vZGUgJiBFTkVUQ19JQ19SWF9BREFQVElWRSkgew0KPiA+IC0JCQl2LT5yeF9pY3R0ID0gMHgx
Ow0KPiA+IC0JCQl2LT5yeF9kaW1fZW4gPSB0cnVlOw0KPiA+IC0JCX0NCj4gPiAtCQlJTklUX1dP
UksoJnYtPnJ4X2RpbS53b3JrLCBlbmV0Y19yeF9kaW1fd29yayk7DQo+ID4gLQkJbmV0aWZfbmFw
aV9hZGQocHJpdi0+bmRldiwgJnYtPm5hcGksIGVuZXRjX3BvbGwpOw0KPiA+IC0JCXYtPmNvdW50
X3R4X3JpbmdzID0gdl90eF9yaW5nczsNCj4gPiAtDQo+ID4gLQkJZm9yIChqID0gMDsgaiA8IHZf
dHhfcmluZ3M7IGorKykgew0KPiA+IC0JCQlpbnQgaWR4Ow0KPiA+IC0NCj4gPiAtCQkJLyogZGVm
YXVsdCB0eCByaW5nIG1hcHBpbmcgcG9saWN5ICovDQo+ID4gLQkJCWlkeCA9IHByaXYtPmJkcl9p
bnRfbnVtICogaiArIGk7DQo+ID4gLQkJCV9fc2V0X2JpdChpZHgsICZ2LT50eF9yaW5nc19tYXAp
Ow0KPiA+IC0JCQliZHIgPSAmdi0+dHhfcmluZ1tqXTsNCj4gPiAtCQkJYmRyLT5pbmRleCA9IGlk
eDsNCj4gPiAtCQkJYmRyLT5uZGV2ID0gcHJpdi0+bmRldjsNCj4gPiAtCQkJYmRyLT5kZXYgPSBw
cml2LT5kZXY7DQo+ID4gLQkJCWJkci0+YmRfY291bnQgPSBwcml2LT50eF9iZF9jb3VudDsNCj4g
PiAtCQkJcHJpdi0+dHhfcmluZ1tpZHhdID0gYmRyOw0KPiA+IC0JCX0NCj4gPiAtCX0NCj4gPiAr
CWZvciAoaSA9IDA7IGkgPCBwcml2LT5iZHJfaW50X251bTsgaSsrKQ0KPiA+ICsJCWVuZXRjX2Jk
cl9pbml0KHByaXYsIGksDQo+ID4gKwkJCSAgICAgICBpIDwgdl9yZW1haW5kZXIgPyB2X3R4X3Jp
bmdzICsgMSA6IHZfdHhfcmluZ3MpOw0KPiANCj4gc3VnZ2VzdCB5b3UgY3JlYXRlIHR3byBwYXRj
aGVzLCBvbmUganVzdCBtb3ZlIHRvIGhlbHAgZnVuY3Rpb24gdG8NCj4gZW5ldGNfYmRyX2luaXQo
KSwgdGhlIGFub3RoZXIgaXMgZm9yIHJlYWwgZml4ZXMuDQoNClN1cmUsIHRoYW5rcw0KDQo+IA0K
PiA+DQo+ID4gIAludW1fc3RhY2tfdHhfcXVldWVzID0gZW5ldGNfbnVtX3N0YWNrX3R4X3F1ZXVl
cyhwcml2KTsNCj4gPg0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCg==


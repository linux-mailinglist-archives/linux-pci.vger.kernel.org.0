Return-Path: <linux-pci+bounces-14607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D658F99FE87
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 03:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BBC1F229B1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 01:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A413514884C;
	Wed, 16 Oct 2024 01:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KebnLex1"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2042.outbound.protection.outlook.com [40.107.104.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798751F5E6;
	Wed, 16 Oct 2024 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043609; cv=fail; b=oozg+MGN9XRz2oWILiQ2fF77/o7fRkYz1OXW/RdVYO7RDt/OCTvOBMSu8+WzNlD6aBQubezrRd1i9eVKBHhu0StWCtPIV+Bi26chrCyyc5m8I7al+mBOub+rBdQfUs4ZdoLLa5gbPeVdsDpFanA8cBJ9subfc74c9I+Cb540NQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043609; c=relaxed/simple;
	bh=FsfdA2VGseWtKy43RJ5/YlnMy/H6om5TyV9DKpiPeJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HWCrsN73UpilMMoHEZDhE6Mw7YaD+NiesKWPjdkXBbhKjG6LBzlcNeOuHMN92xtNTe5s3YJZt9j/tx4lQu8yIziEQFXtCICnMglp5vQHkwxIHqXZpB7wbYrKCj+H0dRIAyfijaGGl0x/jI1xO6CabhKoLR9/3L4N1u51hQEoM6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KebnLex1; arc=fail smtp.client-ip=40.107.104.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHNXY1vWL1GmRTq2fcOyzhjqePqfiOGMFglr/w5F3ClWo0xm0N2oTTNo3fs4CtF42u0I0TDlkxouFZs4HBzfijQUQI8zdqkgMj5r22zcNH8p8S5tdKXpYomocxh0bPyhBb1337m7c+rAMMBjk0zbfeTOIi0qUJlVZp/5ZFEJxoHrIDcMm549FD/kygVNYtEaLX+i4NO8SDxfHwHzTZ0s8t2nY2xbtdFiyehldZerb3TFVUi6O5jPqLwwyXSoS9/Z7QomDejFLrpZV19otyqfngovg8EU5Ytc4rWoVIZZmrOPq6SKtORVfUKO5ataSH4pLwvCnCIGNBIPTGTXB3nyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsfdA2VGseWtKy43RJ5/YlnMy/H6om5TyV9DKpiPeJo=;
 b=lxVezApGb6yyluXZbZMQkMle+2mHXnqze7R4ycOBbjyZGkL4oPEub0CPeV5/qn6EgTcW0vFmjatsc+NWaDXIWOMTWpmtdqLAN/iqt6iCcI6/3VFovvi+pDlr8q5FqMFPADZveWR7OfPi/To9A0Pv6uA2WfVXQSrFD6LQGXEbUZQo30tM2fVLB9CaMwGC6dVkefVJcku2n3U/OSPWwXfiZRxxjNYIIo5np4hWFLbMjcWuNyOVs48bmL93FOI8WnEgSGXANjXSJh2EQ5zET1YBix0fAqZ9Vo174b3l1axjq+tdjgniURj1/xqncTbKLmN/WhevglPe1406ROeIdlEc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsfdA2VGseWtKy43RJ5/YlnMy/H6om5TyV9DKpiPeJo=;
 b=KebnLex1PJ3rDSHaknMP0kRa+UaR0oMBKADVEKu6f3rEWLzeW8XTA2kRDf5GjSZTo9uaUbDewqoJPFSqJN8wh1VKjtLb6AAZ3uPugCXvMAf4d7APQTeNcLBvh3A23XDwGTlvFs4YYK9OEP6e4K1RllxLDzCmFI0qD3JE9QgUoMa5RqiKfWADuK4IXYrYs/I0l90xVKMDowi2zyJYWn7nkFscPv1NnsarW3MTy7qQKg/PeoE6ueHHuaZSE08ljTWH3ZkodoIa4pC26Xm3INAKBbkvR4YhDPOBPzRBq1dA8Uvy+LQwmYw4NId7lZin+EzJ9G+UCfh9rB4UkhVAZALM4A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10092.eurprd04.prod.outlook.com (2603:10a6:800:22f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 01:53:23 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 01:53:23 +0000
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
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 11/13] net: enetc: optimize the allocation of
 tx_bdr
Thread-Topic: [PATCH v2 net-next 11/13] net: enetc: optimize the allocation of
 tx_bdr
Thread-Index: AQHbHwQuMCZTKFxgy0ODX3E59zBYtLKICNIAgACUr5A=
Date: Wed, 16 Oct 2024 01:53:23 +0000
Message-ID:
 <PAXPR04MB85102E4F3B394C363548AC5488462@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-12-wei.fang@nxp.com>
 <Zw6fKHOXbQsoV4MV@lizhi-Precision-Tower-5810>
In-Reply-To: <Zw6fKHOXbQsoV4MV@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB10092:EE_
x-ms-office365-filtering-correlation-id: de29a2f1-7bb4-482b-15b8-08dced8551a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?ZzUwWHVoRkVhV09lSFIwMStVRFR4RTdod1Vxc1RxUVhncDlXVzBvbjlNZm45?=
 =?gb2312?B?b2RudUgyT0dqcE9kYXpHc3ZZa2orV255dGo0OGtGZXl1M1BDUTJ6bjVIYWJD?=
 =?gb2312?B?eTJZMnE1T0s1NW1NeENtNnE1ZUpweFRUNWFyU3EwS3FYSnliT3BUaDlLOXRK?=
 =?gb2312?B?Yi9ORkhwcFFCQXhnVmllUjhLTzduRXhvSXRudUdQNXZJSnd2WkxEUUF1Vm0y?=
 =?gb2312?B?MUcxYitlMDFXYnlwL0JvamREMG4rT2ZWdjhDWG9OOU1TZjNLbnBrZFRpMDd6?=
 =?gb2312?B?cFlGWmFOVW01a1FYdVdldnRIenpWNTR2UXBkNUhXTXEwZU5RSGZzc3piVG1G?=
 =?gb2312?B?Z29TWWpUS0VLSjdYcmIxaGxoK21FWEZlV3JZbEQvaGQ0Z3h0SzNDdkhJc0Nw?=
 =?gb2312?B?YWNsNWNkVVdPTzY1S2dUN2RtQ0dpT0h1eXk1MUN1aFFkSHJraUE5NUNlNTlE?=
 =?gb2312?B?Z1Y0MGxEcGNwL2hEZ29weHExYTRLVzhldGEwOXFFckNnaVBZRUtMbE5OOXBS?=
 =?gb2312?B?U2t0R0p0VnRPQUtHSkliZTVkbll5TStBT1ZOcDZyN3Z0a0w5TktnNjArbFJZ?=
 =?gb2312?B?RElrSzd6ZkxLckNmMEtlVjJIUm1ieDZ4cFJ6b0x1WHVDY3dpZ2NLSW5LR051?=
 =?gb2312?B?OC9JR0NEcWRVRFRaS1BRTGJuRitBQ25tQVdVZmVOVXhEcDM5RmMyaG1OSDVi?=
 =?gb2312?B?cEhUVWZLdTJxYVZhY0ZYWGNQeFhDYXJ5a08wV2ZudnJJU1NpOXdZS0hjazJt?=
 =?gb2312?B?R2JHek8zTzh2L3pLclozN005QXpocUxoTHZ2M1haR2hWcGdOclVYNjZ5c3JI?=
 =?gb2312?B?M1d6QjhwT01MYWViWStVcmczL1B4S1JteGhGUHVpYkY5Q2FzSDgwS2RFYlIy?=
 =?gb2312?B?ZkgyVXNnWk5TMjArcU9Yd3BpeUlPQUF3QjUyR0hMUDNWNjVOVFhmd216ejNJ?=
 =?gb2312?B?OVV4czFjVlN4UzVBOFpHNGxNa083SGtQVzZYb0pwU0JjSUdZdndCS1E5RDhC?=
 =?gb2312?B?WWtsRDFGc0hiM2FFbGF1RHJ6alAya1hYMHltc0lKL1lzaGFhbTJHZHRud0dn?=
 =?gb2312?B?NlFVSEMzV2RYbkZQV1lxRS9Qdk1HVmE3b3VSOExFNnBPREt3WGdjb2sxV09v?=
 =?gb2312?B?QkEwVXZSWDhWbnFJS3JicVdaTVdaQnJMYis0ZW5TbERqY05PWTQ2NGsyMk1k?=
 =?gb2312?B?N3FKMDBhZnNCTTV2SjAzNTk5Q1p4cm1rSlRDa1dBSXhvcXBydDQrUmcxUnRy?=
 =?gb2312?B?TDJlSGwyQ00zbFE5OUhrT3ltdmVGQkg2bGI1VHArd05qUmp6amRna3BxemYr?=
 =?gb2312?B?eGNHaFM1dDVaV2d0RUNsTmNhSnh2S0VPdm9qei8ydElKZWtkVmZYbDR1cmEz?=
 =?gb2312?B?czlFdDRjT2pVd0xrY0N3VVpndStPUHZUNjRwbFUreVQ1Uk1qMkhWdjVYKyt5?=
 =?gb2312?B?cU9HVWRiK0VwRUZUSWdrTmcwMFlieGtvdUc3USsvUDQ3ZEVhQkwyRUt2TFdj?=
 =?gb2312?B?T3RiUzNkSU9ET0kwVEZNT21QVlkwTitjeUdmU1RZUWtQb2J0RlVHTGNrT2M1?=
 =?gb2312?B?QUhCNElUbHYrOEc2aVRPUzZmS0o3eTk1K0lCcG5lNlhWRHRmeU05c09KNmh2?=
 =?gb2312?B?VHp0RFpJZ3hzaHg3N3dXTnk3SzU1T0hIUDB1L0ZvNDNzRDcxclJaWkNxaVow?=
 =?gb2312?B?NmpFKyt2Sm0yRitDcUh4N0d5SU9VdE1xU3VnKzRPNTVuait2ekV4VFRZL2Vm?=
 =?gb2312?B?cEtUOFY1TkZFa0lHMTNQcHMxeTY4NkkyUlZtWThIVndwVHJPbis1YVJrU3FI?=
 =?gb2312?B?ei9EYzY4SkNhbVVpQTByQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?T0N3azB5Ulo5OGZkQ0o2OXliOGcyekhJdU5zVWpIWVN1Ny9KSkxSUTdlV0NU?=
 =?gb2312?B?SmdaZ0dqSEU4aWxHemRtZ2RUZUVQZ2ZuZ3E3OU5DZnNrUitWMElKTFZFWWZh?=
 =?gb2312?B?OVdzelhHSWJzNnQzU2tjUkswTWh2NTZyVjIyL3NKNkszUnF0N0lUQlhySzc3?=
 =?gb2312?B?YTJsMHpmWHpwSWVhYjgrNkczcTJ5S21iS3RKZUsrMGhCU2NBNEllak5ja0p2?=
 =?gb2312?B?VHB5VjVYU1ZVcFhzUzg2eXFlSE9IMUxneUxBN3gyNVlIRmtWQ1JsVCtnOXcr?=
 =?gb2312?B?dzV1NXhnV2NFOVdyTDc3UDJac25kVXU0d1BtVTk0eVYxZ21uL2dhS201WURH?=
 =?gb2312?B?dFJuSjRhdUdZeEg1c3gvNmpHc1M1Q2hXT01HTWlCd2NIL3VHZ2RaRVlLNW5U?=
 =?gb2312?B?RHNUNGxZeW4wa0hsRW1tRTlPWlZwWWxWbWRqVVlua29kalViWjRoTVZiSVFz?=
 =?gb2312?B?M2gxVmpoVWhXZEZkclFiVXhpZW5TZzdYNkZYazZ0L2diWWFLRWNwUTZqdFph?=
 =?gb2312?B?bHhIOGFTVlhjNGhIMkRQYUg4WEdYUE53U2tlUnlDMzNJTjBiMVg1ejI3UmRY?=
 =?gb2312?B?eWJrRU9SbCsvbyt5QTMzQUxXOE5tRmp2VDJRVlZwL0dGSEJWb0dHd2tGam5n?=
 =?gb2312?B?MlhKdUt1dWpYY2hwbnBVeHY0VnhsMmd0ZDBydDNZdjg3ZmxIeVFZLzF6M1E5?=
 =?gb2312?B?dmpKb2lsT0p5OW84T21HV21wVXdLQ1JOM1FQWnpnY0NtMjI4OHNUVGZWMDM0?=
 =?gb2312?B?aFBtQUU5WjRhV1hRNFQ4ZVdoSHMvK09WakIwUTRsQVBOekE3S3JqRUJPSlp1?=
 =?gb2312?B?bUJ2azVPWWZEaU55NzVGWjJ2bUMxRnBXRjdBdU50akx6MlBFQlh4S3RqcGF2?=
 =?gb2312?B?S2RxK2FSVDlLa0Myd3lkclMreGhWeDhYOFZMZTlhQU1TTlpNcDI3aFNRN0t5?=
 =?gb2312?B?NjJ3M2lXNDNQQjVnekFnZ0szRktTTk5MemxOTXBtUTZZSTd1dFdWcjhmMW1n?=
 =?gb2312?B?T1E4NTF6OHFIQThvRjRFS3k1dDd1NS9RY1FhMy9GR082ZmljZUt1Z3Y3U1F3?=
 =?gb2312?B?QjFtR2xRd1lzMWJPcXF1cEl6Rk1JSW5WWldWeFpaa3doaHVZSWx2Rk9lam1W?=
 =?gb2312?B?S2EwREI5cy9kZWJPK1VpYUtDOFdueHVoQWk2ZzNnR3lHVFBOME9pN3JMZHNI?=
 =?gb2312?B?dnNaY1lMWGlxQTdma2s4dUdhck9TNFA5YWdDSU4yRGVOdGs4NzluNzkvT3h3?=
 =?gb2312?B?MmpSMitVWU1mZkxGMmFGdUtOdkNLaXRXVDE5c1ZETXhIcW1OaFpFTHhQWVJW?=
 =?gb2312?B?MnhVZUxHYXV0alVPTHVIN3M3Q1BQTlNRdEhTT1NjVFlZSFNsTDk4TjJZbmMr?=
 =?gb2312?B?R0Y1dEllMy9wZE85OHR0aXoveURsa04zVDdNeEVyRUZJS1dhRWVpRnE1TFFq?=
 =?gb2312?B?d21VYnpRVklMWDNXWkR2cy9WaGcycjFpM3ZHZHFnaUdoek4vT1lZQmNaaVk3?=
 =?gb2312?B?SGYwYTYrUlNLYW9nSi9xNVE3UEQ2SzUzWDhBT2U4Y2ExbFpLbEpKc0xQTTAw?=
 =?gb2312?B?UTgyUmN5VENIbWd0NFJZRGVoRjU4T2dYYUE1bjl5Mnp0d3Bjb01vRnVVM1cv?=
 =?gb2312?B?Rnp3dXlFK052ZXBMZUt4Y1gwSzBZRllxSXZscFJsVDhYYzZ3d0dRUHBzMFpu?=
 =?gb2312?B?bUV1R1k0SEV1NDRlcHRPV3h1S3ZJYkx4bVpQYi9scVIxOVc3N3ZHYm4vT09a?=
 =?gb2312?B?Y3F2bi9HamNiSDV2RFJtQnZFU2JIaFVGdW43SDg2emxFQ3F4d2JzNTlFUTlH?=
 =?gb2312?B?WmpZMDBNL3lzby9BeTFjZHpSSlBoZ2pUSzA0THUzb2RoM1RRRFZCeDZtSFRP?=
 =?gb2312?B?dnJvcVdQZ3hFNG9zTlhqTGJ1a1AvcG9hUkhWT0w3a1l3TTFWUGI5RHZ0L2xO?=
 =?gb2312?B?b2pJWWptQmJmbkRIUzBMdVA4SFNreW5lZGZkc1ZudTBBVWVwbXU2S1g3VW1E?=
 =?gb2312?B?RkEyRWtGSlVNY3V1UEd2U1F5cGU0ak9DbjRFSGY0NC9YTkxPUXl4Wko4b2p6?=
 =?gb2312?B?ODd6dzhXRVVYV1Q1ck9KOVRadnlhNkhRT1JOZCtubWhnOWJUNEsxZ0NkNG95?=
 =?gb2312?Q?9zNw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de29a2f1-7bb4-482b-15b8-08dced8551a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 01:53:23.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NePUi9uMxGEKchEI0HjfB0pazy5PuJp+2pQ2Y/yaaNO87LmTVSBakypst9QQ8W2NHcPqHV9ddau8P93WP9gUWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10092

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjE2yNUgMDo1OA0KPiBUbzogV2VpIEZhbmcgPHdl
aS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29n
bGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyByb2JoQGtlcm5l
bC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgVmxhZGlt
aXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47IENsYXVkaXUNCj4gTWFub2lsIDxj
bGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29t
PjsNCj4gY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1OyBsaW51eEBhcm1saW51eC5vcmcudWs7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGhvcm1zQGtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51
eC5kZXY7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgbmV0LW5leHQgMTEvMTNdIG5ldDogZW5l
dGM6IG9wdGltaXplIHRoZSBhbGxvY2F0aW9uIG9mDQo+IHR4X2Jkcg0KPiANCj4gT24gVHVlLCBP
Y3QgMTUsIDIwMjQgYXQgMDg6NTg6MzlQTSArMDgwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gRnJv
bTogQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPg0KPiA+DQo+ID4gVGhlcmUgaXMg
YSBzaXR1YXRpb24gd2hlcmUgbnVtX3R4X3JpbmdzIGNhbm5vdCBiZSBkaXZpZGVkIGJ5IGJkcl9p
bnRfbnVtLg0KPiA+IEZvciBleGFtcGxlLCBudW1fdHhfcmluZ3MgaXMgOCBhbmQgYmRyX2ludF9u
dW0gaXMgMy4gQWNjb3JkaW5nIHRvIHRoZQ0KPiA+IHByZXZpb3VzIGxvZ2ljLCB0aGlzIHJlc3Vs
dHMgaW4gdHdvIHR4X2JkciBjb3JyZXNwb25kaW5nIG1lbW9yaWVzIG5vdA0KPiA+IGJlaW5nIGFs
bG9jYXRlZCwgc28gd2hlbiBzZW5kaW5nIHBhY2tldHMgdG8gdHggcmluZyA2IG9yIDcsIHdpbGQN
Cj4gPiBwb2ludGVycyB3aWxsIGJlIGFjY2Vzc2VkLiBPZiBjb3Vyc2UsIHRoaXMgaXNzdWUgZG9l
c24ndCBleGlzdCBvbg0KPiA+IExTMTAyOEEsIGJlY2F1c2UgaXRzIG51bV90eF9yaW5ncyBpcyA4
LCBhbmQgYmRyX2ludF9udW0gaXMgZWl0aGVyIDEgb3INCj4gPiAyLiBIb3dldmVyLCB0aGVyZSBp
cyBhIHJpc2sgZm9yIHRoZSB1cGNvbWluZyBpLk1YOTUuIFRoZXJlZm9yZSwgaXQgaXMNCj4gPiBu
ZWNlc3NhcnkgdG8gZW5zdXJlIHRoYXQgZWFjaCB0eF9iZHIgY2FuIGJlIGFsbG9jYXRlZCB0byB0
aGUgY29ycmVzcG9uZGluZw0KPiBtZW1vcnkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDbGFy
ayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIEZh
bmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gdjIgY2hhbmdlczoNCj4gPiBUaGlz
IHBhdGNoIGlzIHNlcGFyYXRlZCBmcm9tIHYxIHBhdGNoIDkgKCJuZXQ6IGVuZXRjOiBvcHRpbWl6
ZSB0aGUNCj4gPiBhbGxvY2F0aW9uIG9mIHR4X2JkciIpLiBPbmx5IHRoZSBvcHRpbWl6ZWQgcGFy
dCBpcyBrZXB0Lg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZW5ldGMvZW5ldGMuYyB8IDEwICsrKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+IGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmMNCj4gPiBpbmRleCBkMzZhZjNmOGJhMzEu
LjcyZGRmOGIxNjI3MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVl
c2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVz
Y2FsZS9lbmV0Yy9lbmV0Yy5jDQo+ID4gQEAgLTMwNDksMTAgKzMwNDksMTAgQEAgc3RhdGljIHZv
aWQgZW5ldGNfaW50X3ZlY3Rvcl9kZXN0cm95KHN0cnVjdA0KPiA+IGVuZXRjX25kZXZfcHJpdiAq
cHJpdiwgaW50IGkpICBpbnQgZW5ldGNfYWxsb2NfbXNpeChzdHJ1Y3QNCj4gPiBlbmV0Y19uZGV2
X3ByaXYgKnByaXYpICB7DQo+ID4gIAlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHByaXYtPnNpLT5w
ZGV2Ow0KPiA+ICsJaW50IHZfdHhfcmluZ3MsIHZfcmVtYWluZGVyOw0KPiA+ICAJaW50IG51bV9z
dGFja190eF9xdWV1ZXM7DQo+ID4gIAlpbnQgZmlyc3RfeGRwX3R4X3Jpbmc7DQo+ID4gIAlpbnQg
aSwgbiwgZXJyLCBudmVjOw0KPiA+IC0JaW50IHZfdHhfcmluZ3M7DQo+IA0KPiBOaXQ6IE5lZWRu
J3QgbW92ZSB2X3R4X3JpbmdzLg0KDQpKdXN0IHRvIGtlZXAgdGhlIHJldmVyc2UgeG1hcyB0cmVl
IHN0eWxlLCBvZiBjb3Vyc2UgSSBjb3VsZCBhZGQgYSBuZXcgbGluZSB0bw0KZGVmaW5lIHZfcmVt
YWluZGVyLCBidXQgdGhlc2UgdHdvIHZhcmlhYmxlcyBhcmUgcmVsYXRlZCwgc28gSSB0aGluayBp
dCBpcyBtb3JlDQphcHByb3ByaWF0ZSB0byBkZWZpbmUgdGhlbSB0b2dldGhlci4NCg0KPiANCj4g
UmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiANCj4gPg0KPiA+ICAJ
bnZlYyA9IEVORVRDX0JEUl9JTlRfQkFTRV9JRFggKyBwcml2LT5iZHJfaW50X251bTsNCj4gPiAg
CS8qIGFsbG9jYXRlIE1TSVggZm9yIGJvdGggbWVzc2FnaW5nIGFuZCBSeC9UeCBpbnRlcnJ1cHRz
ICovIEBADQo+ID4gLTMwNjYsMTAgKzMwNjYsMTQgQEAgaW50IGVuZXRjX2FsbG9jX21zaXgoc3Ry
dWN0IGVuZXRjX25kZXZfcHJpdg0KPiA+ICpwcml2KQ0KPiA+DQo+ID4gIAkvKiAjIG9mIHR4IHJp
bmdzIHBlciBpbnQgdmVjdG9yICovDQo+ID4gIAl2X3R4X3JpbmdzID0gcHJpdi0+bnVtX3R4X3Jp
bmdzIC8gcHJpdi0+YmRyX2ludF9udW07DQo+ID4gKwl2X3JlbWFpbmRlciA9IHByaXYtPm51bV90
eF9yaW5ncyAlIHByaXYtPmJkcl9pbnRfbnVtOw0KPiA+DQo+ID4gLQlmb3IgKGkgPSAwOyBpIDwg
cHJpdi0+YmRyX2ludF9udW07IGkrKykNCj4gPiAtCQlpZiAoZW5ldGNfaW50X3ZlY3Rvcl9pbml0
KHByaXYsIGksIHZfdHhfcmluZ3MpKQ0KPiA+ICsJZm9yIChpID0gMDsgaSA8IHByaXYtPmJkcl9p
bnRfbnVtOyBpKyspIHsNCj4gPiArCQlpbnQgbnVtX3R4X3JpbmdzID0gaSA8IHZfcmVtYWluZGVy
ID8gdl90eF9yaW5ncyArIDEgOiB2X3R4X3JpbmdzOw0KPiA+ICsNCj4gPiArCQlpZiAoZW5ldGNf
aW50X3ZlY3Rvcl9pbml0KHByaXYsIGksIG51bV90eF9yaW5ncykpDQo+ID4gIAkJCWdvdG8gZmFp
bDsNCj4gPiArCX0NCj4gPg0KPiA+ICAJbnVtX3N0YWNrX3R4X3F1ZXVlcyA9IGVuZXRjX251bV9z
dGFja190eF9xdWV1ZXMocHJpdik7DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=


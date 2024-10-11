Return-Path: <linux-pci+bounces-14254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A023E9999F5
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 04:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1EF1F23EF1
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 02:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD13214A85;
	Fri, 11 Oct 2024 02:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NfFq3L4t"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EAD2F44;
	Fri, 11 Oct 2024 02:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612343; cv=fail; b=ZtTm156kLw09S3lIn4eOaLZdWqYgRfjkb8+unS8mB0wJkUoP6i45oexJgSlErtSz2C7lAKH+zSS79B/41GoAjtUR07OA3XFFZE00ydX19KmjWn5vJX9NCVTiuz325r9SVKrlf8bL9G2ovtakHNr4o6v1H08jBiIKzYkSJahS1Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612343; c=relaxed/simple;
	bh=NRyuB0NToEdlQwcAE7yAlHs02SBko8636467FxI0Upc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q6/VMLrC/xbfvnVuS22p1R7A2z9IwuZ82EEjEqZGhuNgck/Tibj+uHR8aNe4S5pBW2iP7aqCgEIDtKk9tkO73Roreye6qTWO/bB/an34zU3ijDCFTAQt8wVF0fnhz14fZqiHK5VJPCFN2NCMQV+cbsP+Vp6QyrB9+2wSQhELAKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NfFq3L4t; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBj5QHdNsYHbmIFjh0v+X18qDyr9FhvQrh3bwFnLsBuSDGIXJxw8UEbGcif+kamDF7Vw160JI9KjQT9JhhSV3laF7LTvfYj/NzjDlRvIpkESZB4VLc2L+ieE+tCo2PS1TFvkzCwEsdpPMgC2JVFpZTHAHKb1lVF9hzlQ/VvnUGZAjXjizmx71rrLbjEHDaFh76zusDqtDpu+dxR85zlysmzljJ6xYbrPC2baS2nily5xmlbYEqeUXFCClHzN+YTkvrZDYNWqOcynAzwm3b3riSVZy1fmL6+5okZEKN1RDTIe+0VvKU0cVsqF3INdBYqyb2a6KyS7v0auOuEn7mJW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRyuB0NToEdlQwcAE7yAlHs02SBko8636467FxI0Upc=;
 b=BuCmZKxsjRGS63sfNV7m1l7eCiSwbDUa1IvV7yx9A56yCOXQrRHxfSGru2tqoaIBb94g2anhDDyRXWV47xDglZPZH3N2FXdIE8S0vfR6NjHKPzbiA6ps1Hp9EkEUQRWYsSe2zu0tNCNicrL1j6ClulqQ6y8gjAgZ5O89rCfVirHUqajwYHEDT2P+Xg3HjGM4cpb2ockygrjW2smK1DN+NvHWBKVXsL2I54DDmXVJ8qh7M8zWj9vFiDw1N+DqmFyUPRgt5X5ZqSqGVY2fZxPYbr0epmgiD7jQlCDiSMTvKOJal8u4oFwhgfMdDPl67EuzDDccxMnSWD38hj2PSwxdMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRyuB0NToEdlQwcAE7yAlHs02SBko8636467FxI0Upc=;
 b=NfFq3L4tHsLMvsBvkcKysM2NeLq23hlUDrnFPL53UW1fALzvq7/GpOjCqG6skq0KySIcQUWVASFVV+JYcQv6dF+Q/lrN+Pbe1nzxdN/369DSEpxuXd5phMJDIfXfjPrKM3cEz3z2rKhG7mioOEgK0LNrFt1z3M/Dehhpa6gVgHpgMC3beBn+fxQugn9Zm20rWlV3Ite5z3oKAJ8kf8PBqzUyjJjGyXEcIrxTb3jreUGCT7mch3iC2w6ZoZFTwVyMvUO2xRM1AF5RC+aop18RTDBf9mrfjbQcr9KWDhdHpY03i13uBnKaZI3/UabFKi0GuQKU29Y1HeOpv01Z7qAvEw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB9443.eurprd04.prod.outlook.com (2603:10a6:10:35b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 02:05:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Fri, 11 Oct 2024
 02:05:37 +0000
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
Subject: RE: [PATCH net-next 11/11] MAINTAINERS: update ENETC driver files and
 maintainers
Thread-Topic: [PATCH net-next 11/11] MAINTAINERS: update ENETC driver files
 and maintainers
Thread-Index: AQHbGjMG0icrobd2ckyrkNnSVruYHrKAXqiAgABwiDA=
Date: Fri, 11 Oct 2024 02:05:37 +0000
Message-ID:
 <PAXPR04MB8510EF1F7A375A16211F26CF88792@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-12-wei.fang@nxp.com>
 <ZwgpF3CJepAklWeT@lizhi-Precision-Tower-5810>
In-Reply-To: <ZwgpF3CJepAklWeT@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU0PR04MB9443:EE_
x-ms-office365-filtering-correlation-id: 9d48a109-efea-4d9f-64ef-08dce999331a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?VGJqdStXNWdKdVhpd0lFS1JFOFkxZFAyNjdUK3MyN1R1UEU1bzJWWndNT3JI?=
 =?gb2312?B?MWtGdytqWFhONVBYSXF6QmhVTnhPM3RQRlJ1UFpmbXNPZUhieUViTS82MWh1?=
 =?gb2312?B?dUUwUmZnUUxTZk1qYVZxK2tSS2xFNG9pVE1QMktGWS9yY3g1ZUJNVndRdURo?=
 =?gb2312?B?VGF2S2dZam9vWDZwckRYVml1aGxwek9VK0dod3ZTdFBUNFVUbWtKZE5PbzY0?=
 =?gb2312?B?c2VCOS85cXhnaDVNQ05rMDhaamlUZzhna1FFUTZ4dktYNW9XMkJrOSttS1pN?=
 =?gb2312?B?VWhFZzRIV3NqcmNCNlBQbnZtdlNjMERZNmRFdUpVOUJRd0ZIemhkdXV1TUFL?=
 =?gb2312?B?WnFlNkIwYXZneCtKenRWRXV3QklNSE51amhsZVBIQ2VENVptUXJYTkIwTW1v?=
 =?gb2312?B?UzNSZ2xIOHdIVHNMSFpEbDhKMlpjOHRjaXhpZ3RqcGZhelBtSmN4TnhFVFhu?=
 =?gb2312?B?Z05QN0xiRzdnc2d4RXk2L3owSE5zUU5aWEhoVThPN0tYaXdyeFVzcW1DYVJT?=
 =?gb2312?B?TDFlYW1ZbW4wQ0VXQlU3d2dGaHNaK0R3cUhBSkxaN1BOR21zWWlmRlNNRkRh?=
 =?gb2312?B?OWkwSTdnOExuTW1EM3dkS25WUHdjOG1zVDZFZkwrYzhTNStMck1mSVl4bTJj?=
 =?gb2312?B?NjUrRS9mOGNRMzFZRVp2NnIvNnRLYjZDMGZVT2s3WEpSbFJJd2hHR2pUZVV1?=
 =?gb2312?B?OEZHRnUyUjhXaDBvbHhqK1R2aE0ycU9mbFR6VjVNbEhVYmVUa2dHNnVHM1Fl?=
 =?gb2312?B?Um9FYjAyYVNwZm51Y1hsT3RXcFRsdS9WQ0x5S29yanFGU1l1aGVDMDkrL1Na?=
 =?gb2312?B?N3BNL2Q3ZDJIWXR4Qm4waXRkb0hqcytSRkRzdmo2dTQrL1dsOWJiRExhYk5h?=
 =?gb2312?B?U3dCZllFcENEdno5eWpzM3g4cGF3TGlsNzFLQkFqd2R2dmdSSUo0eVkrcVR2?=
 =?gb2312?B?dlR6MWxudnJHYXo5MGtkN0ZXUi9mUVE5d0txcGN4KzI5MDBCZlUwbEkzRkdk?=
 =?gb2312?B?VXlGV1ZQQXp5cWdrQ01iYUNmTlpjVllzQWFCUzNJYTh5TlFpc3BtSnlmait1?=
 =?gb2312?B?dlA5RmxrKzR2MHhRZVNTNjJyRTJXRS9kMlVrZVdpcWx5Qm1NRGVZdzdTTGZU?=
 =?gb2312?B?UnlFMGJRZG5VTkN4aFRqOHlVVENyRVpqdFl5MXN1RHNHTDVyM1RKZzdhaEhX?=
 =?gb2312?B?YmVJNEthODdUZDBjZURScWJJaVVNai9yU0pHVWdvbFBicWh6MXNYZDU3T3I5?=
 =?gb2312?B?T3htbXUxWWgxbnBBbzVvaER0SlFYSlYyOWl3OXFzVWJsR2JHTVBoaFpReGpO?=
 =?gb2312?B?SDRsOU9jNWtrTmtPNDVIVTIybEZ1WHdScE5VVGxLVTVxbnBQYlAvQzJyV1VW?=
 =?gb2312?B?ZUsyQjNYRnZIUlhnM0U1eHRSMUJJVitKUmk0SnUwdnZZMk9IOUlRRjFuaUdY?=
 =?gb2312?B?Z0ZDd000QVFnaDAwaExJZkk0Z3dkMmU5RzJMQXBoLy85dUxsclovRkVUY1FC?=
 =?gb2312?B?M2crTTZ3aHdHaEpXd3BuWUNETXRVY0Z5Q2ZsSDJHeTNURFNGYXdtNTc5b0tm?=
 =?gb2312?B?aXJFZEtET1RCd1JsSUlrcHBmazFGNm5EYVpNM2RIM3VsbDhXVkhjdDBPbEd4?=
 =?gb2312?B?S3pteWd3Q0FpWWFERkYzVjFNVFBxWm9nTXphMGpiSnZNSjM5R0h0dmlCZ25j?=
 =?gb2312?B?Z0pSeFFuWXVjeUlXOVJZam5xLzRrL1plWjc4dXBsZkRqNE9LOVl4VHRWTHhZ?=
 =?gb2312?B?SFl4NDF0b3FJanJ1SUpqNm1LbWt5L1dzcjdiL1QwZG1TMVF4Q1JVS213S1l2?=
 =?gb2312?B?dDlZeWFMUWlDUTNyckp4Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?U1Boa2ZtekRlTldHZEVxUWZOVHpuMXdsaFZ5UCtveHd6aGpabzBreHZ5b0N5?=
 =?gb2312?B?TjkrakxkVE0xYVJJa2JETzgzSi9FOGlqakxFVWRmWGFrVTJBSXZsMDdnSG9E?=
 =?gb2312?B?cm94ejhjeWdOYlcrNzlNSkhHWEdKWjd2bjJ5VmlZejc4d3FJNHBGbWx2SFMr?=
 =?gb2312?B?MTB5N3ZmQXZyVlp6QTJiQjVnU2pFUFYvbjJNZGxtNFU5UVFJWGVTcituY3I3?=
 =?gb2312?B?MjFOVisvMWc3VTJKSUlycEZaUEVMajNzSTRsQXZGVUgzTWRVdWNmWE5tSndn?=
 =?gb2312?B?MVJabjRzREdXZkVwd1NtY0NYR1Joa0o3WjFsbmtMZFhLQ0NxV3lmY0ZuQUdN?=
 =?gb2312?B?cTk1cktMVjg1ejdqMDcxdVN0SDBqVmpycyt4ZkFoZ3RtUnd4ZjRnZkNBWUZu?=
 =?gb2312?B?UmZ1aHhrRTBtUkVJYU4rcWZ6cTQ5cFhKRkZiaVljQnR3MzhPUjZyY1JudU5v?=
 =?gb2312?B?N3Irc0hDMDVhbDZkdjhHb0Y3WEY5NWd5R08raTZjZmx5TGQvNUpIV0o0cmZT?=
 =?gb2312?B?dVZneStRbEh2OVdsM3RFbG14Vk92U1JBWUI1d0o5S1Buai9qVVVaTENEVVRU?=
 =?gb2312?B?bHdBblBvcmp0c2Q0dDc2L3N0OGx0VlZlSGJHNW03N0xBWDc0a3FlNXZ3N3Nu?=
 =?gb2312?B?ekxIRnZSYmZ3dVFiQmt0bThWdFh6U2VseFZwLzVvRVNBVzYzanVJVlZGemZ3?=
 =?gb2312?B?eVlhclZ3SklWdXFYT2dsUjJpeEU2ZGo3RGVnK09RTk1kS0dENmRPMXhJTVRz?=
 =?gb2312?B?SE1YZDNERDdHM3dIcU1CQklXUmc3cDRYSkM5RUk2ajlCYi9PQ1p2aVNRT1Vm?=
 =?gb2312?B?aDh4TU9CbVhIU0J6dGlVQzdpSlhmaFNmYVBQazk1YVJXaXNxRDI2S2t5c3dp?=
 =?gb2312?B?eWlKLzM5WDRmYmZkM1lOT1c1L1owVW9WQ3AwbTdEM1IyNTlBNnJkV1JCejdk?=
 =?gb2312?B?RTl5dlRVRTN2K0lnR2VtMmJKR3NsQnZVRVZkQnJxNUxNT1BpS0VRRW04N2Nw?=
 =?gb2312?B?M2pJWFJjL1RSQTFycjNaNHppVlFUVkYxL2tQRnBQTi9PVzJ5NkI1OHZlNEs3?=
 =?gb2312?B?UzQ4TXVYdlFyVjFmU2pzV0dDSHFSRjQrTmJTb0liU0Y0U3BodXpPZXpVelF6?=
 =?gb2312?B?aCtDQU80OWpqMkdCZFZhYUl1ODd5K3FQblBGbUVTc1dWV2h3cG4yUWM0Qi9D?=
 =?gb2312?B?WVBZYW9FbGtzS0RPaG1Dbmkyd3VXc3FRU2pPUGRUc001WmFDNU5BRFhqbitQ?=
 =?gb2312?B?Undxa0R2dFFwci9QWGN5b0NLclpiV2tuMTBKMnJDcWR1SlhLYW1YUHIvakJP?=
 =?gb2312?B?LzdRbnEydDFVaW5mcXNFV1ZvckUxZm52RWFoSXUxSHEvSGt0c1U3VDBFUjVC?=
 =?gb2312?B?bkUza1k1WDlDcE5mL3c2UjYzVTMxdkp3V2hYQVBHS1pKd1BrdjZNOWVVbExF?=
 =?gb2312?B?Q3gvN2JyRWJsT1JreWxzVGd0KytiQ1kra1JnOUtJRE1kbHV1Sk41SW1KVzB6?=
 =?gb2312?B?OCs2RExDTVRya2NPQU9RSzJqNnpEN0hmZEtYcnVPMEhmUTVnNWFueWVxaHJM?=
 =?gb2312?B?dG9rc1NnN0hOOGN5c2hRenFtVnJsbVZtTGVJTXBRaFNCTlhvbkoxVFFYM2d3?=
 =?gb2312?B?NVdWTHdpaTdLN2JQcVh2QlBMT1l3NGdzN1lmeFE2MWxCZ0ozYmhXRWcxb2lO?=
 =?gb2312?B?ZFBnRW9oYytLYU5QMUtQeTN4RGhYMEVTckN3RkZUMy91c0VOdXZkdllIM0ZV?=
 =?gb2312?B?YnVHdW8xZ3RsMy82ZTRMQVJFbURpUTl2WUYyaVhKTzZBRjdNWmU2RytkSEZx?=
 =?gb2312?B?U3puaEw1UHEwUXI3Uy85VFNiUWxpeHlhZWoxWkloMWJYckZyekI4ODdEbmZQ?=
 =?gb2312?B?UmlmSHVXUzJuaGZBYkRIMTFUNjhyMDYzSERxdFpMd1NJQmthWXZ5VXNWUElH?=
 =?gb2312?B?d3E4U0w4N0daWHY2OXNvMGNvRUtDeVVmakowUGVTaEJTZ25XTDdJODNhMmYr?=
 =?gb2312?B?SkNXK0hCVmlhaXYxaWN3NEtaakJvSVNjK1JtcFdpQkNMaW9qU3UvTHFQYTJD?=
 =?gb2312?B?OC9wcGZ0MkdkY2J0dFJoM1ZTSlRFelk3M2lBaWhCbDJTY1pQRUhFUi9TQkZ1?=
 =?gb2312?Q?j8Ro=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d48a109-efea-4d9f-64ef-08dce999331a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 02:05:37.5775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9/Juzb2LnxEjhIRppMAEvXQMMiIn8bZxEz+eh5z6WTI/65AipK8Lvyo+wTyDUHbzq8XVzi6/1Km54NpFe8Ttg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9443

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjExyNUgMzoyMQ0KPiBUbzogV2VpIEZhbmcgPHdl
aS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29n
bGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyByb2JoQGtlcm5l
bC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgVmxhZGlt
aXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47IENsYXVkaXUNCj4gTWFub2lsIDxj
bGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29t
PjsNCj4gY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1OyBsaW51eEBhcm1saW51eC5vcmcudWs7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggbmV0LW5leHQgMTEvMTFdIE1BSU5UQUlORVJTOiB1cGRhdGUgRU5FVEMgZHJpdmVy
IGZpbGVzDQo+IGFuZCBtYWludGFpbmVycw0KPiANCj4gT24gV2VkLCBPY3QgMDksIDIwMjQgYXQg
MDU6NTE6MTZQTSArMDgwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gQWRkIHJlbGF0ZWQgWUFNTCBk
b2N1bWVudGF0aW9uIGFuZCBoZWFkZXIgZmlsZXMuIEFsc28sIGFkZCBtYWludGFpbmVycw0KPiA+
IGZyb20gdGhlIGkuTVggc2lkZSBhcyBFTkVUQyBzdGFydHMgdG8gYmUgdXNlZCBvbiBpLk1YIHBs
YXRmb3Jtcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBNQUlOVEFJTkVSUyB8IDkgKysrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9NQUlOVEFJ
TkVSUyBiL01BSU5UQUlORVJTIGluZGV4DQo+ID4gYWY2MzVkYzYwY2ZlLi4zNTViODFiNjQyYTkg
MTAwNjQ0DQo+ID4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gPiArKysgYi9NQUlOVEFJTkVSUw0KPiA+
IEBAIC05MDE1LDkgKzkwMTUsMTggQEAgRjoJZHJpdmVycy9kbWEvZnNsLWVkbWEqLioNCj4gPiAg
RlJFRVNDQUxFIEVORVRDIEVUSEVSTkVUIERSSVZFUlMNCj4gPiAgTToJQ2xhdWRpdSBNYW5vaWwg
PGNsYXVkaXUubWFub2lsQG54cC5jb20+DQo+ID4gIE06CVZsYWRpbWlyIE9sdGVhbiA8dmxhZGlt
aXIub2x0ZWFuQG54cC5jb20+DQo+ID4gK006CVdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0K
PiA+ICtNOglDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+DQo+ID4gK0w6CWlteEBs
aXN0cy5saW51eC5kZXYNCj4gPiAgTDoJbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiA+ICBTOglN
YWludGFpbmVkDQo+ID4gK0Y6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
ZnNsLGVuZXRjLWllcmIueWFtbA0KPiA+ICtGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbmV0L2ZzbCxlbmV0Yy1tZGlvLnlhbWwNCj4gPiArRjoJRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL25ldC9mc2wsZW5ldGMueWFtbA0KPiA+ICtGOglEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbmV0L254cCxuZXRjLWJsay1jdHJsLnlhbWwNCj4gDQo+IE1p
c3NlZCBlbmV0Y19wZl9jb21tb24uYw0KPiANCmVuZXRjX3BmX2NvbW1vbi5jIGlzIGluIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy8NCg0KPiANCj4gPiAgRjoJZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjLw0KPiA+ICtGOglpbmNsdWRlL2xpbnV4L2ZzbC9l
bmV0Y19tZGlvLmgNCj4gPiArRjoJaW5jbHVkZS9saW51eC9mc2wvbmV0Y19nbG9iYWwuaA0KPiA+
DQo+ID4gIEZSRUVTQ0FMRSBlVFNFQyBFVEhFUk5FVCBEUklWRVIgKEdJQU5GQVIpDQo+ID4gIE06
CUNsYXVkaXUgTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPg0KPiA+IC0tDQo+ID4gMi4z
NC4xDQo+ID4NCg==


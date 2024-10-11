Return-Path: <linux-pci+bounces-14255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8C89999FE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 04:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2BBAB217BF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 02:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898CD199B8;
	Fri, 11 Oct 2024 02:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gYz/oaV9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CA017BCA;
	Fri, 11 Oct 2024 02:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612380; cv=fail; b=upO3+DKaAm/A9u7CKwCgE5JAo/YaOl+NuwUcoiDba4HOhuMTPKtsaYEq+1DiXS2p35xF8asTLs5z6GJH5ChupuNDJeOXBo82gRzq4sZMgHW8m36Ta4U4s5BaQVVbxd41hzPI+EatSbdLU4Sw7yuPr+AwqSbMu/09T2HN+8YD+jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612380; c=relaxed/simple;
	bh=DHr+T1dz9EWonFrE+Bk55eiazarZwdHHMRLMwGB4HbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gQWE6mju2+m3PPbKsB1N7aHOkaTWb1LEvetcNdEXvxGnLD1YZlGbs2NHizas3xAWK1WT3nIqCNaS/yJSgoLWrKJxmoU5+8lPWh0tQhAGWbJwF7X9UdXeDKUemf+JKgVKJbrKuicrDIWccyN1kVsfxVYLvaBZgfZZF/DGr2UxExQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gYz/oaV9; arc=fail smtp.client-ip=40.107.104.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjMm0NgTSi0dZxNX4mAFJsvkCOf0Rg/dMbA5GF4PC37Du0A+MXAIAQZuPYsjPsSZ7N0CqlCBXaqUXNiJb0O2+pxP4+pqRrAyAi1qjnkwK+wdvXHyuCyucc/PCzro3a20Hv9Xxcs3h7riO6aweGT+mZGEyrxYeBsJNk0LyPtz9jdw/qgLoThbjCUC45IEG+pS1129lW+S7qfSMnC6lktUCfhJ3bP20MauXYpPriB7GRZgeBvkiMTVoYTs2/mIgDlNGXKWzp3RYGdNwRQR/4NU+V/J4U0NLYZlmLgXI1ID8EfhiBxdWi6cX9MFOnl7su5VNUgZqT5xq1+RS5m83rFGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHr+T1dz9EWonFrE+Bk55eiazarZwdHHMRLMwGB4HbI=;
 b=kc6PJmX2d0bCdy2moUCN7E4RqnetYULBgQ6xl31SZFIGvzSef5z/C/WtcDi3lm5pHdVYgJhyrfoOjZNRwdxga0vwzKoJy2T4vWi8mdk37JD2lMwW0GoQ+ThQbF+R6oqf+ZJ1HhhoM9JJ2ULv8AJYzLvk/x3If7XCOZ3C6UNHfSuONmAa0iq8vBOj2wd6nxvdOh1zjrntN+Il+0voqDbkITyGg/Pf0SpJoRWNu2Vbz/5T2hrMumFAmMAyTOe28SVVjJGNmlLJwPsxTwaKf0XG9aK408Fulu3OUTj9CkdAYs7jWAT3s/NrqmhZZDVv8E3fRV/R3f6B7TcttpJ0zD7ZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHr+T1dz9EWonFrE+Bk55eiazarZwdHHMRLMwGB4HbI=;
 b=gYz/oaV9xCkT/0zRZRD+p0ANfcChAXdkhylHKjTqXuBkOGdvBsOR4+DSJnZfFuD2NwfZ1RFGc87Vvr9lmWyDqmc24kw8YMM9iMORfZfDBVifGrb+I2ErRaiUVK3xUVnxvpz9iOJpijk+tF7+2cFOQhpDt0AS9EdjkUNdpQw5AyrZEdN1EvaGS/OzPL834Z+5XBG1dz+3gnmxAOFKi44v/gljWq798EZga+T67FLfq0o7CsF6DBWrB3reSOQH4rn4ON5swzMqfQilT1Zw2YkkDYeHcTEXnfMMjTwzl80suaQJM55umEVvHvm98Pq2a8tpdgshvsLc+v/ABXS7VIFu2A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB9443.eurprd04.prod.outlook.com (2603:10a6:10:35b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 02:06:11 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Fri, 11 Oct 2024
 02:06:11 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH net-next 07/11] PCI: Add NXP NETC vendor ID and device IDs
Thread-Topic: [PATCH net-next 07/11] PCI: Add NXP NETC vendor ID and device
 IDs
Thread-Index: AQHbGjL4esXLa/K6xk61s1LLYZrPzrKAYn6AgABtRxA=
Date: Fri, 11 Oct 2024 02:06:11 +0000
Message-ID:
 <PAXPR04MB8510FFF6813E16B72C0A2BBE88792@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009095116.147412-8-wei.fang@nxp.com>
 <20241010193439.GA574630@bhelgaas>
In-Reply-To: <20241010193439.GA574630@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU0PR04MB9443:EE_
x-ms-office365-filtering-correlation-id: 3b6c2833-66af-4598-6ca1-08dce99946ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?b2VoYUVYMVdSeXNRWjhldzdKNnNwR1VUUUlmRHVvWDJ2dm83aDdhM0hUckJu?=
 =?gb2312?B?NW5wUDVWU3ViYU13VzVNQnQxUDRuc08xbU1MeGlIcCtKdG9hRC9TQ1JIN2hj?=
 =?gb2312?B?UEd6dmJCb0lEMUR4dTJqRlpaVkhsakVOZHRYV2NBWm1VUFNrd2ZjZU9KT242?=
 =?gb2312?B?aFhzNUQvWDhCQzYyMy9SVFF6WXIrNXhScEkzRWE5SnBNYllrQzZKTk1Pd000?=
 =?gb2312?B?L3B3U1NZRjdYcW1aeTJobUlCbW5UalYxYXdDTjhBQU13Um5ES1U2TmQvMCtU?=
 =?gb2312?B?RUhRQVRiQmRhWTh5aUhha01vR1NRaG1UUW05QXZseUE5MktHbS9rS3J5L082?=
 =?gb2312?B?eUUyK0hhak9DZkdXalZYQnk0Tmp5b3lJT2RSNXNGMkZmc1VtdUc0b2djTGdC?=
 =?gb2312?B?QVNGSTBaRjdYWUhFaXpJR0Y1bDFFL3F0Mkltb0RTV0U4MXM2cHUzdW95Nk5r?=
 =?gb2312?B?QmtHbzBIQjNXWVVqS0VJcFhFWmthMzI1M1h6ZWJzUWlOdURwVEpiQ1kxdTAr?=
 =?gb2312?B?S3Y2bHgwWi84NVBjMXFPVDBncm1NWUNOVWM2cDlpdUpWdjVFNzdZU1p0cHZF?=
 =?gb2312?B?UVltSmV5VUhvT1BGMmQ1VHlmYzYvNjRBWVdldlFwQWkxYmxCanRpWDBtckpC?=
 =?gb2312?B?SDVSMEx6K21RN3VoU3NIS0VXVVdoS25vbDN4eFkrQlN1STNIU0JuL3dISFNI?=
 =?gb2312?B?TnMyanZGWmtBb2VxK0Fma3VjNzYwUGVXeTBRYjMxaG5pTjFXbzJrdFpGRDdK?=
 =?gb2312?B?NnM1T3UrblNrdjBFUWVUelhqNDVrWFovTFBzTFVCckp2SHBUYjBDTDJ2d2lP?=
 =?gb2312?B?ZlNsTVlIVDUvWkVqRkpIeU9mVG93UnhUV3dEU01ock1vaEQ3NTlmWjVVQTN0?=
 =?gb2312?B?Z29SVWZ6QktjWDM2dkdvVEY5M21VbXlOTGt5bWp4eFhmWHZ5c0IzcDlhMmUx?=
 =?gb2312?B?WEhxQzc5OEptZDZrTEV6RHJxd0hWa0x1bTRDeW1OeDVYWlYxODBnRFBxZys1?=
 =?gb2312?B?VmRkZ0dSd0Vyc2laRDZzSFV6SitOOVN4WGpKMGJiaG0yUHpuQXJWc1FnNmtn?=
 =?gb2312?B?RUdyRzNOUVlYQUJheERiTWZVUW9LeTM3UkRxWkhieTBxUi9ZbFRTTDg5L3ZC?=
 =?gb2312?B?WVQxNXlENFlIQVREN3hSeitMbTR6cm50TklldFlGdXNYMWNIVDlpOWg4SGJN?=
 =?gb2312?B?bDhIbzFZREY1c2NuSERwalFoajI0WlFJMHdkeTFiMHdOSXZQMDQ5azNJUWVm?=
 =?gb2312?B?dndEaEdFTzFFSS9BRlQ2ZTdzbkJWYnZJS0NKTXllemU5YWVsNHpYUE5qaEp2?=
 =?gb2312?B?cVIrWVVmMlRlMU9wMlRWMXJYdnYvaE9DOFkyT0o2clJTQlZFblI0LzRacjlZ?=
 =?gb2312?B?KzQxb3NBTnBuc0hET1NQRTVlMkxYSW4zMkpkOFp3dHVYb05yRTV1ZGtzaDdG?=
 =?gb2312?B?NE9KSmRiSzRZMnBYMjhzaUh0UnFydVp0M2ZkMGs3K3pWYkxidGJNaURwN24v?=
 =?gb2312?B?YUpuZmdYQUJRaGlON1VXMGw4b3JxblhDbnQ0UWFXVGQ5U0ZhQVpBeDVRLzM0?=
 =?gb2312?B?TTJrYlZxanBvb1kwZEloTUdPbXlVNVlKcy9QYlZVVGhjK3VOU0w0TE9kSWo0?=
 =?gb2312?B?Qjc0R3FYSXlkSUVjN2RNczl0eC9IeHJUU3dFK1hMb3habkVKSmo0djEzQ3oz?=
 =?gb2312?B?THArK1dUQ2dHRmt5Yy9YckY4VE1mZDNxUGl3QTVUNU1TZVJsSkxnZ2F5UlAz?=
 =?gb2312?B?TnhBWnlTTmFsRkZGRXlwT011a0N1QVo1SnVIakFUeXRNanFjWDRnYS9Jcy80?=
 =?gb2312?B?MDZBV241QU1DU0NnUWkydz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZkRUdlpBSXdVVlNLditYWVNmVmpVTm9HSTYzZDhNZDVQeFAwb2JYemZ3bDV4?=
 =?gb2312?B?ODFjNTRYVnRTYXdEUjJwUlI1cHZYRUtnK0Q4N0RTbFJGOWtCZG5PcFBROEMr?=
 =?gb2312?B?NnJlelFkNjJSblNpa1pDQXBPeWdHRVBsSzFoYklSY3U2UDA1Q05YVnRSMERh?=
 =?gb2312?B?TU1FcU9PQjNKMzBFeWdmMHdWLzdGUFh5a2JEdW5TTXlXbWozWWJMTFRtaGVN?=
 =?gb2312?B?RWEwdUQ3eGtRK2J5UmNxZm8vV3ZHSFRWMy9pdHp0YUM1clh4NnlSSlNmZ1Nq?=
 =?gb2312?B?YTczNisvTytlTzAwNEZGVVorb0xiNkl4aGJid3ZOeEdteG5Nd1hxbEN6Ky9i?=
 =?gb2312?B?dXY1RjlxSWlsODUvWjI3bW1KRnoxa2hiY2xQeU1tZHRXZUdXRElCWW1jNE9W?=
 =?gb2312?B?R3MwczEvVE16UTBVYU1lMjB2V1hlaGFFWWlLRFlBTHRBTjlPbVU2Ukc3ZDh3?=
 =?gb2312?B?Wmx0S2R3ampZdzM5UDZDNEZBdUx3Y05BNmhjWDBBQ01VYU9RKy9hVU1udjA1?=
 =?gb2312?B?N05CRmhQbS9uNUF1TUdCU3cwUDNiUDB6WUtzUVliYVNsaFp0QnZXcUtldDhU?=
 =?gb2312?B?Y2NldUo0bDlDd3d3UUI4ZS8vU3dCcFVqNW5ZTnE2MmFxcHI5YTVMc2M5QTU0?=
 =?gb2312?B?U05rTnJTN0N5dCtJWnhnVGk3cS9JSEp0Z1Z5bk9GTWdLTzd1M1ZOeTdrYjRO?=
 =?gb2312?B?WW9jOWFsc2Zad3FyZ0s0ZWdVRUhlamxwN2E4cXROUVlob3Qrb3cralV2Qjg0?=
 =?gb2312?B?bndkREtWT3owd3lTbGdwYkJ4UHBtVWlOSlZSRGh3OVFHVTFYb3FIV1RjcG9U?=
 =?gb2312?B?NjF6ekZaTlhZV0NtUk9ON1ZMOWo1ZlF6MHE2OVh0Ym5MRkVadnZWSUl5QjFo?=
 =?gb2312?B?UDVzZmU0c0NPUi9ManNORVRTSFhFTFNTY2daclNiUlRLa3dyRWgzNWV2OXhY?=
 =?gb2312?B?MGJIQWo1OUJPSFFZUnBNTGk2SWN0R05wNWZXampvajRydjhOTXZXM2NBb3Zp?=
 =?gb2312?B?bmJUdnV1NXREUFRsL2I5dTZrdWVNM3RiTmNkd29aL2Mzb09WUlJuSy9PTDV2?=
 =?gb2312?B?T0lkN2JGT1dnOWU0ZytqNXcvQkNQZ0VZQUJRWFZiMXQ1L0g2cmcvSHEveTRp?=
 =?gb2312?B?OWNKaU9jRUtKeDFTV25oRlViY0Y4N1JRc3FiSFUyengzM2xxeGVkaEJkSktt?=
 =?gb2312?B?YktVZDRhVmp0U3dwNU5sQ3J5ZFc2VzFGU0lqRWxBektxeDUxWi9LUHc0K2p5?=
 =?gb2312?B?SkxSZkJNSDNHN1lkaGxKL0p1TmxVaGNFTmJhMzFPeWhESDhEcWQ4ZmN4anZN?=
 =?gb2312?B?THdVbm81ck9pS3lQdkV0eFVnRmdGLy8rV3EzbTdYbnRUcE1CaHhVM29GYWl5?=
 =?gb2312?B?NldURGJaZVlZaUZsMHE0OVpCaDNST3QxU1J1Y2thZkdkeWZNcnlVQmdITVpr?=
 =?gb2312?B?clBZc2FPTU1yNTB1bmtOb1BvVllhZ04ySSt1N2h5aXN2TXhtTW8zait6QzZx?=
 =?gb2312?B?aTI2cUdSUXp4VzlzYjVheTlyWDRuUGNTNG1hdzZhdXBhdjUyeldoVTlBbFRz?=
 =?gb2312?B?LzRIaGxROFpaQ2pOS2NaTW9kN1RXbVNlcGxjU2l3WFlZQ3lueWNaYVgrVW01?=
 =?gb2312?B?cys0RjFYQXpISUZKL1l5c3UxOFZ5cW5KMC96WkJZUVFobE5mUS93bk1Dd2dY?=
 =?gb2312?B?NmcrbGJYbkh0cDBDQmVuVStlVDE1WklUODBSRHFSOEtwRU9pRnAzVGx0Rm5w?=
 =?gb2312?B?RXRGdm9iUXUvY1puQXlYT1RReGtjMU4rVGlhdGZxSFJESHNRL2FwbDdFU1BR?=
 =?gb2312?B?c05wVGw3WFpBbDI2SFZLd3I5VWc5NnQraTE3MS85MkhJdzYrbTVzV1RjR1RC?=
 =?gb2312?B?S0Z6RXhIMklBOHRGR3N5UmwwT1JRMGF4dzZtV25aay84UTM1OUdlQStObUxs?=
 =?gb2312?B?S3Fnb1hyQWVYdXJrc29zS3h3eEwySUtCSjd2R1Jza29FV0tYMGorSjYxbklu?=
 =?gb2312?B?VjdwdldsQmxNSDJCdGZxTG5sYlQ1QjE0aW1hVnZKS012TVU2WnhEZFFnYTIw?=
 =?gb2312?B?MnZKWnE3d0lyc1lHRmZQL1JoK2txdG1TbkdkRXJoRHpMTWo4cjN6eHUxZjda?=
 =?gb2312?Q?MVDo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6c2833-66af-4598-6ca1-08dce99946ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 02:06:11.0163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqmBP/eHPLbSUjFtKHImbUPu3WCU7vj01m8L3VFQk5wh9l6R7QbeKnzHANAAzx4VtYye52OU8BaTgTwaaQexsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9443

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jEw1MIxMcjVIDM6MzUNCj4gVG86IFdlaSBG
YW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgcm9i
aEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7
IFZsYWRpbWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+OyBDbGF1ZGl1DQo+IE1h
bm9pbCA8Y2xhdWRpdS5tYW5vaWxAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdA
bnhwLmNvbT47DQo+IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgY2hyaXN0b3BoZS5sZXJv
eUBjc2dyb3VwLmV1Ow0KPiBsaW51eEBhcm1saW51eC5vcmcudWs7IGJoZWxnYWFzQGdvb2dsZS5j
b207IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQg
MDcvMTFdIFBDSTogQWRkIE5YUCBORVRDIHZlbmRvciBJRCBhbmQgZGV2aWNlDQo+IElEcw0KPiAN
Cj4gT24gV2VkLCBPY3QgMDksIDIwMjQgYXQgMDU6NTE6MTJQTSArMDgwMCwgV2VpIEZhbmcgd3Jv
dGU6DQo+ID4gTlhQIE5FVEMgaXMgYSBtdWx0aS1mdW5jdGlvbiBQQ0llIFJvb3QgQ29tcGxleCBJ
bnRlZ3JhdGVkIEVuZHBvaW50DQo+ID4gKFJDaUVQKSBhbmQgaXQgY29udGFpbnMgbXVsdGlwbGUg
UENJZSBmdW5jdGlvbnMsIHN1Y2ggYXMgRU1ESU8sDQo+ID4gUFRQIFRpbWVyLCBFTkVUQyBQRiBh
bmQgVkYuIFRoZXJlZm9yZSwgYWRkIHRoZXNlIGRldmljZSBJRHMgdG8NCj4gPiBwY2lfaWRzLmgN
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiAN
Cj4gQWNrZWQtYnk6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+DQo+IA0KPiBP
SyBhcy1pcywgYnV0IGlmIHlvdSBoYXZlIG9jY2FzaW9uIHRvIHVwZGF0ZSB0aGlzIHNlcmllcyBm
b3Igb3RoZXINCj4gcmVhc29uczoNCj4gDQo+ICAgLSBTbGlnaHRseSByZWR1bmRhbnQgdG8gc2F5
ICJtdWx0aS1mdW5jdGlvbiBSQ2lFUCAuLi4gY29udGFpbnMNCj4gICAgIG11bHRpcGxlIGZ1bmN0
aW9ucyIuDQo+IA0KPiAgIC0gTWVudGlvbiB0aGUgZHJpdmVycyB0aGF0IHdpbGwgdXNlIHRoZXNl
IHN5bWJvbHMgaW4gdGhpcyBjb21taXQgbG9nDQo+ICAgICBzbyBpdCdzIG9idmlvdXMgdGhhdCB0
aGV5J3JlIHVzZWQgaW4gbXVsdGlwbGUgcGxhY2VzLg0KPiANCj4gICAtIFdyYXAgdGhlIGNvbW1p
dCBsb2cgdG8gZmlsbCA3NSBjb2x1bW5zLg0KPiANCg0KU3VyZSwgdGhhbmtzLg0KDQo+ID4gLS0t
DQo+ID4gIGluY2x1ZGUvbGludXgvcGNpX2lkcy5oIHwgNyArKysrKysrDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3BjaV9pZHMuaCBiL2luY2x1ZGUvbGludXgvcGNpX2lkcy5oDQo+ID4gaW5kZXggNGNmNmFh
ZWQ1ZjM1Li5hY2Q3YWU3NzQ5MTMgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9wY2lf
aWRzLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaA0KPiA+IEBAIC0xNTU2LDYg
KzE1NTYsMTMgQEANCj4gPiAgI2RlZmluZSBQQ0lfREVWSUNFX0lEX1BISUxJUFNfU0FBNzE0Ngkw
eDcxNDYNCj4gPiAgI2RlZmluZSBQQ0lfREVWSUNFX0lEX1BISUxJUFNfU0FBOTczMAkweDk3MzAN
Cj4gPg0KPiA+ICsvKiBOWFAgaGFzIHR3byB2ZW5kb3IgSURzLCB0aGUgb3RoZXIgb25lIGlzIDB4
MTk1NyAqLw0KPiA+ICsjZGVmaW5lIFBDSV9WRU5ET1JfSURfTlhQMgkJUENJX1ZFTkRPUl9JRF9Q
SElMSVBTDQo+ID4gKyNkZWZpbmUgUENJX0RFVklDRV9JRF9OWFAyX0VORVRDX1BGCTB4ZTEwMQ0K
PiA+ICsjZGVmaW5lIFBDSV9ERVZJQ0VfSURfTlhQMl9ORVRDX0VNRElPCTB4ZWUwMA0KPiA+ICsj
ZGVmaW5lIFBDSV9ERVZJQ0VfSURfTlhQMl9ORVRDX1RJTUVSCTB4ZWUwMg0KPiA+ICsjZGVmaW5l
IFBDSV9ERVZJQ0VfSURfTlhQMl9FTkVUQ19WRgkweGVmMDANCj4gPiArDQo+ID4gICNkZWZpbmUg
UENJX1ZFTkRPUl9JRF9FSUNPTgkJMHgxMTMzDQo+ID4gICNkZWZpbmUgUENJX0RFVklDRV9JRF9F
SUNPTl9ESVZBMjAJMHhlMDAyDQo+ID4gICNkZWZpbmUgUENJX0RFVklDRV9JRF9FSUNPTl9ESVZB
MjBfVQkweGUwMDQNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=


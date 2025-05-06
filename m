Return-Path: <linux-pci+bounces-27302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BB8AAD0F1
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 00:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494DD7B718A
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 22:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA46157A6B;
	Tue,  6 May 2025 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WO5dBISh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pZoPOtKX"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F9F217648
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 22:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570301; cv=fail; b=ARxqLRTfv6joTrETznCgffsRgcLfnQr863qBN/bE20ZBCeSj4eFr3YH25VnatQPH7A6/UIhHLCHW96/U9H7y/D4IwOaTKhymO+ZKp4qW+pF5xo6ySOVv3hLDpDaPmXCx6bEqMZekgPf44Dp0iBb/v/qElnueW/YByfhgwErz5oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570301; c=relaxed/simple;
	bh=8z0m0l7zEEqllOcqMjq06pGZ9QXRlslyss0gkmKilyc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sjxV56AqywzKlMW5JEJi8UmClHB4Uc7HjJwzk3cVZ70iQ1KKk1Z479Jn64ApA6QI/9uwvUWhKpMDJ4o9XFJQoaY9R4Hk9hRpRVQFzYWNyDn35l9Vyw1GJPjoYRaQGC5a8d2S4wpXJlXgqgPkoMDobI/VVqsN9ip+fj+g6VnzQa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WO5dBISh; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=pZoPOtKX; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746570299; x=1778106299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8z0m0l7zEEqllOcqMjq06pGZ9QXRlslyss0gkmKilyc=;
  b=WO5dBIShqQPAlfJqJq9zRuLdFWvKXEG9WA+VcFY3E6TjGHmEoUHKY4WU
   GSnh9T+hncAXGQrFIUvSkozWkFnHv7Xf27ctMxH2rvaJRXtTjvu/ncuOZ
   4geJlPCnhC6rGOjAX/ih2b6bZH8Sm9tIcprFP8o+nGCKCyLDlOTLdDQyk
   XJ5moMUEDWrAPwTigxC7ZijATbQEtoAZB9gpN/6sNhJ5e5wW2Zlldeb+m
   jBkVC+SD9xWrLlEHlXsDoa812kElZQmyNNhKzTXNcUAWxyZMrFezVS1MZ
   W/XaJeNaG9zaGEMT18tYvEdTS16jAVOi4SVDJ+UCwbyuWlwlrmZ0R+Ygn
   A==;
X-CSE-ConnectionGUID: pnkr4WtTTGyMcGo+0BBdKA==
X-CSE-MsgGUID: OVAqGzriQFCYSUKPYjrR/A==
X-IronPort-AV: E=Sophos;i="6.15,267,1739808000"; 
   d="scan'208";a="79609670"
Received: from mail-westcentralusazlp17012039.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.39])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2025 06:24:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUOnwN66zHyxIdNyAuQOIPqpB5fWub0iFQ0EF3vVrY+stzpi46cy48lywff0XzUHiBVAmV+AeadEmE9I3LT4B+5P/OECGnNGY8mEHBxshd640UjCUWyyx88ZEDe4fwGD/9rgH/x5z30JXFHPjOAWspPKXc5UdWKsWm7VbCQXh7b5uvFh0FZXXi8fQ91HyveHkJcR57WwzRqyvIRFv2YvpA1+gK5t0LjzHjBPnlEDgN925txpMhz32h5HJs3aHS43oItvDSN50a67A11D+gHBGR894ltZsbG8u0ZPbunyTNRdbpLTrLOYyJye0JCGFLKjdTUlZmtR5Y5mpl3X/jqy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8z0m0l7zEEqllOcqMjq06pGZ9QXRlslyss0gkmKilyc=;
 b=JR98bpljvHPlvNZ7iWLrx/alrxsJhX4N6W96/NTr2dUrrp7kuoQXF2wQg///2dbtwvRovwjcLqqh2HSoL31NpreNeMj50DaroWljJl9v4JPwJo/U3T38f85prxGQCuHDmyghaAhDCjemq6WNnqbdlnrsU6yBKVnB0BjKumjCczG2pPDzo1+fYehL2cxIq3sppj2XVotKrpO+kABh3WlJRlwhyg3KIONUhegSWttUKYJ30QcfvfOrqd1b5jW90TTRYCXRvy2sj78mKmNnShf4N8PunW9OJTfgPrMbcnFwBe9qnbTMg+dChTDtH/fUp9d53l9kS8vU3V8a/UxFEC0rRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z0m0l7zEEqllOcqMjq06pGZ9QXRlslyss0gkmKilyc=;
 b=pZoPOtKXn9uCifBeQ9Q5+2oiHCwch4FKU9Ol8l9UXmJhES/ZXrsM5FjCu5amHXUdGpREw5I9+efBfccH3CUQWR6hK6Oo99Uherl6cFH+8+8OuxhDKvT8ZxBWkVv6hh3OS9ssVB9sdiCjw10ORjwXBL3WjBQrZIvLCJBTxfh3lIM=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by DM6PR04MB6729.namprd04.prod.outlook.com (2603:10b6:5:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 6 May
 2025 22:24:46 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.8699.031; Tue, 6 May 2025
 22:24:46 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "cassel@kernel.org"
	<cassel@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "laszlo.fiat@proton.me" <laszlo.fiat@proton.me>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "18255117159@163.com"
	<18255117159@163.com>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v2 3/4] PCI: dw-rockchip: Replace PERST sleep time with
 proper macro
Thread-Topic: [PATCH v2 3/4] PCI: dw-rockchip: Replace PERST sleep time with
 proper macro
Thread-Index: AQHbvloUSHcOZJZkFEGONVW4W3SAZLPGLqEA
Date: Tue, 6 May 2025 22:24:45 +0000
Message-ID: <e6357b42ae1506729bc7fb07eb8df05e87a59d4e.camel@wdc.com>
References: <20250506073934.433176-6-cassel@kernel.org>
	 <20250506073934.433176-9-cassel@kernel.org>
In-Reply-To: <20250506073934.433176-9-cassel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|DM6PR04MB6729:EE_
x-ms-office365-filtering-correlation-id: 830f81e6-081e-4f3c-c6c5-08dd8cecce43
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3U3aEgrdXZ4MnBGMEFPVW9mUGx1MXJESEFyejBVMXA2dXRPU0Ywd255aUFC?=
 =?utf-8?B?bXdxRU1xN2FiUWMwZTdGaDlhNWlqTUdTcVg3OWJYaHIwUklzNTlCWU9EQkhQ?=
 =?utf-8?B?dFBRRlJXQ3VLZlF4RnA0WXBqTWxKN1YzdGtZTnJoU0J0TlVmVzluR2wvbk1V?=
 =?utf-8?B?VW40UmJNVXpIczd3RlFVZkR2dFpjSXJwblVKbUNyaWsvMGJWY21pclN4bk1P?=
 =?utf-8?B?eThIUWF4NEFZcHJwUFlwcTcrYm12MmRFcWthS1puOFBJanJJcURVK0FNNmdZ?=
 =?utf-8?B?V3R1YmQ2VHd3OU1wclVVNU52ZmhGMC9NbCtUbDIyc0hUeXFFTXpiTjlRRzNv?=
 =?utf-8?B?UzhrRXAzUWlZMFlzQW40bm9kTFJ1d01WeDhUUWd6N1RyK2QvdjdRdXdTMDJp?=
 =?utf-8?B?Ukw1UnBmMzBvQjgxcUJZdzhqKzlLT1VrQ1hTMTVHNmVXK21ROWdHNUZKeW9Y?=
 =?utf-8?B?VlhkWnlIbm1GQlpDRFliRFU5NVNPNllueklJL0xRSEhXQUhLNjBmNnd0YWVX?=
 =?utf-8?B?eHBrZDdhcFZyZysrWVFBWmZkS0p1cVhBWFZrb1ZMWWFlM0VIMFl1ZXNKY0xG?=
 =?utf-8?B?bWxRUmlSUnVyV0VxSTBqbElkZnFYajRraytKVmxVU3pqazVjWUJzL2ZCcmtq?=
 =?utf-8?B?T0pNWUF3cUhOM0xRcm55REwxVlNzcDlHSXNXT0Q4RjNlUUt1emNsSXpOamov?=
 =?utf-8?B?aGM1NzF0bVFCTEJ1ZG5jRzd0TWV5TFdmNkM3UWlBL2RhM3gza3NITGVDZ2pK?=
 =?utf-8?B?QVBwWm9Vc3U4KzRoQlJRd2FaRlprdkFSRjZieUJmZ0FPMHAwZmxydnVBN2p2?=
 =?utf-8?B?ZHNLQlE4dXVybHhvV1R0cXI0cWJob2lZQjdHVTZTK1dVTTlDMzdZNjk5aGVQ?=
 =?utf-8?B?NEVFTHludUxyM3UrMnAxREtUMjEvU0tQQUJqdHhPQ1VNK0hBSVliS05vUFFV?=
 =?utf-8?B?Q281WDNiTkpZdGpjSisrUmhuVlNlOWJrZ3N5cUhkT0pZVUxJdjY0TnpLMHEy?=
 =?utf-8?B?QTRsblYySXFXVFhKWW5DK2dYS1dRaTFJN1hIV0pXLzBnK0prRTIxL0R4cVp5?=
 =?utf-8?B?UWcvRFgrV3FhWU9sVVArN1pTWXVSRFdhL0lMSDJlSjhHY0pZZlJzS1dEOThq?=
 =?utf-8?B?TlkrZHJIWE1sWnBiV05zVjJEeGNoL0E1LzBGTG1YYUhzcGdhUEZtbFlVd2ta?=
 =?utf-8?B?dW5hQk9IcTlsZWpHWXEwc0N5TWk4TkJYSThZelk5bWNhQ1FYbTFtOUdCR3NF?=
 =?utf-8?B?TzQ1RnhMTEQzSzlBMDBjOStSaVRyV0hRQk1zWUV0UFlFUW5kTEY3RXF0WlVz?=
 =?utf-8?B?R2U2ZW5YRUJzMDM3VHl2ZW5ZR2hjV2oxWnZVaWFKNHZCWk93NVNjQWlrby9K?=
 =?utf-8?B?ZzdGYWRua1VINjRwb2FVTWkyeDVJbWlhS1FpeDJKbVlPci80ZWJKMG9PcW5U?=
 =?utf-8?B?Wlhkb1BsdDlmK21lQUptS3lSWUNRd0FtcnBXQmthcVorYTVBL3dMMXhwcmRk?=
 =?utf-8?B?WHRXazc2Ym1LZkJXRk01MmNiWEtJUXh4OFp4cHVSemR1djhQSmtrc2lKRk54?=
 =?utf-8?B?SnRWeUFjcEt3NDlkd0dHWXZtQjlOZUJvZkt6V1ZBazEzckFXNStxaXdnbVRE?=
 =?utf-8?B?UEdYcFZUQ29JbDFaeU9aTFpBQU94dlMvaWFMVEFXRVFkNTJvMEhjNWhKOVdN?=
 =?utf-8?B?MDAxOEZia3UxUEt2dzAvTnBtQWJuWHlDV3hWazJRbkRpT3Z5cmlWbWdrNlFR?=
 =?utf-8?B?K0EwYlduRE9KdjUvQlV1eStYSmk0aDhvZjJYWk45S2xHTjN2cUZSZjU4U1JW?=
 =?utf-8?B?aW8xTGtQNDBNdHpIckVlYU9SOVdWNkptcVBRY0syQ2RRaHc0cWJVQ241TDd5?=
 =?utf-8?B?NUJJWVBzMnRndzhQVzA5cGMzZEtzcmJ1QkpKcjNaQlk1M1V1cXYzc2c0QUhl?=
 =?utf-8?B?VldoeEdMeGJad2V3WjEvOVVqdHdUWTBkSWphc2xzYXZMY0xRdzBaNllJTk83?=
 =?utf-8?B?YlJlakw1ZG1nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXRhemMxakRxZlMvQW52c0J2eDNId0c1TDYzWmVxc0NtY1UvL2pHMC9vQzM4?=
 =?utf-8?B?YjVlbnpxM1JralJ2amNOdFVPSUlWMTdaaVEyR1htY2g4Q2dXQmZtWXI4MmFt?=
 =?utf-8?B?Yk9QQ1lQdFFZQnlxMk4wUkpTSjdNcERyZTU0K3ZGVUdGczVsNCtCYkZXUC9H?=
 =?utf-8?B?UnZNWlhkeGJnbnZvdkpOUi8xNm9QcVFGZGZ2YU1CeXB2aXRLakZ5SmpOaVFD?=
 =?utf-8?B?UTFSQVhGdlpadGNXN2JzS3JxWEZSVUlVMlA1Q3BUYVcvM0RraEYyd0pYWXRj?=
 =?utf-8?B?MEl0eWUxV2xBdWFLMnpkQjBpa0c0d29oOXhBN05LM0pOVWppWnBNLzBIUnJi?=
 =?utf-8?B?czc3Qktod3UxTnN0SzBRODIzVktkSDJBMzRwRlNhN1NjZldGNEVLcHlLM1ZX?=
 =?utf-8?B?OVI0M3BSRUMyN21VN2pVd2JUd3NsMFg0VXhPNWFkOWo5Z2c4VWtMcGZOeXZ2?=
 =?utf-8?B?Y0E0TVVINllzOG5IdVgzdFQwK0ptaWt2b0d6cXFNY0pzbkVKSjljUlBDSEdp?=
 =?utf-8?B?cEQwU2hGN21ubXFtei94a0hoeld3Um1IZXdyZWFDdXcwRWZoTmVyQVFneHJR?=
 =?utf-8?B?dWlTRkppYkNTK0NZQXNSWjJ3Unczb3pyeFpGOG52dGN5dkhEbzAzVEZxeTBR?=
 =?utf-8?B?KzVwUXdoRFF2L0VTelBxREpqUDczK2t5c05DelRxb1NYVVMyYklRVDBTLzRB?=
 =?utf-8?B?UjFFd092Y2FyM01xUFNvQUs5WDF5K09xOE1XeHlpWTAxdEI5UEpPcFE2SXI0?=
 =?utf-8?B?b3ZuQ3pZS0xXekN6Kzg2ZEdMb3hCUXQxdjd4R2NjMW0xMjRncU9PdFdtUDk5?=
 =?utf-8?B?Znp6M0dwTElSbnNNVFQzWlMyV0NnbGFsMGxtMGw4WlZWTWFjaVFybktMN0Qr?=
 =?utf-8?B?ZVBFZ3IrZ3hWaUJiN3o4MS9IMEhqd1Q5NFJxUW9hd2VVeHFxU3hJOGxDeEwz?=
 =?utf-8?B?ZGVnZCtycStYLzBCcGx6S3I0Ti9QcFN4ZkdRQVJPSEdwYVN4ZG1JWjBEZStn?=
 =?utf-8?B?cDd2UkV5TmJWUEdvbVZZb0JGS05lM3FvVmhvSm0wTWZDVnVJekxJWHpyLzFM?=
 =?utf-8?B?cFRFQzRScHFHMDBIc095dWxmUnc3d0ZxK29Jb0VscUgxNEZKTkc3WWRuOWRv?=
 =?utf-8?B?SEdQcG5UTFJza2wvWGZIYU5MSmhiRUtUT2VuVjMrWDhUZzFVS3hxMFlHcXJz?=
 =?utf-8?B?b3Mzb0Y2RitIQ1QxU0EyODN2REFXaEJ2WTZFckRaY21SRzk5QVRZNE5NVm1I?=
 =?utf-8?B?dS9GcUJLRGptajg2UHB6UmN4dHdSOU1pc2hhcnkyeXE5VXc0L3RxV1lGRjc3?=
 =?utf-8?B?Y3JrbnR4NEhDVnhMVURQSGsvYnIrdlkzM3VHNWI4TzNjSWxJbTNQYTZ6ZDJP?=
 =?utf-8?B?emgxV0YvQ293RFRyOFIxUE9EeDlubkFMU3d0eVNQeVZvZEtsNWpZVHVTbElX?=
 =?utf-8?B?cUFrc0w4clZuYkwreVdvV3JDMHNDcDkrV3BKRksyNUp2eSszRXVvZy9rQnps?=
 =?utf-8?B?M285M3gxRjV1V0NVT2tycVFQdlJHdzJCZFVxdU1mdUJWS3llSUJPRHlQSWVD?=
 =?utf-8?B?ZVRKek83YjlzaXpZMWlVNVNpb05HK01zbGNVcW03aHVXWnRHWFBvSWZwMjRj?=
 =?utf-8?B?RlAyS1d4RVBFbkhkQy9adnlJS2lFck1iOENPc3pNa0pUVXN6WW14K0YrUzVt?=
 =?utf-8?B?bktFRzNwVFYvekJkUWtRcVVuNVE4VkFBdnVKRkF0azZwMVVJMTEyM0syVjlK?=
 =?utf-8?B?d0FQZzF3c1ZpYWZaNkpNYkU1QkNwV0hmR1kwZEtVcnJPL0ZCRDZzbStVK1ZC?=
 =?utf-8?B?cFc3RDdFSUdBS2ZRRUNBaG0yQ1ZIZzBsQXlYaHozVzNQOEdqUm83dUFzNXkz?=
 =?utf-8?B?eUl1ZDZOS2hyRVplNFR4aTJPYUs3U3Q3VkI1anREMjdoV080aHRVNml4WVFk?=
 =?utf-8?B?WklVajFING0wbXhyb1poc2VPVzMxMzZjT2FMNVBQVFJrZ0RNMjJPUGdsWjVx?=
 =?utf-8?B?d1NITmRIZ1VrVTYzMDdpeHpqbDVNYnN5b29OZG5BREV6SDdtZE1MQlAvby9O?=
 =?utf-8?B?dDBqRnVxVWs5YkFUVDQ4azVKaUJoWTNIRUZOMjFlY282UzlOdmJZODE5VHBi?=
 =?utf-8?B?anh6V2hENzZNK2VIdnFUanJIU29OYW5lMkIybVVnY2VQMW9wdWpobUZveHV4?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E804B3B2CFEE9D46B9C8D06A3C47E5FA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A9moW7f4gsX+qXiHtpwL9El61yeqtjpJ/M691HBko2PTUBAzNHOMc///7+LODlcvw83DQ+w3Tw0HSTUUFzXF8qN6SXA9MsAwajoEVGsQQXqMrYvmmOu0bIDYCfXig+maxA9TZru6fy2Vlp4kLm591+MwLmhoE1o4ZFzr7VlcXwEQXb5HsqDnJk81Mku3DFumNMKeNIi7eSLHnFHCZymYaKr+Imdn1DCtdQr90bPeBVQFyaeR/zc+15cEewKxIhbG86b5BDk3Dc6SKISp/4AKXr2eYLD1S/9jpG/78SVT4W5zmYGcOZaRKLnjJDP+CA9B2wl5bsow775PHB3i79hLLyuVQtDZn8DwfshtwRfl/4IyTFIokDwp1imAdbTKsdtCk1B7l4pev1WeCIziKsxDInpBWGwtrTAmXbLdDEiUDi1pf6h3xCqeJ0aVN3GuwUPMVAp45K226YF/YS1GV36nfn5M/F2UgPJIJdvg+gabssiSCCWIN7xvwlGZlUg6xHICUbrsEy86Q8IKwaFypHFuZesy2fzImAtmxgnJsUga8GGelgpprBb01U0Rt+51arXBsk4Ct35j5lw5O70HtSlaWeGWESlyj5VAP5G51Tv3vJuLQ7kzs2NJm7UvVKLQO3Be
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830f81e6-081e-4f3c-c6c5-08dd8cecce43
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 22:24:45.7118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0EhwdgU1zzpi/K8yKnVsWD7u8fdEVFYrOlRIBn84EQyI0tIG8tGtHclC9rtm0/g1eofvadNuNhrZmY6rDIcmPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6729

T24gVHVlLCAyMDI1LTA1LTA2IGF0IDA5OjM5ICswMjAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0K
PiBSZXBsYWNlIHRoZSBQRVJTVCBzbGVlcCB0aW1lIHdpdGggdGhlIHByb3BlciBtYWNybw0KPiAo
UENJRV9UX1BWUEVSTF9NUykuDQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTmlrbGFzIENhc3NlbCA8Y2Fzc2VsQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiDCoGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZHctcm9ja2NoaXAuYyB8IDIgKy0NCj4gwqAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWR3LXJvY2tjaGlwLmMNCj4g
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWR3LXJvY2tjaGlwLmMNCj4gaW5kZXgg
NmE3ZWMzNTQ1YTdmLi4wYmFmOWRhM2FjMWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZHctcm9ja2NoaXAuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWR3LXJvY2tjaGlwLmMNCj4gQEAgLTIyNSw3ICsyMjUsNyBAQCBzdGF0
aWMgaW50IHJvY2tjaGlwX3BjaWVfc3RhcnRfbGluayhzdHJ1Y3QNCj4gZHdfcGNpZSAqcGNpKQ0K
PiDCoAkgKiBXZSBuZWVkIG1vcmUgZXh0cmEgdGltZSBhcyBiZWZvcmUsIHJhdGhlciB0aGFuIHNl
dHRpbmcNCj4ganVzdA0KPiDCoAkgKiAxMDB1cyBhcyB3ZSBkb24ndCBrbm93IGhvdyBsb25nIHNo
b3VsZCB0aGUgZGV2aWNlIG5lZWQgdG8NCj4gcmVzZXQuDQo+IMKgCSAqLw0KPiAtCW1zbGVlcCgx
MDApOw0KPiArCW1zbGVlcChQQ0lFX1RfUFZQRVJMX01TKTsNCj4gwqAJZ3Bpb2Rfc2V0X3ZhbHVl
X2NhbnNsZWVwKHJvY2tjaGlwLT5yc3RfZ3BpbywgMSk7DQo+IMKgDQo+IMKgCXJldHVybiAwOw0K
UmV2aWV3ZWQtYnk6IFdpbGZyZWQgTWFsbGF3YSA8d2lsZnJlZC5tYWxsYXdhQHdkYy5jb20+DQoN
Cg==


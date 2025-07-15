Return-Path: <linux-pci+bounces-32206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E69BB0696F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 00:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C276189D4CD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 22:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C7517BA1;
	Tue, 15 Jul 2025 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mYucD2E8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EVjV+SVW"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A27D288C09;
	Tue, 15 Jul 2025 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620049; cv=fail; b=nT/OlITz7WoNr+h3hBqBfqTk/O4KDgOEbNz0IxPGttbiozmgP3zxkkNyXMidg3cyJ+y6Zo5BT+aZ/0rOiVe+Nl/Rqc+o9cg7vu9SnhpJgfxhmG0Z0glj9+Euexml44CuabougJiIQXaTnwMC/mhd4WUlrPcZqmwZVfoPkR7dEUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620049; c=relaxed/simple;
	bh=jeCCENn9N/J3u9VtGg0hTZvyGVWhp+fxNLhkg73cuAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t0WWpulRPKkTTl8JT3qzXAQn5iF8ubZXyw1gTBKzC/5Hk980OiMRvG0if26UpQs/GNttSK2xelQVoMsVg9VPD7WSN1KJ2mj1q2F/wNCQEhE3a+dQuTyNy9yGuaHdzqWoJWxks6a9lRAeNTITBV0giTJ2PboaQRDKRZT5B26CLFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mYucD2E8; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=EVjV+SVW; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752620047; x=1784156047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jeCCENn9N/J3u9VtGg0hTZvyGVWhp+fxNLhkg73cuAo=;
  b=mYucD2E8XoY8vqQaNS4sQlA9S6EWcc38PwvOsJ2DJJoi8+zdaAZAfkPf
   Mb6jRPb7Nt3e1xU9w1UER2EMG8ja7DfJ5F0/yHXuu+Gj1rQnZpezqH6gu
   idVuYwlDzkBB8kRuTQMV/rQVzRX7wm4PFPYkprVoTKhm+bb3qtdZYxm4K
   fP8Tk5L825lt58I0JNv/EoBBP3MbGtVJ/EkcW+pjSFZK3Tr2/HXiS9DEK
   D3+JeBDtgm7h7YQ189yWslf0aPnVaeOXxzVZufNyflB9CRFX0mYbuOF1G
   pqUjnAGS+tC/oA9NBylBEsm/8BQTJLJFckemnarmpG4ssOvTIqx0KphRx
   A==;
X-CSE-ConnectionGUID: 4bWYKhXYROSLFPru1Wc1FQ==
X-CSE-MsgGUID: qmOKz5QZSrKYApHzcJ37jg==
X-IronPort-AV: E=Sophos;i="6.16,314,1744041600"; 
   d="scan'208";a="94069968"
Received: from mail-westusazon11010016.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.16])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2025 06:54:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Snla8UjX+nt3h7+wl50sxmTyz7AAftDnaMQw8dxcdDPu2XkW91XwWBsT2Nrst9ZjCl4jfmb0e1cKNNjkyH6tCsNqhV3FEXWEXklt103Q5Rgj0X9Geh7RbppCtAeqEU7sLoKjGpbDjK7nfeC7T3gX+HkGI50hbfVMe36v6ZiUEsdFRumIBI/UttEAn17n9hHyRDnhMwv3tE31IrGUfrqjH/sgEDK1m8cm+TDP/aaDCME92MQU9C5rtgdvRVx01SuUEYBecnsSkrdvuKWwUBFJu/t9WymZFykMm3qzlvTZl+QmPwV7jerkM2oHeDdKD77xfEK2RQantuJuPLrFDvrcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeCCENn9N/J3u9VtGg0hTZvyGVWhp+fxNLhkg73cuAo=;
 b=xetBQBfxaHTzt51t5JcT3romAHuNMW5Yg8JehFJcx5g2lVB8uGymVJL/TwQVbWy1sIn0/W1uAwcPCIFhV5kcSaL/U7BVpJH35oL0Kx+qKITUayJF8B5TazeTg0c5kIu6RTn/8iKWMJWeVNAi65J5iMKJSG4YY1D1bYRjTvR/mIlZhjEHv1yEhdl6GRJ3K10tRaVs7mqZpQoLOZJscQEXVuJncZm61J1Y2sTubqKbEnZ03VsdE5Tdmf1Lh0e/gqPI5XLaIzciXS9Exz7ltFJDz8X9JfglXkEaHnrNOsbKyDK4bmaOgLKOOFnrSFRvgGELpzQx1E6kAguj1YbVmdBzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeCCENn9N/J3u9VtGg0hTZvyGVWhp+fxNLhkg73cuAo=;
 b=EVjV+SVWZX6BjbXPFNdOVlMDDyzOxR/J4dryUFDfwsO0nKEMoT5tTFk9+scFQ0a1DmymMzKVddAMIehbuYpTEGJaK7SPbrNkvkF7HiHiDYhNTzK6aJjmD49keYznyqU1u8jQf3aOYvh57UIIxd5f56jkGLGB/o3hmJiJqxeZKt4=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by SJ0PR04MB8422.namprd04.prod.outlook.com (2603:10b6:a03:3e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.24; Tue, 15 Jul
 2025 22:53:58 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 22:53:57 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "david@tethera.net" <david@tethera.net>
CC: "dlemoal@kernel.org" <dlemoal@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"alistair@alistair23.me" <alistair@alistair23.me>, "cassel@kernel.org"
	<cassel@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "heiko@sntech.de" <heiko@sntech.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Add support for slot reset on link
 down event
Thread-Topic: [PATCH v3] PCI: dw-rockchip: Add support for slot reset on link
 down event
Thread-Index: AQHbwIpZ70Uk8zYD6UqKMlfLq36i/rQt6sSAgAT/9ICAAUrkgA==
Date: Tue, 15 Jul 2025 22:53:57 +0000
Message-ID: <bc71f7fb38c1cf2e3faa6d191d61d40121c4ea22.camel@wdc.com>
References: <87cya6wdhc.fsf@tethera.net>
	 <f083038e43899cbe17624bf10c8d118fe92bec29.camel@wdc.com>
In-Reply-To: <f083038e43899cbe17624bf10c8d118fe92bec29.camel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|SJ0PR04MB8422:EE_
x-ms-office365-filtering-correlation-id: e2354531-11ee-4aa0-04c3-08ddc3f27b94
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGdIQ0o1bEFQdVB5SjBxQWFLbGVwYVRXa04zNVhwRy9OSmZZK2x5ajQ2WkFz?=
 =?utf-8?B?ZjlFZXdBQ1p4NUdkWU5lL2JtbGpEckxkaldUb080NnVuUmI5VGkvRVhEcVY3?=
 =?utf-8?B?d1NjcWFRYTR1VFNPcmFudENhaUtxMDBjWmxrMVlNdGM5Y1V3KzV4UzFKY1M4?=
 =?utf-8?B?ck5GSmlQZnBPNFdqbW9UalA5ZTBlRTQwN1J0RGM3RlA0VW9jZlU4eHF3VFly?=
 =?utf-8?B?ZlpoVUtWbi96d1NmUCtJRTNzZkhYdWdHZklYUis2OHlScVZ1d0xtbWVPNzdJ?=
 =?utf-8?B?TWNXMXpTYVRwSFA2YjRGSGVheHpveCtWUzVTcjZlbkVncGJpakdLZmEvNngw?=
 =?utf-8?B?VU9rTS96aExqZENxdG9adDdJSStGMUNjVUdOWG0yOFFrQ0ZCVkR6Tm9iSFdX?=
 =?utf-8?B?WHZmQ2M1RkhwSmtsR1JiWTNqS1hPZ0t2NXErRVJoYmpPVmFZOXdwNEFGVTNm?=
 =?utf-8?B?UmIwY0MyNU90QzJlUkZMZ2o2cVBKV3VYSldFcUNoVlRIc3ZraG5SRm1kZDJS?=
 =?utf-8?B?L3VqUXZXcmhONEVBSExJRjlBVmNKVUt5TERYU20yOFVzdVY1cmRaWGRXdFow?=
 =?utf-8?B?eGpYVFViVjJzUjJ4TXZweERTbDFhMVRNbitlMDNRT0JqUkhqc25DeHhFeUNp?=
 =?utf-8?B?WDVyUExYVWFIcXNqZEpKaXRxOVJJemdIa3NIQ3A3clFDdkQ4Sy9tV3U1azQ2?=
 =?utf-8?B?MldRSHF1dmZ0R09kMDNxOXFUYkdwTXFvUjVpcG5WUWVFdjR2REJWSUVnWWwy?=
 =?utf-8?B?ekdXM3lPMzhuekdQQzRqUFZ4cW45ODIydUhLODRLNVducWpkQ2F3bWdlWFdM?=
 =?utf-8?B?RG1VTTF2WFBabTNOU3NxODJYUWFkUG04b0hWaGFDTXhVRFVWd3dUT2UzR0tD?=
 =?utf-8?B?OWVReDlvcUk5SW0xT2RxZzhObkNFdlorOStQZ1REci9OSWNZaEIxcmJKQnFW?=
 =?utf-8?B?clluQ0Rxdk5mTG44UnhkSUg4Mld2dHpxNFp3TC80QklkNFZWaDJtQ0o3M0JM?=
 =?utf-8?B?c1FScWlmV3BwRkMxK0oyZUlHYkpNVHNTMUhvU1pYNkQ2dG9sZCtQemNheGlG?=
 =?utf-8?B?aHBNd0J3T2VPSjhjdHdtTXFkMDdEY3JNdzJvREFDNC95RVBTY285bGtJaXRv?=
 =?utf-8?B?ZFhMaXFuRFZTMXlmanJicFJEUkpPVWpqUHpPaTRBQlNkNEIwNHNyTzJRc21h?=
 =?utf-8?B?aWtkMk56YWJVUFM4bUU3WlhCN3JYeWlYV2NoMk5mOGVaOVg2bGM5bmxnL2Q3?=
 =?utf-8?B?aXFaSWY3NytOcjcrNys3TXB4NkIvdTRiMjhWamJFY0xXSHZhbWJyWVk0RVRq?=
 =?utf-8?B?YUsvMVFTeEpleXRxQVRWamFFRUN0UEhEekQ2ZVdHRDZpY2FSMWt2YjFiL1Vv?=
 =?utf-8?B?cTNNS1pPcFZYaitBK2p4ejVYaEFRWmpvbHJFSnB0bW1ienNNb2JFTnlpMjZn?=
 =?utf-8?B?c2NzWXJwR0RscjR0aXRVa3V4RFo3aWVkSmRMOUQrQkd2MlVkRzYyUWh5NGUr?=
 =?utf-8?B?aEdUVFI3MGUybVdRdXF4WWNNbElPYm9yVHhLa3dnRWI1ZmZHS0dMRWtHaTBV?=
 =?utf-8?B?Zm9yRTd2NWszZVZvYk5JeDdOWkFQVzhmWEZmaElOdmFSYzFITlVuYUl1N1hz?=
 =?utf-8?B?NndESTBjc3M4VFlNazR1c2JCLzVwZ2R1ODZ1OThQTDk0QWo3dTN4WUZ5WUxh?=
 =?utf-8?B?b2s4QjNEUDlIamFxaWhZRWFOczU2QkJKbEhoa0Jrb0k5ZC9yZUFDWExZNGNH?=
 =?utf-8?B?YUpoOXU4Rm5IL0FwM0k0NFVpNlRUMTZvUHJaNzliYXNVNFpyVk5oWXQrY29r?=
 =?utf-8?B?enhVUkF2SklBNkRnWmRHWjlZT3Z4WXdWdUJGTVFNQ20wN2c5VEludGpxVEZr?=
 =?utf-8?B?bjdoTmh4RFF2QlZPa0IwTnV4ZVVUT29OU0hIUmw3YkF0QlZUaWZCaHpyV1NX?=
 =?utf-8?B?U3ozb2RXVHBGUUdXRzNvZk54Vi9zNWY1YkIwcnJNcG1zSGR1TTd0LzNGaW1z?=
 =?utf-8?Q?FDd20DFR+Hf0mhpmQrE8/1huuac45c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlI2WE85RlJhRld4azIzT0Z2OXZkRWwvV0dwSVVuMEdRMW41M01mTmRPTVdL?=
 =?utf-8?B?c3Nvb1B1UWN0L21BMk9Ka0FmRkQrQk5HNHZSVVU5NnVDZ200OHRIenp0MmRH?=
 =?utf-8?B?a1E1cFMybHk2eWlqSFZ2TEM3NjBvVmgwZTdseXhxN1A0dkdNdnJPS0FOQ2tx?=
 =?utf-8?B?WW1NdWEzT0NjMEp4QXMwWDJiTEtJRWJ1R3diMXpaVG9RVktCazBxZ0trcDBn?=
 =?utf-8?B?cXd4MmE3UWs3blpGUGRvSjJPRWZnTWpMeGNFNHkyZDJjblhzMW05SmN5K1NR?=
 =?utf-8?B?ZHo1Sm1hVDAwRk5TVFhnYWY0WDhZZjZRUnViTS9TVDRWOTg4Mmg2VFBzYXE4?=
 =?utf-8?B?cnRqTEw3N2dBWUp4NVd3dEUwODNkV09PQXBHZCtRSEM2WTZhR2V4Rkc5bEFC?=
 =?utf-8?B?UnJYa3VTalkvNTQyVk0xM0ZQVFlYM3dMKy8yS2VyZlZlMjIxR3F2NDBGbU9P?=
 =?utf-8?B?SXZldmtpUzFtWFg3TGFmcWZiQjZUb2d6Qm84Zi92VjdrU0VVWWFiVzJaYWF5?=
 =?utf-8?B?OUNzb1BDZlNTMWF6KzdGQmdxelhiVVpaTXZJWlZ0R2p2akI2NkdIWWhjMkdj?=
 =?utf-8?B?a3Y4eWw3dkI1cHJGOGt3RWNnRWxmb2RXRU96eDFXRXMrck5pbHdzSUhHSFU3?=
 =?utf-8?B?OUp3aXhKcWhSU0ZURVFITGxxQTBPN1JTeThnV1NleFJmdksyVnJieFFGKzI3?=
 =?utf-8?B?WWJZYi9PeC8yTVE5TlZEbHlpZGRRc3pWT3NGRFoxRW4yTG9PcFNwcXJKU3Bh?=
 =?utf-8?B?WkczdmVjV09qaGI0Zy94bEdPMS9xOHdjTDZvRXFJQzBxaTFFZ3JtQWsyblFJ?=
 =?utf-8?B?K2RjMVk2a2JGb0FxcEMrNENKd3R0M0VSQnFXSEtLWEVNdFZxc0RsOElnbUxW?=
 =?utf-8?B?OVgzbVFsR2trdWRXZmdySlhuREV2K2xtMW9YUGF2N01XN3JCc1hYei8yb0d3?=
 =?utf-8?B?VGNBMm8rVGJUU2JzWU1ySFU4UjFCNHBSRGppQXhRSENUQTRiUW04b3o0NWZK?=
 =?utf-8?B?ZEhQaiswYUU5dUtNNDN6bEE1alZJTmxnbkFDOVJhWmhkbWtoaVJyTWNXUC94?=
 =?utf-8?B?VnA3NUxZWnJKNWNnOE91N0pCczlTaFlLWUlrazY2RTFYbnZ4UWMxVmp5ZDVO?=
 =?utf-8?B?K3ZqWEl5SkFsS2ZPZHcrd1o2U0xvR0pqYkJMN3F5Z1RuSDQ4VXpjQk5NbXdm?=
 =?utf-8?B?Mnpob25SUE1YcVJmY0lYdjhTYmt2SzFQL2hHaWRYc0FlNldGNkVnOWZxUDhw?=
 =?utf-8?B?NGFkWU82WmNZOHVPWUFjMnh1UUlMMGNYTEVvRjFxY2NreUU0ODJyT0NWc3V4?=
 =?utf-8?B?NjlwQm1LNzhKRDJuZEdzZEx4OHg5b1BGbFBVTmJ5R2lOSXdQeDVTU1BKVTJt?=
 =?utf-8?B?YXlXN1dSVDVuNUJhUWV5UG14K056S3dvdmUxZzQxWU1TNytpUjJoR2JHS0xK?=
 =?utf-8?B?eHlSa3R6c3dFN0VGMDRJZG9DNks4b1lBMytzV0hCR2NTL2djTzVxMFZVRmVi?=
 =?utf-8?B?eC96TCsyYTREcGJGYXQvZEtEZVdOZW1vUkRUT2tBYytXTVZYc3A3T2s3SHJO?=
 =?utf-8?B?Um1QSThOOGtzc3VlQ1BnWHdhK05Neld6OFFJUGwwdk15R3QzeWVadjZVbG9E?=
 =?utf-8?B?RE5xcFdKbTRiYnA0anJMaHhLNTEvUnBKK0VvTTRZRWp2UTh1azlWNEJCb1Jv?=
 =?utf-8?B?VGhtbk94c2pTeWIzNVhxcUhsMitpWDZtbTdSaGxYSFpFWVRuL2xQalpMWUNW?=
 =?utf-8?B?ZlNZVmJOOUJkcXdHaVNTV3V4Vkxpa29McUZtd2QwSjZzSnlrM3RBOXpqclVj?=
 =?utf-8?B?WDFuekQ3bEJqVEVRaURyMS9PKzhsNkNxYm5OWUZOcXFjaTBEQ3FTdXdMTysr?=
 =?utf-8?B?RCtobTNWR3RzTTBORkJ2cGhGUmlGTTdKNk1yRnl6TTZXekZ3ZzhaOE11K3Ew?=
 =?utf-8?B?SDF2RDBFVElxdXFKUnpaODlqcnV2Y2hjMFBBQ1pDQmpkMmFGRTZJNlRCWUxH?=
 =?utf-8?B?a3JLUGxQTlNINGtoOWhmbTVRTEVhOElLSlI4M1RYZW1STi9XRURkSkVPUHFI?=
 =?utf-8?B?bm1VbTA3VkJRTXJYeHY5NzBGZkJOQ3JucWROMW9HVThyaVArS051ZVhDTCt1?=
 =?utf-8?B?VldaK3ZMUEgybHViU1Q3Nm01WGlSUEN0M0M2Wk9CRnBRUkFUanpHMHJ2UUFP?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BFC3976849192469E0DC201414DF2ED@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RO+7Mr9vFRJXPKv8Bjf3tz5qHzseYJF0fHr8sQ3KYNlC76ckiCtIw45eAY5c25f1KYIzNCIaKcqbY4qvbh4q3NvVr5680SWql1kB+LTUSC3CDtc+AQRQLpBogA9JHFYhyWxXy0+w1/SYE6C4CExgwWeFyy7tmHuA+/wtsMmqrShNejiLAPuyub0PQtr40FjnJCcShFIx6nEC0Y54QVolOWq9sPz76lSpAmFoj6DKO5BV3DAEGOMqBKuaTrZJ2v6uFDt2MskNVEez5RYhji86LW7GPF3eLQVFJuEZFA5n2gQCHZ90Tkeulp6S0wiQBwxSa9iltBHf04yGl/kXIglW9CKqqNI8dc9GMVhE4+eh7imZDOJMQWoT/TTneNarBfN5F8Rh1eAgwXatBgVs5PjY4isoKwhfSpWc918hqK9vjX+3JLxznbPs7oxRvwV3e0t0Mw1w+OA/H3i8uyQc6pVQ3rACQNVpTH8GOPRnZGnQ95rCudSnVcv2Ox7FCARq7G7/6ryA2Bms7lb3M16fndalR4eRVW+L9G73Bzb15O9NrNwmbJgySF6OZphQgUGaFcVbbqg+1yNPQIIuPP4pjS9MN9Kkhs0rTKjQigEou0804NP4yE9IwkTclJUYc73efDBA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2354531-11ee-4aa0-04c3-08ddc3f27b94
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 22:53:57.8921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +tm0Dn2VPF13wCnleGQcrE1LIsLaXKwPAVnXvCh23evwX2tUhOshmukjqckhme1iYG8giJH8QLxgtSmwUt9mXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8422

SGV5IERhdmlkLA0KDQpRdWljayBmb2xsb3cgdXAsIHRoZXJlJ3MgYSBuZXcgc2VyaWVzIGZyb20g
TWFuaSBub3cgWzFdLiBXaGljaCBzaG91bGQNCmhhdmUgYWxsIHRoZSBwYXRjaGVzIHlvdSBuZWVk
IHRvIHRlc3QgdGhlIHJlc2V0IHNsb3QgZnVuY3Rpb25hbGl0eS4NCg0KQ2hlZXJzLA0KV2lsZnJl
ZA0KDQpbMV0NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS8yMDI1MDcxNS1wY2kt
cG9ydC1yZXNldC12Ni0wLTZmOWNjZTk0ZTdiYkBvc3MucXVhbGNvbW0uY29tLw0KDQpPbiBUdWUs
IDIwMjUtMDctMTUgYXQgMTM6MDkgKzEwMDAsIFdpbGZyZWQgTWFsbGF3YSB3cm90ZToNCj4gSGV5
IERhdmlkLA0KPiANCj4gVGhlIHNlcmllcyB3YXMgZHJvcHBlZCBkdWUgdG8gc29tZSBjaGFuZ2Vz
IHRoYXQgbmVlZCB0byBiZSBhZGRlZC4gSQ0KPiBiZWxpZXZlIE1hbmkgaXMgd29ya2luZyBvbiBp
dC4gSG93ZXZlciwgeW91IHNob3VsZCBzdGlsbCBiZSBhYmxlIHRvDQo+IHRlc3QgdGhpbmdzIHdp
dGggdGhlIGFkZGl0aW9uIG9mIHRoZSByZXNldCBzbG90IHNlcmllcyBbMV0sIGFuZCB0aGUNCj4g
c3VwcG9ydCBmb3IgdGhlIGR3Yy1yb2NrY2hpcCBkcml2ZXIgWzJdLiBUaGUgcmVzZXQgc2xvdCBj
b2RlIHNob3VsZA0KPiBydW4NCj4gb24gYSBsaW5rIGRvd24sIHNvIGl0IG1heSBoZWxwIHlvdXIg
Y2FzZS4gV29ydGggYSB0cnkgOikNCj4gDQo+IFsxXQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1wY2kvMjAyNTA1MDgtcGNpZS1yZXNldC1zbG90LXY0LTAtNzA1MDA5M2UyYjUwQGxp
bmFyby5vcmcvDQo+IA0KPiBbMl0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNp
LzIwMjUwNTA5LWI0LXBjaV9kd2NfcmVzZXRfc3VwcG9ydC12My0xLTM3ZTk2YjQ2OTJlN0B3ZGMu
Y29tLw0KPiANCj4gUmVnYXJkcywNCj4gV2lsZnJlZA0KPiBPbiBGcmksIDIwMjUtMDctMTEgYXQg
MTk6NDggLTAzMDAsIERhdmlkIEJyZW1uZXIgd3JvdGU6DQo+ID4gDQo+ID4gV2hhdCBpcyB0aGUg
Y3VycmVudCBzdGF0dXMgb2YgdGhpcyBwYXRjaCAoYW5kIHRoZSBwcmUtcmVxdWlzaXRlcykNCj4g
PiB3aXRoDQo+ID4gcmVzcGVjdCB0byBtYWlubGluZSBsaW51eD8NCj4gPiANCj4gPiBJJ20gd29u
ZGVyaW5nIGlmIGl0IG1pZ2h0IGJlIHJlbGV2ZW50IHRvIHRoZSBwcm9ibGVtcyBbMV0gSSd2ZSBi
ZWVuDQo+ID4gaGF2aW5nIHdpdGggcmszNTg4IHJlc3VtZSwgYnV0IGl0IGlzbid0IGNsZWFyIHRv
IG1lIHdoYXQgSSBuZWVkIHRvDQo+ID4gYXBwbHkNCj4gPiB0byBlLmcuIHY2LjE2fnJjMSB0byB0
ZXN0IGl0Lg0KPiA+IA0KPiA+IFsxXTogaHR0cHM6Ly93d3cuY3MudW5iLmNhL35icmVtbmVyL2Js
b2cvcG9zdHMvaGliZXJuYXRlLXBvY2tldC00Lw0K


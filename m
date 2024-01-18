Return-Path: <linux-pci+bounces-2308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF768831246
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 06:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FC1CB22869
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 05:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89B253B4;
	Thu, 18 Jan 2024 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bjstfmYU"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2657A53A4;
	Thu, 18 Jan 2024 05:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705554538; cv=fail; b=T9xmQn4KwysdxqqLIPYRNJLGpOVTzJxtqpz+BIWUgkoKVuLppp5UC/j5Ftbou9R/fjYnQhSWUmGG590GcUBKCtn7kn2xai53ESTlegLjJkgWBo2fcTdpISD/bgdDrPf98Wzz4L1olSyEtyG1uA6xJFcB0SohkmThhoNmbb7hqdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705554538; c=relaxed/simple;
	bh=6K/Mkpj5l4DEOAGFEJ2dPEBXeynfMl/9ssJ8UdAkCQI=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=f30S0o53aNlfERtcCRFQqEDvgzlcV4iVtyOhCsX2nmprBfJn1d5sNzouac0CN6LaNX8s6LA77nHp+SLXpbudN6n8tbPKT8s39tlbNjWeQZDZemGXxh05Dza5wvS/qODCS/j8X73G3W5NW2tPGL57Un8WooKkmAi0wXXugFegYsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bjstfmYU; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705554535; x=1737090535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6K/Mkpj5l4DEOAGFEJ2dPEBXeynfMl/9ssJ8UdAkCQI=;
  b=bjstfmYUHllM0gHlt7hiD2/48oHxsGPcG8p9Um9VfpxzPH0getpsAUun
   V0r5Z+vZV7/GhiY9h6kI6Z+J9y/0di9ZSfM35y0usoYFV+S1e1F7qO46K
   uAUZZV+wddO/e4ZbVaGFQRFxfXrh5WzCZxsD78qF43Vo3EOEMItkxgg4b
   1lAtuAXEfpBFVXax6COAaKhB+9PbWf9C85ZaEH+2LP6k3iQk/pik+BVg7
   ArKENWvdSRYEBW/l9q3MgIJkNHN8B3IGAfRK+KXE4mq/6PkOHF4Ha4Wma
   wBmwJfi6sX1EaLSeQqguCB79Jl2WJ8oLojJ2DmEf4//XBbtXmW/qGn8/5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="108862470"
X-IronPort-AV: E=Sophos;i="6.05,201,1701097200"; 
   d="scan'208";a="108862470"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 14:07:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvKj1rl5YvNaRz3D/x4v2yZhC0wOM0sMsypED9neOp30R5xK5Tjke7uhaOeSmrTRjhDlAIhxaH4YsVTd7+NL5+wPYJAQaqaA7FA965L/frtwmYlOIuQRqWE/gjlrQ7UoNV/FyGIkNxfRqcku2mHIVJ/S1jJPwkL0GXmV+W68Nvbf7v5JTQWQp2UYDE5HvUqllf8B7ylfGMKpK4z2A2hKhcrDMUGsE4DO2I+NtotaNvR0E50uRQWxcDDHoWuie5IWD7A3GJcT3h0clWbqiP7XHiYyGu7ix56m3do6+VXSP56kf710JyIlXBnDsd7H2eyx73QHhAqwS5dHJA+5da30gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6K/Mkpj5l4DEOAGFEJ2dPEBXeynfMl/9ssJ8UdAkCQI=;
 b=V5m8mGzAfjwF/pItmXo2DUVZ1FWwl4mpwpCBQ4x5v7HE4c6HtcFlYTmPM6Wn9yhg4eS43F0myIF1mcu6yU7CzGY4xotUZCmcClvfr4zI+kBvBpgrt0O6VdlIrbuDjIv/gA2qJTIQjzca8oFTo7OV9OGvFTtXaoLAbQHc44yfcK/SswAIXel2+6QPc7NuVDTPGoJuZvqAaWQ69fAdMJNeGEsP2e36woT93MdbyuLnbMMfPHO3dwt6292Z4Rip/+MGmFqzfUe9Is9x4j7ru1FpRawXxaw6sdsvjCVBmqkczKLr3f5TgBYM7vqHngdoFTH37e2PXu4fzMWhIh4Kt3T+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB11764.jpnprd01.prod.outlook.com (2603:1096:400:3b8::7)
 by TYCPR01MB10364.jpnprd01.prod.outlook.com (2603:1096:400:240::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 05:07:40 +0000
Received: from TYCPR01MB11764.jpnprd01.prod.outlook.com
 ([fe80::19d6:fc5e:27ce:1700]) by TYCPR01MB11764.jpnprd01.prod.outlook.com
 ([fe80::19d6:fc5e:27ce:1700%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 05:07:40 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: =?utf-8?B?J01hcnRpbiBNYXJlxaEn?= <mj@ucw.cz>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>, "'mj@ucw.cz'" <mj@ucw.cz>
Subject: RE: [RFC PATCH 0/3] lspci: Display cxl1.1 device link status
Thread-Topic: [RFC PATCH 0/3] lspci: Display cxl1.1 device link status
Thread-Index: AQHaMwXr559Y+43gz0Gam6b/l4Ghc7DeFmIAgAEY40A=
Date: Thu, 18 Jan 2024 05:07:40 +0000
Message-ID:
 <TYCPR01MB117646BFAEC01B301BE485D4FBA712@TYCPR01MB11764.jpnprd01.prod.outlook.com>
References: <20231220050738.178481-1-kobayashi.da-06@fujitsu.com>
 <mj+md-20240117.120837.23579.nikam@ucw.cz>
In-Reply-To: <mj+md-20240117.120837.23579.nikam@ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MzgxMDQ3MGEtNzE3Zi00YmI1LWEyOTYtMTkwMTJmMmEw?=
 =?utf-8?B?MWRiO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjQtMDEtMThUMDQ6NTY6MTJaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11764:EE_|TYCPR01MB10364:EE_
x-ms-office365-filtering-correlation-id: 6a797dd4-ff2f-4e8a-58ea-08dc17e36527
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 n0PqqYoCSk3mmTgoy7OEc2rtc/ruD07ieKCGEOVZrUsnTwfT7F3tVK1NbOaqGwZLY+ySvEakpvp85jSHJQGsDQ5OSj/ylIYSR7HrySHnGTANo3gpDWk77sUDPN6Ahc00Brt+l1wgeBm9EBkIc0MD4QEJXMuNauTnNBb33IpFsVhYOdZlVoESxoPSt8BvU2Qagg40VLyMIt+k02ZQeqXXkW6xG1sO/z/I96qCmPZpKjX8owm9Nzk1A/zl/5EHzUpzL79S2P4fIE/1XSeiY3Ox0CfFokGJwHy+INDJ5nRXlyTbNpLs5YAQam6GXO4w1iFd7Jtotp3czzVlnbLQdq3AzzTE4xnWrkzu9Dqe/U0VMrNV2JzFeX+QxCmx1KRi75DuH8E46FB7GEbI/Fq5xKdcLKD9IkeMsdhSBWtaXuWPHDzAOAURjjqTaHLPtc5vR5y+hlD03urM6FsXpJM2zb1NRXPpnvxSPhAaBgL693zbGIoexuI69LD0j1DY60FPk/lt18r4IW34vV+NfUs2gEQD1tP3STy7nwigHBaWXkmE4D3IByBRdPdhfnioReaGivYRAOg52hn9sU+p9hj0lpriVj7GfmRstnpUmj7cfbsWvwFcDKNlknNgQHwj6Fk+e5vly+2NeC1eGdZKeQj1Alo+Pw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11764.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1590799021)(1580799018)(86362001)(83380400001)(4744005)(26005)(41300700001)(82960400001)(122000001)(52536014)(64756008)(66476007)(66556008)(66946007)(76116006)(316002)(8936002)(5660300002)(6916009)(8676002)(2906002)(4326008)(38100700002)(54906003)(66446008)(6506007)(7696005)(9686003)(53546011)(71200400001)(966005)(478600001)(38070700009)(33656002)(85182001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U210MFA1azFmM3k4Ynl1NGtyM0dnS2VoNXVQaW5ab1hHcytzY2lFTXpZMTFG?=
 =?utf-8?B?aXFSZ2RhNlNLNURHN09rejZMZ01rZk9SK25SR2kzejBhUmxLaXF3OFpyWms5?=
 =?utf-8?B?VVlNVlJaTDd0S2tPTFQwNVVoQU1hNEJwelVtNWxoL3JZNFl3bXordnN5M3No?=
 =?utf-8?B?YWl3cDA3TGYzNEZ2K2t6YnhLRUdCQXpvdlFFQjBMWkNZVUhuUy93QlAxQjlX?=
 =?utf-8?B?TXBrMkFmNGhOVTlDZUJHZ2ZvbkxDbERvclM3OEJuQ3d1dEVncWdHY3d0WitU?=
 =?utf-8?B?M0E1TFY1SmJEYWlkdE1oNUNxL1REelQ5bENucUhvd3lLZU5NUUxZaUd4RVVQ?=
 =?utf-8?B?Q3ZVbXRGVmVFZWpDYjYva2RDZG5XY05NRFFpQUkwVGgvR05ZOW8zL3E4cEVr?=
 =?utf-8?B?VWpIdHNuWnZnanpEeWdaZGgvRFpUVzNzWWZnOTEzSXNyS0hvWVNabXgrUUNY?=
 =?utf-8?B?MFFqOE9WUmFnOEY3MElnZTJyMTc3bG1vK2tvellJQXpXb1JyUlB4dVRMdlZR?=
 =?utf-8?B?QlpBa2RlRXFFUFNVNGZZdHZ2N1ZCZCtGbVhHb0dacTVMKzlGZDZWUU5XZmY0?=
 =?utf-8?B?RjFHcmIzQmo3ZFY5RTFSSzNjS0RxWEpBc2c2eVVKRVIyWTNZbXAvQWNQZ0tt?=
 =?utf-8?B?ZnhTMHZxZ0RqNE9Ia3BrbGtSb1R5RUFtUUczeXY5OEdKL0k5SFZPS1VIU1Nx?=
 =?utf-8?B?QUNhbmZ2N2xISGE0dXQrV295bmdxRmt3M3ZSZXkvOGpocVpzT2pJT2FIQWFl?=
 =?utf-8?B?eVNKTExocVVCUDAvRHZSd3ZMUktLZCswSERsOWhBOGhlNmcxeDd2RTN3TDh3?=
 =?utf-8?B?eGtMQ0l1b0dYaTg3TmZxTDhieWlUMVNzR2FCcHdJdVhLb3ZpeW1mTmlVS0tS?=
 =?utf-8?B?MXMwSWhDM2pwNnZIa01mV2E4cDhGZjlPb0lFdDVrakpiS0gxNWdmenRGSWZr?=
 =?utf-8?B?WmlNY0RDS0xXNE5FT2Y5d2UzQU44dmpvbEs4TWlFRXFnRzZmdEhFS3EwMEFE?=
 =?utf-8?B?MUlDWFBYbmpxVk1XK3VFU00yUjROdHVMSHdvNFR6ZnpMWGVzQzJYb0hQejdF?=
 =?utf-8?B?ZXVQczRDdFhBM3NFQjFtcnoyZDFQdTYyTlEvdTRXU0kwR1Y3YzUrWWtYNzVZ?=
 =?utf-8?B?eDFSczdhZTRDb0ZoUXZyeHZoa3BYaTdiRFlRTnNJTWd6UXdPNjJwZHEwR2Jy?=
 =?utf-8?B?VXZ6L3ZQMkVvRXlBeVg1UWxNb1ZLaEtYU1hJNzdlYWxBRkt0S3Exa1RoT2dF?=
 =?utf-8?B?RWM0b2F2NjAxd3JBZmI3Yk11aEt6UUdCR2hGYWFnMnVTS0FDcEx5VnRTZjVK?=
 =?utf-8?B?UjJEallETGMxVDByK0thMUNIUHJ2clhvbUpFOWdmcURxcWY4OWZ0dVRRTVBM?=
 =?utf-8?B?NU9tVm1JbEtqTzA3TkxNNmVWazNJaHNyT0tMdDM3dlVrWFF6TE44V0RtZ28w?=
 =?utf-8?B?YUdqRmRDaGpxUlNML1ZJSGJVMkxaSXdDUjY1bHhkQkZrbGlQSzRDdkUxZnRL?=
 =?utf-8?B?U2g1UWdVbGFrK2N1bTNqZlU5RnZjNE92YXVlUXY0SHliTVI1NXk2Q0krbkcr?=
 =?utf-8?B?M1lDT3Y4NTFUU3J6eFhTb3kyRjZEbWVuUmtFT2gwS2pxQTRLOXFYSGN2NGRD?=
 =?utf-8?B?U2xvQ1E3WUFUYllZUUtDRURGNHoyMVd3MjFWOGxUNWxiVmMxaGZ1ZzRhZ1lu?=
 =?utf-8?B?TU9KMWIwRVJYMDhvb0l0WHhPd1BoU0MvaWNIdFkwOURweHZEcGRtcmNkbU0y?=
 =?utf-8?B?dFRoY2poTXVacFFKeTdwM1RFMVppQWxQbUlidE1aOUFwQW81OWxabHZVQ3dB?=
 =?utf-8?B?NG5VNnpmUGgvWWFSMlE3OEd2azBhOHQ5NC92WlRSSHUxOG1SeDJGSWd6MEJW?=
 =?utf-8?B?TnFsVUo1TFNaOUx2d2tRNlh0blZBS01KaVdsTnNSeWN6LzR4VFhrMmgrNWFa?=
 =?utf-8?B?THVyeG5uZXNnbTJGYnMzTzJqMldYVkk0dWN4WEI1V0ZWTHJFQW5pMmVjQ0JE?=
 =?utf-8?B?YzJoa3BsdzJ1WnBWNkJQbXhXVG1oVStTZHZLTHdCdUF5NVIvL1ZaVGxra0FG?=
 =?utf-8?B?VCsvc1dlMnlxRm9NSlp3M3hhOFBuNWgyVGI0Y0xPSzhhbzRJK0YrZENKMFRH?=
 =?utf-8?B?VjNLc1h4WCtGSWRJMEV6TTlPZElSc0pJQTErTWp0QWM4QUlhRjFtd1M5S01M?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jh99BUj40pcx35fZz7BKxRNqiSo2N/59NX8uUVGMw5tFs0ALTiTlR0yuMUjTGThQor6UxITUtmy7qCdHuB8QxnrdW82tuf4bGTjxpTgd1QiSfjd2JbdiUXk2oD1rlFzdL4F4/YLZweBtIgD0FE+JWOY04gnFqiflRBRBijI6Y1QOYc7rcnXb+OXac0NMxKN/7MUjZXAN4elnSK1RdvHa8dX5m0B7pWw0djq5cA3e94es4JzpscX5Tv83wUbrwNO3JE1UAmh4n+qUvvtsxlNf/jS96q9P+hiwkbBGbBHU84srUdlNQQxrCHRuUMfaoRFC7YteJWkKSlKFbof2M6YMStK1d5yKuHrkuPiuOZz5ZCdZ4OXgDHxtqmMG0GeOjB+p8UypaV7R44FR1H/26d7cyQKkMaZiJydgrYC4l6TV7er4OWaRVDs8kkOsOjEo280tynI31C+Qoxh3FfkanyMOiK+HfzOXBxUDH520rlG2iiSLnqjrB7oyEF1NbDxcban/+Dbz9HJQePDnS0Sq5Egrfql6QotWNM+5LY/yXjDJLNYheMpwOVcJ2C/n5ywRw8ta5GTaJJPXA8+p4n96G9iyh9wMM6TkEYE2BmCZh9P08oDff8TJqMWTkKNjPwPNL7Sz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11764.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a797dd4-ff2f-4e8a-58ea-08dc17e36527
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 05:07:40.1440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U/0Z5T6jrBkTZGJIR/qmGZbXcZ68S2D7a81fUhMd0W7H480nyUgZH7waLc3dT0BZ7i0100dXnl/qLfwawd5IVFmZbWGRkSMkZ8eBaC4C7x4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10364

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcnRpbiBNYXJlxaEgPG1q
QHVjdy5jej4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDE3LCAyMDI0IDk6MTEgUE0NCj4g
VG86IEtvYmF5YXNoaSwgRGFpc3VrZS/lsI/mnpcg5aSn5LuLIDxrb2JheWFzaGkuZGEtMDZAZnVq
aXRzdS5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1jeGxAdmdl
ci5rZXJuZWwub3JnOyBHb3RvdSwgWWFzdW5vcmkv5LqU5bO2DQo+IOW6t+aWhyA8eS1nb3RvQGZ1
aml0c3UuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAwLzNdIGxzcGNpOiBEaXNwbGF5
IGN4bDEuMSBkZXZpY2UgbGluayBzdGF0dXMNCj4gDQo+IEhlbGxvIQ0KPiANCj4gU29ycnkgZm9y
IHRoZSBsYXRlIHJlcGx5LCBidXQgdGhlc2UgZGF5cyBJIGRvbid0IHJlYWQgbGludXgtcGNpIHJl
Z3VsYXJseS4gUGxlYXNlIENjDQo+IG1lIG9uIGFsbCBwYXRjaGVzIGZvciB0aGUgcGNpdXRpbHMu
DQo+IA0KDQpJIHNlZS4gSSdsbCBpbmNsdWRlIHlvdSBpbiBDQy4NCg0KPiBBbnl3YXkuLi4NCj4g
DQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyB0aGUgcmlnaHQgYXBwcm9hY2guIFlvdSBwb2tlIHRo
aW5ncyB5b3Ugc2hvdWxkbid0IGluIHVzZXINCj4gc3BhY2UsIHlvdSBhbHNvIG1ha2Ugc29tZSBi
b2xkIGFzc3VtcHRpb25zIG9uIGVuZGlhbml0eSBvZiB0aGUgbWFjaGluZSAoeW91DQo+IGFyZSB1
c2luZyBuYXRpdmUgQyBzdHJ1Y3RzIGZvciBkYXRhIHByb3ZpZGVkIGJ5IHRoZSBoYXJkd2FyZSku
DQo+IA0KPiBUaGlzIGJlbG9uZ3MgdG8gdGhlIGtlcm5lbC4NCg0KVGhhbmsgeW91LCBNYXJ0aW4u
IEkganVzdCB3YW50IHRvIHNheSB5b3UgbWFkZSBhIGdvb2QgcG9pbnQuIA0KSSB0b3RhbGx5IG1p
c3NlZCB0aGF0LCBzbyB0aGFua3MgZm9yIHBvaW50aW5nIGl0IG91dC4NCg0KPiANCj4gCQkJCUhh
dmUgYSBuaWNlIGZvcnRuaWdodA0KPiAtLQ0KPiBNYXJ0aW4gYE1KJyBNYXJlxaEgICAgICAgICAg
ICAgICAgICAgICAgICA8bWpAdWN3LmN6Pg0KPiBodHRwOi8vbWoudWN3LmN6Lw0KPiBVbml0ZWQg
Q29tcHV0ZXIgV2l6YXJkcywgUHJhZ3VlLCBDemVjaCBSZXB1YmxpYywgRXVyb3BlLCBFYXJ0aCwg
VW5pdmVyc2UNCg==


Return-Path: <linux-pci+bounces-27471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87CCAB07F3
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 04:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4844E5123
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 02:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C149F18C06;
	Fri,  9 May 2025 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="atRipV9R";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eHpmzXkP"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD65410F2;
	Fri,  9 May 2025 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746758132; cv=fail; b=Nl+qM+kMRX6r2rcDikidU9mFCYyJx52+uLlrVURPGnbIZyM3DBx66dyIRwybjaIlP3NnVNQc8qxKeEtutyLmq2raoaZziRtB8Cr4R3h0WkMv1VNQ5d8XgAmUEUiEaHuVBJLH6hY05RdZt5MJIPlZJnYVhUYJmJPPQmnkc5KR5nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746758132; c=relaxed/simple;
	bh=rjctwD3mrB4rawCpUFLggSboOjsOHq64Z8MjCFoKKT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F/5WFMle4AGpER2EUG6MWyA394M7OaFeCxfLEc8JtpY+AMcUj8L7U+vtawpPSwWguE1+5M0A54qzBc8+jEpNKsepZcjfLKtTLT6Xp3DB4GU2QVvWzjhtvoYTeNxVRRzzhmeCJVKhg1Ek6w+eODnkb59H9nsQyL5GcW+XXH9Hmp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=atRipV9R; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eHpmzXkP; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746758131; x=1778294131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rjctwD3mrB4rawCpUFLggSboOjsOHq64Z8MjCFoKKT8=;
  b=atRipV9Rj+QkJjmOB6M1MXgneHrvy9vnBoZiWPuJHAHP4j21wIqqSstB
   fqeFTd1XOt8gaCjuJdQTI7inOnpO33+O8XSJR2d/73QNZbPO+2YW5w7mj
   XdQD71BJ++HqJWeGjVRScaE6wt/+vvcN4QOxX72rHzaCW2CXSC7QNWYZz
   w2dms3fHRLFT66DCLubEjYY5LZMhPsDN3PR0X+rbi7zS7rdzh3ZBbjTfh
   fHt9HlQKmtxE6KCKzDniQsQ/yMipJpCpxer7mbsegZfaHf7dB787iyvLQ
   BRxp21fDAQKSahBKZmv08DYlhNdOWMsfhsETUO4Mpl2TwSYBOFCcYuwOZ
   Q==;
X-CSE-ConnectionGUID: 3xepgtk9TkmUCEcSrq+FtA==
X-CSE-MsgGUID: 4xAfSEaVSOKyXwlEPpBlVA==
X-IronPort-AV: E=Sophos;i="6.15,274,1739808000"; 
   d="scan'208";a="81666689"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2025 10:35:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tiJP8nlPWjkMo7xK9ZOVfjzS4xwvZ6JWddA9zc0PEh45mCjcXifVebH+S5qRg3K1jGFMsh1pyMlRtm0Ipbfhvu2vJhsNRe54KCJ9bJAXaUvghJkQwOO1SDp2vE2kU9gu5mycuDobwVLZ0jgY29HlTSm3vlghWY0z7PQKRF2kvc+S+TStr0v1F5lB4HsxK7ztb39LiLBP8GapJ5aEl3wi8K5IJPhjWKTKzskN3+QiXW9oyUD49mq93OIwjrNiVBBnoq390QoRsikyhFT23rUOFqxFGU4i/MoCqRjOSNAkSxZP0FCwCxyOcZzm3SuVGR0LF1TeWpmqQq1ju6oC3loVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjctwD3mrB4rawCpUFLggSboOjsOHq64Z8MjCFoKKT8=;
 b=TiBzYm1v8IxWJmFBQUjt5wdFfaOsaaJha3h6WjC/PNVjP1pSqJaV0ukLw/VaFtkUlIZgwSTCRmtC9E+QIzS19pMcjxJpUlL2Ph6T+sB+1YyQZmMm4n9jsFWErympSgnrp66uK/vOLbRkWMG1ROLAFVVqdoChbi9E22kWML9O4+bevgUAkzRMDrhFnoFOJrGLPRuWLgYUNPUg9iHsf7+Gx2mVm2Gmdk9TKZLyYT4EIds9IMx5nQlbg2ubLOehbgnaHWTAp5hXOVhHHhQvNXuYTbiDodpU3p5QABZYO1l9lhgWvdA3jYGEvkJAvnR2rloLEELujE0DJ2ASlQ9UXi46Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjctwD3mrB4rawCpUFLggSboOjsOHq64Z8MjCFoKKT8=;
 b=eHpmzXkP8BEChHXnOqFK2AM2b2jHiwcjI3ykFGyeXwsCl8ic1r17Uc9McGtaNwl7ibuEFdpP6ifUfUcezZ1yw0mFL2OB2ZnG9qMqVdhuHzXHThjxLZivLazH2K3KP8G+cms6VyJXY9IUfeINuq8Q7lRh3VJZjx4SHMeC8IQMtfw=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by SA0PR04MB7404.namprd04.prod.outlook.com (2603:10b6:806:e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 9 May
 2025 02:35:13 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 02:35:12 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "cassel@kernel.org" <cassel@kernel.org>
CC: "dlemoal@kernel.org" <dlemoal@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"alistair@alistair23.me" <alistair@alistair23.me>, "robh@kernel.org"
	<robh@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"heiko@sntech.de" <heiko@sntech.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] PCI: dwc: Add support for slot reset on link down
 event
Thread-Topic: [PATCH v2] PCI: dwc: Add support for slot reset on link down
 event
Thread-Index: AQHbujx7ZfQsEfaRY0W1BCUFZRTTCrO+6uMAgASpmYCABg0DgA==
Date: Fri, 9 May 2025 02:35:12 +0000
Message-ID: <2cf165f6e7f3fbb28624d89ffbd775ee7d253e39.camel@wdc.com>
References: <20250501-b4-pci_dwc_reset_support-v2-1-d6912ab174c4@wdc.com>
	 <aBRtNOLQ6R-5iOB4@ryzen> <aBhWdySIH7jlIZMA@x1-carbon>
In-Reply-To: <aBhWdySIH7jlIZMA@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|SA0PR04MB7404:EE_
x-ms-office365-filtering-correlation-id: 04edd3d2-874e-4b1b-cb00-08dd8ea21f93
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y29xVjdnSDJCR2x3akcvbU54WWpMYjFTYzN4ZHF1aTZhaEc4SENaSyt0cmgy?=
 =?utf-8?B?bElkL0FhUldYVjE3Q0VMSm4zUVF5bi92dVNRZURFZU1XQ3VONFgxZGhQL1Fp?=
 =?utf-8?B?QUpyQWJ2RnpLbG00SDAwdlVjWStXeVdzdWVhK0R1ZUV5Qks1bXllQjY2bG43?=
 =?utf-8?B?UFNwbXB6TWwzZTcvWHMzTm9Bd2V1UVg0SzJWL2M1dXlHM016VmxodFNYb1Zs?=
 =?utf-8?B?aUw4VnBTNE44YmgvU3RwT2FHeVpLWVVIdjBJOWZSaE1Ob3hlRSt2alhONzRU?=
 =?utf-8?B?WGtLVzZLbjN5OGlNcG11c0R1RlpjeFpMZmw3bVFZY2l5VHN5a2NHZ2ZnQXBn?=
 =?utf-8?B?cUxwYmQxMUpLMzhDME1QektNaW5LVnliUitTekdlUm1ZajFVN3lBTHFSVFRM?=
 =?utf-8?B?aTE0ZW8rbW1wUEZCV1F1M2pUN2xDcnJsVFJvTXhvVitLNGs4d0ZmV0pHK05Z?=
 =?utf-8?B?Q2VXMi9lVnI1T3l1Y3dMRjFEcjRzc3FsNG8zZldkcUJEem1BMmV2R3VJdHNz?=
 =?utf-8?B?L2szc2lBUW8zRUQ3eWtoZWhCWGNqRmcwRk1lbnl1b2VTQ3lSb0JTQ0J3V1Z0?=
 =?utf-8?B?Yk5ZemhuYVZPV3M1bFhHYXUybHR4OXFnTEgrVE53OEZuVGYzK0NmakxRTmdR?=
 =?utf-8?B?QkQ5R0RhTWpMd2xyYzhoL1hJdlF6dkdXVk9lWWJOZENralFheXlkVjRJNVcw?=
 =?utf-8?B?L1VrV3doYXlvTmFuQlpsQXB0U1Q5TFRaUElUQ3pNRUUrZjZEaWhyaWtBbjJ3?=
 =?utf-8?B?S0lYVDl5WEpFSFdra1doRkhRN0pPaW1SdkM2YUtzNWExZDdiNWp4UCtzUVBj?=
 =?utf-8?B?NTUxeStrTlJyQ3VPbDhoREw1MHY3S2czWUZVb0YxT0dSbU9IcXdrSmlTYVJN?=
 =?utf-8?B?ckFKQnlLWHdTNWlmL2hDRk9oTWpFdnRtTzROdDB4bi9wbEZFV3RrU3FPQy9s?=
 =?utf-8?B?dzRyNkh1ZkwrVzZaSXZBV2U3SFA5NWc5aVF0bWU0QUZmc0RmYm1BQ3hSMTdS?=
 =?utf-8?B?VmxNUFRpU1RSb0JDVnJiSnBXalZualordS84UG5vRTlIbnlEYTVDUEpsbUNY?=
 =?utf-8?B?S2JSSVpUWnJVQTN1ZU91L0ZhVjRHM1BDTC9Eem5URmpLL1ZEY21qNXMyVGlE?=
 =?utf-8?B?ZGdwWWI0SkpTWmdtUHJsRTBZM1RaN0kvSWhMamsvT2hQMzZKQ2xPbGt0a2hw?=
 =?utf-8?B?bk56YjFkMnVuQjBJSGZpZDRhdFBIdUk1c3BOUkJEYzl6R3ZmaDRpSlNXN0Iw?=
 =?utf-8?B?K0xrRzNOUXJzUEloM3ZnWHl3STBUbE1iMEtuY3FCMldTemx3Y0RhWUxlV0dF?=
 =?utf-8?B?U0dzSEFDU3o0SDJsRFhneWlSZnNMTUdLNUdyd0VEeEZxZ1NRWWJsMG00YTNL?=
 =?utf-8?B?dndHdk5wZHlId1JsaW9VMldaNU1QK1FoVkNQNHh5bGRYdStXLzRIV0lDald3?=
 =?utf-8?B?KzdXT0g2eUdNUUpvdWU0YjB0Yjhjc0JmbVhwQkRCT2JjYkl4VDduMDEwS2I0?=
 =?utf-8?B?a0RoWnNiOHowaTRVWDFOaWVJSHRURVlxajJVSktHYytsYzF6dG1mZE51ZEhU?=
 =?utf-8?B?SDBTWWNKTFFyS2dPblBlSitKTDd0UzBSRTAzUzZBZURMd0k5Z0owLzJxK3hI?=
 =?utf-8?B?alIrQVgzODNhOU93MnVzdFdteE1KYVdybjdEbk44cDQ0YlNGTkhqSW1LWVZ2?=
 =?utf-8?B?WDN4UWJ5VUtmR2NnNUt1VnBtV1RsaktvKytMSW9qeS9CQWNtbmRjaFg5QWhx?=
 =?utf-8?B?K1NsZFhCdmtYMzluTXhMcFlKU1llL3ZGRktDci8wUCt6K2VVd3pmeS9aUmc3?=
 =?utf-8?B?Ymcyb2twR1NSU1Zna3VCdVVCNjViOHpraDVIS1NKR0p3TGFaWTRiS2IxcU44?=
 =?utf-8?B?SXV5T2EzTFZUcEZsR1JxczVtKzBhOGVxSUZxRDZNMGk5b1Z6bjRjWXVUK25I?=
 =?utf-8?B?ajRjenpHOUdCVzRmd3lsUTE0SFRuSkhCZXN2TXF6VGdJUUk0Q1BHaEhQaVdV?=
 =?utf-8?B?TGkrdzRxejVBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDZRcnFrd1F0RldobzhPTWpGYlI0UTZxUVl3b2xhQmtzOGcrNENobHQxN2R6?=
 =?utf-8?B?TlIxSG1OVkYva0ZTZVBueUhnQy9SSzBXSU1JdC9rajZsRGZpV2RQZjhqL1NC?=
 =?utf-8?B?WWFjWWFYcUV3L2p0Ni9sNlBiTzlJT29PeEtlYno2ZVN1UGpsNUV3NndPaGh6?=
 =?utf-8?B?WmpXU21lVU9IS05KSWp6WlJpTUExcno3d0lmVFdtRHgxbms3OXJCc01TVnNH?=
 =?utf-8?B?LzZVMWQvMEJvUjZQZEJSSUJrODBEZDdVVVJucXNkNE1oQkJnWFUwWFR4dXpq?=
 =?utf-8?B?eDhmN3QyM3V4b0EwdFBydnEzTHZlVTRiQTdhYXhBdlhpL3dBZGk3bncxejMx?=
 =?utf-8?B?U1dmNndKVUkrTHlEZ1VsSkc4SVRYOGdDNzBQQlhHTUorQWgxaExJQTU2anB4?=
 =?utf-8?B?bm1tNmtBeWJldWxZZDF2NDFHVUwyRXRWaEU2K1BjU2haOGVtNTR6SFRlazRP?=
 =?utf-8?B?V1gvb1lzcEt5K0xjS3NSNmYvZ3I1M2ZVeFEyaHdpSlBYaDhubUQrNXN3L2Yx?=
 =?utf-8?B?RDFKRUFjeG9zeVhpTjVidzVQWWUxdG4vYUpKMitpR3c2bUhMN0ZrQ3pUM3pt?=
 =?utf-8?B?NzY1NU85djhBaVY5eFRFTnV1blo5c2tSWlRiTXh0YmVJd2hHMkI0bEN5bVFw?=
 =?utf-8?B?NmZqK0xScmFoRitSeDArRHlQblVPUVdKNnBZVy9DaW9BaktmRTcwSGh1NWt1?=
 =?utf-8?B?UWdOc2tnY3pBeThaQ013Rnp0WXlQR0JmSGl0VjJWSWpRcTJDTXNHeFZGTmdM?=
 =?utf-8?B?bkF0Vk1BS0ZWZE43S2QwcjFxNEdjUW5qbzRXeWNjcC9hTVRGcGJlcjVhelBW?=
 =?utf-8?B?NU1FOFd5TWc5QURhSitMV3dsUlN6Z3VSejR5WmlGM1JEL0Z3bFRaUFM4b2lr?=
 =?utf-8?B?WUZBU1Fmd1lKeHQ1NG5rMjBRcnRaNVBCS21uY1dJN2VCaDdMSDJxbFpnNlJR?=
 =?utf-8?B?a0VVTktueXR0VDhrVjAyaVBsZkJ6K1hwQVpKaDlYSTRnRzBMelV1Rng4UUxD?=
 =?utf-8?B?eExjRW9JS0JtYVQrVDgxSDBRQ3dkUG00Wjd1V2FiaFU2dkFoclhHallTSjNl?=
 =?utf-8?B?ZjdPd0RTK1kwWURxalFycEdDUU5JQ2ZDckJ5ZnpIMHpsZHZNUWEvVkxrUWJZ?=
 =?utf-8?B?K3Y3djhyYkZBNlZKWklPdlpzdjhCRUZtTnVPWkVMdHBQRG8wK1hCandPTzNJ?=
 =?utf-8?B?OVBybG9LdHBiK3ZjTThWdGFpRjNsdkVJQTZxQmFjeXUyamtSeHpqajg1UUhi?=
 =?utf-8?B?Z2NiMmIybGtDRkgwRDdLYlJ6TlpPNzNKTkwyTVJCdEJ5UXhwODVxTnlDY2U0?=
 =?utf-8?B?anFVK3ZhQ0JpNDllaVAvaloyeWVPTC9XS1FUekdKUFBMZFB0djM3cjFqV0tz?=
 =?utf-8?B?Q3hJeUkrVGlxQk1yVGcyZXNaVmNKeXZlOVlFaTJSc2ZwNFYzWjNpZWM1Nnk2?=
 =?utf-8?B?VW5TemRVVE9xZERDUmRHTHVnVWdKQUtkaXE2WjJSTkNkTFk5dG1YTno3eVR4?=
 =?utf-8?B?UDE3VE9aQ2NGQmMvS1RKeU1saVE2SFpMSC9wcHIwbkx2aGdETkFpdGJuUVZL?=
 =?utf-8?B?Vko2UjJsMWQwK3FxakE3YU1sbmhSeTkrR2tFTTNObU5XVk55UG1qYkpocG5O?=
 =?utf-8?B?R0lqcGk5SFNNbVNXam40R2F4eldyK21nanQ1Z3RVeHg4N21zNU5ETWsyaEg2?=
 =?utf-8?B?WkZrY0JNY3hHMjhyYTkzNFVmL3VMMmttekdaRng0dUdQK29IYXpVaFFEVy9i?=
 =?utf-8?B?WXZJWVFRY3lJKzk3dVV3R1NRUEJqa1FNNkpkaHNoWkFZREl3b0Q4cUFiMFJt?=
 =?utf-8?B?aWNJSTdaaE9IZTkxRjQrckMycWxTMjgxTXM0QXZYRWxibmZZaG8xK1U1UW5I?=
 =?utf-8?B?R3FoLy9zUndFM2MzbEl2OGhBeUcrRm02YlZDNmo1anIzU3BZRHU5WVc1c2hz?=
 =?utf-8?B?M3Y4K1pnZEhHc0JmWldxS1JiK2IwWHZ3VWZWMFI5b2pkb2sxRmViUmRUT1pU?=
 =?utf-8?B?cStGMkRQL0JXeWJEWkRvbHp5MzAxUTZQNmg5L3I2UVAwQkNhUS9rcEtKakNE?=
 =?utf-8?B?R25IM2pYTWFyTDRGcnNnQlkvSC84ektuelRrbFRZRkVuV2ozNXhkZW9nZ05C?=
 =?utf-8?B?RDJBNXIzOFgvQldiY1pkTnRacitlckI5VHd5cVJtVFJGaDhTK1MzK0dveXBa?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94E5DA3B2D1CB04CA1BBE17CE77FEB98@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dlc6TseXt9DbZOyMSDUY64vZUb0qKsbLE9de0UW7RjayW0AM/JwJbykhWcZ2qbSmb1vbn2bwq3XGdqKC7hDSZPRyjtWqDoH1C3vKoTTWws2x0/LmlCgiwbMcFZj8i8K8IFlw1se7jniy/wUxn0d2lo2rz/e8SscdM+DmAX2k11WulkS7QrcXoq4NyJJha+g4Vi483Gu0mmOAHpT1jeFUi6fABizVMV0Q114PIvxGDIOnHLCTBK4MbjuTIgQKwJwqwuHbTLUgX1T6btHxpOz6SU6D1sVnElh3AqlBeZg3M4arOi4EwBGhjh/wkazfNaYJVtGcujKO8waxBaGwcvLkTJv0IgY8pr3MxpGkUILDE0iLfnvU3ovUgeQQr5fTZ71GoNfATB0UPESkswfPIeLnvhromxsaiCQWHV44zIT9atYyVDYM9E01kARr0BiY3FKC2ZRo/7j3eljqAetmIWnBVvsVZ+nRgRef3Bp3rsJVlbNYvCXltmma4G7LQswnZ4QuSrVzvv/LKuIT/0gnEJAm4m3AiLz1anDugKXudD/200YeNVeYz85VUiaQPi8phb0UzgO/QOaftU5heJ7VxeToLzcbNB0+5QIMDkwY0nQnksplt6r0ma/ZtwMXooXJnbjy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04edd3d2-874e-4b1b-cb00-08dd8ea21f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 02:35:12.1545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7OnioqudD21y+bdAAZDBKXZyoulWCTJdIYwC6XlcILi410XSxzJowJNZevqOijy8w8xPdutUr8655TvSQ1YPtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7404

T24gTW9uLCAyMDI1LTA1LTA1IGF0IDA4OjExICswMjAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0K
PiBIZWxsbyBXaWxmcmVkLA0KPiANCj4gV2hlbiBzdWJtaXR0aW5nIFYzLCBwbGVhc2UgY2hhbmdl
IHRoZSBzdWJqZWN0IHByZWZpeCB0bzoNCj4gIlBDSTogZHctcm9ja2NoaXA6IiwgYXMgdGhlIHBy
ZWZpeDogIlBDSTogZHdjOiIgaXMgb25seSBmb3IgcGF0Y2hlcw0KPiB0aGF0IGFyZSBnZW5lcmlj
IChhbmQgbm90IGdsdWUgZHJpdmVyIHNwZWNpZmljKS4NCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4g
TmlrbGFzDQpIZXkgTmlrbGFzLA0KDQpJIGp1c3Qgc2VudCBvdXQgYSBWMyB0aGF0IGlzIGJhc2Vk
IG9uIHRoZSBsYXRlc3Qgc2VyaWVzIChWNCkgZnJvbQ0KTWFuaXZhbm5hbiBhbmQgd2l0aCB5b3Vy
IGNvbW1lbnRzIGFkZHJlc3NlZC4gUmFuIHRoZSBzYW1lIHRlc3RzIG9uIGENClJvY2s1QiBob3N0
IGFuZCBldmVyeXRoaW5nIHNlZW1zIHRvIGJlIHdvcmtpbmcuIExldCBtZSBrbm93IGlmIHRoZXJl
J3MNCmFueXRoaW5nIGVsc2UuDQoNCkNoZWVycywNCldpbGZyZWQNCg==


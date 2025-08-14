Return-Path: <linux-pci+bounces-34024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3794B25B55
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 07:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E827AF063
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 05:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1356E225791;
	Thu, 14 Aug 2025 05:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d1fQkK/4"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011006.outbound.protection.outlook.com [52.101.65.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F74221FF5C;
	Thu, 14 Aug 2025 05:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150901; cv=fail; b=XuOHtIpjybNKpfuJ2GZ/X2fUHvGIWF8AB3A4XaX+k6Ag6GRvDpa948YW4tS27+LZEpORrLYI2sVgdpcoq2MoXtspbJlDSa0cwbXC6hj+HI+c7ig09YebqJrBfn5FLu8cLghgD4XKnJWIFNmyYWCtkbq1LHSBKqr3YLe2Dcd74+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150901; c=relaxed/simple;
	bh=VTayRBcFitOD6C+Fm2ze4lfKe6N8uVHjn3nay1YQ2W4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qARA7k7Mui8SYx7cMRbWeolZWGhYDvPaSDmhyWkczH574Xda5S/yj6jRZ1IGC1GFZads7Xu919jl8u7FOZTh7iINDHd3qwFqi8v/sabTGQvF/UoDKh/80y2lwgoFlpURJkO8uNutvJ+xfIwq80jjFDf/BbdOYPWH7eu3hMKRKPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d1fQkK/4; arc=fail smtp.client-ip=52.101.65.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RckwZvS0ofARQke2qMh3GwfrLKb+9Qm1+KMsl+QIncEoqANFlRW9mE4+of+0cRj4A/H99o5Qko9zEkvARA8HKI70rSanai8NzcjSYvOP5wdueRWUyIqgrpQVK/2MT/BOZw6hi6pGq1tzJy0BFoT5f9Hrh5QhKLdQrOhtCrzaxbxIP2gGHl0kJ0zz2RPMUL/hIUvtkMQrdqfcpBvyuJQARw9eq8+g9pNhHxQiyUkuVpp+YXdrOt2/OzbqvlVsD1gHIZ2Z8TKgXqT1QWK6cDsQpO1poer0qu6bTxvIAZu8pRjXq04oVDj8NZb4TnD38JkC/+5jy5aNl4mzCkvrQN7Jkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTayRBcFitOD6C+Fm2ze4lfKe6N8uVHjn3nay1YQ2W4=;
 b=Q8ZdiTtrqfvc0xCdqfwdlyjmFJ901JTNHVEzgsoN6gYUq0TnUNfFZRmBQdvoRAncHbxUT9nQV+x86ef3o+a2umMrhOxjQkZRFYMlPJcHaK6jSA0FXqsFP1LXfqu0gA7CU9RkmmeocF+t1t9mPgAQYzIQTH0Kk7El4lpKfB0YWnPAe9xLLS+mQNzuux97gAZlv5rOCQX06RHHxStn5Ht7N9SH/eB+7a0O3B/1im9+d+jmFD8aHHT0f1vcqgCfm42bdNoLdQ9dXasOqpwmqiwkXM+agndwXMlsszo4WsIpgiEk+Wen68cP4/wndjZZ7tUoxFAMk6a1aD2mPvVUu7CsCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTayRBcFitOD6C+Fm2ze4lfKe6N8uVHjn3nay1YQ2W4=;
 b=d1fQkK/4QHoPq2UTZG4GuLdPIVM9kGI3au3GU9FZz5V+FLGpA5N7GJbKflCEVnUxeX8xZqCHCIXN0KTfleyAOQhyQgm1J8kyZpAR4/b832/h1hEpUWHyI0OL1iDqZdW9AWnLsJ9A43o7Jq3L6le0owCSj87oIDO/fFq8jFgJ1uMmNBfznHiSkbjZNgRoJi20Z5gTMVdHoMt99VqJetUyVrRm0aeGzfL7yu5O2AzA+6YQlrFzpBgC40OmqV4jf2fp4zq3IYoE/mftuDKhvwPE3aWeGPpx/J0fqlWCvJPWC01rvX04/V+lPTdC/LgCaZSUsmeeFmzyuFWuCym0JtvxYQ==
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by VE1PR04MB7229.eurprd04.prod.outlook.com (2603:10a6:800:1a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 14 Aug
 2025 05:54:54 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::d507:6a35:df73:f6c]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::d507:6a35:df73:f6c%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 05:54:54 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: imx6: Enable the vpcie regulator when fetch it
Thread-Topic: [PATCH v2] PCI: imx6: Enable the vpcie regulator when fetch it
Thread-Index: AQHb4OuAs40gujNM2U+N9LYLz0oUoLRflquAgAJlavA=
Date: Thu, 14 Aug 2025 05:54:54 +0000
Message-ID:
 <DU2PR04MB8840BC4FB0436EB03B2C56338C35A@DU2PR04MB8840.eurprd04.prod.outlook.com>
References: <20250619072438.125921-1-hongxing.zhu@nxp.com>
 <zl6ie74kyeen2oudt3l2hv6ba5fwjsuiqlpdgaao5l7al7zjwu@bsj3agyukypn>
In-Reply-To: <zl6ie74kyeen2oudt3l2hv6ba5fwjsuiqlpdgaao5l7al7zjwu@bsj3agyukypn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8840:EE_|VE1PR04MB7229:EE_
x-ms-office365-filtering-correlation-id: 91642de2-d960-4774-8aae-08dddaf717c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZkVIUTkvTHh3QllHMDMxbEZFRjFaeGY5R0crN2NCQXJvUEs3T0hVWlI2VzBH?=
 =?utf-8?B?enBWcURDNDlJLzF1OTl2bW94U1hMY3BlRkFyd3NpVEFOVHF6KzY3V0tHa21y?=
 =?utf-8?B?NzFhZTNZNEdVZmNUV2FJVXg2TkhCOFl6eng0eC9UMXo2NTVPL0tFSmRRRU81?=
 =?utf-8?B?VjFQeUVvdUxlL1VuRVNOaFlER1IwSi9qckJndkxTTWh5TldzUTFZN2NGMy9v?=
 =?utf-8?B?QUx1MncvMnFtdkQ5VEVJWjVXaTJWOG8yNGhyTU41ck9rRUJyczdVTnprdHYx?=
 =?utf-8?B?TUFQaDRQclpUVm9kMkZjcW90OFV1OTl1VXl3MjhQcytJSmNna01EVGpIUW9k?=
 =?utf-8?B?YkFpbXQyQnU4RlhVa1p5R2QzcEoxRnpqS3MxRzA5VC9pTk01R3ByQ1AwQ3ZO?=
 =?utf-8?B?K1VPc3lkV2hkQ1F1dDFyTWZ3T3BWUEdTN2ZacTJ2dmVZQVNwVmMrL1p2TEhD?=
 =?utf-8?B?TDlRSzl1cllxZndwdjhtYkNKQmFQVElIbjZWcHl3L2dGNjg0dU5UTHVBaGgw?=
 =?utf-8?B?R2RpdGtJVXJBR1VSdjBKUDlKVllOMTZkMW5QcGM1RjM4K0ptVmJBT2o0WXBj?=
 =?utf-8?B?Q1NOMXd5K2hTbFdzb0d3a01UZm9zbk1va0hPdTYyMVlzMHdNK0R2Q1dZTE1z?=
 =?utf-8?B?WFRzaTlqZFR5bnlrZklTSTA1NVJVNEcxdHFEQmo2clNyOHNOVkZ5UHMrWEh4?=
 =?utf-8?B?SjkwaGIxYXh3dytJb0JoWlhmSXZZMzRYMmtDM0tLN0p0WjRCblljMkkxWERY?=
 =?utf-8?B?bXRrZFVodGNlWG5FWW5EZ0htLzdPOUlIYS9wQTFOOHpDOEF3aVJPREloTGhU?=
 =?utf-8?B?bG50UCt4RnpaYTc5SjlTbnVXazk2VENPQ1VYZzNqSWhWMVJENHNsVi90VUtX?=
 =?utf-8?B?ZGNhZUpHbnMzWDFuN1FINXV6U0t0K1hvSXJoL2VjbGpEQkhMeTdFWUlrYWEw?=
 =?utf-8?B?NXJQRWtKZ1ZUcVJNSksvR2MwM21hK1k2azJOa3VSc0VrMCtReE84enpPR0F0?=
 =?utf-8?B?dWxQd0J3eHpnVWR2VmlBSUhna00za0hjRlBmV0VTRk1La0kxdmEwemYrcHIz?=
 =?utf-8?B?eHZMZ2FRakc5cnJ1YlZ4bk5vSG9jd1VHZ2JLdVJSMmhPMVJuNkhNbjNqWTAv?=
 =?utf-8?B?dEhUOUt6czN1WEtwam9CQ3hiY1d1M0VMdGFXNE9iWnh0Ykpkb1BvaXFxYmw3?=
 =?utf-8?B?cGg4T3Fpb2xDWkVKWGFGOHFtUzlhVDVDOWxaVk12WnB3WHRtUG84WlhqWmRq?=
 =?utf-8?B?dTRGWkZHS3VwbUN0TElmY1p4VExBVGgvTkY5aHVGQlJmV1kreGNOTzFtb2pv?=
 =?utf-8?B?a3psT2UzazU2azVhalRPV3BMMVVsVTd6dWVGL0RoSTJKVHE0dTFNcnEwOXJs?=
 =?utf-8?B?bmxCVHhtOStRQU1zb3d0Sy96MVJQbzRCV2wrY2FtVCswYmFwWE5PVUlDL0hZ?=
 =?utf-8?B?ZmRVMW5FbkJTNUl6TlJmZEo1a3BBQUtSUTFiZ0ZCVWdGUGs5QjRQOFZ3cDN0?=
 =?utf-8?B?dGpmaERpZm1ZeUVIOE53dVIwMjMwazBWNlY3Z3paRHVqb1NpWnBTRktmNGhX?=
 =?utf-8?B?STBzLzJRT0RGRUUzdjhGRUFUL2poNlI1Z1N1YWQvWUdITVZJRExqS3FXTFYv?=
 =?utf-8?B?emV0b0xHSE1MSlM0TndUNVhKeWYrdjJ5Mmp1bDJHakI0VFQxU3RsU3p4a0lp?=
 =?utf-8?B?OEJYU1FITXM3YXkyWWl1SWZPdHFCa3NVVDBKY1ZJRkZ3akIzTU0zUTc0RGlH?=
 =?utf-8?B?UmZQZVFWc0dOY3oxcThmeCt3eVNQYmExMlpkL1Z1bVJ4QzNGWGROdGprdzZJ?=
 =?utf-8?B?ZHpwcHhDakVEQXA0MHFmS2JRTG4yK01mUmh3V3ZGOXJSR0diakVuN203OXVH?=
 =?utf-8?B?UHcwQTg3MlR6b3lKUW5lVWp4bC8xbG1vc2UzVGZlTlBFNEd3M0p0WURQY1dG?=
 =?utf-8?B?d3VOaldXUXVjNHBiRVFSSXRKc0oyNnBZY29WVXdDRU5nNkZOcWdyVFN2T09F?=
 =?utf-8?B?TWJaSWxBSVJBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUE4bVdqY29lWUNmdk9EaHZ3bnJMRFdyL1ZmZlphZnpMZ2V2YWcxSkgzalNk?=
 =?utf-8?B?VE54MzZVV3NITVhQNUdmOWZNSk1ILyt6WWMwM3FFQms2TjR3TmlwRlRDSkpM?=
 =?utf-8?B?NFM2MVZ4TVJCeUlmelRpWEtBUVcxZEhHdzU1Zjl0QTZpdHlqTGZacldvRjkv?=
 =?utf-8?B?SUsrKzBNMGpVVjA4akNZWCsvSFdVUjRIeVJyOUdnblI5dkQwZUJJM212QXds?=
 =?utf-8?B?UVpOTHNiNTZFZHhpbFhrWVhIRmJGbzcyS2l4RXNDK2pBcTJScE94NS9DU2hv?=
 =?utf-8?B?UGRnM3ZWeVpjc3ZYaWJNKytkRzhtR3RXSnZaUXgzdHBlWkNIWTlrMk1pNDRq?=
 =?utf-8?B?YXR0QUcveGFhcTAyV29QQ0RsRHFRQ3FucGlUQUxwWFRxbXU2clFLN1JDdTh4?=
 =?utf-8?B?UWkwSitCVnRiMUQwZkFDTFFaaHFrbUh5dUZXVG82bWNpelFSK0tGTG5KaXU1?=
 =?utf-8?B?SnI2YUovS2YvcW9FS0pwVTRBa2dKTkFJckZzU1FXSWpLSGFhZ095UFZPZUFO?=
 =?utf-8?B?UjBzcW1WQ1hPbDBuemVjM3U5NEhBTkJlT1QrYjVaS2VIdFhwRkV2MFkzRFFa?=
 =?utf-8?B?WEtyZjM1V0hOR0ZUM0tqbWY5eFZoT010bVZQeGpUaWY4Y3RjbU5Tb0F6dkRr?=
 =?utf-8?B?WCszZk1BWWJkcVN1bk45Z2hjMEFCNGxtZEd6VXNKQXJVT3BNK2pqOWZqU0Vh?=
 =?utf-8?B?eWE2WmlvcDQybzNUa2hFVG9GNW1RenVMZG02L1VFUUpHN3pHdVZjczM0MXNY?=
 =?utf-8?B?SzllOWZ4MElKN2VSM2FjVC9mRm15V0diV2ZkRElLSkg3Um1qeXNNa2k5RVJN?=
 =?utf-8?B?dmhrelVyb1RxK3R0WjM1QUhnQ0xEVVR5alI5OGNLWjlDN1dzTzF0MWM4cmFT?=
 =?utf-8?B?QU0xZ0hvZFcvbld5OGRCMkFkQ1pVUVRqN202ZXZUYzNIdFlTd3pIWnZKVERM?=
 =?utf-8?B?TWJCSXpYa2h4WFZJZHBIdWFEbE9RWDRPZkFOYVprL2lsTlVQalljVU5uOER0?=
 =?utf-8?B?TGtrY1NGY0s3Q2Fta1ArNGhoTTgrZXVXdEoxcW9HNlQrSmVBQXlJZk5rcEhW?=
 =?utf-8?B?S1NyQ0lZRGFkb3FqTlRNZUg1QkNRMlE3S0l1aThQTDdDZjZrZUxMR3YwV3hE?=
 =?utf-8?B?WGtjTGxNUEd3Vy9WcUtYYkZLeTJhNlJ3bEwrNXBBTEVzVmtxUkhyUnp1STND?=
 =?utf-8?B?aHJsT3puSytzSGdLdnBoTkFkRTZqV2xpZEdwUHFaR1k5VWZGQ3hYZnMvM3V6?=
 =?utf-8?B?L1dLa1pEbmFRc3VLMTltUm01QVNjMWVRVVY4ZjMwYTBpY203MXJHMFpVZEVn?=
 =?utf-8?B?ZmJJcFdZT09iNTR1VEVvNzVnTStQUlN6eGJrRjZMcm5Zd0x1d0dHWC9qZWlT?=
 =?utf-8?B?NEtqUUNPSExERWYwRFZ6K1ZsNkM0bjBTQW82TkJyZ3R3bEFjNCt2YkpOZlJY?=
 =?utf-8?B?YWdFU3pUSHVqNXM0T094dVZvalJrWHdyL09kaFJOZG91N1lpc2VjcytQWm8v?=
 =?utf-8?B?RVhmQmhUaDdVTEpuL1FmUTVqU2dWb2lvSkVySWNMMzlwNWVNY3MyZkJraDlm?=
 =?utf-8?B?TE05YmV6SThrYUpobVdJaVBqSjFvYXU5bWNMQStwUDMvS0NpdFVwMnRLcnk4?=
 =?utf-8?B?VitUUWU3QzB0VnVKTHk4dmVpVHE0cURtUUNUeDJlcmNUbU1ONzdUWWg2OHF6?=
 =?utf-8?B?cnZpRkwxNllrNFpnait0QUVJQjBKMkxZZXg2OHBDdmY5MzdsS3FjMWgrTGh4?=
 =?utf-8?B?dUJGTDFYQTBkOXNxT3YxenFJZU4vN29JQS9VUHZtQm11UnJrVkdnYzhjNGV0?=
 =?utf-8?B?NVhSVStFaE1EVURKZW5QZTVPTmRIV2lIN3FUcUtYTTdkaE5TTHY4NlVsNlBB?=
 =?utf-8?B?SVN2YXcvcUd5MGxMSjg4cTVtVDl2LzhTWnNDcTNVWDdRUndESXZseHZmSy9Q?=
 =?utf-8?B?dWIwU0s1Z2t1OXhwaUFSNzlBWURiVmQ2ZE9zaHFsNUdOUjN4M21TVTlKNXN0?=
 =?utf-8?B?SGVqaHVhb3JQMkJoTHcraG1uck5oNmtrQXdqbWhIajVFL2l0MksranlpUHd1?=
 =?utf-8?B?NkRHZmxSMHk1eDZKYW83Q2lNN3hiTmozMjMvVW5XSWpzVzdmRHJrOTRrSmdv?=
 =?utf-8?Q?QgLU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91642de2-d960-4774-8aae-08dddaf717c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 05:54:54.6289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJm/Km8eB91yduIy5Bl50jxbCRX3NiXoAz7MfFgSOn23F454Sa1kwPBnAQVm3CHzxozn9tCLVbVDxoN4CFDRGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7229

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNeW5tDjmnIgxM+aXpSAxOjEyDQo+IFRv
OiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogRnJhbmsgTGkgPGZy
YW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiBscGllcmFsaXNpQGtl
cm5lbC5vcmc7IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj4gYmhl
bGdhYXNAZ29vZ2xlLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25p
eC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBQQ0k6IGlteDY6IEVuYWJsZSB0aGUgdnBjaWUg
cmVndWxhdG9yIHdoZW4gZmV0Y2ggaXQNCj4gDQo+IE9uIFRodSwgSnVuIDE5LCAyMDI1IGF0IDAz
OjI0OjM4UE0gR01ULCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBFbmFibGUgdGhlIHZwY2llIHJl
Z3VsYXRvciBhdCBwcm9iZSB0aW1lIGFuZCBrZWVwIGl0IGVuYWJsZWQgZm9yIHRoZQ0KPiA+IGVu
dGlyZSBQQ0llIGNvbnRyb2xsZXIgbGlmZWN5Y2xlLiBUaGlzIGVuc3VyZXMgc3VwcG9ydCBmb3Ig
b3V0Ym91bmQNCj4gPiB3YWtlLXVwIG1lY2hhbmlzbSBzdWNoIGFzIFdBS0UjIHNpZ25hbGluZy4N
Cj4gDQo+IEknbSBub3Qgc3VyZSBhYm91dCB0aGlzIHBhcnQuIEZvciBzdXBwb3J0aW5nIFdBS0Uj
LCBWYXV4IHN1cHBseSBoYXMgdG8gYmUNCj4gc3VwcGxpZWQgdG8gdGhlIGVuZHBvaW50LiBCdXQg
aGVyZSwgJ3ZwY2llJyBsb29rcyBsaWtlIHRoZSBtYWluIDMuM1Ygc3VwcGx5Lg0KPiBTbyBrZWVw
aW5nIGl0IGFsd2F5cyBvbiB0byBzdXBwb3J0IFdBS0UjLCBzb3VuZHMgdG8gbWUgdGhhdCB0aGUN
Cj4gY29tcG9uZW50IG5ldmVyIGVudGVycyB0aGUgRDNDb2xkIHN0YXRlLiBTbyBubyBXQUtFIyBp
cyByZXF1aXJlZC4NCkhpIE1hbmk6DQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuIFlvdSdyZSBy
aWdodC4NCkFub3RoZXIgKzMuM1ZhdXggc2hvdWxkIGJlIGFkZGVkIHRvIHBvd2VyIHVwIHRoZSBX
QUtFIyBjaXJjdWl0Lg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiAtIE1hbmkN
Cj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54
cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2
LmMgfCAyNw0KPiA+ICsrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggNWEzOGNmYWY5ODliLi43
Y2FiNGJjZmFlNTYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2
LmMNCj4gPiBAQCAtMTU5LDcgKzE1OSw2IEBAIHN0cnVjdCBpbXhfcGNpZSB7DQo+ID4gIAl1MzIJ
CQl0eF9kZWVtcGhfZ2VuMl82ZGI7DQo+ID4gIAl1MzIJCQl0eF9zd2luZ19mdWxsOw0KPiA+ICAJ
dTMyCQkJdHhfc3dpbmdfbG93Ow0KPiA+IC0Jc3RydWN0IHJlZ3VsYXRvcgkqdnBjaWU7DQo+ID4g
IAlzdHJ1Y3QgcmVndWxhdG9yCSp2cGg7DQo+ID4gIAl2b2lkIF9faW9tZW0JCSpwaHlfYmFzZTsN
Cj4gPg0KPiA+IEBAIC0xMTk4LDE1ICsxMTk3LDYgQEAgc3RhdGljIGludCBpbXhfcGNpZV9ob3N0
X2luaXQoc3RydWN0IGR3X3BjaWVfcnANCj4gKnBwKQ0KPiA+ICAJc3RydWN0IGlteF9wY2llICpp
bXhfcGNpZSA9IHRvX2lteF9wY2llKHBjaSk7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+DQo+ID4gLQlp
ZiAoaW14X3BjaWUtPnZwY2llKSB7DQo+ID4gLQkJcmV0ID0gcmVndWxhdG9yX2VuYWJsZShpbXhf
cGNpZS0+dnBjaWUpOw0KPiA+IC0JCWlmIChyZXQpIHsNCj4gPiAtCQkJZGV2X2VycihkZXYsICJm
YWlsZWQgdG8gZW5hYmxlIHZwY2llIHJlZ3VsYXRvcjogJWRcbiIsDQo+ID4gLQkJCQlyZXQpOw0K
PiA+IC0JCQlyZXR1cm4gcmV0Ow0KPiA+IC0JCX0NCj4gPiAtCX0NCj4gPiAtDQo+ID4gIAlpZiAo
cHAtPmJyaWRnZSAmJiBpbXhfY2hlY2tfZmxhZyhpbXhfcGNpZSwgSU1YX1BDSUVfRkxBR19IQVNf
TFVUKSkgew0KPiA+ICAJCXBwLT5icmlkZ2UtPmVuYWJsZV9kZXZpY2UgPSBpbXhfcGNpZV9lbmFi
bGVfZGV2aWNlOw0KPiA+ICAJCXBwLT5icmlkZ2UtPmRpc2FibGVfZGV2aWNlID0gaW14X3BjaWVf
ZGlzYWJsZV9kZXZpY2U7IEBAIC0xMjIyLDcNCj4gPiArMTIxMiw3IEBAIHN0YXRpYyBpbnQgaW14
X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBkd19wY2llX3JwICpwcCkNCj4gPiAgCXJldCA9IGlteF9w
Y2llX2Nsa19lbmFibGUoaW14X3BjaWUpOw0KPiA+ICAJaWYgKHJldCkgew0KPiA+ICAJCWRldl9l
cnIoZGV2LCAidW5hYmxlIHRvIGVuYWJsZSBwY2llIGNsb2NrczogJWRcbiIsIHJldCk7DQo+ID4g
LQkJZ290byBlcnJfcmVnX2Rpc2FibGU7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiAgCX0NCj4g
Pg0KPiA+ICAJaWYgKGlteF9wY2llLT5waHkpIHsNCj4gPiBAQCAtMTI2OSw5ICsxMjU5LDYgQEAg
c3RhdGljIGludCBpbXhfcGNpZV9ob3N0X2luaXQoc3RydWN0IGR3X3BjaWVfcnANCj4gKnBwKQ0K
PiA+ICAJcGh5X2V4aXQoaW14X3BjaWUtPnBoeSk7DQo+ID4gIGVycl9jbGtfZGlzYWJsZToNCj4g
PiAgCWlteF9wY2llX2Nsa19kaXNhYmxlKGlteF9wY2llKTsNCj4gPiAtZXJyX3JlZ19kaXNhYmxl
Og0KPiA+IC0JaWYgKGlteF9wY2llLT52cGNpZSkNCj4gPiAtCQlyZWd1bGF0b3JfZGlzYWJsZShp
bXhfcGNpZS0+dnBjaWUpOw0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+DQo+ID4gQEAg
LTEyODYsOSArMTI3Myw2IEBAIHN0YXRpYyB2b2lkIGlteF9wY2llX2hvc3RfZXhpdChzdHJ1Y3Qg
ZHdfcGNpZV9ycA0KPiAqcHApDQo+ID4gIAkJcGh5X2V4aXQoaW14X3BjaWUtPnBoeSk7DQo+ID4g
IAl9DQo+ID4gIAlpbXhfcGNpZV9jbGtfZGlzYWJsZShpbXhfcGNpZSk7DQo+ID4gLQ0KPiA+IC0J
aWYgKGlteF9wY2llLT52cGNpZSkNCj4gPiAtCQlyZWd1bGF0b3JfZGlzYWJsZShpbXhfcGNpZS0+
dnBjaWUpOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIHZvaWQgaW14X3BjaWVfaG9zdF9wb3N0
X2luaXQoc3RydWN0IGR3X3BjaWVfcnAgKnBwKSBAQA0KPiA+IC0xNzM5LDEyICsxNzIzLDkgQEAg
c3RhdGljIGludCBpbXhfcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2
KQ0KPiA+ICAJcGNpLT5tYXhfbGlua19zcGVlZCA9IDE7DQo+ID4gIAlvZl9wcm9wZXJ0eV9yZWFk
X3UzMihub2RlLCAiZnNsLG1heC1saW5rLXNwZWVkIiwNCj4gPiAmcGNpLT5tYXhfbGlua19zcGVl
ZCk7DQo+ID4NCj4gPiAtCWlteF9wY2llLT52cGNpZSA9IGRldm1fcmVndWxhdG9yX2dldF9vcHRp
b25hbCgmcGRldi0+ZGV2LCAidnBjaWUiKTsNCj4gPiAtCWlmIChJU19FUlIoaW14X3BjaWUtPnZw
Y2llKSkgew0KPiA+IC0JCWlmIChQVFJfRVJSKGlteF9wY2llLT52cGNpZSkgIT0gLUVOT0RFVikN
Cj4gPiAtCQkJcmV0dXJuIFBUUl9FUlIoaW14X3BjaWUtPnZwY2llKTsNCj4gPiAtCQlpbXhfcGNp
ZS0+dnBjaWUgPSBOVUxMOw0KPiA+IC0JfQ0KPiA+ICsJcmV0ID0gZGV2bV9yZWd1bGF0b3JfZ2V0
X2VuYWJsZV9vcHRpb25hbCgmcGRldi0+ZGV2LCAidnBjaWUiKTsNCj4gPiArCWlmIChyZXQgPCAw
ICYmIHJldCAhPSAtRU5PREVWKQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0
LCAiZmFpbGVkIHRvIGVuYWJsZSB2cGNpZSIpOw0KPiA+DQo+ID4gIAlpbXhfcGNpZS0+dnBoID0g
ZGV2bV9yZWd1bGF0b3JfZ2V0X29wdGlvbmFsKCZwZGV2LT5kZXYsICJ2cGgiKTsNCj4gPiAgCWlm
IChJU19FUlIoaW14X3BjaWUtPnZwaCkpIHsNCj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQo+IA0K
PiAtLQ0KPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u
4K+NDQo=


Return-Path: <linux-pci+bounces-14834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B73DD9A31F1
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 03:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3128CB223C9
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 01:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8945478E;
	Fri, 18 Oct 2024 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a/V3hKcf"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2068.outbound.protection.outlook.com [40.107.249.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE483BB48;
	Fri, 18 Oct 2024 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214461; cv=fail; b=hZ1epw5ngfgixhxcNdMttJIn7y/MdbanrhMqakFYgsTKMdwrWkzmenf3uDJw0SQjXCVt545/w0JrCmmi8Nm3vd3fp/v/5KhHtg53D4l0ansg5T94OAumYEFiMMbO1WqXI/0oKUQBnCTP6g6wtstbf7oq6+LHPYZOGZ+LMTqzLgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214461; c=relaxed/simple;
	bh=+hQyNj8qNKeIXp8E9LpN5APD+/MUkqHbTmH+bQ77xLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fB2XrfB7caSgfp6e1Mk+Pxs6x9ymC9+haWkbiz7dsCe9HXOKRbFDJBwrxVikjfpIM+mSxKB89Pe4nm3fCY3oEVv4/sb9b8380UO3SD9TsjyZWIsMcb39pLh/u0dSeHZcDnKIaePsQADdEJraZYQPerTmaTbXT/htfknt+vYyqbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a/V3hKcf; arc=fail smtp.client-ip=40.107.249.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSTqA+jP6D0VaSdKoIVkQnl3ecedtsGqN+adPz0bXG/UrAn2sLC+B2CK0RHZQL9/8ds8gdSZ/HezHnBaDiebQtbkrPfrFMKKV3maTLeV0q/Tk+T8WGqM8e4/GttearGyB2qZZOjcNBBzvaZJ6zIVNNOTySFP/jrAWr9l9kDg9k4sD5dz5BjnzGLBAmcZpSuuYhITJD4duplOJ6oEbYcqKPBzDBZJZT9nkVjB5wd4YLkbm5Q74+DoG6XgZeusgSHhgQHV53db8HnwsPUUN6O8cWUN7uarKio1cJPTxEXSGbQifCvPmWQBulDEMaOSsGlFvVt8WRBUJpaRbh4zPysOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hQyNj8qNKeIXp8E9LpN5APD+/MUkqHbTmH+bQ77xLY=;
 b=SzjGXSZdPEqb9GcjiylSYJJJAemqoZhtrnJgVUW+iK1i84PNATgTWTxeK0ncIoB8F6AAf7KTs8grnIeoYtCdRW8ixqJhbLd72NUHKCmDOKLzy4HJgktcruDEcWl6z9KhHRGwpBO5VcK3f1ASyPLsWBmohGemcQIWqY2HsLdZT6IosCx4nUZFSjuIieXCB9TnXd8p663G6Ju3oCHRARlViivIofAsjHpsTvRfaWpxeH+j1w/UZyijGFA8gMa8HNey+22LJ2pBgIV2ef+bna8zXWEbABvH37A7lHpq8xKKyr6huWmNR4DshdlMbMk/VinP6BH0pTdDJuUyKzORTVd3GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hQyNj8qNKeIXp8E9LpN5APD+/MUkqHbTmH+bQ77xLY=;
 b=a/V3hKcfGfbMwhGjYnwCCiIKA2Ujpg2Dh6ugdpi0/45hOpyVIG6tPl4O7SpH/d1+15ogr2eD5N4sTopCJpPwSy1g0KiQ7aamRcyuloCqqq50U3QWVuQJigdY1Mc3IBgG4tzhNjiEITegIA5orMDvVCbdUQj5TwaK3PImc88431ItdoO4gFHtD7Ou/2O3Iy/rLlzqAKthF/O68eT6mGFLkjPBalRaSQNdTP0edySrsJ/Ebn8rkrqJ0BKh6oAVyBzlkbXACZqhy9NEAmaS8+F68//plrDyfstnU0QMUU07AzXDb5btzDKNNE4RofTFuwHrmyRVtyvs7EfE3yfFNxnEVQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8935.eurprd04.prod.outlook.com (2603:10a6:10:2e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 01:20:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 01:20:56 +0000
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
Subject: RE: [PATCH v3 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Topic: [PATCH v3 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Index: AQHbIGrTTA2gJ/XR3Uu/G3eAF75QCLKLINqAgACVsjA=
Date: Fri, 18 Oct 2024 01:20:55 +0000
Message-ID:
 <PAXPR04MB851058F40F264FA9D20F385888402@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-3-wei.fang@nxp.com>
 <ZxE56eMyN791RsgK@lizhi-Precision-Tower-5810>
In-Reply-To: <ZxE56eMyN791RsgK@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8935:EE_
x-ms-office365-filtering-correlation-id: 1ccfec1f-e2bf-4b0d-1f31-08dcef131dbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?U0lhZDkzRy81VlNhSFFFYlJpbzk3STI1WGNLTFYrRHYrTjZCUVVqV01MMnVV?=
 =?gb2312?B?U295Nm5IZlB0bFlmL0o3SXF6VUMyMXNScE1ncHRBTG5xWFZNeTc3ajk0YTdI?=
 =?gb2312?B?Y01nRTNKcGljaEJnYTltZ1lZVnZ4VnprOTdkU2crODFoQVY5Mm9SQ3VCS3dS?=
 =?gb2312?B?bEpPd2Zob0Q4eVRGa0xLMGZMVnlocWY3N2lNUHN4OUltaFowcHRSRW9DRWQ2?=
 =?gb2312?B?WEFSS3crT2ZTSFR2VnV4dnhITG5zdU4rMUVkRlEzNnh6OTlBT1JkMXIxejZZ?=
 =?gb2312?B?RENUUFp1VmYrNGgrTnJXNXlxWkRaVjZjd3FXMGJzdkIzK1duWWloZldPb0lG?=
 =?gb2312?B?aFBzSDlETm5sbzhzaSs2dFZjejlFS1hwL1hhQTFJTE1tbnp3NjdhVUh0a3By?=
 =?gb2312?B?WkFUN3lVT0w0b09NbEFabFByQnI3bEVVbDk3NG1tNFJxTWdId0xZajFoNXNO?=
 =?gb2312?B?dUsxRE9Ec1RCRWFIbzhFaVdaVWRlSTdBZ2pDelE5Zkhjd1dQOVpNNWxMNVcw?=
 =?gb2312?B?aHZmZzh4Y0J0bm1CaWhNRkxQSU56UjdkQjJYcDRSc0czYXlDWGtnTWVDb1Mx?=
 =?gb2312?B?VGNDTnVrK0VmZXZvZGo1R1lpN3B3QkhiY1hVdXNFblo3T3ZaNGhjUlRCNGFz?=
 =?gb2312?B?S2xMTTBxWVlYR0tUdldVL3pudGhnd0s2V2xtMllMdi9meW1DUUZlQmRKZ2lC?=
 =?gb2312?B?OEVmNTQrT1BSYUVGTmFYRWRlYWZHNmNlYXpDaXNsS25FRmR4NFQ5UkY3aytG?=
 =?gb2312?B?cm1sclNqTVhJdmJaVDkvMVE2eDRicjh6MGpqNzBOQXpGSm5PN1VBTEVqendj?=
 =?gb2312?B?NjVJSEVSeUlIYWdER2RZQXVOY3g4aVlnLzhieGhNOFZTb0tMSWIxMWZtRUR5?=
 =?gb2312?B?Q3lCdVlnSVphbmRZT1MxTkJBdG9VNS9TelpwaXBrWXhWcEk5bXBtMGZrWVRO?=
 =?gb2312?B?cGtkQ2VKL0xaMXc0UXdtaUZFYkg5NXQvT3YxWUtma3I0YXgveU1WcUtrVGhU?=
 =?gb2312?B?MkJxMnlwWm84Nk5uNllDZ3hjT3BMVXF1T1ZkUFdTVFRCZVk2TFVabkc0bmtS?=
 =?gb2312?B?Nnp5ZjlGUVl4dGR3ZkhmMWFXUVg1cVVDR2NCRkE4c3VVRHJ2ak5qY0Y4dlpL?=
 =?gb2312?B?RDRaNExsb1NtWDNrdGo4OGo5TEwzdC9CNHFyZXQ4YVlCczJ3UVZPdVQzYW1s?=
 =?gb2312?B?eHFXTHcvK0lBa2JSZEJJVjZZdnFpMnRSamE3ODBRTGErZHlsVGJPM2JqNFRv?=
 =?gb2312?B?TE1yb3kxcThTL0dmTkxFRmJBYlptMnFhSXJGSG1zaU1BeXhKUDZVc29Oamt0?=
 =?gb2312?B?TW9mTXdLRjlIaEtkNlpZUmVtQlFIS01QRDA5M0VHNmRUUjMzVUZLM0hkSHBK?=
 =?gb2312?B?OHdXcHIwT3VPVkcrNlZuNE0xdGtZU3NVRitQbGxJRWZmQXdSUUNuc1JaRjVu?=
 =?gb2312?B?ZWJNTkVHMTVIREFKVWpoSGE2eFpKM1FxenVFOXJkMUJWa2puaFE1VUUrd3FW?=
 =?gb2312?B?QnI3cTRlOTBkQVpGdXdtQUtCRTc4Q3MxQndOQVlqY2VoNG05R2NHMDBBeEwz?=
 =?gb2312?B?STdwVmQ3bmpENkcycEZpOGUybkQ2cFpyeFdzUGxjNGg5K05HUEwwYTlnTlNm?=
 =?gb2312?B?UWJDVXNZdGh6azVyaGlKM0xHZXhZNnpXVkRzNDJvTHEyT0FaUVhLTXEzK0da?=
 =?gb2312?B?bHM5K0ovM1JjTHZweTF5RzU1MHIwbndQYnduakR5QzBac3J2bnQ0Q1RpeFhk?=
 =?gb2312?B?ZitHWklnTXd0a2MxVnVuUVFnQmZEMFk4c1BNK3NaWVR4RHZPNlV4ZXg0WlE4?=
 =?gb2312?Q?ZWNtzX0pdDhj1uLP6uVxkkj4Ynu56l83MckVY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WmlXcDFRNThTRFk2TlFJSjZrQUpoRCthQnQ5NlZoYmdjOGZMQ2ZxSkFZa2p3?=
 =?gb2312?B?R2IyNVNtdjA2QjlmSm1nWWFTM3MwYnZzRU1iMTc3TjZtQjIyM1cvTktYcCs5?=
 =?gb2312?B?Ly9nWmpUc21YN0oxQUhHVEEzeERaNWs4M0hoV3Z3R1ZqQU1qeTdJeTR1RlBX?=
 =?gb2312?B?ZndPdnlIQWtqTStFYzl6UHo1NzVPT3V2STJtREdZdFpJckdIUFA1VG92VmZs?=
 =?gb2312?B?NG82ZVJFQmJJZFR3UTNyOExZLzRxaGtUYldnQlFtOEdxendSQkJFUTZ5Rk5k?=
 =?gb2312?B?eGlOWTlSZ0xrVmVzd2gzU1FUZ1JSNnI3VUxENDZ4YitUenByQWNIc2JtS0dS?=
 =?gb2312?B?Z3hUK2cvR3BkZkgzRlJmdE80ZlRveWtZN0NIQllXY1NoeURRTFlGa3JpWExt?=
 =?gb2312?B?U3R2bjVYbzFqZkxiVEhlb1QvaFVIMXFLVU1tZUM1Y3hFOUdJNzhzWDViNWJv?=
 =?gb2312?B?b1RwUU5rTHRWbFNncElwL215MEV5NTZXaFh5U01nUnhGcTBIVnBNL3dQSCtH?=
 =?gb2312?B?Mm16ekxSSE0vMEhlWUQ3UXdTN3JyVkZtVXlBQjlDTlhkRDVtT01HZldiOUgy?=
 =?gb2312?B?V253Ym1PQU94d0hzZDRjQWsyRGdqendxenNOMjZ1Wk9qSS9wS3RSR0g1S0ll?=
 =?gb2312?B?aXZaYlArZDIzaXJiV0FTT0gweGt5NlY1VmRsVUl2N1MzNzlnYUl3OUxqcEVO?=
 =?gb2312?B?UnEvdmVRazhDVElxL1VReVBqaEcxWUVPKzI2dk5mVnVMVGhRZ2NaOHNJS3Aw?=
 =?gb2312?B?bHd4bUV6WlhxR1NTUk44T3ZLVHhXQmxEaXRzems3SlM2ZlcyaGhkdHFMOVJQ?=
 =?gb2312?B?b3hkcmhsaVprZDNEcCs4cG5YamRQMGI2cGRpS3A4MVk3d0tTMFo2dVp6NGxD?=
 =?gb2312?B?azA0MkNub09OdkNlRHNTbW1PV2RmYXdkRVk5TjVjc2dZY1FRT01jNnhpdW1H?=
 =?gb2312?B?V1ZNcFlyeGpLbDMwUTA1THNDVFR3VThXQUowejdCcnhyeE5HcDhJOVI2YWVG?=
 =?gb2312?B?NksyMFkwQnJPbFhNWUthLzRLME1rQTBITVc5YkpxeDl5RVhpRUE0MXA2TjM3?=
 =?gb2312?B?dzVxUnluV3Q1YVZYWmI3YnhhNXV3aVE3VkxtZmRvRTlCbHl3MlczekswelM2?=
 =?gb2312?B?MTVZV0MwY05naWdOd3RnVzJYSVVoRkR5UXY1ZzZsNTNWOThrSXR4RGNUbUpk?=
 =?gb2312?B?bXd0TTBPWlFhSWlDUWFmMmU5OUNFeXl4d1Nzd3dReUlvMFBiUitJVExYNldO?=
 =?gb2312?B?VzNRZHRpUVBHUjVvTmNKQzlQZVEybnkvL3l5dWFaeWJMdi9kbDFDNnhvQUt3?=
 =?gb2312?B?bERmSm5DN3VqTzI4ckh2eUJLbW9xVng2ZDEzQUNmcU85bFNXTSt0MlpUeGFt?=
 =?gb2312?B?clNDZUs1UDdtMllJNlRzd2hmT1BvbFFTMUwxc0NQQVB5UHljc1ZSNzEyZFJr?=
 =?gb2312?B?TlcxR2xiRmE0eW9vSzUwUEdKS0kyZm5SeVB6RmFGdG03R0Z2bkV4R0h3MklW?=
 =?gb2312?B?ajZGd3pYMlFUMllFWGVyZHNXUTNFNkkyWS90TGNqRmV6RXBXRkMvSlhMcWRC?=
 =?gb2312?B?bTVpaDg4VEdBUy9TNVYweEorZkdwWXhrbEw5RG1ES0FCVzVWUnNJQU10R0lq?=
 =?gb2312?B?Y3hQeXUza0tmLzh0RFZxMzJCNVFWbFlLNnRqVUltM1l1bENkMzA4eEJhSklU?=
 =?gb2312?B?anBUKy9NQzFNb2R3UzNZbThxTkNZM25zMGxsczE0OGF0dTVsTXgvMzdXUDJH?=
 =?gb2312?B?Mys3WWIxVVpoQk45emlPUVo5eXZtOGxOMFozM3VuTlFKSlRSVXR0TFltdW1s?=
 =?gb2312?B?QythVWNBaFNkZWZJWE50TG9zNWkrcFpVRW1QaEQrU2R5QmFkMDdsZE5nY29P?=
 =?gb2312?B?WmJYQUFzKzdMeW5PQlJPcG83OEttYzRWK25BTHg2T2lZakVvOGFxNHVUWXBj?=
 =?gb2312?B?dXVpa08raHROWkF3QjhQMlkrcEUrMTh3bTFPSVpOd25FNlE3UFllOXR3ZzRi?=
 =?gb2312?B?Nld6dVRoejN1QmZsYzF2NzlwZUNYN2ptVGJ4ckR6dE11K1NHVTZOVGpqOUxm?=
 =?gb2312?B?RlNSbnkwbnYrWlR6WERBd3A3d0djb2VneFZ3QW93N09ocVd1MXlneSswckk3?=
 =?gb2312?Q?v4MI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccfec1f-e2bf-4b0d-1f31-08dcef131dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 01:20:56.1917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PN27O0IaAfdNx/a4bp9HBx9rkBHd/JFbM5zUKt9JnEdB6X3XpQc2WTQ4p/ZLTAKLlRhxu6Fv9zoBzYWL6uwDOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8935

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjE4yNUgMDoyMw0KPiBUbzogV2VpIEZhbmcgPHdl
aS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29n
bGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyByb2JoQGtlcm5l
bC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgVmxhZGlt
aXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47IENsYXVkaXUNCj4gTWFub2lsIDxj
bGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29t
PjsNCj4gY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1OyBsaW51eEBhcm1saW51eC5vcmcudWs7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGhvcm1zQGtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51
eC5kZXY7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgbmV0LW5leHQgMDIvMTNdIGR0LWJpbmRp
bmdzOiBuZXQ6IGFkZCBpLk1YOTUgRU5FVEMNCj4gc3VwcG9ydA0KPiANCj4gT24gVGh1LCBPY3Qg
MTcsIDIwMjQgYXQgMDM6NDY6MjZQTSArMDgwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gVGhlIEVO
RVRDIG9mIGkuTVg5NSBoYXMgYmVlbiB1cGdyYWRlZCB0byByZXZpc2lvbiA0LjEsIGFuZCB0aGUg
dmVuZG9yDQo+ID4gSUQgYW5kIGRldmljZSBJRCBoYXZlIGFsc28gY2hhbmdlZCwgc28gYWRkIHRo
ZSBuZXcgY29tcGF0aWJsZSBzdHJpbmdzDQo+ID4gZm9yIGkuTVg5NSBFTkVUQy4gSW4gYWRkaXRp
b24sIGkuTVg5NSBzdXBwb3J0cyBjb25maWd1cmF0aW9uIG9mIFJHTUlJDQo+ID4gb3IgUk1JSSBy
ZWZlcmVuY2UgY2xvY2suDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZh
bmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiB2MjogUmVtb3ZlICJueHAsaW14OTUtZW5ldGMiIGNv
bXBhdGlibGUgc3RyaW5nLg0KPiA+IHYzOg0KPiA+IDEuIEFkZCByZXN0cmljdGlvbiB0byAiY2xj
b2tzIiBhbmQgImNsb2NrLW5hbWVzIiBwcm9wZXJ0aWVzIGFuZCByZW5hbWUNCj4gPiB0aGUgY2xv
Y2ssIGFsc28gcmVtb3ZlIHRoZSBpdGVtcyBmcm9tIHRoZXNlIHR3byBwcm9wZXJ0aWVzLg0KPiA+
IDIuIFJlbW92ZSB1bm5lY2Vzc2FyeSBpdGVtcyBmb3IgInBjaTExMzEsZTEwMSIgY29tcGF0aWJs
ZSBzdHJpbmcuDQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mc2ws
ZW5ldGMueWFtbCAgICB8IDIyICsrKysrKysrKysrKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDE5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mc2wsZW5ldGMueWFtbA0K
PiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mc2wsZW5ldGMueWFt
bA0KPiA+IGluZGV4IGUxNTJjOTM5OThmZS4uZTQxOGMzZTZlNmIxIDEwMDY0NA0KPiA+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZnNsLGVuZXRjLnlhbWwNCj4g
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZzbCxlbmV0Yy55
YW1sDQo+ID4gQEAgLTIwLDEwICsyMCwxMyBAQCBtYWludGFpbmVyczoNCj4gPg0KPiA+ICBwcm9w
ZXJ0aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6DQo+ID4gLSAgICBpdGVtczoNCj4gPiArICAgIG9u
ZU9mOg0KPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBlbnVtOg0KPiA+ICsg
ICAgICAgICAgICAgIC0gcGNpMTk1NyxlMTAwDQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBmc2ws
ZW5ldGMNCj4gPiAgICAgICAgLSBlbnVtOg0KPiA+IC0gICAgICAgICAgLSBwY2kxOTU3LGUxMDAN
Cj4gPiAtICAgICAgLSBjb25zdDogZnNsLGVuZXRjDQo+ID4gKyAgICAgICAgICAtIHBjaTExMzEs
ZTEwMQ0KPiA+DQo+ID4gICAgcmVnOg0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPiBAQCAtNDAs
NiArNDMsMTkgQEAgcmVxdWlyZWQ6DQo+ID4gIGFsbE9mOg0KPiA+ICAgIC0gJHJlZjogL3NjaGVt
YXMvcGNpL3BjaS1kZXZpY2UueWFtbA0KPiA+ICAgIC0gJHJlZjogZXRoZXJuZXQtY29udHJvbGxl
ci55YW1sDQo+ID4gKyAgLSBpZjoNCj4gPiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAg
ICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICAgICAgY29udGFpbnM6DQo+ID4gKyAgICAgICAgICAg
IGVudW06DQo+ID4gKyAgICAgICAgICAgICAgLSBwY2kxMTMxLGUxMDENCj4gPiArICAgIHRoZW46
DQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgY2xvY2tzOg0KPiA+ICsgICAg
ICAgICAgbWF4SXRlbXM6IDENCj4gPiArICAgICAgICAgIGRlc2NyaXB0aW9uOiBNQUMgdHJhbnNt
aXQvcmVjZWl2ZXIgcmVmZXJlbmNlIGNsb2NrDQo+ID4gKyAgICAgICAgY2xvY2stbmFtZXM6DQo+
ID4gKyAgICAgICAgICBjb25zdDogcmVmDQo+IA0KPiBEaWQgeW91IHJ1biBDSEVDS19EVEJTIGZv
ciB5b3VyIGR0cyBmaWxlPyBjbG9ja3NcY2xvY2stbmFtZXMgc2hvdWxkIGJlIHVuZGVyDQo+IHRv
cCAncHJvcGVydGllcyIgZmlyc3RseS4gVGhlbiB1c2UgJ2lmJyByZXN0cmljdCBpdC4gQnV0IEkg
YW0gbm90IHN1cmUgZm9yIHRoYXQuIG9ubHkNCj4gZHRfYmluZGluZ19jaGVjayBpcyBub3QgZW5v
dWdoIGJlY2F1c2UgeW91ciBleGFtcGxlIGhhdmUgbm90IHVzZSBjbG9ja3MgYW5kDQo+IGNsb2st
bmFtZXMuDQo+IA0KDQpJIGhhdmUgcnVuIGR0YnNfY2hlY2sgYW5kIGR0X2JpbmRpbmdfY2hlY2sg
aW4gbXkgbG9jYWwgZW52LiB0aGVyZSB3ZXJlIG5vDQp3YXJuaW5ncyBhbmQgZXJyb3JzLg0KDQo+
IA0KPiA+DQo+ID4gIHVuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4gPg0KPiA+IC0tDQo+
ID4gMi4zNC4xDQo+ID4NCg==


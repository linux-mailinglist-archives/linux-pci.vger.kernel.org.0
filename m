Return-Path: <linux-pci+bounces-14116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB02997A3C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 03:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC14A1F239BE
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 01:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D40C339AB;
	Thu, 10 Oct 2024 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UqFIwvoz"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F481F4EE;
	Thu, 10 Oct 2024 01:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728524577; cv=fail; b=OT4Dbg+ZiEpqVCaGE+wOfKLPWqbmHJawyIB92spWMoZfDw3lsJJVbiyLhI1JWXgCer8BTm9EZmA2eXteSSZz3RuWRI2JsmIWsNVtxi/55DUQB/+kd8tv0zty+iI/jO42dFdAdLmgF5Ud2U3GJcVznuOm3fdicSOnYxCN8usmcY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728524577; c=relaxed/simple;
	bh=BDQu7DyAfzgsQCSPPg1HBj9JirYFddkUwa26wfNhsg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A/Y1KW2cThVHOBu7O2rQeS7myglkqIAVT/QzPzaJJ9267QoLcMjWg6B9hb7GOKjmRe/x/u5+JuZ7YVIoO1gyHSHvbJ7nQRmohJIHibVxGd/iGf2FzqIMKPq433QlYPkwtxKBSKY/BvMeQ/vuCodC8IJ/xm1y9726pE+s5C1QXcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UqFIwvoz; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzAeBMZll0Oxmb9aJOZ3JC3l6prKXMmNXzzcINN3vBfgbxEi2GxviLkgnCH1OwXBcLCkBUHh2USVJAN860MTZ6Jh/Rq1S3zjZFQURvCHqFSKgweQOVoUddGuI6i0aHSf+gBN7BUUfnqlX2e59ydi+tr2gNLJNKwvGKOlyEAnlGM/SsJ26GfPwdQjq/Hnk0PnhX276kQkJQv+/eIGQEMUUZME/5gr0VIkun9burvJgBz2gpojYb+0i7B2L0x+tpL2r1vrbyRQ38T6cbrCszn4RpQsEsIat6ogagrf5s4DDu1DMSt2j83diNOv8hEFtkgyiQbUDLyXqYBNlQxbRGSJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDQu7DyAfzgsQCSPPg1HBj9JirYFddkUwa26wfNhsg8=;
 b=YdNSBkkzk+YnP7x/3/VSoydztkf0z2utqNoUPdv0NIzos/0l/6Fo5LBsQHyCEuKbEb3zZQsuoLQj+ECbpTAU6c7wvNhyP9Wn2jZMMxGHgNu5ZhIZcKGIFcZGGBgk/Kto3iF6JK/FmdCAnz4wySKkOlZwYD4zTbgUVhQWXujHSSVgW0BNcOmDSgA7pAwWjmtsgrWzFEhIpuNx7ff66RokCnweEqgNRSkNxX504tRl5O7eefdNv62T4sHdaAI2lSVxM5ZCJ8zY99+M4uPvNQXO+gUxhHXeciI765VC+42PZK5d9zJtvjG9S8JERzUNavewVFjIEuHGSicNMNaXAV+3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDQu7DyAfzgsQCSPPg1HBj9JirYFddkUwa26wfNhsg8=;
 b=UqFIwvozlcuPerLUbYH+zDJBgA7bjFaEhAhSXNPqO2z+oFNfLolsY0/yV7zKbB71WloS9oFRkxB02CQwA2M+jiQqvVTfQxsCDmVbnEtVJKWR9GPQyMU35cNk1Zi9TxJ90y7pCYEvHlFf3tITorg+zZvJ4DoISqGTBTdFxWcq8aj2cc+j7GwreqyFRQaGvIkoOdaMp/c1yCPt/+jlK7iM0GwHy26R+tN47YBhrGoyjVydSJBcH+P2VUDuHjMqPGqrO4qx8HlPZHyu4takdTvrajOIyo+WORJGLeY2cTemjQNdIkj13YTmnYUsOsSObpCNir6GLEiH7xEGux/3xOt/PQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB11009.eurprd04.prod.outlook.com (2603:10a6:102:482::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 01:42:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 01:42:51 +0000
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
Subject: RE: [PATCH net-next 01/11] dt-bindings: net: add compatible string
 for i.MX95 EMDIO
Thread-Topic: [PATCH net-next 01/11] dt-bindings: net: add compatible string
 for i.MX95 EMDIO
Thread-Index: AQHbGjLl591Rz/Mt20OKV++K3phNBrJ+m7GAgACY2lA=
Date: Thu, 10 Oct 2024 01:42:51 +0000
Message-ID:
 <PAXPR04MB851023C43FBF2EDEC45257A488782@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-2-wei.fang@nxp.com>
 <Zwauy1WYZtHmwmFC@lizhi-Precision-Tower-5810>
In-Reply-To: <Zwauy1WYZtHmwmFC@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB11009:EE_
x-ms-office365-filtering-correlation-id: 7f1b9a8f-2d2d-4f93-7610-08dce8ccda7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?dmhtdmJFVXBsRXBqUWJkSEdXeUpQc3hSdjFodHkvY0dYUmx2Qjh0YmtNbXlZ?=
 =?gb2312?B?Um9LNklDWmRnKzIxSFMyNllpUzBrdmxUVzhLYkpkZms3YW9rVncrVmY4b0N5?=
 =?gb2312?B?MXdGdjFQQVI3and4R2dEVXovL3d1VGlPcGNUeW91dzNLbHVQeGlMZDdCT3A2?=
 =?gb2312?B?VGxRcVBMRzR2V1ZkSDFRMGhLNTU5OGFHWWQrTGtzSFlia1dEYjNqUkZhVEVr?=
 =?gb2312?B?RjhvTW9FN0JEQWMveVB0UVJndW8vbUpEeDM4NGY3QVJ3QjlzcXBQb1JYQmZr?=
 =?gb2312?B?b1J0dkpIODhaQnZVSnRLalNUL0xHRzcwU3A5VlkvMnVXSTAvU2x5V2hibFl6?=
 =?gb2312?B?L1ltenVOSkJlNHpxQWJxZzQ3LzcyVnFOSFZ1Y0JObW5RRXh1eXFWMlB0bVA2?=
 =?gb2312?B?ME9XQ3NKeXdRc0JHREJoTjFud2twTTk2ZmdiWE1BZllHZVl4OWJaRnVZb3Q4?=
 =?gb2312?B?YWlZdzM5clplKzdrY2V1K0xjZ0xkeE5zNUFMYWk5aE4rU1pKV3lFeTg2cmkx?=
 =?gb2312?B?SXZlQ3pYUmhsaTMrc2hwODFMK2xpbkZITnBNZDhjMlQ3RDlrYXU0ZGk1eVlI?=
 =?gb2312?B?TjI4NG9QMFRTSDFLWFJ5Tm52YjdheDVqNDlWa0daL0VOZzdlRk02Zy83UUxN?=
 =?gb2312?B?SSs3c05zSTdqbSsrOVBab2tCUmxZZzNqR1dFSlA1VS9sMFdaeDlTV1l0SzJi?=
 =?gb2312?B?bkVZR0N2Y3pkZloyN01Gd0RiRzJhYXkvVG9HTjk3ZmJPandOb1RmUmxGUTRH?=
 =?gb2312?B?elZBWHV2VTd1TjNQSG5VQjFoeVordXAwN2ovRjRzZERzUGtLRkRYM1NHQ1FE?=
 =?gb2312?B?Z0FmbFdRS3pzK2UxL1pXSElhV0trUThtTEcwMzM4TU5wUnpPZFZkdnJlUXJt?=
 =?gb2312?B?dVlrUlNmcFpDU2RyaWR4WjA1NFRLYjhINkRYdGo3L2gyVHZEcEJ3aCtBSnlL?=
 =?gb2312?B?RzlXQ2NkTnRXeE5QL3ZOa1M2a3FLQlVtclFFUlliZ3BNRzhtdm85c3BxK21n?=
 =?gb2312?B?MUhiUHVHeXZWWWZMeTV6NUVvN2NlcjNJUDV6alVZZXFJa3FCRlA0RGtIZ0d0?=
 =?gb2312?B?bWIyWXhXV3NDUmJiRS9TNFRiSVlaVlhRU0l0aUxRS0F0ZDVFVXNVTTBLS0Jk?=
 =?gb2312?B?UEEzOC9acFgwRmZtclFjS2VJbVU0VEVqRmNaTk9qMHpoaDFNMHNHYU9ISFZv?=
 =?gb2312?B?SmtjNm15SnhKVnQ5Q3p5Y0l4YlgvZEZIZUpZZS9yWkg2V3ptWFU5cDh2Skl6?=
 =?gb2312?B?SjN1dUp1ZW9Qc1RtK2I4dUlpelJEUHZQNmlFU2pteFB3aVl4L01mTFRrV3VN?=
 =?gb2312?B?MVhraEp3WVozSm5rK3FSYWNFdWs0NkxTM3hMLzQ0RzRDR0lNZDd2QlZTelFs?=
 =?gb2312?B?R3FGRVozNEtnTGdzMXRXUTQ5Y0Jmemg4UzVBUmxVbUdsVnhuZXR0bWhKamUz?=
 =?gb2312?B?VUkrSFI1U2NEdDR3enpQbVliWWtQQjg4bldtdWViazZtRkxlUDlISlVJL0FU?=
 =?gb2312?B?YTBGUEUxNTBlL0JNNFdhVGJUNnBZOFYxemkxYjI0eTBLbGZ0L3hJSDYzYmN2?=
 =?gb2312?B?ZUNGSGdTbVEwL0QyWHhVR005YTRRZnFhK3VLWkgreTFrNjJ0V1AxaXVpbXJI?=
 =?gb2312?B?YlBhY3E0YTBVclZBRWlGQ1RSN1h5M0hmaUw0dXpwVkNDWFpzN29XeUtlRkVF?=
 =?gb2312?B?NENGd2ZFRFFJNFRwSFFwYSsrK2RLTXI4ZExnTjF4b25uOGtXNFJGK2JWSGtO?=
 =?gb2312?B?RE01YUxFeS9Bcy9RUUtJM3JoSFBMNUFIL0FhdXZ1bzFXRk9NbjdkYS9jUkJj?=
 =?gb2312?B?ZlNlMWJkWnUwNFVYbUVqZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Q2F5c0JlU0RKL2FuR3FMcWFYeithR3ZiOEFBTi90WjFVYnlTUWxOdWEzalBJ?=
 =?gb2312?B?RzdROEhJbG5NWUszSDYyV1lxS1pUYjE0ZkNyWGxkT0tWTjJTaGlmM3lZUHVL?=
 =?gb2312?B?Z2tSZVVyenJ3Vkxab0MyazNhdDVrTk80eEcveTk2dVRGaFhhQyt5V3E5SU5Q?=
 =?gb2312?B?WjlQZk1Cd09icHBQUWFWY3dZbWs0VCsxMmE1M2FLemVyQkNGMzRMSkFvZ0My?=
 =?gb2312?B?MzYrY1BTUlA5MUtDa21IZ01FSkM5dlRZT3I4ejAvWjFOSlZiYWEzbStsN0Ns?=
 =?gb2312?B?Q21NaTVTRVBma1BBWUxobVI5MFlKTzJvM2xrUlo4UkZlRWxLa1FacFJsOVh1?=
 =?gb2312?B?ZVZwS1lRcWZ0Y3JGVzRWdlBzRkpSdDJGQ3JqdHUwaEtuMUhuWjRnc0Q1REJh?=
 =?gb2312?B?Qm9lTjhwNVY2ai95ZEVmZEI2V1Z6OUZOTUJna1B4VXIwbnpmckpkZHFKMTds?=
 =?gb2312?B?bXNrOXRzT3hUVjl2RGZ6NC93dy9DRExjOVhYWmxvSStib2xjZUJzNys2WE4w?=
 =?gb2312?B?OHVaNTBzUGZ1bktzaG5peU5IZkMwVzlGQ01hZzcvbjNoZmwwMlUyd2hjVEMy?=
 =?gb2312?B?aGdlMk5DYUl1UUR1Vld5UTlMYXY1V3FJVVdPejJuZ08xZ0pCZ0tqeUgzdjJx?=
 =?gb2312?B?QkxEc3FxMWdLZWdLc1RGNDdqOFNJRmxRNjdmOG5ueE1SbW5Gbng2Y2FZcEtR?=
 =?gb2312?B?eHdzNjUrTXl2QVNVZzhlN2ZkNzdHK3FUcm5XeHkydENiUjFZa2lpTGRKNHZj?=
 =?gb2312?B?Y3NPSGorUzZ5M1VsVENLWU5wMjZpb0FRM3hRTy9vd1JZemFpMlJiaTZ6bTFu?=
 =?gb2312?B?UkpUbkJqTkJpc1E1SzN2cmYrT3oxUlhsRFdpWkEzd3BIcW1oN25wWW41NUtY?=
 =?gb2312?B?aWdTRVJrMk9tUVdON0ZzamJ1MXhNR3RBRWxweE1tckhnRmQvTE5MNEJ1VmdU?=
 =?gb2312?B?NkhWT29vMmt2dmRZTUw1bjJPdEs0Zm4wbUh6REhQMjRXRzNtY1Iwb0N3YUZD?=
 =?gb2312?B?R2tCUzhLMkJHRmVRa0hoN2xLZDZFemU3bnpBV0dyY0F2ZEZNWDhJbVZjbmdE?=
 =?gb2312?B?K2xWQjArNzdnVVpDMUdyanNiNjFzc256a0NlVU1FNGsyak01ckp0Q2dLeUF0?=
 =?gb2312?B?aWRibExlQ0V5Nng2NGI1NHBPV0ZFaXRRbEVrZXdmK0xpWkJIemVyQzl6OFp1?=
 =?gb2312?B?a3BGUTRESm15NmRobUF1Z0prMk5CdVk4SE1zVi9JcnU0V0RHUG9YTUdOR0Nk?=
 =?gb2312?B?ZWtROXdLZzR5K2loOWxkVzdxNXI2NEQ0cjd5RzBYQW81R0grd0ttOGVDYnd0?=
 =?gb2312?B?aE5jMEJKVG1DdGJnVGw3b3o2YTJCR0pFcGY0WnlUd2dJYjZkTWoyVHZ4L0lT?=
 =?gb2312?B?MHFuYm5aa2dBaDY1UTlzaFpMVFgyNVhvUG9oOGhLZXhzZ1c2RHlod0RaUGRm?=
 =?gb2312?B?bXMyejFXZm8rWlQwWWk2NmROLzViL2N2M2doZU1yV21rR1RRYmNmdmNYNm5m?=
 =?gb2312?B?N2ZGQ3JVTDUwZW5Vejd1eXkvQit5OGsvRVRlU0FSQnhWMG1tbjhwTGFsRVZx?=
 =?gb2312?B?aUNEMEw5eXlQbXczN2VZWmhQcEd2TGp4TVVKSU9wOXpnODdkT1R5d2VVYTgz?=
 =?gb2312?B?YW5JMGlDQlp6b3RNNmh6Y1BFZjFLaVRWV0g0QkNZNHVHWmtCTXVXT28wQVdy?=
 =?gb2312?B?UlNVSGJJdlNKMkhuZ1E1OUlzbEcrd2llZndONWh1R2MwQzlidTA0SEYvcWZQ?=
 =?gb2312?B?UjQzeXVzLzFLTmlRcEsyRDVva0dGYVBnYjVRQXBjUWl4dmNMYmJ2M09LSnRT?=
 =?gb2312?B?QkdFMU14ZERGdnhKVTZRVHUzeTllR2JlM1ROV1diMnErS1hYODFKWEVyOC9C?=
 =?gb2312?B?YXMvK0xLMHRrUlVCMUhVTFcxN2wzY0w1Umx4K202cE94ck0rcCthV0lHdlBp?=
 =?gb2312?B?UWZwbXJVUlZaLzUyalJmeW9hOUdDaXZ2cForNUZSREdTMG5ydVk3Y24yT3NZ?=
 =?gb2312?B?bWExNDRCZ2FvcXZPSDQyNDllSWRIWXN0cDdnK2RrdnFSakhGYkw1NTNXcTZa?=
 =?gb2312?B?NzNNc1hXVDI5ZmRzaTVFY2Rha1pTZG0xcEZaZXZmN1lLck4zZWNQNUxtODdE?=
 =?gb2312?Q?GxKo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1b9a8f-2d2d-4f93-7610-08dce8ccda7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 01:42:51.6168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWWFp1d0/H7PvLTpmvEnFdX2pZc7K91ZnGVOr0qp4CRuBhXI33/4SacM05RixPqunBzz+c6OoqdTj9tS3rQjxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11009

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjEwyNUgMDoyNw0KPiBUbzogV2VpIEZhbmcgPHdl
aS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29n
bGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyByb2JoQGtlcm5l
bC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgVmxhZGlt
aXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47IENsYXVkaXUNCj4gTWFub2lsIDxj
bGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29t
PjsNCj4gY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1OyBsaW51eEBhcm1saW51eC5vcmcudWs7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggbmV0LW5leHQgMDEvMTFdIGR0LWJpbmRpbmdzOiBuZXQ6IGFkZCBjb21wYXRpYmxl
IHN0cmluZyBmb3INCj4gaS5NWDk1IEVNRElPDQo+IA0KPiBPbiBXZWQsIE9jdCAwOSwgMjAyNCBh
dCAwNTo1MTowNlBNICswODAwLCBXZWkgRmFuZyB3cm90ZToNCj4gPiBUaGUgRU1ESU8gb2YgaS5N
WDk1IGhhcyBiZWVuIHVwZ3JhZGVkIHRvIHJldmlzaW9uIDQuMSwgYW5kIHRoZSB2ZW5kb3INCj4g
PiBJRCBhbmQgZGV2aWNlIElEIGhhdmUgYWxzbyBjaGFuZ2VkLCBzbyBhZGQgdGhlIG5ldyBjb21w
YXRpYmxlIHN0cmluZ3MNCj4gPiBmb3IgaS5NWDk1IEVNRElPLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL25ldC9mc2wsZW5ldGMtbWRpby55YW1sICAgfCAxNSArKysrKysrKysr
Ky0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC9mc2wsZW5ldGMtbWRpby55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L2ZzbCxlbmV0Yy1tZGlvLnlhbWwNCj4gPiBpbmRleCBjMWRkNmFhMDQz
MjEuLjcxZjFlMzJiMDBkYyAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L2ZzbCxlbmV0Yy1tZGlvLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZzbCxlbmV0Yy1tZGlvLnlhbWwNCj4gPiBAQCAt
MjAsMTAgKzIwLDE3IEBAIG1haW50YWluZXJzOg0KPiA+DQo+ID4gIHByb3BlcnRpZXM6DQo+ID4g
ICAgY29tcGF0aWJsZToNCj4gPiAtICAgIGl0ZW1zOg0KPiA+IC0gICAgICAtIGVudW06DQo+ID4g
LSAgICAgICAgICAtIHBjaTE5NTcsZWUwMQ0KPiA+IC0gICAgICAtIGNvbnN0OiBmc2wsZW5ldGMt
bWRpbw0KPiA+ICsgICAgb25lT2Y6DQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAg
ICAtIGVudW06DQo+ID4gKyAgICAgICAgICAgICAgLSBwY2kxOTU3LGVlMDENCj4gPiArICAgICAg
ICAgIC0gY29uc3Q6IGZzbCxlbmV0Yy1tZGlvDQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gKyAg
ICAgICAgICAtIGNvbnN0OiBwY2kxMTMxLGVlMDANCj4gPiArICAgICAgLSBpdGVtczoNCj4gPiAr
ICAgICAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgICAgICAtIG54cCxuZXRjLWVtZGlvDQo+
ID4gKyAgICAgICAgICAtIGNvbnN0OiBwY2kxMTMxLGVlMDANCj4gDQo+IHdoeSByZXZlcnNlIG9y
ZGVyIGhlcmUuIHN1Z2dlc3RlZDoNCg0KSGkgRnJhbmssDQoNClRoZSBWZW5kb3IgSUQgYW5kIERl
dmljZSBJRCBvZiB0aGUgZm9sbG93aW5nIE5FVEMgSVAgd2lsbCBub3QgY2hhbmdlDQpmb3IgYSBs
b25nIHRpbWUgaW4gdGhlIGZ1dHVyZSwgYnV0IGl0IHdpbGwgYmUgdXNlZCBvbiBkaWZmZXJlbnQg
cGxhdGZvcm1zLg0KSXQgaXMgbm90IGNlcnRhaW4gd2hldGhlciBzcGVjaWFsIHByb2Nlc3Npbmcg
aXMgcmVxdWlyZWQgb24gZGlmZmVyZW50DQpwbGF0Zm9ybXMsIHNvIHRoZSBlbnVtIHR5cGUgaXMg
YWRkZWQgZm9yIHN1YnNlcXVlbnQgZXhwYW5zaW9uLg0KPg0KDQo+IG9uZU9mOg0KPiAgIC0gaXRl
bXM6DQo+ICAgICAgIC0gZW51bToNCj4gICAgICAgICAgIC0gcGNpMTk1NyxlZTAxDQo+ICAgICAg
ICAgICAtIHBjaTExMzEsZWUwMA0KPiAgICAgICAtIGNvbnN0OiBmc2wsZW5ldGMtbWRpbw0KPiAg
IC0gaXRlbXM6DQo+ICAgICAgIC0gY29uc3Q6IHBjaTExMzEsZWUwMA0KPiANCj4gRnJhbmsNCj4g
Pg0KPiA+ICAgIHJlZzoNCj4gPiAgICAgIG1heEl0ZW1zOiAxDQo+ID4gLS0NCj4gPiAyLjM0LjEN
Cj4gPg0K


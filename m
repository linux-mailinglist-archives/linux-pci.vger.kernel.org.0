Return-Path: <linux-pci+bounces-24630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB8FA6EB1C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 09:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3F116247D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 08:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE48674E09;
	Tue, 25 Mar 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Us9sQjdc"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F2A1C6BE;
	Tue, 25 Mar 2025 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890091; cv=fail; b=phYvfGKOqFQMGgLVno5PwVOkNoCcj5PpxxN9NCDqmvgZKcNqQxxho4JUhI6J2Fv09TxFDzKsc/aFCZO5q1gvlxt7xoSzQyyvYtEgM+95v3apC11gifugLJQZs3RkoCQ8fYFn0Y1WyJIfGbwykD2T+hTJLZa8TteoHa3YV/w7I40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890091; c=relaxed/simple;
	bh=Re5iRiNyHRlvfazEwwzxIaAS3vMtRra4DTytO75Rcro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mkgf3NEC4TT/471TpotPCII4ldnvsBeRWMchWhbc3eJOOtBQnI3c8lrSl55utnRw0Njby72GaVRDdP2cuJd2A3dMp3LteVInKOfdEaa+CWBGTjHDdI578TJFHCQGrzZ545JELcAWeSe1J7knFv3tD9D8brsx6ezbnD/0qVwOQeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Us9sQjdc; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5OsFRBiNylBXi/3UzuUaPprU+XUNwXsXfcnHaKyv+Ej1xT3aNg2kYSaXgXSru5El+rAr3O5WUhM6YQ02xO9K8mwbkxFsVmFG895l23ZGXAd88/qvLAUNA7NK4ahsAK+M/prX0GD5VqQt3IjHPierbJda9lxjEqOnhI9AvWZY/Y5BS09RErnhOdL1uKDLjzD23t1XD8/lc7F41XOrnEGIX14YwT80eZe4rIuRorHsdDBMQdqVwIVY8/bzhvx+xmdbtzNxgWhlczdYv0lJSxvDpGnEiYEK9w7s6WbL+UuZ7BNuGELI8QWInThAfM/61A6gvRPirres6hLBzsyt6Ptyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re5iRiNyHRlvfazEwwzxIaAS3vMtRra4DTytO75Rcro=;
 b=EL5vCfagLB0kc2vLOFizhXjXV/xiXifncQmQFAS+JDQ3wEvY2EXSk+DXwdqwNjGqBQJWmFU6rI0VTo75tkX19gNeh8FZetuuPll1fVdaOx8pr7dEhFeDakJMNzsrCSmpPVTAgmopsEAdxUoqbFn96wK4sbND6TkCqsYAl/h94t+51W4UqFbc83lSf0enPxNXov23zdJhsn7BEanMV2NGs940PkyaA9dBBr5mlJEEQPTx6hgk2s5FfDqLaoL1vfLEvq+OKqJ2PyrOCPTvooMy+jt780r0yBrNJb7g3mxH4JcjleO6ccBvNPjFnQqhoZ5B8rRQVFWiGdkrv7d6zdMxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re5iRiNyHRlvfazEwwzxIaAS3vMtRra4DTytO75Rcro=;
 b=Us9sQjdc/p2J6KUPRiK6Z1UU/OD+oLKgnjlJVPoTIvGmwwXEnMe//z6RfcakH2h5BIMZ3mwYGGY9CW99nXPZMijYb4uFGNKVEzZW1DIgbZszW+b5InJ7Urd+sEmM0ebzcgh89Q2ezJUHSeXw2x1ndmsMA4ovN/yplE6zXpQV6QX2X2YO1lIdW5vOTRjp3WZ42BNalLYGMVP/+U1G87iw14ukFUPXBuHjJt8OWAMindLMOhoj3nDYJeKwc8bsJ8wn3ss2TWt4wNB5VWkW3tqc+QSVY22hExdQzaz2kOaQazM+swUA6OyYe7FvzAG9bgCxBOpl0uKMLDn4KSwfny/IYg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB9448.eurprd04.prod.outlook.com (2603:10a6:102:2b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 08:08:05 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 08:08:04 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 3/5] PCI: imx6: Workaround i.MX95 PCIe may not exit L23
 ready
Thread-Topic: [PATCH v1 3/5] PCI: imx6: Workaround i.MX95 PCIe may not exit
 L23 ready
Thread-Index: AQHbnIZs1WBxs/rEJk+GVjzhOIPvl7OCqMYAgADXIIA=
Date: Tue, 25 Mar 2025 08:08:04 +0000
Message-ID:
 <AS8PR04MB86765138FE183551D570AAE58CA72@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250324062647.1891896-1-hongxing.zhu@nxp.com>
 <20250324062647.1891896-4-hongxing.zhu@nxp.com>
 <Z+Gu/gmioiVJfDV0@lizhi-Precision-Tower-5810>
In-Reply-To: <Z+Gu/gmioiVJfDV0@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PAXPR04MB9448:EE_
x-ms-office365-filtering-correlation-id: d9e7252c-5d7f-464b-5f16-08dd6b742bab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?VlcxQms4a3MrSk0rdXBjbVhPTEptd2dxa1VVL3p2QmRTRXA5N3RtS3liOHRL?=
 =?gb2312?B?MFg3bE1mTTlVZE5vTmcvTjlrNFkzUlhqeDkzVG45YklHQ1hmWFo3SnNxSVBp?=
 =?gb2312?B?cXdKQ25hbForamNBOGI3eW9FUmM5NXYzRnI4SnFiTVNDcktidzFpa1B0dlNn?=
 =?gb2312?B?aVlMd3VENnc2eXh5UXBCMmdrcWg1aEZibjhaYjVDRFJHeEcwMEtIeUpvNTZz?=
 =?gb2312?B?UEgyYUQzZEw1aVNBcVozZFNONnVBL2graFQ2WmJqU3VqY3BwZW52SjhIdHE2?=
 =?gb2312?B?c1dWaDZNZWdSbHlFc3FwN3JPQ2QrTi9qbGVrZjhFcVdPNVhmS0t1TE51TEJR?=
 =?gb2312?B?N25tTGJlSldhMHgxbHRzLzFBWHZvOHA1MWwzZFIwN2c0Wm1UWkVneit1ZEVH?=
 =?gb2312?B?QlhON0JaRTZKamd2UnJSQjVLUHVoSlluY2JRc2ZDL1hsMkt3UE5rUGVPcC85?=
 =?gb2312?B?TDBrTVlaZHVxVXFvWmxFTjFuSVhqc3JCT0FTaWJaUmRDd1pEVnVUdngxaEN1?=
 =?gb2312?B?WnNMbDFHUVRSRmlkdEYzNFFHekl4cGRGR2MyaG5vOXR6Mm1oWmxMSWxjNEZh?=
 =?gb2312?B?aFNKa09vUFNzNDd0K1lyV2lCSmxtVitHVlU1MEt1NHlRR21nUXAwU005ZjBX?=
 =?gb2312?B?Y0w1ZGNCMDdraWJiRTUyNDEreko0OVRVWU56RUt2c3FVVjNCMmt0YWF0dFZV?=
 =?gb2312?B?WXVoN3JqOTJQUTgrZ2M4dDJhMjFtVU9MVWNkMUJBYThPc1UrSlZRMlJrTnRo?=
 =?gb2312?B?MVVMV3RxM3Z6SXhwdmVlSGpKemhOOWcxaTRvekxmcW1qUTBKZVQwSGhhekhR?=
 =?gb2312?B?S0xaSys5QlNaRUJqMm1RdFFHQ05ZWDRiQVgrZlF2eUN3RzlXQ2RLUlM0clpj?=
 =?gb2312?B?dGw2bWhreVNsdndPSGVXTiswZDdUanBKb2xlbG1FQXdvQUxjSExsdVhvemdR?=
 =?gb2312?B?SFV1V1lWYU1XY096T0s2UmhUVnRtOVBZZFYrVm42WXhaTjFEQ2ZRWkRPczR5?=
 =?gb2312?B?di9Ud1N0emRtZ2REVk9NcXp1SHNCS3R4eXBQYjIwcGsrQWd6blRkK2JZcElK?=
 =?gb2312?B?dUgzN1FYTW1RZ1BiREc4dUVvdWxnNy9kUUtaRUI3dGVZdEdia05BbVoxVllK?=
 =?gb2312?B?VGpZY2pUV2gzUlF6NjRtay9yUk1CZmwwZTJHWmV5dGU3Y3hEYUxUWktBaHkz?=
 =?gb2312?B?ek9xYThveDBzQkdiSGVOdmlFVUxUd3A3TmpjS3lKWG1MSXo2aURrdkdjbEVt?=
 =?gb2312?B?ZFZkaWxLbVd2WVlTVlNIcDlsU1JBb1NGUUwzdUR4dTJIRGsrV29HNnNLSzMw?=
 =?gb2312?B?TGFLTEhrZXJaaVJ3NkJPd3k4Rm9mMlZVS2N1UkxHN3ltKzlZVmdyemFWQXdK?=
 =?gb2312?B?eCsxMU1HY01qK0g2QzhMMXliSUhrOCtzTlVFbnpnb21HbXVRdUsxQWdxb1cw?=
 =?gb2312?B?ZnB0MFZjU2FlVGhTWU5MYU0vZ2xKZkprZklIOVExNjBiRXRuUVgwL2ZtbGJl?=
 =?gb2312?B?djRLOXNsS0YxRFhwVHBmZS9LT2JtZmw2MVdpRE0wYUg5QUhEeEo5T3oxRjB5?=
 =?gb2312?B?NHRReG1zRnpCUmhtMDB0cGFEaUNSazVadTdTSThOam5aSkRzQ001WHZyMjVF?=
 =?gb2312?B?c0hYUDMzTUYwT2oyUkZRRzlqL1UraEx5TDNpSE40R0krSUNjVngraFdVMXR5?=
 =?gb2312?B?YWkxeVBXMTlLTVA2Rms0YW8xRHlqYTFUUFlMdWltOUdqNis2NjlPZEpCZW1Z?=
 =?gb2312?B?TzlDZ01OR1hKWTlLd2NWMUhFNGpDL3BWank4enZHUUE2dk83WmhVY3RkQnJu?=
 =?gb2312?B?b0NPcjhlZzM3QUlVZzJrSy9RZzlVOUhCWUVLYmpmT01vZ1dJb3RRZDhjeHA5?=
 =?gb2312?B?SjZmN25Qd1NWSHc2RHl0YUh4V1k4ZVFHNGNSSUpCdndMZVlyWnl3aGMzRkJ4?=
 =?gb2312?Q?x/O6j8t785dMPnlwZE1LUjzcxMAFu83x?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dzRYTXEvZGRwSWRjVUlNREptY1M4clhRd21CV3c1cFU0T3hjdUdxZWtXWlc5?=
 =?gb2312?B?eDc1cUN4a0d0QldIV2tSUlQyV1FsTkpFMHAyZTF2cTF5WUpob0liRTNMb2Rr?=
 =?gb2312?B?QU9OUUpaVEpLMmZRSFJkNm1PbUNhcUpCUjg3WitQbW5mN3ZRbmhybG0vK29T?=
 =?gb2312?B?QTRSbjdscEVPNHhUNkhXMnRhQlc4QXI2Mjl0TGVOSjNRRFMzYyt4Q3B1UVZX?=
 =?gb2312?B?K2dJMU8xVHFSdHBDcFdwbXVSZVJRbEZBVUJrRHdtREFjTlQ0QVFLUTVPZGZa?=
 =?gb2312?B?UFNEaWJGNE4yRmNEdldiZVdsK1d6cXNSOTNuLyszT2V3S2NkMDkyOXJHUVhE?=
 =?gb2312?B?Z0dHYnpTaDU5TVlvbkRuK0dYOEJDRnp3K1BUam5zd1ZjQzhtRWtIZ2V4S1Y3?=
 =?gb2312?B?WmtVNXJmMFIvMHhsWXVqR3BaQUkvM1F6WnJZekVwaXk3YlU0NzE3ZjNWMFNM?=
 =?gb2312?B?N2JyZ1BFeVNPZFNmZjFXdlV6NXNBUjlYaXp1ZTljbm8rVUw2RjdVME1saWhy?=
 =?gb2312?B?QkVaU3JXNHNLc3NkbmdHZmpwTTdkRHZiVDIxd056UkpvU3RWRjA4Y01ITEpu?=
 =?gb2312?B?NEJYTWNHVUhqa2Z6cjNDLzZpUjIwZjA2b28zUFVFYjN2ODQyU0VXdFdiRzRq?=
 =?gb2312?B?VUNFbDBnS2NZK09JOHAyeHMrSlRCRUlVZHQxMjAwYWhLSnczdDRPQWdRT1hC?=
 =?gb2312?B?YUMvRk9kcmhHbllIVDdkL1BsRzNmNDZ3ZlE0TkZOaGJLQWMzRk8ycStUeGkv?=
 =?gb2312?B?ZklIRThUMWt0eDNETlU4VnNNNE9NUVdDN2ZDemtRRXN3UFBZZzF1cGNKSld0?=
 =?gb2312?B?a014VDZCdlJBaVByZ2tVMFp1N0NTSUZPWnJDRWRGcUI0enZjNU8vQmRjVlB1?=
 =?gb2312?B?dGZScDRMNVdqbm16YVhSUnovdjJwaWJWdGJvQ3dTQlNVaDdZdHVXSEdmTmNN?=
 =?gb2312?B?cmZITjNXSDllR1poY3hOWlZKb0xwWkptdFhCeG54eXBmemNSd2Jaa1J0ZzQ5?=
 =?gb2312?B?OWNnU0RoODJqZS9YWkw5cmZ3a3FnR2xkWmVqS2JIZGFQbHppZkNlVi9zbHBJ?=
 =?gb2312?B?dzVPWWlpdW1YbW90eU9DcnFnbUdINjMwT3ZNZEhrUGNJMjBCdXlTUVZtWmgv?=
 =?gb2312?B?Q2lxY2NoTDhFbmNaajBhdk1mY21WYmMvUjIycDFBamxIcndYTm5LcytJM0Va?=
 =?gb2312?B?L05TUi9qR3oyYXBlanFmR0NWU2dSdUFLbVlFMG1OVHJoK0t0OWpqbVJHTU53?=
 =?gb2312?B?K09FcDNQOHFmUjlxcUlyaHZNQlhUWlR0QlBoSTExWFlmUlVPUldMSlo4ckZK?=
 =?gb2312?B?aE1VVEJQTkFIN1dJMzRVbGpheTY3YWhEcWRPNk50dDg1eUtuUXJMV1M4WDJ6?=
 =?gb2312?B?Vks2SE5qa2hQK013dWZYa1NxNnNxRGg3SitUMi9MbHlkRVV6WE9rTW5DR2hI?=
 =?gb2312?B?QlBUWDFvcVd3WEVld1hmUFBUUThhd0V5Tnl6bExUcXNlOUdrS0ZCWmNVd1JY?=
 =?gb2312?B?MTNkOVErSGNLbWNiMTFoMDkwaThmaTJSdHh5R0dWVW05dzJIVEVZMVIrbXo1?=
 =?gb2312?B?YTdtQ2xUTk9mb1VOZEJkK0puTld5cFI0OEhUYlFTWk81bnJVWXBpZ3VhLzNI?=
 =?gb2312?B?aTh0K3doZ28xYVpGWHdHS0ZYZURHbHhiSUFiSWxnOHlsMS9KOWZnRzR6cTJX?=
 =?gb2312?B?MmJ4SGJkdUpnQVlRamRIdlh3RURYdnpuelVHazFoMG5BMWZUbEhWbUlpaXR0?=
 =?gb2312?B?TU00Z1NRTHZ6a0s3TVFKYXZLenRQeG8vSldnSXl3OW85N0loVXdzT3g3Ym1j?=
 =?gb2312?B?RjNCVGNyNDYyMU9ZQ1plWWlFL0cxOTdrS2NNRENCTG1tbWZkUXFrSFpVYnRu?=
 =?gb2312?B?TUFJSm1neWxKc1NpcjZrdlJWMFYzZ2ZJSGFrUm11MHlGWnhHU3ArQjVlcUhD?=
 =?gb2312?B?QmwvTmFkdk1WRXBGdXNISzdzTnpKQkl5NEZyU2k3Rzh4cnhlSlhnY2VrL0JH?=
 =?gb2312?B?REFOem9xdXFPaGNRTXVSeGlPM2JjRGFHYlBuMjJMWnpCWXdvTytqQjgwUDBD?=
 =?gb2312?B?cldDTzkxZ2pTamcrd1NJUFk3VjZYT3Fkd1F2YXZwT3lxbERtYlhwZndEeHdO?=
 =?gb2312?Q?LDiV1Lnop9BGii0A6hUPHtPCC?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e7252c-5d7f-464b-5f16-08dd6b742bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 08:08:04.8871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1G+4wXCsnlcW7q2t7WawydalnVAsbr1SoFve4UA8hRHojGYf9gz4llEoNrZnbf5o8Zio4Iyc9gMKAy5HiLHu5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9448

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNcTqM9TCMjXI1SAzOjE0DQo+IFRvOiBIb25neGluZyBaaHUg
PGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgbHBp
ZXJhbGlzaUBrZXJuZWwub3JnOyBrd0BsaW51eC5jb207DQo+IG1hbml2YW5uYW4uc2FkaGFzaXZh
bUBsaW5hcm8ub3JnOyByb2JoQGtlcm5lbC5vcmc7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IHNo
YXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGlteEBsaXN0cy5saW51
eC5kZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MSAzLzVdIFBDSTogaW14NjogV29ya2Fyb3VuZCBpLk1YOTUgUENJZSBtYXkgbm90IGV4
aXQNCj4gTDIzIHJlYWR5DQo+IA0KPiBPbiBNb24sIE1hciAyNCwgMjAyNSBhdCAwMjoyNjo0NVBN
ICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBXb3JrYXJvdW5kIGZvciBFUlIwNTE2MjQ6
IFRoZSBDb250cm9sbGVyIFdpdGhvdXQgVmF1eCBDYW5ub3QgRXhpdCBMMjMNCj4gDQo+IHByb3Zp
ZGUgYSBlcnJhdGEgbGluayBoZXJlLg0KVXAgdG8gbm93LCBJIG9ubHkgZ2V0IHRoZSBmb2xsb3dp
bmcgZG9jdW1lbnQgdXBkYXRlcyBpbmZvcm1hdGlvbi4NCiIgVGhpcyBpcyBiZWluZyBjb252ZXJ0
ZWQgdG8gRG9jcyB1cGRhdGUgYW5kIHdpbGwgYmUgYWRkZWQgdG8gaW5pdCBzZXF1ZW5jZQ0KIGlu
IFJlZmVyZW5jZSBNYW51YWwuIg0KV291bGQgYWRkIHRoZSBlcnJhdGEgbGluayBhZnRlciBJIGZp
bmQgaXQuDQpUaGFua3MuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IEVSUjA1
MTYyNDogLi4uDQo+IA0KPiBUaGUgd29yZHMgYWZ0ZXIgRVJSMDUxNjI0IGlzIGRlc2NyaXB0IGVy
cmF0YSBpdHNlbGYsIG5vdCB3b3JrYXJvdW5kLg0KPiANCj4gPiBSZWFkeSBUaHJvdWdoIEJlYWNv
biBvciBQRVJTVCMgRGUtYXNzZXJ0aW9uDQo+ID4NCj4gPiBXaGVuIHRoZSBhdXhpbGlhcnkgcG93
ZXIgaXMgbm90IGF2YWlsYWJsZSwgdGhlIGNvbnRyb2xsZXIgY2Fubm90IGV4aXQNCj4gPiBmcm9t
IEwyMyBSZWFkeSB3aXRoIGJlYWNvbiBvciBQRVJTVCMgZGUtYXNzZXJ0aW9uIHdoZW4gbWFpbiBw
b3dlciBpcw0KPiA+IG5vdCByZW1vdmVkLg0KPiA+DQo+ID4gV29ya2Fyb3VuZDogU2V0IFNTX1JX
X1JFR18xW1NZU19BVVhfUFdSX0RFVF0gdG8gMS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJp
Y2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRleCAwZjQyYWI2M2Y1YWQuLjUyYWE4YmQ2
NmNkZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14
Ni5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+
IEBAIC00OCw2ICs0OCw4IEBADQo+ID4gICNkZWZpbmUgSU1YOTVfUENJRV9TU19SV19SRUdfMAkJ
CTB4ZjANCj4gPiAgI2RlZmluZSBJTVg5NV9QQ0lFX1JFRl9DTEtFTgkJCUJJVCgyMykNCj4gPiAg
I2RlZmluZSBJTVg5NV9QQ0lFX1BIWV9DUl9QQVJBX1NFTAkJQklUKDkpDQo+ID4gKyNkZWZpbmUg
SU1YOTVfUENJRV9TU19SV19SRUdfMQkJCTB4ZjQNCj4gPiArI2RlZmluZSBJTVg5NV9QQ0lFX1NZ
U19BVVhfUFdSX0RFVAkJQklUKDMxKQ0KPiA+DQo+ID4gICNkZWZpbmUgSU1YOTVfUEUwX0dFTl9D
VFJMXzEJCQkweDEwNTANCj4gPiAgI2RlZmluZSBJTVg5NV9QQ0lFX0RFVklDRV9UWVBFCQkJR0VO
TUFTSygzLCAwKQ0KPiA+IEBAIC0yMjcsNiArMjI5LDE5IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQg
aW14X3BjaWVfZ3JwX29mZnNldChjb25zdA0KPiA+IHN0cnVjdCBpbXhfcGNpZSAqaW14X3BjaWUp
DQo+ID4NCj4gPiAgc3RhdGljIGludCBpbXg5NV9wY2llX2luaXRfcGh5KHN0cnVjdCBpbXhfcGNp
ZSAqaW14X3BjaWUpICB7DQo+ID4gKwkvKg0KPiA+ICsJICogV29ya2Fyb3VuZCBmb3IgRVJSMDUx
NjI0OiBUaGUgQ29udHJvbGxlciBXaXRob3V0IFZhdXggQ2Fubm90DQo+ID4gKwkgKiBFeGl0IEwy
MyBSZWFkeSBUaHJvdWdoIEJlYWNvbiBvciBQRVJTVCMgRGUtYXNzZXJ0aW9uDQo+ID4gKwkgKg0K
PiA+ICsJICogV2hlbiB0aGUgYXV4aWxpYXJ5IHBvd2VyIGlzIG5vdCBhdmFpbGFibGUsIHRoZSBj
b250cm9sbGVyDQo+ID4gKwkgKiBjYW5ub3QgZXhpdCBmcm9tIEwyMyBSZWFkeSB3aXRoIGJlYWNv
biBvciBQRVJTVCMgZGUtYXNzZXJ0aW9uDQo+ID4gKwkgKiB3aGVuIG1haW4gcG93ZXIgaXMgbm90
IHJlbW92ZWQuDQo+ID4gKwkgKg0KPiA+ICsJICogV29ya2Fyb3VuZDogU2V0IFNTX1JXX1JFR18x
W1NZU19BVVhfUFdSX0RFVF0gdG8gMS4NCj4gPiArCSAqLw0KPiA+ICsJcmVnbWFwX3VwZGF0ZV9i
aXRzKGlteF9wY2llLT5pb211eGNfZ3ByLA0KPiBJTVg5NV9QQ0lFX1NTX1JXX1JFR18xLA0KPiA+
ICsJCQlJTVg5NV9QQ0lFX1NZU19BVVhfUFdSX0RFVCwNCj4gSU1YOTVfUENJRV9TWVNfQVVYX1BX
Ul9ERVQpOw0KPiANCj4gcmVnbWFwX3NldF9iaXRzKCkNCj4gDQo+IEZyYW5rDQo+ID4gKw0KPiA+
ICAJcmVnbWFwX3VwZGF0ZV9iaXRzKGlteF9wY2llLT5pb211eGNfZ3ByLA0KPiA+ICAJCQlJTVg5
NV9QQ0lFX1NTX1JXX1JFR18wLA0KPiA+ICAJCQlJTVg5NV9QQ0lFX1BIWV9DUl9QQVJBX1NFTCwN
Cj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQo=


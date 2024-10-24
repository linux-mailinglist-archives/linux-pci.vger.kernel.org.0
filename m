Return-Path: <linux-pci+bounces-15185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D02189ADE01
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E5F1C24B05
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36D61AF0A3;
	Thu, 24 Oct 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JlmoYDHN"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C51ADFE3;
	Thu, 24 Oct 2024 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755788; cv=fail; b=IXnGNacaqFNe3dXaG1CrMmt/zpHUclrmVS+z/ppVA7ddb7GhlGJnNoTTPKWHkes+AZrgteWo68yVXnfHNRyDX/fx0w7uhYsb70vazPlqz7yiULao3Psy0vsvrh/POz4x6zXeRhrkBAdxBPy8BR+/ozqxOyNq3Ej37aeYBkazTL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755788; c=relaxed/simple;
	bh=Ts2XbLfOiDYOreaS6V8MdZw/9YRd7SIfnuoCO9Qgijw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t74/T0xU7q+mnMcI9b29hKyEjr1wZLqmMGZl7FHPOT0jTcfCATAHM3YlPUygcsa8zz1+3V3ybCP/x9smn91J6y7ganzBRpCunly3ml7ELWafERlHQdqzs9LQ3TywZqzfzgQwLoXFIcY9qGAYPRGGeTi+9hWh6ifyJXoAdJ0BiTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JlmoYDHN; arc=fail smtp.client-ip=40.107.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMYZI1c2zzvGxP8aouR2f+PnjjD1QyU84IhlFPh0W305BoI5wTkCfaqepJhVOrBW6Wga/kevXcASEDX4aFEj5Q12ATz+MjXDvxUQyjrj19ce6cQIWzakjU66XAFYb1oGL32XXCiD+KEmFBO0GMJPcW/jfDQZVXM/+rrz7IH/HGtFmS94pW0Ts0c2Fhr1Fgwcwn6nhphvJTb/oMWKU7zScj2+SuLutCv+6U/3/l2qIy9gWyEUy5pSWzHjPIKpIgBJQIbAorQQHvVzWDUoivqBoQAv5F1zI10EceNtlNKFScW2voYteaFbcO0oj35PzNt7aoG0KVRKW8enbKm4s/rdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ts2XbLfOiDYOreaS6V8MdZw/9YRd7SIfnuoCO9Qgijw=;
 b=ZiB+JBmKA/+0fnZpM113r8oVtt7smGV4NK1fbF+T1uPoPsZIuZqpmdbs0cUQZfD6jBbhOctpTjioLniKryjdYAvwn4SgIx1u86T+e2rXhnwil0XwZo+Qrq9NnQ3Nssy/sr1cahwha53kCGuueVBisZeFGmeSvhNcHKmDNZpu3+NYHAcEfXnF0poh3dyuaDyGpwptHgYGhZKd1Nbsagj/fJ9jCRD9uMt/6T02hrNRj/fh6kTQ7mkL10B0XacZryFDSSXGJaTExMh7M0MCbnW6/nm2pf5ZKISl9sN5IP5toX3EU3+lbt8nWOncLHtyXlFpZEfXd8EjNOO+shzNIcgmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts2XbLfOiDYOreaS6V8MdZw/9YRd7SIfnuoCO9Qgijw=;
 b=JlmoYDHNhdXGAc9muVA50QZ+kYN9Bn5E/INsBf8gBC5jVm3CjtJRiLNSbIx9EWR8rFCVpJl7F7fLNlRmqZm7iFJCtJzWCa3i+lMq6IXpQJWDkltmhoVLa9Nc+GI326fKfLE8J+QYP07N/b9AD0bInw5s8VAHc5MSeEHBFv4SeE1C3DzXHwMSusxpTalQpWrXLhxb5zBJayOUTrz2xXd2rPpLArPYZZvR/Pb1grqEf2ePrCrks3n7xCPek3XlbBybRxe9+kdXquYVClbwNm7DnDfkQlsIlAjmGX70+XB1tnvgD8yg4jJuerDt9QYb8D/cHLQZNsxmvF5ss/BVlkktJQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 07:42:58 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 07:42:58 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "kw@linux.com" <kw@linux.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, Frank
 Li <frank.li@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"festevam@gmail.com" <festevam@gmail.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v4 4/9] PCI: imx6: Correct controller_id generation logic
 for i.MX7D
Thread-Topic: [PATCH v4 4/9] PCI: imx6: Correct controller_id generation logic
 for i.MX7D
Thread-Index: AQHbHuBEU2VzccqnjkOMBbCHOG57jrKTCLsAgAIiY5A=
Date: Thu, 24 Oct 2024 07:42:58 +0000
Message-ID:
 <AS8PR04MB8676B522DE767D2B0F1D1A058C4E2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
 <1728981213-8771-5-git-send-email-hongxing.zhu@nxp.com>
 <20241022165548.6qhxt7dsd7m7i2tv@thinkpad>
In-Reply-To: <20241022165548.6qhxt7dsd7m7i2tv@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|VE1PR04MB7342:EE_
x-ms-office365-filtering-correlation-id: 2186c577-e3ed-4f02-80c4-08dcf3ff7b16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WWRtNUU3dURyWElqS1Y0UUZIMUpiQ014NDlxVmdCVStzTHBRT2RqQUo1Q3JG?=
 =?utf-8?B?WG5SMDVyNTZibVllVERDY3hzNWNuOEVmbnNnemZvWnBkRWNOdW5SUEh0Z1E1?=
 =?utf-8?B?L0ZOc2F4RWRQQlpyRmtiR2J2Y3VxYVdmMXVqUWlzdHBZOFFVbUx5WUIvVzN2?=
 =?utf-8?B?TlZDRnpjaDB3aFF4bEt1cTFIbFErRVZ5S1JmUDNpNk5OTVB0MUlWVTFLQ1c3?=
 =?utf-8?B?LzJLeVJEQit0c1FxL2pKQUcyRG9FUXhGYTZFL3V0Nld4MzZ1ZkN3N3gzMzNq?=
 =?utf-8?B?V0lGRmdzelNNSEg0MmtLR0xaQUdOT3FyYVVMNUNiS2pxSmdEaXY0NERMVm15?=
 =?utf-8?B?WDdYNGhzZmhqN3dSV1RzMWI3TjY1b2k3TFZmMms4b1ovQ0h4N1RCVFZqYWJs?=
 =?utf-8?B?WDN1RDlQaU93bDVML3FsZWlYd2QwUFlyMHhKemp0eXZROEZZVFo2MmpORGlI?=
 =?utf-8?B?L05nK1BITE1GbmFFVmtWeHdTRXdLalphVmUvNFVYUUI2U3N4dEMrd1UzdU84?=
 =?utf-8?B?V1M2bWc4aDIrcUFkQVFSL3BoaWkzdUJ3ZWRISWNSVkl4SCsvdkJ4RUQ5bHFr?=
 =?utf-8?B?emFabnB0R0RDaTRvNzJHcmlxdU1JVXVMNXF5YWxDek9JSmNjSG5TSXE4SzhY?=
 =?utf-8?B?V1R3NDh0WDdjaWszQWhmZmJGNG91KzVIZzV4b0VZbFJmem9GazhZeFNMaURD?=
 =?utf-8?B?MHZibnMyaGkwNTlSNHpXaW45bkNRYk5ITzE1aktWRjlpRnlRQXNNWkxIVFpi?=
 =?utf-8?B?NzQ4eU02blFZdE92Y0g1SWEwOEw5ckQzY2IvaVFNTUdzNWNVTHBVWTBkT0JZ?=
 =?utf-8?B?VUdHQmoreGQzbWFwRXdzb0wzUXllOUJYRnVNZStOWVpYZ214Q0lPa3laMzlD?=
 =?utf-8?B?KzFMRkx0Ti94ZWluN3JBRHB3QytnYVZHdjdpUW5YMXJFajZrK1hmN2lHV1lv?=
 =?utf-8?B?QU9idVVhbnoveHpaR20ySWRSVzRIaEhNOTFONzhIa0l5VGlkUXM3TE1pZjds?=
 =?utf-8?B?dVFSa2ZvMDA4Tnd6ZGpmam9BZjdvdnhwSk16bHpxWm91VzAwbXkrdVk1YnVr?=
 =?utf-8?B?dllGRVhmd2I2SCtWRU9abHh0MFNWekpwYWQ5TGxoOGFqR3BuVkpBRTJBNGdU?=
 =?utf-8?B?bFFpMXVWWENWV0hrVWR3OGdSdFM3RWtYUDlqNGtQcUZTMVZLYUdoWVBFWENH?=
 =?utf-8?B?RHRlbXBlK2ZneVFkdUlGSWo2bjNXV3VyU0RIVGFGK0JTRkdKUjVBM0ZYY1pq?=
 =?utf-8?B?akhVU0owbW1YZHo5OFc3V2VUL0M3MVI3b3V0YUh2WkUzMUJiNnlYRE4rQnh1?=
 =?utf-8?B?QkZ6alNXL2pqb1I1c09pNkkyZlN0MUdmTzRGa1FMeEd5a3pxOTRyKzRoS1JH?=
 =?utf-8?B?Uk9Wc0JXM3JHelNKRXdtY0gvbHJnNUdRRzJyNzEyTk5OaGlZN0hlZ0pBU0ha?=
 =?utf-8?B?Qjh2eVZmSU1EdjFlZVNiZkdMcnFqZVo4VzlUdzI2UlExbjhVQmV1djU5Zk52?=
 =?utf-8?B?TWt2eHFLS1daUWNWL3FaREh3dWlkQzFyRVNwM0tTM1JuUnJCM2M0WjR4Sm50?=
 =?utf-8?B?UFhIaTdid2YrM29udHhSeHZoRzFzd1JOVFVNK2hNQk4rZWpZODJKa3FEVlMr?=
 =?utf-8?B?S1FFRE54L0RVYjFuZU5UejcyeEdlV0htSnFTWlBCMmtsNVZIMngwazhyU3FM?=
 =?utf-8?B?OE4xU3dZTzFjaWNMbkNnbFNYYk16TzZZU205TnB0eFl1OHdhbm1Ib1RWWDl2?=
 =?utf-8?B?b3QyY2pFdGFDaVAyZ1MrdmNieHNHRlVBT3U1MG9XUXV4a2MxQUlURmpmbmF4?=
 =?utf-8?Q?Rban3y49e9kdtord/F/wx3LqJjTgYG+1idm1M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qm5XWWN1cFJkd0hKdTU2dTF1WFZVWnQ5QWVTZ1RMZDNuNkpYZmdYWVM4NU1r?=
 =?utf-8?B?d1F5ckZnNUxJdTJ3SWxLMUdYR1dsWVByaktVYTJSWEQ2SXFVV3MvQ1hET3RG?=
 =?utf-8?B?cE9yZTdHNzNoTStOa3JHbmg0MjRGTWVYbjlkRmg0MDE1bElacGdHQTdLRGtS?=
 =?utf-8?B?Uk9XSUZXUDFxa2M5UVI2bkh5S1E0WEcyU0ZFWnRZZXk1SDRzcnlYeWE2TW0z?=
 =?utf-8?B?bFo1clFQcE5ERndZUUJFTkJhTHZlanR2UEdzejBXWFZXRGJucDVaQTFpQXZN?=
 =?utf-8?B?NFFRcmJhWmxoTFNNRWs0ZTVObjV0M0NlcXhMak1MQXFTd09WRndFRWp4S0dV?=
 =?utf-8?B?MnZLWnRINk5RWVpzS29POXg2Q05HK2xGaEwxV2F1RjA2bWxBd0toRVpscGhu?=
 =?utf-8?B?Z2ZjQ3RjaDZKTS9FMGltVHdzcnV6cWtJRUFZbVN1WG8yQjFrbVhGd1VHYzAy?=
 =?utf-8?B?Q2ptR0R0ZjJhWkxheXZyTVJZdGtiVVgzUTVIODVkTGQ5STQxSDI2L2ZTeDBs?=
 =?utf-8?B?TDFZeVF3a3h4WmQrRU5KaUViSGpicFFFN09ubm1nMVhXakVSRTkwOUl1WDlp?=
 =?utf-8?B?b3VSNlgvamdwb0NkeGs5SHNCTjhra0ZVU2JHdmJoS3V5M3RNeC9DRHBzbGZZ?=
 =?utf-8?B?Y1VXYzNMQU5HdEdSWFFWaE5GV01yMlJaM1ZiVE5POXk1Q2xFd1FXaGs2clli?=
 =?utf-8?B?ZHZuTG9tVVd5ektmZjUxQWRLbjhhZjR6dEg1SVRUbkdkTGFhVGREdGMrblR3?=
 =?utf-8?B?R3pwL3A5aDFiVitOc3NpY1g3VE1vaW9Pa1RTaDV5Y3hzdGYvMVFLK3Y0d1Vx?=
 =?utf-8?B?YXlUMWZTL3AvdzFuTTc3WU55aERhVFRISG5PV0hzN0Z4NkVqKzFjdEVYeTlP?=
 =?utf-8?B?TVZWS2kzNHExVVJZSU9jcU5RNUdodjBuT0FxYXVqcitVcVZnc0FCdlBXRHVj?=
 =?utf-8?B?VkNXaURFQnpEQSt6ZXlRWnpEV0FySnJGNkFYRTdIM2tXQ2pLRGR3bHZQZDcr?=
 =?utf-8?B?QVhRQjBIZ1c3MFRJeHU4UlcybXVhM2NCczhPWTJ4ZElzSW42RStFeHZUbnFk?=
 =?utf-8?B?M1dJN0ZxRnRWd2wwL2ZpVGR3cDE3K1VENUduN3BHRENmS0poMjVuK3kweDlk?=
 =?utf-8?B?UVBqV0xWcEpXR3pBSUxib1RWYVZKc1ZPUHVuL3BaVGFCWmFOWWFSTFRvR09l?=
 =?utf-8?B?ZjVVeExaczFPcTdUbFBqYkdrbVdHQzJvM0FxZVhhc0xFY0UyUCsyUnEwNEEw?=
 =?utf-8?B?SUFpZ0dwYlJ3eDlIajlVYnNpZXZ3M2xSejBCbDUvb0NlWWwvR0oyYVVwRE44?=
 =?utf-8?B?VFBmZGEyR0ZTMnBQQk5KK1lKeVF1bnMrUE5oNjByQXV2SzY2Q0F3UklLeTdt?=
 =?utf-8?B?Z0Z0ZDdybFBibU9vLytYb2hwdXZUT01IMTB0THZCZDVHMTFPWE5ucGZTSjFs?=
 =?utf-8?B?TVBlR3gxU3JxNDhHRlpMTnE0RGEyZnVSZTY4eFlZdG04emVKS0tUa201UDNU?=
 =?utf-8?B?TWlTaDVoY0k5d2RSTmNtaTI2TzhydjVKWkJTT2wycEdUQUxFM0t1YWZUU01r?=
 =?utf-8?B?S3czVnB1Qkg5UUFud2UvbCtHcEpsTjhJd21PbThpK0hlYjVxWGNrL0hXbFFD?=
 =?utf-8?B?dGhocmNreUtwbG1ucCtQejlMd2pacGFyOUZLN2Fna1pONjJ2RG1pblVKaVpv?=
 =?utf-8?B?YmR4Y3pleVFlUXFVZ1hhcGtnRWFwU1FiY0RlWk5qZlFZYWRyajhEUGVSNzNO?=
 =?utf-8?B?dlRodjVnMUdFQm10a2VvMzQxOEJtWlNKVzBmTXZjdmJnQ0xpbTFuaXFacXJN?=
 =?utf-8?B?OWdIcmxkdWVxZldIQUdhbGNvVDhMMU03M3dFb2o2TnpROU53NklhS2dwT3ky?=
 =?utf-8?B?TmpmUGJPcHYvUjc4RldReVJ2cG4xMkpEU3JweEh6NzVKdFNweEorZHRwaTVR?=
 =?utf-8?B?R0RhZkNXckRnR1hLcUVHdUxFa1ZLZVdiaWxqcjhWZXhjWkNIdXFTVHoyNlhH?=
 =?utf-8?B?MGxpWVhwQS9TUXBLejc0Y2NORDNFeWhha2pNd2xvUFdaU3hGOVR3Um82M0RD?=
 =?utf-8?B?UytwWCtVTWxXd09NTkFqekU4MVEyenJHQWJjZDZjMjVMTGVDOUpTeEw4QkJu?=
 =?utf-8?Q?SSnkUFL313WzpzNIpIZRnG+JZ?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2186c577-e3ed-4f02-80c4-08dcf3ff7b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 07:42:58.6986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ga6Hl6tDq3nn4jPqucfE8j8j2h+kxrVclaTMZbvvFknMhRz20gh4lvyFCyZJBTYFNz3Q/QwD7EkWoN6sNjj3Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI05bm0MTDm
nIgyM+aXpSAwOjU2DQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiBDYzoga3dAbGludXguY29tOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBscGllcmFsaXNpQGtlcm5l
bC5vcmc7IEZyYW5rIExpDQo+IDxmcmFuay5saUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25p
eC5kZTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBjb25vcitkdEBrZXJuZWwub3JnOyBzaGF3bmd1
b0BrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGZlc3Rl
dmFtQGdtYWlsLmNvbTsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsgbGludXgtcGNpQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
a2VybmVsQHBlbmd1dHJvbml4LmRlOyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjQgNC85XSBQQ0k6IGlteDY6IENvcnJlY3QgY29udHJvbGxlcl9pZCBnZW5lcmF0
aW9uIGxvZ2ljDQo+IGZvciBpLk1YN0QNCj4gDQo+IE9uIFR1ZSwgT2N0IDE1LCAyMDI0IGF0IDA0
OjMzOjI4UE0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IGkuTVg3RCBvbmx5IGhhcyBv
bmUgUENJZSBjb250cm9sbGVyLCBzbyBjb250cm9sbGVyX2lkIHNob3VsZCBhbHdheXMgYmUgMC4N
Cj4gPiBUaGUgcHJldmlvdXMgY29kZSBpcyBpbmNvcnJlY3QgYWx0aG91Z2ggeWllbGRpbmcgdGhl
IGNvcnJlY3QgcmVzdWx0Lg0KPiA+IEZpeCBieSByZW1vdmluZyBJTVg3RCBmcm9tIHRoZSBzd2l0
Y2ggY2FzZSBicmFuY2guDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9u
Z3hpbmcuemh1QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14
Ni5jIHwgMSAtDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGluZGV4IDJhZTZmYTRi
NWQzMi4uY2E4NzE0YzYyNWZlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2ktaW14Ni5jDQo+ID4gQEAgLTEzMzgsNyArMTMzOCw2IEBAIHN0YXRpYyBpbnQgaW14X3BjaWVf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPiAgCXN3aXRjaCAoaW14
X3BjaWUtPmRydmRhdGEtPnZhcmlhbnQpIHsNCj4gPiAgCWNhc2UgSU1YOE1ROg0KPiA+ICAJY2Fz
ZSBJTVg4TVFfRVA6DQo+ID4gLQljYXNlIElNWDdEOg0KPiA+ICAJCWlmIChkYmlfYmFzZS0+c3Rh
cnQgPT0gSU1YOE1RX1BDSUUyX0JBU0VfQUREUikNCj4gDQo+IFRoaXMgaXMganVzdCAqd3Jvbmcq
LiBZb3UgY2Fubm90IGhhcmRjb2RlIHRoZSBNTUlPIGFkZHJlc3MgaW4gdGhlIGRyaXZlci4NCj4g
RXZlbiB0aG91Z2ggdGhpcyBjb2RlIGlzIG9sZCwgeW91IHNob3VsZCBmaXggaXQgaW5zdGVhZCBv
ZiBidWlsZGluZyBvbiB0b3Agb2YgaXQuDQpIaSBNYW5pdmFubmFuOg0KVGhhbmtzIGZvciB5b3Vy
IGNvbW1lbnRzLg0KVG8gYXZvaWQgYnJlYWsgRFQgY29tcGF0aWJpbGl0eSwgYSBwcm9wZXIgbWV0
aG9kIHNob3VsZCBiZSBmaWd1cmVkIG91dCB0byBmaXgNCiB0aGUgaGFyZGNvZGUgaGVyZS4NCkJ1
dCBpdCBzaG91bGQgYmUgYW5vdGhlciBzdG9yeSwgaG93IGFib3V0IHRvIGFkZCB0aGlzIHRvIHRo
ZSBUTy1ETyBsaXN0LCBhbmQNCmlzc3VlIHRoZSBwYXRjaCBsYXRlcj8NCg0KQmVzdCBSZWdhcmRz
DQpSaWNoYXJkIFpodQ0KPiANCj4gLSBNYW5pDQo+IA0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPg
r43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=


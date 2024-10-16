Return-Path: <linux-pci+bounces-14606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2BE99FE78
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 03:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB247B24853
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 01:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C8142659;
	Wed, 16 Oct 2024 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Eb8qwRcg"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5D113C807;
	Wed, 16 Oct 2024 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043413; cv=fail; b=mGF8SPEngpok00ZA15iM2jpVZn3+OJFX3dI/iokQlQw95MuP/SoUUbWrXnjz1+P25M7tyWbHA29Ejp0gbTxUEnT+lz5kNBXU+jDHRChyTGRMP98QDA6cDu25fOHZZ6R7IHdx4w4jtl9qdOqPBgvwdXDKYizUJdNlAi3r8usW3qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043413; c=relaxed/simple;
	bh=qal+7cNuDxYY3RywD5h9KtOu2qVmmt5Sjx/XsxQby+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qTGHVoEDkKeYBLMWWDm0Yo0zMNH28ICzBPJVes7qTdNCXggbyaNViYwcSfORUOc33UTf4TjYe36O5/1/pp6l0sN5DXbgTEgjWXEX1KCogYplfD32cgQnSXnAc+UbsL0hWOgRKYYx/0hyvweJOYheYyh9NU9up8KX4ueZXEwpuO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Eb8qwRcg; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xk+LujRecj37hqkkzG735ZgYncG/osEAVu6iox/5y9waXlwrdU2luacg9zmuMvYnmXU0iWRw6u5FcqQD0JcKRaVrssQc1iVD4neS78Jd4MNQxz2v0Bjzg3n3U5PqQeEVwUSewgPQOXEhsF0CifCrKwafATYovQ2YKsb+Sm/14OvX6na5XSrt1ptpoE+Z9Myndt9r4PM1Q9otXGyl1f8TnbhCDaBNZSt4ThpgyLCbVEMeKoPI3XGujzUDHWZy2tjZjUhnQhOVrxIi6/e0LZZxX4FHOMyf+xKhtfqgD7oHqahZsQaIWlA5gawsPy2EEAwJVNlrCQsl/+nLtHg2XD/Y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qal+7cNuDxYY3RywD5h9KtOu2qVmmt5Sjx/XsxQby+c=;
 b=O0LFnFU3lSJutCpRFvEVFK0egT5RqGWD00MQivuNyIko75Sv8+9CNV9xvnOdYeSC+hR5pA2skhb//b70BBuNmWxjHFyhg5A54Nwt43+28jPxRM+9YPLABq80SqkZlKiG462TJp0U3yz5bje8s4+CSWkwexOqhdyseLG3DyOetcL31faP8qSooxl6tmnaY+x/W/hAYv7pr1lT67GSNTjc7SyoXUYXXD/6oMm1nJWjK3Nbx+tGwiTrYQbe2IwM09rj+ZITQ7TK2pwrrOVi08UzGd8usERP5vbXffnRWt0UXqL05MaHg31WdnkYRKgGr+JYBi0QArjwCXjP/1KTbLGTsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qal+7cNuDxYY3RywD5h9KtOu2qVmmt5Sjx/XsxQby+c=;
 b=Eb8qwRcgihLqnhfRzO2dLhxYr1mxilvOv5+cCd5ESQHZu25ZmBCcdhyHTF9rLlmaWQ5K5QhKJIUhszt2uXp8jBrJxLHcC5EuTgjxNp5JFTlZ8ntgPMK4rfCRYS5qfqg6KADHiHuMjuG95HzJFx3HD8eFM3U+9u7ePK1xw54/Ll4CRTqICuGwTvLoGNeEZAY2X/zfEQaVtdKj05Jq9o2Thmhs+dbpd7LSaKwEsVfVItSM/v5yCX3z2fdaR4YoPoGVw1qWDT43WX+G49sJ532lj0mKqxCNr51idU5oqCQNSrP3heF6BhjoublOPfrorp6fM6MpQOHC/53wFL+o9gz7IA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10092.eurprd04.prod.outlook.com (2603:10a6:800:22f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 01:50:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 01:50:08 +0000
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
Subject: RE: [PATCH v2 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Thread-Topic: [PATCH v2 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Thread-Index: AQHbHwQq4QKqZMQ9p0KkBhFIskuic7KIB4OAgACVwsA=
Date: Wed, 16 Oct 2024 01:50:08 +0000
Message-ID:
 <PAXPR04MB85103094C1F7ABB9FDC4EADF88462@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-11-wei.fang@nxp.com>
 <Zw6eD6/KG2ufNr/G@lizhi-Precision-Tower-5810>
In-Reply-To: <Zw6eD6/KG2ufNr/G@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB10092:EE_
x-ms-office365-filtering-correlation-id: d602b6c4-19a1-4ac2-5009-08dced84dd52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?RytQcXpDQmJoei9Kb05KVVYvSGtJeUhxZnpwaHVlK2s5V0QzSWRsa2l4b2px?=
 =?gb2312?B?QkhwdWxrUTlaTEJKc1NFN3lNaU1XOHAxSExJaEJaU0MvdUhja1JKaFZOV1FM?=
 =?gb2312?B?NmZjZVp3bHRwVmNBMG41eVhnZHpaZ056N0Z5emNXdzRSZEJVZDJscjVzenV5?=
 =?gb2312?B?RDdCeTJUYTNzR3cyUk5oUWhWWlRSM0xaMWliQUV2d1NOME9QOHRIODNrY2Yz?=
 =?gb2312?B?ZUgyUU9wUHhmbzRhWHV5VXliZCtrNkZ1TXZqZVF0MFI3QVg3ZzNJTmNHa0V3?=
 =?gb2312?B?dkhVVTVzNURTM3BuNHNlSzBBUEhvbGNKRnRtd2lDa01VWStwKytZU3R6Y2Nj?=
 =?gb2312?B?M2VzUHY3cGttamVWU1dQZ2JodWpmdm4yMmtPNkxqWktpMVNEYVJXeWVqQysz?=
 =?gb2312?B?U3FXUEdlS0ZqUkp5bU5za1RVNkV3MGN1WXZxRkI5MGUvaHppd1U5OGNmZ3Rz?=
 =?gb2312?B?KzFrZWd1MVlmZERwSWV1b2RFdE90SG1xZVpKRS80NWp3T0FTV1dBdGxZeEs2?=
 =?gb2312?B?MHlIRG8zM1BPOHFBL3F0bW5WVVl2cmVFL0lHZ2hKMXRzN2VqUGpZZk5uMGoz?=
 =?gb2312?B?VUFxajd6b3pwOXg5M3hBbHZ2WDdTL2psRXBlTnZlVUNUZlVmcXF2S0hBWnpY?=
 =?gb2312?B?Yi9iOEdzb3Avd0VUK2NiR3lHYWVCYitqSVA5eEhnZGJRbDFIZytrMThjZW1u?=
 =?gb2312?B?NTJ0VlVtUk4wQW0xRlkwa29vR2pjRm5xR2w2UVcwRjUzQ1oxSzZqSHVxVWFW?=
 =?gb2312?B?dHlQeW5qaXRlWSt1NVR4MEFOSnlOMkM2c2RGUWdTVDJRNGZlU2J0L0haT3VL?=
 =?gb2312?B?Z0RDUTh3VlBSRWF1dUZsZ1lHbldHUXdMaFg1UzFMQks0TmhBd016bEhZVXJn?=
 =?gb2312?B?Y0ovck11N3pNY3FhM0tiZ0JXUGhhd3NtaFVneVVZRm9zeUErZ0sxVkwzaW5W?=
 =?gb2312?B?S2ZYcGQzdjllOUtlcDEvYllRTWhycjE1eFBlSERBL1IzTWVvK2wrVlhFRXd3?=
 =?gb2312?B?LzlDY1hSaFhGaGtHN3pyQ3pZUzRQTDY2Y2l6QTJ5Z1dpWmhBWWMxZUdUVWxq?=
 =?gb2312?B?Y3MrRmxMMW1QSkU2YXhIRmlxUnZFZVc0K0owUVkwT0FaSm5FY3Izd2Z6Rk1O?=
 =?gb2312?B?UHR5dk5pSnBaaWl2Vm02aCt2OTVQMm9NMFJyQlVuNEgzY01GYXRxemgzeXJz?=
 =?gb2312?B?YzRCc091T1RyYnlvZmUxUG9UV3EzSFhNTWhiUlFWYytGOUpBU1VubzdSWmlG?=
 =?gb2312?B?YnF1UHpLZktxNXNBMkVwN0NrTUNOUitaNlg2UnArTlRFVHNGaXozb3VzWTFk?=
 =?gb2312?B?NXo4dThmZVdXVXVTYUdaWDczVHhod20vWEQxK1BEOFVmQWcxaTJuTTBXUjE3?=
 =?gb2312?B?UDd6elZZb1lucE1ZM05kQjRkZGZqL3J4U2VuSDdiZGtHYjZBMEswNzZGVm9a?=
 =?gb2312?B?KzF5ZitBWWdSdUJzdE9kMkxwK01uYldVWThQN09nVTZKK0ZnallvU2E0Z00x?=
 =?gb2312?B?c0VrbTg2NVNwYUpETS9VTkVtTUZrd1BpOS9pS2EwbTNOVzFsYVZoajEzT2VR?=
 =?gb2312?B?QmhHSkJ4aU9rYjNqbmtSRHMwaTl6Y1IrM0Z1U2FhMW1NZXp4YmpkRVIxK2Q5?=
 =?gb2312?B?WEdXVHFIZzRUeFRRRThtanIzZnlLUDFpc2V4clE4SUNmL0Y0UWlDZHhtYjJu?=
 =?gb2312?B?NGNKMHQ0TEJmeCs1VFQ5VDRVaWh6Z3RzVmYvbkRHeTA2b2Q4TnhnV3ZXVW9C?=
 =?gb2312?B?RW12YTBlVHJ1Z2RqSDhmSkF2OTE4djFRcTVSOHIwWjR1TS9WWXgvdXN6OWtv?=
 =?gb2312?B?Mnc0bXdCWkFLWHJscnVjZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bmVPUy9INys4OUlGeGNBNjNDS1pCVk1lakEyRVNOZEFzb0R0Z1gxRHh3YUc5?=
 =?gb2312?B?Z25rWHMrM3lBRkkzLzN2d0t5Ylk4RnFyM0lKRW5saU9wOFdYMGtqcm1nNDZt?=
 =?gb2312?B?dVlrY0c0V1c0UnlRcEkwWFpHdS9oREZyL253U2JKN05MOGllWU1lODBTSEhM?=
 =?gb2312?B?VksyazhnU3hlSGtnOVc3WHE0eW5VTGhMYTY5N0RoSWZXRVNHc3M4OFVZNy94?=
 =?gb2312?B?Qmp3SFFxOW1FemxESmkwVEhvaG5QUm1qeW0zWVhkeFVOa3cwdmMxOUh5bk53?=
 =?gb2312?B?K1R3L2hTdFFxbk1SZWFLRHNVMkEzTXZUSjFVZGxkaUtSU0cxZ3I1ckxZZUg2?=
 =?gb2312?B?NXJLMVRzb21BdkxWNzlXdmhsaWtpRWp0UzJXOWl3MnYvUi9sNUxRZk92R3cv?=
 =?gb2312?B?SmVET2xobWdkcE1wU0VnZUNtbkdCQTJNemNCbXpndE9CZ0tJN1BTUVc0TFVp?=
 =?gb2312?B?ZnNKcytPK3lkZW11ZmFkUGdnc1VsdVFNRkhiQk90bG5oUXRvdXBlNTd1ckR3?=
 =?gb2312?B?eVQxc1RydEE4c3lTNmQ1REpWT3RmZ0JtL0E2Mmw3UFVmVFJCTCtLWS9HWDU3?=
 =?gb2312?B?U3lDeWZwaEc5bzR6ZjhyMEFIVTluekVLTVNwcDNQYmVJeEE5RkNkdE5Md0Vq?=
 =?gb2312?B?d0owZVUyQ2J6cjBkVVFpY28xSTRuUGd5bzZnM1o0NWY0V21uZzEzVDg2eGZM?=
 =?gb2312?B?YU1xdEp2Q2xKVlA1MlZMNktoUkJvOWptN1hhLzVpa2FROGkwWkxyOWF3Zks3?=
 =?gb2312?B?dGgvbjJ5N2RwMG96cGdTZzZMVmpGTXprbVkxOWFXNHZpYmorVlMyRkttZUR1?=
 =?gb2312?B?QkxOSU9JejBPeGg1REFiS2ZYdmswSGE4U0xqakNraEluSzRDdHN5T2JZTS9E?=
 =?gb2312?B?dkxaR1pkcEcvTU9YMDVNYzlGTW54UVJxRkszRWtwUk9oYUVaaWlWT1BWdjZs?=
 =?gb2312?B?RmdVWTIzeHYxNW5MRitnbHl4L2cwdzNxVXBjUU9kSXZvN3FYczRtQ2NWeFVH?=
 =?gb2312?B?QmQzRElEdk45L21oRkJRbHFxUGZJNWR5VkZSQmFEeHplQjA0bHpIM0NybFFE?=
 =?gb2312?B?TVI3M0lrN1dseFZ1dXRsNWExeTZLaklxeGYxT3libzFteE9vZk9qeStvUGU0?=
 =?gb2312?B?ZUVKOXozY3BoNll4MzdsTTlvUm5CR24yQ3h1bFI0WVVEL0pUQmFRRVJoUUZG?=
 =?gb2312?B?SVBOR3RJaTc3bnVKektiM2o0U3QvMXF2VzRGUnJLckxwNnpjSVAzUUhKRGZX?=
 =?gb2312?B?MVp4OUVWZyswK1lINmJiZ21hU2FzRGRTTmhham9FNFlJbk9zRFRkOE9mTzlC?=
 =?gb2312?B?RXhkM29FVnAzMVJ1ekcwYnpSS3ZEQjliZ3RNZFpxN0lFMTNBVUhvVE03a1B1?=
 =?gb2312?B?ajBBNFZMVDN1MjJaQlArV0d0NHA5ei8wTkl3TTFITG5lSmdCRVl0SkM0WnVt?=
 =?gb2312?B?czF1ZHRteGMzdnRnK1hFZk8wNGRvbUJrOXRreEU4N3JNVFJDcS9MRGZOaFl5?=
 =?gb2312?B?VG4yNlp3MDdwRWorSFA3dFByM0JMVHdxRUxGN0c5QUd1M1IzZG1IbkdJclNI?=
 =?gb2312?B?dTc3OU9Wc0N4YU55a2t0aUZML0tldG01Yk9vZ1JlclJwK3RvbUlXV3FLZWlF?=
 =?gb2312?B?TkpacGFYSUcrelEvMjBhOW5yMEZrMEJVOFRXL29NWVRTQkg3SU1CKzhxL0Y1?=
 =?gb2312?B?ZDBEOS85dm9yUHBuWWNnM09ZUVFlQy9GaEZqdzJFVDRDb3k2UVptcEpQK1U2?=
 =?gb2312?B?eDVqZUpOODJKQWpibSt1M2sxbml2QmVGVmV2a3RYTmYrRmxCWHY1TVR4KzBO?=
 =?gb2312?B?L2RZL1oybWkyT1dOVjJycmZLR1hzeTd3WkNlRjhRTzRaNFNiQVFRZ0JpWFhY?=
 =?gb2312?B?TmwxR0RjRVRoWURrRUF0Qk4vb050SWwwd3R4SlVyZzVCZTBwa2FVamRQWDV3?=
 =?gb2312?B?QWJQVmJkMGduOTl5eW5xeU85NWoxT2xuRWlpOGVvTGY3WDZSVGFpVkhwb2lU?=
 =?gb2312?B?cFVkZFY1MmtYbDBmRUhyUTZSOE1IazZmS1Y1NnRJL08zRDdERHRHZVdKR0JY?=
 =?gb2312?B?MmdJbVd5Z0JhbGFpTHlHU0xPT3FwMDlyZW84UGlkV1VQKzdVWjFuL004N1Rj?=
 =?gb2312?Q?P07w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d602b6c4-19a1-4ac2-5009-08dced84dd52
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 01:50:08.4018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yATeJRiyNlenpB8/YPIoFgCFJkV7tl8gl75/4aaqAADqVMK5X98v4vbIK7qh342XtWgJVlqvbGBRjFFvA/nTUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10092

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjE2yNUgMDo1NA0KPiBUbzogV2VpIEZhbmcgPHdl
aS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29n
bGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyByb2JoQGtlcm5l
bC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgVmxhZGlt
aXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47IENsYXVkaXUNCj4gTWFub2lsIDxj
bGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29t
PjsNCj4gY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1OyBsaW51eEBhcm1saW51eC5vcmcudWs7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGhvcm1zQGtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51
eC5kZXY7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgbmV0LW5leHQgMTAvMTNdIG5ldDogZW5l
dGM6IGV4dHJhY3QNCj4gZW5ldGNfaW50X3ZlY3Rvcl9pbml0L2Rlc3Ryb3koKSBmcm9tIGVuZXRj
X2FsbG9jX21zaXgoKQ0KPiANCj4gT24gVHVlLCBPY3QgMTUsIDIwMjQgYXQgMDg6NTg6MzhQTSAr
MDgwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gRnJvbTogQ2xhcmsgV2FuZyA8eGlhb25pbmcud2Fu
Z0BueHAuY29tPg0KPiA+DQo+ID4gRXh0cmFjdCBlbmV0Y19pbnRfdmVjdG9yX2luaXQoKSBhbmQg
ZW5ldGNfaW50X3ZlY3Rvcl9kZXN0cm95KCkgZnJvbQ0KPiA+IGVuZXRjX2FsbG9jX21zaXgoKSBz
byB0aGF0IHRoZSBjb2RlIGlzIG1vcmUgY29uY2lzZSBhbmQgcmVhZGFibGUuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gdjIg
Y2hhbmdlczoNCj4gPiBUaGlzIHBhdGNoIGlzIHNlcGFyYXRlZCBmcm9tIHYxIHBhdGNoIDkgKCJu
ZXQ6IGVuZXRjOiBvcHRpbWl6ZSB0aGUNCj4gPiBhbGxvY2F0aW9uIG9mIHR4X2JkciIpLiBTZXBh
cmF0ZSBlbmV0Y19pbnRfdmVjdG9yX2luaXQoKSBmcm9tIHRoZQ0KPiA+IG9yaWdpbmFsIHBhdGNo
LiBJbiBhZGRpdGlvbiwgYWRkIG5ldyBoZWxwIGZ1bmN0aW9uDQo+ID4gZW5ldGNfaW50X3ZlY3Rv
cl9kZXN0cm95KCkuDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2Fs
ZS9lbmV0Yy9lbmV0Yy5jIHwgMTc0DQo+ID4gKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgODcgaW5zZXJ0aW9ucygrKSwgODcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmMN
Cj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jDQo+ID4g
aW5kZXggMDMyZDhlYWRkMDAzLi5kMzZhZjNmOGJhMzEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmMNCj4gPiArKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+IEBAIC0yOTY1LDYgKzI5
NjUsODcgQEAgaW50IGVuZXRjX2lvY3RsKHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2LCBzdHJ1Y3QN
Cj4gPiBpZnJlcSAqcnEsIGludCBjbWQpICB9ICBFWFBPUlRfU1lNQk9MX0dQTChlbmV0Y19pb2N0
bCk7DQo+ID4NCj4gPiArc3RhdGljIGludCBlbmV0Y19pbnRfdmVjdG9yX2luaXQoc3RydWN0IGVu
ZXRjX25kZXZfcHJpdiAqcHJpdiwgaW50IGksDQo+ID4gKwkJCQkgaW50IHZfdHhfcmluZ3MpDQo+
ID4gK3sNCj4gPiArCXN0cnVjdCBlbmV0Y19pbnRfdmVjdG9yICp2IF9fZnJlZShrZnJlZSk7DQo+
IA0KPiBPbGQgY29kZSBoYXZlIG5vdCB1c2UgY2xlYW51cC4gUGxlYXNlIGtlZXAgZXhhY3Qgc2Ft
ZSBhcyBvbGQgY29kZXMuDQo+IE9yIHlvdSBzaG91bGQgbWVudGlvbiBhdCBjb21taXQgbG9nIGF0
IGxlYXN0Lg0KPiANCk9rYXksIEkgd2lsbCBtZW50aW9uIGl0IGF0IHRoZSBjb21taXQgbWVzc2Fn
ZS4NCj4gDQo+ID4gKwlzdHJ1Y3QgZW5ldGNfYmRyICpiZHI7DQo+ID4gKwlpbnQgaiwgZXJyOw0K
PiA+ICsNCj4gPiArCXYgPSBremFsbG9jKHN0cnVjdF9zaXplKHYsIHR4X3JpbmcsIHZfdHhfcmlu
Z3MpLCBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghdikNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsN
Cj4gPiArDQo+ID4gKwliZHIgPSAmdi0+cnhfcmluZzsNCj4gPiArCWJkci0+aW5kZXggPSBpOw0K
PiA+ICsJYmRyLT5uZGV2ID0gcHJpdi0+bmRldjsNCj4gPiArCWJkci0+ZGV2ID0gcHJpdi0+ZGV2
Ow0KPiA+ICsJYmRyLT5iZF9jb3VudCA9IHByaXYtPnJ4X2JkX2NvdW50Ow0KPiA+ICsJYmRyLT5i
dWZmZXJfb2Zmc2V0ID0gRU5FVENfUlhCX1BBRDsNCj4gPiArCXByaXYtPnJ4X3JpbmdbaV0gPSBi
ZHI7DQo+ID4gKw0KPiA+ICsJZXJyID0geGRwX3J4cV9pbmZvX3JlZygmYmRyLT54ZHAucnhxLCBw
cml2LT5uZGV2LCBpLCAwKTsNCj4gPiArCWlmIChlcnIpDQo+ID4gKwkJcmV0dXJuIGVycjsNCj4g
PiArDQo+ID4gKwllcnIgPSB4ZHBfcnhxX2luZm9fcmVnX21lbV9tb2RlbCgmYmRyLT54ZHAucnhx
LA0KPiA+ICsJCQkJCSBNRU1fVFlQRV9QQUdFX1NIQVJFRCwgTlVMTCk7DQo+ID4gKwlpZiAoZXJy
KSB7DQo+ID4gKwkJeGRwX3J4cV9pbmZvX3VucmVnKCZiZHItPnhkcC5yeHEpOw0KPiA+ICsJCXJl
dHVybiBlcnI7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJLyogaW5pdCBkZWZhdWx0cyBmb3IgYWRh
cHRpdmUgSUMgKi8NCj4gPiArCWlmIChwcml2LT5pY19tb2RlICYgRU5FVENfSUNfUlhfQURBUFRJ
VkUpIHsNCj4gPiArCQl2LT5yeF9pY3R0ID0gMHgxOw0KPiA+ICsJCXYtPnJ4X2RpbV9lbiA9IHRy
dWU7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJSU5JVF9XT1JLKCZ2LT5yeF9kaW0ud29yaywgZW5l
dGNfcnhfZGltX3dvcmspOw0KPiA+ICsJbmV0aWZfbmFwaV9hZGQocHJpdi0+bmRldiwgJnYtPm5h
cGksIGVuZXRjX3BvbGwpOw0KPiA+ICsJdi0+Y291bnRfdHhfcmluZ3MgPSB2X3R4X3JpbmdzOw0K
PiA+ICsNCj4gPiArCWZvciAoaiA9IDA7IGogPCB2X3R4X3JpbmdzOyBqKyspIHsNCj4gPiArCQlp
bnQgaWR4Ow0KPiA+ICsNCj4gPiArCQkvKiBkZWZhdWx0IHR4IHJpbmcgbWFwcGluZyBwb2xpY3kg
Ki8NCj4gPiArCQlpZHggPSBwcml2LT5iZHJfaW50X251bSAqIGogKyBpOw0KPiA+ICsJCV9fc2V0
X2JpdChpZHgsICZ2LT50eF9yaW5nc19tYXApOw0KPiA+ICsJCWJkciA9ICZ2LT50eF9yaW5nW2pd
Ow0KPiA+ICsJCWJkci0+aW5kZXggPSBpZHg7DQo+ID4gKwkJYmRyLT5uZGV2ID0gcHJpdi0+bmRl
djsNCj4gPiArCQliZHItPmRldiA9IHByaXYtPmRldjsNCj4gPiArCQliZHItPmJkX2NvdW50ID0g
cHJpdi0+dHhfYmRfY291bnQ7DQo+ID4gKwkJcHJpdi0+dHhfcmluZ1tpZHhdID0gYmRyOw0KPiA+
ICsJfQ0KPiA+ICsNCj4gPiArCXByaXYtPmludF92ZWN0b3JbaV0gPSBub19mcmVlX3B0cih2KTsN
Cj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQg
ZW5ldGNfaW50X3ZlY3Rvcl9kZXN0cm95KHN0cnVjdCBlbmV0Y19uZGV2X3ByaXYgKnByaXYsDQo+
ID4gK2ludCBpKSB7DQo+ID4gKwlzdHJ1Y3QgZW5ldGNfaW50X3ZlY3RvciAqdiA9IHByaXYtPmlu
dF92ZWN0b3JbaV07DQo+ID4gKwlzdHJ1Y3QgZW5ldGNfYmRyICpyeF9yaW5nID0gJnYtPnJ4X3Jp
bmc7DQo+ID4gKwlpbnQgaiwgdHhfcmluZ19pbmRleDsNCj4gPiArDQo+ID4gKwl4ZHBfcnhxX2lu
Zm9fdW5yZWdfbWVtX21vZGVsKCZyeF9yaW5nLT54ZHAucnhxKTsNCj4gPiArCXhkcF9yeHFfaW5m
b191bnJlZygmcnhfcmluZy0+eGRwLnJ4cSk7DQo+ID4gKwluZXRpZl9uYXBpX2RlbCgmdi0+bmFw
aSk7DQo+ID4gKwljYW5jZWxfd29ya19zeW5jKCZ2LT5yeF9kaW0ud29yayk7DQo+ID4gKw0KPiA+
ICsJcHJpdi0+cnhfcmluZ1tpXSA9IE5VTEw7DQo+ID4gKw0KPiA+ICsJZm9yIChqID0gMDsgaiA8
IHYtPmNvdW50X3R4X3JpbmdzOyBqKyspIHsNCj4gPiArCQl0eF9yaW5nX2luZGV4ID0gcHJpdi0+
YmRyX2ludF9udW0gKiBqICsgaTsNCj4gPiArCQlwcml2LT50eF9yaW5nW3R4X3JpbmdfaW5kZXhd
ID0gTlVMTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlrZnJlZSh2KTsNCj4gPiArCXByaXYtPmlu
dF92ZWN0b3JbaV0gPSBOVUxMOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBpbnQgZW5ldGNfYWxsb2Nf
bXNpeChzdHJ1Y3QgZW5ldGNfbmRldl9wcml2ICpwcml2KSAgew0KPiA+ICAJc3RydWN0IHBjaV9k
ZXYgKnBkZXYgPSBwcml2LT5zaS0+cGRldjsgQEAgLTI5ODYsNjQgKzMwNjcsOSBAQCBpbnQNCj4g
PiBlbmV0Y19hbGxvY19tc2l4KHN0cnVjdCBlbmV0Y19uZGV2X3ByaXYgKnByaXYpDQo+ID4gIAkv
KiAjIG9mIHR4IHJpbmdzIHBlciBpbnQgdmVjdG9yICovDQo+ID4gIAl2X3R4X3JpbmdzID0gcHJp
di0+bnVtX3R4X3JpbmdzIC8gcHJpdi0+YmRyX2ludF9udW07DQo+ID4NCj4gPiAtCWZvciAoaSA9
IDA7IGkgPCBwcml2LT5iZHJfaW50X251bTsgaSsrKSB7DQo+ID4gLQkJc3RydWN0IGVuZXRjX2lu
dF92ZWN0b3IgKnY7DQo+ID4gLQkJc3RydWN0IGVuZXRjX2JkciAqYmRyOw0KPiA+IC0JCWludCBq
Ow0KPiA+IC0NCj4gPiAtCQl2ID0ga3phbGxvYyhzdHJ1Y3Rfc2l6ZSh2LCB0eF9yaW5nLCB2X3R4
X3JpbmdzKSwgR0ZQX0tFUk5FTCk7DQo+ID4gLQkJaWYgKCF2KSB7DQo+ID4gLQkJCWVyciA9IC1F
Tk9NRU07DQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgcHJpdi0+YmRyX2ludF9udW07IGkrKykNCj4g
PiArCQlpZiAoZW5ldGNfaW50X3ZlY3Rvcl9pbml0KHByaXYsIGksIHZfdHhfcmluZ3MpKQ0KPiA+
ICAJCQlnb3RvIGZhaWw7DQo+ID4gLQkJfQ0KPiA+IC0NCj4gPiAtCQlwcml2LT5pbnRfdmVjdG9y
W2ldID0gdjsNCj4gPiAtDQo+ID4gLQkJYmRyID0gJnYtPnJ4X3Jpbmc7DQo+ID4gLQkJYmRyLT5p
bmRleCA9IGk7DQo+ID4gLQkJYmRyLT5uZGV2ID0gcHJpdi0+bmRldjsNCj4gPiAtCQliZHItPmRl
diA9IHByaXYtPmRldjsNCj4gPiAtCQliZHItPmJkX2NvdW50ID0gcHJpdi0+cnhfYmRfY291bnQ7
DQo+ID4gLQkJYmRyLT5idWZmZXJfb2Zmc2V0ID0gRU5FVENfUlhCX1BBRDsNCj4gPiAtCQlwcml2
LT5yeF9yaW5nW2ldID0gYmRyOw0KPiA+IC0NCj4gPiAtCQllcnIgPSB4ZHBfcnhxX2luZm9fcmVn
KCZiZHItPnhkcC5yeHEsIHByaXYtPm5kZXYsIGksIDApOw0KPiA+IC0JCWlmIChlcnIpIHsNCj4g
PiAtCQkJa2ZyZWUodik7DQo+ID4gLQkJCWdvdG8gZmFpbDsNCj4gPiAtCQl9DQo+ID4gLQ0KPiA+
IC0JCWVyciA9IHhkcF9yeHFfaW5mb19yZWdfbWVtX21vZGVsKCZiZHItPnhkcC5yeHEsDQo+ID4g
LQkJCQkJCSBNRU1fVFlQRV9QQUdFX1NIQVJFRCwgTlVMTCk7DQo+ID4gLQkJaWYgKGVycikgew0K
PiA+IC0JCQl4ZHBfcnhxX2luZm9fdW5yZWcoJmJkci0+eGRwLnJ4cSk7DQo+ID4gLQkJCWtmcmVl
KHYpOw0KPiA+IC0JCQlnb3RvIGZhaWw7DQo+ID4gLQkJfQ0KPiA+IC0NCj4gPiAtCQkvKiBpbml0
IGRlZmF1bHRzIGZvciBhZGFwdGl2ZSBJQyAqLw0KPiA+IC0JCWlmIChwcml2LT5pY19tb2RlICYg
RU5FVENfSUNfUlhfQURBUFRJVkUpIHsNCj4gPiAtCQkJdi0+cnhfaWN0dCA9IDB4MTsNCj4gPiAt
CQkJdi0+cnhfZGltX2VuID0gdHJ1ZTsNCj4gPiAtCQl9DQo+ID4gLQkJSU5JVF9XT1JLKCZ2LT5y
eF9kaW0ud29yaywgZW5ldGNfcnhfZGltX3dvcmspOw0KPiA+IC0JCW5ldGlmX25hcGlfYWRkKHBy
aXYtPm5kZXYsICZ2LT5uYXBpLCBlbmV0Y19wb2xsKTsNCj4gPiAtCQl2LT5jb3VudF90eF9yaW5n
cyA9IHZfdHhfcmluZ3M7DQo+ID4gLQ0KPiA+IC0JCWZvciAoaiA9IDA7IGogPCB2X3R4X3Jpbmdz
OyBqKyspIHsNCj4gPiAtCQkJaW50IGlkeDsNCj4gPiAtDQo+ID4gLQkJCS8qIGRlZmF1bHQgdHgg
cmluZyBtYXBwaW5nIHBvbGljeSAqLw0KPiA+IC0JCQlpZHggPSBwcml2LT5iZHJfaW50X251bSAq
IGogKyBpOw0KPiA+IC0JCQlfX3NldF9iaXQoaWR4LCAmdi0+dHhfcmluZ3NfbWFwKTsNCj4gPiAt
CQkJYmRyID0gJnYtPnR4X3Jpbmdbal07DQo+ID4gLQkJCWJkci0+aW5kZXggPSBpZHg7DQo+ID4g
LQkJCWJkci0+bmRldiA9IHByaXYtPm5kZXY7DQo+ID4gLQkJCWJkci0+ZGV2ID0gcHJpdi0+ZGV2
Ow0KPiA+IC0JCQliZHItPmJkX2NvdW50ID0gcHJpdi0+dHhfYmRfY291bnQ7DQo+ID4gLQkJCXBy
aXYtPnR4X3JpbmdbaWR4XSA9IGJkcjsNCj4gPiAtCQl9DQo+ID4gLQl9DQo+ID4NCj4gPiAgCW51
bV9zdGFja190eF9xdWV1ZXMgPSBlbmV0Y19udW1fc3RhY2tfdHhfcXVldWVzKHByaXYpOw0KPiA+
DQo+ID4gQEAgLTMwNjIsMTYgKzMwODgsOCBAQCBpbnQgZW5ldGNfYWxsb2NfbXNpeChzdHJ1Y3Qg
ZW5ldGNfbmRldl9wcml2DQo+ICpwcml2KQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4NCj4gPiAgZmFp
bDoNCj4gPiAtCXdoaWxlIChpLS0pIHsNCj4gPiAtCQlzdHJ1Y3QgZW5ldGNfaW50X3ZlY3RvciAq
diA9IHByaXYtPmludF92ZWN0b3JbaV07DQo+ID4gLQkJc3RydWN0IGVuZXRjX2JkciAqcnhfcmlu
ZyA9ICZ2LT5yeF9yaW5nOw0KPiA+IC0NCj4gPiAtCQl4ZHBfcnhxX2luZm9fdW5yZWdfbWVtX21v
ZGVsKCZyeF9yaW5nLT54ZHAucnhxKTsNCj4gPiAtCQl4ZHBfcnhxX2luZm9fdW5yZWcoJnJ4X3Jp
bmctPnhkcC5yeHEpOw0KPiA+IC0JCW5ldGlmX25hcGlfZGVsKCZ2LT5uYXBpKTsNCj4gPiAtCQlj
YW5jZWxfd29ya19zeW5jKCZ2LT5yeF9kaW0ud29yayk7DQo+ID4gLQkJa2ZyZWUodik7DQo+ID4g
LQl9DQo+ID4gKwl3aGlsZSAoaS0tKQ0KPiA+ICsJCWVuZXRjX2ludF92ZWN0b3JfZGVzdHJveShw
cml2LCBpKTsNCj4gPg0KPiA+ICAJcGNpX2ZyZWVfaXJxX3ZlY3RvcnMocGRldik7DQo+ID4NCj4g
PiBAQCAtMzA4MywyNiArMzEwMSw4IEBAIHZvaWQgZW5ldGNfZnJlZV9tc2l4KHN0cnVjdCBlbmV0
Y19uZGV2X3ByaXYNCj4gPiAqcHJpdikgIHsNCj4gPiAgCWludCBpOw0KPiA+DQo+ID4gLQlmb3Ig
KGkgPSAwOyBpIDwgcHJpdi0+YmRyX2ludF9udW07IGkrKykgew0KPiA+IC0JCXN0cnVjdCBlbmV0
Y19pbnRfdmVjdG9yICp2ID0gcHJpdi0+aW50X3ZlY3RvcltpXTsNCj4gPiAtCQlzdHJ1Y3QgZW5l
dGNfYmRyICpyeF9yaW5nID0gJnYtPnJ4X3Jpbmc7DQo+ID4gLQ0KPiA+IC0JCXhkcF9yeHFfaW5m
b191bnJlZ19tZW1fbW9kZWwoJnJ4X3JpbmctPnhkcC5yeHEpOw0KPiA+IC0JCXhkcF9yeHFfaW5m
b191bnJlZygmcnhfcmluZy0+eGRwLnJ4cSk7DQo+ID4gLQkJbmV0aWZfbmFwaV9kZWwoJnYtPm5h
cGkpOw0KPiA+IC0JCWNhbmNlbF93b3JrX3N5bmMoJnYtPnJ4X2RpbS53b3JrKTsNCj4gPiAtCX0N
Cj4gPiAtDQo+ID4gLQlmb3IgKGkgPSAwOyBpIDwgcHJpdi0+bnVtX3J4X3JpbmdzOyBpKyspDQo+
ID4gLQkJcHJpdi0+cnhfcmluZ1tpXSA9IE5VTEw7DQo+ID4gLQ0KPiA+IC0JZm9yIChpID0gMDsg
aSA8IHByaXYtPm51bV90eF9yaW5nczsgaSsrKQ0KPiA+IC0JCXByaXYtPnR4X3JpbmdbaV0gPSBO
VUxMOw0KPiA+IC0NCj4gPiAtCWZvciAoaSA9IDA7IGkgPCBwcml2LT5iZHJfaW50X251bTsgaSsr
KSB7DQo+ID4gLQkJa2ZyZWUocHJpdi0+aW50X3ZlY3RvcltpXSk7DQo+ID4gLQkJcHJpdi0+aW50
X3ZlY3RvcltpXSA9IE5VTEw7DQo+ID4gLQl9DQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgcHJpdi0+
YmRyX2ludF9udW07IGkrKykNCj4gPiArCQllbmV0Y19pbnRfdmVjdG9yX2Rlc3Ryb3kocHJpdiwg
aSk7DQo+ID4NCj4gPiAgCS8qIGRpc2FibGUgYWxsIE1TSVggZm9yIHRoaXMgZGV2aWNlICovDQo+
ID4gIAlwY2lfZnJlZV9pcnFfdmVjdG9ycyhwcml2LT5zaS0+cGRldik7DQo+ID4gLS0NCj4gPiAy
LjM0LjENCj4gPg0K


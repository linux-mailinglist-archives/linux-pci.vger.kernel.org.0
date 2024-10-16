Return-Path: <linux-pci+bounces-14601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA64099FE2A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 03:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09AAD1C2091B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 01:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256D781ADA;
	Wed, 16 Oct 2024 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tt/A/ifm"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2048.outbound.protection.outlook.com [40.107.105.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0C101C4;
	Wed, 16 Oct 2024 01:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041776; cv=fail; b=RXCU02m/X5Dok2ixNt4/U/9ViiZfm/akGmorAYl6eousH8rYcV7IrD31xgcavfn9oU75p8iG27gQx9YsGbIyOTuNxGXpeJX3njBNXiKdXzRPzv6ST61qO+YGDyDrbCV/p3LnhgZw98+S/wQEJWevoPAMWIBEb9VCJLcP9/wqWGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041776; c=relaxed/simple;
	bh=Khg2PZEMqR/4PNA+S9zRpxEt+1i1ltXu0YUdKtULh08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WVCUT4C7Zt/0KhIaDyU/Q5Yr7igfuXVhA7s1P2swjVzTW03sSiBJiUYiFtMU59VBfqgVNlsJIJloVeV+oIvEit0i3kpFxLAoM6o+KzG1Fodq+xQp8fLSd5Jvpgo0CaguXVZbG0zWeK2Y2qscSuUdct/ecrwIi/A+mQKCg8ScYqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tt/A/ifm; arc=fail smtp.client-ip=40.107.105.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXiOSBpWKtEp9sMi2RTL5mNPOGQgPDaI4QVPWKnrUcV36tWEK1aofboH1u5ZYGCksRpmVx7y0zrthrx9QJcW/SpZIf7x162X0JyfYReAitdDkxykr6+zfpP3VHvfcRFhx96LywaNw2y7YkTGUyb/IrrMgGZasagxQN2owpeeNkv1D2xVzQBxiSvL71wkoYSdpy0W4qWnpU+1npdC0CCCRFYfr+sLy1M4bIL94Us0pYDmyvIjsxVfTfexeZBBTcJopqDExHF8hK3/0ZYY6pWUoZZn5NJYpKu6V3dYegiVQURHgnJi5kU/KZawFI+UU/doqPJfdNPRWY8tmRQjyw4alA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Khg2PZEMqR/4PNA+S9zRpxEt+1i1ltXu0YUdKtULh08=;
 b=d19CMHGqQxZofcgmNNKf+Cd+O3SuR5gaLwQws2cm0WwuWmf89cz0GVxjqKoCsbU4F6fCazTv6davD79lNWJgezMsRh0I5ZEil5T9zXJMxJuqRWoiXixy3WgyU9kD1JCK1VpZOO62RET9fhLbBbsr0YrUhDiG7EaEyF9xE0bkzXTcXnLMv9XuG4JFb2exzAtAZb1CGw85dqGA0vZzM5eOQcahJgaFke+aSLbyC4fnW7ND9/xDhm8RW9RaUAk2EdzfGwwm1nVmjc5jAQOduQiS6NbO6+KEy/lxG7/uLF9NMpqfGX1V0Z7U/sHpvH5TwGuQAyTwECcT62iMU/x4c8iMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Khg2PZEMqR/4PNA+S9zRpxEt+1i1ltXu0YUdKtULh08=;
 b=Tt/A/ifmSkmPSS6I453+rsW1VAR5UpsXyDl3+qzpXCpLmqIVuH1ka61fXxsLjPd27Zp2LTzCh8kccDtGPTW8lLX+8RhEbUrcwOSJtTk5aCet2W0LYDUP4AKA7zHHjdazf7TlMLdR2PHcKRwh4QMZH0DfLMwXn34HRTdRmE8fJ5s3hrC8AvCgK6sLYpWTb8tWhJvv2kVzZDbU0d15CnX+I/RxWwcDExDpii0v6lwNzXnn7WNQax+jG3r1kKH2C76wIwjMgW+s4A0ygV8ZqHeFcNCKzVKyvCYVigqFkK6S0DOTheza3+E9Jeglg3Usjl3hXRKpLL74k+Qe+hmBtNfimg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9719.eurprd04.prod.outlook.com (2603:10a6:102:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Wed, 16 Oct
 2024 01:22:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 01:22:50 +0000
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
Subject: RE: [PATCH v2 net-next 03/13] dt-bindings: net: add bindings for NETC
 blocks control
Thread-Topic: [PATCH v2 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Thread-Index: AQHbHwQTwv6rid1NsUWySy5OdGop9LKH9GCAgAChLvA=
Date: Wed, 16 Oct 2024 01:22:50 +0000
Message-ID:
 <PAXPR04MB85108B497E42E63DC81D9FF388462@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-4-wei.fang@nxp.com>
 <Zw6OAVT10JrnFkSO@lizhi-Precision-Tower-5810>
In-Reply-To: <Zw6OAVT10JrnFkSO@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAWPR04MB9719:EE_
x-ms-office365-filtering-correlation-id: f0659860-dab9-4b46-2182-08dced810d4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?dnFzQjVWRFJVV2dPTzc4eXFhOFg3VkNmZERhSEE1d0xqcml0ekc0SVZuZ2xG?=
 =?gb2312?B?bXhsSnpQWEVMWFcweXUvRHlwaWlSVmJoZlhNREdoQjY5Z2gycmkyWWs0NnlO?=
 =?gb2312?B?RWVVMVdjV0xoVWJDc2FudEo1cGp2dGR2WkZRN3h2QktqNERFZUlia2JNemtN?=
 =?gb2312?B?UnBoTFZFTnVSV1hFUVFKekdLMWlSV1BodUt0eHQwQTFWRGpwUCt3eGFnMHI4?=
 =?gb2312?B?MFZIK1VhODBVblhiMWs1SHRXWXM4Q3FUN2VEaDQ1M0tTV2dxWDVyeDNHU1Vt?=
 =?gb2312?B?UGxiaStOMm1KYTJXcVVuKzBGdXZDV2VjV1NOUDV5eFRTUVBleTBCTFEwS21V?=
 =?gb2312?B?QnFKT2xKTTJFRmF0Uld6Zk5tNGRJbWdGdlpRekxPRng4OVpWM1NPcFZqZ2Ru?=
 =?gb2312?B?U2xsSFdSTm5iQXJLVHBXY3F5VkdIdko3K21pTmJlOEtUYzZ3dGZDTzZPNVBv?=
 =?gb2312?B?QkZjMEpyM29Wcjc1b1lxZ0VNd1pGNVN6VU83QjZOVjZmTWlvbXkyZS9jZ3lV?=
 =?gb2312?B?ajVVSTQvMFA2cUxEbkRCY0UyVGVaVDBMVU5yYVJFZzFuOW5NQnU2aC9JWW12?=
 =?gb2312?B?bkRMZHM0SVhkSTBDdXBzWUk0RWRYMlAwZU9NSVp1Nm5nTC9ZRE1xTTZzWkdD?=
 =?gb2312?B?c1BvV216WHRnOUN3N29rRGVZN0pjdS9rZStuclFVbldETHlnTjZwQTEyWWxq?=
 =?gb2312?B?NGU2RGs4c3ZXd0g5YlNIamhKcS9BM1lPTnhmdlM3TE1KQVBZZ3c5dXUvWlJK?=
 =?gb2312?B?SEdYb3JaSDIvakRHcVBPOU05SVBqb1ovNGR1bkNoRzdYUmRRd3pJZFlyWjdr?=
 =?gb2312?B?OUsrMWc3NnRWT0dXYytTQ3VXblB3aWpicnJGOGxCMlg1Wm1vRWwzZnZDRjh3?=
 =?gb2312?B?QlRqQmhmaWtucXFkQUE1YzkxUytPY3ZkM21JL3JFNndGUzQ4ditIS00wSEhY?=
 =?gb2312?B?TzRXSzErOVkyclRvSG1GNTN1dTliZGg5YXo0WWN5S3Z5dFZTK0kvQVBxbEZR?=
 =?gb2312?B?UlJTRGhld1p6SWxsQmhtZElhZm9tUEptRTB3VkY4YldVYVJCUWp2WmN1Y2xN?=
 =?gb2312?B?enhmeE01dVEzTkFGZjJmUEk1WUZ6Q1VpY2lvcHFvRW1MTUpNYkVIR0Vhb05k?=
 =?gb2312?B?UWZiL2lsOHlOL1B5V05iZUpJWEdQTnRIVGNrSXNKY2ErZVlGVmM5SmIxZkM3?=
 =?gb2312?B?djFrd0VHMEw0UmRJM2liVlRvckJTaXdpL0NtU3kvU1hZSHhsK3Y3VGptRjQ5?=
 =?gb2312?B?RUhLT2RETHJzbTE3eXN6MEJtOFpiZ25PN3hqRkZvNFJwb0g4QlY3U1VoOE45?=
 =?gb2312?B?aUdoR3VMdEVyeUFBWXVreldIOFV6VWdjTG1HSnpaNXc2SVdvakMzbmV6OWdM?=
 =?gb2312?B?cEVRZE9SY1VRdm5heVUvVDBCWGNTeGNYK1JpbFVyU3ZIRE42MXhxbXFWMzdh?=
 =?gb2312?B?SVRaaDRNMWNTUGIxakN2anREb2YyWS8ySTJXRUt1MHE0ViswR3hKbGQvYzli?=
 =?gb2312?B?MFNnYzVLKy94d1h0U1RWWk9pTU1OcjlkcXBZWkhPekhUdnlEV0hMZ1Q3M1hu?=
 =?gb2312?B?VHcyUUM3MzMwNXNCNWhhb2E4eW4wc1dnMS9LSEt0V1hBWWoycnQreS91a21N?=
 =?gb2312?B?eGVMRkFHTWRQVkphem93UlU4N20yNFpHZzUvcFgyczdRcDB0SFVxS25hZVcz?=
 =?gb2312?B?Y2xwMk9kMEs2bmE2dDBKOUE2N0puR2tybVp5MUFYMm9mZkZ1aHEvZEpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ampzdkUvSElDU1g0SHZkTjRqUWxycXRya0ErU1dmS1Rsb21rRFhJa1pHakJH?=
 =?gb2312?B?UjBMRStsK0diajZHZFllcG90NFN4bldWYk9JbXBVc3d5N3dRczhSaXJWdmRH?=
 =?gb2312?B?TnE3VUR4VERNVlBnL1N1aGZoYW5rS3c3cjc5VFR6dks4VHJRaktMa2VpSTVj?=
 =?gb2312?B?YUpNdjdYSXJVRlZKNmw0NTVqVTRuVjVxVnlXcFNpMW9SUzRNMEdUWXpQOWUw?=
 =?gb2312?B?ODdHSzJRSWJ6OEVJSU1LVHloOW9rZmFHQkdIdzRHMlpNelg2VTZpQ0duaVdi?=
 =?gb2312?B?d2doc3YxVU5NM1pYYTJYb3ZZSGgyNW1FcnY2cHhXRzRpSm0vUHB2NXVDeFlB?=
 =?gb2312?B?dDNmSWFmT1hhZjZFTWZVTThYTXhuWUpBY1JCUXV3a1hGNDZhYzNqbDhadU0w?=
 =?gb2312?B?ZEpyMjJQa2Via3NrT2x2Um5wYzJkLzRTMVMrMHM2S1VsZGpoS2Z2YklrS1BN?=
 =?gb2312?B?WmtJZ3dOVVBadmZnZHFXZkdLWDExdGhkYjFRNDVqMFYwNE9LYlY1MVdlR25t?=
 =?gb2312?B?RFVvREtrNG9TVFc4UkxJMk53aFBEMW5SWE1zcDExdys4dDAvbUhIV0pTVlRq?=
 =?gb2312?B?OWhuYU1UTDFWMlI1SGtFZDRYT3FiR2JvYzVXZjFpY29hUWxVWCtIckpoNzND?=
 =?gb2312?B?RVJHWXpSamhYUngvNElmYlFJRVNHZktHOEt3ZnQrdVZ2bGRUUGdqMGJMRjBu?=
 =?gb2312?B?N1Nkd2xMczJNbU1KK0JmdkN6djFZaGNnVVFINFl6eHpteDBjRG5IdzZKT2sy?=
 =?gb2312?B?OWVDZklSRXlocFdtYVZQTUF1R0xrMDVjbGIzaUh5UTlKWVE5b256dXhlSFc3?=
 =?gb2312?B?Y1VOTGx0QWdoSEMyWnZOTWRqQjFPZTU4dmtVOEFqTWRzVlNJWC9MdGE3bS9m?=
 =?gb2312?B?VzMvc2NkZllidHFOd1lBUXVDRW9pdjJaK3RvUlBlaW0zUFRCNU9aQzBoUTVV?=
 =?gb2312?B?VEhBUEpFRVZKWXNHYU42VnBpd0FLdFFCb2dMUExhdksvempjcHZtcUZiOWVr?=
 =?gb2312?B?THpKL2RyamQ5djVpV2Vienc4ZDNiSGs2anE2VkdycVdtdWEyVlEzOERiQWhO?=
 =?gb2312?B?dmJnZXhiNDRkd1VKRGpENWQ3U3kvSDF3QVFkTmk5eFVwWmFQNjluTDBRV2lH?=
 =?gb2312?B?dDhNRTVVYVFidk9US0FGNG8zcnJxbXhwdnQ4S1VZRGdUbW55UmdXdWlHdGlk?=
 =?gb2312?B?TkIyS1lobVR3ZzlkaU14aEtmdXBkMWlsQXhsY3U0UnBMSEZkTDU1MXJEcGRH?=
 =?gb2312?B?YWFHZ3lsUG1ITndhd3J0b0R1OGJVSkxSa3FHRnFUU2JBLzZqdS9CU25aUGhU?=
 =?gb2312?B?N3Zya1hVeU5McnNjem5wL3dLSms5blNRR3hJQ2hqbFRDWjNiMXRLSXBzR2ow?=
 =?gb2312?B?THJzbk5RS3VwVm0yL1BXNWRJemV5aEIwUnFveGVkUTJ3cVE0Sy9hVWs5Lzdo?=
 =?gb2312?B?aCs5RmxkSERzdTNlRHY5K3dMYVE4dGFFOGpxdDZ5V0lISGh3R1puWmtRSEdJ?=
 =?gb2312?B?SHVWTUcwUlg1azdQWmxKZ040Zi9qTjlkNURGUHNpZlhiK0h4SFVLNUtRdC9Y?=
 =?gb2312?B?V1NUN3A1UEl4YXQ1aE91SEduY2JUMHpnenozbkVkY1hEdVZIZjZHU25DTEhV?=
 =?gb2312?B?aS85NWkzL2hhWm5wNHYycVNjL01vVFQ0K1JLTXYxaTAxbmM5K3NFUWlRT2xU?=
 =?gb2312?B?YllZa2hjUUQ3QUw5cy9mcGtNdFYzNzYyUGhwa2xJSWFIZUJNRk5Dc0RVVTFR?=
 =?gb2312?B?RHYvQllwVnc5cGE1SU5zNUY3a1pqeDRMMFVBV3UrZGYvZFpqOGdkMk5zQnZN?=
 =?gb2312?B?QnU2NTI3UlBBVCs4YnlML3hoZGQ1OTJOT00wMWRCYkROZGIybXBXNGN2VUFN?=
 =?gb2312?B?UU9HNEZ2dGJ6MlhWd2VSazZoT0oxaGdmUjBvMWU2S0xlcnJwUEFjbjBuVjBJ?=
 =?gb2312?B?SVJjUktEUmVJNDdSV082TjR4MVNxTW1waFo1MEVWM2VhWS9HUUVSWmpCKy9x?=
 =?gb2312?B?ZE5HS0JiOTNtRTltc1F2emlqc09qLzJVQ0tiaDNqY0sxbWsxNUtVSDFoWDZn?=
 =?gb2312?B?cnZWSld2dHc3SDVHMlpINTBWY0k5cGxBWk5BcURNcklUczZUT3h2ZXVaeGZn?=
 =?gb2312?Q?HXoY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0659860-dab9-4b46-2182-08dced810d4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 01:22:50.9165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVwfbEqvGN5lKIzYJP5hRg53xaQJhHx1/QOS0CPN4TuInc1mXK6c4AhkS+5ulEb1awboE/LR7lxlxh3ygAKO0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9719

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjE1yNUgMjM6NDUNCj4gVG86IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgcm9iaEBrZXJu
ZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IFZsYWRp
bWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+OyBDbGF1ZGl1DQo+IE1hbm9pbCA8
Y2xhdWRpdS5tYW5vaWxAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNv
bT47DQo+IGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldTsgbGludXhAYXJtbGludXgub3JnLnVr
OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBob3Jtc0BrZXJuZWwub3JnOyBpbXhAbGlzdHMubGlu
dXguZGV2OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtcGNpQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIG5ldC1uZXh0IDAzLzEzXSBkdC1iaW5k
aW5nczogbmV0OiBhZGQgYmluZGluZ3MgZm9yIE5FVEMNCj4gYmxvY2tzIGNvbnRyb2wNCj4gDQo+
IE9uIFR1ZSwgT2N0IDE1LCAyMDI0IGF0IDA4OjU4OjMxUE0gKzA4MDAsIFdlaSBGYW5nIHdyb3Rl
Og0KPiA+IEFkZCBiaW5kaW5ncyBmb3IgTlhQIE5FVEMgYmxvY2tzIGNvbnRyb2wuIFVzdWFsbHks
IE5FVEMgaGFzIDIgYmxvY2tzDQo+ID4gb2YgNjRLQiByZWdpc3RlcnMsIGludGVncmF0ZWQgZW5k
cG9pbnQgcmVnaXN0ZXIgYmxvY2sgKElFUkIpIGFuZA0KPiA+IHByaXZpbGVnZWQgcmVnaXN0ZXIg
YmxvY2sgKFBSQikuIElFUkIgaXMgdXNlZCBmb3IgcHJlLWJvb3QNCj4gPiBpbml0aWFsaXphdGlv
biBmb3IgYWxsIE5FVEMgZGV2aWNlcywgc3VjaCBhcyBFTkVUQywgVGltZXIsIEVNSURPIGFuZA0K
PiA+IHNvIG9uLiBBbmQgUFJCIGNvbnRyb2xzIGdsb2JhbCByZXNldCBhbmQgZ2xvYmFsIGVycm9y
IGhhbmRsaW5nIGZvcg0KPiA+IE5FVEMuIE1vcmVvdmVyLCBmb3IgdGhlIGkuTVggcGxhdGZvcm0s
IHRoZXJlIGlzIGFsc28gYSBORVRDTUlYIGJsb2NrDQo+ID4gZm9yIGxpbmsgY29uZmlndXJhdGlv
biwgc3VjaCBhcyBNSUkgcHJvdG9jb2wsIFBDUyBwcm90b2NvbCwgZXRjLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gdjIg
Y2hhbmdlczoNCj4gPiAxLiBSZXBocmFzZSB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+ID4gMi4gQ2hh
bmdlIHVuZXZhbHVhdGVkUHJvcGVydGllcyB0byBhZGRpdGlvbmFsUHJvcGVydGllcy4NCj4gPiAz
LiBSZW1vdmUgdGhlIHVzZWxlc3MgbGFibGVzIGZyb20gZXhhbXBsZXMuDQo+ID4gLS0tDQo+ID4g
IC4uLi9iaW5kaW5ncy9uZXQvbnhwLG5ldGMtYmxrLWN0cmwueWFtbCAgICAgICB8IDEwNw0KPiAr
KysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwNyBpbnNlcnRpb25zKCsp
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9uZXQvbnhwLG5ldGMtYmxrLWN0cmwueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdA0K
PiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9ueHAsbmV0Yy1ibGst
Y3RybC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L254
cCxuZXRjLWJsay1jdHJsLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4
IDAwMDAwMDAwMDAwMC4uMThhNmNjZjZiYzJlDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbnhwLG5ldGMtYmxrLWN0cmwu
eWFtbA0KPiA+IEBAIC0wLDAgKzEsMTA3IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gPiArLS0tDQo+
ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbmV0L254cCxuZXRjLWJsay1j
dHJsLnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVt
YXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IE5FVEMgQmxvY2tzIENvbnRyb2wNCj4g
PiArDQo+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ICsgIFVzdWFsbHksIE5FVEMgaGFzIDIgYmxvY2tz
IG9mIDY0S0IgcmVnaXN0ZXJzLCBpbnRlZ3JhdGVkIGVuZHBvaW50DQo+ID4gK3JlZ2lzdGVyDQo+
ID4gKyAgYmxvY2sgKElFUkIpIGFuZCBwcml2aWxlZ2VkIHJlZ2lzdGVyIGJsb2NrIChQUkIpLiBJ
RVJCIGlzIHVzZWQgZm9yDQo+ID4gK3ByZS1ib290DQo+ID4gKyAgaW5pdGlhbGl6YXRpb24gZm9y
IGFsbCBORVRDIGRldmljZXMsIHN1Y2ggYXMgRU5FVEMsIFRpbWVyLCBFTUlETyBhbmQgc28NCj4g
b24uDQo+ID4gKyAgQW5kIFBSQiBjb250cm9scyBnbG9iYWwgcmVzZXQgYW5kIGdsb2JhbCBlcnJv
ciBoYW5kbGluZyBmb3IgTkVUQy4NCj4gPiArTW9yZW92ZXIsDQo+ID4gKyAgZm9yIHRoZSBpLk1Y
IHBsYXRmb3JtLCB0aGVyZSBpcyBhbHNvIGEgTkVUQ01JWCBibG9jayBmb3IgbGluaw0KPiA+ICtj
b25maWd1cmF0aW9uLA0KPiA+ICsgIHN1Y2ggYXMgTUlJIHByb3RvY29sLCBQQ1MgcHJvdG9jb2ws
IGV0Yy4NCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gV2VpIEZhbmcgPHdlaS5m
YW5nQG54cC5jb20+DQo+ID4gKyAgLSBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+
DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBl
bnVtOg0KPiA+ICsgICAgICAtIG54cCxpbXg5NS1uZXRjLWJsay1jdHJsDQo+ID4gKw0KPiA+ICsg
IHJlZzoNCj4gPiArICAgIG1pbkl0ZW1zOiAyDQo+ID4gKyAgICBtYXhJdGVtczogMw0KPiA+ICsN
Cj4gPiArICByZWctbmFtZXM6DQo+ID4gKyAgICBtaW5JdGVtczogMg0KPiA+ICsgICAgaXRlbXM6
DQo+ID4gKyAgICAgIC0gY29uc3Q6IGllcmINCj4gPiArICAgICAgLSBjb25zdDogcHJiDQo+ID4g
KyAgICAgIC0gY29uc3Q6IG5ldGNtaXgNCj4gDQo+IElzICduZXRjbWl4JyAgb3B0aW9uYWw/DQo+
IA0KDQpZZXMsIGN1cnJlbnRseSwgTkVUQ01JWCBpcyBvbmx5IGV4aXN0ZWQgb24gaS5NWCBwbGF0
Zm9ybXMuDQoNCj4gDQo+ID4gKw0KPiA+ICsgICIjYWRkcmVzcy1jZWxscyI6DQo+ID4gKyAgICBj
b25zdDogMg0KPiA+ICsNCj4gPiArICAiI3NpemUtY2VsbHMiOg0KPiA+ICsgICAgY29uc3Q6IDIN
Cj4gPiArDQo+ID4gKyAgcmFuZ2VzOiB0cnVlDQo+ID4gKw0KPiA+ICsgIGNsb2NrczoNCj4gPiAr
ICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBORVRDIHN5c3RlbSBjbG9jaw0K
PiA+ICsNCj4gPiArICBjbG9jay1uYW1lczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAt
IGNvbnN0OiBpcGdfY2xrDQo+ID4gKw0KPiA+ICsgIHBvd2VyLWRvbWFpbnM6DQo+ID4gKyAgICBt
YXhJdGVtczogMQ0KPiA+ICsNCj4gPiArcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gKyAgIl5wY2ll
QFswLTlhLWZdKyQiOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvcGNpL2hvc3QtZ2VuZXJpYy1w
Y2kueWFtbCMNCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+
ICsgIC0gIiNhZGRyZXNzLWNlbGxzIg0KPiA+ICsgIC0gIiNzaXplLWNlbGxzIg0KPiA+ICsgIC0g
cmVnDQo+ID4gKyAgLSByZWctbmFtZXMNCj4gPiArICAtIHJhbmdlcw0KPiA+ICsNCj4gPiArYWRk
aXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAt
IHwNCj4gPiArICAgIGJ1cyB7DQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+
ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKw0KPiA+ICsgICAgICAgIG5ldGMt
YmxrLWN0cmxANGNkZTAwMDAgew0KPiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54cCxp
bXg5NS1uZXRjLWJsay1jdHJsIjsNCj4gPiArICAgICAgICAgICAgcmVnID0gPDB4MCAweDRjZGUw
MDAwIDB4MCAweDEwMDAwPiwNCj4gPiArICAgICAgICAgICAgICAgICAgPDB4MCAweDRjZGYwMDAw
IDB4MCAweDEwMDAwPiwNCj4gPiArICAgICAgICAgICAgICAgICAgPDB4MCAweDRjODEwMDBjIDB4
MCAweDE4PjsNCj4gPiArICAgICAgICAgICAgcmVnLW5hbWVzID0gImllcmIiLCAicHJiIiwgIm5l
dGNtaXgiOw0KPiA+ICsgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiArICAg
ICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAgICAgIHJhbmdlczsNCj4g
PiArICAgICAgICAgICAgY2xvY2tzID0gPCZzY21pX2NsayA5OD47DQo+ID4gKyAgICAgICAgICAg
IGNsb2NrLW5hbWVzID0gImlwZ19jbGsiOw0KPiA+ICsgICAgICAgICAgICBwb3dlci1kb21haW5z
ID0gPCZzY21pX2RldnBkIDE4PjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgIHBjaWVANGNiMDAw
MDAgew0KPiA+ICsgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJwY2ktaG9zdC1lY2FtLWdl
bmVyaWMiOw0KPiA+ICsgICAgICAgICAgICAgICAgcmVnID0gPDB4MCAweDRjYjAwMDAwIDB4MCAw
eDEwMDAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwzPjsNCj4g
PiArICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPiA+ICsgICAgICAgICAgICAg
ICAgZGV2aWNlX3R5cGUgPSAicGNpIjsNCj4gPiArICAgICAgICAgICAgICAgIGJ1cy1yYW5nZSA9
IDwweDEgMHgxPjsNCj4gPiArICAgICAgICAgICAgICAgIHJhbmdlcyA9IDwweDgyMDAwMDAwIDB4
MCAweDRjY2UwMDAwICAweDANCj4gMHg0Y2NlMDAwMCAgMHgwIDB4MjAwMDANCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAweGMyMDAwMDAwIDB4MCAweDRjZDEwMDAwICAweDANCj4gMHg0
Y2QxMDAwMA0KPiA+ICsgMHgwIDB4MTAwMDA+Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAg
IG1kaW9AMCwwIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInBjaTEx
MzEsZWUwMCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MDEwMDAwIDAgMCAw
IDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsgICAgICAgICAg
ICAgICAgfTsNCj4gPiArICAgICAgICAgICAgfTsNCj4gPiArICAgICAgICB9Ow0KPiA+ICsgICAg
fTsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=


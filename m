Return-Path: <linux-pci+bounces-14609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC6199FEA4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 04:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E433B222B1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 02:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE0115B987;
	Wed, 16 Oct 2024 02:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hu3laZDn"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11EE158A2E;
	Wed, 16 Oct 2024 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729044402; cv=fail; b=OamRKi+nlu9xW5jmRDXkv8FJXQIi28Ch4lDUh/dod7Y+3S1by+WSSGq1U8EnC+75c3PHIO/vozwUNg9OABaTXBiU2oNQzCvG3ohswKrEfbkAcK4zalHlom36e8Y+rWBDXGXa1clsTquNix44foAC35Qh2SvWkdSbE2/lOCqqY/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729044402; c=relaxed/simple;
	bh=NlBkBfklCmjdX7UNVwo1m7rDSvp80cpDxaiglPQH+HA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P62Z47cpcobx2WVo+UMY8SMpdvT9iVUp8dqQ4O+T2KyIxza0wpENU3QUx2LWMGAV4/T2D2VaRmoJ9vxnAuMAy8LHlH5gesGdk2EYXTXRJf6EjGv5SJpDFzLnnxrbFFJJMsbdaTlO/HWAM21S/uQOnI/xKkToSvQ9US0PrI4wO9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hu3laZDn; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6q19rx2yxLxe8NajSCrZAM2R4hXdlzCEV2T9i9E8vr6qcZZHFtrKmsykWX7qk6gsuGahtxedKs3piAUftroFVF9iXSM/cOPlXCfJY13tf8SYiklkY3lRm4faJybnOH4FRS3z8HaB6dCMuRfQQzrkHgfGUqft/OAzJtRgHzPwaQrUsgp5wSWADY6iC5IFUPAHOyr5yXKcnTDOYjcC+DFPrx+FXBefU1a7YBTbAMOH15kYzOXF/6q9fV8PoOssfD4oa/Kf7fUUbPosTRxJJ5dDDUnk/D9epHFK6Qv0XtX4A4evR0MWIDahHTkxZhD0fc1IStDRCKEQDDJtcQ1s4BrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlBkBfklCmjdX7UNVwo1m7rDSvp80cpDxaiglPQH+HA=;
 b=sATTfAdmg1WyA2L55YizGjo/Iv/AOAcAzYjKjZLZ127hyOX4t2dmRd/rg3uW3b65uYoGqoFnGxxGGXMKZfd7/APARHlgMCM2WP2ghs0Zdm2jIG/2h/DUsNtKIKkGyhgJ/atBECcR/waZyRckcSCfdcC3I5Al8Tovn1JW2zUdwJfXSC+x/th6qMeAR9lWiJfy2VOZGO4alRewM0dJsQaT4sUTLyanleY04FjQ4Kxw4cdumA3Tt4Lla0ku99eNQmtDuPn6mxksOUIFWMbpXFAjl/I7Eh2FwXUjmy29rsrdW+OG9ZvNcM0btzoUtJg8+RUk/i/eIHxAvs6NIMgahLy7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlBkBfklCmjdX7UNVwo1m7rDSvp80cpDxaiglPQH+HA=;
 b=Hu3laZDnLA+/uQYofnYGs9qgrJwCcaKpbbXW8F8tpzP7zv8nODlCihYT5kFdm+/IqArbn8g5bk7qg2xqPb5zTqUuq8r46m+9KDMZibIejv3ZuV5HjQtxhg4rW5Ml40UTsyRf4yX892379D4P/tNBn8qi4XEOe1PGbs/RcnBtCU7FIUAK/EacP2iUkvMFtJkVPuHDZC1vaTD6NoAa1xok3oTMMc50pX6+cPVEZGhC7V1dJdKhsYO3ggJvPr/PUUNxN2/4V4e8uCphWheFxjdrh1xZBHf8oBjJEe4aikEREIl9wnM7GtZMb0DncIGLl8NkwDP99MaDObhQKze6GKcgcw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7819.eurprd04.prod.outlook.com (2603:10a6:10:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 02:06:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 02:06:37 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Topic: [PATCH v2 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Index: AQHbHwQPe0FiChmkLUS/Jev+GMlg27KIXL2AgABE4oA=
Date: Wed, 16 Oct 2024 02:06:36 +0000
Message-ID:
 <PAXPR04MB85101339DA552017EB19C39988462@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-3-wei.fang@nxp.com>
 <20241015215837.GA2022846-robh@kernel.org>
In-Reply-To: <20241015215837.GA2022846-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DBBPR04MB7819:EE_
x-ms-office365-filtering-correlation-id: e28d1977-79ec-41c5-a169-08dced872a87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?QW50d0FPQUlkb2tTdjBsNUJISlUra1Z0ZHNKRVI2c24xU0s3QzhKK1lSTDVj?=
 =?gb2312?B?bkRhYlFpME5kMFRFMzdVY0xmRm9xN1NzYTNJK1d6Y3IvbEhIdnFJdk9pVlIy?=
 =?gb2312?B?UndiVDVGMEt2ZStYN0swaEJXc3BoRHo0OWhNMTE4SGVJQ1QwL29LQ1FmaUlC?=
 =?gb2312?B?WkF6WUN6ZjN6NjRvTWprR212bmp1OW9mYXJPemZPTmFzVzVsdW1wRFFwbHIv?=
 =?gb2312?B?OWxRQUZrbm1QODFKMit5V1dCVCsycUtUVmVBR1ByUFNWQW5RUDNBN0ptZ0Rh?=
 =?gb2312?B?QUVzT3QrL0ZQdzRCQjNCZkVKQlVzaTJPRkpsQ25FbVpkQS96Q1pMYWFkS2sy?=
 =?gb2312?B?OFdEenE1RzY1T0xkaEFiZngzL1EzNUlRT0gwWmhmZ3VSa05QTWxQaXkrSVNp?=
 =?gb2312?B?ODJDbHZHc01iR0QzeVJNcjY2UGVlVnhhdXpPb0ZpMlY3aCtRSkFXVjQvM1N5?=
 =?gb2312?B?dk5pZXJwTjFqMmFHclNsamRHWDNGMVdSZWU1QzlNaDQ4aDNOSUMxemcxTXdz?=
 =?gb2312?B?V3puR3h0RGFKWmNxOVNsSTV0SC9xSkhrU2F2eEpXeG0vOHVBRS9GQ3BjN3NE?=
 =?gb2312?B?ZVhJVVBOUDhSanlISWZBNkxLRGMyblhsdDdYVk81UWQwbGlCc1hpTEthMnlJ?=
 =?gb2312?B?alZ0VTE5YWZyWWdQd0ozTmQ1R2tSelUrTmVnQmxZNldMRmlnQ3RLOUdCazlR?=
 =?gb2312?B?aGVvekxDV3pPbDdHT1I0TW0zM3Rxc1RSeFZuTVI4MUltN1pXTS85THlVUGxt?=
 =?gb2312?B?RUJOL1B4VE0yaWcrQzJXRHJlTFU1VVdLejNPQ0xNRjgrRUhDQ0FCNEpYYyta?=
 =?gb2312?B?OWloZGZpWmVXYitZWWE0R1RVc1ZhcFZrYnBDL1gyTGlsQmhBbytQbGNrOHhK?=
 =?gb2312?B?RUpIWEl4TmtpRThtZnhERi8wazl1Y3hseUNOdEdzc05rQVh3MzZFdU5EVU5R?=
 =?gb2312?B?R2FjTlJHaUdxVHpmNnhDV08rY1BuZmNCa1dKTTVKclJMck53MUFUclRqc0Nr?=
 =?gb2312?B?M1ZhazFFUDJkeDJRalF4Sm5pTFNYSW9yZ3hjcE1NSHBlZ2haeVlCbkU5YmdY?=
 =?gb2312?B?TDZzNHV5a0tMNm1wQTRpQVJtQll6KytCb1ZJQzVmeTdnTFdlRXBITXluU201?=
 =?gb2312?B?ejZqWEZxVC8va2ZUWkpVaHBCRldQNkRqRXYyNnlCYXVJTUpwMjZhbXhHWmVX?=
 =?gb2312?B?Wk5zZ2FIYnNZRHhqcmZNSG1BZ1B0VHFtUW9WeGR1Qm1jUDRTY1lyT0J3V09H?=
 =?gb2312?B?YVZubG5HeUx1SVdZWVczVWM1ZGdja3FwTFlpc1dmc25uUUhOdEQwK1l0d2dK?=
 =?gb2312?B?QzBlQXBURkgwVS8xSGZBWHZkMVdWNGlZbVNOYkp5QjZvNG5MdjNVUVE5WHdC?=
 =?gb2312?B?OS9ZcjZRU0dIR3pTTU1WRjlTSDZ2UllhMzMzemp0V1ZnZ0J6djIveXlsTWxY?=
 =?gb2312?B?MzMwZHNZVTVLRUZyUEhsREdrWUwzNFJDTXZ3cXJESG5RT2J4dDBqVHg4WFdQ?=
 =?gb2312?B?a2t4NWZGaVdLeVh2SW1EbFFxREtrbnEvaS94Rkwrdk9iUVB3SFMvOU5rR2RJ?=
 =?gb2312?B?V0d2Q0Y3Yi9tRktEYzVSTDRBS3FVZzVaTVR3M1J0ZmRBUHpRbkFBclBieVdC?=
 =?gb2312?B?b3JkK1RjWFBlbkJ4MEdFMXdxUVVPbWRWY0kzL0VocnRQcDR6SkwyNWR5NFZO?=
 =?gb2312?B?Qld5ZGgwRzNhVk0yWmFoMW82SmtrSUJkZUVwM0loUGs2azdwL1hmVi9XTVhR?=
 =?gb2312?B?cy9nRzFJeHV3SDNaK1NkK2toV2lJczhMWjFUR3N0N01GalI4V09sMzNhMzhD?=
 =?gb2312?B?Sy9vNFdSU1Q4d0RhVkZCdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?YXppUHZaek4zSG42ZHQwWkZGcTdSN2NtN1dueFdKRnQ0ckV3bXdNQkNjM0Q2?=
 =?gb2312?B?N0tNcjFOVDlkMXJIVHVJcjhpSzA3S09QcEFHYnZGL1E5UU96WFIyRUNZcmJI?=
 =?gb2312?B?RVVtaU9ySDc4ZDhxVjYra0MzQStCNVRtSDJHMWZmRUdoYUlPM05lakhQYUNH?=
 =?gb2312?B?ODFReXlHemZZQVZqTFhHZFFJV0FMN1VpZWw5M05tQWhsMVpzZ2R2T0Q0azVj?=
 =?gb2312?B?RnpDajRjY01pOUVUZThSOXhrR2hDa3dtSEhvenc2amllL3VJWjJRbzdnZit3?=
 =?gb2312?B?NWoza1ovVmJXd2R6aStUWm1Bb05iR3BaSVpGcTljK2JTYjREdTRnaDEzMGNx?=
 =?gb2312?B?NUh2NStOMFcwQVc3dS9oL0doeXFHczJTb3d6blZ1WjdXbVVzcXZ0V2psRFR2?=
 =?gb2312?B?d1ZxcUN6ekMwZjVyS25JRVFOazV6UzJGVWQvREFrbTJwc0ozSzhNRU5OakRv?=
 =?gb2312?B?eXJaVjJxbzljVEp4U0lDWHdGaHk3SnI1eU5ZdmNRYWZjeEt1ZlIrTmhGMlB4?=
 =?gb2312?B?WXdpVGRQeDJ5OXl5UXMwVkVpUmhCWEt2aUszeGZTZ1didUYyUUFHdGRCdGxE?=
 =?gb2312?B?N1BmeGlOTStJaFgyME1QSzlBMEJsZWR6blRGMGIxanVORWN4VVpadDZEaEJx?=
 =?gb2312?B?YkEyaTlHRFpaZVl0QkI4Y2hQY2k3azlEQWNCckZ1VXVhZ3hGZ3VGYU5aYXZw?=
 =?gb2312?B?ak1QTUVMdlo5WUlQa1dSUVdqMWJJemZFVkRCdm5vZlExME9KdUw5TW5CZWpN?=
 =?gb2312?B?SUxNRWxCQUluMVNpMkE0ZXFtd01xSk4yeEhMSi90NE56T3J3N0JTclE0UEIw?=
 =?gb2312?B?VTkwUERBZTN2S0NRMElFRlhlV01GZDFyeEtZZWwxL2NuN2xHVGhGTGl1eENG?=
 =?gb2312?B?SEVNUmZLRC9nL2xPVE9BK2pKWXFDNGRWRC9aQnU5NlVRRFVFVjQ4K0JQY0N0?=
 =?gb2312?B?VGJjNVY1WlF2Y3pxL2xxTjJndVY1N2VaR01SRVRMRGxsMFFycS9nSHpwUVVG?=
 =?gb2312?B?b2lrK09aT3hJRm9OR01vNjM4ZlAxV3hlZjE1UXhoWXpXYmRpTUZtSmROaVNX?=
 =?gb2312?B?RWs4bUFaSytwUFFpcGlic0d2aDg3WHZtVjhxejcvRGg3UFBEejFSM2pnRXg4?=
 =?gb2312?B?MFpIR1ZxSlZkMk9aTzNIdVl0ektIczNhMHY2QjlsKzByeENPTEh3eGVzQXFT?=
 =?gb2312?B?SGN2RDNWc2QxS0hYOWNiQk5RSVBJSi83TUlRR1VOS2doWUlubmxMSUY5SHVR?=
 =?gb2312?B?eE4zYjd6ZjdLT2hmMUtKQVYxSWRGa2ZxaEdIczJldU8rVGNqSVV0eDlnSUo3?=
 =?gb2312?B?QnpFTE00YXgyNHR6cnlLS3I4THcrL09GMlNJcmJLZE9Jei9mZS95RnpvZi9Q?=
 =?gb2312?B?S1lpMEd0WUJNNnYvMHR5c082QzdoSzdrM2dRS0x4WTl1YzFJT0QvZDFuSlFQ?=
 =?gb2312?B?d0JRRC9sbTJxa0ZBNjhSMGxVZUpjNk1OTXF5SXNkeHJSM2Q5S0dYajBNMHNC?=
 =?gb2312?B?aU9EU1JoaHhGWXA0RlJBOGNxeFpFeU93K0JCcXA4L29YcTloR3YyZTNyVjlJ?=
 =?gb2312?B?NVJsNHVSRnBZOS8yYnpsZTVIMU5BSW1ubVpkUjlublFWZXVNN1RtZ080Ykky?=
 =?gb2312?B?T2pTMUpHeFdheFhXZVJEYjI3cTJaNWhBcWxCcUQxK2FFdkprVkErcWpRVVY5?=
 =?gb2312?B?cXZGUEE5K2FNSW8xWGIrQThuQVk4Qm83cTNETmlHejFOaWI2WS9tUHlURmla?=
 =?gb2312?B?a2ErSE8xditscWQ1QkVGS253UkVLNm50ZHVreGZUTTRrOStsMVRQcUtUQlBn?=
 =?gb2312?B?ZVdJa01RaHZGdVhUd3orMWNsZXo3SC9na2YxUVE5QnV6R2gwZ3RVVGZpc2po?=
 =?gb2312?B?NGFYWHNOZStqZjdWYXV5cDY4OFc3Y3dkTkZLQXRHeG5KdHJub2ovSG9tdk9S?=
 =?gb2312?B?UGEyVi9hbVNWVW1mdGNEZWJoSmUzVitxamZBQUZPUWh0TE82WStvN3c0enVV?=
 =?gb2312?B?MlY1NW8xdTdyalJNSUtMTExldkc3UzBXeC9oR3ZwVVZ6N0JoNE5NWjVpdTVR?=
 =?gb2312?B?b3lZcUx6MFNUcHFBdWFucmQzOENqY0p5TkhVdjFUTFdERFlGQTVFWXVNNXRh?=
 =?gb2312?Q?GgMA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e28d1977-79ec-41c5-a169-08dced872a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 02:06:36.9271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jv4MXF9lxkf1HZk9UWT3pLA8CyuRSwNor/4I+dQwdq+2kaxuFrDWJWaMPBmxrgkXwh2Fif9YipKxEzkBTGSLsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7819

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOoxMNTCMTbI1SA1OjU5DQo+IFRvOiBXZWkgRmFuZyA8
d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdv
b2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IGtyemsrZHRA
a2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsgVmxhZGltaXINCj4gT2x0ZWFuIDx2bGFk
aW1pci5vbHRlYW5AbnhwLmNvbT47IENsYXVkaXUgTWFub2lsDQo+IDxjbGF1ZGl1Lm1hbm9pbEBu
eHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgRnJhbmsgTGkNCj4g
PGZyYW5rLmxpQG54cC5jb20+OyBjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU7IGxpbnV4QGFy
bWxpbnV4Lm9yZy51azsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgaG9ybXNAa2VybmVsLm9yZzsg
aW14QGxpc3RzLmxpbnV4LmRldjsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiBuZXQtbmV4dCAw
Mi8xM10gZHQtYmluZGluZ3M6IG5ldDogYWRkIGkuTVg5NSBFTkVUQw0KPiBzdXBwb3J0DQo+IA0K
PiBPbiBUdWUsIE9jdCAxNSwgMjAyNCBhdCAwODo1ODozMFBNICswODAwLCBXZWkgRmFuZyB3cm90
ZToNCj4gPiBUaGUgRU5FVEMgb2YgaS5NWDk1IGhhcyBiZWVuIHVwZ3JhZGVkIHRvIHJldmlzaW9u
IDQuMSwgYW5kIHRoZSB2ZW5kb3INCj4gPiBJRCBhbmQgZGV2aWNlIElEIGhhdmUgYWxzbyBjaGFu
Z2VkLCBzbyBhZGQgdGhlIG5ldyBjb21wYXRpYmxlIHN0cmluZ3MNCj4gPiBmb3IgaS5NWDk1IEVO
RVRDLiBJbiBhZGRpdGlvbiwgaS5NWDk1IHN1cHBvcnRzIGNvbmZpZ3VyYXRpb24gb2YgUkdNSUkN
Cj4gPiBvciBSTUlJIHJlZmVyZW5jZSBjbG9jay4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdl
aSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IHYyIGNoYW5nZXM6IHJlbW92
ZSAibnhwLGlteDk1LWVuZXRjIiBjb21wYXRpYmxlIHN0cmluZy4NCj4gPiAtLS0NCj4gPiAgLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZzbCxlbmV0Yy55YW1sICAgIHwgMTkgKysrKysrKysr
KysrKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbmV0L2ZzbCxlbmV0Yy55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC9mc2wsZW5ldGMueWFtbA0KPiA+IGluZGV4IGUxNTJjOTM5OThmZS4uNDA5
YWM0YzA5ZjYzIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9uZXQvZnNsLGVuZXRjLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L2ZzbCxlbmV0Yy55YW1sDQo+ID4gQEAgLTIwLDE0ICsyMCwyNSBAQCBt
YWludGFpbmVyczoNCj4gPg0KPiA+ICBwcm9wZXJ0aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6DQo+
ID4gLSAgICBpdGVtczoNCj4gPiAtICAgICAgLSBlbnVtOg0KPiA+IC0gICAgICAgICAgLSBwY2kx
OTU3LGUxMDANCj4gPiAtICAgICAgLSBjb25zdDogZnNsLGVuZXRjDQo+ID4gKyAgICBvbmVPZjoN
Cj4gPiArICAgICAgLSBpdGVtczoNCj4gPiArICAgICAgICAgIC0gZW51bToNCj4gPiArICAgICAg
ICAgICAgICAtIHBjaTE5NTcsZTEwMA0KPiA+ICsgICAgICAgICAgLSBjb25zdDogZnNsLGVuZXRj
DQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+IA0KPiBZb3UgY2FuIG9taXQgaXRlbXMgaGVyZS4NCj4g
DQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBwY2kxMTMxLGUxMDENCj4gPg0KPiA+ICAgIHJlZzoN
Cj4gPiAgICAgIG1heEl0ZW1zOiAxDQo+ID4NCj4gPiArICBjbG9ja3M6DQo+ID4gKyAgICBpdGVt
czoNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogTUFDIHRyYW5zbWl0L3JlY2VpdmVyIHJlZmVy
ZW5jZSBjbG9jaw0KPiA+ICsNCj4gPiArICBjbG9jay1uYW1lczoNCj4gPiArICAgIGl0ZW1zOg0K
PiA+ICsgICAgICAtIGNvbnN0OiBlbmV0X3JlZl9jbGsNCj4gDQo+IENsb2NrIG5hbWVzIGFyZSBs
b2NhbCB0byB0aGUgYmxvY2ssIHNvICdlbmV0XycgaXMgcmVkdW5kYW50LiBJdCdzIGFsbA0KPiBj
bG9jayBuYW1lcywgc28gJ19jbGsnIGlzIHJlZHVuZGFudCB0b28uIElPVywganVzdCB1c2UgJ3Jl
ZicuDQo+DQpPa2F5LCBJJ2xsIGNoYW5nZSBpdHMgbmFtZS4NCg0KPiA+ICsNCj4gPiAgICBtZGlv
Og0KPiA+ICAgICAgJHJlZjogbWRpby55YW1sDQo+ID4gICAgICB1bmV2YWx1YXRlZFByb3BlcnRp
ZXM6IGZhbHNlDQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K


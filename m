Return-Path: <linux-pci+bounces-14600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEF499FE23
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 03:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD114284C88
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 01:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9FB433C0;
	Wed, 16 Oct 2024 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k5QmvrV2"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2049.outbound.protection.outlook.com [40.107.103.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5BB28EA;
	Wed, 16 Oct 2024 01:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041715; cv=fail; b=ufh0ysorc9kNu6EvSL/CO4lyvd3wNCTgWHya4/VdhtmL7xB2LmgqxwqRQ2BmEixSN+QEJCWEWmtD22PgNLZx2uvD/byJ6JTY6Bm7p+9zldkWM0MB3NEEbGBEMYnhOnspbVlZPCjdEL8+2ch+Frf6hY/GOoVRfZup/Xvy8E4qsLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041715; c=relaxed/simple;
	bh=aWsySaMQ8Eaky0Um14vRNyVagDTJSASgWyvd77N0Fts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h1tp/qcdZAvKyaTH116/OgYiCLDlvCpsilFsn2PbqHstb4vGjhvVFEEzylBMdICtm643KODMJicK9wha/FypQ92TYQiGE/uVwN7/YNR6h0W0HsJjW/msEutaFa6L2DRyvJ8N0dcrO0JjgZqNP1OV4bcuTAGqnGzX89NPvD+WO2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k5QmvrV2; arc=fail smtp.client-ip=40.107.103.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gh634w4CGO6wdqbilAvrIfl5ZykMwruXDJLU7or9PcwSaaHlSWlOnpm0Jp3DDOBqWlj0GhCsOgiDXG/qR/uOYtwrKhB4F1EdQMukmWiI6DpXLskhOKeKs1/qvvSj311sk8VVQdPnRlhPoV0by7OhyxmwXdnnZZEe6kfJOZO/PQ0/SBhmR/93XRQ/zx5b5EYXN1at/ikCHK376JvtNr99M/V4tSOwbr49tumPaCZ/+Gb0yy0uAAPoibETFzKyTqAoesaETK6LaSNpYEofsvNQo5ieK0u7Zbfr31G8CHEtVL5PBmLPX7AmUm5wvfwr+wc4raqLEpse76sgNSMlcuJiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWsySaMQ8Eaky0Um14vRNyVagDTJSASgWyvd77N0Fts=;
 b=UjEol7as64jMmBlAhG1K54g9EMksqanB0CWvhe6tkkDNDSJrHSBkRw1S8BHgrGRIOd1AlpMUkI+ygijsfCJxn3dmYYPGhkxFQRLJOtuSTyqDYA21YAiwGDFCeRoFtDTFuwy5GokTpZUjtsU17A1YNSei9xG8pNfplL8iVGAJCF7J7MhOK3BJQ0LaCPhPfjW0vMk0qIApXIO9zz8FxsvBFU0zdZ7UGA1wRgZC2CPvVGyjoq1ba6IIY7RhJO5HCvast9tsnw98TdfOCqlvr72v7Sl+5DAgBpQSYPAEhwLDIk3WI0DYD0L35iWHVW+62Q6QpVSJ7HPCFhfCqCtYhjqvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWsySaMQ8Eaky0Um14vRNyVagDTJSASgWyvd77N0Fts=;
 b=k5QmvrV2Uz2Vq9DbdXxxA99ePo5rfxh+zLo0Xioi3w37koJNnEXvR7t8A7B/fG1G88LgUfvptQzvID9rxTz3t3m4PiOYF+vtAzQMTQT/piBFuf+LRnpEyNLTBipQLPnTVWHG1DFZebrZ4FnDoN21BOlSgf+ySUSGUDUS+eVqViAxRaE3uHBdxEWkLwCuTrnSJwU6ClW+vT9ll70Ewk0f0w/XEqV98jaMMTgQai962ie2FVz6Yq3Lpf0QKtqxeHrx48qdMwEecQGpoNDR5HM/FF4iO4zKUZvWkBAgocSazxNd6bgp+urUlgYi8yEOcbjmGihBgfsog0IK7q1myrHeRA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9719.eurprd04.prod.outlook.com (2603:10a6:102:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Wed, 16 Oct
 2024 01:21:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 01:21:50 +0000
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
Subject: RE: [PATCH v2 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Topic: [PATCH v2 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Index: AQHbHwQPe0FiChmkLUS/Jev+GMlg27KH8ysAgACh/KA=
Date: Wed, 16 Oct 2024 01:21:50 +0000
Message-ID:
 <PAXPR04MB8510494AF13FADC89F608A3988462@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-3-wei.fang@nxp.com>
 <Zw6M/rjt6e6iZ2zd@lizhi-Precision-Tower-5810>
In-Reply-To: <Zw6M/rjt6e6iZ2zd@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAWPR04MB9719:EE_
x-ms-office365-filtering-correlation-id: 8596f202-889c-454a-9824-08dced80e915
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?UkFoaWExcUdXSWw3UTFxRjc0eTUycHJKSlJzbk1XaUM5dHpjdCtEaXBtVVVp?=
 =?gb2312?B?YmEyNWtkbGJGalFNTm9lOWdkYVlHbmpoaHBWd0VkNCsxV1lWOFhyK2svQnpX?=
 =?gb2312?B?QjgzZGpmN3F0N285R2FvV2d2dlNZbXE4TmVLQit5aTlYRWlyeU1VeXpUaENj?=
 =?gb2312?B?NDdrczJDMnk2V3BXQjczNEZpRHlybUpQOFdQRXY0V0M4aG0rQmFONEczN0Ex?=
 =?gb2312?B?VFZHbXEzdWRYTGRtNGE5M3JFWDhPemZXR3h1RG4wb0tFUHRyVzRwcldRdFBT?=
 =?gb2312?B?T3d1MXNrcE1XQXZET1NMZzV0N0RqOHhTSGVoTXVXRFlheVpiRmM0Z1UzU04y?=
 =?gb2312?B?U2dNcTVTOW9LaEYrdVFmZk5XSUxlUlRIUHl0T2NBQ01zRDJjNlRRY0FMT2RE?=
 =?gb2312?B?R2tRM1U3NzAyb3VkMUp4cWVMN2wxcUVzdTZqQ1pBTnRtRHNBMVZPWWduVFUw?=
 =?gb2312?B?TkY0UGRhNitXeDBKRmFLaXdhdzZ5anBHUUppcVBjZS9TL0UzT3VNc1JtemJj?=
 =?gb2312?B?ckVGRnFVRkRpbHlRcjJvUEF5clYzL1d6Snp6V0ttc29ORzZ5YXpxZXM5dXd3?=
 =?gb2312?B?SVFWODRQdXVESUJxRC9mQ2xZVHZRaXZvaVJZMDkwaFluNnUzakowQ1p1L2lJ?=
 =?gb2312?B?cEpoMDdRdlBFTWVORHRoeDZodFBNbUZmbm9ic2wwOVFOalFvTVNmZ1hpQzJ6?=
 =?gb2312?B?djk1cDRkOXk4K1FUdFZNSmxHdkk3Y0IvY1RMaDlJdGJPbXNUbjdSQVFaRDRB?=
 =?gb2312?B?cDJHZDJzMU5oV2JFSkVDNEtYUUp5UWpDaDN2TlU3UGZJUExaZEhSMTZSQU5S?=
 =?gb2312?B?S2NnRXZUeFJKbDNSQlVyanU4b2ZoSktNcVd5cFZNL05MWnBQV3JXS3pQM2Jl?=
 =?gb2312?B?amxpRnFTL2haMWRxWDJzZThmeWc4K1dZcXF2UW12bEwzNmZWSndYdUFIS1Yz?=
 =?gb2312?B?ZUVSZnlUTWVKbnlzcXB6Q1hsTU5MRUhsVzZQYUFCVjN1UmtGdjBETFMwTzkv?=
 =?gb2312?B?UHZNdVNNM1R5TVlzelVNMUJpbHNzNWUzWGJvWlRNS29WMzBuNmp5UEh4WVdu?=
 =?gb2312?B?Rzd3UmlGL3ZrRnZ6ZmplM3JFT3lnRFJYUDgvSEtPcEhmL2RiWUNJRW8wemt3?=
 =?gb2312?B?dXpXU0RsRTdFT3k1bDVtb1V5SXE4QTZwcU90RjBLTkdBMVJMK2dnRnBvTGVE?=
 =?gb2312?B?OUExZkFoUjBxbkkzSWxNWHRZK3pMU0NiUGpBajlWWXRIWGJ0Q255N3lrLzFo?=
 =?gb2312?B?WmYrR1NOeTdySTEzSmU2dFZkMzlETmdwMHRPejlHaXBzTmpSREdXd1Vhbnli?=
 =?gb2312?B?a3NnTHRjODFOanh4U1RaMjFFd1VjR3lUdmtnVHBWc25JcjJzT1JPN1NKTHdp?=
 =?gb2312?B?SXNJQkZSNU1Ga2E5VWhINzJZUUVSR3lvdzVuVEZBVTdjNzZHcWtLRm1oK3FC?=
 =?gb2312?B?REZaMkZBdHg0bVFIVy9la1hsKzJqTlpEMk1LemxkRTVWRDNHZHpEeUVkUlRD?=
 =?gb2312?B?bVBBTnhpYmZNU21mZDBXM25OVDJVOCtOWUxMY2MxRDdDYUs2NFJXUVozYVZt?=
 =?gb2312?B?TW5Ud3dJcmsxRjcxSTF6UExFS0htUndxL3dPWWI1TXBER3BKWHJPVlVudHhG?=
 =?gb2312?B?NnJmRTl5ZjNTRlpUUlY1am83N09YWFJ3Qk8zekRVb29qVWlJbmR3cXJKNkRa?=
 =?gb2312?B?VWMyZW1YYlkwc2F5Z29vTHhLeUNWbWhmUFVKOWREQmwybG9HUjhXUGxCdjNO?=
 =?gb2312?B?djhtUEs2dHgyYTlna2FrazNKVUY0NjMyVGZ1RFp4M2tIZzJsNytFREU5QXlH?=
 =?gb2312?B?NlZkQkRzY0NKTkNER0hoZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RU1JNnQ5OVRDUWtOc3hFU1dTbnNQTXBheTkvOG16Q1VmTmJQWkkvMUc0TkFG?=
 =?gb2312?B?OHdZL2FTNTZZZHkwcms2K3IvR2RUTUo3cWFKMWZRMkRmVGtxUHBKaW04dXhN?=
 =?gb2312?B?WHBUVURqVi9WZDR4Qkdhd2VLNWk4R3pJclJlcWJucHZyOHp4cC9hU0txQnBD?=
 =?gb2312?B?U1NtZHg4VXhUbWlMVjBFT045UDdyK1VMQW16UTJOcU8xcmV4OVozNW92SWlL?=
 =?gb2312?B?WTBrZHRMZ05UeUNRY0doUmRhUDdyc1hjZ1dpNk9JeTYzVjliK1lUWEVjeUho?=
 =?gb2312?B?ZkV3bzF2Wmk4SkNXS2poTEdGSXEwSFZXcE80RUxDaEdtRmVheGRydHp4N0Fk?=
 =?gb2312?B?RDh5WVhzenZBZEhlNHpCbzVrWCsrankvNHJjaFArMi9kQnpyVEtmK3ljSlRy?=
 =?gb2312?B?NmJrNGowODZXdEZQeSs5cGdtZWxpUHVyUU40R0JTaXRjMEs5ZlFKT2kvNUJi?=
 =?gb2312?B?VjM2OFkrMW1vaERHeVVGTkN1Q256eGdmYzlKR3pXSmIyajg3b25lRkZPK1J0?=
 =?gb2312?B?MFdBaUR3SzhKMWZ5Zkk1UUExdkx6VjQzZk9vVWgwWTcySHhoYThzSUVaekRJ?=
 =?gb2312?B?YlR1akR0M0VENjNYbkdEOTF6eERUdktZUDZITlljRmdKMlBEZjhPdHM1a05R?=
 =?gb2312?B?U2x2VjE2U3JrTnNtVmVvWkJqZzRsU0VFNzA2bFdtelR4Zm1iWG1EK3ZNSW9U?=
 =?gb2312?B?SGlxMUtZSllSdmFKdk43L3M1VUZQUnR0cDNxWS94NXJUSDF2QkROSDZsRHdv?=
 =?gb2312?B?V1FhdEVSNHcrekJHaWlEaElFUTYyemFpS29IUnM2QmZ5OWsxbFNqTlhNZE9V?=
 =?gb2312?B?VDZlWHFGR3p3d21MTFZQU2c4OWRSZTgrckFhVHRtN0x6NGg0TlNMQXcrMHU4?=
 =?gb2312?B?Y0xsR2JCK1gvY3B0RjZWV1IyVmJueUtPU1RSTm90cEJkTzFUL1RiUkZZOURH?=
 =?gb2312?B?MjJUQkVncXhoeDRUR2VnUFFlY2w1N2Ztb3ZramcxOGJzT3RRNG9ib2dGRGtn?=
 =?gb2312?B?K01UeUdIbXlLOGFzSy9UNVRsUEd2eVE4V1pTVFFuT1NJRTdTenVSZml2OXNl?=
 =?gb2312?B?TnlCditZclo0NHozWTZBSmRTcTRYREhJcTQ4SCtIQ2VSQ01vZkd1NHhWOHFV?=
 =?gb2312?B?bmRwQmJhdUY5ZktNdjNuM0FVSVF6MU5IZDBBMkFHVm8vU2tQNDh2Q0ovTVVq?=
 =?gb2312?B?djVIYkppdFcrOHYwbzBjTDFtRXJKYnJlTTNDQ0EwUWg4dXBaV2NLVkVMRFJO?=
 =?gb2312?B?Nml3cmxZaFB5M1VVOWQ2Z0diTXRRU0hLdGZvWlNZT0U0Qk9lRzR1dmh4MmJN?=
 =?gb2312?B?Z2JQU3pYaFlxdzhzM0dmZ2xrMndMaUUrNmhTdVBBV0V5L0QyS25zeWV6K3Vw?=
 =?gb2312?B?WjJXSUhneFdKclEwditXczNWNlNaQi9QQUNqN3plSTBPeUxBMDVleUs2Tlhx?=
 =?gb2312?B?Tk9yYUtRTGx1UnRCMGEvSS93Y0M5WWFiSkd2d2N6emtqemJzNm1aN0owcEJW?=
 =?gb2312?B?OFFpb296NEtSSUtUNm9MWjdhQnc0N3RqaEwrSHNMbm9mSnAzcG9zZ2xSenNU?=
 =?gb2312?B?M0pJYjhSZlhjVWdhVEtkbFdId2JSZTJneHdXcmR5QVBxWHdXTnlhK1V3M3k2?=
 =?gb2312?B?QXJRQkRCRUFUSmxUVThmbmZhckgwaElVS0E3cDl2OG5VZG5oS0FoSUpWUmxh?=
 =?gb2312?B?aksyUlczSU1MandwaVlRWlVtejdBQk95T0hHeUlHQnJsbm1wZm9iTnhEZXFK?=
 =?gb2312?B?WTBHT2NVTVlJbFF5SDN3UVdQZTBNZnRxdjgzbUF3Y1BHZWpyRzZRRXZyeEV3?=
 =?gb2312?B?MXV3WFlBVHVGMW81SG1MTlgyUFJOYk0zb0IzYUc5Z2VkVWV4czVpYmRQS0lQ?=
 =?gb2312?B?OXRHS2dEVkpzUnErQTVtNVRyS05LSTBJTlVxVXI3L01QSm5uSWtGQVdBek50?=
 =?gb2312?B?YUZyNmZUb0dqNjZEcHJjNFI1WUZsT2FYZmQzV3MzK3B0VTNyVWNiMmlQNnBz?=
 =?gb2312?B?UWp5NFhUY3BmVnU1ZkJNYkRVNzlac0Y2ZVROVEMrZnB6cHY3NjN2SEsrdjNw?=
 =?gb2312?B?SllqdW5ydVA5Y2JxQ3ZSNDZyRVV6MjdKemkrSGN5THErRDdlTmszYXgrb09k?=
 =?gb2312?Q?4WC0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8596f202-889c-454a-9824-08dced80e915
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 01:21:50.1466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /83Ah5mOAqUBby4kHbKn52jKtHMiS50ue6lBxaFJASq65sL498O2fqqGSrQchxWTLmAccL2URWR87C6tU6AAMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9719

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjE1yNUgMjM6NDENCj4gVG86IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgcm9iaEBrZXJu
ZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IFZsYWRp
bWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+OyBDbGF1ZGl1DQo+IE1hbm9pbCA8
Y2xhdWRpdS5tYW5vaWxAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNv
bT47DQo+IGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldTsgbGludXhAYXJtbGludXgub3JnLnVr
OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBob3Jtc0BrZXJuZWwub3JnOyBpbXhAbGlzdHMubGlu
dXguZGV2OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtcGNpQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIG5ldC1uZXh0IDAyLzEzXSBkdC1iaW5k
aW5nczogbmV0OiBhZGQgaS5NWDk1IEVORVRDDQo+IHN1cHBvcnQNCj4gDQo+IE9uIFR1ZSwgT2N0
IDE1LCAyMDI0IGF0IDA4OjU4OjMwUE0gKzA4MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+IFRoZSBF
TkVUQyBvZiBpLk1YOTUgaGFzIGJlZW4gdXBncmFkZWQgdG8gcmV2aXNpb24gNC4xLCBhbmQgdGhl
IHZlbmRvcg0KPiA+IElEIGFuZCBkZXZpY2UgSUQgaGF2ZSBhbHNvIGNoYW5nZWQsIHNvIGFkZCB0
aGUgbmV3IGNvbXBhdGlibGUgc3RyaW5ncw0KPiA+IGZvciBpLk1YOTUgRU5FVEMuIEluIGFkZGl0
aW9uLCBpLk1YOTUgc3VwcG9ydHMgY29uZmlndXJhdGlvbiBvZiBSR01JSQ0KPiA+IG9yIFJNSUkg
cmVmZXJlbmNlIGNsb2NrLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIEZhbmcgPHdlaS5m
YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gdjIgY2hhbmdlczogcmVtb3ZlICJueHAsaW14OTUt
ZW5ldGMiIGNvbXBhdGlibGUgc3RyaW5nLg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9uZXQvZnNsLGVuZXRjLnlhbWwgICAgfCAxOSArKysrKysrKysrKysrKystLS0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
ZnNsLGVuZXRjLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9u
ZXQvZnNsLGVuZXRjLnlhbWwNCj4gPiBpbmRleCBlMTUyYzkzOTk4ZmUuLjQwOWFjNGMwOWY2MyAx
MDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Zz
bCxlbmV0Yy55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC9mc2wsZW5ldGMueWFtbA0KPiA+IEBAIC0yMCwxNCArMjAsMjUgQEAgbWFpbnRhaW5lcnM6
DQo+ID4NCj4gPiAgcHJvcGVydGllczoNCj4gPiAgICBjb21wYXRpYmxlOg0KPiA+IC0gICAgaXRl
bXM6DQo+ID4gLSAgICAgIC0gZW51bToNCj4gPiAtICAgICAgICAgIC0gcGNpMTk1NyxlMTAwDQo+
ID4gLSAgICAgIC0gY29uc3Q6IGZzbCxlbmV0Yw0KPiA+ICsgICAgb25lT2Y6DQo+ID4gKyAgICAg
IC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgICAgICAgLSBw
Y2kxOTU3LGUxMDANCj4gPiArICAgICAgICAgIC0gY29uc3Q6IGZzbCxlbmV0Yw0KPiA+ICsgICAg
ICAtIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBjb25zdDogcGNpMTEzMSxlMTAxDQo+ID4NCj4g
PiAgICByZWc6DQo+ID4gICAgICBtYXhJdGVtczogMQ0KPiA+DQo+ID4gKyAgY2xvY2tzOg0KPiA+
ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IE1BQyB0cmFuc21pdC9yZWNl
aXZlciByZWZlcmVuY2UgY2xvY2sNCj4gPiArDQo+ID4gKyAgY2xvY2stbmFtZXM6DQo+ID4gKyAg
ICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDogZW5ldF9yZWZfY2xrDQo+ID4gKw0KPiANCj4g
TmVlZCB1c2UgYWxsT2YgdG8ga2VlcCBvbGQgcmVzdHJpY3Rpb24NCg0KT2theSwgSSB3aWxsIGFk
ZCB0aGUgcmVzdHJpY3Rpb24uDQo+IA0KPiBhbGxPZjoNCj4gICAtIGlmDQo+ICAgICAgLi4uDQo+
ICAgLSB0aGVuOg0KPiAgICAgICBwcm9wZXJ0aWVzOg0KPiAgICAgICAgIGNsb2NrczoNCj4gICAg
ICAgICAgIG1pbkl0ZW1zOiAxDQo+ICAgICAgICAgY2xvY2stbmFtZXM6DQo+ICAgICAgICAgICBt
aW5JdGVtczogMQ0KPiAgIC0gZWxzZQ0KPiAgICAgICBwcm9wZXJ0aWVzOg0KPiAgICAgICAgIGNs
b2NrczogZmFsc2UNCj4gICAgICAgICBjbG9jay1uYW1lczogZmFsc2UNCj4gDQo+IA0KPiA+ICAg
IG1kaW86DQo+ID4gICAgICAkcmVmOiBtZGlvLnlhbWwNCj4gPiAgICAgIHVuZXZhbHVhdGVkUHJv
cGVydGllczogZmFsc2UNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=


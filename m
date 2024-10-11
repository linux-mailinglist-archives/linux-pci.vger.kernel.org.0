Return-Path: <linux-pci+bounces-14251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B9B9999DB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 03:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B8D1C22AFB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 01:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F071A179BF;
	Fri, 11 Oct 2024 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a5lNPgTS"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010004.outbound.protection.outlook.com [52.101.69.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B315716419;
	Fri, 11 Oct 2024 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728611786; cv=fail; b=R/yDdq7q5XX7wkUaMuZBCLYPgjQCiuHo1rGqJqSmWp9VPmAbr66DoRMEobtHhG+BVMmKt68MPfSpZo7bJ5KWdwYVAOwj6h0LR1H5ruxEyXtrgJQt1JlJ6EDIYaw7yBG4RhYOmoNwZMLHUFUMETbTYAcxjREWYa6Y7yXfP5lFIkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728611786; c=relaxed/simple;
	bh=Hieg99cY7dAHs/sH3fVgwH0u5jj0aD6KTmDqzCBGAZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kaExDIvnnkNTFlr0gPpej1SjTNFYi8ydL45gq4ChTMD3c3ashEzgG+BXzgbF3yiq240XQ2uQo+c0ZAcJm/+3OFM8GHZWJ/CqjUtR7jq3PtYsynm/QiVI+lZzatFwoQ8HvVm/HfSCRfiPh9JaUGbGRFw9WvpIQuZrblKuuJmTJV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a5lNPgTS; arc=fail smtp.client-ip=52.101.69.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oz7s2T86kRKsglmf74vgIj2SJPgvuD/pLRdovJrY+QUVrKCcSF/0i81nv3DcTCO1xv2uqRTf/3ceSFEdOZylkhBTVFT0PZXb6OBmbqQm+hLASccbcXs+z0b8J24lVZmRB9sapDTVo/BjiVO/TQOmm3iKb4cYPaD34WACakp+pXGK/HELRz0ygD08J4dSIUPQXlUA14YIbuDSNSJSWH3BprW1yfsjcSJ4Yq/yDeu5Xjfs4rOrqg4gdaZOrT9x0PI6eDgKgF49EI2/MA0zRLVvLAWmZvHGuK0rc5KjnQtF8bDK7vIhkkbYuxmCtY8jsnNN8lVxWDh/u3rjXHL5CsdQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hieg99cY7dAHs/sH3fVgwH0u5jj0aD6KTmDqzCBGAZk=;
 b=lvAPa0kyDFihxI26BGEjbACUET5h0FfxdaXZ9VIdXpesW4TydzFqrcyFW0ZlIZn/wkiJOdrJ0WrrDYtDI/Mqx5cJ6ttSlFs1rPLfdKI8nJo/V7+EUx3dtoIGoPKGGnApn4UZr3esw9oITkT8BHVQJnEn1XK9+muyTP0KK0fdz0l7GF0xxMwfjArPBW6gC3qZ9YleRpNlv1EKuH1nZIUOwOJgcpBPZUNL/xNFrQy4W9t/A7RujBOkL44Jq2RHDqTaAxJqwhtzepsAK4xClkS0FD5i3R9jkF+j2hSwdUVRX2Tra6qwtjKTcpnVRu/364ceS0rI16oQa89SIHNW2B6jsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hieg99cY7dAHs/sH3fVgwH0u5jj0aD6KTmDqzCBGAZk=;
 b=a5lNPgTSV2Q5U6jgLVwObqCL5ijsN2voOsY+WTKe9DAdRO0f4xtHjpBgbrpvF9OVdaVeVWtHGc89lgxh+6bddSMkVvKCjffkOPv7evr2VygDcUHRIaIjhVB3a7+0jb1nU97qjE0RSh+xzkolJ/55EinjceDDJFNslICGfh8BT7TXJVrICjyFdpKvdk+jVBULYX/dMWYPrNoEeiggCe807JsYlzEqgEvGna5jsCPZ+CTEkfVRjNlsydM6eHPPHTNtRO7IDj6nGWYA8n+IPIFJr9/54sgVV7rLLjC0g8Ie9myTsu9VcVK7P6ProKX+RxNugBNb0DQyKCJz97apIueLYg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 01:56:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Fri, 11 Oct 2024
 01:56:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Rob Herring <robh@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
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
Subject: RE: [PATCH net-next 02/11] dt-bindings: net: add i.MX95 ENETC support
Thread-Topic: [PATCH net-next 02/11] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Index: AQHbGjLp/l9Es9i+jUim/i4c8s01WLJ+nI6AgABJhACAAFjFMIAA258AgACyE1A=
Date: Fri, 11 Oct 2024 01:56:21 +0000
Message-ID:
 <PAXPR04MB8510DDB03D58B15A9F03DF4B88792@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-3-wei.fang@nxp.com>
 <ZwavhfKthzaOR2R9@lizhi-Precision-Tower-5810>
 <20241009205304.GA615678-robh@kernel.org>
 <PAXPR04MB8510E8B2938E88DB022648F588782@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <Zwfv4if3mWPLStb/@lizhi-Precision-Tower-5810>
In-Reply-To: <Zwfv4if3mWPLStb/@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8865:EE_
x-ms-office365-filtering-correlation-id: 8700c9c6-87c5-45af-bfd5-08dce997e7b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZnlTQmxybUhqUWVtWTdrM3pqUWZBckhyVGFXZ0wvK1pDSFJlYWx0bFNZajdT?=
 =?utf-8?B?RTV4a3MxRVNiVmYwQnUrT2hYYURJdE1qVE9rR0dyZzNLM1FGRU1nUzlac3JS?=
 =?utf-8?B?NGQ1ZDZTeXk1dVk4eGFTaEp2OXBwcURWVDNvd0lsSWVPZjZLbnZjWXJrbUs5?=
 =?utf-8?B?NWU3aVBTVVdJVkgyY3pqNHBkNWFiSzlsTk9IQ2ZQUkVIYW41TllDYXdkby9q?=
 =?utf-8?B?eW9jZEdrK05JVDVLaytCQzhnZDN2eEwzRFpZVnJzWjFpa1RWeFJrSkNjd3Ew?=
 =?utf-8?B?TFJoSTMveEtpcWV2ZzR6a0taZmVhSzl2WHc5d3ArNEl6S3lZTnM3NkJNeTlB?=
 =?utf-8?B?b3h6eTAxWFZpdGtxTi9aK0h3dWhVbWtHMUhkWGFKUWU1blQvRGcrbFN1ZEhi?=
 =?utf-8?B?dnA0ZDZkK1lFbzRkV3JLT3piY3NHSUNBYVZLcWdidzhWZ1gwZXZ1aTM2UmQ1?=
 =?utf-8?B?WTcyQlZlcXpxa0Q2YU1uVTk4Z09kRzZGN2hGd2tCTjZSUkFjd1BER1IzMFM0?=
 =?utf-8?B?R0FQQUZlOVE3UFRlU3RjQ2RZa0lKK0ZaNXJYQzNGMzFYeE8vbWtYY240TGxZ?=
 =?utf-8?B?U1g1ZFZqVEh4M2NMMEtzU2FkYkZGdHpaK2NJYkphT3FURW92d1hqL2Zmc2dv?=
 =?utf-8?B?bENUUkYyd0o2ajNxYXNMQk82dE1Bd1FmSk9HaTdBMXU0bzdtb3FmQXJPQWFD?=
 =?utf-8?B?a0NZb3NmQ1ZCbWNaTnF6TnpDTVZ4bTc2Q0lRT0xpYWszZmhKVHhPYVBoOEta?=
 =?utf-8?B?ZWl6RGdaTitpcVZZYk5EbE5WSTJPVnpYcVJxYStVMVJ6dFYzL1BCTFRMcjBO?=
 =?utf-8?B?SEgxMk4vWUFtOWNyTVpZYUxCc3NhNEJXN1MzTmRycTIvNWczTCtQSUZibDdv?=
 =?utf-8?B?bTYwZ0lwY2EyNVdDbFg3LzFiWW1QbzVsSUhvVzJXODBoWHJvVmZVUFlHSWl6?=
 =?utf-8?B?Y09UM1V6TTQvS05aSDNRZ2F6QlhHcjMyTFZ2L1FzQ2hMcEpQcURsSmlibGln?=
 =?utf-8?B?ZUwzajhrZHFXOHp6UTNLS0I2MUkrL05WblpvaTFMbDN5cVRvWjZPSVdXTHZ0?=
 =?utf-8?B?SVlZNytOK2czaWdGdHNnbzlUZytESWRIcUY1ZWEzenJxUTc0amNMV1NaaXpN?=
 =?utf-8?B?S2VDN1NoVGZ6dUpKVVFSczVQMHhMZHg0dFl6eGRyaHlkWTB2Qkw5clVkL0or?=
 =?utf-8?B?ck5wb1NiSE4ybmpQdnoxZkNFUzBoV3Y1d1BPek9hcGdncW1WWHViT0Rzbkdu?=
 =?utf-8?B?VzJDU21VVmthS005MHVSWkIwSnlqRzltWkgzbnB4SU45Y01FTWZFSHM2ckpv?=
 =?utf-8?B?QkRScUovTkhKSmFFMGFRaktBTTk0Q1VwalU0clFRMUVqR29kNVRPWERkZEVo?=
 =?utf-8?B?R3pqekhsV3RPbHRBNDNTRGlaclhvZ1dqMUxJSXh2WkI3RjkzZEpkVU82eDZX?=
 =?utf-8?B?UzA3eVJrYlliaU8wUks0NTBqME1qL3RHTGo2enpsUHJWVUE3dzE5U2Z6Y2RN?=
 =?utf-8?B?UjlHUldXYzEzMmk2VEI2dmhBcUtmSFA1K1VTMmdJQmVOclE3YS92dXZuVHdz?=
 =?utf-8?B?NkpMdWU5bTFuMk0xMFJJSzgzZ2RDUDdKb0tpdHp2djRjeDNEdVRTeE5XQWE0?=
 =?utf-8?B?T0hvUUpzd09MRDJWVWd3Yk5OVit1V3JpU3dHVFE2aTMvNnltWWEzWGw4dEhO?=
 =?utf-8?B?UHI4VE1venc5bnV3YmozNE45VjVOL0VzekpQK200OCtoQ002Qis5bDN5VHBL?=
 =?utf-8?B?OWtVWW9oSG90d3ZKS1o5dDI4cW51R0JBWUp3VEd0VnpPQi85UENzdE5EYjRF?=
 =?utf-8?B?aExZZ21GUlRBZjZXam9xZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Njk2VnNOQkRpeU8xODlhRXFsby9NRVBpcEU1WGlpRm9NUE5POUdUVERtVmxV?=
 =?utf-8?B?WEFLVG9lZkVHZndQNXJlZmR1andUWUVLZURNcnVMem45U1p1VnB4cWRLZ05D?=
 =?utf-8?B?dDNkK0l1MjF4dUpYTTRGOWpwSEc1YkpOa0hvdHM3MWJBbjdiNWhMa091RVN4?=
 =?utf-8?B?aFEra2k0bkxxdloxcTdIQlpSeTRBTjFUc29SNXBOdzFxS3RjcVlXLzZTdEZZ?=
 =?utf-8?B?UFluRjloUDlrZGhBeWRBN3VvdGcwYjVVai9nN1BWR21oZ28xdVQ0ODgxQU8v?=
 =?utf-8?B?bCs3M1lVV2VrNUJqVlhWQ3pyRTVQcmxQbmUxT2xneHpjOENDTHhJdHhjcFlJ?=
 =?utf-8?B?eGR6MUNGbTV1TWw2OCtMVWpMZ0ZTK3lxMVk5ZzB1KzZGQk9MbGxJS1MrUlVX?=
 =?utf-8?B?dGdPYWhITEcyYzFmcG1IYlBMOC80Ynh0N1dlRklYYitWeEdKaVgyOGhJVVVI?=
 =?utf-8?B?L2Z6MDlra01hTUZMOFB6SkxCOEwxTTJFTnRncXBPZTlsM3JpU1phTE5HanZo?=
 =?utf-8?B?SlBnZHVEbjQ5S2ZyMDl2VXdFQ3htZ0xyL3pBdWxKVVJRMGVsUGZMRUFYbGVs?=
 =?utf-8?B?T3pIWlQ3RU5UcXBueWEwaGxXR2FhZXhuNHdGaVNtaUNaQnIvQkFpbjlvU3Ax?=
 =?utf-8?B?RXhIRUhLUVJSZVpzS3l6V0lLcTFLSlBUeTZ1aHFBNk51bE5DVHhvV0s4NzFL?=
 =?utf-8?B?RWdoeWsvWFM0M3Iwc0NLMEVNZ3gyL0k5aHJHTnFBQlNjak1FQ2ROdWhUNDBK?=
 =?utf-8?B?a3U4M3cvMnlSWUszbm5HQjNwQVhuaTNneXV2aXhtVEdLUjdzcmdkM0k4U2Jn?=
 =?utf-8?B?eWhqMTBKQVB2RStJeTgyRjdkbDRLSUdIdlpGQVZlRWFud3lZYlJaQ0VYQVpU?=
 =?utf-8?B?UFc0N3VtWDRuNFdDMGpxZjBGbnBSVGxVUUxuZWo3R2U5WG5DRVkyS3B0QW5i?=
 =?utf-8?B?c1BhemtudWZSUFM4MHFzK3dzcmxpbFljMytQRE94dDhpbGlYWDhtL3ZuV3F3?=
 =?utf-8?B?T3BJZlJFMzl4d1dWbjV5UEJsYjd1aHFIaWxzSFdzVkZERVFsSjh4TzYwWllJ?=
 =?utf-8?B?NTVTTm12Wkl6cTBKNkFoMXloTWhDUEtvZjJSK3VCZFQ0blZxTnN4cy9mVGZN?=
 =?utf-8?B?UTJBYWgwazh3OG50VjZpMUo2VEtPb1luQWpiN3pyZ1BpNDl6Ym9XM3d1Q2FL?=
 =?utf-8?B?YzZaZDMyTncxWUdkSWJvay9wcG5PNEk5RWVoVnhkQnV0Q2EwTitRS3I3UXVJ?=
 =?utf-8?B?OEl5dDZjVFIybkxaU2VqVm1wQ2hHSG1WY0p5RXI5U0ZLZ1VTYmRaVDYrT1J6?=
 =?utf-8?B?Znc5V1pvZlVDQTR4VDFqVXdBWTcyTThsdVhTY0tnS1lmTE5Mb0FPTVFXTnFI?=
 =?utf-8?B?RklJMjVUS0h2bGtYaGIxcTI0a1B4QWxoM245b3M0MGw1UDdaZVlNcEhjUmpm?=
 =?utf-8?B?UmtVUzdCRTRQNi80UVFsUGtRSXBHcDhvZlBmQnVsWVBLWEdkVHJUdjJKT3hs?=
 =?utf-8?B?VkVPN3I0c0YyUEhzTVZKZnZRdTY2NGVyUEp6OG1taktTcVlUTlhjNXB6TFNR?=
 =?utf-8?B?S3NuUE8yZEhWME85U0g4MWZhNFhsTHlUWS95SHM4SE04b2dIUWFTMmhLZEQ4?=
 =?utf-8?B?NU1MRzJvNzhPaTRSdlpoUko4eEVXVXVzRnA5dHZoMUpnVU1QRjlTZU1VK01Y?=
 =?utf-8?B?azVqZ2JxY2JjeHJVZGJQRndvMjJ5VHBweVk4eGtYTEttNEltN3h1WDdvYWlN?=
 =?utf-8?B?TjV2YWVFaVlwb2pOcTU3MU9jdTFIZ2pUS3JVZGc1Z0tiRWw0Q01jYUpNdEZn?=
 =?utf-8?B?MjhNZ3hFbE92SkgyL3d3YXZLSWFCSjdJb1NOTDBVaXZUMEhVeVJ6K2xXN2VP?=
 =?utf-8?B?Mm9GTWE2YU1rUk5VR256QzBoOVRCOXQrNTM2SVFpNFlPN2hkYVN1WUFsb1Bq?=
 =?utf-8?B?My9PTzRhUW5tTnd6SFNPUTU3dGxkOVdidkpPUnp1M3p5RmtKS0ZGMmFML3Bp?=
 =?utf-8?B?a08rcE1BSnU1VlozbHhpd2cxNGpCcFc2L2lJYWc0emZSa1RmQ3RiT3g5Q3M2?=
 =?utf-8?B?ZFR1QW9nQVJRWUFqbmNqWkFKZW85ZEhwbGF6WFYzOWRkZVlKb2s2c1RmQlpy?=
 =?utf-8?Q?TVWo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8700c9c6-87c5-45af-bfd5-08dce997e7b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 01:56:21.6533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/ndubRmnGrRPdtj402omQocwML5/4+fo68xjwKo7+dTTVJG5CBMaT3Rjs53/9zonESUXgbjhDv2DtE4fjnGkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNOW5tDEw5pyIMTDml6UgMjM6MTcNCj4gVG86IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47
IGRhdmVtQGRhdmVtbG9mdC5uZXQ7DQo+IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVs
Lm9yZzsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRA
a2VybmVsLm9yZzsgVmxhZGltaXIgT2x0ZWFuDQo+IDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47
IENsYXVkaXUgTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgQ2xhcmsNCj4gV2FuZyA8
eGlhb25pbmcud2FuZ0BueHAuY29tPjsgY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Ow0KPiBs
aW51eEBhcm1saW51eC5vcmcudWs7IGJoZWxnYWFzQGdvb2dsZS5jb207IGlteEBsaXN0cy5saW51
eC5kZXY7DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgMDIvMTFdIGR0LWJpbmRpbmdz
OiBuZXQ6IGFkZCBpLk1YOTUgRU5FVEMgc3VwcG9ydA0KPiANCj4gT24gVGh1LCBPY3QgMTAsIDIw
MjQgYXQgMDI6MTQ6NTBBTSArMDAwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz4NCj4gPiA+IFNlbnQ6IDIwMjTlubQxMOaciDEw5pelIDQ6NTMNCj4gPiA+IFRvOiBGcmFuayBM
aSA8ZnJhbmsubGlAbnhwLmNvbT4NCj4gPiA+IENjOiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNv
bT47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7DQo+ID4gPiBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJh
QGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOw0KPiA+ID4ga3J6aytkdEBrZXJuZWwub3Jn
OyBjb25vcitkdEBrZXJuZWwub3JnOyBWbGFkaW1pciBPbHRlYW4NCj4gPiA+IDx2bGFkaW1pci5v
bHRlYW5AbnhwLmNvbT47IENsYXVkaXUgTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsN
Cj4gQ2xhcmsNCj4gPiA+IFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47IGNocmlzdG9waGUu
bGVyb3lAY3Nncm91cC5ldTsNCj4gPiA+IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgYmhlbGdhYXNA
Z29vZ2xlLmNvbTsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gPiA+IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDog
UmU6IFtQQVRDSCBuZXQtbmV4dCAwMi8xMV0gZHQtYmluZGluZ3M6IG5ldDogYWRkIGkuTVg5NSBF
TkVUQw0KPiBzdXBwb3J0DQo+ID4gPg0KPiA+ID4gT24gV2VkLCBPY3QgMDksIDIwMjQgYXQgMTI6
Mjk6NTdQTSAtMDQwMCwgRnJhbmsgTGkgd3JvdGU6DQo+ID4gPiA+IE9uIFdlZCwgT2N0IDA5LCAy
MDI0IGF0IDA1OjUxOjA3UE0gKzA4MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+ID4gPiA+IFRoZSBF
TkVUQyBvZiBpLk1YOTUgaGFzIGJlZW4gdXBncmFkZWQgdG8gcmV2aXNpb24gNC4xLCBhbmQgdGhl
IHZlbmRvcg0KPiA+ID4gPiA+IElEIGFuZCBkZXZpY2UgSUQgaGF2ZSBhbHNvIGNoYW5nZWQsIHNv
IGFkZCB0aGUgbmV3IGNvbXBhdGlibGUgc3RyaW5ncw0KPiA+ID4gPiA+IGZvciBpLk1YOTUgRU5F
VEMuIEluIGFkZGl0aW9uLCBpLk1YOTUgc3VwcG9ydHMgY29uZmlndXJhdGlvbiBvZiBSR01JSQ0K
PiA+ID4gPiA+IG9yIFJNSUkgcmVmZXJlbmNlIGNsb2NrLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gPiA+ID4gLS0t
DQo+ID4gPiA+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mc2wsZW5ldGMueWFtbCAg
ICB8IDIzDQo+ICsrKysrKysrKysrKysrKy0tLS0NCj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQs
IDE5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mc2wsZW5l
dGMueWFtbA0KPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Zz
bCxlbmV0Yy55YW1sDQo+ID4gPiA+ID4gaW5kZXggZTE1MmM5Mzk5OGZlLi4xYTY2ODViYjcyMzAg
MTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC9mc2wsZW5ldGMueWFtbA0KPiA+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9uZXQvZnNsLGVuZXRjLnlhbWwNCj4gPiA+ID4gPiBAQCAtMjAsMTQgKzIw
LDI5IEBAIG1haW50YWluZXJzOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIHByb3BlcnRpZXM6DQo+
ID4gPiA+ID4gICAgY29tcGF0aWJsZToNCj4gPiA+ID4gPiAtICAgIGl0ZW1zOg0KPiA+ID4gPiA+
IC0gICAgICAtIGVudW06DQo+ID4gPiA+ID4gLSAgICAgICAgICAtIHBjaTE5NTcsZTEwMA0KPiA+
ID4gPiA+IC0gICAgICAtIGNvbnN0OiBmc2wsZW5ldGMNCj4gPiA+ID4gPiArICAgIG9uZU9mOg0K
PiA+ID4gPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ID4gPiA+ICsgICAgICAgICAgLSBlbnVtOg0K
PiA+ID4gPiA+ICsgICAgICAgICAgICAgIC0gcGNpMTk1NyxlMTAwDQo+ID4gPiA+ID4gKyAgICAg
ICAgICAtIGNvbnN0OiBmc2wsZW5ldGMNCj4gPiA+ID4gPiArICAgICAgLSBpdGVtczoNCj4gPiA+
ID4gPiArICAgICAgICAgIC0gY29uc3Q6IHBjaTExMzEsZTEwMQ0KPiA+ID4gPiA+ICsgICAgICAt
IGl0ZW1zOg0KPiA+ID4gPiA+ICsgICAgICAgICAgLSBlbnVtOg0KPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgIC0gbnhwLGlteDk1LWVuZXRjDQo+ID4gPiA+ID4gKyAgICAgICAgICAtIGNvbnN0OiBw
Y2kxMTMxLGUxMDENCj4gPiA+ID4NCj4gPiA+ID4gICAgIG9uZU9mOg0KPiA+ID4gPiAgICAgICAt
IGl0ZW1zOg0KPiA+ID4gPiAgICAgICAgICAgLSBlbnVtOg0KPiA+ID4gPiAgICAgICAgICAgICAg
IC0gcGNpMTk1NyxlMTAwDQo+ID4gPiA+ICAgICAgICAgICAtIGNvbnN0OiBmc2wsZW5ldGMNCj4g
PiA+ID4gICAgICAgLSBpdGVtczoNCj4gPiA+ID4gICAgICAgICAgIC0gY29uc3Q6IHBjaTExMzEs
ZTEwMQ0KPiA+ID4gPiAgICAgICAgICAgLSBlbnVtOg0KPiA+ID4gPiAgICAgICAgICAgICAgIC0g
bnhwLGlteDk1LWVuZXRjDQo+ID4gPg0KPiA+ID4gY29uc3QuDQo+ID4gPg0KPiA+ID4gT3IgbWF5
YmUganVzdCBkcm9wIGl0LiBIb3BlZnVsbHkgdGhlIFBDSSBJRCBjaGFuZ2VzIHdpdGggZWFjaCBj
aGlwLiBJZg0KPiA+ID4gbm90LCB3ZSBraW5kIG9mIGhhdmUgdGhlIGNvbXBhdGlibGVzIGJhY2t3
YXJkcy4NCj4gPg0KPiA+IEkgYW0gcHJldHR5IHN1cmUgdGhhdCB0aGUgZGV2aWNlIElEIHdpbGwg
bm90IGNoYW5nZSBpbiBsYXRlciBjaGlwcyB1bmxlc3MNCj4gPiB0aGUgZnVuY3Rpb25hbGl0eSBv
ZiB0aGUgRU5FVEMgaXMgZGlmZmVyZW50Lg0KPiANCj4gSXQgaXMgcXVpdGUgd2VpcmQgZm9yIFBD
SWUgZGV2aWNlcy4gRGV2aWNlIElELCBhdCBsZWFzdCBSZXZlcnNpb24gSUQgc2hvdWxkDQo+IGNo
YW5nZS4gQXQgbGVhc3QsIEkgaGF2ZSBub3Qgc2VlIHVzZSAibnhwLGlteDk1LWVuZXRjIiBhdCBk
cml2ZXIgY29kZS4NCj4NClllcywgdGhlICJueHAsaW14OTUtZW5ldGMiIGlzIG5vdCB1c2VkIGlu
IHRoZSBkcml2ZXIgeWV0LCBJIGp1c3QgcmVmZXJyZWQgdG8NCiJmc2wsZW5ldGMiLiBJIHRoaW5r
IEkgY2FuIHJlbW92ZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLiBUaGFua3MuDQoNCj4gDQo+ID4g
Pg0KPiA+ID4gPiAgICAgICAgICAgbWluSXRlbXM6IDENCj4gPiA+DQo+ID4gPiBUaGVuIHdoeSBo
YXZlIHRoZSBmYWxsYmFjaz8NCg==


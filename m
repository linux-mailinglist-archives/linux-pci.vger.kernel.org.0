Return-Path: <linux-pci+bounces-10713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F1E93AD1B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 09:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2CA7B2218B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 07:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE29F52F74;
	Wed, 24 Jul 2024 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DdnWRsLL"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F54C84;
	Wed, 24 Jul 2024 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805592; cv=fail; b=YEoXtBIE8kYwlldzU7Y/nVEJVE+kZKu8EGc0SDgRVb8NbPjowTfbdCIXfbfaBfoSbzotcm9UuG/sDqk2vQmDtBYNYk4PWg8g9qRmHnWk5exgYdi+tDczDRTcqWzPdIicn/igZGhBTvGwUDPbUYBByuPRAyFZEd/jgc714FyelGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805592; c=relaxed/simple;
	bh=mvoVgl6U8U1QnvSZ2ZbCGbirKAXcJLAVhzFPKVbAGBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EEUpEi+HYUsOQMdRXcBgcoFin70O/VvxKplFyAwEXgE5uxbKtf47HePPL40yLIa6Szts15zgxryThTMVoKelDf+p0cc1PNsfE3y4Bpt9cLBKj1lEhKCgOeJHIVyDoBJzSwE1sdVfbu3rFnWWk7zUgg9w/VyF3fHTNjhsnxtbmSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DdnWRsLL; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USmWAEDVRhQt4vusjKlrhIFmqse263tILH6hArjNAcBW6YHzxST/AyLF0h0J11HoMWtPKE6g7VULEx2EFEgZ1sNzkNCam4ZYrKkcvc8ueMat+ZkQkLyiWiD2DpwmGF4AoSMz9Dh4RU97BMwYkPtelKOMHZWBgZVbp6kQU6taTH+Zk0w433oTQ4FBrm9y8DCm+qGaskPJ0bY4wdVVKK4W+FoL9MlKRBgnRGB8V4yrieI0QdgV86/9ahLggHksbpEVSw59v52uYcE/o1giKS7V1B5O1LrxfCjegxkAG3Oa3aA3BXPBzjoQAv1ntlGgp74g9XsoVFGfvxI30ujYVL8FgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvoVgl6U8U1QnvSZ2ZbCGbirKAXcJLAVhzFPKVbAGBg=;
 b=OGDNMsQ1a4t6d4JJp7I54bwsEVHFkre1LAEtWDpcGLriUTEhLik/SMIv+2uJAfDVvbahQBP0PlzX3Byuti9S5jKlgyqeQFOEgq6aFLb6/heJ87sm7TLtjy9xNSBSOHWkoI5bsgXJK08sfl6jArSGx7rwMZ3ZVgW9bVKzcX2tTdhGMcQucRgWcc0gIxZkVZdfW/oYBQWqJAj7TqHDUDV7LqAoUaotxBOIO9iBxo2RuJ7DEL9+y4YxXHLjntC9S0RsygFQwX4KP0isdz73UkBw2pOYQepVuZdrAdX1J0/s4pC7kovEHYTCUgZGbtA3fdjST39Xbkp90xEWvoHX/nQ+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvoVgl6U8U1QnvSZ2ZbCGbirKAXcJLAVhzFPKVbAGBg=;
 b=DdnWRsLLEiB12M4ZVZVaUmoKu44qG/Zy0ftbwVzg1uaghkY8hPXmzV7iXNdSK8YceOzeQw6oG0v00w35NFvLy4HkRxqMU6iHYylvHG1WN+uBlLfk++qary6HXg4qGJgVrc9mXvY+dpsG73pBMY5tz6EmYjqrbMETc5keTsKGmQJopmqDc1juTXtNPf/93z/WeeBxh3YapBsN+FwMN0fIkwlVLQzZHhI5mKaTjBcKCPmukicVb47FchP905+JCJk5RIb15CFxuz+cwhKppc9DcuzEAZ834Ff+D2Zw6bNOK3zxmXDj/PHUy4EF7LMZwQVLXjn8AyWmeamOFFtKdSUl6A==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB7877.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 07:19:47 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 07:19:47 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Thread-Topic: [PATCH v2 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Thread-Index: AQHa3XjKPyuG93K/lkCq2rFQl2xS+rIFZFSAgAADLtCAAAQVAIAABtIA
Date: Wed, 24 Jul 2024 07:19:47 +0000
Message-ID:
 <AS8PR04MB8676C73277BC4F787B56A5E58CAA2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1721790236-3966-1-git-send-email-hongxing.zhu@nxp.com>
 <1721790236-3966-2-git-send-email-hongxing.zhu@nxp.com>
 <dbcd776b-172a-4c53-b33a-3215f7dcfe77@kernel.org>
 <AS8PR04MB8676B0F1385BE39D209DFB698CAA2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <c9efb8a4-ca08-4e4a-97c6-de03ecea2955@kernel.org>
In-Reply-To: <c9efb8a4-ca08-4e4a-97c6-de03ecea2955@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB7877:EE_
x-ms-office365-filtering-correlation-id: 2ee20fcb-8f70-4002-c641-08dcabb0ffe8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUM5dit2cTdtMVIvRVB4OXdjNkpMRll4V2JxbDZvblRGMEp5NTB3NlpBUWNB?=
 =?utf-8?B?SmJ0WDEvaXhOYXBBcC9JWXlzeGZpY29sUmkwb0JveEVWc2FGcnlsQ3I2ekJm?=
 =?utf-8?B?UTF4VGV2cSs3R3FSdGh3dmdRMmx0bEZ0MUNNVzJXazRCQzVYdWxuTHdmamgz?=
 =?utf-8?B?WjNldkIybFdaSkJ2OFJXOTRxQ2xuQXZJaUhScDJ5UFU3ZjhHb0RMZXp0L0Va?=
 =?utf-8?B?Rzh2ZkdCSjVudEZjSFhvR2NjRjlZQ3NBOVhxOUlka0RiK3ZkeG5PNlprblo2?=
 =?utf-8?B?NWszbU50bW9XOU4yY1RGaTBQdUdXZGl0QTBVQ0dId3hCZENoMjg0ZlZ0K2Ns?=
 =?utf-8?B?bnpNQVpJN3F6bnF4MEJMemljRDJKWm1TOGJaYTNoSlhCNjgzeHhZMktUL0E4?=
 =?utf-8?B?Sk5sOTNXdmNZYm9scXpxQ2dwRmdrTjBZblA0Z0huMFBuVjF2V3NPMXdOYmd2?=
 =?utf-8?B?M1dEKzNnQTloS0cwc3NYRWRVb2s4dXJ5b3dMUmhIZC9ZVTZ1N0tNZXZadXVJ?=
 =?utf-8?B?ZE9ZaStoREk2Zk8veEROaVpFWlc3VmNHMXVaMHRFV1Q4ckZOQ2d1VmhaMzRu?=
 =?utf-8?B?NkJLVmpNVTVJYVlGQXl1NlpxSzVkUE1ZYTRNVzRvVHZVbjZJZ245QU1za0Nl?=
 =?utf-8?B?OXBHVkZoMnRVdWV4TGltbnFUZGdXckJFZlgyS09TUkduWkpIOUtIckRQUUZW?=
 =?utf-8?B?L1NKU2dhSzR5YVZVQ3NEZU5McVhRVVArR004bGxRR0JRekRvL0lpb1IvazAz?=
 =?utf-8?B?d1ZuVWUwY0JRZ28wdnNYK1JLYVZlaVJTREl1QXcvVnVDUGg5b1luTXdHMGFu?=
 =?utf-8?B?cWV6NHVYemsxbTJuRFFNeDZMR0psTXBaQnBTWjJvK0FnZ1owYzFrZzArWUJE?=
 =?utf-8?B?WVJ2Yy9ZeXVoUHRLSEs2SlFXVGNmdFBxWVhWM3B6NTh0M1RWK09qT215SVd4?=
 =?utf-8?B?ZTZwc2FnNzBkSzY2d2tzOVZGclNiTmFoR2xpSllYL0MrOU5NZDM5STdnalZS?=
 =?utf-8?B?RmlaQ1liR1cvd3BrT1ZuL1NubkpRNG4wUnBOUllzcHFlK3h4RzEvRkpGZ1BP?=
 =?utf-8?B?ZnJJTElVbXQ3NjdLVVNkNWpPSFNSY1B3aHpwTkhxakJSTE1xTlgvMUU0Skpa?=
 =?utf-8?B?a2RBbGlzOXdlY0FMS0dtcmlJdFFOOFlVZlNHUHNwem5pL3dzN3lSbmU2S25x?=
 =?utf-8?B?bkxmMllrL1FQd012NW1oYVhCQ2N3V0tWS25BMVdkZ0poMlM2N2ttV3FVdDA2?=
 =?utf-8?B?NzFxcC8rYTZybGRMOGVOWkNUcjJtTSt6WVBiZU1LSUtBTkxjam1LYjVPOGY4?=
 =?utf-8?B?ZmNrUGJXcHhkYzBXeHRHT3h0MTBZeGI2SFB3OWpVSGJVdEJDZkpFOUk2MnBw?=
 =?utf-8?B?Sk9LanZ3T1I5K0NXcmNtUWNzRXg1R25wNndGVWE4Q1hpZm9ac3lmRWw0dTVL?=
 =?utf-8?B?bGhScW5DSi85NEpVRk9QTitNbStOK2xDd0llOTVrSFcwZnpMT0dLQ045S1Ry?=
 =?utf-8?B?YjdkU1U2WTVEaDV6SzJMVXBndS9rOUZqYjZwS2t3WkN5V1V3S1BtNWppSUVn?=
 =?utf-8?B?SHhNeWdkNlRnY3luSllVYnlhQ1RmS0Flbzc5RlhDQ2gvZ1l0SEllVkZ1blhJ?=
 =?utf-8?B?TGRLSWhjbFh5NFdTVXBrTWVnYk0yaWwzU3hlUFF6K0dLVExSUC8xQVh4ZDZs?=
 =?utf-8?B?OXR6SkVwSUpiQXN0b051MWMvSkhmczFRcHVWNlpLLzFBRFB3QkdYVXZRbHFo?=
 =?utf-8?B?b292ZU1tb1djN0lTRXJONlBnVkU4OVJRVDF3NG8wbDZieEtIQldySjdhc3R5?=
 =?utf-8?B?RU9BZXdNeklWU2dOWG1SVXlZV0ljc3RHRFQxSG1USFhWd3RTbHI0bDh4WEE3?=
 =?utf-8?B?Q2pvZnV2RlMrakdFUGI4RWtmSHNac0FYUmd0eTdYUnc0M2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWlXWFoyUlp1VC9jbjNLTE5vNFZxelQ4bkh6Z3pGNTdWODd2R2NtMTZIRGYx?=
 =?utf-8?B?OHV0K2VVYkhMZ0pqQzhGMnZmVTFxWFN2RTVrMXU3d3RhL29KVUppa3ZHcm1W?=
 =?utf-8?B?SDNkbmJkWHBNdGhkWFRZc0dqUnRsNmZYR0FWdkM5R0ZLWGZybFdGaUFJaHlx?=
 =?utf-8?B?QW5aVUlCMmJrb21vaDVIUlMxZjFtNkVLU3ZiL09LQ2Z0RDQ0SnB4Uy9HYW9F?=
 =?utf-8?B?aEhBYzdXaDhjaFBScUpndFRhTkZVbUNyUi9GZ1V1UHh5NTZHdXNURXo1TUlp?=
 =?utf-8?B?MlZyektVTmhQMi82TWlkQWtDcG9pVVErNyszcEJFVGFKS05YMSt0cXNma21T?=
 =?utf-8?B?RjRUOTdaQVVyWUhVZDFibEVYYXlBem1SYTV3aWpWYkpXWDIxQ2lmQW9DOHZ5?=
 =?utf-8?B?RjRrZTNua3RDQUp0dThKZ2Q0R2hxWjJqMmliZU9GenhGQUlTdEwxOE9pL0cx?=
 =?utf-8?B?QUN0WWVEMGkvZjlGZ2loOUxGaVI2ZEJSWkxIWGd2enZNbUFIcVZaYjBrZ2V2?=
 =?utf-8?B?K0xHUU9DVnVCRWsxcXlkZW04UzdVdGdrdDVaOG9Rc0RHaTdWbDlmcldya21B?=
 =?utf-8?B?TnhhYnBBdXdtMnRUMmZyRVUvOGxScVU1M3NWaTZIY2lrZ0NBSjdjd0UrY2VO?=
 =?utf-8?B?ZkljSlRzQy93eTJ4Y3UrUkJUeVpwemJuMm1rYmFzWElVK1JFV1ZhYUFuV0Yv?=
 =?utf-8?B?S2QvZjFoekNQUVpMQW5HWkg3NVQya0hrK1dSakpyMS9OR0RaV2ZoOVFwZEZj?=
 =?utf-8?B?cVliMTJhWlJ4TlUycm5uMXJkOXN2SDNjTnA0emo1KzFFc3hSRHBjSjR2LzVh?=
 =?utf-8?B?UExKT09rOFZsZVVtUlZLSjFubjBzdURvQ0RFK1M0NnhXTWloNjloUkV2OGx6?=
 =?utf-8?B?VEgzMC9OSStxNnVzb0wwcy93WkpOVUZjYnJ4VmJRMlZrNWhmb05WTTREcTB2?=
 =?utf-8?B?ZVVIQ29maCsrcVNqTWVkdlE5a1VjQzVMZmRGSHBXY3ZiZWRSbVNVS2pUMzVZ?=
 =?utf-8?B?NjZmYklRRDNUUFdHa3BIUlZ5TWduTmZxTHRwQUZ5VjNrWEdxTlplTTlyek4w?=
 =?utf-8?B?MnlDSjhIZENSSEU0eHpjRHdVMzBuS3ZKSE9sRm0xNFlsUWRaRXBiV3F2RDI5?=
 =?utf-8?B?aTBLUHZQVWxhOVJxRXpYMjN1Z3pVaHRMQzFhbjlXeUNoVS9NbnZEeWFqenM5?=
 =?utf-8?B?dEhVM3U1Z0E1UXRtWFdXUVcxOGV1all6d0diWTRLV1gwZk1TSFQ2WEJMREhp?=
 =?utf-8?B?QnhvYWliQVZuL0hLcGN3MHFoRDdWT2JRTmdvcmlnb01XYnlPQjhlTHFkRlND?=
 =?utf-8?B?TTRJZFFIM1BvYzM4Z0lvWVdtYXZraVNHc3U5QXN0S2RtQ0tYL3RLRXJ6NnVO?=
 =?utf-8?B?UWdpZUVVSVcyMmh6cW5RMTFNRmhJcDU0SURqM0hmV25kVHc4RHEwcDF5MEYy?=
 =?utf-8?B?Tmp2bzZndHhHTncrSzdETzVCNklIeGNYRGc3N0wrSnRWZnBTZGRFWVNGKzBh?=
 =?utf-8?B?dHJKYUhLdXNrVFBvaEFhMzU4RE5QSlc5SWRacXhpRlJQb3ViYUIyTm9STlJa?=
 =?utf-8?B?MTNhVmZZZ1ZGM0V5TmVNSGZmR0p6WVdWVXh2TXNMTzFCS2Nsd2U3YlEvNHZG?=
 =?utf-8?B?VXpPNk1qWnd5ZTZnOFVNVmg0azFTMXJYU0hlZS91d3dtRHMxc0VKODdKVjg3?=
 =?utf-8?B?QWZVYVR1Z1hCZmZhOWdpaEJneXVramJPdGhTV3hmamZNUkFxQjVGVS9lS2pm?=
 =?utf-8?B?RDl6T1M5THVhRldGRTJBWXZmTDlqV01DWnFuWnlTUHpLV3pOblpDQTdFQWJD?=
 =?utf-8?B?NEJTU012S2grNEMwT2JVR3A5b2hFdXNpclFQeVlHRTBYVy9tZ1loRHdCbSs0?=
 =?utf-8?B?QW1FODZlUzN3V2NWaTRURE5LQk91cmFkanVXMzlNVXJjclh2cVA1aE4vU2RQ?=
 =?utf-8?B?UFgwQk5wdUdKY0hXUWFyQmJvUXNLU3o2NlRhU2Zvejl5NWZlbmdtQW1Dbjlz?=
 =?utf-8?B?V25KSmRGc3VTVS9PckJkM0thVjRiUUx4NjczdUdZcFpjMGZDTXVGSVRKdTVK?=
 =?utf-8?B?WWtwU0MxYUxrRTFRKzExdWpucGw1cm1oV1cyc2wyaHFqeU1TbGRNK2dzMVR3?=
 =?utf-8?Q?13t9N5FDfSsXMivM7lQ/TVbY6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee20fcb-8f70-4002-c641-08dcabb0ffe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 07:19:47.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZclMk4C5FZ5wI2XsdsLB38HimdFYpC6PZ2NMnTROLIurJSHf4MLCDhHcgmYQV5OxiC4HVGWOEyUSTCbXALyAZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7877

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTlubQ35pyIMjTml6UgMTQ6MzMNCj4gVG86
IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyByb2JoQGtlcm5lbC5vcmc7DQo+
IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVs
Lm9yZzsNCj4gbC5zdGFjaEBwZW5ndXRyb25peC5kZQ0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2Vy
bmVsQHBlbmd1dHJvbml4LmRlOyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMS80XSBkdC1iaW5kaW5nczogaW14NnEtcGNpZTogQWRkIHJlZy1uYW1lICJkYmky
IiBhbmQNCj4gImF0dSIgZm9yIGkuTVg4TSBQQ0llIEVuZHBvaW50DQo+IA0KPiBPbiAyNC8wNy8y
MDI0IDA4OjI2LCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4N
Cj4gPj4gU2VudDogMjAyNOW5tDfmnIgyNOaXpSAxNDowNw0KPiA+PiBUbzogSG9uZ3hpbmcgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT47IHJvYmhAa2VybmVsLm9yZzsNCj4gPj4ga3J6aytkdEBr
ZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiA+
PiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlDQo+ID4+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gPj4gbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gPj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MiAxLzRdIGR0LWJpbmRpbmdzOiBpbXg2cS1wY2llOiBBZGQgcmVnLW5hbWUN
Cj4gPj4gImRiaTIiIGFuZCAiYXR1IiBmb3IgaS5NWDhNIFBDSWUgRW5kcG9pbnQNCj4gPj4NCj4g
Pj4gT24gMjQvMDcvMjAyNCAwNTowMywgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4+PiBBZGQgcmVn
LW5hbWU6ICJkYmkyIiwgImF0dSIgZm9yIGkuTVg4TSBQQ0llIEVuZHBvaW50Lg0KPiA+Pg0KPiA+
PiBUaGlzIHdlIHNlZSBpbiB0aGUgZGlmZi4gV2hhdCBJIGRvIG5vdCBzZWUgaXMgd2h5PyBIYXJk
d2FyZSBjaGFuZ2VkPyBIb3cNCj4gY29tZT8NCj4gPj4NCj4gPiBGb3IgaS5NWDhNIFBDSWUgRVAs
IHRoZSBkYmkyIGFuZCBhdHUgYWRkcmVzcyBhcmUgcHJlLWRlZmluZWQgaW4gdGhlIGRyaXZlci4N
Cj4gPiBUaGlzIG1ldGhvZCBpcyBub3QgZ29vZC4NCj4gPiBJbiBjb21taXQgYjdkNjdjNjEzMGVl
ICgiUENJOiBpbXg2OiBBZGQgaU1YOTUgRW5kcG9pbnQgKEVQKSBzdXBwb3J0IiksDQo+ID4gRnJh
bmsgc3VnZ2VzdHMgdG8gZmV0Y2ggdGhlIGRiaTIgYW5kIGF0dSBmcm9tIERUIGRpcmVjdGx5Lg0K
PiA+IFRoaXMgc2VyaWVzIGlzIHByZXBhcmF0aW9uIHRvIGRvIHRoYXQgZm9yIGkuTVg4TSBQQ0ll
IEVQLg0KPiANCj4gVGhpcyBhbGwgbXVzdCBiZSBleHBsYWluZWQgaW4gY29tbWl0IG1zZy4NCj4g
DQo+IEFueXdheSwgdGhpcyB3aWxsIGJlIGFuIEFCSSBicmVhaywgc28gZXhwbGFpbiBleGFjdGx5
IHdoeSBpdCBpcyBPSyB0byBicmVhayB0aGUgQUJJLg0KT2theSwgYWxsIHRoZSBleHBsYW5hdGlv
biB3b3VsZCBiZSBhZGRlZCBsYXRlci4NClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCg0KQmVz
dCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cg0K


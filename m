Return-Path: <linux-pci+bounces-40191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90C0C302A8
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 10:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FF33A8B1C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 09:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017EC2951A7;
	Tue,  4 Nov 2025 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WFE4Tb3S"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9B62C15A3;
	Tue,  4 Nov 2025 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246984; cv=fail; b=swPR2S4OLKYzTxlyhJV8GGnZ+tKKUeC/K4sSKoDgiJkMEhEkyqTSJUTc+r5iX/GgvokUGZ/Wb/WAP9HHVdjBm9Dq+2qzXj7CMF8sjbvD3IrvP66Gwsdco/fkVtrz7LL0TeZlLvZrhWxAnxvf/3+paCao++UbzUcKvE4ajpScg9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246984; c=relaxed/simple;
	bh=NC20SIporVV6AzQJQdMAfGCUDycxKeLNRpo6gKoW7iQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CLfd72hQe+2YOxXPB5vnDb1TF267YeZi5r10fb9YYd4gmhmVUq91G4Z9yjUcAuS+Nh5k18k59120w5o5jYMd/7jW63cFXGQh7qcyqIH8aA+xpHEGJzHEPJu4j2NfT4u1btxJCk0K9zC6WdS8Q5gD9Tjw0akbelga/BSLJlzoo5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WFE4Tb3S; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3+3bGk9/zdasXf5UhPJ7o0q4ZAx6GTsVaamuhH/StUcLrESWZjIbeUpqe/9T59xi1XX46ltscIaW85HkXeXaj4EjwjhsU3TIUHZVNKK76ZFwMdKKFmA8DIjth2a3xb15534bFgQBeSx8AfcGKaMr9nHeimO388+sjarejMxGvEW+ONi7cW8LkCxKJfXkr7KMjiqNyXhsrEwfEtX70nj12yDw78397ortCzaEdelzttQMX1JwIuoOy8axN78Ml6GhWutwJHO0QeE5hDvhsmWEXXIibCgpAJ8Nk1UyV9UQO5AI8gVQSwCWgbbKYVWr5M0RPIPG9g5fUtUzq+Y4scewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC20SIporVV6AzQJQdMAfGCUDycxKeLNRpo6gKoW7iQ=;
 b=HkfblqrT9VI8Fls9IZIEKW43mLhICVqOffbHHS4QKL1eVYwwAH25wpPgBuZSlgcJL1GFtT9eo9YjaTAP77wXeIAbbqtfzhGq5bDn2OgSXqy8gbP5G/50Eg57NQyQrCqhfueXeB+yFiXKb2lbjSbTJSBt2PCFRuPiam36yPdfUyBUXKid53Vd7sq7pFItRQRcrQ0xaxSnwNMGgTuaGU6dxA05WgDe7wSDB4nLJ3r4AloaF8Mlg3Znot6kA2jNVW0DWMh1UXArO28IXwwLVgg5ItrkRuBy39SROHEGxKblgP7sePPKZm6kr5V0fWMAX44jbnL4ZkxWE9SyoEkGC3kC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC20SIporVV6AzQJQdMAfGCUDycxKeLNRpo6gKoW7iQ=;
 b=WFE4Tb3ShwZtqRDrjqzhBIBNistYWZf7/ZCJ7tiDDiHJkUoQXjcCbSZyB3Wcy0wp+mrOqLLbxmIDS6cDRpobaUds35bMXTlIt++lVS2gfHKAyKkunYiv2o14ZKc0pC9gwbH7OFAMp9WmPAuSifHjWihWLWDtxFAyhRBNRgqy0vuuVqXoRDTo67NWgQ7tjSynfeJkdtAejrdG9xZ2y/DvYm0NNpLQ7PDLnAO7sSfV7on2D3xvlGaCX+/iMNsI2N+UEojT95nMjTOx+1r3P5wsbEpuz3igo8CN4qbumY4YYC9HowrweSJhAXDcGrANZklA9QDJfIrJCvHX0R1of0I0NA==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM0PR04MB7124.eurprd04.prod.outlook.com (2603:10a6:208:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 09:02:58 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 09:02:58 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 2/3] dt-bindings: PCI: pci-imx6: Add external reference
 clock input
Thread-Topic: [PATCH v9 2/3] dt-bindings: PCI: pci-imx6: Add external
 reference clock input
Thread-Index: AQHcShU4hnYNoZIfzUG27ZeihKxenbTfkJaAgAKBhlA=
Date: Tue, 4 Nov 2025 09:02:58 +0000
Message-ID:
 <AS8PR04MB883314FEB5A3E3434FABFC6F8CC4A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20251031031907.1390870-1-hongxing.zhu@nxp.com>
 <20251031031907.1390870-3-hongxing.zhu@nxp.com>
 <20251102-complex-placid-frog-09cbed@kuoka>
In-Reply-To: <20251102-complex-placid-frog-09cbed@kuoka>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|AM0PR04MB7124:EE_
x-ms-office365-filtering-correlation-id: 7e1a2d11-fd05-4eb7-73a0-08de1b80f352
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWV5OFFqU0lLTlB6bGpsYnpmSDlDem53VnJTbWFMdGRYNFdCVDV1by9VZmtv?=
 =?utf-8?B?S0ZsTkRGOGZIN1k1Y0g3VnVQZEhaSW9KY29DRTFPTkZ5azJnV2Nodisrcytp?=
 =?utf-8?B?bXJva3JSUlhaTlFWQmFKbDdIYStmYndibEoya25EeHkrNVZQLzBvWGdlWjhq?=
 =?utf-8?B?SkJ6L1RUT2FTeDcxYjlvOTRFcG1oNVRoVm9HM29uaHRPVVZmMkJiYWxZTUY4?=
 =?utf-8?B?aVd1bDZQWlJDcmYrcU1FZURRMFZjYXNEVFNOdDBtNjJhT2JaNGUrZlRFMTZ6?=
 =?utf-8?B?cTdjL01xZnpEeGVPQ051Y0piazUyN3M2Z3FyMnVBRXdXNkUxNzlSNHdUNFYz?=
 =?utf-8?B?NnNZdWhRZ0RtZlZuVGljLzF1TEMvR0MzdTF0Q1RtaWdsNUxhMHlKak54ZzNY?=
 =?utf-8?B?RWU3cGN5S2l3NVBZWC9QdTdqVEhFaHlzcGJOLzIxVGZlcnhibFZtcXVENG5s?=
 =?utf-8?B?MkRYQURPZ0o3cTlkVUlTMlJ1bzJWazVGUk9UekhjWFU3U2hWb1BhaWtsVXFi?=
 =?utf-8?B?c1gxMXhWNWJwNDhUMTMwMTVWREFETzFFRFBKNTZMZXh6Y0oxT2loRFBqaVdy?=
 =?utf-8?B?Yk9aTmg2dy9UZmZTTGs0ZDI4bUFTc0xadlVRZ09rMkVXQitHQ0lBcEtKaU5j?=
 =?utf-8?B?YlFVNW9QQzE2aXNxbkxobnRNekVtby9pMWRUR0tMcWNnNjh1WEV0MjhWc05o?=
 =?utf-8?B?Q3c0WXlwejhxUDFUSkZpYmgybTVpM3BpSDA4c0l0VlhkVHU5RmJ0WS91SlN2?=
 =?utf-8?B?d0xRWWplb2xheGkyMUY3OTRyOWpxZGdocENZWnpkYkEraXRxR2w3OFBxSmV0?=
 =?utf-8?B?NGdSK2JubysrUnZFRkM3TkVPNU1GTnY4UzZMTGJqOFhaUlN2cEdkbnByb3Zx?=
 =?utf-8?B?MVlkYmhwWHZkVTZ6TWpSSXNaNnpSVU91T3hpTVJyellObzNqSjJtcnBtaytB?=
 =?utf-8?B?bGdiSEZmVlQzRk8zbEhwUFNBdkhlelM4SGswLzFaeHBwWXhBaGQ3OGpMdnBt?=
 =?utf-8?B?eG55Q1FGWlBoc3ZkQkM1YnZWZWFmT1lPUitpcFBXdEp1SU1uNi9zelNNa2N0?=
 =?utf-8?B?UkZIRyt4N01CQXpsRjUxSTRHVnl6SGFKMWMwT1REMzJjaStnL0dZOHlwOHJV?=
 =?utf-8?B?NXBOVE10aWpnZVc1V1QzcG4wTTIzUXM1Q2Q3c2ZQd2xhTHVTRTV0cDVSamt3?=
 =?utf-8?B?bWpQTk1ETFB2Y1FVUGo2eFc5NlRFWGdVbmJTa0hmTTVScFdWVkt4ZUIwMG1s?=
 =?utf-8?B?UjdUdlQyNmZqUGVxSlZPT1JYaDJFM2xKRXlNWDh1RVlhTThPZURNMmFDSzNp?=
 =?utf-8?B?NG4zRWVQMFcxNUhSZHhEaXdLRHYrNkVENUVPdlMwdm05K1BGZEVyaVBHS25P?=
 =?utf-8?B?eFY0WEZVZi9VZFhRRnRXb2h2WitwSTVTdmVYUjJlb05GRTFnT0xLYTd3cHJ4?=
 =?utf-8?B?U0hIM0l4RDZyM2JPLzg2ajhZQW1QbGxXQk5qbUVqcVFBSnhJeDA5cmZMM2Ns?=
 =?utf-8?B?ckFEeERObGQ5TmJBSEEyN2RDTjJjR0NHOENsVEVkeUh6eVRnbjZkSVR2Lzcr?=
 =?utf-8?B?UGR0cFRlZ2JLZkxNM1ZHbzdpN2R5MllLSU1seHhCZzByMWhSMXNKL3JhNThq?=
 =?utf-8?B?aE1kTzhhSXV0VG1GbCs5VGtZU0dZMzdTN21yQVRRNUIwUTYwVzZ0TDdTOHRO?=
 =?utf-8?B?bHJsWVAxbUJNblhDUm5pNEZOSDRmRHVLT2UwVXlJd1NMVEp4dGFkTE5BU1Jp?=
 =?utf-8?B?MnF6clBBSVd3TmhhMERCN1dVSm1BZFdncjZoa3ZJRDRnQTVHMlZYQ3I4QmFh?=
 =?utf-8?B?ZUV5T2pZK1psS3NQUDg0c2p0TGxsOUtJb1YwOG1pQjBBdGdCUm9vdDFWSmUv?=
 =?utf-8?B?cGtabjg4L0ZEMElNQTNsQWZCZlI5ZVRLendhSWR2aGZTVGdVRFNyVnpnUFZi?=
 =?utf-8?B?OGlJb24ySzRVU045N3ZqNEIxeEo3UzBFTnlBL2V5UXFRT3cwMGcrU3RoT25p?=
 =?utf-8?B?Z2hKNFpvelk2UTRYeVdSeXUyRnlyOE9vNW9YZk9oTTFMRVNaSms3Y0RoQmJl?=
 =?utf-8?Q?hxr+oH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K05scE5qd0FvRkxIdzBWRitJMTNEdTJLc3RZdlE5dzE1enRpU1c4dWJuL1Bx?=
 =?utf-8?B?T0NHOHAxWWF2Q21OQXNha0hDUEFwQVNwaXFYQ3M4dndRUnFwK3lqOEU1Vm1D?=
 =?utf-8?B?Y3REN0k0eXhYS2VBTTZOa0JrT29nQjQ5THoyamNvVHZMS3ZXSXFXZzZ5THpG?=
 =?utf-8?B?ZitqTDBubmZMaUFyam80VjhmQjJHUGIxRU1senIvalhtcGlMc3JidEV6VUQ2?=
 =?utf-8?B?OVN0RTIyTm5uMGkyTUVlRUhISFFlNXlRNGhwdTVXYml2L2JXdFBEZUNVNTlv?=
 =?utf-8?B?U0lUQitObTRLSEdxVFkyTFBxMkZKSUlqa0R5TTJ4elNZL0tCZ1B3ZlZLSUIw?=
 =?utf-8?B?ZjVONS90UTdUeW9XWkUveGlNbENDc3RsZXEyVDcrRGllWTJ6ZTkxWHJLNUR0?=
 =?utf-8?B?U012bnAyMDhpc1g1RGtveVlXN2ROWXE1Nm41V1J4OTNnbXZ0WVFaUzQ3UGxz?=
 =?utf-8?B?SnNBMm0wQmpkaTF3WWtueHJZeHlpd3lrRXRFMVliR2tjdkxlQVJnUjZsVEVq?=
 =?utf-8?B?eklDOUxzM2svajFuRlVnSysrdnZUKzd4enNpU1VObXlKZDlpNTFTUVZnNGVj?=
 =?utf-8?B?bDFUNWRaYnZIZmxUZ2xZOGIxTUkrT0xYWlE2NHhwTFVzYzk2YUVxVm1sbVRz?=
 =?utf-8?B?a09ZQUpjSTMyS1NLK2ptaklicWNERkpaeXhzdFptNEZNR1pPOXJ3d3crWmpq?=
 =?utf-8?B?a1d2ZXN3S1hIdktGcWdBRGd0cXJXa3F2WldFUDJ6TEZLcXVPRU1TRTQ3QTJ1?=
 =?utf-8?B?cHFJK3A2QWNpa3VTY2tpQmsyVFdyWTVyWkxVZWU1b3lCOGx3NjU3enAzM3o5?=
 =?utf-8?B?SVFlKy94THJFaWllZmpGb1k2K3hFN1AzVlplVlpOT3VVMXYyZDBISGxZaG1X?=
 =?utf-8?B?Q3JjeHI1WE1oUjl4czQ3b3VjS09wSStFak5oWmxYS05jTFdZam5naU1zSDd5?=
 =?utf-8?B?bTNDRnlHL0VNWDNnWlZmdkVhZVYrVUwrMTdsNDdkaUJoT3hSODNwVTlVR2dK?=
 =?utf-8?B?eE1qNCt0Sk5WV2t1L29wN3lTcWZLTE5vdER1clFHRWFReDEvMUttcXNnbWww?=
 =?utf-8?B?NmJrcmNSc0ZVN2hGMjNyU1ZWZnNzOTVQbVlYOVU4L0V5ODc2Ym54ZE14bWZS?=
 =?utf-8?B?NHFrZFB5NmNqNW5XK29VNmd5MG8vZVRhbUN0WXpUUjhPUWpyeHdFb2ZpYkdv?=
 =?utf-8?B?dzRHQkRxbVlNb0hHemFqWHFFY1BKS25YZDlrZHhucHZTRE9ZNG5McWpBVDVQ?=
 =?utf-8?B?d3JSSjcyRVN1MHFJSDRTSjltZHlCcSt1MEQ5eW9nVUZVNCszUi9XOUNiZzVz?=
 =?utf-8?B?dzMyc3YyN1FUL2xiUlpHZnhjS2tTdUIwaERmbUwwQ2hIWVlESmVKL01NNDRy?=
 =?utf-8?B?ektwWWhsSjAxbTlsb29lN1g3Vzk1Zmg3NktmRnIvNTZ3UHVoVzF2ZFczQUdG?=
 =?utf-8?B?YUkvaWhhTVBoTEdVRk5MbThEV0RoQzRTZ3NrQlh4TS9iSXgwU3p3ZDh2Y0FJ?=
 =?utf-8?B?RS91Tld2TXUzdG4yMjNncnhDT3BRMzRqK0txTDBUTkNLV0QxTk5qVGhyQjJi?=
 =?utf-8?B?dzNMZHlqK2lZZnMyTisxcWd3ZnEycFFONTF4MVMxTmZWbnN4SXpWUmJDejNG?=
 =?utf-8?B?YnhRUCtDVUhINUlleG5xRzJZazY2VTBqVVpNL0l6YjNPbFVTdkN4ODZRWGdP?=
 =?utf-8?B?TzZUNXRHT3N5VGFrUUx6Ykt4MEFXRERPc3FCOFpVWVRrY0tYbEdZVGJEMzBH?=
 =?utf-8?B?Kzc2YWhSK3Y2ZGRWblIvN25QbWptTGxnWisrS0o2Q212UTBxTzZjRk91NGVj?=
 =?utf-8?B?NXI3aS94bkkzMW1xUGdPbjJ4SUg5REw2OFN5MlU4Ni93RVhrdnNsNUpxdXlT?=
 =?utf-8?B?bVJUeXRPbmVMUkFxK0svT2JYZXdVTkk5a0R3dndqWUJoTDhpRFVvdkF3OEhw?=
 =?utf-8?B?dFl2Yjh4dDZFd2RxVHdVZi9QUC8rVDRRVXl5RGlJOU9vZGs1YjM2L1RvQ3BR?=
 =?utf-8?B?STRZTmE1UjJERkFXa3duejZHRDJOcmRlUlUzRU4xd0VCcUo3dzRPQUFEQXNm?=
 =?utf-8?B?K096NzB5TXovMlpYVVAxeG01SEhidlREeUhZVEdISlU1Sm5vOHF4T29mdDZ6?=
 =?utf-8?Q?0Akg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1a2d11-fd05-4eb7-73a0-08de1b80f352
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 09:02:58.5198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74IlmZw3OLdHd4iK6xazym7ACCIBiEtp4JhwFTaI+wY4xoGyxxaGNOq5ls6/cFmwwbd4J7q7grNjUZriQiEjtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7124

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXlubQxMeaciDPml6UgMDowNQ0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IHJvYmhAa2VybmVsLm9y
Zzsga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBiaGVsZ2Fhc0Bn
b29nbGUuY29tOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9u
aXguZGU7DQo+IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsg
bWFuaUBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRl
djsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY5
IDIvM10gZHQtYmluZGluZ3M6IFBDSTogcGNpLWlteDY6IEFkZCBleHRlcm5hbCByZWZlcmVuY2UN
Cj4gY2xvY2sgaW5wdXQNCj4gDQo+IE9uIEZyaSwgT2N0IDMxLCAyMDI1IGF0IDExOjE5OjA2QU0g
KzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IGkuTVg5NSBQQ0llcyBoYXZlIHR3byByZWZl
cmVuY2UgY2xvY2sgaW5wdXRzOiBvbmUgZnJvbSBpbnRlcm5hbCBQTEwsDQo+ID4gdGhlIG90aGVy
IGZyb20gb2ZmIGNoaXAgY3J5c3RhbCBvc2NpbGxhdG9yLiBUaGUgImV4dHJlZiIgY2xvY2sgcmVm
ZXJzDQo+ID4gdG8gYSByZWZlcmVuY2UgY2xvY2sgZnJvbSBhbiBleHRlcm5hbCBjcnlzdGFsIG9z
Y2lsbGF0b3IuDQo+ID4NCj4gPiBBZGQgZXh0ZXJuYWwgcmVmZXJlbmNlIGNsb2NrIGlucHV0IGZv
ciBpLk1YOTUgUENJZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9u
Z3hpbmcuemh1QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwgfCA3ICsrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwN
Cj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBj
aWUueWFtbA0KPiA+IGluZGV4IGNhNWYyOTcwZjIxN2MuLjcwM2M3NzZkMjhlNmYgMTAwNjQ0DQo+
ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEt
cGNpZS55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bj
aS9mc2wsaW14NnEtcGNpZS55YW1sDQo+ID4gQEAgLTQ0LDcgKzQ0LDcgQEAgcHJvcGVydGllczoN
Cj4gPg0KPiA+ICAgIGNsb2NrLW5hbWVzOg0KPiA+ICAgICAgbWluSXRlbXM6IDMNCj4gPiAtICAg
IG1heEl0ZW1zOiA1DQo+ID4gKyAgICBtYXhJdGVtczogNg0KPiA+DQo+ID4gICAgaW50ZXJydXB0
czoNCj4gPiAgICAgIG1pbkl0ZW1zOiAxDQo+ID4gQEAgLTIxMiwxNCArMjEyLDE3IEBAIGFsbE9m
Og0KPiA+ICAgICAgdGhlbjoNCj4gPiAgICAgICAgcHJvcGVydGllczoNCj4gPiAgICAgICAgICBj
bG9ja3M6DQo+ID4gLSAgICAgICAgICBtYXhJdGVtczogNQ0KPiA+ICsgICAgICAgICAgbWluSXRl
bXM6IDQNCj4gPiArICAgICAgICAgIG1heEl0ZW1zOiA2DQo+ID4gICAgICAgICAgY2xvY2stbmFt
ZXM6DQo+ID4gKyAgICAgICAgICBtaW5JdGVtczogNA0KPiA+ICAgICAgICAgICAgaXRlbXM6DQo+
ID4gICAgICAgICAgICAgIC0gY29uc3Q6IHBjaWUNCj4gPiAgICAgICAgICAgICAgLSBjb25zdDog
cGNpZV9idXMNCj4gPiAgICAgICAgICAgICAgLSBjb25zdDogcGNpZV9waHkNCj4gPiAgICAgICAg
ICAgICAgLSBjb25zdDogcGNpZV9hdXgNCj4gPiAgICAgICAgICAgICAgLSBjb25zdDogcmVmDQo+
IA0KPiBUaGlzIHdhcyByZXF1aXJlZCBsYXN0IHRpbWUuIE5vdGhpbmcgaW4gY29tbWl0IG1zZyBl
eHBsYWluZWQgY2hhbmdpbmcgdGhhdC4NCj4gDQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGV4
dHJlZiAgIyBPcHRpb25hbA0KPiANCj4gRHJvcCB0aGUgY29tbWVudCwgZG8gbm90IHJlcGVhdCB0
aGUgc2NoZW1hLiBBbmQgd2h5IG9ubHkgdGhpcyBpcyBtYXJrZWQNCj4gYXMgb3B0aW9uYWwgaWYg
J3JlZicgaXMgb3B0aW9uYWwgYXMgd2VsbCBub3cuDQoNCkhpIEtyenlzenRvZjoNClRoYW5rcyBm
b3IgeW91ciBjb21tZW50cywgSSBrbm93IHdoYXQncyB0aGUgcHJvYmxlbSBpbiB0aGlzIHBhdGNo
Lg0KRmlyc3RseSwgdGhlIG1pbkl0ZW0gYW5kIG1heEl0ZW0gb2YgaS5NWDk1IFBDSWUgY2xvY2tz
IHNob3VsZCBiZSA1IGFuZCA2Lg0KQmVjYXVzZSB0aGF0IHRoZSAicmVmIiBjbG9jayBpcyBub3Qg
YW4gb3B0aW9uYWwgY2xvY2sgZm9yIGkuTVg5NSBQQ0llcy4NCg0KSG93IGFib3V0IHRvIHVwZGF0
ZSB0aGUgY29tbWl0cyBhcyBmb2xsb3dzPw0KIg0KaS5NWDk1IFBDSWVzIGhhdmUgdHdvIHJlZmVy
ZW5jZSBjbG9jayBpbnB1dHM6IG9uZSBmcm9tIGludGVybmFsIFBMTC4gSXQncw0Kd2lyZWQgaW5z
aWRlIGNoaXAgYW5kIHByZXNlbnQgYXMgInJlZiIgY2xvY2suIEl0J3Mgbm90IGFuIG9wdGlvbmFs
IGNsb2NrLg0KVGhlIG90aGVyIGZyb20gb2ZmIGNoaXAgY3J5c3RhbCBvc2NpbGxhdG9yLiBUaGUg
ImV4dHJlZiIgY2xvY2sgcmVmZXJzIHRvIGENCnJlZmVyZW5jZSBjbG9jayBmcm9tIGFuIGV4dGVy
bmFsIGNyeXN0YWwgb3NjaWxsYXRvciB0aHJvdWdoIHRoZSBDTEtJTl9OL1AgcGFpcg0KUEFEcy4g
SXQgaXMgYW4gb3B0aW9uYWwgY2xvY2ssIHJlbGllZCBvbiB0aGUgYm9hcmQgZGVzaWduLg0KDQpB
ZGQgYWRkaXRpb25hbCBvcHRpb25hbCBleHRlcm5hbCByZWZlcmVuY2UgY2xvY2sgaW5wdXQgZm9y
IGkuTVg5NSBQQ0llcy4NCiINClRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0K
DQo+IA0KPiBJdCBpcyB2OSwgY2FuIHlvdSBwbGVhc2UgcmVhbGx5IHRoaW5rIHRob3JvdWdobHkg
d2hhdCB5b3UgYXJlIHNlbmRpbmcsIHNvDQo+IG9idmlvdXMgaXNzdWVzIHdvbid0IGJlIHRoZXJl
Pw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K


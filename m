Return-Path: <linux-pci+bounces-29646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B14AD82F9
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 08:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B023B446A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 06:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D3B2580E2;
	Fri, 13 Jun 2025 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UEorM+y0"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28931B95B;
	Fri, 13 Jun 2025 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749795241; cv=fail; b=V24RP0qBN2yk8CRObXz+yEt2Y5J1ZnziwFeKBKm/l/zhvo4KUNeIH6PXBrt0cuBKVRHAjVLUWn2TzwxiCrthjtiq25bVEN06WPkiSNUcGnMYYYplUbIZd5TmSVkkOLKD/ZGv6ciYT1zUA14DzRElLZELO6sKLyc/BPGTMyG3YhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749795241; c=relaxed/simple;
	bh=f/GcgsXHUhlzhtAEdazRJMkmtIz2FI0Oad30LtZ8Mwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SU8w3H/GiTnqrTj7MhPEF1C7dENssZo647sZ7vJaPLjaIFRqQ7GQ6Fg7muLMKUlkg6tsHF6M3huAMXtuggkU+QNDS+ZoJFW1m4TWMZYm2K0R+38V/I8GLpBFQSzyI4igQ6kvRGR6CqBkCfrwaFBIpy5Wu7R2KtStelUrYPOrw9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UEorM+y0; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nm6ijUZ1WdMvWlIoqiDl7ZGi7PQA64//epUDA5DLfFeqh2yNEzH1napEgWQPBcoVTsbCD3TmUdGCVXbkrbhoQtNDGjYIZlWtkOShvR+aDZipbfIw5qhEni4K+LAMZgmPPTa/+a6i3+gdpUMqM/B/Bvu8jgno8rAaFUnqMasA3sSvvQhdE0hlhXz+3dMaCPP2fHNgjw7kwF+NJu34XniTSR7mY8EGhXJXhdbqWQzlPAYql6t/VXGsac6jlrCGKhhpCkAJ4LxhReAWj3LXCwuQrpZa0C1BldDEDHt6EybU91o/Hfa268kWgI3W92cd+j68V1JvrYybn3GUVgo9tx8wVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/GcgsXHUhlzhtAEdazRJMkmtIz2FI0Oad30LtZ8Mwk=;
 b=m/ojkukdq5Sn5dxfNJt1cvQv3wqnKFxI174EPXOIX5I7zd0PoxYs9FE7ejCNCYNs8mu0dSgVrmpECV8ZnQ0DweePvPfXpJ3nmZS4sgD85Kp+snpJvgm+fccJ5k7AMvXGVFbm0B7RWkTcWh6ul55ZTK1ncwLPPoq2N4lZzW0zekEbteBhs5Z9CgRenhraMpCpzFYs7Hk8x+JIY8oLxwZCNPXPnrPwn/xGNn8mZpIKlOYAymIkBqDfUQJ478WN/gmYRl0eTwctUpyb3Sf7Rq0uySvvA5PiCmTUdmnDM7aCwDsbayYx4SKmAw5vIrdWwQqXpiGE4BB2yQyrqyZOIdixZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/GcgsXHUhlzhtAEdazRJMkmtIz2FI0Oad30LtZ8Mwk=;
 b=UEorM+y0J0Tf5R+YqjJhtAcQcXutgObTH4eXx+TrMsDKSVfq6y+o8blbMBI+T2ddh44RCMkmteXlG3c7jrKW2JElOAw0NRwujAuWsCDQ3KvTkk7SWVNnMo4ZdOk0LeQsiyAGkUq+5Sxvy4Uns3h7JEoSfOcdokkKjNFRQWYlG8hC1tcJCaMMDdEK2pe7xpwF2J97LzD2Qx1FFY4/E/N7YRLJw64rF5u/tBGMiDgFNWQib1ouDB12nSBR5MU4/E2hGOPxRJbJYYcqgfq4qXh+40T7ylJmiYP/6FNKBJVWmnoGkWe/IFAqsY7wqW0VQbKeJkG+apTnq6dnnGthhp0RPw==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DU2PR04MB8535.eurprd04.prod.outlook.com (2603:10a6:10:2d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 06:13:56 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 06:13:56 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, Frank Li
	<frank.li@nxp.com>
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
Subject: RE: [PATCH v2 1/2] PCI: imx6: Remove apps_reset toggle in _core_reset
 functions
Thread-Topic: [PATCH v2 1/2] PCI: imx6: Remove apps_reset toggle in
 _core_reset functions
Thread-Index: AQHb20HdMtjlU3ox3UWRJCXhOZGdU7P/styAgAA8ZACAAG1fgA==
Date: Fri, 13 Jun 2025 06:13:56 +0000
Message-ID:
 <AS8PR04MB8676883A907B64E70CEC3B9C8C77A@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250612022747.1206053-1-hongxing.zhu@nxp.com>
 <20250612022747.1206053-2-hongxing.zhu@nxp.com>
 <aEr8PxcHp55Bo5Os@lizhi-Precision-Tower-5810>
 <CAJ+vNU3vyznybZ_QZBrB+nc1=2+BcC8csOtR5=6-gmgn6sb5tQ@mail.gmail.com>
In-Reply-To:
 <CAJ+vNU3vyznybZ_QZBrB+nc1=2+BcC8csOtR5=6-gmgn6sb5tQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DU2PR04MB8535:EE_
x-ms-office365-filtering-correlation-id: e7a4b6a3-8031-4d3a-629d-08ddaa417a7e
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cytiRXJ4TjkxZXUvWFJ3VEMyWXppblZDS2NsdytYOEVCZ29QelNiMHhNN2Fa?=
 =?utf-8?B?cmYzbnY5SUhVK2hMeE9GNjMrNGlWdmEveUY4Q2dtaERFV2VnLytQK0E1d3lQ?=
 =?utf-8?B?KzNpd0hLa1JWL0pzQ2lhNFoyQ2hNTkZoZUV0eDlYUmVJQzVwbUd5aVBXQjU0?=
 =?utf-8?B?SXRYemtDdUNtaGh5WHNqYUJNMFQrTHRidEMxYUgyUDVqZlJ5Z21uRTZtaEJ5?=
 =?utf-8?B?a3V2WWZ6ZmI4KzF0bzN0OE0rWWhNMzJSWmExOExjQVR1Ym0rM0ZFellmUjVq?=
 =?utf-8?B?WGFPUFFmcU5FdHBuVW9RQndDRTVWcUJLSm1uVVRnUjloUGVSMjFqQzh5UWFo?=
 =?utf-8?B?djUwUTY4TmV4c2tGRWVmNHlrV2p1OVVFV1VpL3QzU0l4OHhrcnpzNW9aMXV5?=
 =?utf-8?B?Slg1dnJNS1UwVjJ0REpNOHluclJETGZMaFNVdUVQU29kcStmelhoNTNkNy9Q?=
 =?utf-8?B?R2FLcWRKQ0FLYmsxeUttR0pzS2JBZDRBUDR2bG80NTh1OTNrRXpSSlBSNjI2?=
 =?utf-8?B?enNHMnYyaitacE5vL2h4QmkwTEFRZVVOaUJLQlpEOTJPMjRRdGdia0YxWGt2?=
 =?utf-8?B?YmNuOHUwM05MS0xUNXdYejJseU9TRnoxd1RhMm5BTUpydmVKUlJoQUMycUti?=
 =?utf-8?B?c0Y1aituUklpd2RzRyt0VG5oM3ZXU0syNjZyQTRFWDBPRjFlMmg2cnJ1UlVU?=
 =?utf-8?B?UVdPSExoZnBQdUdCS2MzbjdJR1BwekI3b3BSQXE5TU9Rdk80cE5VVlZvdHY4?=
 =?utf-8?B?Mnpoc2FubytCN095WUdFb1VMQk1RU0ZIb3BXQlpIZEVyM3JMVEFHcHAzWDZZ?=
 =?utf-8?B?b1VQZkF3Z2JTVXU4YTRHL3BLVjhmeFNiYVAyL3pLR0RtMnRkWEl1VDFhNFJO?=
 =?utf-8?B?b2x6VkluRUp2T1JPeVEyblVlUS9QK1FLN1JMWFBIb2VhdUl5YUxzWVFGbnRx?=
 =?utf-8?B?SnhJQzZJYlF1L0V4TmprOTBwV1dhRm5GMTZab3F1aU1iY2p5VFFRQ0dlM3l0?=
 =?utf-8?B?NkdPRVJ1RXBGVnl5MnovWklMMmxBaDkzL3g5TTZQS3ZqVE14TWd3NHNBSFNV?=
 =?utf-8?B?aDAzd1hPRm52NnZyWDFVeFd1czdxcmpoUWVXRWZCVGNLY0Z3eXNtcHY0Nzh6?=
 =?utf-8?B?R3Vua2g5d2d5M1VISTVTeUVyQTU1MnB3UERHYWNhaEJlcXBCNnUvNXpNY3I0?=
 =?utf-8?B?bkdXZmxVOGZJa3VFSngzQk9lRGxkVXVCT0lQdTVvMzZEc3hOSGtYZGRlUEdr?=
 =?utf-8?B?eU1NWUNBbTBOLzhueS9OK0RaVWxWRjdVT2hBRFVyMDhMOVNDVmxwL1g1Q25O?=
 =?utf-8?B?VG5lK01BVHlMRjBHTjEyNWRQY2YzZTVOVVBoSFI0dXNLK0VTNDJKV01DQS9G?=
 =?utf-8?B?SUtTRTczcmI3K2V5TnNobzBxc0V1Ry8zek9GbS9KUmZjWmtsZ3NERHM4R3Rr?=
 =?utf-8?B?bUk4VUhtVHJtYmJYKzFPWEZSRm9ZaS9zZWdRc1dKYWMweG9tZlNXUUdSMmVH?=
 =?utf-8?B?ZFFRbmZqT0s1bjBzRlhmQzFYS0xDRFFrNWQ0Ly9qQVdZT3BrdEkwZ0pZMmxn?=
 =?utf-8?B?QWR3eXIvOHRlZnAxcVVoaS9tcU40VnlkRU4wQzdMbHAvVnEyR1cxdzI2dUxj?=
 =?utf-8?B?dEc5K0hqTmVrb2ZEWFpMZFNzamEyekVQcUZDN05TMkgzYk9hWE05cXNDTUdJ?=
 =?utf-8?B?b0JrakRyTk9iQmhOL3BiclB6SzRibUVqMWt6d3RVdFFPMmo4T29iMXNTTldp?=
 =?utf-8?B?d1hvbmk2QmNFa25zN1EvNStaWnpQMFVZeGliQ2NkeCtMUEJpS3BYVnNYRzA2?=
 =?utf-8?B?eEl0TFY3azdBMnB0S080aFFtYURqMk12d3NFUi9kMjJUVkdxUC9aUGxkUnYx?=
 =?utf-8?B?Zm5HZjZ0M2lKL2FkaVZ4SnFQa0ZpajZkT1R3ekVoTU5ialJuZDducXkzWitz?=
 =?utf-8?B?em9EeGtIUjlXa2tnRmlXNEhYRmpVd3BsUGhPTVppVDRkTGdaOTAveVZDN0sy?=
 =?utf-8?Q?TSvXe7dH07ReFa4/NtHcvMBji9mm8E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUN3aXpzQWJmdnJNQTJqalF1VjExQ0NPcHZKMUdaaTJHWmJPdUZ5cllJeVZh?=
 =?utf-8?B?WVMrT1pmci9PVmw2SnVjckZrK0hISk8wcmpmWkNXWW9BS211cGdpV2dhMlZv?=
 =?utf-8?B?R0V0TmEvaGJkeXJmNmVMTHFXeHk5OCsvcFdKeUxWTjVmWHhRbkhGK3FBQ25F?=
 =?utf-8?B?cDZpbi91OWdzOGRqSTlLZEZrN25Lb3NsKzBTanVHQjg0YkRObHROeEpmNDVa?=
 =?utf-8?B?c2RaT2lGNUdrNmg2b2s5clNPNFcyZEU1aXczM012Ulk3NitoZWE0bytsbTRC?=
 =?utf-8?B?NFFVTFhmcklOZStKeW1nVmQ3NzVkc00vR0loM3pYaXg4dGo5OFB2RzFyMnVP?=
 =?utf-8?B?ZXo2MTdyN0pDVDFsQ2JFYTlIWVNWUzlKQmhkMjNWMTVLd2NIZ0wxWFphZ1da?=
 =?utf-8?B?c1FaMFUzRXlTY0JsVFRwcEZHR05qR2g0VHlOTy9Yd1Y5NmNwOWxzcnZ3R1BL?=
 =?utf-8?B?dGZGdTdvRFowUnJqQ0hVaWUxdzRGVlpJb0xmSG5PbWQvU0tDc1NwNFd3Zk4r?=
 =?utf-8?B?dXNBeXArbmpPaUxTL1ZSZnUwdllCcDdMaWFGRzlTMUpzcGNGaUt6TTk4dGdv?=
 =?utf-8?B?Ump5YUI2dlBVc1IvRXNUellsbEp3SG84bjBvT053WGovamZ3K0RBSkhSbDJk?=
 =?utf-8?B?dU1qa2lPTXN2cFhueENJWENuZXlxNUl6OHFteG1FTCtocU0veE5uOGJKalZo?=
 =?utf-8?B?d1VYV3VYNVlNRGhTb2V6MEZHQVJ2Z0swRTc2WVlDRXQyNkh6QmRGUURIbHlo?=
 =?utf-8?B?b0sxVWg1UXlrY2ZRQnJYUFFadkN1bzhncHFmb0NDUktmYUxWY1VCTEFTNExZ?=
 =?utf-8?B?d3Q0dnZybVlCN1BOYzcwaXhFSVl1MmdMeU5Bc2VlZlVMcWpEcjRkdS9ESjh5?=
 =?utf-8?B?U2VoYXczQWp2alZmYkJwK0kxb0lQWjh5RlNKSXJGdHY3eUN4a0F1MDNUNHll?=
 =?utf-8?B?L25nRFZ5a2p2WlhBRmxVekdzZWJlWmw5TG9qTVpPcXY1MjNONXAwaHZ1MXJh?=
 =?utf-8?B?K3JTTjZyU3JKazY2UEZHbUczc3hZQ05GbmlYZ3g2cnZTZnVsQllyMGhFZ2ZE?=
 =?utf-8?B?MFdhTEpXcVdKTHpDNGxTNTZKMlhKdnlQdVkwZ3FBT05oRlNlWXA0d2Mxb1Zp?=
 =?utf-8?B?UUNoeUNFSC9WZHI0RG5ucFVGYWorZnY5Wnd2UmM3YWw3dWhBQlVSaENnTmM5?=
 =?utf-8?B?aVhxQ1lpTDVqMjBLZ3NxNVh3OXVqT2tJZmFSalExM3NWMENnalpDV3BiSE5i?=
 =?utf-8?B?VEI5MFBzaUM3dlBJSVc1Q2k4Q1BtWVRSSUl3VzhaS0RYVzIzNnRrZGtsTHU0?=
 =?utf-8?B?SFBJL1NQNXdVeUowM044ZkpZcFVGUGxrWllsWWVIZms2K0NPem1ZL2lleHZl?=
 =?utf-8?B?TlBIM3V6SUhXYU0yNzJ0NTgveUVzdXREeThtamxaZUNQOUtyaDBKbUYyeElK?=
 =?utf-8?B?WUVHdVRUMGN0Wk02UmZ5MnVLZlcwUWNiUkVuS0NYLzhYb1QzS3l5dlJFYlpp?=
 =?utf-8?B?NG16VVJleW9HdmRvbTFxVDZZbXNNUkxwT2JsOE5wU0JTODV2aUI2TUtSZFRD?=
 =?utf-8?B?RFViL3g5VUJ0YjJIMFA5RFpiNjJYU2xoaldkTEV1N2Rjd2F2TDJGTGV2S1li?=
 =?utf-8?B?NFJCVGpDdTVhL0cyTnRJM0Z6TTdocXdKbDdzaXFsTUhaUUpVdmtNMXlOY0Zv?=
 =?utf-8?B?d1pULzEyaEsyNTA3bXl3UlMxeHlpMUx4dXdvMlJwWDVoQWxCclB5QW9jT2J0?=
 =?utf-8?B?VUVjbDcrc3ZWN1VjeG4zd2VxRWJEYXpESG8zSWNTMFRUVW9GaW15K3pNdCtO?=
 =?utf-8?B?bHFGTTN2SGJzbjJReU94RFlQTTNSQXpsY2lNb2t0VHdBRTQ3Z09QQkZodjkw?=
 =?utf-8?B?QVVaRG5HR2x4b2NlSVVycHpTNzVRL1ZtZ0xwNWNLTWZTYXFnaW0zZjkydTNZ?=
 =?utf-8?B?dEIwcGwrQnVSaTBmcmZUTWh5TFlXTnQyckZXaERYZEtMeUQvYko3ZW5RZmFE?=
 =?utf-8?B?Sm00MWRac2RMNEttK245K1YrcUdFRUl1ck90ODJoRGxxNkVnTmhwdW1lWTVI?=
 =?utf-8?B?RmlsS1k2MU9VTHpTU2o0NVZPMmJTSWxVODgwckpRNTNXUDR5T3FkZHBOV2t4?=
 =?utf-8?Q?OLooFlNfWt2Ta6SiTLiCGIrxb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a4b6a3-8031-4d3a-629d-08ddaa417a7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 06:13:56.1117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vTRafQHjztyrUG46okMmSNkLX5dJ5j6YCEmGYBmi2bEaoPIhLku+32yoDghQv6DknmZUoe7ma1KtcqMFD7qgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8535

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW0gSGFydmV5IDx0aGFydmV5
QGdhdGV3b3Jrcy5jb20+DQo+IFNlbnQ6IDIwMjXlubQ25pyIMTPml6UgMzo0OA0KPiBUbzogRnJh
bmsgTGkgPGZyYW5rLmxpQG54cC5jb20+DQo+IENjOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpo
dUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4gbHBpZXJhbGlzaUBrZXJuZWwu
b3JnOyBrd0BsaW51eC5jb207IG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnOw0KPiBy
b2JoQGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7
DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2
YW1AZ21haWwuY29tOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIFBDSTog
aW14NjogUmVtb3ZlIGFwcHNfcmVzZXQgdG9nZ2xlIGluIF9jb3JlX3Jlc2V0DQo+IGZ1bmN0aW9u
cw0KPiANCj4gT24gVGh1LCBKdW4gMTIsIDIwMjUgYXQgOToxMeKAr0FNIEZyYW5rIExpIDxGcmFu
ay5saUBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFRodSwgSnVuIDEyLCAyMDI1IGF0IDEw
OjI3OjQ2QU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+ID4gYXBwc19yZXNldCBpcyBM
VFNTTV9FTiBvbiBpLk1YNywgaS5NWDhNUSwgaS5NWDhNTSBhbmQgaS5NWDhNUA0KPiBwbGF0Zm9y
bXMuDQo+ID4gPiBTaW5jZSB0aGUgYXNzZXJ0aW9uL2RlLWFzc2VydGlvbiBvZiBhcHBzX3Jlc2V0
KExUU1NNX0VOIGJpdCkgaGFkDQo+ID4gPiBiZWVuIHdyYXBwZXJlZCBpbiBpbXhfcGNpZV9sdHNz
bV9lbmFibGUoKSBhbmQNCj4gPiA+IGlteF9wY2llX2x0c3NtX2Rpc2FibGUoKTsNCj4gPiA+DQo+
ID4gPiBSZW1vdmUgYXBwc19yZXNldCB0b2dnbGUgaW4gaW14X3BjaWVfYXNzZXJ0X2NvcmVfcmVz
ZXQoKSBhbmQNCj4gPiA+IGlteF9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoKSBmdW5jdGlvbnMu
IFVzZQ0KPiA+ID4gaW14X3BjaWVfbHRzc21fZW5hYmxlKCkgYW5kIGlteF9wY2llX2x0c3NtX2Rp
c2FibGUoKSB0byBjb25maWd1cmUNCj4gYXBwc19yZXNldCBkaXJlY3RseS4NCj4gPiA+DQo+ID4g
PiBGaXggZmFpbCB0byBlbnVtZXJhdGUgcmVsaWFibHkgUEk3QzlYMkc2MDhHUCAoaG90cGx1Zykg
YXQgaS5NWDhNTSwNCj4gPiA+IHdoaWNoIHJlcG9ydGVkIEJ5IFRpbS4NCj4gPiA+DQo+ID4NCj4g
PiBZb3UgbWF5IHJlbmFtZSBhcHBzX3Jlc2V0IHRvIGx0c3NtX3Jlc2V0IHRvIGF2b2lkIGNvbmZ1
c2UgZm9yIGxlZ2FuY3kNCj4gPiBwbGF0Zm9ybSBsYXRlci4NCj4gDQo+IEhpIEZyYW5rIGFuZCBS
aWNoYXJkLA0KPiANCj4gSSB3YXMgdGhpbmtpbmcgb2YgbWFraW5nIHRoZSBzYW1lIHN1Z2dlc3Rp
b24gaG93ZXZlciB0aGUgYXBwcyByZXNldCBpcyBpbg0KPiBzZXZlcmFsIHBsYWNlczoNCj4gLSBp
bXg4bSouZHRzaSBwY2kgbm9kZSBhcyAncmVzZXQtbmFtZXMnIGFuZCByZXNldCBpbmRleCBudW1i
ZXIgI2RlZmluZQ0KPiAtIGlteDhtKi1yZXNldC5oIGJpbmRpbmdzIGFzIHJlc2V0IGluZGV4IG51
bWJlci9kZWZpbmUNCj4gLSBwY2ktaW14LmMgZHJpdmVyDQo+IA0KPiBHcmFudGVkIGl0IGlzIHVz
ZWQgYnkgaW14N2QuZHRzaSwgZnNsLGlteDhtcS1wY2llLCBmc2wsaW14OG1tLXBjaWUsDQo+IGZz
bCxpbXg4bXAtcGNpZSBhbmQgaW4gZXZlcnkgb25lIG9mIHRob3NlIHJlZmVyZW5jZSBtYW51YWxz
IGl0J3MgYml0NiBvZg0KPiBTUkNfUENJRVBIX1JDUiBuYW1lZCBQQ0lFX0NUUkxfQVBQU19FTiBi
dXQgZGVzY3JpYmVkIGFzDQo+ICdQY2llX2N0cmxfYXBwX2x0c3NtX2VuYWJsZScuIENhbiB5b3Ug
YXNrIHlvdXIgcmVmZXJlbmNlcyB0byBnZXQgbW9yZQ0KPiBkZWZpbml0aW9uIGZvciB0aGlzIGJp
dD8gSSdtIHN0aWxsIHVuY2xlYXIgd2h5ICdkZS1hc3NlcnRpbmcnIGl0IHR3aWNlIHdhcyBhbiBp
c3N1ZS4NCkkgc3VzcGVjdCB0aGF0IHRoZSBsaW5rIGhhZCBiZWVuIGFibm9ybWFsIGFscmVhZHkg
YmVmb3JlICdkZS1hc3NlcnRpbmcnDQogdGhlIGx0c3NtX2VuIGJpdCBhdCB0d2ljZSB0aW1lLiBU
aGUgcmVnbWFwX3JlYWQoKSB0cmlnZ2VyIHRoZSBoYW5nIGluDQogeW91ciB1c2UgY2FzZSBhY3R1
YWxseS4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gUmVnYXJkbGVzcywgYW55
IGNsZWFudXAgY2hhbmdpbmcgdGhlIG5hbWUgY2FuIGJlIGEgc2VwZXJhdGUgcGF0Y2ggaW4gbXkN
Cj4gb3Bpbmlvbi4NCj4gDQo+IEJlc3QgUmVnYXJkcywNCj4gDQo+IFRpbQ0KPiANCj4gDQo+ID4N
Cj4gPiBSZXZpZXdlZC1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+ID4NCj4gPg0K
PiA+ID4gUmVwb3J0ZWQtYnk6IFRpbSBIYXJ2ZXkgPHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbT4NCj4g
PiA+IENsb3NlczoNCj4gPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvDQo+ID4gPg0KPiByZS5rZXJuZWwub3JnJTJG
YWxsJTJGQ0FKJTJCdk5VM29oUjJZS1R3QzR4b1lyYzF6LW5lRG9IMlRUWmNNSER5JQ0KPiAyQnAN
Cj4gPiA+DQo+IG9qOSUzRGpTeSUyQnclNDBtYWlsLmdtYWlsLmNvbSUyRiZkYXRhPTA1JTdDMDIl
N0Nob25neGluZy56aHUlNDANCj4gbnhwLg0KPiA+ID4NCj4gY29tJTdDM2QxYjNmZmEzOGVmNDAz
ODA2M2EwOGRkYTllYTBjNjMlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWMNCj4gNWMzDQo+ID4g
Pg0KPiAwMTYzNSU3QzAlN0MwJTdDNjM4ODUzNTQ0ODgxNjcxOTU0JTdDVW5rbm93biU3Q1RXRnBi
R1pzYjNkOGUNCj4geUpGYlhCMGUNCj4gPiA+DQo+IFUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3TGpB
dU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJDQo+ID4gPg0KPiBsZFVJ
am95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPTd2VjVIeUVhbHVZZjRpNGwyYW5FWCUyRmI2
ejN4DQo+IFVQYzANCj4gPiA+IHVyaEhOSWRUUEt3VSUzRCZyZXNlcnZlZD0wDQo+ID4gPiBGaXhl
czogZWY2MWM3ZDhkMDMyICgiUENJOiBpbXg2OiBEZWFzc2VydCBhcHBzX3Jlc2V0IGluDQo+ID4g
PiBpbXhfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KCkiKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
UmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDUgKysrLS0NCj4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4g
PiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiA+IGluZGV4IDVm
MjY3ZGQyNjFiNS4uZjRlMDM0MmY0ZDU2IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gQEAgLTc3Niw3ICs3NzYsNiBAQCBzdGF0aWMgaW50
IGlteDdkX3BjaWVfY29yZV9yZXNldChzdHJ1Y3QgaW14X3BjaWUNCj4gPiA+ICppbXhfcGNpZSwg
Ym9vbCBhc3NlcnQpICBzdGF0aWMgdm9pZA0KPiA+ID4gaW14X3BjaWVfYXNzZXJ0X2NvcmVfcmVz
ZXQoc3RydWN0IGlteF9wY2llICppbXhfcGNpZSkgIHsNCj4gPiA+ICAgICAgIHJlc2V0X2NvbnRy
b2xfYXNzZXJ0KGlteF9wY2llLT5wY2llcGh5X3Jlc2V0KTsNCj4gPiA+IC0gICAgIHJlc2V0X2Nv
bnRyb2xfYXNzZXJ0KGlteF9wY2llLT5hcHBzX3Jlc2V0KTsNCj4gPiA+DQo+ID4gPiAgICAgICBp
ZiAoaW14X3BjaWUtPmRydmRhdGEtPmNvcmVfcmVzZXQpDQo+ID4gPiAgICAgICAgICAgICAgIGlt
eF9wY2llLT5kcnZkYXRhLT5jb3JlX3Jlc2V0KGlteF9wY2llLCB0cnVlKTsgQEANCj4gPiA+IC03
ODgsNyArNzg3LDYgQEAgc3RhdGljIHZvaWQgaW14X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoc3Ry
dWN0DQo+ID4gPiBpbXhfcGNpZSAqaW14X3BjaWUpICBzdGF0aWMgaW50IGlteF9wY2llX2RlYXNz
ZXJ0X2NvcmVfcmVzZXQoc3RydWN0DQo+ID4gPiBpbXhfcGNpZSAqaW14X3BjaWUpICB7DQo+ID4g
PiAgICAgICByZXNldF9jb250cm9sX2RlYXNzZXJ0KGlteF9wY2llLT5wY2llcGh5X3Jlc2V0KTsN
Cj4gPiA+IC0gICAgIHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoaW14X3BjaWUtPmFwcHNfcmVzZXQp
Ow0KPiA+ID4NCj4gPiA+ICAgICAgIGlmIChpbXhfcGNpZS0+ZHJ2ZGF0YS0+Y29yZV9yZXNldCkN
Cj4gPiA+ICAgICAgICAgICAgICAgaW14X3BjaWUtPmRydmRhdGEtPmNvcmVfcmVzZXQoaW14X3Bj
aWUsIGZhbHNlKTsgQEANCj4gPiA+IC0xMTc2LDYgKzExNzQsOSBAQCBzdGF0aWMgaW50IGlteF9w
Y2llX2hvc3RfaW5pdChzdHJ1Y3QgZHdfcGNpZV9ycCAqcHApDQo+ID4gPiAgICAgICAgICAgICAg
IH0NCj4gPiA+ICAgICAgIH0NCj4gPiA+DQo+ID4gPiArICAgICAvKiBNYWtlIHN1cmUgdGhhdCBQ
Q0llIExUU1NNIGlzIGNsZWFyZWQgKi8NCj4gPiA+ICsgICAgIGlteF9wY2llX2x0c3NtX2Rpc2Fi
bGUoZGV2KTsNCj4gPiA+ICsNCj4gPiA+ICAgICAgIHJldCA9IGlteF9wY2llX2RlYXNzZXJ0X2Nv
cmVfcmVzZXQoaW14X3BjaWUpOw0KPiA+ID4gICAgICAgaWYgKHJldCA8IDApIHsNCj4gPiA+ICAg
ICAgICAgICAgICAgZGV2X2VycihkZXYsICJwY2llIGRlYXNzZXJ0IGNvcmUgcmVzZXQgZmFpbGVk
OiAlZFxuIiwNCj4gPiA+IHJldCk7DQo+ID4gPiAtLQ0KPiA+ID4gMi4zNy4xDQo+ID4gPg0K


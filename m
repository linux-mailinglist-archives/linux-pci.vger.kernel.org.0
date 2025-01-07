Return-Path: <linux-pci+bounces-19367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9BAA034AC
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 02:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B66D3A4CA8
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 01:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FA2134A8;
	Tue,  7 Jan 2025 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="agnGrU+P";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="J1JioPXe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ED2CA4E;
	Tue,  7 Jan 2025 01:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736214723; cv=fail; b=Qd9xQtaQiE+Lmn2MeVPDvP/5V6l69Ig50yMyDScDbu06iWalAK9+kyolJuTjzNLJqqVXN61LFCzHoP7FDjWN0Yl5B69csbDujYryKiIVQQdBItb4pOte2PJWr3HOIFD90JhaPwksNqcr903N3Y9oXGEJYR/7MWfiDF04IPvtHuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736214723; c=relaxed/simple;
	bh=gNxpgDDnbZH+zRP8bp4rO+YMuj3hU3Q/G4JDJTz/928=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nh7cqdx/fGZdYyMDteTrS5RuDHBfacp3rW/41HZZdFYFp59fJx4dkDJsMx7yA5ol7vC+5Zr1awlPMv+LpapYpf/j62sIjjodKYF4OBNynQdBwk8fVSe/iaypCISaOhOXwe+TOAXO2NcYllKshVe0L4WRuDaxDcBUTjoSTx5qLgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=agnGrU+P; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=J1JioPXe; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f96b3f40cc9911ef99858b75a2457dd9-20250107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gNxpgDDnbZH+zRP8bp4rO+YMuj3hU3Q/G4JDJTz/928=;
	b=agnGrU+PyTnhStscLv+z5agK+1FTuJBbTRYXDkkd7V1hIQoSzgZAcCXwTq1zPoWgcZr8nQakWLJ+HjyA1lK45RBeXSCOlmbUmSHBB+jiw7p/5jK6ZTRSHvgsx52vyPSm1e/q1aTUHlsrLQF3qhRtbaPadwgFXkGa7Ajc0Qn1/1w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:ef483a46-04a4-4e47-a1eb-28cc4aa63995,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:60aa074,CLOUDID:c4297019-ec44-4348-86ee-ebcff634972b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f96b3f40cc9911ef99858b75a2457dd9-20250107
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 975760941; Tue, 07 Jan 2025 09:51:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 7 Jan 2025 09:51:54 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 7 Jan 2025 09:51:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9AJJEmtljUzNgI/76SOWNEBAIvY1XB3PUo4wOfIkVMCMydvfwND50ZRskEe/S2oCp8XSoq82WgzKf76ZuPQhk3yZMl5qJR+F02xdHzq07qr8/zVNABmNWgLaihJ2cyDPker30/4WpRvZYvKgR1n7uNyxnX27VyFOxUcK0qLGS8ReTAMbZTmnHAAbiQugZFRxOEYVVJaea3F+B/yH/9aKcagVJkijtVO0EOtsBRn4yZZ6p3rTxVdnUvFi6TuHiNIDa4n4w03B7kZmH8AvV7v71cgWrNkBBMCJ+8HukF2Dj4hMPDFkV7C68aCB5vP2Ox6i/KmKo40aWBIOR34SdejcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNxpgDDnbZH+zRP8bp4rO+YMuj3hU3Q/G4JDJTz/928=;
 b=XdXj5Tiz4KKumWDzAjYWZ/6CMwicsT67c6eCGYV3ol3zkWhdyrGFJu1/qKDWhuzU+94gGmCB5WSdrFbeP5LQb2uceTNwI/SdfIY2KGeHQHnEucehwaoIXdTb7rREzwGtxyO4xy8gS/zG2pEP6M/g0pPV+RBpC9SN+9t1YjvFsGkkxM+aEWbybEeD82F1E8/AtMA7pOWsLbTLyrKPH+iCjlpq+v/dk8Q38dkg5WPvaqc4/AoRPUcqMVhAC4L9GiqgB+OXzZsfGUjuXPKw3PRlX6ffMfJDBiRjoYO5aBAa/I7txsoEg5gJMbdmbdlS83YrO8zrtExoLN4CHdVXfUfv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNxpgDDnbZH+zRP8bp4rO+YMuj3hU3Q/G4JDJTz/928=;
 b=J1JioPXeneJdrKFPDOJ9WGl9OESQz0KNnEBB4TGILqH3DjfCReNqFARSRlDekjp0185z9ad2/BNWEKJnibvJ9eNVQgExnv9KJocUYNrwwuRoeDWNEqCe1k8iNlB9bqTZUZYuSvs3oQ5WK0+76BY2klg3Oi7Gqrcj69uyo0efV3A=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by JH0PR03MB7633.apcprd03.prod.outlook.com (2603:1096:990:9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 01:51:52 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%3]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 01:51:52 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "helgaas@kernel.org" <helgaas@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?WGF2aWVyIENoYW5nICjlvLXnjbvmlocp?= <Xavier.Chang@mediatek.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH 2/5] PCI: mediatek-gen3: Add MT8196 support
Thread-Topic: [PATCH 2/5] PCI: mediatek-gen3: Add MT8196 support
Thread-Index: AQHbXaTZvG6XLjh41kevru3xE94Rw7MFaNuAgAUpVAA=
Date: Tue, 7 Jan 2025 01:51:52 +0000
Message-ID: <36c5011e0df6a706d7389aebeda8f8912f403fe8.camel@mediatek.com>
References: <20250103190245.GA4190015@bhelgaas>
In-Reply-To: <20250103190245.GA4190015@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|JH0PR03MB7633:EE_
x-ms-office365-filtering-correlation-id: f71f457c-10e4-49b4-ebd3-08dd2ebddb6c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S2J2Q2cvbk1sa2VBVnFNMWZUeEczSDJVVUNmcmt5SnJTZDU1eTRlMEp0R0lh?=
 =?utf-8?B?VTF1Tk9GT0I0aTVHU3UzK0FsdE5WczhjMEtLL096ZmpkaUdZZkg3ZDFZYjNO?=
 =?utf-8?B?WjRHQlIzak80NU9HNmwvYzdwaTFqZU43d21McFJxUVd2d0M4bklNYVdBYWFz?=
 =?utf-8?B?Wk5LanRsaC9ONU83VnNtc2hDcGh1VWk3Zkt6S1pveTBJUjlqcW04YnQ1Rks1?=
 =?utf-8?B?ZmpHanBORjI5Z3hnNWxOZHVodlUyeUh0WkpTWHl0UG5XZ0c4WG5uRmxUT1FU?=
 =?utf-8?B?aXRZSE1YbU9ZWUZBMWxBTWEwaTBib0hyVmpKMnRFMkIvMzlUWEU3cVNDaVd5?=
 =?utf-8?B?ajJSZENvZEg0Rmhvdi9ERFpKNlRnUW5CNTZoeDJEVWlOT20zM2NVOUsweVNT?=
 =?utf-8?B?eDJBU0NIaEVRd0R2ZjNBb3NobG4wL0xNcDFJRzUyY3BxNzhuMDc1UnBVQ0I4?=
 =?utf-8?B?OFRIZkJ2eGovbTZnZEloeEhSdEVBME9oV1FHaS84RHB1V1VCOXl2cHp0Um92?=
 =?utf-8?B?RlFjbzNQN0tuWmt1NGxuMnpUemxnNk56ZHp0Qnc2NmVnOTFkcmI2cWtEb2Jr?=
 =?utf-8?B?RnhNR1FpVlZLRzRXTFVIN092UEJ5WE00SFdOc2Naekk5V2duYmNiSW1QZzBX?=
 =?utf-8?B?a1p6cHVhVHdSMzlXL3RRSnNHb0R4UXM2NWRaUDVFZXk0OGZtMzNmS2FsYnQ2?=
 =?utf-8?B?WG5zYlBkMXNIb1VnUk1uZHdodE9aMUtTRWFkVjZZaDFSMUJYSnliS09tOFpL?=
 =?utf-8?B?aWpPZ3dHY0k3ZmNkUGwwM3c1bnZzeVI3WTVVaGUwZWg4S2hnRGZ3d0c0UENX?=
 =?utf-8?B?UWZ1Tjc4dFhBRU5hMkc2Y0ZTKzRUZ1REV0c5aS85ZUdWVlhZcW5pWjlJbXd1?=
 =?utf-8?B?SHBZeVRBL0lWQnd1K3paNkpuNTBBMnYxTEtXYmZNK0MzQjQ2dGVwUkoybzcr?=
 =?utf-8?B?VWI3YUh3NVBmNVRjeFNVM2U0eGgwcllZaWlRV3VPNHUxaUdsdlhndlRoeGNJ?=
 =?utf-8?B?R1JubG1XUlZMeHZGSmVYaDdJeDZxL3JlVTM0MmZZeVNobDdEckJRVWExMXNs?=
 =?utf-8?B?d1d6ZVZEWUNmSW8vU21LMHp4bEY4NHdWVmxMK0pZeTgwdzZXN2ZEbk9zejV6?=
 =?utf-8?B?RGJ3NEpybC84cVBFM1F0dWtNZ1hYb0dCMGVmc2lDTG1GM095V255Yy92N3Vs?=
 =?utf-8?B?cTBML045eEtiYjFpVVhsNkdaOUZXb3hoMUs1RU9tMHowQUZxYnlPenhkbkx2?=
 =?utf-8?B?eVpEMlVwY2dUZlZqaEo1UWVyc3pPY0txaHQveDVYazZ2TlQ3TFFlVlJjakFr?=
 =?utf-8?B?NSt0bnZKNUs0UkNpVEhMZzUxRkl1a1NCWllMb24wWmpOZ1BjbWlKZnZaYjlk?=
 =?utf-8?B?T3BERUdKaU5lK1JCV1VqSWZhNFRHbTJDMHVWTG9vTEdFaTIyMUExeHQraVd0?=
 =?utf-8?B?YkRGOFg1cjBKWWN5TVIrV3VxL1N5S3lJR0YxTk52UjF3c2gxc0d1ZHNWcU56?=
 =?utf-8?B?dEJTVnM3N21WSEN5dzhFbzhud3ZVV1BxR2ViZ2hrclJVRnFjbnhvMGZFRmZi?=
 =?utf-8?B?aXZXKzdseWVvbTFCU01Na0x2Zjljcm50eTc0Ukx3RVh4RTBlMlNWdWxIMzNp?=
 =?utf-8?B?Qkp6S002RFhJSExLb0RFcHdVMmhHb1d4QVJwNFNWTW5jaG1tbEZYcUtEdTlh?=
 =?utf-8?B?L2hTVXJZM0JEOC91bVNDaWFtZllHMXlMcnZMU1BWN1U2a3dXZHJBdlhoaW53?=
 =?utf-8?B?MS92MDlFbmhWdDdZamJtR29wUy82VVV6TDd5R2dCaHhXNnpKNnY2dXFhanFj?=
 =?utf-8?B?Q0JMYWxZV2tmNHh5QTVXWDdVb1dRWDVIVXJwbCszRmxoM011V2NVWnZrK21I?=
 =?utf-8?B?S1R3TGkzTUpCd3hDU2lIWVNjRnNhRjFMc1FEd1N2aEUvNzZUT0w1UXg1TW5X?=
 =?utf-8?Q?E1fptiheI0JzUusOaBk9guo2lfbOZjTz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0VFdXh5aGl6dTllc1VVdWpnL3hTaVMvVlozamFmS01id24rc3dqTjlrZTlF?=
 =?utf-8?B?SlF4dWl5NWFUSnBTWTRSU2VSenNiVW5DTnBGSXVTRzh0NDBYdFQzcGxSd21J?=
 =?utf-8?B?ajEySHhNN0djYjlxQTFtYXFHMFpsR0FXSTVuc3QwaE5WM0FDYVlmWkxSUEJZ?=
 =?utf-8?B?Y3pZdFBEUXF6WVEzK1RWc090UjNrZ1F6U3pKczFPRDEvdUZlRS9WL0ZYUjVB?=
 =?utf-8?B?d2xoVVd0Z3NDYXJ4RFVib2hlRWJvWmxmZVhyeG9BWXFaYlJ4WnEyZXpXTUJo?=
 =?utf-8?B?V1FINjgrclJmcXFkQnNxenB1c2U1Z3p5blIvUkR5TWdQdXlhdWh0b1g2ME1V?=
 =?utf-8?B?dGdxMHBUZm1qS2xtMGcxWmNxaVk3ZE5JNFpDcVBwVkI2ZDhRMm5Wc2wwVXJs?=
 =?utf-8?B?MytoY3dZNkxwR2JVMFVQS2s2TG16ek1BQmVsQWEwM1NqZmZldHJVbkFFdDYy?=
 =?utf-8?B?ZC9CM2tqdFNLUW5mdUhsZXoxKzNNTU1zTkNOSUFSdnRjTEgrWCtCWm8zcC9Y?=
 =?utf-8?B?cS94bmdkUjAwQWQ2Z1BoRkdVbEFvZzFvMWlQcXlIbUF0ekRNeXFYTEZDOTAz?=
 =?utf-8?B?Ti8rWE1YNU5ZQ0NsM1E5blEvemM2MkowMGVUZnJwNmxuNm5ZdTlhTVc0U0xF?=
 =?utf-8?B?S1ptcFlmSmxYV2J6Vlkwd0pXWXlGRTF0ZWY5aCtKL2hvUU1wL3BEa1JYUGZO?=
 =?utf-8?B?ZTd4OWl1U3NaMWZSYTVtbmd6b0pQUVRmOXUxR2ROY01mRUhZZ2F0bStlNE5l?=
 =?utf-8?B?UThzN1JDamdUQmhDM05IdFVicnEwbHZmZnhINGk4UHRMYmpiOGtsTFdvRWZF?=
 =?utf-8?B?NFFQUnd1TmMwc2cwd0VhdWxFb0dCamFocjdFMFgzTzBGaXJSTDBQQTFzOGdG?=
 =?utf-8?B?Q0tSVDdUOXdKU1JCbWpUeDNoeGxjL2tWMll6Z08vT3NLTXJ4NmdDTHlEQXpV?=
 =?utf-8?B?VktZdXBMYmNtOXBXQm5rODY2Uld0eU4veTNRbmNMcmQ5QmlSL1EvM25lWnZQ?=
 =?utf-8?B?VFhTaUNiaE1Na1ZLNDdrVWtMTkYvSFlKMjlVTnhSMDBRU2JKa0ZCOE5WZGRZ?=
 =?utf-8?B?akIreXY3cDZ3SU14M0x2cjl3V3ZjTk1yTlNFNUVjU3hqdHdSRUo0cXBsQncv?=
 =?utf-8?B?eE1xYlVNcnhuUmRORGJsb2tZOTRtYjNuUTkvaGdOaytYUFdFUDM0VWVyNDJG?=
 =?utf-8?B?cjBpZ0ZvWFcvYjc1UkJNMHhWNEhaMFh1WmdFKzUwM1R5QXNGRi8zYXJ5WDhs?=
 =?utf-8?B?d292UkpqOUdqYXhmbEZlUmxHMkdTaDdVMGVEK1FGVW1URnF3VVhNYUk5SHpj?=
 =?utf-8?B?TGlodG5UZHJnR21WQlE2NkRKZTRoVmxPVnJNQWtvZXNjQnFVZmJzQVp0ejRt?=
 =?utf-8?B?M3dOZi9TcTFtcU5HN2tGY0R5MnIvWTVFbjFvWHc0RjhkcjVPSWlMSXJJUENp?=
 =?utf-8?B?SldDOXMwODVYRkkydm1kMVFtZ3FMTWlxamJ3aXJOeUhGZ2h3dWt6K3pRR0d3?=
 =?utf-8?B?SFBkdjNPZjVqUU9ES2o0WDN5SHF0UENaZ2xia0wrNEovQWdoemRvZUlLSnR3?=
 =?utf-8?B?d1k5Mm1kaXg0dUxraGZkQkhmQmhPUGxsNXU3RXlmMk9VUVp6NW9qcGFWZmVz?=
 =?utf-8?B?OThVdklhc05ZSzJjZGlab2RSazBHMzZmY2hadkx5TWZaaGxRaVVPdmZXbEFI?=
 =?utf-8?B?N0dFWW5CZzdzQVEyZDdMeURDSHVYZU5WMGJ6WGw3aitVd1BodW53NXpURUJV?=
 =?utf-8?B?TU9RRExRTGJETkpFU0NleGpMbGx1c0xOKzAvTk1jOGdlWGppOGdaS1Y5WUls?=
 =?utf-8?B?U0tzT0x6R1ZnczJVNWRpd0QvSGRIVzFPQXgyZ21lTVA3aXdUdm5JVjgvZktR?=
 =?utf-8?B?RWwrdGZmWkZVYU0wd3pBdVZ5SzRHOFU3ZFE0ei8reFlORGRyK3FPcktzUXJh?=
 =?utf-8?B?ZU1hVUFld1lpZFRDWVI1ejNTZStPODdLWUM2ZG94MlJkVkFFMDZqR3AycXM0?=
 =?utf-8?B?cFdha2o3SW1QUGFCMmZJNU82cWVJWnVNTiswcUx3QnRHSEFpM2xuMTJvRENG?=
 =?utf-8?B?UU1mWEZjMHBlSFhKT2JTODc5OXBweFZQM0FKaWxtendNdjNnM0tJLzZFSThL?=
 =?utf-8?B?TGQ3aVVOTUVNM2NBRVJTK0tUQll4eVRZY2pTYy9BVmt6eW5EMWdMTkNEeEZy?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <867F39843763CD45B19FAEA4A2A9C255@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71f457c-10e4-49b4-ebd3-08dd2ebddb6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 01:51:52.1451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdmRIi8jEwLaQqIfH1AV7706Fn8AZcxdJqOo6HABpC3VEKVKKGNW2npooxBLnHMaTPEWfZ538gZPGy4NjhkeiKA72rl2nChgxLVkzQM5/L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7633

T24gRnJpLCAyMDI1LTAxLTAzIGF0IDEzOjAyIC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiANCj4gDQo+IE9uIEZyaSwgSmFuIDAzLCAyMDI1IGF0IDAyOjAwOjEyUE0gKzA4MDAs
IEppYW5qdW4gV2FuZyB3cm90ZToNCj4gPiBUaGUgTVQ4MTk2IGlzIGFuIEFSTSBwbGF0Zm9ybSBT
b0MgdGhhdCBoYXMgdGhlIHNhbWUgUENJZSBJUCBhcyB0aGUNCj4gPiBNVDgxOTUuDQo+ID4gSG93
ZXZlciwgaXQgcmVxdWlyZXMgYWRkaXRpb25hbCBzZXR0aW5ncyBpbiB0aGUgcGV4dHBjZmcgcmVn
aXN0ZXJzLg0KPiA+IEludHJvZHVjZSBwZXh0cGNmZyBpbiBQQ0llIGRyaXZlciBmb3IgdGhlc2Ug
c2V0dGluZ3MuDQo+IA0KPiBBZGQgYmxhbmsgbGluZXMgYmV0d2VlbiBwYXJhZ3JhcGhzLg0KPiAN
Cj4gPiArICAgICAgKiBUaGUgdmFsdWVzIG9mIHNvbWUgcmVnaXN0ZXJzIGFyZSBkaWZmZXJlbnQg
aW4gUkMgYW5kIEVQDQo+ID4gbW9kZS4gVGhlcmVmb3JlLA0KPiA+ICsgICAgICAqIGNhbGwgc29j
LT5wcmVfaW5pdCBhZnRlciB0aGUgbW9kZSBjaGFuZ2UgaW4gY2FzZSBpdA0KPiA+IGRlcGVuZHMg
b24gdGhlc2UgcmVnaXN0ZXJzLg0KPiANCj4gV3JhcCB0aGlzIHRvIGZpdCBpbiA4MCBjb2x1bW5z
IGxpa2UgdGhlIHJlc3Qgb2YgdGhlIGZpbGUuDQo+IA0KPiA+ICsgICAgIC8qIEFkanVzdCBTWVNf
Q0xLX1JEWV9USU1FIG90IDEwdXMgdG8gYXZvaWQgZ2xpdGNoICovDQo+IA0KPiBzL290L3RvLw0K
PiANCj4gSXMgdGhpcyBhbiBlcnJhdHVtPyAgSXMgdGhlcmUgYW55IHNwZWMgb3IgZXJyYXR1bSBj
aXRhdGlvbiB5b3UgY2FuDQo+IGluY2x1ZGUgaW4gdGhlIGNvbW1lbnQ/DQoNClllcywgdGhlIGRl
ZmF1bHQgdGltZSBmb3Igc3lzX2NsayB0byBiZSByZWFkeSBpcyAzdXMsIHdoaWNoIGlzIHRoZQ0K
dmFsdWUgd2UgdXNlIGZvciBhbGwgb3RoZXIgcGxhdGZvcm1zLg0KDQpIb3dldmVyLCBmb3IgTVQ4
MTk2LCB3ZSBuZWVkIHRvIHNldCBpdCB0byAxMHVzIHRvIGF2b2lkIGdsaXRjaCwgSSdsbA0KYWRk
IG1vcmUgZGVzY3JpcHRpb24gaW4gdGhlIGNvbW1lbnQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0K
VGhhbmtzLg0KDQo+IA0KPiA+ICsgICAgIHZhbCA9IHJlYWRsX3JlbGF4ZWQocGNpZS0+YmFzZSAr
IFBDSUVfUkVTT1VSQ0VfQ1RSTF9SRUcpOw0KPiA+ICsgICAgIHZhbCAmPSB+UENJRV9TWVNfQ0xL
X1JEWV9USU1FX01BU0s7DQo+ID4gKyAgICAgdmFsIHw9IFBDSUVfU1lTX0NMS19SRFlfVElNRV9U
T18xMFVTOw0KPiA+ICsgICAgIHdyaXRlbF9yZWxheGVkKHZhbCwgcGNpZS0+YmFzZSArIFBDSUVf
UkVTT1VSQ0VfQ1RSTF9SRUcpOw0KPiANCj4gDQo=


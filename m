Return-Path: <linux-pci+bounces-10049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1792792CB8F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 09:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6CD1F236B3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 07:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1377404F;
	Wed, 10 Jul 2024 07:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PNL2C9be";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="IboS8U/l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569E7D3F5;
	Wed, 10 Jul 2024 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720594997; cv=fail; b=U7sIlf2xuqpVa3vjM541X9qcwiQVB23U7aXBIxokK62mnUNgw5hMnXXeMfNbcjy1MDBG44/7AqaOMNx63YVeRCPdvNTUe9bL2wTjzkPv4fc2FZ8vleEaDKuBhqlKXW8sPFE14qooiU4QsXvIIA2cKBKrqq/BBozSD+j0BpGZn5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720594997; c=relaxed/simple;
	bh=NSDDJcVhV+ay5XbvFIiIfucTekFbHEC7qv4YDO82UEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bWvCGitEMlCeLNB35KNMbDNtt0Ukc2yk79ZpBwcIc+pOpfsSMWAHXE02tRfbUD3bS8ZZujtO0QNSlgrCIIJBKP+CnNmCk7nVL4aVFeKzhPRmI2g9JoBKs4VefRURqfv6gyZcDhDoGroOexfWskRnHEfP3FyAfUadNor+gDFqsmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PNL2C9be; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=IboS8U/l; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 70a50ce23e8a11ef87684b57767b52b1-20240710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NSDDJcVhV+ay5XbvFIiIfucTekFbHEC7qv4YDO82UEk=;
	b=PNL2C9beew2SXtdnFFe4er/Qpp94uPjwRkfW0JPw3jZNBZ/UuhoZFxs8VofqwdNh6FkOogzhGwa4qNYuMYP3tC/Q0mhpYKWtGMZD7PRfsYhpcJQ8S9/qtnPB2LgQu9vzGcCpoFxPQSss9tJ/LNUkvLQowIjUvOLC5lwbJdyY190=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:be2dbf1c-eb4e-4e3b-b066-62692c5e1372,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:6a6f4ed1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 70a50ce23e8a11ef87684b57767b52b1-20240710
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1468293177; Wed, 10 Jul 2024 15:02:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Jul 2024 15:03:00 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Jul 2024 15:03:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgmuYnASvEwqNivJjB/0QzlvzuwUSdZBHP3Sj1uuhDabbh0f5JCmuelpzBLNtGOuwWVyob3HT39KOSM4PiztgwZXfhPK2RDiY0ibuFaXqaDSqOBZ69917LUTTziU+RW7PWnLEu2Mq5/J05gqvbm6odLkMb5DXqC/KexVJYtbYabizBT7HmufH1j5N7jIIfr5/q2EsSMevIT27o1uIVYWClELw5/0v0Q+8zCYUN4xty4VzbCVwnSY/EzmFyyUiaNOmnVRSPtI8bGG7t+9lbeTF3ioUh2j2WTJpfAW3cKanMxx9kJr8F1vCi5/ADEsVvUz1yEaWOWZVnAcLIh1OzoH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSDDJcVhV+ay5XbvFIiIfucTekFbHEC7qv4YDO82UEk=;
 b=M02hJcaKQ5aBUsGUEDZLUWq9ucRQn5s5bugMN1oUwU4PehUofirzZ/Ds5jgJQ9aJd77mPMASYO42BuM2HgDfZAeV3hXmn35/vP3dnlIv2FpEFW2nx72cMckVMKvuJFX80J4blck0qrm/7yV0eDPUcpx1V4eIulxTwVjTWaCs14CZ2LV0x2Dgzvg1bS/IoqOfaJ7EPWW7c0LmH5h7E2RnsgJGg+2rl3pAqGxMoCspp3AspulCZXlxOOKFlQnrT2uDTWVjL2OE2Zu14WfPQqZPVLlAOSde0HmGpc/yEmf24c0BocQSZGe0JOLy/M7nWBxdiK8BYJ51bLIo6jy3JWpeCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSDDJcVhV+ay5XbvFIiIfucTekFbHEC7qv4YDO82UEk=;
 b=IboS8U/lsiQSzeXhWAQfVuam86DYIQ5oGXslWyHcQHnOIdYiodZtLqpE3a5BKRzpibVlgcKvHrYs0sx0quMUhCZY/MRs8ymKmHYWarxbve+FK7pAjInGzawLrp06RT/tHcHh/H9sx2PaKDIMzOuil8dodeCBC8+AUUxkj1NpXJs=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by TYSPR03MB7332.apcprd03.prod.outlook.com (2603:1096:400:431::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 07:02:58 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%4]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 07:02:58 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "nbd@nbd.name"
	<nbd@nbd.name>, "dd@embedd.com" <dd@embedd.com>, "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"Ryder Lee" <Ryder.Lee@mediatek.com>, "lorenzo.bianconi83@gmail.com"
	<lorenzo.bianconi83@gmail.com>, upstream <upstream@airoha.com>
Subject: Re: [PATCH v4 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Thread-Topic: [PATCH v4 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Thread-Index: AQHazWQBUY9GsxTwU0GMVo2as5xDr7Hvk5qA
Date: Wed, 10 Jul 2024 07:02:58 +0000
Message-ID: <3d53e7074f9a1f342fec5d0ff59a46827cc96cb4.camel@mediatek.com>
References: <cover.1720022580.git.lorenzo@kernel.org>
	 <aca00bd672ee576ad96d279414fc0835ff31f637.1720022580.git.lorenzo@kernel.org>
In-Reply-To: <aca00bd672ee576ad96d279414fc0835ff31f637.1720022580.git.lorenzo@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|TYSPR03MB7332:EE_
x-ms-office365-filtering-correlation-id: a452786a-327b-4d73-8070-08dca0ae54c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QkZoRFo4aVZOOVQ5eFhxbG5vMDNkSW9zcklZSVdQZnJUTi91V20rQms4UW45?=
 =?utf-8?B?dmtadE0vVDYwaFJuZEhTNGNhWmpvUm9qQzhWNjR1cDI1U2hqeVNvZGpsYm14?=
 =?utf-8?B?MGZJc3pJc2p5NnF2WTNYZFZkU2hvV3M0bmNCR3BjamJhK2ptOTJwZ0hObVNq?=
 =?utf-8?B?RWhHT2pWZzB6ZWF2SXZBblZHdDUzeHNuYUVmelh1RndWRWtqc1MxcVpYczh4?=
 =?utf-8?B?V2VnbWFldHpFMnkxZjh0V1JjSVZhT0RsbHJxTUtPNnFkWFlNb2xENy9aeHlV?=
 =?utf-8?B?WWJncHV5V2JWTm0zQ08zeTBUYldzL2g2eUpRRHFvdXdvemdRMEpEMHY2TlR4?=
 =?utf-8?B?L0dOejRDZlp5dWVOdnNhUHdSM3Z0cTlQdkxldTZRQWNQajFzNTJvUm1OQUlt?=
 =?utf-8?B?MDkwbUFYdkZqSDdKcjE0L0d4N3BvNVZtdXdLWVZSbjVvYTRtOWVEZFBZcVpk?=
 =?utf-8?B?YTgrMVdMYktYTUZlV0d3L0RFUXRTWCtEdUJqNElwbUlWcThNNGZveE1rLzZR?=
 =?utf-8?B?dno1MEltVEFvOGYyUE9ZNnNIVHZNbzlLVU95dlJ5T3ZOQjg3U0hidjFRUkF5?=
 =?utf-8?B?K0k3M3FLZlNMOVdCME5lenRUQXpOalhMN0dlL0MyK0pEcW5Oa1EvenNXTzdH?=
 =?utf-8?B?VmlNcXg1cGl1Qk40M3lnWE81NU1DRkJ4QkhpN0xVSCt1a0JlbnhjZ2Qxblp0?=
 =?utf-8?B?eGxyOEpRVTh4b2VFUDZpWEJaaVU1c1p6YVNRNUJWZnNZNUNmenY4MlBOSlRX?=
 =?utf-8?B?QzNKTEkyUjRmR2JVL0FQZFdpcGE1V1BrakxTTjBqQ0YrMWtwa1Z0NkhzNHNP?=
 =?utf-8?B?K2JhaDF4NWxaNFZNY1BISm5nSmVBa3hsdURMSU9iZXpjRG5rd0VBSHdIamhL?=
 =?utf-8?B?Qm1RRjd4cUxiQ3RGcUNtVHo3eTVEL1hZMXRNTENsQmhrNk14TGxnN01LOEw3?=
 =?utf-8?B?Z2d1Z0RMSDRSSHhmUVVSeEVOQXhldFBwUkthUWZyc2k3SGVSNTd2OFFxN3Zr?=
 =?utf-8?B?cWJRdHVCNEc2a21MUzBUTGIxcm92VmlJWXFvSGpaYklzR3hmaFhaSFpJTTFz?=
 =?utf-8?B?a0NwQWo4R0N0S0FhL1ladjNjeEowaC93Nks4d1h3TVNRZnlLbmtBbCtkTzN0?=
 =?utf-8?B?YTFUZG1VZGRnTkVoNGZBaEtKcEFxdHlIMzlhdm5xeit1SUpVYkV2YXlvcmZ5?=
 =?utf-8?B?RFU5dXVMTHBRMVptVm11SzdkSjR4WXJDWnVYeTc4NHZZaC9NL1E1UmU3TFU3?=
 =?utf-8?B?TlhjWW4xdWtPL0QrR1QrK2sxL1dBUEhGTW03T3Y1L2tJNUY4cUxQRzFQM3hT?=
 =?utf-8?B?T2V0NGw4aXRJUlBWbitpanBONnpSTllmS1U4cEVDdXhzb1VHYzFncFgxTU9D?=
 =?utf-8?B?S3dmczZsTnpvUVB5cTZJM2VvTWdNKzIrc3diOENjajY1VXhFeWRwVG1FTkZD?=
 =?utf-8?B?S29EVTQxTktmaEVGNWZXbUZGVFRJRXJsNnhkUFJtSGxpR3BncE4yeHVqRzdQ?=
 =?utf-8?B?MzR4YUVhazJzVlBLNWZrVHFac3JPdy92Q3Fxc3A4LzR2dWZ4U3kvYVo5V3By?=
 =?utf-8?B?ejE0YVRHNndKQ3Y4NmJUQklVQVEyWGtxNnloaXpEZ1NhNW5JaHlWazdWWVJ5?=
 =?utf-8?B?bHVaenU4N1VBUlBSQm14RTYvQ0E5TWRRTjRia21HcHRFOVFuZlVZb3FMMUFz?=
 =?utf-8?B?b3lFOEpxTU1OZVdwbHozMThXaFRPL1o5ZC9XRWg2MmU1VUo5MXZaLzdGSFJ5?=
 =?utf-8?B?akMwOUlQMHMyNHhoVXVMRmRIcFB6SFRNMXBmQlBhcnBXaFJZcS9qUEpOMnhS?=
 =?utf-8?B?RkJYbit4dzdvWENsOHkvUlZQaDM0ODlMeVM1clJpZWRoOS95dVVYOG1vS2hG?=
 =?utf-8?B?QXVoTlo5a1F5SEVldVVMWW5YNGdxcW9NUmtIUldtamtXcmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2dwRGRmS25mc0h6TUlTaXZXdWcrR3ZXVkhMTmlvYkhpUFk4UUozN25taCtX?=
 =?utf-8?B?bFErY0JzbG5oWWRCK2VUcm9hSXZVTHliTlBiejc1UGhZQncyUkc2dk1mR1gv?=
 =?utf-8?B?Z2ZBOGdEdC9LUnJpMjdiWnFQTmFMQlpNNTVFU0dVNnZVMENvbDJCWDFNYTZp?=
 =?utf-8?B?b0p5TGZNVlZ0VWNXditKOUhQNE9EekIxWWFRZmc3REtDYzVPNitUYTAyZEYz?=
 =?utf-8?B?UmlWUEFRQXVucm9OaWIvendEQm5lQWo2MHk0aGVvdzJBOTd3Kzc2dm51d1FU?=
 =?utf-8?B?Rkp2QTNWdHJHK2VnYVY3Z2pZRmhpL3YzQkpxM1ZYWGFYb1Y5RHVIeHE4WXNh?=
 =?utf-8?B?dDUyNkN4ZlJjZ0p5bHY3N0JmM1ZRbjdCWW1LUi9SUUtsVUxOS3J1Zmtwdm4x?=
 =?utf-8?B?Y1g0Rkwvd3h2MUpEUGU3bmJlbVcrcmw4YVhyTUxmdEd0UTVaSHkwSEtPd1Rk?=
 =?utf-8?B?Q3ZSa0hFcldVRTJpYTNFOVUxUVpBSVNJb3pjU0RZNGIvVkJUOWJZT1A2WVZs?=
 =?utf-8?B?MVlkV0FVM2VlRGg5MG9jN1R4UlF5YUhTV25WVUZKNVZSSjZrZDJkKzJNYUxM?=
 =?utf-8?B?bGUwZ2tzTThYOUlIY1BUNHk5Y0V1QlpSNUdOWGY5V2k3NHZ6SFdGSmtzWUhB?=
 =?utf-8?B?d3cyeWwrZDZNQ2hZUGoyVDhybHZSbVdKR3BPOTJtU2xxNXM4d09sUTMxcW81?=
 =?utf-8?B?VGI0QXBUaXcxNzh1YVNaanpHdnlaTG9vNkNSN3MvRG1YSzRBOXltdERObk05?=
 =?utf-8?B?Y2NyYUdNL0dYUng4SjlrdldNVG54aTZSbTdWSnU1eklVT1dDQmFwR2RubnAy?=
 =?utf-8?B?Uk1LRjllR1hUeXRIYVE0K0c3TGRoV1JRd3Z4NWVjSFljZzF3Zk9IaHNlQ3F0?=
 =?utf-8?B?ci8vUjI2NG5EWTMxSEgyOFBmTWJSMmxWU1BDL05VSXphSWlJNlhHYXlkcGJM?=
 =?utf-8?B?L3l6aENTSC8wZ0pIRTFEWlBkMnc5ZVdBdWpxSnAwNGVrU2MvTlhBV0NMV1pw?=
 =?utf-8?B?NlFkMnhMaTcyejVjYUVYbTR0d0owWXd1SWJnVTlSc3M3dmtCQnhQTFJRWkpx?=
 =?utf-8?B?dDZNRHNjdEJ6LzQyeXQ4SzZpWVlDNnpqVXV2cWhHOFg5dzFyMnhBemVQSnBB?=
 =?utf-8?B?cVk3OFY1V3IzUWc2UHo0TnJaL0ZadDVyd1ZzamVJSVZzSW5hQ0t5aHJhQ2JU?=
 =?utf-8?B?UkE1UnRWeHNrYXhNdy91dk9zSkY4RmdIaVBCUWRiVnIxTi9DUFp4ZFZLUDhU?=
 =?utf-8?B?TlNnS1RKbk5Ib0VlOGdFS0UvWGdwNGJ4Nlk0MytxV0F5cmFMdVNabmNaZ1ZX?=
 =?utf-8?B?d3NUcWxxOTlKU0tRNERWK1VPVzFHTXRoeXhuQjZsczBoekxUYUNzemdKV2RZ?=
 =?utf-8?B?MzRncDJPcXp3OGZOR3Fqazc5eUVtL3ZCM3gvMzcxTUxhemNwbXk2WXVabnI5?=
 =?utf-8?B?ZnpRN3p6OG12bEc2aUhpRGRBYloraWtJQVJPaURlUlJqVDlIV2YzZUNUaHht?=
 =?utf-8?B?TXBkenJLZVcvVm1jS0MrUEd2VStha2ZYc3pjdW1Md01sWFp5TDdLNjFEMVNy?=
 =?utf-8?B?Si9SR0ptbVJRUnhTVGFFSjFLLzE2aENNd3dRVHNtTWhMTEFLRjN1TFZDMVBt?=
 =?utf-8?B?bnRDRFNzV1BHU0hkcWRzL0pBUFJuRHVUQlRlaVU1Q0VXc0ZGeGwzYnRPRCtu?=
 =?utf-8?B?VkhFbjBGYlZkOHRtai9tbTlJS3lDZEVpSEVsSXkxdUsyNWo2a2lEQ1A5SFJF?=
 =?utf-8?B?K1psM0VhZEZjZEQzd2JudXdPMTJJT2tEd2I4a0E2dDY2dm9lWnhKUXphNmVI?=
 =?utf-8?B?dng5WCtSYW5idjFOZXRBSzBETTNqRWJwNzhQWHp1MEord0FrUlY5eGE1bmpN?=
 =?utf-8?B?MUNLOEtnK0dqVnA0eVRoMHVjZjNCK3oxYnhlL0N3WXpJN2FVRnJCZjRLMnND?=
 =?utf-8?B?VDc5OGtWREprdTJVeEM0TDVUZDl2UEdQSjk1VWZNcFpGQmd5NGRZazRQQkxC?=
 =?utf-8?B?bDNiUkhMKzU3VnhCUW1yb29ibjNkMWN1SjQ2ajVsaUIxSUxNY2hXY004WVVz?=
 =?utf-8?B?WlF5aXczL05hWjFzQ21qTmtkTFdtSUk3TnM0WGtHTW0wcW9wN2h1bHNHb21i?=
 =?utf-8?B?cjM3TGUwdVRmT29WUFdNNFM2eW1SMFJMVEg5UDlDVjB2b294WW5tVXJxZGlV?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2ED5B1A54AD9148B9618F4AFBDA9907@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a452786a-327b-4d73-8070-08dca0ae54c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 07:02:58.6561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StjHeU2WGfMgPuDaaL3k0/9Tmkj8Qv962mCfRPHe9f1oI+gqRHreu0jEgkP3nKCIAk2S3YXuH8GeoAOsFibjA3X8BD6kMpt/WMUZiUA7500=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7332

T24gV2VkLCAyMDI0LTA3LTAzIGF0IDE4OjEyICswMjAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gIEludHJvZHVjZSBzdXBwb3J0IGZvciBBaXJvaGEgRU43NTgxIFBD
SWUgY29udHJvbGxlciB0byBtZWRpYXRlay1nZW4zDQo+IFBDSWUgY29udHJvbGxlciBkcml2ZXIu
DQo+IA0KPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdl
bG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IFRlc3RlZC1ieTogWmhlbmdw
aW5nIFpoYW5nIDx6aGVuZ3BpbmcuemhhbmdAYWlyb2hhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
TG9yZW56byBCaWFuY29uaSA8bG9yZW56b0BrZXJuZWwub3JnPg0KDQpBY2tlZC1ieTogSmlhbmp1
biBXYW5nIDxqaWFuanVuLndhbmdAbWVkaWF0ZWsuY29tPg0K


Return-Path: <linux-pci+bounces-15914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03A79BADF1
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 09:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 013BAB218CA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 08:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C16A18A6C8;
	Mon,  4 Nov 2024 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cdlYqB2y";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="EveX3gcc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F91A4F2F;
	Mon,  4 Nov 2024 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730708562; cv=fail; b=ZxyRRwDiRB10XEyAGJlJgxGfTRPYQ+n7/wNtaqQob6/9AcWEzCogkXMlz5CoJRdzTgvmEY2e7ukFR2liyRr1zfqcDo9Zisj5bLTD0cdpqdPfUxHgWZ4RZEMw8QqKTL6ghByfFj0fIpqarPGjXGu9//LbrSF1KB+fDxcOCSCo07Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730708562; c=relaxed/simple;
	bh=wC8SHg7FupaKX7sJLfCAwSi+hLodke9LSBAM0PSqJ48=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NxGy6a3Q8OtJgG3QNgAPr59StajXigeoQMfkHZA+ir1qFALdtsAX1JEVRV5oNeuwt/ueOSSNmNAl/SWiFRkNR8UdsteJ3sfNSmD9F5B7zV2FlZS71w62J571p2RCJuh7O/e6w5OLqC6zPRURvJ4TIGakbwXC0hORqn7SQr7vPKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cdlYqB2y; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=EveX3gcc; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: edc635149a8511efbd192953cf12861f-20241104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wC8SHg7FupaKX7sJLfCAwSi+hLodke9LSBAM0PSqJ48=;
	b=cdlYqB2yvjaHy7iMskPN7wZXTAyhsshYnV1omtDKEoXOIIdEmlTPuVneaacP97X7Z3yvACNoWiKuxetBEpH7cnN6Lzoqs3ZlIRA82GLWopQlgSsqS14qTZsXo154uG3RZLiLGR5ul49bpd89AMkPTCZAmvnDKLFs684AaOImxKU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:efab35bc-8a0c-4187-a2c2-3b3a9dd31809,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:5b188107-7990-429c-b1a0-768435f03014,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: edc635149a8511efbd192953cf12861f-20241104
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1780293096; Mon, 04 Nov 2024 16:22:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Nov 2024 16:22:25 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Nov 2024 16:22:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0F+SjsLDOaxVlUVOeSoQNUn2lInhWlg8NEbSuaUl/G4Z5+KRJkpbjgTqg5oTBYs3H0quDtks6nGgPFSMMFLPTX5UDgxGiLfHiQWEENRLtGTFVjMkssxZ2uQ/f236oBRUO7ionQ9ow4V3l2z/wxeB0EcthXuh6WSl4fhk3/HEn7c3NsxdLNJEqytxRlsWdecuEbIFrINxkOA+DCm1mc3ajtlTYTMGF5wEzjHpDiMnNM9O/L5Tnuq9e+PTjLnETSfu7jPPGKSQlTZFsl3+ATRXK/7lJRFoACQM0yEnG9gKgQv5Zm+CRBPtwYVIObFIwohtU5v1903mCH7UcK9L5PxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wC8SHg7FupaKX7sJLfCAwSi+hLodke9LSBAM0PSqJ48=;
 b=YgBXxFPxXOXbBOAUbRroO4NXeW5JDpqJuRM0LFSPhSfhnsdDxSOQXvWZxa0iS7uwzqHwjdnFN0dM6Z1WUvCk9rymdri0ug+hoN3GytE+ViXTbnFWAMNWN1QBMU5zrPhQZomNSxnn9IMWStBXzTqd9mDQTWBC1gmBeFhY1IjGnvFPBllOL4NFIao+swqcDXCMOM9+v7uG1bVQeslW4EyKvaFimXDet9p7h95UPGJwG7KWpqS/k84Ju0raUUfxGnsB8fhTHmzD950EjOuaX128uzzFJoBaTK1qfYxRvvgGKmb8w3RdlsABcJ18hA9sJH1HnLaW01OhVvfvIGf1AadEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC8SHg7FupaKX7sJLfCAwSi+hLodke9LSBAM0PSqJ48=;
 b=EveX3gcc6EOt8VzwlY2rAd+nrjzecVXyxgodfV8JR/TKOyWBGHOe6vI3rnZR+pzbff/VuGZju2fzaRaYM7+dkenvCGNPMaUIzd+WAKXShgo72CVcT942yLgBMOoeLASmEUiXqGEuH4M8rgOooj88i0Nc0Xyc+ClxwMQIcjN9lEE=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by SEYPR03MB6793.apcprd03.prod.outlook.com (2603:1096:101:8f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.35; Mon, 4 Nov
 2024 08:22:19 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:22:18 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "AngeloGioacchino
 Del Regno" <angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, Ryder Lee
	<Ryder.Lee@mediatek.com>, "fshao@chromium.org" <fshao@chromium.org>
Subject: Re: [PATCH v3 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
Thread-Topic: [PATCH v3 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
Thread-Index: AQHbCaKv1aLjwpTY4UmFXBvK44HsHLKnEg0A
Date: Mon, 4 Nov 2024 08:22:18 +0000
Message-ID: <744a8362065b0c75178c3e0d402ea4932cb1fc96.camel@mediatek.com>
References: <20240918081307.51264-1-angelogioacchino.delregno@collabora.com>
	 <20240918081307.51264-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240918081307.51264-2-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|SEYPR03MB6793:EE_
x-ms-office365-filtering-correlation-id: 35e8bd53-208d-48d0-83dd-08dcfca9cc65
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N1RqbGFqdVJLNlVkODlCMFNCMmE4RnFOcVYyOTNLRkRYU0tZNTFvWjE4aHB4?=
 =?utf-8?B?WUlQejhOdkN6TWhwelNwVVJxekJEdFdxZTE0djl5RldVWWl4cURQL2I5a01y?=
 =?utf-8?B?Z0Q1UUxiTDdvMlVveXBCV0ZNdng5R3JPaFdHNWdqT3U1TTFYZG1Xc2RzcEgx?=
 =?utf-8?B?THdCTHdaSVp6bHZYWkJmWk4xWENTck9OOEtnYlg1SXRGdUpPMmY2RU5tWG93?=
 =?utf-8?B?YytWVXdlbEdjNThXeVZzUE11VzJ2VThKK1AzdmdOOUZsU2ptUWxLUzBjcEVG?=
 =?utf-8?B?a1BGNE1QemJYSEdUSEhTeUlXTldadXRSL2hVd0FtNGVEZ1Z1ZjBLODdwVTcw?=
 =?utf-8?B?VDZtMGdGdEFUQmx3VjJNcnRENVJpVUlNbmZnVWI5WEhoVXFzOUpxOGRFUFU3?=
 =?utf-8?B?TFZlM3JidHZJWFdpUk1tK3FXclozU1hqcGpSSUJtMk41ejNYa01icEZaVWwy?=
 =?utf-8?B?OUNweGUyQk1YWVdDaFVHMzF1dTF2clB4OUVzNkRVeVF0WXFXbTcvSTJjQngz?=
 =?utf-8?B?MjdNQy9kU2RnUW03UnVoQjZGbHliam02bnRaZXZKN3JYVkE2VXRNUEpTbUF2?=
 =?utf-8?B?TVhXeFV6VS91ejViSG1NUDRkaHhsZ1Vha2VZNCtzWFBsT01aRmR3Rk15dmFu?=
 =?utf-8?B?MjF5N1pnZEVOak9rVkR5YWV6MFVJR1NONGZTbEpTbHNKSWVqUDMwNzcxeWcr?=
 =?utf-8?B?UzNZSWc3S1dubWVKUHlLUk1RZVZ0YVZIZ2MrUVdkK0VwWjV6SElZYXRMSFRW?=
 =?utf-8?B?bE5PWUFScmRCWEVjMk04Z3lkMDFUbTE5OVBteVB0WmErZWRaMXJQMkFITE9L?=
 =?utf-8?B?SVJhcEpKcnorNStWOTF1YmVBT3R4QUY2UGt6bmZaUldJcCtld3JsSzgxRGhm?=
 =?utf-8?B?c1VxMTBOcmkxclorMlZuVjRDbUh0MmFsU09VT1N1N0ZmeUJNa21jbHRnWS9H?=
 =?utf-8?B?SVVQeWJUQ01HSWdRK0lseUJWL0JYU3B6UW9PZWlXNi82a1RBWWErNnBZdXJw?=
 =?utf-8?B?b1l3UG9aVW9PK1h6dmZqd0VkdFhXL1hzVFhNcmc5Rm53ckk3eUxLQzFscGo2?=
 =?utf-8?B?UW5QMExUQlcxKzNTT0twc1N6Z2dNYjFMQ0JxZDZKYTYzVnJaTjdrZlhueTlw?=
 =?utf-8?B?eDRUSFdldGJrRVlRSXppWDhHSDgwcG84SjYybFltZDdlSGhkcUdsd3hteGlF?=
 =?utf-8?B?Vzh0cjRGdnFhd1hLR0xCMXl4RklsK2RWTXd2QVBXZnluTE8wL2NxaDIwTUx2?=
 =?utf-8?B?cFBFU015VjRiRzYyd3h5Ty8rdWk1NjZMdXNab28wditJUldFYnBSbkJuS2hs?=
 =?utf-8?B?UXoxMXZaVW1tZWt4Z2cwbVpXMk9ZZHBIZzVGQmQ0ZnlWVE9xQXhjeEpFSlRv?=
 =?utf-8?B?UHREUWw1cnI2enFWeEZHUm8za2JIdE8xOXpPTW05M1FQSmxURVlhVE9NS09i?=
 =?utf-8?B?a2Z4T25qSE5JbUw2a2UxYlNMU2dpZXAxSWtEM2UrNzhLRkVvQW0wb3k3WnFI?=
 =?utf-8?B?MFFERWpaMDJhVWoreWJwcVM3dmZTSmhDcGR6Lzloc3YzeGtLbHFwMzk5ZnJX?=
 =?utf-8?B?NDB0ODZGTWhwYlkzK3lvU2ZiejJBSXIwb3JzN01UTUhJK1JzNi9WVGROZWVw?=
 =?utf-8?B?NkN5TkczUHZvcTViU3NKdnoyQlNsNUNKZEYzUFI4UjEvaWpyd29FSjJ3MUdl?=
 =?utf-8?B?QXdmblRIRHAvRUliV0V4bVBnb08ydlBvcng4Vlp6ODhVVGliL0NGSkxEN3lG?=
 =?utf-8?B?NEYxTVAwRU5WbldGZzhnWDBIdm9oYUV3bE83ekZJWm95LzBRamlPWE5tTnVh?=
 =?utf-8?Q?xo6/4HdfULaUO0nm1+czhx9fJFdcTiOkPC6ZY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXRLcDV5OWE5KzZVQi9HUktQTVpyQS9FeXhtWitCd3E4QjJvMHdjQmNMUzJE?=
 =?utf-8?B?TXpJWWlUcTVYdVE5RjR6Y08zOVlDYTdrTUVHb2x5anpyNngyaFZpOGZoeXpt?=
 =?utf-8?B?SkZBS2piZ0h0MFNXTzdLRi8yL1FvMDRoUXNCQnhiakd4TFdzak55NFh0RUVR?=
 =?utf-8?B?RHFoVU9hRTNUWGgrTzVjWjVsSkUzVWxZY0xEbG5SNWRkTEtaOUt0dFNveHh4?=
 =?utf-8?B?TVdEUVNzUnhUcUE2QVBRUGIzSG5RTjNqQ0VVZlNzL2dML2hKZldwR1V0NG9D?=
 =?utf-8?B?cmwwNUNkWjhVaFlHcDRIYkRDMkVPZDFXQWx0TmZoT2tLV25Qb3ZMZFY4TVNN?=
 =?utf-8?B?Z28wK3FSdHZwQ2tSMXgrelpDOC9WeHhMekFWQ1ZDSGc0M0pIc1g2bWNrUDg1?=
 =?utf-8?B?VW50MzlBeVlKNnNZMWJDd2k2VTBWcWF5SmpsaTkzVktBRERGYSszRHNTeWJx?=
 =?utf-8?B?bjcrcDRxMVNOdjQvS0RiUGQ4MVpUcXErOHZKYnFUOVgyN3VlZVBhMEdrRS9D?=
 =?utf-8?B?NVNTM2FNb1BjNE95WE0wWlcybzFZYkVaZHM0cSsyM1ZZM3VsWEFqMEdYL1BS?=
 =?utf-8?B?TWppUWswdWJhWHZZOExSa0pWT3NjUk0yRjFKWlFRcDRWZW1FaWVwZTVyZG9y?=
 =?utf-8?B?clpTODR2QTZ5TnpuMkN6VEkvNHBYQXZaNXdzWmZUM3o3VzZRM2NBMG1YUVlH?=
 =?utf-8?B?bVBhR3hUREpQYmVnem1aeVBrUTJ3aE5HSWJkNCtpdkF5Y2p5N3BMVk5LQ2dC?=
 =?utf-8?B?NFdhRVNUTEtBb09FZko3bVJZa3VyVE9rQU5pTzVXRTFCQjMxZUZkdmFWSGpo?=
 =?utf-8?B?SUpOaWRxTndvdEIxckIxWHp5QXY4ODJkc0JOcDZOOFNnRDZXSTJ2Mm1teVlQ?=
 =?utf-8?B?ZVNFWGhFYWowNHFobWZTcW4yMnRlbGtnUGNWTkxTVUpqbDhXZE5sdzRvUFNq?=
 =?utf-8?B?VkF1TmxkSDhaYXVmNWplMlBLdXcraS9LaGE0NS9OejVoenY0Q01UQ3oxS3d5?=
 =?utf-8?B?UGdGVVJvWHYvTmRCYS9CcGQ3MzBRZTg4ZnZjc3VmQUM1VFllcjU2V3lYZWVI?=
 =?utf-8?B?Z2xLSnpTWU1KcEtSUG95VDNBVFhDUWFXN25GdTY4dHlsbnRnTVFKZEFQaG9X?=
 =?utf-8?B?WlRvaGtUMVZUMzJvRDM3TStIemxhaXJQeGh2RjRXRGlPbldGb0ZGYTFWSjFD?=
 =?utf-8?B?UStvTElrOTVKMUt6S1dNQjRWM0QzVTd1ZWk5TW95M0JnUkxZWDFHb2MvZmxM?=
 =?utf-8?B?L2NVK3Z4Ykh0RUJhTWl4OWd2ZkhwRTJPSTlzRzlEVE5UQ3FZR2hIb3JqNW5U?=
 =?utf-8?B?eW1hWmcrQmJrNVNFRG9JUUFXb2YyYTkrZjhZdHNGYUNObnY1NGFVeXYwTXRH?=
 =?utf-8?B?OE5RKzZpTTh2ZWd6OEx1UnRFSi81UXVqZkRRTVlrcmFnQnMrcTVmSnVROUp3?=
 =?utf-8?B?WDgrTndqWFNtcUZxdXRJWk1ZWk0vVkZoZWp4cng0emUwRm52WDIxZk5VVFZ3?=
 =?utf-8?B?cnNURThHRmJqUUNSWmFIWHpxMTRLakk4YnZpQm0wWkVncFp3Tjl3ZWsrc2x4?=
 =?utf-8?B?d2VjUHJ0WlhLU2todzhRZmNYcXFMUkFMTE5oSnNuYWtFYWJ1Nzk4Z2xpdzRq?=
 =?utf-8?B?ZGxvZ0VhRlRCbXFSMFd6cXNBcWhqWlpkcTVOOHRFVFRmenVPWnpHem1rZXRO?=
 =?utf-8?B?RzBUR1VSTWlWWmhkUDVTUXI2YVExdzQrOEhMV1pmQ1o2Y3FKYXEvNWU1Mmo0?=
 =?utf-8?B?VlpodzNYSUtGakxqVVhFZGxxK1o1UkZOL1BKNXNZYWpsa3d2VWZRd3ZnbDB5?=
 =?utf-8?B?RkNQOVkzWG9wdXI5MGw1K2RWd21UenY2Rk9pWnJGVGk3R1czNk5ITGE3Z3pt?=
 =?utf-8?B?Q2F0Y1Joa0Z2bXU1UUwvZ0Rnc0d4MldxSFJGSS9RdFVhWEJEdkkrL0t5R292?=
 =?utf-8?B?Qnp4WnJmdy9hMjlZN2ErNFAwTk8vTUd3UmxaR2lLME0wSUlFODZhRlZPOFZv?=
 =?utf-8?B?YWZERnk4QTRRdUdXbjBMdlVwZU1va1NYbDJvNG9mdEI2aG5FaElteUt3NnRZ?=
 =?utf-8?B?dEF2WFptYTdmeVZXT2RrWGpqUHVZR0ZSdjRmN1JPK1hPQW54RUtwN2J5Tjgw?=
 =?utf-8?B?djR3N2duczViVGc3K3VVTlltREkxdkRGYnZmWE5KYldwbitNY0cxWXZxUFEz?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9F0A9CBB8B0B5459F346A7606910820@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e8bd53-208d-48d0-83dd-08dcfca9cc65
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 08:22:18.8194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BudINRjyvlgso7P7DQ2zUmAd4Sfo+PCsWuWtHxPVhITvlvE6FPXkISGKMM66ynv6RyP8SPmjnZqWMMokNtQAsf387zL2XIE0Iiw4ia6j9IQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6793
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.628500-8.000000
X-TMASE-MatchedRID: GBgFBUqwD4HUL3YCMmnG4uYAh37ZsBDCQV6BZJ9WeFayrCkM9r1bWskU
	hKWc+gwPwQTqbLJ40jtIsXsyRpNqM4CkWuQJNIQ/BfXXgOJmsOkhnAF+qfR1ZmqxH4jGPahAZvo
	+mFW19mDu5CPTjxJrzPNh1w4jg7JjeRdgcXs92xdIOSHptb5tx/P4U2pIUfzQDpCUEeEFm7CQxX
	DSJnj4AwRMBudAg30DV1M/l3DgYRGf9SROPcS9xnTnOygHVQpOfS0Ip2eEHnylPA9G9KhcvbLn+
	0Vm71Lcq7rFUcuGp/HCttcwYNipX8KVf7avePdYFiIDlN4HgqjDs/zYrSW2WpZ9nhWKL4v6BKCY
	Y5B00K7/hXwPI51JJ11tzXVh5rPvxztoMiwPD8cyx4w3QdJf/A/YOL4J3nVWOfbyAG+7N/vQTXP
	mYM0+8Ng2r9cuAAjdn6JI6Uotz6TAvpLE+mvX8g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.628500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	EA2769B34BD042D31C7D94A0F4BE9815DE16236A546E4FD227A5E515C2D1E3FD2000:8

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHlvdXIgcGF0Y2guDQoNCk9uIFdlZCwgMjAyNC0wOS0x
OCBhdCAxMDoxMyArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6DQo+IEFk
ZCBzdXBwb3J0IGZvciByZXNwZWN0aW5nIHRoZSBtYXgtbGluay1zcGVlZCBkZXZpY2V0cmVlIHBy
b3BlcnR5LA0KPiBmb3JjaW5nIGEgbWF4aW11bSBzcGVlZCAoR2VuKSBmb3IgYSBQQ0ktRXhwcmVz
cyBwb3J0Lg0KPiANCj4gU2luY2UgdGhlIE1lZGlhVGVrIFBDSWUgR2VuMyBjb250cm9sbGVycyBh
bHNvIGV4cG9zZSB0aGUgbWF4aW11bQ0KPiBzdXBwb3J0ZWQgbGluayBzcGVlZCBpbiB0aGUgUENJ
RV9CQVNFX0NGRyByZWdpc3RlciwgaWYgcHJvcGVydHkNCj4gbWF4LWxpbmstc3BlZWQgaXMgc3Bl
Y2lmaWVkIGluIGRldmljZXRyZWUsIHZhbGlkYXRlIGl0IGFnYWluc3QgdGhlDQo+IGNvbnRyb2xs
ZXIgY2FwYWJpbGl0aWVzIGFuZCBwcm9jZWVkIHNldHRpbmcgdGhlIGxpbWl0YXRpb25zIG9ubHkN
Cj4gaWYgdGhlIHdhbnRlZCBHZW4gaXMgbG93ZXIgdGhhbiB0aGUgbWF4aW11bSBvbmUgdGhhdCBp
cyBzdXBwb3J0ZWQNCj4gYnkgdGhlIGNvbnRyb2xsZXIgaXRzZWxmIChvdGhlcndpc2UgaXQgbWFr
ZXMgbm8gc2Vuc2UhKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVs
IFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMgfCA1NQ0K
PiArKysrKysrKysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3Bj
aWUtbWVkaWF0ZWstZ2VuMy5jDQo+IGluZGV4IDY2Y2U0YjVkMzA5Yi4uOGQ0YjA0NTYzM2RhIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5j
DQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4g
QEAgLTI4LDcgKzI4LDExIEBADQo+ICANCj4gICNpbmNsdWRlICIuLi9wY2kuaCINCj4gIA0KPiAr
I2RlZmluZSBQQ0lFX0JBU0VfQ0ZHX1JFRwkJMHgxNA0KPiArI2RlZmluZSBQQ0lFX0JBU0VfQ0ZH
X1NQRUVECQlHRU5NQVNLKDE1LCA4KQ0KPiArDQo+ICAjZGVmaW5lIFBDSUVfU0VUVElOR19SRUcJ
CTB4ODANCj4gKyNkZWZpbmUgUENJRV9TRVRUSU5HX0dFTl9TVVBQT1JUCUdFTk1BU0soMTQsIDEy
KQ0KPiAgI2RlZmluZSBQQ0lFX1BDSV9JRFNfMQkJCTB4OWMNCj4gICNkZWZpbmUgUENJX0NMQVNT
KGNsYXNzKQkJKGNsYXNzIDw8IDgpDQo+ICAjZGVmaW5lIFBDSUVfUkNfTU9ERQkJCUJJVCgwKQ0K
PiBAQCAtMTI1LDYgKzEyOSw5IEBADQo+ICANCj4gIHN0cnVjdCBtdGtfZ2VuM19wY2llOw0KPiAg
DQo+ICsjZGVmaW5lIFBDSUVfQ09ORl9MSU5LMl9DVExfU1RTCQkweDEwYjANCg0KTWF5YmUgaXQn
cyBiZXR0ZXIgdG8gdXNlOiAoUENJRV9DRkdfT0ZGU0VUX0FERFIgKyAweGIwKS4NCg0KPiArI2Rl
ZmluZSBQQ0lFX0NPTkZfTElOSzJfTENSMl9MSU5LX1NQRUVECUdFTk1BU0soMywgMCkNCj4gKw0K
PiAgLyoqDQo+ICAgKiBzdHJ1Y3QgbXRrX2dlbjNfcGNpZV9wZGF0YSAtIGRpZmZlcmVudGlhdGUg
YmV0d2VlbiBob3N0DQo+IGdlbmVyYXRpb25zDQo+ICAgKiBAcG93ZXJfdXA6IHBjaWUgcG93ZXJf
dXAgY2FsbGJhY2sNCj4gQEAgLTE2MCw2ICsxNjcsNyBAQCBzdHJ1Y3QgbXRrX21zaV9zZXQgew0K
PiAgICogQHBoeTogUEhZIGNvbnRyb2xsZXIgYmxvY2sNCj4gICAqIEBjbGtzOiBQQ0llIGNsb2Nr
cw0KPiAgICogQG51bV9jbGtzOiBQQ0llIGNsb2NrcyBjb3VudCBmb3IgdGhpcyBwb3J0DQo+ICsg
KiBAbWF4X2xpbmtfc3BlZWQ6IE1heGltdW0gbGluayBzcGVlZCAoUENJZSBHZW4pIGZvciB0aGlz
IHBvcnQNCj4gICAqIEBpcnE6IFBDSWUgY29udHJvbGxlciBpbnRlcnJ1cHQgbnVtYmVyDQo+ICAg
KiBAc2F2ZWRfaXJxX3N0YXRlOiBJUlEgZW5hYmxlIHN0YXRlIHNhdmVkIGF0IHN1c3BlbmQgdGlt
ZQ0KPiAgICogQGlycV9sb2NrOiBsb2NrIHByb3RlY3RpbmcgSVJRIHJlZ2lzdGVyIGFjY2Vzcw0K
PiBAQCAtMTgwLDYgKzE4OCw3IEBAIHN0cnVjdCBtdGtfZ2VuM19wY2llIHsNCj4gIAlzdHJ1Y3Qg
cGh5ICpwaHk7DQo+ICAJc3RydWN0IGNsa19idWxrX2RhdGEgKmNsa3M7DQo+ICAJaW50IG51bV9j
bGtzOw0KPiArCXU4IG1heF9saW5rX3NwZWVkOw0KPiAgDQo+ICAJaW50IGlycTsNCj4gIAl1MzIg
c2F2ZWRfaXJxX3N0YXRlOw0KPiBAQCAtMzgxLDExICszOTAsMjcgQEAgc3RhdGljIGludCBtdGtf
cGNpZV9zdGFydHVwX3BvcnQoc3RydWN0DQo+IG10a19nZW4zX3BjaWUgKnBjaWUpDQo+ICAJaW50
IGVycjsNCj4gIAl1MzIgdmFsOw0KPiAgDQo+IC0JLyogU2V0IGFzIFJDIG1vZGUgKi8NCj4gKwkv
KiBTZXQgYXMgUkMgbW9kZSBhbmQgc2V0IGNvbnRyb2xsZXIgUENJZSBHZW4gc3BlZWQNCj4gcmVz
dHJpY3Rpb24sIGlmIGFueSAqLw0KPiAgCXZhbCA9IHJlYWRsX3JlbGF4ZWQocGNpZS0+YmFzZSAr
IFBDSUVfU0VUVElOR19SRUcpOw0KPiAgCXZhbCB8PSBQQ0lFX1JDX01PREU7DQo+ICsJaWYgKHBj
aWUtPm1heF9saW5rX3NwZWVkKSB7DQo+ICsJCXZhbCAmPSB+UENJRV9TRVRUSU5HX0dFTl9TVVBQ
T1JUOw0KPiArDQo+ICsJCS8qIENhbiBlbmFibGUgbGluayBzcGVlZCBzdXBwb3J0IG9ubHkgZnJv
bSBHZW4yIG9ud2FyZHMNCj4gKi8NCj4gKwkJaWYgKHBjaWUtPm1heF9saW5rX3NwZWVkID49IDIp
DQo+ICsJCQl2YWwgfD0gRklFTERfUFJFUChQQ0lFX1NFVFRJTkdfR0VOX1NVUFBPUlQsDQo+ICsJ
CQkJCSAgR0VOTUFTSyhwY2llLT5tYXhfbGlua19zcGVlZA0KPiAtIDIsIDApKTsNCj4gKwl9DQo+
ICAJd3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5iYXNlICsgUENJRV9TRVRUSU5HX1JFRyk7DQo+
ICANCj4gKwkvKiBTZXQgTGluayBDb250cm9sIDIgKExOS0NUTDIpIHNwZWVkIHJlc3RyaWN0aW9u
LCBpZiBhbnkgKi8NCj4gKwlpZiAocGNpZS0+bWF4X2xpbmtfc3BlZWQpIHsNCj4gKwkJdmFsID0g
cmVhZGxfcmVsYXhlZChwY2llLT5iYXNlICsNCj4gUENJRV9DT05GX0xJTksyX0NUTF9TVFMpOw0K
PiArCQl2YWwgJj0gflBDSUVfQ09ORl9MSU5LMl9MQ1IyX0xJTktfU1BFRUQ7DQo+ICsJCXZhbCB8
PSBGSUVMRF9QUkVQKFBDSUVfQ09ORl9MSU5LMl9MQ1IyX0xJTktfU1BFRUQsDQo+IHBjaWUtPm1h
eF9saW5rX3NwZWVkKTsNCj4gKwkJd3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5iYXNlICsNCj4g
UENJRV9DT05GX0xJTksyX0NUTF9TVFMpOw0KPiArCX0NCj4gKw0KPiAgCS8qIFNldCBjbGFzcyBj
b2RlICovDQo+ICAJdmFsID0gcmVhZGxfcmVsYXhlZChwY2llLT5iYXNlICsgUENJRV9QQ0lfSURT
XzEpOw0KPiAgCXZhbCAmPSB+R0VOTUFTSygzMSwgOCk7DQo+IEBAIC0xMDA0LDkgKzEwMjksMjEg
QEAgc3RhdGljIHZvaWQgbXRrX3BjaWVfcG93ZXJfZG93bihzdHJ1Y3QNCj4gbXRrX2dlbjNfcGNp
ZSAqcGNpZSkNCj4gIAlyZXNldF9jb250cm9sX2J1bGtfYXNzZXJ0KHBjaWUtPnNvYy0+cGh5X3Jl
c2V0cy5udW1fcmVzZXRzLA0KPiBwY2llLT5waHlfcmVzZXRzKTsNCj4gIH0NCj4gIA0KPiArc3Rh
dGljIGludCBtdGtfcGNpZV9nZXRfY29udHJvbGxlcl9tYXhfbGlua19zcGVlZChzdHJ1Y3QNCj4g
bXRrX2dlbjNfcGNpZSAqcGNpZSkNCj4gK3sNCj4gKwl1MzIgdmFsOw0KPiArCWludCByZXQ7DQo+
ICsNCj4gKwl2YWwgPSByZWFkbF9yZWxheGVkKHBjaWUtPmJhc2UgKyBQQ0lFX0JBU0VfQ0ZHX1JF
Ryk7DQo+ICsJdmFsID0gRklFTERfR0VUKFBDSUVfQkFTRV9DRkdfU1BFRUQsIHZhbCk7DQo+ICsJ
cmV0ID0gZmxzKHZhbCk7DQo+ICsNCj4gKwlyZXR1cm4gcmV0ID4gMCA/IHJldCA6IC1FSU5WQUw7
DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgbXRrX3BjaWVfc2V0dXAoc3RydWN0IG10a19nZW4z
X3BjaWUgKnBjaWUpDQo+ICB7DQo+IC0JaW50IGVycjsNCj4gKwlpbnQgZXJyLCBtYXhfc3BlZWQ7
DQo+ICANCj4gIAllcnIgPSBtdGtfcGNpZV9wYXJzZV9wb3J0KHBjaWUpOw0KPiAgCWlmIChlcnIp
DQo+IEBAIC0xMDMxLDYgKzEwNjgsMjAgQEAgc3RhdGljIGludCBtdGtfcGNpZV9zZXR1cChzdHJ1
Y3QgbXRrX2dlbjNfcGNpZQ0KPiAqcGNpZSkNCj4gIAlpZiAoZXJyKQ0KPiAgCQlyZXR1cm4gZXJy
Ow0KPiAgDQo+ICsJZXJyID0gb2ZfcGNpX2dldF9tYXhfbGlua19zcGVlZChwY2llLT5kZXYtPm9m
X25vZGUpOw0KPiArCWlmIChlcnIgPiAwKSB7DQo+ICsJCS8qIEdldCB0aGUgbWF4aW11bSBzcGVl
ZCBzdXBwb3J0ZWQgYnkgdGhlIGNvbnRyb2xsZXIgKi8NCj4gKwkJbWF4X3NwZWVkID0NCj4gbXRr
X3BjaWVfZ2V0X2NvbnRyb2xsZXJfbWF4X2xpbmtfc3BlZWQocGNpZSk7DQo+ICsNCj4gKwkJLyog
U2V0IG1heF9saW5rX3NwZWVkIG9ubHkgaWYgdGhlIGNvbnRyb2xsZXIgc3VwcG9ydHMNCj4gaXQg
Ki8NCj4gKwkJaWYgKG1heF9zcGVlZCA+PSAwICYmIG1heF9zcGVlZCA8PSBlcnIpIHsNCj4gKwkJ
CXBjaWUtPm1heF9saW5rX3NwZWVkID0gZXJyOw0KDQpEbyB3ZSBuZWVkIHRvIHNldCBpdCB0byBt
YXhfc3BlZWQ/IFNpbmNlIHRoZSBoYXJkd2FyZSBvbmx5IHN1cHBvcnRzDQpzcGVlZHMgbG93ZXIg
dGhhbiBtYXhfc3BlZWQuDQoNClRoYW5rcy4NCg0KPiArCQkJZGV2X2RiZyhwY2llLT5kZXYsDQo+
ICsJCQkJIk1heCBjb250cm9sbGVyIGxpbmsgc3BlZWQgR2VuJWQsDQo+IG92ZXJyaWRlIHRvIEdl
biV1IiwNCj4gKwkJCQltYXhfc3BlZWQsIHBjaWUtPm1heF9saW5rX3NwZWVkKTsNCj4gKwkJfQ0K
PiArCX0NCj4gKw0KPiAgCS8qIFRyeSBsaW5rIHVwICovDQo+ICAJZXJyID0gbXRrX3BjaWVfc3Rh
cnR1cF9wb3J0KHBjaWUpOw0KPiAgCWlmIChlcnIpDQo=


Return-Path: <linux-pci+bounces-16407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B14BB9C3672
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 03:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358FF1F21E41
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 02:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845051F931;
	Mon, 11 Nov 2024 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airoha.com header.i=@airoha.com header.b="TXHWJdAz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="VX73gjkS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E617F7;
	Mon, 11 Nov 2024 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731291435; cv=fail; b=IemKLUnj88WpaNWLW/wad9K74ek1Q86M9o7Tpb4K+hoNpCPTQQPnkkL1al8ygvRTC3bKhHOu5gYk9f1yfFMoSeQ2m/tJ6YN0Yk+6bi9yDa5r3vDEjmvSnyu2Cl+dpiL4fIvPmDE8v2VRaVuH8gKI2KyGy3pQpccMnJnNP48GvSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731291435; c=relaxed/simple;
	bh=s0G6YLDDRDM1JTrl3lVPLreqkvppE1/U5fsQCg4NYgs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XMQWafd67cK63tGkLGoPzZqfHrAZGxQVwsxSXWOrPfA/iiWSGKpBRqUQUC3d3VtXUIA1H338Rf6BhSApIPKn07FCJS4+UEgG5RuSQBmn6OTbvP/VPq44U6KPLMS8tNu2k6nY0N2vlVxI+IpTOSqr6Z/1zqhEDovw5W8hkTO3ha4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com; spf=pass smtp.mailfrom=airoha.com; dkim=pass (1024-bit key) header.d=airoha.com header.i=@airoha.com header.b=TXHWJdAz; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=VX73gjkS; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airoha.com
X-UUID: 0bf132949fd311efbd192953cf12861f-20241111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=airoha.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=s0G6YLDDRDM1JTrl3lVPLreqkvppE1/U5fsQCg4NYgs=;
	b=TXHWJdAzxgBm+LwcAm9XcI3k9wmqqIiKu04F0B5qgX9QAfZDJPfYSV/ED+8IYMuWYZThJ+Ic3VlKq0V6Bmlj0IXQ7sXNhDoe9Ac+uinOAbk95aISaxaIdJWsIC6CCPObtCreMwHXVHzB2xdLyGOkvIQy4uUnoOzeeObGdj//YCU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:449e750c-1d80-4638-a89d-195e2d710c4d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:a36ddc06-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:-5,EDM:-3,IP:
	nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 0bf132949fd311efbd192953cf12861f-20241111
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <hui.ma@airoha.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1726715643; Mon, 11 Nov 2024 10:17:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Nov 2024 10:17:03 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Nov 2024 10:17:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHqmiUsI7ujCCpGEepQPzVkHjtrYmChKnSaO6kTW+um9BM5g31axprMlKRLOnfQSy1q/zLRM6UVPB8mRiPojsbfF96mySiw/YhCFb3em2JJPTl6tjE8QiHAaQ+xefeX1ltQbvSjrUjZqROk7TcYe0sUoA8mLlGOtggeTQnd5DlZ5pMiSvV4HdUmDIqYm4XYzRo0xUagiGkbR+gEduPdb4xHKJrVIUNlls5BrSGt9sigaBo0E5m4OupdNo8LLKDuhq7w4bX8XrJp2gIqlFr3kIbhE1HlVMVqYggMxO7tNNzbU6bFVoDFSQmtIrCTzYJ2Htv6kWeUdop7mQQFYlhKjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0G6YLDDRDM1JTrl3lVPLreqkvppE1/U5fsQCg4NYgs=;
 b=YVeLnL4n/jhDghComj0n11SlTCvTkejXSic6w8d2wCNns0OaMbkZKl5e7m12LlTSwG4YqMkgIH8XQZIE/N8bOcq1a45/fNi3sZlyCx3k/HwyfpdJViddEnbQJf0xarF8J+Ym6KfgibEAmzgOsJ6h/50iTF0+TalFDoDBYc3S5+chabRj4WF0Uen8RVNL9N0aYMhrqLm1qNXReoKdZn4t0K/lB9DXTmxgEtBci9yHlUVKG8RA4v09hY68o3sa6eDjGTXHMrT/NLdWJSUxqwZS3+HCNVCfAfSZ8VjJC7QdaCJd+LNCw5kObR2zYhRVS6LGbJ05ZJJ/ndkwXgs5e4u1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=airoha.com; dmarc=pass action=none header.from=airoha.com;
 dkim=pass header.d=airoha.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0G6YLDDRDM1JTrl3lVPLreqkvppE1/U5fsQCg4NYgs=;
 b=VX73gjkSPMhuBD7rZ9kW+5GAUhJd4Ow1+yAm8fIxID6xD/VUcZAjBy0cJVDaEklq4GW9ipzbAxLvyZp5HSmcx1QkwpXY3yVOF01vC614P3yq1NrvmtWW4qKjkgrrGZkb78L1yY3umWdLhqthe1Afdzr9PJVPQngBBY9Jjmm1scs=
Received: from SG2PR03MB6341.apcprd03.prod.outlook.com (2603:1096:4:178::8) by
 TYZPR03MB8727.apcprd03.prod.outlook.com (2603:1096:405:75::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.21; Mon, 11 Nov 2024 02:17:00 +0000
Received: from SG2PR03MB6341.apcprd03.prod.outlook.com
 ([fe80::619e:4ef8:147a:3554]) by SG2PR03MB6341.apcprd03.prod.outlook.com
 ([fe80::619e:4ef8:147a:3554%5]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 02:16:59 +0000
From: =?utf-8?B?SHVpIE1hICjpqazmhacp?= <Hui.Ma@airoha.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Ryder Lee
	<Ryder.Lee@mediatek.com>, =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?=
	<Jianjun.Wang@mediatek.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "nbd@nbd.name" <nbd@nbd.name>, "dd@embedd.com"
	<dd@embedd.com>, upstream <upstream@airoha.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2NCA0LzRdIFBDSTogbWVkaWF0ZWst?=
 =?utf-8?Q?gen3:_Add_Airoha_EN7581_support?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjQgNC80XSBQQ0k6IG1lZGlhdGVrLWdlbjM6IEFk?=
 =?utf-8?Q?d_Airoha_EN7581_support?=
Thread-Index: AQHbMV/yjTpzpkxs30uMvvSIs5ZH3rKslW/AgAD/vgCAAR7kAIACpmtw
Date: Mon, 11 Nov 2024 02:16:59 +0000
Message-ID: <SG2PR03MB634145B4F5B67834715EA869FF582@SG2PR03MB6341.apcprd03.prod.outlook.com>
References: <KL1PR03MB6350EF22DE289B293D34FD6FFF5D2@KL1PR03MB6350.apcprd03.prod.outlook.com>
 <20241108163338.GA1663274@bhelgaas> <Zy8uDDUWSkLVXa5G@lore-desk>
In-Reply-To: <Zy8uDDUWSkLVXa5G@lore-desk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=airoha.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6341:EE_|TYZPR03MB8727:EE_
x-ms-office365-filtering-correlation-id: 87e757dd-65a0-409b-7fa6-08dd01f6ec8e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Mi95MlJ3ZjdmOVQ5YU9kNWttSlVOd2FBUTRiS1lhQnpjcFhJRjN6Q0wxOVRP?=
 =?utf-8?B?UlI5TTNUQjJOMHJiWnNPMXhiQU55NUJUVmIvQnpKRGx3d0VidGpkS2lUcVB5?=
 =?utf-8?B?cU9Fc0M2QWR5elJaUmQ5UmplMnlqb3Z5K1VvazBpWFluR0g0MnhScVJocFND?=
 =?utf-8?B?VWp4ZE9CRjhEWSswV3ptc0ZrZ2NTaktXZmVDRzFxYWZhY0U1WmkyZTNSOWxC?=
 =?utf-8?B?U1RmVXc5bXRTbStBZEFQQkxJRFk2ZDBsaXU0MytNdUdnTzE4dFhYeVZjOEMx?=
 =?utf-8?B?Z2VkblhrRUsvMURid1EvdVFBdWZOcG9Kd1pnUlYzQk5CWFZ5TkFPY0tkeC9O?=
 =?utf-8?B?TXpwU2wxM1FkSDJFcHdHckEwMjRLNzEzRnBXUWNyMmZjclp3Tmx5aGRDTi9n?=
 =?utf-8?B?dC9ZdTFDYisxQ1FjK1BQanEzYzQ5UlhFK0ZHNUE2b0ZSZ3B5bGdaYWFyK05x?=
 =?utf-8?B?NUt4QWJqdE83dW1BWmcvbGoyMHBZNnI3enhJQWd3VEJxc1NsRjdaN0RGQUJE?=
 =?utf-8?B?RXdZcFZsbnBzVENGRk5PS2pMTndjRktyUFFzQkdiZWxlV2tXYXBNQkhFZ3lo?=
 =?utf-8?B?S1BYbWJHZ29RQ3RUV0pUb2p4YUs1REpvSU5jNkgvOFNzNTloTEk0blJJUlZ3?=
 =?utf-8?B?dDYwSDNHbTVYYlJOSFMvMExiQU4wQjZzLzRHaWQwbFBaMm9pdW9vbXMybDh1?=
 =?utf-8?B?N2lXNG13aUpaM0l3bzZIV1pHUlBlVmhTdmh6NlIwaEpmeGlvZGhkeW9NdUgz?=
 =?utf-8?B?REg0NTE2L2xaNmp1ZkdWcDg1Y1dNcDJ0aWJZaENrSTVpMm5xOE4xYmhPL3h2?=
 =?utf-8?B?aVFmSWxIYUNiVTRaQ25WTDlTOVAyNitUZlpUZFFDcEN6M0EwZ2h0djJVeU1D?=
 =?utf-8?B?VU5relQ5VmNnRlloSkhYblB3RytqdTZCRVc5VU1PcTVjdlFpaEY5S2lMQWVS?=
 =?utf-8?B?Vjk0dVBwcFYrZFZoRE1SMEU0bk5zWlZWUDN6U2Y5Nm1QeE8vTDBQelBxV25J?=
 =?utf-8?B?dmpOc1lMKytFdm5rTzNleFJNODR5V3NVeVZNamFKUlcwNHJmQVV1Q3Q2N0NZ?=
 =?utf-8?B?bFFyNEdzNTgxNVpZQlBOcXVFK1Z1Y2dtbGNTT3N6dElHNzcvcldzdzI2V0pX?=
 =?utf-8?B?eU84bFA3ZVEyMHYwZTJZYTFpbnZXV3JxNnY1c3ltcmI2TTBwaVJwb2YxQjgx?=
 =?utf-8?B?Qzk4K29PV1hCRGRzam5QbWFxUm54bllEa1RBRWtYZVcxRkV5T29lWENTbGVB?=
 =?utf-8?B?WE1mSXdsVTlxUjRpZk00dEcyTUh1aHRUbG81THNJTVJRcENRT1VwTmdxU0l5?=
 =?utf-8?B?dEx0ZnAwSUVTMFNlWnZYcjZRaXZ2bGJyK2lWd25GQ3Y3Tmo3OTQ3VExsM1J0?=
 =?utf-8?B?M3JBUG9ETC9LZHZidnpYYk1QbDBtYmVYN1JxeG1oSHA3dk5xTC9wb01qTjZK?=
 =?utf-8?B?TnJUUFpZT3F0TGlrNTdBN3FqZFNma29ENmhFeDhrZXVaeFVtNlNObWJPeWpF?=
 =?utf-8?B?My9pSm54YTB6RWNLdWxnK1BoZkorN1R1YzI2OVpvUXdBRlZ0aU1NblkrNzdM?=
 =?utf-8?B?RkUrSnVGTW9wVzVEUi9yc3hSUjRMT0JOVUVCWE1BMCtwY1JhREtMOXNQckUw?=
 =?utf-8?B?TDAxT0JjdDkzd2ZKQk1lU01KbTdXcmtIa0pGdCtuK2RyOGJXY1d1aGFKY0RN?=
 =?utf-8?B?c09XbGp5SlRwcFdNTHRGU3JsWmZLc3NuVmFHNE1LTDhSbXRqbHdrdlRBaXlu?=
 =?utf-8?B?VU1LMmMvOHF0eUlONG83b1hUaFRoaVo3cmsyQmZvcmdiS3czZ3Y1a2VyM0h0?=
 =?utf-8?B?ckt3c3I4Nmo3UjBuVisrZ2ROaVVubm55a0U1V2x6Sno1K0tMWkYyMGpnQ1RX?=
 =?utf-8?Q?Ub6w0Yz06geQq?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6341.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dS8rQzhPdzR2d2JEUzVJQWxvR2doa0lZZnBxRjQ3MFJVV0ZIZzcrRm9FMjht?=
 =?utf-8?B?VXpQN0I4bmtJUS9DQ2JKK3FjN2FOZWlVbkVVQ2ZFOGhpYmErdzZKWFJJU29O?=
 =?utf-8?B?NDhqWCt2OGR4a25qWTZPaU54TW5HUlkrL3JrQzQ5cFlvMnA3K0RJQ1BCSGlV?=
 =?utf-8?B?WWdNbkhCNWlnL0tEOHIxcitlN3FRWXYrOHhySExDMEhPVWNlcDk1QWIvVVRq?=
 =?utf-8?B?Sjc5TGpwZ1pNQVJQMVpBc0E4dnhyWDB6WnZzR0Nqb1ZEN0VnQlhNQVhvVm5i?=
 =?utf-8?B?d21TWTdteFkyZEl2d1d0WjNjOExzNjBGcjNOSUpDOXlmdUViM290RmtsYmVu?=
 =?utf-8?B?Q3dNbk9DWkJzUW4xVWFPM3lhUDV4Qlh2TFJVazF3TGdBMFJkc3B3Q0lSRjVn?=
 =?utf-8?B?dkNLcUtKbHdHY0ViaGpoTmFudUUycHMrVW5VanM1RlZuamM1NFRWYVNKbks0?=
 =?utf-8?B?NU5vT2syOHhDZHZ2dlVzT05RSy9temZkZWZxS0JBaEVDdldLVncvdmZ2clpI?=
 =?utf-8?B?MEZvNFJsOWRrTVI0dE5CdW13NHA3ekhkSmxkVWdjTHNKVHptM3Jhb0pxL0tC?=
 =?utf-8?B?anNFMUJwNTRQWE5NQVRwOGJrVVZDRU45RXdPQmJRLzlLdzduSWs3L0pmdFp4?=
 =?utf-8?B?NlF0bDJSbWlqMW5SdFY4SC9DWG9jVlZobW10NUR5QlhXMXVmL3NmQTFxNWpu?=
 =?utf-8?B?REVlbVgyeUhFTVI5MWhqWGpLM0lJYWNGNk11cTZRSzNDZjBrL3NIdHdCZ3Vl?=
 =?utf-8?B?b0t1ejVHUXB5UGRRQ1d5c0hqbHBEWmtoVzRsN2V0NUo1L3RXVm1jeSsyUVRO?=
 =?utf-8?B?a2FHS1Y4WVZ0QnkrR3pxVDkvOXVUTlhXZXBJZ1JaT3I1RmlUaVIreU41TEFH?=
 =?utf-8?B?OExsT3BTNU1hQW1GZ2FIdzY5L1hEYStEQlFTTTBjclBoTHA1dmsrZWl6dEM5?=
 =?utf-8?B?Uys2TmZYcUxTK2FJWTU0TUNqejBmdzVHa0ZFSjh0MFdLOEt5aDZoT3Bha0NM?=
 =?utf-8?B?S1NjL3FGdjMrb0piQS9qSSs5U01CTTQyNG9wajFzaDY3ZXRod0hjampaVkc0?=
 =?utf-8?B?aUo4YmNpZ1ZLOXBPWEpxMDVHbGFtbGd0WnZ4THQwdCtYc3Ezc0MwNlJIRnVB?=
 =?utf-8?B?UDBKMVp1T0ZqakwwNkRPZEZ4RnZhaU9udHdrOXdTcTdvQ0FxRXlpRW91N2gr?=
 =?utf-8?B?QVkxbkVwRXA2REMyR0lKRXE1LzJhRlhkVjhaOFFXZEtwekp3Zi9NTlNMNktx?=
 =?utf-8?B?ajRkNTBKT25HRTZsNFp0Q2hhemZ2NkZPV3pJL0xXbWE1TWlXempnYlZ0SktI?=
 =?utf-8?B?MU4yVTc4YmtQZ2RPQ2lzQW9WeXlFYVE1cFluZTVQZ2E2MFNDMmtMNThlOVhI?=
 =?utf-8?B?VUl5RjBLaktYbldLaHJqRlVUcEhJSGtMWmhUSUcrdkFNMStvWlN3VlVWTE1R?=
 =?utf-8?B?aTRiRWxlOGcyNC82M2loWjliak1Sb1FQeFFwRGphTDhCcmRURFhOWmZkalcx?=
 =?utf-8?B?VTRoWDNEOG1jNGxOamF2WG56N3JxeWhUbG5xcDdGZ1FNRWx2MGZ5eEdrZis5?=
 =?utf-8?B?b1M2dGY4V1FUOGs2cWJ4SjJMVW5JdVgzOTFwRk1BUDFpSTlqTjBiUjBVWWRm?=
 =?utf-8?B?NEN1Z3lDTHBFTmRhSi84TUs0b2ZZdCs0TUN0cWYvL0t5UGtXRlFTSUVrWFRa?=
 =?utf-8?B?OW9KMzZ2NjM4TFQzaHNMS2ZST0NtOGVvdWFHOENDMllqWDZRdytqNDliZnlY?=
 =?utf-8?B?b1RpMFhlSnBIMEg4STRUUjdxbHIrbzRsRTdJUEJZVVVOZ21CSGJPNXY2TXRZ?=
 =?utf-8?B?eGovOVVMRFdnR2gzUlVhNlpWUDMzdEQ4T09Nak5CZ2pMNFdhaERPbmRjVC9t?=
 =?utf-8?B?QXJnVjlaakJ1bTdXTGM2QWZEZ1Fsc3BMTFlXc3kxOU9zV081N0JweWtPdWE5?=
 =?utf-8?B?VG9hclFVWXJuTnRRaEFkRzFaNEVaUjdqaWZHVGU1U0F4SWcxSFMvQWVBZTNh?=
 =?utf-8?B?OE5lS2tJVnVFblZSZnMzSEJLZlhmdWdlWVQyWXdyOW5RczBqdjlGZDZqMkF5?=
 =?utf-8?B?dHVjd3FkYnhRZC92OFZ1c2RockNzd3NibmdoMi9Nblp6eDc1T1h1R0R4S3BK?=
 =?utf-8?Q?7C5Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6341.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e757dd-65a0-409b-7fa6-08dd01f6ec8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 02:16:59.8213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AN2beQF0qKBQXM7V0DjgHKXMAQVaefHTU2XPksYDcn/ttsq4qxR8WmDO9teSLNeyRLNubGjKNlLC0v33roTYtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8727
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.879700-8.000000
X-TMASE-MatchedRID: e4o27ty5DRa/+IV5X7qKmSa1MaKuob8PfjJOgArMOCZxMpe96EyhT5M5
	rPAxB6p1CNLuPteRDHedgOhK37CczxnsS71Oo/Hwh2VzUlo4HVPYP0VsOD0E/gzvg1/q1MH2ceJ
	q9ZcWb12p+po932P8Hg4Vbml1eRbDuN0AXBH/oPFzaTZqCdc3fJaFO9XLY12UvStYzicikmtGHn
	2ZgywDwADPqaCd3p2+9lM3/K31NE0iXL+V+zm5iZYsKSXWWrsHbd6rGhWOAwRstn3MIA3aF1WBE
	HEQr4pg6vRaGE0GC6r5VXhHYr1OPja5NNzGfDJlSEQN/D/3cG5zd7C7BtJobjhgoAzehG326yi0
	8F3h8/GHhCu0DQxicgJ+2GmvVjyvFOKk4UrUPgXdQ5ZOINfqbkEKKv3+tzX7fS3Xi1H8tPSysKt
	IPbDXL8HbBl2CavJnctAk+wls9eAUPKwcuWzcJKb8GfRpncAzELbqrOgWzyciFBkGC/mNIgoekt
	pGiVj3U5/Vz6VLZ7fs8dA+Nc3EOxgHZ8655DOP0gVVXNgaM0pZDL1gLmoa/PoA9r2LThYYKrauX
	d3MZDU980qe9xzB3A==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.879700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3974BDD5C24D3CE430E900F21D2C329F5E2FD5BB8F528DA3068F119A7C3AD2CD2000:8

PiBPbiBGcmksIE5vdiAwOCwgMjAyNCBhdCAwMToyMzozNUFNICswMDAwLCBIdWkgTWEgKOmprOaF
pykgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIE5vdiAwNywgMjAyNCBhdCAwNToyMTo0NVBNICswMTAw
LCBMb3JlbnpvIEJpYW5jb25pIHdyb3RlOg0KPiA+ID4gPiBPbiBOb3YgMDcsIEJqb3JuIEhlbGdh
YXMgd3JvdGU6DQo+ID4gPiA+ID4gT24gVGh1LCBOb3YgMDcsIDIwMjQgYXQgMDg6Mzk6NDNBTSAr
MDEwMCwgTG9yZW56byBCaWFuY29uaSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gT24gV2VkLCBOb3Yg
MDYsIDIwMjQgYXQgMTE6NDA6MjhQTSArMDEwMCwgTG9yZW56byBCaWFuY29uaSB3cm90ZToNCj4g
PiA+ID4gPiA+ID4gPiA+IE9uIFdlZCwgSnVsIDAzLCAyMDI0IGF0IDA2OjEyOjQ0UE0gKzAyMDAs
IExvcmVuem8gQmlhbmNvbmkgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiA+IEludHJvZHVjZSBz
dXBwb3J0IGZvciBBaXJvaGEgRU43NTgxIFBDSWUgY29udHJvbGxlciANCj4gPiA+ID4gPiA+ID4g
PiA+ID4gdG8NCj4gPiA+ID4gPiA+ID4gPiA+ID4gbWVkaWF0ZWstZ2VuMyBQQ0llIGNvbnRyb2xs
ZXIgZHJpdmVyLg0KPiA+ID4gPiA+ID4gPiA+ID4gPiAuLi4NCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gPiA+IElzIHRoaXMgd2hlcmUgUEVSU1QjIGlzIGFzc2VydGVkPyAgSWYgc28sIGEgY29t
bWVudCB0byANCj4gPiA+ID4gPiA+ID4gPiA+IHRoYXQgZWZmZWN0IHdvdWxkIGJlIGhlbHBmdWwu
ICBXaGVyZSBpcyBQRVJTVCMgZGVhc3NlcnRlZD8NCj4gPiA+ID4gPiA+ID4gPiA+IFdoZXJlIGFy
ZSB0aGUgcmVxdWlyZWQgZGVsYXlzIGJlZm9yZSBkZWFzc2VydCBkb25lPw0KPiA+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiA+IEkgY2FuIGFkZCBhIGNvbW1lbnQgaW4gZW43NTgxX3BjaV9l
bmFibGUoKSBkZXNjcmliaW5nIA0KPiA+ID4gPiA+ID4gPiA+IHRoZSBQRVJTVCBpc3N1ZSBmb3Ig
RU43NTgxLiBQbGVhc2Ugbm90ZSB3ZSBoYXZlIGEgMjUwbXMgDQo+ID4gPiA+ID4gPiA+ID4gZGVs
YXkgaW4NCj4gPiA+ID4gPiA+ID4gPiBlbjc1ODFfcGNpX2VuYWJsZSgpIGFmdGVyIGNvbmZpZ3Vy
aW5nIFJFR19QQ0lfQ09OVFJPTCByZWdpc3Rlci4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvZHJp
dmVycy9jbA0KPiA+ID4gPiA+ID4gPiA+IGsvY2wNCj4gPiA+ID4gPiA+ID4gPiBrLWVuNzUyMy5j
I0wzOTYNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IERvZXMgdGhhdCAyNTBtcyBkZWxh
eSBjb3JyZXNwb25kIHRvIGEgUENJZSBtYW5kYXRvcnkgDQo+ID4gPiA+ID4gPiA+IGRlbGF5LCBl
LmcuLCBzb21ldGhpbmcgbGlrZSBQQ0lFX1RfUFZQRVJMX01TPyAgSSB0aGluayBpdCANCj4gPiA+
ID4gPiA+ID4gd291bGQgYmUgbmljZSB0byBoYXZlIHRoZSByZXF1aXJlZCBQQ0kgZGVsYXlzIGlu
IHRoaXMgDQo+ID4gPiA+ID4gPiA+IGRyaXZlciBpZiBwb3NzaWJsZSBzbyBpdCdzIGVhc3kgdG8g
dmVyaWZ5IHRoYXQgdGhleSBhcmUgYWxsIGNvdmVyZWQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IElJUkMgSSBqdXN0IHVzZWQgdGhlIGRlbGF5IHZhbHVlIHVzZWQgaW4gdGhlIHZlbmRvciBz
ZGsuIEkgDQo+ID4gPiA+ID4gPiBkbyBub3QgaGF2ZSBhIHN0cm9uZyBvcGluaW9uIGFib3V0IGl0
IGJ1dCBJIGd1ZXNzIGlmIHdlIG1vdmUgDQo+ID4gPiA+ID4gPiBpdCBpbiB0aGUgcGNpZS1tZWRp
YXRlay1nZW4zIGRyaXZlciwgd2Ugd2lsbCBuZWVkIHRvIGFkZCBpdCANCj4gPiA+ID4gPiA+IGlu
IGVhY2ggZHJpdmVyIHdoZXJlIHRoaXMgY2xvY2sgaXMgdXNlZC4gV2hhdCBkbyB5b3UgdGhpbms/
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSBkb24ndCBrbm93IHdoYXQgdGhlIDI1MG1zIGRlbGF5
IGlzIGZvci4gIElmIGl0IGlzIGZvciBhIA0KPiA+ID4gPiA+IHJlcXVpcmVkIFBDSSBkZWxheSwg
d2Ugc2hvdWxkIHVzZSB0aGUgcmVsZXZhbnQgc3RhbmRhcmQgDQo+ID4gPiA+ID4gI2RlZmluZSBm
b3IgaXQsIGFuZCBpdCBzaG91bGQgYmUgaW4gdGhlIFBDSSBjb250cm9sbGVyIGRyaXZlci4gIA0K
PiA+ID4gPiA+IE90aGVyd2lzZSBpdCdzIGltcG9zc2libGUgdG8gdmVyaWZ5IHRoYXQgYWxsIHRo
ZSBkcml2ZXJzIGFyZSBkb2luZyB0aGUgY29ycmVjdCBkZWxheXMuDQo+ID4gPiA+IA0KPiA+ID4g
PiBhY2ssIGZpbmUgdG8gbWUuIERvIHlvdSBwcmVmZXIgdG8ga2VlcCAyNTBtcyBhZnRlcg0KPiA+
ID4gPiBjbGtfYnVsa19wcmVwYXJlX2VuYWJsZSgpIGluIG10a19wY2llX2VuNzU4MV9wb3dlcl91
cCgpIG9yIGp1c3QgdXNlIFBDSUVfVF9QVlBFUkxfTVMgKDEwMCk/DQo+ID4gPiA+IEkgY2FuIGNo
ZWNrIGlmIDEwMG1zIHdvcmtzIHByb3Blcmx5Lg0KPiA+ID4gDQo+ID4gPiBJdCdzIG5vdCBjbGVh
ciB0byBtZSB3aGVyZSB0aGUgcmVsZXZhbnQgZXZlbnRzIGFyZSBmb3IgdGhlc2UgY2hpcHMuDQo+
ID4gPiANCj4gPiA+IERvIHlvdSBoYXZlIGFjY2VzcyB0byB0aGUgUENJZSBDRU0gc3BlYz8gIFRo
ZSBkaWFncmFtIGluIHI2LjAsIHNlYyANCj4gPiA+IDIuMi4xLCBpcyBoZWxwZnVsLiAgSXQgc2hv
d3MgdGhlIHJlcXVpcmVkIHRpbWluZ3MgZm9yIFBvd2VyIA0KPiA+ID4gU3RhYmxlLCBSRUZDTEsg
U3RhYmxlLCBQRVJTVCMgZGVhc3NlcnQsIGV0Yy4NCj4gPiA+IA0KPiA+ID4gUGVyIHNlYyAyLjEx
LjIsIFBFUlNUIyBtdXN0IGJlIGFzc2VydGVkIGZvciBhdCBsZWFzdCAxMDB1cyANCj4gPiA+IChU
X1BFUlNUKSwgUEVSU1QjIG11c3QgYmUgYXNzZXJ0ZWQgZm9yIGF0IGxlYXN0IDEwMG1zIGFmdGVy
IFBvd2VyIA0KPiA+ID4gU3RhYmxlIChUX1BWUEVSTCksIGFuZCBQRVJTVCMgbXVzdCBiZSBhc3Nl
cnRlZCBmb3IgYXQgbGVhc3QgMTAwdXMgDQo+ID4gPiBhZnRlciBSRUZDTEsgU3RhYmxlLg0KPiA+
ID4gDQo+ID4gPiBJdCB3b3VsZCBiZSBoZWxwZnVsIGlmIHdlIGNvdWxkIHRlbGwgYnkgcmVhZGlu
ZyB0aGUgc291cmNlIHdoZXJlIA0KPiA+ID4gc29tZSBvZiB0aGVzZSBjcml0aWNhbCBldmVudHMg
aGFwcGVuLCBhbmQgdGhhdCB0aGUgcmVsZXZhbnQgZGVsYXlzIA0KPiA+ID4gYXJlIHRoZXJlLiAg
Rm9yIGV4YW1wbGUsIGlmIFBFUlNUIyBpcyBhc3NlcnRlZC9kZWFzc2VydGVkIGJ5IA0KPiA+ID4g
ImNsa19lbmFibGUoKSIgb3Igc2ltaWxhciwgaXQncyBub3QgYXQgYWxsIG9idmlvdXMgZnJvbSB0
aGUgY29kZSwgDQo+ID4gPiBzbyB3ZSBzaG91bGQgaGF2ZSBhIGNvbW1lbnQgdG8gdGhhdCBlZmZl
Y3QuDQo+ID4gDQo+ID4gPkkgcmV2aWV3ZWQgdGhlIHZlbmRvciBzZGsgYW5kIGl0IGp1c3QgZG8g
c29tZXRoaW5nIGxpa2UgaW4gY2xrX2VuYWJsZSgpOg0KPiA+ID4NCj4gPiA+CS4uLg0KPiA+ID4J
dmFsID0gcmVhZGwoMHg4OCk7DQo+ID4gPgl3cml0ZWwodmFsIHwgQklUKDE2KSB8IEJJVCgyOSkg
fCBCSVQoMjYpLCAweDg4KTsNCj4gPiA+CS8qd2FpdCBsaW5rIHVwKi8NCj4gPiA+CW1kZWxheSgx
MDAwKTsNCj4gPiA+CS4uLg0KPiA+ID4NCj4gPiA+QEh1aS5NYTogaXMgaXQgZmluZSB1c2UgbXNs
ZWVwKDEwMCkgKHNvIFBDSUVfVF9QVlBFUkxfTVMpIGluc3RlYWQgDQo+ID4gPm9mIG1zbGVlcCgx
MDAwKSAoc28gUENJRV9MSU5LX1JFVFJBSU5fVElNRU9VVF9NUyk/DQo+ID4NCj4gPiAJSSB0aGlu
ayBtc2xlZXAoMTAwMCkgd2lsbCBiZSBzYWZlciwgYmVjYXVzZSBzb21lIGRldmljZSB3b24ndA0K
PiA+IAlsaW5rIHVwIHdpdGggbXNsZWVwKDEwMCkuDQo+PiANCj4+IERvIHlvdSBoYXZlIGRldGFp
bHMgYWJvdXQgdGhpcz8gIEkgZ3Vlc3MgaXQgb25seSBodXJ0cyBtZWRpYXRlaywgYnV0IA0KPj4g
aW5jcmVhc2luZyB0aGUgbWluaW11bSB0aW1lIHRvIGJyaW5nIHVwIGEgUENJIGhpZXJhcmNoeSBi
eSBhbG1vc3QgYW4gDQo+PiBlbnRpcmUgc2Vjb25kIGlzIGEgcHJldHR5IGJpZyBkZWFsLg0KPj4g
DQo+PiBJZiB0aGlzIGRlbGF5IGNvcnJlc3BvbmRzIHRvIHRoZSByZXF1aXJlZCBUX1BWUEVSTCBk
ZWxheSBhbmQgMTAwbXMgDQo+PiBpc24ndCBlbm91Z2ggZm9yIHNvbWUgZW5kcG9pbnRzLCB0aG9z
ZSBlbmRwb2ludHMgc2hvdWxkIGZhaWwgd2l0aCBtYW55IA0KPj4gaG9zdCBjb250cm9sbGVycywg
bm90IGp1c3QgbWVkaWF0ZWssIHNvIEkgd291bGQgc3VzcGVjdCB0aGUgbWVkaWF0ZWsgDQo+PiBj
b250cm9sbGVyIG9yIGEgY2VydGFpbiBwbGF0Zm9ybSwgbm90IHRoZSBlbmRwb2ludCBpdHNlbGYu
DQo+PiANCj4+IElmIHRoaXMgY29ycmVzcG9uZHMgdG8gVF9QVlBFUkwgYW5kIG1lZGlhdGVrIG5l
ZWRzIGxvbmdlciwgSSB3b3VsZCANCj4+IGRvY3VtZW50IHRoYXQgYnkgdXNpbmcgIlBDSUVfVF9Q
VlBFUkxfTVMgKiAxMCIgYW5kIGFkZGluZyBhIGNvbW1lbnQgDQo+PiBhYm91dCB3aHkgKGFmZmVj
dGVkIHBsYXRmb3JtL2RldmljZSwgaGFyZHdhcmUgZXJyYXR1bSwgZXRjKS4NCj4+IA0KPj4gQm90
dG9tIGxpbmUsIEkgZG9uJ3QgcmVhbGx5IGNhcmUgd2hhdCB0aGUgdmFsdWUgaXMsIGJ1dCBJICp3
b3VsZCogbGlrZSANCj4+IHRvIGJlIGFibGUgdG8gcmVhZCBwY2llLW1lZGlhdGVrLWdlbjMuYyBh
bmQgc2VlIHRoZSBwb2ludCB3aGVyZSBQQ0kgDQo+PiBwb3dlciBpcyBzdGFibGUsIGEgZGVsYXkg
b2YgYXQgbGVhc3QgVF9QVlBFUkwsIGFuZCB3aGVyZSBQRVJTVCMgaXMgDQo+PiBkZWFzc2VydGVk
IGJlY2F1c2UgdGhhdCdzIHRoZSBtYWluIHRpbWluZyByZXF1aXJlbWVudCBvbiBzb2Z0d2FyZS4N
Cg0KPj5JIHJ1biBzb21lIHRlc3RlcyB1c2luZyAxMDBtcyBkZWxheSAoUENJRV9UX1BWUEVSTF9N
UykgYWZ0ZXINCj4+Y2xrX2J1bGtfcHJlcGFyZV9lbmFibGUoKSBpbiBtdGtfcGNpZV9lbjc1ODFf
cG93ZXJfdXAoKSBhbmQgaXQgd29ya3MgZmluZSBmb3IgbWUgKEkgdGVzdGVkIHdpdGggYSBNVDc5
MTUgV2lGaSBQQ0llIG5pYyBjb25uZWN0ZWQgdG8gdGhlIFBDSWUgc29jaykuDQo+Pk1vcmVvdmVy
LCB3ZSBhbHJlYWR5IHBvbGwgUENJRV9MSU5LX1NUQVRVU19SRUcgcmVnaXN0ZXIgdG8gY2hlY2sg
dGhlIGxpbmsgc3RhdHVzIGluIG10a19wY2llX3N0YXJ0dXBfcG9ydCgpLCByaWdodD8gSSBndWVz
cyB3ZSBjYW4gcHJvY2VlZCB3aXRoIDEwMG1zIGRlbGF5IGluIG10a19wY2llX2VuNzU4MV9wb3dl
cl91cCgpLg0KWWVzLg0KDQpIaSBMb3JlbnpvL0Jqb3Ju77yMDQoJQWZ0ZXIgb3VyIGludGVybmFs
IGRpc2N1c3Npb24gYW5kIHRlc3RzLCB3ZSBjb25maXJtZWQgdGhhdCBhIDEwMG1zIGRlbGF5IGlz
IGVub3VnaC4NCg0KDQoNClJlZ2FyZHMsDQpIdWkNCg0KPlJlZ2FyZHMsDQo+TG9yZW56bw0KDQo+
IA0KPiBCam9ybg0K


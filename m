Return-Path: <linux-pci+bounces-15921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352039BAEC9
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 09:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3EF1F22868
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 08:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6896EBA34;
	Mon,  4 Nov 2024 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZOGmp/9K";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="jXEljBv7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5A1ABEBF;
	Mon,  4 Nov 2024 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710629; cv=fail; b=hFXElvFY7HlqET8faCxYPkesRofDHJxzgZPtsLAmi/u6tT982QOGOEHszWFqtQnmDnCrZ2ImHSw0Lw14oGQFEWtdA+cvLWjen9xewTbmAsTHikKvSV0Ski4TnaUns7ZW8z4v/yvBkPqXiky1Mo71h8tkuVXZkyKRTIQRukL4GfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710629; c=relaxed/simple;
	bh=cnffao1UgU15Wyk+nKO2//Jnjb6lrfulgJleQXmjjxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MyfNNQA6YQuew9rM6inFU05N6i6WVbyJ3rFKFHPU1Js+TZIVa0TLic+xBbQ9HvnWGty3kTOjYcik/XZrgOuV+w+gjExp54AjOjsxp+eIySR+NeQRm8wE0bVduu926cduZ/YerkdiID7XVts1TV+UsWWHSk4uX6rQeIxWvmx07JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZOGmp/9K; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=jXEljBv7; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c01583c29a8a11efb88477ffae1fc7a5-20241104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=cnffao1UgU15Wyk+nKO2//Jnjb6lrfulgJleQXmjjxk=;
	b=ZOGmp/9KBkhjACggHif+rxtDVu5HSv8w1qJmLg07XXiSAZsFyOP4Rh+882WFgS2/xGeWkzhrzG2aOhS70gTxyChbU9Ein2lvaQMLtElp1UwnFm+WVljmTui+p0HDAanurpYMCk1ecuigkGqObpuVrt9UAjQYlyDPzmJdA6XherE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:abc5e5dd-c465-4912-b156-06949cb90ab5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:8beda648-ca13-40ea-8070-fa012edab362,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c01583c29a8a11efb88477ffae1fc7a5-20241104
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2111405180; Mon, 04 Nov 2024 16:56:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Nov 2024 16:56:56 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Nov 2024 16:56:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/DgdTgXGy/VlYejbOlCh75UtPNDIQ2v2/kP1VfDpUiuugNPp52b6PyJfTAR6T/t88CgtW4VsOIb5kuoB5U49/z2Mo/Ni7bnPiT0s7GVGuUBiP/Xcz9hzdPSFV0SeVEoIFvLw+eXsEwgWg6nL+zei39PwMrpw3p0Zw79OMPbtGB4pH5GW4/zuX57q84eSTY1YrU68uo4cUIPhB1eeGVYaFrxDi9WZu+it3bwqBFZ4U1yUL4vM4VZw4YI2bNNtYUklqhQHnrq6jGiVTXNW5m/cf8bIsI0SH1O+dl8Qf9pTYnjf/gn1PFi1A16fKve2Qhtkuozpm569OEqG2bD/hOqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnffao1UgU15Wyk+nKO2//Jnjb6lrfulgJleQXmjjxk=;
 b=yD6oYdRyxeKr7dthNYpOvMhSEDLkQlpNYbd378HUbfiZ/KFnS3QJu6+kFHtVPhEaVmtLPlw+DT53h+D39BOVkPEkgiJLwi5yFOcHSGzV2I162QKdQ7cc/2HLamXH7V+xMl118pXIwJ6obDj0B6s0PDgAm3noH8eVE4Ay9VLsWRgLkZgv8hgJN5nsV4U36f+OFn0Fujd/9j7Niv14FyrIUEE1FMziWNpASDObN7/W0A68MIrv+R31O/77iFn6Kz2AHqH6gATrx1jDJVD2rPETnd6Yn4cYoAwfswDxKfyVmtiRuOeipopbF+O2T6eFiU0Lhna69I5Oug3BWIGIq1jbJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnffao1UgU15Wyk+nKO2//Jnjb6lrfulgJleQXmjjxk=;
 b=jXEljBv7w3V2iPJai1issk6YtcV+eecjXDF0csLtME9aRSJXAdX24/c/zQOToXbZXdz+8jSxPKqAZLfG6HHd8aE8mwEOx/AQWmxg21Cu+exwuu4gIjlULy46T4u1xTrGAhVtIZs7wr0YE3HmADwqr/GScaSV+dNdV330SX4P9aU=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by KL1PR03MB7694.apcprd03.prod.outlook.com (2603:1096:820:e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 08:56:53 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:56:53 +0000
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
Subject: Re: [PATCH v3 2/2] PCI: mediatek-gen3: Add support for restricting
 link width
Thread-Topic: [PATCH v3 2/2] PCI: mediatek-gen3: Add support for restricting
 link width
Thread-Index: AQHbCaKzwdXptM4QE0ChAaJfH8YklrKnG7UA
Date: Mon, 4 Nov 2024 08:56:53 +0000
Message-ID: <9e56fbe0b1a388b4e0da20cca53e157f51288916.camel@mediatek.com>
References: <20240918081307.51264-1-angelogioacchino.delregno@collabora.com>
	 <20240918081307.51264-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240918081307.51264-3-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|KL1PR03MB7694:EE_
x-ms-office365-filtering-correlation-id: a7a9b8ae-4ce5-4fd1-f33e-08dcfcaea0c1
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eGNqSGNPcFV4QXRDVmJVcFJhalJVUWdxTEorT2t3ZGJTRTZVclZodzExai9n?=
 =?utf-8?B?K3I2c1VuWG1xWDZLSmNvaWd1V1pqc3V3QXFqanprMjVGQUJrRzgxb29tVkN2?=
 =?utf-8?B?T1V3elZNZ2p3NTBKTXVrc2NTdWs3aDlIYkRTenRkaU9JNk9RQTR0ekluYng5?=
 =?utf-8?B?NVhDSkRDaVdMOUpLY2dTNWFPUmgzK29WckZxY1pDVlpKMnZSTHNUOWFFZk84?=
 =?utf-8?B?UFB0bUlqREtBeUJNYU4zWlZOQ2FMelFIQkJ3VHB5aXprNFVsdTd5dkEvWExU?=
 =?utf-8?B?ZDl0czJzdy8wUXlNUUsvR2VacG5ENVJPempWTDZhdG9jd09Ld0dkQlNZNXhV?=
 =?utf-8?B?Q2FVeHBrSitFc3NYckRPRmw3dG9ndEhjdHRWYmFCdWNNMUZhSW1UbnByQ2tQ?=
 =?utf-8?B?VDdjbTA2K1pJdjBtYzFTNk92ZEo1VDd2cXJudzI2MGgxVTJKcTdpRTZPMGc5?=
 =?utf-8?B?cUxhRm41OWRycUowY0lTbytZUFN0Z2E3Qk9rLzFIMnd0M0crVEVNS1VoUnhM?=
 =?utf-8?B?dXRUemNQbE9ydGhDUXNHTkVCak5xcUU5a1VBMzVhUldjY21pVDlTbi81dnlj?=
 =?utf-8?B?UGdBdkhDUFBxdW5mNVc3c3lJbTdPK0pmVHdNMm9UYkRBdlc5LzRzSXFveU1s?=
 =?utf-8?B?UktsQ0ZsLytFakRwL2FDMXVtUjAzNTRhTnMxUFRJUjEra0JmYjR5UzBZNEdW?=
 =?utf-8?B?NnBQQ0dmSG9pQjZ4OHNNSWM1MllBUHgxVkF0WTEveThuVkEyTWx1MThSWUN5?=
 =?utf-8?B?blZPYlFxRGI1UFVzaG81aEdpZjg5a2ZveEJrREIvUFFIeThzcUZOVmRrV3h6?=
 =?utf-8?B?VUZJSk1iVngyZWxpY29pUS96b2JBTFNkTHRTNXRKenZmNTdiTE5zVWx4ZW9X?=
 =?utf-8?B?UElObE5vV1hkdXJOSUZ6SmIwV0pBUjA0MUswTW9ORzJ6TzdCUjZpUmZGNXVs?=
 =?utf-8?B?UTZIaTQ1R2dNUW9wdnd5VGx5dHhQckdhbE40ZU1xeE00cnhnUjBpTERJbGZF?=
 =?utf-8?B?L21OcjZGZ1FaS0NSSlNleWo5c3Y4R0xEM2FYZjVqdDJoYzJtcWNsay81YlQ1?=
 =?utf-8?B?SWVGTXE4T0hxYW5Fcmd6T3lqSVpqTTcvNS83RnRPcDMvREZlbXFvL3RHblNV?=
 =?utf-8?B?T2xnZkF6Zk5YRmI0RkYzZVpUbU05NGVRSzhzNzI2RTFLZEtYTzJsR0pGTkpr?=
 =?utf-8?B?d2xRLzlHYWp6UEE3ZVNkRVo5ZW9IZHVkWFlXV085L2JqazZWSTBsSUQ1dm1W?=
 =?utf-8?B?Tnprc01oM2F0RWUraDhSQlNHamIwS0tWd1pTU3ZXUnNhR2M0LzNRUk80TTYv?=
 =?utf-8?B?d1huYXlRYVZMUkI3TDdEbVlsOXJIWmpwdWk3elZUaktVTU9FZ1pyL3hFSGJp?=
 =?utf-8?B?azYzNnpHc3p5dm13QkdhaHplUWZocGhMQzFNTk1HeUJJSkVXR0xUZlBWYmpU?=
 =?utf-8?B?NWFtWWo0SjFob1BCRjdQK01sYmFncEN0UXBMWCtsM3hMUXAyNkE0Uy9QOUVq?=
 =?utf-8?B?NHVlNzFmSDY2Y2dzaGppMVArOTdZQUI4YVREdElrbFVPcVdtdmNxMkoyZWlT?=
 =?utf-8?B?MXhNZlBTRVJ2Vi9CZjVwa0Z4K041dkVHd1dPYnpvT1NHNHlVT05EUkx4ZEN6?=
 =?utf-8?B?Q3Z0QkRTbERRVVpnWG05UXV3OENqb0ZTdFdNKy9QVGdBUTY0VTRDNkJqWWRF?=
 =?utf-8?B?SnRZR0tFMGtDdTJiZHNHcEFwVFVvdXBrR2dpQzQxS3Yrc3dFYWljencwOVJ6?=
 =?utf-8?B?UTBaTmcxaCtZekI4WEkxWUM1a2U4SWRCWFZHdVdqNXVSOVRnYkh4MWV4V1V1?=
 =?utf-8?Q?BcF5rcGx58JNe1DCQAMXeVZGNw+/0NXlspHXc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGVhUlJCVFVuWDFMVFN6dHQ2cm1GS1ZNTlY2OXJVWVkrR2pFS3lLTitDSnRn?=
 =?utf-8?B?WGs0V29YMHNSbmRyMllGRkVScVcyenl3dU9lOWlseVhOVjl1dVJvaUNONlpw?=
 =?utf-8?B?TCtENSttdzc2dXJURXhOM2VwSWE4ZHZSN0ROYU9XTHpXRTNDcTZZRUc3a2F3?=
 =?utf-8?B?QmY0alF5ek5hdERXc09oZFM1R3FxeTRTOW4yRWxMQWJKYm9KWm5IcjhUMG96?=
 =?utf-8?B?eDRBNm5ja3ZreCttRGJOOS9wTnlPcm5ZcmVBWWd1dVZkTXd2b0hnazNCdlRR?=
 =?utf-8?B?MDFoSXRFamR3VWY1cWRzZlRRYmRHc1YrNkM0QzRHbkt5RWxpZDZHcmJNaTU1?=
 =?utf-8?B?d2E1b3ErMHhLS3NFbWZGZU1KZC9YZHYrSlRJb1V3QmZGcThSQzhPWGlJc1o4?=
 =?utf-8?B?UUlocHVNODNjdzcvM3UwRloyTXlXODQ4dm01UjdMNjVqNU1EeDFEcHNRT0VX?=
 =?utf-8?B?dFdsZXlrT3g5azVYQkVLdXBzbkVaLzc3ZVVnTjZjUlJhZnZFa3FidXlVY200?=
 =?utf-8?B?RGJ1OXl2Y1JFMkZwVWdmd0dOTFpsMXpEdTdFcWZ3aVZvUVl4WHdVNzRENzF4?=
 =?utf-8?B?L0c3SWFCejZITlF2RHNOVCsyeXNGa0dLQ3VyUFBUbFlaaTJaUjFBVTdRdkV3?=
 =?utf-8?B?WkJBT0Voa2g2eDZOWUQ1UTVqQ3JmbzljMjVxQ3NLQnFSQ2FmdzhHMDBNR3VZ?=
 =?utf-8?B?SDgvZDdsdzZVaTJDRWRKS2JLZ2EzcVJkOGxKbnZDTHl4Y3RNVURoYjdxUnNO?=
 =?utf-8?B?UDlIOEV3ZWprb3NvU0FVOTF0SFMrdXRrYXlWUHdqeFFDR3M5VklzY2VnTmJq?=
 =?utf-8?B?YTY0bTRSNlhEKzhwcmFteVpmVExUZVV0c1c4RHVhV08vbXBNQ1VqdERCOE9B?=
 =?utf-8?B?d3RTcHpwRGJETDJwTFNtdFR3ZG83eWlKNWt4dFpqOC9OcmNGNWNLaEkrcVo5?=
 =?utf-8?B?NGFTU0xCckJMOFlLQXlOMVB1N0hyY0VRdy91L0hoWVFIbEwwTVNXc1dTWUtx?=
 =?utf-8?B?R1A1YzljaUdHQ1E1dHVhWXFIWFJycnFnN3FtQXo3eTJFUXR1VWJuNzM3L0ln?=
 =?utf-8?B?VTJmQVltbTdzVTl3K0c0M0duY09FeTRjZEgwbzB2SUlqTGZ6R1dtaFF4VG5N?=
 =?utf-8?B?Tm9FUjFYSjdaVEc3Nk9WcWNZNkFCdTRnYTVMVlppMldwUzdkNUdqaUVhbzFs?=
 =?utf-8?B?RXZsR2p0bnU2Z1pPc1ZJTWtMQUd1UlhERGc4UTdWVERYUTdtSlBVVng3U3pS?=
 =?utf-8?B?T1JzRXNKVSs1NHlCelFkVnhHMW1Za1pHemN3Y0dXcHZCZW5MSUFoVTBEYzND?=
 =?utf-8?B?ZXpOZElJTGVYUVVickRoNUx4ZmJJOHV4QW5xYWhnUW9xRmJhQ20zaVE1WGh1?=
 =?utf-8?B?Y1VtSFBqV0plblRzYjExMEZnNVZ5RmgxNW5Md1dhWU9KdnFtODJOV0JxNllL?=
 =?utf-8?B?VC84TDlBZzl6WkkyNU0vUmc3MVhMZ3F3L3IzaHRHWU94dnFiUU5tK2ZJemF0?=
 =?utf-8?B?Z0c2UXNrcHU0am4vbEhNVjFJdkV0YXZPbnRGOGdqNjF0YXBXZGJhQmxjUUFU?=
 =?utf-8?B?N3pVRWsxOEJOZGVNSWptMVBDOHMzdC9kZ080WFUyTDFtQkpkaWJEd2FkNUJn?=
 =?utf-8?B?M0dzSzFDd3JTTUVzaVdkUldUK2RwRDRrR2lKOEh2RTVRK1VsZThnTHk2TmVz?=
 =?utf-8?B?TGNsVlhTWmE0QVo3V2dEQ1pCeVNYOTBpOTBsYk54bWEyeElqQVdqZWptaDlJ?=
 =?utf-8?B?M1hqZTNHcjFjK1NrUWJid3JoeThSa3ZRUmhFamFiQ3NMZTRYT0x4U1hvak5K?=
 =?utf-8?B?bzN4cVA4QzlhRG52VXlWUjRrdXVBL2VOUjQ1cHJUeEZ1Y2JPVWp2RWgzbDhs?=
 =?utf-8?B?WHRXVVZFNjdBWXN0a1kxQmNKMnpQZFJwYUFwUzdlUDBtVzNZRkVCdzQrT1Fw?=
 =?utf-8?B?NkF5eUw0YzNqUGtScUZaN1N0a0VuYlIyUkJPZTE5amwyYXJrY0xkZDZmRk1s?=
 =?utf-8?B?aWQxQ2IxWEJka1E2MnR5N3NnQk1hN1RNMm9DUHhGeDRkaHVHTjZHK0NIKzBh?=
 =?utf-8?B?SCtka0syaHh2RHA5MXlYczRVeEVMcW4wVXdRRlo2MVhQU1l4cy9iU1NLWEhG?=
 =?utf-8?B?SHBRbkhIZGRiSlBzT3lBcWkySUFkcGxRemxya2ZkTDFZZjd1UGt4Y2FoeGhF?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFDE30808339C640A32F5F0D6C9AB08A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a9b8ae-4ce5-4fd1-f33e-08dcfcaea0c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 08:56:53.1125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6GgAOyY14/CFFuOpLBjhUBcb0ffBulnAgcHhkZ+VFU4mUtoElJabAqjaqe/szsK6aB4LIVhW6g3kxMmuLk2MtAt1WuKJY/VNprMLbumSgbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7694
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.383200-8.000000
X-TMASE-MatchedRID: 0aps3uOmWi7UL3YCMmnG4uYAh37ZsBDCQV6BZJ9WeFayrCkM9r1bWskU
	hKWc+gwPwQTqbLJ40jtU/qdak2do+bvaJG+XDhc2t1AhvyEKdj754F/2i/Dwjan5EKVhpwLGaa2
	6QlZ2KmuVMlcqqHWd7e0aF+/fOisWb3FRBHgV1mCHZXNSWjgdU+DkiVuoRhM78Ule2AXgYUvejM
	lFftvg2UsETgg57cdgd4ligS539sZgL7CyZrbL054CIKY/Hg3AwWulRtvvYxTUHQeTVDUrItRnE
	QCUU+jz9xS3mVzWUuAojN1lLei7RWSSPDvJIpJBo5HWQCN1SHexRetwN3ZrLdxNsDtjuYkTBq5X
	KGVK8BaVesHHH0ZBHAiUchQNDWmRg1ZkSC9ZIOaWUATGEo8ZTlZpsTgWmBmFE440GA1tXyvUoWT
	7XIVDwvZxKIJv87S0
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.383200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0CFE20E08FCD22A14FECD61DD5AC947C0820E292DA1B2F089D37C971C44EE4222000:8

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHlvdXIgcGF0Y2guDQoNCk9uIFdlZCwgMjAyNC0wOS0x
OCBhdCAxMDoxMyArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6DQo+IEFk
ZCBzdXBwb3J0IGZvciByZXN0cmljdGluZyB0aGUgcG9ydCdzIGxpbmsgd2lkdGggYnkgc3BlY2lm
eWluZw0KPiB0aGUgbnVtLWxhbmVzIGRldmljZXRyZWUgcHJvcGVydHkgaW4gdGhlIFBDSWUgbm9k
ZS4NCj4gDQo+IFRoZSBzZXR0aW5nIGlzIGRvbmUgaW4gdGhlIEdFTl9TRVRUSU5HUyByZWdpc3Rl
ciAoaW4gdGhlIGRyaXZlcg0KPiBuYW1lZCBhcyBQQ0lFX1NFVFRJTkdfUkVHKSwgd2hlcmUgZWFj
aCBzZXQgYml0IGluIFsxMTo4XSBhY3RpdmF0ZXMNCj4gYSBzZXQgb2YgbGFuZXMgKGZyb20gYml0
cyAxMSB0byA4IHJlc3BlY3RpdmVseSwgeDE2L3g4L3g0L3gyKS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxy
ZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
ZS1tZWRpYXRlay1nZW4zLmMgfCAyMA0KPiArKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+IGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiBpbmRleCA4ZDRiMDQ1NjMzZGEuLjhkZDJlNTEz
NWIwMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVr
LWdlbjMuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2Vu
My5jDQo+IEBAIC0zMiw2ICszMiw3IEBADQo+ICAjZGVmaW5lIFBDSUVfQkFTRV9DRkdfU1BFRUQJ
CUdFTk1BU0soMTUsIDgpDQo+ICANCj4gICNkZWZpbmUgUENJRV9TRVRUSU5HX1JFRwkJMHg4MA0K
PiArI2RlZmluZSBQQ0lFX1NFVFRJTkdfTElOS19XSURUSAkJR0VOTUFTSygxMSwgOCkNCj4gICNk
ZWZpbmUgUENJRV9TRVRUSU5HX0dFTl9TVVBQT1JUCUdFTk1BU0soMTQsIDEyKQ0KPiAgI2RlZmlu
ZSBQQ0lFX1BDSV9JRFNfMQkJCTB4OWMNCj4gICNkZWZpbmUgUENJX0NMQVNTKGNsYXNzKQkJKGNs
YXNzIDw8IDgpDQo+IEBAIC0xNjgsNiArMTY5LDcgQEAgc3RydWN0IG10a19tc2lfc2V0IHsNCj4g
ICAqIEBjbGtzOiBQQ0llIGNsb2Nrcw0KPiAgICogQG51bV9jbGtzOiBQQ0llIGNsb2NrcyBjb3Vu
dCBmb3IgdGhpcyBwb3J0DQo+ICAgKiBAbWF4X2xpbmtfc3BlZWQ6IE1heGltdW0gbGluayBzcGVl
ZCAoUENJZSBHZW4pIGZvciB0aGlzIHBvcnQNCj4gKyAqIEBudW1fbGFuZXM6IE51bWJlciBvZiBQ
Q0llIGxhbmVzIGZvciB0aGlzIHBvcnQNCj4gICAqIEBpcnE6IFBDSWUgY29udHJvbGxlciBpbnRl
cnJ1cHQgbnVtYmVyDQo+ICAgKiBAc2F2ZWRfaXJxX3N0YXRlOiBJUlEgZW5hYmxlIHN0YXRlIHNh
dmVkIGF0IHN1c3BlbmQgdGltZQ0KPiAgICogQGlycV9sb2NrOiBsb2NrIHByb3RlY3RpbmcgSVJR
IHJlZ2lzdGVyIGFjY2Vzcw0KPiBAQCAtMTg5LDYgKzE5MSw3IEBAIHN0cnVjdCBtdGtfZ2VuM19w
Y2llIHsNCj4gIAlzdHJ1Y3QgY2xrX2J1bGtfZGF0YSAqY2xrczsNCj4gIAlpbnQgbnVtX2Nsa3M7
DQo+ICAJdTggbWF4X2xpbmtfc3BlZWQ7DQo+ICsJdTggbnVtX2xhbmVzOw0KPiAgDQo+ICAJaW50
IGlycTsNCj4gIAl1MzIgc2F2ZWRfaXJxX3N0YXRlOw0KPiBAQCAtNDAxLDYgKzQwNCwxNCBAQCBz
dGF0aWMgaW50IG10a19wY2llX3N0YXJ0dXBfcG9ydChzdHJ1Y3QNCj4gbXRrX2dlbjNfcGNpZSAq
cGNpZSkNCj4gIAkJCXZhbCB8PSBGSUVMRF9QUkVQKFBDSUVfU0VUVElOR19HRU5fU1VQUE9SVCwN
Cj4gIAkJCQkJICBHRU5NQVNLKHBjaWUtPm1heF9saW5rX3NwZWVkDQo+IC0gMiwgMCkpOw0KPiAg
CX0NCj4gKwlpZiAocGNpZS0+bnVtX2xhbmVzKSB7DQo+ICsJCXZhbCAmPSB+UENJRV9TRVRUSU5H
X0xJTktfV0lEVEg7DQo+ICsNCj4gKwkJLyogWmVybyBtZWFucyBvbmUgbGFuZSwgZWFjaCBiaXQg
YWN0aXZhdGVzIHgyL3g0L3g4L3gxNg0KPiAqLw0KPiArCQlpZiAocGNpZS0+bnVtX2xhbmVzID4g
MSkNCj4gKwkJCXZhbCB8PSBGSUVMRF9QUkVQKFBDSUVfU0VUVElOR19MSU5LX1dJRFRILA0KPiAr
CQkJCQkgIEdFTk1BU0socGNpZS0+bnVtX2xhbmVzID4+IDEsDQo+IDApKTsNCg0KSXQgc2hvdWxk
IGJlIEdFTk1BU0soZmxzKHBjaWUtPm51bV9sYW5lcykgLSAyLCAwKS4NCg0KVGhhbmtzLg0KDQo+
ICsJfTsNCj4gIAl3cml0ZWxfcmVsYXhlZCh2YWwsIHBjaWUtPmJhc2UgKyBQQ0lFX1NFVFRJTkdf
UkVHKTsNCj4gIA0KPiAgCS8qIFNldCBMaW5rIENvbnRyb2wgMiAoTE5LQ1RMMikgc3BlZWQgcmVz
dHJpY3Rpb24sIGlmIGFueSAqLw0KPiBAQCAtODM4LDYgKzg0OSw3IEBAIHN0YXRpYyBpbnQgbXRr
X3BjaWVfcGFyc2VfcG9ydChzdHJ1Y3QNCj4gbXRrX2dlbjNfcGNpZSAqcGNpZSkNCj4gIAlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSBwY2llLT5kZXY7DQo+ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOw0KPiAgCXN0cnVjdCByZXNvdXJjZSAqcmVn
czsNCj4gKwl1MzIgbnVtX2xhbmVzOw0KPiAgDQo+ICAJcmVncyA9IHBsYXRmb3JtX2dldF9yZXNv
dXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJDRV9NRU0sDQo+ICJwY2llLW1hYyIpOw0KPiAgCWlm
ICghcmVncykNCj4gQEAgLTg4Myw2ICs4OTUsMTQgQEAgc3RhdGljIGludCBtdGtfcGNpZV9wYXJz
ZV9wb3J0KHN0cnVjdA0KPiBtdGtfZ2VuM19wY2llICpwY2llKQ0KPiAgCQlyZXR1cm4gcGNpZS0+
bnVtX2Nsa3M7DQo+ICAJfQ0KPiAgDQo+ICsJcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzIoZGV2
LT5vZl9ub2RlLCAibnVtLWxhbmVzIiwNCj4gJm51bV9sYW5lcyk7DQo+ICsJaWYgKHJldCA9PSAw
KSB7DQo+ICsJCWlmIChudW1fbGFuZXMgPT0gMCB8fCBudW1fbGFuZXMgPiAxNiB8fCAobnVtX2xh
bmVzICE9IDENCj4gJiYgbnVtX2xhbmVzICUgMikpDQo+ICsJCQlkZXZfd2FybihkZXYsICJJbnZh
bGlkIG51bS1sYW5lcywgdXNpbmcNCj4gY29udHJvbGxlciBkZWZhdWx0c1xuIik7DQo+ICsJCWVs
c2UNCj4gKwkJCXBjaWUtPm51bV9sYW5lcyA9IG51bV9sYW5lczsNCj4gKwl9DQo+ICsNCj4gIAly
ZXR1cm4gMDsNCj4gIH0NCj4gIA0K


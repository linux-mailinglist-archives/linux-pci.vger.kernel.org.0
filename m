Return-Path: <linux-pci+bounces-4290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A85186D9E1
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 03:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2901C221D7
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 02:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D0B37705;
	Fri,  1 Mar 2024 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nX7EzTWE";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="LW/KJgQ7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AFF4204C;
	Fri,  1 Mar 2024 02:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709261354; cv=fail; b=aFfdpD4uACEufEhhpWsz0ndDgRjr8VDiE7JJE90UuxGRE74B1iAy3nOiW87/Ue/OS8X88ezO/nmlJFZI3bkyHdeakULQgjo0oRFggcycdANq50V256ESsw4tkwgniUA9WSixObTW5A8BM7qLBpUnLbO6xKOJXyn/JZaLOio1Kz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709261354; c=relaxed/simple;
	bh=4Dm+xiOAeCdHTix7lHbtaN8+wvs1/m5JpDQzKa+bWZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YMVm6NhbkSSj+x37V9uaYZDI/IaRraH05+XdW5AHqOTrOXMGHKHuQWoGlBIkYV5d+8iN7ktv+XK4AiszR/wf1s5SZAkDtZ+5yR5iKr/yTzv3VjYYKJd8H3Vgp60tUSgAgIiMtTQT9mtpMikdSMUBx5G0yaoymjHRF0pkIT1awMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nX7EzTWE; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=LW/KJgQ7; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 42014fded77611ee935d6952f98a51a9-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4Dm+xiOAeCdHTix7lHbtaN8+wvs1/m5JpDQzKa+bWZI=;
	b=nX7EzTWEdrqYvELEiQGqHtIaynKBJDV3EJLHT4+y028q4qmnvQ027hsi8uo9RJWKbZqqP0B1VR+axURTxEWNWjPtZbWDip6XoGRFE7rFVfd0mzsxPQdKOrcWZIVyWkay0DSBHrz2LUQR2vOuw9f/9Y271IZmSQKi7wFIuoiWuls=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:20793e7f-86b6-4797-90b1-53816b2d14b3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:c5927a84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 42014fded77611ee935d6952f98a51a9-20240301
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 68013820; Fri, 01 Mar 2024 10:49:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Mar 2024 10:48:59 +0800
Received: from SG2PR03CU006.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Mar 2024 10:48:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3SOUBPprqZ+RMILMpzFIuJYgOJjsaiZWHQ664Uu3L7A72wMcmb64YKxa4JBjlt2b72N6CD+IgFiHUZBdDG1IjA/jSQ416vl2gIGJDx+xOdfwuwqPQ/uErLxJxB9UlJ3M110h1FiGGqnZaqNpOS1dY8LzYpYVTtaXQdkuuwGeFI5iNHx7FQHH67odThId8j2fa9fUQIyu1vl4Ja6M83ArAQmlINy+xwzp1WNkc8bG3z/D3gMP5/a0RFpoHb7xEn08GkqFwFs3lbod0PFmyBgI9m8eo+1FTBWNcINca4/HJUw0hFYp0BoRSIwlXNpoBuIHMUNgn40rtsd4YD/akb8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Dm+xiOAeCdHTix7lHbtaN8+wvs1/m5JpDQzKa+bWZI=;
 b=Jn0pxoNZuDalSsYNpJ6Z8WUnQurxZxeS0OzUMCTDu6GQBQDG0JQ42xrfWorBuL30zZhe8xCBqXKCu2Gim8OvOIFnm1dFY5iG5Qofr2Sg1qeeDXs0V/da89ZFsfp33Sia+Uy/qfreDLGY9qffwla6IHATAt0QXPmuxrWw66So/0T57mzhM/A5YBXrPg4YgXUFGU+vvtXGJOBZmBJVRfv39F+HXTr8XvhPXEuT1cjJ+KJCgM5u7UlyS+G355VGBRk+il+tsTvOSwWMLHBjhjAjJva1rbC3v2Nl22Sz+O6lOXuhA2FGRu94eFLXqtlyOwHQAzKpzZnS9vwv3i6TGOVoBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Dm+xiOAeCdHTix7lHbtaN8+wvs1/m5JpDQzKa+bWZI=;
 b=LW/KJgQ7TidYugMKUXe2abrT60RMWgV6meNPA39+DTH5IuXkUoX5IjYIeehZLXw3yvlY52fHZZH1BugzRULn1ovSeytDdqJMQ70feV09Js3ID1qeu6GtODFrEHNeLl3KJVIJ1bVFQ17+d4gEnqgk87rTpgLSCM+vrmf+qTjYnkE=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by SEZPR03MB7246.apcprd03.prod.outlook.com (2603:1096:101:a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 02:48:56 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::22dd:6695:c2ad:c4bf]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::22dd:6695:c2ad:c4bf%7]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 02:48:56 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, Ryder Lee
	<Ryder.Lee@mediatek.com>, "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Assert MAC reset only if PHY reset
 also present
Thread-Topic: [PATCH v2] PCI: mediatek-gen3: Assert MAC reset only if PHY
 reset also present
Thread-Index: AQHaavEyOFiHWdSs9EW2P5MBW1O/vrEiMBwA
Date: Fri, 1 Mar 2024 02:48:55 +0000
Message-ID: <30824df32636dec25b9a5972b1ee8de76b295feb.camel@mediatek.com>
References: <20240229092449.580971-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240229092449.580971-1-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|SEZPR03MB7246:EE_
x-ms-office365-filtering-correlation-id: 3443112a-bb28-49f5-924f-08dc399a234b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLuASAmHltcG/g6USJMPb7Hc9FNF0QeT3k9LAWlG3mXC5UDd7DBb4SdZnTkDDIihBrT20bF8dLOuIfHpwtmDlVzZ7vf0KLhLfRFrQSCDwsZeiMXYy/2rZVna9nIrz9KuoEZbtzChpwoIAg8EIz3GPkCO3owiGv6Gywj0yY4GPh75YiKDVVROkndO7U46mIRSb7E+9NbKNBOVMFv9uBZjdNslFglkYTWWvv3kGjgMAuT907V5vnnQE4oaAhIq1h6cC5EdXgpykIKAof0ZVEkVPxCynFSZcMgV9FwhKv+fQUZ1wP7xXq8gJoGY4zcHHwBSFpTE/+QO9fZNCs3zzCP3G0//3JX/95W7VYtxSLuTSvQ5flPjNw7oaXJK5ENSG7oZ7OCeHXVT+q3ED8l9WeOTnJftW/DbNH0VXop72uhxBqqfF1Sskox9drFPdkIKipEJ21k3QEPQspd9rDsm/AQNOQc+CwsqwxsU2PHvY9qj8uYMfJdD8ayut/616L9XeU3xXJO30V9gR6Jbbj6EBIgH9KCAaJF+qJXg9q0Y/ZiPkxBqdrBEbSJlcyMqZWMkWNRWNZKSEEP5FumVairK4Y1SxsCQTr3JZq96sLWgiu48ElsDuPbKXFE3K975ts+M0OwassKWF5LemA1QZfInxNpVqz1vsgn5pASmJFpdHAXNBCaislldzx5LfH4a1LZVI4QAASbDKFKo+Xqw32O/Tn3Hz0VVd9URgdz83b8cwz0YM3I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1o2Q2ZYdW9rYnpqZG9MeDJTNjdtMmg0SVNsRFFTTitPdHJ4SDhXY2tvYjZj?=
 =?utf-8?B?bnlFS293ampIZEpNbSsvMmorSXhyQUxkRFNGeDdIb0lTSC90bG02RmZ1ZW5I?=
 =?utf-8?B?d01EbkFON1gyayttb2Nzd0tJRjI4bk5zOGJBOVVRRUg0aWEvTHB4bmpVYkpZ?=
 =?utf-8?B?OU1HUHpEd2daM2JyUzV5aDdpcG9KSE40NUhHTUViTDRFYlRMUnkrRk9ndWxE?=
 =?utf-8?B?N0Y0MCtvdEF0K1dyT3RSWFlEeVJNalVLQm5MT1N6dlA1T0M5RHFPcGZGcG03?=
 =?utf-8?B?a1BHSUdsZ0Y0cDFqRFR5NzZpTWd4T2MxVG9iS3JVa3pQN1lJRk1aZFFDeEJW?=
 =?utf-8?B?UndmdnVpRzZTMmZXZWpPTHE4d3B0RVhLQ1dtSDlXWWVJbytRVFFsY2JSMDJk?=
 =?utf-8?B?dExMaFFKSk16RVhyQ29SU2NSRU1hOVJIejE1S0JLRjdoVkFrTW0xZjBBZWFO?=
 =?utf-8?B?UHhCdkhjQ2h0UEI3RjFQc2orOXlXUWJVL1F3SHF6NFlCYTR4TkU2OWN4SERV?=
 =?utf-8?B?V3JRVWMvUW1BcU0zRi80by9EQWE4Q1BUNUtMZnROcHlublZ1WU5MRWFBV24x?=
 =?utf-8?B?RjE3UWlCR0IrVmR2dGZTU3JzcEM2YlRRVEdzMWUyOTdFRWJZMzhqYnFwcWxO?=
 =?utf-8?B?b1pqSitLWlA5YWw4SUw0Q2ZtQTRnV0Q5bzhQQU9xeldMV0VRUUhVTEpGdlNB?=
 =?utf-8?B?OVhnVnlkYzJNOCtCbm1LZUJYdWZRcGFpVzZoZGZ1K0E0MUVLOEIxU3pJZ256?=
 =?utf-8?B?YmhoOTBPT1FmazhSRTRjY1JqemhVa09oYW0zSHhWQ2hlU0pHd0hFajFPUUR4?=
 =?utf-8?B?NVlMWDh4WkVmY2hxQUJMbUdhcjBEYmVLc0xlcnJweFN1SzNUbkd1aGNQS0dj?=
 =?utf-8?B?NTlQTUhsdDRhc1VNVXI2TzBJMzZFc1J1a05oZitSUmpLcDk5MTlneU5EZktF?=
 =?utf-8?B?OVFCOWdTM0tTWTVaNWZhWnNGUVIwclIvdjY0S2RaclVMbzZtcFRlZk9CVjhW?=
 =?utf-8?B?ME9xOXFKRTB0djlsdm5mOTZudXVROXljUVBTNXZlc3ZpdlRLTDRDaWJMdjNN?=
 =?utf-8?B?dXFzNEJFTjNrbkcvMXZ3QjNxbkwzeW5UWjd6cXV6MTJUT3dMZlNmSTZDM1Bm?=
 =?utf-8?B?QXdXcUVnNldDOVl6Y0ZJSTJCQUN1MFhhRWprRGkxOVZXVExJUmphWE5xU3hu?=
 =?utf-8?B?bU16bHRrQWs0ZjhBdy9WZzlJOVdERlN2SThtQitHY2JvWHQ3YVRZQWd5dGl4?=
 =?utf-8?B?VUR4NUNqenRNWURSQkVnWXY4U0ZnbzB1NlNtSEJYcWpNR3dDNW1ZTXhocVdN?=
 =?utf-8?B?YlJkYmhYeTRHcThEL2FqQmZSOUQ2d3M5dEYzQXZEUXE4ZXlocFlmNncrOEIv?=
 =?utf-8?B?dExEUDZ3dmxxcWUzWUgrNVJPcFNBTmFXTFBEMkl6YkxhcTJSQWpvRFdZa24x?=
 =?utf-8?B?NW82STFqd2ZGOS95elArVHVIWGtZMDRqSzVRak1SSU4rS0phU2czMDNGNnJK?=
 =?utf-8?B?REVMcjlldzZRQUxTSjZMaXBiUGZIcC9pYnhMSWp4TGlUV0pYQTkxMkhRMURY?=
 =?utf-8?B?OGlBUlIxTGI1MUtDcEowRHAwcklTTVRBUi9wZXJmZG9FY3dGQjFHVW5QMllk?=
 =?utf-8?B?TmtJRTNXWG5VRExONVdBR3R1SE0zRzF3TWVib2llcUJ4bVVId3NrVDg5S1hu?=
 =?utf-8?B?SklIQ2x3TWdmbmtMM2tWaGp5aCtTYjBrbjNlWjJLRWVodzFwS2ZiWVRpKzBV?=
 =?utf-8?B?QXZkRUF5WEtsakxoR3dYZTNPUmcvMDkyNlpZSnJGNzRQaXBJOWZxejQ1SitM?=
 =?utf-8?B?K1creWQ5K2h5WlRXbnB2K3QwSEJsWWhDUHBSbEI2dTV0UTVDWXpHekQyM203?=
 =?utf-8?B?THBMbGt3ZlZWK0UzQ1ozUnBDdWM5Wk1VU0Z2MmVwSWd3ZW1KUCtYNFhvWG5u?=
 =?utf-8?B?RDZuMDh5RHc3WENuQWdjclF0YUxERnl3MkdZT3M1TFh2RVBWUk5wN2xlc0Jo?=
 =?utf-8?B?S1hSRmRSd00yWW02Vlp1MGNtMmNqVjcyWkF3QWZpMVhqaFdBZ1RDblMyaFdp?=
 =?utf-8?B?NlZQVXNwVHpyNjFtdnRvcWRrbHoxUWJPV0pPUUlYS2lRV3F6ZHlscWJvOEtD?=
 =?utf-8?B?emNHNDhFM3RXaE5rMDkzQmRINUZMNmVnQlNaa3F3akduSW1UY2tRUlRMcEFT?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <548AD5B922BC4C4D9B6DF1B18227382B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3443112a-bb28-49f5-924f-08dc399a234b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 02:48:55.9075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/AJbHOGkPJ3w/hYh+r7AsQr7T8pB85fG6X4JCCBB8dYwUisRdf7wvwDqKTmDHptAubj1gC8EuHp0Y9WgTpA/9+8zpLqzs+L2cOQSEdL3qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7246
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.560800-8.000000
X-TMASE-MatchedRID: UWn79NfEZzbUL3YCMmnG4uYAh37ZsBDCQV6BZJ9WeFayrCkM9r1bWskU
	hKWc+gwPWASbhXBhlp5EWfNw6xpshwu0oQDyuFNTJhFEQZiq2ZRo3Yq5PCwLAvt592eq2xoTcZR
	z3r8mb5RbFSjXHvY/oEr+cHw2Pi9QrPvkNFf532SM29hkek7XdwRryDXHx6oXdf6tui+/W0yQxX
	DSJnj4A1yIuBLp7rU4l/nE+SiO7IYdj9vNGYhpkeKXavbHY/C1edRmpFvdpuZ3aEDyEjSZIaDz5
	hsiacLfyJbKe4z4Q29ICsMQxCDS2Lsl8Gv1eXkKQpxiLlDD9FW2LJAlsBf47r2Bebs5vP5MwOWn
	bwsz43LeRumvl8rHn5GTpe1iiCJq0u+wqOGzSV1WdFebWIc3VsRB0bsfrpPIFUFJm2B6H9E=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.560800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5703A05AB2CC6B9C44C07E297670AF1207EBBBD9F0865BADAE1C5AD052A8800F2000:8

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHlvdXIgcGF0Y2guDQoNCk9uIFRodSwgMjAyNC0wMi0y
OSBhdCAxMDoyNCArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6DQo+IFNv
bWUgU29DcyBoYXZlIHR3byBQQ0ktRXhwcmVzcyBjb250cm9sbGVyczogaW4gdGhlIGNhc2Ugb2Yg
TVQ4MTk1LA0KPiBvbmUgb2YgdGhlbSBpcyB1c2luZyBhIGRlZGljYXRlZCBQSFksIGJ1dCB0aGUg
b3RoZXIgdXNlcyBhIGNvbWJvIFBIWQ0KPiB0aGF0IGlzIHNoYXJlZCB3aXRoIFVTQiBhbmQgaW4g
dGhhdCBjYXNlIHRoZSBQSFkgY2Fubm90IGJlIHJlc2V0DQo+IGZyb20gdGhlIFBDSWUgZHJpdmVy
LCBvciBVU0IgZnVuY3Rpb25hbGl0eSB3aWxsIGJlIHVuYWJsZSB0byByZXN1bWUuDQo+IA0KPiBS
ZXNldHRpbmcgdGhlIFBDSWUgTUFDIHdpdGhvdXQgYWxzbyByZXNldHRpbmcgdGhlIFBIWSB3aWxs
IHJlc3VsdCBpbg0KPiBhIGZ1bGwgc3lzdGVtIGxvY2t1cCBhdCBQQ0llIHJlc3VtZSB0aW1lIGFu
ZCB0aGUgb25seSBvcHRpb24gdG8NCj4gcmVzdW1lIG9wZXJhdGlvbiBpcyB0byBoYXJkIHJlYm9v
dCB0aGUgc3lzdGVtICh3aXRoIGEgUE1JQyBjdXQtb2ZmKS4NCj4gDQo+IFRvIHJlc29sdmUgdGhp
cyBpc3N1ZSwgY2hlY2sgaWYgd2UndmUgZ290IGJvdGggYSBQSFkgYW5kIGEgTUFDIHJlc2V0DQo+
IGFuZCwgaWYgbm90LCBuZXZlciBhc3NlcnQgcmVzZXRzIGF0IFBNIHN1c3BlbmQgdGltZTogaW4g
dGhhdCBjYXNlLA0KPiB0aGUgbGluayBpcyBzdGlsbCBnZXR0aW5nIHBvd2VyZWQgZG93biBhcyBi
b3RoIHRoZSBjbG9ja3MgYW5kIHRoZQ0KPiBwb3dlciBkb21haW5zIHdpbGwgZ28gZG93biBhbnl3
YXkuDQo+IA0KPiBGaXhlczogZDUzN2RjMTI1ZjA3ICgiUENJOiBtZWRpYXRlay1nZW4zOiBBZGQg
c3lzdGVtIFBNIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERl
bCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4g
LS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAgLSBSZWJhc2VkIG92ZXIgbmV4dC0yMDI0MDIy
OQ0KPiANCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMgfCAy
NSArKysrKysrKysrKysrKy0tLS0tDQo+IC0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0
aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiBpbmRleCA5NzViMzAyNGZiMDguLjk5YjVkN2E0OWJl
MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdl
bjMuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5j
DQo+IEBAIC04NzQsMTcgKzg3NCwyNiBAQCBzdGF0aWMgaW50IG10a19wY2llX3Bvd2VyX3VwKHN0
cnVjdA0KPiBtdGtfZ2VuM19wY2llICpwY2llKQ0KPiAgCXJldHVybiBlcnI7DQo+ICB9DQo+ICAN
Cj4gLXN0YXRpYyB2b2lkIG10a19wY2llX3Bvd2VyX2Rvd24oc3RydWN0IG10a19nZW4zX3BjaWUg
KnBjaWUpDQo+ICtzdGF0aWMgdm9pZCBtdGtfcGNpZV9wb3dlcl9kb3duKHN0cnVjdCBtdGtfZ2Vu
M19wY2llICpwY2llLCBib29sDQo+IGlzX3N1c3BlbmQpDQo+ICB7DQo+ICsJYm9vbCBzdXNwZW5k
X3Jlc2V0X3N1cHBvcnRlZCA9IHBjaWUtPm1hY19yZXNldCAmJiBwY2llLQ0KPiA+cGh5X3Jlc2V0
Ow0KPiArDQo+ICAJY2xrX2J1bGtfZGlzYWJsZV91bnByZXBhcmUocGNpZS0+bnVtX2Nsa3MsIHBj
aWUtPmNsa3MpOw0KPiAgDQo+ICAJcG1fcnVudGltZV9wdXRfc3luYyhwY2llLT5kZXYpOw0KPiAg
CXBtX3J1bnRpbWVfZGlzYWJsZShwY2llLT5kZXYpOw0KPiAtCXJlc2V0X2NvbnRyb2xfYXNzZXJ0
KHBjaWUtPm1hY19yZXNldCk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIEFzc2VydCBNQUMgcmVzZXQg
b25seSBpZiB3ZSBhbHNvIGdvdCBhIFBIWSByZXNldCwgb3RoZXJ3aXNlDQo+ICsJICogdGhlIHN5
c3RlbSB3aWxsIGxvY2t1cCBhdCBQTSByZXN1bWUgdGltZS4NCj4gKwkgKi8NCj4gKwlpZiAoaXNf
c3VzcGVuZCAmJiBzdXNwZW5kX3Jlc2V0X3N1cHBvcnRlZCkNCj4gKwkJcmVzZXRfY29udHJvbF9h
c3NlcnQocGNpZS0+bWFjX3Jlc2V0KTsNCj4gIA0KPiAgCXBoeV9wb3dlcl9vZmYocGNpZS0+cGh5
KTsNCj4gIAlwaHlfZXhpdChwY2llLT5waHkpOw0KPiAtCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KHBj
aWUtPnBoeV9yZXNldCk7DQo+ICsJaWYgKGlzX3N1c3BlbmQgJiYgc3VzcGVuZF9yZXNldF9zdXBw
b3J0ZWQpDQo+ICsJCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KHBjaWUtPnBoeV9yZXNldCk7DQo+ICB9
DQo+ICANCj4gIHN0YXRpYyBpbnQgbXRrX3BjaWVfc2V0dXAoc3RydWN0IG10a19nZW4zX3BjaWUg
KnBjaWUpDQo+IEBAIC05MjAsNyArOTI5LDcgQEAgc3RhdGljIGludCBtdGtfcGNpZV9zZXR1cChz
dHJ1Y3QgbXRrX2dlbjNfcGNpZQ0KPiAqcGNpZSkNCj4gIAlyZXR1cm4gMDsNCj4gIA0KPiAgZXJy
X3NldHVwOg0KPiAtCW10a19wY2llX3Bvd2VyX2Rvd24ocGNpZSk7DQo+ICsJbXRrX3BjaWVfcG93
ZXJfZG93bihwY2llLCBmYWxzZSk7DQo+ICANCj4gIAlyZXR1cm4gZXJyOw0KPiAgfQ0KPiBAQCAt
OTUxLDcgKzk2MCw3IEBAIHN0YXRpYyBpbnQgbXRrX3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZQ0KPiAqcGRldikNCj4gIAllcnIgPSBwY2lfaG9zdF9wcm9iZShob3N0KTsNCj4gIAlp
ZiAoZXJyKSB7DQo+ICAJCW10a19wY2llX2lycV90ZWFyZG93bihwY2llKTsNCj4gLQkJbXRrX3Bj
aWVfcG93ZXJfZG93bihwY2llKTsNCj4gKwkJbXRrX3BjaWVfcG93ZXJfZG93bihwY2llLCBmYWxz
ZSk7DQo+ICAJCXJldHVybiBlcnI7DQo+ICAJfQ0KPiAgDQo+IEBAIC05NjksNyArOTc4LDcgQEAg
c3RhdGljIHZvaWQgbXRrX3BjaWVfcmVtb3ZlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICAJcGNpX3VubG9ja19yZXNjYW5fcmVtb3ZlKCk7DQo+ICANCj4gIAltdGtfcGNpZV9p
cnFfdGVhcmRvd24ocGNpZSk7DQo+IC0JbXRrX3BjaWVfcG93ZXJfZG93bihwY2llKTsNCj4gKwlt
dGtfcGNpZV9wb3dlcl9kb3duKHBjaWUsIGZhbHNlKTsNCg0KSXMgdGhlcmUgYW55IHJlYXNvbiBu
b3QgdG8gcmVzZXQgdGhlIE1BQyBhbmQgUEhZIHdoZW4gcHJvYmUgZmFpbHMgYW5kDQpkcml2ZXIg
cmVtb3Zpbmc/IFNvbWUgU29DcyBtYXkgbm90IGhhdmUgTVRDTU9TIHRvIGN1dCBvZmYgdGhlaXIg
cG93ZXIsDQp3ZSBuZWVkIHRvIGFzc2VydCB0aGUgcmVzZXQgc2lnbmFsIHRvIHNhdmUgcG93ZXIg
aW4gdGhhdCBjYXNlLg0KDQpUaGFua3MuDQoNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgbXRr
X3BjaWVfaXJxX3NhdmUoc3RydWN0IG10a19nZW4zX3BjaWUgKnBjaWUpDQo+IEBAIC0xMDQ0LDcg
KzEwNTMsNyBAQCBzdGF0aWMgaW50IG10a19wY2llX3N1c3BlbmRfbm9pcnEoc3RydWN0IGRldmlj
ZQ0KPiAqZGV2KQ0KPiAgCWRldl9kYmcocGNpZS0+ZGV2LCAiZW50ZXJlZCBMMiBzdGF0ZXMgc3Vj
Y2Vzc2Z1bGx5Iik7DQo+ICANCj4gIAltdGtfcGNpZV9pcnFfc2F2ZShwY2llKTsNCj4gLQltdGtf
cGNpZV9wb3dlcl9kb3duKHBjaWUpOw0KPiArCW10a19wY2llX3Bvd2VyX2Rvd24ocGNpZSwgdHJ1
ZSk7DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gQEAgLTEwNjAsNyArMTA2OSw3IEBAIHN0
YXRpYyBpbnQgbXRrX3BjaWVfcmVzdW1lX25vaXJxKHN0cnVjdCBkZXZpY2UNCj4gKmRldikNCj4g
IA0KPiAgCWVyciA9IG10a19wY2llX3N0YXJ0dXBfcG9ydChwY2llKTsNCj4gIAlpZiAoZXJyKSB7
DQo+IC0JCW10a19wY2llX3Bvd2VyX2Rvd24ocGNpZSk7DQo+ICsJCW10a19wY2llX3Bvd2VyX2Rv
d24ocGNpZSwgZmFsc2UpOw0KPiAgCQlyZXR1cm4gZXJyOw0KPiAgCX0NCj4gIA0K


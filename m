Return-Path: <linux-pci+bounces-10704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D37E193AC8C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 08:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39950B20D5C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 06:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0031C6A1;
	Wed, 24 Jul 2024 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c2cfd9pz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="bcmquNcT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397A4C84;
	Wed, 24 Jul 2024 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721802323; cv=fail; b=XLxqKBR8X5JFGYrxH7rj3WWgLd3myjWgAq9LVwki/8f1VwBt58pTCm2UDIYatsRB7ZIyg+DbcktC8xFy+n61T5kgkzbevXb/QGb7eBffeDz/VKGL9QCkb8gbQn5ooJD75rBUWpRmXHyOhcy1u0Wj+Uq58epkdT4y85XA9rmCTiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721802323; c=relaxed/simple;
	bh=222xKPkuKKZAU2NT81xKyr/vS/K3az7OyLbDnyelsbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FK3KN9EeANeLHqKKz/BdW/FYwV/EeeQMoq3lYcuq7PmM7PNh3Hq3Q/wh5EGttW5ASrmiqIrykLyOKsFRXk2DntW2StiVugcxBCqnM3rLGssKcX9hVvk/6NZ1EQIwRF5s1aZoY6UviyS0FpnaUGSlRpPq7y3GdMfnz54oJ3A6vhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=c2cfd9pz; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=bcmquNcT; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7c2ad28a498511ef87684b57767b52b1-20240724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=222xKPkuKKZAU2NT81xKyr/vS/K3az7OyLbDnyelsbs=;
	b=c2cfd9pzRZur5drupm6Ynrk/NRCe6Ae8XcR+BsNAv/G+aeCCjJmc/4ZixwD8susmYmAbPsk4UvFr2IgZbwlcd0XN+Zecqz69Q7Wo+9ihcVcRwhxYoHbI1/v8IXXasIr8Hi6qUZWVy6XcxMSO4j9siRyp3AQqhKKybIL0qRCNdeg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:993e3bbc-bd28-47d3-bd0a-f5e187a2422f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:149da945-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7c2ad28a498511ef87684b57767b52b1-20240724
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1062315297; Wed, 24 Jul 2024 14:25:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Jul 2024 14:25:14 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 Jul 2024 14:25:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uG4BDjV+gNBah8QzCME0pthOtYjCF7VVCZU37bknmEHZ+8ftdklf4uGuh3FZ0/qrg5Dcyz0lOE4N7P7L9+IgHAT79i2uTR0A0NbiE/lvGisYPck0os0LcHdsQlBTJdV36MGJhM3XBGQOlHcNGiT605+MInkkQfrqgEedkVK82LxmRL3jsRIuD5x2vHoOLeMMtv6ts21YH1MGttGRXfxJZVxmcdYyJmHoCGsijKWaWporR96CVePxCurNnZvLA1tTuuZcoPDod8lI3MO1szAHUDpbU8ebAA2nFF7BHarftstuvzkH5WC70wOZhACHiY8TAlUBncohfuBF+rDNZdtFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=222xKPkuKKZAU2NT81xKyr/vS/K3az7OyLbDnyelsbs=;
 b=N6eh624ffOCgN7f7fVamniiyGIQ4yc9GtLu8Hfsh+y6Bs4/jWofbFnnGxcGth08QvXg71t170GddJtB6Wlq3nXGhKnmDsdDg+JruQ0pO3MqfHWvX9r1djIij6oJmf6+6dMsdMs0JQAOUmt22yu3YDRlrEYDcxpibhz0/3ppvraBJNb7DR5K4Ks1luzG+8Q70RL7P/+YPXNyVXQ5Xj5wgLmYaWH02Ybm6PNOY4cV8r94HRFBTTdr8dg7Dp3jl5sU6geRhGUaXE/tvQGsEBGIsXUdZg029Ub0rpOEIku5IiF/fuhsqXty/HfChdhTbskgJ5OYVXkwyBUIOEG2bqjGbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=222xKPkuKKZAU2NT81xKyr/vS/K3az7OyLbDnyelsbs=;
 b=bcmquNcTkLkXuQHglAZwB74YzBdibU+3Gg2q5SOMX60xxu6Sr3nOcVLD/A6etKcoJx16b4dhSfp/Xg+SU8rnHY0atRjc80x8harxbxQUYYE9/P1C55viYohRwDZpeYwM3TfwDSIKtAsYf0eBvoyH/y8qhR2Jgk9uYWYqG2YOGS8=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by SG2PR03MB6682.apcprd03.prod.outlook.com (2603:1096:4:1d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Wed, 24 Jul
 2024 06:25:12 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 06:25:12 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "jim2101024@gmail.com" <jim2101024@gmail.com>,
	"jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
	"Jisheng.Zhang@synaptics.com" <Jisheng.Zhang@synaptics.com>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, Ryder Lee
	<Ryder.Lee@mediatek.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "den@valinux.co.jp" <den@valinux.co.jp>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "Zhiqiang.Hou@nxp.com"
	<Zhiqiang.Hou@nxp.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "nipun.gupta@amd.com"
	<nipun.gupta@amd.com>, "florian.fainelli@broadcom.com"
	<florian.fainelli@broadcom.com>, "nsaenz@kernel.org" <nsaenz@kernel.org>,
	"daire.mcnamara@microchip.com" <daire.mcnamara@microchip.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>, "joyce.ooi@intel.com"
	<joyce.ooi@intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"anna-maria@linutronix.de" <anna-maria@linutronix.de>,
	"shivamurthy.shastri@linutronix.de" <shivamurthy.shastri@linutronix.de>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>,
	"linux-rpi-kernel@lists.infradead.org"
	<linux-rpi-kernel@lists.infradead.org>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "kw@linux.com" <kw@linux.com>, "amishin@t-argos.ru"
	<amishin@t-argos.ru>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "maz@kernel.org" <maz@kernel.org>,
	"nirmal.patel@linux.intel.com" <nirmal.patel@linux.intel.com>,
	"apatel@ventanamicro.com" <apatel@ventanamicro.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "thomas.petazzoni@bootlin.com"
	<thomas.petazzoni@bootlin.com>, "kishon@kernel.org" <kishon@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "m.karthikeyan@mobiveil.co.in"
	<m.karthikeyan@mobiveil.co.in>, "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "u.kleine-koenig@pengutronix.de"
	<u.kleine-koenig@pengutronix.de>, "pali@kernel.org" <pali@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>
Subject: Re: [PATCH v4 07/15] PCI: mediatek: Silence set affinity failed
 warning
Thread-Topic: [PATCH v4 07/15] PCI: mediatek: Silence set affinity failed
 warning
Thread-Index: AQHa3QSuLRCgzIarA0a5TOrNSf/V/bIFam+A
Date: Wed, 24 Jul 2024 06:25:12 +0000
Message-ID: <0df751227ae58474f4b7e87589f041a75a5821f1.camel@mediatek.com>
References: <20240723132958.41320-1-marek.vasut+renesas@mailbox.org>
	 <20240723132958.41320-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240723132958.41320-8-marek.vasut+renesas@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|SG2PR03MB6682:EE_
x-ms-office365-filtering-correlation-id: 9bcb9ed0-0615-4385-ebd2-08dcaba95fcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M2RxYkRqZ0dwZnNwYWpNQTQ0dDQwbkp6cGlDVVNkZlhFbVJNV3JSVER0dkVW?=
 =?utf-8?B?SndUeVNTc2ExeW9vT0djelBjVVRaMUZnVzJVU2daLzZraE4vRzFnbzZJUTBI?=
 =?utf-8?B?bnE3dUZEd3h1Y3FCdklhT2o5MzFiYVArVGdGNjNjZklMSzBFaHpnR09ab0lW?=
 =?utf-8?B?R1duMmFsTEQwN1FYWHFSSHpYTWhiQk5FdXMrbTY0ZTJScHkzc0d6WnJqenZ2?=
 =?utf-8?B?SjJZVmUrdWRQSjlnMjQ0akhPTy9Cc0Jlalk3NmRTdXU0S2xsL0VlZ0JjUkln?=
 =?utf-8?B?dFdaMURsaXg0TmZieWJwbUZOcCswbE5VeG1WWVdRdGdIT0ltcC9Kd3h3eU9l?=
 =?utf-8?B?ZXRtTzh4LzBnQ2ZIL2tDSGsyUDZ4TlZ5QWlNV0tmc3FwREJURlAyK05yMlo3?=
 =?utf-8?B?M2VVTU9wd0Nxdk9CMVV2a0c2WnBJell6UnNJNWRtaDZuTTArVHdWdVZsdXpx?=
 =?utf-8?B?NndtRnpUS292TjdiT1VWZ3RvNzljV0ZjZUQvUk80OEh5aXNsZUw5WkVQVkF2?=
 =?utf-8?B?YkhwdHZxaHFUanFld29tOGgxR0V6TGY3bU9nc2pHZkdLaHJLaEZ4bnphRHk3?=
 =?utf-8?B?ajlXbmFTTlpTKzlBbGM5RndUL00vVTVoTk1IUk9wZm9lcHVrZ1hPc2lYUmY3?=
 =?utf-8?B?bDlrTk44bFo0K1UreHMwVmZVdytVT2UvSmJHU2lRNWJLV0U4TDRZN3lCV3FY?=
 =?utf-8?B?UWpTWkRYSjA5cVZMT3VHd0VvUTR0SUlLRnB5eUtMbzJNZjkvZFQwM3puaS9E?=
 =?utf-8?B?eENBSkZubWhPdHVSeUFaa044QWI1UXAvYlRTYTNISk9RSGY2SmxDdko4RjJO?=
 =?utf-8?B?bFpHeGFNNG9zdUUyem4vSVRpdkdFU0FOK21STEVBaC9DeE1HbG9FOXJodkYx?=
 =?utf-8?B?N2pwN3BSSTVQUk9US2VwcUdFbnR3aCswSk5ZQXcrQ1VmcC9UK2hjOWRXTVJE?=
 =?utf-8?B?cmZzREYzbUNFR0pSR29BOFhvL1p5MGJjdXRPTlRYZFY1LytkU0hRemJOMGk2?=
 =?utf-8?B?M1ZERjRNWVFmT1dyamM5bWZXeFBTR1BhWDJQVjRteTV2emI3dlVCanVoNHly?=
 =?utf-8?B?UFUxWlU5RmZVYk9xMVFFYmpGS2FFNkRUNXNQY0JTeFZ4WXZETUJsblI5UWRK?=
 =?utf-8?B?QjFaZXYzTTVIQ3JXaEtCS040RTNNay9LSlAvcHhWejd0RjNjUENLZmVIdVZD?=
 =?utf-8?B?OHJJLzM0ZUQ1WkwyTXAyN25aYnVqQVVidkRaTU1vOTVpS21iLzB2SSs0bHZ2?=
 =?utf-8?B?UTdBeTFndjBuamZ0ZHpadk5jdW1IQ0EwaGRWRDNpTTRueFZtZ0VJak9hZzVv?=
 =?utf-8?B?dlc1cEZZVmJiVXJ6UXBsL2dXbThCQjR0MWhXeFFFNDRaVkVzSEY4TTJuRmts?=
 =?utf-8?B?VHJwYlcwNkcwMGt0dlp0Y3E5dWxDNU5mbHRQVTE5RjFHUzM0dDgrMmVoYzVC?=
 =?utf-8?B?R3IvU3YrY3lQbVg3bjFBa1lkWGdzZGlPRkRMb3lqLzVGWmFxWmJNZUYyck90?=
 =?utf-8?B?cFhZVXZ2TXNZY1h0ZXlQNURCc3hiVWdMYjRRZlJCaXowbTVzMUE5ZXZ5R0Ri?=
 =?utf-8?B?SnhtdThmZzZjQUIrSVRxUy9QZTJKblFtbWFPQkFBbzNmMFQ0Q1JGd3lHeFhT?=
 =?utf-8?B?NG0yUEREeXNaTXArM1UrR0VKemJ6TjV0dWdOeExncFZhaGo4VzhJeXRjZDFa?=
 =?utf-8?B?bjBXMjI5U2VsZjh1SXpqLzk4SHBLOXY4bnlnQVMva0hodnRDVnQvMUt1b2dC?=
 =?utf-8?B?YnhabHlFTXZ1THpoL1BCc0hkNkVzZHNWUUp0SFZmL205YURoeUdIVFhVYUZz?=
 =?utf-8?B?ZDdLRjkwL0M0c0tSNllGNnFNbm5QbUIybHRvSksxRWg0RStyb1NDTWsrOTNm?=
 =?utf-8?B?TXNObGREdEFHZzhBWDVNbXk0Qm1QVjBwZy9ZZzBmK0lzZlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmdNTmM0T2xYQloxNE9PSUl1RHZLU1FlVmZ5UlhnTHRvbVA5YXBoaWJyL25Q?=
 =?utf-8?B?VlRINElJRURiS0YvVkhRamNYREdjZlhZNlY2UjNibXhOYkhsaU9VT3puWGdl?=
 =?utf-8?B?WEdpekc0TGhGM2RiaUZSWG9TRW5UY3dOVE1rWFZmSUxvakRxbWlZTEhSKzRw?=
 =?utf-8?B?cURTZ2FnVEFKbllFTGdnRlc2R0ZveSs5VklvcFdOTk5USFVvSE1BMzIxSVUv?=
 =?utf-8?B?c2dZc2hJb1VGcjFkcGhZazlBa0VLaFFHMTgyNHJEZzN0M2RFVFBabG5Ic3Zh?=
 =?utf-8?B?cGNxWDd5M0hNNmhBR2orSldsTUtoRGxSUXhTa0RtUGorU0FrSE85TmpNZG1j?=
 =?utf-8?B?UmwrNmxxTk5RTms4d2hISjBIOWo0c3ppcXpCbXlRVzVuWWJvZ3BydVgrYmVa?=
 =?utf-8?B?b3h6UGJBeHgwMUdJbmVVeWhzeHkzWWNDWTVSR0VEZ1N3dWVTZUxPcy9ZeW51?=
 =?utf-8?B?WG9adWI3Rit2SER5UUQ4cnpBS0FyK3Q0cktxT2FpUVpkWjJJVkVQLzU5ZVhR?=
 =?utf-8?B?bG0xY2RITXpMSXFCYU1ZUHpMdTdXVkp4M3VKYnkyaW1scktRemw2WURodHhZ?=
 =?utf-8?B?MDRmMHJRWEYyU0FKTkFBN0o4dWxWRjUrb0pmaFhLUy9BU0xnVWY1ZHdPc2V1?=
 =?utf-8?B?V3Z5RExoZFdqQmJiV1VFOTZqTjROMER0bFBCUVNPK3dHTTFZdkZIa2tEeW1a?=
 =?utf-8?B?Y09jV2dpVHo0MDZKY0hKT09jV29TeFZTT1l4NExVUWJDZmdETkRUU1dZdmIv?=
 =?utf-8?B?QXZKYk93NEZmTHRubk1ZT1I0S214R2xDZC8wL1JMVzlHdGU1aU9kOTJJRWFl?=
 =?utf-8?B?bmVQYW51QzJDSkNqcmdKVU9WUm83YnMrZVhDY0JqUnJNRDZTSVY1V0o3TUZx?=
 =?utf-8?B?NXpQU3h5dk5rdE1vS2RvdXgvZEFyNy9hTU9JbXZ5QloxQjkyN0hRajAzaHpn?=
 =?utf-8?B?aVU3cnJOUTJRUkRTdzVFVG1VNDUvSGdrZ3lBakNmNDJZU1Z0UGErZ1docW1D?=
 =?utf-8?B?ZVoxMnJ5T3V6dTg5MkVHTWp5a25KcEpOV09kdVQveFBOdlBKV3AveUt5cHZz?=
 =?utf-8?B?NklCZXR5T05na3hCcDkzNURYMmF6SGdhV0ZMZ3BBUFE5SEdKMjlsbUloa2Rj?=
 =?utf-8?B?WWpxNExsM2RFYnV3VnJ3bCtrVmhtNCsxQVdBUG1CWGlkamhUNGRtQkNpM0Nw?=
 =?utf-8?B?MDFqcHN2Rnd0TFY2RlJFZFd0Ly9keEZDNi9MOTVFSUhjNmZEV2ZtNG96V1dP?=
 =?utf-8?B?TTBsbFZuUUJudlFtODBwcmljYmxxdEgra254RkUxVmNsN0lxQUlrZFVnVTB6?=
 =?utf-8?B?dlNwUkJFVVBSdjVPQWoySXdNQWpIN01Ga24rV2ZCcGJBVFhjL205Z0pXYTJw?=
 =?utf-8?B?NHJwT1ZWU3h2Sm9sblMrSm0zY1Zjb3U5ajJFbVJxTU1CQXRRcHlWU09GUVZK?=
 =?utf-8?B?d2FUR3NQOE1SYnlUdFcwbFlMUG5mTEdsQnV2cmN6TzQyaFFMVkRJV3lUTVFw?=
 =?utf-8?B?NGNmQXhxVjl4dDZQajAza2pBUW1Gc1g2ck9hWER5blJGMkFXcHlYL0tPMnAr?=
 =?utf-8?B?VVFnak15d0Rib2I2a21hbXUvbXNRYURiUVpEQVQvczlMSTRMQkpVcEZQZlBM?=
 =?utf-8?B?Z0VJL3dGb1IrTmQwN0xuL3dSNHlodjl2bkxvbVdPR1pQMEF5MXhHNmZwZnVI?=
 =?utf-8?B?ZWtEdGgrUDgrM0ZHeU1WQ2lzQzJiYjVqZmMwQi9pTFVMa0w3dkYwbzJLaVZt?=
 =?utf-8?B?QzZFc3hGdWc0VGx3T05ndjJ4VTVCK3hQU1YyUWtmSytURDhhZDJiRm1NYjJ2?=
 =?utf-8?B?NWE3VU1qYUtaMzBVYmdhWjZhQnRvZFR6NlZkZnlkMUx0WlowcjFXRjBFdUdo?=
 =?utf-8?B?eDJBTzdmSHc1UitGSURWMENBRGZrdEVsM0ZSYWdqR2hqUzFHR05NV0Z6Wm8w?=
 =?utf-8?B?U1FJMDZkZ09tWHUwRXBuL0RsZyt2RFpKUzFqYWQ2a1FldUtvRGZKSkhrRVcr?=
 =?utf-8?B?WE5sRHk5bXNIWWlYUXFNVVRWTFhjQUVGSjdZY011OGhyN0dLaGRyZGJyaVZr?=
 =?utf-8?B?U1VuUFdzakJBSE92aVdXckR2WGJuWm02MXh2VUh5VzdEOVpSa1BWdWdXYjVM?=
 =?utf-8?B?Mm1wdkpMb3F5bEpnTjVWTjhYRHc5SlpyYVlzeGFMZTRheFZNdkhpQUlyNEts?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20D03D3AFD8B2E42A0BE312C3BF870CC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcb9ed0-0615-4385-ebd2-08dcaba95fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 06:25:12.4723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qVO8UqePOmydzqURyjqGSVUpgH7LcxBFgxkI9FeCGWvPylxqBo6M4vFF8IG78wYa/oNraUOZhnabwebri8IYn5+U1jnIyboiZI37K7Op1Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6682

T24gVHVlLCAyMDI0LTA3LTIzIGF0IDE1OjI3ICswMjAwLCBNYXJlayBWYXN1dCB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBVc2UgbmV3bHkgaW50cm9kdWNlZCBNU0lfRkxBR19OT19BRkZJTklUWSwg
d2hpY2gga2VlcHMNCj4gLmlycV9zZXRfYWZmaW5pdHkgdW5zZXQNCj4gYW5kIGFsbG93cyBtaWdy
YXRlX29uZV9pcnEoKSBjb2RlIGluIGNwdWhvdHBsdWcuYyB0byBleGl0IHJpZ2h0IGF3YXksDQo+
IHdpdGhvdXQNCj4gcHJpbnRpbmcgIklSUS4uLjogc2V0IGFmZmluaXR5IGZhaWxlZCgtMjIpIiB3
YXJuaW5nLg0KPiANCj4gUmVtb3ZlIC5pcnFfc2V0X2FmZmluaXR5IGltcGxlbWVudGF0aW9uIHdo
aWNoIG9ubHkgcmV0dXJuIC1FSU5WQUwNCj4gZnJvbSB0aGlzDQo+IGNvbnRyb2xsZXIgZHJpdmVy
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0K3JlbmVzYXNA
bWFpbGJveC5vcmc+DQoNCkFja2VkLWJ5OiBKaWFuanVuIFdhbmcgPGppYW5qdW4ud2FuZ0BtZWRp
YXRlay5jb20+DQo=


Return-Path: <linux-pci+bounces-10706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588C693AC9C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 08:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8092834B7
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 06:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98663482FF;
	Wed, 24 Jul 2024 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MudYp0z9";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dxFkd/Ty"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2924C84;
	Wed, 24 Jul 2024 06:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721802483; cv=fail; b=iMLy920sC0pvQZ2J7kD2t/mFB7NqJz6bf+MXFikjRj5nMbl5folFMrk2eNcW1aWG+hmOmQMwQKgaqdJA1KXCa7rb45xrR53Rolr9L9Zrp22s45vtsrB6dTcq5CVIUMccrkdXAUvG5fQA7sdC4WWUU1CDBHNF8lXbMosERuW+rz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721802483; c=relaxed/simple;
	bh=222xKPkuKKZAU2NT81xKyr/vS/K3az7OyLbDnyelsbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zor/ftLvJ+7RM2wbkXSI0G2o/z85AXjV3lZsq6Ls6EGPruLwUn+nolVDfOFjGsmt/JwSM/laESd1l5yGVYTbT/rxQcuPsAw0DOfktHKWO2QkHEq2HFTGLhIFfvAxYWBXGi9XTH/0dx/FJJ7QZ6HWNEdH5WvG3K7OwacHTl3GXZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MudYp0z9; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dxFkd/Ty; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dbc441b8498511ef87684b57767b52b1-20240724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=222xKPkuKKZAU2NT81xKyr/vS/K3az7OyLbDnyelsbs=;
	b=MudYp0z9etujsgl4UhvRSMklheGGUl7E1UHvLuMhIlhtV56WaoX0vAeIJtskI659Hq3+TWRyTYU9RC7sVqVYqa9mtPDvSG8n+vP8wAZ6asGK0+S+xp5PpDPK0vJfBN0OxBtnbalQNc6yDw5UcONyFnd565w6ZqzhkRiNXPTM0kw=;
X-CID-CACHE: Type:Local,Time:202407241425+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:9f6d8c4a-8dcf-4996-97a1-8e3c7682f305,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:149da945-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: dbc441b8498511ef87684b57767b52b1-20240724
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 56193275; Wed, 24 Jul 2024 14:27:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Jul 2024 14:27:52 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 Jul 2024 14:27:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UslPPICiLWDoYUKrHfBheUqygWXzlLwJyHhq7l4WaSyzGgqULT1s0kRDPNL0950ZplXOC9AQ2h1KHg2vlXfid5Xde+cbBEKOb1emH/UoKy4hSkaCXIhVjgytn1n0wnn/++1soOJcxYVWTPCooaCJP238tfv5FSDE9ic6HJmcwXrmJXU48pBw0DKVvsDD8S49tzgkM5c1kibONKYRRzjM9gIYbCLl7jtI5IP7gsTOlUB3yd7ld3umaB070V0+G/mF2BANzmTkjaixusYgIgk2++6Tqpl+sRwRVq56Ondx27zXFaVQzh4pcLLQpeRtKOxuntO1zpXMzTf0snwWgDLLTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=222xKPkuKKZAU2NT81xKyr/vS/K3az7OyLbDnyelsbs=;
 b=yazn67cIV2KAs/ncSFSkUZtHy6k1/ulVD8Wemqg6OYq5ZLN7LKNdq+mT1wH7k6xcvkkJ4wLeQP4rcrdwuJYuXvFH7fd+6vv+eUvqC5t/12U7RLyaKhenV3JFQk4RtEmrQokYgNeP1ZFArU3mzaXIVTLuGmYL9aUz1QDGkrIdZFNAk43EIy/1lcLB+rScNsPjgswvaVGfNLOmZz9YqDngXvLFTm5Ghto+8kA2bJltGEMHJaTLYvB8jIEY+nwNokh8NTYMFf1eTVIxXijlcR16TwuFrU8VWi/O3vV63zK5zmoRKoQuC6uLiqQBowpf5mpaQ3Rx/IZguywVJ5Bunzyy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=222xKPkuKKZAU2NT81xKyr/vS/K3az7OyLbDnyelsbs=;
 b=dxFkd/Ty/E4sQQYLWsYQtUJtyHWQqQGopijXwkgOy1hcbDh3xy/itkzDQEq+O+Y7DSxTwo0h8/offgWVjWoBMKoLhv4YGhroPIOSUqiuBYIHI0+NDrMVfE00ZywvaNd/GrJJ3xbA6w4STGXKaopLtVdMzK+u5qhKkivbxU32vuY=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by OSQPR03MB8698.apcprd03.prod.outlook.com (2603:1096:604:28f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 06:27:44 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 06:27:44 +0000
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
Subject: Re: [PATCH v4 06/15] PCI: mediatek-gen3: Silence set affinity failed
 warning
Thread-Topic: [PATCH v4 06/15] PCI: mediatek-gen3: Silence set affinity failed
 warning
Thread-Index: AQHa3QSo4zLiRwpqE0G9BEaPP+4CNrIFaySA
Date: Wed, 24 Jul 2024 06:27:44 +0000
Message-ID: <79c3833a9e901697e4381d34af0eb057963dc6f5.camel@mediatek.com>
References: <20240723132958.41320-1-marek.vasut+renesas@mailbox.org>
	 <20240723132958.41320-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240723132958.41320-7-marek.vasut+renesas@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|OSQPR03MB8698:EE_
x-ms-office365-filtering-correlation-id: d74c543c-00bc-4832-3566-08dcaba9ba87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QnFhaUFmZnlhbFl4SkNucTVUSURocXExRFBqL3VSSW8xSXlzWnZKTDEyUkVD?=
 =?utf-8?B?bTBRSjVCRDErQWE3TEtWVE9aaWExdFo0b1ppcTMxSWtHM0VPOFBzbXRNdElo?=
 =?utf-8?B?dXdSa1VPVW5qVmk2MVIxNGtVQmFSMVBoSUhZbTNpWlR2Z21RWGc2Wm0rZjBa?=
 =?utf-8?B?QndxckRvSFJhaHU2SCthcXhyMzBvMjZXcWRmZFdUTHluR2IvTlA5d3Z1NUs4?=
 =?utf-8?B?VzgxNEJ1aEVWWWtGSXl0Y0htNk9hNzRmM3VpWFprT1JiUU1NY1d5bms3Vzl0?=
 =?utf-8?B?TXFsUGxmbzhmREZCRGNYbmNYVnJvcVowQTJPK2FvbHJZdmtjMXBUZG5najFI?=
 =?utf-8?B?d1ROQ1dGV3EzbThnRzljdndrRVdIK3RQV1ozK0NDd2lld2pTNUtmanVlVHh5?=
 =?utf-8?B?YmVOVmU2enJiYlVWK1EvUFk2aktBUHBTOHF4dVJjQ2xCZXpCNTVHaFVncG4x?=
 =?utf-8?B?Z3dWZDM2MGhWOFFIZTZNcW1TcjVBd1F6MU43OUx1dTRnT0FlZXhnTG8xeDk0?=
 =?utf-8?B?SUdYNmtqZW9hZG9Nb0VQai9kWVFHNko4YTJhOG40Zmd5bWRWK2tvSjNCdU5X?=
 =?utf-8?B?aFhZT2k5Nnc1Qi9Db0JqMndyd3FaV1JYU3A2b05YZ3BXb3Y5U01oaE94a3JS?=
 =?utf-8?B?V25ZcnBHYk1EWWNRKzFhYUZBWnczeHAxdkhuRlBYVmZBYU84VWVZL2dpdE1Z?=
 =?utf-8?B?SnVkOFdDajhYbm80d2lRclczVmYzNWRyeWxNQzZqYWVFZktVZGdXRzBLWmZr?=
 =?utf-8?B?S0d0QkVvV28zYXJoLzAwYTlMa0ZWaXFWUGhJZlhkTDF4Z0svQXU2OHJyTEwz?=
 =?utf-8?B?cUFPcncrVW1RbGNOY1NnVW9leFVXbmJpR1NPaEcvcFFPN2FxcnVadXI5TEdK?=
 =?utf-8?B?VElqY0lnQnhjL3Q3TS9kaEJzeTlaRUs2TVZ3WXFwaVRaTnlnMW9rUndnZG41?=
 =?utf-8?B?Z3NCNzdmZHoyOWVMVldKYnAwUXVxMUJnRXc4RkpHT2gyVXBzWXVnSGJZaUJJ?=
 =?utf-8?B?K1NNeWdZS3M0bWN0NmMrTFlPRUhWOEgxTmYySnZteVZZVGVPNXU0dU1yYXhY?=
 =?utf-8?B?dFova1pjZ2cyaFViZnZCWldKR3FEWHBQMkJvblBvUXkzV3lhUmhuajdGT3V0?=
 =?utf-8?B?T2Y3UklxZ1pWNFB4VDgyVFNDcyt2eWpLeE9WbUdETjV1VjZVdkd6N2tVc09B?=
 =?utf-8?B?STk1TlJtNTM1MlhYaG5GNWs4WHF3VnlYdmU5M3ZvTXAzZXYyblduZmd4a0Fo?=
 =?utf-8?B?T2VmWGs4M21DZUZXejRML3ArRWdKd0t0cEtnVDg3RGpXU28xQU13amNhb2lu?=
 =?utf-8?B?RUVCMlIzMVJsdFJpKzRzMVM1ZVVnS3RHMU5CNUdybHhpWEFuVjM3Q3JiQTlL?=
 =?utf-8?B?RUVkb0JZRTdkQzhESnpna2FoUG8yZlNsVHJlM1dGK2hCRW5laWhKUFVSSUtQ?=
 =?utf-8?B?YkpFSENkRlFPSElKclFWWkw4TEQ2QUVqYjl0MTdNZnNHUHhZc0lwdEdQRFJF?=
 =?utf-8?B?OUNoOUQ0REFiSlFLV2t3WDdQWE9UMElvQWJSamNlalQ1dFNBeitDTUdjc3ll?=
 =?utf-8?B?T1BDMEEvcDllSHhoVThybzEvTWpaRFRyc083U2dEUS9LS1BPSUl1WHRBZzg0?=
 =?utf-8?B?SlAwUFhTOEZKUEhHL0RzNkVJbmFnK3hTQnBiZDV3NjZNdmFOZm8yeGtHNU5w?=
 =?utf-8?B?TG9BcDFrbFlqamdIT09RWUVaZjh5R0ZlWFFoTExnZC9obEJyRG1pSkZLOFps?=
 =?utf-8?B?Umo3ZE5oWGJobHFlUmRIbVNKK0ZYMDZ5QzJPZVhPT0gvRnNKOFVOVmdIM0ln?=
 =?utf-8?B?QldJNzZsQVhzbFpqV2JuMGllNFd2SFc2c0laSnZvU0VObkZpRmg3dDB2VUxG?=
 =?utf-8?B?SjIwa0ZoL2JKVE5yb0ZydTAzbHpFcWVFNCt3K05kUytJeVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVdTRm5pL3V3R0pJUUtQZXlTeFRZZUNZdlg1V3Qyd1hTenYzVFRGcGVvY29N?=
 =?utf-8?B?aDliSlJjK3E4NFU5ZDlDOERJWGVrRHhYVmpnbWlNUlFuQ3NQYXJ0MXJUM1dl?=
 =?utf-8?B?cFpaS1hhdjhDclNvS1VFK2EvQWdnZldMVGVGTFprU0ZyaXQzUTc0UEcrQjZV?=
 =?utf-8?B?WGpaK09vTjNmUkVaTnFCU1dYVFhRZ09JSzN1aGdFUzRmWjFmZ3ozS014bmF3?=
 =?utf-8?B?MzFMQlhkSVdZLzF3UW5HdmsvUHdVVENwZlFvakcyeTdlYWRLbzRPdVF3Z1Q0?=
 =?utf-8?B?aGJkQXhwcmh5dmVZeCtYZHkyQ2R0blFPTVJ6K3NmQXR2TmcvUk9ubVdUNzJY?=
 =?utf-8?B?UDFtUXRvZUttanp2QUpJZUsrRzEycjZqWk1NUytYaDFIZVJaeXQya0RWVjdM?=
 =?utf-8?B?SDhHbHBhTlMveVF0RlhwMVg5MXZ1ZzJKOVhPajM4WHpVWEp6MUl5dzQ3bldS?=
 =?utf-8?B?bkhFL1EwQWNzNzRjU0VudVRzcVhta3VHcnpCaGRxMi9lSWdOdWplRzB0ZWhx?=
 =?utf-8?B?cWpGaG1yQ2N6WFhGZWFHNHlZUEVHRm5ZSnk0M3ROY2g4bjZkNXRlWDF3R3Fu?=
 =?utf-8?B?QXQwRlQ1ZkNBaDBjVk1Dbk9ST1UzdE1YNkVMaGZjRGJCQlQ5eG1BQWM4ZVNt?=
 =?utf-8?B?MitaNDh4aU15WThSY09YVVdZbFVLOTNNQXQvd1poVGZuSmRIUnNhdXJtRndW?=
 =?utf-8?B?MkptTG44OUpzcnk0TFZHVkc5YzFZQnpoTElob2VsdXMvSExTQzdRN3RlQURJ?=
 =?utf-8?B?aWVYOFVkS3RTUnJuQUp3RlR6Zm10YmRnZmRoS3BhcU5FQ0U2ZXpGajFScTcy?=
 =?utf-8?B?L2tNUkNmUHlFRmNxRndEaEIvclRoQldTbnE1YktNU1BHY2hUZlRrSTBIQ1RQ?=
 =?utf-8?B?QTZZVGV3ZXQrUzIyQVdmbGVwcEZmNnN5SGY3KzFwbTc4aWZMQVpEZ3FPVnR3?=
 =?utf-8?B?eFgreWZ5UW9yaWNtcW9aSVFCN2lkWXZUTUNtbFRWaFp2V1hPMTJSNnk3WkZa?=
 =?utf-8?B?NkdRYjNWSitVYjhjV1hJUTM0V1VHbUh4Zk5TcFZjSCsrRXhUdUVVeEpNZGZw?=
 =?utf-8?B?SExMeGlrQmtlV3dUSXNUZnhLcVd2TmNYSHNxY3VtVmlmT0VDZHZiZU1OeGRz?=
 =?utf-8?B?dllGUml1WVVkc2ZIUUEyb2dWdVNWMngvaHBjd29RMVBBclg2V3JVbGhobTFz?=
 =?utf-8?B?MERyMVVlTjJLVGRzTHFSdGdMTGdjUlp6SU5EMEl5bVhlOUFad1RSaUVOa0J0?=
 =?utf-8?B?allYMENRajJFb2dnZlVQMDd1bm1IVTY2QUxxcEFycVNqUlBGd0QralJFN0Ur?=
 =?utf-8?B?clMwejQ1czg1N3htUWNTRk5NZDBsNWdxQ2puS3NZN0pZYk8rL3NPOU1FN0dm?=
 =?utf-8?B?N0xtMUJqTGEvalYvVW84NXFjcWNyNlZjWm95dmttVkppd2doRFBvZEh3RjBT?=
 =?utf-8?B?TkRRZmlYMG1JN1c3ZkE5ZWlSeGpmL3o0ODQrSTcrb25qTWhXcTVLdVhxb0kw?=
 =?utf-8?B?NGxvKy9BWDM2a1FLQUxvZGViL2NCUWZ2VGtiWUF1djJWazE1d05reTNDZ1I1?=
 =?utf-8?B?Sm5wOU9MQm1uZVR3Z3BqZjZqSmtsaFQ0c1FwVXFtWnJ3aEtWNjFYSWpzZXJu?=
 =?utf-8?B?VHdudGRkQkl1U0M5Q3RXaUtwWEtiR1FRZXp3OURUanlTc0trUWFSdGd0ZEVY?=
 =?utf-8?B?UjRFYTNJSmxHdFl1bUtzTVAwTW5wTmUrK2dQU0JtVG1FMEY5aGZEWTcwN1E0?=
 =?utf-8?B?T2RwcUdjckpXd3A2NkF3anBraDRnMks3ZjRjN2lzNS9BV2FtOXdJc3JIVmxH?=
 =?utf-8?B?MncyMDNtMlZVckdQS0lBR08vRXNzV1VYdWZZSFExU0JxQW4wTGJnbWxOa2w2?=
 =?utf-8?B?eEw5clFUU0cyeUl2U2htcW9ZT21MR1BPTXpocjlicUh0cEhiamI3RU9TV2da?=
 =?utf-8?B?RWFSbTNJdWtEZ0dUelh3SmlFT3dobkVhT2ExVjJCQ2xCbTl3UGtRc29ieTh3?=
 =?utf-8?B?aHA2TmkvaTc1dS9pL00weU1RbU1MUk8vV1BWSC8yN2NpVGI4NEFTeE1rYnAz?=
 =?utf-8?B?Nkp5amtGY2xqRmtNamVLaGZ1Rkdwdm1VbnVYTEw2Y3JRdFJHTXVzUStqOEFR?=
 =?utf-8?B?K2pPU2tQUUpXT1BwR3VYalFuei9nemU3Y0Z6ZUFQUjZKM2xtMEhiS284TDZI?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDC2D45DF387E54D8F0F9DE1833FEF14@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74c543c-00bc-4832-3566-08dcaba9ba87
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 06:27:44.6969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IkjHOeneZqVE12zkhwuVZl0dLdLovqhznerv1MTUZuOMQsldcCZkkaOqCtoHPK+cgwNiUne8k5i26F0ru6KOg1fCbGMeVG1JK/y1ubdo+8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8698
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.064800-8.000000
X-TMASE-MatchedRID: qEAy/z09Hq3UL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCk2VnXMRzIBjaK+MsTwM+1lMkOX0UoduuY7fTcpcY1e/BTO
	P6CqFK1FY1bHLs8FB4ML6rZDQvNqmlwV2iaAfSWfSBVVc2BozSpwhktVkBBrQmKFSOuIXjvDakj
	6FuUTADwtuKBGekqUpOlxBO2IcOBblJe2l4VyfBk+OXE7PgBvRb8mcM5eLoZFUBBYT7icZKnsp6
	d4iDOHEQwymtxuJ6y0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.064800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	92CC6AD932849D5B109F3C5A6FBF61AD670F28A4EB5B879E5D565510E0DC067A2000:8

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


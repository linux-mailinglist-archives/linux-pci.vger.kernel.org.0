Return-Path: <linux-pci+bounces-19370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A447A035CF
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 04:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C0A3A49F6
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 03:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EA113B298;
	Tue,  7 Jan 2025 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eb5KkoAg";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="bPaVqDR2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABAEA31;
	Tue,  7 Jan 2025 03:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736220079; cv=fail; b=QsoM5BeZvAkj5MsWpiAtspwTDKnMO5mq/ojBk6O3dC/qHsqa0PFMCKp9b+qyL67bMNzuF8qrLpiN9gFQwGu259bysfsZmd7OU5LDHNUdLPYooHHqN9RW3UV+5wIQ3vBPBOm1kGyFmP2JHdsuyXIp0/r+O/4VZsKnWf0fZTl/nBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736220079; c=relaxed/simple;
	bh=Lx81qHBvY+u4FRF0iyAXn43MPhC2Aw818JGdp5nHPOQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e1y4iUeOtg8qGfOwUkp845SezkapSXAWNQrjGwiTCWgN5up3yLynimHJg3H3McYr50MDuwed8GWk0C6QstITqmphSrNEfX8Cj/0bzwMUknRiY5rIZqU8JqyK2On04Zcppmhw7DRhgsi9U/HDZy8iY8Yh58R4H1gkSMcKJ9Xqn4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eb5KkoAg; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=bPaVqDR2; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7080dadecca611ef99858b75a2457dd9-20250107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Lx81qHBvY+u4FRF0iyAXn43MPhC2Aw818JGdp5nHPOQ=;
	b=eb5KkoAgL5tk6O/jz88fFfK9F+VbLjYDq+Sc5RkqPqsZOe96cjPnuT8ulD5XJEWIpMAS8uIeo7vE8Ap1bEG5vtvQCJ8LVuxX1F0vcxXfDFLJr7ZHpq8svVZRtvOgHhtuoAyMNV2kj581q92USgzYizxDeGGHCNGI8sQRRopmUew=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:6cde8ad4-b468-4e14-a24a-c70b94a2faee,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:60aa074,CLOUDID:1dfdc149-1563-4a46-85ba-7ddee3d98b2a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7080dadecca611ef99858b75a2457dd9-20250107
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 498357295; Tue, 07 Jan 2025 11:21:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 7 Jan 2025 11:21:08 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 7 Jan 2025 11:21:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2/juoM8yTdE7LfbZY2D10TnBtFx75aH8rqNFi7eRWyWLT8IVPJcvx2K51OHksJn74KbBcDZwfwHZLzeXxLTLmwSihfoDOxyv2a7ol4MqswIyyt2IKbOudp6i29D+5ToODS1Q97Q1Ll5dB0Q7ykpe+VmPyfZcg1vd1zczCaAGRQnkueQ+xDXeGu5ucUmNtx6nT8X5P5umWQRlspVAkLDx/nYJH1jl88XLKe06zeKdcSTeSwHOay2fr6JapvoF3hOsxMriC7BAVDhPMJP43hV3m4sOTuXv13P3DEPqQQzDI6zZCJlDNC83XMDzNAOEZXXZSQExGvpxhYlzixX+MTKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx81qHBvY+u4FRF0iyAXn43MPhC2Aw818JGdp5nHPOQ=;
 b=yWV5FPDehLLIFVSkiY5l5zvHu+gilK2aoKX/rjyZnKaNSPN2zCuNyGFI6PZfmkQGgz/yII+hFkLmxUDZXAeMDdtFdjpMmmWTTOQXdFidgs45PeKxxRxkNXiarDzZPJlHzqk74U0zCil9gSmFGYYipM5NKlpjR1GvJI5Me5gmU1YGwjqBBawHriGnazhE4l6ZNIwG3YEjt9HZkKUrOWYFyh4mlK149Jg3McVZsgd7Gkm/sOEAwLAaJh+T7M4KVGpB4S9+Si7MLzFCnrWPw9za7I5BQ5aVNpXNrz7ShWox7cN2vC4Cg3FRk+5L+78ripiC2nDP690/jEzCiEDAC+HWrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lx81qHBvY+u4FRF0iyAXn43MPhC2Aw818JGdp5nHPOQ=;
 b=bPaVqDR2n9wRhzoBPV3MT9mLTOtoRvol2ZlaFVKDkZEL5+dSbK92YQpENay0/bPIAgLSgakzk53xsdNUfW/eDOK6bN4KbX4jIP6QyMoaqVMIq4rWN8T7DQZz2HfnIFixLJUvEh7GkvOiegpQ+OhhRPiwwK0Uz5dC5U8LAXSpyDU=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by OSQPR03MB8745.apcprd03.prod.outlook.com (2603:1096:604:272::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Tue, 7 Jan
 2025 03:21:04 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%3]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:21:03 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?WGF2aWVyIENoYW5nICjlvLXnjbvmlocp?= <Xavier.Chang@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH 4/5] PCI: mediatek-gen3: Don't reply AXI slave error
Thread-Topic: [PATCH 4/5] PCI: mediatek-gen3: Don't reply AXI slave error
Thread-Index: AQHbXaTudx8xtE3Nc0iENJOHrgCzn7MJ8XGAgAC5eAA=
Date: Tue, 7 Jan 2025 03:21:03 +0000
Message-ID: <a30f2395fadcebc6981308fe609785a5e964d02b.camel@mediatek.com>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
	 <20250103060035.30688-5-jianjun.wang@mediatek.com>
	 <20250106161639.4bgb7rhokoe22xpp@thinkpad>
In-Reply-To: <20250106161639.4bgb7rhokoe22xpp@thinkpad>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|OSQPR03MB8745:EE_
x-ms-office365-filtering-correlation-id: e1a7b1a0-7bda-4ea2-6874-08dd2eca512f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WFVhOG5yVFhFQ0FDT2JPZEpWbTBTVDZlem1BNXNSemY5bFJlRWRIQ1pkbGw4?=
 =?utf-8?B?emZ4R29rZGFRcFpsR2FyTjJCVlB3S0g2a1lJaEI5S21pUFRETGxLWXYzMzE2?=
 =?utf-8?B?ank5d3VXRDFmRnNNT1hQRldrUTJQaUgrTmR0SmlTOUlIcGNIOVhzVFNXQzBu?=
 =?utf-8?B?SFRLeW4xYXF3dFp5cUk2dU4yWEVJMGo5NzJINU1JN2RVOEh5NmNEVkNhY2ho?=
 =?utf-8?B?c2o1RlhwL2JmbnhjQmluQ1hra21OWW9ONldjZW4rWkdLRk9lZ2RBRHc2a2Rj?=
 =?utf-8?B?NDV6bjI0ZWRWR1orMzRkZGtlVTIvYmFDbWd2WXNzQXdLenAvYi9iaUY3clVG?=
 =?utf-8?B?czB4UUdPRU9qU0xEWC9VM3NDMWhaYjYwSXdDRmE2SGF3UU5vT1dvSlJyZUN0?=
 =?utf-8?B?RGd3V1FXZDFZM1Y5Sk9PaFFkMDc2VlBmbDM3NnpFQzdFTUtuL2FZR2JjR3RQ?=
 =?utf-8?B?WGgrMldoTVFHL25NRVV5djAreDd1KzdmL0NtMEJyeGNoZ1UyZmNJSzVWZ0Vj?=
 =?utf-8?B?UzJiYk9FNW9SczloQUdPRncyS2haRG5NMDQ1MjhrMEc1VXZZdHZyc2ZmeWI2?=
 =?utf-8?B?ZnNqNXcxcFdicUpJNDd2a2IxSjc0akN0U0pqd3Q3NTk3UkZGYjd6VE8zL1N3?=
 =?utf-8?B?UloyaDRJZDFpdWpMVkxpTExLWENMZjdoWHFqL05zbGhYSjZvQmt3TW1IQWRs?=
 =?utf-8?B?OTJTN2lxSUlCM2V2Mm05d1pxRmdTVS9FbTVpc3VMdDF6eE9NNzZON0g5MGdZ?=
 =?utf-8?B?S1l3YUlLU25DRVd3bUY0cmNZTlpLSDJuS2tIQlhCOWJaU3ZXc2ZCclRuN01y?=
 =?utf-8?B?bXFrMS9jNjdUdEp1NjgyTUF1UzNxdDdCOXNHRlQ3bi9XRUpNSmtMRzczN21x?=
 =?utf-8?B?OW8zcGNocjBMZWRxSVdOR0M1Vmt2dUY3SDl3aG5zUDJxV3o4ckkvZkFKZjBn?=
 =?utf-8?B?WVJpc1VzZjVpa3psSEN1TWxvdGtBb25hNlNMMEJPTVI3Q3QyUjdyNEdWUk9i?=
 =?utf-8?B?ZkRHejdRWldrWERiOVc4aFA4VW5aNUVhNkNLNnN5RCs0Z1VGSVRpSVpOczdT?=
 =?utf-8?B?b3orUFk3ZGtNNC9uU2hpNWg5SEhSQnhOU2tnQjhBVE5sTVJsQUgxSy9HYVRL?=
 =?utf-8?B?aTFiQTh5b0VzOUFXWW05bVFBNHZRc0lmbTJuRTdNUGRuK3pDR3ZuZDVvNlBW?=
 =?utf-8?B?RUhFUHdnbHVvRjdJa25nUnhObUl1RnRVVTdpdnRmQkg1UUlYY1k4K0RmL3BU?=
 =?utf-8?B?NHpwRkRhZUtQVXFVY0tNdWx1ZitTR1JkSmM0UGc5RnlTZUhUQUNCQkdOaFNn?=
 =?utf-8?B?TTFuSDJySTN2cElaNHo5N2R5UkswZm9xeGM5Si9ISDk4L3AyUlRsTXh2ajls?=
 =?utf-8?B?WUJHdEJmZmxaZTQxKzRyb3VYRytYZzVaR2xsSlBYQjhKVHFvT1pXeVVNN1hI?=
 =?utf-8?B?TGU0UlAwTmNhc0taR3pPVFRsVnJaUlJSU3BUT1ZVbTVhaDN6cUdFMmRidWgr?=
 =?utf-8?B?SjdOYXEyM1BQekFwZXA2STBMN0VpTXVhSXJiSmtZcWVtMVFMMjhMRnpWT3Vm?=
 =?utf-8?B?S0d2RHBLV3ZoVkxCWFpiWXBKeWtMSk41SkljRy9EZWdXUVVoNDQzWklUZzY1?=
 =?utf-8?B?K1hoWmU4MThYYi9hVGtWVUZmZXFOYU9YQWZRUkFYeFBZR0VoMUlhN25Rd1RL?=
 =?utf-8?B?MmpHR3NVKytqczFXV0RmallnL1NNQlhXU0V0bmx3VlFiNWU3OHdPd0ttSHN5?=
 =?utf-8?B?d1VMZytGZmNCeHYxNE12dEVYek1lM0J4SmhSQkhLNmRrMHFGK094b1BYT2Ny?=
 =?utf-8?B?aVdtUUhtL3lYdTdoNmZLMmtMUFBaeWNzdXlxcnpyYUhSV2hNbTNpcFVRSE1T?=
 =?utf-8?B?N285bTZ6Um1qd3VQZDlGdDg1N2luN0Q1aXk4STFSaExjcXBZSU1vVnJwWkpG?=
 =?utf-8?Q?dVa5TCH8guqbvusj8tCvLBgt9mBpRGCO?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnV6b29oOE8yM0xKM0hBY1BreDdidXhxYzdqQm1BMU1uNVhRYmU0dDRVaC9P?=
 =?utf-8?B?K1RDWXZrOHJuZ2NnakJpYkZiQTZSTThUaklFa29Eb2QxWmR3eVEvMnd2Z1pr?=
 =?utf-8?B?QzRSOU9GaFJWUzlUWisvYkQ2WnpnWHplWTAySkJGMzJsSE5Nd0w4anBJRFJx?=
 =?utf-8?B?MUovaEVrOEthWENzR0hBU0ZBeEMxVDkxbnl3bHBob2lnN3lpa1hueXZXKzBF?=
 =?utf-8?B?ZXA4d0QxM2hDbUI4WDlPQzB1K1cyQTVKTE5KcGQ5VDdCNDJWVEIxZG5iWCtI?=
 =?utf-8?B?MXBnMURyQ0FFQkhxV2l4ejRtcnJlcDNrNzF2ZXpuWllpdjBvdUJCTmc5Vi9k?=
 =?utf-8?B?SEZ0VWRHMTVtMTFuZk5SMVBhNUNENlFwUTV2MUx6ZWZUU3NzaVlmaHFxWVFB?=
 =?utf-8?B?UEZhNG41WDBQZjQ3enkvNVRnWTVKVFZ0Z3pWUHhKSTdQclZuOXpkMEp3aWpa?=
 =?utf-8?B?VWpacDZJTW93VWVWNSs3QVNFTVNqV0IvVENoSm03R2JsNmVZUW1HN1poSndL?=
 =?utf-8?B?MmxhR0RpdFpuNEp1cm5nNUYrazNjNU5wTFR1UXdhcS96N0gxZjlFVFdwUmpZ?=
 =?utf-8?B?ZmUvQktOMUFXTkF3Zkx3SVZXMEw5aVJObU1JUGxkREdEZUJ5UTAwc0p1VE44?=
 =?utf-8?B?ZTc1a1hBSHZBUDhLS2srMzlIbUZ2Ynhtb2ZrcXAveWRNRFBndnFTTUZ6R0l4?=
 =?utf-8?B?VTRSa2xtM29FT1gvUkt5VW1aOTcyM0FhcGk3UjBJR3NSYklHN0tDNG5JbjRL?=
 =?utf-8?B?WlMxWTRld2tuMG51U2VaS011bVJCNnYzekt2SFNnNWlvR2VzUmp0ZEVmd2Vw?=
 =?utf-8?B?dEFKT0M4NTJXYWxTRGRzK09YTmk5RzNwVUFBd2ZwOXRyaGhncnlWK2RvckJU?=
 =?utf-8?B?bFJCQUxYNU1PU2R2SUFiV3I5NFBCRFFrZlNwQlpQWUN1bTlOdnFRSVc3cHpj?=
 =?utf-8?B?dkMyNENseWFXT01oVzNDM2l6ZXpQSUE2TlR3NHhHeWpuNE5aeEkzODd6QURZ?=
 =?utf-8?B?cEZMNEZibVpxSTFJL2tCOWVGLzFSMFR2eXNoZkNsVFZ1V0owVTQ0c04xL0ly?=
 =?utf-8?B?YnRITERxSU5KR2JnYUpEUjZNWGlQek03dW94dzM5R0xIa2RhMjFWRGhUd0lE?=
 =?utf-8?B?TTQ3Z2VHWW5SNm1JUjlTMUJteUV1Q1pBODBNWWUzejZnbUFYSEdqV25idEpy?=
 =?utf-8?B?RlQ4SHoyRFNDNkt0TkpzWTR6UUpCSmlsTmFoUEx4ZzFHZTRTS1c2UXphcWJP?=
 =?utf-8?B?VzRteXB1Y0QxdHNzRGN6aWJadDBNaExUeFJjbTRKRXRVeXN5NmxMWXpVY1NS?=
 =?utf-8?B?UVJSVEZ5aldjL3FPR1VYbzFtNW5rK05MdFBEZDZlOGdQR0sralp6d1pCdlg1?=
 =?utf-8?B?Vk9sMVU3a0RQRExRVVpMVkRrUGFjV0Zidm5pRDdqZUpSTGFsaWFTQ3cwTFY2?=
 =?utf-8?B?OTA5QmtNVE1xeFZGdXh1cDkveTNHMFJxNFJIdC85d0JPL3NmT0pnb0xHVlJX?=
 =?utf-8?B?ODVRNVllVVd4V3FoRXZIMmxpaG5hVXkwb2FHdkN0cUxIaHNIVXhOVXNqRjMr?=
 =?utf-8?B?SEYzeTFZOWdmU2dvTkhmSlJwclVic0MzSzFScjdON0YwK3IwVzdVelJhSVlQ?=
 =?utf-8?B?ODJwNTVVcG9SdlN0MVI3bWQ3RzJDUXJqQTF5RVhmRDlBcmRuSnYyazdlNzJq?=
 =?utf-8?B?NmF0QWxXZ1RZMHdTbFRQdTFTWDdVUlI3cU5uQVVNbTVOd2lDK01mTEdpUmtN?=
 =?utf-8?B?TTQ1UytvQ05rYU9VNjFNMDNyZlV5VzFJNTlNYXVXMFBrSEd6R014K1NFVFdU?=
 =?utf-8?B?TXZnN2pvYmExU0g5c3hiKzlVM3ZSa201T1NGcElRMjN1Q2JxM0E2Ry9QbHV4?=
 =?utf-8?B?MlBocXdKT1VHNW1sSTJNemdZaWZvMzJhU0ROTng3anZESDVCM1dJbjFpQ1Ez?=
 =?utf-8?B?VGFTeUZwTStyTFZqejJnRXpLSFkyWGVJZTN4amZFd0JrYUZ2TGhIQVE1bkFR?=
 =?utf-8?B?UW1kdGI3dFRnT0xsNTR5OHpoRkZncXd3ODhaU2U0VWRFOVZIUGFZY2Jsbkxs?=
 =?utf-8?B?RnAyVDV5clMvU1FZWGh5ZUVrNkxkZVZoSUx3SjhHVVdjQnltYStXdTl2TTB4?=
 =?utf-8?B?TnBQS2dRK2ZvRnQ0YTgwak05eG00eEd4d1dnRGhDZExhb0c1WnY0S01XenZv?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CB5AEF219D40D47B0AA538753B7626C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a7b1a0-7bda-4ea2-6874-08dd2eca512f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 03:21:03.6512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qczFPK5hVYFMQ9GZSNIqD+ie82RePDLit2fmyXmGHUEjhqu5UnnoTDTQ/gbBvrFK2CbXeBnX15vW+xxBJLfTnrDBBEwAqsioj4BUyPUEMhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8745

T24gTW9uLCAyMDI1LTAxLTA2IGF0IDIxOjQ2ICswNTMwLCBNYW5pdmFubmFuIFNhZGhhc2l2YW0g
d3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gT24gRnJpLCBKYW4gMDMsIDIwMjUgYXQgMDI6MDA6MTRQ
TSArMDgwMCwgSmlhbmp1biBXYW5nIHdyb3RlOg0KPiA+IFRoZXJlIGFyZSBzb21lIGNpcmN1bXN0
YW5jZXMgd2hlcmUgdGhlIEVQIGRldmljZSB3aWxsIG5vdCByZXNwb25kDQo+ID4gdG8NCj4gPiBu
b24tcG9zdGVkIGFjY2VzcyBmcm9tIHRoZSByb290IHBvcnQgKGUuZy4sIE1NSU8gcmVhZCkuIElu
IHN1Y2gNCj4gPiBjYXNlcywNCj4gPiB0aGUgcm9vdCBwb3J0IHdpbGwgcmVwbHkgd2l0aCBhbiBB
WEkgc2xhdmUgZXJyb3IsIHdoaWNoIHdpbGwgYmUNCj4gPiB0cmVhdGVkDQo+IA0KPiBCeSAncmVw
bHkgd2l0aCBhbiBBWEkgc2xhdmUgZXJyb3InLCB5b3UgbWVhbnQgdGhhdCB0aGUgcm9vdCBwb3J0
DQo+IHJlc3BvbmRzIHRvIHRoZQ0KPiBNTUlPIHJlYWQgYnkgdGhlIENQVSB3aXRoIEFYSSBzbGF2
ZSBlcnJvcj8gSWYgc28sIHBsZWFzZSByZXdvcmQgaXQgYXMNCj4gc3VjaCB0bw0KPiBhdm9pZCBj
b25mdXNpb24uDQoNClllcywgSSdsbCBmaXggaXQgaW4gdGhlIG5leHQgdmVyc2lvbiwgdGhhbmtz
Lg0KDQo+IA0KPiA+IGFzIGEgU3lzdGVtIEVycm9yIChTRXJyb3IpLCBjYXVzaW5nIGEga2VybmVs
IHBhbmljIGFuZCBwcmV2ZW50aW5nDQo+ID4gdXMNCj4gPiBmcm9tIG9idGFpbmluZyBhbnkgdXNl
ZnVsIGluZm9ybWF0aW9uIGZvciBmdXJ0aGVyIGRlYnVnZ2luZy4NCj4gPiANCj4gPiBXZSBoYXZl
IGFkZGVkIGEgbmV3IGJpdCBpbiB0aGUgUENJRV9BWElfSUZfQ1RSTF9SRUcgcmVnaXN0ZXIgdG8N
Cj4gPiBwcmV2ZW50DQo+ID4gUENJZSBBWEkwIGZyb20gcmVwbHlpbmcgd2l0aCBhIHNsYXZlIGVy
cm9yLiBTZXR0aW5nIHRoaXMgYml0IG9uIGFuDQo+ID4gb2xkZXINCj4gPiBwbGF0Zm9ybSB0aGF0
IGRvZXMgbm90IHN1cHBvcnQgdGhpcyBmZWF0dXJlIHdpbGwgaGF2ZSBubyBlZmZlY3QuDQo+ID4g
DQo+IA0KPiBCdXQgdGhlIGlzc3VlIGlzIHN0aWxsIHByZXNlbnQgb24gdGhlIG9sZGVyIFNvQ3Ms
IGlzbid0IGl0PyBJZiBzbywNCj4gcGxlYXNlIGFkZA0KPiB0aGlzIGluZm8gdG8gdGhlIGNvbW1l
bnRzIGJlbG93Lg0KDQpZZXMsIG9sZGVyIFNvQ3MgZG9uJ3QgaGF2ZSB0aGlzIGZlYXR1cmUsIEkn
bGwgYWRkIHRoaXMgaW5mbyBpbiB0aGUgbmV4dA0KdmVyc2lvbi4NCg0KVGhhbmtzLg0KDQo+IA0K
PiAtIE1hbmkNCj4gDQo+ID4gQnkgcHJldmVudGluZyBBWEkwIGZyb20gcmVwbHlpbmcgd2l0aCBh
IHNsYXZlIGVycm9yLCB3ZSBjYW4ga2VlcA0KPiA+IHRoZQ0KPiA+IGtlcm5lbCBhbGl2ZSBhbmQg
ZGVidWcgdXNpbmcgdGhlIGluZm9ybWF0aW9uIGZyb20gQUVSLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEppYW5qdW4gV2FuZyA8amlhbmp1bi53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYyB8IDEyICsr
KysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2Vu
My5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+
ID4gaW5kZXggNGJkM2IzOWVlYmUyLi40OGY4M2MyZDkxZjcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gPiBAQCAtODcsNiArODcs
OSBAQA0KPiA+ICAjZGVmaW5lIFBDSUVfTE9XX1BPV0VSX0NUUkxfUkVHICAgICAgICAgICAgICAw
eDE5NA0KPiA+ICAjZGVmaW5lIFBDSUVfRk9SQ0VfRElTX0wwUyAgICAgICAgICAgQklUKDgpDQo+
ID4gDQo+ID4gKyNkZWZpbmUgUENJRV9BWElfSUZfQ1RSTF9SRUcgICAgICAgICAweDFhOA0KPiA+
ICsjZGVmaW5lIFBDSUVfQVhJMF9TTFZfUkVTUF9NQVNLICAgICAgICAgICAgICBCSVQoMTIpDQo+
ID4gKw0KPiA+ICAjZGVmaW5lIFBDSUVfUElQRTRfUElFOF9SRUcgICAgICAgICAgMHgzMzgNCj4g
PiAgI2RlZmluZSBQQ0lFX0tfRklORVRVTkVfTUFYICAgICAgICAgIEdFTk1BU0soNSwgMCkNCj4g
PiAgI2RlZmluZSBQQ0lFX0tfRklORVRVTkVfRVJSICAgICAgICAgIEdFTk1BU0soNywgNikNCj4g
PiBAQCAtNDY5LDYgKzQ3MiwxNSBAQCBzdGF0aWMgaW50IG10a19wY2llX3N0YXJ0dXBfcG9ydChz
dHJ1Y3QNCj4gPiBtdGtfZ2VuM19wY2llICpwY2llKQ0KPiA+ICAgICAgIHZhbCB8PSBQQ0lFX0ZP
UkNFX0RJU19MMFM7DQo+ID4gICAgICAgd3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5iYXNlICsg
UENJRV9MT1dfUE9XRVJfQ1RSTF9SRUcpOw0KPiA+IA0KPiA+ICsgICAgIC8qDQo+ID4gKyAgICAg
ICogUHJldmVudCBQQ0llIEFYSTAgZnJvbSByZXBseWluZyBhIHNsYXZlIGVycm9yLCBhcyBpdCB3
aWxsDQo+ID4gY2F1c2Uga2VybmVsIHBhbmljDQo+ID4gKyAgICAgICogYW5kIHByZXZlbnQgdXMg
ZnJvbSBnZXR0aW5nIHVzZWZ1bCBpbmZvcm1hdGlvbi4NCj4gPiArICAgICAgKiBLZWVwIHRoZSBr
ZXJuZWwgYWxpdmUgYW5kIGRlYnVnIHVzaW5nIHRoZSBpbmZvcm1hdGlvbiBmcm9tDQo+ID4gQUVS
Lg0KPiA+ICsgICAgICAqLw0KPiA+ICsgICAgIHZhbCA9IHJlYWRsX3JlbGF4ZWQocGNpZS0+YmFz
ZSArIFBDSUVfQVhJX0lGX0NUUkxfUkVHKTsNCj4gPiArICAgICB2YWwgfD0gUENJRV9BWEkwX1NM
Vl9SRVNQX01BU0s7DQo+ID4gKyAgICAgd3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5iYXNlICsg
UENJRV9BWElfSUZfQ1RSTF9SRUcpOw0KPiA+ICsNCj4gPiAgICAgICAvKiBEaXNhYmxlIERWRlNS
QyB2b2x0YWdlIHJlcXVlc3QgKi8NCj4gPiAgICAgICB2YWwgPSByZWFkbF9yZWxheGVkKHBjaWUt
PmJhc2UgKyBQQ0lFX01JU0NfQ1RSTF9SRUcpOw0KPiA+ICAgICAgIHZhbCB8PSBQQ0lFX0RJU0FC
TEVfRFZGU1JDX1ZMVF9SRVE7DQo+ID4gLS0NCj4gPiAyLjQ2LjANCj4gPiANCj4gDQo+IC0tDQo+
IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCj4g
DQo=


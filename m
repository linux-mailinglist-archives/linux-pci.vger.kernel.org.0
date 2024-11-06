Return-Path: <linux-pci+bounces-16103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7194D9BE0EB
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 09:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C7A1C22F99
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 08:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48BE1D5ADE;
	Wed,  6 Nov 2024 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="m2fPe6FD";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="eOHTwHq3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6773E1D416B
	for <linux-pci@vger.kernel.org>; Wed,  6 Nov 2024 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881573; cv=fail; b=RjW/mmHaDanURaVR7yaj+egB/vsIvcgurRfOQy2jkhYLmBKcsLOq9oZxmK56FUuOerPWQ7PT3NvzXbIrVZC10AfmykeX+A0uH+q4d43pczxV3VodVMZYiL9R16NxraTVs3p12P3RQmBfxNk4Ss4mZh6sa2BvT49SQ9e3CWGJhrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881573; c=relaxed/simple;
	bh=GRbQmJWoVM+IXoO2K2WOsH79ssmAAO935wjKyY1UWzw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=guyCIbXOcH0+ErYq9/FZAh/iMKvJDlYM4xJbydVsDQHlw5Iq/p6AgdMHgqTOAIgmo0gpBMDZD+BvlIYPU0gJhOHKVj6aKCqSZk4ZIsuWMpovY7r0+7k9GaWQKtBFmvvh9OeVEF7P8EnPWeD7R0Rpp4JvSv6K7Zr61qtnilitWUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=m2fPe6FD; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=eOHTwHq3; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c33db4549c1811efbd192953cf12861f-20241106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GRbQmJWoVM+IXoO2K2WOsH79ssmAAO935wjKyY1UWzw=;
	b=m2fPe6FDQXLxhwXMquCLlPqcozSpyRKSCySC7GAXMokJRIrIclAWMpNmQRovd5JbL0sAyCPOzmjkkgMqyP7ehDaY74AzFNr4IFAf+hoUG3TT6oHNG616/Ey9LhFQKzrepyB5vTtBCEJ2vRSeDVteGnY6OQ1oYjeXTdNvB0DkdG0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:499e5e6b-4623-4d7f-bd0b-60239efe25c5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:5c467e22-a4fe-4046-b5be-d3379e31a9ef,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c33db4549c1811efbd192953cf12861f-20241106
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 99308805; Wed, 06 Nov 2024 16:26:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Nov 2024 16:26:02 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Nov 2024 16:26:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPTud3rTSlR0Q8Tst+vuIVbNJ42igVF6p6B4FTHB9VZpaJUJFsG23judx8qgq/0wjp6eMFO9VTb5g2CFnIgr+G5cbu9haiF7lHupH40eb6N1peGweSE6fOcRTY40Ra/HiESjGLg21hpO2oeCm9mBj9y6DEFQ74UpkUfpMdZkSWru1HctUWWQ+FEBd9jP56GKsGBpoqFKqDLLtc3r7hyIyhmzCgrTmYHflGgxPbftaxy8o+0LzNySrb6Ddz7ngwSHGnOVBeuwRIva4OZG8XCxoAkPCGxktjKPly1dOBsvaBwwIvyrIwoQNyIWsQ9B/uU66l/Ftb0t8qtTemx0RLrW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRbQmJWoVM+IXoO2K2WOsH79ssmAAO935wjKyY1UWzw=;
 b=voX83eQQ3x5CETpdz1o3R22UkeREjTCfM0NaB+j/dgPmUKnCXnk63xb3nKy7P/7EYGMwDqg+sCitv13caw2C++BxOVGyBX5/vXNBEm9dWk4m0suOIxomyo2cJDdyh6Pc5YWbFMAqwSfEX+qDgo8wQsmQq3jbJQSZSVW0INTdx2g3Mri4CqC3EE9uryBW5R/oQ5zGoqd0OM543z4KxN/stOOXKic9mM3XN8r3EDqn1T0yCYPQayAXA79neeXTngCJduNlSTABpEloLXi2TdUig07SitRInKJXaqxioy+4LIjsYGmTbp3VdK7V7faFWTvGBaJPIefzelnx3F+3r330lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRbQmJWoVM+IXoO2K2WOsH79ssmAAO935wjKyY1UWzw=;
 b=eOHTwHq3o693++cA6cbfBNaiduw2hsTTwaVYU9FHOzJ0TDcd+N33mlxW9N8u/eBcswO0Btx3pQUNdvDRKfYXUXRJLkbbgzrAxpsnNLhHl+DPbHrMccy1Ez3dbKzsDcZbxCwLLXZQAf2TBMkClitpv6Jpm6MX0rQFtupKMwzRVNI=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by OSQPR03MB8748.apcprd03.prod.outlook.com (2603:1096:604:275::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Wed, 6 Nov
 2024 08:25:59 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%4]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 08:25:59 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"ansuelsmth@gmail.com" <ansuelsmth@gmail.com>,
	=?utf-8?B?SHVpIE1hICjpqazmhacp?= <Hui.Ma@airoha.com>, "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, Ryder Lee
	<Ryder.Lee@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, upstream <upstream@airoha.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Avoid PCIe resetting via PCIE_RSTB
 for Airoha EN7581 SoC
Thread-Topic: [PATCH v2] PCI: mediatek-gen3: Avoid PCIe resetting via
 PCIE_RSTB for Airoha EN7581 SoC
Thread-Index: AQHbLwUKxn3W3mufJ0mUHMDfaZ/NObKoaryAgAAB/4CAAYA9AA==
Date: Wed, 6 Nov 2024 08:25:59 +0000
Message-ID: <d6faf3f169c33d3c9c392c0cc4ef9efe517fdcdf.camel@mediatek.com>
References: <20241104-pcie-en7581-rst-fix-v2-1-ffe5839c76d8@kernel.org>
	 <f827f7c45094722aa3c254eda32ada157156444a.camel@mediatek.com>
	 <Zynlw7wzyeucc2iT@lore-desk>
In-Reply-To: <Zynlw7wzyeucc2iT@lore-desk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|OSQPR03MB8748:EE_
x-ms-office365-filtering-correlation-id: 1f4689e4-9771-4bc4-616e-08dcfe3ca477
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dGdhekl5SlFMT0Izd3JzR2J4L3lUVnZpbkNlcHM1VHEyYmVGa0ZUbVowMDVU?=
 =?utf-8?B?UXQvRmhQaWxVZjZxRk1qVm9hUEtjQ1FTcHBBUEtwcUVwWHU3dW5SelZYa1Jt?=
 =?utf-8?B?UHBaRVJwZUh5QWR3eUtsNXhOUmltOXJva2UwaFFBSnZ5RUhYL3R3S2JtWm9o?=
 =?utf-8?B?UzgvNjBxY3F1M3c1SWpVSlYrNyt2TW84WGMxeWxja2tNTTRxN2RlSWVRWmNi?=
 =?utf-8?B?TGdkWXRFUmhuUGFnWnRBK2xDeUNkUXJ5NWVRVWYzamlFaUxreDdabDBIUy84?=
 =?utf-8?B?RlZ5S0UrRFFmdXpFa2xSamNyOXdNQlcva2F0ZWFwVzB4TXE4M3piRU9YUnpi?=
 =?utf-8?B?K21VTU8vdzFTbUoyL0E2M1dtVy93eXJOeGdseStzc0JlMzJRWDUycVRGTERF?=
 =?utf-8?B?MklkR01Hb1pkSVZ4aGFHbVNQUFpGVlRnTHhTRjQvS0pjd3FCS1MyWW1oWW81?=
 =?utf-8?B?V044T0I3MVpZakp2MlAvQm41NlpsOGNrL3JmUVB3WkhHL3M4WWVURWt2OERO?=
 =?utf-8?B?MkI3ZTRzTlFQaGJualkrUHJwb2dSbzZtUC9WQW04SnhXUzc5b244RzFiT1pL?=
 =?utf-8?B?KzVmTFNGdnZVaytyY1MvTjRUUDRZS09vNEkzN3c4TFJjaktXOWF4a1pQM3pC?=
 =?utf-8?B?b2F2M052M0gwVm9CbmtFWDhDMXVBRnFyY29hN2xnckxMTDFOeFVQNE9Gbmpa?=
 =?utf-8?B?cEFIU3N5bEtKc3N0eG5EQ1Bic3dnZ09iVE9PQXh1anFoYjRUZnVkR2JKY3gy?=
 =?utf-8?B?dFFNVHVpNHVUb2ZsdTVQN3pJaXhQRUhxajBzNEo3VWZ1Z1RtZ1BuUjZiV1VY?=
 =?utf-8?B?ZE04eGgrczZ5Q1E0UkNvNHYvSXVGbnJHSmlaTGtmaU1uRmNDcCtnTHM3VDd0?=
 =?utf-8?B?WlFxRnZwTmtQUFJZaS9nTUlTaUlZa05qQldYNlE5dk5CY3FMNGlnZXQwb1hy?=
 =?utf-8?B?Q2J1djVJWjZ2UjRQaGNsRTV6eUwvaDIzVy81US8vTS9ZN3QxUktXUStyKyth?=
 =?utf-8?B?ZEczRzF3aTBIOUEwc1g3U056S21OaUliY3o0S3lEMmgzMTJlUXM3S0k3dmEy?=
 =?utf-8?B?YzcvL2NKVUVlMVpFQlhUWEd4WXRXN3Z0c1RqRW5HbEFCREFDT1VBcCtaUDJW?=
 =?utf-8?B?QnlIWVNhR2h4RFZySUd4c3RMeXpBZE1VczNyaE9SRkFlNG0vMmJ1TXhZU2Zm?=
 =?utf-8?B?WmxUeVlDVkR2YWVxUWhMUWNMUkVtSVdWVmdYNlhPQU1peWhNZTArYUptSytJ?=
 =?utf-8?B?VDJzSlcwNldHeG1pNVd1TjBiak13eFFlcEEzamwyYTFTeEt3MDNKMWxzS0Zl?=
 =?utf-8?B?ZHlCSSsrODNJZ25lYzBySVBaemhFNFFCUTkrWWJ0dGtRbXJodUp6WFpYZEk5?=
 =?utf-8?B?YXMvdDNwUzVEa295ZmtBWmgwRFJkWTNHd29lZ3lZbzJTM2wwU0p3V1g3ZU82?=
 =?utf-8?B?UmtnTm0vWFZ0K3VKcGtwQmprekJJY0EySkV2NkUwR0tGUXJYRldRTG5Tbnls?=
 =?utf-8?B?Q3A4cnpUWnc2eDFzSlBqanR6RU8yZUVMS0FDRDNMNXJPc1NJYU4rdE1Xdkdz?=
 =?utf-8?B?NnBFdEQ1V2JmSGdFcHZHZUVpT3NITFJGNnBlSnloWE8wRHMvUTRjRUFybW56?=
 =?utf-8?B?UjVleGZMWmtMWWRzbmxEOXo1Z2t3OUNlREErbnVVenIvNGFjclZvYzBHQjg4?=
 =?utf-8?B?T2JzNi9LaE5RV3BsTDJlbEI2enVFTkNUa1E4SUtmMXducUg1N3pjb0s4dHJs?=
 =?utf-8?B?QUpBRnVxSVRudGwzQm9qM0h4cEFoZFZMYlRoeWtCSGVXZ1JSL3hLTGgyVkRE?=
 =?utf-8?B?Y20xTnBQSWxJZW5pTWhPck5UTkdNSTlweDNhYWpIQzVqMDRSTEtmZWZESG5T?=
 =?utf-8?Q?KRJvgHt1g20OB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0NpODcvVDVPNHVtZVpzOGZRbWxkNi9DVmFCc0h2eklkaS9zcGhLSVprNnM3?=
 =?utf-8?B?TDg0L0pJbnNNREJ2ZGdiK3ZDNkNVZzg1bmVDb3ZpNGh3UXRIUzZPcnhON0ti?=
 =?utf-8?B?bE5tcTdWdVM3NkllSEwxcEowc01qelh5Q3FhNktuK1B5ZWp0Q3gzRjlHVkJM?=
 =?utf-8?B?Rkx0SjNQV2IrWkhTS1BBY05TcmZ4Skc3YUxEMk1qd1BtQ25CRm9BRlBpR0Ja?=
 =?utf-8?B?OXpyc2F2ZFllTzRZNU00c1BKK1l2eUNRTkNtYU9Ic01KVDZYeXpNcDVaekdC?=
 =?utf-8?B?OWNsTVBQd1ZJWXJ2LzBzRUZaK205ZzRKbHF0UnhNaWRhNWE2MGQ5bXRtSzRk?=
 =?utf-8?B?ck5LRGxBeEZqdVdSVEczZnBDYkNYTEhQcHFsbVFLM3FhOHdJTW1RdE41dVJU?=
 =?utf-8?B?QlZYWHdrWTdqR1E1VGo5SGNIckhKMVhSa1Q4OEJqYUVkTkg3REx4dmlwR0JW?=
 =?utf-8?B?UmwwUzFTV0NZNmhkem4wZGU3cUlQZmRtb2hRcW0rdkk2RjJWaHBxOWx5Zy9S?=
 =?utf-8?B?RkpLcForT3VzRDRwMURQc2kzZzFpQkNzYWhIaExkd09UckdFZzVMTkcyTVpp?=
 =?utf-8?B?NURlMzBmTzJTQWRrV002L3NQdS92VTJSdEg3NUlleXlIclVhWHcwRlovOUc4?=
 =?utf-8?B?VXNmYml0VUhncEpTSjdDaGszcWc2TzBoYk9hRFF0dHZEQ0ZYT2JuR2w1WjQw?=
 =?utf-8?B?eGQ4V0dqVU41VTdCenNValVlaGlOZG5GRlZUVVN1MGlsQkhreUpWbWIzRkxr?=
 =?utf-8?B?VFV6N1lodDJRWkR2US8wU2tqVVpjM0RvczI3bDMxYkgydEc2aytCQlN2RERa?=
 =?utf-8?B?dzIrWVRQNkRLb1N5S1d0VnpmMWpQVTZRZ1dYKzZ3cndCUUMvdXA3T2IvSG5N?=
 =?utf-8?B?dXpIYitUQ2QwQWs0aEt2d0VjNExNQ25vU3ZWRjAzUDhvdklHTzJOUHVoT1NI?=
 =?utf-8?B?ZnM0RkNqWVI2VlR1OEhNNExMVlhuU2hBSXlBQjNENVRQR1VmaG1pR1JGeXRN?=
 =?utf-8?B?MERMc0dWeWRuWmJsUnhiQkJES3l4UnVFWVlQVVZUTG1jOTV5SXBRNnk5Rk1G?=
 =?utf-8?B?dDhjc1dFQjg0MlJPTVZ6Z3ErNUNoMmRkTWd3Qlh3SmFYQWRvbTN6M0hPSHNQ?=
 =?utf-8?B?VWcrOG9QTC9yc1kzR1NkMWVKTjB0MXhhdzUxc3hveU13aUdNQ1lxRkVlT0FD?=
 =?utf-8?B?dExvUUJMdUkwMzA4WDJUZW1aREtYU0RzWC93RG1peHVveDByb1FQSCtOYyto?=
 =?utf-8?B?R2FnallnMEljZ0pCS2Z5a2VwbWNNbk94SGRRU2VjVHMrTmNmMTU0dnlCZkRw?=
 =?utf-8?B?SGVFT1FBQjEza2VxSjlwRGRDZnpVczVPeTNzTkhYVHRra1VYMUNidExlSkRj?=
 =?utf-8?B?VVdvdDNoWnE3Q3FZZU52TW5odTh2eCtNVW1UUlNseE52MGVKR0RjN3RkRGdI?=
 =?utf-8?B?WG1tdzJkYmczai83Zkp4QlpHUEZtNXN1a3pmQUdZZi84SDRoODhjeHdkUkZ2?=
 =?utf-8?B?eklkSjZJTlZJTThUSzcwZjUyamp5cVdSeHExS0lWV3RuTHVVMnNXVFp0anZM?=
 =?utf-8?B?MWt4VWtQb2JCZUZYUDlnSzV1RnR5WkY3cHFmSzhwTytDajZMVHlpNkRBWE9x?=
 =?utf-8?B?UVlKNDRsNmRIR2c3TGJiZXNwME1OSjhzTko3YmFBYWoxVjcrNFpvZ1ErcUdk?=
 =?utf-8?B?TWhvRSthU05ZTjhYY2ttZ01OZDh6TXk1dFJkMjRsa3hGaWt0RFdYSzF4Wlo1?=
 =?utf-8?B?N2dmV2RGTXZjb3gzUG1jblNiWUdwTUwxMmExbkNPL00wbnBieFBtY3FLRHFG?=
 =?utf-8?B?bW96MC8vaDBYMTIwVVhUWjFDb3RKUkxkME1McDUxSlJrbjI5amVjdndOWmVF?=
 =?utf-8?B?ODVoU1lvbnZVOGFDWDFmNTltY1FGV0Y4YmlpM2RCZzFiS25mUGY2cGhRWE9x?=
 =?utf-8?B?ZGdDcWRGaDhkb1pBWVJjY0lrVFMrYUQzVksxZVl5UE54NjNuY3RlUGh1UG9q?=
 =?utf-8?B?ZFZ5QzRtRUJWY0ZiVjVacHNpT0lLa3F1a0VIbnR2eGNidEltYTAzbmhkUXZG?=
 =?utf-8?B?THNvUnNhZlZnY292cE1KYll1QzBtRlBDWTZXRXlZNndaMTBRL0xpQ0IzYmEw?=
 =?utf-8?B?dmdJeGszUTZLRHN4ejBES0h0bUdaV2dUako2WmJXRStWTkxVbS80SmxGdTRQ?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2513345AB8B654FBBDBF9B8F59192D6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4689e4-9771-4bc4-616e-08dcfe3ca477
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 08:25:59.0289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIpjfrMum1cB9IKocdknTPxGdU0pFNaawVxZRcoVHOnGtpLhm16DQOSa9YuHNmXOxkNJdDulJKO3IgqilhbqhYLLn7xZKXZ82niU/BKy9kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8748

T24gVHVlLCAyMDI0LTExLTA1IGF0IDEwOjMwICswMTAwLCBsb3JlbnpvQGtlcm5lbC5vcmcgd3Jv
dGU6DQo+ID4gT24gTW9uLCAyMDI0LTExLTA0IGF0IDIzOjAwICswMTAwLCBMb3JlbnpvIEJpYW5j
b25pIHdyb3RlOg0KPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4gPiA+IHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJp
ZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IEFp
cm9oYSBFTjc1ODEgaGFzIGEgaHcgYnVnIGFzc2VydGluZy9yZWxlYXNpbmcgUENJRV9QRV9SU1RC
DQo+ID4gPiBzaWduYWwNCj4gPiA+IGNhdXNpbmcgb2NjYXNpb25hbCBQQ0llIGxpbmsgZG93biBp
c3N1ZXMuIEluIG9yZGVyIHRvIG92ZXJjb21lDQo+ID4gPiB0aGUNCj4gPiA+IHByb2JsZW0sIFBD
SUVfUlNUQiBzaWduYWxzIGFyZSBub3QgYXNzZXJ0ZWQvcmVsZWFzZWQgZHVyaW5nDQo+ID4gPiBk
ZXZpY2UNCj4gPiA+IHByb2JlIG9yDQo+ID4gPiBzdXNwZW5kL3Jlc3VtZSBwaGFzZSBhbmQgdGhl
IFBDSWUgYmxvY2sgaXMgcmVzZXQgdXNpbmcNCj4gPiA+IFJFR19QQ0lfQ09OVFJPTA0KPiA+ID4g
KDB4ODgpIGFuZCBSRUdfUkVTRVRfQ09OVFJPTCAoMHg4MzQpIHJlZ2lzdGVycyBhdmFpbGFibGUg
dmlhIHRoZQ0KPiA+ID4gY2xvY2sNCj4gPiA+IG1vZHVsZS4NCj4gPiA+IEludHJvZHVjZSBmbGFn
cyBmaWVsZCBpbiB0aGUgbXRrX2dlbjNfcGNpZV9wZGF0YSBzdHJ1Y3QgaW4gb3JkZXINCj4gPiA+
IHRvDQo+ID4gPiBzcGVjaWZ5IHBlci1Tb0MgY2FwYWJpbGl0aWVzLg0KPiA+ID4gDQo+ID4gPiBU
ZXN0ZWQtYnk6IEh1aSBNYSA8aHVpLm1hQGFpcm9oYS5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBMb3JlbnpvIEJpYW5jb25pIDxsb3JlbnpvQGtlcm5lbC5vcmc+DQo+ID4gPiAtLS0NCj4gPiA+
IENoYW5nZXMgaW4gdjI6DQo+ID4gPiAtIGludHJvZHVjZSBmbGFncyBmaWVsZCBpbiBtdGtfZ2Vu
M19wY2llX2ZsYWdzIHN0cnVjdCBpbnN0ZWFkIG9mDQo+ID4gPiBhZGRpbmcNCj4gPiA+ICAgcmVz
ZXQgY2FsbGJhY2sNCj4gPiA+IC0gZml4IHRoZSBsZWZ0b3ZlciBjYXNlIGluIG10a19wY2llX3N1
c3BlbmRfbm9pcnEgcm91dGluZQ0KPiA+ID4gLSBhZGQgbW9yZSBjb21tZW50cw0KPiA+ID4gLSBM
aW5rIHRvIHYxOiANCj4gPiA+IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDkyMC1w
Y2llLWVuNzU4MS1yc3QtZml4LXYxLTEtMTA0M2ZiNjNmZmM5QGtlcm5lbC5vcmcNCj4gPiA+IC0t
LQ0KPiA+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMgfCA1
OQ0KPiA+ID4gKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+
ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gPiA+
IGluZGV4DQo+ID4gPiA2NmNlNGI1ZDMwOWJiNmQ2NDYxOGM3MGFjNWUwYTUyOWUwOTEwNTExLi44
ZTQ3MDRmZjM1MDk4NjdmYzBmZjc5OQ0KPiA+ID4gZTlmYg0KPiA+ID4gOTllNzFlNDY3NTZjZCAx
MDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1n
ZW4zLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1n
ZW4zLmMNCj4gPiA+IEBAIC0xMjUsMTAgKzEyNSwxOCBAQA0KPiA+ID4gDQo+ID4gPiAgc3RydWN0
IG10a19nZW4zX3BjaWU7DQo+ID4gPiANCj4gPiA+ICtlbnVtIG10a19nZW4zX3BjaWVfZmxhZ3Mg
ew0KPiA+ID4gKyAgICAgICBTS0lQX1BDSUVfUlNUQiAgPSBCSVQoMCksIC8qIHNraXAgUENJRV9S
U1RCIHNpZ25hbHMNCj4gPiA+IGNvbmZpZ3VyYXRpb24NCj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKiBkdXJpbmcgZGV2aWNlIHByb2Jpbmcgb3INCj4gPiA+IHN1c3Bl
bmQvcmVzdW1lDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogcGhh
c2UgaW4gb3JkZXIgdG8gYXZvaWQgaHcNCj4gPiA+IGJ1Z3MvaXNzdWVzLg0KPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLw0KPiA+ID4gK307DQo+ID4gPiArDQo+ID4g
PiAgLyoqDQo+ID4gPiAgICogc3RydWN0IG10a19nZW4zX3BjaWVfcGRhdGEgLSBkaWZmZXJlbnRp
YXRlIGJldHdlZW4gaG9zdA0KPiA+ID4gZ2VuZXJhdGlvbnMNCj4gPiA+ICAgKiBAcG93ZXJfdXA6
IHBjaWUgcG93ZXJfdXAgY2FsbGJhY2sNCj4gPiA+ICAgKiBAcGh5X3Jlc2V0czogcGh5IHJlc2V0
IGxpbmVzIFNvQyBkYXRhLg0KPiA+ID4gKyAqIEBmbGFnczogcGNpZSBkZXZpY2UgZmxhZ3MuDQo+
ID4gPiAgICovDQo+ID4gPiAgc3RydWN0IG10a19nZW4zX3BjaWVfcGRhdGEgew0KPiA+ID4gICAg
ICAgICBpbnQgKCpwb3dlcl91cCkoc3RydWN0IG10a19nZW4zX3BjaWUgKnBjaWUpOw0KPiA+ID4g
QEAgLTEzNiw2ICsxNDQsNyBAQCBzdHJ1Y3QgbXRrX2dlbjNfcGNpZV9wZGF0YSB7DQo+ID4gPiAg
ICAgICAgICAgICAgICAgY29uc3QgY2hhciAqaWRbTUFYX05VTV9QSFlfUkVTRVRTXTsNCj4gPiA+
ICAgICAgICAgICAgICAgICBpbnQgbnVtX3Jlc2V0czsNCj4gPiA+ICAgICAgICAgfSBwaHlfcmVz
ZXRzOw0KPiA+ID4gKyAgICAgICB1MzIgZmxhZ3M7DQo+ID4gPiAgfTsNCj4gPiA+IA0KPiA+ID4g
IC8qKg0KPiA+ID4gQEAgLTQwMiwyMiArNDExLDMzIEBAIHN0YXRpYyBpbnQgbXRrX3BjaWVfc3Rh
cnR1cF9wb3J0KHN0cnVjdA0KPiA+ID4gbXRrX2dlbjNfcGNpZSAqcGNpZSkNCj4gPiA+ICAgICAg
ICAgdmFsIHw9IFBDSUVfRElTQUJMRV9EVkZTUkNfVkxUX1JFUTsNCj4gPiA+ICAgICAgICAgd3Jp
dGVsX3JlbGF4ZWQodmFsLCBwY2llLT5iYXNlICsgUENJRV9NSVNDX0NUUkxfUkVHKTsNCj4gPiA+
IA0KPiA+ID4gLSAgICAgICAvKiBBc3NlcnQgYWxsIHJlc2V0IHNpZ25hbHMgKi8NCj4gPiA+IC0g
ICAgICAgdmFsID0gcmVhZGxfcmVsYXhlZChwY2llLT5iYXNlICsgUENJRV9SU1RfQ1RSTF9SRUcp
Ow0KPiA+ID4gLSAgICAgICB2YWwgfD0gUENJRV9NQUNfUlNUQiB8IFBDSUVfUEhZX1JTVEIgfCBQ
Q0lFX0JSR19SU1RCIHwNCj4gPiA+IFBDSUVfUEVfUlNUQjsNCj4gPiA+IC0gICAgICAgd3JpdGVs
X3JlbGF4ZWQodmFsLCBwY2llLT5iYXNlICsgUENJRV9SU1RfQ1RSTF9SRUcpOw0KPiA+ID4gLQ0K
PiA+ID4gICAgICAgICAvKg0KPiA+ID4gLSAgICAgICAgKiBEZXNjcmliZWQgaW4gUENJZSBDRU0g
c3BlY2lmaWNhdGlvbiBzZWN0aW9ucyAyLjINCj4gPiA+IChQRVJTVCMNCj4gPiA+IFNpZ25hbCkN
Cj4gPiA+IC0gICAgICAgICogYW5kIDIuMi4xIChJbml0aWFsIFBvd2VyLVVwIChHMyB0byBTMCkp
Lg0KPiA+ID4gLSAgICAgICAgKiBUaGUgZGVhc3NlcnRpb24gb2YgUEVSU1QjIHNob3VsZCBiZSBk
ZWxheWVkIDEwMG1zDQo+ID4gPiAoVFBWUEVSTCkNCj4gPiA+IC0gICAgICAgICogZm9yIHRoZSBw
b3dlciBhbmQgY2xvY2sgdG8gYmVjb21lIHN0YWJsZS4NCj4gPiA+ICsgICAgICAgICogQWlyb2hh
IEVONzU4MSBoYXMgYSBodyBidWcgYXNzZXJ0aW5nL3JlbGVhc2luZw0KPiA+ID4gUENJRV9QRV9S
U1RCIHNpZ25hbA0KPiA+ID4gKyAgICAgICAgKiBjYXVzaW5nIG9jY2FzaW9uYWwgUENJZSBsaW5r
IGRvd24uIEluIG9yZGVyIHRvDQo+ID4gPiBvdmVyY29tZQ0KPiA+ID4gdGhlIGlzc3VlLA0KPiA+
ID4gKyAgICAgICAgKiBQQ0lFX1JTVEIgc2lnbmFscyBhcmUgbm90IGFzc2VydGVkL3JlbGVhc2Vk
IGF0IHRoaXMNCj4gPiA+IHN0YWdlDQo+ID4gPiBhbmQgdGhlDQo+ID4gPiArICAgICAgICAqIFBD
SWUgYmxvY2sgaXMgcmVzZXQgdXNpbmcgUkVHX1BDSV9DT05UUk9MICgweDg4KSBhbmQNCj4gPiA+
ICsgICAgICAgICogUkVHX1JFU0VUX0NPTlRST0wgKDB4ODM0KSByZWdpc3RlcnMgYXZhaWxhYmxl
IHZpYSB0aGUNCj4gPiA+IGNsb2NrIG1vZHVsZS4NCj4gPiA+ICAgICAgICAgICovDQo+ID4gPiAt
ICAgICAgIG1zbGVlcCgxMDApOw0KPiA+ID4gLQ0KPiA+ID4gLSAgICAgICAvKiBEZS1hc3NlcnQg
cmVzZXQgc2lnbmFscyAqLw0KPiA+ID4gLSAgICAgICB2YWwgJj0gfihQQ0lFX01BQ19SU1RCIHwg
UENJRV9QSFlfUlNUQiB8IFBDSUVfQlJHX1JTVEIgfA0KPiA+ID4gUENJRV9QRV9SU1RCKTsNCj4g
PiA+IC0gICAgICAgd3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5iYXNlICsgUENJRV9SU1RfQ1RS
TF9SRUcpOw0KPiA+IA0KPiA+IFdoYXQgd2lsbCBoYXBwZW4gaWYgdGhlIEVONzU4MSB1c2UgdGhp
cyByZXNldCBmbG93PyBXaWxsIGl0IHN0aWxsDQo+ID4gd29yaw0KPiA+IGFmdGVyIHRoaXMgbGlu
ayBkb3duPw0KPiANCj4gSGkgSmlhbmp1biBXYW5nLA0KPiANCj4gVGhpcyBoYXMgYmVlbiBkZXNj
cmliZWQgaGVyZSBieSBIdWkgTWE6DQo+IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0
MDkyMC1wY2llLWVuNzU4MS1yc3QtZml4LXYxLTEtMTA0M2ZiNjNmZmM5QGtlcm5lbC5vcmcNCj4g
DQo+IFNldHRpbmcgUENJRV9QRV9SU1RCIGJpdCBvbiBFTjc1ODEgU29DIGR1cmluZyByZXNldCB0
cmlnZ2Vycw0KPiBvY2Nhc2lvbmFsIFBDSWUgbGluaw0KPiBkb3duIGlzc3VlcyBjYXVzZWQgYnkg
YSBodyBwcm9ibGVtLg0KDQpIaSBMb3JlbnpvLA0KDQpJJ20gd29uZGVyaW5nIGlmIHdlIGNhbiBp
Z25vcmUgdGhlIHByZXZpb3VzIHJlc2V0IGFuZCB0YWtlIHRoaXMgb25lIGFzDQp0aGUgaW5pdGlh
bCByZXNldD8NCg0KVGhhbmtzLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBMb3JlbnpvDQo+IA0KPiA+
IA0KPiA+ID4gKyAgICAgICBpZiAoIShwY2llLT5zb2MtPmZsYWdzICYgU0tJUF9QQ0lFX1JTVEIp
KSB7DQo+ID4gPiArICAgICAgICAgICAgICAgLyogQXNzZXJ0IGFsbCByZXNldCBzaWduYWxzICov
DQo+ID4gPiArICAgICAgICAgICAgICAgdmFsID0gcmVhZGxfcmVsYXhlZChwY2llLT5iYXNlICsN
Cj4gPiA+IFBDSUVfUlNUX0NUUkxfUkVHKTsNCj4gPiA+ICsgICAgICAgICAgICAgICB2YWwgfD0g
UENJRV9NQUNfUlNUQiB8IFBDSUVfUEhZX1JTVEIgfA0KPiA+ID4gUENJRV9CUkdfUlNUQg0KPiA+
ID4gPiANCj4gPiA+IA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICBQQ0lFX1BFX1JTVEI7
DQo+ID4gPiArICAgICAgICAgICAgICAgd3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5iYXNlICsN
Cj4gPiA+IFBDSUVfUlNUX0NUUkxfUkVHKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgICAgICAg
ICAvKg0KPiA+ID4gKyAgICAgICAgICAgICAgICAqIERlc2NyaWJlZCBpbiBQQ0llIENFTSBzcGVj
aWZpY2F0aW9uIHNlY3Rpb25zDQo+ID4gPiAyLjINCj4gPiA+IChQRVJTVCMgU2lnbmFsKQ0KPiA+
ID4gKyAgICAgICAgICAgICAgICAqIGFuZCAyLjIuMSAoSW5pdGlhbCBQb3dlci1VcCAoRzMgdG8g
UzApKS4NCj4gPiA+ICsgICAgICAgICAgICAgICAgKiBUaGUgZGVhc3NlcnRpb24gb2YgUEVSU1Qj
IHNob3VsZCBiZSBkZWxheWVkDQo+ID4gPiAxMDBtcw0KPiA+ID4gKFRQVlBFUkwpDQo+ID4gPiAr
ICAgICAgICAgICAgICAgICogZm9yIHRoZSBwb3dlciBhbmQgY2xvY2sgdG8gYmVjb21lIHN0YWJs
ZS4NCj4gPiA+ICsgICAgICAgICAgICAgICAgKi8NCj4gPiA+ICsgICAgICAgICAgICAgICBtc2xl
ZXAoUENJRV9UX1BWUEVSTF9NUyk7DQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgICAgICAgLyog
RGUtYXNzZXJ0IHJlc2V0IHNpZ25hbHMgKi8NCj4gPiA+ICsgICAgICAgICAgICAgICB2YWwgJj0g
fihQQ0lFX01BQ19SU1RCIHwgUENJRV9QSFlfUlNUQiB8DQo+ID4gPiBQQ0lFX0JSR19SU1RCIHwN
Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBQQ0lFX1BFX1JTVEIpOw0KPiA+ID4gKyAg
ICAgICAgICAgICAgIHdyaXRlbF9yZWxheGVkKHZhbCwgcGNpZS0+YmFzZSArDQo+ID4gPiBQQ0lF
X1JTVF9DVFJMX1JFRyk7DQo+ID4gPiArICAgICAgIH0NCj4gPiA+IA0KPiA+ID4gICAgICAgICAv
KiBDaGVjayBpZiB0aGUgbGluayBpcyB1cCBvciBub3QgKi8NCj4gPiA+ICAgICAgICAgZXJyID0g
cmVhZGxfcG9sbF90aW1lb3V0KHBjaWUtPmJhc2UgKw0KPiA+ID4gUENJRV9MSU5LX1NUQVRVU19S
RUcsDQo+ID4gPiB2YWwsDQo+ID4gPiBAQCAtMTE2MCwxMCArMTE4MCwxMiBAQCBzdGF0aWMgaW50
IG10a19wY2llX3N1c3BlbmRfbm9pcnEoc3RydWN0DQo+ID4gPiBkZXZpY2UgKmRldikNCj4gPiA+
ICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+ID4gICAgICAgICB9DQo+ID4gPiANCj4g
PiA+IC0gICAgICAgLyogUHVsbCBkb3duIHRoZSBQRVJTVCMgcGluICovDQo+ID4gPiAtICAgICAg
IHZhbCA9IHJlYWRsX3JlbGF4ZWQocGNpZS0+YmFzZSArIFBDSUVfUlNUX0NUUkxfUkVHKTsNCj4g
PiA+IC0gICAgICAgdmFsIHw9IFBDSUVfUEVfUlNUQjsNCj4gPiA+IC0gICAgICAgd3JpdGVsX3Jl
bGF4ZWQodmFsLCBwY2llLT5iYXNlICsgUENJRV9SU1RfQ1RSTF9SRUcpOw0KPiA+ID4gKyAgICAg
ICBpZiAoIShwY2llLT5zb2MtPmZsYWdzICYgU0tJUF9QQ0lFX1JTVEIpKSB7DQo+ID4gPiArICAg
ICAgICAgICAgICAgLyogUHVsbCBkb3duIHRoZSBQRVJTVCMgcGluICovDQo+ID4gPiArICAgICAg
ICAgICAgICAgdmFsID0gcmVhZGxfcmVsYXhlZChwY2llLT5iYXNlICsNCj4gPiA+IFBDSUVfUlNU
X0NUUkxfUkVHKTsNCj4gPiA+ICsgICAgICAgICAgICAgICB2YWwgfD0gUENJRV9QRV9SU1RCOw0K
PiA+ID4gKyAgICAgICAgICAgICAgIHdyaXRlbF9yZWxheGVkKHZhbCwgcGNpZS0+YmFzZSArDQo+
ID4gPiBQQ0lFX1JTVF9DVFJMX1JFRyk7DQo+ID4gPiArICAgICAgIH0NCj4gPiA+IA0KPiA+ID4g
ICAgICAgICBkZXZfZGJnKHBjaWUtPmRldiwgImVudGVyZWQgTDIgc3RhdGVzIHN1Y2Nlc3NmdWxs
eSIpOw0KPiA+ID4gDQo+ID4gPiBAQCAtMTIxNCw2ICsxMjM2LDcgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBtdGtfZ2VuM19wY2llX3BkYXRhDQo+ID4gPiBtdGtfcGNpZV9zb2NfZW43NTgxID0gew0K
PiA+ID4gICAgICAgICAgICAgICAgIC5pZFsyXSA9ICJwaHktbGFuZTIiLA0KPiA+ID4gICAgICAg
ICAgICAgICAgIC5udW1fcmVzZXRzID0gMywNCj4gPiA+ICAgICAgICAgfSwNCj4gPiA+ICsgICAg
ICAgLmZsYWdzID0gU0tJUF9QQ0lFX1JTVEIsDQo+ID4gPiAgfTsNCj4gPiA+IA0KPiA+ID4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19wY2llX29mX21hdGNoW10gPSB7DQo+
ID4gPiANCj4gPiA+IC0tLQ0KPiA+ID4gYmFzZS1jb21taXQ6IDMxMDJjZTEwZjMxMTFlNGMzYjhm
YjIzM2RjOTNmMjllMjIwYWRhZjcNCj4gPiA+IGNoYW5nZS1pZDogMjAyNDA5MjAtcGNpZS1lbjc1
ODEtcnN0LWZpeC04MTYxNjU4YzEzYzQNCj4gPiA+IA0KPiA+ID4gQmVzdCByZWdhcmRzLA0KPiA+
ID4gLS0NCj4gPiA+IExvcmVuem8gQmlhbmNvbmkgPGxvcmVuem9Aa2VybmVsLm9yZz4NCj4gPiA+
IA0KPiA+ID4gDQo=


Return-Path: <linux-pci+bounces-4650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3839787612A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 10:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3061C208BD
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 09:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF0B5339B;
	Fri,  8 Mar 2024 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f3JzIYP2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="B/9K26RN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA43BBDE;
	Fri,  8 Mar 2024 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891078; cv=fail; b=hLfH5KuYWnbgXfe/w0/eLVHnWV/odiKpOaBjMD25c7+n6fD/3TBTmWmZ7ZJerw2/JQoZfHRpkg+lxRHaquMjjb0XWZMJzhWmYG0MH2lzxLTmcCP+TvxrGaVxodyc9l8FsC86ryvCQEz2KV2pXaqtrGKVCUufZZhP4BwYyRqxU1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891078; c=relaxed/simple;
	bh=rKtz6OprJfM7k9OCV2lT/mdm5L3gjujrkr9FNhHBIjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LIbnLrOTvzDR0N75k3bRScRFiuQqqFVw6XOoux8uhpmD3SZiiXn4G0ECMts0LLMF39lQX0HIbdK9zCd68CgNsvSVmG9X70iu4Q2+16d5iIEYTFebU2dluzAyaMyeaElxKUrCjgY8GOiE3uD7s4k7ox02ekNmb++yRPjkIoxwCAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f3JzIYP2; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=B/9K26RN; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 73d44088dd3011eeb8927bc1f75efef4-20240308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=rKtz6OprJfM7k9OCV2lT/mdm5L3gjujrkr9FNhHBIjg=;
	b=f3JzIYP2XanY8MKEa87IyLUQkyLjzGA0hUBskL4/azcEGPV2BDXc4hHaT/WRbr2YJ0P0Et+ctCZi9z7cPfv6e7FMfHulD20S0ZOF6ETVNzNDWYpDPDO9nr3+/FTpfEWaRwgYqkv+qPnugWvI6eg2EAzUY1cZP2rhtBRZPozOgyk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d242dbd2-bf42-4ee5-97c7-523a99350546,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:cf90aaff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 73d44088dd3011eeb8927bc1f75efef4-20240308
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 809917359; Fri, 08 Mar 2024 17:44:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Mar 2024 17:44:25 +0800
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Mar 2024 17:44:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrl5m7C9vxaJ7Gtbd0sA/8qpIOLL9tgUM9PuKRY8xce8al3+1w4RR3EDQitoio0pKSeSA93lu/fXO+khoIHMzDZFJrh7PGWD+70bPwYMxSpMnoivYHJF6+TiZpKJNhVuEPWjgwepuaoAm9Ps4Xjuh7KVowWymJnlZVtopJa0KytWFNBREKqp7p9zAoeMEjAQs55OTvSLokA4H7kV9R+sxpi99TXGITj74+jh41Yk7k4Zt88Dcpaqip9ucEcuN73HVMYEBb695aD4nS29xCTB1mFIzpG3I3acQt1ZcvFcTFZyCTfWRoEJnOWahPZueHosEuROfmkILPm2yX7kaM7oAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKtz6OprJfM7k9OCV2lT/mdm5L3gjujrkr9FNhHBIjg=;
 b=LqMmisIWy2WruTNC8vJpxjqn6xDyYdB2xveFIK7wx0j/rBJclKPIu3cdeMDqTAaQW0vM/Ic/vX3d7hlKwNAVCj5KM7Vdq9889tWOp6rjofJx1uqepnHwi8a6b9LmUOlbgfUhxiKY2EzNc4syD43lfFXau5+uXsDKuK6CTwMf0hmj5jzKgOx6MhvWyR2m8kJ/f0ctrPQvEIcKWkp51UHzan5IZsk7dFq7BFeQkwKhmqeBxXZ7VRAlefnv9c7oAoiZJjl6ikBMHrQhalE6QZGzJOMXtt/yWeA2jfjTN68aw3qEyYUkRM30XisZ31sU3EB85CZPq0FRZ9HLIaCJyVgDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKtz6OprJfM7k9OCV2lT/mdm5L3gjujrkr9FNhHBIjg=;
 b=B/9K26RNwRPpNIFmRgG/NldmqDFhcIen5PDmnlVwyF2UbS8vZY8qBAQxGWROkVp3mJsIoB3NeTc2LbBajXym56Yak1badbh2iQirlD6ApGUdNxcok5HYiMspj2aalqbWc+8/LHOC6xLh74NvjXV8YuUvxLUC4IjNGVHGBCC6jWI=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by SEYPR03MB7190.apcprd03.prod.outlook.com (2603:1096:101:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 09:44:23 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::22dd:6695:c2ad:c4bf]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::22dd:6695:c2ad:c4bf%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 09:44:23 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
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
Thread-Index: AQHaavEyOFiHWdSs9EW2P5MBW1O/vrEiMBwAgAhAmACAAzPPAA==
Date: Fri, 8 Mar 2024 09:44:23 +0000
Message-ID: <8a5a695ccbc4401954f7df5a9690af726fc59173.camel@mediatek.com>
References: <20240229092449.580971-1-angelogioacchino.delregno@collabora.com>
	 <30824df32636dec25b9a5972b1ee8de76b295feb.camel@mediatek.com>
	 <c55f2c6e-1de8-4248-a52a-d6c9e49b565a@collabora.com>
In-Reply-To: <c55f2c6e-1de8-4248-a52a-d6c9e49b565a@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|SEYPR03MB7190:EE_
x-ms-office365-filtering-correlation-id: 389311cf-3783-4974-22a9-08dc3f545608
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y3tXyFl6PnwEjES/6BauoW3urzfOgvbKphje8zP4SRLl+6mybI9VxV/Q+cdcDxKhaM7bxTVE5c9rTBNudhIzx08Dz/6bdMg8/RyIBz42xKC7Mzn1SgSs4XM0d9ptmT9Ofk3fqw4Pzp8hs/fss9ipIiitr5iTP1Cff8eTO0RTBNcJDWheyz9bQb+joEffIOUZxhgg5doiggfaPeXCE2cKVJvpNyfK8uC+9xNpHOUyWEpe2/1jx4f9IRURJONcdmXqit/KWHgMB8tI3dLIg3+ZccZL7LLta7AKzEERtH79Jv4PhRxKqhLMgNc/zEp5jwV0Kihs9VQRsxj9AyB1URiE5obxALAx84pYGdz5w8lm00mxNf/eMqQ/XLCnfZ+WyuVlIqq+a+EL0jRMybZzOiCmPhUJDVPF7rEr1EcOLE+HstjBUxS1pI67oepNdH+pw3HdeLquwcmcJRjJtFUn5YnRl5n2pXA475FwhnjFjP/f/ioGr8G4URZAzz/bZJotHZyvD7k2plYk2oe3sYgXZvAlk9lSdAfn3bTtO+n/HpLzLfNq1bHJZnkbCDFdILQQ1q1q3ppVs4EGFb30rCkRU+MzYXgwUmiYVvRDQ81stJfiL54tc1UOQIa2534Oxfgo18fy6Kis3PPqVKq9usfu/X1yQ/ff+RTpKtzeOzsMGZcNpkxempRu/gL9Ae9vR3UN6aUKo+pjPZumb3qkaejPENyaPB+Tan2wq4dlEOVi9RGTjI8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0IrUk5QZUl5blMvZDRoZi9ZODBhMVkxc20vVktXbDg5dUcxMnlzUWUwYWNl?=
 =?utf-8?B?cXdyc1V4ODZ2dHZ0SkdVcVhhM3VLU2gxMG9TSE9QZFN2VzV4SU1Vc2JjUkMx?=
 =?utf-8?B?WVVJclh5SU1XYVlwb21Wa1FFdFhwVVZVdFVjWlU4Zk5GNUJQR3pMTytEQUFP?=
 =?utf-8?B?Y1FYclUrcG1zd3haMkh1cmpzZWRMemdDdG9OUWhLYW0xYXB0a0tOaHBNN3N0?=
 =?utf-8?B?Rmhxd0NnSDBTdUlyMmJvOU9LT29Sd1dRQ0ZFVHNFcXQxeGVGeWprZTZaTUpt?=
 =?utf-8?B?WUNPTithMGF6SGJuRzJ5djVHTk5KaDB0NDY1V2VRS3doNklRNUZmUEJvVGJs?=
 =?utf-8?B?Rk9ZOFVTMG1ReVNPZ0xQaUluUnlTTjhZZXpFTmpvWmM5cjJ3SGc2aTEvM1lK?=
 =?utf-8?B?TER0WXhqa2hhSko0dGViUXEveU9PQjhHY3ZlbDRrZUwrM3BwNDBEZlNBQWl5?=
 =?utf-8?B?dFJySFo1S2VJMkxPVWJFaHBMbFRyK2dzY0dQbkZZRE9xN2pYUTdrN2kxNmd5?=
 =?utf-8?B?Ym9HNTM0MzVKdEV1QTFZN0trYjRRd09GckM1SVg1UmdhUVFHZkhBK3BqNDU2?=
 =?utf-8?B?R0NBM2FUNEVmQ1JXcmd1dzJ2L2R3T3Y2Qkw1bzZHZXVpTmdEQ2VMUWkzbUds?=
 =?utf-8?B?TlRSK0p5THBVUURTZVhpVXFTQlFvMTVVejBVa081MzhPVTNtdHVwT3BMT1Ba?=
 =?utf-8?B?eGxMR0ZlRis1K1JuRlVtSGZYQldpeWY2NEtPTG5aN2VtclowRWdLTnpxc1dl?=
 =?utf-8?B?bEtoSTEyY1c3cFQyN2VaS0Jzd2gxckI2ZnFPU1J4azFsQ0tyazlkN3llMFJt?=
 =?utf-8?B?M1ZDQ09HNzZSakR0WGx0UmM2bUpmQkFRZldkMy8wcjZuZXhuYUZoR2czdVlt?=
 =?utf-8?B?eWVYTHIwcUcwY1R1UWpQdy9QenQwRHZuTmdJMnJwUGJpUThhMXZZcnJBUkNn?=
 =?utf-8?B?WXFQMTNrSWZ2dkNTdURjWW9ucWFVV2hMZHo4SE5Bd01Gd2drTmdiUS93WXlS?=
 =?utf-8?B?YWZxa2lUajZiS3BXbEtSMDRXcDZZRmY3c3lpbTBMa2txdGQ0UFNUSUtRSTdw?=
 =?utf-8?B?cnRZZWc4LzhlNTdZSGZyNXZiZTJmbkF5NGZrUTIxTnNyZ0lMV3hvVVlmenNX?=
 =?utf-8?B?Z1pRbjNLamo1a1N3VDdHaE5Rb1NjNjBmT29HcWphRXZnc1Z2Zk9oeTZrVmNJ?=
 =?utf-8?B?M1R1bWpid1VkaksybkxkeHpCRkE1emVZaXlKSEF6Sml3QjNFNXpldEhodWFh?=
 =?utf-8?B?Qk1Rc0ZxNFRwdk5kSHBxQTFDMVpjdmZyRlBmaUlWUllLWTFGQ1dueGtaeDBN?=
 =?utf-8?B?ZzdnV2FsZEszM2NXQjFvUkFXRzdrb2tNUkpnZnltRUp0dytTVlhMQ0VmR0pK?=
 =?utf-8?B?akovbU5ZRUUxbGdNSFBPdTlDTlZpVENWbk5KNEVxaUg2WUFQQUVrSUEvYWFp?=
 =?utf-8?B?N2lLWm1KUFQzZGNka3AvNGRzZ2hOTHcvUDc5cE4rSnN0S25tUzg1QjdQNFlV?=
 =?utf-8?B?bVlXSmdmQ0gvUXZEQjdxSEpwNFhMdStnMkFoamZidno0YXQzekxZeDhCWkVX?=
 =?utf-8?B?RXNVTG1PeExJTmc3T1B3b3BjSGlIeVV4OSt3dDVsWGZRUG5NbEd4dElOOUlJ?=
 =?utf-8?B?TEh5eGRuTm51SEJiZk5SOW9PNlh1R290K3VDdXNxeXZabkkvTWFWS1RJbk9U?=
 =?utf-8?B?dFl0Szk1RlBSSHNFZzIzellzQVR5b09kTmUraGpnOHoxaDlQSEdrZzV5VHdF?=
 =?utf-8?B?dWFWZUJrSEswUzNhL2grTzNRUDRZWmFUOGlGdWd0dUtmODFFdzA4eXM5UDB0?=
 =?utf-8?B?dkNmNmZFaUpYSEc4aGtwcW5Zd0RDdWxPOEZBbEpwbjhUV2NLNFNHRTNGZ1dI?=
 =?utf-8?B?QlN1Q1IrTWV1dTY3b0hkSWY4WnBZaFBZdkt3RFVYWHlCWGdnQ2VBZHBmSTVm?=
 =?utf-8?B?czlhaXFHYTBkRUcrVnRvSDc3RkdCdXJxelRqKzU3SFRhTVJkWXlqWUkwc1Vk?=
 =?utf-8?B?UHNuZUVibXYzWHQwMmxWbW1JVVZEK2xZd0E2ZWliYkVmTWZFNFhpb29ESVA4?=
 =?utf-8?B?NzdTNnkvRnhUbXNsYkgrZDRCdW1JK1AxU2dTTHpQOENIQjFBU1pTeWJEN3Rl?=
 =?utf-8?B?dFM3NHlnU05ZeFJpdzVCd0crc1BFUXQvOEttTXNhd25zSVV4V01laEFqaUdl?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8639FFD2660BF44B87E1F7C5CC1B0D34@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389311cf-3783-4974-22a9-08dc3f545608
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 09:44:23.2874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WsRq0TuiAmzxLxPKuhsl0/1URn2dtYD/fyZQOXY/843N/ZILrK3ebFNc5uMm+07EP8q01Ltb3dhsI5B1uuVa++pnmvXAmkxffDMYV0QuMAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7190

T24gV2VkLCAyMDI0LTAzLTA2IGF0IDA5OjUwICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDEvMDMvMjQgMDM6NDgsIEppYW5qdW4gV2FuZyAo546L5bu65Yab
KSBoYSBzY3JpdHRvOg0KPiA+IEhpIEFuZ2VsbywNCj4gPiANCj4gPiBUaGFua3MgZm9yIHlvdXIg
cGF0Y2guDQo+ID4gDQo+ID4gT24gVGh1LCAyMDI0LTAyLTI5IGF0IDEwOjI0ICswMTAwLCBBbmdl
bG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiA+IHdyb3RlOg0KPiA+ID4gU29tZSBTb0NzIGhhdmUg
dHdvIFBDSS1FeHByZXNzIGNvbnRyb2xsZXJzOiBpbiB0aGUgY2FzZSBvZg0KPiA+ID4gTVQ4MTk1
LA0KPiA+ID4gb25lIG9mIHRoZW0gaXMgdXNpbmcgYSBkZWRpY2F0ZWQgUEhZLCBidXQgdGhlIG90
aGVyIHVzZXMgYSBjb21ibw0KPiA+ID4gUEhZDQo+ID4gPiB0aGF0IGlzIHNoYXJlZCB3aXRoIFVT
QiBhbmQgaW4gdGhhdCBjYXNlIHRoZSBQSFkgY2Fubm90IGJlIHJlc2V0DQo+ID4gPiBmcm9tIHRo
ZSBQQ0llIGRyaXZlciwgb3IgVVNCIGZ1bmN0aW9uYWxpdHkgd2lsbCBiZSB1bmFibGUgdG8NCj4g
PiA+IHJlc3VtZS4NCj4gPiA+IA0KPiA+ID4gUmVzZXR0aW5nIHRoZSBQQ0llIE1BQyB3aXRob3V0
IGFsc28gcmVzZXR0aW5nIHRoZSBQSFkgd2lsbCByZXN1bHQNCj4gPiA+IGluDQo+ID4gPiBhIGZ1
bGwgc3lzdGVtIGxvY2t1cCBhdCBQQ0llIHJlc3VtZSB0aW1lIGFuZCB0aGUgb25seSBvcHRpb24g
dG8NCj4gPiA+IHJlc3VtZSBvcGVyYXRpb24gaXMgdG8gaGFyZCByZWJvb3QgdGhlIHN5c3RlbSAo
d2l0aCBhIFBNSUMgY3V0LQ0KPiA+ID4gb2ZmKS4NCj4gPiA+IA0KPiA+ID4gVG8gcmVzb2x2ZSB0
aGlzIGlzc3VlLCBjaGVjayBpZiB3ZSd2ZSBnb3QgYm90aCBhIFBIWSBhbmQgYSBNQUMNCj4gPiA+
IHJlc2V0DQo+ID4gPiBhbmQsIGlmIG5vdCwgbmV2ZXIgYXNzZXJ0IHJlc2V0cyBhdCBQTSBzdXNw
ZW5kIHRpbWU6IGluIHRoYXQNCj4gPiA+IGNhc2UsDQo+ID4gPiB0aGUgbGluayBpcyBzdGlsbCBn
ZXR0aW5nIHBvd2VyZWQgZG93biBhcyBib3RoIHRoZSBjbG9ja3MgYW5kIHRoZQ0KPiA+ID4gcG93
ZXIgZG9tYWlucyB3aWxsIGdvIGRvd24gYW55d2F5Lg0KPiA+ID4gDQo+ID4gPiBGaXhlczogZDUz
N2RjMTI1ZjA3ICgiUENJOiBtZWRpYXRlay1nZW4zOiBBZGQgc3lzdGVtIFBNIHN1cHBvcnQiKQ0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+ID4g
YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+ID4gLS0tDQo+ID4g
PiANCj4gPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gPiAgIC0gUmViYXNlZCBvdmVyIG5leHQtMjAy
NDAyMjkNCj4gPiA+IA0KPiA+ID4gICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0
ZWstZ2VuMy5jIHwgMjUNCj4gPiA+ICsrKysrKysrKysrKysrLS0tLS0NCj4gPiA+IC0tDQo+ID4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+
ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlh
dGVrLWdlbjMuYw0KPiA+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWst
Z2VuMy5jDQo+ID4gPiBpbmRleCA5NzViMzAyNGZiMDguLjk5YjVkN2E0OWJlMSAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4g
PiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4g
PiA+IEBAIC04NzQsMTcgKzg3NCwyNiBAQCBzdGF0aWMgaW50IG10a19wY2llX3Bvd2VyX3VwKHN0
cnVjdA0KPiA+ID4gbXRrX2dlbjNfcGNpZSAqcGNpZSkNCj4gPiA+ICAgCXJldHVybiBlcnI7DQo+
ID4gPiAgIH0NCj4gPiA+ICAgDQo+ID4gPiAtc3RhdGljIHZvaWQgbXRrX3BjaWVfcG93ZXJfZG93
bihzdHJ1Y3QgbXRrX2dlbjNfcGNpZSAqcGNpZSkNCj4gPiA+ICtzdGF0aWMgdm9pZCBtdGtfcGNp
ZV9wb3dlcl9kb3duKHN0cnVjdCBtdGtfZ2VuM19wY2llICpwY2llLCBib29sDQo+ID4gPiBpc19z
dXNwZW5kKQ0KPiA+ID4gICB7DQo+ID4gPiArCWJvb2wgc3VzcGVuZF9yZXNldF9zdXBwb3J0ZWQg
PSBwY2llLT5tYWNfcmVzZXQgJiYgcGNpZS0NCj4gPiA+ID4gcGh5X3Jlc2V0Ow0KPiA+ID4gDQo+
ID4gPiArDQo+ID4gPiAgIAljbGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZShwY2llLT5udW1fY2xr
cywgcGNpZS0+Y2xrcyk7DQo+ID4gPiAgIA0KPiA+ID4gICAJcG1fcnVudGltZV9wdXRfc3luYyhw
Y2llLT5kZXYpOw0KPiA+ID4gICAJcG1fcnVudGltZV9kaXNhYmxlKHBjaWUtPmRldik7DQo+ID4g
PiAtCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KHBjaWUtPm1hY19yZXNldCk7DQo+ID4gPiArDQo+ID4g
PiArCS8qDQo+ID4gPiArCSAqIEFzc2VydCBNQUMgcmVzZXQgb25seSBpZiB3ZSBhbHNvIGdvdCBh
IFBIWSByZXNldCwgb3RoZXJ3aXNlDQo+ID4gPiArCSAqIHRoZSBzeXN0ZW0gd2lsbCBsb2NrdXAg
YXQgUE0gcmVzdW1lIHRpbWUuDQo+ID4gPiArCSAqLw0KPiA+ID4gKwlpZiAoaXNfc3VzcGVuZCAm
JiBzdXNwZW5kX3Jlc2V0X3N1cHBvcnRlZCkNCj4gPiA+ICsJCXJlc2V0X2NvbnRyb2xfYXNzZXJ0
KHBjaWUtPm1hY19yZXNldCk7DQo+ID4gPiAgIA0KPiA+ID4gICAJcGh5X3Bvd2VyX29mZihwY2ll
LT5waHkpOw0KPiA+ID4gICAJcGh5X2V4aXQocGNpZS0+cGh5KTsNCj4gPiA+IC0JcmVzZXRfY29u
dHJvbF9hc3NlcnQocGNpZS0+cGh5X3Jlc2V0KTsNCj4gPiA+ICsJaWYgKGlzX3N1c3BlbmQgJiYg
c3VzcGVuZF9yZXNldF9zdXBwb3J0ZWQpDQo+ID4gPiArCQlyZXNldF9jb250cm9sX2Fzc2VydChw
Y2llLT5waHlfcmVzZXQpOw0KPiA+ID4gICB9DQo+ID4gPiAgIA0KPiA+ID4gICBzdGF0aWMgaW50
IG10a19wY2llX3NldHVwKHN0cnVjdCBtdGtfZ2VuM19wY2llICpwY2llKQ0KPiA+ID4gQEAgLTky
MCw3ICs5MjksNyBAQCBzdGF0aWMgaW50IG10a19wY2llX3NldHVwKHN0cnVjdA0KPiA+ID4gbXRr
X2dlbjNfcGNpZQ0KPiA+ID4gKnBjaWUpDQo+ID4gPiAgIAlyZXR1cm4gMDsNCj4gPiA+ICAgDQo+
ID4gPiAgIGVycl9zZXR1cDoNCj4gPiA+IC0JbXRrX3BjaWVfcG93ZXJfZG93bihwY2llKTsNCj4g
PiA+ICsJbXRrX3BjaWVfcG93ZXJfZG93bihwY2llLCBmYWxzZSk7DQo+ID4gPiAgIA0KPiA+ID4g
ICAJcmV0dXJuIGVycjsNCj4gPiA+ICAgfQ0KPiA+ID4gQEAgLTk1MSw3ICs5NjAsNyBAQCBzdGF0
aWMgaW50IG10a19wY2llX3Byb2JlKHN0cnVjdA0KPiA+ID4gcGxhdGZvcm1fZGV2aWNlDQo+ID4g
PiAqcGRldikNCj4gPiA+ICAgCWVyciA9IHBjaV9ob3N0X3Byb2JlKGhvc3QpOw0KPiA+ID4gICAJ
aWYgKGVycikgew0KPiA+ID4gICAJCW10a19wY2llX2lycV90ZWFyZG93bihwY2llKTsNCj4gPiA+
IC0JCW10a19wY2llX3Bvd2VyX2Rvd24ocGNpZSk7DQo+ID4gPiArCQltdGtfcGNpZV9wb3dlcl9k
b3duKHBjaWUsIGZhbHNlKTsNCj4gPiA+ICAgCQlyZXR1cm4gZXJyOw0KPiA+ID4gICAJfQ0KPiA+
ID4gICANCj4gPiA+IEBAIC05NjksNyArOTc4LDcgQEAgc3RhdGljIHZvaWQgbXRrX3BjaWVfcmVt
b3ZlKHN0cnVjdA0KPiA+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gICAJcGNpX3Vu
bG9ja19yZXNjYW5fcmVtb3ZlKCk7DQo+ID4gPiAgIA0KPiA+ID4gICAJbXRrX3BjaWVfaXJxX3Rl
YXJkb3duKHBjaWUpOw0KPiA+ID4gLQltdGtfcGNpZV9wb3dlcl9kb3duKHBjaWUpOw0KPiA+ID4g
KwltdGtfcGNpZV9wb3dlcl9kb3duKHBjaWUsIGZhbHNlKTsNCj4gPiANCj4gPiBJcyB0aGVyZSBh
bnkgcmVhc29uIG5vdCB0byByZXNldCB0aGUgTUFDIGFuZCBQSFkgd2hlbiBwcm9iZSBmYWlscw0K
PiA+IGFuZA0KPiA+IGRyaXZlciByZW1vdmluZz8gU29tZSBTb0NzIG1heSBub3QgaGF2ZSBNVENN
T1MgdG8gY3V0IG9mZiB0aGVpcg0KPiA+IHBvd2VyLA0KPiA+IHdlIG5lZWQgdG8gYXNzZXJ0IHRo
ZSByZXNldCBzaWduYWwgdG8gc2F2ZSBwb3dlciBpbiB0aGF0IGNhc2UuDQo+ID4gDQo+IA0KPiBT
b3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkgLSB5ZXMsIHRoZXJlIGlzIGEgcmVhc29uLg0KPiANCj4g
T24gcGxhdGZvcm1zIG5lZWRpbmcgdGhpcyBxdWlyaywgcmVzZXR0aW5nIGF0IC5yZW1vdmUoKSB0
aW1lIHdpbGwNCj4gaGFuZyB0aGUNCj4gbWFjaGluZSBpZiB0aGUgbW9kdWxlIGlzIHJlaW5zZXJ0
ZWQgbGF0ZXIgKGhlbmNlLCAucHJvYmUoKSBjYWxsZWQgYXQNCj4gYSBsYXRlcg0KPiB0aW1lKS4N
Cg0KRG9lcyB0aGlzIG9ubHkgaGFwcGVuIHdoZW4gdGhlIFBDSWUgTUFDIGlzIHJlc2V0IHdpdGhv
dXQgcmVzZXR0aW5nIHRoZQ0KUEhZPyBJcyBpdCByZWxhdGVkIHRvIHRoZSByZXNldCBmcmFtZXdv
cms/DQoNClRoYW5rcy4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCj4gPiBUaGFua3Mu
DQo+ID4gDQo+ID4gPiAgIH0NCj4gPiA+ICAgDQo+ID4gPiAgIHN0YXRpYyB2b2lkIG10a19wY2ll
X2lycV9zYXZlKHN0cnVjdCBtdGtfZ2VuM19wY2llICpwY2llKQ0KPiA+ID4gQEAgLTEwNDQsNyAr
MTA1Myw3IEBAIHN0YXRpYyBpbnQgbXRrX3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1Y3QNCj4gPiA+
IGRldmljZQ0KPiA+ID4gKmRldikNCj4gPiA+ICAgCWRldl9kYmcocGNpZS0+ZGV2LCAiZW50ZXJl
ZCBMMiBzdGF0ZXMgc3VjY2Vzc2Z1bGx5Iik7DQo+ID4gPiAgIA0KPiA+ID4gICAJbXRrX3BjaWVf
aXJxX3NhdmUocGNpZSk7DQo+ID4gPiAtCW10a19wY2llX3Bvd2VyX2Rvd24ocGNpZSk7DQo+ID4g
PiArCW10a19wY2llX3Bvd2VyX2Rvd24ocGNpZSwgdHJ1ZSk7DQo+ID4gPiAgIA0KPiA+ID4gICAJ
cmV0dXJuIDA7DQo+ID4gPiAgIH0NCj4gPiA+IEBAIC0xMDYwLDcgKzEwNjksNyBAQCBzdGF0aWMg
aW50IG10a19wY2llX3Jlc3VtZV9ub2lycShzdHJ1Y3QNCj4gPiA+IGRldmljZQ0KPiA+ID4gKmRl
dikNCj4gPiA+ICAgDQo+ID4gPiAgIAllcnIgPSBtdGtfcGNpZV9zdGFydHVwX3BvcnQocGNpZSk7
DQo+ID4gPiAgIAlpZiAoZXJyKSB7DQo+ID4gPiAtCQltdGtfcGNpZV9wb3dlcl9kb3duKHBjaWUp
Ow0KPiA+ID4gKwkJbXRrX3BjaWVfcG93ZXJfZG93bihwY2llLCBmYWxzZSk7DQo+ID4gPiAgIAkJ
cmV0dXJuIGVycjsNCj4gPiA+ICAgCX0NCj4gPiA+ICAgDQo+IA0KPiANCj4gDQo=


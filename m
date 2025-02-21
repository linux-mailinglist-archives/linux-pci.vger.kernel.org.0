Return-Path: <linux-pci+bounces-21972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5288EA3F04B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 10:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3239D17FA46
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 09:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F991D5160;
	Fri, 21 Feb 2025 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airoha.com header.i=@airoha.com header.b="tESTgZnZ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JNbQ4RS8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4C3FD4;
	Fri, 21 Feb 2025 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130259; cv=fail; b=mj9/Fe4gVynF/J3pdFFmCwUpFKgX864r0YbxxQBBJ5Vi7A/LCIKLMmjWISTiDoBAArILsC+NE0ZT4SRnwqgy2bDBwSvFX/kz5lH193Au2waOWyTjqQV9vXTectVvlev4YpEzfhTNGpeI76cs9gt6IMfu1GmA5kOxL7+s8QwjmLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130259; c=relaxed/simple;
	bh=zMUlwNleKNbcOkYl8Ty1NjjCtp717vm/KvV4z5NKo0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uLuO+4OXpXmBiQnFnT6baWMBpt8Shp2sjcnFnz1zJ0PJLNkROlBfwAK7bB5HDIWElm6J4CPdKvpGpuZ59vB3Gd/11Dxeh2mv4jG3CcejXQaxONK5SUxlQMH3yUb+i3RSmHdVdA/zVx5cCcme4mLPJi3xuZ52Wl1QBZ09ZMCSY2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com; spf=pass smtp.mailfrom=airoha.com; dkim=pass (1024-bit key) header.d=airoha.com header.i=@airoha.com header.b=tESTgZnZ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JNbQ4RS8; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airoha.com
X-UUID: 86830d26f03611ef8eb9c36241bbb6fb-20250221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=airoha.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zMUlwNleKNbcOkYl8Ty1NjjCtp717vm/KvV4z5NKo0M=;
	b=tESTgZnZHGYlL1JtPQyRPQOuIDmk5vH0JZG+ybtfmJbRt3Zeza8s75l5MDeg9RdLr5QavYszUrxZ+E2Pf/r8/pxvySCFVsb0VxifEtTkzoFhvcn0XFD/6KMEvPbeYXp5+B4H8uRMTxX+qDIpxGvZqZtZWzz8cHSA+qnejUikazs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:c8c4e56f-f668-464d-8b55-3a748269aa3e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:44602bdc-d480-4873-806f-0f365159227b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817,TC:nil,Content:-
	10|-8|-5|52,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 86830d26f03611ef8eb9c36241bbb6fb-20250221
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <hui.ma@airoha.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1842429370; Fri, 21 Feb 2025 17:30:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 21 Feb 2025 17:30:43 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 21 Feb 2025 17:30:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otSDWTFDKAAZK0UQ64otrwV0SjTBNzODuG86zku1POdJ2W2kS/Ze2DELWmD4ZiZD3/T8jmUVYesVpGoDHbLYJBVTYEFTaZNb66RfDSwHInEFhXN3tQYRw5wkWhl3cfLlT1/2oxzRD3CSPWxrzMnvlAMluHEIoJqVe/+JCBF6yOZruehp7LaNXYh0Z+HqSxcP1TORb18JcJU+DPBqyLDZ+5q5QBSEvTQ8tvAVZFrJ1jujdXVff/58phy0B9ffRNHtEdLBQT9DpZDf794COKsnhrjcQKud9O37fvYpyljJIEAJxt/pdxERjKzwmYfzhHBApMPzLLGEAshBZeuE3ghecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMUlwNleKNbcOkYl8Ty1NjjCtp717vm/KvV4z5NKo0M=;
 b=brWlknCB9d9adebAOLRhi69WFW9/eR1iDEVZBLTVOsOicNpP034SDGd8zQL4g/5n8Gyil7E6VQMvWNX+0S5ub19Evc24Ve2UuqVgE27g+bO/uqampuMLA0tD3H8bR0n9ou3rKU7W9hGoid7UBDwu6D7P+JuVDk/4fGMwqz+cjFL8uWW3WDNeMue0GqkmHqm+sZK9DSz/hfS8nfd8y4yn6JI0tsmimBwJuTPHSfUmp3x/tO9H6Fqnjf+4lwgwZoF283dn/e6chczzexrZWuJS2vFQ64oKlt9zR+mo5s9mqrcx0VPIzGcVWCqyuXqkvfO86KCulGiS15kNkt00v3LZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=airoha.com; dmarc=pass action=none header.from=airoha.com;
 dkim=pass header.d=airoha.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMUlwNleKNbcOkYl8Ty1NjjCtp717vm/KvV4z5NKo0M=;
 b=JNbQ4RS8eBfGnL8nWcf7eQybCBU6F2wHTg0OMUwb5OeMb4bVDz4CbWtxt/Yaxndox1fJogFWkX7o9pZkUZqjsH7+1BMf3YqaSpUcx4Af91Obj0cvz4jqg/J3t3CD80rrLJ4MgnGnUTS/1rpIpm3kJkeRCpFvVOyxQROZyaBalds=
Received: from SG2PR03MB6341.apcprd03.prod.outlook.com (2603:1096:4:178::8) by
 TYZPR03MB7868.apcprd03.prod.outlook.com (2603:1096:400:45f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Fri, 21 Feb 2025 09:30:41 +0000
Received: from SG2PR03MB6341.apcprd03.prod.outlook.com
 ([fe80::619e:4ef8:147a:3554]) by SG2PR03MB6341.apcprd03.prod.outlook.com
 ([fe80::619e:4ef8:147a:3554%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 09:30:40 +0000
From: =?gb2312?B?SHVpIE1hICjC7bvbKQ==?= <Hui.Ma@airoha.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
CC: Ryder Lee <Ryder.Lee@mediatek.com>,
	=?gb2312?B?Smlhbmp1biBXYW5nICjN9b2ovvwp?= <Jianjun.Wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>, "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Frank Li <Frank.li@nxp.com>, upstream
	<upstream@airoha.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyIDIvMl0gUENJOiBtZWRpYXRlay1nZW4zOiBDb25m?=
 =?gb2312?Q?igure_PBUS=5FCSR_registers_for_EN7581_SoC?=
Thread-Topic: [PATCH v2 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers
 for EN7581 SoC
Thread-Index: AQHbhEHdVTvJ6OzUdEyAK2p8UPr8trNRfEoQ
Date: Fri, 21 Feb 2025 09:30:40 +0000
Message-ID: <SG2PR03MB6341ACD4DADDB280A8ACAA29FFC72@SG2PR03MB6341.apcprd03.prod.outlook.com>
References: <Z7eIXsupArd8xH7_@lore-desk> <20250220235607.GA320302@bhelgaas>
 <Z7hFQXIrpMpH_72T@lore-desk>
In-Reply-To: <Z7hFQXIrpMpH_72T@lore-desk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=airoha.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6341:EE_|TYZPR03MB7868:EE_
x-ms-office365-filtering-correlation-id: 0bcc28e9-afdd-45a6-0017-08dd525a6870
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?gb2312?B?UFlRUjhQN1ZDRldpQTNTbFdMSm1Nd29mV0Y0WVlLOSswMXE1cWhXcDZ1alVx?=
 =?gb2312?B?VldGUC90aHNmYzhyUGdRYTE4TVcxd1YxSFZrcUFTY0dXRGN4cE5NaStuTDh1?=
 =?gb2312?B?czFkem9OS2xRTHYvK1dieS90R0dXWFlFRlE0UGRuQ1ZPY0pDZGFQQjRwZ3NH?=
 =?gb2312?B?SG84NmdpQmVLU2dlemJKaFg5VDRPWDJMeUE1Z21Zd2hHUTNTYmltS09vMGc3?=
 =?gb2312?B?dUhNVVBWT2cxSTkxdHBWRmo3cmtrYXp6eUlFNEFWNE5CR0k4clBwU2Ixc3VY?=
 =?gb2312?B?WHNyRmdwTzAraElkZFJZN0VYcmxCNklITENsRjFVYlJ3WUgvNjIrRTdqbERz?=
 =?gb2312?B?RlFNTzkxbU9jSnZ0ZFB4UStqWVlKTGh4N1pTS0Z3N3R4M0N6R2FhY09LTW1G?=
 =?gb2312?B?aDRYa1dubmYzcUpKcTdoWFlJRGZsRVByM1EyZCtJYnN1M1hhK0VYQTZEeG5o?=
 =?gb2312?B?TTk3RlArcG9NdGVLZEs1MXdWVnAwNzVZVDdDbUhjUXY4U3ErMDFhVTFhWEN6?=
 =?gb2312?B?eGI2OHlmVHR1VU9QVWZ1SVBxK2liOFV5MytuM2dSUHd5RldBT29UQXQ2VnNv?=
 =?gb2312?B?cW5MbEptQXhVZk9kam9GeDBIZ2Q0YW1Xb3VyTW4vcmJOTHI5eGRXNk8rZnI4?=
 =?gb2312?B?bys0cjEzWHpES1R4TUFlVUQ5WWRmWGd3dXFVOHpDSHEyWUlPNDlSbElpU2py?=
 =?gb2312?B?WmJ6MHRoaW95dE9VRDlFT3laUnYxdWcyRXF5dnhJYjNVS1FGNEFtYXhHTHNY?=
 =?gb2312?B?c2ZsZDhaQVgzVUZENmFqc1NlMUN4Q05nUHN5RzFRUVVZS1Y2VmM5TTZMbkgx?=
 =?gb2312?B?eUdiMlRLTWxIN3YyU2tZZnNRQzg5b2tpQU13eVVEYk1IMTFmZXVsbUl4VzNT?=
 =?gb2312?B?dEN4Qi9BMlMvSHB3MGZxZ0dyT3p5OHM0SlJEcUtIMEttRU1kL0xxYnZMTGdw?=
 =?gb2312?B?Z2puL2wwckJWb3lpQ1J5WlliZkxuc0ZkWjZKNFg4N2o4eWZVeTBMVkdzWEov?=
 =?gb2312?B?Q01GY1lQdDZVRFgxT0NtTEdmdDUzVVFBSllhSkVTeGkra0dac0dBK0hpeFk4?=
 =?gb2312?B?Yzh0bjhuOUxSQ2tlZFNXZEVlbjEvQ3BzRThMNWtwWUVjWVhUVVZRcHJlVHo1?=
 =?gb2312?B?aXZwc1RML1dNYXFyVDhJeDZOYWJ2WGpvcGxqbmk3N1c3WlNJeG92N1c0Y0g5?=
 =?gb2312?B?eXgrZHRjdmh3aFBjU055WFhCaDBwS3Z3bHdBbmtVVWlBRWo4RWY0cHorM29U?=
 =?gb2312?B?cTJNaUFibmJuT2sxK082UzJxUG5DcXIyVWl5bzA0cnp6SlZTVWpZeUFSYjdR?=
 =?gb2312?B?QnpsbXEwdXFGWW12dlFiR05RWDRYcE9sSjdCUjVKYzJHVXNHV0Jmd0REU3FF?=
 =?gb2312?B?OUJZTng1TC9odTZacUo4RURtZGlIY3hNN2ZFbFZ3Z2NURHZTdDY3dWpTdkU0?=
 =?gb2312?B?MWVTQWF2ZlJPbXdtMkZJYldRTlhJb1Q4VlcxWkd3Ny9lVkFUUmJudlVFS2Q5?=
 =?gb2312?B?eFBVL0ZuMlhXMEQ1S3hJaG82TDdGKzFrOE41YkE0aWtBZDhUaDRKTU85MXhr?=
 =?gb2312?B?OWxvbWwwSXNZZ2VpMFVtQmNlOEFoNkthRFZVZm44QlduVHA0citpWjdXMUdL?=
 =?gb2312?B?LzVjVTVYY3NWaE54bHI0c2lNeFg1SWZpRS9hcVhEUTVPWCtNQk56bmlRbS9z?=
 =?gb2312?B?cFl0RWhzQnhXSFJMTnZVTTdtTjVaVTE0MlorSWRCNWYwdVhTRFVxaDdSazdo?=
 =?gb2312?B?ZG1mMnJuZE45amQwZEVZWFVuZFJLYmFPWjhwZ2dSdmFtV05GaEMrKzJVUWZB?=
 =?gb2312?B?NHU1QStPekppUTV6TjlYdmFhTVAvSnVKNDN4S0VWdEVTTVB3WW11Mi9JSTlu?=
 =?gb2312?Q?ECqTJ++UjnN/P?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6341.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UTNYVHZQQnhMQVQrWGJHUUNBT2lQanU2MUJZL3Vid1RIOUV3c3NOYXowOFNt?=
 =?gb2312?B?dlYxU3hoUmRMM1VaTG90TUIyZ1c2cWcwQitGcCt1ZFIvYmVRZW1DT00xNlIv?=
 =?gb2312?B?SHdFcVp1anFRQW5FVmE0eWNld2V0UytMUXJsbEpDRVdKVXNJTEtLMUxoTlBL?=
 =?gb2312?B?WndZNzVwM0U0VG41ckw2b0NGd0x2V2xOZ2VzTC9wRnFtb2o3Y0FTTkNkZkRz?=
 =?gb2312?B?WW0vMTI5aC94UFgwSXFyNDFUQUxZdkNrTWhyM1dnR1oySUdsZEk0dk5mbHJD?=
 =?gb2312?B?VC8waVZzdmY2bmF2dHg3SktNd0JaV1lkMkRwWTNpRE01MGZRd3ZWcWFpL2lo?=
 =?gb2312?B?WGhlV2o1OWk2dnovVGNKYy9OVEZoTlVVNTVpNXJtaHBYd3Vrd2xqckVlV1ZY?=
 =?gb2312?B?TnROVDNOLzRNZy9WazVBY1BEY3FSNlV5OEFaa2NtWWszNkhNUHdJem9pNHBK?=
 =?gb2312?B?dGdwcVRIMUF4YngzTnFLV1NSb1AyQ1F0TEJYamVmT1p4ZUxJZFc2VTY5QkJH?=
 =?gb2312?B?SG9OZlhsZ1dLcjdyaW5hakhXc094Q1FuQlhPaFNrT2RiVEJ3K2JCT0Ztb2Na?=
 =?gb2312?B?cDhPR091cXRIQ0ZoWm0wVjU1ODJISmJ2THNkMm56WFJUc2ZSUEd2RW9KZzNP?=
 =?gb2312?B?TE56QlYwUjlsMWFpblBOSVAxRGVnZ01EVHg0dTBEL0NzdXRDVWU2TVJnRS8y?=
 =?gb2312?B?ZTRJdDZpSjFlc2EzZmZsVDZzeVpZTXA0R3JWZ1RkVlRJRWphc1hoUk1vdkVl?=
 =?gb2312?B?OWMvU0pzbU5zVFptaVZFTkxCdHlkazNrTU1LS2MrYVpXbmVZUXBWK1djNE1C?=
 =?gb2312?B?UDV5bUFydHB1TUJYK1F5YmZhRmFNMTJMQ1MzTDlxSEwxZ3ZTcStPTEpZZWho?=
 =?gb2312?B?eG5oY2FhbGRBNDVOUFRXd1MwelRPQ0lXYkFpamtnRW12V3NGWEQ2OXhaWnhu?=
 =?gb2312?B?M1p2UTNjOHdFVmZNYmZGb0JFTXFpdGJCemJLd05Sb0xreGNWbkhHOHFweDZL?=
 =?gb2312?B?QUJFcjN5UWM5dENvL2pBcXJZUVVvUDhtcjZyWS9SQXRrcnNKcHR6aXI3cmtO?=
 =?gb2312?B?cFQxK2h5N0l5aGFOMmpUVzdOZmMyNHhadkNXZUtCN1k2U0Z5ejdBZDRsbmts?=
 =?gb2312?B?bzd4ZU5WbHNiRTFrQ2VXa1QyTGlnZDBONEVGaFpGcXlkSWRmcWdYZXBvT3JP?=
 =?gb2312?B?T3NRVDFQRGM2eFlNQURqMEFwWG1TMXE1Y1N3MWFzekN1VEtSM2JyMFdseUo3?=
 =?gb2312?B?YzErQkxPQ2g3aFRjMnBEc1kyN0Z2OTNPZHdFWkVReFR1RlIwMkorT0l6WHFq?=
 =?gb2312?B?S0dvQ09lcFlGd1RhR3g0UEU5SFZpVmZpcmdJcUZuUWpvNXZwbXZOcEVkUWtI?=
 =?gb2312?B?SFc4UHoxZXlIdjNkejZNaWNEREg4VFlTMGFRbFJHZ3NRQU5ZZ09ueU5ZcWpx?=
 =?gb2312?B?b2d5Y3NhcHlNOGtZcHM0aUhvRit6VkFacHlGVlhNcUE5QlI5alV4RlpZU3Q5?=
 =?gb2312?B?MG00VC93cWl6clQ2ZU9QNEhLcWVST3ZpcGM5N05HOTZjRktUczdiRjN1TU9Q?=
 =?gb2312?B?N0gwQUNYdWRjY0NMaW1Ta0hScXAvT2Q5cUhlNU9IT0RLTDRpTEJWcGJBd2VB?=
 =?gb2312?B?OEJUOTFmOG5JSGt4ZWI1bi8zck5kZ2YyYzNQYi9KU0xSc3ZQcnptSThzazdO?=
 =?gb2312?B?dGNFZEN3REcrTERVbkV5NlprdXJ3cWp2K01hMFIrYVJBUi96NFBYU1hPK1dN?=
 =?gb2312?B?eUE5V1dhT1RVQy9pcml1L1VNUWVLaG10OUVucTJLVUIvYVloeEtDczFiWXZW?=
 =?gb2312?B?SXFhbGtya0xUZExKclo4MzdUVytqUlRkV0VWR2RiR1EzdDZ3UTJycytpWnNs?=
 =?gb2312?B?VnFpVTlYalk0K0o2T1VuYVJhNVo3MVhscklKeGxzSThvaURVemQ4UlJrRkVH?=
 =?gb2312?B?YnNwMkRLMi9hdG5hcmxwczNNN2w2bFU5Mmx3cGw1bVRnRVpOSFlwKzZKTFQ4?=
 =?gb2312?B?NUZCMWtUVTlMcmh1VTRuTjJHM0lYOXJVZk1DSEFsMzJUdUtwS29aSHJueUxC?=
 =?gb2312?B?QmhTMHJrSnlGcWVPUmlsd24yRXRpbVdkQ2NzNHdjYkZkWEI1Um5LaWdoSE85?=
 =?gb2312?Q?+Xts=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6341.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcc28e9-afdd-45a6-0017-08dd525a6870
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 09:30:40.8882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xQpUokhKZsgQbjG7K4X4evTehb2w355Z6YH/x15I8/TVO/lR//jsxH9PN+W5vUy/tyOKPKJOn1EGFkGxH1hOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7868

PiBbK2NjIEZyYW5rLCB3aG8gYXNrZWQgdGhlIHNhbWUgcXVlc3Rpb24gYWJvdXQgRFRdDQo+IA0K
PiBPbiBUaHUsIEZlYiAyMCwgMjAyNSBhdCAwODo1NDowNlBNICswMTAwLCBMb3JlbnpvIEJpYW5j
b25pIHdyb3RlOg0KPiA+IE9uIEZlYiAyMCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gPiA+IE9u
IFN1biwgRmViIDAyLCAyMDI1IGF0IDA4OjM0OjI0UE0gKzAxMDAsIExvcmVuem8gQmlhbmNvbmkg
d3JvdGU6DQo+ID4gPiA+IENvbmZpZ3VyZSBQQnVzIGJhc2UgYWRkcmVzcyBhbmQgYWRkcmVzcyBt
YXNrIHRvIGFsbG93IHRoZSBodyB0byANCj4gPiA+ID4gZGV0ZWN0IGlmIGEgZ2l2ZW4gYWRkcmVz
cyBpcyBvbiBQQ0lFMCwgUENJRTEgb3IgUENJRTIuDQo+IA0KPiA+ID4gPiArI2RlZmluZSBQQ0lF
X0VONzU4MV9QQlVTX0FERFIoX24pCSgweDAwICsgKChfbikgPDwgMykpDQo+ID4gPiA+ICsjZGVm
aW5lIFBDSUVfRU43NTgxX1BCVVNfQUREUl9NQVNLKF9uKQkoMHgwNCArICgoX24pIDw8IDMpKQ0K
PiA+ID4gPiArI2RlZmluZSBQQ0lFX0VONzU4MV9QQlVTX0JBU0VfQUREUihfbikJXA0KPiA+ID4g
PiArCSgoX24pID09IDIgPyAweDI4MDAwMDAwIDoJXA0KPiA+ID4gPiArCSAoX24pID09IDEgPyAw
eDI0MDAwMDAwIDogMHgyMDAwMDAwMCkNCj4gPiA+IA0KPiA+ID4gQXJlIHRoZXNlIGFkZHJlc3Nl
cyBzb21ldGhpbmcgdGhhdCBzaG91bGQgYmUgZXhwcmVzc2VkIGluIGRldmljZXRyZWU/DQo+ID4g
DQo+ID4gRG8geW91IGhhdmUgYW55IGV4YW1wbGUvcG9pbnRlciBmb3IgaXQ/DQo+ID4gDQo+ID4g
PiBJdCBzZWVtcyB1bnVzdWFsIHRvIGVuY29kZSBhZGRyZXNzZXMgZGlyZWN0bHkgaW4gYSBkcml2
ZXIuDQo+ID4gDQo+ID4gQUZBSUsgdGhleSBhcmUgZml4ZWQgZm9yIEVONzU4MSBTb0MuDQo+IA0K
PiBTbyB0aGlzIGlzIHVzZWQgdG8gZGV0ZWN0IGlmIGEgZ2l2ZW4gYWRkcmVzcyBpcyBvbiBQQ0lF
MCwgUENJRTEgb3IgDQo+IFBDSUUyLiAgV2hhdCBkb2VzIHRoYXQgbWVhbj8gIFRoZXJlIGFyZSBu
byBvdGhlciBtZW50aW9ucyBvZiBQQ0lFMCBldGMgDQo+IGluIHRoZSBkcml2ZXIsIGJ1dCBtYXli
ZSB0aGV5IG1hdGNoIHVwIHRvICJwY2llMC8xLzIiIGluIA0KPiBhcmNoL2FybTY0L2Jvb3QvZHRz
L21lZGlhdGVrL210Nzk4OGEuZHRzaT8NCj4gDQo+IEl0IGxvb2tzIGxpa2UgeW91IHVzZSBQQ0lF
X0VONzU4MV9QQlVTX0FERFIoc2xvdCksIHdoZXJlICJzbG90IiBjYW1lIA0KPiBmcm9tIG9mX2dl
dF9wY2lfZG9tYWluX25yKCksIHdoaWNoIHN1Z2dlc3RzIHRoYXQgdGhlc2UgbWlnaHQgYmUgdGhy
ZWUgDQo+IHNlcGFyYXRlIFJvb3QgUG9ydHM/DQoNCj5JIHdhcyB1c2luZyBwY2lfZG9tYWluIHRv
IGRldGVjdCB0aGUgc3BlY2lmaWMgUENJZSBjb250cm9sbGVyIChzb21ldGhpbmcgc2ltaWxhciB0
byB3aGF0IGlzIGRvbmUgaGVyZSBbMF0pIGJ1dCBJIGFncmVlIHdpdGggRnJhbmssIGl0IGRvZXMg
bm90IHNlZW0gY29tcGxldGVseSBjb3JyZWN0Lg0KDQo+IFswXSBodHRwczovL2dpdGh1Yi5jb20v
dG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1l
ZGlhdGVrLmMjTDEwNDgNCg0KPiANCj4gQXJlIHdlIHRhbGtpbmcgYWJvdXQgYW4gTU1JTyBhZGRy
ZXNzIHRoYXQgYW4gZW5kcG9pbnQgZHJpdmVyIHVzZXMgZm9yDQo+IHJlYWR3KCkgZXRjLCBhbmQg
dGhpcyBjb2RlIGNvbmZpZ3VyZXMgdGhlIGhhcmR3YXJlIGFwZXJ0dXJlcyB0aHJvdWdoIA0KPiB0
aGUgaG9zdCBicmlkZ2U/ICBTZWVtcyBsaWtlIHRoYXQgd291bGQgYmUgcmVsYXRlZCB0byB0aGUg
InJhbmdlcyINCj4gcHJvcGVydGllcyBpbiBEVC4NCg0KPkkgZ3Vlc3Mgc28sIGJ1dCBJIGRvIG5v
dCBoYXZlIGFueSBkb2N1bWVudGF0aW9uIGFib3V0IHBidXMtY3NyIChhZGRpbmcgSHVpIGluIHRo
ZSBsb29wKS4NCg0KPkFzIHBvaW50ZWQgb3V0IGJ5IEZyYW5rLCBkbyB5b3UgYWdyZWUgdG8gYWRk
IHRoZXNlIGluZm8gaW4gdGhlIGR0cz8gU29tZXRoaW5nDQo+bGlrZToNCg0KPnBjaWUwOiBwY2ll
QDFmYzAwMDAwIHsNCj4JLi4uLg0KPgltZWRpYXRlayxwYnVzLWNzciA9IDwmcGJ1c19jc3IgMHgw
IDB4MjAwMDAwMDAgMHg0IDB4ZmMwMDAwMDA+Ow0KPgkuLi4uDQo+fTsNCj4NCj5wY2llMTogcGNp
ZUAxZmMyMDAwMCB7DQo+CS4uLi4NCj4JbWVkaWF0ZWsscGJ1cy1jc3IgPSA8JnBidXNfY3NyIDB4
OCAweDI0MDAwMDAwIDB4YyAweGZjMDAwMDAwPjsNCj4JLi4uLg0KPn07DQoNCj5ASHVpOiBjYW4g
eW91IHBsZWFzZSBwcm92aWRlIGEgYmV0dGVyIGV4cGxhbmF0aW9uIGFib3V0IHBidXMtY3NyIHVz
YWdlPw0KDQpIaSBMb3Jlbnpvo6wNCglQYnVzLWNzciAoYmFzZSBhbmQgbWFzaykgaXMgdXNlZCB0
byBkZXRlcm1pbmUgdGhlIGFkZHJlc3MgcmFuZ2UgY2FuIGJlIGFjY2VzcyBieSBQQ0llIGJ1cy4N
Cg0KMUZCRTM0MDAgUENJRTBfTUVNX0JBU0UgMzIgUENJRTAgYmFzZSBhZGRyZXNzDQoxRkJFMzQw
NCBQQ0lFMF9NRU1fTUFTSyAzMiBQQ0lFMCBiYXNlIGFkZHJlc3MgbWFzaw0KMUZCRTM0MDggUENJ
RTFfTUVNX0JBU0UgMzIgUENJRTEgYmFzZSBhZGRyZXNzDQoxRkJFMzQwQyBQQ0lFMV9NRU1fTUFT
SyAzMiBQQ0lFMSBiYXNlIGFkZHJlc3MgbWFzaw0KMUZCRTM0MTAgUENJRTJfTUVNX0JBU0UgMzIg
UENJRTIgYmFzZSBhZGRyZXNzDQoxRkJFMzQxNCBQQ0lFMl9NRU1fTUFTSyAzMiBQQ0lFMiBiYXNl
IGFkZHJlc3MgbWFzaw0KDQo+UmVnYXJkcywNCj5Mb3JlbnpvDQoNCj4gDQo+IEJqb3JuDQo=


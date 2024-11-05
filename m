Return-Path: <linux-pci+bounces-16036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E0A9BC90F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 10:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153C71C20927
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 09:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B70186284;
	Tue,  5 Nov 2024 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UEKnHztu";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BijS2Gv5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43A2C1A2
	for <linux-pci@vger.kernel.org>; Tue,  5 Nov 2024 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798653; cv=fail; b=N8w7C8vB0h0Qkd1ysZ2FaoJ3bxv1yOxhO8VZPSZ50hWGz3qQnFFJ+9/rKISSm9WK5wIozuHjhABXBFuThzrgd2EZAWkrasNAavmvNVIEWLac1rTM9cZgJRlhWuv0OKkB2faNE/XeEhnKT+x5zLH297SgLznCzXpQPMJiJul6OK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798653; c=relaxed/simple;
	bh=tIpxRdsfB/inYQKk9qfBlboc5lgBE+fxrkWGpRlA/m4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s3aItTg/xj6Fd2GVmt9jzG2P5IMx6GiRAyd8AofJi/xjlX5KYip3j/yNeKew5S6xQRNGfDE5aTp2U5agQ2vUPOmmGwLQl2fY3oH+RUxlIzYymJymoflilP+BWLB78AYnjNVA1zWmBXRdUzcJmchE4GjKqhIvxYoh9C69LYNqq60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UEKnHztu; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=BijS2Gv5; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: af1e2a429b5711efbd192953cf12861f-20241105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tIpxRdsfB/inYQKk9qfBlboc5lgBE+fxrkWGpRlA/m4=;
	b=UEKnHztuIw7z1HJeWrXUcJwFJgZFtCvql8iKfaX2+GBchH10R9TxsmcMV1GhcwGNUO6JkPCTjn/e7+Txhbxpm8jzoFP3EikRTOnHkZVCH3jSOS7JZBHtuk9H/dE46cnCY+nH2lAuehXrSunxZRQ0s8VnWySrYuzkmuDjYfx6l6Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:f2a0df2a-cfeb-44f1-b7ba-b7f53740b4d9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:7a1ab848-ca13-40ea-8070-fa012edab362,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: af1e2a429b5711efbd192953cf12861f-20241105
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 178884518; Tue, 05 Nov 2024 17:23:57 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Nov 2024 17:23:56 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Nov 2024 17:23:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVBj+2lSPxQQmK4ZH0I2ES45G84dVN/tKKL/ec89Fc+WF/sXtKxooqmo8PonwVB3tVHUQPeLbrMk3stFnZg+k0wYwwRuS2mlJoviw0VLFwkL3opXmSSYqNCMtkcYS5ZdNZksTAIS5WPPQn07u4aHQo98XGietuWIYjQKO45VGt6nJYnk1zAKaOwLCcMhymNEOoD7v8Z1Lvkjko1gfFJd3/jTEggy0q61N4UJrlRG3se0QjrTlBToQTqz8CEUezNcvuWYlM2vOLTYlRr9MSyndofPkPVf0WHZ5jvhmk+UmajeEpnqoSzsADyViZ7RemrhS6e54woOj673tDM/FxtP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIpxRdsfB/inYQKk9qfBlboc5lgBE+fxrkWGpRlA/m4=;
 b=OFRoUZU5sohjDp+uIKANw6je3oJVxUnmTaHdswYB1KM8s+Kyxx9umPiaKjIx8ZxlNYaGlDATc7SJAt3q9qI16O3mb06ehWLB+myD73F88gdaVlinHFCxjybEoyzw22tmiXo29GLten5ATUebOoJxL5aEXK1oJQCTzlbArjl+YnZZsH6upPsYkRCz0jdvJi6HjOOEnSFQzU0iRwcWjeL0F8rB5rel+fkg73yfelvkq4OMi45A423QUc4hmYIKlvCorvSGnUKi8pla5kXWP6t/hdFZKk4sjA+ap7XvkfGhApHDTjePEkTr5l3548W2r2T+aGtmW3utdKEhYh7D2AoH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIpxRdsfB/inYQKk9qfBlboc5lgBE+fxrkWGpRlA/m4=;
 b=BijS2Gv53WjOpwip9jItVg0PxnRLQ+PFj3+EbAiG41uL+pQDk1ehhlI3DuD0m+VG9gcbvUpbNGHqk9qnXOLpCfJmQXyWdWBDBQHgc+zPGIQlBzAjP+vqzJnDw7138w0XaPG1CmI/1nsRdkOEFhLeSl8bChU9tQMpbH3eesQS9P0=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by TYSPR03MB8045.apcprd03.prod.outlook.com (2603:1096:400:478::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 09:23:37 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%4]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 09:23:37 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "lorenzo@kernel.org" <lorenzo@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"Ryder Lee" <Ryder.Lee@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "ansuelsmth@gmail.com"
	<ansuelsmth@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, =?utf-8?B?SHVpIE1hICjpqazmhacp?=
	<Hui.Ma@airoha.com>, upstream <upstream@airoha.com>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Avoid PCIe resetting via PCIE_RSTB
 for Airoha EN7581 SoC
Thread-Topic: [PATCH v2] PCI: mediatek-gen3: Avoid PCIe resetting via
 PCIE_RSTB for Airoha EN7581 SoC
Thread-Index: AQHbLwUKxn3W3mufJ0mUHMDfaZ/NObKoaryA
Date: Tue, 5 Nov 2024 09:23:36 +0000
Message-ID: <f827f7c45094722aa3c254eda32ada157156444a.camel@mediatek.com>
References: <20241104-pcie-en7581-rst-fix-v2-1-ffe5839c76d8@kernel.org>
In-Reply-To: <20241104-pcie-en7581-rst-fix-v2-1-ffe5839c76d8@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|TYSPR03MB8045:EE_
x-ms-office365-filtering-correlation-id: c7b2b3c5-0d94-4c93-dfca-08dcfd7b8732
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aXZhcXpnQkV6WTZ3b2thWEcrdHp3MXVWTzN0aWpNL2k1bURsN2lWWENjMnVJ?=
 =?utf-8?B?K0xqcGNwWlQ3V0pMbUVINHEvdk1YRE11QVgwdE1TaTFJQ0NEa2pxc1V6NTFO?=
 =?utf-8?B?VkdEWWZQa0F5dWJmdHRlUXUreTBySFZrNDFCUThuVzF1QTVJSU9Uak80dERH?=
 =?utf-8?B?QUZ6T0hZZnhaeTZ0cStXNFc4U0V1MHp2YWxPRU8rUHFsUW01a0N5enVtSU9w?=
 =?utf-8?B?bG83alE2TDFJamNZeWlCbDIwekFWb21sSUtWNjZFOWdzaEZpVnVHQVdPK0hn?=
 =?utf-8?B?TEFMaGtFLzZ2YWludmt6VklvOFJyRjNTeEpVdEY1QitLV1NsWkl4WHk4cmtU?=
 =?utf-8?B?Z1RNY0ErYnFKa3pDSThLYzlYQ1ltcDZWYzN5RUlnNkx2WHp5RHJOeVdnamtE?=
 =?utf-8?B?MWpkMGxkSHh3N2I0MlFqNGpkUEJvRmFQRzF3RVZZOWswa1dJWTVhWjhndlYz?=
 =?utf-8?B?dlJvZFR2b2tJcmpJcGp0WXYxaW0wSjVZVVJSSjJEdmFsSzlCZy9HSDZMeW1U?=
 =?utf-8?B?aE85V1lHaWRLTlNPYmtaNHB3UEdhVzhhUWY1N0c3Y0pISjZLRlV0cjROTnZm?=
 =?utf-8?B?dCswN0d6SG44MnZuMUtxSCtDNnNCcHhmY3hqVTRvU01Ic1RWTUlwMHRmTlJx?=
 =?utf-8?B?TCtYb3dOTWVJbnpJQS9RU3lPS2lqQ3NEaDJkb2tvbjJxMnlwZkZvdm5sVjhr?=
 =?utf-8?B?STBEdmtZK0w3VDd5SmQ5dHJkV0ppU0xiNXNvUEZkSFN2Sm1zSW5MbktrRjRV?=
 =?utf-8?B?cGoxSGFYck56T1VMUUZWbkh2Q2ZiUFJRQmlqOFNLTEhUdXd5TXRqV0J5UUdq?=
 =?utf-8?B?OUZpMVY1VGtGL090NFFObEFUUFVqVzBGN3ltUHFsY1lyc216dENoUStZY1JL?=
 =?utf-8?B?UEpFdkc2M2VBQzNYR0g0Q05QV0hNQ2FnYmVsVFo2RnZzMEs1cnhweGtDSEtQ?=
 =?utf-8?B?SGVsUURQaXhVYVZpNHpDdUZNVmJzaUpCaTlZK1JLa09aQnFsbHBNWHJzNFZR?=
 =?utf-8?B?ZUxscTRMZFRwaWNhVUpOMmFHbW5HdXNCem1qNGU5V1lkcktaWWVxeVBQUnFI?=
 =?utf-8?B?S3FCelZBcFJySWNselllMlB0SXl1Z2h6ZTAwM2YrU3h3eU5aK2RacFJZR3pl?=
 =?utf-8?B?OWgrUUt0WS95aU5zbERQa2hlS1pHRndtWDlGY0k2VWNlUkxLK1YrTmxaMXhJ?=
 =?utf-8?B?VXRtUG5kMXRaaFMzUDlPZlczNFQwZGNwazN2SGtBcTBtVFNWcHpNTDJIQW90?=
 =?utf-8?B?VlcvUGxvV2ZnakNzM2VIRTBMVjJ6RFVVWFZYaDFwYzRhTG9KL3JpRjdsekZZ?=
 =?utf-8?B?c2pHU3FXMFVvbGV2WThGa01wYUMrQ1Vlb0pVUUR0K29PeGR0YzlPcEVBOXdz?=
 =?utf-8?B?Z1dHNUgvODhablV6S2diQUpvcUQ1aG45OXNqKytwY3pUQnY3d0R2cnV5ZllR?=
 =?utf-8?B?cHAzR1piVTh0a2JJVW5zSCtzWXhRR2t3Sk5MZDNaTWc5VnBiaWtXZlNpUVQ1?=
 =?utf-8?B?dVdncFg0MFdZNzcyL3B1SHZEWVZueFMzSGVGM2t4cU1MSWtUckVsTkpsZGJO?=
 =?utf-8?B?SGE3V3puYXBFMjRIZVBMajZENndQUmhqYkpNNFlram5QMWlGd0ljMWIwRGFC?=
 =?utf-8?B?US9YV3hIYTE3WDQ0WE1sM2dBbEpNaDNaNTBIajZmdFJwalVPeXg3bjZhTmN3?=
 =?utf-8?B?SDdtS2lPdG8xSDdnWEtjTzgvbjl0VGZWTkdMZ2JZeWNPd2UybjB0UlRScU9J?=
 =?utf-8?B?NStRQlRPQWRBVHhoSEh1WXBXVENkTkJudFBLNlphZml0dHJkOWF1Z1RueUlC?=
 =?utf-8?B?R2tMMW1URWd5MFhGMU5uRHhZOTBuOCtrVllyWFFRanUwOHlLdUZWTUx1QVNG?=
 =?utf-8?Q?RrSlB+oH120fq?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGR6ZkpMRElla3cyY0dUZWRrM2RvWjJIQ0gvSGhtVnN6WG84Sy92OUllNjhC?=
 =?utf-8?B?NTNhVmZxQzRDaG9NNFJlZmdaVEN1OGExNkdVVm91U2tXMlg4MXBhZHFpNmhV?=
 =?utf-8?B?eU9ZMG0vMTN2ZTY0RTZFdyswd01DVzk1dEs2V3pkVXprMklmRHpFcGc3enJj?=
 =?utf-8?B?dzZhRG9UbVZ6OVRkaHUwV0h2VXZJVFI5aWt5VXRMbk5WcVdUNXljZzlwVGdL?=
 =?utf-8?B?MnFDTHRlM1RrTWxVRnd1WUVha0dGcXRPK1RrYzJ5NEhMZzRuRGZCQTlucUN2?=
 =?utf-8?B?ZndEbmNnQVB1eDRIVDh2OFliQ1ZFSHNCS1JRaTZBWUhmSjJ2ak04OVluUXRH?=
 =?utf-8?B?WFRzb0d2OXFiR2paZ1BHYnRBMjdWZFZHRFhLblpUdk1vZU9RUTVMUlJxS28x?=
 =?utf-8?B?d2NtaG1mb1Y1c00yNkJtM3dIQXdLeC80OEM1Z0ZTVXJ5NjNZM2dQZXd6bFFT?=
 =?utf-8?B?ZzYzOVZzUzUyUXZmZTBvczFPV25FbnA1WWovL2Q3dVJQY3V3MG5vNkpSRExP?=
 =?utf-8?B?VW5YclQ4TlFGMmRtUDZBd2lRZDZjelJWL3ZLb0Z1SkkzbXkxVnVXb2xzdVFr?=
 =?utf-8?B?T3dacjFsQ2JnN3ZRcnBCbzVkcEhFd2lROVZuY0VicUM0K3hMV3hqMjhCQ3Bj?=
 =?utf-8?B?d1BOWHhwZy9tcFNGZ01ONmRrbk5GV2s5RStuV1hFRGhyd2hvNTliZ3pQRjFk?=
 =?utf-8?B?RDNKaVcybHlsT0RSclM5SjJJdW9xK3RkeEgvUC9JZTBqTVdlSmFMVk9xMGtB?=
 =?utf-8?B?TjVqQ2pIMUJ0WXhDM3dRdFp5U2QrSkNMcnVTV1NOVUczVEtEeWJwZHRGTmlU?=
 =?utf-8?B?ciswMzkrQS94Yi9ybk1iUXkyU1NNQXJTMk5ydk8xNW9kb2pOckY4VGtrQkpu?=
 =?utf-8?B?ZGhtanloYnJVaEtBUCtXTXA1R2JEcDF4SEtwSWgyRk53MnB3RWhHSzlobXZG?=
 =?utf-8?B?cHNtVlgzT1Mxb3dHVGxVTlQ2TzhqMXJSUmsxOXdhcFBseEYxbmxDSTErcVVi?=
 =?utf-8?B?VWZ5MGg1VFhqeDVjeTlPQ0ozckdMR3RWTzgxbVBVYlpWUW41ZFdPTk1iWHkw?=
 =?utf-8?B?YlYxSmk2SCtDMnA1cVBIaWE2K1RDZWxBdEgxRmYwN2JHQmNxSE5DV1VaZzRv?=
 =?utf-8?B?cHZnNjM2aHZWRXF0dm1CSklhN1NvNjBnaFRBUkJHdUE5MXdVT3V1eVhUQU03?=
 =?utf-8?B?V0NGMU1mVkkwN2Uza2RCTThVMWM4YWRlTUxJeitJMElQaG41UUJqaitmY1BP?=
 =?utf-8?B?dGt3MVR1TElLNlRiVGVweUZSblJXK1o4dGRLNm5maWxlM0FXU0NveEd2OVln?=
 =?utf-8?B?OUxTOHRwMUVTVllvYlErVGFkQjZqNC9CS1JWTWIwVmQ3RW1kUDFJV2l0Ylgr?=
 =?utf-8?B?N2hUZkNEM1VEQ3VnRFkrSzVwYTQwYWtNRDYxRnBEUFVwbExBc3EzK1dWdlhZ?=
 =?utf-8?B?Q09Pc0JEWWYvOWYyK051Mk5PbDA3a1Y1Qlk1Q0Iwa2dtWVVDU0dzY2t0UDY3?=
 =?utf-8?B?bXIxcHMxNDNHTjgyTG9iWk9GQnJUT1hpQ0JjckdvcEExMnF1NkNJOXBCQ2VW?=
 =?utf-8?B?TUp0UzNBTDZkeW1DbzYwTHlEbG4ydkUwMHRiQ0pweFhZSkY4TmlnVlVqUFRn?=
 =?utf-8?B?dEc3WlBpWkMvSFpBNUtwZzY3WlpZOWhqTzFSanNHUjJCNlFYV0M2QU5DVkNI?=
 =?utf-8?B?Nld2N3NJVnZRTEtPUzlabGNJVlBiNzdieS9adzZVTkMyV09xWHVYU3FSNmFW?=
 =?utf-8?B?ekwwZWlOK0c4VjBpVFFYREdkZzN1dXBnVGFwYVkrNDJ6UndQUmxYK2svd2hZ?=
 =?utf-8?B?eTcrQjdYT1phbUNITTJHckxPZ3NCOEExc1VIU0J0NXBPMFdrQ1JZQVhEb0xC?=
 =?utf-8?B?UVVaS1NnNkJKdGNtUHRCYnZPVC9DYW15d3dyeTIxUEQyVmkxM1ZUYnRqYmJk?=
 =?utf-8?B?QStsWXNVdlAzMkhqdURrQ2hMQmdOZTBqUzF4VGFmb3U4anA2b2VTZmFPNnFB?=
 =?utf-8?B?cHZkZmJHTG5ZZDg3YmhTZWs0UTJjQVh3UVlpbjJHdHc1N2YydUpuWks2SEdF?=
 =?utf-8?B?YmJkV2dtK0s4OEpNb1VGZis5M2k3c0FDWlIrb3RkS0N4V1NLSkJnNkpKcS8y?=
 =?utf-8?B?N1l6ZHdTeXpwb3YwdGtVbDJPT3BSN0ZSdlpWYkpFNi9JQmt1WnhwZmJSdTVH?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E82DBA2E01E9A4C98788EA2C899C85E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b2b3c5-0d94-4c93-dfca-08dcfd7b8732
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 09:23:37.0251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HlhHgSahg4FVkLghZObBOS0UsbS4HUZjSgHrumdWBEX8EiMcc/lrLJTP3d1WYUywULkHFaerwa0rU4LprrCyuOD67gC2F2nQoKNDQbHmwE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8045

T24gTW9uLCAyMDI0LTExLTA0IGF0IDIzOjAwICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiANCj4gDQo+IEFpcm9oYSBFTjc1ODEgaGFzIGEgaHcgYnVnIGFzc2VydGluZy9y
ZWxlYXNpbmcgUENJRV9QRV9SU1RCIHNpZ25hbA0KPiBjYXVzaW5nIG9jY2FzaW9uYWwgUENJZSBs
aW5rIGRvd24gaXNzdWVzLiBJbiBvcmRlciB0byBvdmVyY29tZSB0aGUNCj4gcHJvYmxlbSwgUENJ
RV9SU1RCIHNpZ25hbHMgYXJlIG5vdCBhc3NlcnRlZC9yZWxlYXNlZCBkdXJpbmcgZGV2aWNlDQo+
IHByb2JlIG9yDQo+IHN1c3BlbmQvcmVzdW1lIHBoYXNlIGFuZCB0aGUgUENJZSBibG9jayBpcyBy
ZXNldCB1c2luZw0KPiBSRUdfUENJX0NPTlRST0wNCj4gKDB4ODgpIGFuZCBSRUdfUkVTRVRfQ09O
VFJPTCAoMHg4MzQpIHJlZ2lzdGVycyBhdmFpbGFibGUgdmlhIHRoZQ0KPiBjbG9jaw0KPiBtb2R1
bGUuDQo+IEludHJvZHVjZSBmbGFncyBmaWVsZCBpbiB0aGUgbXRrX2dlbjNfcGNpZV9wZGF0YSBz
dHJ1Y3QgaW4gb3JkZXIgdG8NCj4gc3BlY2lmeSBwZXItU29DIGNhcGFiaWxpdGllcy4NCj4gDQo+
IFRlc3RlZC1ieTogSHVpIE1hIDxodWkubWFAYWlyb2hhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
TG9yZW56byBCaWFuY29uaSA8bG9yZW56b0BrZXJuZWwub3JnPg0KPiAtLS0NCj4gQ2hhbmdlcyBp
biB2MjoNCj4gLSBpbnRyb2R1Y2UgZmxhZ3MgZmllbGQgaW4gbXRrX2dlbjNfcGNpZV9mbGFncyBz
dHJ1Y3QgaW5zdGVhZCBvZg0KPiBhZGRpbmcNCj4gICByZXNldCBjYWxsYmFjaw0KPiAtIGZpeCB0
aGUgbGVmdG92ZXIgY2FzZSBpbiBtdGtfcGNpZV9zdXNwZW5kX25vaXJxIHJvdXRpbmUNCj4gLSBh
ZGQgbW9yZSBjb21tZW50cw0KPiAtIExpbmsgdG8gdjE6IA0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzIwMjQwOTIwLXBjaWUtZW43NTgxLXJzdC1maXgtdjEtMS0xMDQzZmI2M2ZmYzlAa2Vy
bmVsLm9yZw0KPiAtLS0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1n
ZW4zLmMgfCA1OQ0KPiArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+IGluZGV4DQo+IDY2Y2U0
YjVkMzA5YmI2ZDY0NjE4YzcwYWM1ZTBhNTI5ZTA5MTA1MTEuLjhlNDcwNGZmMzUwOTg2N2ZjMGZm
Nzk5ZTlmYg0KPiA5OWU3MWU0Njc1NmNkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gQEAgLTEyNSwxMCArMTI1LDE4IEBADQo+IA0KPiAg
c3RydWN0IG10a19nZW4zX3BjaWU7DQo+IA0KPiArZW51bSBtdGtfZ2VuM19wY2llX2ZsYWdzIHsN
Cj4gKyAgICAgICBTS0lQX1BDSUVfUlNUQiAgPSBCSVQoMCksIC8qIHNraXAgUENJRV9SU1RCIHNp
Z25hbHMNCj4gY29uZmlndXJhdGlvbg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICogZHVyaW5nIGRldmljZSBwcm9iaW5nIG9yDQo+IHN1c3BlbmQvcmVzdW1lDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBwaGFzZSBpbiBvcmRlciB0byBhdm9pZCBo
dw0KPiBidWdzL2lzc3Vlcy4NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
Lw0KPiArfTsNCj4gKw0KPiAgLyoqDQo+ICAgKiBzdHJ1Y3QgbXRrX2dlbjNfcGNpZV9wZGF0YSAt
IGRpZmZlcmVudGlhdGUgYmV0d2VlbiBob3N0DQo+IGdlbmVyYXRpb25zDQo+ICAgKiBAcG93ZXJf
dXA6IHBjaWUgcG93ZXJfdXAgY2FsbGJhY2sNCj4gICAqIEBwaHlfcmVzZXRzOiBwaHkgcmVzZXQg
bGluZXMgU29DIGRhdGEuDQo+ICsgKiBAZmxhZ3M6IHBjaWUgZGV2aWNlIGZsYWdzLg0KPiAgICov
DQo+ICBzdHJ1Y3QgbXRrX2dlbjNfcGNpZV9wZGF0YSB7DQo+ICAgICAgICAgaW50ICgqcG93ZXJf
dXApKHN0cnVjdCBtdGtfZ2VuM19wY2llICpwY2llKTsNCj4gQEAgLTEzNiw2ICsxNDQsNyBAQCBz
dHJ1Y3QgbXRrX2dlbjNfcGNpZV9wZGF0YSB7DQo+ICAgICAgICAgICAgICAgICBjb25zdCBjaGFy
ICppZFtNQVhfTlVNX1BIWV9SRVNFVFNdOw0KPiAgICAgICAgICAgICAgICAgaW50IG51bV9yZXNl
dHM7DQo+ICAgICAgICAgfSBwaHlfcmVzZXRzOw0KPiArICAgICAgIHUzMiBmbGFnczsNCj4gIH07
DQo+IA0KPiAgLyoqDQo+IEBAIC00MDIsMjIgKzQxMSwzMyBAQCBzdGF0aWMgaW50IG10a19wY2ll
X3N0YXJ0dXBfcG9ydChzdHJ1Y3QNCj4gbXRrX2dlbjNfcGNpZSAqcGNpZSkNCj4gICAgICAgICB2
YWwgfD0gUENJRV9ESVNBQkxFX0RWRlNSQ19WTFRfUkVROw0KPiAgICAgICAgIHdyaXRlbF9yZWxh
eGVkKHZhbCwgcGNpZS0+YmFzZSArIFBDSUVfTUlTQ19DVFJMX1JFRyk7DQo+IA0KPiAtICAgICAg
IC8qIEFzc2VydCBhbGwgcmVzZXQgc2lnbmFscyAqLw0KPiAtICAgICAgIHZhbCA9IHJlYWRsX3Jl
bGF4ZWQocGNpZS0+YmFzZSArIFBDSUVfUlNUX0NUUkxfUkVHKTsNCj4gLSAgICAgICB2YWwgfD0g
UENJRV9NQUNfUlNUQiB8IFBDSUVfUEhZX1JTVEIgfCBQQ0lFX0JSR19SU1RCIHwNCj4gUENJRV9Q
RV9SU1RCOw0KPiAtICAgICAgIHdyaXRlbF9yZWxheGVkKHZhbCwgcGNpZS0+YmFzZSArIFBDSUVf
UlNUX0NUUkxfUkVHKTsNCj4gLQ0KPiAgICAgICAgIC8qDQo+IC0gICAgICAgICogRGVzY3JpYmVk
IGluIFBDSWUgQ0VNIHNwZWNpZmljYXRpb24gc2VjdGlvbnMgMi4yIChQRVJTVCMNCj4gU2lnbmFs
KQ0KPiAtICAgICAgICAqIGFuZCAyLjIuMSAoSW5pdGlhbCBQb3dlci1VcCAoRzMgdG8gUzApKS4N
Cj4gLSAgICAgICAgKiBUaGUgZGVhc3NlcnRpb24gb2YgUEVSU1QjIHNob3VsZCBiZSBkZWxheWVk
IDEwMG1zDQo+IChUUFZQRVJMKQ0KPiAtICAgICAgICAqIGZvciB0aGUgcG93ZXIgYW5kIGNsb2Nr
IHRvIGJlY29tZSBzdGFibGUuDQo+ICsgICAgICAgICogQWlyb2hhIEVONzU4MSBoYXMgYSBodyBi
dWcgYXNzZXJ0aW5nL3JlbGVhc2luZw0KPiBQQ0lFX1BFX1JTVEIgc2lnbmFsDQo+ICsgICAgICAg
ICogY2F1c2luZyBvY2Nhc2lvbmFsIFBDSWUgbGluayBkb3duLiBJbiBvcmRlciB0byBvdmVyY29t
ZQ0KPiB0aGUgaXNzdWUsDQo+ICsgICAgICAgICogUENJRV9SU1RCIHNpZ25hbHMgYXJlIG5vdCBh
c3NlcnRlZC9yZWxlYXNlZCBhdCB0aGlzIHN0YWdlDQo+IGFuZCB0aGUNCj4gKyAgICAgICAgKiBQ
Q0llIGJsb2NrIGlzIHJlc2V0IHVzaW5nIFJFR19QQ0lfQ09OVFJPTCAoMHg4OCkgYW5kDQo+ICsg
ICAgICAgICogUkVHX1JFU0VUX0NPTlRST0wgKDB4ODM0KSByZWdpc3RlcnMgYXZhaWxhYmxlIHZp
YSB0aGUNCj4gY2xvY2sgbW9kdWxlLg0KPiAgICAgICAgICAqLw0KPiAtICAgICAgIG1zbGVlcCgx
MDApOw0KPiAtDQo+IC0gICAgICAgLyogRGUtYXNzZXJ0IHJlc2V0IHNpZ25hbHMgKi8NCj4gLSAg
ICAgICB2YWwgJj0gfihQQ0lFX01BQ19SU1RCIHwgUENJRV9QSFlfUlNUQiB8IFBDSUVfQlJHX1JT
VEIgfA0KPiBQQ0lFX1BFX1JTVEIpOw0KPiAtICAgICAgIHdyaXRlbF9yZWxheGVkKHZhbCwgcGNp
ZS0+YmFzZSArIFBDSUVfUlNUX0NUUkxfUkVHKTsNCg0KV2hhdCB3aWxsIGhhcHBlbiBpZiB0aGUg
RU43NTgxIHVzZSB0aGlzIHJlc2V0IGZsb3c/IFdpbGwgaXQgc3RpbGwgd29yaw0KYWZ0ZXIgdGhp
cyBsaW5rIGRvd24/DQoNCj4gKyAgICAgICBpZiAoIShwY2llLT5zb2MtPmZsYWdzICYgU0tJUF9Q
Q0lFX1JTVEIpKSB7DQo+ICsgICAgICAgICAgICAgICAvKiBBc3NlcnQgYWxsIHJlc2V0IHNpZ25h
bHMgKi8NCj4gKyAgICAgICAgICAgICAgIHZhbCA9IHJlYWRsX3JlbGF4ZWQocGNpZS0+YmFzZSAr
IFBDSUVfUlNUX0NUUkxfUkVHKTsNCj4gKyAgICAgICAgICAgICAgIHZhbCB8PSBQQ0lFX01BQ19S
U1RCIHwgUENJRV9QSFlfUlNUQiB8IFBDSUVfQlJHX1JTVEINCj4gfA0KPiArICAgICAgICAgICAg
ICAgICAgICAgIFBDSUVfUEVfUlNUQjsNCj4gKyAgICAgICAgICAgICAgIHdyaXRlbF9yZWxheGVk
KHZhbCwgcGNpZS0+YmFzZSArIFBDSUVfUlNUX0NUUkxfUkVHKTsNCj4gKw0KPiArICAgICAgICAg
ICAgICAgLyoNCj4gKyAgICAgICAgICAgICAgICAqIERlc2NyaWJlZCBpbiBQQ0llIENFTSBzcGVj
aWZpY2F0aW9uIHNlY3Rpb25zIDIuMg0KPiAoUEVSU1QjIFNpZ25hbCkNCj4gKyAgICAgICAgICAg
ICAgICAqIGFuZCAyLjIuMSAoSW5pdGlhbCBQb3dlci1VcCAoRzMgdG8gUzApKS4NCj4gKyAgICAg
ICAgICAgICAgICAqIFRoZSBkZWFzc2VydGlvbiBvZiBQRVJTVCMgc2hvdWxkIGJlIGRlbGF5ZWQg
MTAwbXMNCj4gKFRQVlBFUkwpDQo+ICsgICAgICAgICAgICAgICAgKiBmb3IgdGhlIHBvd2VyIGFu
ZCBjbG9jayB0byBiZWNvbWUgc3RhYmxlLg0KPiArICAgICAgICAgICAgICAgICovDQo+ICsgICAg
ICAgICAgICAgICBtc2xlZXAoUENJRV9UX1BWUEVSTF9NUyk7DQo+ICsNCj4gKyAgICAgICAgICAg
ICAgIC8qIERlLWFzc2VydCByZXNldCBzaWduYWxzICovDQo+ICsgICAgICAgICAgICAgICB2YWwg
Jj0gfihQQ0lFX01BQ19SU1RCIHwgUENJRV9QSFlfUlNUQiB8DQo+IFBDSUVfQlJHX1JTVEIgfA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgUENJRV9QRV9SU1RCKTsNCj4gKyAgICAgICAgICAg
ICAgIHdyaXRlbF9yZWxheGVkKHZhbCwgcGNpZS0+YmFzZSArIFBDSUVfUlNUX0NUUkxfUkVHKTsN
Cj4gKyAgICAgICB9DQo+IA0KPiAgICAgICAgIC8qIENoZWNrIGlmIHRoZSBsaW5rIGlzIHVwIG9y
IG5vdCAqLw0KPiAgICAgICAgIGVyciA9IHJlYWRsX3BvbGxfdGltZW91dChwY2llLT5iYXNlICsg
UENJRV9MSU5LX1NUQVRVU19SRUcsDQo+IHZhbCwNCj4gQEAgLTExNjAsMTAgKzExODAsMTIgQEAg
c3RhdGljIGludCBtdGtfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdA0KPiBkZXZpY2UgKmRldikN
Cj4gICAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+ICAgICAgICAgfQ0KPiANCj4gLSAgICAg
ICAvKiBQdWxsIGRvd24gdGhlIFBFUlNUIyBwaW4gKi8NCj4gLSAgICAgICB2YWwgPSByZWFkbF9y
ZWxheGVkKHBjaWUtPmJhc2UgKyBQQ0lFX1JTVF9DVFJMX1JFRyk7DQo+IC0gICAgICAgdmFsIHw9
IFBDSUVfUEVfUlNUQjsNCj4gLSAgICAgICB3cml0ZWxfcmVsYXhlZCh2YWwsIHBjaWUtPmJhc2Ug
KyBQQ0lFX1JTVF9DVFJMX1JFRyk7DQo+ICsgICAgICAgaWYgKCEocGNpZS0+c29jLT5mbGFncyAm
IFNLSVBfUENJRV9SU1RCKSkgew0KPiArICAgICAgICAgICAgICAgLyogUHVsbCBkb3duIHRoZSBQ
RVJTVCMgcGluICovDQo+ICsgICAgICAgICAgICAgICB2YWwgPSByZWFkbF9yZWxheGVkKHBjaWUt
PmJhc2UgKyBQQ0lFX1JTVF9DVFJMX1JFRyk7DQo+ICsgICAgICAgICAgICAgICB2YWwgfD0gUENJ
RV9QRV9SU1RCOw0KPiArICAgICAgICAgICAgICAgd3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5i
YXNlICsgUENJRV9SU1RfQ1RSTF9SRUcpOw0KPiArICAgICAgIH0NCj4gDQo+ICAgICAgICAgZGV2
X2RiZyhwY2llLT5kZXYsICJlbnRlcmVkIEwyIHN0YXRlcyBzdWNjZXNzZnVsbHkiKTsNCj4gDQo+
IEBAIC0xMjE0LDYgKzEyMzYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19nZW4zX3BjaWVf
cGRhdGENCj4gbXRrX3BjaWVfc29jX2VuNzU4MSA9IHsNCj4gICAgICAgICAgICAgICAgIC5pZFsy
XSA9ICJwaHktbGFuZTIiLA0KPiAgICAgICAgICAgICAgICAgLm51bV9yZXNldHMgPSAzLA0KPiAg
ICAgICAgIH0sDQo+ICsgICAgICAgLmZsYWdzID0gU0tJUF9QQ0lFX1JTVEIsDQo+ICB9Ow0KPiAN
Cj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19wY2llX29mX21hdGNoW10g
PSB7DQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDMxMDJjZTEwZjMxMTFlNGMzYjhmYjIzM2Rj
OTNmMjllMjIwYWRhZjcNCj4gY2hhbmdlLWlkOiAyMDI0MDkyMC1wY2llLWVuNzU4MS1yc3QtZml4
LTgxNjE2NThjMTNjNA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBMb3JlbnpvIEJpYW5j
b25pIDxsb3JlbnpvQGtlcm5lbC5vcmc+DQo+IA0KPiANCg==


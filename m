Return-Path: <linux-pci+bounces-16514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF55F9C51FE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 10:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64F8B2C66B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 09:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A031A263F;
	Tue, 12 Nov 2024 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jra5ykXq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE25520512A;
	Tue, 12 Nov 2024 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402931; cv=fail; b=qVYDsPLGUz1VPNyrdbnkURtPYmqx6ZhM458vkZRcRVgGJ78EKVDLrsVEkLjEVfWYAaKjUvB9AScINa3XTvijUt2iUowgt9IXSyC6DJA/0VJl1ujggEdyEfkuDrRfv4wtgAaO01Zv5dxMjRqfmdZNc59RvqZQC+8OJoL3TD5XbjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402931; c=relaxed/simple;
	bh=MACfme9PzPI47yxClEjae2myThuFc1rbQ2uuQu5mqdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e7uYMN5I4PiRLRdI4r/6oEqYvXQjfr7C/yLtwbUno6KozSFpXdyqfz8oTjVhjp+UWqvIvejI4PlgtdTqoCaSbRpLtzXQw0BR9p2CepSqwUyQVrtW/sxE1vxp/Sa09gInBzf2ZUOLSQQTdhf5S8NUk95wOLPqJ1XbWsF7GTmd7KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jra5ykXq; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVXExF8W4zRoG4oU1VM6BeeMeMkk7CCFDOGsbzH3cuLizKb54Z9xGdGAs9mvRRSM8A5ZpYjo0kaluTiYf+g06icNruloiCfbsbtHWWvIrFJMkEiRuWwJUb2F9h4bgCroqguvV/sQgHv/LbTurohvKQed3g2DEehNYxZnqvm8HG2y/OgPu7bjbtc6gq7kVBgWBztdry5aVUMmBlof4ZuKBwbmBjml/iyf+xR6SGf5mbHnyBoSAGYBjfSiZgqimxhmPPo6JgCkVBAuixXpYCG9GD71769urzpXk4TnzcshQQO77cPwgPMRUsEGoE9kJolBzooTYXIl1Bt4yr7EgYT2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MACfme9PzPI47yxClEjae2myThuFc1rbQ2uuQu5mqdI=;
 b=izOJXS0qPnEysK2xXsBttUsEW47Gv9TcJiygI02PNzechTDwOiTj5iYRAidIjrYqSKHbJ0qk7qy6whtYpCoBCoDKA44e1s8XtfU4UsKBXoW3T5nt5L+bMb4NmpSki0BKDatODRmab+zRy5UrZXa5HIzJ+BQ/vAWNQ/yotbdMftgfvonT5xED/br1WWQ2Xj7kn3eOzMjQ4gX/+4mcMNuhsmNwwvZu29QmKr2/QMvcU/rHWFErqotNXz3zD2rZnUibEzyK1kNSPuUEPIVkrjprlNcMAr2TEl45Fea07E4JAeQJIKE/l5KP8mw4fqhEb/h2GTkw9upSfI+PM0UF8nctTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MACfme9PzPI47yxClEjae2myThuFc1rbQ2uuQu5mqdI=;
 b=jra5ykXqQ2wkvHhwYo3ZsThExK26SstNim9uqNz4veE9Fo8IoQl91KSFASOsleCeXQmF02G6IpqMM3WGlaC9i5lumoO0FYo0K0Ehs7Jp2Z1V3/FfeORTUVet1/eMzNoOPQ3MXKFyzkxu3tXC+EPOi2fFH0TpLhFzb4Vrdg/VNjybEO16/ODmMLsw/YYQ+tjT7a3SMAjorAwlBHSq1+7ffq6zj0tl971h0uC8jMEBw6YCq+IIptHi1Dg9AI7O+4BE/EiTQTH6FJ2+Tu5l4whQ4fLuqMNyUktlSc58pIv6mqKVnkxlO5QDKp+OGCBjK38vHgBAW7MwU4calh1VXvriyQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8690.eurprd04.prod.outlook.com (2603:10a6:20b:429::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 09:15:25 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:15:25 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Frank Li
	<frank.li@nxp.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Thread-Topic: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Thread-Index:
 AQHbMO/ydVggfwMlw0SMjZ6nwDplE7KrqksAgADc9oCABRdHAIAAwdkAgADwHwCAABMQkA==
Date: Tue, 12 Nov 2024 09:15:25 +0000
Message-ID:
 <AS8PR04MB86769CB7A25283A4E252477D8C592@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241107111334.n23ebkbs3uhxivvm@thinkpad>
 <20241108002425.GA1631063@bhelgaas>
 <20241111060902.mdbksegqj5rblqsn@thinkpad>
 <ZzJCGkenhxgJxoC4@lizhi-Precision-Tower-5810>
 <20241112080216.6kzdybe2su5ozp44@thinkpad>
In-Reply-To: <20241112080216.6kzdybe2su5ozp44@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8690:EE_
x-ms-office365-filtering-correlation-id: 4e8e89bd-fbec-4a1d-8921-08dd02fa8b1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3JrL3VCR0YvSkxrY3c0WSswb1hmbjJvV0VoY2U1VkUxcmJrN01NOG81VUE3?=
 =?utf-8?B?MGs0cFd6OVF2cmNES3pRNWJwcVdwZG82OXJ6ckxScGdJU1pncUpyQkdFWEhJ?=
 =?utf-8?B?bzlxR2pobmdPd25KdDArU2VxS3ErV3M4MzFhVDRUbFhOT0tYNTM0SndzMS9I?=
 =?utf-8?B?M09abEk0S0ZRb2p5TFVDTTYwWWJYaGg0QitQT3g4MEVYTFlySW9IcmY2Wnkv?=
 =?utf-8?B?cTloUk5Ka1JFTG1tVXRDZTRsaWpQQWxwQXZXWjROdVByRnBJdUk3K1BjaWtx?=
 =?utf-8?B?RXA5alV0Y0RXUXMxRUdFSUQycHE0TFJQMmhZQ2ZxYi9uYUNmaDh2TjN2RERL?=
 =?utf-8?B?UVViUXhxVU9yTUdYL0ZYbTRSR2ZpLzJ3SlBmck1GREsyaVI5UGtudzEvV1pL?=
 =?utf-8?B?SFNLTzE4akVJYWMrL3ZSOWFCUEs4SEVCUUNWMzN0WURlVXB0dzlIQ3hyL2lS?=
 =?utf-8?B?VU9rK2dHQ0xnclRPeVI0cGRSQmdRMWxKRG5uOHBpcFM5NVVNb2hpNHdONE5q?=
 =?utf-8?B?eHFsZ1lUbEhyK2xVWFVEdkViR0tFNTBxbm9hWjJzZFhPMXM1TTFyMS9GMXRi?=
 =?utf-8?B?TlRLNWxQVVl4WDdKQ2thcmFkdzNvR2d0TUFGanhPNGQ4V1BYR2VHa2NnNUdR?=
 =?utf-8?B?ZC83azBYOS9TbXNCREJmN0lhTXpQd0NYdzhpTjdkKzJOaFFRcGhVdmNVQWdt?=
 =?utf-8?B?RHNHUVZJZi9UWHJlNm1FYzVxaFMvTFcreGRPbmllc1dTOFhzWVdVR2VLbzVC?=
 =?utf-8?B?RnhBTE9jSE41WjNPRUZhTkVmOHZkZjJYM2grQk1aTEhQUWloMFhVaGpaVjR6?=
 =?utf-8?B?ZGVBeitnRzY5UEJnS0puWkdPMzFkMmJpUk04MTg5TVlBTEtDcDA4UW90Y0JQ?=
 =?utf-8?B?OGlVTjRMUlpxQVJkbksraFhjTmROcUxpNFN4V1d3TXZBbHF4T1U4bm1IZ2VF?=
 =?utf-8?B?Vk05SGE3TGdGZ242VlBiZ2IzQXJWQUZhVjgvbXlzT2R5UUZneC92UXJNbkQ2?=
 =?utf-8?B?ejB4NDlPc1BzNVNIVDJTZlZBMEg3ZjNjYUpnRnBQT1l1YjhMUDhQZEhIRTBm?=
 =?utf-8?B?dFhKa2RNTTFMRStsS2dqSDAxNWdFb2Y5UTdPeTRKcUlhOThmUDZmczZmU3d2?=
 =?utf-8?B?ZGJVOEt2OGtHNGFUWDFuUzZPbzBFaVdTSkdhRDBYbEdJYUh2ZjJRQzM0SjhY?=
 =?utf-8?B?M3hGS0NIa0xoNkR3Q1d1SStkZTRoQ3d3YXR1NHV5Q2xRM2E5aS90czlneE9x?=
 =?utf-8?B?cU5nMXNJRW5WUGU4RlZzZEpxcVBCYzllWHBKYXBRblA5WEZSQWkweHBUZEkv?=
 =?utf-8?B?TTBzU3ZoNStZUXQyakc1Ym1qZFRUcUJqdnJTZE9LV3pIMnlCZ1FLVjlTUGhw?=
 =?utf-8?B?RHBlQVhpby9JN2ZnR1dDR0dPZ2dUTUlPR0x3Y1pEanhIdXRRSS9CdWZxaU1r?=
 =?utf-8?B?SStVdmFmdUhFcmtNcU05R0oyVDAxWEY3Mk42V0pvVGxUNS92OFh4UDZJSGZZ?=
 =?utf-8?B?THJLQWwzTUNWM3dQdDZQbEluT2o0b2FrTU9LNmpCVEhUdTJ2Z3ZsZGdEQ0Zl?=
 =?utf-8?B?MDFGVURveFNKMUJDSlBnNmdVbTk1K2ZSZ1ZIYmFTQ29XRWpzOGJaUHdSZWRE?=
 =?utf-8?B?QTE3N01iMXQvWDAyTVp1Y0ZzSUx2dzFCemlBWU9DbGZsU0dWcG5GbVFMcjU3?=
 =?utf-8?B?Qi9NY2tKMHBxbXF1Q0tVdXBPRTV3QmVEa2FFMC8yS2w4L3dpcGNKVGpjTGJM?=
 =?utf-8?B?RWNtdDdJd1U5d0ZwLzl1NXJ3cm81UitsTkd4c2huOGdRR0dXWFZvV2hnaWRH?=
 =?utf-8?Q?QwBia4LNB98bJ1DFecK2y5TeqdtvqPlLNzzAU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEpFT3BmSFN6RlpnNytHWUpSYlFyWVQydk9UVTIzRHVXSWpZMzVSUDUwMS9k?=
 =?utf-8?B?N0xncnZYdm1uQ0dHdmplWjJBZmVBWURvQWMvWmQ3WVpleGljb3YxOUx3U2Uv?=
 =?utf-8?B?RTRGZVBkczEyTUZvY3huTWJrRjY4RHI2ZEdNWDJSdFZRMlM0K2pBd05ybFZ3?=
 =?utf-8?B?QlVSUU5vY0w2SmlTTTZraStKU0pKbFhKMGsyMWl6VkV0VFZSMEMyLy9kaVVh?=
 =?utf-8?B?b3d0NWR0aGJNMHBVcGg3OXZHZ3V6U1R4dkZSQ1dQTVFQYk1md1NzZUYwN0ZQ?=
 =?utf-8?B?UERZQ0Q3dXlEUkZKbWNtdngrRFNWeW55c0QyRzlJNmdXc0V6b1laTElaL3NL?=
 =?utf-8?B?ZWhzcWR0WFNEWW1FT3Fqd29RWHM0N0xpMDhHdzFCSEowSlV3aklCN3hUMDVI?=
 =?utf-8?B?TkRxNzBzUGtMWG9MRkNVQklFNmpEYTR4ZXMzWHpxWDNBOFNBSE0raUlUS2pJ?=
 =?utf-8?B?TmI4UG13RGNoVStzc2pOd1hNLzA3UktWWlRRVkMzZmNHY0Q4WlpoOTkrWWxz?=
 =?utf-8?B?dUZqc3NobFMreHN6cWVHVG9veC9oWCtDTG9CSVN3OVcvTTZrN05ISmhzNzhs?=
 =?utf-8?B?ZkVMcnhwSURwMmVlU3NoQWxDSlBNaElUMXNKdElxZTVSd1RKTmYxcUE4TTUz?=
 =?utf-8?B?UjM3VnVXR0cyZUxyVXFFdnJxYmtlekRYckNFYTM0YTBodUp4SEJydHFRaHF3?=
 =?utf-8?B?OC9jUjJORVA1alFNUkNCREdnM0c3R1luNDNYSU8xRS9HQWJaYjQzQzBHbTBU?=
 =?utf-8?B?YnFLQ2hBb2lEYjJCYW8vZkJnWHdiRHNWZkJVb1VBUk9ndDBQVGgvMTNLZ2wz?=
 =?utf-8?B?RzNRNzBKM04wQ0xqYTNaWXI3ZFlmNTU2V3Fkdk8zT21RdWU4S2VuL09xQ2cr?=
 =?utf-8?B?a1h4MDFHVzdvNmY4UTU2cWRDc1B5SGtPNXJYckcrcWphM3Y5WWQxeGkrZnJQ?=
 =?utf-8?B?UVBnbVZiMWFkOWt1SjVRSUpQV0oreHZiMlB1YkVWUkRaUEdDYXhQeVdGOEE0?=
 =?utf-8?B?aTdHekx6SzhtQlJhbk12TlZTbzFGbG5GeXM1U3hPSVc3ZUpVQTBaOW1FWTdz?=
 =?utf-8?B?Yk5JdEdEZFl3QVpkcXhjZ0IwTGVLMXJ5ZE5qRUFUT1VJTDVUcUdZOVNaMjNP?=
 =?utf-8?B?L3cwZk9CNzd3aDNRa21SM0ZQZ25wMnJaMC9OR1VqdzVzd2FDU3pHUUpucUhV?=
 =?utf-8?B?eG5UN2wyb2lldHFDUjVQVnFXTTY1akxGOHNQb1d2WjNnWFdreUtKN0RCM3JX?=
 =?utf-8?B?ZHFNTXlTKzQ5b3I3UVNSb3VQWXV6V3draVZ6cFlNWEtHWjViRFV0T1dTUFdV?=
 =?utf-8?B?RTg5TStxcmpvdm9EM1NNZzhaTGtLRGFXRDAyRmtLNDFwb3hkYzkrUW1YZ0gz?=
 =?utf-8?B?SitXamFCUjlLNHF0TmdsWHdadklGMHFTTFE0MS9jWHNjUEwyV3lOL0lmS0JP?=
 =?utf-8?B?NFZrM2oydzJWV1ViVU5ORndIbXgwL1ZjV0JjSEhIaFlYZmZycUJndS9BYzE3?=
 =?utf-8?B?YStVUVpacFE2REJuVjVVUGRIS1NvcGtBMXhNQ1Y0UGFqVU5zMmFFQjFnbjRF?=
 =?utf-8?B?SFV5QXFTUzA2WUVISnFkdVBkMjk5TlM1NENNZWg4RXF0cjVuKy9vSXJOSEpM?=
 =?utf-8?B?eXJCaFIzYlNVd1MwT2hUZUgxK016MTR2Y3RWalpMek9HR2RCRi9xNmFFS3ZN?=
 =?utf-8?B?b1hUL2NGQ2VTc05ySysvWnVTekNrU1BDZmpQRGVZcklYN0NvY2N4K3F0a1li?=
 =?utf-8?B?ZW1SZzUxWXhTUXVEQ2QwOVN4RzdIdzN6OWlicitNRWtHUEtPRVFpV3Z3SjVv?=
 =?utf-8?B?ZVpLczN5MTVkbkJDSHBvcWRacWpqRWszUmRSNDJrRisvQ09kam1NTDcrU2NT?=
 =?utf-8?B?K3NMNGU1OEZMMzNTdmg0UXhBYUd6dHN2M1J4bUJzQWxvSDFrU2hlRG5mQ3FL?=
 =?utf-8?B?QVZnRFFWQnFpV2ZDbFlieTQ5SUJiM3k5NDczbEFqL0VudzBRdmRiU1lRMTB0?=
 =?utf-8?B?NlNsaC9CN0VFd3MwL1NZU0k5QzdVVHJqZjRjendGRHRsV1VhUnp4UHpsdXFY?=
 =?utf-8?B?KzZpdVViSGRSVVVKcHZLQlp2YlBTdlB1R1BoaEFEdjd4U1JyOWhpd25LM2Rp?=
 =?utf-8?Q?isc669ejhD336lzdvbdkmaAIL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8e89bd-fbec-4a1d-8921-08dd02fa8b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 09:15:25.5431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MM4psovO0Nysu9bnDIgK7TPxPfsravBnwlBWcDxo5Y2eqSFvXSt0lsz0qLYAZBWi8+uGsjcDcThA4Dc8LY5aBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8690

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI05bm0MTHm
nIgxMuaXpSAxNjowMg0KPiBUbzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+DQo+IENjOiBC
am9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+OyBIb25neGluZyBaaHUNCj4gPGhvbmd4
aW5nLnpodUBueHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207IGJoZWxnYWFzQGdvb2dsZS5j
b207DQo+IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5v
cmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgbGludXgt
cGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYxXSBQQ0k6IGR3YzogQ2xlYW4gdXAgc29tZSB1bm5lY2Vzc2Fy
eSBjb2RlcyBpbg0KPiBkd19wY2llX3N1c3BlbmRfbm9pcnEoKQ0KPiANCj4gT24gTW9uLCBOb3Yg
MTEsIDIwMjQgYXQgMTI6NDI6NTBQTSAtMDUwMCwgRnJhbmsgTGkgd3JvdGU6DQo+ID4gT24gTW9u
LCBOb3YgMTEsIDIwMjQgYXQgMTE6Mzk6MDJBTSArMDUzMCwgTWFuaXZhbm5hbiBTYWRoYXNpdmFt
DQo+IHdyb3RlOg0KPiA+ID4gT24gVGh1LCBOb3YgMDcsIDIwMjQgYXQgMDY6MjQ6MjVQTSAtMDYw
MCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gPiA+ID4gT24gVGh1LCBOb3YgMDcsIDIwMjQgYXQg
MTE6MTM6MzRBTSArMDAwMCwgTWFuaXZhbm5hbiBTYWRoYXNpdmFtDQo+IHdyb3RlOg0KPiA+ID4g
PiA+IE9uIFRodSwgTm92IDA3LCAyMDI0IGF0IDA0OjQ0OjU1UE0gKzA4MDAsIFJpY2hhcmQgWmh1
IHdyb3RlOg0KPiA+ID4gPiA+ID4gQmVmb3JlIHNlbmRpbmcgUE1FX1RVUk5fT0ZGLCBkb24ndCB0
ZXN0IHRoZSBMVFNTTSBzdGF0LiBTaW5jZQ0KPiA+ID4gPiA+ID4gaXQncyBzYWZlIHRvIHNlbmQg
UE1FX1RVUk5fT0ZGIG1lc3NhZ2UgcmVnYXJkbGVzcyBvZiB3aGV0aGVyDQo+ID4gPiA+ID4gPiB0
aGUgbGluayBpcyB1cCBvciBkb3duLiBTbywgdGhlcmUgd291bGQgYmUgbm8gbmVlZCB0byB0ZXN0
IHRoZQ0KPiA+ID4gPiA+ID4gTFRTU00gc3RhdCBiZWZvcmUgc2VuZGluZyBQTUVfVFVSTl9PRkYg
bWVzc2FnZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFdoYXQgaXMgdGhlIGluY2VudGl2ZSB0byBz
ZW5kIFBNRV9UdXJuX09mZiB3aGVuIGxpbmsgaXMgbm90IHVwPw0KPiA+ID4gPg0KPiA+ID4gPiBU
aGVyZSdzIG5vIG5lZWQgdG8gc2VuZCBQTUVfVHVybl9PZmYgd2hlbiBsaW5rIGlzIG5vdCB1cC4N
Cj4gPiA+ID4NCj4gPiA+ID4gQnV0IGEgbGluay11cCBjaGVjayBpcyBpbmhlcmVudGx5IHJhY3kg
YmVjYXVzZSB0aGUgbGluayBtYXkgZ28NCj4gPiA+ID4gZG93biBiZXR3ZWVuIHRoZSBjaGVjayBh
bmQgdGhlIFBNRV9UdXJuX09mZi4gIFNpbmNlIGl0J3MNCj4gPiA+ID4gaW1wb3NzaWJsZSBmb3Ig
c29mdHdhcmUgdG8gZ3VhcmFudGVlIHRoZSBsaW5rIGlzIHVwLCB0aGUgUm9vdCBQb3J0DQo+ID4g
PiA+IHNob3VsZCBiZSBhYmxlIHRvIHRvbGVyYXRlIGF0dGVtcHRzIHRvIHNlbmQgUE1FX1R1cm5f
T2ZmIHdoZW4gdGhlIGxpbmsNCj4gaXMgZG93bi4NCj4gPiA+ID4NCj4gPiA+ID4gU28gSU1PIHRo
ZXJlJ3Mgbm8gbmVlZCB0byBjaGVjayB3aGV0aGVyIHRoZSBsaW5rIGlzIHVwLCBhbmQNCj4gPiA+
ID4gY2hlY2tpbmcgZ2l2ZXMgdGhlIG1pc2xlYWRpbmcgaW1wcmVzc2lvbiB0aGF0ICJ3ZSBrbm93
IHRoZSBsaW5rIGlzDQo+ID4gPiA+IHVwIGFuZCB0aGVyZWZvcmUgc2VuZGluZyBQTUVfVHVybl9P
ZmYgaXMgc2FmZS4iDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gSSBhZ3JlZSB0aGF0IHRoZSBjaGVj
ayBpcyByYWN5IChub3Qgc3VyZSBpZiB0aGVyZSBpcyBhIGJldHRlciB3YXkgdG8NCj4gPiA+IGF2
b2lkIHRoYXQpLCBidXQgaWYgeW91IHNlbmQgdGhlIFBNRV9UdXJuX09mZiB1bmNvbmRpdGlvbmFs
bHksIHRoZW4NCj4gPiA+IGl0IHdpbGwgcmVzdWx0IGluDQo+ID4gPiBMMjMgUmVhZHkgdGltZW91
dCBhbmQgdXNlcnMgd2lsbCBzZWUgdGhlIGVycm9yIG1lc3NhZ2UuDQo+ID4gPg0KPiA+ID4gPiA+
ID4gUmVtb3ZlIHRoZSBMMiBwb2xsIHRvbywgYWZ0ZXIgdGhlIFBNRV9UVVJOX09GRiBtZXNzYWdl
IGlzIHNlbnQNCj4gPiA+ID4gPiA+IG91dC4gIEJlY2F1c2UgdGhlIHJlLWluaXRpYWxpemF0aW9u
IHdvdWxkIGJlIGRvbmUgaW4NCj4gPiA+ID4gPiA+IGR3X3BjaWVfcmVzdW1lX25vaXJxKCkuDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBBcyBLcmlzaG5hIGV4cGxhaW5lZCwgaG9zdCBuZWVkcyB0byB3
YWl0IHVudGlsIHRoZSBlbmRwb2ludCBhY2tzDQo+ID4gPiA+ID4gdGhlIG1lc3NhZ2UgKGp1c3Qg
dG8gZ2l2ZSBpdCBzb21lIHRpbWUgdG8gZG8gY2xlYW51cHMpLiBUaGVuDQo+ID4gPiA+ID4gb25s
eSB0aGUgaG9zdCBjYW4gaW5pdGlhdGUgRDNDb2xkLiBJdCBtYXR0ZXJzIHdoZW4gdGhlIGRldmlj
ZSBzdXBwb3J0cw0KPiBMMi4NCj4gPiA+ID4NCj4gPiA+ID4gVGhlIGltcG9ydGFudCB0aGluZyBo
ZXJlIGlzIHRvIGJlIGNsZWFyIGFib3V0IHRoZSAqcmVhc29uKiB0byBwb2xsDQo+ID4gPiA+IGZv
cg0KPiA+ID4gPiBMMiBhbmQgdGhlICpldmVudCogdGhhdCBtdXN0IHdhaXQgZm9yIEwyLg0KPiA+
ID4gPg0KPiA+ID4gPiBJIGRvbid0IGhhdmUgYW55IERlc2lnbldhcmUgc3BlY3MsIGJ1dCB3aGVu
DQo+ID4gPiA+IGR3X3BjaWVfc3VzcGVuZF9ub2lycSgpIHdhaXRzIGZvciBEV19QQ0lFX0xUU1NN
X0wyX0lETEUsIEkgdGhpbmsNCj4gPiA+ID4gd2hhdCB3ZSdyZSBkb2luZyBpcyB3YWl0aW5nIGZv
ciB0aGUgbGluayB0byBiZSBpbiB0aGUgTDIvTDMgUmVhZHkNCj4gPiA+ID4gcHNldWRvLXN0YXRl
IChQQ0llIHI2LjAsIHNlYyA1LjIsIGZpZyA1LTEpLg0KPiA+ID4gPg0KPiA+ID4gPiBMMiBhbmQg
TDMgYXJlIHN0YXRlcyB3aGVyZSBtYWluIHBvd2VyIHRvIHRoZSBkb3duc3RyZWFtIGNvbXBvbmVu
dA0KPiA+ID4gPiBpcyBvZmYsIGkuZS4sIHRoZSBjb21wb25lbnQgaXMgaW4gRDNjb2xkIChyNi4w
LCBzZWMgNS4zLjIpLCBzbw0KPiA+ID4gPiB0aGVyZSBpcyBubyBsaW5rIGluIHRob3NlIHN0YXRl
cy4NCj4gPiA+ID4NCj4gPiA+ID4gVGhlIFBNRV9UdXJuX09mZiBoYW5kc2hha2UgaXMgcGFydCBv
ZiB0aGUgcHJvY2VzcyB0byBwdXQgdGhlDQo+ID4gPiA+IGRvd25zdHJlYW0gY29tcG9uZW50IGlu
IEQzY29sZC4gIEkgdGhpbmsgdGhlIHJlYXNvbiBmb3IgdGhpcw0KPiA+ID4gPiBoYW5kc2hha2Ug
aXMgdG8gYWxsb3cgYW4gb3JkZXJseSBzaHV0ZG93biBvZiB0aGF0IGNvbXBvbmVudCBiZWZvcmUN
Cj4gPiA+ID4gbWFpbiBwb3dlciBpcyByZW1vdmVkLg0KPiA+ID4gPg0KPiA+ID4gPiBXaGVuIHRo
ZSBkb3duc3RyZWFtIGNvbXBvbmVudCByZWNlaXZlcyBQTUVfVHVybl9PZmYsIGl0IHdpbGwgc3Rv
cA0KPiA+ID4gPiBzY2hlZHVsaW5nIG5ldyBUTFBzLCBidXQgaXQgbWF5IGFscmVhZHkgaGF2ZSBU
TFBzIHNjaGVkdWxlZCBidXQNCj4gPiA+ID4gbm90IHlldCBzZW50LiAgSWYgcG93ZXIgd2VyZSBy
ZW1vdmVkIGltbWVkaWF0ZWx5LCB0aGV5IHdvdWxkIGJlDQo+ID4gPiA+IGxvc3QuICBNeSB1bmRl
cnN0YW5kaW5nIGlzIHRoYXQgdGhlIGxpbmsgd2lsbCBub3QgZW50ZXIgTDIvTDMNCj4gPiA+ID4g
UmVhZHkgdW50aWwgdGhlIGNvbXBvbmVudHMgb24gYm90aCBlbmRzIGhhdmUgY29tcGxldGVkIHdo
YXRldmVyDQo+ID4gPiA+IG5lZWRzIHRvIGJlIGRvbmUgd2l0aCB0aG9zZSBUTFBzLiAgKFRoaXMg
aXMgYmFzZWQgb24gdGhlIEwyL0wzDQo+ID4gPiA+IGRpc2N1c3Npb24gaW4gdGhlIE1pbmRzaGFy
ZSBQQ0llIGJvb2s7IEkgaGF2ZW4ndCBmb3VuZCBjbGVhciBzcGVjDQo+ID4gPiA+IGNpdGF0aW9u
cyBmb3IgYWxsIG9mIGl0LikNCj4gPiA+ID4NCj4gPiA+ID4gSSB0aGluayB3YWl0aW5nIGZvciBM
Mi9MMyBSZWFkeSBpcyB0byBrZWVwIHVzIGZyb20gdHVybmluZyBvZmYNCj4gPiA+ID4gbWFpbiBw
b3dlciB3aGVuIHRoZSBjb21wb25lbnRzIGFyZSBzdGlsbCB0cnlpbmcgdG8gZGlzcG9zZSBvZiB0
aG9zZQ0KPiBUTFBzLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IE5vdCBqdXN0IGRpc3Bvc2luZyBU
TFBzIGFzIHBlciB0aGUgc3BlYywgbW9zdCBlbmRwb2ludHMgYWxzbyBuZWVkIHRvDQo+ID4gPiBy
ZXNldCB0aGVpciBzdGF0ZSBtYWNoaW5lIGFzIHdlbGwgKGlmIHRoZXJlIGlzIGEgd2F5IGZvciB0
aGUNCj4gPiA+IGVuZHBvaW50IHN3IHRvIGRlbGF5IHNlbmRpbmcNCj4gPiA+IEwyMyBSZWFkeSku
DQo+ID4gPg0KPiA+ID4gPiBTbyBJIHRoaW5rIGV2ZXJ5IGNvbnRyb2xsZXIgdGhhdCB0dXJucyBv
ZmYgbWFpbiBwb3dlciBuZWVkcyB0bw0KPiA+ID4gPiB3YWl0IGZvciBMMi9MMyBSZWFkeS4NCj4g
PiA+ID4NCj4gPiA+ID4gVGhlcmUncyBhbHNvIGEgcmVxdWlyZW1lbnQgdGhhdCBzb2Z0d2FyZSB3
YWl0IGF0IGxlYXN0IDEwMCBucw0KPiA+ID4gPiBhZnRlcg0KPiA+ID4gPiBMMi9MMyBSZWFkeSBi
ZWZvcmUgdHVybmluZyBvZmYgcmVmY2xvY2sgYW5kIG1haW4gcG93ZXIgKHNlYw0KPiA+ID4gPiA1
LjMuMy4yLjEpLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFJpZ2h0LiBVc3VhbGx5LCB0aGUgZGVs
YXkgYWZ0ZXIgUEVSU1QjIGFzc2VydCB3b3VsZCBtYWtlIHN1cmUgdGhpcywNCj4gPiA+IGJ1dCBp
biBsYXllcnNjYXBlIGRyaXZlciAodXNlciBvZiBkd19wY2llX3N1c3BlbmRfbm9pcnEpIEkgZG9u
J3Qgc2VlDQo+ID4gPiBwb3dlci9yZWZjbGsgcmVtb3ZhbC4NCj4gPiA+DQo+ID4gPiBSaWNoYXJk
IFpodS9GcmFuaywgdGhvdWdodHM/DQo+ID4NCj4gPiBHZW5lcmFsbHksIHBvd2VyL3JlZmNsayBy
ZW1vdmUgd2hlbiBzeXN0ZW0gZW50ZXIgc2xlZXAgc3RhdGUuIFRoZXJlIGlzDQo+ID4gc2lnbmFs
ICJzdXNwZW5kX3JlcXVlc3RfYiIsIHdoaWNoIGNvbm5lY3QgdG8gUE1JQy4gQWZ0ZXIgQ1BVIHRy
aWdnZXINCj4gPiB0aGlzIHNpZ25uYWwsIFBNSUMgd2lsbCB0dXJuIG9mZiAocHJlIGZ1c2VkKSBz
b21lIHBvd2VyIHJhaWwuDQo+ID4NCj4gPiBSZWZjbGsoY29tZSBmcm9tIFNPQyBjaGlwKSwgT1ND
IHdpbGwgYmUgc2h1dGRvd24gd2hlbiBzZW5kIG91dA0KPiA+ICJzdXNwZW5kX3JlcXVlc3RfYiIu
DQo+ID4NCj4gDQo+IFRoYW5rcyBmb3IgY2xhcmlmeWluZyEgVGhlbiBpdCB3b3VsZCBiZSBiZXR0
ZXIgdG8gYWRkIHRoZSAxMDBucyBkZWxheSBhZnRlcg0KPiByZWNlaXZpbmcgdGhlIEwyMyBSZWFk
eSBtZXNzYWdlIGZyb20gZW5kcG9pbnQuDQpPa2F5Lg0KSG93IGFib3V0IHRoZSBmb2xsb3dpbmcg
Y2hhbmdlcz8NCi0gQmVmb3JlIGR1bXAgZXJyb3IgbWVzc2FnZSwgbWFrZSBzdXJlIGxpbmsgaXMg
dXAuDQotIEFkZCAxdXMgZGVsYXkgYWZ0ZXIgTDIvTDMgUmVhZHkgaXMgcmVjZWl2ZWQuDQoNCi0t
LSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCisr
KyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCkBA
IC05NDAsOSArOTQwLDE2IEBAIGludCBkd19wY2llX3N1c3BlbmRfbm9pcnEoc3RydWN0IGR3X3Bj
aWUgKnBjaSkNCiAgICAgICAgICAgICAgICByZXQgPSByZWFkX3BvbGxfdGltZW91dChkd19wY2ll
X2dldF9sdHNzbSwgdmFsLCB2YWwgPT0gRFdfUENJRV9MVFNTTV9MMl9JRExFLA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBDSUVfUE1FX1RPX0wyX1RJTUVPVVRfVVMv
MTAsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUENJRV9QTUVfVE9f
TDJfVElNRU9VVF9VUywgZmFsc2UsIHBjaSk7DQotICAgICAgICAgICAgICAgaWYgKHJldCkgew0K
KyAgICAgICAgICAgICAgIGlmIChyZXQgJiYgZHdfcGNpZV9saW5rX3VwKHBjaSkpIHsNCiAgICAg
ICAgICAgICAgICAgICAgICAgIGRldl9lcnIocGNpLT5kZXYsICJUaW1lb3V0IHdhaXRpbmcgZm9y
IEwyIGVudHJ5ISBMVFNTTTogMHgleFxuIiwgdmFsKTsNCiAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiByZXQ7DQorICAgICAgICAgICAgICAgfSBlbHNlIHsNCisgICAgICAgICAgICAgICAg
ICAgICAgIC8qDQorICAgICAgICAgICAgICAgICAgICAgICAgKiBSZWZlciB0byByNi4wLCBzZWMg
NS4zLjMuMi4xLCBzb2Z0d2FyZSBzaG91bGQgd2FpdCBhdA0KKyAgICAgICAgICAgICAgICAgICAg
ICAgICogbGVhc3QgMTAwbnMgYWZ0ZXIgTDIvTDMgUmVhZHkgYmVmb3JlIHR1cm5pbmcgb2ZmDQor
ICAgICAgICAgICAgICAgICAgICAgICAgKiByZWZjbG9jayBhbmQgbWFpbiBwb3dlci4NCisgICAg
ICAgICAgICAgICAgICAgICAgICAqLw0KKyAgICAgICAgICAgICAgICAgICAgICAgdWRlbGF5KDEp
Ow0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiAtIE1hbmkNCj4gDQo+IC0tDQo+
IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==


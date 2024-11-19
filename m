Return-Path: <linux-pci+bounces-17060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFD59D1FA0
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 06:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FBE1F2188B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 05:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A54149C57;
	Tue, 19 Nov 2024 05:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GrCvfASV"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6D42563;
	Tue, 19 Nov 2024 05:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731994716; cv=fail; b=CK1Z+q/z4pWGYAKXA+p5UcwgZ9kY+jFSW1GNvvPRvgJGFgryrV1KmFGG0hJGcjyjXV5puO0d42AiKpVpHuMAWEFWQZqt3MWzln4ACdodpW4fbSWc/LiBBJUf8BLrxxKVC4uE+jZIEBuva6evqr4gs0EA38tSofHJXssgVIv1A2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731994716; c=relaxed/simple;
	bh=2wMGiYkK3syYAvsZKVfu/BMFwK+VD94tFfQV1+BXy9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=daiNJDpLGqz1plEtuAbKA2HqiHkejqlHzFh6hqySYOmeWEWANTL0gC1oODeyq/rRPtgcXgDh2a9HTXXykb/3a52DRZ2apb4PMqTN0PBeM62JhG/iW3kmuMQ3TInd2dSdPOSrgIUNNamu3GaH2B69qJ5zJEm3/gxzUQX/TPI8lJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GrCvfASV; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHpbUE4wrLTxpNumE3pB1WML0btK02sjL+906Q16diDrr+RP1sXyjXIZR84tNfzOLjSSNoTzo/WUPs16iUhulkCN77ixjlSb8k7Gw5YAOsS4iM5WVp3Ra+7vaVEjZR0nQPfRHd33K+wtXhLlEzcuPEOWlV3ije2y4Tuedf1YGiAGiHPKXEvkvloskm0GpziLRIH72weiahWxaH+YLYMvCsmVRQXg7W+rr/GSpDUYgf3tzq1EcabiG7bM2YbqfgnA3QB49dUr5iKE1BbserOZsK0LscE02cYlfZUZ//8bHjv8wrygczvSeTn4gEcSu0BcfuisRcqKujVmQxKIIS/4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wMGiYkK3syYAvsZKVfu/BMFwK+VD94tFfQV1+BXy9k=;
 b=g/yZz21ThsLygY53PnVhi2n8bESehWAkrfgOM1xMkP2poa2kmoO2Rj8RdK2uM0yL0rfAuXd5ROqL18tESRmtOGc4IpgCuDZ54oH5v8OO/iVnV1eisE27SIIuS14erexNRBKChdmZRl3nuVMKCGa6oI9mabQaDQ9jh0L85qOZTkDnRPJh1yQHxW3siT0W0zzQaMiHMkgHbfrhvxIJmw58BPqxIPLV4zrKyx2UgYzpYt8W7UC+g4Q/VFjSRL3VDuJvItySzjs7QAIyOppCdM5K/k+6XzyNLhhZ9P+8QIKd34y+ttz9sE7t+5Er5Z8ZaPior2V9g1+D6LsQ69xyrZmyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wMGiYkK3syYAvsZKVfu/BMFwK+VD94tFfQV1+BXy9k=;
 b=GrCvfASVwQvFx5BpogljByvtHY4QLJ6oo+yi1RzpfUVEft8/KJgdq1ECTrS6aLIHeXfJCJXn8setGbdAdnNQRyZ0qcxpe1euRZ8PZEhvzAvt5Wyoe+H9sJP1Cs7I4Bq3GqZ5j9KDOhxLWZGu6UXVNjAgZTBpaWGi54w2Cn9cqHVD5Smgs+Iid6r9CJUOx25FuSGDKrBEUOVJTut1K1fnrAFS7G4tYLqXJan0T1r0wzYgbS318OBeA0hsgp8PoB0wyOlnk2LyLbF8h/PMmJPNHoEfXtlZY8GCBkNBWDLD8CFbW0hIdF3BFLnhmvW+zWVMS23RZ4I09y6uOjyfr+0nmg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8625.eurprd04.prod.outlook.com (2603:10a6:20b:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 05:38:30 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 05:38:30 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
Thread-Topic: [PATCH v6 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
Thread-Index: AQHbLCso6MuPL2Z9qUKOGDuz4p1bP7K3+ZAAgAMyLECAAtI0QA==
Date: Tue, 19 Nov 2024 05:38:30 +0000
Message-ID:
 <AS8PR04MB8676DFD33B926A2EC57577CC8C202@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-3-hongxing.zhu@nxp.com>
 <20241115063816.xpjqgm2j34enhe7s@thinkpad>
 <AS8PR04MB86767205982E13C2771614AB8C272@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS8PR04MB86767205982E13C2771614AB8C272@AS8PR04MB8676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8625:EE_
x-ms-office365-filtering-correlation-id: 6bf50f79-6fce-4fd4-38e4-08dd085c6690
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2RSRnpvVEpwNWpPQXcyMDE0RStlV0ZLanBzcWF2TjEyNkdhdEF4TmlxRVJz?=
 =?utf-8?B?UXEyaU5uNGY2bzI3cTUvdEk0MGhFRnArWmpjN2dWVnUyMU9Qckh1bUlWeUth?=
 =?utf-8?B?V1V1eExBdDVwaSs3UVluaHRTcjBBbXlJNWtnNGtDaDlxUGcvM3M5bUxPSVAw?=
 =?utf-8?B?aTNQMGdaNnBMdTdTSlpzT3Rsci9jdDZ5d0R5dmdLQitXRmdFOFFZZzFiMTls?=
 =?utf-8?B?S1FQeWtTRmJ6dEVTVlhiaGt4SGpSSjhPODJrWS91TWU3cWJYcVY1RHpEUU1v?=
 =?utf-8?B?UDR1RGJVY2grQ1BKdkpkODUwL0xaZXhEQ2JScThLaDB0T0NyeTFnOXhTV05j?=
 =?utf-8?B?eXJMQjd2U3ZNRjI5R21VV3dETHNMSXBKSGxkYjlJLzBGQUlxalhRNTJ5MFN1?=
 =?utf-8?B?U3RDK0IvZXk2QzhOMDNLMUpiL1V3UHA0WmlVb2FBblRhbkpvSHhWZFM1V3dL?=
 =?utf-8?B?c3ZpaEl0TlhsUmJIWWJBbUo2V28xL1FSOTFBS29RUGxxVzk3N0d1aGFFbXI2?=
 =?utf-8?B?TCtsUlk5aGNlekVoT0ZGeVNBR01Pd1cvQi9VbEVTcjlFd3ljZ1ZFQ0FkSVBl?=
 =?utf-8?B?VlV0YjZFdWl2bDVyT1JZdDlwSjZmRkdsZzEwaGlueGIzZHcyNjYvOTJMSHdw?=
 =?utf-8?B?R0R6VUpNajB0LzZSak5iamZUak81bmYrSVA4Z3UwbVk2aWJublMvK3ZacE8v?=
 =?utf-8?B?ak9ES3JKR01KNkRudE1MYk5DMGdQVGs3T3hKdkNZZHhmdjV2QW9CcjRHMTd2?=
 =?utf-8?B?SlFCSkd3RmpoVnFJL1JxWDJKamZReENMdFJNeEpzcHpFd3JVY3FTUEplN3VO?=
 =?utf-8?B?TzBEM284WXk1UzY5T0lmT3NVZys3SzdkWHZpeWc0bUE5WU4rZkcvV0g4UUVq?=
 =?utf-8?B?b3pZeEpLbkFHR1ZrNEI1UHhQY1JjN25tSkZna2hZcktTQllhRjJIYlcxL3JL?=
 =?utf-8?B?NCtYaTR4Y0pVbnFQMzFXbThGVjZ2dUZjSlljR3Z0TUZaTDAyWktpNmJ0WUdk?=
 =?utf-8?B?UHAxMWZseHZGMGtscVZCUFZVanBJRFNCUGQ4ZEhrYyt3cFZpeEZ6bXRBc1gx?=
 =?utf-8?B?d1I3djhwdVFFdEN4SVVML3AyYXdVMUY5TStsMXFaSUREbThrSE5xWGtQQWVV?=
 =?utf-8?B?ZXYxcjZGQ0swZENpdWhVb09Td1VlbVM4S25NdzJrcHNqemRLbjVVU1RaYmx5?=
 =?utf-8?B?ZTZoOTBCYm9tR1hXWkpjTFgrejVLSy82S0Y1ODlDS2JCSDMxMWEzY1ZBb2li?=
 =?utf-8?B?VWRtUXY2cHV0UkFEOTNWZ1loL3ljZy9VeURXOTRyczdOOEhLczBYVFU5OFZO?=
 =?utf-8?B?K3RpVkxCSURYajRKR2t5WE8xcHo4OEZkbjc4ZzB1RVRjWGllODhNdWNaR3VR?=
 =?utf-8?B?dDA2SENtYUU0V3FuWnVCelA2S0JuYnBEY0NNKzlGODl5a3VwWXdlMFZtb1Ro?=
 =?utf-8?B?ZWxiV2dKcmJReTg1VlVvYmxJZ0luOUJzeHluRitwK1V3QlJGWXpTU0habnpx?=
 =?utf-8?B?ZVRpZktlOE9vK1RjQStkamhKMytyOTJMQWl2M1A2OXd4Rlhmc1RiTng4QnJz?=
 =?utf-8?B?T2F0a1UxS3EySmVqSFdvYVJ0ZHBqMkU3SXVBNitraE1HRzNEZ3IzVEJNaXF1?=
 =?utf-8?B?cWRUTFJxcGlRMno5Mk5KZmtaZTZBRkxJUnhXZTBaWFdEbTltU3RCNU0yby9B?=
 =?utf-8?B?TmwvK0NCV085SU9abE5WeHNHaXNYSSs5K0htMFo3azErQ3NnRS9NdUVodDB3?=
 =?utf-8?B?Sk42WC9FeHNjYVZVWUJFVDl0YmJzVDFybDhlL2YxK1dOR0VkanRKZEdMZGIz?=
 =?utf-8?Q?vY6olLds2IvW4hNoKiENLk2LI8vHvLLXo/a7A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHZwdlU1RksraEpnTFFIYUpUWU5GekpvZUtiajZhQjAyQTB0amN2YzArbkha?=
 =?utf-8?B?aHh5YVRtRlJUMWZUYnM1S0d5Y1FrS1VBM1hUdE1JYVU5QXlrT2FaOHdRRnNj?=
 =?utf-8?B?bEZ2Wno4Uk50VmFjUXVDZnMxOEdDOGpQMy9yOWhVL2xuaUx3NmxUamlOdU9s?=
 =?utf-8?B?Vzd1M2ZUMGVIM1dXY0ZwVVRGQVFOaTBqbTNjQ0dpZHVJNmZJclNRSVMxUHAz?=
 =?utf-8?B?SkZhNmlTU01iTFdJUkh6eWxZMHU1TWZPNzRDejFwRVNiNEF0M3NvUTFESG9k?=
 =?utf-8?B?OHlRSUo0UmIwVmlNblpTZ0MvdUJGZDhxLzZSc3pBYU4zUTVFSWVOZG1SOTFz?=
 =?utf-8?B?eHBnTytITG9CQ1Y0bk5MMzIvbUE3Mm1EelBwZXg2OVZDNGxuVE1neGlvQUF4?=
 =?utf-8?B?Vmo3L2M4UCtoTnVIazlNMFg0YjBEWjJDRm9hWGJNL3NsMTRWcDFZZVgrSktx?=
 =?utf-8?B?YTB5Y2p1Qno4Y0pOQ2Rhckw4UDdETm4wMU41cjNPUzE1eUNWUUlKM08vRlU3?=
 =?utf-8?B?ditYck5hbTJUZ01aTXdSMWVhUUtXR3M1S0hwNkpvWHNlOExTMmxaMDlwbEIv?=
 =?utf-8?B?SG5wYk1vdWVRam1vaXdDOGUxWDJlblNWL3NBS2x6V0R0d0NqbmFYMVMvcHNO?=
 =?utf-8?B?bER1MkJRa2FRMTZaK3R0NzF2eHgzdkVBeUpma2dMRkNkZ0ZrcDV5dGpsN3pG?=
 =?utf-8?B?cnpsQ1hBMzluRmN0dVhRbmdXNGs2cXJJYWQ2U2dhWDlvRE9WSUxOSlJ4Q3F4?=
 =?utf-8?B?ZWVLc3hza24zcGtsMGJjUVJKcktINi91dXVFcy9qb243YkJMOG9aVVB1RTNt?=
 =?utf-8?B?R3ROZzI5d3ZjR2U1ODF5bmtCWHJSUllSWXdPRjlmTExxWFUvQzB3dFhYZTVk?=
 =?utf-8?B?SWt5ZmJBelpFczRHWGQxUlBMSEROa3ovdUJoODV0VS9KaHE2dmxzRFY1bkVa?=
 =?utf-8?B?M1VoYmo2TjU1Y3d3MllEZHgwRktHMVRyLy9rUDdZKy96bHJRVGJmdlpHbWFl?=
 =?utf-8?B?aWxJWHRNK21ha09jZlB0ZFZldHNCN1dDT3NmallqSUZDVG54Q0V6dFgzRUJm?=
 =?utf-8?B?SEExRm52L2c1dDlqaTJNWVVuY2JmTnBibnJKa2YrWUtFTVlEY3MvTGF5V1FC?=
 =?utf-8?B?eWZ6aFYyamM5WktGa3A0TnB4STkwY1hQMm1YTndjSFpXaUY2QmREdGNDOEh0?=
 =?utf-8?B?M0kwLzhGVFBOQmwyd2ZqM0JnQjhMdStYWjZKM1RVQ0luazNwRUhoZVhXRGFY?=
 =?utf-8?B?Z2hpTDBKSTExVmhha1d3ZE9MdzZJUG9ZQWlFKzltaytZaVNBUmNBQmo5ZWxS?=
 =?utf-8?B?TEpIeElOeEFqTGFhMXd2YTZqNk1uZ3FsdFNrOThHdU5YOTZWQWhCcE8vS3pH?=
 =?utf-8?B?dHYwa2NZTUhYUGJTb0o0QTEwWDZRYzQ2UkowVHJOcENDRHFHeFA0TWJzemY4?=
 =?utf-8?B?RTVRVDgxWWlpRWNFV25KS1I4Mi9VdS9rYVBxUG1yRGVmMU1xVkhLTTg0NEFu?=
 =?utf-8?B?Njc1ZTJWdlBGNVpmMTkxQ1I2SXBTMkN6OTVaTUgzcmtPRGlIVWFNS1ExaUd5?=
 =?utf-8?B?T3BjUzN1QVcvYTl6Q3MxT3ZHYzcvVGhCc0YvaFFTWE9KR09WVzhPdXYydmdY?=
 =?utf-8?B?emJiQXNZZmZuUmg1MW5hU1c5eTdDZE5XT1h1Mmd3cHJCNGpwSXRvZThzckQy?=
 =?utf-8?B?Misxb2ptMFZPRW9KSkN5TzFuQzJ5bndMdGJ5ZTZyZGg0TDJTQkFZRGswWnVk?=
 =?utf-8?B?aWRCNy9CQ2NqaWt3Z2xyTFRkYnRhczVVMng0MU54T1cyMnhIN1B3VnF3SVU2?=
 =?utf-8?B?KzZSWFNoOTVJbk1jVnBqWUtwSXdVbCtlKzkzR05nNnNvbFFYdjRSNXRFWXdm?=
 =?utf-8?B?eEFOaCtvUHgwVlN0S3JGTWljQWFNb0FxQzZBRTdpK251aExRSUFWQnJrb3lj?=
 =?utf-8?B?MkdvaEtwb2xrR1RVc3hRZ0dZUmtlMGpaSDh5ZFVGeDF4SHdoMkFCV3cwQTU0?=
 =?utf-8?B?bXBLS2pmSEF3T2U0YU16QnlwS00vNVpkMG05bnMrdGFrVXR0WkZtWGkrZG9U?=
 =?utf-8?B?M0R6Q0U2Sjg5YzBZcWdFUm1xSGJDS0s2TXU4NWc3NUR5RmFBemx4Y2tYdml1?=
 =?utf-8?Q?XQQHpvB3Wq0QB2A06WC0sniJb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf50f79-6fce-4fd4-38e4-08dd085c6690
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 05:38:30.6784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QtZ5+l6HN0DKwR7TexNIDGmcSAEe8DRKE4gu2kf/DZ/AdJV3nwWOReUT06RDHdUJXOvdHGe9/ybymNGGFt5JKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8625

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb25neGluZyBaaHUNCj4gU2Vu
dDogMjAyNOW5tDEx5pyIMTjml6UgMTA6NTkNCj4gVG86IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8
bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+IENjOiBsLnN0YWNoQHBlbmd1dHJv
bml4LmRlOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBscGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+IGt3
QGxpbnV4LmNvbTsgcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0
QGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPjsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBp
bXhAbGlzdHMubGludXguZGV2OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGxpbnV4LXBjaUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4g
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogUkU6IFtQQVRDSCB2NiAwMi8xMF0gUENJOiBpbXg2OiBBZGQgcmVmIGNsb2Nr
IGZvciBpLk1YOTUgUENJZQ0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
IEZyb206IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFy
by5vcmc+DQo+ID4gU2VudDogMjAyNOW5tDEx5pyIMTXml6UgMTQ6MzgNCj4gPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiBDYzogbC5zdGFjaEBwZW5ndXRyb25p
eC5kZTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3
QGxpbnV4LmNvbTsgcm9iaEBrZXJuZWwub3JnOw0KPiA+IGtyemsrZHRAa2VybmVsLm9yZzsgY29u
b3IrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgRnJhbmsgTGkNCj4gPiA8ZnJh
bmsubGlAbnhwLmNvbT47IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNv
bTsNCj4gPiBpbXhAbGlzdHMubGludXguZGV2OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwMi8xMF0gUENJOiBpbXg2
OiBBZGQgcmVmIGNsb2NrIGZvciBpLk1YOTUgUENJZQ0KPiA+DQo+ID4gT24gRnJpLCBOb3YgMDEs
IDIwMjQgYXQgMDM6MDY6MDJQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gPiBBZGQg
InJlZiIgY2xvY2sgdG8gZW5hYmxlIHJlZmVyZW5jZSBjbG9jay4gVG8gYXZvaWQgdGhlIERUDQo+
ID4gPiBjb21wYXRpYmlsaXR5LCBpLk1YOTUgUkVGIGNsb2NrIG1pZ2h0IGJlIG9wdGlvbmFsLg0K
PiA+DQo+ID4gWW91ciB3b3JkaW5nIGlzIG5vdCBjb3JyZWN0LiBQZXJoYXBzIHlvdSB3YW50ZWQg
dG8gc2F5LCAiVG8gYXZvaWQNCj4gPiBicmVha2luZyBEVCBiYWNrd2FyZHMgY29tcGF0aWJpbGl0
eSI/DQo+ID4NCj4gWWVzLCB5b3UncmUgcmlnaHQuIFRoYW5rcy4NCj4gDQo+ID4gPiBSZXBsYWNl
IHRoZQ0KPiA+ID4gZGV2bV9jbGtfYnVsa19nZXQoKSBieSBkZXZtX2Nsa19idWxrX2dldF9vcHRp
b25hbCgpIHRvIGZldGNoDQo+ID4gPiBpLk1YOTUgUENJZSBvcHRpb25hbCBjbG9ja3MgaW4gZHJp
dmVyLg0KPiA+ID4NCj4gPiA+IElmIHVzZSBleHRlcm5hbCBjbG9jaywgcmVmIGNsb2NrIHNob3Vs
ZCBwb2ludCB0byBleHRlcm5hbCByZWZlcmVuY2UuDQo+ID4gPg0KPiA+ID4gSWYgdXNlIGludGVy
bmFsIGNsb2NrLCBDUkVGX0VOIGluIExBU1RfVE9fUkVHIGNvbnRyb2xzIHJlZmVyZW5jZQ0KPiA+
ID4gb3V0cHV0LCB3aGljaCBpbXBsZW1lbnQgaW4gZHJpdmVycy9jbGsvaW14L2Nsay1pbXg5NS1i
bGstY3RsLmMuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4
aW5nLnpodUBueHAuY29tPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBu
eHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYyB8IDE5ICsrKysrKysrKysrKystLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MTMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gPiBpbmRleCA4MDhkMWYxMDU0MTcu
LmJjODU2NzY3N2E2NyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaS1pbXg2LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aS1pbXg2LmMNCj4gPiA+IEBAIC04Miw2ICs4Miw3IEBAIGVudW0gaW14X3BjaWVfdmFyaWFudHMg
ew0KPiA+ID4gICNkZWZpbmUgSU1YX1BDSUVfRkxBR19IQVNfU0VSREVTCQlCSVQoNikNCj4gPiA+
ICAjZGVmaW5lIElNWF9QQ0lFX0ZMQUdfU1VQUE9SVF82NEJJVAkJQklUKDcpDQo+ID4gPiAgI2Rl
ZmluZSBJTVhfUENJRV9GTEFHX0NQVV9BRERSX0ZJWFVQCQlCSVQoOCkNCj4gPiA+ICsjZGVmaW5l
IElNWF9QQ0lFX0ZMQUdfQ1VTVE9NX1BNRV9UVVJOT0ZGCUJJVCg5KQ0KPiA+ID4NCj4gPiA+ICAj
ZGVmaW5lIGlteF9jaGVja19mbGFnKHBjaSwgdmFsKQkocGNpLT5kcnZkYXRhLT5mbGFncyAmIHZh
bCkNCj4gPiA+DQo+ID4gPiBAQCAtOTgsNiArOTksNyBAQCBzdHJ1Y3QgaW14X3BjaWVfZHJ2ZGF0
YSB7DQo+ID4gPiAgCWNvbnN0IGNoYXIgKmdwcjsNCj4gPiA+ICAJY29uc3QgY2hhciAqIGNvbnN0
ICpjbGtfbmFtZXM7DQo+ID4gPiAgCWNvbnN0IHUzMiBjbGtzX2NudDsNCj4gPiA+ICsJY29uc3Qg
dTMyIGNsa3Nfb3B0aW9uYWxfY250Ow0KPiA+ID4gIAljb25zdCB1MzIgbHRzc21fb2ZmOw0KPiA+
ID4gIAljb25zdCB1MzIgbHRzc21fbWFzazsNCj4gPiA+ICAJY29uc3QgdTMyIG1vZGVfb2ZmW0lN
WF9QQ0lFX01BWF9JTlNUQU5DRVNdOyBAQCAtMTI3OCw5DQo+ICsxMjgwLDgNCj4gPiBAQA0KPiA+
ID4gc3RhdGljIGludCBpbXhfcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiA+ID4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPiA+ID4gIAlzdHJ1Y3QgcmVzb3Vy
Y2UgKmRiaV9iYXNlOw0KPiA+ID4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBkZXYtPm9m
X25vZGU7DQo+ID4gPiAtCWludCByZXQ7DQo+ID4gPiArCWludCByZXQsIGksIHJlcV9jbnQ7DQo+
ID4gPiAgCXUxNiB2YWw7DQo+ID4gPiAtCWludCBpOw0KPiA+ID4NCj4gPiA+ICAJaW14X3BjaWUg
PSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKmlteF9wY2llKSwgR0ZQX0tFUk5FTCk7DQo+ID4g
PiAgCWlmICghaW14X3BjaWUpDQo+ID4gPiBAQCAtMTMzMCw3ICsxMzMxLDEwIEBAIHN0YXRpYyBp
bnQgaW14X3BjaWVfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+
ID4gIAkJaW14X3BjaWUtPmNsa3NbaV0uaWQgPSBpbXhfcGNpZS0+ZHJ2ZGF0YS0+Y2xrX25hbWVz
W2ldOw0KPiA+ID4NCj4gPiA+ICAJLyogRmV0Y2ggY2xvY2tzICovDQo+ID4gPiAtCXJldCA9IGRl
dm1fY2xrX2J1bGtfZ2V0KGRldiwgaW14X3BjaWUtPmRydmRhdGEtPmNsa3NfY250LA0KPiA+IGlt
eF9wY2llLT5jbGtzKTsNCj4gPiA+ICsJcmVxX2NudCA9IGlteF9wY2llLT5kcnZkYXRhLT5jbGtz
X2NudCAtDQo+ID4gaW14X3BjaWUtPmRydmRhdGEtPmNsa3Nfb3B0aW9uYWxfY250Ow0KPiA+ID4g
KwlyZXQgPSBkZXZtX2Nsa19idWxrX2dldChkZXYsIHJlcV9jbnQsIGlteF9wY2llLT5jbGtzKTsN
Cj4gPiA+ICsJcmV0IHw9IGRldm1fY2xrX2J1bGtfZ2V0X29wdGlvbmFsKGRldiwNCj4gPiBpbXhf
cGNpZS0+ZHJ2ZGF0YS0+Y2xrc19vcHRpb25hbF9jbnQsDQo+ID4gPiArCQkJCQkgIGlteF9wY2ll
LT5jbGtzICsgcmVxX2NudCk7DQo+ID4NCj4gPiBXaHkgZG8geW91IG5lZWQgdG8gdXNlICdjbGtf
YnVsaycgQVBJIHRvIGdldCBhIHNpbmdsZSByZWZlcmVuY2UgY2xvY2s/DQo+ID4gSnVzdCB1c2Ug
ZGV2bV9jbGtfZ2V0X29wdGlvbmFsKGRldiwgInJlZiIpDQo+IEl0J3MgZWFzaWVyIHRvIGFkZCBt
b3JlIG9wdGlvbmFsIGNsa3MgaW4gZnV0dXJlLiBJIGNhbiBjaGFuZ2UgdG8gdXNlDQo+IGRldm1f
Y2xrX2dldF9vcHRpb25hbChkZXYsICJyZWYiKSBoZXJlIGlmIHlvdSBpbnNpc3RlbnQuDQpTaW5j
ZSB0aGUgY2xvY2sgZmV0Y2ggaXMgbm90IGRpc3Rpbmd1aXNoZWQgYnkgcGxhdGZvcm1zIGV4cGxp
Y2l0bHkuDQpkZXZtX2Nsa19nZXRfb3B0aW9uYWwoZGV2LCAicmVmIikgY2FuIGJlIHVzZWQgb25s
eSB3aGVuIGkuTVg5NSBzcGVjaWZpY2F0aW9uDQogaXMgYWRkZWQuDQotICAgICAgIHJldCB8PSBk
ZXZtX2Nsa19idWxrX2dldF9vcHRpb25hbChkZXYsIGlteF9wY2llLT5kcnZkYXRhLT5jbGtzX29w
dGlvbmFsX2NudCwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlt
eF9wY2llLT5jbGtzICsgcmVxX2NudCk7DQogICAgICAgIGlmIChyZXQpDQogICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCisgICAgICAgZm9yIChpID0gMDsgaSA8IGlteF9wY2llLT5kcnZkYXRh
LT5jbGtzX29wdGlvbmFsX2NudDsgaSsrKSB7DQorICAgICAgICAgICAgICAgaW14X3BjaWUtPmNs
a3NbcmVxX2NudCArIGldLmNsayA9IGRldm1fY2xrX2dldF9vcHRpb25hbChkZXYsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGlteF9wY2llLT5kcnZkYXRhLT5jbGtfbmFtZXNbcmVx
X2NudCArIGldKTsNCisgICAgICAgICAgICAgICBpZiAoSVNfRVJSKGlteF9wY2llLT5jbGtzW3Jl
cV9jbnQgKyBpXS5jbGspKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIo
aW14X3BjaWUtPmNsa3NbcmVxX2NudCArIGldLmNsayk7DQorICAgICAgIH0NCg0KT3INCi0gICAg
ICAgcmV0IHw9IGRldm1fY2xrX2J1bGtfZ2V0X29wdGlvbmFsKGRldiwgaW14X3BjaWUtPmRydmRh
dGEtPmNsa3Nfb3B0aW9uYWxfY250LA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW14X3BjaWUtPmNsa3MgKyByZXFfY250KTsNCiAgICAgICAgaWYgKHJldCkNCiAg
ICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KKyAgICAgICBpZiAoaW14X3BjaWUtPmRydmRhdGEt
PnZhcmlhbnQgPT0gSU1YOTUpIHsNCisgICAgICAgICAgICAgICBpbXhfcGNpZS0+Y2xrc1tyZXFf
Y250XS5jbGsgPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoZGV2LCAicmVmIik7DQorICAgICAgICAg
ICAgICAgaWYgKElTX0VSUihpbXhfcGNpZS0+Y2xrc1tyZXFfY250XS5jbGspKQ0KKyAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoaW14X3BjaWUtPmNsa3NbcmVxX2NudF0uY2xr
KTsNCisgICAgICAgfQ0KDQpXaGljaCBvbmUgaXMgYmV0dGVyIG9mIHRoZXNlIHR3byBjaGFuZ2Vz
Pw0KT3INClRvIGtlZXAgY29kZXMgc2ltcGxlIGFuZCBhbGlnbmVkLCBob3cgYWJvdXQgdG8ga2Vl
cCB0aGUgb3JpZ2luYWwgb25lPw0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gDQo+
ID4NCj4gPiBBbmQgd2hvIGlzIGdvaW5nIHRvIHN1cHBseSB0aGUgcmVmZXJlbmNlIGNsb2NrIGlu
IHRoZSBhYnNlbmNlIG9mIHRoaXMNCj4gPiBjbG9ja24gaW4gRFQ/DQo+IFdoZW4gdGhlICJwcmV2
aWV3IiB2ZXJzaW9uIGZpcm13YXJlIGlzIHVzZWQsIHRoaXMgY2xvY2sgaXMgZ2F0ZWQgb24gaW4g
ZGVmYXVsdC4NCj4gSW4gdGhpcyBjYXNlLCBoaXNvLWJsay1jdHJsIHdvdWxkIGdhdGVkIG9uIHRo
aXMgY2xvY2sgaW4gZGVmYXVsdCBzdGF0ZS4NCj4gDQo+IEJlc3QgUmVnYXJkcw0KPiBSaWNoYXJk
IFpodQ0KPiA+DQo+ID4gLSBNYW5pDQo+ID4NCj4gPiA+ICAJaWYgKHJldCkNCj4gPiA+ICAJCXJl
dHVybiByZXQ7DQo+ID4gPg0KPiA+ID4gQEAgLTE0ODAsNiArMTQ4NCw3IEBAIHN0YXRpYyBjb25z
dCBjaGFyICogY29uc3QgaW14OG1tX2Nsa3NbXSA9DQo+ID4gPiB7InBjaWVfYnVzIiwgInBjaWUi
LCAicGNpZV9hdXgifTsgIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QNCj4gPiA+IGlteDhtcV9j
bGtzW10gPSB7InBjaWVfYnVzIiwgInBjaWUiLCAicGNpZV9waHkiLCAicGNpZV9hdXgifTsNCj4g
PiA+IHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgaW14NnN4X2Nsa3NbXSA9IHsicGNpZV9idXMi
LCAicGNpZSIsDQo+ID4gPiAicGNpZV9waHkiLCAicGNpZV9pbmJvdW5kX2F4aSJ9OyAgc3RhdGlj
IGNvbnN0IGNoYXIgKiBjb25zdA0KPiA+ID4gaW14OHFfY2xrc1tdID0geyJtc3RyIiwgInNsdiIs
ICJkYmkifTsNCj4gPiA+ICtzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGlteDk1X2Nsa3NbXSA9
IHsicGNpZV9idXMiLCAicGNpZSIsDQo+ID4gPiArInBjaWVfcGh5IiwgInBjaWVfYXV4IiwgInJl
ZiJ9Ow0KPiA+ID4NCj4gPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGlteF9wY2llX2RydmRhdGEg
ZHJ2ZGF0YVtdID0gew0KPiA+ID4gIAlbSU1YNlFdID0gew0KPiA+ID4gQEAgLTE1OTIsOSArMTU5
NywxMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteF9wY2llX2RydmRhdGENCj4gPiA+IGRydmRh
dGFbXSA9DQo+ID4gew0KPiA+ID4gIAl9LA0KPiA+ID4gIAlbSU1YOTVdID0gew0KPiA+ID4gIAkJ
LnZhcmlhbnQgPSBJTVg5NSwNCj4gPiA+IC0JCS5mbGFncyA9IElNWF9QQ0lFX0ZMQUdfSEFTX1NF
UkRFUywNCj4gPiA+IC0JCS5jbGtfbmFtZXMgPSBpbXg4bXFfY2xrcywNCj4gPiA+IC0JCS5jbGtz
X2NudCA9IEFSUkFZX1NJWkUoaW14OG1xX2Nsa3MpLA0KPiA+ID4gKwkJLmZsYWdzID0gSU1YX1BD
SUVfRkxBR19IQVNfU0VSREVTIHwNCj4gPiA+ICsJCQkgSU1YX1BDSUVfRkxBR19TVVBQT1JUU19T
VVNQRU5ELA0KPiA+ID4gKwkJLmNsa19uYW1lcyA9IGlteDk1X2Nsa3MsDQo+ID4gPiArCQkuY2xr
c19jbnQgPSBBUlJBWV9TSVpFKGlteDk1X2Nsa3MpLA0KPiA+ID4gKwkJLmNsa3Nfb3B0aW9uYWxf
Y250ID0gMSwNCj4gPiA+ICAJCS5sdHNzbV9vZmYgPSBJTVg5NV9QRTBfR0VOX0NUUkxfMywNCj4g
PiA+ICAJCS5sdHNzbV9tYXNrID0gSU1YOTVfUENJRV9MVFNTTV9FTiwNCj4gPiA+ICAJCS5tb2Rl
X29mZlswXSAgPSBJTVg5NV9QRTBfR0VOX0NUUkxfMSwNCj4gPiA+IC0tDQo+ID4gPiAyLjM3LjEN
Cj4gPiA+DQo+ID4NCj4gPiAtLQ0KPiA+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprg
rqTgrr7grprgrr/grrXgrq7gr40NCg==


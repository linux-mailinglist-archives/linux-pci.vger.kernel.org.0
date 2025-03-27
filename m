Return-Path: <linux-pci+bounces-24857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B08A735A8
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 16:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F85116B14A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE801494DF;
	Thu, 27 Mar 2025 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hdG3BO8R"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6356A126BFA;
	Thu, 27 Mar 2025 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089543; cv=fail; b=SgDqotIajXVGAnadWYxa44Eb7r+RXa4wngTY77hnONW0foZ1V12KuVchEaoXqzlOVHygeJVb8wTwJyh37YFj4/Pki1qdv6hBc2WApyNbGAmgTKkHM1DUZG56mpHP/Gxytz1nVi8d6X9ONoDqoGBEcwp1DNKW7k50VAh4KXZrMMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089543; c=relaxed/simple;
	bh=bWwemJYANSmSFjn5BtISt/wL8F1N+oZ1nCfv3E6ylTA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NTeL3h0/w1IYnD39WBC4fTytM6yUOmW3ik1QyxJPJ05aRnRZP8suwiFwU5vfMrnX/u/WVz5iennLYw5ZQRarV53Btx3zlK2Y3UUF6A4bXoeU2Zo2mwn7kDKPo4AmoN4jkB0U6uVYCY96KGio301UPTzHF7Cusxm3H3tTa4EjUiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hdG3BO8R; arc=fail smtp.client-ip=40.107.247.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWDPb8zamnd7VrASALzxPnKepUddbjz416Lf51XQ77SNSwgWV4OSFR/Jwliga5dvQWrASV5BDXK6wihxS71fOR74nRJ9luOAGjPNSVXjAxBCYdJ3yECr5WkfGfK3ATulTl6hMgCdeQKhv1kEIUMYFOHH1Rf9VsP4urT0fm0uKTbzKAS5pPh9VDsQ92AxiQRbN2tinMehFVQkNDBgHLAg9r6H8WjHs8nwQnpdcixrFlgd+T27YrDrG17lPTynECCerIEzX39iAovBQGDmN6P+EjBvDbm3Xuo+VhqAtf21uVZ1g6TKzKiB+VwDTsIEphtflcF9YUvp9R/KbdhYUJmaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cA9e7zqFE0HAi11QSDKMdSaV8j+CK8zhiEq0Z/rR6b8=;
 b=aRWf5w/jLw4g3MdkgyvaNiBp2nuhpS4MW4fp+SbUTS2fwZOJw2bvM1XhFCWcMYju/kGm2IiQjuTPuI63HAAmCr/DyTmbrDmVxK6HUtht4LhEcGVUlVA1EifuyhOSBy3ovjB8TofbRwy+985+XLouAqUifkSBE3hr4pUD/XT0sDIfGf7a646mrv9O7L1l74ccfIB1b/zJgax8mlyKaoVZ5S95ME3bCcBiliLvXnyp5ST9MFm8+6JLHtKXahxQ+dcT83nkig4cCoittChRLFRzTqGjsy73ekpltAZtHaQD7YgQH+2o9YW0KG0Dl5QL2GfQRYcR5z/XT5PszchJmZ0fIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA9e7zqFE0HAi11QSDKMdSaV8j+CK8zhiEq0Z/rR6b8=;
 b=hdG3BO8RnxJHvEmA40H02fVzVoeZ8mHKvJx/HaKV2nKHs8WGUQp++w6nhXZMMehEBhBI0IL6o0oo3fJDRCyua7NOIFClWAi1Acyxz9d+asg25rbzcXL4v4JLFRk2M3R6RHcs+D+d6ANGA6xV65E+0EmrJiV1EIDTKDkAwBYEi7/T5NhXmqyLRLCosXd5YqlxgrPCbru6toupm4C2D4JEB7KsmesVd+d1FcWOONs3WGBJp/kJWpsaAs8rSoN3wTGWrKWwJ6cLl2vOlfYfaJsd+raxsYT9Cv7gqiQnjDLXr6obs7B+L6Sul1eYjdAXI6u5Vpm+tN6zoDoGLu5gF9yKzA==
Received: from AM6PR0402MB3528.eurprd04.prod.outlook.com (2603:10a6:209:7::25)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 15:32:18 +0000
Received: from AM6PR0402MB3528.eurprd04.prod.outlook.com
 ([fe80::e73b:96a6:ec15:9954]) by AM6PR0402MB3528.eurprd04.prod.outlook.com
 ([fe80::e73b:96a6:ec15:9954%4]) with mapi id 15.20.8511.026; Thu, 27 Mar 2025
 15:32:18 +0000
From: Roy Zang <roy.zang@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <frank.li@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: layerscape: fix index passed to
 syscon_regmap_lookup_by_phandle_args
Thread-Topic: [PATCH] PCI: layerscape: fix index passed to
 syscon_regmap_lookup_by_phandle_args
Thread-Index: AQHbnyvB1TRUzdvv0EKuIOTtnn55e7OHG+YAgAAALfA=
Date: Thu, 27 Mar 2025 15:32:18 +0000
Message-ID:
 <AM6PR0402MB35281E7B8A7BEC907FFA8D198BA12@AM6PR0402MB3528.eurprd04.prod.outlook.com>
References: <20250327151949.2765193-1-ioana.ciornei@nxp.com>
 <a772a388-87b8-41e7-a142-2ba48eef2941@linaro.org>
In-Reply-To: <a772a388-87b8-41e7-a142-2ba48eef2941@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR0402MB3528:EE_|PA1PR04MB10843:EE_
x-ms-office365-filtering-correlation-id: 3bb07704-a510-4e4b-0331-08dd6d448f41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjZneGxUbmFTempzNGZwcTZZNTVaejQxSDBHb1dldzlZY29wYnY2UG9QbE9k?=
 =?utf-8?B?Zk9xaFUwNUNkTnJ5SnVCVUVvakh0ZmFDbmlveWlZTUVGeE5YV0VJajIzdVVm?=
 =?utf-8?B?TjRJcXNheStkMm9LdXJVc0U5UFVac0VwT2hFWUVDTUJCcW9YazdDZmc0cFJX?=
 =?utf-8?B?Qktna1FSNmtMb2xvSzliY3NiM2p4NTR4SUV2bVgyZWJFRjdSaDZLbzk2L0hS?=
 =?utf-8?B?eUlJb21jNm5HL01yV1ZmcElyNE9ZMmh0RFFjUFpFT3FxZHlUWjVQNUUvUUMw?=
 =?utf-8?B?TEk2NEc0WllnY1FaWEVoZlBjUFpVSHZvOEJ2M3ptZC9ZQXk5KzJOZ2kvSGZK?=
 =?utf-8?B?ckJUTXB1UXJ0M05lZjdKdnFBczFrN3lvVmFkUXhEMHFMRFlOK1hrVWFrbWRU?=
 =?utf-8?B?dllaNEttcUs4WGw3aEFLUjBNTFVWV1Z5QlIzMFpZait1VWZIRnhTRENQUjBB?=
 =?utf-8?B?US95Z2N0SkpibFRtc3diU0lNWnpVNnZIU1VoaXY4eCt5RWtIYUR0S2g3bU02?=
 =?utf-8?B?MkdKN3RLeVZBVncyMFV6L0FwQUlFUGIrMVl5U210MDNmQmFsaU1WaEwzQnhX?=
 =?utf-8?B?dGw5TnR3TXQwVGkweU9XV3pwQjNyaHUzWVJLQ0Y3MUsrZUJrTmZqRm9GQnll?=
 =?utf-8?B?cGNRSHJabFJIQUVmVncvdzNLMFFtK2dKRVczSU54bFA3TDgrU0RNVmtYa0Jl?=
 =?utf-8?B?SFRjWEVlbEE1RU5VVUJNMTVSMkc1OStIc2pMTkVxYVBpWXFVL0VLN3Jsb2xK?=
 =?utf-8?B?aUEyaTI0RUh2RzU2UTd0L0d5NnpHQnE4R2lQWC94dTlIanRXMnBkSlQvdStK?=
 =?utf-8?B?MkRvS1IrNXRDbDY3SXpYNFBjOFRQelRxa24wZS9XTXl2Q1kwK0d2TUNHK2VF?=
 =?utf-8?B?dnBvTFNieEZmdEk0WDlkWTNUVHhhTHRkOEdZZUp2ZTkvQnZKNi9DNVFtRTBH?=
 =?utf-8?B?dzhqY0oyUmJaMGhpMVdQTXhtaURTNTZWVFZ4MXE3NElpanorVWFFeEE4S25O?=
 =?utf-8?B?MzYvbVZCNFVhRkR3QUJkbnNEcG9xb0llaldEY1lCOHhpNDlPN2pwSUFjRzJJ?=
 =?utf-8?B?S2NOK1dIR1ZtZUFHWGUwUy9CVzRzVnZIT2RhY0hvQ0hzQ0o2NHJLSG1zeUJW?=
 =?utf-8?B?WXIwWTVUc1hrM2tXQkc4TzN4Q3ZYZXpVM3NZK1RYR0J2RWFFcUhYeHAwS3hx?=
 =?utf-8?B?SUM3V240SHZxdi80QkhHSzB1NVBGYTdaem9SWXhHYjAyM1dxMmFCcGxka1ND?=
 =?utf-8?B?NFhBVzhkdllDd0JCWkFMWldCYit0czBqQTJYMTk1NjFaWXZRMEhUa1NpaDA0?=
 =?utf-8?B?WUl4T1QzOXpybkdNUmR2NU1lTWwvbWo4blJEZEpFS1k1YS9HMjEvYkFyMCtL?=
 =?utf-8?B?cGpRZno5ZHdIaGk2QytYRmN0ZWFYanlaYUMxUlJqSGFadnpyVFg4MWJpZTdD?=
 =?utf-8?B?N2JiY2llSnVJSXpkYUVCVkdCaEtKNlF6TU5yN2c5aUV4Ym1hdloxTHFUOHkv?=
 =?utf-8?B?MXRkaHh2SVQyRVZVc213QUtvMVdicnBjNzhjc09qRkZ2cFQwRkhaSVlYdHdH?=
 =?utf-8?B?THpQaTAwbmYzcld2MnJmdjYzcVhUWUpKYmZDdi9qelBKbEJJdFFCcm5Gak5M?=
 =?utf-8?B?SGFZdmd1d2F5UnFNa3IvdDZhUjVTTmJnSnJYc3piRytFQ1cyRkVPRDV1MW9J?=
 =?utf-8?B?R2xTayt6dndhTm80amJPRHdwcHpialVNYVY2SmsydEc1bFZ4OUNJSmZjZTJM?=
 =?utf-8?B?S3R1M2hkWVNMaGREZG1xUTZpN1BDdGI1WkIzcnNUL0dHUDBWOVJQMWtXY0lh?=
 =?utf-8?B?aDdHdXR2ejc2emkyTEJoREVtNTVDaS9oVkp6Nzc1Y09KWWw1M3FQMnhUSDcw?=
 =?utf-8?B?ckczMlVnSXIwcFVoTmxiUUtZVC9XeHFsQ00wenRnaEdZb2dMMy8zWEc3aFMv?=
 =?utf-8?Q?IQEg/zbiZ0s4cSxIvRqN4NTHotplK0Qz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3528.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUVJM3paWjY0Mll3cUxnamtHMjZJVG1vaWJKTlNLajNlZlhnZW1uZjdhTXU1?=
 =?utf-8?B?RDJVZGpXYzZub0xWYW53UGlWL3BBeXJWcUcvNEc0NUNvUXVDYmMvZndRZktj?=
 =?utf-8?B?N0lCTkYwVnUwaW1Ea2pWNElBWDFqTmcwZUp1VEhsRUVmYmRKeWFsbXlvTElH?=
 =?utf-8?B?cFBpWmR3c3JPVnI5NlNVMHlCMkI4TDh4THBxRjVHNXFnMVJiUXM2Q0JiR2F1?=
 =?utf-8?B?dThyemxyODVudnZHUXRiTm5LNVV1RFlnYnhmKzNGdlY2cFlMekRYajVTWVVN?=
 =?utf-8?B?V2paQURRV01JOExYM2YxbmlaWmx6cE9CWVN2bmJjTkI0S1FjUmp4YzF3a3RP?=
 =?utf-8?B?bHFIS2FyRHQ2QXF4NkNTUVRpVTFFMDVkczd1anNBTWJoVDhKMFAxTzVPcHV1?=
 =?utf-8?B?OUw3eEF4MnpiYlYvTUpCYWtERWtndVRiWXBSMlF2L08wSlh1Q0x0eWxMT2x6?=
 =?utf-8?B?d1MwcWtjV0NYK2lSYzgxUFZtYVU4VlJ2bXlsWW1yQVQzTFl6b3lvVGNwUVlp?=
 =?utf-8?B?NnF1b2xYK3VzQm83RWdkRTBtYTVadEZLQTVxZDJNUEVCSUlnVUdHdVBoQnVK?=
 =?utf-8?B?M05QS0pxT0REZ0V6b0llQWwydkJFQi9HbTNET0xzT2E4UFNJZHJDYUVtYzFY?=
 =?utf-8?B?eUhyWUMxZTlmN1UwZWxFWEVGUVBpcVNvbVVnWHAxQlpldHBlYkZRNmxkZW8y?=
 =?utf-8?B?U2I5aGNWUkRRYTZZQ1U1dXpYaklQYVROcTMweitXU1czNjQ4K2V3MnEyK2tR?=
 =?utf-8?B?TnpsYThNKys4TW9sOTJiVklyaDNCem50RU1ZbE5aS0RQL0MrRkdyaHVNa1pp?=
 =?utf-8?B?c3VjR2tMa0J5RHV5akhyOTNYUTFnS3dJeXp0YUN2THd4T1VKS3cvYjRkQjJz?=
 =?utf-8?B?V3ppMkpiS2M1SXA4Ry8zY0Jqc1VJenJzMVBwTG4vSlJrVTRWSFVCdnBtQ2JB?=
 =?utf-8?B?aGtkMS9DL1VWOWNIekhxR1dFMHRTNVNEZUpzeW5JMTJMMWhBeG10NGZ3Sk41?=
 =?utf-8?B?ZU9HdDR4NXhVeVNmOUNRVHh5WkRwQS9iYytRQ2xqbG5QTWl4ZkVnNGMvMU1l?=
 =?utf-8?B?TlJDb2prVDN2d05CVW9oTUtZeEp2VWZwcGdFTDJlVzRqOFFpUDhSWlVGaDhT?=
 =?utf-8?B?SE01V1BBNlJaMmw2OTdKNlAycGhJbjdHSWx1WVZ6Q3dsclhxUVZDaUFJOUs5?=
 =?utf-8?B?SEw2Sk5NZC80dE50NXpvODhxa0VpWU1na1ZWbERkWmNpYnJGbU1BYlpQQnR3?=
 =?utf-8?B?SFNMWFB5bUxRQUlxK1NrQnN6RUNac2t1ZDIzTU1oZm5SNkMzREpENUV5UFNN?=
 =?utf-8?B?L2NWZmkzRHdlNTQ5K3ZqbEE4dVFnZzZqVVZNZnV6RHcrc3IrZDVWMXBSWkNF?=
 =?utf-8?B?enZreHllN2hUcEtjUGdablc4UTZ4UkVNSnQrRWRLUThkQ0JIWFVVekI5VnBN?=
 =?utf-8?B?U25jcUpKL2luZWZTTDk2dlFzSWpFcEd0Zmw5cU9wSzVJRzg1RWVUb2FHaWRo?=
 =?utf-8?B?TjVHSm5KUDFkZVZOWmNwMm1ZWGwrdFQ4aTJSNmhYRHQraVBndXkwWlRCUVVH?=
 =?utf-8?B?aGNPSEFxZzB2aEdSRDZ2WEFWQ01adU1rNFlsT2xWdVBOcTNXU1BzbDlyNVk0?=
 =?utf-8?B?RHVMekIzdGlSdllRR2xEU3FKYzhCbGE0ZmU0SUR1ZGgvcjZqUHlNR2s3R2lD?=
 =?utf-8?B?ZnFsQ1NqdVAyM1RDMGdoSDZESXg5bFBTeUJmc1NMdTdseUZ5Y0FqSFJYdEtG?=
 =?utf-8?B?RzZIVmRQRWEreVZrY09kRFdlWEhjcGtBNU5LNG8vbmNxbGdIbTlVMGIzcGwy?=
 =?utf-8?B?U2hyMkhtVE9QeExPQnFBaWNZYm5UVGJaRU1xbXZXQWU4NXNTMFRseFdaakVi?=
 =?utf-8?B?N3pOYlVMUU5tRUJMd2gvRzF3TVJLa1grSy92VElPRlJsa25vakpOVnBLMGhr?=
 =?utf-8?B?TXBjWUo0V3dNS1dvREpYT2VHMk12N084R2dVczFDZE8rNWt5dDdKQjRPOHZv?=
 =?utf-8?B?bklBWnZTWERuNHREY0hvdWMrVFd0dEFCVFJvblNoMkw1K3Y0RjRDZVI2UHRN?=
 =?utf-8?B?ejBaQ3k5NStFR3FYV00welB2L3k0djR3Z2RHbFNYV2ZIMTN2dlZsdFRvZDJR?=
 =?utf-8?Q?CGz4=3D?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_00BF_01DB9F03.82ED9C50"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3528.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb07704-a510-4e4b-0331-08dd6d448f41
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 15:32:18.4596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iK6nr/49FMdStoMMT5uPTJR/A96Vf9n1ye/FdGI8wFnBf0LWtBmCqYODCfcbf/yRdVij8jAYhZdXof5msTDSpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10843

------=_NextPart_000_00BF_01DB9F03.82ED9C50
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> On 27/03/2025 16:19, Ioana Ciornei wrote:
> > The arg_count variable passed to the
> > syscon_regmap_lookup_by_phandle_args() function represents the number
> > of argument cells following the phandle. In this case, the number of
> > arguments should be 1 instead of 2 since the dt property looks like
> > below.
> > 	fsl,pcie-scfg = <&scfg 0>;
> >
> > Without this fix, layerscape-pcie fails with the following message on
> > LS1043A:
> >
> > [    0.157041] OF: /soc/pcie@3500000: phandle scfg@1570000 needs 2,
> found 1
> > [    0.157050] layerscape-pcie 3500000.pcie: No syscfg phandle specified
> > [    0.157053] layerscape-pcie 3500000.pcie: probe with driver layerscape-
> pcie failed with error -22
> >
> > Fixes: 149fc35734e5 ("PCI: layerscape: Use
> > syscon_regmap_lookup_by_phandle_args")
>
> Uh, obviously, probably I thought the code is using
> of_property_read_u32_index(), but that's of_property_read_u32_array().
>
> Thanks.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Thank you Ioana for the quick patch fix.
Acked-by: Roy Zang <Roy.Zang@nxp.com>

Roy

------=_NextPart_000_00BF_01DB9F03.82ED9C50
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIhUTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
iDAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSCAT0wggE5MIIBNaCC
ATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPW5sYW1zcGtp
MDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29u
ZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0
P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54
cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2Ny
bC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKG
ga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUy
MEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54
cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRo
b3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVy
cHJpc2UtQ0E1LmNlcjBRBgkrBgEEAYI3GQIERDBCoEAGCisGAQQBgjcZAgGgMgQwUy0xLTUtMjEt
MTkxNTIwNzAxMy0yNjE1MDQwMzY4LTMwNzY5Mjk0NTgtNjMxMTU5MA0GCSqGSIb3DQEBCwUAA4IB
AQA3/Dd1a+EHwL+AHpwSghyD5OCgILaIgL9W+OgJ2D5EKrOilETssP4FCTzZWMVKS1VWqglY1EiE
Dw30admpZ405aPcBa3Dmf5OnL9FMKL7Akty4U5VOotSeQVwrRazWHPt+GgDmqRtjq+k+wUFtIG+n
Bgo2OeTT3NxQ9PYv9HiIfuYybwHBooiO0v0b0zaVcI1MkajE4Yh4PjU3amwh6T5X4uKpQCJJAZmM
JF9OP+SSq9T7QP6qmtgRd6fVU6jMPHUrOvewel2l7mJKFdeuMw54+PPP7ZLzaxNyHTMSy9ni/6/m
yy3rgQ0z9p0rYpivBqEjJc40ZJqndU/jSchazSpbMIIIOjCCByKgAwIBAgITLQAMpBb3zugcBVYH
WgABAAykFjANBgkqhkiG9w0BAQsFADCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTEL
MAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNV
BAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNu
eHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MMB4XDTI0MDgwNzE5MzgxMVoXDTI2
MDgwNzE5MzgxMVowgZoxEzARBgoJkiaJk/IsZAEZFgNjb20xEzARBgoJkiaJk/IsZAEZFgNueHAx
EzARBgoJkiaJk/IsZAEZFgN3YmkxDDAKBgNVBAsTA05YUDELMAkGA1UECxMCVVMxFjAUBgNVBAsT
DU1hbmFnZWQgVXNlcnMxEzARBgNVBAsTCkRldmVsb3BlcnMxETAPBgNVBAMTCG54YTIxNzAxMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA55YyjGM+ltxo8NcfzL4FYuNVxTSHoMXQdjHo
ddnsJO77cR5GnfdlRXEOdJUysAKlGhpMxYekUrKBGfuoTXlXthcH/51P1apcmQBioE9kjwMf3qYM
wroBH1wWfKervMVKyVoULgWuN74/CeY7lN0zttUp9x3g1jMKVgKGap9Q2lDVbxFCMzWDieiPRMEM
G8FRcrGUSOKSkQl5j/X7n+VqAvXWZlqvhyzsOyXBFrXJvslOQGCXAAavQXNfrIDRRKy4PS+MSd26
6sEakJlhbOAsIeUcDyP1Rq7tbfuZ+BFrq2w5x0SifHa5ugFi3Z7LBTREB+lsvUtoaFnZX1tQ44v7
ZQIDAQABo4IEWTCCBFUwPAYJKwYBBAGCNxUHBC8wLQYlKwYBBAGCNxUIhYLAfoGO9FWG7YU4guuZ
S5qSVj+F5opuhLXhfgIBZAIBQTATBgNVHSUEDDAKBggrBgEFBQcDBDAOBgNVHQ8BAf8EBAMCBSAw
DAYDVR0TAQH/BAIwADAbBgkrBgEEAYI3FQoEDjAMMAoGCCsGAQUFBwMEMIGUBgkqhkiG9w0BCQ8E
gYYwgYMwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBLTALBglghkgBZQMEARYwCwYJYIZIAWUDBAEZ
MAsGCWCGSAFlAwQBAjALBglghkgBZQMEAQUwCgYIKoZIhvcNAwcwBwYFKw4DAgcwDgYIKoZIhvcN
AwICAgCAMA4GCCqGSIb3DQMEAgICADAdBgNVHQ4EFgQUa9VvfI2adDKzdXh2zk0AoaavdmIwHwYD
VR0jBBgwFoAUWJVg7k5072Uiqr3tGakreo4XnQcwggFGBgNVHR8EggE9MIIBOTCCATWgggExoIIB
LYaByGxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNSxDTj1ubGFtc3BraTAwMDUs
Q049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3Vy
YXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNl
P29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hi9odHRwOi8vbnd3LnBraS5ueHAuY29t
L2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybIYvaHR0cDovL3d3dy5wa2kubnhwLmNvbS9jcmwvTlhQ
RW50ZXJwcmlzZUNBNS5jcmwwggEQBggrBgEFBQcBAQSCAQIwgf8wgbsGCCsGAQUFBzAChoGubGRh
cDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPUFJQSxDTj1QdWJsaWMlMjBLZXkl
MjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9
Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3LnBraS5ueHAuY29tL2NlcnRzL05YUC1FbnRlcnByaXNl
LUNBNS5jZXIwPQYDVR0RBDYwNKAgBgorBgEEAYI3FAIDoBIMEHJveS56YW5nQG54cC5jb22BEHJv
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

------=_NextPart_000_00BF_01DB9F03.82ED9C50--


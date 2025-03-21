Return-Path: <linux-pci+bounces-24305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 738A9A6B4AF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 08:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABDAE7A5BDD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 07:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1DA41C64;
	Fri, 21 Mar 2025 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HQKg6UGl"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012026.outbound.protection.outlook.com [52.101.71.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34A5184F;
	Fri, 21 Mar 2025 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742540669; cv=fail; b=dVoPW1GN3SwZWJW8spZ2EL51E3y1/OCiHk09q8/EvfgWEEPSB/eDjCZR42zi/QJ5mvqjeY5Qg2WHzQm0ZSe/rIXJVJeiluPYy473BnksEwVyV1JvU7kUL4bmTAaZ/1VAsVaikcxKJIvWqoCRGMh4rB/jaexiQ8P6xMkFZxmTTdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742540669; c=relaxed/simple;
	bh=p/8+nVH7T8W+FmSPKaxYdt8mX3DQ+Ep5qvlfbdi+GSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dOctrkyJ4iXOcWR2rPa6ZaGisBvV3NLjy2XXsICx73uMvUnCkXOYpTAuBL364GVHBdY4ZvqHzXk46IPdaOOIwEoZhYOMxic+VjNyf35R2y7It1GH3bO0GpbsaOLKRc12Tu9Ne6fbshUPK2xiLyMeSKhiClBC8jI/HL0mle2Mws4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HQKg6UGl; arc=fail smtp.client-ip=52.101.71.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieYj9E50DclPPPM3QK8CPwzyOm3asgCW43uwNBwrZQGFJwW3EFaA1Ru3ao/OtdgyaTlxM8/5CBaSqHVar7L7sFgQp1dGsOcNt9QYcQLFFPO9Tr/SyBU3+1+LQInpi9k4g3xXTUyQIvImkdTPeLEpjx0utnUhombfbynGgmbVbTexL/+gMd7I1GrW+mW8rtAib6GtL0lUTA9pVNGEz45ilRFT4evPXh3KZ39j5wBr1uFM67wHDJEf6eyxCqhZXiykBLNTbE+muXIlWaYlRUoX+k4/rP8uAg+AY659f48yvPf52KNHG0Va4BcxiifLmX8Q57TjJ720aMZB4vQFlyk/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/8+nVH7T8W+FmSPKaxYdt8mX3DQ+Ep5qvlfbdi+GSA=;
 b=qJUKMbvCe7dGDvSmXxiFOWtMW6/1/0HEbp2QsZg9yGqDW17S0PgC2e3g3ra+MavUrsd1LbsU0Vua2gDI5OwXEh5NJOXyjKxvmcSNRzCVFq7j8fvnxN03PRxhHVLyUu5bQAAypgE3FFElMko6ChzoeA752FPl3Xn0yafY/KaKQBDiM99f0vwSE9thBneDLWu9rzOUuFOq58mbLzYm9FRwFjhT5wdPw+LOfXaZrYNkYImM3SAQwkGSF8QtrYQNVQw6Zfar3+G8zBzCsc26P6BaA/e9RhHKBhZXURbbKRuh7S1uD6qHHBlhC0ETn4AUedYUXAHvsKOqM/PnsNEc0o0iEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/8+nVH7T8W+FmSPKaxYdt8mX3DQ+Ep5qvlfbdi+GSA=;
 b=HQKg6UGltNoNNHx88OPrKxdzjbakeYOlpDeceJ0u/dAoF/uMFyLt3wlnoPnbHtxXr7A07CVIvwlZ+qChypxWZlkyoAq8tcFOusqZIpKVbRp72lRlw/3QGe5m4zrbq1txfYBsqWGuEqQfjtL627NSirpQbAcrzV6AxNBCjCGSS7/FvGd7SDZXWlRK5RToKFl2wykRJ3n7mXbqUV+TLkNDGbQLwpU5qX0huT/VX+389YnqZv5WhLQRDt1oG3FmVnIej7PjLKOBznf8F8WwWkO6H4T4VFkb5tiUkcrBOs5wUbGxxX8WRq3zZT5dDOMfR18ZRCzqpVh3yStcQREeI8EI8w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 07:04:24 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:04:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"devnull+manivannan.sadhasivam.linaro.org@kernel.org"
	<devnull+manivannan.sadhasivam.linaro.org@kernel.org>
CC: "bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "brgl@bgdev.pl" <brgl@bgdev.pl>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v3 3/5] PCI/pwrctrl: Skip scanning for the device further
 if pwrctrl device is created
Thread-Topic: [PATCH v3 3/5] PCI/pwrctrl: Skip scanning for the device further
 if pwrctrl device is created
Thread-Index: AQHbmg0cayhvVFUY+kOmWlFBWATdm7N9A1KAgAAREWA=
Date: Fri, 21 Mar 2025 07:04:24 +0000
Message-ID:
 <PAXPR04MB85102429AE77159F8CAF914088DB2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250116-pci-pwrctrl-slot-v3-3-827473c8fbf4@linaro.org>
 <20250321025940.2103854-1-wei.fang@nxp.com>
 <2BFDC577-949F-49EE-A639-A21010FEEE0E@linaro.org>
In-Reply-To: <2BFDC577-949F-49EE-A639-A21010FEEE0E@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8849:EE_
x-ms-office365-filtering-correlation-id: 783c286c-f542-40d7-2c99-08dd68469ca9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZmI3T2hLNnVGSkZKY2JGQm5EUGF6UE5TTHhzTThEZmYxc01mVTYwaUtWYTR4?=
 =?utf-8?B?SFJzNFJEZ0xpNEhJdGVMNThCNk9MRHpoWkhTQ1B0NDFZbEpvOXAydk1rZmc4?=
 =?utf-8?B?eGlRSjZGSzhyWklsZ1ZGbTgyN1ZockNkbXkzN1BCanFUZlJzNmIvaGdkMEJ4?=
 =?utf-8?B?di9MT0ZUaGRjeW5NTGZRb1ZrRkdSSXVjSnFYRmNNREltNUtYQWpLVlBuMnJJ?=
 =?utf-8?B?MS92NnVIRWlzdkl5ZnlXdkF1VmVLTE14T0F3MWwxeENEVEtqeHNwZzY0S0p2?=
 =?utf-8?B?RlNXRmNINVQzSXRqenNtUi9mY1dqbDZnOTdRbkZENmxPNnUyUXFXYUxkV2JN?=
 =?utf-8?B?SGtJYTdLanNYOVp0NnorbGR0c2Y0ZGppVDFXR01DaGNuUEQwQVdVdmxYTm90?=
 =?utf-8?B?Vkhpa1orUlJTNmdITWkvUmMrTXhpa3pMeUpLdW85SHFFZlpyS0I4UkhTQ0hk?=
 =?utf-8?B?ZnlvZmdvVjdNaTVIK1BhVHlVVGkya3dFbmpuRkRxZFFaT05lUzI1Sjl6ZEJQ?=
 =?utf-8?B?MFNPOE1Lem4yVmZvUzloS0tIdndiVjF2ZDJtQmVqM0Y0Ky9VZXIya1RMODFL?=
 =?utf-8?B?cjNibSsyT0hOZEVmOGN1bm5FN24yS1RwOE9FcU4ySDFsT081djBaZjF0UDdn?=
 =?utf-8?B?R1BCdUZQb25BOTV4NE1OeDB5akdJZDNxenFhVjFqZ2xzRUJ4ODhPU0d2QVZT?=
 =?utf-8?B?WWV6LzY4SWVsYldOYVRoMVlFQTZyY1ZPb0lhSUY3ZkVHYnJkTWpYSTN6cWwr?=
 =?utf-8?B?MytHdFllOStFYkFnNDZFcUhKVk5JVnZmYlRHR1dTY1YyY3FLZVhvR3U0SEh0?=
 =?utf-8?B?RE1tYnVZTTlYeFlQd1Q2WjBYcytsVGNodkFNUjdEbWp5VXFwVU5uWjk4NDVO?=
 =?utf-8?B?TmF1YUp0dXhWU1NMSXh5NS9NcE5OZUlUQVQ2WXhtR2RqR1BFSEtXNXVML082?=
 =?utf-8?B?VzFmdVRPRXJpZmtNU0RoNFNLZ0xZcXNNMHVucHk2U1htbi82RHpnQ1k3RVFl?=
 =?utf-8?B?SGhuRWJiMVdWaWlWWjBNTEp3RlEvSmtOVzZ3a3QwVkk2eFJXY2hhZzNUWmZv?=
 =?utf-8?B?SEFaRnFOMUl0Q3l1emdDUjRSTHdlMWdaRUtNdStXQ29PaTh5RWxuK1BsSmR1?=
 =?utf-8?B?YkU4ZkFuQzdwSXN0d1I1QlFuV0VKVGh0SE1RTmd6RXhRV2hFZE4rRnNrOWp2?=
 =?utf-8?B?WFdaRjJQSW0yWUlMSUo3U05GaSsxd0ZRVlFPc3V2SmFhclU1VklkZHhrWEZW?=
 =?utf-8?B?TmVRYVRUUW5qQjZVSGdab29weFloaWlCaC8xRjRYdWtyd0crQW11NWY5aG8z?=
 =?utf-8?B?NW50TE51a2IramhtdERwYTJrRkZwcE5veUxWYXVVVjE5QllIRU1QTkR5dHhW?=
 =?utf-8?B?MmYvUi9WR3c2NS9GOW1nQTFmaUNCcWJFUW9iREUzVmJQWWMydmpObmUzZnpo?=
 =?utf-8?B?Mm5pRmdMY1JHTnhPSEFJeEkwSFhIK1BtbFh6RlV3QmQ4SVk0aThqZEFkcHdJ?=
 =?utf-8?B?bE02c2tQWDVxMUhNdUV1dTJSdllla1RMOU15MllSVHcyQWNPVE9RZFhGa3Ey?=
 =?utf-8?B?a2k3bkxpSlI1NWFaeCs3bWNLWGg2Qi9sS0YrRDVPM2orM1ViTThBaDRxNDV5?=
 =?utf-8?B?d1NQV3pNNTNqZ2w4QkpDQUk4a0NpMTl2Rk93eTd6d29WMkkzbUd2aHBXY1Ir?=
 =?utf-8?B?dy8vWkdTVGZKN1ROZDcyc1pSWTl3eDRuSTAvd0tKV1VvdUxKeG9KSnQ5ajIz?=
 =?utf-8?B?aE1TenJGRncwLzlwVXYxUDMwYXNLUVIwK3ZrNS9reG43ZGowaFJSM25PSndy?=
 =?utf-8?B?amNqUDlNTm0vRWNqcWJTWm9ia0k2ZEpyOXlIVm14MTlIRTFwUkRTeFhST0lo?=
 =?utf-8?B?MTE3Z1V2TlF6WVdqWkh5VnZDNWR1WHFLd1d5S3JhbWFLUC83cTYrWkdWWjcv?=
 =?utf-8?Q?HfXfhPjLRN8RMXdVGHns8phXL6JilF0a?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1FrNXp2VDBKVi8rWkZhcjRNUjg3c0RNbjVaTG5WMFBuT3RaQ29BMCtqb2Q0?=
 =?utf-8?B?SGpUS1lUdVZMZGZCZ0hENE5LUDNUSjZaVkhFc2lsQ3o3NjA0RzU3TFh3V0tS?=
 =?utf-8?B?NUkrUEp4aGF4bGdlbitOdi9KS1Nwek1NdDBtRjdTODhIeDVNeTZhblZJenlE?=
 =?utf-8?B?RjZ2U3kzT3M1ZUt5c0dqbVM0allpdkZZOWo4MVMvL1lHYTh6U3ZGa2luNUxH?=
 =?utf-8?B?Sk9pQlVmWkprWXFZSWNPRC9aOWFQSnRwMW9sdVI2S3ZPVmJ5ZDd1RG16VEtN?=
 =?utf-8?B?LzBwUWY1b1VmZVRSc2c3cG92RU5QcWFmSHJpVFp4Ym9zMXRZdU1LQWkwK2xh?=
 =?utf-8?B?K1VHTmVYVGRLcmtvTTc2RVNUMWsyZm1IdTloc0JhNWdxdlAwWHo2VmtNMGlo?=
 =?utf-8?B?OWVpYjhKYjlxWVZPWXBQcmhsWHpBR25ybHNodkZkU0hNeEhmbUVldUwyVHhR?=
 =?utf-8?B?RGZvNmtoY0duUERQZDgzSHRyWExtZGpEUVFDUWtHbG1yWmxlQTBXTW1Lc0Uw?=
 =?utf-8?B?MnpHWkdGSTVDUithaTBQQnZYb1lIeGVOYWFFa0JMODRxZm9vVm1hQnpiUUlB?=
 =?utf-8?B?bVdIYlVQTFo0YTB0czgva0pOZGRmZlMyS1Z6WFdJQkhldEtQandtMklqVmNN?=
 =?utf-8?B?czlQYkZtV1VKZTNzc281NlRCR3huczdCcUQ1eUNvclEvR3l1OVVOY0k4OVhE?=
 =?utf-8?B?QUI2ZUxDV2UwY3NNZkRMS0hxWVdlNDV4TFh2L1ByTXV0RG5jZWZrOXEvdnpU?=
 =?utf-8?B?M1hkbEFKSkJkSGpLRVQzOFVMOXZKTXBLbURWcEpCdkRkTXVoaHFSeWhjdmRz?=
 =?utf-8?B?NmxPOHZoUU5DY1krNThNaEZJWXplRWdmWU5zSTlpT3Z2N0FmajZRTm80RnVB?=
 =?utf-8?B?a28yM3FGL0Ewd1BtWUV2dU1XT3ZzOFFwdk84YW9ic3ZnaFFzVUdTdjZpUUQ2?=
 =?utf-8?B?dDhUb1VtTUhGZTJjWnc2eklYTjZaQjRma0FJeVlpVW4vMjN5Sm9laWx5c0Jn?=
 =?utf-8?B?aHBQcmFpOHpHOWorRFNuREVyMG1TQ0xNd2oweGxHVytUYkt1c08wZ2pXTEto?=
 =?utf-8?B?VnlNRGVpbnNpc3Y4aFFnQUgrOGVyUTVEMHVDTEZPVnVENmlseGVjRHd3OFJ1?=
 =?utf-8?B?Yk9ZVjdIRGw5Vys2d2V4SmUwSEZzYTlFd3YrNDI3aERDeGk5YnhJdkFYS1Fo?=
 =?utf-8?B?dXZhVGxXcVBPeFZDWDJSayt5bjA3WXBIdnd4TStzdEw0aVYwdWdZcDA1aUh0?=
 =?utf-8?B?N0hGcHpoSWpWemd6Q1BGY2liNjByWXRkNlFlTmczOFcvQ0lENkhTL0NyaFIv?=
 =?utf-8?B?WVA0RHM0SUxrcGRsSkJKOGxITCtoK1JCS01QZWZMME5idDMwVktJZlJaVVFO?=
 =?utf-8?B?SnJmcmcydmxOSU5OZ3d0VmxtMng3amE5RjFDZXRVcDluSmJ5TVM4bXQzbzNq?=
 =?utf-8?B?N0Y1NWFvUVVuK2tBeUtuZm5PaXRveUY2cFNSNHU5OUE2Z2tTN29XVFdoeUVv?=
 =?utf-8?B?TjlxMndtU0JyUmVncTJwNTRJSlU0dFRjbjEyZkNTYTN4NzJqYXNjUXNMZHJN?=
 =?utf-8?B?OC9lblBqY2F1QWtzdkFtVkNrTmJpSkI5b0ZzTFd0UkNaYmdrTzcxRGlyWFUy?=
 =?utf-8?B?b0tEYlN3Y1hCU3p3MjZiTmhDY2w2Q2dxWTdic2pVOVVUdkkxWE5XNjVTMko0?=
 =?utf-8?B?MEU4djVJU1U4ZXphd2NkMGZvZmpzVDdSQm9yLy92bFJHRDMvVkJPeDlDTVlG?=
 =?utf-8?B?QlYxSmw1dlY5NmI1dzBET3lUd1lyZ2dNdjlseTQydVVpSkxwNzBtMnBqWHNK?=
 =?utf-8?B?ZFNzWUNOZU1iZzVCRkxocUdXMWtTUDNmcnlydzhHTVNpSXNRMnBtS2U5b2tj?=
 =?utf-8?B?V1RKZ0JCbDlCcFJsM2dpN2gwSjVWZGJiY21RR2podGZNeDlGMVQ3SlloVTBp?=
 =?utf-8?B?TlpUK21TdWhISWhGZXJVcEFianJuVUFKYmxqTlErMEdWaUdxbXE1c21IOEVq?=
 =?utf-8?B?SDU5UGZyaVF1Tk1hckFEZzEyUUEyQU03bEphWnpCcjY2Y3pUYU44M0dIaXY0?=
 =?utf-8?B?bjlESDFKWmhNZFViU3Zod2QxWWsxQkFEOENVdFREWGEzaSt5bmFFTXJDbFlN?=
 =?utf-8?Q?q4nQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783c286c-f542-40d7-2c99-08dd68469ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 07:04:24.1432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmcvheNFzRNBQ7IYrZKH4Zi/7EjHaBbMK5OfZAfTiIec46z2u6XmmPD+pxDKs2KQDrL+hTlcpMuZkQFkiGNDTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8849

PiBIaSwNCj4gDQo+IE9uIE1hcmNoIDIxLCAyMDI1IDg6Mjk6NDAgQU0gR01UKzA1OjMwLCBXZWkg
RmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID5AQCAtMjQ4Nyw3ICsyNDg3LDE0
IEBAIHN0YXRpYyBzdHJ1Y3QgcGNpX2RldiAqcGNpX3NjYW5fZGV2aWNlKHN0cnVjdA0KPiBwY2lf
YnVzICpidXMsIGludCBkZXZmbikNCj4gPiAJc3RydWN0IHBjaV9kZXYgKmRldjsNCj4gPiAJdTMy
IGw7DQo+ID4NCj4gPi0JcGNpX3B3cmN0cmxfY3JlYXRlX2RldmljZShidXMsIGRldmZuKTsNCj4g
PisJLyoNCj4gPisJICogQ3JlYXRlIHB3cmN0cmwgZGV2aWNlIChpZiByZXF1aXJlZCkgZm9yIHRo
ZSBQQ0kgZGV2aWNlIHRvIGhhbmRsZSB0aGUNCj4gPisJICogcG93ZXIgc3RhdGUuIElmIHRoZSBw
d3JjdHJsIGRldmljZSBpcyBjcmVhdGVkLCB0aGVuIHNraXAgc2Nhbm5pbmcNCj4gPisJICogZnVy
dGhlciBhcyB0aGUgcHdyY3RybCBjb3JlIHdpbGwgcmVzY2FuIHRoZSBidXMgYWZ0ZXIgcG93ZXJp
bmcgb24NCj4gPisJICogdGhlIGRldmljZS4NCj4gPisJICovDQo+ID4rCWlmIChwY2lfcHdyY3Ry
bF9jcmVhdGVfZGV2aWNlKGJ1cywgZGV2Zm4pKQ0KPiA+KwkJcmV0dXJuIE5VTEw7DQo+ID4NCj4g
PkhpIE1hbml2YW5uYW4sDQo+ID4NCj4gPlRoZSBjdXJyZW50IHBhdGNoIGxvZ2ljIGlzIHRoYXQg
aWYgdGhlIHBjaWUgZGV2aWNlIG5vZGUgaXMgZm91bmQgdG8NCj4gPmhhdmUgdGhlICJ4eHgtc3Vw
cGx5IiBwcm9wZXJ0eSwgdGhlIHNjYW4gd2lsbCBiZSBza2lwcGVkLCBhbmQgdGhlbiB0aGUNCj4g
PnB3cmN0cmwgZHJpdmVyIHdpbGwgcmVzY2FuIGFuZCBlbmFibGUgdGhlIHJlZ3VsYXRvcnMuIEhv
d2V2ZXIsIGFmdGVyDQo+ID5tZXJnaW5nIHRoaXMgcGF0Y2gsIHRoZXJlIGlzIGEgcHJvYmxlbSBv
biBvdXIgcGxhdGZvcm0uIFRoZSAucHJvYmUoKSBvZg0KPiA+b3VyIGRldmljZSBkcml2ZXIgd2ls
bCBub3QgYmUgY2FsbGVkLiBUaGUgcmVhc29uIGlzIHRoYXQNCj4gPkNPTkZJR19QQ0lfUFdSQ1RM
X1NMT1QgaXMgbm90IGVuYWJsZWQgYXQgYWxsIGluIG91ciBjb25maWd1cmF0aW9uIGZpbGUsDQo+
ID5hbmQgdGhlIGNvbXBhdGlibGUgc3RyaW5nIG9mIHRoZSBkZXZpY2UgaXMgYWxzbyBub3QgYWRk
ZWQgdG8gdGhlIHB3cmN0cmwgZHJpdmVyLg0KPiANCj4gSG1tLiBTbyBJIGd1ZXNzIHRoZSBjb250
cm9sbGVyIGRyaXZlciBpdHNlbGYgaXMgZW5hYmxpbmcgdGhlIHN1cHBsaWVzIEkgYmVsaWV2ZQ0K
PiAod2hpY2ggSSBmYWlsZWQgdG8gc3BvdCkuIE1heSBJIGtub3cgd2hhdCBwbGF0Zm9ybXMgYXJl
IGFmZmVjdGVkPw0KDQpZZXMsIHRoZSBhZmZlY3RlZCBkZXZpY2UgaXMgYW4gRXRoZXJuZXQgY29u
dHJvbGxlciBvbiBvdXIgaS5NWDk1DQpwbGF0Zm9ybSwgaXQgaGFzIGEgInBoeS1zdXBwbHkiIHBy
b3BlcnR5IHRvIGNvbnRyb2wgdGhlIHBvd2VyIG9mIHRoZQ0KZXh0ZXJuYWwgRXRoZXJuZXQgUEhZ
IGNoaXAgaW4gdGhlIGRldmljZSBkcml2ZXIuIFRoaXMgcGFydCBoYXMgbm90IGJlZW4NCnB1c2hl
ZCB1cHN0cmVhbSB5ZXQuIFNvIGZvciB1cHN0cmVhbSB0cmVlLCB0aGVyZSBpcyBubyBuZWVkIHRv
IGZpeCBvdXINCnBsYXRmb3JtLCBidXQgSSBhbSBub3Qgc3VyZSB3aGV0aGVyIG90aGVyIHBsYXRm
b3JtcyBhcmUgYWZmZWN0ZWQgYnkNCnRoaXMgb24gdGhlIHVwc3RyZWFtIHRyZWUuDQoNCj4gDQo+
ID4gSSB0aGluayBvdGhlcg0KPiA+cGxhdGZvcm1zIHNob3VsZCBhbHNvIGhhdmUgc2ltaWxhciBw
cm9ibGVtcywgd2hpY2ggdW5kb3VidGVkbHkgbWFrZQ0KPiA+dGhlc2UgcGxhdGZvcm1zIGJlIHVu
c3RhYmxlLiBUaGlzIHBhdGNoIGhhcyBiZWVuIGFwcGxpZWQsIGFuZCBJIGFtIG5vdA0KPiA+ZmFt
aWxpYXIgd2l0aCB0aGlzLiBDYW4geW91IGZpeCB0aGlzIHByb2JsZW0/IEkgbWVhbiB0aGF0IHRo
b3NlDQo+ID5wbGF0Zm9ybXMgdGhhdCBkbyBub3QgdXNlIHB3cmN0cmwgY2FuIGF2b2lkIHNraXBw
aW5nIHRoZSBzY2FuLg0KPiANCj4gU3VyZS4gSXQgbWFrZXMgc2Vuc2UgdG8gYWRkIGEgY2hlY2sg
dG8gc2VlIGlmIHRoZSBwd3JjdHJsIGRyaXZlciBpcyBlbmFibGVkIG9yIG5vdC4NCj4gSWYgaXQg
aXMgbm90IGVuYWJsZWQsIHRoZW4gdGhlIHB3cmN0cmwgZGV2aWNlIGNyZWF0aW9uIGNvdWxkIGJl
IHNraXBwZWQuIEknbGwgc2VuZCBhDQo+IHBhdGNoIG9uY2UgSSdtIGluZnJvbnQgb2YgbXkgY29t
cHV0ZXIuDQo+IA0KDQpJIGRvbid0IGtub3cgd2hldGhlciBjaGVjayB0aGUgcHdyY3RybCBkcml2
ZXIgaXMgZW5hYmxlZCBpcyBhIGdvb2QgaWRlYSwNCmZvciBzb21lIGRldmljZXMgaXQgaXMgbW9y
ZSBjb252ZW5pZW50IHRvIG1hbmFnZSB0aGVzZSByZWd1bGF0b3JzIGluDQp0aGVpciBkcml2ZXJz
LCBmb3Igc29tZSBkZXZpY2VzLCB3ZSBtYXkgd2FudCBwd3JjdHJsIGRyaXZlciB0byBtYW5hZ2UN
CnRoZSByZWd1bGF0b3JzLiBJZiBib3RoIHR5cGVzIG9mIGRldmljZXMgYXBwZWFyIG9uIHRoZSBz
YW1lIHBsYXRmb3JtLA0KaXQgaXMgbm90IGVub3VnaCB0byBqdXN0IGNoZWNrIHdoZXRoZXIgdGhl
IHBpbmN0cmwgZHJpdmVyIGlzIGVuYWJsZWQuDQoNCj4gQnV0IGluIHRoZSBsb25nIHJ1biwgd2Ug
d291bGQgbGlrZSB0byBtb3ZlIGFsbCBwbGF0Zm9ybXMgdG8gdXNlIHB3cmN0cmwgaW5zdGVhZCBv
Zg0KPiBmaWRkbGluZyB0aGUgcG93ZXIgc3VwcGxpZXMgaW4gdGhlIGNvbnRyb2xsZXIgZHJpdmVy
ICh3ZWxsIHRoYXQgd2FzIHRoZSBtb3RpdmF0aW9uDQo+IHRvIGludHJvZHVjZSBpdCBpbiB0aGUg
Zmlyc3QgcGxhY2UpLg0KPiANCg0KSSB1bmRlcnN0YW5kIHRoaXMsIGJ1dCBpdCBzaG91bGQgYmUg
Y29tcGF0aWJsZSB3aXRoIHRoZSBvbGQgbWV0aG9kDQppbnN0ZWFkIG9mIGNvbXBsZXRlbHkgbWFr
aW5nIHRoZSBvbGQgbWV0aG9kIGlub3BlcmFibGUgdW5sZXNzIGl0DQpjYW4gYmUgY29uZmlybWVk
IHRoYXQgYWxsIHBsYXRmb3JtcyBpbiB0aGUgdXBzdHJlYW0gaGF2ZSBjb21wbGV0ZWQNCnRoZSBj
b252ZXJzaW9uIHRvIHVzZSBwd3JjdHJsIGRyaXZlci4gT2J2aW91c2x5LCB0aGlzIGlzIGRpZmZp
Y3VsdCB0bw0KY29uZmlybS4gOigNCg0KPiBPbmNlIHlvdSBzaGFyZSB0aGUgcGxhdGZvcm0gZGV0
YWlscywgSSdsbCB0cnkgdG8gbWlncmF0ZSBpdCB0byB1c2UgcHdyY3RybC4gQWxzbywNCj4gcGxl
YXNlIG5vdGUgdGhhdCB3ZSBhcmUgZ29pbmcgdG8gZW5hYmxlIHB3cmN0cmwgaW4gQVJNNjQgZGVm
Y29uZmlnIHZlcnkgc29vbi4NCj4gU28gSSdsbCB0cnkgdG8gZml4IHRoZSBhZmZlY3RlZCBwbGF0
Zm9ybXMgYmVmb3JlIHRoYXQgaGFwcGVucy4NCg0KSSB0aGluayB0aGUgY3VycmVudCBwd3JjdHJs
IGRyaXZlciBzaG91bGQgc3RpbGwgYmUgaW4gdGhlIGVhcmx5IHN0YWdlLiBJZiBJDQp1bmRlcnN0
YW5kIGNvcnJlY3RseSwgaXQgc2hvdWxkIG9ubHkgZW5hYmxlIHRoZSByZWd1bGF0b3JzIHdoZW4g
cHJvYmluZw0KYW5kIGRpc2FibGUgdGhlIHJlZ3VsYXRvcnMgd2hlbiByZW1vdmluZy4gVGhpcyBk
b2VzIG5vdCBtZWV0IGFsbCB0aGUgdXNlDQpjYXNlcyBhdCBwcmVzZW50LiBTbyBJJ20gbm90IHN1
cmUgaG93IHlvdSBjYW4gZG8gdGhlIGZpeGVzIGZvciBhbGwgdGhlIGFmZmVjdGVkDQpwbGF0Zm9y
bXMgaW4gcHdyY3RybCBkcml2ZXIgZm9yIGRpZmZlcmVudCB1c2UgY2FzZXM/DQoNCkZvciBleGFt
cGxlLCBzb21lIEV0aGVybmV0IGRldmljZXMgbmVlZCB0byBzdXBwb3J0IHN1c3BlbmQvcmVzdW1l
IGFuZA0KV2FrZS1vbi1MQU4gKFdPTCkuIElmIFdPTCBpcyBub3QgZW5hYmxlZCwgdGhlIHBvd2Vy
IG9mIHRoZSBleHRlcm5hbCBQSFkNCm5lZWRzIHRvIGJlIHR1cm5lZCBvZmYgd2hlbiBpdCBlbnRl
cnMgc3VzcGVuZCBzdGF0ZS4gSWYgV09MIGlzIGVuYWJsZWQsIHRoZQ0KcG93ZXIgb2YgdGhlIGV4
dGVybmFsIFBIWSBuZWVkcyB0byBiZSBrZXB0IG9uLiBTbyBmb3IgdGhpcyBjYXNlLCBJIHRoaW5r
IHlvdQ0KbmVlZCB0byBhdCBsZWFzdCBhZGQgUE0gaW50ZXJmYWNlcyBpbiBwd3JjdHJsIGRyaXZl
ci4gRm9yIHRoZSBvdGhlciB1c2UgY2FzZXMsDQpvdGhlciBzb2x1dGlvbnMgbWF5IGJlIG5lZWRl
ZC4NCg0K


Return-Path: <linux-pci+bounces-28313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80BBAC1BD9
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 07:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB223BE902
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 05:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B832DCC0E;
	Fri, 23 May 2025 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C3iBm4Vq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GPUCo12m"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE51E2DCBF6
	for <linux-pci@vger.kernel.org>; Fri, 23 May 2025 05:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978215; cv=fail; b=E8rTM9VPLEVA5DdwtSwF/HZa3T9xdj31o6Qr5PorbctW2GYFDybZWL6byP5fm3YbLKklm7P9G0RvjKkuJ7qiy6ekDbo4tKeXy2yqod7Wra0LE73+eCrWSqGuoceNjE3m7g4WV+mu9VNfP9Ae1C5u2UugEQtNnGmop2sx91HOb6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978215; c=relaxed/simple;
	bh=g7G0PuMRY2Mfq+7NNO7w8nLb4AscUATXYbyomk/uiaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fRHomeortl4g2yvMNxDwlMqNzcq4BsJa5HXpO4+AM79zVAxxdKmcc9u8dNH7iNxs+VuZMVlf3kFQAtM3m3jTZfMlXUUsw/12LsxVIc3OGyTUjJgzJHehKnbkTbOs82JWTxqf1YjqfTuYhj06BHj9yGEVGxL9mUa40EbRxVzM3Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=C3iBm4Vq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GPUCo12m; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747978212; x=1779514212;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g7G0PuMRY2Mfq+7NNO7w8nLb4AscUATXYbyomk/uiaI=;
  b=C3iBm4VqQ0mL1JsdyEatzTkpJgmrrsYHOXDnIlJ+BxzVQg2Q1OsqchoA
   IH7ofbFhQVdfaql60XUaOw35bZ6P8DIsE5Bn+m2XNDYlvNi5Yn136gEkd
   GIe3Dl/VWQCHcDC04E3PN9aTqN93NRggo8480UoWffUe/TvNFKPZauLft
   ZJmOrHl9K+asq3WXE7Namlw+4ihyj4krQX0+arsM3BhAWEO8G5YrNqCMU
   hc+Vmmqjolj05LZtk+oXBIF2MQ2jZ2BerBz+wS/ed/5cuuIkgLfqPjrUk
   gZ/V01AhCGbvItKy6JI49NFE7bRcYYtH1c6m2TisqYe7sKYrEh/b8j4o+
   Q==;
X-CSE-ConnectionGUID: 5zXgUhB5T4O5KRKrJIZjfQ==
X-CSE-MsgGUID: nR7h/QbcT2mIxr9NALa68A==
X-IronPort-AV: E=Sophos;i="6.15,308,1739808000"; 
   d="scan'208";a="82315313"
Received: from mail-co1nam11on2085.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.85])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2025 13:30:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7GVTwuePiK6yC/jZVL5+hz1V0r0I7nXhqxh2YcMVefaz7qbJ1GqOiNz3X9u1zvSubJg/HWlBy4QliZSZcqc/M5y5uxCbgyBMlrEgrQI2rEgzJMmAWNzev1QEnhYCcPO5MsoZfOETcHB4HC7zLjyKNNIwhVtPDYJpS2+Y5jI8HMWDlgANvQ7xfMrmCpW0hUyS4Pvkows6sL4tqtreRpRQ8H0MXXBmDz3Nn43QtTqe1w8O+Rw+dk/UsgyEvEBEYQByEUHeQg4TFOprk0QKRrlIsfNzVan9mTcDF5wvfuUNKeYM/OqODzo7g6B9ZN4w+tyJDNpX4+XaJuAD4FJp5rWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7G0PuMRY2Mfq+7NNO7w8nLb4AscUATXYbyomk/uiaI=;
 b=v0vfRbZ/rPgbUKV8ktbuHjtabIWTmXviDSCumnTpE/gqZtmC1ZkOaJJCJyYD0PD+vMDEB9INognCgaxPjsWOMgU2L0BRp1/8ssO44y+Ae1Hg7bUZyzBPNiA3s+ShfJJ+0cCl6Erg3GV9fnBFko23VNcVQmz2TiOTyDeoZQyt/dwKfITPpJ//LHou0e6S+mxz4w1asBOW2KWoWKR2Y+KPqpBPjg48qhZkn5+Dlq27UtkLlcgZmLqm7vw57nDrrLhix7D/h4DdY53KRaWCGSJhKR9ZCvxPLwMrTC0o6suM3Nt7ovKratRUC+NDlJIF9czp6FRDlaIjjMcbWdtSQhgF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7G0PuMRY2Mfq+7NNO7w8nLb4AscUATXYbyomk/uiaI=;
 b=GPUCo12morUnTyEjy1EuN3KBqPIhPDZztSGlUBIoVjG4ElCXCyfNX43217G9vFpsH/mcbGZQmhWPZlGSdOlGQpa3maMsvnd3dpGVnCG8uxp0w0xgST1GgV2HYAsIPFRd68hCZksSy8erBL6ukzb2CmF4jXhqhXRc/qBFmMxpxsY=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by CH5PR04MB9621.namprd04.prod.outlook.com (2603:10b6:610:20f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 05:30:03 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%5]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 05:30:03 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "cassel@kernel.org" <cassel@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"helgaas@kernel.org" <helgaas@kernel.org>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>
Subject: Re: reset_slot() callback not respecting MPS config
Thread-Topic: reset_slot() callback not respecting MPS config
Thread-Index: AQHbyzVhisCTrJczKES6+eV+2grOxrPfsQsA
Date: Fri, 23 May 2025 05:30:03 +0000
Message-ID: <a6c30dee9f8ff0b9846c4f356089991ae6c0e54b.camel@wdc.com>
References: <aC9OrPAfpzB_A4K2@ryzen>
In-Reply-To: <aC9OrPAfpzB_A4K2@ryzen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|CH5PR04MB9621:EE_
x-ms-office365-filtering-correlation-id: f822efa7-8197-4f27-0aa2-08dd99badea9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MEswbHMzeUtZbTQyZVRmV09LUTV3aFQ1dkRVWUJRSWJaSktYSTRhV21aeUUz?=
 =?utf-8?B?NTZyMXRSS0FMR2txZHo2WDdtNXVOWXZKS1lNV3R0cjZqblJoMlRLMzlYOTBm?=
 =?utf-8?B?eUdzM0pXWHFqYlVRR3FoSnlwclVkT3k1MWNpQVNWNzNOTjNjdE5WbnhhV0Fq?=
 =?utf-8?B?bjZ0NHdrOVliZE83RlpHakxIaVNyNHExa09aenVPd3pCcGdWbVJDV05XUU1Y?=
 =?utf-8?B?UzNPa0xLTlZkYmtVbFNQRWpnNUFzRFhMeS9pbnBzWDl3cDVqRnRvSXNYa0dQ?=
 =?utf-8?B?cVhqYXNsa2F4Q09oQzd2U0gycVZtTUpDbElNb24vRk1pclh3RysvcGRvOU85?=
 =?utf-8?B?L0Y1RG16TUFpN1VNTVlXSUpLT0pKYVoxVm9jRXdiYzhHeTFHMDlvTXpoUlgy?=
 =?utf-8?B?UFJ5VHNGRU1RejN0blpEK0JEWUhtVUFBZlIvMm5PdVFHbng1ZWxmNEorblVH?=
 =?utf-8?B?UE9nZ1VRUnVJOWxWbE1aVUdNc1U0N2JKaTBSUHZ5OWFCTzV0U0gwYWVJM3FH?=
 =?utf-8?B?WDgwYlJTVUJ1KzhGWE9neTZzQURmdmhraDlVeExIVkZEZEV2SWZLVCt6eXo1?=
 =?utf-8?B?YkxaNTJ2ZmFMa2s5TE03R2V0Sjl1NS9TbFVpbzcwSERBamU4MnpNRDNmWVYy?=
 =?utf-8?B?TlZubElFend6ay9VeVYxWkZ1ajdreHZTb3pkekdUMEpsSUNXY2ZPNjZseEJ6?=
 =?utf-8?B?YVkveVh3TzE2VTZCdWRtTktaeFp3M3pBdXZSRENFZjRMaUx6K2w1UWJPYkNW?=
 =?utf-8?B?aU5TSEVxNGxYN0pwTW1GWUZVUVp1b0l0OHFWdUVzNkZxQW9za3dFRVlHRCtu?=
 =?utf-8?B?RFp2YzNraDlWc1NOS2Q3cFI4MXNSV1RabWtoajV0bzFMYkFCYXlYK2x1MzRF?=
 =?utf-8?B?ZE5hYkFRWWsyb1ZVdXQ3emZraTdCNXZkSHhCbGx3TVh1RUxEZ2gwTE1RYzB2?=
 =?utf-8?B?dlNkd1VLRkhpNUlUVExnbXZVVER6Y0RFL3lEMDUwY3VrbEtzYStJSXlnU2ZH?=
 =?utf-8?B?UlNKMW5QZGd4N2xwdStISU16Vm43MnByS2JMQkx2NHgrVEtYc3o0Y3ArQXpa?=
 =?utf-8?B?R3pneHZUWDJXUG9Bd2dLRjhncVNFdWxxR1h5bTRORE5sN3gxSzhjeG5WK2N4?=
 =?utf-8?B?Z2tub0l3eDBLd3hNN0syL1JSY1c0T0NiYTM4Q2dvMklHMXV2dUtsL1p0UUdz?=
 =?utf-8?B?VDBNeDRTOGpkcEppQS9LYUM4TUdiRWtlZjdRY0JMV3FRSTFQeUN3eEZHNTN4?=
 =?utf-8?B?SnRGR1ZFYUllOGJNUjY5VlhYRHVQWFZ5WHA3ek1CcGMzRUdydlVIbTJXdEc5?=
 =?utf-8?B?OGJJZk5WMVUyeGx5bys3VFB3RnZDTTlRUVlzelR1eDc0d3h5d3hiZlFhM2l6?=
 =?utf-8?B?N29mODBTaEgzOWNrRGd5enl6SkdFTDgwcjhKdkh2d1RSenkxSzFGbDFKNitu?=
 =?utf-8?B?QWZFanZ6K3JwbXVrREcrU3hPTEZkc2NrQW1zMmN0Z0l0Uk9iYWZ1UG8vR2FT?=
 =?utf-8?B?Mm1HSHZTV2V0NWJSTlpRd2VqVjhLOElyZ2g4bVFsaVlhNERvOUhnYTAyZ213?=
 =?utf-8?B?eXRKWVdabnd4Snk4TnNhUEhDTzF5c2J5L0lqTDUrekR0elNML24wdnBGQ1ZU?=
 =?utf-8?B?VzFrS21lbENvdFo3S0RCaUgzV01ISVJNTFBTYjQvNGhSaWRMekxicEoySHpv?=
 =?utf-8?B?LzNORit3ekZ0eGl3am03Sy9va0pCRkFMbnBKd29MMjZxWGxraERuT3UzaUNr?=
 =?utf-8?B?YVoveE1wYlNKRkVINjhFSTFXN3BUS3ZQOGtZZnp2MHBJMlZsM2FpcEZvK1Ar?=
 =?utf-8?B?Q1RhblNmRmo2alNwazJNK0RlUWtQOUJxK0ova0YvOVVYVFZKRkpVRGk5Mks1?=
 =?utf-8?B?QzRpNHVRU2dQVHhKK0c4Q3Y0Zm85QXduNk9XT2JJUmpGOFY1enRaMUxhRGhI?=
 =?utf-8?B?NUJ4Si9aSWk5OXRvWmY5TTFKYTR4ZnI3M2hla0NxOVZqeVdWc0pqWGtFNFpT?=
 =?utf-8?Q?1VCxjeC+vlRUlO55rnmo4x5BvA3GRc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnVUMjdlWVpRZE51a3djdjZFU1B5VnRZaWY1OUJQcGoraDVDRjBzQlhtdkpx?=
 =?utf-8?B?dUg2VUF4VUZVNXY0RnF4OERaMlpOcER1ekttZ1JFUUFPN3RxcG1wK25BeDl1?=
 =?utf-8?B?RzQxUHJpY1JBVUx2eVNvaVBwRTljak1HaFZFZXh4QlRsaUlEUUY0L3ZpK2RD?=
 =?utf-8?B?NXZ2bE5EUENqQlVUN25XZ1d6VVNoaHR0bWJGcHdoVGROeGpxeDJtVWpXaXpT?=
 =?utf-8?B?KzAwNGl2V1M5RzFaOXBPSWlMY2EwQ2Jkb2ZtemE4OFBmbUkxUXJsSTh3VnE2?=
 =?utf-8?B?YS9JeitiRDhuNlJkZWZmRE5uazNFeDIrelQxaVd4Uk0xZGt2QUxxUjVSL3NX?=
 =?utf-8?B?V3JpQWxmNGtvSEtaTkNDLzFXN2taQlJFSytTQVNRc3FoM0VZOUFPYmE2enNw?=
 =?utf-8?B?dWV0SEdPNWlYSFMzQis2ZFcxTkIwMWltUmNGZ0ZoaGdNSFhZWmdQeS95ZTBy?=
 =?utf-8?B?UUVuT3ZOdVRQZFAwZEFqOE5vWGhXcmFnQUQwUHdKdU4yS3pEdE9jZzUvTWZs?=
 =?utf-8?B?V0d2Z1pwOUwwS2RCamlvZHloRnY5bDNyUlZ4U2pFL0l0bEtoMmFhWGNmRHcy?=
 =?utf-8?B?L1o1cjFqeUZ2dHpnSkFwWnVtd0lpSyttb2hSNHZQMzJRZjFYcy9yUnhsaEdC?=
 =?utf-8?B?cThIQ3U4c2M3T0xMenIrYUtBbmRjMTBXWm1rTWxEd2NlVjA3MWQxNEZaazVk?=
 =?utf-8?B?bjRQeEtvcWUvTWlhbHpKNm9rSytsT1FwSVhnemZiWUlCV1JrYUVYV3QxQ0VL?=
 =?utf-8?B?WnhUZU1PQXduNDFBbTAvdnpCQnF3S0NQczRYayszSUVvdmdpUU40ZWFkdWxO?=
 =?utf-8?B?bnNyREhhUkk4ektFWTFZNWcrdlZMSkI3R2dsNERDRkpTNnhrYngzTVZKVGZi?=
 =?utf-8?B?TXhBR0UxOE5EWlVqUFVXcEdaeStOSlE1eWlRRmwxUFRTSTdJV0ZaNFkrSzFB?=
 =?utf-8?B?VlA2b2VFNGxMNWhuUDNEaC9BWFJmUlRNUFJicWFBL2NRcUNkbmFOL3FYWWhr?=
 =?utf-8?B?WDZuU0hKNGxMTHBOYWlzVFNFWC9BMkh1L052TCszdVppdlBrUGlqVWZhZzIw?=
 =?utf-8?B?anFCWDNRaDNMbXFOMitBdEh1akgvK3F1OGZoZjFYeVY3RHV0Ump6UDdaaVFF?=
 =?utf-8?B?RzkzYlZETnUwRGxFdUk1RStrZXFkMnFvZlpBdXZUZThPVEgxeFNyTkxYVG90?=
 =?utf-8?B?bjBmVllrNDNhZTFUSDRqdGdYeVJ1YnN1MWhBazNUZXVjTjNGTW8rWGVxSFJH?=
 =?utf-8?B?NDFCbXNVS0tLZjl0aVEzNC8yNER4YTEyVDdQSFRGcmpyS0k0UmI5REpxRWM2?=
 =?utf-8?B?Q3dyNW9oajZkZXNlM0s1WktTNldwRGdUUnEvZXI4Sm5wVGFKUXZ6N1dqWWdC?=
 =?utf-8?B?YytQSjMrUjZzYlFQUXpaWjdacUs5L2Q5UG13ajAwb3dWZnZWeDQ3NEN5MTRK?=
 =?utf-8?B?MlFGZmVGU0VVbXFwZ3lhVW1zSlN6VjRTSklRTEUyTWhKaWpoeHZiNVFuSTBP?=
 =?utf-8?B?ME4zMTVvWUdOMDh5SDJLa2pVd29mUnQ5RFpoanNjQitYQzRaV3VtNlpzZDlN?=
 =?utf-8?B?WGVWRzBxbHRuWHA3MWJKdE00Skt2MHIxS1MvcmxvaWIxQlMzMyttSGczRCtE?=
 =?utf-8?B?bEh1YXlac29uNzhaWVVmT0VjcjB0UUt2elFNa0FEbXpvWmcyZDBLMnowS25G?=
 =?utf-8?B?K3RBOFJlcHFGdnNuWTB2alJ4dldraDFrc013TnNzV0VzR0ZZaDN6WFZPcnY0?=
 =?utf-8?B?Uk92MDZHZkVwQzRuTlJwcngxVWdNS3E4NmUxelFZbndkNzQrNVhqV0pMTFoz?=
 =?utf-8?B?aUdUclJjb1VEbllNZHNCU1hlQkdxWkQrMW1JWmdnSzZvbEVjcHN4ck5jVVgv?=
 =?utf-8?B?TjF2NnphODhBZG5rRGZKUG1ldElRL3Z3REZsWllaWndNNEhKNWkzRVhUaHQ3?=
 =?utf-8?B?T1R0SVNoTjMvYWQ4VERhQi9jVVNFcUk3b3JSMGNrbXB0T3poK3RuVWRyaldr?=
 =?utf-8?B?eElwbWtUK1FVamRSbnVkdVRMV3AzZTdmSUN3cys4L2JiNmF2L2NnQ3lHbXFD?=
 =?utf-8?B?bHVKSk40NGJ3NTdnaVg3MFFnRUNOcTVJNGx2aUFVN3RSZ0x6VElFa0xpcWxI?=
 =?utf-8?B?Z3FIR2VJd1ZRWVR5RGNxZnFVa3FZdllibU9YcFNPSHJkcUxSMkxSV2VLNmwr?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F348334FB8106C4493404907265D529A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I6zxbrI+bL25M5GlviyyrzTdwZt9bAQVdUL0+FxT5UttAqNYZ0yfdQozaJSmwzZSW39tbixqvH+5WsS0Z/rJwnkez+j1lDrVSLY+p1Owm4J1vljn55CQ1ZxMg2D59ay77WscC8zM+0TRQYyZazHxGGYlDyudFnTpPpeY7+cjfxRRqeD5M729oPwIg6hMmQd+c5xLCYgD9J3JUMICv5sSxbBODhzulmDB13WQbNhZGuA0ASE9OiKyeFXDHwYeZqD3uTwUl9X5VhkDeskaQzj+0Uqo1NeRVmRPJL9LtC7DCWx6T+hKfWmB+XG9ahsOtXvZqfpCPvTFCSj4LHxlLiwzBOTU5+UfwtdmJQzidwcEyTCNLCJRrM1XC2L98X7Z46Ur+dbHISOgwzuo2TjQiCdGNRTZuw7FDQtDpP4f+WPbnss7sErlNI1MY84J2NZe+JqOxGh9y+qzI0QDBJQ5nuj4OqbhbrZjw/PZjMtwSAG2ATjYw0UdGJAUH1JOCuDHgCCkTKG7updMDG5GYQ7B42DJ5ErPY6gEgTzl7xZ85XVN4OkOkqtEHIGf5PYt5PVbOATbhXPUSaCQl3m9AKGGy7ngrLcXEB6eqTrc0AMZIcwKysn6Ubi6RQtI+arp5QSaNYMR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f822efa7-8197-4f27-0aa2-08dd99badea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 05:30:03.4870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: neDvgi0fahVlD3NQbLj87IaVZEK+c0VXVWzF8OH3SxQnYZZELrYAsBM6cs9bqDps/YAc5EGU2BIFsQLQZlTtTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR04MB9621

T24gVGh1LCAyMDI1LTA1LTIyIGF0IDE4OjE5ICswMjAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0K
W3NuaXBdDQoNCj4gDQo+IEkgdGhpbmsgdGhlIHNvbHV0aW9uIGlzIHRvIGFkZCBhIGNhbGwgdG8g
YWRkIGENCj4gcGNpZV9idXNfY29uZmlndXJlX3NldHRpbmdzKCkNCj4gY2FsbCBpbiBwY2llX2Rv
X3JlY292ZXJ5KCkgLyBwY2lfaG9zdF9yZWNvdmVyX3Nsb3RzKCkgLw0KPiBwY2lfaG9zdF9yZXNl
dF9zbG90KCkgLw0KPiBwY2liaW9zX3Jlc2V0X3NlY29uZGFyeV9idXMoKS4NCj4gDQo+IA0KPiBP
ciBwb3NzaWJseSBhOg0KPiDCoMKgwqDCoMKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KGNoaWxk
LCAmYnVzLT5jaGlsZHJlbiwgbm9kZSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHBjaWVfYnVzX2NvbmZpZ3VyZV9zZXR0aW5ncyhjaGlsZCk7DQpIZXkgTmlrbGFzLA0KDQpUaGFu
a3MgZm9yIHdyaXRpbmcgdGhpcyBvdXQgaW4gZGV0YWlsLiBKdXN0IHRvIGFkZCB0byB0aGlzLCBJ
IGhhdmUNCnRlc3RlZCB5b3VyIHN1Z2dlc3Rpb24sIGFuZCBpdCBkb2VzIHdvcmsuIFRoYXQncyBp
czoNCg0KYGBgDQpAQCAtNDk5MCw2ICs0OTkxLDggQEAgdm9pZCBfX3dlYWsgcGNpYmlvc19yZXNl
dF9zZWNvbmRhcnlfYnVzKHN0cnVjdA0KcGNpX2RldiAqZGV2KQ0KIAkJaWYgKHJldCkNCiAJCQlw
Y2lfZXJyKGRldiwgImZhaWxlZCB0byByZXNldCBzbG90OiAlZFxuIiwNCnJldCk7DQogDQorCQls
aXN0X2Zvcl9lYWNoX2VudHJ5KGNoaWxkLCAmZGV2LT5idXMtPmNoaWxkcmVuLCBub2RlKQ0KKwkJ
CXBjaWVfYnVzX2NvbmZpZ3VyZV9zZXR0aW5ncyhjaGlsZCk7DQogCQlyZXR1cm47DQogCX0NCiAN
Ci0tIA0KYGBgDQoNClRvIGNsYXJpZnksIHdpdGggdGhpcyBwYXRjaCBhcHBsaWVkLCBiZXR3ZWVu
IGEgUm9jazVCIEVQIGFuZCBSb2NrNUIgUkMNCmJvdGggQ09ORklHX1BDSUVfQlVTX1BFUkZPUk1B
TkNFPXkuIFdoZW4gdGhlIGhvc3QgaXNzdWVzIGEgc3lzZnMNCmluaXRpYXRlZCBidXMgcmVzZXQg
dG8gdGhlIGVuZHBvaW50LiBFdmVyeXRoaW5nIHdvcmtzIGFzIGV4cGVjdGVkLg0KV2hlcmVhcyBi
ZWZvcmUsIERNQSBmcm9tIEVQIHRvIGhvc3Qgd291bGQgbm90IHdvcmsgYWZ0ZXIgdGhlIGJ1cyBy
ZXNldC4NCg0KUmVnYXJkcywNCldpbGZyZWQNCg==


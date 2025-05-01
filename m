Return-Path: <linux-pci+bounces-27056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4920AAA5990
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 04:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8E21889363
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 02:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBCB25634;
	Thu,  1 May 2025 02:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lTYrSFu1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uyFHU56T"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC62DC782
	for <linux-pci@vger.kernel.org>; Thu,  1 May 2025 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746065172; cv=fail; b=ZCV9fodhuGQK7vVA+rPT1lr5R0SEzwsrIn5g8AU1fUf4e/HZh5nSo7qhjuwbQbdZ4TWKp7lYfleeDxqvTpSk6spbMV+j9DGCtJnTprWTKXigDiv/JK+riX+fEYdHQAi8Tvq6oh10ug8CaEUWaCx5UVPHDLbI1lTHOYswOSYbv78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746065172; c=relaxed/simple;
	bh=E+iGPmGwYhuwS7l3vPJkpJAXJVaJlvcmxzslC6kUlA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YHs+RpaMe8HDUJnovVjxx6FOirVoPWnhrZt++pT7JNP39TVQElts7DRJyirUHf/LJPpsidqy+aEv0GK2zPf5eM2LO8z0F0arp6m7AIYdbnu4T7QYU2VjKtoej9sRZaFO33frosIoApC35BlVgXmcVblPZjwyfBCdhcQJc/mUhLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lTYrSFu1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uyFHU56T; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746065170; x=1777601170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E+iGPmGwYhuwS7l3vPJkpJAXJVaJlvcmxzslC6kUlA8=;
  b=lTYrSFu1YQMuVtZpcGAtyHYFCaxe0l/65wiqOtFpDyH59Bhf4FJKXntI
   xGeIDmagJAv7KRgIl7//ETsWW+v8+Jt3wamXjKaAxm1yWpqOZyoQuw08j
   p4DTWX3FPB9ZoVi65tehQTtE6lR9L897KT9OCezG2ArFKQ7u5Or4Bb7aM
   LN9IWIvqRsDTEhhq1r6laWPgq/kjcJT0tlGthwkUqEt9dFX3/7+JLLlkX
   QPxKS7WW//ILrjemzJTcyvBepgFtmsdwZxo5gslGRIrl9BR2Nd/Y1YQKC
   L4EZYjdDmp92dzXw3OSLawzHv10q37mv9axLryGjpLceOruZCDH4C6biu
   A==;
X-CSE-ConnectionGUID: 4JCaVV4aSjansvgo3nRn6A==
X-CSE-MsgGUID: VAfvNa0QRRmCyXE4uYfjAw==
X-IronPort-AV: E=Sophos;i="6.15,253,1739808000"; 
   d="scan'208";a="77642095"
Received: from mail-westus2azlp17010006.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([40.93.10.6])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2025 10:04:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlWDsH8a/RVKTWcxQwECq5x4gMpUYuh1/8RBajPydwNViiEoIwAF1fWYlQLYezCd84nrPTKiGSJJbW6T8qRzKByjMVCe1+sUcWeK7LynhSToMs0ZVhfwaLtuUNXCZpO8agczvUPmWT3UzGnsTLp/oAKbJ2zjrDjA3Ihn/s/6bSkDHXFHNYfNB0228P0OHa8wGj5JnYzEbK7lPTKEBGifbDDromFOfxSYhyF7gfZIMsHcOzCAtHrmow33WUL8QgOtNbMJ0bfnvE0nr/Pdu+K/OUqVS4GZywtGCaFJyYuv4tMVImp+/mIihChu0m/8P4mPHtqTGjS+QpekHvYuIXpjQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+iGPmGwYhuwS7l3vPJkpJAXJVaJlvcmxzslC6kUlA8=;
 b=sev2ZuyLJoTcg5RC/gnjjRsOnwKuQ5lEK8F7ehW7OejC9MHogaxmeVRzd5PVqyxvhyuVT6dDCfAsdpiVdEYRrAiGM+9kklscbYkGvAm36yxtylhzAG/hliPWFO3Ig6tE6AbwwaCjqfi7F88SiGQI+bwVZt+nuOdt++XFufGldKAdVnX9saFcpLQlqHg90KpyS5njflVwjOr18sbF1TlG2+U90xSXHXvknTxVR+nJ3MM7DCx+hYJODL3Q5hA1bzkhp0c6qSfCwV374e3DSGAPQxtGgCAJOeW28zlBlgh4W5iqnmNGs3oCwzcgDqA3WXWIXJkoWtQKH/vCG8+Bc67wkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+iGPmGwYhuwS7l3vPJkpJAXJVaJlvcmxzslC6kUlA8=;
 b=uyFHU56TZYdciMjfWTcyhs/mVqdzcTUqVbX+Dx20KlcqFStQRaeKrTbbMH8dJ5KvJX2KoY1Y3w0TivGepIcA/laMyNZxGpFvwd6aK2jBWk6Ucc5517A91aVN++18uLAEnOMxe70RTUpO59pbkTZ6iC5qxVLbE8xjwnGQQL/Cx1k=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by SJ0PR04MB8472.namprd04.prod.outlook.com (2603:10b6:a03:4e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 1 May
 2025 02:04:58 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%2]) with mapi id 15.20.8678.028; Thu, 1 May 2025
 02:04:58 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "kw@linux.com" <kw@linux.com>, "cassel@kernel.org" <cassel@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
	"adouglas@cadence.com" <adouglas@cadence.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH 2/2] PCI: cadence-ep: Fix broken set_msix() callback
Thread-Topic: [PATCH 2/2] PCI: cadence-ep: Fix broken set_msix() callback
Thread-Index: AQHbucvtwrUKoisnzki+CQ/6pHdxYLO9B0eA
Date: Thu, 1 May 2025 02:04:58 +0000
Message-ID: <53b7304049e18e62a62c04ca6d0ebc20ed6a8ebc.camel@wdc.com>
References: <20250430123158.40535-3-cassel@kernel.org>
	 <20250430123158.40535-4-cassel@kernel.org>
In-Reply-To: <20250430123158.40535-4-cassel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|SJ0PR04MB8472:EE_
x-ms-office365-filtering-correlation-id: 30a2b716-05c7-40e5-3bf1-08dd8854931e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NHpleDZvRitDYnRURlp0eWlwVWNMcmpoWjlnL0x1bUhuWmUzdkhUNVY1QkFE?=
 =?utf-8?B?WUhxcEkrSTFTT0lzSFMwcSsrdzV6a29sejJvUk1meWpjRDgrb014blRSM3F1?=
 =?utf-8?B?YXJyMEw1cEJMVU5ON0tPOEdqRGVuUkRSZlpITUZqeDVFSDR1RXNaYWRxZGRP?=
 =?utf-8?B?K1RzbmVtLzBmRS9FRHFGa0ZQbXExa1g2d1g3MlVYRUxpZkc0S1g2Vk4zODYw?=
 =?utf-8?B?VE9INDBSeGlHYmJLcjZXRmxRdThlakxYYXZuNEZhM2tPQlpNSDEweUJSQ1hU?=
 =?utf-8?B?eEtIMjhEaTBpVEtQenZXMHZIcHBmejVvU3kwVmRRT1BNc2ovWG5abFNWWW1D?=
 =?utf-8?B?MTJ3Q21KUlpsU0YvN0NBNkhSRE5lVXlOQ01valNVYzRDVzZHU1BWTjNpcndz?=
 =?utf-8?B?eTNlM3hIT1RPYjNlMjZwQ0NHSkZadXVxem4wRGpRa0RkMksvMzUwYzM0WWdS?=
 =?utf-8?B?c213OThERXdmNW1KS1B2TExDclhuUmtkNE5xdHltUE4zQ1FwT0VtWjNEWUd4?=
 =?utf-8?B?OVN4M1c2L1EzQng5MXdYZWtWS0NzYTM3b25sWlZ5RFNpeXhKUnJ4ZVRGQk5i?=
 =?utf-8?B?MUVHUW11b3FwMENSMmZPSEJzTjU2NDBQV3NrZm90RWM1aWhteVJ3T1BRVGt5?=
 =?utf-8?B?Z3R4NnFlbXhXdE9qQlZ6SXNTNmlWaWF4bG84TTVrS1puRGtSU1lmR3Q5djI2?=
 =?utf-8?B?c3UxS2hIWWFYay9MTHZBZXlsUVl1NDNlT2hkWGVoSmhRRk5MY080OUZWSUFX?=
 =?utf-8?B?OWM5QWpXS0hFd29SRDNaRnJQMU9KcWo3bHlob2J5TmFlRnN4OHp2cW5YY2xm?=
 =?utf-8?B?bnZOWis0L1dhU0hmNnpWKzc1YWtGb0Fvc040Y0lXYUxaeUNNWU5xekd1K2k5?=
 =?utf-8?B?UDVnajJrRXl0TnNsRlFpNitnemFoMElzMVAwWFJNUnU5V1EvUmhHVThYcWFQ?=
 =?utf-8?B?TXEzcysrYXFwcFBWREJRaVNISXJxV24zTGxRVHhmTVFqRnpyRWg3ZXRWZ2RI?=
 =?utf-8?B?anNQcDJvMWpTZ1ZFYis2QVhwaitBcTFaQ0xrY1dDY1ZaM0UrOHprbVZDSy80?=
 =?utf-8?B?NTh6ak5mWjZYYTY2dU0zdFdhb3AranpJaTdOaVRNdjBTb3I1SFMrOHI2aGVy?=
 =?utf-8?B?RHZjcVdyaXRtaWRyU1NuOS9OVUx0RFkzamMrcEdxcXNUeWtySStsZFJvekt1?=
 =?utf-8?B?R2lER1NrZTUvdlQ4R0RZRDljb3l3cmwwajluUWx0OEliVzBSa0hmQ0JjU2Yz?=
 =?utf-8?B?UzZmVmdwenlYSDkyeVNaUnNDdkNrL1cvOXBRK3lHUWJZUUhVNXN2WmVNakc0?=
 =?utf-8?B?bUpiVzZSZWI2WmRaVDE5aXp4ZTkyekFxYVpxMzNzeHM3THBSQlpRZyt2WklW?=
 =?utf-8?B?TUpJSTdPd3FPWnpJR0xBQ0tNcWwxdThoSmlSOGdtZGZWeFdqbHRGbVJ3a2kx?=
 =?utf-8?B?aWpTNThUY2FreWZjSVhrS1J0TEdsTEV1QTQramlQdjA1bGVKODJzL0hQNk5D?=
 =?utf-8?B?MHQ2c3RBVlpJek94QkxxbitWQnFxSkpxZE9JMWJWL3cwTU9ETUQrNHkyYUFN?=
 =?utf-8?B?NUJjSHpxK01kUEVjMVlXRGRIdWZYbzUzTkF2U21JaExuWHo3NWpQNklKMUph?=
 =?utf-8?B?cENaMG03RFhvLzQ2eVZaeTAvdE9tZWpnMTlKWGRrL2FkVjdpWkYyQzd5OUtj?=
 =?utf-8?B?NXZwYVNmN3FxN25sRXZ4TWNvVFJSRytyMm95cXp2UzVoaU5jMmM5M0VScHM0?=
 =?utf-8?B?SStHbVAxUlI3MDZRWGx0TjFYY0ZmaWJSMkFHU045RThDaCtRRExyWVVaTXFN?=
 =?utf-8?B?YThPYnBRdXRnNDdDMU4xU2VRc3VURnNTK211R05VNk80QllPdHplTXA2NGI1?=
 =?utf-8?B?SWdXclVkSDhGdXZJY1NhM0dpZGY4TzV3b2Npc0tGeHlXYldld1A0eHNvWXFs?=
 =?utf-8?B?YXN5UnRob1AxZ2FzcFA5VXhDTnZJVEYxM2lTRkxCWjNKSXUvNU8yVmNDdGRq?=
 =?utf-8?Q?CkAiDX9bUKAsFlkdDtzrzeOA+8+pUA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3hZdTAybnRqUDdURlh1ZFlWQ2t1eHE5bStnRlBXV1o5TllXd2toNkU5a25P?=
 =?utf-8?B?cUZQbDJ1cU9FZUVvZXg2NURqQVhxM250VXBtT29xNHU5VFBRTTBPaCtSaTVu?=
 =?utf-8?B?NU1lcTltS1BMYk5WanZjK2VrVzN3bnlOUnZHUmRRcmpKcXFyWFBqam1icFJ0?=
 =?utf-8?B?bFlXQlFTdVFnaGFGY3VTL3o3OWdoYloveDFzS1l6bWFGOWxZdkg1Ry8wZ2RK?=
 =?utf-8?B?VWdJcmU2UTNZaFpRb05DRzBERXRpTE8wckxQTDR3T05WTDVSdG1vN2d2UDN0?=
 =?utf-8?B?Nmh3Q1dlazFDeUdlVktKd0E4NTY3S1Y5REhtMXJETEJRNzZhaG9nQVVoTnho?=
 =?utf-8?B?OGFDa0gzdG4zR20rNkNXN2hnVzk5UEhhbWlVY3dqSXYxSXEwcmE5RVFqQUlU?=
 =?utf-8?B?QjlaeE1iK2lVejYxZ1lRSWdNeE4vVXBrb0Vaenl2cEdXa1BrNmN4K1BMeitS?=
 =?utf-8?B?ZzVzQUFRZ2ZyVlVXR1YzMTJNTnkwRkEvVTl2cEtlMmw2T0RJRWVnSmNjdFcv?=
 =?utf-8?B?bzI2YyszcU9McHBZa1BHeGdWOWQvVzRkb0dxRVNzRXh1QTZ6eGx0Z3c1WnRK?=
 =?utf-8?B?VDVHbVdCeUpaVmVWNzRZME9SQkxETkZTS3NzeDZnU0s3ZGhjR3l0ZzhrVm1s?=
 =?utf-8?B?REFhbHgvL0NiV1N0ZVYwV1J6SGYvanRvMzRnN2wvMlM2dklYalM1NUt0Ujdq?=
 =?utf-8?B?VmdJcW9SZEE2bVUySkJXYkF0blhGTnZCRFpyR3ZMVk5tZ2xsc21IZFdYQ0VG?=
 =?utf-8?B?RDUrSXVidXVidkw5MGdIcE9MV25ZZ3BsTGRickluN3BNNDVlOHlsY1lLbHZW?=
 =?utf-8?B?emNrTmlXVm5odklmK3RCOExYd042L09TN2NWWVdXL2ZoTlYxOU91VmI0M1R2?=
 =?utf-8?B?T2M0WWhVWGZjZ2FuZWFTTVAxSEFoYm9IbkFHZTh6clBVZHRwa0I0QmxRZWxJ?=
 =?utf-8?B?d2JlUmxlR1pkcVluVVZ0MHVoTHRjVGExMXBtdHN2OXhUL0p0MWtnbVRtRGYv?=
 =?utf-8?B?Z0ptcXdjc1hSRlNUVHl2R0lMVTN3a21sY1RjZkQ0OVhXQ3FFS3YwNlVWUjZq?=
 =?utf-8?B?UXJReUhicEJwU0l3OFcyaGVCbkk3akI1ZzZCZEE5eldvbG1iR2t4U0pZUE1C?=
 =?utf-8?B?TWZXaUVFS0VGeDFHallWRklPSTZwbndxSEJlRE1YYVgxNU9tM0thKzVNaDhP?=
 =?utf-8?B?ZXQremZId3ZCZElONG9ZQXIrUzIxbjlCc3JIak5ubkhXZGZ4VERJS25JK1hJ?=
 =?utf-8?B?dW5yWEE0MTY2dTluSXFPZE9RYWVDT0ppb0dYb1JkeVdyN25zZTRMNWhxeklX?=
 =?utf-8?B?dEgrUnB2WjV6aWRBS3AwMExaSmtTbXR3amcyS0NIaWNxK05laVY5Uk85a3Az?=
 =?utf-8?B?ZHNPS1lPeC9PdnpUSnZiMFRlYkhiYVlqODNDUTRuZEFMcGs3bE9jLzJReHRC?=
 =?utf-8?B?SWF6MWo5MlRVSVZxdndvRkwvOG9vVjZDTFBvejZQTWs0K2ZpaVQ0bkhzd0JG?=
 =?utf-8?B?MVFSc01YTXVDdk5CNlh3ZS9rQjRqaTBvZXpZMVpTcWNadVI4NXZNNldUNldo?=
 =?utf-8?B?amJ1WFlya0FUL2Rhck5ROEJOMGxwZkptNVBlaGxOTTdmSGZRY0VnRHluN2Jn?=
 =?utf-8?B?VHJsMHJJVXoxUUI2WE5JTS9JdEJ0NVgwdWV3TEEyTlJvMEttV01yRDFSQUlB?=
 =?utf-8?B?VnNWejN0clBleEZRTmxWcHZwTTdPS1pFcHA0UXVxbnhySUpRWnNJTndUcUkr?=
 =?utf-8?B?K0FjVm9yeHV4RVp2RGxXV2lPbXFpM1Y2ZUh4dUtSNC81ajRhUUlxZ0JCOGUv?=
 =?utf-8?B?L2N3ZUVUNXY2cTk3MmpCQjZ2Tm1wTG0wOTdORHUwVTFVMlhJMHNweDZ2R2tY?=
 =?utf-8?B?WUc1NXJQc1BTRStuVjFsVTJwVGdPejFtU1BFSzVMOFVqRjRzRjYxa3hNdEIz?=
 =?utf-8?B?TThHRld3cVlxdVBsQnJuSnRvenUvNzU5SytsQ2RxQnFTQTBpWWhvSUkxeXBS?=
 =?utf-8?B?bVpxOTNPd2NtRHloTkJhN3Q0RXV3Uk5Xc1lUK1lzUnB5UXIxSlZWcms5TG5i?=
 =?utf-8?B?b3J6L2xpejVVdUk3OCsxdXRsZmduSWtuUU5oREJCQmVoRkh2RTV6UWovTkpE?=
 =?utf-8?B?eGJaZnRSN3BRY0l5Mkk0TGRBN0VQcEpPQXlkTUxVV01hNUp5Sjh0SHVBSUJo?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A0B9B0BEBD11145BD83BD43D9EC5CF6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FMdbKLQEbaerJ8XFT/gUzEpiYYJ8dXvl+vaKAY81qabW034cXBAzQGQxSwVaR6si6AtqEi0z+yaZwfjRBVcwPi7Fe/dYu1gCf8WJSTBm/h1HKxrLmDRuhB0NgZn79ccKpF3TbKUWscKGnhhW1llMzJUKI91jaqKNYtH00XVSJ3eqO5Sgmq+K4FCMVrfceg7pqHIbyze/U7+rSoOfgp3yLda6wuXlh8CLVq9wp6VufY1X+2gilfRtgFsjX+xd9UuG0nyO1W7+eSH+yjQlcYfD4pBKIfEbNFzpA5Xf3YnVULygPq3m6JcxpfSARWJ7Q8oE162ERj9FDI4wM7eZyrCsgBhbcRV4jWVQwBRPHrbFz/FAQnFP4sm2YKcGaiPAMrVwRRPgBxEnviRIczg7M3yd1FNJeowFoBoi9Od6ryufjKoUbptLwiFhUrKsJ2LMiSXjYNLfX0GDo26guXIj7Pg38Tp4pMOaCNZPB+V72FVz2RmZuBmfrQVq+Sx5nPIef8TBtgylYXMJPh4CvW+eLbj1/WaAZnLgnZfCrNWBNFoJcq1zAAKqcdEX9fjmJ4KTdf0h4kliSbf4iFks0mckGu8j4hlRDMU/oGtTLHDqCp87gpmygXH2dI5COGyaV9clcPqg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a2b716-05c7-40e5-3bf1-08dd8854931e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 02:04:58.2770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gjqo59+ZJrYtJDA7fx1yrQ9gZuUvV6nWULgAZyg25xA8hk38GDMYoVG3bKMvvv/S5JUsSWEozd4a1A4NJVs3RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8472

T24gV2VkLCAyMDI1LTA0LTMwIGF0IDE0OjMyICswMjAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0K
PiBXaGlsZSB0aGUgcGFyYW1ldGVyICdpbnRlcnJ1cHRzJyB0byB0aGUgZnVuY3Rpb25zIHBjaV9l
cGNfc2V0X21zaSgpDQo+IGFuZA0KPiBwY2lfZXBjX3NldF9tc2l4KCkgcmVwcmVzZW50IHRoZSBh
Y3R1YWwgbnVtYmVyIG9mIGludGVycnVwdHMsIGFuZA0KPiBwY2lfZXBjX2dldF9tc2koKSBhbmQg
cGNpX2VwY19nZXRfbXNpeCgpIHJldHVybiB0aGUgYWN0dWFsIG51bWJlciBvZg0KPiBpbnRlcnJ1
cHRzLg0KPiANCj4gVGhlc2UgZW5kcG9pbnQgbGlicmFyeSBmdW5jdGlvbnMganVzdCBtZW50aW9u
ZWQgd2lsbCBob3dldmVyIHN1cHBseQ0KPiAiaW50ZXJydXB0cyAtIDEiIHRvIHRoZSBFUEMgY2Fs
bGJhY2sgZnVuY3Rpb25zIHBjaV9lcGNfb3BzLT5zZXRfbXNpKCkNCj4gYW5kDQo+IHBjaV9lcGNf
b3BzLT5zZXRfbXNpeCgpLCBhbmQgbGlrZXdpc2UgYWRkIDEgdG8gcmV0dXJuIHZhbHVlIGZyb20N
Cj4gcGNpX2VwY19vcHMtPmdldF9tc2koKSBhbmQgcGNpX2VwY19vcHMtPmdldF9tc2l4KCksIGV2
ZW4gdGhvdWdoIHRoZQ0KPiBwYXJhbWV0ZXIgbmFtZSBmb3IgdGhlIGNhbGxiYWNrIGZ1bmN0aW9u
IGlzIGFsc28gbmFtZWQgJ2ludGVycnVwdHMnLg0KPiANCj4gV2hpbGUgdGhlIHNldF9tc2l4KCkg
Y2FsbGJhY2sgZnVuY3Rpb24gaW4gcGNpZS1jYWRlbmNlLWVwIHdyaXRlcyB0aGUNCj4gVGFibGUg
U2l6ZSBmaWVsZCBjb3JyZWN0bHkgKE4tMSksIHRoZSBjYWxjdWxhdGlvbiBvZiB0aGUgUEJBIG9m
ZnNldA0KPiBpcyB3cm9uZyBiZWNhdXNlIGl0IGNhbGN1bGF0ZXMgc3BhY2UgZm9yIChOLTEpIGVu
dHJpZXMgaW5zdGVhZCBvZiBOLg0KPiANCj4gVGhpcyByZXN1bHRzIGluIGUuZy4gdGhlIGZvbGxv
d2luZyBlcnJvciB3aGVuIHVzaW5nIFFFTVUgd2l0aCBQQ0kNCj4gcGFzc3Rocm91Z2ggb24gYSBk
ZXZpY2Ugd2hpY2ggcmVsaWVzIG9uIHRoZSBQQ0kgZW5kcG9pbnQgc3Vic3lzdGVtOg0KPiBmYWls
ZWQgdG8gYWRkIFBDSSBjYXBhYmlsaXR5IDB4MTFbMHg1MF1AMHhiMDogdGFibGUgJiBwYmEgb3Zl
cmxhcCwgb3INCj4gdGhleSBkb24ndCBmaXQgaW4gQkFScywgb3IgZG9uJ3QgYWxpZ24NCj4gDQo+
IEZpeCB0aGUgY2FsY3VsYXRpb24gb2YgUEJBIG9mZnNldCBpbiB0aGUgTVNJLVggY2FwYWJpbGl0
eS4NCj4gDQo+IEZpeGVzOiAzZWY1ZDE2ZjUwZjggKCJQQ0k6IGNhZGVuY2U6IEFkZCBNU0ktWCBz
dXBwb3J0IHRvIEVuZHBvaW50DQo+IGRyaXZlciIpDQo+IFNpZ25lZC1vZmYtYnk6IE5pa2xhcyBD
YXNzZWwgPGNhc3NlbEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gwqBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLWVwLmMgfCA1ICsrKy0tDQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLWVwLmMNCj4gYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLWVwLmMNCj4gaW5kZXggNTk5
ZWM0YjEyMjNlLi4xMTJhZTIwMGIzOTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UtZXAuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLWVwLmMNCj4gQEAgLTI5MiwxMyArMjkyLDE0IEBA
IHN0YXRpYyBpbnQgY2Ruc19wY2llX2VwX3NldF9tc2l4KHN0cnVjdCBwY2lfZXBjDQo+ICplcGMs
IHU4IGZuLCB1OCB2Zm4sDQo+IMKgCXN0cnVjdCBjZG5zX3BjaWUgKnBjaWUgPSAmZXAtPnBjaWU7
DQo+IMKgCXUzMiBjYXAgPSBDRE5TX1BDSUVfRVBfRlVOQ19NU0lYX0NBUF9PRkZTRVQ7DQo+IMKg
CXUzMiB2YWwsIHJlZzsNCj4gKwl1MTYgYWN0dWFsX2ludGVycnVwdHMgPSBpbnRlcnJ1cHRzICsg
MTsNCj4gwqANCj4gwqAJZm4gPSBjZG5zX3BjaWVfZ2V0X2ZuX2Zyb21fdmZuKHBjaWUsIGZuLCB2
Zm4pOw0KPiDCoA0KPiDCoAlyZWcgPSBjYXAgKyBQQ0lfTVNJWF9GTEFHUzsNCj4gwqAJdmFsID0g
Y2Ruc19wY2llX2VwX2ZuX3JlYWR3KHBjaWUsIGZuLCByZWcpOw0KPiDCoAl2YWwgJj0gflBDSV9N
U0lYX0ZMQUdTX1FTSVpFOw0KPiAtCXZhbCB8PSBpbnRlcnJ1cHRzOw0KPiArCXZhbCB8PSBpbnRl
cnJ1cHRzOyAvKiAwJ3MgYmFzZWQgdmFsdWUgKi8NCj4gwqAJY2Ruc19wY2llX2VwX2ZuX3dyaXRl
dyhwY2llLCBmbiwgcmVnLCB2YWwpOw0KPiDCoA0KPiDCoAkvKiBTZXQgTVNJLVggQkFSIGFuZCBv
ZmZzZXQgKi8NCj4gQEAgLTMwOCw3ICszMDksNyBAQCBzdGF0aWMgaW50IGNkbnNfcGNpZV9lcF9z
ZXRfbXNpeChzdHJ1Y3QgcGNpX2VwYw0KPiAqZXBjLCB1OCBmbiwgdTggdmZuLA0KPiDCoA0KPiDC
oAkvKiBTZXQgUEJBIEJBUiBhbmQgb2Zmc2V0LsKgIEJBUiBtdXN0IG1hdGNoIE1TSS1YIEJBUiAq
Lw0KPiDCoAlyZWcgPSBjYXAgKyBQQ0lfTVNJWF9QQkE7DQo+IC0JdmFsID0gKG9mZnNldCArIChp
bnRlcnJ1cHRzICogUENJX01TSVhfRU5UUllfU0laRSkpIHwgYmlyOw0KPiArCXZhbCA9IChvZmZz
ZXQgKyAoYWN0dWFsX2ludGVycnVwdHMgKiBQQ0lfTVNJWF9FTlRSWV9TSVpFKSkgfA0KPiBiaXI7
DQo+IMKgCWNkbnNfcGNpZV9lcF9mbl93cml0ZWwocGNpZSwgZm4sIHJlZywgdmFsKTsNCj4gwqAN
Cj4gwqAJcmV0dXJuIDA7DQpSZXZpZXdlZC1ieTogV2lsZnJlZCBNYWxsYXdhIDx3aWxmcmVkLm1h
bGxhd2FAd2RjLmNvbT4NCg0KV2lsZnJlZA0KDQo=


Return-Path: <linux-pci+bounces-10033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0960D92C8B5
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 04:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214841C22222
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 02:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827181803D;
	Wed, 10 Jul 2024 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XIWJHeS3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OO/f7ddj"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1EF2F36;
	Wed, 10 Jul 2024 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720579611; cv=fail; b=eP8v+5GUpMFXvjNxvPJqCebbVTXwRNUPExcOYqpaScxf3nknggS12e7yR18vzNNsPDTLtFp+IQNf5nUC5aaPwlquwns+lAWQesNx51ce+MkRM5yaoZ0mGCACCyMT4VIniRHnmpvII0JyzgimMkTjX9XfwOhNDqaZGDZg5caGR6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720579611; c=relaxed/simple;
	bh=f18GcyGokR9f/Jwb7J/667y4P/feEBmKnfKXs2+MxHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qmiymlu8Qfdf5FSrBqRl/67A0jt4EcDQMDDiBxOSVl4r5zB1HO3Z1tIonHZ7qfU3VCQNKGLQtPnYFVZBBjtc+NPRgZKM4SnjhRs83S1+yI7qiJ/multNY1Z6tq6TKdFMSdSUTOgS5j72uQZ12oQChBBnmvL/jVvYJqWTixaoGRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XIWJHeS3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OO/f7ddj; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720579607; x=1752115607;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f18GcyGokR9f/Jwb7J/667y4P/feEBmKnfKXs2+MxHE=;
  b=XIWJHeS3V6jJh3paGeUJpsd2gZGqfXmywdNEdfK79ZU2HqOdm7HFxiZp
   fpSK2BFqpcTqiv/qrJmklFWpT9ScufkrqZuiLEBwF6ioAda8hQ7ao06iW
   fj6f6rmTI4Uk5hgTzXeGyv2JAg62Ijod37mAa0imf3qXqKkqT53mZjeO4
   MS+qRyZYPFFuOuTjaYAD3h9+TBFmtNKfxtyAyEKNdKnq4uELrWGAP4UlL
   8AXaN2pZsQsuvOWWSqTUaZGsqT1Ol5dR6ygbX7Tozx/4l+jT5SNz6VQ5h
   q14DYkFw3KOJR2gjWraUNBPG0RNCvt6KbaU8UzBOLhpWrdfvNBWf8pnGi
   Q==;
X-CSE-ConnectionGUID: 4cEwWcjOSZCZFGwDdULoMA==
X-CSE-MsgGUID: Xw5SCoZOQ3yOCgJsMiQGwg==
X-IronPort-AV: E=Sophos;i="6.09,196,1716220800"; 
   d="scan'208";a="21330469"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2024 10:46:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrILo7VTyvx9sM6vqhQpgYaXoj0OBdhMKnqpQ/agDxaDamSsEC9tQ+heiyOiIxq2PV/R/uUEEDPk6KNebb+Eu7PgWzekUSP3cC7z2HnVMym964Pbl5VtV0KpNLepATu3b8M11lOSno5Slo4jMqCMUwvAIyaxy2N8vCEZ1DzO8jRXiCNPvoq6H/pKJ+pTw+dLcb/4/+mPS/kdT5xSoAytStDlDGMZzl97fQvGZgBLNPDKC9mMdwsRoFy6WDqdHAp358ZWULAYHKyuf0LkM9FDlzeh7Uj/dFs8esDRgKFxFbl8TqM+/wVNQUzvD92TaNNMAFD24ytPwC+xJ6uteXzCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f18GcyGokR9f/Jwb7J/667y4P/feEBmKnfKXs2+MxHE=;
 b=InUSRxV8vN418bvHcvwbWA6ipln7I1GXKpFASgxdSuih8J5HzvggSpsNgv5Hc0xP05y/Q+8JlguKcplvFdBjgMTyYxfHWchoCGSPjtlAp8f4R8bZFA7qAx40pNhYPHfe5PZwq4uaT6BvNisf+5j69BBhChNtGxPmSx8rIcVp2za45JhQBgjkgV8KuE7/Wrp7ilhuyIjGymQ+OQXbn+BtCAnrCZ+7hAk/ET2tZt85x4bJCvtmKaRejfSuR4p8tDWxLmxUiao9vkNt3smdJHxBiSrkW40+6iJX2EJ9itY2A5JuCg22xgDsP14zTciMW3V+ZifXUUYl/JYd5ny8oJIabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f18GcyGokR9f/Jwb7J/667y4P/feEBmKnfKXs2+MxHE=;
 b=OO/f7ddjcff2hShvvNWCdySNEMV9gDxO8oH5oL2gVw9pmy0JtH5DyWj/lBG6Xf3acTrSG5FbaoStxfVJ205HIphoGtgs6UH5jq+mmjLXXEI7doNLbk9C6pIOZ6bu9v8jq0dQYPG1R8HTtKvN16DqoYZxQwXFgW/DddQ4TYtkZus=
Received: from SJ0PR04MB7872.namprd04.prod.outlook.com (2603:10b6:a03:303::20)
 by SA0PR04MB7227.namprd04.prod.outlook.com (2603:10b6:806:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 02:46:42 +0000
Received: from SJ0PR04MB7872.namprd04.prod.outlook.com
 ([fe80::3c90:f146:c39c:33cc]) by SJ0PR04MB7872.namprd04.prod.outlook.com
 ([fe80::3c90:f146:c39c:33cc%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 02:46:42 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "dhowells@redhat.com" <dhowells@redhat.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>
CC: "ebiggers@google.com" <ebiggers@google.com>, "sameo@rivosinc.com"
	<sameo@rivosinc.com>, "graf@amazon.com" <graf@amazon.com>,
	"jglisse@google.com" <jglisse@google.com>, "ming4.li@intel.com"
	<ming4.li@intel.com>, "gdhanuskodi@nvidia.com" <gdhanuskodi@nvidia.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, "seanjc@google.com"
	<seanjc@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "david.e.box@intel.com"
	<david.e.box@intel.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
	"dhaval.giani@amd.com" <dhaval.giani@amd.com>, "aik@amd.com" <aik@amd.com>,
	"pgonda@google.com" <pgonda@google.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v2 01/18] X.509: Make certificate parser public
Thread-Topic: [PATCH v2 01/18] X.509: Make certificate parser public
Thread-Index: AQHayyZR09ZDsIIRGkiFqVEiPpGJFbHvUHyA
Date: Wed, 10 Jul 2024 02:46:42 +0000
Message-ID: <c1e50d249b5154f746ee1cd255c98d2a6ae56082.camel@wdc.com>
References: <cover.1719771133.git.lukas@wunner.de>
	 <014885d5b43b5c0fdeff67c7f95b978405740126.1719771133.git.lukas@wunner.de>
In-Reply-To:
 <014885d5b43b5c0fdeff67c7f95b978405740126.1719771133.git.lukas@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7872:EE_|SA0PR04MB7227:EE_
x-ms-office365-filtering-correlation-id: 2a783970-c3c0-4d0a-d211-08dca08a87a9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K3JFZGVBMjhYRHlzYUNTbTJuczFQam5uYzNQeDlpUlRYNy9aTDVPcXdsdk54?=
 =?utf-8?B?dTF5UjVadVVUY1hWckNmZUJQdFZmQWozcG96Mnl4RHJWTC9QT3MzTVRxc0J6?=
 =?utf-8?B?L01jM2wrczRuQWt6T3ZLbmZXQ2krckhrWlhyUmtmYjJ2NG1SdkpGNks0cjBq?=
 =?utf-8?B?T2tnWVdUbmk3WE1ocVJhRnFQajhyWXg2ZFVRdlpEZHhueXlaSnM0eDBqWGk0?=
 =?utf-8?B?ajJFUVFETkNlSGJBbXh2aEd1TmV6cWFjZlR3ZElKY0pvRHVSMUZycXBQZ0o4?=
 =?utf-8?B?d21IellpbWJmaEhzNDBXWlJUWFZ3Y1RrSlhXeU5zdE1nVVhhU0Ixc2h4RGhz?=
 =?utf-8?B?WmpUWlJScW5GNktFZDVVdVFNcnNVbnAyU2xnS2hBenlnUWk2bk4xWTBKOGdx?=
 =?utf-8?B?bTBzN21DZnYvY0NlYWg1djF3Q01kMSs4MHhJZTNWZjZCZkRNZGVORjVoTGR6?=
 =?utf-8?B?OUlyb2ozVVVlZXJvOHRMRGUyQ3cyT1hTdE94UHFHcFN6THZqbng4c2s3Q1FT?=
 =?utf-8?B?OG5pMVBWd3lRNnpsU2t0OGlRTmhwbllDMDd2MkhmbDFKRFNmZUIzaVdQTHlp?=
 =?utf-8?B?cjgvY2xZdUxPMUE3cVF6dmV4N1JSc1hyUWJDRCtPL3NDTi9tWVM1ck9xVC9u?=
 =?utf-8?B?N0NjaXZPU2tjSk5KZG5Od2JML3JRQWs1TXZYRlM3MEcrK0V0b0dxQU9ITDJa?=
 =?utf-8?B?bU5WZldKdUpPVjF1VHFYZFJaYWNseUJXSkh2aTVIcTVSY2w3c0FpWkhaWjM3?=
 =?utf-8?B?TDdZN01NVjVmQkhpOE9UU2JhUFFXdHBzditQQXZpcUZpTVZxMXNHK0Mzanc4?=
 =?utf-8?B?YTZsOFdGNHJWYS9nOTFNV1dBazhmeTEzZ0l3TUhJSitmV0k0OHpyaHgvSmxW?=
 =?utf-8?B?MWNhL1pKLzgvai9XTEtld0VrSFBMbkIrUDFYRVduTVZtQ0lydy9MZ2svcUIx?=
 =?utf-8?B?SGF5NWVpQTFjakQxUXVpLzFTVXdiK3MvYXYrYlBZOTJhVXpBYW1DVGQvQytJ?=
 =?utf-8?B?czlrNGRGUTZyV201U1lpSFNKdVhJNkFEa1grcnkvejVwc29aT3hPSzBiMnJ0?=
 =?utf-8?B?K1c0ZUJHYkpoVGRWZmJmMXEyQkd1WllMQzQ3cHlRYkMyRXFEYmNwUEdKOU43?=
 =?utf-8?B?YlE0LzRHSnNuSE1TUFJLQ1NHQWZxcmwyV1E4ZHpuMzVDd0xMdjRaeitPbU4z?=
 =?utf-8?B?ek9IejhteFBPZWpuZlBBWEJ2VWI5eEtCbE8xQVV1cDEvOENuNXpHcFl1Wkgw?=
 =?utf-8?B?WDdwVTVSa0F4Wmc5UmRDQVVPemcxOVVsRnFZcEtNY2RXYjFGZ1RKTzlBbkZr?=
 =?utf-8?B?MStBNkJWaXh5Ump3bFhBbllrdmhDeFZvL2FLZ0d3Y1R3cCt0ZHhlLzZRM051?=
 =?utf-8?B?Z2dZUkVHRk1yMDNXTklvS3dDcnNHbGs5NG5SZ0Y4c0xsMVJXVTIyMTcyQTJ3?=
 =?utf-8?B?a2VFSWw4K284clovOHVPbEd5T0tXalJibmZWMHdmYmhGL3JpdmJENVBlME1H?=
 =?utf-8?B?S0w4aXhpWUFTMmRiOS9jM3NnenRSTkFPaDhCMzFaTDVyeGNDRElTZmxIOVVV?=
 =?utf-8?B?bGlYR0hyY0VGaGFuZ0hOQWZtY2tzQmRGNm9aVzZuRm82TkIyRng4QzNvWVJw?=
 =?utf-8?B?R0NzcGNqM0xndlFtSnZJdUlJTWN5M2RwemU2OXFEOXQ5TG1saEhhSlVFTUQ5?=
 =?utf-8?B?akx6OGRwSFhQWTc4US9hMlRJS3psWGFUR2VYczQvL2xoVDZIYkNTbXZJMWJE?=
 =?utf-8?B?aDNaMnVEMHMyVFZpbUVURXJtNkxwemQ4Q3R6bWY4a2liS0RMS2JvUzBzREs4?=
 =?utf-8?B?SmI2YU0zTGRYc2pKNjFmcWpMUVRTOUpqOGk5WHZSUHoyeFhNbFdVS3I3WVk5?=
 =?utf-8?B?MUtHUGM1VXZvQU9DTWJCTExCdUYvZ2tuN2NPekUvQnlpWnBnb0NJK2xsYTB2?=
 =?utf-8?Q?HHq8Dit+F8A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7872.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1VtS2Y1aWpoN25WSFkwSkRPMGdUZGhibGlraERYNFVPQU1RQ2ZoSmlxQzAy?=
 =?utf-8?B?Q3h6UFJSL3pDRmF0c1Bna1BIN3ppL1RVbHI3LzRHd1NrLzJDZ20wU2ROQ3RH?=
 =?utf-8?B?b2cyYlpsODZUSUdrQ3Rkcnh4RFAzSjFWbGVhTDJyWTRHUXk2WHRqeHE0L3Iz?=
 =?utf-8?B?ODF6Y1N5Z0ZDNUxzRTFFU2EvclJWMXZwR0lYZ3lOeHBwQXExbXl6ZWdxcHBW?=
 =?utf-8?B?SzFibkdJSlJIZE9oMmZhWUtKT1pGVmNNUWxxbFc3TTA5VXJoanNLTmxCY3k5?=
 =?utf-8?B?aFpVV2VKK2kvNkVEb3JaNDl1NFYzQXlzMGVCNzh5alZPdUwzNkYyRTVHUTlD?=
 =?utf-8?B?WlVYOGwvWFFJK1FhVjVnN25CZ3o3YkVOeHRXMTFBRUlxVFVISmRYRG83WjU0?=
 =?utf-8?B?SEVsbDNLSWxIQ2xSaEdYTHZtOFhjd09CYmk0UGs1dXpoa1hEY2FUUHBQT0o5?=
 =?utf-8?B?WDB3SEhoQWNzUzBBOUpIUldYMGFGd1BJcHlGcUFlb0FEZUoyamVvdUpBbW1n?=
 =?utf-8?B?eXJCUmYwd0IvVGtXeEQ5WDd2eUxwL3NyZ0g0dkRMWjZqVjgvNHZ5L1paTWRn?=
 =?utf-8?B?ZG1TNWZPbmd6bWFWdGlJcDVzai9NdXd4bEhCckRPS0xjR1F3Skp6SVVjeHBQ?=
 =?utf-8?B?STBsdS9VZHdmQ3FjdzVxZUU0UmtvZUxCbnZ5MitaYWdnWUM3ZXFVZHFhMnNY?=
 =?utf-8?B?Uy9FSlQ2R0Q3eEg5d1ZOVWRXTmdIWFhZTXlTcU5Oc21uZzhBQ3E1b0tMK0M1?=
 =?utf-8?B?ZmErdjlhaTFQMndtWkg1VHNmRHRTay9yRmhtTW9tTDJIQ3MwZXV0YUt4N01t?=
 =?utf-8?B?emQ1OExwRmVTNFphOGRGcEIzNEd2QVA0d3NwNWZzcmZIQWltV1VJandQUmNV?=
 =?utf-8?B?S1ZUQ2FRRC9iMFJ6a3MrTUZNYUxLTzU5NTA1U09oVDJVQjFNam5ueUpEUkRV?=
 =?utf-8?B?Wjhzb1c0Z1UxY0ovK1JEbzJHZkNvckNJci9pRjM3c0FzWXBtMUMzQ2ZtOC9o?=
 =?utf-8?B?d0pLUHVPK3FwbTduTXIyV05LZVBpT0JTcWlvRURwWVNTTEtickVNQjlxWlho?=
 =?utf-8?B?dWZydm1hU0M4THlORmxUN2hQRFNETDQ4ekZoamdRS3BwdEpyYVlyQXdZS2do?=
 =?utf-8?B?d3QvdE5FREhYZFJvcWhQSnovWDJQaEJtaDFGNjNkRjZMR3VpdXNIeGMzY1Yy?=
 =?utf-8?B?UFp2SWdiUDY0SGI3b1QvWmxMYTI1c1BCdTNobFhNY2VzUkN6bmI1QU55RmtH?=
 =?utf-8?B?VWMzN25lL3RkRXNDL1kxTjgxSjdRSEFZWSs1bHJaSjJGM1pac0hMM1lyOExH?=
 =?utf-8?B?eGdTMGYrYmU3d2hIRVBIZFl5VnZqSW80NEJMaGN2R2RCRGNLTE9OOUdZZ2VN?=
 =?utf-8?B?RUk0UWE4QTdSdWdnZC9Td3BQeGp6TVdwYVJnQ2h4cG1nMC9LUnpZeThseHRE?=
 =?utf-8?B?bXgyNFhJSzFiTmxaLzZReTdSa0lzVmc0ZkZrUE9jcG9IQmtBNVlPTnkxRVkv?=
 =?utf-8?B?Mk54VGl3UG1nNEhqRkk2Q0Q0U0ZDUGZjSXdTL1NCR3BTUkhpTUcxaVRPcldG?=
 =?utf-8?B?N0RBKzBSVm54a3lzeGpsY202YWUyL1RQc01qdEtQV0d4YkFiTC9MQy9IdXZU?=
 =?utf-8?B?QzlUb3NGc3M0UjdOdjBZc1FVcEl3QkJzNkl1d2txUE5GZ2xETG1yaFpyMFd1?=
 =?utf-8?B?REg5ckxBSklKSHV4WEJBSWMyNmlscTdkN21NWWw4YllrbzFpS1k2dnc4NlhB?=
 =?utf-8?B?S1g4SDd6WVpJZmJySzhCSTc4cWtOZzZKc3FSMFlZMmsreUxTeHI0MCtsTkoy?=
 =?utf-8?B?aWw1cGVzdmVod0dnL1R6Qzc5WHExS01MODh6T1dObVdrTy9NR0VpUHdSN0w4?=
 =?utf-8?B?Q1lodkxuVCtqNUE0UGZGMU42N3VtYWVHL0JQb3RsYi9wZXY4K0RRLzh5Q1Ni?=
 =?utf-8?B?TjZZSjlYZFF1TDIyTG5sbjB5aXF0K0lNaGZFYVdKTVZzRDhYL2ZFdllpYVZ0?=
 =?utf-8?B?ZWJDMkpFR0NXOHI4V2t3aG5vRlBTVUcrcFRKemdlRHJFSjlPYlI3NUxXaGdT?=
 =?utf-8?B?RFNXRklmRUZGWVNzVU1MSTFKYm9KRDlJVnZoVStvVCtoV2FXSGhLNlJvQmRo?=
 =?utf-8?B?ZitCbjQzdGxHVndYRVIwSDkxZjlBbFV4VTlyWjRuTlpXNVdsckdYbFBhckFF?=
 =?utf-8?B?VXh1OEx4Z1JNaUx1U2tZR1hwMS9aMzZqbkhHVjlOeHlhUXIraVowWkl0ellP?=
 =?utf-8?B?NVdmRWJRQktEVnhWRm1pVDY0dUt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7117B2978D7A91418BD692B797690392@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+5TPFq12u95YlBMAL5t1Yj37n0qNKRM2xuvtLWAuzyHJUXViaG2Rd3q/GxUUt0Z7TywhHrTyhIfZIAtqXe78XN3r7jjwlIlJ5SGqnUxvwjZ56eYSAPsZne88lQXWSH9oGmHFPxPfaQWwcfLg1uvyGzbVzX5eQO1nwjsJ5/R2RW671Hx6PUaJeA9dlNEeazq2OfevV9hNcNR4bpGK4FvQS7YT1H/zxn5m8umIIgIS1Jrk/o1pbXZs2AKS8Z1tAOJyzaxTNXC7t9Meg6sGsDAi1vvmCwqXbQRAj8XelVqyQYkS0IcYChHXOpa1Qi+FVUBraEgxWtrm2+FzGbdi1DFmt4zdNCzfQ6LajmMQNt02niNDat+/ruBT+S7DzQDoWs6kX/Rx+lmFJKcyETyumdvlfUiVZ5+vbv54CUlEDIfnxnYJz1qlTFNgC/NCyerRZyjPJfAITeVbVM8X9L/JUiyxAnYLQdKm6BTfEhTJLKke1L+F8qNBBkFgCJx6pd/XWdHj+ZvT2bJ9JSWpaw6BYS3SVXJlkVyrNiuB563JhDQH+WlDRhzdlmOXAlWWqlyTBU9ePhBdc4PWjW3M9DYyeYXw3K2QsbA+3NsnO03lXM2gCBdk6vhidzGS0UU0uqTVL0gt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7872.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a783970-c3c0-4d0a-d211-08dca08a87a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 02:46:42.1214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hODnfKMY9Av2QzZetLL/2uFUm7wfzkmNrDrAxzjUrCwRMCMIq9IMEbBQ2EC0QJzfQls8TBeHHPgyW94jxpvS3O9SKM8hnXdeEQBXuR+ZZDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7227

T24gU3VuLCAyMDI0LTA2LTMwIGF0IDIxOjM2ICswMjAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+
IFRoZSB1cGNvbWluZyBzdXBwb3J0IGZvciBQQ0kgZGV2aWNlIGF1dGhlbnRpY2F0aW9uIHdpdGgg
Q01BLVNQRE0NCj4gKFBDSWUgcjYuMSBzZWMgNi4zMSkgcmVxdWlyZXMgdmFsaWRhdGluZyB0aGUg
U3ViamVjdCBBbHRlcm5hdGl2ZSBOYW1lDQo+IGluIFguNTA5IGNlcnRpZmljYXRlcy4NCj4gDQo+
IEhpZ2gtbGV2ZWwgZnVuY3Rpb25zIGZvciBYLjUwOSBwYXJzaW5nIHN1Y2ggYXMga2V5X2NyZWF0
ZV9vcl91cGRhdGUoKQ0KPiB0aHJvdyBhd2F5IHRoZSBpbnRlcm5hbCwgbG93LWxldmVsIHN0cnVj
dCB4NTA5X2NlcnRpZmljYXRlIGFmdGVyDQo+IGV4dHJhY3RpbmcgdGhlIHN0cnVjdCBwdWJsaWNf
a2V5IGFuZCBwdWJsaWNfa2V5X3NpZ25hdHVyZSBmcm9tIGl0Lg0KPiBUaGUgU3ViamVjdCBBbHRl
cm5hdGl2ZSBOYW1lIGlzIHRodXMgaW5hY2Nlc3NpYmxlIHdoZW4gdXNpbmcgdGhvc2UNCj4gZnVu
Y3Rpb25zLg0KPiANCj4gQWZmb3JkIENNQS1TUERNIGFjY2VzcyB0byB0aGUgU3ViamVjdCBBbHRl
cm5hdGl2ZSBOYW1lIGJ5IG1ha2luZw0KPiBzdHJ1Y3QNCj4geDUwOV9jZXJ0aWZpY2F0ZSBwdWJs
aWMsIHRvZ2V0aGVyIHdpdGggdGhlIGZ1bmN0aW9ucyBmb3IgcGFyc2luZyBhbg0KPiBYLjUwOSBj
ZXJ0aWZpY2F0ZSBpbnRvIHN1Y2ggYSBzdHJ1Y3QgYW5kIGZyZWVpbmcgc3VjaCBhIHN0cnVjdC4N
Cj4gDQo+IFRoZSBwcml2YXRlIGhlYWRlciBmaWxlIHg1MDlfcGFyc2VyLmggcHJldmlvdXNseSBp
bmNsdWRlZA0KPiA8bGludXgvdGltZS5oPg0KPiBmb3IgdGhlIGRlZmluaXRpb24gb2YgdGltZTY0
X3QuwqAgVGhhdCBkZWZpbml0aW9uIHdhcyBzaW5jZSBtb3ZlZCB0bw0KPiA8bGludXgvdGltZTY0
Lmg+IGJ5IGNvbW1pdCAzNjFhM2JmMDA1ODIgKCJ0aW1lNjQ6IEFkZCB0aW1lNjQuaCBoZWFkZXIN
Cj4gYW5kIGRlZmluZSBzdHJ1Y3QgdGltZXNwZWM2NCIpLCBzbyBhZGp1c3QgdGhlICNpbmNsdWRl
IGRpcmVjdGl2ZSBhcw0KPiBwYXJ0DQo+IG9mIHRoZSBtb3ZlIHRvIHRoZSBuZXcgcHVibGljIGhl
YWRlciBmaWxlIDxrZXlzL3g1MDktcGFyc2VyLmg+Lg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFu
Z2UgaW50ZW5kZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMdWthcyBXdW5uZXIgPGx1a2FzQHd1
bm5lci5kZT4NCj4gUmV2aWV3ZWQtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50
ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogSWxwbyBKw6RydmluZW4gPGlscG8uamFydmluZW5AbGlu
dXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4u
Q2FtZXJvbkBodWF3ZWkuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxp
c3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGNyeXB0by9h
c3ltbWV0cmljX2tleXMveDUwOV9wYXJzZXIuaCB8IDQwICstLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiDCoGluY2x1ZGUva2V5cy94NTA5LXBhcnNlci5owqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA1Mw0K
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA1NCBp
bnNlcnRpb25zKCspLCAzOSBkZWxldGlvbnMoLSkNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgaW5j
bHVkZS9rZXlzL3g1MDktcGFyc2VyLmgNCj4gDQo+IGRpZmYgLS1naXQgYS9jcnlwdG8vYXN5bW1l
dHJpY19rZXlzL3g1MDlfcGFyc2VyLmgNCj4gYi9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL3g1MDlf
cGFyc2VyLmgNCj4gaW5kZXggMDY4OGMyMjI4MDZiLi4zOWYxNTIxYjc3M2QgMTAwNjQ0DQo+IC0t
LSBhL2NyeXB0by9hc3ltbWV0cmljX2tleXMveDUwOV9wYXJzZXIuaA0KPiArKysgYi9jcnlwdG8v
YXN5bW1ldHJpY19rZXlzL3g1MDlfcGFyc2VyLmgNCj4gQEAgLTUsNDkgKzUsMTEgQEANCj4gwqAg
KiBXcml0dGVuIGJ5IERhdmlkIEhvd2VsbHMgKGRob3dlbGxzQHJlZGhhdC5jb20pDQo+IMKgICov
DQo+IMKgDQo+IC0jaW5jbHVkZSA8bGludXgvY2xlYW51cC5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4
L3RpbWUuaD4NCj4gLSNpbmNsdWRlIDxjcnlwdG8vcHVibGljX2tleS5oPg0KPiAtI2luY2x1ZGUg
PGtleXMvYXN5bW1ldHJpYy10eXBlLmg+DQo+IC0NCj4gLXN0cnVjdCB4NTA5X2NlcnRpZmljYXRl
IHsNCj4gLQlzdHJ1Y3QgeDUwOV9jZXJ0aWZpY2F0ZSAqbmV4dDsNCj4gLQlzdHJ1Y3QgeDUwOV9j
ZXJ0aWZpY2F0ZSAqc2lnbmVyOwkvKiBDZXJ0aWZpY2F0ZSB0aGF0DQo+IHNpZ25lZCB0aGlzIG9u
ZSAqLw0KPiAtCXN0cnVjdCBwdWJsaWNfa2V5ICpwdWI7CQkJLyogUHVibGljDQo+IGtleSBkZXRh
aWxzICovDQo+IC0Jc3RydWN0IHB1YmxpY19rZXlfc2lnbmF0dXJlICpzaWc7CS8qIFNpZ25hdHVy
ZQ0KPiBwYXJhbWV0ZXJzICovDQo+IC0JY2hhcgkJKmlzc3VlcjsJCS8qIE5hbWUgb2YNCj4gY2Vy
dGlmaWNhdGUgaXNzdWVyICovDQo+IC0JY2hhcgkJKnN1YmplY3Q7CQkvKiBOYW1lIG9mDQo+IGNl
cnRpZmljYXRlIHN1YmplY3QgKi8NCj4gLQlzdHJ1Y3QgYXN5bW1ldHJpY19rZXlfaWQgKmlkOwkJ
LyogSXNzdWVyICsgU2VyaWFsDQo+IG51bWJlciAqLw0KPiAtCXN0cnVjdCBhc3ltbWV0cmljX2tl
eV9pZCAqc2tpZDsJCS8qIFN1YmplY3QgKw0KPiBzdWJqZWN0S2V5SWQgKG9wdGlvbmFsKSAqLw0K
PiAtCXRpbWU2NF90CXZhbGlkX2Zyb207DQo+IC0JdGltZTY0X3QJdmFsaWRfdG87DQo+IC0JY29u
c3Qgdm9pZAkqdGJzOwkJCS8qIFNpZ25lZCBkYXRhICovDQo+IC0JdW5zaWduZWQJdGJzX3NpemU7
CQkvKiBTaXplIG9mIHNpZ25lZA0KPiBkYXRhICovDQo+IC0JdW5zaWduZWQJcmF3X3NpZ19zaXpl
OwkJLyogU2l6ZSBvZiBzaWduYXR1cmUNCj4gKi8NCj4gLQljb25zdCB2b2lkCSpyYXdfc2lnOwkJ
LyogU2lnbmF0dXJlIGRhdGEgKi8NCj4gLQljb25zdCB2b2lkCSpyYXdfc2VyaWFsOwkJLyogUmF3
IHNlcmlhbCBudW1iZXINCj4gaW4gQVNOLjEgKi8NCj4gLQl1bnNpZ25lZAlyYXdfc2VyaWFsX3Np
emU7DQo+IC0JdW5zaWduZWQJcmF3X2lzc3Vlcl9zaXplOw0KPiAtCWNvbnN0IHZvaWQJKnJhd19p
c3N1ZXI7CQkvKiBSYXcgaXNzdWVyIG5hbWUNCj4gaW4gQVNOLjEgKi8NCj4gLQljb25zdCB2b2lk
CSpyYXdfc3ViamVjdDsJCS8qIFJhdyBzdWJqZWN0IG5hbWUNCj4gaW4gQVNOLjEgKi8NCj4gLQl1
bnNpZ25lZAlyYXdfc3ViamVjdF9zaXplOw0KPiAtCXVuc2lnbmVkCXJhd19za2lkX3NpemU7DQo+
IC0JY29uc3Qgdm9pZAkqcmF3X3NraWQ7CQkvKiBSYXcgc3ViamVjdEtleUlkDQo+IGluIEFTTi4x
ICovDQo+IC0JdW5zaWduZWQJaW5kZXg7DQo+IC0JYm9vbAkJc2VlbjsJCQkvKiBJbmZpbml0ZQ0K
PiByZWN1cnNpb24gcHJldmVudGlvbiAqLw0KPiAtCWJvb2wJCXZlcmlmaWVkOw0KPiAtCWJvb2wJ
CXNlbGZfc2lnbmVkOwkJLyogVCBpZiBzZWxmLXNpZ25lZA0KPiAoY2hlY2sgdW5zdXBwb3J0ZWRf
c2lnIHRvbykgKi8NCj4gLQlib29sCQl1bnN1cHBvcnRlZF9zaWc7CS8qIFQgaWYgc2lnbmF0dXJl
DQo+IHVzZXMgdW5zdXBwb3J0ZWQgY3J5cHRvICovDQo+IC0JYm9vbAkJYmxhY2tsaXN0ZWQ7DQo+
IC19Ow0KPiArI2luY2x1ZGUgPGtleXMveDUwOS1wYXJzZXIuaD4NCj4gwqANCj4gwqAvKg0KPiDC
oCAqIHg1MDlfY2VydF9wYXJzZXIuYw0KPiDCoCAqLw0KPiAtZXh0ZXJuIHZvaWQgeDUwOV9mcmVl
X2NlcnRpZmljYXRlKHN0cnVjdCB4NTA5X2NlcnRpZmljYXRlICpjZXJ0KTsNCj4gLURFRklORV9G
UkVFKHg1MDlfZnJlZV9jZXJ0aWZpY2F0ZSwgc3RydWN0IHg1MDlfY2VydGlmaWNhdGUgKiwNCj4g
LQnCoMKgwqAgaWYgKCFJU19FUlIoX1QpKSB4NTA5X2ZyZWVfY2VydGlmaWNhdGUoX1QpKQ0KPiAt
ZXh0ZXJuIHN0cnVjdCB4NTA5X2NlcnRpZmljYXRlICp4NTA5X2NlcnRfcGFyc2UoY29uc3Qgdm9p
ZCAqZGF0YSwNCj4gc2l6ZV90IGRhdGFsZW4pOw0KPiDCoGV4dGVybiBpbnQgeDUwOV9kZWNvZGVf
dGltZSh0aW1lNjRfdCAqX3QswqAgc2l6ZV90IGhkcmxlbiwNCj4gwqAJCQnCoMKgwqAgdW5zaWdu
ZWQgY2hhciB0YWcsDQo+IMKgCQkJwqDCoMKgIGNvbnN0IHVuc2lnbmVkIGNoYXIgKnZhbHVlLCBz
aXplX3QNCj4gdmxlbik7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2tleXMveDUwOS1wYXJzZXIu
aCBiL2luY2x1ZGUva2V5cy94NTA5LXBhcnNlci5oDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
IGluZGV4IDAwMDAwMDAwMDAwMC4uMzc0MzZhNWM3NTI2DQo+IC0tLSAvZGV2L251bGwNCj4gKysr
IGIvaW5jbHVkZS9rZXlzL3g1MDktcGFyc2VyLmgNCj4gQEAgLTAsMCArMSw1MyBAQA0KPiArLyog
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIgKi8NCj4gKy8qIFguNTA5
IGNlcnRpZmljYXRlIHBhcnNlcg0KPiArICoNCj4gKyAqIENvcHlyaWdodCAoQykgMjAxMiBSZWQg
SGF0LCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuDQo+ICsgKiBXcml0dGVuIGJ5IERhdmlkIEhv
d2VsbHMgKGRob3dlbGxzQHJlZGhhdC5jb20pDQo+ICsgKi8NCj4gKw0KPiArI2lmbmRlZiBfS0VZ
U19YNTA5X1BBUlNFUl9IDQo+ICsjZGVmaW5lIF9LRVlTX1g1MDlfUEFSU0VSX0gNCj4gKw0KPiAr
I2luY2x1ZGUgPGNyeXB0by9wdWJsaWNfa2V5Lmg+DQo+ICsjaW5jbHVkZSA8a2V5cy9hc3ltbWV0
cmljLXR5cGUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9jbGVhbnVwLmg+DQo+ICsjaW5jbHVkZSA8
bGludXgvdGltZTY0Lmg+DQo+ICsNCj4gK3N0cnVjdCB4NTA5X2NlcnRpZmljYXRlIHsNCj4gKwlz
dHJ1Y3QgeDUwOV9jZXJ0aWZpY2F0ZSAqbmV4dDsNCj4gKwlzdHJ1Y3QgeDUwOV9jZXJ0aWZpY2F0
ZSAqc2lnbmVyOwkvKiBDZXJ0aWZpY2F0ZSB0aGF0DQo+IHNpZ25lZCB0aGlzIG9uZSAqLw0KPiAr
CXN0cnVjdCBwdWJsaWNfa2V5ICpwdWI7CQkJLyogUHVibGljDQo+IGtleSBkZXRhaWxzICovDQo+
ICsJc3RydWN0IHB1YmxpY19rZXlfc2lnbmF0dXJlICpzaWc7CS8qIFNpZ25hdHVyZQ0KPiBwYXJh
bWV0ZXJzICovDQo+ICsJY2hhcgkJKmlzc3VlcjsJCS8qIE5hbWUgb2YNCj4gY2VydGlmaWNhdGUg
aXNzdWVyICovDQo+ICsJY2hhcgkJKnN1YmplY3Q7CQkvKiBOYW1lIG9mDQo+IGNlcnRpZmljYXRl
IHN1YmplY3QgKi8NCj4gKwlzdHJ1Y3QgYXN5bW1ldHJpY19rZXlfaWQgKmlkOwkJLyogSXNzdWVy
ICsgU2VyaWFsDQo+IG51bWJlciAqLw0KPiArCXN0cnVjdCBhc3ltbWV0cmljX2tleV9pZCAqc2tp
ZDsJCS8qIFN1YmplY3QgKw0KPiBzdWJqZWN0S2V5SWQgKG9wdGlvbmFsKSAqLw0KPiArCXRpbWU2
NF90CXZhbGlkX2Zyb207DQo+ICsJdGltZTY0X3QJdmFsaWRfdG87DQo+ICsJY29uc3Qgdm9pZAkq
dGJzOwkJCS8qIFNpZ25lZCBkYXRhICovDQo+ICsJdW5zaWduZWQJdGJzX3NpemU7CQkvKiBTaXpl
IG9mIHNpZ25lZA0KPiBkYXRhICovDQo+ICsJdW5zaWduZWQJcmF3X3NpZ19zaXplOwkJLyogU2l6
ZSBvZiBzaWduYXR1cmUNCj4gKi8NCj4gKwljb25zdCB2b2lkCSpyYXdfc2lnOwkJLyogU2lnbmF0
dXJlIGRhdGEgKi8NCj4gKwljb25zdCB2b2lkCSpyYXdfc2VyaWFsOwkJLyogUmF3IHNlcmlhbCBu
dW1iZXINCj4gaW4gQVNOLjEgKi8NCj4gKwl1bnNpZ25lZAlyYXdfc2VyaWFsX3NpemU7DQo+ICsJ
dW5zaWduZWQJcmF3X2lzc3Vlcl9zaXplOw0KPiArCWNvbnN0IHZvaWQJKnJhd19pc3N1ZXI7CQkv
KiBSYXcgaXNzdWVyIG5hbWUNCj4gaW4gQVNOLjEgKi8NCj4gKwljb25zdCB2b2lkCSpyYXdfc3Vi
amVjdDsJCS8qIFJhdyBzdWJqZWN0IG5hbWUNCj4gaW4gQVNOLjEgKi8NCj4gKwl1bnNpZ25lZAly
YXdfc3ViamVjdF9zaXplOw0KPiArCXVuc2lnbmVkCXJhd19za2lkX3NpemU7DQo+ICsJY29uc3Qg
dm9pZAkqcmF3X3NraWQ7CQkvKiBSYXcgc3ViamVjdEtleUlkDQo+IGluIEFTTi4xICovDQo+ICsJ
dW5zaWduZWQJaW5kZXg7DQo+ICsJYm9vbAkJc2VlbjsJCQkvKiBJbmZpbml0ZQ0KPiByZWN1cnNp
b24gcHJldmVudGlvbiAqLw0KPiArCWJvb2wJCXZlcmlmaWVkOw0KPiArCWJvb2wJCXNlbGZfc2ln
bmVkOwkJLyogVCBpZiBzZWxmLXNpZ25lZA0KPiAoY2hlY2sgdW5zdXBwb3J0ZWRfc2lnIHRvbykg
Ki8NCj4gKwlib29sCQl1bnN1cHBvcnRlZF9zaWc7CS8qIFQgaWYgc2lnbmF0dXJlDQo+IHVzZXMg
dW5zdXBwb3J0ZWQgY3J5cHRvICovDQo+ICsJYm9vbAkJYmxhY2tsaXN0ZWQ7DQo+ICt9Ow0KPiAr
DQo+ICtzdHJ1Y3QgeDUwOV9jZXJ0aWZpY2F0ZSAqeDUwOV9jZXJ0X3BhcnNlKGNvbnN0IHZvaWQg
KmRhdGEsIHNpemVfdA0KPiBkYXRhbGVuKTsNCj4gK3ZvaWQgeDUwOV9mcmVlX2NlcnRpZmljYXRl
KHN0cnVjdCB4NTA5X2NlcnRpZmljYXRlICpjZXJ0KTsNCj4gKw0KPiArREVGSU5FX0ZSRUUoeDUw
OV9mcmVlX2NlcnRpZmljYXRlLCBzdHJ1Y3QgeDUwOV9jZXJ0aWZpY2F0ZSAqLA0KPiArCcKgwqDC
oCBpZiAoIUlTX0VSUihfVCkpIHg1MDlfZnJlZV9jZXJ0aWZpY2F0ZShfVCkpDQo+ICsNCj4gKyNl
bmRpZiAvKiBfS0VZU19YNTA5X1BBUlNFUl9IICovDQoNCg==


Return-Path: <linux-pci+bounces-29623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E90AD7E74
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 00:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C033A5F90
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 22:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3BA230D1E;
	Thu, 12 Jun 2025 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hdLyCEf+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="h715PKou"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232EE537F8
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767785; cv=fail; b=fg2YRL1vrJrPNLi296f1B2M/Fv/dLkOaxQLT5mAt9Ish8D+hSQzAtvhUcJp3t8LzXwSjRTedZvBJKXkZp2cxLs0jh2VlDFcnENf1L7tk2+wnUS91wN9GiyQtbZq8oec6w9M7s1phJPvZOkAjBA1NJJC7EClGeTsh434DW3VHkJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767785; c=relaxed/simple;
	bh=1dBfdBPMgDqQzm2aPpxq+tee6NpNt1y4uFj1ohSjCZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HXWxfNHh2cnpQUI8ZM9fgpDHE9hj3RVRTy25t+kqpeg8KWyNlJyAbwNE8+srdDXTA164NNdO8FuaOdmb7R3mBAYODC5B2MvR44t3c4lOjIAOuPjPRn2PfHzP/pIQNXX5fku/WzS6Oezt5Pcq4tDyiS87lWIKFJ4QsN8YVNAXYaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hdLyCEf+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=h715PKou; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749767785; x=1781303785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1dBfdBPMgDqQzm2aPpxq+tee6NpNt1y4uFj1ohSjCZM=;
  b=hdLyCEf+0G3VJr2C6I4rkd934lfkXPUTgLwjlWFkgNIviILRRmAgG8Jo
   mjNKg4P0MgOut9Np3WSkWKuETXT2BP2LRoIQOxLy9E4GcUArY4XOnJsTT
   yFad4t24X8tEuOBxmZpG6Oq4aXzaQvzuuI8F9fb90MKRE3CSBXwSibuts
   3vub70g5TU/sQlUZPPrGzy0SHN2CQkvKXCHIvJiFWkwBZo+3G2O4SZjZj
   12cn7XhUUaqWw/nXqGRmx9qWpkki2I/Lyb/ieBE8x2bnA9UcAcL7NEH3p
   vVEAiryzMrlB5Zm16t+sw9vhTMoJ5onmutXcUU5FA1fx+Q5R+Sf7lZLvH
   g==;
X-CSE-ConnectionGUID: 3Rr3NQ7NRqeHxNOd49UaIw==
X-CSE-MsgGUID: AUuu5z+fTIGkt0Mt2ZEKCA==
X-IronPort-AV: E=Sophos;i="6.16,231,1744041600"; 
   d="scan'208";a="85223139"
Received: from mail-mw2nam10on2087.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.87])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2025 06:36:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRyCrKlQDPDBEc8iOp0yo7h5pfjIDzucJTg3XVF3GOPPmlFTY0yYdp0m9s7sZx0fyIhxCvJDprlwXzpNW8EIPkEv8XQ6bNIdAHP772iJTEP9U+en3cgdLgq0Y+/A+PP+sOJf4+DSAwRO4mWvzI36QvNn2dXtOeHrINbaPqkSH9ZmEYMdN207eOJsZEBRApym4CyYwYX3Q6FhBBoDH6VXY78Xoo19Hw4yIvMbgapCVrivcI7x5bcx+uxrbTV2grLnjvEoR2JWu6y8Mh81wWl4rvWM7zCn/oLQJAjptKOhcLkPXJ0eTNLv5SNZ9XtXiBIuccWn2y8SO373qFbFacx9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dBfdBPMgDqQzm2aPpxq+tee6NpNt1y4uFj1ohSjCZM=;
 b=YyxmkHYS8XS6kjFf8ra9aiNALqWOI8wy6Hfg9uC6NRYVDXe3s533mblJf972FMXjET2wkURsYvUNAYB5YosvaTz5J/NtAeLrdRuUgAvW4rBTauWxxNKnsJD4xrg042phdm0sD+A8UrRb+zCuIMDzKYZTlpvMoUVqNA+aAyVLyNnD15Nmzt73hWStfXHKa57nx/tfko7dMRis28ufh7Kr12+ekycnbnorQlDjSpsy80+0p2ic6NQER1JbuGNu9kAaTI6CF1snT2zWFENeB9rItHzugV7jKrOONbZlKK6l3ad7ClC52m9KioGMJPeX87DugDW6SLS1iuOddp+WCvSYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dBfdBPMgDqQzm2aPpxq+tee6NpNt1y4uFj1ohSjCZM=;
 b=h715PKouGSjC//RW4CAN8t+JNyda0//AfT7GJly6OYI+hp7Z6aItvY1iZbtP/wQMASLlGolBCeXZL9qh16ODTcXCnNFAocCAuIqjA8ghbgmqrNnhqABL7e4P56blL4OpGc+Ft1gRMjdobZ4HvCkmXPatnYMMPF0SsuYEyFOO1nQ=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 22:36:21 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 22:36:21 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "mani@kernel.org"
	<mani@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"laszlo.fiat@proton.me" <laszlo.fiat@proton.me>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>
Subject: Re: [PATCH v2 3/5] PCI: dwc: Ensure that dw_pcie_wait_for_link()
 waits 100 ms after link up
Thread-Topic: [PATCH v2 3/5] PCI: dwc: Ensure that dw_pcie_wait_for_link()
 waits 100 ms after link up
Thread-Index: AQHb25AivkRMBEqUkk+1iLqD5zVYtbQAHbUA
Date: Thu, 12 Jun 2025 22:36:21 +0000
Message-ID: <86a07522e2a409b19733ee309cb870ba28709117.camel@wdc.com>
References: <20250612114923.2074895-7-cassel@kernel.org>
	 <20250612114923.2074895-10-cassel@kernel.org>
In-Reply-To: <20250612114923.2074895-10-cassel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|BY5PR04MB6327:EE_
x-ms-office365-filtering-correlation-id: d8e2d040-accc-46b0-d788-08ddaa018e2e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWxhQndwM3o5U0Ywb25wRFRNYlFoUCtMdVBhaGNhV0hsWUlsSTVsYTJ5VU5i?=
 =?utf-8?B?NzNKakJEMXFYblRSU1NNTU45dkNQS1VhQ3dIZEJSTHZZbmhwN1FmdUM2TGdy?=
 =?utf-8?B?OHkxNzhZU2N3dlZtTVoyc1hiSExGQmhQR2pNQ29NMnpmTDhuYXBZeVEwVWpV?=
 =?utf-8?B?ZEdLS1B1V2xPaHpybUwvZzlIZklJUnRMYXFmM1hRWWpDSmQwMVVPajRkYXZl?=
 =?utf-8?B?dWpaTWhCOHREMUkyOEJoc0JiNEFRSHlQTnZFQ2VQUG1hNjFUK0FlWmxURWEr?=
 =?utf-8?B?bWlJbjVYVkdnSUhDMjNKc1VJNjF2czJITklESGxrbEpack9BRWdBUzExanY0?=
 =?utf-8?B?NDJXS1pMZFhBRTVKRkxLaFI4aDl5dUZ3eFNnTVlYMTNkcDZMNldQMnpzdWh0?=
 =?utf-8?B?a0h1ckNKc1lCL2xvTC9seUpoM05aVjJpUjkwQjZvaVE1WXQ5emVma01MdmVW?=
 =?utf-8?B?dmk3ZXNKOFkrcWJnREpNbXFkbUlrYzFkVUtGS0NYZVhydFdsQlRUR0h4Q1or?=
 =?utf-8?B?OTFwNjZ3TXV3VngvN3E0cWxuSHU0aUlBWlNkZCsyMVpROGJhNVNBMldwQkU3?=
 =?utf-8?B?MmI5eUNUQS9Kd3I2MFpoT1lhVnRIUzBya1RVZUF2elN3U3Z4a2gyLzQ1VHFn?=
 =?utf-8?B?STM1YlVLY0tBRmZBSGg0M3JhS0l1THptTldsb3VzS2RMOCtIL0J1NDZFdlNC?=
 =?utf-8?B?SUhwMytYak83Q2JwY2FnMGFkK08wUk1LNlFOZUNTQ2l6aHRuem1JSFltUVRG?=
 =?utf-8?B?ZFJwYllqQlBsaXVBN2pMa1V2YVBIUHRuOUVEN0ZVbUVRenU0WmU2dUMwR0Vt?=
 =?utf-8?B?RmRhdGxVdVRlb0dITWVwMjFVWjBRQ094WnRCMmJvS2daamMrVWQxYnpobmtI?=
 =?utf-8?B?QnMzaUlqbGQzTGJYOG1zTkNmQi92RllhKzlzeTZMM1k2cHk2V0t0R1BMM1FG?=
 =?utf-8?B?SXJGTFZITEhIR0ZzWFlYU09HS1BBMHBKRENOY2VVRE8wK2hRZXFwa3IwNEwz?=
 =?utf-8?B?QTM2K0p4a0NmU2JKTURvYWd6YkR3dmlhejdxd0d1WlU0a3RlR21KZmprSkFi?=
 =?utf-8?B?LzNEQWE2T1VRYjg4WDh0TGNCZllyaGRFOG9FVS92MjgzSHcvdnk5VXdVSi9h?=
 =?utf-8?B?bExHRTVyblZONTVKdGV6MldpcU9vWW03OHJFOVljc0EwVS8zUGdSSkRnQWZ1?=
 =?utf-8?B?bzlnTWRWRDdrMk9WZmRUWTVkVmltbmViWnhjR0QyMTlaU0NTM3J4SlJ0TitP?=
 =?utf-8?B?bnFYQnNUM0VxVUp1SnRlSlExQ21kV1NKQ0lYRnNOTjVoQTIwMjNHTU41R3l5?=
 =?utf-8?B?TGcwd0ZSNUpUL1IvUFE0RzBGZm1xZW1OekRWMDVRZCtrNHdIVU50MWhRVGdE?=
 =?utf-8?B?S1lxVkNUdjZudzV6aVZSaFIxUDZ3TW01OU9FWFZqdWNOQlZqNk80Z1FDSGFL?=
 =?utf-8?B?WWQwS0xjMDhWaHZoQzQzNnRRZFduQ2ZabTkzSm5XK284QzFkVCsyZmd6TGVG?=
 =?utf-8?B?QTNkazI1RkUyd2pudC95RmMvWjBNNDhyTHgveDk4ZzlONWJaSzFiTldSMXJ6?=
 =?utf-8?B?UU9vaU5LOHREU003UFNGbkZKK1VxbE5xaTlyYklaWmFWdjM4aXZvNW9ZbExh?=
 =?utf-8?B?NkhIZGw1Y21KMlFYd2ZkUlQ4NzVEbGltaDNTZ0NJS3hyNTl4dVhEOEE1TlRT?=
 =?utf-8?B?ditUaENOT0h2Q25kdU0zSmNyUnNXaW5jenRSbXBqYWwwVmdUSDdnelROU25r?=
 =?utf-8?B?aHF4U2Z3ZGQzblhSdGxCa2FoNklRNVdQYUVzSHRaaUU3ZHNxOUlMeG1LR1Jr?=
 =?utf-8?B?WWdsR2w2RjgzSzNNZHFTS25KWElPRXdxeW5OckVXa25Pbk4vRUdWa3RlQjZF?=
 =?utf-8?B?TnVFZHRKOUdrN0VWbTVNK0N6dkRhb1BqcC9pRWxVazg2TVZUUWdrcVF2eDUw?=
 =?utf-8?B?dTRQekFIZ29PQlpsSjBMWVhzWC9uTDdCVlRiSGx1NE56b0RQMU96RzFCcDBV?=
 =?utf-8?Q?Ty5usOSez8c1ERUtmAE/7YKNA7ha9A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUhoMExUVmg1dmRHYUZydXJ3eDJFbjNBbnRnVWxmWFl5bnlVRUFGalVDWjJU?=
 =?utf-8?B?cCtMbUZIZFNIUE4yRmFNaEJvSWxmTjdmSEJJa3Q5cUFhT2dtTWMyazVHcDZ3?=
 =?utf-8?B?RXNuLzJ2Znp0MnN2WnQwZ2VhTDFBajU3M1p4aUt0bnVuMkpIRTBlZEp6eUVO?=
 =?utf-8?B?SmVIekFLZkRySnZ5eTBERjg2ZU9wbWVKQ3FkSHBoYW05NmJOYjZPQnZmLy93?=
 =?utf-8?B?aE12YWErRTFqYkhGdWh2TE8xdE1qS3RPb1NXRnZVdTRCZERHNzJOclV0REEz?=
 =?utf-8?B?Ukx4dEZsb1h0dHZ5bUlvbnZkVkRlZkZCSHZZWVk1NVlGUXFNcHp2WU5PRW1t?=
 =?utf-8?B?UDAwWHoza2k2eURvVDREcGl3SUg5cmRsT1B5TFdRZW1jMmdtZENvYTdmbWcz?=
 =?utf-8?B?UzdjYUw2aXFkRm02dmY2a0FGSWo4YktJL2pqdXZsTmMwaXNvdk1oT2RJaGIv?=
 =?utf-8?B?YS9QcG0ya05OakJTUW16bnhMeWNiUXRwSWZsbVpYUUpuUGxQZjlQUlhOZkZZ?=
 =?utf-8?B?MWFBRjRCekNFRENoQXZyeUoxTnBMYThvczFtMUJVSnBsOGpEaks5VEdwSUkz?=
 =?utf-8?B?Z1B2MHpPNEVJUE9DemVwUG5HVmUycEwyOGRVL1FJdFlvK0JXNUdOVFlnTEFw?=
 =?utf-8?B?MEhlRTlSZUJQVE5pUXFSVk9wTFcwVUFucWJBL1o0RzNCbjA3eXFBcVBmK1V1?=
 =?utf-8?B?VHZjeitQQ2xScnFHV1NVSnZOb1ovRkNxMXg2Yi9YeGtkR1JxOUNqOVBKUEh2?=
 =?utf-8?B?UmpMbTlESmYvekVqT0FsdXVPS1BkYVZqSGhaVzQ3WTZuVjgxeFNKc1lkY1Ax?=
 =?utf-8?B?bURRVFFnVkxBdy9MYXlNK1pFa1YraG5NczVtMGFDQ1pIY0Z6WW1QbzBYcVdu?=
 =?utf-8?B?VFViVURnazUrakIzZ3NkMHVBY1Z0dmYyTlFnTHRESklyZ0IxMytwa3J6bnlO?=
 =?utf-8?B?Y1hzS2ljQnhuSEVMaStzcGNDZE9zNzhBL2plY0RKLzRnTnd2K2VrM3QrWDhy?=
 =?utf-8?B?ZWoyMk5nS1VSNWMzNldXd0Zpc29FalhBMFhXMlBib1BkVmtQU0lMUFB3SzNN?=
 =?utf-8?B?Tmdqd05seFJScTlpc0pqbjZrYmFXZTJBd1FHZDlQUXIrRXFZQ0o3bFpyNnRJ?=
 =?utf-8?B?dmp4VGhxd1JFUEl1ZDRqeU1jZTI2Z0VaZHRCYUtyVmRmaFpIUXVEUlBkUm5L?=
 =?utf-8?B?UjNIQWsrcXJ1bjVTbXBHY3l0cDVyY0orRC9JUUkwTy9vdzB5T0YvMUF2SlBw?=
 =?utf-8?B?QzgxUjN6UTZubTM5MWJaVWY0ZkV6VWc4V09wRm1Uc0FvVTRrdVY0ZEpkVVhU?=
 =?utf-8?B?aHpVY3pzVGNHSjJpLzc4cDR4b2ozb3g0VXVkMHFRTnQzVEptYlZsQTJ0Mzl3?=
 =?utf-8?B?MGg4cVBmZDZoWW5zSHpIRTZiN3VaajJuRmM0STQ0eWlsQ1NGR2V1aW1KYTRy?=
 =?utf-8?B?MmZKbXhJZ1FFZmd5N3pNZnVvUnA5MzNtWDI0c3hxdkgxOWRWZmJWNCtSdlBF?=
 =?utf-8?B?WFdxeW56MWpYL3NQZDhsYjJPcTQ3eGtNdHhCbHMrT05VWHBpSDBLL3k0TjZH?=
 =?utf-8?B?TjFjM0lOdm50VG5MQnpGUnZMaEVldTNZaWpjZWJ1ZnpuOExxbnBDNW5jZGRV?=
 =?utf-8?B?WVp2dHlBVnlTWjlaRHRia2c1dEtScVU4Y2hYSUxqUHBUZGVveU9ZbkNtVHFw?=
 =?utf-8?B?bitBUGkxdmw0akNneVFIeUhMQVppTHJZQXlacnJyTnZHZjBuZ1hSdkFDWjY1?=
 =?utf-8?B?eTU4UkZ2UFR3RGZWQ3R6VVk0WGlzUnUxTS9OOUdaQWVPa2VNT2puUFk5QkxU?=
 =?utf-8?B?S2FxRHNERTh6dE51TmhiUjlNNGd5YjRuWmdETUtPYVY1TW5ueEwzTEpGV2o4?=
 =?utf-8?B?cGdhZzdheVE3dTJBeDFJSkhJcmVFWTc4aTZtYmw3RS9KSnZ2dTd4Y1pLZEx4?=
 =?utf-8?B?UWxubHRZS28waDBTQk5NVzNFdHpQcWpRNklrenJqblNtYlNxM25vRURCZGRt?=
 =?utf-8?B?aThoZWNFcUtQR2dJRk9sc0ZwT29QeUpuZWVKdE1McHp1bGxZTXZCWmFhdzBj?=
 =?utf-8?B?MWg1dE9MZGNPbmlwOG8vMGQ1eEJIZ010UENuTldUc29BQVNBdzd0dnlPQkUv?=
 =?utf-8?B?ZGFRdnpiOXAvRGthZnBDdUwxeTBsSEpINTRqeDJCdFRaaHZ2VzBuV2drQzhB?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD9BDD2A055C9F4D84FF7402AD9DFF53@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	knvhI2agiIMuWZ/93V04bzTqL7MUIZsHTvMu9r73Dx/lYOvDYURemefTeGfpkKR+hKPJeW3jcyZsgbDAIE3Ka6JHpzwpBvAavkwYlhBpmHeey4Im2Shz3phDSz5ocPcURnsLVxGWjZMVD6iBVF5ROchCymYzscJJjpqZmVOfcybWzmnkNVb+5ZUrlnSrrgOZZRcuX66pJzvCuvukVIkHuqz6q6Gub6MYViKmKYVJT6SIGX6l1YMQEWtVZOrAsgu0p9F+1llzoi0UK1ASF/a2JGhlAMUSqRnPOaSxItOMjkyxX48RbZOyUhSNgnlVH/EzdAc/K7eRnd85/I/k9nGHQy2mMUYzZdfoWDJMLQefiWFb87mUtaYcX44XiFkg5hn3+0P5X3Iwb2pSwLbg5lwxD45wh5PuKvB/d/BiRCsZ4hwWejwbsoVq//oetiO8QB/qEHEXHJU8f2VEw7NCntPYYITZDdD4Mm7BShsvTMyaVdBbjfyWnXu3unTaIkoGO8K1oz1wqXVjkD9g8WpSbzHKdj7G/kJLLF7yKdt9fqhvFzYHBI4t9bAvaa/WuIZeBd4ewV9Gc4EpqBB8KAs8temofA5qs7BxlgJfKMuFSs66TetnGxFXQEgGGS7oTTvMcDjN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e2d040-accc-46b0-d788-08ddaa018e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 22:36:21.3257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDw/uE7wIwOkAlOJcJ8XzxzE5AK5d+fzj3DVCLJt1n09y5AlfwRF4urvIfCI9TvgOjzAs/XqTMokMLZn3b0oPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6327

T24gVGh1LCAyMDI1LTA2LTEyIGF0IDEzOjQ5ICswMjAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0K
PiBBcyBwZXIgUENJZSByNi4wLCBzZWMgNi42LjEsIGEgRG93bnN0cmVhbSBQb3J0IHRoYXQgc3Vw
cG9ydHMgTGluaw0KPiBzcGVlZHMNCj4gZ3JlYXRlciB0aGFuIDUuMCBHVC9zLCBzb2Z0d2FyZSBt
dXN0IHdhaXQgYSBtaW5pbXVtIG9mIDEwMCBtcyBhZnRlcg0KPiBMaW5rDQo+IHRyYWluaW5nIGNv
bXBsZXRlcyBiZWZvcmUgc2VuZGluZyBhIENvbmZpZ3VyYXRpb24gUmVxdWVzdC4NCj4gDQo+IEFk
ZCB0aGlzIGRlbGF5IGluIGR3X3BjaWVfd2FpdF9mb3JfbGluaygpLCBhZnRlciB0aGUgbGluayBp
cyByZXBvcnRlZA0KPiBhcw0KPiB1cC4gVGhlIGRlbGF5IHdpbGwgb25seSBiZSBwZXJmb3JtZWQg
aW4gdGhlIHN1Y2Nlc3MgY2FzZSB3aGVyZSB0aGUNCj4gbGluaw0KPiBjYW1lIHVwLg0KPiANCj4g
RFdDIGdsdWUgZHJpdmVycyB0aGF0IGhhdmUgYSBsaW5rIHVwIElSUSAoZHJpdmVycyB0aGF0IHNl
dA0KPiB1c2VfbGlua3VwX2lycSA9IHRydWUpIGRvIG5vdCBjYWxsIGR3X3BjaWVfd2FpdF9mb3Jf
bGluaygpLCBpbnN0ZWFkDQo+IHRoZXkNCj4gcGVyZm9ybSB0aGlzIGRlbGF5IGluIHRoZWlyIHRo
cmVhZGVkIGxpbmsgdXAgSVJRIGhhbmRsZXIuDQo+IA0KPiBSZXZpZXdlZC1ieTogRGFtaWVuIExl
IE1vYWwgPGRsZW1vYWxAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogTmlrbGFzIENhc3Nl
bCA8Y2Fzc2VsQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS5jIHwgNyArKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLmMNCj4gaW5kZXggNGQ3OTQ5NjRmYTBmLi43ZmQzZTkyNmM0OGQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+
ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+IEBA
IC03MTQsNiArNzE0LDEzIEBAIGludCBkd19wY2llX3dhaXRfZm9yX2xpbmsoc3RydWN0IGR3X3Bj
aWUgKnBjaSkNCj4gwqAJCXJldHVybiAtRVRJTUVET1VUOw0KPiDCoAl9DQo+IMKgDQo+ICsJLyoN
Cj4gKwkgKiBBcyBwZXIgUENJZSByNi4wLCBzZWMgNi42LjEsIGEgRG93bnN0cmVhbSBQb3J0IHRo
YXQNCj4gc3VwcG9ydHMgTGluaw0KPiArCSAqIHNwZWVkcyBncmVhdGVyIHRoYW4gNS4wIEdUL3Ms
IHNvZnR3YXJlIG11c3Qgd2FpdCBhDQo+IG1pbmltdW0gb2YgMTAwIG1zDQo+ICsJICogYWZ0ZXIg
TGluayB0cmFpbmluZyBjb21wbGV0ZXMgYmVmb3JlIHNlbmRpbmcgYQ0KPiBDb25maWd1cmF0aW9u
IFJlcXVlc3QuDQo+ICsJICovDQo+ICsJbXNsZWVwKFBDSUVfUkVTRVRfQ09ORklHX0RFVklDRV9X
QUlUX01TKTsNCj4gKw0KPiDCoAlvZmZzZXQgPSBkd19wY2llX2ZpbmRfY2FwYWJpbGl0eShwY2ks
IFBDSV9DQVBfSURfRVhQKTsNCj4gwqAJdmFsID0gZHdfcGNpZV9yZWFkd19kYmkocGNpLCBvZmZz
ZXQgKyBQQ0lfRVhQX0xOS1NUQSk7DQo+IMKgDQpSZXZpZXdlZC1ieTogV2lsZnJlZCBNYWxsYXdh
IDx3aWxmcmVkLm1hbGxhd2FAd2RjLmNvbT4NCg==


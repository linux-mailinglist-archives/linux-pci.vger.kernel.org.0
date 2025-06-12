Return-Path: <linux-pci+bounces-29624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22426AD7E83
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 00:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4407A3A87
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 22:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4082DFA3A;
	Thu, 12 Jun 2025 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AMo++j8n";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WQsmQHwB"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8885C2DFA38
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767863; cv=fail; b=hjVBiK9OhX/k/Sdid5IGiR/VUCUf/gCywzkwgGBGP5StupHwodZ2Gi6RtuDnx2ttPGw+C7d7JPgYK+FXllKF+a0duLOK3hcKzqqT511Q4P3k9TJ+FOLRb/C+Z1DcqFYOJbbnWjPUo1X0JZE4Pu1K5gd1hmQ7+oY5VunEyYq4Mvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767863; c=relaxed/simple;
	bh=ckXbMv0AlQ0/xQ2eaGyL448RcAwdaG0WHP9NG8Yo3iA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8imN9zHGdz4UgIuX7LkyH0+N06JCQT46QPiuw3Tu4NO33DPbq9A8XhLoPQuHBXJDXyg+LPortOqL2boS98aOpyphWuGgF4a/HKUQvVGVLV57t3elfdC+NK2j76GvxMMEDXQzaOhLBGoXKbn9W0pDfp0gN+gCWHofLaxizfRQ8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AMo++j8n; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WQsmQHwB; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749767862; x=1781303862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ckXbMv0AlQ0/xQ2eaGyL448RcAwdaG0WHP9NG8Yo3iA=;
  b=AMo++j8n/61QlB8pObPYerAZ+RrwM6Fr1Y1SLNzSjbDeKWliVP1jkK8+
   st556SdMmpZ85jFy9R89iDTJS7ct4Ki32VlACyZrH/liGy2kDA78cak6G
   yV9x4V61NmUecSV9mqV4C3FVKpyiJGPOGjzeOj7s3VlOEcm5i7pUoAHyN
   ILeGEURvkrADfXSBnsKUtqPqqbZOHHGy2a3idL0Ez7SL+COvJ7j0o9sva
   +IdPJGfEmaHSlCL50vwfJ0r7R4x115l3D4mzKq6+929dosN1/grmErpN5
   mO52/DUrDIJkx8Wg5saxJkzMKAdJ7XNsWK2G9xNJkK8mq+jZYDNj3j7ez
   Q==;
X-CSE-ConnectionGUID: ktqbNl0fTBmTqLr3a9zujA==
X-CSE-MsgGUID: txjaXz9rR7CKgOL5rDnlVQ==
X-IronPort-AV: E=Sophos;i="6.16,231,1744041600"; 
   d="scan'208";a="85223195"
Received: from mail-mw2nam10on2056.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.56])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2025 06:37:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDERm2qviPLUroL7eAPRmcodfJJkkPSWUhbc7kIx1FEJe8kISU9Z7D2GbAIV7+uMWyu5w1v1y9aQs9rjjQEsb784/bHX9+MjJu2EcDjcyTJeLRiqh3CmkslqJlJyEzmtGtO2Y1qNBErwaY0XOswPpDucyAGaquBRmI2EKLNn30cpNpmQkRBuRdj8ylKDb5qyu21yvSaMSTyx8Bq9zHl62s/+B22S0bvuPE4AO+3KgRNB5/4xaKGcPbtCBpYG1231gu4harcUNfdgOVDFJvJTvfOukXhKYJou+9TetrtAOQPpAEdX/w0c1o6esTfxgGaqas5uV3NoWUvvbkif66yW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckXbMv0AlQ0/xQ2eaGyL448RcAwdaG0WHP9NG8Yo3iA=;
 b=DJ9oqXeL0j2M1PiaSxhVzRTPUBCmryLikeCPLEVOuG7r12DfQsEgv4TeRN9Tq5IWw4xBBpsg6QKrZ6UeOXYvZcMrrUuvkPpYU0IcbYk1oztsfG3S6t+zKq0Tqp+UOoidyTLsEs5qfMyoUGN9XwExenf4cwQ9mBA+1hUvqtKgl+87nBnXbK7Fp+nyeleZaV4YVkBwtsFhYlytMSYQaErSrM52mVlZRr7faTPY3enolakzeO/KWJwI3W0cagmkTwpkrsYX27L7sVp19uEH0Ia8HY7kbSYs40ZWh6u0MSJ5ahRjCgt4dfU9jPa4yUm3Qa/UTd4Lem0V6f6SGlmMI0cZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckXbMv0AlQ0/xQ2eaGyL448RcAwdaG0WHP9NG8Yo3iA=;
 b=WQsmQHwBASFR1vmnt+9G56CufKlpgj5JImAe2/nRE0vqzGkIKX1uVyvF3sEJ2wiaJhZIcgP7Hdq0VRZAINOdU4Dws1bxlJNSZKxjdklEPv3NovZZUOAush+z6oOeUaZNI3bOLRu6r9ijRxPQVblvTcdCzkUo20UzhCm7Pn/X+xo=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 22:37:38 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 22:37:38 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "mani@kernel.org"
	<mani@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"laszlo.fiat@proton.me" <laszlo.fiat@proton.me>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>
Subject: Re: [PATCH v2 4/5] PCI: dwc: Reduce LINK_WAIT_SLEEP_MS
Thread-Topic: [PATCH v2 4/5] PCI: dwc: Reduce LINK_WAIT_SLEEP_MS
Thread-Index: AQHb25AmyJDz1eaSLEiE5uTtCaQe0bQAHhIA
Date: Thu, 12 Jun 2025 22:37:38 +0000
Message-ID: <d1e5f32d7b5d0d60588deec046f7f116f89a6572.camel@wdc.com>
References: <20250612114923.2074895-7-cassel@kernel.org>
	 <20250612114923.2074895-11-cassel@kernel.org>
In-Reply-To: <20250612114923.2074895-11-cassel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|BY5PR04MB6327:EE_
x-ms-office365-filtering-correlation-id: 28ab9065-bb39-49d3-d111-08ddaa01bc48
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SXpCOTFUN3BKTG9rb0V2a2h0RSt4bXpYSFo1eWdJR2lmUnpkaXNHYmFUeEpU?=
 =?utf-8?B?NHdlSkhHUFhDRUZIWHkzdGlvaFRkTGc4NUNWdWJjM2tad2Q2b0dsY0J1UmZF?=
 =?utf-8?B?eDZVZjFFcUJBUG5rMXdjMDV4MzNlcHBhaUMzN0lDbElwVkFTTGZxVFhxTDRK?=
 =?utf-8?B?dk1KUDYzcFl6RnZIcTY4Rm42NFBkTTh5R1V2OVgweWg1MDBOdTU3U0d5STE5?=
 =?utf-8?B?U3ppNk9yK3MxSTNmejVXc2xHVTl3RGQ4U0dTakZXZGNXZlNqdkZmR1dCU2tm?=
 =?utf-8?B?N1dqSnZ5SGtYMGN1VVRXSXZOcmJlRllKRlllQ1pGN3hsV1czUXBiMzFiTGVk?=
 =?utf-8?B?VGYwdzZEVWRPU2dROGlNczZOM1NHZlZsSXo4YzA5TXkxMEpHSVpqT01nOHlH?=
 =?utf-8?B?SElzNHVoM1N5eU44c2FiRkNVTXdKczVHVVlTVVZwYTdWbFljVFM4S2xBYmcy?=
 =?utf-8?B?Tk81bFlLZ09ncFluYWVDWGJGV0diemJLVHRWWjJoTHN4QXdNV0lUYkp4WWc0?=
 =?utf-8?B?dzBVL3JCZkJueTJBRDFNdjlxNFNsNkRaMlBEemtLcjJVNmNXbkFSM1doTVBQ?=
 =?utf-8?B?aDhUSVR4MkJSSk9KQjF1a3VrMkdMOG50VGdVZmZxNGNTb2FWODBveHVZVG1M?=
 =?utf-8?B?dzRrdUVtdjd0SkNlODJsQjNXdENJd1JBSEoxZ1o3UEF1aEE4QWhqc2VWdzBV?=
 =?utf-8?B?TmdMckRZMkhvN0tjOTN6cG45WTV2bk9NWTZrRC9GUUFvZjFzZ09LaXhxZWRQ?=
 =?utf-8?B?R3dQYnVZZ3NvNlpkeGxsNzV6SXVLbytrMHMzUXdncjFlNC83VFZXRTd3NUIv?=
 =?utf-8?B?eFhUWFdUblFaZXY2VVVRSS9nMVJ0TWdzNDNiN0E1eE5Ea0xGUStkOCtGVnVV?=
 =?utf-8?B?aDJ5M1dqTHR1NEF5L3c4cFM4QVlYSFNadkJjTmxoam9LeUNBWGxJeWlQWmZK?=
 =?utf-8?B?ZlpISHVWakhpWnlPMlZaL3Vic3JEemRwV0lkbzJsRlIrUUkzM0xOWU1nUnVP?=
 =?utf-8?B?dGJlUlgrc3RWWEEzaVpHMDF3V0xlUnJKeHhUeDVPVm1xeGNyMnh1UmlXSFZH?=
 =?utf-8?B?RFFSQS8yUmtaL0NNc3R6bVo2UEtHNXBWM0NMazBVc09OUlpZcC96TS9PTW01?=
 =?utf-8?B?dFNzaTZBeVY3WDZHMnNLVm5qVkVLcWhJUGoyb2RQRGJxeld0blI1UE4rZTky?=
 =?utf-8?B?OU1jZW1TRHJRMCt5WFVsL0dxNkRWRCtEUlpMZHJNVHd6Q3NmbE9tUmdsenda?=
 =?utf-8?B?Z0FJTFdrSXYzRUFkWXNncFVxSU5iRThuL2ZlNkxuNisyREw0ZHBrTDY4SFRT?=
 =?utf-8?B?ZUlPb0xYSHM5b29sK0ZPcTh2b3B0N0c4S1ZiUlpTZlFGajMveHQrUlQ4cWNk?=
 =?utf-8?B?R09NeDRRTTJmcHJDMWdrWjNOZjUvNEpESFZiZkx4TGJiUUZwckpsQllueVhW?=
 =?utf-8?B?azRnSGNlc2huc2IyNGx4bSsvZXpIa2llcDlYV3BzV0F1TTAvVXdvNHYvNElo?=
 =?utf-8?B?dUxTY1V5a2p0Q2dJMTZQRFBCUG15QjYvY0pQT20wRUc0Mi9FcWVWYmQ1dTl5?=
 =?utf-8?B?eTY2TGM4T3NjdUNIdG83UDQxYlBPZjgxbUdCYWQ5aitjUS9paDdXNmtEUmZz?=
 =?utf-8?B?OXlQa0xoVGhDVEtySWc2YTFrcG1OWjJ1SXg0blBvY2NDalMyb3NaU243ODhw?=
 =?utf-8?B?eHIwRVNZOVE5blpESFY5VXgwNGRodDlZblladEdTaG1qaUVpSnFFWFlUUjYy?=
 =?utf-8?B?bUN3SW1PVWpsMUNmSWxCYjVqNFBZdXd2TmFxeWJydzMweXBXREFMRTdvc1Jh?=
 =?utf-8?B?K2tvaitYVFNGbWplWUlWZVBabytPc05yNGRWamRLaVpub1lKZjhNcUxUZjl3?=
 =?utf-8?B?Zi94WjdaSVdEazhkOEZac1ZkRmVVZVZvSmkwZm92NHZuSUhDeUt2V2laZ3FZ?=
 =?utf-8?B?UXBlbnErWktxWlQ3eWtWRkUrK0tJNENLVEhCcitJSDl1Ym9rbjQrRXBoQWY1?=
 =?utf-8?Q?sUU22KV8jVlvn11Ls8qVf1aOExY5OE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2Q1WEVyNFl2VS9kSVdjdklxZUtIVlM0OXRmblc5dk03VkJNWThDdWQ0cmVU?=
 =?utf-8?B?NkFRRGttL0JGdmpSeXhNUUNmMXV3alRuVzJacFZ1a1JJVnR6bUIxODdMN0dR?=
 =?utf-8?B?T0wwQ01zYzNMRmdoT1RuOU1HWXRJSkVSU0hYVXZWVlFkOFRiU3VBSnBmSFRY?=
 =?utf-8?B?SXRsN3p4eWpqZ0hSci9BWEU4UnE0S0oxZjRkVXlINzlaZVdzL2RDUVZ2c1pS?=
 =?utf-8?B?NkllWlh2K0tNRWdTREV2Z3pNclQ4ZXk1MXAyTlljZEVldEkvNHRuRklpV0pJ?=
 =?utf-8?B?a3YrNG94eGVSeGhCd0JLeWlLVytWZTVlR1RpKzd0VlpBNE5KQzZZR1lvbkEx?=
 =?utf-8?B?ZkhSY2h4NmlVY2J2N3E1NVYxWW1WbTVmRktEbzFJRCt5b0UwTWlOZnVvT2Rz?=
 =?utf-8?B?T2VNdDh0ZDU5bU5ENUdNbXhQVVlhSGxJRklpNklXaFk0engyYTRnMTgyOTVG?=
 =?utf-8?B?Z24rd3ltYXVxdHMzK3FhMXhldjFHK0ZWQ1lJTTVKUUpmT2JOcUVzTUVIczUx?=
 =?utf-8?B?a3QzVVdvOVN0UHJzNmZZZkFsNkNUNCtMSDBtSkRmc0xicDcwaG9paUVNTTA0?=
 =?utf-8?B?ZUdyK201NXZBTEFxWVd0OHdHSEFNY1pLMVduU2t4aUFhTkxMOTBYOWljZkZJ?=
 =?utf-8?B?ZFliTWpXUkV4R29xMS9za0d6T1htWG5zV0N3V05rMWJ4Y2Fldlk0NlFQa1hx?=
 =?utf-8?B?dmFPQUxiSmlSVFFGKzBRR3RibnhMYTB4MlpXcDhCeUpMbmRkNGtFZjhzUEJ6?=
 =?utf-8?B?Ym9TK1MvOTJxb0c3MXJmYnRCL3orYlhxQXZFRzlYMUlEZFIrQVQwbEg3TzBq?=
 =?utf-8?B?aXNuQ0ZYZzcwT2pESXU1TkcrMmRnQkczblJjSHN3WllqY0Q2dWZVMnh5K2Zx?=
 =?utf-8?B?aHFjZjhJNnRZVnhPMXNocG9BNzFIWU1uSVNoL2FGaEJXd1cxQ1Y3SWxaa05E?=
 =?utf-8?B?QjNtNTVaTG9lemNJaFBWYjNPSWx4aTgxY0VkdGdqUTVFWFJFR2dub3VGYkRs?=
 =?utf-8?B?M0NONXVPeHRUVjhIVDBPc3lMcGJEa0E3WnUzUEVtUEt3VWFBWFpDelhoTWYr?=
 =?utf-8?B?YTZuWi91VHJzRnpGUVo3eHlMUXExdVFocjFyWUY2ZExaeVBRd0hCUWpVVXhY?=
 =?utf-8?B?dkFmdFBMbHF6QjlZWEVqb2ExT055dXZPemJubktwSTQwSFV6cG55TGxMOU5P?=
 =?utf-8?B?VDRsMUpWNThtUGI1QlRLQ1lWMVY4bnZrZGloQm9sNkZFTWx3NkJnMmh3a3Ar?=
 =?utf-8?B?VTUzWkpJVnFsWEowT0RDRGpaeENhT0ROeWh4MjkxNlFwLzV4UDg5NFBmWGR0?=
 =?utf-8?B?MkZlYWZLTUx5VW5ITW9QL08xQytHbWpqMGp1djVLQVBQOHA3Q0oxWC9VbEdn?=
 =?utf-8?B?Nnc5MUlmQXZtZlZXRnJFbHc2R0hoVXZLQlNZWHcvL2lXNWYzTHRtQ3hkbEly?=
 =?utf-8?B?UGRWdWVoRzczUUtXS1lKVXhHcFgwTlBZQ3ZKMTl1VEZxcWs3dTRKTUxtbHRL?=
 =?utf-8?B?VG8yNHpvelZ6RFpPbU81SWlRYkkrVXJSUWFqUjZyMUM0N09YbDdQZVdMaytt?=
 =?utf-8?B?ZkkyQXBvUGNVeUFwWWltSk9yaVNyNUxoTTI2YUhnNTRwZWp6UXMyQkpzZTU1?=
 =?utf-8?B?cmlLVlFBZlVIc1NnSkc3SUMvQm9kbEpWbUFYWjFJTWFCZGptTzc3UTU2dUMw?=
 =?utf-8?B?UWVGRW1zaHdrQ1B6c0ZVZGh0SWJQbzR0MHp5OThmNzl6N0Q4ZzBSSnlFOVVZ?=
 =?utf-8?B?NTJvekwrL1hlNHRjS0hjTU40b1dZMEs1OUJwMTlFb0FRWjJaZVpxaTJIWTM0?=
 =?utf-8?B?Y3NmOVN1TDFLU0dNNGhCZFlCWW5EdTFtbW0xNlk2UUwyYWJ5KzhFUEI0Z0ww?=
 =?utf-8?B?Tk9mSjhKdkdONmt2eGV5dFRvTGMzR3ZTYnZ4WVdUZ1gxS0s4c0JQeXVkeFNZ?=
 =?utf-8?B?ZXIrUTNZV0ExSzdHcEd4NEIwaWFFT3VmSzg4UEt1TlFHd2RkQ0VzbHhYUUw5?=
 =?utf-8?B?aGlkMnVwUnQwcG5ZRnl2T0xGK2RKQml2cHhGbXJrbmhlbWtxV0k5bDFmdzZ5?=
 =?utf-8?B?ZlRqekN2K2NNUEtvRS9DVTg5WjQ3UjVBYjdENTJOVW9BUlk1NnZmTTV4Nkkr?=
 =?utf-8?B?ZGZ3MUlGUW5hTUd0ZW1GSkNUb1lROFovWWpBUGtnbXVMYW9yVW80YnJyekVo?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <873755EA11AC8141863D6F53CEBCB6EF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YoKvLx2aMvAxj7a+T0zjgh8JYXAPHvUe8YnaPH++qRsoqCzzEmflyfXDHPazhT3maJJQ9bUeHomdcDj0NDcX5d5MoDzyW0m0W10SuVihDP+ffdkZZTFzJMXQNTPmwTmE+F79Zk3zd5ghggAGhDBEIb20kBspx3rMAKxfL9NOvPU+0uDv+CyHNakh1boDBV5Gb2pWYcIFHNN7E5r3e6WIiC1P+yZJ3txJfar87Jjm1GMC19/e9yzNBrJATnVL7V88A5hS/OZdvjpxx1MhnVXNXCC1OCWapYC3h5XdWrxeqfIEeTcl+uYm8mefrK2HCLKaDGvfThKvtJdwUKZ2KLEMZKkTZ9XUhXZO+7Kvn7TG+VJJsdvDKoq4XPYnLKon7hS3ixawAmf+U2guN1iAh//O0eUuQN9oNynU5fAcbcfuX5NZXIBlO+1qdlr7vhPbLlGnn88/WrnMc+ZCa5nNLTxN09feyeoY8mfSNkE2QjQgIRJMbKSSwWO1ijuEMa7NEOv8yOeVucF/HpT/FCmKf2w4iMm40btLP5K/N4Rk94IZFmMogsRMHcaEWptbHsa8ctQxYDHpS8e1XVsbysj0lFkt5UeokhYehiuX756Y4K1SCTIc6zstU/4R76/dOTKn/6BX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ab9065-bb39-49d3-d111-08ddaa01bc48
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 22:37:38.6548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 964Et9c/6U4lE7xXCzf43SpKWvqypblAoA9sZikgq3hUKA3h8W5dLOoc3chCTt/faICQ41QLGI3ucDPePk/kiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6327

T24gVGh1LCAyMDI1LTA2LTEyIGF0IDEzOjQ5ICswMjAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0K
PiBUaGVyZSBpcyBubyByZWFzb24gZm9yIHRoZSBkZWxheSwgaW4gZWFjaCBsb29wIGl0ZXJhdGlv
biwgd2hpbGUNCj4gcG9sbGluZyBmb3INCj4gbGluayB1cCAoTElOS19XQUlUX1NMRUVQX01TKSwg
dG8gYmUgc28gbG9uZyBhcyA5MCBtcy4NCj4gDQo+IFBDSWUgcjYuMCwgc2VjIDYuNi4xLCBzdGls
bCByZXF1aXJlIHVzIHRvIHdhaXQgZm9yIHVwIHRvIDEuMCBzIGZvcg0KPiB0aGUgbGluaw0KPiB0
byBjb21lIHVwLCB0aHVzIHRoZSBudW1iZXIgb2YgcmV0cmllcyAoTElOS19XQUlUX01BWF9SRVRS
SUVTKSBpcw0KPiBpbmNyZWFzZWQNCj4gdG8ga2VlcCB0aGUgdG90YWwgdGltZW91dCB0byAxLjAg
cy4NCj4gDQo+IFBDSWUgcjYuMCwgc2VjIDYuNi4xLCBhbHNvIG1hbmRhdGVzIHRoYXQgdGhlcmUg
aXMgYSAxMDAgbXMgZGVsYXksDQo+IGFmdGVyIHRoZQ0KPiBsaW5rIGhhcyBiZWVuIGVzdGFibGlz
aGVkLCBiZWZvcmUgcGVyZm9ybWluZyBjb25maWd1cmF0aW9uIHJlcXVlc3RzDQo+ICh0aGlzDQo+
IGRlbGF5IGFscmVhZHkgZXhpc3RzIGluIGR3X3BjaWVfd2FpdF9mb3JfbGluaygpIGFuZCBpcyB1
bmNoYW5nZWQpLg0KPiANCj4gUmV2aWV3ZWQtYnk6IERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtl
cm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IE5pa2xhcyBDYXNzZWwgPGNhc3NlbEBrZXJuZWwu
b3JnPg0KPiAtLS0NCj4gwqBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUuYyB8wqAgNiArKysrKy0NCj4gwqBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRl
c2lnbndhcmUuaCB8IDEzICsrKysrKysrKy0tLS0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDE0IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KPiBpbmRleCA3ZmQzZTkyNmM0OGQuLjVkYWIz
ZDY2OGFiMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNp
Z253YXJlLmMNCj4gQEAgLTcwMSw3ICs3MDEsMTEgQEAgaW50IGR3X3BjaWVfd2FpdF9mb3JfbGlu
ayhzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiDCoAl1MzIgb2Zmc2V0LCB2YWw7DQo+IMKgCWludCBy
ZXRyaWVzOw0KPiDCoA0KPiAtCS8qIENoZWNrIGlmIHRoZSBsaW5rIGlzIHVwIG9yIG5vdCAqLw0K
PiArCS8qDQo+ICsJICogQ2hlY2sgaWYgdGhlIGxpbmsgaXMgdXAgb3Igbm90LiBBcyBwZXIgUENJ
ZSByNi4wLCBzZWMNCj4gNi42LjEsIHNvZnR3YXJlDQo+ICsJICogbXVzdCBhbGxvdyBhdCBsZWFz
dCAxLjAgcyBmb2xsb3dpbmcgZXhpdCBmcm9tIGENCj4gQ29udmVudGlvbmFsIFJlc2V0IG9mDQo+
ICsJICogYSBkZXZpY2UsIGJlZm9yZSBkZXRlcm1pbmluZyB0aGF0IHRoZSBkZXZpY2UgaXMgYnJv
a2VuLg0KPiArCSAqLw0KPiDCoAlmb3IgKHJldHJpZXMgPSAwOyByZXRyaWVzIDwgTElOS19XQUlU
X01BWF9SRVRSSUVTOw0KPiByZXRyaWVzKyspIHsNCj4gwqAJCWlmIChkd19wY2llX2xpbmtfdXAo
cGNpKSkNCj4gwqAJCQlicmVhazsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLmgNCj4gaW5kZXggY2U5ZTE4NTU0ZTQyLi5iMjI1YzRmM2QzNmEgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5o
DQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+
IEBAIC02MiwxMSArNjIsMTYgQEANCj4gwqAjZGVmaW5lIGR3X3BjaWVfY2FwX3NldChfcGNpLCBf
Y2FwKSBcDQo+IMKgCXNldF9iaXQoRFdfUENJRV9DQVBfICMjIF9jYXAsICYoX3BjaSktPmNhcHMp
DQo+IMKgDQo+IC0vKiBQYXJhbWV0ZXJzIGZvciB0aGUgd2FpdGluZyBmb3IgbGluayB1cCByb3V0
aW5lICovDQo+IC0jZGVmaW5lIExJTktfV0FJVF9NQVhfUkVUUklFUwkJMTANCj4gLSNkZWZpbmUg
TElOS19XQUlUX1NMRUVQX01TCQk5MA0KPiArLyoNCj4gKyAqIFBhcmFtZXRlcnMgZm9yIHdhaXRp
bmcgZm9yIGEgbGluayB0byBiZSBlc3RhYmxpc2hlZC4gQXMgcGVyIFBDSWUNCj4gcjYuMCwNCj4g
KyAqIHNlYyA2LjYuMSwgc29mdHdhcmUgbXVzdCBhbGxvdyBhdCBsZWFzdCAxLjAgcyBmb2xsb3dp
bmcgZXhpdCBmcm9tDQo+IGENCj4gKyAqIENvbnZlbnRpb25hbCBSZXNldCBvZiBhIGRldmljZSwg
YmVmb3JlIGRldGVybWluaW5nIHRoYXQgdGhlDQo+IGRldmljZSBpcyBicm9rZW4uDQo+ICsgKiBU
aGVyZWZvcmUgTElOS19XQUlUX01BWF9SRVRSSUVTICogTElOS19XQUlUX1NMRUVQX01TIHNob3Vs
ZCBlcXVhbA0KPiAxLjAgcy4NCj4gKyAqLw0KPiArI2RlZmluZSBMSU5LX1dBSVRfTUFYX1JFVFJJ
RVMJCTEwMA0KPiArI2RlZmluZSBMSU5LX1dBSVRfU0xFRVBfTVMJCTEwDQo+IMKgDQo+IC0vKiBQ
YXJhbWV0ZXJzIGZvciB0aGUgd2FpdGluZyBmb3IgaUFUVSBlbmFibGVkIHJvdXRpbmUgKi8NCj4g
Ky8qIFBhcmFtZXRlcnMgZm9yIHdhaXRpbmcgZm9yIGlBVFUgZW5hYmxlZCByb3V0aW5lICovDQo+
IMKgI2RlZmluZSBMSU5LX1dBSVRfTUFYX0lBVFVfUkVUUklFUwk1DQo+IMKgI2RlZmluZSBMSU5L
X1dBSVRfSUFUVQkJCTkNCj4gwqANClJldmlld2VkLWJ5OiBXaWxmcmVkIE1hbGxhd2EgPHdpbGZy
ZWQubWFsbGF3YUB3ZGMuY29tPg0K


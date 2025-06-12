Return-Path: <linux-pci+bounces-29625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4F3AD7E89
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 00:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0D916B7A8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 22:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB7F537F8;
	Thu, 12 Jun 2025 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qX/zY4gV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ba/fsTw2"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89616F288
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767953; cv=fail; b=YEbQTehu1e1RhZLFfzz7vyNsS30UAC14iyWrtzrhI4s9cr7HSZdUEFUTI80IfGBGA/6fyiAPxPCG32oNvSRMDjcfii97USIWGwJWNu/VVH8J/lySte3JJBBJBg0XBvCWZf2ZahiLgUNekqlVh5JqVfqxbqJRQasikYWD8vanCvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767953; c=relaxed/simple;
	bh=fWqF60gL00YObfWS3hyD4L12wR8WXFSco/TA3JBNYVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pB/QXgrqILhTFHUij+Tpiv6kceWRJvOleCMQoYqgHf2JdqI1fIeLCgmryNQJaI8zTPDZAknmBRelrR37rezRPdoCwyyCXL5bDhCxTbv6yR3Md/Y5wn80bRgLtprkXHtcsHm0b1zmNH+IdYmaTVeF2G6pALsqclCvpJD2CyI3VH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qX/zY4gV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ba/fsTw2; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749767952; x=1781303952;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fWqF60gL00YObfWS3hyD4L12wR8WXFSco/TA3JBNYVM=;
  b=qX/zY4gVsEEJz1Dmc6HF73dkQOzUrNasOUbrEAEizEkOoFvE2RP97bIB
   E0mfK0K3XeVCEP7qaqI4cbpKkS/A9VRBSzu5yZgCMN0euKsjHs9bVxkdS
   A6EeKhwB8g8+DpB1ZsiH+H40RaV6iy5VOTPvr3l7xYG4mD5gOM91MGjQE
   yHk4AVwJ37dyRghpa4VnZ9EREL8+actS5xW5hBcJuwDfjWMO2ai4FT8Es
   jxwYTV7n0Ugr9+1AIztydCxh3SnoApVNNk/EF4FTh/AAcZuQyv8c03iKB
   MeZ8NrpM3MjNFdyjYcgOg4A9Vo4OYWc6kMExTi8zN1J1+usdbN6HSbiUf
   w==;
X-CSE-ConnectionGUID: CmassbmbScW5jDd1YRZ1vQ==
X-CSE-MsgGUID: WlGu6PQXQMKzmnMgWg+Ekw==
X-IronPort-AV: E=Sophos;i="6.16,231,1744041600"; 
   d="scan'208";a="83943450"
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.41])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2025 06:39:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHU/BsAFYKruJU4+AGYlohG+a1XCsE99cSPBNTjKl6OnEZf0yEqT3uDeovHYO6uy0ETcVt7iAsEPtqIzXQ1+2ziy1NZaMbWYxKI6VTBZ0Dg9bd8WlAd1qPgmJsIP+kSQiDEWbpPGPvvyK/D4GepdzbDa9JSPljdYPCz2lmhWVczFJn7GqEoftIAuvS2bGm5g58cPCOl9pHN8RPb6FVTrOgLQxEHvUBxj0sNV18HpKUwjL//N7iuX4tPEHhX/dbZ8Ym1bpYbWtvHysktekvicMxhu2gis7tYG/Er4EGvsjXWmIM7usSGZLgHOJP3Xl30rnDVnq2mEljpDwImCfGyyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWqF60gL00YObfWS3hyD4L12wR8WXFSco/TA3JBNYVM=;
 b=mnBaNcD23+uU9o0hUWPeqhqi/PKx5GWdy33KTN+zGAkaE6LepxnkXeCCCOBWoIrwfj9/3OX2lZphXfLBedyEB76mGw6xAKXTqem1oLUvUvYclawHshtJEwHxGUZ7+JKu4vMpJu09q1oflxB0yRhjdvmNzZ4lANpRqo/nkUJfQgW0jEMnq2HX4Z/Smf55eLDDbl50IjVBzWEGnSIJGlnvGNDEQkIluLK0CPgGpQgdHZflyhQ2M6196WLOkoSMWSH8gBxs+lgB+FHkzTd4qi86Mwrrgb8EgVpmqtoStZ2cqJqDxQgFh071glbAS0hzvTqW8F07MJqZO9ZUYH6pN/3teQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWqF60gL00YObfWS3hyD4L12wR8WXFSco/TA3JBNYVM=;
 b=ba/fsTw2S07QHgQRpZ+088gPRIx+xd27uPYK4dMJnfGL+TbUZO3JscahTZZCKb/DOKgXiC6ng6bzd0UKFgUyrO/DtMBWjePJUP7zJAwHF5WKw6uCDyRX7/6vFWjepDXGsZkvaI1wgwVQb2BVNXQJGtRcxwSVTHE6lCmMvcYbL/A=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 22:39:07 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 22:39:07 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "cassel@kernel.org" <cassel@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "heiko@sntech.de"
	<heiko@sntech.de>, "mani@kernel.org" <mani@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "laszlo.fiat@proton.me" <laszlo.fiat@proton.me>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v2 5/5] PCI: rockchip-host: Use macro
 PCIE_RESET_CONFIG_DEVICE_WAIT_MS
Thread-Topic: [PATCH v2 5/5] PCI: rockchip-host: Use macro
 PCIE_RESET_CONFIG_DEVICE_WAIT_MS
Thread-Index: AQHb25AmRX90wXqOAUadzcb+vT9gerQAHnyA
Date: Thu, 12 Jun 2025 22:39:07 +0000
Message-ID: <446bb8bf4323b2b03082d4f93ff08eb8e89b1ed0.camel@wdc.com>
References: <20250612114923.2074895-7-cassel@kernel.org>
	 <20250612114923.2074895-12-cassel@kernel.org>
In-Reply-To: <20250612114923.2074895-12-cassel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|BY5PR04MB6327:EE_
x-ms-office365-filtering-correlation-id: 69b9072f-d9b5-43bd-6921-08ddaa01f161
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OTl6N2s5c3NqRElCbUJtWkw0TkEzaDYrUzRPQi9iMWtGZWpLZFZsSWE1WTRp?=
 =?utf-8?B?OXNxN3BzMW5BNW1LeVVXMnlHRWwzOUpNTDZBTmg4QnZwdUhuUmVPSWU3d3lD?=
 =?utf-8?B?UnM1RktCTGJKSlhScXpRZktZVlRVbDFZMjBRajAyemovbFhJZTNSNkJ2Uzcv?=
 =?utf-8?B?UjZOdDZkVXFBbTZjNTZOdWtTUW9Ea29LVDVnWGw0UnFyWkdwN1FYUlBIM2du?=
 =?utf-8?B?N1hQS3NRcnpYUncxVU5ocWpVWnpVSHA2TVJ5ZDdDRzJvWFJVZTBPckpCTmVU?=
 =?utf-8?B?SXJZMUFJc2NWOXg4VFFBVFlMMUZwWHhic2NiaEZQWTB5WjFBa3k0bStrSVB1?=
 =?utf-8?B?Qko1dkpxaGhRcmxncWVYTG4veW1XWTlXZi9kQ2MwQzE3U1N1a3JSM0hoVWl2?=
 =?utf-8?B?c2ZiRlY4K3dYYVMwRTM3V3JnbUc4RVM5dWozYWI2b3ltdWk0ZHdWeE1NS1Uy?=
 =?utf-8?B?MUM1VUViRUM4RGpwbG94c09qNE1VdWxPUHE1TEpLRjV4MXpEMzNFZjlqM0VC?=
 =?utf-8?B?b3dCSWhpdk1tbXNhbERSU2Vja25hTFdZWjNwdzYvenRTQjAzVTEwWStXRTc2?=
 =?utf-8?B?OGxYU21aSWEzNlFweDNPMExTSFZVblI1eUhicGZoc3dBMnRNdTVEREJxSzc0?=
 =?utf-8?B?U0JSdS9YZjJPWEcwN1BmVWdaR01iOW9XS21JbUJwT2JWWGhQazZ0alJnT3da?=
 =?utf-8?B?T0JtSEx0QmI4SE5mcEhCSUd5ODlIbitiTjF6dHIwbkd1Z2dib1ZKTkFTQlRs?=
 =?utf-8?B?OXltUWxoODJ5b05iWWtVSkRqU0ZaTktua3hRUXpnOWVFUCtwWDhXbWV0a2xZ?=
 =?utf-8?B?dzZqd1RRcHZSQVltSWJDS3NBS1BCdTBHZVc4SDc0Z1VkOFFCYzZSU3dlQUht?=
 =?utf-8?B?alBkS01lNSt5Vll6RTNEZktjSHcxRHpVQlVqWVdvUCtRSWxZWS9NNzRNNkQv?=
 =?utf-8?B?ZGhxS1BEQ21Tdk45cVd5MDhMT1ExVHB5aHpDQ1pNU09XVE9udmpvWGxrMXU5?=
 =?utf-8?B?bEhnR0tHZDVnWW5oT3NDeURuTEFyN0ZKVWtXVDJMTTMwUCtjZys1Nk9hdXlY?=
 =?utf-8?B?WjdRMzY1UXZ5cWRuYU5UQ0ZaSGN3SUNDSnczS1ZqZXBRY0laT1RtYUJXazg1?=
 =?utf-8?B?YS9ET2k2SjZQVzgva0p4NnE2SUNBVHF3eWFpSVppTTk5bjdDV216bk8wbkNk?=
 =?utf-8?B?OE53QTBxWkd2VWw0ajRsWEVSU1pseStzTmxISFVoUkFyK2NNU1pGd01QWTVO?=
 =?utf-8?B?N3ZYd1lFNjAzUjdZNnBub2ErdngzaHlvZmcvM3FOd21zYTRudFREMllQalBS?=
 =?utf-8?B?VjZhendxTk1WSUxQTk1oU0dqd2JCSUt5akI4djVJMkhmTzNpQXBJVld0KzEr?=
 =?utf-8?B?clViaUM5bUVzbW9HSGdMS0Q4UTlicEVHcXRaZVp0RHVoWVFNMkNma0tBdll1?=
 =?utf-8?B?S0M4cVJzTVE3cVZPS3gyL3ZOdlFhcFFmMXFCK1ZmdDlkeWNLWnhWOEZpdUpi?=
 =?utf-8?B?ZjZ5eUlWd2kwVWFyTVlUeTV3ZE9MUmRtMEtQS3VuSGkyN0pWYWpLMUtrWXJw?=
 =?utf-8?B?SjI3bnFNTlVWVkFkMDJmYzl3dU1MYy82RktBVXhpT095MFJtdCtNZmVYV1Bq?=
 =?utf-8?B?Qlp4aE1oVTBFdlE5Q0dWRUdEOWZTbmRwT0VhOWdNOGFVVW1HZk9pSVJpc0xm?=
 =?utf-8?B?cnpCaEJRN2ZkL2FzbG5Wd2E4cEtHQWhQNWNCRms1VTBCK3FYTVRvUnNNaTF1?=
 =?utf-8?B?SlQrMzhFYmYxY0xBR0Vhdyt5bkhSVGZFVTJaMFZldzJadFBXTHNtS1VJRUxm?=
 =?utf-8?B?MVdUaE5BQXNzaVBwWERFNlFNRTBLV2EvemxqbDI2SFA3ZFJPd2FxQVhBVXlO?=
 =?utf-8?B?RDF6cDNzZlluU0VOdzh1MUVZaXRTU0dWUEZlRUVVeFlHZ1Y4NVl2WmJZbyts?=
 =?utf-8?B?K1FkT2o1WUcyVXVmMUJvZ0VlRm5aSkxlc1NkYkdnaHNnQXJpV1dBcjBGcjNr?=
 =?utf-8?Q?VQnL8JMGQS+3UxsXHs8jjjMHqxi2EQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3Rad1NQYm0vV3RMaklUTTNXRDc1RTR5MUFFUjhnZU5rNzVmUkFqRGFERjdt?=
 =?utf-8?B?Ti9XM0lDbXMreDFOUlJJZGRwSXFNVE1zbENRR1VFV0tsWDNiS09MWWh2Tisz?=
 =?utf-8?B?aXA1aXM5TWJLZkc4RWhlajFET2R2TDlpUGlVU05rUXRJQjRMOU9teW1lTnp1?=
 =?utf-8?B?S1JSYlQ0d1czMW0rWm5KaENzOE02MXMxWjlqOGZScnNoTmMvRXI5U0dkSGhj?=
 =?utf-8?B?eVV5VXM2REFwcThWRi9kKzFHWkxuUzJkT0dyMVFlLzdGREtaMEY1YWR2MXJ6?=
 =?utf-8?B?aUNER01EQlgyd0F1eXlkbkpSejZObWI1Ymx2ZENZRWJaVGJaU2RvNGlOUFJ6?=
 =?utf-8?B?bDhHSUZPWXM0OThFN3UwRytpdzQ1SHNVSkdYdWpZTi9TV05jbTlDeGllMFVV?=
 =?utf-8?B?MmdMTEJSam54aEZaVW5LNmVjYXJ5aS9hYTRtc1lheDRzQ3pZcXNyU1YwVnkw?=
 =?utf-8?B?U1RUTWFKb2ZIRXhhcDBCbmFaNW5nTDFTUEk0bkhiZTlKWlprWG1WZW4xOE1J?=
 =?utf-8?B?cWk1ZkM1Y2w0VW1uMWNKTlBjV0xhVFA3UGVDcWUzZkw5Y0xwNkx2UDBVdG5x?=
 =?utf-8?B?MFF3Y3ZmQ0JyQUtFVEFDTVpxQTUxc29ka0hsT2RIV1MwWWoyT3lyNHkvcFI1?=
 =?utf-8?B?MGVzK01INmcvc1BWSnZURHRtNzU4UHRzc2JJdW5QWm41MjNJZ2FmQmVzRDIy?=
 =?utf-8?B?NkhJZ0U3clpjVndld1FhT2huV0xyZ1dSN2ZVcCtGRHlnalE1VVZKTXhxd0JQ?=
 =?utf-8?B?bTNsRWI3SWZJc0hwUGxBMmU0RVNaV3psMnRkdEkrZnNuV21nS2lCU1hHQVZG?=
 =?utf-8?B?cFRZcFVVZjZiNVZpS0xFTlhYY3JWQ2FnenJibUVKWnBDdDRWOEM1Z0NBbXhs?=
 =?utf-8?B?aFFkZzJScWVwMnh2UE9RYWsyYTF4c2Z0cnoyVEt1akI5TmR6U1JyTS84b2t0?=
 =?utf-8?B?SjlhbWd0ZjdYeDJzTDdPTGlsTDd6ckVVcGYvbGZvcUdRNzByS3d0dkh5YThp?=
 =?utf-8?B?Um95bHdwQXdIdUVlSnkrbnVXM3V1ZGQyY0pPRWZGZTJoZ1RZNEVqRkwrQjJv?=
 =?utf-8?B?eWFTYWp2T2VEU3ZCcVc4Q0FTd1huak9CWHcwK1VWOGppRkxucmFxTkw0ei8x?=
 =?utf-8?B?L2VpeFRweTE5cDY0OUxaR2RrdldCYmhoOXc2TGd2K0tMSmV2ZlV0Y3dFNnhx?=
 =?utf-8?B?dy9PcHdvaDhzVGxsTlZqWXByc1FTTHo3a0lPaVpZSjZTaXFhaXhDL01GbCtB?=
 =?utf-8?B?djQxRGtCdmFSVlMzamtyM2l4Sk1tYW01UEtaZ0VrODlqVFlRTzhwaDJEWWtV?=
 =?utf-8?B?YVdZbEtta0tkWllaaUMveEEvRWhLSkROTW5rbVhtVWhTc3pnU3pZa004TUov?=
 =?utf-8?B?Mm1UTXhGdkxPVlpnMDhXeDllRXMvcTQrS05HZ1UxZWgrRElJYStYTjd3SnMw?=
 =?utf-8?B?RHJ3YWpHVHlPaDdDczhOQjJHRFBWeW1vSDkvMTRXWVZjM0ova3lUcC9kQnJH?=
 =?utf-8?B?SDI2Tyt6ekNQNStZK0ZDN1d5WVZZSnlsbVV5bVpjT21vTFVRdXUxNlZoUk5p?=
 =?utf-8?B?cVlkMmxPd3pSY09JSHJ2UUZBendLUFBzVXhuWWJnUStwTHozT1hVdUQvRlZS?=
 =?utf-8?B?am1pWXZIRzc5TlB6dEJ1b2FqTXJFOVovS2JRRTlVTWtvc1RQRmpobmIyM2Jl?=
 =?utf-8?B?aUQrc3BmUmVlK2drdmNGOG5IS0tkRWZCWmZjZmpUTTVZU2NibkpQYWpyc21E?=
 =?utf-8?B?UnJDdWdYd1Nhem1KK3A4dWRFQnk3TWVvaVQxZ25UcldYQVpTYllnYXptWW5h?=
 =?utf-8?B?dU1DNkQweHJYU0wrY3plak9OR1BTNFg1Qnl5ZHNGS2VndlRPaGN5SGUyM3NW?=
 =?utf-8?B?V0I3TnlBWVYrNFI4WXdJR2drYmVVTDhQRWJUUU8xbmxjMmsvdGtiZ1ozaGEw?=
 =?utf-8?B?OXdzMkMwVVZwR1hmeE9FSjdtdWs1NDMrU1o2MlloYjJ0S3cwTm92bHFoRE00?=
 =?utf-8?B?U083aitISExoajVQWHlNMXNYK1JZQkpWandMeDlCT3dJNG1YYTF5bm10M0xM?=
 =?utf-8?B?dEN2WGQ3N2VXL0p1RWQzMnh2Z3dLZ1JvUXJ2alp6MHBTMk9YTFJna0JTaWRI?=
 =?utf-8?B?QjJFQWo1N3ArZVAreXByK0wwSXN2eElzVjkybUdqQWFab0NZRjRwRVp6NVFL?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7F16E47B13CE24490D45176FBB22A09@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1wvyA3gLvQZuOeOGTqu4VWHPvVSS3a0ntmwLN2JUyCDNF5Adx0B2/azm4aJRvt7vrMVhIrF/ptvTeeqrvWGG+TtbcJiWV+9trY7tS75nFJMMmh0NJUvb8PDZHwDlSXLL0yvfS3dG7hwfwstdGhqV9/4LccIgcmE9Ba2XYM+LgE1bt6PgYTK0/yRw1pO4DtxP+Bsxe9rpUd4Z/KfEOzgumcd60t0gb7Ns1Gpjw+qfAj+laF0s9IGY3kg7x8jQZvg+eq3o8iJOu8NPXN0VycoCJJMZ211hHFRn6Z01P1MwYcRg1leMnk+QwGMmtbNteqsHSfpqJai3sPUorotQjY+h6Xqq3WkaQ2zH/AD3M464xnJDw9PpIhnxL/0mAD4qANCeRSwg6WKTkX2GHC0Qvv6aP2pda0VhtE/5+CmGPMONzL3D9Je3m5rrQV9UMnXahew9Rly1Ce2zatsFOzV7d+7Q4PvmkUxSJe3Olw/sXkGznOqGDvQJHeqSljJgiX7ntKf7aVL7yNGhfekeel/apnbsiYF8UZ7J7MIPMlp7kOwwjkEmy0eDFjLzg5DLtyrhFZWyegd13+6Z9RK+SwrWkh/AbnUIZFwe1OpS6MTiAdNnQ3tpCuMC5YUWQRsPzwhlyojB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b9072f-d9b5-43bd-6921-08ddaa01f161
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 22:39:07.7295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ny3ZxlqcRtxdofAki+JkuqGPsUfSdhiF3HqhvHIiutD1IUr/0mf3EnkAtYCbqxxHiPvt0nA4nIf/pLzvEOH2bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6327

T24gVGh1LCAyMDI1LTA2LTEyIGF0IDEzOjQ5ICswMjAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0K
PiBNYWNybyBQQ0lFX1RfUlJTX1JFQURZX01TIHdhcyBhZGRlZCB0byBwY2kuaCBpbiBjb21taXQg
NzBhN2JmYjFlNTE1DQo+ICgiUENJOg0KPiByb2NrY2hpcC1ob3N0OiBXYWl0IDEwMG1zIGFmdGVy
IHJlc2V0IGJlZm9yZSBzdGFydGluZw0KPiBjb25maWd1cmF0aW9uIikuDQo+IA0KPiBMYXRlciwg
aW4gY29tbWl0IGQ1Y2ViOTQ5NmM1NiAoIlBDSTogQWRkDQo+IFBDSUVfUkVTRVRfQ09ORklHX0RF
VklDRV9XQUlUX01TDQo+IHdhaXRpbmcgdGltZSB2YWx1ZSIpLCBQQ0lFX1JFU0VUX0NPTkZJR19E
RVZJQ0VfV0FJVF9NUyB3YXMgYWRkZWQgdG8NCj4gcGNpLmguDQo+IA0KPiBUaGVzZSBtYWNyb3Mg
cmVwcmVzZW50IHRoZSBzYW1lIHRoaW5nLg0KPiANCj4gU2luY2UgdGhlIGNvbW1lbnQgYWJvdmUg
UENJRV9SRVNFVF9DT05GSUdfREVWSUNFX1dBSVRfTVMgaXMgc3RyaWN0bHkNCj4gbW9yZQ0KPiBj
b3JyZWN0IHRoYW4gdGhlIGNvbW1lbnQgYWJvdmUgUENJRV9UX1JSU19SRUFEWV9NUywgY2hhbmdl
IHJvY2tjaGlwLQ0KPiBob3N0DQo+IHRvIHVzZSBQQ0lFX1JFU0VUX0NPTkZJR19ERVZJQ0VfV0FJ
VF9NUywgYW5kIHJlbW92ZQ0KPiBQQ0lFX1RfUlJTX1JFQURZX01TLA0KPiBhcyByb2NrY2hpcC1o
b3N0IGlzIHRoZSBvbmx5IHVzZXIgb2YgdGhpcyBtYWNyby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE5pa2xhcyBDYXNzZWwgPGNhc3NlbEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gwqBkcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtcm9ja2NoaXAtaG9zdC5jIHwgMiArLQ0KPiDCoGRyaXZlcnMvcGNp
L3BjaS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDcgLS0tLS0tLQ0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDggZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ll
LXJvY2tjaGlwLWhvc3QuYw0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1yb2NrY2hp
cC1ob3N0LmMNCj4gaW5kZXggYjllN2E4NzEwY2YwLi4zZDQwZGFmZjk4YmQgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1yb2NrY2hpcC1ob3N0LmMNCj4gKysrIGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXJvY2tjaGlwLWhvc3QuYw0KPiBAQCAtMzI1LDcg
KzMyNSw3IEBAIHN0YXRpYyBpbnQgcm9ja2NoaXBfcGNpZV9ob3N0X2luaXRfcG9ydChzdHJ1Y3QN
Cj4gcm9ja2NoaXBfcGNpZSAqcm9ja2NoaXApDQo+IMKgCW1zbGVlcChQQ0lFX1RfUFZQRVJMX01T
KTsNCj4gwqAJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHJvY2tjaGlwLT5wZXJzdF9ncGlvLCAx
KTsNCj4gwqANCj4gLQltc2xlZXAoUENJRV9UX1JSU19SRUFEWV9NUyk7DQo+ICsJbXNsZWVwKFBD
SUVfUkVTRVRfQ09ORklHX0RFVklDRV9XQUlUX01TKTsNCj4gwqANCj4gwqAJLyogNTAwbXMgdGlt
ZW91dCB2YWx1ZSBzaG91bGQgYmUgZW5vdWdoIGZvciBHZW4xLzIgdHJhaW5pbmcNCj4gKi8NCj4g
wqAJZXJyID0gcmVhZGxfcG9sbF90aW1lb3V0KHJvY2tjaGlwLT5hcGJfYmFzZSArDQo+IFBDSUVf
Q0xJRU5UX0JBU0lDX1NUQVRVUzEsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2kuaCBi
L2RyaXZlcnMvcGNpL3BjaS5oDQo+IGluZGV4IDEyMjE1ZWU3MmFmYi4uNWE4MzMzOGM4Zjk5IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9wY2kuaA0KPiArKysgYi9kcml2ZXJzL3BjaS9wY2ku
aA0KPiBAQCAtMzUsMTMgKzM1LDYgQEAgc3RydWN0IHBjaWVfdGxwX2xvZzsNCj4gwqAgKi8NCj4g
wqAjZGVmaW5lIFBDSUVfVF9QRVJTVF9DTEtfVVMJCTEwMA0KPiDCoA0KPiAtLyoNCj4gLSAqIEVu
ZCBvZiBjb252ZW50aW9uYWwgcmVzZXQgKFBFUlNUIyBkZS1hc3NlcnRlZCkgdG8gZmlyc3QNCj4g
Y29uZmlndXJhdGlvbg0KPiAtICogcmVxdWVzdCAoZGV2aWNlIGFibGUgdG8gcmVzcG9uZCB3aXRo
IGEgIlJlcXVlc3QgUmV0cnkgU3RhdHVzIg0KPiBjb21wbGV0aW9uKSwNCj4gLSAqIGZyb20gUENJ
ZSByNi4wLCBzZWMgNi42LjEuDQo+IC0gKi8NCj4gLSNkZWZpbmUgUENJRV9UX1JSU19SRUFEWV9N
UwkxMDANCj4gLQ0KPiDCoC8qDQo+IMKgICogUENJZSByNi4wLCBzZWMgNS4zLjMuMi4xIDxQTUUg
U3luY2hyb25pemF0aW9uPg0KPiDCoCAqIFJlY29tbWVuZHMgMW1zIHRvIDEwbXMgdGltZW91dCB0
byBjaGVjayBMMiByZWFkeS4NClJldmlld2VkLWJ5OiBXaWxmcmVkIE1hbGxhd2EgPHdpbGZyZWQu
bWFsbGF3YUB3ZGMuY29tPg0K


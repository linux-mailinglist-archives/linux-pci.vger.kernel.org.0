Return-Path: <linux-pci+bounces-45078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38770D38811
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 22:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C808301D660
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 21:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7F43090C7;
	Fri, 16 Jan 2026 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="tZga0kQ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011007.outbound.protection.outlook.com [40.107.74.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F76B3033E3;
	Fri, 16 Jan 2026 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768597208; cv=fail; b=FA718W6ZCsmWSwVBj6wivkHbt+9kSmlWsgcRdj0iimeg7v5SLghISrAtBA9F2H2hzmjtH3sARSS3HyFRPymqefMkPZQGqAO9k0QafjZFuZGarsQluGGxLfPjYxN/LKcMg3SJDcfxDUzjv2fTQZeyRX+XJu0qVgvRaYbePj+mwfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768597208; c=relaxed/simple;
	bh=HJ6w924FLChX+VaU4zyi39Y2XQr13gJ9j3xpt9Oog+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jwJQ7vsoTdC9N2x+RCkIz0TB3PrKWyYIj55XZnRu7WV4tNFEBYHCpOn4ETOQCH7QRLs5LiK+E7OgmDE/4F0/K3xCyg1i0NXjxGUlBxsZ+QqEyHAGvaX7yPJGDaJRbnmkg59kNu5/fnRtPZlWlombjeF6ScXH/PkwfhcDeh2QwRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=tZga0kQ4; arc=fail smtp.client-ip=40.107.74.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzSKWRH8h0p9PkeOWCaORJv0o3ccfS1iBYR6KB+myG0u13zRbBrZrhjPUO5lLZhPLrGWBxV+ZLUNG6vRcFsFz+2kuC/9cVKV5Eyi5i9x9v4RI6FFUMRGnhc7bymfb5xqQXDSDKnrr6M+squycU3b0e09ajWYRXBNJLwTJmIBKB9hOLj/JyE0BGiDb/PieizCIFfXeooyFOaR15J2+a1A6xbujv5PhiREi5mbnWPW9qAQaURAWb/9wgKsYgo1Tfw2BBxgce0MY0N6vAxNPrlpNPn84AoA7QE6TEAqw4pa+/9rewQpDJSLtzKeNj5PE2FndVVgGJiIFjBtmQ3isIxViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJ6w924FLChX+VaU4zyi39Y2XQr13gJ9j3xpt9Oog+s=;
 b=QgHIKKnAu9Y+NJn8fn19vLKMFCAjKbaEQBdpJeG+PpbSox0F7NWB3OISkgvKPkuiLz8LBgWftjD8e0EMJ2yfkvha/D+VmKuZ6E8DZQb6aOtZLuOEqllWcZRoSwkemwf45SvPf82sBnOxwXAQ+hbjKGq3vrUpLQeNS3STTT0UCCRp6Fq3C6wFZXqgZJoukQiWnQB58MLa53KPCF1fVzGk211D2vGMQeg/pQNKfH4ebnmnHirj7+fcJRFzsKsP5QGlOWPJlZ9uL2fz1y4zFMY2KvdJUNEaoOqn3p3MYmh3IqU40Z9gYQ/ZyeWgar5WsuQyYgGCzo2R1yWg5ZztcS7NOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ6w924FLChX+VaU4zyi39Y2XQr13gJ9j3xpt9Oog+s=;
 b=tZga0kQ4iRCqrvaLV6R9uAL9xCrczwRaCjJ7aSpwCdkm0lNuP+FkWsFaKX/V/z/Xpv8kklqTYiGEJAwKkoFzSOhKglZIO5+nLk8wdaM3WONV/VdiSfcGRQDlJliLQgpkaOjkLnoimrs9FgVCiHwp+FPZzWhSxZlheinqNi/wRSY=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYYPR01MB12465.jpnprd01.prod.outlook.com (2603:1096:405:f5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.8; Fri, 16 Jan
 2026 21:00:03 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8%6]) with mapi id 15.20.9520.006; Fri, 16 Jan 2026
 21:00:03 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	magnus.damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>
Subject: RE: [PATCH 01/16] PCI: rzg3s-host: Fix reset handling in probe error
 path
Thread-Topic: [PATCH 01/16] PCI: rzg3s-host: Fix reset handling in probe error
 path
Thread-Index: AQHchWtzpfFST+ihokiR5M7UyuehbrVTNpYAgAITwXA=
Date: Fri, 16 Jan 2026 21:00:02 +0000
Message-ID:
 <TY6PR01MB17377F72FCA90657086978241FF8DA@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
 <20260114153337.46765-2-john.madieu.xa@bp.renesas.com>
 <2e05a458-b055-44d0-91d5-63091b9eab91@tuxon.dev>
In-Reply-To: <2e05a458-b055-44d0-91d5-63091b9eab91@tuxon.dev>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TYYPR01MB12465:EE_
x-ms-office365-filtering-correlation-id: e84b5c84-7d00-4175-1fd9-08de55423807
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0IyS2RjQldKWjdJeXJOZUZESHpKcHFtU2dZcWVZUHZ1QWthdEljSytZSWxE?=
 =?utf-8?B?bmZKcEZUdGNPWDBmeU5FZ0U5RkRMNVBDbUQ5NVpWcUtaUVZQTDc2UCsrK1FH?=
 =?utf-8?B?WE85b2tvcUdnU3VuVFl5T2kydzV0N0I1TWxreEN3ckRmcTFyS3U0MWtJenYz?=
 =?utf-8?B?K09YN25rN0JoNmJmeHBIOU40RzB1eXVnYjJXK20zc29QTFdSTWxpenBQNHhj?=
 =?utf-8?B?TEhUa1YwUkQ4dXhPM2xWanpQSFNZZ1QvdTNRL3hiSHg4SXdXSzN4T1lVSndV?=
 =?utf-8?B?Z0lhaERrS3RQRmZsZkt5a1MvT29sL0JvbEV3OENOcS9xWmwrdXdKc2E2M2Np?=
 =?utf-8?B?WlgwOHRSMEo2NnU3THBYSHZtTFgxN2ZrNkVxdWVPcGpyN1FiaUk0cXpNVGwx?=
 =?utf-8?B?MFVEWUxWd3ROTzN4NWRwQVo4WHUzTGhhOVR3Z1RXK25mYno5cS9zbVphKzRk?=
 =?utf-8?B?WEs3dHR1NzJtOU9UVVM2ZzFLb1hKblhRUjhaWGhpdFNPTUh3end5cEhyNklR?=
 =?utf-8?B?T2NnUFg2empTTUJQNUIxd2d2ZlVzbmEzOW9KQU5GT3F5K2RoZXNraHQzSmd0?=
 =?utf-8?B?UmlqRE1TREZac1JrdENmdnpyTVR0TkU0K1hVWE1ZbHVHbXNVOUlqZnpTVm0y?=
 =?utf-8?B?SjFWQzBoZmNzd3JvclMrKzJkVHZwRnVOZnE0OVpmdWRHN3ZiSmJHak1UWjdu?=
 =?utf-8?B?c01nakQ3VVZRTDdtNEtJMjU4K3ZDQ1dhdi9PeWNLOEpUdWpHdC9OZXhkMUI5?=
 =?utf-8?B?MXhJQysxRXFYZERmNnJVV0duMHRQOTZWaDNqd0hyc0l0eWFUbzJGcnhTR0l0?=
 =?utf-8?B?TWhaSnBqZ1ZNM3F2MFlsV3VvSUlUV2hMMDhyaEVWZGtWU000MjA2RC8zSUVa?=
 =?utf-8?B?cDRrM1Jjd3o4R0VqOTZ4V0dVZFJWeW8wcytJYVFLRUJmc1VlZzhLdjdIZVZT?=
 =?utf-8?B?RTBRMGdpK0FHczd2RmtzKytTeHo5R0Y4cnpBaTlqM0s5V3BqV05hMmxxRUJv?=
 =?utf-8?B?RkFLQ3hWZDllTmMwSEsxd2N3V3A3a3hlNVZFNmx5QzFLeTdLa1g5eXpQcTNa?=
 =?utf-8?B?aTdmaTV1WWp3azdKSVN1dWJwRlhyeWlBUTM2TS9YM2V6OG9VYlV4NVJMVnla?=
 =?utf-8?B?aFU2VGo2NGFjNGtVcHg4dXZCaEJpYW85QUp6QnJEWFZocE54NXk1NFBCTUh6?=
 =?utf-8?B?RHltQ09QRkZuWVFWdE5zT25lWXRXbFNORFhFSC8rUC9PZEJRTjdkV2c0RWhj?=
 =?utf-8?B?b1ZuKytFdW5maCtXaTVzek9mYy9TK0xLUENNblhwM3c3UUJ5YWo5ZU1xVkcv?=
 =?utf-8?B?dTRJeE5DeklXekpMWitjWlVxaDBRM0dwcmFLN0trSTNCdFI2Q0Z1Y3FiSW8r?=
 =?utf-8?B?YUxEZlBVRFZMOUt6eE1UZTFLMnN5Z0tTaFVaSlBjaEQ0VGRIZHZxakNodUFu?=
 =?utf-8?B?Z0Q3M21hejNOK0dxeXVNb0dPNksxV29YMFR5NSsvUllPVDRhV2d4Qm9zYWp2?=
 =?utf-8?B?OVdMN05PK0Mrb3lScFdLcmZhSFBLWTNlUUwyQmpqeE0xdUdESkh5VWI2NC9Q?=
 =?utf-8?B?ZmxkcmdsR2JDV2s4OVBzVHhHQ2hIMkFtc1ZwOFNOY3BIclJmTTVYNUJVM3d5?=
 =?utf-8?B?SGtNY2FNWWVSUkZTODRVUStBeXZpK0owRGptZE1VVmpXZHpydmMvV3YreE0r?=
 =?utf-8?B?RWJNRlJmNjlFbUtsMzYrbWV2Q2xkbUNrVHB4R3lQVnVCdE55aFpoTlZHQ1or?=
 =?utf-8?B?amg1K1JScEo0ZW85UHVpTWZjTW9UMEd5aTYyT1ZJRjJIOGZKWERqME9FMGhP?=
 =?utf-8?B?bzdtRkdlRUMvUlAzNFovWFRuekp0N0F1K0o0akxCU2g3UDYzTy9WUlV6b2Iz?=
 =?utf-8?B?akpkNk1CMDEwZngxOVh3NE5jZk9za2RZa2VxRzk5MXU2eUk2VUxTMWlabmRL?=
 =?utf-8?B?NE9aNUVtMnFraHQ1b2c5S2U5cFdvUWsxa3UvRGo5c1ljaTJTb0xFNm0zd2V3?=
 =?utf-8?B?Tlp5RVFsQ3EvY0xzbjJYeUtRY3Zlb092ckF0VVFkSnJSNWUxeWtPdVpGcnZL?=
 =?utf-8?B?T2J3MWNvY1BLTFNXVnZOSVE0UkVUVmpLMmt2L1JmK0Y5dlo0clUzUVUvZG9Y?=
 =?utf-8?B?NXAwcjFmelpaaGV0ejgzMG9nNlNRNVBIN3NENUNXWm9ER29tOTlETWZralFy?=
 =?utf-8?Q?etEL/+7drPHsn+yl3HCzqNs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGZ1MzhmVU5na2JtSVVJRkNqQWFlRHlYc2EwNjdWN0RIYWxiaWNTWSs5NDdW?=
 =?utf-8?B?NnhyNlE4Z3VZeUE1UWZ0elZoWmsxVGxIMWN5MGRJSWNPUC9na0h3akZQR0pI?=
 =?utf-8?B?NjRTVGlKdDFtZ0xLV3lzbEsyMXEwcUFpamFoQ1ZHRDJhZmJWMi9TTTJ5bHJs?=
 =?utf-8?B?dDNwWW02VnRhV0hIc1VBbjdkZjFvZGIxdm1MWnFDWHBMZ0NsU3pMZVR3R2Ni?=
 =?utf-8?B?ZXlxVkwwVmJVVW5oeEx1WjY2dGJlQUp5SkRqRnNnZEdTMWZCVytaZnZTVEhY?=
 =?utf-8?B?T3ZXOWMrNVJ2ZXBXVytENzFnczJTelhtajZ6U0ZyUDIyd0FtcGlwTG1aY2Fu?=
 =?utf-8?B?NS8zSkVEOFZEa2FZRUtzUXhRSEx6QXN5dFFhSmQxUGxKY1ZjNHNRYS84ay9M?=
 =?utf-8?B?dUJPZGlCNjk2SWNGbXRFS3VBdzhuRjF6cnJIODhBSmVURGFrT1VQeGlvN0xy?=
 =?utf-8?B?TU5ZNzRwREJwcjhJckMyM05iUGJaR0YyZzFFejZmdTFBVWRSUmthQS9CSm9a?=
 =?utf-8?B?c09EMHNBd2pjYmw4V1lmeWg3NUsvQXJzVmpaQ2Y3LzdTQkxNRld0YVdQUlk3?=
 =?utf-8?B?OFhzNllLeXVUeUZpMVBQTE9SSEZoN3JjdVBBM3hMaG13TDQ1cThYWGlDV1Bx?=
 =?utf-8?B?bUlGVTBFZ1pVbFdlUWx4R1BBREtFb1h6eXJhRGlwZnJGK2hvWFY1SUxNTEh4?=
 =?utf-8?B?VzdiN1ozVHJsTFI2bjM4L0dZNnkybWoyU3F2dTRINVIwTng5b3hRL1RSaER1?=
 =?utf-8?B?MmhrNUx1TDJENVZ4K3duaW40a2E2QkxHd0I3bmFxSGxwSy90cnZUV3gwaHNV?=
 =?utf-8?B?eUFaN092VThYOU1GUnlPMG1CMi9RZTJyY1FBS2Mza2ZzTW93cHlKbDlQYnhl?=
 =?utf-8?B?U0hsa29DR0Z4TUxocmJ4QUNwdENEakpMZGVNM2Y5TGMyRDYyeElmUXpWb01Y?=
 =?utf-8?B?QmhwcVdOakFPMllrU2VQZ2dENVY0VFppbUQzQ0FreTZVQ2xER1pqemVHckVX?=
 =?utf-8?B?WXFZTWs5c1pzTVFNeWlaOVppem1veVVGenl4REZ4dTdrUjF2NndadWs1anJY?=
 =?utf-8?B?SHYreDl2TEdvUDBKRUUzakVQL3B3alJ5dERGc3RaemRwakZIcWZRb0kzN3Bk?=
 =?utf-8?B?QWpscjJzdWNiV3YvTTIvaXVjTjhLTElYbHBEc2Vhc052enZ6UXhWZ29iUkFQ?=
 =?utf-8?B?WmF1UFllTFlxMytYZDQwa01qSjcyWW90V2RkUHNrZHcycEZQdUcvR0w3dGRG?=
 =?utf-8?B?WG5kL01JT2VMMytRVTNhdy81UU0zWHdNOVRiNnRPRDhiaUdjZVJ6K3RUK3pP?=
 =?utf-8?B?Zzl2ajYvNmw1SHRLamQ3cGE1YTZ2NkNOMjU4MkYzaS9qNXdFcDdVRmpCdUgw?=
 =?utf-8?B?YVI2bThKNXM3VThORnozRFdFcjk4L1JJZC9JK04xN3FyaEh3bTUxdzVDZ3kv?=
 =?utf-8?B?Q1RvZ1hIQkhoUTBYbHJBbm1qeDhFM3lNV1lMT1hVYU1FdS9Kd2hCaEFlTFZi?=
 =?utf-8?B?VUl1OHJ3a0ZyNWwwMzZoUW8xNE9xazEzcUI5d2RJN1hxOFZiRkZuRFVSUGRE?=
 =?utf-8?B?djFPY3Q0aklES0JnU1g4Z2x5UEVLSXBNK1VSSWdZZWl3RUxpeHRkTlRxR3RG?=
 =?utf-8?B?SVhmUmtlQnBLeW1zUEI1cmg4VklGandJbTZMYk9yMHR0R1V0d0tCV2NEanBu?=
 =?utf-8?B?clNnanU5NDFERFZFWXZkQkZTVThnM2N4UnYrUlQ4TzNWL2JiN0ZpaHY4WU5p?=
 =?utf-8?B?d0xPblM1VktYZnZyUVA1L2RWNVBoZnFqc2w0bjBaRExpTjhwM0h1ZGlRM2Zh?=
 =?utf-8?B?WWNvZ0FsZkN0NlhBUTdSS2V5TGhIWDVaQVJVVDVWSkFaQ1loNDNzUkxBd1h1?=
 =?utf-8?B?SUVvWVBuUm9VdllUZUVOOEZJOTEyZzZOM3B3VVNabG15bzNIMUx3SXRIOVRJ?=
 =?utf-8?B?cjRjWGc3ZVMxU2tldlRPT1JBWERzSDJZNExJOUV1bFk3cUdPcUQrVElaMGVv?=
 =?utf-8?B?OUdLZ2hpdmRndU16TnMwczgwU1o4L1pTdUZIb3E2eEt6Z3VmY1ZkbmZPeXY4?=
 =?utf-8?B?eFU5NVBqNkk5bVR5MTNEVGpqQzY4QWY2K3pnTEc2WnlNOU41cGpHa0xTbklB?=
 =?utf-8?B?YnpybkxVL1hQd09ET2o5SHhDSXJybDdZRnhIaFZWWjNhQktEcjFIbW9rcm9m?=
 =?utf-8?B?ZXptcXV2UC9FQm5Id29jY2lRK05TLzJ1WFU1WDdBbXJpN0k3SXVBc0t6bTh3?=
 =?utf-8?B?cGlHcm1qeE1RRWZUb2IrM05oRWIzUXMzVjQ1ZC9abWhVbUc0aG5xTUtiTEdD?=
 =?utf-8?B?QlNoQTlLeWlCOC9MbWtVUnNRQzdBWG8zekZoU2MzRkswajhQV21XaEZxUys1?=
 =?utf-8?Q?GsxhQFLS6s6i2UT4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84b5c84-7d00-4175-1fd9-08de55423807
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 21:00:02.8965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /UPjj5pdMWwbUtei9Nb5clJRaFR1rf/SqciVTWS4TS8Kq6yKRLBMmNlkqL9se4Yqv2VSMFzSjMDQg2LSDBl9XNi69z0UeMODT+qlkQsZNxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12465

SGkgQ2xhdWRpdSwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IGNsYXVkaXUgYmV6bmVhIDxjbGF1ZGl1LmJlem5lYUB0dXhv
bi5kZXY+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDE1LCAyMDI2IDI6MTMgUE0NCj4gVG86
IEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNvbT47IENsYXVkaXUgQmV6
bmVhDQo+IDxjbGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT47IGxwaWVyYWxpc2lAa2Vy
bmVsLm9yZzsNCj4ga3dpbGN6eW5za2lAa2VybmVsLm9yZzsgbWFuaUBrZXJuZWwub3JnOyBnZWVy
dCtyZW5lc2FzQGdsaWRlci5iZTsNCj4ga3J6aytkdEBrZXJuZWwub3JnDQo+IENjOiByb2JoQGtl
cm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207IGNvbm9yK2R0QGtlcm5lbC5vcmc7IG1hZ251
cy5kYW1tDQo+IDxtYWdudXMuZGFtbUBnbWFpbC5jb20+OyBCaWp1IERhcyA8YmlqdS5kYXMuanpA
YnAucmVuZXNhcy5jb20+OyBsaW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtcmVu
ZXNhcy1zb2NAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsNCj4gam9obi5tYWRpZXVAZ21haWwuY29tDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMDEvMTZdIFBDSTogcnpnM3MtaG9zdDogRml4IHJlc2V0IGhhbmRs
aW5nIGluIHByb2JlDQo+IGVycm9yIHBhdGgNCj4gDQo+IEhpLCBKb2huLA0KPiANCj4gT24gMS8x
NC8yNiAxNzozMywgSm9obiBNYWRpZXUgd3JvdGU6DQo+ID4gRml4IGluY29ycmVjdCByZXNldF9j
b250cm9sX2J1bGtfZGVhc3NlcnQoKSBjYWxsIGluIHRoZSBwcm9iZSBlcnJvcg0KPiA+IHBhdGgu
IFdoZW4gdW53aW5kaW5nIGZyb20gYSBmYWlsZWQgcGNpX2hvc3RfcHJvYmUoKSwgdGhlIGNvbmZp
Z3VyYXRpb24NCj4gPiByZXNldHMgc2hvdWxkIGJlIGFzc2VydGVkIHRvIHJlc3RvcmUgdGhlIGhh
cmR3YXJlIHRvIGl0cyBpbml0aWFsDQo+ID4gc3RhdGUsIG5vdCBkZWFzc2VydGVkIGFnYWluLg0K
PiA+DQo+ID4gRml4ZXM6IDdlZjUwMmZiMzViMiAoIlBDSTogcnpnM3MtaG9zdDogQWRkIFJlbmVz
YXMgUlovRzNTIFNvQyBob3N0DQo+ID4gZHJpdmVyIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2hu
IE1hZGlldSA8am9obi5tYWRpZXUueGFAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtcnpnM3MtaG9zdC5jIHwgMiArLQ0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXJ6ZzNzLWhvc3QuYw0KPiA+IGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXJ6ZzNzLWhvc3QuYw0KPiA+IGluZGV4IDVhYTU4
NjM4OTAzZi4uYzEwNTNmOTViYzk1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS1yemczcy1ob3N0LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaWUtcnpnM3MtaG9zdC5jDQo+ID4gQEAgLTE1ODgsNyArMTU4OCw3IEBAIHN0YXRpYyBpbnQg
cnpnM3NfcGNpZV9wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4N
Cj4gPiAgIGhvc3RfcHJvYmVfdGVhcmRvd246DQo+ID4gICAJcnpnM3NfcGNpZV90ZWFyZG93bl9p
cnFkb21haW4oaG9zdCk7DQo+ID4gLQlyZXNldF9jb250cm9sX2J1bGtfZGVhc3NlcnQoaG9zdC0+
ZGF0YS0+bnVtX2NmZ19yZXNldHMsDQo+ID4gKwlyZXNldF9jb250cm9sX2J1bGtfYXNzZXJ0KGhv
c3QtPmRhdGEtPm51bV9jZmdfcmVzZXRzLA0KPiA+ICAgCQkJCSAgICBob3N0LT5jZmdfcmVzZXRz
KTsNCj4gDQo+IFRoaXMgbm93IGZpdHMgb24gYW4gODAgY2hhcnMgbGluZSwgY291bGQgeW91IHBs
ZWFzZSB1cGRhdGUgaXQgbGlrZToNCj4gDQo+IAlyZXNldF9jb250cm9sX2J1bGtfYXNzZXJ0KGhv
c3QtPmRhdGEtPm51bV9jZmdfcmVzZXRzLCBob3N0LQ0KPiA+Y2ZnX3Jlc2V0cyk7DQo+IA0KDQpJ
dCdzIHByZWNpc2VseSA4MSBjaGFycyBpbiB0b3RhbCwgYnV0IGZvciBhIGJldHRlciByZWFkYWJp
bGl0eSwNCkknbGwgZG8gaXQgeW91ciB3YXkgaW4gdjIuDQoNClJlZ2FyZHMsDQpKb2huDQoNCj4g
VGhhbmsgeW91LA0KPiBDbGF1ZGl1DQo=


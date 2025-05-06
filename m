Return-Path: <linux-pci+bounces-27301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B106AAD0E8
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 00:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709D41BC656A
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 22:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619E4218AA3;
	Tue,  6 May 2025 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PhZkAehQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="v0cmm/2K"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57AE157A6B;
	Tue,  6 May 2025 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570278; cv=fail; b=MXTFq2Iq547WDQ7buQ/L6SGa9Zih/Jti3I1CWn266Ql4hJXYZSKKvJD79TJEoUaO/HAZCN48IP42CwkEIDH3xl2ZMX7/yMeIsbCs+Bcl7QZKTAyd2mG9h0+lZEnp6+nNyb18UwwykFXwaGb2GzaE/ht3B4i/KybR5c8Yh89+Bhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570278; c=relaxed/simple;
	bh=sAVUd2kor5f883ok1nTzMm9z4/a0ck/Mm5LqQLvi/I4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KWzeADiwkSQviDqXPcS3JxPAk5W7L5tBPlkYXGpg2D/T2qVMRTzviALwien+TefmppDLEtcWwzf3d5+0JvH/9NpoDtzOZlTYYJmU+/PoF57W5sQ8CMqTU8X9Fmnvwm04z8owoqX++xsY2v5dzR2xLmRGwCvg9VzX/LQeR1lLsTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PhZkAehQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=v0cmm/2K; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746570276; x=1778106276;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sAVUd2kor5f883ok1nTzMm9z4/a0ck/Mm5LqQLvi/I4=;
  b=PhZkAehQhY9OzbpuV3/fuG41lGIsCCwUJcOM8/qNsggMh95MggyZh0+v
   BQ4MkkMzR6m7KLJGEgYOOKxSIuL86QIGFOMNmSArd11StwfiwrDIXwjzz
   I1lARzmv1GzlaI2SztAhwsFE6Li1fuJVeeRtYW4cPb28XY3NXbUGrOBm7
   S72mtktexc7uHGvK13ib8DjWIBbUb+A9YUWuvkbJzkQbTwcoLVet0omZe
   8gBzpryLMeWMsxV1uWsJ0BTmshFhsWQ3JMbHx95WLD3cNiRER5BpuAZo3
   UJCoFOdGxv5Mq4Makl82mep2QdBHm5qkSw2MF6gusRXBNQxNUKfIahrio
   g==;
X-CSE-ConnectionGUID: stGN3GJGTSujqRp60zDjmg==
X-CSE-MsgGUID: FBy0ghu5SgmUVHAEtOCPrA==
X-IronPort-AV: E=Sophos;i="6.15,267,1739808000"; 
   d="scan'208";a="78993124"
Received: from mail-westus2azlp17010004.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([40.93.10.4])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2025 06:24:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LB5bcmQ8X8LnLDHGgfgt6ynAkkaojXsDnYpatNr6uVbdUyGDNwhqG2JlFhFOgVpWkA+cNkawHm/tM4EpIFE8/zIEt3UHtnEFd/EAO66PB1cqYbpgLmIDBff5YJlXsa8RLiAxCuWLN4BJLPugo5rHBz/uMplfF/nxluU9L3TCElcayU72R19z60p5UtE56fKIifv3sKUP/r/6Pj6WMaJy0LLoduggKqq4gh05ARJvfpmv6V02BlKdk6AxrGOkP9R1KgNAPCEcUCpsDf52eJ7EjAqL9GPjW1iD0IfcgGhp1rNcl6GhU4WYUx02hsvYuO+pGqlxwMcJ6ZQ3qX6LUJaXdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAVUd2kor5f883ok1nTzMm9z4/a0ck/Mm5LqQLvi/I4=;
 b=SIvYA5zx7Mtdjwwo2I914PE5Cs4P6l/G5p2VRWWYX9ujNQUd3JQMzcBYD1R+u5NCucStBHPsJVO4RxQNWd4HUetvPCOoHULXAdAklvpxi+Xqq5hgb/geG7nYQJyQf0xf24jFbzfOPL/ApHAyUzLHCvl52zX6qtYnP5t2UAbA0vcBbBA067ul6NrjXWM1/+kr2rF7cggfBREbSBQYw3APY1OJBsS1eR5fjcezRFtXkNcu0dHVd5UH3Ws6IHO/TYGR9j1tV5ZfOVt8WaJ9u6FO1Xnk5lqHPObKHHQnyN0X5phqs/kIUmVWYtLk/0zIFi12HDhvXgk4EAYtyQyquMEjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAVUd2kor5f883ok1nTzMm9z4/a0ck/Mm5LqQLvi/I4=;
 b=v0cmm/2KXx6q/kc6qCTO0Kx5gsn/AlSSCZto6KOxDRQ2JF0/0D28UiGQC1UrP5olDAuruyUxHSW+ar62pRnPYHvs2M3vuHmLc0QUmq0Phhiy1V/AW+3Lw9weAlNH+meFXGebqP0eF1HQnBq8F7dJiujEuMJGQ4FGCUNp8knxF8Q=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by DM6PR04MB6729.namprd04.prod.outlook.com (2603:10b6:5:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 6 May
 2025 22:24:23 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.8699.031; Tue, 6 May 2025
 22:24:23 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "cassel@kernel.org"
	<cassel@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "quic_krichai@quicinc.com"
	<quic_krichai@quicinc.com>
CC: "kwilczynski@kernel.org" <kwilczynski@kernel.org>, "laszlo.fiat@proton.me"
	<laszlo.fiat@proton.me>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "dlemoal@kernel.org" <dlemoal@kernel.org>,
	"18255117159@163.com" <18255117159@163.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] PCI: qcom: Do not enumerate bus before endpoint
 devices are ready
Thread-Topic: [PATCH v2 2/4] PCI: qcom: Do not enumerate bus before endpoint
 devices are ready
Thread-Index: AQHbvloT+D9g5SLVVkygtNGzMqXzYrPGLoiA
Date: Tue, 6 May 2025 22:24:23 +0000
Message-ID: <5d374521cc4d8599ab6b5eea1d44ef05e9340835.camel@wdc.com>
References: <20250506073934.433176-6-cassel@kernel.org>
	 <20250506073934.433176-8-cassel@kernel.org>
In-Reply-To: <20250506073934.433176-8-cassel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|DM6PR04MB6729:EE_
x-ms-office365-filtering-correlation-id: a2f01870-78d2-4c61-44b3-08dd8cecc13c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S1BCelVidXNKZFRnWlppdzlmVlNxT0cxMDVyTjUvRkNWMXNaSjZCT3lHMWU4?=
 =?utf-8?B?L2ZHd1ZueTFFMWlvYlNMSkVSNnNuYmljV2tjSkJxdmx2WmVhdS9iQm1Da0xk?=
 =?utf-8?B?c1cxRHdvcVlhTGVGRVlBYmhrYXFJUW9qOWoxT2QrZW5lMEorRlVQenhtZ2Jx?=
 =?utf-8?B?cjdqaWVLeGlzbkZpNEpJbTNUNTNaT0NxdiszUHhiaTVEMUZibGFXN0M3NXh6?=
 =?utf-8?B?SEZ2cy9oN244aW8zL21TMDUwNDFqV05LY254bHFwd0xVM3luTm8zdWRpMis3?=
 =?utf-8?B?ZDJpMVFiVDJYOU9JUXJoeXM3MnpBcmlUaFFwTUgwOVJqTkdkbThUNTlBQk5i?=
 =?utf-8?B?ZkFDSzNya01GQzJ4UExERFNkVTZOTlorYkhncmhKVjh5dlFsTkVneE5Sc1Z2?=
 =?utf-8?B?NEVoWnRtaFJZanpZejRsWjdKKy9Rb3NkVGdQMFpXUlhwQVU3akdqdEpVMUNy?=
 =?utf-8?B?eW14L3RUYWNxbFg1UGVoY3A2dmlVZkhVSzBsZEE4VjdVYXZ2YU0rRkNzekhX?=
 =?utf-8?B?NnNYcmM0THJCQndzRUZVdUtPczdiZU1CUldFY09nOWZuY09mMkV4TDMwc243?=
 =?utf-8?B?b2p5YXRvbzFqeWFGTW15MkxDNURyS21kbWN2V2FsZE4xUkdKOEVwOWdlK0RX?=
 =?utf-8?B?T3c5QlRKMUhGVU1UbDJRa2ZhSFFwUEtraFJWeEsrOGY4Mk9CanJBVWk0UWRs?=
 =?utf-8?B?T1IvSXg5d3h3T01kYXQvTENrOFlOTi96Y21Yekx3azVrYmVlaDByVUZBanFu?=
 =?utf-8?B?enlUeDQydXd4S3Y5S0hWaVRGcmtkRG5FOW53UHU3bXZ0aTBBWnVLb0ZEL2lj?=
 =?utf-8?B?Y20vcFNQc29HdnBHQkRMOEpQZk5pbkdDYW8vcUV3Vzk0eElvSVcyMllPWEZa?=
 =?utf-8?B?Qlhud3Z4eEdGckpsNnppOERqQkhZTEtMZG0xb0N5cUFzYVlZbFNKOFY1b1c3?=
 =?utf-8?B?amFjZ3phSE0yS011QnEyS3YzQ1piLzI3VkxzazFSaStRaS9rTW9TREtjU3Vr?=
 =?utf-8?B?aG1OY3ZDczFQRVFUa05tTlpLaUZYMDRLRCtYWFhzM0FYUDh3TGhtakFoOXZa?=
 =?utf-8?B?NndzNlNIMlN6WUpPc3YwaFg5WWpYY1JLYlF6SkFBSE04ODhtL2EwcnZFNVRF?=
 =?utf-8?B?WnpOZ3hmU0wyRTdMQmRxS2Z5YjY0WFZIajl5NzlsVW1IREhTL0txemxTVGh4?=
 =?utf-8?B?U0tldm9xcFZXb0dJSG1LanFHTldhekhpU2tSUTNQRVl5UkMxaHRBSTdHWkhP?=
 =?utf-8?B?cklLS3d4aXFtcDVkc0kzck9Ma2NIdzB0KzFHeWxVV24vMHBKSjNsanVyQ0xN?=
 =?utf-8?B?YnI4L3JrUHFNV3UyNUxNdENXMlhmQmtlUGIrSzNRdE51KzBleXdObzY2UUFo?=
 =?utf-8?B?Nk1MR1BMUmNSdjVnVzdFN3FYTHZ1TWdzTVhvcXpDYlh0MUs0WEoybUl5bGNX?=
 =?utf-8?B?Z3Q3RjRoNHpXZFJwYk05MnhGY3h1bFM3MEc5VHRCWFdJRkozMkxZd2oxWEFM?=
 =?utf-8?B?VFBGMVVxZzN0OStUU0dDY3VmK2VWRjRKdGlPSnRoUzhvUlBRWjRYVVZhcVVK?=
 =?utf-8?B?WmFoVDA4RUZoa1NtYkcwdm80TTRlaFpqRFZ6YVFNb0hZSjRKL1FVcEFSYlpo?=
 =?utf-8?B?RkVNTWJLc0FVZGRySkNSNTFveFpyZWJCTlFPSjdxcXRGNGpFbGM2QXFVYzRn?=
 =?utf-8?B?RHNhd2x4R1NQWU5UcEdlQ1NzT2Zzak9MQmFXdmF0QkJOQkpPb1VKeWpFNVd4?=
 =?utf-8?B?OURHOHZrcVNrc0swakxlRFlGVFJIVXQzc0cyY2hBU2pGVmtBV0RabFprc3N3?=
 =?utf-8?B?N0dlQWdETUtPbnc1OHBiVnRtckxiUC9iSytSYmgvVzN1MHluOGZoY2FlUE1x?=
 =?utf-8?B?ZkV2YzNYeHEraXhoTGdrZjFXMDVyelgyNDVqVUowbHpqY2oxV2huV01UbW5l?=
 =?utf-8?B?TVR5NThjTVBCWS9walA5NU9ydEt6bU1QRHpyLzV5eFdETHJMaDUxS29Ob25n?=
 =?utf-8?B?ZG5lNUFxLytnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWdQaklaUm5ueUE5TDUyM0MxZ3ZZT0ZFV1QrenF6bXZjMjZvMFljZjV3WExD?=
 =?utf-8?B?TzhZdk54eUI2OGJVa0dnSmF5SzdMQjVydWpiSDJCa1ZadDBVMDF2V1p0UzYw?=
 =?utf-8?B?Z2ZLVGV6WnV4cHJyK3F5VE0wejFJYmxPZUlEQkFHUFljdmhrMkIraGkvQnRQ?=
 =?utf-8?B?bjlSTGV6dDZ1OE1QWGh3N1hyejdLZjlzZmVxM0w4YTFaVzFjcUZRYmZsMzFr?=
 =?utf-8?B?Qk8wTERFcGQzUFZQQS9VcXZGT3dUcDZUQ0g0MFB2ZEo3NmR1bXJhL1dyRHkw?=
 =?utf-8?B?Y0gzNVRNRUhYbWRyTFhwS0MvNmpaSmxIempOUHBEOHRXV1BFZE9Ia29wRnBq?=
 =?utf-8?B?ZkZ3aUVlVUJIKzFicmtPeW0zdmlIWjhTZ05tTlhtS3FnUytleVlhalNpd3Rl?=
 =?utf-8?B?Mzg5bnMxdEZlaUYrNkhnZzh1YXI5LzltcVRvcGpyVXNQSzVYaXJiVmVTWWlU?=
 =?utf-8?B?MWpGZzB1QjcxSUJtSU96dXd3Y2R4V3FvVHFOUVNPMEQrWmVOTkZEemJxZjFN?=
 =?utf-8?B?TUVEZmdDaXpadmNFc0ZSUUZ6YXhIVE5LTHl0THpzclJzdzFNMkp0MEtCanY0?=
 =?utf-8?B?SlAwMFpJOW5XaDRwMDFQN1lmTWZUQVB6YXVsVCtvYWl0WDRyUWdkY05WRWFa?=
 =?utf-8?B?RDhBMXlDNDNUeElMZlMrd0laZ3VqYWl3TTZqQzlKMFprK1dyakRGU21xWVNP?=
 =?utf-8?B?MGlXTzRpRmNNaVkySzhTa1FDdjZMN0doMjRVNW1BamNmRUFheUpmUWI3RVR3?=
 =?utf-8?B?LzBqV3JUOU9KTlM3bkhCbW9IRWttMFAwVjVDRzdGWmMzS3JxNEgvdzdhR1pR?=
 =?utf-8?B?eDRMd1ErUzR4UWw3Y2wyaHRFQlhGNmprQ0xrMk0wRmJLdnJvYzRuUHQ0RVB3?=
 =?utf-8?B?L0ZmVER6RGNxc0g0c0s4TGRRTTNTRGlKWlViMVkzSTFkNU1OVW5FbThreGpi?=
 =?utf-8?B?U1hnbkM3UUJIWTVudjlkVjJmZXNVMGFtbkV1LzZmaEJURWdBYzBxdm9jbDdL?=
 =?utf-8?B?U2FnemJWcWxLd3ZFbThVOE5MeS9jblorM0Y5YXloUDdUSUJIWnV4aVc2MDkw?=
 =?utf-8?B?bUFiclpienBwbmJISmR1MGVQcEpYcEZ1ZzlYcjlETzlKZm5ld2VwRTJZUzUr?=
 =?utf-8?B?cVRKejhYVVJNdHhLZUJUMUExeU8ydTJMY1NZd2w3VUZNS0xldnNJMVhucUR5?=
 =?utf-8?B?WTZqbEIvVDI3WmkzY2pJWGg3Y2JlU2pHN2ZOTmFkYUJ3QkJJblEwZXFFajJG?=
 =?utf-8?B?RDRxQTdwN3VSYy8zbk9LRENqZ2o2cUp5ZlIyNzdMRzlrUVdic3U5TThtbThE?=
 =?utf-8?B?R1UwMU82RVZsaERyY0V1bm5RUjdmTWRIazNDZVZHYURUTHdHTUZIQXY2NlFV?=
 =?utf-8?B?cFAzK3BjRWRoRjJYZ29zV0c2cEtYV1k5ZUtBbit6QXArSEIzTktuQUF0V0U4?=
 =?utf-8?B?WSt0bHk2cVFoUXBnK3dKejdSc29pQWhuTnd4WHlpYWxjcnhLYi9mcjN4RGk2?=
 =?utf-8?B?Qk45cStsTmJwL2VweVFUc3p6MEsyemk2KytjR25BNk51RklGUXRPaEhhZDZQ?=
 =?utf-8?B?eVBWZUZQU1F6dXJySThhNTlwK0l3OXIyOGF0aUt3QTJVaG1NTFFUelkveGND?=
 =?utf-8?B?VWhHQms4azZ5ekRtODNDVml2YnhoemdYOEM3Z3pXVkpwT2gwa3ZiWGZLbGpH?=
 =?utf-8?B?SXRGdTFES25wcVlBM0N6MS96Q0tmVm1DbkJZN3dwY3NyclJDY01PdEpvbXJx?=
 =?utf-8?B?ZVZNczBsQ1BrenVzdlhvaFp0c1hiMmRUSHZ0ZDJJemwzK2lEbjh4SVYxRzBo?=
 =?utf-8?B?VFlPSEwvYUUveXhaRE1GWU90YjFLa0xvaVZYUWVlcjJsRjlqT0FkditwTGVt?=
 =?utf-8?B?RTZIWEo0UFVvekljVkpSdWRmckk1RGg4SURVYlJjeVVUdUNyNm5laitkaE8v?=
 =?utf-8?B?QUk4V2N2TTlZZ1ZzTVlwWVF3N0d1MzB6Ymc4TFd6WmZBejgyTTRLNStYRXFF?=
 =?utf-8?B?QWh3YW8rSk9wSE96MVFLdFdQYTFnM2czenE0UU1INy8rd0xZZUFhRG5LckNQ?=
 =?utf-8?B?MG11ZTJUTDR4WjZ2Q29PMFBKeHJFUkVzYWJVYXF3RTl2RGR1YS9PTE40bjM5?=
 =?utf-8?B?NExhMnEvekRJbjErN3ZuVjh4Smh2NmFVUGlJVjBJZzh2aVFGeW00S2g5Qjlv?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1CFCFBCA7A8C844AE5B669D78090376@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G1b99qgJv/MbHdmgzmUbCrJ6gnqhwGcRsFe5uxsg8OUN3eWlM5dKbBcOKtaRlInzGBCR6MNuU6eHtegcjOrfKv8fJw3yawpFjpDtWA2sqRAJZoR/zR9jRsOKOnJIiq3bGniGdaL8ex2qMnUFOs7IIGfaZHiQmC/eAdKc8EvYzOJg1E6a3BeR/ey/Wsvw2LGhbAM7003521pqdCijtUgGYbZcbvKszR4A6JLgbpkXJYdibZj2l0dMfUqba1z4C3VvfUGrN6YoEy6S05lnd5tX3wulYsr1L0qU83qSbGXcPMW7eGjA7O9PY3VD5tcRQtBaeKjQRj87pyAjC39wue+A5iJj7g5fQpZeURfJEFnjxJOu4KlDapQK6C0zAJva6JRLNTYYnYqYlpIDUtYaNCigy+Sfb0yNJDmg5NJULPcpZ1ThfEbAEvuUVaVyw7HCxxqsnC8GZ53WgBGagJbM9Bc1r7Ke295RFi4F93ndQ8unQdYGdGYapmgxXnVFcnWn8YGT2W9u+JDMTxjR7386SFMPwrzaN2PQtOheIg4BPQDLZC+PzYyPfYxHtxVuo1GAV8pki9xzkaaqwgKZf4iIxPKEeowwoP7rI0U3atf0KryW/hwaPY/WQNI9TOt08PKobHKw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f01870-78d2-4c61-44b3-08dd8cecc13c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 22:24:23.8127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F45kxATnCM3pTf1avVypKhqt5bxi+h10NxMVmwsv/hgP0F50lC0Up6wi6xXKak2sC7Bxr7JEeNF4/b6a2m1TzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6729

T24gVHVlLCAyMDI1LTA1LTA2IGF0IDA5OjM5ICswMjAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0K
PiBDb21taXQgMzY5NzFkNmM1YTlhICgiUENJOiBxY29tOiBEb24ndCB3YWl0IGZvciBsaW5rIGlm
IHdlIGNhbiBkZXRlY3QNCj4gTGluaw0KPiBVcCIpIGNoYW5nZWQgc28gdGhhdCB3ZSBubyBsb25n
ZXIgY2FsbCBkd19wY2llX3dhaXRfZm9yX2xpbmsoKSwgYW5kDQo+IGluc3RlYWQNCj4gZW51bWVy
YXRlIHRoZSBidXMgd2hlbiByZWNlaXZpbmcgYSBMaW5rIFVwIElSUS4NCj4gDQo+IEJlZm9yZSAz
Njk3MWQ2YzVhOWEsIHdlIGNhbGxlZCBkd19wY2llX3dhaXRfZm9yX2xpbmsoKSwgYW5kIGluIHRo
ZQ0KPiBmaXJzdA0KPiBpdGVyYXRpb24gb2YgdGhlIGxvb3AsIHRoZSBsaW5rIHdpbGwgbmV2ZXIg
YmUgdXAgKGJlY2F1c2UgdGhlIGxpbmsNCj4gd2FzIGp1c3QNCj4gc3RhcnRlZCksIGR3X3BjaWVf
d2FpdF9mb3JfbGluaygpIHdpbGwgdGhlbiBzbGVlcCBmb3INCj4gTElOS19XQUlUX1NMRUVQX01T
DQo+ICg5MCBtcyksIGJlZm9yZSB0cnlpbmcgYWdhaW4uDQo+IA0KPiBUaGlzIG1lYW5zIHRoYXQg
ZXZlbiBpZiBhIGRyaXZlciB3YXMgbWlzc2luZyBhDQo+IG1zbGVlcChQQ0lFX1RfUlJTX1JFQURZ
X01TKQ0KPiAoMTAwIG1zKSwgYmVjYXVzZSBvZiB0aGUgY2FsbCB0byBkd19wY2llX3dhaXRfZm9y
X2xpbmsoKSwgZW51bWVyYXRpbmcNCj4gdGhlDQo+IGJ1cyB3b3VsZCBlc3NlbnRpYWxseSBiZSBk
ZWxheWVkIGJ5IHRoYXQgdGltZSBhbnl3YXkgKGJlY2F1c2Ugb2YgdGhlDQo+IHNsZWVwDQo+IExJ
TktfV0FJVF9TTEVFUF9NUyAoOTAgbXMpKS4NCj4gDQo+IFdoaWxlIHdlIGNvdWxkIGFkZCB0aGUg
bXNsZWVwKFBDSUVfVF9SUlNfUkVBRFlfTVMpIGFmdGVyIGRlYXNzZXJ0aW5nDQo+IFBFUlNUDQo+
IChxY29tIGFscmVhZHkgaGFzIGFuIHVuY29uZGl0aW9uYWwgMSBtcyBzbGVlcCBhZnRlciBkZWFz
c2VydGluZw0KPiBQRVJTVCksDQo+IHRoYXQgd291bGQgZXNzZW50aWFsbHkgYnJpbmcgYmFjayBh
biB1bmNvbmRpdGlvbmFsIGRlbGF5IGR1cmluZyBwcm9iZQ0KPiAodGhlDQo+IHdob2xlIHJlYXNv
biB0byB1c2UgYSBMaW5rIFVwIElSUSB3YXMgdG8gYXZvaWQgYW4gdW5jb25kaXRpb25hbCBkZWxh
eQ0KPiBkdXJpbmcgcHJvYmUpLg0KPiANCj4gVGh1cywgYWRkIHRoZSBtc2xlZXAoUENJRV9UX1JS
U19SRUFEWV9NUykgYmVmb3JlIGVudW1lcmF0aW5nIHRoZSBidXMNCj4gaW4gdGhlDQo+IElSUSBo
YW5kbGVyLiBUaGlzIHdheSwgZm9yIHFjb20gU29DcyB0aGF0IGhhcyBhIGxpbmsgdXAgSVJRLCB3
ZSB3aWxsDQo+IG5vdA0KPiBoYXZlIGEgMTAwIG1zIHVuY29uZGl0aW9uYWwgZGVsYXkgZHVyaW5n
IGJvb3QgZm9yIHVucG9wdWxhdGVkIFBDSWUNCj4gc2xvdHMuDQo+IA0KPiBGaXhlczogMzY5NzFk
NmM1YTlhICgiUENJOiBxY29tOiBEb24ndCB3YWl0IGZvciBsaW5rIGlmIHdlIGNhbiBkZXRlY3QN
Cj4gTGluayBVcCIpDQo+IFNpZ25lZC1vZmYtYnk6IE5pa2xhcyBDYXNzZWwgPGNhc3NlbEBrZXJu
ZWwub3JnPg0KPiAtLS0NCj4gwqBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXFjb20u
YyB8IDEgKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5jDQo+IGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1xY29tLmMNCj4gaW5kZXggZGM5OGFlNjMzNjJkLi4w
MWE2MGQxZjM3MmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtcWNvbS5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5j
DQo+IEBAIC0xNTY1LDYgKzE1NjUsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QNCj4gcWNvbV9wY2ll
X2dsb2JhbF9pcnFfdGhyZWFkKGludCBpcnEsIHZvaWQgKmRhdGEpDQo+IMKgDQo+IMKgCWlmIChG
SUVMRF9HRVQoUEFSRl9JTlRfQUxMX0xJTktfVVAsIHN0YXR1cykpIHsNCj4gwqAJCWRldl9kYmco
ZGV2LCAiUmVjZWl2ZWQgTGluayB1cCBldmVudC4gU3RhcnRpbmcNCj4gZW51bWVyYXRpb24hXG4i
KTsNCj4gKwkJbXNsZWVwKFBDSUVfVF9SUlNfUkVBRFlfTVMpOw0KPiDCoAkJLyogUmVzY2FuIHRo
ZSBidXMgdG8gZW51bWVyYXRlIGVuZHBvaW50IGRldmljZXMgKi8NCj4gwqAJCXBjaV9sb2NrX3Jl
c2Nhbl9yZW1vdmUoKTsNCj4gwqAJCXBjaV9yZXNjYW5fYnVzKHBwLT5icmlkZ2UtPmJ1cyk7DQpS
ZXZpZXdlZC1ieTogV2lsZnJlZCBNYWxsYXdhIDx3aWxmcmVkLm1hbGxhd2FAd2RjLmNvbT4NCg==


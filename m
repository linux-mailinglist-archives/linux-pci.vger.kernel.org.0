Return-Path: <linux-pci+bounces-9497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA8A91D6EB
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 06:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A791F2137B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 04:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32B61FA5;
	Mon,  1 Jul 2024 04:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="jtVThnFz"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2046.outbound.protection.outlook.com [40.107.114.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C5F171AF;
	Mon,  1 Jul 2024 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719807040; cv=fail; b=Pa4g+LfnrKkLR1j/NyVLDEqp6ew2piUWONTTbYsCJofaDLp+itNtjh5ST9DG6+p253R7YgoGMv5DyTu5sPr5wV3bZ1dIPvDOa8UmksZGMfkBVIjX7PfQfaOSzvUVoaKIEoECSJsk09Ert7g0KGYCtJa1F020yjhyjqIV9ASbupE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719807040; c=relaxed/simple;
	bh=vvBuXZwA1VbyunZOYq8ikITCb6ioES8XtzbcRh/ufT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H8ecVfLF6rqs7qh0JX+f+la+d5f+AQWmm3XEy5aziDu5dIWkcJUa9BFOIlaiKTnXWQc+oI5RTTFIPjR+N89vgx9yTWak811CeNMyYGr25gUMzo6B9tETahajRouo0I8Eqylt9WLiRW2sZ4dT+h/Qs03ZPn/R9714imOtQRn1iJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=jtVThnFz; arc=fail smtp.client-ip=40.107.114.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neEvYcl9C7+e0DBQLjzXdq2HookxhaVwGW5dT4Cw1dS5u1kyFMgqOaeTRNXSCzFf4NhfUNE/yPqr5goBotgTctb5yK6GebbzYU1MwNS2DMOSJLZvUu6XnDHVloat10gdTyPkb4S8aooKQ07tSX7203e4ml8lZ/zdB2h/AExgmLiR3YhWjupLEmCXB5GAAffs+SbYknreBLd+38k9XnM8QU1xwJN/NpdULPyC2RRqDcWTzn0RRjV8+aSe2P7RApxXNt4jWY1nsQsNExy0ZFoip3sOHXPEw3ikl+TP40evPo+If3adi6uJkhJoa9Fh0Kc/xFoIWfeVa9WeZ0oMHv95Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvBuXZwA1VbyunZOYq8ikITCb6ioES8XtzbcRh/ufT4=;
 b=Y9n7wbsKcJYUrvL9klzyASVV67kmpmJ17EckgXR0MPXOHOsehHJ6cRmpt5fM9npsyiCK6Uxh1tS1TsA6F2GkxDm7/3o2GiizXiJ5Pw5CkVwg6GkVdAIPQIvxMMFdi+zOdt77Hc2KCzWXRUO3hfRHKdZC5PM2FhBKG5fme08TFMr+DZ6o9TFoHwML9B5IHzJzjImO44LL3lMhcF8u0oZgU1vQOuHh7QU8S889Ir+ILpUbkQRUYHqEAnuPLwtO9ISE2DorocJfwrjIAIkRJ1CB9jlsP8/PJbj25aBxhVSXOJ673L8l0xKZm6/2Ee/ZTx3aVrVz/F/rR/hwoSXILKvDvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvBuXZwA1VbyunZOYq8ikITCb6ioES8XtzbcRh/ufT4=;
 b=jtVThnFz66SCPgIaHiQYqJX9BURch0vN8Zp0WpAmBrDT2E/zclkMrsuZHPLbMdZjEO4o0Y7hZzxF836OIvth0M4SsTU9L8b53EA9UT9TcctIPLf6ccEquP95ThJru2yPOLqizjS0IFz5DWcswAgWSnMRA7hFcltwP/HxM0mm6U4=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by OS7PR01MB11682.jpnprd01.prod.outlook.com (2603:1096:604:244::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 04:10:36 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 04:10:35 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "mani@kernel.org"
	<mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v9 0/5] PCI: rcar-gen4: Add R-Car V4H support
Thread-Topic: [PATCH v9 0/5] PCI: rcar-gen4: Add R-Car V4H support
Thread-Index: AQHau/4H+pvFGTDHG0OY/yehxiZnUrHfR8UAgAALCQCAAg4GcA==
Date: Mon, 1 Jul 2024 04:10:35 +0000
Message-ID:
 <TYCPR01MB1104020A6F6F4FB896FEE717ED8D32@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240629200650.GD2249818@rocinante>
 <20240629204620.GA1482128@bhelgaas>
In-Reply-To: <20240629204620.GA1482128@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|OS7PR01MB11682:EE_
x-ms-office365-filtering-correlation-id: 63540290-7de6-4179-15ec-08dc9983c20e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dkkyVi9WQ1hrd0RLZ3FlbWJLRU93NXY5eXpkWDlpVXluYmdlTmZmSFkyaDND?=
 =?utf-8?B?YXhjemdwT1gyYUFtYlU2UlArK21YU0s2WXoya08rVC9MWTAyTkVSSnJBRkE0?=
 =?utf-8?B?S3dOTXRiZCtXWWZKT0UrTk5vbEpGUVJxc0k4K3BuZTU3ZjdiRGYyYVJBZXA1?=
 =?utf-8?B?UFVNVFpTc01hdUNIeDVpbjJSSXJEc2FobGIxVnROUnJCQm4rWFR2cmhkOXcw?=
 =?utf-8?B?NThodHBQdkVLSkRZcmFlb0Nzb1pBNVdIVml0WDk4UzRMTjErVnlncDJ4ZG5l?=
 =?utf-8?B?R0pBNTBXamwrNmJXV0FnOTMxcHRBaVdrTUk3VXNNaHFuYVk0WmEvZ1RWR3hv?=
 =?utf-8?B?aHN6RHI4NXhuR3JtdSs1bWlmVTlna1Z4Q1FvT0Y5S2lheUxrZEw3bW03eWRT?=
 =?utf-8?B?cDltem0rZXlPR0hVR0MzVDNpVk1jS1F5REQ5QUhmZ1hpZTl3ellFQnZkVDlE?=
 =?utf-8?B?bmd2ZUNjUzl3WFAwNXNIeFlJWURxL1dvMG1RMCsxZlNIYk0vR0VaRmxsY0lm?=
 =?utf-8?B?ZElCNzBKcjF2UmpPd1FQdVJDNnQ5SjVBU1VzQitlQ3lvZXY1MEJ6cmFjZUdO?=
 =?utf-8?B?NnNFcFpBTzArVi9rVVI0TVZSVnJBNHRxYW94OTVCUkpwYXVxMXB2dHoyRmRT?=
 =?utf-8?B?WVlFeFN3K2o1QWV6N2tuY0lkc1dyWjVsYTIyS0JWbFJlRjgxelRNMnA3SENX?=
 =?utf-8?B?TGJ2OEJFaStERVdKcE1qYmZYOUtlNlZtQ2FwdjVtVlpCSmRmMDFOUE9sc2ox?=
 =?utf-8?B?STU2ZWxrK25LZ21DOG4zeG1XOGJnY294OVd0TjFlenNIWG03TERkaXlKc3BH?=
 =?utf-8?B?QjFLNzk4TjZUajVIVkRrTkcwTUd4YVlzOFl0MUxCMUZjUm5QOUdFczJaVTdL?=
 =?utf-8?B?Rngxb0ZydGlsSkZkeFFsWGtLVys4UWlRam1iYUtuaHNtNXhWdnZsUVY3VnhZ?=
 =?utf-8?B?S280ZDFkY3pGOEFEQ3JTOWFhT0JDWDFQWFpHVGc3cXlveUtBVWJ3Wnl6OEVq?=
 =?utf-8?B?a0JmVkhKelAyWDdnemxFdmxWKzVpUnRjOFE5WUxvU0xQeW4xc0pPbk9CbUlD?=
 =?utf-8?B?ZElkYWNKMlZId21oaGNTRVE3Tjh3dW5LbVJBK0tRblZiUHNLbWx0OGRueXNC?=
 =?utf-8?B?QkoxL1hITDJLb2RHcHZuSGdKR1ROM3JybHk0c0pxRE1iM3ZQajdIUVp6VWN4?=
 =?utf-8?B?LzdUc2dRZEN1Rm52QjJiaXRYQTZENmxidEczOWZBMmhRcnlucDRyeW5Pa1kx?=
 =?utf-8?B?Um1MQWlzRzVEZG10ZFI0VDl3NGxPcHBsWkJlOEhjS3plKzVVQ1JBTkhicXZ4?=
 =?utf-8?B?OW1NREZYUm4zQkxVZ0ZDWml4elFXNElsdk1mVjJxZStBMUpVMWZHWng4Um9B?=
 =?utf-8?B?VzZXa1l2WGQxdS9RSXBOZnpIbnh0cGdrc3MvRWJicnF0T2NZd2Rad0xxSGRz?=
 =?utf-8?B?VDV2ak1LNEphUnhiM0UrMThSeHNCUXVDNTMzMnZmcXpvN1BXRldwMzNOYTRp?=
 =?utf-8?B?bGZwKzJ1RXJ4NGY3Q3Erb2I5Q1pYK3hSZkVWQkN2bExVMTZiZ0hOdGJxUCtk?=
 =?utf-8?B?NzJXNlZCblE3K3NYZjhSSk1QNjczWU95RDUwVGUxcU9jQkxIeXpWK1Q0WnhQ?=
 =?utf-8?B?dUIrbGZobHNlTUp3cm9sZ3dkeVFvY3dMZUFtRFFSK3dNWGJYbFlSUlVjOUhX?=
 =?utf-8?B?T2l6WFIwYjJGd2RrVUhXUmZBeU5laFAyUVBHSUhNbnFOYUVCYjFQNkNLdGxF?=
 =?utf-8?B?eTQyM0orcDVhQ1NVYWVHQ29JRUNmd2xnUXIzdHhVSlVxU0FBdXN3ZEZ1aG5p?=
 =?utf-8?Q?t3oCjhYbqPwfhoVVVFhoIuYrLNUZY7ubL7C+Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3NoeXpyRG1xaG1OUnU4Yi8wY0prWGQ1c0laeENuQ1FhQXJqYWN6bXhYRkJZ?=
 =?utf-8?B?dThWUGZIMWNwM01yaHVhd3FYOTNMSWs3NWVES3ovS1VWeUQ4OFIzUGtLRWc5?=
 =?utf-8?B?QzV1cDE1cWJGcGFGeGpXeThTdFN0M1A3eG5sbTlteVh4OVAxR09XOFljR21u?=
 =?utf-8?B?YzFob0IySjFXK1hWZ3RwSTlPaDczTHRiMUN6Unc3S29Eam9hdndNK1hnWmtD?=
 =?utf-8?B?QzFsWjlMNmpTdDNQZnR5ekJ6RnJjZE84TENSYlZPV3AxWnNSei9tckVmV1Rk?=
 =?utf-8?B?RWl4V0EyeFFoQkdYOUMyTlk3K2tsOHhNeVVrbk5PaklacXBBVnNJcC95bHU0?=
 =?utf-8?B?cHRPaGdORi84OUQxKzBIclFOeFBLZVBETGtQd0JyL2hWSDQzZTFVOTlvZ2FJ?=
 =?utf-8?B?N2hwTXJwc1FFM29najJBMzNZTU1ZQUc5ai9mZGkvbm1kVldjM2VNQVlPZHMr?=
 =?utf-8?B?dW82d3g1L1F5Ky9RK21HNCtNLytMekRoKzZPSWJWWnJGZFZTMWd2N29sUkQ5?=
 =?utf-8?B?cFNXdk5kUzFmMVFFOU5YZDZCQlJWWVB6Wk9aNGhZbDJXMzVTNmZuUzQyNkJv?=
 =?utf-8?B?SW1wTnNjUVZXMCtiMWVyVDNuRThDTXFzTGtmMjZSM3pLQzlucWxqVGZqZzYw?=
 =?utf-8?B?MWVzVGRmRUdhYjVvSGExS1hJbVdMYUhxMldoRDhwQ1M2UnpDWTN2V1VLL0lC?=
 =?utf-8?B?RXVZRGkxVjBuT1pMc0Y1L2M4aENpZlU4QWhpRTUydktNM29nNWUxWklnSHBQ?=
 =?utf-8?B?V1NWSW54ckxPdkNJYzkxQW9tTnFBNExBejJkcnowU0RiR0lGU0toWmF0MExw?=
 =?utf-8?B?UlVZNEVNdmppaDVxeFhjT2xJYUluV0dmQlZsUUszR3dSZnN3NElUL0dPODQx?=
 =?utf-8?B?dDUvNWxXVy95dHN6Nys4bGNEblBWemR1WUVpTDFNZjNCQ2pHbkZ5c1ovbW91?=
 =?utf-8?B?cWluZTMrT2EwSk5LSWpvcWpBcW1HSjNzU2V0QU9VaUEzekt6YlJHYk55Q2lx?=
 =?utf-8?B?UWo4cXFudlA5WTFJQW9hWHVuMlZZZlJ3TUdNYjlHbkxGNTBWQVBLd2x5S215?=
 =?utf-8?B?TWIwaWZJVS9TWHpvbjg0YklQTHFYcFZrNVROdFl6OW9ZTlJYcFMyWW1ZK001?=
 =?utf-8?B?eUd5ZmhtM2VsbWlvNGx1aERiR0tCTnI1KzRMTngzZytobWZWckIyZFF6dFlK?=
 =?utf-8?B?TTI1QXpwU0wyeHVnQTVDbWNIWE45Wm5Cd0ZEeHNsNlJCN2ZvbkVuK1QrQ0V6?=
 =?utf-8?B?OEpLTENNU0RXNTBaeUNWOG5UWWYvN2NFRHVGby9CdXVyZDJXU05nV1JaUU03?=
 =?utf-8?B?ODJRZjVXQlRROEV2Vmg1RkZuTFFVRGd2bURyMWNsclMrNTcrcGlhSk5Telc2?=
 =?utf-8?B?YlRzbVJOVll1WG1EbGt1MUpPN0pDaVAvZ1JXdGZXRk9jMVBSbnl2UUdTNGhj?=
 =?utf-8?B?cWdjOUNJM2ZRM0JQRHllZlB6cjhTZVI5a1VKcVlNd2pvMldoQkp2N0oxQnBw?=
 =?utf-8?B?Q1BpdXZsUHdvNHFmUWxVK1g5Ni85R1lNY0k5WXNjSS84WGlxbS9IRFZLeWFi?=
 =?utf-8?B?eVpPTFdFWmtPYlc3UHBoWE5DbDhjUi9Yb1IxNm1IcFRQTmdaanhVemNVTzVN?=
 =?utf-8?B?MVZNVzM0ZE9pd2JWWm5lVDBpb0FlZWFHaXJncnEyM01ScDAwVnArK1BBTU5q?=
 =?utf-8?B?ckZubnBjelJDQjVSMXR4Qmd4RGlBWm9EKy9SVmx4ejdPS091ZVBPT2RrMkI1?=
 =?utf-8?B?T2UyZWxMdGRhNnZ1eVlxS2wyQVh0WklXQy9PckJBVDJMQW8wRThsRXEwQXB0?=
 =?utf-8?B?VWhFaUxRVm1kYU02emxPMkUzby80MkJkSHBFK0dteWVnSG1OZ05IbExlMG9E?=
 =?utf-8?B?RTRpS1lLakRIV28zbmNBTklMeXVST1RPWWVEVFNKeHkyWVVjbHozd1dTTXFX?=
 =?utf-8?B?NjIyQm9tQ2xVV1crZ0NYRjVmTU9iakt0QzVLUWJzTGdEeVFPeS9zMm51aXMv?=
 =?utf-8?B?cUg2VkR4dC9RSDloUGlSV08rTXhkWkovZjFlZnZLTUhYVzdmQkRGdkNkazhN?=
 =?utf-8?B?clFnNzdtUTYyTW5vQ01BWXZ5YjM3YS9yNnJ2M1lTaWMrNWdmMGl3VjdpUkFt?=
 =?utf-8?B?cGxFSHpwOHhqdys2dm5sdU5tVWk5RTR0Q0E1UkQ0UWE0NnhPNVhxbktBeENV?=
 =?utf-8?B?R0F0Z2pPWW5veHcyVkpTVGNaVzd3TVFrWVpCWTZkL1pXZDZ4V1h1SElNdFlK?=
 =?utf-8?B?dWhtM0R3Y1RPTEJTRUlRemFDK2JnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11040.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63540290-7de6-4179-15ec-08dc9983c20e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 04:10:35.5217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8N9PeckpCpDeALTEel8UPmz5EXQNe04IwluRiDdhjvIAs9VKs0mN6TfcpuFTmbRtAUpEX/ca8dRFyAmLeUV0+a0bkvjyfDAO6B9X5GpUOzAcdVZ613wRQx/G67m6IsGa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11682

SGVsbG8gQmpvcm4sDQoNCj4gRnJvbTogQmpvcm4gSGVsZ2FhcywgU2VudDogU3VuZGF5LCBKdW5l
IDMwLCAyMDI0IDU6NDYgQU0NCj4gDQo+IE9uIFN1biwgSnVuIDMwLCAyMDI0IGF0IDA1OjA2OjUw
QU0gKzA5MDAsIEtyenlzenRvZiBXaWxjennFhHNraSB3cm90ZToNCj4gPiBIZWxsbywNCj4gPg0K
PiA+IFsuLi5dDQo+ID4gPiBBYm91dCB0aGUgZmlybXdhcmUgYmluYXJ5LCBwbGVhc2UgcmVmZXIg
dG8gdGhlIGZvbGxvd2luZyBwYXRjaA0KPiA+ID4gZGVzY2lycHRpb246DQo+ID4gPiAgIFBDSTog
cmNhci1nZW40OiBBZGQgc3VwcG9ydCBmb3IgcjhhNzc5ZzANCj4gPg0KPiA+IFRoaXMgcXVpdGUg
YSBzYWQgc3RhdGUgb2YgYWZmYWlycywgYW5kIHVzdWFsbHkgd291bGQgSSBvcHBvc2UgaW5jbHVk
aW5nDQo+ID4gZHJpdmVycyB0aGF0IHJlbHkgb24gY2xvc2VkIHByb3ByaWV0YXJ5IGZpcm13YXJl
IGJsb2JzIHRvIG9wZXJhdGUuICBUaGF0DQo+ID4gc2FpZCwgUmVuZXNhcyBpcyBub3QgcmVhbGx5
IHNldHRpbmcgYW55IHByZWNlZGVudCBoZXJlLCBzbyB3ZSB3aWxsIGxpdmUNCj4gPiB3aXRoIHRo
aXMuDQo+IA0KPiBXaGF0IGFyZSB0aGUgZXhpc3Rpbmcgc2ltaWxhciBzaXR1YXRpb25zPyAgSnVz
dCBmb3IgY3VyaW9zaXR5LCBJJ2QNCj4gbGlrZSB0byBrbm93IHdoYXQgcHJlY2VkZW50IHdlIGFy
ZSByZWx5aW5nIG9uIGhlcmUuDQoNCldvbGZyYW0gbWVudGlvbmVkIGl0IG9uIHByZXZpb3VzIGVt
YWlsIHRocmVhZCBbMV0uDQoNClsxXQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNp
LzUzc2ZrYXY0NWRqY2FhcHFrenNwczZvZnNpbmY1bG54YmhyanZnc2V2dDN3NnFjbXM2QGUydnB0
d3JqNjQ1cS8NCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0K


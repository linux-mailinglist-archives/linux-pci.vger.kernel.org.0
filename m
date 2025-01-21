Return-Path: <linux-pci+bounces-20195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C37A18053
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 15:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56683A3E37
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729251F2C47;
	Tue, 21 Jan 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="da0YGBJW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B0649641;
	Tue, 21 Jan 2025 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470915; cv=fail; b=lx72jWXsOgT18J6RjhJSEj1SMkavrddu87hFwuXQT8qG7gnL0bk7I9eTUOG8GS46Lqn3MfQ1v/3HPOOkQ37XbGR+BG7uTL/K9UP59g8oc4u8SXsWIKhHwPylPTdP8Oit36Q/cogkLR9Hv+qZLS2RmTQrDPZqG6nNICrhgiSLE6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470915; c=relaxed/simple;
	bh=SgoG3RTpL+v4kIGXIEN9St6gSv0oPlJyL99gHJ/IhUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HHSbO2ngny783hE97+7mFkL7gk8zLjO9tyEg2qPiyiYDDr9X/p8DdS25cXarXCB8y/TsB6AREUDePh7FAnlqsFzx40dGQ82YnJgfbKkmN9SM2X/4c2RPo8xPfpIASgvKooDbpiFw/6ao/F6H+jHlgW+hYrrisY7bd2h++5pTQ+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=da0YGBJW; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1J8ZqWnbLT9EVY0cKfXv1Bff/VfRLBtktodzGAYRz+qfqrXfz6GbEp/i/yx/+5YaKjYweHFwyII4qJclZXSuo3r9WAEFw7kH2RnObqoDxwXMUy3DGz4uang9QCtSSkbl+xRTLCJMo13Dth32jFUunEgilWu6ffsnySgs4exWwytNmZ6pezWmoKXawgfX1s0nQVPiGe0KXJbFg9VmxGm4m0M3jOsoBFL+1RSiwGY9tiVIWVzuVqk1SmvWTFEZddyazEFDXMTJ2unGTMo2qivh9va84yfpsYdHzGx5DKnZgvB+fMYwMcrD8egaKS8ZuGGtyj7IozK18xXlAsl/drlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgoG3RTpL+v4kIGXIEN9St6gSv0oPlJyL99gHJ/IhUo=;
 b=UUxLzMaLzcqWPZxomiGWRT7hqS+TrlphsshX0H8uFyRXjCXBmlN6i+uM1EzWT6eny7bdwFkKDIsywWEm3XNUJ+lRvZQ53LX37of/nvuR1mnMjDCbC+hEUdn82LG1tZuO348BcCLXSaaMtYW5cwQMDSc+B0bsiv0g4QT/n+nXtfiH/iVfM16iPou7TX3X0XhJn0dTePT7Rxijw/j6RDScpXJqXpJZrDSJZPgxCJRhb0bOQjFJ0kgPG5z3jLCGUwbGsIB2vAcdiUuH+wE1s7T/WtdKlkvGqPRRMVbaAK54j73pSE3xezuyyJa+vpUadPUQQr/V/sQ57VVMawheDHrxBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgoG3RTpL+v4kIGXIEN9St6gSv0oPlJyL99gHJ/IhUo=;
 b=da0YGBJWJ9F8+wW8oaq+m2wjOFJmiDCJn6dnTkM6ACP+JaYUuAsmlXmW5kbqYJntWKfCY1Wrap1OmFfNkbSmESBxEfR+8r+AmSKBanXdq+FVrXXtK/CIUrEh4jwdxlFp/DQ3QTnbOkjBYZ3vj6PxuUH0aongYL2IMi324fzwZ9iHDdso4wlY57FHCnkIc/JxVAQU9lBCG7dVV8cl/X2i7Be1irD4kZWenTm6shAEy+0XPskmejKrQOtq/t3+GnqPSeaSdV456iGZSKqPVxw6uy7xHoyPBkg4uQPO5nEzN+eUt5C+JmrhBMbIvZ4nZVHE+Qvje0mtSKCp0Gziz5k9AQ==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by CYXPR11MB8730.namprd11.prod.outlook.com (2603:10b6:930:e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 14:48:29 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 14:48:29 +0000
From: <Woojung.Huh@microchip.com>
To: <Saladi.Rakeshbabu@microchip.com>, <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<linux-kernel@vger.kernel.org>, <logang@deltatee.com>,
	<UNGLinuxDriver@microchip.com>, <kurt.schwemmer@microsemi.com>
Subject: RE: [PATCH] PCI: switchtec: Include PCI100X devices support
Thread-Topic: [PATCH] PCI: switchtec: Include PCI100X devices support
Thread-Index: AQHbayGB3hYd6pLhkU2olHysK+eh4LMgRuEAgADwHICAABlusA==
Date: Tue, 21 Jan 2025 14:48:29 +0000
Message-ID:
 <BL0PR11MB291389A19D72075963A755D1E7E62@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20250120225642.GA906528@bhelgaas>
 <be829909194332808ab3ed4ad4fce4b488549e12.camel@microchip.com>
In-Reply-To: <be829909194332808ab3ed4ad4fce4b488549e12.camel@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|CYXPR11MB8730:EE_
x-ms-office365-filtering-correlation-id: 69445731-35a9-44b8-5ee8-08dd3a2aab83
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWdDOGlFK0pTQklhaHdMcXBUWWxjaVBEa0xwRmVlV1NyOHIxVkRYTDA0TUY3?=
 =?utf-8?B?NFAzc2h1SGYzUkJOUEFrNWszVzhYbUJBbllURW94Mmt3SVpNalc5Qkl6anQx?=
 =?utf-8?B?VHhPTmErbVR6WVZBR3lNbnljSExlejdSSURMdGxMVlkrc0dWRmpOdUJrRjEw?=
 =?utf-8?B?NkRUcCtZRWt2ZUtWUkwrZ3BPNGQwb2pFK0Y0bGFLeDA3dUxDU2ZjMnB0Q0JX?=
 =?utf-8?B?OTByQnliNkxDOFRvcXF2MXdlWmNlMXBwVGx2bEhmbXlnQXNmdFU1Q1phM1Z6?=
 =?utf-8?B?L2JJOGVwaWxLSVBiWmdqVVh5UG0zY3hoelVZU3M2VlQ2cnN5NDYwWG5wMzlJ?=
 =?utf-8?B?SVpCMzdaRDVmQWpEVUxidm5HbWFMcHowdjV1OHNaZVB3ZzJYczk4UVpRUUpv?=
 =?utf-8?B?SkJCVktYcWJmWmp0cnlUZXBZV1pqOGFKZTVTM3Y1TDVoMFlWbGpZckd1c21S?=
 =?utf-8?B?UHVVVVVyUlg2b1RLT1pxYWE2SlFZRzBXaUxVTzgyalFjM1MvRWx6dm5qc3VT?=
 =?utf-8?B?eEU3Q2MxMDhDRUd3TytSYnFJSThGeTl4ZjM1dFhFTVlMMHNCcG55bGxHNkhI?=
 =?utf-8?B?Znh1a2I0QWErTVEvUG5INHlHbklYb0NaMjNZUGc5UHc5VDltOEkxZ1Z5bk1K?=
 =?utf-8?B?OEdJZERVcEk2MmJ5SFA5VGlzU1d0WEg2Sk1XcVppWi96ODVlRU5tSmJFWHhZ?=
 =?utf-8?B?cDZQbzZNM0E2SWFURjdmREFQMVVFQWxVN1o5enBiSm9GbERGY1V2bjd0R3pT?=
 =?utf-8?B?ZUtTbTA2WUlaekRLWmNlWWxNRS9NTys3azU1blM3a0hPTGxjZnNOQXR6MmFJ?=
 =?utf-8?B?T25ZdWc5eFQrVFFmTUNsT09uQ3VrVXdKcjR1L0ZpQVhMNWh5WEdNVUc4SzM4?=
 =?utf-8?B?cFpaUzBaQkxmbnZZYnlnbmdqNFFZSTloOENGZnNrOWJMRWdTelh3S2tVVUxp?=
 =?utf-8?B?MGtLS2xLOUdMQnlzSHcxc1VKazJEalpySXBjVnhhSysrd3NzQktpbVdWVjNq?=
 =?utf-8?B?OHNmem9LY21ueGw5V0FKL0JKMXE4R2FCODNtVTVWSEh6enQzNkU0SWlEMU44?=
 =?utf-8?B?RGwzejY5SjB3eXZVWkpjR3A5M1Q1ZDlJa09lVlNRQ3MyTitaclN5WDVUQzVh?=
 =?utf-8?B?NDFzT00vSHZPVFdwaWNPV2ZZaVNyeHEveE1qMXJpNW9xUWxlOFU5Vy9uSkJw?=
 =?utf-8?B?TC85Q0tjT3VsZVJSN2QzVkFsVGxuNnhRbm1sUENEZWFwb0JrNk8ybWtTSm5z?=
 =?utf-8?B?RUxzNGcwd0p0Z3RnaC9Xem9VTjMzd3pDb2lHdEVOaENGVVFMMWRrK3pYNEU0?=
 =?utf-8?B?QkFxSEdocWlJSnFVQjdwQmFRSEF4QXpNQ2J5NHA2Vm5ZMFcwYmNzNHVsWGFH?=
 =?utf-8?B?dUdUNWRvZndCSjRlNjh4YzlUYmpLdDJQbi9SN1JCQWR5cHQvMk1SL1ZkUTB6?=
 =?utf-8?B?N0ZaakIvRDVEY2RCR3JTZE9vYlE1bGNLY3A5cGg0SDBzYnE0YXlsbjBENXlE?=
 =?utf-8?B?STlxd3p4U3dIcDVJN2hVaUU2UDFralViTkdiVXY5V0tndENSRWtsdzgxSkhv?=
 =?utf-8?B?TVY0Q1dyNzhxeThmZVlGK0gxOGlHR21JYlBoZVkxaU02ZzM3SDMvRzRWVmZs?=
 =?utf-8?B?YTlobHRPanJ3Z2RsczI1a3hCRWdkUy9mdjJpQUh1MzZsVjhZWHVKK0YwTjd5?=
 =?utf-8?B?dWIzZjJRUzRtV1FOdDdmalVhWlF0WW5MMkE3cnZkYTRBZWtNclFNMUZZQnlZ?=
 =?utf-8?B?Mm9ZcWp1YlJ4TjBVOHIzVHJTZjF4bDQ4QSt5cHYxem85UWxZU0t2WC94KzFN?=
 =?utf-8?B?SjR4aUFnRDZQdmFwb0ZCZkF5YWU3K0Q4c3YyVmdLN2c5QjMzU2o4TUVkcURX?=
 =?utf-8?B?bUkwbFJJMm9UUW9sVGJSY09WQTZCUC9vdm5LWDBUaGEzQlE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aCtRa3ZubzRGRVB3SjZyd1VUZkpNVlR4S1M4c2t1OExINkpXNEltR1BLbUo1?=
 =?utf-8?B?TGVNNTk2eWVsYzBRUEdSdkFCUGpmSnRkK2cyQVZWdnE2aVRBYitvSVF2Ry9l?=
 =?utf-8?B?TFBGZUE0dmcxaEp3MS9zMy9sVndYcGhRMFBmU09wbmRMY3F6Y25PNDFwNytn?=
 =?utf-8?B?cmQrTFo0YzNIWEtJeko5OVJZeHFzeXR1ZjJpZ2w4Z2xwNTRvUTFpdXVWRGE0?=
 =?utf-8?B?TFdWQnM3TXZhbDlGSVppcGc0OWU5aVJ3cm9nQUNwK2VJM3pDeUlieVVLMnZ2?=
 =?utf-8?B?a0hjU2dqbERRdW5OWkRNM3hsRkJaLzdqb3dzc2QrUGY4Ky9lK3VTVEppY2tN?=
 =?utf-8?B?ZUpQRXEwSWZCcXlTZmxUTXJ5NHh6Y3QxaWRJRnlweHZ3RThGWldsSFNvQTU2?=
 =?utf-8?B?d041MDRFcVUvMkQweGk2b0JRaE9tSzBBTFlGTFV2UW82bnNpWHJtVUlVM3Fq?=
 =?utf-8?B?NHMwVkpUUmtleGJYMUF3aktoQnlxZVNhV3EvVkdGTWozQnFocURSNUJWeU1a?=
 =?utf-8?B?UVN3TjltME5sZGNsdTBWTWZYTXI3Rm9uREw5QmJVbEdVTnIvUWVQdFRkRWlR?=
 =?utf-8?B?KzI3Slo2d2dWV2dWYmlMcTI5NU8zY3lMYjJiK0h1Sm5DOGpJWTc1KzhOTGZu?=
 =?utf-8?B?NEFrN2tYWHBvdUNZU0FZVmlvSFRSUjV6VTZHUnVJS01UZHZBZmpXVEZpVFcy?=
 =?utf-8?B?K3oyTXBBZExaR2w0c2JKUm12ZlcxU0Ridm51ZVFwZW9FMkhQN3J4K1g2TitP?=
 =?utf-8?B?OFhDNEZuV2tEMUhiWHFrTnNzZnl2R3NqM2l4Q1VEZDByeDFiZ3VyR1pZYUd3?=
 =?utf-8?B?OG94a2RqalQwTTU3U1Y5cmZodDJ3NDIwT2hiTnNpa0RZcUZEQmJIR3BsZzRy?=
 =?utf-8?B?NjEwd21ncERVbEZVSEd0Wk8rSnlsa1BXaStuUTFzajJFaXFlblNWVGpRNE1w?=
 =?utf-8?B?N2Qxd2V4MHJ6Rjdqb3dZdVU2OEFDeThCQlpjQzJjQTlwZUFHbElFWmwydUh0?=
 =?utf-8?B?c1h0eTdHUlpxNTdMcTJURmxvbFJURTJDdVBUMllVRjJlTWVsQWEyNGNnZ1k3?=
 =?utf-8?B?Z2wzR3VKVUZsend1eFREMWdFc1RqaStBVWx3TlF4cEs1NG1aTFV1ZHoyL0hG?=
 =?utf-8?B?TWdaUEdLRGRZYjVtbFBibnF3SEE0eTNJREVnR090dnhnZUJoTFJUNGZIMzBL?=
 =?utf-8?B?ZWZPWXBmS3JxdFYyYW5mUVdVeU1wMTdOQXRjTm56Z2FyWjExYzZXdTFrWk1m?=
 =?utf-8?B?OFVnZ2djOHM5NFE2VU91M3A3alRkWGlnakFDTGZvRStUNHJOQ3FGMHBUZ0Ux?=
 =?utf-8?B?cTJJQmJldm45VHkzamk3TVhGN1BuYjMxTWJRREFYSnZ6elpUQ00xdEFIQzZU?=
 =?utf-8?B?bDlKK1FwRVZKVXlpNzJ1QkNVcTRhbFpFUGEvZU5xZ3VwY2FYVGtOd0l3dUNN?=
 =?utf-8?B?UHNidldvZ242NldlcWZkMDNTTlZLQk8xMUplRkZKOFdWMWZqSSs5UjQweGVy?=
 =?utf-8?B?ajZKeDlMd04yRGpDVUpSMlhOOHg3bVRGTXFaNWV1M2VhU2xUaXd1T1pQWHBv?=
 =?utf-8?B?cGxEWE9CblNZR3VVS1lvNjkyay92MFlWYzFuM0ZLMkJIZmlKZDIvRlhuQTd1?=
 =?utf-8?B?NUc2U0pLUjdlbG9QYVJEY2hNa25pSDdBWk05NTZML0tla3B6Q3RBdm1qRXI4?=
 =?utf-8?B?Yk5SS2hOWnZoWklZY003Ymwza21jdTZTenVFNFloT0ZTSmw2dXJ6THArNGg3?=
 =?utf-8?B?ZzBnclRSaVBzdDRzNG1ad0YrSDFrN2E1Ull1T0VsdDlpanVkUU5McFN6SDF1?=
 =?utf-8?B?OWZNOG5rdXQ0ckN2a09pOTZoa0VnYVREVFRPVUxnQ2o0bDZVWjVKYmZ2c25M?=
 =?utf-8?B?MTcwa09wYmpMY0JOa1dUM29PZU1mTFVVUTEwMVJ3TWdnN1JrM0FEL0UxdGIw?=
 =?utf-8?B?MkxWRjQzbkxMQXgza2Q2enYwUk1SVm9Nc2RSTmlhRXNteDBVMmVpbjVRM0c3?=
 =?utf-8?B?ZVBwNTNHWTB0a3psMDd4ZERDNnF1K3VtY2dUQnFLMUhvbFRMNWRoMEp3R3E3?=
 =?utf-8?B?cmxHM2ZFRTNYU0xQaVZJbmsrR3d5ZGk2MHhqbVk0VjFIL2dBT3FZSXd3VDZV?=
 =?utf-8?Q?XAqeFxblkHg6la2NliTlSX0LR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69445731-35a9-44b8-5ee8-08dd3a2aab83
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 14:48:29.6934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8AzmfIzoYdb/bsZrAfXUC8ekeIqbQQBwb+TJVJ4q/ycb+Q2qnuMBY6phj2xR+y8Z64oLJH2oIddEk49sXV+7BPLRqaBmXmIBGGVlrpXs/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8730

SGkgUmFrZXNoLA0KDQo+IEZvciBmdXJ0aGVyIGluZm9ybWF0aW9uLCBwbGVhc2UgcmVmZXIgdG8g
U3RlZW4ncyByZXBseSBvZg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC0NCj4gcGNp
L2Y2OTU2MTgwNTQyMzJjNWY0M2MyMTQ4YzVlNjU1MWYzYWIzMTg3OTIuY2FtZWxAbWljcm9jaGlw
LmNvbS90bw0KDQpCZWxpZXZlIHRoZXJlIGlzIGFuIGVycm9yIGF0IHRoZSBlbmQgb2YgdGhlIGxp
bmsuIEl0IHNob3VsZCBiZQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpL2Y2OTU2
MTgwNTQyMzJjNWY0M2MyMTQ4YzVlNjU1MWYzYWIzMTg3OTIuY2FtZWxAbWljcm9jaGlwLmNvbS8N
Cg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvMjAyNDA2MjExODQ5MjMuR0Ex
Mzk4MzcwQGJoZWxnYWFzLw0KDQpUaGFua3MNCldvb2p1bmcNCg==


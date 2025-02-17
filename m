Return-Path: <linux-pci+bounces-21576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35267A37AF9
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 06:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB02188EF5F
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 05:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A61185B67;
	Mon, 17 Feb 2025 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k6m9UqBg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB8C137750;
	Mon, 17 Feb 2025 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739770699; cv=fail; b=uOnN+ZvVvaKme6oMNdVrJh+Qp4/o1cCMLd8g0XW6xv3sfgfCx7tgXDQHRbiC0tuQbkt86+LwfpK41EdoMdF50baLwBAZWLMOnZ7t3gBfs57NoW+ftX69ksigpeEWek4Iac5+whPRkrKZXVnIcEBeAMAyXyz1XpKGHjWxJlOXfEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739770699; c=relaxed/simple;
	bh=/6sFrWUytt6qj5MLG2KxLvTHVkrQw8k5eRVvG9JQWjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d0C7W+77mx9r5sco+4aVaeyL54ENNPxerNovJb1359ICyTHEhBC2DE68OeFy5IgNotg8vaukarwc1WzFZcLRE3WRRhlkm6+96w9Y29BWh1/YQsxIcrAN34uiseTHl7DRcpPRsIzNY3aJNf8t/Z62T/pTJejtOAzOcUyd0npkcQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k6m9UqBg; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrfI1qEWwp64ibP7O9Pjp7DFE//aO4url5J9L3qIgPW4BmZta3Ne+OTLjITBiqb5bPh0KloDSc7kIx8/rgWomNqNyPL+71RFlz+Uv5FNTQNiXE+DGFJUXsw7f+08aenIy26y7PtupNVtP6gwWO+aKr0fEMNye9brERzAPPPBbsBaiAic0Sy7yaQGVBYkKMUoYmt3KQFB4u1kFjzQ8tP5L3OU07+G46gRj316oXnvTi8sePxJ2q5C0ewbbC/FcBXaM9eguyq3+Jfr+nj6V1lph2GDHEqDT1KzeBQv30PqEr82Q4S8NnzZxJN5LyTErTcZNr/lguq4UV3fWckqMiRkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6sFrWUytt6qj5MLG2KxLvTHVkrQw8k5eRVvG9JQWjs=;
 b=b8Eyno/NOxE1c30p+v+fbUG4snVWlSu3A4FYeMV9uYM0CMtc7aVN7p7JXTnYPOUT95oG6ySHRPGYgM+zaVgFjVBXdjydJIhqw/2G3XPaaU5irRo225LSSR7MPOClNEtxD1QtCv5lS/EkDTtn/dPog45BMXpViEfmIO4xrU24q5rW8ECjz6YqSaVrWiiQ3v3LqxR5FfBUuEht0aI+kFTiZTT979X8xEPTt0Pv5C+I7cGhHj0Iw2Y9Un3W9KEwWPROAvaUvu8f8J3AAZTlgZLOrqq+7F6dAJSd0jbFvs3DeHTfj2jPXOVnLpAewHNQIjljDK4sN665AIqMlAUD/rr63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6sFrWUytt6qj5MLG2KxLvTHVkrQw8k5eRVvG9JQWjs=;
 b=k6m9UqBgImgL7PSEPl85aSzPzGNEcYLsXK5IdTbnZJ23mrjs70tJ/lSoxSN+oI9xHeHAULlZgm+lfyIJlO5PUEophYfIhShZHyNFTdpOQYQ3HEpvQjJseYfWVizRmhfYsxZdCjNF5ozYHwYfdN+DgMWkUrD1fIcQXKMawH4fqc8=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SA1PR12MB7151.namprd12.prod.outlook.com (2603:10b6:806:2b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Mon, 17 Feb
 2025 05:38:13 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 05:38:13 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v2 2/2] PCI: xilinx-cpm: Add support for Versal Net CPM5NC
 Root Port controller
Thread-Topic: [PATCH v2 2/2] PCI: xilinx-cpm: Add support for Versal Net
 CPM5NC Root Port controller
Thread-Index: AQHbfRIpMGlWlFbQLEKa/Lx5tVM5dbNG96EAgAQI/TA=
Date: Mon, 17 Feb 2025 05:38:13 +0000
Message-ID:
 <SN7PR12MB720127C32746523921BCC3F28BFB2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250212055059.346452-1-thippeswamy.havalige@amd.com>
 <20250212055059.346452-3-thippeswamy.havalige@amd.com>
 <20250214155536.ap7mjvutnuledkki@thinkpad>
In-Reply-To: <20250214155536.ap7mjvutnuledkki@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SA1PR12MB7151:EE_
x-ms-office365-filtering-correlation-id: 70cd65ce-a4a3-44cb-8f76-08dd4f154546
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yi9wWGppZWo0QWNCcUxhNlBkSE9MZjIvaUNrQWF1RjhYQXQ4V3IvRnhkMERN?=
 =?utf-8?B?RFpGMUpPOFBkUW41ZmRnZlg4amgwZDBDWFR0UElobzNPNkhMS3IzenVUVE4y?=
 =?utf-8?B?UVVSc2N6WE42cFVnWTh2SU1Bak1VSi9nWFJjZW44QnEwR0ZOZXh1WEZWNXQv?=
 =?utf-8?B?cjF1cVpkSGx0WVd2cUxLN0ZkcmU5SUF4UEhWVzFkMGFyWkVnNkNJVHVIczNV?=
 =?utf-8?B?SzF5N1N3ZUJyU0xPRXI4eitOY0pKM2tkVVpCSmJwbVMvY2pUaUYycmJLakVN?=
 =?utf-8?B?K1U1c2JUcUlRYWk0ZFQ3c1RwVnpmd01OUEMxcXBZRWZSaTg4OHQ0UGdQeFVR?=
 =?utf-8?B?R1c4WU85QmE2WmFlSCtJSjlIZmNBS1dTQWEyQ2hhYzk4UzlWM2NnV1dVYkZu?=
 =?utf-8?B?bm8rSTNFZEp3YmRGSmRWWThac0Vmejc2NkZ4S21keHRCb0hhQ1hZbWVTUWdi?=
 =?utf-8?B?Vk5WMkdpYjRkRGgrclN3SGxva3JFWWlWWWt1SXZWTHQvTmlXeTZCOS9Yc3k3?=
 =?utf-8?B?N3R1b1dVcDZvSS9qS3p4SVZiYmhrRk1nZmFqR2Ixa2twNjdtbkxYNzdsQ2xj?=
 =?utf-8?B?bTdwRVVuK3RWRlVEQmFUYkVnT1VxZXh4bWZmM0QrM2FsYUlKNzF3eDZqcWdJ?=
 =?utf-8?B?aEtnWVN3YXpmT2ZVQzVtUjRjbi9VYVlWMlZzWEswWGNqaGU5R1ZXSHAxQzFC?=
 =?utf-8?B?cGFUTWRwTkpJOHJvaGNKSk9pZDdGS2J5QlJnOHg3SmU1dFhaWUh6WEFpakVq?=
 =?utf-8?B?aGVBdmVpUGhDaVIwQllIVGJZL0puOTZld3gzandmQXpwMllHZ2xzYUxTS0dG?=
 =?utf-8?B?NEl6cmJiVHVhYkM5M1Q3c0xabE5FTzlaZXJoUlc4WWhKOGZIZnRqbkFIWStO?=
 =?utf-8?B?NWhOdEYxWGpJWTB3OWh1OE5XU1BsQ0NiSVBsRkJOOWpmL3h4dWFTdFM4QlFH?=
 =?utf-8?B?eTdYRmxyM0lNOURETU5IVngxSHNZdG0zTFo3emtVcHBsY2Z0K2hHYkZxdHJk?=
 =?utf-8?B?Wm1sNmswWDlDZE5Ca3cvby9BUUZUSm15czdsYlp5YUFQR2ZxZnNJMDdyWVZR?=
 =?utf-8?B?OExWSHJIQVFPZUhMU1VoMHJ0YXovdy9oN3FMK1RlekVUWGs3L01XZEdNWjJB?=
 =?utf-8?B?ZXRnUnMya2JUVGF5V0R0WGZTaExIaDAvRzhBdjFkMW1PVEkxZVhaY01SMHph?=
 =?utf-8?B?NVpSWU9YcjBsQm9Td1VIdWRxbVFYdXJLbDVXeXArT21tREhTVFNnMW9BNm1o?=
 =?utf-8?B?a294NWJYZXZldzVDN3h0S21MMDBwd3N5VExLNVFPTytuVCtHVHMvU1c4VGx3?=
 =?utf-8?B?bDFleDhPUkRFdVR0SHR5Rk1LMjEwNWNSR21qdnU0WEpCajhqSGJGbEFWL2cx?=
 =?utf-8?B?S1B5ckRyMUttcVdLektNSEZpNVV4U0s2M1hGcU1OamJ4aTRPOFdYdlAva1pE?=
 =?utf-8?B?OWYzRnlmMytMWGFyd2h0UmQwZ0RtV2tDb2RKVitvSVc3MGdjcjlrYnFldURH?=
 =?utf-8?B?OW1jS0IvZWxNYWNoaG9VSDRvamVmbWdCOVVYTWZsdDFtUTZOakFEY1JnaC9G?=
 =?utf-8?B?bW5hbWg0L3B4VkRsblJVQ2R2dGdoTHVOTndBUHJEakI1VlRidFY3a0NZelVk?=
 =?utf-8?B?a2lUQzQ1UnBDOEszRkdDY1RnVlRpUXYvNVdqUm5yaXJCNlVPNTBNVmh2a0ZR?=
 =?utf-8?B?aDN2MzRFRE5KSXpITXdQVTJXUnFKalRHaUVwT05mK0YvaWtLQVJDQ3lmRTZK?=
 =?utf-8?B?dVI4NTNPTmhWa2NJanAreWtBcFk4MTQ5U1A3MzZIdFNnR05FakprbkxGd0E3?=
 =?utf-8?B?NUx5WW1jdDdZTzk5ZDNEZnZGZGJOTXFibjlWK0h4N04wVjZGWnB6RWE1ZTcw?=
 =?utf-8?B?dWl2bXdnb2lFVTBVZTVJcklsRm42RjdKamFYWjBNandBZTROeGFrWTkrTnJy?=
 =?utf-8?Q?XU8skIcRP9oJvmVu/dwM12nrSs8ZF9dl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3pMd2xYRjFXVTN5d2VDdDVoTTQ0YVFyTGdNK2Uzb0drSllDSGlHZlNqWFBs?=
 =?utf-8?B?UmFOY1FlUzFHZUd1QStYNTJCVkhpYW9HY2ZOc09PNjZNWUhoN21JSVR1K2Y1?=
 =?utf-8?B?K2FGUzA0YTEwelFtOXN5ZXdpcnVLVXBKMXFja2FnbG5vakFUb0pVdmFGdGlT?=
 =?utf-8?B?QndlYjFWU2UyWG9lNWpvQmxUV3J1QU9ycitZVWRhemdEU01RVU0rbnIrTVcr?=
 =?utf-8?B?bGJwcHd3MGZDYUJtMnMzMytMTloydzdmRmswdURjRjFMSmtGSjZsRkFvTVhi?=
 =?utf-8?B?Wi81UEZySlp1eE1BZldzalZwWE9wdkVzY3owTWlkZWYxV1hyYmRJdG80Tm5h?=
 =?utf-8?B?cSs2MnNtYnFZa2xSTDJKYmpidXlmVU84QXZ0c1ZmR0xXdTMybGlYZDRDaElo?=
 =?utf-8?B?Zm9Dck15R29PbWhaQVNrdXh5cnpNNmMyODlHUzJQS00yWnY4clpSdDJYYmxy?=
 =?utf-8?B?b2MvTXo3dDdUNTJRV1dRMEZ0MHNrb01NSXhLUkE1RmVxakttaEh0dmVMdXl2?=
 =?utf-8?B?cit3UDNQL2U5dUIxZ2lNclB6UW9nQTl6R3RKKytkWlpGTEJQWXF1akV3c0NN?=
 =?utf-8?B?ZE52eEZ1c3BLWGdQZ2NVM3JrQS9SVWNQY3Zuc2xOY0FwT3E2RnNnRVVkT29O?=
 =?utf-8?B?OEhpVHNQb2lzUCtMZ0syQUoxMjNnRzFHK3JkanRmRnRtc1BYTDdnZ1UzWm55?=
 =?utf-8?B?MUd5NVpaSHVUVXUzTVg2aUFFKytqdmNKNEY1YzNxUGZWT3RFTlBkblE4OWRE?=
 =?utf-8?B?MGlOcFNRdS82OGpnaWduN2hvM2VjWmN3MVNlR2xOTnYzcmxsSGJDdmhrN3o4?=
 =?utf-8?B?L3lTQVd0YTZsRndWOGlpZVRPNWxCUHhZRkJ6UXlXNEY1NEpwK2RWL3NlcnFp?=
 =?utf-8?B?UmwzZVBSUWt5dWhCdWcwQko3Y2ZSMFR2V1kyZ3o5TUlaUS90RDRoSzl5cGJB?=
 =?utf-8?B?VDFJZjU2aXo5SVVxUmZwVlNpaHFNaGRjd3BoY0tNT0QvV0E5VllSUXltalh2?=
 =?utf-8?B?MEZLNGxxY1ljN1pvWU5sUXQyOE9QRngxMmZyTml2TURxVDBIcGc4dlJOV1A4?=
 =?utf-8?B?aUVrL1loeHp2SmlRQkRsa05JeEFUNzBVSVRsSDB1N0JkTXBqVEpyOHliWlV2?=
 =?utf-8?B?ZFZnL2pVNk4zeWw5Y2FVejFJbEs4ODlOZXFYdzcrTEd1MVlKWHdQejBlMVFP?=
 =?utf-8?B?WlFNUjh5cG5zN3ltbWx1UnZiSFQxU2VrZStzNlY3QnY0ZzcxaEpjRDdDOVVP?=
 =?utf-8?B?RytFMkNINmJCTDhSZk1WN2hPVEtaWHQ0QUJYSVdpTk5Dc0VNS3ZPSzZmQ1RJ?=
 =?utf-8?B?anJNVW9LRTFOMHdSQkJOWWcwbzg5anhPRnlWYjl2VmxQaWFId01PM3dlTER6?=
 =?utf-8?B?dFhGRDFQVDAzNDV2d2tCa1kyQnlOejQyUGtKMVZIR3B0emtNZDRuSlRlUnBv?=
 =?utf-8?B?bGJOUElWeXVKUkdNZG5ueVBiZWtiQldrbkdPSEZVMnA0VlM2cnZGV1BRZ3Ux?=
 =?utf-8?B?TkZBVHhXSHU3YVpieTdZTFdyd21TdStWWk5jQlh0OXViODVzTVFuNnkyd2xU?=
 =?utf-8?B?U0w1QkgzVU5pRjRxQWNVYmRXU202clMzVDkrbkhiMDZIdkpGWithWTJUZ1dE?=
 =?utf-8?B?aW1Jbk1qV0xDd2lQbGJvMmk0Z1FrQmpWTExKMjlwK1BvRmJWeXk2a1NRQUpH?=
 =?utf-8?B?eEhVUXY2QnNoTWZkOEFiTVdDN0JlOGNrSGk4dHEveG05VUJMYUVpbFgzMGJz?=
 =?utf-8?B?MDdDdjBERXk5Z24zd0xpK1NJUVZrQnlFMnZvajNnT2xOaFg0UDByZk9CL1h4?=
 =?utf-8?B?ZkRTaHZQV1kxVkdjdWpMTFF6ZDBiTVpVYmpJczdnZTd5Si9VcjUwSHViUjFt?=
 =?utf-8?B?Vk1CLzcxMi9zOXlJSlgxQ0x2eTJ2T0xaU3JrU0NtNnF6dHVCMkdGeWhPQ0ov?=
 =?utf-8?B?c3VKMlE4VE1ZT3ZjNWxlNktsUG0vUVJ3N1VFcDBpMUFlYTBKYnhBdk5NcEVW?=
 =?utf-8?B?a3d2QmxkUlFkczU2YnY2QzlQZmV4YUIxanY5UnRaT0NqaytFeUNhcjVJZE4r?=
 =?utf-8?B?TWRvckRRVGV2Zk5kdk1iaWlSaEVpdjMvZ1B3bURVU0plMnpFRVVPUllVdlI2?=
 =?utf-8?Q?I36I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cd65ce-a4a3-44cb-8f76-08dd4f154546
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 05:38:13.1322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9nWgFOVjZQQZURtw8ILYErx/a4SUhwCwKjljeTiStVnzcWSkcVPtCZ4m5beRdYc5UOhQ3QMvjVjL5YsFMfZbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151

SGkgU2FkaGFzaXZhbSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBN
YW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBG
ZWJydWFyeSAxNCwgMjAyNSA5OjI2IFBNDQo+IFRvOiBIYXZhbGlnZSwgVGhpcHBlc3dhbXkgPHRo
aXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+DQo+IENjOiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBs
cGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsNCj4gbWFuaXZhbm5hbi5zYWRoYXNp
dmFtQGxpbmFyby5vcmc7IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOw0KPiBj
b25vcitkdEBrZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2ltZWss
IE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+Ow0KPiBHb2dhZGEsIEJoYXJhdCBLdW1hciA8
YmhhcmF0Lmt1bWFyLmdvZ2FkYUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIv
Ml0gUENJOiB4aWxpbngtY3BtOiBBZGQgc3VwcG9ydCBmb3IgVmVyc2FsIE5ldA0KPiBDUE01TkMg
Um9vdCBQb3J0IGNvbnRyb2xsZXINCj4gDQo+IE9uIFdlZCwgRmViIDEyLCAyMDI1IGF0IDExOjIw
OjU5QU0gKzA1MzAsIFRoaXBwZXN3YW15IEhhdmFsaWdlIHdyb3RlOg0KPiA+IFRoZSBWZXJzYWwg
TmV0IEFDQVAgKEFkYXB0aXZlIENvbXB1dGUgQWNjZWxlcmF0aW9uIFBsYXRmb3JtKSBkZXZpY2Vz
DQo+ID4gaW5jb3Jwb3JhdGUgdGhlIENvaGVyZW5jeSBhbmQgUENJZSBHZW41IE1vZHVsZSwgc3Bl
Y2lmaWNhbGx5IHRoZQ0KPiA+IE5leHQtR2VuZXJhdGlvbiBDb21wYWN0IE1vZHVsZSAoQ1BNNU5D
KS4NCj4gPg0KPiA+IFRoZSBpbnRlZ3JhdGVkIENQTTVOQyBibG9jaywgYWxvbmcgd2l0aCB0aGUg
YnVpbHQtaW4gYnJpZGdlLCBjYW4NCj4gPiBmdW5jdGlvbiBhcyBhIFBDSWUgUm9vdCBQb3J0ICYg
c3VwcG9ydHMgdGhlIFBDSWUgR2VuNSBwcm90b2NvbCB3aXRoDQo+ID4gZGF0YSB0cmFuc2ZlciBy
YXRlcyBvZiB1cCB0byAzMiBHVC9zLCBjYXBhYmxlIG9mIHN1cHBvcnRpbmcgdXAgdG8gYQ0KPiA+
IHgxNiBsYW5lLXdpZHRoIGNvbmZpZ3VyYXRpb24uDQo+ID4NCj4gPiBCcmlkZ2UgZXJyb3JzIGFy
ZSBtYW5hZ2VkIHVzaW5nIGEgc3BlY2lmaWMgaW50ZXJydXB0IGxpbmUgZGVzaWduZWQgZm9yDQo+
ID4gQ1BNNU4uIEludHggaW50ZXJydXB0IHN1cHBvcnQgaXMgbm90IGF2YWlsYWJsZS4NCj4gPg0K
PiA+IEN1cnJlbnRseSBpbiB0aGlzIHBhdGNoIEJyaWRnZSBlcnJvcnMgc3VwcG9ydCBpcyBub3Qg
YWRkZWQuDQo+IA0KPiBzL3BhdGNoL2NvbW1pdCwNClRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nLCBX
aWxsIHVwZGF0ZSB0aGlzIGluIG5leHQgcGF0Y2guDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogVGhpcHBlc3dhbXkgSGF2YWxpZ2UgPHRoaXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+DQo+
ID4gLS0tDQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAtIFVwZGF0ZSBjb21taXQgbWVzc2FnZS4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXhpbGlueC1jcG0uYyB8
IDg1DQo+ID4gKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1
MSBpbnNlcnRpb25zKCspLCAzNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LWNwbS5jDQo+ID4gYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUteGlsaW54LWNwbS5jDQo+ID4gaW5kZXggODFlOGJmYWU1M2QwLi5j
MjZiYTY2MmVmZDcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ll
LXhpbGlueC1jcG0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14aWxp
bngtY3BtLmMNCj4gPiBAQCAtODQsNiArODQsNyBAQCBlbnVtIHhpbGlueF9jcG1fdmVyc2lvbiB7
DQo+ID4gIAlDUE0sDQo+ID4gIAlDUE01LA0KPiA+ICAJQ1BNNV9IT1NUMSwNCj4gPiArCUNQTTVO
Q19IT1NULA0KPiA+ICB9Ow0KPiA+DQo+ID4gIC8qKg0KPiA+IEBAIC00ODMsMzEgKzQ4NCwzMyBA
QCBzdGF0aWMgdm9pZCB4aWxpbnhfY3BtX3BjaWVfaW5pdF9wb3J0KHN0cnVjdA0KPiB4aWxpbnhf
Y3BtX3BjaWUgKnBvcnQpDQo+ID4gIAllbHNlDQo+ID4gIAkJZGV2X2luZm8ocG9ydC0+ZGV2LCAi
UENJZSBMaW5rIGlzIERPV05cbiIpOw0KPiA+DQo+ID4gLQkvKiBEaXNhYmxlIGFsbCBpbnRlcnJ1
cHRzICovDQo+ID4gLQlwY2llX3dyaXRlKHBvcnQsIH5YSUxJTlhfQ1BNX1BDSUVfSURSX0FMTF9N
QVNLLA0KPiA+IC0JCSAgIFhJTElOWF9DUE1fUENJRV9SRUdfSU1SKTsNCj4gPiAtDQo+ID4gLQkv
KiBDbGVhciBwZW5kaW5nIGludGVycnVwdHMgKi8NCj4gPiAtCXBjaWVfd3JpdGUocG9ydCwgcGNp
ZV9yZWFkKHBvcnQsIFhJTElOWF9DUE1fUENJRV9SRUdfSURSKSAmDQo+ID4gLQkJICAgWElMSU5Y
X0NQTV9QQ0lFX0lNUl9BTExfTUFTSywNCj4gPiAtCQkgICBYSUxJTlhfQ1BNX1BDSUVfUkVHX0lE
Uik7DQo+ID4gLQ0KPiA+IC0JLyoNCj4gPiAtCSAqIFhJTElOWF9DUE1fUENJRV9NSVNDX0lSX0VO
QUJMRSByZWdpc3RlciBpcyBtYXBwZWQgdG8NCj4gPiAtCSAqIENQTSBTTENSIGJsb2NrLg0KPiA+
IC0JICovDQo+ID4gLQl3cml0ZWwodmFyaWFudC0+aXJfbWlzY192YWx1ZSwNCj4gPiAtCSAgICAg
ICBwb3J0LT5jcG1fYmFzZSArIFhJTElOWF9DUE1fUENJRV9NSVNDX0lSX0VOQUJMRSk7DQo+ID4g
KwlpZiAodmFyaWFudC0+dmVyc2lvbiAhPSBDUE01TkNfSE9TVCkgew0KPiANCj4gSG93IGFib3V0
LA0KVGhhbmsgeW91IGZvciByZXZpZXdpbmcsIFdpbGwgdXBkYXRlIHRoaXMgaW4gbmV4dCBwYXRj
aC4NCj4gDQo+IAlpZiAodmFyaWFudC0+dmVyc2lvbiAhPSBDUE01TkNfSE9TVCkNCj4gCQlyZXR1
cm47DQo+IA0KPiBCdHcsIHdoYXQgaXMgdGhlIHJlYXNvbiB0byBza2lwIHRoZXNlIHJlZ2lzdGVy
IHNldHRpbmdzIGZvciB0aGlzIGNvbnRyb2xsZXI/DQo+IEVzcGVjaWFsbHkgdGhlICdCcmlkZ2Ug
ZW5hYmxlIGJpdCcuDQpUaGFuayB5b3UgZm9yIHJldmlld2luZywgSGVyZSBCcmlkZ2UgZW5hYmxl
IGJpdCBpcyBlbmFibGVkIHdpdGggaW4gSVAgJiBubyBuZWVkIG9mIFJvb3QgUG9ydA0KZHJpdmVy
IHRvIGhhbmRsZSBCcmlkZ2UgZW5hYmxlIGJpdC4NCj4gDQo+ID4gKwkJLyogRGlzYWJsZSBhbGwg
aW50ZXJydXB0cyAqLw0KPiA+ICsJCXBjaWVfd3JpdGUocG9ydCwgflhJTElOWF9DUE1fUENJRV9J
RFJfQUxMX01BU0ssDQo+ID4gKwkJCSAgIFhJTElOWF9DUE1fUENJRV9SRUdfSU1SKTsNCj4gPiAr
DQo+ID4gKwkJLyogQ2xlYXIgcGVuZGluZyBpbnRlcnJ1cHRzICovDQo+ID4gKwkJcGNpZV93cml0
ZShwb3J0LCBwY2llX3JlYWQocG9ydCwgWElMSU5YX0NQTV9QQ0lFX1JFR19JRFIpDQo+ICYNCj4g
PiArCQkJICAgWElMSU5YX0NQTV9QQ0lFX0lNUl9BTExfTUFTSywNCj4gPiArCQkJICAgWElMSU5Y
X0NQTV9QQ0lFX1JFR19JRFIpOw0KPiA+ICsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIFhJTElOWF9D
UE1fUENJRV9NSVNDX0lSX0VOQUJMRSByZWdpc3RlciBpcyBtYXBwZWQgdG8NCj4gPiArCQkgKiBD
UE0gU0xDUiBibG9jay4NCj4gDQo+IFBsZWFzZSBtYWtlIHVzZSBvZiA4MCBjb2x1bW4gd2lkdGgu
DQotIFRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nLCBXaWxsIHVwZGF0ZSBpbiBuZXh0IHBhdGNoLg0K
PiANCj4gPiArCQkgKi8NCj4gPiArCQl3cml0ZWwodmFyaWFudC0+aXJfbWlzY192YWx1ZSwNCj4g
PiArCQkgICAgICAgcG9ydC0+Y3BtX2Jhc2UgKyBYSUxJTlhfQ1BNX1BDSUVfTUlTQ19JUl9FTkFC
TEUpOw0KPiA+ICsNCj4gPiArCQlpZiAodmFyaWFudC0+aXJfZW5hYmxlKSB7DQo+IA0KPiBuaXQ6
IHlvdSBkb24ndCBuZWVkIGJyYWNlcyBoZXJlLg0KVGhhbmsgeW91IGZvciByZXZpZXdpbmcgd2ls
bCB1cGRhdGUgaW4gbmV4dCBwYXRjaC4NCj4gDQo+IC0gTWFuaQ0KPiANCj4gLS0NCj4g4K6u4K6j
4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K


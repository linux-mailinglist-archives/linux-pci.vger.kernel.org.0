Return-Path: <linux-pci+bounces-43060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BA5CBFE8E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 22:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A04EC302531E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 21:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355E32D0F1;
	Mon, 15 Dec 2025 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2nGp4gJK"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE6232C92D;
	Mon, 15 Dec 2025 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833535; cv=fail; b=NLblGWHl7FH1fHps+VbaYs5WN9IRIKGRoqFDQyQgYU2FLy/GBEyeyuZ/n794QHRnIczFSTs0eYu7bJrJkBwBrSCjh8jihzt8clK51A18pX3l1xn5gxzRpfJKidYeuMpzWw2IFqRsxFRyIIxcWlZklSvBH0ms3pCzaxBitgFb0z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833535; c=relaxed/simple;
	bh=h8ubuoaNpINeWLDa0D3oJXrSXeQvYkezqCztlOmVpU0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tnLRLZi+vAMD4uoFwo98UG5rMLD9DrVVzJn4onyeilKLUwEHxwd5FQjopuseM/enHAKarFos+oL4OuyK7cE7huIauSKeDzu24XQM1ZXLTpa1wx/b3f6KSoyMrK/3snY+ocRZ+R2Hpgvk405AESq/Wv5GpTcRkWaBeqtAV5NjI2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2nGp4gJK; arc=fail smtp.client-ip=40.93.198.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaJ1y891UCmPJpHZAqkK8Q6nb3D0v9EQ8RrnE7Rfpe8ofjNnkU4UKUC5EpI4vfbkFr4gC466WRlnkWzPtM1EzSpNaj0KAxH/ECiLKYgJfHP0PvtMTSbO9osr+wO7/8+L0I3+z14rbSM8eM5mz+YyCWQ80JeywUIjx3or2u+NGbxInGgTL8dHNiA7xxKvTw6IUb1p1TrzRuRjttGOsNt5YihVDV71NNx1QahdEXTfDRJhmP8Drp0Txsu0iT8iAg3JCp/YHwOZ03/ijFJSs02nSSR2GWV6QZQaWesnsERAeugajn9XG6Ct0R2VNi5NVkKFlMTizb+8dyX3Z3xe6cXRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=539Sig8E0gl0E9E9VdUxmokD1fE0gXyfURKv0Yggkxg=;
 b=Xkkwr8mVZSyxx3OUsZ2Urr+EHIpUywUO3Rzr5GyGW2Dd84cqLTXvfHq15Qm/gYHkUmmUm5T5jkJHIe7jR35f2zuc1V0TLDsOq1xu6lvbA4JdOXhVJ/k4X7Q0C0c6mah7aqVJwEXU/GGVGtV0SK23SK+6dLJtf8uaq/SS7mzFIc9UQv6ojciiiVEX6taaB5bIFDsCf1T9xtLiv+b9wgQN/1CF4DepLYGS1XgNtRx8kE9jXISX2RChKqY68hOzSUSZ2qp2ZB177b8HKxX7PY7XaZFLaAD8/2fTS92zNGmsZ4cusfcmAd5ZwQstGFl5TJt2YrmN77W8pghMeesE5hSAkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=539Sig8E0gl0E9E9VdUxmokD1fE0gXyfURKv0Yggkxg=;
 b=2nGp4gJKiJ6Bp5lBXm9/+gBf2v+9LzvOMPqaqjC6V/VD3cd2l6jmb1e+l4w54y+TcySYY7EqKJ+jLoN0/MHJDvFmok+ht7XkXkcsKBJMTgw0jdcVfKxJjaIi0wWbtzlLIFl3Jw57r5izcAFF8LbN3IpP5d5XhzRMdPGstrbU2y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 21:18:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 21:18:49 +0000
Message-ID: <eca84784-c96a-4666-8f12-b0e6b70dbf76@amd.com>
Date: Mon, 15 Dec 2025 15:18:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] ACPI: PNP: Drop PNP0C01 and PNP0C02 from
 acpi_pnp_device_ids[]
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Alex Hung <alexhung@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>
References: <7888874.EvYhyI6sBW@rafael.j.wysocki>
 <9550709.CDJkKcVGEf@rafael.j.wysocki>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <9550709.CDJkKcVGEf@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0095.namprd07.prod.outlook.com
 (2603:10b6:5:337::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee0d637-2b2c-4d8d-d6ea-08de3c1f8a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Kzh3MitjWE1JWDNZSTh2ZXlOankwa0JBTWxaODdtWUlCa2Q0QXJ1Vmtqek9q?=
 =?utf-8?B?K3l2OU5MSUxmTHlnR2Vpajl5ZWdGbmNzSGFOU0VqTkxrbTF5ZFp1OExsSjlV?=
 =?utf-8?B?aklSMTY2TndhTGpHc0ZvRGVjbE5JSXl6dFk2bktVN3lPdnVHVFpTSmc3V1FO?=
 =?utf-8?B?QUNmZzE2S2FXdW50UGhUMlNkSUhkaFpubFVmSkFzMndXdmZnMHR2UWNmMkhZ?=
 =?utf-8?B?S1VKbFVIUTd4VTQrM0lWYjVNdDA4TTRacTNzRzB3S05wNENtaUJMR3ozMXNC?=
 =?utf-8?B?bjRMb0hNWDdnTk4rNEY2Sm9kZXZDekFWNHh6dEdrbENGY2NVM0J3SHJGdWR0?=
 =?utf-8?B?V1JnU3dVZGpxeXdBQnNJT2hpck5waW5STFZzUTV5cE5QU04zLytsQTY0MmFj?=
 =?utf-8?B?T3lhZkRDTmdTS0QreXpFeWl0NEhQZ0E3b2Z0QmMweFFlSjNFclR4bUhRRUli?=
 =?utf-8?B?a3RVcDlSM3hUbU81T003cXNpMnJqVXNGY1V5NlFnMCt2c2xqc25Xdkhoc2NE?=
 =?utf-8?B?a0tXc1l3am1yZWQrWmtyNDVFcktQMkY1Q3RkbVNZUjA2YmhLMnJqK09JZWVP?=
 =?utf-8?B?YWhLQzkxMitKRS9OZXU5dGRJcVRZVW1wZU1lRTFKV3ZrTXlrdHBBNWlJaWNB?=
 =?utf-8?B?blUzQ0JCbHJ1bVpOOVVFdnRvUUFGWStYek9PZ3NzbllWTTVaWkl2OXIzMzdo?=
 =?utf-8?B?K0lNQk04K2lJWEJBbFROeitCM0paZ09qWjNIMURZbllPWVkvWng2b2NpWGg4?=
 =?utf-8?B?VFA3amlSQTB0VG8zVmN1RHluMmhnaTlJaEpnM092NUlkQkdvT2p5dnlzYVpF?=
 =?utf-8?B?VjBwL0xpeXIrcUFxY1lmVE00eWZrU00vUSttcVBUbXptUzJPS01rUmxiSVVv?=
 =?utf-8?B?VEJWdjZ4WGQyTVNWQkNKMGNwODJaZlA0SzNrRmJaZFdOQi9waEc4Nm5hS2xj?=
 =?utf-8?B?UkR0RENESEw1Wi9Rck80VktpVVIxMUMwdHBzK0xvMEsyNC82ZEhyWUIxZUZh?=
 =?utf-8?B?dll5Mi8xREszMmdiRU1HR3BtV05sZmtyTjJqTTNIZ3NMNGxqS0xPU2JmQVh6?=
 =?utf-8?B?NVQvcDFrNHNGN1lxU2VrV3Rma3EwUHVoMnhnNFZpd0Y0b2E5S1hPZjBzV1l6?=
 =?utf-8?B?V2JQRFl6UHJkR3k1dFNnS0dtdXJLd1Y5MVRrOWZRU21aRE9aaUFXdCtBV0xK?=
 =?utf-8?B?UC91Vkh5NEt5MDRQMEw4dTNrRXNVK0JvSlNsckJUQmxacE11ME9ZRlkrMWJF?=
 =?utf-8?B?dXRSSUtJcVdhZG9UaGUyU0hSeGhNcTlVeDlkbDliemZkNzlPeHNSU0h5R2JL?=
 =?utf-8?B?dTFRbCtLZ1pxTi80U2hqU0JnNlhSYUhWZEt2MzFVRWlaREhhVGxlajVlcXhR?=
 =?utf-8?B?NW1seThzL3BoaVI5Q3dJcldzL1dwa3RnRnFPdnl5eXdpSUlCVGJpM2l2WmNP?=
 =?utf-8?B?RUxXVlk3b3hVaXdib1h2dFJ5eFdaZmR0RjE3U2dab1U4OTNaUTBuOFBhcm9O?=
 =?utf-8?B?SkllMmp0b0VUNGlsWWtjY2kxaHJacndyWGszRXYzcW5sQ0Z1ckVRa2Y2ZmZQ?=
 =?utf-8?B?WUlrMk56VXlPOFZ3eDMrVDV0YnNxSnR6Z3NXTW80Qmk1bmdubjZjbG8zUkU3?=
 =?utf-8?B?QVI5WlFybHJjd1BsNEdDRFBKU2tZRTZaTW9SYlJVb2pPYnhxcVpjNzlQb1Rq?=
 =?utf-8?B?M2w4Q1JxZU9sak04cHB0ekQ2RkpwWTFUU2JFczM0czFHMmtkd1hJMjlESEsz?=
 =?utf-8?B?YVc4bk1jZVFraGpIR042RzFXRHpoMDNlVFJnNUxjRWp3M2txY2dMRDVuV3pp?=
 =?utf-8?B?NThnSXhzL1d5VmlFSUQ5TWVDSkR4aGMrMXVLcjd2WFBUa3dQMUdpSWppWWhO?=
 =?utf-8?B?cFdpcHdZUkhXWlk3aHROWTc4cVkvbVBqa1pTU2tWSXZWWFIwbkVOQWhkbko0?=
 =?utf-8?Q?Oqn0hkJabLCk5JM41l92YOZXA46I4fGT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dE9zdDVEenRybnhlR2M2aThwOFphQ2NibU1TcVIzQ2cxRE5rZzRyY1hxVXdB?=
 =?utf-8?B?My8wUGIxVTk2SGVvaUdWN1M1c1lyUnozcXpCZ0dndmwzcVU1MkROclpMTDEw?=
 =?utf-8?B?TGpJelpoVDUwbTJDdmQ0dVVGN0c0cWdwMnBoU1VDUnJ2L05mWDc3Q0lFNksv?=
 =?utf-8?B?d21TMm4wL05KTk05MTRPMi9ZRkc0T3AzQk5WNXU1eGQwZ0t1OWVuT1hXMFFO?=
 =?utf-8?B?TkJDWTUvYXExRjUwWEhYb2dMS0p5UjhUbThJbXBmOVdXb3I5REsreUhBWFBZ?=
 =?utf-8?B?bTZhZEFLdFBPOUcvUHJIdWFCQlhjUGpFbmZFZEt2Vk1vUnJvZHpydkhORUNX?=
 =?utf-8?B?ZDh6L3JINTB0R29FUmxzY2UxVHpORmZWOG5pZlY3bWZuRWowaHRJd3JQWGRo?=
 =?utf-8?B?b0xYVHVndEJYa0lRQ0tCZzRIS21wMGVvRWJUbU5HY0pmbVFrVTY1QThVR3h4?=
 =?utf-8?B?UW0wbzR5a0R6d0VTYnhWclBBR2NEWFRBR3h6U0pKWmZLS0xscGdrUEZUWVZx?=
 =?utf-8?B?bVdMVWF1UU1VZVM1U1FidWdmZmd0VWlvT0llLzBjSGJJeXJGdkJqZnFNbXVh?=
 =?utf-8?B?M2JwK0NIUXg3TzJ4L0JyNVRXY29TZmk4emNYcTc2YzRtSFFaWmYxZmJLZmQz?=
 =?utf-8?B?RDZ0bVd0MjBmcnlEb0h3NElOWHVLWkxTeHRLV1BIYUgxcGI4dXFwdWl2ejQ0?=
 =?utf-8?B?VFkxU1hUV1hONFFLOUNvbUc4azZZWHkzL3Fia3gzL21VY0JPNmMyY1NyWnBk?=
 =?utf-8?B?K0h3K2piUFQwRytqemVZOWVNM3pDa2dCRERxbHlnby9JaXVlbEVJd29ZQ1Rh?=
 =?utf-8?B?Smd0WGF3dVNGTkRXbmwxUUZvSGVBUzNMMVBzYUZkQkpZTFh0MU01dnV1VTRW?=
 =?utf-8?B?WWllUEVHVlRhWXB1YjcyVVlJR1FxU0NTZGV2UDY0QTVpWmdqOUxmMU9YTjRt?=
 =?utf-8?B?UVNsWkpWZC9pV1U0UDlBc0RiRHJTNTIwOU55clZpTG8yVkVvdmpCZHp3R3ll?=
 =?utf-8?B?aGNEcVk1T2o4ZTVGUWp1ZHlZMEM5NkJab0k2cGNkUm5qNlhEZkR4RVlsTlFq?=
 =?utf-8?B?c3hHZUd3QnNLdEd3Z2NKQTRtemZSbnNzVnpvblc0cWxjMzRTRFBRdm1zcjFu?=
 =?utf-8?B?TEhtQWFML0kxNVBSYzBOVG1QRWMvTm03bWRyRndkUGNrRXZMcFovRU5uV1Fk?=
 =?utf-8?B?VmZqeXM2RW5UY0pwaDF1c21DbnZseHk3Ujl3b2VDT3JQTnpxL1NRdTI3RU1p?=
 =?utf-8?B?Nm9qOUQramg2eTM1VTVKMUNubzVmbnBJSmljUy9sK1QyN1dzT01JV0Q0RTNG?=
 =?utf-8?B?ZDEyU0VJbFhJakpnTTZTekdSV3p4WHkxcjlVZ0xsUXE5cGtuOUVqNzQxT1VB?=
 =?utf-8?B?SlJJK0pabC9zNG0wbXRlWDlrUzVrSEJNYzVJSnl0T2p0akFqZ0ZoTEI5SHl4?=
 =?utf-8?B?cXVVOVYyOTFGU1VaMGZJUmJUcDZWKzhXUTRBUXZnZXJNMWpoTW9uRzBoTGI2?=
 =?utf-8?B?SHFUMXU4RWdWY2hJZHJqTDVrZ1lJY2FmMWhtZ0Z6UXFDa3lORkJLUnNHaEQy?=
 =?utf-8?B?YlhCQUdNWjltdkdJRC94YktZU25RMTVzMTd2RHliZi9VUDd1eWVJTzBDWWJI?=
 =?utf-8?B?bHBvQnNlcHkzSUZJbVBEWWNvTHNuV3l6M25xK1djTEM2Sm91NktqUTZuU0Ra?=
 =?utf-8?B?cVNiWDdUOXhOVGZDRldwWVk4TFBwZDMwUTFiZHFWZGhJM0RtTXhTRGVqMFpJ?=
 =?utf-8?B?NnY5OGRxSTN1TUZ4ZDlmN0lWUVlRaUlIUmxZcXhlM0pERUdWWWJSNk8xWFND?=
 =?utf-8?B?bTZsV05aQno2bWV5STVnbGhRRFQrVXJsUlJMOFVkYUNSYUxmKzg2V043aGNZ?=
 =?utf-8?B?Q0IwK04rVG9USVRoeDE0cWZxaExEcHlWU1VnUFdIdWlKMGtya2xJUlYzS0Ny?=
 =?utf-8?B?aTFwL3QyVFk0ODZNNkNvZmRBVi9hZFJIbmpCZllESXFMMFRqZ2VMMFA2aWxk?=
 =?utf-8?B?ZnZjMkxFMUVxU0lIVGw2VkZ4ekdFeG8xREpPd1lRT1hyRU9XQ3JUb3M4Y1NF?=
 =?utf-8?B?cmJPQ0VNL3BVODlheU5tOFlyUDdPYndHVDl4b0Z5dWtzbUFWbnp3M2R2bDJ2?=
 =?utf-8?Q?/KDT8ZgZ32VvBKVkzf9VwPupC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee0d637-2b2c-4d8d-d6ea-08de3c1f8a52
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 21:18:49.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4XWNQhcXWNiDdIY6+87eBCMP9NCnBoYb5K6iQ2jWFtulqyDbruxR4ijGb+c/JW7OYUWQOrg064ciI2lqpgPcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281

On 12/15/25 7:34 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is a long-standing problem with ACPI device enumeration that
> if the given device has a compatible ID which is one of the generic
> system resource device IDs (PNP0C01 and PNP0C02), it will be claimed
> by the PNP scan handler and it will not be represented as a platform
> device, so it cannot be handled by a platform driver.
> 
> Drivers have been working around this issue by "manually" creating
> platform devices that they can bind to (see the Intel HID driver for
> one example) or adding their device IDs to acpi_nonpnp_device_ids[].
> None of the above is particularly clean though and the only reason why
> the PNP0C01 and PNP0C02 device IDs are present in acpi_pnp_device_ids[]
> is to allow the legacy PNP system driver to bind to those devices and
> reserve their resources so they are not used going forward.
> 
> Obviously, to address this problem PNP0C01 and PNP0C02 need to be
> dropped from acpi_pnp_device_ids[], but doing so without making any
> other changes would be problematic because the ACPI core would then
> create platform devices for the generic system resource device objects
> and that would not work on all systems for two reasons.  First, the
> PNP system driver explicitly avoids reserving I/O resources below the
> "standard PC hardware" boundary, 0x100, to avoid conflicts in that range
> (one possible case when this may happen is when the CMOS RTC driver is
> involved), but the platform device creation code does not do that.
> Second, there may be resource conflicts between the "system" devices and
> the other devices in the system, possibly including conflicts with PCI
> BARs.  Registering the PNP system driver via fs_initcall() helps to
> manage those conflicts, even though it does not make them go away.
> Resource conflicts during the registration of "motherboard resources"
> that occur after PCI has claimed BARs are harmless as a rule and do
> not need to be addressed in any specific way.
> 
> To overcome the issues mentioned above, use the observation that it
> is not actually necessary to create any device objects in addition
> to struct acpi_device ones in order to reserve the "system" device
> resources because that can be done directly in the ACPI device
> enumeration code.
> 
> Namely, modify acpi_default_enumeration() to add the given ACPI device
> object to a special "system devices" list if its _HID is either PNP0C01
> or PNP0C02 without creating a platform device for it.  Next, add a new
> special acpi_scan_claim_resources() function that will be run via
> fs_initcall() and will walk that list and reserve resources for each
> device in it along the lines of what the PNP system driver does.
> 
> Having made the above changes, drop PNP0C01 and PNP0C02 from
> acpi_pnp_device_ids[] which will allow platform devices to be created
> for ACPI device objects whose _CID lists contain PNP0C01 or PNP0C02,
> but the _HID is not in acpi_pnp_device_ids[].
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/acpi_pnp.c |    2
>   drivers/acpi/scan.c     |  115 ++++++++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 111 insertions(+), 6 deletions(-)
> 
> --- a/drivers/acpi/acpi_pnp.c
> +++ b/drivers/acpi/acpi_pnp.c
> @@ -126,8 +126,6 @@ static const struct acpi_device_id acpi_
>   	/* apple-gmux */
>   	{"APP000B"},
>   	/* system */

It might be a little bit confusing to have a comment for /* system */ 
still here but have dropped all the IDs that previously corresponded to it.

Maybe lose the comment too?

> -	{"PNP0c02"},		/* General ID for reserving resources */
> -	{"PNP0c01"},		/* memory controller */
>   	/* rtc_cmos */
>   	{"PNP0b00"},
>   	{"PNP0b01"},
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -42,6 +42,7 @@ static LIST_HEAD(acpi_scan_handlers_list
>   DEFINE_MUTEX(acpi_device_lock);
>   LIST_HEAD(acpi_wakeup_device_list);
>   static DEFINE_MUTEX(acpi_hp_context_lock);
> +static LIST_HEAD(acpi_scan_system_dev_list);
>   
>   /*
>    * The UART device described by the SPCR table is the only object which needs
> @@ -2203,19 +2204,48 @@ static acpi_status acpi_bus_check_add_2(
>   	return acpi_bus_check_add(handle, false, (struct acpi_device **)ret_p);
>   }
>   
> +struct acpi_scan_system_dev {
> +	struct list_head node;
> +	struct acpi_device *adev;
> +};
> +
> +static const char * const acpi_system_dev_ids[] = {
> +	"PNP0C01", /* Memory controller */
> +	"PNP0C02", /* Motherboard resource */
> +	NULL
> +};
> +
>   static void acpi_default_enumeration(struct acpi_device *device)
>   {
>   	/*
>   	 * Do not enumerate devices with enumeration_by_parent flag set as
>   	 * they will be enumerated by their respective parents.
>   	 */
> -	if (!device->flags.enumeration_by_parent) {
> -		acpi_create_platform_device(device, NULL);
> -		acpi_device_set_enumerated(device);
> -	} else {
> +	if (device->flags.enumeration_by_parent) {
>   		blocking_notifier_call_chain(&acpi_reconfig_chain,
>   					     ACPI_RECONFIG_DEVICE_ADD, device);
> +		return;
>   	}
> +	if (match_string(acpi_system_dev_ids, -1, acpi_device_hid(device)) >= 0) {
> +		struct acpi_scan_system_dev *sd;
> +
> +		/*
> +		 * This is a generic system device, so there is no need to
> +		 * create a platform device for it, but its resources need to be
> +		 * reserved.  However, that needs to be done after all of the
> +		 * other device objects have been processed and PCI has claimed
> +		 * BARs in case there are resource conflicts.
> +		 */
> +		sd = kmalloc(sizeof(*sd), GFP_KERNEL);
> +		if (sd) {
> +			sd->adev = device;
> +			list_add_tail(&sd->node, &acpi_scan_system_dev_list);
> +		}
> +	} else {
> +		/* For a regular device object, create a platform device. */
> +		acpi_create_platform_device(device, NULL);
> +	}
> +	acpi_device_set_enumerated(device);
>   }
>   
>   static const struct acpi_device_id generic_device_ids[] = {
> @@ -2571,6 +2601,83 @@ static void acpi_scan_postponed(void)
>   	mutex_unlock(&acpi_dep_list_lock);
>   }
>   
> +static void acpi_scan_claim_resources(struct acpi_device *adev)
> +{
> +	struct list_head resource_list = LIST_HEAD_INIT(resource_list);
> +	struct resource_entry *rentry;
> +	unsigned int count = 0;
> +	const char *regionid;
> +
> +	if (acpi_dev_get_resources(adev, &resource_list, NULL, NULL) <= 0)
> +		return;
> +
> +	regionid = kstrdup(dev_name(&adev->dev), GFP_KERNEL);
> +	if (!regionid)
> +		goto exit;
> +
> +	list_for_each_entry(rentry, &resource_list, node) {
> +		struct resource *res = rentry->res;
> +		struct resource *r;
> +
> +		/* Skip disabled and invalid resources. */
> +		if ((res->flags & IORESOURCE_DISABLED) || res->end < res->start)
> +			continue;
> +
> +		if (res->flags & IORESOURCE_IO) {
> +			/*
> +			 * Follow the PNP system driver and on x86 skip I/O
> +			 * resources that start below 0x100 (the "standard PC
> +			 * hardware" boundary).
> +			 */
> +			if (IS_ENABLED(CONFIG_X86) && res->start < 0x100) {
> +				dev_info(&adev->dev, "Skipped %pR\n", res);
> +				continue;
> +			}
> +			r = request_region(res->start, resource_size(res), regionid);
> +		} else if (res->flags & IORESOURCE_MEM) {
> +			r = request_mem_region(res->start, resource_size(res), regionid);
> +		} else {
> +			continue;
> +		}
> +
> +		if (r) {
> +			r->flags &= ~IORESOURCE_BUSY;
> +			dev_info(&adev->dev, "Reserved %pR\n", r);
> +			count++;
> +		} else {
> +			dev_info(&adev->dev, "Could not reserve %pR\n", res);

Shouldn't this be louder?  Like warn?  Or do you think there will be 
normal conditions we see this happening?

> +		}
> +	}
> +
> +	if (!count)
> +		kfree(regionid);
> +
> +exit:
> +	acpi_dev_free_resource_list(&resource_list);
> +}
> +
> +
> +static int __init acpi_reserve_motherboard_resources(void)
> +{
> +	struct acpi_scan_system_dev *sd, *tmp;
> +
> +	guard(mutex)(&acpi_scan_lock);
> +
> +	list_for_each_entry_safe(sd, tmp, &acpi_scan_system_dev_list, node) {
> +		acpi_scan_claim_resources(sd->adev);
> +		list_del(&sd->node);
> +		kfree(sd);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Reserve motherboard resources after PCI claims BARs, but before PCI assigns
> + * resources for uninitialized PCI devices.
> + */
> +fs_initcall(acpi_reserve_motherboard_resources);
> +
>   /**
>    * acpi_bus_scan - Add ACPI device node objects in a given namespace scope.
>    * @handle: Root of the namespace scope to scan.
> 
> 
> 
> 



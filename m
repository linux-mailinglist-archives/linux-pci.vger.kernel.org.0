Return-Path: <linux-pci+bounces-35150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3679AB3C458
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 23:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527DD1CC1FFD
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 21:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9077273D83;
	Fri, 29 Aug 2025 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IbPQUHSX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF5E258CE2;
	Fri, 29 Aug 2025 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504210; cv=fail; b=n9iYChEaUcFIFBt+gy0RwVcu5cYRlaeoTGV7aMAMJ5Ewl29sJM5LM0chj3UOpcvVu0FUUgQbE3atUc0UkGgCKI7pGdOr5pQuL13HU1J+Kgj/+n5PaDL90/mlrdwoNh29qtSxPQlhOeGua+on9kJY4yiYo7mAovQkfberJnTMtj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504210; c=relaxed/simple;
	bh=NaV7g+wCiRUqlbXp5LlyaT02FOS1HI4/1j1N9i/OP3U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mw2QF58oPloCfQs1WSArMS8RCE7nJAZgzValZUtwY2pzK8FNeXLeCITv23bXwVRpnlpFblC4NuSRR4PbNQaVVJ1MkylyVjr7BE+PSpmkDIunDiwuteLQzDbDyBvStL3inmRUyF+oY1EJep5DCPAjRSi+EiFcPsxoOw/RaWdmFR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IbPQUHSX; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZ3A4P2WQLVtfMMmyiAJ/gaCKsFpgnmk6ciCxQpzxjrSdzlVzT8Q7NW6XvfCxtyJhM2MoQY3z+ehut+zhK6s1SffWJkeH75q+bTtbkOxihtKBkuScGYDaVJcALwUk19iIlJWJnPBoXUuXSuZrvYSwV2soajbrnPanYGTqWZeNkRanYXGLQm4LHhIR3SO2wFgP2eub4Bt1OJTFrocZFfAtNSe4EfuUPuOG77CtnsMtPwuX9QewlWBBa9eUYFBq0NiFJ8Q4Ra7Dd8jSChSs3t2Rniowb7wa7dsDHXerjgXCbObtUC0E0K/iKtJuXLmZD8heolk3D5h9WNYBT2kpSxa9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0j8IK4JRUydME7vjAbt57857Nz56PpaPiaAHfYprHQ=;
 b=Z8f2E9gpEuQ0lNmEp01kJ1Yc2R6Xnas/z/S189X8ZTlyZP5znKraQG4/8cQfOe9J4aNeLqinlkAE+8dsPsDsFUF5sGdPdTHRdu+6hVJOzWsm7hT03AwUGefcDA56gTkgndKLISS6tCbBrepX4hPwBoNDIlVl5pj0euqggqGcAVaFXdOm8Wc2eSEWmf0u3VSFGUGiPp50TZBk3NkebUfYarceIV9tIQ6uLJ43ii1a5tNyGsz2V59yT24IXviyk1B1veo0gQB57180jFFcnACRQ/oaFeKkWyFrtMaN4jS4KWF0izt9jsps0Je7McAN/DSEGHSNLFzclz690eJOYw7Zkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0j8IK4JRUydME7vjAbt57857Nz56PpaPiaAHfYprHQ=;
 b=IbPQUHSXoErglYCzbYS6I3MWIgAt6PO51H5GCWWIHjL9IhjMxrV+U/DfjoatVMiZQbBYPF5+cYQb3hFFQmju6c4ghV2zKP6b93hxeavPzmzMCJocjtXR8sTvnA7eyFQmLY1ic7o8Z2vtEvFZilS8LyzGQpZM+ak1gIhGNErJuvcNLQsfzB4c/OD3x82aqydhGReO5lqYe110lRN53stLxGwfFcvHw4p0iuzNUh3bmI2yWggiG7cqSvF/IG1bpejzMUx0/Cefgi3QoSc4BrhZg+TtiMnWHt0R1tROlzP1lsCUgGAgUCM6F9oul5cuNo/uKX3t5ig9f7NFaPCf63jYCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 29 Aug
 2025 21:49:58 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 21:49:58 +0000
Message-ID: <d8914135-3bff-40b7-8642-139a32b47573@nvidia.com>
Date: Fri, 29 Aug 2025 14:49:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] rust: pci: use pci::Vendor instead of
 bindings::PCI_VENDOR_ID_*
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>
References: <20250826231224.1241349-1-jhubbard@nvidia.com>
 <20250826231224.1241349-6-jhubbard@nvidia.com>
 <DCE3EV79EX7N.DCIT9JWFGXGG@nvidia.com>
 <4b525afa-1031-4f99-a1ab-e89af77616eb@kernel.org>
 <cd20f283-bd92-47c9-a336-fe9ff46d82ed@nvidia.com>
 <5fa42689-4f7b-4770-bc44-a4c17d9de79f@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <5fa42689-4f7b-4770-bc44-a4c17d9de79f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::35) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: b22073b9-afcd-41c2-a742-08dde745ffab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjRSM0VwSjQvcTlHWWZVMXk1d1BMTDhVUlRicFJNZ1ZPc3RkQ3B0RWs3RUl2?=
 =?utf-8?B?NUdNMWQwb1VSVktBT3RwOGwyWUVuUkorb2NWVk43YUtDY0RrR2xxZDVqeUVj?=
 =?utf-8?B?dU53amFwQXJRQjZ6dnlxT0NGTWRMTWQ2M3kxdGcxNlBBYmhJSnhadjRIMnps?=
 =?utf-8?B?ZVVEKyt2TXRoSFA0dzNuSWhtRkZJWGk1TmJMWmduekM3ODZwUFo2MHg1Mmlw?=
 =?utf-8?B?eDVpSldYcEczRm9XczNFcGNqWVZJTUtkSHh3N3pOc2hDUzNKYVlQWlBleDNq?=
 =?utf-8?B?c1lyV1NJQ3hZYXozNUkxV1lVblR0M1g4SFg4S0F0aXovdGJiN2JqZkFiUzdp?=
 =?utf-8?B?RmxrQW1XdGdHcmtGRGJWRGM0WlJ5c2R5K2ZjSlNrUlc4YktQbzJ1LzJtTCtw?=
 =?utf-8?B?ckFGTG40cGFucnE1ZGhUN2RqQTk4STdEd3haSkFuMGRiZEZzVDBQbXlUaUlJ?=
 =?utf-8?B?OHQzOXZjbFpBNjRuWnhyRkhuNDc4cExUZUpCVUtWdFhVbThwa2kzUWhrSDJB?=
 =?utf-8?B?cWMxdVhzakNCaUwrTXhJN1BLMVIvYXVWK1prS282ajJqdEUrMGpSbVpLNmVt?=
 =?utf-8?B?UThtU28ySHJCV1FYYlNQTnBvanh5MHZOV00xRmlsRDlyY05zMWN0bFNKVDZZ?=
 =?utf-8?B?aHhjQ21KY1NLMG1KdERyb3N4ekY3ZGViOVJRNUxHbkpQVTRMVGkrbGsvbjJW?=
 =?utf-8?B?aGZEMjZGeFBWUjl2U1lTdGN3ZVdUajVqalZoLy84VVRLVTkvUzdyTVBTVUha?=
 =?utf-8?B?b2RheGJoY2R1UEhyc2FaaFRIVW53NzVUTHo4MlNLWnpmNXpvUmY0RW5aRmNw?=
 =?utf-8?B?YVRRUEl2Z2NkdVV3S3plUjRvMmUwdjhKcE1WUDlkL2doMldoZGdwbXdPK0V2?=
 =?utf-8?B?YUZZdHhEam5idVlSWVF1bG1scEJnL1lDUllwa05KbUV5SFQvVnpHY0tCY1FS?=
 =?utf-8?B?VDBZaVhRSXVTMURxaFNEM1JVYkdrWFpUWDRvQ0FITkNZdCtGd09IZFdQbEtv?=
 =?utf-8?B?WEVCSVF3R1NLRXdwazYyMVI0MXFQZFVvb3BKZ3JTdW9rS1RzR1VQWjN3aStB?=
 =?utf-8?B?QzZtZU9peUl6alllQU0zQTZPUmVmVkVSbHlkZ1NTa2Z1MkxuUFlFQUlscVgy?=
 =?utf-8?B?VndNQUtBU1IrWGNMNmo1cWtrSVhkYXR3cEdzRWJ5RnExMUtRbDhwdzI1UnE0?=
 =?utf-8?B?bzRlVEY0WTJuN0VXN0o5Qk4yazV0ajNyUEJTREw3dFI0bzg0OHNlUlhIS2ll?=
 =?utf-8?B?b1lGcEx2eU1mR1BwSEhaaTJ2aWI2b0FOc1RleVdwRWIzMDZzTVVWbDg1c01Q?=
 =?utf-8?B?eUxLUVRxUElyeDhvWXJlUXYzZ3NDaVJhQzU3RDJ3MkNHTnNEbFlzZXdkUGg5?=
 =?utf-8?B?WkxoUDQyZmg0bGZGVEdmN3RYbWtXUk5IRDdEY3hTWlM5RSt2VFkxSkVqdzFZ?=
 =?utf-8?B?b2tZK0FHaTNld0hxeURjcTA1S1RUY2Q2dUpSOHllckdWOTU4SkY1aVQ5VGpr?=
 =?utf-8?B?NHhhVy9MQkZROFJNZzYxUkd4YWd6ZWxNYU11VnZMVGt4Z3hiTE91K3RMc3lz?=
 =?utf-8?B?eGRDWDRRVzF0eFo0dExWTWptcThwQ1BydzNtSWdJYXlodzJ6M1dwaDlMOHZN?=
 =?utf-8?B?RjhkYXdqVWRGSlFRdGNteGpZcnRsdWtjVnFIeXh1K0tYRTFabll3c3ZIL0hB?=
 =?utf-8?B?WWhYOVRlZDBPZ3FmczM2VFZKR050U3NzakhlTERJb0R0VU81Yng5T2x1QThQ?=
 =?utf-8?B?V3kxMXNWMTVoM2lxcm1GYjhCays3M0ZRckFLTk9uTmozb1JNSjlSOEJFZW5H?=
 =?utf-8?B?c1IvUlNMQ1FzTWRmR01Ec2ZycGlReFREUXpWeU9iUGVSMUhtRjcwcEtDYWUx?=
 =?utf-8?B?bS9xQWpqK2gzZStjb1hFMjI1Tzh5Wm45UHVIbjVKMXNlM1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVdGZHVjNTBoU1RzMUFVTnBmTUoyem1BZENxOXhaTGltaS8zT3cwaEQ1Q2sv?=
 =?utf-8?B?alptekMxQzBqZnBOMU5BZC9acUR0Lys5Z2dtTmdwZ2JabkZ2RG1VNDZVeEx3?=
 =?utf-8?B?MThzNU9QQmsyMFl5YUJDUkFVQk13TVVxMFNkU1RyNlRwUktMVEUxeUczRjFB?=
 =?utf-8?B?MDJwemtlRGdyaFBtYitUOElsYzBaRmh0TXRJMG5vUjc1SUVCWmJocjRvRFZH?=
 =?utf-8?B?M0wzcEdjUlJZTVk2dzhCZWZzMnFCN1hjSHU1cHNtYjFEOEN4VlRiUHA2VVV4?=
 =?utf-8?B?MndxektnVTVGOXpPVTVXa0tQaUdSb1ByOGdHTktESzBob2lmNmNRL0pLZ0g3?=
 =?utf-8?B?NWJlL2VsaXdQMk1pNWRjdmMwM0NHNnc2VlVTQytlK3hCN0p6RzJ6T1pJdHl1?=
 =?utf-8?B?WkU4MTcwTU84RVpDc3RhTkxUUFAyQTN5bEZxc3paQ2VuaXNCdmFWYTZ1M1p2?=
 =?utf-8?B?VGdIWVVJRW56NTJ3ODFKNncrMDhjdWZuM3VrdFBGNDlJMis3SzdMVGE1YXJx?=
 =?utf-8?B?N2oweW5iNEJpajRjcHd3NHROc21RbFU2ZGE1SlZyNmZzRDNVTitBSHhFYlUy?=
 =?utf-8?B?UnVUVzBoUFg5RUlTMGplUDNWbUhXTUNaUUNzTkhvcTBUb1RqOTd4dWhNK0Fk?=
 =?utf-8?B?bjlPMnJsSi9JTmkrVmtlQTE4aDZmVDRQTFllc1BQNVJDaENyRW1mSi9vZVlF?=
 =?utf-8?B?SjF6RVdjRFJwbllKQWQ0TloyNlZSeEJrWCt3d29wVVY0cmRJRnRGb0ZPTm41?=
 =?utf-8?B?akQzZzJneXFraDczUVJkZmo4TnVibkxJWmNWNmlOS2FiRGdzVHV2SE1zSXVi?=
 =?utf-8?B?bEtoaVpRNjVnK2RLQ04vbG5xMnpISE9KTTR1TC8vQjVDTjRjbTRUMWJaWGdP?=
 =?utf-8?B?MjlZL29YQnNLemkvUE0xeXl5OVRkVTNiUHFtMW5LYS9aamZwVVRqSS9kSzZj?=
 =?utf-8?B?RDlyZWJhNWhrZ1B4SkVDa2hQMklOWXRHN1UxV0hKVnR4TGx5a29NUWx2MWJL?=
 =?utf-8?B?dkFpYWhiYzkvejhFRUwyY0RHMG05eUR5MjIxL1ZwYnpwYzZsUWpOZnNmVEV3?=
 =?utf-8?B?V2o4djBHLzBFcEZoajU3aTRnREwvTlB6THByWnJibXlWMlZJbURwL01IUlpo?=
 =?utf-8?B?ZVBOUmN5aHhHVWhRaEhZVGo3NjVBVnl0QlUxT3VrY1hpeFAvMlV5SWhGUzUx?=
 =?utf-8?B?RzdNRHFrVit2M1B5d2VwTFR2QXBUT0xkZUN1NjdPRUlQV2hHYk5udzhmMUc3?=
 =?utf-8?B?YVhsdWl6STMvR3NHZkhsNGFGVmc2RTNyYTJGcjFSWEU0OXhmbVR4S0FRQ3NW?=
 =?utf-8?B?SXUyNS9Dd28zRkZFTzNLWHRldG90c2h5R3pRMjRSTW1UWTJRZ2kzYjBQVHU0?=
 =?utf-8?B?eUFqNGhHSnlWV1N3b2pRVkdNb2syVDZjWm90QUFQbE1mcVNNN1ZXc1NXbVVK?=
 =?utf-8?B?M05TbFc1OUVjSVpVOHBtc0h2dEF3K2ZzbHUvZ3ZpL2ZQWUlxWGQwTW5rNFNw?=
 =?utf-8?B?Z0NtemNnRzhNVFBVMHdicFBObGl0ZE9NbmtLZ010R3Q5UjdXT0dHTnVVZ0hY?=
 =?utf-8?B?SzNvdlpwNWR5UitpZEdHSndiMmJhSVFzdHRvOXBEUWl1amV1MGxjR3MwaEZu?=
 =?utf-8?B?bk9RUjNOOWw2WjNod0Q3OWVVcTZpNFhSQ2ZoeURUSEFBMktPdUNtZzFCTTNE?=
 =?utf-8?B?bmk5cnRieWZzRGgwQ2IvalNFK1ErZVhVR2w4Yzc4QlV0UlpHdDZBNlprcVds?=
 =?utf-8?B?YWRsMEVieW1WNFplb3M1SHExSEJla1NuUFBZUGJiS0NyTlVOcnJwTTJuWlZv?=
 =?utf-8?B?akFKdTAvUnVKZm9kdEZhUUhOTWdDQjkzZnRTZWhUekVFSWI1NlFaQXpvZjc1?=
 =?utf-8?B?a0p3ejlUcVY3eFpUeUtCbzF5WE03bytEYk1Zb0t0N3h5OFUwb1Ixemcwdno1?=
 =?utf-8?B?V3VWUTZHc1BnVnpRYmtITjU3cFhIT3FTR2FMeVVESkU5NnQxWnFDbXhNd0lN?=
 =?utf-8?B?MzhSY1RURDdydWdNYVlna3lSME1kejBJNUtzc1hnYllQY1JhTlpkWGZWY0ht?=
 =?utf-8?B?NVVxOXVYSEkzTmtPcUF1Y1J2aXNWVnFOUmR6Nm43NWF5bVVkQXJzOGF2MEV6?=
 =?utf-8?Q?qoIb8mmfXfw5eeQ1blkr9qGKn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22073b9-afcd-41c2-a742-08dde745ffab
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 21:49:58.6182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98YGARBDjtZsrlRRtyfvMZS0e0OJb7NWtaYEIdsYDfXiHAHzyD79XXmKkrFP+dCnBUZ1FFibzTmssGeF+4HrmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712

On 8/29/25 2:46 PM, Danilo Krummrich wrote:
> On 8/29/25 11:38 PM, John Hubbard wrote:
>> On 8/28/25 6:59 AM, Danilo Krummrich wrote:
>>> On 8/28/25 3:25 PM, Alexandre Courbot wrote:
>>>> On Wed Aug 27, 2025 at 8:12 AM JST, John Hubbard wrote:
>>>> <snip>
>>> makes a little more sense if this patch simply introduces the example as an
>>> example for vendor_id() itself.
>>>
>>> I think struct Vendor does not necessarily need an example by itself.
>>
>> I'm not quite sure if you are asking for a change to this patch? The
>> example already exercises .vendor_id(), so...?
> 
> Yes, I think the example above should be on the vendor_id() method rather than
> on the Vendor struct and should be introduced by this patch.

ohhh, so located directly above it. I finally get it. haha. I'll do that, thanks. :)


thanks,
-- 
John Hubbard



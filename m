Return-Path: <linux-pci+bounces-24856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB273A735A4
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 16:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C8617B3F7
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C013140E30;
	Thu, 27 Mar 2025 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="riWdrp9I"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5958015746F;
	Thu, 27 Mar 2025 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089456; cv=fail; b=Dinbzmndw6UirYTgKT3S7TBbhZjiMDFtk9sE7MTlMxXyG2uVsK+mouSzFCGq8koJssvy73eBwd4nN2xG4/iSLlk272Pv80CNxseN236AYm1/nGjqKQ9o6MKRY7VkgOZD5ISn8gJC7UzbEknYVhRJjuKKsURwY4GoVGxXv0rJGic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089456; c=relaxed/simple;
	bh=QO1U42wcctveiGDZTBI1xswNStpA76N8KPIs72AEWW0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ugD40jWwa7c3yJ0WZNrBX58j2UzoMUO23oIoL2o1sRSm/Oh6uLZhwh+W2SLvFG/SrmASHdicUlB+XJEhawNJetrKqlwsuuzTbMuDdmPwzKy5cQ5XUlopV/UpysNaqddRQosJOc118a4XRq48V5lxt1XHaoyVS0pxYNcJuONH0ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=riWdrp9I; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8SLUDweVqkqK+8nQvGkRMnGSwovbhUg0tIEYTRfsRU/JhqbQ+dHxTmE7J7g5t1rVEvMR0/w7WHguyU3XtJ+CMU55f91VIRzmbTED+qBsY2Ova809vdgfwYmmiwD4QBj15wMxPiQBEPP6g5+cKlNLcXhCGa0UFdvLgHYNemNEtYIEHlvUFN52WuFNvqwGUB5pf2tK9YMpu0irgWL0cgrrjx08objMS1AAPlTGm87F0KOzh7WV2eVATKzHf/TmRkHh0NoJFaBjD4hAtSF5ddV/S0BZNCjnxxDCJp83qzo6Ci8D+gAQVE93EVNqfxL4UpVWjVtgzhVMyLaARJkR4jNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvpmrDJRlUvKdHVQp+e3/Tso69fxCbE062GxqVYwdNE=;
 b=D2+EPeuMtAh6hzoTjLy0qnZXN/DtkF+/Z1FgcpupXD57OJYO8EWgHckp9Wkj6TS7liY3RYyfJHDu4uSqOtMihf7p9p8MFT798Vrx8jeh0G8AVJzeQN2NaYIiy6JjArK/xDLFXrdpIqtwpb55LAREXpcIUKhMb3NSe8XraRe4jLZSUoG1V5l4kUTzJS1LHcel+MJF3vQgtqjGxyntxud2aBN4N7tCRoOtaaaLiwqqAMHw2wURA/Ze2GHmzVtPpCOBpXdYZKkNmyTDe+0BwcsqNLAYBC/0RYXgX92PKOuDqu/dCGAIXGOqXDhQbsET4qW7x7BeTJ5bcAgygox84AAGsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvpmrDJRlUvKdHVQp+e3/Tso69fxCbE062GxqVYwdNE=;
 b=riWdrp9I7UqFDwKXLAT0KRIF47gi1b/Y0tKBQG+2zStvLliVAlphYfk15l1y/reikc225j4Z7BPgyeZ8k13smY5lj6+j7lndvfKj6VjEe1nn6Do6f8ZLR6kPzv0ZX0qnSQ1+26i5HmyLGFIoZwdfM+wzElO8xXkViWtBPgsy648=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 27 Mar 2025 15:30:52 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 15:30:51 +0000
Message-ID: <9d0636f0-784b-4074-9364-45b2377947d9@amd.com>
Date: Thu, 27 Mar 2025 10:30:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/16] PCI/CXL: Introduce PCIe helper function
 pcie_is_cxl()
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-2-terry.bowman@amd.com>
 <67e56a9933d43_160b72946a@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <67e56a9933d43_160b72946a@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0080.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::17) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ff4178-7e09-47eb-3e36-08dd6d445b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHo0ZERtNmJnTmpJcHV0Tis0L29vdjlDNzg5SEpXem1QcnVFWTBXQ0VhOHhK?=
 =?utf-8?B?c2FrenQ3NkV3d08yd3g4WEdEQXJjY2dIY3JwWnRVTVZjZkFCdStwb2kwQ05w?=
 =?utf-8?B?YjByTWNGS0UrTDI2cXVyUEY2T2RSdHVJSlQxLzdiU1YwNjk1M1dUYWFFMS9N?=
 =?utf-8?B?QkIvbUo5ejcwL3hidXNJVHpZYmtnL0hZaEFTRmJMUldvYjRQNWN0ZWsxQ0Vn?=
 =?utf-8?B?UWVuR0dHeUVRK053T1FMRjE4VHg5OWF3dEREaWIyRGJNcVYvYUQ4UEFNZFNW?=
 =?utf-8?B?STRBVGN5UEVsN3g2UWVMR2U5aDU0ODkxcVJmZkZoQW02aTNNVHJrUjNPOVUz?=
 =?utf-8?B?UTMyZVZtbUFVK0preUpVZjQzRmt6UTN6MXZTR2RJMUFaa1E2djlyc0xNdGtK?=
 =?utf-8?B?SFZ4TGtXK2l1TnozSnY2VC9lNWd4SStDOTZLVHh5d2pNQmJEZHlUS0kvaDlJ?=
 =?utf-8?B?NnlKcVFaOVk5UWJHTlJkWVAvMXpOblVSbmMrUzVmbHlzeWlrenlsOTMxaTdH?=
 =?utf-8?B?WWQ4U0xPbW8xWjU3Q2RwY0RoUy9GMUhIb2Y2NjJvWm9qSkV4S080WG15UVIy?=
 =?utf-8?B?bi9oQXZBcFI5VFhVbEdnZUN5U0JBeVlQeHBDYkhBaVREcHpNRGZWYStFWmEr?=
 =?utf-8?B?cU1GbnBFWHp2YmxMa2tPUVhnS0NDQW16U0dBbTZ2ZW1lbFFaby9vczloZ1NQ?=
 =?utf-8?B?eHpad3czVkZwSjROSnFWQkswRVdGVW4rUWhWMUpRaE84SjVTVzdGQzFXckpY?=
 =?utf-8?B?bmU1amQxRVZOYndNRlltTS9XaFFJa1BvMEE4MmtaUkZkRC9nbjhEV1hLZ2s5?=
 =?utf-8?B?b1NuSUtQaVE3Z3FrSGx4Y1JZaDZBeDFIbEdobXNLZUxMckNKdURtZG16TzRr?=
 =?utf-8?B?UzBObTdVYUVJMm5TZDZobWI5SjdFbnY5SEZLSWU1N2ZvUjk3akg4VG1NM2Nj?=
 =?utf-8?B?WjNmNDZMUkNwamY1ek0rSEhua0dwa1lyV3hVSlRQYjE5TFB5SUsweldiaTg3?=
 =?utf-8?B?Q1d1R0QrNDZ4NURlZmQwYzArU2krS04zZ2NETVRNTW5SVnNDL24zN3ZveU9v?=
 =?utf-8?B?TmdHc2ROZFBWdS9RK2dBRTNPMEw1QjUrcXoxZlFtampRTVIrUjRXenpIejZt?=
 =?utf-8?B?WnBXUFIrYlVhM1N2dGZoM1pleVFDbXRwQkdYd0FQMHd4VXNCTVppTndndnUy?=
 =?utf-8?B?L3hRRlJBTU0rTStTR0pqeW1JaXRaUnFPcUZLeXdVN1VyVFNBdWRjV3dWZzgy?=
 =?utf-8?B?cm8vWXFFQU44NGw4c21vaVJ5OHczaXlzd0VvSGQvZHlvQjN1dGh6K1FFMmNM?=
 =?utf-8?B?OVR4K1NMQlJsUTNqV2l1TGY4YVZRR3ZhVHlRTFBxR1hVclBMd3R5dm9OVkNT?=
 =?utf-8?B?Y3VhNnpHTUNsWXRHY05EZng0RDNHTmRTenhjOExlVFJjYlVLeVM4TnMvWFFV?=
 =?utf-8?B?NGFESUV4V2JqMmhNdlhoampnbm00YVlXd1FSejR6d09MYnlMRFlZdURrV2l6?=
 =?utf-8?B?VU1LaEdNQitlZVlJbTNtODJTWXBpUFEweDNyNkQvU1VXWHdFSmdGY1E1bnc3?=
 =?utf-8?B?Q0JIOUtvZUI5MmNpSFFmVU9nTWs4dDhBQnBLMUV0MnI4V1BxZURZc1NrREE5?=
 =?utf-8?B?WXFMVjI5UXlvVDU1UmRBRkFCczlVVWlnY0g3bUlKZytxOXR2ajREVjNwTUN1?=
 =?utf-8?B?S2JXbFM3bHhiNTRvcWswQi9jQzlsdHg3emk2YmZaYTJXM2NFRFB6U2l2YVBK?=
 =?utf-8?B?dWwrNUxmaVpXcVc0U05RaEVVRkIrUjJ5Q055YXJkYWg3L0lqMDJNRkRRcC9m?=
 =?utf-8?B?dmZEbnQ4Nm1uTlFXL05HVjNKei9DUHdqVWU3bHVXazZuVWVMaVhRejAwQmRT?=
 =?utf-8?B?VFJsaGltbHkyNHRyaS8rYVdjcWlRUUtYN0dBQkRGaHVIekRwMVNhVUF0WC8r?=
 =?utf-8?B?amVlRlB4bHNkTFU4TzRPUzVLZzlVMGhmSHZrdUFtcVhkS25qYk4xa2ZVM0Rx?=
 =?utf-8?B?eE5lQkhCRUhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlAySGFWU0dvN3VySmo0Q1ZIRE5BMTBTaitKWWMzU3plTXNVeHFBcFhmOHRo?=
 =?utf-8?B?d1YrZzN2eVZ6Q2hGa3dHSVZDTGxWQWZvb2F1RERGYUhTMWNIYnZwblVrczlp?=
 =?utf-8?B?aVM1WVUvUHZ4WWlKWEJLZDJZVUNPVFdhOUNKMlFhQWhoMjR3SUptRUhsTzQ1?=
 =?utf-8?B?cHRJbjM3eWIwMFlCVzNPbWFvbVI3Z2R5Zk9iVjNqaXVYK0tUelh1bUovTGpV?=
 =?utf-8?B?Q2lTeXdrNVQ2SzJ3VTlQZ3dYUGNNV3A4cm51V2g4VlRSbE1pL3luN1grdy91?=
 =?utf-8?B?V0ZiTnFVYzE4RklUNlc2dXRYSitLSThJcGNZUjg4eU5mRE1WblhzZlp6ZWZN?=
 =?utf-8?B?RmF5eTZoMFRGaXJmVEkvbzZPRVJDNmxJZUczeDhRSFJUMzcyY1NUbEcrU2t1?=
 =?utf-8?B?Tk5WamN3c1A0ZjgxM2M1djV6ZFhjVGJzM3orNGRWekZ1Qm91VFBuSG5CNXdE?=
 =?utf-8?B?VjhGdXRMSUIyUjdJaDJWNVIwOGxLeFREMUlEc1BlWUsvUUJRT2cvclRvY0hQ?=
 =?utf-8?B?cHNaVU8veVh2TEtWQXRSRzg0NkNWNHpJcjkyUytPUUt2SkowRmlnM3NFV213?=
 =?utf-8?B?VW5lcWs0cDlsaHdCWEhGczNRYUMvd3N6eEhrbGhNbXh3NGdBb3ZBN21icTZI?=
 =?utf-8?B?T0VEbmVVeEtBNWZYVmFkbkVLOHVaSlQxQTN4d09XaitxbXN2bVRDbm0wMjN4?=
 =?utf-8?B?aGdaMlhIL0xJcFU5ZDhIc0JJRHYvUW1kZEpoalJqcHYxS1hwRWQ0M1dzTk1n?=
 =?utf-8?B?VzJJS212SmJlem1xWmgwTTJObGJ3YVR6UWxGWEtKc25ibDdXRTQzNkV4Vjkw?=
 =?utf-8?B?NWpaS055MVVRdytlK2YzMVFaVWxPaTRXeis5OGFZdVNlblNPRGY3Z1drT3I0?=
 =?utf-8?B?cVpDRmpmeE9JdnZPeHZxKzFhL0F5Sis3cnN3ajlGbVpJOE5xSHYxUVNUSTYz?=
 =?utf-8?B?K0FwVmxVcHlHUGtHMmRrTkx0NkhRYnZQYzhFSldKUU9ZM0RYT0QxWFgrRVdt?=
 =?utf-8?B?Qm1qWWptM09PclVlcWFycmhqbW15QVhxb3orNExZeFE4Q242Q1M5cTJyZ1A4?=
 =?utf-8?B?dEhuRUdZRFdpdHcrV0ZtMUVLMjZINFdna3VaclZmU1dFTk9HU0F6NFpINko4?=
 =?utf-8?B?Rlo1TTlDK2RTS1F4ZjJmVk9LZzlQaE1FYlhVVHhSRk5oTktZRnVPSjRkSTM0?=
 =?utf-8?B?dWdyMEs1dCtiY2hHd3YwMkJUelJwMFA1cC9DNG8xTkE5cldZSWtJRU1BUE1x?=
 =?utf-8?B?dy93TkZZZFdVM21xUXArSGxZdnRsb1J1TVIzcTE0NjJNdUhXOEFHREJDMllP?=
 =?utf-8?B?Qm1iSnJLdXJUWTJHbW5OZlJOdTEwQ3U5a3dJbzBkaWFJQ2NzUzV3bGFyWk8v?=
 =?utf-8?B?YWFUeE42bVdaU3IrYTZpS1k0UlNpeFQzbVdTY2tKaU01cytLQTlqR0JhaEM5?=
 =?utf-8?B?S3lPaGFXMnBYZHZCNmtNa0N5V3lGd0pVMXlJeG9Cd3RBdVgxOFYvRWU5RWlJ?=
 =?utf-8?B?OFlmRDFzdUJQeFJ2SU12TVQ4NFNjaE1pMzRtdE1tN1IyR1h5OFB6MHR4cllm?=
 =?utf-8?B?a0tRRUVmZVYrYlorUVdNeTFYNTRsVnZWS2N6djhXTnhyVkNYMXV3emNOb3E0?=
 =?utf-8?B?MjBVdGVvTFJ0TGxwUC9QK2Z3YzdNTVNkMXhYaWdOM0orZkdPL1QxUVhFVjhR?=
 =?utf-8?B?TURNcmxTbkJQZmJ1U2crbnQ0QmdqYlBvOXc0ajlPTkFGamVhOHZ5Vm0wV0NM?=
 =?utf-8?B?R2lpTlhEckhkb1Q3T0YwMXFqbmlncU85MVNKdlQrbFR3d2dEWXRQOUsvNjhR?=
 =?utf-8?B?MjlDeGljc3VtK0dTZHVWVndSMUZWU2I2cnpiTktJMmJESnBxVlhkMEswVk05?=
 =?utf-8?B?aTFYbW1hbXZWRzVackkrbFZDRy9YdkM1S2M3Wk1OVklQMFRxMkN5MnZMYzIw?=
 =?utf-8?B?MUUrWFFWNGMwcTBXMlBWMXFvQ09EN0lsREwzajA3cU1hc2g0ayttbWRCczJl?=
 =?utf-8?B?TzhBYitHQWdPVS93bmtZdmFxeURBK2EwTVNIaGJRczErbzZQN0JOc3grZzdS?=
 =?utf-8?B?QW5vSkF1Z0ZJK3BhUisvU0JGeHoxS2pFUnJZLzk5TmNlVHB0TlRIZlA0dWdj?=
 =?utf-8?Q?sEJ/v8/MPjqqwiKClfmnceGY4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ff4178-7e09-47eb-3e36-08dd6d445b67
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 15:30:51.7654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oIhKjnmWupyTMaZV5FarCnC/G5wyzTp3qwTNKaDNaDAO7DFXIFBJCdX4i1kwb8hsCVEW2KxGTbV1PRZOOgjQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297



On 3/27/2025 10:11 AM, Ira Weiny wrote:
> Terry Bowman wrote:
>> CXL and AER drivers need the ability to identify CXL devices.
>>
>> Add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC presence. The
>> CXL Flexbus DVSEC presence is used because it is required for all the CXL
>> PCIe devices.[1]
>>
>> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
>> Flexbus presence.
>>
>> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
>>
>> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>>     Capability (DVSEC) ID Assignment, Table 8-2
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/pci/pci.c             |  5 +++++
>>  drivers/pci/probe.c           | 10 ++++++++++
>>  include/linux/pci.h           |  3 +++
>>  include/uapi/linux/pci_regs.h |  8 +++++++-
>>  4 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 869d204a70a3..a1d75f40017e 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5032,6 +5032,11 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
>>  					 PCI_DVSEC_CXL_PORT);
>>  }
>>  
>> +inline bool pcie_is_cxl(struct pci_dev *pci_dev)
>> +{
>> +	return pci_dev->is_cxl;
>> +}
> Shouldn't this just be a static inline in include/linux/pci.h?
Ok, I'll make that change.
>> +
>>  static bool cxl_sbr_masked(struct pci_dev *dev)
>>  {
>>  	u16 dvsec, reg;
> [snip]
>
>> @@ -741,6 +742,8 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>>  	return false;
>>  }
>>  
>> +bool pcie_is_cxl(struct pci_dev *pci_dev);
>> +
>>  #define for_each_pci_bridge(dev, bus)				\
>>  	list_for_each_entry(dev, &bus->devices, bus_list)	\
>>  		if (!pci_is_bridge(dev)) {} else
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index 3445c4970e4d..7ccb3b2fcc38 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -1208,9 +1208,15 @@
>>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>>  
>> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
>> +/* Compute Express Link (CXL r3.1, sec 8.1)
> 				r3.2
>
>> + *
>> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
>> + * is "disconnected" (CXL r3.1, sec 9.12.3). Re-enumerate these
>                              r3.2
> Same sections.  :-D

Got it. I'll change the spec release to 3.2.
> With changes:
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>
> Ira
>
> [snip]
Thanks Ira.


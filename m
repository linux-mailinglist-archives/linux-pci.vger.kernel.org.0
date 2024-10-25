Return-Path: <linux-pci+bounces-15263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766D49AF91C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 07:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087251F22F7F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 05:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935A481ADA;
	Fri, 25 Oct 2024 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="n9SC8FMb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2059.outbound.protection.outlook.com [40.107.247.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD7B641;
	Fri, 25 Oct 2024 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729833331; cv=fail; b=GaCf3koPm7wbBN9wqNS/mWJbk9rl8DYmeDGvaY1nies70Yju2uTMvtExyXhq90g2eN9H65UiPxVVWnX+FQSFquWbdVC4greKdsZNvAR+QZ+e79vcy+JcOMsoU43FmsM/n0i683MTh3zEIjqOQxvNS1grbDTJQHA+fVHXaTNOdM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729833331; c=relaxed/simple;
	bh=SaNXVBj+f88hWBdF4TS8HGrhh141obfm0zPuxztEbGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g/HZPMb3FBmPaj0atNmOCx3y9PPNtxx02oRCdTcBCF5vS/qt9sjFJ/OoIo9z0u65yEhEUs8TllAwvIYW5iM9AIyGSd0UGNLMWoQLzzfd6rxvLzdDRaHA0I8a25TIPmvo86GPoMVjIcFD6nSFnrJkj+FMXwT3AaFSc2ewylZ5sgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=n9SC8FMb; arc=fail smtp.client-ip=40.107.247.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNNIYL3Vcov3XC/P/Md/KJ2ZlW/FUnjtxggtzWOLlxJx3Tx53pXSmHTTUzFDC4XODFigLJlyD3Lvszh62GKDKHdi9O/JehHJHA8USVyok/Nvo45W77Zg2PJm19Dj98kODCeCKZTosD4UVSLWqBRPiql/VSj7ncju4K/jfMrCzLl9X2dGZ/rlIBjXVJiE3Lo4PxR85lUIYjRsBu8/ZhG/6XRXrU97r6A0DwZeT7QqTf393jlQqIY/1ivutUlVtgG4VNCmdm+tT9A88xRJN8slQmdiixziOCF0+tjARrlJjF90ylCx2NOU2By15U1dBv3LfVa6fNcJEdkJBa3w5zPNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0pRpCOj9rDEMoYsuBth9GOhFMd+u8z+UeimDyTIpMQ=;
 b=rUwD4TtA42EnnxqOaWiZV63lqADJmK1y8mC3TkdaoDz5GpZXab6WEUTVP7wEaM55QekFYK10vc571G2o+1QvNr4opsZOVOQKArZlyAGOR6ipcvU0Hy4svtJvgAurAqCxDiqtuxTdEVLRNkAH7MkuyVa35L9d1KuIABs2mTknWYZI/j0Adq3+KS9kcW9ir2YTFniT9oEOrYCQBtEHwJP0Fr6H8OcfGOPToMAvjYNq7+niPIzfHRFhPEjlKOuEDrhWjD2OkufeGrYRVLMSHBAW/Va/ncVElZENYOeHLxsiZsqMt+1v4jJeUM5P6vFPKaSTrzL4BiUdfPIFWg5bTRpg7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0pRpCOj9rDEMoYsuBth9GOhFMd+u8z+UeimDyTIpMQ=;
 b=n9SC8FMb72APnK+44yrsJtV8Rhz73Iz7Gt3rlbVTTWQwxWeBBLTPtD8HmsiZxEDrOU1HfOV476/IHPR382OLR34kFy4m7rDw4RrV3KoUie1s8MG5gr/zGAFOhoo4y3xz6irKgjaeYsfrPLmx9Ev7ZCxMM+YxkQ/9rKZQeEDIQnttY1K4fcFAT9L5mL391pYdLsgXA9D47gjfqp5tPj/hUapo9pxxCKX/mriexuiAGNhw1byE/dl7qbRjSOBpp6oAGpeZxeHYmCTqGqiI+hzCSJc+6J1pCQ+2YbBugbRcCa67kFXBJ8SqLIrWXfBNE0FX6oaeMVlJDwqlJKdegHIBqw==
Received: from AS8PR07CA0060.eurprd07.prod.outlook.com (2603:10a6:20b:459::33)
 by GVXPR10MB8001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 05:15:24 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:20b:459:cafe::e6) by AS8PR07CA0060.outlook.office365.com
 (2603:10a6:20b:459::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.8 via Frontend
 Transport; Fri, 25 Oct 2024 05:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 05:15:24 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Oct
 2024 07:15:23 +0200
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2001.de.bosch.com
 (10.139.217.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Oct
 2024 07:15:22 +0200
Message-ID: <7ce81fa7-c316-48fc-8013-e1aad9e24fd8@de.bosch.com>
Date: Fri, 25 Oct 2024 07:15:12 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/16] Device / Driver PCI / Platform Rust abstractions
To: Danilo Krummrich <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <bhelgaas@google.com>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>, <tmgross@umich.edu>,
	<a.hindborg@samsung.com>, <aliceryhl@google.com>, <airlied@gmail.com>,
	<fujita.tomonori@gmail.com>, <lina@asahilina.net>, <pstanner@redhat.com>,
	<ajanulgu@redhat.com>, <lyude@redhat.com>, <robh@kernel.org>,
	<daniel.almeida@collabora.com>, <saravanak@google.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20241022213221.2383-1-dakr@kernel.org>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20241022213221.2383-1-dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000003F:EE_|GVXPR10MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 04578fb3-d54c-404f-83b4-08dcf4b407ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEFuQXc3VE9nbm5ERGlMNzNLaEtQbDc2aEwvMCtwMkpwMERuaHk5SEhQZndB?=
 =?utf-8?B?dC84Yzk3RE9CaU5RelUyRC9IYXJmSGdhUTJNSnpQQWxvUFhqQ3Zlc3FsL2Mv?=
 =?utf-8?B?Q0NaMWp6VTR6QUUvaDVPRlVkcStSTTJvbDJjbzZseXpLQ1N2VHNjRjZYRnZH?=
 =?utf-8?B?Y0xQT1FSWWtVbDdYbXkzY2RTWTFzSlN1eVkreUpZUmZDc2xaQzBxL0VQUmdt?=
 =?utf-8?B?QXNoQ3ZEZWVVVklzc2FMcFFZZ0hiaThlQzI0NWxhKzhKT284MGFCWjVXSlM2?=
 =?utf-8?B?d1dlUEdIcmt2NCtUVFZwZm1Fd3VCV1lsT3ZvN3pVRWZ5Q3ZhU2Zlc3FBdGds?=
 =?utf-8?B?L0hGL3hPS2svK2pMOGkweG0za29lYjFPQTBBK2dLVU9UT2VyQmZ5RlhkcC9F?=
 =?utf-8?B?dlFueHpjRjJQWUpSRlFZbHlPOXYzR1RVeXFsNGZPc3hyOGttNE5TSlIyVGVo?=
 =?utf-8?B?aWNFWWQ1TjVxZWFRakVlQXNEeG0vVjFGTk5IVExJRCtSTmF4RG5md2VYTGZE?=
 =?utf-8?B?UTI3ZE9PV1V6TEhsZ1dzcVVsOGpsZ281VDVHOUFrMHoyK0Q1UkRRdXU1R05u?=
 =?utf-8?B?cEdaUXpZMkNXdnFURWpocnVPQlNsUUZvR2ZJaGtuNmlMVFJSdHAwTkZ0ZUg5?=
 =?utf-8?B?MFVxNm5icnQwRzRmMEV0WFI2S2tiQ0NDazdJYVJPa0QrdDhjVVJBd1VwRTdl?=
 =?utf-8?B?THVKY1I5SzJOc0piUEFLVDlrd00vd2F2S2pJclB2bUF2dmxzVHYwRTVQSkJT?=
 =?utf-8?B?cXJEcGZuWktXNkd4NktZUDU3VmZPYjZJUGU0NG5BQTcvTHFubjltZ1djdnNW?=
 =?utf-8?B?L05HYUlxRm5wZVJIT1JpR2RNM1BEUi9nTWVnMGRhVlRhYTVOMHEwRFNuemRW?=
 =?utf-8?B?TzFRNTBKRmRTaG03Snl5UldhWFRXNmloRG9VTmhlTjAwbzVGUDhMMVFyaVVN?=
 =?utf-8?B?cXNSNGwybDVrQkFoUVdQUE1sTjloTkpGTUNEODhUbjVrK08ySU90dVBBL1c3?=
 =?utf-8?B?UGR6VThEcHZYajl5TVpMNE93aXlZbUY4Y285dVRYTkdNVFozOGtENTJhci8v?=
 =?utf-8?B?TEN2YkdLRFlmMzBBNFR2c3FKMUVoeDBCMVpRMzZQa3laZVpOTEZLWFFhM3VO?=
 =?utf-8?B?dzZqb2pwWmhFeTNsTHFpYXVRRGRpbXJWYzlTcHdXdm1PNm4wanl1dDFWSm1F?=
 =?utf-8?B?NU5COWk2RlNzZk5POXIzYUU0SjNqY0NQQlRibStPVGZqdFlRMndrR3lQaGRn?=
 =?utf-8?B?VFNwRlQzaVF1eDBDMTNYQ2QvemVWRXBqSk45SWpuTWgrbjdzYVB0L3hzUjYr?=
 =?utf-8?B?RlRoUFl1aXNQZ29rS20zM1pXVW1BVUZNMVdiWWFSZVBlcUhaOU5vSVBSSndy?=
 =?utf-8?B?THd2Y0xTQU1PQ3ZoNVV5Y2dxVXcwcmJVbTNTbkpqS21SbVdNaDV1TDQvL2F2?=
 =?utf-8?B?djRKY3luRjhMbkErR2xJTmpnNkxvQjRaR1BPc2hydzNlNEl0MGFIUnNUaEFT?=
 =?utf-8?B?a2Z1QVRrYS85WlB0SjR2cHJhYzNwR1lsazhRR1d1cURzV2EzdW1KeU96WFN4?=
 =?utf-8?B?U2FrcTByVVFFSDYzc3BNajNyYjFrdVhSdm5BWHhwVmZzTHlKZENKS1J2L1Jw?=
 =?utf-8?B?eHdnaXVYLzhTRjA0SXExdG9WTDJQWHNLL2puNE5INVduaHVBcHpZUTZpQlFP?=
 =?utf-8?B?OWdaQnRlYUgyUksrZUhOR1B6N2tlR2Rzd2xKWHBvN3hpcnpTd1lDVkQ0RE9l?=
 =?utf-8?B?Q1MzQWZKWkFBdTJURWRJQ3NTUE5UdEZZOW5YT3F0cWdBR1JOTGtjbkdWNmxZ?=
 =?utf-8?B?cnk5QzBWcDZGeHlVWXBIT0F6THFiTHhRTTdodldRcE5WV2J3WUdQUGE2T3g2?=
 =?utf-8?B?TncwV3B6WlV0S1pHOVVFb09Ld08zYWM2a3VVU3FrYm42ZVVoNUlpTmlESGRk?=
 =?utf-8?Q?T/BIY6n6PU0=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 05:15:24.4619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04578fb3-d54c-404f-83b4-08dcf4b407ff
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8001

Hi Danilo,

On 22.10.2024 23:31, Danilo Krummrich wrote:
> This patch series implements the necessary Rust abstractions to implement
> device drivers in Rust.
> 
> This includes some basic generalizations for driver registration, handling of ID
> tables, MMIO operations and device resource handling.
> 
> Those generalizations are used to implement device driver support for two
> busses, the PCI and platfrom bus (with OF IDs) in order to provide some evidence
> that the generalizations work as intended.
> 
> The patch series also includes two patches adding two driver samples, one PCI
> driver and one platform driver.
> 
> The PCI bits are motivated by the Nova driver project [1], but are used by at
> least one more OOT driver (rnvme [2]).
> 
> The platform bits, besides adding some more evidence to the base abstractions,
> are required by a few more OOT drivers aiming at going upstream, i.e. rvkms [3],
> cpufreq-dt [4], asahi [5] and the i2c work from Fabien [6].
> 
> The patches of this series can also be [7], [8] and [9].

Just some minor typos:

-----------------------------------------------------
0004_rust_implement_generic_driver_registration.patch
-----------------------------------------------------
WARNING: 'privide' may be misspelled - perhaps 'provide'?
#63: FILE: rust/kernel/driver.rs:14:
+/// Amba, etc.) to privide the corresponding subsystem specific 
implementation to register /
                     ^^^^^^^
---------------------------------------------------------
0005_rust_implement_idarray_idtable_and_rawdeviceid.patch
---------------------------------------------------------
WARNING: 'offest' may be misspelled - perhaps 'offset'?
#84: FILE: rust/kernel/device_id.rs:39:
+    /// The offest to the context/data field.
              ^^^^^^
-----------------------------------
0009_rust_add_io_io_base_type.patch
-----------------------------------
WARNING: 'embedd' may be misspelled - perhaps 'embed'?
#27:
bound to, subsystems should embedd the corresponding I/O memory type
                             ^^^^^^

Best regards

Dirk



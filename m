Return-Path: <linux-pci+bounces-37346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EDCBB095D
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 15:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987D23B5721
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 13:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FB2284681;
	Wed,  1 Oct 2025 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1k2Vbz1c"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36462FCBE9;
	Wed,  1 Oct 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327151; cv=fail; b=se/kP2wJ1beHEz+HzUpQrwh4adSloemLVOm0VMdU5V7MuyWsH2ksavrG99LXC2oDbOnJkW5xkCYgOOVBa4yV1gBOMLHHg0k7P9ryLDr/+CCHj/reHl4xW6d8OslWxJM/TY0ngQDVqeepTLr5Ek277AupXrt/+6Dgna/s1oUQQ3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327151; c=relaxed/simple;
	bh=Tqs2pWlScmUp7XzQcbNHaOSXdKc3UOfCiuKJKjM4pzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KFoz+sd0BYYqKVFSynyBIUWQMS6RlcuDz8m/hRAGF4fpdbdieSnHZEuzxISt7myJ+jBi397jb2Yo0hvUNPSL5ntbmlNXr4jDYTsl8p/RNyTWs/Gl6p4gfJzND2hQekpX78KcdpEuhKwhfWHLadFz6dldNJHHe4tH8mOeQhLc5Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1k2Vbz1c; arc=fail smtp.client-ip=52.101.48.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrZ6tQU2nmZP4jJF4ec3zfDGbqW+K0J/e4YlT0PS97Ko6ECt+lddNpCQGGLmnwBta1X/vFW+MiBdFm3BhN853XRLI11prYp+AXsFKuwnDAOW39+nIbemd32viIN70Iyc3SJwjrFxM7J9OaABoPoqPm0anY/Czlwv9fpYCXOBlnfkvTf+b23siNrfIC0PDNAoZsqPKynmxfnBIwhmslYMPUORiBeT+D2g+pedu0ua6ec3xySDX2kgDeYYP5WuJuemlsG/Nx93jCe01eHL4zUBwHkCfQmEcupae54onUz4kTpyZ3pUb9koO45nyYJH0oNdNqZpUObtpFtyMJYPWH1EmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0PEAvbqCjkm5jvNgmgyqdG83gjAvngc1+rdOG6G1sc=;
 b=SGNQwIRRiJhASivFcHWJ5x1czzS1B5yauLHsyVACiqZwAlLzGVWsibCgBLLVdADQr8DIglY/F+lqHU+KhP812RGE520hIXjX+O1ENvEI7/6hS1dMMQTZ2m9XJb9SieRUac0Fc7E/ElV5rPH0SrAI1BR/AvpT5Gl3AhhYUUWoBuCYWB/a5kf0PjQWNkDFiSMUECrnmSC3tqGLItwX0eBkgbRD5RGBlgchSWZQAhy629WhAne4tocW+Z/uCRd0jSyURjFdYKy3gWBrcFyfHU0bAXuhPtP9/YiFH6dnimPj44rxgEQl9siQkWi8rKQ6dzmpvp0ABH3NVKJEQf6NdsHu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0PEAvbqCjkm5jvNgmgyqdG83gjAvngc1+rdOG6G1sc=;
 b=1k2Vbz1cMIjauDiTu39yPqxzgJj6zRDSZy+kIQBqGLtolz0NlCGgPakDq63ipCVfB5sV5YUunNmDo7CvTHwyiqwi+WuaCYXCbpjCiwYBlakrv6JpCupacvZvd5NEdtjq3L6EgMzSB5fXUa9+5Rix36hKkEFLqdJ+67ORb+LTZ64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 13:59:03 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 13:59:02 +0000
Message-ID: <cf1a759f-5327-4e47-8632-23010b337983@amd.com>
Date: Wed, 1 Oct 2025 08:58:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 23/25] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-24-terry.bowman@amd.com>
 <d3d3ab84-8cdd-4386-82dd-de8149159985@intel.com>
 <a2b5d6f0-7f6a-4ac3-b302-73fb3c1a92b2@amd.com>
 <5706b8ca-6046-4f96-a93b-8dd677494352@intel.com>
 <20351ea0-4bb7-4b5e-b097-42ef145dea68@amd.com>
 <ab001a63-47e4-4d85-b536-8103835a5b39@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <ab001a63-47e4-4d85-b536-8103835a5b39@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::32) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: edfa4035-e563-476a-c7a5-08de00f2ad88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjBOazd6cXdxQWhSeXlKM3NFT2grdXpFcVphcEtUSWRxU3dZMFJxZmw5c3JV?=
 =?utf-8?B?REFtSEVodHJoSUdSeDZ3Wk5KaUptK3ovZk5oZ2laMnpkcGxXM3hid3hTN1B0?=
 =?utf-8?B?VVgreVg2bGVFNUVYUGhIcTVJNVBNNzR6bU1PdWJGRWxFOGRNZzNrSVM4S3Ru?=
 =?utf-8?B?YWRueUh3NnFYOFlWc2hWR0dMeVBtYjI4czNVLzcrVkpFQkxTRkhvZ1dZSjFH?=
 =?utf-8?B?cHpVT2d1Zi9mNVlURWVWVk10ZkxESFZoUTI1S01Cd3JENHVLQ1RqZXJxclhv?=
 =?utf-8?B?bnFMRkIyRUkrQWQ5eXdCU3hUSFY2SXB3cDg2c1ptM1lqakcxU1RYSGcrS2pT?=
 =?utf-8?B?N29jck5GN0tOTXVhWXcwTXNEdzc1RTVSMFRhK3lNaDVhZmV0eHNwSXpVVTFl?=
 =?utf-8?B?dDVMVzMzSEdJWE5IaHF4bWZBbStLWXhiYVU2aUxlemNqbENBTkR3YkN3UGNz?=
 =?utf-8?B?bFNBNWd0bGxUODBlMjFhd1gvL2JiczROK2FrYUs3S1BYQ3RkbDB3bjVHaGlD?=
 =?utf-8?B?QWtzZjg5TzFWb0FSRWc3NHBmN2dGMlJQN09DWUZXRHhqMjUwam9XVVozUWE2?=
 =?utf-8?B?YjJvNEdLMytjSXJkUXhRQlJKWmVidWdrTlZCT1JBN0lBQ3JTVDI0c2xxL1VB?=
 =?utf-8?B?azdIWThVWVhWRWdEd1FXODUxWlJhVEpzaWRHVjVMOUl1RHRnWEFDQTZpL3ZQ?=
 =?utf-8?B?ZkhOU3dJeTY4dzhPMFI3RHBaMkdBMmJXcHUrK0RKaVNOcjZCZmhkbHNGZFRF?=
 =?utf-8?B?VHhzQnQvVVVwNEVDcGRnSitkR3B3cTlWMlJzVDBEbjA2end6UGRLQ0lZQ0h2?=
 =?utf-8?B?NUhwbDZsL2RqSTJDVHc5clJES3NJYnBXbGk4WjlqOXYxejdMb210VHFGd2J1?=
 =?utf-8?B?OEhDNmpRV0VrNVQrdjNmRXRPd1N3K2ZHSzVRcnVwZmx0dVZicmUrdFpZckg4?=
 =?utf-8?B?VVVjOVd3QzFSaDNOR1YzTjQySVdMN0pXSitoclpyS1VsQWM0bHVFRGQ2Q0N4?=
 =?utf-8?B?WDhnV2FEcDQ5YVRMTm5NcjlwN0ttZWR0S0lNUkpyT3d6OTBxajhDZmhJQURU?=
 =?utf-8?B?UzFYMXoweVhxS0xNQzFna2pKc1pzUW1udFlxUmd0QzVYa09nUGowV0lCYlI2?=
 =?utf-8?B?NGltYzlJR0xxdmZHUVBKVXEyb2w2bDJpaExwVXMrb04wL09nQU1vWFZBeENo?=
 =?utf-8?B?cjdIZys0ZUkvc2xBdGJsR0p2enVja3luTk94NmhybFpBM0FVVW9hSlZtU3Rw?=
 =?utf-8?B?WUoxUFJGTmtpSlB5TnZpdGU0Z2FZSlRMbm1IZzNOdk1yM2lNV0NJb2RhSmNt?=
 =?utf-8?B?VVZUN3FvRXEyS1JnWEZkZi9veXR0aUkweDNuL0xyV3pTZEJiL2RTdlE2Vkhy?=
 =?utf-8?B?VGlSb21DbnFjcm1NQVBZbGk2bUFIYysxSVIvN1czWUpHcHAxTjlRNDBsRXNY?=
 =?utf-8?B?WWROdmpxZGxqbVJpSTJZVjNXY3lGdGxlTXNQUVRzd2JHRUx6TVpPK0ZkMHNu?=
 =?utf-8?B?M0FNL25lRDRHeS9TcDlMU2Q2NHJCbDBVeW1tT1NsTkUvckNYa1NweGJ5K0RW?=
 =?utf-8?B?TzBhcjVhUFVVa0hMSVFEY2Y2Y3R5WkJWb1M5UHlVd0N1STY5SjhBWk8xMEdl?=
 =?utf-8?B?V0g0Rk9SME00SlE2NzRZOUdJZkljcmRGNEhtZVlCV2ZpVURiVXBKc2F2bW5R?=
 =?utf-8?B?SnkyczJBVmlvSEM3YTNqeWJ2Y2dxajU5L2hLcWRWTmZJVGwvd2pLRStEenA4?=
 =?utf-8?B?ZHJ6azNRUTFKbDJoaFJMTnFUYXhDZW56ZVNOdVV4NTc0WTRVbzNKMjh3elcx?=
 =?utf-8?B?L29VVFpwU05BaFJhMUlkSWFHeXVnZU0wT1IvczZvYS9kZllmbTJiSWRaSmUx?=
 =?utf-8?B?eHVxM2JDY3dNOTJpVlJVb1VOdGZGZ3J1Y2F4TFpieWdsb1dmdUp3Z1JaOVpj?=
 =?utf-8?B?Q1J3WUM3cVRpVHBBOFpOUUpzZ3BXa2ovaW5FaHUxRTNjWjFhNlpBS0JXTmhQ?=
 =?utf-8?Q?3hq8/RfQuhsFAia9whQ/GXlKfpr42U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkY0cDVEcHhnbVMzOVUzcUxrQkpCUEtKUHpnbHE1WjBaaS91cWN1VURtK005?=
 =?utf-8?B?Ly80cGN4TDVvYUZHM1A4YkF0a3RGb0FqeVc1Qld5T0M2czVTdStvL2lvMFY3?=
 =?utf-8?B?Ri9CQ2ZsakVLbUxPM0J3TDZsWXI3ajFQUGRoMEFmSVNTVGN4WDU1TjV3NzJQ?=
 =?utf-8?B?NDV2N1lidGZOWHAvb3JldFpDOTRTR01jd0RiN2t0SzJtYWdBTjgyejUwRzZL?=
 =?utf-8?B?eE1MMlRFTWY4MFhLZ1dCRzU4U2VlMXhJNmF3b25ndzNOUVF6ZEEzYWhVWmln?=
 =?utf-8?B?dWlCckVnRmtGTUY5UjZjem9KeU1hKzVSVUZNbGVOVGkvbi9aQmNHamE1ajJh?=
 =?utf-8?B?eUVUdXhyVS9mMjRGKzlQWWRZWVp3SVZLMWVxZDlZK1EzY1FZbHRWTUN0djRw?=
 =?utf-8?B?L0FXRmNEMkQwZVFNRFlnUUxrZFFTQWdLQUd3dHNLNHA3SXVQMDVmSEpldlIx?=
 =?utf-8?B?dFJrMGZ0T1Z2bDVCclR1cVJIZDdjYVFzSGZUYVF4WjV0R21aQjlPTi85YjM3?=
 =?utf-8?B?M0JjOVgvektYUFlsL0N2dXFFTDFQQzdmSklabWgzVUpnMnFmM3N0ZzRhVzd2?=
 =?utf-8?B?MHlBUlhndHZXT1A2UDZ4ZTFNVU1WRU14WGcwcmRiZ3R1cWRZbUhPeGVmR3dn?=
 =?utf-8?B?MFdHb3dLRUxrYXVjZWVEWjJ3VGF5SG9KU29Zd0NiNlNxVTBQeUtlL2xjcmhO?=
 =?utf-8?B?MjQ3aGI0NWIrRFNrTS9LOHB2Skl5OWlJMVJNaCtySGFXRURRVlBCK2loSy82?=
 =?utf-8?B?UCtaKzA4MDJHMmkwZ1VTTFg5VnZiTXRWaUJoRzJGNHlOc25IRUY4RUg5ZGNU?=
 =?utf-8?B?N0t2Q2U3QkE5M2t3cXduQkZISzJ4WGJaSmhaZm5rUjlXeXJWd3lIWVRGKzZM?=
 =?utf-8?B?YTVqbW56RWNxT0VVU3pjZnpTSGlYM21NUTI4QkU1Y1VpZTdSSmRNeXgwdEt3?=
 =?utf-8?B?VFZGdlpROXZHVDMreVdoZkUyQnA0MGE3bDRwWGhuUEJmbGc1dFQvS2orM00z?=
 =?utf-8?B?SXA0UmdNMHp1emlGV2ZOaTNzV3hZMmhsczRoQ0lLWnorQUZJak1rWWF0S1RO?=
 =?utf-8?B?Wm9sbGZwaWVIL0ZMOVo0TVIxeFRVbUcyeVJ5dFRzbytidDhTLy8rM0I0ZWlw?=
 =?utf-8?B?cTZnVjQ0SWdPZVRENUVnNU5BL1BYQisxNnRYazl5SUEzVnFPeDlwd2E3bzMv?=
 =?utf-8?B?bTI3TGpEMU5Sd0lTdXZkRG9RUkJibG00aGlIb1c1bHVsQUVwdEh3bWVxRk1a?=
 =?utf-8?B?TzRyQVBldlpIQTIzZ3k5UGVvR1lkTjF4NEpER2ZmVjRkZGRtUjd0U1Q0Uzc2?=
 =?utf-8?B?Y2RNRzkrT205N3lNNW9WamNLWGVaanNmdkJhZFROU0prVFZPWStZY0hCbm1N?=
 =?utf-8?B?RmovRWtFRUpPR09ENENmZFlKa1MxY0o4YWRZMDg2OWphMnRiMldwa0NuQVYx?=
 =?utf-8?B?RjlxZ25QOXZ4dVBGMGp4ZGRVazBoeW9TWGNWRG9sc25qUnk0RjVoekp0cEt0?=
 =?utf-8?B?MHJQaDI3dzBFcTFLbkQ4QXExMkFtUU1vamFLUmR1TXVmL2hNODF5VWFUQmY2?=
 =?utf-8?B?OEI4eFVQSGFQMHNqOHBFMlZ5ZndmdjltNkpvOFNzRStpZ2pVcXFDSWUzajF0?=
 =?utf-8?B?a1dINWhMRWh6cWR6Y2Q4V2VKQWJ5Njc3dEF2U3hoWFFiNEYwNFpaMUVyMWlm?=
 =?utf-8?B?KzdEUEMwTEMyY3kwRm5mdk44dlBKY3ltU3MyQmRlRUJ1ZkRUeXAyMnZ4UGhK?=
 =?utf-8?B?RThWWUxtSGdmdzR3MkwyY0VVa1ZMUCsrZUZ6bWhpNFJ6TThNRmlIaWRNMHFT?=
 =?utf-8?B?QTBkVFNxMGxvRW5oYUc0VHNVbzdwS3NTeU1Cd05yMFlTT3V3TEhuTWtpU1FS?=
 =?utf-8?B?TGR5Z2FRRGpzWVZ2UkMrbDZCc2lTNndSS1UzcW5wQ09MRWg1MGdxRU90OFNT?=
 =?utf-8?B?VTVCbWE4Mi9mbGpYWWJYaDh0Z2xScW03bTJhaVhvQmE3WUY5dGpXaElKQ1hx?=
 =?utf-8?B?NnpzYitMSy9RbXFoeWtNdWFUaGpnNW5GMU1adXBuaXpEeFdWdEYzNzMzdm1o?=
 =?utf-8?B?Y1cxMFc0N1E4bmUySVpxWDFmUTl5b2g0Ritva0dNVW5jU0t3ZHdUa084a2ll?=
 =?utf-8?Q?nTeYqkPflb5wyYDXtEMsWjezo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfa4035-e563-476a-c7a5-08de00f2ad88
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 13:59:02.8500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dif9ffJbX3Z8IUaBuIR0BHIqVazXEINYC/s+6XkkTih2qcLSFQyXxAsC3qX+un0cNV3QFV0BMUp3joie/mPnbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980



On 9/30/2025 11:46 AM, Dave Jiang wrote:
>
> On 9/30/25 9:43 AM, Bowman, Terry wrote:
>>
>> On 9/30/2025 11:13 AM, Dave Jiang wrote:
>>> On 9/30/25 7:38 AM, Bowman, Terry wrote:
>>>> On 9/29/2025 7:26 PM, Dave Jiang wrote:
>>>>> On 9/25/25 3:34 PM, Terry Bowman wrote:
>>>>>> Populate the cxl_do_recovery() function with uncorrectable protocol error (UCE)
>>>>>> handling. Follow similar design as found in PCIe error driver,
>>>>>> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
>>>>>> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
>>>>>>
>>>>>> Introduce cxl_walk_port(). Make this analogous to pci_walk_bridge() but walking
>>>>>> CXL ports instead. This will iterate through the CXL topology from the
>>>>>> erroring device through the downstream CXL Ports and Endpoints.
>>>>>>
>>>>>> Export pci_aer_clear_fatal_status() for CXL to use if a UCE is not found.
>>>>>>
>>>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> Changes in v11->v12:
>>>>>> - Cleaned up port discovery in cxl_do_recovery() (Dave)
>>>>>> - Added PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()
>>>>>>
>>>>>> Changes in v10->v11:
>>>>>> - pci_ers_merge_results() - Move to earlier patch
>>>>>> ---
>>>>>>  drivers/cxl/core/ras.c | 111 +++++++++++++++++++++++++++++++++++++++++
>>>>>>  1 file changed, 111 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>>>>> index 7e8d63c32d72..45f92defca64 100644
>>>>>> --- a/drivers/cxl/core/ras.c
>>>>>> +++ b/drivers/cxl/core/ras.c
>>>>>> @@ -443,8 +443,119 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>>>>>>  }
>>>>>>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>>>>>>  
>>>>>> +static int cxl_report_error_detected(struct device *dev, void *data)
>>>>>> +{
>>>>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>>>>> +	pci_ers_result_t vote, *result = data;
>>>>>> +
>>>>>> +	guard(device)(dev);
>>>>>> +
>>>>>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
>>>>>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
>>>>>> +		if (!cxl_pci_drv_bound(pdev))
>>>>>> +			return 0;
>>>>>> +
>>>>>> +		vote = cxl_error_detected(dev);
>>>>>> +	} else {
>>>>>> +		vote = cxl_port_error_detected(dev);
>>>>>> +	}
>>>>>> +
>>>>>> +	*result = pci_ers_merge_result(*result, vote);
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int match_port_by_parent_dport(struct device *dev, const void *dport_dev)
>>>>>> +{
>>>>>> +	struct cxl_port *port;
>>>>>> +
>>>>>> +	if (!is_cxl_port(dev))
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	port = to_cxl_port(dev);
>>>>>> +
>>>>>> +	return port->parent_dport->dport_dev == dport_dev;
>>>>>> +}
>>>>>> +
>>>>>> +static void cxl_walk_port(struct device *port_dev,
>>>>>> +			  int (*cb)(struct device *, void *),
>>>>>> +			  void *userdata)
>>>>>> +{
>>>>>> +	struct cxl_dport *dport = NULL;
>>>>>> +	struct cxl_port *port;
>>>>>> +	unsigned long index;
>>>>>> +
>>>>>> +	if (!port_dev)
>>>>>> +		return;
>>>>>> +
>>>>>> +	port = to_cxl_port(port_dev);
>>>>>> +	if (port->uport_dev && dev_is_pci(port->uport_dev))
>>>>>> +		cb(port->uport_dev, userdata);
>>>>> Could use some comments on what is being walked. Also an explanation of what is happening here would be good.
>>>> Ok
>>>>> If this is an endpoint port, this would be the PCI endpoint device.
>>>>> If it's a switch port, then this is the upstream port.
>>>>> If it's a root port, this is skipped.
>>>>>
>>>>>> +
>>>>>> +	xa_for_each(&port->dports, index, dport)
>>>>>> +	{
>>>>>> +		struct device *child_port_dev __free(put_device) =
>>>>>> +			bus_find_device(&cxl_bus_type, &port->dev, dport->dport_dev,
>>>>>> +					match_port_by_parent_dport);
>>>>>> +
>>>>>> +		cb(dport->dport_dev, userdata);
>>>>> This is going through all the downstream ports
>>>>>> +
>>>>>> +		cxl_walk_port(child_port_dev, cxl_report_error_detected, userdata);
>>>>>> +	}
>>>>>> +
>>>>>> +	if (is_cxl_endpoint(port))
>>>>>> +		cb(port->uport_dev->parent, userdata);
>>>>> And this is the downstream parent port of the endpoint device
>>>>>
>>>>> Why not move this before the xa_for_each() and return early? endpoint ports don't have dports, no need to even try to run that block above.
>>>> Sure, I'll change that.
>>>>> So in the current implementation,
>>>>> 1. Endpoint. It checks the device, and then it checks the downstream parent port for errors. Is checking the parent dport necessary?
>>>>> 2. Switch. It checks the upstream port, then it checks all the downstream ports for errors.
>>>>> 3. Root port. It checks all the downstream ports for errors.
>>>>> Is this the correct understanding of what this function does?
>>>> Yes. The ordering is different as you pointed out. I can move the endpoint 
>>>> check earlier with an early return. 
>>> As the endpoint, what is the reason the check the parent dport? Pardon my ignorance.
>> There is none. An endpoint port will not have downstream ports.
> parent dport. It would be the root port or the switch downstream port. This is what the current code is doing:
>
>>>>>> +	if (is_cxl_endpoint(port))
>>>>>> +		cb(port->uport_dev->parent, userdata);
> DJ
>
>   

Yes. I need to change port->uport_dev->parent to be port->uport_dev. Thanks. Terry


Return-Path: <linux-pci+bounces-35851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CA6B51FFF
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 20:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F1B164F35
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 18:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E188D275B1A;
	Wed, 10 Sep 2025 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2DB5iBZR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CFA329F18;
	Wed, 10 Sep 2025 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527919; cv=fail; b=NKllLjTdx8Iqk6XnCy/9FTIpIju6wAwXrwk5vfVfvtCT4pmsY61YBJvcnqqYWX3Z7oIbt9/VBNZyTZmQ0yX751QCuN0FYuQ3F8B810iDpNe6A11SEp1rMhZ9UkcMdDMtxCkJxJQy7QpUGVAy4ZIJuFOpPlvgtW4pY6C3Tjb+ojI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527919; c=relaxed/simple;
	bh=U53toUl9aai2ffHGq4dR4tpTN598giXrGwLj6zf6hdk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mW9JSQniU2QTvxET5hhRvCWqag64efPTstIlavPvzYLHkQaaDMqGHz1r183wgygtlDlcdv9SnUBAqNhlUdjxVcXkStuqJ8vCPMu8NPcwaKMTQBapYVXoLT/6tZhzHc2c38ud1VTUeCa98isSwyRIrmHcoFf0847dt5wzkFL+VAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2DB5iBZR; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3+o7WvsTHnaPz1jMjbXSfF2veYqICsrBIqekk1r5vjYM+HqE0SsReku+alNRfnAEojmHBnnEBl+Zq/JJyFW2XWbVqH6PDltOFIds07cKLOvVM12ZM4catA7gM03q32IDTySbQ+XzkdofFOzSHZ/fojNQ6gutAxsOFMFsfmv0PDXKpeDkjdpGLYoRwezGyPKL+pG8W29066DRiBzdltm1xpRlbV0m4QTBKDocqV/0lDpzp/DEVpq1XipChAA1GD379FQo3pAyHsqa2Z6bkVyoFL6KrAxsTvaPM1WCb5MKVkh0nfVuF+McoXFxTWXlPbTa9KqELFsnSocpW7iN6fCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YimadxnXAdjayXQ6w/rSVHl1g01wf37aWyaMiW4WAw=;
 b=P89y9CfJH541ZhhLKuAQLp3utp09Y0hvD+xKZTJun2AeAOQX6JAsxr9ALxHBtE9HQlMRgZNdy7A7BpjC35nmwbv0OYUqOQI1WZ5pgnK+mG89Tp9LBAXhrWTeTrW/ZXQoGTq5EcuTT0tzXPgcgveSPp8dNNkCrrf7kNp4UyLy8HxbZZ5weBhAzCIphg5JYCTHrwJF3Xs9DiK9rJs8N49+7qXecyUmcSWR5TwkvdLiM/qx2qT3GEjcJFT4BKQDIx6bEOpZ1/sz/bKmCZGARo2/66xlzWKnDL5q+e0WU7vQvrcU/xw7ttNe2n+Siqb5Nk8JKfRW5YMwPw8baAT2ERqC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YimadxnXAdjayXQ6w/rSVHl1g01wf37aWyaMiW4WAw=;
 b=2DB5iBZRZWAFcxLarzaZTtF28IS+ke25YQEYqid2RoTLtgQuOua3p0G8sencxZM3TW+7Ea5iLxN96gn8Ude6bD6LrQZ3T4gv0TjBaQwzUKAepI1EJmd1NylPl6vU4VunMBfOZ9Erk9KJvqVjZv8Y/P/rGPEjkSar6ZlISbz/cgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 18:11:50 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 18:11:50 +0000
Message-ID: <750a363b-8645-4115-a6a4-757941992330@amd.com>
Date: Wed, 10 Sep 2025 13:11:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/23] CXL/PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-8-terry.bowman@amd.com>
 <91a11ced-88be-4ecd-b3c3-04e1e85f1860@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <91a11ced-88be-4ecd-b3c3-04e1e85f1860@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:806:6e::33) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: a22a483d-e79b-4198-fb5c-08ddf095837c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjFCT1RvS0hzNVBWYlBxdUtFOGs2R3pMbWtZZ0UrUndGVnh0ZWJDL2VhRGho?=
 =?utf-8?B?bGdKbHc0VTNuM3JRN0VNTzFseE5CS2poRTByU3ByMFBFMkpMa3U1MHk3bnZl?=
 =?utf-8?B?R1lPbVhoSXRoRkFOOXBFQnVIcXhUcFZEMzVSNkJZaUlCN3RoNlhCejRFanpt?=
 =?utf-8?B?Y09KcWZRbkdlRVdQTHpEZ1dyeXB3TElmWXdueTd2UXlKY0ovUjhlMWpiZ2dU?=
 =?utf-8?B?dDlmWVJ3bDNIRDAwY2IwaGRDY2VFRExoRnk3Ym40TjFNSGxWY08vVEsyMk9K?=
 =?utf-8?B?RGpQUE9lWmFIRGhDbHlNaU1VN0x2eXRNNHJMRlg3azRzQzQwUDNjMG50eG9G?=
 =?utf-8?B?d000WFhtb2Z5UVU5YzZFOEs3U293L3A1OTVJTERzNVlZSHBuY3lsY2RjYVNz?=
 =?utf-8?B?VlYwSDdjc0ZHWXVRZ3R3QXBVS3oxeitIM29hSCs0d1FSbVp3R2lyYVRZdzJC?=
 =?utf-8?B?R0M3MWFqNmJVTXNiOXd3UVcwZW5NTGpYS1NpSFBYMWlJUzB3ekhOZktXRFYw?=
 =?utf-8?B?cXZzNlZNNHBjbWRRWnZHRjdET0hEYUgxUVF2OE1vMWg4UkJXQVpoT0hycktF?=
 =?utf-8?B?bVQ1R3hESXJtOWlpZ0xuZzU5ellERGpGWERFR0UxWE5ZNk5FbFdPOXcwRXNk?=
 =?utf-8?B?dTJmanB2RkYxN0lvODZvM2wzcXhrR0w3M0lCUlNqamJYM010QXBHYjVsSzB5?=
 =?utf-8?B?K0h2bEpuMytLTnFoVnAva0s5eDRHbDllZkt6ei9pSWRMd1hpNk5kZkh2NDBC?=
 =?utf-8?B?ZVdDUUZ0VWRiRXhlZjFCOGdMV0pWb0RxbVFkckUyVEdhd3ArOHdzWk1kYnRJ?=
 =?utf-8?B?bklDaGFqaWowMk9hZC9YR04va1Arc0w4a1dpc1MycG5nWWpRQTcyTVBvWFVG?=
 =?utf-8?B?d0Z1UjdhQ3lyL3lNckJaM00rYkg3L2xPcEVHcWMzbEZ3enFiQ3UxQW9oUTMy?=
 =?utf-8?B?K2tHb28rb2ZMN1RPK21tdlBZM0NYMDF2SktDVkdwMzNjTUZXWGFPa2FsZ3Yx?=
 =?utf-8?B?NUxwQXRtNmk5TUFEQXdoMDZqM3FNL3ZRZnE3NEJFeURCWVZ3Nzk4U0pQdWx3?=
 =?utf-8?B?cHpzV0ZDOWcyQjhNWDVpNUhCNW41ZERnRFRpQmhnNTJvcjUya2pLbjhkdG5P?=
 =?utf-8?B?bDIzazZaaEpOOTUrZUE2ZkVSTVIvd3A3Sy84akljQXgyWDh0UmZkUjdzQ3Yv?=
 =?utf-8?B?MVhtc1I4aHRSTWtWK202RFdOMUFLN251OGFGYWZMbE9PNGFYWkRJVEFaNWFj?=
 =?utf-8?B?K05EQVV3dmR1L3QyMUtKQkpJTVJIU1JqWExYSHlBVlRLYnRUdkM3TjYvcWV2?=
 =?utf-8?B?ZSswbm16R0VQSTc2NGtabE5IUzd3TTFhM1hnNGpSRmpXNDlaZkhiSTNtRjVF?=
 =?utf-8?B?MFIvZlJKcnhCQkIxTFdjSGpsUUVOenk5UXFaVzNuQTVITWY4VSsyUkw1bWI3?=
 =?utf-8?B?Y0dDSjdSNXJNTXgvaHpJZGZsRVhuaUVGT1JDanlxL3U4di9OUmNqM0xMZm5q?=
 =?utf-8?B?OUdGb0hYby9QbkxZd0FQcG9uRWs4Z2dtODBiUFluQXEwTk9sRnlJRjI5RnFE?=
 =?utf-8?B?a29hL1RqZEMwRElpYkFPaU4zd1JaMDZreVlES3YzcFlFK0tUb3VQV1dpSUFP?=
 =?utf-8?B?aTdwcUs0QVlJS3J1WWMxb0VvbG0zK3p5TjFOUSt6TlN1OUdORDBLYUovT2Fz?=
 =?utf-8?B?ZU5sTFp3SVZDOENzazVIL25IaHBSN1RzNkNIYVRSaWgrd3pHSERTWGNGNjV3?=
 =?utf-8?B?TUZvTmxxYSsyRGNEQTJ3WEY0d3VaQ05HTkRlT1lrSVoxQW9kQTExRll0eDlV?=
 =?utf-8?B?TWpqMi9YVXFpWk5TQ3VDZnkrY3RuYkUzOGdCYnYrM2p4MWJpRlc5T0E2M21s?=
 =?utf-8?B?WU82VkJ3YTJCUll6UUowTWR5ZUxYZjYvQjVpcU5nVGJRYUw2U2o2KzRkUHF6?=
 =?utf-8?B?MmVpbXExYi9vZDBGVXd5UzloS1J3SGZ1dXl5L01zaXl3ejFmd1pEaDRrekFX?=
 =?utf-8?B?N0F0eVo3MWR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlVnTTJmZXpCQWt4dmFQc2t3RGdycit2cTFHanVwS0pqRi9mVFNxS3c0R0RR?=
 =?utf-8?B?N01NaHRqSU1YeFRVSTJiVHk0ZGJuaFFpTFdVakhYSXNyemthVDNCYmNiV2xt?=
 =?utf-8?B?UC9FaGRpUysxamFDeFdLRGNqWW54Q2dTOThCVEJWT3dSNGlabGVpb2c4MnlI?=
 =?utf-8?B?MHlMZHdlUWpCaWZOdVpHY0dRZTNUaERseHJQOHpoN3QvemNTOGJZOXk4MnND?=
 =?utf-8?B?VHZiNTJ1SDg5RWRHWkp0OENmb3gyVTBTYU12VnBseFBuVG9ZaEtMdkpyRGo5?=
 =?utf-8?B?M2o1Zk5TeG1aa3Z4eXQ4ZXdZLytHa2hrZkgrWnJMakcxUFl0ZzRPWWZqV0dt?=
 =?utf-8?B?TWE5NlcydmFzSEhTWmx5Wk12TXpFL09DQVlsU3ovTXBmUElMK1JwemJNRkQr?=
 =?utf-8?B?M2NQUjZYbUtINmx3aDl1TXZFZllEL3Q4bzJheDN4TnFhYnBMRFg2SXV2V0Z5?=
 =?utf-8?B?ZlEyeHBpN3dpaVJjMzRtdXg3OUx2MEFKUDZWS2NocmFhM2ZOeHBuNFE1d3JD?=
 =?utf-8?B?WTlvY3Uxd25LS1VaMHFYSmd0cmhLbkRvY3RCYmtiRitFb2l3azFvS2RQOXlr?=
 =?utf-8?B?bEVGRTN6bld6S0pkNHZCK05HS1l2MmFEOHBIRnZxWVA0Nk1XUXo5cHFHbVRy?=
 =?utf-8?B?MmpDdWxQNWlIRmFBcldnbDhtbmVialdoQ2psdVhVQW1IajhzUjVVYTV6QlI0?=
 =?utf-8?B?cmU5MDM0ZFFQUWR3ZjdpQjQ2QWJFZTBqb0NqNXVmL053Ym1YR0FpQU8yZVJo?=
 =?utf-8?B?bzJsSDQxeHFMSFBqTXE2NDlqT2VnUEVXQ0FhT25QQ0hrQ3AwVVFoK3I1LzUy?=
 =?utf-8?B?Mit0UThXbVJkcS9uQkNLeTE0ekxIazhsNnBIa2dPelJIVTlncTgrYnJvNngw?=
 =?utf-8?B?NGg3MjlyVUFIdW1aUHZEQUluTi9SbXIrZFFncU82WWpHckpkRDFrLzlvekhB?=
 =?utf-8?B?d1kwS3hXQkFiOWRjaUhIVmcxeURpU3VBTFhCZCswY0w5MTd0STU3aE9yQnVp?=
 =?utf-8?B?UjRnWkxhbjhHcjZmRExnNGJCTjdVejZTRGtxeTkwWXU4MHdNVVc1TFh6amRS?=
 =?utf-8?B?TFFKekg5bFlodGlVME9FYWpEUlhhNUdlQllKYlJLeXBmT3B0SmlMQ0JxaGJ0?=
 =?utf-8?B?ckhZNTVsUzZPeTJnZ0lXcGJLSTBPcFE4OFJFM0daa0NhLy82dGNPYVBvUjhH?=
 =?utf-8?B?M0t1S291ZVhrTk83MXNVaERkbWNVa2tucHlUaUFqYXAxT1cycU1rSG5CMHoz?=
 =?utf-8?B?VEVjdkFWU0hIVlh2SUdtYjlXRnY4WU8wRlhHZFM3VHlrdXNwdXBVRWlvbDVo?=
 =?utf-8?B?TXFtZHlTRGhmeCt5d3dYbXc0cWVhM0F0SWFXemZWb1IzUk84TklhU2RLdTlK?=
 =?utf-8?B?cTFuaUREQnZPK1BkamZIVWYrTDhZN2tZNnAvaENhQ0xVc1RpdGltMmFMR2RS?=
 =?utf-8?B?VFAydmxPNGdUVStGcmlGYXFnb0J6NFg4dVlJTGtnTDdCeVBQMStRZFMzY25J?=
 =?utf-8?B?L0Y5emYzZzVOQ2dQejlFWlJ5Y1ByV0lyblZ3VjE5OHdCM0JES2FaUW1YNW5J?=
 =?utf-8?B?dFlhME5yMXlvR0tEb2hRZmxMNTVpbFlUSUxpSmZyMHZaZnl5QUZoeG5hZ3Vz?=
 =?utf-8?B?L29ZWXdlVlRxR1JBdHcyQkd4cm5BWGlNYXZoNkNlRU1aRnBsdmdhdk1yZktz?=
 =?utf-8?B?NUZZQ3ZmOS9yQUlDVlFBVnUra3Q5V0ZVei9FTGFRWnN6VXpUUnB0RXk0TDJD?=
 =?utf-8?B?U1ZvNkZDUTI4c2g2QlpHNTlqMzRFeHBJREYyTENWTDg4TW1nSlBteVlFTHFa?=
 =?utf-8?B?RWQwS1BaK2ltaUg5V2tYSnlLeWRmMmNqK0JFY0NnNWU2TlVPUkU5VG9MOXZF?=
 =?utf-8?B?SHJxUmdQaERXRzREMWxOdHJZS2NmckVJdk5sZ3RFL1NoQWdmVDExZWErbytK?=
 =?utf-8?B?aTJQZ1JibHBUOVpPdStweXFGWGhSZGt0U3ZOUms0aHFwLzE2MHVpakNXalJi?=
 =?utf-8?B?c1JhRUZ6MEF4VGRmT3JVd2NFVmN5b2t5NmZ5dWQrb1JTS20zd004cTlDSDdv?=
 =?utf-8?B?Y3c4YytXOFp4bW5DSWEzYy9hWTJteUk5cnBGWUN1bjkxdHRVSXVYS1ZnekxC?=
 =?utf-8?Q?GFb8MsMJTCB7lqIVQBB1uLfXX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22a483d-e79b-4198-fb5c-08ddf095837c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 18:11:50.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYyX02OwWNuQpo+Dm6nGYe25ZNDLCGdm0hDp/oMN3gndMp6cmCkboPSK7H2TIyFg0bfXD2Q8Le7dKr7w6bbA7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079



On 8/28/2025 4:07 PM, Dave Jiang wrote:
>
> On 8/26/25 6:35 PM, Terry Bowman wrote:
>> The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
>> accessible to other subsystems.
>>
>> Change DVSEC name formatting to follow the existing PCI format in
>> pci_regs.h. The current format uses CXL_DVSEC_XYZ. Change to be PCI_DVSEC_CXL_XYZ.
> I don't think renaming is necessary. Especially changing all the existing CXL code. CXL isn't exactly considered a subset of PCI (not part of PCI consortium). IMO it may be better to leave it as it was. Maybe others have different opinions. 
>
> DJ
>  

Hi Dave,

This was requested by Dan Williams during v10 review:
https://lore.kernel.org/linux-cxl/6881626a784f_134cc7100b4@dwillia2-xfh.jf.intel.com.notmuch/

Let me know how to proceed.

Terry

>> Update existing occurrences to match the name change.
>>
>> Update the inline documentation to refer to latest CXL spec version.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/pci.c        | 62 +++++++++++++++++------------------
>>  drivers/cxl/core/regs.c       | 12 +++----
>>  drivers/cxl/cxlpci.h          | 53 ------------------------------
>>  drivers/cxl/pci.c             |  2 +-
>>  drivers/pci/pci.c             | 18 +++++-----
>>  include/uapi/linux/pci_regs.h | 60 ++++++++++++++++++++++++++++++---
>>  6 files changed, 104 insertions(+), 103 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index a3aef78f903a..d677691f8a05 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -110,19 +110,19 @@ static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
>>  	int rc, i;
>>  	u32 temp;
>>  
>> -	if (id > CXL_DVSEC_RANGE_MAX)
>> +	if (id > PCI_DVSEC_CXL_RANGE_MAX)
>>  		return -EINVAL;
>>  
>>  	/* Check MEM INFO VALID bit first, give up after 1s */
>>  	i = 1;
>>  	do {
>>  		rc = pci_read_config_dword(pdev,
>> -					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
>> +					   d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
>>  					   &temp);
>>  		if (rc)
>>  			return rc;
>>  
>> -		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
>> +		valid = FIELD_GET(PCI_DVSEC_CXL_MEM_INFO_VALID, temp);
>>  		if (valid)
>>  			break;
>>  		msleep(1000);
>> @@ -146,17 +146,17 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
>>  	int rc, i;
>>  	u32 temp;
>>  
>> -	if (id > CXL_DVSEC_RANGE_MAX)
>> +	if (id > PCI_DVSEC_CXL_RANGE_MAX)
>>  		return -EINVAL;
>>  
>>  	/* Check MEM ACTIVE bit, up to 60s timeout by default */
>>  	for (i = media_ready_timeout; i; i--) {
>>  		rc = pci_read_config_dword(
>> -			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(id), &temp);
>> +			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id), &temp);
>>  		if (rc)
>>  			return rc;
>>  
>> -		active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
>> +		active = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE, temp);
>>  		if (active)
>>  			break;
>>  		msleep(1000);
>> @@ -185,11 +185,11 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>>  	u16 cap;
>>  
>>  	rc = pci_read_config_word(pdev,
>> -				  d + CXL_DVSEC_CAP_OFFSET, &cap);
>> +				  d + PCI_DVSEC_CXL_CAP_OFFSET, &cap);
>>  	if (rc)
>>  		return rc;
>>  
>> -	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
>> +	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT_MASK, cap);
>>  	for (i = 0; i < hdm_count; i++) {
>>  		rc = cxl_dvsec_mem_range_valid(cxlds, i);
>>  		if (rc)
>> @@ -217,16 +217,16 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>>  	u16 ctrl;
>>  	int rc;
>>  
>> -	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
>> +	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL_OFFSET, &ctrl);
>>  	if (rc < 0)
>>  		return rc;
>>  
>> -	if ((ctrl & CXL_DVSEC_MEM_ENABLE) == val)
>> +	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
>>  		return 1;
>> -	ctrl &= ~CXL_DVSEC_MEM_ENABLE;
>> +	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
>>  	ctrl |= val;
>>  
>> -	rc = pci_write_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, ctrl);
>> +	rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL_OFFSET, ctrl);
>>  	if (rc < 0)
>>  		return rc;
>>  
>> @@ -242,7 +242,7 @@ static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
>>  {
>>  	int rc;
>>  
>> -	rc = cxl_set_mem_enable(cxlds, CXL_DVSEC_MEM_ENABLE);
>> +	rc = cxl_set_mem_enable(cxlds, PCI_DVSEC_CXL_MEM_ENABLE);
>>  	if (rc < 0)
>>  		return rc;
>>  	if (rc > 0)
>> @@ -304,11 +304,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>>  		return -ENXIO;
>>  	}
>>  
>> -	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
>> +	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CAP_OFFSET, &cap);
>>  	if (rc)
>>  		return rc;
>>  
>> -	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
>> +	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE)) {
>>  		dev_dbg(dev, "Not MEM Capable\n");
>>  		return -ENXIO;
>>  	}
>> @@ -319,7 +319,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>>  	 * driver is for a spec defined class code which must be CXL.mem
>>  	 * capable, there is no point in continuing to enable CXL.mem.
>>  	 */
>> -	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
>> +	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT_MASK, cap);
>>  	if (!hdm_count || hdm_count > 2)
>>  		return -EINVAL;
>>  
>> @@ -328,11 +328,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>>  	 * disabled, and they will remain moot after the HDM Decoder
>>  	 * capability is enabled.
>>  	 */
>> -	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
>> +	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL_OFFSET, &ctrl);
>>  	if (rc)
>>  		return rc;
>>  
>> -	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
>> +	info->mem_enabled = FIELD_GET(PCI_DVSEC_CXL_MEM_ENABLE, ctrl);
>>  	if (!info->mem_enabled)
>>  		return 0;
>>  
>> @@ -345,35 +345,35 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>>  			return rc;
>>  
>>  		rc = pci_read_config_dword(
>> -			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
>> +			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i), &temp);
>>  		if (rc)
>>  			return rc;
>>  
>>  		size = (u64)temp << 32;
>>  
>>  		rc = pci_read_config_dword(
>> -			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
>> +			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(i), &temp);
>>  		if (rc)
>>  			return rc;
>>  
>> -		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
>> +		size |= temp & PCI_DVSEC_CXL_MEM_SIZE_LOW_MASK;
>>  		if (!size) {
>>  			continue;
>>  		}
>>  
>>  		rc = pci_read_config_dword(
>> -			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
>> +			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i), &temp);
>>  		if (rc)
>>  			return rc;
>>  
>>  		base = (u64)temp << 32;
>>  
>>  		rc = pci_read_config_dword(
>> -			pdev, d + CXL_DVSEC_RANGE_BASE_LOW(i), &temp);
>> +			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_LOW(i), &temp);
>>  		if (rc)
>>  			return rc;
>>  
>> -		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
>> +		base |= temp & PCI_DVSEC_CXL_MEM_BASE_LOW_MASK;
>>  
>>  		info->dvsec_range[ranges++] = (struct range) {
>>  			.start = base,
>> @@ -781,7 +781,7 @@ u16 cxl_gpf_get_dvsec(struct device *dev)
>>  		is_port = false;
>>  
>>  	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> -			is_port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
>> +			is_port ? PCI_DVSEC_CXL_PORT_GPF : PCI_DVSEC_CXL_DEVICE_GPF);
>>  	if (!dvsec)
>>  		dev_warn(dev, "%s GPF DVSEC not present\n",
>>  			 is_port ? "Port" : "Device");
>> @@ -797,14 +797,14 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>>  
>>  	switch (phase) {
>>  	case 1:
>> -		offset = CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET;
>> -		base = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK;
>> -		scale = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK;
>> +		offset = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_CONTROL_OFFSET;
>> +		base = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_BASE_MASK;
>> +		scale = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_SCALE_MASK;
>>  		break;
>>  	case 2:
>> -		offset = CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET;
>> -		base = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK;
>> -		scale = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK;
>> +		offset = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_CONTROL_OFFSET;
>> +		base = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_BASE_MASK;
>> +		scale = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_SCALE_MASK;
>>  		break;
>>  	default:
>>  		return -EINVAL;
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index 5ca7b0eed568..fb70ffbba72d 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -271,10 +271,10 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, "CXL");
>>  static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
>>  				struct cxl_register_map *map)
>>  {
>> -	u8 reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
>> -	int bar = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
>> +	u8 reg_type = FIELD_GET(PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
>> +	int bar = FIELD_GET(PCI_DVSEC_CXL_REG_LOCATOR_BIR_MASK, reg_lo);
>>  	u64 offset = ((u64)reg_hi << 32) |
>> -		     (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
>> +		     (reg_lo & PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
>>  
>>  	if (offset > pci_resource_len(pdev, bar)) {
>>  		dev_warn(&pdev->dev,
>> @@ -311,15 +311,15 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
>>  	};
>>  
>>  	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> -					   CXL_DVSEC_REG_LOCATOR);
>> +					   PCI_DVSEC_CXL_REG_LOCATOR);
>>  	if (!regloc)
>>  		return -ENXIO;
>>  
>>  	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
>>  	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
>>  
>> -	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
>> -	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
>> +	regloc += PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1_OFFSET;
>> +	regblocks = (regloc_size - PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1_OFFSET) / 8;
>>  
>>  	for (i = 0; i < regblocks; i++, regloc += 8) {
>>  		u32 reg_lo, reg_hi;
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 3959fa7e2ead..ad24d81e9eaa 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -7,59 +7,6 @@
>>  
>>  #define CXL_MEMORY_PROGIF	0x10
>>  
>> -/*
>> - * See section 8.1 Configuration Space Registers in the CXL 2.0
>> - * Specification. Names are taken straight from the specification with "CXL" and
>> - * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
>> - */
>> -#define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>> -
>> -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> -#define CXL_DVSEC_PCIE_DEVICE					0
>> -#define   CXL_DVSEC_CAP_OFFSET		0xA
>> -#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> -#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> -#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> -#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> -#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
>> -#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
>> -#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> -#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> -#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> -#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
>> -#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
>> -#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>> -
>> -#define CXL_DVSEC_RANGE_MAX		2
>> -
>> -/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
>> -#define CXL_DVSEC_FUNCTION_MAP					2
>> -
>> -/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
>> -#define CXL_DVSEC_PORT_EXTENSIONS				3
>> -
>> -/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
>> -#define CXL_DVSEC_PORT_GPF					4
>> -#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
>> -#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
>> -#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
>> -#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
>> -#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
>> -#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
>> -
>> -/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
>> -#define CXL_DVSEC_DEVICE_GPF					5
>> -
>> -/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
>> -#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
>> -
>> -/* CXL 2.0 8.1.9: Register Locator DVSEC */
>> -#define CXL_DVSEC_REG_LOCATOR					8
>> -#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
>> -#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
>> -#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
>> -#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
>> -
>>  /*
>>   * NOTE: Currently all the functions which are enabled for CXL require their
>>   * vectors to be in the first 16.  Use this as the default max.
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index bd100ac31672..bd95be1f3d5c 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -933,7 +933,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  	cxlds->rcd = is_cxl_restricted(pdev);
>>  	cxlds->serial = pci_get_dsn(pdev);
>>  	cxlds->cxl_dvsec = pci_find_dvsec_capability(
>> -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
>> +		pdev, PCI_VENDOR_ID_CXL, PCI_DVSEC_CXL_DEVICE);
>>  	if (!cxlds->cxl_dvsec)
>>  		dev_warn(&pdev->dev,
>>  			 "Device DVSEC not present, skip CXL.mem init\n");
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 9e42090fb108..d775ed37a79b 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5031,7 +5031,7 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>>  static u16 cxl_port_dvsec(struct pci_dev *dev)
>>  {
>>  	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>> -					 PCI_DVSEC_CXL_PORT);
>> +					 PCI_DVSEC_CXL_PORT_EXT);
>>  }
>>  
>>  static bool cxl_sbr_masked(struct pci_dev *dev)
>> @@ -5043,7 +5043,9 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
>>  	if (!dvsec)
>>  		return false;
>>  
>> -	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
>> +	rc = pci_read_config_word(dev,
>> +				  dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET,
>> +				  &reg);
>>  	if (rc || PCI_POSSIBLE_ERROR(reg))
>>  		return false;
>>  
>> @@ -5052,7 +5054,7 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
>>  	 * bit in Bridge Control has no effect.  When 1, the Port generates
>>  	 * hot reset when the SBR bit is set to 1.
>>  	 */
>> -	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
>> +	if (reg & PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR)
>>  		return false;
>>  
>>  	return true;
>> @@ -5097,22 +5099,22 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>>  	if (probe)
>>  		return 0;
>>  
>> -	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
>> +	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET, &reg);
>>  	if (rc)
>>  		return -ENOTTY;
>>  
>> -	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
>> +	if (reg & PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR) {
>>  		val = reg;
>>  	} else {
>> -		val = reg | PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
>> -		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>> +		val = reg | PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR;
>> +		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET,
>>  				      val);
>>  	}
>>  
>>  	rc = pci_reset_bus_function(dev, probe);
>>  
>>  	if (reg != val)
>> -		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>> +		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET,
>>  				      reg);
>>  
>>  	return rc;
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index a3a3e942dedf..b03244d55aea 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -1225,9 +1225,61 @@
>>  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
>>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
>>  
>> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
>> -#define PCI_DVSEC_CXL_PORT				3
>> -#define PCI_DVSEC_CXL_PORT_CTL				0x0c
>> -#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>> +/* Compute Express Link (CXL r3.2, sec 8.1)
>> + *
>> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
>> + * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
>> + * registers on downstream link-up events.
>> + */
>> +
>> +#define PCI_DVSEC_HEADER1_LENGTH_MASK  GENMASK(31, 20)
>> +
>> +/* CXL 3.2 8.1.3: PCIe DVSEC for CXL Device */
>> +#define PCI_DVSEC_CXL_DEVICE					0
>> +#define	  PCI_DVSEC_CXL_CAP_OFFSET	       0xA
>> +#define	    PCI_DVSEC_CXL_MEM_CAPABLE	       BIT(2)
>> +#define	    PCI_DVSEC_CXL_HDM_COUNT_MASK       GENMASK(5, 4)
>> +#define	  PCI_DVSEC_CXL_CTRL_OFFSET	       0xC
>> +#define	    PCI_DVSEC_CXL_MEM_ENABLE	       BIT(2)
>> +#define	  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)     (0x18 + (i * 0x10))
>> +#define	  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)      (0x1C + (i * 0x10))
>> +#define	    PCI_DVSEC_CXL_MEM_INFO_VALID       BIT(0)
>> +#define	    PCI_DVSEC_CXL_MEM_ACTIVE	       BIT(1)
>> +#define	    PCI_DVSEC_CXL_MEM_SIZE_LOW_MASK    GENMASK(31, 28)
>> +#define	  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)     (0x20 + (i * 0x10))
>> +#define	  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)      (0x24 + (i * 0x10))
>> +#define	    PCI_DVSEC_CXL_MEM_BASE_LOW_MASK    GENMASK(31, 28)
>> +
>> +#define PCI_DVSEC_CXL_RANGE_MAX		       2
>> +
>> +/* CXL 3.2 8.1.4: Non-CXL Function Map DVSEC */
>> +#define PCI_DVSEC_CXL_FUNCTION_MAP				2
>> +
>> +/* CXL 3.2 8.1.5: Extensions DVSEC for Ports */
>> +#define PCI_DVSEC_CXL_PORT_EXT					3
>> +#define	  PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET			0x0c
>> +#define	    PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR		0x00000001
>> +
>> +/* CXL 3.2 8.1.6: GPF DVSEC for CXL Port */
>> +#define PCI_DVSEC_CXL_PORT_GPF					4
>> +#define	  PCI_DVSEC_CXL_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
>> +#define	    PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_BASE_MASK	GENMASK(3, 0)
>> +#define	    PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_SCALE_MASK	GENMASK(11, 8)
>> +#define	  PCI_DVSEC_CXL_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
>> +#define	    PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_BASE_MASK	GENMASK(3, 0)
>> +#define	    PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_SCALE_MASK	GENMASK(11, 8)
>> +
>> +/* CXL 3.2 8.1.7: GPF DVSEC for CXL Device */
>> +#define PCI_DVSEC_CXL_DEVICE_GPF				5
>> +
>> +/* CXL 3.2 8.1.8: PCIe DVSEC for Flex Bus Port */
>> +#define PCI_DVSEC_CXL_FLEXBUS_PORT				7
>> +
>> +/* CXL 3.2 8.1.9: Register Locator DVSEC */
>> +#define PCI_DVSEC_CXL_REG_LOCATOR				8
>> +#define	  PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1_OFFSET		0xC
>> +#define	    PCI_DVSEC_CXL_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
>> +#define		   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID_MASK	GENMASK(15, 8)
>> +#define	    PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW_MASK	GENMASK(31, 16)
>>  
>>  #endif /* LINUX_PCI_REGS_H */



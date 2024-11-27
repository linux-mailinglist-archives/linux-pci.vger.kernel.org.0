Return-Path: <linux-pci+bounces-17429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539939DAEA3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 21:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C5F164A27
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 20:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD4C201116;
	Wed, 27 Nov 2024 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y/9Y6Ho0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02814F90;
	Wed, 27 Nov 2024 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732740824; cv=fail; b=fMVRzp4Zjb/tBtwD29wKnnf/fAx3gFPxcN2mYWGl4ArJip+6N0CikqTEc6mEa9SGY72tf5pG0nJ3rQFe7wVAjfchIKCvsb9UOnhc9mgEUoksGWL+2hHdI3WQtNkAqbfHe2nAmbzu5kTYBF/IREqizCOu7FqF1RExuyJBpuP4PSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732740824; c=relaxed/simple;
	bh=nvKjcFxnXZZaTQlLqUqKsn6sFaGOWS2A5bq0D8sQqhE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E1XsFRyDRlW8IFl0rx3v4uNY5CLd3EcnUXt+8rzhrEGeSzN3HbhgdenOVxXLKavNpFe2PxR+lOzjU1O/zrbYt3p2w4LiCY5jMroDDTg+Py3D6POgi9OGHwsQz42tfk5p285ryx1mWBCdZkr3Yne8ggWTUUlQMvyOwW56scU7qUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y/9Y6Ho0; arc=fail smtp.client-ip=40.107.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6imBTN61GEioPm5RiJqWg9Bu7mjAvGexv9/qUZQ7+OI04M5fgJH9OvhBFl7Q+3ksDobKbCCxohaT0vmVrsROPcDL3i9Q3FrGNuMWUnr/JujooHKa3yTgx9EAEJ/lL98EK07sf5ZX1sIsT19180QgDRVrzsGTCXi9O2pIz2mLQQ/6YexiXQa1Hj73wqsuVTTi/xOuUez8pSeCBQz3XfVvaNTXYrdXthuUCuMo07eos0tP66DVByhzW6syuyYhTcnNzT6dCj/4EzWl3Y8YrLbCxjWITeCjg2IM2fwoA/N6YvK6OdGfldqFthcDrwrWkVPvY/ax/aeSDWxKCh4c+eQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BXuulV2F2F6PjrLBjMftZAhhep+qChlBtzbYy+yy4E=;
 b=tp/Hy1pkS+zyj3USjB2LJNhsifw+w6/2qZ8ShS0fmWts+42YbIYMFm22tjLx3SglCAy6QBsg48NU4Zn29aNVqJYKrNiri1CkOZTkHaCSnqOGT0SOOdZ262Kqhngm5Y8FT1rJzxXvdHBTydrNNN0cSY5Bk4rPqMjO6o0Ol2pcU+i/GZAw9EEJ0KEXMtL1oUoiJWBv/v9khjnc3X6J5JSr6uTOi2cS5/3VzClVYCdGu7vaIwnNdqwqc5+BjEMbVMd4/940ilCJXKBA8LyD4q00zUDJw9Ha20pWcwWOEd4YeJaYqH6kBvM2NcGMAIfYpssodyuLdoyDDrDlaNufba4dww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BXuulV2F2F6PjrLBjMftZAhhep+qChlBtzbYy+yy4E=;
 b=y/9Y6Ho0aoohkbbL8Ptow1khgJnNRFwdTUzfeJsyjH6PV8n7wCnV7GWxcMGge7EW+av+DEYqR+jvyjxY+ei3kMAsl2t1YhBwwfLGQ/H9pO1yfQpL3vIe3xOgDIbcS4wwjcJpxqrEhlBZhlzUkEfLUGDDHX5xkwYdI/wxEfWp/Sc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 20:53:37 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 20:53:35 +0000
Message-ID: <3536d4ae-719c-4aab-b0bb-5c8a3781ca8f@amd.com>
Date: Wed, 27 Nov 2024 14:53:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/15] PCI/AER: Change AER driver to read UCE fatal
 status for all CXL PCIe port devices
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, ming4.li@intel.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com,
 Shuai Xue <xueshuai@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-7-terry.bowman@amd.com> <ZzcVzpCXk2IpR7U3@wunner.de>
 <c7c9d417-5c32-4354-825e-58f736726114@amd.com>
 <20241127170518.00003966@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20241127170518.00003966@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:806:f3::7) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 13faac8b-8f92-4f40-76b9-08dd0f258f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHVRZDkySFBnenMySDA5ay92dXAveU1lV2lBZCs4cDQ3cGRZYm9vSGRQbzNq?=
 =?utf-8?B?KzE5YmpDaVAySmhBbnRYbXJMdzk1bDJoRmF4UGhSTWFZMzhXUnl1am9Ndk1u?=
 =?utf-8?B?cDdwLytqcGdGMGx6bk5EeVFnTEIyWUgvd0ZrZEpOTVVWRGE4TGdOeVp3ZmYz?=
 =?utf-8?B?aEgzeHQ1bmQ4UHZYZHAyZjVUbDB5aWI5UEN3NUVnZUVuUkRNVTZiL1IvTHdR?=
 =?utf-8?B?SUtHZHNveFRmYzhxWldjbnR3VjQ1REdJcWpxaXB5MXFkazMzZ0FsK0NHQzEx?=
 =?utf-8?B?RlVIendVZGNNUEd2NXgrQ0N5cDRJWEZuSjk4cGgrL20xMm1WSWJlU2xEdklJ?=
 =?utf-8?B?QUJZRDZTWWQwaE5CSnpMaVBCWnpjRVlmOURXb1kyRlZab0dCay9LeTN3YSt3?=
 =?utf-8?B?QUdnL1NtVk5WNDJjVktkOVhOZitXc3JzSXZ0b0ludHNqZkpCTkoyQ3lEOEVB?=
 =?utf-8?B?aTFqZWdnN3NLK21CWDdERWE2YzBKeEZSVzF0SVgwT0UwT0JRQkFQcmwwMEF2?=
 =?utf-8?B?M04rTEhyN0lPd2lZdHVwVmdUKzZJQjgwc0RGUFlHdGkyL2lyaEVyS1lUN2RD?=
 =?utf-8?B?UU03Q1cvWUovdlJnVlJWbStZenNGdlUrS1orM1NUK1plRG81eVNMTkNsSys2?=
 =?utf-8?B?eWlrTEcyUUllNlJGRnRDR2lGNStoQUxBc3RuR0hCQStHdDJkcExJS000S3dK?=
 =?utf-8?B?NkVUcHJsZENKMDhxNGdlL2VUbWhCQ1hSNzJpbll5VFVUV3VmRll3eDJ4MllJ?=
 =?utf-8?B?bzQzRCs1RWY0M3Y0QWNRNFhwZWtVWGdrMEZNTlNpYklPcFZkSkhsbC9scURN?=
 =?utf-8?B?d1RNWEs4eWp4RDVYaGV5ZWRLNFdUa3JtdEhORStBRW1XUDI0MTdtNlErZ0hK?=
 =?utf-8?B?YytXaU14WmN2dU9vR1RyRGltOXNQcE5PaFFBTkFEL0dJOWxxYk5jdUJVZ2R5?=
 =?utf-8?B?TUU5dFJ3a1FwQzNkbjF5N0ttWjB4OEJCcnNBYlp1WG1icXJBMnNMMEM4TER1?=
 =?utf-8?B?bDE0YkNNRVhBRTlRMlUwa0VpZ3ZrdFY3WjBTeGNBMmVFajdKWFNSVTdMdkVD?=
 =?utf-8?B?S0VKQ0ZvSXlkZDJnRGg3dGFPSGk2TkpteXhMSVg4MjhlamgxUUVMcjZ6dEVt?=
 =?utf-8?B?YjBMTFNuRFNlMDFoZ1JtYit4VEpGY2RsWTBVdUJoWGpJK0NMYUhvdFdvNVZx?=
 =?utf-8?B?Q2ZlRVNub0kzclhvSTRnSVRVOGxOSmpzNkZNUXpDOTdkNDlEOTVmd2NVZE92?=
 =?utf-8?B?Z1FFQzR2ZkxpWDFlcXRHazBXQUw1RkZDL0pESG5VaXNERXc4ZnJDWGVqZmM0?=
 =?utf-8?B?M252dE1MWW9LWXhrSXl2enJYYVRId3dENzR3dXZjMDVhdjZuQ1pHT3d5NERT?=
 =?utf-8?B?aGNCTnZVdWdWdC9vQ3RMQk1VMjFoQXM5Z0E2eU5WNy8yelloNHZtNEhqYXVK?=
 =?utf-8?B?ZzFiQTg0cGNVejZ1emhlcHFSSHI3QTNKUGo1VGppS0tkZGttVFJzQ1YwSEQ5?=
 =?utf-8?B?QTNkNGtwOHFwbFZNYm8xTFdJZW8rVCswek1XWDNtb2NJckc0ZEZvMm1sblFQ?=
 =?utf-8?B?RzZWNlpMbTIvMTVIOWpKdndneStJSk05R09TODdycWcyc3V3VDdGV3VYYlhj?=
 =?utf-8?B?dDFEbDl6bGl2cUN6b0JGTVhNZUIrRW1UV01ZeGFSVVk3ZUdHQWtTR1Q4aExo?=
 =?utf-8?B?WngrRG00VkxTdmdJamFNNDVHNXV1S3FuMkFYaVBMYUlyZTdsd2tmQW5Obmxl?=
 =?utf-8?Q?OpOojOyW9hs3tb7Q0Nwj9rNGV5E5SSv67JBAb3m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWVNdndTejFPc1JqQm83RldqVWdyU29pTlBRRFFReGpLcXNNVFc5WEtFbVBI?=
 =?utf-8?B?UjlaRWtUQUx0QTFGdEtiTXh6SHIzTUczUUU0ay9EOC82bnFmYW1FN2RaWlM3?=
 =?utf-8?B?L01icmlmcVplcE9Tb2t2NmFLL1c5dlFTQWFKTzFEVjdJdE9kNVQyQllyQXJS?=
 =?utf-8?B?MnAzdUJBL3RENmpveTJFUzJocUs2cWRGNHA2bWF0cTluYkJ0ME4rQU5yTlVw?=
 =?utf-8?B?a0ZaS3I0SWRZTnJJK2JQWElMWkZDc0kzZVVHRVFLSWZHQ2NWMWQ1RXY2Mktv?=
 =?utf-8?B?ejgwUXdoTkdsRjg3b1JaVGZHSHhTR0lMRG11dDJHejFhbVp2UzJuUVpQL0Fz?=
 =?utf-8?B?RXZmL1Q2NkFSNGRMdDRuR2RKZUNuWkIzQnRpOFVIYThsVXRXQUt4bm54bHRM?=
 =?utf-8?B?SGdseVR5K3ZCZ0hvbVpoQUp6QW96b25SOGdCQUJ0TjhVOGYwQ1JpU2t1Rnc0?=
 =?utf-8?B?REhqRUtTY1A1QlpBNEZac01iOVdrOGIvQ1FnMENFa0NhZlk5NVAwYWtqMEZE?=
 =?utf-8?B?SnNueUhEWEREYk5SR25SOUQ1dmZzZ2x2S3VNb2xFMzliZ0U5UEdFTDBiUFlK?=
 =?utf-8?B?djlNRjVsUTJkYTFiMWpPWml3bWRBazdjMkZWYkxTU0ZtTWY0cUR2U3dTOVhL?=
 =?utf-8?B?RDAxcEFIUitKMzBkcy9xS2FBV013dk8rSmdaVTc0U0ppZE50S3ZuQ2NDMjU4?=
 =?utf-8?B?YTVOU1VjRWJ2QUtxdFVMMWsveVdObk1HS0tSSmJqYW5WVFE5MGRDNDFqSFR6?=
 =?utf-8?B?SnVERXJhU2ZudUcwWEtlYzVQSG5wR0pBSnVWYXJxOVNPWkppUGw0ZjRHZDZV?=
 =?utf-8?B?by9zY0FPSnd4Y2ZkZjllditUNmJZNjlpcVBtLzJwa0ZIWmRna0wzZk1wdDlO?=
 =?utf-8?B?V2ZMN3BENGFTOThaZDgvN04wOEZKbDlLcGIxVGgwSDhmOHZJNnJmcnl3Tjg4?=
 =?utf-8?B?K2c2RUV4VmJqSms0anF2Y2Yzazg1YW9pQ2JMYjRWK3RENzZGZDBaNVBhRG5n?=
 =?utf-8?B?ZUY2aERlZGhVNXgrN3RsUGg3Zlp6eWQzbVR3cm5yZEU0Z2hIUGtoN1haa2R3?=
 =?utf-8?B?MXJBV1k1bUhHazV0cnFUQyt1L1YrejBXVXJqZEhWUExreHYvQzZ3bStpZTJT?=
 =?utf-8?B?TnF3S1JlMEI2Z2xkNTJsKzVEaERJSVQ2Mzg5Y0tqL1hGVUJYOGFvb1d6dHgw?=
 =?utf-8?B?ZEk1cENZc0ZEMXJ1aG8vKzBKTGxhRVhiUG1jTFo0QXdnZk5TdlhSVnJzb2xQ?=
 =?utf-8?B?MTd0UzNGd28rWjNncUFjQkZkc2dDald3bVR5cnJhWDY0OUNrZWNjVlpJK25M?=
 =?utf-8?B?R09lNFoxY0dIUlJ2ZkhEeUV3ajQvQXpIV0o2dGx4TGtmQzJzdXIyMGJiMVdP?=
 =?utf-8?B?azJ4TkV0YzZqK2oyQmNUS3lJSnRObkJPMHNxbk1wQnlPbkkrVTl4QW5tdjlu?=
 =?utf-8?B?Q3BwR25CT2dkN2dUaG13K05kQ3RhbHJ0VTVxYlVRRWZEZWFjUXBwYmRPUy9O?=
 =?utf-8?B?cSs2OGpKcHRHUHE1d0FsNmRZTHV1MHFVV29yK055eGV0eWV5bHFjWno5dFA1?=
 =?utf-8?B?VWdCZzliK3N6Z2lyYzhDeWVXVVJpZ242RWVVdGZSM0hQbDMwY0Qrb1gyQmo2?=
 =?utf-8?B?T3BsY25LZ1FaOEZjUlZUV3dLa2pIcExsbndEcFdmeXdzc2cvaWMrMWJaTmsv?=
 =?utf-8?B?SFhQY1dPMnBqeHY2NFM1K2ZLRkhhV0tva2pxMjNKMXV6bm1DT092Ymw3NUx5?=
 =?utf-8?B?dzZjRkI5R0Y1U0dPV1FaWXVwWUpWRy9IbHJ2KzZrM0xjREJkb083bkJoNzQr?=
 =?utf-8?B?a3hyV1NOc0lMbEFUYno1bytBVFFMVENVYUdWbWx0Z3ZyWEFjWjNWeDFXcnR6?=
 =?utf-8?B?bmZaV0JqQzQyU25XcUZEZ3BxMUhmS054dGI4bFoxbytXR3E5NFFpUjUwWDFj?=
 =?utf-8?B?YzRQMklLeisyUDc0TlczamZJRHJWTy9DU0tjcEs4eTR5L1dydUlKOU5DbEh1?=
 =?utf-8?B?Z0xHNzhXNDBXUGxLTUZkbjdTeG9VdWNRS3dpZEZwMFlTdWJRMUpRQW1leG1a?=
 =?utf-8?B?d3puRVdXWXdGMDB5Wm1rY0h3R0Q4NzVYU0l0eFMxeENOYnJDcjBXUTcvbzJM?=
 =?utf-8?Q?NHvWBx+i9elUReTyyZDr0Hpwr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13faac8b-8f92-4f40-76b9-08dd0f258f62
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 20:53:35.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2du++/N/GcQJkcMG+d724d+fkbUlwaYX6SLQFp/lSfdYXhnF8RyUkcHAFtw3AaJ7Qm/ACJEx1rRXv+6wrYfsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715



On 11/27/2024 11:05 AM, Jonathan Cameron wrote:
> On Thu, 21 Nov 2024 14:24:17 -0600
> "Bowman, Terry" <terry.bowman@amd.com> wrote:
>
>> On 11/15/2024 3:35 AM, Lukas Wunner wrote:
>>> On Wed, Nov 13, 2024 at 03:54:20PM -0600, Terry Bowman wrote:  
>>>> The AER service driver's aer_get_device_error_info() function doesn't read
>>>> uncorrectable (UCE) fatal error status from PCIe upstream port devices,
>>>> including CXL upstream switch ports. As a result, fatal errors are not
>>>> logged or handled as needed for CXL PCIe upstream switch port devices.
>>>>
>>>> Update the aer_get_device_error_info() function to read the UCE fatal
>>>> status for all CXL PCIe port devices. Make the change to not affect
>>>> non-CXL PCIe devices.
>>>>
>>>> The fatal error status will be used in future patches implementing
>>>> CXL PCIe port uncorrectable error handling and logging.  
>>> [...]  
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -1250,7 +1250,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>>>>  	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
>>>>  		   type == PCI_EXP_TYPE_RC_EC ||
>>>>  		   type == PCI_EXP_TYPE_DOWNSTREAM ||
>>>> -		   info->severity == AER_NONFATAL) {
>>>> +		   info->severity == AER_NONFATAL ||
>>>> +		   (pcie_is_cxl(dev) && type == PCI_EXP_TYPE_UPSTREAM)) {
>>>>  
>>>>  		/* Link is still healthy for IO reads */
>>>>  		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,  
>>> Just a heads-up, there's another patch pending by Shuai Xue (+cc)
>>> which touches the same code lines.  It re-enables error reporting
>>> for PCIe Upstream Ports (as well as Endpoints) under certain
>>> conditions:
>>>
>>> https://lore.kernel.org/all/20241112135419.59491-3-xueshuai@linux.alibaba.com/
>>>
>>> That was originally disabled by Keith Busch (+cc) with commit
>>> 9d938ea53b26 ("PCI/AER: Don't read upstream ports below fatal errors").
>>>
>>> There's some merge conflict potential here if your series goes into
>>> the cxl tree and Shuai's patch into the pci tree in the next cycle.
>>>
>>> Thanks,
>>>
>>> Lukas  
>> Thanks Lukas I took a look at the patchset and reached out to Shuai (you're CC'd). Sorry, I thought
>> I responded here earlier.
> I'm guessing we might not need this change if we can base querying on the
> link being good.  If the error is on the CXL protocol side, the link should
> still be fine I think?
>
> Jonathan

Hi Jonathan,

Shuai is determining upstream link viability using a call to pciehp_check_link_active() in dpc.c. But, link viability is not determined dynamically for call to aer_get_device_error_info() in his patchset. I suppose we could add this for CXL devices and continue to isolate the new logic from PCIe devices. Your thoughts?
Link to the brief discussion with Shuai is here: https://lore.kernel.org/linux-pci/11282df5-9126-4b5b-82ae-5f1ef3b8aaf5@linux.alibaba.com/ Regards, Terry
>> Regards,
>> Terry



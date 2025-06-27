Return-Path: <linux-pci+bounces-30929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ED0AEB9DE
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 16:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB11173FF1
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 14:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2115C2D97B5;
	Fri, 27 Jun 2025 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r4f/39Sa"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F0C2D8DAF;
	Fri, 27 Jun 2025 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751034582; cv=fail; b=cUOnF9pB/dgun5dIOYaApo9imV4gW/jtblkIyPmDUHbVv0qkJW50l/0ucBwmo0PmhhdxYw4JLmPKXltt4XfkK5RcKAKh4FymlDtiuuZwy1HuOa/6iMRpWG9XuZcIwr2u30rp6UxP8+gQoetxFvRn97cXXgajqgdvwZfijIh/Eh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751034582; c=relaxed/simple;
	bh=Qnvq8fDfE5MdImXK+xSOepFezYoGMD23hqsLyxELoj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OM8QmwGssop0uANgHhJhpCQgxKGT9zL9jFjc4H8DVqnJGkKx2zrejJqflYfQ8i7uM2kmapMsy/TeFY50rn5NBYrBBbm7NIx9r4UZrg+j+/FuPz4qC+/tHGMuDLdZLbnaFmM4wO+A4jU/hIf0B21LmI52L8N984LGaEoNJ4SLBiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r4f/39Sa; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUUJdypnvlqJA83BQTk6hdfqZIBZeZAN7r+5oDpsPD4tq90ypv+ZsO03qlmZwL5DUi52EqvZ6XtgK7QCSDCt4HisSbG1EmRmA1gXy3ZFUN3wpDMi7hddQ8tDQ47/Xin0+f184WMnUjLKmRkp88WWuWQPYjDcx4J26J6Ov95vKF2BzGImrQkX0eSa0x2q+PVwKjyyUXMawhDsniM9br/EK1osQEoMnCHgegfNzouj7sYLpze0YBDeT6Uhs/9c7lJBjLVweVmw+TH+A0Rb9AbMbQ9BgFWqJtuvuRWCTaxdFs2+wd18+DjzGkivSDXF2Ds1ppJR1nHChta/bkYRqmWAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8pW2VL0gyfV0KNyJHWnqi3/L+8Jo3Q1E/lub6JfE/k=;
 b=Nb7B4p9H3QAqqiB/6AR6SwbBpZr+t1jAvoCnrBxO6GumudXgAHv+hN4ZhiQ0J1JjWpx8cRSmSP5L8U3c1ug+vvGz3qxlPJcfF/sYzBo2hLECUC/ypaXoulpdMyt8Y3ee8Ur5h/YnxaYCu9hptVGZy8ZllQmBiU1dra/nqV6Wj1H4F+z+wy2kehb/iyjp2NfoRIDl4JHr6ezTMD+4UG+c1IJbUCcEjCTD0NPT4U5XykeGfQ8rK6AWaSFFgiZBKMkpp/6xOKvy7FHEVcam9emGiindCcFLZfFnUk9YXr48WgXmxSQsjWzQYOMh3XddBTxK3Qk3y/IPgg5Ojl3xu3Eh6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8pW2VL0gyfV0KNyJHWnqi3/L+8Jo3Q1E/lub6JfE/k=;
 b=r4f/39SaqyZryE4FrFIhQG/c2Cd4I2UWVfC24WzU6d+mzMHKvJfZP+9LBdNxW74hX+uogfePEqw+71I8sR+gQpHKkWfgGSgklP4/nox4Y4FSQ4XQHiizddsOZK5wDa4kpgYu1ieASyh5WNdxK+GeI+bCh5yqRPai/ufjIk5bkt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.30; Fri, 27 Jun 2025 14:29:35 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8835.027; Fri, 27 Jun 2025
 14:29:35 +0000
Message-ID: <c7a25021-b8a4-4528-9dcd-cfabf314ab03@amd.com>
Date: Fri, 27 Jun 2025 09:29:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/17] CXL/AER: Introduce CXL specific AER driver file
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-5-terry.bowman@amd.com>
 <214c9b73-6e62-40c0-a805-56127269941a@linux.intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <214c9b73-6e62-40c0-a805-56127269941a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::16) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: faabb58f-4c3e-43b8-3add-08ddb58709d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alV4SXRyWTB4anc2d0gyZWQ5dGJxQUVQcW53MXZwQVdEWmxna2d5cWZLODAr?=
 =?utf-8?B?enRETHhoaHBtT2txVGlteDc4SDhzNzBZNFRCZnI5L21vdlBsWkpHaFJ0d0Nj?=
 =?utf-8?B?Um9JR0E1ckdXMjVzVU5sQlVXUE9sUExRQ2tlTWVDTlFVTUZYRFJQVkRLS3hX?=
 =?utf-8?B?ZlVrRlYvS2RZNE5SazRPbmFXZmZGaHB2Y1RoekJGT2V5a3dOMDFTNGVoN090?=
 =?utf-8?B?aTUzR0dzVEt0aGUyY2tBTXQxbHgvdmkwQ0hVN2ttT3BadS9rTTVKR1JEbDd6?=
 =?utf-8?B?KzJqMEdoUmZiSllhN3FkQjJDSHlRRHY4MDBuUVVHQzFYbG9PaVJ0U0NDYVM5?=
 =?utf-8?B?bUpWczZudTlaNXJUU0syUjRxdFVVdHFRK0RmdFhQOUtMalYxWmRTOElsYnJG?=
 =?utf-8?B?M3JqRVpnUW5RUWhydk5OSFFDNkVZQlFJQndjZ3hqb2RmMExnakFWdS9SY1hq?=
 =?utf-8?B?T3o2Yk5lTWdaSC91cGo3cE9vdm5NaHRtK3FQK0pNaFdDb3FkeXBYenU4Qi9V?=
 =?utf-8?B?dGJKeitHaUg4YlNoM25nNzROVzI5YnhYU0FOWWhxbFoxQXd1cm83VFlySG9o?=
 =?utf-8?B?YkhndGtuQTRicjBMczJKMlpkcThuWWdjS1F3OVF5WTRGT1BLRXpmSVJzUUZE?=
 =?utf-8?B?RG9UYlJFQXFob1BUOEU0MlVhZEVVRUVuRTJObjZmNk40QkFhRHhSdmRMYVY3?=
 =?utf-8?B?VzBnSkRYTWhoVmZybFl2MzFYUXBnMVliMThPTGJsQjAwWm5aU0RZS1Arblln?=
 =?utf-8?B?aEFmbnk5MTdueXgxSExWL1RYVWtwNE1iRkkzMVdCRmJiYVAwazRVcU5QQk8w?=
 =?utf-8?B?MnY4cGtFaU5hdXlnaHVmTU5VNnczaEhrL1l6UXVITjNqYktwNFliRlljbnNU?=
 =?utf-8?B?bStHQStKemRUbkVpS0I3UHZHWkF0UzFYNUtYZmhGcjBmenQ1NlN3NTdudE5M?=
 =?utf-8?B?T1g4Ry9kbUk4RUdiNVVqZXdLODV1N1Z2VzAydjhyTmdVdnZRODFILzBDUitj?=
 =?utf-8?B?RDNkcWhqdlFmQmVBSnlvMmJJRU4xVFVsaVU3OXJ0V3RJSStPZzY4TFcrYnJD?=
 =?utf-8?B?VW90aFpkdHVneGcrVG95TFhYVHhWMTNjM0d0TzVXcnFtQnVCWFRlWndIeVN3?=
 =?utf-8?B?R1VYZXpBY1hIdG5IV1k0aDQ0S1JBTUhSM3dMMFpWWjNFYkZ6Y1h4cU4zb2VH?=
 =?utf-8?B?Tk9ic0lLNm0wZVpCdnFmSmt4eThhRDlSTDl2aFNMSFN2VWI4ajdjUUtqVEMw?=
 =?utf-8?B?bW80TTMwVjlTVjZ5R2psMlVLakd5MFNRT0hwRGdhczVIM21yME5LMGQ1UFg2?=
 =?utf-8?B?SnBvdXJNQ2dBTytGVnh5bUZBamhicmZGZk5OMjA5TmFJMDhVSkU2bitlSW1i?=
 =?utf-8?B?VkkxSytoMXZ3OEJvRlJROEpsZEFjVXNURmh0RndHNUFKWW9JRDIxdFFjdlY1?=
 =?utf-8?B?c1ZvNWNBUjJrUjZ4dXFBazIzU3RhSGxYaTlBRjhRdmFUb05TOGZmMkNKQnA2?=
 =?utf-8?B?THRDOU9id2RJa0tLUGhaYU5BUTd1SXRveVM5SVJ4a1lBMXBYWW11Q3ZxZnlB?=
 =?utf-8?B?elVsa2tFUHlhbjJXQThuWFJqdmY1Zk1OTmN4a2I1bzNFY2FNZzJmMC9KVk0y?=
 =?utf-8?B?MTAxdjRxeFpMS3I3eXdXekFSOFlram5FN0Y4Tm9rV0padThYcFkyYkZCL1hH?=
 =?utf-8?B?L3VQNU5IZFRTcGxZRndsdGpSZUNIOFAyVlNNdGM5N21WVm4xa0l4bHhJZDA5?=
 =?utf-8?B?R1VGRy9xYU5rWk1ZV0doamlPckh6TWpqa09yNnFseVV3YWVTYjUrY0pzaTRh?=
 =?utf-8?B?WENPSkhyNXBNODhCeHE1ZHRrSTJkVlNNWEVWVzdUWjRacHhUWm1COFFHRG5E?=
 =?utf-8?B?eFZoNmdDNVRXQXRkeTF0b0phMEtKY2hlRkRjSVk1cktzblVRWG1OU2xxWkwv?=
 =?utf-8?B?ZFJpY29ZWElOdVRFVWlHbVdmemVNZmQwSG5DRGtNb3hmdFdRdGlGS1lLTzdG?=
 =?utf-8?B?MWNnSVZTdW1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk92RVRUVnV3MUNkMDk0VHl4KzBkNS94TFhCS1NIVDBkbktmTDdObWNoSk5x?=
 =?utf-8?B?NmZQaU5sUXlqRzR5eVFHbk1taG1telJmZzBPbGxNdnZsT2VqdkZTdHlMQldU?=
 =?utf-8?B?dUc5T3JVcTlhN1lKTVozcXVXS2JySCtJL2E5Y2xuRVVESURJOEJTNXUrWUZF?=
 =?utf-8?B?NVZRNGNMRGc2RW5lK2RDaVFQODhKeFBycGpkM2Y2Tk5pUW9VQklUSklUU1I2?=
 =?utf-8?B?UitmWEhWS1hOcFIrc1VkdTJBOGgwaWtqMGVrdksxVnVSWExTdHp3NG1uT2Z2?=
 =?utf-8?B?YktTTXBDYlgxZ2FkY0hFK3RycDlQd1BjNFlCcXI5bXBzWDlpb2o5RUtvRmU3?=
 =?utf-8?B?Sm1QQUYyMFRhMlVqR1MrbllMa0ZzOCtITUFzMHgyM2JMRFhYSktMelJUZy92?=
 =?utf-8?B?STM0MU8ydnhCblpOeXVmVHVGRUV0M2huaWIxT3p1aWovbnRsUitXclJiUDd4?=
 =?utf-8?B?NVNLbko5OEd2VWNnSXMrSW84c3NudHJ4QXpxdHc2czE4TU42Ry9xU1k3Wk5X?=
 =?utf-8?B?Y1BrODE4OHU2bEVvOC81VmdEZ3ZvOENSWGloejkxU0NTTDdVS1RhRTBpZ3RQ?=
 =?utf-8?B?MEFNK2RyeXFzWkhEdjV0d1pwZ25XWlVMYmQ1TnZjaUwxWGtnbmJtQ1QxTDZS?=
 =?utf-8?B?UXVrQ1JnVjZWdzhvY09CR3NhRFAxbnlkQ01WMjdiR0NZVnNqUlBDbnpnVUVr?=
 =?utf-8?B?QXpubVlDUWdkMVdzbUpmUFV4cElVT1ZKd2lFSmY5ZHcwQXI0WmRScHgxUUZm?=
 =?utf-8?B?N2N0MWZKUGpyenhNdklpL2x5Q2c2MURRTTk2b2FWV0JBc0JId0pCblFBTlVQ?=
 =?utf-8?B?aHJkNzhLRWhtajNBQ1NCTFZiUXBQSHFGbjJaZGpHcUJNbGNjUTBsMVB3RnFn?=
 =?utf-8?B?Rk0zaTkzZWVqQng3OVVyN0RXOGprUmN0c2swelYyeGo1bW1POWF5RFlZUTgy?=
 =?utf-8?B?MU4rME9RS3NjaWFLM05TdXYwUHNvU21EY1oxR2NMMHpXb0ZHWmhEMmxaTzAz?=
 =?utf-8?B?M2YwNUpRZGZuMmhOOVI3bjlnM1hGUU4zaWE3Q1ZKTDc5M2FyWXh1U1NHY1JO?=
 =?utf-8?B?N0NVRElzZ2RSZXA3WWhrUzhLbXFlR0JVOWVuamFEYWV4TVZhK1FUQzJtNWNC?=
 =?utf-8?B?dityKzNmR0h3ZHIvUFpkaDlxdDk4c0hCUHRXSjJLdGYyYW93aTdEKzgzSHlx?=
 =?utf-8?B?OHhKVFdGbWlmN0hmZS9sR0lmTGgzUnI3S1VtWVZ6S2xreEt0RlJhcEovdm5E?=
 =?utf-8?B?dkVua0pZbUxFYW11RnNFLysvTEFBU0JyYUk3ZGYzVlpQcU14QkEwZG81bXNz?=
 =?utf-8?B?Q3FqOWJJNnY4ZHFRN3grMTNLUXBETW9ma0grUUpSYlhweUJyYUdHa29OTzY3?=
 =?utf-8?B?amVNc0tkdjhkZWhCT1hLRWdLbnhCa09ZYVNxVU9ZNldWc0Q1N25SZ0YvYWVB?=
 =?utf-8?B?S0dvRDlCaVBRWm5LVUNnSkNaUXNGWEY4RXVPbk1WSVlUV2IyNnNqL2RBYWlo?=
 =?utf-8?B?RDZzL2ZEdldZeW1iZTNNSkNlWE40MFgzZS84THdiakM2THQ0RCswZ3BOalRw?=
 =?utf-8?B?NkszbDl3TVFSNC9GTC8wV1A0TFJNYmJVNEMvQUNBVmFCZENXeUFGMzZwT1pu?=
 =?utf-8?B?Q1dKZlh6OWFkRnN1dWVwMXgzTzE3Z3A5bGRvU2dKazZNNHVSa21LWEFOR0RN?=
 =?utf-8?B?WXJiU2tGekVLSWNIaS81S0RNa2d4anlsKzFaT0lSRm56Z0owTkJLWm9GYTgy?=
 =?utf-8?B?bDJvcHo4TjhmNThtRW0yd2xNSzdFQUNIQ3g4clVJRUdhOUFPQXp3d3ZXNGtN?=
 =?utf-8?B?UHJqRXhObVhYZ0lZelZ3Y1pMU0h4Q0VWTGhxbzJFaE5tdWhTMXFwbzlnOTFa?=
 =?utf-8?B?QU5hMXhRUFhtZWpiTDRUNHdlMSthaHZjcldTQkFNcWNDeEdhVHZGaHpLakpj?=
 =?utf-8?B?NTArbU5VRUE0VTNRd21FTllrS083dloycklGMDlOTzRoWGtFVzF4Y3RsTWkz?=
 =?utf-8?B?TXJvdzczQVcvYVZyeTNZbFpRQ1ZRR2JQc2h6UGVzcU9MbUtEejBvRC9jS0Vy?=
 =?utf-8?B?c0Z3Q2JVaWNnay9abS9lbktWS2JKTERYUTJheTNtbzkzdVdWZFZubTRTRVh3?=
 =?utf-8?Q?c2qZg8cgCh1PVwn0/t35M/BKK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faabb58f-4c3e-43b8-3add-08ddb58709d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:29:35.0663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMPdbWVmnoCItVX+06jA9C3Co2XuWmF2YhIw20K1K9GaAfWmKIm/gSIvntwSHnef8ggqjq7Sm0CiF3GxjVnYJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339



On 6/26/2025 6:42 PM, Sathyanarayanan Kuppuswamy wrote:
> On 6/26/25 3:42 PM, Terry Bowman wrote:
>> The CXL AER error handling logic currently resides in the AER driver file,
>> drivers/pci/pcie/aer.c. CXL specific changes are conditionally compiled
>> using #ifdefs.
>>
>> Improve the AER driver maintainability by separating the CXL specific logic
>> from the AER driver's core functionality and removing the #ifdefs.
>> Introduce drivers/pci/pcie/cxl_aer.c and move the CXL AER logic into the
>> new file.
>>
>> Update the makefile to conditionally compile the CXL file using the
>> existing CONFIG_PCIEAER_CXL Kconfig.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
> After moving the code , you seem to have updated it with your own
> changes. May be you split it into two patches.
Yes, I'll update to make a copy and add the changes in the following patch(es).

-Terry

>>   drivers/pci/pci.h          |   8 +++
>>   drivers/pci/pcie/Makefile  |   1 +
>>   drivers/pci/pcie/aer.c     | 138 -------------------------------------
>>   drivers/pci/pcie/cxl_aer.c | 138 +++++++++++++++++++++++++++++++++++++
>>   include/linux/pci_ids.h    |   2 +
>>   5 files changed, 149 insertions(+), 138 deletions(-)
>>   create mode 100644 drivers/pci/pcie/cxl_aer.c
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index a0d1e59b5666..91b583cf18eb 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -1029,6 +1029,14 @@ static inline void pci_save_aer_state(struct pci_dev *dev) { }
>>   static inline void pci_restore_aer_state(struct pci_dev *dev) { }
>>   #endif
>>   
>> +#ifdef CONFIG_PCIEAER_CXL
>> +void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
>> +void cxl_rch_enable_rcec(struct pci_dev *rcec);
>> +#else
>> +static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
>> +static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
>> +#endif
>> +
>>   #ifdef CONFIG_ACPI
>>   bool pci_acpi_preserve_config(struct pci_host_bridge *bridge);
>>   int pci_acpi_program_hp_params(struct pci_dev *dev);
>> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
>> index 173829aa02e6..cd2cb925dbd5 100644
>> --- a/drivers/pci/pcie/Makefile
>> +++ b/drivers/pci/pcie/Makefile
>> @@ -8,6 +8,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
>>   
>>   obj-y				+= aspm.o
>>   obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
>> +obj-$(CONFIG_PCIEAER_CXL)	+= cxl_aer.o
>>   obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>>   obj-$(CONFIG_PCIE_PME)		+= pme.o
>>   obj-$(CONFIG_PCIE_DPC)		+= dpc.o
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index a2df9456595a..0b4d721980ef 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1094,144 +1094,6 @@ static bool find_source_device(struct pci_dev *parent,
>>   	return true;
>>   }
>>   
>> -#ifdef CONFIG_PCIEAER_CXL
>> -
>> -/**
>> - * pci_aer_unmask_internal_errors - unmask internal errors
>> - * @dev: pointer to the pci_dev data structure
>> - *
>> - * Unmask internal errors in the Uncorrectable and Correctable Error
>> - * Mask registers.
>> - *
>> - * Note: AER must be enabled and supported by the device which must be
>> - * checked in advance, e.g. with pcie_aer_is_native().
>> - */
>> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>> -{
>> -	int aer = dev->aer_cap;
>> -	u32 mask;
>> -
>> -	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
>> -	mask &= ~PCI_ERR_UNC_INTN;
>> -	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
>> -
>> -	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
>> -	mask &= ~PCI_ERR_COR_INTERNAL;
>> -	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>> -}
>> -
>> -static bool is_cxl_mem_dev(struct pci_dev *dev)
>> -{
>> -	/*
>> -	 * The capability, status, and control fields in Device 0,
>> -	 * Function 0 DVSEC control the CXL functionality of the
>> -	 * entire device (CXL 3.0, 8.1.3).
>> -	 */
>> -	if (dev->devfn != PCI_DEVFN(0, 0))
>> -		return false;
>> -
>> -	/*
>> -	 * CXL Memory Devices must have the 502h class code set (CXL
>> -	 * 3.0, 8.1.12.1).
>> -	 */
>> -	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
>> -		return false;
>> -
>> -	return true;
>> -}
>> -
>> -static bool cxl_error_is_native(struct pci_dev *dev)
>> -{
>> -	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>> -
>> -	return (pcie_ports_native || host->native_aer);
>> -}
>> -
>> -static bool is_internal_error(struct aer_err_info *info)
>> -{
>> -	if (info->severity == AER_CORRECTABLE)
>> -		return info->status & PCI_ERR_COR_INTERNAL;
>> -
>> -	return info->status & PCI_ERR_UNC_INTN;
>> -}
>> -
>> -static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>> -{
>> -	struct aer_err_info *info = (struct aer_err_info *)data;
>> -	const struct pci_error_handlers *err_handler;
>> -
>> -	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>> -		return 0;
>> -
>> -	/* Protect dev->driver */
>> -	device_lock(&dev->dev);
>> -
>> -	err_handler = dev->driver ? dev->driver->err_handler : NULL;
>> -	if (!err_handler)
>> -		goto out;
>> -
>> -	if (info->severity == AER_CORRECTABLE) {
>> -		if (err_handler->cor_error_detected)
>> -			err_handler->cor_error_detected(dev);
>> -	} else if (err_handler->error_detected) {
>> -		if (info->severity == AER_NONFATAL)
>> -			err_handler->error_detected(dev, pci_channel_io_normal);
>> -		else if (info->severity == AER_FATAL)
>> -			err_handler->error_detected(dev, pci_channel_io_frozen);
>> -	}
>> -out:
>> -	device_unlock(&dev->dev);
>> -	return 0;
>> -}
>> -
>> -static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>> -{
>> -	/*
>> -	 * Internal errors of an RCEC indicate an AER error in an
>> -	 * RCH's downstream port. Check and handle them in the CXL.mem
>> -	 * device driver.
>> -	 */
>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>> -	    is_internal_error(info))
>> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>> -}
>> -
>> -static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>> -{
>> -	bool *handles_cxl = data;
>> -
>> -	if (!*handles_cxl)
>> -		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
>> -
>> -	/* Non-zero terminates iteration */
>> -	return *handles_cxl;
>> -}
>> -
>> -static bool handles_cxl_errors(struct pci_dev *rcec)
>> -{
>> -	bool handles_cxl = false;
>> -
>> -	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
>> -	    pcie_aer_is_native(rcec))
>> -		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
>> -
>> -	return handles_cxl;
>> -}
>> -
>> -static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>> -{
>> -	if (!handles_cxl_errors(rcec))
>> -		return;
>> -
>> -	pci_aer_unmask_internal_errors(rcec);
>> -	pci_info(rcec, "CXL: Internal errors unmasked");
>> -}
>> -
>> -#else
>> -static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
>> -static inline void cxl_rch_handle_error(struct pci_dev *dev,
>> -					struct aer_err_info *info) { }
>> -#endif
>>   
>>   /**
>>    * pci_aer_handle_error - handle logging error into an event log
>> diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
>> new file mode 100644
>> index 000000000000..b2ea14f70055
>> --- /dev/null
>> +++ b/drivers/pci/pcie/cxl_aer.c
>> @@ -0,0 +1,138 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
>> +
>> +#include <linux/pci.h>
>> +#include <linux/aer.h>
>> +#include "../pci.h"
>> +
>> +/**
>> + * pci_aer_unmask_internal_errors - unmask internal errors
>> + * @dev: pointer to the pci_dev data structure
>> + *
>> + * Unmask internal errors in the Uncorrectable and Correctable Error
>> + * Mask registers.
>> + *
>> + * Note: AER must be enabled and supported by the device which must be
>> + * checked in advance, e.g. with pcie_aer_is_native().
>> + */
>> +static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>> +{
>> +	int aer = dev->aer_cap;
>> +	u32 mask;
>> +
>> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
>> +	mask &= ~PCI_ERR_UNC_INTN;
>> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
>> +
>> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
>> +	mask &= ~PCI_ERR_COR_INTERNAL;
>> +	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>> +}
>> +
>> +static bool is_cxl_mem_dev(struct pci_dev *dev)
>> +{
>> +	/*
>> +	 * The capability, status, and control fields in Device 0,
>> +	 * Function 0 DVSEC control the CXL functionality of the
>> +	 * entire device (CXL 3.2, 8.1.3).
>> +	 */
>> +	if (dev->devfn != PCI_DEVFN(0, 0))
>> +		return false;
>> +
>> +	/*
>> +	 * CXL Memory Devices must have the 502h class code set (CXL
>> +	 * 3.2, 8.1.12.1).
>> +	 */
>> +	if (FIELD_GET(PCI_CLASS_CODE_MASK, dev->class) != PCI_CLASS_MEMORY_CXL)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +static bool cxl_error_is_native(struct pci_dev *dev)
>> +{
>> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>> +
>> +	return (pcie_ports_native || host->native_aer);
>> +}
>> +
>> +static bool is_internal_error(struct aer_err_info *info)
>> +{
>> +	if (info->severity == AER_CORRECTABLE)
>> +		return info->status & PCI_ERR_COR_INTERNAL;
>> +
>> +	return info->status & PCI_ERR_UNC_INTN;
>> +}
>> +
>> +static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>> +{
>> +	struct aer_err_info *info = (struct aer_err_info *)data;
>> +	const struct pci_error_handlers *err_handler;
>> +
>> +	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>> +		return 0;
>> +
>> +	/* Protect dev->driver */
>> +	device_lock(&dev->dev);
>> +
>> +	err_handler = dev->driver ? dev->driver->err_handler : NULL;
>> +	if (!err_handler)
>> +		goto out;
>> +
>> +	if (info->severity == AER_CORRECTABLE) {
>> +		if (err_handler->cor_error_detected)
>> +			err_handler->cor_error_detected(dev);
>> +	} else if (err_handler->error_detected) {
>> +		if (info->severity == AER_NONFATAL)
>> +			err_handler->error_detected(dev, pci_channel_io_normal);
>> +		else if (info->severity == AER_FATAL)
>> +			err_handler->error_detected(dev, pci_channel_io_frozen);
>> +	}
>> +out:
>> +	device_unlock(&dev->dev);
>> +	return 0;
>> +}
>> +
>> +void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>> +{
>> +	/*
>> +	 * Internal errors of an RCEC indicate an AER error in an
>> +	 * RCH's downstream port. Check and handle them in the CXL.mem
>> +	 * device driver.
>> +	 */
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>> +	    is_internal_error(info))
>> +		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>> +}
>> +
>> +static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>> +{
>> +	bool *handles_cxl = data;
>> +
>> +	if (!*handles_cxl)
>> +		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
>> +
>> +	/* Non-zero terminates iteration */
>> +	return *handles_cxl;
>> +}
>> +
>> +static bool handles_cxl_errors(struct pci_dev *rcec)
>> +{
>> +	bool handles_cxl = false;
>> +
>> +	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
>> +	    pcie_aer_is_native(rcec))
>> +		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
>> +
>> +	return handles_cxl;
>> +}
>> +
>> +void cxl_rch_enable_rcec(struct pci_dev *rcec)
>> +{
>> +	if (!handles_cxl_errors(rcec))
>> +		return;
>> +
>> +	pci_aer_unmask_internal_errors(rcec);
>> +	pci_info(rcec, "CXL: Internal errors unmasked");
>> +}
>> +
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index e2d71b6fdd84..31b3935bf189 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -12,6 +12,8 @@
>>   
>>   /* Device classes and subclasses */
>>   
>> +#define PCI_CLASS_CODE_MASK             0xFFFF00
>> +
>>   #define PCI_CLASS_NOT_DEFINED		0x0000
>>   #define PCI_CLASS_NOT_DEFINED_VGA	0x0001
>>   



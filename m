Return-Path: <linux-pci+bounces-18640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A80279F4DFF
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 15:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC0B18847DA
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609BC1F6663;
	Tue, 17 Dec 2024 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v0pLckNl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764BF1F63E1;
	Tue, 17 Dec 2024 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446361; cv=fail; b=hOqhRFWpzAxm3gClrJiC09fBHDWPJAMWgXpssGrisjWqjMg5QE5bsD70BnBujpzbRWwKnRwcYZ2cvSs4Hdk7yf6Kki4sbqRr080bhMdPFTP7XX8Ki/JfDfjh5Z5PKrDigfq3VtraZk2l4xcBTFtPAT6hW63VD8j4dpQ6E7DuYI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446361; c=relaxed/simple;
	bh=XQeuR9wHtYyiLlvxAk0/81X/wCqMGibSFSSIyfbJXxU=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QD44F2uYD4odfUs8cznbFpgLYWvrufkVXlMAR4aWf6b8PpRquQ8BQNIoeMRZmawIsJzX7Uy6ecRA3ZLN+md3j89ZaWev7BebGC9aDYNv2LEiZW1UjuuLIsVS2UFRQZgzCgmXvNSUUecDi9t7nsiMnNJwCJ1YfqHJ7JsyU59a7ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v0pLckNl; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hE/PvL/YMcqGLs5ZhyvtrYs9CuoL5Vn6fuQX3tOoN8Xhc3BJSSab62so9V6heSFQoaISjSubCpxTc3SMIeeB0ma6TAkEORNHkOUq40MyzYHonk5eXWfXwxK2f2fEPaci3KXPD6Us5tmCVIrHQ8n7v5ZXy2rlTklCxf9spaBJ3iJXw9f1zn3VsidHSxMczyPU9rtpSMX03qojSJ5OQKAkZ0/wYXQA/9bBIYKcIShXqv7pW2HZ5/YyFjYU6wGABWT8zU36KBvPzGZ5E8+1Yo8HgmHMF/Bpx29RsjhjE3mc5WSisQQ64wNIK17UUrCSC0agfj4WaLUH+lRGLh94vxaBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDGc528fn2ytGxf0Rp4QOxLOrvb4FALlCY5Gu1pWzLk=;
 b=gtFmRY4H2pRBPeBualOdSeTPBLHu+cneoJgMYtCPhINs+JXJISXY9m1uCZlg3tJh/9Q28BOpO8b07qGHbIU2MJIZEvMpKyQSVy/Xg3rPpCS+/jgxO5DAISTZSj9fCj+qquIWGiIosUf+w6cbEgJLIJZBHFSeTiI91sRztz+qddCbhMwt0J46UL2ARBTaPE5v7XQpfOqR/SptFUyvupZpx8c5Bl2JWAOvSJaa5qbR8EGcvoNlQgpwViLsYMxwaOtigbx04tcZaBV1wU8fyRmmoJyOQvX4qwN1GzI18Ah5cjVPrpohGo5Fex2liLdAT9Bes1RHr1/Phqg5wgOBGWrMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDGc528fn2ytGxf0Rp4QOxLOrvb4FALlCY5Gu1pWzLk=;
 b=v0pLckNlRYw4QgWHMsQv3k7JuBVQXfPfknebYhT0B22jMeRxhInyEiMPdpeltoMmbgeY5UnLt7MU+NfedxnbY9TYthcNjv4QKiqTdu5/vbc6z6waXp5JkJFpcW0v3ZpC5PvMhGF/PH06TPCw1gyFc+EfrBdqTtvkACS1bEqsTdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Tue, 17 Dec 2024 14:39:15 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 14:39:15 +0000
Message-ID: <b5779064-c1fa-497f-b7e8-db943ec9d38a@amd.com>
Date: Tue, 17 Dec 2024 08:39:05 -0600
User-Agent: Mozilla Thunderbird
From: "Bowman, Terry" <terry.bowman@amd.com>
Subject: Re: [PATCH v4 14/15] cxl/pci: Add support to assign and clear
 pci_driver::cxl_err_handlers
To: Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-15-terry.bowman@amd.com>
 <04d33184-be7b-432b-a83f-fce649de3491@zohomail.com>
Content-Language: en-US
In-Reply-To: <04d33184-be7b-432b-a83f-fce649de3491@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0121.namprd11.prod.outlook.com
 (2603:10b6:806:131::6) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c5c8dd-78e9-4a80-3344-08dd1ea894a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEVPNDRHaFFXUEltaS9kd2pZM2FjbithMDIwWlNMdTZjSGtXelo5QmFmazRH?=
 =?utf-8?B?N0NiMUdKVVBmYW1LbTNiZzBJanRvMXFwRzl4ZGVyYjA5Ynk3NDkvRWhJL2pZ?=
 =?utf-8?B?R2ZlN3FZbG9RT2UyeldTSmJnU2lnM0N4NjdtVWE1SE9sWDZDRXNTaE5GZ3pF?=
 =?utf-8?B?K216REczSUxJMzRWQ255V1dVZXdlT2ZxNXdGa2tJSGhRMjlndW5OODlFZ3I3?=
 =?utf-8?B?aTZ4ODVHSkc1RWY4b2N6N3daNkYzWi92bE1PWEF1STZBSUN4T2FpWEFhTDhK?=
 =?utf-8?B?L1RDSWtxSVJTT1J0UFJoVU9UaEhib1RRWTRRcjU1a2kxa0hGdm82ek1FVkxR?=
 =?utf-8?B?Z1BORHdaaWkzNFVCa3hEK3lNcW1yLzZvUEVkdnl4aEZ3ZXR3WmliUU5aREhr?=
 =?utf-8?B?eWFHZklzWk5iUVJFMFdUNFhyYVhwSDQzYWRPSi90WFh2NVpVNmswWFVKdzVp?=
 =?utf-8?B?NkdKYlFyeHBNV2xMeU1CKzk1aFg0UHZpUGg0QWZ5TXB1NXlYWEUwRStKcnoz?=
 =?utf-8?B?TkxWMWoxY3RlbnZ2YnB2R3grU0w0OXdTNEZiRW9qb25yYlE1V2RaanFTZ2RN?=
 =?utf-8?B?aGw5d1dWczQ0K2RKNkV1a3ZrUmVDaUwvYUtmSkpBZ0tVYlRMTDJTRmFZWjdu?=
 =?utf-8?B?cFhQMUFNb2t4c0hzaXA2em1iZm5YUHJIWUV0eHgwM1VNd1VvTGUvWE82MzNG?=
 =?utf-8?B?aHIydWZPRWo1TkNVbUNIU2xYUG9KMDNVZDFHdWtGUXQrOWdNbjA3Nnc5azhH?=
 =?utf-8?B?M2tqQjFwUDFOWmJhNUNMejlGYmp0cWcrdlliWU5NVlRTSGNwYThqaWtxNEtP?=
 =?utf-8?B?ZXBOYVNKZm9kVGdCd1NDREx3MXdGMDI0V2FvRTNDR244eVk5VlBXaGg2OFJi?=
 =?utf-8?B?dEZ1c0dQN1JMaTdIQm9tbVF3akt3R3NNcGlNNE9sMXpvNmxhNDU1b0NXK0xx?=
 =?utf-8?B?SE52OSs1SFpnL1ZjM3NkczRRckRKMmpFL2ZDOTlsVXo2cllzQnhubm5lOHcw?=
 =?utf-8?B?eXMrTGpKZWRjcncwekJvcURCc0poK3V1R1JLY0NFZmtDWG9Zanoxa1YvUjBE?=
 =?utf-8?B?M3drTlM5VHdwQ1lTTXNySlFuUkg0YlpnYlhvYy93M2doRVo2bjNwMGxaZ1N6?=
 =?utf-8?B?Q09wMVpDTlJ6Y3V4L1RheVFGUjNqb2tmc0VoMkUyNWF6cHI0bkNlbEV1RzdP?=
 =?utf-8?B?S2Q4bFNzVy8wanl0NVV5OExqNDJ0OEQrdXovUU9yUG9YcmFYVGpkMlZpUHA1?=
 =?utf-8?B?NE1qWWNJTGoySzB6U01mKzB2RjU1L2g2bEs4aEJLYTJIMVdUL3d0Y0JXc3Ew?=
 =?utf-8?B?SHo4bFNLbktFeDNZTi9oeGFUdWNUbXMwVll4L09Eb1RkTmE2SE5Xb1o3T0Mr?=
 =?utf-8?B?MFpzUC9URXVUT2hMMStVd1lTQzUzODdsQUwrMHdzdGRxVU0wVnNIdmFZUWlL?=
 =?utf-8?B?MlpVcjFvVUhCaitqN2JjbXhPbTBlLzVGK3JLRnpZZUo0VjY0SEN1UU9odXNz?=
 =?utf-8?B?YlZnWXZTK1krejBqeEJ0Q040b3ptSExWQ1hzdVdzaEFpZGJaVXFhdDNreERS?=
 =?utf-8?B?dzNpRlg5QWljN2JQdjl3K21UUCtOODBRelhMVGttKy90U1BsVlVacVVTckY3?=
 =?utf-8?B?bjZhQ3g0cmpsNGZBbE8rbTRaQjlFTHYzUjJzb1doeWVqdVdCTysyY1hTWndu?=
 =?utf-8?B?dGlaMnZhOE5PSmFUYnlaV2tPYlRpdHZCdmVSQ0VGbm1XZFovRzhIdVo0REE2?=
 =?utf-8?B?Smkva0djRjVJNFdTSHE3TjduOXVHakpPRHByNWhiNDRwRU93U3ZBT2NXYlpi?=
 =?utf-8?B?eWRPOEFqQ2RWT2hjRXowWDdSR2ZIYkdrVXdtRzNCK3I3eFRwSWJKTTB1WVNs?=
 =?utf-8?B?SDA3bTlTU1pwMXV3a1FQVnluYnIzTXhSZXFWTThmbTBWbDlSckNBemZnaFk0?=
 =?utf-8?Q?zlb2bx3RFMg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVZlTVNVU3U5cTlEMVEvZHkwVlR6VlBHUGNaMWV3WGU0YjEvSWhmUUpIZVB0?=
 =?utf-8?B?a2pFYTNpRWpzRThweEVWWE5LOGx6Mk1zdUMrUmgrVm5EZ2ptNVNWODBQUEph?=
 =?utf-8?B?bEkrZWlvRzREZml5VmxMakZTWXpMVjdhTGhSTnozNEtHNVFmV0tlaE1jUGRo?=
 =?utf-8?B?RFo3Y3laZEQxSWozRnF2ZHBvSmpmNUFlbkZFcXdORzRPQlhrMHRGNEhxeEFu?=
 =?utf-8?B?cFJzKzBOVGtzekE1Y0NsS2I5VVdHSmg0d0JWdU1zekkrVUl1akJid00xSkRP?=
 =?utf-8?B?dWREcExZVTRxWjdDQ0hsVHJ5bmlzam5ncUFibG1oNko3MVVzUGVXRmx0YmRZ?=
 =?utf-8?B?MU4vREtXNlJ4UE9JdG5DbS9wUkFkdHBScW8vWUJpN1FTZ1U1SXVzUUxUWFZx?=
 =?utf-8?B?Qy8vVGxtcC9QK3lybHVCZmxkYmdvTytQMytDcjJwQXJyMTQyRE5oL2lIcjhr?=
 =?utf-8?B?ZldtTjdCK25xK1VPUFk1T1dDUmMyUkZGemdkQzlOTlBYUFd2b1piVVhSZUV6?=
 =?utf-8?B?YlQzd0REVlNyTmlBbDFxcGhlVWhDTUp1alV6Y1B4K05qTFBRZjVxaFlYQ1dx?=
 =?utf-8?B?RVZnc0NMQ3lVSXVHYzg2RkJyUXllVW9qMGQzMFRxelovRmJxUnNUOTdibGpk?=
 =?utf-8?B?L2FxWlczanAwRTMxU2I2MWRkekNIMUJaVkY3V3NoSXVTcnVKazVGWTcrRlhl?=
 =?utf-8?B?cHFmZjNNcjdmN0tmSzhQVmR3VW1PK1NtRVRyQXB4V0tCTjdOSktvMkJjTk1L?=
 =?utf-8?B?aElwdGVrOVpweW9qYTV0bmk1TDB5R0pSYnYra2NQbzFKaUNEQ2NFL0JZcDlm?=
 =?utf-8?B?T0ZpWTNVa2R3ckR6YzFjRXhzYkx6Ky9uZWE5VUM2cGE1MUVvZnI1RmxMbGNU?=
 =?utf-8?B?UVFLdGg4V2ErWEliVFZUbVE0V0hFZDRFdmhObGRhak9LNUppMjcwNDQrWHdT?=
 =?utf-8?B?K0pGQklVbExRbTNHKzRHeFhjU3ZqSHgyNWlUV2RPREJxTGtibjVMWWxVNWtv?=
 =?utf-8?B?NzB3eU5TbUV6QlppeXVDRWJSeXpuRk50NGhNdWF6NEtFTEhDY04xNUZqRWFu?=
 =?utf-8?B?RUc5M0Qwdkh4MHAveDI1c0hYb1c4ZjBYUWEzYkR5N25UeG1jRjdYY1FWKzJD?=
 =?utf-8?B?NitFRDh5SzBJMUVCSVBWUW5kSlBGV1JvLy80S0duMGNlYXl4bVlhemZSWVo5?=
 =?utf-8?B?YXF2TkR1WXAxNVhuRWZlWU1keWlNR2w3TTFYUjZzUi9iY0cyaVFuMnZuSWJr?=
 =?utf-8?B?ODhRTUZMQlY3V0oxMWY3R1M4TEhya0JMVTF1Y3dwci9yNmtzQTJsQzd6K0RF?=
 =?utf-8?B?QzJRNGdidWZiYmVoRjhlM0ZFd0ZNeHpRUWwzWENVUnN4NnYza1JjakliTXJn?=
 =?utf-8?B?a1hPajJ1Q3RIdE5xUm0zNmlNWTBtVnpTTlp0UUxJWk9CUjBIc21qektKd2tW?=
 =?utf-8?B?Tis3NmdNWHJVbFM2L0VKc2cra2wySzJnRW03WHgzdFFlRnFzaVR5dXc0eksw?=
 =?utf-8?B?ZWc1T0ZWR05YTmtVQU5BT080c3lsOEtZYU9uK2lwd0g0bVlwejVEQ1VHOW1w?=
 =?utf-8?B?bnJxRWpSb0NmL3c3dWJnVVZrdCs2aWNVM1RJRjBuZzhNTFhuRS8xb2JzU0lK?=
 =?utf-8?B?T2IyS09XaUdOY0NpREJsd05CYVRLbUxITWtoU0ZobGI5OU5lekF4YU0zaFBD?=
 =?utf-8?B?dVFBZE90cUl0VmN0QlV5cHFJcWNuRWhKTXh5cGlVTHF2ZVI1WFM4OEI0Yktu?=
 =?utf-8?B?bUUrdVFad3dwbVNtaWcyUStvbHRucG1BV1hIdjhrZVZhWFhxZ2xJa0llNjBt?=
 =?utf-8?B?a1Y0NmdJVG0vUENHbXo1U2dURFJQUjFIZXZpeklNNzJ6dmtoYTJUeDhpSDhN?=
 =?utf-8?B?bFBxdFQ5d0hKTnBzbjJqTXhYeXhHdGxYc0VucTBsMEwxclBsV2lsTDhsektP?=
 =?utf-8?B?WnRRWFlGQlI5cWVmaEc4TENzOU1BdW9nMlJ0Q1RETytKc0tLcUx2Um9BZXBr?=
 =?utf-8?B?clk3Q3I5bFJ4b2VwdzJRT0w4bStNdm84UjNsQlNLa1NSVVhhOEV4WDdpMnNB?=
 =?utf-8?B?MDhmbHdOeHZIenluUGkzMUhoam82MXZwcGNiOWY1ZGJMMS8wNHJMNkZMQzBo?=
 =?utf-8?Q?2ez2f8AkWDzTRNPpAbkPUGhad?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c5c8dd-78e9-4a80-3344-08dd1ea894a4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 14:39:15.6258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhARH3naH2XtFLXxBXwHhjAh1hjJxtrx0hcM28Mbb5tbwfOLwx6HR9ToNZ37G/BGHc+1NHxvXZ7qaalIn9svhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796




On 12/11/2024 8:31 PM, Li Ming wrote:
> On 12/12/2024 7:40 AM, Terry Bowman wrote:
>> pci_driver::cxl_err_handlers are not currently assigned handler callbacks.
>> The handlers can't be set in the pci_driver static definition because the
>> CXL PCIe Port devices are bound to the portdrv driver which is not CXL
>> driver aware.
>>
>> Add cxl_assign_port_error_handlers() in the cxl_core module. This
>> function will assign the default handlers for a CXL PCIe Port device.
>>
>> When the CXL Port (cxl_port or cxl_dport) is destroyed the device's
>> pci_driver::cxl_err_handlers must be set to NULL indicating they should no
>> longer be used.
>>
>> Create cxl_clear_port_error_handlers() and register it to be called
>> when the CXL Port device (cxl_port or cxl_dport) is destroyed.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/pci.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 3294ad5ff28f..9734a4c55b29 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -841,8 +841,38 @@ static bool cxl_port_error_detected(struct pci_dev *pdev)
>>  	return __cxl_handle_ras(&pdev->dev, ras_base);
>>  }
>>  
>> +static const struct cxl_error_handlers cxl_port_error_handlers = {
>> +	.error_detected	= cxl_port_error_detected,
>> +	.cor_error_detected = cxl_port_cor_error_detected,
>> +};
>> +
>> +static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
>> +{
>> +	struct pci_driver *pdrv;
>> +
>> +	if (!pdev || !pdev->driver)
>> +		return;
>> +
>> +	pdrv = pdev->driver;
>> +	pdrv->cxl_err_handler = &cxl_port_error_handlers;
>> +}
>> +
>> +static void cxl_clear_port_error_handlers(void *data)
>> +{
>> +	struct pci_dev *pdev = data;
>> +	struct pci_driver *pdrv;
>> +
>> +	if (!pdev || !pdev->driver)
>> +		return;
>> +
>> +	pdrv = pdev->driver;
>> +	pdrv->cxl_err_handler = NULL;
>> +}
>> +
>>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>  {
>> +	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
>> +
>>  	/* uport may have more than 1 downstream EP. Check if already mapped. */
>>  	if (port->uport_regs.ras)
>>  		return;
>> @@ -853,6 +883,9 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>  		dev_err(&port->dev, "Failed to map RAS capability.\n");
>>  		return;
>>  	}
>> +
>> +	cxl_assign_port_error_handlers(pdev);
>> +	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
> I think the first parameter of devm_add_action_or_reset() should be 'port->dev' rather than 'port->uport_dev'.
>
> 'port->uport_dev' is 'pci_dev->dev' which will be destroyed on pci side, 'port->dev' will be destroyed on cxl side.

Hi Ming,

Indeed, this needs to be changed for dport and uport as you also indicated in your other email.

This is necessary in case the CXL drivers are uninstalled. Making this change will de-register 
the RAS error handler callbacks so they are not potentially used to handle Port CXL errors 
after the CXL drivers are removed.

Thanks Ming.

-Terry

>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
>>  
>> @@ -864,6 +897,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>  {
>>  	struct device *dport_dev = dport->dport_dev;
>>  	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
>> +	struct pci_dev *pdev = to_pci_dev(dport_dev);
>>  
>>  	dport->reg_map.host = dport_dev;
>>  	if (dport->rch && host_bridge->native_aer) {
>> @@ -880,6 +914,12 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>  		dev_err(dport_dev, "Failed to map RAS capability.\n");
>>  		return;
>>  	}
>> +
>> +	if (dport->rch)
>> +		return;
>> +
>> +	cxl_assign_port_error_handlers(pdev);
>> +	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
> Same as above, should use 'port->dev'.
>
> please correct me if I am wrong.
>
>
> Ming
>
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
>>  
>



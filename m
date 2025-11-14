Return-Path: <linux-pci+bounces-41247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2CEC5E039
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 16:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83393382ABF
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 15:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08FE33E344;
	Fri, 14 Nov 2025 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NRecRswm"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D633B94B;
	Fri, 14 Nov 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133692; cv=fail; b=iN/kuf18iZe5IadYIyDBRfgEMCieQ+VX4SVCMPjSAUpxxexLyFCS127Tx+xCMiJN82LQMMW9LU4HUio+92lvnpjeQo+0bD5d907TGNyu0xrev2q7R/0+lyXuSXKBQAg7biBkAaPfXBmzKZG+ylKQbhhFA4RHmuQT/U/X/MNpt0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133692; c=relaxed/simple;
	bh=s2G046/2G7JCQpt7JF9iz3e+chdzKzWfPdUhwkLqH6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kGCOC2Xs6gbbmd3Es1tg4wWtGMO2+0ijteXR3lgx9Vmo2ob8QHfnEMyjVGIOFrl0/HtoucgI3FMCsvqSn+gQrEmM3+Auj3gQeu6vl8seJnZRyP+PTmHKH371+IrJzfFTdzDc0rGaL1C6Sipth/wTYXCkN7wmBKGtXov3qxymPZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NRecRswm; arc=fail smtp.client-ip=40.93.195.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCRoZVBYi+w0CNmnxNPmUKz1CRNZjQgkitDkbakwVGhLLlqp1aek7NPcNYXxZgIK/RamlwF8wfgodchFzJuqqBdJleIyqoJkEoUIsrI9fFFydzOpzpMO/MMjeq3kKCq6lWZqJAUuTmIyb/kNQBmDJjRf/0HxJVcXMq3HncuZZqDa8aUyP/6yL5Sesp+DQ0GGoLGOchuG2yWuVxu5DjAvMvHxBuMbCmgEVEzx+vml/Nx+VVhI8+j5Hli2YFRQbynx7Omi7zliWHq0k2sLeEHLlTlo2P/71bLAmohEW/kky7Wrx3Es7AmoeTgr6j9IXvb1g+2zyhUlcVxjllRvP0WZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boxOnxAr4RKwlwR1iMx3I1ZkhB0rkKCbRJKxq1DI0AU=;
 b=hM3+ge4cy8SR/7ylracFpVWRvD335GUJXSuLHAocxrJE7ZL4KwlYgJBCy3vQ5Sm5E9fdcDKG6iS7ppl8YfDzQfG+iNk6nNBKQYv9l9G1ji0JSwqf0wGT8/Q4saX/dT10JVxASpCyyjrtJP9bNPc5Z0Q/75EGyscc6hT4hMX9YQYd49Udv1uC5etTVp2jtolbJqbACE7dHH1X9DPs5x7cZwrr1zhNXAFX9knEv60yabtvDpoJ523Xpy17niBw7X/6LsbGQiM+P6Py2JXKdmvAY7X/QPcs8cb2mpLSk2zkv9YwkK9KvKjZNcT8GrVA61g3sD9SG/IRzC902cWSLmT9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boxOnxAr4RKwlwR1iMx3I1ZkhB0rkKCbRJKxq1DI0AU=;
 b=NRecRswm7dFbsR7VWLdNLQOdafQvIulmujidrx1Qu5AOYgugqsstmi6kN3fg/4DSruCzWFXK21xtWqC8sDbS/SS0TFrJCQtesPB8IJJbaqpxXPiZvSxdDPx4VqrFJMyAdsbqflSbGtds6gARIHf+JGB7+e5xiEsseNU9hhv/+zc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 15:20:12 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9320.018; Fri, 14 Nov 2025
 15:20:12 +0000
Message-ID: <31f7da35-e603-4272-9e9f-8edc8b4f2075@amd.com>
Date: Fri, 14 Nov 2025 09:20:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 22/25] CXL/PCI: Export and rename merge_result() to
 pci_ers_merge_result()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251104190348.GA1865266@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20251104190348.GA1865266@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0067.namprd13.prod.outlook.com
 (2603:10b6:806:23::12) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|MN0PR12MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 538d17a4-5bbd-494b-02ad-08de23914df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlduWGxHOFhXbExQWlJGUmJQMitJZTVFTFdDT2hVaVBpWnE3YVAxVzB4UHpl?=
 =?utf-8?B?a2dpemNPUDRBWGI1QzlnMjVpZjVzUVJaTVlkbWF6cVlMT1VwUlRrei90UEUy?=
 =?utf-8?B?dlJyYjl6aVNsK3hCZkl3VU02VFlwYmRocCsxa1R1UWdtNXByUGJYcUhQMU1U?=
 =?utf-8?B?QWRPYUpCWHlEeWc3NWc4YlNJTnF1Q2xHcG5NeXQvWDF3cTQ2REhXTHh0bGtV?=
 =?utf-8?B?S1h4cHA0ZzFHR1BJK09JYldPQTdjQTU0VExVeGc5QnZYQ3NHSlk3b3UxSmhR?=
 =?utf-8?B?bVBTUENDYWtja1U3TWJwdGR3cFhqTHVhMTkvWnUwM3JEWDBsKzRHSi9qeGwz?=
 =?utf-8?B?aXczNERHcGJ5bWxWcit0YnZXRnFCQ2lQSkFaL1dWQ3o2TGw3aFJ4d0M5K1oz?=
 =?utf-8?B?MHJ3bWYrV0tHSzBZTUNJaXZ2S1cxNHhuczd5a2lpYWR4dE5oRkpvL3NZNGJK?=
 =?utf-8?B?dm5nSHJpenNwVTVneE4vbmhVMmlwaTJYeitHL2g0Nm5ja0dJdGtsT2hzOXZB?=
 =?utf-8?B?UlRSNVRqSm5qVDZhLzVKbmNoRHBmNXJoNnZ4eTVlT3lMUU9kall1dWN5UHRI?=
 =?utf-8?B?QytEd1BDbkZ3cENKKzhibXJKNXhMR3pXeVhWeVZPKzdNWnJKWW53TWJ6VVRY?=
 =?utf-8?B?VkF1RHRRNXlGQjRPckZkNWVQWWVZVFkrNjJITERHK0d2bDNMeThoaEhkVGUw?=
 =?utf-8?B?LzRwYlZDd2tndC9nQmhUZ2d6MUhmRlZxV1R3UE10bmdYOURVYmpSdDI1RnY2?=
 =?utf-8?B?L0xiekRZQjZYazlXNzNvdG1hWnJCblNXYXYycVFyRE9Qd1FWSnQvUGIzSU9S?=
 =?utf-8?B?WTkyYjNxNjBpYXl4OHBZa2U2ZFFjTWpCdHNRK2tDZC85d0NFWWM1cGozM0N3?=
 =?utf-8?B?WkxXMVRJU3JlNjlRRUFpV2RLdW0vT0J6b3BabzFxUkJwL1YrWVREWDdTY0N5?=
 =?utf-8?B?NzVmUk1SNHo1TVRVRndxTFBUY3djWDkvdXFMUGRqTnBYL1llbEpIZXJGRXln?=
 =?utf-8?B?VTQzY3RIOG9mbEVUbldnbDNGR1o4cTYramFRRG1qa2J3N0xmVDRYekViVXNm?=
 =?utf-8?B?NmJCTTR3VnVZSWJtS01KZ0w5SnR1UnExdGJFdEtxS3Q1Mm5Vd0xwQm9vdjU4?=
 =?utf-8?B?emg0MlN5dVdYVGRSTlRDdldJMCs0K2pvdFdpcW5Cd3ZtYXBQWndmdmVRV1hk?=
 =?utf-8?B?QUdvUVpwNzZNZ3AwMWNvbUNQaWZ1d0MySGgyKzNFM2xKcVoyVnhvQ1luaXg0?=
 =?utf-8?B?UFhWNzd4c2hQc2I4dk9SaXp5T0gwU1pya2xiemNkYjBrSUFxcWtLZCs2RHU4?=
 =?utf-8?B?L200eDh1aTlCL3pBbzBlU1U2M2FXSUNFOVdWL2J0eEpXTS9kMVN3cGpIOXBE?=
 =?utf-8?B?dlUzUXR1RlhobXFSNVVpY1NibFZVVXU3N0xTbk9lbUhsMUtUclIxSW5NdVhG?=
 =?utf-8?B?NHk1OXVLL3ZrZFNZdm5RR2hydStuMHVEK2QycnZQOFg1a3BNTjBjdDA2a2Fh?=
 =?utf-8?B?SGRvU292TjJTVGg1S2ZjY05iRVZDK3NZV2pTVWhyMjl3SEVJd090NzZUaUZ2?=
 =?utf-8?B?dUNkcDFEV1RxdGFGWkZnbHlqc1I5c1ZWMUdEUjRUaUZuaG9QTUJBeVQycVBh?=
 =?utf-8?B?L1NjQTU1WGpLNlhtSzN3OC9QRCs3cDFWYTZpQ21SbURSVG00OGpibUR3WUVj?=
 =?utf-8?B?dC9MRjdodFlXR04wZnBWQmk5UVpUd3JkTS8rOG4zMEFISjR6MVRRcTNkc2JN?=
 =?utf-8?B?SWhubm5PUTFCa2M1Slh0Ky9CckRsMkRUOVNULzRVQTZxQWNvVGExRDUrV2xY?=
 =?utf-8?B?dHd2b0RyVi90OUlaZXpVVVU5Yk5TMTdQR3QxMjBkWjltSjQxeGdKSytYellJ?=
 =?utf-8?B?a0JDT0NteDJyQ1JDTTlLeVVwVGlSNXZxdCtzYUh3YS9yaTRDOUo3RUxQYXFQ?=
 =?utf-8?Q?vnp33qqjfRtbAd8bL7n5CXCaw0fXdTFo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVdjVWF3dXJNY1IzRTkrR29ZbFNndnpqZ0pUR29uTm9lMlMyN0E5cituaVg0?=
 =?utf-8?B?RnZtZmQxYnVYVzVPemtiVGpKazl0MkRwakpLZ2pQZkt3MVZ0TFdacUxlN2Rs?=
 =?utf-8?B?NWprYjRXN1drK2lMV0FBSm9HTHR1WnY5cVJ6d0VMTWNER2dDdWR4U1Jwa1Q2?=
 =?utf-8?B?bFI3SkhiUUt0eDlPOCtMRHJrVkszN241MXJ2TkZCMUxqb2RVWGdtSFNxTzZT?=
 =?utf-8?B?VXJqTXllakE4cUJCWlhQMkdTaVJDcUJuYVpSOEZTMElzYmRYQjFlaUxIN3ow?=
 =?utf-8?B?T1JIaVNPTFM3UHBWdjdTeE5LMFFud2l4TC9CWDZpeWxHQUNYZ0N3R2M4ZWNC?=
 =?utf-8?B?ekFTaFNjT2hlM2k0VnFpT0V5eGRwWUlNOStUcGdNQmcvMEYxRlJnK1NRZkMr?=
 =?utf-8?B?SzVHWkxTTGhEQklualp0K3lHalFlNXFUdkNNemZoakIwdXNrcWZPaktUVjgr?=
 =?utf-8?B?NUxyaFRQR0dTYWRFQmpzNzJSNjJ5YTZKem9CMlc5RjV2OFREN0IrUzRSZG9S?=
 =?utf-8?B?b0ZZZExzbXV2NDZvcjZYZHFnbEt0WWJXTDNRalpRSEc2VHdyNnlyNjJ0QXVr?=
 =?utf-8?B?ajhjMloremhMQUpzVUZBdjVMdzIwS003K21ON2U0ZWxHZmVSVTlvSGxxSWpu?=
 =?utf-8?B?UHE0T0JSWU05QS82aXM3QXBpZUFGVDJNdEFNVnNOZllVWklWMWtWbUZCMDRz?=
 =?utf-8?B?aHdiVExydHkzbmVZK2tLZG9sRkxuRmJwYnlnU1dLRGFPemxSR0dOS2lOU0hN?=
 =?utf-8?B?NTlHWXgxWFVPU3FydUhER1dZWnBubXNya0x4OFo0MVJzdjBnQkRIamkxS0N1?=
 =?utf-8?B?QUVOWkRTU3hEUGNweXhrRHpUc0s5eTlXVFRXRStqM1lBY1JxQ1lrWXMzRXc2?=
 =?utf-8?B?WmZhVmJVby9SUGhLbjFwdjNvQmQ3QXJOSHpWRS9xbEF0MVNxS2dXUEJ3S0Fr?=
 =?utf-8?B?SWx6Q3hNUDVXYjFaSzNDdHNGbWVKQXZzZytKVHpWV1Y0dGZOUk9RekNwT2h2?=
 =?utf-8?B?eldLdHFuRVM1a2dUQnE2M2FTeXExWUltWENmajhYaFZXV2MvbFlQU2JvUWJw?=
 =?utf-8?B?WXYyOFllVklYK3pBUE5ZWWRWQnVrdGpKS3NhN1RvWWFpSGdGZlpTRkRvelU1?=
 =?utf-8?B?T0tCeUZCSk81YStZbTFlcHVpeFhjUUhYQ3F0eEtlL0w2TEthcm8yeEdMYlM2?=
 =?utf-8?B?Vk1ud3FEUWJWUXBwUERFQXJXWlVtdFRoekJZUjc2VUliYkVwRWhDdFBNbjRR?=
 =?utf-8?B?RmVmY1VyMUxNbDc3WEtXanZ3TFdFVlVxWVQxU29uR0p0M0N2K2JJczdjYnFC?=
 =?utf-8?B?Ynk0ZzI2SUl4OXlhOXZmSnRKVlR6ZXpDM2xnRUw1SFJzbjZCWFZ4VEhDZ1hz?=
 =?utf-8?B?YVdhNDZJc1pzMW9TYVdIMUxBMGxsYXQ0dytla1FaU2xneUhRS0swdUFGcURX?=
 =?utf-8?B?Vko5SVJsQkQ4TTd5cHByNEJhOUdSSnFQdUovZ0JRYXN3VGRSLy9UdXpBc1F1?=
 =?utf-8?B?MVRMVzhDaFFRNC9YK29ZNlZjR205VWlGRWJyekJBQk81N0NRak5lSFRBZUls?=
 =?utf-8?B?R1RGZFl3UFYzakhucnVTUTF5T0QyUEpZcFBrVTNyWis2NmRrRVRXMElucUNN?=
 =?utf-8?B?TGpzYzJkMFVoZWdDMGoweEVuM3Q2MDU5M3Z1RXBDdTlUdFVLVmdyTGU2ZGFj?=
 =?utf-8?B?NDc0ajJ2UlFqVEFTNUhFYXd5eGJIRzJXSFAzOS9Fc2NyejIzNmZBUUQ0WUxw?=
 =?utf-8?B?bHhJWTR5eGFmTDRNNENWNDUzYkNORW8rbmhFaUpqY0xoRTNOTEpMU1VycnMv?=
 =?utf-8?B?WmlUVVFzNzloOGxSUGRNcEM5NDJNeG5PT1ZmZGl4TmMwQWJIV3hrQjV5Nk9x?=
 =?utf-8?B?Tm5hT3phQzlZUU9PbGN4c2Q1N25hYnIxRDl4WkRJTy9WTG5hNUdZWHFPdkwr?=
 =?utf-8?B?Znl5RWFLT0ZBeXo1aHRRbFd5NG5OTmQvWUpDVDZ1bTJBNFduaXNmTVQ4OGxi?=
 =?utf-8?B?YjU1clk1NnREM0dGOHFoR3NQTHNKbjFBZkNzT0RaZjNjVW1nUjNFSFVWVmFH?=
 =?utf-8?B?K1lBRGM2T01lYlV5S05Lam9SUm9keFJ0SEhqQ2lNOGpnLzlYNVIvSS9kY2FX?=
 =?utf-8?Q?m8xNQIKvO1sWG7uXXdMRkDohY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538d17a4-5bbd-494b-02ad-08de23914df6
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 15:20:12.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkxs/h0rEOjSFb9jecgIhSHhVUdqDCQ6bIWRuvnYOJieg31OufGu66zg7rjo8+/RkuDIe7dn/y9f+A4ElvacZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788



On 11/4/2025 1:03 PM, Bjorn Helgaas wrote:
> On Tue, Nov 04, 2025 at 11:03:02AM -0600, Terry Bowman wrote:
>> CXL uncorrectable errors (UCE) will soon be handled separately from the PCI
>> AER handling. The merge_result() function can be made common to use in both
>> handling paths.
>>
>> Rename the PCI subsystem's merge_result() to be pci_ers_merge_result().
>> Export pci_ers_merge_result() to make available for the CXL and other
>> drivers to use.
>>
>> Update pci_ers_merge_result() to support recently introduced PCI_ERS_RESULT_PANIC
>> result.
> Seems like this merge_result() change maybe should be in the same
> patch that added PCI_ERS_RESULT_PANIC?  That would also solve the
> problem that the subject line doesn't mention this important
> functional change.
>
> I haven't seen the user(s) of pci_ers_merge_result() yet, but this
> seems like it might be a little too low level to be exported to
> modules and in include/linux/pci.h.  Maybe there's no other way.

This is used in the UCE handling patch. I will move there.

Jonathan suggested updating |merge_result()| to handle both PCIe and CXL error 
cases with shared logic. The only other option I see is to remove the export here 
and duplicate the function in the CXL drivers?
/
/

- Terry


> Wrap commit log to fit in 75 columns.
>
> Suggest possible subject prefix of "PCI/ERR" since the only CXL
> connection is that you want to *use* this from CXL.
>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> --- Changes in v12->v13: - Renamed pci_ers_merge_result() to pcie_ers_merge_result(). pci_ers_merge_result() is already used in eeh driver. (Bot) Changes in v11->v12: - Remove static inline pci_ers_merge_result() definition for !CONFIG_PCIEAER. Is not needed. (Lukas) Changes in v10->v11: - New patch - pci_ers_merge_result() - Change export to non-namespace and rename to be pci_ers_merge_result() - Move pci_ers_merge_result() definition to pci.h. Needs pci_ers_result --- drivers/pci/pcie/err.c | 14 +++++++++----- include/linux/pci.h | 7 +++++++ 2 files changed, 16 insertions(+), 5 deletions(-) diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c index bebe4bc111d7..9394bbdcf0fb 100644 --- a/drivers/pci/pcie/err.c +++ b/drivers/pci/pcie/err.c @@ -21,9 +21,12 @@ #include "portdrv.h" #include "../pci.h" -static pci_ers_result_t merge_result(enum pci_ers_result orig, - enum pci_ers_result new) +pci_ers_result_t pcie_ers_merge_result(enum pci_ers_result orig, + enum
>> pci_ers_result new) { + if (new == PCI_ERS_RESULT_PANIC) + return PCI_ERS_RESULT_PANIC; + if (new == PCI_ERS_RESULT_NO_AER_DRIVER) return PCI_ERS_RESULT_NO_AER_DRIVER; @@ -45,6 +48,7 @@ static pci_ers_result_t merge_result(enum pci_ers_result orig, return orig; } +EXPORT_SYMBOL(pcie_ers_merge_result); static int report_error_detected(struct pci_dev *dev, pci_channel_state_t state, @@ -81,7 +85,7 @@ static int report_error_detected(struct pci_dev *dev, vote = err_handler->error_detected(dev, state); } pci_uevent_ers(dev, vote); - *result = merge_result(*result, vote); + *result = pcie_ers_merge_result(*result, vote); device_unlock(&dev->dev); return 0; } @@ -139,7 +143,7 @@ static int report_mmio_enabled(struct pci_dev *dev, void *data) err_handler = pdrv->err_handler; vote = err_handler->mmio_enabled(dev); - *result = merge_result(*result, vote); + *result = pcie_ers_merge_result(*result, vote); out: device_unlock(&dev->dev); return 0; @@ -159,7 +163,7 @@ static int
>> report_slot_reset(struct pci_dev *dev, void *data) err_handler = pdrv->err_handler; vote = err_handler->slot_reset(dev); - *result = merge_result(*result, vote); + *result = pcie_ers_merge_result(*result, vote); out: device_unlock(&dev->dev); return 0; diff --git a/include/linux/pci.h b/include/linux/pci.h index 33d16b212e0d..d3e3300f79ec 100644 --- a/include/linux/pci.h +++ b/include/linux/pci.h @@ -1887,9 +1887,16 @@ static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { } #ifdef CONFIG_PCIEAER bool pci_aer_available(void); void pcie_clear_device_status(struct pci_dev *dev); +pci_ers_result_t pcie_ers_merge_result(enum pci_ers_result orig, + enum pci_ers_result new); #else static inline bool pci_aer_available(void) { return false; } static inline void pcie_clear_device_status(struct pci_dev *dev) { } +static inline pci_ers_result_t pcie_ers_merge_result(enum pci_ers_result orig, + enum pci_ers_result new) +{ + return PCI_ERS_RESULT_NONE; +} #endif bool
>> pci_ats_disabled(void); -- 2.34.1 



Return-Path: <linux-pci+bounces-42642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3DECA4C60
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 18:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EA3630038EF
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4413F33508F;
	Thu,  4 Dec 2025 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wfUKLDfO"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E92259C94;
	Thu,  4 Dec 2025 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869456; cv=fail; b=j7SifNULp1HMesPiMc5YzmYR9ugaoW1VYqe+1u0edi6nQiVlgZSi+rSJO9XkoVlTNm87pOIromKcAlmFt+tac8r7COwtwlTGJDbMMx+m6z/p31L7eU1iQ3KGAgexXKUY4EBvSCl4wbY70Ni94BMw/UcIoYrqVoIBYYhOxBAkVh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869456; c=relaxed/simple;
	bh=LPVMuE7YwYbiBiMLchQhG3tAAlRGZkFcLS8gyonKve4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CYvmjhMuECLVhi3XzxqcDUECsuQ0Xzhho6GA/YQiVedUrT/XF9kftJlCeYyVu/GoGNMQTRlmJzjvSaWpRUSWITEGS3rESIXLCWr/SjBn35GTxh+tIlWGnUKEsMLzW1Ldl8vP4dwoB+I+pZxqWYy9gCiwbI/H2HZhugz9w1CF09M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wfUKLDfO; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHTpFSyUfqxueSusFkpRKS+o16hruFmrcwDLSoAT32JcYCR5/s8cNwVa0B/TtsZAgoraABF8frhuAo2v3CXjtoLEL2lH/dCeSgf3SBPqnrQ/goNffNnnhw4u1P4pM3ihlA/7BKnas/kz0HiYjn3Q08PXMXj0/SLWaKfQkNfWlE4e161nxMVgyTgCizi8w4ntzkOPY6RrtvzzUajA9CCXs56EdImRk45dK2FTo+ND+IVPJCh8PUNG39fAghjrGo2GpRZZZbvjbd1ZSV7KZruu8WIzCBV6QITlkoUeT8YX91N2AHs7LygkHuTTwrfts6jPkUySciksJBnEF7BFxSQmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1UUJibG6OxOmbNGu3ClSEkZKrdcfwlUwo5ga0HFlts=;
 b=x15n1KEJvuJP78UEiVXDh65y1X3lrvP7YNCnV2BMSlaCKvaqXDw9Pt0Zufctd/wi/tYM1n/Bw9e1NxD4P44frQW9xhCvQi1UVD/lpkx4dDsnMSFSi3fowbbQJ/ytHcGDx4x0Zl15b0vlRsjTXl6nDXLHuKZS5/L+74yolDUUYQvvtvirntLcf18M21Ag+SAMGGNUudT7QbHbG8EVLijj7yv3iflwjft/+cdxIOVFO2Ws+MGksAVc5snzKAqt4UBupcgWsoOMNkS3MwKKDeOLv3ciVGtfoScfHZhWEMfgpRWidj1mB1/HdvnJ4nfZT88SI0dITRQ1J04/8cSsUbiuUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1UUJibG6OxOmbNGu3ClSEkZKrdcfwlUwo5ga0HFlts=;
 b=wfUKLDfODnMFsRrlAJfU/a0r/G9D0Ps1610byesvrS6gPjxOAJfeUNPVBiLFYInP4p9iuojdZ2E3CGRXAXGTJZDx+dyhR169ngboLL5EtTsgU9KO2kts8MzMlrzsWP6kn88/WqjHXQ+vqJeZYbx9i6NMJktZdcrc/SsOamBNRIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 17:30:51 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 17:30:51 +0000
Message-ID: <00537640-96a1-4476-afd4-c8c4894d7931@amd.com>
Date: Thu, 4 Dec 2025 11:30:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 00/25] Enable CXL PCIe Port Protocol Error handling
 and logging
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
References: <20251104221200.GA1874852@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20251104221200.GA1874852@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:806:121::22) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: d58723c3-c573-4a96-acd3-08de335adef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0M2L1ZoZVFHRmI4ZjJwZnc2Ry9CeXJ3Z2VONW1TWjkvSVdSOWpUbVQ0a2dw?=
 =?utf-8?B?VGFpbDhDSHF3UnUxWWdTVUx5Vk5sWXlHZ244OWNlWkJPWGtwM0ZjZHNOdHZu?=
 =?utf-8?B?enRaZ080aXpDa2ZrNHk5SnRuOXpXOG1qNVFHZEF3c1JlRlpEWW5obzdYRjRG?=
 =?utf-8?B?NGllTytZbW9lZUFRQnc3K1NHSkREK0tJVjVtZXBWNDdabnowdDBWaGlGelZk?=
 =?utf-8?B?Y0UvYlY2YzY1aUVmTTBiTVU4ajZBRDVLbWt6cnMyRFQ2QXlDWlhtNjhSVDlD?=
 =?utf-8?B?V240VVZTN1NoZEh4d2xCSEM3eU5PazJRMnFPWTNNSElEVWhKbjk1S0tTeUtC?=
 =?utf-8?B?c2hmb2ZlVStQankwbG5xRkpjSmhYWFBCK2FWQVpuQzR1cHpKTTRPQTBIT3NB?=
 =?utf-8?B?NUlSUzJNNzB0VHo0NDNwMk5EaTJSTVdZNUo4ZFJ0eDlsYW9JU2czNlY5alU2?=
 =?utf-8?B?bHVzQ2ZsVUFPR0NlS29tV2VaUnZYWU1TREx3VFAyOTNIMldjQmNXVnVCVE50?=
 =?utf-8?B?aGdRNnkyM2h0bEZuUWk0cGtnd1BwUkkyZ1JYVEJ6emdXcGdoaTFPUkNQSlZ2?=
 =?utf-8?B?QTJJZVo1aU5KbXAvTUQyMFJyakRZRFd5SVE5SldRUjNLKzJPQXNtYmNQdG5n?=
 =?utf-8?B?SkJyazJERGNpeXQ3QlhBSEEvLzIvb2Z3bzB2Z2pkemxQdGFwQXRpYi9ISzl2?=
 =?utf-8?B?VHMzMmduMlpOeEI0WHJnbEZQMWE2NDVybDBkckc4SmpvU01vbTdGZ1BFaGs0?=
 =?utf-8?B?OUFrQjdvdS8vdXBpYkZtMlpLMkNFbWRoMytVdGlBNjB5Rjk2aVVZT1ZHRkRY?=
 =?utf-8?B?djVrWm44T3RncWluL0Jldkl3Z1l4NGRqS2p2T0tITkJnQ09tNmR5WFltUUtZ?=
 =?utf-8?B?U1NBbUlaZUQ1amxDZmtEaGJLRU1rbFRpdVF1OE9qbnllbFlScGhKSnErYWs5?=
 =?utf-8?B?WjBTWmd3SC9tQURaR0tJbmtCVFo0TWdTMW54dlM1VXpyeXdFNnZmMGxYSTBr?=
 =?utf-8?B?Z3MwL1I2WFpnN01yRmZiU1lKWjhHTmd0S3VXOHltZFdPV1FEL0V0RDJKWmho?=
 =?utf-8?B?MmZOUitUK05kKzRQakVrd080VFBGdkNjY05od0xOWWY2RE5wdFdhVTBjd3kr?=
 =?utf-8?B?UnNSZm5ZUTUzK2swVHNrM3NFZXBQSDBCWFFLamU0aU5aWVR3Z3U2M0o0RXJn?=
 =?utf-8?B?ZXZpTmlHVkYxSjArdGFYOVZtS2NSNXRXd2htTGZDUUFLaVQ5L2VJazA4enZl?=
 =?utf-8?B?MjlHbkR2QmM0eks3M2FoS2xTRE82TFIwb0JOWnY0RGJITE9FdFpnZmdZYm4y?=
 =?utf-8?B?OENXeFVOSjZTZzJxN3MzNnpQUDJYNTBpSnE3T1pPUG5LQnFTT0dPZlZhWk94?=
 =?utf-8?B?YnNDaHJVcnNhaU5tTUgzcVBibmdjUyt6RGZaczNUcEwvVS8va0VVUzFhNE50?=
 =?utf-8?B?dkdVQjd2MW1zajA0VjV3WkMwc3VkcjQvNnRzR25nRXRWK0piT21XR1NnQ0hm?=
 =?utf-8?B?Vi9Bck5GSnc3TDQ5Mzh2MkJ2UGxJYm5xMVAzcythdVRaSzcySlFLNU9sUUxB?=
 =?utf-8?B?cjFIdUVPT0ExbnFmLzFEdS9vaXRqSXg0amhMbDNHY3haNU02cUxxb2J3Rm52?=
 =?utf-8?B?NTlZVEFOcXdoUHEyTzVEellxOWcwRHlNQ2FhWTFFbHhVcXpEYVNkRFRjeitP?=
 =?utf-8?B?QWVjdlhsTG9QRkh4ZFR1UktuUkJhb05saTBBa25TTzFDcHJHR3dHb0dPT0t3?=
 =?utf-8?B?NTRRTndWeFFQZTRpOGhhdzM2UjVVZUh1dVkwcXpiSnlmUytKOGtJUGIwbWRk?=
 =?utf-8?B?MmdwQkxyVEpqUEFKcVRCcldKNThmQlVnZWVaTThFRWppMTFwQ1MrNHVaZHUx?=
 =?utf-8?B?TWE2d0xITVdTMVk1SFVsaHBzZlQ0ZnBEWTZsUE1PZmJDWG1Kd0dnRFpiQkNr?=
 =?utf-8?B?dUYxQ1JFTEUrbEYzUkNQVUJjWXpIYzZIU3YvVHRHc2NYVjhEQm01ajlnVk5T?=
 =?utf-8?B?ZnQyQksrQ2x3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnNiaThES2NXdDEzemt3elg3QThMSFRPVjgwdUlkRDhmclBDcHJvQXBPdE5B?=
 =?utf-8?B?MVo4S3dZVGlPZ1BsQm8vdVk4OEdhU2VXNEJ1OU1MR1ZYRXZidHVwY0tjVStB?=
 =?utf-8?B?Z01JRmNpcktCWmFxZVJEVW9POG9uVTFZR2cyOFhLc2wrSE5LUzhZT0lqeG9J?=
 =?utf-8?B?cklJQ09BOHNWMW9BSlRxdnJzbWVzZEE4VGpZZCt0aW1nRkw0RnlHSDV6TFpq?=
 =?utf-8?B?NG1DUjltMjVaemNtanFqZUEvbTFzWUlLUWwrZGhCV1BuRkk2MVZ4bGNFbm16?=
 =?utf-8?B?dU1WRVRicEtpSUNXWXE1V3VqcldiTGNYSU5TT3Yzakx6TmtvS3BxQTRMa01V?=
 =?utf-8?B?ZUZBQjRWaUt3NFlRWDNTbTRFUHYzNUFOcmYxUEh3YjMyNysxdElxY3dFSXZI?=
 =?utf-8?B?dkNRbW9lRUR5eC9FVy9hUi9hQzZ6WmF2T01WdXNuZlhVT2Q4ZkxwTjFBSUVl?=
 =?utf-8?B?dGJQTTV5UGswblZTNHVJOXdDblNwYTZ0TDVjRHhRdXhYWHJPcXdKL3VwMjVz?=
 =?utf-8?B?MGtWaUJtdmJqZUpSWWhNSTRkdkZWTURBWDJYdWhQUlVDOXJvclF5UVZWNHFN?=
 =?utf-8?B?RXJ0SWs4NWlSUjZsZkdUdEJRUkxCMFI3eXNkN1dBTXlwZmZsRnZickVZWGhs?=
 =?utf-8?B?dVNXazgyTVZxVE0xQTMzMlhjRTEzTTlMRDBLVTI3d3hlallFNkYxbExER2RY?=
 =?utf-8?B?cG01dThtZ2NuaUxicDZGYVVqbjlCWUZpc1JEUVZ1Skd1blZNQkNyRGdiWnJm?=
 =?utf-8?B?TW5pZkZiWllNSm9SN3ZoWkFkSnc1c0VoUjZBWWd5d01XOTZleDlyRVFBZUJO?=
 =?utf-8?B?cTl2WUt1bm91SGFMYXFiQlRDTzdkSFhIMERLdmRkcmsrYmM4RTNrZnE1Nkln?=
 =?utf-8?B?ZUU2cVNXZ3lnSHVyODg5TkU3L0Y5TlNOZk5nL1Azd1ZrMFp6N3h3UCsydnNY?=
 =?utf-8?B?YVAvMTY3eW5Xb2FBc1FTbWJ0ZFZCVEplbEZGMUhJcDI5RlBUT2VsZXg5d0V3?=
 =?utf-8?B?ejVRUTZ5b3dJWnU1TmxnRi9kcTZnNmlWdW5FR0V2Uk1BOXk5dUR6SktJM3JX?=
 =?utf-8?B?NU9XZlBuaE00UnZzR2FvaHk3VTlnRDlXNDlOWkhHak1lRG5Wc25aaklTUHNZ?=
 =?utf-8?B?dW52bDVhTzB5eTNBSHM4MEowSFZYaFJyYyt6MjVDclprd2tzM1dnb1ZWakwv?=
 =?utf-8?B?YUpJQk5sQWdXTXYvMk5KRUkySmNHMVE4WFdmZXMwTHBtT3M4RGxZa3ZmS1I0?=
 =?utf-8?B?clNWQmhJeWI0S2V0elgwOU84RUIwZk5SWk84cXo0amFJbUxjZ0RYTnZsR3Jk?=
 =?utf-8?B?aVpseHlvLzAzc29Dd1RKMkpzVHM2bkxUaVJvaG4yK2tmNGRQU1Bab3NzcHdn?=
 =?utf-8?B?Sk1QOGd5VTV0U05PcFA3WUVwNmRFclZtZkNWY0ZROS9OYkNwNkxLSzhWMm9z?=
 =?utf-8?B?dUorMlR4RVZiM013YS9BREhocDVIWnRFWUxleXEveTdmOE1tckIrUittTFNs?=
 =?utf-8?B?ck5TWWpwK28vUVFLdFIzclB3eC9QTXVYMlk1YWxTcHVIQnJRb2VYclNFVjRl?=
 =?utf-8?B?elBnc3Nrc2tyQWdsNEZIQVd2VDllS2VqWmRSOUFseFhCZW1KSWhlM1lrVjkr?=
 =?utf-8?B?czd3N3dCRDJxTkI2QXZXRDBuaWttZUsvcVpoL05aQ0RNL2dhWGh1c0I5QUNT?=
 =?utf-8?B?eXVQayt6VTFlUkxDdm9KN1daV0VLMlZJVVJybFVoQTVNbkdJdjFmTmwyd25T?=
 =?utf-8?B?Q202K1l3Z0hEcE9XbXdSQUZiOEgwcUJDNHBQNGtpOTdWNVZOMERuWFp5OE5J?=
 =?utf-8?B?S1hnSFZCWVF5Q1pReUwwaE1PNFVPTElSaCt6V3I2MkFybnRBRGtoUVk4WFU1?=
 =?utf-8?B?NWJFYXllbFpoM25pdk5WT2QvcnU5Z2drOStwV0NWU1pRaEk4a3J3eUtwb2ty?=
 =?utf-8?B?S2w4Y3RvU3dPaE0zak1lMmlxaVF0TVhpMGh5c1lJbXBPRUx1RlRXQ25IQmtl?=
 =?utf-8?B?UHl5N3RZYmF2ckZ0dlRQR0tGOW1RQXRUR2hrcjVqRjVqRWliQllsQ3hXQ2Y1?=
 =?utf-8?B?bFZMRTZCczlmd05vb1ZQUTBwYlBNbU9mL3dkV0ZSZ3g5V2hzSG5iMmd3S1Jm?=
 =?utf-8?Q?Q9gv3EO//EIUG+Zz5kJ88jLav?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58723c3-c573-4a96-acd3-08de335adef4
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:30:51.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVjVhDUBRAs6CZf25JZKsW3AmdDsQtM9L/KPlU95LtuXHnw1wv90PhUIpqY2NggM7XWb2D5ixL4Q9vwwSCInOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232

On 11/4/2025 4:12 PM, Bjorn Helgaas wrote:
> On Tue, Nov 04, 2025 at 03:54:21PM -0600, Bowman, Terry wrote:
>>
>>
>> On 11/4/2025 1:11 PM, Bjorn Helgaas wrote:
>>> On Tue, Nov 04, 2025 at 11:02:40AM -0600, Terry Bowman wrote:
>>>> This patchset updates CXL Protocol Error handling for CXL Ports and CXL
>>>> Endpoints (EP). Previous versions of this series can be found here:
>>>> https://lore.kernel.org/linux-cxl/20250925223440.3539069-1-terry.bowman@amd.com/
>>>> ...
>>>> Terry Bowman (24):
>>>>   CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
>>>>   PCI/CXL: Introduce pcie_is_cxl()
>>>>   cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
>>>>   cxl/pci: Remove unnecessary CXL RCH handling helper functions
>>>>   cxl: Move CXL driver's RCH error handling into core/ras_rch.c
>>>>   CXL/AER: Replace device_lock() in cxl_rch_handle_error_iter() with
>>>>     guard() lock
>>>>   CXL/AER: Move AER drivers RCH error handling into pcie/aer_cxl_rch.c
>>>>   PCI/AER: Report CXL or PCIe bus error type in trace logging
>>>>   cxl/pci: Update RAS handler interfaces to also support CXL Ports
>>>>   cxl/pci: Log message if RAS registers are unmapped
>>>>   cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
>>>>   cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
>>>>   cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
>>>>   CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
>>>>   CXL/AER: Introduce pcie/aer_cxl_vh.c in AER driver for forwarding CXL
>>>>     errors
>>>>   cxl: Introduce cxl_pci_drv_bound() to check for bound driver
>>>>   cxl: Change CXL handlers to use guard() instead of scoped_guard()
>>>>   cxl/pci: Introduce CXL protocol error handlers for Endpoints
>>>>   CXL/PCI: Introduce CXL Port protocol error handlers
>>>>   PCI/AER: Dequeue forwarded CXL error
>>>>   CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
>>>>   CXL/PCI: Introduce CXL uncorrectable protocol error recovery
>>>>   CXL/PCI: Enable CXL protocol errors during CXL Port probe
>>>>   CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
>>> Is the mix of "CXL/PCI" vs "cxl/pci" in the above telling me
>>> something, or should they all match?
>>>
>>> As a rule of thumb, I'm going to look at things that start with "PCI"
>>> and skip most of the rest on the assumption that the rest only have
>>> incidental effects on PCI.
>>
>> I think there was logic behind the (un)capitalized but I forget the
>> reasoning. It's  better to keep it simple. I'll change to use
>> PCI/CXL and AER/CXL.
> 
> I don't know what "AER/CXL" means.  I think "PCI" and "CXL" are the
> big chunks here and one of them should be first in the prefix.
> 
> I do think there's value in using "PCI/AER" for things specific to AER
> and "PCI/ERR" for more generic PCI error handling, and maybe "PCI/CXL"
> for significant CXL-related things in drivers/pci/.

I was informed any patch touching PCI files requires a PCI maintainer 
review or acknowledgment. I misunderstood how to communicate this.

In my workflow, I used uppercase tags like PCI or AER to indicate that 
a patch needed PCI review or ack. For example, when I wrote CXL/PCI, I 
intended to signal that the patch was primarily CXL-related but in a 
PCI context, and therefore might need PCI review.

To avoid confusion in the future, can you advise on the best way to 
indicate a patch needs your PCI review—even if the PCI changes are
minor and don’t warrant leading with the PCI label?

Also, can you review the following patches?
[RESEND v13 01/25] CXL-PCI-Move-CXL-DVSEC-definitions-into-uapi-lin
[RESEND v13 02/25] PCI-CXL-Introduce-pcie_is_cxl
[RESEND v13 07/25] CXL-AER-Replace-device_lock-in-cxl_rch_handle_er
[RESEND v13 08/25] CXL-AER-Move-AER-drivers-RCH-error-handling-into
[RESEND v13 16/25] CXL-AER-Introduce-pcie-aer_cxl_vh.c-in-AER-drive
[RESEND v13 20/25] CXL-PCI-Introduce-CXL-Port-protocol-error-handle
[RESEND v13 22/25] CXL-PCI-Export-and-rename-merge_result-to-pci_er
[RESEND v13 23/25] CXL-PCI-Introduce-CXL-uncorrectable-protocol-err
[RESEND v13 25/25] CXL-PCI-Disable-CXL-protocol-error-interrupts-du

-Terry


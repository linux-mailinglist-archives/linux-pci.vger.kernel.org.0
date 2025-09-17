Return-Path: <linux-pci+bounces-36358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E05B7F943
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 15:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2117C3AFE1E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 13:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4E532B48D;
	Wed, 17 Sep 2025 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uIXh0LD/"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012009.outbound.protection.outlook.com [40.107.200.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B555A32341E;
	Wed, 17 Sep 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116691; cv=fail; b=OC5uASwp/XFpCniF7Wt+cXIA1TK0QpfitmpARXR217mBz2T50PwuuZSdFLrmwGoZvyEsy32G+r7fF8TVJ9xCi2NW+07K1gDux6OAtV0j8YY/PBry8KKyTkfyQ0iN9WLUAhOEiLkd3SaOosi2ec5K4aBju212fjPGdfRSbATxt8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116691; c=relaxed/simple;
	bh=J95mRQ8mVu1tBspg4eTMCXNCN2KRqY4/fHYmWTdyMHM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I9A1RuvQOBdsUCdSUWcOldRdP6Wy7lYTshSEvrKbUzPO4vpM90m9iDEV/TlUwcO2zA7WXLvJHlfX9FXJ7q1Elk/zTGX3ZZv2Lp58WsfRMP+5rthGjYob0EfPz6U1FB7kefHCZ5wxLUXTw6S10zG/0Tj/HVUjbUv97Lu5Vjv32d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uIXh0LD/; arc=fail smtp.client-ip=40.107.200.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBxm3u4Z7z8/QpnG0OEVjzx5MqMptU/0SiKMfpgf3y+cGIYvUjjCeUikgVGQZHxmqjEfoAyOOgHZozgVcmDvz4/BAASAn/0CBrt+SdXWX4OoGZqCXgsEms68QI2GXJsmnYyBvTYgTDG+F5QvUg/aYFRgjdNVgjXRBDgkwRncfS+mHvWx+yv5gOLDwflTjtDT3jcxfOixei6n63SYJEjrCo+0Yfff/Z9eR7kh/k8dQX2R6yYAHU7/B+YBdsm8/crbsXrEwSOU9t2E8Xrq5xn5oX5izmw+c6n07Qzjm7J+pR+7ke1eZXJ3pIzL+a4Z2U4zIwNqe1vWU/nBz3vLDuJhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJWM48Jci6haAYNKkqGrnLER2/WAq8BvZ4on+JydY8k=;
 b=eJ7C0mP3+TtUgY4vaHuHanbZaNj8C8/bO4Kfa8XDrNSp3GFqwGcBuifBZ1KqOdX4zIjk9/ZDT+eRp1fGtYSJnfMQaXjzVMRXvf2Fo4n26VDYx3IqQ6aD4Wf9FCa9iKKWq61mkFjqQ+gme+htylJqsWGtlD4pJLFKqYBwvVxdjRKE4H/7NCR51OrdymNhvDbPkjfu8AhEBmEAldLFPecd5StB+qcPj35JqdvUu8HEUuTPl5TO36L9m6x6TS+XNpsVbnvkrqFDOUyc6jTwhGxZ7K/qLEbIa4QW56mXPGfyj9up2DT9vlhO+3qQwFLMmo65k8QSi/hF/grPp7MPWhOLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJWM48Jci6haAYNKkqGrnLER2/WAq8BvZ4on+JydY8k=;
 b=uIXh0LD/vgab0RmrlmM4SSPSYjdAOWzDdd3wtA56+FQourHY8aBAmm1RyW95zUqrfMpd7Q+S6om4XH6vq2xMNRL9baeOmH8hPzgwhsJ0LAGrP+ocafH9TgoRHW6cnU37VBP5jo9n9bqfZymaFylQ0/UGGj7Msd6VZr6blGb3OBTtnZwmwB8R3w1h2p7oq++CX18SBtwPHn0dnxTqz1w1icQeZyyjb+imKu2bHwV1kDKHsVB6ztbJceG7y69sBAPOl+kjbqJG7d9aQEFUzJNsdo6opcjAsfko1hYd1L3D+gGPNtODQZQM2+GT59rQfbXQo/cHRnKUZJriUtDylEaOkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 13:44:44 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 13:44:43 +0000
Message-ID: <a743fd19-d54b-450f-a4db-8efc21acf22a@nvidia.com>
Date: Wed, 17 Sep 2025 14:44:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 1/2] PCI: tegra: Simplify clock handling by using
 clk_bulk*() functions
To: Anand Moon <linux.amoon@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>,
 "open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250831190055.7952-1-linux.amoon@gmail.com>
 <20250831190055.7952-2-linux.amoon@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250831190055.7952-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0241.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::15) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd11f1a-7410-4e75-6f9f-08ddf5f05bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFJFay8ya3pMTElxK1JnSHFxbUZkK3B3cHdvVFNPSjR2YVNxYXFOc2d1bmJl?=
 =?utf-8?B?dUw1UGE5UVRnc1BLQ2NlVDhMWDlSRkMvVVRiS1Y0WlpNbEpTaW1kVW8yUU9G?=
 =?utf-8?B?NHpaQStibmthaVZRN2haMmJCT3U0MUJwTnB3cGpxTDhNWU1jSmJoVlN0TlIy?=
 =?utf-8?B?SUltdmdIbXNBZXhKaS8vSGNlUk1VWk5XcDgxNDRqU3hXOGsvdDZPSHMwdjE1?=
 =?utf-8?B?alRITDFLdFh1cXdvZWFFb1dKd0l2ZmZCTWlUd2RHN3c1dFIwUUU3NTFMcXF1?=
 =?utf-8?B?dkNQTVZhd1ZVZjVJNTM3WDhydy9Hb0tXQlBrdzUxUkFTUU40YVFnZ0piSVIz?=
 =?utf-8?B?OXplUzhmdkFtLzdYTStxMnRkcGo4SWt0RG1sOTd3N2pkL2xESnZQZE5DU2JD?=
 =?utf-8?B?NXlwckxvYUNVZURZQlI5Uy9EelJ2UlFZeFp4ZDRlZTFrY3FZZmRTeE1kZU52?=
 =?utf-8?B?cDhhWUZsUTd3RzNiRWwzUXFLOWdPWGhleTVoUnE3a3JSVkQwbEdrK2NldjBV?=
 =?utf-8?B?bEQ2cWI0UzdMWE0wUVJZdVdYVE43ZkwxR2VzT3BsdUcyZHhnWkxVWVRTTkN1?=
 =?utf-8?B?STJ5bVBoeittWUZpZEYrRm9KSlBwQ3phRlZrOUNvK00xSTRnTnNvSm5MZUFH?=
 =?utf-8?B?QWE1OTZIUCs3N0VRUlYzMnE5Wk5xeS9kUUhzVHVEdzZIRjVnV3VCa2gvUTJI?=
 =?utf-8?B?a3FjcDlueVJjZ1N4Smp3Ly9XUGVpTlpZY3lKVTlpdzN5TDAwYTJIQTJaL2hF?=
 =?utf-8?B?OSs4cGFiOGhTZ2x4WVhxdmwrRHNwRWF6dVlHQ3U2ZVZqUFNnWDhUcjJmZlVr?=
 =?utf-8?B?dFpTa3gxaEdFNXhnT2xJWDZmb0owKzVNdHhvOVJZVkgxV2REN2lXMnFLcVYy?=
 =?utf-8?B?SEk1Q0hnOGU1Wis2aHFvQWdwaENNZ3lXdHRqcEhOaU9iRCtPWHZHUTQ1WDUy?=
 =?utf-8?B?NDFxT2ZPUytsOXN1OTRFNi84bHM2aGZPTldJemVJajFtUUZhVkZDb2FsM1hG?=
 =?utf-8?B?V2w3bkZocXo1cWs0cGFRdldGYVRqajFFOEdsZlBONW9jeUNoYzJ3Q29VbWFy?=
 =?utf-8?B?ZlRzblcxcGY5cmdCLzJVQzFvR3NNd000dEtYZmMwZjlDRHYrRW1WWFZ5anlB?=
 =?utf-8?B?Y1pUOXBxeCswZ0diWUthQlBwNDFtTmtsZG41OCsvcXora0Q3VHFjN3AxbWRH?=
 =?utf-8?B?anBxNExpdUJ4SVMvcWEyaTNPb3FxcmVEaGR5UVM5TmNWdDBLcU9RcFAzS0Fp?=
 =?utf-8?B?NXYrSG94QWJGczNKL2xwUmZJcEd6YXR5UDBSZzJOeE9oVFdwblpBZlhrZThq?=
 =?utf-8?B?SGVCSEk1MWU1aUkwa0VzTlprM0YxUzM4Y2hMOFNLK1VyQmJoRE9XQUFNbWJX?=
 =?utf-8?B?TnRsZnZrRHB0elJQbWV4Zmd3eW5VVnV4QUZRSzFUbUVGYkRkY2FNemVrNlRw?=
 =?utf-8?B?NWZGUmNaanZpM3B3WkRQQlJ2N2FwVXlZc2NWZ2RDNmFwdyt2ZGJQZDYwNFJi?=
 =?utf-8?B?UHYyK2hkSjlXS1I0YmU5bjk1cFVpWDBxR2RjOXAxQXlwcUh3RmtYa2xsZWJ3?=
 =?utf-8?B?M2NCUGNrQnd4OTdzeHJrZktNL1NreVJ3NXVwc1UvWGR4SW5yTWpVS3hKa0hl?=
 =?utf-8?B?Q2lHWTNUODNnUkE1TEovSEk4QlZ2YnlNU3l0bWVxNmgyZkdJRXA3YWZJTVNN?=
 =?utf-8?B?TFh5UC96dzB2Z080U1JvZnVFK3RrV0Zlc1BmV2RtSmVXWFUvZzFOd0NsY2Rh?=
 =?utf-8?B?S3Y4SmxQUEhYRnlkcmxTZ0hOWldZcW53cm5VNGtoZTA5OGlXTFN5YXFWcWc2?=
 =?utf-8?B?bkJBM3hzUXBBdHpLNnFWa1cwS2tGTWxvZmt0M2NTdU9MWnBFRzVnb0RSVDBL?=
 =?utf-8?B?ZHlvVG54Z1c0RW5PQzA3R3pYY0RpVmxPdnV1VUQ2UW1uR1Z1Qy9FQnI1Ui8v?=
 =?utf-8?B?OExtSkp2R05zbURvMmdFaUJrUFBRVThmN1c2enZYeUFvUVZvZWQ4UU1DUis1?=
 =?utf-8?B?ZjkvVVVtVUJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVVOVy9WVTJtb2VWU0RtM3pOZHZjcEJhSUo2ZmVDN2pick9QUlRlQlRjSERY?=
 =?utf-8?B?Vi9xV01aS2pwVUcwUmgzY0VuR2tyU0xNbkMwcnZ4MWlBQUxyNjhpaXlXOXlu?=
 =?utf-8?B?MkZTZkhXQzc2VFM5M2xIYUFBTlI1cllIM3Zwd3lDWXF5c1ZYc1NnbzBiK3Ro?=
 =?utf-8?B?WXkzZ0NWamRiNjVRMVl4TnVtZnl3akZJaGdXZ1o3WmZld0ErM3FHYkhQUmth?=
 =?utf-8?B?MzJOdWxNaTQwTkV0a2Z3TTdNNmxUVXA3ODBNM0U4RXB4aENRbXdDR3NVTExl?=
 =?utf-8?B?YzV2UmIvekJaei9xVm1JL2syaHNRSHd4RXlwVnB0UUdlTDA0S0tiYkVNNHh4?=
 =?utf-8?B?VVdXWk5mODcrWldwb0dOTkM4eTBrbEZkb016dm1LMm9Va2hSenpLT0cySXIv?=
 =?utf-8?B?cGl3QjBML3ExeW9wM3ZLekhCbW1PUFB0cm1TQ01va2thZnZJbGh1QW5NWUl5?=
 =?utf-8?B?ekJzWU5GQTVIdk1WSVZVZmtSYXl3aGw0aGtZWjYyQ1N3dGlna1JwVXdObWoy?=
 =?utf-8?B?Q2VUYmx2aE5vRGowUkJrckRUT2J2dzJXMVdmakhZSkxrWllRT0ZTcFowK3dl?=
 =?utf-8?B?TzhnQ1hBZGJKeTlSLzMyajAyckJuWGpJclk3MUZ1RzlsMVZsZ0VwSkI0VzdT?=
 =?utf-8?B?K01qNnFvb0IzTGY0MExnQ1BOdHF1K1VHTmhVRWM4Mkh5VVBVNFJQZnBOL3NY?=
 =?utf-8?B?aEoxMWUybGsrTzRHNi8zK0h5T0FTeWFwR1pYNWRqb25xaEJoWFlCMTkvVTFo?=
 =?utf-8?B?dlYxV05pNzFMMWpCZnkxMkswZWlsSHlUM0J2RmtpZ3pRK2R0Y01NMjU3cWhn?=
 =?utf-8?B?M1Z3SCtvZjJ4RGcvNzVCNHhSQlNVa1NXY2MzaTF3c2tta2JqVmxhYzdKeUw0?=
 =?utf-8?B?TGE2WDhRZG5mQTVObzU3MWYrQVNjWStXM29pazR5WUpManBJd2ZJa0UxTklt?=
 =?utf-8?B?cnFyYzZRTkdUemptM3pzSnNoRUpzRjhmZHlpUGZiTGFhVzJTS1lzZDdqQ0Mw?=
 =?utf-8?B?cXg1S1BLWG9ZQ0NIZFIwVkloVWtZWHlOalI1VWJWRW9LbS8reVJKNDN6bzJv?=
 =?utf-8?B?bFRUUyt3Tm1oQ3ZlN00yM1VldUU4eUxTVk5HaVd0YW1QL01xazArMTVlSER3?=
 =?utf-8?B?MUc2QzdEeTBjeXEzOXRBSGNpUWpCaVVPdXQvMUF0VHNGeFEwM1pSeU5hdXA5?=
 =?utf-8?B?L1ZyWjRCamU3ZnlBcWlLQTE4MlBQK1JQa3lwcnRBUTArMTFnV0I5ZTlYSCtV?=
 =?utf-8?B?L3ZBY3ZjRWVlWWQrYmRIeXAyYU1DZ2xSSkI0YXEvSk9iZDlvd2E1NUVDc1NH?=
 =?utf-8?B?VEhkbEpvVGhVT0NtWHQ1MlJwOVNIN2NQYVg5QWZVZDQrY2lGOXkzZlhGZDN6?=
 =?utf-8?B?VGJzRUdLMHBFK3czR3BrT3dRbklkVFlmd0tQZ08rY1pMNG9hZkQxak56aXhx?=
 =?utf-8?B?RThLeFpsUHZVMjhyMlBKL1FsM00wRjRGZWRvSitjeXRVbDFEbUFyZUJlcmlw?=
 =?utf-8?B?WmtLMm5yYUZYd1Y2Wk0zSDAvYnlvOVhlR0dDSDE4a2lwM04zR1ZsaHQrTFNW?=
 =?utf-8?B?TzYrRHRkendUV2RUN3pNNUs5a2VYZjRzRmE0SVR3SGhrSWVHOUVwejg5Wngr?=
 =?utf-8?B?TXpkeWxEZ1luOHdXVThtWGF0RjkwMDlvbnkvMXJLRWVXWWUxQW92ODkyNW0v?=
 =?utf-8?B?Mk5aVVpVS2dodGlvWllMY0IvQUptRERDYzJqK0hRM25aeVlUZTZwTFdEM0l5?=
 =?utf-8?B?c0RyMSt3VkRTR1hseGFhTU9UQnRzM1NYRWdPOGYyNmFkenVLci9qaWhxQUw3?=
 =?utf-8?B?eU9NaE5vNkdlR28wZmtZYW5PZm4yVjdmVFo4ZmF0a3Z6bXRVOEoxWFc0bHZD?=
 =?utf-8?B?K2ZGUlZ0d0RrQWVhR2NTOU15UmFiVUw4NENObUVSOUt1S21XdDBaVHFaMXdo?=
 =?utf-8?B?QWg0YjR6cnFTdzFaRms4K1FMSG4xOFBwWVZBUzVKdTdIK0hKR2FnY3JGWG0z?=
 =?utf-8?B?Ri9MVlBMNytlYUVEMmRvZTNVRUFEVUNXWFRFUTJ6VTk2ZDlDcnloaWxlamxm?=
 =?utf-8?B?S0t1NStoWEp3L3ovUE01akZoT1JRam92YVd4aEJ3aGdaMlNob0o0a0pRNFJp?=
 =?utf-8?B?aSsvcXpWSzc5dFU1UGRHaUNWNW1iaFhFUjR1Q2lSTGtIbHh3RWJlNElKSXRL?=
 =?utf-8?Q?PFhof2+3CAgxMdFPBFN1xJAIw8NbkgEfwi9twfpDonAd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd11f1a-7410-4e75-6f9f-08ddf5f05bbc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:44:43.8838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mruKhmUh4XjhaI1Z4BUkKPkbn4nhTN+OgOPisTyWRVcPizmFDkEraPIanlcK2too2nJzWkaUmGbF9+/BzBCSpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925


On 31/08/2025 20:00, Anand Moon wrote:
> Currently, the driver acquires clocks and prepare/enable/disable/unprepare
> the clocks individually thereby making the driver complex to read.
> 
> The driver can be simplified by using the clk_bulk*() APIs.
> 
> Use:
>    - devm_clk_bulk_get_all() API to acquire all the clocks
>    - clk_bulk_prepare_enable() to prepare/enable clocks
>    - clk_bulk_disable_unprepare() APIs to disable/unprepare them in bulk
> 
> As part of this cleanup, the legacy has_cml_clk flag and explicit handling
> of individual clocks (pex, afi, pll_e, cml) are removed. Clock sequencing
> is now implicitly determined by the order defined in the device tree,
> eliminating hardcoded logic and improving maintainability.

What platforms have you tested this change on?

Thanks
Jon

-- 
nvpublic



Return-Path: <linux-pci+bounces-17434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9B49DB650
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2024 12:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E22C280EDD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2024 11:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2AE192D82;
	Thu, 28 Nov 2024 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TSZillQF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC4313A3F3;
	Thu, 28 Nov 2024 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792303; cv=fail; b=UfWSSHkLIxOdIfgbIqpE9XPIlWcdPKsC2Y9/pKwaunxwu6aDlNvKaQjB2tUB213zLn4v8h6SJurJMdEsXhxbcZilFOfIG2ziDbrwVKHmK/T1+JPaQhxRKRzSrb3swEngJNDxF89TFFCRPeHq3sJp7LANFeSvJoNEJvXhNujUbFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792303; c=relaxed/simple;
	bh=zUTFTFx7o7LcSjp4xOqiE8Lk+UBbMm54fOO/EO57e30=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hrjGYhJ5R4PbDXDOArhTUAkXqY+4bCtCfgL8Jkm2142oAVjH/LjBJ5q8N83LQtWzdATLOhaTR1/iXWierRUvg4eeF4oIgtj6bZQFztq0APdeK14F1XTL96UdCfXLoDUMg40zD17qZVU/Vj3x4F9j/P6d4iBDUv9SIKxs7WkwyjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TSZillQF; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlVP06tirFMmVwd6QIm65kpyKE1dqZ5OKj/NNAYq0nUFs2Mz6Q3vuHB1wv3qmsyTC3uj7aV/vZliWjvfbIkMc02+2gkbo/Zn2OnyP1ytMJLOH7ix0ZPH2juMbrM0xVhcClDJFL3rTSb0qGLGRSRtgXG1wiUZFJZa14d78vsqd8clnMLWeTGCShSZx6hIflWc9YrMvOvAgbO4jFAa77Icr+p1jDNSxW8qUTDBjZ+MY0yb9tKxFrrXNvKIrWlulv78rVr1GK/X5P4RwgAR+Rv+MIXJSe/uTQ8mmczxMXAPhfacI8YSSj1dDJKRkrBDPWv3KogYQNHiKtzzcqzXTBks2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1UPBY66Z9ruYqMDMyZqSH2PELo1R9Cj0TvycAh8K10=;
 b=GX/U0Pyv8DpV+3lATNzK2p/gtrjTpZSXFLBBdfYtDp+5Rutj8mCs2DMuJU8AAfnoVMN3P9tNoBBOKS6xvLLrrfdRuSYL/3GRBdD6EpZvQDIoOdEDl3NfI6ffaVhYwS37envkJnLAgFMia82hiuj5cvWD76IwKjdtJepa2alPneF2HDOt9+DJ63Ga5R2JaZYuUnqG9bu+gnwDlzT6ZlUclErFNmP/WXgfGpZ7MZCc9m5mOQ/UYwuarrCTORC1MZ3tGSDlaxFnJakgpD8NzGaYWuc93AL/zSBM493ADxi+GzHLOjESfqjuDMkU8I1K4b2wGzHuypbAhwvBRzA6sdJuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1UPBY66Z9ruYqMDMyZqSH2PELo1R9Cj0TvycAh8K10=;
 b=TSZillQFimPZDES05qwmpYICb/r4JGk4Uc/ooZr6YgQdIatkvFurueHN0NqEH55TyWqqaFRhqbU0sNe2J3KH0ssKfU0tLyXHmENiLz0xkCdJk6GjqNgWJKlQYNtxbuMi6rvA4Jo3OcMum+0aFUHMCZi+haPqVsGceDoKHQYswmfQR9sd8VJNip3yl+/8wmxaNIphGKM2vzNJaihc0Y93rN+KQAFgulP8BmR+k+KWbGGtICxxgrXyRA0hmTYJgjMZf58PCjo0/cWzmyuL++Je2qQbYQb/KNldaTGN6DgvJZopsqmbYbQib1kc9w1oHiG63OkM5XDb63rij4pLcX3jdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.14; Thu, 28 Nov 2024 11:11:38 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%6]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 11:11:37 +0000
Message-ID: <4a88159f-b0f7-43ae-b379-d64c25f417bb@nvidia.com>
Date: Thu, 28 Nov 2024 19:11:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Use downstream bridges for distributing resources
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Carol Soto <csoto@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Chris Chiu <chris.chiu@canonical.com>, "Matthew R . Ochs"
 <mochs@nvidia.com>, Koba Ko <kobak@nvidia.com>
References: <20241128084039.54972-1-kaihengf@nvidia.com>
 <20241128094529.GT4065732@black.fi.intel.com>
Content-Language: en-US
From: Kai-Heng Feng <kaihengf@nvidia.com>
In-Reply-To: <20241128094529.GT4065732@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f6f3a0-62c7-4198-d4af-08dd0f9d6d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0ROZWJ3bkdISTdXbUlGR3FEMUttd0d3cWNRNUc2d0hEUm1xdTRpYWtXWGRX?=
 =?utf-8?B?d2pWY0J3T1JHNVFzWDFOOVIzT3U0UFVIdU1IWko2VFJ2c290MDVMdWZuNmor?=
 =?utf-8?B?UmNPWVd5c0t2aUk0eFdUYnhJSUR1VVppVFQwRDhibWYxYVFaTFJ5ekxOalcx?=
 =?utf-8?B?OG1xa3N5VWVFaHpYZnZyMHJzWVdDZkN2V1paTk93UmpkTkt5ekN4ZmhkRjgy?=
 =?utf-8?B?dWJxeEVhcVA0cEZha3luSkJBSlE4SkdIVkhtU3JPRVQ0blhvSDFROStxVm9P?=
 =?utf-8?B?dkhDdVB6S2QvOC9ObmlnTTFJR2NDNFNQN09oTmM4RFNiTUk4ZWllc0p0TTZ1?=
 =?utf-8?B?a1NtdVFDNHVuOEk2RnFlbVpaWXpNclRHUHpDcDdIdjJlT25FempDRU5PbVhk?=
 =?utf-8?B?dGx6Z1JrRFpjNzJFcjI5bkZheG91OFVRbDMxb2h5QlNYcko2bTZjbzFkRG5X?=
 =?utf-8?B?bFhOakZJUTY4dktOWjBudFZUTzViRFlEQXhjUmlrTG1mbWVuMmZpeU9MdjBU?=
 =?utf-8?B?Y0hKSVJKSVc2MUdKTFkyYnV0bHB3YmxHN0poaVFSSmZoanE4VUhwZnhyL1Vx?=
 =?utf-8?B?SVFvL0ZhcCtPQnJCSnRMeWpuRFB6UVEyalRMUTlxcUN1Ujg4MW5tWWFDcDV4?=
 =?utf-8?B?R0p6NnZmVU5wMldHNU5nd2NQbnV5K3lVNEVnaGVLSURCSGkyaE5RMGpKaWhw?=
 =?utf-8?B?ZnAyNHdsbGM5VVZkTERLVHBEQXRvZ2IwZTJCc3gwUG0rc2xPUFBXVmtkeDhp?=
 =?utf-8?B?Rk85bDRIUkpDY3VUL2JBOWhTb285MTUvdzRoYXdXU2IrWnh6QWxyd1VlVGl3?=
 =?utf-8?B?cE5OR2dTZmN5OG5LSm5DdGZjek5LRnNucW5uL2hZVmFQRXdXQVAxSlQwUXZT?=
 =?utf-8?B?ZUJVN2l0bFRoT3BnSldkVXVkMFgzU1cwOUpVeXZaYmxlaE04eHRCaThEOG1N?=
 =?utf-8?B?VlNMalFhaFVqeWlSUGlzMkF5UmRKOE1NdysrbkRqUjZ4Mk9yejFvYmd0LzMz?=
 =?utf-8?B?RWFhVlJGandZTElmMTFid3k3QkdBVi9XeXRpL1hjUVdSYk9UOTRTQktiWStU?=
 =?utf-8?B?ZElySGh4NEc5clZ0MW1GWVA1NGV1NHdVZ1dnblFjdTRTaUQxcGRiZkFibkQx?=
 =?utf-8?B?VXdGTmwyVkxUR3QzM2RpOHduVTM2S1Z6L1JRUGh4MEwrVk02UStFUS9BYS94?=
 =?utf-8?B?cW1DUy9FdFZPamlrV25EQmlFOUMzYmpzc1NaTnhTUGpzZE1FT2REWmhpQm8w?=
 =?utf-8?B?R2w4aTZ6dWJDTTNQWjFZUS96VnFGZ3VQcWdmQlNaWDNZU0Q2TWQ0VlB4dS8y?=
 =?utf-8?B?RllRQU5adzNGRE5KQ0NId1Z3Z0M2eWtFUjlJWkVIOGllVzdjQi9EdklVT3dM?=
 =?utf-8?B?cEdHN1U1ZVIzb1F1TU5QczhEZTVMamRTZ0QvanFCaEtja2xOVUk3RnRROTlC?=
 =?utf-8?B?VUhZandpUmJKbGhNcjVUU3BwUjFjR29ZWFlIdExnQlVBQytjVkNUamV2d0dP?=
 =?utf-8?B?UnJzc09XRzFhcGQ5cnBiUmUrZ2Z1cVRyZDdBSEEvcU1ZYk5KNW1GSzVlV1Ax?=
 =?utf-8?B?RGxIbG54amtNaU1oZVYwUXg3VjF2UTA4TUdWb3RHNWNGNGp0S1dMellybStG?=
 =?utf-8?B?ekh2S3djMGRlZC9VUmVsbEY3Ky9VajFWaWpKMjFsVnBjeEVXVk5sRFpWVGt4?=
 =?utf-8?B?b1hyMWVsTzRPUGNyS0dQWTAvSVhVT3ZBQ1dvTFNYLzMxM0ZCNGtWdVBySlpV?=
 =?utf-8?B?dTA5Z3FQQkRSZlBnbWdpL1owL3VUbzdXVjJqbFNMWmZtZTkvTkd4ZHRDR2V3?=
 =?utf-8?Q?CvnuGc5T3SwBk+Y4A7AB3Qxfm2433Zqab5QHQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0tEa2NubDFwZWdIUWhFNjhzT0hSTHVYTmF0NmhJSjhGVjY3QXNZQlg4Qjk4?=
 =?utf-8?B?U1phTHhzNTV3TUVhMEFkSmN0endmTmF3T0owQ0Y0cDlEM2dodUpmQkdOeGJF?=
 =?utf-8?B?b2h0SXZRVCtvL1cyKzEvQWwwZmRuRlpLclJlK3l1QktYZ2EwQzFZcVEyeXU3?=
 =?utf-8?B?akpOYUgzeDJRRDlZQm1tanpVUTIxZGJkTWt4aGZ3dk43djB2dE5SeFNPMXNG?=
 =?utf-8?B?N1lVVHRENTc4MWEwMk0xR1E2SHgvRnBxemViQmxLVmhwUnJhRnZQeUhQbDla?=
 =?utf-8?B?eXZ5T3pMM1NETTBsajRaYTRvWWkrTU1aMGNiczNKZTc1eGZIZG5NbjVMR2o3?=
 =?utf-8?B?bExVa25zNFREdnhKUGwvZEIydmo0di9wc3F5d2hscjgrOHR6N2hUZkJOci9E?=
 =?utf-8?B?T0hENm5BNFREQnJLcTRFaUs1WjJ0Z1FQNUNadUxjL3c1VkZHSElRQUt3eXpY?=
 =?utf-8?B?VjVXT2lsbUxtNHBvbmg2ZldUZVhWc09TZDFRMWJIMnRQU1k0QUlId3FKREV3?=
 =?utf-8?B?UXFUaWt2QlFadlVnNk1MOFlRRkE3dHVzSnZSNmIzVjAxc2RpU0xtbklDYjBo?=
 =?utf-8?B?ZEVWS1l1d2txb0FVaXV5SHdTMFlBZzlCU3c0cjZ4c2dSMEhiRHZsaEhwdHNZ?=
 =?utf-8?B?L2cxTFZ3N20rVDJjMlZTS3dEZDdNUjI1MHVDUExpUG45V2c5MCtxN3VqVXY2?=
 =?utf-8?B?MzlpVUFvRnNtQ1RmNElMMTlUYXlFRWhwWWk1Q1VYSVpPOUFGUEpQdCt0Q2xw?=
 =?utf-8?B?VDY5RHIzbFh3ZmltSXQveEdyTDNaVE5HcXIzS3NjM094VGpvZ0hSb09oQnhW?=
 =?utf-8?B?bU5ZY0UyQ09NeHozMVlXMExvdURpTmNLMDk5Y1JoN3dvYVBlL2piZjhVcmtv?=
 =?utf-8?B?bEVvWmcvM2FRMWp3VUx2ZTF1N2hhTnlER21YZ0xETy82aVJkbFl5TGVtMEdD?=
 =?utf-8?B?empoYnRNNXZwVDgxOEgxZVVvbHBCcml5a2xZTFltRXljRkEvS3hLb0Eydm83?=
 =?utf-8?B?bEh6REdOazFvVGJDQ0pTNzJNajdVUjBoZERKVE9BOEV1cE9YQWFKaHFzenVZ?=
 =?utf-8?B?eXRKZ3h1dUJ2dWZSNkgrdkp6MHBLd09HbTlrN0FLbjI5VUdVeTROU0xKME1V?=
 =?utf-8?B?S0FvMlNtWXVFb1VuVmRsSGlrWEsrMDdlMnAvb0RnMXRZV0NPMjhrWTlxc0l2?=
 =?utf-8?B?UG9zYUFubDRBcU4wbFZYTXU1RVoxMkE2VmZDRmVxK3EvT0xqNlU1Z3B4VDY4?=
 =?utf-8?B?MU1nK0ZlU1VUa1NCeUxLZzRIeTJBdzdhQUFTYllMYmh6RVI5ZTliTGtRcEs5?=
 =?utf-8?B?VDBBb1ZoK2pQR1FiTW56MktXaWJuUVhnayt3cUduWUJHM09hTTMyVjBVVVY5?=
 =?utf-8?B?THU1TFpMaUFmRTM4NFpWRDExb1Q1QkxDVHIzMjhteStjSUZjN2VnR0J3aWFV?=
 =?utf-8?B?Wnp1dnJXM0FLQjJVb0thUzFoS0h5OHo2Q251a25DeWVVeUt0MnljRFR1RURC?=
 =?utf-8?B?NzRGTDJiRWNlcXJIWEtoM3o1RGNFL3dUNzZnbFd1czN0NXU1bkh6WEhMNUJD?=
 =?utf-8?B?dDZFcmtwRUgzdGNlSk0vUm9menpKdnl4SmcwV2J5S3l1NzdCWmhaYU1NdTFj?=
 =?utf-8?B?dWtKSE82Y2Q5TXVMNFZ4RUJlY1pJb3dEZUNxWHQrR2RITkRqN1FXTG5rQkxS?=
 =?utf-8?B?bWg4S0JZQ2JFQ3hJeFk3TGdNa3plblVuS3ozeEVJTGJacTA4SnBFcWdJMEQz?=
 =?utf-8?B?M0c1OGVtRGw3bzBPL2JWYzVxeit2ZDczemlTYTgzQWN1RzdKL3I0eEFJZk8x?=
 =?utf-8?B?VzF6L0dvVHhJeGYzMFkyVFJCMm5HZWwwalEzY20rMDlFeFdXVC9WV0sycm5n?=
 =?utf-8?B?dy9WV3doRVYrcDdTaXg0SUdFY3lCMUR0SGdNa0ROUkcrSUVJbG9nbWpmMS9K?=
 =?utf-8?B?THFBeE5yUE5uNVBnV2JWTEtoMUltV0k4NThDbmVZTnY2TnV4MlBnOVVWd3dG?=
 =?utf-8?B?Lytsd0QxL0NVWTNGbnN5MG1hYkxSdGtuVnNuVzBNRnNOdENDOVFZNVBGcDIz?=
 =?utf-8?B?K29qZ0lzNXJYeHFUR1VmUVNoRncrbkIvVDJTRHdaS05RenpCMk9QNHdRSEVK?=
 =?utf-8?Q?M6DbdYkJkpMZFS+CS9cvRjJ3j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f6f3a0-62c7-4198-d4af-08dd0f9d6d33
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 11:11:37.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oby30vIGdZFSeZundo7edJiABcd/2fC1B8PKfUebkNx8HjVEeJce4uui8lyJcpSNbo3yhgeP/+Q3KNxPYirasA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372



On 2024/11/28 5:45 PM, Mika Westerberg wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Nov 28, 2024 at 04:40:39PM +0800, Kai-Heng Feng wrote:
>> Commit 7180c1d08639 ("PCI: Distribute available resources for root
>> buses, too") breaks BAR assignment on some devcies:
>> [   10.021193] pci 0006:03:00.0: BAR 0 [mem 0x6300c0000000-0x6300c1ffffff 64bit pref]: assigned
>> [   10.029880] pci 0006:03:00.1: BAR 0 [mem 0x6300c2000000-0x6300c3ffffff 64bit pref]: assigned
>> [   10.038561] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: can't assign; no space
>> [   10.047191] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: failed to assign
>> [   10.055285] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: can't assign; no space
>> [   10.064180] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: failed to assign
>> [   10.072543] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: can't assign; no space
>> [   10.081437] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: failed to assign
>>
>> The apertures of domain 0006 before the commit:
>> 6300c0000000-63ffffffffff : PCI Bus 0006:00
>>    6300c0000000-6300c9ffffff : PCI Bus 0006:01
>>      6300c0000000-6300c9ffffff : PCI Bus 0006:02
>>        6300c0000000-6300c8ffffff : PCI Bus 0006:03
>>          6300c0000000-6300c1ffffff : 0006:03:00.0
>>            6300c0000000-6300c1ffffff : mlx5_core
>>          6300c2000000-6300c3ffffff : 0006:03:00.1
>>            6300c2000000-6300c3ffffff : mlx5_core
>>          6300c4000000-6300c47fffff : 0006:03:00.2
>>          6300c4800000-6300c67fffff : 0006:03:00.0
>>          6300c6800000-6300c87fffff : 0006:03:00.1
>>        6300c9000000-6300c9bfffff : PCI Bus 0006:04
>>          6300c9000000-6300c9bfffff : PCI Bus 0006:05
>>            6300c9000000-6300c91fffff : PCI Bus 0006:06
>>            6300c9200000-6300c93fffff : PCI Bus 0006:07
>>            6300c9400000-6300c95fffff : PCI Bus 0006:08
>>            6300c9600000-6300c97fffff : PCI Bus 0006:09
>>
>> After the commit:
>> 6300c0000000-63ffffffffff : PCI Bus 0006:00
>>    6300c0000000-6300c9ffffff : PCI Bus 0006:01
>>      6300c0000000-6300c9ffffff : PCI Bus 0006:02
>>        6300c0000000-6300c43fffff : PCI Bus 0006:03
>>          6300c0000000-6300c1ffffff : 0006:03:00.0
>>            6300c0000000-6300c1ffffff : mlx5_core
>>          6300c2000000-6300c3ffffff : 0006:03:00.1
>>            6300c2000000-6300c3ffffff : mlx5_core
>>        6300c4400000-6300c4dfffff : PCI Bus 0006:04
>>          6300c4400000-6300c4dfffff : PCI Bus 0006:05
>>            6300c4400000-6300c45fffff : PCI Bus 0006:06
>>            6300c4600000-6300c47fffff : PCI Bus 0006:07
>>            6300c4800000-6300c49fffff : PCI Bus 0006:08
>>            6300c4a00000-6300c4bfffff : PCI Bus 0006:09
>>
>> We can see that the window of 0006:03 gets shrunken too much and 0006:04
>> eats away the window for 0006:03:00.2.
>>
>> The offending commit distributes the upstream bridge's resources
>> multiple times to every downstream bridges, hence makes the aperture
>> smaller than desired because calculation of io_per_b, mmio_per_b and
>> mmio_pref_per_b becomes incorrect.
>>
>> Instead, distributing downstream bridges' own resources to resolve the
>> issue.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219540
>> Cc: Carol Soto <csoto@nvidia.com>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Chris Chiu <chris.chiu@canonical.com>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>> Reviewed-by: Koba Ko <kobak@nvidia.com>
>> Fixes: 7180c1d08639 ("PCI: Distribute available resources for root buses, too")
>> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
>> ---
>>   drivers/pci/setup-bus.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 23082bc0ca37..2db19c17e824 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -2105,7 +2105,7 @@ pci_root_bus_distribute_available_resources(struct pci_bus *bus,
>>                 * in case of root bukjijs.
>>                 */
>>                if (bridge && pci_bridge_resources_not_assigned(dev))
>> -                     pci_bridge_distribute_available_resources(bridge,
>> +                     pci_bridge_distribute_available_resources(dev,
>>                                                                  add_list);
> 
> I think it looks better if you put this into one line instead:
> 
>                          pci_bridge_distribute_available_resources(dev, add_list);

Sure, will do.

> 
> 
> Otherwise looks good. I wonder if you checked that this still works with
> the cases 7180c1d08639 tried to solve? ;-)

That's why Chris is Cc'ed.
Chris, is it possible to give this patch a try to make sure this doesn't break 
what 7180c1d08639 solved?

Will send v2 after your test result.

Kai-Heng

>>                else
>>                        pci_root_bus_distribute_available_resources(b, add_list);
>> --
>> 2.47.0



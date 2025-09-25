Return-Path: <linux-pci+bounces-37063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B33BA1F7A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 01:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E41A327E4C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 23:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AAC2ED154;
	Thu, 25 Sep 2025 23:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DwT+46v9"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013066.outbound.protection.outlook.com [40.107.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5C2ECD05;
	Thu, 25 Sep 2025 23:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842867; cv=fail; b=hvj68TnT0/VzlVdYL2jlOgJJxBfRyBsuxWBDlPX57jnQ/yuYRdoaxVwrU3jinB82HRUqc0q386vfSHmcTNx7T0ifT7j5jpdDH1c5rhGspq5lnnLzL2nd5yZ2Yr0jaoqSu/4T9YoHUn760RIujxbTi81BgP+H6pKqp82Mz6Zf+I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842867; c=relaxed/simple;
	bh=ZP/LMyOXa8nhj22UKHcP/CUmaCu/+g1bjouk1ZsSvHg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aZef4hi/cBv/wu+okvsI1VUOFs/XxLycAC2cosO97jIcd48OGJtHvmmg4CCJzpE+JQaaNHYicLmDpmPUO2J3+ILxBXtw/13PS0euq2zyjlqBhYwL2DIdOvYDa0QRp2Oo6x1EXS2nur4WM2iKjp4VxYFGhWstPielzZKFYF/yBL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DwT+46v9; arc=fail smtp.client-ip=40.107.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qt9VEdUwQesg+7WEp0gqhgbyBZbTo3pzS7tkVftZjUfE7TMSHw3S01Fc8B+5gOZe/pFFgm96YtSJ7os2pKyc4gVJpHmJ9kpsbgtqEMmLnc3p3n5P7i4/cifjDRwT/WqdB/jRy3F22ZahXEQ4VvVrpQVwqWgU+ZNgk0MWVyEMc5IVYG7IAB651/JSloaVSec7Wb5WSsKqiwpOuhu8J8T4SjvSIXflXj3GDRFwv9KcB9SfW0egJQxQ4CdRhcAuWwWrC4kUD9kIB/AhDDtRHajUTc4dvbbyePV6at+nc1hyYPLyGsg93XFAn+kWENshDqHwa717TZbh6KOD1CJzYifojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2chXq+DKWvqgyNjBKLbGUiq213ejexhLM8WcaFB26Y=;
 b=A16j6NjbF++6uEBv0pLfp3Wx4SVtKcphwZHuAp+1nzjdEiaArTPh8t1ZVZFku3/BT/nmVgrZdxq/CMYC/bbYd+goWBkbw8lKLAEI2cCisX6AqklXkaJ21rnxIzIGq8Hj45ymNaDJoLPSfvDGCvLe5vJZUKEPUSODIQMjsrA3elBmYekLZwwID9ai5IZ35yZRhAPkjj9ECte09ZWFvJJHbAMOnjGjXkEztP2MY4ArFbP50kwOhbn4zAe7/OWJ51PMUWx4souKIsf/WWJhcjd9marp2qtXsODCyuQ0rdG8XoWFbwY8x+sRYRMXaS/6EcqsADu6ttWwAM+0YralQfO03w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2chXq+DKWvqgyNjBKLbGUiq213ejexhLM8WcaFB26Y=;
 b=DwT+46v9MSkbAp5UhqwTlVgjEqtqxolX455b6L4nMqxza554l4r1dcf92swIANEzXg2S90ou92BR5mwwyMg0XNfG8cQVUcXhgfGhdAxa4dYSgfDGAleIu+4+SJyTh1FwL0FU8ojm0Wn0lm9kLy2LyXA5ZKZI1N6pk5vop9Q0TO+DowS6t7pYVWjq3etK5YiPCzQKfpQWMwNuqCc0fmZ1xBFGFh3t2VJdlwMhwZYAJbnU4G796gSFYc6spBlnaDLHSiNSZOqb1i3+J8n/vAOiGU3907FTx2Blkzd4/rWOquBMgb3BNyNYJd78w3v0F8Jnbimwt0tYAcnOP3E8T1UjvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by BN7PPFED9549B84.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Thu, 25 Sep
 2025 23:27:42 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 23:27:42 +0000
Message-ID: <142cd07d-c251-463a-83b2-246d6af278d1@nvidia.com>
Date: Thu, 25 Sep 2025 16:27:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rust: pci: display symbolic PCI vendor and class
 names
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250925013359.414526-1-jhubbard@nvidia.com>
 <DD1JORQ8539K.1H5X1SIF7J3WD@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DD1JORQ8539K.1H5X1SIF7J3WD@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::23) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f164ca-7a7e-46c5-2e33-08ddfc8b1fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFhMSXRuUXhNNDBkc0lacTJTcDRhZ3BFSnRhdVNIaTdVcjg5dTlzclB0RTFU?=
 =?utf-8?B?ZW5rRDlMWTU4azlzNmhpM2YxaWxXaUVrSHdMSXREczJ3SytjN01CNjJUN25X?=
 =?utf-8?B?VEJzOHU2Rlh2bThiWnBlOHNtbCtPN2ljYXlpODg4V0ZIbTN6TFVlOHgwT1NY?=
 =?utf-8?B?Qi80akQvLzdqeFpRR0ZQd21tNjJkUDRkRkhBamdnZHB2TWVBRDVwQmdQVGZ0?=
 =?utf-8?B?V09zeVhJS0lUNDkxMzVzMktvUTN3cS9tYzZFdmpyemIzcjRaZFVWMk44a3V0?=
 =?utf-8?B?ZGphaFp4RnJlOTRNWG5pTWtmdXJrWng3akR5VmZ5UjBaZkZYSGFtWFhpWE5o?=
 =?utf-8?B?TW53ZGk0ME1adGE5RWhkU2wySGpTc3N5SHdlYmpOMXB4eVZ1cmhZZ3o2NkJm?=
 =?utf-8?B?dFNZdzUzaXk3ZWJOUHNhQzRmcVczY1FDUVpzL3NRdy9pZFYrQlhJL3lCSUt3?=
 =?utf-8?B?aHV0WEtqcjMyYXVCMTBVS0JIZmtpNjdMb0dNVHRPNVpUZTJndnBjRFBUWVFE?=
 =?utf-8?B?bDM0RWpUaGU1Z1ZWUnlvbFc4MVJodHp1TXJmclFsODBoMHFRR29lT0hvN1Jj?=
 =?utf-8?B?KzhBbGZkTmN4TlJaMEl0Mlk2ZUYvMitRdXc5d010YThNMWpUUzQ2OWxCcWNh?=
 =?utf-8?B?bElkU2lFdkY1VmpHNm4zRUxXeUMyZGxETTVHbUMrSVRLbDEwSVVoajhXalRk?=
 =?utf-8?B?KzZNeHplbjlUTFlGUERyMFp2aEd3aG1pVXVDdTNCTVVHTDdGM2IzV25JYU5u?=
 =?utf-8?B?elowSEdLM042empVZHcvWlh4NU5jbWN3dCtmdUZ4MDFSZlJzWEZJNWVON09Q?=
 =?utf-8?B?RTJJcDJmaDFYbVpzblpCKzc4eDhvVTV3S25wa1Yrc0NYTUJOV3NMWWVwc3kz?=
 =?utf-8?B?c1lZYkdIbllWcVU4MzRhUkxINXh3Um1NR1V1WDNML210bW5nZUxBUnQ1bWFk?=
 =?utf-8?B?YkhFcVZOVE81T3g0Ny9qaFB0ZHlNVmRVcE8yWm9wbHFPcFdGdHpEeG9xKzhN?=
 =?utf-8?B?cGRvRnZ2aE1RdDFiaW9BRmh5RWNUNnVlMHBtS3VTajFXdnB0WkRYVTh5Kzkv?=
 =?utf-8?B?SXFsL2NoaEFuMFoybitTNm1zTFlRamRlSlloRzcrREhWY0d2ZUtDQ3JUMFlI?=
 =?utf-8?B?SC9zQUY1bTZDY2F5ZzRvUnZVQkNteHRSUG5VdTFIb0NaTTc3b2VOb1hUMGl2?=
 =?utf-8?B?UEZFN3RUYzdaRTZ0VVovODZqV0p6dCt6Nm1BcWlGTlplZ3pGWHZSMnk0UzRU?=
 =?utf-8?B?ZkQ1QmNneWFXb0djRXlpTDh3aWV0b3lyVkpYalNkQmowZFJTT2hmTmZnZnYv?=
 =?utf-8?B?MzNFTmwyc2R0Mnh6cWtJZ1IxVTA5b1VRQ0R1V2VjZEo4MmkyZ2ZoSGczM1la?=
 =?utf-8?B?dGZCWERJWXlhdTFMTHl5U2FjazZMT3FiYUdHcUd5MUU4WDVVbHdmdEErWFdH?=
 =?utf-8?B?MUtJNzREWU02ZzJJMXdyYzhtZ0tXOE43c21aYkpDWGVLUS9sUjdTL01vN1l4?=
 =?utf-8?B?aEsrdVhKVks4SXFrVDdvMUdaN21RbGVXUE9lQ2NRcFhRWnQ4R3ZDNkp3Ynho?=
 =?utf-8?B?NjJDMmJYcTl6MU5lNk1tZUt3UjY1c3JGckJoZjcrMllLUFdvK1ptVGovc3VS?=
 =?utf-8?B?U1lZWlA0azVtNEwzcVg4OHZaRTVRZnFtZ21XUG11WjRwcUxUUnJUNEplUDdN?=
 =?utf-8?B?ZjNaM3N2dzMwdkxoU2JEb3pjbjBoQWl3Skt0eDl2b0ovc2VjOVppU3JOSzFj?=
 =?utf-8?B?RXhrblE3Q1cvNW12WHo3TFdnR0ViZ0JUQVNuV3dZUnJTSnFKQXRQYndNaXY3?=
 =?utf-8?B?OCt4a0poREhIUzRNcGk1YW5BU0YyL2xYU29qMG02T3k5VUo2UHduMS9ZUXZy?=
 =?utf-8?B?OTVicTk3ZjJMMnkrNVJVbkpLaHR0M1B2dzRMMmMrNTd5UEp4Nk9aRUl0Wmgv?=
 =?utf-8?Q?dcpw/XZbV1E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlRIQnB3Z1h6T3A2a0twWGdpOWpJSkhKM2x1cWhpSzYrMEsyd0J0aGFKbFkx?=
 =?utf-8?B?bjBCZ3lyVTEyVmpZYS9aQWYwUmZVVlRjUThHL2dnODZlWFBvbDVmdjRYcm9V?=
 =?utf-8?B?b250Uk9BMktzNHhSVHI0eUM3enpYNTQwM2loNE5PMkREUnBXWlRZUmllek5Y?=
 =?utf-8?B?bW1jd0JwZmdoNTNtOWEwZWFZYnMxWGlURDdaa2hKbWhwSTMrNGM5ZnRscVE0?=
 =?utf-8?B?SitBQmo3TFlzZDl4c0lwcFVQd3lrS2pJZTJRbDNuRFFpY0NlSGF6ZWczMDln?=
 =?utf-8?B?SklJYmZLYXRIVTcyRU42S2Zjc2FaYnpoRmlpa2VFTEtRbDZ0UzM4Rk1paHBP?=
 =?utf-8?B?R1F6WURCTHFSR1dQMTB3NGtkaDlFTFhXRG5IVnBPOEtxM1ltQVhBNk82TWtD?=
 =?utf-8?B?NnBEamVNNEt1TmZUczZIOW81OGpPMWMrNHpWYko3MFVZZXhaK2l0MlB1eTJj?=
 =?utf-8?B?STBiOHFjLzNkUk9yamZpL1l2VGtmRDVsUVllejcvWFFUa0s4N0VhQlVLaGdB?=
 =?utf-8?B?L0F1Ni9mYUxhcWFZTmJjUGRTQnJxb045SEJzcjNCemVBOHk1ZlNBeGd6OXBu?=
 =?utf-8?B?aWsrN0NmOG9ERlJVaWZnQ1dBOHdMWjVaZ0hFWnFTVTNKalRhbjlybE50WndH?=
 =?utf-8?B?cDFnclFqQVN1TzhlMVdXLytEUjZEK1hVYlBBendhc0pMRE1hVVlnWVIwbVJh?=
 =?utf-8?B?TzdDSXpYYkpvNnRndDJFK3NTaytWWDlLQXg0ZytJUndkZzFJUDF3aTlQaElj?=
 =?utf-8?B?bzVKanBrRm1BNTlQajh5b1BVakFZZ0dyK3VOeW5VdWtRTXNxVjZibVZGMVFB?=
 =?utf-8?B?Y2NhR1VKbkdRY0IyUUtSMzdMUTNFekUxQTVDd1FSL0dsY290MU43QWRHVzJa?=
 =?utf-8?B?UjVMMkNmZXhLNHdnM2IwL2lmNE53S1FjSGlkekJNWEtIMGhxVDFPdlFUbzBR?=
 =?utf-8?B?T3htTnB6cXR3dVJWcU1wMDVwYnJ6b0FuZHR0a1lRN092QUdlT1BrNzFPL3RV?=
 =?utf-8?B?SFFNUVFsNGhHRytUT3pzS0pFREFubitpYmJiMDQyVXg2VWtiWDdzZDh3NTBn?=
 =?utf-8?B?a1lOM0NDa3U5SXdFTW9vcGJ4bGIvNmdpdC9ibmZvOGdDNjYwL0dLWFRhemk0?=
 =?utf-8?B?N3orQ0Y5UnVJcHcwU1I2WWh4ZW9Wa1Bxb1lMeDUyMlVVTkpPdjhmM3ZuZUYw?=
 =?utf-8?B?eFVIcUlGa0dLcFAzN1M5MXdzbllKckEzREVLZkpDbXpIUTR3aWlCL3ZGNUdn?=
 =?utf-8?B?UlZsMzk4K1BrY2h2aXFzYUNQRVNyeXdqUWl6SkZkVUh6TzRsVnFJT0lVL1JS?=
 =?utf-8?B?UFBtenRnenZTZFRwcFp5SFJaTFY1TGZhQTJwSkk5Mnh2TGMyUUgvTWEwMzlt?=
 =?utf-8?B?NUs5VzdGdDJacW82bVVvOU9la095aWFVRkt0Z2VTL2VOQnVFdU9ObDlEb1Av?=
 =?utf-8?B?R3RSVkJwMUtHTmE1SlBYNHZvUms2Z3NQVGtNbmJ2U2pzOEk3c0tSS1ovek9s?=
 =?utf-8?B?ei9RT3RHSnV4UVBFa1FnbVd3d1F0Ryt3SGdxR09zcEZ5U1UrOHJqM2Jpbk85?=
 =?utf-8?B?TDZ0SnVzUTFScElKVmN1blo1Y2VoT1BHNzJWdXp3ZnY1anlCU3pXNUxkN2Zr?=
 =?utf-8?B?MWJabzVTNnhFYjNPeHg5VjFGSHA2dEZzN3k5K1krWFViYlpuek1wY2M1RmFW?=
 =?utf-8?B?Q2FYL2h5TXRnVjl4YUFHdnRzeExnRzJiVzFKaWY0bi9BS09PS3pQOTNrb1c1?=
 =?utf-8?B?ei9iUG5pODVqcTJyY3YrWXYwMWZpU1JvL2orTERLQ0tYVE9mSlJ6Um9TdnlG?=
 =?utf-8?B?aWxXTTJJOWN2TTBmWEVQUER3UVFoZ3NzRTJmN3lKUE85dEZFV2dtVk5QbEYy?=
 =?utf-8?B?TzdWTksremhESVhOUGJ5dVk5OGtpTk5VUmJ6czVDWmpYTzVkT1pVWUpOK3dJ?=
 =?utf-8?B?eksvVDZrNDIxaHVvWGc2S0VLVkljenQzTzBMVHFZRm4vZlY1T2dtdE5tZ2xn?=
 =?utf-8?B?TWN3NzRmMWY1dTFaYStaYkFNOE8wMWJTc2YzK0ErRWpwL2lVWDNlNWJwQjF6?=
 =?utf-8?B?dE5ZclhXeXhXWm11aXhLU2dTWjBGeThNaThjNmpqTmpqQUFmWGV3UzlqMW5Q?=
 =?utf-8?Q?KLB+cEWoaKuwC06MTADTd0f7/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f164ca-7a7e-46c5-2e33-08ddfc8b1fe5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 23:27:42.3844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFLkElZGJA7ieNjvQoaWSEr1I0n1/zXxKrBv+MCkycpE4+aPLhkJE2ID98JRGOlIKhIIQ7HP1YcQmDvTxGjxYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84

On 9/24/25 8:01 PM, Alexandre Courbot wrote:
> On Thu Sep 25, 2025 at 10:33 AM JST, John Hubbard wrote:
>> Hi,
>>
>> This applies to:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
>>
>> It's a small follow up to these commits in that same branch:
>>
>> commit 5e20962a9fc8 ("rust: pci: provide access to PCI Vendor values")
>> commit ed78a01887e2 ("rust: pci: provide access to PCI Class and Class-related items")
>>
>> Danilo, I've added your Suggested-by to these.
>>
>> John Hubbard (2):
>>   rust: pci: display symbolic PCI class names
>>   rust: pci: display symbolic PCI vendor names
>>
>>  rust/kernel/pci/id.rs | 36 +++++++++++++++++++++++-------------
>>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> The series,
> 
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Thanks for the review, Alex!


thanks,
-- 
John Hubbard



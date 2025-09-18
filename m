Return-Path: <linux-pci+bounces-36429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE27B86171
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 18:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4775464BA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 16:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0299219A79;
	Thu, 18 Sep 2025 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BEUtkr57"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA90C34BA39;
	Thu, 18 Sep 2025 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213975; cv=fail; b=q8lqn15HuNcG6xwR03HpEEA8lMPhqG0i3euKBwIq068LKMDnjEUZiZULsMWAyd+7vOaNY8bWKT8p9Rb2mAiOZVtUWugU6XjjgzywGsZD2LQgHQLbEAvZ6g0FcNlxxPVS+Tto++O84A6qchRXDZt98s4Y5l4HnRbMoR+OhD9vQC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213975; c=relaxed/simple;
	bh=zwL1cipMR/xN1gP5CyPzIKpbx4g7VkJSRILhiWW+etQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gZmtl1xBBZu+ruxpgmHrTrq+fCRMAEZFIg2r22D/LvTeYWLeqV2k8KuUD7etP2lPYmd+DDFBxxxi81qUhJpYxqH1/WuOc2EvLsvZNnwuiaIkQAkm0+EpRHEeKaOsPZAkwOKoRcAVrC23hz+TFcJnPRPzjGxn8wtsEBwFzXqFDhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BEUtkr57; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPXSAQkjUgJz0X/XC4+i9ZXfBM1gu1frOJkOuU2134CRAvvVHH0rHSIMDELH3aQp3ZIUidw43XyrlQOsYKvtJhUHfkgsMlnJC1qLG9q13p3DGNj5HCsSrLZBYBsavnwIAc45WYwmtECN4NXoZlJiPxt+Am5SRR1UkwZTUpRtoahqFyGBCvn5JBbOkgYQttA/o/2yYqFJV5EcohoSbrG6Ko6Fs1YOe0pRidCIs5KncotuxfLmE/mMTuBcJPEjorJqeUGeTAMcNN0RRlXjt1mjBiTegLsaJZC7xuDUTvmJnRO3ijTobikr1IrRusF91CIlx468WS2F/n+DwDvcXPXj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIpbz2w2Vo1hJMims8mutk9jz9TJZqE5s8Uji7TVOiE=;
 b=UBZ3wUc95Yp00wClbDcdWLgwOcOSwFvDkOgfDR3XkXtIbA1mF2Gqcc958sCu81RwCzfnbyWBNiSNTSFDWe21jQaM3Kv18+kQXlDR+aocaaN85mmW3/FhUC+mdMqNbgJ+5LnRU53o0fORaYEl1SN1rddlMHZKRO9xRGgMWxK+AlRGaXY11rOoQ3gza67EBHjFgsbzzfQ3gUyWkfivJIQbqeQXTXEnDzHFrpWls3eVLKh/UpZpC7tzxkQEg8udKhs84pK/MZthEJc0LugIzHgwW4WGQW8ZgzjltvHykNyY4SERZuTQ4zoDrkSlrRcI3C0rErtzhR+TW8tn6vGcNJgS1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIpbz2w2Vo1hJMims8mutk9jz9TJZqE5s8Uji7TVOiE=;
 b=BEUtkr57JtvtB0uVMo2X4145nbqDZqahyWWL0YqiTwKSMBCO06IsvM517Ew5XzJeJuVq4BVKxYEnuHd/w104vdDIyLigKk8Q6ITQK+sfmOUclkT4yOupPdHzW251TKjsVdvzhj7BM+Qw226IC9KoNTJc784sicy3USATMv/Qlr3RFvVTFNMxv3IamkdhqZiD3JUXPtvb+b9Aq3uzbtVL/RZnNflZOn87onAycP99k1jo1hfQDML4ufeRANAeCVF9sb+/BD+2gLgYRDvWXimKdmUceeLzAlo5b+WL6ddNJf5mk8848DnUncY7ybt2cg68XINdsbEx7Q2J4bKfSO7Mlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 16:46:09 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 16:46:09 +0000
Message-ID: <b54099c5-3f1c-4dec-862a-dd2e3f8d03cb@nvidia.com>
Date: Thu, 18 Sep 2025 17:46:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 1/2] PCI: tegra: Simplify clock handling by using
 clk_bulk*() functions
To: Anand Moon <linux.amoon@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>,
 "open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250831190055.7952-1-linux.amoon@gmail.com>
 <20250831190055.7952-2-linux.amoon@gmail.com>
 <a743fd19-d54b-450f-a4db-8efc21acf22a@nvidia.com>
 <CANAwSgS-Oq7iXDtiWM0W8NZ2q=BcCGviJAUdscWJRvyxLsw0CQ@mail.gmail.com>
 <8fac00fe-2ad4-4202-a6f2-c5043f7343f9@nvidia.com>
 <CANAwSgSZ7ANQVXyWM6wtaOG0tgAbNxoVh7Kz_AaDuxvQsA1b9g@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CANAwSgSZ7ANQVXyWM6wtaOG0tgAbNxoVh7Kz_AaDuxvQsA1b9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0195.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::12) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 98949ee1-3a1a-4f97-3e39-08ddf6d2de34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE1MVVViMU0zKzRVTjYrM1Z0SkFQVFpnUnROZDFJRDlqZkJJMTV3d0huMkpz?=
 =?utf-8?B?NjRzQ0ZDL0NKOG0wckhjSy9saXZNSXZib2EyVXQxSEpyWVpzd1VvK3hYMW54?=
 =?utf-8?B?bUxMOC9QenBmNjRQZnVOTXhkbFJFUkdHb0I5ckRPYi9PMFBwUUVnckR5Y2M0?=
 =?utf-8?B?Nnd1RXkzT1lpa25XdllNUkIyTlRFbXZ5SnBOK1QzbHpVM3dKTDdSYUJrQ0kr?=
 =?utf-8?B?Z0IwdkJYR0t6Zno3M3B5WUwrdjBsQUwrK1gwOWoyM1BkS09admlabmxXUkV3?=
 =?utf-8?B?MDVNd25OaHBDVElTdEc3QkRDRHNDTzdnenJ1NzczMDNIaHhLdUl2N1BEd3pq?=
 =?utf-8?B?RmlDSUFqS2dvODlUdnhUQjI1SnVHTk9Jai9qZ05ZUnNUK0hsZXFjUjQxTWEy?=
 =?utf-8?B?MHNmNHo2TTJSdWRsZll6c1RoNUFYT0dkRlQ4OXBSUERuN0NjdUVmalh6SjFn?=
 =?utf-8?B?Nkc0YkR5bDBBUnhFbkxiaTEwQzVyMlRQZ1BPN2x2azlxWWxnR1hMNW9salp3?=
 =?utf-8?B?RVdTV2hnam9zakJubjI5QkpRVVRuNFBJUGVNcmF4elBTbExzS3VNcldFVXVQ?=
 =?utf-8?B?a3NKLzVEUTI4bml4YTN6b2VLTnR5MC9nOHFoeGhTVUgzRnlLa3hsNUg0bzFx?=
 =?utf-8?B?Vk5UN0dOSk02QnRZRTVwMVRLZ2taNVlkRVJtck9nTExsYjBiQlNFam9SR3lu?=
 =?utf-8?B?d0hQWTVNSWhZU291K2lLUTlzcmsrTmVSbS8yZ280ZFZnaWkxcnRtTzBObmhW?=
 =?utf-8?B?OTRSTXVVUmR0bU9Ma1hTWmsvcGN3SkRLUU1MZFk5TURTU0F4ZkFIcVdBZnNp?=
 =?utf-8?B?QnZ2YitqcHROTWZyUGlCM0xoZU1EbHkzem8vUFZBQ25pYjh4TEZPR1FFcHF5?=
 =?utf-8?B?TWRxUjNxQ1lZd1huR3ptTVpMblU0MFdickFlZWRKR2FYZmNZZWlJQTV0elBq?=
 =?utf-8?B?ZWo1U0RwTFRMSzBOVDJwN2I5SEN2YVd1T3p5TkVoMVd3ekNkaXA2RHpYc3RY?=
 =?utf-8?B?REJ2cEllU0dpYmxqNi9wT1BJWEdVazh3ZU9jSkZGdXpVMTBsN3drbW1NWEFP?=
 =?utf-8?B?bm1XSFlhazhPY2F1d1hrQVB2T2Q3ZDZHV1R2MzZ2clFqVnhDUW51K3ZqZXdo?=
 =?utf-8?B?cjIybE5iRXRBbHMra3lZVk5LYmlTdC9YSktVcVRJalRwRnJCSStjbFliRDh2?=
 =?utf-8?B?WUppMXZSMytMMHBOQml5bFg0NlIvUE9YcWQ3VWJ3RlpURU5EM1BhRk9QUGpO?=
 =?utf-8?B?elVRYldKTUptWW1Sb3F4cGRQNkIzTnJCbWNlc21idzNiV2FqczlkUUVjYndv?=
 =?utf-8?B?Ym9NeTgzZG16V2R4bWQ1enIvT1VFMW1UVi8wbmFuTmhTaFFENGdQNUJTSkRs?=
 =?utf-8?B?V3h0RVJlelNFWjRSNW16WWtueFU2RnU0L3BUWTg5VjZydEdpQnlxUWRhVi82?=
 =?utf-8?B?QkZrS0x0TmVkSHFaVWI5cUErQkQrQTFoUHRUdWE3ZTZHZmx5ZWJpTzV0cmlQ?=
 =?utf-8?B?VjR1ellIQWJja3hnc1l1TGNrNVZCTnRTYUtybDZwY2ZrWlA5Zlg4bnlQdElj?=
 =?utf-8?B?dHBJM1hhREZJNVdMNjdBQm5EdzBtakhvYlBhSDlNRy81Q3gzT0ZsOHpwUUVJ?=
 =?utf-8?B?S3VSR2lXMys1NmxjcXpsV255WlVKSVN1dnNMU0ZUSURxcW84eU8zdFhJa3kw?=
 =?utf-8?B?ekZHcjdldWJEcDJyaitDeHdhSlFnT0o3VjE0eWQzVmRTdCthaE95cjdwM2p3?=
 =?utf-8?B?UHl4aWJtZkV3RUkwTTZYeERnQk5OcnpJekhTU28vUmtKWVFBZmcyRms4WFZq?=
 =?utf-8?B?bmMyMjBUS3JMUFBNOXFhYzVQVW8xdkdERkh0aFZSNEs0Y2dBZUJYa0NvTHJM?=
 =?utf-8?B?NG5sNXV6YlZQQ09zRmRqdTM5VGpZQnppbisyamtFQ2Q5MmpDK2pUN0NmVFNl?=
 =?utf-8?Q?vbeuVKIn0lI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1A2Z2hOZG9PSlpRUTBQdlYyNDl5Z1NESGdzYmVOajV1Ui90QkRNd3BFYzhW?=
 =?utf-8?B?U3o5NytUSkJGV3Bzd2liWkJ5dHpBSUgwMUNjZEMzTDVEc3BkUGdkVEFGck96?=
 =?utf-8?B?bWJUQmIyaWk0aGEvTUNicE1YSnZyYTgyRUZMaDlpbzFKM3pTeHBiSFVEMCtU?=
 =?utf-8?B?cVpTTGJQUFZrMVAwSUtIRGNZYXhqZnk0TnFaQlFDTTlSbmhGbnpmcnhBQkNK?=
 =?utf-8?B?eXZBeW5QeCtLQWRBbG9UUjVhQlQvdFNtMkNpY2R5bThUQlBiNVhzSkNNUmow?=
 =?utf-8?B?SWlOY3V5RFh1TW1IVm9RazdpaWlZcWkydUEzRDh0WnBiSlJtc3hyVi9SMEd4?=
 =?utf-8?B?a0tpa29iMkMvdkpEVDRvQVBLaXNMVUZkdVpDUitYRkdnenNNMGd3QndmUFgx?=
 =?utf-8?B?UTJJN0hiVmhDZStFSy9NNFBrb1NmeWt5T2g5b0JHbWJ2UWRROFhZcHhMeFBx?=
 =?utf-8?B?QkZRM3VzdWJFdHl2MFFRRFdTSHV5RHFtd2RmdDRTRFhBdnF3aFZkaVFDajU3?=
 =?utf-8?B?eXJWU3FQb2piNGRNakl1ck1CQkl1SXBGUlRzMDhkZnBuSXpPOWJ2UkFhMmNH?=
 =?utf-8?B?cTRmUFdBSFFGZkZRYVlvcTJ6WDFSaHhTK2ZyLzRJdTZOVThDQm8zMHByd0Zy?=
 =?utf-8?B?dTJCQytQYUsvQlJKaDJQZzNyUGZXdHBHcGcvd3VsUzQxN295TWtvQi9OZ0Na?=
 =?utf-8?B?c2lGYWUxMUlKeEVDRWVyQmF3eElwZXd4L0VMa3JvVUkvRWFzaHgveWxiS2t1?=
 =?utf-8?B?TW9JV1lWMStvdmRvcE5oVmNxSUJXZGxjNXZlRDI2T0RNbHkyZHNCN2RSdnkw?=
 =?utf-8?B?S1BmSDdjb1JzMjhYZU5iUTVZbTlLRGFQRXNiQzJpNnFoTmZERWJMbVN5Sm1Y?=
 =?utf-8?B?Q1BVNmg2QWdCLzJmbDJ6SmNuYWpHMjBUQ0VqS1FpempzSFk1eDBobis3cEhh?=
 =?utf-8?B?UWlYMTZFQS9FelFQd2VKTUVScU1kNk4veDFyejZPc3A4RHBPU1Y1SEI0ZUdR?=
 =?utf-8?B?SXYxbHdIY09mdU9kSE1TYWFGMUN2MFJwdDhTT0FET1hlNTBWdjFyaHVGaDhE?=
 =?utf-8?B?dDJTb3FzMjZyOTNpbFVLeE5yUjgyOFBqNGkvN0ppRDhwTUJXcWxTZkVwODQ2?=
 =?utf-8?B?S1dBU3BuaC9VM0puM3Y3N2tUbWlsbTBhSGRFTzEyWVZaMnAwTjN5VjdPaWw1?=
 =?utf-8?B?MkxwclI3ckE1QUNuTDFQT2M0dnFDK01JaVJETVk5Q2VnK2JFS29TRThDelZs?=
 =?utf-8?B?TzROZ2FhYzVGRzdGUEE3Qjk5dXhOSXB2YzdyRmx6Y2RwcllUK2NuOFNaTEt4?=
 =?utf-8?B?YlBmK3FjSU5mbEpuK3NnNnE2U2ltdStYM2ZJZExMSW9lQmZnK3plUTUyNlhW?=
 =?utf-8?B?ZC9oV09hd0ZvYS9zMmYrd1pCREpUZ0hzQVVCODlpRDJMb0pndzBYOEMxOG5u?=
 =?utf-8?B?NGc3YWk0eHVoWmc3UWJ1aXY2YUdJQm85dEkyUGxaSmtBaVVOZXNxSTVvOHZk?=
 =?utf-8?B?NjNlU2g1VkxrbHBKNXV1N3VESkF0TlZmRnh4bHQ2Z1VaM1hGN2c3bjh2RWM0?=
 =?utf-8?B?WjJkVmxvVGFlUTNFWDdoQkpxY2ZwaStiOVlNc1FQa1lsVlNFT3k1TFlGZHNp?=
 =?utf-8?B?YnRpRmZVbnpmakJMRCs3UG1adjFkcVlKSU1hVFNCUkRDcnpNRkg2TTZnRXhn?=
 =?utf-8?B?YXViaHpIWVdPKzNocW1nSkdtaHJleGlhNytlcXhGRTFSOFc5UFIwRlBYY0hX?=
 =?utf-8?B?TGhqaGpVUWpMd2pMemVPcVFrWGJjNFlMbUM0NTdFMlA3TjlXNWFaTFJDcEl0?=
 =?utf-8?B?RTFLU294MDZxWElmWVg4OHA1alhjL3hFK1hBaHZxdkRtYXlXRTBRYUliQVo4?=
 =?utf-8?B?R2Y0aVJSVHJRTHRyRWVPQ1Y0YVhnQWdTcWYvUklnMi9WQ0FEOGF3aWx6QnE3?=
 =?utf-8?B?K0txeVEyTEhzVVdKa1RLNDZwemFWNnNLTXdsdVhmT1ZzSklnMkdFNWp5bE41?=
 =?utf-8?B?YnBEM2E3aTRCcEw3dmVKUVJqaUFjc3RhQVRNMFdJcDFsYUpYWExObVlpcFNs?=
 =?utf-8?B?RHpXeWFnMEQ2L0JFa2MrbERCYkdIcWxsc3ZOSHV1dCt2MFdtQUdaQnJ3aWJo?=
 =?utf-8?B?M213enRWYnh0djZhbVp3RHFCZmFvdzdsV1NxMGR6dStYZnFvTlJydmlHQUM2?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98949ee1-3a1a-4f97-3e39-08ddf6d2de34
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:46:09.0891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 176KgPN6HomXtTsyyc2R1HaXSnDcaNRPd//QX9m4VBsFl6ggiS2UE+VtW+6Zq87RYYkwUERrvL0WlECrNP47qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668


On 18/09/2025 16:06, Anand Moon wrote:
> Hi Jon,
> 
> On Thu, 18 Sept 2025 at 14:47, Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>>
>> On 17/09/2025 19:26, Anand Moon wrote:
>>> Hi Jon,
>>>
>>> On Wed, 17 Sept 2025 at 19:14, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>
>>>>
>>>> On 31/08/2025 20:00, Anand Moon wrote:
>>>>> Currently, the driver acquires clocks and prepare/enable/disable/unprepare
>>>>> the clocks individually thereby making the driver complex to read.
>>>>>
>>>>> The driver can be simplified by using the clk_bulk*() APIs.
>>>>>
>>>>> Use:
>>>>>      - devm_clk_bulk_get_all() API to acquire all the clocks
>>>>>      - clk_bulk_prepare_enable() to prepare/enable clocks
>>>>>      - clk_bulk_disable_unprepare() APIs to disable/unprepare them in bulk
>>>>>
>>>>> As part of this cleanup, the legacy has_cml_clk flag and explicit handling
>>>>> of individual clocks (pex, afi, pll_e, cml) are removed. Clock sequencing
>>>>> is now implicitly determined by the order defined in the device tree,
>>>>> eliminating hardcoded logic and improving maintainability.
>>>>
>>>> What platforms have you tested this change on?
>>>>
>>> I'm using a Jetson Nano 4GB model as my test platform.
>>
>> Thanks. One concern I have about this is that right now the DT binding
>> doc for this device is still in the legacy text format and not converted
>> to yaml. Therefore, there is no way to validate the device-tree bindings
>> for this driver. So by making this change we are susceptible to people
>> getting the device-tree incorrect and there is no way to check. Right
>> now the driver will fail is a given clock is missing but after this
>> change we are completely reliant that the device-tree is correct but no
>> way to validate.
>>
>> It would be great to convert the text binding doc to yaml as part of
>> this series.
>>
> I will convert the legacy text binding to a YAML file as part of this series.
> 
> [0] Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt

Thanks!

>> Also if you look at the dwmac-tegra.c driver this one still populates
>> the clock names when using the bulk APIs so that we know that the clocks
>> that we require are present.
>>
> Only the Tegra20 SoC has three clocks.
>      compatible = "nvidia,tegra20-pcie";
>      clocks = <&tegra_car TEGRA20_CLK_PEX>,
>                           <&tegra_car TEGRA20_CLK_AFI>,
>                           <&tegra_car TEGRA20_CLK_PLL_E>;
>                  clock-names = "pex", "afi", "pll_e";
> 
> Whereas all the rest of the SoCs have 4 clocks.
> 
>    compatible = "nvidia,tegra30-pcie";
>    compatible = "nvidia,tegra124-pcie";
>    compatible = "nvidia,tegra210-pcie";
>    compatible = "nvidia,tegra186-pcie";
> 
>    clocks = <&tegra_car TEGRA30_CLK_PCIE>,
>                           <&tegra_car TEGRA30_CLK_AFI>,
>                           <&tegra_car TEGRA30_CLK_PLL_E>,
>                           <&tegra_car TEGRA30_CLK_CML0>;
>                  clock-names = "pex", "afi", "pll_e", "cml";
> 
> As suggested, I need to create two clock arrays for the clocks of the SoC.
> 
> But the code will introduce more overhead:
> 
> bulk clks -> devm_kcalloc (for clocks) -> assign id to clocks ->
> devm_clk_bulk_get -> clk_bulk_prepare_enable.
> 
> I believe the use of devm_clk_bulk_get_all() is a cleaner and more modern
> approach for the following reasons:
> It simplifies the code by removing the need for manual memory allocation
> (devm_kcalloc) and populating an array of clock specifications.
> It is more efficient, as all clocks are fetched in a single API call,
> reducing overhead.

Yes that's correct and I don't think it is that much overhead. The clk 
names array can just be part of the 'tegra_pcie_soc' structure.

Jon

-- 
nvpublic



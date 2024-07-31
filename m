Return-Path: <linux-pci+bounces-11050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3E1942F04
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 14:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE2B1C21F6D
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D958A1B3722;
	Wed, 31 Jul 2024 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Omr9uNuc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B1C1B1427;
	Wed, 31 Jul 2024 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430067; cv=fail; b=d1H/92vCu8Zl5FrlvQb1XkTn2+khyuRSLPfRqGaC5Lzbb7wwSO5iFJAnvxXBNZPk8c4cPvxcwwFI09mx0t3TkzN1vAWvC2jOGKyv+qmF6cUzLgWqzIlXtAHUwy9XS4wbGHKw2G9/NcU+xOv+VfFmTnBAA6EvfRS7KpURgBP6nzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430067; c=relaxed/simple;
	bh=/a94/tLcTq0F2MKbH4YHNZNKNsVer5CYElZSgdDmCYM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hdaWtQoeTGWfqEGSxdHj91Ugqfu/Ra6FKxxFHhJVWp74/itbZjupt7sHpwd+t99aTYgRLzq6XxCfteMnRb/AvOWOvMZAZ5KzaPdmTMyJjoRGi9Or5/cMZuKeELF//hbjkaFzjrDm6zbhgR2SSJVPaz1xscFyM21HOG5HH0YwwRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Omr9uNuc; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722430066; x=1753966066;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/a94/tLcTq0F2MKbH4YHNZNKNsVer5CYElZSgdDmCYM=;
  b=Omr9uNucWmhH2Gi+t+7JBw48+8gA+YSg0d0AJ7Dz5/n2YtBKCRttHtcQ
   vFW8ykq6/qRJWB1Zv86xC3t/4ib0ABjNdFDR88zzln5qJ4TvVP25Ux8KO
   JT1dBPiEt7M0dAnpXZL5z6Sacj+DB6Ddspi8rTgAlQYi3AKE5sFVXqkvT
   JsdvlURsf7uHggwTF2lyzQd4KpWYktkx6FpXaOPa/9SWti4ST3HR9shiz
   a5G8ZoU0ns7AbG8uQW5vKojKFN8bcaFr1RuvNPmdn2DsYvP1Qyn/EAKKd
   ZUbtcwj6am3WtbrnYgUIeWbaF1mNZUiWvjfGKAQSdpRCHhQjXcfue1AzA
   g==;
X-CSE-ConnectionGUID: DCKKXuyuTPKjnXKylqzbjQ==
X-CSE-MsgGUID: /fLZyZmiQsyRV6dQebxtNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20253145"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20253145"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 05:47:45 -0700
X-CSE-ConnectionGUID: sleV773UTfurEnvjzKycSA==
X-CSE-MsgGUID: U46S+vTPSCqSXDJWeF0nIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54922003"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 05:47:45 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 05:47:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 05:47:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 05:47:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qi6scNO22eaYJZGGCvTGBEp5Y9a5o2tEhbV/1hr+UGPKjkTci8b7Zd/1Y0GNe9abaVzapXdZFIqxRaWE4tInaod47U9oKDucYvxyIwrUqwxITlF9RHgcGHrumKRw6Fhr55GbWnQX5Z457w35/M+gkHjpeoy+jOvPTebEJcejDsLXjmO1b00PyNYHszg2t1HuMN/5WIKpbfyITf93gnlKrARquSnxhR20+4xYZR3b4QSuVtUnLKLlPVpJebQ3lWpBf1b4ipW62yxzUO5Pe89zg/RgXfQ7HHU8LrMk7SHUzA8WokYYAIEtval9G+LMIfwe3D4H0D2Q6S1J00v11sGRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hKBxsrbs2OxWbOmaLwx2aAeJonhSQ1O+aHHjnozs3w=;
 b=y16M65cM68O3mZ+oR7B218woFGm0w7A/6gu8zDtA8CGka/yd4OvXoZ4maKCXV0zOozRZlwGCv4QG99LN063UirtppPXeMa353pACEmlzlMF8044Bg6rnNaIzEGAWAZjga52bythJYwTM2t9wbwriUx2JBQD7j1QtsGeOIJcCAcgWoGuCOmf18xRo3x97MX9R7RWBPFV5FdyWfHmcKMAXQJq1KBDlju3uWIzOhjPSxCD6aq2xhwXCVoJ4a9dJxklC10J4rs2bHOS5MYCKAUMctAC782A701RSjrjqhg/l6LpZq2lnxFBAl9SCczTMKghd0duvBgGo+q11S9KH5wp6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DM4PR11MB8227.namprd11.prod.outlook.com (2603:10b6:8:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Wed, 31 Jul
 2024 12:47:41 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 12:47:40 +0000
Message-ID: <ead1f11f-c4af-421a-8e41-6a107ecbccbc@intel.com>
Date: Wed, 31 Jul 2024 14:47:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 1/3] net/mlx5: Add support for MTPTM and MTCTR
 registers
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, John Stultz
	<jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Anna-Maria
 Behnsen" <anna-maria@linutronix.de>, Frederic Weisbecker
	<frederic@kernel.org>, <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Bar Shapira <bshapira@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>
References: <20240730134055.1835261-1-tariqt@nvidia.com>
 <20240730134055.1835261-2-tariqt@nvidia.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240730134055.1835261-2-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::11) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DM4PR11MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 7634f2ca-03cb-4df8-dd0f-08dcb15ef6d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFdyUndYU3ozakFlSW5qVjFvL0JoRG9JL1A3YmNqWTZlVkVlZEZ2ODFKMExD?=
 =?utf-8?B?d3ROYkkralB1akFGUko3OU9IQjdMMWRZRDd4dXV5THd2eUFJSmF4UW1tVnNt?=
 =?utf-8?B?V1NsdGppbnI2YjlhaGx3NGIzUlVMRFRUMGZVbjE4ZlRibzJDdHBOYWFad1Bq?=
 =?utf-8?B?Q1hFdmVvNk14MHBvbHh3dnJ2S2ZkcFRZLzZWYW9MZGx6L1lwSnZ2SDZnL0l6?=
 =?utf-8?B?WU0ySFdUQjR4N2FoUnR6djZhdjFpV0UwV3BYVGxSSC9BcmV0RVloeE1sYXVi?=
 =?utf-8?B?YnlFYWdQY0NnRW1YaCs3YjIyRm55RHBuUVNYR2tVdktLajdVQ2gyckNTRlE0?=
 =?utf-8?B?V1QyeVBVU2JwMnZ1NXRrRE9SbE5nbHhId2R4c3RrL2hvRjRwVWhiaHVRa3pW?=
 =?utf-8?B?ckIzZDFYeENhOWF3NDE3WllWc0xTYnBMdUpsZ0h4ZFAwTWxuWFFqck9POFBm?=
 =?utf-8?B?Z1lTbTBJVHc3SmhYRXVGRkNOdmIvRmJpeEU5aHpEZmsvclNsT3hTNE5tRS9n?=
 =?utf-8?B?UWpJMWREMzA2REFTaWdpSWU2enRwVlBsZittWnhJcHNxRG5qWU5YQWtRWHNB?=
 =?utf-8?B?Mzg2OUVJS20vV2xpN1FOd0hhUFJsaVJ3NGJnUWJrSk1hRzhuUHhZd1k4d3Uy?=
 =?utf-8?B?UjNmVElJK2puN3dNZUJrYy9TOVR0UjN6QS8vWHlsMWdpekF1R0h4am1NOGlL?=
 =?utf-8?B?TWl5UTlqVlpXV2tERHhrQ0NYc2JiQVF0VWZ0aTk2K2NTSVNxdFFjcTZzVGZF?=
 =?utf-8?B?QnZMZ1F0QzljNldRdG5TcjFBSUY0bEdzYnZCK2pnWTZXUXNuVEpBTWRYTHM3?=
 =?utf-8?B?ckJRUEMxUlB3MTNtb3NMU3phc2xnMGxJVEJ2elVGOGVJWUN2bSsyUnY1eXZL?=
 =?utf-8?B?UU13WjNqUmdFcEJMejB2V0hjZTNoQlEya3VtM0w1Q2NyTkwvRUlyYjlKZXJX?=
 =?utf-8?B?b2hZTDVsL2pLYjNBeTBOZGJWTWVSbVVVaG5DYUF5R1pCNXlVb2FmTjJEcTFI?=
 =?utf-8?B?azJRTlhkZDUyek1HSVpTWUtSY1JHMjFrV3k4aU8zaFUrTjkrM2lmOTZQbjhZ?=
 =?utf-8?B?KzN4NFh0dmRtK1lKc0NtaEpWZ0toVllMLzJmbktNWmRjdmxiRXFZSktxc2hF?=
 =?utf-8?B?c3laSVBZL0d0ei81UjFIc2pmaFZuTFFVR01xSldnWWVLS2JYWWJ4L2FtaTVY?=
 =?utf-8?B?bUlONXJKcU5KY1FmRnVzeXJEdnlLT2tXT1FKRW5XaGdyYUE0cCtlRUJLbWJs?=
 =?utf-8?B?LzQ2cis4M3U3RzBkTTFBRzNKTWNxV2QyK0g0Yis3T3lVL3Z1RWltVWhEd0JO?=
 =?utf-8?B?dWU0cFZsUFRvY1JIalR0UzIrclowNzlYcmdIYW54Tk1VMkxuUXY5bDhtRnE5?=
 =?utf-8?B?RTdDeldPb3FSNFgxcWNjZUJtMTVubWY3MVRFd1ArTVpRWDI0N2RMVXBFVmhY?=
 =?utf-8?B?UDNDWFYrVUlUWmlkMitEb1dQV2NrdzZHbzNOeVphVjduL3d4RjlIZ05FSGFD?=
 =?utf-8?B?YzIyeFRZankyRFV2Mk5yc0RqVnpjQ2s0dGNuR1VTYzA2U0FvL3IybjNPKzlh?=
 =?utf-8?B?RThHd1dCQnUzTWN5aEFkMG85b0VSak5rQ211QzlWRmROdWRWYlAza0pxQ0RX?=
 =?utf-8?B?akt6QmxsZmVnSEJkaWhIRFUrUGpvWld1Smp5ZVliZEhScjltQ3lOV2QwNkZG?=
 =?utf-8?B?cXdIMkxMN3NHNWpGdnQ5Nys1QU1kcTlhUDM0TTNYWFNWckRwL1EwSUt4WWo0?=
 =?utf-8?B?T1FKWnZKeFB6Qzh5ZW5ENnVKb204cldtUmJ5b09KOUd1RGVZQmo1c3BoWmFB?=
 =?utf-8?B?RkRlbkkxZU5GNmFNckR0UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWRIYVhRN1Z2OWM1QmlYb3NrR0NHUlJQclZBSkowWklpcjRXMTQ0V01YN29u?=
 =?utf-8?B?aUF0WTN4TFU4NkU5eFVSRjlqSTdBd0tIYTMzekFpYzZBQ1Jmakh3S29GWUNx?=
 =?utf-8?B?SjlDT05xL0dVM0xmVzJtdUtnVjdPanZNTjgwS0U4K2FRUzFZOERFTjlIVFBQ?=
 =?utf-8?B?YldTbUlUaDVNZnUwdmJtRWRDN2hGQ1ZSeHQ3b3dONWlCbUdUZzBMd21ycUlr?=
 =?utf-8?B?d0lmdFJuOXFiblh2di9JanE4c0FoSkZCWXVodHhxY3JSeVlMZVRFVzhlOXJi?=
 =?utf-8?B?MW4zYWxmNkY5S2lwQ2JtWGhQVmY3WStpa2NtNnpvYThSZUhIUi96anVBakhq?=
 =?utf-8?B?c1lEclRzSnVIVmlDZ3N1Rms3b3ZqRmFlZTJsdis2dm9ONWNXS1N4bTFyOEY3?=
 =?utf-8?B?djRDWlhHYmlvOTEyMCtmYTZ1ZU1Rb1hFRW4vaXZlNW1TQyt5M0I5R1NFKzFS?=
 =?utf-8?B?ZHJoNi9QOXE1a25HZ0pFa1paOHVvRS9OY2FjcU1adFJGTGJkZVNBREo5L1Ex?=
 =?utf-8?B?cjlJOEMzQ1NudGdCNms3UXBtNXpubERUd1VYTFEwcjRlbXkxbHRaanQwT0hJ?=
 =?utf-8?B?UDc4bWRHOEVmSDdYK1kvdy94VTRmUHJNNU1SZFdqZGR1Z2VnV1BiN0lxS2k3?=
 =?utf-8?B?RjF0cjZFS0RnVjNQN3BRQjgyQk1OV3VBQkl0RGpuR0hhRS9QREtZUk4zTGxi?=
 =?utf-8?B?dmhnRzZrNGorRmNxZnpoWlRWeHRyNlI5TWZ2bWVwa21QU0tjWTRCWVZOT0Z1?=
 =?utf-8?B?aHpOeDhrK3N4Q3lyekppbitDSi9INUVkMlpnSEl4VVpuMmMwSVFSMGFQSUtV?=
 =?utf-8?B?OER2ZERycHA5TW5VcG5veFM4VG11RytiWUVwUndRbVRwZlorTjE0WWYyZitZ?=
 =?utf-8?B?MzVxaUh2bTR6cks0SE1BbVdHcVNhcE5EMGxUZWdEcVp6VHRPYVhJVk13R2N0?=
 =?utf-8?B?QmhVQVFIeWpzV0VaUWFVZXk5Ui8vWWxCc1o0Z1l6RXdBMnpxZVZTR2xlWlB3?=
 =?utf-8?B?djZUdkRsY2ZLTWUzWHlNSkt0b1IvN0ZFMGNZVnZ4VkQ5RGVhYWhHV2o2L1Iv?=
 =?utf-8?B?aHVEaURRMGoyc3RPQ2lsR2hmZno1eDZRc1EvS09zczdnU3lmWVdHaHM3VFMv?=
 =?utf-8?B?NExRZXVsRiszQ1J0RC9lWXRzK1dCMGNiR1lPNDlkUEhuVm9NV09YVFd6eWgz?=
 =?utf-8?B?Z0R3Z21CdHQ4eTBTeFozTkE3REF0ZlVOQU1VWHhyUVY4S1JTRkR0NVV5UVR0?=
 =?utf-8?B?dlNQVG1SM3JWenFTYURnMmV3MGV3dkU3MHhwYzZzWTk1akRGQmZOSWcwWjZh?=
 =?utf-8?B?b2NlMDBBSmVPWFlNUHQrQnNpWEhxM0w1Vkp0SHhBc1JhQWxrcEg5OWVMQVVH?=
 =?utf-8?B?Q0JUWXBiYjdqeGhBWk4xQmhaV0cySjRqYTBOUnZ1UTlzL3lCeVAxV1RBM1BM?=
 =?utf-8?B?TVFucXRlOC9tU1I0TTZnbGRnUDM5Y2VodmdCMldpYW9pUWd2RklUU2wxdmcv?=
 =?utf-8?B?czlWbEhlZStRR2kyc2hHUkFnMTA3TGszNjZBRjBMcGJUSFRPZmkvT2RGT1cw?=
 =?utf-8?B?dys5NVVyYnMwUWdIM3hscHBtT29KQWFXSDU3YkNoNG9BZ1RzUkhialZsTWVG?=
 =?utf-8?B?Q2pjUExlK3RQSHZWd1lOUmZqQVBMcTJnMTRIdkRQUUpMZmVEWXFmMUdvaUNv?=
 =?utf-8?B?N1p3YjhNM3ZkSU10eG1QSEQ5N2hrcmNWWXBvUzFDTFNKWXByT0FNeHBVTmg3?=
 =?utf-8?B?My9ncGFSVWFKcE1kbjVGcHQ4TTE2OVRQWlpYRXpYdmx3R0VYK0I4Ui9pZ3pl?=
 =?utf-8?B?d3NUR1JobDBudS9NRWJkQStsT0FzekRKdDBCK09JNW9QcFJzUWNNQnpsRXF3?=
 =?utf-8?B?c2JlNmZEZXdvcnJab0M2ZEh3dVNYWFlBeWlGeWlseEFhbnMxTnNPeFkzNStC?=
 =?utf-8?B?TWdHc3d0bDlzVGJwM0ZMSE9Kek9Fa3Y4TWZMbFZ0M3F5d3FvT0d3MFFYMWVw?=
 =?utf-8?B?L3VDVlZHVzdPVjdPVDJiM21WNUVVbWxXZ0lzUUhDMExmMHEwRUlxN3dkdS9r?=
 =?utf-8?B?YTg3NU9TRlhya1FPNExzSitsTzR0elp5T2lGcVFQNnlNR09yeVA4dFBBRVZu?=
 =?utf-8?B?VDNodXhySmp6dEF0d2pJQnpBWUZCanZSbjAyZTFhZEtrZ1RuUTkwZXlDSlNE?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7634f2ca-03cb-4df8-dd0f-08dcb15ef6d6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 12:47:40.8851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDfToYBH8jp4GZouCOjviTc0fmPmwApvEKNkk04xsuUZSjUGYCDNlH1GrEfpDbVy7wNFuUsJGV8r8frRS6Fvy4xdnuXn1i2UdP3At68jsjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8227
X-OriginatorOrg: intel.com



On 30.07.2024 15:40, Tariq Toukan wrote:
> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> 
> Make Management Precision Time Measurement (MTPTM) register and Management
> Cross Timestamp (MTCTR) register usable in mlx5 driver.
> 
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/mellanox/mlx5/core/fw.c |  1 +
>  include/linux/mlx5/device.h                  |  7 +++-
>  include/linux/mlx5/driver.h                  |  2 +
>  include/linux/mlx5/mlx5_ifc.h                | 43 ++++++++++++++++++++
>  4 files changed, 52 insertions(+), 1 deletion(-)
> 

<...>


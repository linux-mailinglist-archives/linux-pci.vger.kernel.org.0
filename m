Return-Path: <linux-pci+bounces-28672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C746FAC7F86
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 16:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0E33BFAF3
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E0F1A0B08;
	Thu, 29 May 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MkRzL0ep"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188C14EC5B
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748527761; cv=fail; b=FCq1Et1twp1UFcTd1i7xco0PeDfv8G/kajzq2tEwGWCuR0i4z+6paa3SDy5eGFMUfKzC8hx+6Xv/nl1mw3p3yF70SYx34jpSilooRRutyhxQukQsHA+7ox2mtnxLM7fiMotFuA5hrfE2t2BeNSsaasyl5qMO1nC/CN0TlNoG81E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748527761; c=relaxed/simple;
	bh=COkj8KO7Xiklb4MW9Xo0rl31IMK6hSN4xMGD0lDfVy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qNITg0egeoqFUfbthsEURlk5Zr13z/oNIMh06LXR7AcGKy2ig3WSpQXE5geskrEVa0lucrLSLgOt41jhp/C0PQ/6Cjk9uaauYEoQetv+ka19yZOIsVDU00PoeEFRKpwJlNGjwRWTAHiQK9rrgZg2sep/9fwn695HafYvrGmDG4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MkRzL0ep; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikffBjIEgQ6L+J25D7gPVfUKBDzqWBptDKrLeJZX0+Jd8HqfQCavXZG7tx4na3mlKXwZXF/PkD+bUeRzS20HwVebfYZ4rb1xnsbZqSUunnYXm5GaFO0rrtltKIKtSq4RbvV8+7ujged7Lb/rIfOfOsdsmXvVXP7tdCynEE5K0bKxyDSoD8zvwMShF0XTffhQWwIFuxGZh7irz8nX6WyIC0i4QlSEP+owzeafWijkbL82edoZUDPC1YprmF+VSBpLtEWQCMsi+6xRdVj6/f6lRxxcujs/iren3jRYK2RC6z691yjQXHPrlnZXcZwuerG1fQ6p6UPIcOUENGcKSnVQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOaOKf6O3JTLFJd5YS9wHuUY1WDCI7TvhspIZ+UdiU0=;
 b=pXk2v3VRS2NMkvEkQ7Ssx+7oNWLKK+ZF+hIkOgQqt/mTfrewnlP4d6KO6geP5bTdsbCRnAqx60tNp3h/b4an70PTMVPMlGuqLgQlo/mGOWsaAU1BwGYaCNE4DczwMhlKHjRHoysU4tcDgvkvY+TLetOx2uAU1sswy9rHq99DDrkNa9tTqgSZnB6iSjtxuoSm3K/0M9eLFtYc2rPyMN2kNr4/Dt7ciNN7O5hL1qkE89xhHqevH2vZlguHpdhccNHx9jfldI/e6HbdtPewRVjKf7lr3oEQAjKHP3tuYp0h9xEtvFMHsw0+1ec+Xse71DlVSZxPKEk1QaUZskULrPaoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOaOKf6O3JTLFJd5YS9wHuUY1WDCI7TvhspIZ+UdiU0=;
 b=MkRzL0epf9Z9J6HZZxxfEzbNmR8BZLCQ0a2dIepE5iVhYmYiak7QBokCEoS2l/ceXUO3elQLjMAGYrB2qsck6qVkvtHXOhuwfkhb/xZnYOq2aLiuBfmD2FSBuCiHM9s83ZzURwBqmpx5lbGq2PzHlDLUzk0XxJ/e98PKgLfx2JqZw3BK9caOkFcUPg+x7+hiQKFp7Gt3uO8DUcy57eLN3mpPGSw0yqlXeoeuOCHvcrj6tI6b3zD1QZD4tohnRQLbdIAYcYi3Djti4EMGg253zMTh1HWnn3alywOXKcAMJHCA69DrFTbinFW8tNzvdwmbT4LHv2RDqj94DkOV5xJNtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Thu, 29 May
 2025 14:09:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 14:09:16 +0000
Date: Thu, 29 May 2025 11:09:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <20250529140914.GD192531@nvidia.com>
References: <yq5ah617s7fs.fsf@kernel.org>
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com>
 <yq5abjres2a6.fsf@kernel.org>
 <20250527130610.GN61950@nvidia.com>
 <yq5a8qmiruym.fsf@kernel.org>
 <20250527144516.GO61950@nvidia.com>
 <yq5a8qmh53qo.fsf@kernel.org>
 <20250528164225.GS61950@nvidia.com>
 <20250528165222.GT61950@nvidia.com>
 <yq5a1ps75y79.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5a1ps75y79.fsf@kernel.org>
X-ClientProxiedBy: MN0P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: c3cc729a-2ec5-477c-1e41-08dd9eba6548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEFLNk9CRmZzZWF0MkRLbjkvbUJ4c3U0YWpYbVpuUXBBN01NdUR5Vk94WDJW?=
 =?utf-8?B?QWl5U3RJNXhvRzZUTVBkTVB4dFpaNThSaDk2QlYrR0xmSWNjQTl6RklYTEZo?=
 =?utf-8?B?NFE2ZXpKNkNmNWNhcWNMekdOT2RUWlJST28vTEdJNXQxZnQzU0RXMmNTWGFP?=
 =?utf-8?B?UXhmNW4rdjFNOFIvMk16VE5Bc28xaU5ZUkQrcjdRV0dHOWV1ZlREUnEvdVRX?=
 =?utf-8?B?ajN3SFZYY3lGUnY1bVNJV2NiOHBXOTlWMk9vVWN2SitVWlgzdEdUUFBvUHpS?=
 =?utf-8?B?SEhKMC9rdkFmbWdlSnlDdzVXUG1KaTdKOWZBaS9KaXVWeDBBSnkvdTllRkpP?=
 =?utf-8?B?Z3dkOU5Yby8xSk05U2s0Z014VjNuRXZoZFJTUS9rcnkyN3BBRHNLTkhuNS9K?=
 =?utf-8?B?Q2EzQ0lCYUV1Z1R1U25BSEtXckxaTmg4U0poeFRxc25XaHR0S2J0VVZNakZK?=
 =?utf-8?B?SWE0ZGR3ckpUOUVjaS9neSs1bVE4anY3LzdDbTR5M3JHNUVjTzU0NkFRNWY2?=
 =?utf-8?B?WTJsSDV0MGtkYVgxZ1JGbWJ1ZlhyTVRadXFYYUxYaytKcnZJanNRMlNWbkJ2?=
 =?utf-8?B?b3pXaFI1cGtCRlU3QXUrZS9pZjlKQWxtYi9oRkNESVpsSHNYV3Vla1lidVpG?=
 =?utf-8?B?d25ZNDFUNkRXQ2N1UnBYVlVjRW1FMlVuUVJyNmRNbmpLdWRLWXpFUHlFdm9V?=
 =?utf-8?B?bnQ1cmxTNzZJRFF5N01wVmEyaWRiZjN0Q3hXRE1adUR6UGdyeEtwaTdqUkRQ?=
 =?utf-8?B?Vnk2dTR4cmZxbG1EcUQ5MGUySW96eE5nL2ZxQUYyemRleTZyNExSTnJ2SXNj?=
 =?utf-8?B?V0lERlpabU1nbzYrODR5d3BQUkdmcHdSRFdBa1hQRkFZODczOGRQNXZuYThP?=
 =?utf-8?B?c1ExUk1SYXVHR1loWVNSUit5aGJqNTNtVGkwZUpQRUp1aTBDWEZDVjBXOE9s?=
 =?utf-8?B?all5OFFKdXJqZE9kSDlLSnJHQ245bENrVHFGaElpU2tkVk1kVEQ0VU9DMVRn?=
 =?utf-8?B?Unp6S081U2F2S1ZZbmhBeHYwS2hiWC8zMm01NE5hSHgyVEd2WkZ4WGgyVC91?=
 =?utf-8?B?UmwzTkJtTys0L3ZPYmhhY000eWg1aDhBenZvRjBzL0s2cm5telRZWEFLZlFn?=
 =?utf-8?B?K0ZsZXNPOFBGMXR6SHN1czN1SGNqSTNHb3lVSVkzM1B6ZmdIbFFxZFRlUDRx?=
 =?utf-8?B?MmdZN0N5cmtYMWxJZmVpb1ZHS1hCc3pLZlJjS3A0RjVXSHFiYW1xdnM2eXlR?=
 =?utf-8?B?MWxHUkdZL3ZteThqTnUvOXpjeHdnSGJRaXBjMEx6NGxEQ1ZzK2xHRzVpR01m?=
 =?utf-8?B?dDR0VnNGa2lQTEYxTklnazNRRFU1ME9kakwzbnEybnYvVWVJQTZNeGJrVEF5?=
 =?utf-8?B?KzhDTk1Hdm5aRjE3R2c5Z0NUWm1WK3BLcVpFUzlnRVFTMUpla3Z6eWZqMStp?=
 =?utf-8?B?eTNFWGd3OG03eUd4UGJybFFYMGRjSWJvaGtBSnRxeThmM2U3SDhvNUZVWklm?=
 =?utf-8?B?STBqaGF4bGc5eTVFV3JkbFVEOG1SOWw3eUdKenVYUGJ0YXdmVzNpOWF6MWVo?=
 =?utf-8?B?RGJaRHdVNzgzNDVXSnFBaVl5QzFiRlByd284YitEMHNHVjBNMS94Y0JPNjA4?=
 =?utf-8?B?VGwvaWplZklmWWtjZlloZnJEb1J4MlpvTDgrMjFxR0dvTnJpTmNXc3Y3c29C?=
 =?utf-8?B?aEh3TFZ4UDY1eklhWmtXVGE3bmpkeUx3TEQ1TXlCSnNNaHFPODNQU3JaMkYz?=
 =?utf-8?B?c25sV3NHOFRuWDZ0bDFUVm13bVhOYTV0bm5wMTRqOGxQNHhFMXhSbUtQc2tZ?=
 =?utf-8?B?eWRSUkl0aE8zajNyais1WWRtL3dhTDRtQVRxT3EzaEtKRlZPbk15S0dhQnZa?=
 =?utf-8?B?NVJOVFJLVUsrWlNTZldNV0ltU2FtWUtUVkF0VFNxVTBwWm9GNGdVQ1JGQnVo?=
 =?utf-8?Q?8KGlmun7OQE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXNCbWNwMkk4cHczZ04zK1V1eHE5MEFqYWlQS2ZMZlJLTmhmWisxVUtvbldr?=
 =?utf-8?B?Vk1WaDBiWmRtdkJaREJ3Ty8vZmNRVHRhUVJKckdCMFlTNGwwaFhXQktSQ3RQ?=
 =?utf-8?B?Ukt6MlJ4eXRTRnlIakphZmtVTDBwTnVyVkN6eE1SVE8zcFRRemVBci9sWlhI?=
 =?utf-8?B?MXEwU0pyUHVJY0hDZlEvam41RjFjNmFGK0NBRXBNVmVQYUdudm50NmRBcERM?=
 =?utf-8?B?N1FndElPYjJWVjhmU0lBYUZIdU9qRVRGY1ppYW4vSWNpTWtoZysveTU0RG9q?=
 =?utf-8?B?SHBSWmUzUTJFNXNtZHJtYWZvTUMzdVEvYTBhV2wxYkhZMnM0OFFBTmJHTklW?=
 =?utf-8?B?dE9UNGFxWUZiNXNmVFc4NlhLUWx6MlFLdTR3OTZncUtuK1l1YUZ0N3RweFdy?=
 =?utf-8?B?M3pIYlJuMDNoRTB6RWJ2MjNCY3hVRFVZZkRvWjR2a0FoeDFIUEdWUzRuMlJE?=
 =?utf-8?B?REhPNW9Pa0lWR0lFTUpYb2pCZWNsWVZwd1dQMjFyOUlRalVyalNkZFVkdURC?=
 =?utf-8?B?ek4zRlBraHNOeVVRM3d6cnYzUGM5YUNuUGlFOHI4TUNmSDdlVmI3WnFUencw?=
 =?utf-8?B?dWd4QkxnOUg4ZStibG1ueFpRYW80T2RabFhZVHNXN2x3L0ZrT2ZYZGJUbjVT?=
 =?utf-8?B?S2hPdmtDczVVWFludnZMQzhUZjh1aCsybFJDK0lubndrUlhrQ21FU2IzeWg1?=
 =?utf-8?B?Mm13YmJPWFlEdTU1NTFURmpSdzRFYllSb2Z5b3BFODBUV2JuVXJudFFKYnlP?=
 =?utf-8?B?S1BvbEdGajgveUtXYjJGaDNYd3UwR2pvR0FXR3JxUG8wV0Z4aHdhVUI4MjBs?=
 =?utf-8?B?TVA4RSt4dFdrTmgvNnB1ZzFuQzQyekJOUlNMZ3JNYUhIbEJIeVJwdFBMVmE0?=
 =?utf-8?B?em5uenI0MUdGalZFcUVhVmZ0TkRHVXJPbGRFYXRVR0hSK1FhZ1VMTTVJaEtv?=
 =?utf-8?B?OE8zd29pcnFMY3dvQjZOWTY0bE1Oai9SV2RLb0l0NDQxWU90d3MrSzdiT2ZG?=
 =?utf-8?B?VCtSRGxzRHhEYjhiM0haYXhPSXJkdHNLOTlSVkt4TnIrcHZwc0Z3bE1zbHJv?=
 =?utf-8?B?OG1GMVRrU2prU2wyeUlieXgvQUNIVVk2TFV0Q3dzb2V5NEo1WHlUQTU0bzlo?=
 =?utf-8?B?a3hEQzNLVmZRQXl1bnpQZVJjcnZoT21RT1J1L2NRTnZIeHl6cllXbksyLzJY?=
 =?utf-8?B?OFRhdnFicHB0Z2xGSXgvbzZIcHE3R3g2QmJZZVNoSUFncy9qMW81dDc0SDhZ?=
 =?utf-8?B?a1NwWEt0ekpFYzFrQ0FxeWtGdEtoOGlVQXJTbWQrekRGNFlXNEw3cC9KUVJk?=
 =?utf-8?B?bXZYTjJBNDdPQnF2NnBiSzI4Z0NWeDcxV2hRUXF1WmgzK1VBcFc3S0hQNjlJ?=
 =?utf-8?B?Rk1UN1pwU1k4UW5iUWFEcWQ1aXhjOWRmaXBvMjE2dGt1cmpyN3pHbnZQN211?=
 =?utf-8?B?dXJMV3EvdkgyVU5zcVBTR1VsUE1vU2Z0bjRUbGpBSTN0Sk92eDNQWXJVemkx?=
 =?utf-8?B?cWlaMW95aXhMOGduSWZxMXdlZFhEaHBVWFhoNjVBOVZ0cGMycDg1Y3o3OFpL?=
 =?utf-8?B?TmtUZkdHbXNqbms4cit1dTRxWnBqWHdyVDFaRVd2V0NVM3Rub0Nvc05tU1Bq?=
 =?utf-8?B?a1JxWGZ2dkhWZVdTclZRYUR6VUVZREZyUmtrY0daSDZXWHNoOThHZVdLL0VN?=
 =?utf-8?B?TTZVRjBIMkNEU2EyMklDb2JrdysrMnRVSHFkeHRmY2xDU3BrTVRJTHFINTF2?=
 =?utf-8?B?dTRwWURQOGtKMnhSQVViVllESzNBMWwvU0U2dXRIRnlSdGdQQ29zaThIKytL?=
 =?utf-8?B?cG1PcHBqZHZOZzFMaUY5K1FGOE1aOTloaElGTXlTYytBdHdzRysxT2ZpTlZU?=
 =?utf-8?B?Z0dKWW03R3c2aUV5ekZlY3VsVGdzSHNaVVlYVkxvb2lKZmd4bHpKQXlsZ0pW?=
 =?utf-8?B?d3l2MFByUS9IcmRnQlNXUzZxRWR0alNQcjZnNVpVUHJ1SklVMFhvSTZFUU4y?=
 =?utf-8?B?RGNwcERHWHl2QTVkQ0x5aVNYc2ZQZ2t4U2RTTFNKdUFQRTJ3OHFaZURYRHpt?=
 =?utf-8?B?dWRnamZ3bXVqdWl4dnZVZVZaTVlHcW9XcmswMkx4dnZiUU9LUndjdE0xdWxw?=
 =?utf-8?Q?mS5Thyg+3H9x9GCJMPhPmN30P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cc729a-2ec5-477c-1e41-08dd9eba6548
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 14:09:15.8939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zP6k8fQVDDilEE8JaXuGF+K/fUttGJj/tjAm5xF99QDjaatgtHVgBS60i3HtFuY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280

On Thu, May 29, 2025 at 07:13:54PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Wed, May 28, 2025 at 01:42:25PM -0300, Jason Gunthorpe wrote:
> >> > +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
> >> > +{
> >> > +	struct iommu_vdevice_id *cmd = ucmd->cmd;
> >> > +	struct iommufd_vdevice *vdev;
> >> > +	int rc = 0;
> >> > +
> >> > +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> >> > +					       IOMMUFD_OBJ_VDEVICE),
> >> > +			    struct iommufd_vdevice, obj);
> >> > +	if (IS_ERR(vdev))
> >> > +		return PTR_ERR(vdev);
> >> > +
> >> > +	rc = tsm_bind(vdev->dev, vdev->viommu->kvm, vdev->id);
> >> 
> >> Yeah, that makes alot of sense now, you are passing in the KVM for the
> >> VIOMMU and both the vBDF and pBDF to the TSM layer, that should be
> >> enough for it to figure out what to do. The only other data would be
> >> the TSM's VIOMMU handle..
> >
> > Actually it should also check that the viommu type is compatible with
> > the TSM, somehow.
> >
> > The way I imagine this working is userspace would create a 
> > IOMMU_VIOMMU_TYPE_TSM_VTD (for example) viommu object which will do a
> > TSM call to setup the secure vIOMMU
> >
> > Then when you create a VDEVICE against the IOMMU_VIOMMU_TYPE_TSM_VTD
> > it will do a TSM call to create the secure vPCI function attached to
> > the vIOMMU and register the vBDF. [1]
> >
> 
> Don’t we create the vdevice before the guest starts? 

Yes, vdevice/vPCI creation is before the guest start.

> If I understand correctly, we expect tsm_bind to be triggered by the
> guest’s request—specifically, when it writes to
> /sys/bus/pci/devices/X/tsm/connect.

Yes, vdevice creation does not set the device to T=1.

If the device is T=1/0 mode is a dynamic choice controlled by the
guest.

vPCI device creation is controlled by the hypervisor and is done
before starting the VM. It just informs the TSM that a vPCI function
exists, should the TSM need to know that, which it usually will if
a secure vIOMMU is involved.

Jason


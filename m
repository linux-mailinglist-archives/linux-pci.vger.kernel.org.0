Return-Path: <linux-pci+bounces-37248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B33FDBAC569
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 11:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A897AA9E8
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5835F2F617E;
	Tue, 30 Sep 2025 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awLbNM5o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DF92F5318;
	Tue, 30 Sep 2025 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225174; cv=fail; b=KSqb/WBsOzmS3LQJ5q3oWVuIc0PSaP4OQQDBej49N225dFW766z03Z2qv2zyHNFc+jhXOLIiFE08BiioeGNflPY3mFSq8aUCX97VNsq5205LkqswFH0OLE/KQVH2fX3YC7wFDVc2jkVcapMaUwNHJDiRHQXjBr1bzXfm831O970=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225174; c=relaxed/simple;
	bh=Kn4VbegCSC3y85S39bTsqA2TktmzvhcRuGv1tmitWb8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jV9ZjsdhNRlDBZDJ4KOvqlO6yG9R+HnmZxnIR6vG2001W9UyfFEMTb372oC0qi/10HSOpoyQbvNnCiY5sk034aZcnXtyRjcNBVZxuyMPT3dYWi832RO1n7+QUQrNb6vHe0eA80tqtmKrHmgLDokxZXPDLRxB0NH+mh3MR7emR/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awLbNM5o; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759225173; x=1790761173;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kn4VbegCSC3y85S39bTsqA2TktmzvhcRuGv1tmitWb8=;
  b=awLbNM5otZnDjN+IbQ32iCfydscY1pB0kx8QzKYD1m+Op4u2anCA8+9/
   M7PGJUELoVm/9NHky8vKRa15qsJiL8Ccku1uQdQmJy9E6btrf1refCXS6
   ejanP/Nlxhu0JD2sAYFwIynEDEMhmpI5Fi3Bgx9359/BAwi1NYU0ECQMQ
   NHr5M79U0VJKXMRIU4OAGvYTGt9srSQwRdDgMasapxX76aThwntbVmS3E
   voF6jL9cpd8dQYHyiJI7wiPMRD4bSvhUvaE4uYpmwFXHGY/D658sndQ6y
   WHCM8eyrwO/MOMqiQTUmbi2MvIGcavWf2qtjLGYgddRp7/rwdE8CcHd1G
   A==;
X-CSE-ConnectionGUID: LVj8HNogTNivO2LMnbhisQ==
X-CSE-MsgGUID: AgAewA4sS8m3qQVmgY9PFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="84094108"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="84094108"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 02:39:32 -0700
X-CSE-ConnectionGUID: qOgvbrb1Qxe2FQjIwhO4wg==
X-CSE-MsgGUID: GnwdQRwCR9OHbBjxJhicqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="182770456"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 02:39:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 02:39:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 02:39:30 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 02:39:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUnEi5g+cXFRhX3MUQIaF6nYJK5hdAZd80iz6gTJMaG69qVGEqmkLM+vO1X0Yrms7LEaRBqbwHu6dDe9bjXuBfYStFbnc8QLko/fd1773Za/1LsfL1FDPezxDj8FAUEnLitorNb8zv7rwlQnrQpWiDhKTXEEYuSCCOdMKcJ+2U4IwP2bxViTawSqij5zf5t+ElrXRUp0+c/vy1R8s6FNjgPzYFIV7eTDZZNWmvi7nsX7Ph4HsrrWJDmUP3kD8+uUpDq0SBm+MuPFHMcAbqKpQIKJ+83oVBgbP/EHS0YJfru65MY17NlwIo2uzgErOZI3v+zD2UxeRWWKq0IRbSz2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17nxHuo6Tbq0Q5sirHach9IpHjbmTk2CnY2U1+UZg5c=;
 b=ktqSMAxIUz47sh5OJ+ro10C+bDTGp6Yak3C/ianUPHOmQrocp7pP6wFe8sP2Hm+BGvIzykTgEpH/HxIibGg88c2zmdKCtUx8cry9pBiUi9TfOuZqeBj8x5NuyOqGboJ5QFUxlsBuahLbHj/BHpG4xiUFgTTma2UlVZLgJDEHgprvCuQF/pAU2cyfEXe5QArU01x0kmivos7JzD0NEbbuZ0ftJnDkzoRi4++q2QHC9lhhrp8+GxrWKh/fgRQlK39Q6jZo7yAFQYuZfz4T14i/ohCtosSH5yPxbLJqX0QoOu0ikH4UT/kz9tORV6xaeFnh5NAouLHmrsmkxutiAdlUVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by CH3PR11MB8209.namprd11.prod.outlook.com (2603:10b6:610:15d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 09:39:28 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 09:39:28 +0000
Message-ID: <deddb713-8352-47b5-9705-4cea0200d54d@intel.com>
Date: Tue, 30 Sep 2025 15:09:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] PCI/ACPI: Add PERST# Assertion Delay _DSM method
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <anshuman.gupta@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250904184427.GA1271351@bhelgaas>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <20250904184427.GA1271351@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::8) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|CH3PR11MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 95345fa9-1d0e-4031-ab98-08de00053ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enYxd0FYNlZQdTdyUlorK1FnMW9PdW43SGJLYlUwYVcvQlhJcHpXN3JyRDVP?=
 =?utf-8?B?MWF5eUpDWC9JNS95MUVOem5BT202TTNDM1dJZlQwOUhxQ2FlZDNBR1Fpazl6?=
 =?utf-8?B?TGVEaEV0TWhMN1ZVY2pGcTYySVRLNGpGQThZSWsrVzl0TWhuZ3lVcWtIRksx?=
 =?utf-8?B?YzV3Snh0T0wxRmhwRlpvR3hyNDRPbjI1UTVRRnpZYm9zaHZXeUdURlVnQ1dm?=
 =?utf-8?B?c0JlMSs0V3NoeWtIMUJqbEcvZnpVeVphMVlybVpYZmVjT2NJVFdrNnJ0MWY2?=
 =?utf-8?B?TWRPNUF2cTltV2tLNS9MaWZJYnJ1aGI4K0p4TyswRjVSdVNZY0xONHZNTURu?=
 =?utf-8?B?eDJkaHpOdjJUNloxcFRZclRvYTJzODZLMXB0UFhlcDR6bUNkK3o0RmxTMU40?=
 =?utf-8?B?NzY2cVZPSWJEejVSMnpJZGdVVmFiMlNDRVZwZzlzRGxUK1BHWHVaS3VJanFw?=
 =?utf-8?B?ajBNeng2MlhEN1IyK3AyMTN3U3FIQVg0ZlNmL0F1WHBJTU1Ub2kwVU9YdzIv?=
 =?utf-8?B?UHo2UE01UHhCazJZRUN3eTdFd0ttT1hKVEZVN2crKzZhcHZSdHBOTzY2MzRB?=
 =?utf-8?B?eVpwMS9PUGd3TnpWRXE0bytYS3hBVEY2QUZJdDEyV0dRaHd6MDdOZU5vdFF6?=
 =?utf-8?B?Z1NnWHcvWndzMUlkdkxCcmxSMm1NTFZLblhBYVdvTStxQkxTTVc5S1YzN2Va?=
 =?utf-8?B?cFZ2bkwzbFRGc001ZjZQUkNGRW9CK3k0WWgyVmhkU2Z5ak02STZtYVBNSmxC?=
 =?utf-8?B?TEFDc09LWkloUXR1TitmVFIrVEkzSDkzSFhZNDdLeWltYkV1STNsVmhxNnV4?=
 =?utf-8?B?MHFyakMvV0pDZGxyN3UrM1pkUFJuY0NtQ2RmWmQrMXZ1RUUyOURnN01hMjg0?=
 =?utf-8?B?bFZTSVAvSVpxTnRESldMbXk0ZFNZQ0F5S3NRMkxUUjJwS3BCMG5INTM3YklP?=
 =?utf-8?B?c2Q4MU1qZlpENmoxcmF3UnVrc0F3dVkxcUlnRGQvcWlPd0t6TzVVWkdid0Vi?=
 =?utf-8?B?R1BiY0x0OE91c3VLUk55NVJZaExnWXlLU3F5aFlIdkNjVDRKc3JTSTdDMmVO?=
 =?utf-8?B?K1VUZ25pRkdZSHViT29xdUNsZmNSc3M0WFVyNDVKT3FiQjVjR2N6NXVURGJ6?=
 =?utf-8?B?TDEzMTd3TWpyZkJ6NlQ3d3VvRG11eFN0bDZxU1RUcjFTc2dtLy9HNjdLVkU1?=
 =?utf-8?B?M2RaV1VubHNnQllhZWIzMitZUkVJZTBNTlFRS2gzbVVYWUJZUGdwUzBPNGht?=
 =?utf-8?B?ektIdnFEMStnbE85OWhud0lQVkhCby9BaXN1Rjd0Y0dSZGwvdkpLWkd3Rmxw?=
 =?utf-8?B?LytRYWc0Tnp5TldjODk0VHJLQ2VwL0NLN2hORW9RQzc0WFh2UFB5Q0VlUDZ6?=
 =?utf-8?B?cnp0bHpxanJzVTB6VVAwandib3RXQ2YybkZHQ2tTSTR5ZGdkelhqOWdzT3Zt?=
 =?utf-8?B?Z2xQZjBpYjBCQTI2eStNbDNCamhXRUNxYm5xbm1xRXRVQUNYUGNzUENQU1ZH?=
 =?utf-8?B?cmpKOUw1K21LMDFva0pETTZVR1dPSkhxdjFkWFdVTzhrZlM3V2ZTQnJpYVJu?=
 =?utf-8?B?OTZpdUdDQ2dPR1g5VTM1cVA4QlJiZVVzREFLbllxMXQycWprZmdzSzdycnRw?=
 =?utf-8?B?ekt4N0RGT1BZcmhHQ1k3N0l3WE82WW15VVZoYlJWT1hPcWNqQzlvL2tqVVR1?=
 =?utf-8?B?U0ZpdmI3UGZGcSttQkhoRmRESXQzazh5UkV2Mmk3MGcrMW5nMTRxMlArMjY5?=
 =?utf-8?B?U2U5citmUWZnRjlJQTdORjM0L1JzRGh0V2RGTWllb0dpQ0Yzancvd2FNckZH?=
 =?utf-8?B?UWU4blRVVHBVTmNsYVpjMnpCY2pqYU5rRHh6YjgrdFJERFRrNjJMRlRSTU40?=
 =?utf-8?B?Z1VhZzlnOEoyczYrRzFIbk4yWUhLR0k5UzQraDg2cit4Z3R2dHNJcmN2ZCsv?=
 =?utf-8?Q?HRNe06HXR8f61q1GzZhyG/CT208yovTk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnplMm9JN1B1dHAvbjR6aHJWSzlQTU1Jd0NEY3ZOY0Y2QXRDT3dBblFwYVJM?=
 =?utf-8?B?QmVsRkJTZ2JzQndvYVY1ak9nUUNoM3lKcFlMdnJRQ1M0Nm5mQ0U4VVB3TmRD?=
 =?utf-8?B?WFBObndYQXR3UURVb0JacmVOdHpSYlJMVFF2SnIrWmhib3NPVnBlTTVudzFi?=
 =?utf-8?B?dTB6L3MvN0V0T2hxdTlKdmZnalZzWVcrQUtPdENlV0l0STJpS0FtcDBubVFR?=
 =?utf-8?B?d3RWdHppRzZ1OE1WWnEzclZpSXk3MjhBeXFvMVpqR2w5a3hDTmhHdXhxMnZs?=
 =?utf-8?B?OGU5cXpOSkZlQ1JQdkxMM0NlMGZPaWcySUZvM1B1eEhtcVRqRkNpNmYzN1Ru?=
 =?utf-8?B?NG5saVIwcUtPREN0U0wvZ2Q3VkxhemhzVTFrSVZEZGxFdHZkbStUSGlNZDQ5?=
 =?utf-8?B?dEJHT1hIOWk2SGQwQTNwRU1OakhtVEdCOFYvTkpEWlV4S1p4OEpDRDQxa0ZN?=
 =?utf-8?B?N052a0F4N0RyT0pFOUZ3WEFDSHlnU3U1T2JzMm5QSzJOVkhtM3RXZS9yTXBx?=
 =?utf-8?B?YlIxOXlIR3pyNDhQZWhNODY2dEowTFVhVmlrUkxQdXUwWWN2ZXgzRWQ2WHNN?=
 =?utf-8?B?MHY2a29TNzNhQ2l5MmhCZ0t0elBUbER5QW0rTjVzUnZzSXRuNzN3S05Yd0ZK?=
 =?utf-8?B?RHpvRmYzQXVKRXQ5K2NOUU05Z1NBMmNJdHliM0s2RVZnM1JrV3U0Z09BRlJH?=
 =?utf-8?B?RXAvV3grY1Bra2RaNTZZeWExeUVjNDBSWEdhMHFockhESWcvenQwamxwRUF3?=
 =?utf-8?B?MUw4a1pJUGx3bDMxZE5ybWxubFZmazFHeGtnTGtsOTZWb3NhT09WMTVzT3Fo?=
 =?utf-8?B?MzJDRWJVVDdmRmdmSDJpWDFhRGk5U1piSWQwanNMaTNScXRBSHBVUTROK1pl?=
 =?utf-8?B?ekl1ZDJWRGM5MTEyTktzNjkxSXR0cVUwYXMyYjhsSWFRMmJoTkE0dER1Z3RQ?=
 =?utf-8?B?eFpEVnNZQUE1eHRJRFlHYXl6dkRkckIrTkVGTmVnT2swMFF5QnpEaE5UT2cv?=
 =?utf-8?B?VTVFN3VlNzJFdzByVGxGeEtzUURiTHpTd2czR1VDc21XeFc5VFFZRWZMWmU4?=
 =?utf-8?B?UzZCQXlYVVhlWXgrVXZocTkxRnVlcmcyc1hyZ1d1b3YwVElNeXR4UVRoK0Zn?=
 =?utf-8?B?SmtvMnJ2UUJueUZuRHFXYWRTNEpGSGdPNlgwcHNuUnBaUE5ldG1YWVVnckx1?=
 =?utf-8?B?RDNmNDZOMDBnNTNuUUEzZ3gwRjJZajFBcmlYaDBGaWc0QkQ5UjQraksyRFF6?=
 =?utf-8?B?b2FtYVEzQnZlMEd5ZlZXNzF1R09ZNXdSeDVLWFhNeGRYd2hwd2ZDeUhZUElO?=
 =?utf-8?B?a0ZJMmd5UlJDcHRnTEM5ZmJzaFpKaGhOTDg0S3dYaVl0UnlicXNHa2djalJh?=
 =?utf-8?B?T3EzdklkT3c1eTdLa1lFNUJUbFlNR2J3a0Q4b1pIdnNCd2RjaWRWOUxhSVBR?=
 =?utf-8?B?OTdyVERtT1VaNmVIMklxQ2RudUZ1U0hVUlhoU3pZQ09ybkxpQ1ZxbVBJTVdG?=
 =?utf-8?B?aUY5aC9Ia0ZYTTNqTWxGL2sxNEViVjdzNnQzMFpCYWw3ZloyNkl3VWI1ZXRm?=
 =?utf-8?B?MDRKNUhLL3l2N2JjZlBJeWlRcm9Ua2ZUcGh0OUhFS3R6ZHRMaStCR0dYYktj?=
 =?utf-8?B?VnZuUHFuNlNGdXdLbWFXdDBES3BKc1k1S1pyK2t2M3V1aTRpNkNQRm9sdjdL?=
 =?utf-8?B?cWdWQlppK0p5cG0yZ3BqdUI1anZIK1U2NldrWlNhMWVrNDNtZ1R5ZEFLNU1H?=
 =?utf-8?B?dVcyc3BwMEJBVUUzN2RsYzJlbHl6T1BRdFF3STU2emVhWFpjS21kaHp5ZHdx?=
 =?utf-8?B?bWtCZHVtY2E2a3pFUnZINWxXTURZbEd0QXFvN2lnL2dVd2hqNG1JMCtYRnVq?=
 =?utf-8?B?NGNXQTRmdEcreVVXWUhZOXcxcDJyTGR6eXcwcmxLMnB5REcyWGRGZkZya3hy?=
 =?utf-8?B?dVJlY1ovN3hRd2dXOTNTRmtMZWg1WlY1cGs4VnVNMEJISTdpNTVncmpOT3FJ?=
 =?utf-8?B?T3FqQitoK1o0S0pYWUJqK056Nkg0OWNHRDZSeUFEc1crQW1TWXl0SUhUTW5X?=
 =?utf-8?B?UEJadnRWUVd3d2dNVTlxd0lVMzFaMDZjY3VDci9mTnJwUmxNOXczV09LTjBX?=
 =?utf-8?B?WWlOOGJLYlJhWGhvWlZQYUNRYXE2R0FSWGRDVlp1eC9tY1dra3BNekkrUWth?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95345fa9-1d0e-4031-ab98-08de00053ff5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 09:39:28.4903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 372B45hrz6D54fQ6a8fr+Vr/RqPrJhqyDsUqaorEEuZ5ts76xM0ZzQUu5dsAbAHBk5ZLqKC9WmyNGQQVidUeeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8209
X-OriginatorOrg: intel.com


On 05-09-2025 00:14, Bjorn Helgaas wrote:
> On Thu, May 29, 2025 at 04:46:46PM +0530, Badal Nilawar wrote:
>> From: Anshuman Gupta <anshuman.gupta@intel.com>
>>
>> Implement _DSM Method 0Bh as per PCI firmware specs
>> section 4.6.11 Rev 3.3.
> Update citation as for the other _DSM function.
Sure.
>
>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>> ---
>>   drivers/pci/pci-acpi.c   | 57 ++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci-acpi.h |  8 +++++-
>>   2 files changed, 64 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index d33efba4ca94..88044491feaa 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1531,6 +1531,63 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>   }
>>   EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
>>   
>> +/**
>> + * pci_acpi_add_perst_assertion_delay - Request PERST# delay via ACPI DSM
>> + * @dev: PCI device instance
>> + * @delay_us: Requested delay_us
>> + *
>> + * This function sends a request to the host BIOS via ACPI _DSM to grant the
>> + * required PERST# delay for the specified PCI device. It evaluates the _DSM
>> + * to request the PERST# delay and handles the response accordingly.
> Reword in imperative mood.
>
> Like pci_acpi_request_d3cold_aux_power(), I think the driver should
> call this with its device, not the Root Port.
Ok.
>
>> + * Return: returns 0 on success and errno on failure.
>> + */
>> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
>> +{
>> +	union acpi_object in_obj = {
>> +		.integer.type = ACPI_TYPE_INTEGER,
>> +		.integer.value = delay_us,
>> +	};
>> +
>> +	union acpi_object *out_obj;
>> +	acpi_handle handle;
>> +	int result, ret = -EINVAL;
>> +
>> +	if (!dev)
>> +		return -EINVAL;
>> +
>> +	handle = ACPI_HANDLE(&dev->dev);
>> +	if (!handle)
>> +		return -EINVAL;
>> +
>> +	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4, 1 << DSM_PCI_PERST_ASSERTION_DELAY)) {
>> +		pci_dbg(dev, "ACPI _DSM 0%Xh not supported\n", DSM_PCI_PERST_ASSERTION_DELAY);
>> +		return -ENODEV;
>> +	}
>> +
>> +	out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
>> +					  DSM_PCI_PERST_ASSERTION_DELAY,
>> +					  &in_obj, ACPI_TYPE_INTEGER);
>> +	if (!out_obj)
>> +		return -EINVAL;
>> +
>> +	result = out_obj->integer.value;
>> +
>> +	if (result == delay_us) {
>> +		pci_info(dev, "PERST# Assertion Delay set to %u microseconds\n", delay_us);
>> +		ret = 0;
>> +	} else if (result == 0) {
>> +		pci_warn(dev, "PERST# Assertion Delay request failed, no previous valid request\n");
>> +	} else {
>> +		pci_warn(dev, "PERST# Assertion Delay request failed, Previous valid delay: %u microseconds\n",
>> +			 result);
>> +	}
>> +
>> +	ACPI_FREE(out_obj);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_acpi_add_perst_assertion_delay);
>> +
>>   static void pci_acpi_set_external_facing(struct pci_dev *dev)
>>   {
>>   	u8 val;
>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>> index 6079306ad754..e53d4893cf56 100644
>> --- a/include/linux/pci-acpi.h
>> +++ b/include/linux/pci-acpi.h
>> @@ -122,6 +122,7 @@ extern const guid_t pci_acpi_dsm_guid;
>>   #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
>>   #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
>>   #define DSM_PCI_D3COLD_AUX_POWER_LIMIT		0x0A
>> +#define DSM_PCI_PERST_ASSERTION_DELAY		0x0B
>>   
>>   #ifdef CONFIG_PCIE_EDR
>>   void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
>> @@ -135,7 +136,7 @@ int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_de
>>   void pci_acpi_clear_companion_lookup_hook(void);
>>   int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>   				      u32 *retry_interval);
>> -
>> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us);
>>   #else	/* CONFIG_ACPI */
>>   static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>>   static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
>> @@ -144,6 +145,11 @@ static inline int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 req
>>   {
>>   	return -EOPNOTSUPP;
>>   }
>> +
>> +static inline int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
> Wrap to fit in 80 columns like the rest of the file.

Ok.

Thanks,
Badal

>> +{
>> +	return -EOPNOTSUPP;
>> +}
>>   #endif	/* CONFIG_ACPI */
>>   
>>   #endif	/* _PCI_ACPI_H_ */
>> -- 
>> 2.34.1
>>


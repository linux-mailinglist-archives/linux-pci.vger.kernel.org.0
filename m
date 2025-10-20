Return-Path: <linux-pci+bounces-38793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD234BF2FAF
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 20:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D4B34E51DE
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA752C15A9;
	Mon, 20 Oct 2025 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDtuTTC2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707311DE4E0;
	Mon, 20 Oct 2025 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985810; cv=fail; b=Rm9riSyxnOYmPki4VWuaJ45VbLEPVVUve5rG/5yzvMpayNohsJlV9W+uPWXGtb2+IqEWOzoT9jYozoVbEM1ZINFtkG25+zrmW33yzU6HIX6BPxyaoAtxdRXC8n6fW3uIenqb8rnirlN0bO601WRaYG/wdfFJgXYF56KuHusfy1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985810; c=relaxed/simple;
	bh=Jplh+hDKCY4Y+ye5Q/nJ/YslJunZV1IZEYCxZrfpiqc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=iJe7bOKgG2yozx2/1zFYg97G/X4Z0QaDB2jpxTijkwfDiN71eJedYRy5a/HFDDmBPzmR/XMHp4NjKO6LtGwfxNPLxG35M/ZdRtNrVBiAs/0s1zn0wRu7glLNkl7gTSbtlwf20fHjzQW5yd3qUvSVuTC+AE+li+2p0i+iNJpCoak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDtuTTC2; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760985809; x=1792521809;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Jplh+hDKCY4Y+ye5Q/nJ/YslJunZV1IZEYCxZrfpiqc=;
  b=fDtuTTC2MHDMHPz1QPOKAJdhRgrdxuGmRTSK1PyUeEwU3HNkyDBWmkIe
   dKA8bhvbNhdD1AMnNQd5iIR2bv+8qqOYDFdd+sQSWCwlFU8ZZzlaQewEP
   J8PAftnAzNrIpIbWqKvAbULza+uS1spUunLMkfjbczehx7UCkQW/wqtPk
   aZS79MDc6urjqnOQvLGt+ceBKaEKLSVRQp8BLiqpWJuGasie6yf9FBXQA
   +H9nvGrbyYBEEgzDEZ6HUOpGj8gvibe8o6797dCi+nCB5cDOi0xSXMe7A
   HHfwCoH7ifM8wSfFDaks7DYpiwHlHbS2/tntnGumY7LVEbSa7ITh91Gub
   w==;
X-CSE-ConnectionGUID: trZylR2SQfa2BdEWoNUAWA==
X-CSE-MsgGUID: MeIsxcbvQoaox/BCqzTtlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73778104"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="73778104"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 11:43:28 -0700
X-CSE-ConnectionGUID: iptt8ZiVRo6zJaDioAeYxw==
X-CSE-MsgGUID: AKCy+0VkRJ6Tl/f+C8gVcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="182584097"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 11:43:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 11:43:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 11:43:26 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 11:43:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvQQFBP0/RdlfyX4vEK1ygT/GSJVx1VUqkYrLf42uMDZMua6np2IoCaneP8SMYzw+bcO7Jj/0eqMnufh2KjRcahVx1Je/ix3DYLcqY8VWLVSfTTsToR8CDIvtEe0FhYrRV8iaYtflqrZs3sbm7e5aYQ2lxWvFKA3FuLXHrXcrKK14LIk81+oZtwzrLBhL77iav/yvPeo0Hg8GX5QuzbMVss47Edhx6ngxT9gZ7Gngy+Wh3sGayGiQT0sYUV5ywh5bxNQPN60wfNwxkvwIi9HGPr6m8QA9IPhV/OdEv6ZqOw4JjDrIjfrSYk7Fp+knL+kZYGMRlOz+ZqrFdl2/VPIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYBJXvPvAEJkENZQuEKA65rXy9L0g1jIvohBXAEE6Lg=;
 b=JcZMGHzxglst+FZ4YdGEwwq6jpEg2XgnFGgHQ4Sv4wwGJKOWYvkUkV5TV1/0vcuNtY9Ex1gffanCe4mSCUvFg+LmusL5rjJdSfjPd3seF9v7UENvhVIbJjyDIQDtl4cFDUGi1uH3rrgQH+WqS1n6Rr3hsyg2PGGSJKqMS2DLdL2L3dF6EyBzZLAOU1kUw8nhbZNVAOsHy2UH3PGWEGiAEr0BNThTICH/pv7v7PVdJ5icfefWfE3zEmStYr8yZwS6TCLXaC6Vzg2+M40EnLp4HQ+LgQ4SKUnJtAXPa/1pkSq7EmNn5TazNpfPnJstQG7w1B6NirRkTcCx8sJKF080Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7524.namprd11.prod.outlook.com (2603:10b6:510:281::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 18:43:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 18:43:24 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 20 Oct 2025 11:43:23 -0700
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai
	<tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PCI
	<linux-pci@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>, "Dhruva
 Gole" <d-gole@ti.com>, Dan Williams <dan.j.williams@intel.com>
Message-ID: <68f682cb2627_10e2100dd@dwillia2-mobl4.notmuch>
In-Reply-To: <5943878.DvuYhMxLoT@rafael.j.wysocki>
References: <5943878.DvuYhMxLoT@rafael.j.wysocki>
Subject: Re: [PATCH v1] PM: runtime: Fix conditional guard definitions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:332::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: d236b365-191b-4100-3538-08de10088cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2c5SW1FUkJHY21YMVpUanV2UlNObW5rMU1qeWh4T2Nwck5YQmI4ZGlLa1BN?=
 =?utf-8?B?aG5KK1FOZTRnQS81NE5odU5rdzM1YnYyRXlVaHBoaXVBY2JWRWx0NkpNbGUy?=
 =?utf-8?B?RlFQdWFHSEZyTGhIcDlKUGFVNVNySG04Mk5reW10Z0VsR1UyTEhTSGxxbnFm?=
 =?utf-8?B?UDRMOVR0ZHhKK2c3SFJYMnc5U2Y2MTFGdVRYcitKVUw2OSswZDdsc2x3eGpB?=
 =?utf-8?B?V1ByN01BYSt5TEhoVEhUTVZ4bjA0a1JZeTljeUNxMGJSVlJ6UEk3UllaSFhM?=
 =?utf-8?B?NzNmMVZrMkpRd21EczNEN0xxb0JMT0kzV1pjNlR3UGlLMkwxbnRUWG14MDNn?=
 =?utf-8?B?OWl2dExXTDEwMzcwYTZMMmdxc1JmWG9XM3pjNDk1U05WRE9hdVVmMmJVUWRo?=
 =?utf-8?B?Y2hqVUZXK3BoL1lhU3h1aXc3cVVoOXg0bXJJUTBDeVU3Rk9GVG9lQmlUUlNZ?=
 =?utf-8?B?MmRyNThjdHEydlUvRHRUUmcyT2JEbVh6SUNWUkNBelhrUEVTdlQxQTd3MDZU?=
 =?utf-8?B?M3ZEd3lMRG1xd2wxazE2bmQ3dGRIL0ZNQndXM01HVDhaTDBkU3lwbUpDSE1O?=
 =?utf-8?B?SGN1dDRWUlVkdHkwWDAyVzhkWWR6K01xLzc1WG1Pb3hzRThUVzdlVVJoMG8v?=
 =?utf-8?B?d0tSbGhWbVFyMlNQOHhnUURuWktwZEs5UklwMTQ5Zjh2Y09UNzVWME5VeHpy?=
 =?utf-8?B?SElyQk9majdWclJCc0tkaG9LSDFCRGw1VWNUWm5CUE5aa0dpMmROMGQvTFBX?=
 =?utf-8?B?OUU5M3NqMmkrdWw4NU5lMncvSDdaUy90MUh6aGJBZi9NVWpWbG5WR0NOK2E2?=
 =?utf-8?B?MjUrSGcrL2wwVWwxMHpFQWQwaWFvcnlBWUs5ai9zRjJYY3Q0d3ZMVDZkWWdZ?=
 =?utf-8?B?ZDM3UXRidStlRUUwOGw1RFlJSHVaMlpkM3owbWxMak9KMzRlSDd6YWtvLzhB?=
 =?utf-8?B?dDRKSWNKN20rWkQwZ2tYTHVFeHRha1pjdjJiSlRXcjdCNzRnbHZTQ1dTMHpC?=
 =?utf-8?B?Q0MzQnRHN2hwbDhMUXhEc1lQdFFmT0FieU9XZzFkQmVVNjhrMVpTczA3WkRT?=
 =?utf-8?B?dGR0OG9BeVpPd1FndDlRLzNwMDRoVHV3SnZGdmVyZ0RPTVV1MmNHSlQ2Wk1i?=
 =?utf-8?B?U3BGWEl3QmpCV2Q2M21YRWs2U2pWYlhzNnoyZ1VlV3MySlkrY0NtT3dWZllD?=
 =?utf-8?B?VHJXRXN2dlVLeGNpOGxLa1AveWZPanJQZ21wVlM0c1V2TzZ4WjBCdnlzcXlw?=
 =?utf-8?B?Q3hYazRZVG8vNU92aEZkMUkzaEFjc0d5ZnRhd1AxYng3aGFQTVN6OVJpSlBr?=
 =?utf-8?B?WWNyRlhGRXZPNzllWWxZU3d6cVpaTVI2eGdHeEV3VXgxN0VYWTB1MG5ydGNV?=
 =?utf-8?B?WFJHQmFOaUdnTXAxaTRjUDhHdHZweGUrbk5ySEdsTE9MUlhIdVdzMDNVU1hS?=
 =?utf-8?B?NmljYUpFcTErTVM5a0dBRkVscyttUGpYczFkdXBpUWU4b1p5SFdiRE5BT3hO?=
 =?utf-8?B?bDRHSVF3UkhEYmREbGsrSTFQWGhKTExUS2xDWk1DbTlneVE0RDAvNVMzK2pJ?=
 =?utf-8?B?RWx1YWlpYnN6TlVDaXhJeXF2STFZWURJL0ZEbVEvOHA1TjBvRnJvMUh0ZWIv?=
 =?utf-8?B?S0F2OTQ5U3FULzhxdm15WDhidkQvMDRzeDFUSWVVK09QZ3BrZlFlVE9Wcm45?=
 =?utf-8?B?dWNwUE1nd25CVURCMnZXWmUyUUg3Zm1BbUtWM2hVZE85SDF2WGlCdndVa1Ir?=
 =?utf-8?B?NHowOTVhRW9PcndVRWRZczFkcDFDZ3BTL3FuS0d0UmpuU3pWcWY2N1Npell5?=
 =?utf-8?B?OWpvcTRjdkgybTBEd0dGU3M2QlZMVkduNy9GMFppYkFwSTdESFV4Z2R3UVFY?=
 =?utf-8?B?S0Z3Q2ZGUEZPOTJ3R1hPS3NSWm5XZEoyUEdGYXdObU5TKzJrcWhRS2RoUml1?=
 =?utf-8?B?M213STFubU5jc3ZPZVVTbHpRK0cwUGMzU3VxeGNoTitFS1lKSmowVjI5RVd3?=
 =?utf-8?B?UVE0dDZONGpBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?My95SktsYm53SW5SV2pkdldxY1dvcFo1bjNzRjU1SW1DUGJsNDB2NEY0cDlK?=
 =?utf-8?B?UnBXZnRHNXBIREk0WUl3OFptTTJQTjh6b090VkZFOHVhUW42NUxEWWxnZ1pI?=
 =?utf-8?B?Q2JVRFdxcFROQ1VVZDR5UWFkYUt4L2ZGV0R5cEZGUUNrbWI2WVlJTGFIVFN4?=
 =?utf-8?B?VFpYdXdXZkUxVDZVZE1pNnVzVEtpbGI2TG85QVJqUGFiUXVUK1k0Q2N5SG9n?=
 =?utf-8?B?dVRTTGtDTHVLVkpqM2VUQ0h1YVUySWdXLzJyTXgvTUZsQzU0UElSb0t4R1oy?=
 =?utf-8?B?MEZMdDkxZFBZSGgxV3FDeURBNWFyRDg3WWpGNmlpTktqRTgrZDdvWUM3eTFh?=
 =?utf-8?B?Nzl5UEFqR3EwLzNzR2hHaHgwb2VEais1TkNQRlhSN1pBNklGS0FHdU9kUlZO?=
 =?utf-8?B?MWpveDJtVGY2SUJFTzgzeXh3T3d2OUJFbE1rVHMwYnBJQ2NsY1lEZmFJelNv?=
 =?utf-8?B?dDJBbXhWc09nOE5XSWptSlJyaUR4RHNhY2p0QU1HR2xMWFhOVnFrRGdrcDNp?=
 =?utf-8?B?L3QrRmM1WFh5UUZ3cXphUEgwUWpFaE85MzJ1SjFEdXBCYSt6ZTlScnE2QVps?=
 =?utf-8?B?WWxtekwrWThpSGRnM1paci9jZGx0anZ0OXdJNVc2K3pBekorMWxLVTZPd2Nz?=
 =?utf-8?B?cHhLVmhyQmUvMVNlY0x2eDRNUHR1bWVianNmSEF4RXBobDExMng1NnBHd0VW?=
 =?utf-8?B?Z1BJejN2UWJ1WWRuZFZwWkoyeVRuRjNQSzg5d2YzR2wwK0RFZHFFdlJoejZE?=
 =?utf-8?B?RG9xUmViTTc0ZWNlRTBvbWdlYVZjc0RQQjRZYkpYbVpuNDlNeVM5c3dycmFq?=
 =?utf-8?B?TVB3SHV5OERSS3FRcFNyMVpjYVBsRU8vR0pjQ28wakxGdmpLRDVQUXdzZTFi?=
 =?utf-8?B?Zkw0cW8zTmNoNWhmVy9Ub1N0VjYwZlNRdkptL0g2MDg0Tm5IRnN3NFFDR29o?=
 =?utf-8?B?TTZ4V2hYbkxaeEUyK2FLTkt0QXhjZnEyNzB6cEtld3RnK3Z2QUMxS0xuUlVZ?=
 =?utf-8?B?UVY3Z2M4dlZLckgwOHJwOVlUaHg3b1FHWUx0RWlnaUVQeGR0WnRkNEJ2KzNj?=
 =?utf-8?B?NC9IKzBOWHI3ZVRodnlSaldObEI1d0haVlVJdVcySW91L3ZsUFlxd05FTHZy?=
 =?utf-8?B?L2dodGk4bElMTDlDV1B4NHF2MUFEbmY3cVR2WVljdzhiVU16N0VBVzlIVWxS?=
 =?utf-8?B?OVQ5c083N0k5ZXd4c1VKd1JJclFpcUFUcVpLcDdaaGhTMVRWZVVhU3p2VWpn?=
 =?utf-8?B?UDZLT2VxMGJkd0pOc2ZEUjhtM0ZFUTJNekduVUR3VWpOaWxXWkpLMndqbFps?=
 =?utf-8?B?NkRQUmJOd2NFNUdxWHYrRUF2S1M5NUNmZ0VzRHJHbTI5ZDRXWGpJT0FFT2NI?=
 =?utf-8?B?VVNycE56MkJLeVJrRDZFdlJGY3VPM1dPVEViOVpMdVV2TVRJdXk0UmZFT1lC?=
 =?utf-8?B?Z1U1aEx3L0dnbkwwY21lWTJQVW9yRzNzTTVMemlEQ0tZWEkvVlJaTXJVSVVD?=
 =?utf-8?B?Q21CN2RvTjF3encxd3Y2QlVkOGVzWFdBU1c0L2h3bkd0Ty9qRkpOeFdGcTMv?=
 =?utf-8?B?dXJXTTFsU3R3MTcyM0JRZ2UwWTB4MnJ5ZHJwcERmM2kyb0dnRHJTaFlkQVpF?=
 =?utf-8?B?VGZQRmtsZGNqQ2RCekRRemMrQk5sQkRLYW02MGY4amVNbDBWRUxQRUgxZkc5?=
 =?utf-8?B?Yi9jMTdJMjJvVldBSjRMdWFMNGdxT2ZRM3hWSXpvdFMzV1ZuUURGbFY1T0Jn?=
 =?utf-8?B?THEwWmgydHBxSndlNVdGMEhVVlFMWTUxcTl4WUNiYWRqQ2hUSktCSkFPaDV0?=
 =?utf-8?B?aUlnbEc5YTZSZWE3ZVc4MlBnUU8wUGNXWmdSa2Z0QURFRld2djYxb25IRjFk?=
 =?utf-8?B?YkpSalVjRGlheFZna0FJOGxHYnZLUHFBMGFsVHRNa1JzanJ4L3NJWCtBODJy?=
 =?utf-8?B?VnFwb0ZSZm40cnc1NVB6dnhGd2c3Nm16TlRpb0p3Z2JhZTkzZllOTDl4Ym1y?=
 =?utf-8?B?K1gxODlRaWpjV1lqRXkxdG5POFZGRUxWdXJGV0k3OUkzeVJCRFFCL1pwVXda?=
 =?utf-8?B?MkdyY29VYUl6M0RURlpEQTMvb3BpL1pUR2s2bFZySjNNbG91ajdPK2kwYXNS?=
 =?utf-8?B?QzNKRzY2ekNBZFRKUi81d2h4SGxsOWlmMW1LSTN1M3J2dUtLbXdUWEVTSzNU?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d236b365-191b-4100-3538-08de10088cde
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 18:43:24.4103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fn5J69eDsHD9/6haZlAsJGEauP8giNorjnHrVfamu0xfV1E9LQK/+nnXPP/OlLdE0FGEtjucgQS0MJrBuT7LiJ+thrAzGw6C2oVHlxwpTdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7524
X-OriginatorOrg: intel.com

Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since pm_runtime_get_active() returns 0 on success, all of the
> DEFINE_GUARD_COND() macros in pm_runtime.h need the "_RET == 0"
> condition at the end of the argument list or they would not work
> correctly.
> 
> Fixes: 9a0abc39450a ("PM: runtime: Add auto-cleanup macros for "resume and get" operations")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-pm/202510191529.BCyjKlLQ-lkp@intel.com/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/pm_runtime.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -629,13 +629,13 @@ DEFINE_GUARD(pm_runtime_active_auto, str
>   * device.
>   */
>  DEFINE_GUARD_COND(pm_runtime_active, _try,
> -		  pm_runtime_get_active(_T, RPM_TRANSPARENT))
> +		  pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET == 0)
>  DEFINE_GUARD_COND(pm_runtime_active, _try_enabled,
> -		  pm_runtime_resume_and_get(_T))
> +		  pm_runtime_resume_and_get(_T), _RET == 0)
>  DEFINE_GUARD_COND(pm_runtime_active_auto, _try,
> -		  pm_runtime_get_active(_T, RPM_TRANSPARENT))
> +		  pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET == 0)
>  DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
> -		  pm_runtime_resume_and_get(_T))
> +		  pm_runtime_resume_and_get(_T), _RET == 0)

I missed the detail that these are named "try" guards, but return
"-error" on failure. In all the existing cases of "try" vs "conditional"
acquire the polarity is different, e.g.:

	DEFINE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
	DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T), _RET == 0)

So, while this fix is correct, I wonder if a follow-on patch should
change the naming..., but I cannot think of sufficient replacement.

Reminder for me to be vigilant about this detail moving forward:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>


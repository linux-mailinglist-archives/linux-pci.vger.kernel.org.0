Return-Path: <linux-pci+bounces-9792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C772592722F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 10:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CE41F21D98
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 08:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C105D1AAE04;
	Thu,  4 Jul 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iblt81Fy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC1E1A4F1A
	for <linux-pci@vger.kernel.org>; Thu,  4 Jul 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083254; cv=fail; b=LE5YGqnXxZSxGQwP4n1iDOwaS6z7H6usO6i0Lcu4u+LYh19rDKm2aS7xuCz0XEyT2AN08vupRTXQyN9QK2s1FR7I2T3jMyWRcyMiNbeE8Td82eYF7yAnm3aw6YXj8IQiRSWjcJWMnsbdisiAiZW3CmNS9LQBeiQg5Zt8lfVbJ6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083254; c=relaxed/simple;
	bh=Ezfn1t+oQlOxRpbc9btZRpuXsSG6kCCw5xv0egpsTdA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZeXjLQ40DEMvlpz0MK/GD2GpJQsxC8dQQcIXGssO3JHHxt1uXvy3/MjiPnYmIIQbbNosvB1CpfCcSp0iJULm90BIzZgN+vsKOVSmpH41CWlkpSEwOk9XEz8+VUhn+usaCSxUATlgXdg97eLb9hShgA900aqdpVwTd2xXZITPOx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iblt81Fy; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720083253; x=1751619253;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ezfn1t+oQlOxRpbc9btZRpuXsSG6kCCw5xv0egpsTdA=;
  b=Iblt81Fy/Nz5WLi4Zym8AqKYkbIeIkJOozLeBF9PMbIgFouXr4gUd7iO
   V+PaahwgdIXITFTkx5OSfVwT/eORoFbRScZMtPkLjYJ1gPTTenO5Emu0z
   4oPZ73mRxDGsQ+EobE4si6/HX1ozkHj7AJVnB7jlqJ68SdNIFLD5KRvK0
   9DKwTNqSIvF6Jl5BHPI2DmiYDySStBG+E9grnc0UK2HcIPEZgOw9nzBEP
   HC4FwEJwVg5Z3QIanDXNsWTzcdhly04Ae2DOxTkB0wl7S1oTEu0oQ5j8o
   DTzYhSaOqrYHsVXJaGT2+hvVYQWaYZuu0HgU4SjrQFcEQA053wABp/eqK
   g==;
X-CSE-ConnectionGUID: icjqqm4xRz2Jp3+8hOq/fA==
X-CSE-MsgGUID: wrqxK7ZZR8mRJ3KVL3YavQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="34888456"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="34888456"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 01:54:13 -0700
X-CSE-ConnectionGUID: ItwpSyqORDu6pdx43uxM+w==
X-CSE-MsgGUID: cPyeHR57TUecJD/UHAKlCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46604018"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 01:54:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 01:54:12 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 01:54:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 01:54:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 01:54:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmSRpykrwjQg/OocvuWldSP17+lsRln7GUUXayK8vREY6klw8wA12vjzCtyaLnLvbTDmjpGlE+YhsS53i8wUTj4vU7mLUzxOkRIsonqq+rBHXvZhPEW9LODRmsyGWo4E78OZdqFFxasIc6vKDMdV+XQO0XQC5QLusD7HHOLqzjKkAzx8dfifOKDfYUldPm1avTDDCGw1k8yzpyACedgnPAtkUkUBUy0A6xXE+wl4lQYid/pYlfhnL5qf3BRleFLEAlZfiacvaur3trwivJTquRsw9THhnEjrQIKKucIBDjEf+x+4RN9qTJOAwS5MMaGbPH7q1GtLxcT9twTSdWP00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXorYMAZJZ3aPWMZKem143vjteWopEyEHvFnTJUW5IQ=;
 b=badCeTM3LR/Oa7SjMZxUkP319nSmpxLtYO65QV47WV7xZYYHTXYMJaOATNO1aKL/4ssLJuxgO7AqdNTl8ZcE6MxPbreMXLnV/Wy0PVmnXNXaYS9fs0jvFEe4N/o4AKR9r/Wcrwv1ZRpxq6oT/06rgwWQyOX8sDGxW6VnJCx0M65/t7R47G3qME6/n0N5FOTqWBsTt4HhUjnswHb8VIbtoJcS0wdHGc1mrifRHgee6Apq7dDfbaVwt1E4bjjk7uhFKVdz8ATuvd530D0JV5w5TFyU9KF9POcJI0buIgx+Nc00+dSa9xPlLZs5eCXViaUpM254Fg52noW+ytyi19aBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 SN7PR11MB8282.namprd11.prod.outlook.com (2603:10b6:806:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 08:54:10 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 08:54:10 +0000
Date: Thu, 4 Jul 2024 16:54:00 +0800
From: Philip Li <philip.li@intel.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, kernel test robot <lkp@intel.com>,
	Abel Vesa <abel.vesa@linaro.org>, <oe-kbuild-all@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [pci:dt-bindings 10/11]
 arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: pci@1bf8000: reg: [[0, 29327360,
 0, 12288], [0, 1879048192, 0, 3869], [0, 1879052064, 0, 168], [0,
 1879052288, 0, 4096], [0, 1880096768, 0, 1048576]] is too short
Message-ID: <ZoZjKN1N8QfRYn7n@rli9-mobl>
References: <202407041154.pTMBERxA-lkp@intel.com>
 <20240704072006.GA2768618@rocinante>
 <bd96c9e5-9342-41b8-aa14-2db4828e37f3@kernel.org>
 <20240704073908.GA2877677@rocinante>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704073908.GA2877677@rocinante>
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|SN7PR11MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b7c033-d66b-4245-1415-08dc9c06deef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|220923002;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTJ0Vks1Y2hCQ1dxaTA2QWtjaU9vVkxtbms5ODVGd3hlem4vTURZSU4yMUpm?=
 =?utf-8?B?d3hlbDFNOHhtdE1XN2QwOHlVY3BRaWVaZHU4L3VyN1d6RXdrb3NyUmV1Y0dw?=
 =?utf-8?B?ZG5saExmQ243MVYwQVhrOFNISFdBc1prZjdzT3pxbE8rS1V6ZzBGNjZwVXJK?=
 =?utf-8?B?eHVJME5rNlZrZkdjbXBTdTgxTnJicisrVXg1cDQxTzBFb3p2V21UalJNTlln?=
 =?utf-8?B?V25MM2Z1QU82NUMxbmVwaXlTQzJtR3FoNUh4S1ZSNWZoUTlGMDlRZW55SGI0?=
 =?utf-8?B?cDVMZndTUE1HcFhzeWtuVkFyRnpmM3RaMnZyemVWcW5tQ1FpTncwVndHYWcw?=
 =?utf-8?B?TTl1WkVuWjJGc2tUSm1UMWI2a2laWThkcW5pcm02Rm0xRmhLRFFzNHhMN1dJ?=
 =?utf-8?B?aUIyNU1nMmpacG5Db3lzcWsrbTd6eFN5OURHQnMyeEJNLzl3RHYxejlJVXNw?=
 =?utf-8?B?a2gxaEtVMERPZXMrbWhMOFZCVlJoV285SnlTd3ppZG8xZUl0bUw0NlJldlFm?=
 =?utf-8?B?VFZWVVNFeHlqM1JjZ0FBMUlQTU4zZlEvaklid1JucGk3Y0crVUIyeTlPNjN4?=
 =?utf-8?B?Q1BHaFk4WEFqc0Y4dDJ3TnV6MnRTanFGa3IwUjB5T2FFeTNaRDBuWVJONWJM?=
 =?utf-8?B?QnZ4TnF2M3JhZnYxUWphWSs0ZW8xbGtrTHlHUU9XMzRscEk1d3loS1ZGbjFT?=
 =?utf-8?B?OExWR1VOa1BYVnlLODZaR2tDWkxGeVpCSkhQQ2F1b3JGeUNvZElZR0hwbHIy?=
 =?utf-8?B?T0I3Qm9pTnVOc0hBZER4amhKd3NqTVMwRERNVWlWeDUzQysvQ2NGdHRBUjlR?=
 =?utf-8?B?SVNtOTRpYm0rcjk0NlhmSTI2QkpOdGpwdnF0SkRya0U4b1BoV3J5MXRwUjZ5?=
 =?utf-8?B?VW9WUHBhdlRHNXVHTXRoWGppZGVhcElKcGRQNFhJZjJlUDVpUmhYbyt5SzJK?=
 =?utf-8?B?VE8zWWtPVU95dXZUc1ZuSlNvK2JzNEVQbFJlaEtjcFUwWTNBQTRsS2Y5Y2E1?=
 =?utf-8?B?ck5uZEhJUTR0NXVqc08wOWNrR01UNERnZ2g2SzNUUlNjQnNOTlF3RE5YdWJj?=
 =?utf-8?B?R3ZGK0tKVlFVRXgwekE2S1hVemgrMTZQOXB4THpLdDBwbmJUWGY3S0JDVkxL?=
 =?utf-8?B?SC9NcWI1REkzRVdRekZqSVNKcnoveGE1Ky85b2NMS2swSU54RG9pY2NubGd4?=
 =?utf-8?B?VHhNdFhvMENYZGxRaEVrOWpVYndMS1VCZGh0bHduWFBUYWpUNXVQZlFKb2M4?=
 =?utf-8?B?UUZGTys5SzFpUUZpaXJxUGZNL0pibHhVdjRZZlpZYUQwbERCTXBONnBQYXd3?=
 =?utf-8?B?RHFPRUJsRmpjUTdmQkQvZkFVWUQrR25kWm54TkhVc2Uwc2NIQ2VlVEJIMW5W?=
 =?utf-8?B?dXBBUnRMaEpuelQrcjV0WE1TaUZrckYxWnhNRjdQL1lDNktOaHhTVk1aNnFi?=
 =?utf-8?B?d2lsTHlxa2NyMlpKM3NNa1dhWVpCbVdJdTUzNHhPdGt1Yit2d2N6b1lzeGF3?=
 =?utf-8?B?MktlZnJZS1p4UXJYK0MwRGU2MjlVQVdYbDZiMytQeSt5dVBvOXZNNmVNd2NK?=
 =?utf-8?B?enJ6dHR0eHlhYXZMV3ZQMXFWNnRoOWpCeWl6aWdJekhwUGQzRUw0Vk5aMEJu?=
 =?utf-8?B?QUoxK05aTXBiVFBFWjR0WGM3dHFVaVRnY1gyeDdYN3BXV2FkL2dpWjlUWHlN?=
 =?utf-8?B?bDdBcnRrMHZKZHBuZlRVdDkxWk9LdVQrTUpSL1pFWmc3ajFVb1NTcTdBOE93?=
 =?utf-8?B?bUg1cHFaZVhNbmRrS0FLVDF3UWRxaS9CUDRFSFdzTEdDdnFNdDlHNXVrcGdS?=
 =?utf-8?Q?LwkUvb+8WdO1wusQUqdJXLtaA3Q5qeJkh7JJU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXlBVzVMTVc2K0NxSDI2NGFPZnZYNEN2Y2djOFIyMFJDekV0OUpFb00yeHZj?=
 =?utf-8?B?SlI1YlQveUI2NlNDSWwyMTB6alNFaFhKWElscHJQaS8wWEpseSszMEZ1L08z?=
 =?utf-8?B?RDhZOEx3R1RpcXBtUVhjV01WeHhRY1orQXhIT3Z6Q09DQUZCK0tYcnRKeUtO?=
 =?utf-8?B?UXJZZklYNFA5QmtSSVpqelZqMExPdXprYjVaa25yU1ppZEZNL3FIVDcvZEJX?=
 =?utf-8?B?V21DVmlTSHNMMVoyN0tPdGpwTUQrSWlpb3lSNEcrZnFsT2VRbmo2Ynl4aFlt?=
 =?utf-8?B?dlZUVUR0bDFNL2lqR0Z0Q1pVamIrRXVZeFFYdklYT0lVTStDWWo5b25XU0tK?=
 =?utf-8?B?RjU0RHpHL0dac0tzMm8rZ2Nhd0wyZUk2Y1M3ZXY4MjFFMWFSTW8rLy9RaFlC?=
 =?utf-8?B?c2xUWCtmT0V3cjNnQ1dJNUY4d3NVNzBUS24yZ2sveDRmdXBGWS9USFZJdFZC?=
 =?utf-8?B?ZTJtTUpCYnhmK1VNVkZYZXNraTlCMWVjVGNjTjc2d3dkUTVXa0RzSkxMcjR1?=
 =?utf-8?B?K1MvZHFqQmx0MGtQL1hBUGhvdzZvMmZlak9RTUpJcWwzNzg4N1JVR0Y0Tldu?=
 =?utf-8?B?NUJiYmVGa0ltMGc0QTlRYlpQcjVlTXVqRllneHJ6N3BGS053aXhybHZReUFJ?=
 =?utf-8?B?ZittZkF3aFdvTEZCZ21SOHVYaHdHUFlCTk1RRCtYNThIR3B6R0o3L1dNQlgw?=
 =?utf-8?B?OS8vbDArYXZMNXVQa2tJRW9iVERXcy94aVFsK1A2dHRlVlJkTlNGdHNhTGpG?=
 =?utf-8?B?YUxlcFBWMUorSFBPSDlzK3RnL3dqOW9RS09zU1htV1lORGhPTFFsVmFjRnRh?=
 =?utf-8?B?UWNtc2tYNHZwZkU4MWVvUFViQTU1ZzZDYnJoRDNxZW9HV0dDa3plZGo3NGxR?=
 =?utf-8?B?STBISHFYeDk0QkRHMFJiSlg2bnpxOS9sMGZhb1hBV0Y1UjV4bDA2dloxZVNS?=
 =?utf-8?B?WWNjeUw4ZkdaaG5xTW5xU1p4NGpCbEVSQlFMRkN2ZU02NHh2emRWOXI0K1JJ?=
 =?utf-8?B?TGRvQ2J4NyszN0o0Wk41dCs5ZFRyaldJMFpNYXlnUVA2c1d0MzFldXdGOWgv?=
 =?utf-8?B?aGxVdmVnOWhCN2FXRjRwcXBPSG1McTNncGdtTm5DaVYyb2puYjdNTFd2UnBE?=
 =?utf-8?B?eDQySjR4Q0cxQXRjQXhpUVl4U2JSR0k3S1pXZmw1Y2ZRSFpuTkl5WVphNkJP?=
 =?utf-8?B?UWpydllTamtNRnhnb2pkdUhONVlSU0ZBbXJ4akNtb1lmMlN5YllDUzVWQVpQ?=
 =?utf-8?B?WktTdGQ5dkNOYmc5SkRRSTVyc24xbitGRUlLRFlvSURFWUFJQWxLb1pteFQ0?=
 =?utf-8?B?U3NTWEgvR040VndmUnJnSjhRclc2cEpNZ0Z1bzg1REpLVGlLL2Nhb3dSRzZ4?=
 =?utf-8?B?SEFXZDR3NVVNMy9yK2dhZTZRQ3FnOG5MRTc0ZHN3SUFPYm9jcXBEWXc2Tndz?=
 =?utf-8?B?cnFKRUFxcUhmTmp3OGNOR2JIQis2WWRSenQwQWs5NWlKUmFqamZobkxnMmJz?=
 =?utf-8?B?YWlwNFdGRCtrN3Y5N2c5d2VHRjFtaGV3cEtWOU5LMnVUeW9ISktWSitqQmdz?=
 =?utf-8?B?c3JCU1YvaU82ZVJwOHYwVGdiN0UvT0NLVTdqdk9HM1U2bHhqV1JZaFlPekJk?=
 =?utf-8?B?SUN0R1gyZFpUMXdNQWxhMGxoSXVqSkQ0VmNBKysxS1RTaEo4NUg2MUZYdHFw?=
 =?utf-8?B?RjZnZ0RrVW9rTmNiKzg1MDkrV2ZwbVNHbkNFYU9ZMHZJWnlHNHRVUlpiRDFE?=
 =?utf-8?B?RGpYc2RiSDhTb3BCamcxQXUzRjhmMm93bVhmNTIyN2RhWWdSRzE0UllvK1Mr?=
 =?utf-8?B?a25NRXJGS3NkRHgrWlBQdlJsZHgwOVZzZktYZFpJR21qT2FaaGxGSFZxelZt?=
 =?utf-8?B?dGNaYkp4YUJJa3g1VmtkaEtYSEc1eGN6ODVBdklHaDhUSjNabVdONktTNXZ5?=
 =?utf-8?B?UVJxSC9pWDNKSEp4TEhxRklWSDRGaXg0bHgyYkNSTHBXZzkwWnptdjNvREw3?=
 =?utf-8?B?QzJvczJRSUo2ejh2NEp1b1czaEJxT3JvL0NsTllNd29QbDZCaEFrVmZHYkho?=
 =?utf-8?B?SmRZVTVKVFJIQTZnbmYyZURjamk4RVFFUWdBa2VlWXYvNGZuL2VtVEFVMWpT?=
 =?utf-8?Q?R5jei+779oaqcEa/aiKC3aeQu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b7c033-d66b-4245-1415-08dc9c06deef
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 08:54:10.4336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMm0/ld9sRpBfxshwKkFPMxBhwbBrIY52Yd+yj7PnVtTtkjC0zMw6L8+wj1Ax0HqEi/a3z8SDSisY8LJGgjzIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8282
X-OriginatorOrg: intel.com

On Thu, Jul 04, 2024 at 04:39:08PM +0900, Krzysztof Wilczyński wrote:
> [...]
> > > I removed this patch from the dt-bindings branch for the time being.
> > 
> > 
> > These reports are useless. I suggest ignore all of them...
> 
> I see.  Just a lot of noise then...

Sorry about this, we will skip these reports in future as discussed in [1]
to avoid false positive.

[1] https://lore.kernel.org/oe-kbuild-all/ZoZhvjDsHSHtvpP3@rli9-mobl/

> 
> 	Krzysztof
> 


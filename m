Return-Path: <linux-pci+bounces-16426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351AB9C386B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 07:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587D51C22297
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 06:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD34155742;
	Mon, 11 Nov 2024 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXNs2BDr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F31553A3;
	Mon, 11 Nov 2024 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306834; cv=fail; b=MzfW9vdPdp5wwxX1DDVt30zKoQlmRPK34+tRFLaZzJ/yMzxrcNIMyXrCzLNVcjRtHGVHUpIdtoLUyGpgtRkn85xBq/TNlVKAMt3c0JMeROntIO/4RdLQZo22S4cvlOUnT4EP1CpncY1YKPa8D5WAFLOz6Lz67nellpZjUzl8V4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306834; c=relaxed/simple;
	bh=E9HupVdAb5tpl3Yo0eo6TS+3HzKBQQ295y3ax1xwo/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J+Y/xdAVZU0Y0yNJa6N2QvG9dKdXlGo5dJZXuf9HitxSVCoCrdITxWeWgZp8eXEQV/ErHlWGx0N/Yi0LJGCOMvcuWff4JD/9Q8cvWJ1WObWcBC6I3eaY4kbr8trMIzgMqejtpGwyvG43QCJMYIKsXspQY5NGd57vW7hqeH1Weso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXNs2BDr; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731306832; x=1762842832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E9HupVdAb5tpl3Yo0eo6TS+3HzKBQQ295y3ax1xwo/0=;
  b=MXNs2BDrhut8t9Ahy/0VGsWLTXYqZnxw5QSPf4IRnQP5Q+982GbMvyqo
   0JdtkYULWVQuaApbTcQeerrBvvQeom/IHOx+Lckk3O42DCCjtoI5FVPu6
   uL5KvA7rk6YPAjKMKjiLKxzfRRDUSaq1uGSfs0LL54lthF02UndEyU99z
   Ix82hizF1aUsvN2yrQlAtH/FQmyURDV7oBtPc0UYmOp6RevLhBhwxKfiD
   LQyG+OGFVMKRafT715IaGOCtzce2KNYvmmGZg2RakNS4k7+aAnVKTKqCk
   gGqS/9FxwZVuIO/VvWxIkfklAan+x4gPds0Kxbdmn0TaPUUUsIJObueIB
   Q==;
X-CSE-ConnectionGUID: iHojSQB/QK6/GWVvkBVZOg==
X-CSE-MsgGUID: 57hjO+DKROuPn2mTrN/J+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="33964909"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="33964909"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:33:51 -0800
X-CSE-ConnectionGUID: BT7YXBmZTjCYUqTv1Pfu2w==
X-CSE-MsgGUID: mFUEmJU1TNOJBrb7CU3PJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="91683861"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2024 22:33:51 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 10 Nov 2024 22:33:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 10 Nov 2024 22:33:50 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 10 Nov 2024 22:33:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9p1H0tsjvm5BmOQ01vXiCxVpaJIKWK/LApRsCVZlwUztq2gde7Gq5YYaREUYWwF2yWAePg4Tl9GQCv6/TGg+md0kA8lk45S6FfOdjJixEuXxiTDw+11t+7IPbAM5KFhT13mLxWmllYUluz0uVP6KZxJxalv0Y/uqAUx/6sz+J0klQv91bODbG7x6FMKVLfraWobWlXI6W6X8FSERGgolb2ar6cEhuuizgRmjD2m53h7V56Un5JSvGJPb9xLk549+SRLMD+SQAiXkD7fCXtGWar51BYTKUEpiMxR+PPBizBeBaw4wsIi6GchjrVWzWgxrfC7CB0hPUwDLOCnyGacBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9HupVdAb5tpl3Yo0eo6TS+3HzKBQQ295y3ax1xwo/0=;
 b=o4yeELEctqu5iitKLjzr/UI3FnivOOjAAt/HIHIivQbFvXT9ZGRr6V4xafRVfMSuart3xS2TcHJ+ov7Nc/1JmZzZj+zcnPXnh4u2+fleO+LAn2UHbeKAG2qmyouFveQfJZqDy8YXHhO70zPXv0LKZUxbwASQsGlVbywH17rqK3slydSO80+Pu64tA6672Se+pNW5aYiYp+9Wl/Ldl0IEOf+O+nbjonBKdmTL9+S6fpg9IUydq+pFrtbhxaAnxRtscxh8kQVLFyeHY/dSk4+LDrrYut3pmys7bWt9E5i3uLHVS0gRbY/+Jni7Z1y/fMkAN1/W/kM9JMZ3CzuuPi4GNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5952.namprd11.prod.outlook.com (2603:10b6:510:147::7)
 by IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 06:33:46 +0000
Received: from PH0PR11MB5952.namprd11.prod.outlook.com
 ([fe80::b961:2a71:c5e8:460]) by PH0PR11MB5952.namprd11.prod.outlook.com
 ([fe80::b961:2a71:c5e8:460%3]) with mapi id 15.20.8137.021; Mon, 11 Nov 2024
 06:33:45 +0000
From: "Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "K, Kiran" <kiran.k@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2] Bluetooth: btintel_pcie: Support suspend-resume
Thread-Topic: [PATCH v2] Bluetooth: btintel_pcie: Support suspend-resume
Thread-Index: AQHbMbvIxage3zLxU0CexpI7qMWqbbKtGv4AgARgZCA=
Date: Mon, 11 Nov 2024 06:33:45 +0000
Message-ID: <PH0PR11MB5952C7090EAA4F6B75145611FC582@PH0PR11MB5952.namprd11.prod.outlook.com>
References: <20241108143931.2422947-1-chandrashekar.devegowda@intel.com>
 <693d09b6-edab-4ed4-8df5-11ca74bb02e6@molgen.mpg.de>
In-Reply-To: <693d09b6-edab-4ed4-8df5-11ca74bb02e6@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5952:EE_|IA1PR11MB6170:EE_
x-ms-office365-filtering-correlation-id: 0e1e934a-5e8c-413f-8f24-08dd021acb40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aXBXRkFhNm5sK2UvRW9NV3o2QnRFa3BUMFdmVFVjcm9rT0NqSVJjeUlEWld1?=
 =?utf-8?B?UXpZa2VDc1c5Rkd6SnpHdWY2VUs3OU9WbDNxcjZwV0c0UUFPQVA3YnArcUJX?=
 =?utf-8?B?cnladVh2RjRNT20rcVltZzd2eXh0OE5vNFhPWGZjYzQ4VHgrUXEyUGxJQjNn?=
 =?utf-8?B?VVp3Q1pXeDBZdFJtRnhqVWIyMDRkNHQ2WVZsUXBzek5PcUtGRDRpWGJNMDRn?=
 =?utf-8?B?dVhpUUlab2J5eHA1d1FWUmdLUDl6am9FbEFUOGp2UTU0bFVMT2Z0dWpBMytK?=
 =?utf-8?B?dEVmSDJPRVpRbGpWMTNjSmtVSTl4UU9PMnp5TTVkQndIdk5ZRFhqZHdJWXZD?=
 =?utf-8?B?d05FT0ptcVZKVHc4VEF4SmFzcEJqNTZhc0wwU0xWRm10RjBudlZNRmppOXh2?=
 =?utf-8?B?L21iaWpqYXN3OGNRYVJ5aysvVTdNSkdPb3YvSkFOdE1WempKWjQyaXBxem14?=
 =?utf-8?B?eERlcFF3UHA1N1U4WjM2Q241cmFBeldtYmlkME1FbVBPUDgzblJpSDUrSU1B?=
 =?utf-8?B?anF0NUkxbnNxQW4yT1NlczFrTjNoWnpwRDN0ZHc5ZjhTNDY4clBYNnYxYysw?=
 =?utf-8?B?Q2NHTEhOZUlRSk00ZzZrVEVqaUROalZoNXBRSFpiK08rL0NFQ200b3prWmNa?=
 =?utf-8?B?YXhMSVdqcjUrTzZrNVZPUGhDODNWYlBiOXdXMUZiam9XVzgyRGtUbk9QU0Jk?=
 =?utf-8?B?ajZwWERIS2plTitsTmxnOUpBUjViZUh0U3QzRFJzL0h1NXVLMERFSlNTNjRm?=
 =?utf-8?B?Y3pyU2xCUVBxeW4xMSt0U0NxanRLc04yMk42Y2IxTDRIK081QU5sRWplNjRW?=
 =?utf-8?B?L2ZiUGtQN1p1MTdkeXJoUTYzUVJUYXpTcmJZRFFFeWNvNFJZMGdrZmZISWdi?=
 =?utf-8?B?Yy9TKzhiTzc5dnVCeGtFUkxkNU9pZ3QwaGZxZ0hvTTNrQTF0TGsrRkx4Qkg0?=
 =?utf-8?B?MWVUbzVaRFpjTHVXaG1MbG8wQmlzU29WbEtVb3hlUktiZjhlV2ZwMTAxQ2tj?=
 =?utf-8?B?UXltSUk1bjR6d09vSGlBR0w2aG8wRGJJNnY5Y0NwZ0pKRWdEeEFWL0pNZjUw?=
 =?utf-8?B?ZFJqQ0hJQ1htSDFNN2pYcUhhaEV1L3RoTXhEc0VtUng1b2RvS2NXODQrQklR?=
 =?utf-8?B?dm4wOGd0aUVYcXNlMS9rZFAyMU9JS2hlRFAxVm8zMGJKTjBEMVhSVHoyR0Nv?=
 =?utf-8?B?VUhWNmRDN1FQaFVZazVpU3BibnprcHBSRTU5RWlKdTlYYUNpb0RPa25waVhZ?=
 =?utf-8?B?NWhuNnRWV2Y5djBTSkpVVVdHb2JIdzVzbnVPdXR3R0Q5UVlXb1gvM1NZMERS?=
 =?utf-8?B?QTF0RU4vNE9YUElIdG0zUi9pb2pSeW4xejgydXNmNW9OVS80T25vUEJ5WGJy?=
 =?utf-8?B?MzJhQUhhTGUwSjZWbUZFdXJRdGFrRnlHVVNJRStIbENEelluNGJ0UVk4SHUr?=
 =?utf-8?B?cXRZa1JkalFrWDY5NFMrM0lkZFI3anJvcHRQdDRnNG1Rc0hvTUVjYStlOU45?=
 =?utf-8?B?WlhlM2pDNFhnUTk3RFlwdCt3RFdPWGJQMUQyZEI2Y0VwZUJ3d04wN1JHcXdX?=
 =?utf-8?B?U3VBODF6OFBaL1lkaU1uV3lCZks1OUJvZ3RDdHo2VURnU0xzLzEzOElUUitq?=
 =?utf-8?B?VGp1QmY4MGZ1NHViaTVJSndsalBhZWR0WnRIR2o5MGJES3ZzS0s1NEhQbStj?=
 =?utf-8?B?MDZEVzlTUFhKV25vRjl6cExrZjVRa0dvbEI1SStTaGdiT1hEVFFsYWtvWFpX?=
 =?utf-8?B?amM3ejEvaGVSSlV6OWRIbkNRZGN6MldPVlVDOTNWQlRHL1QyR3R5SUhwRUpN?=
 =?utf-8?Q?IPyVu/ME43fUtVea+t1zQ9vaXGB641nga8/Pw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5952.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nkx0bGVPd1VXY3NWWE52ZWFPdjNPbWg5eWZCalFlMU4rRG5aZkxKRldjS21l?=
 =?utf-8?B?OTZtWG5INnVQSEZodTFKalpMTjByYk1JaDcwdDVXT0pLN2lkMTJaRXNMSzd6?=
 =?utf-8?B?MmZjMUZUQU0xVC84VjIxakNoa3o1MkZrQlkrSnpzbkRreU5WMzBXdTR0UGx0?=
 =?utf-8?B?MzNiWjZLQkhCMURDTEN4cUVxQ0JHY2l3a0w0OUFhcEJCRE1Ud25zSnhjSXRN?=
 =?utf-8?B?ZzVzNXp6eHVvSHRrRUEyTVFpL2w4bjFubnpBNCtMRjQ4VTB6RVpSeGI3dkdK?=
 =?utf-8?B?emJxWjdwNHpEejcrOGtybldCMkFXRVlwZDdwY3JmSmxNYTkxU2c0WTQzTXZw?=
 =?utf-8?B?YXFJaXhkamFsZ2ZjU1d6UHJ5OU1xb1ppU05yMDdUQkQ2THhVOEcxN1ovUWFk?=
 =?utf-8?B?eFg1RGZzQ1lGRE1xdFJaU2ZvWXZjREU1OWdFUWxjcGJmU3BQR1pCc2tuT0J1?=
 =?utf-8?B?N2NpWXREWURkcm1aaGNXcVMrS1dMbDYyWW1KQ1ZxT05MQnMzd0lDUG9sY01s?=
 =?utf-8?B?UTZhVzd5NHlVdklDNnR3WTVXTzBQeGd6cXRHaHdzRldEN1pXR1R1Rkg2Unl3?=
 =?utf-8?B?NktkcHQyRm9rVVhPbnBtWlVhaUljQkJVSm0xSDVnQk1senZibmJyS2c1d2pP?=
 =?utf-8?B?M3ZJSWJtMzJRc2J6bFpKOURlL3p2MllDc2VRSlZLR2VBWFN4WVBuZ0N0ZGha?=
 =?utf-8?B?QjZtZDZEZ0dqbVZlM1VPd2dpeDlpUWhraDRzejhBNHlHSTJlMEZWbG5RTDhq?=
 =?utf-8?B?YXZBK09kWWx0WURycTM1TVRMeFBSWk1DNVFqZjJNVVV4Q0FCaCtOYmVVWld2?=
 =?utf-8?B?dGV6ekVpOXE0LzdHUlVjeFdIUU1jSmtlWWJYWGdGWTlLUEFFMHFoaUVPd3hk?=
 =?utf-8?B?a2ppcFo4NzIwMGNOaDlwSXlIalZXcEN5cTg5VjBYazV2T1hRdjhCTXB3VGV5?=
 =?utf-8?B?Tm5raWUyS1kyVzlEcEUvVXRycXFSTnYyQW92aXkvbEd2SUhnTkNZZ29mL1dP?=
 =?utf-8?B?OUFsUlg5QUhCY3pxMnRxckRoQTBwd3orZFlHRE43SVhUeGJOcWxiUHZzL1hT?=
 =?utf-8?B?a3poSUpzNERnNStiUk5Kd2MzM1hHdE9LSXRXWlF0ZVo1bHpWVFZiWmR1Unh2?=
 =?utf-8?B?ekRNQ3V5Tm9YbStmMlhYTHRRRGZQSSs2czZkR21uSHRrT25IeWQyL3RsTjFO?=
 =?utf-8?B?ZEQrWTJENkVTa0UvdkhPaEN0UzhGajkzRkJMbmlSM2dIZEVyam5kVEszYnhp?=
 =?utf-8?B?YVAwWFZzYVBXRFRteEdrenhrWjJ4MmxrOWpTUndUNHRyVVhUMURDZVRhNnlp?=
 =?utf-8?B?RmpYbGFOWlpIT1FpWStLaWJubzh5UXB5T3FUdSs4UVNPM2V6bGJ4OEZ3NmZZ?=
 =?utf-8?B?UmplU0xnczQvUWxtL0hNWTNJK2VLOVQ2U29hc1dqNGZ3bEZBR1gwNEVkM0RG?=
 =?utf-8?B?SXROdzBYQVVySFVmcEdRUTVZc1lqM2hxSzF5R0Q4c3UyaEN0c051QVZFdjM4?=
 =?utf-8?B?TGxoTEJmNjEyYUk0WERDWm5heVJvcFFvTW8yQXdDS3dSSDZISjM3MWcrWWhn?=
 =?utf-8?B?V284VVVPMFNyaTVmVmNrdlJMdUF5WGJ1bFJDYnd3dzBHQkxLYkFzSDhwVlRp?=
 =?utf-8?B?UDhWNGpqSVA1OTJreXRySWFuOXdsOEpkV0lSaEVPdWE4Y0Z2RTRPcDZhcnZB?=
 =?utf-8?B?YStGZTJFc1kvaTNOQ0loZGlGZjBWTFhYWjJHVDJGdXlpZHJQb21Ca0hqSFMw?=
 =?utf-8?B?MHV1bE9Ta2lMSHZPRnZMN1k2TXZMMm00Z0g5WUoxNWxIM3R3S3JMdmplM01o?=
 =?utf-8?B?eWR3ZHoxSlozMi84V2Z4eHNERXlYcGJQOURKNWhPZEZnYkVKV1BNSXhhRkRp?=
 =?utf-8?B?WnN4SHluUCtvd2VwVmlmMm82cnpONUgxM3V3dlVPeVVBSi91MGZWR2J1bThr?=
 =?utf-8?B?Z2ZLKzV4Q0YyaTQ2WDE2WHl5QzBkOWJNRmZtcmQ4T3hOT3lvRVRxSmhMTGlF?=
 =?utf-8?B?aVZPVWROVlIvWDkxZ0Z3UTVHOU5wQ3lHTHRCL3dyZThMVkpGb001TnEvMVNL?=
 =?utf-8?B?YmIyRU9Ya0tBV2o4R2JmN01zcG9JNmhYQk1PUk14b25McTlVVm5jbVFreFVi?=
 =?utf-8?B?YmxLQ1V3K1pFS3pXcXZSamdFVk1sNDJvaCtCbTk3SCtubncrbUpXTXRwVTV5?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5952.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1e934a-5e8c-413f-8f24-08dd021acb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 06:33:45.8800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhl7bGJDsjNG8/TmVnOyFXoorzHb8jwX70zzacResv8EVKdmuVRYnj4Ip7utZqrprVIkaEOQDecqbJ1aUjBmke7SlX5mF+6nM8c4DdcnzQGOGA9mkZY2u+djOkBN6QLs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6170
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCiAgICAgVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLA0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5t
cGcuZGU+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMDgsIDIwMjQgMjo0OSBQTQ0KPiBUbzog
RGV2ZWdvd2RhLCBDaGFuZHJhc2hla2FyIDxjaGFuZHJhc2hla2FyLmRldmVnb3dkYUBpbnRlbC5j
b20+DQo+IENjOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBTcml2YXRzYSwgUmF2
aXNoYW5rYXINCj4gPHJhdmlzaGFua2FyLnNyaXZhdHNhQGludGVsLmNvbT47IFR1bWt1ciBOYXJh
eWFuLCBDaGV0aGFuDQo+IDxjaGV0aGFuLnR1bWt1ci5uYXJheWFuQGludGVsLmNvbT47IEssIEtp
cmFuIDxraXJhbi5rQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gQmx1ZXRv
b3RoOiBidGludGVsX3BjaWU6IFN1cHBvcnQgc3VzcGVuZC1yZXN1bWUNCj4gDQo+IERlYXIgQ2hh
bmRyYSwNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHNlbmRpbmcgdGhlIHNlY29uZCBpdGVyYXRp
b24uIFBsZWFzZSBhbHNvIGluY2x1ZGUgdGhlIHByZXZpb3VzDQo+IHJldmlld2VycyBpbiB0aGUg
Q2M6IGxpc3QuDQo+IA0KDQpBY2sgaGF2ZSBhZGRlZCB0aGVtIGJhY2sgaW4gdGhlIENDIGxpc3Qg
YW5kIGFsc28gd2lsbCBhZGQgdGhlbSBmb3IgdGhlIG5leHQgdmVyc2lvbiBvZiBwYXRjaGVzLg0K
DQo+IA0KPiBBbSAwOC4xMS4yNCB1bSAxNTozOSBzY2hyaWViIENoYW5kcmFTaGVrYXIgRGV2ZWdv
d2RhOg0KPiANCj4gVGhlIHNwYWNlIGluIHlvdXIgbmFtZSBpcyBzdGlsbCBtaXNzaW5nLg0KPiAN
Cg0KSSBoYXZlIGFkZGVkIG15IHNlY29uZCBuYW1lICwgbXkgZmlyc3QgbmFtZSBkb2VzbuKAmXQg
aGF2ZSBhIHNwYWNlIHNvIHBsZWFzZSBjb25zaWRlciBDaGFuZHJhU2hla2FyIGFzIGEgc2luZ2xl
IG5hbWUuDQoNCj4gPiBUaGlzIHBhdGNoIGNvbnRhaW5zIHRoZSBjaGFuZ2VzIGluIGRyaXZlciBm
b3IgdmVuZG9yIHNwZWNpZmljIGhhbmRzaGFrZQ0KPiA+IGR1cmluZyBlbnRlciBvZiBEMyBhbmQg
RDAgZXhpdC4NCj4gDQo+IFBsZWFzZSBkb2N1bWVudCB0aGUgZGF0YXNoZWV0IG5hbWUgYW5kIHJl
dmlzaW9uLg0KPiANCg0KRGF0YXNoZWV0IGlzIGludGVybmFsIHRvIEludGVsLCBzb3JyeSB3b3Vs
ZG4ndCAgYmUgYWJsZSB0byBzaGFyZSBhdCB0aGUgbW9tZW50Lg0KDQo+ID4gQ29tbWFuZCB0byB0
ZXN0IGhvc3QgaW5pdGlhdGVkIHdha2UgdXAgYWZ0ZXIgNjBzZWNvbmRzDQo+IA0KPiBQbGVhc2Ug
cmVtb3ZlIHRoZSBzcGFjZSBpbiB3YWtldXAsIGFuZCBhZGQgYSBzcGFjZSBpbiA2MCBzZWNvbmRz
Lg0KPiANCg0KQWNrIHdpbGwgY2hhbmdlIGluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNo
LiANCg0KPiA+ICAgICAgc3VkbyBydGN3YWtlIC1tIG1lbS1zIDYwDQo+IA0KPiBQbGVhc2UgYWRk
IHNwYWNlIGJlZm9yZSB0aGUgc3dpdGNoIC1zLg0KPiANCg0KQWNrIHdpbGwgY2hhbmdlIGluIHRo
ZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNoLg0KDQo+ID4gbG9ncyBmcm9tIHRlc3Rpbmc6DQo+
ID4gICAgICBCbHVldG9vdGg6IGhjaTA6IEJUIGRldmljZSByZXN1bWVkIHRvIEQwIGluIDEwMTYg
dXNlY3MNCj4gDQo+IFRoYW5rIHlvdSBmb3IgcHJvdmlkaW5nIHRoZSBsb2dzLg0KPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBLaXJhbiBLIDxraXJhbi5rQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBDaGFuZHJhU2hla2FyIERldmVnb3dkYQ0KPiA8Y2hhbmRyYXNoZWthci5kZXZlZ293ZGFA
aW50ZWwuY29tPg0KPiA+IC0tLQ0KPiANCj4gSXTigJlzIGNvbW1vbiB0byBhZGQgYSBjaGFuZ2Ut
bG9nIGJldHdlZW4gdGhlIGRpZmZlcmVudCB2ZXJzaW9ucyBiZWxvdyB0aGUNCj4gYC0tLWAgbGlu
ZS4NCj4gDQoNCkFjayB3aWxsIGFkZCB0aGUgY2hhbmdlLWxvZyBpbiB0aGUgbmV4dCBwYXRjaC4g
DQoNCj4gPiAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jIHwgNTgNCj4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50
ZWxfcGNpZS5oIHwgIDQgKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDYyIGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUu
Yw0KPiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+ID4gaW5kZXggMmI3OTk1
MmYzNjI4Li40OWI3OGQzZWNkZjkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgv
YnRpbnRlbF9wY2llLmMNCj4gPiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUu
Yw0KPiA+IEBAIC0yNzMsNiArMjczLDEyIEBAIHN0YXRpYyBpbnQgYnRpbnRlbF9wY2llX3Jlc2V0
X2J0KHN0cnVjdA0KPiBidGludGVsX3BjaWVfZGF0YSAqZGF0YSkNCj4gPiAgIAlyZXR1cm4gcmVn
ID09IDAgPyAwIDogLUVOT0RFVjsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBidGlu
dGVsX3BjaWVfc2V0X3BlcnNpc3RlbmNlX21vZGUoc3RydWN0IGJ0aW50ZWxfcGNpZV9kYXRhDQo+
ICpkYXRhKQ0KPiA+ICt7DQo+ID4gKwlidGludGVsX3BjaWVfc2V0X3JlZ19iaXRzKGRhdGEsDQo+
IEJUSU5URUxfUENJRV9DU1JfSFdfQk9PVF9DT05GSUcsDQo+ID4gKw0KPiBCVElOVEVMX1BDSUVf
Q1NSX0hXX0JPT1RfQ09ORklHX0tFRVBfT04pOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgLyogVGhp
cyBmdW5jdGlvbiBlbmFibGVzIEJUIGZ1bmN0aW9uIGJ5IHNldHRpbmcNCj4gQlRJTlRFTF9QQ0lF
X0NTUl9GVU5DX0NUUkxfTUFDX0lOSVQgYml0IGluDQo+ID4gICAgKiBCVElOVEVMX1BDSUVfQ1NS
X0ZVTkNfQ1RSTF9SRUcgcmVnaXN0ZXIgYW5kIHdhaXQgZm9yIE1TSS1YIHdpdGgNCj4gPiAgICAq
IEJUSU5URUxfUENJRV9NU0lYX0hXX0lOVF9DQVVTRVNfR1AwLg0KPiA+IEBAIC0yOTcsNiArMzAz
LDggQEAgc3RhdGljIGludCBidGludGVsX3BjaWVfZW5hYmxlX2J0KHN0cnVjdA0KPiBidGludGVs
X3BjaWVfZGF0YSAqZGF0YSkNCj4gPiAgIAkgKi8NCj4gPiAgIAlkYXRhLT5ib290X3N0YWdlX2Nh
Y2hlID0gMHgwOw0KPiA+DQo+ID4gKwlidGludGVsX3BjaWVfc2V0X3BlcnNpc3RlbmNlX21vZGUo
ZGF0YSk7DQo+ID4gKw0KPiA+ICAgCS8qIFNldCBNQUNfSU5JVCBiaXQgdG8gc3RhcnQgcHJpbWFy
eSBib290bG9hZGVyICovDQo+ID4gICAJcmVnID0gYnRpbnRlbF9wY2llX3JkX3JlZzMyKGRhdGEs
DQo+IEJUSU5URUxfUENJRV9DU1JfRlVOQ19DVFJMX1JFRyk7DQo+ID4gICAJcmVnICY9IH4oQlRJ
TlRFTF9QQ0lFX0NTUl9GVU5DX0NUUkxfRlVOQ19JTklUIHwNCj4gPiBAQCAtMTY0NywxMSArMTY1
NSw2MSBAQCBzdGF0aWMgdm9pZCBidGludGVsX3BjaWVfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2DQo+
ICpwZGV2KQ0KPiA+ICAgCXBjaV9zZXRfZHJ2ZGF0YShwZGV2LCBOVUxMKTsNCj4gPiAgIH0NCj4g
Pg0KPiA+ICtzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4gPiArew0KPiA+ICsJc3RydWN0IGJ0aW50ZWxfcGNpZV9kYXRhICpkYXRhOw0KPiA+ICsJ
aW50IGVycjsNCj4gPiArCXN0cnVjdCAgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsN
Cj4gPiArDQo+ID4gKwlkYXRhID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+ICsJZGF0YS0+
Z3AwX3JlY2VpdmVkID0gZmFsc2U7DQo+ID4gKwlidGludGVsX3BjaWVfd3Jfc2xlZXBfY250cmwo
ZGF0YSwgQlRJTlRFTF9QQ0lFX1NUQVRFX0QzX0hPVCk7DQo+ID4gKwllcnIgPSB3YWl0X2V2ZW50
X3RpbWVvdXQoZGF0YS0+Z3AwX3dhaXRfcSwgZGF0YS0+Z3AwX3JlY2VpdmVkLA0KPiA+ICsNCj4g
bXNlY3NfdG9famlmZmllcyhCVElOVEVMX0RFRkFVTFRfSU5UUl9USU1FT1VUX01TKSk7DQo+ID4g
KwlpZiAoIWVycikgew0KPiA+ICsJCWJ0X2Rldl9lcnIoZGF0YS0+aGRldiwgImZhaWxlZCB0byBy
ZWNlaXZlIGdwMCBpbnRlcnJ1cHQgZm9yDQo+IHN1c3BlbmQgaW4gJWx1IG1zZWNzIiwNCj4gPiAr
CQkJICAgQlRJTlRFTF9ERUZBVUxUX0lOVFJfVElNRU9VVF9NUyk7DQo+ID4gKwkJcmV0dXJuIC1F
QlVTWTsNCj4gPiArCX0NCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgaW50IGJ0aW50ZWxfcGNpZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICt7DQo+
ID4gKwlzdHJ1Y3QgYnRpbnRlbF9wY2llX2RhdGEgKmRhdGE7DQo+ID4gKwlzdHJ1Y3QgIHBjaV9k
ZXYgKnBkZXYgPSB0b19wY2lfZGV2KGRldik7DQo+ID4gKwlrdGltZV90IGNhbGx0aW1lLCBkZWx0
YSwgcmV0dGltZTsNCj4gPiArCXVuc2lnbmVkIGxvbmcgbG9uZyBkdXJhdGlvbjsNCj4gPiArCWlu
dCBlcnI7DQo+ID4gKw0KPiA+ICsJZGF0YSA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gPiAr
CWRhdGEtPmdwMF9yZWNlaXZlZCA9IGZhbHNlOw0KPiA+ICsJY2FsbHRpbWUgPSBrdGltZV9nZXQo
KTsNCj4gPiArCWJ0aW50ZWxfcGNpZV93cl9zbGVlcF9jbnRybChkYXRhLCBCVElOVEVMX1BDSUVf
U1RBVEVfRDApOw0KPiA+ICsJZXJyID0gd2FpdF9ldmVudF90aW1lb3V0KGRhdGEtPmdwMF93YWl0
X3EsIGRhdGEtPmdwMF9yZWNlaXZlZCwNCj4gPiArDQo+IG1zZWNzX3RvX2ppZmZpZXMoQlRJTlRF
TF9ERUZBVUxUX0lOVFJfVElNRU9VVF9NUykpOw0KPiA+ICsJaWYgKCFlcnIpIHsNCj4gPiArCQli
dF9kZXZfZXJyKGRhdGEtPmhkZXYsICJmYWlsZWQgdG8gcmVjZWl2ZSBncDAgaW50ZXJydXB0IGZv
cg0KPiByZXN1bWUgaW4gJWx1IG1zZWNzIiwNCj4gPiArCQkJICAgQlRJTlRFTF9ERUZBVUxUX0lO
VFJfVElNRU9VVF9NUyk7DQo+ID4gKwkJcmV0dXJuIC1FQlVTWTsNCj4gPiArCX0NCj4gPiArCXJl
dHRpbWUgPSBrdGltZV9nZXQoKTsNCj4gPiArCWRlbHRhID0ga3RpbWVfc3ViKHJldHRpbWUsIGNh
bGx0aW1lKTsNCj4gPiArCWR1cmF0aW9uID0gKHVuc2lnbmVkIGxvbmcgbG9uZylrdGltZV90b19u
cyhkZWx0YSkgPj4gMTA7DQo+ID4gKwlidF9kZXZfaW5mbyhkYXRhLT5oZGV2LCAiQlQgZGV2aWNl
IHJlc3VtZWQgdG8gRDAgaW4gJWxsdSB1c2VjcyIsDQo+IGR1cmF0aW9uKTsNCj4gPiArDQo+ID4g
KwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIFNJTVBMRV9ERVZfUE1fT1BT
KGJ0aW50ZWxfcGNpZV9wbV9vcHMsIGJ0aW50ZWxfcGNpZV9zdXNwZW5kLA0KPiA+ICsJCWJ0aW50
ZWxfcGNpZV9yZXN1bWUpOw0KPiA+ICsNCj4gPiAgIHN0YXRpYyBzdHJ1Y3QgcGNpX2RyaXZlciBi
dGludGVsX3BjaWVfZHJpdmVyID0gew0KPiA+ICAgCS5uYW1lID0gS0JVSUxEX01PRE5BTUUsDQo+
ID4gICAJLmlkX3RhYmxlID0gYnRpbnRlbF9wY2llX3RhYmxlLA0KPiA+ICAgCS5wcm9iZSA9IGJ0
aW50ZWxfcGNpZV9wcm9iZSwNCj4gPiAgIAkucmVtb3ZlID0gYnRpbnRlbF9wY2llX3JlbW92ZSwN
Cj4gPiArCS5kcml2ZXIucG0gPSAmYnRpbnRlbF9wY2llX3BtX29wcywNCj4gPiAgIH07DQo+ID4g
ICBtb2R1bGVfcGNpX2RyaXZlcihidGludGVsX3BjaWVfZHJpdmVyKTsNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuaA0KPiBiL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0aW50ZWxfcGNpZS5oDQo+ID4gaW5kZXggZjlhYWRhMDU0M2M0Li4zOGQwYzhlYTJi
NmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmgNCj4g
PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuaA0KPiA+IEBAIC04LDYgKzgs
NyBAQA0KPiA+DQo+ID4gICAvKiBDb250cm9sIGFuZCBTdGF0dXMgUmVnaXN0ZXIoQlRJTlRFTF9Q
Q0lFX0NTUikgKi8NCj4gPiAgICNkZWZpbmUgQlRJTlRFTF9QQ0lFX0NTUl9CQVNFCQkJKDB4MDAw
KQ0KPiA+ICsjZGVmaW5lIEJUSU5URUxfUENJRV9DU1JfSFdfQk9PVF9DT05GSUcNCj4gCShCVElO
VEVMX1BDSUVfQ1NSX0JBU0UgKyAweDAwMCkNCj4gPiAgICNkZWZpbmUgQlRJTlRFTF9QQ0lFX0NT
Ul9GVU5DX0NUUkxfUkVHDQo+IAkoQlRJTlRFTF9QQ0lFX0NTUl9CQVNFICsgMHgwMjQpDQo+ID4g
ICAjZGVmaW5lIEJUSU5URUxfUENJRV9DU1JfSFdfUkVWX1JFRw0KPiAJKEJUSU5URUxfUENJRV9D
U1JfQkFTRSArIDB4MDI4KQ0KPiA+ICAgI2RlZmluZSBCVElOVEVMX1BDSUVfQ1NSX1JGX0lEX1JF
Rw0KPiAJKEJUSU5URUxfUENJRV9DU1JfQkFTRSArIDB4MDlDKQ0KPiA+IEBAIC00OCw2ICs0OSw5
IEBADQo+ID4gICAjZGVmaW5lIEJUSU5URUxfUENJRV9DU1JfTVNJWF9JVkFSX0JBU0UNCj4gCShC
VElOVEVMX1BDSUVfQ1NSX01TSVhfQkFTRSArIDB4MDg4MCkNCj4gPiAgICNkZWZpbmUgQlRJTlRF
TF9QQ0lFX0NTUl9NU0lYX0lWQVIoY2F1c2UpDQo+IAkoQlRJTlRFTF9QQ0lFX0NTUl9NU0lYX0lW
QVJfQkFTRSArIChjYXVzZSkpDQo+ID4NCj4gPiArLyogQ1NSIEhXIEJPT1QgQ09ORklHIFJlZ2lz
dGVyICovDQo+ID4gKyNkZWZpbmUgQlRJTlRFTF9QQ0lFX0NTUl9IV19CT09UX0NPTkZJR19LRUVQ
X09ODQo+IAkoQklUKDMxKSkNCj4gPiArDQo+ID4gICAvKiBDYXVzZXMgZm9yIHRoZSBGSCByZWdp
c3RlciBpbnRlcnJ1cHRzICovDQo+ID4gICBlbnVtIG1zaXhfZmhfaW50X2NhdXNlcyB7DQo+ID4g
ICAJQlRJTlRFTF9QQ0lFX01TSVhfRkhfSU5UX0NBVVNFU18wCT0gQklUKDApLAkvKg0KPiBjYXVz
ZSAwICovDQo+IA0KPiANCj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1bA0K


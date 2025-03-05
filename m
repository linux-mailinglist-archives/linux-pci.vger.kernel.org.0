Return-Path: <linux-pci+bounces-22925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC2A4F271
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 01:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B6A189056C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 00:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D465B2F3B;
	Wed,  5 Mar 2025 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcaAYKFb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E2512B94;
	Wed,  5 Mar 2025 00:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134159; cv=fail; b=Yp1jfJ7rnwV8QzAzXOneoX8b5XRjTm9HpWWBNlWZbQc3YPNIfa//lpvS23CIdVJkXvF94QZzgYKTh7eL24mCSqQ0kobDj9riUGTmhlser/DxNCcCVHzwKC9AWvtdHAJ6hd7J9/ZCfQbyw3d9oJtCAdpO3AqoGh+BO4VoFb4QJIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134159; c=relaxed/simple;
	bh=7iVaKcpuSyqUZBCfJS4oQ4aAQplKwgSvh+ydOE6lPsg=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uGAKf3/HyvM/6xgIPa9lTTVJJe9raLGnZKFYUp4qzvD1HiryQw8FC++JDkxm9BZYwEb5SYtxhIdts62lpM1Q7lssE12gvU27MvVcSYAQAD7Z4Gji252n5HhIqqHL1ic4uTMPM5uxOVaXOLpa1keZ6jjaIFMeOsn0P5En6eSTciI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcaAYKFb; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741134156; x=1772670156;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=7iVaKcpuSyqUZBCfJS4oQ4aAQplKwgSvh+ydOE6lPsg=;
  b=OcaAYKFbxMSsDEKbs4FiFJO2KQqzW13Vw3YdDaQd091XUBW90x1mmmqK
   Zg4FCikECmBBz2p1Ji2U776CHWcccY2xl6WTcDHRtuDVloq6DyExvsUHC
   Z1JQB9L9/5u2q3cdV5XbKA2v0pSkoy4T/MMlOgu2U6OUzG9ToRBzoQ2/Q
   0Pjie6bH7ACtBcdeV6QBmcCDHAoa+aWk3ikqSuDJgBlSyrJpYOni2r/Ve
   3oxs/hOXPCPtYVeaYXdwCIJije8HNz+3bDnS4CFogPh5d1ngJDGLa65Yl
   F6mS4x3iTi1zKXfLsZBge8HwlFyLZejefFc4LhmZri5Fjq+b4ao05DqNe
   A==;
X-CSE-ConnectionGUID: NetQQSFJT9yddglK0KfkVA==
X-CSE-MsgGUID: UnVwsnquS3+4G2RBdL9n3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53479403"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="53479403"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 16:22:36 -0800
X-CSE-ConnectionGUID: IZYORZPFSdGheQBUfxWkZg==
X-CSE-MsgGUID: 7RfhYqokRh6ncylMwvty9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="118682378"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 16:22:35 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 16:22:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 16:22:34 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 16:22:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kay2N5Chx/bPqZP1WjUjVozYSIJoiueRNqy7LGGBhf78ftyZQegkrYAXHmZKaqNkjdsxlG76gb/2M3bKB1tWW+hg2JQyvGWY34vYyRoES67Ks420wp1aEPPQbrv3yVGIQg9+fAIcIXu5mX73k6qXd2u0JprTJvmAIsW0Q6zNEq4kF9zQxRnRpYXEddt+PeQmazOANrEgB52UCezJZhQ1E9XfERSruRxJxcF+AQnj58s6vT6X6ovgtemJs7rOw2QAJiyQsDQ3mBTyuwpjxbHleWKLmWf1RNElF39Rw6O5b80qNjRLrwu8XlIbVKcKYQ9uA2/NrJ35TNuiBL/Sgklbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmB01xO+hd6H6O8oE/NAS/pMK0RLDB+th+sLk5iUIpQ=;
 b=kxT4VasAn8vj4V9G6AU07zvrfsP9vRIh/U/6kZqZB9gOJcx84x5jXwRgf8wGTtDcKAZicNdF53FIBcvGgG5phJB+hqASyluUSRy7044Y6hfy+UjXv8k7WqsZIjrEmuDkGAd/CAGpAC5F/t7dWiw9kCvSvA1APODpS46T6a3WlKBgkjAO9VtOKJUn3OE2eX6116/Dor+oSaQXY3MoYvqmKirX5Ia99XZQ4Iu8xw7OM+OhiaVMhK0hfDkn1uJf515yjyG4BOvOLbCuZdcHF6ubQp9NPToUK/8+EGnKr/2335NnB1+XQHgeSv45ROSk43mLqfpvTPJKOEcCSMW6Qfv8UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB7064.namprd11.prod.outlook.com (2603:10b6:806:2b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 00:22:31 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 00:22:31 +0000
Date: Tue, 4 Mar 2025 18:22:35 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 12/17] cxl/pci: Add error handler for CXL PCIe Port
 RAS errors
Message-ID: <67c7994bd79b1_1327329455@iweiny-mobl.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-13-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-13-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:303:b9::7) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: a81330a9-bd36-45cc-aa6f-08dd5b7bd189
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mSKHjmKM/yj+0G0FiVMqFK3Syei6JBrp1EqlAfhHVvU231T8fy6hs+/f2U4W?=
 =?us-ascii?Q?c/yQiu2ZZtq4xNjQ1wWiiXs1mkftQ5lbh4DI7vJ1heChhm2Pwy79SzbhfOW4?=
 =?us-ascii?Q?2xDyhDP3bwWQRNBu71coJMGuaMy5HDKBltzbiWfwm9sWeTXPsKYD/412h10f?=
 =?us-ascii?Q?0ad6I8j17oiXIZDo5Oaw3B4mpdkti9FBxpNioBaNpHjf6lkHXBcgG20RtkL8?=
 =?us-ascii?Q?VKKFRuFbssTYyyH08oCpbeJMYG+2aDum3MV4xkZYeEroQpSOqHIWK87QkIDs?=
 =?us-ascii?Q?9myyWroE9dQ8JIHwbRCMsG5u62qd3kOfrchwr96nI3dolJjFGJliwu5erXKn?=
 =?us-ascii?Q?87sdBBAhzRkkUQK+deeMviI0Lb0A57O+9PqwEqRISf4zgtoIrt+JRMTG7i6E?=
 =?us-ascii?Q?z5loMPIyN1NV8uve1aGPd5enUxRpJ5Zh/bS3MTG1ZUqY3qmGUSzRx9fqr1mB?=
 =?us-ascii?Q?x6JC49Bmm3A96LdKfjRO7AhdLax23j/uZsAoHSBroplQ1OI3wXt+w4crueuV?=
 =?us-ascii?Q?lSL+J6zFA8N4GLHohg5WXrT9m3OgS209F4ZQHgNDUZ1TFdJVEZ4f46W4Jffc?=
 =?us-ascii?Q?mr8cfRIEIjz7V5DC4bWZr9+J2PuC9t8kJTr1z5gSKSbSD1L4wAPRebjs1zEe?=
 =?us-ascii?Q?nCHoD4ACx7cbHcUoWkhNcpNbCiJyri3V6syZz3k7P9pVp6RkwvKvMCOv9kQ5?=
 =?us-ascii?Q?3m0CpX78UQEQ/qSvIO+s19TovIQGTFcc464K0dFPgxeyNL6Pom2dbKcz8nbB?=
 =?us-ascii?Q?83yypqr2C09B0T+3vKNroF8pdzoTl4nIwEsqGZmVA0zjPLnILAN8/QM/ikw/?=
 =?us-ascii?Q?JD1Lk76FbxYCb+VIeqFWazX2+tnF20VLOMwgedM8mFp13OUw4+NT/zkg3X7x?=
 =?us-ascii?Q?quwT7dRpLoaty3DuEcRLJv72C97AocvlaQcVsni7KP2+0DPZzxHT8CPdFXNC?=
 =?us-ascii?Q?xMnTqNP3ujIs1pK+4p3dheWR6E1bb6uOXjKB5BYim0PHZMGvKroQx+rPRYwK?=
 =?us-ascii?Q?eOcIYKYdhU8jKD6lRyfd7m8FbidyWSyrnysI1Hvujk3+2PNz9nfOZa5intNB?=
 =?us-ascii?Q?6lqU6ZhLkIyUa4qL8JhKRFO8IWwaGYFgshKr2xzS/2lL1FOFYiG0KvxwX0NE?=
 =?us-ascii?Q?d2uOUIdrOwpUTkgCxsENQVU275L9ixCpF1gq5nfBqBRNmQAcon15Q1Pq1OR9?=
 =?us-ascii?Q?UIJWYlDyPQ9KIXcTDRmmwhbdFLybSdk+finbAuxz7ClRCsbwrwTaj/n1ZxNE?=
 =?us-ascii?Q?ril1ZVaUm1CPus3JFXbCZvW/hWAYNeuwEeO7t0TeY5JLk1KbwsBA6Dy0BDQs?=
 =?us-ascii?Q?m72Dtj5F3c/fNSUxoGOJz5vRve6rUyPqxKf3ZwHi/kF+LhbwND/XGte1WN2E?=
 =?us-ascii?Q?GpTH4sd4tklXNMt+ebx4JHEnlJt3e9ViKIr2yHyqsvN2Q1wuKcgHNGb9CFuI?=
 =?us-ascii?Q?o3yQTHw8nAI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h10eSgYTuw7eykkTVu01/WTrwemR7i416SL1xlvVvkbVUiTiccvmZkK3Y6ag?=
 =?us-ascii?Q?pwTHKEp73iqaveRaFSqCmgissr0awNz0R+/7p+hIlcDPVRjz+160oUkpIFRS?=
 =?us-ascii?Q?bQfreU+C0wwR4yshgejDaISp88ZlN2O/KCMoTKr3ZlFmkgZZtjn4JK5V/2gG?=
 =?us-ascii?Q?GVH3wfAs1FA9iqL+qj+Y6c9if41AlH3IYN914vw54PkvfZMsw2+JIJnFSyeT?=
 =?us-ascii?Q?5rrpduxcQyGjbs1QRHXh7qgdyJ33CtfxOZsybX3JWE/Pgqy47w01lWhH98XJ?=
 =?us-ascii?Q?2+owAjdE6ZsWQDQ3v4WqOel3HCm5rG5UGs1Obttk+2pHGji8oWrqYKgIPZ/P?=
 =?us-ascii?Q?JfGjsrr1NFrU2RbiXIn6rB44xydJt+Q4E2HgNVmSXQ+zr+TVGcpzkd4LLqOj?=
 =?us-ascii?Q?cj7eijyUegrd/dd/BK4a10rCEdVl1j3NOQ93CHkpOoEuYajl1SZTTjHaa/GB?=
 =?us-ascii?Q?SLnHrhd+xxP+l4ZFKP4aIbdLFmjbUWn204c8amcbCV90VseNUY0qYHeIyZ1c?=
 =?us-ascii?Q?1EnsEs6rKCV9YilJk+2Vcb2ppFFK72meqRlRfEnOulLVd8cMFm3hGkwPyva3?=
 =?us-ascii?Q?pLWcgVfPxShM0mk3wLKWkeqO0itp+07GZn8AQWmrCkI36YyzdcMwjiRlUQeC?=
 =?us-ascii?Q?J1Aw3LbwPvVHGZm+Uqr8SnLCP/b5JIznbZofiwHv+0gNl/77NiNVVBX3znpf?=
 =?us-ascii?Q?yuyR8Ad1qlHn5691vcH7aqBoFFuCDztJJ3y3ZzqOMivLSX21mAUPE6zsYtfU?=
 =?us-ascii?Q?IqCttjDNQ3OmnKMzj3zvugZo0jRsvEBEzbdENxtFwP5G/hGpBab5OF4Vd4IP?=
 =?us-ascii?Q?LQPBKzMRhT1qwrxauz0DPAkMXOLJ7ZvwCzUXH8v0lVdZe4RJ9Y/Ba4z9rM9f?=
 =?us-ascii?Q?e7WfRNpb3YfU9Zw6A6PyiRl477KeMjPcMTsj7ev9U5UsOBk3o52ybDNd1u+Q?=
 =?us-ascii?Q?/bTGBINTbquE9Fndtq642zcadOic2RX+CNeTRJuhkoW+vMIZJQtgD6GNAxtX?=
 =?us-ascii?Q?8+OxzaHQPlkY2XU2o34eMuwBGxIAyoLp5bOQnbcAS6BXzivvx3OGCkJw+NW3?=
 =?us-ascii?Q?Gi5ub/WDR1LuumEOW8gEw4C7V3R7cH/cLs4rX9WT0YfuD0AzKNpi7oIjf7vK?=
 =?us-ascii?Q?yTVlQMDlWb0nADlhb+1YPwtTRPmkDdcEr8AmfVOp0wrKOFY/R3dkEnTin/Gx?=
 =?us-ascii?Q?JDp8zyperikYIpEIT5J/8PVy5qg0KwwaoQezqD+5ruE56RrZLSG7dp6CFXeD?=
 =?us-ascii?Q?M6biMvlr4gsnv6C5qSVfza2SmjEMYVc6HK3LsClA14TucS3cNxrWBI4n5Dmp?=
 =?us-ascii?Q?VZ/S777f8Yx1IeJRII+dyZhb42+niWLrBhde9ABrZLuyJiwm/BL9ykqTw+6Z?=
 =?us-ascii?Q?RauM2Bf4qlb1ohLIx7IEyKabi9dzcWI7b/5yw4JpZAQxzRXUi9coor7JouXw?=
 =?us-ascii?Q?Lg8tTSWwM3/aqsGefzBOcrmbxhXBtJj9fx6kmpg5DzZrvhsmkyGWneR4DY/m?=
 =?us-ascii?Q?SfinzW65y3l/CF74IGOCaD84N/nBaWscMVABtzsH9rBq2FWsrCYSAsOnRFXs?=
 =?us-ascii?Q?c3KfXF5MqtWMT/hZUgANoVpoAzh/Zz6v17H3grgZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a81330a9-bd36-45cc-aa6f-08dd5b7bd189
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 00:22:31.3119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KARD0/USXaoVHmdYD5O+1gxy/xIj437XP18AHjTtZULTsKI+SeGEVyKBSOrR0Belp4lDfM2WzhIkxnLGdLTa5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7064
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> Introduce correctable and uncorrectable (UCE) CXL PCIe Port Protocol Error
> handlers.
> 
> The handlers will be called with a 'struct pci_dev' parameter
> indicating the CXL Port device requiring handling. The CXL PCIe Port
> device's underlying 'struct device' will match the port device in the
> CXL topology.
> 
> Use the PCIe Port's device object to find the matching CXL Upstream Switch
> Port, CXL Downstream Switch Port, or CXL Root Port in the CXL topology. The
> matching CXL Port device should contain a cached reference to the RAS
> register block. The cached RAS block will be used in handling the error.
> 
> Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() using
> a reference to the RAS registers as a parameter. These functions will use
> the RAS register reference to indicate an error and clear the device's RAS
> status.
> 
> Update __cxl_handle_ras() to return PCI_ERS_RESULT_PANIC in the case
> an error is present in the RAS status. Otherwise, return
> PCI_ERS_RESULT_NONE.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

[snip]

> +
> +static void cxl_port_cor_error_detected(struct pci_dev *pdev)

This causes a build error in this patch because it is defined but not used
until later.

Might be worth deferring to the future patch?

Ira


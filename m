Return-Path: <linux-pci+bounces-6665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF7C8B2224
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 15:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A29285063
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 13:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F15B1494C9;
	Thu, 25 Apr 2024 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SePYx9T7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A591494C4;
	Thu, 25 Apr 2024 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050027; cv=fail; b=W4y23eaY1P8z84LSm60vBCOtqvrYqx5Ot4MgWlm8ArO7N5fzJrn26YvXd1nvboD8nlW86MpbZM+yrPJ5jG6wFfGUFbRYbG/x18bBEPb54c5ei+56CmyBW3436pNNmhBAYAxbN7u91IcmK5i1mo+H++JWNoJ2G0WHLXhhVHqWMfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050027; c=relaxed/simple;
	bh=QfYUXnnHmeSQFsZwrNXX4l8CqprUMZVCZ+gMumIxaRA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DYUzQOZ5DlBr6i3tmgjlkX8qPuXfqz/+tnixuDtXeAuGEDZd1msyp+mldDUd9EO7eeg6hwEdyebQf4/QlNH6ch2OPD/hl/57OIF8okBCwL7iMjNdc0v7ezBEXnpNAkDcq9hbTL+hNKUfPS+dNv6Q0J9O7e69Pvd1b9XrDBqTY0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SePYx9T7; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714050026; x=1745586026;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QfYUXnnHmeSQFsZwrNXX4l8CqprUMZVCZ+gMumIxaRA=;
  b=SePYx9T7m8+2g+854DmHDVQTJ7Yd/jP/gbT66ZK28iee7IK0mfpeUnB+
   4bGqaaWSFYoWAGABpXDcpHCCdjYrEIUJjhyILaQENNjXhJxIL9oK7xgtM
   cYR2SPWvJdLbXMPpyc6mpkjgIghScBO2KLGM7vUQ/OaXvuMD8hBWDmipG
   mxFibRIBMiDzI2Qyg+kAno2c7N2EbZVcYlrIkeXZDU5A779EZDcdrbDP/
   oepbRqRZHRsIvoQqW9N/zVNY+eiAzTsrw/Tj3RFD+7ScGrZKuDBlmqDcf
   5TJl6x4gySMYZzu/Ks+lBY707/61HKirS67/yHwPUyDBCx/X11W8vdfKA
   w==;
X-CSE-ConnectionGUID: 3+DPUyE+TOCjq9eLfaMFsg==
X-CSE-MsgGUID: cq/XPRaOTRa2+V/p14PcNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9660130"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9660130"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 06:00:25 -0700
X-CSE-ConnectionGUID: yGLZiaWJSqKesOvEuVP/Yw==
X-CSE-MsgGUID: FwHU/VXGRxGeYS4R7DFXww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25548478"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 06:00:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 06:00:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 06:00:23 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 06:00:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQeGLZeKNkYE6heO6hB+g1gKgsyk+LOz6wnotnymwws/mRp1XpRWx7m5HflXT6nFWBO5z2WdTnFE9PYgmX6qYwcCACQD8Z/T5TNFNp0lvQiVXwW5/Eyx9hiBDwaAKK1QO3qSGKjEm8n4i1SGICs4o2ZWR+OVWzBPgvTtU7yEQYNzP+qX5m5ACc/9n3met7BjUI40N9BCtkiNnlnCaO/8GBBvFBYjRI6BL3jEuUc3EX98lG8IbTnmTHKt37aQMG9JSs25Un2y6mcMXZi4UYk/ygPi4P/UU+dTadX57mlTVDM/VGQhPeQN7jUZ8/IjMlAP+1k+jNg2UlK/8Qk6tne+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKuVBkPZpVA5kI1axW7zAaRx4gFualAmLX3BL9TvzxI=;
 b=QkWLditEKJIMRyKpQe9ll3iv40NR0wmR4nkmqV1Zuem4iwmwx7YVD/LXFcaPYNkd4GNKBmwGWu+SugtXPJLwDhfbkGsPRa6YDXhlGv4Py/rTRixjBq0J5DhqVGmWxJzr5tNn6s7EDm7kE9HqhKxPkpf3cafjiSHTmVbnnTi3zli+hC6FsexnlxnWm70tnTVtIP6CO121rDB5z8FnQbP6/tQXOoxFl2pL0CkIWNpHfOOzveECj0/BT0Kty75HgKsEpyW0gjhOiPJUEiF5MxjjPRD9S64n+ywFi2zDKvm6wS3Nej1nqsoR5wd8qsXu35rzD0BCKjpP45jUsno3Qt3N6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 13:00:21 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 13:00:21 +0000
Message-ID: <63b89455-3e30-421a-a082-00d39e836e20@intel.com>
Date: Thu, 25 Apr 2024 15:00:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: dwc: keystone: Fix potential NULL dereference
To: Aleksandr Mishin <amishin@t-argos.ru>
CC: Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Serge Semin <fancer.lancer@gmail.com>,
	Niklas Cassel <cassel@kernel.org>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>, Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20240425092135.13348-1-amishin@t-argos.ru>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240425092135.13348-1-amishin@t-argos.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::29) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: ff08cef0-90d2-4e08-6c84-08dc6527aa34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWM2ajF6SEY0NGl5VVo0OHNTTDJsSVZjVEY3OU5TNlB1bnArT1JRWlNnWU8x?=
 =?utf-8?B?M1pQdVN0WHNObU85aXh2Zm9sS01vbDdldWEwMk9MdmJRdnN4eWlkSnB5QnJV?=
 =?utf-8?B?dllrUEVMTURIU1h5YmFvbDhRaEJZM0VvcDBUVXlHc2s1dEtQL2o4MVdYYTZC?=
 =?utf-8?B?aWtKMUNxWCthS1FRNHF2RGk5Z1VQVmEySDdWc0U0eDZKUzRacXorVHVLb2NG?=
 =?utf-8?B?ajJJTUR5MjdMK2E3WFlMcWhGdEw0cnVTSTZPT3FqK0ZUU0JhczNRa0RaUEZY?=
 =?utf-8?B?d2VQYXR2Q2RJVkFzdnFjQlEvS1RTMGk3Ym5ydE01SDNUZ0s0L3pwTllaaHd4?=
 =?utf-8?B?RWVITCtNOHRsMEY0aXRLbStqTFdMVzMyZG1aYXZnRVBJMVBHTnBnVkVsMEps?=
 =?utf-8?B?MEJuUHc0cGY0OEh2RitGTFpkUThyWFdkVHI2bWhlMndzWFB1WEp2S2xPUGx6?=
 =?utf-8?B?QTdXTmlFTDljaFRhTnlOS3NhNTdmV2lxcVRpampINHhjSnlVYVQ2Um9UeVZS?=
 =?utf-8?B?bWF3S2gxdmRDMnNwY0RSZjVyU2hHNTVNWUoxd1BxNmhVV3RwYUZHeGdQbnpv?=
 =?utf-8?B?SU5uYmU3NWs4SVFtVitCUDIvTFV4UEV3UGh6MFNiYkM0NXhmWHlGcjluMkgr?=
 =?utf-8?B?UmNFYXlXREwvOHlqK3FKTkd1RzJ2a1VLaDR6WXVLS0lmMHhWczNwNjNHQmhO?=
 =?utf-8?B?NWxaRFVBN01EcFkyZ2x6bW0yZC9LcG9ldVlmMVZsR2Znemh0TDRjN3FrcWor?=
 =?utf-8?B?Nm9zSnJsQzJKdkN1b2lpeS9pSEMyUXh5YzlnMTJsNWx3dmtmUmplOUxsL0p0?=
 =?utf-8?B?dnRMR3A1SE52bTl1L3RWenZ3eXV4TEZURlZVR2ZmQ2dsQitwOXYyTlNZYmFx?=
 =?utf-8?B?MEZWOVNaNUQyekw4MXE1VE9LQUFpVDFmSVN2Vy9CeGU2cGpjdFF0ZU5hQkph?=
 =?utf-8?B?WnhpNEJlWVQxZlJtMjF3WlZyUXJxTkV6MngwMDhBM2Nobi9FMnZvbm8vMXFE?=
 =?utf-8?B?cW5FOHQxUUVJTFdOZHRTOHEzVmIvaWFZNkhlRXV1d1ZINlJUTkgwYVlNYjVK?=
 =?utf-8?B?bmZ5VnpIMGd0by85ck55dTBVSWhCTTVTSDFvTm5HK3VFTUwrd2czT1hCUlIr?=
 =?utf-8?B?WFZVN3dxMldYY1djYmZzdEFFV1lBOXJ6N1NOSEZIYU1uTmJLUk8rV0ZPSm9T?=
 =?utf-8?B?YnN4TUdvaTd3M2oyWFBwS1BDL0tHVzZNeEVRTnFoTlZxM2ViSmIzZHBFaVpF?=
 =?utf-8?B?T0x5YTBaRTVQVSsxT1pDdEpjdXhRZDlXKzBRV252QkxvRnBWakZ4bHIxRU5u?=
 =?utf-8?B?QVlNOFRHTVRESmc3QjJBSXdlVFlqODRjWXllNFA0T1c1eVlaMXdvSWlhblJE?=
 =?utf-8?B?V0trZWd4QmYxZHlnSENSYjR0WlJRQ3l2NUNyRFlhQUhVUEZnbW5xb2taNWtG?=
 =?utf-8?B?MWdicnptWFJYcm1adkxoZUdEUUhSTzdCS1grS3BLd1g5LzJtZTRueEFoSVl5?=
 =?utf-8?B?R2ZQcGkxUDE1a3I3Rlc0YzRWdUNITU5VVWgwNllPZWJraXlGZU54U0FyWDlI?=
 =?utf-8?B?ME5QUEZiMUtZQUNMYk5yL1hmUTdzOFplbTREL2JtQWg2aUNRejFHMW9ZeUls?=
 =?utf-8?B?aGVuNWhsUHRwKzl3Q3pMaUxYQlRiUUZxRlYrMnVZaElvYVNwcU9vMjFMb2t4?=
 =?utf-8?B?STE1dDhBdlVaWHI3TDdLcnl0OGM0c3hPSjNpc1c0Uk1jTE9LbStFekJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjBnL2ZFNHBBMTBhc3pJZkRETWhVQ1RtYnRha0s0R1RrVUhkZGdkWUJIWTZ6?=
 =?utf-8?B?Y1lLeGZkTGVJYWQyRlJjNnFDb243bkk4aURnMFRnZEpkdkJFUUdOSmNqanpB?=
 =?utf-8?B?SXZQMzcrMmZLUmhzU0thYk1UeUYrS0RtK1UwUk0weTRpKzZ4N1AyUXhJZ3RW?=
 =?utf-8?B?cEpmLzI5b2VoMEE5MnBVTWliMWU2UlBWMzh4bnB5UVA3SGY3b2wveGJyb2xF?=
 =?utf-8?B?Q0lMZVVBNEVWUHNQcWZ3aVFiQXpNZldBbmF5VjFrODZ6TUxIYnZlanFDeEh3?=
 =?utf-8?B?TzQ4QUxrbnlXZmREV1FVY096YUMwbDJGSUh3cXMzZzJQTTZTOS9jMUl6RTlX?=
 =?utf-8?B?eTc3KzJpbUN5dEFjZlZZTmlLL3MvTGRYMm5vVjIrdHdLTzdGYU9XL2pVV09U?=
 =?utf-8?B?elBRV0JTZ25GaEcwQWtYejF1N2NMWmlMK1R2bE9CbkNKaC9JZ3lmN0FqMTIy?=
 =?utf-8?B?dkdueUtYdktQU3RONEFhWDB1bnhNNEJlRFFONlYxL1Y2andnUzN5U0RTMHla?=
 =?utf-8?B?RnFvUmwzZFZHZGNqbTBZSVQ3RkRoSE4rL1BoeWpNamlzNmJhOXl0ZnNSTjdo?=
 =?utf-8?B?NHdnaTI5RzUvK2dyS1MraXcyNE90ZWdTUFlBSnMrNHRiN0lxRnBGWUZPZ3RS?=
 =?utf-8?B?RFFEbGZxazdzY3VEVW1MYkc1MUVBL3ozbHlZSGJwUkJ2UEJrRnpQemgydU5R?=
 =?utf-8?B?eDF3Zk5uanBBQ0tIRW5RRnVvWDE1QTZiNkN3bUI2d3ZQMmJyK25PT2tJbmtj?=
 =?utf-8?B?N3RlODE3djJWL3ZSNHRhRS9kZ2tHd1Z4US9QV1o4UUVGNGpMdnQzaUtpd1NV?=
 =?utf-8?B?OXdMVktnOG1xbzRFQk1rMFJUV0tidE0wTSs2UVpGZHFCS29JMWxqcjZvYkU3?=
 =?utf-8?B?V2l3elpRRElzRDhiODE1K1FsVkNaS0g5SDJKNVRwdWovdnRDSzBFS1FZM0dV?=
 =?utf-8?B?N3lxc0Vud0dDSlQ1eFBUZm8yRUZwekFSMUtIeDh5SU1Ud0ZLU2ptSXR0N25p?=
 =?utf-8?B?bnVnMi9FTG5LRjl0ZXQ4QlhoUzI2aUZQOVpsbnBsNlFtUnAvR1NjSm1kZEtN?=
 =?utf-8?B?aGoxZDRDckVVbHRpK0JMdStWMTV0UGIvd1F3amlFbkRreGdEalYyS2VadTdZ?=
 =?utf-8?B?NFZtNWJNYTdFaEF0cDBIdDJ5VExDSUI2Tk0rdlYvb1Q2a2w4azZVRk5SUnhD?=
 =?utf-8?B?N2kva2NRbzlRY0xxZTNvb0U2RmtCaUhxRFFIN1JOUk5XKzdSdWtFQjB0ckcy?=
 =?utf-8?B?aUVZdkNpdDNNSkRyWW04Q2xTSXBLYjJLUVpVUGtFMm4xTksrMy9JUzI5KzZw?=
 =?utf-8?B?QW1PMlRnU3A0UjVGajd6U2VnM25jVE5CMStLQW1IaEJ1TmRFdEQrRTl4cFB1?=
 =?utf-8?B?ZllyNnY3ZHhLcUFZc2UwbzlGc3Y1RThMQjdKYWREb0ZVeGtQRU1rb2JJTURW?=
 =?utf-8?B?WG5jZXZYY3BBQWgvQXh6NllRRGRJMXhGRkxWd1NFOHozZmdiaXJrSm1BVmFZ?=
 =?utf-8?B?YnhscVlPVXJSdHNTM05IUE5mRG9ZTURTUmRnaGplZ1g3TFFrdWJzNlQ4T0hI?=
 =?utf-8?B?eGR5YkFUZkgyZGlobDhCUFhkTWt2a3kyd3JIMHM4Ukdsb0RtTFhjQ1FheGZj?=
 =?utf-8?B?dFNtZlFEVVBzOXdKbWdxc29VZUFFUk5tbURqRllrL2lwOWdST2Z6bndRNVho?=
 =?utf-8?B?OWVWaC9qSjNYOEd1M0pRTE96YnQwclRleGtKdXRVaDh0b3ducFd5REp3Z0x3?=
 =?utf-8?B?cFd1bE5wZmI5TWRWT1I2V2lBREhxc3Z6OVE0eTcybERkSkE1Ry9LZldtenVl?=
 =?utf-8?B?TkdTZmF0UURmRkZHUHArNjduUTUxbU1zd1RuZDVqK0Rlcm9Vc2tubWxNK2gv?=
 =?utf-8?B?TlFYa2lRVnp4SUlQK3NXSUJhTmxDaDBvZ2VFd3pjNnBIUkNmaW9LOHoxWmVv?=
 =?utf-8?B?ek1YL1ZMcjNHcmVNY2dDQ2UwWFhXTWZiaVlGV2FSeEcwUDBCeTk1em5wSEVt?=
 =?utf-8?B?WWxmRE5hais3R05Fczg3TTFmbURGWkFQdG80MXlTblhhaW9wWnVseC9GTjJV?=
 =?utf-8?B?bEZxTnM2Mk5MRmtpWU1UeGxCRWVpZmpoY0VhNTVkdnJmOTVWbEdQRkV5SEFW?=
 =?utf-8?B?Q1RZU1hKWDdndG9nYldROUdHYkhWNmlvVDV0YmtPNnhHMXJUSDBsTnNSaWJx?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff08cef0-90d2-4e08-6c84-08dc6527aa34
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 13:00:21.6060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6P5+jqXaf/bVZslPquaKpPZdHn6yG5T9l03c+KwSY6/5V3aRdRgabGf+rcu7FmvT2kvAKqzML20pCO2YXbz6e7S5zKwRbnCrxAS1gh/YR3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
X-OriginatorOrg: intel.com

From: Aleksandr Mishin <amishin@t-argos.ru>
Date: Thu, 25 Apr 2024 12:21:35 +0300

> In ks_pcie_setup_rc_app_regs() resource_list_first_type() may return
> NULL which is later dereferenced. Fix this bug by adding NULL check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Please stop spamming with "potential fixes" made mechanically from
static analyzer reports without looking into the code flow. These
patches are mostly incorrect and may hurt.
Either have a stable repro and then fix the real bug or don't touch
anything at all.

> 
> Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

Thanks,
Olek


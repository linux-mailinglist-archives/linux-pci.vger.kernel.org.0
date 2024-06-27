Return-Path: <linux-pci+bounces-9378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C4E91A941
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 16:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B2E1F221BD
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0FE1953A1;
	Thu, 27 Jun 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gG5GoHE0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7DA1442FE;
	Thu, 27 Jun 2024 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498743; cv=fail; b=ucUs82Bq1xyl+C9X6++i5Sy78DTeT52IMteseRgrPOto44JzwUdfymN5vk3vd8Yzi4L3xVID5hgkufmXe5rcMkXKb/9Yz/B2X5gO04oSwbiA+lbo8aTLsqxWGaO5TsPbAQBlPRT/pylZVZqi1jPLjHm67xyZwtA5DlCOFZhSbs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498743; c=relaxed/simple;
	bh=GuIU5vE9sxINdRtM63EprqEyVukUmokgQoRcIf1+Rkc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jwCIYcFWmfyMJxhche1D+pUVIjafCZKqJe40wvgWSNvyUGQBlhSGVB6LyEEwLRqnRfUwjlOGyL4qi8odrNbqv0Km0o57ahmH7TYz3GIXyimt1Kgrpx2jqMSa6A0PloZysHe6yISBKTp914soaxP5HXBVCYhJbXinDb0okMbkR/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gG5GoHE0; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719498742; x=1751034742;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GuIU5vE9sxINdRtM63EprqEyVukUmokgQoRcIf1+Rkc=;
  b=gG5GoHE0+Psx6A0KKU9w1AstvEi0DrVZrVVK7FX8mwno+qcBQmTGDz24
   k+YWiMe0QCFpCYSLaJnLd2CckKycEv+46nNN0EtwZ2AxFnj6nFjNUA/7N
   jLyAnJvuVOcR54Ihak7YwwpeiVq96iATaPHsgYj5FbycSh9QF8u6kC4sb
   J+dqJOtBRn/nUOE11xBD2dnNQGLTLS1dU51TM7gZMUVL9fkbu6MXdk49i
   zRIOvrrY15Lq5wHlnXmJvFxKhVkCuyZP5igDXyaM5N7iRkGr8mlZeNmJ3
   CrUhwSeAuGvH+LmkBCrTUA2ZXZr52S60A9DWUJTQ0fFrwHVcXDAHF5g9Z
   w==;
X-CSE-ConnectionGUID: ABtbgwFNTu66gwx/qrY6PA==
X-CSE-MsgGUID: 2hTLaVRLQwa8n3QYUHwzDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16855993"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16855993"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 07:32:21 -0700
X-CSE-ConnectionGUID: YvlH7jpITxOLun0v2mJI6Q==
X-CSE-MsgGUID: B+c9SIIcRFyFW+j22chxjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="75154974"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 07:32:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 07:32:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 07:32:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 07:32:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 07:32:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BO4YlW9APJIvSm4iDvMH9AA/x3BNL02CZp383DQmH0U0r7llo1J2j3LwV9RYIZbFzzEuEXwFeL+r00xPzkVDA53FfH34B+UbvP3ugyRTXs6nztmtUjZ2/++9cG0LBhqkqbZhiPgfqGZZdfYHc2CNYJS7Je22k9jWP96R9r8oH3jSyrGZsh2uli8XZ+hB1JlZjJ3bzA4sjv+licvbFQyi4jZYkAQbRetxIltA5fLwIJJE9E8LRrHMFU+qRkyNvHESQVqTemqx0759OCtdRHzyvFmISdJv7OaGu+GAXzdnaMCZ2QiMGLjncM3OXTUp6DtwNzuz5/nygvB56xk53rUYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsKjrQ4xY7W1V+DC9y5boHGO4rZIXXSlsiQHZgcp5ss=;
 b=Z2ArQBHsPbQB4oELhpLefyjtTsJthpgw2vI5CGVFEs0Xo1MWlWjFdHHYY5BVx8yCcdBUc6mkLHLGSt50EKEzCsAWjcg0v6TqPedLMYa/i5BN0EQfUi/OPR/iI8T5hBJ8IaAkz7vIbWnPzPM+6691iEKBKj0Fq1/rXQpnnSyT0JS/y31aYgWIKhWgLFze8sPUsgMQCNAljtZ+ipdcUGTojAJiYeUlqyCEpZ3Ps1e6b3vlYnMES0KegcQD8d2KVLyw+aG7ebDm0DbEbSrYYh9aR4QYz5YUS314FoowmMyqFHRuxhFUUK5ahIXRqFbSSzRXgJ0Pans2E6wRNL07UIDZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5087.namprd11.prod.outlook.com (2603:10b6:a03:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 14:32:18 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.7719.022; Thu, 27 Jun 2024
 14:32:18 +0000
Date: Thu, 27 Jun 2024 09:32:14 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v5 1/2] cxl: Preserve the CDAT access_coordinate for an
 endpoint
Message-ID: <667d77ee16b31_2ccbfb2949@iweiny-mobl.notmuch>
References: <20240618231730.2533819-1-dave.jiang@intel.com>
 <20240618231730.2533819-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618231730.2533819-2-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcd19a5-e088-491d-0eb4-08dc96b5f284
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pc6J/ut49omDELqJH86y45cUDwg1pIg0xNDHvsYdvwQg+ALBxwUTK3pTLC76?=
 =?us-ascii?Q?rAHvSDLxKeY4KSIiBtJQQxfpa3U2ippo2RdYYsPoQHTizO/rvTlvZ1YhvaCM?=
 =?us-ascii?Q?NLTV7HhEuzqC5jOJgxHGJupzKxx3zA33eZ/HBjkI9I5l4t5r4dQ9xw+7SJNh?=
 =?us-ascii?Q?gZ3S7rlIQUZeiKK7mYrzV4HKZS3/9jcSYysYhryggl3kgbzXQWL+0AhClvu4?=
 =?us-ascii?Q?2nYuBXcNVgrbBvmHiy51M221Kl5RYKZZ91Ep0FUb+oKbCsR+bJt3GJI9MDkY?=
 =?us-ascii?Q?y8yDfRICDJzLv3eLeIP3Tb3GT6XzWY3g4pPFqNRe6x6dFdsU8Oyj+0CCXnT8?=
 =?us-ascii?Q?tfaSqSP7hYIlJ8HKEU0WKBs14/Reb3L5RMcuB1NhAFE1gmuD4oR+5gC6VWSW?=
 =?us-ascii?Q?kpPFYagaM23FgBoRFJP7Fodyo0GPFERXuS1eUEBMluSfWzlMsSiEEIBPTe6q?=
 =?us-ascii?Q?gIi/8mPF6YfVOuF7UiDuI2kpfcjQ7VkeLAqs4L8WHMEcOFW3wzFjegL55rI4?=
 =?us-ascii?Q?dDjGMpo0Hk8T7dNB7DEkXawA9AHa5B+IM7o/H3VsR+0LsYnSC6Lc4W67XmcA?=
 =?us-ascii?Q?6rjog4UHNO/dqJOVfgFd2e8vdAAWMLWGEzh4a039dvy3PHLvXJuHYYLzULxO?=
 =?us-ascii?Q?dDZJIgYY83Uj7bvgl+ZMAtte+hKyFlA7RoaF7jLxUa+szD1JNIq8NkIGgXZh?=
 =?us-ascii?Q?wPTJaAQVlwYUm1fqJHrTiQutEuLkLgS2J6q6/APYC2zZXc/UeJ+6eFtP7P1I?=
 =?us-ascii?Q?AA1rNT8sa48QZNpMcJe/J7wB1C/H2TcQC0+JYkryR9ZNACsW8yezybIRv/UR?=
 =?us-ascii?Q?HYq/aXWzsAW4VSVxuVtkBgPoXEfKksOWHLArLdGbRPuNBxSbSGjFW8nmA+Oo?=
 =?us-ascii?Q?IENvs2A/iYzcAxjslTZREwHRkPFgJNo5u6CZBO0d0q28lglzGcGkN0Gt/I0I?=
 =?us-ascii?Q?Z2qQF2tpUcUk3ixb1E9VHdxpcMz6iiDJofXIdN97h+uqcYGGf67gnroAy65O?=
 =?us-ascii?Q?4eLfTWN0UbJL8iXkHdNf/0VeC+Wcx/6cB1zUbhfv/u7HekWEDNFWrBlqKyg4?=
 =?us-ascii?Q?p2c1l8FW0uGtBIhtfhNanxEB1eOhWh3CrLJb/HuAlkWxsM9cqUZYS+2PTVyo?=
 =?us-ascii?Q?EqgOGhvbm+ekTNjUs7cWgcg2TWfQpqq6nAQ93mBIaBOVJwphuw99loZXOQOn?=
 =?us-ascii?Q?RZQW8RWbJ5/a9q/Z9ZHWfd5VoIEDCXhCr8FS1HDTPHnKMA11x4FpopNRpO5w?=
 =?us-ascii?Q?u0c9j9yxzdT7+6D9SvYZCgZ6XeCA9+TVaTtl3LHAX8qjEuQs5+pDsapmgDrx?=
 =?us-ascii?Q?Xo9tNclNaLWAIKCoXA+z8jTW5u2SkFD/AJhIwzEtsqwniw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hIlCNMyZelNWOYKnFlBx8d+frtPqKzPzIQEWXWX25Fw+z8O28RWlZ2OMKvV0?=
 =?us-ascii?Q?5bGPSd+sq4nesv9EpqIOTik1t7r2UqW7BthrJ454e9fnTwKL1hiEN+7hvqdu?=
 =?us-ascii?Q?0Vz89cJ6g6sHS94+HsTjzV8VdTBrxiYGCpZRdeisUqJmokaqerw+dW7oJl3d?=
 =?us-ascii?Q?TM4HbQcQh3UpVXYZvBEdMfcXsRD8/tcnSFpTCghSh2eY+XHRRkquVSqcX+SM?=
 =?us-ascii?Q?zPK7X8PIp/h1RhgPPEJF3v4fnqAqNahpKb+pNg7a+x3dOOBE1JRPDHYBJ4Nz?=
 =?us-ascii?Q?+PMX40ST4ZnqPw2lCUT85lAmOzHwcDuZyAYve9s4EivzRnC3Hrdhxm75XDYJ?=
 =?us-ascii?Q?Z2jvqzqI6NdpGVZRE+zpPgpDm9H6g+AZEnmLwoCdZvH/nElB4vv4hQtMN9UH?=
 =?us-ascii?Q?leVmzIA9yD56do6N4nmapxGLUahDZPA/4IWJdJrEY+UYl7uTWWMNFroBmwK9?=
 =?us-ascii?Q?UUD5tLGBqjt0HQEl6pMe9+nFddQTP/PBCUo5ZHvFVb6AzU8W3OPjyMbJtrY6?=
 =?us-ascii?Q?1Ip8mLGNnPUEKd1f7S2reUGQhKV8+CB8J0xVgwAq+riMTGeKSXJq0nvyyaRP?=
 =?us-ascii?Q?rDKpS9IL37F3Iho3R2FsC5z404jWg64JWhmVx00t6v0IX8FRbUdIOfVCDhBt?=
 =?us-ascii?Q?tdSHRTo+3R+LbUkReQmbadd2yKpR4u8Daoz4dYzN9PWZn1DNyV5ZuryDFSd9?=
 =?us-ascii?Q?w5zVRaTwR/1RlWGjaXRlwCQy3ayS2ddgwSmSioWhf2T1mrlUHO13YDfN/0Fh?=
 =?us-ascii?Q?yl3MzpSxDn9zCDquafR6h4HFWoJ9lg2hHF56mC4nNieM4Jexs7p4dgwSO0E+?=
 =?us-ascii?Q?Q4B7gCnPKEWt96uFvaUjrmIFGw6Vk6u43XQm3WWJzI16q3kRZMyvPp33ByZx?=
 =?us-ascii?Q?Y9eGsagV3ebcc62NXwhFE1skahsU0hZ87IbnJwewEjvnStMHrSbPiOXbDCBf?=
 =?us-ascii?Q?vFVqPirtWrLneXpRGZBWNDSCVSqTjO75fQC62K1UYaccHq0p03hYKdXhJ+xf?=
 =?us-ascii?Q?6rDh411qvdGSoknk9K97JCYUhgQxdwaHFz4ksMWLwk3WI0tRRlRZUF7UW9YV?=
 =?us-ascii?Q?Ayx3fa/n0/clT3aRcV6+7ME6kr6zqPq70Shq1OmmjPA5bB5El7aF1ey7OYYY?=
 =?us-ascii?Q?DM4NU5wKtp31CqDWbnq518fp/v4AiF9L3XEpqTGjvHY+p91CiY+9fWRwx06O?=
 =?us-ascii?Q?V6hc3hSYrh8FOif/qsBZsNGacFiO1rqXgCbVxu9CdQ9gt/YJNW0cGXEAUutN?=
 =?us-ascii?Q?ulW8LLR8fzO84E1QSTcHGBmjj9rqpRdeQUUKPXEw5plTOB0bttXHCHRtTg8J?=
 =?us-ascii?Q?t6Go7PS81FnRjucmDr7F9zzMr3lv+r/K+e3nDPrylS7yq696EPx6CwRlsT7S?=
 =?us-ascii?Q?f1YT/UZYB5NadwU1n8CM81BDQkw3efYY1txPbuuLnymDaU3WXYgQRtKZWKDT?=
 =?us-ascii?Q?pCwudzQYHgmJNfKr80RLdEVklklGm23qWmofX9zZdhGHC8MvscZqFS18r4IH?=
 =?us-ascii?Q?PBLYj63tvnKjM9Urz81EFaxw53utBkexhJEr4Mp7mvSY/xye7LOy4xGptgjA?=
 =?us-ascii?Q?+HAiluIrV4BwEAZKGm3L/+DIhQXWez6lDSu260rn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcd19a5-e088-491d-0eb4-08dc96b5f284
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:32:18.3090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlziyzC9P7xVcyBNdFUgUJy3sq/ofw7xnxyShGrQIMzYkvGyMceK32VSpCOHb2yVMiqjubTUo5DFtkMLqdSqwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5087
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Keep the access_coordinate from the CDAT tables for region perf
> calculations. The region perf calculation requires all participating
> endpoints to have arrived in order to determine if there are limitations
> of bandwidth data due to shared uplink.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/cdat.c | 10 ++++++----
>  drivers/cxl/cxlmem.h    |  1 +
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index bb83867d9fec..fea214340d4b 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -15,7 +15,7 @@ struct dsmas_entry {
>  	struct range dpa_range;
>  	u8 handle;
>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> -
> +	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
>  	int entries;
>  	int qos_class;
>  };
> @@ -163,7 +163,7 @@ static int cdat_dslbis_handler(union acpi_subtable_headers *header, void *arg,
>  	val = cdat_normalize(le16_to_cpu(le_val), le64_to_cpu(le_base),
>  			     dslbis->data_type);
>  
> -	cxl_access_coordinate_set(dent->coord, dslbis->data_type, val);
> +	cxl_access_coordinate_set(dent->cdat_coord, dslbis->data_type, val);
>  
>  	return 0;
>  }
> @@ -220,7 +220,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  	xa_for_each(dsmas_xa, index, dent) {
>  		int qos_class;
>  
> -		cxl_coordinates_combine(dent->coord, dent->coord, ep_c);
> +		cxl_coordinates_combine(dent->coord, dent->cdat_coord, ep_c);
>  		dent->entries = 1;
>  		rc = cxl_root->ops->qos_class(cxl_root,
>  					      &dent->coord[ACCESS_COORDINATE_CPU],
> @@ -241,8 +241,10 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
>  			      struct cxl_dpa_perf *dpa_perf)
>  {
> -	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++)
> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>  		dpa_perf->coord[i] = dent->coord[i];
> +		dpa_perf->cdat_coord[i] = dent->cdat_coord[i];
> +	}
>  	dpa_perf->dpa_range = dent->dpa_range;
>  	dpa_perf->qos_class = dent->qos_class;
>  	dev_dbg(dev,
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 19aba81cdf13..fb365453f996 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -402,6 +402,7 @@ enum cxl_devtype {
>  struct cxl_dpa_perf {
>  	struct range dpa_range;
>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];

Need to update the kdoc.

Other than that.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

>  	int qos_class;
>  };
>  
> -- 
> 2.45.1
> 




Return-Path: <linux-pci+bounces-10183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E7592F024
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 22:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4E01F236C5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 20:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9690019E829;
	Thu, 11 Jul 2024 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKvZBoyw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E2B17C216
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720728510; cv=fail; b=eVhIJQsocX4Lr/DoGHIMfsSiO4ZqCiuHidW/GZCzZg65DLSZ7hfZQbR/ZDVJX7NGisQHyDNxdik8IKnjmy27rvy94IUvtChdLgRfqUdXIkX6ndFnS5CJXmGRePRFXI9W516kIETuqMRU8pK6jl1aerU0mxzSZajXNbwhR5Pjm7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720728510; c=relaxed/simple;
	bh=QQjF/QjYeQENlF15gYlbpYqq0CkjePvR4hqSiW6e7rg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HKPRNInAvCDaO0N6JZW3h5uWhSR9oGN9lVyc1KK0jhtfF26Db/EABySHIRjJ/OWktmXZedoNNWGs/ZZvUTy1ZlJ7BlGgHhq5ZaJt8SOxrMBux0hnUsojHke3Hw5tMTpSZus+2UyC/RmGyMA/e3Wt5usvcPg0XmcbIt7x5/+MkSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKvZBoyw; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720728509; x=1752264509;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QQjF/QjYeQENlF15gYlbpYqq0CkjePvR4hqSiW6e7rg=;
  b=PKvZBoywSN0IN/t0ndmCsmyIECK4UISxv2bt6DssYeKPdWTRHs0448X6
   NyyZHWqbTNkDEoK0MwuakF2Uv1AwrgLWznvMqY6Ea1AB3orY+kuKDCk++
   KcVCIzWXg9lWWtfMxeNORxpktFWqBptkpmvCJPQDe5R3/r3guyB+W2NS2
   +Ev1vwY55o7F5aS3SZKDWJiajO8f05ngO9qNP/qtxAiSuTFrOpnRcDYFT
   yVKzpjayI9dMrZFzPvgR1jv187654f9D4OA+kbM3kIiOnFyROt1buxd0C
   uCOBp5htNCJHD08yiTwvv9UuQEMJmTIhZ6lX2rR4qJ6r7WlwltP8oWAAo
   Q==;
X-CSE-ConnectionGUID: Q5iqQU8KTR+M+Ewal6kKZg==
X-CSE-MsgGUID: tyd0nqp2T8+Lw8neGjRqjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="17759790"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="17759790"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 13:08:28 -0700
X-CSE-ConnectionGUID: sZIU4I9sQnm+BYwCCp4WRg==
X-CSE-MsgGUID: 19DfPo+8SwuKNNgaJX/h2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="49099377"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 13:08:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 13:08:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 13:08:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 13:08:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 13:08:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjTTY7abYGtV19XrDyFcb7DckAovDuCwfzMq7f3Cq6hpN+HPJSNIHIdUe8YaH0LY9ofehVqTNe1F9LtbR0C94lknssfQRJsV7D0C9GzprB783cdKCUX3VkF2xO8Y8LLJ2b75fRCHQjgVtfqBzV31WO0JubG+WF5UhEB007be/Sf472AV0x56TLSG+qHKWl5j/5jIO3E4it2NxS57UsypOct9YRDQEOIwIvmci6EKTVRZNpGoRqiNz+NTx6vOs5u4lBEB5iFl6jPXTUU7p/0vKXI87RmPQdZkaWp/TpeeYoXgoxozapPgfT1+7NSdn5gR+m8udpUKFMcf/qRoBPvshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZOmKcv4mwxoSNCY4tCeDXHLGG4Equejm4MDLpYq+Bc=;
 b=V5QHl865gm+q4rJEiRtNI8wyrgyp0RBEhmZS3lKVOf9f+7Z9zlDZiBKIMetehNLi1jHM4p8T69pO8PAyB1mtnZ7LlG51GwVl9gYJQgJqbtsusHDaun+ZP8nD8A4cGPoKMghPPHgE+XpddMg3/4Pj/P+K4lCWgafCjDsNfs3CcesQwiSJWx47/RhHn9Lurnzr7PUnTGDcyZeOvxfmDPg9/QZeGXsQMUoQkGgqXDzypNxAXoRaYsK/3Wpo3L7Vo20PHc8o58TdPOhaY3BbvmeY7UTaZ9/klDoFvvwjWqkHGJ+kx6B2m7sYsQj3ni4KfuIA05QSnuTVoXfNyyDhksPxKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8041.namprd11.prod.outlook.com (2603:10b6:806:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 20:08:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 20:08:25 +0000
Date: Thu, 11 Jul 2024 13:08:22 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RESEND PATCH] PCI: fix recursive device locking
Message-ID: <66903bb6a8c44_102cc294d2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240709195716.3354637-1-kbusch@meta.com>
 <ZpAwp7K3YtZqg2NZ@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZpAwp7K3YtZqg2NZ@kbusch-mbp.dhcp.thefacebook.com>
X-ClientProxiedBy: MW4PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:303:b8::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c5eeeb-f1a3-4ab1-60d3-08dca1e53897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lRJy362T6O3qjFfAVWtDowPsjOWIgW5qodM52mF/BFFFfwYqWwyAkv0kDksp?=
 =?us-ascii?Q?liOPAeY8NULdbKjUtj7eGH7MPk5Ohn3pm7Zu34Flu0br7c7IZvfPJoZiIREY?=
 =?us-ascii?Q?xjtse3+htol8Ikg8mSJzHOHHuHaeAn0mWQuvxv1R5z7Ze8XuM9VSmyAk0tYT?=
 =?us-ascii?Q?WQ2mm2hcX8nlocgfRCIhqUaXMEMB2ffNKw+m9zPqbjTYzmJRhkYZFjoVWIhh?=
 =?us-ascii?Q?wyB4IdEY8rKQZjoXUjUGGLArTLcuvySyXMZViRU61iB9EbmNRjfnEh+H+N23?=
 =?us-ascii?Q?D0e6ClYJlv8Wx+kHtd5XTHAspNNYXFGDm1FMfF/rcpZ3go3bgzwrHHZf97G/?=
 =?us-ascii?Q?YF5hE2zDORBB5eL78pc381x9Jhu+zu71rqe25gB1rn1Y5Ou6ci0SJbo0wgDh?=
 =?us-ascii?Q?D33QfLgA4mfePebum1jOs1qDKRq37tPu0aGkYGL0XtGhyTKwWs3G8qvVVhSN?=
 =?us-ascii?Q?ilo8YVdNid+1RCtM48MMr4ZFh6c0iLl2j4OaIyDnDXSpo1e+3hntIImHmSbL?=
 =?us-ascii?Q?e3957IUvW7nTcly26jxvCn7vX4/GFIjxKHTKD2ltKc89nAGlcXPXr8EZNuDV?=
 =?us-ascii?Q?DtKYi8nl18MgdGEA+Z0fFRtwJkON4VMuU/nvlvTbjcRkwTr37daSFjn1jafz?=
 =?us-ascii?Q?5BSCVxvXUvn1JoYUYat/F03SpFnYOKBRajBMSbkusqH49OFPlVvUnQtQLJax?=
 =?us-ascii?Q?FCV9WVGJXJkR84LZSvL1Lhm4kNbqjM1N8ygl2JhvMAV4+/yuKntz0x1Zt6En?=
 =?us-ascii?Q?BC5twyISUC34J/3mYOjYMzr0xKEBCIyrjJd9dE61ZkMRfl58PjbCZCPIpRzx?=
 =?us-ascii?Q?1Avq2jQKn0NfH1Rcpc1WF2LYpPa8ArlXNzxEqebGfsV3U6dA7NIR+WxaPK7/?=
 =?us-ascii?Q?htq3Kl8WVWxx/tgKzPTKg+PVhY0P7tym8DxyUGs7kka/NSNkCaC2NijVm8Kv?=
 =?us-ascii?Q?LGOcIJvK42assjWM3z9OEWR93CdMReMeOsNZM66KYjbe0U0zfPEslp9+GiTE?=
 =?us-ascii?Q?t12esiWQ/OjL7vt19NTQYW3Rvxo3UOW7UniwVOas/kN1qV8jWRpbPXMmLqJd?=
 =?us-ascii?Q?9qsmrJj07OF8MV953tXZHLLEykYTp0dnZ+WpXLe7R+82cBWBwZ4zspqhvRfg?=
 =?us-ascii?Q?EQAxzpPNP2iBUQCx+IpGsJW0Vpzf1g984V4J+MP0WzMWInIyUjYbtIUoggJE?=
 =?us-ascii?Q?1q5J5Y6S2umCJxKUzfhbKYBRoyDc4wgmtJ446ccxcVYXaAC287sxblAsqbt1?=
 =?us-ascii?Q?FfSJftlAHBYjZV8ONg7Hynajsqz6XtgCQ0icORl2p64vBjrY8v7j1Wtp4ZkO?=
 =?us-ascii?Q?YI8GpbVLelDpJJi/TllR8zoQfa2hX1ouTPaEegPdv/XB9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gtXqAHCBiUGIGpHZTXxmsrwdCoADSydeEHteozbd7lly6ypwHCjqpgEF7Chk?=
 =?us-ascii?Q?Yq57OR7jrPPwQISHwa1oztJyeq0/wKhuhP0Lnuff5/YSekySl+5nf8PZNwDm?=
 =?us-ascii?Q?+b7HO9L4x9L9G+l/CuCujEI24edvHSrIw2wWNJYgmEMW2hpqXJ44XpqNSQ7N?=
 =?us-ascii?Q?hkXeYQ+YKCHDkiUzApil+MMIt9QYsNBh6/h7ndvrw8rTf8Yk1/tGrR3aVDEm?=
 =?us-ascii?Q?/rRVA92dMtLZpxUkl8zF1NVbUny0gJTUQJ2wkh+o0QpeC6btwLp1/EM2cIdx?=
 =?us-ascii?Q?5rrtoc4MCBXJSgwOxHFPi7aAonxpCZK2PggsrYXZfl3Bl9C1SuwrO3yNPPcS?=
 =?us-ascii?Q?9V9Lv8z1U7lVoZNhzV0q9Ub5Gs94yXVfzkTRXyUPJriR25PFDn4kc2vGAUd8?=
 =?us-ascii?Q?WdXVS34BQzXUrd3QcZ4r9p2bWl6BwbgFodiC+a7iefUVWC+LcrTcanSYQalG?=
 =?us-ascii?Q?VFD1LLh7GsdL5p8xb5Oq7FccRvfCm2k0ocQkcZcC2dU2/C5btm0DKOQVncsB?=
 =?us-ascii?Q?+mHCdg8i14FmM9c//Pk4XUPZOTiXg2BdRMARs0flz7Ly/CXdva6XVYEKkx//?=
 =?us-ascii?Q?v3m13rs3SeTadIoHthQOapGX3Pe+IiCqAGU74sw8RrLbhMiMbv9kgUnJ+9tk?=
 =?us-ascii?Q?kOIwU3KemxPSbUVAp7lC7dw2PtyMXDHUitw2g642KkmdUzgm2zczlblpWvSo?=
 =?us-ascii?Q?0cBe+LOYh2JM8OJFjGdrmTjSEweSuNP6UacJvI5YHfmf9U6GZ88JVpfsurUV?=
 =?us-ascii?Q?Sq18wh+hK5ZS5Wbm1xo0VUJNnCcnvGqUH2aw3U0W6eFy++JmGMbREcrHSa2p?=
 =?us-ascii?Q?xlPxdH8bhrAJIby8qsMBRNcDm1qrQYO97+G9SIe24zgD8gWo6De2JtybamJ5?=
 =?us-ascii?Q?xuuIFBjiN1YN1T0uw3pyY/3cZXFd7zKgVY6NwVNfW0U9Fa+qY6y0CSKwQl9+?=
 =?us-ascii?Q?ZSFVck+ecAA4QPlsOcRdiiGzAaQDJUPANpERv23ZbriBOU+L279i8qD1Z3Ii?=
 =?us-ascii?Q?BEPj38IGSJjRFL9POcQ8bPLG/HQwUzsgBpTbDjleiivWYSCwZ8DXFRPh3mG3?=
 =?us-ascii?Q?PCwgEFvviIqOaDCpNkoTGSmeEichDEao9uO6XHsM21gePHHTM8bCKG2bZXMg?=
 =?us-ascii?Q?aayjQNR7YrjvtoMSz8AjuFg0wH++6047iG4Jbg3YtQXZRi41cIhZp1ZRBX+G?=
 =?us-ascii?Q?DG5YhcrmB6Hu5xFbfxDNr9lhH2vwrNv6owkrjly1FeU0cSsUu4wi0CN3et9g?=
 =?us-ascii?Q?jjW83KhsID1io2iYLx0nQHgsRX6+VIrQNTSyHzs7RmX3i/6dcfLtiTtf0z0C?=
 =?us-ascii?Q?pxAYEL4h4e6b4iqASzr84RNZd+PuUcSbtCwH6F4HKRERlIX/0N9ESHtNFHJs?=
 =?us-ascii?Q?IG+XXsEIQynM+vb91Au+dF1YUlgt7QpmfKmMq0TyAwKYoK6aa+Y6DA7lR88J?=
 =?us-ascii?Q?s05Y9tq9hwBpog4zkeOk5rm4xH72wZoFgqqfXlKHF7bc3t8Mek2NRtZsyZ52?=
 =?us-ascii?Q?oEKcx3iXKQWBRAiQnIC2ut562NQ5eXPo/n2cNdvJTFV66L3HBZn1XoO/lzVE?=
 =?us-ascii?Q?PtSYn21T7kedybdd+TEe8K+mWOo8SSoq4XdxKzwuX4fys6ZdDRiuBl3R6L2/?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c5eeeb-f1a3-4ab1-60d3-08dca1e53897
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 20:08:24.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHZ1DBlLoeMq14s+sTNL279tCLlAhx5CrQcAW0+2q8BGxzOT5v52hnuwXCFAgC7EAcezTKE2iHm3Z0m5JxQLVciHFQwIEMgvZaNdXuZNTKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8041
X-OriginatorOrg: intel.com

Keith Busch wrote:
> On Tue, Jul 09, 2024 at 12:57:16PM -0700, Keith Busch wrote:
> > @@ -5488,9 +5488,10 @@ static void pci_bus_lock(struct pci_bus *bus)
> >  
> >  	pci_dev_lock(bus->self);
> >  	list_for_each_entry(dev, &bus->devices, bus_list) {
> > -		pci_dev_lock(dev);
> >  		if (dev->subordinate)
> >  			pci_bus_lock(dev->subordinate);
> > +		else
> > +			pci_dev_lock(dev);
> >  	}
> >  }
> >  
> > @@ -5502,7 +5503,8 @@ static void pci_bus_unlock(struct pci_bus *bus)
> >  	list_for_each_entry(dev, &bus->devices, bus_list) {
> >  		if (dev->subordinate)
> >  			pci_bus_unlock(dev->subordinate);
> > -		pci_dev_unlock(dev);
> > +		else
> > +			pci_dev_unlock(dev);
> >  	}
> >  	pci_dev_unlock(bus->self);
> >  }
> 
> I realized pci_slot_lock() has the same problem. I wasn't able to test
> that path from not having a pcie topology with a subordinate on the slot
> device, but it follows the same pattern. Same thing with
> pci_bus_trylock() for that matter, so I will make a new version.

I can take another look at that one as well, but feel free to carry my
Reviewed-by tag on that one, and just trust that I'll scream if I notice
something late.


Return-Path: <linux-pci+bounces-8979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C0390EF24
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 15:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F821F21A29
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BF113F428;
	Wed, 19 Jun 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ArC6wFIk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5063C0B
	for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804204; cv=fail; b=qA/3NxZcn/9X4OyyzMSc//Gmu7H6II0XgC6z1tVx/C++lPC0B7r5Kkb+YckLyJGcBUELPy0003Z82ztLMtHga2iuUroPqre0eYCT+T+PG/QN20C1GTI/zi8Sie9bfdZGdwCbTEaU32qJE2DPj31S0ZnwpR0qN2HSVbHraGHqJCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804204; c=relaxed/simple;
	bh=Jk/mqkuzd+ImWrd6riG4/vAkC5qbnN6S3IOmsk0bwck=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=utjPVcOVQTvclcxMlzLkhQHRUJMbhM2yAoJOS+ca2QRZA4q80AR1okZRMAUDyTGa727VM7vSJuc1blqfiRQkQZa33F8GJkm83FpR8TNnnKtEB2AttCrey2i4JVbsOgX6jOb/7Kipt8iJ+fAiJBxY51jxg7Pa+3FADOPfKYEJbbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ArC6wFIk; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718804203; x=1750340203;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Jk/mqkuzd+ImWrd6riG4/vAkC5qbnN6S3IOmsk0bwck=;
  b=ArC6wFIkYOK79ZkYrtUsB/O6tD9mxZ7LOPTTLRMjZ6OqqaNWw6wp5rKY
   8rl/gRDh3Yc4uaMZCg3dLxWnN69F3zcSQlKU48sRKOy3W6piT2Pvyei/o
   PL+OyeyvgEntSZaEQh3srDlPzyAwyz6QgiWNOxnNtraXxuwIg2pOo/JoK
   QJ1fEd2bpYvOU2qvFuAx3km20Glhc7naQ66ZHwK9MeCKXyruZ/viA3qtu
   1C9yX4DbIDTAeTBhxEUua3xIiKlan+SZ3F6uXoyURHbLDiI4uvgfOk3lv
   99DrGvJJoxicIweg/XvGkPmRz+oppS2+WSjfiADwamLw/uUiHzc+Mx2yF
   A==;
X-CSE-ConnectionGUID: KXNbx9ttQDW2w3NDcHTs7Q==
X-CSE-MsgGUID: BaRcKjmmR9OAjIR6bICKwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15884364"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="15884364"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 06:36:42 -0700
X-CSE-ConnectionGUID: a1r2usqdTtWTWFSjpvVkqw==
X-CSE-MsgGUID: Y33dOvCsQ2edLoUmP7Ztgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="41883358"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jun 2024 06:36:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 06:36:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 19 Jun 2024 06:36:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 06:36:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UI7zJkJdz08ho7WgCL/CGgk7O7lzNOWS+LvTgKPWZ/xPwqRQ0aVhNN9UoI8nZ2weENjI/34YfXcbZNolOxdfBr81+Z1ejSpBHieKIJ9OCu9a4Orc88ekBZGiv19+J5esoTlpOiTdNQ2yRvPriLp6t9udwXV95gZ3pJpysFWVZmYA3WuB2W31Lm0j0BUsdB88MUs2t8Y9K8SKfP9rSu+ogh8O1wSGYtBxQ8okqgE+CR32MCH0uvS+qYD8YpSf+KSwW0kytziFG2pHeqMsKH8fdQuMEIurH171PGPXfmDMGucAFPb8muw2WzMOaizyf7/uwkrb46EZr9d1GdT/Jj3I/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXBYIRsdq/cs0D4+iqn9M6CceaI2YVkeH8X68aKnZtA=;
 b=FIiYxW80LIf0l3EunJl4ob3GfNGYixJ9BkIvH6VN4btJK4QJ2G1i5UA1DqFd5pvnSkhK3g8dvx1PqwBoLOdHVHYUAf70/MuoN1arVCzAv68oeYOePfFgp9UXX0vN3fxBKo/cZ63OBOUlk223S/tDfM7+rU7XeuxTKPYEtW6hMoxu9hMSr17QsQStJ9XsFCwiYOzm48A3xd2M/NxsbZD0yHCO2zbptAoRgbkaQRm2ojY9QQFrpv92/t2BlVr4BMT8ycHvj/nHmM16BrJ+Zc033fPOIjy5zwD0UxPyQN/8tQ4qZZp4N0VKAeGAL6VmXbJjGlPA8oWWsh3tzO9IbuEZ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 DM4PR11MB6477.namprd11.prod.outlook.com (2603:10b6:8:88::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Wed, 19 Jun 2024 13:36:38 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7698.019; Wed, 19 Jun 2024
 13:36:38 +0000
Date: Wed, 19 Jun 2024 21:36:30 +0800
From: Philip Li <philip.li@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: kernel test robot <lkp@intel.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [pci:endpoint] BUILD REGRESSION
 1b2ccd0341a6124d964211bae2ec378fafd0c8b2
Message-ID: <ZnLe3dOQNg4TZ5HB@rli9-mobl>
References: <202406141054.rqus0osg-lkp@intel.com>
 <20240618154503.GA1257212@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618154503.GA1257212@bhelgaas>
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|DM4PR11MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c0afd6-b9eb-41e5-82f6-08dc9064d883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZQpJGlUST+qv+bk6xhBue0cKpBUCwBjWJIad2QKFi9UxMAgJg36GWEF8s7Xf?=
 =?us-ascii?Q?O2GS6Y0+iu7Jb9FeYvi7LgiPFsPe4W6A1FjC2m9+YhnLCD1HE6801PTdgn1+?=
 =?us-ascii?Q?BmzKucbMZ/CV3ZrcZiAbc6rEoNnU9Jz9K4D0fc1O0sgI+VmgmYOc7bNzWesj?=
 =?us-ascii?Q?45q7C3kGv25XkcXBnZXW5HezWwdYKbxdDmWporcRUqIm020fIxYMwMbLRHF4?=
 =?us-ascii?Q?fJ1mzkomZs/5jb/KhBYedY3eCiNCfkErkAtjZwMVhaY6t8KuyDpc05Hz1anp?=
 =?us-ascii?Q?X3m1fpBbHom1z24fcoTJ/26mpC00b73zWc12dB9ZbEzs5AeXY4D+NZZZr47c?=
 =?us-ascii?Q?9X9Ckt2ifioHwSWQwC0KNjQ6on3eUY4spbSke33kSILiDxtIwP1kN/bi8PR/?=
 =?us-ascii?Q?jd/3M9pQJG4foXY2JFngoY6ZRx5kv//A+PjeaoH85LMaRKX5esgHkmc8vPKb?=
 =?us-ascii?Q?4qFLc3o+WEZJif9muLX5qdbaIhA1VDRIOUuUD2a906YCz5EM75ZLaCsHXom4?=
 =?us-ascii?Q?r7uETwFW3I9tyiVjTMzIVG7uanJZS1mRTCJxP43+PwutN4hD7uul3ikTwWdg?=
 =?us-ascii?Q?FI6CLEhja7MOxS3Zxesc9TJ/cKMH4cXPCS+H3uzaFWoTsgAT5HSuUns8/93m?=
 =?us-ascii?Q?BXQZVcNFsrqV0rzKncEbzNheyWsBS6gLLPkEkomhUMFNG0VORFCeA4ZrAd7Y?=
 =?us-ascii?Q?TMPQXb4Ia3m4vPkYg8dHXMUOid5w6s5WNnskdBaTwW86F1pB21mkFuTaLfwj?=
 =?us-ascii?Q?Su64AxyNTBjOVX5+ZAzvowMqTjHaIfl/RVnn6AITDYhIk26vwdmpP0jRB0x5?=
 =?us-ascii?Q?VFQYlwP2cJ2ghrQnAkTBYX1C4o78XcOtUbBH5/U0cPvl/sjPbtZ19pqCHsU+?=
 =?us-ascii?Q?yxznPLRJ2yiITD1HFKVS09UepMeXyWT41+hO8Mbh3v60KwFcet5v24mz725z?=
 =?us-ascii?Q?0F3cVC/FFOOsgq1YwmyxFClhkeg3OV+mk1HliPz1OK+wKDFGsqtpvubgwI31?=
 =?us-ascii?Q?mLICEThtwIHy6k2vjc2yrssWsvGLSeLD+rIZ2JAU2W/OOQTMq8AvnbDla3zi?=
 =?us-ascii?Q?/XmrNEF+ioKhTeF3lh7TFOhnwtcZU2431mf/VgN9WeTwMGrdYumfTwl5rLJU?=
 =?us-ascii?Q?lzGYlWZ5ASzhKun+595kvVzz6aWLncveLAf92QuXkq2/w2YaZ3l+tHBvVRJK?=
 =?us-ascii?Q?mW636S8SGBaGB736QOv2Tjnx8ZyomCneIQN6h9SXiC9Tqoa69GxHqOVqtRiQ?=
 =?us-ascii?Q?gXgXtNKg5deiFse2PFOUU8kyHR3xf391iWUFHunh+w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?42rIXR6VEntzm8lGNR4WBYqnfaqQ0s43tOyGYks7oEMZkwKL97+s5QNKfgN0?=
 =?us-ascii?Q?omgvO2MahxikD4LiaEj4n6sxfzt1hVKWINmVUCV3QjS0v7l04WYx8QFHN2uj?=
 =?us-ascii?Q?dOt9M9rxbQALkwqcySjiT3O3y73pEB4J+ui5Dh62Dcs3GfWDWJo1Xe8ZjXKG?=
 =?us-ascii?Q?ogWsFG4yrU48cxaZa+sxWX/eA0/tOL5Q0ElUP8tRrupN0PaD6br7otJ5RnZh?=
 =?us-ascii?Q?DHX6+lV+6iBrmD5k6W+qOqQ8ZbQ5nTo+lC8xO/GuySrZm8lOnCWnVllyolly?=
 =?us-ascii?Q?QpM5PF+IJhEG3Zn5glrHG7UhyXW+bJSJOkyr2b1wKcm6iG4iaGVOR4bo4xbh?=
 =?us-ascii?Q?vmQzD8Yq6E+Zkd6pO/bQlGSD08lZoKitWLp8yoLAzHQtZPxctZflpX9JiHVl?=
 =?us-ascii?Q?iOBQc4UzHtOPqa/CE6LWeT4l5oeI6M+ZiBhymDBW/s2ummNX95uoY1QHQMyG?=
 =?us-ascii?Q?k5gf7csj4GmkRxT/mdA1lqQ1WHZF5YI4dCXRBWA3Kn6N8T2hHJ7shppGMroF?=
 =?us-ascii?Q?eA6hgLIW6xhFJCSjvRCtVlRuwMOGUKrkbwOXmnVhenLprRt4gTn4RDtp4Dss?=
 =?us-ascii?Q?0fgOSRPAURDIWH6F4N5MAo7enV3+6EgbFTizhBC6wO0uAW0OmzXkzdiUeeDI?=
 =?us-ascii?Q?DxXM4DMZcvKRsaeH+0BwXVO9dpbmwfGkWGDCTQXt8UfGm4stSFhqOcfUJNMG?=
 =?us-ascii?Q?u4ppMzkybe7XZN347k+TTH338QWjCnNe4Dhwwzv3Mgh/mz0WnC6Qh4rEiBRj?=
 =?us-ascii?Q?5tF565xCmmJmC3qLlknXjjVZggx8AKLYzf7a8ZMnz3e2/Rib6Un7qHcQ59CB?=
 =?us-ascii?Q?iFilcPtXOUXv7nig9U9VvMU+32zbiz8cz3PRnwlyLGlEx0h5v+3rOEBy3Sln?=
 =?us-ascii?Q?iRZehC+ZBiU5pq4cn7Kjq7nxATXNa5bkGKgS3lJjBKtSFi+/jBOeRALbD/i4?=
 =?us-ascii?Q?lRklIJQjISW+sxePynprvzhyxDdQO4HlDI10gmKNZOKTgJ/6+KqGDiS+yDL2?=
 =?us-ascii?Q?OTurDNA4swwcrsEh34tsIfIUQQapYqEFjTMRCkj0AndGYnC9w3v8t8tK9MVD?=
 =?us-ascii?Q?1tTKmLBgika9jfgHHNaW2WYI2dzG3HHZXeED0aqM6S6IwcqN36Cf0q9ZYxkI?=
 =?us-ascii?Q?sdUyHQuSr4fX9Q8qr4nEDtiJLj90I48NqhgMqZHc7TmkSRjbc23eoCehVPz0?=
 =?us-ascii?Q?smCdd3K6UxcdqW6yoZ4JW8YBsRrXvu/3qQPC0CJJp38kovQSu2QPom/3VlKa?=
 =?us-ascii?Q?Ro4rOMOGdkDTQ2jN6TcfFsTb1dA8vbFDFD9qk58e5u+2B9Le23ObEytmnQYX?=
 =?us-ascii?Q?PFqCou3Zp3TNM8JP71HeMSDLP/sYOFMgBQM57HztxVAvlKM4GqCy5OyYJ9uz?=
 =?us-ascii?Q?DEydOLPn9h5h21j1Ep7sraKW4Kpm5f0Gi80/QrbnTRZy01+0fDjKp1ObSa5K?=
 =?us-ascii?Q?wDjCVXQAVFJ+VMc2r6RIElibXtth0Ww6HKSOiVjurH3lKVB/7DTgOIiQSKA+?=
 =?us-ascii?Q?6h1+V5mAeI8dYEiqn7KYidGF0TGXptFkcMEJ/GtQY/IvML9ps+fUfnGRaaez?=
 =?us-ascii?Q?k8rpuTJmJeVx9E8NsPuFfxDNPFmHfDclevyHGDoH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c0afd6-b9eb-41e5-82f6-08dc9064d883
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 13:36:38.6791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oq2y3e8XseajMvHDEN6JNWCCKdEP4HW0STq3LcpiVtGg6dzK6s/w1xmc58iFSZhHC983kzZXxNJ/6SvcL/3z/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6477
X-OriginatorOrg: intel.com

On Tue, Jun 18, 2024 at 10:45:03AM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 14, 2024 at 10:32:57AM +0800, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
> > branch HEAD: 1b2ccd0341a6124d964211bae2ec378fafd0c8b2  PCI: endpoint: Make pci_epc_class struct constant
> > 
> > Error/Warning ids grouped by kconfigs:
> > 
> > gcc_recent_errors
> > `-- sparc-randconfig-002-20240614
> >     `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
> 
> Is there any further information about this?  I don't see the config
> file to be able to reproduce this failure.

Sorry, kindly ignore this, looks this is a false bisection and it doesn't
send out final bisection report. It was wrongly recorded here, and we also
need follow up to fix this problem.

> 
> > elapsed time: 1692m
> > 
> > configs tested: 109
> > configs skipped: 3
> > 
> > tested configs:
> > alpha                             allnoconfig   gcc-13.2.0
> > alpha                            allyesconfig   gcc-13.2.0
> > alpha                               defconfig   gcc-13.2.0
> > arc                               allnoconfig   gcc-13.2.0
> > arc                                 defconfig   gcc-13.2.0
> > arc                   randconfig-001-20240614   gcc-13.2.0
> > arc                   randconfig-002-20240614   gcc-13.2.0
> > arm                               allnoconfig   clang-19
> > arm                                 defconfig   clang-14
> > arm                   randconfig-001-20240614   gcc-13.2.0
> > arm                   randconfig-002-20240614   gcc-13.2.0
> > arm                   randconfig-003-20240614   gcc-13.2.0
> > arm                   randconfig-004-20240614   clang-19
> > arm64                             allnoconfig   gcc-13.2.0
> > arm64                               defconfig   gcc-13.2.0
> > arm64                 randconfig-001-20240614   gcc-13.2.0
> > arm64                 randconfig-002-20240614   clang-19
> > arm64                 randconfig-003-20240614   gcc-13.2.0
> > arm64                 randconfig-004-20240614   clang-19
> > csky                              allnoconfig   gcc-13.2.0
> > csky                                defconfig   gcc-13.2.0
> > csky                  randconfig-001-20240614   gcc-13.2.0
> > csky                  randconfig-002-20240614   gcc-13.2.0
> > hexagon                          allmodconfig   clang-19
> > hexagon                           allnoconfig   clang-19
> > hexagon                          allyesconfig   clang-19
> > hexagon                             defconfig   clang-19
> > hexagon               randconfig-001-20240614   clang-19
> > hexagon               randconfig-002-20240614   clang-19
> > i386         buildonly-randconfig-001-20240613   gcc-9
> > i386         buildonly-randconfig-002-20240613   clang-18
> > i386         buildonly-randconfig-003-20240613   clang-18
> > i386         buildonly-randconfig-004-20240613   clang-18
> > i386         buildonly-randconfig-005-20240613   gcc-7
> > i386         buildonly-randconfig-006-20240613   clang-18
> > i386                  randconfig-001-20240613   gcc-7
> > i386                  randconfig-002-20240613   gcc-11
> > i386                  randconfig-003-20240613   gcc-13
> > i386                  randconfig-004-20240613   clang-18
> > i386                  randconfig-005-20240613   gcc-13
> > i386                  randconfig-006-20240613   gcc-13
> > i386                  randconfig-011-20240613   gcc-13
> > i386                  randconfig-012-20240613   clang-18
> > i386                  randconfig-013-20240613   clang-18
> > i386                  randconfig-014-20240613   gcc-12
> > i386                  randconfig-015-20240613   gcc-8
> > i386                  randconfig-016-20240613   gcc-13
> > loongarch                         allnoconfig   gcc-13.2.0
> > loongarch                           defconfig   gcc-13.2.0
> > loongarch             randconfig-001-20240614   gcc-13.2.0
> > loongarch             randconfig-002-20240614   gcc-13.2.0
> > m68k                              allnoconfig   gcc-13.2.0
> > m68k                                defconfig   gcc-13.2.0
> > microblaze                        allnoconfig   gcc-13.2.0
> > microblaze                          defconfig   gcc-13.2.0
> > mips                              allnoconfig   gcc-13.2.0
> > nios2                             allnoconfig   gcc-13.2.0
> > nios2                               defconfig   gcc-13.2.0
> > nios2                 randconfig-001-20240614   gcc-13.2.0
> > nios2                 randconfig-002-20240614   gcc-13.2.0
> > openrisc                          allnoconfig   gcc-13.2.0
> > openrisc                            defconfig   gcc-13.2.0
> > parisc                            allnoconfig   gcc-13.2.0
> > parisc                              defconfig   gcc-13.2.0
> > parisc                randconfig-001-20240614   gcc-13.2.0
> > parisc                randconfig-002-20240614   gcc-13.2.0
> > parisc64                            defconfig   gcc-13.2.0
> > powerpc                           allnoconfig   gcc-13.2.0
> > powerpc               randconfig-001-20240614   gcc-13.2.0
> > powerpc               randconfig-002-20240614   clang-19
> > powerpc               randconfig-003-20240614   gcc-13.2.0
> > powerpc64             randconfig-001-20240614   clang-19
> > powerpc64             randconfig-002-20240614   gcc-13.2.0
> > powerpc64             randconfig-003-20240614   gcc-13.2.0
> > riscv                             allnoconfig   gcc-13.2.0
> > riscv                               defconfig   clang-19
> > riscv                 randconfig-001-20240614   gcc-13.2.0
> > riscv                 randconfig-002-20240614   clang-19
> > s390                              allnoconfig   clang-19
> > s390                                defconfig   clang-19
> > s390                  randconfig-001-20240614   gcc-13.2.0
> > s390                  randconfig-002-20240614   clang-19
> > sh                               allmodconfig   gcc-13.2.0
> > sh                                allnoconfig   gcc-13.2.0
> > sh                                  defconfig   gcc-13.2.0
> > sh                    randconfig-001-20240614   gcc-13.2.0
> > sh                    randconfig-002-20240614   gcc-13.2.0
> > sparc                             allnoconfig   gcc-13.2.0
> > sparc                               defconfig   gcc-13.2.0
> > sparc64                             defconfig   gcc-13.2.0
> > sparc64               randconfig-001-20240614   gcc-13.2.0
> > sparc64               randconfig-002-20240614   gcc-13.2.0
> > um                               allmodconfig   clang-19
> > um                                allnoconfig   clang-17
> > um                               allyesconfig   gcc-13
> > um                                  defconfig   clang-19
> > um                             i386_defconfig   gcc-13
> > um                    randconfig-001-20240614   gcc-13
> > um                    randconfig-002-20240614   gcc-13
> > um                           x86_64_defconfig   clang-15
> > x86_64       buildonly-randconfig-001-20240614   clang-18
> > x86_64       buildonly-randconfig-002-20240614   gcc-8
> > x86_64       buildonly-randconfig-003-20240614   clang-18
> > x86_64       buildonly-randconfig-004-20240614   gcc-8
> > x86_64       buildonly-randconfig-005-20240614   gcc-10
> > x86_64       buildonly-randconfig-006-20240614   clang-18
> > xtensa                            allnoconfig   gcc-13.2.0
> > xtensa                randconfig-001-20240614   gcc-13.2.0
> > xtensa                randconfig-002-20240614   gcc-13.2.0
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 


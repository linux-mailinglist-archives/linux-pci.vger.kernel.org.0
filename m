Return-Path: <linux-pci+bounces-22063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3D1A4045E
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 01:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25DA7073EB
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8253597D;
	Sat, 22 Feb 2025 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gB/H+pLo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88753365
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 00:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740185018; cv=fail; b=IMttiQ8NYc+o6qv4bRWiniCGcHfx2Cy8jJhNEUqx6G4+dRA815HI5uL/MyqpT3WmZSdZEDd/yTyI7TYoca56+pUtCT/IYHFaykzy6heRf+lfZjlK9TpKkH6ibkdlNK9kGHHwgfU5JqQeH6TEJomt74tBZap9/OuZM1dsT41oN/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740185018; c=relaxed/simple;
	bh=ZR+F/Pna/dUYBWnbsn6a5UU94D/pqz3emiQeGMONCu0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X2XhM6IokuGnU+gqnnA2sVacHgPXnhkPjz0kCChDHDggjT+qIcgr71Z8VfZgj2ulrGCLUcWiqqLB7hoSzoxB2BDFgpsKs8Ca2ZKofTe+oLCqlIkAhBxAi88HZjvZ4KepoKHA4ExBZzNqPeQIyA05FuGCY/AUEkdmYPVpceAolg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gB/H+pLo; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740185015; x=1771721015;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZR+F/Pna/dUYBWnbsn6a5UU94D/pqz3emiQeGMONCu0=;
  b=gB/H+pLoGzKlg5FfkCjk4zZunXvH+7SRuFAxN0gEuuuLxHP+i4hHbTqq
   eZeYTS8PkDB5VIxrrgkEGufYI85phs86z8+uai0dk0pZIxJH0QdpE4+5b
   FsPMAxEyGgHz76gIDIPtSfUiUP8s91ZGEDTVKvHevLXQaCj3ug1Bc9Z7K
   9ljwgJRb0Ci86LYubccEBtNQ1OA4C7q9lCxXXryuzUUWCyKsWi7q//d7M
   RPeOzzNH8rPcoxMxXnCPzXqAr+zmxDoihl5WKU/suv+bitadJUPbrcKtc
   Z4MGvW+yaFqH5p/r0+/DQWOBEGsRIKGVH8w1mzu/uMSS72ms7oldt0RSg
   g==;
X-CSE-ConnectionGUID: bvzJ1I41TOuw/qcDzmBmng==
X-CSE-MsgGUID: 5OcU6V+kRQyiP26MnRempw==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="43847146"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="43847146"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:43:34 -0800
X-CSE-ConnectionGUID: mrzWnLtaR/y+wmbD2Us5IA==
X-CSE-MsgGUID: 0t0hsyW2S/W5OhWu+H5rfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116014962"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2025 16:43:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Feb 2025 16:43:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 16:43:33 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 16:43:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sd/k8l/QuRh0j06tN8RtdHfAZJKYqDiD4HZmZKTrgO1Xi3hKJsYgc+nO2pvbCfRGZ38z4218T3vmF3fx8DO6Gxat17rgmPzt46fEPgCklqJKf4mGe8zCa4TBk2tYSAAzJlqcT9Ym0WPffaYSaz0eaPHUh3p3FuXpXgxBiFs+HE7vx3CQwalrLeMP62u0x9n8jgeUAdzgHgAiK1EVCPn3VD/xL9Bx/+884KX0tz+HePdSsxZObY7eThK91FdPAekh1rN/LO9o66CZ5E9m+6iPpEu59RNGrgzbg9Cp+qTgGzWh0Kk9j2sUkx17uZGBP4K4Ge0sL8dPQr0K1ATC+d7ZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXurGAH72Bj/tzOaEU4334pq57wOR8FjP2/S66MBYdE=;
 b=K4o2KfTNet9xCKIaqj0R8SZqi0fCfCGFLLMJ5IaHQZLSWjhFBufceJZgsPlyxHY51a6IXtG4rL+G3ISBtHdLA0yLJwBnYgrQOj8Bg7u4HvL4n5doL//6xl2ZDjsWMbuRYUGnhrHJcV5SI/8ueVnZOuU1GRmAcX+NVKvLj2YrL1l14c5IOkTRqVRDzG72CxitbkAoA1Brn1IK2vSoKZ8dAAOlFI1O47xfVvW4VOenC5nhBXblOQmrdRwwIngoXaw1fkkqmETLnmKvBhO02ShcUwOwvZOszXMHRxbGrx5p/RA3Sj/atj2la+jFHQqqtHObRuiEbhnUdPjX1oW9rqdNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5023.namprd11.prod.outlook.com (2603:10b6:a03:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 00:42:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.015; Sat, 22 Feb 2025
 00:42:48 +0000
Date: Fri, 21 Feb 2025 16:42:46 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	Alexey Kardashevskiy <aik@amd.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Message-ID: <67b91d86a48aa_1c530f29431@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
 <yq5a34iw1bg6.fsf@kernel.org>
 <Z1qDgGLhw2xSk9T9@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z1qDgGLhw2xSk9T9@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: MW2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:907:1::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b35d08b-7681-45e0-1042-08dd52d9d4ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AuWpEXJwWa/KUfVhFjosYBL/K2fDHJxSSC8rDEI6UId9dUqUWjnTkcG877fq?=
 =?us-ascii?Q?3qPfCot+YJnWAurmyx8mfF87c8DjaZUOHDS078+szMoMkyGbPDg12OuJ3Y/O?=
 =?us-ascii?Q?ZbrHsp+yPaE8Ty6U0UleiCN8evZsnZCbrTZrcrgR42JlkHNXTNj3fm/f1X1i?=
 =?us-ascii?Q?y452S8bRxYPDXOmzmEcWWVaxnCDr9GBG1GrZL31tIW4LzY1Byxa05vBeNq1e?=
 =?us-ascii?Q?LP6BUClzM0Pomo5QzW0K5xbBuaRXnAY2l2VtzEzJlR5S3yudMQYnRrBLjDf+?=
 =?us-ascii?Q?3vjK6R9GekNk6wRnz+qVHTVDVH/dHuNWNcDXyvF9BS3VUFhVHmhvu8IyHMV5?=
 =?us-ascii?Q?flOgX0TyF+d9+8M5msQZJQp6wWsw8PbTLfMnAw/xHLjbE3Af1s/iDSGXoRvV?=
 =?us-ascii?Q?J0SwLA+jBRZ4FdtcUCdr0SysQpLEQnZftkBEDYR2gduUZbteqLllVd93ysLC?=
 =?us-ascii?Q?u++c89FYuoeXKy3zbmLWTQAfacXy9vJWMzixUEPLWqPDjnNGSa07V48caC2/?=
 =?us-ascii?Q?UY+uWMgmhsTmAKY0AoN21p863YNjVwWlCSlFV75qWbBI5zdt6x89dyouw1cw?=
 =?us-ascii?Q?pb/Dlu2cTgUyNAaPCaYJzrr+HlGQp/ONiWLUunB+iGh6jMXm9K9mZOHkA8MQ?=
 =?us-ascii?Q?LvCWjy7Oe9hGrOTj36hyZS6jOW/GqBB7YLggUL5EbGR9Fa+1XYj7Y60Fzv0N?=
 =?us-ascii?Q?X5QXqiw1QniOxH0/Ng+XJXx7HQ7CCHGoLsuNc/ztGKOS5qlDb3ZolPERcZz5?=
 =?us-ascii?Q?IB9a0MO4oVZicI7Mg78sASXkz4gtRwAOfaRCo83rCXWi0lJDX97/2hklwRIH?=
 =?us-ascii?Q?H75IVrfnHXDe2Giz8yAegWP+PMyRs9z2MCCaJxFL1Qt/nwUgU7qENOk8X0ho?=
 =?us-ascii?Q?4J16aSDbaTUF5hqjbsbk4DqfvH5TArlRW9vPrRkjGmzSsLf/q9PFEb5bwAmf?=
 =?us-ascii?Q?0Ak4DUSz3MmKtxLRRVZ/A41SH3O2XOYnfZhU+CIL7ibpC7jpvD26oOWu/cTK?=
 =?us-ascii?Q?YB3VwwNNRqnxtsTn9EaIfqQa8ier2GNtzdjsvac5u2Zyes7HF4u6su4qJkLG?=
 =?us-ascii?Q?qtRDSf0OnonjauxQ958m2KuXI+AaTIrENZ6NHsN/IsftppMETrj0nkRc39wp?=
 =?us-ascii?Q?CDNJ+HJjDglqlnshSVKdTHArpUyU4yzqGn8A+uckXRRFRWrhjB52lZtf5HnO?=
 =?us-ascii?Q?Qpjrgfl7rWGZAZ5p/ln2uBk+Q9knt5M5uETxssL+AFeMOFWmYDhbg0iBIFUR?=
 =?us-ascii?Q?KHf5YALvm4+60+8f14W2y/61gAs46i9JP84WBxklSF4wiH6frBMLo2L6UE4z?=
 =?us-ascii?Q?2Jwjt45CyGXbctEtpWv9O3FD3eY+KZnYp95rtRkDOLVJNlt04P8fVT4z7tw9?=
 =?us-ascii?Q?6TUI+WpdkLKqOBG8DyRrOETmWE3N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eCQQbpDHdj9rb3EMuMLLilB41SuA1JtmYKOhVd5TV3UpC8UAeOSczioCQQvO?=
 =?us-ascii?Q?jxzdrL2wEIWULC8ObG1EWqqiCD3smc4GXQw5fucX5qGo88ZAQkUpRXuNV/Sf?=
 =?us-ascii?Q?M89cwIfXikHu9HbdjwMq3rQSGBfTlvXzAqM5J+e/k+IFLdatnvcguOfHcd0K?=
 =?us-ascii?Q?AZ86eUOVnZm42w+olvovcq2YCrMrukP2Gaq7wEnibXJZMrT6WorLftfupQtZ?=
 =?us-ascii?Q?b0CeiPZrp2KF6kDA+g7ntQPbw8wIN4CeoPLP9R66g7DszAGEdybw6Bg30+l0?=
 =?us-ascii?Q?0fWWfr5eWGpTPwb1myk1HUjUPAl9/MbMGPythT/3P+5X5zcl6NsrxyDN4owA?=
 =?us-ascii?Q?9WmX53dTMqfUaJ1mhmgYrWi2e/q/vuU9gx3ba5F8/BQ4NtCc5lT4eNfSdHwa?=
 =?us-ascii?Q?10gPy5BqNHlYLaLyGNorbxNOVOczsG4IUcbCHCqlA0/QUZ03SQZMkKv4fsmF?=
 =?us-ascii?Q?VQRjxKnXG5Q0wpSMIj20u5zkSauKH85qsESc7og4eiOkMHxejFT5/KtaNSt9?=
 =?us-ascii?Q?ThPGbLAUfEE+S/d5Urk44zgXf7X7hkRC8lQo4h/8hu9jKlduVXMEuKtysS5I?=
 =?us-ascii?Q?UcRXZ9XtfR9lK8M3MFJVIkGjyBZkDM13q+G1QdjXIyCgMliyD8fuUQZUIuiR?=
 =?us-ascii?Q?QubgI8rNWbcUmbfw1DuxBlRwFaQUUI/8J7pxVx1vvaTamywYUoJiksynknjY?=
 =?us-ascii?Q?SYttkWFCTdU4BdBdTfPOViMWwQYyTYr0/Z2F8JQh0IByQQZINXrxLVHeZoaT?=
 =?us-ascii?Q?lfIdqflbwgmoYpJBRTRmurwGOMFCMHtfXcU5OC8i5Otf+7gdkJOB4DwamiUn?=
 =?us-ascii?Q?2AxDxvzLkTILprIJE/h2CPyKDvfT0Rac1GZsZakU0n7WpjW0GrfVJmFJGnYd?=
 =?us-ascii?Q?MBR6FDviHTyLlQkgFBEDkfhrtVciEz/uCx85t4XiCgVmr0XO/JpmJ0fpIxAZ?=
 =?us-ascii?Q?YDzorbqR+nmuWzJNOXPSo0zUFQSiFRq4uJBVZ0/gYQsfZg60r2RKznGfMs5Z?=
 =?us-ascii?Q?Zg7IYahagVX9ZFrxlnFkBHDi7/en3CePhdmgE/4TENDFQ1166QfGbF4aIjxT?=
 =?us-ascii?Q?trr6rPBjY3RjgrHECsmNNzONgtzQNu+02hPysyEr4LhppddYhVKXcLU42zYK?=
 =?us-ascii?Q?Hy80g5YqMdoIQQXQUHGyfWrtzCA0jwDcsEFXK92OiraE/ZZQzX1hDedZ9IIU?=
 =?us-ascii?Q?SZlBsYQoJWaz2Vpk+qRyaPg69nEERZckTk53GksfAO7lQ/tdc7+X0CKmLLH2?=
 =?us-ascii?Q?OFM0E7W4VhYpW9VxWrCGpBezZCQ+lU2lo6OEIc7s2fSFTdrMRJfP76eFSJjX?=
 =?us-ascii?Q?v3VNE1X8vpt3MN5THiyH9ECICbEejiT2jOf/KDCJtWUuhJF/jnmb3Ed64C/n?=
 =?us-ascii?Q?G3irrKT/tzMWYEJzM+/7qbYdP4LczvDOvxYIrNYQsh+18aNMDA1USytdOLdD?=
 =?us-ascii?Q?7wYp0Uc0OMoqMBUC20Q3D1nk237PDf8Qxg3y+ajJJO96VF7gmvwDu0/QE9p+?=
 =?us-ascii?Q?xHZBgzZ3Rsf/mlHDUTsbhygoUGieelu/vOCLvaX+IKYRwSOopF2eluX6Nzgf?=
 =?us-ascii?Q?LQ5PnKe4AZvLypviQ8yr18lmqjJDJQZWcI3iXNaZXcc5Ovtsq0owY64nKTxE?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b35d08b-7681-45e0-1042-08dd52d9d4ac
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 00:42:48.6921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhz0FYe7Db5ledRm2mflO8OFzGAOrFCUCw5116e+Df6qF+ApkVvtrEx5NwJpp3LtznliYpottP2I2h3LfFg8/WdEN0V889zIgziRvixHXbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5023
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> On Tue, Dec 10, 2024 at 08:38:57AM +0530, Aneesh Kumar K.V wrote:
> > 
> > Hi Dan,
> > 
> > > +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	(((x) >> 16) & 0xff) /* Selective IDE Streams */
> > 
> > Should this be
> > 
> > #define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	((((x) >> 16) & 0xff) + 1) /* Selective IDE Streams */
> 
> Is it better keep the literal SPEC definition here in pci_reg.h? And ...
> 
> > 
> > We do loop as below in ide.c
> > 
> > 	for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val); i++) {
> 
> for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val) + 1; i++) {

I think we should follow what you said in the last patch and just define
the mask that gets to the raw field and then put the fixup code in ide.c

Folded in this:

diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 6667a61ba01a..eea126ce7ae0 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -14,8 +14,8 @@ static int sel_ide_offset(u16 cap, int stream_id, int nr_ide_mem)
 
 void pci_ide_init(struct pci_dev *pdev)
 {
+       int nr_ide_mem = 0, nr_streams;
        u16 ide_cap, sel_ide_cap;
-       int nr_ide_mem = 0;
        u32 val = 0;
 
        if (!pci_is_pcie(pdev))
@@ -47,7 +47,8 @@ void pci_ide_init(struct pci_dev *pdev)
        else
                sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM;
 
-       for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val); i++) {
+       nr_streams = FIELD_GET(PCI_IDE_CAP_SELECTIVE_STREAMS_NUM_MASK, val) + 1;
+       for (int i = 0; i < nr_streams; i++) {
                if (i == 0) {
                        pci_read_config_dword(pdev, sel_ide_cap, &val);
                        nr_ide_mem = PCI_IDE_SEL_CAP_ASSOC_NUM(val);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 7b8ef694a9ef..17aef7646b8d 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1226,8 +1226,7 @@
 #define  PCI_IDE_CAP_ALG(x)            (((x) >> 8) & 0x1f) /* Supported Algorithms */
 #define  PCI_IDE_CAP_ALG_AES_GCM_256   0    /* AES-GCM 256 key size, 96b MAC */
 #define  PCI_IDE_CAP_LINK_TC_NUM(x)    (((x) >> 13) & 0x7) /* Link IDE TCs */
-#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x) ((((x) >> 16) & 0xff) + 1) /* Selective IDE Streams */
-#define  PCI_IDE_CAP_SELECTIVE_STREAMS_MASK    0xff0000
+#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM_MASK        0xff0000 /* Supported Selective IDE Streams */
 #define  PCI_IDE_CAP_TEE_LIMITED       0x1000000 /* TEE-Limited Stream Supported */
 #define PCI_IDE_CTL                    0x8
 #define  PCI_IDE_CTL_FLOWTHROUGH_IDE   0x4     /* Flow-Through IDE Stream Enabled */


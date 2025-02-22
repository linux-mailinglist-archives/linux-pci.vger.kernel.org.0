Return-Path: <linux-pci+bounces-22058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57A0A403F1
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 01:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCB13BC24F
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E904C6C;
	Sat, 22 Feb 2025 00:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYU7IyPh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA38836
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183239; cv=fail; b=ZAGiu9kYDh2q+QApAig4TkwZmKzqaaB67LKS/HM5P3FyXlNnlq14CRPwWEsoWnR85XJhFgJVlMyC2uBlNVd2e5mUpLUHnCpSSf8NCTCe0/8XtE9vTrlhRjuz+lDZidfDcFwLJQJ4JTPqn46zx9zj7OtlVvQlm5xvlTdW1qxzgqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183239; c=relaxed/simple;
	bh=xykc5nJMkf9/v5TjLkabp87L65VuzWBQWKw+AsIgAdc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sCQln9ihhH64xsGz9nTfzeWJYkrTa9kgcbSh4GSlOQTchBJwmXnbLGPS8kXuc0aLB2rBfW+K4oB1+nuuZcGDNG7k93fjJvIuPNLUS1owpym6GNJeNxaDkDRDfs6yZkLt/EyDwz6/Pzjqr+Kauxg8kd3t3trReVGBHAQ8JGiqNXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYU7IyPh; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740183238; x=1771719238;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xykc5nJMkf9/v5TjLkabp87L65VuzWBQWKw+AsIgAdc=;
  b=NYU7IyPhhvyTwkc/T0D0MNcUKqoiFRyC9qDM8NgNNsCPUDC1TLGKicjZ
   le3sW21i5ZZCM3LDGpW/8quzNCsxxtXGIQ5ZOk+WloJIlWvEfurbppQKo
   v7zH8l6cRpBtvDChirbvU+AdQ8CZyecOiaV5cLcmrqJpKKd7fnSqdKwLK
   /PKATsFZT30AuuPzfPzVGxzglg+YqNbcIY0UG/20uj0xmxfm+gN6H+nS+
   R0nqQNxQ7524CFmTKmF02OWAzSs1tcF3dp1oPqVnN01ovwfz6tEXrpEMR
   ZU15VQcUUNDIOifC08QF1DlrTrlVUbuEHH9i5DADFWeLcZ+I0dDT5PQO3
   A==;
X-CSE-ConnectionGUID: e5d/PCp6TdmVX2Eu/ww2Dw==
X-CSE-MsgGUID: /ZkTeX7fQ/Wo4PwqubmX7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="44926789"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="44926789"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:13:57 -0800
X-CSE-ConnectionGUID: 4Y1r/JHwRPCGgtX/2XojkA==
X-CSE-MsgGUID: g3s6dgyARumDiTrl9CLm2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="115705498"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2025 16:13:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Feb 2025 16:13:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 16:13:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 16:13:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwwAo4S/QApATd6PzF51g6XXxWHxUZv0nu7p1YZ2JjoG0sVuUXSQK2o7Gi1VLHsVNwsCby+x08GFnGalmlh0pxN3bfZHiTSyzl9h9bBX4ajJMYTvUs7l62sTMXAGK9y4N5iRizDpBQmRv7kyGu4muXylA41J9j0erdLmpOmPs/PCOnDQ0w6khmlH1OWCVNqu0k0VRxb3kqmkD1EFME+MiUlCV53H1S19+38hfRl5RwuMTtw5X3OsQeKeQh4CHV3qEyzkzF5Ib6CVrTUq8KgbhcrGETwIdxUVSpkuGQl3C00mJM5jZYxgTE2G88d/vUai2RHhEzB+ucJy+9uMJoDwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJqdim0RdJllTIOJCjVGklwQTne6L3p13MhtUCWSZ3I=;
 b=yscoA/XnEXCpjvhDbVl4thC58yP/k8wo0p2huy4dN/Pp4uaTtXXKSWBHEGhAmCF5K35ar9+o1m1//mp023sW2JFCDbTQ4LKus5chx2N3Vm68OVHOIrcGbMhUimU9LJWFdfzlKy3DdbUT1xfux5Zx2nhG0A9JJHfaGiNQ8jo0rGp5IJygRAG8QTGXpA8fuhY52mz+objdZ7qiYuS1QJjx//XERfO+b3fDml1aPUMxYSrxEE3otuO4fKHYHyCZUSLiiM4QvyFSp+aE7M7ImdMzKTjuY2XC4K2pG2+tCL0EFGKZAh89dq7HfXBx6w+wpM+0h1G7beLxPw2xEFzFdQ228A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.20; Sat, 22 Feb 2025 00:13:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.015; Sat, 22 Feb 2025
 00:13:52 +0000
Date: Fri, 21 Feb 2025 16:13:48 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Alexey Kardashevskiy <aik@amd.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Message-ID: <67b916bcd0bf8_2d2c29480@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
 <20241210192444.GA3079017@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241210192444.GA3079017@bhelgaas>
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e21535c-8ebe-49db-6ca5-08dd52d5c981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r5+gOs/Y7iA6j8jEQ7CJIjayKLa2K1OSG9qRmmwba20PF3STQkKdZh1zJHRM?=
 =?us-ascii?Q?6SJNqUGCGT2vUlqNnTqa+OMEi00zPzOsU9JMTJmB6KBe7aVMqrdSoWXYNZz+?=
 =?us-ascii?Q?zFU7s5iLS0eWeAX0WEQKs5VRl+cPzcssbIZ3dwzp2p7eYUHayEXp4rCSR89y?=
 =?us-ascii?Q?IvuJQjGjpo5lWzF2zG1SNLXctyC/Omde2RKPKzdd1NhmVUHuWYVbFvzfLjpz?=
 =?us-ascii?Q?GbewkUiThEH/pxjyxGMcdS1Qjtgr/X7O4ewnlmzWAXbfRltbTjOhflj/WjdK?=
 =?us-ascii?Q?1sAuR7V9tRmBivh3SbX/bp319fzIQUPV4e2XyiiyvL9AdCv/TULIupPUU9Bc?=
 =?us-ascii?Q?JR6Eex43Upy++2bN4TRfR7bbu2beWjylIwxqppjjlnN0q10lMgY3G64kYnYY?=
 =?us-ascii?Q?AHnPmSUcK9nE9PQwnNUrQND9m28iGNwycUnJ1E3crHA9Xw2TsMbeu8ZDWFT4?=
 =?us-ascii?Q?OvUUb5NYV5I2l6F5Qwgfp1lvq2gf68KI0xpdlHXCVR3fyi/DcK10udfiMOhk?=
 =?us-ascii?Q?EZsZk7HP1s9Qi5dDJZPp8V4ysNBYe1BFk4+6SyKVjdtlCORGacAODralq8Jr?=
 =?us-ascii?Q?+hl6FLfnm6HVk+AFvDhyb7/7UZYu5JEbOMcEw7ftxZ7qJYBl5BWal2HaQfbj?=
 =?us-ascii?Q?VoWVeH9Mlmd5xV3t0A0xxJdUST5ddNBRbu7K2Lda/Ed6VseXjZLxMhFmT7Ac?=
 =?us-ascii?Q?2Vx1JYRTHCTJvYOn4lmKRyNJ63/vM+BohhXDYhDDDnoHT9pFTaV6P45UEbiW?=
 =?us-ascii?Q?2bUvjAQTbRq+3R/L1mtu9s9DVVea/Mu9jVGJ1c7bNy+fmss7+m29UaI9BSFk?=
 =?us-ascii?Q?jXYvaKDRJV4Wz9JPq3+6kh//NTRU5uddfX4ilXg7zlTDxkRycAvU7r7BHusF?=
 =?us-ascii?Q?++p8UhQFm+vfAbG4no1v8CUhWyA8ZtrmMI7JXIdzOxF+ZRJ1/doBVdjgXq23?=
 =?us-ascii?Q?f2lEJp8N+rzXTkRmizDMP8qUCoCLXdLmJ3/S/cYKWiUwaTJBNOfE4vavKalq?=
 =?us-ascii?Q?MzHNNWCDmWjQNA4qwz1NNFiMa7Pm5UrfsXQ9Pr7CTJFmuFn3YoatsLSmAIuX?=
 =?us-ascii?Q?ubkFrzEAyWDO6FCkBHhLE9e/5eco03bqOZOntBUFlTIzKvy71gDBspXkqcMz?=
 =?us-ascii?Q?1kcx4ZDNeTS5atg0AkFmS5PZLI/s2o/F+JbHAjGFdiva+mA5kDXctFeC6wvt?=
 =?us-ascii?Q?daf9/ewJnkaTdIzQmPQaB2Sjq1dsPOB4jsIpQT8YjOh8aJe5tD0TmErMAJq8?=
 =?us-ascii?Q?hup0vGOJXQ7skhZ7wE8GRrUxprAu4pM2OUWyfXTZamPiWPyNhkfskc0qVK9q?=
 =?us-ascii?Q?2NiTjzjBZi+3QafX7Pv3IwYn9k7Dnity/oG24sABPfLQw+IdWF9spGNWiugT?=
 =?us-ascii?Q?jVyODushRQuynXmeTDY9M5BsC2kb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CD2DvHfeyvFPQS4YwIJOTW3ay01IAAE3O9kDzCPh6OVscrEqj9cFl9TvkOCw?=
 =?us-ascii?Q?Rzi+iBTODYQz9qlnQtCsRrd0Ue40KGpVM9KVpkttgqZgDSr0Makt+IYU2EMA?=
 =?us-ascii?Q?j9tQQaz6DiVK7+P44d8G+wTLssXHdynsyAInTl4aO05nts/T6UxtqPm4UuIz?=
 =?us-ascii?Q?wiTunse3czI70k4y5pd2iXkI5DAJTs897CkvueU4F5+VXyMSeIq9KgXSgXyW?=
 =?us-ascii?Q?2Lqqn/SvLWMA2rW2ETJ9y0JXPmanaM3wxCvlnJ9Bsaty7TJxf2li7bJ19A2f?=
 =?us-ascii?Q?F0aW87rOs4JeGmHoAcbnBq/gkdi1yjnTmxwGfnefy1/sZ+GiNqhuB53v7g3O?=
 =?us-ascii?Q?ljhz0HgwGLe+RaBDy6nezEUWTLxdmQ4ifPvCZVMtWwAAnbQdw0yj7vfOXW7D?=
 =?us-ascii?Q?/EnZRHy2Zvj+eajg8SidaAlZU7wr1bzVLQAKciRbuV+VPYG0yZhfi9SbKztI?=
 =?us-ascii?Q?D9SmmA9bwCP3jPkj0qhwQkWgieXYk7OlpZzSPzaHATarOVGn5RhlY2EFXYn+?=
 =?us-ascii?Q?ryy9r7+6KNpuGsYUqJs/+jvEMZODCLPiO0nsrdTFur8+JvqwZqJ4/D6BKJ6h?=
 =?us-ascii?Q?nlG9GmQGmKbj3GmdbB+6kE5C0BhFLCAJde1XSL4ff/pH1nI9CnPB7yd7CL9q?=
 =?us-ascii?Q?/IzUgcLbJFu3B+0P8muMKKc7ks1PZJSbHxF9cE8hcZu5JqGNmT2Wldj7CkNM?=
 =?us-ascii?Q?Gy3bd62l1OAQ27tyuxKnSg+mPCvn6ZMGsmFXQDN1EOBeX20sLMc0vVbyvLci?=
 =?us-ascii?Q?oFC/Q276cQ33CETYVannv9q1KX6wIc3AX0Gl4nWywxFeeO80pmK0OWoNQ+CC?=
 =?us-ascii?Q?ibLnnm6Q+etI122slo8X82KPNQp9puhJcvnNfcL8L+5uX3AVy+J7CpxG/J25?=
 =?us-ascii?Q?TCrJ98VTHoGBooPQ1J5hUKQahSzxkCCIiJmHa992JACBLdKH5TCb6Y3IOins?=
 =?us-ascii?Q?RIsRXeKjO+rZ4EOVddHHhBiNVh2jw6pHH9f7Hhz5YKMaGZTpGkFnJonoEVwB?=
 =?us-ascii?Q?Cd98RaNNRq7Xw5/uYf20fmK2YUS6o98fiZYcfWxzknJNc9BUP9CBArt2ZOsP?=
 =?us-ascii?Q?ISstI+fO5T+rnZI3ZxdJaZp+EErVkiTaelgUlZCmyUgB0FikGdkEFl9Dh3L8?=
 =?us-ascii?Q?hqwrodF5pWKxl81rTu/8eAKFY2G5zSftzUgh2Aow44B7K2MzPmy+QmVYttr5?=
 =?us-ascii?Q?RV/wMMrp/lf+Jy4+sX1sFJpzXj1FbGkiPD9P0HTiINXBLfgeom5skSgbaBrr?=
 =?us-ascii?Q?1Gi/BFaVSDgcxQRSaryHBh5kUQB/hVmXTiGSTi+6sB6wCJZUOQymqhdncOg9?=
 =?us-ascii?Q?LROTrsZNt79Cb+3bDWOKS/ui0vu4VWptUKDI5LkXPNMlJfXQYIy8MKzAnfRm?=
 =?us-ascii?Q?bi4DWBfmJUfGJuzc1zaAZbh+acHPNVpI/WhO62qnyCecONDFN6dG10xVODDk?=
 =?us-ascii?Q?p94DsTDvwxO4SFhA9b2MdK7R0ig7lVfRTx0QBFSKHhun4J7qr+JeMQfFON04?=
 =?us-ascii?Q?MUqMsl8NT9KGSJCL1lX0x6gqt9Yu1i25/7XFu8IGIt2vURMhDf7tyV2YjpoO?=
 =?us-ascii?Q?673k1p72UTadAHecXmP1o9hnaDDnBS+0pMIUgLUvoDDXSk9P6e4IDfby4q2Y?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e21535c-8ebe-49db-6ca5-08dd52d5c981
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 00:13:52.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhzR0hs966h+B+gA/2u1Tv2KNZaSJgQTR/TORn69rowHvqTeUkljtVYxV3VMK/wnUdoZoQpFKaJUa3rv8xFpiipQwe8HpOZ4G3srDfvbHhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6502
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> I try to make the first word of the subject a verb that says something
> about what the patch does, maybe "Enumerate" in this case?

I usually do that as well, "Enumerate" works for me.

> On Thu, Dec 05, 2024 at 02:23:39PM -0800, Dan Williams wrote:
> > Link encryption is a new PCIe capability defined by "PCIe 6.2 section
> > 6.33 Integrity & Data Encryption (IDE)". While it is a standalone port
> 
> Since sec 6.33 doesn't cover the "IDE Extended Capability" (sec
> 7.9.26), I would word this as "a new PCIe feature" here.

Updated to:

"Link encryption is a new PCIe feature enumerated by PCIe 6.2 section
 7.9.26 IDE Extended Capability."

> > and endpoint capability, it is also a building block for device security
> > defined by "PCIe 6.2 section 11 TEE Device Interface Security Protocol
> > (TDISP)". That protocol coordinates device security setup between the
> > platform TSM (TEE Security Manager) and device DSM (Device Security
> > Manager). While the platform TSM can allocate resources like stream-ids
> > and manage keys, it still requires system software to manage the IDE
> > capability register block.
> 
> s/stream-ids/Stream IDs/ to match spec usage

Got it.

> 
> > Add register definitions and basic enumeration for a "selective-stream"
> > IDE capability, a follow on change will select the new CONFIG_PCI_IDE
> > symbol. Note that while the IDE specifications defines both a
> > point-to-point "Link" stream and a root-port-to-endpoint "Selective"
> > stream, only "Selective" is considered for now for platform TSM
> > coordination.
> 
> s/root-port/Root Port/ to match spec usage, also below

I also went ahead and updated occurrences of "selective stream" to
"Selective IDE Stream" given that is also how it appears in the spec.

> 
> > +void pci_ide_init(struct pci_dev *pdev)
> > +{
> > ...
> 
> > +			 * lets not entertain devices that do not have a
> > +			 * constant number of address association blocks
> 
> s/lets/Let's/

Got it.


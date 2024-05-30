Return-Path: <linux-pci+bounces-8096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165B88D52AF
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 21:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037731C21CF7
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 19:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817514D8B4;
	Thu, 30 May 2024 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GN5EWif4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC8433CA;
	Thu, 30 May 2024 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717098835; cv=fail; b=BJPn6xzyQjdbdodSVQwlDbuc5oVoAcqmPaj+aoHDaUTFRPGNspTDTXCGWw9m1ebKiucT3D21VXgaCcAPZyzpl+XqdSkcB1lTdNIbSnyfeaOuC12Ffyhairo+iAXJklEOzV30/xyEywaZ6TtHJAKDASP7XB2vUsiHjLlmboh47E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717098835; c=relaxed/simple;
	bh=V/Y0PyxTgJvPDVyiuTaD6v9KClmxhr6nkpfkqANdQsg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mmzwdFdwErxcq9mKKvn05B+oGBZAcVTj6OkCfzSVc9G7HnW5jw+64aPG3+40JuK/AmECMAPOX1fOP2P1/L/rgn5Vpy4RHiKWchZSmOutEjjZ/l5PGF4Ij9YcJOdAofKeCGLreaBxOf0l8U1dgm841+6iT2xqY5E3eHUDvcKm2fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GN5EWif4; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717098834; x=1748634834;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V/Y0PyxTgJvPDVyiuTaD6v9KClmxhr6nkpfkqANdQsg=;
  b=GN5EWif41s1KHQ39+s/s531yeO3MFDL3hLUKkp2GJiXjP1msQ8RcM+DX
   qaFgktkkwawtnU2LjrhNXMSYZZU99zoOHRXyhj1fKNBuFK4MuoqAih53F
   jj9RGWnCwdjj3ck5rDNMWis0l0ZKYTxcNdJlUABncSdMluWOiZGS6h1So
   GukqQl+GnIrYaIX+gM5XzSM8suNykWz6iRmX9uhIkt+4ROkzEcBri5n2C
   cRAX3dBEM6M9sPdmyRiKdG5wLOI8oi3xQtxIocXsixgnR7eUaFzyPUWtp
   mnQBe4pul7T9pH4zS6jReC8o0Oo6/RPJwhVjsH9wD+wt5JiQj6oxxVy3i
   Q==;
X-CSE-ConnectionGUID: dGWvW3smSJCAljKFlKYt0w==
X-CSE-MsgGUID: iQtBo7RQS4yo2AHtz05LBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25020573"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="25020573"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 12:53:53 -0700
X-CSE-ConnectionGUID: 3kJ0UnX/RW24Ssj4gaD7jg==
X-CSE-MsgGUID: xKi5bh6LS0aYi0RUfZtTMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40844656"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 12:53:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 12:53:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 12:53:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 12:53:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/0kwxcAPDSoLXPhyI7VaOIu9w0u6ZdFjz2dKXzKzGpRfoHUG69gbiytQg2PAVMNRn548KJYqDSwyKwjfu8Vn6NW0kOF4wJHZEhdrX0hfqlryO/6Yb0dCaIX3XVOIBoVpktUlRuexrKSPNt0uCPAwDVnf2Kss9HdPbv2KyG8O/j4Dg7gdGcMvul0dBFuUTHxX2KHM3npJySouhUOACy+iLQnYrxo0G41KmNUKAyT2LSmxALR/Z+txYGzlphRr1IK9ZzhamJEhATwgyDtz4YOwO3xAHd78kt8zcFB9hAdo08RqKwbJY26HYmGxMusUkInb6F1RHvjC1HJ7TWpMbN9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyNoxXq7srxBMe3gAktfo+cVMWAN9ubxczsjDYZXhD0=;
 b=Gr1dHV8lop/OObJS5XngZQkf+7RsdlGIUK/e9N64yAdf5DLUwrbPp4OIw1WcWfRwf9jn05R4EJ1uYSB6Oqn0H5TYge0+KWPWeLc2a+9SEL1pukTm843LqCGF2PX/m6+v8lu/wolQJqhpu9y/8eZdZBk2WXDb+68GMNKS6RItjRWJAQL6wiMg0ad1KxiqQ27UX0SA2x9/tWohLPsNFzT0UMQf1KpAobM2w/03uW72cWuU0wEshQ4KLbwomRESSI/lFprEB72h9Q+tEQTrfQ++yERHtojulLfigPrfRYei+9uRtPgEmO6Tg66/MN6DzzWkQCy16iMEtb9xQ7tobG+zCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6903.namprd11.prod.outlook.com (2603:10b6:510:228::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 19:53:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 19:53:48 +0000
Date: Thu, 30 May 2024 12:53:46 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <bhelgaas@google.com>
CC: Imre Deak <imre.deak@intel.com>, Jani Saarinen <jani.saarinen@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: Revert / replace the cfg_access_lock lockdep
 mechanism
Message-ID: <6658d94a4945d_14984b2947e@dwillia2-xfh.jf.intel.com.notmuch>
References: <171709637423.1568751.11773767969980847536.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <171709637423.1568751.11773767969980847536.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:303:8e::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: fd20cdaf-82f8-4d89-97bd-08dc80e238da
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mo3Ef3JninifskEWYt3XBK8Ra5bp+RVeJBDDmwoP6+p9Ny9XG3YoR76r6oP5?=
 =?us-ascii?Q?lMdW6WelWgUYZ0WBaOJU360o/n60KqvcNypNHzvg7dwcAFoW0O8+tnphJmMB?=
 =?us-ascii?Q?YkOKeeFf/j+b50mSdL2Qm3PWsci1vj/R5dHIkfVjAYt97sv/TlEe/AVtoks+?=
 =?us-ascii?Q?VWfyAbINk6bCTtA0TqN4/roDbl/RcvKzdziQZKxdOYaeo7BImkiQWUZbc6hj?=
 =?us-ascii?Q?y27AaC+xYe7+OZMshErz65WUvh30WtRiKbxTpl9HLmlfp1G6NGlbz0Tqsxtc?=
 =?us-ascii?Q?y8lBjtlWd843lvcCkhElFikoswYBWyJYyzwK5G4WiOwspD8vEizNYwUjRAKB?=
 =?us-ascii?Q?DhAfNYYPol6JIUS/yNLavyMMTVnuTTdlXI9t5mlU5jMxczIvptIVHuMK8t/o?=
 =?us-ascii?Q?bo2HpqAGOkUrEYTjecROgVv7SmcLPBeL0rY9FIfV1S9rS1bKDJ6QH8KljPQs?=
 =?us-ascii?Q?T/oVQDnYFDsxMZY2hEiwXMgcPCD26mfWfjjdoHz5IXsJHkE6FwEdopaAX2Hf?=
 =?us-ascii?Q?RsUOExiqtdZnJiyJqMndbSRLzHvMw/6xMu6YWtPrjewxMIzCP7dbVIbspN87?=
 =?us-ascii?Q?qdeG6cJYT60s61l+vzInZ1ad9V+tPpf8GIPOwmrYccrQ9e+iFjhlaN9dfRRS?=
 =?us-ascii?Q?C+/GypEhRrRbLCobffExP80YtLNnsT1h8duc+4EReU6gNIMuNyklkRXWoBfO?=
 =?us-ascii?Q?+4cjrhxwVOsMfyJ2GdCn2s8whuy4H4IrnkOWerr4tAvnWdjD4lr1u9S3o1EU?=
 =?us-ascii?Q?CPlmCr+krK4sQTleabrK5eFgPXaLXcyyoOFBZjF7PD4wlxiA8I9qnqzrS07m?=
 =?us-ascii?Q?Q4+ZH/NkfQim7bzDGv+rvGgQRll+nfiu+JerNTF4l/Z2QYEpM6DUkGUpBn1M?=
 =?us-ascii?Q?u9dmSJI/QjIRiJOitcx6slpaLvh/LtLCGVQWMyjuRhg+mN6e5ESAFtbIwB5l?=
 =?us-ascii?Q?rlqchFZVrwtNAcioD+S8OUBfxz0bMLqDyTFJ/lJG1xGoDLJHeAYQO7i/JCXd?=
 =?us-ascii?Q?LQFiFDsWivaPB0OqJ1d6qaU1FXihSN4Gx660CMui56vNdP8hxeAy4EhCokzl?=
 =?us-ascii?Q?+scOIq0GI13DlPQtzqY+a0Z+I+8PXZrYzVfzfhMF8FIMfVHXcRpeBb8hw14A?=
 =?us-ascii?Q?RrtGJWlJj9r9Me52xP/lph/TZvfCk1BD7avc1g+6vfJ7orE0tUk5jZc1e9Vs?=
 =?us-ascii?Q?7x+bnJp91wjMktZvlTSeG6pTEXgDT0nuJQ52COZpOih0esktap1OKhO8MU8?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m+Qy5+JL/X3mKs8NNy0XpY+b8ycCRWRSZQqxRQwSvnuu0DLHXsHyvH5U95Fz?=
 =?us-ascii?Q?LlGPTsI2EJu6qnhaDj9wkfGMzpc8KnHbT1RrLDVTiwHpK1LRz4wE6hJyM0iL?=
 =?us-ascii?Q?Hqg8nyogqJRjSHrAuYhULrEy1jxsz2PWQpIslbmvwkRdsf6RDa3/8RuDLQCb?=
 =?us-ascii?Q?HxbIDf5BGMD3+dlUrieL/S5TSDt0t9NSxAkS6iZG1NCx0Xr68lfyuQr/3ca6?=
 =?us-ascii?Q?lH9UcU0omIRzVBQ8H8jak7FU4wq+QapOHNOYV0QQvdeClVgQwUfJEwRVuxIZ?=
 =?us-ascii?Q?mhQOaVuTdITQEI7okat63h9w3DU1JqjgDIFJ5le65dha7BcvQfm980NAmwiK?=
 =?us-ascii?Q?eKJADZNw3P0zpGtQc7/7O1R96dNngAoKCa9OJbqcgNLmRdfOmne+SmFlcblJ?=
 =?us-ascii?Q?cctC7cMo+VRowoOknjL0Vi/JVgZt8Evdd751rH0Ya3G+Ev2ufBBdF1BJQ38t?=
 =?us-ascii?Q?PP+D26dOjWxAP7fRiAI3II9i8kyKVz4Iqoe8IHU45oJWUW+O7QTEOZcSQ4Gn?=
 =?us-ascii?Q?rsNpLPDIfk0wuAv8qhiqXS4z9C/ddGVMZoeBAkSdzyywuJvHo0hBKinBg2Sh?=
 =?us-ascii?Q?Fu+49M57fB65FQhuYMNDrZlpq/R2MPdYaqCyBppBesbOuDKJaG/MMuHISCP8?=
 =?us-ascii?Q?7TziMUHIg3986lLiop70rJ803jqkz2j2ZVTcBfBetd4a3/JTerDGTvoxdh8H?=
 =?us-ascii?Q?lfzIyD5LYFTKeCOE3qrRWTet8N8UprLx+vTynuEwWxySd+AasTyr80nFl0Ib?=
 =?us-ascii?Q?4qXbNuY2bT0Z8/jsAUJn6876ljE1LPzjAIhzCwOTA4P60KK0LvkY1gaEXfNC?=
 =?us-ascii?Q?LjDzwe/i4F3OySbppJSU7B8tR1daOwRrk5ERlwNVc1N6JT3ETHJ60FTMF4Ag?=
 =?us-ascii?Q?iceXKdf+uJEXdk4vy23T7vHEP0ReDTGTWe0+DaIHP1UYWYcWwy17BdFKrWGw?=
 =?us-ascii?Q?9ELfIadCVmz4S8VfgyhXt+63+GgFFD2vgiygC1ejOr3n2sAGhWLboJrYONaM?=
 =?us-ascii?Q?6qp8qkHe+Er3KLS573qqgr5lq/LfsDONKCcYho1+F6JSPaNS55ABSMCEDKB0?=
 =?us-ascii?Q?GbLeXhjRVWbuCddemvLI7n+Uvaijs/ZW435aRNO6GQlWxwsschOAH3xB1fMV?=
 =?us-ascii?Q?WLNz8zt4A64gIBxDmOO76llcfpP2MXjFFnbNY9HEeDN5c4mAbo3J/suVi5Gg?=
 =?us-ascii?Q?SV26A1TG9GbEXzVf5geTIXjWNAl5l5cnCgWq3vs1g3oPog6odHk2NIsJt+Xb?=
 =?us-ascii?Q?Cn+1M6o2y5D4Kq4/VbevOtNkqAfriD0XAILM01h6JMaTzRY5o/rhLQt5oYJA?=
 =?us-ascii?Q?0CEyJiseFMmOBXX/9s5z7kz0bl8KuAb57rkp7cd1Qx4vBk5YsKpcxhH00/ZM?=
 =?us-ascii?Q?FuKEcqsVXr6Hj0AK0ba0lhkV3xzYanQCWkK1gVYaOa3j3fiLzruuYL7wLpbu?=
 =?us-ascii?Q?3J9p5MqQE3HwXlxhDK8LoRJmofFR1rEYdVffuXpYaC7kW1HeZzTuZ9/eMOl6?=
 =?us-ascii?Q?3g0L3dhSGFAROa3lA9m0m1BkKuduFarf5vOSeMhS6AYz6wHGW5bRyjK517xq?=
 =?us-ascii?Q?06gA7kLnywvxXt7VyUF0Dc9eu7SZRGH8iR92dFgQtQUpHyP2ZNwBBJCF0KEh?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd20cdaf-82f8-4d89-97bd-08dc80e238da
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 19:53:48.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9eYeUxEBcHCW6JPkN9Xom4RnPpMWhERj8icpQcAmVz/G/2rZHndixOizP9YJc4JQMTwtuYKBkEw4uax+TOW/RLJJV7wo1ZuQKtAPLLwHn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6903
X-OriginatorOrg: intel.com

Dan Williams wrote:
> While the experiment did reveal that there are additional places that
> are missing the lock during secondary bus reset, one of the places that
> needs to take cfg_access_lock (pci_bus_lock()) is not prepared for
> lockdep annotation.
> 
> Specifically, pci_bus_lock() takes pci_dev_lock() recursively and is
> currently dependent on the fact that the device_lock() is marked
> lockdep_set_novalidate_class(&dev->mutex). Otherwise, without that
> annotation, pci_bus_lock() would need to use something like a new
> pci_dev_lock_nested() helper, a scheme to track a PCI device's depth in
> the topology, and a hope that the depth of a PCI tree never exceeds the
> max value for a lockdep subclass.
> 
> The alternative to ripping out the lockdep coverage would be to deploy a
> dynamic lock key for every PCI device. Unfortunately, there is evidence
> that increasing the number of keys that lockdep needs to track to be
> per-PCI-device is prohibitively expensive for something like the
> cfg_access_lock.
> 
> The main motivation for adding the annotation in the first place was to
> catch unlocked secondary bus resets, not necessarily catch lock ordering
> problems between cfg_access_lock and other locks.
> 
> Replace the lockdep tracking with a pci_warn_once() for that primary
> concern.
> 
> Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
> Reported-by: Imre Deak <imre.deak@intel.com>
> Closes: https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134186v1/shard-dg2-1/igt@device_reset@unbind-reset-rebind.html
> Cc: Jani Saarinen <jani.saarinen@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Bjorn, this against mainline, not your tree where I see you already have
"PCI: Make cfg_access_lock lockdep key a singleton" queued up. The
"overkill" justification for making it singleton is valid, but then
means that it has all the same problems as the device lock that needs to
be marked lockdep_set_novalidate_class().

Let me know if you want this rebased on your for-linus branch.

Note that the pci_warn_once() will trigger on all pci_bus_reset() users
unless / until pci_bus_lock() additionally locks the bridge itself ala:

http://lore.kernel.org/r/6657833b3b5ae_14984b29437@dwillia2-xfh.jf.intel.com.notmuch

Apologies for the thrash, this has been a useful exercise for finding
some of these gaps, but ultimately not possible to carry forward
without more invasive changes.


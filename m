Return-Path: <linux-pci+bounces-28927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE56ACD4C7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 03:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6E617B632
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 01:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F871553AA;
	Wed,  4 Jun 2025 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K63zZIp/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9731DDD1
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999739; cv=fail; b=XVik7y5JP9xRp7S61TPPJrN5WdyGqFtS7kmDwlKNmKUbgwbJJQpfcSTOkLsiP5IQyz+eBRJBCf2i7saezkMw6BKBqiQqHParDLF6waE6wi1cqRsvypN75vz+aN2z8A3ZKsA5bjmWEUILJDChThKIy0Oj9hPLVw93RnVctIqeWFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999739; c=relaxed/simple;
	bh=narXK0tc1R2rxba0qGnDdZb+eFwz5xQGi8dRuIMhhkI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sf+eUM5ZWypzSqyK3vBfiIEiP5baXeWE5qypGqCUSruoEgYy24LBXgWN08Hu3DfRpgxQ+dHOcpQtFLEmlMjXL0XwKOUhgDPIrJQCcNFxXN4vVvHv1eZk17oWUxZCxfcd5m1yDz796VxpzVvVRi6+/a/bfak3/ndHQxUeEN7S6kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K63zZIp/; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748999738; x=1780535738;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=narXK0tc1R2rxba0qGnDdZb+eFwz5xQGi8dRuIMhhkI=;
  b=K63zZIp/wQzgkD+oFJLWWC2vSRseuNUNv/hC42JyYqcmfnmx/iEe3Nr+
   9ZJdn6k5ujlcHhyfLSRR2cjm9UF1uh7IHjNP6dp9k8B2ouhIqNf+bPL0A
   cj20bHdC0KQoruKM09Kpq1406vM+i3xf7H64oSDbndAezCdOJwj1J5g1J
   jzGx/TK/a1ZpPx0SynCIHkmzSEr+Rq+LIcXcEfrE61HM/u2VG67DNdBCC
   wucS7yHmM/i1pJEM0GKLdSPCXAqavwbFNmiPRzwo4bTtYQnQc/tT7uN2a
   euVBbXYzWncFiAYuI3kOLNtl7KH3KM2pdA2KTmg7jtUn6VL6DIvimgegt
   A==;
X-CSE-ConnectionGUID: tbLSl3twRGyL8QX6BEwpiA==
X-CSE-MsgGUID: nHRq8dnSTC6d2tZRLJEzag==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50921238"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="50921238"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 18:15:14 -0700
X-CSE-ConnectionGUID: SlcZsNpbSIW+eB1nqrGnhQ==
X-CSE-MsgGUID: B+9nTwIXTVG2NG4JGnc8dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="175893637"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 18:15:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 18:15:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 18:15:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.64)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 18:15:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qw5wDyZnOId8U4bmv8X5YYL06OOns7innTIVLIXxN8XJtA0foCkEnJP06nD/VhiNopBjDr5xo4nUjEl9dnPeYloBrXmigMTsOA6GkHaXpbaDNKLu8UmTcKKI1p2YxNOosn+L79GqGXvjblWk616CY+gw6pJYmwcb9ow6FFYDmlc/5tLncHvJI4cHmlBxTiaiEcH+CTdRdN19E2N1gz+OB7hnRd4hthUY2aYardk+Mb3VxQG4zmdutnzxzi1W2nTXd1PqHJENd6OuXrFRnJHGbAoeYPdXpO4JMSzeWLGweEyIQLg8iSezW2XxxHafbGLfeQzw5whogAOS4aKfgAaksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKRwYB2sBBkjlT16M6y71536hRMszgTAeTVswKAp7Xo=;
 b=GTV7POF65nXb1SAdt/4FdKmeksZuFSkMZ3XnMb9acWLkl7vXl4lK37LM+UWApbZAMEPuMdul0Xbb1HFJU6pSawS6Vbctd2ctUJbezrMuyUzV0/U5RzcFFYd/dQQmxK9xSYT8HZPC0B2myqyj2QkPjxV35r+7mmz7QHxTZHIIfZiQluvWWIYjL4awKugduDLN8KgIir8+FgOW4kx5e/bPn/v9w5onjup4tj+yHB5xusJsLIAwIaOzl11tVtRSyeN/qFyiFhLb22Lq1xpMEv2QIvUc/+8OTTk9/dyJRQf4b3gUmN+9r44kk7MyWkFRpWXsHFdMoKEJQ2nwkL9UYfwlCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6561.namprd11.prod.outlook.com (2603:10b6:510:1c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 01:15:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8769.031; Wed, 4 Jun 2025
 01:15:02 +0000
Date: Tue, 3 Jun 2025 18:15:00 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<zhiw@nvidia.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, Yilun Xu <yilun.xu@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>
Subject: Re: [PATCH v3 01/13] coco/tsm: Introduce a core device for TEE
 Security Managers
Message-ID: <683f9e141f1b1_1626e1009@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-2-dan.j.williams@intel.com>
 <20250602131847.GB233377@nvidia.com>
 <683f965d41634_1626e10043@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <683f965d41634_1626e10043@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BY5PR17CA0038.namprd17.prod.outlook.com
 (2603:10b6:a03:167::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 65db7954-c1a0-477f-0cb8-08dda3053b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3/smeThwf9ltBMxzRenOFeDaU+fg0fe/Xagqxu6KlUJOd/nMllv9KCfu5qAf?=
 =?us-ascii?Q?Cf9xn/g4sDH3/XyOYAtrNXSk9hm0fv9AkEXzIhlkpYXd2XC53OxzUQ+ee6kf?=
 =?us-ascii?Q?D/Ut8D2/zuwEcqkS8UV0BXz7HXP6JDgjl2gpj4POgTP5tgOXsfDayYhiX7kA?=
 =?us-ascii?Q?rHwyd85CZiCk14YMV0817SEjg1g3FtDPkwNW2uBTTduFHpC1cnpHD/xBZ5ET?=
 =?us-ascii?Q?jq8PUSAPbOtdxlm8gymWiLhYg1glbvSCMFt52BhrUdQ60drIuvEV5IUH6OX8?=
 =?us-ascii?Q?L3sHtQQ+nmqwqXpGJofIIN8DpelOh6i+yz6X0HeytP53pWPDDIj4++35bPyP?=
 =?us-ascii?Q?1h7hPLS++O8KOOUA0O0ZIRkHAbr95w5MtSL/SrSOM4F+TYuowtnyZ5dMqaj5?=
 =?us-ascii?Q?bgCY3Y1AwY6H485q8j1w/U2gPkGbreQqgOzMAwFt7IIVGB5LsgUVzGipiKJt?=
 =?us-ascii?Q?RYzkGEWcX7YKAWOQDXZySv4cSWEds+Vq/9atVcEUB9VybcBbSBZvmIHPXsaw?=
 =?us-ascii?Q?gzxdiKV7MuXOrcEi4nDkrzc+Pbwb2HSvKzEJz3Xyt39ri1oog9b2VfxzCVhb?=
 =?us-ascii?Q?oaaid4IjGYlVKnvkPDiBTBQLmvl5tbeXN8QINp9JJMLKui4wW51wnRkr8MMU?=
 =?us-ascii?Q?fO8Ikxvv7wrriHxSjUjP3YVhjfrD5h8Qd9aKGRZri080e8nouvvoOiFkwzFG?=
 =?us-ascii?Q?u1ie3HES0fIeH/kuPl+KYFmFvx8G2h8ioQ4XOAJUhkknJP60ojcqOyyEGmox?=
 =?us-ascii?Q?PRNqL9X331pe4tJe3zM+iZ4UX8dXXgFWWQ1BaEcTFo/LIN74uff9tbpirkRq?=
 =?us-ascii?Q?PYYkK4eoBkUIOGUmiaPlFHIXVOjJVlIkMDZJvKEV7AjpvLz97un7lPGvvgWY?=
 =?us-ascii?Q?GRYYOyDrvfhICiqdhU2ZmHOL9WMIsKuIqIrlZz09JDdzLLXbTU+aO63eNZxo?=
 =?us-ascii?Q?RmofX8DzE+9oq7XS56kJox2aWEqbzmyQD5Xgs4oPUIYh8P0dLzS7eZfpv895?=
 =?us-ascii?Q?fWwvlP2RsjdxBnNmMswVH44gxsBpqRudocnhBHhXFqca+L2Fo1QFfWHE2NSC?=
 =?us-ascii?Q?gViif8xIL2+g+DrYRvLYZlDDZRqF/RAl/jPHh8Q/FAG+Jcr3TG80h4SQLLWx?=
 =?us-ascii?Q?/iIUAd2I1AKuOXz+7XYhxzqNFYrjHmDKuAq0fnQRr5RUZCyfTR+EOyT0memR?=
 =?us-ascii?Q?NmTtjq6ucNQwsC3YEDYu5b9wHQMWl7tqjyzi+/KWSq7PeUMJ5FN6rID5Afm0?=
 =?us-ascii?Q?aky6aqPcBvoYUNtw8muK5VxcFJcDTMLteybXYxFFpHpBxEGLj+p9MHHOyRfT?=
 =?us-ascii?Q?XJ4SZf4KdU73LX+rIxLIuhgB29P04sqYk2G2Ng4LDUbOTbPI+GefiUjlUe8S?=
 =?us-ascii?Q?a+xOpv5D67Mnoh7vDy4te2R2VMAUKoFA0cfPWde8RaHxjcqx1vc5tu3Pf+NS?=
 =?us-ascii?Q?qqe4+KEuvKo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EK9/FWHRYI45zclulhpEA2ebK+N5DQo/C7yhh345JGxjGnfTZEde3aSt9vfL?=
 =?us-ascii?Q?1D1B8xgYYChvrAXl52Hq6v32+jLgr4f0tVat9QUPdv6ZRcoLT+ETwqcrmMVR?=
 =?us-ascii?Q?F7v/aZ+xSN9JEsnPzkG+arP8BlEcqMIOIdmZPqr6rsRwG8ffTG7fp/3HBCn2?=
 =?us-ascii?Q?sJ7Ol6FkniVB/KQNCpdP+IeGlivLgIKv+A8kUzAKScDNIxp6j0v0JoIWiI54?=
 =?us-ascii?Q?l2MWiruRvVroJfHh0WxSjkZIxNTqXFSg7FZjnTEPj9Pb/eooS+yP4Cesjbrw?=
 =?us-ascii?Q?aT2KhfSo6ncZUFrFR6NtXpI+YUEwmg4cIPK/570uQR7oL950LM+WmO997MzX?=
 =?us-ascii?Q?qr0s1V/PzcDKvhqCh+LdyxPFGofImTx5ES2mXEsJGOjudL24bJavwXW4la2B?=
 =?us-ascii?Q?rJMnImC3qKvDcBtfQTq2fSKfRyYlATVDdshNH7LmOKXbTDpwLyDgSGQ2p4lP?=
 =?us-ascii?Q?NpCrCqCWUUgfan6XpJLJkZHTSHSoznPihQ42hd8p/oySlYAY3ifOHfRQs1Rp?=
 =?us-ascii?Q?LoE0RDwKfgs6Y7juXF7+i6UDQFZaN3EatdWtYM0U0PloQ5Ry3QXZBwzRf6Gv?=
 =?us-ascii?Q?7mZDSMgdwlY6jrTduHblaXaV9ujlUQbnEg1S7WpuByESctAQCgRME/R2OVBc?=
 =?us-ascii?Q?XUN+3KVjv2D8nAR7vJ62SeLQcnsSmrnorAwSU2/dV8bKcEhXRQU7LU49leEl?=
 =?us-ascii?Q?ROUt3blWlX+UIzBK3oMi15NQzo4Eyi4BHma20Zn2rqUdmk/3Dv6mw4OCOnlj?=
 =?us-ascii?Q?SCRCRiD/eGD73s7r4P52gJtBj6cCAxrur26wnWwAoM7vgL8oLQ0/iffAROgr?=
 =?us-ascii?Q?A+kWMj38CBODR5JWs1DXK6KEOuVFAP9RO6vPSPk4J+m9v9LpOZ22u2y6a9/F?=
 =?us-ascii?Q?Qceehys52X+oBhCvx5YrlhTZfmZOzjZDhAvBuHXyrb4c1kP9l5hAByEuLYps?=
 =?us-ascii?Q?+lBf/AthI5zm7829wXjt0bMf5/e39GlqZwo3JrtFVfUBclM20X9yunE8vkiX?=
 =?us-ascii?Q?oD3GKD2nPNQ3o2cARHRPbOyRJyK4r9d3QBTlkxWGU1eF3e4+aCd1UQMlRUyX?=
 =?us-ascii?Q?6LsJvlllj11OYCwg36WdwuacY7fVJfOyZo4nCob0EQlTywd3A1as6wbxzCle?=
 =?us-ascii?Q?hJDmkp3qZ3bBkKEeSo2JQ4RO7tlK1qTsN041YI/70xwvC66YtVqvhwip6aw7?=
 =?us-ascii?Q?ptBWqbSeKzwUF1/yZFxKccDvZvBfAs4lZSogzIiIZNQEeQG7pwnSANPclDrT?=
 =?us-ascii?Q?CKvqW4ET4J9DH9NSa9WrQEzLD0Ct0Ss8gmjnFvT59JbaeLkCCpg7qR6LScfN?=
 =?us-ascii?Q?2OHVw1Gb+fX5D0490vQbRn5TPcWEHBpzdBR3cYm3hkcpY+BTe7fHYJ97+D7r?=
 =?us-ascii?Q?UtFCVFswmAl3KaXk65S3xXwDCTWbpfpzeDE/+xTdTdYm5RjFhUppkmdXngxf?=
 =?us-ascii?Q?Q2/uO0YKLhPqv6BITvwBmNfYRcj7T1rfVWffzLCveWL1fCCbfOP8g9LBuk24?=
 =?us-ascii?Q?MMXIuhblSfno2kVI8irFtxJHlulamefti0IG9N2kKQfKVqj+0ugzpWSvdeTG?=
 =?us-ascii?Q?9VtHgtCP6bKPEOtFKbpwu1gHHf4EzX9+MuWgFBjmX1JO4pHylty//JucqSlN?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65db7954-c1a0-477f-0cb8-08dda3053b59
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 01:15:02.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +f9XR12KC2+7EtGDysWgaepoVWulR+jiZpcn83K7hT6gc9rorEiVxcDkraEyJCgoGxRVuQPLFrfQt0dCJGY0gV+A+YlIPXVXnlW5nc4iZK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6561
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Thu, May 15, 2025 at 10:47:20PM -0700, Dan Williams wrote:
> > > +static struct class *tsm_class;
> > > +static struct tsm_core_dev {
> > > +	struct device dev;
> > > +} *tsm_core;
> > 
> > This is gross, do we really need to have a global?
> 
> Let me restate the assumptions that led to this, because if we disagree
> there then that is more interesting and may lead to a better solution.
> 
> * The "TSM" (TEE Security Manager) concept in the PCIe TDISP specification
>   and, by implication, all the CC arch implementations, instantiate this
>   platform object / agent as a singleton. There is one TDX Module in
>   SEAM mode, one SEV-SNP CCP firmware context, one RISC-V COVE module
>   etc...
> 
> * PCIe TDISP is the first of potentially a class of confidential
>   computing platform capabilities that span across platforms.
> 
> * There are generally useful details that platform owners want to know,
>   like number of available / in-use PCIe link encryption stream
>   resources, that are suitable to publish in sysfs.
> 
> * Userspace is better served by a static /sys/class/tsm/tsm... path to those
>   common attributes vs trawling through arch-specific sysfs paths. E.g.
>   SEV-SNP device object for their "TSM" is on the PCI bus, the TDX
>   Module device object lives on the "virtual" bus etc...
> 
> So, create a singleton tsm_core_dev to anchor attributes in that
> "cross-TSM" class.

However, after spelling all that out it occurs to me that a class dev
already meets most of that requirement. The name of the class dev does
not matter much, and other paths can enforce that there is only one TSM
class dev registered at a time.

So userspace could lookup /sys/class/tsm/*/$attribute and as long that
is a single result, great. If that ever returns more than one instance
then we will have entered some advanced future where there are multiple
TSMs per platform.


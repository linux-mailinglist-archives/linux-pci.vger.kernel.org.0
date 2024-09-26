Return-Path: <linux-pci+bounces-13573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681EA987785
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 18:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89AE1C2143F
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 16:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3339015667E;
	Thu, 26 Sep 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zj2GN7fX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEFF522A
	for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368071; cv=fail; b=BbE3QF2EkvGbQajA3Sog1gVpGgqJKwOV03YswnAWDpMBDim/w4G+PUei8ipFUCj2HHZJXNbgGCDkOnHvEW6p8iYCzYACmlgG+Z94A4n4hFl5EyY5VwUcqClhH+8RzXoaUL+oK4BHNzcKyjCNNKypQ+HWr4j7y+E4KGPRXjAif4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368071; c=relaxed/simple;
	bh=IoBECeMupSIEM6LfxSqeNdH4O4hTG10vMWGHrsrmSEM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=feGxDK9GWoVMwpq+Yyb0lIx0115FIUkPl1NRA1H9hhaV9eEi6M2Wgc7XjzTYQVuq7BjS98/ThAIJh7/b9PuC5W25W/+BrUci3l5yCXYigopy01gtji/5GdLOA3El3X/OTc04Fu7esEktVRfU8n/p62+afUM5nFp9KLv8L3jNHug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zj2GN7fX; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727368069; x=1758904069;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=IoBECeMupSIEM6LfxSqeNdH4O4hTG10vMWGHrsrmSEM=;
  b=Zj2GN7fXPe8x/uvOnyOSEeHHUmcYEEXhHW37hY19l9kUvQyGrDQtrF9M
   258u/t5sTq2R2p+Ix2c9kWUtBHdwi+qNgB5Ao6JkGobpnKwXpyjDPx9XO
   +FdjeIt3M2IVOejEMxjZEKR59Avbrg+D3l0mczJGd5m8ZHH7ToOWkoV0w
   Ti+MIgglPjjXlkPqnXJT36pVNKSkR3ilGTb5oBQvUBfuQ95vFZg5Ipwxv
   pMnECLHZ5EUkg4GGfexB7ZzYTazukqAHMKO4g5dIxByQX/cFSlauIASkd
   EoPWUqZprxxyJoOD3ItZzug8LUTkhzr/Ua/2yZzO5XawVIFI2ZdqxfdXK
   g==;
X-CSE-ConnectionGUID: DUelIc7jT0KjEMMpFHV6cQ==
X-CSE-MsgGUID: 8ouzHqqaQrKeQWhsO9LpNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26639707"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="26639707"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 09:27:16 -0700
X-CSE-ConnectionGUID: JMsfFou+Tl+I8wlruEuHXA==
X-CSE-MsgGUID: seGvMG91QzuUaxhaZ0IWeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="95559993"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 09:27:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 09:27:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 09:27:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 09:27:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 09:27:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARzkJF2xjvkM5srRcbXKQ4M9B7C1szT90z2OSjJ7NHTT07iw1X9RhzKtvpeP9+S8Hv51AZet6fSO6/rHFLOFjzawtBBaMWVI+g1HGqynUKyW+Qv/EutxQq5w2VEEU10U7t1kX/8srSo5aCGVOx5+JSPTQ53kIwLhWLb8IJXcHZw50E/HH02zUk85nKGIeW4im952XoJCobligHyJuxKXxHFRDcsLrWKqJ5DdwxnT7IeBhoYhuGq4cbbK9+w6RHcO8wSrXoDUjb9utMopeWqUsO7ndKuSseu+y+10gTDXwkQJ1SS3HZaOZrvIviXC4fxTBrxOnhPe+GUdXRSGBAMAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h510MH6unuqpuyK4RobViCFbVCgfkzUFL4rHXXV5rvY=;
 b=FOVw2hNGzIBYznN7e4GGO/f6Ndt1ibxRg2MBYtFJGRIx+/8QLqwnC9IEUF1Ps/dJWlJzOeqmvox+sB3rFE0cQareNcFzUP+DubGW84pnts6Nn5wzZeoNaS8vZkRc0gHuaYvFie63m3GW+uE6jAsdLYaj/fkfm5eSyG7jFIQIPM1rAy3i/mdOKvqoQ2cRJ4Uq9wVjnVfpd2/JOSXe05v/c3UsyP/NsJafLaekYsd1lojqOTICnc17HTNpeAK7zWAmoD7IQoZWusj1b6MHfjY7ZyIbGvi8Ib1qMmKcU8IlbBPrc5WpPz4NiBZTNWI2nzHJKiT6np715H3+ccmLrKPI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2854.namprd11.prod.outlook.com (2603:10b6:a02:c9::12)
 by CH3PR11MB7915.namprd11.prod.outlook.com (2603:10b6:610:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 16:27:10 +0000
Received: from BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42]) by BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42%5]) with mapi id 15.20.7962.022; Thu, 26 Sep 2024
 16:27:10 +0000
Date: Thu, 26 Sep 2024 12:27:06 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 5/6] drm/i915/pm: Do pci_restore_state() in switcheroo
 resume hook
Message-ID: <ZvWLWtooNVSIc3gD@intel.com>
References: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
 <20240925144526.2482-6-ville.syrjala@linux.intel.com>
 <ZvV0STiWx6xyIE0E@intel.com>
 <ZvV_bdAIYcVQVold@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvV_bdAIYcVQVold@intel.com>
X-ClientProxiedBy: MW4PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:303:b9::16) To BYAPR11MB2854.namprd11.prod.outlook.com
 (2603:10b6:a02:c9::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2854:EE_|CH3PR11MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8637b7-c10e-4c27-2227-08dcde4811e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?FPQ8sHvvGkgmmWZ+JU0lFvIIrde5cjji5Y7Ym2N6Ns+1n1oUI/V18Q0eEY?=
 =?iso-8859-1?Q?9lCVB7p1WCnynOvLd+W04ZTFT7vKYoJmSVsr1hZyvfIFXErDObPn+F+pXv?=
 =?iso-8859-1?Q?/Vu4rhmzWo9C0Dn7M9dG5YZps+qsFG35i9RG6ch2KfWciDrPR5jh+ntN+p?=
 =?iso-8859-1?Q?vZIPqQqDHidlUDmMXN7/i9JdnArzsMozRLPtWuOCOvzi3mtGDSuqWPCKgB?=
 =?iso-8859-1?Q?2oohcIEkkzPDn2+EWKLvh1TF5vL6Z5WolfVPNjY1C8gMhA2XJTNvNTrxdt?=
 =?iso-8859-1?Q?+m+qEuFjV2ui8k1fhT64H8YuDMt0EaS3dubtGfRvSYnRxPKH3DTcHv/8Og?=
 =?iso-8859-1?Q?kvFlhMwQqtOVRgF4nKqTKZXi0LaFsEZA7DXfo7Qqdscpe/CIi0rS8A4QE/?=
 =?iso-8859-1?Q?mOPCOOa0SQgYm8/ZiFtY3aqElDQj/MwCP0WP1mXHSm3WXUO2971GeR9lBX?=
 =?iso-8859-1?Q?hwTJXUTjf2kueysYNzre/bZmfEzoAg9iicVFIZBkTSYEiNpNIyCw7uvZnY?=
 =?iso-8859-1?Q?RWRFS3ad2hWFPRdaZ6Fb7XeGekYbo9Oii9tqxfsjlFZvjDGje6CI6igzGM?=
 =?iso-8859-1?Q?M0DJaCg1O4yoY1Z/Z/MmxSTC+lkIZuoOAL/fTKhFZrSvj9MqnA7HhEA8j5?=
 =?iso-8859-1?Q?1J6yODoyeF7/idyP4h2Nn01z5hvs9SF43VzHJnNDez9FC5fU60EcR3CPq8?=
 =?iso-8859-1?Q?d6mWml4GL/VYf/MNh2VBb4COoNvuSQEheCQrpMuWX3b6weL5P+krmF6Upc?=
 =?iso-8859-1?Q?d1LT4ASu8rn0Ou+rMJxmmcLeQ3Y5WrsvH3gQkq1AC3Vd0dqGY8vg8wj0h7?=
 =?iso-8859-1?Q?+GWcMKvwtOhk1qYNh7iXqJSzACBJks1Zd8piPoXS3uM5nm2u4+mZIJAITl?=
 =?iso-8859-1?Q?fVfq9qSKsTWq7iwccmw4wLNVxq6gyWiMw0u8iAe7w0aGw8Chcn9DIM5yZT?=
 =?iso-8859-1?Q?QXLacX99uzH3GHPmh3iIMnMYd9do6PO/RuVBnpYGBvNoe7kI1qladIFaZH?=
 =?iso-8859-1?Q?RwDl6yDUiqNnzSXJRk3hGNaLM6gwwFoe448j7mwqlddzjxz3MbZJF5Ggks?=
 =?iso-8859-1?Q?3ZZHIsyN5glqRmE1kcnP/TuzvjpMKDj2vwhjKHybIXjkxQoKWirD6zgdHg?=
 =?iso-8859-1?Q?ZJ5d71eas2vijvm3e48m1Trw5rh2rr3EeFv3mZd0ntMYRMS1LZVBFfvcF+?=
 =?iso-8859-1?Q?84onO96Yjpdv+3n2i75AkkvfjAmXY4Nxn5IUaiYS2/tTtJ5ab6S2TkWZMf?=
 =?iso-8859-1?Q?+2ZTChG8ACaZMLq9cpAJNYHPZf9Y5/n6EzOo3hc4wjgmLvTCyvUQYASkyl?=
 =?iso-8859-1?Q?TQusa5oFvftpKSi+fSkbGrWRy6cl5Vq47HoLRoTsHhQOfhwh4XuZFe4do/?=
 =?iso-8859-1?Q?KOBuCyB4QKm0i+anYXmpXU+EeseGtrXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2854.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ui1HJcLj51miLvzjy6Mopg8SnJolWBkls4KLyhBLPVlnxbcoP8fT9B0NEl?=
 =?iso-8859-1?Q?DSL9J1Bak5uQwlHgza4l9QBcxVRRrI6yZf5yQxq8dTuv0QUaOaBCvCx49g?=
 =?iso-8859-1?Q?dZ8zO1hNUXX6LxOCLbXPSZOzwBfih2cxu9aNP+PWdf+01ROmiKFNaHdevX?=
 =?iso-8859-1?Q?3Hp23vmG8CF/QMKAAYrPtndS40zvXV1hrCvVbHQB4pLdRApksqzia1SRIu?=
 =?iso-8859-1?Q?/vvmO5R+Pi05p/wcOJEfz/qvXA3KP7n6hWN0O00Th7boAiceIGU/ui2apU?=
 =?iso-8859-1?Q?3gtgsaFjK8h1A8CZoHKyEXCr4HBujO0O5wsJWkQK+pMELTaPWlKYyEvrjY?=
 =?iso-8859-1?Q?lrMKlE84I31YIlQQRkk8j5FpaXZuasC0G+YqAB5xnrXlEK+TAwkSRSy4PV?=
 =?iso-8859-1?Q?K4x4HI3wQKZEOw2FjSkAkO2jo2zO5hhHjZBIfOUwKt0JtZO9Objj/V3Ua+?=
 =?iso-8859-1?Q?S4rVQCGWr2rvdKLvFHxH8GEQEkduGF3SCrWfDph4aHxNmmt9YkQ8J1KEnj?=
 =?iso-8859-1?Q?30XniOtM4PzQHkjI/i+eesCBkBJnF0NSez8s9F7tuYYev983HHTolFcSGM?=
 =?iso-8859-1?Q?+bfii1JKL2QSCIlJUm2UdWxQWB7kRveGxN6fsTLJ9NNzRjrLm030mKicvT?=
 =?iso-8859-1?Q?nbN1kM4wXbBqefnO6SJ1YNLA3D3KqyTRfqh8IXTRrZQDed2X7JSn0BreaV?=
 =?iso-8859-1?Q?8SSA20f8Ct8QdZ14/7qOTiuOFFzmLdB0jWHe4QCY2Tl+LElpXXiq4qy1qG?=
 =?iso-8859-1?Q?Af/h2DAwK7xvHhFHZbMf6u300GoqM2Mq5CwrI7uYkviHHCBvLqpOluS5Ls?=
 =?iso-8859-1?Q?hzAWr6aFZhdtvwIosn6kXxIcvBgcnJQRE1DKfC3HHavL0HTJ2KRoGd2hT+?=
 =?iso-8859-1?Q?KGJt1DT2X8sQi0PKHMXfCYMJDpNS1pZVfAikHfbcf+ooEks08OJQSlKHDn?=
 =?iso-8859-1?Q?ED5jSv6vfBBXEZbTMVovgNTohYvZYWX5MbuhaVuo+IdymrbKJQUrMz6xz/?=
 =?iso-8859-1?Q?ORxTo9yBhhQ0XF9D4h2R+pqWT64P+LtJn0z47uPPexsVuk2PUPmHN417pA?=
 =?iso-8859-1?Q?R8PTVro2AEeI3gZi0Hqi/5iTHlMSWctcRNPCgx/CPp0kWSdxwgmIFny1jr?=
 =?iso-8859-1?Q?yU/+5Y/Fqc+4hy0JShkejftLBUoo6ZVlxryb0zJkgrJQfV5gMsRahTrUt0?=
 =?iso-8859-1?Q?FP60JU7WXKskwihRjLsT6ReBOc5GyOLq6OcuFB+f5OMbAuJ/ldFDY5QdBF?=
 =?iso-8859-1?Q?0fGbnj2f+ADAs3RPUAZFql1kAPtnQqAHlZp2hPvnbB3szy7OHOuH55qmKK?=
 =?iso-8859-1?Q?sVFtZCXucwjudMkr5IUgp8uAemQEB20YX9894ZjQwEgfMTIdRnkvbp9hpH?=
 =?iso-8859-1?Q?qmq7b6JNSQY1ZQT6kiZlDp/fcYwc8pmTcIWVHH2jIFz1WFcq2o6NMkwfe/?=
 =?iso-8859-1?Q?c2i4uSNyWA8PNtLYrTD8yRObp4OYpqHBBvd0IZ39kIU2SpxaFo64aglEJx?=
 =?iso-8859-1?Q?jOFlkLkT5FHLsynDVVP8UMsXQGSqeG036dZNsMWozu+ySWHP0kw9Xgnvhg?=
 =?iso-8859-1?Q?5V4GW8ju4pjFpKaUXGCdFVRCYPTGkG0FsNuisES8ZU78O7sZQpDvu+Hfxs?=
 =?iso-8859-1?Q?JUUkDfBvvkOBfkDcgt7a/c9/diIKQH9YYEBHPdF2pAM4nI01JKb5yXMQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8637b7-c10e-4c27-2227-08dcde4811e5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2854.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 16:27:10.0688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47gCYrQGQBoZ+yzBTTGvNVGycuI9fSJ1dHdlvkuNuvHHvGRD/7SaBDXq1thCxoX98HfLPloWk1NjGzye4tZLig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7915
X-OriginatorOrg: intel.com

On Thu, Sep 26, 2024 at 06:36:13PM +0300, Ville Syrjälä wrote:
> On Thu, Sep 26, 2024 at 10:48:41AM -0400, Rodrigo Vivi wrote:
> > On Wed, Sep 25, 2024 at 05:45:25PM +0300, Ville Syrjala wrote:
> > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > 
> > > Since this switcheroo stuff bypasses all the core pm we
> > > have to manually manage the pci state. To that end add the
> > > missing pci_restore_state() to the switcheroo resume hook.
> > > We already have the pci_save_state() counterpart on the
> > > suspend side.
> > > 
> > > I suppose this might not matter in practice as the
> > > integrated GPU probably won't lose any state in D3,
> > > and I presume there are no machines where this code
> > > would come into play with an Intel discrete GPU.
> > > 
> > > Arguably none of this code should exist in the driver
> > > in the first place, and instead the entire switcheroo
> > > mechanism should be rewritten and properly integrated into
> > > core pm code...
> > > 
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: linux-pci@vger.kernel.org
> > > Cc: intel-gfx@lists.freedesktop.org
> > > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > ---
> > >  drivers/gpu/drm/i915/i915_driver.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> > > index fe7c34045794..c3e7225ea1ba 100644
> > > --- a/drivers/gpu/drm/i915/i915_driver.c
> > > +++ b/drivers/gpu/drm/i915/i915_driver.c
> > > @@ -1311,6 +1311,8 @@ int i915_driver_resume_switcheroo(struct drm_i915_private *i915)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	pci_restore_state(pdev);
> > 
> > then why not simply call that inside the resume, for a better alignment
> > with the save counterpart?
> 
> This is switcheroo resume. And the counterpart is in switcheroo suspend.
> 
> For the core pm hooks I'm getting rid of both save and restore.

With this I totally agree. I probably missed something when just
reading the patches... I had to apply them all to see the final version.

So,

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> 
> > 
> > > +
> > >  	ret = i915_drm_resume_early(&i915->drm);
> > >  	if (ret)
> > >  		return ret;
> > > -- 
> > > 2.44.2
> > > 
> 
> -- 
> Ville Syrjälä
> Intel


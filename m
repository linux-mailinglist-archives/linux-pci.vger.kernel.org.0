Return-Path: <linux-pci+bounces-13566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D879875E8
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 16:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF592883A3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD4F82D91;
	Thu, 26 Sep 2024 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eh9hHfQn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9D5338D
	for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2024 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362018; cv=fail; b=CQRkxROH1htmtRNcAFNMZvLmYf86tLbDrpvTo9DrudQtv2WiAQZekyC8COnEdOu8M7/6AEXAA8K5+7opRnkiiIWT0m65I4bcBfI9j7DuOM2kJh/IaZQFjatfKclnvlgyAyh59PEZ82K18BnA/ZGJVSkUHdL4tlZVkhKCnyR5IPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362018; c=relaxed/simple;
	bh=qTeaDzxdcgGpkJ1W8s2aS4FYgR1o4QA7EbUcrAWiVFM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uS1ffJ4BmL1ThUh3oNIqhrFJucqOZBkksCgDMlfoscHN9/ZwI07jv4Ox1QjwJlVptj4lbdsq5hl31Kya3Vn8TYrGNki8216JsbVq00n3DS7aohU5hg5kAqJ0Sb6wPqvPZ/2evqM0PKyym6sIgWYNqw82YoIH0peBxYkKYO4ymXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eh9hHfQn; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727362016; x=1758898016;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qTeaDzxdcgGpkJ1W8s2aS4FYgR1o4QA7EbUcrAWiVFM=;
  b=eh9hHfQn0thDAuPT+PF/JWSF5xZoQB2hh0si2F4ejcrq27K19N+OVRbX
   2d8d4AtDMGVHxVFnqUXgPK2LZrWahmGJOpFbCLai5bqSYTsGQ3jvixR4i
   3I5ZPF4ekPYmVKOmrsUJJKQILGwWoJcSWbIDM+8IMJuMzz1A2QHMUUB2E
   Mu5rI8yNmeoomdaIg726ppFKD6jY2ecO95XsDgqaVmuZ4D0xewHZeNoob
   QA02Bm/SfOMN2viNH9dcR7np+V6/THB29GmX/ogJHYH5F0EmXA1mImFdo
   m+4socBoga2qr3MOn43LTmt1I4ZVh4AaUn07S1TpegQCUj9FwgTbqQ4Hk
   w==;
X-CSE-ConnectionGUID: 1PlbPmPGR0WH32+JpLaldw==
X-CSE-MsgGUID: TQcwrkEfTU288YdzZw2Lvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="14084624"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="14084624"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:45:51 -0700
X-CSE-ConnectionGUID: jefx921DS/SIZhq8buJMOA==
X-CSE-MsgGUID: 14rjPzvvRbOameq8wIVgWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72328209"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 07:45:51 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 07:45:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 07:45:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 07:45:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjNpm+4MOdnfyVyI6Nj43WqIgryvf6BQS4/rW4xR/iu8N3JqLEzEWFqE2K64BB5QWPmZFZmYsTJltNrxaF4Yb3LWqZ2cr3k2NJoAmjkn7SOqYqFShjDDdAJZYBCGuGogf/y6h0sq0iLSWapLXixLvBPtFxRL/SUerA7XDTCDnRnYGsGzHfouBQqewvx1HnvTYmJARFGufMz1eWZ2A7i1lcBnVItMA+EaHo2LRhK7Flr+ecfxw/sEqwAH6c66KPtTPdxekKjiDHprUhamGsHaRkMVFpDpZpgF+3ICA8R3DPDFmuKTk9bGz9CEbfVrCdb1NvNL/KYgqKl0FJOBuzQJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsBa2jfCokfDMypU0K41uvhR4Nl9OGuaRi1uh2CBmA0=;
 b=ayvUAgPE+6MCxFUC5f6W6U3U45XgtqXN4RuLB/Ng939MXkapbMr4Qofbzc+QTFLpxe3oasJy3IiLcJcXkcJM/t/Cz9ofpZmNUyTWtyfIilKSXYDuUE9+NH4KV3k/2OfPC05J9OpmwSq0ojUWVykbZi7ve9+8JbWstiiuRa5ydzVYt3By/QaYwjzUxzs3zWr0WHljM9qAGM1FMwfXTt+r8Bh9R7WIXYCO+X6vBkNnImpIEXg2NvN6ZI0vg4ee9Yr4pqZ2G/6o7WyIa7UQaFEz8hpHUbbWXwJhEBXMJqTkBbviQ81NEdRip7R5vPMeUhSzdZn/N5q2ouiDT7SFaxi9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2854.namprd11.prod.outlook.com (2603:10b6:a02:c9::12)
 by PH7PR11MB7641.namprd11.prod.outlook.com (2603:10b6:510:27b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 14:45:47 +0000
Received: from BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42]) by BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42%5]) with mapi id 15.20.7962.022; Thu, 26 Sep 2024
 14:45:47 +0000
Date: Thu, 26 Sep 2024 10:45:44 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/6] drm/i915/pm: Simplify pm hook documentation
Message-ID: <ZvVzmKIL_PrM2fds@intel.com>
References: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
 <20240925144526.2482-4-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240925144526.2482-4-ville.syrjala@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:303:8d::17) To BYAPR11MB2854.namprd11.prod.outlook.com
 (2603:10b6:a02:c9::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2854:EE_|PH7PR11MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 560b307a-5ad8-48e9-383c-08dcde39e883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?aAT+Hg/Hux9NuHqvV8pL9dNedFFqwdXdG1MQoJ4btSmhNmbIX5j9ZAFLGj?=
 =?iso-8859-1?Q?Bvu6IQ3KHM4l9zUnX9pWBIeWqmM7DDuo+p4sICE+ANZ7az5K0AyJgsFX3s?=
 =?iso-8859-1?Q?3QcXJ/DofB6w6/ZSgiQ3rpaPxbrRlUTH997Y530IhHXy6ukdWSi5MSuFk6?=
 =?iso-8859-1?Q?/88a61+44GIpvmickmuB4LkTPN2iGWBiyxr9Ljb/Q49x/Gkm3SNAoWt1f5?=
 =?iso-8859-1?Q?CkIxEhcH3ny4YubVJiwZkWx4RQiHsuuj06K3s1addKFI0Rl6Ftt/ZrQBC6?=
 =?iso-8859-1?Q?Z4bqtj1WLHxEH1XDRZhOlDWAV2e6NN75Hq2dND6FBUOQRFhsiEEvIOYDmg?=
 =?iso-8859-1?Q?UExUvfVEQd9rF++gU1ZDduIG5tnGBK2aapEWNiwRDxj54zTUdAY59rt6VI?=
 =?iso-8859-1?Q?5TmLJZRvgNgjH4Gu7MEOSLqykWcFi3eY/ebMV1SoJeSSAF3k4KVOltE+du?=
 =?iso-8859-1?Q?IxCJw/Dzo4wxNtARRn4vEqbGKqYuBxEHRQ6ya8pvw091gpZJXTXU4QmGTg?=
 =?iso-8859-1?Q?nZ5uobk++wjlk8BTTSwuTAi9lgS7PFnvAeF2wKaE0HOSpWYtcU49eBpYs0?=
 =?iso-8859-1?Q?/UzVG2vv99AYjScMbrXXpxzeVUFNoq2t8vJg+oNnxsXdeYDK5vI+NS1zf+?=
 =?iso-8859-1?Q?UkbazczYrL4aBtUWCVhpNTXwJ4LEH2BNeqb46YL489LdWtwyCmu9+mg5t1?=
 =?iso-8859-1?Q?3zq7K8/uFoznk1mDFCV/kmH98ERxA2XyYkSqfYLzwbdEvc4dPnaFqZiI45?=
 =?iso-8859-1?Q?pf24fq0ynVmR7dijRPIJSRRpEkLi3/TQnXcvAfS2n2cfQmEoH5U0kJV2MB?=
 =?iso-8859-1?Q?2kigPJqEljSjdRe0HRpwLpkL5yvyTREJbT7kps8CN/VZndqLQjl7bdEgAY?=
 =?iso-8859-1?Q?KWTDY+xcuu61iclIykWnQi0096HNqzkKKY8mOB9Z3Zge3lcNde93u92zEP?=
 =?iso-8859-1?Q?aq8dqcE7zvxTn0o8U4qhccRsSVRtuB1s5UT8fnaMqORE5685dHj3NqQoJ3?=
 =?iso-8859-1?Q?X3Nn86ZpVc1nekqW7AhYdHouFSi7Dd1a9Np/3xNuyM6SAJyGMuCRMJ+pG9?=
 =?iso-8859-1?Q?JqqIwVEOXq9tB55/9qLdhfTq9Worvnv/LF55IvE0LU2Cy+ChcCldh82NZs?=
 =?iso-8859-1?Q?sUkiiij7XNqhbRObEBefVSnDVTYmrlqadjTriH2g6n6R5X5Pk9uaSWU65q?=
 =?iso-8859-1?Q?V70nM6rmZgZeNkFNpQke16mW2GXDdb8PxY+z5UIgnnZE20WvWudWdpnw31?=
 =?iso-8859-1?Q?iROLTfFGgNcwtg7fro39+Fi95PspByFLDb4Xf07ymXszVyIapDGuwySe2K?=
 =?iso-8859-1?Q?dxn2PmQZ66/f1lCTAxxAWaDV3g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2854.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?e2Jrq0FH9z5o2M/0zESl44RPrQC9cG4PCeWt4ThH0xR9LAIAjCkXrCY3d5?=
 =?iso-8859-1?Q?+nLsQV+buBR+ZdTE/0FAqKMbjuILl2YSEJ6AlGH8MmRxwwqYIvDcQRvWLn?=
 =?iso-8859-1?Q?QuoONXyFj9oTu3C0Y/ASfLvlz4Q6kKDRr70Y3eAP9jSs6hq5zYLqCXb/J5?=
 =?iso-8859-1?Q?bfxG94iCP+XbB70LeapUl2VrfgDEmMiAgo4EMfKqzKFlSyduyMq6IpAXTh?=
 =?iso-8859-1?Q?e7ar1JxeD9SyN6G8ytKxVFuqD+KqVgJ5PF1MlzRoEzX2i6/Wsuzx2Azu/W?=
 =?iso-8859-1?Q?AoPkHHgtuNtk9zOqjnSJPMzwDBhXKKbIXHmba4OtQz5mA0WtOIJtVuMpZx?=
 =?iso-8859-1?Q?CITSS6V2bE81isMMYWaOsTq7p/lTk70pZfQMz/P17h2nWKj/Q2u/3YD3VM?=
 =?iso-8859-1?Q?mc7eI0Yp2sRXxZEjojyjBx6G18b4yI/kaCHv+Hq8AZm0gc9I5S6/Y/p2Y2?=
 =?iso-8859-1?Q?+Fox6TfCqd7JivJxBNkTk7y0h2Fqt8TI0hIGrqoGc4s1xU0VD/CZyowqtX?=
 =?iso-8859-1?Q?khw8wgJYZX2ehrwe0zvzoOkz2aTefKVaHlR2tf9q/vVTLFhf3GQ2kwqkWG?=
 =?iso-8859-1?Q?REXN3X6BB8TTgtr6GL6J+avDeghEjFQij/4JASloWydWWK8FVBpCryc+Un?=
 =?iso-8859-1?Q?LLMbnjb5bTD/JZQISYINvg5IcY6KUje2MAWnpISgXXp6HUe4EpCPLofBE+?=
 =?iso-8859-1?Q?cOeJ9ml3Khn56s57T3FOVdGviUi3CrjYd7ek7vYlVDB7U2MqxyfNsgwbiY?=
 =?iso-8859-1?Q?w6FFnEEzmWAvwtCfQOsAoa3ufo9tro0Zidtv8YFzRT5XKcM7xeyaK4Et7/?=
 =?iso-8859-1?Q?ArSrjAFvcG9NnZMxivxTnd+74TwEV9X/1pvOWfnHyeuVRhB/GWUEIK9fn6?=
 =?iso-8859-1?Q?SNIP3GgFJeYNULnra6rqu5MjSYBTs5XtKykCUYESO4car/QAo46lfAAf2X?=
 =?iso-8859-1?Q?lYBcZUkCLCbGWbu8gxtIXGGKSXP2Qjhy3B9d/TO4IOB1kpLDXX2VMtkIiv?=
 =?iso-8859-1?Q?PA9VUkM+RNDln31Sa3TB60qKWjy1IyRjKxOzqSZbywUprIH0w2QDUC75au?=
 =?iso-8859-1?Q?NpBqiuKiest2+odERh40yMathdPQPU7aDq6OimZGRAeVAdjgeR7l/hYWCr?=
 =?iso-8859-1?Q?JtwpremsEMjXBdgwnVuN1DYd5GO1lMV1lswP7lLPoQFeaE6WvtIU0foMv6?=
 =?iso-8859-1?Q?YgjkIojpqAx21Yc36wCbYgHTsEF0YNX9neDXcLQhoJ1AFd4TPAy9BZ1vgM?=
 =?iso-8859-1?Q?oQfhyePpd0G51nT7kydvXF6gr/0jR4Q2Z1jxxjVFHxKh8CEBO8n4skpvOV?=
 =?iso-8859-1?Q?/M6CNfb9zA8PbReeV0F6Cst7fxVyiZySx4264YDFOLi/09V1i/U1TuIn5b?=
 =?iso-8859-1?Q?1w5DfbNo3jbgilC9nZGHIByIN7RNb99hIRWz4bKxb1O5zK3I9JySelNjkw?=
 =?iso-8859-1?Q?aPbl8ZJSKvTDDfH3qFSbkyApWXWQ/L5qfesZr7U61OKg/EJLLG/DZMORyO?=
 =?iso-8859-1?Q?r3uhDQ5keEl/5GFyVGezQQ8UktlGiKuuToVy19dlyJqLqc475evhoeCP1X?=
 =?iso-8859-1?Q?Q9JPGcmerfQ0C0YNl7pLzv98N0pJYlOUpGgbxBpKk6ADg09062+RPBU6bd?=
 =?iso-8859-1?Q?5fi5atEXXMSyAhmreztw/Lw/PIqARrjeLNl5t9nCsu7LxksjWSRbp8vQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 560b307a-5ad8-48e9-383c-08dcde39e883
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2854.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 14:45:47.8015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yd0apAgDwlofsMFEiB2syw0cXN5N/vRhQcE4Ok6zyp3nC+i9lsjUuzn1hmcYm0OHM2W94XpkwzcJA04mZwwQBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7641
X-OriginatorOrg: intel.com

On Wed, Sep 25, 2024 at 05:45:23PM +0300, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Stop spelling out each variant of the hook ("" vs. "_late" vs.
> "_early") and just say eg. "@thaw*" to indicate all of them.
> Avoids having to update the docs whenever we start/stop using
> one of the variants.

That or simply remove them all and refer only to the pm documentation?
"Entering Hibernation" of Documentation/driver-api/pm/devices.rst

> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: linux-pci@vger.kernel.org
> Cc: intel-gfx@lists.freedesktop.org
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/i915_driver.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> index 9d557ff8adf5..1e5abf72dfc4 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -1644,18 +1644,18 @@ const struct dev_pm_ops i915_pm_ops = {
>  
>  	/*
>  	 * S4 event handlers
> -	 * @freeze, @freeze_late    : called (1) before creating the
> -	 *                            hibernation image [PMSG_FREEZE] and
> -	 *                            (2) after rebooting, before restoring
> -	 *                            the image [PMSG_QUIESCE]
> -	 * @thaw, @thaw_early       : called (1) after creating the hibernation
> -	 *                            image, before writing it [PMSG_THAW]
> -	 *                            and (2) after failing to create or
> -	 *                            restore the image [PMSG_RECOVER]
> -	 * @poweroff, @poweroff_late: called after writing the hibernation
> -	 *                            image, before rebooting [PMSG_HIBERNATE]
> -	 * @restore, @restore_early : called after rebooting and restoring the
> -	 *                            hibernation image [PMSG_RESTORE]
> +	 * @freeze*   : called (1) before creating the
> +	 *              hibernation image [PMSG_FREEZE] and
> +	 *              (2) after rebooting, before restoring
> +	 *              the image [PMSG_QUIESCE]
> +	 * @thaw*     : called (1) after creating the hibernation
> +	 *              image, before writing it [PMSG_THAW]
> +	 *              and (2) after failing to create or
> +	 *              restore the image [PMSG_RECOVER]
> +	 * @poweroff* : called after writing the hibernation
> +	 *              image, before rebooting [PMSG_HIBERNATE]
> +	 * @restore*  : called after rebooting and restoring the
> +	 *              hibernation image [PMSG_RESTORE]
>  	 */
>  	.freeze = i915_pm_freeze,
>  	.freeze_late = i915_pm_freeze_late,
> -- 
> 2.44.2
> 


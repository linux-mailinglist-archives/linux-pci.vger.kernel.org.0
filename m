Return-Path: <linux-pci+bounces-9764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0520926CD3
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 02:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7625828430D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 00:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636604C92;
	Thu,  4 Jul 2024 00:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XrOXJq/U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4083D23AD;
	Thu,  4 Jul 2024 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720054726; cv=fail; b=nIV57RUcNc3nHZI9ZgbVbPPOx7su0gzsQ4Og5/IOWvnqaMvdFdYkHmFG118cvKNVtsET6YiHAauAicDGXcXTREXxwXhjc6PNX+hcyQdKh8yM0r/oOQdvCsi2b66KrluCqjV2Jn9MWSAgswkZi68cYqAYn3v9/VxKqXC70CyxvcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720054726; c=relaxed/simple;
	bh=YIGGgTLTCY75ZPEj/iL4eUQsFU2DKxVcFAMeIXyvqg0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IJJ2VR2Konz2kOI+NgIGzmBR04ayMARnfCgUAJcdhlyn+YtxJqx/oZF7DQ9LqNg0o9yLkKmr6liBTIuomY9527DNuHrvb4DLp5Fztpao5+sNbDa99ZdaRqlIiaWw3/FIb+omlOLQRqupHNQbgkqlaICOyWD1K6vG2r/wpE95sUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XrOXJq/U; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720054723; x=1751590723;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YIGGgTLTCY75ZPEj/iL4eUQsFU2DKxVcFAMeIXyvqg0=;
  b=XrOXJq/Uo33Tln1slHAVEmq6UJ4wZfd8C6UrTpLqLeLxchBlNXh2/43m
   yKjz3il2Gp49iDEgey+u36LDCbUyIfmEJKtgVI1WiZ9RB1g3Z6ZP4tUCj
   Mw7TNVRLzDjagWLCOjvUQUKP9LFCjjmHkA0H65RIumUNYY/qRhu3VeYLm
   Y5Djtt4ewUeDA7xRgazRerxaQUgycyaiPGUoFWB6Oksw+2okIN6jDp+M8
   0/kYKdGT7ZOmf/VwRWcnMUDkRN0p5gwBJpy0V5DQh2RKsvzUQuJJl/kJY
   EWyRhy26GY7329beBQBiyzE0I0EbE0U2bnumoVk1ZJHK73fHy3fUL8E10
   w==;
X-CSE-ConnectionGUID: zYsOsqqaQ4C8J7ryNTL/Cg==
X-CSE-MsgGUID: 3mXEfuuJSGiAjD+j/OuMwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="39830093"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="39830093"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 17:58:43 -0700
X-CSE-ConnectionGUID: EmB96yA2QM+vaXt4R0qyGA==
X-CSE-MsgGUID: oe5HyMz5QJ+iLdpfWp/LuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46573508"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 17:58:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 17:58:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 17:58:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 17:58:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 17:58:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O550ofdfXj7kub/pDlaoOw6i1nBTvlhKmEPop2ira0TThxZc6NxLRmRMJk3AhSjHMwIDbQ+OAg630561fYtsEA949pgXdUbd51xSda0rjpJiw5rvY0b9GqD2lI/dDbKs0UqT2VIm3K62HPEtKmbj0I9m1op4lbQq3ZxMdJeMYBBJuQuWTapp93TUVNBxHIsptHeqLE0tRuqx50iIz+hy6NUKbbhF7p8pS8hdFDjhPcTJGMYm/KxI4URiXq+DEXDhZE9eXWQVfHkJtY0e7tGSCOqzUEHoiJG6V5u4JOg8BzR3cbQBTVn7lIIDSlvefAKvqCyGemPfrhgqjkSUrkrffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qR7coR3hXUr2GklDqbeQCx+zsZlvJuX8MV+75u/M1v4=;
 b=IxEmmHD4f4+ZFgySVH68Zhepfy1qIvS8g+/Y8AxR1FvAQnEkeD7BiRzOaMs0/kRuoAPcjn+KpR5zZzicLBuDJy49n3CXo2OAECHQoo3sTGAbYuudmMEIK7EsCyQs1N97ShMOT9+H2Gwf0wr+KoMWWrThnbArm1DMQ2bNPC3TaiUHfClGq4QiTDKZqDPt7zMBN5sfcvVqUdDFxuKgLuoScZUlw0MSOl+fejpMQ1rzgaGXVnxUw+RO70DsqD/WjbY2FTAK+2bQstojkpYZuO6IWx41ZiIqO2DPCsBxwOjMKUYGitue+06Kqzzi1pIhqVEgurpMldUeoAZ5ofu11X9KDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB8198.namprd11.prod.outlook.com (2603:10b6:208:453::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Thu, 4 Jul
 2024 00:58:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7719.022; Thu, 4 Jul 2024
 00:58:37 +0000
Date: Wed, 3 Jul 2024 17:58:35 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v6 2/2] cxl: Calculate region bandwidth of targets with
 shared upstream link
Message-ID: <6685f3bb2be5a_4fe7f2942f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240701215020.3813275-1-dave.jiang@intel.com>
 <20240701215020.3813275-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240701215020.3813275-3-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:303:85::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e87a77c-498c-4c5f-2681-08dc9bc47014
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CXXJtDfY80TDN+Pj6MK3VpPVvENY6pPCtbaP8ZIxLfVbRvxojTT08dAOMOCs?=
 =?us-ascii?Q?3oK0kgGYWfIKZ0R60fLw99FHwpLI5yLE+J1N3Lps7J0UY92fd/xEigvolK+W?=
 =?us-ascii?Q?w+Ej/1YSx3yVKmBF/JNXafLdbS051SY/yXTcEp3ITFajdyA5IX3uoBd22KpG?=
 =?us-ascii?Q?hPXTJ5naCon3KBuzTuB9iYq4EPx8ym64G8aTcFKqybe4QMjf560SNR3APawr?=
 =?us-ascii?Q?5nL9VTl+JU3Ca+LZ/Bc8ABoakSPkcOb1RcyNgsCtZy5Zhkn0H/qypfnpGnig?=
 =?us-ascii?Q?40mPR8uqVmfsyozB4CY8O1a4YDErWMpIfJhZxGg2Q+6P32vEfm9pTO1i51iv?=
 =?us-ascii?Q?EM99pwEZu+u2AvzmA9u/AFj//MD73bVL4aC6+vanftT4FeF0QBD2ACjRhQmr?=
 =?us-ascii?Q?llr3Q4fF9z2iQqhYj+sBJ2mb1zaOOOECCEXXI49fmUSlCrsG6Q7ZOdGtQeak?=
 =?us-ascii?Q?+fbzqC81LFUum37HU11TEa9a4Fuow2bxESV16JP4/Ju+sCxNjoKU/OKMo3MV?=
 =?us-ascii?Q?Snc8AxTP0yeYyooX/RMzrGlRFK+Yh+um+QLsX92PphZjxZuzg3JV4jefHfaT?=
 =?us-ascii?Q?lIjrUTBB+gDm1EF8cjvWeE3++YzC7uGp06BL7I/JBnw8fGRkYo57PlTkYaqc?=
 =?us-ascii?Q?eAKrFRY+DZuCKYK80w5XNjczcE69bXEzTPbR5xvqR0sR/XvUDInkYhmchkFl?=
 =?us-ascii?Q?A0m545yH4uBdW9JaxivKGw0/N5tmZDFM4HKgv6hTYa1tKXxR+dCm6YipduWP?=
 =?us-ascii?Q?zp7ZEyLb5cxOUEnpGw+wQ87JUQfLTtYqHmZsHBt+/WC7OPFiEmsHv6lhSjUG?=
 =?us-ascii?Q?6ATJlE0GUIlKk5bg/lAffnknz6j8RN5Ro+2hh09v5zbZseDxQ46YvjTG5+3/?=
 =?us-ascii?Q?Y0eo+EQHQHUB27E1EkVD1MkV8mXkH5jPBgomv2MTRLUh6tjiUD96UaxtbIr+?=
 =?us-ascii?Q?42omqY2HlrDdyRRfddNLMVId7bJZY5W1Lrs/3ut/61Lc0of+T6vhK0Fk7TsZ?=
 =?us-ascii?Q?GC1SyMJ7QWEBedDjEw6NXX+y7FebFkjJDlL7y4MeaMdx2WZigGpn0KFAnVTV?=
 =?us-ascii?Q?YvFYdQ/+bUF2aME9eIGj+d3CO5r8k3N7EyC5AWdo/TGTZnLcIQ9CvZbLOpCg?=
 =?us-ascii?Q?9RE5EmeRlFjsR8hRdldTYx5uZRhRd7rI26tC4IQ3AK2tpkrmQALnr39dhJ4z?=
 =?us-ascii?Q?8Gh/pw2QBHdOt2adX+b1YxJBR58RFM7+wfu1SWeJFXddKmvqyD4mBkPeJNDf?=
 =?us-ascii?Q?o6MEhTYYWcD9X8V31YGqA23nxRxK5t6sSMHBe8Ayr/Ka0GI0/FACGnFh8GSj?=
 =?us-ascii?Q?9n4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iAFdExIz4jHbABTHX+bgsbjUQ+MgtPB+c+39z3nnUwRyJuuMa4+PoWwyb9Wd?=
 =?us-ascii?Q?nkVrWTq6i4yJW9DYkQpY5hRz1JX8oeCk7ygqryIWjSdm2wsSecv+7BKvwRCq?=
 =?us-ascii?Q?T/l85t7RGJJnKIhABxoJWf+YRBWU4h0qGeNss+bg4Xf8Of7BLVu5NRfOjIPN?=
 =?us-ascii?Q?/0RrSB874nelaPUTd0zE5ccjPxeiExp4sIkru/ZIAEfqR4POYubLebSaUlnk?=
 =?us-ascii?Q?yyxq40dgxZWM9yQtPzXgibANbr73ziKUN5hcioGS+iCCW95MQToyieQ27YaC?=
 =?us-ascii?Q?o9QPbWQXvamz9A0Qukgi/MvcpNOnytLOOMxzmLzGdcQclrFkXzKtV/YEAzqg?=
 =?us-ascii?Q?ENQmZJqVyVzQp2XDtSMrNUT8pUe3YCKdNEbBqt46RKXxJ8eWYTU8Pg8LELUu?=
 =?us-ascii?Q?AzF6dOtHnbSa4hRY8gUXICceT8FhzTsMaFJMVXfpSOsyTgA0Lx+3srgBlbKU?=
 =?us-ascii?Q?nJe903NE0L58CnGh1a2V/eg2c9cdynJBn7b4YnOxMrpmleXNj1wtR1+68CXF?=
 =?us-ascii?Q?1xLtkKbRCB9H7EYN5cg8pfQ+4SYDQadH9Jb7tfZSEzTjv6BR3RKjHOgbIUZ2?=
 =?us-ascii?Q?cmH4kah7TF0p5VEAOXc9/eUGbzQTAcFArhuRS81jRNHgWX7K+09JPTnDvkF7?=
 =?us-ascii?Q?eJZlnJgqAcsaFRpxwsj76urqqZDz3fbtP91+/WuelHqOauNexD1wtLj59Yaj?=
 =?us-ascii?Q?ubVxsBZQEL8fEI6UA4Bltz+Yvat059jViPi62JacRnVOUg9MU9vXNbrgatYO?=
 =?us-ascii?Q?K2iCCzEOj5vOYImXbh6p7KEi6LMjzQ30tgU396JX4omWODnb0ujkpu/nVOwv?=
 =?us-ascii?Q?dRLX1opapX3JlPxsTCCyN5jKSLz0NUVKWOgB9Z5D4gxhieFeAQXpHs/VvXe4?=
 =?us-ascii?Q?HiHWQLrvhRb9VO8aEap9PZt6tGU1Q8xZ6HNf3i+hqfS+4vGWDszJoQe8iT09?=
 =?us-ascii?Q?wRVEzXEfbnqTqb0NQBLRaHTiQP3GhtOvPfsn1tm9QdjP+/L5YKAFIl1l+G8P?=
 =?us-ascii?Q?ZhMJELrlpb28LUIw5A3HR1I8oJQ/2ey5ON0gt5bWSJH4A786IOLTVxIZccBZ?=
 =?us-ascii?Q?hZ91/5afs56FfaB6nZLS3hiCNuXaGpzmw0DSc2vIwKQN1MCcUljlhV4nri9R?=
 =?us-ascii?Q?/vISadb/7mSWqKV1W04mgfM9HAFX5WpcVV7G+VYqsFnYWH5ZppkHr0PZAuWk?=
 =?us-ascii?Q?iEkr1rcVsd7WuEXZmrfTP7PbYGEH9Uppcg+cd2z7qpUGrlJ0t3871KcB3+js?=
 =?us-ascii?Q?VxtAl7Y/OU/qXAedS1O++veWfNtIqfzLvHYkpzDSxXDxqoAbawCO/cRt90Ud?=
 =?us-ascii?Q?g1sEsVbHXuMtrH54w0S1j8e2RmEG+70cwuz1NXxiEZCIA+sg2KPo7eX58KjT?=
 =?us-ascii?Q?i+zktJutOYUB5T8BJPmxEE7se0eX/YeVwJ+eEDIXkAsyW6fYjgPDMAQQbwr/?=
 =?us-ascii?Q?4wJMpzqj64U8vn0g7moLWtM6xd+ZwHlFrLf+wsm9duzzb8xdSqvK+Cwn8KPn?=
 =?us-ascii?Q?bOazA+94t+Lp1pMjLl42ft5APUsKIOF8DVRizUdNBJhvDBEbxhqqcWdsfJrr?=
 =?us-ascii?Q?LrMEWZ365Eyi5cEPJQunYfeA02a2G2gzmoZW456fsbN1dsGbvyVU8oReiyXm?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e87a77c-498c-4c5f-2681-08dc9bc47014
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 00:58:37.7864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpZNpFSXwGfhj+W7C0epdJIH/5jSalSyFf0beuRMNzvZQd1QJw7UwYkC+aMNhT4Fp0vxOKljnELnVGI7yNQokTVintsVkQo7uWNPQDL2Tkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8198
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> The current bandwidth calculation aggregates all the targets. This simple
> method does not take into account where multiple targets sharing under
> a switch where the aggregated bandwidth can be less or greater than the
> upstream link of the switch.
> 
> To accurately account for the shared upstream uplink cases, a new update
> function is introduced by walking from the leaves to the root of the
> hierarchy and adjust the bandwidth in the process. This process is done
> when all the targets for a region are present but before the final values
> are send to the HMAT handling code cached access_coordinate targets.
> 
> The original perf calculation path was kept to calculate the latency
> performance data that does not require the shared link consideration.
> The shared upstream link calculation is done as a second pass when all
> the endpoints have arrived.

The complication of this algorithm really wants some Documentation for
regression testing it. Can you include some "how to test this" or how it
was tested notes?

> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Link: https://lore.kernel.org/linux-cxl/20240501152503.00002e60@Huawei.com/
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v6:
> - Various rearranging and cleanup of variable declarations. (Jonathan)
> ---
>  drivers/cxl/core/cdat.c   | 397 ++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/core/core.h   |   4 +-
>  drivers/cxl/core/pci.c    |  23 +++
>  drivers/cxl/core/port.c   |  20 ++
>  drivers/cxl/core/region.c |   4 +
>  drivers/cxl/cxl.h         |   1 +
>  6 files changed, 432 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index fea214340d4b..44e7d2e67aa0 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -548,32 +548,397 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  MODULE_IMPORT_NS(CXL);
>  
> -void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> -				    struct cxl_endpoint_decoder *cxled)
> +static void cxl_bandwidth_add(struct access_coordinate *coord,
> +			      struct access_coordinate *c1,
> +			      struct access_coordinate *c2)
>  {
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct range dpa = {
> -			.start = cxled->dpa_res->start,
> -			.end = cxled->dpa_res->end,
> -	};
> -	struct cxl_dpa_perf *perf;
> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> +		coord[i].read_bandwidth = c1[i].read_bandwidth +
> +					  c2[i].read_bandwidth;
> +		coord[i].write_bandwidth = c1[i].write_bandwidth +
> +					   c2[i].write_bandwidth;
> +	}
> +}
>  
> -	switch (cxlr->mode) {
> +struct cxl_perf_ctx {
> +	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> +	struct cxl_port *port;
> +};
> +
> +static struct cxl_dpa_perf *cxl_memdev_get_dpa_perf(struct cxl_memdev_state *mds,
> +						    enum cxl_decoder_mode mode)
> +{
> +	switch (mode) {
>  	case CXL_DECODER_RAM:
> -		perf = &mds->ram_perf;
> -		break;
> +		return &mds->ram_perf;
>  	case CXL_DECODER_PMEM:
> -		perf = &mds->pmem_perf;
> -		break;
> +		return &mds->pmem_perf;
>  	default:
> +		return ERR_PTR(-EINVAL);
> +	}
> +}
> +
> +static bool dpa_perf_contains(struct cxl_dpa_perf *perf,
> +			      struct resource *dpa_res)
> +{
> +	struct range dpa = {
> +		.start = dpa_res->start,
> +		.end = dpa_res->end,
> +	};
> +
> +	return range_contains(&perf->dpa_range, &dpa);
> +}
> +
> +static int cxl_endpoint_gather_coordinates(struct cxl_region *cxlr,
> +					   struct cxl_endpoint_decoder *cxled,
> +					   struct xarray *usp_xa)
> +{
> +	struct cxl_port *endpoint = to_cxl_port(cxled->cxld.dev.parent);
> +	struct cxl_port *parent_port = to_cxl_port(endpoint->dev.parent);
> +	struct cxl_port *gp_port = to_cxl_port(parent_port->dev.parent);
> +	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct cxl_perf_ctx *perf_ctx;
> +	struct cxl_dpa_perf *perf;
> +	unsigned long index;
> +	void *ptr;
> +	int rc;
> +
> +	if (cxlds->rcd)
> +		return -ENODEV;
> +
> +	perf = cxl_memdev_get_dpa_perf(to_cxl_memdev_state(cxlds), cxlr->mode);
> +	if (IS_ERR(perf))
> +		return PTR_ERR(perf);
> +
> +	if (!dpa_perf_contains(perf, cxled->dpa_res))
> +		return -EINVAL;

Shouldn't those be combined into a cxled_get_dpa_perf()?

I don't understand the standalone utility of cxl_memdev_get_dpa_perf().

> +
> +	/*
> +	 * The index for the xarray is the upstream port device of the upstream
> +	 * CXL switch.
> +	 */

That's evident from the code. I'd prefer more commentary on orienting
the reader on what is going on here at this point in the algorithm vs
just rewriting C statements in prose.

> +	index = (unsigned long)parent_port->uport_dev;
> +	perf_ctx = xa_load(usp_xa, index);
> +	if (!perf_ctx) {
> +		struct cxl_perf_ctx *c __free(kfree) =
> +			kzalloc(sizeof(*perf_ctx), GFP_KERNEL);
> +
> +		if (!c)
> +			return -ENOMEM;
> +		ptr = xa_store(usp_xa, index, c, GFP_KERNEL);
> +		if (xa_is_err(ptr))
> +			return xa_err(ptr);
> +		perf_ctx = no_free_ptr(c);
> +	}

...commentary like what is a 'perf_ctx'? And if every upstream port
needs one of these, is there a reason to not just add that storage to
'struct cxl_port'?

I think that's the main thing I am missing reading this patch is the
"why all the dynamic memory allocation?". I get that some of this is
dynamic and ephemeral, but I have the nagging feeling that not all of it
is.

Because you could imagine that at cxl_add_ep() time it simply updates
how much bandwidth can be pushed through that port relative to how many
endpoints have been attached so far (up until saturation). It feels like
this is walking the ports all over again vs incrementally updating as
endpoints register / unregister. That may be unavoidable or less desired
approach, but the lack of justification in the changelog for doing it
the way the patch chose to do it leaves me wanting more commentary.

> +
> +	/* Direct upstream link from EP bandwidth */
> +	rc = cxl_pci_get_bandwidth(pdev, pci_coord);
> +	if (rc < 0)
> +		return rc;
> +
> +	/*
> +	 * Min of upstream link bandwidth and Endpoint CDAT bandwidth from
> +	 * DSLBIS.
> +	 */
> +	cxl_coordinates_combine(ep_coord, pci_coord, perf->cdat_coord);
> +
> +	/*
> +	 * If grandparent port is root, then there's no switch involved and
> +	 * the endpoint is connected to a root port.
> +	 */
> +	if (!is_cxl_root(gp_port)) {
> +		/*
> +		 * Retrieve the switch SSLBIS for switch downstream port
> +		 * associated with the endpoint bandwidth.
> +		 */
> +		rc = cxl_port_get_switch_dport_bandwidth(endpoint, sw_coord);
> +		if (rc)
> +			return rc;
> +
> +		/*
> +		 * Min of the earlier coordinates with the switch SSLBIS
> +		 * bandwidth
> +		 */
> +		cxl_coordinates_combine(ep_coord, ep_coord, sw_coord);
> +	}
> +
> +	/*
> +	 * Aggregate the computed bandwidth with the current aggregated bandwidth
> +	 * of the endpoints with the same switch upstream port.
> +	 */
> +	cxl_bandwidth_add(perf_ctx->coord, perf_ctx->coord, ep_coord);
> +	perf_ctx->port = parent_port;
> +
> +	return 0;
> +}
> +
> +static struct xarray *cxl_switch_iterate_coordinates(struct xarray *input_xa,
> +						     bool *parent_is_root)

Naming is hard, but this name is not doing this complex function any
justice. 

It collates all the performance of all the upstream ports in @input_xa
and then stores all that in a new array representing the next level in
the hierarchy?

> +{
> +	struct xarray *res_xa __free(kfree) = kzalloc(sizeof(*res_xa), GFP_KERNEL);
> +	struct access_coordinate coords[ACCESS_COORDINATE_MAX];
> +	struct cxl_perf_ctx *ctx, *us_ctx;
> +	unsigned long index, us_index;
> +	void *ptr;
> +	int rc;
> +
> +	if (!res_xa)
> +		return ERR_PTR(-ENOMEM);
> +	xa_init(res_xa);
> +
> +	*parent_is_root = false;
> +	xa_for_each(input_xa, index, ctx) {
> +		struct device *dev = (struct device *)index;
> +		struct cxl_port *port = ctx->port;
> +		struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> +		struct cxl_dport *dport = port->parent_dport;
> +		struct cxl_port *gp_port;
> +		bool gp_is_root = false;
> +
> +		/*
> +		 * Create an xarray entry with the key of the upstream
> +		 * port of the upstream switch.
> +		 */

Here is another comment that is just reading the next lines of code out
loud without adding any helpful information.

> +		us_index = (unsigned long)parent_port->uport_dev;
> +		us_ctx = xa_load(res_xa, us_index);
> +		if (!us_ctx) {
> +			struct cxl_perf_ctx *n __free(kfree) =
> +				kzalloc(sizeof(*n), GFP_KERNEL);
> +
> +			if (!n)
> +				return ERR_PTR(-ENOMEM);
> +
> +			ptr = xa_store(res_xa, us_index, n, GFP_KERNEL);
> +			if (xa_is_err(ptr))
> +				return ERR_PTR(xa_err(ptr));
> +			us_ctx = no_free_ptr(n);
> +		}
> +
> +		if (is_cxl_root(parent_port)) {
> +			*parent_is_root = true;
> +		} else {
> +			gp_port = to_cxl_port(parent_port->dev.parent);
> +			gp_is_root = is_cxl_root(gp_port);
> +		}
> +		us_ctx->port = parent_port;
> +
> +		/*
> +		 * Take the min of the downstream aggregated bandwidth and the
> +		 * GP provided bandwidth if parent is CXL root.
> +		 */
> +		if (*parent_is_root) {
> +			cxl_coordinates_combine(us_ctx->coord, ctx->coord, dport->coord);
> +			continue;
> +		}
> +
> +		/* Below is the calculation for another switch upstream */
> +		if (!gp_is_root) {
> +			/*
> +			 * If the device isn't an upstream PCIe port, there's something
> +			 * wrong with the topology.
> +			 */
> +			if (!dev_is_pci(dev))
> +				return ERR_PTR(-EINVAL);
> +
> +			/* Retrieve the upstream link bandwidth */
> +			rc = cxl_pci_get_bandwidth(to_pci_dev(dev), coords);
> +			if (rc)
> +				return ERR_PTR(-ENXIO);
> +
> +			/*
> +			 * Take the min of downstream bandwidth and the upstream link
> +			 * bandwidth.
> +			 */
> +			cxl_coordinates_combine(coords, coords, ctx->coord);
> +
> +			/*
> +			 * Take the min of the calculated bandwdith and the upstream
> +			 * switch SSLBIS bandwidth.
> +			 */
> +			cxl_coordinates_combine(coords, coords, dport->coord);
> +
> +			/*
> +			 * Aggregate the calculated bandwidth common to an upstream
> +			 * switch.
> +			 */
> +			cxl_bandwidth_add(us_ctx->coord, us_ctx->coord, coords);
> +		} else {
> +			/*
> +			 * Aggregate the bandwidth common to an upstream switch.
> +			 */
> +			cxl_bandwidth_add(us_ctx->coord, us_ctx->coord,
> +					  ctx->coord);
> +		}
> +	}
> +
> +	return_ptr(res_xa);

Nit: At a minimum this is inconsistent with other parts of drivers/cxl/ that
use the "return no_free_ptr(x)" style. I prefer that as "return_ptr(x)"
is jarring syntax if not already familiar.

> +}
> +
> +static void cxl_region_update_access_coordinate(struct cxl_region *cxlr,
> +						struct xarray *input_xa)

Update what?

I think some minimal kernel-doc would keep easily distracted minds like
mine grounded.

> +{
> +	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> +	struct cxl_perf_ctx *ctx;
> +	unsigned long index;
> +
> +	memset(coord, 0, sizeof(coord));
> +	xa_for_each(input_xa, index, ctx)
> +		cxl_bandwidth_add(coord, coord, ctx->coord);
> +
> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> +		cxlr->coord[i].read_bandwidth = coord[i].read_bandwidth;
> +		cxlr->coord[i].write_bandwidth = coord[i].write_bandwidth;
> +	}
> +}
> +
> +static void free_perf_xa(struct xarray *xa)
> +{
> +	struct cxl_perf_ctx *ctx;
> +	unsigned long index;
> +
> +	if (!xa)
> +		return;
> +
> +	xa_for_each(xa, index, ctx)
> +		kfree(ctx);
> +	xa_destroy(xa);
> +	kfree(xa);
> +}
> +
> +/*
> + * cxl_region_shared_upstream_perf_update - Recalculate the access coordinates
> + * @cxl_region: the cxl region to recalculate
> + *
> + * For certain region construction with endpoints behind CXL switches,
> + * there is the possibility of the total bandwdith for all the endpoints
> + * behind a switch being less or more than the switch upstream link. The

The less case is not a worry, right? The old code handled that. So this
is only an algorithm for clamping bandwidth by switch capacity, right?

> + * algorithm assumes the configuration is a symmetric topology as that
> + * maximizes performance.

I think this needs to document what guarantees that this algorithm does
not become horribly confused by asymmetric configurations.

Like what prevents this code from ever seeing an asymmetric config, or
if it does what happens?

> + *
> + * There can be multiple switches under a RP. There can be multiple RPs under
> + * a HB.
> + *
> + * An example hierarchy:
> + *
> + *                 CFMWS 0
> + *                   |
> + *          _________|_________
> + *         |                   |
> + *     ACPI0017-0          ACPI0017-1
> + *  GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
> + *     |          |        |           |
> + *    RP0        RP1      RP2         RP3
> + *     |          |        |           |
> + *   SW 0       SW 1     SW 2        SW 3
> + *   |   |      |   |    |   |       |   |
> + *  EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
> + *
> + * Computation for the example hierarchy:
> + *
> + * Min (GP0 to CPU BW,
> + *      Min(SW 0 Upstream Link to RP0 BW,
> + *          Min(SW0SSLBIS for SW0DSP0 (EP0), EP0 DSLBIS, EP0 Upstream Link) +
> + *          Min(SW0SSLBIS for SW0DSP1 (EP1), EP1 DSLBIS, EP1 Upstream link)) +
> + *      Min(SW 1 Upstream Link to RP1 BW,
> + *          Min(SW1SSLBIS for SW1DSP0 (EP2), EP2 DSLBIS, EP2 Upstream Link) +
> + *          Min(SW1SSLBIS for SW1DSP1 (EP3), EP3 DSLBIS, EP3 Upstream link))) +
> + * Min (GP1 to CPU BW,
> + *      Min(SW 2 Upstream Link to RP2 BW,
> + *          Min(SW2SSLBIS for SW2DSP0 (EP4), EP4 DSLBIS, EP4 Upstream Link) +
> + *          Min(SW2SSLBIS for SW2DSP1 (EP5), EP5 DSLBIS, EP5 Upstream link)) +
> + *      Min(SW 3 Upstream Link to RP3 BW,
> + *          Min(SW3SSLBIS for SW3DSP0 (EP6), EP6 DSLBIS, EP6 Upstream Link) +
> + *          Min(SW3SSLBIS for SW3DSP1 (EP7), EP7 DSLBIS, EP7 Upstream link))))
> + */
> +void cxl_region_shared_upstream_perf_update(struct cxl_region *cxlr)
> +{
> +	struct xarray *usp_xa, *iter_xa, *working_xa;
> +	bool is_root;
> +	int rc;
> +
> +	lockdep_assert_held(&cxl_dpa_rwsem);
> +
> +	usp_xa = kzalloc(sizeof(*usp_xa), GFP_KERNEL);

Maybe a DEFINE_FREE(free_perf_xa) to avoid a goto below?

> +	if (!usp_xa)
>  		return;
> +
> +	xa_init(usp_xa);
> +
> +	/*
> +	 * Collect aggregated endpoint bandwidth and store the bandwidth in
> +	 * an xarray indexed by the upstream port of the switch or RP. The
> +	 * bandwidth is aggregated per switch. Each endpoint consists of the
> +	 * minimum of bandwidth from DSLBIS from the endpoint CDAT, the endpoint
> +	 * upstream link bandwidth, and the bandwidth from the SSLBIS of the
> +	 * switch CDAT for the switch upstream port to the downstream port that's
> +	 * associated with the endpoint. If the device is directly connected to
> +	 * a RP, then no SSLBIS is involved.
> +	 */
> +	for (int i = 0; i < cxlr->params.nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = cxlr->params.targets[i];
> +
> +		rc = cxl_endpoint_gather_coordinates(cxlr, cxled, usp_xa);
> +		if (rc) {
> +			free_perf_xa(usp_xa);
> +			return;
> +		}
>  	}
>  
> +	iter_xa = usp_xa;
> +	usp_xa = NULL;
> +	/*
> +	 * Iterate through the components in the xarray and aggregate any
> +	 * component that share the same upstream link from the switch.
> +	 * The iteration takes consideration of multi-level switch
> +	 * hierarchy.
> +	 *
> +	 * When cxl_switch_iterate_coordinates() detect the grandparent
> +	 * upstream is a cxl root, it aggregates the bandwidth under
> +	 * the host bridge. A RP does not have SSLBIS nor does it have
> +	 * upstream PCIe link.
> +	 *
> +	 * When cxl_switch_iterate_coordinates() detect the parent upstream
> +	 * is a cxl root, it takes the min() of the aggregated RP perfs and
> +	 * the bandwidth from the Generic Port (GP). 'is_root' is set at this
> +	 * point as well.
> +	 */

This comment probably belongs as a kernel-doc for
cxl_switch_iterate_coordinates() rather than an in inline comment. Save
the inline comments for tricky logic that can not get its own
kernel-doc annotation.

> +	do {
> +		working_xa = cxl_switch_iterate_coordinates(iter_xa, &is_root);
> +		if (IS_ERR(working_xa))
> +			goto out;
> +		free_perf_xa(iter_xa);
> +		iter_xa = working_xa;
> +	} while (!is_root);
> +
> +	/*
> +	 * Aggregate the bandwidths in the xarray (for all the HBs) and update
> +	 * the region bandwidths with the newly calculated bandwidths.
> +	 */
> +	cxl_region_update_access_coordinate(cxlr, iter_xa);
> +
> +out:
> +	free_perf_xa(iter_xa);
> +}
> +
> +void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> +				    struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_dpa_perf *perf;
> +
> +	perf = cxl_memdev_get_dpa_perf(mds, cxlr->mode);
> +	if (IS_ERR(perf))
> +		return;
> +
>  	lockdep_assert_held(&cxl_dpa_rwsem);
>  
> -	if (!range_contains(&perf->dpa_range, &dpa))
> +	if (!dpa_perf_contains(perf, cxled->dpa_res))
>  		return;
>  
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 625394486459..c72a7b9f5e21 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -103,9 +103,11 @@ enum cxl_poison_trace_type {
>  };
>  
>  long cxl_pci_get_latency(struct pci_dev *pdev);
> -
> +int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
>  int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
>  				       enum access_coordinate_class access);
>  bool cxl_need_node_perf_attrs_update(int nid);
> +int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
> +					struct access_coordinate *c);
>  
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 8567dd11eaac..23b3d59c470d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1074,3 +1074,26 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>  				     __cxl_endpoint_decoder_reset_detected);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
> +
> +int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
> +{
> +	int speed, bw;
> +	u16 lnksta;
> +	u32 width;
> +
> +	speed = pcie_link_speed_mbps(pdev);
> +	if (speed < 0)
> +		return speed;
> +	speed /= BITS_PER_BYTE;
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
> +	bw = speed * width;
> +
> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> +		c[i].read_bandwidth = bw;
> +		c[i].write_bandwidth = bw;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 887ed6e358fb..054b0db87f6d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2259,6 +2259,26 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_get_perf_coordinates, CXL);
>  
> +int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
> +					struct access_coordinate *c)
> +{
> +	struct cxl_dport *dport = port->parent_dport;
> +
> +	/* Check this port is connected to a switch DSP and not an RP */
> +	if (parent_port_is_cxl_root(to_cxl_port(port->dev.parent)))
> +		return -ENODEV;
> +
> +	if (!coordinates_valid(dport->coord))
> +		return -EINVAL;
> +
> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> +		c[i].read_bandwidth = dport->coord[i].read_bandwidth;
> +		c[i].write_bandwidth = dport->coord[i].write_bandwidth;
> +	}
> +
> +	return 0;
> +}
> +
>  /* for user tooling to ensure port disable work has completed */
>  static ssize_t flush_store(const struct bus_type *bus, const char *buf, size_t count)
>  {
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3c2b6144be23..e8b8635ae8ce 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3281,6 +3281,10 @@ static int cxl_region_probe(struct device *dev)
>  		goto out;
>  	}
>  
> +	down_read(&cxl_dpa_rwsem);
> +	cxl_region_shared_upstream_perf_update(cxlr);
> +	up_read(&cxl_dpa_rwsem);
> +

It feels odd that this is taking the cxl_dpa_rwsem this late in the
process. By the time the region is committed it's too late to be racing
against decoder DPA changes. Even committed is too late as the target
list is finalized an CXL_CONFIG_ACTIVE time. So this feels like
something that should be finalized when the region transitions to
CXL_CONFIG_ACTIVE after cxl_region_setup_targets(), not region probe.

>  	/*
>  	 * From this point on any path that changes the region's state away from
>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 603c0120cff8..34e83a6c55a1 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -891,6 +891,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  				      struct access_coordinate *coord);
>  void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  				    struct cxl_endpoint_decoder *cxled);
> +void cxl_region_shared_upstream_perf_update(struct cxl_region *cxlr);
>  
>  void cxl_memdev_update_perf(struct cxl_memdev *cxlmd);
>  
> -- 
> 2.45.1
> 




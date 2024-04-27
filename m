Return-Path: <linux-pci+bounces-6746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E61E08B48D8
	for <lists+linux-pci@lfdr.de>; Sun, 28 Apr 2024 00:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37ECB211E5
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 22:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A533B1AE;
	Sat, 27 Apr 2024 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWO1w9lB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6485F611B;
	Sat, 27 Apr 2024 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714257571; cv=fail; b=rlS5OP5QkfPmZLJe0Cm8luK/clfxbLBNHVWER9StWPgxYSNDNffboNYwDwgDC9fe8A6OF5oSjG3dA3tRcisKbES9OmRirGfMb7xCN5R9huNS5Nlr6Vwq7ZRrFuQjjIPRzK6Vgk3CDmarWZeB6Ed0rFbggtlCWUlAA4DZHNimtzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714257571; c=relaxed/simple;
	bh=GxnOTbUrjNUldtA3gcgohgdKAzRAM2QfjWt7OGybWEs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rng8df0GnQ00h8raS0rQKhkKV6NOM+pHYPX9FGC2Od82eSKudCSm/oq1xxbMbIOzTEyj8nAaDWfIVRrHyITehF+V9l5VmohaqtphWWLf7gC0bQcH0wuMR+pl+eRqPzBzif84QSigFkjbH3bjzMjo0gm1lZkauRVKmiYiY0pO8I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWO1w9lB; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714257568; x=1745793568;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GxnOTbUrjNUldtA3gcgohgdKAzRAM2QfjWt7OGybWEs=;
  b=BWO1w9lBieiivoOcg0q2h8Sytc8c+gABB1w9HE2GWeetGB+N0SU65Byi
   8UQBmDSEifo4uJVfg9i7k6fwOIj4OrjvnBREtmbMgGbETB4rTLPpBeLTp
   lYhyvQK3288eF0imV7bI6fUs/fKXOSbG0CUy52+fEAn+H5yJlZQcG5axv
   w52wqLaq6jSI8sEhsMywMXebeZ7yW19nollIpZAnFIWlDxwCZprIzZp+P
   jEiwegINhwSoEUqC6oW+f4+6DNQplcH+mh8h6RiLbVawXmwCkqdn7GzdE
   YEOxQshj2Xwkf11AB+oVVhEb/OfqFEjZ/xhv0LobjFOs/4NXnP8t2UQgG
   w==;
X-CSE-ConnectionGUID: K0Q1j3s1RMKmx/F7/o6I9Q==
X-CSE-MsgGUID: dzp+r8gKQ8yDAOmj7cYXlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="27479884"
X-IronPort-AV: E=Sophos;i="6.07,236,1708416000"; 
   d="scan'208";a="27479884"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 15:39:27 -0700
X-CSE-ConnectionGUID: M862POicRtyKIcTAmh5Wcg==
X-CSE-MsgGUID: J7oQyf0iRdeaPcrlw8Fcyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,236,1708416000"; 
   d="scan'208";a="25735324"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Apr 2024 15:39:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Apr 2024 15:39:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 27 Apr 2024 15:39:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 27 Apr 2024 15:39:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8z9XIRsTnzpNYLbWuzq5JWamnMSBHhmHddYeQUtgxoUHi2cFIujwhDeiGpSvoPeJr0o9Ii/ewpfdk5KqhEqbh9gM2zUBUgefbTsW7xO8quAoXT0eYGqVuCPOw6M6Z87eSuJAisG1qEDsXn54+NVNQuV6bR4bHUD7whmeTaO/hi/W3lEhsDgCXf15ALMLgd/fEHchV1PGIofcxVij5V3eLQ+FyoaX7toQEQfWZqX7NgHa5S14jcCWlVZclIfiqmjsOA4qZbmMb8kZ4MuO6qzNc75uzhoX8ir2fMw8FFQ88yS9pKJQl1N6uVFFt5I2Y8IXQQH8Jq32ojbEKMWViIT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIncS6SYxUf6OZoGzGG18ULH0rSN5SPAyoK1YZcOhUM=;
 b=mtqOApavDhtng6wTFVqoTCJ0wD8kiVqbw6F18hFvpRWN4mz4BOuzGrIN2PQU+xqwqTdiVbi5iP2Fdces9dhIn3GkZxJVxIAGokHY/Bc40vp2JYvsugCRq2ZmMbhVEpA+OmUvxskoq5e/R979TCNiHbvKPBBI7Tmx9txnYSEFMA75sb0s/0r30B8GMnRuSj5YEbLREZ9pomfMi9ZvMVUCJtkOuqymnG1KijNA44GYIkpkhl1w25eaOAp4UB6+viN6lox+ImtkiR93JOpRq6n8JBdpE1Km/1cD/nvhQeBN8HjPRuGJf3WLGSScXNauZ2gTVT0+zRRCjaGCPWHMKzzEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5019.namprd11.prod.outlook.com (2603:10b6:806:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sat, 27 Apr
 2024 22:39:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Sat, 27 Apr 2024
 22:39:25 +0000
Date: Sat, 27 Apr 2024 15:39:22 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>
CC: <gregkh@linuxfoundation.org>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Marc Herbert
	<marc.herbert@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 1/3] sysfs: Fix crash on empty group attributes array
Message-ID: <662d7e9a6d437_b6e029440@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
 <170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com>
 <ZiYrzzk9Me1aksmE@wunner.de>
 <662beb6ad280f_db82d29458@dwillia2-xfh.jf.intel.com.notmuch>
 <Ziv9984CJeQ4muZy@wunner.de>
 <662d2ca522cc6_b6e02942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zi1qtKNwcyydP4c2@wunner.de>
 <662d6f24528d7_b6e0294d2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <662d6f24528d7_b6e0294d2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: MW3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:303:2b::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: 296c6d25-ec90-42c2-dbf2-08dc670ae3c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kzdtnrO5JMYCDcUkOkGpd4gFv/Nx/RKhVfOxmuHcPORL5ssLRL9fOYscnKNe?=
 =?us-ascii?Q?CvzG+mf8Jjyn9K5m/WAmwkpfuvU6UapOm+RpX84x8Mea2bVJTmB6XBdpssy1?=
 =?us-ascii?Q?feiaFWITcy7T7PWPFtcHL40HN+uzeCsB+4fGGbi61n+3s/s43UboL3CuJV+F?=
 =?us-ascii?Q?Df/u2jW+FUM7yc8e/tNoH3IFwHY/M6I/+b2i57DcH4gj4EnoVbCwjkFB+oMo?=
 =?us-ascii?Q?By9zLqmgCPEqb9ARMVsU1tIDcjtRKeHh/hZp0Sbe8vmjTDO07XQNY/zKlpF3?=
 =?us-ascii?Q?IXTMNJqU9w/lArODv5cuc7Q0eqNUaOJbekF5bbjr5q+OQ1vov+Swf1blo/VP?=
 =?us-ascii?Q?ERyxfmIfeV80ynMfl5jrq0fQNCNde4aRv29z7x9daEiw99wJbOcayMZpWEhW?=
 =?us-ascii?Q?lucPoFE6CcjFeVWRgt4hv/FeN1XNgMtQLRjJbH+Cycq3hWqSXaZBiEZiX4F7?=
 =?us-ascii?Q?3AN/EA+r++fZImNExf6zAy2q/sS7LI9fP4h3C365NjoZq6m1nA2d7tvrfNRe?=
 =?us-ascii?Q?rF5i8KfTJf1f5kqLxj+a5r7hpExGu/ePWM9syyK+LKw0hH7yabpUkQ05ZBnK?=
 =?us-ascii?Q?0OMcGdIChAS88GQkf7rwI1U1Bahnqx4rhrkoGSjdD3Q2y99R8sCLFPrBdeVn?=
 =?us-ascii?Q?tTFnfRKmC/+5NWjuGK5sM5HMbE5D0xxrLbV6jrsWMpHMMQ4lPxGuWJ7MW7oM?=
 =?us-ascii?Q?A0Q7iLaGNrWgnGxkuEowZBTYc3/yxZmMCAF9SJShohmL/b2vk2x93LBzgCBq?=
 =?us-ascii?Q?7cPPXgfXkncRD+won/GeFa90KCa5uRh2PZ7baqY0VgOzbvseDzgsf47vkKZx?=
 =?us-ascii?Q?IVlRA87FZcA5q+VdHvuGJHmfX3mY8Z4yFOjo7IYRibl8bFqp6LKbhJRrhlk2?=
 =?us-ascii?Q?zrnSD694pbG6kOIFXx+ozS8pLEFLGPwQWItIgQQSJ+KbHgjRPSnaPQXXVePE?=
 =?us-ascii?Q?KptRjNFbrWSnZMuQdEk1FUlJudZBHr6rZupK3UnZVdgdo1UIUTns4fd07Rzc?=
 =?us-ascii?Q?936kG7zSc/zVjllfoWupy3cijtg7bNpleAP86Yz8eMERlV+6IHvsWrXqggp9?=
 =?us-ascii?Q?iotDO58sGzYzIqYxsR4iOxfXHsRmu69MLla1O6jEXCU6lPiG/oYdolNBJ58a?=
 =?us-ascii?Q?y/5ocRMrS3j7HI1Kb6f1SU2DHLTpmGbrIedumASWY8d5gDfr77ydUHcPkfuD?=
 =?us-ascii?Q?E8a4fkW8QYtk9EssiThmtvNEOaMfj/XlsBQ9LgHU8FtesJH3b4TYPtx1m/oQ?=
 =?us-ascii?Q?2KS+4yn7bFyQtWmdhXHqE9SgcJNP1NNXsDm9NFztbA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rxc5+Ja7aYtRZbOnnAlxG/qr/z7rxKNeLv7YkjmIQJ6wH64NZ4gCRuV3GTvv?=
 =?us-ascii?Q?2WeNCuH03ceExiTtzTNj1TFOB+x6F+qVusIx/C1v3Defz/Mmp+g/ULRAXcj8?=
 =?us-ascii?Q?LiDUr5xLRu2Cgozk8xJUClEQx7FlE+fm+pNfHG2tsX7YR489/bjxraQiy32I?=
 =?us-ascii?Q?oF4vB0cmwmmFhbYzi71Vi/3Y55VHtZC8IiTN8wdjBSPUkdWqYdNMNKd6ql2f?=
 =?us-ascii?Q?R4cVi4tiS/C4DhO1Qj/hxaan2dJeZp8fZdWVhITSH8SRcnuDqmWajXKY44qA?=
 =?us-ascii?Q?kLLW8Lstr+Eh4SdpSBsENbFZSpOSj9y9IZGQvYYBn160qufq7MWfMd67hMRf?=
 =?us-ascii?Q?LJs/6UtFrpTBIxkXI8n8mFIwOAiZrI3oT7B7X4RgGNTeJE4JQbOoRPGTP6OS?=
 =?us-ascii?Q?3IAzo2IeXhj5fH0EvA+By+dugwSiQl+mf1iBQqOr0LeDSdwKiHzq3tRodret?=
 =?us-ascii?Q?bnBiDtrr2lKgURaacDmQncdBaRhR/4gcsjKD+VCF8l4Th6YDfDPivDU455wO?=
 =?us-ascii?Q?3eQxPSZLOCh8334++49G8/RvW3UeUu7c+iJcX0r21rWjs1YtqsRVpMs2swWi?=
 =?us-ascii?Q?aCOTmJkL+OGRembyDpuMBmJpRRVqf/vS1MYwzXqrInhFWcMADGJ20RqkCMzr?=
 =?us-ascii?Q?v3neMJPeNBAzZYL0jENVp4l1LNpwDlDLiGnQpguenqX8CFwKBnWM4UH74uzE?=
 =?us-ascii?Q?aOw6Deq6/uC3jPrNsOgD9pDMHxihyNjF+AK5BwOFdk18V3T2rCEfaFvGwZAM?=
 =?us-ascii?Q?tWz8BRRf8fhZSnfLM4tv6xbB1rvmWlN0Lzm+p3SfrUjg4wiW2rjHkgE1MRIe?=
 =?us-ascii?Q?Ej2rKO7/NY2xnAg4ICiH5WQt947G05rZJwg9WV8LHz0uF1tf4oYPKT10RVFe?=
 =?us-ascii?Q?8VdpFvqv1BpxRb9f+y0Ppn/d2fKNxrXTyftb/GgRPUX5qg0kmTHATP/VLMzH?=
 =?us-ascii?Q?WJpiC0cJcidWxEhg8084IVUXFluSIbZ7nDRcDAVQ/WzZA3Ao9ft0fQG0cas/?=
 =?us-ascii?Q?MjK8AQwblj72/GO1Rl8pqqK8FKaajngxf332drpr9oSre2foVqvWMq44WD5i?=
 =?us-ascii?Q?lto6keOJqeccDp6XGzZva74glEfxmeKHxWmPnU1a4pJ3OkJ2oL+Wq6ftIsnC?=
 =?us-ascii?Q?bXT0sI9bvPnEFc0H929FsJCshyDInGeDZIDb6aNaCLxJ8ayTEnfAZmHLcbHm?=
 =?us-ascii?Q?92M2ndRhy1sWzlqMigYeof+xVNMjyxC+pD+8U8HfDyvz+2VtSoQOGQjcSOiH?=
 =?us-ascii?Q?1JzjFN40tDCMHAzs0YcwXKlP2Fy8YnUa98YrdJsGBTYshTg6NjWpZZGQ5aYz?=
 =?us-ascii?Q?CEInJZ01l9bDDzSiXRmLLfP90atpuqbkI/ooQwKg4tGaPnhkA5thghlG7kN4?=
 =?us-ascii?Q?Gf9gbGAO0VY7iFsaGoviJ64OriCg6xrCuXVRzdlQCzE2QYtpCPumbldsa3Z2?=
 =?us-ascii?Q?nSin2T/8uIKo24upFwsz3+rccVBhL4Wf3qnpnZ7ZaR0BDnGDMCFSRCxBi2Uf?=
 =?us-ascii?Q?0qt530tQkEd6ycV7f9vaWqL/0P0LRob1Y5YfejBJk+GEEfDqHE+Dd0JtAPeQ?=
 =?us-ascii?Q?KGd9DQWIThG9OwqimaI/d3J250tqrF2uO+Tvfs1rGSuhNXse62DU+8kFVl3O?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 296c6d25-ec90-42c2-dbf2-08dc670ae3c8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 22:39:24.9813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qbpFnzOuSbVZrZmnFmhPIAjlzTdYueqxZp9N274w76jesaRYSjTo7NFTKxHiNO6uO+g81b+FOvjLAIUv7P0DeruFP5dgMlhhPfm/ZMveWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5019
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Lukas Wunner wrote:
> > On Sat, Apr 27, 2024 at 09:49:41AM -0700, Dan Williams wrote:
> > > Lukas Wunner wrote:
> > > > But I want to raise awareness that the inability to hide
> > > > empty attribute groups feels awkward.
> > > 
> > > That is fair, it was definitely some gymnastics to only change user
> > > visible behavior for new "invisible aware" attribute groups that opt-in
> > > while leaving all the legacy cases alone.
> > > 
> > > The concern is knowing when it is ok to call an is_visible() callback
> > > with a NULL @attr argument, or knowing when an empty array actually
> > > means "hide the group directory".
> > > 
> > > We could add a sentinel value to indicate "I am an empty attribute list
> > > *AND* I want my directory hidden by default". However, that's almost
> > > identical to requiring a placeholder attribute in the list just to make
> > > __first_visible() happy.
> > > 
> > > Other ideas?
> > 
> > Perhaps an optional ->is_group_visible() callback in struct attribute_group
> > which gets passed only the struct kobject pointer?
> > 
> > At least for PCI device authentication, that would be sufficient.
> > I could get from the kobject to the corresponding struct device,
> > then determine whether the device supports authentication or not.
> > 
> > Because it's a new, optional callback, there should be no compatibility
> > issues.  The SYSFS_GROUP_INVISIBLE return code from the ->is_visible()
> > call for individual attributes would not be needed then, at least in my
> > use case.
> 
> That's where I started with this, but decided it was overkill to
> increase the size of that data structure globally for a small number of
> use cases.

Perhaps could try something like this:

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index d22ad67a0f32..f4054cf08e58 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -33,11 +33,23 @@ static void remove_files(struct kernfs_node *parent,
 
 static umode_t __first_visible(const struct attribute_group *grp, struct kobject *kobj)
 {
-       if (grp->attrs && grp->attrs[0] && grp->is_visible)
-               return grp->is_visible(kobj, grp->attrs[0], 0);
+       if (grp->attrs && grp->is_visible) {
+               struct attribute *attr = grp->attrs[0];
+               struct attribute empty_attr = { 0 };
 
-       if (grp->bin_attrs && grp->bin_attrs[0] && grp->is_bin_visible)
-               return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);
+               if (!attr)
+                       attr = &empty_attr;
+               return grp->is_visible(kobj, attr, 0);
+       }
+
+       if (grp->bin_attrs && grp->is_bin_visible) {
+               struct bin_attribute *bin_attr = grp->bin_attrs[0];
+               struct bin_attribute empty_bin_attr = { 0 };
+
+               if (!bin_attr)
+                       bin_attr = &empty_bin_attr;
+               return grp->is_bin_visible(kobj, bin_attr, 0);
+       }
 
        return 0;
 }

...because it is highly likely that existing is_visible() callers will
return @attr->mode when they do not recognize the attribute. But this
could lead to some subtle bugs if something only checks the attribute
index value. For example:

lbr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
{
        /* branches */
        if (i == 0)
                return x86_pmu.lbr_nr ? attr->mode : 0;

        return (x86_pmu.flags & PMU_FL_BR_CNTR) ? attr->mode : 0;
}

...but in this case we get lucky because it would return attr->mode
which is 0.


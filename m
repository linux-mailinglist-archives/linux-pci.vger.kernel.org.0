Return-Path: <linux-pci+bounces-21527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3716EA3678D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 22:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A79D18972A9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859BA1DDA0C;
	Fri, 14 Feb 2025 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGpzkRs0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E21FBEB0;
	Fri, 14 Feb 2025 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568551; cv=fail; b=dvv0AapPhH6RyB6503h18wRY4VS0fqdbq3cYkFl2NEgG/Kl4WrVtMHDeEMaoGvvzzmzAo4pQUV4gQuW7oDCZ0phtzeeZ4DAPSe4UHdSCzs2jhNDc/5Ci3TzRg/dZdTsEdfqoyvyLIPDpKs+Ag90TtbGjATV6fBHv3mmt+cYGrfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568551; c=relaxed/simple;
	bh=w4luRuvPZqh8wi2jjo3zaOGQGDt0laAb1eHjnLFZZ3I=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RMorFXhsM0A983Fdu0H+akKv8nY7z2JzErt7tjDDNsqszouDbcnIDNNWfM9FWG7EeG2bOLwb5wuPDXEnNrytUIOGWq6WVq0hsoqiVjS8TnY9qRR0hnscTHDiOLFHJgvsfyvhEgdLNq0OK/eNrgOgk62NbIXFLvIBuGOv2icYRkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGpzkRs0; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739568550; x=1771104550;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=w4luRuvPZqh8wi2jjo3zaOGQGDt0laAb1eHjnLFZZ3I=;
  b=ZGpzkRs0XCXsBf0P54KOY4C4tCRsXnkHh3J9GW0U1Gi0iTnA3iJi5y3A
   2Bs8ee+B/3iCE6DGtSagpN/V5Q3Hqs0u84Fb5ZktmaAuuzDw/FlY9J4PL
   Tr+tctNWCSO/3OXUhoaWcTL3J+Es/PMSkHzrKtYjPMTk1iWDNCBgMPGIs
   batUjXvpEmgC7UJdU9saEgbQRtk2nKCNBR1YcwCm0g3e8ns67dIxDhgEO
   NBFxhqiu768DajDaNZrvDpKZjV1YWVAG1j2odJQ0ITF8MNQBiQHShqiH6
   voCNpIw0Ks4NMXJleEk18yIPoNWxK4736qwcQfDFcCG00Nmv3BM8dx8x/
   w==;
X-CSE-ConnectionGUID: 5eqRcDFdRDmVhOHB411GEg==
X-CSE-MsgGUID: MEkORI+wQv60nCTFvi0UQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40455370"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="40455370"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 13:29:09 -0800
X-CSE-ConnectionGUID: Q16NPUpISJq8KnOiex6rFg==
X-CSE-MsgGUID: x5rT1EQ6S2S7NgdREJAjbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136788945"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 13:29:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 13:29:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 13:29:07 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 13:29:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LC0tZKRO/eXbiwFebrHl3k0iDWiUbd3YHx3DTXbu/Q1PGeXa/+eHJaonuhAmjOO/fXfLucW0XwHPcToPFxAQ6M+reobzHoyesGCKhWCnZJ4rgXwQ/hPGrbL41TAAFDUr6b6/sp7W/+5EHAYNsJ6dMQZyMKlLNUZsf9Zat2tLBXTP6FqZGV94eXLKTL1lT+3xHE9vnFOCU8v1hVwv7zL481laRHL9Fp0KNAZnQCVjZlSlfMYsOG+fM5nxOOaI/oD5eNiX6EMNB9jROxlRMqkBDu/tPSpJJ8mv+VYUzKVRe0ChPh+WmRzoLLrUTXq2qFZbKOqWz/lfInaexBo9Zp6Thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgnmH5StICUvFECQJT0YamosG24WhoMwslaYK137Iis=;
 b=woByw9w+uBtN8Gkd0rex4/Wmg29xJNokMGkrU3wL1cDzIz3iBbvltUx2qJ1cnElUvWEZ9cBSD8zQD9JC5uIiupzf+dR37GJwrCsgU8X3cEiYMIJ9uQVQYx4nKsOPaoP6fRngaBYH3SavbEm9aAFLGMHTUjbKyt/sv/99bVfavlAJ+Bw5auJIzoLmtXsEZMSZoqtL44joYvW/mNx8TyceDTA1ZbsmrokOqXK82++cd6zaXZ2W89vAoMkYiuLbMprLD9fsivgHxkWbJjeeByVcBBpMxaRjjnYAMlTCJiWin+a8j53GuSJmqEd9GV9TlLOGVqLoqBdPBpbAmqynijYKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYYPR11MB8306.namprd11.prod.outlook.com (2603:10b6:930:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 21:29:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 21:29:04 +0000
Date: Fri, 14 Feb 2025 13:29:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 08/17] cxl/pci: Map CXL PCIe Upstream Switch Port RAS
 registers
Message-ID: <67afb59d6d2df_2d2c2944f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-9-terry.bowman@amd.com>
 <67ac00b78e492_2d1e29486@dwillia2-xfh.jf.intel.com.notmuch>
 <9f2531dd-6ee3-4e71-9b29-4cdf9da410a6@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9f2531dd-6ee3-4e71-9b29-4cdf9da410a6@amd.com>
X-ClientProxiedBy: MW4PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:303:86::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYYPR11MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: f840bda5-c35e-4733-d7fd-08dd4d3e9b57
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PMJTqw3YcH3DPJYsaHUY4oROrSioIdmwwjauy+Qpn4/cIWUiKoCzT3INXH5o?=
 =?us-ascii?Q?A4duUVVFx4Mt80jRLPI62mznFgc/J3y23ur9rx5EP9XD6DXgjU+iuDyFxJhJ?=
 =?us-ascii?Q?bQ9caO7T/IZDZjPYgV2clqPmpxvXlNIuYphTWyQpN0pS6RSTGj4GcrFMUECw?=
 =?us-ascii?Q?jyzeRu7PlnfUumjHBV/gevMXqMjo/gWZEO6R0wbYRCWguxJl4H12bIGRlzGq?=
 =?us-ascii?Q?JXYhAx7X4vHlPoSyXVDWtgGHD05acotfX73+UxjVUxj4WLYl2ugS2uIYbNM7?=
 =?us-ascii?Q?7d9j8EVo0MNwElFkNx3SQfxrKl4b6ObEv1eb/iPMytlnp5ZffpAh/v+jKejo?=
 =?us-ascii?Q?EoSSb6MM71m7wns4pohVCIrc9taUwAtnSTKkHgfZwISON0hnxj4/Xw4nDMJD?=
 =?us-ascii?Q?74Wp2W7QCTxkFbLQ0Tij4WO0Ql62RE3thkUxG3zgPDImR7zNC0nUGtac09nU?=
 =?us-ascii?Q?OWpz2JU0eQ2pPCZ7lc9IlHS+euZFI0NnlVwecIUJgvqB45Ek4qputUVjE0hY?=
 =?us-ascii?Q?+TfHCRHXIn9yNtfxmX9cXcpxEvPjCCj0liybskbj+80Rld86oKMcZ4+aKq7Z?=
 =?us-ascii?Q?P6O4soQDQVaAi7OOj1iNK/A4hAi7m0L59Grw5lB1iPwF4TnVOlPdpEg7ic05?=
 =?us-ascii?Q?NnqxFQhJsdHeQaB+xcS5be2B9Y1NHrrn3iAVpsWNX/2UI3Ce+IvowDianeoQ?=
 =?us-ascii?Q?nNc3YHuijcp4Kon5XrCkEdibvqMO4PJxCxAY1jg7ndoBaj6bOBXSE/Iplw6M?=
 =?us-ascii?Q?CzeTWomJFKy2F2FLja6MSluT7ElV5CIwnN17CJGTpokilXWARvxUG0fRjjW5?=
 =?us-ascii?Q?i51nYXAXY2Ll8mWqSRMSk3EjVfRlLmM+LvlohRydPuO5UHX3yNdNQ8wx/lcX?=
 =?us-ascii?Q?XlVVGrOC6K9cfFSIPnW9jaDFXEISMHILo2lDlQy9d2mQsC/CMwNBA6vaAfB+?=
 =?us-ascii?Q?UAbr0hETMLcwyxs80h5Cbj57b3OpX4SbtGPr3IfdUVmmilZRHoBSuCMKHqA/?=
 =?us-ascii?Q?eRYpvvBhwW4dIgsRxawr0iciC1csQH4Y6PliPnNeYMolXDBusmEHhAOQvpjQ?=
 =?us-ascii?Q?nnEWMf+3zOjOY/PxqCogJDytAelXpAaG9c/77D2cHec+WWu1fxv1dix3lY7q?=
 =?us-ascii?Q?Qww0OvZXarW+O3meC5RRpzmANF9JcqLzUkaba049le+gclk590hpkHbdwLex?=
 =?us-ascii?Q?K/EKOgTm3GuF+gLnd4BIEWhGoBI3oQJUR9ggJdxS/9Ss4/Szve9sryW7bfPo?=
 =?us-ascii?Q?P8re6dF/O16J1s9Xr+02nMlmaYEX2Ei6XWzV84SEhScGMlRdyGmh15K/V2/v?=
 =?us-ascii?Q?UljCCNDdMRTv0pRGptoQxKmvN+FVM5Ey0B1xSFFSlcsGSYz4AYu1kEqtnakt?=
 =?us-ascii?Q?nG/7szMfBVzZ/jH/L05aUcEGNOZFLVAa9EHsMylsuBGBXPj39JyLCp7H+/SG?=
 =?us-ascii?Q?abijisu8Abo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?smB9CCvNh0Ug724BXTd/bw3IzS9XoP7KLsBkmFI/NLqwVS2gT6GojtlXM/eO?=
 =?us-ascii?Q?aSJHFauvu1nV2idIiyxRu3ZnbwYHHhpFAVhhV50RYDrIC/VxfNGr4wAjfd95?=
 =?us-ascii?Q?kT6kkimDSZWrvtz2Y/QlrSjZbVYHty0NiXyqrTKx6IHAC6EE3dKsHWAapJxq?=
 =?us-ascii?Q?aPVri3eN8YPgBOyQF1Qg9txdjHwixuNSOD9QpOx5SFUJXEErXveW8itxjQvP?=
 =?us-ascii?Q?4rIZcIqIMOdEF73t2pxePwpt7t/1XucJVNW29S1kunV/ar3KnghzOxBlbOu/?=
 =?us-ascii?Q?1pQr48AF5R4F6NEqlRl0UoeJk6cNYtpcuQYx9BoNlU1/nsiCua4W3kQ4oHAp?=
 =?us-ascii?Q?R9tXGY2tbhSimPzdA7FUscXUU38HHIOITlk5kfNCbj/piNIzw0BEmbAEsLKT?=
 =?us-ascii?Q?zN7j8YXtdtBMk+e9x07i4imHnn3AMfOwZtSgSRHL6ongaKEZdC+g7bEa0I8w?=
 =?us-ascii?Q?/3Rf91Lnw7hC08YxqF68yZgynYB73qwapwIjTtVa1KMCirzZTvYLUWbelGc2?=
 =?us-ascii?Q?Wc/mwHy7tbSm9Ub8yByRDqTFvkrHeXFPGY6c8iA0a7nDyiRKWZcrG7of8JD6?=
 =?us-ascii?Q?1ur4FTjt2RmSPCJjz27Ci+nhfcOxCbmCRiIcyKBIhQekH0nCJUj3Kx2rs0IC?=
 =?us-ascii?Q?K8S2QJQKwya9azcNODNG+sYUx5cM2dKU53lRltcu1A+O4PdCsyMlT8yezdI4?=
 =?us-ascii?Q?V/h79ExOmovSQPKSzih2Fn1f4IN8VkPV4nkKASR++vKxSlDJCAsGyEhsbpTC?=
 =?us-ascii?Q?cV8Gu+l9/pZwlrQOwyo43v2wXtMtDCqQFwOi3QKD4lRglHEnosWfiR5oZSLL?=
 =?us-ascii?Q?qB/ZiNZG2ne51EdibdgZSZGA/3HOBfiBxZtJ7bAUk/Cg/tjuGX6RLpj7MmAY?=
 =?us-ascii?Q?x1SjR5TehbI3SG5Gy0KFfCY2coNqciTZhdlM2BIUBbBT1mWa1LjjmmGyNftI?=
 =?us-ascii?Q?+NG7X2geGtdEZnbRRyApj9QMV5h6Gg12VKXsDZRMwpiOjCH7H475Th+eBh5A?=
 =?us-ascii?Q?/ykhXH+SzaELAWfQddzdEdyxvFd+1Mde7Q2ZRkC7NoYEzLAXoN9q3A9LtewR?=
 =?us-ascii?Q?B9aUrOZkGyB9EJO+uealBpdPoDnCcJtiJA5NAQ+vcUUAoFY76ebgvT90EdeQ?=
 =?us-ascii?Q?w9GV2NxThKNq0WLAKSps+W4pynm0kQbi2hDiOUSC2sXuR8OW/MXPUx0Iq76Y?=
 =?us-ascii?Q?TQlJ1qHruEK1XmuAfXMLLgNwIQfx9bG/ySTtR4yfNSbNBHndDd8PAGTwgvNI?=
 =?us-ascii?Q?7ZRZF2uNnY2l6tEQ8GJPDvkSmpXmuaqFt/YZcisSCBm8diPCtlSZB3ZQKaNB?=
 =?us-ascii?Q?M6pq0Fh48y8wXAC1r696pt37znIUJ+Uxlb4vOpSg+VVRYe6GwbZD+hVZl4fA?=
 =?us-ascii?Q?tZwwVCZcaezdF098+fOuwCjm8O5P8aEt1iJYWPcukIZbJs9NVu9yjcuIGSUE?=
 =?us-ascii?Q?O1uDug0vPW5apZRiuORp0FUTOl5sRkRBMzMX5lcarCW6ax+me7gJFrnyWhhu?=
 =?us-ascii?Q?15tMfGoQioSJi+IL7PjYcY/KEy8573/iNQRlWjO7Lp5SEUQMUtAso7qGfIGO?=
 =?us-ascii?Q?hfzEgB48jgLQ90O/4TW9bYZ7yKwE7/5fMM/OMuyzP/cEVY7CZB6ijsCgxEqD?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f840bda5-c35e-4733-d7fd-08dd4d3e9b57
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 21:29:04.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvOSVFULXw0UhkDYDuVUmkW1M+IGjqKJXIntH5Bj6t5zWyVGmB/rmsdBe0muCTMqPadBDoS/pL5xcFphF8FPEffm96362xYn9t5TGCfuJ1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8306
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> 
> 
> On 2/11/2025 8:00 PM, Dan Williams wrote:
> > Terry Bowman wrote:
> >> Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.
> >>
> >> Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
> >> pointer to the CXL Upstream Port's mapped RAS registers.
> >>
> >> Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
> >> register mapping. This is similar to the existing
> >> cxl_dport_init_ras_reporting() but for USP devices.
> >>
> >> The USP may have multiple downstream endpoints. Before mapping RAS
> >> registers check if the registers are already mapped.
> > Yes, now this sharing makes sense, but the ras_init_mutex +
> > cxl_init_ep_ports_aer() approach to solving it is broken.
> >
> >> Introduce a mutex for synchronizing accesses to the cached RAS
> >> mapping.
> > In this case, especially for VH configs, you should just be able to map
> > the RAS registers once from cxl_endpoint_port_probe(). That will
> > naturally only be called once when the first endpoint arrives, and will
> > never be torn down until the last cxl_detach_ep() event triggers
> > delete_switch_port().
> There is still RPs and USPs that will be called for mapping more than once,
> right? This will require synchronization, right?

I feel like this would be a symptom of endpoint registration doing too
much work. endpoint ports should only care about enabling RAS in their
immediate upstream dport. So, what seems to be missing is upstream ports
doing the same for their upstream dport.


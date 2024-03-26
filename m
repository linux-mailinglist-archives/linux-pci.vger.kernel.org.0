Return-Path: <linux-pci+bounces-5196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29FB88CB4C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 18:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939571C63732
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B50652F8A;
	Tue, 26 Mar 2024 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igTYoeg3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44C1F94D;
	Tue, 26 Mar 2024 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475404; cv=fail; b=dCvbgF1m8H2P2plSDqxmfFrIuNRW8nlIgSJlZwXUrTbzAwoYkz+pFm/I3X97iXGQr4QTcYI7zjIKrZb2yT0CBUf4z/4PspHA+i/CW6etoUrqqUpqIcywwbQJS23aQkOEh/jg45lPi/01iiDDKospQKHj5hlyVLVFV8WoE5ZjG0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475404; c=relaxed/simple;
	bh=4svh+RFKEhDaPDI07ZX5meCuwYI6/tLK0wMGTPB2QlM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hTpIXgGdh2mlKvW5FtM84VtQrTa5LfwLGxiHw2fHzqeyPwyXdnUFBmavCCq+tfNFVyztdoIpbTyZ0j+ketteXQYaMEDMcqBqVLO2swpiCkDHUXhqp/HxxnDiqrtnh/OILc/dtngvpPfFkOh2j3jJO8oPZLV4jz9xq01X/zRG1Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igTYoeg3; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711475403; x=1743011403;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4svh+RFKEhDaPDI07ZX5meCuwYI6/tLK0wMGTPB2QlM=;
  b=igTYoeg37LoOXNiqyuqFEVHXVGsTniYWfdLaXNBa/v3T7Nh4soHI5rwb
   qJzCRjyGv/ojpHHOkKK++s+wk0A9xrtDx7uYQtgKsFW1QvjVLB0uWnJW7
   /T987Wg2dhmeeA70NhxlsSx9OsWoj8LdifyRqKBZqhWuE/COS8KdjsHX1
   w40H7XYmldpho3y/V5fvboAQzY0iZ1INSO+G74tdsAdMWgSw/962l9zfn
   p5NZxThBEUbGy23sgaZQe8EoZgVCGaW1HLjb0QXkB5uqLlbHj4QVFlKMB
   Iv7oiHzTMTnmL/d7/DlLSl0ymO22LXcwDU4d1MRzheu/Owxbuu/D3+ECr
   g==;
X-CSE-ConnectionGUID: QHyV5AdtTdyS9r2j/ayXcA==
X-CSE-MsgGUID: OOM9RffjTDO1dwUSK5Yqhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6676803"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6676803"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="16683147"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 10:50:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 10:50:01 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 10:50:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 10:50:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 10:50:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxMeXpaC2EZuHJ6e5f3JVWWa3fZpbzLzL8patWDxeic3/lPk9Voffv9TP3+cMiF8O4x0fWOmU02R0RhS+UqOyYCSNe8Zgnlv7eES5xPOSfDZw+cuGG0VQMpCVxLrPZ3Qj4quqGbKZ3hMDCTVSJKYdV2lMusaNI4+XH7BXCrhDHK3BvaTnJD96Ihr4sRllQRPfzrnSRKmScjJieAo/Leg2VDsfWMKMJo3RNHkfgdreNF1K1quNclE5Gx9uv+OMzqrfiTAWeYCFYOt2FRFzB+Hd4McG9Cgb6+144wbHPgUdTfd0L0duSOVpLMNqimorlowRIJVFjP2HC4D3Za6pWQCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5Exa5qEpMMD/KikgXzektXUbYnUa70WoS8DF4iZaPk=;
 b=SOAruFQLgmDfQq/P6RBpn1u8OXLr1ArBRBnoGf/oxLnwpi7wXpmgeksF4z8ynSrcmTV/JMwUd9Jqp8K/cUkzVaijEvUiZd2k4NPbgolVuU/o9Yx+tRW3qqqJROPx4sjnu1kIkQx/+j2vruDZvry5o2aXiq5+BLPIoyjo+4GHxY6k5ZeBvB1wcmJh8jxVl2Wiq/0p530RgtZhTt1KMAMe7ObY2PpF7vDLSVuCaxL94s9CoULZgSIvDyKDF+jTSsbPdV7k0hNwsMGt6r/bSfQ6Lk4suTmu8ZcD1LIWtduE3ihep/fxw9hyoyeG0G5uRq+lhiKCChW9dOAFp4N9SaGTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7776.namprd11.prod.outlook.com (2603:10b6:208:3f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 17:49:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 17:49:56 +0000
Date: Tue, 26 Mar 2024 10:49:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <peterz@infradead.org>,
	<torvalds@linux-foundation.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Ilpo =?iso-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] cleanup: Add usage and style documentation
Message-ID: <66030ac1e78fd_4a98a29415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
 <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0249.namprd04.prod.outlook.com
 (2603:10b6:303:88::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7776:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WG2xiGtIV4WZecIe60wBJY0HmEWJEd/EEd5q1zY5p9K6tHVBizy5O+EPp3n64GuAfzu6ELF9e9Yd7R59o7iKxODKHU9Gq4dAGtGrbsN7WP7OHnESyloumi78A2LdtHE1Oz9NutCQ7HIqnutrPsb1ufyEcBQeGY65blL8ahJx5GtpBh/afoKwk6x1jnyg1D23c2BpXQ1hpHkCSH5a4SD62LkdCgJS2MLqm2vt9+cMqEaarmf5YobycaXoXvkx1OKqDPx6KKIikgzUpltQc4+8X75lTfnC1WVz4n0n2J8wMDomNzt7rYBmITHbNEWvC7dBtJLs+gK5TMG1PGGnypVIv3xJ58QLUcHxd935EJFvPB+PCBl+VPoDcH0F7MjLikpHiD0kq/LqBhSU7AfQDccF5oQqO2wRc8pDZswVe7z+zNX4YcGCN90FQdLl4VcIGaYKO4OHvGT/4ITBYCErxWaAlTMeXNcHs5oE0hZedquN7Xf8gCynPCE9StxGZg8vxeVCrpxTjWGJ1jAwt5Atvb24rWxqlVRe3rK1uaDmX0TcsbZ5bOq4I75fM8U1WIWxZ3P/9idjYDQxdU/vUKtqM7KKXiCLp0pmeTzIm6tzztHdIzdfD1AFvkcdVKbkPmFR6NDN7ff71qeGriG8zSnESGb9HIniv9vYDWAJT8O/fIdFPiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+5wbbaNK3IJOmvKGHkNKc4mxxhcoV2KFdM3R04XK7WoESydSX45+QMATQ10l?=
 =?us-ascii?Q?+lBsJfFS86N7nFthp5/BPKmrn4Eu6RCSRmNmFo7VKUfg9RHomZEGBcOjcgNC?=
 =?us-ascii?Q?Syxc+euLlgq/s9m8tIeTOXcJOaYLidsPSzFG4GOwC3MApl0Fd8fOudriVOUz?=
 =?us-ascii?Q?7mtiiblaSGD0YIyxtlS5YszyEeTMYBAZ5OjfUGyPmLPHQWF9C2CTGreuL2le?=
 =?us-ascii?Q?npYJJbTV4+OemqcrlHwRmfF/gfqAWonXo0OILLWDT+e6XT/bs9nKULjREkho?=
 =?us-ascii?Q?jeh3orb4SosCEPl1+4omCh1zAxN2xrnGaxw5pqbh3cl0djV+gwPdtvt6ckD0?=
 =?us-ascii?Q?q38XVlOx+TGolXEUh3z0lzrLVkE9VJWvRKeUll4en6QrTvK0QTHXBjnljDA3?=
 =?us-ascii?Q?2RP4g6o1i9ON5sNaUjcjgqWC5gszDGtIJtk40W0djOnKJVEVEHkYSKI09h3f?=
 =?us-ascii?Q?MUfcDjMkE+zJHLSflqJRM6XBEfWZkau/VIWDCZ4HU8PT2aojxiNRnin3yh9X?=
 =?us-ascii?Q?9bwKipUswxP28k861qsZk0dHbmdopvmrHAQbn9KqirDUj3zhbVpEay9gfZNc?=
 =?us-ascii?Q?5wl8SIQtSEYp0V8K6WJ2byYAIiowrocM4BlyLdw6/UjNp156dXriwSKmwbW1?=
 =?us-ascii?Q?4KmwFXexM6RPvmv2yw6NFfuZB0yTGntFGo5auF38Pys/0YfipOYkN0HyMNc+?=
 =?us-ascii?Q?6JPsWOvoQeyJem33oiwRaPakPJdHHAwy7p3eOa64amwH57PO2RD3UM2EStOr?=
 =?us-ascii?Q?dEvofz4cijZakTPUhATG+UM89xTKljhDydejtRUMg69PT4r8qLb2gxm1w68p?=
 =?us-ascii?Q?nH48pqFNhWcXFWscidpDVrf9UFC4Fs271F3SgG+gdon+FxTY0q+EtZypMB1p?=
 =?us-ascii?Q?+Cc6d8qEs/W+0+Ja/O0ztCdxb3Rs6KGdZvxnmsPYeH7BqBHg9OndNiFCFnva?=
 =?us-ascii?Q?iBqQ+5e8Md0OkkW1JGY2xz3A5CbKd7Vg/7A5Q5Hiy7g2CauMEnjswnlQ6w25?=
 =?us-ascii?Q?lmEhytKAAaODzV9nmWKG1dUNLe9InKhaLX898hiRNHxYO4BJLcHfHtngDi0R?=
 =?us-ascii?Q?n4OR8JptYpx/ItNFCuNZJYEj3ATmx3UV5FChxQ//CuHj/eA2eq0NzKi5Y/EL?=
 =?us-ascii?Q?XJZGKShESqKOgva4w/fC3GhX7rGGYBEGuumzQPHV66WP5m5TymXUOPkmX5Fl?=
 =?us-ascii?Q?SNd3tTsRYuBuDnPLuiLZph0DR6WHlT8B48rH2GdWRPDDjcifi98Xls2b77m2?=
 =?us-ascii?Q?/8+tleKzrf4GUz061Gx5Jsr44Kj15N9q4lUPCL7DEdHP+Nt3TfQwIMYl6+Ev?=
 =?us-ascii?Q?OW+j5fYpjeJzQ987PA+yTHP4X6asuVukY7AHGL8QLg4OpJvU/6W7dL26QUTY?=
 =?us-ascii?Q?rKqWCYu4ht1bAwTEkuxlrT+a11AuqjbpGuqpbWazAlteRt3iLPRZc2PW8IUP?=
 =?us-ascii?Q?UdrgTmxUI+Pzx5wZMLjh3kE556vPqfrP11aQDnbOnmHpKlqL+onPSE6Uqsie?=
 =?us-ascii?Q?1hO9qdOwR8muT8YGAQ0GcrHGA3n8hI9eAAVaqleSS8KJGfSkpUog93O4SQ1J?=
 =?us-ascii?Q?o3CkSY8Ma3ppc1vQ7Pj6CdGGwcLRFmY3kWLuSzrBUNu3cCsrVQAhNOj++Nnh?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7b82d6-3e8d-4939-b3f8-08dc4dbd2637
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:49:56.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYQk/NcuLwChcvJHuTQCcicWxOYj2Ia+m3Z9AIPnrJvNdxXVPF9gAXSZbTgzpTKb+ZqXnN35lBFdq9jMbZDZXEg+45fBG3AdYdD9ksIutAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7776
X-OriginatorOrg: intel.com

Dan Williams wrote:
[..]
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index c2d09bc4f976..8ef2d91c2cbf 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
[..]
> + * When the unwind order matters it requires that variables be defined
> + * mid-function scope rather than at the top of the file.  Take the
> + * following example and notice the bug highlighted by "!!":
> + *
> + * ::
> + *
> + *	LIST_HEAD(list);
> + *	DEFINE_MUTEX(lock);
> + *
> + *	struct object {
> + *	        struct list_head node;
> + *	};
> + *
> + *	static struct object *alloc_add(void)
> + *	{
> + *	        struct object *obj;
> + *
> + *	        lockdep_assert_held(&lock);
> + *	        obj = kfree(sizeof(*obj), GFP_KERNEL);

This should be kzalloc(), and I should note that this example is of the
UNTESTED variety.


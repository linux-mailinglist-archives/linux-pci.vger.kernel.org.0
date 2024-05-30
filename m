Return-Path: <linux-pci+bounces-8097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E888D53F0
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 22:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC4F284D3C
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 20:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBDB6A8D2;
	Thu, 30 May 2024 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyzIS5Ex"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E026725634
	for <linux-pci@vger.kernel.org>; Thu, 30 May 2024 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717101554; cv=fail; b=OU7dAuTFlvvQT5TtxYNGjSoZnseXGRBdRuqsWaw19bQDjcgqBfsl+OBwKdPcwB7pLm2Zox0yv5/BNUnFczV+MkaHW2IF/DYdTExaAGNZWKnMwzRnHai8owc+3/aPRdfcz1yp6pHZi3hNHxM/8ZbaeX8zemA+a82fPgOo4E4qoFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717101554; c=relaxed/simple;
	bh=cZp+wVRQumPdalHKUEsq+y2eI2pnCopgPx67GI/1WV8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uDTGDvuBcN5KbmLBaS3UAeVUz/NlQyF+TzUEw9MuMrUrdi0qXOZxbT+Ccqbo50nROqRe/MJVYOMFOfxvmIkR1eTn+BogNFJiZCb7st+3dgC73dEV/qAFvUX0NRloq6nKw/zJoNwfocL66SCG9m/IJyVgvr8F1bmTJvlSGJs4wXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyzIS5Ex; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717101553; x=1748637553;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cZp+wVRQumPdalHKUEsq+y2eI2pnCopgPx67GI/1WV8=;
  b=HyzIS5ExlM1xbV6+OprY52dbS4In+p2FXaTl2Uf7qih/cq/vjYNEtpCJ
   96jcJL+CQQlRyoLvWFpPKI5ARqtmO7cuSgvCwhJSohwHixq6D93L3RtUs
   OSe/MsTVI05XxAgh3/J73wHSSiNoNkuRHOPT2G3oY62xzEYX4s4jUOjRm
   IBxnkK3olAqW0fzPyPbcDXDX4cu0KqL9HlFWWHwwlfjMc9oo5iYFipYe4
   om7kXVYKRg8JGkQkIC2RuJcVK/FnSDOtK9usZEXfJsb7KRNspXzMxq65H
   Cw9eBocYXWLXHD1GjmUxFRgj0l5rUdm+2b8zypgyimyTA8WSVTtaAqg6y
   w==;
X-CSE-ConnectionGUID: DNLQZyQFSpSr5Vav41hdKw==
X-CSE-MsgGUID: 5nc+Dc2CRXy8PSozcLDA9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="16568954"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="16568954"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 13:38:52 -0700
X-CSE-ConnectionGUID: BVly96QwRRCOYj9HlUB6ng==
X-CSE-MsgGUID: /X3Ba9C2QNyPPJzcEvAL0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40856985"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 13:38:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 13:38:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 13:38:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 13:38:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQbPGS9RNWxMLbzWWURpsi+MVkg3PY21dvxYEFBUBXw9AAUVKv4kuQdwlaXUdmx+jyakTmpMYjJpYuhpKF1tPjBBnxutgeq9U1UTD8DpSwCC7/CHYyzvHeUwahFxJq/w7NKAjkbDU0ZAEvi0i9XpqAbJIZmvr6wHD/g8opRihTdYd8QUixo1km1IgpChMeINakmMcGwcl5OwoUnQ4mmjuvESMRXIuhcdtU085bbwIzB9WQ/olkuQV/qIH5OCDAoS/rmKD1mVgYf5Azt8W9rTSH+2K3U4JKgNisEM4/yImWag6TmbdpTzZwUj2zMsfSsTP8M7b0THwUWMygYl+fzzIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ni2Dz+/wf6DFfIVFOJ/J/MdxaGt4kWvfgQELkJbEpf0=;
 b=dkUVLQ3Ji/sT7YJxgByyFcZaqCFvcEPh30GsY8MsvBlCuj7e6zuHs9Voj9SZ8fVQv2RJ+z2XV7RfHyvEx94NtFYIjXk60oteP7WK/QjLAxadh5pwBoBNxpM7m2KkAxytGn/asqBE6uzZbNte2YVhS53aM1pXHxar4EinnjF27bpCY4k1JCZ6RDXsIcgbuwovA1ZDH3Y7/YLl85unPss/doZHzhV5oB56G6EV7TnCLuKe2a13BUMSBvFGqH6DOHijUPCpFyBAda0uXb/MneEV9gssOgk5B8unu8rCPLoJyssEJvLLeNEI8vItczqeQQ2ef1oB9vBft5oh9ibNKXI7GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8353.namprd11.prod.outlook.com (2603:10b6:208:489::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.42; Thu, 30 May
 2024 20:38:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 20:38:48 +0000
Date: Thu, 30 May 2024 13:38:46 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Hans de Goede <hdegoede@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Linux PCI
	<linux-pci@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: PCI core lockdep warning with 6.10-rc1 on Dell XPS 13 plus 9320
Message-ID: <6658e3d6cc0b_14afbd294f8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240528222143.GA472908@bhelgaas>
 <d606330a-1280-4399-bce3-3aac1e1de0dc@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d606330a-1280-4399-bce3-3aac1e1de0dc@redhat.com>
X-ClientProxiedBy: MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f44021-9291-4c1a-fb01-08dc80e8820a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6CayfzR+Tcr/5pcNygsPUW7xQ3mtBjeMsOtLraaE+/WRoONZgBu9oitjuLFo?=
 =?us-ascii?Q?WaD0mx7/pEmpjfUaEEYpPld1PmSFQr3OQNbhaSX0dWEp0hrQlqspQUKjK7vD?=
 =?us-ascii?Q?7drsTjhG2V3MIBPC+idOBGbQF/Muo73epmEUMsJrin25OISZEYoyFRqH0brO?=
 =?us-ascii?Q?QFbuMTSfq4PGH2p0L1/IVM2YXIfJvsKB3/7z0Or45q6XISvDV5helIFwBiNB?=
 =?us-ascii?Q?Uw5KQsOzROjPKL0EGjwe7wzVyiYelVDs5Uvkirz+/DnOG1IKJrhLDYXLW9el?=
 =?us-ascii?Q?GK38q8BlMPplyc2RQVMPEL48FO0f+lJcVqLvYYRoiB/4xI/R2HuyoSjyZEIt?=
 =?us-ascii?Q?/vC1DVUa0foaI0LvsdfKRD1dx4fOkHSJWE1RB7DjXA4znobn7X3sDqDkRJ0C?=
 =?us-ascii?Q?3RcFCwN6/GmKd/zviwARt7Appz4216WhU9EenBzlITKW67qw3VV2Mzu4LvhF?=
 =?us-ascii?Q?EC6M+VVEDl98+GFooMp9mNnKVTttHZdJS4C20m45xKvpMKK1zMO16gJpzh0y?=
 =?us-ascii?Q?N1VXa5H0zt+DouS+dUu1LCGmJZfS3lpQMddHqHkzBa3Q3doWvpRO3Qji7AXI?=
 =?us-ascii?Q?rr4PwTaH+puwyYklv1sUMOGExTXRG9+e8TkHml9u/pXeLxI/xPelTkIoYcyd?=
 =?us-ascii?Q?jeqU2nPgS6HlE3aC9l2jJ2PuePFxtpzPcL4XnnfsDzzXkfvb87s8XtuQvcIV?=
 =?us-ascii?Q?0a9xmE+vDYhRlWWs8iN6pq4msGA3jAWtK/1nhhcY9NSJuLxYJdCwndPMWgRG?=
 =?us-ascii?Q?FW5Mf+9vlDNiy9FphRl+6LPsSPbmi9jG2PPUf+4xPRDfro8WK85gZU9Ec9d/?=
 =?us-ascii?Q?K7bm9NfxHF+le3fL2cBV7LCZsEKaEoKVWgSPi/8Iuxzt66rxGmVw5Tsc8LgE?=
 =?us-ascii?Q?NkyeW7s2rsGe9CmzsYq+8SWWz22m8P4zVxdcAN/GV05nBYcXRnXN947vsesS?=
 =?us-ascii?Q?jW8jHIeiLt7ESxTEAZhiDexkaFLnINW9qpP2ytkXYMoFmQcPoQ0fYrL2D4+H?=
 =?us-ascii?Q?2bg8lx7d9bLS51PrxxFcfbth+P/T7V8mmsb38DmZZq6ws86LP3i0/VvQfyMU?=
 =?us-ascii?Q?EeZQhKHTdNrtLoHlsFYWyUR7NUyv440yQROVwgJmBGJGBAvjlxy1SGuwS5Eh?=
 =?us-ascii?Q?mO0xZ4dk1Cbhx/ErvIb0XkDzO9RzmV3YaubTPWTcc6i8mQgn5mToK3lLF53I?=
 =?us-ascii?Q?7ecdo9U9boRv2DZkYU+2JdNl9bG7l0C34pyMww16rp/tCmi8/zyijk77U1I?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yI02BxME9I0NieBrQ7kTbdUGdsXMyXkMW+wFyjp5wd9c6UV06g5zuqeWz8Le?=
 =?us-ascii?Q?IFkhAzjRBOK5qwqt1+rrkUdgCrD+Ktqo0PaxqAUgOp1/JN5UBrJIS0yYIgcT?=
 =?us-ascii?Q?7SEJglJ7MR/qqxG5WByd/Jo/PiikNWy/A30xVE3FyeinmY+4/Xzf8ftLPWPl?=
 =?us-ascii?Q?fdRhotoVCDzUWxs/xWLZ5LwVzHcI6sRizl7uARDzsi7L2uZsejNXBhtWj6RT?=
 =?us-ascii?Q?itVdcDjcbdUbxXQdiaCRDp0KiPy9SUxkIbtgxkh5hWxpMoYUacXN35ekNopl?=
 =?us-ascii?Q?LWwyBvWWEs5Hh3Me3YwiowtFB4yP/xWiUlRzxyhQ20O7ePtZOdhFArWCbtnS?=
 =?us-ascii?Q?bxULHETKJjNkdRTMyemRmN3NrXf13jIrJ7Uub2MfMkeDdp/d/QXjlGnrkYhs?=
 =?us-ascii?Q?+2aH1ukA0tLYYRJMfMF0jPN21yS17KIuo+oOH7Z+QCtdho0g0C+sUgtt26mW?=
 =?us-ascii?Q?eQsAPtwPJd8ASpygmGExYFiZvokdfXV3lYiv39i8TmeMLhM4fNyyGU/lB4eb?=
 =?us-ascii?Q?SVSEQbcy7iMUwanPZ84Y1fRYBomcj/Da1hplgcEcVnS8nW5mxS9kMOVS2n+5?=
 =?us-ascii?Q?wSp7F05sQZ8GLbKtIE0BMqpWYWUenAgbogyJg+rARFWZsxePMuXh4UINPj0d?=
 =?us-ascii?Q?b7V9WkUe99KbjECdVh8ISounBoW6Tmntb6Xkj4gbuJIlieHbyco5lFDS0J1d?=
 =?us-ascii?Q?kOtUXPzkRuSosA3pkfSyMelpLlPGs26P/uG9irIvBrJVud8gM2jcZsd/Ri1V?=
 =?us-ascii?Q?c6II5nIKaUdni27C4ucyECK4OTUxpE1EaYLLVcR//Pjz7rIwjp90OxUlXnms?=
 =?us-ascii?Q?QcCC5ivQVKnLhVoHToQYgsHKMUWWuap60q3HKythaADI1Dnw7reW1u4Wh6I3?=
 =?us-ascii?Q?lnivqCZTdC+Ugc2nhBYIDVZMMHVneC+8Rd925/kSNqW62eVOUFQpeYDJiEE8?=
 =?us-ascii?Q?p7iYX61jD2ohZYLGkH+/Hp4ukyU0EJSjwlawsJfX+BC5rdKX1HGBcWgEGCe/?=
 =?us-ascii?Q?3lkrb+KOrub4Pfl78XMHncQPPUO15AgDo6hESRDTrAhLvs1Xl9Lyc4Pz3h/H?=
 =?us-ascii?Q?3QoiaeJKIktH3iC8hbFUl+IsNHuX/indRL9j41GX7kwIiSM5Vz6PYjxfN7A4?=
 =?us-ascii?Q?qhHFfZIDpsZ2UQr8oP9WEdxaoyqhPaXgOG9dsOaVA2CH8OuiH+v9nPUlY79J?=
 =?us-ascii?Q?GqLj7E6+JuACt5mjnXSfm1CioMSnvN/s/gw2T7xWTbdAfSCwgSoqvSjPduVu?=
 =?us-ascii?Q?fh39txgosWuKoG4Ilso+SL9wiY17AUBwMZdBYV2ZDAjtd2QbbGLcHG8pbHbi?=
 =?us-ascii?Q?tIELY0hTUwhPtVEJPqI77uwDdyPOMxy4+5djKU/9BePM9LEvHhVlb3nO4ZbE?=
 =?us-ascii?Q?d+D1dvWYIAZQo80VK++q2KTDE/6LYHjqJgWRiPSpLVF8ZTXN2oEeXT/waZME?=
 =?us-ascii?Q?hLbqRBFxgR0x4s6TaW3LADyFvwUSxiVMxwBjbEJFV/0mDFl21l64FS623Mf4?=
 =?us-ascii?Q?ew66uBGc6DufLfikUUBeuEdCcqt7bX63076n5dhvZDLnBep/Cl+ZduUQE3vt?=
 =?us-ascii?Q?ZeARvXIg1ruohavC/ADSWzunnIQbgmIOLQq2ZbfobiNt38suhAqICUtab7wM?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f44021-9291-4c1a-fb01-08dc80e8820a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 20:38:48.3331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/Q8w+qOai/i6B33htIB9h22Du5sbbaH2kFm26yEI0mT13SgLLuRDz+AX4xZyeHk3s8RjJ/yhi0uuONmznkvCennTXhwU4qbo84KqG4v2Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8353
X-OriginatorOrg: intel.com

Hi Hans,

Hans de Goede wrote:
> Hi All,
> 
> On 5/29/24 12:21 AM, Bjorn Helgaas wrote:
> > On Tue, May 28, 2024 at 09:02:05PM +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> While testing 6.10-rc1 on a Dell XPS 13 plus 9320 I noticed the following PCI lockdep warnings:
> > 
> > Thanks for the report!  I think/hope this is the same as
> > 
> >   https://lore.kernel.org/r/171659995361.845588.6664390911348526329.stgit@dwillia2-xfh.jf.intel.com
> > 
> > which is queued on pci/for-linus.  Let me know if you still see it
> > with that patch.
> 
> So I have tried with both related fixes from pci/for-linus added to 6.10.0-rc1+,
> unfortunately this does not fix things.
> 
> Note my original logs contained 2 stack-traces, which I now realize might
> be 2 different issues:
> 
> 1) The lock_map_assert_held(&dev->cfg_access_lock); check in pci_bridge_secondary_bus_reset()
>    (drivers/pci/pci.c:4886) triggering because it is called without that lock held

So this one is a valid catch and comes from the fact that
pci_reset_bus() has never bothered to lock out config cycles over the
reset. The problem though is that to fix this the best place to take
that missing lock is pci_bus_lock(). Recursive locking is not amenable
to lockdep without lock subclass annotations.

> 
> 2) A mutex being unlocked while it was not locked, I thought this locking unbalance also
>    triggered 1) but I think I was wrong there.

This one is another side effect of the pci_bus_lock() problem where
lockdep cannot tell the difference between pci_dev_lock(parent) and
pci_dev_lock(child). Fixing it would either need a lockdep key per
device (likely too runtime expensive) or "nested" lock annotations in
pci_bus_lock() (likely too invasive).

With those observations I decided to fall back to just catching
"missing cfg_access_lock" occurences and skip the full lockdep support
for cfg_access_lock:

https://lore.kernel.org/linux-cxl/171709637423.1568751.11773767969980847536.stgit@dwillia2-xfh.jf.intel.com/

> With the 2 fixes from pci/for-linus added to 6.10.0-rc1+, 1) still happens and
> 2) is replaced with a lockdep warning about circular locking now. So we still
> have 2 issues and 1) is unchanged.
> 
> Here are the new logs of 6.10.0-rc1 with the 2 fixes from pci/for-linus. I'm leaving
> the old logs without the fixes in place further below in for reference.

Thanks for the detailed reports, and apologies for the thrash.


Return-Path: <linux-pci+bounces-22602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C81A48CDB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 00:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA394188C494
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 23:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A5FECF;
	Thu, 27 Feb 2025 23:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9VDtDQy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8784D276D24
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 23:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699332; cv=fail; b=ITqNxsKYWLgPun2XoknQ05/DhVw3+10OPgZfXIagyqG57Cs4rWFy19HP8g0ju8GgIJaulwGOT6tkMVL1z8AcgMpkxkqXQy5HOJ9u7YrQMj3vVeW2IUnfsN0BEkLSOt75gSvGLXD/tL1LQ3892u/zEGu8kvUp/t6kB0BECspBh0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699332; c=relaxed/simple;
	bh=BF4XN+yTxdCfb3RaABxnn2/OFktiznj+LgmppJKM0lQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RDfFwmnfPDrzmA/z505WcHnO8oTTp2DN3TyGZCt6eAhyTXkJUTnB978ViZ2tzhXBk2FAmumH8Tn3Apd4AVwxp45rTyihScVr0/V+Mk80X+N4SQWRbDbguPfggbS7ySLyYGiNzQhE3T1Tg4D8JzR8Ru806pOuLjO85kZ9RxVNBTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9VDtDQy; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740699330; x=1772235330;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BF4XN+yTxdCfb3RaABxnn2/OFktiznj+LgmppJKM0lQ=;
  b=k9VDtDQyrRGw2cF8raM6Zno8eXJm7/55cbjZjEqH5WNauY0H5pF/Fx/K
   JAPUbrnyzWbRd6CJaPbrg5gt1JW25ZsgsFLuqje/P9NQZOA30M5Gso8bo
   tTgKxGB97HuzH9sAFjtMZt//l4RhBC//ZLU445PJKkEG4dV2jYIkE5BgE
   O1C2DsDyskKFYAev8zObt4sK/ZuQat/d4kV8MCsJvLJlmo6N9fFEBIVoq
   zHqCbenvmisUzHmxoRI8KPFjpA4VLE3hC5bqsuUvy3gq0LWmMxkdmxLWX
   uM29HFRV72YM979FMxHUKrBpPXWJ7xDdgXh68f7Q06kBgDF4Discgz6tB
   g==;
X-CSE-ConnectionGUID: rM1sygyCQ4iJj/s9+L3iZw==
X-CSE-MsgGUID: 3o/RGc6uSs6pr4BlUJr84Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40790370"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="40790370"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 15:35:30 -0800
X-CSE-ConnectionGUID: uPgmK829RyqFv09X3gi3IQ==
X-CSE-MsgGUID: 3ep3SVVtR7iOcBCn4Tm+Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="122121446"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 15:35:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 15:35:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 15:35:29 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 15:35:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7h7TIVyW5H819HtHN/VeJgNxzSjMGD797nIceljjANfJ7lJFm4G7Bt2Zwlc6aN3LmDfbLLlVkWo+qRTBVbzVLyfpwU1N3WOzFpTguQJ9Q2Wi7Em4sp/0JAknqLlblRNE2Eq41URsLWyPDH/0AyDBF3Qkw7BlsY5Rg1b1SfUfzz+HilZmsYaCdjy8yVKRD4OzKoOyqtNTd5NzUvr1YQJ8m0gTtkNUdGi2hMJZ5rY3wKSkeQx9QHOpOjttIHqVy/30qj/VK2pJo3a/sMWIKMUktqSe7R22EtmraSZXHR0VFdmzJ75Sceocf2jZcvXAMH2EIQJcusYr8WNCdvuuxoD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRO4WOgyQy5a2a4zVF+mPqlNns1iAzfiDTpCtMBJvT0=;
 b=rz+4qYfZ/59CX7AeSWJgMq6M60aE/abxU/I6P5ZyJqaJRAjCNcnsq1flffeMhE0HnI25UqRnO1c8xxE3woQzJ6LEpjwSQRt4HbRcwQwCNw1H11q4D02W7OI6vlAxMaggq6Bh+WSNSgtP0FVHIavdpeZoDg6A+pBCvm6nS5PFM8pZuME2PXdhWwaG2LRulJ9EV65zVE7GkrpKa7sQOQ+k2bxUW4A+xeIexFL5uYxnVvcHDUVI1lUbTXH9IrJ+nDIiFJ70nmL1T5gxxmrTLGyGrykmyU0KagrqrOseJ5KVtrU3UsOxot7eLQGjcQotOJoHJGf2X+EOm5HRCV0fjb+Qfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6564.namprd11.prod.outlook.com (2603:10b6:510:1c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 23:35:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 23:35:24 +0000
Date: Thu, 27 Feb 2025 15:35:22 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 09/11] PCI/IDE: Report available IDE streams
Message-ID: <67c0f6ba72_1a772945e@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744869.1074769.12345445223792172558.stgit@dwillia2-xfh.jf.intel.com>
 <deb682e6-6f08-401a-afc7-890bc48ec6dd@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <deb682e6-6f08-401a-afc7-890bc48ec6dd@amd.com>
X-ClientProxiedBy: MW4PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:303:b9::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 08097d7f-9660-442f-b801-08dd578768c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ECWzhlj6qlrG3CBPcXDnUh9xODygLFYDgmrM9JymEW0WWE3TW5pOXFLYEtrT?=
 =?us-ascii?Q?Lk5bZQ/CbgxO5hPOHxYlGp2wx+0zmUZx/0L6QVPB0GRLPYadU+X7bIv1JoiA?=
 =?us-ascii?Q?J7gqpVBzah+QSij695GvQrS4rmytrqyjUUbtfTGw08wKwOG2fhtr5sIYcC+7?=
 =?us-ascii?Q?pVr9lgq/Xlm6B34VXl5XGJZRCUIRpFRhsThIKc0RiwTKUre9KfeOWH4Hd7Zp?=
 =?us-ascii?Q?UA6MRF3d0c1dV0n52Hpc+LeVENjK5kPKJoDr5lXScnmI4Qlqgh8QJi4tTZj7?=
 =?us-ascii?Q?p5R8UN8ZaXJj6jI+zuZhybt3XYd9Y670DDUtp+mY2SM6tir6q26gF+7vK812?=
 =?us-ascii?Q?or6/SFaJL0Dej7ww1cE/pNgDBiNRRNctpKGWYzo0US1Vcxhq/MuMM7rEkGBg?=
 =?us-ascii?Q?cReHSldbV240h55hsQJcA/ePKSgJu2RkmY2PRoxDYWN7FoyGUrMY0szWAKFe?=
 =?us-ascii?Q?M/kix6+jEOHYJGtITXY3fhJDDAn4w3iqx0p5GuWms+bFIDzdBxm/lpALZxZW?=
 =?us-ascii?Q?QrAGYsj5MzKFeUl5MWmkUmz7RBv/7mVmN9Bgjqnv3E2FxGNT+NEJ7TEAmSye?=
 =?us-ascii?Q?nJUHUhkx0EGed87Nhbp9w3TNtM49p5cKZMFH6gBZ+SHnPDLgiNu/n1vdIL3L?=
 =?us-ascii?Q?ouVY/QECOoWeDZPoSDmpnYCPFuhfPR9NTP8K6KSdpHS1ozDhmHlGAIIxGOK7?=
 =?us-ascii?Q?LK7/FN5OijylIfoANgLNV5fsb6TIzKbJKMDKF+lGyWL8L7UVCo3+GgXaq7UI?=
 =?us-ascii?Q?SylR+7nTPSEUMZm+YJ3mr4V9X6tZbVs3iczoZgvRg4k3V/GUJG8LsUk53R2p?=
 =?us-ascii?Q?OzpTSbsokEFD7KnrldT9FLZsch1BrTdX+Or+lYUGpH7yzYIt01lRve+g33uR?=
 =?us-ascii?Q?q68Cgwe10ko4Ngg9jOvaGDQVsMseXHK9ElzMaDQSkEZIUHx0JflT9nyBsnMd?=
 =?us-ascii?Q?zYJGwMkqe6FJ646gDhVt841kJyn3SzkmLFxb/ycEtKk6xYWg6MEods/sHmYe?=
 =?us-ascii?Q?WGifbg8H0YVUHh6s3UTRcI+mtFlZU4HxkWjgqrJoyn+28GfGbZewbMGPBF+6?=
 =?us-ascii?Q?H/lkUVziLGIxzXvyTov7Ro5/M7uyc4RLGhG8NSJY0piIDSZXKDCBCWgh/OXV?=
 =?us-ascii?Q?l+4NckKJ7r423fytZuje7EwCVF2r+F4XGNGY7thIgcQfrqU94c/EhlXYoaET?=
 =?us-ascii?Q?v61bxguPCjAv3DdsskhQkKe/6B82B9nIsGnT0noon6PibX9rk7sv8waU7UIK?=
 =?us-ascii?Q?jEu8eHxgSVEs3Pgbj54B5oL0aRD2ItuLBdWdI7rrEcDhYocTJzjoZ2HU036B?=
 =?us-ascii?Q?+aPZYQfXMHl8eHO+ajZlqCjBiWlHcST6lPQLcSqNAmMNgp8oFHSTaLKSYAKX?=
 =?us-ascii?Q?tQMuDmxWvIJWdOmfr6ZHhNaXa55a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CwTz0XKRWKHTT/fGFSRzFxjKQlzanxsWgPbtNTrjEMo+iheJu7n8thHGJu1N?=
 =?us-ascii?Q?8vRUUjCHMeeDtRSFwBem1dn/eBhBBn3aDLwSljuymfXfeiHVZ9CWsp7d3/fX?=
 =?us-ascii?Q?JW1AT52zjilDFcEfs647mgmJFYWnnjImAAJzloXNFMopWBgRRzQ12DT9KYkG?=
 =?us-ascii?Q?262xTh5Mk7Jp55SlXMGJoqYyfNoQazOZAk28vWOVUomJoNrVsraBtBrABGvh?=
 =?us-ascii?Q?xHcPVwRj5jj712wPjK7EGxhpr9afAAy2zvQJHF9k4APBs6OdKglI4mbeOlEC?=
 =?us-ascii?Q?vsWMV87Z/CfY3Gn/xKECtkGptD6cnKwH74XTKicrT5u7TDTTjLOL2FGjgATk?=
 =?us-ascii?Q?EVnExV9LUXEFfs96QEN8CecYV9FtAs7obfPHpGbepQEE9aLKJcfMdWp0o4Om?=
 =?us-ascii?Q?wpKpzQ1fqk2P49cmaW9UwI9sTe7Y1dDtGP11YjSmeahkWIUAxz1v3G/7NZyJ?=
 =?us-ascii?Q?THrQw6uqvWy4tALSSTDnRnaq+XEIFdzC8KSgqK/DilP6sB+o/vIh9ahIArGl?=
 =?us-ascii?Q?QCTxtd6mSvXd7HiQWFyAJC09OaIxvh1ccRaDlYwQUBoBtmSAfK4vTCEhYtXF?=
 =?us-ascii?Q?XBCZ/lmK98aDuU+BGHHU1A5Cx9h3eSfhOlHb4ckNXlJQQuKZCMzLCFFTmdiw?=
 =?us-ascii?Q?gOuMH6Gdh9u5F2hdWtQKyt/saONVfohJUsmDVNncZF1HvFme+hw6dgKLJPwf?=
 =?us-ascii?Q?ys8hea+UrYpMwfGuGKYBRFgUPpTArBlaHpbqxv/tZ8GcWhvXPWmvwGEc6xoO?=
 =?us-ascii?Q?1zCMtEREicx/inO62BYfjmxTh3ILxxRgAZuH3Lzto6K1mU1zwkx4VmyxeZRi?=
 =?us-ascii?Q?4RygquJzyuZH+eRYjZntKK0KKFdU8uDh7Hh+E4eXPa4EvwL30MjQ6Y9voaop?=
 =?us-ascii?Q?7TnrPu+Ym8xdPPLO0L5qeq2ykaMkHvJP6RhK2LH2sDTQB/MC4r00sqea4O2p?=
 =?us-ascii?Q?wxOyUyvnooVKIUcUawJqQFxpMa2/AHNcCnDWAUYQYL89HVDmpaXGSF+m+5JO?=
 =?us-ascii?Q?P3Wu/c3whOb1kHMgmF7F/qzYTZkQMYYatMB+NwPBlEdqjK1PB4CYcg78dGZO?=
 =?us-ascii?Q?UjyAvOhUNglwhnzEAlcIcT9UGfcy6Q4qQPfHqoRw1O8N/gFPkLSntd1fpA3g?=
 =?us-ascii?Q?HXA5J67dnOFdaZMaRe4I4ItR7ZkoevHIg+lB+fGXs4n/8y/3sFBtJ9Jaootq?=
 =?us-ascii?Q?PCIREannTgPgq/3CYLMX8C8u1lPqC4wPQk7sF6FRpuoQlg0hrttvy9Bv/+5M?=
 =?us-ascii?Q?/ANktejCTfNW9fz7vvwu9L+OxP/1DXJi4BJXf9r/YASoUqxE1HU/epp3p27w?=
 =?us-ascii?Q?e9+RTcQckPpsTSWqFyVyYyDSlRLuq6ulspZMnDvL7aRjN4xZcdZ+IZJwhgsO?=
 =?us-ascii?Q?4x2ZMOoAKcr0BTDnetFtYGp4fen8AqsIgSw0NA4oZnbb5KlcjNpbcXy/aKTY?=
 =?us-ascii?Q?aZ534EzKRgnQYtxMA80+GuLXDZZAfowrCs+lE44dmodfoihDz7Yokkb1Tpim?=
 =?us-ascii?Q?EWt/18XmqE/6ecfqbA6XHesgA4CrP5PwBzeOcD1n8BBgSleJY8SZIYH6iRAc?=
 =?us-ascii?Q?tmpyoO3jQb82bwgouPfabvWiGL9YXhWFr3tIvK651dRO+05rlIIHtxi8jF6+?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08097d7f-9660-442f-b801-08dd578768c8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 23:35:24.7867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: av64I7+hWiHhZiFueJFcfdA1kZlYnzwJg57tFylrYab63zD90OIp9nMUr68DjcD/nGrxHLYxntj0bXZxu2nihe88pM2iIWQiEhRmNiKwze8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6564
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> On 6/12/24 09:24, Dan Williams wrote:
> > The limited number of link-encryption (IDE) streams that a given set of
> > host-bridges supports is a platform specific detail. Provide
> > pci_set_nr_ide_streams() as a generic facility for either platform TSM
> > drivers, or in the future PCI core native IDE, to report the number
> > available streams. After invoking pci_set_nr_ide_streams() an
> > "available_secure_streams" attribute appears in PCI Host Bridge sysfs to
> > convey how many streams are available for IDE establishment.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >   .../ABI/testing/sysfs-devices-pci-host-bridge      |   11 +++++
> >   drivers/pci/ide.c                                  |   46 ++++++++++++++++++++
> >   drivers/pci/pci.h                                  |    3 +
> >   drivers/pci/probe.c                                |   11 ++++-
> >   include/linux/pci.h                                |    9 ++++
> >   5 files changed, 79 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> > index 15dafb46b176..1a3249f20e48 100644
> > --- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> > +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> > @@ -26,3 +26,14 @@ Description:
> >   		streams can be returned to the available secure streams pool by
> >   		invoking the tsm/disconnect flow. The link points to the
> >   		endpoint PCI device at domain:DDDDD bus:BB device:DD function:F.
> > +
> > +What:		pciDDDDD:BB/available_secure_streams
> > +Date:		December, 2024
> > +Contact:	linux-pci@vger.kernel.org
> > +Description:
> > +		(RO) When a host-bridge has root ports that support PCIe IDE
> > +		(link encryption and integrity protection) there may be a
> > +		limited number of streams that can be used for establishing new
> > +		secure links. This attribute decrements upon secure link setup,
> > +		and increments upon secure link teardown. The in-use stream
> > +		count is determined by counting stream symlinks.
> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > index c37f35f0d2c0..0abc19b341ab 100644
> > --- a/drivers/pci/ide.c
> > +++ b/drivers/pci/ide.c
> > @@ -75,8 +75,54 @@ void pci_ide_init(struct pci_dev *pdev)
> >   	pdev->nr_ide_mem = nr_ide_mem;
> >   }
> >   
> > +static ssize_t available_secure_streams_show(struct device *dev,
> > +					     struct device_attribute *attr,
> > +					     char *buf)
> > +{
> > +	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
> > +	int avail;
> > +
> > +	if (hb->nr_ide_streams < 0)
> > +		return -ENXIO;
> > +
> > +	avail = hb->nr_ide_streams -
> > +		bitmap_weight(hb->ide_stream_ids, PCI_IDE_SEL_CTL_ID_MAX + 1);
> > +	return sysfs_emit(buf, "%d\n", avail);
> > +}
> > +static DEVICE_ATTR_RO(available_secure_streams);
> > +
> > +static struct attribute *pci_ide_attrs[] = {
> > +	&dev_attr_available_secure_streams.attr,
> > +	NULL,
> > +};
> > +
> > +static umode_t pci_ide_attr_visible(struct kobject *kobj, struct attribute *a, int n)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
> > +
> > +	if (a == &dev_attr_available_secure_streams.attr)
> > +		if (hb->nr_ide_streams < 0)
> > +			return 0;
> > +
> > +	return a->mode;
> > +}
> > +
> > +struct attribute_group pci_ide_attr_group = {
> > +	.attrs = pci_ide_attrs,
> > +	.is_visible = pci_ide_attr_visible,
> > +};
> > +
> > +void pci_set_nr_ide_streams(struct pci_host_bridge *hb, int nr)
> > +{
> > +	hb->nr_ide_streams = nr;
> > +	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(pci_set_nr_ide_streams, PCI_IDE);
> 
> PCI_IDE needs quotes but somehow it was compiling for months until I 
> rebased onto v6.14.

Oh, interesting, will fix that up when sending v2 based on v6.14-rc.


> Hm. Also probably all exports should be PCI_IDE NS, 
> or none. Thanks,

I will add a comment for why this one is namespaced and the others are
not. I am also renaming it to pci_ide_init_nr_streams() to reflect this
detail:

/**
 * pci_init_nr_ide_streams() - size the pool of IDE Stream resources
 * @hb: host bridge boundary for the stream pool
 * @nr: number of streams
 *
 * Enable IDE Stream establishment by setting the number of stream
 * resources available at the host bridge. Platform init code must set
 * this before the first pci_ide_stream_alloc() call.
 *
 * The "PCI_IDE" symbol namespace is required because this is typically
 * a detail that is settled in early PCI init, i.e. only an expert or
 * test module should consume this export.
 */


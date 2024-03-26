Return-Path: <linux-pci+bounces-5193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A18988C9D5
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 17:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C064F1F2168F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09051803D;
	Tue, 26 Mar 2024 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhJmZNK6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591DB611E;
	Tue, 26 Mar 2024 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471913; cv=fail; b=qEekUFq4wf1XTgdzU4oH9S/eV0Hul7yd6DAG0/hdOT/fHIxMqXL9IUQS4RmQQbD1lklJkexCeQJElpdCqlgPRSasRuQt+/xbFFNm3NnSWEl9Ga2gT26v/wMt6CLWv4Pl5FG7pGdfeAeuQ8Lh41/bQKUo2zuI1njh7EWgSC5dfLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471913; c=relaxed/simple;
	bh=D8o/Du9/cL71WBQa9Xt6oAnn+Hrp5jkyJVTE9ddBU0w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gDyYYrcI06peobD5fMBp+dNNJKIEtl2dTWGJBNAcfo5atC1/OkXS2eyk7bMAUwzjKQt2BSxFhPCJzLtn7vdrdCgMzJ30s3G/KkUxAhARE1HsIlVx9qZsaQp0scKEgTRq+8iF6QQtpr/U2BPDXPeOP+on7H4szZvomAhTbjaMyH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhJmZNK6; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711471913; x=1743007913;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D8o/Du9/cL71WBQa9Xt6oAnn+Hrp5jkyJVTE9ddBU0w=;
  b=EhJmZNK6wDdsf46L3uiUnpowRb2yNQ16RDc9UbPhvOAFjMtAJLGXEwAy
   XLwSqQ/XGsVIAi/NPWWFPJTibbpfoR3QvprOEPi+PiKTmbm+181TMzYm+
   OGbPA8/wTzMk/XJFCri49XVfj5TCfe2aTx+x3MUfS+hf+SrleRNBZslPF
   IB/8+Deyb+lMqsasmJX9PiXRX1SCjKlIVFsOeL/bpn/6ddK5N81SeuG4d
   ird3n2j0mJWXMJksBsZSzILfPjjNKcEcApoFRADN4zHG6uhr5hJ4RYTtZ
   9RAXeE7APubiqdPkCkwx3NSE1cmWhVIA63VMuhP0LyAco8UjeU1mGCBhC
   A==;
X-CSE-ConnectionGUID: lk8V/X7BSweqQslC1UgKeg==
X-CSE-MsgGUID: mSj/p83rS+GjQhLAAwVVIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17680090"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17680090"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20566636"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 09:51:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 09:51:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 09:51:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 09:51:50 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 09:51:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkNQbOFEyvBStyERZRoNTrvVY6DXbyhsdJhVlo/h/+//V/f8dm+g5l2JnNGjyoBniuLaBb1FxDNbpJH/pZlJR61RxncForjm0ABTCdlJ56mt2SE7cwGQ+o/w90T7tn6XZ98DXpZ6Ll3ldOWYCSXw2voQRvvcMcMgE7ksDp5DCHk0KqPJB+jjH/mQLM/F2N7lHhgVZgOCR5hpXKfc2fSRyDLuVJh4DZnqboaUKBqh4uI8TTpEKvBtIjE0wl/8TjyMMa+55VdS7ucN1OjPhXN8NVRlSj97J/PfXOlbfnucQEfhFYpbx2qUZ5Dd8jcmqzFJ44JSKEsz/QdDNfYBqnRCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35AaHKTdhj7eAacatmkcJjnDuTL1JZjHb88E8imxl1A=;
 b=obB0iBAeKMPHNSf0xPOvtGMG5nHEe0NVg3KVoO+MJknDO7QeP2wLXL2BNHsyupTcOnpXDeRMiHGrysB8SMxlCufPNNMIBDVvP5lnWv/bMkkoLYJSGkfvJzQEa4nDcpr3gUwC8vfw69D/7qipMp7r7LBQfU7QUVV/xJ4tVjff6Yyyi0jdj5+rRupWRUqfGSe4l0/4sT5Z57n5lUhweXW6bQ3y1TbvJk+ORUCJchOSaKDSGetL0TlC2rrevzKYz9uVQKV8kq6gM5S+btttfxQ4xkXOTFUK5tYSmRf5Wi3fsQIk+qPCABYrK8zYA237wbQqXUIbvGXEjOqo0Dk0dpfRVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6062.namprd11.prod.outlook.com (2603:10b6:8:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 16:51:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 16:51:47 +0000
Date: Tue, 26 Mar 2024 09:51:45 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>,
	<peterz@infradead.org>, <torvalds@linux-foundation.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Ilpo =?iso-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] cleanup: Add usage and style documentation
Message-ID: <6602fd2119101_4a98a29474@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
 <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
 <8734sd0zwf.fsf@meer.lwn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8734sd0zwf.fsf@meer.lwn.net>
X-ClientProxiedBy: MW4PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:303:dc::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6062:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLiwp3/95KPeZK0bT4B8CYqkClmHk1sQuMQybzbKn3nyW8r2wdv7F2t6I/T+VYe9UtO7Zuj3fiEJKtj4p1ly13BQ01oKmd/hpTDMs+lSNZwJbWhY4xNqwxt52yuNBFN/zzRGdBqashOnEB1SsDxBvfEVICcqJgC3LAi1XZWszYoGFUcdAvZD3ZkpzX+Cy7Wu1/f78DjxcRSz0Cmc4VHsmw39VYdXVqkJCaarElA/s7JzRg308R0uRiM6nvGRC9WOctVmpPdi/GPSdgTJXcAJ3qJNF2RpH/vOOug807C2RO0Q+2M+OgDwdBfYd7TPItbgoAGu41lmM4oWXfTTboIVVZnPnCqj5+LWtjGxtfDQ3KURCNtKp6wLoeH7hEcHxl+SJ0IA9shYThCxo8UU8X412eod74/OctjK42Uq0zYVwLROnC7rU9+RQT0+1kaI9H+KIw5hn3Xl11pJZ7GhLWla5HzBZUVri0YjD1FEwscb7i2Yr22CrlZFihLDR9DIrRFzV8HfQ9YRqAhOCMbAOIUL+3+PlVTqQYnel0f5//ltvJCTeF8bVH0DW1954zcMuIG8LgDQTnbN9Uhon4lAbcGPbdRYUbW1L8hYD1eex0kjeK6mGoB7YiKe9pV4h3blNHaIRBmlTW97zybxMRygvO55IFItUUqetRt75+MDfl5HSBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O7wva1KGfZ/IzUbYWqeTkEKrHkuFuj8AHIvQf8Z4mLQ0CVDK51Dqq6ZiCNl1?=
 =?us-ascii?Q?qsdZyJbE4AWJyMOnNcBALEcmNzZh8MD6ijHycx2NSC47k5nBcFLoKNw9oAiz?=
 =?us-ascii?Q?umn/Xxm03jiOa0j7CKDlx3wr+c7LHh2tsW0IIn7m5mLRCdsGvS1XzmVp7wr1?=
 =?us-ascii?Q?w2Q/AXwyc5sMX1X6CUt7rDhfprbAvxjVvybuoGQ6NlVVfWLN/W0jRpjc7+b0?=
 =?us-ascii?Q?ZgvYwYvfCPiIU1IwpEsNO+Tfiu4EZDTx6sOHMUWfhuGZSz6HO5ObFAlq8ZbY?=
 =?us-ascii?Q?a3EBQL9lAOOiioIqtnkYuZ0VRM4xZXvHr/icZe6vU4kJJfGRYpwWqKErVq7U?=
 =?us-ascii?Q?4sS3U3D4XcYZ0w5sdiZcNqepx90HoypjRVBC5bJ5JuRPh9VDM38ENcPi1+a0?=
 =?us-ascii?Q?+kWBqD+zaPx6TN9a+dmIosbXqSxGqqA72V746P1nkK7pfabqDE6HFcEp2p05?=
 =?us-ascii?Q?bf7faPR5/ri8OaVP230zUcksG0hJ2+uM+eB1/zOqtzC/bxQFozg3n1tYYKQ2?=
 =?us-ascii?Q?M9YkApfpnxtAbMqz5RVlpjggT7YAqoqGDBzyjWjRFc/CfeRiAz7QZqmWXTBZ?=
 =?us-ascii?Q?mpGeHEBu4UwRD8P22oiIUfe8QhVYtNEzcTjOVaaOKRdtFFn4dSkagefb2WgR?=
 =?us-ascii?Q?ybUaA1ikOwVadFD7WdDsB8nrAohZW9cdaEMVXqcrvQNuiOAGVrE7hREqqOxd?=
 =?us-ascii?Q?MHXWR8yHoK9Z9dqsN0SZJQiHp7e+d2JAyu+j+mPgrbf43Rf1E6cAmmCh9A7+?=
 =?us-ascii?Q?kqFwKLCWEpCpaXP8ck7jMTpPTVFvmipYKpThkIEXioUQM8IgZbDGcdbpUSlx?=
 =?us-ascii?Q?na5FZTTyxxrPtof8ZoqS4HSpJERhpkFDf3jNXb9OLxQ/4owg5kB/tpvkcy52?=
 =?us-ascii?Q?w1yhGpQibiw06+/C9a7SFUs7OnINe0gz3+z2haVFYM3V6CiOq4PskpUGINdf?=
 =?us-ascii?Q?rmkyySTIq54sEiL2N0lqpC1NYqd8zTxARKYEtNYwvrx2CV7JoyDvvekxfW4V?=
 =?us-ascii?Q?AYkdzVtnWGNL82/TKxcDyrfwCYjfA1aN9pWaQvrZ4AZ9yk+yR1KURua8nx1Z?=
 =?us-ascii?Q?lQTUN3xHW1L4MptcFk1+zev3S6ezn1Z5+d+LzvFMKow9AZoJpnzdMeu9g/qC?=
 =?us-ascii?Q?6aOlYH1s4WVEXC6/6j6j9kp57Z7JcNjpuWYM9BGf4n5IKr7Rqra7EPFyHvsJ?=
 =?us-ascii?Q?DeseHM9s6U+RuW/n2v1nlunwDbc42zqzviyTcUDeCTDsAaZRZUGSIv2ex0Q+?=
 =?us-ascii?Q?JH5VSDkLQaWtulnFwcoiUVKL3zLgiRYZeQreJc4Q1pvhK3tw/NieJb4RaTts?=
 =?us-ascii?Q?YVDoeaGEtU9jytLdTQTfIMbX1sWFgYKwEvd1BanMfXdur7m1oj0Qk8AnulLM?=
 =?us-ascii?Q?13mB3csQv8vybRAF6HDRHtRjJA6r38MJl8gglCtUYwt1hlSs93NyHkSchY09?=
 =?us-ascii?Q?2414ny3qBuqcEFE5yL+BtN5lnLBW3a7ca2Nas3qov/IPU57TSAJRoarBM/7j?=
 =?us-ascii?Q?TxOCDmGWgMoDia4910obEhq8BU4hwPEgzgBpdKxyXLyMCFOi/lpoZ6Tqmv9H?=
 =?us-ascii?Q?0uQsXlGnBv440POfP7ys4UlQEYRSNmiLkdsdCBn0/tq9jRG8qeiYlDhhKM1W?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d47697-5f05-44dd-7017-08dc4db50699
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 16:51:47.6793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ew/2mQjSRFVSdU8vZgGUjTePpZdfgWE+Fw4eZO2djCvba7kp4/vyikNgwEmnS7giVfL18rWdmUMq3jfWS+5hxMgnKe5quxi9o/v+VU+/Dhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6062
X-OriginatorOrg: intel.com

Jonathan Corbet wrote:
> One little nit...
> 
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > + * The DEFINE_FREE() macro can arrange for PCI device references to be
> > + * dropped when the associated variable goes out of scope:
> > + *
> > + * ::
> > + *
> 
> This can be written a bit more concisely as:
> 
>  ...goes out of scope::
> 
> without the separate "::" line, reducing the markup noise a bit more.

Oh, nice! Today I learned...


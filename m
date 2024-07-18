Return-Path: <linux-pci+bounces-10477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3701293467A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 04:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55EF1F21F1C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 02:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABC9286A8;
	Thu, 18 Jul 2024 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gA9Fknk9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FC024B4A;
	Thu, 18 Jul 2024 02:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721270636; cv=fail; b=VeGanragV/W4dhTGZqoxKeVSvakS0EHv28bUC+rA4cejtUHm2ea2Df7aEMz5XtkENudPj5kZrIU2SF/igXTvt6N+g/rIIL4gl+nx9vEH6cJDrnME3t9nS6jvpHjar9Q6l1GZr9/nFYE+QzY0iY5TrOe3+lbiqYOr408rhcTXJx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721270636; c=relaxed/simple;
	bh=rZkvRU8IjUB3mLq5TFP20PwhTB1Kfc4y+uejwxwHC44=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=doPtxchGPv1/YWTzHvVKbkWrOSlTcCR9A1P3O5ZM7fbDj4ejoWOJ/3tgz3BeXlIB61oMkNe3YcZQiILHlvfCCFdxATp3pveXCv8vVAWDHgVlPYsxVfRSro6xmkJJHtenbiVkJQe/kJEnSjVLYmDV/5eSWwozw3XO6rbtbfcydi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gA9Fknk9; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721270634; x=1752806634;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rZkvRU8IjUB3mLq5TFP20PwhTB1Kfc4y+uejwxwHC44=;
  b=gA9Fknk9EvmS/wUvyYSu2DyOVt42nyxakA8oGeUMAvknNGfN5SYW7plk
   e/zWp60ZSz4u5FTXDui4gXgX+gWxnkzuXAJCbDPDp5nGn6+2PVRNIqxuE
   oxkSsQ7e4FHsoV5n65Hpwqo6Wz+TPZeSG5zim0ApldeEM+SIO/vKJpIcV
   Lj4GHv6jG3FE7Hqw8hQZAp4e3gj80mWHYo223AB9Sazn0Kfs1gXRnQRQ3
   nC+GSEnCTqYMBQBewgtnVG2aKAJ+cNRISDPxbPCrxv8StaXjrpNwUIDcl
   lVLltM3mbW2GHkda8cI/Nljurc2kShun9Wg2FO/p+a1vTtH0+nz+nAkgk
   Q==;
X-CSE-ConnectionGUID: OQ2nka7dRiioZmc7/LSySw==
X-CSE-MsgGUID: W4PnwflFS2uIU+7dicunlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="30224286"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="30224286"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 19:43:53 -0700
X-CSE-ConnectionGUID: xuthOUJpT/qCpeELaGWJmA==
X-CSE-MsgGUID: rE940lFpSUKTR1uHD1L0vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="51333266"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jul 2024 19:43:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 19:43:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 19:43:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 19:43:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJWHzKWS1LOGkwwEkE0Jus+ufFmVA5ekZLXXhvqdTjmcDpVjmLiah4ZGVFNKpLMzgW0cPRBFZPXKbdYrcIN3ofrHHUFqsFFfjxnpVjOM3dXFzt6kLOQ1tvwnU9KxDku6uo8nk88y4Gp7Hrr8j+qWLR6XoxOm/AVBd4Ln6bsnbsfeso0fiXUicZzI7vHibRXoVvJSJ3kBYWA6uF0wwNz9vj8k1JDANzb4cWqVsaMzJuyA0G0dzkqy0bd3G6x1yl7ikKBzp5GDv7vavqv6vzUU9Kz+sxLiOOo+uKpSMWz4pLOHHYSuAvaj+ANVTcqHDzH1tz1XtdnfkkxY8DFocqq7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chDhIKf0dtvT9TpF+qQIFMqyevK9eadzrxwbQ7r6SB0=;
 b=T1161R5YCr3NCr8PnnbD79Zg29mMTPwpjayJ5756L15xrGct7sf4V5Y1dWP6xzw9+a5snktYeXvMFQh2nYf8m9lV1VUDG24zy7aMX9qlypdYvVqVp1hTMpGUiJlMf4AWFnejHsIMhFJRsbj9f+HpNVoKzSizVhT77MsofGtpsH4rtWdlGjzh16T2uH9sW8SyLxlwZ3LRV/FozF0cHdUYWIfJD0/CExoOC0Sccbcpn/AdxaccyrBozWiiBmlnsyLJJRMgQAPI1bD/38+2sU7ft8Or0H/ss8tOnJRAEHoEOayJlftQQy3JMFStbY+InIUNegGhkxppIpgjYFRKCEQblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7296.namprd11.prod.outlook.com (2603:10b6:208:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 02:43:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 02:43:44 +0000
Date: Wed, 17 Jul 2024 19:43:39 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, "David
 Howells" <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, David Woodhouse
	<dwmw2@infradead.org>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
CC: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal
	<dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani
	<dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, "Jerome
 Glisse" <jglisse@google.com>, Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
	"Jonathan Corbet" <corbet@lwn.net>
Subject: Re: [PATCH v2 12/18] PCI/CMA: Expose certificates in sysfs
Message-ID: <6698815b1331a_1f03d294d6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1719771133.git.lukas@wunner.de>
 <e42905e3e5f1d5be39355e833fefc349acb0b03c.1719771133.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e42905e3e5f1d5be39355e833fefc349acb0b03c.1719771133.git.lukas@wunner.de>
X-ClientProxiedBy: MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c44b152-8c93-46a8-0f85-08dca6d3712d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J4ScP2O9UCD0aMkPxxL/Uo3ZWVtW2d26+ZrhMnGaTFcA4bfW9DhPC3OOz5/B?=
 =?us-ascii?Q?uTl9eqAHmBiyFnRlthXX3FUVUgUTWEIta4VncAe3yAWHN1QkljZgkG4cn+J6?=
 =?us-ascii?Q?wVb0IOCLmSdF5qzP1k01g3x7dNA0JZ5UsKMMBI7SllTvftgKrkf+iGQfq+3x?=
 =?us-ascii?Q?rWeOVpOVMQXYzjwvNZrBZc6cX3k6dRF7Cg+NqyizyCRKj8vcl4TpF3AK+B2q?=
 =?us-ascii?Q?4dZin2XXpFl7XXt9cLWR1N6iAyY9KgT4G8fTu0gRTKusxuYrDpqf4i8Aaa2x?=
 =?us-ascii?Q?jbEynn8FigcL8GWqB3UMGhW2g1UH46voqKBzUCxIk2Ge230Br7t9pIhFHLAM?=
 =?us-ascii?Q?zXdQO0U4w07BmtPWh9I5HDkDJyQ2NUl9kZJLWtR6Q+4pnePMbA9A07YsQxN8?=
 =?us-ascii?Q?B3p6A2J/wq5Uwpby5Tqf0crnhON9Yn36i+JrPnvx/JBJdXNQgrjXDT53KvKy?=
 =?us-ascii?Q?uCVDsXi+yrb8YOnAJM7Yc1bM/+i05EwCwvvzIIP8jqL/auPmoAwf/oUv/BeS?=
 =?us-ascii?Q?HxtZI/ivJfq1H+RaS+44yE2NgBUS+E3cVcEbPRvQ8oUDpokaNc7P6pDe8qJ5?=
 =?us-ascii?Q?EDmY2kCF7wCRPignwZj7CC080O/IZCqUUSXycX7WYsFBRxk3FYRyubboJHeU?=
 =?us-ascii?Q?jX0P0+gSM7aVXj+hoeduDm0ux/N1MxQLmPhB5HvVU6UV0rDgGlYF2+58nL1f?=
 =?us-ascii?Q?Id3nFJyGeKLw03YFi8NvJhsltixMz5fWSVqWtUrJ5eQCX7dfG4A1+0p+L0lr?=
 =?us-ascii?Q?fRTTWyn2l3IWi7R0sYjz2qPDzBfVJL3YiIfOLFNWUy5QYW1D+ZQXm0MNDHom?=
 =?us-ascii?Q?BkfW5xP8XpPUrNqY2El5I7KB3ZK9BiLzO1hOabblA1iXp4SUAhWaEJB4eoe3?=
 =?us-ascii?Q?ewICndE4PDxzGHzixpWuj10aFhTPo1xbgDm+yoPpUfWmUZi+weGqO6JUTRLR?=
 =?us-ascii?Q?sw5gek5F0otYuecWE2QYiGmT4j4qotdFP+Z5zEtSbFoQoTX/IXgtGWBamdbS?=
 =?us-ascii?Q?xL35mSvYbqtrrwG7nxmvL0T4ZdV9Kp08LouvCKmbrljFUr+JIiqIt1iAgDIF?=
 =?us-ascii?Q?I5OjSenSfIA9LzFhOPtFpczVrLP9Nya8AJHJ3ezW3hyRtaam7J1sBJxrIl3N?=
 =?us-ascii?Q?b72No8fbQLP38UsZw3woqA/HPPtxqV2KvJ8DPVsvgg9LQh/1f25xLr7qVY6x?=
 =?us-ascii?Q?abx0bZa37XlfCymDKvJcGCwC+EhFBEAH/Cwo+vz1BWnkMUCYVbgmMCc0zBzG?=
 =?us-ascii?Q?bYquZKEhh9qHlzwdlnVTsEzh/tQT4B4O6FfSS1vjIQRij/S+U2DZYYNsrOPz?=
 =?us-ascii?Q?+nRUck6d9Yp4OKhPRpsDv0f4K/bJpHyB0AF24RSsMTWsx+7TsSA8wdDgDwnO?=
 =?us-ascii?Q?/tXwYrtvixXI4dct6+uTRJzlRuo5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XjS7Oej7xd8d/jyaQadj/gpl1ghKkeO5HOr4oN2Le1lEw0saLIsXsUvkIWET?=
 =?us-ascii?Q?SpJsxlZKBhpPrDUfydBiCrBQhUzRfiBrEoFinCuXLfgBI4UREcyv1M8Y6Pr0?=
 =?us-ascii?Q?beQDoho0UB2TL/dK3VTb9kSbBkkpiOm05k+1wHqxz7c8Ab3Brx9jbu/SRXSA?=
 =?us-ascii?Q?2o+1qbBYzFdmGg6k1lwqV5k49SmPxVvu4pKixqiMuSKGQfNRnJ8qQhjncvYc?=
 =?us-ascii?Q?X0eFinvZvGqr2+RhC9HoUhSR0/IYts+X9AvWGigYdIF3eAyJgynepVVTGATK?=
 =?us-ascii?Q?46hp38q3cUCwIsMOJqNdlyFvVEINMGXJ9VN4b0qIJKcpKOnHbzG6utJF/6f0?=
 =?us-ascii?Q?qouQh+0s3Qqb+Lz7g0c0z9BYh5HBtzkSMNkl5xYXWj24YjrtHqs43NbHrd0i?=
 =?us-ascii?Q?Q0ReN4fZLEG3thEENy2NGpjEv3saj1V4sVUyEUE1NzjdjQrVCdbWR5SPB+5W?=
 =?us-ascii?Q?bFxvyQjwoyp7xxsTgaUa8TL80h2DDY+qCfajKTxMZoI0dVRIslvEyDS8hzlc?=
 =?us-ascii?Q?3jUkWP3xFnztGcBBfVhVGqaipdGzsx2jR3Ua9pn3UzH2/udSTmcwjHImBBNl?=
 =?us-ascii?Q?R1L7GmM155YjRV/c+Kd+1+Pj56WL5j673MxU1LG8LrwtamFXACzmXs0Qt9OX?=
 =?us-ascii?Q?qnubLgPiwW7Vv6zpKiJjJ2MrohybKxF9KMOT93eUWt4TWV3nMdpAtgTOGCQj?=
 =?us-ascii?Q?9hufBeepAaq76/L34CaClCXdnazZMg7MCr793AEil+ObCVAIPmdbpzjEaOV+?=
 =?us-ascii?Q?ey4Q7lz6wTBF0o4KVg2xkASeGloJ2rlWZaGb/jqAL62MYz3CexkNbXeYGiKi?=
 =?us-ascii?Q?JymhB/PUVs/b2BL2CuH1IF4C0v7XHKod4RIBO9uR0BL0SVWEHKsVX38i30sJ?=
 =?us-ascii?Q?9l0pKw1D1l8wTiKWjf8ooufnACwDxqSpct1nHCfJabYH/YxXOcVrRaUDsnJo?=
 =?us-ascii?Q?WO5ife5j2fe6YkHDqTvPVOcmnKy3tGHP4t5HvIhIYvXwitEzQ0dbj+TMTtCs?=
 =?us-ascii?Q?ahPJkG9TA40b0Eo6xE03pnjAne/ll+v9nNjdReQ0aoF27+oExhlAD+wzmcxW?=
 =?us-ascii?Q?1JS4jIC6Wx4zmJg1CEwC0AsdOd7ydrJYkyeBoeI2XaXC/VWbGelYD/ZL0rM0?=
 =?us-ascii?Q?QtfU9ZVaDHHHadHwfNUGOFeC1Tz5rsSsXyQuWAPX2TtI6boDfPF9hUIHy47h?=
 =?us-ascii?Q?aVKZyVjp2ADqg8zm3I9hsk+svq9t8kcgikNxWTR7NKs/WBNEL53Zs56ri+KX?=
 =?us-ascii?Q?wUUR0y1dQGh0LBKeY9THQsff9GRHATBnscuE1ukslO035wijx8h5yd94hpk7?=
 =?us-ascii?Q?crjzt4GCtdn7l5068az7B3PQUEvciU0CW3kXZ5eovTizbQkwUZe/16raTf7h?=
 =?us-ascii?Q?0eFjdZYf+N+xdzozD7TjEVvP7WQeosD2vdY8Mdhuv+540UdNQhHUY6+dFJVO?=
 =?us-ascii?Q?9G3KTe+38KNOhGYSy7BpHMm4RYn5kkX5WlCMxAfDz9itw2DNPAI/tuL+CZ5i?=
 =?us-ascii?Q?ZlHydySrBFdb+vj4iBIjbnjBmImP190NKgZc4Z9LLT10FLTKxIQulVenuwMp?=
 =?us-ascii?Q?NGIiwIv6O/nPEdiRDxVi7FKc0ZosDcI9K3CMmyktGJsN9ZEwTvtCm5EawfAv?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c44b152-8c93-46a8-0f85-08dca6d3712d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 02:43:44.8415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sarMJwGqEOrlSV2vHrq6YQxOGtmxA3L+ohhbcuX8CA5ay7Aey8Wn5Bv5UXjYQ2m8c4N70hPSQe/xBXuHay9nzbAH9HvgK60JaB9HOjlHdZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7296
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> The kernel already caches certificate chains retrieved from a device
> upon authentication.  Expose them in "slot[0-7]" files in sysfs for
> examination by user space.
> 
> As noted in the ABI documentation, the "slot[0-7]" files always have a
> file size of 65535 bytes (the maximum size of a certificate chain per
> SPDM 1.0.0 table 18), even if the certificate chain in the slot is
> actually smaller.  Although it would be possible to use the certifiate
> chain's actual size as the file size, doing so would require a separate
> struct attribute_group for each device, which would occupy additional
> memory.
> 
> Slots are visible in sysfs even if they're currently unprovisioned
> because a future commit will add support for certificate provisioning
> by writing to the "slot[0-7]" files.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  Documentation/ABI/testing/sysfs-devices-spdm | 49 ++++++++++++
>  drivers/pci/pci-sysfs.c                      |  1 +
>  include/linux/spdm.h                         |  1 +
>  lib/spdm/req-authenticate.c                  | 30 +++++++-
>  lib/spdm/req-sysfs.c                         | 80 ++++++++++++++++++++
>  lib/spdm/spdm.h                              |  3 +
>  6 files changed, 163 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-spdm b/Documentation/ABI/testing/sysfs-devices-spdm
> index 2d6e5d513231..ed61405770d6 100644
> --- a/Documentation/ABI/testing/sysfs-devices-spdm
> +++ b/Documentation/ABI/testing/sysfs-devices-spdm
> @@ -29,3 +29,52 @@ Description:
>  		The reason why authentication support could not be determined
>  		is apparent from "dmesg".  To re-probe authentication support
>  		of PCI devices, exercise the "remove" and "rescan" attributes.
> +
> +
> +What:		/sys/devices/.../certificates/
> +What:		/sys/devices/.../certificates/slot[0-7]
> +Date:		June 2024
> +Contact:	Lukas Wunner <lukas@wunner.de>
> +Description:
> +		The "certificates" directory provides access to the certificate
> +		chains contained in the up to 8 slots of a device.
> +
> +		A certificate chain is the concatenation of one or more ASN.1
> +		DER-encoded X.509 v3 certificates (SPDM 1.0.0 sec 4.9.2.1).
> +		It can be examined as follows::
> +
> +		 # openssl storeutl -text certificates/slot0
> +
> +		A common use case is to add the first certificate in a chain
> +		to the keyring of trusted root certificates (".cma" in this
> +		example) after comparing its fingerprint to the one provided
> +		by the device manufacturer::
> +
> +		 # openssl x509 -in certificates/slot0 -fingerprint -nocert
> +		 # openssl x509 -in certificates/slot0 -outform DER | \
> +		   keyctl padd asymmetric "" %:.cma
> +		 # echo re > authenticated
> +
> +		The file size of each slot is always 65535 bytes (the maximum
> +		size of a certificate chain per SPDM 1.0.0 table 18), even if
> +		the certificate chain in the slot is actually smaller.
> +
> +		Unprovisioned slots are represented as empty files.
> +
> +		Unsupported slots (introduced by SPDM 1.3 margin no 366) are
> +		not visible.  If the device only supports SPDM version 1.2 or
> +		earlier, all 8 slots are assumed to be supported and therefore
> +		visible.
> +
> +		The kernel learns which slots are supported when authenticating
> +		the device for the first time.  Hence, no slots are visible
> +		until at least one authentication attempt has been performed.
> +
> +		SPDM doesn't support on-demand retrieval of certificate chains,
> +		so the kernel caches them when (re-)authenticating the device.
> +		SPDM allows provisioning slots behind the kernel's back by
> +		sending a SET_CERTIFICATE request through a different transport
> +		(e.g. via MCTP from a Baseboard Management Controller).
> +		SPDM does not specify how to notify the kernel of such events,
> +		so unless reauthentication is manually initiated to update the
> +		kernel's cache, the "slot[0-7]" files may contain stale data.


> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index d9e467cbec6e..a85388211104 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1664,6 +1664,7 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>  #endif
>  #ifdef CONFIG_PCI_CMA
>  	&spdm_attr_group,
> +	&spdm_certificates_group,
>  #endif
>  	NULL,
>  };
> diff --git a/include/linux/spdm.h b/include/linux/spdm.h
> index 9835a3202a0e..97c7d4feab76 100644
> --- a/include/linux/spdm.h
> +++ b/include/linux/spdm.h
> @@ -35,5 +35,6 @@ int spdm_authenticate(struct spdm_state *spdm_state);
>  void spdm_destroy(struct spdm_state *spdm_state);
>  
>  extern const struct attribute_group spdm_attr_group;
> +extern const struct attribute_group spdm_certificates_group;
>  
>  #endif
> diff --git a/lib/spdm/req-authenticate.c b/lib/spdm/req-authenticate.c
> index 90f7a7f2629c..1f701d07ad46 100644
> --- a/lib/spdm/req-authenticate.c
> +++ b/lib/spdm/req-authenticate.c
> @@ -14,6 +14,7 @@
>  #include "spdm.h"
>  
>  #include <linux/dev_printk.h>
> +#include <linux/device.h>
>  #include <linux/key.h>
>  #include <linux/random.h>
>  
> @@ -288,9 +289,9 @@ static int spdm_get_digests(struct spdm_state *spdm_state)
>  	struct spdm_get_digests_req *req = spdm_state->transcript_end;
>  	struct spdm_get_digests_rsp *rsp;
>  	unsigned long deprovisioned_slots;
> +	u8 slot, supported_slots;
>  	int rc, length;
>  	size_t rsp_sz;
> -	u8 slot;
>  
>  	*req = (struct spdm_get_digests_req) {
>  		.code = SPDM_GET_DIGESTS,
> @@ -338,6 +339,33 @@ static int spdm_get_digests(struct spdm_state *spdm_state)
>  		return -EPROTO;
>  	}
>  
> +	/*
> +	 * If a bit is set in ProvisionedSlotMask, the corresponding bit in
> +	 * SupportedSlotMask shall also be set (SPDM 1.3.0 table 35).
> +	 */
> +	if (spdm_state->version >= 0x13 && rsp->param2 & ~rsp->param1) {
> +		dev_err(spdm_state->dev, "Malformed digests response\n");
> +		return -EPROTO;
> +	}
> +
> +	if (spdm_state->version >= 0x13)
> +		supported_slots = rsp->param1;
> +	else
> +		supported_slots = GENMASK(7, 0);
> +
> +	if (spdm_state->supported_slots != supported_slots) {
> +		spdm_state->supported_slots = supported_slots;
> +
> +		if (device_is_registered(spdm_state->dev)) {
> +			rc = sysfs_update_group(&spdm_state->dev->kobj,
> +						&spdm_certificates_group);
> +			if (rc)
> +				dev_err(spdm_state->dev,
> +					"Cannot update certificates in sysfs: "
> +					"%d\n", rc);
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/lib/spdm/req-sysfs.c b/lib/spdm/req-sysfs.c
> index 9bbed7abc153..afba3c5a2e8f 100644
> --- a/lib/spdm/req-sysfs.c
> +++ b/lib/spdm/req-sysfs.c
> @@ -93,3 +93,83 @@ const struct attribute_group spdm_attr_group = {
>  	.attrs = spdm_attrs,
>  	.is_visible = spdm_attrs_are_visible,
>  };
> +
> +/* certificates attributes */
> +
> +static umode_t spdm_certificates_are_visible(struct kobject *kobj,
> +					     struct bin_attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct spdm_state *spdm_state = dev_to_spdm_state(dev);
> +	u8 slot = a->attr.name[4] - '0';

This is clever, but the @n parameter already conveys the index.

> +
> +	if (IS_ERR_OR_NULL(spdm_state))
> +		return SYSFS_GROUP_INVISIBLE;
> +
> +	if (!(spdm_state->supported_slots & BIT(slot)))
> +		return 0;
> +
> +	return a->attr.mode;
> +}
> +
> +static ssize_t spdm_cert_read(struct file *file, struct kobject *kobj,
> +			      struct bin_attribute *a, char *buf, loff_t off,
> +			      size_t count)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct spdm_state *spdm_state = dev_to_spdm_state(dev);
> +	u8 slot = a->attr.name[4] - '0';

Similar comment on cleverness, I will note that the way this is
typically handled is something like this which is just slightly less
error prone if someone in the future changes the naming scheme.

#define CERT_ATTR(n) \
static ssize_t slot##n##_show(struct file *file, struct kobject *kobj, \
                              struct bin_attribute *a, char *buf, loff_t off, \
                              size_t count) \
{ \
	return spdm_cert_read(kobj_to_dev(kobj), buf, off, count, (n)); \
} \
static BIN_ATTR_RO(slot##n);


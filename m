Return-Path: <linux-pci+bounces-21867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB27A3D029
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 04:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D2167A5EB6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 03:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46581C6FF0;
	Thu, 20 Feb 2025 03:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zmt7O13d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A1286291
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 03:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740023962; cv=fail; b=PRT7j+wf9T2aSJwq0qr0ed2IxuUvbs4wuk3LmCWgjyxIqyl7xzBpYorGpttScrUYPVIbSFrvf92LJM0K/REyTcQW8u7pVWTBcS4mfALvK09AOLU7hVGXcx4iJD1VpMyX/GLw9vRRn2BleoU/cVZTN9sUR12ORT4Grs7zm1kzgwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740023962; c=relaxed/simple;
	bh=YkzI0udb+vhRuJVpj/7r9YXE2ra+lGtgT7cfUyGL/fU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fNx2UzoJQRRn7BzCqZ5NdAXHbNWpjZgrejYHbdpnR59sQTDfNewMYDy2VvX7mwghX/GO1uFD+DcnQI5tSUyIOmuiMQsLQ7axYee6+P5/PTthU27W1nBOisk+8SjIWM7PeKILm4Fyfb7P412no9V5NCaRjjTrGY9p/LP8HWN21XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zmt7O13d; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740023961; x=1771559961;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YkzI0udb+vhRuJVpj/7r9YXE2ra+lGtgT7cfUyGL/fU=;
  b=Zmt7O13d8Ym7Mj1f9JgvpQkz7wO/a3nja1nYQjBObLAwjT97esrR2/Ds
   o7UkGiSMl2WllfODPxdPib9OwT8YOehIyXQ64jQem8yt9IarNej2EGX32
   YtpftRcwQ+wftZwfJ/SHTDCWmwBuwReXlt8GUJkRzGjFxhSWImogD54C+
   ByDG9cWD+LcgYkE/tNT/qdVCUxnSu1gmAJe6//6VSohugq1ZL+daPauIS
   Pa/NgRJh4IVYbY3UEonJTi5+AStAyIe5yLEsT9AYguup+xorOcTQwMote
   qaVPZmF19on9I1XZJRahdg2qVYBzfOgqRNsBoT4Rt2B8OCkARrgpPi4yF
   A==;
X-CSE-ConnectionGUID: ODXFUf/CSL6Ca5MxzHQoWw==
X-CSE-MsgGUID: 01vHWKHGQTeBYnZo14oIkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52220920"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52220920"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:59:21 -0800
X-CSE-ConnectionGUID: d7Q7aHIFQAmpGOVvSPfWqg==
X-CSE-MsgGUID: l0242j9+TqOgNFUoYKs9Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115399363"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:59:21 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 19:59:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 19:59:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 19:59:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTXr2Vtz2qlVdcxPMvjXylkp/LKbdod9BIYvGPNyrKvcVr6DVAHH5eGK1YNB+OH8NKJZ7NTVCu1DYtOy0j4D4fw66y5VJrvTwue60ZGcXiemdY5UFJPZS5PRaOy2MXJYfKSi+6XUreogDsdDk3BdByNSUfAwQyBHdWRuOqTmX3DVIx953Hf2vskR78BVpPDMWM78NzrRCZfbVphYV+hEbntgnqN0xIp7EeiVFUx27asj8U0YAqTYBX+1O/M5M8vcXnsRiTRtXp6tCRM7UPUImaYqm2oVBCH8IoleNdwRak8dxHLCkL9dcsWQ2m/iAbr0AkGB47/U1u1ad8TcB/Ryjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWtorQenjTKmoenfNaaQysGX4VUAF8A1ZmA/E7vUjUQ=;
 b=ElS5oRvnf+SHAP23SEQ5rOCxoJk0NOBY7cK09Q7utJ3LzIoN6+U0NptUwSVpkAwBiQzb48CfbklI8tpSkCmMqjQiOa6y4O+MSHf+BvgC0tbIyTEna0TXTvP6QMYKHj5u2B5YQoe2e4MjVpOiA2zkxL9Ceuw8pdRrTuoz24BVH6r9PRgRS25/LXDjJnVwCQfZgy5DtkskAIJDvBkwZqMLJR5rJlMne25+cQU8KH6Ratm4PLr3dxHy4w0whsLUo+H50u2jrUdpEtxRfyEZbxGsKCHRF1C91wKO7a1kE9iIhw49kMKhqDmGLzNsBQxhtU19UcwKGkWRrv/q0IO7Nid2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6905.namprd11.prod.outlook.com (2603:10b6:510:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 03:59:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 03:59:18 +0000
Date: Wed, 19 Feb 2025 19:59:15 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: <linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Message-ID: <67b6a893b004b_2d2c29412@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
 <4a50bcf4-89d0-466b-a27d-6036882e5fc3@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4a50bcf4-89d0-466b-a27d-6036882e5fc3@amd.com>
X-ClientProxiedBy: MW4PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:303:b9::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c4ffe7-df3d-4f18-9a4f-08dd5162f2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nhOp0U26684l976OFt4gPqmRZ+PPcE3LcHuB2CN5ytIJt7tl44G7tUp/SKS/?=
 =?us-ascii?Q?oV+gCnmgYr20uVO/WLx5Sagxc8+cT49z8oHYTCTOcAFBRA0Hp251SbyvEx0e?=
 =?us-ascii?Q?fwGgql2nSTI42nlHEmg4ng90FfjGXeR5sinNwEwT860WCjIb9o+MB6zxtLiA?=
 =?us-ascii?Q?aDOSmBXzEUdaa/j3m03FnKC12ULdgC9e9DKu7sk7pJifDLbw7HsFdwi16ckQ?=
 =?us-ascii?Q?9C8B5CE25c4v90ESDn4STzvCi1sAyrADzQhJSy3Sj/90V5b4T3aJmBeBc5QF?=
 =?us-ascii?Q?IZ4HHccoxuMLnZpcYqltEAvkfXtRvG9X7HFwKyHdPfwg767VsUz2pxNVGpYM?=
 =?us-ascii?Q?wmCNZal+Fsa2kIfsuoiVsHmcPGhGpnzVI9AQQAhoaTUyhEvOWyZdcz17OvxU?=
 =?us-ascii?Q?zUtVgLbVK90EDpmmYOzUg53kvzuiR5/WCQ6lvNDG6dzz+hPnn9UqGunfIxyk?=
 =?us-ascii?Q?z3t300YAbFs5HL11eoCpqPNZTqrL/tLcWflnaqekNi4Q1XjQxnpsSWo+L2VN?=
 =?us-ascii?Q?oz6gEloXqGjRgT0C7It6fOyG9yuG92Ext/hC8wRqx9ogIoAFyrEu+pOn6XKb?=
 =?us-ascii?Q?uzjItjN7WwHppmypN0DxQTJ+yHN0C0y8D3/T//1XP9Tr30OimsgfmViueBo4?=
 =?us-ascii?Q?JkLFGbHJYne2Q93iE4At9mmETa296YQNGn9wXKfZAgZuis044NksU9Yvxu9E?=
 =?us-ascii?Q?gxe7++9oN1Z5+AV99t34Ge6f2KzXuTQ7a2+cjoQVBcK27D51gNa1T/BCydp+?=
 =?us-ascii?Q?9YDL7DpGCXPfXXKlEd0OFU7WpoWSfA301fp3pyEUa8YG6A2icsC4hOas+sT7?=
 =?us-ascii?Q?Bkz/oEl/RIZ7n4dEeKy3bH7+Xz9sRSXfiEnFmTVeeuGu34VAd4CyeRUbS6d2?=
 =?us-ascii?Q?Htju+PJKCJA9rtloYC226XCigsUQLBEVSi8+Rf1U6CIqjUnT9VbsUOVl5iEQ?=
 =?us-ascii?Q?evxdHfWJ9UvrfPqQ62JMT+4hH8kTuxLLH/8pCA8sHgyJJM3Ag1jXU5r1L6pG?=
 =?us-ascii?Q?tz14MyTqcTKP5Fbc0zfJ9KcmqydeS+G/sDb0mDCbq6EyEbx7ieHMrEAeK9hS?=
 =?us-ascii?Q?6sEkUNUr35t102He6QBP6bxu1GtDt4jZPlw6lIipyLBAAmEbB0OXtiuQNdlc?=
 =?us-ascii?Q?G93ej+BxU6ciUWFYVScUUqpz5dC5oKeoBaLOuM+XMwrcaWgRnnbVbpUA4tv+?=
 =?us-ascii?Q?zcqrgMEYy+EGI+5UFIJFKgVTLCs9fGbLGYaTr/LMdjWFGYk9GZKo1ZS0z8oA?=
 =?us-ascii?Q?IdrHktZgTARNGM0WiolWBjmHQYUBLHsYfsCy7qyzheuiKAzZtZD3OHb73dqq?=
 =?us-ascii?Q?H9jgXlc2+eIqlGGLuoORHTmlE5zeWZi8G0pkQj0Ch0kOnq0sOgY0PeZyM57L?=
 =?us-ascii?Q?3lAiIYHyajroB/D0FJo+lsmzirkZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K591oy/Pg4upV/wcZGV7BAgt91NWgE+1fAKeogWFvhaicEKjV3nOwRc3tUWq?=
 =?us-ascii?Q?X1aQEouaoo9/OgG6SgMQXXbdB235KHoILQVlrclep498bUMRovZxm3kpiWG6?=
 =?us-ascii?Q?duHTpZ7h0X1PNqZoTR9p8z2e3Je+km5KGX0t0QyL15pRVhGg/sMzWW/A530b?=
 =?us-ascii?Q?kVXax2ecdic+mRA9p0Vx1Hsdlgrjx4ncjurIP/CeyquGnPMrxt9pZfQQmsRQ?=
 =?us-ascii?Q?cOxuOYptfbcAYXb8hK5F5EGkxCwA3yG8U+tzDYj57BUcAShgiRP7yHf+SVo4?=
 =?us-ascii?Q?WTcvzl3bCxNOzti0axffVe0uVnjVvtwa5UW9OACwdsKq4wql2AtPI1lvDfbt?=
 =?us-ascii?Q?mmDfFnuFBbAayBFWFAsIIRZUpDJ4xCnE4wZRTRtYKrHKQu+dlk7lhvhixO8C?=
 =?us-ascii?Q?TMQzwAQacKjdYhrB+moRwtCCIHST27Xb7shhKUZDL3WI4CaTMybNCghyXrux?=
 =?us-ascii?Q?jYxgQxGaXHtf645+z58u3Ca6i8Zk6j9tSQUr+lTkY8VbykvvWeOEdfcDivWF?=
 =?us-ascii?Q?veEyTqyON5rg7hwwHuRXwe/miY2Db+kCwxAVlMZsAkI7nabPCL2qvENZIkUZ?=
 =?us-ascii?Q?WXt5mnZhnnFJXc2xn4ZigQ3v8V+OcaEJnbgHkHW0T4tefeBmO6rKgfzwS77A?=
 =?us-ascii?Q?9oIqJbwZNaxt6qoAaVEFxDQx2n/xuzPvNkkiYeUwhTvv+rWWuX/Oq+/Rr1tZ?=
 =?us-ascii?Q?XBguQf4VAP4pUpT8hVuwTd2Pms/zDnndhNi/lLpjlXuyQC7PV/CaUhmemA2C?=
 =?us-ascii?Q?+xRJy88jOtdrQ1gn5Y4kS1lHFzTr/T9VY44kiYunV+nnYIKcYF0i6T3hDgBS?=
 =?us-ascii?Q?hlbik1liFeMgaMMeLEff3+n8E7F5OJEp3HylQSxX5TuraetaiABdbnuFTDBW?=
 =?us-ascii?Q?Ddyw3GvjU22n8dsvOP4eZwvSu3NTo+dm6giqnlxPecPtt8Wr1R/WImeV/7GA?=
 =?us-ascii?Q?/0VV5ht5KbLlmdkbctEKSlU9tSjZl6XqvG5EtvUZV0NWljsmsVeKN80s1O9C?=
 =?us-ascii?Q?Fvzm2yuB1VpBnluq1KRqhYkEuHr17Yo18nYova34Vp8YHj4uDyZPxkqM4VIB?=
 =?us-ascii?Q?urG3+8bOeVgBnud/oxyu7ngV+HgEnLgInBmR4Gr4Opow268didJ8y8g4u5xR?=
 =?us-ascii?Q?JEcnFbWHGAg6fFH4giLaoSVcEYh2zGmfhNDg2N/mawGxd8UiA5BAkVFcYFI0?=
 =?us-ascii?Q?tf7qUr90D4xG68BtjbPoUIIR5ibLe8YheRlu5xw6REzf0ElFw45II27YmjKE?=
 =?us-ascii?Q?hbLD6W97V3l/slTOHFZj4Kn3TzzVozu/FBFV99jMl/CPZFXItO4L8gqKkbnx?=
 =?us-ascii?Q?EU2ks4gUHDFP7cgaM47In+Yd+DP56/7IWWA0qVi5Y9734TTI+Udy1Z/pFWdD?=
 =?us-ascii?Q?Gt1V1wRp9HNYQqXSrRDLRpCd+Jf7aBbJxA5bz+08C5u90PtuIP1hNdQ7jQC+?=
 =?us-ascii?Q?3oPP9PYIDngafOQfnyDh/zGHImmXl4+SGEDBZZBjmlr1zm9By0jBxXaGn7xT?=
 =?us-ascii?Q?R8dzXWjLEeXfegyoESScOxyVGburG+I5OEDMZ7UBngFBOxpAgLd4fTpUExIH?=
 =?us-ascii?Q?M7ODJCpTcNWP2eAkxB+Kc351fLvLlgsVfinNWMzzIS3r9SY07LgM6Monhr2t?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c4ffe7-df3d-4f18-9a4f-08dd5162f2dd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 03:59:18.0802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yd6MjHGeVRTDh0Y/n/Q7eXcaBYyb8v8zywskAP5Rkhr/Dg1PrGc4UDwZfwcM+/zA1C6JDCyrjF5jBMX97rNf3kRWGi3bxK3Y5LozLZ+W3WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6905
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> On 6/12/24 09:23, Dan Williams wrote:
> > Link encryption is a new PCIe capability defined by "PCIe 6.2 section
> > 6.33 Integrity & Data Encryption (IDE)". While it is a standalone port
> > and endpoint capability, it is also a building block for device security
> > defined by "PCIe 6.2 section 11 TEE Device Interface Security Protocol
> > (TDISP)". That protocol coordinates device security setup between the
> > platform TSM (TEE Security Manager) and device DSM (Device Security
> > Manager). While the platform TSM can allocate resources like stream-ids
> > and manage keys, it still requires system software to manage the IDE
> > capability register block.
> > 
> > Add register definitions and basic enumeration for a "selective-stream"
> > IDE capability, a follow on change will select the new CONFIG_PCI_IDE
> > symbol. Note that while the IDE specifications defines both a
> > point-to-point "Link" stream and a root-port-to-endpoint "Selective"
> > stream, only "Selective" is considered for now for platform TSM
> > coordination.
> > 
> > Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> > Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[..]
> > +void pci_ide_init(struct pci_dev *pdev)
> > +{
> > +	u16 ide_cap, sel_ide_cap;
> > +	int nr_ide_mem = 0;
> > +	u32 val = 0;
> > +
> > +	if (!pci_is_pcie(pdev))
> > +		return;
> > +
> > +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> > +	if (!ide_cap)
> > +		return;
> > +
> > +	/*
> > +	 * Check for selective stream capability from endpoint to root-port, and
> > +	 * require consistent number of address association blocks
> > +	 */
> > +	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
> > +	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
> > +		return;
> > +
> > +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
> > +		struct pci_dev *rp = pcie_find_root_port(pdev);
> > +
> > +		if (!rp->ide_cap)
> > +			return;
> > +	}
> > +
> > +	if (val & PCI_IDE_CAP_LINK)
> > +		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM +
> > +			      (PCI_IDE_CAP_LINK_TC_NUM(val) + 1) *
> > +				      PCI_IDE_LINK_BLOCK_SIZE;
> > +	else
> > +		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM;
> > +
> > +	for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val); i++) {
> > +		if (i == 0) {
> > +			pci_read_config_dword(pdev, sel_ide_cap, &val);
> > +			nr_ide_mem = PCI_IDE_SEL_CAP_ASSOC_NUM(val);
> > +		} else {
> > +			int offset = sel_ide_offset(sel_ide_cap, i, nr_ide_mem);
> > +
> > +			pci_read_config_dword(pdev, offset, &val);
> > +
> > +			/*
> > +			 * lets not entertain devices that do not have a
> > +			 * constant number of address association blocks
> 
> But why? It is quite easy to support those. Yeah, won't be able to cache 
> nr_ide_mem and will have to read more configspace but a specific 
> selected stream offset can live in pci_ide from 8/11. Thanks,

Specifications often add flexibility without concern for the system
software complexity it implies. I am happy to change it as soon as there
is the first sign of evidence someone might build such a thing, but
otherwise it makes walking this register space simpler. It is not clear
to me that there is an economic reason to build a device with variable
amount of address association per stream block.

Also, apologies for letting this patch set so long, I have finally
cleared some other backlog.


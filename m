Return-Path: <linux-pci+bounces-10331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6A0931D52
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 00:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FD71C2144A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 22:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCEF13C816;
	Mon, 15 Jul 2024 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4FkSEIC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68873BBC2;
	Mon, 15 Jul 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721083840; cv=fail; b=PS3kJS43E7KLhH6MHqsnaryS/QmQMOvSXDsu00MBs1wtzKh9zmJ9LuCbcK8qRP3q8UwtWjB3nrlP76NaYUkRsAFG9+PvUrXTexS8Dim9vusM0CgUayg+sxq7vjDt8ufm9PacWjhRyjKWnVG/rN3xjG2ou0bw7Cb0OF4I3b3bssY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721083840; c=relaxed/simple;
	bh=N7JIC5rzY4mbSQe5EV0+S6d/C0I4AgaOtl6mafuWG74=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gIwDJEJn80yuGPLGJaKEhgAAXUbapg5T3oNBx4W1i6qLMPr5XEgq9mNPvFqKQFxtTxW2+7C3z8NvTiDotfO1rRlriIELvAvZQDUPFkT8/RgtedN+3q5Pd6fj6I9CzFsr4ZPk6+4TU1M/IbmNlplOu0M6EGL0vLrs2597Hcmh8Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4FkSEIC; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721083839; x=1752619839;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N7JIC5rzY4mbSQe5EV0+S6d/C0I4AgaOtl6mafuWG74=;
  b=T4FkSEICtuwYAqDBCKW1A8kOTeKqVMvjwFyqhhflI2V7TJWvT6pBuHoE
   P5XbnxR/dxShn7tA9Zn1YY7AWWs2lrAaO3PUisIPj8ZV6SI4XMMyUpoAA
   FW4PssU0b4O/0AoTKNT1hvT79CIi1jFG8seYTRGkh7o8rbO2QkJVVL5vM
   a33cM3GQBwveCUNOP5Qz/4JFMp2NCKlxcHZH6uBOWYr+gzK8hFvcE+wZz
   FSCI3ATqzmlVQVSxselI1yQmX+mbvudYP3/xnGT1/Jr2qCRdzkg9lcKrS
   kyjtW1kXznJYzzhA8KH36QfkLkshHD2bsuhBlOJ2vFb2T7tuV2AKVAUqp
   w==;
X-CSE-ConnectionGUID: SQohW0JPR1SWHf4ngEPLCw==
X-CSE-MsgGUID: Ch3c/vQiRkK3XcalmCeHpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="29640481"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="29640481"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 15:50:39 -0700
X-CSE-ConnectionGUID: LXyFzG5URJe30Y9ONgNtMg==
X-CSE-MsgGUID: zo2B3GAtTkG4MkKYsB6/jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="87280456"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 15:50:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 15:50:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 15:50:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 15:50:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrXhuFJBV9zw4xuj5WVnHxsHYVSiZR336kaalfPtiTypoXzgFxGiGUtNE4rhJgPrV3JOxH9FLLfZtoX+dzMHKBa/CUKDwcO/Uz6e6crwte3n6dc/zmCleaalSAljWMtR3e1ZNkwS31HoQVBWRaP4iMtU3S1JzejdsexsAfbQXIcX7CVE+//1wbuHJMz3l/h/TmiH9DFDbbPEGw4/63Bp2g2K1Uy11n86wdy9cwn0rVK17fpLD6jCAP8JvrwwOsspvYyqjpv5TKtKLkCRnLwSEyqXk+v62hF6cXXem2bXtz1f0URTVVptuY8YMxmg3r1xReG0ApxWHRFAq42U0ye23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHUx58aBSCbI2I5wQXq8+Dz/Y64fntWmV6N0qC7zLi4=;
 b=TFwoQOmO1tlXXcFrKolOx9G5WtXc87erNg4AgPPbsyX4MI3FdfITupBH5sJfjBgf/q3eOJrISsBZ+sh1wfDT8K3VUV2WWKUQf6NkMzC9eqZ8CWS7Je27sz+YD78807/p+5+zJ1Vda63Xr2pTv1lHQ5nS8DhfHapXlpqWMEaCG4JSjJQTGCGP8L2OeK+9ziE6yLzIYIARebFOajjJtiv0kjWv6Qy6w6O71ylssegFWrssZ5Ogk9AoZjDn14StrS9h04eMMiWHn7hjQrSIaiCWozCB/QkF3I2GE6lKsQtBoA6hKv3fy1929zyQJZ9qxlUfXTR0+nmFaa7FdXT9RlaugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6978.namprd11.prod.outlook.com (2603:10b6:510:206::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Mon, 15 Jul
 2024 22:50:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 22:50:33 +0000
Date: Mon, 15 Jul 2024 15:50:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: Kees Cook <kees@kernel.org>, Lukas Wunner <lukas@wunner.de>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>,
	David Howells <dhowells@redhat.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	"David Woodhouse" <dwmw2@infradead.org>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linuxarm@huawei.com>, David Box <david.e.box@intel.com>, "Li, Ming"
	<ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	"Alistair Francis" <alistair.francis@wdc.com>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>,
	"Gobikrishna Dhanuskodi" <gdhanuskodi@nvidia.com>, Peter Gonda
	<pgonda@google.com>, "Jerome Glisse" <jglisse@google.com>, Sean
 Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel
 Ortiz <sameo@rivosinc.com>, "Jann Horn" <jannh@google.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <6695a7b4a1c14_1bc83294c1@dwillia2-xfh.jf.intel.com.notmuch>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de>
 <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715220206.GV1482543@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240715220206.GV1482543@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0110.namprd04.prod.outlook.com
 (2603:10b6:303:83::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 23367196-e27c-4504-fabd-08dca52088bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RD99e3PIIBT8pz+EWUa79IS7cRTRCtSXptKJBPknmjSu1GkahxWzQjOtPGvy?=
 =?us-ascii?Q?veM//LPcCmnNi4r5qXI+gPiKsX8HqXsD8zJkUYKxjQGktLQ0kLkFk1LL2HCd?=
 =?us-ascii?Q?xsQBy3BCRQeUdlsUHSYykXKLS9WoAVAXmeUjNGz8A8Ua806rd6j5cEXOpSbN?=
 =?us-ascii?Q?zRQwbI5lztUU5IxANmo0C66xicW2BIps6kOIAyded1x3jKB8stvP7/j5aL6c?=
 =?us-ascii?Q?UmKlGGmHZPSz6YWfsmhD/SCLttvIWwpbXeGHkoTMWwIsqFK/sgtDsdZKEelm?=
 =?us-ascii?Q?NFlpN/kAOY2Jr3sMTxWUuf8+OVRU+f1wIN0tfPgmADqzpvy2fMllRV0TGJmP?=
 =?us-ascii?Q?howi8xeMIYB0Waz3ss35LTTBs4huAmMjTCi76qPMnYZTugyy4ASRSVzyBVK9?=
 =?us-ascii?Q?eE16hIHg9Af4LN84/+PglpCPv4wj49rEX5k8shveeU2BhPcmkZJ5eGGChYNs?=
 =?us-ascii?Q?YjEBNf4P/PO88qqjfvg1uBibcKGeaPCJ/Hs4+/HC/6BPTHkP1EA17Un4O2d9?=
 =?us-ascii?Q?ravJ4Pn0LBytXA43oEvrlOJdv9ed3uDOEhAK0y2e4xG2rGIERjhtMqiyPTk1?=
 =?us-ascii?Q?4kr74zCkqlo5hh5ft0dTJt1h+uvxlqaUcHtEJg/IaSqp4blZh1tUQ1w5B0g8?=
 =?us-ascii?Q?4sZmxZUMidHgyrHTr2ODuyY7ttmia3EW6KDpKuItAAac0wypxdZMVh1CIWld?=
 =?us-ascii?Q?4grB4YFJoYA3ff/e6scq78/rpnq5M2Tsp04EibP+L8L/yW5wZLMu1OiIdLVu?=
 =?us-ascii?Q?3yP0stb1DpbrU4BkGTsa5oVqq1Kp2FOycQOpnomFYK9vcOmbPPm7VyEsYKQm?=
 =?us-ascii?Q?waZLBp/IHh2kVWhkZF8lkAxCneMHE8Xh6m3gtMlSt8Drm4CBYJooP00M68LV?=
 =?us-ascii?Q?jozVo1gwmr3sV3HUfabLnW4r+qDrAIzDd0y7uCZDQuBJIa+mp1dHnUY7z2fP?=
 =?us-ascii?Q?k3hdL8hX9dVBvFi/Pr3OGvAnvBTJi3epwh/NUVxq37gkpUCcto0V5PDWenFA?=
 =?us-ascii?Q?It76slyY+rnkB5MSh8hMrKJak4LOUj5CvIHMz+oluq2fuy6pinVLqPZJ7Eto?=
 =?us-ascii?Q?Pt3kypPw2dsw+NxNN862pdA1oEk2X8+asgFmVYXNHzBSbQRjFWHU9uHSMs94?=
 =?us-ascii?Q?wYpXrze8Q18S4V6Sav9mYU+u6GbbQMK6mdpFZHGgdKgmqkwz3psQNtDoExkb?=
 =?us-ascii?Q?gvTglsYq/naLGrvXgrUIlVMAK4Rb+PCkdXMumksjCbBAWhh6yZnbEi/lVc2v?=
 =?us-ascii?Q?MIYbHL/3yoSMIIZoToCZNR7EuDCieU6M7zXnjKT7h6vIl/qpfSdQHvt9UB1W?=
 =?us-ascii?Q?AGjreTcAIb5Hy9g0yluu+L4q2G35iIC2cVumy1OKzaJixg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+NS/QWt+llQvpuhXB9MTwqLYms+6zop0yZAIZFv/N8MjFkIxbBN86cE1uBN3?=
 =?us-ascii?Q?H7sdoS+xu3mwz3XtoGvumgKgAw8yDknjQoW7t1hqjrR82ooV083quIuU1SAQ?=
 =?us-ascii?Q?l7hPMtPUKLKEpfZGBtrnaqILP/5mHDayk/bEL6C9BUU8ADBFPVahqnJeisCK?=
 =?us-ascii?Q?50ZrwzBuqXggA4jz7UJfdpd2jWFSzUUNEWFaWZ3v0pp8Rr8IF5ZmPBqBAWtT?=
 =?us-ascii?Q?eSBx3CdVhTTzMUfT0FOPktvxfCny9Za/zcLlKI6Zc5zPaWmAb7zF6NvUhM9X?=
 =?us-ascii?Q?pDUD0GMUVACsOh4KZhSLN5Ik5/Rty2bce74olZ4sTjlfcZQo6B//5v2XTBPA?=
 =?us-ascii?Q?UA5OVyN8vzUzJDCGlKZpAWyAfhy4PjU6Wg2DcCNopyhXNeZrGBSGtdyRoZV6?=
 =?us-ascii?Q?x4cla1HAicYD5IGED0248mhOnRKBzGoGp1B/TQMEzJKcoPF236NANIfUC+6z?=
 =?us-ascii?Q?wOOOyUX6CWUVVt5UDVnjcgd2M0scBmCL4li4+2J/HUzKj/8vYtqeW5MPlMhh?=
 =?us-ascii?Q?f9Pw7XV6Nbt8milXT0iAJH8x9H8mtQ0hx0FFpufVVDyUNoSppO3Acn/o7e3Z?=
 =?us-ascii?Q?HYE9RbRE6KTLh1S40oGPo8W1F+RKaDsamWFLX9LBfW4My8HGRz/702Hk2L6Z?=
 =?us-ascii?Q?enMsQ0xQ7ZalAMAyIq6O70yGm5Up4+8uPDvYxoXjR1dlnF7tKqx6c/lzYCvH?=
 =?us-ascii?Q?pc1dcKaLjd6YthLn0jyIz0x01H03spBn6SNW5XC69dB0Yt7cHNw/MuYGTQ3l?=
 =?us-ascii?Q?5u4CwKI4evbw9PnwDC3rfqoBKhEF9m+cZajGWKoSDZz/10IXloOjbp9yh8KW?=
 =?us-ascii?Q?afeDqRP8GJS6UqOOS0i+mNw3+bTAQYgIGa5wGaRo58FWXMq8y0HNj4TH8RHa?=
 =?us-ascii?Q?TBn7u9lRoGJoNos0BKc0hi43NqjWM1aG4z5qBchGwh6Dfk6Jr5abi2IjyAkm?=
 =?us-ascii?Q?ldFFhFH4hwqBUPjTU63EhDe04CgRu3bEsRE4SWzPtMaMgtBt4GUz1VSy/Xvn?=
 =?us-ascii?Q?USRjPBA0CZhBr295JJrh9YWA+2f3gfsuA+QAWhi3826LnJTOJ/5n8XuguWKu?=
 =?us-ascii?Q?YiF1zBVIs+0oNyQsr20adD1vrWfpzAE7JHmUrjbADgMEcWEH+agT7rbVUvgc?=
 =?us-ascii?Q?0lE4GwNoaU8oW1UtDOKFGGl8tQpSH+qnNl54JBGvPTS/64GWC7lIUga4jiUM?=
 =?us-ascii?Q?XZP3JI63qwPLx+XOe29ufDmEM1IRsQ2xy8Xk9fXmJpPChmsWSjb7cb0oLDpw?=
 =?us-ascii?Q?LEdxRcX/dhdjYK9/+wfxl0CB6a4vyFtvFUL0vUnWpYB3Tk3Il1l0K0U273vL?=
 =?us-ascii?Q?vyu9QJDBsrvThj88rdYrrnXKYThHxACHwP6ERPeDD8WcFNLMecD2pUHaGzRc?=
 =?us-ascii?Q?NwFB9xT3Vur+/RCKI2zPrEkriJrPe0KNhGhcePWIMFere3zOXblbSoiGt6+Q?=
 =?us-ascii?Q?zIoK9P65L3NGeV7uBbocrEi/Zj0zsVVxzBtKa23uuM96VXSBmxaby7YlRX+P?=
 =?us-ascii?Q?b1huUrDlQAjei32HfBDl3RFUicqfWuTirmJI7PBCoIPMpWlk8oNZV30/08OJ?=
 =?us-ascii?Q?9TP4uynyFFHsD82OjbyfMl4ydGf6xJDsQsyGvQYluiQ6SgsFle4fMviOtoKO?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23367196-e27c-4504-fabd-08dca52088bc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 22:50:33.2853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzZwUCtouFa9bIwwinl4UM5KGLSWQu23mlvAh+yR+1iuNwRCgJGVyZFa5gk1gquoCM4dQyQzhM2A/njXk4nYcxN9Ee1uTzw9jCQ+DTBgju0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6978
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Mon, Jul 15, 2024 at 01:36:32PM -0700, Dan Williams wrote:
> > Jason Gunthorpe wrote:
> > > On Mon, Jul 15, 2024 at 10:21:48AM -0700, Kees Cook wrote:
> > > 
> > > > Anyway, following the threat model, it doesn't seem like half measures
> > > > make any sense. If the threat model is "we cannot trust bus members" and
> > > > authentication is being used to establish trust, then anything else must
> > > > be explicitly excluded. If this can only be done via the described
> > > > firewalling, then that really does seem to be the right choice.
> > > 
> > > There is supposed to be a state machine here, devices start up at VM
> > > time 0 unable to DMA to secure guest memory under any conditions. This
> > > property must be enforced by the trusted platform.
> > > 
> > > Further the trusted plaform is supposed to prevent "replacement"
> > > attacks, so once the VM says it trusts a device it cannot be replaced
> > > with something else.
> > >  
> > > When the guest decides it would like the device to reach secure memory
> > > the trusted platform is part of making that happen.
> > > 
> > > From a kernel and lifecycle perspective we need a bunch of new options
> > > for PCI devices that should be triggered after userspace has had a
> > > look at the device.
> > > 
> > >  - A device is just forbidden from anything using it
> > >  - A device used only with untrusted memory
> > >  - A device is usable with trusted memory
> > > 
> > > IMHO this determination needs to be made before the device driver is
> > > bound.
> > 
> > Yes, and it depends on the device. Some devices should be filtered
> > early, some devices need to be operated against untrusted memory just
> > to get to the point where they can complete the acceptance flow into the
> > TCB.
> 
> Operating a device with both trusted and untrusted iommu
> configurations is complex to manage and depends on how the trusted
> iommu HW works.

Yes, especially if there are ongoing memory conversions.

> > The motivation for the security policy is "there is trusted memory to
> > protect". Absent trusted memory, the status quo for the device-driver
> > model applies.
> 
> From what I can see on some platforms/configurations if the device is
> trusted capable then it MUST only issue trusted DMA as that is the
> only IO translation that will work.

Given that PCI defines that devices can fall out of "trusted capable"
mode that implies there needs to be an error recovery path. For at least
the platforms I am looking at (SEV, TDX, COVE) a "convert device to
private operation" step is a possibility after the TVM is already
running. Are you implying that this platform in question would need to
shutdown the TVM and start over if, for example, the encrypted link
state bounced?

Or maybe device capability conversions are effectively "replug" events
on such a host?

> Meaning the decision to operate a device as trusted or not really has
> to be done before any driver is probed and probably needs to involve
> the iommu layer to try and do something about this mess in some way.

Yes, userspace needs to be able to deploy device-attestation policy
prior to driver attach.

> I have yet to see a complete plan for how these details should work :)

There are so many details that I find myself needing to land basic
infrastructure upstream to bound the possibility space.

> And I only know in detail how the iommu works for one platform, not
> the others, so I don't know how prevalent these concerns are..

I think it is an important concern. Even if there is a dynamic "convert
device to private" capability, there is a question about what happens to
ongoing page conversions. Simultaneous untrusted / trusted memory access
may end up being something devices want, but not all host platforms can
offer.


Return-Path: <linux-pci+bounces-10342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C745931E70
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 03:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD481C22120
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 01:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F08463D0;
	Tue, 16 Jul 2024 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtfpO+OG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29BC4A1D;
	Tue, 16 Jul 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721093002; cv=fail; b=Ffak1PJSo9/t6jZT3yNY5156J5dLw/hnfmQ7jSA88lk30lwGcQVrFi8t0QoONGz2PaqQ9ZwYIWGUq91NSjnMW9fwqzG+JG5+xqB2p3jUxHQadbzb+n5WCmApYNJx1F53XkCxhxlIBb83TRjih5saRf44fpNfMVNSyZWURTG9PLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721093002; c=relaxed/simple;
	bh=e503xErVD5+0yLbOCaW3uCbcQ/GWFyxg3tgrGnSVwI8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eJiN637TyYcSAONIRqCytPxpHWbcPjk4hX5ryYhhKhXba5aY2HEpiNMcUJuEejNDjdXCRB+I8i045IubaTFzkeqRvBE1BJDKqWfD5OlJR8WlsRxPV47sZoYwDvjqZ/YHmXgAY5iY58MuzfA7PTvnoIS0CtrUFYBjxfxPxQx69BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtfpO+OG; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721093001; x=1752629001;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e503xErVD5+0yLbOCaW3uCbcQ/GWFyxg3tgrGnSVwI8=;
  b=mtfpO+OG80SPB7ht1JdpQdwM7jj/foQrTEkZ2MiHEaXQWej8390VOTMh
   CBb6OhXt08RdE/bN1yjK7seoZZ/j9FLvbx+OOdER5jrMuud/pDR4/vtmH
   PncWpmvv/Z6mZKYVQTydw5uErv6g2sVQv2BQRIXIddkYP3LbyXf4wf3SS
   Co81G74NV1VW4Ay3bEgvHP8NM/cJdhApjFyJh65ehgMhWAB5MIOHIzMWq
   TjkSEOKaJp/hfdk9f1jI3GQzHmIvLGdrk4+nzGrClxaKgCVkmhMxMnOK5
   8BwmP8q35frfbgXH0HwN6TJR1+PjllZtx7f7+rmfzqMgV6P9/nVu/klT3
   A==;
X-CSE-ConnectionGUID: eUUix+bHR6iaW2mEbYDGNg==
X-CSE-MsgGUID: XDM8g4N5S02iZKGp35SLmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="29655299"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="29655299"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 18:23:20 -0700
X-CSE-ConnectionGUID: Y9eT8BoERpCjMgOtqN6A5g==
X-CSE-MsgGUID: FcKmoOS1SeqFG1E0x9f6/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="54987443"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 18:23:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 18:23:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 18:23:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 18:23:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1CTIPeNnqrbtqxzPrcZk2YZEpsWNykPBijOy9Gu0EfzT0De2BvNgwRyX3rp2wqJYuG0Fzr4J5O3+vXTE1B+Bd+OLMot0/+e6GL5rTiP7134fpHDCRY2vzTxzO64By9tVwcO1IGss1rIwgHYVaSEwiE8c3rN795qEdyIwBgvQTYxScv+AH3glqAjo3KToP66CZjJSIuQU+7Dny/VSrF9SFwe2bl5Wks0CoSmK/TVOk+3LLHYD/bJWFj/8QIc5PSL02gDFd40N/hq/RuwipIt6K6/XIEMDirCmt35x4ZFJ4rzzjkB1asQA8O/bvLqE7zapgPy8w3mGDXLJEzo4ylXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t2H/XaTJ99uEun5I1WevgZMbg1+NyZiDEZmZJetjz8=;
 b=xWnOBAx76Wd7jzhlGvWqmWf+i9IKLwQkrwlp5uPxyjCXeIZm+/ZvpjaHyHYvBOwbQUIibXghHJ72otGy3zSRzClA7zuzCvFb/yS/Ak7c5KH5Aen0ZnGeCmP73IzU93fsKZCLRDvkgqKl1SKEuaXw+hE7Ec4ADSPFbhZdCf1csH4uj4Na6koKZV0M1NCw7A/baA+hafm+KViBSqds8tVJDrAIRJXSGhjsMO8GCv3Mm0PkrJCsHXlZXQqiyDt9I5mVOaFRQNZgz3tpAW0L3KsbBbAzGYJ9tGxSSZAeMJMl7LyVqoIo+DaRKFEaOpei/P9mZLRoNqBNVYlPyGu6PQREcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7941.namprd11.prod.outlook.com (2603:10b6:208:3ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 01:23:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 01:23:15 +0000
Date: Mon, 15 Jul 2024 18:23:10 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, Kees Cook <kees@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, "David
 Howells" <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, David Woodhouse
	<dwmw2@infradead.org>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linuxarm@huawei.com>, David Box <david.e.box@intel.com>, "Li, Ming"
	<ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	"Alistair Francis" <alistair.francis@wdc.com>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani
	<dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, "Sean
 Christopherson" <seanjc@google.com>, Alexander Graf <graf@amazon.com>,
	"Samuel Ortiz" <sameo@rivosinc.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <6695cb7eb7bc1_8f74d29483@dwillia2-xfh.jf.intel.com.notmuch>
References: <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715220206.GV1482543@nvidia.com>
 <57791455-5c70-4ede-97d9-d5784eef7abe@kernel.org>
 <20240715230333.GX1482543@nvidia.com>
 <f228526a-984f-4754-8ade-3f998a8b436a@kernel.org>
 <20240715234259.GZ1482543@nvidia.com>
 <5f7fca8b-ab74-4fba-8df8-152ad6f94227@kernel.org>
 <20240716001142.GB1482543@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240716001142.GB1482543@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:303:6a::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 935d422b-2055-405c-763f-08dca535dd89
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iUp2WjNbRSuk71RdOKjF0MjVxEMjpAvQo3HLXcaNUHvGzTUv1c+2B3TStVa4?=
 =?us-ascii?Q?f8EU3757UzZi6uCFz+JjEnoAjxe60CPsbq7ngyVwzAhCtQaxy/lyJ04FwWet?=
 =?us-ascii?Q?J6Y9ekpRHW8TdFNKWZ8bvVR1gWvUKgGmi7ItNZENsI6SDZzzlBY5AWjkmRKi?=
 =?us-ascii?Q?snKOeZ9BTcdVvaghSa4oiAvGPq6qOIbO5ctRouhEz32CPV/NJq7myk4KmFfn?=
 =?us-ascii?Q?QdgAMrq7f9tzRsUlGi/s1HYHNRSetJg0CX5cW8mB28O5nvm7886wNRI4c6BY?=
 =?us-ascii?Q?+nHbZdcKEyOdUPM5wUlGB1bmsIojkSMsJOfNS3jocBMlBLmFOV5DbuzU3DfE?=
 =?us-ascii?Q?ITPi1HXMp9H8rkrc0Q4j5XKR7le5eXBLHHML7NKxe26nZypESHAYMpNWhH93?=
 =?us-ascii?Q?i7L9B1bZ/VWQRAcrEzHC/DN7ilQiIz8h/kZMsJKBFmjueUc4oqOmt2asw+9c?=
 =?us-ascii?Q?MT60mYKWyapL4MpagFxRlxqN/eU436ZqffkF+pPOLDBetl/uZxydqxqYY3tp?=
 =?us-ascii?Q?2Oo0zRJCfqPQA9cM/1Sqbe64/mwFxWFcStT6rgk0Ym20BBDZNYLi0mdocGMl?=
 =?us-ascii?Q?+CjmmNVrpCbcd4QyBgmnIAIuRFKnJZkfA5kNbMJbFYj1IAmaAPapSFDOHdWa?=
 =?us-ascii?Q?1CjhfUDkVV9P2D6nCgXKO+6UrV6ws7G4JZLz5iogFu6oKYmMztQm0x/XX+y2?=
 =?us-ascii?Q?mmtOk8wdnPdd/Qqk4SCaPLDI4HFdmEvGmfUdQDnI2SeGAsaA2pxeW9mr/E2Z?=
 =?us-ascii?Q?8YDdfAEtdMnU0n+rS8Zi/VX0dxtIL8kob8u0BNYiQRmNP1ADzJDjbGXsfSiK?=
 =?us-ascii?Q?7XsBxfiiHpGP2wuQc9pIPQu+YzP7EDaCcqEC6wUYk6AuOpIUvlnr9lb2Iklq?=
 =?us-ascii?Q?JDHoNGLBdeo1QxGvWTGNV4/HheWfoxvdzYIoQYnMoE4UlQzdj0g2L1LviIry?=
 =?us-ascii?Q?yLLOGw7gA6TQhWszwL3CaM2HlsUDXJ+5Q44r6Wxe52PtfTeOZ4uD79GpwiPa?=
 =?us-ascii?Q?uSrhHrdiuSqvWq+cPFVBgXQ9scSUSj7nuEl6jQu25iXieIrHeKdlQR3VABNv?=
 =?us-ascii?Q?1rbdbApyiLRdaYNzpBC5us0TeQe+nzGj9DAnI3rTA5iSwZ3Dobil61o6aAgp?=
 =?us-ascii?Q?l1+QL1X9Dq5pSTJKFmzeYeMN8A2tMDktYL2qytEPzQCWho3hb30npZhJSe/+?=
 =?us-ascii?Q?V7o0Wu4GX+6ko05A6R4WNyfEC3CMp0a/onVBquJLWs+8ba5bKMF9arUVptoS?=
 =?us-ascii?Q?IASVdMgMzZZteduFLl0RiuhaYEGJPQUWyDsHKDXlM0BfDsXQfScw0cmVnPte?=
 =?us-ascii?Q?LSJuDIXuTrEJ3+Z1rgm5h/vvAeL7MkMinNzva7oQANb4tQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C1f9O1cM4+UlbkfACk9DctIHEbUgVbSM/5uuXjbk5uTJRGSd5HCWp3nhcxzr?=
 =?us-ascii?Q?SUuaHgBImH4U42PdEehB9E9fQzUcdpKEcX0nNQ+tVoPJsxry8WW4MdjqSlAy?=
 =?us-ascii?Q?N4h0tNXtIpKC4gL63gaqW9JFvYjNRRz++ULFDR4RQkOQGtC4+KK1qkey6xOQ?=
 =?us-ascii?Q?ZmhIEAhIaIzUTBubTjOpcs13NINo9KuX+DX8X4AdfQpK9fFSqxk8mOMVhHp1?=
 =?us-ascii?Q?sQ6Vw9xKsyKtMyj6y32NVqNnqE7X4gLD787an+7rRe8W1DLK8WIN2vbe4Ga7?=
 =?us-ascii?Q?lNZ/0tLhrHV6CM3hiSBycHkFWbHa+4u2wii8eS8OGdJV4QGSbOMffvzZe87z?=
 =?us-ascii?Q?MLhT6DwH1krOGYupYu75mH5lxmrYB20oL3XNJAPDq8Lb3t6REitSkTp2YRBQ?=
 =?us-ascii?Q?nJ3aF4HvhtcaYTAKoez6mTiCzenBKM2SQqXmvIJIYJO+bsJjr+kkOTrs2rV0?=
 =?us-ascii?Q?GXSixoMoY0l9iNV9LJzCZz+5YnoA4G1Ur2SDmteethU4ExKQy2NqQlbEWnRu?=
 =?us-ascii?Q?b0eGWLXbwrWR6FknqjuB17nLExShgZU7DKpCgqTJU+Lqt+pSLPo4o59imEtY?=
 =?us-ascii?Q?cMI1B58ZFZ9yDv6RumyiZ49XHoJnf1lM+Qk4msz461YVUPDI22g0bubAC4gi?=
 =?us-ascii?Q?qsYLi0l4V78UbzUvz1fxgkWeOUOz+LMppLTLuOm3ErMrFf5s7Eg+/mTB5vv/?=
 =?us-ascii?Q?TPoB+2OdeiRdnI3U4CEmyBGacMtMxLuxgB03YawBXYIQevah7IsQBXdgBUZw?=
 =?us-ascii?Q?VuVMBZasDqi7KVcWm7WUjsYPNC+tnsibtsUBDHOgujV28yucWQtNV2vt3QXJ?=
 =?us-ascii?Q?Sx1+aRYhoIa6VtfXGwV7iHIcLExrA2NOT5joArcbknQlN0F+fFaHAgpEHJXN?=
 =?us-ascii?Q?HOcA9BZdMY3+r3JPKKFAEVbnfYPEMlru2PXjfeVNy0Dnu8Hkx4Q7QevyMtTw?=
 =?us-ascii?Q?J9+BT+GjcuYZ+ExWekrQ5gTdOq7dWM0/EtEa8pPut3ZW5RlzaBOycW6a1Di2?=
 =?us-ascii?Q?NON1ZcvDkoz5d7UZOv+CIPvv7xtwQz+SyygrEP8yLdA7EH/KEztIOqEVzsgh?=
 =?us-ascii?Q?Rp8h7lViCiQ4TplV/JOP0IDm1yK2+9428uv41btJRtLLXKtUc5T5RjWiTSdD?=
 =?us-ascii?Q?1b7tf9+u5lxFE/fqZiX/YSHB+ggW8i/HNqEAu7XTFErGP5eg497tfHT+bnP7?=
 =?us-ascii?Q?4XelJsqXsxnOp0O1NxVsrXe+09+18UKBejhJSuDe7ItliN3PFxLfNNHK54i+?=
 =?us-ascii?Q?TtaqN/BURotra10FM3Q96Pq8cU+ClOdwQC0v5m6/JFK+HGouXqYCiXgTHysN?=
 =?us-ascii?Q?8GUFWgs5ErwKtQYxLKiP1zwhz+cSdh9vXzUMAJuiZBgqdEulltEH4Zcr3zMt?=
 =?us-ascii?Q?rcln4UCVnUir30+HWpkykVlx/9uhnVbdtB7ZM6pgg4hDP41LvD6LVWPcJPxQ?=
 =?us-ascii?Q?KreeBIDjh9xhGTCYuscvLUBYZSHPw7p+RRyhnoET3/CF6m2hyjbB37/zy9su?=
 =?us-ascii?Q?5tviyNXyxzkCnPpvO1UXc1M+PVRtsYha6i44RcfzEo+ltb+fUfEYnQg0J/Be?=
 =?us-ascii?Q?hTe/epuTKltpsOvlw9T8FtNiQONp08msPmrIBLGM49msbC9HLcArXPfQz9xi?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 935d422b-2055-405c-763f-08dca535dd89
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 01:23:14.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iv8KRFHSQYTG5ACYmfOzC/u2p21TYOj1uZL8Is3nhKQvyXdtbbKaeUUisd+neVsHtBMnSxX8jBz9X8jEDB6esysCQTklFdmBpcAp1XyNegE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7941
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
[..]
> If the TVM would like to have the storage device do the encryption
> with something like OPAL then:
>  - Attest and trust the PCI function, this lets you load the HBA driver
>  - Attest and trust the "media"
>  - Use the media attestation to load an encrypted copy of the media
>    key from the secure keyserver into the drive
> 
> The split view of "media" and PCI function seems appropriate. The
> keyserver should only release keys to media that has the correct
> attested ID, while a controller may have many different media attached
> to it.
> 
> Attesting the controller is probably not enough to release the keys?

Right, I think key release is going to be based on measurement of the
entire VM and accepted device topology state.

Also, if the storage volume itself is accessed through dm-{crypt,verity}
it is not clear that the storage controller needs be attested to ensure
confidentiality of those transfers.


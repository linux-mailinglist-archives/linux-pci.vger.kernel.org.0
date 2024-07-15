Return-Path: <linux-pci+bounces-10312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA074931B85
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 22:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2601C21CBA
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACF513A41F;
	Mon, 15 Jul 2024 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwVvNqX3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36C96BFD2;
	Mon, 15 Jul 2024 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074125; cv=fail; b=fcQoMfVwcmJjGlt70gLPZu2Kbu7V0XpckQRD7bGoD6WzzlAPR2w8d6O/AoMBFtcAxZ9kEZWZGGEtevbk5djm7TIJUsKA/VsJdsLx5Yj39Hus5ANggxDnisbvJkxndnIKYnn2tNtDjvIo18b9DWQbqk9hssc1LQSLkIt1CeRCK9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074125; c=relaxed/simple;
	bh=4bkT04Y6o20gzc3uXEzVSKMO5j5TnDwCqLM2DAlG5Fc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o3SLx2pg8t0Zq7lvfTFq+nlYvCddms4PJvPBTUmuuyce/1c5Zcg0GIAFVIzkPPiE2TZySxeqU9yjMi/I03I61/YgS3+RIXXUE+Q4TMvOiiujIvu2ICCwKPD2s8VhnER37QxPauo/ZfeeT3RF4Rd23ae8wkjmlNh+d6S8d5jaKY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwVvNqX3; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721074123; x=1752610123;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4bkT04Y6o20gzc3uXEzVSKMO5j5TnDwCqLM2DAlG5Fc=;
  b=fwVvNqX3NnnRMyDABPI3mGKXoHLnxy8NZDU4R7W+cff/xR3Q/MZWLHhJ
   M2TrkkrA0u/9Y6xNte425jnM6N+LKws0ID34D14wKISVsiFrXTtZxeOXz
   zsAnv0o2D4bPyKjNrS0y1v0Aj7zP7ELhz/5t3A9OFDZsV2LQup8T2du1c
   N0psr/uH1/RU02J45HjdNP7Jo30aimrIS1Ej1NTskvGRccvpHcGqEkARU
   ZBrx8jjsRH8kSfM5apsn3/eFvK3+BpbsPC/fDRlAGX2JeRzD1el/lYAq2
   NqRjPsQtBqtx+pLt0/6E5U0saLOi5K2MrC5Fgl/smojKwCLqcHw9uxH2O
   Q==;
X-CSE-ConnectionGUID: 2nX2cDzhR3WGtel9VixAng==
X-CSE-MsgGUID: onHJRs2cQqefq+F18QwqJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18616129"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18616129"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 13:08:43 -0700
X-CSE-ConnectionGUID: P84DrWZXSKeFU5REUnQUxA==
X-CSE-MsgGUID: G8swAjEfTRSUTsc3BmTY3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49592941"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 13:08:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 13:08:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 13:08:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 13:08:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbcS2cFoKv4210eXB0vm7EVtmj/uLbJ1TNogmxvEdDRxlPlCPrgrZx/Ht9oGzanAq3ya1i/CAWjVk7viT/M7K+noNSGrqFxstkSNqOVczk+bN4cDYrltI5b+9Jd5OOWXrRbcCCdA6dIHxOLTMSwdnJ5KkkfIQ9GKEwd9tQsxfVBzdE9pEx+2z94I4GZaZJV1kxmwogLnoP9FhrK2GPxV2Axyn8mNkrqXHcnnTxZEfS+Lu4gRpWVwOR2E0Hw7Vpan3gNYRNFM8ve8MN4kLe012C5RzBlpiua8lGQM0UTery13mnUCm+Hczjb61Oq5MMjR5qS/qiI0GIWw5oUCotoglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcWHAaEjh4mr24XamPJIByI1SXKPkebV49UIh2YhbMQ=;
 b=g3OqhGPuKcZb3o6vXQDzVyxRUUcF2KzpgFK7j0r8u3TJMIo46+f+MLmqoV0ELwUPiZxakocLf2X7jLQHKZyKSic5GDMZ+ZjUNsooDTFOtONy7BZ7Um/O9JMiG+TfeeUB5Bx1z4Qitkb1jHdEWsYanLF+X+hqhwI8usURZhyznj9IdV3OryNoNG5qN2fsvIwo3xwlMzte7RVK4ehTDozwf1ENy82JzntVanwriwUoabieCtHxddqTeYtY2Jd4HEnaFBr9A2Kmdw5HziJUVNHv3HvYTwZUuaj/4IQfmWLYCxcT0MtKXsf85s/MOeZJA3UR5c8xxuLGYWa+VtEfeExuMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6482.namprd11.prod.outlook.com (2603:10b6:208:3bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Mon, 15 Jul
 2024 20:08:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 20:08:34 +0000
Date: Mon, 15 Jul 2024 13:08:30 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas
	<helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu
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
	"Gobikrishna Dhanuskodi" <gdhanuskodi@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, "Peter Gonda" <pgonda@google.com>, Jerome Glisse
	<jglisse@google.com>, "Sean Christopherson" <seanjc@google.com>, Alexander
 Graf <graf@amazon.com>, "Samuel Ortiz" <sameo@rivosinc.com>, Kees Cook
	<kees@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <669581be31009_8f74d29452@dwillia2-xfh.jf.intel.com.notmuch>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZpOPgcXU6eNqEB7M@wunner.de>
X-ClientProxiedBy: MW4PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:303:b5::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: eb64da05-2752-4ff3-1439-08dca509e81e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vggbx0pLQGflWm8CNtsW3etUK4fDNpJ4cgrwM4HfwSuBk3pxlg0DwbOya+li?=
 =?us-ascii?Q?jQxBNybBUNs4bvAAbCB2W78BIZE9zQBdLLcWwQS5phQQzN0kBv7LT7i+O+NK?=
 =?us-ascii?Q?GebPRtfkR08DVsupbjyiR8mjiISDhJVRi8HpaOVzUeoRnSKUWTxRaYlGGPd7?=
 =?us-ascii?Q?6OQs7c1gRAyS15ukCJwK3jTEOCOve1perbNO04JqARCLb3Q9GhOPGUM/CeKQ?=
 =?us-ascii?Q?S6cmhuWBSq47OXk5XvrqPp8IebR5HCdn+rQ6fMvod6AJbq7VAslcvCacyQ2Q?=
 =?us-ascii?Q?kNRWK6dpKAn7pAbMMkVPlYIzWpXHGSR6ALcg9jj/etodcsFitAEAIOGs47Ro?=
 =?us-ascii?Q?KWoETNq9sTdz4+0WTv6Nsap+opnEW2Sof6ku96f9iaoj/OFWQtuHJ1W1A+EI?=
 =?us-ascii?Q?4w3xXy9sGEIe1pIIh7TGmKGnTvbG3Jkt1WMxa9VYASFupUmb06d681PNE5wB?=
 =?us-ascii?Q?3blyFptGf8fkqHsESuxhA70baT5FYc2IWBntUN+JdUZhxWORzb5pJ5PCU+gO?=
 =?us-ascii?Q?haHOOGkZPjEV641cf1sJgXHq+Wh7lgMJymAmkkOSgPESXr8rocWwnPthUg2I?=
 =?us-ascii?Q?Xg6nSw291ZCW5wgxl/+T9S2ZxYlvRAb4v1sPWqCRJug/lvXgfXKcIc3kESLY?=
 =?us-ascii?Q?8ZorXADz+0Zhk0c41jUxvM4ljhypx4XSCytcY4HLKz0iHh1aEbjNQ3NAHASk?=
 =?us-ascii?Q?G3p9RZ76NOYZJsZH51AvrwT4cX9U+2XJgkp4YqfkWgPX2B3DFDzeyJHy/n3d?=
 =?us-ascii?Q?32hBtkIgPa0iArEh1Wz64VIL2lOkhBpmeqygL/JkLZUyYucOjU7B3zqMbsym?=
 =?us-ascii?Q?4+JTSJ7YgCKyupDtvKE7o2fBEQr0/ueHKAVEzdrTvaAJTlct+MAtXvfxh8CJ?=
 =?us-ascii?Q?JSuYJ1P/yQ3sfXMxw71rvEJV0pK4/zIIBifzqgRsk8XHAkj1tyDs1ovG/4Lo?=
 =?us-ascii?Q?UVU4yNseUv1cnGgO4Qp0XML0s9sB+JIBth6dcBgHAhuhCTxI34hJb5VKOV8c?=
 =?us-ascii?Q?tvyegmQhh8EsBtymc35LOeoj45KvTjsj0t/gcoSS3TtZe/GYt4vkRaWl5lcS?=
 =?us-ascii?Q?1UA+uTkZY2TwawFs4W8kmcA2NhfIa0jv/ahlhRPML0E7Uz4nFYURIX0LLl4R?=
 =?us-ascii?Q?z8xWFspiiOQN3pPjcr9TgR0Ti/Nh/r0HwB/pnc4ePmIv5ZQbw8dtNAXj+2fG?=
 =?us-ascii?Q?KrhygTk2daWEpIpthdlTu67pykCXeXFNNzuZt2x1A04TtPljED8Bacdy/1cJ?=
 =?us-ascii?Q?Ty1F1XQEU+sOWwIr+StFP0DvdAKCpqLhRcxqe/laqHKgnezx150YrTXKL3AC?=
 =?us-ascii?Q?eEI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?km7Fn428MDsPKUTOIN8EQRoO3JKSh79P7Juw8qbvXKJlUwU80wpbUf56nlKg?=
 =?us-ascii?Q?LqwrdRyHunMrcZPct1X4TIR/JNt98JQQToj6Wibp8NGsxTHzV3Py5oH/IQ8/?=
 =?us-ascii?Q?FQCEw6RnPtVO94OIfxdDAbsddf+4+XiA7UMmn0f4t96PK5ywV0+l1Xuf2jv+?=
 =?us-ascii?Q?fNL7GwDREp7xbPL0bksuLcM6TGv8RX3itYhk7IF1HchkZeoStUHwYGhZdmoz?=
 =?us-ascii?Q?8eNKYyAM31CEPkZQmvpKRDSt05xKUEC1EGtK5qD6/AdpJRGwryeeFVi5oLMc?=
 =?us-ascii?Q?zhb8K7FNnay8h2SYHax2vi4++nMhPqMr/kC7womEbpNvL3EyU6WCH3fo3nUZ?=
 =?us-ascii?Q?UIad1XMVLV5MTvdRXccIWC+5ZEVdNtIQDeI4a072SaINxEszv3scP6DFAGcV?=
 =?us-ascii?Q?RHOL05ED1rKCchEwHTgHXwC2WH/xJ6kZQnO9JgqlRdEpXEa4Ms0SRYKBpRbB?=
 =?us-ascii?Q?3l5ox2yNCZ6xgkG8n1SglE7S+eG3xlqKcD/E2qW5K37h/Ttko+nLulHbP9uS?=
 =?us-ascii?Q?nbBu4FP0Tp+FS/JVdty18EPkZRdLvswC8bZnlSp/fm8Luag2GfrCQN37c9tk?=
 =?us-ascii?Q?iKdMGk2i8jaRF7PleuP6qDw7rzFJ63jFQFrKk/2GLy3iRGyjor39XoR/5anO?=
 =?us-ascii?Q?k9TslhUkrHRYD8isiPO/rMpZ19yZqMQ7qUHpGzH0uSf2q1PF3jBFK0t0YET5?=
 =?us-ascii?Q?GJ3+bAdw0xL5DY2oyYxh7m3rlmuHPP8z5KZETHLr/vDWIkjgfAl3WyhT/IMr?=
 =?us-ascii?Q?k53RwfX3+s2H8DPUlkEifouo+FaEl0X5qKYqIFMQdwmkjZcVZKfEudPSSfTO?=
 =?us-ascii?Q?rEnj2x00x2UudRaBnJ24netR3/0gUdYOiKO60g+cXOV2GfoVfXDRyYecSbBJ?=
 =?us-ascii?Q?Pfxyartsuy3kTzgOTsVhZs2Y/9p4W0M/n6MT9oGK58PKeypHRTbbmkcjq8e9?=
 =?us-ascii?Q?CiZZQ1grZLbsLrg7oeJgyiBKL0WJ47mz0a1Q5t5K3p6buUooA8G+GxVnmNrq?=
 =?us-ascii?Q?j18/52vvti+NRaYqreOfcP7msmk1PbY4ei5QDxipKFByJeR1+0EwKwqSGXgV?=
 =?us-ascii?Q?SGMhujI1mcFXO/5O8+ix9iG4tCRWW1kAMWVTt1q2CPwgTFgK2RrgXMKG2IUn?=
 =?us-ascii?Q?E9V9423jmfGjDrGoKMVaD/fmLx2EdpJnTX09rL85LAh9D//sO560Or2ADrt1?=
 =?us-ascii?Q?fewhE0tjVEXvLP6q3PyBT8kkwi7uElMWH0wTz5X9ddWE3zLiYE/e7McGUbPT?=
 =?us-ascii?Q?SmbOJ2gOGFQEIsRKR/rwpoVgiFgV8qxNa4+Mk5UUiqPmfa6zNYQeYutecgZw?=
 =?us-ascii?Q?0A7/acUMI+vpQZ704YUbrA3pi5j+fJH1B1obDsPLE9YkzDLTcuOXR+R17euu?=
 =?us-ascii?Q?z3lN2A83HhvF5Re7C6Kv235Kt0ghnQwHu7UUR6xwsHwEUz1zoaMEHa9mc5Qh?=
 =?us-ascii?Q?SshFvd/QAjKZhGybkJwBLShTjd5PuWo3FjQvrJStI9FhUl/tBJyeMj/3HATf?=
 =?us-ascii?Q?EqBwGlpnzy/9YoNZUVZADtXAs7ooZTA5KWIr0cBf+9AWHHcPrJN21PxZnv+t?=
 =?us-ascii?Q?2FT/LvKTHnEcgC0rgo8igVu+xMU2Y5SUqD4EoeAqHM6Qs621uK+kItH2GgL9?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb64da05-2752-4ff3-1439-08dca509e81e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 20:08:34.8850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZJh9HBjpS2AYjMN7F7j+AkckrWgjgjWVxlzpSEEiYVnRFsUdA/gXzWnq0ST8CflJhFdvIsbwxK/acwiQ3xiGpGh1jdHl6hmMgaXI2osapI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6482
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> [cc += Kees Cook, Jann Horn; start of thread:
> https://lore.kernel.org/all/6d4361f13a942efc4b4d33d22e56b564c4362328.1719771133.git.lukas@wunner.de/
> ]
> 
> On Thu, Jul 11, 2024 at 10:50:28AM -0700, Dan Williams wrote:
> > Lukas Wunner wrote:
> > > Resume is parallelized (see dpm_noirq_resume_devices()), so the latency
> > > is bounded by the time to authenticate a single device.
> > 
> > As far as I understand that can still be on the order of seconds, and
> > pathological cases that could be longer. [...]
> > How bad is that latency problem in practice?
> 
> I'm seeing 150 msec to authenticate a PCI device if the signature can't be
> verified (e.g. due to missing trusted root certificate) and 400 msec if
> the signature *is* verified.  This varies depending on beefiness of CPU,
> algorithm selection, key length and number of provisioned slots.
> 
> But I've never seen this take "on the order of seconds", I assume that's
> a misunderstanding.

That worry came from an offlist discussion around handling AEAD limits
for IDE. If IDE is going to go into an error state when the AEAD limit
is reached then software needs to prepared for the worst case time to
re-establish that session and that worst case DOE transfers take
1-second.

That said, a device that takes one-second per DOE message is likely
broken for other reasons, so lets hope that authentication latency does
not become a problem in practice.

[..]
> > All of these are mitigated by pushing authentication management to
> > drivers.
> 
> Device authentication can't be pushed to drivers.  It must be done
> *before* driver binding:

Allowing for it to be possible before driver binding is a good idea,
mandating it is the issue. Mechanism vs policy.

> Drivers are bound based on identity information in config space
> (such as Vendor ID or Device ID).  A malicious device could spoof
> identity information in config space to force binding to a specific
> (CMA-unaware) driver.

Yes, and mitigating that depends on the threat model. For example,
unauthenticated devices talking to public memory is outside the TDISP
threat model. It is private memory that needs end-to-end protection.

> The certificate contains the signed Vendor ID and Device ID of the
> device.  By validating the certificate and the signature presented
> by the device, its identity can be ascertained by the PCI core
> before a driver (the right one) starts accessing it.
>
> > I see no justification for the hard coded aggressive default policy
> 
> I think that just preventing driver binding if a device fails
> authentication may not be good enough.  If a device is truly
> malicious, perhaps we should firewall it off.  I'm worried about
> a device laterally attacking other devices through P2PDMA or
> sending malformed TLPs upstream to the root complex. 
> 
> In patch [11/18], I'm suggesting:
> 
>    "Traffic from devices which failed authentication could also be
>     filtered through ACS I/O Request Blocking Enable (PCIe r6.2 sec
>     7.7.11.3) or through Link Disable (PCIe r6.2 sec 7.5.3.7)."

Again that is a policy option dependent on the threat model.

> To firewall off malicious devices, authentication should happen early on.
> The system shouldn't be exposed to those devices any longer than necessary.
> That's one reason why this patch set performs mandatory authentication
> already on enumeration:  So that we're able to catch malicious devices
> as early as possible.

We keep talking past each other.

I am not disagreeing with the possibility of deploying the strictest
imaginable policy around CMA. Instead, I am looking for CMA to consider
optionality in policy given the TDISP threat model, and the known
"secure CSP device inventory" use cases. Neither of those are mandating
that CMA classify all non-authenticated devices as malicious.

Going further, there is a reason that CMA is only a building block of
TDISP. If the threat model is "malicious device implementation" then the
threat mitigation needs to consider spoofed MMIO. That's where IDE and
private MMIO come into play. Sure, CMA is a hurdle to make it more
difficult to carry out a malicious device implementation attack, but do
not oversell the protection it affords relative to all the other steps
needed to protect confidential memory.

[..]
> This patch set merely exposes to user space whether a device passed
> authentication or not.  For that alone, it would indeed be sufficient
> to authenticate asynchronously -- or delay authentication until the
> sysfs attribute is accessed.
> 
> But I wanted to keep the option open to firewall off devices early on.
> And placing pci_cma_init() in pci_init_capabilities() felt natural
> because it's where all the other device capabilities are enumerated
> and initialized.

Yes, lets build that as an *option*, and step back from CONFIG_PCI_CMA
implying an "unauthenticated == malicious" policy. Given the TDISP
threat model allows for unauthenticated devices to freely access public
memory, my contention is that Linux policy should start with how to
protect private (confidential) memory and then grow to cross-device
attack and bare metal device policy.

In other words, "hardware enforced confidential memory" is the new
concept that makes Linux reconsider its stance towards devices. If there
is no confidential memory to protect, does the mere presence of CMA mean
that Linux upends its device-driver model?


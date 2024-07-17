Return-Path: <linux-pci+bounces-10476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 539C0934501
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 01:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F131C215E9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 23:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314B24F883;
	Wed, 17 Jul 2024 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkN5wKCV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7A979D2;
	Wed, 17 Jul 2024 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721258285; cv=fail; b=bAgk4biuGymys9MOkVB9Kv6nbUDHNBD07JLh2MV6N6Jz/NymPd8WipRbibBDU2wn5UPOSd6tHlLrI48QyJF7IxwFsa6vEsXUFrGS2E5eL5IYE6dOeM2fhsCKR9foorptfFbxkUmQ/wEn1Hx00Msr6EwKEfMRAN0lO7IC7thK+Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721258285; c=relaxed/simple;
	bh=VSanPPzcXZMexwKHz6Xh7s2ZRxt6eJOpW62aswLG09E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E8TtouaUzHrjGyTmYeFprBh950zJAt5yCmOjfMGvfDJ+ISiMCfrEYtSCjUVu65RdyT3zqhRko20RArrijbyM2Viu+XaJwkyfzH9p/vC34M2REB2nMEF/jE7b7PUuBH1ZPGhOta8UPMb/M+cloZlvJPk5Hj41tfesLGApOHGkEA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkN5wKCV; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721258283; x=1752794283;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VSanPPzcXZMexwKHz6Xh7s2ZRxt6eJOpW62aswLG09E=;
  b=VkN5wKCVWTyeUd2A789mpVV227BLipi8OL8aR/9VvFQCT3xPyPiMlvZs
   D1nypPzdd/zym68hz3DQE3WEXdZ5NbOxzCBgHxhRbz48stGx6MGqb+H/M
   x8rgG6GFppswQ7uBDjkmpZUAtk3D6GK4Ya5TJx4fKVMNIOsIv9h7s1tcE
   9fDAfvLdL/tG48qNkoHbAkWSOCVORBegRc5y8DW2MPSGBV+hGt1RPg5Gx
   n9pv5VRhMw1fR9jk3DuHttd3aOLEIuaxuJBU3V1HWbTU7l42889s3GG7H
   eA4srU+EtyFRNcV2GXHyQl6Fcuk7HkhMDK72uKvUgJaDyK+pUerxnrQws
   Q==;
X-CSE-ConnectionGUID: p04TlEJuQ02gORXB8zEWkg==
X-CSE-MsgGUID: M3UXYOIVSQiNJ6e4mACXzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18416650"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="18416650"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 16:18:02 -0700
X-CSE-ConnectionGUID: chLij9y3QDK5I1G2i5oIyA==
X-CSE-MsgGUID: zcjILOYwTh2zs2NBqTwVHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="55389898"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jul 2024 16:18:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 16:18:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 16:18:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 16:18:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1QNc1bsNUhSObSuQD84ajjLYFblZvjQIwgC7/REDuaJFFchYm4q+Oo11/B4oPQoWM0II0+TR0sReYk/eA0JuORePiB2ojsgSQ3ulpLOv0dbOjGUC8Ip9XF7J1SwTNQIEAbQOsM5bwYzad+6Q37GauIb2UhSwhqNYEskvHtHG9LjRiNKKheKrGdKLK4ftWGPm70/DQ/4T+dmfrhi3sgRJmBuSDXZHjP3Rs8fZtPMTyPPVr3N6YSUgGnRp2/flPc57JgLxOSjBPza4BEtIErE90Q3O9PBH0LpnaLuHmWDSXWJG9HjPjNq7MrSIId8XWAz0c6Gq6zK/RQt3r7q7qi4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFj7nX4FdYvauLEkTMT9jooaxeWVXm02l+hgJ3SKq58=;
 b=S5q8y0L/ZZ/zAS9FTxkcS9qnfLdWa27Y3Tq+RTWgdVgq9AXR9SU6AmALb7j4auRr8NlhHoq5xE3tuXFlaMOSpL2ELhRPlNWNPni7MO0MlVczGznRqbEsmpB87UsjKuRz0I8LWMei/1tmTqXLyxsiXP7vCp62ZPF4pUTNzKh89y+WEMZfQygwDJs2RI86wuvaH+rwoXV2yhSoFldBn4Ud8aP87+n8yYMyBd1Iy4LEn45hw2gBUDHo92V5iCuLQoHcmAv+cD3gtX52TKtC5WwXvQlFoDnHT6YMq8sMrGwkF4vqVCQp57zCGGMN97YA2MOjQB32El+TsrOYHy55IYWzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8090.namprd11.prod.outlook.com (2603:10b6:8:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 23:17:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 23:17:59 +0000
Date: Wed, 17 Jul 2024 16:17:54 -0700
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
Subject: Re: [PATCH v2 11/18] PCI/CMA: Expose in sysfs whether devices are
 authenticated
Message-ID: <6698512248ee6_1f03d2949f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1719771133.git.lukas@wunner.de>
 <8851c4d4c829dd6608f15244954e3fbe9995908b.1719771133.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8851c4d4c829dd6608f15244954e3fbe9995908b.1719771133.git.lukas@wunner.de>
X-ClientProxiedBy: MW4PR04CA0125.namprd04.prod.outlook.com
 (2603:10b6:303:84::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5367e3-ecc0-45e6-def0-08dca6b6b2a6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jo0cYM5RQG1E+3mEbQTb4HQLYTL/jfLI0yIXdJfawqQi/pILUSO+UEUqFXQZ?=
 =?us-ascii?Q?ZQokcruORXoNwzQaVs1mNPvjQgSuiRcvmbZaoyG3RlXYrgu8ZySOnO3rKMlR?=
 =?us-ascii?Q?a/yUfGBELRDvRjnwYWRyTGyE8FjkTUsVvz3NjJ/APZBOWgt9n0Z7jSD4GNtw?=
 =?us-ascii?Q?tNvVqoRnZCCrhur649C+SCfVF5akjzk1lsIuipjiIQ7fWGsW/h+bH112HSp8?=
 =?us-ascii?Q?7GGSVihwDfWknVs62vvi5cF1NQVafJAliKRl0R+o0JkIw6TQSiS8KLHvAMoN?=
 =?us-ascii?Q?1+4UfHpCDO+VwmUPb4u4MMdKa4b7Oh/IKZsvEWSUJRC1SmjTulzaXQNIEbpg?=
 =?us-ascii?Q?wvvdMn+k80LZGQ+MBkgjP5bwimbNVxCC4J9sbREmKe70+LdUQYOQdu1J11Xr?=
 =?us-ascii?Q?mpMUsuyQDIW1ZaD8Jp4ejsQf9lakg6po32I1WuEIoE/7mmCC2+b9nF5ukka7?=
 =?us-ascii?Q?YzlyU4YEVAGV3VZSbQIjtpPrmrJ/P3XjTLIJ8GAjbEZepN2PVlVJEI6Ezvzi?=
 =?us-ascii?Q?lJpSbdU5uF9MzZ/DokrIHbmq/s702EIldH4gPhj+yA/Xs3PTKmYK76vOXrtE?=
 =?us-ascii?Q?j0JhwrfiaK1MvtKxNq/zU1fyjyf7DBazWkIcMi3F9D3kdy46kgHW9dAcOwXZ?=
 =?us-ascii?Q?STLtHdleyvBLZuk89gUjQHH6HfoMSx53hnX8FjndSfqJ6kWZi8zUg8EMvsWK?=
 =?us-ascii?Q?LEgj3HMXaroUNM/LM+IsZog8qTHenVSdRNOn+zDJayxHYTNyednxYJmA2gGF?=
 =?us-ascii?Q?DyWUsBmjpOt2J3bvmL6mI6OZTkQCnJk/7SZFSl9kgd2vDIS4pbwgKfbyVNqV?=
 =?us-ascii?Q?kXol1Ec4YR0y2bIKncUBiaJx0nmDzQ8Vgd6RfZNjHayHHyqVXMkEd58Ay6vT?=
 =?us-ascii?Q?YC3vu4nQNmTB4LHoGdprNtkkC0ZEB4ylQSa2yY9WV9BajC6AvC0pl5k/05P3?=
 =?us-ascii?Q?uq7dEA0Yte2Qp13+1hlgP/FOHx/DkcX67xrAWngWggwP3b4f9MipMWZxbbVm?=
 =?us-ascii?Q?seEzxKIVjKamZevFL90ATiY3YlT1Y3YH+DR+9o9hKDD8Y66qU+Lb3+Xe6KN2?=
 =?us-ascii?Q?i5v2dift9S9gVZOvMVavBguHDXdIL37KRQgB0PeWXUweitmwGF10TwW4c74Q?=
 =?us-ascii?Q?iA0M8SoRZtCjEa4+qfV7DG0KHdrOpGXp0KMjjRBx46emSEWuRLMRc24O0WAw?=
 =?us-ascii?Q?PAZM6aVRDK8eVqPF7CxDKBbam0xOhJwm6gIlnY5na4ztPBYpSoGSqEYvCAsB?=
 =?us-ascii?Q?JiV3PS9eWezoHgO1LyDBqdX/RdrXDNZHJOsTg7AxSmTOAgcfij1YPDlGgVaa?=
 =?us-ascii?Q?+rIvlN3qLJE23HStBerJCXP+wg+pZwoJJ1fsyOWEmmBylQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9CGy1qXt5KGpMGE+zMIB5aM5Wpjjgll5vNnQOocExi8IAQJg4WvbCmOBvuFK?=
 =?us-ascii?Q?BUWahE2ThNR5lu2K+Tnqv0ZeTaikJ4ijvleorhQ44MMI1Sa71zdmiixV/cRh?=
 =?us-ascii?Q?aVZ23YkEBT1RfT7B8vHUBCrehVjf9gCQfzMeaQ7h4S5Z62jCf5Kw7+Cbk3xG?=
 =?us-ascii?Q?UlXRl3DaEPqcesS3pX7VG/ozpQoksfwB5nmLiHxyQofvW0zfNgaI7RKQjUiS?=
 =?us-ascii?Q?veZenje3xGhkJ+P4EdnXTJLGP3H8ugHClFrQvDwCbcDl69sJhwQ8Wa+r+1Jw?=
 =?us-ascii?Q?isrJXAefXlTKeJfk/k6uws49zGmRvILSotX5qnrbiN2IWeDh9Z1/AlWWgNmD?=
 =?us-ascii?Q?k1QcxWBsKiKDFTb2bK8Fn39koIiwg5G4khTslHr1ckPjHY1Hg1CvkH+W1gvv?=
 =?us-ascii?Q?E2fc91oCPjGwvvM7sujIZeqdAoxigs46QsQ1mlvu8aSFcNj/U171zhvQWwWP?=
 =?us-ascii?Q?PVUC/EnRZWBZ59fLmT/Tt343P6sdMzYmEtzkvG72ZthdqDJ+ZXPly5v6QT8H?=
 =?us-ascii?Q?pi4W3EDnEiE3+bgQ8rH5BZp+5xPOKxkfOxW9PvY5IKpuPkU8X4Ywk0GxEx+t?=
 =?us-ascii?Q?O1lVmG+gpdlvlgAktCyPpft+mPVTV9F9dy4yXJHONXx+CxWZM2TNei9Xg9sQ?=
 =?us-ascii?Q?uJrFc7h6SZzh0DjSlw0a5GWioXnCs8U5DQ3UvzvvrWigfhcf7HnLodrZEhZv?=
 =?us-ascii?Q?vOJndaDvGrP1dGOx1cIMQlcrKMPHpc/x5SFXaCAU6KQlCJDR2ejNLASPmFhz?=
 =?us-ascii?Q?E+fDYKtIlp9FoSCj1WgtK8C2aKnZvBqy9d+f7mCSIec/nrWNRnpF4kK/kl1c?=
 =?us-ascii?Q?1WdvJhv3p6Z9RAepY7JbO6rif5mL+UeOG26LG9EFnAzSMYJUYrCCXFy7o4zf?=
 =?us-ascii?Q?CEFyltGQfLvorMXiW6W+o6xfEPOVKwSgXUPfXZ0E8dMHG0sS9SDCUSxTHcqd?=
 =?us-ascii?Q?3K55UubRu6Uy0XpeD73AAXIkJ/JhN4+yh97366Ar8Y72uf6jovFYgq82pLIm?=
 =?us-ascii?Q?2odx/6+384TKteQSgDr+dRpuXKAOzy9eh2nfWUldgcIw+olXwxtE+a2TMm8f?=
 =?us-ascii?Q?yZHrmAHJYvfoeqqD+T7uctC2MMx4u4fxqQbs8EfcEAPRZuWJNZwLeJe8kocc?=
 =?us-ascii?Q?TKQPlhp+rsUXtrwldJXD/D/TkMe2HSU0XzXZxgKtMPR9VHjrckfTSPudarpS?=
 =?us-ascii?Q?0nt2uJyl307m4GxayrvF4/NniarAh7B7fSgmwGgxxQQC9QHYwcB6FdwLh7US?=
 =?us-ascii?Q?p9LnJs3nop1FIcRyDXFSQH2nux69PWi5JsGDhjmdDr8BBkMWJX6EEbQEagyN?=
 =?us-ascii?Q?SopkU2fqp6ZETyLY24d8dvyxSvj8Q0q0uIDlOXZxnXLZNCl6tkxSelEoDkrT?=
 =?us-ascii?Q?QMO2nppe2MElSRkdwflb9FPde75mnVUGXmN1PSq6Kjab3R6B6s1MhtoowtHr?=
 =?us-ascii?Q?jI/8j9JN54rfvNiPBXnTXlli7YMhlVyMVh93LPqmwwC/HeD1IlAyZHw/1lFG?=
 =?us-ascii?Q?Tqo1eLdnOzzgFGcADZ6pA67lRowJjeIRpCXOV7hjhTT+Yn4X5cTUVOmL876O?=
 =?us-ascii?Q?4sawP3erRNghKR3uyLHLB4alSbjVzvpmYQrn8smEFaIoLIT35jSnMONcOQIa?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5367e3-ecc0-45e6-def0-08dca6b6b2a6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 23:17:59.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRlT+keo5BrOADgnHiJGvjjHqmy7dIZgAfpYRmACAiyE5x9dZOifLH0KEe7KSNEBpZRyLPWG6/J526/+Jcx5cchsoDan6eCumZSpRtiAVyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8090
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> The PCI core has just been amended to authenticate CMA-capable devices
> on enumeration and store the result in an "authenticated" bit in struct
> pci_dev->spdm_state.
> 
> Expose the bit to user space through an eponymous sysfs attribute.
> 
> Allow user space to trigger reauthentication (e.g. after it has updated
> the CMA keyring) by writing to the sysfs attribute.
> 
> Implement the attribute in the SPDM library so that other bus types
> besides PCI may take advantage of it.  They just need to add
> spdm_attr_group to the attribute groups of their devices and amend the
> dev_to_spdm_state() helper which retrieves the spdm_state for a given
> device.
> 
> The helper may return an ERR_PTR if it couldn't be determined whether
> SPDM is supported by the device.  The sysfs attribute is visible in that
> case but returns an error on access.  This prevents downgrade attacks
> where an attacker disturbs memory allocation or DOE communication
> in order to create the appearance that SPDM is unsupported.
> 
> Subject to further discussion, a future commit might add a user-defined
> policy to forbid driver binding to devices which failed authentication,
> similar to the "authorized" attribute for USB.
> 
> Alternatively, authentication success might be signaled to user space
> through a uevent, whereupon it may bind a (blacklisted) driver.
> A uevent signaling authentication failure might similarly cause user
> space to unbind or outright remove the potentially malicious device.
> 
> Traffic from devices which failed authentication could also be filtered
> through ACS I/O Request Blocking Enable (PCIe r6.2 sec 7.7.11.3) or
> through Link Disable (PCIe r6.2 sec 7.5.3.7).  Unlike an IOMMU, that
> will not only protect the host, but also prevent malicious peer-to-peer
> traffic to other devices.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  Documentation/ABI/testing/sysfs-devices-spdm | 31 +++++++
>  MAINTAINERS                                  |  1 +
>  drivers/pci/cma.c                            | 12 ++-
>  drivers/pci/doe.c                            |  2 +
>  drivers/pci/pci-sysfs.c                      |  3 +
>  drivers/pci/pci.h                            |  5 ++
>  include/linux/pci.h                          | 12 +++
>  include/linux/spdm.h                         |  2 +
>  lib/spdm/Makefile                            |  1 +
>  lib/spdm/req-sysfs.c                         | 95 ++++++++++++++++++++
>  lib/spdm/spdm.h                              |  1 +
>  11 files changed, 161 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-spdm
>  create mode 100644 lib/spdm/req-sysfs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-spdm b/Documentation/ABI/testing/sysfs-devices-spdm
> new file mode 100644
> index 000000000000..2d6e5d513231
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-spdm
> @@ -0,0 +1,31 @@
> +What:		/sys/devices/.../authenticated
> +Date:		June 2024
> +Contact:	Lukas Wunner <lukas@wunner.de>
> +Description:
> +		This file contains 1 if the device authenticated successfully
> +		with SPDM (Security Protocol and Data Model).  It contains 0 if
> +		the device failed authentication (and may thus be malicious).

I'd drop the "(and may thus be malicious)", because passing SPDM is not
nearly enough to establish trust in the device interface, only the SPDM
mailbox. Also, unless PCI CMA becomes mandated in the PCI spec, or a
major operating system, I expect a limited set of devices do the work to
implement CMA. It is too early to declare that unauthenticated devices
are malicious, they are simply unauthenticated.

[..]
> diff --git a/lib/spdm/req-sysfs.c b/lib/spdm/req-sysfs.c
> new file mode 100644
> index 000000000000..9bbed7abc153
> --- /dev/null
> +++ b/lib/spdm/req-sysfs.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DMTF Security Protocol and Data Model (SPDM)
> + * https://www.dmtf.org/dsp/DSP0274
> + *
> + * Requester role: sysfs interface
> + *
> + * Copyright (C) 2023-24 Intel Corporation
> + */
> +
> +#include "spdm.h"
> +
> +#include <linux/pci.h>
> +
> +/**
> + * dev_to_spdm_state() - Retrieve SPDM session state for given device
> + *
> + * @dev: Responder device
> + *
> + * Returns a pointer to the device's SPDM session state,
> + *	   %NULL if the device doesn't have one or
> + *	   %ERR_PTR if it couldn't be determined whether SPDM is supported.
> + *
> + * In the %ERR_PTR case, attributes are visible but return an error on access.
> + * This prevents downgrade attacks where an attacker disturbs memory allocation
> + * or communication with the device in order to create the appearance that SPDM
> + * is unsupported.  E.g. with PCI devices, the attacker may foil CMA or DOE
> + * initialization by simply hogging memory.
> + */
> +static struct spdm_state *dev_to_spdm_state(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return pci_dev_to_spdm_state(to_pci_dev(dev));
> +
> +	/* Insert mappers for further bus types here. */
> +
> +	return NULL;
> +}
> +
> +/* authenticated attribute */
> +
> +static umode_t spdm_attrs_are_visible(struct kobject *kobj,
> +				      struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct spdm_state *spdm_state = dev_to_spdm_state(dev);
> +
> +	if (!spdm_state)
> +		return SYSFS_GROUP_INVISIBLE;
> +
> +	return a->mode;
> +}

This looks ok to me, but it does strike me that maybe
DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() should be deleted and replaced by a
recommendation to open-code returning SYSFS_GROUP_INVISIBLE as you have
done here.

Other than those small comments:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>


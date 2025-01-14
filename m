Return-Path: <linux-pci+bounces-19737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A36A10CD9
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 17:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72BF188ADDD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 16:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDE91C4617;
	Tue, 14 Jan 2025 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arT0W+AY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327571CAA7C;
	Tue, 14 Jan 2025 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873853; cv=fail; b=rc0fks9TqApaQcQyV9kbnivMATN70D1c96Ifcc6c1iDsW+qdzo/j6tN1I//h7x9Y8cJeHdXVtxyLyuHvWC7xwWU4f/6GO19k+mMBrasYaZS9nw50jNhhSYV1dbp1KISScEYfaIWgIpRS/lnhiPspJj2LXkpDSw1bYcOh1wVRozg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873853; c=relaxed/simple;
	bh=QhrIJRjPaOpAMns06uVo+Ynk1L0fUR13cUBMhF46544=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=naEQlRE79e6kOu2Z2Rqgv44Qiafz/coEGCPDGOL7F2qgYC/jfvteJgixRyj3uyfQQWV5k5rAR06lcrlJ1XJpSGhfFVx8JrUd1TiHotD1on5auVHdBwjFyA+7zrmN2DeJJlKGiumGibd4HCMNZB0I7yhb0N88jNtF3BMYXv5hf6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arT0W+AY; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736873851; x=1768409851;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=QhrIJRjPaOpAMns06uVo+Ynk1L0fUR13cUBMhF46544=;
  b=arT0W+AYH2loU0iGp+Y16gImns+8YDO/xy1dwAu3KJP98w8wcs7J9LVm
   8anBlr8ecMMd88PJNcWRnH1bvkjqrJjliBcBpFOvFnVuVqbXIzVA5JAEQ
   43lgIe0vh+jdXZ1cp8oNstyxODJ4EueQBEogcn0pm5KMhM+49fOQKPhZE
   5N8MWP/3E390GJvLO2yAuNTDV+wqBl92DZCQXI3EIcPkDR1G6T8I3Ls9K
   eaHDgoA7eebOaEl5iMYwgSBGVyLQTHsxAcQAV+g01d1kDpH3X0OfYQdtr
   K4V/5di1kI7EKsehOv5E0KXUWYXCfFdO9q6xqwCNwYiZIyDgqbTqNNq0c
   g==;
X-CSE-ConnectionGUID: sWtGdSV/R8ukxtIvnCJbpw==
X-CSE-MsgGUID: q9hu0i2TQIG8lU3CUzfdpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="24781784"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="24781784"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:57:30 -0800
X-CSE-ConnectionGUID: Kw9i1XVASI2ZrmkKKzJXhQ==
X-CSE-MsgGUID: epKnVYDCQvi1hJqPONQmeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="105374855"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 08:57:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 08:57:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 08:57:29 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 08:57:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAxRwddE+nfwfG8nP8tYalbeusS1lnkD4RHNke8fl/cPsgSzx4aNwJk1ORoHGgQLUeyev5AX441S40E6CW0CNxUxYa0P9DcrWShGvsQwY//FcYYmtpuwE2Fqda/luPhw7ax6Ebl5Um/PWQhXlHMsHni8CCfUrUPUc19H7rNIIpL0auiCLlC+P5o0QHVrkyC6eYOu8PABhvzv12RWE1CayIJJ/G62UhoReYSwp/GJ1N3qY7pCscNao/oHt07045n7Jyuc9C7kEmJulE3htIE+qMEUScpMUmIwpei2cW71OjbbI52Yy+bywWVQXf5wlGvj4/v40vuCfh5z281BRB+gRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBvTDmB/nbQzHssTwiaqk5X9MaKE/q3ClWzEKBB+SOo=;
 b=iFZPKbPKKdoJTNLd114Murz3AtAtt8ExbpSQeD8xjFwfdz5dnFTVClRfB0L3TISWZ2L7+5Rzke7/5S1WOHZYu52V79B14bIHmDWejKQRmt8hH+/bWzmM3m8kB7HtftFxYrS5ENbBSL2JuUpIR7qpqMSbS/6JGH4W1zYzYX1ek/6PWbomiGB1b526hE1mPJcuQmoEfjLKNJk/C7RjFnPwN9/uEa3+oJxqbD/z6ZQolexCu2+zfld5tY9Bkxl4X4tZg4Rka7F0Dch545cO01GqKqOjcz9s4U59cMz1NuAHR+kFWnslNCIvheRAqm4OYp9c5N2LB9y9Znu8wH7IvRWVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB4983.namprd11.prod.outlook.com (2603:10b6:510:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 16:57:21 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Tue, 14 Jan 2025
 16:57:21 +0000
Date: Tue, 14 Jan 2025 10:57:15 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 06/16] PCI/AER: Change AER driver to read UCE fatal
 status for all CXL PCIe Port devices
Message-ID: <6786976b8dcf0_186d9b294d9@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-7-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-7-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0334.namprd04.prod.outlook.com
 (2603:10b6:303:8a::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b55c93b-54fb-4a53-0b72-08dd34bc830e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qi4HYtbcCirN/c6ADeeVqXV2BvlX7fivntsVKnnz9/79UYVWmnf9rpvIFG2Q?=
 =?us-ascii?Q?ROWm67kQvJPIl9MVWr6b+EUbF5MR6ZUadhH9ZWpQwr+F/4g40A+6WisoTR7P?=
 =?us-ascii?Q?ueLst7DaPybH9cAo3Q1GeYvp/d1cbs14d8ncfTz3/KVMSEkXdrp2LmbCAxIL?=
 =?us-ascii?Q?49kcIqYUC65uJjsQkB0hL4CyG54zSXF8GVpo6TTrf44Ijf/XcMokSq2YqNee?=
 =?us-ascii?Q?y44UB3K6u40Uiv9OVQmL7SBzJ+Iq/7bgsZj2NIeXdXmZqY69fk+mtcjEOawR?=
 =?us-ascii?Q?V8pL1dIH1PCGCHD1CwnzFfHqyLo8XJpZHMFc6vVcZSv6KaSUQmZC1eq3QZrO?=
 =?us-ascii?Q?4etjePseQ9W6vFMHrxN297aZSpmaeaiEbpu3KNPyQnzHi4rcZ972R3lk/zrX?=
 =?us-ascii?Q?LY++j8Tlnwx4yOV5LAzxCz+9RBc/MUamm2SaJmZaJx5Ty0W25e8y1ksnTuP2?=
 =?us-ascii?Q?vQDWKiEaswk2CAwlWe0yk0CxShjusDAENI+iof116kTrPqfdKzvWKbDYN5x7?=
 =?us-ascii?Q?MZIS0PifdEarBMV+gWa0Ec7tPb3A3WGqYB2L4Rbd1oMSvjbu3IsGEin7M0a0?=
 =?us-ascii?Q?5/LlWoaif3xpT4pjY4CkMLIQ1rIuq7NUEQ4wH5Aw/Bcn6MLiTEDsRHD3ps5s?=
 =?us-ascii?Q?AB8mRLDMGXzSOvK9FaGAymEAXumIeHDzJUThLC54EdZ8OKcfT53r8Q4SdIOh?=
 =?us-ascii?Q?dOV89ev8vX5ViGi/ueLoDWZbUCh+6IKE+kN5ZCHEPMdwofyMhtziVvPE2S81?=
 =?us-ascii?Q?oy+6FmF1I0MVlSJMkOeTQ74bsdRqynX8kc+97B5YFrdf3gllkeNJuLLHSFGn?=
 =?us-ascii?Q?N6yKgMAJfZHM23Z5nBB2KQae+nYpdyZEkdZ0jnhzNmXRRHOaDvaiH5/A197p?=
 =?us-ascii?Q?GtehX9b8dnQOfwddRL9xexdd19vij2niCTuuoXyRPg0Xll7+XIHnZ4kKzgtR?=
 =?us-ascii?Q?FXkzFymuESs9MURkblD4E9UvipOc9+4C6Ut5NoHGEnLzW56vVXGEt8nAasis?=
 =?us-ascii?Q?RkfIZRGRUbhAkQ/Y8aXtSHAdkeYNQ4N1uX7yNF5xl+SduWc8ROng3V71bbPL?=
 =?us-ascii?Q?pmOBOqPZgsCBFXkH2Zhh2BA0RU00SmgxN6oybe21oOM3zLg/GztqzlAunBOU?=
 =?us-ascii?Q?1LqhcRUTJJVyw/to5+66QC/JYJEoSiePZ7Heio6qvb4JG0PzdbDYb2WdugNQ?=
 =?us-ascii?Q?cUbX5AIxBLTNpu8bp0Muge42q6jj7NsahytgAgJ3v25JJDwmG6w+X61uggm6?=
 =?us-ascii?Q?9JtrssOEsdxL8ecCOzf0P8bVXzwrLJMhoVXMT7Y9EmtqrXDqbP/Ob8r8okcx?=
 =?us-ascii?Q?CtpeABXL1pRgXTi1jPuxasLuHXj3HJOlVbQzR87pUlV96Cfr8r/QV5SHbhmT?=
 =?us-ascii?Q?Z1kRyMOK4B31d/xAjqS8bC2gT6TGWpQH4QYhNvlV8D9J2fI58QmOGlMAp9oz?=
 =?us-ascii?Q?23C2RaCStW4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?htqNO98YwrDEGMe6gzZgZF0uY8usipNyTgZCcpmCelh49Pm1mvhELjjRXyhp?=
 =?us-ascii?Q?p3NVnr0u3o//Uyo/Gbdnx1fgPvJJ2T6fZ1xPqhB2G6Xl9NY66NAJgiCl9dZS?=
 =?us-ascii?Q?QAvBBcznMfN0z2SoK/Fh8M2BXmU+ibNVzQpNFctYQi66fU7f6bhJaVpvhva+?=
 =?us-ascii?Q?ikFbJCgZdHDzQ/xXuOTu7CL4QowXSUPPbXogzg1T69jbHppzBM7JQ9HD/dgN?=
 =?us-ascii?Q?OM4RCxQ+0S3Jw5VmoVAa1DtNAlEiNFREKr8Xkv+hSmLGluMHBf2cFJJJWUoB?=
 =?us-ascii?Q?maG3pffQrkz0eorGab7t8UFcl2e9AUSTph616DZwgBAuu1Pc2imVfPu13XP0?=
 =?us-ascii?Q?wbl30GmgWs5hW+lkBE6aZ5GwaTjBxB6JMVgSXUtEznWOvzrsJzJbxQdNLByo?=
 =?us-ascii?Q?Q3TMdsVxdmDBy2PlFGRoL9cCj+XzRqu1+RrnS95/ac2wuCrt0pCv4tvj0e1j?=
 =?us-ascii?Q?UbaI8+YwNA4BxtV/cjq1Bra7c0+vR/Qd7Ws82YcLLZlVFjNQjpVHC2dzvVcS?=
 =?us-ascii?Q?oZi2BFfFRSzy3eqrnx12DnE4vo1W2FuHfk6hbEXQ3iPSXkeRJFXoYP8VuLti?=
 =?us-ascii?Q?KOpD0adqDlD+ZfaVJuVZRdA0ZaOO/UF/OqYYSqYhXs5gKtWfz5K/IAkEh4WT?=
 =?us-ascii?Q?iGhokUNcrCmqZKHLUGYSpV8TgmzBvad5rpBA6gUzp15EazdIKf7wPfteZ60G?=
 =?us-ascii?Q?9+KhEr69U+ECK+xis3MC4CD/8Eqw75+EfkqzyedC5jXOVEObiKUi542LNCeg?=
 =?us-ascii?Q?G6bgztLYNBSc2p/WnvJcxtb0tob5x4pdyddjD7PWjarn0iKYQPNsb0F//iYF?=
 =?us-ascii?Q?GRdHAwxqrvGeKa7VIE4uwwK3MLWA6oPoFlDeB4sqU4VUdef2IWDVRN4uMxzN?=
 =?us-ascii?Q?VsNMva4tpeoRhTGHWNR9QUsnuOb8B7gUO3c6ccxrgn7aIim5wu2M2PeF4nUz?=
 =?us-ascii?Q?MeAFfJNiSJfJFvB5I5I/dZm/UeRqzPtUc4Om1me3D6i+GU9/Cc4GJx5cnJRM?=
 =?us-ascii?Q?e1bW0GbKBYB00PtoYB5nZtbzQ/QG75z/I1+GFw+pKF3sJfre8NOFvqH+r7h7?=
 =?us-ascii?Q?EhMTzTJHdeeG17e8Ucb6bSpw3efvpaIyxa/UpkL2Pl4B41RZv2z5U/6gb5V4?=
 =?us-ascii?Q?R18rdATxATIRxbx7MXvbqRKVgJGx/AfcM4Z3HvVB1wKQBMcmUZhAdVRPKI5q?=
 =?us-ascii?Q?OPk2GEA1ZmWG84MvsSzNbz8C51tMTdhiwJFKx4ayfZ/eZyawQaRiTH4RphLl?=
 =?us-ascii?Q?FmUUXvhqzgnxLCxsr8g3ZYp0iXJjBsBg295XocgDjLMGSlvVZ2s/CgVsEEle?=
 =?us-ascii?Q?6DaIsaQnLRbSDlRyRbZSRNjJs/r5b8FglsLAhnGUNemE6wbp2cFPRgLPzPtl?=
 =?us-ascii?Q?MgUdyqtSGardhKwpJGCSlVv3i1eSVfbpC68cY0Avl4+u44rqRM23St2iMJYE?=
 =?us-ascii?Q?sCWASLIhfzmEfD48Arc+zyvnIp8ueKh5WabxX9n4FVIqU6wCaLljqTYXUw4X?=
 =?us-ascii?Q?hyKpnKnRUHJdl+5Ov6LlioDfk7c6ET/S4qPAap7mszBgpA7stsVrI8aCKYOH?=
 =?us-ascii?Q?EgHYzzItI4lpVfnnq8j+0j4efwaD0RwILaMPr7/c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b55c93b-54fb-4a53-0b72-08dd34bc830e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 16:57:21.4839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgHbs2Jje0Klbc7+ewkGKcN/p+nn2bD90dLbV/8yjxSwH08TvRpYvG4F1i7ckSesqv+wkyZBa4HZClauj15u8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4983
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The AER service driver's aer_get_device_error_info() function doesn't read
> uncorrectable (UCE) fatal error status from PCIe Upstream Port devices,
> including CXL Upstream Switch Ports. As a result, fatal errors are not
> logged or handled as needed for CXL PCIe Upstream Switch Port devices.
> 
> Update the aer_get_device_error_info() function to read the UCE fatal
> status for all CXL PCIe devices. Make the change such that non-CXL devices
> are not affected.
> 
> The fatal error status will be used in future patches implementing
> CXL PCIe Port uncorrectable error handling and logging.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]


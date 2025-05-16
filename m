Return-Path: <linux-pci+bounces-27832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB433AB95A3
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA52BA03B3D
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 05:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD673221F16;
	Fri, 16 May 2025 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuC6jpKU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED73B2206B7
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374550; cv=fail; b=TGLF6z73xBKfhL48AIZpZuBcpYJqqdRcShoKS7r+c3ALJEVCKw6Vp4VpKtASk11ld8tCvkrXHRCHos4321JbRXMWBizC+LqTjvMDKVJJr4VHow/oRWFyT/Z3cN2F6rJJNj3RVMaDC31tDD5UuFm6AngUTZNaJEb/O3rrKyGblu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374550; c=relaxed/simple;
	bh=5hpRAIIBOZEdGvHKxBkDb4F458zTvGRC+TtlODcFFMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M37WyZIdQ3zclwqEpXvR/Fq/SqQHoXLkls27ttZSUuaMShvkInIWt/cWg/fY/YJ9z30X0lXom4q3JqE3LO+a6dhdw33+vwlWwQyqs9Ews/kvZKrget/p3bku0gpFcMK++NjLAfUcZyYVz6C6ZMmkIv7PN8ePhOa7+lAQPDC41XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AuC6jpKU; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747374549; x=1778910549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5hpRAIIBOZEdGvHKxBkDb4F458zTvGRC+TtlODcFFMw=;
  b=AuC6jpKUsPNgnwRxT+krVwwr+lac3xe9KgASeDGIVwkq9AgwMksZRyAu
   kyG0fzvzjQbazzbDwMCRS0tVidka8WE2GVScdWoz+5ua/qV2oVIvihFAK
   pohBgmhHwdfnU7bomladwvBsnMGm54s9VLphbFOUmxY0H32iM7u5d3815
   3v2P1j2CNa1tIiTlLmpYuv3vFAfIx1Zt1XEl5DfI29+1Cfd77xKaDkjcy
   JayI0WsPJT12RItDjfya7nVPiI/y88U4ctTbSoRZuR9abKT0vb/2UK8cH
   DZtEcGMRvpubKZ7499leHcEMueL/d6sqIpBDixd4f2rGCiV9nXFa02dAN
   g==;
X-CSE-ConnectionGUID: yGx+NMNYQpaQhjW6v+bzkg==
X-CSE-MsgGUID: GqTP4ofrRB6uDoTgng8ocg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36953043"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="36953043"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:49:08 -0700
X-CSE-ConnectionGUID: +tZHjNuHQ3eBvq6Y8lKukg==
X-CSE-MsgGUID: AEKVXJFjQPGqDb6SrSfBDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139084854"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:49:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 22:49:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 22:49:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 22:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWrS7yPwzx65AOnngm9F10v6TUYVenamZHGVhG6f8XnXN7Ozz9RVik8526fMOuisYYbyRL8Us7l2Rz1HzJ4SY9qCgzhJoAeSm61fbsE5Qg5jFLlxUuP6A6n/GZLKXRYHI8tob4kAgdNWavgsQrFp5HWTi7PtP6S0Pv45qPl81+YaYM8iuCHE+DjygsGsO9sfco72hy+VfLso5JRNsR2s8ZXvP8Gqj6rcvwUq5g2yWvDXfmm4PqLx2m61oNzkeqigBnMLsfHMVcm6FD7zhadgiYzLWk9U0I2qWu/iCEhr7jVmXVyRWINLRxd7XCIOnssLXc30mXEeRt9xrAacExJLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MId58PO9VyE3+zE65W0a0wfRo9ebqhoKpWyyoEb04w=;
 b=uGMAm8BAqCTosIi//ZZALusTwkkX6or9sKaHzFt1f/mRryQotYm97hZni4MyrtxOnuSdU6GgXSzydN48jWTL6Ose/jXTFvnP67Fr1wd19aiharhZPj9wCBOPYJ8ERxgjGARAxxdmXCvMpHQkFZC4OWG6rifh1qOLuTaHiQ+REeihsMXpV3i1Gnyx0hw3LlJofmIoBRA7f+tpow4DGsG1oltkcgFsA+oqdzr0hnYqTA+6hjTqM1O0KnEB4r7hN6LI4YPt7FSomxvTzx1uH/9Is1cOT/NgphXLZ3cHIfVEJNH27QR9o051DFAxHEEUlEXJsZr99KKd1Ikyz8vmBDCbtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 05:47:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 05:47:50 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Subject: [PATCH v3 13/13] PCI/TSM: Add Guest TSM Support
Date: Thu, 15 May 2025 22:47:32 -0700
Message-ID: <20250516054732.2055093-14-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516054732.2055093-1-dan.j.williams@intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0098.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::39) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4683:EE_
X-MS-Office365-Filtering-Correlation-Id: ee04742a-1b40-44bf-fae8-08dd943d31a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?82ZwHK6SGEJSRxYPZtqkontWl0SCwQN5DgJ3cKEzEAjNzvmKloG6kCBEOWyF?=
 =?us-ascii?Q?49v2jlx96rkd715NTNDQDx6P3MwVYchc/7cBnOrSTi+GMJal4/fPC/iMwIQX?=
 =?us-ascii?Q?VR4AihUU6UhOkXf0FWSrtKyKwKajnAKg4TpbuA2fHa8GQihpDrFqQff9oHMM?=
 =?us-ascii?Q?jv3RvkwKfYNtTqMpdpD7wVVBTziQpzJuewI0clGmrCXB2ereVfvB2lr1DvvR?=
 =?us-ascii?Q?lO9kXbhM/FCgGhhP40pWK+ZRp96kO3PRRNfdyVqNKBNWnicYIOYxiZNRu2me?=
 =?us-ascii?Q?jrZObZXnmFCYfxqU84m0uf8unwMmmYVMFhAVa2fsCOFuu+O6tXZiC585pafs?=
 =?us-ascii?Q?xP5ECvy+bWLuEDig6OUKVso8O3ZHhH3+rDwPxJLDrOMJmXa0g5XejxJT+cnQ?=
 =?us-ascii?Q?eXo+psvMWsvHO3nTl1pnGUhPhrF/8K9SUY3dmRHOTXuMqi+KBBCALA/pajdO?=
 =?us-ascii?Q?bxJBQwNjZnR80ss7TJbUtVhaanAYD1uljjndj1gOXfsaqiYA57mOj/U5Fr0a?=
 =?us-ascii?Q?hgkDkg/UxXfm0rA91wOALbTY17VvFoZOcfsFFLXWMNuhbntC/EgrzHzu7kJ2?=
 =?us-ascii?Q?7YfWmJjQ3Eyqe3fXB6b6gvRINuqEk2/WSx+JknNwRy0EhuqMIgSmwY/OUAaw?=
 =?us-ascii?Q?ug/10ukUdAlupmmzXRooECmpnoJCqx9kr1SJpTVcdBDmfeU34SndlEa2epUI?=
 =?us-ascii?Q?YIk7Uwesw1krw2Cob0dwxmqsE/g3v80sHmBVdY0bfj3UXVorgv8w2Xx58CKH?=
 =?us-ascii?Q?XyCSgM+si3WggBXtJXk0Gz8kMryZ8mRaZsHGkYt2uwU1UpwQFExoKr0N9jjv?=
 =?us-ascii?Q?IUoya0gr3BqMM0LSAImfvDrBh6H8rOtWlzgn6r+5zmzRgSzL9ycV1cc6FaR+?=
 =?us-ascii?Q?XwWvafefEm5KVwVAHv5I52FwbDpaEqxpf0tz6WeDUCLblMiVIS9uBX/MhStj?=
 =?us-ascii?Q?YGQdJFEleMEc92YTpAAZ5JsbwZOOrF+1S7E+tRwh4E7tC747ZEFzLvjM+L5c?=
 =?us-ascii?Q?8wl94w4X3agcsMV7Erk+qQV0wJdQapnl83bJ5Epl9f+mtbEnEpf1zkwOlbcD?=
 =?us-ascii?Q?q/MtX5KagGYhRrZigVaTKwn9293haCYNohwqXnKke8f1abbyys2eR/zEVGlQ?=
 =?us-ascii?Q?Zi2j5M1xLIAPDkml6NCB2/cdFSKLeS4BhW0bnPU4Euq0UMocFv9GqupwxVm7?=
 =?us-ascii?Q?4mcuPvNFKTkxv5OBr0oHCp+JDy7BD+jLBRBS3l2ua3OlkfmEbrrinjYQ+2n8?=
 =?us-ascii?Q?LIjC3XTiH81R+ImhYyXk8eFeH7uCUKMqClvOKhq8kjdJfw/GTevS2k7rG+Hc?=
 =?us-ascii?Q?StvvAlfKze6Ij/3cbLa8hLQQe+YGjN88OXXuVC/j7TPwWQZYSeeFeZvupjuh?=
 =?us-ascii?Q?yta7wWQckjNaQ2DN+3uTU1oZoCEwdRNJpKmL7+0yUgn8KJYy5EcACyBkv9Pq?=
 =?us-ascii?Q?qtq0Sa+W9hM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d1n1k0WyaGTQHUXSmKVVoRXZcAOev8+OT1MyDAs6aX5bY7qZlTBgO5cS/SFc?=
 =?us-ascii?Q?3fW7ebWR82KKtnZyZRk9ssrA1uBf4Sylg1oNEpVj/D9uG4WafCWAidT6A7+t?=
 =?us-ascii?Q?dNujMIp7YOQooAL4Mw3VAhWgosBzjb1ijjW4QOT+X5eVNstIEUdXDYn3sFED?=
 =?us-ascii?Q?b6TkHw5s3d5F4hoKJp3WzO0SqSORgH8xYOnH8R1hgRwLlDiIb34zDKSSXKvb?=
 =?us-ascii?Q?ikvYf6jJAFg/xArgNZA7e/JcWPy77C5bgmX9L/VAwgbmhHdGyN9uKis08Tf4?=
 =?us-ascii?Q?Xi9ovR9GXAll/6MJ1s3Nm5k2KDDTh+WpXewkyeGhaY8fQF2Qlh2S8UVpO5tO?=
 =?us-ascii?Q?49A0GvhW5NMF8tDdpYfVjzWouoApw+xOSao0yaGsfymjZVXUYMxEhOlLP/UE?=
 =?us-ascii?Q?v1JWQdozLAabWM+dOsptBPQjAfvli7SxMXdvKDaYT73TM2yGFzB3PxOMtGyw?=
 =?us-ascii?Q?ZrdlscD0tjDEcx+1nf2/vVUDOZWis8kMspdbJsg3zZF/GYhzxrTWhyxWnS3H?=
 =?us-ascii?Q?gZVLy6CKGHRJ/SkTS19LSU04lrHbALTyE7YQ+YRaegs2BKdaMlDT8mFiyaZP?=
 =?us-ascii?Q?0ysQT43pFnwCab6ns5JB2iOmdFEcKPjzCXHVRjsAqmA1E6VmsCjOeSm54t8S?=
 =?us-ascii?Q?JSZvPhbS3BvkMzDJBhMYp8q4kaL7NwcmD+VA9EMRP907S+QE8GYc3e1bLR4M?=
 =?us-ascii?Q?L7/Nu8ihM3YPZbdcFWH+luABcrTYBDnbMo3ilyJiCC7FQQ6kueLEc3bDP9Sp?=
 =?us-ascii?Q?1bE2bcjqmnOpf93n4+GYsm+Jgz2GmwSmD8ytAQ5lCYzYAqEfkG8DNZJh05RQ?=
 =?us-ascii?Q?5y8ekisdGNvbeIFkPAPCHB6/dXGp/4mwWfRzrvtDF6T3f5uAcBcGkq0We7Ba?=
 =?us-ascii?Q?vpwhDpUbp38rNMGpRjCSXQh7oIcMMVy/KPu4IrazQ4LUiKUn9EqxAUjTVCCZ?=
 =?us-ascii?Q?IYJDBgJ6oo/ypzKF0KBVQh3EqTD68PWEW1Pe3hT3fxDhvuprMm+VRbc+GFu5?=
 =?us-ascii?Q?l97Ootq40tABOivWjQkgM/9H2kA7Wj4IzH0Y1YDlBF9XqiJN7aAvWoujRYYW?=
 =?us-ascii?Q?tnkvd/cq8cm7nFGRGa/6WP76Qa6GNOJsZ9g1b8wQhfwofGCcWn4X7zfw4xUO?=
 =?us-ascii?Q?E5uPnuWeV91IzP8ANldKaGxXj3N9qRnY5IiIR8ykEtzX5gL1pxEHwf+vyf8f?=
 =?us-ascii?Q?M0iamR12Y2Nixpi2VGIKtOZ2tcR1z6gPxDJjcM9bDhN/cp2+2e5eyEaELg/B?=
 =?us-ascii?Q?7sI7vEARuTlNa8MZOGWos+YtAiGBJ46EkFSdbwHTTkz9/pAkWxDo2ZI6+w0p?=
 =?us-ascii?Q?VVnhwM3wqJIY1bvf2rMvup2LbfXQSzuhEfja/1TIXDJhrdenwSjYhrJDrXyb?=
 =?us-ascii?Q?iCpbvaFL76CMCAD+QGvW11f2bjL/q/k2QK+Ay82DSXpDPq0nvK/NHJYSh404?=
 =?us-ascii?Q?mjXryvk0m/lMX4Ppa/vm2XyoS72iPB3k1aaJ30HUxifnm7l2B6nG+9T8kWMQ?=
 =?us-ascii?Q?K3G8imm/NB2Bt+bj17armwyNBDFDYPxi19vLIi+BM38KUdF+xZFXYvz60AUT?=
 =?us-ascii?Q?B6WEDegPnKUpjIQjjdoiNX8/sWQlatWe7bXv5KCOPcGAwWSzWIYXaxVSJfAB?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee04742a-1b40-44bf-fae8-08dd943d31a2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:47:50.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gli6HqymMWxX9qVB6iEApasK2sedkh9GGav9+cY6shu22lnHt5MHoEzA2w0ufceKEMh/wKZXKw2XEX4Z5WXWcUOZtm0Dnfwg5kO+Bry+7sE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
X-OriginatorOrg: intel.com

From: Xu Yilun <yilun.xu@linux.intel.com>

Enable PCI TSM/TSM core to support assigned device authentication in
CoCo VM. The main changes are:

 - Add an ->accept() operation which also flags whether the TSM driver is
   host or guest context.
 - Re-purpose the 'connect' sysfs attribute in guest to lock down the
   private configuration for the device.
 - Add the 'accept' sysfs attribute for guest to accept the private
   device into its TEE.
 - Skip DOE setup/transfer for guest TSM managed devices.

All private capable assigned PCI devices (TDI) start as shared. CoCo VM
should authenticate some of these devices and accept them in its TEE for
private memory access. TSM supports this authentication in 3 steps:
Connect, Attest and Accept.

On Connect, CoCo VM requires hypervisor to finish all private
configurations to the device and put the device in TDISP CONFIG_LOCKED
state. Please note this verb has different meaning from host context. On
host, Connect means establish secure physical link (e.g. PCI IDE).

On Attest, CoCo VM retrieves evidence from device and decide if the
device is good for accept. The CoCo VM kernel provides evidence,
userspace decides if the evidence is good based on its own strategy.

On Accept, userspace has acknowledged the evidence and requires CoCo VM
kernel to enable private MMIO & DMA access. Usually it ends up by put
the device in TDISP RUN state.

Currently only implement Connect & Accept to enable a minimum flow for
device shared <-> private conversion. There is no evidence retrieval
interfaces, only to assume the device evidences are always good without
attestation.

The shared -> private conversion:

  echo 1 > /sys/bus/pci/devices/<...>/tsm/connect
  echo 1 > /sys/bus/pci/devices/<...>/tsm/accept

The private -> shared conversion:

  echo 0 > /sys/bus/pci/devices/<...>/tsm/connect

Since the device's MMIO & DMA are all blocked after Connect & before
Accept, device drivers are not considered workable in this intermediate
state. The Connect and Accept transitions only proceed while the driver is
detached. Note this can be relaxed later with a callback to an enlightened
driver to coordinate the transition, but for now, require detachment.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/tsm.c       | 160 +++++++++++++++++++++++++++++++++++-----
 include/linux/pci-tsm.h |  15 +++-
 2 files changed, 152 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 219e40c5d4e7..794de2f258c3 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -124,6 +124,29 @@ static int pci_tsm_disconnect(struct pci_dev *pdev)
 	return 0;
 }
 
+/*
+ * TDISP locked state temporarily makes the device inaccessible, do not
+ * surprise live attached drivers
+ */
+static int __driver_idle_connect(struct pci_dev *pdev)
+{
+	guard(device)(&pdev->dev);
+	if (pdev->dev.driver)
+		return -EBUSY;
+	return tsm_ops->connect(pdev);
+}
+
+/*
+ * When the registered ops support accept it indicates that this is a
+ * TVM-side (guest) TSM operations structure. In this mode ->connect()
+ * arranges for the TDI to enter TDISP LOCKED state, and ->accept()
+ * transitions the device to RUN state.
+ */
+static bool tvm_mode(void)
+{
+	return !!tsm_ops->accept;
+}
+
 static int pci_tsm_connect(struct pci_dev *pdev)
 {
 	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
@@ -138,13 +161,47 @@ static int pci_tsm_connect(struct pci_dev *pdev)
 	if (tsm->state >= PCI_TSM_CONNECT)
 		return 0;
 
-	rc = tsm_ops->connect(pdev);
+	if (tvm_mode())
+		rc = __driver_idle_connect(pdev);
+	else
+		rc = tsm_ops->connect(pdev);
 	if (rc)
 		return rc;
 	tsm->state = PCI_TSM_CONNECT;
 	return 0;
 }
 
+static int pci_tsm_accept(struct pci_dev *pdev)
+{
+	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
+	int rc;
+
+	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
+	if (!lock)
+		return -EINTR;
+
+	if (tsm->state < PCI_TSM_CONNECT)
+		return -ENXIO;
+	if (tsm->state >= PCI_TSM_ACCEPT)
+		return 0;
+
+	/*
+	 * "Accept" transitions a device to the run state, it is only suitable
+	 * to make that transition from a known DMA-idle (no active mappings)
+	 * state.  The "driver detached" state is a coarse way to assert that
+	 * requirement.
+	 */
+	guard(device)(&pdev->dev);
+	if (pdev->dev.driver)
+		return -EBUSY;
+
+	rc = tsm_ops->accept(pdev);
+	if (rc)
+		return rc;
+	tsm->state = PCI_TSM_ACCEPT;
+	return 0;
+}
+
 /* TODO: switch to ACQUIRE() and ACQUIRE_ERR() */
 static struct rw_semaphore *tsm_read_lock(void)
 {
@@ -196,6 +253,61 @@ static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(connect);
 
+static ssize_t accept_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	bool accept;
+	int rc;
+
+	rc = kstrtobool(buf, &accept);
+	if (rc)
+		return rc;
+
+	if (!accept)
+		return -EINVAL;
+
+	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
+	if (!lock)
+		return -EINTR;
+
+	rc = pci_tsm_accept(pdev);
+	if (rc)
+		return rc;
+
+	return len;
+}
+
+static ssize_t accept_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_tsm_pf0 *tsm;
+
+	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
+	if (!lock)
+		return -EINTR;
+
+	if (!pdev->tsm)
+		return -ENXIO;
+
+	tsm = to_pci_tsm_pf0(pdev->tsm);
+	return sysfs_emit(buf, "%d\n", tsm->state >= PCI_TSM_ACCEPT);
+}
+static DEVICE_ATTR_RW(accept);
+
+static umode_t pci_tsm_pf0_attr_visible(struct kobject *kobj,
+					struct attribute *a, int n)
+{
+	if (!tvm_mode()) {
+		/* Host context, filter out guest only attributes */
+		if (a == &dev_attr_accept.attr)
+			return 0;
+	}
+
+	return a->mode;
+}
+
 static bool pci_tsm_pf0_group_visible(struct kobject *kobj)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -205,10 +317,11 @@ static bool pci_tsm_pf0_group_visible(struct kobject *kobj)
 		return true;
 	return false;
 }
-DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_pf0);
+DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm_pf0);
 
 static struct attribute *pci_tsm_pf0_attrs[] = {
 	&dev_attr_connect.attr,
+	&dev_attr_accept.attr,
 	NULL
 };
 
@@ -322,11 +435,15 @@ EXPORT_SYMBOL_GPL(pci_tsm_initialize);
 int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm)
 {
 	mutex_init(&tsm->lock);
-	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
-					   PCI_DOE_PROTO_CMA);
-	if (!tsm->doe_mb) {
-		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
-		return -ENODEV;
+
+	/* Assigned pci device in guest won't have IDE and DOE exposed. */
+	if (!tvm_mode()) {
+		tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+						   PCI_DOE_PROTO_CMA);
+		if (!tsm->doe_mb) {
+			pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
+			return -ENODEV;
+		}
 	}
 
 	tsm->state = PCI_TSM_INIT;
@@ -483,7 +600,7 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
 {
 	struct pci_tsm_pf0 *tsm;
 
-	if (!pdev->tsm || !is_pci_tsm_pf0(pdev))
+	if (!pdev->tsm || !is_pci_tsm_pf0(pdev) || tvm_mode())
 		return -ENXIO;
 
 	tsm = to_pci_tsm_pf0(pdev->tsm);
@@ -495,8 +612,8 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
 }
 EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
 
-/* lookup the 'DSM' pf0 for @pdev */
-static struct pci_dev *tsm_pf0_get(struct pci_dev *pdev)
+/* lookup the Device Security Manager (DSM) pf0 for @pdev */
+static struct pci_dev *dsm_dev_get(struct pci_dev *pdev)
 {
 	struct pci_dev *uport_pf0;
 
@@ -558,11 +675,11 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
 	if (!pdev->tsm)
 		return -EINVAL;
 
-	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
-	if (!pf0_dev)
+	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
+	if (!dsm_dev)
 		return -EINVAL;
 
-	struct mutex *ops_lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
+	struct mutex *ops_lock __free(tdi_ops_unlock) = tdi_ops_lock(dsm_dev);
 	if (IS_ERR(ops_lock))
 		return PTR_ERR(ops_lock);
 
@@ -573,10 +690,13 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
 			return -EBUSY;
 	}
 
-	tdi = tsm_ops->bind(pdev, pf0_dev, kvm, tdi_id);
+	tdi = tsm_ops->bind(pdev, dsm_dev, kvm, tdi_id);
 	if (!tdi)
 		return -ENXIO;
 
+	tdi->pdev = pdev;
+	tdi->dsm_dev = dsm_dev;
+	tdi->kvm = kvm;
 	pdev->tsm->tdi = tdi;
 
 	return 0;
@@ -592,11 +712,11 @@ static int __pci_tsm_unbind(struct pci_dev *pdev)
 	if (!pdev->tsm)
 		return -EINVAL;
 
-	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
-	if (!pf0_dev)
+	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
+	if (!dsm_dev)
 		return -EINVAL;
 
-	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
+	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(dsm_dev);
 	if (IS_ERR(lock))
 		return PTR_ERR(lock);
 
@@ -641,11 +761,11 @@ int pci_tsm_guest_req(struct pci_dev *pdev, struct pci_tsm_guest_req_info *info)
 	if (!pdev->tsm)
 		return -ENODEV;
 
-	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
-	if (!pf0_dev)
+	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
+	if (!dsm_dev)
 		return -EINVAL;
 
-	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
+	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(dsm_dev);
 	if (IS_ERR(lock))
 		return -ENODEV;
 
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 2328037ae4d1..1920ca591a42 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -11,6 +11,7 @@ enum pci_tsm_state {
 	PCI_TSM_ERR = -1,
 	PCI_TSM_INIT,
 	PCI_TSM_CONNECT,
+	PCI_TSM_ACCEPT,
 };
 
 /**
@@ -32,12 +33,12 @@ enum pci_tsm_type {
 /**
  * struct pci_tdi - TDI context
  * @pdev: host side representation of guest-side TDI
- * @dsm: PF0 PCI device that can modify TDISP state for the TDI
+ * @dsm_dev: PF0 PCI device that can modify TDISP state for the TDI
  * @kvm: TEE VM context of bound TDI
  */
 struct pci_tdi {
 	struct pci_dev *pdev;
-	struct pci_dev *dsm;
+	struct pci_dev *dsm_dev;
 	struct kvm *kvm;
 };
 
@@ -69,7 +70,12 @@ struct pci_tsm_pf0 {
 	struct pci_tsm tsm;
 	enum pci_tsm_state state;
 	struct mutex lock;
-	struct pci_doe_mb *doe_mb;
+	union {
+		struct {	/* host pf0 tsm */
+			struct pci_doe_mb *doe_mb;
+		};
+		/* To be added: guest tsm */
+	};
 };
 
 /* physical function0 and capable of 'connect' */
@@ -135,6 +141,8 @@ struct pci_tsm_guest_req_info {
  * @bind: establish a secure binding with the TVM
  * @unbind: teardown the secure binding
  * @guest_req: handle the vendor specific requests from TVM when bound
+ * @accept: TVM-only operation to confirm that system policy allows
+ *	    device to access private memory and be mapped with private mmio.
  *
  * @probe and @remove run in pci_tsm_rwsem held for write context. All
  * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
@@ -150,6 +158,7 @@ struct pci_tsm_ops {
 	void (*unbind)(struct pci_tdi *tdi);
 	int (*guest_req)(struct pci_dev *pdev,
 			 struct pci_tsm_guest_req_info *info);
+	int (*accept)(struct pci_dev *pdev);
 };
 
 enum pci_doe_proto {
-- 
2.49.0



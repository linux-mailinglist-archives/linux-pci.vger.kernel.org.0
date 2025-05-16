Return-Path: <linux-pci+bounces-27828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 931C6AB959F
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1979F1BA5232
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 05:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5811221FCE;
	Fri, 16 May 2025 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2e9TRW3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69320221D9E
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374487; cv=fail; b=ZwskTjpMVaxgwBVrPTj9ntfOWuOii1co9QmvtavU9cATE42NUFyVBSowtisbKIDqf+QwpKYapbIWjNUKD5p10ceeJBmVhHhkywIBfV6ySd9PeLSmw1KhFP54bV8TPs7QmYFuuhMNDMmqSthNUyOIti0YyJcN/8YVOZnXXy3M+EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374487; c=relaxed/simple;
	bh=CmQ6UTY4Hs/fYrcUIC23pLkQJ0DIC129tgOiRRqHtBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cbkvtP4NP/V1/BGHNEeT4HNPsfDYSJ6ZOCI5eQ/FXigKp9gFF98gmhDoFJqfKIiI2lqeaY575qk9f6xnnrHUo6/l9dGCZokI/ZPFUuwTP9eY69tQO5yUcw5DRtNz7tIweVLf4bCtbrWj1GkXA9KFTPLukufYthGBeIQeWYQ+q3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2e9TRW3; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747374485; x=1778910485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CmQ6UTY4Hs/fYrcUIC23pLkQJ0DIC129tgOiRRqHtBM=;
  b=f2e9TRW3a7w/0mDP2Ojpq9XPJEdaisaV0nal1M0/pf6Zn06BMsLosqNe
   gcB7HhQOk18tO54H7bemFPpvBtvjJRqutsFoYXD6C9DzBX5ZiBc/4/iK2
   YdYk1QIcgZkfW7z1lCVH+6kO4XtQKb6OjqNXhWIHQttMfj//gcf94iHPy
   J7zXUZ3GT7mrUw1EDVRX4AYhOaf0ymkbQCymfdwYtDdV2np/XGFL47fK2
   JcyUL/r4riyO8Y8ApR0oVWyUsAH8GuaKWvwsv23hg1shAd4Txh8Rdp89k
   30Qn417J1VCU252YgbEIC/Mxt55iRicSXHZmUFrPjwEBmUm7obeCu66A3
   g==;
X-CSE-ConnectionGUID: ko68YYlHRvimxnpwG4dycQ==
X-CSE-MsgGUID: WDi5unbCSXy/0tiqa9eD2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36952847"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="36952847"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:48:02 -0700
X-CSE-ConnectionGUID: VHPCQin/QcSRZswRP6BzKw==
X-CSE-MsgGUID: mW7FdhhcQ5WqwThByOMctg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139084728"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:47:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 22:47:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 22:47:49 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 22:47:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m065EvVJnX0X5bIySMJkq9yl8AOkuWwxhEZBdKcHnGyRYLj5ddIBG8ZANEYb1lM9D6ctq801JHODSYnZZLE+QjW63Bj1cAZtAEybGqQWGXuX4yQP6/216DHHUtrsItRwkF2QLZLSTIlWVErRa9mUfQfwFLV9mExrYHlamsmfIBi7b6LxTzfzNQYqsIEq/DFpO9u6VEqJ2aGjJeBxA/r5lIF9lIfhqv0RvFYb7Hxxhwa5v4ppeiq9fP9WrpqY38sBKYBaw+8UJAESGvAGJcljlDinJGDNMS+ga3E+vRL4pbYgp05tslYp2KOc9DIrqZp6LWWa6i2wa2PWdHY8QeQsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ty4CxP1045Egdxdzslu03/hV8tl1jFwtcXAy5Y87qw=;
 b=WNup9dHRmJThpCPvpt4ucKUM/Oyao60lG80XQduWzRcM18rXxyEZ2pjaPPgmb173h1MuCaAdKXJdduMXIEWgF1jxo1H27NOwx40ExU7tTVx3VJfNcXTlW1Eduog55HJmOmLeuvzdmhB65DUKv5aJnEGdqatlhgUd/zsk1vmVyayVXTgFIFqs/bMVUaGfLOHEcXem4MAJRY3zDmQmKgOxZPUv68MbIs81WULLJmFY/tho/CN9tld2GvYYGKhpaXwl7e7bQ6kqPv6CbuH6xyeVyPDt/C/Bj/s4zunIuBzbNiX5uY89dZW9a/NwuIS3I24f5QwL+BX4zTAh+X9H4cIwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 05:47:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 05:47:45 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Yilun Xu <yilun.xu@linux.intel.com>
Subject: [PATCH v3 08/13] PCI/IDE: Add IDE establishment helpers
Date: Thu, 15 May 2025 22:47:27 -0700
Message-ID: <20250516054732.2055093-9-dan.j.williams@intel.com>
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
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e91449-c88a-4486-b6f2-08dd943d2e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QYwpqABrTWiZRfdU0W+WuQtchO6D5kUlyAOWvJzUocaT0Jmqr0DbChueqTHG?=
 =?us-ascii?Q?cuQiCHU12x79a5sR4tyBXnOwB2goaBi/czM+c13xKvz7sH1GS/9UgXjJbg44?=
 =?us-ascii?Q?HTIsT3obro2T1Okt5zpLJ7KCAgpYbXnvX0bA04eLpijC7Wlg2RcwfYe3Bqai?=
 =?us-ascii?Q?91zlZkDkMg7K2k0US5u8JBX6riZr0h/0VFi4NNH0BKU8YWakpA+mRZy/vJP+?=
 =?us-ascii?Q?uSQuut29aqfA8Aqlf0fz8wVIhzVOYqoJNqyqdUORftzQtDY0htry/w3hUo5m?=
 =?us-ascii?Q?TFQtdyBqEmBcbwVO8vVOkQv06jih7vf6dJE2CZwXCezw++mCxDDGZxEBIEW6?=
 =?us-ascii?Q?78pc2X21TP47EijV9rf+2D5Zv5fLeD6DLiEazBVR3J0p5owdr5MHmufQEobv?=
 =?us-ascii?Q?o0+J6+O1ffJWHEFQkBdqRoiyQg3+D7voDca/BhZ1f6UzWosMfoKFuUH2k0vl?=
 =?us-ascii?Q?/1hEg8KOXlNZi1DXUJ7KDCglpkgTOx5V7TkwNxI06TiksuGa3VmTooud8IjM?=
 =?us-ascii?Q?9qIfmyEPQ0wNSlbTBheV6LEqxfBJN2e7ntX8vO4SqcpljXh13LQq82jstP7u?=
 =?us-ascii?Q?uBFrksMP795q1kf/sSraybuVK/ns6MzSC2Nhv1GHCYiX7CrHqPxdHA25m1lM?=
 =?us-ascii?Q?QF4NoBgEF75Dt9lpPbKJ8jythaFYUPOgc8QhDsmJMnqMRhFBnWV9ZkU9kNS0?=
 =?us-ascii?Q?hgA3uODBKwmGtrlDEPBA6+FDeJoRMeSQXB/cTIZtDnEcRxvtRoF9koROZxLj?=
 =?us-ascii?Q?3NH6OwbLLn8OsS1MKF7MRnGFmc843yYAfHHjlNhStcrfSC7Yh8qPmbIn2IDB?=
 =?us-ascii?Q?CpExieNluC9j6hjKkU7AGNn9Vww/egT6V9XHuxHlyhbAeoBC6UrO6aI2PBqi?=
 =?us-ascii?Q?JgWglNKvhLjUayD2s4ZWufmfMXn9EuA/JKruq1GqZurPkDrsEH9Zy0oIU/x7?=
 =?us-ascii?Q?+VdVa8UP+bjwLXwDdKkpVJ0stpD24RPPRlz1iyrJaRtR0AytlOAYIQ9OZOBq?=
 =?us-ascii?Q?TgbwmvI0AfZPgbxrnQDUMXHa8aB2uGtIoXKkxnQJXlL1Y+/b8iDJb2ULroI7?=
 =?us-ascii?Q?uXdNor1m/rzvDbCeXHpTLW/LAfW6oLZagiS9zu9FhDOBwoYSTeiySX9KowxU?=
 =?us-ascii?Q?9wkqoroqGGk0l1A7FlzEUbzIj2LCkYEPTHhcs5gMXy4ik5XBLeBG0gU1MfKR?=
 =?us-ascii?Q?iYdo7KQH0U4R7JrXItA/6X1Mq/8ZVTyG8x3aaVjNSB1z+yTwuUsoro41Wu2o?=
 =?us-ascii?Q?rw+Fgge4r87O93/sXRwv1yJu47o+PvuJzCLqwkzo89FTjP5/yeGWN4CctG46?=
 =?us-ascii?Q?1agoYYsEju6t5OL8GryvZ3BC/Fp81JMWwwnUbhpy/y0GRrS+E+WE14mDtKZb?=
 =?us-ascii?Q?9PVtDIAcYjY0724GtEXB1AFmCLSX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fgSaKM0jIXJMzuZ8XCfPSXwdIHCeTt/Q4nQDpD1gkFTI0zuRkYl56W317dE+?=
 =?us-ascii?Q?zEfpo2236woIFDlFADMcFQ80JrSFJ4BFjDRWCSZ+cY2+5KzJFrsZZXKoXi7c?=
 =?us-ascii?Q?SFd8ufWibi56E5Irnmya64sbx+Vg4FZ5MVjuUx+FEAYZqyItMjzL4Z2YxyjE?=
 =?us-ascii?Q?Jwzpt1rPB9VdHYblSYi45+PPIxpBFCa6I+EpF6vkvFVT0mNrnUwwI9Z7Pl+8?=
 =?us-ascii?Q?T9oto/dolmTf9+NGrk2cugUOhDdjq8GzXaEtBwgSja3x04cAb2Mbz9hT890k?=
 =?us-ascii?Q?ab2x/fNQQxA+kV4uB9VOpKHIemektlRRY6nKpw7TfBFiAEb4iSybg46K/HsH?=
 =?us-ascii?Q?oJfmX9vgf537dOPhnuVsX1M1YTHYeoAcMxoupPgVKoQyV7e17Y2NMbj6y2A4?=
 =?us-ascii?Q?NC7QmFcuuEv82b5pdmkIw5CRJ/y/k/+XtU8dFEthAB6G1L5t+/LE9SXeFm3C?=
 =?us-ascii?Q?vsNaMMnvsLIkkctQ9awegXpmV1Zm9A/YSSMufvA9E+OubtopImcRKY4yiEzJ?=
 =?us-ascii?Q?5Juk0uuBzJXn2KGGNq1479N0HEnDvNlSgCcA0xQSV2e0XERPJGgLBn2dNMC+?=
 =?us-ascii?Q?73fAt1b4Ksl2lFz8f8yVxie+e9OzQK2FcSo2op2+3l7+VbAdL8oEkrgeXdCD?=
 =?us-ascii?Q?lcdixr2ZNCLbJ6RwAH2BPqM1/JlLNn7u7fbJKj4954U2piiTOEj9sneNWZTr?=
 =?us-ascii?Q?vAWYQvPiw1+18qPUivMTheA3JxZJ7tlTVJn2WvA8Ps7/S+gkGPEfHz/yuCA6?=
 =?us-ascii?Q?V5VSAKFV84o8gvzmMXS2oUxXPLtlEEMs4wfA5jdb1IDdo5Ct7gZycNwa5N7C?=
 =?us-ascii?Q?qftwedf3YZa16SKr0vx4XZnv3G/8fV4JctGDH+P/thXKdxuOqg5bBGvQvAPx?=
 =?us-ascii?Q?IUWYtYhzMzSgVQ1Q5uTT6azdxeaYlLY4jnxKQ77xXBuqU28EWsEP0k0c/lcg?=
 =?us-ascii?Q?nkxtaM3bwS/GDcJpRFLdY4oqo15cy+n5at8/meWaqFC17bTrNoy5MhsbFFb1?=
 =?us-ascii?Q?s1OEfvWAmmgU/C8fB6Vip+4KbeUupIuiPG+1e+1+85M/oMdJLp+zmOdpYQsy?=
 =?us-ascii?Q?oyOzYUhJTN44r+89c6X2YGpGvsPreATbVbvpzL50DQDWQWPZlZKC0GTr8Cl6?=
 =?us-ascii?Q?QRVylXN+M5y44HiEnyASiDBcY0wNz7AD0dA1ZXSNQ2j8ma1OQi2ivxA1/LA+?=
 =?us-ascii?Q?Mm0bGRxAFtRp+cLMnhuuBWEgJ1X2kJCQnVW25zuSviExysH6c9Hmpq4cjzE2?=
 =?us-ascii?Q?x2+Og7if1l0tuHmVDVj3vQ3tM3uQVTdey5CyRnQuPouDrEluPz667DVP91wo?=
 =?us-ascii?Q?gr3vRUA6AlIFL9tEKlA/gt9WKYuYSgcKGtrrNG88lnc9juefjOZuyjseAWX0?=
 =?us-ascii?Q?ZRvw+gra2o9E3yFA91mIfFD/GxM39Kme6s2HrA5HCVn2KXFMxfbFfq+Gq2p6?=
 =?us-ascii?Q?twPq87fBjzMtWRcuF7blFzjARH54lTHux2wz1JtCfRDpjrYmX49AS1P0x5pZ?=
 =?us-ascii?Q?n+n7dEC28FO0P52pY2T/dxixDX8oLlXdqk+6ESs0DBDOI39oOvKulrzyqxC/?=
 =?us-ascii?Q?nPVSrgfeDPQARUkR6ApoxbU//X72RthEfC8Xzl+0nxd2pSLeRf9Bej58+A5g?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e91449-c88a-4486-b6f2-08dd943d2e91
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:47:45.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bh6BjBpuhYUyeUJMwvYanvpKc4YGibgDepp4UN/rONzqRqnaG0Xmt0vBnU5UfQKD42VkLQleq3rir5/LiKHV/sgXkGUggyf9YWH3zEkNKUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
X-OriginatorOrg: intel.com

There are two components to establishing an encrypted link, provisioning
the stream in Partner Port config-space, and programming the keys into
the link layer via IDE_KM (IDE Key Management). This new library,
drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
driver, is saved for later.

With the platform TSM implementations of SEV-TIO and TDX Connect in mind
this library abstracts small differences in those implementations. For
example, TDX Connect handles Root Port register setup while SEV-TIO
expects System Software to update the Root Port registers. This is the
rationale for fine-grained 'setup' + 'enable' verbs.

The other design detail for TSM-coordinated IDE establishment is that
the TSM may manage allocation of Stream IDs, this is why the Stream ID
value is passed in to pci_ide_stream_setup().

The flow is:

pci_ide_stream_alloc()
  Allocate a Selective IDE Stream Register Block in each Partner Port
  (Endpoint + Root Port), and reserve a host bridge / platform stream
  slot. Gather Partner Port specific stream settings like Requester ID.
pci_ide_stream_register()
  Publish the stream in sysfs after allocating a Stream ID. In the TSM
  case the TSM allocates the Stream ID for the Partner Port pair.
pci_ide_stream_setup()
  Program the stream settings to a Partner Port. Caller is responsible
  for optionally calling this for the Root Port as well if the TSM
  implementation requires it.
pci_ide_stream_enable()
  Try to run the stream after IDE_KM.

In support of system administrators auditing where platform, Root Port,
and Endpoint IDE stream resources are being spent, the allocated stream
is reflected as a symlink from the host bridge to the endpoint with the
name:

    stream%d.%d.%d:%s

Where the tuple of integers reflects the allocated platform, Root Port,
and Endpoint stream index (Selective IDE Stream Register Block) values,
and the %s is the endpoint device name.

Thanks to Wu Hao for a draft implementation of this infrastructure.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Co-developed-by: Yilun Xu <yilun.xu@linux.intel.com>
Signed-off-by: Yilun Xu <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .../ABI/testing/sysfs-devices-pci-host-bridge |  38 ++
 MAINTAINERS                                   |   1 +
 drivers/pci/ide.c                             | 366 ++++++++++++++++++
 include/linux/pci-ide.h                       |  76 ++++
 include/linux/pci.h                           |   6 +
 include/uapi/linux/pci_regs.h                 |   2 +
 6 files changed, 489 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
 create mode 100644 include/linux/pci-ide.h

diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
new file mode 100644
index 000000000000..d592b68c7333
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
@@ -0,0 +1,38 @@
+What:		/sys/devices/pciDDDD:BB
+		/sys/devices/.../pciDDDD:BB
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		A PCI host bridge device parents a PCI bus device topology. PCI
+		controllers may also parent host bridges. The DDDD:BB format
+		conveys the PCI domain (ACPI segment) number and root bus number
+		(in hexadecimal) of the host bridge. Note that the domain number
+		may be larger than the 16-bits that the "DDDD" format implies
+		for emulated host-bridges.
+
+What:		pciDDDD:BB/firmware_node
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) Symlink to the platform firmware device object "companion"
+		of the host bridge. For example, an ACPI device with an _HID of
+		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00). See
+		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
+		format.
+
+What:		pciDDDD:BB/streamH.R.E:DDDD:BB:DD:F
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a platform has established a secure connection, PCIe
+		IDE, between two Partner Ports, this symlink appears. The
+		primary function is to account the stream slot / resources
+		consumed in each of the (H)ost bridge, (R)oot Port and
+		(E)ndpoint that will be freed when invoking the tsm/disconnect
+		flow. The link points to the endpoint PCI device at domain:DDDD
+		bus:BB device:DD function:F. Where R and E represent the
+		assigned Selective IDE Stream Register Block in the Root Port
+		and Endpoint, and H represents a platform specific pool of
+		stream resources shared by the Root Ports in a host bridge.  See
+		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
+		format.
diff --git a/MAINTAINERS b/MAINTAINERS
index 2fcbd29853a8..e4c3da0b570b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18677,6 +18677,7 @@ Q:	https://patchwork.kernel.org/project/linux-pci/list/
 B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
+F:	Documentation/ABI/testing/sysfs-devices-pci-host-bridge
 F:	Documentation/PCI/
 F:	Documentation/devicetree/bindings/pci/
 F:	arch/x86/kernel/early-quirks.c
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 98a51596e329..a529926647f4 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -5,6 +5,8 @@
 
 #define dev_fmt(fmt) "PCI/IDE: " fmt
 #include <linux/pci.h>
+#include <linux/sysfs.h>
+#include <linux/pci-ide.h>
 #include <linux/bitfield.h>
 #include "pci.h"
 
@@ -96,5 +98,369 @@ void pci_ide_init(struct pci_dev *pdev)
 
 	pdev->ide_cap = ide_cap;
 	pdev->nr_link_ide = nr_link_ide;
+	pdev->nr_sel_ide = nr_streams;
 	pdev->nr_ide_mem = nr_ide_mem;
 }
+
+struct stream_index {
+	unsigned long *map;
+	u8 max, stream_index;
+};
+
+static void free_stream_index(struct stream_index *stream)
+{
+	clear_bit_unlock(stream->stream_index, stream->map);
+}
+
+DEFINE_FREE(free_stream, struct stream_index *, if (_T) free_stream_index(_T))
+static struct stream_index *alloc_stream_index(unsigned long *map, u8 max,
+					       struct stream_index *stream)
+{
+	if (!max)
+		return NULL;
+
+	do {
+		u8 stream_index = find_first_zero_bit(map, max);
+
+		if (stream_index == max)
+			return NULL;
+		if (!test_and_set_bit_lock(stream_index, map)) {
+			*stream = (struct stream_index) {
+				.map = map,
+				.max = max,
+				.stream_index = stream_index,
+			};
+			return stream;
+		}
+		/* collided with another stream acquisition */
+	} while (1);
+}
+
+/**
+ * pci_ide_stream_alloc() - Reserve stream indices and probe for settings
+ * @pdev: IDE capable PCIe Endpoint Physical Function
+ *
+ * Retrieve the Requester ID range of @pdev for programming its Root
+ * Port IDE RID Association registers, and conversely retrieve the
+ * Requester ID of the Root Port for programming @pdev's IDE RID
+ * Association registers.
+ *
+ * Allocate a Selective IDE Stream Register Block instance per port.
+ *
+ * Allocate a platform stream resource from the associated host bridge.
+ * Retrieve stream association parameters for Requester ID range and
+ * address range restrictions for the stream.
+ */
+struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
+{
+	/* EP, RP, + HB Stream allocation */
+	struct stream_index __stream[PCI_IDE_PARTNER_MAX + 1];
+	struct pci_host_bridge *hb;
+	struct pci_dev *rp;
+	int num_vf, rid_end;
+
+	if (!pci_is_pcie(pdev))
+		return NULL;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return NULL;
+
+	if (!pdev->ide_cap)
+		return NULL;
+
+	/*
+	 * Catch buggy PCI platform initialization (missing
+	 * pci_ide_init_nr_streams())
+	 */
+	hb = pci_find_host_bridge(pdev->bus);
+	if (WARN_ON_ONCE(!hb->nr_ide_streams))
+		return NULL;
+
+	struct pci_ide *ide __free(kfree) = kzalloc(sizeof(*ide), GFP_KERNEL);
+	if (!ide)
+		return NULL;
+
+	struct stream_index *hb_stream __free(free_stream) = alloc_stream_index(
+		hb->ide_stream_map, hb->nr_ide_streams, &__stream[PCI_IDE_HB]);
+	if (!hb_stream)
+		return NULL;
+
+	rp = pcie_find_root_port(pdev);
+	struct stream_index *rp_stream __free(free_stream) = alloc_stream_index(
+		rp->ide_stream_map, rp->nr_sel_ide, &__stream[PCI_IDE_RP]);
+	if (!rp_stream)
+		return NULL;
+
+	struct stream_index *ep_stream __free(free_stream) = alloc_stream_index(
+		pdev->ide_stream_map, pdev->nr_sel_ide, &__stream[PCI_IDE_EP]);
+	if (!ep_stream)
+		return NULL;
+
+	/* for SR-IOV case, cover all VFs */
+	num_vf = pci_num_vf(pdev);
+	if (num_vf)
+		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
+				    pci_iov_virtfn_devfn(pdev, num_vf));
+	else
+		rid_end = pci_dev_id(pdev);
+
+	*ide = (struct pci_ide) {
+		.pdev = pdev,
+		.partner = {
+			[PCI_IDE_EP] = {
+				.rid_start = pci_dev_id(rp),
+				.rid_end = pci_dev_id(rp),
+				.stream_index = no_free_ptr(ep_stream)->stream_index,
+			},
+			[PCI_IDE_RP] = {
+				.rid_start = pci_dev_id(pdev),
+				.rid_end = rid_end,
+				.stream_index = no_free_ptr(rp_stream)->stream_index,
+			},
+		},
+		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
+		.stream_id = -1,
+	};
+
+	return_ptr(ide);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_alloc);
+
+/**
+ * pci_ide_stream_free() - unwind pci_ide_stream_alloc()
+ * @ide: idle IDE settings descriptor
+ *
+ * Free all of the stream index (register block) allocations acquired by
+ * pci_ide_stream_alloc(). The stream represented by @ide is assumed to
+ * be unregistered and not instantiated in any device.
+ */
+void pci_ide_stream_free(struct pci_ide *ide)
+{
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
+
+	clear_bit_unlock(ide->partner[PCI_IDE_EP].stream_index,
+			 pdev->ide_stream_map);
+	clear_bit_unlock(ide->partner[PCI_IDE_RP].stream_index,
+			 rp->ide_stream_map);
+	clear_bit_unlock(ide->host_bridge_stream, hb->ide_stream_map);
+	kfree(ide);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_free);
+
+/**
+ * pci_ide_stream_register() - Prepare to activate an IDE Stream
+ * @ide: IDE settings descriptor
+ *
+ * After a Stream ID has been acquired for @ide, record the presence of
+ * the stream in sysfs. The expectation is that @ide is immutable while
+ * registered.
+ */
+int pci_ide_stream_register(struct pci_ide *ide)
+{
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
+	u8 ep_stream, rp_stream;
+	int rc;
+
+	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
+		pci_err(pdev, "Setup fail: Invalid Stream ID: %d\n", ide->stream_id);
+		return -ENXIO;
+	}
+
+	ep_stream = ide->partner[PCI_IDE_EP].stream_index;
+	rp_stream = ide->partner[PCI_IDE_RP].stream_index;
+	const char *name __free(kfree) = kasprintf(
+		GFP_KERNEL, "stream%d.%d.%d:%s", ide->host_bridge_stream,
+		rp_stream, ep_stream, dev_name(&pdev->dev));
+	if (!name)
+		return -ENOMEM;
+
+	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, name);
+	if (rc)
+		return rc;
+
+	ide->name = no_free_ptr(name);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_register);
+
+/**
+ * pci_ide_stream_unregister() - unwind pci_ide_stream_register()
+ * @ide: idle IDE settings descriptor
+ *
+ * In preparation for freeing @ide, remove sysfs enumeration for the
+ * stream.
+ */
+void pci_ide_stream_unregister(struct pci_ide *ide)
+{
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
+
+	sysfs_remove_link(&hb->dev.kobj, ide->name);
+	kfree(ide->name);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_unregister);
+
+int pci_ide_domain(struct pci_dev *pdev)
+{
+	if (pdev->fm_enabled)
+		return pci_domain_nr(pdev->bus);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_ide_domain);
+
+struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	if (!pci_is_pcie(pdev)) {
+		pci_warn_once(pdev, "not a PCIe device\n");
+		return NULL;
+	}
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ENDPOINT:
+		if (pdev != ide->pdev) {
+			pci_warn_once(pdev, "setup expected Endpoint: %s\n", pci_name(ide->pdev));
+			return NULL;
+		}
+		return &ide->partner[PCI_IDE_EP];
+	case PCI_EXP_TYPE_ROOT_PORT: {
+		struct pci_dev *rp = pcie_find_root_port(ide->pdev);
+
+		if (pdev != rp) {
+			pci_warn_once(pdev, "setup expected Root Port: %s\n",
+				      pci_name(rp));
+			return NULL;
+		}
+		return &ide->partner[PCI_IDE_RP];
+	}
+	default:
+		pci_warn_once(pdev, "invalid device type\n");
+		return NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(pci_ide_to_settings);
+
+static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide, int pos,
+			    bool enable)
+{
+	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_EN, enable);
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
+}
+
+/**
+ * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered IDE settings descriptor
+ *
+ * When @pdev is a PCI_EXP_TYPE_ENDPOINT then the PCI_IDE_EP partner
+ * settings are written to @pdev's Selective IDE Stream register block,
+ * and when @pdev is a PCI_EXP_TYPE_ROOT_PORT, the PCI_IDE_RP settings
+ * are selected.
+ */
+void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
+	int pos;
+	u32 val;
+
+	if (!settings)
+		return;
+
+	pos = sel_ide_offset(pdev, settings);
+
+	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, settings->rid_end);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
+
+	val = PREP_PCI_IDE_SEL_RID_2(settings->rid_start, pci_ide_domain(pdev));
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
+
+	/*
+	 * Setup control register early for devices that expect
+	 * stream_id is set during key programming.
+	 */
+	set_ide_sel_ctl(pdev, ide, pos, false);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
+
+/**
+ * pci_ide_stream_teardown() - disable the stream and clear all settings
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered IDE settings descriptor
+ *
+ * For stream destruction, zero all registers that may have been written
+ * by pci_ide_stream_setup(). Consider pci_ide_stream_disable() to leave
+ * settings in place while temporarily disabling the stream.
+ */
+void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
+	int pos;
+
+	if (!settings)
+		return;
+
+	pos = sel_ide_offset(pdev, settings);
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_teardown);
+
+/**
+ * pci_ide_stream_enable() - after setup, enable the stream
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered and setup IDE settings descriptor
+ *
+ * Activate the stream by writing to the Selective IDE Stream Control Register.
+ */
+int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
+	int pos;
+	u32 val;
+
+	if (!settings)
+		return -ENXIO;
+
+	pos = sel_ide_offset(pdev, settings);
+
+	set_ide_sel_ctl(pdev, ide, pos, true);
+
+	pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
+	if (FIELD_GET(PCI_IDE_SEL_STS_STATE_MASK, val) !=
+	    PCI_IDE_SEL_STS_STATE_SECURE)
+		return -ENXIO;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_enable);
+
+/**
+ * pci_ide_stream_disable() - disable the given stream
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered and setup IDE settings descriptor
+ *
+ * Clear the Selective IDE Stream Control Register, but leave all other
+ * registers untouched.
+ */
+void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
+	int pos;
+
+	if (!settings)
+		return;
+
+	pos = sel_ide_offset(pdev, settings);
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
new file mode 100644
index 000000000000..0753c3cd752a
--- /dev/null
+++ b/include/linux/pci-ide.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
+
+#ifndef __PCI_IDE_H__
+#define __PCI_IDE_H__
+
+#include <linux/range.h>
+
+#define SEL_ADDR1_LOWER_MASK GENMASK(31, 20)
+#define SEL_ADDR_UPPER_MASK GENMASK_ULL(63, 32)
+#define PREP_PCI_IDE_SEL_ADDR1(base, limit)                    \
+	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |             \
+	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,          \
+		    FIELD_GET(SEL_ADDR1_LOWER_MASK, (base))) | \
+	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,         \
+		    FIELD_GET(SEL_ADDR1_LOWER_MASK, (limit))))
+
+#define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
+	(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
+	 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, (base)) | \
+	 FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, (domain)))
+
+enum pci_ide_partner_select {
+	PCI_IDE_EP,
+	PCI_IDE_RP,
+	PCI_IDE_PARTNER_MAX,
+	/* pci_ide_stream_alloc() uses this for stream index allocation */
+	PCI_IDE_HB = PCI_IDE_PARTNER_MAX,
+};
+
+/**
+ * struct pci_ide_partner - Per port IDE Stream settings
+ * @rid_start: Partner Port Requester ID range start
+ * @rid_start: Partner Port Requester ID range end
+ * @stream_index: Selective IDE Stream Register Block selection
+ */
+struct pci_ide_partner {
+	u16 rid_start;
+	u16 rid_end;
+	u8 stream_index;
+};
+
+/**
+ * struct pci_ide - PCIe Selective IDE Stream descriptor
+ * @pdev: PCIe Endpoint for the stream
+ * @partner: settings for both partner ports in a stream
+ * @host_bridge_stream: track platform Stream index
+ * @stream_id: unique id (within Partner Port pairing) for the stream
+ * @name: name of the stream in sysfs
+ *
+ * Negative @stream_id values indicate "uninitialized" on the
+ * expectation that with TSM established IDE the TSM owns the stream_id
+ * allocation.
+ */
+struct pci_ide {
+	struct pci_dev *pdev;
+	struct pci_ide_partner partner[PCI_IDE_PARTNER_MAX];
+	u8 host_bridge_stream;
+	int stream_id;
+	const char *name;
+};
+
+int pci_ide_domain(struct pci_dev *pdev);
+struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide);
+struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
+void pci_ide_stream_free(struct pci_ide *ide);
+DEFINE_FREE(pci_ide_stream_free, struct pci_ide *, if (_T) pci_ide_stream_free(_T))
+int  pci_ide_stream_register(struct pci_ide *ide);
+void pci_ide_stream_unregister(struct pci_ide *ide);
+void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide);
+void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide);
+int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide);
+void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide);
+#endif /* __PCI_IDE_H__ */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d8dd315d8b4c..d1c901904ee4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -538,6 +538,8 @@ struct pci_dev {
 	u16		ide_cap;	/* Link Integrity & Data Encryption */
 	u8		nr_ide_mem;	/* Address association resources for streams */
 	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
+	u8		nr_sel_ide;	/* Selective Stream count (register block allocator) */
+	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
 	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
 	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
 #endif
@@ -605,6 +607,10 @@ struct pci_host_bridge {
 	int		domain_nr;
 	struct list_head windows;	/* resource_entry */
 	struct list_head dma_ranges;	/* dma ranges resource list */
+#ifdef CONFIG_PCI_IDE
+	u8 nr_ide_streams;		/* Track available vs in-use streams */
+	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
+#endif
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 670314666fdd..0ae7e77313f8 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1286,6 +1286,8 @@
 /* Selective IDE Stream Status Register */
 #define  PCI_IDE_SEL_STS		 8
 #define   PCI_IDE_SEL_STS_STATE_MASK	 __GENMASK(3, 0) /* Selective IDE Stream State */
+#define   PCI_IDE_SEL_STS_STATE_INSECURE 0
+#define   PCI_IDE_SEL_STS_STATE_SECURE   2
 #define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
 /* IDE RID Association Register 1 */
 #define  PCI_IDE_SEL_RID_1		 0xc
-- 
2.49.0



Return-Path: <linux-pci+bounces-32289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ED4B07ABE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E213F7B141D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F132F5C41;
	Wed, 16 Jul 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Px4jyw3Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CC22F5C34;
	Wed, 16 Jul 2025 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682142; cv=fail; b=Egy/xVLmqNHmswqz7cwTDJNsktSucKiKlfOfg9wKPJ+cZl5lzdZbcNpANC8B4ohGYkrgU+/wgsz37qNYzJrLuaO/lvks4In98E/IC7f+iiZ2DeGlAToZaqjM6M/77GN7FMlvKJnD/SJ/hfZRa/IdlGZNVal4/eJ2MzLtP+MKsqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682142; c=relaxed/simple;
	bh=bvyNTFGZBKP9hz07R72m0jt7Qv4xp4XCEeQg30QlNvk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SdgjJtWn9Gsw0ABcZn6JPFCg6A3vYfEvt/R+TUBHgKNTya38AeRwGaNh0XV8sNDdyrLFgiFMb+kxgwW3hOTdPkqZUUTz5Vd6kHaj/M/6S3c4H99CavqRFqZ2ogP0PJ0iFsyhTSgwe7gZi8k3d0JdtkU4pIXBYwwN5Y4Rol7AsAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Px4jyw3Z; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752682141; x=1784218141;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=bvyNTFGZBKP9hz07R72m0jt7Qv4xp4XCEeQg30QlNvk=;
  b=Px4jyw3ZDyM6/HNhxn8uqZ82BLcPuLPwMhXJ8lIrfKpS4fsbp4t+2Fzw
   QNXWs6aGsSN99JHigD4IqLMBRgwcLwoL9l7AVLe3t8sp4u9p+ttN0wSG+
   nzQWAWGlyOWHSGUh74dw4Mm8EDTaxPBYWPyhVTGOCVxs767qf3ujUqTLQ
   xEStp2oG6p3dSBGmzwcCbD/Bhljw1YqL5lwNs9hYDX4QcBO2fNG3/oIbJ
   yRC5ngHm7CFoa/fzgxpg8wYmI3hKOG/ytOHc0IZfIW69GeWrP5q6eO7et
   KvwaCvY8LR+EkIGLFTQoswlmSj6WSDmnn6CZo/UISlT9t9ocS7ha7SoM5
   w==;
X-CSE-ConnectionGUID: ViYUdsQsSWGBv4tKYPR4KQ==
X-CSE-MsgGUID: +N24ShccRk6DVw4eEK1Buw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54153013"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="54153013"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 09:08:51 -0700
X-CSE-ConnectionGUID: I/NG00OdTCmlG/JsmqNFiw==
X-CSE-MsgGUID: gegFC08NT+KjqAEBtBI1CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="181232912"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 09:08:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 09:08:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 09:08:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.80)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 09:08:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7PB/6uvPrCfZL2ts34pk2zGOty4f66Z85fkqI5HvfecSCp9B4RomnuWhCsHkfjmQxsjQJ78tgfwwrmLWogOIi44ZT0ZrjdDdqEc5JVYsOmPkhKQq9xKeWcVaO++ZbOrhG1v+2r7wr9qYRLMCFIOtZH/iaHRb5DESQla15U2GEUiFXGkXR1yNScnQE9nc0CmfOcEEFtTjkcCAMfZ7W32XgcjxcB2/5UlQKVqIAHz2yfxBpnmS3fWWbvUWspvfxqPvGSS+ndSpWDcE+R6IiCQsMtfmF0SaY95RrsIY4atxX9eHDbNFoTOErhaGsjlOyhVPWCS0U4Q4Rn5IMcYFmLBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+EXxmyNzwENMYAfMp+LXopzgOnmx5MAW6zcVTVx2b0=;
 b=RTAInETBkoaHgrFKrQUjAxjOHv0KZ7R0bsMvP6sBvrt6VdqaE2qvcVFpi9iCPt/w0ln7JK9J26AxoN0ZcxUAEhPZDjHqXQwK26Q+j32u/DEEywQQi9YytbbqQOxbELpIGihJvgS0SozvDEb6hyJUxDZZGrcOXG7SJNCtxQNCDQGPC5F30ZhcT/OprnczF/Y8qv/tCsjrAYLjFcN4LsVjTvchTlFFPmDO5PBLX7YqjT/zUN3y+LjwMpsfj2Vh6K2am5O1QUh+sPFJf+WzUzRD6c6BxtyMsZxB6/pkRghwQF4ipWCKorhB7q48V+ESyh9H0pgPd6ZlddIHwYXaP47MNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4954.namprd11.prod.outlook.com (2603:10b6:806:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 16:08:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 16:08:38 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
	<linux-kernel@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Dexuan Cui
	<decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Nirmal Patel
	<nirmal.patel@linux.intel.com>, Rob Herring <robh@kernel.org>, "Suzuki K
 Poulose" <suzuki.poulose@arm.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH 0/3] PCI: Unify domain emulation and misc documentation update
Date: Wed, 16 Jul 2025 09:08:32 -0700
Message-ID: <20250716160835.680486-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:a03:54::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: fa18fe75-7614-42a8-a824-08ddc4830649
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F4zboYk2jPE+PajS7T2IHAbLS1h/lZUlrZlJy9HEytrEQ6WmCcnSxlMzeDOi?=
 =?us-ascii?Q?7EIlBszyn2nMyyTSL8NTWpnDh1weCAqhZ1D1R0l5YryIu/S6w2fnXxop/i/V?=
 =?us-ascii?Q?/kwL10UwsfvifFXkTOJepv+rY5wubzBIJ4tS+x2MjMamdUutyGaBR4kQhspy?=
 =?us-ascii?Q?GWD4kBKbNGtQvaue6LQYIQBPI2spUx4mPszfn6YOt2IFdWkheWLIl1imRJo8?=
 =?us-ascii?Q?+huwrQT6HWVvir/6EvxGTm9g+KQiT8IrsCXbVS0A9dQsMxrYmC6HKApTufMH?=
 =?us-ascii?Q?JHu0KzlzsG1cvbuLa27114Z5fBhFRNLFFUTY0v2efuohBtgwxd1vTB16Q+n6?=
 =?us-ascii?Q?NSEYb9WKlH/E+09ObrrZ/ObaWs+bA8C8xlgJ285k9u9FZ8B/njuwdaFHuVrZ?=
 =?us-ascii?Q?RsfdbIprc9HkDsVL9TbI7qg3S6qzonNTGsDxxT1LOXMIPDUOeqVCxl+g4a+g?=
 =?us-ascii?Q?m2R3FvKFHL1XJwozV7kLP1GvI4VlIPJR303iM0o8fg1fgSSMH4d2HXgYFE7R?=
 =?us-ascii?Q?YvwUFlYGbO281kdDVTz67Q2lyhNRy9S170ayZ93PRPnOwvToBm5N/sfk9Dwm?=
 =?us-ascii?Q?Cla0+4yxDOOC+/eQqf8kVMoE+HTrpaZC+Y1kMjNVVGLw6AEDlh+e2Tc2GeEU?=
 =?us-ascii?Q?W0WWoAlbGUEkdCVO0B2lrShAyVxz4ItbeSjXKncCeh2x/ZreWio4HwHPv3Fg?=
 =?us-ascii?Q?B3yqmhyiZTjY4RQ44d9Jh93A0uuQX/f5XkZkyiAiETgfApfLg7THp3VVXHST?=
 =?us-ascii?Q?Pajw+t3mZKKSzbI1oqpQflzvKkujlrsXjEfq4wvvA9mQTIZ8gFoFIyO22b1l?=
 =?us-ascii?Q?3Z7ay2yDqM14KTdhGXWz8as2NYcgXwDrdiYIBYg0rLRyTuKnWNCmG/nEumLZ?=
 =?us-ascii?Q?K2ulwlz+yndyPDdkV91i1m6uLiYgTfNgPKICWy3QToM+FCoEdQcSviq3SLaw?=
 =?us-ascii?Q?ImExbhOWKKH1f0LALVGcvBygJn68tDixp+zrm3VQy1yB+HfRhBkszaGMXiN2?=
 =?us-ascii?Q?CTkt9eyK28X6RDqLvp9pZR4rt9IfQ+OvjhuZ7+WYd+/NbNliSdCi4m783Amf?=
 =?us-ascii?Q?pDnIKKhFd6eRcIuyOutfbHgG8YReeqr/bIiClBFqaAWzRXo8A2bvEaN44YKY?=
 =?us-ascii?Q?yPYZHq47s3nbkRHE466asvoyS+hKC6AtJh/9H+wt3c17FUYxESRXnlBjx/iY?=
 =?us-ascii?Q?WL5TMYrNBFJtcLX6dQOkxAc/QAAaQiueQo5G6MgITLYZy5nnC4oa/FjUdjKx?=
 =?us-ascii?Q?8Qqzc9KeA4Y9DO3CvT7Rll5keVJBUm3BUmXueRLWYKeXfwW3QXdQMVytXtc/?=
 =?us-ascii?Q?LFiJEgYg1Lx8j7tEG7Y4aoawLBVqAssk8pc1BXBSu5QpeKLK9ufgWnfU/a0G?=
 =?us-ascii?Q?P1Oy+WXeonSwjhboUIrfQDFTtc/4pLueAibvnq7//BRTmzq1SCV01fAfIfDX?=
 =?us-ascii?Q?LnGz96gJel8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gVUWSfJ4Rs5pMAvgx8lwxZME3z4JJeEiCbKHWwuzmwP9gx2c3or09zigMvd9?=
 =?us-ascii?Q?mrOYs5f/RHjBc9XP7BSv4DO5ed0xwLaIFlBALt1qd+wA5SFUKSzGqK3sIDmZ?=
 =?us-ascii?Q?TgCqqO4UDNN9/ruD6MVOOIWqYjpgacXDWGjjH1OLkHSROCnCu2KQ873+aIAV?=
 =?us-ascii?Q?ZJtnBri87W/PEKrivnsnAvz8IvQQ1T+fy9NNBR1jJ3avvb4hVZ4hkb92TU+N?=
 =?us-ascii?Q?3/kO5C4j+he0j5XHlSNpHNt7/Q6wo8h5Qn50v2SdOch1O1fiaOSz1pkvlNkD?=
 =?us-ascii?Q?c0iY0lU3VJnMA7pDvgHh6KkLRnz6pPrshirE02mbOhIqADVS+/SxXjEEfv6H?=
 =?us-ascii?Q?Hz55mSXzDevqnEiV9S2mdCM+VLyL2X2o6vuMzabU6fNJPdx1b3nS2r3Ayw/h?=
 =?us-ascii?Q?RGRHsU5pyjib6EIL+9SWQX/TNzChN/K6tHOwyf3QSzK/k7qmLqxy3LV9i74B?=
 =?us-ascii?Q?xV5FvAXHhzcek+k1x8wvx0VfFKQU5OWRJzi/rLxi/lHx+9se5ZZFqr7y+mV+?=
 =?us-ascii?Q?Uvmn/3lgRQMFzBgFUQlALc2GDvuVFrWRHON0+soK+2K5rkqruoj0GD/+oXIK?=
 =?us-ascii?Q?7JkLZPCejEpxhwgh0Fxge9k8tuv759vgeXrm+u3+39wFua3x8d6nEyCIxa1G?=
 =?us-ascii?Q?eYtiZ4Y1FdwE32RIqkNwbN7eGbEbr2iu5oPubDOrutlVvVijv/Rc9akoqUFL?=
 =?us-ascii?Q?mo+ZGZs/KHkTayj10Vr6b78dCd0ddrLxnMifx6cU9PYhEclnIp/OD5eZovXs?=
 =?us-ascii?Q?bBq8Pp4EmJcGDanO61Ohyau9vfUeOaz0JpWvo3sVXjYjKSVW6mHbc/ThIpWt?=
 =?us-ascii?Q?o64W4e7ZN4TRW8eh3wsCgWNocph8+oUYR63YEWcuDPKMaIPAwiDrTSFxWjMm?=
 =?us-ascii?Q?6BjAzj1h+rBDG2tnXbAxeAuH9l4quiIv21T1AXr9xWV3tvrDuj+Oe3qT+gq3?=
 =?us-ascii?Q?Ok6tt1gtEe49femgH8rFkPezSmqBKwcE5RNAuZzq8HmRtXOZIMQCjoJfFcMI?=
 =?us-ascii?Q?1C1tLT+NS2Hap6XRV0Z64vGS5iHCU29wvg4vYoegmQnzNA5/O033hP1qg5dY?=
 =?us-ascii?Q?oVIcG2bEWnQCaSqhnEpiciraK9+/uflscN7qgPqSHEoWglcWp3YLzzpwa7OG?=
 =?us-ascii?Q?In1V/WPDS8asOSCnGTPnCVMIohNR6QZDEh6yMH2fTJ0pD9VbUQeWntIwYfVQ?=
 =?us-ascii?Q?Wkcm89ax0fuVkfV7uRktn72lrdHz/HLjmtO5rUGYtW3uBVTEE68xZ8hf3aBP?=
 =?us-ascii?Q?PG2bcnlTgxbcR41qVNCgYxD+A5oxPLjRYUZ/NtEE5zonBCsaTe8TF2+JVTd7?=
 =?us-ascii?Q?dEU3LR3KTEgiZRHt59pcbDrjkQt04X+HSVBIGQII/Pn2vIMFBc3AYuQqogyP?=
 =?us-ascii?Q?7+a+ALY5O2yguyFuI2gUAYghCDGEKq/fT16qclHIg0fD+SiKgEmc6/om9mJ2?=
 =?us-ascii?Q?f5apaNSs9g+ZNpfw7JSvdpKb68ut2TWHbihVrdBLPdZRJKkdpRape7HddCqS?=
 =?us-ascii?Q?sadM6iF/Tvvllqce5pwnWwf6+qo8u7T0s1sSzWGYnOHQpA8AuA+dbK7+59vP?=
 =?us-ascii?Q?i/hRtil5nW9uviMStecn8p7sXOIM/kVUpXSFce+D2ITBf5ozjQ8IGXZ5egD4?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa18fe75-7614-42a8-a824-08ddc4830649
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 16:08:38.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7gZfmvPk3OGbLOMMDc0zbuLStdTwG2WQpy/TKUMNhAriXF4rYT30SLvtj45NO70vxO8DP/dWtrubxQLJeyp37Aobez1Q3bAtNZ3nZ6dNX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4954
X-OriginatorOrg: intel.com

Bjorn,

This is a small collection of miscellaneous updates that originated in
the PCI/TSM work, but are suitable to go ahead in v6.17. It is a
documentation update and a new pci_bus_find_emul_domain_nr() helper.

First, the PCI/TSM work (Trusted Execution Environment Security Manager
(PCI device assignment for confidential guests)) wants to add some
additional PCI host bridge sysfs attributes. In preparation for that,
document what is already there.

Next, the PCI/TSM effort proposes samples/devsec/ as a reference and
test implementation of all the TSM infrastructure. It is implemented via
host bridge emulation and aims to be cross-architecture compatible. It
stumbled over the current state of PCI domain number emulation being
arch and driver specific. Remove some of that differentiation and unify
the existing x86 host bridge emulators (hyper-v and vmd) on a common
pci_bus_find_emul_domain_nr() helper.

Dan Williams (3):
  PCI: Establish document for PCI host bridge sysfs attributes
  PCI: Enable host bridge emulation for PCI_DOMAINS_GENERIC platforms
  PCI: vmd: Switch to pci_bus_find_emul_domain_nr()

 .../ABI/testing/sysfs-devices-pci-host-bridge | 19 +++++++
 MAINTAINERS                                   |  1 +
 drivers/pci/controller/pci-hyperv.c           | 53 ++-----------------
 drivers/pci/controller/vmd.c                  | 33 ++++--------
 drivers/pci/pci.c                             | 43 ++++++++++++++-
 drivers/pci/probe.c                           |  8 ++-
 include/linux/pci.h                           |  4 ++
 7 files changed, 86 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge


base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
-- 
2.50.1



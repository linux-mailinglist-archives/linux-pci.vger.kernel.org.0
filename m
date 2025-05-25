Return-Path: <linux-pci+bounces-28388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8938AAC33BC
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 12:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB7A175FBA
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30E515278E;
	Sun, 25 May 2025 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyEYgaiv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7DBFC1D;
	Sun, 25 May 2025 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748167426; cv=fail; b=C5apX0CwMTj6gFu0By/xabx+or/1W9UL00tmaclYP7Jd+Wkqii+0JJzV62Pk3CH305l+pHSWXkKcq0tmZSlf7SFID2SSi0fN40eRSXrWnCAoZZQs3mapR0C/f8KNrH8NVvJGl5BpsC3amGz/Daldcec4Txa+GvCkizE9n2XFVko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748167426; c=relaxed/simple;
	bh=EEDoQjFHQ+bmMz5qFY5FkyXhEVK7pVITKR86KqfSAl4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oWWgrpEefyCDCS/7GV9tBy0nIfn2/QQtunPsGvdNXLzZpTGNaA5mR2ziWubM8EBHbuAZtn8tGSFGcM4Xno4H0JWiZtsFpY1mF279PQXhS9Ws4yCFv6BUnu4XVOzaPJRYJv/RHx5l4Rvk5YvAuB7e/hXuud91dSukdBbcMh5Xz0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyEYgaiv; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748167425; x=1779703425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EEDoQjFHQ+bmMz5qFY5FkyXhEVK7pVITKR86KqfSAl4=;
  b=GyEYgaivBFPrUNXeszazxixgb3W/lXRqphagZXvTy76YijgQSbv1uvUJ
   bVPagNiQDDyh4swPCRw3x+EwZa6GziVyD+FMdFwEqh77jv5FJURiRAJKS
   s/zs9IyANBvD+Dxib+n0RwrIeyWM5+cPUL4gpjJcFjoU3RQaNDwJ3ntW9
   UJGQx83iLotDPgJdmfu1oQCbmFuj51WMYUICm30Sso9pozeUyXuJeJpZ3
   i2Lt8snR+FTwl7VX9tO/0Gy9aa/OpykSwfyspA8PHHrcKqwsEFtbYUI6u
   GzNMTQeCgDKvfRXkb5sJbIliWCYiLcYQFqe1rwdZN83MKFSBnicqByiCL
   g==;
X-CSE-ConnectionGUID: /9p8z5eMTxGtQ9P/raklSw==
X-CSE-MsgGUID: B0qrzFX0Rr2l9M+m1RhZYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11443"; a="50157100"
X-IronPort-AV: E=Sophos;i="6.15,313,1739865600"; 
   d="scan'208";a="50157100"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 03:03:43 -0700
X-CSE-ConnectionGUID: SVNsuGLiSrSUV90HlbAZWg==
X-CSE-MsgGUID: T+29ohhFReupmoFQTvM4TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,313,1739865600"; 
   d="scan'208";a="172829788"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 03:03:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 25 May 2025 03:03:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 25 May 2025 03:03:42 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.49)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Sun, 25 May 2025 03:03:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k//4hhKU/OPd3DubTW+a39Kj0qka8E5U4uugVGI5oBvzqioD44c1SJ3PXRa0MSpe6ceo4heWLk3c7jQQZbKPhz9Ru3uk9CYAOU8LD0XTtbocEY9paAWSJUXqJTAXtLE5WNue3nHY4OEc+JSeFRON59KW+UoL52Lf7Xj6udSOfOpfWvrAHGyUfvcH4wQkixPCQhiCamGQ30doZePsxoY7sJw8eiyPIlKp4zVMuH1y6hnQFKnimVTXAi8CGZgfwLZgAK7JRzVihey4b8kjr/c2Gu2dNNI311dM+N3NUR35tNA09XZF6QCKyhm9Yss/YW8cIFwXUkrrgzFbUshVVKcfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uld/DPeNAELi/G4fOI2oq4hXhFR+Q27OE1DpU4yqggc=;
 b=OCFEdTumUBDA1cF/Jh+MANtoeaYRUWXo5Qe0KfKRLSOQVSWWl9iD5i2+JNP4lbr+HGfuwtnt+KegS6A0O8QFs40HpGT8/EIDnF6MNCqvO4Tt8/WEF1pTdwo1RbcXSfl7PNhCV8VrPasoAGsRVjfUs8FP7t6KWwMqeiZg2Xe3CPzv8x+GV71ZWP5F1wCIhPZOwxqEWoiLe9qRXvytqOOEe280CApCfUTf9cIMD9ITVCsWcWlpKXt5UaXowxoOVHlZMeoJHzjm1yyyuCdf9nH+FehUwFUsxNFlzhLOviNTdA/CCLZiWzcxqN1YcwJdjVYxdS0spBkr61XcWWLXOmRj3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Sun, 25 May
 2025 10:02:58 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%5]) with mapi id 15.20.8769.025; Sun, 25 May 2025
 10:02:58 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "Satija, Vijay" <vijay.satija@intel.com>
Subject: RE: [PATCH v2 2/2] Bluetooth: btintel_pcie: Support Function level
 reset
Thread-Topic: [PATCH v2 2/2] Bluetooth: btintel_pcie: Support Function level
 reset
Thread-Index: AQHbzVvKifGdeEkLxka+1SPg25ceQ7PjHU7A
Date: Sun, 25 May 2025 10:02:58 +0000
Message-ID: <PH0PR11MB7585DFC60412A23EC20066A7F59AA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250525101619.530255-1-kiran.k@intel.com>
 <20250525101619.530255-2-kiran.k@intel.com>
In-Reply-To: <20250525101619.530255-2-kiran.k@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH0PR11MB5079:EE_
x-ms-office365-filtering-correlation-id: 84b154e1-25a3-4057-90fe-08dd9b73539d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?ndagGMBqakMvjsKycUca2Qsk8i5SAw177U/mRQew+2RlVZl08LcvJLWLdIqI?=
 =?us-ascii?Q?VZiddiCnnuVYFlbmqY0//Av3WzaFjJGpyKAYZqqiyxJk9/nUFYNFVXuVxOaF?=
 =?us-ascii?Q?DFwR5vQK2g2jXsTD1HQPKZjkk2OrorMmFyPq0S8QnJtsOIKiijunGcdgFlrU?=
 =?us-ascii?Q?toPClryTGX61xmfo2Cm7ynceDfOZ/1b7kIO5kORgf2GqWnnymAucQKKwhuOZ?=
 =?us-ascii?Q?PDRAaVdrRKKnuhAo7TkKYkPmNGjNVuUbNApZlbQmNGY6/bqukPEixNuyuZKg?=
 =?us-ascii?Q?TbdYWbseMRpEo7vpo/0OETPMkt9XU3eIPpoq0zp5CEf3wLYDUBdTeKcpnQqa?=
 =?us-ascii?Q?NDbEUj4jIGG2cfRLH+fqzAd0ytgLVYeI43RFGeI1W/w6I3BMdUSPbWcxPvNg?=
 =?us-ascii?Q?j5QBJ8yeBAKDX7GB+QR+SoFRT3oOIiH6eWOA0tLEfH8FbbtfLIwpu8WhLtOR?=
 =?us-ascii?Q?Gm4BJrggvXAIKleGfH/shuvyUyfuBpwoj0iu6QaCM3GqlPCBtiiY182Zoo/4?=
 =?us-ascii?Q?vmIJXJBNyTM9q5BjN2Cu+Hlth2L3c1ohhp4cPVPlz1MhUYUVG8RkuLk0+T92?=
 =?us-ascii?Q?5Hdz1IZMMkLjs7lrOM954WIGLOMtjKjj5vuvGE58vosc2Sl1tQpz+l244Haw?=
 =?us-ascii?Q?0ZiVVVWkiHM70L/rRuI2bN/07iGbMhxgqC0+JPQ/Gje8bT2MBs/IIkrkNbBp?=
 =?us-ascii?Q?kQFbaA9vlP6Yb7CfeSyfPEY0/UpqWETPIhWwVjPKeaSitZsBQVfSNikv0DBV?=
 =?us-ascii?Q?IdwQYV6G5flkrajD52Ep6fd+oyOmOwac7tt/gykfviEgXQxpdAc2lV2qNkxa?=
 =?us-ascii?Q?PII/UNP1W1Sprtksq33w0uje4yV50fqTGdVX1gpc3o+RLnsGUQV+faXwnnUX?=
 =?us-ascii?Q?hyQL1de85xaBdUWLW1PFthlql/Rr7DXfg11AIPT+uyh9E+m7AuFz9dqrLQi8?=
 =?us-ascii?Q?PBJOL+6oonHy47M7/uSPwDwvlC2WanOO5xFN2TetgtZp9ntng3vyIU4X0zpv?=
 =?us-ascii?Q?Acge90JgZM7/gDe0ARnDFyrdMp9CDqxNAMxNBK9UQ+xxleh3zaEBmb+aZ43Q?=
 =?us-ascii?Q?2rY7RWoMUv9R/Ugx1H4GhbuzDJeAd1hi1gGhciIasuMHyEtLhAt0jxB4RG01?=
 =?us-ascii?Q?QRimmvHGKgZ1k08+bWEr3i3WTpT+uaUMaJMAmoMXmxWKf1X6dPtmLNJ8TO1V?=
 =?us-ascii?Q?G9+l+pSzdT8IgZIqfPuQ06C364SLcV7HAKLWn9GxSMefGAjoL43iQFcw4843?=
 =?us-ascii?Q?IipmMTIasG0TXzJJCa1cVqMAh3A/Bmlk+6YqQF7GuPE6viSfEI8yIa02yQwj?=
 =?us-ascii?Q?c7jzwrbB4OJ3igKAaZ8gPuxhXY0Y/u0pXv3ITc5i2gx1+t3KCqta8Cw40WuK?=
 =?us-ascii?Q?BiBWnkw0Ir7piO48NSl/KWqxltsOzSzHeWN8U5jFSXOQlEIJ8d1nSA/bGOw1?=
 =?us-ascii?Q?yzqZlpJ60QX3ik+la9E7DIxzsso7IlM9BDiUstCJwXZCUk/+/OlENOC3v9/T?=
 =?us-ascii?Q?8mvTbXJ6TGAmckM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sRvfy5xs+qB5HZbMiS3zmOFOibc7wt9lfNALAjCMunNjhpmOPakL2eZPTkbx?=
 =?us-ascii?Q?bmleA6FysDPguN+d7KHmOpvpIwA8hs+rDsc4/VtD/B5X+w4IG8eMfceL7WBu?=
 =?us-ascii?Q?QqxJ4ovPa1BhmiK8WtzsQphE9R/k//mw2A17ePJjtDyl0BALuDvU8iqzY/4e?=
 =?us-ascii?Q?6jS7CQNcR/Fn7yfi/FQFxjOu/kV6bA4aIMqOWeiD3lk0ESbYZwCM70B2fOm3?=
 =?us-ascii?Q?KlQIfl4faD2In5sgDRLZS00lEWyju1IkRM2LY/V6GxYvpsg3sHXB6b5yvCt4?=
 =?us-ascii?Q?u6aNEqjG5myMKIahfgLmWGkzwcOZc9Vc7hfnHw8AWK+38F5hafjA8kt84LQl?=
 =?us-ascii?Q?eHvBi20WbSoT/gUv3EwJlcD3It8nz4RPXNteWdVuBkxxw2ifQjjLXWx+R5//?=
 =?us-ascii?Q?YyLQUaFSq5gU6Ts8VuDAmSAd6zEwWSrzlB/bSWhxFFCkCBERYb5o+Rxd3l/L?=
 =?us-ascii?Q?HdPSnbYd05TJeLi7EHjVCNJjJMzq2xgVt7VS3jLTZrSM5Fp0kXhlT0GIH5YF?=
 =?us-ascii?Q?NixKhrsw8E7k/EI1ulVUGIIO33eMxf7C5xt0+SDjkPYwUMBgz380OzKLcL5D?=
 =?us-ascii?Q?GcHn7Lge42wg+2d6X2Px+AxKOXyuSgh7HZQkRI0pzoZIN6aAcoa097S+1BQa?=
 =?us-ascii?Q?RyLquXg6f00EaVXRe4EQUzvYtvzbhKSoeJYotMkHYoVVOSnzTW2epNMTVfZu?=
 =?us-ascii?Q?TMTinPw5T23oX1IOEmrMEmssUkBuJMX6RyC4sdxLFPKZa/ScC9IQ3pHU5G0e?=
 =?us-ascii?Q?DvZAHDgbg/frjI1XyayADhJ5S8weNJ979GF3ClTQmU1CIGVb0XhdqK2pj8n6?=
 =?us-ascii?Q?heqnV87Gcw8KF/e8aUvUVt+jHMHqjdikaMRtB75O+wRfDfmUudjwyzlbHF/k?=
 =?us-ascii?Q?wava+OsMQ1Dm/Tyu47O1D6zc+OnD7iEJKtlxFBx1futcQ1B2DTt7TaneDwZN?=
 =?us-ascii?Q?84ayWHnE15VJXHMpOZV5hsa3AjdI0CgDJ6kBTzupbZ3Kk2Ba9sjYPTkebgE/?=
 =?us-ascii?Q?/wNHHfTNJ0ghNR+htADh2axseuEWkCnERmkIBC09T+D2xH2qpfChwXPwZUbc?=
 =?us-ascii?Q?E9w1nw5tpqpaI6I2PMrTl4pg8GWt7bbIBC4DfdoDHL45odKp4frriQSEAYkG?=
 =?us-ascii?Q?nVL6lq71HapBs8flF6gCFcjKQOL5+pQ8Hmuv3NxO5if1sjGMQQiE4OebHe9h?=
 =?us-ascii?Q?qtZNIcYeC/ykDssgIEG18CdHzr18iMVYnqHKLSabRYu4ggCb9pb274HfE3I2?=
 =?us-ascii?Q?E3Bc/om2Pkv/eJ1coXM2+/vDzvnX4K6A4CoMIYDl6cqf7fWn3JVyI5UGgU4h?=
 =?us-ascii?Q?L6l3ZECluRMLf/pgidYzFNj9yyh3Isfymjm8tyj4wpys8sdUgZ9Y+uDFq6Th?=
 =?us-ascii?Q?nO/BaAHzeTDnai3YGFXR7vrcFvtiDI37w2RQOFg5cJq0yTgaS+jLBin5eVoY?=
 =?us-ascii?Q?7qvh6HkaZknccX61WP4TBeg8pLTPr7+urbY83zH1/gVhH11FuOwmpRoKLSyR?=
 =?us-ascii?Q?KJg1GCQHDnzRDXHrFjSTMumKCRb1YTuDk0QGEHbt70G5tHLLS43DUjV7EBXU?=
 =?us-ascii?Q?NyPBOJ1bXLrJUQQ3z9s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b154e1-25a3-4057-90fe-08dd9b73539d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 10:02:58.2430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZuIEjTQ3D/64rCP0ODr6uyVS+/cjJeFB/OtRr6zrrqQm0jQ7HkstK52fuyrh3uune4aq2cFWzpuiUUamR/00xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
X-OriginatorOrg: intel.com

+ linux-pci@vger.kernel.org, bhelgaas@google.com

>-----Original Message-----
>From: K, Kiran <kiran.k@intel.com>
>Sent: Sunday, May 25, 2025 3:46 PM
>To: linux-bluetooth@vger.kernel.org
>Cc: Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; Tumkur Narayan=
,
>Chethan <chethan.tumkur.narayan@intel.com>; Devegowda, Chandrashekar
><chandrashekar.devegowda@intel.com>; Satija, Vijay <vijay.satija@intel.com=
>;
>K, Kiran <kiran.k@intel.com>
>Subject: [PATCH v2 2/2] Bluetooth: btintel_pcie: Support Function level re=
set
>
>From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
>
>Support function level reset (flr) on hardware exception to recover contro=
ller.
>Driver also implements the back-off time of 5 seconds and the maximum
>number of retries are limited to 5 before giving up.
>
>Signed-off-by: Chandrashekar Devegowda
><chandrashekar.devegowda@intel.com>
>Signed-off-by: Kiran K <kiran.k@intel.com>
>---
> drivers/bluetooth/btintel_pcie.c | 234 ++++++++++++++++++++++++++++++-
> drivers/bluetooth/btintel_pcie.h |   4 +-
> 2 files changed, 235 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_=
pcie.c
>index 74a957784525..6779a2cfa75d 100644
>--- a/drivers/bluetooth/btintel_pcie.c
>+++ b/drivers/bluetooth/btintel_pcie.c
>@@ -41,6 +41,13 @@ static const struct pci_device_id btintel_pcie_table[] =
=3D {
>};  MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
>
>+struct btintel_pcie_dev_restart_data {
>+	struct list_head list;
>+	u8 restart_count;
>+	time64_t last_error;
>+	char name[];
>+};
>+
> /* Intel PCIe uses 4 bytes of HCI type instead of 1 byte BT SIG HCI type =
*/
> #define BTINTEL_PCIE_HCI_TYPE_LEN	4
> #define BTINTEL_PCIE_HCI_CMD_PKT	0x00000001
>@@ -62,6 +69,9 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
> #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER	0x17A2
> #define BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT		0x1E61
>
>+#define BTINTEL_PCIE_RESET_OK_TIME_SECS		5
>+#define BTINTEL_PCIE_FLR_RESET_MAX_RETRY	5
>+
> /* Alive interrupt context */
> enum {
> 	BTINTEL_PCIE_ROM,
>@@ -99,6 +109,14 @@ struct btintel_pcie_dbgc_ctxt {
> 	struct btintel_pcie_dbgc_ctxt_buf
>bufs[BTINTEL_PCIE_DBGC_BUFFER_COUNT];
> };
>
>+struct btintel_pcie_removal {
>+	struct pci_dev *pdev;
>+	struct work_struct work;
>+};
>+
>+static LIST_HEAD(btintel_pcie_restart_data_list);
>+static DEFINE_SPINLOCK(btintel_pcie_restart_data_lock);
>+
> /* This function initializes the memory for DBGC buffers and formats the
>  * DBGC fragment which consists header info and DBGC buffer's LSB, MSB an=
d
>  * size as the payload
>@@ -1927,6 +1945,9 @@ static int btintel_pcie_send_frame(struct hci_dev
>*hdev,
> 	u32 type;
> 	u32 old_ctxt;
>
>+	if (test_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags))
>+		return -ENODEV;
>+
> 	/* Due to the fw limitation, the type header of the packet should be
> 	 * 4 bytes unlike 1 byte for UART. In UART, the firmware can read
> 	 * the first byte to get the packet type and redirect the rest of data @=
@
>-2187,9 +2208,204 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
> 		}
> 		btintel_pcie_start_rx(data);
> 	}
>+
>+	if (!err)
>+		set_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags);
> 	return err;
> }
>
>+static struct btintel_pcie_dev_restart_data
>*btintel_pcie_get_restart_data(struct pci_dev *pdev,
>+									   struct
>device *dev)
>+{
>+	struct btintel_pcie_dev_restart_data *tmp, *data =3D NULL;
>+	const char *name =3D pci_name(pdev);
>+	struct hci_dev *hdev =3D to_hci_dev(dev);
>+
>+	spin_lock(&btintel_pcie_restart_data_lock);
>+	list_for_each_entry(tmp, &btintel_pcie_restart_data_list, list) {
>+		if (strcmp(tmp->name, name))
>+			continue;
>+		data =3D tmp;
>+		break;
>+	}
>+	spin_unlock(&btintel_pcie_restart_data_lock);
>+
>+	if (data) {
>+		bt_dev_dbg(hdev, "Found restart data for BDF:%s", data-
>>name);
>+		return data;
>+	}
>+
>+	/* First time allocate */
>+	data =3D kzalloc(struct_size(data, name, strlen(name) + 1), GFP_ATOMIC);
>+	if (!data)
>+		return NULL;
>+
>+	strscpy_pad(data->name, name, strlen(name) + 1);
>+	spin_lock(&btintel_pcie_restart_data_lock);
>+	list_add_tail(&data->list, &btintel_pcie_restart_data_list);
>+	spin_unlock(&btintel_pcie_restart_data_lock);
>+
>+	return data;
>+}
>+
>+static void btintel_pcie_free_restart_list(void)
>+{
>+	struct btintel_pcie_dev_restart_data *tmp;
>+
>+	while ((tmp =3D list_first_entry_or_null(&btintel_pcie_restart_data_list=
,
>+					       typeof(*tmp), list))) {
>+		list_del(&tmp->list);
>+		kfree(tmp);
>+	}
>+}
>+
>+static void btintel_pcie_inc_restart_count(struct pci_dev *pdev,
>+					   struct device *dev)
>+{
>+	struct btintel_pcie_dev_restart_data *data;
>+	struct hci_dev *hdev =3D to_hci_dev(dev);
>+	time64_t retry_window;
>+
>+	data =3D btintel_pcie_get_restart_data(pdev, dev);
>+	if (!data)
>+		return;
>+
>+	retry_window =3D ktime_get_boottime_seconds() - data->last_error;
>+	if (data->restart_count =3D=3D 0) {
>+		/* First iteration initialise the time and counter */
>+		data->last_error =3D ktime_get_boottime_seconds();
>+		data->restart_count++;
>+		bt_dev_dbg(hdev, "First iteration initialise. last_error:%lld
>seconds restart_count:%d",
>+			   data->last_error, data->restart_count);
>+	} else if (retry_window < BTINTEL_PCIE_RESET_OK_TIME_SECS &&
>+		   data->restart_count <=3D
>BTINTEL_PCIE_FLR_RESET_MAX_RETRY) {
>+		/* FLR triggered still within the Max retry time so
>+		 * increment the counter
>+		 */
>+		data->restart_count++;
>+		bt_dev_dbg(hdev, "flr triggered still within the max retry time
>so increment the restart_count:%d",
>+			   data->restart_count);
>+	} else if (retry_window > BTINTEL_PCIE_RESET_OK_TIME_SECS) {
>+		/* FLR triggered out of the retry window so reset */
>+		bt_dev_dbg(hdev, "flr triggered out of retry window.
>last_error:%lld seconds restart_count:%d",
>+			   data->last_error, data->restart_count);
>+		data->last_error =3D 0;
>+		data->restart_count =3D 0;
>+	}
>+}
>+
>+static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data);
>+
>+static void btintel_pcie_removal_work(struct work_struct *wk) {
>+	struct btintel_pcie_removal *removal =3D
>+		container_of(wk, struct btintel_pcie_removal, work);
>+	struct pci_dev *pdev =3D removal->pdev;
>+	struct btintel_pcie_data *data;
>+	int err;
>+
>+	pci_lock_rescan_remove();
>+
>+	if (!pdev->bus)
>+		goto error;
>+
>+	data =3D pci_get_drvdata(pdev);
>+
>+	btintel_pcie_disable_interrupts(data);
>+	btintel_pcie_synchronize_irqs(data);
>+	flush_workqueue(data->workqueue);
>+
>+	bt_dev_dbg(data->hdev, "Release bluetooth interface");
>+	btintel_pcie_release_hdev(data);
>+
>+	err =3D pci_reset_function(pdev);
>+	if (err) {
>+		BT_ERR("Failed resetting the pcie device (%d)", err);
>+		goto error;
>+	}
>+
>+	btintel_pcie_enable_interrupts(data);
>+	btintel_pcie_config_msix(data);
>+
>+	err =3D btintel_pcie_enable_bt(data);
>+	if (err) {
>+		BT_ERR("Failed to enable bluetooth hardware after reset
>(%d)",
>+		       err);
>+		goto error;
>+	}
>+
>+	btintel_pcie_reset_ia(data);
>+	btintel_pcie_start_rx(data);
>+	data->flags =3D 0;
>+
>+	err =3D btintel_pcie_setup_hdev(data);
>+	if (err) {
>+		BT_ERR("Failed registering hdev (%d)", err);
>+		goto error;
>+	}
>+error:
>+	pci_dev_put(pdev);
>+	pci_unlock_rescan_remove();
>+	kfree(removal);
>+}
>+
>+static void btintel_pcie_reset(struct hci_dev *hdev) {
>+	struct btintel_pcie_removal *removal;
>+	struct btintel_pcie_data *data;
>+
>+	data =3D hci_get_drvdata(hdev);
>+
>+	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
>+		return;
>+
>+	removal =3D kzalloc(sizeof(*removal), GFP_ATOMIC);
>+	if (!removal)
>+		return;
>+
>+	flush_work(&data->rx_work);
>+	flush_work(&hdev->dump.dump_rx);
>+
>+	removal->pdev =3D data->pdev;
>+	INIT_WORK(&removal->work, btintel_pcie_removal_work);
>+	pci_dev_get(removal->pdev);
>+	schedule_work(&removal->work);
>+}
>+
>+static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code) {
>+	struct  btintel_pcie_dev_restart_data *data;
>+	struct btintel_pcie_data *dev_data =3D hci_get_drvdata(hdev);
>+	struct pci_dev *pdev =3D dev_data->pdev;
>+	time64_t retry_window;
>+
>+	if (code =3D=3D 0x13) {
>+		bt_dev_err(hdev, "Encountered top exception");
>+		return;
>+	}
>+
>+	data =3D btintel_pcie_get_restart_data(pdev, &hdev->dev);
>+	if (!data)
>+		return;
>+
>+	retry_window =3D ktime_get_boottime_seconds() - data->last_error;
>+
>+	/* If within 5 seconds max 5 attempts have already been made
>+	 * then stop any more retry and indicate to user for cold boot
>+	 */
>+	if (retry_window < BTINTEL_PCIE_RESET_OK_TIME_SECS &&
>+	    data->restart_count >=3D BTINTEL_PCIE_FLR_RESET_MAX_RETRY) {
>+		bt_dev_err(hdev, "Max recovery retries(%d)  exhausted.",
>+			   BTINTEL_PCIE_FLR_RESET_MAX_RETRY);
>+		bt_dev_dbg(hdev, "Boot time:%lld seconds first_flr at:%lld
>seconds restart_count:%d",
>+			   ktime_get_boottime_seconds(), data->last_error,
>+			   data->restart_count);
>+		return;
>+	}
>+	btintel_pcie_inc_restart_count(pdev, &hdev->dev);
>+	btintel_pcie_reset(hdev);
>+}
>+
> static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)  {
> 	int err;
>@@ -2211,9 +2427,10 @@ static int btintel_pcie_setup_hdev(struct
>btintel_pcie_data *data)
> 	hdev->send =3D btintel_pcie_send_frame;
> 	hdev->setup =3D btintel_pcie_setup;
> 	hdev->shutdown =3D btintel_shutdown_combined;
>-	hdev->hw_error =3D btintel_hw_error;
>+	hdev->hw_error =3D btintel_pcie_hw_error;
> 	hdev->set_diag =3D btintel_set_diag;
> 	hdev->set_bdaddr =3D btintel_set_bdaddr;
>+	hdev->reset =3D btintel_pcie_reset;
>
> 	err =3D hci_register_dev(hdev);
> 	if (err < 0) {
>@@ -2361,7 +2578,20 @@ static struct pci_driver btintel_pcie_driver =3D {
> 	.driver.coredump =3D btintel_pcie_coredump  #endif  }; -
>module_pci_driver(btintel_pcie_driver);
>+
>+static int __init btintel_pcie_init(void) {
>+	return pci_register_driver(&btintel_pcie_driver);
>+}
>+
>+static void __exit btintel_pcie_exit(void) {
>+	pci_unregister_driver(&btintel_pcie_driver);
>+	btintel_pcie_free_restart_list();
>+}
>+
>+module_init(btintel_pcie_init);
>+module_exit(btintel_pcie_exit);
>
> MODULE_AUTHOR("Tedd Ho-Jeong An <tedd.an@intel.com>");
>MODULE_DESCRIPTION("Intel Bluetooth PCIe transport driver ver " VERSION);
>diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_=
pcie.h
>index 21b964b15c1c..62b6bcdaf10f 100644
>--- a/drivers/bluetooth/btintel_pcie.h
>+++ b/drivers/bluetooth/btintel_pcie.h
>@@ -117,7 +117,9 @@ enum {
> enum {
> 	BTINTEL_PCIE_CORE_HALTED,
> 	BTINTEL_PCIE_HWEXP_INPROGRESS,
>-	BTINTEL_PCIE_COREDUMP_INPROGRESS
>+	BTINTEL_PCIE_COREDUMP_INPROGRESS,
>+	BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
>+	BTINTEL_PCIE_SETUP_DONE
> };
>
> enum btintel_pcie_tlv_type {
>--
>2.43.0



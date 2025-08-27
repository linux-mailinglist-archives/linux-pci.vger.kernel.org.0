Return-Path: <linux-pci+bounces-34846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A64B378D5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B32D365481
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DCA2E7BDA;
	Wed, 27 Aug 2025 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbmAYED8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92D7304BDB
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266695; cv=fail; b=kcABT8kvvnF0suYIrOVHJhUYxdVEbrPEoR7hfR8oaeeovhDBTnTuSfEt8jE7U0+0s6llNAT7PcW1dw+Cm2PyCRaG4imWmmYTXSPFK1Rjj8G/BwJ3G76KAAX9Qzh96h2u5XwscXbT6pzWEXN+6itEUH5U+Swu7wjF6IGzZ7aBQGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266695; c=relaxed/simple;
	bh=zuD8zGPEbe9pZhFFO9UR8L2XNDAzv5P/G4GSVNZeA7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L9wnthJknh7hqVGgf6lO8kxFFN3VB5ooC7nFMVp+36bUv/tna/KxyEmrDx4FeNcpwU6a3bds3wDotRYBZc2KTHZUSvKFS0oMEJbj9bYVPRJEOA1XM4dcdZU6kZlbCCYA/QquymM2xfWL4d3hZhtShOoDedyYbz3qCWcrHUtqCVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbmAYED8; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266694; x=1787802694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=zuD8zGPEbe9pZhFFO9UR8L2XNDAzv5P/G4GSVNZeA7E=;
  b=DbmAYED8nG3H3R/Bo6nYLrM4ixwjHKlp8bssAMwSEc6mCSYPjl7iA6sq
   Ydw56uLD0Nzd3y3BK3TNiwrfBn6t1BH7aDNIw4matWvotwB4TwcqlwaPB
   FElXLANckr3obufpKwKzLH8pbSJ61uWbK5fCI2gjABU5EiBqj7dbP/otp
   gMWibUoBwkILehtK7VWcZEVwfk1ixVWLxGpre2MK0fsa9UEHysZVzkJ63
   9oO08H4zCpkQMN9aNLfrgQ6rqIu3j26JDF36wgXjoTliu7YnJwCxT/bWt
   QQYsE1i5uDXuZEL9yQ8TM3efCfjLbEhMKlW4FGOlQsu2OXuuvsK2iRxtc
   Q==;
X-CSE-ConnectionGUID: brXy7xU3TWC14hr5fX4F7Q==
X-CSE-MsgGUID: CO79V0MFSnuEzIHe1KiqHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62329492"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62329492"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:33 -0700
X-CSE-ConnectionGUID: cvKc8tEASZ2C+jTNOYNrLQ==
X-CSE-MsgGUID: J5CQnooJQVSnSfbaoo7+xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169651572"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:51:32 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.87)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htJKzMoI54fcafsxPrDpwwGHLv0oYAN3N85g5PU0FLeDkgriy69G+PU2NoOiBccoEojpaL2HxE47f+X1Ep6BSl4GxnN/s/kBB2fLuKr5W9ikSqtPUg57v1zOjRf/A5AlXMq57ibo4mTmKcgZEC4rDK8gYCyzpcF6Rd1YlfsMZFnS17vrYFRfVicUnFRt494J/iwZw5UFGA6dJzWJOFq8jkv+gqVGKnDwmZIaaDaZP+eqGAM1Iff4v4mPijkbG8kqPz/MUZ2flf9kj8MdA9270BMtWGAAlyCUGvZl+lwq8wIu/SwiFDQGb4KbHUhduEE8at7v0okJVoXJ7mBtqXFE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ1GtXId1NKjrQ7zRNCVUMUtaXlgmWRZ/Zp8QsMK0Tg=;
 b=nxRKvN7UB9q5QfXwxZwPKcKTHXyCvW1YMer2gtLehrAfDhmbrqXjOL1UqHX5YnGdb8uuTOr4j+XSGXPvIJY0OXlSA7JPssBl4EAfTp6wk21mfsRWE1GXh3ibtwUP6hJMBLuuX0CzTQGNOl+cbMJzahukpf/CiXCTST4XFe33J4VoKZWwqc3tsNo28AOn+Nv4EVjLMJ9ZAALHDMnfct13HUoiXvkoBHkEywE0NWNYzJzQY/YVld6Hp48dosm1bWIu9nzUCf3RmIlpETSeRIhRu/okKWFg7FH8jIJ/oQvPSCNNrDxY0FdfvSjdJxoNOaiTiPJIjBoOyldknvoUDBe6zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 03:51:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:51:30 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>,
	<gregkh@linuxfoundation.org>, Xiaoyao Li <xiaoyao.li@intel.com>, "Isaku
 Yamahata" <isaku.yamahata@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 01/10] coco/tsm: Introduce a core device for TEE Security Managers
Date: Tue, 26 Aug 2025 20:51:17 -0700
Message-ID: <20250827035126.1356683-2-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827035126.1356683-1-dan.j.williams@intel.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:907:1::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 6364d3ae-b390-47c0-5bd0-08dde51d017d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G3V3xRpqGk607+7gt8w+71LdG4i0ag/ZbCUO9G9Ano4C274bh+eVLr7SJdTG?=
 =?us-ascii?Q?mkoE6/RCsw5zQ43BBk8wGlTZ+5imbVHRLjlcEROnhJzC2TGShY3aWdbD4mDO?=
 =?us-ascii?Q?7qlusPlYmfudRHr03K1iMSTDlcGJJuPYqz51VKK5ZqhFNIOSnrDrIXPgp1fv?=
 =?us-ascii?Q?PPJvE6O3uzknNWgUPPDJQ2xZnitfOzTKeVe/nK4odzMIU0fobPRfzmlagjzl?=
 =?us-ascii?Q?uhuhpSBgDmyHwpvrjxnvil7raTWibr589oSrTJgYulNwTgjBhtYLTJhVKoX/?=
 =?us-ascii?Q?yh/KqkMvdLft/eOxqH+2UL9vcLdyHK+f2hILIPfz33yl9exGgPmlUO4IOrLR?=
 =?us-ascii?Q?F4lNtp6YV7HUaAV7Wv9tonSw+NIkKoUtOcBhs0mHb/+Tht0Q5kcEN6p/WCqq?=
 =?us-ascii?Q?4jVcT25uG3Mv55F8sWWc4RBJbXTur4EyUageazgth7FzU/fryNjQ62a6zf9A?=
 =?us-ascii?Q?RzZ9xRLbYR5BYFHB0eyWf3yc0oyLS1hOixBgTsaiAVRQGwEvhL408UE95WH7?=
 =?us-ascii?Q?msy3p8HoUe/MzenflyTEN4scmwW+51VdJE3FedbpaOIFjMii0YxDftqbDZO2?=
 =?us-ascii?Q?frgIsJQz0QOiIsGl06cnB97p/QYYN169Et+xIq3olp1CVbvUWbO4253Gqvou?=
 =?us-ascii?Q?JCSgtpfcY0mp1tt8ETI+gnIe0d7G+CcUfQanuQX/A7Qy0eIf2mNE55ZMbqpm?=
 =?us-ascii?Q?5EW1Y4I1RHbRapvu/zmp7GFjhDvVIz6td+AfVOQDnDvK7q6AxzqhHpbyUIG5?=
 =?us-ascii?Q?9g4JbloLLhAVhi9wk3O9anxGoBYHbJ33ZlqFu67nD+rkV9Rlw/IPH25zTe7d?=
 =?us-ascii?Q?wuN+tCXOUxFiP6RB87VQgXjvLa+4AP9F95IN6/StLSb8TIBaVSXtQQJrQHXR?=
 =?us-ascii?Q?6ZmpcMhb83nwO/7k5TWSUpfk93FutIK35bNI08AAx16nFcfedozidFBME+bK?=
 =?us-ascii?Q?7bXjXzMi8DxOPVveR/+IwKwAMNPN0Fj5UI9fTGjpXSZn624RthQ1GmAPebji?=
 =?us-ascii?Q?32qt0wr/UZnO/A2CtxGVRrfG/Sw5z9wdQCNoHCUxvmB+k3YJyMHjTloQHOH0?=
 =?us-ascii?Q?8U8ZfncW+ywXbzRaD5vaf1LlC0YObmHWmTvifO+jmJEcNAK5KNpsehbj8pDj?=
 =?us-ascii?Q?J3j8lT80eAhN7/2FV4sm7cMMGv8NlH6LAi9ffxjEwvuDR+Y9XIR7OYNzSISJ?=
 =?us-ascii?Q?bdhKQYV724A+L0/5po1dRrEoyjkCqGk7go3GnUryr0c3grhMDXvd8TfcvDCl?=
 =?us-ascii?Q?onR2u4h6JkQ2kZVa7aCTLP9frzsYzH6vBdcwtP73XoeVj3bLONh4DVWJfg+m?=
 =?us-ascii?Q?Ic4shm/vofYZjSpHTBycPiDnP61xVC8467Dw0PbEuSCCDTOcb8MFeo1GVXtD?=
 =?us-ascii?Q?Pdk10bAOX43Aq8eiA/+qRyXjlz/MH7tRslF2FMg2uOmYWmhz3bGxaO0gXvbD?=
 =?us-ascii?Q?JXFvEN57kfY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZaZLBI3HtxQux07EiuLK9K9gIpH6qbBCMAB4GAdVyH+uepSje47+w6fq1WNp?=
 =?us-ascii?Q?blMaMmxyZWXin+EteM3TdfxqBKORHOcoPyy23ONr2dipp0rs917h/ORSU7q8?=
 =?us-ascii?Q?W3uiRM9Di6Quk4jJeh+kzvu87NaOd5KkfzbmUiW+ZyS7z6GCUSXoxWVQcklt?=
 =?us-ascii?Q?EVXsaP3UMXni/m38wON4aoLB3X3sNEMGH0itgE8hI8Ah90J9TW1pEgKunTmp?=
 =?us-ascii?Q?J1lq6B66Xrw7EVX9bP2QvOc23N4vINkRuKEbr/RxF2Kv7AGEtGWdK5v/XmnJ?=
 =?us-ascii?Q?y0EvlYFVQ9PHKNpPWFW5spJRj1AO55n3SPzIs+dd3VWS1RU199IpGEWbmHXp?=
 =?us-ascii?Q?PZ1tK29zaAc5NkLHHCza9Znu6NXs1v2xqNarqmZeFUVD5rcFNDAl19cUJVug?=
 =?us-ascii?Q?BbLOfC/r7I/9vbDKgx+lylBVZcnHKx9cuheNPw/WWBubpN9vYeYOtjHUUTq4?=
 =?us-ascii?Q?wmttAxYI5M6+10vKWtNVQEeAP4Ou93SsjGsQLeIYoKOZlC7WCK5UQcHgZfIU?=
 =?us-ascii?Q?ssWUYiCWr7zwg7kXAAdGNlNApctlM6XfRQ74KzMDIjv/BHWxmyap2d6Sj0cJ?=
 =?us-ascii?Q?otIqLk3cvNpain2qF9wC3TJBcPPhsEs+wm+TdwR/4NlTXIiJtYvLrRTV2xQb?=
 =?us-ascii?Q?IcbmUDr/foeUilf9iaLI/Lc9kefvlvp7qXxNbtzyF9bvKs6JbWPOZDbZBUds?=
 =?us-ascii?Q?5//EqA9e2IyM4vCa35nazTl5i73DiVKtQfi9FcQcnjCJE0VwkHw4tfMXt21j?=
 =?us-ascii?Q?BjqlHp6Pxi2vnCZnOF0yGJIAlML3XfuTtfwE6h6fl9Moa+j9oBIGeMpLUrUl?=
 =?us-ascii?Q?V8Ilz0iFY9+kupeQujosjowjWPnFOFB1vdYg8mq6hWEdSVtI2yLOx3t6WbQl?=
 =?us-ascii?Q?Ba6n43i5McarpC5p3cs7A7QQy4CN2cVG8mRE/I2b9MBJE1CHUgn5M7ddnIWp?=
 =?us-ascii?Q?6p5SKQ3mmWO3mfxV9D2z7jSXdCZpiSJN5f5sV58cqG5UgvJGEAJI65Dra6Cq?=
 =?us-ascii?Q?tqCBNDCH4TGqVvNKaz3jhgyXxBACVHbqzx6j8FMhr2QLXssqehtwSv+vfvj5?=
 =?us-ascii?Q?fVhxG1hyj3L330Pp2I+OJ4VQnJyJKoXWCyplIjKXwt6MSF8Zw1EjrPDC5lqx?=
 =?us-ascii?Q?y5sCHGse5P2YsLPmQtcB++to2Za623l1jHExG+ZV/7iOxs3T0uym4bl57JDh?=
 =?us-ascii?Q?9raiOFNHvUuAwWw1kH2tVaDtgdr5VPflk7cIrREX1baTWwPAqGFOHk7YvQHZ?=
 =?us-ascii?Q?XX5e7W9eHOBbZpkYmZrWdUwxhJhfq/o25m6wsJmAtSmNwPq3MzxA6ZmhZNe4?=
 =?us-ascii?Q?Amby0ELowsZ7pVtk9L0GDqUPCVXkHi0qfbbY7mXb2NF8jRTwuPZliq/GKbVJ?=
 =?us-ascii?Q?s/1uDvizCF+k9uCY1c/41uQwpXk87oq7qXbBDnQOSn6b/TFpiEydIsWPJS3A?=
 =?us-ascii?Q?pJHd0pZxtDm7L5KVv384gTzVQNhqi6giVRQPrKPB5XGv0NBms4l8Z3wsDXtV?=
 =?us-ascii?Q?8LUG1BtMqZSIT65ViG+wNLKIf6/uzpUFRqDPA3ctbwgxLJVbsAKwxW7Xy+ex?=
 =?us-ascii?Q?Tr9ba1hKDWQj076ou6VNVsh4Z6FCIqipZ2VuQJFfN7HDk4uSQFmfhdQadiVL?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6364d3ae-b390-47c0-5bd0-08dde51d017d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:51:30.0630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEPcKoEaJ5H7mk9L6kGOLnNeEQoALlQXc+4dvgV90V6IY6UhjwiEpo3gb8zDfPCJSyntXRcig2vQEtjqlf4WNM61oMX2+rI8Ss/EOTo6cv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

A "TSM" is a platform component that provides an API for securely
provisioning resources for a confidential guest (TVM) to consume. The
name originates from the PCI specification for platform agent that
carries out operations for PCIe TDISP (TEE Device Interface Security
Protocol).

Instances of this core device are parented by a device representing the
platform security function like CONFIG_CRYPTO_DEV_CCP or
CONFIG_INTEL_TDX_HOST.

This device interface is a frontend to the aspects of a TSM and TEE I/O
that are cross-architecture common. This includes mechanisms like
enumerating available platform TEE I/O capabilities and provisioning
connections between the platform TSM and device DSMs (Device Security
Manager (TDISP)).

For now this is just the scaffolding for registering a TSM device sysfs
interface.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: John Allen <john.allen@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm |   9 ++
 MAINTAINERS                               |   2 +-
 drivers/virt/coco/Kconfig                 |   3 +
 drivers/virt/coco/Makefile                |   1 +
 drivers/virt/coco/tsm-core.c              | 109 ++++++++++++++++++++++
 include/linux/tsm.h                       |   4 +
 6 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 drivers/virt/coco/tsm-core.c

diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
new file mode 100644
index 000000000000..2949468deaf7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -0,0 +1,9 @@
+What:		/sys/class/tsm/tsmN
+Contact:	linux-coco@lists.linux.dev
+Description:
+		"tsmN" is a device that represents the generic attributes of a
+		platform TEE Security Manager.  It is typically a child of a
+		platform enumerated TSM device. /sys/class/tsm/tsmN/uevent
+		signals when the PCI layer is able to support establishment of
+		link encryption and other device-security features coordinated
+		through a platform tsm.
diff --git a/MAINTAINERS b/MAINTAINERS
index b65289db4822..024b18244c65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25613,7 +25613,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
 F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
 
-TRUSTED SECURITY MODULE (TSM) INFRASTRUCTURE
+TRUSTED EXECUTION ENVIRONMENT SECURITY MANAGER (TSM)
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev
 S:	Maintained
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index 819a97e8ba99..bb0c6d6ddcc8 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -14,3 +14,6 @@ source "drivers/virt/coco/tdx-guest/Kconfig"
 source "drivers/virt/coco/arm-cca-guest/Kconfig"
 
 source "drivers/virt/coco/guest/Kconfig"
+
+config TSM
+	bool
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index f918bbb61737..cb52021912b3 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -7,4 +7,5 @@ obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
 obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
 obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
+obj-$(CONFIG_TSM) 		+= tsm-core.o
 obj-$(CONFIG_TSM_GUEST)		+= guest/
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
new file mode 100644
index 000000000000..a64b776642cf
--- /dev/null
+++ b/drivers/virt/coco/tsm-core.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/tsm.h>
+#include <linux/idr.h>
+#include <linux/rwsem.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/cleanup.h>
+
+static struct class *tsm_class;
+static DECLARE_RWSEM(tsm_rwsem);
+static DEFINE_IDR(tsm_idr);
+
+struct tsm_dev {
+	struct device dev;
+	int id;
+};
+
+static struct tsm_dev *alloc_tsm_dev(struct device *parent)
+{
+	struct tsm_dev *tsm_dev __free(kfree) =
+		kzalloc(sizeof(*tsm_dev), GFP_KERNEL);
+	struct device *dev;
+	int id;
+
+	if (!tsm_dev)
+		return ERR_PTR(-ENOMEM);
+
+	guard(rwsem_write)(&tsm_rwsem);
+	id = idr_alloc(&tsm_idr, tsm_dev, 0, INT_MAX, GFP_KERNEL);
+	if (id < 0)
+		return ERR_PTR(id);
+
+	tsm_dev->id = id;
+	dev = &tsm_dev->dev;
+	dev->parent = parent;
+	dev->class = tsm_class;
+	device_initialize(dev);
+	return no_free_ptr(tsm_dev);
+}
+
+static void put_tsm_dev(struct tsm_dev *tsm_dev)
+{
+	if (!IS_ERR_OR_NULL(tsm_dev))
+		put_device(&tsm_dev->dev);
+}
+
+DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
+	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
+
+struct tsm_dev *tsm_register(struct device *parent)
+{
+	struct tsm_dev *tsm_dev __free(put_tsm_dev) = alloc_tsm_dev(parent);
+	struct device *dev;
+	int rc;
+
+	if (IS_ERR(tsm_dev))
+		return tsm_dev;
+
+	dev = &tsm_dev->dev;
+	rc = dev_set_name(dev, "tsm%d", tsm_dev->id);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = device_add(dev);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return no_free_ptr(tsm_dev);
+}
+EXPORT_SYMBOL_GPL(tsm_register);
+
+void tsm_unregister(struct tsm_dev *tsm_dev)
+{
+	device_unregister(&tsm_dev->dev);
+}
+EXPORT_SYMBOL_GPL(tsm_unregister);
+
+static void tsm_release(struct device *dev)
+{
+	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
+
+	guard(rwsem_write)(&tsm_rwsem);
+	idr_remove(&tsm_idr, tsm_dev->id);
+	kfree(tsm_dev);
+}
+
+static int __init tsm_init(void)
+{
+	tsm_class = class_create("tsm");
+	if (IS_ERR(tsm_class))
+		return PTR_ERR(tsm_class);
+
+	tsm_class->dev_release = tsm_release;
+	return 0;
+}
+module_init(tsm_init)
+
+static void __exit tsm_exit(void)
+{
+	class_destroy(tsm_class);
+}
+module_exit(tsm_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("TEE Security Manager Class Device");
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 431054810dca..aa906eb67360 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -5,6 +5,7 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
+#include <linux/device.h>
 
 #define TSM_REPORT_INBLOB_MAX 64
 #define TSM_REPORT_OUTBLOB_MAX SZ_32K
@@ -109,4 +110,7 @@ struct tsm_report_ops {
 
 int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
+struct tsm_dev;
+struct tsm_dev *tsm_register(struct device *parent);
+void tsm_unregister(struct tsm_dev *tsm_dev);
 #endif /* __TSM_H */

base-commit: 650d64cdd69122cc60d309f2f5fd72bbc080dbd7
-- 
2.50.1



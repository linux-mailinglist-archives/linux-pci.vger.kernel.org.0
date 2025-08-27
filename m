Return-Path: <linux-pci+bounces-34849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2026B378D7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B121B671EF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A91730DD3A;
	Wed, 27 Aug 2025 03:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTu5p+k0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2831530DD14
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266697; cv=fail; b=hi0BhHQl1CyXs5wehJ1+W8rjWXWUC78y7bTNSyaiXiEtDxiIeevHFDuQlytK44XGV39gp1LWrUmb0+6rPycf3pwimCQbWG61MtusT60fRew9WyGSww0Tn+MP16T0gBHIC4j/sB3L3F2mM4RwKRwT3qVtpqRmBFIqrl5DCR/jkb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266697; c=relaxed/simple;
	bh=YNmP2ifyZTDfQNjcRxfAzljBzcKXPJfwLn2teH3DgVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W1Y4kYUCer2mK4hzzgwL2epU6piHI1TbGQ8OkY9Z/qKWkxwtf8Efmm9cHryYom9zPfVd7WZ2vHvV22/5IxB+7EguOOqcacD6ZgMffPrqgyrolHNlPuqr7bwIVsE7ltjM3YJ5iJAFoYRKRx5EfsFHfJBHcpXVx9ZE39LgZXx1K+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTu5p+k0; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266696; x=1787802696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=YNmP2ifyZTDfQNjcRxfAzljBzcKXPJfwLn2teH3DgVE=;
  b=LTu5p+k0oc072ZHi6ZCu7MtlNmrIkXWCwfvm1U5oORJ8lUGTDjsSGRR4
   g5RlKRSig9A+sU/7qdcQtFk/YbL3RDAiumSgmT7xkpswu7PRDFnESVbqh
   +lRDQRiCP1FAc45I5q7q/x5ODzp5hHOxfXImxnQ1KIvCdingeFmyrG7VC
   +zt04hEGwYpz+R8w/711ft8fyfr9npzJj4aG2/76jjLgqxL49WMhHV8Ry
   YZ7U2fsEr7aEQQgGhbdm6Yzrd/XAJs/ij0x0VjD+97SPZY9PJm9ebuWXm
   +gMmocMcwYyhGAk1Q+6hY0fQFMFViVtlkFpDmuwfrjgeAVasIzhYPNg+R
   g==;
X-CSE-ConnectionGUID: 3L28ozsxSXuR//Nl6nzYsQ==
X-CSE-MsgGUID: qFnyyuM5S76haxELTnqqJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62159112"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62159112"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:35 -0700
X-CSE-ConnectionGUID: CHfxPjgURtiZulyT4wDq2g==
X-CSE-MsgGUID: 3FmD6r/rRvqMfQdYJyY8xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169685096"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:51:34 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.72)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4IKYrdZOnCuVlhpnv6hNSOhvZae4ECO61IvPTGFTlRQ0kU+ZPZ4sF6UN6633K3sxNk/fobkau1eIdmjsLjtpTQMCM0wuwgKwkbaAqMjlswlpjhCj/F8Hg2obBkhynCO3W1xvwH3Y/NhpAq/mUJrVREaJVO9+LAu9jB0SAJVV29AHLdrj/hdDAc9nTPhHKZb1KiMgFcL2xCF6yu+cLw5YSBe0iu2aAoV1wlaYsf/dEq5SFYpQFkbbPZKWYK3VFZF3totXvOmplrkNJQ0loAa++iloueu2TDMkE62lWT8JqX5NtOvWSzVj/8OaEQNhvp2bUqZ7mrenvfHRwpIQLKNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOq1nIi1b4GUq1AM/7eb3NQPRCW6iG1iR8KWAYOoVQE=;
 b=LZNiyDPUCXfJSUePg9SG6ToAd5tn/jA+wPkIUuZEgniFIowS7UCg1nF1OUpF1IXUM6LzlqQuN7h28uUufE2q+ESTKbMJc4e94GJd2dP4isucTNloRM0KSO+lBYgA6viD+bBzrPGvso2pm3kDnsMvPtp70zS4WlxSecqXvwUizM7ZHeWFA0H25j5xai972N06EDf/Foe1P6PABT7E5N6uLspS7Q1UCd6XtBiMM/wqa93nfucLEXEsF8DYzTifz8BFamzgzfyhWNrnbZxQrmNzF9sPDHxYxgErSso8lRoNPCixyznjvrb45xgCq2fTMnN9Smau3DWc4hp+yap2jV4r5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 03:51:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:51:31 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>,
	<gregkh@linuxfoundation.org>, Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v5 03/10] PCI: Introduce pci_walk_bus_reverse(), for_each_pci_dev_reverse()
Date: Tue, 26 Aug 2025 20:51:19 -0700
Message-ID: <20250827035126.1356683-4-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 47dcd9d2-a1d8-4aff-5e64-08dde51d027b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mMVFKUC6sSqDZBFfT8E+k3uoQ6lSpkP0GRjT8dWflnSDJavzSVQOnX8O31cW?=
 =?us-ascii?Q?PKDGuvb0Zb6hlMJlYhbJWwsg6Wnuj0VLc2Nb1DTvxip4GGYz1nC3bR7nBWC/?=
 =?us-ascii?Q?SU0Y+CULlXAdKu7+MrJS9A3gjVRnzcht71aZEvcS92brvXvU+58n+gZKbnKP?=
 =?us-ascii?Q?1FFCItijp4D4PKATasrtu6sl55KkdqeTNOh8/FM25KMSzEnMbvKb5HzTIE4s?=
 =?us-ascii?Q?gd8cRUA4h9b8XbOTBfBGtacJnX/Tw7DzZD8TJdAKmVwB70BxAmv1k351lKnF?=
 =?us-ascii?Q?U+nHzyiztDfuMSYscbqod/6Pk94BLIChDUEJOcOkEchUIzz5aO0Dxp1YFC3S?=
 =?us-ascii?Q?JqaW8sUhAQxiLMVq6qStIRd5+7cUCsqjG83Mv2/J84XrsPCKckCo8yp9+CiD?=
 =?us-ascii?Q?HN68NV+zLtYMQx7gm0p+HZkYtB21YKLwU/12wsdOGi7eGcnxunBIwhlPLvuM?=
 =?us-ascii?Q?uOOKeINR/mJIAxcYSDrWk5oPBaQkivtSx+CQEsFDoPaTzQzi96UE9J+dGC/J?=
 =?us-ascii?Q?cvryTTnp9liQCX0MEaTgrnkfleWbpjwC4Jm/z7Q4bjmFNiBENqbeffGAYJyo?=
 =?us-ascii?Q?0oa/fzptKNG4Ee8/VDOTpSnQIUJ8EgYqs7DWPqnfnHOFdfGvCRKEGt7mVL+R?=
 =?us-ascii?Q?kISBREr0ouvjmMt9k7I83SJXkCijQbN/6cOOYd5Ifn0RRZXv8mIdj/FrDMno?=
 =?us-ascii?Q?ZW0z0myBJrO/3tLaaxGgFFCWaUmylx5XMciPpsDNDwwVHXXprPEDOTLxvHd8?=
 =?us-ascii?Q?tOn3blBu22EIYzVTDXfmvfTEHr5cOFP5eta4+ilW5FSAM1Ii3W5z49usJJme?=
 =?us-ascii?Q?SVt7Uvae5ZPOkB+vGFgGdYMGL4Mrveil0wAo2g7He/lryvpS17aSN2QImrFH?=
 =?us-ascii?Q?riZTReNwe1tlS/+esTKG6axAA0BO0sTKkdXduX9Jhf6533hy3T9Cr9IOfISq?=
 =?us-ascii?Q?QUa61jFmBaduBAY0pM3WVou3LMSDxEnNQZ/vY03Rv44vMp9qmCpSh8c+w167?=
 =?us-ascii?Q?0/ZXiWFR9rK5CQb6+iYxflEv3Oi/uMAAuGHrrOLLOKPdOUz2hrA5tvRrYSg/?=
 =?us-ascii?Q?yYoOOv70KiFEuYz4r4D72rWyRyExRkHEJ1upwIQcGlXPqbAa5FtsienxIgw1?=
 =?us-ascii?Q?vz7qAVWzwh5ZQxAKKqYNLpaOmG+Y91I1IcLbahs0NigmXWU9mjmkcJz+oJrT?=
 =?us-ascii?Q?CnfUP8QC7pvghXRtIEGoteEHba85ohaMaXFagOv4sw9JDHDT8VC4cQa43uHR?=
 =?us-ascii?Q?vMLDC1V4U8IIkkMWpKUty6/ww5HrQ2M2UKpMcIUEyakBC1BZ0NPdrD7x/XOa?=
 =?us-ascii?Q?IPfmQwqP1yiEkSjOlI9KKc5KYJdHaqeeKbBXWszAOEj43XsGCvKyj9aVld4R?=
 =?us-ascii?Q?kCgPuN3Fx/Zodfto4FySJ/B+sgdd5Pir/26LbFW4Y/D00kXye+Pw3lp1TS9w?=
 =?us-ascii?Q?lgG0gE1Jf9s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C4+IOKYBsXfltjFUiK8GkeEzuqhc+n+xtxJgTfKQflswbRo0LjFdw5+GK5FE?=
 =?us-ascii?Q?FmuTNyvaCGzG5KVuTJDicBzriW/aZY18JgNeQTjsTRLcFuvirxGfWjW4iHNM?=
 =?us-ascii?Q?3aFgTs67LFsXontgqCKVZYm+0wiDrpNsErY8HKDHZPOw94/Rd1AzV6V5Ibyi?=
 =?us-ascii?Q?fpLbbQutFodOYxSEvQ5Eu0PD2ctrle2jDs4ORXjZbMsOSQGQ9RVNHfOOEJG8?=
 =?us-ascii?Q?NIsB7rCHWqVrCIwGqDhNoTMPjIOG2enrEKnaFjSjkn1BQ+cJ+WxhGqXIji3+?=
 =?us-ascii?Q?lRmnCOHgAjCExKDNYgsOe3QKpLlCn9juoX4hP2oL8VKBzDEogfIxobx2lYZQ?=
 =?us-ascii?Q?6rcUkiiH6iPOWVylfP0ZgYG8ddIVpoeGsDTUBIb6smTZgMYtihOLVshbNhUi?=
 =?us-ascii?Q?lQTvHm8sqeR1JZBF9cL/wDgNpKe6GPwMKDhXHazkmsvVuEiPi634URWw3qAx?=
 =?us-ascii?Q?zTs6AifioDY009lAyIx206mXpBzKf5E8omNNXD1ksInTiqjHjUBzc2pmre4o?=
 =?us-ascii?Q?xrTEUg8H5XKvJ6VuCUO/qsMQBlhdBp4QXjjKNY2s5ZyoZm5o7L+Ttb8g5dRd?=
 =?us-ascii?Q?PhUO7PpdKyGOM0LVre6ggRbDAZw27DgxY/3kEBIXQL7Ltt89/x2auLJdsIQw?=
 =?us-ascii?Q?p6RZGGWKr9refGHuTrVsZQZBQ9H6Wpw2RyntbR04Dl5T36Rt2M2ccZh/dstq?=
 =?us-ascii?Q?xY/oT5YzqYM6x5NtEBSYlm3F+StnbSUfXDPIEG68VbytLZjouBQhSxOdqp54?=
 =?us-ascii?Q?E7pZ0MtU6Iq+o3LRCDmy3QhzQKSAeHmwIWeD1QNRC5Dreccyy38tpMeG0BVG?=
 =?us-ascii?Q?r/i2RsGzXgHxDxvzJ5EzS8AbHENzuG7XW4e250D4KeVHOzMcOWzUNJ6gGmSA?=
 =?us-ascii?Q?jJRC19Br0taezadOezeYv+2bfic+Z3Lzg284mha0u1ZVm3Pavplgq8rdcORt?=
 =?us-ascii?Q?Un0KcpLi3Hnbg9IPF5hQGKNS1NpXCUaTqnQPHrbIo+RwY0oaSm+OfM03wqkw?=
 =?us-ascii?Q?C9jRCfJ4n/Ht6joJkd8AE1ovtdeLFsKeRtm7EsOGPrN/cCGR4B0F8EILQdTG?=
 =?us-ascii?Q?a9jCSWg1PF4unM88P0rGisdOloDzRqMvDjTy/RNhAAKfMqSlQcaVKP3RjJj4?=
 =?us-ascii?Q?mbqHp/b4kqbN5kiIREQFvz/DAzQ0Q0kpzJXTcROZ/1mTbb9cDdbh1otuZXQ0?=
 =?us-ascii?Q?v5D6IguvMgpruqZNXa+ONRUjqPQWb4kpRqfCanj7+mKVLPzO4aKFU+C7SpW6?=
 =?us-ascii?Q?zOfKK5QMQlUBKG+3UyR2HnLLtjeN7RmB0lqs23VKJOv9OANKboMnOpeOK65E?=
 =?us-ascii?Q?Klxi9BYOXq/3GbVSd7kJf6QzUymwFGkHuxrbj9kKLNdg+dW5X/yYRBlE1OUa?=
 =?us-ascii?Q?dNNqlq3Vkxz+6X/wcMZZmMzuw+zOjsm4+cApvCyi7zU4NQQNykw8gEc51632?=
 =?us-ascii?Q?dgF7i1OME1oPUL0iWEDHzVaTbFAgM//eHcPhW+cP0d7z+eDlKVWUyJG49267?=
 =?us-ascii?Q?pxI+PhfEaLM88pTJEH0mZWBKYJ5Orf58Msb0TXn0vVxiMNtpzW+4TUS3jc4c?=
 =?us-ascii?Q?RdvDElwMT/C/NFJRTmP3QuMwEG8lYTYSBYPwwNZlh8qV0MCRBmL2mA8ioIAj?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dcd9d2-a1d8-4aff-5e64-08dde51d027b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:51:31.6106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ms7r3HFhYELjM0wr7jsPaKUG6z+OMUEy8RnxJkrkxQFWvolDw5njapgeHzCQAvP0kZ+djCCw/yIa7u7yQibhhrHLCmvitdjmbGbdLueLCG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

PCI/TSM, the PCI core functionality for the PCIe TEE Device Interface
Security Protocol (TDISP), has a need to walk all subordinate functions of
a Device Security Manager (DSM) to setup a device security context. A DSM
is physical function 0 of multi-function or SR-IOV device endpoint, or it
is an upstream switch port.

In error scenarios or when a TEE Security Manager (TSM) device is removed
it needs to unwind all established DSM contexts.

Introduce reverse versions of PCI device iteration helpers to mirror the
setup path and ensure that dependent children are handled before parents.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/bus.c         | 38 +++++++++++++++++++++++
 drivers/pci/bus.c          | 38 +++++++++++++++++++++++
 drivers/pci/search.c       | 62 +++++++++++++++++++++++++++++++++-----
 include/linux/device/bus.h |  3 ++
 include/linux/pci.h        | 11 +++++++
 5 files changed, 144 insertions(+), 8 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 5e75e1bce551..d19dae8f9d1b 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -334,6 +334,19 @@ static struct device *next_device(struct klist_iter *i)
 	return dev;
 }
 
+static struct device *prev_device(struct klist_iter *i)
+{
+	struct klist_node *n = klist_prev(i);
+	struct device *dev = NULL;
+	struct device_private *dev_prv;
+
+	if (n) {
+		dev_prv = to_device_private_bus(n);
+		dev = dev_prv->device;
+	}
+	return dev;
+}
+
 /**
  * bus_for_each_dev - device iterator.
  * @bus: bus type.
@@ -414,6 +427,31 @@ struct device *bus_find_device(const struct bus_type *bus,
 }
 EXPORT_SYMBOL_GPL(bus_find_device);
 
+struct device *bus_find_device_reverse(const struct bus_type *bus,
+				       struct device *start, const void *data,
+				       device_match_t match)
+{
+	struct subsys_private *sp = bus_to_subsys(bus);
+	struct klist_iter i;
+	struct device *dev;
+
+	if (!sp)
+		return NULL;
+
+	klist_iter_init_node(&sp->klist_devices, &i,
+			     (start ? &start->p->knode_bus : NULL));
+	while ((dev = prev_device(&i))) {
+		if (match(dev, data)) {
+			get_device(dev);
+			break;
+		}
+	}
+	klist_iter_exit(&i);
+	subsys_put(sp);
+	return dev;
+}
+EXPORT_SYMBOL_GPL(bus_find_device_reverse);
+
 static struct device_driver *next_driver(struct klist_iter *i)
 {
 	struct klist_node *n = klist_next(i);
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index b77fd30bbfd9..1a090da18e59 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -8,6 +8,7 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/cleanup.h>
 #include <linux/pci.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
@@ -425,6 +426,27 @@ static int __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void
 	return ret;
 }
 
+static int __pci_walk_bus_reverse(struct pci_bus *top,
+				  int (*cb)(struct pci_dev *, void *),
+				  void *userdata)
+{
+	struct pci_dev *dev;
+	int ret = 0;
+
+	list_for_each_entry_reverse(dev, &top->devices, bus_list) {
+		if (dev->subordinate) {
+			ret = __pci_walk_bus_reverse(dev->subordinate, cb,
+						     userdata);
+			if (ret)
+				break;
+		}
+		ret = cb(dev, userdata);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
 /**
  *  pci_walk_bus - walk devices on/under bus, calling callback.
  *  @top: bus whose devices should be walked
@@ -446,6 +468,22 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *), void
 }
 EXPORT_SYMBOL_GPL(pci_walk_bus);
 
+/**
+ * pci_walk_bus_reverse - walk devices on/under bus, calling callback.
+ * @top: bus whose devices should be walked
+ * @cb: callback to be called for each device found
+ * @userdata: arbitrary pointer to be passed to callback
+ *
+ * Same semantics as pci_walk_bus(), but walks the bus in reverse order.
+ */
+void pci_walk_bus_reverse(struct pci_bus *top,
+			  int (*cb)(struct pci_dev *, void *), void *userdata)
+{
+	guard(rwsem_read)(&pci_bus_sem);
+	__pci_walk_bus_reverse(top, cb, userdata);
+}
+EXPORT_SYMBOL_GPL(pci_walk_bus_reverse);
+
 void pci_walk_bus_locked(struct pci_bus *top, int (*cb)(struct pci_dev *, void *), void *userdata)
 {
 	lockdep_assert_held(&pci_bus_sem);
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 53840634fbfc..e6e84dc62e82 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -282,6 +282,45 @@ static struct pci_dev *pci_get_dev_by_id(const struct pci_device_id *id,
 	return pdev;
 }
 
+static struct pci_dev *pci_get_dev_by_id_reverse(const struct pci_device_id *id,
+						 struct pci_dev *from)
+{
+	struct device *dev;
+	struct device *dev_start = NULL;
+	struct pci_dev *pdev = NULL;
+
+	if (from)
+		dev_start = &from->dev;
+	dev = bus_find_device_reverse(&pci_bus_type, dev_start, (void *)id,
+				      match_pci_dev_by_id);
+	if (dev)
+		pdev = to_pci_dev(dev);
+	pci_dev_put(from);
+	return pdev;
+}
+
+enum pci_search_direction {
+	PCI_SEARCH_FORWARD,
+	PCI_SEARCH_REVERSE,
+};
+
+static struct pci_dev *__pci_get_subsys(unsigned int vendor, unsigned int device,
+				 unsigned int ss_vendor, unsigned int ss_device,
+				 struct pci_dev *from, enum pci_search_direction dir)
+{
+	struct pci_device_id id = {
+		.vendor = vendor,
+		.device = device,
+		.subvendor = ss_vendor,
+		.subdevice = ss_device,
+	};
+
+	if (dir == PCI_SEARCH_FORWARD)
+		return pci_get_dev_by_id(&id, from);
+	else
+		return pci_get_dev_by_id_reverse(&id, from);
+}
+
 /**
  * pci_get_subsys - begin or continue searching for a PCI device by vendor/subvendor/device/subdevice id
  * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
@@ -302,14 +341,8 @@ struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
 			       unsigned int ss_vendor, unsigned int ss_device,
 			       struct pci_dev *from)
 {
-	struct pci_device_id id = {
-		.vendor = vendor,
-		.device = device,
-		.subvendor = ss_vendor,
-		.subdevice = ss_device,
-	};
-
-	return pci_get_dev_by_id(&id, from);
+	return __pci_get_subsys(vendor, device, ss_vendor, ss_device, from,
+				PCI_SEARCH_FORWARD);
 }
 EXPORT_SYMBOL(pci_get_subsys);
 
@@ -334,6 +367,19 @@ struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
 }
 EXPORT_SYMBOL(pci_get_device);
 
+/*
+ * Same semantics as pci_get_device(), except walks the PCI device list
+ * in reverse discovery order.
+ */
+struct pci_dev *pci_get_device_reverse(unsigned int vendor,
+				       unsigned int device,
+				       struct pci_dev *from)
+{
+	return __pci_get_subsys(vendor, device, PCI_ANY_ID, PCI_ANY_ID, from,
+				PCI_SEARCH_REVERSE);
+}
+EXPORT_SYMBOL(pci_get_device_reverse);
+
 /**
  * pci_get_class - begin or continue searching for a PCI device by class
  * @class: search for a PCI device with this class designation
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index f5a56efd2bd6..99b1002b3e31 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -150,6 +150,9 @@ int bus_for_each_dev(const struct bus_type *bus, struct device *start,
 		     void *data, device_iter_t fn);
 struct device *bus_find_device(const struct bus_type *bus, struct device *start,
 			       const void *data, device_match_t match);
+struct device *bus_find_device_reverse(const struct bus_type *bus,
+				       struct device *start, const void *data,
+				       device_match_t match);
 /**
  * bus_find_device_by_name - device iterator for locating a particular device
  * of a specific name.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7b9c11a582e9..6fb0e8a95078 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -581,6 +581,8 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
 
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
 #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
+#define for_each_pci_dev_reverse(d) \
+	while ((d = pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
 
 static inline int pci_channel_offline(struct pci_dev *pdev)
 {
@@ -1241,6 +1243,8 @@ u64 pci_get_dsn(struct pci_dev *dev);
 
 struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
 			       struct pci_dev *from);
+struct pci_dev *pci_get_device_reverse(unsigned int vendor, unsigned int device,
+				       struct pci_dev *from);
 struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
 			       unsigned int ss_vendor, unsigned int ss_device,
 			       struct pci_dev *from);
@@ -1660,6 +1664,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
+void pci_walk_bus_reverse(struct pci_bus *top,
+			  int (*cb)(struct pci_dev *, void *), void *userdata);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
@@ -2055,6 +2061,11 @@ static inline struct pci_dev *pci_get_device(unsigned int vendor,
 					     struct pci_dev *from)
 { return NULL; }
 
+static inline struct pci_dev *pci_get_device_reverse(unsigned int vendor,
+						     unsigned int device,
+						     struct pci_dev *from)
+{ return NULL; }
+
 static inline struct pci_dev *pci_get_subsys(unsigned int vendor,
 					     unsigned int device,
 					     unsigned int ss_vendor,
-- 
2.50.1



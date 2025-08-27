Return-Path: <linux-pci+bounces-34848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289BBB378D8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35DF47B2A8E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89EB30DD28;
	Wed, 27 Aug 2025 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USiQKN6H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010F30DD07
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266697; cv=fail; b=HOEbxQRRrNilFwQDcqa+dWYzGr6ybsjPrRmKhdXGmpc22/WCT/dECtgyOEQegJcr2N1dt9WDtbTAHsyCwC/IKMu2tQvWNGOynYQPaKn973eCVtV2TpHle+FuMHBY4Vi1yaYpLuFaATNi7D5MQMh1w6ziowTNMhVbeU+brgPXsro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266697; c=relaxed/simple;
	bh=k2Ueis4weQ8KvAFFPjWqOMplpnmS6yCkyG9PPnKQ2jU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jIpTfH+vdxhqnB3bf/7PCiyU88Nk6gDHm1NFakYNjGErG69mwU0PH05RqzJ+dvX9jLdH1f1SbdOZdbCDKLSwR7lS1pdlNXiXQgbTT8oQ8DO8+vQL/unWep802MyMp60TYHjkPnssCmVSAvvETGDAQgCGyZoeJbpwDnzcDeGJDxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USiQKN6H; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266695; x=1787802695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=k2Ueis4weQ8KvAFFPjWqOMplpnmS6yCkyG9PPnKQ2jU=;
  b=USiQKN6HHSFR1H3bzcML4ppRnDppClDVW6pZQsLKyS/1bmPs0Qm/PZ1u
   6kZHf09y1C+iKVlNZ7dvu7tC2XhhPrgrcUMTxdCZPx4tEb5xJyNSS8MSC
   vy9IY2BL7ueylSfZXaEyDcN8c1+D5XecSEwVwRCeh/9reAIamgbB9F40Y
   FO2ZS3GqUZ0YPkwkK5NDIHlRD+yH+84URZVi6Be7mEPeeem3DFpIdx6kY
   aYTrqNqe+zt/jXjEGgX8PYWOZW/mbktOaM5ouUgeW31jlrJa29lO0Qa4I
   1i508KP8HNaslE/8PMRR8BeusXbRRYsmYOU/8qfGkCAF8jpeTSqcOkxK+
   Q==;
X-CSE-ConnectionGUID: Pu+lim9yQeShpvX388dkcg==
X-CSE-MsgGUID: 0iQO1fpsQPuKecwSdeAFrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62159100"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62159100"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:33 -0700
X-CSE-ConnectionGUID: RBABBqdaQhKcGj4Gts8l4w==
X-CSE-MsgGUID: VfV/eL9fQIuEC7e2Y8xg4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169685087"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:51:32 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.87)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctHKo25i6wZnOrSWncasIVC9uVXHigN4jfoZbyqwXbuy8wQgxjKZDHn86bt8u5kPbbOKnrNEJv3KxwBKLrxOHAfXUE+ifmwKLjjwY9pDxGX8HGUIMTUaoESmJW1/JFhexKTp+Ii/+VFbcX3MgSE7UxZ0holHt0qy6A3aCdIySAAXM0TT6HL5I9ydFstL6u5eAa2CbhTOcWT6RVWFqmKuy3qFK2VdDBERBrOb+4+QW9+fLg4ovKZojt4VMTZWleKhmZKNaF2HopqeZg9BLBGIOczi0jE0m53nhxB5mtRJFcDewOwzv2lRB7bzqMkOE1o7SQSxapyOA03c5qtfvwJ/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jhe7N28hHwl8bC4BwMNCwxyDXgKYFFjaecFwrcLwUgI=;
 b=svp1qu/JjbeNy1TOUXclsTMSIaihNcsznTnidbMb0VvPHef3Z1Zknu7yJPgLefYpsaPHuWNEGDNr9X4nPt4evJAjlMaNlFdZCWRHzmQhPz5/LeGBdxktboTNddfTpn4+mPJ7F8bgCZ2w2bYViEprVkz9vazEehYWl9qy8s1zho+cUKU2o8OmxskgJaPsvu0lr/L1Wjj2r8020BdxIVbu3IOxdaWvCoqDnn54Su/JBkk2IM1rh8LKVqqk/K7fEU6506Mzt4mIavhToPRpKgotCVmb5pr6WsCPqMrPb0VKJ7A7oaTbPeo84nVYSgmaqNiPLsrOym2zVsE1T2p8uXl8Fw==
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
	<gregkh@linuxfoundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 02/10] PCI/IDE: Enumerate Selective Stream IDE capabilities
Date: Tue, 26 Aug 2025 20:51:18 -0700
Message-ID: <20250827035126.1356683-3-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 04eb28a2-1c5e-45a5-a061-08dde51d0201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Q4CvrDto6MMBS7OrBsnMvDIxohde4Ho0CAZRlUSzWFVZP0G3X85b96eEKXb?=
 =?us-ascii?Q?doskGqLYkxMuyD6K743aZCd2OPa3HzOKWcgJA1P+TgiyUyr4ZX5R7AshXvsJ?=
 =?us-ascii?Q?coEnBnc+ZavSoQCbKN0ZadeYGcMc2iQpJOdDiNeDf+4FiZBTHMZmp44mRMsV?=
 =?us-ascii?Q?Ej3/0rdVEnpAPsuAd66v6xGerTE8ehWAjumkrIjqtz76JiHV9pW02O9NLA7l?=
 =?us-ascii?Q?ekfYS1ttPCGStNCsti8vwqZ5YiS5CNRas1xicDTwdnvduJPcM5x7fYPMTsZj?=
 =?us-ascii?Q?Zpbp31uHgJ4AtOt8/huLwM6fg/BfySOqTPoyKOVGikvglrWz5vzaLQP0CIJM?=
 =?us-ascii?Q?CIpCh4YItlLy9PYnbmuT0i46Y2oHErKbJB6DUy+XanNJ7a2o9ONnZgxKjPg8?=
 =?us-ascii?Q?2ATzuQsagVPWPJj2RCKwNjDH/8prweFDP2Z/uff5vTm1NIDis4mNJGim2aQC?=
 =?us-ascii?Q?ZdZVO7vZFDQlTJEU3Yx9PcNxGC22I3dUN3Tdo6hlggjvF/e/mzcY8PK3VdNs?=
 =?us-ascii?Q?Z0eLLbDD4oz2OGpLN6Wnl/AaOp78YrnVhvKhbRdCaihsm52r2rz75wLWdzVV?=
 =?us-ascii?Q?KRwdOyS5ksuFC7VNyO2eFmS0Zue6bZ/yC6FOkVLmuodOekUdpQk7icZalLJn?=
 =?us-ascii?Q?q6y1K7xXmdsnPFPoA/BV4G4D2jbf3sH3Mf1rqtaueLqHcuUFp+XMsrJ50ykh?=
 =?us-ascii?Q?pWDttEqhLtnmptDa1n2utc6SDxId5mSjhTYQJXXB8f+pV+2Ecw0TG/iR1Ill?=
 =?us-ascii?Q?8LXLs9QjROBr4Rgk/GV3iI9HcI4LW7qvEu52TOoXTaBlS5ekaDliIo78nk5T?=
 =?us-ascii?Q?OHkRFqSI1zePaBePSftiJxtUSdJaKs4QYmSWzMut5tFbj/OM+uimum8A0170?=
 =?us-ascii?Q?tFQ9YMxN/gDc8VUpoQCmifsBbfV67FhQ9E5qHoOvsu/1gnPRfd5q2IPniSPW?=
 =?us-ascii?Q?4QM6bWdjJrIgqPumMoOXD6cSOYE97sYnRniNnFlBl5/E6roae2aQUXxKePNt?=
 =?us-ascii?Q?pE9vBNt2WxRRCUf60rDWDaOw5oNqKOYa/BVi4Mw4mNfXXZlQok7fhrReXzyC?=
 =?us-ascii?Q?10Dq0QTESZb5TVjMlEKyVu8TQqkD6vEJxQWwGOlPTa7K9nfakG07/XaMeUIt?=
 =?us-ascii?Q?/wzzvO6J9Cb0LTNW5AtZ9cJ4Plq8EDW5GS0bl2Dmpse/wGIBggSQUlXAt4o8?=
 =?us-ascii?Q?aF+SlVmT92PdbH9vhIBxgTrAPfvN9Hz126+UPv6rk3qWj93pJQOOZVT+z3fn?=
 =?us-ascii?Q?Hr+UGuVUb+l8UyGtks94oyXj4XqnrXLh/J61TSZhvIE5g2Fk5JbDnke03MAZ?=
 =?us-ascii?Q?f4GRzgyV6Xdp4L2eBqbcSO6DpJuE90L9Ermz+lfYVQXHrtdMg0XYMZFhDIwD?=
 =?us-ascii?Q?fRg91FxfJ6OXmMC6/b2/BNerSifg++8oRK8mFdyQmoG35YvLjjbIOH7LkRd4?=
 =?us-ascii?Q?utoNOSr9CXQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DRacW4IiG12qJWUpNOZ2jrtxwiboBBojemdA2BKUHWXdV3CCjpf0dR7KLtlo?=
 =?us-ascii?Q?qWoQ0jspFbkLgmaM/e+H+aJhKfvDvVN2CKsSHHG8RgDWwfrK4BH1w5U+aetn?=
 =?us-ascii?Q?ps40cZcd5rBYy0GzYGwpGbn5H/m91NQ5ENNmLe2mFpMHLTaLCnQnMJKqYLQ+?=
 =?us-ascii?Q?geTGK33DS/VdgA8wnHjQ08Oum64PPqfJS2Qvi0VN1v2EVhxZ5PWPdOlRQCSF?=
 =?us-ascii?Q?ZH2tqTgzGzzmoszaswrBq59CQigd+LLcNunz7OH9kghqMPCLHclDkDpCfpOR?=
 =?us-ascii?Q?AWxXHX3PpkTOVbgAtB7YTzqQRHfsyA8AiVZnY0p/Jzz1nP1j/UCrMSmml39w?=
 =?us-ascii?Q?p2BrhJjWvCt5uhZx4ZXxlbeuJ/KVK5XWAZadZiw70KY7Z6HHvyoiFMv9b/lp?=
 =?us-ascii?Q?Bgl8VX1zyt7QwwKqFKDxL+x/6/JgM7YX8odNHXaxoEjZOWpMBjPamNzbbIxD?=
 =?us-ascii?Q?uThUkQBHzI8vDZDDo+0e7YAJiZ7mP5HqJsLcoFZf+xcyXkuNLnyULZ0ad254?=
 =?us-ascii?Q?z8N2j8RL3N7PlmFQ75QzEc1jIYmolMSKCYM7PI0h8FjB3snH5Wtbn0/S+GQb?=
 =?us-ascii?Q?2wuPw23ppVuiHXuZU3WmQ7Q/KR00OPZPlrQG93azNbG87h6iiedLe63dD1Su?=
 =?us-ascii?Q?+oKURaU/sorp+U9AlwPAz5SRqBhVnhlz6Z8uhO8j7mBxGja5bCY57DP0FVO3?=
 =?us-ascii?Q?KUIKykEgcNMgRyWOs7wjRmSYR7F68aevZ4m5jY9PBryFpWKywJYLyZnsObcq?=
 =?us-ascii?Q?45tH51t/sQkI5TEd4MueYzyRnbca2zWtGMRCXP6JvUHpsgkOTfwQTVtkEq/+?=
 =?us-ascii?Q?MJ/gvlBDdCcQUvYHnPx4cswmzQAitOFDllAGXwheMca7oaTQ4Ae8gpH/Ahts?=
 =?us-ascii?Q?6yQURKdxfjCkvGbO3/NSH+RJFNzvR9I+hQkDvi23Hs/pyKiiir2j51sidToP?=
 =?us-ascii?Q?aLlF1GjUeLf/tuT7kb/oa1yhXIjODkjzevwt6o5JSDxuViBUJ4F6t4Cokv5G?=
 =?us-ascii?Q?fsHPJboP2/kpY8MFcwv412W+9jTHf9eiSUx4uQ8Ggg8cUpyMGCRTgvi6FWVo?=
 =?us-ascii?Q?8/w3wglAbs8uE2pkT+IEc40HJwKxINgPOG9wv4aF/mSBX/1K3GoGjX2st6rl?=
 =?us-ascii?Q?1S94tFbMGCftyrwYgBATmyaUYchlJP78ONPT5vNSckQAO74esAZCWOAb/8aC?=
 =?us-ascii?Q?6AeBjq83JedqeYxsJtbUfa0TqTk747XUU2C2jU8ynoQnR0CO4jF64AVj3LPW?=
 =?us-ascii?Q?JeKr+RlCMokfQOJMhlwjjSjXMMtup5nTrZowK/D7hZM5uWsPqOcwpJogSaac?=
 =?us-ascii?Q?TxEk5CpD6u2HrlI8LFBZFQZgpwLlW5uPXiI/VnGodt6opUiFba+eaWNMj9QV?=
 =?us-ascii?Q?98VV3xhuzCVfdS1w/pRjPvjtE/CYHQxrqtvk5qejcNTujMxXO0gcfnWuIsRR?=
 =?us-ascii?Q?+CsWmfOLA1na7xdHmroAGoSxqJvPt2xLryODQXGyHJGupOZhBu4uubRjSmdu?=
 =?us-ascii?Q?d/ZJk+xwOBalR70/XkzWnxJF5A6H8a9OnEwNORafymfisGIr+Lls6eJHgdeI?=
 =?us-ascii?Q?UDOOi1CuqmYUd4k+7D0FKB8FxPet8bhR5uivOWvy5ZQdi7tOG4Ch4pW2I7rW?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04eb28a2-1c5e-45a5-a061-08dde51d0201
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:51:30.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FbQyHAh4nNWuO6vFDu9bB95SJl+qELqBFAVcECv0KKpIZOqzIEtRf/WtFl1jftGawt0o0uujBTDhKS4Xox9zD3l2DRHI27uFGQm/A3O+TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

Link encryption is a new PCIe feature enumerated by "PCIe r7.0 section
7.9.26 IDE Extended Capability".

It is both a standalone port + endpoint capability, and a building block
for the security protocol defined by "PCIe r7.0 section 11 TEE Device
Interface Security Protocol (TDISP)". That protocol coordinates device
security setup between a platform TSM (TEE Security Manager) and a
device DSM (Device Security Manager). While the platform TSM can
allocate resources like Stream ID and manage keys, it still requires
system software to manage the IDE capability register block.

Add register definitions and basic enumeration in preparation for
Selective IDE Stream establishment. A follow on change selects the new
CONFIG_PCI_IDE symbol. Note that while the IDE specification defines
both a point-to-point "Link Stream" and a Root Port to endpoint
"Selective Stream", only "Selective Stream" is considered for Linux as
that is the predominant mode expected by Trusted Execution Environment
Security Managers (TSMs), and it is the security model that limits the
number of PCI components within the TCB in a PCIe topology with
switches.

Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/Kconfig           | 14 ++++++
 drivers/pci/Makefile          |  1 +
 drivers/pci/ide.c             | 92 +++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |  6 +++
 drivers/pci/probe.c           |  1 +
 include/linux/pci.h           |  7 +++
 include/uapi/linux/pci_regs.h | 81 ++++++++++++++++++++++++++++++
 7 files changed, 202 insertions(+)
 create mode 100644 drivers/pci/ide.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9a249c65aedc..105b72b93613 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -122,6 +122,20 @@ config XEN_PCIDEV_FRONTEND
 config PCI_ATS
 	bool
 
+config PCI_IDE
+	bool
+
+config PCI_IDE_STREAM_MAX
+	int "Maximum number of Selective IDE Streams supported per host bridge" if EXPERT
+	depends on PCI_IDE
+	range 1 256
+	default 64
+	help
+	  Set a kernel max for the number of IDE streams the PCI core supports
+	  per device. While the PCI specification max is 256, the hardware
+	  platform capability for the foreseeable future is 4 to 8 streams. Bump
+	  this value up if you have an expert testing need.
+
 config PCI_DOE
 	bool "Enable PCI Data Object Exchange (DOE) support"
 	help
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 67647f1880fb..6612256fd37d 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
+obj-$(CONFIG_PCI_IDE)		+= ide.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
new file mode 100644
index 000000000000..05ab8c18b768
--- /dev/null
+++ b/drivers/pci/ide.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
+
+/* PCIe r7.0 section 6.33 Integrity & Data Encryption (IDE) */
+
+#define dev_fmt(fmt) "PCI/IDE: " fmt
+#include <linux/bitfield.h>
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
+
+#include "pci.h"
+
+static int __sel_ide_offset(u16 ide_cap, u8 nr_link_ide, u8 stream_index,
+			    u8 nr_ide_mem)
+{
+	u32 offset = ide_cap + PCI_IDE_LINK_STREAM_0 +
+		     nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;
+
+	/*
+	 * Assume a constant number of address association resources per
+	 * stream index
+	 */
+	return offset + stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
+}
+
+void pci_ide_init(struct pci_dev *pdev)
+{
+	u8 nr_link_ide, nr_ide_mem, nr_streams;
+	u16 ide_cap;
+	u32 val;
+
+	if (!pci_is_pcie(pdev))
+		return;
+
+	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
+	if (!ide_cap)
+		return;
+
+	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
+	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
+		return;
+
+	/*
+	 * Require endpoint IDE capability to be paired with IDE Root
+	 * Port IDE capability.
+	 */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
+		struct pci_dev *rp = pcie_find_root_port(pdev);
+
+		if (!rp->ide_cap)
+			return;
+	}
+
+	if (val & PCI_IDE_CAP_SEL_CFG)
+		pdev->ide_cfg = 1;
+
+	if (val & PCI_IDE_CAP_TEE_LIMITED)
+		pdev->ide_tee_limit = 1;
+
+	if (val & PCI_IDE_CAP_LINK)
+		nr_link_ide = 1 + FIELD_GET(PCI_IDE_CAP_LINK_TC_NUM, val);
+	else
+		nr_link_ide = 0;
+
+	nr_ide_mem = 0;
+	nr_streams = min(1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM, val),
+			 CONFIG_PCI_IDE_STREAM_MAX);
+	for (u8 i = 0; i < nr_streams; i++) {
+		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
+		int nr_assoc;
+		u32 val;
+
+		pci_read_config_dword(pdev, pos, &val);
+
+		/*
+		 * Let's not entertain streams that do not have a
+		 * constant number of address association blocks
+		 */
+		nr_assoc = FIELD_GET(PCI_IDE_SEL_CAP_ASSOC_NUM, val);
+		if (i && (nr_assoc != nr_ide_mem)) {
+			pci_info(pdev, "Unsupported Selective Stream %d capability, SKIP the rest\n", i);
+			nr_streams = i;
+			break;
+		}
+
+		nr_ide_mem = nr_assoc;
+	}
+
+	pdev->ide_cap = ide_cap;
+	pdev->nr_link_ide = nr_link_ide;
+	pdev->nr_ide_mem = nr_ide_mem;
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 34f65d69662e..56851e73439b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -519,6 +519,12 @@ static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { }
 static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
 #endif
 
+#ifdef CONFIG_PCI_IDE
+void pci_ide_init(struct pci_dev *dev);
+#else
+static inline void pci_ide_init(struct pci_dev *dev) { }
+#endif
+
 /**
  * pci_dev_set_io_state - Set the new error state if possible.
  *
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1de6e3be6375..4fd6942ea6a8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2642,6 +2642,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_doe_init(dev);		/* Data Object Exchange */
 	pci_tph_init(dev);		/* TLP Processing Hints */
 	pci_rebar_init(dev);		/* Resizable BAR */
+	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9b2c753aa192..7b9c11a582e9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -538,6 +538,13 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
+#endif
+#ifdef CONFIG_PCI_IDE
+	u16		ide_cap;	/* Link Integrity & Data Encryption */
+	u8		nr_ide_mem;	/* Address association resources for streams */
+	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
+	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
+	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
 	u8		supported_speeds; /* Supported Link Speeds Vector */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f5b17745de60..911d6db5c224 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -751,6 +751,7 @@
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
+#define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
 #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
 
@@ -1239,4 +1240,84 @@
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
 
+/* Integrity and Data Encryption Extended Capability */
+#define PCI_IDE_CAP			0x04
+#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
+#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
+#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
+#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
+#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
+#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
+#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
+#define  PCI_IDE_CAP_SEL_CFG		0x80 /* Selective IDE for Config Request Support */
+#define  PCI_IDE_CAP_ALG		__GENMASK(12, 8) /* Supported Algorithms */
+#define   PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
+#define  PCI_IDE_CAP_LINK_TC_NUM	__GENMASK(15, 13) /* Link IDE TCs */
+#define  PCI_IDE_CAP_SEL_NUM		__GENMASK(23, 16) /* Supported Selective IDE Streams */
+#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
+#define PCI_IDE_CTL			0x08
+#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4  /* Flow-Through IDE Stream Enabled */
+
+#define PCI_IDE_LINK_STREAM_0		0xc  /* First Link Stream Register Block */
+#define  PCI_IDE_LINK_BLOCK_SIZE	8
+/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
+#define PCI_IDE_LINK_CTL_0		0x00		  /* First Link Control Register Offset in block */
+#define  PCI_IDE_LINK_CTL_EN		0x1		  /* Link IDE Stream Enable */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR	__GENMASK(3, 2)	  /* Tx Aggregation Mode NPR */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_PR	__GENMASK(5, 4)	  /* Tx Aggregation Mode PR */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL	__GENMASK(7, 6)	  /* Tx Aggregation Mode CPL */
+#define  PCI_IDE_LINK_CTL_PCRC_EN	0x100		  /* PCRC Enable */
+#define  PCI_IDE_LINK_CTL_PART_ENC	__GENMASK(13, 10) /* Partial Header Encryption Mode */
+#define  PCI_IDE_LINK_CTL_ALG		__GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
+#define  PCI_IDE_LINK_CTL_TC		__GENMASK(21, 19) /* Traffic Class */
+#define  PCI_IDE_LINK_CTL_ID		__GENMASK(31, 24) /* Stream ID */
+#define PCI_IDE_LINK_STS_0		0x4               /* First Link Status Register Offset in block */
+#define  PCI_IDE_LINK_STS_STATE		__GENMASK(3, 0)   /* Link IDE Stream State */
+#define  PCI_IDE_LINK_STS_IDE_FAIL	0x80000000	  /* IDE fail message received */
+
+/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
+/* Selective IDE Stream Capability Register */
+#define  PCI_IDE_SEL_CAP		0x00
+#define  PCI_IDE_SEL_CAP_ASSOC_NUM	__GENMASK(3, 0)
+/* Selective IDE Stream Control Register */
+#define  PCI_IDE_SEL_CTL		0x04
+#define   PCI_IDE_SEL_CTL_EN		0x1		  /* Selective IDE Stream Enable */
+#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR	__GENMASK(3, 2)	  /* Tx Aggregation Mode NPR */
+#define   PCI_IDE_SEL_CTL_TX_AGGR_PR 	__GENMASK(5, 4)	  /* Tx Aggregation Mode PR */
+#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL	__GENMASK(7, 6)	  /* Tx Aggregation Mode CPL */
+#define   PCI_IDE_SEL_CTL_PCRC_EN	0x100		  /* PCRC Enable */
+#define   PCI_IDE_SEL_CTL_CFG_EN	0x200		  /* Selective IDE for Configuration Requests */
+#define   PCI_IDE_SEL_CTL_PART_ENC	__GENMASK(13, 10) /* Partial Header Encryption Mode */
+#define   PCI_IDE_SEL_CTL_ALG		__GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
+#define   PCI_IDE_SEL_CTL_TC		__GENMASK(21, 19) /* Traffic Class */
+#define   PCI_IDE_SEL_CTL_DEFAULT	0x400000	  /* Default Stream */
+#define   PCI_IDE_SEL_CTL_TEE_LIMITED	0x800000	  /* TEE-Limited Stream */
+#define   PCI_IDE_SEL_CTL_ID		__GENMASK(31, 24) /* Stream ID */
+#define   PCI_IDE_SEL_CTL_ID_MAX	255
+/* Selective IDE Stream Status Register */
+#define  PCI_IDE_SEL_STS		 0x08
+#define   PCI_IDE_SEL_STS_STATE		 __GENMASK(3, 0) /* Selective IDE Stream State */
+#define   PCI_IDE_SEL_STS_STATE_INSECURE 0
+#define   PCI_IDE_SEL_STS_STATE_SECURE	 2
+#define   PCI_IDE_SEL_STS_IDE_FAIL	 0x80000000	 /* IDE fail message received */
+/* IDE RID Association Register 1 */
+#define  PCI_IDE_SEL_RID_1		 0x0c
+#define   PCI_IDE_SEL_RID_1_LIMIT	 __GENMASK(23, 8)
+/* IDE RID Association Register 2 */
+#define  PCI_IDE_SEL_RID_2		0x10
+#define   PCI_IDE_SEL_RID_2_VALID	0x1
+#define   PCI_IDE_SEL_RID_2_BASE	__GENMASK(23, 8)
+#define   PCI_IDE_SEL_RID_2_SEG		__GENMASK(31, 24)
+/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
+#define PCI_IDE_SEL_ADDR_BLOCK_SIZE	12
+#define  PCI_IDE_SEL_ADDR_1(x)		(20 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
+#define   PCI_IDE_SEL_ADDR_1_VALID	0x1
+#define   PCI_IDE_SEL_ADDR_1_BASE_LOW	__GENMASK(19, 8)
+#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW	__GENMASK(31, 20)
+/* IDE Address Association Register 2 is "Memory Limit Upper" */
+#define  PCI_IDE_SEL_ADDR_2(x)		(24 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
+/* IDE Address Association Register 3 is "Memory Base Upper" */
+#define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
+#define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.50.1



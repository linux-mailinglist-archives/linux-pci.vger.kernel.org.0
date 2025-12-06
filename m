Return-Path: <linux-pci+bounces-42715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC216CA9F49
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 04:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A80E6302563F
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 03:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6315F28FFE7;
	Sat,  6 Dec 2025 03:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPSNMQ8q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C27C28CF7C;
	Sat,  6 Dec 2025 03:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764990509; cv=fail; b=Lzlu4nL6JKYyVU/ahk3uCN4sm8jPwmzm7xUtRR9G1Hr/gYNmlEFGyp4d3RzOqyIbKx3WZZ5qVf0Dlb4m7LYO14udfA8Nlrv9/XP2vCzHbnA98qmNm8hsNs2LU00avesw5406roNAT4ppt853W6QYpQT9Wgg5B+o0i/4+zNVI9lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764990509; c=relaxed/simple;
	bh=HirOngj8zmkslp1bZze6e+waHsk3h94sFG2F1kT/aH0=;
	h=From:Date:To:CC:Message-ID:Subject:Content-Type:MIME-Version; b=Et6ZMRtcKHvelAn4XAaYEzTQmOP0ryiBpy1kR2dkRnrTARvhs5PZgmJXyTfT/Fu6Z/BxhbOsvcWXu4hwA/M6StqwL1BDxREED02yPmhtBpnCyhLi60jG/BofMo4qomJOl5yES7TYP0T24lD8nF21PxQDCZpoAgqEXalaydJJtVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPSNMQ8q; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764990508; x=1796526508;
  h=from:date:to:cc:message-id:subject:
   content-transfer-encoding:mime-version;
  bh=HirOngj8zmkslp1bZze6e+waHsk3h94sFG2F1kT/aH0=;
  b=RPSNMQ8qXrNwMtUsZYXDh7RqHGoqfJA2+uCR4ola2Y+IFkrPsO1PrLJs
   gig8f+jcXZ98lWFXJUTQyVYqVpBxwklzWoen3yWslGfRBz5eUW9O7pdA/
   nx4M5KRWo5WGgNq5600O3Zk8AVDs7PT6iNyOW0VLuBd+OOuZrgRFsKI3T
   Q0h9bOEjVCrFTwWtP3n11FeRezGmidFgjIn2Znp9jBnDVuuC6yx+TJD9S
   9YSw3R3IvfNy+EhU+K1x4Cc7IhlEYB2dI9CsrIH90Lp+NjMiwhEtG6sf2
   3Ycb8PJieHXNEaEdz7eJMqGyRWwKeZ/PTo/pwXVec4ZLq4l9tDk1CvtNl
   w==;
X-CSE-ConnectionGUID: PpeNU9zjSHGQS6PRsTVGUQ==
X-CSE-MsgGUID: EZu9e97+RVyZoLFncLQ3iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="84629734"
X-IronPort-AV: E=Sophos;i="6.20,253,1758610800"; 
   d="scan'208";a="84629734"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 19:08:27 -0800
X-CSE-ConnectionGUID: C9Qedu9UT46gqn6bOjvDbQ==
X-CSE-MsgGUID: 0zVrfnuSRVWlcd6JoWqDPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,253,1758610800"; 
   d="scan'208";a="200382615"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 19:08:26 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 19:08:26 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 19:08:26 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 19:08:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDUiEIQy4nqFNYx16nE1S2vwLoWaRlfttSmpl9hIRZ7+ae5JMn5SU1bGk0oje8G/WlxTuJMuUvPnmcg3uNhGqcCVSDa3sROVNJOEGCNrAA6eIOV1yn1KEGbrBYKvzQwpT7eToG+MElS9DqUNqTUHOM97iVgP43sfUulFeIIDsHr7A9PKcOyNtAckA5cLukR2XfDaZEeaS4BVY2IRPkbqIDE5UkBD7vtRBxqPqXrm23P2jMfkQFI6vsCMDZEjuIkcBhXc0Uh2PmtQOy3wY+F6I//DseJIQO8WROEcYWH1vXe8zC9nlT30gTBhcHgSTqbXFsrV09aljgfZrBXVN4BTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4yok+lFbh+k8aQnSuzb1nnflIHrO5ZvtQDo04UvYr4=;
 b=fe1hhHwYxWasnlbiEF5/PdOeECZw0ZLxaYhuU7QHJAcr1jWS48eGRG8CkTHoDayiP60ZgYQi8ccypdVNv3ZfyGXZhKLt/KbqY95l3avq1J3SRrnKGuwyH7TeLF7SuauuvQHPPkadoH+4rt6WxEp0HkMUZ2I5oYzaNF9BLNBoOnzISmv63lL9FyqOx7oCuG+kMGTDDc325Q6MS5Jxq8lDBVOqdT6edgbMlmDn+MJZ7wFbAe/T4q/vWF682uzrzAca+PltL16s+ELyShKxXLXq6SEPCG6NbL5ydB1Qvpv+/Sw/XPOrE4LK+vJY7zqLGpNaD2qi6Wp16PpyYtmdtfDWzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sat, 6 Dec
 2025 03:08:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9388.011; Sat, 6 Dec 2025
 03:08:18 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 5 Dec 2025 19:08:17 -0800
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, "Aneesh Kumar K.V (Arm)"
	<aneesh.kumar@kernel.org>
Message-ID: <69339e215b09f_1e0210057@dwillia2-mobl4.notmuch>
Subject: [GIT PULL] PCIe Link Encryption and Device Authentication
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5309:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a03759-cda5-40e6-cd3d-08de3474b4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVMzY2xJcW10T3NBWjFpMkxQeTBMMTFBcTBKbExOMVR1b3BzU29GbFFNblVt?=
 =?utf-8?B?NStWRVh2SDRYbkV5MkpOYjI0TFg1SXNUYnNxMkxaSzhTS2JULzVsRTdiQXRP?=
 =?utf-8?B?Ly9BQ2VieDg5WnRSUVFCTVloNmgvMi9kWC9OSGs3SFBHWjA1ZkVId3FKeHJy?=
 =?utf-8?B?aWo5WnljM0pnVU9xSVk5WVRLb0FWZWNMbXVYdWJZeHdUZEhsR2c0dHJLcjdu?=
 =?utf-8?B?bFFCbHYzeWNMMkJhdVk5dXNYWmtjWW5Ib0thZ1RMVTdNbmVoWFNYUFBTbFRn?=
 =?utf-8?B?aE1kcWpRR0dNM0xna1kvWkNweTFHbnRWT0pBUUQzWkJZUTZpWFV5V04vZGZY?=
 =?utf-8?B?emFrbmNTNGx6L05QZC8vQWl2WXFxRE1MTlo1ZlVMb2RSVDVPdXdhWFFVVzBC?=
 =?utf-8?B?U3o4UTQ1MWk4UTBCUlVLRU1aWmFuSWFGTnZiUUpUazc3Vlc5NzFzZ2dsQmw0?=
 =?utf-8?B?U2R4Nk5PdHRhWnJBVHAyamF0SjZDWDZwY09OSkdqZ1hCQTMxYVAwUWx6Rzkz?=
 =?utf-8?B?Wk83N1paYjlWK0h3azZWREJtUXY1Tzhid1dIeFlDQktqbkI0My9HZ2hQbndJ?=
 =?utf-8?B?LzVFT2xuMllISkxjZFo5c2ljRHFmemE4bTdmd05KNW1vaVNIYVhyZmpmWE9F?=
 =?utf-8?B?L1kyR3pKaWc2MGRnWUFiVGYvRzBSWVR0Zk5iZ25yT0pVcjVicDAzRnNzS1g1?=
 =?utf-8?B?VVJ2WkU5VXBmQkRWcU54U054WXIyQjN6cGg4R1BFVFJBUFZoSVV6Q09jK3VL?=
 =?utf-8?B?TDY3Ynd4M1dBYnFKUG8ra2t6Rk1XL2p5V1ZpVkQrNVR0b3dzcXh2Mytsbnha?=
 =?utf-8?B?YWJlblJUM1BsT2pQb3hVQkZTUFNya1JyNUZFY3V1QWRxK0llRVJnZnFKZFlK?=
 =?utf-8?B?SlI3L1huUVJjamZ3UlgrTGZnWldqa3ptQ3Q1cnZ0SFB3bU9JWHQzZzF3VDRs?=
 =?utf-8?B?Z2pZUm1PUUJTaE1CWTNBaWhia3IxWWkxOFkxN1Zrd2dzUmhNTzRDQTVjK2Q2?=
 =?utf-8?B?WG9TWUZscFhpb3ZCRll4cGZ5ZDBUdFFMOHY0NFVwbFdmZFQ1cTdqNDVLMWFi?=
 =?utf-8?B?SXZ6RGJKK25icTN6UHRjaUt3cVJhVllQZ2c4RTNtNS9UbHVxZUNhT2JPdlZ3?=
 =?utf-8?B?RGRZc0ZiYnl4b1libXNpRG1Bb2prZk1vSEg1RXBpN0RUd3BWMTNsV2k2cVg2?=
 =?utf-8?B?SWkyYkpTbVU0eWYxL1NyVXE1UzNQQWtkbEkwZkoxczhQbGQyUUQwVHBraFVz?=
 =?utf-8?B?WUk5OHp1S1NZaGUvMnoyMFpra3pxRXlwSzJNVzljNkUrM2RaYVVRQlZaYW1I?=
 =?utf-8?B?Q1ljMlBYS3dnSWtiSzB1R2NrM3E4VEkzbUpVcVU3cXhpQmV6a2ZNMlc5ZEtu?=
 =?utf-8?B?SlpycjBZenF3OHFrM1hjdFJCNitrdkNaNU9zYnBGaldsYUpyOS93Uzhma2NN?=
 =?utf-8?B?bnFMcUFwYjJqRWNoWkcvYjZieldSWUN0M1gweXAzYXlhMFU2d3J0S3c5bzRo?=
 =?utf-8?B?cmhYTWpNdFhnV1FTWEd1UnhNNGtudFhFWVMwWGIyekF2R0hFTktZNFpnYmxU?=
 =?utf-8?B?SjcvMVY2elIxN3NMRzZHeTRMemxqR1VxaHdyaHJDZE81clVtTnZNK2lFOEox?=
 =?utf-8?B?MWhhdGxzOUFmQmR0QkQ4R2YvUjE3emxpMDNQRTluZVErd0p5SHJxSXVDVUls?=
 =?utf-8?B?WU5IMG03bXpsb3VEMnVjYm45WXlLTWRTdlcxbmRpdlJCUVArWUQrYlh0YXBk?=
 =?utf-8?B?VytROEkwV2tGOFBZYnMrTDVBbVl5bVpCOEExKzdMOVZ4Y0Nxd0s2Vkk2QVQ1?=
 =?utf-8?B?RWV4QVhpUFRlbFNOdVRLZGpyTXR5RXp5RCtQKzR0VUpXWnRBaGxHYXY5VTBu?=
 =?utf-8?B?eUxkN3lTUWN4V2YwdXNDVXdBdE1jM1lSek5MV1gwSGtINHFZUzJjZng2L1FC?=
 =?utf-8?B?SnZpckp4dzhkT3VyOThaS0lQWVFGaE9wRlJyaXFFSlBiQUhyZldxQUswS3k0?=
 =?utf-8?B?ME1TaytORk1RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVYvTkN3aEVKOFlLWWdRcXlFR0ZyVmNSM1c5TDZSTVlUMFIyWEYxTTJLY2pq?=
 =?utf-8?B?WS9xL3AzOCtiQXJFZWJGanlOQ2RRWnRrOVBKK3dCZUptZHpXQ05JQ1k4ZUlN?=
 =?utf-8?B?TWFkcWtOVzhDYmYrc3ZpUjk2bkh0cGljcE9uOUxYb2hmWUZ2Nm1jTUYxYlYz?=
 =?utf-8?B?aW45V210UXBqUUdjU3ZOMzU0M3JPVzZudFBRemxjSjBrRXFlV0k3Q2lybURp?=
 =?utf-8?B?Wk5iWDJneGROeGpzdTlOMVAzK2l6TGRPdUVzLzU0bmZNSFoxZld5QWdGcllX?=
 =?utf-8?B?alZIUE56Tms1WkUrTHpoME1Ud04vQjEvOXl5cUI3ZDZ4alB0QkpVNkZxaVV3?=
 =?utf-8?B?M1dpVExabWpkT3RlMjk1SFp6ZFJUTWUzYmt5aFc3Uk5KQ2JLK0UyRjUvWUEz?=
 =?utf-8?B?bm5pODJWUlgrZlhtR2ZTQzVJN3BHc05CcklYVXFwVU1YVlh2VE91bGhBZS9Q?=
 =?utf-8?B?YXBXUmZueUJzekhJV2ZNdnowR2RlTE9BY1hVbXFkdUY5K0hWYzMzcmh5ZjQ0?=
 =?utf-8?B?ZW5mQlpMUTkwSW1tQ3F6UVhOeGUwNkR0RHorTHFHL0d4TEh1SFNjM2dZTnhy?=
 =?utf-8?B?RGt1cTFVOUVrM01TUVpjK1ZxT0lWMXhrSVk3eCs0eFRkam5FWVI5aUZ5SlQ4?=
 =?utf-8?B?TVFnUStRMUhIYkNtN05PZ0FaeDZRYUdrQ1IydWoyMzh1eW1seE1XQ0xsTDlm?=
 =?utf-8?B?VTIrSjZiWnB4MVN4bUlzcmVrckx2S0hwbjgzZUtSbDJQcU1LYm53eXJmZmxY?=
 =?utf-8?B?NE1XdWMwUk8zYUpNRmV6bzRTdjVFTllBcFRReUNwN08zdURFY1BEZ1hkdWp1?=
 =?utf-8?B?R251c3NySFhjNkx1cUs2aEJZMy83Y0dGRzBWMW1YMkNZZFEwbXR1RWJSOFFh?=
 =?utf-8?B?bnczYjFXWXB1akZZdWQ3TkFoUFd3bXVVTFZIS0lNRkZZeFpxOUw1US9sMGIy?=
 =?utf-8?B?WFpYaGZXVyt2Nk1VakhIdWV5OVNGcitlUkVmclI4SkNXUTRkMFhPdXpMbUxJ?=
 =?utf-8?B?bWd1Z0NYZXpOSFlOTVlKSUxISnNQR1pVQk1jV0RjeWJzK0d1c1FzR3k1bjFp?=
 =?utf-8?B?VVZNWGRmbVNFRWo2b0JHY09aV2szeGJwc0hOQjRvN1Nnd054UHRaTVp3ckVQ?=
 =?utf-8?B?U0pVcU93OEpqNml2ZjJHUnBFYlVoSnFyR1lhS3daZUZleld1OEVWcCtINVhL?=
 =?utf-8?B?TWt3RjEyRTl0T1p1dHU5dnNNMm0zRnljdzh5aHgyUTRsZXlWSlFWbnVDUnJn?=
 =?utf-8?B?TDBVMU9aeWJ0UHdqeVVSeVVNKy81aWoyaTk0OW01RkthcXVLZHZkSWxLbnRU?=
 =?utf-8?B?aWg0eU5pWWxYMlRQL2pRWnp1d2hpOVN1UXBkTGlYYzNWN3ppKzk0bkdueEtG?=
 =?utf-8?B?RjJKaHZxQmcrQzNNQ1czN2trbXI0dFNzdDR3Tlo5c0lSdUM1TjFENU5HZGNq?=
 =?utf-8?B?aFZNaVY3Y2x5Q2Z2ajg5MFNGQWJUNms1OHVYY2tqQ1dEUmkrcHF3eUpsS3p4?=
 =?utf-8?B?K2V5dW95dGovenlEYm5HdzdVWDlTbnh2aThjZ1VvdzdwYVpSakJJME80cUov?=
 =?utf-8?B?SjIzL2Jyd29MZlNYRGw4SklmZ0pML0JBcDVsSU1zUG44a1BDeXNjN1dJc2FX?=
 =?utf-8?B?SldyeHZYLzBQbHJjeW51MDBlZU0vWlB3ekwraXphT3dIQ3BhY3ZSRnhEdWo2?=
 =?utf-8?B?YlBBbzkxTGFZbWFVUTZIQlR6ay9hV1dOMXJENXJET0Q4V216MG56OTBBaWNW?=
 =?utf-8?B?QlFnNnpFR2tJM1pVLzU5elY4UlVCeFBWaWxkbnNsU0tOTmJlcFhic01nNU9o?=
 =?utf-8?B?NGJpckxCNVhGL3ZTbCt6Q0JUc2NNWnpsZ0JNOVRjMzJjMGpQVzFoL0tTT2lt?=
 =?utf-8?B?WWp5VW1SR1hvQmE0UXV1Yjc2TkxQc2RVTklGd0RTWC9QYmxUYldqMzQ0LzRy?=
 =?utf-8?B?M2l4bi9lbDRrYkRNYkNWV2ZYSHVtN0F0TnNxaGRyMUt5K1JpaWRsenByd08z?=
 =?utf-8?B?STZ1ZU52NCtWWnpqRnNMbzJJSkxQaTZJNWZnOVFTa2hhZG9ydUp4S1pvZWo3?=
 =?utf-8?B?RjA3N05mU05QQ1RPYWZpWDhrQ3FOL1ArWHpzaksrTEtVaTJUK2F6d2dxc0JO?=
 =?utf-8?B?dGlCUmZYUHhLV1RDYW5hajlacmtXZ2c2Nkk2eWE1WUx5UytpR0hUcWZSTjlD?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a03759-cda5-40e6-cd3d-08de3474b4c5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 03:08:18.8582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvEWlGtIu2HhIpNwgE03SrLhNph4FqpALLHerL/QumrMKXGIFU1SFxCIo58bLrRK7HnaVF9jgCbUmT46fEV+u6jAojwzoFmSV9ttJLm7+Z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
X-OriginatorOrg: intel.com

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm tags/tsm-for-6.19

...to receive new PCI infrastructure and one architecture implementation
for PCIe link encryption establishment via platform firmware services.

This work is the result of multiple vendors coming to consensus on some
core infrastructure (thanks Alexey, Yilun, and Aneesh!), and three
vendor implementations, although only one is included in this pull. The
PCI core changes have an ack from Bjorn, the crypto/ccp/ changes have an
ack from Tom, and the iommu/amd/ changes have an ack from Joerg. It has
all appeared in linux-next with a small conflict reported by Stephen [1]
(I agree with his resolution), and some late build fixes for odd configs
reported by the 0day robot. A recent small fix from Dan Carpenter [2], I
expect Tom to pick up for post-rc1.

[1]: http://lore.kernel.org/20251201125039.36b9f37d@canb.auug.org.au
[2]: http://lore.kernel.org/aTLEVmFVGWn-Czkc@stanley.mountain

PCIe link encryption is made possible by the soup of acronyms mentioned
in the shortlog below. Link Integrity and Data Encryption (IDE) is a
protocol for installing keys in the transmitter and receiver at each end
of a link. That protocol is transported over Data Object Exchange (DOE)
mailboxes using PCI configuration requests.

The aspect that makes this a "platform firmware service" is that the key
provisioning and protocol is coordinated through a Trusted Execution
Envrionment (TEE) Security Manager (TSM). That is either firmware
running in a coprocessor (AMD SEV-TIO), or quasi-hypervisor software
(Intel TDX Connect / ARM CCA) running in a protected CPU mode.

Now, the only reason to ask a TSM to run this protocol and install the
keys rather than have a Linux driver do the same is so that later, a
confidential VM can ask the TSM directly "can you certify this device?".
That precludes host Linux from provisioning its own keys, because host
Linux is outside the trust domain for the VM. It also turns out that all
architectures, save for one, do not publish a mechanism for an OS to
establish keys in the root port. So "TSM-established link encryption" is
the only cross-architecture path for this capability for the foreseeable
future.

Acceptance of this pull request unblocks the other arch implementations
to follow in v6.20/v7.0, once they clear some other dependencies, and it
unblocks the next phase of work to implement the end-to-end flow of
confidential device assignment. The PCIe specification calls this
end-to-end flow Trusted Execution Environment (TEE) Device Interface
Security Protocol (TDISP).

In the meantime, Linux gets a link encryption facility which has
practical benefits along the same lines as memory encryption. It
authenticates devices via certificates and may protect against
interposer attacks trying to capture clear-text PCIe traffic.

The ongoing work is tracked in the tsm.git#staging branch [2]. A rough
map of next steps is maintained in this "Maturity Map" document [3].

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/log/?h=staging
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/tree/Documentation/driver-api/pci/tsm.rst?h=staging

---

The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bceb0:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm tags/tsm-for-6.19

for you to fetch changes up to 7dfbe9a6751973c17138ddc0d33deff5f5f35b94:

  crypto/ccp: Fix CONFIG_PCI=n build (2025-12-04 18:14:08 -0800)

----------------------------------------------------------------
tsm for 6.19

- Introduce the PCI/TSM core for the coordination of device
  authentication, link encryption and establishment (IDE), and later
  management of the device security operational states (TDISP). Notify
  the new TSM core layer of PCI device arrival and departure.

- Add a low level TSM driver for the link encryption establishment
  capabilities of the AMD SEV-TIO architecture.

- Add a library of helpers TSM drivers to use for IDE establishment and
  the DOE transport.

- Add skeleton support for 'bind' and 'guest_request' operations in
  support of TDISP.

----------------------------------------------------------------
Alexey Kardashevskiy (4):
      ccp: Make snp_reclaim_pages and __sev_do_cmd_locked public
      psp-sev: Assign numbers to all status codes and add new
      iommu/amd: Report SEV-TIO support
      crypto/ccp: Implement SEV-TIO PCIe IDE (phase1)

Dan Williams (17):
      coco/tsm: Introduce a core device for TEE Security Managers
      PCI/IDE: Enumerate Selective Stream IDE capabilities
      PCI: Introduce pci_walk_bus_reverse(), for_each_pci_dev_reverse()
      PCI/TSM: Establish Secure Sessions and Link Encryption
      PCI: Add PCIe Device 3 Extended Capability enumeration
      PCI: Establish document for PCI host bridge sysfs attributes
      PCI/IDE: Add IDE establishment helpers
      PCI/IDE: Report available IDE streams
      PCI/TSM: Report active IDE streams
      drivers/virt: Drop VIRT_DRIVERS build dependency
      PCI/TSM: Drop stub for pci_tsm_doe_transfer()
      resource: Introduce resource_assigned() for discerning active resources
      PCI/IDE: Initialize an ID for all IDE streams
      PCI/TSM: Add pci_tsm_bind() helper for instantiating TDIs
      PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
      PCI/TSM: Add 'dsm' and 'bound' attributes for dependent functions
      crypto/ccp: Fix CONFIG_PCI=n build

Nathan Chancellor (1):
      virt: Fix Kconfig warning when selecting TSM without VIRT_DRIVERS

Xu Yilun (1):
      PCI/IDE: Add Address Association Register setup for downstream MMIO

 Documentation/ABI/testing/sysfs-bus-pci            |  81 ++
 Documentation/ABI/testing/sysfs-class-tsm          |  19 +
 .../ABI/testing/sysfs-devices-pci-host-bridge      |  45 ++
 Documentation/driver-api/pci/index.rst             |   1 +
 Documentation/driver-api/pci/tsm.rst               |  21 +
 MAINTAINERS                                        |   7 +-
 drivers/Makefile                                   |   2 +-
 drivers/base/bus.c                                 |  38 +
 drivers/crypto/ccp/Kconfig                         |   1 +
 drivers/crypto/ccp/Makefile                        |   4 +
 drivers/crypto/ccp/sev-dev-tio.c                   | 864 ++++++++++++++++++++
 drivers/crypto/ccp/sev-dev-tio.h                   | 123 +++
 drivers/crypto/ccp/sev-dev-tsm.c                   | 405 ++++++++++
 drivers/crypto/ccp/sev-dev.c                       |  66 +-
 drivers/crypto/ccp/sev-dev.h                       |  11 +
 drivers/iommu/amd/amd_iommu_types.h                |   1 +
 drivers/iommu/amd/init.c                           |   9 +
 drivers/pci/Kconfig                                |  18 +
 drivers/pci/Makefile                               |   2 +
 drivers/pci/bus.c                                  |  39 +
 drivers/pci/doe.c                                  |   2 -
 drivers/pci/ide.c                                  | 815 +++++++++++++++++++
 drivers/pci/pci-sysfs.c                            |   4 +
 drivers/pci/pci.h                                  |  21 +
 drivers/pci/probe.c                                |  31 +-
 drivers/pci/remove.c                               |   7 +
 drivers/pci/search.c                               |  62 +-
 drivers/pci/tsm.c                                  | 900 +++++++++++++++++++++
 drivers/virt/Kconfig                               |   4 +-
 drivers/virt/coco/Kconfig                          |   5 +
 drivers/virt/coco/Makefile                         |   1 +
 drivers/virt/coco/tsm-core.c                       | 163 ++++
 include/linux/amd-iommu.h                          |   2 +
 include/linux/device/bus.h                         |   3 +
 include/linux/ioport.h                             |   9 +
 include/linux/pci-doe.h                            |   4 +
 include/linux/pci-ide.h                            | 119 +++
 include/linux/pci-tsm.h                            | 243 ++++++
 include/linux/pci.h                                |  34 +
 include/linux/psp-sev.h                            |  17 +-
 include/linux/tsm.h                                |  17 +
 include/uapi/linux/pci_regs.h                      |  89 ++
 include/uapi/linux/psp-sev.h                       |  66 +-
 43 files changed, 4323 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
 create mode 100644 Documentation/driver-api/pci/tsm.rst
 create mode 100644 drivers/crypto/ccp/sev-dev-tio.c
 create mode 100644 drivers/crypto/ccp/sev-dev-tio.h
 create mode 100644 drivers/crypto/ccp/sev-dev-tsm.c
 create mode 100644 drivers/pci/ide.c
 create mode 100644 drivers/pci/tsm.c
 create mode 100644 drivers/virt/coco/tsm-core.c
 create mode 100644 include/linux/pci-ide.h
 create mode 100644 include/linux/pci-tsm.h


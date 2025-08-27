Return-Path: <linux-pci+bounces-34863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B36CFB378E7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C897C342C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A78330DD38;
	Wed, 27 Aug 2025 03:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNyRh89H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581CC30DEA4
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266794; cv=fail; b=KlP3NYi4JTREkpuQTFKN/YKChoBaHRjKm6rNlma3g5Xjr5hZmpiRb7rRIC+h1j27FG1MsAWXUiAvCYmAuH9x9hzE93ZgeZADt+biprIOOIDujH0mbw8EZHuQX25Z4pFMTgLF/FpRa7amflWSp0Lt4NcsK+WhWf1Gsxbz08Ploc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266794; c=relaxed/simple;
	bh=vwHin8pIdac3B/wqTma+gUsZEcZoKDYnBt4msym1JOI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ap5t1cFO4kWgMbceYDMXs7/0F898BTB6eZ3xyHdQKUT7yzDB54Dx8ftdQmUXbRXMu3Jr+al+WuWlaS+rE7fcyIhSuBoIg8ReiqjFjQk2ReoOyd150awfyyon+qbOTrlDiGAGWkBp+uoM2mZG1u/47qa1uxlWgnUw19CHae6dZ6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNyRh89H; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266792; x=1787802792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=vwHin8pIdac3B/wqTma+gUsZEcZoKDYnBt4msym1JOI=;
  b=BNyRh89Hbh0RCZRIW76q2/FHbTgF3qrEuaopZiBJPFNIBk1MHhH0QVI3
   WBgGVQZKIlUSB9VKhyHZtRM2P8EN+PhbgFX1fjVng5J3XWedj5zr2xMhv
   /ksylq4iaEqaRBMOBarg1KFaGm6YZWB47ZtgpQfX91SnvFBhSvQqPqxyV
   7RsC87R+WjLy6WOozhxuzgi2tRPDJa418kHAM5/XpDo7CEq1IcO+41Ptg
   ldAK0KRFjSTzGUXtL9LbHAAABZ82m3BDbCKQaqVxnID4Uvq8YoT98UtXI
   xdm4i8rdwQeI9ER1UsS7XIy0BCyBwlo550ivdLBBoElC0172XYk3hVLES
   g==;
X-CSE-ConnectionGUID: xfyksSAAScqZeFuKZ8e4TA==
X-CSE-MsgGUID: dY9ltUgzSLGIrZC5bFIubw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69106538"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69106538"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:12 -0700
X-CSE-ConnectionGUID: alL7+HmJS7O2hkwziw2GIg==
X-CSE-MsgGUID: SMZx/fAES42qK+YnANv6iw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:53:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.75)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SK8itpbQXBKSOboGYcoB5nc3DBIaKhSwxiU0p1D8U4Qsnh8idAe+H3hxBv07VYhq9n/z67lDchc3AOX7c2cl2XJEw5aM3iot/XnDPKMS7ePkCdTIHSs96QIB4AkA64ruBwsLOOPhFTlNVubp4Fwyr1klMlemYeZ19hso/B+5lcxUYswIRsfdT6zOBttvDZV5IXTVZGVl3XDDSGxqtCDz5AYFO9JXWZorGpJNrDCa9zqLRrV459NdBZpyLGdF4OD2OSuuB6yDsL/ZWg04FEY+KivVyNbiYanMqH9RonLHtxDr8iif1tNJjVi1XL8zYblfW8vcXMbfJ/jneFDMcFLoFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+prVgsFqv20f4Hqh/QPPAXqkWo4BZJ9QbiatN9RAr0=;
 b=qxoJ1dvJAupMN2r/0EAKxXY/jZxmo/AdU6Pdtq3tB5QpWwXW6sfElj5LUzQAvsqi9IfA1OivGnnZbqYHzleOLnlHzFzEyGJv8nHl2A+ml4yRkgQjRBknitV5MeUGOsNBZO6ROa7qVivU7Cq+ZK5GRsg+5om7l/NYKltmThSpjAhWC4PFYHpURcSo1xCAPvJQT7+SWHUBiBaGatJCYDTxEOks2SJ06iijdP6m3qS6KNmHf7jx3+wnj2bt43yBKidD+L3JYFnItuzY9E0kmEkr0jYc/ilONswgTxNhONX4GKat97Bv0A7OOB5NC7Dx+syJXDAXGn+qedsVJJZfWNrzbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 03:53:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:53:08 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>
Subject: [PATCH 7/7] tools/testing/devsec: Add a script to exercise samples/devsec/
Date: Tue, 26 Aug 2025 20:52:59 -0700
Message-ID: <20250827035259.1356758-8-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827035259.1356758-1-dan.j.williams@intel.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:303:8d::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe646fe-9f89-401d-5c25-08dde51d3be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?txPTBPafAkOKEs/2JWAGJdzJaH+HCg99mr5i1JqIg1+MPzVIlMuPzAsZjFZ5?=
 =?us-ascii?Q?yjzE4A6PlF2qV+qzRnUsH0dCNDWIGK2qWwXEh8BXgw+pnb57tabUpQY9mJ8x?=
 =?us-ascii?Q?PawfvzoMo+pVNjAlxZFnUWEfLdP6Y1d9jqVY+dtvbpkIcQvnsfZrlO3Tw6+z?=
 =?us-ascii?Q?w6S59Eo8S3UoHrWDRS44GtjZ2IKMDY6EqsJPwngQ69fYircNc9cl5LptWC/w?=
 =?us-ascii?Q?Fu9X8AvubKCnlCn5q62aXP0+/Wxxp1Zkcvyl4AhJdBoX8Yl3j3NtwvwHPz2C?=
 =?us-ascii?Q?7gTJPVqsKWFFDEnd6V0vMTMYjiyOFfEwJO4C1Qf40mjYJlOrspljntZQtsNO?=
 =?us-ascii?Q?7XIpvmZP1Tewl52G4Tv9tL8qL11RSmFe/SwRYq/9GcWSNOxahZVSLTgpMeaE?=
 =?us-ascii?Q?hNSxugFwTdeNTsWFXQeqvDnKDGECO+UMw+SkzCRgQYVCgk62OccgfLuAkr96?=
 =?us-ascii?Q?wY8Q6Va0sR39UJnKkIvu39OI3SmEe6LGH/IPTH6IZ3pXicoyX1/dXv0PPweh?=
 =?us-ascii?Q?u+NRFwsAWA2yyKgtU64kkMiE8O0j0mOjUWVGUv08GG5rILZUGFhwed5fdsj8?=
 =?us-ascii?Q?Ji1gLYyqB8ojOFAf/0Vu7HA5X5E/DAJGwMpSow0eIHzUN5KQcVU8PHL0W3Pv?=
 =?us-ascii?Q?WyxAc5ypGLwQ8jfbAAIyjlT8qi5hvHMuxLKqijiXztHoCXmKdQZUXlrEmJ6v?=
 =?us-ascii?Q?YqPt4V4zYllGswCHGUYf7qEtPs+tkVSBD7Mv4dd4cxfv59XFWMzQlwfdMXKD?=
 =?us-ascii?Q?ch6RLnHarm6sL7J1nndF4jRY2TqhFloeXl3Fqx8/aT60XZI4LANLj/m2Vtqv?=
 =?us-ascii?Q?2OwVJv6GQQAmqNkW4mk/xeTpQitLqjsxgr0vmz8ji+e4fPkpuZNuuPn+bFwM?=
 =?us-ascii?Q?yMOY72LL4xq/5CbB8pAKMSsGIkukOq7bJqpiUVgyZhYCk0AJr2JO1CIm5g9s?=
 =?us-ascii?Q?/mgBG1mVw8XNQVuWYFTWa56QVcCnxbZZCon8pwvWSWpO/4pMRIjpy4PXeKNv?=
 =?us-ascii?Q?SauYe0D97hpSyjnGx4AgjHlpQN1dU/wDsjeWxuQb9al4kkqIUpGpOkNpLJdO?=
 =?us-ascii?Q?juhqbCvD5v9zLLf2xkuzvg2Af4X+0D5fgL2qGE2ycDit63ABGi4zgcwwzYvs?=
 =?us-ascii?Q?cR1c0a8NbtrX/obkjC8urje1tf0jQGzKpi05ThSUJkiidICmCbOPGxkV7B30?=
 =?us-ascii?Q?aYNYVPs+6A3uRq2HyOvJ/9BNfYF3lJQYpJnjAcpewMgHxp0akJU+og4mX2nk?=
 =?us-ascii?Q?lZOXx8quSog4CnNRqGd0sEGN0P7P1C/lGteJhIacaev2vYad0xoM0PtPg8Lw?=
 =?us-ascii?Q?3wz2xdIqpwxoan6nyUbhXJJrl5XT3CCi3kMGgUOfV0aZYFsoPoHiiO9UpGKm?=
 =?us-ascii?Q?9+H/3PAH4bhNjLdQlp+jTbv4aaNLIdKkvAMJeBg7S7bXX2akeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UssOgV2GgIajWFRHBIn0jW5/NHE1Z338MpP+59T6g656py331eK7m4ADWVHA?=
 =?us-ascii?Q?4lS6AKmdEtOGEDJP+rDxRubuhu9I+C6WVnqIdGjRXoT670pp6TnHi1rV82+8?=
 =?us-ascii?Q?TebhZXqDWfgh3/agH2XtZuV4lFpiW8a9Z9LZa3q98lL2jOruED4hKiIuTUiY?=
 =?us-ascii?Q?ku7ZiMWCvmdZ6N3Ks7CWqHIOpCvDpp4w8rxPd4PnI7L4SmgIdQVxcQIOOWLS?=
 =?us-ascii?Q?YSWmq7Veb1KWcdbpwkqGRyS93/waTzY92zZswCavJkFmVLIU4NvlcFcc+KWB?=
 =?us-ascii?Q?IpQa5d5ptOSIeRQ6y56HqAPfZOa/Op7/rgibpD6PyZWGusxh0RR1dL8600hN?=
 =?us-ascii?Q?aWErYNUKgFdTI2M/ltTVRW7usoSoIlXg1ojlRhnsSmvVXIJjHqfZhxqdn5cX?=
 =?us-ascii?Q?dQCqX7wy6J2eC5Hzx3GtFxVv1WVggttEYP0neben7XljAKYBLc7ReEX8jhdo?=
 =?us-ascii?Q?A1ahcRpn9921S7Bn0n895lE1Pux1FMy2fR3TIV20rOJQp7OV51OccwzVfs/q?=
 =?us-ascii?Q?36g4aiGbyDu3MF2LyrYvD/+ofM40ZJ2QzkYbzCC/Q2YgA6TQxriSZwVBSZ2Q?=
 =?us-ascii?Q?ftDb7Jx/bfgYb6LBfU8Sdzuw6ao4dLys8+9dBID65RHkjDxMkYVfYpHXUMZn?=
 =?us-ascii?Q?q2xyriBQA488qaOwcSwAcO7V3K3GptUky2IdQ9fD+miBXwUCMz32Z2yBlLD8?=
 =?us-ascii?Q?EDgvwxds588YLzAtoqYS5fuXr2q+U+qQTB3DzMgBtdMGpMkIfscBdPYYR3Bu?=
 =?us-ascii?Q?IJjc2OMCWIsfjsGkAE10eHz2GufNzJoJIoJSMtKja2k/gJtcJvMD86fD7oZh?=
 =?us-ascii?Q?U6I/G2i9gJZxXeDIOuBNP4VqbL/ByxtdB10vyk7/EurP9dBV4KIYo6j2EVNV?=
 =?us-ascii?Q?qdULvYwHP5HlFfEDQNf92urD/jCsZGoZhLAJOrNyUx8TONOLBP1KvrLueVkv?=
 =?us-ascii?Q?hMBxSPpW6pEVggN9CD3xIaVQeF5dHg/7vRk6oBeelkYSk9Q2pCUvIuUkSYtA?=
 =?us-ascii?Q?zyLzVNhKl+1FpDoCEQC5Ib4pJPJZej4OPHFjPRyheziNwayJuKsrHMmatk9I?=
 =?us-ascii?Q?FVfRJfzwqFffyAmWATPySBNoiicDLxcXSWzZ+o3zwwpmBvAdLAp2zu98eL7b?=
 =?us-ascii?Q?MQ6Z9dsyhdcYSfgz4goEqp3OhXB9NuKVb0imXDjdDJWYSCAKMHoUFGlGAUiv?=
 =?us-ascii?Q?DcejuDF6ItF9MgWxWOgNccjfpWX6b97xOzJEDQcRzeNqNjkTtDMSg3ERmTJV?=
 =?us-ascii?Q?DryFZ5ONummoN+I8Qt7jtaeRgL9i+8Vdkna7qOMupgDbq3vGburHVNYe9Tud?=
 =?us-ascii?Q?KEVzHKF8MoO+oeYlWbZO3e9aiVmNmS/4puUj3x8ubrlvCODxwvinmtI/hQ+T?=
 =?us-ascii?Q?HXydQM05bw3VkodP5uW11jOdi6bOX6oRaN0biX922Q3YJxuCCY8P8ZcO3Ohf?=
 =?us-ascii?Q?JNpvQpf5+wgnHOkIA4tOTj58VB7h2iDnoQ5Q9kWgQxggHeZ/2y4pxkaVk4tJ?=
 =?us-ascii?Q?T0HGcMZGr0Q/8mHEFCaDcvJWUbFs3XelYGxb0er28lRXoTrQOHM+mwsZlZiI?=
 =?us-ascii?Q?wjMguWpiZcaadDpZZroDvHfaOi8aNKmIeDIuwNsmluvN6nWLKJgCmbx3QClH?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe646fe-9f89-401d-5c25-08dde51d3be6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:53:08.0006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EIn8JVaMx+CQX9OazAuWRsVOA9PMM5TleSeAS7+leqgIWGgVMDWsRTSuGWyVjGt8yBzpQbNwp4ZKP/utFaFFDRMYcyvuWUeKf8eHOyTujA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6170
X-OriginatorOrg: intel.com

Run the samples/devsec/ infrastructure through the PCIe TDISP connect,
lock, and accept flows.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/devsec/devsec.sh | 138 +++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100755 tools/testing/devsec/devsec.sh

diff --git a/tools/testing/devsec/devsec.sh b/tools/testing/devsec/devsec.sh
new file mode 100755
index 000000000000..cbf4b43ec93a
--- /dev/null
+++ b/tools/testing/devsec/devsec.sh
@@ -0,0 +1,138 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2025 Intel Corporation. All rights reserved.
+
+# Checkout PCI/TSM sysfs and driver-core mechanics with the
+# devsec_link_tsm and devsec_tsm sample modules from samples/devsec/.
+
+set -ex
+
+trap 'err $LINENO' ERR
+err() {
+        echo $(basename $0): failed at line $1
+        [ -n "$2" ] && "$2"
+        exit 1
+}
+
+ORDER=""
+
+setup_modules() {
+	if [[ $ORDER == "bus" ]]; then
+		modprobe devsec_bus
+		modprobe devsec_link_tsm
+		modprobe devsec_tsm
+	else
+		modprobe devsec_tsm
+		modprobe devsec_link_tsm
+		modprobe devsec_bus
+	fi
+}
+
+teardown_modules() {
+	if [[ $ORDER == "bus" ]]; then
+		modprobe -r devsec_tsm
+		modprobe -r devsec_link_tsm
+		modprobe -r devsec_bus
+	else
+		modprobe -r devsec_bus
+		modprobe -r devsec_link_tsm
+		modprobe -r devsec_tsm
+	fi
+}
+
+pci_dev="/sys/bus/pci/devices/10000:01:00.0"
+tsm_devsec=""
+tsm_link=""
+devsec_pci="/sys/bus/pci/drivers/devsec_pci"
+
+tdisp_test() {
+	# with the device disconnected from the link TSM validate that
+	# the devsec_pci driver fails to claim the device, and that the
+	# device is registered in the deferred probe queue
+	echo "devsec_pci" > $pci_dev/driver_override
+	modprobe devsec_pci
+
+	cat /sys/kernel/debug/devices_deferred | grep -q $(basename $pci_dev) || err "$LINENO"
+
+	# grab the device's resource from /proc/iomem
+	resource=$(cat /proc/iomem | grep -m1 $(basename $pci_dev) | awk -F ' :' '{print $1}' | tr -d ' ')
+	[[ -n $resource ]] || err "$LINENO"
+
+	# lock and accept the device, validate that the resource is now
+	# marked encrypted
+	echo $(basename $tsm_devsec) > $pci_dev/tsm/lock
+	echo $(basename $tsm_devsec) > $pci_dev/tsm/accept
+
+	cat /proc/iomem | grep "$resource" | grep -q -m1 "PCI MMIO Encrypted" || err "$LINENO"
+
+	# validate that the driver now fails with -EINVAL when trying to
+	# bind
+	expect="echo: write error: Invalid argument"
+	echo $(basename $pci_dev) 2>&1 > $devsec_pci/bind | grep -q "$expect" || err "$LINENO"
+
+	# unlock and validate that the encrypted mmio is removed
+	echo $(basename $tsm_devsec) > $pci_dev/tsm/unlock
+	cat /proc/iomem | grep "$resource" | grep -q "PCI MMIO Encrypted" && err "$LINENO"
+
+	modprobe -r devsec_pci
+}
+
+ide_test() {
+	# validate that all of the secure streams are idle by default
+	host_bridge=$(dirname $(dirname $(readlink -f $pci_dev)))
+	nr=$(cat $host_bridge/available_secure_streams)
+	[[ $nr == 4 ]] || err "$LINENO"
+
+	# connect a stream and validate that the stream link shows up at
+	# the host bridge and the TSM
+	echo $(basename $tsm_link) > $pci_dev/tsm/connect
+	nr=$(cat $host_bridge/available_secure_streams)
+	[[ $nr == 3 ]] || err "$LINENO"
+
+	[[ $(cat $pci_dev/tsm/connect) == $(basename $tsm_link) ]] || err "$LINENO"
+	[[ -e $host_bridge/stream0.0.0 ]] || err "$LINENO"
+	[[ -e $tsm_link/stream0.0.0 ]] || err "$LINENO"
+
+	# check that the links disappear at disconnect and the stream
+	# pool is refilled
+	echo $(basename $tsm_link) > $pci_dev/tsm/disconnect
+	nr=$(cat $host_bridge/available_secure_streams)
+	[[ $nr == 4 ]] || err "$LINENO"
+
+	[[ $(cat $pci_dev/tsm/connect) == "" ]] || err "$LINENO"
+	[[ ! -e $host_bridge/stream0.0.0 ]] || err "$LINENO"
+	[[ ! -e $tsm_link/stream0.0.0 ]] || err "$LINENO"
+}
+
+devsec_test() {
+	setup_modules
+
+	# find the tsm devices by personality
+	for tsm in /sys/class/tsm/tsm*; do
+		mode=$(cat $tsm/pci_mode)
+		[[ $mode == "devsec" ]] && tsm_devsec=$tsm
+		[[ $mode == "link" ]] && tsm_link=$tsm
+	done
+	[[ -n $tsm_devsec ]] || err "$LINENO"
+	[[ -n $tsm_link ]] || err "$LINENO"
+
+	# check that devsec bus loads correctly and the TSM is detected
+	[[ -e $pci_dev ]] || err "$LINENO"
+	[[ -e $pci_dev/tsm ]] || err "$LINENO"
+
+	ide_test
+	tdisp_test
+
+	# reconnect and test surprise removal of the TSM or device
+	echo $(basename $tsm_link) > $pci_dev/tsm/connect
+	[[ $(cat $pci_dev/tsm/connect) == $(basename $tsm_link) ]] || err "$LINENO"
+	[[ -e $host_bridge/stream0.0.0 ]] || err "$LINENO"
+	[[ -e $tsm_link/stream0.0.0 ]] || err "$LINENO"
+
+	teardown_modules
+}
+
+ORDER="bus"
+devsec_test
+ORDER="tsm"
+devsec_test
-- 
2.50.1



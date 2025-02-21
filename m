Return-Path: <linux-pci+bounces-22041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA4AA4026E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 23:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84696702055
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 22:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15551FC102;
	Fri, 21 Feb 2025 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1SS9gUb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B318DB0B
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740175416; cv=fail; b=Qcfw6fRytkSg9Fjr84kIImSnbJjoFgqZJhpIYcTxiqKm3/J4EFcUPcVZccjBD/MEewU7kKwJiMdapWM3aKabiLHuRGoAdcksWm6tyYPEnJTVLfHEc2z33WA23F13oKJNpp4EpHUn+b0zu0MpEZ1WZWpZxylLzFQsJpNt2ZuWYwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740175416; c=relaxed/simple;
	bh=ADJu7FVWzw8ucOKlf63k6jOTKK856KFtqnK0yU52EXY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XhnkbbMWCjl3Mjsbmxk8VvuaQ9hM5qPbLO2OCFiLIgdq0pKTbsIechCAhGaC94otjVwsLGDxyZvf4B6fajoUkQdQlf7bln6lEuHRB8U62mp9SuEwpxklVdNYcBFnNnrsJhCrsWw2nzd3MB1/X8mGnOr4dAtGyq0ZvgHSASasjac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1SS9gUb; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740175414; x=1771711414;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ADJu7FVWzw8ucOKlf63k6jOTKK856KFtqnK0yU52EXY=;
  b=W1SS9gUbF00Dc0aZQSgjuYaNL+xPaOBtRM5QCGMauZPKuKDrRmzaDntE
   Z3INLJiBvQKX7gvbegmHQPiZ+aHZIPCz574n0QdXrIXajo0qG1BxRZFuq
   3bxUMYrQWjQEiA1u/aagGZQJxJtmRfb3ViwG85zWhMqtyUUlsXP+5CAF+
   3lessWFFPKRn5LvzmEGSgCJyJA3P0MREWljSks47RboSqZq3WwdQbxtOj
   u4g4npZYNvGuZsw8JWFy+gHc1+mgihdQq2Kc1rBhPZHQcDuR1Peb1pTXQ
   DNo6+czTeg/T8JfaVAiYxPfQR27gma1yaDFpuJrJwz6+TwOg/ppd/Ayk0
   g==;
X-CSE-ConnectionGUID: +U2FsI7sRaOUySdcu9TQTA==
X-CSE-MsgGUID: hyxExio1Tz+/2DM4CGcc6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="44658319"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="44658319"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 14:03:34 -0800
X-CSE-ConnectionGUID: ba+SzoZZRyayG6By2LDzNw==
X-CSE-MsgGUID: kMaMkOcYSfmSNCK5D1xpRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120726446"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2025 14:03:34 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Feb 2025 14:03:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 21 Feb 2025 14:03:33 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 14:03:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJrFxabvqiJ0ym5LN6NCLyG4ybKCtazR1qrUH1obmwcd7Rzxa1NvNHamYLyU2tBlAFQidX/pjee1Ww5MGsO0eoQQhOO0YnXXwlZAvxLjiejOXd9wydeS/JWxDWq4iwiC66V2R2peA6QaowTVjEHJeqnpSr2EgDN+aya6Hx36pzFpUqcHI0cbwgxqHMhxjIExn20TK9gIKNX0yjvO11zC8NmHgllrZDXDphAtpPS7GaNgl+b59gDC6yOGco/bpRMJf/fYaS+4sUGL5ozmb44fIKK+FzOZ4T+kdOspZjkhTca4DZ85k11rTrZADUTzIpUSzC2gCLJ4wXq6HNR1+KH44A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbK8Gx/z/pr4KcgDtA5K7S6DEna8VtTHQaQM06siUzw=;
 b=Eah5t8lwkrU4EFzKm7Tmn7ZvppK/2DJuobirijujytHmxMYP9jc4JfA0QZPiLftKK2nB9W6/XJkEOoF+rRkrBZWcqfHqDnouQgb3hpC5wTRkuTvcyY7mUnlZiodjAuDCXcsJZ+g7/jdBWZMNYh++5ZwsXMajROTA6CNoYLglakE0XrPa/qFkt1rmrtUrj2hxdRBKs99+ac2E3wE7QuiL9zeEwNE7Jt3jtpTqDwh2lxAlQQIUzYRyaeOuXfSuG4spPGqFBoF5LkSBiPUKmAAEN2s8MNineTaWWWbOjr0HBGFN3DGefZ0ezM1pAGRCZHKwmKlX9Hgaez/VoGNjzj2S7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7015.namprd11.prod.outlook.com (2603:10b6:806:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 22:02:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 22:02:49 +0000
Date: Fri, 21 Feb 2025 14:02:47 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <67b8f80752fbc_2d2c294a4@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <20241210184720.GA3079867@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241210184720.GA3079867@bhelgaas>
X-ClientProxiedBy: MW4PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:303:8c::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ffb801-76d3-4398-fe84-08dd52c37b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fqbaptih4yuRgDMt8RmpVJM8UsyBuGocVnkpIs2KbwEXwWrvKMY8ZR13hP+Q?=
 =?us-ascii?Q?ZJL00KBm8KQQBjz+83QXMo607JdU+/6Ze9MLDOi25vxS5Eo4Xomp5LG4oOCt?=
 =?us-ascii?Q?hvJ0Bo6EYl9/NTh6sZAfMKXVEfixXRD9y28EB/2uF1XiD7o5+ja8T/ukrgts?=
 =?us-ascii?Q?RV3xJJlM0HjQRM6m48jDN/jP0NlLngyI+F+ijRCcPYyuyUnjfnjegCnChZ/E?=
 =?us-ascii?Q?2pKBwz+g2IGNMDAy7M+blxuOIUQXpiThMu6CvoKDl4zphZP7El8/TDQAAnd1?=
 =?us-ascii?Q?/8mZjJo58eXEDM5NDw/5rkZnzwvY0IljSg5DfJHnQiBTE/1GZaZK3dIxEpe0?=
 =?us-ascii?Q?2ZWVdsizt3U/FNJr0wKr2IQP5N0rWSoVJvsxvPNB+b72rUmy/8GpW388ZKkc?=
 =?us-ascii?Q?3SmT3/HVM9DamJG6CRTBQSoAWthZD/ESyuhaat0MAn0XNTvDEgjghUuVcrAw?=
 =?us-ascii?Q?jmmBCXHbQYxumNlxbhBqDOIOn7FgN8oK/xrpGb4TvKKeYn1gd3ntK/LLaSyc?=
 =?us-ascii?Q?FOE5cZMuK6IbhggAi0BhaWYAVZke1Jy73Pl9HxdoJ0mA1qUZiBx0Wt/7IYwK?=
 =?us-ascii?Q?avLhH9NxCZ+KdL+cmqSEaoDZZC0dAuuxBEXfvH2oMb+alSbgkCp168Zi6kPK?=
 =?us-ascii?Q?sa1IUixyUCUPCmJKuEgU3UCsMLyivT22iRcF5Rdof+IioLNS08IhI+VxUDra?=
 =?us-ascii?Q?3NUGoevaW1kPF+b1A04Su1uirC5BKMaWorCReKcH5b7MZ09HS4aPj5sYB0Ez?=
 =?us-ascii?Q?nTiN5SJ8+Ggj9GQEIG/Ir6Hks/+mlx9QZC/+gerk6s1AwlbldPLOtilI8+li?=
 =?us-ascii?Q?nVF4SDfs86gzIWrswc6EcWFIsXGWsbTY3/gt91BtDTSyJA6iVhpZc86UZJlS?=
 =?us-ascii?Q?CV3dojrtedgE/kz0PMhgdLgcYS06TimGek/Ti4hL51mCaaH6bXSWoABcmStJ?=
 =?us-ascii?Q?Gp62SdYhji9DxlQiRMDZE8oO2ibQ9tKXWJ+kpnLpUDojxUadzFAnE/+VRuz5?=
 =?us-ascii?Q?CX7VjKWLdub1fziiCUy1bR10/0o/+kEbsjwK5fR1NNskpKOs1DVrHfvH0mmy?=
 =?us-ascii?Q?BySZxMlkgnFHOdKsxyM6HN1i0q5zXVed0sDB20/VAS2grIy95dufBfNjFOkf?=
 =?us-ascii?Q?ETLOQEdzTZaEw1xtunrY0UGT8YH/Lb4cujrLIcsf4Ue2yOaBw+32RE5fHqEz?=
 =?us-ascii?Q?0ZPZcD/z9UYyHJFcTI1BI7IbVV+t3qppudlRqfPvlQqxKbHBSMWxg3Z8fa8A?=
 =?us-ascii?Q?xnsinQSS1/UixwMcokT9NiTteS5EVyi6eFCl9g1slqRoqw51v9HuJKgqZf7f?=
 =?us-ascii?Q?wB+OXHkJk5n4jFWJyHBcBdqfuJ8rA5x+RF41zHmIEXYQy5eF44hO/ikpYJjG?=
 =?us-ascii?Q?CP4g40Wim6DsX/dAOSmvNAV68vmL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wIVQdGRr1de6a0hj/dhBLthgR3L8IZbM/Y2/WhHZvpVvQmlBp5YkjqzATUfH?=
 =?us-ascii?Q?NdAvHfzhoIgiS0fQeH+EsNJM6azO/wfzMnucF5PWhFUoOuTN2sGZ/OnoMc1X?=
 =?us-ascii?Q?0UgV9+pqSN0u2be61Cmv7xLS7sTmsTgBFxfS38xgMNSSWlgICAR4932Ujo/P?=
 =?us-ascii?Q?Ygdd6jonQLp3WJjvhRja8y+4w27CTUd76mtKm7bolg64Xj5e8t0x2XuwsUp7?=
 =?us-ascii?Q?VhNsr68BDWf1TrER9XxhY5L01rfO0k/KB1uAGPWezoqP2KMlnXyUXM3IVsr1?=
 =?us-ascii?Q?asIe5l7ulVUcR4SzbZ24j4/gx9Q9JK2OSVrqI5D3GldebmKbblnQFs6xDlD1?=
 =?us-ascii?Q?8TyGu6c6V3Ssh9kfXwn2a30IKsCYJpjdIF61Pfp5yILGyQJxczetZbSqDHzF?=
 =?us-ascii?Q?fZZlg31j+Ul32hmNhw2TWYrZIRDGynw7nllQR3dot16tvq5TXIyD4vSyYfYD?=
 =?us-ascii?Q?Iag9pgWD3p+hiNXeOPqMFeKbA/LhXajW/RRX8ZGUyvvEgbVikCC/VmXoj9Qt?=
 =?us-ascii?Q?tIrjRiV2WUWc/bi9zJxY49OrEWZmwEdN929VUZguK+8A3RpTYq3ZCwSVBEzr?=
 =?us-ascii?Q?8a8zXTfXEf4t803Me11RaZqR6yBiSrZyhrbGWdjEeqVX18BcXdTj5gedQ83e?=
 =?us-ascii?Q?BF+6tNFc6giq8KWh7DSd7iJcnT7c+w3y492x7ciwUuwlachpud08OaT2rwz6?=
 =?us-ascii?Q?Pk2Le1IMzbiaTKem0CI9gc0ToXLOpH8E6XT1r3vnqOd00sy+1+mFeU+GWSvR?=
 =?us-ascii?Q?vaffHugc1LE6xHWU48KTWSK8UyFX4s/s3bENB0LEzpH4W3IdhEOI5O3x2tXL?=
 =?us-ascii?Q?yLRAhG+yUXgJHdG/KlHdI0aaZszSQ08MR/sfXuP7OeyI7uG/cUGklKveRKBj?=
 =?us-ascii?Q?N41Wqk1F3shRcCmknqCOBowqhwJ1Tte5k4pOrlD0OT0fmj4XvAlBMJl8J7q5?=
 =?us-ascii?Q?YRF8at7VAUW7BMBzbyPTYV0qPdl5KF1h4A+qfZ6eoL9Hidh16tDGWGBY5ABa?=
 =?us-ascii?Q?aTs1sSU2ga00xbZelgzD2exkgBiyaW68FaUvlaEyQ6JknqcRJ5Qz3+VZdpA8?=
 =?us-ascii?Q?ko1gl7xIgWrTqAX8KbnnAGww+D1xAZ2sSXWdlvn1Clz4kZGHg4q6bdOkCVDe?=
 =?us-ascii?Q?fVpUiyHb0eDcVM0kuAaYZAugjrtCDjCesu14/Ps6VAn78waBnV6oSgegfuQH?=
 =?us-ascii?Q?h3Tq7mqNXoNwMCFtHA6SaDiGevIuowtw4/FU15K5kvqhKglFrqimZtNB255+?=
 =?us-ascii?Q?HHTJPUyn7aOtWEp7ITQTZ1rQ5fWt3XjtBrqXMh4e+/sD61W9Oq/Td7L0odPs?=
 =?us-ascii?Q?mtrdzge17uKZV6u/H4MUM+LdGpIcn1lN/VRT+FuWSs6KrG2ycARG/KQ1np8/?=
 =?us-ascii?Q?fIfpQtHR9zB6yUz7r7MMDTHBH/egQJapLAL7x84uiZQSEbSN2dEPiSK6OSqh?=
 =?us-ascii?Q?ZMPN9FnyoKR0woDOCdV6n9JiF4303C2nQ3swik3it9OgOfPh1xck5fpTUWja?=
 =?us-ascii?Q?3XOK26oLBPshtWQlG2/NWtQ3/MgCv2ePz9l8hAVqDTw9WEbHXmjNeBW3XPa0?=
 =?us-ascii?Q?/lxVrhBi3nXr/SOjuz0JIXdCdxDa5ZRV1WNV3ttmcex22eZgTb5Kp53FrQbf?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ffb801-76d3-4398-fe84-08dd52c37b31
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 22:02:49.7334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78ogMdXTYRLYYlWDKTnDTCTiSIkfPUYy0E8/XZXaB54IRkHhF3VVx8J9iSPsBPBZjd7WZB/qP1P5baMoMNUibeK4BPQG1uuFwzi1niGieqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7015
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Thu, Dec 05, 2024 at 02:24:02PM -0800, Dan Williams wrote:
> > There are two components to establishing an encrypted link, provisioning
> > the stream in config-space, and programming the keys into the link layer
> > via the IDE_KM (key management) protocol. These helpers enable the
> > former, and are in support of TSM coordinated IDE_KM. When / if native
> > IDE establishment arrives it will share this same config-space
> > provisioning flow, but for now IDE_KM, in any form, is saved for a
> > follow-on change.
> > 
> > With the TSM implementations of SEV-TIO and TDX Connect in mind this
> > abstracts small differences in those implementations. For example, TDX
> > Connect handles Root Port registers updates while SEV-TIO expects System
> > Software to update the Root Port registers. This is the rationale for
> > the PCI_IDE_SETUP_ROOT_PORT flag.
> > 
> > The other design detail for TSM-coordinated IDE establishment is that
> > the TSM manages allocation of stream-ids, this is why the stream_id is
> > passed in to pci_ide_stream_setup().
> 
> s/stream-ids/Stream IDs/ to match spec usage (also several other
> places)

Sure. Fixed up this one, the print statements that were using "stream
id", the code comments, and all the other patches in this set using
lowercase "stream id".

> > The flow is:
> > 
> > pci_ide_stream_probe()
> >   Gather stream settings (devid and address filters)
> > pci_ide_stream_setup()
> >   Program the stream settings into the endpoint, and optionally Root Port)
> > pci_ide_enable_stream()
> >   Run the stream after IDE_KM
> 
> Not sure what "devid" is.  Requester ID?  I suppose it's from
> PCI_DEVID(), which does turn out to be the PCIe Requester ID.  I don't
> think the spec uses a "devid" term, so I'd prefer the term used in the
> spec.

Indeed my thought process, was "well, Linux has long called Requester ID
'DEVID' so just pick 'DEVID' to keep with that momentum". I am fine to
use "Requester ID" in all comments etc.

I'll also switch any usage of "devid" to "rid" for variable names and
just note somewhere that PCI_DEVID() is the "rid" as far as IDE and TSM
code paths are concerned.

> > In support of system administrators auditing where platform IDE stream
> > resources are being spent, the allocated stream is reflected as a
> > symlink from the host-bridge to the endpoint.
> 
> s/host-bridge/host bridge/ to match typical usage (also elsewhere)

Fixed here, found an additional one code comments, and the documentation
file

> 
> > +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> > @@ -0,0 +1,28 @@
> > +What:		/sys/devices/pciDDDDD:BB
> > +		/sys/devices/.../pciDDDDD:BB
> > +Date:		December, 2024
> > +Contact:	linux-pci@vger.kernel.org
> > +Description:
> > +		A PCI host bridge device parents a PCI bus device topology. PCI
> > +		controllers may also parent host bridges. The DDDDD:BB format
> > +		convey the PCI domain number and the bus number for root ports
> > +		of the host bridge.
> 
> "Root ports" doesn't seem quite right here; BB is the root bus number,
> and makes sense even for conventional PCI.
> 
> I know IDE etc is PCIe-specific, but I think saying "the PCI domain
> number and root bus number of the host bridge" would be more accurate
> since there can be things other than Root Ports on the root bus, e.g.,
> conventional PCI devices, RCiEPs, RCECs, etc.

Makes sense, adopted your wording.

> 
> Typical formatting of domain is %04x.

Oh, whoops, fixed that by doing:

    s/DDDDD/DDDD/

...throughout the set.

> 
> > +What:		pciDDDDD:BB/streamN:DDDDD:BB:DD:F
> > +Date:		December, 2024
> > +Contact:	linux-pci@vger.kernel.org
> > +Description:
> > +		(RO) When a host-bridge has established a secure connection,
> > +		typically PCIe IDE, between a host-bridge an endpoint, this
> > +		symlink appears. The primary function is to account how many
> > +		streams can be returned to the available secure streams pool by
> > +		invoking the tsm/disconnect flow. The link points to the
> > +		endpoint PCI device at domain:DDDDD bus:BB device:DD function:F.
> 
> s/host-bridge an endpoint/host bridge and an endpoint/

Fixed.

> > + * Retrieve stream association parameters for devid (RID) and resources
> > + * (device address ranges)
> 
> This and other exported functions probably should have kernel-doc.
> Document only the implemented parts.
> 
> > +void pci_ide_stream_probe(struct pci_dev *pdev, struct pci_ide *ide)
> 
> > +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide,
> > +			     enum pci_ide_flags flags)
> > +{
> > +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> > +	struct pci_dev *rp = pcie_find_root_port(pdev);
> > +
> > +	__pci_ide_stream_teardown(pdev, ide);
> > +	if (flags & PCI_IDE_SETUP_ROOT_PORT)
> > +		__pci_ide_stream_teardown(rp, ide);
> 
> Looks like this relies on the caller to supply the same flags as they
> previously supplied to pci_ide_stream_setup()?  Could/should we
> remember the flags to remove the possibility of leaking the RP setup
> or trying to teardown RP setup that wasn't done?

I addressed this by decomposing this function into a "register" step and
a "setup" step according to Alexey's feedback. That removes the
responsibility of the core to remember the flags and puts the onus on
the leaf driver to remember to program the RP if its TSM implementation
requires that (some do not).

In other words the leak risk is contained to pairing "stream register"
with "stream unregister" calls, and that is independent of this now
deleted PCI_IDE_SETUP_ROOT_PORT detail.

> > +++ b/include/linux/pci.h
> > @@ -601,6 +601,10 @@ struct pci_host_bridge {
> >  	int		domain_nr;
> >  	struct list_head windows;	/* resource_entry */
> >  	struct list_head dma_ranges;	/* dma ranges resource list */
> > +#ifdef CONFIG_PCI_IDE			/* track IDE stream id allocation */
> > +	DECLARE_BITMAP(ide_stream_ids, PCI_IDE_SEL_CTL_ID_MAX + 1);
> > +	struct resource ide_stream_res; /* track ide stream address association */
> 
> Seems like overkill to repeat this.  Probably remove the comment on
> the #ifdef and s/ide/IDE/ here.

Done.


Return-Path: <linux-pci+bounces-9088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF288912DCF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 21:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F52B1F22C30
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 19:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0926D179949;
	Fri, 21 Jun 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCuKbGLZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59F4644C;
	Fri, 21 Jun 2024 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718997841; cv=fail; b=r6ubV0hhKRKfm1Or6PrUpqjppAmiePWwKYDCwp60IfRbGhvwG8CG5zEoU4DhT3fHaqGGLVoSLxD1DssZdavloSwlflxA7ZY3KooZF2mn02XJAcbvfcGV9dgqP6nRDlQcOfSGOaah+hWJrO+AVIEmC4XajLRPr+0+WrbxDklXSLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718997841; c=relaxed/simple;
	bh=OogoxmR90tGvWAPnLqaHRigOfUriTSYM4Hdvslb6pwY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VEk41EWebiFw1LTQ//MAUVvEf92kEq6sSAn3uxP9Y3evFWCYLnPqAw9LtBcfB+dIzCiQjNqYkMwkTIhyul1G4ufSNBL6/lpWji7NDmo+4T+37EoYOBckrKzkHgUsv+Js5dzSI3PMsvQH+Y7XNZwMKOJHHLAqJhXsFe6MqnPYOLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCuKbGLZ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718997840; x=1750533840;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OogoxmR90tGvWAPnLqaHRigOfUriTSYM4Hdvslb6pwY=;
  b=dCuKbGLZ6DwslgLgIl1PhvyPBqxTrGkXxGrVxgEahgwiqapOwKEMRhzb
   NqJk+TLtYGCEP69wAwirCiE1cIgWZABoVrLPRMoZdN/gb2NtWX5sv8PHR
   ga6wk0OD9SFjTWaRQp1C5PCkmbcuCqIkGo1qaC4kaM+jab64HVtUbApUw
   vHPlWgpfSifpj3Je2zqCtfGheY16rDtO91mRhF+GBJQghsI5e2Yqe5umS
   hcPQwlXTVijl4F0JDEXyYzPhlpGYoW0L8YDFFQ+JJrtO+tubvsEurrq1a
   kQbNt6R+Eaanztu/qOVbKlbdir0KzvS3+z0wOppR8pHbS8mqOggny0gYF
   A==;
X-CSE-ConnectionGUID: OS1QWzB4ThagyzW+hYNOdQ==
X-CSE-MsgGUID: ePnkNEOkQbyalH1ttG6U7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="19824713"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="19824713"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 12:24:00 -0700
X-CSE-ConnectionGUID: biON4d/sRnKBnl8XwR33JA==
X-CSE-MsgGUID: fD4we5ekS2mc+qx1GmVsxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="42647253"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 12:23:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 12:23:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 12:23:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 12:23:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSMfyrh2DoyUTaaMyN8zAczR+mxa9j+XZ+NFgCPTizD+VicpL+ibhREnrvMdnK4E0Rz1R9WWOmi1yN3lxOZl8SaZZOCxURRC8eRG+melFN/6CafR+DPFAXxbJqIlXtTo4iDmNndXWbj3G3H9LFL5mOZBIt8RAJeTg6raic5W8WAe7Fbq61Gvdf3zptU7U9N7arJNrcNVtjZ3WGquObyt56rD47169xD6YvAmW/46GDUwOQzwiwJhdSDeCafL85taGfy9ef1xXdt2POujpk8OCY4gdCUbtkeUwoixojSuw6SD9ksPpTJ/6DS1iqp+xO/4e/N6rswabKZHam4f0m1MZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBFJdsQwCEeDXigv+iuyoACVbtd+AAg5UK2rAt3YyeI=;
 b=f/QyykMbbzAPBiT8inF3WeeMNsNoTdcQSrpLH08sQCUTG/abKo8O4stSAkTpMElFq/jpGOaFgNI/SOfPMSIhXrfcZOn5A7fHjQtqH1KeEoNroqcScqWv1axWKRJepDHMWm/76OoO906VFrrSUxdaQQDXUQwzaPcZLlHJG93yV+SqLtzSw0tMT2lfodY7ldF8EzJtdba/Qjt4vZoiVvbPFggMNhCLeKjuFwFEq7FXPuy8Q48EGd7wBOnkICx+dAMsmWR+QmqLxsScT+EPXA/38vCjh+Vt1pHgJ+9vHZ8ZO/o4pji7EKvLHgYVxtrgyxfCkJmKcjV0xAHASd6R1HstrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5097.namprd11.prod.outlook.com (2603:10b6:806:11a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 19:23:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Fri, 21 Jun 2024
 19:23:55 +0000
Date: Fri, 21 Jun 2024 12:23:52 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 2/9] PCI/AER: Call AER CE handler before clearing AER
 CE status register
Message-ID: <6675d34860e5e_57ac294a2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-3-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240617200411.1426554-3-terry.bowman@amd.com>
X-ClientProxiedBy: MW4P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: 72085719-c7ef-4dce-5169-08dc9227b11c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013|7416011|921017;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GJWplHnh/mM0Xj8al4mIbiiKTXYeiB143QKCj2FT4n4ZOJZfgxBTlQWcfPwx?=
 =?us-ascii?Q?qP5mpT9XpSEvmlbYUzZwDnhsxlGBG7noeWDC1IluJZYDJMtmYyNQc/p3BPbb?=
 =?us-ascii?Q?rEHt9c8vuEqk5Wi5ilCwzbzbTpNfNv69CjuYCy5qPlDwFwgDbeLdpVtQdPZX?=
 =?us-ascii?Q?3y8orln+RkXXGqO6AVImL3zsv/IPyo1mbZd6HftjR2S8zTUBLGSaHJahVqEc?=
 =?us-ascii?Q?ts7cJ4xJ9Jg5F8TfR6mzTxnye5LXeJ2YuRJTOaTvS+43AcEZPgOuxIMKneq1?=
 =?us-ascii?Q?Ezbdk9CfPVS7/Wm3/ggWTmomLUjZVNQ2scq7z4ALbRx7V34QioRapLcMx2qV?=
 =?us-ascii?Q?8aNYtXR74DHz15tZu5+q8xOI4jXeEHdCD7GiULycYdicWVxWsGsUvdCU7aC4?=
 =?us-ascii?Q?jNb0IdrMrgQyB3J+MuDZICfU/ADeIBV8kwKtUM3bWJrifarnukUE90XwQwpP?=
 =?us-ascii?Q?AbwS1w+4aFwgDpM1KuoE/PGiKiF9qcctS/+rHsiiCgC+l8T73o379SAWza+r?=
 =?us-ascii?Q?9DXLONOJX8fbUmC/8U4ZOruR7Cixn8eOU4ognyZ0tWMPNs2Qld7RQYf8O001?=
 =?us-ascii?Q?zNk5Z7BU5pZKy4b9a9zjBhjiL7hPQljK1aFDhsdQIz1ur7CpjqSW0lFKu+RJ?=
 =?us-ascii?Q?QwjGM+xFUnEdQCTRSvnVGByIqW9lgEeLR8Qj9Z8+tHUoyFqqggBzgEMwLgRO?=
 =?us-ascii?Q?un3rM7owCbmAMviGbk6jlZu2sjOLzKjRGIXvx6+ig58By3bmnMpL4NdMOFp7?=
 =?us-ascii?Q?kmWIKxAktIlFbKDF2+HYsmpiOvZsxLJqchw/cwKo/8E0gwo89pX2JYyYdvK4?=
 =?us-ascii?Q?5c8jrBH6jAsZ+ghXxsDUgMFjlmoIXZ+hkg5leO9k6c5XAeGHuVQ4vYJR2ifo?=
 =?us-ascii?Q?15dyhwH7WMjDb6K2WyFw0+bUQaNFvOieEm/Elf3NWsCsm02+GomohyAgEpEY?=
 =?us-ascii?Q?re01RhHM1KTGlVXpn7cyzFaVa9VgGSJRx4lTqrh8GlUdGZRqgBms7rhusJUB?=
 =?us-ascii?Q?zyLzq+ig4G3tx8PAQGBDWlqT7Ab2idsQ+NeybHh3gsIGgaogx7DATokyr44G?=
 =?us-ascii?Q?IPXtITr4GvNbiSAH7o91GuuS59KlMSYezz6zxx9K3KULUpDpoOABy3wdsjWr?=
 =?us-ascii?Q?RsvKdSY2ag1hK4Wx1cXsKWj2P12mXXIeG/V2mRh7eFU7HWMfCLV9aKeiH+2I?=
 =?us-ascii?Q?5nhCIEpfxnlgFtEAe+hUYMqIIn0B0imGqhGhuMiXArWa2h5WkjpQPVWRbWTZ?=
 =?us-ascii?Q?jK3saUlDH/H91z3OeaoLu0Kc9dR5QGx/VyemAwg5t6gTJaA84kU/F16OkdmO?=
 =?us-ascii?Q?ymorQmPPGc5E38V8PQAM4ycvXQTfo4Mtf+P7vbAWRKJcycXfhs19FbFNvizF?=
 =?us-ascii?Q?qZKoucU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(7416011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BPgBhAb11/HIf9GW+2TFsuKqRXFkesCE5Xv/220RQRd2OssLAVJ0aXLrAG4f?=
 =?us-ascii?Q?DHLQxeXs/W+ml9blE2lJYBjIXJOfpcwUu+1MAKAUc16ZFj3ozhNrLRg/kVtO?=
 =?us-ascii?Q?XoAVYBFgrdVEzatcWn09yw9RBQFFoVxbYef4Kl8I9wXAiVggGGYjbWRRwiuM?=
 =?us-ascii?Q?8Ce4NLG4PtVwrF4CByemIbMrsxyZ5WsClhJ5f/NBKlhH/EFcKvjmlThCp9Se?=
 =?us-ascii?Q?1Gdbeakyj177XxjMBHjSZB+YOQnBqbuoAp0GKnkJt2UfMdEIZrs0lFwfqGvN?=
 =?us-ascii?Q?c1DjWywsss/RN8YrwsUfV5csUTgEyZ/iCEWtudTvkeKpvAM0RCYBU3C1YSx7?=
 =?us-ascii?Q?zJOk92QQI39OJwbTOkf3nHmpdZPcPlqeSwk82gjnQaiaBF7OEr9rq04TStnm?=
 =?us-ascii?Q?eZeg8XKHuKBy53k8vCWcBhtUe7cGhlr0cxQH2yj3glgZKpOIXnQgfsZ9c0KP?=
 =?us-ascii?Q?DXK89RWAqBD8iUap8WamrUWBlJmdC4TF0C8T+cD2p9T4IEwYPfwYsChQ4nrk?=
 =?us-ascii?Q?Afv5QEX/0Yi0cyhYLzDdelKnSIYtDkIEY7ySCWRC02fMqadCfU/eJSoC/jUx?=
 =?us-ascii?Q?7PmhykxDO/yFS/+G3MuLch+bPtwIyrHBXN3uLNhX/y8FwoSuvEJixLo5jRKg?=
 =?us-ascii?Q?5iLkHwVgycMa65I8LEhwvgdwVxUn1l3H5dqGLzQdad5J9//q4/mckxFqPBIz?=
 =?us-ascii?Q?mDH12y1xnSmD9d6hBqlEO5UgE/OkHlAluAHnTn5bRjlLngfMARUyp4Ly2ewu?=
 =?us-ascii?Q?cva5duHkg4Lss4PVoVDM98Da2B5QHKsyGdH6WLy5LBIVuyhaiy+5mLu736XS?=
 =?us-ascii?Q?sXCVtmImmKCph74ZfC8PYcPcYRQPQQnQ/AmSWkiW+b0qtVkuzk4XLojk4vdy?=
 =?us-ascii?Q?b9rum5gdyObRt1LtC6cy5V3xfj2z4sKhM7osJcF0xT9YTI5sBRrRA50ElXbO?=
 =?us-ascii?Q?J1ihGzGL5MuOJMzEVA9q1xSWYwHU3qNS6Xny6PaKuFww8mgr72coo5CgU6YU?=
 =?us-ascii?Q?wPkG3chPQnogJ2xLN0P/yGLfCfEkjQXx9JrpNZgjeyws0vXHjnP/wrWbheCs?=
 =?us-ascii?Q?QyqUyD5uU4Z+JjlEMo3M5qld0yGQbv9kh8GB8s0cFAho4dI66IsHD3qTr0b5?=
 =?us-ascii?Q?4OnpXfY93jiMIYLHBgs1z8ah5VqhHw9CNtW4QZuajopFG61kogghH9Pm2+XM?=
 =?us-ascii?Q?ysnilWZTAhmg0uCMaboZkZRu1RIpoCbLT9Z1LwKL/oY0y7kGtqvTqHFnCLmn?=
 =?us-ascii?Q?RsWRIo12Q7HgrLRRYwLlqSE5mSgz7/LCrZ0jKzE+7u+3HZsxvre/pEzdm2Em?=
 =?us-ascii?Q?1rDWTC6Q1RMaiJx720Ok73uSbPlDxMyGojMO8L/N0b0y2KsZlu0fNf7oK4Vz?=
 =?us-ascii?Q?xgSNvB73AG+2695lxF58xoXP16shxFHUMByf7qkzIx9MTGfLz8xdOdK7XIHN?=
 =?us-ascii?Q?yZR4JYgvHITRObepAzX80qTN1GreFBdlHe1PmQ1Yi8ys+N6azrcEKXhMjPbJ?=
 =?us-ascii?Q?UtfX8v2gbgmUbfv6rZLLNx0zay7mqPWZ+sP+upGjTuQfqy0oAZvvQdkjIuNa?=
 =?us-ascii?Q?eyXaEEzX9MP2g8keEG4iXk+VpWPDqqX0xDQs7O8JlcJPnoA9cRr4rFw8oPB5?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72085719-c7ef-4dce-5169-08dc9227b11c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 19:23:55.4027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWY9k/5UTdszc18iFTGejiLQijrRxxk0gMBxMTqRtGjDWp5HZiKw11OSABSDMa89UqmY9RoaYZ10F+903g2vG74dQVSHXHR2tJnM4hPMULg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5097
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The AER service driver clears the AER correctable error (CE) status before
> calling the correctable error handler. This results in the error's status
> not correctly reflected if read from the CE handler.
> 
> The AER CE status is needed by the portdrv's CE handler. The portdrv's
> CE handler is intended to only call the registered notifier callbacks
> if the CE error status has correctable internal error (CIE) set.

Is this a fix or a prep patch? It reads like a "fix", but there are no
notifiers to worry about today.

> This is not a problem for AER uncorrrectbale errors (UCE). The UCE status
> is still present in the AER capability and available for reading, if
> needed, when the UCE handler is called.
> 
> Change the order of clearing the CE status and calling the CE handler.
> Make it to call the CE handler first and then clear the CE status
> after returning.

With the changelog clarified to indicate whether this has any impact on
current behavior you can add:

Acked-by: Dan Williams <dan.j.williams@intel.com>


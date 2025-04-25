Return-Path: <linux-pci+bounces-26793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CDDA9D63F
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 01:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D4D9E124A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 23:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5B92309B2;
	Fri, 25 Apr 2025 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etsiG4xI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C9F226183
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 23:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745623897; cv=fail; b=LXFTlE0dQihYOWhjtbE3PrbMhXEbq5neT0NW84y5n0dqENRL71byhpZKj8JbJzcr0b3sqUfG0G/UvpRchmBrYNIDNyC/NIbesO4EFBggjcPQBM8ChmhzvfeKNpaBPiSqVhzQJWAx6/5NVK0EFyR1fwr+AAjp5mpziPHqGdqLLME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745623897; c=relaxed/simple;
	bh=mI5YvkEwX78JE9d++A+BkWYkmBTvxgyWl/0qx//Tfvw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZuzsoMgOvYPlM2aCvaGfO4DmeqLOtwm8HgBJlXq56GGphUmvXwaKn3qXyZ8u9LmTEeEhxSC1qoj5pR+8D/IdfnHbrRc1gM97ROXc0dhcKIeOYqZ+SMu8akHAwT1vL+OOsxV1JmRej1f2J2gGcnHfiyXGnNLaEOBU8KZThjFIORc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etsiG4xI; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745623896; x=1777159896;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mI5YvkEwX78JE9d++A+BkWYkmBTvxgyWl/0qx//Tfvw=;
  b=etsiG4xIpQQUFIcutpc47Tab2ff++5oVOrCTVvM4aBt3pBqBS6YQ2UM6
   T5QFkI/wT7CL//uomiPBOF+RSyxlFci/a4Mx7bfzP0DCc6bfIA9w/3NHo
   KGouVL2N/MznfoZYRPNLu1PWLWXc915kLrNojlKearqYLJs8a3A6CFJFP
   jz3LxuYpRc6gJXSKODBAyxgEqlPXX6VXacxcc37lT8PQn1Jg1hOSsntuc
   1QlEkDiAzdyQdm/8uIlD1M1TxWDEICq51bSWHRUbRrQrD5grGT0MPkoIH
   nktM3kc5VXkaae1YcKHdBGoiOJTOTNTY0LNjfEgFnKjVFUp6VZuyvCuGV
   Q==;
X-CSE-ConnectionGUID: 5Pyxm9thR1iMXYIV4ncTEw==
X-CSE-MsgGUID: ippC8lMZQUSFpqhcIvIMvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="49947209"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="49947209"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 16:31:35 -0700
X-CSE-ConnectionGUID: KHds5v3+SuWAtdd/L11kyQ==
X-CSE-MsgGUID: alViHYawSv2hfbo1BC8gTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="133546696"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 16:31:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 25 Apr 2025 16:31:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 25 Apr 2025 16:31:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 25 Apr 2025 16:31:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFJ4XPP3FdjYc2zPn2OrKLjrd4Mdrg0+Vg7IXrLr8580br1tPplOg0ers12xyVCDSiYtO+g+yp8CoO7hcrl3ILorlO3jL3aIfB621k5kbEBgEE5mJZZB5esajTZ8oJphmycWaWtXmsr78L8cbBdSo/oc59HgsAIrvIfoRCEjVE5z0gIpVp55xQLaHH1ZJ/5MjtY5mBwzbCGj2sBdihkhulFXc6SBXykvoayvdpA8hs/CrVKEXEypFjmpOBsvmzhPr24hJ8EQvBAnqGch1zMDh3B46CNMbNCSUsztGllmBDS2xtqkeBnzFEhtqn3RB84F1uekye0TUZierdljtqoP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBsOzO7LcGZ8nD4ghzLj1cXYqrrfhWP8XgX3/JtPiVs=;
 b=GfcCo9sKkRcO+HcGkAYwfQnRUOJTpduaNaTwzg0d7psMasUzNuofAW/T9mx4mVl/72LO/rZ6f3ckZfHfgJ49mFfK66KYN7HC6qPYuC6kXE07j5qHJmPQRm44yXS7RUgl3drxjrlRLcuRXwc/YZSurDh0DTbhz2svQ2oFhVMwyJDjSZBwSH3dD8mGHcPykoFaeCuBpUtb/B+Xy1+kYbVbBEDEGOKBGDBcoYKvnGuo5Q0zDsREgoofuJJ8gLxK+LfgHBoZmM4Vi7ZWGpKEncu55v8WYw1U+yWR30hXZ2eyUUVON8A7soTqfnp8uZ/QDBx6SdpFnF41JUI+uOhO+DLvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 23:31:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Fri, 25 Apr 2025
 23:31:31 +0000
Date: Fri, 25 Apr 2025 16:31:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>, <gregkh@linuxfoundation.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <680c1b50443bf_1d5229484@dwillia2-xfh.jf.intel.com.notmuch>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107250147.1288555.16948528371146013276.stgit@dwillia2-xfh.jf.intel.com>
 <yq5a7c3edot5.fsf@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yq5a7c3edot5.fsf@kernel.org>
X-ClientProxiedBy: MW4PR04CA0387.namprd04.prod.outlook.com
 (2603:10b6:303:81::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 76afb5dd-1dba-4828-b3c0-08dd84514f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MvoRN/LJ0NLnbuMTDP8lCgKaqLFK5TStENk0fYs7ZAcSkoM1Id9gniZ3Ufv1?=
 =?us-ascii?Q?kR8yP6U7zr/CaL4vMo7mHuKQAQdP00Wv4NHJhoJk20F9Tjxxzffs+OdYbPl7?=
 =?us-ascii?Q?26D7kx/hJIxQ+gr+oiQ/i5FqxNWWZnAn7qRvPZdjBKprdhurK0Bc21cdiNF1?=
 =?us-ascii?Q?8gtAEL99q7FmTUjMlnJNx5n7wPUIW0EV1SfoqPMs8jkLL7GAcavHG3xTZbF/?=
 =?us-ascii?Q?F7f5W/RhJ/GqhsNOfd0RYEbEf3rQj+ABksE3Mk7iRWq+8y2DOg3L8WoHNpG8?=
 =?us-ascii?Q?kaSmr7fjIKHz61tzr//Bur1ztKF6zfD4jBYl6lCgXFjyNadl5NAfkOOOFhgp?=
 =?us-ascii?Q?oqf9ii1A7W4wOdbIn/F2pmXnWT6jQ5uP+DVNqndsc4ugQJi1oDaEXXjinXkd?=
 =?us-ascii?Q?R/ayeOUCNn5vYTqUn8qB3HrfcVGanZZmhMck/20oDigyPJGUSjARqn//t9n1?=
 =?us-ascii?Q?OukvD4QfL0tMxMvD/2bAi8yjVUVMAwaxYAsf6dJlQEul3ulVw2KNeI69jasU?=
 =?us-ascii?Q?coYdjjV0WIcmKa5AzqI03wfN0ytJIIZha9W6L0tXJW7nHeai4vCougfO/v57?=
 =?us-ascii?Q?/4JxCIcgU2Z39KPXTBoz7nbKyumyzhkcFRCpEB18Op7+TlLqAUYyrtIlzZQE?=
 =?us-ascii?Q?vRF2xoloZEmSNWVNGRNMQFwxpqOOsqBJOTqkZKGhSrgckRgl3p8pGTM+oyPM?=
 =?us-ascii?Q?RViDj7thi+OHs5OSeoyQcHoDn2UVRsk8F8Jbn0x5U5j5iutgcp/MjYLMAqmz?=
 =?us-ascii?Q?SdKQJuAECkhxVirVvWBd6NpiYmKqmFf98yRXbzEkvDeRo1kM9pcyASGYCFlN?=
 =?us-ascii?Q?wN1Vg/L2Wig99rxzT9s6PhqPyDPQ6NKhVMAQz3J2BjL4cvveAnvDywVBIGGD?=
 =?us-ascii?Q?ea8dQirxggiksR6d8IT0Hl8jbeqjhKxxnCwzKKegtyahx9eAqcbLP0q5p7PV?=
 =?us-ascii?Q?llqC4E3v+y5DRUQSQx2jLpAeXtUi/4DKGxWad77R0attyEYgVBJPVrMYAWz9?=
 =?us-ascii?Q?wAS6eqDZDooxPwIFSzQ250hYMRFcLoA7DyAXYybu7nk+PwGq62oU7yI54y/k?=
 =?us-ascii?Q?Wdw30KuMPTx9Z1Rz+doxys1Jto3YFlPh4IOsHSMLtvZ4snBssaQGCapckqMj?=
 =?us-ascii?Q?gd+TvsF/e9mVe9gP/ZCXWcsMGJVkZhzVhY9W4VfAC71NvnN00Nf2qMk485eD?=
 =?us-ascii?Q?gu+EW31pUuKXvmW3YLxE3wAcOlGiTOK+nMy27aFLbmgXu11W461L15O64/15?=
 =?us-ascii?Q?WmbH0hcrwZE3PdT9X89uv/cDOMgmb9E76Xk+zUyH70KY8EtKasG70smA8iJj?=
 =?us-ascii?Q?/2Evp0b7HXkD4NlLTIdMyRD3cNNpEDy+Kcl61g73hf1q/vOzlf6FZm2FYSUf?=
 =?us-ascii?Q?82f1tG4/kJqRenkud5C6rg9kNXZ6ibJS1uEVTfZQ98QZAi/J2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?izfd4cinuBXEF44s0MXcCP6l8pXLu6Bta4LfmHVtke7OvkNApQczhowpHl5e?=
 =?us-ascii?Q?hUhR9N9qdLrAogsEKNzD77WNiVAYSZHCDIn6xjo51Do8hFcT7220031KCusq?=
 =?us-ascii?Q?jJuFOLTscQrp0sTBoWD07gOUX/sklZlfRokz4O3De4KONyJGFR1Q5+tsQApa?=
 =?us-ascii?Q?tLsHCep+y9GFFfiVW3Uss0el7BNj3lx+hi8JhEBf81lQPPixHwoF+m23G0qY?=
 =?us-ascii?Q?FNfL7p19vhMTShhLQ76Cw9gf4IWnNBR/IVJW8uORo59/9+hBU7TCK/w/L0kX?=
 =?us-ascii?Q?7ZHg73kCT5N654mAwLPRzl92jdUORLjmHCdxBrl3NPRVdYldRAr7evtCRgmO?=
 =?us-ascii?Q?1GmXzTtgUup9aNHrZ/LYm5VcWmHrEAc4gb2RMJDV2BZg4/cwZ+hZBf5lglVW?=
 =?us-ascii?Q?rMYFbk6byLZTMmBuQ8PIA8jKj/w3eT/kvD//IVYyVzofYjd+FJ22zI8DndhB?=
 =?us-ascii?Q?pPL/ALsBVe13ksiY2SQ2V3hjrHpq1kl0IQmYudgjcVCW6bws3zYPucU1d6pS?=
 =?us-ascii?Q?61Er1Bx7s9q1jdmziCg185DhiE+TbbSGilrzG/TVWHyuGSvmSNTKpiv+lBk/?=
 =?us-ascii?Q?VT5xX0tMiBGID0aW20um9PO0SaufvLmh/2KvZV+O20S0Ix+1TzAP9ijIubPZ?=
 =?us-ascii?Q?1PGzVCgpwN7qJXG/mhzjTkhYyLcJg5pC0GSeAyVFyVCs5bB1D83g/+eSbWFb?=
 =?us-ascii?Q?rfxX5Cagg/WUGXaaD4W7e2r67B/Q6/kkyiljS+uk7qN30TAxg7lb8y4LT1bu?=
 =?us-ascii?Q?1l/ubDk9DGNajdcUiWsvpVUGyDUE04veRIgg5sm8X+GalXVs9Rd9VeBK+EZh?=
 =?us-ascii?Q?XhhcJrORMyQnCgtvgNSRU5b3+YQq0H+HY8+1vBf7IQATWrp6bLX3hiop1edf?=
 =?us-ascii?Q?9XS3RuAYi811qPTRtxjpOsRNo6snZ/zmftogl09SGjvdtzwHajeBX/+yWsPP?=
 =?us-ascii?Q?w1Vh3O2Lq3ZBEV4JBQwtowpRyxp76lBOcTlztJ6WnbbbGNQ3XnWDAsz2aI23?=
 =?us-ascii?Q?HmL7enVjpMtSaJSVlGcJ+zn0Dkz2qyjJ089UvNgcQiTDKirCtRcuJTJGiimK?=
 =?us-ascii?Q?0oSSPRGKhpYDfu7P87opQF0FwAyuwgrFfFRTtykSXvJ6qHR0wCH1bjuQu51Q?=
 =?us-ascii?Q?Yba+KBrqDwaS3JOUug6YYAFjv4wTGuKCAymzmDX+h5zr1a6pwxNNTWzmdhux?=
 =?us-ascii?Q?pEantP1xKAGqqADpOOVC6g7GBfE9zLqERRrzQ8A9UIAZHavocJVgTq2dm/wS?=
 =?us-ascii?Q?S3xdNmRcnljSM+zo14+ynfaEx1k5oy/NJl/pgfBxjEdiieTnE7v2N4Zu0YQ/?=
 =?us-ascii?Q?l8S/teCyoyz+g/MZpdRcXFe3BdhHTeRy448u8/Nfr1N0LFERnF396Jha4aBz?=
 =?us-ascii?Q?7yICNnEYZlHoIAQe8egiO0DqAA7dJuJg4nITnyU8SYiN3kPA+W3Ohn6VBlvD?=
 =?us-ascii?Q?GgAIWC6hp+TbUOfqALxTfEipCOm2oiKyraHctgDCEmZoh1Y+Yc3QNTEBG/0m?=
 =?us-ascii?Q?PXPT1DpngOxLffHK1o50RrI34I/iQfmdtkyZH4tHUu3PSOwlAZ8OBD7Y3ToR?=
 =?us-ascii?Q?tBe6Cz1FQSi2vSe1JwxNHBa/YeEH4Lfk1o35OaZB+4YpG62XwUvGDGTorip6?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76afb5dd-1dba-4828-b3c0-08dd84514f17
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 23:31:31.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tei17I+fmpCRhzGwcgVFBIvbp1htTtsaLn/8voYnOePGKcCHYJZEKNCLmNKfbv0ISe4vPqQRFn3EmTv6xsse6mxJFh+0JKp50V64AWzq6f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6895
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > There are two components to establishing an encrypted link, provisioning
> > the stream in Partner Port config-space, and programming the keys into
> > the link layer via IDE_KM (IDE Key Management). This new library,
> > drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
> > driver, is saved for later.
> >
> ....
> 
> > +/**
> > + * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
> > + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> > + * @ide: registered IDE settings descriptor
> > + *
> > + * When @pdev is a PCI_EXP_TYPE_ENDPOINT then the PCI_IDE_EP partner
> > + * settings are written to @pdev's Selective IDE Stream register block,
> > + * and when @pdev is a PCI_EXP_TYPE_ROOT_PORT, the PCI_IDE_RP settings
> > + * are selected.
> > + */
> > +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> > +{
> > +	struct pci_ide_partner *settings = to_settings(pdev, ide);
> > +	int pos;
> > +	u32 val;
> > +
> > +	if (!settings)
> > +		return;
> > +
> > +	pos = sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
> > +			     pdev->nr_ide_mem);
> >
> 
> This and the similar offset caclulation below needs the EXT_CAP_ID_IDE offset 

*facepalm*

So it seems no one is trying to build on top of this framework yet.

> 
> modified   drivers/pci/ide.c
> @@ -10,11 +10,13 @@
>  #include <linux/bitfield.h>
>  #include "pci.h"
>  
> -static int sel_ide_offset(int nr_link_ide, int stream_index, int nr_ide_mem)
> +static int sel_ide_offset(struct pci_dev *pdev, int nr_link_ide,
> +			  int stream_index, int nr_ide_mem)
>  {
>  	int offset;
>  
> -	offset = PCI_IDE_LINK_STREAM_0 + nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;
> +	offset = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> +	offset += PCI_IDE_LINK_STREAM_0 + nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;

Will fix this up to the following since ide_cap is already cached:

static int __sel_ide_offset(int ide_cap, int nr_link_ide, int stream_index,
                            int nr_ide_mem)
{
        int offset;
        
        offset = ide_cap + PCI_IDE_LINK_STREAM_0 + nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;
        
        /*
         * Assume a constant number of address association resources per
         * stream index
         */
        if (stream_index > 0)
                offset += stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
        return offset;
}

static int sel_ide_offset(struct pci_dev *pdev,
                          struct pci_ide_partner *settings)
{
        return sel_ide_offset(pdev->ide_cap, pdev->nr_link_ide,
                              settings->stream_index, pdev->nr_ide_mem);
}

[..]
> > +/**
> > + * pci_ide_stream_enable() - after setup, enable the stream
> > + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> > + * @ide: registered and setup IDE settings descriptor
> > + *
> > + * Activate the stream by writing to the Selective IDE Stream Control Register.
> > + */
> > +void pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
> > +{
> > +	struct pci_ide_partner *settings = to_settings(pdev, ide);
> > +	int pos;
> > +	u32 val;
> > +
> > +	if (!settings)
> > +		return;
> > +
> > +	pos = sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
> > +			     pdev->nr_ide_mem);
> > +
> >
> > +	val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
> > +	      FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |
> > +	      FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
> > +	      FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
> >
> 
> Does enabling pdev->ide_tee_limit here will prevent a device from operating 
> as expected before we get to TDISP RUN state? 

My expectation is that non-IDE TLPs can always be sent. I.e. a TDISP
device outside the RUN state should still be operational without needing
to send T=0 traffic over the IDE stream.


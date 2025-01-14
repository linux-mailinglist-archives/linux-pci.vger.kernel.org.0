Return-Path: <linux-pci+bounces-19784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9838A11467
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BB61889407
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 22:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041D22135A3;
	Tue, 14 Jan 2025 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foWLlWTm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35CC21146A;
	Tue, 14 Jan 2025 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895108; cv=fail; b=hkxORsKyGdon0gjB9V0fQoMfi3oUueKK7u1cKf5LZ27AkNjRCoblTAxoVwYdlo3RTa0ZTX1bvf+f50o2d82BcJ1EoA6Lb+kSkc9xycUP3zCWgC6/suLXKnaEBLI6P9AE2pcSoEoS/Q6M7/56TtwZ7XLvgM2Kg1cC1jQz3eFZfEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895108; c=relaxed/simple;
	bh=D7Y4gfioHg9ZoZaDz3btvuBhbkX9VXTGN/cyPfsM5EY=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RxS+oZ6d32MdQ7Vqx2zRn0/gZToU33Dc2zpAOqKxoGsoc9xVBPKeBZRo206N0oL5WEnOEyrSGbrZklUMwtwacAebG6jEyPA5JP689fUnG0K5y9ZjuLB/TGDPOctuFmI/AVXZfqLfvDQ0F2TKLN+uxpnOZ7tJP6Ok+2GsMJNpWYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foWLlWTm; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736895107; x=1768431107;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=D7Y4gfioHg9ZoZaDz3btvuBhbkX9VXTGN/cyPfsM5EY=;
  b=foWLlWTmdOC/bK76WWi06WMGFm6UUSWW4IfK+jZmDd7q4gSWBFbpuc2i
   ppVHI76EfInU9DT+0rlMkUyUMjahZbBbHcfhCRhy7OjCvalDVS7+LZ2iw
   C7J3cIOQ+7S9Uyvn5xZhS+RLhpjBZQmwf60xY9ZgCz55jgCnOIHNr1ky5
   U7eQgtDDES4+ERasb1MTqz0P4YLKbH1lah8GlQF30r36t8xQY/S2LOeNs
   1Xau9AZ4kIHOrNF5oHpP9mNs6WMxEl2qjij67w1w2jErd4+BKLJReN60W
   zp8UtpjoJJOSeFQ7j6OpaZ7A1OiwAylB5F2kX/RnLP6bBv2enuDZYY3Us
   A==;
X-CSE-ConnectionGUID: vOpe0RV+Qz+4P2SdRr+ClQ==
X-CSE-MsgGUID: PU0IHYxqQfG0T6OlaVntxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37369950"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="37369950"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 14:51:33 -0800
X-CSE-ConnectionGUID: f9WQT8GASQeSWDiZNaKWow==
X-CSE-MsgGUID: GJ83+wRCQCKFG49h3VDt/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="109899961"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 14:51:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 14:51:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 14:51:31 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 14:51:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEt0tmxXLnbeMJIaeLhibUjh9u74rBfni1dgbUIiuij3d2LRpUEj/LZcxQVHJn6Gqad7CjfC6Bt06ipsoMztdKLbXryiWZhyFs8jXTnzOHlGiQ0EFT7gNnhbDdPn0U7GiJ/hNsbTBvpM2OqV43SMMsqezWsI/y6F7p8djTZecoApZ625NzvGJyObluAVjfpAcjHpDKV8X/J41AL7XevmgLXxBS/ShD6HFrkwb0WWkynZxLh+9JTVnzGIWeztKgpI7bgfOWB9MneQZgViuV3V6yp1zqUrFgAT4UNmKBhb2LRlBlvyuhkJM8eFcFPACV52S87FzU2O0+GzACc/v4terg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dozt7k4nsVFP9170jB6geNBcK2cIjqnVyqQRNzzvHVI=;
 b=wTXBlB7FnKEaLvsZOWssJoKFDs/fsrJ8ruW4rNWsf4arwhSObpVPWqTBNrYzDUKlcHNLLYm9QXZqChJaPMzXRGRUm3QyHOwo1hyp17wYIfWNmm9/5ZbyzOOdapYE58uPGTwasKuZPCEOT7kfQp4Z5oN1/GhefJPWliYS5jBykm8yXgSjKOh98xZwY3VmcZpev1DRSybI+6KpCD7QgHa90SK5Y0u01tYhlM28It1tGxEHB/EntISrhyKmcujk6xPa8r/qdG+uRofTNcrkdmmK05dymV0tRuFiSidgNjDJzQOEnfg1rtEAI2nu6T7G+24oE11QQ6NMmvRi5SqVg5r1ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB5822.namprd11.prod.outlook.com (2603:10b6:303:185::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 22:51:27 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Tue, 14 Jan 2025
 22:51:27 +0000
Date: Tue, 14 Jan 2025 16:51:21 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 13/16] cxl/pci: Add error handler for CXL PCIe Port
 RAS errors
Message-ID: <6786ea6964f3c_186d9b29424@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-14-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-14-terry.bowman@amd.com>
X-ClientProxiedBy: MW3PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:303:2a::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: ba708814-9121-43e7-8ad7-08dd34edfaa4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fdrww8lNmNwqPKBSEs1fIcajI6ELC+sUo8E5c00iWIyN9R8r86QxEZwQ88jr?=
 =?us-ascii?Q?cZZVhNylYrGn8S0xvF0UJZsHLRAL3SkmZW5FpEMD8Mx8i0imbvoR0TtShcDR?=
 =?us-ascii?Q?MW5JnNd/X66GtLoS9x49lMKVS1EEYMaJNwq1zUxjS63wgEoBGkW89owkYaiP?=
 =?us-ascii?Q?ICN5fnwsJM8YBhWRupQbz4xwwrMwyG2NNvEbVOrHNiCGqe6XNmRCZFI+X74G?=
 =?us-ascii?Q?mUUMky/hxIlj3i3DdFtRk71FbHc8ffEc22S/EeXLpwo8xjz2QhjmxTxji+nN?=
 =?us-ascii?Q?4ucWFB4BqNZ2srhp9STEpjYLHZk/mNJ8kXBr2BJ10MEMEr3Y/eWIwGUn49ES?=
 =?us-ascii?Q?a2PRoXhWPQumvX+tJEQvFpQ1BJLCnHuMSEujuK/PiCXCvhKFdhRGPLhQ/5mW?=
 =?us-ascii?Q?DNhUtQ2YWiAtk0EfH6aOoezUKqX7peVEfKyq48BCGJdemMSaGu4cdnVObaMY?=
 =?us-ascii?Q?qce54UYOTg5T2GeNv+hWq+PGJqrKdGNt1W+bHdecU+vYCEgAtcvJELpRTa1o?=
 =?us-ascii?Q?SpT00lD27c0+JNvUw8hkHSXlV9buPuNMm7tOaft5JKgYlGuJ4hAYAERdy66o?=
 =?us-ascii?Q?JtTDQ4q5cB6qQFUzpKTwhzPJ4+Pz7eOJzSDtq5A+P0UPt5r0uJ4HB5tIu9K8?=
 =?us-ascii?Q?SPsrFIHPgLs4KmDWms9YPGIz7oNn261oEWSJqNd/B7TWKFZDits9dfEkiAwI?=
 =?us-ascii?Q?nSB5G3vvq7sGuA7uiNYLgUEBOTHyLqaY6CD8EK4IvN7cgMvDpIAn3AABDPOl?=
 =?us-ascii?Q?WUXbaRaYX9OJehlA4NoBA+KDBpqnHNYefhlxPdZt6RGt73BTigvjlvyR6xxk?=
 =?us-ascii?Q?laTKkrFjlXQhWRznxeHU21o+FpF9Gr1h60sCKFb1SSg64S4/VraUtScNM02W?=
 =?us-ascii?Q?FaRQ0MDUBc8/B53cuHoVOo23pL/oxWdANXoXEauO3TKOSUM4q4A9GLi3Tvdc?=
 =?us-ascii?Q?YfDS4AFJUYus8nQEGWOsLhoRiYh8TwqUdE2lWwX8wOl5qwMgm8S8azB3aBnK?=
 =?us-ascii?Q?dY7fh3d8PIK0fEt/FpJgp6XbDv+bRZho4qEgX2fwXR4DqHCs+CVBoRa93X4G?=
 =?us-ascii?Q?9baYkmJm8YOUVXKvALboxe1c3p68ZnJrHcz18PUbRMZGe/K9OO3sSMPOMqHx?=
 =?us-ascii?Q?ZqVU4McUkU1qU3UDzpS/9ATOPRik+wLm7pYujOm3Fj9ix49N3n7Z7AKOYgYB?=
 =?us-ascii?Q?CddKHej9vQ61ygKjWFeHVVdyjz8hHLTZbv4Onv2pDBbgnwTQLjl0Y01/bv6v?=
 =?us-ascii?Q?Ohc6IwOBR/azT80qyRI+Q6xC68bb/ltyR/bgrkTc7l3QzWBLnN1jlKcPBE9r?=
 =?us-ascii?Q?1vW93CYJfPyeUQHaAZkM/7bKt7lryJC8mwMVasyj6zPif6hQBNMLYBxm2IUt?=
 =?us-ascii?Q?UDN7XUMsvRHcRs3KAdlzFBeR5rrCsvG+nIN6HpLRAHtxEmsX2Qt7aR9FGOfb?=
 =?us-ascii?Q?DPPQCbnzmbM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pZaY7Be2KFCFPzk25HH48mpO/5R5OuBiHHNwhFPlILJTy8ebTOZ7maRE+kNl?=
 =?us-ascii?Q?qgkzzG2xHZfbeKrUPuUB75MOzz60f5PZUJAiqmvyDzzc2/c2YlptXEkmOXBR?=
 =?us-ascii?Q?XuO5x/wLUmkPFcBtsXwwJpmA6ZyhfQCGHwEOFutbRPjI6PjKMmVstExGaP4B?=
 =?us-ascii?Q?gloFdvhDsfkh/EV0cnDXll0wbi/KhHVWugO4yFNRgY/fbLIFm/KCK5GlsE8p?=
 =?us-ascii?Q?xBeAVIU/jOwmAeUF709l5gVqBedNo1TmvCuL7epucgFXGxKhFmz1Gx7e1yUJ?=
 =?us-ascii?Q?f7pAe3jfg+yJQVmME/zSMdhR5/b54/8oaXgqGeoSxGgegmwuez01y2CodBGI?=
 =?us-ascii?Q?HzDXKSM33XooUF9A2SSzJ+ClHBerLvVvZDFmH9NqmPmmqh0Uqr5x7JA3yThe?=
 =?us-ascii?Q?ssyEKJK7Hwd77kxB/5hH/TsKqAFOqB+TGMOkrcKZqScS/NBVNn8d5JrvD0xC?=
 =?us-ascii?Q?gB8PS9E3ltHmsgk1DXFwRZ9HlPz7vysqc2PSvq/xGSVs6JItZ27p4KizzSh1?=
 =?us-ascii?Q?xmE5dytY4bPORVMW79z5tWD3c9aQGsebAByJhNO+g7QJ80Czf+BM8+CJSvBm?=
 =?us-ascii?Q?3bWn+xCSqMyUHuJyrjZN2ecMlBVC91TelElWAr7UZgavVoGZdOpHFpzxkss8?=
 =?us-ascii?Q?pAJ+FLLX4NkNQQs6iruNBtkXPcT0FoSAmfnzAJrlwraZywnfXaFeMaCD0bo5?=
 =?us-ascii?Q?/OKjLopdpaSWgsp/dMdLnqT/vuqLwrFd+RE+LZ5Lco9FXDD2E+9ew7xNyYZh?=
 =?us-ascii?Q?E9FGK7BupmQGTQ+u9Z8Gd+C/nOyeF040M18gQ6it9320RR1v3r9chjCkQg+x?=
 =?us-ascii?Q?7Uzl4y4KXnbbB7TRpk11w46k0CuW/nOpyBt3s77ZWLaQmToCZ3YxT1yCVT6w?=
 =?us-ascii?Q?L7ntBxBSe6jbtODN89ydn6l8X/aoxcsQeSsHoUhFunZR4gzFY9bfkoBzJHjD?=
 =?us-ascii?Q?XaplPx9lMBz+6K+9hVTcTyYIXBSbi4N7MDRnv1e5JmQB7lpA73hKT8lptZbf?=
 =?us-ascii?Q?xhAlg8o2ef873ARAIWxboTu6z8kxAZeD/itJGYqNqoBm+oK0L3LA/lMpHKSp?=
 =?us-ascii?Q?DYDWcAOv8BQD8inpkmi8nmlAA3IrJR4idrjaNPTH20DibkN8dIYqthwd1Ane?=
 =?us-ascii?Q?UIfj4GysZnjsFlyHEwU1dNStI8XqFgqk4sJfPSdCK46mMJhmYKWm2tshOZir?=
 =?us-ascii?Q?/r2i90FKC4Dxfg+3VuUAxvRnDfib23tmRhx4/3mqJjp13oZiwdV0f/XhhjhC?=
 =?us-ascii?Q?QvevvUxV7UuhTvbb8XgY88PudlovOSRodX5jjz98tA1jAIYScc3RXD4DP+Ry?=
 =?us-ascii?Q?+CvzupNXlb5ZBmTjQMEKQKtbCugHzA41CPUQaAAB1JJWlyoJLkViUg8OezkO?=
 =?us-ascii?Q?WeCS6J8E/ClVjgMbTtzgMqEGoV1KfIv46hGitjcnGKLUNY0APN12Yj5LHZZf?=
 =?us-ascii?Q?3vNAN5hwc4Tzjmancd6pQww1SszQZJYuEc5RZcNx44B9od3+A5p8mkqvA00J?=
 =?us-ascii?Q?LxhSr1ITZUgGc+A0eZENGdRAjizVHnKZvLWOiRD2yJpxct3CBWdaqVzJUOG5?=
 =?us-ascii?Q?dYeXr/e2nUbfSahfkzxJWEIgXjHRzQGznDHX6NVu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba708814-9121-43e7-8ad7-08dd34edfaa4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 22:51:27.5183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjNIzlzqZTvwMJxqr9ksS7jXUepugAeYeMFbZHXzbnICuERudikvQQvOfMXyG1rdVVNr3bV507ft23kln7QvCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5822
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> Introduce correctable and uncorrectable CXL PCIe Port Protocol Error
> handlers.
> 
> The handlers will be called with a 'struct pci_dev' parameter
> indicating the CXL Port device requiring handling. The CXL PCIe Port
> device's underlying 'struct device' will match the port device in the
> CXL topology.
> 
> Use the PCIe Port's device object to find the matching CXL Upstream Switch
> Port, CXL Downstream Switch Port, or CXL Root Port in the CXL topology. The
> matching CXL Port device should contain a cached reference to the RAS
> register block. The cached RAS block will be used handling the error.
> 
> Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() using
> a reference to the RAS registers as a parameter. These functions will use
> the RAS register reference to indicate an error and clear the device's RAS
> status.
> 
> Future patches will assign the error handlers and add trace logging.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 63 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 8275b3dc3589..411834f7efe0 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -776,6 +776,69 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>  }
>  
> +static int match_uport(struct device *dev, const void *data)
> +{
> +	struct device *uport_dev = (struct device *)data;
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +
> +	return port->uport_dev == uport_dev;
> +}
> +
> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
> +{
> +	struct cxl_port *port;
> +
> +	if (!pdev)
> +		return NULL;
> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		struct cxl_dport *dport;
> +		void __iomem *ras_base;
> +
> +		port = find_cxl_port(&pdev->dev, &dport);
> +		ras_base = dport ? dport->regs.ras : NULL;
> +		if (port)
> +			put_device(&port->dev);
> +		return ras_base;
> +	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
> +		struct device *port_dev;
> +
> +		port_dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
> +					   match_uport);
> +		if (!port_dev)
> +			return NULL;
> +
> +		port = to_cxl_port(port_dev);
> +		if (!port)
> +			return NULL;
> +
> +		put_device(port_dev);

Is there any chance the cxl_port (and subsequently the mapping of the ras
registers) could go away between here and their use in
__cxl_handle_*_ras()?

Ira

> +		return port->uport_regs.ras;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void cxl_port_cor_error_detected(struct pci_dev *pdev)
> +{
> +	void __iomem *ras_base = cxl_pci_port_ras(pdev);
> +
> +	__cxl_handle_cor_ras(&pdev->dev, ras_base);
> +}
> +
> +static bool cxl_port_error_detected(struct pci_dev *pdev)
> +{
> +	void __iomem *ras_base = cxl_pci_port_ras(pdev);
> +
> +	return __cxl_handle_ras(&pdev->dev, ras_base);
> +}
> +
>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  {
>  	/* uport may have more than 1 downstream EP. Check if already mapped. */
> -- 
> 2.34.1
> 




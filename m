Return-Path: <linux-pci+bounces-14963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FAD9A95BC
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 03:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31651F236DE
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 01:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3778848CFC;
	Tue, 22 Oct 2024 01:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ScgDM2NA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245C85C5E;
	Tue, 22 Oct 2024 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562050; cv=fail; b=CoXLt0J/xCSFqvJO513X6o22VZbXNHA5NS3A6molBRkuiSpB5BxC3BzCGeqTqEQ+KQ5rmhLEUqLZE0S1/lBqghbVuG43sO5pmBhQ8LulvIgW/tECZhjmf4qH5z9mxEYjsbNrX9JA+EoTlkGFz+Yzv8KDHVyBmGkMqGH6BSkUQ4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562050; c=relaxed/simple;
	bh=8yRyP2nHyBr3YHZqHnhR5JYSESMoX354VTwOhIHORQg=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BdJLmixQGcEzodf8R3eEkvN2PaJkEtpTNha5JEncFj0+2DsroFsoFmZUFF6U+F6BZMI2dV1FcefjwLtWhypEXQJcyYrRgiG0f8qCffqJ+SUnXPVhFvZZcdMPChXPH7g9lcGe5KoP17HPlm1kowZE1/myIlWP+DbSQoIkkh4d0GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ScgDM2NA; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729562046; x=1761098046;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=8yRyP2nHyBr3YHZqHnhR5JYSESMoX354VTwOhIHORQg=;
  b=ScgDM2NAFAbOcF3eXBMYgYKJYanHj7LeG3heTPIU0+ZOfa2LbxrZqzLZ
   0cASYmcaP63HzwjX5LiJCQNDWBY05SgrzINt7KYhNM6twOQbguZ2jtsy+
   wepRUN/ZH+Jpy9G3IT0SuofaXerRmAUl/J+HHVlQdScwLlF6uDJFfha5t
   DA4VHVUAtZsHNf9kJKCW2gTZpi68t7yCqMGijkou4zJwTFLUCuDg/kQHz
   B1Z9/jTGGIEO4PTzR/dSsDzvyQgtL5E/U09mlDCtzaQSIS2T1lQkAtnsS
   Dt78xfHJE4zqR8R6xXUvCK1C0RxeGt16ldfjs306qCL+E+499hwJXzmv9
   g==;
X-CSE-ConnectionGUID: K7sEx0T9SSWYQT4wyrXDAQ==
X-CSE-MsgGUID: hnNRWVAeQ+W86Qw+r7Tj2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="54479302"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="54479302"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:54:05 -0700
X-CSE-ConnectionGUID: r/ePf2H8T2maZDIcNCjWdg==
X-CSE-MsgGUID: U3Ta9e51S7ikpsQ7x5qIFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="83709274"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 18:54:05 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 18:54:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 18:54:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 18:54:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1HdyWX+fy0lI98VTjWoEIcPg0NcFl8VViGuZwRI1cLsQKp9R8MfflxgMPkswg7AltJVowcYuTx70VHGVxpDi1sulfOg/VF4x6WX+LVzEVx88d0dyPRpzdUuHs9b5JkmXz74FF3YOiLAx9Ch7yfmOAh2aCzLFGXI1lyUAW8noWInbbYCdUeilEBHp4T+mfd9fBDbyoQyF2ssMyUrphVFom/PDol9RxwcppywYe1t13xIlnm3Cy3fEJDQcSv7iZd2YLukXzzJ2pq/KB+PEYKhyMMxf1dsN8M8AH6pf0SlXnEIvl0hbP8oU1jZW4AMFhVeGrZdIz5e8qG9P82AGVj9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNK2SJGHETZ9FyGQWDkWAXz89VMDhbFpJMHUFHYFC8A=;
 b=zKi23Ijmyxp33Ua5QWbqldpmZHtQsi1ciV9C/kPG0A2tmm61XfQVhYsdZaWbcm8pMgkYvuEBfwp+w4YjbIQrvW9d9Adbj765cM/DZmeJNU5DUq0cmgw7gx7LnyK7ylAsbEqDk2poWoENj2+JL3ux1lq0Snmi6nhFJFMAba0ALIYY71uDGyLDLgAivCTkIrss7cGjDDhy45LtAT7Uo1VitYGFUrUOXGkQiDg61IhS1PhhxK3g4m0HA8N86lRmYB4oSZuluLw5MFNu3cA3yqv3v1S4cTFclBkURr4eT9C8FSIOsv8h61Q3BwDzaM435kBN2O0V2EfyloggkAiVHosWmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB8266.namprd11.prod.outlook.com (2603:10b6:303:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 01:54:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 01:54:01 +0000
Date: Mon, 21 Oct 2024 18:53:57 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 01/15] cxl/aer/pci: Add CXL PCIe port error handler
 callbacks in AER service driver
Message-ID: <671705b5bb95b_231229468@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-2-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241008221657.1130181-2-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0257.namprd04.prod.outlook.com
 (2603:10b6:303:88::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: fe357ece-a8d5-4eeb-3520-08dcf23c66b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m2WHVAvYsoMvAsT6bN85DAj4LQM4lhk6gVnPc624lSrtNOVIKOKCLg7lZqWB?=
 =?us-ascii?Q?eJcpykvE3fuKDCzud22R2BAQhqdoDL5Y0pkin6BPB+9W2Iqel6S2QadGLXHt?=
 =?us-ascii?Q?JlL32LXouknup0Ir3iVpDiReWidHBnFX02EBA45yavZmCq2Ra6w+ATWyMY79?=
 =?us-ascii?Q?GpgzMiLiNEQPGagKZyLYO4d6LRi9BoQXoHDEqyBkcrLXV9fzRIqw0erO79bo?=
 =?us-ascii?Q?zkZrhqukCCFrQ/baEiuR0Nij+5hb2q1H6xxwoHc+lI26iYB+orkxhuka9Qpx?=
 =?us-ascii?Q?cS/C24LBhE4DqB1Zb+l1Y2NdtLRKkyyYe/9+JbaLQYIb1TlZbnobE8U78Dmc?=
 =?us-ascii?Q?EvjG7UGL5zAmUMuT4hzxJqXGhCzMws1+5OikfjLcG+/K+exkd/gg7rVQsiZu?=
 =?us-ascii?Q?j+qFpvMi9qZZiOKq7nxDjqNEcyuifUUjbT+QuxyPaw7hoIbB4CTl6cITqa/m?=
 =?us-ascii?Q?ONs6iMA+HY1UdMWG7Yc2uZtzT8LQt7CIwjvqHMPDuTCj35XvRLBUhjdKmXXY?=
 =?us-ascii?Q?YdR13QNDeXN1i7Pl2hqGDhU+UvLPDzy1gMPQjhntCci139eX0h2RzOPG+LWt?=
 =?us-ascii?Q?hYOQ7aSvA5DWcFnk1WEXzZAd3X9I3dIuAm5qo8Z3bdv+UyTViRSdoLGImUaI?=
 =?us-ascii?Q?IinV6/wi2WDb6VwbuILutNzYVi0nVmC+r/lDODTZMHlyJbjgBL6GEX333wAP?=
 =?us-ascii?Q?Faow9AGDxcquGw2f4pVvMv0sR9V4EfMa6hf+u4cFzqsuWmZS46fZU0TBRXQ2?=
 =?us-ascii?Q?8iBizHNBEg4yQ4EnR27Xigqq+aFgi4qfBI86Rw8Q4EGWhFL0h+NRX0lDelIt?=
 =?us-ascii?Q?PcgENyQJM3YQwTk5visHC8I3FrLkoMAo8FwJ6gbdf1CxB/CoqVg4DlENjjFv?=
 =?us-ascii?Q?lvQXQdLAcfOlD9XtRhjF8e9qmkRE5CFVREmgGwihqW6fmwHcB264fcSi47KS?=
 =?us-ascii?Q?DEiSG7Cb0mxYT8l/IAKSoNndRb5akufZzRh7K+GH4DLN9iMkVn1YFWVGB3mw?=
 =?us-ascii?Q?WSQo/6cVYH5pXtbQuzX2GixreAwVdu6agCdo7/Nh+XfOeYUp8bF3IJ7XNeRm?=
 =?us-ascii?Q?UWFHK8HQUQyy9l7U6un9Ki9ngMY1X7XOX7rNU5RasjxCpV3KaBAcPuK0Ul61?=
 =?us-ascii?Q?NCeTaEwHl+XjHWwcFLpkzebyj4S05Nf+NrxECNuWhdke6s8dURH4eFs/M/ke?=
 =?us-ascii?Q?wM1oUE3zE4e+ylGSd6nMVxIbjTcmK1Kxnex/BKk+sv0zYfYWqiX5EtbX6wEz?=
 =?us-ascii?Q?2Qb1ZrciCrtrGv2qrNu8XlDJzgVO01nFLFzbSdP9RqXYxJsmYHRMiVxn2vZV?=
 =?us-ascii?Q?E6jS3bBAa7F77mSXO3kzsFWFvaXkdtKUjHhcAF+oxGzR6nlmDlwR/uDDPJG6?=
 =?us-ascii?Q?dCRihKU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1G+4ZX3fnSw+FcmmlJmNqIo/89PT0fvwqmsUfjyPgIugL/P4MoYKObtZK5h2?=
 =?us-ascii?Q?4rIMTSERZ+Sr/79kp8EkrGBQkcn8vm00GCqBXDaCUfWglyAYgjT8aQ5295fo?=
 =?us-ascii?Q?Wd8UTBJBZmuMqWsQeawk6EKrwhu77KQ4a8jpZPboeVi367XiaJocDbwoZ8Kr?=
 =?us-ascii?Q?rVIZJZTRZt2vNpB6TlHLCWPBtUxvg110Ri6VFHLSn0TUo+52vek0zr47QVDL?=
 =?us-ascii?Q?APS6RHgl8L6uyCDP1xpEVySxHrIr1oXg3hOcKundmL6MOcbZ/qd2CplXhdaU?=
 =?us-ascii?Q?ZchaWq8/yG+dgE0C56e2seSeZ0KwHp27/J1IERNeTsqO/amh/OajBYjIKM/h?=
 =?us-ascii?Q?+Ipvv+Al/sZcIaAD+cVjABQqMDV7a9wSsXBTqHSAKSz6RHZM485utycqPW5a?=
 =?us-ascii?Q?SLZf+RFjAitdeTlvZG2MfSmrAqPeS50rgl9G6tqysfzbzPmgRmn5/oyqy941?=
 =?us-ascii?Q?G6k1S+F+hJYH0lNruxwowUf2YORN9w38YaHTPHm48a7wP6g1RzDKdceCN9dr?=
 =?us-ascii?Q?FCYRI/Jxm/rBHms9AiuG5KmYG/RYME4fXYEGSYMZK8ruBsPXS8TBpo6JGUeL?=
 =?us-ascii?Q?Ij2DAc41mNgu1IsD+EAFamGBpgLDy8cNP/Yv5jIboKHxnQ7spz73ayM/VRfa?=
 =?us-ascii?Q?02xqERLxYLajEfG1upu9Z6+9Xdk0FLf4syQECvq5K/Q44k4ne1xUTOdnSN2f?=
 =?us-ascii?Q?qPn2PdBNQiKuUOULtGHGID2JzZddslIhkN9TYhpn74AXU39ka9h062ItvX2P?=
 =?us-ascii?Q?9zDr8z/arZ+WjL3Vs0iPG2imaO98yOg95DT0Q7BH14QFm5Bjz/SmMotJBHV2?=
 =?us-ascii?Q?lPBL3iTVRIF/Ywz3RyJjrtWYyveuqflORwGgm0Jzsrz26UZUUKsaGAXuaTV1?=
 =?us-ascii?Q?pVZJvFW0G/5pv3RK/FE/Lecelxyk/E4tilSIt+8BRgvYOLRO2w4nTLt0EDhW?=
 =?us-ascii?Q?QeijccEJKpkfb0xC6qE7LfZ6gU7Xfr18AVLTfLCBKnV5BXDlaw+TsMBBd2y8?=
 =?us-ascii?Q?SsyB1fkAfcHCJqdbgQg3K7gSv3rR0n+rQ0Po1sqyXjMyv0iIACwn7cvjpwD6?=
 =?us-ascii?Q?5v4pMCIe8krYxkp6bLx714ENc+Hjg2f/MxYEdPqEl2rLLuNfSbzatM9p5Pa4?=
 =?us-ascii?Q?NIuW29psW39kl9N1htJQEyOl40Ba7akf1I7EArSwrKwARX7qD7c1R/JJrhJs?=
 =?us-ascii?Q?u39xOgeunLklt14P94Xxzcx8SPD4AeF9y3biWdOURhAtcLmgGGRAgH8fnkJv?=
 =?us-ascii?Q?V99P6IHNM5kLq2FJidJu54FV5PGdHKvqvuetmhYzQBUKh8sxJcin4MTt8C4g?=
 =?us-ascii?Q?/YTH68hklWPpUD7i/bn3ebhv/aoc11zA4jSiCa03avsN6bbX7200weRQni6G?=
 =?us-ascii?Q?GJDvMbdd6m5lGEs8B+sRTXO6pp/vDxfMmb/vdGezdiqhTDKEA6FzBIPVHo7o?=
 =?us-ascii?Q?JVxVqDBmYJuydJgsxiWTTpVeYizl5s+cdsAqHiZeNdRhsBWUodirzWc4KyMK?=
 =?us-ascii?Q?iBXtxyKg7hecnzrOWnl/TbV4zJi1rz0GaFtkbVAgXD3AyZA6y60VzOhalxgH?=
 =?us-ascii?Q?SgSF6sduKWr/BErG149nIMF8zXS0wNv/UXvrDt6TqxYFXzCYhj1tagc+I4lk?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe357ece-a8d5-4eeb-3520-08dcf23c66b7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 01:54:01.6464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yo4fg7eMMA8OHWC6HQV5CrEEvgqpk4cMkxt+dlNO2wDw4g9GhJznpWRagddGy0ey3FwOYMMGM7XY4yTmPBUy1MA6sYGkrfwHV2iMTK/SOEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8266
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL protocol errors are reported to the OS through PCIe correctable and
> uncorrectable internal errors. However, since CXL PCIe port devices
> are currently bound to the portdrv driver, there is no mechanism to
> notify the CXL driver, which is necessary for proper logging and
> handling.
> 
> To address this, introduce CXL PCIe port error callbacks along with
> register/unregister and accessor functions. The callbacks will be
> invoked by the AER driver in the case protocol errors are reported by
> a CXL port device.
> 
> The AER driver callbacks will be used in future patches implementing
> CXL PCIe port error handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/pci/pcie/aer.c | 22 ++++++++++++++++++++++
>  include/linux/aer.h    | 14 ++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 13b8586924ea..a9792b9576b4 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -50,6 +50,8 @@ struct aer_rpc {
>  	DECLARE_KFIFO(aer_fifo, struct aer_err_source, AER_ERROR_SOURCES_MAX);
>  };
>  
> +static struct cxl_port_err_hndlrs cxl_port_hndlrs;

I think this can afford to splurge on a few more letters and make this

static struct cxl_port_error_handlers cxl_port_error_handlers;


> +
>  /* AER stats for the device */
>  struct aer_stats {
>  
> @@ -1078,6 +1080,26 @@ static inline void cxl_rch_handle_error(struct pci_dev *dev,
>  					struct aer_err_info *info) { }
>  #endif
>  
> +void register_cxl_port_hndlrs(struct cxl_port_err_hndlrs *_cxl_port_hndlrs)
> +{
> +	cxl_port_hndlrs.error_detected = _cxl_port_hndlrs->error_detected;
> +	cxl_port_hndlrs.cor_error_detected = _cxl_port_hndlrs->cor_error_detected;
> +}
> +EXPORT_SYMBOL_NS_GPL(register_cxl_port_hndlrs, CXL);
> +
> +void unregister_cxl_port_hndlrs(void)
> +{
> +	cxl_port_hndlrs.error_detected = NULL;
> +	cxl_port_hndlrs.cor_error_detected = NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(unregister_cxl_port_hndlrs, CXL);
> +
> +struct cxl_port_err_hndlrs *find_cxl_port_hndlrs(void)
> +{
> +	return &cxl_port_hndlrs;
> +}
> +EXPORT_SYMBOL_NS_GPL(find_cxl_port_hndlrs, CXL);

I guess I will need to go deeper into the code, but I would not have
expected that new registration interfaces are needed. Each 'struct
pci_driver' could optionally include CXL error handlers alongside their
PCIe error handlers and when CXL AER errors are broadcast only the CXL
handlers are invoked. I.e. the registration is something like:

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 6af5e0425872..42db26195bda 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -793,6 +793,7 @@ static struct pci_driver pcie_portdriver = {
        .shutdown       = pcie_portdrv_shutdown,
 
        .err_handler    = &pcie_portdrv_err_handler,
+       .cxl_err_handler = &cxl_portdrv_err_handler,
 
        .driver_managed_dma = true,


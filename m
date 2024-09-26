Return-Path: <linux-pci+bounces-13572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C6987755
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 18:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036BF1F29542
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13239154BF8;
	Thu, 26 Sep 2024 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPs8srbd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB8615AD9C
	for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2024 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367018; cv=fail; b=cOpkiTcpJsLfWffvm8chlpB7Ar4JOPzZpY2G4ZZ3h9lhQtoMcRmLdl9FPbnyoIJ4dKwjVaRWIgyFoa814sxQvpZF2Eta+oSdEUOZbXzeSAjMc55k7ZL1mraBD+CdEMIFi2pqD1DajrruizzgZkhFxXEagaNW9hDG4e696X9hvZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367018; c=relaxed/simple;
	bh=SkU6m5AUns0EdX7Fa+h5oKUE/6j+ThUuOXaQs3hG+N0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qxgIxvCVkohh9lizOgvlWW2dKEm2EuPeESNjs9OY5+ez/ip9Ot0IZidE7bXo6FjO/TUpd+2R3agi4OE1AAPhcl1TmJoYjccY8SipLUV4gRbltBuxBMYHr8JwQOMcueOxGrxknQ/jX6QkRyNg8O5Hoj76BqjZF8sYeUHh1gigjG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPs8srbd; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727367016; x=1758903016;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=SkU6m5AUns0EdX7Fa+h5oKUE/6j+ThUuOXaQs3hG+N0=;
  b=OPs8srbd05VQP6J6d12EqSabij/0J8ywdsTnR6GVHBlfSn9rtPp4RIag
   pcQeGgGyuB9a+52UvVpDfTDuoGnUhQYPDjuiG95a0kIm6sxVEWceOS0Ve
   mw9v6YjWKIeVr9q5dHoRFZPFbapgfeGdz1f88KYav734SXv76rkoI7ldv
   0ahlpEwXvcBvGKFqsibblzCxucchfzve4dQU9l0N60adA8aZ5xzddgvwD
   jwXZPnhsGLpzXfGyHcjgHMwJgE0mxLD1G4vgxOpBfZbWnerDeLve6g/sd
   uwmcb2ExArIdB+2Hm9ZpDhuMFJxOpteWgP2QDUHydXCtw+BHzxLT9CEHo
   w==;
X-CSE-ConnectionGUID: 1/WBKm4ATXmGGWybkzXIpw==
X-CSE-MsgGUID: pLlynDX+SL6vpRXRLXPRzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="30186069"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="30186069"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 09:10:15 -0700
X-CSE-ConnectionGUID: IFSKv9BmRBmX0kqGNaJI/A==
X-CSE-MsgGUID: a82GvY8tQOWQ3sUNzH4i2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72296087"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 09:10:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 09:10:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 09:10:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 09:10:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jovT9ymnXSAJv0eLc7/mj7ZBp78xpAnTiD2fC59g+Swa6LKxXCFujdOydVoQYLzGhRGoUQBAoB86/z645Ym9MZq6CqdzI9bYpjzsfMPBOFyLZ0Fgyd0ZqAW2EkYJTQIl9bkaBll1TVNvCoM0azA6K8XL3NfXPeeID9kjqRipPCsyJ2Z6TrWCl2KbXa22Wk/ztFp+eC30Vqu5UcX4gfZiwuFiblXvkRXqszbVS96VMKmw1qJ8c6Zn5TDSmND/wiAYIbTcyBDraPTgmBdVzzB37cB+uZDJHf7pIYv+pIpC0Nod2OqyY9NFrxSqS/RiYW101WzpjW7oCGL1FbFMoFXvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD9SyIKJOj3EZyV577KULnODPzGJG3bc4oapkiUCJ8o=;
 b=tSAToK/w0/fyaoXfX72EHrTFpS52qWz3+lzTyTORJPMJWq1MyvgGgHIs92wZfxX/TPPNBiwCiTMlbPHPSehjsBHd1pMw3J3BnNNHKN2cuXvYvZgiKH6hCvEEzb9uTKxSWLp6bDyVdntIw7nd4p3Xp+irK8dBzX6ZBo4pVf/+nPifKdn89J3zbxEOBUdzhroiW6q3Y5ozx1GI6JowR9nRaTEEoN4XBrAZf2WvGI68KO9Sw0o5+FbR4eCdoDgm9Z9lBE7wJTiQesLLo4r8p/xE6Xr4chauObITlyxQSR7Z9SqfFebRp4rio6MivPoRWV+/8I5zIOJoejnrZPnBi5DRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2854.namprd11.prod.outlook.com (2603:10b6:a02:c9::12)
 by CY8PR11MB6986.namprd11.prod.outlook.com (2603:10b6:930:56::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 16:10:12 +0000
Received: from BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42]) by BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42%5]) with mapi id 15.20.7962.022; Thu, 26 Sep 2024
 16:10:12 +0000
Date: Thu, 26 Sep 2024 12:10:08 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/6] drm/i915/pm: Simplify pm hook documentation
Message-ID: <ZvWHYM-I27CokH4D@intel.com>
References: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
 <20240925144526.2482-4-ville.syrjala@linux.intel.com>
 <ZvVzmKIL_PrM2fds@intel.com>
 <ZvWAEN0n1y4xx_AO@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvWAEN0n1y4xx_AO@intel.com>
X-ClientProxiedBy: MW4PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:303:8d::26) To BYAPR11MB2854.namprd11.prod.outlook.com
 (2603:10b6:a02:c9::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2854:EE_|CY8PR11MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f04e45-3faa-48e2-0273-08dcde45b34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ccWXRUxsyQ49Y94L0l1NaoyTZ//rDUlH4dW9LewH/y2tIphk6RHDsIMBWa?=
 =?iso-8859-1?Q?H8aui3XosoN6m8qqE5Js9amSBQf4A/r/q7zVT1wh28NMzcTiVv/1PIaxkO?=
 =?iso-8859-1?Q?gs0hb8T+5cEQQKhpvLreBI2T5yVE04kusrFJWr3MaFwdi1COabihkv0UKh?=
 =?iso-8859-1?Q?4H+XMvFcC5wbckZHKUgPGmFDV0MtoJAAiuYPHF//oInFNaE7Ys7MNI/M52?=
 =?iso-8859-1?Q?PZKivZA0/IQcWpfm9Cth9NY+jTe1Qa1PHEdEwR2mYLZJyyx0CGkZdaO/IN?=
 =?iso-8859-1?Q?k+1WWLTpLxzDpPm+hcvXRDgQ1ofZXjMYvVWQ2Saz/UaisCS3XOs1mgTfLM?=
 =?iso-8859-1?Q?8eF1+4JeNa01UmqGI6nzIMcJlYiJMMFF8zNJyb2gt3c9Nmn+3n8GkgNTVq?=
 =?iso-8859-1?Q?usEqGVZ7mmhSCESVaTvKwKv4uFuGBa1Y1eClElK37OhWB9EGEyfmOR+kJW?=
 =?iso-8859-1?Q?2yyRodaM6x+9hOI0Am+kDh9NntocEKmrv6Iv0GGGyeNeEqznegDsOhBxFh?=
 =?iso-8859-1?Q?GXdoS62bU2Bg+KMJJ3Dt6bUogfaofTHAB/jobHc9MWa0KmAs34bAJSVzYm?=
 =?iso-8859-1?Q?xpNyJ5WEWn4QyBO+2C409EG6IuZh8L89jrk6dtRfcXQjqaq7sXoGkXIQMc?=
 =?iso-8859-1?Q?UQOyg6E3uT4R4KzZTkxaNKwiCrDq3eDZ10KHKFmJ6Gjd6rnPHjQAg7h6/s?=
 =?iso-8859-1?Q?27ywySBlFme48ge6pHUeSsbd5kJ11WKkqiWLC7yc02zw8H71Rui33Tp4Od?=
 =?iso-8859-1?Q?lH8S6zEWY4uQQHeHgb+TC737R9de/Vq5lprYQtt5/JxpCjpPInZVZp1B6N?=
 =?iso-8859-1?Q?KYClou2gY2g7swwaGVNHQu8wcKYTKxQFBtn0cfl15EDs5Wa+HWUtJzhhD8?=
 =?iso-8859-1?Q?7Fm61S5VKpco0foiKo/CufFyYbGg1xttmCjq5LIGZTTBBrp5DM9ziWdsiH?=
 =?iso-8859-1?Q?fzu8ZHK2/s7S6q4alUT4vHk11KU09j7Dcjj71t42PJ4c8xbCldHd2AU9on?=
 =?iso-8859-1?Q?oi+I5vlWNfE1+K90qPmcr8JiFpSZD3XYS/eXw7fWqj3Qhi6smJmqSEJS40?=
 =?iso-8859-1?Q?JFi7lWk69jWSCYRE8GHzxKqihWohvofTxY8Es3r1o/2X+ho81kxwx3GHtK?=
 =?iso-8859-1?Q?a+Jq59gTkyhpCIVPwL/IGrQPuaPwtKF7RVm5Ee2u62bvy+j226Tk4DioF6?=
 =?iso-8859-1?Q?LaeC4l9qxSbVDI9NUftRaQGfd3wZrPcxH1TMV9fM4zO7Ysj7RcTPya2V5l?=
 =?iso-8859-1?Q?wo6MgtIH7O3FSBVBvWiT+PMakVYTXNhB5GYvMiEa9QJT/j03w5/UBYFJVi?=
 =?iso-8859-1?Q?+TBUUaxuKbAvHAFMivKGHvaLnZJ5fITz7mFq6XtqTvA0TrLxAf8Jjn8qRR?=
 =?iso-8859-1?Q?WAmSqynb3ly7YOJ/IkT1//2LBTpwYbkA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2854.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8LeNB274uYn46FvzD1Q1kNIokZuXXKh0NdaGSKe+/wDAL1JRT2SAmimfwh?=
 =?iso-8859-1?Q?ic/6rFk/0CQrrZKPcgLBZ0h8reNRNaRUkAEQ0Cw3Pxc1C0Pdtgs1gqenYK?=
 =?iso-8859-1?Q?zrpRp/8Lj/PxNliMqOKE1L+DdCY4E+xbNDJuvl4Xz36N7rMzqqWpu13FP4?=
 =?iso-8859-1?Q?FuFGnKltgBv2rftc2Ak+4m91mG7sznGbdSaqRNiLu0U3534bks4YPD39Az?=
 =?iso-8859-1?Q?8fxEhj8H2m9ocTMCVpoRkAY3TiMtyo/Bloga3N6nfK4/GEevrygHOtibV7?=
 =?iso-8859-1?Q?x3aMw38DyUr7PufG78CbKCDRC+mfzQ9n2QMh8pb5atZAwlnzIxtCUYlFJq?=
 =?iso-8859-1?Q?7zIxGydZr83wBOoWDJzWQqQUs1zlmpV1q5T/LZYwWdBAb/N9UctDD3vGJ4?=
 =?iso-8859-1?Q?IjJVYj9qdiynJwKSxPi5rnoC/XReG37LlEssJ9uCNpyWJylpcsXd6pTRBm?=
 =?iso-8859-1?Q?y0yDswFYlqXzGsqXlhNmYKOgm3isXs2iiOHfwP7+kXolgg2wNWulV7skwv?=
 =?iso-8859-1?Q?WcwoDXoIXnv7AjtM3ElUnSVqwNsSBUbZTBRgZ2Jv/ssE9127W/226pG5te?=
 =?iso-8859-1?Q?qyrdAliBpk0LduF+Bmih8545260tdcWmJrO4tC9g/X2VSaar9weNLdFLls?=
 =?iso-8859-1?Q?OdlqgVKh3d3zgy2C2h2Sygcj1pYmyiTWKm0evCvzPzbXyflT9qzaUU6T1X?=
 =?iso-8859-1?Q?jzJ029KlktqfWbK2JKHAmX9A8irknk75CeO4yoFW3vrQK3HCgoXDGDqHca?=
 =?iso-8859-1?Q?nUADNnUs4CRD9ZHuTV8FiT2AFNYwsEAiKe3C/9RixOS6nWs6SejhgKyCgD?=
 =?iso-8859-1?Q?itqPTPWD+lMRvtlVmtjwVMtzEivF4CMHdvyUMq826J9D1q5EvgNosbvMjN?=
 =?iso-8859-1?Q?ADaIgrncDTwd923u0h9FuGyEnB+9R7yOhVwEUtFoBIIX24PWaGz+JSR2yC?=
 =?iso-8859-1?Q?7mAneGhzNb3RCw+QWCwLy+wtRCAATup9wkW7ddjkZTXv7ZmpLJfnByIWXl?=
 =?iso-8859-1?Q?zLXUKe3L+J4yJumi4a4vKBh1Ue2/1xKpTZYa9iKRZhB7OqTvHLSZUuNias?=
 =?iso-8859-1?Q?3nMRikPIPZIbvgs2JxJQaat7U+TRu3jCAcxS+o5hIrJSQ705LSASdP3/o4?=
 =?iso-8859-1?Q?2jPZYmS8Hgrdbf85219/RKb90Rwkzih/0nsGp9P89r+6xsjBMlyd6wyS6O?=
 =?iso-8859-1?Q?i1UeyKEf+51eUf1tPopHsJovnpvzWSulMV6h4jECm1QyM2G8w50JQuHBca?=
 =?iso-8859-1?Q?YR46cz6hlsWcgc/0YR1QxwzvjjhkjsLiqiuMM1tkZsBFMdLYeR7un0JDDv?=
 =?iso-8859-1?Q?oEIbMjDYAY5hTBTuLkbo3I7prvn5Hpfx6T+Nkgp/nCwnBV7HNzoVeCHgvh?=
 =?iso-8859-1?Q?eapWH7y/8PRSK6MT1DbPapJYI7XOBizIa6877Tn6mb7FP0m+TPBSXwq86s?=
 =?iso-8859-1?Q?QQoKvjKlGfnte9r7Epp1PhaVoJtDjpFG/meFdBzbWi1FhntXThWwL4R95L?=
 =?iso-8859-1?Q?o5dyaFsoZD5L0XCli1TlGs+2OpOrsivye5P7Pd7sbI5S35Di4hKYrm7RAn?=
 =?iso-8859-1?Q?XdWJEeZ3bF7sXu6Nwy/DlgqLafKFpPU5ApLbxD9IViv08q/M8LkFRP4pbB?=
 =?iso-8859-1?Q?z6M10GkTdHwZk34tpXo0QJOomW3t5ZMn3hO+weYBIf84QDqtkIkt6Ttw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f04e45-3faa-48e2-0273-08dcde45b34a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2854.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 16:10:12.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfPuKwb7Mw6kkVzybnwGpPfnrt0UkZG+BsT28nDX8rkmaMajPUnMbLs81d8mpenFGnvP00RJZbrrW9TSY/UIwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6986
X-OriginatorOrg: intel.com

On Thu, Sep 26, 2024 at 06:38:56PM +0300, Ville Syrjälä wrote:
> On Thu, Sep 26, 2024 at 10:45:44AM -0400, Rodrigo Vivi wrote:
> > On Wed, Sep 25, 2024 at 05:45:23PM +0300, Ville Syrjala wrote:
> > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > 
> > > Stop spelling out each variant of the hook ("" vs. "_late" vs.
> > > "_early") and just say eg. "@thaw*" to indicate all of them.
> > > Avoids having to update the docs whenever we start/stop using
> > > one of the variants.
> > 
> > That or simply remove them all and refer only to the pm documentation?
> > "Entering Hibernation" of Documentation/driver-api/pm/devices.rst
> 
> That's not very succinct. Having a better quick overview
> of the whole situation might still be nice. 

Fair enough.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> 
> > 
> > > 
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: linux-pci@vger.kernel.org
> > > Cc: intel-gfx@lists.freedesktop.org
> > > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > ---
> > >  drivers/gpu/drm/i915/i915_driver.c | 24 ++++++++++++------------
> > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> > > index 9d557ff8adf5..1e5abf72dfc4 100644
> > > --- a/drivers/gpu/drm/i915/i915_driver.c
> > > +++ b/drivers/gpu/drm/i915/i915_driver.c
> > > @@ -1644,18 +1644,18 @@ const struct dev_pm_ops i915_pm_ops = {
> > >  
> > >  	/*
> > >  	 * S4 event handlers
> > > -	 * @freeze, @freeze_late    : called (1) before creating the
> > > -	 *                            hibernation image [PMSG_FREEZE] and
> > > -	 *                            (2) after rebooting, before restoring
> > > -	 *                            the image [PMSG_QUIESCE]
> > > -	 * @thaw, @thaw_early       : called (1) after creating the hibernation
> > > -	 *                            image, before writing it [PMSG_THAW]
> > > -	 *                            and (2) after failing to create or
> > > -	 *                            restore the image [PMSG_RECOVER]
> > > -	 * @poweroff, @poweroff_late: called after writing the hibernation
> > > -	 *                            image, before rebooting [PMSG_HIBERNATE]
> > > -	 * @restore, @restore_early : called after rebooting and restoring the
> > > -	 *                            hibernation image [PMSG_RESTORE]
> > > +	 * @freeze*   : called (1) before creating the
> > > +	 *              hibernation image [PMSG_FREEZE] and
> > > +	 *              (2) after rebooting, before restoring
> > > +	 *              the image [PMSG_QUIESCE]
> > > +	 * @thaw*     : called (1) after creating the hibernation
> > > +	 *              image, before writing it [PMSG_THAW]
> > > +	 *              and (2) after failing to create or
> > > +	 *              restore the image [PMSG_RECOVER]
> > > +	 * @poweroff* : called after writing the hibernation
> > > +	 *              image, before rebooting [PMSG_HIBERNATE]
> > > +	 * @restore*  : called after rebooting and restoring the
> > > +	 *              hibernation image [PMSG_RESTORE]
> > >  	 */
> > >  	.freeze = i915_pm_freeze,
> > >  	.freeze_late = i915_pm_freeze_late,
> > > -- 
> > > 2.44.2
> > > 
> 
> -- 
> Ville Syrjälä
> Intel


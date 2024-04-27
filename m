Return-Path: <linux-pci+bounces-6740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BE58B4732
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 18:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353AB281B54
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC00628;
	Sat, 27 Apr 2024 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EG8To1lj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33276E572;
	Sat, 27 Apr 2024 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714236590; cv=fail; b=T95zmcQa7+ttZV66QW1NjsC2R2XgaOkRUATC69nZiUU9DM5/974hTFdVuL4MkZYL8bh1IaFEOr2YC15cA2g06pnPg16ZCeOkrp803uNsWI1X9aRbVd1dUuVT1yj52Te7M2r8n1rxHpYekief3rVwkDi/sik0Ryg/ta93g2wcMYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714236590; c=relaxed/simple;
	bh=eNeBiEM3zeF5nJ9vR34PhgR/1KFvmEy6KISY6UNKi1M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J65lI90BjA7BDYy05MMgs6GYO6aARiKgHKFwVg1vZxVeqkX8O32hoYaeqYeD9aPEatu5KBxUymVB9SdDD6TGLcL233YEc+8WJzUQ+caTk3GZ68uX0lt58EHcK+4X8eTympgIHjxh7JXkQaqmTx3Lej0MZHPB2biPtryCtBg1nhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EG8To1lj; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714236588; x=1745772588;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eNeBiEM3zeF5nJ9vR34PhgR/1KFvmEy6KISY6UNKi1M=;
  b=EG8To1ljYj7s/N0hKafKQ+A4qF9KLRvZzFt7SPDAGrJgOUvYKX5ApBcW
   pgF9VvnWzGHunbAYUdmMpopBY6T3V41frcy1IF6fn3sTCLlXwcbt5tAhA
   wj0H4IuemJ1vezq1MQGJsQ0jRt7fP/9yDtAqS+IBckBf2JSpsiAOcMJjg
   idKFlt9/nto4Zzyi1ytMthx0Zs3giG9y7YfTUZwSuolJR4qXMncO/FFme
   j3QB/ae2Kcin5Bho+/9lG6DdMjWm7kZdSBiBM7c4yGZU9ZDX6YsZnderl
   dYG+S0+lAk2ZJ249SeM/At5v7A7RnHDZwxoJDPp5bukyoS5WwUfylL9CU
   g==;
X-CSE-ConnectionGUID: id8W6LXEQruv6+07Xt1nYw==
X-CSE-MsgGUID: MNURZ+57QhSVJ01pQGfLHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21367378"
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="21367378"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 09:49:47 -0700
X-CSE-ConnectionGUID: nGAqvCMaQ6mi9bU6ti7Umg==
X-CSE-MsgGUID: Q5lEkzEcS2S9pdWkhSOXJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="30369757"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Apr 2024 09:49:47 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Apr 2024 09:49:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 27 Apr 2024 09:49:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 27 Apr 2024 09:49:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUeWcoHi4aK5rATO/WopJa9PgmPY/YdyJ1081L0ohndP3vPm/JyWclh0DvzoJ73mOIP9GJjhtcoGbfrEfGMy7phlL5X2oE7qR4Fe4J2nfTxBT9cEvVFj7FCSBbU09Gy1dsrA6ghnXIiFjfq6H/g/aCxJVH6pY41tqlyQ0/CLFqYKDprlJUx1q+dPTJy1Z+LJBqM3Otei8B9GP/iDLI9ezuXNgD1OzY3yFAFAGK8pYYEbASdFobrJmhNbqS/KGrBVeNBMo9lkMJyUaxAeOKGeWfVdqcBsDAP4GtrSuo38rR6qDL7Lsj9+FZiThKtkaqMBSoocOH/xiOWTMb0jEBCs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAkiqmp8Kx8UA2A2xOVmf1kLi4nRFmwlxTovExFgUg4=;
 b=K0lbav5qjOp9SSzSitiiRYxMORjmJVaCT+vIHmPX1ns3FRs5r+sDLvirPS6tZPUuZF39XZtwKVcZ5f9h/SRswu5t+YgyQWDFZd1rYY4aisavNBoQw5HwjL4LomxZxNG4zOmrLWGPABAWmO8MpHzpTaSJql/oOVNZLLcuAJq+omUrNoBqEOhBFGGixWRZatneJ/HwCWpRP4oYVd/6yBft72SHNn156cJyXdIfBpLQfLS2g6NguLmdS9D4oubo3KcViCl329WrKofJE8ikC3OrIw2dOuPTVgzCexD0joVsXdjZvps71c+VRz2j1yRDrNefBCrmwjOGXQSo1MCNQxtjhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PR11MB8758.namprd11.prod.outlook.com (2603:10b6:0:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Sat, 27 Apr
 2024 16:49:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Sat, 27 Apr 2024
 16:49:44 +0000
Date: Sat, 27 Apr 2024 09:49:41 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>
CC: <gregkh@linuxfoundation.org>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Marc Herbert
	<marc.herbert@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 1/3] sysfs: Fix crash on empty group attributes array
Message-ID: <662d2ca522cc6_b6e02942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
 <170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com>
 <ZiYrzzk9Me1aksmE@wunner.de>
 <662beb6ad280f_db82d29458@dwillia2-xfh.jf.intel.com.notmuch>
 <Ziv9984CJeQ4muZy@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Ziv9984CJeQ4muZy@wunner.de>
X-ClientProxiedBy: MW4PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:303:b6::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PR11MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: 20afa590-d5a5-409c-0028-08dc66da0a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JxmA7ks4K3yGJ4qaraGvdnJG++QDPLOB0SnmO5uErkGB8cyFkkyMnUvuekO0?=
 =?us-ascii?Q?gv8xI5jwlCRUbHPa4L/dCJD1JdtAdH4bBnPl+WT0dK4WPHa1Vx24vuhcMjlg?=
 =?us-ascii?Q?jCEyRHHxnhqNO+Qyb+pP+aiyPAtLe3HIGDsTZD6qXTL7KIUEU0iCZs5+gUvI?=
 =?us-ascii?Q?qiTM09Ypv+Q52e8DslhKl+xIsTu7Zol9YWeL3pL0tElY8BSp1r2peqeWfHOL?=
 =?us-ascii?Q?Fj+U2VMX3sok/HxjJ56OsnZLnywsFnWMVIPoJK25pnd6rvVSqmz2uxzgEjli?=
 =?us-ascii?Q?C66eR5B2xZLh8B7Q9rpOFSnLWqGd1M5BYpvAsKDK/wGyTejsDHLuqWDzvaPW?=
 =?us-ascii?Q?XTTxww0j8MWNVHbyEaHfeMBaWW8j9WCbn205O0LyoYoSwRmfDjh1ALqZiJGx?=
 =?us-ascii?Q?kxFOd7JQhgyuXtPVpeq5MsZOSl9exeyn0qwgIMiZ93xAY+4FxJhJsedYOVXD?=
 =?us-ascii?Q?gfkEfxKiGhkQ0NoPdToGIEGDjP8p/ENr/ZuTe5AeE8bIUzOI339ZVxQWbUlU?=
 =?us-ascii?Q?CpvuiVPMsYwBgrmEF61ngGDYzeMEwhcAR9fc5urvtb+9Lf4V8hEbZLLI8gVX?=
 =?us-ascii?Q?RJP7/2QkrdXwoSF2f+kGP2M6hPZM/h9fxeCjvM2tt22B0N2Hh9LnthJz7fm3?=
 =?us-ascii?Q?pueUin/H1+CH3vcZlMjz3CLPceJgVz62Y8B6gOYMJZyvCVdt2PXiHi+SxGhM?=
 =?us-ascii?Q?X4EFxtKfyiHVMqLRLMvG9anU+MIuSB7s3rU0Gpjbn30ba2QQI6ZRrlLs4KOa?=
 =?us-ascii?Q?H2CnD4UC4NM50Ma3YTWtlJAMIpJtNkwPOSKHuBhHbQopptR9wX8NBmQytzet?=
 =?us-ascii?Q?L+5QiO7nbUmM44SLr6oFaRMG24WEZWpZ7Uc2K6uCZE5bl6WOh6B8NPgQuvtH?=
 =?us-ascii?Q?tOVt3VcEHqoaay5jW4/7zq2q3EhuDFQTei93dla0xlvOVJxgad1sj5TVKVS/?=
 =?us-ascii?Q?bVoFrAg3pFm6NwYM10PT9uDuYR+fzeUvYF2FDc4THqu111L/2li2M8L6/OUl?=
 =?us-ascii?Q?qiK07CqqT7/cMZOr5souYJ+qosTNxJmA1EHpEEdW7heVg45FW4/ONPPlcX8P?=
 =?us-ascii?Q?AHc6Igx2d7AVc3CA1KP/r9w5Ea+a8tQFDdSmRruo2CQ+OFJdoYhDQBmmwtSC?=
 =?us-ascii?Q?Lvb0eoVvmAQrfE75JQ8Cjujgn6DVdsTJslnv/h7xFwTBTGgX8y7kpu1c8Mco?=
 =?us-ascii?Q?6QDDda153nRZkmHNr0lhU/qTLpo6jKAsLE9/+/B2qB9RjiswfXMbPtuYf+fw?=
 =?us-ascii?Q?y8gfC0R+zKeRdYp8gJadKLTJ3Er4RSm+EPZip8eesw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NIiBvEnRjxXqu9NrEbW0Sn5V19Q5Dg3zDGeMg9I7n4GyMNmsK0q0NYK+IeKC?=
 =?us-ascii?Q?ijVCMiuuAuvW6LQ4t8f2gcgmjBi5X2/wlNr/vd2a2taFvP+Q0OuAiGl4bw2s?=
 =?us-ascii?Q?LNCYWmEUtiPlhri/xdiOdT2nGm8lURFRL8RyteagxH6Go1UGMrmDNULBhKSg?=
 =?us-ascii?Q?8Ui1rmF5r718nWKEadzhFlCCRpU67FyGgPTUflCmRltsHBjC4Oq2MxXgSt5Q?=
 =?us-ascii?Q?HQen9hFnomXHWkjzA/M4wy5UP2ihizIaXvPe+xRka2hiVWDjFvmVaimYGXwR?=
 =?us-ascii?Q?c6Eo1COt9W+WhEVXEHjaKFXuPhuQIYkRFwzZCNu+BNyVcQRD9/YaitHR/rWw?=
 =?us-ascii?Q?4DDUk60NXidhNrMbIZXhDqA+fJx4ey17wpHulOTPIW0wZunBtfgnT5CBgo/2?=
 =?us-ascii?Q?J5a8vtjrcAMnbNRilMaNQLzlnNr7E2FIaXBbI15jcQb8VHtu8JNqr2WAh1CF?=
 =?us-ascii?Q?MRTwHqvXvh5X9NDiaT5GF+tB/vR2Oyr6tSCpnpNvggOvTJEEsP6c5iqeI8F1?=
 =?us-ascii?Q?yW6BFTKzmM3rAeGw7F9xRTZ8A0iZZ5RfupxJIevQKRaH5BMMUhbhEayjt+ZN?=
 =?us-ascii?Q?BIpx8hSQIWG5t6Hb9SPPz/UVjf5FGhLKYp4GwFsSGKiV5D2mt1bGsTMLvryh?=
 =?us-ascii?Q?t0snbPDtRzvWynwrEP3rgd30SFpvXn+iLpfpTcbkmXTQW6WJ8fTpwf4NG/u1?=
 =?us-ascii?Q?tMXcJGq1qoKUIvxXbpEqPvMWyE/+1NQMSMtX692PdCwT6jiZ049Yi36gYzq5?=
 =?us-ascii?Q?QWlM4JFv7hX06wP76og6zrk7TMcE7k1qTo9fTX7t9dJNLBIrlQWcU252zGsV?=
 =?us-ascii?Q?EOAwzOyytSy3vvausJxdCKwb7hwpxPy3a8M+8+P9/7m5WORmgrxISJCE7tc+?=
 =?us-ascii?Q?uxtWQJZfAiDJKc5mqHqiHwjoP45I1nUh0jh8YvKr7gJEeFU/BOQl3ixR4bUU?=
 =?us-ascii?Q?rxmWGNmmYt/6twOwh46Hdb/C0nZX/JJC7B0NDi9ehT1rC1xv83/dG1pvANx0?=
 =?us-ascii?Q?6Ug0afpWOmsuszoxjDZUeXptF9DbJ8qw3IPprSR4Ug4Y9cHrWqQtz3GDS4yj?=
 =?us-ascii?Q?+hcu1DwfZaPb0Pw1956sLu9jehidAE1+hYJGWTpQtC4owHyNau3tovLAK10k?=
 =?us-ascii?Q?lsMRvVl+X3r2pUnu0qJtcHMmRYn3HQE3c6quE1wl+RhnAfHzSw/ZlukJL7y9?=
 =?us-ascii?Q?G1QGUMEVT4GPG2xD3JH20ddWgTm4VJAO8BVVLXo4jsZvWjcEhZ4uHWc2P/ON?=
 =?us-ascii?Q?hZsgoMJMfEEgjS5z0T5PMihFftfhwhjjV4S+n6h3pH+g5qyif1o8ui7JVB8S?=
 =?us-ascii?Q?/zRgzuc2iZlTsEdpsQ4fCeDpeSdMb22lzgROATytlO5jE6DkQliDD7IBoKlp?=
 =?us-ascii?Q?RP8vIuayRUPbJewOPBEeqDgwHK6y0hVCKDx9Dy+JAxze4G9RX/uve45gCEWU?=
 =?us-ascii?Q?e+IzpJ4Lv2b/o61yM9aP4yhds40H98EfF0u3xd/edPXencOZfq7Q5ko/gYpe?=
 =?us-ascii?Q?7Ds4EQPU5VeAISR+nNekpcDjO/tN2i4J0xPi1bhpgNw/PKif8DjgoOeganjE?=
 =?us-ascii?Q?P8MqQENf3hgUJL4QOR1+h7/oqN6muRG62MYll4T+oFVk1vLS18CN8xwI4V0q?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20afa590-d5a5-409c-0028-08dc66da0a2b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 16:49:44.0303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4gc1KuvIyeMMmOfg9zGelFsHcyKt6SEJe7qQhBTj9GXAMckBoEdVjLeslacrpD2bo58D2BtviBoKb9df7zPy27y7suhH/rB+LqJX6HmRFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8758
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
[..]
> So in this case I'm able to dodge the bullet because the empty
> signatures/ directory for CMA-incapable devices is only briefly
> visible in the series.  Nobody will notice unless they apply
> only a subset of the series.
> 
> But I want to raise awareness that the inability to hide
> empty attribute groups feels awkward.

That is fair, it was definitely some gymnastics to only change user
visible behavior for new "invisible aware" attribute groups that opt-in
while leaving all the legacy cases alone.

The concern is knowing when it is ok to call an is_visible() callback
with a NULL @attr argument, or knowing when an empty array actually
means "hide the group directory".

We could add a sentinel value to indicate "I am an empty attribute list
*AND* I want my directory hidden by default". However, that's almost
identical to requiring a placeholder attribute in the list just to make
__first_visible() happy.

Other ideas? I expect this issue to come up again because dynamically
populated attribute arrays of a statically defined group is a useful
mechanism. I might need this in the PCI TSM enabling... but having at
least one attribute there is likely not a problem.


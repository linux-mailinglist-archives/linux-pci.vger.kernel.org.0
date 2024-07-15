Return-Path: <linux-pci+bounces-10315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AA9931BB7
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 22:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F0ECB20E60
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F83013A242;
	Mon, 15 Jul 2024 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtFIDABw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98354D8BF;
	Mon, 15 Jul 2024 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074810; cv=fail; b=nTaZAxVXUq2Zm1pfTK/jLqGKHECsjJcPJofrFSV6djeWCbHQ6UrNizb/Na4d7OZfkXQMXqrxp9vdfjoJJ+h9PcyKz1wXmKB3005h/uiOVSgen/+JQXQ2Co6BMi2MXwSDPidqpkDljzsyLUNIOUmIKehucVjxEaIjjkPo0f4/UBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074810; c=relaxed/simple;
	bh=aaSYCZgz7er3TIi1tdmua5NiCj7yR4slfOYc0AZwpWI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jJB09gp/+tY0tY/Sj3WBeIAxNVt+tP6ixv+X33HHJOA58FDAl4M0C7QhGhiySI3VhNAAztPYaKzTrbwbATFiIi0Rj5W0b4YfAjtBB7hpU1M7t/mN2b4AsRkN9fRJCl1vFUnASehbNLjZJT/JbcbF5uhHgyJHTOAVGApHJ2bYqvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtFIDABw; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721074808; x=1752610808;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aaSYCZgz7er3TIi1tdmua5NiCj7yR4slfOYc0AZwpWI=;
  b=gtFIDABwZTVrxSffEcbs2p2vgt9ByrB2jdbHMJxVxjn1gsxxFamGA/TT
   /sJuykasVCAorjsH0kz80itg0R5Ijq2qITuGyYb9iu95Ca/BqI3Trvhlj
   9LcWA93e1abv2xeOAjkfvt8efnCY33Ht9JGxPSSaPiIYzg5Z6ixCIKG5D
   NoPYUzsYjI8qvAGaIU6yHrAUiXjtSV/eViyRPqRdXMaDaFbt3VbFsgez9
   x7BqEdBkGCYCHpPTsrU7CQkTECrklefqfQohDi4G4Rg82BmbckxPhxMaS
   H0Uq5Ulnsq9VGK8VsKnWwo50YOraMMSgG4Y5RnKi01V0B0/iCAcrov+qP
   A==;
X-CSE-ConnectionGUID: UfV42QczSyu9DbX3PNkmrg==
X-CSE-MsgGUID: zrP1XX0eTRi1CbuzjpJPyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18617524"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18617524"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 13:20:07 -0700
X-CSE-ConnectionGUID: MII5KvOPT+GwtLS4hM3pcA==
X-CSE-MsgGUID: t5/EQc0oSYia1ZUyCUc4sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49596816"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 13:20:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 13:20:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 13:20:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 13:20:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPi9u8Qb0IRPtbWrWzDZdnmz53adPy3Q/Mz6rx6eWQSMI94gxuV0yX8rh0rZUDT+16p92tgm2r1eac23IIgkPPqqJm1w95UULvLlpbFIR3kQHKgY6pWPgyKSmrDppgwSb9YHjGktDJGYlj5OzxVqRIZd0t/6ITr5KMxy2y5gIqoHlYubnxeU0Uc/6HdDJAKHCjwW+8WgFg4nIzHk9yZ6cEDzAkqyUGCIKvbviDTWoD5b83n6coW0TioNgjUSae9H4hVjedoTDBmwJFalQUt7ydRH/AaaT9Vg4zJCbAbMOmqhDBNvQl8QuLQ6+YkGNRNNxTRjHQVqcCqiL6wJ4tLddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t3YnkRWnVLEvzwI4mIFj1fy6+hqA9/1/sg++PfQI8s=;
 b=YbZJMj5EPhF3uG/3JWJ4LsvS3vfjVXkrNnzAb6MiVAPRN3Re36KvBGI+HpWqwle+kWbJYdkYItsVcrDREIp6UwJbAi5EgGWPVneFvt4lf9VvMaGakafa8cE0T5zq62I7FV6Ah8eC03P4HEkDTMeV3JxDNsrbqEalANN1AtTvHrSsK3yQOvg/yIO8QxPQ3fXTNRJSVJsE2opidcyuIUGVjFd4iApCdh1FuR1XiwYSnrsYqq6hKsb2zxVC3b/eqls8uuH0PRan7oIKV5XQ1g7DJr2wY1Nw0lqokYgF/xnekDjnQm3iYt0I9FBkCYmjElzxYKVr/ldoyFGpXfnAZOX1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4637.namprd11.prod.outlook.com (2603:10b6:806:97::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 20:19:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 20:19:56 +0000
Date: Mon, 15 Jul 2024 13:19:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Kees Cook <kees@kernel.org>, Lukas Wunner <lukas@wunner.de>
CC: Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, "David
 Howells" <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, David Woodhouse
	<dwmw2@infradead.org>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linuxarm@huawei.com>, David Box <david.e.box@intel.com>, "Li, Ming"
	<ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	"Alistair Francis" <alistair.francis@wdc.com>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>,
	"Gobikrishna Dhanuskodi" <gdhanuskodi@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, "Peter Gonda" <pgonda@google.com>, Jerome Glisse
	<jglisse@google.com>, "Sean Christopherson" <seanjc@google.com>, Alexander
 Graf <graf@amazon.com>, "Samuel Ortiz" <sameo@rivosinc.com>, Jann Horn
	<jannh@google.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <66958467d03b0_8f74d294c4@dwillia2-xfh.jf.intel.com.notmuch>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de>
 <202407151005.15C1D4C5E8@keescook>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202407151005.15C1D4C5E8@keescook>
X-ClientProxiedBy: MW4PR04CA0258.namprd04.prod.outlook.com
 (2603:10b6:303:88::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f67d1fe-9385-4a0d-d361-08dca50b7e33
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IxpXjegQU/oUWsDhTxLfH2+Lm81D7TrOEcXaD9nIoUVG+9PVUd6bp+bT5Fd5?=
 =?us-ascii?Q?UT4Kh9ePvpatLn30gVg20BMH93Ge+rSv1mlKG9tfKvgARGc5qwQoXFSHr1j5?=
 =?us-ascii?Q?OAdgt87WyNSgZku+u4NyThUG7nV6NPQ0hSleBR/5ylfekUdbiOAoYWSrrOrP?=
 =?us-ascii?Q?RkAF2JeFKWAP//Dz8izU6KcVFkH9AxA3KjwB0eft3RU8ZCaKk50gMnQTSRaK?=
 =?us-ascii?Q?wQOzngg61U19ZsP/xAoYEwP6v8VzxgH8TkjIWhxv0EaPP89YU7PeZZm9Hqcf?=
 =?us-ascii?Q?VLtsB62vlIUGRTnVFbgB94aX5CdfH5rcPhnsNcFtKle826J2EreAf+duXiGP?=
 =?us-ascii?Q?0sX3fGFlEhxkL2SvRs/XAbAnMNQ+OtU0eUCM/IPPYIjOslj7dJC8ZqmtF0ay?=
 =?us-ascii?Q?McEcPYbpspA5IyHA2/q1TfYsI52kp6gkxZW/w6+/apB8vEdsc7rHUhILIIq7?=
 =?us-ascii?Q?eULePv++2UMvG5ZC0HzM5dkTtNpHfebDzCq6XnKO8rDEDsmL58mjJpZgfJ+c?=
 =?us-ascii?Q?T00a9OGcb5f3eC1tQY+0iMmlaJXUbEP3NTcnN0/IvQKrWg/lavElwwyW/Dr9?=
 =?us-ascii?Q?7Vq9cbjH3EtAUnrD8wo20diBn81jQduYZphkX6UVpVmFF3LW12emBhbf3xDE?=
 =?us-ascii?Q?gY5tIcqDhto6ALdZQAAIIDZyEQW003W+C36aoRx2u/V2wh3TTB7cCAg6kjjH?=
 =?us-ascii?Q?1Zr1n7rwoU4cfBW5Lmd2nf78Mu+TUtP5G9gSXsu54QGlQnKyITATCWkJin9D?=
 =?us-ascii?Q?hr7hTZL6mlrZSO9wYLxG6n1wgyy3S37TA5MaxsmyPA5t9zHNL7u5FCAFG/sL?=
 =?us-ascii?Q?6DNUtvu8YsN7OKzJgsOxsqTWttjhSsnwMryZJKI1k3UY60S0X/fblkbvI2iR?=
 =?us-ascii?Q?Cto4VyFIgRlYmCoT8sA2LbELzc/EGyKi8ySeo2SNi80ajuQXHIvy/OZByXeP?=
 =?us-ascii?Q?0cgSu74mS+cyliQvyQE2V861dI2ZLSzgQZnZMPDielNnE4g1mnHLcYFPk71M?=
 =?us-ascii?Q?lOBsct1nSVRtyY8oP+bjj989XM0tXw3JWKuR0gShfmVq6DHlv6oIKKF4WPAp?=
 =?us-ascii?Q?WTivaxeqbWThnXyZKmpg7w4o1bWrBc8Ft/GkHLMyWaxOUJ+b+RKVxkBM/I4L?=
 =?us-ascii?Q?MycrPaQrr+dOaXexzhNO9mcydfrHTQO5RDvPqmJpk91Cvuk96aFPqZl1bRBZ?=
 =?us-ascii?Q?swD6G5i3DgQ484paObSy6N4Vgs/W9Lg1Tn+Ek6xNPpz+jmThnRFZiTZQRMjA?=
 =?us-ascii?Q?VerkcY7DcBGRhI/NzesJO3wEBiIWrsp7pCTnQc24iqGxNwcdLiD2mKx1R9mg?=
 =?us-ascii?Q?mVRoPSxtVdYC+GsBD5kM8tVAv5xqi25JhQqff5ISxIyKew=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fjrqOs0leSNdzNJCuN69a4vLYuJF8KOAgNDWASynG13ouS9XWPj4Uu0whYkG?=
 =?us-ascii?Q?Qyb2WamHb0Qaw2/jsFp4b5Q+YfLMXFNlvRZa/XKgC8MeW1s60L/BaXZj/ggl?=
 =?us-ascii?Q?AN+0VmMdE6CWkuXuWimkECzpoj71ToyHQv/wKmADQY5YtVKwud1HxsFj8RTj?=
 =?us-ascii?Q?jFEnMIluWos0dRPnpVLN0Xoccpbu0s6tK71afZWB2NFfCiqW+Eq5lsUbpk3m?=
 =?us-ascii?Q?Zs4A1QpoeRohrjVSLnMZxHy4Y+zzfXGPSUt39HO6MmW87XaovdZjmcZJs+gd?=
 =?us-ascii?Q?YBzlVPgpfHpjP3ETUjWPLB+CWiJshsW95oX33b3Di646DcNMuSMVkI4lKHpg?=
 =?us-ascii?Q?agy4I9vXdBHPrvIIvuXsP4HBFo9A5hSyVuXI26fk4FbJlYsPqO55u1HAcfLY?=
 =?us-ascii?Q?kpaeV/zRj3hALjjpu0hKOFM8wxe16p8wAm9Sz6rQuvZzdv6uIPkigNSZ722I?=
 =?us-ascii?Q?BW2/kXSLVxevwoj1iE83c+bn7/Bg0rq/zXFcRjRDLbZaFsmbm0pa36/5eb0P?=
 =?us-ascii?Q?LfITSh3HyU6jA/znTjmbv3gaC5QEg9Lt5zbLfkSyM00w+BCYOjOd1uWyJxsM?=
 =?us-ascii?Q?KnMUHe4obz8LeNPnAMXpl7/Rojb1Z2BYFp2YAJ45sVkNfmA1WzpCU2AHmJ5i?=
 =?us-ascii?Q?8CcHl4k8Ae63XI9U1NPmDBD3dc8kMfYQILoyXRUPkaU5C5ye2x8TIcAb7g+m?=
 =?us-ascii?Q?fAppBOYT/Ki0lLKXVT0shHopmJ44o8XauTDulrNfXt4980VD35X1IsDNNDy0?=
 =?us-ascii?Q?rFe5wVS0tyGFvNhh2rhBgGyhOlhC0++c5mNWmhrKvykq5XpY2S0vWPMquQPL?=
 =?us-ascii?Q?DTKeUkQD9yTTi0dUTZlSAaXHslzT9dJw4WA6RIOi2S7MlpYZzeKO9lla5y9X?=
 =?us-ascii?Q?/WzW7DW7XD1Ri7SokDsPYDFUX6gMFxoZCgnaiNV1ixGITR9zXi6sXLX8fpOo?=
 =?us-ascii?Q?CSiX4vdLD2IBx+bq60roqCQTEYANBA6PzCAzqEKCatfD0RccEotfzu/tr5mt?=
 =?us-ascii?Q?OP92BmtrT1p0gAPKLypaJKb33qSdqAp1SeIoWYLGRpJVAZ4Jnyye3LgQg2Pi?=
 =?us-ascii?Q?D5RuXePUIEtS879mCVDp4iCj/ziatWVroiK/4yhJ73+VQde4uQ6htwTNKnn6?=
 =?us-ascii?Q?Yyq4xH8JTsBNb6dSpt21x63MRbIx65PRtqANELp/UG+/mPP1k7i1f7hrC4mi?=
 =?us-ascii?Q?Ykxdixjenwtl9EL+yk+eQwB0ucA6GuG5vBi2FX7Lpxc5FNkXcSstTDlbsnNN?=
 =?us-ascii?Q?1AAFxRtk3ashqhRcZzQvAJC/8OfaV12q3Th2X9i7UPNx6ozG6BfQguY/RS7r?=
 =?us-ascii?Q?jH4gtdRkZcXz+AwodVRIeS5bhASgCYhrK6FTmnzumEXjOwW4GL8ugj8JzYte?=
 =?us-ascii?Q?0JK8BqusRU2UU1SwiV4GsaZydVUiyoLvZyrbW9CFyXHc8t1imBV9a5VqwHxN?=
 =?us-ascii?Q?Lp5kNOwD6AMR0frG6u1z7EbNlPTiYkMNtLYvlRUQGe6XGhc7u13bIfpb4BTU?=
 =?us-ascii?Q?x3QEbccVU8v1Nu+pfulJ6XYjaBC42L804KA0oh5D3UNRDbtKNETh7hKxuVZr?=
 =?us-ascii?Q?u75noK1D7zcyMapolDdTl16T32H0HHnJ7XbvqRz2saSXB6Goj/4PTfpDz7F7?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f67d1fe-9385-4a0d-d361-08dca50b7e33
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 20:19:56.1814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dG2PHBaMwHLSTLrFLUFMPicFzQncO8RbFRlAL78ShHQL9umk+arWCiyFnXCwxcBirl5oihBk7MDTXdGPOs20kTpSu8TQj0ISqI0eVPCaMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4637
X-OriginatorOrg: intel.com

Kees Cook wrote:
> On Sun, Jul 14, 2024 at 10:42:41AM +0200, Lukas Wunner wrote:
> > It's probably too early to decide which actions to take if a device fails
> > authentication, whether to offer a variety of actions (only prevent driver
> > binding) or just stick to the harshest one (firewall off the device),
> > when to perform those actions and which knobs to offer to users for
> > controlling policy and overriding actions.  We may need more real-world
> > experience before we can make those decisions and we may need to ask
> > security folks such as Kees Cook and Jann Horn for their perspective.
> 
> I don't know PCI internals well enough to have any actionable opinion on
> many of the aspects of this thread, but I can try to give my perspective
> on the mitigation behavior at least.
> 
> My main observation is that the CC threat model of "we can't trust what
> is attached to the bus" is an extremely high bar, and is not the common
> threat model for most deployments.
> 
> As such, it seems like any associated behaviors need to defer to common
> deployments. It may just be as simple as making it a Kconfig option. That
> said, the best practice for such specialized behaviors is actually best
> put behind a static branch so that distros can able a given feature
> without making it on by default. (e.g. see the randomize_kstack_offset
> boot param[1].) Given the "module or builtin" question, I would expect
> this will end up being strictly a Kconfig, though.
> 
> Anyway, following the threat model, it doesn't seem like half measures
> make any sense. If the threat model is "we cannot trust bus members" and
> authentication is being used to establish trust, then anything else must
> be explicitly excluded. If this can only be done via the described
> firewalling, then that really does seem to be the right choice.

This is where the discussion jumps off into details and needs more
precision. Mere authentication, PCI CMA, does not establish trust in the
device. Authentication only tells you that the device provided a
certificate that matched a value read from config-space. That device's
config-space can be spoofed and / or the MMIO registers that the driver
thinks it is talking to can be spoofed. So establishing trust in the
*bus* requires PCI TDISP.

> Now given what a high bar it is to not trust the bus, there are a lot of
> attack methodologies that likely need to be examined. For example, the
> bus has a different lifetime than the kernel, so it may be possible that
> members are attacking each other/the CPU/DMA etc, before Linux has even
> started running. If that can't be mitigated, then it doesn't matter what
> Linux is doing.

Right, PCI TDISP considers this, PCI CMA does not.

> This is why I've kind of tried to stay out of CC discussions: the threat
> models can be extremely hard to wrangle, and much of it depends on
> hardware design. :) I have enough to worry about just trying to protect
> the kernel from userspace. ;)

Yes, I am trying to find a path that allows for incrementally enabling
these security technologies while not overselling the value, and not
completely invalidating the Linux device driver model as "step1".

Even with PCI TDISP, and the end-to-end trust that the PCI interface is
the one you expect, a lot can happen once traffic crosses the
bus-to-device interface.


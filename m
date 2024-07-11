Return-Path: <linux-pci+bounces-10173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D17692EE0D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 19:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A336A1F25419
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 17:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50C715B10A;
	Thu, 11 Jul 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6nL/sSD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8E12D205;
	Thu, 11 Jul 2024 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720241; cv=fail; b=k5ZYCipk1C5yvzODdB8kZ00RMg8iWmX4MPqBYr94cTrTNbTyt20U+Pb//m6Ld4bjP9RbSurKE37OcLPvLfNwg3my9H0aeE7Zd9F9bglrfZtHlsn1BvyxbyZAO9LLv5bOb+tilMTNZlhR8pVNu25IyniTnJ2iGDS993riw9eo4rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720241; c=relaxed/simple;
	bh=SnUQR1HcNjnLAmxMT3wmEK0swrh2Qdv2EXSWFu+6tds=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bKbcUC4zBgzbHFvVZY9r0DpZXhihrZCO3hsnFqnLp5xn4fRle3v9WAm38++yHDtkIPTN1dSkwt0zzLOeZLpMEllT98qBxq0mnu4iJD8RQFJXQU2UILfx8OWJK/tItWqaY4xKgrWKr5LQxgQxM+OiGX4SIHngP91sZuljnGCw91Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6nL/sSD; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720720240; x=1752256240;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SnUQR1HcNjnLAmxMT3wmEK0swrh2Qdv2EXSWFu+6tds=;
  b=A6nL/sSDK9icGmcMmWHi549EoK65kHcKMwJMptac+5FaRQNgJ6EJjgQs
   3NOaDGHk92DgSbd5JBaajbnYavy4R62dHo0V4fXOu5nRl2WEY9Pb1uxXJ
   2zJedz/lbuXDmV4QGwJV52AL7p9c+Urw9BWV/GmKhBgCGuDlbWkoibO9U
   dOh4u+JLCLwTB4/YfB+ejbcveNOFQoL5COOJ/fQCHe1OYPI3+vOwtsLxX
   tSnqI5sfmNA25fNunLroB/tzgJ5f9A6i9+VR8qtwrTu7rniJiCwm5L70E
   v3seF5Fn+qJPTzhnhfoFa0PAfd6GQ6sxaK2p2o1JGqk58aGQ2+lG/KU0/
   Q==;
X-CSE-ConnectionGUID: QX0yaUl4S+ewMRWsh/Y9MQ==
X-CSE-MsgGUID: NuNe3V7TSweoLsjLpm0AjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18328457"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="18328457"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 10:50:39 -0700
X-CSE-ConnectionGUID: 0n4u5lDPRqC7fVIIq6fn0w==
X-CSE-MsgGUID: sjndorSOSxCX+Wia3Z50Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48518585"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 10:50:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 10:50:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 10:50:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 10:50:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 10:50:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCOUrrGRJ40rmmaqz8w6Wu0BASYRAA4dsTPCys6pTjwxNCA3LK+V+HC04qg+nWBloSkE8NtmJa9Hu9T2NOqT4ThhBoaQ5Dn90Squc0a6QAWVfrGBcdthDIGDCN9eZqZhcjtwfsmNXexV8EnX6r2ZTtrfLVrsNyIe22d2Lc556851WLHYwRyd7jD2rF4RG1RVdUHRaarHer070gB/4S4Hj7kO+y0pHn/cnqZyBv+8KkTEZ+Vf3s34/IoFimcctdTLUD385pHh+GyqWQa+GxOp2ZQYQ/veXV2guoAo/WiBYls01TW4Kh3byOX7EXaw39cjtXOXbWcX9aeeYwLzXZsc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpZd+Td+pZEXwrnCKg1LvIjqTqdE3TsrIb23W8CdlPI=;
 b=ifaerB13DcFXyO+ckKQbTKjhlck7GvuDNNa7ukA1WO+im/wdMkfNm91QKEPVpV2GsZ8JSMgq7Wg7wmDtZ/91vgQ7SjMvRD+4/EmA0SNGi32Phvod9yaJHkLKFPyQ4xl2u+wq3zsYXUh3f7C/hM1KUW7meMdtAJKRSvQKP89BMWlaeX+uH+tbuf83iGdWfnVwBLMkQrDfmok7ghdQlAXyCJpjoqhoZOLmA7ppjDE1IXNaRbNwwDUt7ZzT7xXPS1It+cfPM+EnrIR9lpjpZ+zs5vx4kui4wvg7DddkEG05fSI3H+XoVjL4MYGNd6U92vWKL6vlSQFbPGIYgTZ6Kr4eHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 17:50:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 17:50:32 +0000
Date: Thu, 11 Jul 2024 10:50:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas
	<helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David
 Woodhouse <dwmw2@infradead.org>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linuxarm@huawei.com>, David Box <david.e.box@intel.com>, "Li, Ming"
	<ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair
 Francis <alistair.francis@wdc.com>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse
	<jglisse@google.com>, Sean Christopherson <seanjc@google.com>, "Alexander
 Graf" <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
References: <Zo_zivacyWmBuQcM@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zo_zivacyWmBuQcM@wunner.de>
X-ClientProxiedBy: MW2PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:907:1::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f61a4d-1e27-4348-82f0-08dca1d1f575
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ISTvYty0+SebQIJLnRODlsqMzKYPYkxjMMfaY6OhNr8u40tlHIa7uTAecW6Q?=
 =?us-ascii?Q?mt89BO4oQkShlix2gWoXLFV4A28EMjdjHgrh7aQseqEYFJQg5KG6Ko0sHckO?=
 =?us-ascii?Q?zzsmkkuLoslf8hoeWqOda6Lm8H0ujut0jI+ySNexyLvKt3ROwvTc8oygrEQx?=
 =?us-ascii?Q?lTlMVgsYaGQqxl9/GXF19+/Lnb8vYLdtsQnClW73MnSkPgy3n6E/IHyMCkiy?=
 =?us-ascii?Q?VWM94NR9uuuQCuNZfZq7VXlb2FrUEDmnM8btu7Rv7r+/PgBV5snkdnJiIMeU?=
 =?us-ascii?Q?nT9fKlp+w0A1ZeU1iM9Dd2hDYz+DN61yCnKTnR3SC2inWjoUMxplu8mtlEgH?=
 =?us-ascii?Q?/zZZkfz1vWSZo2w51O16BQQJ8GLWRqV6aEZaETstd8Z8HEpE+G8vdhS/ij7a?=
 =?us-ascii?Q?DdhIqRtxRLrfQ6y2BF3zwfsrrH8A5zO8AuZRWmbSTR5h7l2hBFIP0ywwJWOs?=
 =?us-ascii?Q?lmIRaGw7Pj3Qh9ZnUO9dJZE9BN6I3jbK9+DRI/z3H9I+1WnCy8fJjXOPzMOq?=
 =?us-ascii?Q?9cdd63YyzLRWcFi0o7g9EfZhSdFOQmwKHqJYuKjNpN8kfyohqyPfJpYhCns2?=
 =?us-ascii?Q?KVnyVGqDUtKbRV+UeekmG+Tilr62KCpZA6eJ7hXWgrpCCMMEw8cfq5hOfFHG?=
 =?us-ascii?Q?UHUH7RB/iMoTkcLbSWlciFRlJhsZOo2yV+2Oz9ChHRMQ/1ooRgSWNyr9pdv/?=
 =?us-ascii?Q?qDKpqIgIJYghXa/vqGlnNNDNKk9YerCRTXg4r2Rl6BgGqm5rjBkt1J43oOh8?=
 =?us-ascii?Q?JToGzkIKpAuRLbsV0DoSCsCtgRwyNuKxtG1dEzFyjk8At/NC4Y7NSaaCF8+9?=
 =?us-ascii?Q?cMpXJ+r85aI+8FyJbcrpuKnO7TxF+CHxlSJIaECBY1fOvwzgbMjlIWKb0wcO?=
 =?us-ascii?Q?JvPiAJxplBlx9FdscTD42PNNYP7Pg2hN2WyEZLmiS4gdX/CfyWU0vPldZ33o?=
 =?us-ascii?Q?bU9gpNuou39B09KtuS/Gn/WPetBrUM1lCs/PnZ2KpuCoHash8Zesa7+IvLMj?=
 =?us-ascii?Q?aIaNlBoATi+BZ3OZhafTwiDuUi6aBmVweQ/DLodGZrqBBwTPF+2AukgFYexR?=
 =?us-ascii?Q?tLir9cJgp0G2oTvxkMO1XcQzYkSNnxi+Kt95myDLgfAaPt66HEcdM7jF3VCn?=
 =?us-ascii?Q?6Jp4xRh3UoYSGU+JE6NU4do2JkdtLYryQkw7t2CED+pFJVixoqTsGEbqwUFO?=
 =?us-ascii?Q?YR0gf6p0huRTL664wjYJv+qpW5aiKw00YBsymgVAMNQamu+rvHX3xHZ0yqbh?=
 =?us-ascii?Q?qo5K/wLkLpfIi12vfA0e92eTYDrKavXHHfj7Sjjc1s78lpss4xceM0f1E64n?=
 =?us-ascii?Q?eS0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dh4lEie6SbYX13dxHjH34QnpH8hlkBWo/zGCZXEkWrioyMh28yhJH6Jdyfx0?=
 =?us-ascii?Q?E91C5PRBDpSPP+qXYbzOTX4J17jgT0NcGxL9dI9h0QqEY3olblJZk6k/T5uz?=
 =?us-ascii?Q?gIM28rjJi5okU0O/jG/VByM6vw8qamaRCZIhY2e0i9WDMsUO9Ws3VdSiMnh5?=
 =?us-ascii?Q?bBK7BPDrsVU3ASbRT9RYoMwI1y1pjYV6yaht8RQK8QipqJ7sN6Xbf+Avpw3A?=
 =?us-ascii?Q?RRPQNO9gVPRDjOxpQAfu2esixcTkwGpF9etwRnPFnWlkboqm7UBHID2Hnt2S?=
 =?us-ascii?Q?ESg12HcHba8dz2Cw5ctSEFl4676SKS8fBNUihhfksrGKbiXgKvPxN+lkGcuM?=
 =?us-ascii?Q?tzvTAOJ/QvAUxSvl88uYaKZ/b02m88hH/HVoWZjyYSBot2AzvYTaNMiw3y8V?=
 =?us-ascii?Q?jfNIJyP39LJDYEL6BXhuXuxBsNLoiDNP96KMXs1rYPVqTYVMuCDwXkj6K/EA?=
 =?us-ascii?Q?UBndqkzBkfPg4QYMjiqmhQti98eOcTKihWccvim+VmaMUwleLhg701otKVVY?=
 =?us-ascii?Q?CLnS54D5j4GVfaRAT2n++NY11Wc7DeSRNeTGH6hv7ShbrGIez5pqHkWItlmk?=
 =?us-ascii?Q?iOFTeAI8+8lSxrma/5uwo6fcJvPQzHfBEQJVu3FlVY6rY8bBfzNDzpWkBgop?=
 =?us-ascii?Q?x8MDa/ffandB3Z2qvILQK911hK5JW8BraXhvPd7CQiWe6KkkxxXpavTOX5AA?=
 =?us-ascii?Q?NaOubaWDF8HfiRfVevJgH/+Lq9mC8iagyUzh1klm2CaA6gne3B+q50bXlRdE?=
 =?us-ascii?Q?+YfEMC4Lxz1rr6JRU6ezrnJKIx+Tk0UmZBNWSIYwWxkttKlA1VUUL5ImnSiA?=
 =?us-ascii?Q?iSoPXtQ+Js0w7cnmFf9pj8xmRB7B0pytKpfdSE9Nx88vWOLLqLypckS1+b1T?=
 =?us-ascii?Q?0/2uAk0c9yl75u/dN6WY0NYQ6n1YFxc4sIk3mXCJvQhpm9f1liL9No+LEBEN?=
 =?us-ascii?Q?suzDihrrQzoWPea3F782PklnO+irJ2uQhawqnBHVPxBsqwgfep9qmcvw/zdD?=
 =?us-ascii?Q?wk4j6YtgBhT6xn3M0NF75UO8ZUzIqrvsM2wVBBFT1yDay5Lk500Zdbvdg4UU?=
 =?us-ascii?Q?oN0QTuWdHdpYEXmLde8XvGRGUTi4nDIrsNauHiZy9PUnIBW2nsrQrtz7Eqst?=
 =?us-ascii?Q?h0ZH1DkX6ImrKi4f5XE0J5aYjspM7tgl8fJeLVlgnNKM8wcvOA0HeqkZGi0g?=
 =?us-ascii?Q?2+LZEaq5CMJqzmDbynFu+omzF9S23hbSlYmSTtD19Ac5QHrxZu/1bfeYzZlV?=
 =?us-ascii?Q?Wx9EXvr48+l5kZRWcODY0ZhZSUuzK2SMGJGQ7aoVNaSnM/e07JyVka/loY0e?=
 =?us-ascii?Q?0tU3nlvPVt6AFexe1Y8IfhpMzw8fGd1BNHwgRXyGbQqHHXrFI6CZJ6k4SsrX?=
 =?us-ascii?Q?P5B6GHVq9m+N5nIYiHFRYd6GMFPbr+8ZZlULALf8NVCuX6dEavRMu4QGkOmV?=
 =?us-ascii?Q?T/k/l2C2m6b2XiuaGRiKkJE0GUWzqXiIV0DzaYEtxoXtDC0wL90vImYzWwJm?=
 =?us-ascii?Q?K0BGYuEm2r1mJVpq29oCp+0wziAerJccN0uXHu/mcg5ybsDf3sH+Odywtn6c?=
 =?us-ascii?Q?f5/4lCXvjntaGOlvX6IJSuAyHMsSCy82wUZ5egEyKxvRHEqFhr445fa86Buf?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f61a4d-1e27-4348-82f0-08dca1d1f575
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 17:50:31.9379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04QrOWsuhxfbElFI4bBK5uKvpcbBnlIcHPGrijWuGWgZKcY38HrDmbEjAJqF4ptI5kk3KcCTA7MkfeMGCrh/y5kPfEo9zjycd3vEVE2eo5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5832
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Tue, Jul 09, 2024 at 04:31:30PM -0700, Dan Williams wrote:
> > Non-authenticated operation is the status quo. CMA is a building block
> > to other security features.
> 
> That's not quite correct:  Products exist which support CMA but neither
> IDE nor TDISP.  CMA is not just a building block for IDE or TDISP,
> but is useful on its own merits.

Agree it is useful. The use case of signed device inventory at a CSP,
that I understand storage vendors are interested, does not demand
aggressive forced authentication of all PCI devices in early init. As far
as I understand the non PCI-CMA consumers of lib/spdm/ are going to be
drivers possibly built as modules.

> > Nothing currently cares about CMA being
> > established before a driver loads and it is not clear that now is the
> > time to for the kernel to paint itself into a corner to make that
> > guarantee.
> 
> The PCI core initializes all of the device's capabilities upon enumeration.

Init, sure.

> CMA is no different than any of the other capabilities.

It is a dynamic command protocol with a state machine, the state is free
to transition post-init.

> Chromebooks and many Linux distributions prevent driver binding to
> Thunderbolt-attached devices unless they're authorized by the user.
> I fully expect that vendors will want to additionally take advantage
> of authentication.  I don't want to wait for Windows or macOS to go
> ahead and add automatic authentication, then follow in their footsteps.
> I want Linux to lead the way here, so yes, absolutely, that's the corner
> I want the kernel to paint itself in, no less.

Look, if someone wants to build an aggressive policy they can, just set
the tristate option to 'Y'. It's the "all or nothing forced kernel
policy" that is awkward.

> > I think you are conflating automatic authentication and built-in
> > functionality. There are counter examples of security features like
> > encrypted root filesystems built on top of module drivers.
> 
> Encrypted root filesystems are mounted after all initcall levels have run
> and user space has been launched.  At that point it's possible to invoke
> request_module().  But request_module() cannot be invoked from a
> subsys_initcall(), which is when device capabilities are enumerated.

Again, this is conflating the init mechanism from the state transition.
TSM will also be initialized at subsys_initcall() level.

> TSM can be a module because it's geared towards the passthrough use case
> and passthrough only happens when user space is up and running.

Yes, and no. TSM is going to be the only mechanism to enable IDE on
multiple platforms. I can imagine hyper-vigilant use cases that want to
deploy a policy of delaying driver probing until IDE is established
*and* wanting that to happen without loadable modules. That should be
possible with CONFIG_PCI_TSM=y and some EPROBE_DEFER dance with the
low-level TSM driver.

At no point is the TSM driver forcing IDE to be enabled on all devices
just because it is there. It remains an optional policy of the distro.

> > What I am trying to avoid is CMA setting unnecessary expectations that
> > can not be duplicated by TSM like "all authentication capable PCI
> > devices will be authenticated prior to driver attach".
> 
> I don't want to artificially cripple CMA

Hold on, "cripple"!? Just because the authenticated state might be
delayed due to distro policy?

> in order to achieve only a
> lowest common denominator with TSM.  Both, native CMA and TSM-driven
> authentication have their respective use cases and (dis)advantages.
> Should we try to strive for commonalities in the ABI?  Of course!
> But not at the expense of reducing functionality.

No mechanism is injured. This is only a question of optionality in
policy.

> > I agree that CMA should be in kernel, it's not clear that authentication
> > needs to be automatic, and certainly not in a way that a driver can not
> > opt-out of.
> 
> If there is a need to opt out, that feature can be retrofitted easily.

Now, *that* is true, and that is what keeps me from outright NAKing this
approach.

I see no justification for the hard coded aggressive default policy, but
I will defer to Bjorn on whether this goes in as is with a plan to fix
it later, or fix it now.

> But systems need to be "secure by default":
> https://en.wikipedia.org/wiki/Secure_by_default

That's policy. Distros manage questions of security vs
user-friendliness, and I continue to have user friendliness concerns
relative to the security value that PCI-CMA offers.

> > What if a use case cares about resume time latency?
> 
> Resume is parallelized (see dpm_noirq_resume_devices()), so the latency
> is bounded by the time to authenticate a single device.

As far as I understand that can still be on the order of seconds, and
pathological cases that could be longer. So the choice is wait to see
who screams, or plan for non-ideal devices. The worst case is distros
start shipping CONFIG_PCI_CMA=n because it causes too many problems,

> Unfortunately boot-time enumeration of the PCI bus is not parallelized
> for historic reasons, we may indeed have to look into that.

Yeah, driver probing is async though, so if initial authentication moves
to be done in or around pci_enable_device() then it achieves async init
while also allowing for drivers to not be exposed to unauthenticated
devices.

> > What if a driver
> > knows that authentication is only needed later in the resume flow?
> 
> If authentication is not possible in the ->resume_noirq phase because
> the driver needs to perform some initialization steps, it can just call
> on the PCI core to reauthenticate the device after those steps.
> 
> The declaration of pci_cma_reauthenticate() can be moved from
> drivers/pci/pci.h to include/linux/pci.h once that need arrives.

Up to Bjorn whether to pull that thread now or not.

> > At a minimum I think pci_cma_reauthenticate() should do something like:
> > 
> > /* not previously authenticated skip authentication */
> > if (!spdm_state->authenticated)
> > 	return;
> > 
> > ...so that spdm capable devices can opt-out of automatic reauthentication.
> 
> Unfortunately that doesn't work:
> 
> A device may have been reset due to a firmware update which adds
> CMA support.  Or the keyring of trusted root certificates may have
> been missing the certificate for authenticating the device, but the
> certificate has since been added.  Or the device came back from reset
> with a different certificate chain.  Or it was hot-replaced with a
> CMA-capable one...

All of these are mitigated by pushing authentication management to
drivers. "Just re-authenticate" makes the latency problem worse. How bad
is that latency problem in practice? I do not know.


Return-Path: <linux-pci+bounces-35927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CE4B53AB6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 19:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA3F7B8300
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 17:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C636299B;
	Thu, 11 Sep 2025 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTu9MAOY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9148936209C;
	Thu, 11 Sep 2025 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612859; cv=fail; b=uG6YwP8BEygOlMrr8aGE4Vrb+p0WTtNQhbia9P3nfDvScWD7GUuX1Ay+hW1+nlHZ0YSgalpKxvdH0L0Wl/UlUrty0q5jR2LOtWDP2EZH5DU74oieYVG/Bhnvm+dzJZZgWSm7jc0kswsNAB1npa1S8gv04y8I0NNt7HXLLQU4a8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612859; c=relaxed/simple;
	bh=DxFFYuolaZ+PtG4yiuuYgjlnNYCvynsFsBDq9og6sug=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ivfhufg46NwQc7mJ/5Gm1ZagUF9QxTkDb1Szffas0vl6yM6Z64lQigqHoHb0XblJl9uxWBcA6ZVqrPTLWLXDeiyVjzJODSOInUXC372MgYD/H0ZSra/6AZ7okWiDtgmK1d76QEWNGBjdCOlcwRpaBipYmZ9qVCM4Q2BYckjn3h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTu9MAOY; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757612858; x=1789148858;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=DxFFYuolaZ+PtG4yiuuYgjlnNYCvynsFsBDq9og6sug=;
  b=WTu9MAOYQELCfZpMbjH5pnWT0HqKzHSEJTA1pDEYdsp7Au46Oojpm3JS
   Azqzfh8Vg7j8YoWFC018BLehlhWu2N4HuzsBtCRro6yueYiTgdQD4wqw1
   jkeO8mFjjg8Po3XGRQR17Xe97jkzDGDHmiMFTAhyr6j1axKYog2QDj5go
   jCAjV8kc59rAP9kpX3Vr+HqO/EZ0JGTQdPMKEzzumFxWYJkrhD8jSh4xc
   hedercPys46RQwgftth9BYelrXxXDnfO8S0zau0C4/1Ke3UaSNl1uSA1B
   YKV8Xop/8xG7V1p2J5SPuqcPYXpKyl9UJzbnt8ng2co8MQITvhFMRU1m9
   g==;
X-CSE-ConnectionGUID: uVa27fzwR0eVUKyBa/JxMw==
X-CSE-MsgGUID: bJDYzOENRe2QUG2AP+XoIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59812835"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="59812835"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 10:47:38 -0700
X-CSE-ConnectionGUID: gqyoaIsyQNmElSwPhJoZLw==
X-CSE-MsgGUID: xvWfA7RWS9GZZ+KI9bxxRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="178962000"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 10:47:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 10:47:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 10:47:35 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 10:47:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FopPr0Bp8MVZZTqqWLe4hm3wNTRR85H6LPkl1Aq432pPgzPwsjfPr0zTT3/F+DpTp/0TkDg5x/Xk4eafdoi3TO3p5bWO6jI9do+PMxrQ06WTftg4a7yPYKcgjPwehlfEangpQAiZFEaWJIYNvagFzwSw3En8W4GDTe9Sjd1XIq24Aj201L7xliMJoqLnCNPX64FfQ3brajWpXVKDa2GVlvvNq7W+mnNZqWB3dJIEZpC45tJzHotvHOOy2+uhAfiEWeh8R4tOW9Sh13UMidcu+Qfp9Jp+Wzkrh/w6nKOS/JWE1TygYsrsm6Z87FUy+GfamfrUEkey5zFGvGoWF2Av9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxFFYuolaZ+PtG4yiuuYgjlnNYCvynsFsBDq9og6sug=;
 b=FuMHwR5un+IKDnlPtNL4GC+dKBzF9TXO0vFF6ONENsniX88vPozSqL0H+EZqhJzSWU3+B1uHtGl2hCojcwPfPXihIDzBq1Fv6WE45K+eI2rXZJcpdaktZm7KBRgXmps/HQfr210NzymuMb2Uw4URR9zRprzBHMfa1xeHtXtp7X9WEsCUbMzQhEk/H9PbeXl1a5V0tfAxsNeDYL1mfhfEt5hc9XwRNFow09Y4+rGe8LCV28MiTna64o6TNtqivOC3bCQIrMXwEalpbq1XQz6PNSAAn/1Yb2rnTUkVCcuEzOMwZYtQe1wwDSb4GoXujI6LFYqB4ObnhyrZcObeR/Kkpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:47:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 17:47:33 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 11 Sep 2025 10:47:31 -0700
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Arto Merilainen
	<amerilainen@nvidia.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Suzuki K Poulose
	<Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will
 Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	<kvmarm@lists.linux.dev>, <linux-coco@lists.linux.dev>
Message-ID: <68c30b33acf05_5addd100e0@dwillia2-mobl4.notmuch>
In-Reply-To: <yq5ay0ql364h.fsf@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-35-aneesh.kumar@kernel.org>
 <d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com>
 <c3291a06-1154-4c89-a77b-73e2a3ef61ee@nvidia.com>
 <yq5ay0ql364h.fsf@kernel.org>
Subject: Re: [RFC PATCH v1 34/38] coco: guest: arm64: Validate mmio range
 found in the interface report
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0370.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a7ca6b-1273-43bf-dccd-08ddf15b493d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODhUc1VscWZYSzlFWWhQc1lwSFNFSnYzS2xVTWVOYUR6M3RtY1FkNFZSU2NU?=
 =?utf-8?B?SHJCL1dGZGR3elFzWTVNUDIyMmFmRmhoUm16amJNZ1hRUW1Kam5pSmh1djdn?=
 =?utf-8?B?elQ5N25IZUk3czdiaHN4NmZTQW14RGNGc1g2SDlybVNyQ3oxVkl2Mlp0VjlN?=
 =?utf-8?B?bE9rTGZmRjV3K2M3MGRXWG51RW4zemozMEEybE9HMGZnR2x1Y0Q0OTRzWTZF?=
 =?utf-8?B?aXU5R1ZWMnZyb0t1S2llZkZhWjU1U2VoVG83SkJINGo5TlpXdGJuVGMrU2Vo?=
 =?utf-8?B?cEwxdENmOW00V0ZlSjhhSkVBZ0VqRnJSM1VxMHBKQndFcGcwT2gzQzhKYVgy?=
 =?utf-8?B?OC9WVlphWHozRm9DTmNrYit5QU5WVmFXM2YzdTZrTDBRa1NBYnBCSEFWQ2JL?=
 =?utf-8?B?ZG1MdTFHeHhOOWhvVmI5SFFQSnFmTm9hRUtKYVN4ekRUeTU4eE9NOXlZcGMr?=
 =?utf-8?B?QlA3N1RpSm1SYXh4dnZFUDdsNFRoSFl6QU91TkRqWDN2dHZmRis2QzZvSG1O?=
 =?utf-8?B?ekR1ckNCZXBHd3ZwREtIYWFsTnUwWnp0Q3J5T1I4RU5kNy81VUhsTnlXdWZL?=
 =?utf-8?B?VlU1dVBkOC9PMFFObG1rRWdrdW1yQ1VxcldyUGRUc3laTnZSS3ZiV0NZVW04?=
 =?utf-8?B?VmRINmZ4ckM2WXVWTkVqb2Nya09uWlJnbEl5NG9uS1M3UnZwanJ4OGV1MTU2?=
 =?utf-8?B?b2pTUE1PVTRtb1NWRXQvR2FhNzRMR2lKWmgrZW1VOFh6RkJ4QW1HNmZPL0Ja?=
 =?utf-8?B?dys0ZS94WGNkZStrYlVoZWpvWUlQditPRnArY09ZbzdRRmFibmtZaXh3MDF6?=
 =?utf-8?B?Tlpwbnl2anI1TVRkQmx4T2REcFN0aDB3Vm1aN0Z1ZUk5TXJ0aUtVNU1kcSty?=
 =?utf-8?B?MHg4OSt5ZzFmaGY1bzk3emk4eTJDZGtBZTdDY1dJL05SYjBiM21mMjdBeFFw?=
 =?utf-8?B?RXJOSlR2NFRqdGIxZmF0Z2VzZ3RtVkQ2SUlpWE0xc0FkZ2hmc3hnaXlxdDlh?=
 =?utf-8?B?eHlJcnZ5VVg2SmRicXRzdlFmanRlWjhmcjBlaDNjUXRFMkZNd0ZuYUs0NFZN?=
 =?utf-8?B?TkZOd0NyYUp4QlJyT0Y2UHZ1SGdPM2IwbFlKYXk5Vy9HOGpTYi9oMHdsRity?=
 =?utf-8?B?Z3dCVTR5R0paUVVXTWtlL3IyTFFQak0vZHc3R0F4dTBOYWFRQ2JkbmJzMDRC?=
 =?utf-8?B?ZE1wUnE1S0tmK2Z3UlRWSjBlYWdYa082Q3BGZnBBdGNXTW12Q3pFVUp0YWx4?=
 =?utf-8?B?RkhGajJ0V1NncWxVOWlIRjZCL0svbjZvbmk5MDBqbFk0MU8yM2NVRFVNU2dQ?=
 =?utf-8?B?aWpGWXZsOE5hVTdZMzY1WlI4MGh5SFpoRWFTTUZqWDhPdVppaGw3cG5QQWsr?=
 =?utf-8?B?WlhLWXRoVksrTlY5MFl1OXdkcTd2ZENyY0YyNlByS1IxYVc0dWwyYStad3JV?=
 =?utf-8?B?QWl1cERlb0FuYTU5V2tndlBOME5qSWpwRnl1M1pOU1FoUVFZVHdoUUFxWGJD?=
 =?utf-8?B?ODF1VlQrbXNuR3llYTJCRTVjRnFHYmxWWXQzSUh3WHBHTkdMMzhFS083enFj?=
 =?utf-8?B?WVBlVituQUNpSlllL3pmK3NucnkrV0dqbWpRdG82V0lrVkM2aldKTVVXak9w?=
 =?utf-8?B?K1pNK0pxeFQ2NXJHUS9RajdFUnRZYUdLcGZ4azJ1c2lBUXFNNVJLYkVSNXd6?=
 =?utf-8?B?NjZ2RVhRMkdHcEMyZXNSTWFjM2pEVUhDWU1KU2RJcTQ4dU9RLzhFVkp5TldT?=
 =?utf-8?B?VStab3Z5RHZqNTZSbHFuMENsY0xFV0hZWk4wZnBZTjF6Y0M2bkhOVW8vN0Ny?=
 =?utf-8?B?dWovUDh1VzkzcVo1bWN1SmhKc3JyQVdkTkludXphVG9rano2NHBnUUJHWkxN?=
 =?utf-8?B?SUpqdHo1RER3SllFeEJuWDJGR2NkVloyNUpXalRqR0JidW56NXpvK0twbE1t?=
 =?utf-8?Q?GiBYa45uQHY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFFLUGtGdnl2M1hKVnZ1emR4MWt0UEZ4OUdFWCtJNmpIeWtnajdJZ2taTy9m?=
 =?utf-8?B?cFAxdGtTNlRHQWp2NTI4T0RTcUpnVUNNblBvMFkwcENUSkxJaFlkdzhWeDQw?=
 =?utf-8?B?UG4wa0laZGJEQWZaMmsrWXBPSWFZbnI1QW5PVVF6SStiU0Rlc2FwczJKLzJh?=
 =?utf-8?B?K3RYbCsrNlF6ZXdyMWZQZ2Fmd25abHlIRVJtOHlvV3QxOXI2Si9VcDlNUWMy?=
 =?utf-8?B?ckxUQ3IxbXkydlRReG5IRHBTanBjNmZvb2tlOFFRd0JLTUhLbmd0SzZxTXQz?=
 =?utf-8?B?OVUxeklWVHNaNGxQTmZwVzkzWnZLVzNBVmtieExtY2V0dVlPb1ZFUktrMnRJ?=
 =?utf-8?B?RzFyQ1FFbkRlam56VGRuSWtwazh3a0l1MnpJck5EU0kzS2VVaCtUc25jakR0?=
 =?utf-8?B?NDJUdnYxSHNseVZ2OWNZUmRCUU9RaXM1bFN6QlVqd0hTdTAvaDJ4cU1zOFA1?=
 =?utf-8?B?VGZ5bVI2Y1pRN0ExNi94VE8wbmdYeURVcGp1bjlqQ3kwbWhZaXJtUlFkdWpn?=
 =?utf-8?B?UUpCTGh2aGtKTE5tUmxaZzdtSlN2OEJrcWs3eFE4ejBPNUlyRldPQlJYV2VI?=
 =?utf-8?B?UlNNdjIyRmlZVmE5RGpmMzhPUE11SEJxNnZTdURvMDFsb05nRlo4R0E1ZTlO?=
 =?utf-8?B?N25Cdk9vSmoyRGhUMDZwZ1ZPMmpZWllZT245anBjdXhFNEFxK2wwZ0JqUEQ1?=
 =?utf-8?B?ZDg4cmZJSHNQdTMxM0RCU3JtLzBxSXEveElaSmNzby9pc1Vtc2NGNDFXc0ZY?=
 =?utf-8?B?TnFkKzFFeXN5TkhFWTRCWHNXcjBZY0gyaG1SNklnRTlDNEJUR3JUcXJhWHpB?=
 =?utf-8?B?dGFaR2Zhd1JPejhLaS9ZQWpNT2Y3QmNxZDI0ckVuVGpQdE5BeERhaG9ndkJL?=
 =?utf-8?B?aTZmUDdVWFArWU5aRFRrN2xvdVF0UWNIbHYzWVNpSWg4NU1zVUwrOWhya2xa?=
 =?utf-8?B?ZE0zMzJSeWcySTN0TC9TMFBMUUVPVkx6d2pBY1RtWUlsalJKUjVET1ZuMWYx?=
 =?utf-8?B?QXdoRTJVZ29MM1ZLTS90RzcvMFVqTTVQTlJMKzFSQW5sNlJuOTRDbnl6NEV0?=
 =?utf-8?B?OUQzZmZkRmo1cExsbmJSWWxUQ3o4bWIrZU93STBxOUwyMVFrbGo3TExUK2NY?=
 =?utf-8?B?V3libVo3S1llR3QyeGxQejJrNEo1ZDBiUzlydXF6MFdIZlBla3ZEcFdYaU1p?=
 =?utf-8?B?SENPRnhqS0IrZnVUVU9ickQwSE9FNGFEcFlpS2JkTCtDWjUrSXd1YkorN2xT?=
 =?utf-8?B?UEFpNGxUY3dZN0V1VUd4bHhHdDBLR3hjenJwLzN2MzlLVWNSWHdESE4yUnht?=
 =?utf-8?B?Vzc2VWJkR0FTcUptQ1ZPemk5L0xwRFIrd3ZweXNLdXRuYXAvTVBCdmxxQ0F2?=
 =?utf-8?B?WDRqcUtZNENpRkJWbmlLdFJ3Z2JQUG9rUkFiUWFxRkltMTBveXQ0WWl3S2FH?=
 =?utf-8?B?aVVQR0hMb0Ywdmo1WTJDSnd6NGFzUG5YcUVZaWRXRzAxVUo5ZjFmWGRRWXVN?=
 =?utf-8?B?Qkp2UXB2ZTFtbnNWZERjWHIyUnA1a0tlcHVyemp6VG90Q2I0NmEvL293aFls?=
 =?utf-8?B?UDNuYmVXMVE4eCs4T0VYbk1qNWVFem1NaWF5WS9EOUQ3Z29UTndjZTd1aEdt?=
 =?utf-8?B?KzgzUXE3SG9mQnJEdHBUS3RwMll4eUw0akNFVjBSMjBEQmhlY1cyYnlHNEg1?=
 =?utf-8?B?ZVhZK3A0cHJhbFp5Z2g2U3VBWVVmWGxqL3dyWGQzZ3lxOHR1SEp6bkpOV2tP?=
 =?utf-8?B?akhJOFBEK3U5K1NVb3JoTUpxa3RTRnRwOE1zYkFxMk1NZjdyQ0I1TWVaWTNr?=
 =?utf-8?B?U1hSM1A4aTRFUzhObHcwVDJEYjZJQTFoSTFmNzR0R0Ewc3ZucFhSdCtDd25Q?=
 =?utf-8?B?eFBzZjZ3T1dQTjA0OVFNVERuRW5PNXJlUkJtVERQdE01QmZidnRiZ1JUUGp3?=
 =?utf-8?B?U3pUbU1idFFUa1VWVzIrTE90ZTI0bjlWdUczdjlRcTJGeTc3MzQ2bk5rYmFV?=
 =?utf-8?B?Qzc5T0FVUTMxc0tHdVlJdWhQUG5DZzJtZnE3eUZNcEQ1bGpSY1d4RWV1ZmlJ?=
 =?utf-8?B?TENCdDFsVmtCajNhcWtwcFlCSHVCLzhvVlErNFkwbXpKZzhxYzhkbDBYSTRy?=
 =?utf-8?B?NC9MNEswQ2ZJRUdNNGFaSmdUYXc2RzRnTndMS2cwQ2dyM0dvL3A2RVJuWlRn?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a7ca6b-1273-43bf-dccd-08ddf15b493d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:47:33.1450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fryQ4/KgdvAGxHZsOlLbjuhEcbhIFeSwmEE8IiyrEenP07eux1qbMf+R04jfxk1xfNgCWPtfPH3jNx5MknpglqOq2hmSjrT9nZRFBLTnd+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Arto Merilainen <amerilainen@nvidia.com> writes:
>=20
> > On 31.7.2025 14.39, Arto Merilainen wrote:
> >> On 28.7.2025 16.52, Aneesh Kumar K.V (Arm) wrote:
> >>=20
> >>> +=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < interface_report->mmio_rang=
e_count; i++,=20
> >>> mmio_range++) {
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*FIXME!! units in 4K siz=
e*/
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range_id =3D FIELD_GET(TS=
M_INTF_REPORT_MMIO_RANGE_ID,=20
> >>> mmio_range->range_attributes);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* no secure interrupts *=
/
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (msix_tbl_bar !=3D -1 =
&& range_id =3D=3D msix_tbl_bar) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
r_info("Skipping misx table\n");
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (msix_pba_bar !=3D -1 =
&& range_id =3D=3D msix_pba_bar) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
r_info("Skipping misx pba\n");
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> +
> >>=20
> >>=20
> >> MSI-X and PBA can be placed to a BAR that has other registers as well.=
=20
> >> While the PCIe specification recommends BAR-level isolation for MSI-X=
=20
> >> structures, it is not mandated. It is enough to have sufficient=20
> >> isolation within the BAR. Therefore, skipping the MSI-X and PBA BARs=20
> >> altogether may leave registers unintentionally mapped via unprotected=
=20
> >> IPA when they should have been mapped via protected IPA.
> >>=20
> >> Instead of skipping the whole BAR, would it make sense to determine
> >> where the MSI-X related regions reside, and skip validation only from=
=20
> >> these regions?
> >
> > I re-reviewed my suggestion, and what I proposed here seems wrong.=20
> > However, I think there is a different more generic problem related to=20
> > the MSI-X table, PBA and non-TEE ranges.
> >
> > If a BAR is sparse (e.g., it has TEE pages and the MSI-X table, PBA or=
=20
> > non-TEE areas), the TDISP interface report may contain multiple ranges=
=20
> > with the same range_id (/BAR id). In case a BAR contains some registers=
=20
> > in low addresses, the MSI-X table and other registers after the MSI-X=20
> > table, the interface report is expected to have two ranges for the same=
=20
> > BAR with different "first 4k page" and "size" fields.
> >
> > This creates a tricky problem given that RSI_VDEV_VALIDATE_MAPPING=20
> > requires both the ipa_base and pa_base which should correspond to the=20
> > same location. In above scenario, the PA of the first range would=20
> > correspond to the BAR base whereas the second range would correspond to=
=20
> > a location residing after the MSI-X table.
> >
> > Assuming that the report contains obfuscated (but linear) physical=20
> > addresses, it would be possible to create heuristics for this case.=20
> > However, the fundamental problem is that none of the "first 4k page"=20
> > fields in the ranges is guaranteed to correspond to the base of any BAR=
:=20
> > Consider a case where the MSI-X table is in the beginning of a BAR and=
=20
> > it is followed by a single TEE range. If the MSI-X is not locked, the=20
> > "first 4k page" field will not correspond to the beginning of the BAR.=
=20
> > If the realm naiviely reads the ipa_base using pci_resouce_n() and=20
> > corresponding pa_base from the interface report, the addresses won't=20
> > match and the validation will fail.
> >
> > It seems that interpreting the interface report cannot be done without=
=20
> > knowledge of the device's register layout. Therefore, I don't think the=
=20
> > ranges can be validated/remapped automatically without involving the=20
> > device driver, but there should be APIs for reading the interface=20
> > report, and for requesting making specific ranges protected.
> >
>=20
> But we need to validate the interface report before accepting the device,
> and the device driver is only loaded after the device has been accepted.
>=20
> Can we assume that only the MSI-X table and PBA ranges may be missing
> from the interface report, while all other non-secure regions are
> reported as NON-TEE ranges?
>=20
> If so, we could retrieve the MSI-X guest real address details from
> config space and map the beginning of the BAR correctly.
>=20
> Dan / Yilun =E2=80=94 how is this handled in Intel TDX?
>=20
> From what I can see, the AMD patches appear to encounter the same issue.

Same issue exists for TDX. In the near term this solidifies that the
PCI/TSM core should not be assumining anything with respect to marking
MMIO ranges as private, and leave that all the to low-level TSM driver.

...but then yes I expect we need to build some common infrastructure for
special casing MSIX.=


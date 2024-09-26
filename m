Return-Path: <linux-pci+bounces-13575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E38C9877B7
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 18:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DE11F26CA2
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 16:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50821552E4;
	Thu, 26 Sep 2024 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5EB29I/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274D014A4E0
	for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2024 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368843; cv=fail; b=IoxZn+4H6snkKaewHuqoZjIJWfYfCt1Vzw5KmK7q5/VBm70AVt1/4iuY/yYXQ/+2Ijt9/9WHs9Y2uOPD1x4iiX7LefW26jF/QhjhT7ujrHsTCn7/67B8CvgotfWPYiVhBnbW0+tUJGHNrZU+x89bsCo32LSnH+CT2czGLa7oajA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368843; c=relaxed/simple;
	bh=Gn7AsBguAjUMEBXOAHwihR4kS3o5ENmRZgTKOJEo40M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WHIwHPdiVqJaGcQV14LO5SNtRWr64JpAsaA/e21h26Gojsq8WfHoXdN/18VF58FWJ/6dWjjHHNr60cfV26UWUlG8Hx/aLsf5Drs4qSDUSrl9uOPywcEBXvON6ojL5BpeI0wbM8PvAaCRUYfQSqHEp21UwY3E16ZdfJSig2ON8+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5EB29I/; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727368842; x=1758904842;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Gn7AsBguAjUMEBXOAHwihR4kS3o5ENmRZgTKOJEo40M=;
  b=L5EB29I/YbfKqXGNL+WWKC1gKVXeD96KBNiKHDF9C3XOXOm+8Zy29QRU
   FV7oL09osnjTUm3Fua10nq1OeX2AVrJiyza6huHlzbpOCcS5FOQwBVOgA
   oP1mOvrbBlcMNsXABmIYTV2XXYYx2fL033MooDsN7intkW5hsQSpb7e62
   sorPRAm+fUsW0VNv8vnjuRNt75uuwyLcc5VSCirD+1Ulg4hZUZ7EGoWk9
   6JY5oMoc4mHAsHbUhwyu0odxs76/HvUiNPVcRWJTAJdhks667lS1aKhjJ
   xU24/2GhqctZwfFBJ4/nLAw/bxIp7LDiCKP3/ejGkegHgincypddZ44bf
   A==;
X-CSE-ConnectionGUID: V70GZhACQYKboHJ+UbDPsw==
X-CSE-MsgGUID: tk0CWa+ZQwyyzQFhWZIHpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26642216"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="26642216"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 09:40:41 -0700
X-CSE-ConnectionGUID: ki4lieUtRpirGKuXmTnHEw==
X-CSE-MsgGUID: ygvW67LNRh6FH7kPCsvQHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="95564577"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 09:40:41 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 09:40:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 09:40:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 09:40:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 09:40:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 09:40:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EK8s5/f58zdU4sWNkPOWqVUq4oi4BWzkVRImvgQtuzBe6QRfAL8YDxVstIN3uKnBeQiqwJMFxphis9EiLD+zSSjgkbA/TjWVvwtCOE4t4Aw+nX+2s7FzDLqS7FvDnAA/YHj9eTBPoMbrxT5bTDDKE30oy445LMqQuV/5KrGFzuKVf1Cmzt4jjWugXvyd87FeeH+huWagbBq6IiuPayi9BxJqtB/kv8dVRATmI0sPth8Evxm1ApbOWmONHFfl6V3pwMnkcfqKtuWL7DIrfS2MddO2DBlEfJbPUdStGePeJQi96fC9pf+GzdZwOp1HPALQGPiiVE2INzxE+4YwzjekbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBKjwr6vps7nDW+5jiw8r5psFKIKAD3uN3LLl5Me7ms=;
 b=wL1jy1jNjYg7GNn0B9riko7NwFX2AWJGoAzf9pJhZhO4x+tM9qGxzGbHaNXGSxVq4uNzHYNgkVDDdVFJIOi6asPnCD2AqQpTDMooTOfAEzK41mOgsKH32c2ojffF6c8Y3sDD+efNRwN3lQBLX5YmeCurzHD0F4QYgB4IalbxXd+O11Fkg9579o/0yVDKo3dQvxRVOeaYlXMTxP5Z3W4tO0kOzamS1KHXGZnjneRjwopdHVG64q2PwWlPD9Hn+iBkmXW1YG+VugUl27QoPkRQHlCznyXjAQ+rhYGQiyex/M/L3HKkKgfAitC0KgqC2CP7+EZCjess8+TF5aw0Vb8/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2854.namprd11.prod.outlook.com (2603:10b6:a02:c9::12)
 by SJ2PR11MB7617.namprd11.prod.outlook.com (2603:10b6:a03:4cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 16:40:37 +0000
Received: from BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42]) by BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42%5]) with mapi id 15.20.7962.022; Thu, 26 Sep 2024
 16:40:37 +0000
Date: Thu, 26 Sep 2024 12:40:34 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/6] drm/i915/pm: Hoist
 pci_save_state()+pci_set_power_state() to the end of pm _late() hook
Message-ID: <ZvWOgs0Y9CN3aNac@intel.com>
References: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
 <20240925144526.2482-3-ville.syrjala@linux.intel.com>
 <ZvVzCbkfUkDb_0Ch@intel.com>
 <ZvWAndAvgfM6_eG1@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvWAndAvgfM6_eG1@intel.com>
X-ClientProxiedBy: MW4PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:303:b4::23) To BYAPR11MB2854.namprd11.prod.outlook.com
 (2603:10b6:a02:c9::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2854:EE_|SJ2PR11MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6d8b44-ebd8-414b-fea0-08dcde49f308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?sIBRl4ZFmj4w+QJzOrR+8+pElhFjYSdWNamA6sk9w0fIAEng+NimDXErTS?=
 =?iso-8859-1?Q?N633/R/sMMi9aUKf1pXqBAuwdphWxbsDLFkkD4mhoJM0kyWmnm+IWNpd/9?=
 =?iso-8859-1?Q?8A4mA+chBxc/DFoT0Cy4+82DDIvDNZADbtv4gBoTZdb2OS2sXySY6o7Maw?=
 =?iso-8859-1?Q?KcsVQZm7NP66kizKq8huVZVX0dib76SM2yl+jP8J0CEogEMP+mvhDpghJy?=
 =?iso-8859-1?Q?0HCbXRjdrj8Za+vpYJCS2fp8Hqvxsyc35BK3R4EFRIoYkANRSL2eDseSmk?=
 =?iso-8859-1?Q?XTzpFjRTySoqdjBhAgQ3VvUkrDwIdV/bvHdOxIfBnSPssq7BJg/iDVz8MK?=
 =?iso-8859-1?Q?+VgtEox2u+Aw4FXXAm1/T8ha1psEyO54Q6KN3zhTienLXZ8+a8PyrPkwLm?=
 =?iso-8859-1?Q?+PfYZy4ZbFg0a7kWIc/kkP4+EY2CBcfNKQPAMGrs/I8JLdgsTtq1+oJjrX?=
 =?iso-8859-1?Q?I4mF9eupIlwOAQkCyv7r0v8Tm22Kb4grzSgXBSMJZ6QLTqpTo69DtvaDAR?=
 =?iso-8859-1?Q?FFmAydJVhmPq6Pvn8lk36PXT22C+gwRRgO1LYA6nocNcbQB4phMWDQVi2B?=
 =?iso-8859-1?Q?8+zVfTe/u8fUCCfHW4adgO1Ln/I4p42q9NFJUziQkod2y+5OL4UW+L6EmS?=
 =?iso-8859-1?Q?khWBRQ4+K74IvgjYZ5O3FvBEMvm5+VKHAfBll10lhDxCPXClfq1fgzWjn2?=
 =?iso-8859-1?Q?ZPHVypJLzNADNxp1f+Y7DyP+zFlVgIimFQimFfanhFFSNXxSSFLIkJ6urX?=
 =?iso-8859-1?Q?Eeb52gd53ZwLJzD3t4LmLdPNL9SUI50Om0N7lz7pwn6BamIC74DvV7vGy1?=
 =?iso-8859-1?Q?xBCmELaoAYojk0JxJFHAdiDFP9uXd2Zn4kBcD85B+OSf6Y5duSujRnwjhS?=
 =?iso-8859-1?Q?GZ1qLo02++In5ZUdcM1soX4GoQrj7nhwefpC7FwM5hfShhPTgko2j/XuYn?=
 =?iso-8859-1?Q?62pDY3GrucebD9SWRyZufp0V5P4pD4klbBAe+dPki9m8ExXkw+KWvFUsMZ?=
 =?iso-8859-1?Q?HC74RTiMRqB8uUkiV5OHD+O3FAIjktHzNojBBLdPf3r6i41R7hptFvTneo?=
 =?iso-8859-1?Q?q7/GGsl62PZI5Fsp6d/2PuUqR1PwCVUhrBtjcfupWWdCk4bItyaVZG2b14?=
 =?iso-8859-1?Q?vEopaq5xzSfjnOgL9bc3Nw8W2XqvOYUTAPmBWN8kT++pLEpqtbbQrAZHQ0?=
 =?iso-8859-1?Q?ROYDNJnZGonmP4g3iAPnAO7hGtMWOhGYvVrpKHBgmZXKP2ykFQS3Yv8MkW?=
 =?iso-8859-1?Q?nTR37xs+OtXbW1yQAt1h1803+PpXqFnW8SSJogJU5wlE2Cts3yNby4Yx/V?=
 =?iso-8859-1?Q?KEipsLjRi6LrIPDjA9ZwtNGRQQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2854.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KmQTsMxgUg5A8YPqb+nfBZu4kmLwijY3jLswQ+751qd+cvrh3DvYZHEcYx?=
 =?iso-8859-1?Q?yxwN8HoJ+oZ7AALr+6jsodP6vbLop5nIIhs0rrtSQP6+Lo1lCiaJyGysAE?=
 =?iso-8859-1?Q?Of0YJzum321Jr+aRVU1BbDIZO+wzBTn7xT8EvWhkLafysZJjJI+3OX2SBy?=
 =?iso-8859-1?Q?5Xv/AVl9wRKENFHm+VbC/Ius2+9B13nrjgiincCOWxD9oaRx9Xg9PndSt4?=
 =?iso-8859-1?Q?G4zWuBZFVYXqVvn0QAy+FHti5c6Em72Kl8UpdmtZufWUdmKjn3z7ls8Ljz?=
 =?iso-8859-1?Q?8GmivPDJ9t5fuB0v9Zqzwi/NMRt1dx5Mt85SJujSRltcSwtV5VtPuLT4/f?=
 =?iso-8859-1?Q?B6bK6Dh4eIcYcCWkJnS5q1ZTvVHwnsdDBcnOeXbFBIqOW/2yTHx5bHkx3k?=
 =?iso-8859-1?Q?uw/SthaHLqnprzzVYqZCG4EQJtj//Mtv3bhJ0Stx+fj/86j/5b42HQborQ?=
 =?iso-8859-1?Q?eSD8VyP+c1pJmyQRCtwg2A3QQn7tQV0JdzT25gxkJ5qtbq4siucHMi3dQ9?=
 =?iso-8859-1?Q?1Ggcqq84zoncEm2T3bGN8BIcRbKzhto6YGKsP2yd3Q8EIC4B82l2nV8mZl?=
 =?iso-8859-1?Q?lnzvoQW247d/HIe8Bw3Zv/i9W/BQ+Ewe9JVf35J5UnEL2plYIq1y2/j19y?=
 =?iso-8859-1?Q?6F3ge1oRjXPOcJ/fqh681dZ48kiWrWVK3Z8Sp2/I+ww2//6hp7gHrnRqZ8?=
 =?iso-8859-1?Q?Vafaw1qGd6MrwlBpdrNAiliOHpA6V8UoZQaYyznmyU1lKU95hAspfLBtjS?=
 =?iso-8859-1?Q?Son7zJ9UkD+kTe48VAWV3C/qBByhJ342ZK1B3k0vQD0HXsg2Jbz7JLcDfm?=
 =?iso-8859-1?Q?rv+b/Yf1O8xYp3exdrEtZ1bcOFpYNHr4gyeplsma4NO5nqOow3OwrMLij1?=
 =?iso-8859-1?Q?a2ucXBo3qYjfXWbWxrBuAGrZDRd4cjALKebbdCCLr9OUx9sYIbA17tJpRS?=
 =?iso-8859-1?Q?LntZHtr7kc638Pb9/T7P+KaHy9O7BkUNWVCU7KzbGhX4ylisRyh9/gpvbV?=
 =?iso-8859-1?Q?PWmIYEEA7aXu4qV1xKMrJigXEPhDn/oRm+sirknWy8Rbzw+scIAtgvCA1a?=
 =?iso-8859-1?Q?BNHu/ty9y6bPRDLVmScgfaJd9ectn48jEfDuUJ76KRixjaGtPTaxtD7HJF?=
 =?iso-8859-1?Q?+gCVQWmqo1wHkNpWJHQN0oR/+dV4fz/ajrxD0aAhtiE44TC1ZmGtpRC5hM?=
 =?iso-8859-1?Q?MTAkJqXbZ5FBRZ1NOOB7/ZumGAQfPW/Rr+tz8V5ZhMYalOtL00rkosc3x0?=
 =?iso-8859-1?Q?TsR8EFQrA6aBehVoeYS66cJeTatFA9xruAOO2J8X9SVdaNLxitOYb7Fs/Q?=
 =?iso-8859-1?Q?6lbGqZBhpaq7DIaaSGHLE1GSBi2PEpYjHyqQSSja7NrGPi4VVweW4wFiNh?=
 =?iso-8859-1?Q?AmEsWz0T88Bq0Td2OC+2dskaX6Oh/U0vNQJb8fQj0OKEF3o+65NPALrSY1?=
 =?iso-8859-1?Q?Oit+wNpXC3c0aJCU4DsnB1Soc2s7p7xFuSCYG55/RSb7u+rOGEV8h9+ILa?=
 =?iso-8859-1?Q?6Sj1NYzRdrTv9MiJ+030j1e6UBML5GTXHifJX4URZX343ibu2vIHNnJfKP?=
 =?iso-8859-1?Q?s2/lRS06bEYgDkq3RSYzeBSbp2ZM/U7U7N4lyF36UHI0TEcT32N7TM/jw5?=
 =?iso-8859-1?Q?YmSMYDnwkcbK7MmD0kutEW3/o9yrILz980yzgR/GexmgBFbZSMxE27+Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6d8b44-ebd8-414b-fea0-08dcde49f308
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2854.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 16:40:37.3691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvFrGYV9/rXfQv0n4vbei+Uty0jJ8ZUd4iuAEaKKvpFjpaSeCCsQyR1L5D1wjEbW6TIdsop3F52n8mD2DRhjMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7617
X-OriginatorOrg: intel.com

On Thu, Sep 26, 2024 at 06:41:17PM +0300, Ville Syrjälä wrote:
> On Thu, Sep 26, 2024 at 10:43:21AM -0400, Rodrigo Vivi wrote:
> > On Wed, Sep 25, 2024 at 05:45:22PM +0300, Ville Syrjala wrote:
> > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > 
> > > driver/pci does the pci_save_state()+pci_set_power_state() from the
> > > _noirq() pm hooks. Move our manual calls (needed for the hibernate+D3
> > > workaround with buggy BIOSes) towards that same point. We currently
> > > have no _noirq() hooks, so end of _late() hooks is the best we can
> > > do right now.
> > > 
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: linux-pci@vger.kernel.org
> > > Cc: intel-gfx@lists.freedesktop.org
> > > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > ---
> > >  drivers/gpu/drm/i915/i915_driver.c | 19 ++++++++++++++-----
> > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> > > index 6dc0104a3e36..9d557ff8adf5 100644
> > > --- a/drivers/gpu/drm/i915/i915_driver.c
> > > +++ b/drivers/gpu/drm/i915/i915_driver.c
> > > @@ -1015,7 +1015,6 @@ static int i915_drm_suspend(struct drm_device *dev)
> > >  {
> > >  	struct drm_i915_private *dev_priv = to_i915(dev);
> > >  	struct intel_display *display = &dev_priv->display;
> > > -	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
> > >  	pci_power_t opregion_target_state;
> > >  
> > >  	disable_rpm_wakeref_asserts(&dev_priv->runtime_pm);
> > > @@ -1029,8 +1028,6 @@ static int i915_drm_suspend(struct drm_device *dev)
> > >  		intel_display_driver_disable_user_access(dev_priv);
> > >  	}
> > >  
> > > -	pci_save_state(pdev);
> > > -
> > >  	intel_display_driver_suspend(dev_priv);
> > >  
> > >  	intel_dp_mst_suspend(dev_priv);
> > > @@ -1090,10 +1087,16 @@ static int i915_drm_suspend_late(struct drm_device *dev, bool hibernation)
> > >  		drm_err(&dev_priv->drm, "Suspend complete failed: %d\n", ret);
> > >  		intel_power_domains_resume(dev_priv);
> > >  
> > > -		goto out;
> > > +		goto fail;
> > >  	}
> > >  
> > > +	enable_rpm_wakeref_asserts(rpm);
> > > +
> > > +	if (!dev_priv->uncore.user_forcewake_count)
> > > +		intel_runtime_pm_driver_release(rpm);
> > > +
> > 
> > why do we need this?
> > probably deserves a separate patch?
> 
> It was there already.

yes, but it was done in a later stage and now it is called earlier
in the regular path. I believe it deserves a 'why' that is not clear
in this commit message.

> 
> > 
> > >  	pci_disable_device(pdev);
> > > +
> > >  	/*
> > >  	 * During hibernation on some platforms the BIOS may try to access
> > >  	 * the device even though it's already in D3 and hang the machine. So
> > > @@ -1105,11 +1108,17 @@ static int i915_drm_suspend_late(struct drm_device *dev, bool hibernation)
> > >  	 * Lenovo Thinkpad X301, X61s, X60, T60, X41
> > >  	 * Fujitsu FSC S7110
> > >  	 * Acer Aspire 1830T
> > > +	 *
> > > +	 * pci_save_state() is needed to prevent driver/pci from
> > > +	 * automagically putting the device into D3.
> > >  	 */
> > 
> > I'm still not convinced that this would automagically prevent the D3,
> > specially in this part of the code.
> 
> You need to read pci_pm_poweroff_noirq()
> 
> > 
> > I would prefer to simply remove this call, or keep it and move it
> > here to be consistent with other drivers, but also add the restore
> > portion of it for consistency and alignment...
> > 
> > > +	pci_save_state(pdev);
> > >  	if (!(hibernation && GRAPHICS_VER(dev_priv) < 6))
> > >  		pci_set_power_state(pdev, PCI_D3hot);
> > >  
> > > -out:
> > > +	return 0;
> > > +
> > > +fail:
> > >  	enable_rpm_wakeref_asserts(rpm);
> > >  	if (!dev_priv->uncore.user_forcewake_count)
> > >  		intel_runtime_pm_driver_release(rpm);
> > > -- 
> > > 2.44.2
> > > 
> 
> -- 
> Ville Syrjälä
> Intel


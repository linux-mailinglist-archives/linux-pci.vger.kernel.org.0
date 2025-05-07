Return-Path: <linux-pci+bounces-27355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF16AAD841
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 09:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178521899440
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 07:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8419E1F463E;
	Wed,  7 May 2025 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7gRF6Sg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5220FA86;
	Wed,  7 May 2025 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603307; cv=fail; b=aXqw1ieOYyLhh+tgYyW8CWgu2yOz1BA2qDIWc2LLOeFyS0vA3Fyi9W7jfz8W9UPUXpzPHpJxuPl2PfigSJiF2HN0lao/OQ2sYs9vq2L1hmmFbZKWDtqDxI+ibRyboG3CcePhcdn0FuZr5rfTp6xkZeQZhFFjN0v6ciKb8AMno9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603307; c=relaxed/simple;
	bh=QJPHehvp1gyVM0pWgW/5sPtjFVmlXDeSgMRvU35q6PY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jG7d4B2wHJG2Tthh/bmNCzzN5FUd1JTCNo4jea8sGKI/HPaZEnxydLZWXU1YD1Otj7r4Q+J3QOZFQw6BozPi2PoIoFrLsoAhstlde4ukMDwoaYUTJPhp0N23pi5tJvHEVYTxBV+2gAhYPypMukZIYkJkR9LFv8kuFPq80IUbapU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7gRF6Sg; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746603306; x=1778139306;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QJPHehvp1gyVM0pWgW/5sPtjFVmlXDeSgMRvU35q6PY=;
  b=Z7gRF6Sg5VoE31pbg1eC+6GCiZFBY6V6DzJQ5mGU+5o2BAG3lkPMWxxn
   v9DZl+VhysH0zYdI0iw67iyk4USyXKsKE2ipLb9A8o9JLym9ZC7eu3gUA
   G1W/wyPEFzzUNOUQpDtk7/u9vGLd2NDrj38mo+BHUaY42eyMaqGqbkJLi
   USPFp0Xw8rJJu/2zhsOXJWoeSX6NaZZaXEXEBxvKRTBcdELVMXdZPTMb0
   6ZWJgTjjkcy5tNejRw6KLq6vBGsCxt0wbWK7RskBV/8/LboAn/DOjBu3n
   W/nQ/duyO6CByDn4/mOsnykzBhZNOZuDN+dtGBfAJuzLOUlc7q9stLyNm
   A==;
X-CSE-ConnectionGUID: JcOvVQfgT6aEUE8jsYva7Q==
X-CSE-MsgGUID: For1OYtISiOlkkp/8gvrXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47566822"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="47566822"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:35:05 -0700
X-CSE-ConnectionGUID: a82ExMtpQrmH4t8U798trA==
X-CSE-MsgGUID: 6gSgOd0ESzCuq6OPZ9Mc1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="135835619"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:35:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 00:35:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 00:35:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 00:35:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6wm0BzLeYBdqqZR55rVYQHa1KLUy0nwCFkRG7fyblMlfX9ibcxEP2JXm4Z3NnalWyIOMGDjY2nvHMnuPYll+vB9ylTChGWBq7Hs8aGAQOx3qFW2kYExfZzvTHfEtDIbLAuKRS/PaTh1yHbadNu16H9cYue5jpYiylAqst3iSZ+AHUJ9nHyb86qjz/gtuvJ4pwDXQthS4R0JIBQSAO32ED1M7oLWPhNXdhSUKgZZ0yiDzLlBbDKz2FFjXwtAJ0vqjr8QD5xhT5si+ddW1K6pAtj1u31pR/63uKZZFs92lOpligXLCYqzdYzvTSWS+VDFZzp0Bq+H41QxzRsBKcnh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJPHehvp1gyVM0pWgW/5sPtjFVmlXDeSgMRvU35q6PY=;
 b=QA92xaOZmU3Zo8p0QjxcGl93AiM4eDtgQUX1eTv32qGg/ybBwOWOWJyuoEYc6hws0cdjInd0PuhZnmWtliGfXROOS9bh45WhlPTJ0lLVpNvMQm8cNNIkFg/bpOFLbZgHEoVR5O1lO1M2wEDKRnlIWeFcN5fr/hgTGNZWATkTfjO5nfdkGYG95MVL4bulz2YaxNUe2Ehty/9ufSqRQbL8ngD2QyBEIolHwdYjCVHgojkl8FOmStVywVbxG5o6Y/ppzevCDrax+HnWQfMmSAGTVm7L/IwyVv5ex/WV0wmRu3ynlzirviPNz9Uabq4+a4+dfij6CgQBaUsUmFfLZZD4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8520.namprd11.prod.outlook.com (2603:10b6:610:1af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 07:34:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 07:34:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Dave, Tushar" <tdave@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 rc] iommu: Skip PASID validation for devices without
 PASID capability
Thread-Topic: [PATCH v3 rc] iommu: Skip PASID validation for devices without
 PASID capability
Thread-Index: AQHbvgLyee2inXEb2EiikYcInmoAibPGyH+Q
Date: Wed, 7 May 2025 07:34:49 +0000
Message-ID: <BN9PR11MB52763FACEE374AD5712E3C2A8C88A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250505211524.1001511-1-tdave@nvidia.com>
In-Reply-To: <20250505211524.1001511-1-tdave@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8520:EE_
x-ms-office365-filtering-correlation-id: 8748bfd9-3a80-470e-b837-08dd8d39a651
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?CVQyGQrr3h20XlJ4iIqYn4ag32m4SpWKaIJ94nd8t3Un+ZeRYyYYmKK3aBdO?=
 =?us-ascii?Q?1M2Y07QIV18aWBbSGC+rze+ts8qBMOJ9C6LaWtt85fn9stk54O6+ZZRLpbr8?=
 =?us-ascii?Q?BrwO0uNL5+eSBMHfDcdv6w4n8rAkvio/NAEe0l002Yb2YP4X3VVJkb/wk3O7?=
 =?us-ascii?Q?v8aJI+bwxM51FpKou0RyLFo8za1md1+4k/k0lr/eURxPLwl0LUtYirNTuqyP?=
 =?us-ascii?Q?U3GH6VTlPMy0uqRKfOOpQx697SsnCzw+ITqFcDdVbViLrzPUdge69Ny09Jh4?=
 =?us-ascii?Q?wfyeMzaFC2yDfSe6eUmuT+ykHoVKvKeOwXBqfyMDqjIqy0Afqbpcx8Yic03A?=
 =?us-ascii?Q?qPMfnHgE9JjRcqAai4ZB7m1hYv1w/OCflO2UC/wlegXwwotsLQfCPh7FO67j?=
 =?us-ascii?Q?XzcDAB23ko0ioNkLVs4WcAkd0umVsG991F6KNm4+1qdwzLj2AOl5CO0HzoD2?=
 =?us-ascii?Q?VmEggFK7UI5S536jWVw7ZXT4zPB2fdQcKEzoNYcJkPM/5sdJTYlHN+5lfvCL?=
 =?us-ascii?Q?9ylsGpYHq05DgpVPYxjgDJz5l7fVjM0s+eDlF1mr2RlaYoTmPOqF/1jQQQw5?=
 =?us-ascii?Q?MM9DdPM+QEqKuMxBocvhrMSuOQrmXikvdPz049391jadESxq277IM0jyCtK2?=
 =?us-ascii?Q?RfcamFkMHKS5pfm3U3VjPnW1dX+B5uafT/6wZX8FfhyxSDx7Crh0teGwq5JM?=
 =?us-ascii?Q?cXDlesfDuTlUxMEX6WH/WnRvtTznVs7nfrmve8D5aK89d3jjD7izzWvv3yWF?=
 =?us-ascii?Q?M4KWC+KQyUAIWoifb66o2DshOTUpMDhtQT7He/vwXgy1p3weDsHuPd4FPCWE?=
 =?us-ascii?Q?94NuWgIrVuSBD4M5dpBUr3DqyZ6Ej42VTfiP3Y7olwNOlkA1fp/Hyc7k8Vo+?=
 =?us-ascii?Q?PvWaHUoHO9m8fYRs4sIp7B41VCurPjBg5GSNe4TXR+RpjHKDQA+8rupA59GE?=
 =?us-ascii?Q?dd/QS/sZCzQ3BjCjOx6tEyqUJRK5AiiEcu1VOgNHOv4W5//3mSxrTQyANjWC?=
 =?us-ascii?Q?v5CHHK/ZoURLE4DmBhoZmzWh65L6/65R4X2RseGnsFZ2Mae0cU9DqOos5zHf?=
 =?us-ascii?Q?rvgGR+8Y4Mu/P+jx69zv3j+TvoIWENk0qQmX73QSdl3GClBbSzsiXsg/LWOH?=
 =?us-ascii?Q?F9/TIXRTBDOLSl5irXTyM6LVNU6ZL+2eXaGrFsVvjrGh3sBxOmF/0Efktxh6?=
 =?us-ascii?Q?np9u1738yLugrI/t3tYeHbuG6LuIUTzl7+6iUgR2LLmI2FXZaDFbQ0nHq5qP?=
 =?us-ascii?Q?f1GSS2t6BcUdH2G3KrVqaZ+oSBkuZbzPy8uhuf7fWVHHQb9cQn8F176w+M4Z?=
 =?us-ascii?Q?OaC+6AFNG0BEOkqazW2Jy2zMztq3R018SVXMTeZv5BI29OmL58z2juOkI+w/?=
 =?us-ascii?Q?Fyw6OTr3tzmbHseQY1q3nfqFFBsjadTYbJEEJjxzhLmccUqdfjzhySKhHAYf?=
 =?us-ascii?Q?ZuSQgOsPaFwraKGqTqL3Xt/5BxokHnna9rlRt97DPhiQJVzvzxYRCODUSnrB?=
 =?us-ascii?Q?pfBPa39fv3Muo7g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LNXN655x31qVkFTZlFwmJc0hVX9hs5NOpjCrrzOLXYgDhFHTas38yt885Rr7?=
 =?us-ascii?Q?0thNqdjWZsjc4zj+TtAWP3U/jvLIrRTY39+ncVB6aI7iue//Vku1sk8XzelE?=
 =?us-ascii?Q?RSSq7jVOFOb7wPRbwyuCJt6u1Z35gkGI8EEp3V6MQw/G4hf+wd8OC88EVDf8?=
 =?us-ascii?Q?gR4w4z/7xI4xkVQ7ntPLhznqUoN8TxMsGwMW1I4ddXwvXv1xRxJmb2giT0IZ?=
 =?us-ascii?Q?d3Sa/Pk8PdBX6FaxFWcwuM8gTwx9j3lG2+T9rr8V+LADRrkL9I1VCHquzy36?=
 =?us-ascii?Q?Aj4kKxHgToL5bA6FQS0p1TieiSzcN3gIYM4PRr4RfKmEdWlwYm4nX6Ln41Gw?=
 =?us-ascii?Q?USttFGvyhC1B0EEauIsT7cm4OHHUF93E6NbFNMZJNT9NyOU2xFVqpLJYlFQ4?=
 =?us-ascii?Q?QuxaqH1q/W0s4f/Z/9Fr8gYHJnaBHDthKBxNGwh5qQIDyNGx2b7j5Molyw4A?=
 =?us-ascii?Q?N4rhmbWCgGYqUcTTKS3DBompQo8L6qgGQIgDRtobhGIwDqLqCc2Pt0W8dI0X?=
 =?us-ascii?Q?HHZQKd0wRbyEI9sa4wIWYggfdp1KAGHJ2dOJBMbM8BPQs2BXkmAS2dh83GD2?=
 =?us-ascii?Q?fGCiMm4oJkYD2LCHOzjeoTlxP5djYhxuAw6IWwEA20+LHFaT2V/Qa/4GOhZC?=
 =?us-ascii?Q?e4N0DGeFQ8ysWc8FYSLroue3X/4M7JdiWDJwHQHxq/4Fo2LJiATgi2Z7T3Ma?=
 =?us-ascii?Q?GN6e3TRUokO8moiCIfoFnn5DsJBZQCdQhqIdZ6JrXM7E6vKo0dTJHhE0TKJy?=
 =?us-ascii?Q?HmEopEWwszKRORC4WhrgVTWPPnPb3eDzybNsTTkPXPt1xySVTSt91PsIotfi?=
 =?us-ascii?Q?vC3X8OGZv4tExBLBVbMJIlcTnilSH5C3b098tK8/mVOgSc+58Rq/4BPPjMxC?=
 =?us-ascii?Q?Lsj95eXYaQNPvPi1sa+AfMJUtwsw9VI21eSslDvrMEo+u6uQgrNMgXEFDvR6?=
 =?us-ascii?Q?wPeBr/81Tz6ruLyunmyT8C32vYtX3Z+n06SeLyn8Q3ZU4MtT/dH6w4PjYxwz?=
 =?us-ascii?Q?2388qzAbEIgwavDU2lD+aQzdEM6+MwwbInlctuSorW04L7tjkvOro4rNZwJl?=
 =?us-ascii?Q?Cdum51vw7XHVtwAS0Ap3LlQ9f9dTyEWF4rDESwmAfOTm0bbSmal2Lz/dMrnb?=
 =?us-ascii?Q?qJoP66gaUb/VujjsHR3EyOZ73pBB5r0mDrknJmQU7lvli3rwRDRNnbjTrL8K?=
 =?us-ascii?Q?vyoy7unwsVumrGtf1QPjHHGju+XJN4E/tio97DqHpTmBgh6hR8mEN9EM88cN?=
 =?us-ascii?Q?aHluBI11xQcozjhdQKS1beDRTTM7AdRCdh4IdscrqmHFA7aJhwXrGNOSoRXK?=
 =?us-ascii?Q?hkw/Mss9fwQ/toca7m0RHRS8HzBig+O3FzVRUTbAGREYqAGiNlbFjfPBq4J1?=
 =?us-ascii?Q?tnhxQWzSiE7QKj1t+3gmLf8hw422zc+IvoHBpXqSbcnaDeAh41Ncqd9jLXZp?=
 =?us-ascii?Q?xqcX0M1vQORbZW+Lqy8q0wP/SbyyE78ZrCrSMeyUwEHthgsusSxyFZjS4l6V?=
 =?us-ascii?Q?iic0/z6vY1pmJ5NOq/UfRIL61uWw4hoTzmNF9wa4sX2On13LDwspd1HZ6VAr?=
 =?us-ascii?Q?GHsDenNPMsfHBGjSbocwrlCWzYs9RagriWPi/Vs9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8748bfd9-3a80-470e-b837-08dd8d39a651
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 07:34:49.9004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3iSMkMfgCPDlUvd9DuFVkf60YLxc8Y/E4kDD0AQH1US2GzGCnOGiuUErP4RdgTojQIdiX+qG0sNJxRlg5zRAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8520
X-OriginatorOrg: intel.com

> From: Tushar Dave <tdave@nvidia.com>
> Sent: Tuesday, May 6, 2025 5:15 AM
>=20
> Generally PASID support requires ACS settings that usually create
> single device groups, but there are some niche cases where we can get
> multi-device groups and still have working PASID support. The primary
> issue is that PCI switches are not required to treat PASID tagged TLPs
> specially so appropriate ACS settings are required to route all TLPs to
> the host bridge if PASID is going to work properly.
>=20
> pci_enable_pasid() does check that each device that will use PASID has
> the proper ACS settings to achieve this routing.
>=20
> However, no-PASID devices can be combined with PASID capable devices
> within the same topology using non-uniform ACS settings. In this case
> the no-PASID devices may not have strict route to host ACS flags and
> end up being grouped with the PASID devices.
>=20
> This configuration fails to allow use of the PASID within the iommu
> core code which wrongly checks if the no-PASID device supports PASID.
>=20
> Fix this by ignoring no-PASID devices during the PASID validation. They
> will never issue a PASID TLP anyhow so they can be ignored.
>=20
> Fixes: c404f55c26fc ("iommu: Validate the PASID in
> iommu_attach_device_pasid()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tushar Dave <tdave@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>


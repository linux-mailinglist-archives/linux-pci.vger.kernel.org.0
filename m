Return-Path: <linux-pci+bounces-37126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668E0BA4FCD
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 21:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DD5625834
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 19:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770AE2737E8;
	Fri, 26 Sep 2025 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSIxJKbS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B481C28E;
	Fri, 26 Sep 2025 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916094; cv=fail; b=g1xNY9ftWnATyGqxl/4ZrjabWYtopqS2e5tOvBHkIkv9Ap4L3iraRkTKPDI+BRYNiuhmmCcyobuXSyN0ZsW2y/ud2s7qw9NDI+P99BdI5Ga/ukEFmoajP0Ra+wtian3/JNAyJA/9JBhoMWH35SHgy1/1CBHLpW5b5gzp3LKJKSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916094; c=relaxed/simple;
	bh=LU0Fpg9jiyHIR4gLp6pgQrpvixUctk69CAiwCaD/yi8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=qpBk4b0+llXgQU1kZrXzUKZm725NmNrawRd5yN6C3ipqe4rnqXZEfpsGr1HcnYVNYy3jt3B6K9u0ZHV9rGRIbuySweFVTSILf7oZkLR9N5XPAf0AVTp1y1BkVvG5tXHkjHBnsJ8hM9/ZP5Q2vOb9CsLEhaoYtRY9KktHO7kaJy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSIxJKbS; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758916093; x=1790452093;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=LU0Fpg9jiyHIR4gLp6pgQrpvixUctk69CAiwCaD/yi8=;
  b=KSIxJKbSlJpXd1Ibc1D333X7U+jqCdbY5KUL6nnZGTjPNXLKhTIQQ0OG
   5bC+sTwBL87/q4EAwYWTY1Jn5j5LKo4+CT9Kd/rf+E77A81fwh+0smROD
   DGbGDEQKyEzbGcDg8h0lEY5+6cmMn/UIsuJ+22G5cHdM8OGjSZzKQh1EC
   Q1yYKJyuivADzeJI2tyLRZyJ9030pFJcINnV5UwHFvDJJlyil36o/uxc/
   gxAyTYplcZpWrWMumwOLtrVsTLlkTr3HfgiZqapF4PhsiG3JVJmOtYP6z
   BuYR1zrjWhQPubHkXazD7dRv6ISLTMtDMvGY+vR/Xo5zC1thJNqUivRN9
   Q==;
X-CSE-ConnectionGUID: 8HFK894MRAu+G8EYMr8z1Q==
X-CSE-MsgGUID: R7FEpUzcQtmT3BeTnuVfig==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="72687335"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="72687335"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 12:48:12 -0700
X-CSE-ConnectionGUID: l40ZcjbhRBugOiDzv5YI+g==
X-CSE-MsgGUID: Jj1c6PQJRe6hXHf2vgdjzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="181997410"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 12:48:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 12:48:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 12:48:10 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.46)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 12:48:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEPypLJfaaB7xYm+AnTuGNeFV8zbj3ZUXMNbPf5FTJeDqdD4W4TF8mKVY7KK1QOc0YPZ+4G3ejSyirr6TqPuB4E43yv6zurNbnnku48cyBXbDvrC81+SbB8KIlg/dQzXs13fN9r+pvBcQasIwYKiKUKYfJwujy4Z+g6lQyKfeta/bGphdISniOD+ZEXrLeLXHr8YyR/kO6V9XRjNYO3e+KZiLELFxcIqafgEnNzIspNxGartUaPAHe4oKmdfIpRmSfZHjpT1KBDI6qDi8LhdO+EbQiZYbzAWr7Ie17BDRgbzg5fKrjw+LQAxzFglSH66cmrDQtZ/xw8AR7HfAdyG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7K3JErOSrZg3cpLnqYyHXtvaWPXcOOFpVLUjCUE731E=;
 b=zG6hNh2XOweGM5NT2eIaH1N/PcezmmXHCpba1jQj6qkrsaSnOmmT+akq3ER+ySGbTCI6b/tYYFgB+VhzeJD2U8C6zA+8O2+ZaiZGxgwY3DxVzpMmSNIBhTRErX/sokNzJHLIveuWdKPuPn+jHVBPl/QkgFP7Q41w8THCThoEhoH06JxdqfYAW4IieoC9TIw5tH5mZQkvZgvvenZhW1LRg5onoQ5iEBssvZj0vebe3h9to/KWx7vcrRxwCqC2j6Y2E22EKLV9uE1GqzwdtuSa9fKFPrfvwS1lWuZXRuaYDvxkzHGNXFwLXr9FaNpk3IGWRuAwlhn5aHbRl56BXsnn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 19:48:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 19:48:03 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 26 Sep 2025 12:48:01 -0700
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, "Linux
 PCI" <linux-pci@vger.kernel.org>, Alex Williamson
	<alex.williamson@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>, "Zhang
 Qilong" <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"Frank Li" <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>
Message-ID: <68d6edf1cab3b_10520100a5@dwillia2-mobl4.notmuch>
In-Reply-To: <2238241.irdbgypaU6@rafael.j.wysocki>
References: <6196611.lOV4Wx5bFT@rafael.j.wysocki>
 <2238241.irdbgypaU6@rafael.j.wysocki>
Subject: Re: [PATCH v4 1/3] PM: runtime: Add auto-cleanup macros for "resume
 and get" operations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e9f21c-b0e5-47da-8e12-08ddfd359ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXBQb0RxRlZ0OTNWM0x6RWVvd3JpcGJENlBQeFB5bGJrVnhOK1RTSlh3MXhz?=
 =?utf-8?B?ZlZlVEgvVlVRNzlqR0tGKzlOSHhMcGJxdGVaVVNjN2dQTldnekthQWUyTXBG?=
 =?utf-8?B?TEI3dnkyK3hMN1h4Mm16TkhXak5zakw5MGpXUDUrdHd2NFdXNERQQUtVWU5V?=
 =?utf-8?B?UWczTTJ4Y3hJYTRoMkNya0RFL2x3dGprMnFKaFE5ZFp5dWxnTjlaRitJOW1v?=
 =?utf-8?B?Ry9QczJSVi9KZC9ZWDF0UGZYL1laaVRkNVZWSDZGYUVqaGtjM3cyTXR6UmI4?=
 =?utf-8?B?MG04QUFEMkxMZWw2TGU3Y0FEN3A3bzQ3SnpLOStFRVgxMktXMWFiYXlNNUN5?=
 =?utf-8?B?empmMVN3UldVK0x1aENCdUFCRVFmZkR4UlJRY0xQOUlnRkxOc3NJU2VsSTRy?=
 =?utf-8?B?RE92eTBaY0x5bGNPRjdjNmY0Q1ZKS0V2MFNxRjdPNlBxMC9kUXUrK2IvSXlH?=
 =?utf-8?B?OERjclZRMFhGMW0wVklrRDczSW9xZ0trQVVjby9mYm04eGU0TUFzZzlJQkZo?=
 =?utf-8?B?ZUxpS3dsYXBiZGtKNCtDV3g4T29vSHloZGZWNzJ3V1NuTEdNYzhrbi9hbGph?=
 =?utf-8?B?bnR1YzNoNVFlM2twU1NWOFAyVXdWemc0WFZCTXBXZEMvYUFiRkNBUE9wc1lq?=
 =?utf-8?B?U2pCTkxpU2tzRm94eGIrd2ZsZnpXdStnUGxobTg3QUV3Q0NNSjA1ZXJFV2Fo?=
 =?utf-8?B?clFXRE9mUzRVLzRqK2VrMy90ZHZOa0V3UFhyN3k3YzV4aGlHemcwdEZ3anJQ?=
 =?utf-8?B?eGRPTnRkOHNTSnpKcmdkNjdvSE4yakpuOFhadFVqclFJYkRCTG14dlRlclJG?=
 =?utf-8?B?dG9YN29qY3lhdVRxRk9MeTZ5aWJLUndJb1pqdElRMTV5aHRkWS9uWkw4LzlI?=
 =?utf-8?B?bWZVNUprWFM0Z09OcklNOEE5VXlLdnBtekNxWk5ibExHZDZ0UktDNTlWblFD?=
 =?utf-8?B?bnJNMWJobW8wMTVVenRzNFNaanllM1pYclFuTkttVTlyeWN0NTVHWWFZaGpa?=
 =?utf-8?B?ZTJQSElkc1FLNkE1NmlUMEc5aFNONnlKMEhrNGdZOTh1aXFRV0FNOWFxMWpL?=
 =?utf-8?B?Ulo2d1A0NlY1aEgxZk5NZXdpSjUxWUdGaGp5c1Rma3F3OThtV3AyQnVOaUw3?=
 =?utf-8?B?NEVOSXhXQlRpTTl2TXU1bkNhWnVaalJoaldzT2dZZG9XQW9wMTFHUEFGTFVx?=
 =?utf-8?B?OG4vMVBOelNpVHQrdTVNMnpnYVhmeGRzTk9SclJyM3N2NzRIbFFzNmJtQzVT?=
 =?utf-8?B?TjVoYzhCLzNoN1BqRHRaVjc2Y2p3SEtSL1pSWStyVGpnTW9lbHVnc1V1cnk4?=
 =?utf-8?B?N1hJQVFKcDA3YWRPM2R5VzZsakFTbzd3TEZuaUZDaXBhRmo3U2NIY0Q1bTFN?=
 =?utf-8?B?WWJuTGxSZDEweGpwZzBsQmVsWnNuMlVOeGczSVpqd2xockRuVFc3Mi90bmFF?=
 =?utf-8?B?cU41NjNEVVg2SnJHQ1NIN0xRZWZjMzV2eUZEMXZsTkh2WlArODBkcXVucExX?=
 =?utf-8?B?VUN4VUo0UjcwTDI3amhXUmY3QmxiaXRyWE8yV012bnl1ZzVaMkNrcUM0Yktz?=
 =?utf-8?B?a2FBR3NmVEZSbUp2V0h5RFdUZWJpbXBCZlFYT0VsM0ZTRVBxdGliRENTcENH?=
 =?utf-8?B?aDRKbEVMZnZYbTQySnFGZjBJSm9ibUlQR05RZzdZa2haT25UUnE4a3lNUkNN?=
 =?utf-8?B?YTdzWXNuUGlUdTlFaXdzT0hHSkRkL3lRR0xHdmJvNlQ0bkRvUWVmSkpPcTg2?=
 =?utf-8?B?amFSQThGRkNPSWVjNnUxZW52b3VOdHpreUp1VjhSRlI3d0U5b3NSOHg5SlYx?=
 =?utf-8?B?eStKY1FwVExVVVB4Kzh5OHJrVHdHTTFRT3lKVFJqUlZtcDZBVytQWTF2TUYz?=
 =?utf-8?B?bVVhUmtteVRPT0E2NmYwV04vZXF5ZWdyV0FRWTh2cjQ1SjMvVGo2Ny9NMXEr?=
 =?utf-8?Q?6+XO/0qkilsql1lUgtmcS10WurKvqoYo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEZNNFZ4L3VtQ1JUdDk1R25NZ3BYeTlES2t4VEFrRnFuSmxsck1HZ1pPWEx6?=
 =?utf-8?B?bXhOQUlDTTZ1UzhwRUcyS3k0YWdXcVNBRHlPMTVVTGZpOE1PUmlvZDhkUGtY?=
 =?utf-8?B?d1NHLzZNVFd4OVV4Mi9KR2MrV2lTdCt2Q2F3NmdycXR2WFlKOEhnTTdlbzBU?=
 =?utf-8?B?Y2F6Yk5Hc2xrSGpHbVg4dWhnODd2amZjNEh3TUtqWjRraWFzRWRVdDBUTEtj?=
 =?utf-8?B?QnM3b0h4OExvOHF4U3prbmVLcWtXaHNGTEZZdStFSUZ0NlN2czRNeUUzaU5N?=
 =?utf-8?B?YzZhSzlXYXdzQ3VDRFhRajZvbDg1emJtK1U2RWQ1S0JpTFJOaUpWWnZZOWFj?=
 =?utf-8?B?OXIwSHpTVFNKanNsMlRGWll3Q3FwSDBRWFoveGpuNFJyNU50eXdtT0JRNDZX?=
 =?utf-8?B?a2lqYmJIcUZ4RzJ1SDZJZEVzRmRHanlOK0tDN1U5T2lwUWFSR3N3Z1RUczg0?=
 =?utf-8?B?U09qclNtSytpWldTVVNyQ0w4azQ1OGtpRVdxZWZPc1VuN0pFeDcySzg0K1RM?=
 =?utf-8?B?d3UxaXdhOS9vd0RQR3RxQ3Q4RjNPQ3lhSjR1NFUxdzY2aTBQbXhFc2xodXVh?=
 =?utf-8?B?NkNFTGtZMEFOaGQvTVBwUGs2UWZqRkpiWjRJODU3MHRsc1hwWWhpalU5bE9j?=
 =?utf-8?B?ajNFajc3R0FBalVYMjNkd1R6bm9lRlZZRlk0Z1owVTc5RS9qR3hib0RyQThM?=
 =?utf-8?B?WWtwL1ZEMWhsMDJsK1JsQlBmY1BGMUJ0SVZZaHRCamRaRXFMZnJxaHVqYWk4?=
 =?utf-8?B?bHpuT25KWDljamVHOFh4aDFhcDhTRHNjY2wwRlNZLzE3TFVrMXRjeGdLa0E4?=
 =?utf-8?B?LzViU1VkK2wzT1hTazJNaUNpY0IzTlJkVW9TbnA5VEhodDFEdks5SVZjbTR3?=
 =?utf-8?B?a3BGY051alhuMVlhMWtFcWpNenJidEtPNTVUZ3FrbXFBbEU2N3Vha2x6SWlM?=
 =?utf-8?B?UlV0UmVmSDB0ekhMRGdOMTBQNkZnY0FyN0VTdmorK21jeUl6d2dUQnZ3aWFI?=
 =?utf-8?B?R0tydVVRcHF5TThQNGc4WHB6LzhzbUhOL2FlUkVZSlBGRWc5ckk4UDV3bmFR?=
 =?utf-8?B?bEJkWmlhNXRBTW9CY0JTZDFYNUpVSHM2VThtNGlSanFZUWw3SSs5VmN5Q3c0?=
 =?utf-8?B?Z1VsWHpCT2FpcmpqK3M5Q0Rlb3NVRHdzTFFCdmRSZzM0MTlyUG5xWHc5dEEw?=
 =?utf-8?B?WThXTmIzSmgzUXFDUDJmYmh2WGFJUkZ3ZGFFZHByQjYrb25XMi9IazlNOE00?=
 =?utf-8?B?bGRFODlib0JmL1g5OCt6SjFlTktSNmRqcFFxekR0cm9TbitKQ2pJS2tpRWlK?=
 =?utf-8?B?c0E1SmdMUzQyekkrTThBUTNFY2JQaWFtS3F3b3VPQnk0WXFnZ0lQVDdEeURk?=
 =?utf-8?B?c21ycWNkS0hWNjFLOVhYWlgwaFpONTRZQ1hHWFV1eU1WQWhyTG1PZXZpalZH?=
 =?utf-8?B?c2hnK1VMM3lrbXpjV3JwU3FYZmMydEZLaHdsNG1OOXIvYldTS1JYNVBlV2hC?=
 =?utf-8?B?N29SUXRCeDduWGZTa0k4dUxhaWs1RWkvYVJhWCtmWEEwU3V6Y2hEUHRWbWpN?=
 =?utf-8?B?RXphYklyUXUybzRydFh6NGJTNStZcGZDRktNYUsrcFBvREt4MXJHSVM1WE9q?=
 =?utf-8?B?RXREZUZCRHRJVTRkQ3NncWhrbEg3OHIrR2V1cDdrSW4rYmMzazRIRXVOR2tX?=
 =?utf-8?B?RWtLa3dZQ1g3M2o3WFoyaEJPWkRRV2V3U3hQUlUrRWJNbnprNTRmdDZXUnli?=
 =?utf-8?B?RnB6WjNxMnp6Z1lOZnI4VVJSY1c2aHQ3aUtnUlN4dXVYU1JVVSs4eCtEdFVB?=
 =?utf-8?B?ZlVnRmhId1hVcVhNMmVQb0JXc0IrQ0pPZk9sSnRMV2ZNZk1HUkNaL3RpUjAr?=
 =?utf-8?B?Q20zbkhPWFR3NjI0NHUzMWd0QnJ6SGl2bHVSbHJJdXlaajlOVTJKN2QwOVgz?=
 =?utf-8?B?Qk1aK1hpZVdnSFBLb2lQSVg2MHNaNDYwZXF3NEs5Z2dZK0FGSFFTRG1EMmNW?=
 =?utf-8?B?dURURmZwYnIwMVZiQm9Ic0pRU3VSclZTNFhPQWRtb2pXR1UwTlRaN2RSZXRP?=
 =?utf-8?B?blhkNTVydy9zeWhEd1FmczVNdXNwNHFZUFVBTHdHbHlLYWRHNmk1alRrWlJ3?=
 =?utf-8?B?U3U4MTE3MVhzc3RmRU5QNVNaMU9CdFhkY0R2ZUt0VmdPcmNrWlZvN1Brb3V1?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e9f21c-b0e5-47da-8e12-08ddfd359ad1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 19:48:03.0505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uaycV98H+zhQKQGsgfC7iPASjfBg3qeuI/voGUfF51Mu4gLsi26moU4RVqQUsN0Mo/UiXiUKJFiFZxZqX3fwsLUORrT8U41P0+Xn9bLKw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com

Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is generally useful to be able to automatically drop a device's
> runtime PM usage counter incremented by runtime PM operations that
> resume a device and bump up its usage counter [1].
> 
> To that end, add guard definition macros allowing pm_runtime_put()
> and pm_runtime_put_autosuspend() to be used for the auto-cleanup in
> those cases.
> 
> Simply put, a piece of code like below:
> 
> 	pm_runtime_get_sync(dev);
> 	.....
> 	pm_runtime_put(dev);
> 	return 0;
> 
> can be transformed with guard() like:
> 
> 	guard(pm_runtime_active)(dev);
> 	.....
> 	return 0;
> 
> (see the pm_runtime_put() call is gone).
> 
> However, it is better to do proper error handling in the majority of
> cases, so doing something like this instead of the above is recommended:
> 
> 	ACQUIRE(pm_runtime_active_try, pm)(dev);
> 	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> 		return -ENXIO;
> 	.....
> 	return 0;
> 
> In all of the cases in which runtime PM is known to be enabled for the
> given device or the device can be regarded as operational (and so it can
> be accessed) with runtime PM disabled, a piece of code like:
> 
> 	ret = pm_runtime_resume_and_get(dev);
> 	if (ret < 0)
> 		return ret;
> 	.....
> 	pm_runtime_put(dev);
> 	return 0;
> 
> can be changed as follows:
> 
> 	ACQUIRE(pm_runtime_active_try, pm)(dev);
> 	ret = ACQUIRE_ERR(pm_runtime_active_try, &pm);
> 	if (ret < 0)
> 		return ret;
> 	.....
> 	return 0;
> 
> (again, see the pm_runtime_put() call is gone).
> 
> Still, if the device cannot be accessed unless runtime PM has been
> enabled for it, the CLASS(pm_runtime_get_active_enabled) variant

Leftover from CLASS() approach?

s/CLASS(pm_runtime_get_active_enabled)/ACQUIRE(pm_runtime_active_try_enabled)/

> needs to be used, that is (in the context of the example above):
> 
> 	ACQUIRE(pm_runtime_active_try_enabled, pm)(dev);
> 	ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
> 	if (ret < 0)
> 		return ret;
> 	.....
> 	return 0;
> 
> When the original code calls pm_runtime_put_autosuspend(), use one
> of the "auto" guard variants, pm_runtime_active_auto/_try/_enabled,
> so for example, a piece of code like:
> 
> 	ret = pm_runtime_resume_and_get(dev);
> 	if (ret < 0)
> 		return ret;
> 	.....
> 	pm_runtime_put_autosuspend(dev);
> 	return 0;
> 
> will become:
> 
> 	ACQUIRE(pm_runtime_active_auto_try_enabled, pm)(dev);
> 	ret = ACQUIRE_ERR(pm_runtime_active_auto_try_enabled, &pm);
> 	if (ret < 0)
> 		return ret;
> 	.....
> 	return 0;
> 
> Note that the cases in which the return value of pm_runtime_get_sync()
> is checked can also be handled with the help of the new class macros.

s/class/guard/

> For example, a piece of code like:
> 
> 	ret = pm_runtime_get_sync(dev);
> 	if (ret < 0) {
> 		pm_runtime_put(dev);
> 		return ret;
> 	}
> 	.....
> 	pm_runtime_put(dev);
> 	return 0;
> 
> can be rewritten as:
> 
> 	ACQUIRE(pm_runtime_active_auto_try_enabled, pm)(dev);
> 	ret = ACQUIRE_ERR(pm_runtime_active_auto_try_enabled, &pm);
> 	if (ret < 0)
> 		return ret;
> 	.....
> 	return 0;

I like that this appears to unify the pm_runtime_resume_and_get() and
pm_runtime_get_sync() usages into common pattern.

> or pm_runtime_get_active_try can be used if transparent handling of
> disabled runtime PM is desirable.

Do you think the above should go in Documentation too?

Either way, for the usage of ACQUIRE(), looks good to me.

Acked-by: Dan Williams <dan.j.williams@intel.com>


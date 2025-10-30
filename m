Return-Path: <linux-pci+bounces-39853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAFBC225F2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 22:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D7E3AEA67
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 21:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20587329E52;
	Thu, 30 Oct 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JneNIm1q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478834D384
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858238; cv=fail; b=I/f/Uth5P/GD8aiZzSKqLZkIiQR6OxXSbP1k+PZyRGtjOqaH8JoQgS1ZxGkjyk8IfW7pMEUEPNrxvJSW2z7ubHN5nx+8ZKX0lnkaxEzQZK+32VU0zFNApAQXfun+L5k3yNdfMpqV3YC8MFNKTguW4Tep4NrmLShj9SjNkglBXfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858238; c=relaxed/simple;
	bh=dw9T9jztOz7OnsdnE83f7gn3UdluZDlLyCdtmSRHJwU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=RuSFTqFHcTjyImhPyJyawzgB3Zze3cf+iEQyt4JIZnouefaaLmUMXNafJXYzO4ufmeT5JUukF1ZajrrilX3lqxzRf1Ry7aWZ8ZofthvkEX6+JmEqYPlWGtWtO2UOLpdTomoTUv3ArnyxM/6y1XEm4z2p1mvCWZJydqp6T9Ypkhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JneNIm1q; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761858237; x=1793394237;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=dw9T9jztOz7OnsdnE83f7gn3UdluZDlLyCdtmSRHJwU=;
  b=JneNIm1qTiZ3z2M4ahkdEV4MfNd/UWgGHqRZzMu2bmJUbZ/XZyPDx+vP
   mkOodbDEQOopJnKVJvRyeXBBkWG8wyGgwKQuTnn661xxMsjNpy/dkUxB5
   tt4xiT4sDe2t+jsIIcrwb6Y6kdav4gacGSuZv3E5JdJnVDUVLFiUr5DmF
   Ul1+kcSym82A68IubqNGSpSAjtDA8PyN+jXSxsnztGauxMo7Uq0kS5aF8
   ZrEcT7iBALsQFMPK7ARvViwcLBxjc7Cj2kCjbI3G5Soal7XUz01cHMwMo
   O6BSE/I+YzGyeFqjSVKZefWgLK4egIByTus2smlGnJf2sdkznjUTlw2VI
   Q==;
X-CSE-ConnectionGUID: oTrl8WE9Sz6FnIZD1SXRrQ==
X-CSE-MsgGUID: 0AuNoQSLQHqKSaH6XMBUJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="67667026"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="67667026"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 14:03:56 -0700
X-CSE-ConnectionGUID: Nam7f6RvS/mGD8Ui+6pGtQ==
X-CSE-MsgGUID: IBk5Dt4JTY6mT6cOzB8z2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="216712971"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 14:03:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 14:03:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 14:03:54 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 14:03:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqKaf5m+7XM4GLbSmEMP48FUEptRFHHtxcBezTKBOmpmQagWQn37x0QIvWa+m+w5ANd1aArUOETsxdTfXjdwOtKGvQXr6pbaQ9WS7nJNXCbCoG1NENRjEOZciM+sLitpVTZGj1saFpyc4MGn4/kQTkY/qLvqm4KaeFiUXpOeaiHfCY/TGLt7NPqQa+ScFkeFcd2ALaj4uT/yjiTfPAJxDAaoRM7fz5t5amDeBWyDonumL06IUksl0T0Yw+DmVMa3wWmKW2bQy1a8myeNhNFq/A9FgaOtDq/CaPh5vftLDG7IwXnJ5K2jnQcY0AWC0F4eQn0oTz1L1tHsyxIEf/2A2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BdOkhD2r4iNqiGBEhc+4Ev4Lqe0LwjkrzdVdGkaS50=;
 b=WhoWyuJnasLsZ+YFk2kkUqElvztTVEl6mW1WWDC0/LIIp8IZo5R/CyIoMvJDaERi+cDQKdb75yg4dQoWAv9FMMeL85TUp0kdR/XYKYIzbrjgE3TBko78LPupyuk4clBfM7ah+QCuwF+hffCncxD24asHcawHGzP7nMi0ibuMbplqmaf2e79V5gItyXr/fL5U2LJmfmLpTNVBbusYrsiNTaqG82DX19cl9IUHN6ZTAc+qRe6F38+OSngk87VSrcnJzQ4fOYXVnSJdEscihjfACrD3UA9hFhLwhlaaGbBl7fbYF49dh6LBUbQer/rVXaybedHjA5Dtsffjd00RfpBPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7029.namprd11.prod.outlook.com (2603:10b6:303:22e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 21:03:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 21:03:52 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 30 Oct 2025 14:03:51 -0700
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>
Message-ID: <6903d2b74aeea_10e910092@dwillia2-mobl4.notmuch>
In-Reply-To: <20251029163438.00001391@huawei.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-10-dan.j.williams@intel.com>
 <20251029163438.00001391@huawei.com>
Subject: Re: [PATCH v7 9/9] PCI/TSM: Report active IDE streams
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: f7861225-2788-4de4-6025-08de17f7d437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmMyaVliY1FsTGlYRUl1UGZ2QXE0aVBnelBUQk5NQ1paSDl0d3NvMzcybjda?=
 =?utf-8?B?UWlZenkwTXlXTEN6N1YyY3F2cVpyM0lHR1hlaXJXSjB5ZFpTK0wxQ2V3V3Rx?=
 =?utf-8?B?d3MzQXVjKytxNHlSREhOdU1hODY1ejFTZmZmZFZQREpTNlNkK3VBOU9VNnVp?=
 =?utf-8?B?SElTVzRvNDZYM1BMQXlHK0tIaVNudHdJMzVibHQxMXJkZFd6d0FKSUNMOHJO?=
 =?utf-8?B?SzQ1LzBIV0hkWmN2eE1tWjF5NFo4a3UrYU10Nk05djZIdnZ4VHUxWEVmWjEw?=
 =?utf-8?B?Z1hRTFBTL0t1emhKNjl4d2pDUlZOMG0xZkZ3VW5OaWsvOEJQdldkbjMyWkNp?=
 =?utf-8?B?bTBjVU5USDM1UVlFRWd6WW5zR3JwV1N5RzJsQ0toVmZ5czdWRmFFYjJuYi9B?=
 =?utf-8?B?c3FRemppRCtORDhwMzdVQWx5ajAzcHhYSXV0aGZ2ampIWG5XdVlrekZFQndy?=
 =?utf-8?B?VENaZzQ1K1FEMFI2aEN2dGcxK083M3NNWjY1NWR4cW5WRmg2NFlqYW9Fa3dy?=
 =?utf-8?B?MFJ6cHQ1dE9zYnNxVncvOU1NR0RweXNyb3RWY00wUWs5cWxRNW16aVd4MnZl?=
 =?utf-8?B?aE4yNHZTdnpWRWxDeGs1dk9nc1FNdnV1a0pBT0lDanBQZXBxcldSTDV4SjZC?=
 =?utf-8?B?QW0yZ1Mwcjl4bVZHeHl1Z010dW5UZml4VGdETmxzZlUvOUp6TEFVcFR5NUwx?=
 =?utf-8?B?TnROWWFoeWZiTEpKZFRmWkxIZG11b2xVVnk3VU5iVkpSWnZVRWNhWCtxREd5?=
 =?utf-8?B?akxwcXJPcnR5Nmw1bzhMTnhtZ2hGdDJuM1QyUnY1aDA0a3BKZzVwK09DVXI4?=
 =?utf-8?B?TmZpeS9yQWx0dFRqbGhjOEpDaW5nOFhDWGNjVXlIUTMvTjNCa2NVbEdJaWla?=
 =?utf-8?B?cFJrMmVrRDl1VkZ0T1AzQkVLTWtxR1VYOHVuSzVGZzF1VkdKRmFWSjdMVEZ2?=
 =?utf-8?B?Q2FBWGozbGdOVnAveUp1M2h5a1BmNjU4NjBMU2pkYlhNZVdUMkhkNmVaSEpG?=
 =?utf-8?B?S3JZcGZHNmdDK2dMNHZhWU5WTEhiV1lRK3BHZGxZY0xqT21HTWFIbDM3V043?=
 =?utf-8?B?Y1cyOTl2QTNEN0d0RXpUUU5rNTJueGduaCtyb3dWMVY2bzZhSkhuTWpxM3Fw?=
 =?utf-8?B?MThZd2JLc01Cek54OHpFUVo4UG5uMklOcG85OWd3ZzZCOEpEWmVlbzVjZHlL?=
 =?utf-8?B?UCsyZllNMTY2RzMwTFVqUVFFd0dLMjBDMG4yYzRjOWlvYWVOeExrUmpMNDFW?=
 =?utf-8?B?RjZGVjhDS0VhTkFNSkNjcjk3eXdiVXdOVXI3QUNEaE52cktYZkcrMGx2MFd2?=
 =?utf-8?B?SUc3ZzZDeE1ZZ2xFY1Q1Y0hhR2VUbXVwbUtNMUc4cFRhSThQYmVib3ZzNzdy?=
 =?utf-8?B?Wjc3SDU1eHNmdllGaWxUT3YvSUl5dnZxRkk1NE9yMkhvcUZrZmNtQ3ZmRHU4?=
 =?utf-8?B?bmdBUC80TERMSGpMcXVlaEFCUmV6RHpNYVJEWnBqK1NmODFncWk3Rmc0ODl2?=
 =?utf-8?B?YkVPZDJnVlFoWlZQcjhVQlF0WU11MGs1ZU9rV2NMdnRNckE1Q254Tm5WOGZz?=
 =?utf-8?B?enR1N3Fxcyt5OUk4c2JIM3hJbG5hbS84Q2l3M21DVFRFaklXS0xmclpLWnhK?=
 =?utf-8?B?Qk1RYVpwNGRYVVFvWDRFTUYrcDNlNGYramxrRGo0aldUWktaVWR3NTkyOWtN?=
 =?utf-8?B?TU84d0JQTW9zc3J1bUFySGVDcC9BTTV4WWdhL2pEQW8rRm0xMHNlcnUvNWRi?=
 =?utf-8?B?c045S0Y3dGhaYXYyN0h1NEthYWdlVStIbkJ1akt4blBzKzlPT0NWdE1qbENT?=
 =?utf-8?B?MEdmSmZzMUJKZ2RNZlpmTDJ5S2ViRjJJMExjU21xTjY0Z2dDeC9iRUFKc0V3?=
 =?utf-8?B?eHlhU2lPUHZFbXNFWS85ekUzcjRtQndOM2V4cHF2dnhBaTVqSXk5SS9UZ1pR?=
 =?utf-8?Q?lsnfUSFovKu6CXkPfTrk7hytV5AUMcDa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWNKQWU0TlNmVmVLRXJvWGpQR281TnR1SmdTdzdYLzJQQ0FPSDdnUmhvZU9R?=
 =?utf-8?B?d1E0Z3F2RnNVZ0VEcklvR01YMGRqdDBVdjlMOFFlcE1CY0Zha0Z2WXRIVjVQ?=
 =?utf-8?B?UVVUSGFIalJ0Q2JQRTEvS3JYNWhlbmJXVnl0YzR2a1JGb0hqa3pnR3VPR2JH?=
 =?utf-8?B?R0RJeFo2ODdMckpLRVd3YjNzQ3NlOEZTM05nNmpFZG9RTzh5LzNOTnFROTc3?=
 =?utf-8?B?R2h0cGNMemlDZzA2TVFlWlE5RkpOZkg5cnpVUDJBYmJ6eTNlMm9mSTI5c0hr?=
 =?utf-8?B?enRpNG15UUtBeFlFWEtJclBNU01Oc2s2STlmZTBpancySFBaVVdwRTZpbkZU?=
 =?utf-8?B?azA3TnBkcS90c2ErZUJpUFlWN04xL3NQdTNSQzNZUHFRK3A3Zm1DMnFmQmxJ?=
 =?utf-8?B?TGJhNE15THJXcHpYTFp0clF4WjY0V2dRT3RUV012QXNTOUhZc0FXYklKcEhB?=
 =?utf-8?B?VVM3Q2VuWlVzMmFJOWpMdlowMGhiMlZXQmhaTHhSWTN3YUxBVGhyaW8xNCtO?=
 =?utf-8?B?T2hGa3FjM2haaUlsVGlRUk8yQ1NjYSs3ZzlCQ3ArY09Jc0kyL1MzSjZMUzlG?=
 =?utf-8?B?c2s0Y2tmR05NTmg2K0w5NG5SVGszSkRkOEp5VlY1c1hoZ2dxcHJSYU9hWlVo?=
 =?utf-8?B?eUovN001MUdFUHVhY1JFeDJnbG1yUGs4UVN2NTVQYWgwSFhDbS91cXNweUJV?=
 =?utf-8?B?ZXdzL28yYjY3K0VIMncwSWQ4MCt1d3FyYVpWMVpEcElGdnFBWmduVUVjaExr?=
 =?utf-8?B?VVErS3pWVjltVXdhd3VyU1BSQ3BjVVkxVEVqMitQUWVEYTlza3B0SG1tdTYw?=
 =?utf-8?B?ckdyVE1iNFBQcGF1cWJjS3hrdDRYTlNiUXUvLzQ3Q01IYjNXOFBxeWhSTis1?=
 =?utf-8?B?MTEvelNWaHYybGFwb0lQOGtxc003MkpyVE1SRFM3eFNCSXlCd3F3dUpodzl5?=
 =?utf-8?B?QjFSeXpqL3pWY3ZhaGlLaE5yWEtrSkdYTU5ycVJSNXk2WUJmU2NubDBHKzBs?=
 =?utf-8?B?bHp2REhyNnV5MGlYdW1hamRhUlZKWWphWVFMaENJdFNaZG1vY3RSRnRhbjlF?=
 =?utf-8?B?dE5Id1JkRGh2NC9GMXlodVVUc05GbThzQ29XQzdMSllqNXB2Q01UNjNFVlZ1?=
 =?utf-8?B?SmtWT0Nod3FqdzFOSmszQlYzSFMyM0E0K3dBWDJrUWFmK1BXeDhiWmw2aVZL?=
 =?utf-8?B?TnJvMGJyUHBraU9pWS9qZ3JtSHNhUUdwbEFBRWEyTkt2VHgzdjYyYXJiRG1q?=
 =?utf-8?B?VURaSEhEQ0taS04yRnFZa0pQc1BTeW0vSytpSWtmVHg1aGdxV0ZXc2VmYXQr?=
 =?utf-8?B?YW5HYTFpYW5ZZGo5c3hHWGw2bGV3T29UQytBb0JrUlVMZGlmMUlMOFp1VmVv?=
 =?utf-8?B?aS9QaEF6VHFxOUJMTENMNU5zbmRncnV0aElkUndIdHhDcG9GK203c0ZJdDlR?=
 =?utf-8?B?aW1HdGx5ZVAwckRnZmVabWJXVHdrajZjTndXeGJOS3RpVldlaEFNYmFBM0VF?=
 =?utf-8?B?SENmcWVTWDlCb0k2THBOQmpQWVYzWTZQbGhPV29RTUtiVlRiM2Z3SVNJZVFI?=
 =?utf-8?B?SGFpVXdicm9NaVZPVklVWCsvWEcxV3Eyc3VZS3VOTGpHaVJkZGlrZno3Q3pS?=
 =?utf-8?B?dUdnbU9NUGhsV3dtbFF4ZFoveVZBSTd2NE5JT25OdlRCY3VwZk16SThzQmJl?=
 =?utf-8?B?Y1loWllvaTI3cHZuR2VOS05RUzdUbGUyajFqa0lDR1BVM0pWdnk3WHZKTmRt?=
 =?utf-8?B?K0xXWVo4NXdWTWgrTkQ5SVJFTjcwcmsyKzIzcWczNHVPMURLR0ZqZXd0NU9F?=
 =?utf-8?B?RVBOWXFBZnNLekR2MEU0b1JqZXQraGJRU2dBcE4zZVlRTTlwaFVsNGpGaHNB?=
 =?utf-8?B?WVNIeG1BTEZHUjNsUGszNFFXbkR2WXlwVlVEYTVYMHBJajhKTllUTVdrTS93?=
 =?utf-8?B?QThKdGRiclo3M1FJRHo3WmV6OWdnRTVBa2tlRFk3aFNBeVFGNUQvRGxpWm41?=
 =?utf-8?B?eFpEYSt2ckVZbmowVlVrM2tCVzFaSG9GZ0JWSGdJb1hCOFNBVlczM2owR2NB?=
 =?utf-8?B?NU5XNjQ5b0dIVzJaTXFqMlBhbWNCR2lMZU90Sk5nL3NvRXFjNGhzU29UR3R5?=
 =?utf-8?B?TWU1MFNuQ0FTUjdEeWJ3a2U0dGJXRkhhcXpYMzhNMVF3ZDY2bGo0OUdJTElv?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7861225-2788-4de4-6025-08de17f7d437
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 21:03:51.9525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHVlRcFpLKcFdNy6DpH7gjIh7FMbCf/qZeDWsKCRAYSJ9ULhxt0f8HrcqfKpDZEdZBcpCNxDUPqBkcUJPwC7LU+hSI7QxlpRpqZxWXfy2N0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7029
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 23 Oct 2025 19:04:18 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Given that the platform TSM owns IDE Stream ID allocation, report the
> > active streams via the TSM class device. Establish a symlink from the
> > class device to the PCI endpoint device consuming the stream, named by
> > the Stream ID.
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Couple of trivial things noticed whilst refreshing my memory.
> 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> 
> > diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> > index 4499803cf20d..c0dae531b64f 100644
> > --- a/drivers/virt/coco/tsm-core.c
> > +++ b/drivers/virt/coco/tsm-core.c
> > @@ -2,14 +2,17 @@
> >  /* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> >  
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +#define dev_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> Why is this dev_fmt() in this patch (which doesn't seem to introduce
> anything that would use it)?

Probably a debug leftover. The dev_err() in tsm_register_pci_or_reset()
would use it, but that print is sufficiently descriptive.

> >  
> >  #include <linux/tsm.h>
> >  #include <linux/idr.h>
> > +#include <linux/pci.h>
> >  #include <linux/rwsem.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/pci-tsm.h>
> > +#include <linux/pci-ide.h>
> >  
> >  static struct class *tsm_class;
> >  static DECLARE_RWSEM(tsm_rwsem);
> > @@ -106,6 +109,32 @@ void tsm_unregister(struct tsm_dev *tsm_dev)
> >  }
> >  EXPORT_SYMBOL_GPL(tsm_unregister);
> >  
> > +/* must be invoked between tsm_register / tsm_unregister */
> > +int tsm_ide_stream_register(struct pci_ide *ide)
> > +{
> > +	struct pci_dev *pdev = ide->pdev;
> > +	struct pci_tsm *tsm = pdev->tsm;
> > +	struct tsm_dev *tsm_dev = tsm->tsm_dev;
> > +	int rc;
> > +
> > +	rc = sysfs_create_link(&tsm_dev->dev.kobj, &pdev->dev.kobj, ide->name);
> > +	if (rc)
> > +		return rc;
> > +
> > +	ide->tsm_dev = tsm_dev;
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(tsm_ide_stream_register);
> > +
> > +void tsm_ide_stream_unregister(struct pci_ide *ide)
> > +{
> > +	struct tsm_dev *tsm_dev = ide->tsm_dev;
> > +
> > +	sysfs_remove_link(&tsm_dev->dev.kobj, ide->name);
> > +	ide->tsm_dev = NULL;
> 
> Trivial preference for reverse order of register.  That means
> setting this NULL before removing the link.

Ok.

 9:  c24f0c9f0b9c !  9:  35aaec30c413 PCI/TSM: Report active IDE streams
    @@ drivers/pci/ide.c: void pci_ide_stream_release(struct pci_ide *ide)
     
      ## drivers/virt/coco/tsm-core.c ##
     @@
    - /* Copyright(c) 2024 Intel Corporation. All rights reserved. */
    - 
    - #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
    -+#define dev_fmt(fmt) KBUILD_MODNAME ": " fmt
      
      #include <linux/tsm.h>
      #include <linux/idr.h>
    @@ drivers/virt/coco/tsm-core.c: void tsm_unregister(struct tsm_dev *tsm_dev)
     +{
     +	struct tsm_dev *tsm_dev = ide->tsm_dev;
     +
    -+	sysfs_remove_link(&tsm_dev->dev.kobj, ide->name);
     +	ide->tsm_dev = NULL;
    ++	sysfs_remove_link(&tsm_dev->dev.kobj, ide->name);
     +}
     +EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
     +


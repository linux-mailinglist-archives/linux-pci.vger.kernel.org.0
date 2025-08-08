Return-Path: <linux-pci+bounces-33650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76400B1F15A
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 01:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B507B2CA7
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 23:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A376B25CC66;
	Fri,  8 Aug 2025 23:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8Z5IZRx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054F61D54EE;
	Fri,  8 Aug 2025 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754696736; cv=fail; b=ee/DUNmTjCRkjW4WmEEJFHyvEBdSvB0FWjoIxsLh5STS8plM4ASfyt24EpPQzf5w+g4Jxm+7oXYN+4M88qG/3HteOGc/2A7mm68XJwsYedNf6uW/0UifeZeAOOSqL88fHZmhAn5K8L53CUlolvtqYYFwQVeoh+8EuVqGy+Msn5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754696736; c=relaxed/simple;
	bh=vapNdvTfk/9ytcE/4ES+eq7KbyzzwSHkOLEWnosiM+s=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Yn+rIdNFq4qNpGH6o4mvCYkwt23XwMNqrfKy0L8LsmkNMv7jpwMN8/A1UWipN1KnAxb5hXM13YB7w/ehuVyDYRYEQlctjEoTVSDoZiEz4qUqbihELlIRA5uB3T0HW2QFn25Q8eI9J4ZLEVQ+qqrZDOu5FSotk3tnwsd/u3P/AEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8Z5IZRx; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754696735; x=1786232735;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=vapNdvTfk/9ytcE/4ES+eq7KbyzzwSHkOLEWnosiM+s=;
  b=b8Z5IZRxhOdVBwTSGcmzxegg1v3G7OK8PrmW0zxRQLTg+YiPC1JdJZ0p
   2utTUdvc0IIyx45YOSzooYDiYv3xDtXvTj/F0pDuAo6WUucCvfTfIlVdo
   2ykt2RXEjAPZVbckxr0y1t919ykSqVNfY3nneNFQwnIFyr8bz2Tfej2kO
   wvMsSxDDmgDQKD9pZzjOyHLip4wbAvyhm7+4rSs8KJqhEfk26YaWUqJYZ
   iynibYd1qv1E75jXN6CmdagvUFUnW7Z/E1YX6TCMoEVrDWPm40xwJksoF
   yEpNomhgC2kNh6yJX27psztK9wGUsS8NH7N6OAsdWM7cap028EYK42iQY
   A==;
X-CSE-ConnectionGUID: lhkqFt5aSfC5GqgfGbdx9Q==
X-CSE-MsgGUID: HIkA5xKgR2GIfoDrbXxE/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="67317292"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="67317292"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 16:45:35 -0700
X-CSE-ConnectionGUID: bJjjjpNrTvKh8ISwlM876Q==
X-CSE-MsgGUID: m+YZyFPjTYqgXsUvSwcqeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196420685"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 16:45:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 16:45:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 16:45:32 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.73)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 16:45:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqts6OFPMDQEoxXw7uuQcg7KArWsK75IR977yKxeUUqIahYCq9MMAvu0O6Epfp/ETQoGjx/4Z3BRlEUtq9df7wRcAMIohfBbHwJeuJqVghlLfzQcXB9W3tBBpZWiUXmHN17gHNLpgwdrntJ9M/FkI2UzS821YgS/nCGiQBIYPg71Njfql6bhGLhZFjrxPQWw8cdad5DGxlxCnsCDikNQUGWbqh9jct0T/T/IucA4mUpS2NENHbnGQpW8Ukbr4FQXgMp46oAkVSRV0iAwC23XoLsvxF1htYPBUd8wngCrDtJV3y1PdMg4h4iNzhz1wmytn2F56RWvh3KGqniax97pIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fT9Yl9zchJAhlPFer8GMiXMY9wlSeiH5j96/AcJzF8g=;
 b=YunzSRSVstb1ESnr7SKfc1o6/YG1/bD78qRCXosNO/euKdStWlfriyxZeFO6OJD4BWhaHBAoXZkrQubBOS3iL4GLKk3EsEVDLdmFTYCPBZirh2yGwar881AU2uYbQD4L+2GhrdZW1JfHaQ3R2ldZMLmeyOy9aQmIOyj0HW9sf7BpdWutl2BqU75RjXsgBZC/dhbYulI0f+y30ndStDfpQKmeEuSekJIw1rfwd6WA4+OwLj4S74dU55INp4v3pgbpK4ATtM0eet/uJE3rJiTqAx7pxnxyifYifeutzcAYKT+gwJye7Y+noy41lzqjl6VLMKJf3g9Y+LMmy/dmycTguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Fri, 8 Aug
 2025 23:45:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 23:45:24 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 8 Aug 2025 16:45:23 -0700
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Message-ID: <68968c1323605_cff99100f1@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250807214555.GA63946@bhelgaas>
References: <20250717183358.1332417-6-dan.j.williams@intel.com>
 <20250807214555.GA63946@bhelgaas>
Subject: Re: [PATCH v4 05/10] samples/devsec: Introduce a PCI device-security
 bus + endpoint sample
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: ef11145f-c85c-4cc9-82ac-08ddd6d5a54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWdzU3dxaW5BNGJCRFp1SXljUnd6b1EyMFkzTTZzaStQaHM2YUVubVIvZzVE?=
 =?utf-8?B?Zk4rcy9HbmdTV3U0bmxiU1FGSXNZQS9kWVl1QXl0emNGZnNjNWtnN1h3Y0pp?=
 =?utf-8?B?b1BDbjh1SkQyVnR6WkdVY3g5cHRpOTRvYUtLWlZ0VlhOa0ttWEFXZFJNTFBQ?=
 =?utf-8?B?eDBVMmxVSUtocnQ3cXQ3aW9Hc25sZHpSRGhZMzB6ZXYzSkJXOFZDdmZnTlZ1?=
 =?utf-8?B?S2NvelZRWHdqdHJEaWRENG9uWEQybm5EZEJlTC9kKzR6dkxhZUZJcVJCQlpl?=
 =?utf-8?B?VkRUaXdYMnpjd016TnUzczZaVDZsR2YrVnliR3RXMGRreWw3QWJHT1owSFY1?=
 =?utf-8?B?a0d2bkhvMjI2d3NncFlmSVNRUStCbW1jTFNCRVpYbGVLRlpWV3hsQURuZjl2?=
 =?utf-8?B?cFBwV24wK3hIV3pTZEp3Mk1kRCtSY3pSMXVDM0pQMlpLVHdkZW1jQ3BVdFhQ?=
 =?utf-8?B?UGxqaWhHeTQ5dmQ3TXd6aHllQXc0Mlpmc3Y1M0RPODJzMlZhZHpIWkZXZzVK?=
 =?utf-8?B?V2R6NHBWcXVxUEF5KzNMcU9tUlVEa2RKamtRZG5ZQ1Q2N2RFU3llaVRJaHBm?=
 =?utf-8?B?aklZYWV5RlU5ZC9zZFZ6NmlnRUhIWkR0eStPS29MUGpMZU5XV05ZbkNDR0xN?=
 =?utf-8?B?bEpzNGR4NCs0UXR4Tnl3WE45NmpNVGdRUXY2SVdMWllFc2IrMkhKVDJVazV4?=
 =?utf-8?B?ZE5MOXB1c2UwZ2Q3Y1FXQVdiVWlMMXpHQWJXS2lIRXBRcWpOYkdFRlZtd2U2?=
 =?utf-8?B?bU54K2RjWWV4S3lwM043eFhiS1RDU255QnBidDNUVXFvRm4vZzQ0M3dpUGMz?=
 =?utf-8?B?d3BHbFRKOGZha3M1endmRE85dlEwRjRlVGxEa0Y5cVpKd0IrM0UwdEV5VCtV?=
 =?utf-8?B?NUhqZHFpcXE0MlRZS2JCYjRDWG9HdnNPRDhBRGZGOHBHTHBQcXNNSGVRS1h2?=
 =?utf-8?B?c25hbW9mUjJ5MkRJSGdhR0xjQmc1NnB5c3E5YXo5NXdxT29pWFpKcjJBM0hW?=
 =?utf-8?B?QWovR1dvZWZUSkdjYzdyL1FHRzh1ZWFna0k2WXp3Yk1PeHQ2cllMcGJnK0hS?=
 =?utf-8?B?RUZPNVpWcG9iRGtGSkZzNVhMR3A1NFFxODRodFJnTWZic1d4ZDZWRnNqWmRZ?=
 =?utf-8?B?SWpOaUpUREZvUUFjUU5kTHBvVTR5dGRHOFlzTHo4NDR1cWtyMnhPMzdOZUxV?=
 =?utf-8?B?Ym0xRFl2WS9Pdmp3YXM3bE8rWjVTb0sxV1Frc0t2Zmxod3lsZkxXSEdDeDRk?=
 =?utf-8?B?QnBkVHlKVVJBSkljT1EwNUNyZU96T25BUHVYdFVFZk01UEVoejRlclh0aWx6?=
 =?utf-8?B?QlhEdWRyQWtJOHZDblhpT2xCSHRJOHZlTHN1NXlBVXIrcGdoWUR1WjFRV3Aw?=
 =?utf-8?B?WjFhTWQvM2VNbUFqcERzd05Cc3YrM1FQY0QvTExFU3VqaGtNcjl0VnJzS2Qx?=
 =?utf-8?B?SUo4V1lVS2RuVStzcm9WbmtVajIwTDRDSnFHQ2tZMjJqRFFCNGx1ZXZnR3k0?=
 =?utf-8?B?UFBPRzJzM1I1ZDVCd2JiZWl3OExSeUxpcHAvcEptdlYzeWowNlNrYk81NGtr?=
 =?utf-8?B?ZnlvcWNiTkE5NDdDcVlGT3ZYRTVpSUtJT2RVOGJkNkRhckZGSUgyMlFaTTNB?=
 =?utf-8?B?KzRjWE9oZ09sSVJIZnlmR0RaTzhxbmErNWZwUWdqdXc1eEltWmV2ME1pRTFn?=
 =?utf-8?B?bWJqU04zTmhLN2ljeklhank1N2xqQnorUUdzLzVielh6MjhpMUl6TDBEeDU3?=
 =?utf-8?B?SUJkS3dUeG9MRzZrRU0yY0xWUG13S2txdC83b3JNWHFGZWwvVXlaR3c3ZzhX?=
 =?utf-8?B?aC9SSFEveThRZUdTcVAyV3M0Myt2NEREOTVCcUFHWGJxTUVXcWF0UVlyRDF2?=
 =?utf-8?B?R2J6WTFwbXErQndxTFBaVGphbWVwOUZyZWtKbElrWUlhczNyMXZJTm9KQ0px?=
 =?utf-8?Q?DmBvRlckHJ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2IrQTFYb2Z2QURKWm5ZeHpmemYvZ2dLUmQ2c2o4RjUwamZNNlNWZ1kzeTdk?=
 =?utf-8?B?TlNCNFRGRlZ1RlF2WFMzZjVGNUFFQy92U21VUlJLaEpOU2dwUzhJUU1jU0Jr?=
 =?utf-8?B?RHFTdzNRY1hLRTU1U1NacHRPa25JOEQ4cEtOSzlrV0NwVDFNTVNOc0xUWVRq?=
 =?utf-8?B?VDVqQzZKd0JXS093akYrak9UVlU2TkY1ay8wZHBJdE5yQnUwd0RuZHVLM2RB?=
 =?utf-8?B?S0Z4NVkzZjdSUDRiN0Vwa3dzTmxJbWtpYm9pdU1xTnJvTzdQenNtWEpmRWww?=
 =?utf-8?B?QzhWdk1WdGxwbTlxakdnRmx4MWw0TW9qMFFXbDlDMkV3RlQxL3hxekpuY21E?=
 =?utf-8?B?SEFOZjVtNFAvRnFwRGt0NVR4S0ZUL3MxQ1Z5clpwcThpZUdIbFZCNU4zL0kw?=
 =?utf-8?B?YXhseTltWkpUYlBTQTlVMFp3TFZ6dlpMRkdCUnJQQXV5RURKWGgrUDVhRGRr?=
 =?utf-8?B?TjJrY29JYzNMWjJpNEYwVVhVdXFlZk9uaUZHQlNDclhCYTJ5cGdPTWdkKzk4?=
 =?utf-8?B?UWRUSG9tVkIvalJUYTB1dUtWWEU0NTEzRmg4TytjNU95WUtkbW5IbHF3UHd0?=
 =?utf-8?B?TzdXUDB6L05TRStVcmJIL0dJa1prQkxBdkJ4RXU3QzBhS2dDbkkxb0VaZ29V?=
 =?utf-8?B?MWdxdkUwNHBIUHhXRGJOcngycWt0eWRPbjZNa25mSnNYS1kvL3NEN3VINHJh?=
 =?utf-8?B?aEJqamZKY2tHRXl6b01ud2wzeG8xV1dVMHBscGQzVzQzdWlyWkxxV1picXp6?=
 =?utf-8?B?VVIxNXZ0ZHhUQjZhcnR2UXFxU2ZST3pIaFZCb044UnRXdXBJVFNpMDA1NmY5?=
 =?utf-8?B?aGU0UUpxdDJLL1JQeGdXdkQrNDdycEdlTkRjVzF3K3RBQlh6ME9rT1NOZ05p?=
 =?utf-8?B?TDd2a09BUldRbDczRm4vNGc5ckVqbW1TQ3VVVkFYRTNVODRxWXN1aldvK2ZL?=
 =?utf-8?B?dFh0cUFVVVVWY1REVEZSRGNtemFyWnFjYW9LTStiWUl0d1QrbjdaRVhSTXh2?=
 =?utf-8?B?SEh3SERYSUVoNHZwRkh5c1hrTGI2aEZuK1Y3clVGWmVkY0NCT3pLMW5SWFNF?=
 =?utf-8?B?a2wxUGJMdW54SHNMVm5NM2k2MU9CTTc0OHRPb1dER1B2SEs1YUhjNkowdHJy?=
 =?utf-8?B?QS9Nb0VNck00aWtGd2tyMGNXSjIwVDE4aVdvWElYTm10WU5QQnpmdHdJeTVi?=
 =?utf-8?B?UmFQTXYwZUZlOGRDRjJMelZOZVBZVU1mNTM1Z3BabXhCQTlPUTl6cTZ3ZGpT?=
 =?utf-8?B?K2VBNGtJUmJZekE4NDFFTG1XZ0ZvV3BNSk9jOEovcllOUjVRWWNvbVpXVUx3?=
 =?utf-8?B?ZlhzenZIUzdiY2FJdDA2emgrOTY4c3hiUlk0d05pazhuZE16ek9qRmt6UEFn?=
 =?utf-8?B?YUZ5QjdhWmhsTHVnbElBSkZnQXFsdG81MVhOL29iNlBhS2xjSVVTV2pjbmpm?=
 =?utf-8?B?Skc5Q20vUUdnM3Y5b2tlaW1na3pBOEJLcmJnKzVkWHFwOXl2a0ZHa3lIOG05?=
 =?utf-8?B?REhDemNRamViZ01nUGhsaWdFNUxVejIyenNNQkN5SjZYWm40bUJqVjVIN2hu?=
 =?utf-8?B?RTVveExjVTNYVHZMTmhiaEdKWVpMZmdneXNmbGJRcnQ4Q1FwR1JCaTBtS0xS?=
 =?utf-8?B?eGlocUR2QkNtSE1jeTVOdDEyQkMyVWZ1MG94cmJvVmJJdi9QbGFoeFdzRkxi?=
 =?utf-8?B?ZDhtTnlSUE1hbVJremV6UDl5T2w2Q0h6azhncStheDExcE9odVNKMW9PMXdj?=
 =?utf-8?B?bC9USnNPNytGYVc5azU3ekZOcEk3TENUU1doWHBqc29vZGRlZTJBTUV1U0gw?=
 =?utf-8?B?Yzl1SjRSL3JkTHZ5WExkMTdnTmFxOWZ1V2w1ZEVwakcyMFFEMlVDRUZmM0pz?=
 =?utf-8?B?QVJXb0xBbitFakpweEZPYSsrK081VWV6MEd5anZTaG1CMUlPQ1lBV0d2b0sz?=
 =?utf-8?B?TmErdHF2dUxXNkpHR1hFS1NjWFV3UmJ4K0ViSjBoWXU0c0dLbmN4WGxORHpx?=
 =?utf-8?B?Q29tVlp2c1BqblkyOUtLaDg1bk5ET2lqa3FHblBONlNnY09laHBLcWo3SEJu?=
 =?utf-8?B?ZXJSL1NxbCt5Q0V0NTV5bDFrVGQreCtaYzgwN3ozVWtINUlxR2VkMkJKbTNL?=
 =?utf-8?B?SkhqREFoOFVIankzMW9DZzZxdUdGUmhHcGM5UWIxNDZzbndxY1I1Q1c1bVNW?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef11145f-c85c-4cc9-82ac-08ddd6d5a54f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 23:45:24.7746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlHyVTh4CXqJQqfQYrRxT03Gs6coJPTxQpIiEzXVyEXZPQBwYdbAdwFf2qnDRo0btw1xGULVPrJgEX1W0YgKX2OKdAqvan9W0vcy6S+WRtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5782
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Thu, Jul 17, 2025 at 11:33:53AM -0700, Dan Williams wrote:
> > Establish just enough emulated PCI infrastructure to register a sample
> > TSM (platform security manager) driver and have it discover an IDE + TEE
> > (link encryption + device-interface security protocol (TDISP)) capable
> > device.
> > 
> > Use the existing a CONFIG_PCI_BRIDGE_EMUL to emulate an IDE capable root
> > port, and open code the emulation of an endpoint device via simulated
> > configuration cycle responses.
> 
> s/existing a/existing/

Fixed.

> 
> > The devsec_tsm driver responds to the PCI core TSM operations as if it
> > successfully exercised the given interface security protocol message.
> > 
> > The devsec_bus and devsec_tsm drivers can be loaded in either order to
> > reflect cases like SEV-TIO where the TSM is PCI-device firmware, and
> > cases like TDX Connect where the TSM is a software agent running on the
> > host CPU.
> > 
> > Follow-on patches add common code for TSM managed IDE establishment. For
> > now, just successfully complete setup and teardown of the DSM (device
> > security manager) context as a building block for management of TDI
> > (trusted device interface) instances.
> > 
> >  # modprobe devsec_bus
> >     devsec_bus devsec_bus: PCI host bridge to bus 10000:00
> >     pci_bus 10000:00: root bus resource [bus 00-01]
> >     pci_bus 10000:00: root bus resource [mem 0xf000000000-0xffffffffff 64bit]
> >     pci 10000:00:00.0: [8086:7075] type 01 class 0x060400 PCIe Root Port
> >     pci 10000:00:00.0: PCI bridge to [bus 00]
> >     pci 10000:00:00.0:   bridge window [io  0x0000-0x0fff]
> >     pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> >     pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> >     pci 10000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> >     pci 10000:01:00.0: [8086:ffff] type 00 class 0x000000 PCIe Endpoint
> >     pci 10000:01:00.0: BAR 0 [mem 0xf000000000-0xf0001fffff 64bit pref]
> >     pci_doe_abort: pci 10000:01:00.0: DOE: [100] Issuing Abort
> >     pci_doe_cache_protocols: pci 10000:01:00.0: DOE: [100] Found protocol 0 vid: 1 prot: 1
> >     pci 10000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
> >     pci 10000:00:00.0: PCI bridge to [bus 01]
> >     pci_bus 10000:01: busn_res: [bus 01] end is updated to 01
> 
> Most of these messages don't seem relevant to DSM/TDISP/etc.  It
> *would* be useful to have a hint about what specifically makes this an
> IDE + TEE device.  Capability visible via lspci?  Are devices at both
> ends required, e.g., a Root Port and an Endpoint?
> 
> Oooh, I see (finally).  This hierarchy is all totally fabricated, no
> actual hardware involved at all.  You did say that above; it just took
> a while to sink in.

Yeah, there are so many moving parts to this that I do not feel
comfortable leaving 100% of the testing to hardware. This is faster to
prototype than teaching QEMU to emulate all the pieces here.

> 
> >  # modprobe devsec_tsm
> >     devsec_tsm_pci_probe: pci 10000:01:00.0: devsec: tsm enabled
> >     __pci_tsm_init: pci 10000:01:00.0: TSM: Device security capabilities detected ( ide tee ), TSM attach
> 
> s/tsm/TSM/ in the message
> s/ide/IDE/
> s/tee/TEE/

Fixed.

> 
> Looks like spurious spaces inside parens?

Yeah just to avoid extra code to elide the separator, but easy enough to
fixup.

> > + * The expectation is the helpers referenceed are convenience "library"
> 
> s/referenceed/referenced/

Got it, checkpatch misses this one.


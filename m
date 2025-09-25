Return-Path: <linux-pci+bounces-36956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BC2B9F974
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 15:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF61387993
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 13:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0078E265626;
	Thu, 25 Sep 2025 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qg4qaCXp"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4DF264A76
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807209; cv=fail; b=aLfLiaoBl/GGDzE660kxcBXV7y2UcLQ3nFfk6CMWr58iE7dXm9cjwuI9EzJkTpb4iLoAFwPT8qLJ7lq0iud1yjAYv5hGdgJHgPv6mrae2e1NyZu6lFbFlsFQ2Ieg44RiNMoot5HDP2ZKGLB8ogRypGQkN+j9N+7KxWmi5mvbraI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807209; c=relaxed/simple;
	bh=Nj27ns0eTBQ2PhaowWuLVUwWqWSjOTH9PKYKh8VY8nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EYADO5p/sIC8ANXP69j2RepJJYVSnZiGp3JCw/9Qi9r68qQPOpp1rbgFe4doYLq5ugTl4dltRgSFO9758mX5QoIHhrtqx5gKdw76sHMTb7xKVUUmoDlf+rWhuRIqLbFZTUURMiwJN4qo//HBoF0/5mpsUsMog07poV08deN/y1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qg4qaCXp; arc=fail smtp.client-ip=40.107.209.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpmqUxW7Ue+NWU91tbUeQDmvzSWBFikBt9aD05lGW2QacFXmnHZIOL+izxcvfBBwZbPkLvaAbBjQjQna+XsrehDKwG5wokAXZXJCbtZHwl4QGBEfnJtJx9y7tQvo8fldIcQMSePYyOzDBnFNHadsIwdJuGz8BF0Fyd8RGEN3cLT5K/a0DxrBxm1ou0t5gjx68BN4F9h6stY3xMURmy8mHeojqHt3b/9J+tnWMc8oUSSPdzcCYj0RcCXEKdtYNtY1BJw9zKcJ1lGbQ+2JjtnIzgdqo04tXvxZgb5OAaW+Izft39CNJgOewRbrRuc0k+SeGwPj7H82F+xOQ7piHhuX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cmseuCL/PjtTU8CF9s/qzR5VnBjgEFVf3j2PIFATj8=;
 b=oVg7GYaOy3IbwRDOPOvffyr2Fj19SuegdWoww/qTXkYY5U6hhFmFEbnEeOGeHutiiihcl+D8pcCweJs1qyGXYFRbV1SWPvWeb2wiaY7j8W9kJKu9fMSH0O5Uuc5UyTl9RTgB3Y2UBS+dcgliXgettnac8/InzdtFhJh9iog8JPArzSpqoawzQMM07g33r2y0cU4dJoQ3pq8iED8lYHpogXrX0JfM5++m4afF9oog8CL29EWo4nmv9dW39RKUtfQ/nMqRV+RmZYbKTAAbI0h/fzIku/2jwAUrLhwZMqf1RAhrZHXh1vD5t/5yXpfg1fqV/h5XQ+13s2IMYSJfZ9Bdaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cmseuCL/PjtTU8CF9s/qzR5VnBjgEFVf3j2PIFATj8=;
 b=qg4qaCXpu2CS076HcXKLt7eNneQ4oNCCWlEHHIVpd2BEWVqtAjVjrKe/EXYXfZIyHFljQQSPgf5a9ls+eba8XqEXZoT6XGeIDoUSWnc331UOE4muBugJTM0cOv0QxpIXsIzYm5yiBVHRfLJsOI9UpQA0mX8qsFz/nlrYEYZEq+2Mv/ez4CF51X2IgVZIjunr0tj7aofKC9onDRkz4SQm2R9+kNOd2/ilwbpcPYO30NExWpATwiR+r/pC2+0pcDFQAgebKiDCy+V3NJodsTank///7VEIoxEtht8hueSoCZVLq5k3PuyGdv3+57PPLtt7prUEgL+jxgDRqyZC911OOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 13:33:25 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 13:33:25 +0000
Date: Thu, 25 Sep 2025 10:33:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	"Brost, Matthew" <matthew.brost@intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] PCI/P2PDMA: Don't enforce ACS check for device
 functions of Intel GPUs
Message-ID: <20250925133323.GZ2617119@nvidia.com>
References: <20250923131247.GK1391379@nvidia.com>
 <8da25244-be1e-4d88-86bc-5a6f377bdbc1@amd.com>
 <20250923133839.GL1391379@nvidia.com>
 <5f9f8cb6-2279-4692-b83d-570cf81886ab@amd.com>
 <IA0PR11MB71855457D1061D0A2344A5CFF81CA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <1d9065f3-8784-4497-b92c-001ae0e78b63@amd.com>
 <IA0PR11MB7185239DB2331A899561AA7DF81FA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <ab09c09638c4482f99047672680c247b98c961c9.camel@linux.intel.com>
 <50c946f3-08c5-421e-80bf-61834a58eddf@amd.com>
 <f646f5e281e0f53656847ad4eddc3cc215c684f5.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f646f5e281e0f53656847ad4eddc3cc215c684f5.camel@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:208:32e::18) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 73514b3d-ac24-4e18-083e-08ddfc381a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEg0VUxFcDlOTGgzZXZCVmJsQ3lVaDY3RTFYbGVsRy9CdE1aS2htV0FuMTNw?=
 =?utf-8?B?QzJhajlxVkI0SU8veXoyNXZ2YWhaMVQzazdqUW9BMm4zdmhIRDZjVTZGQlR1?=
 =?utf-8?B?N3llaFJlNVdtdVVjd2RUNlpBdFpzakthR0dTV09ST3hJd3JDOXF5MEFIMjZ5?=
 =?utf-8?B?ekM1VWQxb1BNY01aajJPVzF4L3dnSkU5MDlrRjRrSUsreFQ4TDBqaXVReEpV?=
 =?utf-8?B?cHlBdVpkcGR5Mjhibis4R2RtU2Q5MlpRby9NZUpZTThwTGxtRjVkVXNrMG4v?=
 =?utf-8?B?eldmNlk5NGdLYnROcGw5OUdzWURnNVBVU3FQVyt2dlhSeHFlcUtlMTFDcUIv?=
 =?utf-8?B?K2RJeTBobU16by9NT3B1bjhqTnNQSVB3WmZrT1M4U3ZtSXZBOFE4QkhZWkgw?=
 =?utf-8?B?bnJ0bDhicmhJV1RuV1VEQml3WmJIa2dZRmRuQUZiMjBkampwcTdtb1YxUVcw?=
 =?utf-8?B?eWZaVVhicnhvWkpVZWJmNURvTjZvQ3VxVHhjMmNRb0Q3aWhTeHFjaUY4K2l2?=
 =?utf-8?B?cll4SmZvOEFScWp6SzhKVW5zUEtpMDBWWGNiSmk2ZGVmY3IyTmZPNmFTdy80?=
 =?utf-8?B?bEhyeWowb2tWT1Z1N2tBNWU5K1RLZ3FyS3gxYlZjMFUzaFRXbWNjdUNuUy9a?=
 =?utf-8?B?Wk9ibzBiNnkvYjcvTkZYN1NvcFJFTGtJWlVmNTI5UmV0MHJ4ekVsaDMxVWM2?=
 =?utf-8?B?OHY1blkxR0daQjlqVUR2Ly80SGNycDRaanlJaVhjVUJNb1NZRFhLWVRNQU9u?=
 =?utf-8?B?ZTZrYm1zL0s3Tmp3bjJLVXpaeTN3b2c2N3V2TFhTTDg4S2J4dUNmaWxQMFAx?=
 =?utf-8?B?aGpudE0rUEd2Nnh1d2s3NlVmOCtzR0dwNXJYRkY1SWlIbEZpbnZ3ajZsZmJN?=
 =?utf-8?B?N2FxZzYvejlZN3dSQk1wMms4d1FBcjRaRjMrbmFHVElMTjBNMnZkYnY2SCtD?=
 =?utf-8?B?MHRJRTV3NkZOYk5kdklzaldpcDE5OWRBM0pTOW1hOHEzMjRJYUFGV003NnlW?=
 =?utf-8?B?MHJpcjd4cU40c05wektUNU4xTkJ5c09lRkNaOUlCSnN2WFk2MTd3MWhSWHh1?=
 =?utf-8?B?Z1cyVkdrTmpwTVIwdWJFcTA1ZnlZaHJIYXR0ck5sbmcveUl0ZHhPTzlkc2xt?=
 =?utf-8?B?U0pYTGd2VHhBTnpvc1luSmFwcFpUUC9PV0tSL2hzS3ZzelRhNnJFRWJLaDZm?=
 =?utf-8?B?d25LTFp1dkpuMzc2Vm01VVNEb2FhazZ2LzZRVTROWWIwNG1pa3JEZWZzcWlQ?=
 =?utf-8?B?a2RHK1ZBejYxdjFVVjFkdThBZzB6elN6WHZSOFpIckRlZmhpcGQxUThiK0c5?=
 =?utf-8?B?OUZrc252QnZWMDFKZVV2d2NZUGJhVmVLVzJiVDVIWGpMUUhsTnNvVGpFVk95?=
 =?utf-8?B?cHdJRTF4RW1pVk9NUmVyWFFBeEVJTW5KYzYwbGFrTnFQMHZNbEVtdURkMmhk?=
 =?utf-8?B?YXJnT21WVjRjMmFvZWZud3o5QWZObEpUWHdDclpFVE9SNXVPL2xrZjlJUUI5?=
 =?utf-8?B?cmVDM2gyRUpOSUlmc0FhQzZGUURrbklmTkhoU1hxUTA1ZlUvYmpRWGJ4MHRm?=
 =?utf-8?B?NHJ3b1NpaUNSWVNiL2E5eXBpQmJBNXhValZKeTBzRUp6VkRXdzVhOUdBWDBJ?=
 =?utf-8?B?UWYxWG1xYnVxOFlTMGtMSUpPenczSFA2bGxiRWlSQXk3V0R6ZFhVVG52RzFw?=
 =?utf-8?B?MllXL0pheVJQemhrMWREam9zWE9NOGJQeVlpejg0THRlQW9HZ3NFWHcwTllu?=
 =?utf-8?B?dk5Ta0JkQ0RyWldacER2RjZDT0YyTWxwekxsYU1wNFZWWVUyRGk0cUMyNnVj?=
 =?utf-8?B?TXV5ajhYcXFjZUpxVWtoSGpVZ0NaZGFydGJYR0VPUnVuaVM2STRJTGxxSHpS?=
 =?utf-8?B?bjlVM3BCci9icXhrMHhsMXdqczVqdWNLZ3huU1RORlZjQ0grbnpDSU9jNFpl?=
 =?utf-8?Q?wVXDnvqU+oc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5753.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzFwT3JCOThQS0g5b0JKQUpYK1BnV2N3MTJEeXBhNFNMdnZoQmJFVzVJUFZX?=
 =?utf-8?B?WnArTGtKQlFTb2N0VTloRG5Nclc1VG9mT0FMQVdOSHJ3UklqbE1QMFdTMXhI?=
 =?utf-8?B?bFNQUHBvMndDekV0ZHhGeTZPV2wwbjlDelNvVUhDcWE3ZUlPUGlYdlRvd01I?=
 =?utf-8?B?Y3N3a0lYeTBSMlhBSis2akxqdWN0OUpBdEtEUjM0VUJ3cTJUQUhnSkNYZG0y?=
 =?utf-8?B?cTdWNWxBYm1PY2JNOVB6ZlpSR3Uwa2Y5cTJpWldFak1LLzZ6OUJmMWU2QnFR?=
 =?utf-8?B?cVErd3h3YVU3RVFtbk9HcG9NUC80RmRSRnFEa2I5cS9USlZ0VVdoM1RqY250?=
 =?utf-8?B?bUU3ajdKVlNZem1NMVFTUVRxL3h5cW1wK3FvR1lHVlpsWU1mL0N0NDBtRUF3?=
 =?utf-8?B?dkNVY0pCNDl1U2MrY01IckwyTnd0dnVDQU83VUxaQ3VtMVhYdy9PK29Zakk1?=
 =?utf-8?B?MDZML1g3U2tuampOaXptUFNBTjRsY2I2QlFIOWk1bXhEMTZSZE9wWGYzMTZV?=
 =?utf-8?B?eHJLSkR6a3BVTmRyVHFrMnZkVnM2cGdwMHhJdUloMkNmMW4rWjREelBCK3Nx?=
 =?utf-8?B?SVR0WWRWN09QWUlaL3pKN0Y1d1B1T244MzZNdmcrUUx2UVJVRG1QR0JXcFJX?=
 =?utf-8?B?UzExcG9CY0RvK3Z0dU1xU1RwMjNxTk5hZnhQUzhwb1g0Q0IvSkxwRTFoMFFq?=
 =?utf-8?B?TEtjQ00wSUwrSVZKYmNvNTJkd3d6QVZmV2NCWnB4cXkwOHJjS1hLTlQwRzRB?=
 =?utf-8?B?Q05yb1Y3TmJBaFJrRDBrZ1FxbEkwWVVDTjdFVU9kdzgxZm1nQ09RZmF4NnpH?=
 =?utf-8?B?WVFwQ0xkNmJXVDEzbU44UHFOUStmMm1qbzg4ZlJKSTAzakdWUjBKK3VuNUNI?=
 =?utf-8?B?RjVsaU9RQjV2bEV1bGdRaXY1WHg5K2hmbmhCQmZEZEtKWFNnQU5MRkJIQ3Y2?=
 =?utf-8?B?YmRzVDFmTUJCTE1XMmlkT3c4SDRFbzIwWlJicmM4N2xlcWNiTDMrY0ZlM013?=
 =?utf-8?B?RWdwa3h6MTRST0hYQVo2ZFhRTGZVQm5odTlUZnZoZ1hNNjVuYjcya3p5Y1FJ?=
 =?utf-8?B?YmcwamkyWExheEsxMWRjUTZqM3pDUDh4OE1sUXJLUXl6VnlJUEZZQUQ1S0Vu?=
 =?utf-8?B?Y0ttemV1aTRrY3hNTTFDbUU1TVNMaER5bmlCZjd1UXBvZDA5dElLcUtrZXBi?=
 =?utf-8?B?UlIzTDR4RzB1bmNuNmsxdi9qWlEvUFkyZFpHcEM5UGpSdE1aN1NoaDQzeWY3?=
 =?utf-8?B?YzFMSS9KZjdiSmk5SlBKSER3b2dpSytVbUZjRCtDeTJHNHFyeEI4cUNPVEg4?=
 =?utf-8?B?cTBpNXFGaTJXYWxubjFjVmJSa0pNSUxrRitBRkZXdkZNd1lWcFE4NFFUZ0ZQ?=
 =?utf-8?B?b1V2M2NFeEFlOTVrNlU0YU9ZdDBtLzg1QVBqMmh0WEdlYVppVklJOHBqMkVs?=
 =?utf-8?B?VUpPZmExeUdaNmJyRFgyb2QxSG9BYkhnMDJVUFROU3VKbXd5R3VnYUVLOWw5?=
 =?utf-8?B?b016NUw3WjRhTzE3Y1Q2aXNwaDVqdG9Bc1ppeGl3Q2x3dHI3bm1Hc0pVNGQ0?=
 =?utf-8?B?YW9WNHZtcFQxcEtuRWczaFVuWFV6YjdDbGs1QXJlUlowTWZWY1RnZGx2WTBE?=
 =?utf-8?B?UmttRFY5VHBKc2cxMHJaL0lMVktMNzJRam1BalhCZ3h2amZEbXF0bXB1elJB?=
 =?utf-8?B?MzJhSVE2UDA0L2RjVlUyY0NsRmlCMVd4Mm5WTWtTWmVoalRyOTk3QUFjMk1r?=
 =?utf-8?B?YjlRY1hUQTByQS8yTTRSN3ZHMjhibDVQVU91S2lvNGErYWZjUzJUVkM4dGxC?=
 =?utf-8?B?U29vaWVVdUZoWk8vcWI3NHVUeGgyQXIyWFJKaXJsMlRFM09lOVpBTmJ3SzNk?=
 =?utf-8?B?aXV1V0xYMExKMjAvUGw5NkpnM3JYSFAxakZMZ3QydWJ1QmNGU3RwRlAraUdt?=
 =?utf-8?B?YUdVWG9KV1Y5WGs4WTNCWUN5OVROUTgzWHNXdC9KdUsyZ3hmVm9BRWhXSlR3?=
 =?utf-8?B?MDNxQkttMy9WcXM2T3o4QWNpTElQU1IyZzNqR0pRQVJBbEZTU0UrZlRXejJk?=
 =?utf-8?B?RjlxZXIvVk5TZlJPeDcvZWoxUVJUbW4xdm5ERjRhY3hqYTRkZW5oSjZzMTJ2?=
 =?utf-8?Q?evxGLmHwVkod1m0k7WZIkgOuD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73514b3d-ac24-4e18-083e-08ddfc381a82
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 13:33:25.1783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Djbqa5S7EAi83nCoZxQ1QOMqmxoeePmLy4RtjRKIYG3RNbtVNz9Mqk1hORNPcMaF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071

On Thu, Sep 25, 2025 at 03:11:50PM +0200, Thomas Hellström wrote:
> On Thu, 2025-09-25 at 13:28 +0200, Christian König wrote:
> > On 25.09.25 12:51, Thomas Hellström wrote:
> > > > > In that case I strongly suggest to add a private DMA-buf
> > > > > interface
> > > > > for the DMA-
> > > > > bufs exported by vfio-pci which returns which BAR and offset
> > > > > the
> > > > > DMA-buf
> > > > > represents.
> > > 
> > > @Christian, Is what you're referring to here the "dma_buf private
> > > interconnect" we've been discussing previously, now only between
> > > vfio-
> > > pci and any interested importers instead of private to a known
> > > exporter
> > > and importer?
> > > 
> > > If so I have a POC I can post as an RFC on a way to negotiate such
> > > an
> > > interconnect.
> > 
> > I was just about to write something up as well, but feel free to go
> > ahead if you already have something.
> 
> Just posted a POC. It might be that you have better ideas, though.

I think is also needs an API that is not based on scatterlist. Please
lets not push a private interconnect address through the scatterlist
dma_addr_t!

Assuming that you imagine we'd define some global well known
interconnect

'struct blah pci_bar_interconnect {..}'

And if that is negotiated then the non-scatterlist communication would
give the (struct pci_dev *, bar index, bar offset) list?

I think this could solve the kvm/iommufd problems at least!

Jason


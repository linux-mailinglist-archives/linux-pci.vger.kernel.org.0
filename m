Return-Path: <linux-pci+bounces-37565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 228F8BB7DED
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 20:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C86454E1F76
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B062D46A1;
	Fri,  3 Oct 2025 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPG68aOi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C19285CBB;
	Fri,  3 Oct 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515511; cv=fail; b=RcYcGmTQZ2AZ/FH8RPTpIx9iECFyT5JGSapPWqn/G/7rup5/2F0U8wAQHxOzudy9SRPiZQ1z4Sz3YK5koJR7zQsSiXdiMpFEUDJ4KBfRAozG0+FpxLlNzSBf5jk7QZ60Ga9zV+IZvy9VIqFH0u6K4c0LNGahdkm1q8Xq8FJDcDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515511; c=relaxed/simple;
	bh=HRUUYJFPJCAgvp1Kn3D6wJ09jbkgmLjw/VIYZzREn74=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=PcMKv6QA33291elQYgPai8RRNtyLL8Dnk3eucFfEQxX/Ek36JX4SAqX9FjZIWao+9PefrqnBxhoQzw8HNzoX6TrqDxzQnZQRj0Q8eJOdLp1eGFFQrwjPURhJ7901Pv1OYU1NvJpLz8vXSLc/2FDGnZ3IHB7rH7X+ZwOkToBaCeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPG68aOi; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759515510; x=1791051510;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=HRUUYJFPJCAgvp1Kn3D6wJ09jbkgmLjw/VIYZzREn74=;
  b=YPG68aOiRDCzFosvixIcrBofJ6sL7QN/507wcsA1l2ARHTlpoy1yPbWs
   IQG0NqTlrXZijyHO3+eqVEj6KUg4iA7/+rpPzDFieYLVXVfAH9Z8dRn1M
   usuE1eriM18Rria6QfMySadXa1jKrHt9C/prxJHzjyRFJI+DRwGWuTSFh
   0qhTvKV4JqwtXlItlqqMRj19+PKMjfMs1IcrqxUgY3EichLxp9LhbWGQ8
   fbmf89AVoJAisRk8JGIvbfLI2ArCEnG8kW0bL3hlhPk9nEjiwKvaJAla3
   6MhNXK8GCFNVV/R2WJ0GP+9tYd0G0VM6azMqjTC/yzh/gAZy9Wh+nPLDD
   A==;
X-CSE-ConnectionGUID: 5dNRY8EhTTi+jpwZrXtqZA==
X-CSE-MsgGUID: GMpkqtkaSQ6ik0j0/epX2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="61711015"
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="61711015"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 11:18:29 -0700
X-CSE-ConnectionGUID: k1MLOrw4TbWufIxqS0cDSA==
X-CSE-MsgGUID: EUMXDf/STb6b/WWVH91DzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="179776972"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 11:18:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 11:18:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 3 Oct 2025 11:18:28 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 11:18:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOLBMrGNs0YgmfRSRfazZqhNM7ncocYex0pEy3sH0kA+mH9j1frUANqYueu4yjfWJFxgz6MYApFp0WzPBLrZsTYx6M2pN+OIo/Z+0BelwPzfw3OrtQGPFZqiPZM/3No8E5aI4C5gJsh6qXpGiCGTLRX3jTwnGq4zW+Q5AuX//lKeajuU5F8tSNcF6WUHSerK2jYm6/HAwkpzn623HjMvtr8as9BlLmfC7VESTZOL+F6YzxurP60i5lgwUNslvwwP5+hN6vaFmKvfavPLOhjgHmOfBdQ9XZRvUDDGU85l2FbN5M2vxEmSvJyMlpF5vX8AC7e21HgVCKwlfQq3fZlytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoOIHLjpun/dn0Lv0DYi9Y47IRmPrgZ39yMxjxDeGLY=;
 b=aGvKZfxOUd8C0Y7GsJt9bYa++lOUuDCuc8pgZWbdBEOypeYQDLBKuz6evJ/bAO8k9VfOzZ7ytvZQsi4o2Bv58bei+HBXDQ52cKUOn+ESRs8vH7ctG3mBbdgLIqsKtZI4t1Yh1N5CsfmHttDIvq3po197/PbCIlINsHwXRkl50bjayJu5TLx5h+xUl9FYCX8XETwEC0eL4SJHQchTBeGd5WEueSvApvi8dEzUsoV7TImGSKsfTJQyd9L9ykM5SRrj2ixHf33eSx4gqvUBLHdOAavuBb5Tt3Ns2enTb0Wpu2WtDhSDkhpOkBFGtvhRr/k7EWl+eLI+b7PXtCFzwd/JDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8558.namprd11.prod.outlook.com (2603:10b6:408:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Fri, 3 Oct
 2025 18:18:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 18:18:21 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 3 Oct 2025 11:18:19 -0700
To: Xu Yilun <yilun.xu@linux.intel.com>, <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<yilun.xu@intel.com>, <baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<aneesh.kumar@kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<linux-kernel@vger.kernel.org>, =?UTF-8?B?SWxwbyBKw6RydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>
Message-ID: <68e0136bd9bcf_1992810012@dwillia2-mobl4.notmuch>
In-Reply-To: <aN9iKtxzv83Y/qvy@yilunxu-OptiPlex-7050>
References: <20250928062756.2188329-1-yilun.xu@linux.intel.com>
 <20250928062756.2188329-3-yilun.xu@linux.intel.com>
 <68dd8d20aafb4_1fa2100f0@dwillia2-mobl4.notmuch>
 <aN9iKtxzv83Y/qvy@yilunxu-OptiPlex-7050>
Subject: Re: [PATCH 2/3] PCI/IDE: Add Address Association Register setup for
 RP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7a1493-0e4a-47e8-1cd1-08de02a93c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0dCdkJnMFFIanlrZ2RiRzluVmpBY1FRUWFOZTRKRGUwdG1qeXpwTWpNcCtz?=
 =?utf-8?B?ZkhHSEVnUU5COWVyQWRyRXQ4TDZPalBqNDJGZTFPa2xYSW1saDdYakhqUHVE?=
 =?utf-8?B?aDExWHREajBlb01rcENxUmkwS3E4OU96UnVKOU5OYjA2Ty9ubFF1NTBDa1Ix?=
 =?utf-8?B?OElPc0JZeVFDdFJNeDAyeENBV3hPZnE2QUFwYWRZcmhuZURJeG01Zi8wdlFM?=
 =?utf-8?B?NXVWSVJyVFU0MWQybDBlRWlaSnZ0a0c1VTNWNXczaytHeTE1T2Y3ZWlxRVUz?=
 =?utf-8?B?WitMYVBuQm9zeGhLdGxSamRCRVVFVTBZL2lWOXF3R2VLdG1aRVV0N1N2VUVG?=
 =?utf-8?B?Q0xHMW1WWTFaVDRvNjN2RTR4RVVWN1ZEMUdnNURRK2kxb0pZWVJKcTdNL2t2?=
 =?utf-8?B?TERoS3p4MGJ6QmNBenNFR2lYekNxQnI4MXU2WVVSM1hyVFE0VTd4c1Rwd2xk?=
 =?utf-8?B?all5RkVuWU1CU0RnVmNJVkRvT0VZSGtBcmlST3ZjWEo0dUE0dktuRlcyZ3JS?=
 =?utf-8?B?MStlQVhEakJTUnorK1ZxWXlRK01GeTZiMW56SmpTNExQVEtUY09MTGFoQlZp?=
 =?utf-8?B?MVZVOHRNcE1JOHRQODN5UFJ5TkFIcnlxY0JuTXkrTGlaQnZnOWxpcFFpcjZB?=
 =?utf-8?B?RTZodWhkTTByV29zc2VpMmxhOHhFWHVMckdpdG9Malp6M05TZzhEMWZyUDkx?=
 =?utf-8?B?YU16SEpYdmtSYXJOc3JtTXlMNHJ1UWZLMEdkZXVYcysydHVjTU0wSmM5cU5I?=
 =?utf-8?B?TjNFVmJjK0hxc29tRU5qUnc0NUduYWxzdmZ1d2kycXdGN2thTTJFWFJPcS9p?=
 =?utf-8?B?MnZVaW42KzhBanBmRzBIUE85eHlNNC9mZzJmQkVIRGFycndQclIrZEloV2pB?=
 =?utf-8?B?YmhPM04vUUwvZSszK21UTE1QcXFxM3A3aEZRRmkrakd3YS85RWJ3bTN3ZHhs?=
 =?utf-8?B?Wi9qNmRTKzJpRU95OUd6Y2FKVm5iRVRJWDY2bzV0dXlGa0RQRjJxeHg1eWU5?=
 =?utf-8?B?S1liRER5bG55U04xOEU1UDhXb0JibllMZHZhNTJaN2VhRXNxSXBaQVl2UEFm?=
 =?utf-8?B?RlZFUmExS0NJTUpQa1ZUWk1KdmlHd21MOWowdGVkUGR6MS94d0V6RXhOQWZz?=
 =?utf-8?B?QTJCWnhMVHVLek5adlI5bFhlVnJSVlRSb2lvSEVQWDdxaHFlSCtWbzhOc2Fx?=
 =?utf-8?B?NmVHbElpek1WZ01qdEtFOGcxL0puRG9Ga3Nnc3ppL3EzR0NxN3dsVE9UOXNy?=
 =?utf-8?B?blo0NGFiWHdjL2IzTHZIUGJtbGFmb2hnM3J1dE1oUUttdHhBcHUwdGNGUjVt?=
 =?utf-8?B?MHBrclVxTnlXV2UxNCtnWElyRDBqMllCSkhiYnZPOHJkM00yQ3N2bE9qZmhy?=
 =?utf-8?B?UGRJa3J2cHo3TFRrUzBDUzZYSkRNNlJPMmZBYlZ4L2Z2V0tkTXVZN29JVGc1?=
 =?utf-8?B?YldEWHhDY1A1eEdvVi9EVU5sT3ZvSFU0RHFOY2F0Zk5sZjZDeEJlSFFMVHBz?=
 =?utf-8?B?V3Nud0lpdVhWUW43dmhEQWFVdEUxck1ZSVI2WU9vRzF2SkNQTXhEZnpHekd6?=
 =?utf-8?B?Z2I5NkhseHJWTlRaS2FSVnBWdUl6S0dpbHB5dzh3TTMxUFYzUnRMbjdKTUtE?=
 =?utf-8?B?MjhDd1Q0ejRYdmlLS053dzI2b3dUVnkrSUU3YUdwNEI1M1d5aHlDNW0vaUZ3?=
 =?utf-8?B?ZUxpOHFCZG1QSWJVNkVXMDhFeG5DQTM0amgxUS9uYVhPdnM4b3daZVVtTHFB?=
 =?utf-8?B?QkRGN3NzazI1L1lJaCtxZ1lwYm9VVlgzZEQ0ZDYxOVBGL3BqNG51MXZZVmE3?=
 =?utf-8?B?NzNDWng3ZlpNcE1zNXp1dVYvZzh4Zm9SN1U4bkQvTHJnV05od2QvbVhybVdp?=
 =?utf-8?B?YXlpZDRXQUJaS1g1em9Zckt3S3BqUi9hTTE4RTRJbmZoUkNHdE5PaUVLUEww?=
 =?utf-8?Q?yYrEhhNOOKG7UW2WiOX0Z60uJrScccIU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXkrZHBuMTlrRGtyeWgvWDdhNlNDQjVUMlk5SGNkdmxac05zRkJ2SmVsTzhR?=
 =?utf-8?B?SVNIWU1GTEZqVEtnZVd5V2w0MlU0MitJbGZUY3FYNnlnb3ZtanVrNFQ1dTVk?=
 =?utf-8?B?dm1wMUV0RzNEdC9yUkovZUpydFRxeHVoVGd2cmJuUEtQRWxab1draUlvRUZ3?=
 =?utf-8?B?T21NSURidUZBWUpuM0V5N1R1L2VpeFBTSCtYQmppNHNOQjNHVDJJMTcvaFJr?=
 =?utf-8?B?MXFWUVpLT2NRaWtnZGdCY1dsZkxRWUk3YnFLR3FrWUdrUVprU3UvVzVLbENu?=
 =?utf-8?B?bXczZ2ZGT1BBR1BiMVg1VEhtSFgwUWVWOURPWGF6NXRVMUVhTndveUJ5aGxj?=
 =?utf-8?B?cGJ0Q3UwamZQaWRHQnRvaE04dnlNc0RhYkhNblh2T05Rd3dSTlRFd1FWZTBa?=
 =?utf-8?B?SEh1N0VEVWNrY1JaVGJKclpYVEN6VEJ0YzdaZDkxdVZmSWhoMnlqR2lvUU4w?=
 =?utf-8?B?OHN2ME5hTk83L3c4Yk9NNzZ5Sm5JRmcrTkI1MzMzWWRYRlI1VWJ0eGxYWkJm?=
 =?utf-8?B?U0NmUTlucEZLaTF4eVpVdHBMSHNlWHQ5T0R5T1poVVU5dHp1U3Y4ZlBRMVNp?=
 =?utf-8?B?YmdDa2JiWlkwaWxnTURkN05mZ3VEZDUxTm9TNnNjeVNIckFpK21nNGN3YXJ6?=
 =?utf-8?B?VW1VKy9UQTZDMGROS3Jqdnd2Sm1pZG9vZmRxT1Vza0R1MWZkd1hKRFJOYlZV?=
 =?utf-8?B?c1J0eGZndENkcDM2UVlXandvOVhDcjRQb1Z2MThCTENEZ2Z5bjVlbThXZUhn?=
 =?utf-8?B?dDhsUE5OVEVkTFlRZ0d2cGZQcXlBeHh2QkFiN2ZDM0lUWnhGdDI5N1ZkeG9o?=
 =?utf-8?B?VFg0WnZ2YUtkVGFqRjRrSTBhMTM2TFdoVXQxbGFIa29iSFZLdmVXL09GRU1K?=
 =?utf-8?B?NlNVMmhxSXpPR0VmWTU2N0NLUUcwTE4rcU1FOHhseUE4YXhYMDZ6d09sUmxD?=
 =?utf-8?B?NWpkQ3MxSDhMU3BMalNtRjJVejJKZktFUGhmVnhTZDRTY0xsTWtqWmpKbHJH?=
 =?utf-8?B?eElhUzFtUGRqclZTaGJZamxIVGR5cDg4eVh1MW1xQzhRbkFvdUZoTGdGT0tI?=
 =?utf-8?B?elNUNFcwYzNWWTBKTjhQM2xWRnh0MnkzR0pUKzMrK2FsL0JkR3FzMnZWZXhy?=
 =?utf-8?B?N2RaUXQ2TGdSTVhJZ3g3dlcrSEJwMi9tS2R3UnRvSGY1aVlNaXdGTXIySGYw?=
 =?utf-8?B?citITFVmeEN6QUZTakFFZjVYNzZueUkxclhYK2NOMHliZGpjd0FyUFg1SGhU?=
 =?utf-8?B?U3JUUGh6LzNNeEVSSHZXZXJtSlNvT2tDZ3FsRWRTSFlWRGtaRkRWaU1FM3Fh?=
 =?utf-8?B?M21xc1VYUlZIVk5qeVd4cDFGeFN0eHl2Vjc0RDVFMERuSS9rYzRuVFRzV1dT?=
 =?utf-8?B?cndRSHp4L1czdVl1REdzZ3ROdnJaSGNjYmZiNDJDMGp6ZVM0aDBQNlVzVm5G?=
 =?utf-8?B?N3l0TDdtakZwQ1ZhUEpYbDUveU5EdmtpVDJSQitCY3FIc2hjV3ZtMU1UMHI0?=
 =?utf-8?B?U3VEMU9mcFMvVmFmbEx1TGd3T3FZb01ESE9FUzZsRlZFU1ZDeUZ2RGs0Qnc5?=
 =?utf-8?B?aUVqRTluT3dDSjRzWHh6OHJCYTN5elJOUllqN2Y1MXlwZFpDTUYyTW1weHRk?=
 =?utf-8?B?NW5zdnBFN2xwWWVjcURTaXFrYStiWXdKb1FQVkZCRHF0emNndnJJdDlyYVo1?=
 =?utf-8?B?eGUzV0ZORkNMOUtXVzdmWDRuQ0RtTEJPbmcvY0tlMUNmVE5mNEFqNmpJZGJ2?=
 =?utf-8?B?dFQ3MjIwcDNnV2Q3ZGRsL2JwN1JrTGRITG0xbG1uZEFwMzJ5WHhHeFVGaHlC?=
 =?utf-8?B?ekEydGgxNXpSUzZiazRPdU5UdzJTdVowUmhUOG1aRE1xa0g2OThMQ001c2RS?=
 =?utf-8?B?K0Zpb1RZK3p6SkNzL2xvcXhPS0hONjFhcGJGam1DTDVldmpNYkJ6Zm5iQXlv?=
 =?utf-8?B?L1JiRjdEVGxSemltNmxlOHpyellqMytjZXUzZGQyZ2EzMnlvREFxejlpcTFw?=
 =?utf-8?B?K2VRQ2NxZ1Q5eVFoMld3aEJkT2NZem5PSzNtaFNoWTVzRk52cUNUZmJibWZY?=
 =?utf-8?B?a1lYdS9GRUhrMjcrTmQ4Z2JMd3EwQkRXTU1hR0FQelZKeG9MdERpaitkbkFi?=
 =?utf-8?B?SitCZDEvUEs5dGM5REZGbXh6T1FQTEpTbnFOWndib3pMd2NkelVuZTRqNWNH?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7a1493-0e4a-47e8-1cd1-08de02a93c37
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 18:18:21.8622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKR9bU8N+K5PQDsAiClxjPW9i5dxb818pDDIWyvT7dakfUttDWxChvrhTBHMRlh4A+Z1Wu1QoJeMA/Kc7zSvMo88hRPoDcUkqqeZcAAyBDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8558
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> > Per-above, just drop the 64-bit policy and assumption. It will naturally
> > fail if the required number of address associations is insufficient.
> > I.e. either we are in the AMD situation and no amount of address
> > association is required, or we are in the ARM / Intel situation where it
> > assigns memory then prefetch-memory (if both are present). If both of
> 
> Intel can't assign both memory now.
> 
> In my patch, the new policy only applies to pci_ide_stream_setup(rp)
> which TDX won't use. pci_ide_stream_alloc() just listed the 2 memory
> ranges regardless the actuall number of address association blocks.
> That's why I said TDX is not the user of the new policy.
> 
> > those are required and the hardware only supports 1 address association
> > then that hardware vendor is responsible for figuring out a quirk.
> 
> But if we want the address association register setting all controlled by
> PCI IDE core, TDX is the practical problem and needs a quirk. I see there
> is only 1 address association block for RP in my test ENV, and the test
> device requires perf memory to be IDE protected and later private
> assigned.

The address association setting is not *controlled* by the PCI IDE core,
it is simply *initialized* by the PCI IDE core. The PCI IDE core should
always be a library, not a mid-layer when it comes to policy. So, if TDX
knows that only prefetchable memory will ever be protected then it can
do the following:

        struct pci_ide *ide __free(pci_ide_stream_release) =
                pci_ide_stream_alloc(pdev);
        if (!ide)
                return -ENOMEM;
	...
        rp_settings = pci_ide_to_settings(rp, ide);
        /* only support address association for prefetchable memory */
        rp_settings->mem_assoc = { 0, -1 };

[..]
> > +	/*
> > +	 * Check if the device consumes memory and/or prefetch-memory. Setup
> > +	 * downstream address association ranges for each.
> > +	 */
> > +	mem = pci_resource_n(br, PCI_BRIDGE_MEM_WINDOW);
> > +	pref = pci_resource_n(br, PCI_BRIDGE_PREF_MEM_WINDOW);
> > +	pci_dev_for_each_resource(pdev, res) {
> > +		if (resource_assigned(mem) && resource_contains(mem, res) &&
> 
> We still need to cover all sub-functions of the dsm device, only
> check the need of the dsm device is not enough. But if we check all
> functions, we don't have to check then.

True, good point, no real need to limit the stream just based on the DSM
device just do:

        if (resource_assigned(mem))
                pcibios_resource_to_bus(br->bus, &mem_assoc, mem);
        if (resource_assigned(pref))
                pcibios_resource_to_bus(br->bus, &pref_assoc, pref);

I was hoping that limiting it to the bridge windows that are used might
naturally result in the non-prefetchable memory window dropping out.
However, better to associate all downstream memory by default and let
the TSM driver trim associations it does not want to support.

[..]
> > + * pci_ide_stream_to_regs() - convert IDE settings to association register values
> > + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> > + * @ide: registered IDE settings descriptor
> > + * @regs: output register values
> > + */
> > +static void pci_ide_stream_to_regs(struct pci_dev *pdev, struct pci_ide *ide,
> > +				   struct pci_ide_regs *regs)
> > +{
> > +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> > +	int pos, assoc_idx = 0;
> > +
> > +	memset(regs, 0, sizeof(*regs));
> > +
> > +	if (!settings)
> > +		return;
> >  
> > -	val = PREP_PCI_IDE_SEL_ADDR1(mem->start, mem->end);
> > -	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(assoc_idx), val);
> > +	pos = sel_ide_offset(pdev, settings);
> > +
> > +	regs->rid_1 = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
> > +
> > +	regs->rid_2 = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> > +		      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
> > +		      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
> > +
> > +	if (pdev->nr_ide_mem && pci_bus_region_size(&settings->mem_assoc)) {
> 
> I image the quirk for TDX is, reset the RP side settings->mem_assoc back
> to {0, -1} before calling this function.

Oh, yup, you predicted my response above.

Now, I worry that some device will need its memory window protected in
addition to its prefetch window, but that is an architecture limitation
that the TDX Module will need to solve when / if it happens.


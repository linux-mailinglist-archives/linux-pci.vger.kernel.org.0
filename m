Return-Path: <linux-pci+bounces-41574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8C3C6C904
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 04:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58D184EDDFF
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 03:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE8720D4E9;
	Wed, 19 Nov 2025 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INolBUM0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1FB279792;
	Wed, 19 Nov 2025 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522405; cv=fail; b=RsEaHbIpEBc1wdPWDupJsGGWMCwIvVsfdhPHko9q/EH7py8MLnq1jinP7yuuxGpchuUE2UYNKtq/FqaOLsc/To3mVs3JImv+8KjyXS17AFUSmy6ueJohzpocKKGh3FPlyDiCxjhAQdLoo8XejMH/b1xApUiKwM+2tNvgR49d1Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522405; c=relaxed/simple;
	bh=5XcnsRaWpURtTb7P4KqiUUXXmNARZiCpUlCaPFvhAjI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=fgFRvIAX+jxVzXPESMGMtdNfaUgo6fkcmvcOXX7oPF5XhnmXZt3t6USKa2Tnn5TyhwJ2Xu6bEFiUAgYOF3I5DKm9utFUapAcBC0idqqO7jK9mEE2Kv+rBXgvW+KFeLvaVW59bH/ZvpD6hXAXcdVjy2r8Jehgd/62x5QLaWBvyJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INolBUM0; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763522404; x=1795058404;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=5XcnsRaWpURtTb7P4KqiUUXXmNARZiCpUlCaPFvhAjI=;
  b=INolBUM06ogECIjhbPKIhv/+UTh7F8ej3PMqvGeq35KEYNmkygp3tGNe
   0Aj2iABoaY/kVmLlEemCoUomIGEaAjNZdTVUcjJLIT4jisfWPd+0cZekY
   UJRl+4bDFa/ENfuvbJCThwsp9b9b3SeZkNPtCqb6HgRqpoUoZrAcuOzWK
   WS98CgjxxXPy5rW9Er7Dp1a/YunXiDROKpR4WmsFo4AE9HApnxqhCG5qX
   2/sCJdF6JAxSlsiCxV1Sq7jKHY/Si9EdYYZ4cAL68NP8tt4+r/qhWHNEY
   PJjCgDcbQZfIyLax/gUVfL3kIYf2O7NGK5UQVjU8N5v26YTYyNopKcsKn
   A==;
X-CSE-ConnectionGUID: MOZp4AypT6CCjoDd+KgtRA==
X-CSE-MsgGUID: a3Fhy4MWQgi1VNjDYwq1kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65497551"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65497551"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:03 -0800
X-CSE-ConnectionGUID: TyDwCzSISOuhGZ6dCcF44A==
X-CSE-MsgGUID: 8THNbUFKQUGQRvXMCQEmFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="196067531"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:02 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:02 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 19:20:01 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLOgXTYyGdL4mgW4c1SsPwLXH5CSwutX9q+d28sHJm5r7F/Gv5qPAqyIl+Mz9858XShS/QqubXYiYHqJ4ZokW/QVXVsfKPIcGZXgLzfoxQAsGdYciXGUvq8ZY6e9/rA1rou5hZGgaaJ4bBiI+W5Fw6V5z3BhVlt61dIthi/zN4lQUraDTGm0wSw2iG/dMb7od5WZQ/zTbhBlb0Di1MvZ3tckwVZFv9U/eneXDrS53JVmnKQniI03mHb+ZFoxPqL+6Q9V/qB92oRSNGqoOLd7tLcjaZ/986l9JApDc9z9ZtqmXywp40goC4sqRrBrQJOfCzf9A9TAAB8VzQE4DE/pCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8YqC5JYIvWXlVqCsh0DMiVq3lvooZNe817ANF0jL+k=;
 b=iMDxvFALa0hPnEoGnshsYwFrCQYt8o12eJqfmWx3ykvs+6a+PZgqgEOGjeY2LnFstVChX8boYwKJT0OtV8peo6xHdnx2i8i+2la0oFZKKaYRItXDuC/sAl3ynmA99/lOcxXzRfHWmLJqUKu9CK/h13tynjnUZyKwhF6KDYqvY7x4ITFjoihcwWCdOshINy4oHUh1x1wAu7VFq8KXlPzK4Hm0KtDekVQ+B/mWs8zZfxSHC4aeYJYN3D13zDaQF5ApZIPFqIr82xfsupDkqNE36KLq+cyZvy37xepidKdaE3uNkkZbXHF31jOqjAcJ6WnSveaoBvPJu9jqDDS/j2ZVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB8937.namprd11.prod.outlook.com (2603:10b6:208:57c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 03:19:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 03:19:59 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 18 Nov 2025 19:19:57 -0800
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <691d375d78bd8_1a37510040@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-3-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-3-terry.bowman@amd.com>
Subject: Re: [RESEND v13 02/25] PCI/CXL: Introduce pcie_is_cxl()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5311c8-7874-49d9-749e-08de271a8564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXROTzRDTUtsYWhkVitiMEhna2dNNWhDZm1aSDU4WmdCMTRGUVc0TVV6dXdy?=
 =?utf-8?B?Qy90dkxhOHltZisxdllCSGNOWjA4TXZGZ0UxU3BteDllZFVGV3c4dVlRajg5?=
 =?utf-8?B?QXpEdzRzRmVlU1BIcm15Y215bUpOS0s3VUoyNDIrS09KeHh1Nmh4WW96RFdM?=
 =?utf-8?B?S0RkcnQySThZc2RZaGxiT0dOVVhEazBXLzJ3NUFLTFhqMUM1Q0pSVU8rWnRR?=
 =?utf-8?B?SzVob091U01naDlrYUtTZisyNnVnbmJBNW4wVlhkdjJlT3Fqa3BKZFdhNUdR?=
 =?utf-8?B?YnJUNDBIMEwxRjNMMG9DNWFyQnprUUxSRkNSOHZEYmdrQU94cjFQSUxHbWNO?=
 =?utf-8?B?d3hhK0JYME9YMTVhazI0KzFUSlp0UmRtZmZ6eTRkQ0ZjMHUxQ3FmUU1EN1k3?=
 =?utf-8?B?a0JQbEZyV0tUckpic3JGU1FFd0E1Mjhha3piblUxd2gvcVQ3cEJ5MmppcStL?=
 =?utf-8?B?Y0RYcnZIY3NodTVMbkd5RllWbUJMb3E5UDF2R0NWYUhiTG43cldWd3FWT1B5?=
 =?utf-8?B?eW1oeVpLRVVkTFRxSW44eFdSNnhUcE8xZU1BWmpzYUwyZnZHZ1JZMzAvUmd0?=
 =?utf-8?B?WWY4ZEF4VlRQLytwVHJteEdRK2lrOFlUMGlva3p3SDBwWTNIWkJYUHh2eUVj?=
 =?utf-8?B?UTN1VDJBOWIwa01EZm5ITHg2OFRUOGpjVzhlaGpJQ3QwVEFTQW5UTDRrQ2k5?=
 =?utf-8?B?VnJQK2x6SXh5Vjk1UDdJNURra2hIclI4SXgwcUwxNFVtaUZMMEdhWWgxUWI2?=
 =?utf-8?B?Q3Y5VldkczN1QVoxOWh0ZTVYY2UxalVRQStJRUhwUGtIYVd6aUUzQVFmc1Fu?=
 =?utf-8?B?R3EzM0l1TG1LWVpOQmJpRWZEMFJiN0VWcHBHMS9keGVVSUtnMVNLUVg4NGVU?=
 =?utf-8?B?ZVN1NkRaaFJkWlRDNmNWVUlBZEUwakZwTHMycXNGekdWVzJXRDFMbFk3Vk9l?=
 =?utf-8?B?QStVQkdWNC9mR3ZzNDZRenRCdGluUThpSmVSUXMzTFIzbDdhZjJKaUl0Vk04?=
 =?utf-8?B?RGVsc1hUcmJ1cXNiOERNUlEzMmhLc25nR3ZleUVWSUZxYmpSc3RTTTRaVC91?=
 =?utf-8?B?ME5mcG5ZcUdsS1lmclFuTE9JWjFKSDcvZm5XdncyaTc0UDlZenZtVkdDdWI4?=
 =?utf-8?B?MWxKQ29FNFdBbEVEdCtpQjNFWHZYQWhzQnlWcVBLSHRmbmFQaE9sWXRCTmk2?=
 =?utf-8?B?bUVFY1E2dHBLQ0YweExkMVNERWhYbTVVejluT094dmRoMjd4Q2lEUjBrOTNI?=
 =?utf-8?B?QzN2NlRhUHRuNmFSQ3ZNc0U3ZWpmYVdjMmd0M2pXckdvbHBVcndLV2dZT0Jy?=
 =?utf-8?B?WmFTOGs5U1dRRmwybXpQWXZ1bjlUdzBSeElEV0NCNjdsQ05TOG1Sd2g4Tkdt?=
 =?utf-8?B?RU4yOFN2RlVwVFNmSzI2YnRQcUU5Yk02c0dXZk5GaHBOdTVOS1VoVU9UMkFy?=
 =?utf-8?B?MGcwYmRjQzlySFZiRWpmUGJON3NuQjNnaUY2THZ2dzhEL0dYZzF6REk5UjM5?=
 =?utf-8?B?eC8wSU1BZCtRcm1Ba2lLMENBVURHb21tWmtUclRxRlREZk5UWndBVzRwUTNQ?=
 =?utf-8?B?dVlaSHlrL1FDN3VtTGE4YlNDOUZEQXltSm93T0F0L0JFM2U4T0MrY09uR0Rs?=
 =?utf-8?B?K05TNWhHc1ZKQTdvbjdnbHpWOFE3VFNNbUxHOG40SkE0b3NCRWFwSDAxTm9Y?=
 =?utf-8?B?cGx1QnU1cGVTK0tkYmx3L2F0TzAzME1UaUgwa2IzZlp6YU4xdTg3alFJOTRG?=
 =?utf-8?B?TjhQMVBOZUY4U3FnekxZZVdSalliZ01PSHBYL1U2V1J1UmsweEQ5ZWRXa2ZL?=
 =?utf-8?B?S3hWdzdpeVJ0MUVRQ2VyU2UwOE5xSWRXVlJZQW1sR2Rwcjc2b0JLUlVzZEtR?=
 =?utf-8?B?dXRzZTB0WHZnT1hCZXp6Q05jemdMcFFsK2paalR2VG9EcHdWYm84Rm1lWEtl?=
 =?utf-8?B?OHMvL3ErbkI1NHFFSU0vUXEzU1BGNlBubzFDY0QrK2szNFBmYnM4VVJZN1kw?=
 =?utf-8?B?S29UZXlCRlVVUXkzL2JvSlF5c1F1R2ZobEh5R0twckdsQWhJUWp2ZkF2UkFY?=
 =?utf-8?Q?x+tywk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2YxbHZxVVpiZEdRcDN4OHI4bkUzUHFxRkdLY3hYeVNOUzNaRVZnNEFyNXYx?=
 =?utf-8?B?MU1oSCtUbnpYTW10dmV6VkIwUkFjM0Y5OGJIU01JeU5iY21tVVBpdVBMSEw1?=
 =?utf-8?B?QndObTZmOGtYRC9NaEUwUjJPVU14UTFOV2NoNTFtbVR2ditiY21CYVFJbjlH?=
 =?utf-8?B?cGxHNUR4VnB4UUdncVJSVEdna3pqdVVhMVkwbWVGUStCRTlLR0dwQmdSKytm?=
 =?utf-8?B?Y1RYMmx6d3hOOHowM0Y2Tit6TWtVdGE2QUhLZzRlbkJ2ZVI4MzhmK0lRc3pj?=
 =?utf-8?B?M2plRTFCM2RIOWN5MTAwT2xvVXB4Mk9na3JOSEdYQlU2Skc1K0pMTncwa3dS?=
 =?utf-8?B?QXdFZW8wM1U3Y2gwaVNXT3JzeU1CMXlUL1ZZam9sdENmeFRSNVpGamhPMkxm?=
 =?utf-8?B?NXZSK3prVmZValAvQno1Y3B6SE5XTU1scVlCYUVMOWxCamNlcmVmV1p1V045?=
 =?utf-8?B?TzFCU1ZBeXkzcWtiYUh6QURqRjZsZGJPTjZUOENCcTZyeUpMOFdpRzdnODRB?=
 =?utf-8?B?WWx6U05YeGlxZk93UFNvc1ZXUVV6TmovRmx0MmNHSDZQT0hHeldidDBtTWFQ?=
 =?utf-8?B?ZkoxNm1ITTJmTzZOazgrc2ZpRFAwOGx5SjljL0xkYWs4VGNSaGpwT0k0RE5G?=
 =?utf-8?B?RlEySC9CZWJ4ajFibTF1UnRpSERwTjlqWDF3S2Q2bHh5YncwYzZ6c2xWTDhl?=
 =?utf-8?B?d3VaS2F4Z3JjOGYyRDgzSFlHMkdvKzZWeFhhQlFzMzhQTkxXNWd4dTkyVUcx?=
 =?utf-8?B?emF1Y2ZXZnJtS3FhNWU2SUZBWlQwdlIvRlFveDkxTXdZNFJOSG1URytydlpp?=
 =?utf-8?B?QmRKRjluRDZCZ0ZDbW14ZVRWYWUyMjVDU1NFNDdITWNMS3NkaThYVUNEWHRz?=
 =?utf-8?B?c1hRZGtoN21NTzdWa2RuZklvMkRTcjE5dG5SWVhsYS9IaWw1YkErRDRTcmlO?=
 =?utf-8?B?SFNvUHc0ZjVkTXg0UEExTW9maDFqZWhLTWtzNnhCY2dNWjYvWFd1Nm5oRXJn?=
 =?utf-8?B?NkM0N3Y2cVpjUytCODdZRjVHS29NVU0wUkt6SGdQYXZ4YWNEankwOUFYTnF4?=
 =?utf-8?B?QkZpM2ZBbmd6Zis5SEJiUW9iQUwzNHJzeUlXNHZtanBORmkxbUxZZGtaenM5?=
 =?utf-8?B?RkM4TlowZFEvTlhIM1JjU3VmQXVhUDZXdFVnQjJaVlNhOVZ1RVBMTEx4aDFR?=
 =?utf-8?B?NEltR0FUUzEzdGhZaUF4SENzRDZlU1pzQTI1SDJxM2NrODJWZUZvZ0s2eWRM?=
 =?utf-8?B?YWwxN2NocXlUUjdZVUx2cWc0SmxIcnMydkZzNFd0M25EVU1LT01LUDBZL3RV?=
 =?utf-8?B?S0g1UTh1NVlWeC9YM1hmL3dyNFZSWndoQS9sR3oxaG5HajBiRGdESlRvWFRF?=
 =?utf-8?B?VGd4SmhqbFRQMXRDdGM1bFQ4eWpzdWRQRU1XUlJxQnZSUUdPS3hFM2ZXUXZ4?=
 =?utf-8?B?d0R0UzY5NURVV25JWWZCMjdHZXR1L3lQWGFITHVwdGpQVmhTcWVJbCtzQXNp?=
 =?utf-8?B?VEd3MFFKaTdjNng4YmY3VjdOb3FWNTVreTNPcXc4alA1RXdWM0pHeE5BMzV5?=
 =?utf-8?B?a0FUZXN3eDBhdUdncWFJSnRrd2lncGxWd09pbmZSOU1GVW5XRlpIa0pGSWZ3?=
 =?utf-8?B?ZWxiM3VTVmh2TTc5VkRNL2pMUEc2ZjV5Z2dUcUdveGE2YjQyNGxyVDc2WXVT?=
 =?utf-8?B?QWFZZmxXelZ6Z1lZdm41VTBKUi9USkptZXAzdi9mVjljM3RJSjloeURZZytV?=
 =?utf-8?B?b0pDOW14VHZIRkU0QnJKTm5tWG91SDJzYUszNTl3V2FEZCtTVmVNcTRtRmQ3?=
 =?utf-8?B?VUhHWHVDVXBCMW1tVGc3WlRzSWhmdHFCWkdhR1dUMGk4bUxkaEoySXZEY2NX?=
 =?utf-8?B?eXh4VHNEUnBYWHRRUXdOb1ZPNU9xOFJuUFJrUFdkODZPNGhCSmJUQ0RkUmll?=
 =?utf-8?B?SG92cnRzRmw4cHpUTEJwZjVpU1Q0SEluS2pJNy9HSC94L1dqcjZWcnZDcGhL?=
 =?utf-8?B?WlczYm5zZHozcThhdE5zd0F6MGNkVzlIMXA0VGp3eFFlZ0FOUXhRUzcwSUFC?=
 =?utf-8?B?V1VidFdvQU1rU051cmVNQkM0MUFFZEQ2enV3T0FxWnA2MTVxalJMQ25jZ0tG?=
 =?utf-8?B?QzR6cXRQaDFhdnFRYjBkYm9ZZWtxZXlBSVBTUXZlQVNQZDRyWXgxV1lkWWVh?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5311c8-7874-49d9-749e-08de271a8564
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 03:19:59.5400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wz9b31ZG/Gsm9VmLuxRe/YUq3nwtkOEaDaTjh4b69NAleA8dcrg2FPbzy08N5DzCqjiNKyL5RTyWbSdYPHJO3ExV6Nh7Kxy4vtRusQrLig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8937
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices.
> 
> Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
> status in the CXL Flexbus DVSEC status register. The CXL Flexbus DVSEC
> presence is used because it is required for all the CXL PCIe devices.[1]
> 
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> CXL.cache and CXl.mem status.
> 
> In the case the device is an EP or USP, call set_pcie_cxl() on behalf of
> the parent downstream device. Once a device is created there is
> possibilty the parent training or CXL state was updated as well. This
> will make certain the correct parent CXL state is cached.
> 
> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
> 
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>     Capability (DVSEC) ID Assignment, Table 8-2
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> 
> ---
> 
> Changes in v12->v13:
> - Add Ben's "reviewed-by"
> 
> Changes in v11->v12:
> - Add review-by for Alejandro
> - Add comment in set_pcie_cxl() explaining why updating parent status.
> 
> Changes in v10->v11:
> - Amend set_pcie_cxl() to check for Upstream Port's and EP's parent
>   downstream port by calling set_pcie_cxl(). (Dan)
> - Retitle patch: 'Add' -> 'Introduce'
> - Add check for CXL.mem and CXL.cache (Alejandro, Dan)
[..]
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0ce98e18b5a8..63124651f865 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1709,6 +1709,33 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  		dev->is_thunderbolt = 1;
>  }
>  
> +static void set_pcie_cxl(struct pci_dev *dev)
> +{
> +	struct pci_dev *parent;
> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					      PCI_DVSEC_CXL_FLEXBUS_PORT);
> +	if (dvsec) {
> +		u16 cap;
> +
> +		pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET, &cap);
> +
> +		dev->is_cxl = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK, cap) ||
> +			FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK, cap);
> +	}
> +
> +	if (!pci_is_pcie(dev) ||
> +	    !(pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM))
> +		return;

Why are downstream ports excluded?

> +
> +	/*
> +	 * Update parent's CXL state because alternate protocol training
> +	 * may have changed
> +	 */
> +	parent = pci_upstream_bridge(dev);

This parent is a downstream port...


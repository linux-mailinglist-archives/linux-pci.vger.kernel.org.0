Return-Path: <linux-pci+bounces-22612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FE9A48EF6
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 04:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4D43B7944
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 03:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C559C17B402;
	Fri, 28 Feb 2025 03:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgQy2hI0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469617A2F4
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740712177; cv=fail; b=gPyDr0MVx96QHTtulw1xYKb9Vct2P1x647mx8GLj7IlQVoZuE86l9E+Z2RhvGxgjwiDt9jMLmPbZVwFIMg7OB/e+Rtzc3fpMbq3SFCtb55fQvggEd6EbxUM04edzUJI8B8DKgFkYhMLCwuvP9kIVaJRyEIQ8juOlCmZEy5Jr3VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740712177; c=relaxed/simple;
	bh=qUvLObUKedKZ8bJ7EdQxdtLLw0CsJtT++QrrbavRZmM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iutR7fBIKA05x8sfKsmsOWpZSTO2KkhtJpuH5+bgQYCs7DZkC30eWW9vsC/Vh/Vud2V1MClXc8g8Db9UsqPV7PgkkQHP0PvxU8ByDDdbIiX4M2A4smW5JQUCVFyvAcXtDzZoi2930SE6jO0/GbU8FvG8R3y6RFBmN5QDbdzgPf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgQy2hI0; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740712176; x=1772248176;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qUvLObUKedKZ8bJ7EdQxdtLLw0CsJtT++QrrbavRZmM=;
  b=cgQy2hI0U1+jzZdrqMs9IJHUiAeo01Z20yBdJM32UZM6fYylbVrlaTrH
   VgCEoKPiF0BnnEpRbUOXwEbGqFdVng3Z6JIm3uz6ALgy+KCYDkTNQAWHI
   wX6+vrNJKOZgg1K344siQ/7U6vje7ZINmx+1iwXIRAmoLsHBuzHUjveYb
   +Gx2SJSHvvwvOY4xAOWu0bO9VP8UtOCehDzXKCvLVOYUgTbfTQvMfMACw
   dFgsK7t8p5Oxf6V1KIl+jW4UR63Az6+ZjTon/RvxVWdghq1xc3C4awA6S
   Lk34rT8251L6V3D7XD77V9AT9TlEPy/OjZ7jeK5KmxQCqPnhT1fgJSl15
   w==;
X-CSE-ConnectionGUID: Es4y2U4OSjuwL3o3Q9uGvA==
X-CSE-MsgGUID: 3Uzp9E02TtGZyvQ3ruZzLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40875640"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="40875640"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 19:09:35 -0800
X-CSE-ConnectionGUID: Z/my5OVQSuuUDYO6QKdAwA==
X-CSE-MsgGUID: KiN2AAQWTh6aaR+pDyBmZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122441647"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 19:09:35 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 19:09:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 19:09:34 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 19:09:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqyndhjbHRT40TKPC2tNE0nahFcnTJjo0y/VMn+jL/V3uG+QzB6Cvh2NHlGiCl35YY7JhFfSbnRB/d9aXRR016/ob1o7JLXhu5ZsE5Pp12vfdwLxTgeUB2fNBxWnPwC17HtSyYdVWJagdXs5KwN1/fJhlJObdKI7ej7EwdJAQy9PYW7woQWd3hWxt/VKnQUn3yd9sThwcGqZBxQ9KG0yg+61vvDRRblB9jDXRqzRc45n9zm9N+GGzksbsLCNSS7TVM956ASkG5CuTMRcb3yRfLvDKJsAXdlAy7SCGmTvRkEgpLqil/LL1WUIPIFMgxbQiwDzj79D8Z9g+HmHvKu4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srZbJY2tKQ+u9cNtej5go+XvmF0fU4DPj5eBygcpMiM=;
 b=eabKFrY2qjnqNpc8NR51rTKc6dWXrHBkE/oGypgnxc3zMI1kcEHKdZrafEaZuJiKqEZUEWqAxfSpgL69VSt+ZdNPyEts14z6ugfRHQBTfECCrObSYLXVW3K1gzmt98j1XbQrh11SzzVaKQDObmMXckVEVJSeOPhhqszk0H2awri3eQdtFPS1MXQ4eILPmxoVTe9m4lVZ0UM5PlEcRNKdISB5CpI85N1+rrB7RK3LfkRzjHJmwTQPvu+jNCr75UADZ921Itb/nY1FrrLP7lSsWEzIzfI5bGYpLQyfvNxlG2lfSyxsfIw7I0jKbN3ETpAcVtfgGDGbOP/EuWhXQEsVkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYYPR11MB8329.namprd11.prod.outlook.com (2603:10b6:930:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 03:09:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:09:19 +0000
Date: Thu, 27 Feb 2025 19:09:16 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <67c128dcb5c21_1a7729454@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
 <67b8e5328fd41_2d2c294e5@dwillia2-xfh.jf.intel.com.notmuch>
 <e1864dcb-fa7f-4c34-8031-a22360c9bd2b@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e1864dcb-fa7f-4c34-8031-a22360c9bd2b@amd.com>
X-ClientProxiedBy: MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYYPR11MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 1249a3b6-5183-472d-7838-08dd57a54a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5YVV7AYKFOWJxG7GXtxZp5psx0dcjA/y32vbqJQOkvKTcSRB7T/Ux36WGyJj?=
 =?us-ascii?Q?PvZq9NfsjEJGc1ulAMjjJz4ahV4WbTXWF1mmh/CZejsGWCRzV/6tamXMacPz?=
 =?us-ascii?Q?mXpMwT2+JycH/6AlGSWQtftmUal+YOIJSuF0by6o7ZYwr02g0fU6YEW95gGn?=
 =?us-ascii?Q?ZvqdfOLqH/Sk264dpVQGLLG8WmpXyVA3ClA7JZ2cQRulRw1fxGIMbT+mmY2j?=
 =?us-ascii?Q?/HWbmfWVBMrcmMt8McHaDHlXshSvCkpHtpRuARGZY6kAnKc7GLXlMzrSzbH7?=
 =?us-ascii?Q?CLiqvm+7Y9mV7YgOw5obs1vI0aOiccmtiORxWJXRhTUNsMLkQbFvWfPk+CRc?=
 =?us-ascii?Q?Fp8/eI9NvKwv7Vm0pFUhM6httpU8QL8a4oioCjgaVCoFW0QoS0jEIHDPFEwO?=
 =?us-ascii?Q?zIo5ems0eNqwzKz4WiPlxQ84MJxN5PgoPr01/TZmRIcLTA5GySi9s3XJzj6h?=
 =?us-ascii?Q?qn3eh0FGqYBFXzArGquFOZ3zwBM9V4b0auAxrdsJUmxihizjYsR0Ja6sEiq8?=
 =?us-ascii?Q?LmiTk0CCXiSKC7TDnMtMDI41+ULclVanzlRwHSWbIucW+un0hlc4OlDTBgOJ?=
 =?us-ascii?Q?EZmV8Tx/2+mEcxLy4N8jNWZHXHkE6I7frZaxFAAUlL7opHbFHL57XoammpzC?=
 =?us-ascii?Q?skCedTHvy/qFF0udKiFnUbgRUpFlNdObPvMDvVYoX0WNwimJE15WNmujOg2z?=
 =?us-ascii?Q?sLS6OERjCgwtsSt5zh0QwlwidnyO5fTpOXgfmIVIlBhPoEb1wvwke1OCsk3P?=
 =?us-ascii?Q?DX4wrkppk24j/O8HasyqQ9D/gpJdnZrRZVlYGQ3K6Eqo5FC6pQTE+vxFHAFk?=
 =?us-ascii?Q?oytvlwjvFNrCeK1AC7N48E0ychoEW7LUr5upagsNQPXMGDDBCT425Lu1zmN/?=
 =?us-ascii?Q?OhEt9BxltN89bJgLdgCWvDY2lca6HISddsxFRx8ysOkT7u7T1ULlPVy+m/Xk?=
 =?us-ascii?Q?IWifRBVXfXR2VeRwc98+Ub/UQ1kBPVHd+46biMDfZt8M4HCZBEEW5ISzMfBX?=
 =?us-ascii?Q?oLAxbNVtk/ZzuJNjQLPmjBVV0yCbPUnoeDUtuadGPNcUedhrr2Rho3lYzNol?=
 =?us-ascii?Q?vjMyPE9Uh0zqobML96GPI6DNy568Yn5tHsvQ8JlY3L2MD8dz8vMil2LRrfSs?=
 =?us-ascii?Q?+V152Hg6lVIrjYIUE2iwBFr1KRFa3w9jeTYUVM2U8WEjMQjRunftOZosJ9JO?=
 =?us-ascii?Q?8l7AjlMXI3CWPO4/Xtkf4CAph8D8EB03HZatEgy1oXyaAbQVT/y0j4G4qCBk?=
 =?us-ascii?Q?zaQGwEOrC8JZKgigVGZ2Kz0G/niwVmDtK+Ngxl9y9TB/bXMVguF3GlIcxKWn?=
 =?us-ascii?Q?xQHo12RfGHX/g9kQfYgaPBlZ8tTykED2OqiJippQgcA07SnnsMKuVY5gHTZn?=
 =?us-ascii?Q?72t7nTYRBo1k41MOrfaifR/aPFyz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nottA2DidLyNILTnwS6OODf6OgoO5EO1IgOCsPwzN0n40amDseRcLRNG/8zV?=
 =?us-ascii?Q?WjU6KcUTMBrZg1JE8KT0/Ijolwwbkw61DaHPz9gVVmB5s8uY0dYAW1ol8wiO?=
 =?us-ascii?Q?dRU9QHQDA7EQ8awqhtNknwEQljJljPp6dW5p6Ix/CIZDbDArkm8hhpPKk3Ef?=
 =?us-ascii?Q?9LwIttnZwuOAtJQwKmeKVKdvMyDqZufuBOqOffPHmRo3uEzVPn+HL1zDKq5M?=
 =?us-ascii?Q?pM4trOnbTr613w03fQ4gSmnOpmHZGVV+cJb0qVmYBnYE47jb5+9oSN+cHiAy?=
 =?us-ascii?Q?iQ2cQ3r0WcP9Iny1ZGKTgJCpSkLgO2APAdFRrc7PEeZYIFmD8WY2B3YxNRRq?=
 =?us-ascii?Q?c9kZQ6T9+XByg/PnpmKdjcy6ksQNkAGc1ZQRqENAwqhKaZd4dyb2VZTpMB/d?=
 =?us-ascii?Q?sSOO1nNdEsxnFAY47vU1BS295h+GsY42N9UfXnil2zG8CBgIQQ694FXVbxf1?=
 =?us-ascii?Q?zI4jlPwnfU6/RDU/J8ZbAK38BQnZB6dKLXINap4ztR9bO0aiUteBy0EuiaWn?=
 =?us-ascii?Q?I39IcgH8LPf5uYWvB5mD16mPaNycHbZG6u86iO3GGmjsa2nS/p1UZrA0aErn?=
 =?us-ascii?Q?CUR1PtTXc3UPvE/T6ojBpHv8fPTAVmZJ9ruZLJODyausbEX0rsT5ph2EvJFE?=
 =?us-ascii?Q?S0hK//nYJgh0qAV9G2Ud3Tyr2leBlXWd2o6C/eOneg7fT8wGGQM4G0DH4C7S?=
 =?us-ascii?Q?P6GUHGaeOEmiZI9XBtEWyOJs5KgWlqWCu80UGsiSmXdbp/Uz6m9vh3juCyhv?=
 =?us-ascii?Q?9umwZAsnA8YAxr5UWYLT1SCiJXmnOMvJGOwiT4Juyso5pv9pJbYh6xSatTFZ?=
 =?us-ascii?Q?R8sOlAZ0xOUup9JZ9T7ZdSA5ApCoZGgMOhT5vF5bqdbKmlmOrJ1DaQ41gO6h?=
 =?us-ascii?Q?Lpqw2rVcotP0jGaCJMh5RBCtBwYu+KeNeQopSwAC5/O4z5IWxMDd/hQ9014T?=
 =?us-ascii?Q?qBFW6ZySmq9lWU5jCa7vdqVk+NLN61VIGuHBluzLf49/5xPhtwOMf/p+8pLq?=
 =?us-ascii?Q?R5zwGlP6dzepNXmCzVdryqgQkph3Vdxu4g43Wm/78ccDez4OKW4Zq2z2d/mh?=
 =?us-ascii?Q?H0bPPzQROG4Eb6i8LAYTyXdz8fpki0DeI4616NeoBy+J5zJu/PWeeg7wo31m?=
 =?us-ascii?Q?WUQWHPPtwv1pfPUiafC/48/GGgTIlLE3kQLQhEfClHGsx7Obaoqa3ZudSMyp?=
 =?us-ascii?Q?vufi+tGtv8j/Kpjy5vl9cdtUNAzbUbkpOaTnnuuoG2yLMgoHXTjrE2Ytq2qs?=
 =?us-ascii?Q?eTWaq4q4F2d8/1Qp2EIRj6Ja9RTDMoxX34v3lBJTQIBjlerzSnSnZYtHUs8P?=
 =?us-ascii?Q?PYIT9XnmxH1x35C9c3JaBlMo2ag7csKvpTjLgapTn5+DXIUOkxfYD94G1Nhm?=
 =?us-ascii?Q?n+d1Qqfy4pq9NH68kUmSaIiLqyc2jyqDafIUyTeI/7NsJZzxhuQx1pNdn0xO?=
 =?us-ascii?Q?+zwGE3+Ppk3p6D+2OOHmes38XW24IM0hudDw2ZaXWKHchuWSSHkiyxirMh6x?=
 =?us-ascii?Q?5q+Xh0hzDxbna/QsWEMq/WPFgeg5r8oamWv1H7BMUFJ0smMLI5OZ6F/rFdE5?=
 =?us-ascii?Q?MIYFOAn+MQLnGjtC2bAuent5CXpPEVHkf3ub+4EVd34a2NH58sEMpmNtknPz?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1249a3b6-5183-472d-7838-08dd57a54a8a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:09:18.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4k4jpPk40xpV5exqDMRnALHfFs22wMg89yeDRrjSphFNecfAEICrBwowkGnPorwFDAuVDGZe5kc1nQTxB5ImekuaE4NOR7K76iet1qPvFRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8329
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> >> aik@sc ~> ls /sys/class/tsm-tdi/
> >> tdi:0000:c0:01.1  tdi:0000:e0:01.1  tdi:0000:e1:00.0  tdi:0000:e1:04.0
> >> tdi:0000:e1:04.1  tdi:0000:e1:04.2  tdi:0000:e1:04.3
> > 
> > Right, so I remain unconvinced that Linux needs to contend with new "tsm"
> > class devs vs PCI device objects with security properties especially
> > when those security properties have a "TSM" and non-"TSM" flavor.
> 
> One of the thoughts was - when we start adding this TDISP to CXL (which 
> is but also is not PCI), this may be handy, may be. Or, I dunno, 
> USB-TDISP. The security objects are described in the PCIe spec now but 
> the concept is generic really. Thanks,

I understand the temptation to consider "what if", but we have more than
enough complication and details to settle without the additional burden
of "maybe another bus will need this one day, so lets commit to a more
sophisticated (more device objects) ABI just in case".

For the specific case of CXL there is already the TSP specification. CXL
TSP does not call for any OS support beyond the existing memory
acceptance flow. I.e. CXL TSP pulls CXL.mem into the TCB just like DDR
does not need any enabling beyond asking the TSM if the physical address
supports shared-to-private memory conversion.

If another bus shows up tomorrow wanting to reuse the concepts there is
nothing stopping them from adding "authenticated", "tsm/connect", etc
attributes to their devices. So the proposed ABI is not tied to PCI.

The simple model of "device has security attributes" is scalable in a
way that "tdi child devices" is not. The statement, "the concept is
generic really", goes both ways. It implies not only "TDISP on other
buses", but also "device-security that is not TDISP". Unlike theoretical
"TDISP on other buses", "device-security that is not TDISP" is a
practical concern. It already has patches on the list.


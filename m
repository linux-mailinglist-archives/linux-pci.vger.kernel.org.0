Return-Path: <linux-pci+bounces-26292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D34FA944E8
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 19:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59FB3BDD16
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F48F1D6DB9;
	Sat, 19 Apr 2025 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NtIawwwT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F911C8610
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745085043; cv=fail; b=RUtXL2iIznhaOVQPaaMhHtlLnh3ZWiJo9mqEW8ND9FtzU6VyBY25JREkV0/tnVpc2kX1N2z340GrJShsSVC6RMik9OsUaRVdyaWlM+OaBKcNbVnNUMBrxOrd7LpaG3eEgqQvTtpoVMT/tyxEHhG3pWTrF3YlmeSUBWbW+p8d4Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745085043; c=relaxed/simple;
	bh=2jXDFEbFeD/VbYIJmLtMfF+NdFNV8jLXXXhaohF20bU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qLZSdAVVJO859LvpqBJncvgcdOliy/HXW5sfCS/+SGtxhnX35YpsvtZ9fvpB0A1A6O1NUceO7/3twr/+XAVGU3AFp7AOxetzKrIWiSZRV2taxMtzvo/uIZeBWiTVuGvvwhA5SnBOqPwP+pNOVbp24Mjqd5/naf9+b9O8qCdcaFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NtIawwwT; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745085042; x=1776621042;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2jXDFEbFeD/VbYIJmLtMfF+NdFNV8jLXXXhaohF20bU=;
  b=NtIawwwTdbrz7lCyV07zIgk9k4f4j399xhsTmz/+LN+HsFFYTMtpvMCX
   MWy1L2YVUSPzE6aTz52TV2PS4k0TC6nJhVmoOlfpOLcu3E2dFxGXQb8lU
   EWe8x7Q6j5+VSybK+DyHkYLx/dva1bNrPy2Q5dvfJ8XVA7Zr44Obg0Syw
   ML45fTs5OyvTyEkwVi3YLJ9dCsIbhlswDEUA1x68qIHfORn8IzOJpCJFu
   g3kYZI26cv0hdty0/eMCAWbDdJPGzq5zKTY7Gzc5AtId5WSUUG3D3Imso
   CL/PWa7z/wS/oEKpdNl/POw9xlG3zWJDnAJhUmxB/rBe+P40wUx5RACEF
   g==;
X-CSE-ConnectionGUID: EwPu1WosQrq9Ym1YzNeGdA==
X-CSE-MsgGUID: +CDps06ITVOZxrXvtJE4Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="46782822"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="46782822"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 10:50:41 -0700
X-CSE-ConnectionGUID: sF7+TbtPQFuvE65LbPl2iA==
X-CSE-MsgGUID: utpoGNZlRfqTPfjwyYjHbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="131898708"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 10:50:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 19 Apr 2025 10:50:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 19 Apr 2025 10:50:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 19 Apr 2025 10:50:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUtIrZd4wxfCFzcuFsyEPO75n4uIjvlQJWzzmdw21X0Txse64P09Klx43B93Y2IAR2JVnR1pxYBB6H+kPUAz2vGlEWpocq1KT9qNygkIN2ICcUNQKcBrL70i1RgbdK9MeX6ZmqMDWqX15wf6W2mW7oQT5QZFWEggB5re+/AmOAwGhlwK5r51vXmHipgvE1UO38qO68QXmF6e6S+Gdse2Z+GMWkg2Gu7GIhMm2fITUMYFWiy7oKQoDLtpPnaNPjb+kGEN6pf6KYXySVkx3DH4VTbvj8C5XroZK8M9uAPZ8eftzr61aoMXgAf/a9f/HBsE6VLJ7ICRO2lFxzw584Hivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwZ3yl+Qb01kuecd5YlUI/X8WtZa2ihYPIL+bLT9uXI=;
 b=Kkd65U/eHoL0PiOMRF/ZmoZKi6/zUZDv3pA2+8IBhTp9XX5b1278VQ2tnYImbRpvDdvAn8kqj6ooMSQRNVrEO0frjLwChBFjIY68BGP7KeH1IC6Mljw/pD8Amp0TRoq85xo1rAHTBYnRvSk0KVmtpZddij6iuMlFKLhaGvh3He0N/KioQoM94W7P7aFW8cArotfrUKxe2+SammaYLG+mWIjsYptKzqpEmx58x0yofqisnS0QhPB3fFbxK2QlyeTUl4H306d//jS0Gxjpu/sWxxFY79qj+s1vJ7d4DC2pdTgXgZ230uidnvYqqAKWO6Q5hYiYhUR2bexIxjJX2U6btA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6892.namprd11.prod.outlook.com (2603:10b6:930:5b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.32; Sat, 19 Apr
 2025 17:50:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.022; Sat, 19 Apr 2025
 17:50:38 +0000
Date: Sat, 19 Apr 2025 10:50:34 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>, <gregkh@linuxfoundation.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <6803e26a9c27e_7205294e4@dwillia2-xfh.jf.intel.com.notmuch>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107250147.1288555.16948528371146013276.stgit@dwillia2-xfh.jf.intel.com>
 <032cd284-1b0e-4d52-94d8-e37fc9a759fc@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <032cd284-1b0e-4d52-94d8-e37fc9a759fc@arm.com>
X-ClientProxiedBy: MW4PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:303:b6::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 4293d7f7-dc46-49c6-6393-08dd7f6ab16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M25RY2lxR3JMZXJSQWcvMkRXcE50YjQvZjM5NTBXbnFlcGFIenpaVGpxNmtU?=
 =?utf-8?B?S3ViZytKVTZteVFpaCtDNE05VWhMSGxiRnZBd0R0OExCVUNoZkp3dXBFSmh4?=
 =?utf-8?B?WjVFMk1YVG5PZEdQMjdIdlJrOHIxUjVuRHQ1VHVuMS9SMHR6bmk5UTFvZkRO?=
 =?utf-8?B?MUFzUENoWmpJbUZ3WWI2MXg5VVRLdENaVEdPbklNVFBuV1BGREN2czI5bitI?=
 =?utf-8?B?UE92S2hMbElhc0tvZDVyUlliZVh3UjI5Um5Pb0pQVC9qUWR4d1diaVVoaEFn?=
 =?utf-8?B?Nkt3UndVSzI2ZG9TQ1NBNU5tK1VOMjBKd0c4bmxVaU1UWk9HQm9QcHF1QkVZ?=
 =?utf-8?B?STNSMC8yV1c2c3RjejZVM2RrV2RvR0xRNHN0Z0tMajA2OTlqYko4em9xZFhp?=
 =?utf-8?B?bGtQNDkvVzhxQk4rWmFQZ3M0Rm02WjRET2FxaHRVWVhCY0d5RzJKRm1XQWRa?=
 =?utf-8?B?YUFyZ2JsWjFmUklrMWtRRXBUMzlVTVVHdHdUSkZLaEY5YVM1NktmM0xYd3pu?=
 =?utf-8?B?dE5RQ3pUM2ZyN0Q5QjhEQ2kxbkhHaFZ2WDhlRHBPd3hFNEVobXBLL1ZhbGVX?=
 =?utf-8?B?M0F2VGxZUDVZK1RoVGdYaHVwSHJCNXlIZVZqSUdiK3VGb0tsUFE3VVlubUZk?=
 =?utf-8?B?MkF5bHhEdjZuQVIzQ2hWQmtaMUpMcjJ1SXFxRFM1dXV3ek5FZ0pQWUU5RTgz?=
 =?utf-8?B?cHpSaWxXd1p4YjZRdVlwbTVsRUVtTFVHL2UrRnRMZDh5VC9IeG5HRnJPd3BI?=
 =?utf-8?B?WmxvYW9mL2Zkam5lK005bnFBNmVVZms0NW82Mkp6ZXJoYXgzWGdDQ2JpMUly?=
 =?utf-8?B?WUlESzJLVHJseG1EbXFPdlpINncwM0lOQ21pMVNCMmEvOVBiYW4wdGljZ05W?=
 =?utf-8?B?NmV4d0JycjZDQWxPUEtEWkluc2lvUXV0cG9EWk9NWGhzT0ZYaVJzSmVKZ3Jl?=
 =?utf-8?B?UVhvd3h0dW1UTFd5VzVQN0YwMU9hVmwzNUJTUmdyaG5oREU5TUh5OGQyelRq?=
 =?utf-8?B?SG1xVVV6VlM3cFRKT05sMGFMVy9FRFlwUDBIZ2ZVbXBKdVBhc3VKTFNXY0hq?=
 =?utf-8?B?blh6NUlwc2M4Q3d0WmN2VmJOZkJqeCswTnVKaHF3WW11byt4SWc2aFBTR0Rs?=
 =?utf-8?B?VEJrZzBzV3R6aytLRU1nbVdzc0p5UkpmRkhDdy9HUDZ5ZzI5TzkxNzdFc3RK?=
 =?utf-8?B?blpFSTNqRHZUUXhHbnByVW9hUVF4dWowM2VrOE9ZK0NwcG4wbENWV2orYTI1?=
 =?utf-8?B?SzBDRnJGVWRMc3MzUExQdUJ5aitvNFh6U0l2dmh2c1ZEVDNJNlk1VHhKUXNn?=
 =?utf-8?B?amttK1BWYUlpYU5yQ01jellsZjZyY3hhcEM2V3kxOWJiYjRvT1ZHS05Ha0lu?=
 =?utf-8?B?bER1Ukl2c0JjYWdBUmdRcWh1VTlpNHA3dEk0VnNQeWVhM2YwMHluRTR4eDR0?=
 =?utf-8?B?UktyVHROMXFUMHFKRittWkFWU0RhNDZ5R2NTcGE5dzZuWTZ6UzVkU1NqRzU2?=
 =?utf-8?B?QjFxaFNPYnVheTJMaXZhdTVuOTJqRUd5bzJGd0ltNmNFVS9UcXpzd0FYWk9V?=
 =?utf-8?B?V282RXJaL2dEcnhYTVFpN0JuWkw0LytHVXJDT1FSZ1A5dk56RVhBV2hiM3pJ?=
 =?utf-8?B?N3NZZmRKNis3bkFXcEFnNUpZUWUxTGcyVWJ1ZEpIamh0WVpHR1d1L3dnOEpX?=
 =?utf-8?B?OGJiSUR1dlVkSC9UTzZTRlpIWG9jQTZna0RiSXp0NnhlUk9KaW5yWWUwajVy?=
 =?utf-8?B?cnA2TFAwcDBDeThZaGVQVlBvNi8rdlF2dHhxQ1BUYURTK2wvZ3JFYkMxS3Vh?=
 =?utf-8?B?Z3FZeHhaQWVaa1Fob3VocVNsbzNPekdoV2J3anBkY0k4azl2cFhCZ1NUeXdL?=
 =?utf-8?B?SWt4dWNsekVWck9IVnVGWHVzNWozOFVzeVZKeCs0dkY5dllhSkdSRG1MUTls?=
 =?utf-8?Q?1r3Y9BjzNJc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJhQkVLWjhsNGdNNURJbDBJM1NOYXd5aGo5Nm9xK2FieFRMZVFFMFM4djZs?=
 =?utf-8?B?Nm83QlZPRWtVV1J4d1NtT2ZweU82SFhoTlU2TWltb3ZIZlVRLzFoOUJ0NnBk?=
 =?utf-8?B?Y2htYTZ1N3FzRW1JRHo1YzRaUXNsZnZQSlkzU2RQNGVDQXU4OENLS09LOFRW?=
 =?utf-8?B?WjA3UE5kdUt4SGh2UU5OWlpJNkQxMmp5bkZ1M1hvQnRzNGpMOVdQZmoza2Fo?=
 =?utf-8?B?c0dTSXZNWDhMMXBaSjRsTUIrY2o1Um5UTFF0SklQcWNHRDJteWJMVDhNK0Zt?=
 =?utf-8?B?aTBEYnBibXpLVitiM0xoMWdORU8wamhXd3RpRkZWUmpneHN5cnhzY2VkVzhX?=
 =?utf-8?B?RHViVFVUN3R0dWJmNHlueERGeVBIUkY4MW51SmdxQ1VMY2hjVXhqd2lZZlNJ?=
 =?utf-8?B?SmRXekZPejV4bWVkLytDdGg5elNieis5dDkxbGwxc0pMd0djZUlsUXhBTnR3?=
 =?utf-8?B?ZFZnTzFCTTNmSjAzNGlob2M1cWZvYjJlamZ2ZU5WRndrUHdIbjlxVTZnMmtC?=
 =?utf-8?B?bkpqeklpb01oWlFzM2F2UGlQK29Dc2tKUkpoMWNIS2VKKzNxWS81VlZPVkxq?=
 =?utf-8?B?SW9kVGlUK1ZJejNpemJhNlo5cjRBazhiVzFWajAxZVFodWllV1NpOFkzUlZ1?=
 =?utf-8?B?TmUwa2RGcmJBTVRqd01mQlFlNENKZmlPejNXZEI0NndES1kwVjcwS0Y4RHFI?=
 =?utf-8?B?bk1GVGY4bXVQSmRRU1owKzRYcGV6MVVzeVJ3aFRoNzlrSjdMSWFrS2dQUmVm?=
 =?utf-8?B?aWEwam5mY1lETm5JanZsNWR5cXR0SkZYSFlWOEtBQjRHcDE5V2FGSmQ4UExK?=
 =?utf-8?B?dithSEFuOFlDc2JZZ00yM2pFQ2UvZzF5V0FlQjRWNWFhUXZXV21YRGRGcER2?=
 =?utf-8?B?MEZoTmc4dFpKOWRYdGRYOW1vU241cSs3bGhOekxDcDRRa2EvcHllNHJMYTFl?=
 =?utf-8?B?Y2VySjNDSytLWEhGMDQ2YW4vVG5QbS9LbDdFaEFqQVBUblFCZFdEUmhxVG03?=
 =?utf-8?B?cklRYWRiYVJ4Um9OVjdPTGNxN0dPZlY1emdSNjhoQnVwZnRsUWtGVk9BQkNB?=
 =?utf-8?B?VVEvWmIrdjNUVHJxYkMvYk44YUFOMGxWelNrR0RWbnJBU2hyY01yUXBSTmxE?=
 =?utf-8?B?OWpPUm1rTzJ6NXE5Wkk0cno4L3FQeEpram92MFA2bDl2SjMzTXdPM0xBczcv?=
 =?utf-8?B?SWlnUTNYR3F0MXc0QXFZdzI4dXdrOHNCQ285dW1wNGp6QlN1TG9Bdk9zK1JK?=
 =?utf-8?B?YnVtMThsL1FLWVJBZFBTNC9LQjZadEZLNHJHRVlZTzdXSnpwcEdoMlJqL0ZJ?=
 =?utf-8?B?TTBkbXc1VEtueUhDVGpzNHRJbEdLamFOQkdhRXYwcFo3ZEFZcnpJYWFNZXNE?=
 =?utf-8?B?Mk1SMVUyYnl1TUVEQk1SN0NwRHhCMnRtd2tycnB6UnNMbjhVSllOTUM1VHZj?=
 =?utf-8?B?K1ExWnZXYldQVUZjYXA2UkhSYUNwbTNwbnNGVEYvM2V1cHowL1JvdklaQmE4?=
 =?utf-8?B?b3doQ3N1KzB0ZEloT0lqYlo5dmsyYU14Q3Z1cGVDT0dsOVp3ODZZUHV6dXI5?=
 =?utf-8?B?QUFpZ1ZpbEs0enFVVHgreVNUSmRQeXVOcnIwRytNWmJ4Rnoyb0tHdHFaZkRa?=
 =?utf-8?B?OFFMbWlkVE1raHRiUkFDeUthRk5JZHozNi9qWE82WEhXc3lLTm5TN2hSZDVU?=
 =?utf-8?B?ZHhCUy8zMzFMaHZzbEovcENrcUNmY0Z0THgvRGFxa0lOTjNoOUtQN1VIeG82?=
 =?utf-8?B?NHYrT3hoaG04Q3d1bW9PV3BXTUNUOUs3L3NpRGhCSjFET0hZeVhVcmV1UEE5?=
 =?utf-8?B?M25abHJlZmtTbG1PZkpWejJEOTQvYUpWQ2hUaytQaFVhR2luOEZxZUxQNFhr?=
 =?utf-8?B?NUdBUC9neGtzWkdIS1RyUWk1Qi9BQjdFdzAwMDVEcjNjeHdHbGpuK3lLVTJ1?=
 =?utf-8?B?T1ZzS2dGWEZNOFZwWFE1YkR3TnV3WDNZK0VaOVZNTU1FMFdRRmN1MG1vSWha?=
 =?utf-8?B?ZklVcFdxWEhtOHlhK2pWakxUNnA5Y3ZQNEJqeVBGWjdoZ1VCVnFNeFFqTXRk?=
 =?utf-8?B?ZVdpYWdROU1xTEF1UUw4Y3BhMUVtMXRweDZ3RlJydnplK0hPTmV3TXVidFJY?=
 =?utf-8?B?aUI0QmxjYVI1cmlyRitzdFZVaVZPcUZoeUVxY0dhbzNaVmdjVDNmdngrMlZU?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4293d7f7-dc46-49c6-6393-08dd7f6ab16f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2025 17:50:37.9421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjGupHSX5MymXcjaCuMd2dBQAiVV+bA16uq25F4k8+7h2K0gFo6q99Gv8CM9Oi5PUAxaiIZPBvF/M+hsyZ7YffAr6gMo2Krq5vUBR42LNs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6892
X-OriginatorOrg: intel.com

Suzuki K Poulose wrote:
[..]
> My (relatively old) compiler complains about this:
> 
> drivers/pci/ide.c: In function ‘to_settings’:
> drivers/pci/ide.c:322:3: error: a label can only be part of a statement 
> and a declaration is not a statement
>    322 |   struct pci_dev *rp = pcie_find_root_port(ide->pdev);
>        |   ^~~~~~
> 
> $ gcc -v
> ...
> Target: aarch64-none-linux-gnu
> ...
> gcc version 10.3.1 20210621 (GNU Toolchain for the A-profile 
> Architecture 10.3-2021.07 (arm-10.29))
> 
> Works fine on a later version of the GCC (version 12.2)
> 
> The following hunk fixes the build for me.

Looks good to me, I have folded this in.


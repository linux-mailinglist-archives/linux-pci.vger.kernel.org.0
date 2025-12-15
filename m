Return-Path: <linux-pci+bounces-43059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FD3CBFDF4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 22:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAEFD3008E86
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 21:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A1E2DE1E0;
	Mon, 15 Dec 2025 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fz+2tztX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9F9224AED;
	Mon, 15 Dec 2025 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833092; cv=fail; b=diYfHsh44/LS0Gk7pKS/oCxGlp9sm+UdJIqPwMXmePVd0iEpntJDGPtlX35k2XUlwtnGrRpAvXrDshmYVGPvXYh1epKnlulHXvpQKSOBquDWaf5XXf+YAAHOMOzpke98/fwqxEoo8ZZcXqSPqmn8km0ZSlhBKMyfppN8g51xtnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833092; c=relaxed/simple;
	bh=2ofedgbrGl4QgVNmMKBUff2F8LrMRQQtbRwESDIPFY4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=cfkJSzYDTSFZV1nAZPHRbXiO7///UQgJJSuaHU9BTOoAGLqGgtGpMGGD/jIMSJ/kAPnoUr897B8ftXc51O3W8gfrHvxK+0neuiitWKLgvGOJckX/wXXMyEoZwfjw6+Envams5DoRry3+p18LIaiHFJqaZIwqkFJVTYfIUkL+iTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fz+2tztX; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765833091; x=1797369091;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=2ofedgbrGl4QgVNmMKBUff2F8LrMRQQtbRwESDIPFY4=;
  b=fz+2tztXUNZ5AF1nxSB2GRsSWNcbwLuJbTz9+7DUh/c7Ahkko5GJXihH
   0yI7/YyNGmTuW8cEXJPtCBTb/1uguB8LsMYsSka3HBF7x3+2i8IjiI1MQ
   YwkWnOg22ZfeYr2RDmL9mfohU1uOltwxiDmRP6urLOick6m+HA3A9xBIk
   qwXF02nmqyYkDzMF4wSbBQ8mbfswx/ivfBuGH3NYL0s5/nBDW0C7+jWk1
   KdBkudUcO/PHCuOFAe7DjL1I3kfIFRAtksi5uJxfgYgDNfY6BooWpjfqR
   06e6MTqEnQfSqJ0eU7NkcceSwrsgHtvD8dvX5i2FzxMxEIwICDU+npW1m
   Q==;
X-CSE-ConnectionGUID: 4P25apSaRa2glKEX1YwzuQ==
X-CSE-MsgGUID: O2oHQI2MTkSgQMZvZ2HQVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67687895"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67687895"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 13:11:30 -0800
X-CSE-ConnectionGUID: YyHoRfHsTKSCuT9rJ8wdrw==
X-CSE-MsgGUID: x+TBPYLyTKykG6rMdJopPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="197455452"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 13:11:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 13:11:29 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 13:11:29 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 13:11:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMth9ITJsoFfy+gSspM4ltSdptFxF2VXvPN0hj8SqWFjls4XB0B8GrlhQCJkksKP0jkHIN+3/JgnYy6QzfR5kbtd5r2YEQV1CtaSm+uOzhDXIGafU4Q/jEz3HX1uYuzjw3YwgL9uRXdARbHhSrtBQPvbSKVjFudDMqtiIF1bkV5JHloR3gJAFj+PBdh2QZUe0oJ8Mb+6vjMDf75tp5XkmWFuRlzPR0tJOMoE+58yW311/icFSZnBUq1/9R+qPEd0rYx2OOFoCoRIrfDa/eK+AHy3J1X3i810lW1c3bYqMl5iSVgVw0gN5ykAk/fwQaSbeq3YMtxxe9519myDz2qOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UnwdAL5Bq3/HtJaKR8S2x54CCZrWlSZ1Hweqqgw10w=;
 b=S6yrnEmyx/AHG2GKfIx8CFLHu4N6Kzc1tRQ6znyufHx3Gk448ff7ee0KoRkMQMa6BxFm7PXyZnQ2pyVqpLW2wArG0AmppZqtyDKlcEHyZJ7KaqaVwfLug4uEy33fDLarkQDSSavrI1TthkWoX1LwntkVBNTE/3OFpW0yIREwc7/2fni+NLPws9r0beh3Qm5o300nrPmshDRhP12B7L+Xsl/7CbHBGgx3uvvonDPFBQehh23HDd1KCvtCwTp0VCGIhIVX1YHi6iBy9rHllyYsD4zyc13Cqn3QGSjAl5Aq/81p1qixIzA+E8eGfAqSZBi//wDZudJKnTRpWN/GYZCjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 21:11:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 21:11:27 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 15 Dec 2025 13:11:25 -0800
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <alison.schofield@intel.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Shiju Jose
	<shiju.jose@huawei.com>
Message-ID: <6940797de4c26_1cee1004e@dwillia2-mobl4.notmuch>
In-Reply-To: <5bd14207-cc7c-4fec-8340-e8a98330d628@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-2-dan.j.williams@intel.com>
 <5bd14207-cc7c-4fec-8340-e8a98330d628@amd.com>
Subject: Re: [PATCH 1/6] cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 93523ae8-5e0b-4591-86c1-08de3c1e82ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UE9iQW12OEczUzVycnY3L0szNlM3a1NkNmpiazR6d0I2NDZka3ljNkpxdWEy?=
 =?utf-8?B?cVdqZ2RJa3AzWERBSVVjaEgwSC92MzdNM3NORk1tRXUzUzkvellpdHROOWtm?=
 =?utf-8?B?VmRtRWxvVkxlT00wbkd4bEYrajFMQ2Y4NytRVkxxdCtnMWZPVkU2dHhZbVJZ?=
 =?utf-8?B?SGNhVjIxRnR4R0VRMlpMdVF5MEdTM3N4NHZUNWNXQm1iMFQzaS9ZR1l6T2tJ?=
 =?utf-8?B?UUZiaGgwNXZUdWVpREdta0dDcUFGRzFmUEN5ZmI1TktyU1gxMENHclBVYWlr?=
 =?utf-8?B?d05ueEtTOUhlY3l1ZDJJM2JISmxyQm8yMXpOcDBlTEY1V1RMaVlWbmpWWFgv?=
 =?utf-8?B?Tk1QM3lZRVJsT3lHUEZ2Y05jMWlGVTZuMnVqZ3hnSmhGUHRDMnFnY2VEUEt1?=
 =?utf-8?B?eWEyQitXb0VwVXlDUE1DWXBZMlFKRjEwbTVqelBvdzZKM1hQNDV1NVE1NG1v?=
 =?utf-8?B?d2FLdjdsZXhKM2ltY21lWmVtVUY1b2JiaFUxdWhta1dRYzRPSnhxT2FWYXF2?=
 =?utf-8?B?RitOR3B5cFZCelpuSWhpUGVWbkhycjV4VCt5akdwMlVaL3dsa00rM0RScSs2?=
 =?utf-8?B?eW5FYTJZZm5JdWw2SDRMUDFYNmpEM3EwMkdMQmNXc0JCeWFpQ3BURHExYXlu?=
 =?utf-8?B?SUE5azl2N3pGRW9KS1dQaElRL2VOVE5qUFJYUjlCRk5NVW9wNmdIVm9tbUpN?=
 =?utf-8?B?QjllbnNDZjBTKzVQcmdGYUNNS0xBRGFLdHQ1d1Z4dnRNZjhMOVFabVUzMG9y?=
 =?utf-8?B?cW5ENGpvSVhuam5maTJORlJhQ213V25YUk0vdGhjRytDcVZWaVo2QTJiNGlN?=
 =?utf-8?B?dnpIWXVnWEpjOU5PSnFZRUJJcWo0clJ5M1hNYms1VHljRDcwSWpYay9JSEkw?=
 =?utf-8?B?VzF0OEp0Yi96SnAvSUlVTWhJQ3kzSDFQNk1IdG1zc3pENkRESWVrMHNzaFJn?=
 =?utf-8?B?eEFyaCtJeWFuNkY2ZDl6MndYektWM0JwMHhRMkRsMnBmZ0VmaDk2ZVhxeHlH?=
 =?utf-8?B?LzBMVCsyaHVtSkRicmQrWHVzblFPb3BTL2QvaEtyY1FtV1NmYlZwZk9yU0Fn?=
 =?utf-8?B?ZFlLazAvVE8rQVV0Qkt3VUtMRnhzalpEd2I2emxWZTI5RThpVDhPMnlNaG9J?=
 =?utf-8?B?cVo2cFlGdWR5SVh4UnQrZlZCcTVJeG5VdkpoQnQyREZ4clV3MGlkSjhVc0NU?=
 =?utf-8?B?dlQ4TXZ6ejZCQ2FsazltSmVBYy90RHJTY3EySmV4Sm93ampPc0t4TXIzUzhB?=
 =?utf-8?B?cUY3blptdW1BeTdPSDViWGVzMVUvUkR5QnhLQkplamZmaVUzMUV3anJJeXU3?=
 =?utf-8?B?UG5uOVJKMWQra01vWUJFMHFFYnRYRElJQmxuTXZiT1NjbERocHRDVWtoK3pL?=
 =?utf-8?B?Z2VuYUFqOUdyVzh4b3BDekQzNWxzaVBZUGV5WFkyS216M3N4b1BIeUJNRjhE?=
 =?utf-8?B?cWVHNENNeUFFR2JwVlQxTDFrSzZnakExRkFhSGU2NkhXNStKckJ2MXQ2dS9z?=
 =?utf-8?B?anNKRmQxVVVuQnhjQVVoWFJ6cmF4ODhieUVGNFFaS0tKWGNFK2RZWW16djFM?=
 =?utf-8?B?b2F3N2lyTGlSSGFwTVVlaWZpQjV0cENoclJ5QjB1OWg1elgva2lLeFhMUkRE?=
 =?utf-8?B?Z0M3Sm5zSzFMUGsxMTBnanNGamcrVFNtY2EyRHpReVpGR3VOQWtETDRLT1Nk?=
 =?utf-8?B?MThRUjBLY0ROTEREVVR3MkJCcURwZWI4YXFPVE1UTThwNzZHQjMrWmxWRFBx?=
 =?utf-8?B?NDBoUkVqUGtoRUJycjlZR2ZkdkoweFV4bDQveWtmbHp4eTNEU3dhdWxmYjFw?=
 =?utf-8?B?cGVrekJMQXNnWktnTEFUZ01iaSt5b3Fic0h0dGo0ZzUyaXUyaG1KNlpFUGUy?=
 =?utf-8?B?QndJd0pSS2pRNHNmUVFhZGt2dENSVjI3WVpsYklEWDJObFZoWGxiWkM0NXNV?=
 =?utf-8?Q?C23K7Px8RwMjb+a6tZgDtZtNQALZosBJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djFzQ1RXL1JoSk1DYnlVL1c1TityekRmYm5KcElSTUs5M0tjSk5WQVJ1S3Rx?=
 =?utf-8?B?RmJBcGJCdGU2QW9yZ1o4Sll0bHZYa3p6WFpyYnFFaDFFajhLTEJqbkdzUXN1?=
 =?utf-8?B?aGgzWmtoMTBKMlE4WVpGSCszWUxvVUJZZCtxYWdBenAvaldDUmU5KzBLSDhW?=
 =?utf-8?B?VjdUY1Q2VzR3eTV6eGI2T0N3SkozZU11N2JnTWpKbU5jUTludzdoNGh0VFUz?=
 =?utf-8?B?SUs4dWZ3WGtmemlCdzd2QUQ4RllZNnZDY243T2xWVU15a0ZRN0lIdWwrR2oz?=
 =?utf-8?B?NnpxM2l6SE9QOWN6UHYxdHJVZ2JWMnJmZlFtR2FMTSsrZVRNSnlwU2FmbjR4?=
 =?utf-8?B?OFBBZ1RrZzA2OUhiL3FVckRhQ1NCbUtYWWY1TmIwT09jWlhZZW1VNVArMGJG?=
 =?utf-8?B?eC91SzNITmdURlBjTmw3TVRPVkpldG8wL3BucC9uZm1SQjAvVG4xOUtDZkRS?=
 =?utf-8?B?UXJqSEpwelNTVXdLekx2RFQ0NWF0bFpkR2RYcXdkdy9VVERZK1h4OHZmQWtk?=
 =?utf-8?B?cWtFSEZScjVFYXozYlhScEFKRWRqNHRWQ3htWGNoUEtZZEVHUFR1SThXeGU4?=
 =?utf-8?B?RVN5QS9WTVlPeUYweXJqU1RmODB4MGpVNlRKejdSWjhXY09wOXNXTGk4Ukh6?=
 =?utf-8?B?RERySWUrcFM5NTlFWGl4OWZNMzJlZTdreDJua253YWNuOVpZQ1E0anNkNDZZ?=
 =?utf-8?B?RVkyYUYxOTVhcE1aQnNtZS96c3Z0WGhIOFFSNCtraW1FWHFJY3QrYzlCU01i?=
 =?utf-8?B?TG9hMWY1aWgxanZ4emFUT0tCQ0xSZ1F5OFlESFRIZFJRWHh2T3VqYkU0a2E5?=
 =?utf-8?B?M2dBNFJVM0kxTEpDdENhRnVzZDZDZFlSTFJ1bys1TWI1b0lESVRFSXJpc3cx?=
 =?utf-8?B?Ti9Pcy92RGZvSnA1c2l5bnBYTXNOMTlsRmpJL0xWMm0zei81cHE5elF1Tk5G?=
 =?utf-8?B?bDc1N2ErcDdjakhHQjdBSm1jTDhDWXJ2OUlvT3BOeW1ZZU5OcDJWRVUySGlM?=
 =?utf-8?B?WnZ4YVU3b2taT2FtSTE0dGhxb3hER2U0ODBoRE9VTDkvVysrdnlHSTRGT0V5?=
 =?utf-8?B?d09WeGI0NTBxR1F0SVFybFIyU3VqaDE0aVExMTNXdFpOVndIaW5SeWs4V0pP?=
 =?utf-8?B?NFMxWk1BMVBjT0FNT1dtQmZYSUhFaUllL01hdDhOaU5FcDhPTElxKzdXSDBK?=
 =?utf-8?B?N0ZOZEU1aERXTjMvR1QyY0UrNC9XajV5aDZ3bmJTQjBXenRRYzljbUN1OTFJ?=
 =?utf-8?B?Y1Jtcm9FbUJFbU9WdzBFWDlvVmFSK1hKN1EraXZwbFVtU2duNS9IaUdPcTJS?=
 =?utf-8?B?QjRxRVU2bnZDMWpTd01BcWRPenFJdituM3NLVnRBZjdOM3ZrWFpEV3o4ckk1?=
 =?utf-8?B?TGRsUnd5ZVNIY2d1RCtqOW5acS9qUWszNmtZQk5FUXJDNEljc3NNUTZVL0Y5?=
 =?utf-8?B?YXpMeFNLU3RXVWhYcE9YOUpIeUdLSUM0OUxvd3ZEK0VEcEdvZ2VZbUJJQlp2?=
 =?utf-8?B?R2N1MDNwQ3I3R3FTYVJ4TXNRa0x6MVYzVG1yLzgxWmFrMzFNOTh2OU0ydXYy?=
 =?utf-8?B?TUl4UE1GUFVRdlVUclFtZkFpZ0R6djd2dXZwenlSZ1lPY3FXaGRxTm0xZEUy?=
 =?utf-8?B?TmQ0cjE4Z2RLODh5VElCOXpNNE1KaE84SGpXNWpUYzBTUVlhWWwzSVBDTENp?=
 =?utf-8?B?SW5JWWJvZEQwd2dVeEZaT1EwMXlsQVJ1QndSdkhTTFVBOS9CZkVEQ2FsUktU?=
 =?utf-8?B?OWlFTUhPOFdTWmx1bURvWit5YmVtVmpMMGhFbnB3UDFvcVpLNmF6VzZHbzF4?=
 =?utf-8?B?RUREUy94ZVBuazBOKzZvYXVGa1EvUTI5c0VNMXJHTnlYYXo5N1RvQkJtdFRT?=
 =?utf-8?B?VCtDRzhia2J3ZjJBaWRYVUYwRldEQnNrcjhUa25DVFJIRDRtcUg1bWZHLy9K?=
 =?utf-8?B?K0JtbStlUXFXQkk5MGRINUhiN2RkU1dCUkcvUmpNUHhVU0M5YXFJd0ZpbVNa?=
 =?utf-8?B?YlNjZWcrREx2d29IY2UyTjFvTHIrTVRLMTBjV2FEcE1hQmI5cklta2llR1d6?=
 =?utf-8?B?VGtGOTM1MmNHYU5yMmZwN2E5ZEhqR3YzRGV5QUliaThBT2Q1SGhPSm9LOERa?=
 =?utf-8?B?Z1RCajZPaVl2aXRQd2VtM2JFMTBYQjJQZitiblY3NUtGSWlyUlhCQ1F1QUpT?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93523ae8-5e0b-4591-86c1-08de3c1e82ca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 21:11:27.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdjeXcjbVjnMyxA+KwdB4up/8eo7REGQKTLhnj//hnPWYlgU5C1ax9rdVbOsFgx4tA1liH/YUX0SH6M4vmolKU09lLWHDlY/KV7oIfMjbs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 12/4/25 02:21, Dan Williams wrote:
> > A device release method is only for undoing allocations on the path to
> > preparing the device for device_add(). In contrast, devm allocations are
> 
> 
> Should this not be referencing to device_del() instead?

No, device_del() is not involved in what this patch is addressing. Prior
to device_add() the container of that device is allocated and acquires
some resources. device_add() and device_del() are only registering /
unregistering the device with the device-core. The release method undoes
any resource acquisition done *prior* to device_add().


Return-Path: <linux-pci+bounces-39851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2174DC22588
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 21:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186F71885D0A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 20:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC6632E69B;
	Thu, 30 Oct 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7Jx7be3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307BD329E5D
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761857326; cv=fail; b=khEaWhCFY529r+IDN8+WSvPSar0Adr8onuL726Ga7fsL8nFK+wR6kY7U4IqLhXPTcf/xwLMz6PBGIQlhaXLw1K56M94Ip0Hxk13nvC1xKPsZhQTxSJchP/6Lv0VlpMj+JcuC5rTDYvw7wkh2QT0SNULaX5j9AawNiteR4tJBSTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761857326; c=relaxed/simple;
	bh=yI1kJf/Dfi1rIFwTfWgDfjG5yQBENOzTdOT4ObWI1C0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=t5j2NgmX9b05O0dEWOLEOlj8wW07nyi5B1SsQNGZZuu/SCU2NNSkl+d1mJrB+IE6woWjTVxVivhBYN5GS8qKCNvbD6sG6T1iWHG2o7Jk8EtSpSb3Kz7VQ22gWbx9PD9zpPLA/N38GaN7VeIquKxrbqHVYZyWPckiHwAFk3JBwms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7Jx7be3; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761857324; x=1793393324;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=yI1kJf/Dfi1rIFwTfWgDfjG5yQBENOzTdOT4ObWI1C0=;
  b=Q7Jx7be34irN3+vp4aEijuGJnRBqPPNI1pSnjzxO9Sl85HdcMxGuoohl
   xJhFJRayitq1P7CbeGuhAqAC31P9Zx43nwZS8CH1jr3Tk8OEMTf++xb8h
   qdPtk7E/RqFHrV+KvhhyEhkP8l/seEiqpZLPGyoO35RhwQL0JYktVr2u+
   sincG9/NcgqaxbwJO48E6EUXlIiHO4mt5g4cTyUUsj2M8cf4bqasMaqIP
   2j9Kv9lcXHw7biVfdpQ0oRtwOmSkLhAXeekCrZfFbtnaONCkTLi7JlAXi
   T93/1s7ddM3qqq6ykExiV89QCpvZunAFHR72bvnOqhPeX6t5Z2ALen+Cf
   w==;
X-CSE-ConnectionGUID: v7toVLXVRouI2vwt1W/4Dw==
X-CSE-MsgGUID: 87OEcwZ3RWOKCQBdb8Bhhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64045001"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="64045001"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 13:48:44 -0700
X-CSE-ConnectionGUID: 4XG4M16YQ2eC5gqHn8iFFQ==
X-CSE-MsgGUID: 6ZCClZ31TG247IPFPfjzBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="209624801"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 13:48:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 13:48:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 13:48:42 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.65)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 13:48:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4jQA+j3lx54bnU1JXHSruVmaD8XnnuAyykQQxgtocxerRv+Ej//kpwd7WyjVfF/XjTjSOmjxgjfRkR5TWFeON5eIqOik31WevWJN5s0aXRqEsBt8kX8UW0khs2soNChOxf/NViMqT+su1uRCkRJSjL2+0zbNNGuTEZsT7Ed4nVKiYhQHVpuKNwt78yrHwXq0x/jwJc8ls9TD7ZwFXCFkNq/QaZzhfYPCTkoNBvTd7Tio8cEpbrFvuVOMQaEQDtubCRJDixXmdv5rBA/NrynikZVq9zqm/xKsiUY5VyFcTzaHktq51/mHA/Q/ej07WigMY/HR0XnO1VE1T+ed0okbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOG5eyoobcso7uoAvt1lrRCY4vRSXPZr9Ve3eo3rQCA=;
 b=My29JvX32dkey1vZy9LD4uXH1s7BPRO7oIAchemUrMLMADmltTHwrurbEzI71aXc/lOHaS1KOax6n9Wib5F2yH8Bdv/D29fvDaSnVHqxBee5DpxMLq30x1Bv23zU46pRg1EOPBcTS4Sd/fXH8BuZQiH9WQYsYAPG4XLX1pzmc5HNMLnBeaus3M1KrGHSjpN5/JHM4ZGD6JXy/OUFi/oHgb00Wi532zcTnFcAMN9GBnJeb5VFIBezg/qIa2gz6QTM+IDlksKNNKhwM522qkN7Xss+cthI0gN4GsmWMltifAoMs1/PCDHz44rIcodbXsZy9H2dUvVTOr+8RgL0xBmM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8507.namprd11.prod.outlook.com (2603:10b6:408:1b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 20:48:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 20:48:39 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 30 Oct 2025 13:48:39 -0700
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>
Message-ID: <6903cf271538a_10e91003e@dwillia2-mobl4.notmuch>
In-Reply-To: <20251029163109.000030ae@huawei.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-9-dan.j.williams@intel.com>
 <20251029163109.000030ae@huawei.com>
Subject: Re: [PATCH v7 8/9] PCI/IDE: Report available IDE streams
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df3b9d2-b1a1-4b24-7c63-08de17f5b47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlVCaFAyeGxHWEEvS0RldURDWjBqRW5UQnowWWVLNTI5eHpxN0RaRERwazIv?=
 =?utf-8?B?UUZuYzdSUk84OG55a2FiZktNMWVEUjQvS3ZKN3NzbEw2T3oxdnFOVk1zREc3?=
 =?utf-8?B?L25sSUNjcEpwSTBscHVMMHM5MXdXN29rWDNYK0FmY0Jnc1lBTTk3T01LSlJ0?=
 =?utf-8?B?QytmRjFndk0wVXBrZklTWml3dkZ6ZTlieEdzSFVwTXdTSzN2MGtFcFBrTmx6?=
 =?utf-8?B?cTRPbVFrcnpmenFqL0J1c0ZEUmJhSHpXNDd5MHNoVGcycXJCMWZZaktCZGFq?=
 =?utf-8?B?Tkh2K21PNG9hN245d2taeTZWYTBZT0JxWVNOM1huc0g5SnZDNWtKZnBuZjcr?=
 =?utf-8?B?OEpwd0Fna1cvVG53VXRtVk9RZHN3QlFhRWNrS2tQazV1cVVIZ3NxeHIvSlA1?=
 =?utf-8?B?T21mUTBQNWJhOEZiZytpVjVWVndVMXlOWS9Va3JyYU0relVwZWpWTnFXYzg0?=
 =?utf-8?B?amxsdGxrWjIyRU5NeHdjNElkZTNuWmdyMUtLNVB4R0dkWnV2cWpJb3Z6UldY?=
 =?utf-8?B?WkdHYmRhamdxZExZTElzT2RVeElTQ3c4dTMzcHE1ZWhBalZoQUF0TnJxYzNF?=
 =?utf-8?B?Nnk0NmVlNXcyMmpmREZDbVR2S2tVb2RxZjZCelhZY1FPYXdQZnJUQzhiTWF3?=
 =?utf-8?B?ZUtBVFRuWmx5ZS9rTHJ4K3hmanNDc0lBeEt4MnRyNWovRTNnRktlZXQ0ZlY4?=
 =?utf-8?B?a1dxTGJCb3pNMlVTWTV2THhwMDNZY0hYNUVmR1lxV3FNbjV1aGFPVGtza1cy?=
 =?utf-8?B?dWhFOEVEcU9sNmNHZDVjSUF1Z3dPeTZyazY3Q1c2Sy9KZkYxcHE2K0ZqbjE1?=
 =?utf-8?B?UVdaUGx0WXNTQ3B5RDRZTnlmcU8xMFR4eDJFc0VObktjaUZsam5aYks1d1pZ?=
 =?utf-8?B?WTdmZTRwVmdOaVl6eDF1enNaT2VoRlhTL2RxbW45UUZ1c0dqc3hhb241c0lF?=
 =?utf-8?B?eWpwRTZGT2lQUjd3ZW9jVitySDB4Um1YWUk2cHJBcXNFeGZTV1pORVViYkhN?=
 =?utf-8?B?azNsOVRldzJBRmtaQjBnRExvVHhNQVlNNWt5NC9qZmhqbXZkemFuRTkzWVR2?=
 =?utf-8?B?Y3hqUmlVTFh3ZnBaY2N1azBJZElhSEpRY1lpUHpKMHdWbG01Nkd1U1BFazd2?=
 =?utf-8?B?WjNXcFNLcXZTZGNhZk9JZnRqcG1pYXBQMUJ3Qk5lL3BxS0xjQnVmY2JLVFVj?=
 =?utf-8?B?bkpGZ2Z3ZS9WdG5id0wvaUdqaE14aDRYV09OMzdGQUg2MGQ5L2tqS0NIN3p5?=
 =?utf-8?B?ZzRGWk1YWitibTdhNHJJT2g4WndnbXlpR2NqaU1nWWZRMkFZckpzSW9zL3hp?=
 =?utf-8?B?dFExcGd0VnErY3lqYi9JZGVzcGxGc3Z3alQ1WmpLN1I3TGNrSHVWQ1FmODho?=
 =?utf-8?B?WGlyY0dINWVrTEZ5QUFwOTk1TFNYMUNOMk9pbEhEczd3WXNHYlB6OVI1QnRk?=
 =?utf-8?B?a2dKU2RlcVhPRFdLcE4vZ01nR3k1eGNUZzhVZTBaajlhY0RaTnhQY05uZStW?=
 =?utf-8?B?cHd1VUR1SlVlRHFVT1VCSEs4U1FLV3BiVTh5bWkzNnJEWVBPRHdCd21CRjV1?=
 =?utf-8?B?Qy8va3FjMThJSkxRdHdGcytyOXFva05ZL0FVSkYweWtlcDBCeHdYNVg3Mm1I?=
 =?utf-8?B?ZmhvZXVEM2RkdzNVZDRKcGJneXJQUi9hYjh1UzZUVjJWRXVHTEhtcVJjVWhp?=
 =?utf-8?B?VGVSWXBTVkl3M0c2L0o4VVlScWlKeEp6ODlRK0hDcnFOTDg5YThyZnQvNUdx?=
 =?utf-8?B?eDJNanhtUERMRWRjazJjdW5XS3hWWlBmWk9ocGFPZFhkTTdTakJNQVJ5QkJB?=
 =?utf-8?B?SWpsVVY3ZmFXZ20xVlFlZ2lyOElHQUVlOCtRaklwcFB4Z3haczBDcDdTU1dF?=
 =?utf-8?B?L1pieUF5cy9QQmgyNW1ib0tVRlhWT1dPRzNVVmRGOVh1alZKZEhvdFdhS1lh?=
 =?utf-8?Q?y9tU1bpAxSs+dlzMlDp0S5wC28ZPDd22?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWdaQWdENjRNY2RWdVJWNlZNYTN3Zk5BTU1RdW1xeWZYa1RmbmczcGZLZ3lp?=
 =?utf-8?B?OUhqY3VZV1B5VU1lQk5ZZUJLWm83aEM4SzBnc3RxeFJ0Y0toNW9aREhJdHJa?=
 =?utf-8?B?YjdIVU05SUxVTmoyUkhGaTgzWmMrVElrcXc0VTVQaENuRGlXbmdTTUhYckVs?=
 =?utf-8?B?MlZSRkN2Vm9TZVNpcDUxc0toWThMdVdzQmNFdWFYeVNraWg0eHRYWDBoV2g3?=
 =?utf-8?B?NlBRSEZuK2ppQlgzM01ycFdHN21KNjl1MTBCaWQ5OXdXQ0F0QXJuK052emNR?=
 =?utf-8?B?UGZnSFBiVWtmWnF0bFVzcWVtSHpuNHovRGpuV2VYVDZ3UFN2NkhyZ3hkZEsv?=
 =?utf-8?B?TjMzbit2amtFY3dacVltK3h0NWVMYm84RTRPcDVUYVpVMm1xZWhtL2EyWERI?=
 =?utf-8?B?OUJERlplWUdjbFRzY0U4VVFGdDV5RW1JNHJVT09jTVlOK3NVSXUvK2JkZjRa?=
 =?utf-8?B?UmtmVEpZQmg4eHRXVHZFS25kN0VMSGtiOHpoTzJhNXFXVGNMNGlVRllqRXRo?=
 =?utf-8?B?dU5JNnlQWWxkcXZ5ZW5sNElGR1ZBWk84REp4bEJ4U3BvcmczbFJxRXlybVlC?=
 =?utf-8?B?VDRkUXRKRDhGRVBQeSs0WUJMajFlQktocmI5bXpKRm4ySXBWMkd5NGR4OWxK?=
 =?utf-8?B?R25tbkpZU1B0UmxRYVh1dzFuaWtXSmRUMHVhMHl6VGZqVUJQYlRVRWJMeHYv?=
 =?utf-8?B?bVQ5MVY4V1FrV2pFWWdMeG5lMnBPRVhIWUhvOFZnSWh5OC9JVkpFMkQvaStS?=
 =?utf-8?B?SnhTdDhFZ0MrN2lNRzZhT0htbzBIRzRWdk5Fd1lQZmJ5NUVURHEzTWRjMVBr?=
 =?utf-8?B?SjgxMkdjYytZQ3hGejhHOU5SVzRCR2VRMExCQ3VVSk53eGVuMmZVcExqbUtk?=
 =?utf-8?B?dW96NFNPd1B1N01qdE9TdllKVTM2UFVlT0tlOHY1RzJtWFpzcTZ3eVNqTisy?=
 =?utf-8?B?eVNCR2lWZEtxbTZHRjlJWnBWMFZUUEdGT3F3bkdXUDh6ZVZhdDhBd3hPeTNk?=
 =?utf-8?B?RDFxcHhOcjhzcHd1bVhqSENteHpKbUxDVDJjSmU1N3RLQmFtdE9UdVpLUFE3?=
 =?utf-8?B?R0Qya1FoZmFnM3piU0Vzci91bU16RVZvTmhka1JFYWhaQUxpdmtBTVlZT1Mw?=
 =?utf-8?B?OFVnTXNLZHc3ZXFyK0ZsQTExUDdZRVFIVVZLd3M1b3Y5MjJPQkVaOTcxWGRV?=
 =?utf-8?B?Q2gyZzJ0NVZHQ2xwVDdHR2t1ajliNGk0QUgwRHRRTmNBeDhUVlVGT3MxTldZ?=
 =?utf-8?B?ZGxYUWloeG5tODZIaGVDTzNqS3FaRGVNZDd2VG1RZ3NpSktENGdmb1B4dUNp?=
 =?utf-8?B?aHRnOC96bUxNRnZuWTAxcmhwTWo3d2VrS0RPREFxbm9vQkNncEducTVXbDQ1?=
 =?utf-8?B?U2hyR3FRcDR2YUYwdVhnOEJQK09ZN2U0UkQ1MVFqaUh3VmdOOWdidHlhMFpk?=
 =?utf-8?B?TDVVYmY0cVpubVVORy85cW9oaER3RHkzT2lRTmZWa0FTYW1YcExzejlJdnBS?=
 =?utf-8?B?Um0wcTJET3o1VE1kWmFlbEx6c2JybHBiNWlVY2JxT0xqMkNHMkpVTlZPYnI0?=
 =?utf-8?B?UVlTTktQemptNERtcGtRdU1KUWxweUxOaHBjL3dINTF4Z1VjNnZqWWN3anhi?=
 =?utf-8?B?Vzd4bHAzSVZSNjl1TFlPSk8zYmIyekFJbjkvSG5idm4xYS9jamZSN1BlM0xS?=
 =?utf-8?B?ZUtTQitzL1pqbml0K042Smw5YnRGUDNjakQra21BcXdLVHhTL2xQL0JSRnRs?=
 =?utf-8?B?NFhhMjdyTDBGQ1I2L0xDMkxlT1llUWVSU1lsVHZCNUVRN3o4QllUa2FlLzgv?=
 =?utf-8?B?Z2ZQaTNCUFV4d2x3RWIwOWpKRjNRRDdyVnZvZHRRcUNGK01wNE52STFBamd6?=
 =?utf-8?B?RUo5empaZ1VZL0xlK1I2MGdyK3lEZ3p1ZVpNYVdBR1piUW1nL3U3ZCtNYWRp?=
 =?utf-8?B?Y1ZXNnZXT2YvWU1qYldVMTF6amtadnBXWmRicTRuZzFvak9QL3lqazlGK3Bq?=
 =?utf-8?B?Mk5UN2UydC8wQVFEZHNKcUZYYjl1a2IxZHJVS0p0TmFZY1puYkZFZmJWMTQy?=
 =?utf-8?B?NnM0eXFyZzRGQTZ5Wk1Ud1RrTFhERHd0QW1xSGFLWE44QU43d2x4cVQ1ZkEv?=
 =?utf-8?B?RFRzL0c5NGJxdmpPYzJIcjZyRjNzYzE2QVY1R3dvc2pDcFU3RS91ZlNjajl0?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df3b9d2-b1a1-4b24-7c63-08de17f5b47d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 20:48:39.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxg1sMY1JA2OEMLqNFO2EzSYFK8e1dPm4tlNW4+0Bukc/fBfYdJHZY5iWrjDUM2hCQAmL7eBuF97mFKcrCria/9WY9f7IflVGJhSdUPUsxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8507
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 23 Oct 2025 19:04:17 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The limited number of link-encryption (IDE) streams that a given set of
> > host bridges supports is a platform specific detail. Provide
> > pci_ide_init_nr_streams() as a generic facility for either platform TSM
> > drivers, or PCI core native IDE, to report the number available streams.
> > After invoking pci_ide_init_nr_streams() an "available_secure_streams"
> > attribute appears in PCI host bridge sysfs to convey that count.
> > 
> > Introduce a device-type, @pci_host_bridge_type, now that both a release
> > method and sysfs attribute groups are being specified for all 'struct
> > pci_host_bridge' instances.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Xu Yilun <yilun.xu@linux.intel.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> New day, new comments.  Nothing huge, but I would avoid the defining
> an attr group to NULL as that feels like storing up bugs for the future.
> 
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index d3f16be40102..8b356dd09105 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -616,9 +616,12 @@ static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
> >  #ifdef CONFIG_PCI_IDE
> >  void pci_ide_init(struct pci_dev *dev);
> >  void pci_ide_init_host_bridge(struct pci_host_bridge *hb);
> > +extern const struct attribute_group pci_ide_attr_group;
> > +#define PCI_IDE_ATTR_GROUP (&pci_ide_attr_group)
> >  #else
> >  static inline void pci_ide_init(struct pci_dev *dev) { }
> >  static inline void pci_ide_init_host_bridge(struct pci_host_bridge *hb) { }
> > +#define PCI_IDE_ATTR_GROUP NULL
> 
> This only works if we assume nothing else ever ends up in pci_host_bridge_groups.
> i.e. it's fragile - think of someone adding something after this.
> Whilst I don't like ifdefs inline, there isn't a better option for this case that
> I can think of.

Fair enough, a comment explaining the hazard is about as ugly as the
ifdef.

[..]
> > +/**
> > + * pci_ide_set_nr_streams() - sets size of the pool of IDE Stream resources
> > + * @hb: host bridge boundary for the stream pool
> > + * @nr: number of streams
> > + *
> > + * Platform PCI init and/or expert test module use only. Limit IDE
> > + * Stream establishment by setting the number of stream resources
> > + * available at the host bridge. Platform init code must set this before
> > + * the first pci_ide_stream_alloc() call if the platform has less than the
> > + * default of 256 streams per host-bridge.
> > + *
> > + * The "PCI_IDE" symbol namespace is required because this is typically
> > + * a detail that is settled in early PCI init. I.e. this export is not
> > + * for endpoint drivers.
> > + */
> > +void pci_ide_set_nr_streams(struct pci_host_bridge *hb, u16 nr)
> > +{
> > +	if (nr > 256)
> > +		nr = 256;
> 
> 
> hb->nr_ide_streams = min(nr, 256);
> maybe

Sure.

 8:  8bcdc030d445 !  8:  37a609df4dd5 PCI/IDE: Report available IDE streams
    @@ drivers/pci/pci.h: static inline void pci_doe_sysfs_teardown(struct pci_dev *pde
      void pci_ide_init(struct pci_dev *dev);
      void pci_ide_init_host_bridge(struct pci_host_bridge *hb);
     +extern const struct attribute_group pci_ide_attr_group;
    -+#define PCI_IDE_ATTR_GROUP (&pci_ide_attr_group)
      #else
      static inline void pci_ide_init(struct pci_dev *dev) { }
      static inline void pci_ide_init_host_bridge(struct pci_host_bridge *hb) { }
    -+#define PCI_IDE_ATTR_GROUP NULL
    - #endif
    - 
    - #ifdef CONFIG_PCI_TSM
     
      ## include/linux/pci-ide.h ##
     @@ include/linux/pci-ide.h: struct pci_ide {
    @@ drivers/pci/ide.c: void pci_ide_init_host_bridge(struct pci_host_bridge *hb)
     + */
     +void pci_ide_set_nr_streams(struct pci_host_bridge *hb, u16 nr)
     +{
    -+	if (nr > 256)
    -+		nr = 256;
    -+	hb->nr_ide_streams = nr;
    ++	hb->nr_ide_streams = min(nr, 256);
     +	WARN_ON_ONCE(!ida_is_empty(&hb->ide_stream_ida));
     +	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
     +}
    @@ drivers/pci/probe.c: static void pci_release_host_bridge_dev(struct device *dev)
      }
      
     +static const struct attribute_group *pci_host_bridge_groups[] = {
    -+	PCI_IDE_ATTR_GROUP,
    ++#ifdef CONFIG_PCI_IDE
    ++	&pci_ide_attr_group,
    ++#endif
     +	NULL
     +};
     +


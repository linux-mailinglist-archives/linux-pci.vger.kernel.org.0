Return-Path: <linux-pci+bounces-41709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D324C71AD5
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 02:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E78BC34A8C4
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 01:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8DB194A6C;
	Thu, 20 Nov 2025 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngyiq7xt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ABA171CD;
	Thu, 20 Nov 2025 01:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763601868; cv=fail; b=SvpaAYNb6Q2PFYCetjhHqAyTOzRFU1lohVyemYwiG9MBdnnVzxtNEytcE2HvLPR9ikOcNkbkrcoTAXDqpGOzWkMVNOWT8WXQvCxC1Ig7bMQAzaIOcEJ21LxeCrjVikfFJ8BLAxJDZdCCtJ9JCwCyaeqlGo8gdGjQT0PmEElgykU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763601868; c=relaxed/simple;
	bh=wh/eZ4+yFzwJS+A0TBjxwMv3xUcWEiyFXrFz2/aJPAs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=BiRMrsROJYz6wL/Gve0r9RY8Iwn5Ieh+VJsxaLloI2j2ljnLJwN/57ugmFTtHau3NYdxlGHD9yV6H6tZ50ThvOlIwWodVzlQrpi8ti87u5y1miNatDWeKAKkQqLhUF+hlarIW3fWPWeiLdsM6nPizJPQLudvjx1Z0PJ1GcbQcnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngyiq7xt; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763601867; x=1795137867;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=wh/eZ4+yFzwJS+A0TBjxwMv3xUcWEiyFXrFz2/aJPAs=;
  b=ngyiq7xt8iGlOttTqMGM/iEtsJ/y46u109LmdCKccXQpqlRgdXVnRdZs
   Fjap9cBjPca1EM4yYyMRcL0kfR/49gTNXolz+tL/tD3MS8A23aUCNVHIH
   A0k9ZIsfO6Am4w75P9Cdr4R/XDSz4SEhpP+A89/9lN3SrG99e90x4fK+e
   bH4yh3u0kH/FGxFlflXtJAZPcSfHKDUz483aHKhH0dtKYCvOuDW9wBhhE
   4ShYUalVsurT88CF8uUroByPZH4lSmHleyUq/DURorgm4LvgFqfFoWpRh
   1wfRpaAPACEUBlFEgH+B+q/fxHbOhGRepNVEOMBNJz8q9YELbo6gnbCQl
   A==;
X-CSE-ConnectionGUID: hHEMfDIOQ2KHdptVohkgSA==
X-CSE-MsgGUID: BbiY4HmoQj+Y1tDPZHbShg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="69511406"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="69511406"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 17:24:26 -0800
X-CSE-ConnectionGUID: lW5XmETsStCXDYljWrcs6Q==
X-CSE-MsgGUID: h/96t29ZS/ecq/dju0zDkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="196173635"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 17:24:23 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 17:24:21 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 17:24:21 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 17:24:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jbm7QMI3Ii6EyMjBae5JBLMYY1fQH4A1SnLIyjxAa/fydMlA0IFAhbMGbMvKE5hF4N4zxRUugbvuIojlR1JviGTEINIWdsVD1mpgotn44odVACwa4WgtI38iZbu9KODipiWE5kMFxvu+PXzEAxhIkadveqnOgPpnN3GSLLBHDr3wtus2JGvdtwsBKOeyjERGGqCLWd85swFe+oRPL5KzKClbin9MXJuz+d87ugfItf47WF448L/IIlQyrwqaTRCJVRhRzSzr8a3BHCxlKW7NZDFrgsN+LFV/8PnH1CorvIYg+8StKoMCwSPRSAu+Rkyr8H0zt2NEYWvjF2GI511FFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ad9tE07QmF+Hv9PL4ipIevb4d4jRIcTAYiIGx+6SifM=;
 b=GxIfP/PEKwY65MxZi5W1lMDJeQfIIex56mHCn68cC2M2bNrq3mHjTPu0c6hsdQZTV+8UroXRenLpWCD4Zt/BProYXWpHCSYTG4Yf6DNfH16rLlb7HFqnN6fzTASdceYSeBuIvf42RMW2dXF11B5Gb6670ongAJz8zG96oFsYeGjA9lgZ3uthHS+9x4FYEe4YZLMS6BTClxmi4JBrhxCnlb7fcsI6nJRrwDfetQ+F+62h9cJEGJOLBzUa4p4WXw/lnBO/ZiJsQZsZoAqLWEPmszoCB9ezlau9oUGG7t8Fq/VHlMbvsnUIHueUHe/INTp270PpjdtoBBZM7eQ6yilUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7116.namprd11.prod.outlook.com (2603:10b6:806:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 01:24:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 01:24:19 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 19 Nov 2025 17:24:18 -0800
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
Message-ID: <691e6dc22618_1a37510035@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-18-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-18-terry.bowman@amd.com>
Subject: Re: [RESEND v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check
 for bound driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0131.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa97520-da9d-42ec-1ef9-08de27d38742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEozWGdheXQxOEJ4VEo1SDFRVm9ROXJGV3lUWFlLdFpSeGVBbXNPYUZyOEJ6?=
 =?utf-8?B?b2paU0pPcGd0dE9MK01ZbjlTS0RKa0RnU1NTN3RjOC93amorRnRSZ09xdGN2?=
 =?utf-8?B?WTlqQkVLbHc2TkFtWjNyZU4zNGJuek0xSDg2ZjluRVNBV3hUckExWGpiVmRk?=
 =?utf-8?B?ZVc1Tmg5TkxVaDlwOHdWMkxtalF0NWk5d2dvRlk2alpCZnB3Z2R2Q3NPZ1Z1?=
 =?utf-8?B?aHlqN0c2TjUvVG9OTlpHNHV0TnpKYmRoYjFVb3FrSE1RL3BDNnRIMzRCa3F6?=
 =?utf-8?B?Mk5JeU9GWlNJaUF5NHQrR2d3WklRaHhJVXpnVjl0MVYwWjZXcGlDRndreXhp?=
 =?utf-8?B?UzZtcDhDbEtNZDVtZ2Q1NTNQWmxpK2NoQStzbFlFMjNCOFNtai9SaFR3RU1m?=
 =?utf-8?B?WE91OHV3ZWdDSkNwZmFzYk8yTjJZcFNMamp5U2RRVFhqWGduVjZ5OWVJODlC?=
 =?utf-8?B?R1hTRkYwWWw5SUNiY1h2SGJVTy8wLzV3bGEySURIc2Zkb3VTem5LVHZuYnBr?=
 =?utf-8?B?STdUS2EybEVkeVNYMkJ6cDRZai92TVdZSGNyM05BNWh2WUg2UWVEeUxCa2oz?=
 =?utf-8?B?WDZXeVVOS3FVK1Z4MzFwRFRzajBIM1hoeHlkM21PKyt1MGhEbFY5OEZ2WEpa?=
 =?utf-8?B?a0lKUml5WWNnK1FSRy9IRXl6RHdxbHA5UDJIQzZLRTdnVkdGdHA3dWZuRG41?=
 =?utf-8?B?Sm0zUllvald3NC9EYk13Uk9VamppTytFb3ZSeDJmcG1RLzBPdGN0T3ZXMlJT?=
 =?utf-8?B?OTM2anYvYzZ4c3BWMnR3S1psS1l0OThuQjJvT2RNSVRjTTJPREhRQ2wvTy9N?=
 =?utf-8?B?Zk9wVTNuRUhodEZZK3RCRGpsSmNQVDVpTTl2c0tqRFo0MUdySk9LcW54TEY2?=
 =?utf-8?B?cUN4OWR1TTZEVmRNbG1nbUtrM3pxUkZ6WnNRT2RWS05paVY3ejA1TTByVzRS?=
 =?utf-8?B?cHRjSWdzalhFYVZjQ2JGbUprNG1jM2l0MzBVaXppdDlxcWRoZit2bzdyVUtE?=
 =?utf-8?B?am5LZ2dOTlFLSkczeFBtTlhlTmhscHVCc3hFaDd4RCtjZzdBa1hDODdMUS9P?=
 =?utf-8?B?N2Q4cDdKeFpHR09nU1B4cmtrdWxIcW41OThLNkZMKy8rNFNuRXFqdDRJWXNQ?=
 =?utf-8?B?VVJMMUJBOEJNYjR6SGw1V0dreUc2Q1pyWEhxc1llbnRaNEs4YzlJbm13OVRZ?=
 =?utf-8?B?UkpZQ2E3WVNSS01kRmxEMHRiM2syczVsb2xEM1prVU5neDF1QjUxazltTkxp?=
 =?utf-8?B?YWk1RDVEaExOR2FCY3c1UWEzTGpnMFNYU1RiQnFCb2Z0dWNjQk13SWZ1dVdO?=
 =?utf-8?B?bHpHWTJJN005MGZWbjNURVBidmNvQitoT1JxNDF5a3FUNHlHemkwNWVVOVp4?=
 =?utf-8?B?bzJMWnVDWnI4ejRYdERPNk0vMGlzSmhGOTVNNmhySFZlN3VlR01DTHRjM0pz?=
 =?utf-8?B?cWtxdXN4cWp4RUU2R2p3QXlxbkhSNFZ6QnkzQy93SG9TUXNFSDR2TXVEanR3?=
 =?utf-8?B?SUxqcE1JdUNSNHJhbnNBM1hQUkFvZE5ramMxSFpoV0VRNjNnMU9sWWRPL0pH?=
 =?utf-8?B?SUk1OGExV1c1UVlCdGY1d09VM2tFOFc2cXIrN3d4ZmFPVk1rc2V0alJvTG1H?=
 =?utf-8?B?QXdteEo5SytxU3p0S3lGa2N6RWJpS0R3RjFCRXo0aFVrUXdIR3dLRlZ3cnpE?=
 =?utf-8?B?bXBGSzR4ajZINVFLblh2NkYyeEhjaG5JdEJabWFMd2N4cGJBYlo1RWtyQTNC?=
 =?utf-8?B?eXdWL3ZoS3hPRGY0dlR2MklweS8xYVlqTE5aWHdJUkdMQzFGdExQNWx4WGc3?=
 =?utf-8?B?ZzVuYjhoWk82RlFOQ2Z4WGlPZ2hwSnlhV1FoWHp4Qm1VOTJKSy9takhTM3Jj?=
 =?utf-8?B?eU8xSzZON2dLU1lwTUY5U0JIWlU4b29NRnY5dnNYczlQdFhoMEhhQXRhVGxY?=
 =?utf-8?B?K0NZN1UwcVB5S1h4TTRDREZESXJnMDVBK2trMTZkZUFPUEpmbURUWnBVTTVZ?=
 =?utf-8?B?UFZkdGZUeWNUclVRMEVMaGR4allEYkhCQlR1VmtzbzY3UHVJWjkwSnpTUWtk?=
 =?utf-8?Q?V97new?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alozL0x6OVFXQk9hTlhZbUNoRVhxSk5pSDRrS21vZHVGTDRDWmlPYlhmV0pZ?=
 =?utf-8?B?c240aVp4QS9CK3Fvc1gxTnRkaE1IcVVxTVltbXlLVWcvQjh2Z1ROek9McjBE?=
 =?utf-8?B?cy8rSjNlYWFId2dLTktWQWxyaXIyeGViRDBBQ202MHRpbW10bTZuNVBWd3o0?=
 =?utf-8?B?a2k4c05JUXdDVjZHVlR1SWh1RzJmZTUyWXR5VUF3bllobVpLWnE3eC9tWkVF?=
 =?utf-8?B?dnBYS3VhbTZQWDEyYjNadmtKVEtYZ1NGYUdHWVpOZ2JzQnZwWTBvRzVtd3FD?=
 =?utf-8?B?QUJOd3Q5SzdNZ1V1NUVlQXB1bFcwUFJ0YVV3MXl1YWVGMlpXWUEvdUZyVmRE?=
 =?utf-8?B?dUJsdVozVU9QNDlvM3lOUStwYStGUGNxa2h2T0d5SGlqZWRLRWYyRERkenVV?=
 =?utf-8?B?M1FNUUF1Z1dya2hyRjJINVBySkFHZEZoNTRiVGhsbm16THlwNlRLMzVGQU51?=
 =?utf-8?B?QWd6RnZKOEZBUmtoVjQ3OEZjOEwzeld0RlNZZlFDU1ZKYzY4NktValUwQXA5?=
 =?utf-8?B?VFRHd09TSmw4RFNUWGprOUlVWjkrdXlySjJKVmhNcVN4cVRuMzJ3WlJOR3g3?=
 =?utf-8?B?aTR4UlpHZCtDeHRmT3R4blQxMU5qaHhCL0IwSTFoNlEvb3NtdVNCNWZ3dFdz?=
 =?utf-8?B?ejRNYUU1RVF6YlowMjJTM0hhYnUyWGFZTml6WHh2UTFJNG84VFl3bGwweXZz?=
 =?utf-8?B?Zk1zRk1OK1pKM2Y3OG1tRWk5OVV5WmFsVDlJU3I5c29oZk96TVl0ZWQxc1ZS?=
 =?utf-8?B?UWlqbEV5eE5RZ0haajVUTWNJRUhvczA0bktnejBsMzRkdHI0Y0ZhYUlJR3Vi?=
 =?utf-8?B?UG9ZZGltKzV2b2RNelgzdVlaTEtDTzVCdnp3WnlCeWVpZGN5ajJaL3ZLMEk3?=
 =?utf-8?B?QlhkSVVXL1padUM5ZmlIS09USllCcHFXcVdzWS9oV1Z1NDdIMmtoS20yak93?=
 =?utf-8?B?TXlRVXBsRVNPU25ENy9EbkdqSkxBMDI3MllQdTVEamRtMGFqVnIrWnp1YVVT?=
 =?utf-8?B?cVhIOTFGQ2RQQXQ0bTFlbFFObWN2MW1qVTUzUkNnVzVoTXZxU2gwbm5JS25j?=
 =?utf-8?B?TzRpUUkrNVozT3VEQ1AxamdHRkljc0ErZUhLeEgyK1ZDZEFzZGtGVHY3TTRw?=
 =?utf-8?B?aE8vTEpBa1UrUVNQbDNrMUdlT004ZFN1bnZLTEhGWnd5cjVlOG5Xd1JtaW8z?=
 =?utf-8?B?MVkrOXNVN1RPSVF3OTc4Mm9IOEtBU0hQRUNVNG9pMjBJZzJjLyt6L2I3Mm43?=
 =?utf-8?B?cUVXUko2RFNrVzZTUVpUYVFHUnljVFlxMjFCSUFMSElkMmgvRTYrRXpoMkFa?=
 =?utf-8?B?ZFI5M0FRY2kwSmwrdmxuL2Nvc1A4MFBzaXYwVVVYOXgzNk5NZGx2NlRZMWR3?=
 =?utf-8?B?NVNkZnJnZitHdkF4OStmVTE1VVRkS1RIRmdZREZUNjhHb1BxM1VvYy9PRG91?=
 =?utf-8?B?QW51NXZ6SlNCMmNaKzB0NjFBWTBsaURQb09PSkpQMWdRNkNOcmFiM3ZBb3pM?=
 =?utf-8?B?cWpqT0RUb2JqRnoxNTFiQzUyTkJEUldvNG5xblNUaE0yVCt3NW1XY255YkdQ?=
 =?utf-8?B?T0NiSzBWejVQUHpVLzljVXFPRTJySFBvd3RBaUpuaUFvaElvYlVGaVVrUStk?=
 =?utf-8?B?MHJxZmJYdGxpazAwNm5zeHgvSVNncnpyNjcvekN1aXZ2dDh2YTd3MlFVa0dp?=
 =?utf-8?B?a3BMWTYxZGd6UHdicmhnOVA3MFlPakM4aXVIelUyUU9oemsxKzlvb1hCSkps?=
 =?utf-8?B?dmFOc3kvbjNmMHV2cG5wZ1IwZ0U0VnREdkFZZDJzUURqNTZ2aGtZTUR6clZx?=
 =?utf-8?B?Z01leUlzVzlCWlVQc3dFNG5VbjdIeVpJWG9xcTlKbzUzOENkU3BIbkNiMm9z?=
 =?utf-8?B?UThSQWl1S0ZnU1pGZnR5cGFoRDF5dVJRTFJGbG5MOFFEaDBwVVJsL0hibDdZ?=
 =?utf-8?B?U2dNVXBRQWxuUDRGeDZiWkx5RFhEWkpmZ3VMY1gzekZRRWZsVUFhV3plaE9k?=
 =?utf-8?B?bFJTaHhwajdFVHhmMm5YUysyaWVtZG1EekY0eUFrTXhZaDYrVWdYajVubnNM?=
 =?utf-8?B?VzZaSFlaZzlkU1BKOHlHSkxJdVk2K3Jza2sweG9CVThxQWQ5cGtab0d5Uldz?=
 =?utf-8?B?SFFzNUtuSlB3a2t4VXAzZU5lbHJGL0praHdQUFZXUFJzQ2NLaUN2QlFjMHBa?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa97520-da9d-42ec-1ef9-08de27d38742
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 01:24:19.5612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caSj0bg1UP/sJel0a/N+4Px4PRo6/r9SL9xlI2BXVUu/Z6II2w4KxXbKP7CRxGCT0o1TQbtsuyjMdKOKDdyBBDyld38kvLb2CsHpb7Gsnxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7116
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL devices handle protocol errors via driver-specific callbacks rather
> than the generic pci_driver::err_handlers by default. The callbacks are
> implemented in the cxl_pci driver and are not part of struct pci_driver, so
> cxl_core must verify that a device is actually bound to the cxl_pci
> module's driver before invoking the callbacks (the device could be bound
> to another driver, e.g. VFIO).
> 
> However, cxl_core can not reference symbols in the cxl_pci module because
> it creates a circular dependency. This prevents cxl_core from checking the
> EP's bound driver and calling the callbacks.
> 
> To fix this, move drivers/cxl/pci.c into drivers/cxl/core/pci_drv.c and
> build it as part of the cxl_core module. Compile into cxl_core using
> CXL_PCI and CXL_CORE Kconfig dependencies. This removes the standalone
> cxl_pci module, consolidates the cxl_pci driver code into cxl_core, and
> eliminates the circular dependency so cxl_core can safely perform
> bound-driver checks and invoke the CXL PCI callbacks.
> 
> Introduce cxl_pci_drv_bound() to return boolean depending on if the PCI EP
> parameter is bound to a CXL driver instance. This will be used in future
> patch when dequeuing work from the kfifo.

I am thoroughly confused about what this patch is trying to do. The
whole point of a cxl_core is to separate the potential shared mechanics
across CXL device types from the specific special case of the CXL memory
class device.

This would be like saying that all PCI drivers need to be built-into the
PCI core to satisfy PCI error handling.

If the core needs to verify the driver before calling the handler then
the design is broken.

The design should accommodate a case of *only* a CXL accelerator driver
loading and not a CXL memory expander driver. Let me go take a look at
how cxl_pci_drv_bound() is used. There must be a simple misunderstanding
that we can resolve quickly.


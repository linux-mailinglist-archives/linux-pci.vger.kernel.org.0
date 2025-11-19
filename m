Return-Path: <linux-pci+bounces-41687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39898C7135F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0B16C2A112
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A969D2550DD;
	Wed, 19 Nov 2025 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWtM0H4N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC671E1E04;
	Wed, 19 Nov 2025 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763589683; cv=fail; b=HQTx2edkCl/DpRovM2jb+Ec+exedM6so8OKfKpR2pPMhQppJPsLWYZ0tH6UUC5MTN++nXNtUQWAPTvZHavs8epQe5vVgG/LW0RmZpMl3bWiePPuAMnxhJyHA7vS6LiP6IRJdrhOJJS35KhrjxAx4TlQAl+6jnzjstg3v9OUPe4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763589683; c=relaxed/simple;
	bh=EhLsYDqYE1LU6gv6922zhnDL8LLXcSCFA/3skgitCv0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=KRwj1HOyxVEvfMeEIKEOIUdedzYZyuc9KfMDvQqXU88BSumwvRFnnZ8rf0nJsZnM8vXFQJjeZDf4I4AyWtJvyBbaQZ6ulDqoir2cqhjuiqvq+6tloK2oUW3kzLbEExSTYbcRfTVJhZ5Z7lN8cDDOqSDuNjeS4B9r2Ny0VM9bMFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWtM0H4N; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763589682; x=1795125682;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=EhLsYDqYE1LU6gv6922zhnDL8LLXcSCFA/3skgitCv0=;
  b=CWtM0H4NhomeyaF39Vd3PkOv7uYREeiGZ5ZcCMb9MWGdRxFgQrC70xRu
   ZbgbTRHmvvke5GRGNwmwu2bpw2Cm7f1lWkq8Bkg75vT4ulo45EjzurIG4
   u3d/arWJW0W+e8P7xBp5O4TFyiCJ6AZcq+yPxcu54QyjNjWuZdxX/WQ6j
   x0YVB9rSbj0bIO9nostbQCR4LZ6mMgm0kUvCRDWL7G9ISttRSuvbniUnA
   WegNSnkyNyTvDOdP643F/CaB0fmMQbiGmb+bLiEedaSNgYBx+QhSD8P87
   jqpcA9LL80ZXstflKtVNaeldKJiiTVBcbTJL2LQXkkqC5rfWtTj0D5odk
   g==;
X-CSE-ConnectionGUID: hZEY7cL1RduWUgh/3CHS5A==
X-CSE-MsgGUID: RZ9HeYYYRwi2rd05vn3C7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65349419"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="65349419"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 14:01:09 -0800
X-CSE-ConnectionGUID: EOQW7hlCQUqWZlIE1/QsfA==
X-CSE-MsgGUID: Mkrkwe2jTUqEMoCwvH+XJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="221829490"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 14:01:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 14:01:04 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 14:01:04 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 14:01:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXi0XjhckBK3t6nHcNeRtLeMDvS3MnX8wtNmUGXEr+CzV0zA9vfIV0ZYXtxd0EILI+8IQexR8V/NXuSuchdAgVk1G6qL86P3mzpO0dPphl7W5dGZdwhhYJlO+tuA2oybfJC4Dvd6F6+0r8SlEWS27BETP3YiinMtHj0p9ufHxGQe6fMQc5JOhN8D/QpUiLhpFqszkmZgUc/mC9JvMprb9YqRD7XLwSWvbqoQ525PCSgNBrIqdeQ/uR1k4vNZLKmksLZ0ke4/6ycHnvoRx8kKqekTQN4LONXUmx6b4bSNkuZ1KuC3i3ysVp62qVnALSKdKe9WkBu16ZV7JCw4yRzNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfkxPG7BWo4nikhMCYAyrJqwQbqbAVWYBHX+fOcI9pI=;
 b=UZpVk7bmkz0ZBV0tlG/N8eOKI0pTCDYyfEra/8oVrcvUycI9PnWsWDAoB+K0dWsrEZnRHuhAfHD2AVtByOupSSRmadBitQfSRyahek4bHfRL2EsAaIsj7i7FXT0rNudRrO4QfefC/l+qHms2xOxlvfWzm4eqRL3GQrZazcr9g7oNPbuPQs14hnL36/5+t9PJ7zxl59FnC8b0fwPKQ0wpMlIFbV32hY64imzBNiS2WW868uY8V2RGTn25gVaZgQgIjbHBPnl29HoiyTnNKrr6o09maHaCq3WFjmACZpLCEnQkz7fMhXlLouCDEu935Yj8+SivYulgQ8j+K8zoXMhj9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 22:01:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 22:01:00 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 19 Nov 2025 14:00:59 -0800
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
Message-ID: <691e3e1b8ade1_1a375100a@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-14-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-14-terry.bowman@amd.com>
Subject: Re: [RESEND v13 13/25] cxl/pci: Update cxl_handle_cor_ras() to return
 early if no RAS errors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: cd294f1c-4b92-4e40-33be-08de27b71ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGlzNDNucmdVdGxVdWsxYjNleUJKbE9QRXFmZDI4ak9EUXJPeDdEMG85NldX?=
 =?utf-8?B?QnBkL0ZiODIxaEJjR3NSSG9zRTZrSHJrUlBtVDFoa2RTQ3pYaS85QTVnMmN6?=
 =?utf-8?B?ZmpxWXdtNlNlTlFlUGtYeXRsUE9ac1l3Q0NvQm9wUHI5d2V0M01MVzNOa0sz?=
 =?utf-8?B?bkNHb0dJb0lMcHBhQWJtSDF1aVNqZUpNbHh5L0I4cW9aLysyWWZJQWM0Z2dk?=
 =?utf-8?B?bTZ2UHUrN25YazIxaU5PM3lSYTJjMHZnQUY5RmtDeTBnTWE1WXhjdEhURE9H?=
 =?utf-8?B?S0VIc25ZT0FXSVJVVlNUcThuSWpkWE5YVDViTytRWW83Z1R6bmNHemczcDU5?=
 =?utf-8?B?R1NiMGhpdVRCOUg0VHhSUlVPOHMrU0RwTHhnMlhBQkx6NGUrbXY5MFc5SnhI?=
 =?utf-8?B?c0h3OU1qZkVqYmUrVXdvdjJ6STcyZkMxK3phanF6MDllYTJCWE04bitCd2VT?=
 =?utf-8?B?ZTNYaFhYam04dkI0cWNnL3F5eFIvV3pLaHc1R0FXTkZHVG02TDl0WGRXSmNL?=
 =?utf-8?B?eVpFOGpEQzRCNWFNeE9Rb1VSeUwyZXQyZFF0ckFDYlpzV2ZHVGN0ZCtpd3Bn?=
 =?utf-8?B?Z2xibnZxUkNsWW1yZXVMVDVkM3AwS1ExMExoUUpOa2lESWIxRTdBZDJ4L211?=
 =?utf-8?B?Z1ZNTS9RTFRzQTlVWmRoMkg3UDFaeTl5RFR2dHR4eGcvd1RYa28ycDkvK1FW?=
 =?utf-8?B?aENyUnhDUitkaFRUUjBSb3J3SjlUNzR4cnpGYzhwNmpZSk83VE13QUpwNG55?=
 =?utf-8?B?Z0E1Wk9SWDNWTjhkN3ltRjZLUlhMTTNJSXdBUHZyTjlYU3RTblFXck5ZK2Jm?=
 =?utf-8?B?K0VrSlF6ZGJxVTd3Q0lYTVdJTTI5eEdQbHYrakZ1bWhFelpJSGRsSkpwMEI0?=
 =?utf-8?B?YUNabHhuMVJqZVZCKzNMamJMR1BGZ29ybDdNVmNqZmpxMzJrNXlzZno1N3Bm?=
 =?utf-8?B?emR2eGMzdWUwc2hMZVcxS3EvakE2VS9JdjlUUExlTHJUekZQSmFmZkNmREpQ?=
 =?utf-8?B?ZzBoS0ZENnBNQkxWNTg4UUtHS3hMcFJEVXlpZDNHR2ExV2srdDhMOUZzeFAr?=
 =?utf-8?B?NzlpV0kyNEU2Uy84K25YMTlZVDl6ZmdxTk50YjV0Vm54SHRncHllZ1RXTkRt?=
 =?utf-8?B?amVIYWh6WFVlakZRcHc0YitmYXc2Mm5XaFVQT09ZTjdEOXp4WmlJUlE1QUEr?=
 =?utf-8?B?ZjdVUnZPSkUxRXZoVmNkMHY0VG0xcm1sdHVXMzhIeUVZOGN5dGU3SVUwdHBx?=
 =?utf-8?B?NDF5dTE2WitCWHhBQlhlSzg4MHFqbzRrbUlPMkpPNThBQzgvalltUDM5Q3lj?=
 =?utf-8?B?VXNRSXczQlhXMk81MlF3SEQ3Zis1ZFdQVGVqSERkUE94VmYxcWIvSmJFTXdV?=
 =?utf-8?B?dWNoVERMVFQ2TFpDWW1BYXk0WnlRRzdvS1dzOVNVMDNEMnFIWnNmY1FEVmxs?=
 =?utf-8?B?WVJQVDFLc3ZtTVNLVXBHa1ZjWWF4ZGVXT1VLdXdiRGs1QnpRTGhMaU8yS1oy?=
 =?utf-8?B?VEs2NjBaOElucnB2OEdiNkFtZ0IwVjhMU2JRSXdPM0dVN3FWSWZDTmlvNyt3?=
 =?utf-8?B?emlaRGl4UlppQlRQenhidEJtb1dnbU80ZWRQN0ZlWkhCYVNZTCtuZnBoMVNa?=
 =?utf-8?B?L2dSeWRlOUd5bXkzeTZlV3hXbkoyOTlRV20xRDdKcHNlaUQ3VlhrOTNlL0hZ?=
 =?utf-8?B?eU5rdk9XRkdNTXNJZEx4Sk5uVE5VSW0yNHhTVkFJNitiYVY4cmIxczNNc0xR?=
 =?utf-8?B?U2U0TzBtU29hKzhaS2VYVVBWVVFEOGI1MURUN2NyMFRZUU1WRmJUak02cG9i?=
 =?utf-8?B?QWFYYkwwR245bVY1WHZCS283VXpmaWpIU1E5bkdMcjNKaUV1T2RFc2pkTDAz?=
 =?utf-8?B?T3lNbzcwT2IveTN6bUpNMXkzaE9VNk43bFJtUnhmMTdIRFVXR3hqYUIrNVF5?=
 =?utf-8?B?QjJJRlhmTnRuTDZaek1JV2tGTlBURitybFZrQTRXaURYczN1QVBVN0VzdGNI?=
 =?utf-8?Q?f6Wb3Ke2i/TkwaxAZIM2Kq6OSWkI7g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTc2MCszRFlCSGdtY0FiUXRoazBLNFBMbVhrN2pTalJmTTlScENMV3BNYWJ2?=
 =?utf-8?B?MHpOS2cwbHllQVNVeVFSNEI2L0FNS2E1dXNkbHJhb3YyR3ZSQ3ZTS1lGQnBp?=
 =?utf-8?B?bWlsRFIzSGxwTGxJSzVPYS9EOTBZcUtOaVlMVTd4T1YzbUFWMDVvbWgvUktO?=
 =?utf-8?B?aFNPQyswc0xPWVdFTnlHOWh3NkUvZFFSdXdieVFFVCtsVHZ1WjZncG1TOXVx?=
 =?utf-8?B?TVEzbnI0L0g5UWRaQTJXYmVPVmZOYnBBSVlKSnczSHFjb3F4aStRTHN3cENu?=
 =?utf-8?B?dldXN28wQU1yY3BPSkd0QXZYUStFSDVkL1MydHBHSDV0MlQwYWRLMEEwTytH?=
 =?utf-8?B?UnlMcTRLTHhKeUJKczhUM0czNFplQnJpc093ZktFWHpyeGVJaUFlUWV3MG4r?=
 =?utf-8?B?QXFHWVRNOTFVRy96QW1nOXZKMFJwMVVkUDVIV1VPcWxnRFoxc21nS0JlZEs3?=
 =?utf-8?B?RTRVZm9yL3VCam5DSWpSV2JaSHRIRUtaSThYZDU1ZXZYTVdZMFpEL1VhSmVU?=
 =?utf-8?B?a1FPTGw5UnIxeVhqbHJFWWRpbVZ2NUVpWFQwVjRCbERmblBmcnAyVjFKNk81?=
 =?utf-8?B?T1YxSDcydUwzbEd3RFhwUWpsQThtVldtTldRbC9qWEJFWTNRVWF3QU1heVg1?=
 =?utf-8?B?WnJjcUlTRDBIdjFvaUU0S2orSE1aSkJwNjFkMHdLZk43OFRwVk0xVGFXdTZQ?=
 =?utf-8?B?aEdFUFdkbFdIZW5YTmVuOXJYaXBQZTFjcXZvOUlDd3dZM2VqbFM0dWZKSVMx?=
 =?utf-8?B?YTZKelVTakxBZ1dUQUNPQXRES1ZnRG5zRVVqWGlGcEwxNUg2K1ZTbmI5QVY1?=
 =?utf-8?B?RnpzMW1FelNlc3R5YkNJeEx2YlRTYjRlZmQwSXJLSU1meGhDa2lzREVQa0Zv?=
 =?utf-8?B?MzdxdVRtbzh5SXFadjdZTGRMV0x0cUxyWTFLanJybGlEVVg5Sm9Gd2IrZXpx?=
 =?utf-8?B?QzdZTXk4ejhhL2VuU0YvWEFsWkZrSFJ1MEtJRnpnSkMzSGZZMnFjSlE1QnRx?=
 =?utf-8?B?aWc2d3B6TEZpS0h6UGUvTlZJdkI2U3ZOVHp1bm1xMWxOb3l4eUtZZXUxUkQ5?=
 =?utf-8?B?SVBEU3R6Tzg1MDdRNGZLU1k5U0U4OXhNL1U1MjNJL3J3cUQ0UG1XUG1PRHEv?=
 =?utf-8?B?WG1Na0M3SVc5eW1QNXVMcTBRVHVkR2pPR1lDbkZ4eUdHNUhJQ1A2Z3hHYzJD?=
 =?utf-8?B?OFBtQXlQYjM4WHJuR2RNVnEzYndFVnVvMDk1bHcyQ1dPNVRnWHpPWHZzT2RT?=
 =?utf-8?B?Y3d6LzhBTkxxa0ZheW5SVWJ3MG12NS9HL3hPWVhaMnlKYjRTdW1KWTU1N3p6?=
 =?utf-8?B?aStVNnFOaDhDSHdrQm5sMnhGNVpFUTJrVVdOakZ0bjNaSC9JTC82aVpZUTZk?=
 =?utf-8?B?aklTTFJEN2pQeHRmZjUxbDUzUWIxdUR4bmhGUW51bzREYk9rdTlNV21CVURi?=
 =?utf-8?B?RjdBUVM0MWdxZFVqRDN6c1UrZkhVb3RPSjk1c0J1MXR0T3E3YThEVFBReHYv?=
 =?utf-8?B?YUlLcDlZZnRqcmNtNyt4S0R3VThWQnUrNndCYWJhRDVyZlZMNFNEVDlkK3Vr?=
 =?utf-8?B?SWdGSGhEcVMxdjVSS1BZekI4QWhqYnZYK2Z1UFRtRWdaaEdrdTNCaW85dkM5?=
 =?utf-8?B?Nk5ZNE5ZZGI3VXdxNWZsa1ZqUHFscEVnajVVbjdPR3VmVk13bWhDczBCZ0U4?=
 =?utf-8?B?SG1FV1FwZkh0Z0ltYlRmWkNSZFQ1Qyt6ai81TnBFTHh0d1NNOHdwZ0ZZdlpi?=
 =?utf-8?B?WnF4eTJmOEN3blY1RThjYmdJTHdQZjJCQ3M0Mm9XaUgza09KNWlsRnBPcXpv?=
 =?utf-8?B?OXIwMHU2OTVaenJFbEQraGhqcU5kWUliQXJZZWNLU0VycEdpU0d2MWtGRTdp?=
 =?utf-8?B?MSsxMGptNll0SEE3OGJ2Uk9WREpiYk85bG5pdWJ1cFpmT1B3dmg1YWVkMm8v?=
 =?utf-8?B?Sm9pUWpsU2Y0NEV1Qit6Nm5YdG9lOHJYTVdhdldqSVpObUJGQnJSeEJRV25s?=
 =?utf-8?B?T3p6L1pXaDZCVElaT2daOTVyMjJvempTajg1TFhBQmlrcjluVmZwV2JuNm04?=
 =?utf-8?B?UllwZ2Y5VGt4OVZVUTFkTlY5OVFaZlhTVzE1YjZ6Lzlpbk5KQ1gyOFVuenVC?=
 =?utf-8?B?L3JQSHRVZlgyd0dpRjlvQWNqcTlQR0YrNkx5aWkrMngxK0dWMVRMYkVHNjg5?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd294f1c-4b92-4e40-33be-08de27b71ffe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 22:01:00.4091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvVbX+7B73knyj7PAe15Tq5uV/WjdWKSCgn4r0qGya31UZLfhUybeV9lByYcQZEDuDENOURJWPdkpzb6mLCowcAsiIpc3NE0i03gSyQ8dhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> Update cxl_handle_cor_ras() to exit early in the case there is no RAS
> errors detected after applying the status mask. This change will make
> the correctable handler's implementation consistent with the uncorrectable
> handler, cxl_handle_ras().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> 
> ---
> 
> Changes v12->v13:
> - Added Ben's review-by
> 
> Changes v11->v12:
> - None
> 
> Changes v10->v11:
> - Added Dave Jiang and Jonathan Cameron's review-by
> - Changes moved to core/ras.c
> ---
>  drivers/cxl/core/ras.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Is there more motivation to this besides cxl_handle_ras() symmetry?
Something like, "in preparation for adding more logic when errors are
present..."

Otherwise, LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>


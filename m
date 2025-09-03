Return-Path: <linux-pci+bounces-35388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CC0B42363
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 16:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F593A6654
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2CC1F4CB2;
	Wed,  3 Sep 2025 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="caE4Mzbt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836802FC887;
	Wed,  3 Sep 2025 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909121; cv=fail; b=uzA9lVPEgeaM0idB76lKXRgbNV80w016UkG8QCCvBplg+bdg/d/LgVEsG8yf81f1c266bRZrRGBDzQtfiC9sT4ZCpgXq12BghaRtFwqiF9FOwku5N2ZufphUa9d2gzBConfpfeU2tATwTgvy5+/+WzJ1hvaQpxAIRAHa4SV9Nfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909121; c=relaxed/simple;
	bh=3TuBV7c5RNOUsRtgCbSpYyHBhWxwP7lZkBXtihanY2A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uEIlwPGBqj8EYyKJA5zwhhEGVmjtMhJ+BzJZ+DN5ip60V1dk1sYXcO+MYOSKhntKKHK7WeDSALVDZ38P4uXdX88AJxL1TFAtVuJ65WSnf09rayBOgtjsu+aH1DQ6hE8nEilDPJAieRc35EXi1sFGYTa7vYfeGVEMzKZYfAcB9HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=caE4Mzbt; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756909120; x=1788445120;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3TuBV7c5RNOUsRtgCbSpYyHBhWxwP7lZkBXtihanY2A=;
  b=caE4MzbtvtcQjVksmPKPoqZfm/3KRHPTFpHng6jJ/zaVcBVUsk9FNDXN
   +73XySajHyLhhEWhoq9uRzNHXLby0SmQaQyqbHT7DLk5EkXVNLoqOLfu9
   BMcdXuqsieR7jJ+Ok4vY+aeGGIOydoy9g1ahBNtOFQzYX8WmIAUxLbv4s
   mV/pvcjscadKDmTp2FUFeqIX/lnSnPepauOQHj/RvUffqSEc508w1Mg92
   cipgGlN4ioFH/16d/PotXVdZyelhlB2AAGkzMEtDChd1XA5A7/P3/Waq1
   KPPDRjJupW2E5P6h9/gSE6OBcpg6DcsV2wQL4loNq9Tvep1oOCTwXTf77
   A==;
X-CSE-ConnectionGUID: 0ZIgHhG8Q+aG3I6A7UJsjw==
X-CSE-MsgGUID: /U2F0Rn1R0+VIXk/4PHgvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59369349"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="59369349"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 07:18:39 -0700
X-CSE-ConnectionGUID: b6ab3Sx/Tc+sbbFRZv6cnw==
X-CSE-MsgGUID: UU+khCSBRHqhKUc3EBNZUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="175959506"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 07:18:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 07:18:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 07:18:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.84)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 07:18:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MN6gFms/0NVNdjMsUPvDC0z/L8qQnUvVkcms+uRiAcSEUazk3FAY5UXjY/P770W1t9o+FiN5ZG14DMCYaFm/j61xz9stOkyFDOuiXtXoSxta26+7dHCVksn5RZkKTA8iiIDEwSsMqb2gMbPBq42tIR4Wd9QWhxxHrHhukSKUtk8czkGXWFREmx4/sy2Dlj+auOlb0uMB2KB9mbTFG2KOwWAeJOFkEyNUZF9T+OOtPrG4uxKqGI8gJcMmXUlIkmC4jZTsvnZYkH8wS1z8SC9nyhF0VFJKH1XQzCRPz714gd9gLTg0z8kCYyH+t/D7LI90yNERvYRcqXKXoUwdKs6vPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WL1G5useRCSZy5gk17hq/sQt/omf1eiop66+uTJgFbE=;
 b=YkAmgwCHz1mynb58hI8uNuOhwUQYBHafxcQoe2mAiPCNI0w11yi7eYP0KqcydAw1W/UD8RbPIaGgsyHv9xHi4YJdaQ1PU5/8jU8XCHXcQ1BbOX5m3+/8mhoXo4qCIxrIEU9c7yjDzIy1JxLYQpWz/k5ZLV7tnEVFh5Jyue2jI3eZ8cjBksYZBvZBDvwR2e1PVIKc0tvZFAWtpfyymCZqC2KJ5QADc0KYfbZVp7SLsIzQwW7jdXZdec2beLtvQMd3wTgpejuPPp0Xtz/HWwbiH/QEOz3W6JCIH4ee5/35+oQqFnms9NXISqrl4R7mieWwmewkFO8VK/sIygOIwssPaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 14:18:35 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 14:18:33 +0000
Message-ID: <8cc7b5e7-e967-43de-89cb-af5155675e24@intel.com>
Date: Wed, 3 Sep 2025 19:48:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] drm/xe/vrsr: Enable VRSR on default VGA boot
 device
To: Jani Nikula <jani.nikula@linux.intel.com>,
	<intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <anshuman.gupta@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250529111654.3140766-1-badal.nilawar@intel.com>
 <20250529111654.3140766-8-badal.nilawar@intel.com>
 <a7522f7954b3c08fec00ae7f1fd132ec4a3d2033@intel.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <a7522f7954b3c08fec00ae7f1fd132ec4a3d2033@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::19) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|PH0PR11MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3f1632-ca7d-4d6c-e58e-08ddeaf4c3a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWttYlhYWGh5ckpPSC9Ca0VSU1V5UjJrbTRDeEZoemNMRytOVDdmdXJuN3FT?=
 =?utf-8?B?UXhQaHA2QmVnSUV4MG9mamJuOTg3TmJDTGMrQUJOU2hrOThkV0J1a0xUeVhj?=
 =?utf-8?B?WDJpYzByM1MyUS9YQnNENzY2eXQ3S0crOW5jd3hMVnlBa3k4VGVaRDRHVVZC?=
 =?utf-8?B?bnpjM0J2K0dqU2EyUUl4ajVpWndXVCtRN0swTU4xQ0E0N0RJd3M2ZGZ5TTIz?=
 =?utf-8?B?UGwyb0thZlhOTDdrMVJBVHdNM0JxOVREOUxMU3FmZWpaejR6dnYvc0J1M1FY?=
 =?utf-8?B?SFloMGxKaDF6dGJmVzJ3aGp6SWdNdmxZUlQyM2FiOE5DS2JJUFAvNEVuMmR2?=
 =?utf-8?B?bmNzakZvMXJuREVyTGNYRS9DNUZhWWVKN3kzYmxQT3BtWU9PMGhwNzh2UFVl?=
 =?utf-8?B?RGkxcUpMdXNNS05kU2kwVkh3MDFSR0hWa0ZWWmkxQ2pWdWFjc2ljL09PSmE3?=
 =?utf-8?B?OEFpUHVHeG1FckVPdVZtVk9UR0FpbVRSdFEwQlNQaFZTK3Nnb0dJWDM2ZGZJ?=
 =?utf-8?B?dkpXaHBPQmtTVTF0eFJVUE9sU3dINjA2NGVEMCs0UDRGZ3lteFBhYTMyaU81?=
 =?utf-8?B?RDZNR3cxTmVOekN0Wk9KeFA3d1Q0eFNqQXhYSDZjN2F1azlSbC9BL1NFckZT?=
 =?utf-8?B?SEMxT3VBVlZhY0cwMUpTcm1pZGtWdm5Sdi9TbjdOakozQXhId3JRUUFCWnAr?=
 =?utf-8?B?SzJIaDgzV1FTS2JRakNFNXh1dFFkcEVRQWpNQnB6ZTJpQS9rdjZzdVljeGpN?=
 =?utf-8?B?WCtUenVZWHJGeFpvWUlJRlNoSVRiaHpUZ0ZaOFZZSjFYajR0KzF5MzJZWDA1?=
 =?utf-8?B?RmdrQysyWitXc0xQbE9kTUd3Vm41bGMwcFU4d25QVXVNQ1FyVnRHWVJZMERw?=
 =?utf-8?B?cHNiQ3ZiL3ZGNHZkVWRxYk5Lb3BTcFdVd3hNSTNlbGpMbUNKUWVLQ20yMC83?=
 =?utf-8?B?d2RRUExibEhVN3Voa2VSdDRhNUQzR2V0TTFMZzFwYnJWYXc5UzZhbTJsUVBl?=
 =?utf-8?B?T3c0eWxPQzlHQTJqVkw1eUg1WHRqREVGaHp6dSthSUxCaHF6WjkrLzEzZ0lt?=
 =?utf-8?B?Z1pDeXlsRzVZWVRqV1RwOHFWTWtyUWhFYWtoUGlrdUV1bDd0STJnMjEveHhy?=
 =?utf-8?B?dmJ1WE9VaXVyR1d1bkNoTktoMVo5UTR2dEh2R1MrUTYza0NPbkVnM0RQN1J4?=
 =?utf-8?B?NmVlWlZIUFBuVkgxZkdLNEdtOXZzTDdXRUg5UDcwU29TQVNFZGduYXcrSGpk?=
 =?utf-8?B?M0UwTjRNTEcrdkJMSmMzYTZzSlczd2hTMFprOS9YZXBKdTRsL0xFRkNZaEdr?=
 =?utf-8?B?djM3OFRZUmlqamdPVEhpOGRXS1c0VUdOemVqSjNUZEYxWjg0RFBTQ2Ztek9P?=
 =?utf-8?B?R0JuOGFPL2Y3OGwycTlBK2dEandrUmVkdUtvVU9rK0pnWG1QWXVsVW5SRDhr?=
 =?utf-8?B?cmZPZkkwSkF4WUxWWmpLL1ZqREk2VTQ5c0pDKzJScE1pbGU3bllNZkdWME1z?=
 =?utf-8?B?N0YxWHh5U0RYTVhGbElqdDJtb1hzODNHLzFvRXI1OTI1dW4zQ1lZQ1NCTkk0?=
 =?utf-8?B?c0liSnErRlgyOWhKWVduUC9tTDlVblN4RHBxUXBSSi8wbmt5elU4VEk3aU1G?=
 =?utf-8?B?M2lLY0NkRVgxU1dwY1FJTjhaS0NXYzI5dzR0NzVZOHVGOVVWOEdoZDRlbVBr?=
 =?utf-8?B?YjNIK012NTZVYmxXYkpqd2Jsdlp5LzlTYmVteGNRVUQ2Q2tsR2VsMnRhM3lo?=
 =?utf-8?B?Wjh6ckplUXFpV1pPY0U1Y1NYeHZVVGVnQlNzTmRML0Jld3JIbktyS09zaFo4?=
 =?utf-8?B?bFhFamduZCsxc015WElMSXM2Y0pndElXbEQvbm1LZ0lFZkRCV0UzLy9GeTZN?=
 =?utf-8?B?UDhuNm9UMFg1TnNVY0V3NmNRWVBWZUhiRXJ4WXhzUGVSVmxhcmZ0aFdOeUhV?=
 =?utf-8?Q?bXkfAVbbh1Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDJUMVVhZUxaVkZoTVpxSlg3K3BpZnV5b1g4aDJob1I3L1NRcC9FWVBvaWNp?=
 =?utf-8?B?UzJGWE9WeU5QeVd0SnFkOFVDK2d3SkZaeXJLNlpEYks0bmVuRDRCckhMb0RI?=
 =?utf-8?B?Sjk2UC8vbmRQYnpKcUJONXoyQ2kxbVRvVzZtd0dod2VmTVd1MkIxNjVpYzRR?=
 =?utf-8?B?Nm9DSFdBMCtuaUZESG15aHNTR24wMkIrYmwwN0pGaEJ6aFJSWGh4MjNpT2tM?=
 =?utf-8?B?ZUlLenJFbXJDcWxvTnBLQVg0QnF2amNJTlMxK2RnYXU3RlFwaFlPYkU4QVo4?=
 =?utf-8?B?RS9uNS9MaGlEOUFmb1ByZkJLd2lWYWQxdzllM3JTUW5pUnFmM2UrbTF1eGZW?=
 =?utf-8?B?QkJ0WDA5bFphTjREendJNEFrZzdlcHcrVGtYRWxNS1psUjBPd3BQZnd0V1JK?=
 =?utf-8?B?aDdQSEFwRW03UUl5aXNJS0dCbE9Wa3pVOStqdTVhSEpNZ21zNUJCRDhXOFdW?=
 =?utf-8?B?ZjdxeUlLNXc0d203TU9JYVVZTkpYeXg0Z2t1RDVJdHVseTBwSmVrL1hXTmpT?=
 =?utf-8?B?SkRGcUtRRDhEWFNnSGRYdmZnZE4rbmlySWdYbm1KRXNHc2EyOWcxUGRxSGs3?=
 =?utf-8?B?djZWZW9NQTNZSm05Ky84TlhCR0NHeTVCUmdScnluY0Z6R0sxeWJuK2NJd2Vk?=
 =?utf-8?B?Q2E0N2l0QnJKOEJRKzBzMUx4b2loTjVnTWU5M0tnMUMrcVJGSEJFaHJOSjZX?=
 =?utf-8?B?T3Bhbm1DZGhVRVVZM2VZMG52T3BoRXlDU2lReEV0V3lVN2puTFZaOXpGdzFp?=
 =?utf-8?B?TWtJYnAzNTVwNGpsQzk4QlBZV3ZuNXdSNSs0c2M3ZXlEczhlMlc5VWNVa05G?=
 =?utf-8?B?ZllTdVpQcXoxbHYwVFEzWFc0enk3dGNabTYxTTBBR2o4TzRkMHNCcG9UQzhZ?=
 =?utf-8?B?dGFCdTBBK2JYU2dwNndJVlRnSG45SEtZL3RRSitmWGlZTWhBc2Q5My9uN2xK?=
 =?utf-8?B?clFHcFkvNktqMFlrNngwakszQXYvTFhoT0JmOG9WMFcvVnU1SlpEOG5jSkt4?=
 =?utf-8?B?ZHBkc2REUFN6YlBXQjREYVVEaDBhVFYvNktiYUhOMGZJckFSN3NUTkExK3VJ?=
 =?utf-8?B?TWJUdkltUnVLWmpqdjFPcFpXLy90MFNMODU2VDlheVhqVmtpNWNIUVpOeEkv?=
 =?utf-8?B?U0toa2Z4blR5SWVjKzBsbG53QTBDUHJZSmdmTk9WdXZPVHRpTHlBV0t3NjN4?=
 =?utf-8?B?SC9mYTRNNXdTSWs3MUV2SXcrOU15SHg5blNyM2lCYURrRnM4SXU4SjNkb3VX?=
 =?utf-8?B?M3NneG52UnhxZXZ0R1VrQ2VCSnh4cmpyZlRHaGtpK0pyckVXeUdNU1B5dlBC?=
 =?utf-8?B?NkM3NnlTUFU3R3dSeHl1amRSS3hsNElmVHoydjI1c3cvbzJIanFkVWJiMjBK?=
 =?utf-8?B?UmhRVGZLVlk2aDF0c0h2a0M4WGJWY205cGFqQ2xWK1cyanplb2N6cGxTVzBD?=
 =?utf-8?B?RWlPLzM2WW9hd2dRTEd5MjJaWmUyQ1dmQ1RMY0hzNlVIRjlZYm90SWx4UGdO?=
 =?utf-8?B?UmZXckIyWTJpUkphZ1VhVThDWENYSWwyN1Y2am9oWlZqR3NHZHphbXpwZkps?=
 =?utf-8?B?dk9SSE04TlJ2WHVhd2svRTVaVXJ4alRna1JpK1AxU2dYUmFTU3o0ZDFVY0M0?=
 =?utf-8?B?WnJVNy9JUXRRa0pCZC96NnZQL0VieUlmY1VhdDRvRVczOVBVM0Z4UVZFSDk1?=
 =?utf-8?B?QU5Ba1RDN0JMNUk4VFlXdU14VWRvNGo0dnlVUFo5ZmNQRE5qajYxYkJEUnB4?=
 =?utf-8?B?NldVa2tVQnF0U2dsZkYyTmJqYkpnd3V4ZHd1T2Z1Y2xRb0krSDZPSlVYU3BJ?=
 =?utf-8?B?LytEYk1kSzVxU0VxWmRyeDNWSUVxMXVsNTBOVTZvQnIxc1R0Z0JseUJlZkdz?=
 =?utf-8?B?S1VJYUtxeWVhQldvQ3ZKQiszVThqVnptNnVHM3ZIdmZPYXBIMlNtZlpka2hx?=
 =?utf-8?B?Vms1MXNsWmpHdEJSZWVrU1JFNnZoL2FYdSs3Zmk5K3N6cmQ3dzgzNXhGZ2h3?=
 =?utf-8?B?N0FBcTU5UHVOdVVzQWFOZ0IzQWpxMDJMd2RieHdCQXJRRUtxaVphQkVDQ1B3?=
 =?utf-8?B?aDJYaDVhVVZmVnd6SDl3aHhranpucDRvMDdJMXg5TDF6NTZiTFAyMkkxbFdl?=
 =?utf-8?B?elNvYjR6WE43ak0rYXNodk5ObTNjRFo4TXBScElhVHBYNWFoVS9PS0lUbjM1?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3f1632-ca7d-4d6c-e58e-08ddeaf4c3a3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:18:33.6313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nu9kdFj+OkJRlP0Kfpfd/BWVserl4Z9MjGEHAMBq+dYfxVy1B3at7a0vNPJZBOb5F04amY09ASFqF75uFERmgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
X-OriginatorOrg: intel.com


On 06-06-2025 18:37, Jani Nikula wrote:
> On Thu, 29 May 2025, Badal Nilawar <badal.nilawar@intel.com> wrote:
>> The VRSR feature is to enhance the display screen refresh experience
>> when the device exits from the D3Cold state. Therefore, apply the VRSR
>> feature to the default VGA boot device and when a display is connected.
>>
>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>> ---
>>   drivers/gpu/drm/xe/display/xe_display.c | 22 ++++++++++++++++++++++
>>   drivers/gpu/drm/xe/display/xe_display.h |  2 ++
>>   drivers/gpu/drm/xe/xe_pm.c              |  5 +++++
>>   3 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
>> index 20c3bcd953b7..b3da88b12b35 100644
>> --- a/drivers/gpu/drm/xe/display/xe_display.c
>> +++ b/drivers/gpu/drm/xe/display/xe_display.c
>> @@ -88,6 +88,28 @@ static void display_destroy(struct drm_device *dev, void *dummy)
>>   	destroy_workqueue(xe->display.hotplug.dp_wq);
>>   }
>>   
>> +bool xe_display_connected(struct xe_device *xe)
>> +{
>> +	struct drm_connector *list_connector;
>> +	struct drm_connector_list_iter iter;
>> +	bool ret = false;
>> +
>> +	mutex_lock(&xe->drm.mode_config.mutex);
>> +	drm_connector_list_iter_begin(&xe->drm, &iter);
>> +
>> +	drm_for_each_connector_iter(list_connector, &iter) {
>> +		if (list_connector->status == connector_status_connected) {
>> +			ret = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	drm_connector_list_iter_end(&iter);
>> +	mutex_unlock(&xe->drm.mode_config.mutex);
>> +
>> +	return ret;
>> +}
>> +
> Xe display/ should contain the *minimal* glue to attach i915 display to
> it. It should *not* contain generic display stuff like this. At all.
>
> The goal is for i915 display to become a dedicated kernel module. The
> above should not be part of xe.ko.

I will move this to i915/display/intel_display.c.

Thanks,
Badal

>
> BR,
> Jani.
>
>>   /**
>>    * xe_display_create - create display struct
>>    * @xe: XE device instance
>> diff --git a/drivers/gpu/drm/xe/display/xe_display.h b/drivers/gpu/drm/xe/display/xe_display.h
>> index 46e14f8dee28..c79441bccb43 100644
>> --- a/drivers/gpu/drm/xe/display/xe_display.h
>> +++ b/drivers/gpu/drm/xe/display/xe_display.h
>> @@ -39,6 +39,7 @@ void xe_display_pm_resume(struct xe_device *xe);
>>   void xe_display_pm_runtime_suspend(struct xe_device *xe);
>>   void xe_display_pm_runtime_suspend_late(struct xe_device *xe);
>>   void xe_display_pm_runtime_resume(struct xe_device *xe);
>> +bool xe_display_connected(struct xe_device *xe);
>>   
>>   #else
>>   
>> @@ -71,5 +72,6 @@ static inline void xe_display_pm_runtime_suspend(struct xe_device *xe) {}
>>   static inline void xe_display_pm_runtime_suspend_late(struct xe_device *xe) {}
>>   static inline void xe_display_pm_runtime_resume(struct xe_device *xe) {}
>>   
>> +static inline bool xe_display_connected(struct xe_device *xe) { return false; }
>>   #endif /* CONFIG_DRM_XE_DISPLAY */
>>   #endif /* _XE_DISPLAY_H_ */
>> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
>> index 278f2eeeaab6..c84b9b3f7371 100644
>> --- a/drivers/gpu/drm/xe/xe_pm.c
>> +++ b/drivers/gpu/drm/xe/xe_pm.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/fault-inject.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/suspend.h>
>> +#include <linux/vgaarb.h>
>>   
>>   #include <drm/drm_managed.h>
>>   #include <drm/ttm/ttm_placement.h>
>> @@ -310,6 +311,7 @@ static int pci_acpi_aux_power_setup(struct xe_device *xe)
>>   
>>   static void xe_pm_vrsr_init(struct xe_device *xe)
>>   {
>> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>>   	int ret;
>>   
>>   	/* Check if platform support D3Cold VRSR */
>> @@ -319,6 +321,9 @@ static void xe_pm_vrsr_init(struct xe_device *xe)
>>   	if (!xe_pm_vrsr_capable(xe))
>>   		return;
>>   
>> +	if (pdev != vga_default_device() || !xe_display_connected(xe))
>> +		return;
>> +
>>   	/*
>>   	 * If the VRSR initialization fails, the device will proceed with the regular
>>   	 * D3Cold flow


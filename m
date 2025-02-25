Return-Path: <linux-pci+bounces-22274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B44A43206
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 01:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A1A3B732B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 00:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA4F2571C0;
	Tue, 25 Feb 2025 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPRGI9q3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D192571B5
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444376; cv=fail; b=XU0pDrH6Q7lWjqwUDVDcigR+NlNm8VGe/C0/Sb6K5B5uIsloDOGAiNfUr5FNLkqx4iHV8ESqix10zN04IasSGh7UpY1Imz5JfZcgXMiOPy7T5TqidOKKkVmq3jEYkROnE9UosxbE4ehpPNUL7ZXJy3HXvpE1a5BteQMAV26+ZNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444376; c=relaxed/simple;
	bh=XJbxMnfoZvTy6EA8T1RM20p2eOVIalbkxE6MIWcn8vY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O3TRnZRMOrSZmLmd2h/Umh0dugpng7OUebyF/Kd00GQxmm/9B7v4e8IM+VkcvPD6A/KRPaDStfB6IRKjFHdsazsi9lG5PFPyr/Fz2Grmb5QGfcqMfXrE7ycOSdm48CBNXLAZTZGCVNmShGqX2OVS179ZNNhbxdAKJT68gf7O1Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPRGI9q3; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740444375; x=1771980375;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=XJbxMnfoZvTy6EA8T1RM20p2eOVIalbkxE6MIWcn8vY=;
  b=UPRGI9q3pMhq0dYZuIqVjzLHL3bbSZYq/BxSYK8rEKiLODeD4No3AEf6
   eoOCelSNS46UjJd33FyVY3T0L5tEL7W1g2wtosJsMu7ZfzYT+LiZh/OnV
   8tYER75P0wXWlSEh0h9go5lHEyfy6shwXD2XxcRvhrufGH3JW1yEeq4h+
   TV0tt9d5rs1M4P4WHqaW0U4PEQmMAI7L90cAdQt0tl4IGQxDg2mV5jKWH
   FXxfysbSEcEn2IN9eR4TtIlKxXGbDO/vTjIdrSAFmuaYnLblolb4IxC6p
   tvMhccROyJXT7urVBVA/0h0V60YADzOVZZ3qmhe2jmtJMha0F198VKDIT
   A==;
X-CSE-ConnectionGUID: tFrXwpPuSuye04L7JGEwZg==
X-CSE-MsgGUID: IkPMOzRETnecuileL0z/BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41434341"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41434341"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 16:46:14 -0800
X-CSE-ConnectionGUID: c8zex4aEQDWbfGuV2xp82A==
X-CSE-MsgGUID: FrYG6FJtTxacWFA9JpNw/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="115991295"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2025 16:46:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Feb 2025 16:46:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 16:46:13 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 16:46:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHvKGljaI+X323kgEfs61uvy2lm6309mWqetRRHEZ2EalKDFFRcY7Fe8lMYO87PvSIvAGmeWDgEpDu6w0xmm01Af0/m/YHke63CkijzfKDtPLpREwJuG3Nmxo6jUB8KC5W2aWleO507KSIwOz3Ahgnb+7JtLCh2xEPel31gJxdEQz0fXXBjnKazi3G0dwdgysfsCDKsohlBY+iNe7U7r+c8ag4Hpo0gAarRyM2v8TgbP74dC88jZDU7Hk+nbb1IQTn0jjDxdkTTLr2RJnD3l/Nck5DhLCh8Lz3DezrWjf8QgWpTnLrPYNOa0MtayspJekqNWEmLdXiUoLpEmrDlZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzSNPDVSGvAjne7SUVWqc0a1skuPjY1A4x2xMH6ZeyM=;
 b=uatrpsmFy+XOt5ti1SA1kWmJ+iOD483pqLFfnKwetNdoWMpe2ivOF2UWyWN0BOq7AAD//fdNti0C+uBMbBEcNQaXysALqJsa9js7m8EdjIMDnBOlxDclJb5UfY62XAoGjQAWHpzfw/4k+N1ocCM/d/fkEEphDSJWKAIv4nxsR869ws8TqThqmv5TxSTCpGfuCb8Rb35nEH5AY7FWhfdF4VHZUdg5nJtfD1cK/f+29C6K1guIXl2JYhF4+o7D3aIKPh5Q9cMRrzFrGdSYzPcz7bqlkTYGhes7DgoOZV7PokiUWcPkm/A7PwsPzuOzLfU+UBIKpJBNVK1ClQm1Zt18KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5202.namprd11.prod.outlook.com (2603:10b6:303:97::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 00:46:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 00:46:06 +0000
Date: Mon, 24 Feb 2025 16:46:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <67bd12cbcca65_1a7f29476@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <yq5ay10oz0kz.fsf@kernel.org>
 <yq5av7vsyzre.fsf@kernel.org>
 <67b6a3fa7ffb4_2d2c2947f@dwillia2-xfh.jf.intel.com.notmuch>
 <yq5aa5afway9.fsf@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5aa5afway9.fsf@kernel.org>
X-ClientProxiedBy: MW2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:907::16)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: effdb433-bead-4f3a-aa4a-08dd5535c9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjlScjFlRXZtRFN2RWF4Qnh0bUFQRDJqR2JaUG9pZUhqVVJmR1l1dmg2N05T?=
 =?utf-8?B?alFaWEorT1YwWWdENG5Nb0RKcFVyS3ZodVdjeXEvR0Y2WUdKOU1JTkQ0SEtK?=
 =?utf-8?B?dkY4ZVVLWHNwSEFkcEdwYTUyRWpsbXhQc3Q0ZXRyR2ozNGg3KzFubGZYaDla?=
 =?utf-8?B?dnJwQWJ6M3F6VXkxWkxOWWJZc2xlaDVTek12YUNHRUYrTlRNWGdoWmZLVkFT?=
 =?utf-8?B?am9RbFlCWEZLaEJIK3pmMk9jdFg4M1hOSDFhOWFUbXlDQXljcnFNMEVpVDVZ?=
 =?utf-8?B?aGRGR0w2ZVF0YkM5UjRNVEJMZkFvN1FvSFBjOGJPS2piWk4zbS8waDhSeEt0?=
 =?utf-8?B?ckxMWkliK0hHMTJBcGxja0dMTTFia0x0ZGVxU1hoSlZ5anNUbHAzSWlGRnQx?=
 =?utf-8?B?eFJicUU1WnpyMCsxbFdMSEZQb1M3REx5eHp3cFdXcytKcERPVmpHZjBIZXlq?=
 =?utf-8?B?U1RiUVE3akpjMy9JWFkreGcyamZnWFY0UnBQcFErU3RHSHk3N01EbnNaNU9j?=
 =?utf-8?B?SnV3cFRkT09hWS9STllIbkNraFpHUTZ6T29ZcDJBa1QzdU1kY3ZheCtoRkJ6?=
 =?utf-8?B?a3FBL0Y1ZUNVcFFSN0xvNUlJM29HL1MySUc2aCtwVk5kOXFBc21yM2xNZnBO?=
 =?utf-8?B?dDUxME9Sa0wwTjh5bG9pd2JaT3QyTjVKSnNqaFpvaEVXQ21wRDI0dExHZXdi?=
 =?utf-8?B?Q0lESGhqVUlJSE9JMzNRaVVMckxnVERyZGdLdUtHRHZQK1lqTVNNSmtjTDNu?=
 =?utf-8?B?SldRc2kxWFJoVWVMZm84c2l3ZGozQUE0RUJyMURORzZFeU5PZHNVTjRGcWZr?=
 =?utf-8?B?RDdBYUZmVEk0NEowdEJLQXpWVXhzYTdCR25INXU4OUtQTG12RmxvRTFnb3p5?=
 =?utf-8?B?QUF6NEtYMDl0VThFSlhqYmwxY3VadzVwemFYL0JnSXFMdWRrL0hHWkthVDlj?=
 =?utf-8?B?SnpuNGRMR0NXWG5vNjEzazI4OGV2eHlyOHJMYTZQMnFJOHo5c2xmYUVLVzlo?=
 =?utf-8?B?eGZ0bXBDQVUwWEZFVllhcjIyVldxN01GSzYyWnh1ZHNEUVUra3l1UFJ3M3R4?=
 =?utf-8?B?RzJISzExRExBdW4vTmNlZkhFTU1kRHdJaVhUODdJZS9YL00xcmhvRU9weGRa?=
 =?utf-8?B?M0IyTHBHdUsyZk0vZk1LZExLbW5LS21kdGI1QW1xY0ZTWDZ3YVB1UlFyYmRj?=
 =?utf-8?B?djFsS0hjV1drWCtJRnd4alhUTzVqaU93cGUva1FGUFFRbWRMRk5BVGg4bkF4?=
 =?utf-8?B?c2R4TVAyRTN5anhEcHlBZExLRjdtTVE5ZmZ5bzVIQUN2WjNNNllraCtZRUwz?=
 =?utf-8?B?elF0WjBPL1FPVCtubklLSGR4akd6WlpzSTVwZEJZRitjM3pqVUVkMHBKRUR4?=
 =?utf-8?B?Nm04TVc4b0lwUm1pd2ZOU1pCWDVuTGUvSFQxQjFJQjJ4UzdTQVlBRDFpZ3BD?=
 =?utf-8?B?V0RHaDRpcUVhYTFTN1RRUCtraE1memFMR2htM1pzYjJWVnZjVGdoRUsrKzJ5?=
 =?utf-8?B?NjhQS3ZscUtSNFp4UlBKcHBrRm16Vm9QcGYyMkFrbkFHZ3l4NXlsblVhUWo4?=
 =?utf-8?B?UnJndkxpTjVtZnAybVVlMXNXK3kvbVo0S3RxZ2o2Y3JLWnpaRU1wc0hFOXdL?=
 =?utf-8?B?eFowcU0yWEloVTNXR1JQbWhzcHRtNDE1TEdxUVB4NkJGcW1yMG16eXREaTBo?=
 =?utf-8?B?S2k2VXNNM1cvTzhSZjBTSVBucDhnWFJIZW1LRUtyalJ5R2Y4SU54MDJxR2RG?=
 =?utf-8?B?V1E0b2I3QStuQXpxN3Bza3RvZ2RyZHZkUmxNVDF4NTNDcFkxRE0wRGdadVhR?=
 =?utf-8?B?b0hCY1doOFliUGlMaGh1MlovbjVBWEJIeVBIMVkrTThWSWluam9iR29nRzkw?=
 =?utf-8?Q?xSl6VbMKk6yQa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVcxNU5Ec3E3TEVLeGdueTYzTUdCRDRHaWUwajJBR2tyUEYxd2tnUHBVRCtM?=
 =?utf-8?B?Z2c0bHUwV0lKdVpIR2oxRjZTaThqMmxnVUd0NXRXSnRZYTRNZXg3K3ZSNzAv?=
 =?utf-8?B?OERucUY2ZldQS0lhUUtzVHZhYnduYUpjei9xYmRvTVQyTnpRNEVoVTRRdXNv?=
 =?utf-8?B?bDdvUUhLNmY2WVByaGxiSkluWSsvUjEvMUVialhWam9xM2JUcktVMXg4V0Fz?=
 =?utf-8?B?R3ZMZjJpSUJsd0VYeUN3SmhlNWttZjcyQlhLRkdlUysrVkhVbHRuTFFvVThQ?=
 =?utf-8?B?WC9aTy9rTFo3Q1BzSHhRRGhsbGd3ZUlZU1E5a3VQTHoyaVZrREZGTnQzM1FQ?=
 =?utf-8?B?ZU4yU1NpYTlJei95NGZrTnlLRnZLSlBBRzhydlphS2pSMUFtZkEyU3h1T1gz?=
 =?utf-8?B?R0VFVi96VnlzVXNXQ2xZVE9FOVB1RnY5ckIrd2ticVpWSWpyc3dEdkVpVFAr?=
 =?utf-8?B?YnFXMDJwTTdRMU51aE5UNHNLMHZHKzQ5UkV1YzhlWEFxSGJTdEFLRFdvbmF3?=
 =?utf-8?B?bXBLVzVRVlFjOWJTVTBTRGNsZWJ3M0RqR2o4V2FvUmZHSDJWTU5FUmtVbVNL?=
 =?utf-8?B?Mi9Gam82aW8yeTRGTnNNbTBnSnFoaUNySW9KczBacVdMK1diZmRyTjExbm8y?=
 =?utf-8?B?U0hYdmRuRjBqMzQ2UFczeWQrSGV5R05pbTRwOVR2ckV1TisvdUdIbFU5bVNk?=
 =?utf-8?B?VXFLWnQ1dGF0ZGNyaVFOVjkzUVJwcm5jM09pcW1WMEhvT1RaMDdOTmtOakho?=
 =?utf-8?B?djBONVdIaTNsRXo0VHRxcmZSV3BwU0FUeWs5RUZCZDRjb0FNbG5hS255WTF6?=
 =?utf-8?B?RFo5eDBJS3RWd2VDNUYrczk3K2MrUzk5MzZJK0FwaUdUb05kdWRnc3Zzbm5S?=
 =?utf-8?B?RUNhMnNjaDkrL0xCOFRvNm81QVAzV1IrQU9IMS9Ja1VUWGZwUm9KMi9zeXV0?=
 =?utf-8?B?OTI5clVOMWJ6N1FOdHFJMGRSUVE5ampFeDBtWExacDNWenV3NWZidVhRU1Zl?=
 =?utf-8?B?SVNpSlgzbjhTWGozR2pVWUlLdGg0Q3dNZUU5RDM1KzVvaHNMWTcreDduWnFn?=
 =?utf-8?B?UGJoc1V6MEViZHRZcDVSK3dFR1BQcSs2eE1HNlNlQ1EzNmJieEhIRTc3OUI1?=
 =?utf-8?B?YUR5OFEzMlBSVStEeExtWU9Lb1lXRlh1d2RJdk5vWXFnaGt6MFIvZk5Nbng3?=
 =?utf-8?B?UkRoV1Vrd1cvbldBNzVCSW4vUEt0aHdUV29Xd3ZVUmNId2VMWVllWFlTRDFC?=
 =?utf-8?B?dWczaXl0aW5GQUVnSGd6Yy9odjEvWXJ4RU43b0ZQMFhESnkwMzc0VVdOd25p?=
 =?utf-8?B?Rk12cDNNV1FyL2RRMWU0dy9QTEdJN0R1T29MN0ErbFVKdUtQRU96dUJxKys2?=
 =?utf-8?B?OXFWaFVQdGs0VUtJN2dFMU5Id0lBSit2QVBkZWlPN1ZhSVprcllwM2F2OWpl?=
 =?utf-8?B?TzNYNE1SZGpRK25TUVR5SzFmNWhHWmR2MjdVbHFWZXJvV3ozdHRVcVhJTUVq?=
 =?utf-8?B?a0ZNUE42aDUrV3JrKzFLcTBCTkhVWGFqVzNVMllpVjFCM1I4ZUcxZ1cwTUxW?=
 =?utf-8?B?S0I3YWxZb3RGUzl3MVNYSVloUFQ5MUZJcjlyeUxyanQ1QWlDRW9FeGxFbi9i?=
 =?utf-8?B?a09hdFRMOExlY1pqeWdXK2xWUUV3OTRiRVRQWHg5dEdsTy9Pa3pjMVhUUXVN?=
 =?utf-8?B?VktsWnJhN1Fid0F5c1JwWUJYVElJVVJCcXVlSFhPK0ZGL2lEallaOGFsOGVG?=
 =?utf-8?B?RHZsaGVQNXVhUFJ3OU5UMEtFRVI5M3p2TUt1ckxCNlliNkc0alc3eVNlSmpw?=
 =?utf-8?B?WmFsMm9VaDFhWGhkWC9jb2owK1liL2pkNGtkRDlmc1hBcFdTc2VUb3E0UVgx?=
 =?utf-8?B?VUpKaVhBTzhXU0FZQXRaKzROVlBpd0xpeFNKMkJod3ZkQUxzaUN0R29CNTFQ?=
 =?utf-8?B?R3lzVnozbmJkeFRUd1VmMDlqUk1ZZnJ1SDRrVUZ5emRCKzV5T3BoR1J1a05J?=
 =?utf-8?B?UjBNWEVnNWpmbEtmUk8xTjBGRjE4VEdJUGMvd3pkN2R6di9yWm9kVXFHdkRz?=
 =?utf-8?B?a0VVWldUU2xrSmxKVWZ5Q0VWSGE3OGNiS1VKREN1ditzdVFqTTdJZE1tU3hI?=
 =?utf-8?B?aVdXVHdsbjBNdEVJNVBaVjVSM0dwV1dsR0pLZnJkYVhmL1FkTVJrRGcxNWRO?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: effdb433-bead-4f3a-aa4a-08dd5535c9a5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 00:46:06.2817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqzMShBvQBdzu5VAn3smhvzUznxXUJiV4/k/j0od5a1mRd8KFGYRonlXdLWveyykbnBbBkig+E8J+JRndNBlhJDLHPeiSihpNZRruLfkLW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5202
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > Aneesh Kumar K.V wrote:
> > [..]
> >>
> >> Also wondering should the stream id be unique at the rootport level? ie
> >> for a config like below
> >>
> >> # pwd
> >> /sys/devices/platform/40000000.pci/pci0000:00
> >> # ls
> >> 0000:00:01.0              available_secure_streams  power
> >> 0000:00:02.0              pci_bus                   uevent
> >> # lspci
> >> 00:01.0 PCI bridge: ARM Device 0def
> >> 00:02.0 PCI bridge: ARM Device 0def
> >> 01:00.0 Unassigned class [ff00]: ARM Device ff80
> >> 02:00.0 SATA controller: Device 0abc:aced (rev 01)
> >> #
> >> # lspci -t
> >> -[0000:00]-+-01.0-[01]----00.0
> >>            \-02.0-[02]----00.0
> >> #
> >>
> >>
> >> I should be able to use the same stream id to program both the rootports?
> >
> > For all the IDE capable platforms I know of the stream id allocation
> > pool is segmented per host-bridge. Do you have a use case where root
> > ports that share a host-bridge each have access to a distinct pool of
> > IDE stream ids?
> 
> I am using FVP simulator for my development. Hence no real device. The spec states:
> "
> All IDE TLPs must be associated with an IDE Stream, identified via an IDE Stream ID.
> ◦ Software must assign IDE Stream IDs such that two Partner Ports use the same value for a given IDE
> Stream.
> ◦ Software must assign IDE Stream IDs such that every enabled IDE Stream associated with a given
> terminal Port is assigned a unique Stream ID value at that Port
> ◦ It is permitted for a platform to further restrict the assignment of Stream IDs.
> "
> 
> If I understand correctly, the stream ID allocation pool per host bridge
> qualifies as an additional platform restriction? If so, why is Linux
> enforcing it? Wouldn’t it be more appropriate for the platform code to
> handle this instead?

Ah, ok, yes, the Stream ID itself only needs to be unique within a given
port pair so it is reasonable for 2 root ports to alias Stream IDs.

It turns out I was overloading "Stream ID" and in practice there are
three separate resources to consider:

- Stream ID: 256 Stream IDs within a port pair (can alias across Root
             Ports): TSM allocated

- Stream instance: Up to 16 Selective Streams Per port: Linux allocated

- Stream resource: Platform specific number of supported streams, likely
                   per-host bridge: Linux allocation constraint

That last one may be a small number like 4 given the relative expense of
link encryption hardware.

The motivation for registering streams as a sysfs object is mainly for
an administrator to manage that last number as the tightest constrained
resource. However Linux can also keep the TSM honest that it is not
violating allocation expectations within a port pair.


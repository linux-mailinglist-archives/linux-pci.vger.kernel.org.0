Return-Path: <linux-pci+bounces-36540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8510DB8B2D8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 22:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398015A0BA4
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 20:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8B723507E;
	Fri, 19 Sep 2025 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0fCZusT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D0E231A21
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758312954; cv=fail; b=ebOY1rUcSyJywQtFk6R2muWog5/yXVT3+TToKIbojmiPYOqIYvUuf/vlPmtFmJKK+44JVsK0HMAm0kQz/cde2pi5KEN9TX588ditzthElb9JgY/acL6n57FnHvz18Cf6lC0CbLw43Bh1djRfbgPE4svqg9qzgvPOCHFIugt3n/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758312954; c=relaxed/simple;
	bh=jZMFqaF1ulTHkIGdJlp3BL5HjHv7sDm/34mUUhvjsj8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=pA8qRakWH6RMnBzjLFW8GCac+Fc/FovW8VO18Z6BFTRCTrJrUdXbYlOJEi1pbZgsp7fihPBhi2agEPp+2SxhPQ0g+gNTF8Zajuz8VHzmLt/zK8tJlwHv75s1x6ijkeMuSWyUfiCtgYo2RM+s0wWCnkLJn+AEvl4pyzgtfoBdf2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0fCZusT; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758312952; x=1789848952;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=jZMFqaF1ulTHkIGdJlp3BL5HjHv7sDm/34mUUhvjsj8=;
  b=G0fCZusTnFqhR6f8j6IzHPZooW2Qij/0Uv3mqkx/yyZbhJleqZMQbXAq
   okAdfHBXIBep7nnPK28yArXc+0e+4YDMxY6qtk01qdnU09d4Fj7XjOcOE
   RTV+yJOhFR0vkZRIpgZgyO6vO4zmGMAY6RSTTQU0+gOkuB+NrgxZ5DziZ
   WCYP4wXOm7fPARmWSFxtwiC/QXd6QvXQqHsANsR3wMaVdLmFJrt7zbRuA
   cSS/13v4xvAmsyDOqQp1572oD8Y364YgaL6n22PL0oIlQEyVFT2VfMKxq
   b5eG9Xf29k0prryQZOm4v0cXH6nEw4WAvDQ3Ord1BU8xEik+qaUMKFUeq
   Q==;
X-CSE-ConnectionGUID: U1D7OPWFQNWbcrHgBENB6g==
X-CSE-MsgGUID: fGe7wvrtQuy6nuoUjP6GtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60819829"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60819829"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 13:15:51 -0700
X-CSE-ConnectionGUID: tOLAMU/pTieMbU51rYY3yg==
X-CSE-MsgGUID: xvayFpXERuWXHE4dQp1NPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="180156564"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 13:15:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 13:15:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 13:15:50 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 13:15:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuYWgVxEG6AfqSfNgXSDuN6SGSnTo6celucLdQC8Yllu2g8TK0gSiTk1jIPVW23AD/dkEKV0R8IC4LwcI2w01NT9QHDnXN2Fn5jOm4HpY3WoFaavlLbobPoHBIWWlo7JSQEEnSfL9dy/taFNZEfEGNq6sjd55/Y8kDjtUwqwm1lk0VMNwwNqMgadH9GDEVMw5TI+ELbVHmATkhsqcG9IPm+XuyXwkCm5OT7+K29y64rxAvKYUewDYrDCIbkv1BL2u67t72FiR+g+Hm4e9z3PfVDyZmkohy98aFrycIT3FE+SigI3dqPmPvOmXZIfgd78DfSdKBziep2aVSe5mBWYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBOz+45HeVzbOWq1T/jGjmGMKau1lDssMPSprBrPa/c=;
 b=JHNzRNOu4ngOIPySZ6RD/iuzInXtfPwHCqcdJBO9HjCp2uqNJqDY0+E/S+zwgGHEa+3RIHNZC86uvfsX+1FCzv2vqyQcNgaclGUKhioZid/gtx62/mvf3jpRvgdiGYMRmRWsMdlZzSveceO4dcuT3tYmCJHPdFQnfaWAz9q/SxXj33QRKpKDbitmjLFy3j6RNRWiyYZrANbKLxSWXBtAsG21FFIibGiY/M1bnqIY2wJ6GUn/lTZWlXh72odhXCuDIYw1SQ/xi4XzN5whOGuyanIdL1qB7kysrjt0oXkMQ2FG/mbEh+hG3NWVf8g550tRDbGWlljQ2dKzQIvvO4eljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8588.namprd11.prod.outlook.com (2603:10b6:a03:56c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 20:15:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 20:15:47 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 19 Sep 2025 13:15:46 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-pci@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>, <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>
Message-ID: <68cdb9f271b46_2dc01001e@dwillia2-mobl4.notmuch>
In-Reply-To: <22cbe028-c1ad-456f-a046-12b4559394b4@amd.com>
References: <20250911235647.3248419-1-dan.j.williams@intel.com>
 <20250911235647.3248419-5-dan.j.williams@intel.com>
 <22cbe028-c1ad-456f-a046-12b4559394b4@amd.com>
Subject: Re: [PATCH resend v6 04/10] PCI/TSM: Authenticate devices via
 platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0159.namprd04.prod.outlook.com
 (2603:10b6:303:85::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: ad60240f-7de0-4eb4-405a-08ddf7b9521b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGxaZUxsdnIyUEd4bmtLaWhaTGcvQ3ZtbEhyQTU4OG9wNXVqaWE3WUt4NGZq?=
 =?utf-8?B?OUxndE4wWE04V3I1Q0tOSG8zMThRRkpJMVZ2U25seGY1QnI0Y0tTT09STzJO?=
 =?utf-8?B?a3o0N1IyV0tWM0g2aXc3MlJSTnJPTVNuSzllSEUydW9PYjd6TjRiS0x3UHVW?=
 =?utf-8?B?amtOUkp4dFZ5TXVjbVFkUmsyZ0FXcGttZHBieWVtNkl6Z280RjIreXBVbE9M?=
 =?utf-8?B?dEliRUFJQmlkZkJSbytQRlVuRlp0U0pJTldPQ2RwYXhhNVduUm05THptdnFG?=
 =?utf-8?B?ejJzTnZ2YWp2RVFGVkJEQjBIME5CczRqRVBLQzNBazVLVjZIMVZUTG5wSThU?=
 =?utf-8?B?Qytad0hHNGVJelprY1lDQXhabjRmU01DZUlyNU5nR2VVTEVXTVVYT0RDYkNz?=
 =?utf-8?B?bmhEc2U2Y2s5OFdXTTRGSUJFZDl6b1EyTnd1Zm9teDJzZlVweEYyblVneldY?=
 =?utf-8?B?cFZldmR1UFRydThmN05MMWpCU3dUZHZCWFQ4VUNVaElTYzJKRzQrK1V5Qk1M?=
 =?utf-8?B?eGpBeE1LOEZJcXBoWnU0K05lQk5JYWUyRGZLd2NvSHRucXhMSWtYTVlrVURN?=
 =?utf-8?B?a3FrcUhXWnMvNlk4YTVLZnZzQnN3dnVZS2trMTZ0RUJPWTZwbC9YQ0RPMXFw?=
 =?utf-8?B?Z0d1NHUrekhqZHB5bDVDbGlxVTJ6TkNyalYyMjRiQUhhWThMQmRiZ0pHYndW?=
 =?utf-8?B?YjZ6V2tqUCtiZENxWmlXcCt5RDk0NnZBRUFqdDRVTzQ2WFVHR0NUcjFsNmJM?=
 =?utf-8?B?cHliMjZzdFcyNzcxd2w2WVAvYkRlTDRha1NOUWh2YUdCU1BXSjZoek9rQkdY?=
 =?utf-8?B?WjFSbG0rK1loMlhad2hHZ1lvaXpvZ0FYOG1jSEw3UEhHYm11MGF4MmNDT1V4?=
 =?utf-8?B?VXZlSHcrWkRDYkJDM0VWcS9QTTFnNDRDcllQSWJIMlVXQ1RxUDZicGpEYlda?=
 =?utf-8?B?OXNWZmllNld1U3V2S2MycmV1WUdmK2dNNUlhYWJJWW1DbXYrQ3BOdlpSZDY2?=
 =?utf-8?B?NUtWcDVMWkVyS2NpYXU4bngzMVVsby8zbjRFV01DVzdDeHhuVU5jdytHYkZ0?=
 =?utf-8?B?b1FZcml3STVCQjJZUlh5cmFwdEZOUEorcS9LQTcvcFR3aGpDTEswQ1FvanZh?=
 =?utf-8?B?aUtGSHE1NjFIN1c2VFhkNmIvNWRPOVM2M015SHlyb2VqMU9QVE1CRkRoVERI?=
 =?utf-8?B?MlBoN3lwVTZJMGJRWm9UQ1F4bVh0cmNsODU3NXgyU2N5ZitvazN3cW1xYmZB?=
 =?utf-8?B?OFlUaDJMakkvWi82R2VlVTFTVGpQQnRueDE4TThJRXFDOFl1VlpUYzRzYldN?=
 =?utf-8?B?NDBjS0phTUs2T2d2VWFzRmVzeFBCbGgvVTdLbnRGRFg1Lzd0UE9SdnFzaW84?=
 =?utf-8?B?WDZ6b3RsbURiczhjRnpncTFOSzgzdlpjQXJEZEpKdFdJM2ZCQWpKenhuUEpq?=
 =?utf-8?B?T2NYYTloV2tGbklLTFBSZ050WDdqb3B3S2NOaGQ5ZllnUjNoWnNFai9idktB?=
 =?utf-8?B?RVZIWS9MMllqYkpLU1Izb0hvcXo1SkwzSGpZVU5LdU80QTkvQVdDcXh6aTRG?=
 =?utf-8?B?SkZ6eTQyTHRJQzVSMlRXcFA3MFlhUUFmZjhxSUlHNE1yeE1xRXJBTFBEeTZv?=
 =?utf-8?B?ZW1XVksyUCsxaDBCcmluaU4zTlhSVVRXZmFqbUY0TDFPZ3JEeW1MTE1Yekxk?=
 =?utf-8?B?WkdYT0Q4QzBnNXprTFRkcWZ2T2I3QmJFWUJGM2N1a2JYRnVsWGFraWdIN1NX?=
 =?utf-8?B?Q2gxVDUrK0xNU1BmZFNGMjlGVml6WGZWclNORkk5ZkhEd1dvRTBWcmJYSmxo?=
 =?utf-8?B?MG9CdUpVZCt1blh2SEJBQ2lNRUJyYkVZREU2NnZ1elRLUWRJWnQyNnJZOFpL?=
 =?utf-8?B?TkFscXQ2Z0Q0ZklkRHZlNTRuTmNsTC94SWVOK1MyU2dNSk0yNzJ5aWFuSURN?=
 =?utf-8?Q?yP9Q6Lw8QsM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0EzdFgxYnIzSDBHd1ZFWC96K01aM2RYM1ViRkVRUWRKS0F2MHBmNzh4L2xK?=
 =?utf-8?B?S1AwdHJ0bGVDbEx6ZUZTSkhwb3ZVNERmZWNpZXp4QjFIZHpOYVlRLzlYTURC?=
 =?utf-8?B?VGJmTjV5STFZbW0wZCs4aVhXa0ZKUWNQTXF0SmEzU2planlmUHJaTTNKR3Ra?=
 =?utf-8?B?Z1p2TVhlQWNwU25Ma0FsajlCbm1wVTJneWZFeVdVMDlZREZGMEZtbjROeWxO?=
 =?utf-8?B?dEQzVkl6WGZPaVRZODhkb1JrVHIxa3d6WkFMWUJXbDFmQ0NWUThBNTVqZlRs?=
 =?utf-8?B?UitsdE95b3VkZDF2RVZ4WU1NVFpkTWd6M3U3dWJSUTlkVDNHNXMrLzVYZWZ2?=
 =?utf-8?B?K0FaVlQrTnNEeElhWGYzTFloNmRraElqNjhVVkNQZlU4RWRpWEd0TytZQlJH?=
 =?utf-8?B?cEZ3MFFRcWVacWdqZ3RnQ0p5S1lYOXhOdS8zU0Y1WnZMOEdGa0ZHeEpKcjNQ?=
 =?utf-8?B?b0dMNitEdUd2S0pxMC9xY1FMM3JkT3AvTEd5U2dvVkhOSnJReS9FdWJQV2I1?=
 =?utf-8?B?NGJ3Q1pJcFllbVBqMkFqOEJFdUpjb1NseFVxZEhuNjlrRlprZnFPc1lFbTB4?=
 =?utf-8?B?dmVweTVWcGg4dFZiSm1PcEp2OXU0bjJoWFZsdkFpSW1nQ2JwbXFpTXh6MXIz?=
 =?utf-8?B?VHNvL1Vpd080cklUZ3pSaitzZjNpTGdNamx5S0FYT2F1REkrM2hSdTdHendi?=
 =?utf-8?B?bkZQSVdQbldZcE4vUU9Ma3UvaXpNTUpSdW54U0RUaDNJbkdEYTRpVC9PRVl0?=
 =?utf-8?B?SjEwc1F1VWZOL3lrbk4zSEUyUXYyT2RmV21WWXI2bnhJUUVHSytrRFRzcmho?=
 =?utf-8?B?NmVxNmMrTE9KSk9yMy95Ky9TcVZFSGJBUjM1cGdiN0F6UmpZTUk0SjBBM2Yz?=
 =?utf-8?B?WHVzVGJ0U0xOenFDUU9KTFFxYk40ZEFqb3E0eGlhOHhGN28yNE96c1RTVm1k?=
 =?utf-8?B?VStobTlYTU1pQVlVY2VCaGJOU0xPWElENld3NXB4NDNySGxHM0NTTU43UXF6?=
 =?utf-8?B?b3BOWkJBdzdwTHBHWTR1aGhsUnJRNzd0M2ZKRnFXU1VxYXk0Qk5mclo5eVJ5?=
 =?utf-8?B?VkhHYkxuRGxvMFByNTNYVXM2WExXZXF3aHNGSWxNTTErbmFtMTQ2WXgyYk9P?=
 =?utf-8?B?T2pwM1czcnZMTWdEaFFpRDYyMjdKSXBGM1M2OGUwMWdvN2VLeHpEQ0g3bExS?=
 =?utf-8?B?ZWE3eTErS1k5UWFDU3VPRnd4aEt6Y1RWRHoyV3NUL3NmZkQ4M3d0Wk9qTzR3?=
 =?utf-8?B?SmVWUlNFT0lFOXR4eTlyVVN5Y0U5NHZvUFBGQWNESmE1bnF5eDA3WWJQenZ5?=
 =?utf-8?B?K0c1cDBHMHhLODRaUW5EWkw1b1NoaFR3NWhSTW1kc2JmVmtPVHJJUnF3SnhM?=
 =?utf-8?B?RHJZQzZQLzk1bVk0K1k5SGR4M3JQa3dxVm0vcDZrazlMRWNVRzFUT1FxTC9L?=
 =?utf-8?B?dnIzQXBFT1hQN3NwM2huVTlsdVdKeFdVMU1NbmQzR3RPbmNOMnRySUpoaExI?=
 =?utf-8?B?WnRERStTdEdoZmYyUGhZaFpqT1lMWnY0MnRuWS9rK2dIcms4ZStoalVhMkIv?=
 =?utf-8?B?bVFFbTFMcTczZllid21aUmlEeWJnSEFCeUd0Rm0zSXJ3bWJjMUdjaXhTdTIz?=
 =?utf-8?B?OXVUanRpVTFMRHBtdmJXeC8rWFJXYkg1bEdFOS9qcjhpWExOajJnWXovV3Fn?=
 =?utf-8?B?M2JsT1FiMHNybVdhQi9wejIwY1NSSGdnTFlRNHdwR0Y3c1E3UTY3bTk2Q1J2?=
 =?utf-8?B?V2tEZkJoOXdUcDRiMmxiN0UvRG5ma2gxZGUya0JjZ29BL2NkaFo0VEZiM1Z0?=
 =?utf-8?B?aERqUzJnaUdLQnloRUZuc2E4MUZCMjdiSDhCblJvdUtCU3pHUjNyWE9IeHh4?=
 =?utf-8?B?V0FIdEhDb2UvYjJQc2tpU1cybG5Ra0drTGZMaDZEb0ZidHFZZzkyTWlxYmVs?=
 =?utf-8?B?NGxXUlB5Mk93TDEvSE9zMlRnWWRvRjc0bUIwVHVHa091RExxcnRDV1BOOVl4?=
 =?utf-8?B?WGJ2MVlVb3BhS3JXUFREcGswRXlSbGJHcUNSN0JzVkVkK3pKZmZXQkd3c3Jm?=
 =?utf-8?B?S1VyNTJzUDBaQnNhb09meU5aYmo4SGNUYzhuNDkvVlRSa3RvNHFBM0svT1Vx?=
 =?utf-8?B?YjI1bTR4aWl0citQSTZGbXlyYVVVZ2tlS3VzSEFnaVhmU0tlS3dndmhMMFN5?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad60240f-7de0-4eb4-405a-08ddf7b9521b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 20:15:47.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvjUozTJCS74RNBoDxRq8QlPocZA2XLAzi3IWZBMic0yc9If1bGkdDaRki1r5AmsvpI7b1XTE0SK+4lt7BfAcis0HUe09QjdlMttI7xQ8hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8588
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 12/9/25 09:56, Dan Williams wrote:
> > The PCIe 7.0 specification, section 11, defines the Trusted Execution
> > Environment (TEE) Device Interface Security Protocol (TDISP).  This
> > protocol definition builds upon Component Measurement and Authentication
> > (CMA), and link Integrity and Data Encryption (IDE). It adds support for
> > assigning devices (PCI physical or virtual function) to a confidential VM
> > such that the assigned device is enabled to access guest private memory
> > protected by technologies like Intel TDX, AMD SEV-SNP, RISCV COVE, or ARM
> > CCA.
> > 
> > The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> > of an agent that mediates between a "DSM" (Device Security Manager) and
> > system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> > to setup link security and assign devices. A confidential VM uses TSM
> > ABIs to transition an assigned device into the TDISP "RUN" state and
> > validate its configuration. From a Linux perspective the TSM abstracts
> > many of the details of TDISP, IDE, and CMA. Some of those details leak
> > through at times, but for the most part TDISP is an internal
> > implementation detail of the TSM.
> > 
> > CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
> > to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
> > Userspace can watch for the arrival of a "TSM" device,
> > /sys/class/tsm/tsm0/uevent KOBJ_CHANGE, to know when the PCI core has
> > initialized TSM services.
> > 
> > The operations that can be executed against a PCI device are split into
> > two mutually exclusive operation sets, "Link" and "Security" (struct
> > pci_tsm_{link,security}_ops). The "Link" operations manage physical link
> > security properties and communication with the device's Device Security
> > Manager firmware. These are the host side operations in TDISP. The
> > "Security" operations coordinate the security state of the assigned
> > virtual device (TDI). These are the guest side operations in TDISP. Only
> > link management operations are defined at this stage and placeholders
> > provided for the security operations.
> > 
> > The locking allows for multiple devices to be executing commands
> > simultaneously, one outstanding command per-device and an rwsem
> > synchronizes the implementation relative to TSM
> > registration/unregistration events.
> > 
> > Thanks to Wu Hao for his work on an early draft of this support.
> > 
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >   Documentation/ABI/testing/sysfs-bus-pci |  51 ++
> >   Documentation/driver-api/pci/index.rst  |   1 +
> >   Documentation/driver-api/pci/tsm.rst    |  12 +
> >   MAINTAINERS                             |   4 +-
> >   drivers/pci/Kconfig                     |  15 +
> >   drivers/pci/Makefile                    |   1 +
> >   drivers/pci/doe.c                       |   2 -
> >   drivers/pci/pci-sysfs.c                 |   4 +
> >   drivers/pci/pci.h                       |  10 +
> >   drivers/pci/probe.c                     |   3 +
> >   drivers/pci/remove.c                    |   6 +
> >   drivers/pci/tsm.c                       | 627 ++++++++++++++++++++++++
> >   drivers/virt/coco/tsm-core.c            |  40 +-
> >   include/linux/pci-doe.h                 |   4 +
> >   include/linux/pci-tsm.h                 | 159 ++++++
> >   include/linux/pci.h                     |   3 +
> >   include/linux/tsm.h                     |  11 +-
> >   include/uapi/linux/pci_regs.h           |   1 +
> 
> 
> A suggestion: "git format-patch -O ~/orderfile ..." produces
> nicer-to-review order of files especially where there are new
> interfaces being added.

Not the first time I have heard this recommendation, finally
implementing in my flow.

> ===
> *.txt
> configure
> Kconfig*
> *Makefile*
> *.json
> *.h
> *.c
> ===

Went with this ordering instead:

Kconfig
*/Kconfig
*/Kconfig.*
Makefile
*/Makefile
*/Makefile.*
scripts/*
Documentation/*
*.h
*.S
*.c
tools/testing/*

...stolen from Kees:

https://github.com/kees/kernel-tools/commit/909db155

[ .. scrolls past pages of uncommented context .. ]

> It is still a rather global thing. May I suggest this?

I am not too keen on this.

Yes, it is global, but less often used compared to @ops, and I do not
want both @ops and @tsm_dev in @pci_tsm. So the options are lookup @ops
from @tsm_dev or lookup @tsm_dev from @ops. Given @ops is used more
often that is how I came up with the current arrangement.


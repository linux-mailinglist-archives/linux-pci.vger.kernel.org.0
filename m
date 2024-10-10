Return-Path: <linux-pci+bounces-14179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F25E9983A2
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 12:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22F1B28028
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474411C2316;
	Thu, 10 Oct 2024 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeS3FbFU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849DB1C1AC1;
	Thu, 10 Oct 2024 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556343; cv=fail; b=HW5xLROcNx54nJHwGDPuxSyumGFTLl52eWebnijnE6uijkpqcO6sozad/SQ5lmDAo5N9boA/T3+BRI9heL2bYz5P5j7Omd2DHxW70Qm2GFQ6HxG0UHuX1Q2eRvJV0Ro8FMiVVrie35ke5rR/souDmc9EK6/7jMm4fLTtsFFcs+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556343; c=relaxed/simple;
	bh=Bs8Jn4giSEzArPZb//LTvOlHynnehCNqHp7FGu65Veg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZNDRBHNzoKEDXmGKGaIRuMZ6N0Ar0l3Tn9HvA/rs5pBiA9InGznGZcS5GUeYN1oe7TBIaBadJjTXWxE8R9hzXrINoZVv0U/wlQavNwGe/3IpA0hrcMKQ13xGbjUolfhK6OGRbBWiDRHA02kDNNOvxvqFmLuzZFjgao9tc3g41MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeS3FbFU; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728556341; x=1760092341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Bs8Jn4giSEzArPZb//LTvOlHynnehCNqHp7FGu65Veg=;
  b=JeS3FbFUE/xtGp/Y4wSTMj+Vh4geg0Tl8jebC+nmupttOkTedrJJzBSB
   SylaDlKliumcYyjiD4OUQEJ/vX8T1YpTZ+NPTPNdNftjp+d8Fj1NQnDFM
   T8r+V6LE4LUcq/cGm6Nv+JsUbjADFQxuwASeEB8ERJL+uzX1iGe7AaOvq
   TyX7TEXvtMcuSxSBObiqsAOgYcwMkpKKyihkFJ4Sj+rk3GmWevde+f2I0
   +UUmw8qdk0RgpR20FHUThz0Ukg9OO8MsOdpgM8YoeihqgNSFiiYdcjSd4
   a6DZFKYnB2Qe14MlGHyLgiLbJPUdbIM0NdyFJMycRdZiDzWAHCfnzHJZL
   A==;
X-CSE-ConnectionGUID: pEf8QKSfTfmz72F6HLM95A==
X-CSE-MsgGUID: se6TxyO8RIyznkrfkFo5Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="15528425"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="15528425"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 03:32:20 -0700
X-CSE-ConnectionGUID: v55bOunjSt65Vs2U2noWuA==
X-CSE-MsgGUID: Ispt2/E+T2e86earY0XKMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="76464924"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 03:32:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 03:32:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 03:32:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 03:32:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxObkvnTz+CwG+LZrXmCHZzrTAMMIxAjYnGyVF38xc4UMAGEUqrx8KZu9Kc9sLjViPDfz/0VMn0FzmR+AhMJ0saI9s9NdLuEFyMeTKGwHF0m5vdwtcgBHLR+xzQlcO8OFR6alRQLl4utSPrjc5JDAb5mp9ScDoa7CJPNO1B+TUBrCwJuU+0enY3L0ZYwvgRIusVc+XEy+1p7PsVeRG/Rq17Z2owoIfNYMDnKqLUdSBUDuxAJ4MjRDWyHMmxIRjg7F52Kz0H7OXIVypBuqIW7Y57RGloH5JslrAiLzNx2sdBefVhZYS4kLcLNETJna92f9YIAmbI+hveQS8OkIuU8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyYEH2qAYR9ofrIMUSnRZ7+9N+tYnnjyVObjHaQr+A8=;
 b=JAhxDeiBdaGr0aspXtEA0yK+1nDrQUzQ6p84gKd5iJvjmjCkp+l8yrlVrkDaiEI0phNuEt6rm6UCqGxHDDNH83nuHBJwb5NXt0vFpHl+7GNdGH1vlkFUvi+GDt6A+85fvK6vzfBDgCLB9Ixnsi9LsWEEeSbSTWHJluAkl4zEGgm7d5DlBx8/V8gXlKgqa8YO/5KGzDwCeEh/nqVGrd5x/0wMmWRG4km/UWQPOfgyKQpjZaRE6KAWyX2jtKgCbsZstgWlq6GpBucB2a41OTs/YEUweN1W6/t+daVrvw1fD7D+2B7ua44e+J2AHSvz5WXXEOP0bETqMnzRwXErMDYXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 MN6PR11MB8103.namprd11.prod.outlook.com (2603:10b6:208:473::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Thu, 10 Oct
 2024 10:32:15 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39%5]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 10:32:15 +0000
From: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To: <linux-pci@vger.kernel.org>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, Michal Wajdeczko
	<michal.wajdeczko@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Matt Roper
	<matthew.d.roper@intel.com>, =?UTF-8?q?Micha=C5=82=20Winiarski?=
	<michal.winiarski@intel.com>
Subject: [PATCH v3 1/5] PCI/IOV: Restore VF resizable BAR state after reset
Date: Thu, 10 Oct 2024 12:31:59 +0200
Message-ID: <20241010103203.382898-2-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241010103203.382898-1-michal.winiarski@intel.com>
References: <20241010103203.382898-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0029.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::29) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5373:EE_|MN6PR11MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 727fef6c-a28e-44ca-f976-08dce916ced5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjF2ZzBSdjB2bXlwVUtCT1ljZmY2MTB2aVVUczNvMkx6cHBYcEdtMllSYkVq?=
 =?utf-8?B?bG9SZVh4UFhtbFg0akFQUWdCNXVIamk3VVZheDhTNTZURDMvNFZ5bFYwSTVN?=
 =?utf-8?B?VFA1OERNbjZIKzJMUWw3NGVrcnVHOFRiSnhESE9JeHFkdytBRWllRFlBV2ND?=
 =?utf-8?B?Ulk0QUd5aitqei80SVFGb29vakVVMUFna0Z5TnUwV283cEIwZytLMUVkTjVs?=
 =?utf-8?B?S2F1WW5iQ0hDcmpibnZoWXZCNS9LbWY3SUpGY0RjRDlGaXhrNWg1RUhHTCtL?=
 =?utf-8?B?VXRhZ285UGkyRXV5TzdzMnJTZTExeHFPaVFjV1ErWDBGc1FtMklmMDRsRU5F?=
 =?utf-8?B?ZWgwdHVpWmVyK3JoY2I2UGhWM21FRzJSOW9OR3IranRjM0tnTEJ6R2IyVXQ2?=
 =?utf-8?B?R2ZVWUVMWTduK1MvZnMzaEpNQ3VYQzZOWk55UjVHMllkSVA4V2pqWUdzOXVZ?=
 =?utf-8?B?V3pNMmViVWVTU1BUU1ptbHp3Q1pjN0xRdHd0MGd1TTlPTnFrQkkvYTFMclRn?=
 =?utf-8?B?YzREYnhzWkQrRWMweFkza0VidG9GVEZCRlQwS05jWmVIQmNMNEMwTWJlU1h5?=
 =?utf-8?B?N3k0UisxWDVLYmw0ZFVjUXNBZkF2Y1pVWnJqZlpoL3dSem1rSlhsQlhrRUU4?=
 =?utf-8?B?cmpkazN5SXhQdnVDWDVmcmVWUFdwL3drUzZWNVRUOGE3OGJWUWFyNGEvMW8x?=
 =?utf-8?B?WEwvZzN2TzZTeENzS1YxUWt6anlFZ05UTnhwWkk5THpWK1dTdnpVT2VxY0xD?=
 =?utf-8?B?b0NzMUN5R3JaVDBmVWJ2cEw5UmI3eHdTL0NjbG9NQUhzMmU1cnZibFJLcFB3?=
 =?utf-8?B?aForb2xlZGhUTG41VW5tclRXbU9KVnc4VjVFQ0QxNThUOXM2SzFWTU4xWjBR?=
 =?utf-8?B?TGljd245MkFPUFBBdmtlN2tRaVdFaGIzMnRFVUNxTSt2L0h4VFplWjYyZ0ZO?=
 =?utf-8?B?am9zaGduN0JMTDV0VVZvNUdDTWo2QXFySG9aZVlJMkVXeFprempEdjVhRXNz?=
 =?utf-8?B?cCtQWlBZRm5BVWJZKzVCZ01IQTcrRzJLaFVLUWdQT0UzR3ZNV0c4VFZLNGlD?=
 =?utf-8?B?eUUxUk04NFNpOFFvUU13eVZLSjNxVThtK2xVaXFUUk80dHpsNXJ0UUQ3anNj?=
 =?utf-8?B?RzZnNyt1cVhUZE1sOCt2TVNHTmxDNUE2aDVVQ2owRXFTMHVQMkNHeU9LSGVW?=
 =?utf-8?B?SDNFZm9NNGFzWHVHcCtnRmtJYUMxK0J2cXVWUHVCSGZTdGc3TWh6UGxhaSto?=
 =?utf-8?B?czhMbmlualVQZjZkMVBmdUJ2Rm1odlovSnNSb1dyaFI2ak9sYzhUelR5Qmh6?=
 =?utf-8?B?U2xiYmNqRTMzdFZwdW9LRHgwK3ppL2hZZHlicHBZZGR1L0c0N3NUNU1QaXFr?=
 =?utf-8?B?VlRXR1ZSYlc1OVR1Z1cwd0hFb2RQV0ZuSU5IYysxVHd1YWplbW1VZjJzcWdy?=
 =?utf-8?B?cG9VWHBhT3pVdFNSaFV2czRFYTBKQ2JiMFZRUjRLVVlYVkkzaTdVa3Y3Nk14?=
 =?utf-8?B?L2VObzN1ZTJ2MDh0Q3dqcVh1N1ltUkk2L2tmUkh1NDlwd09kdXRFelA3eUoy?=
 =?utf-8?B?MkxsQ3daUU5MSkJ6MW41ditXbmtINlZDNzVVS2VFU3ZJV0lSOGVsTm4vZElh?=
 =?utf-8?B?YWFmNUxSbGhuZU5PSjA4c3NDTWEyd05Jek16bmlJais3di9xTEsvTU1LdCtw?=
 =?utf-8?B?YVhPVEo0K21ib0NyVi9KczFzYUYrRGR0dkRDeVBlaElxS25XZXNxRDNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDNxUnpyMDhwZ0l6V3lKSXUxRk5VSTIxMEpuMXdzRWo5ZDdUVHNWNUZoUHFV?=
 =?utf-8?B?cjNwVWdXUFo1dnpVTkN1SVdJOXdPTDRCSE5INFljbGRMbEh2RVAvOHhMd3kw?=
 =?utf-8?B?NnJscjhZenJCL3lXak8yaW1GVUtGRGNwRTUwZjd5Uk9iUGdpd0ZnaXB3Zzhq?=
 =?utf-8?B?ZEQ5SnV3Ympzc1ZrblBlcDdHSDc4d0ZmYVphN0dSV2FBemRaVWJOaXdlMFNh?=
 =?utf-8?B?T2F3elhQZndZSUh2MDlQVlR6TG5paFkyd0w1OUdOTkxpZWlYS2xwWklzd0VT?=
 =?utf-8?B?a0JHNERtbXg0QWRLdnFjV0lpZ2ZJc2tTNjJ0S0drTWwrMmdGR1NxTXhRdDND?=
 =?utf-8?B?U1U1endwb3JFSk9iU21ZTU9yU25EeDVBNnJMYllOWWtsdDRQbVd4aC9JQm9C?=
 =?utf-8?B?S2xnUlJpWEJ1SEUvTlVjSDJCa3lEaHZSMVg1czdqNG5FV0N3MnAzNTJxeEt2?=
 =?utf-8?B?d2JXb2dEbUdKWFdyR0pUcFRaUW95eXhsWUFHN2ZHNDRKMGNxZi8vWE1uNFJ4?=
 =?utf-8?B?Tzd0Q1dSM3lYZ1VDR2NGbnZ0YUpZb29lSDNPcVBaTFZOSUd5a3NIMUl0NFBz?=
 =?utf-8?B?czhid3NBczRhMFE0RHFrdGFUdWhPVmZsRzl4NDdFd1hWeGxDUWNvMGx2dWts?=
 =?utf-8?B?UUVLRUE2S2F0SUYyMmw1T2podkVRa2RTb1VpekFpVE9HRU1JRnFrRzR3dWFC?=
 =?utf-8?B?UXBHVlpWajNUNFJuN1dlV1lCTmJidzJCT25JUC9vSng4NG1NUWNjc2lnTEZy?=
 =?utf-8?B?N2FuWVVIRFBucTN6QUl0VmZIeWszSTFMZ2NmMURnbXc0Q1hZQzNGaEFlOXhm?=
 =?utf-8?B?VUMrRHdmMFVOandwME4ySUE1dkJ0OFVmNmcvSFZCWUs2Q2k4M0tIZytnbkVW?=
 =?utf-8?B?TGhOZWNTYmNsMXhmdHR5bkFzRm5uMXVXQnVVZGtHN0NHdmdxU2E4UndPZjBa?=
 =?utf-8?B?VlY2VzVuejA0NHdqditCSFBTemdQbEpMYnlZZ3JoVDRKcnpDSEw1Q2xBOVpH?=
 =?utf-8?B?dkNBZkxYckdzdnVKeG9YMEtoUi8vQlJjMmVaMVZoeFUrZWVvSEhNV05kNTZI?=
 =?utf-8?B?YkQvQ2lQWENvZThJYUJRY2FPTGIwWmZ4dUNkWUdlLzUwam1nM3hvRHdkSlY2?=
 =?utf-8?B?TU5hMmI2WFVPNm1OTld1KzEvMWxUZzk0VEJwblhhRHVoS05qclhZRmw1RVhT?=
 =?utf-8?B?UzVqeVBBbjM2MGNTR1BXamVXZ3J4YTVnSVg3U2Fzd2xGQTYyRGQxYy92Mkls?=
 =?utf-8?B?STBOMUljejZnTStnVjNyVWYzT3c0b1NQYWdRdEZuekZYL2VheDFIOW92M3hi?=
 =?utf-8?B?L0NkZm40NzdnYUZ1eFJtU1ZtUkVpQmtRcHJFUStMTVhSdHpjdzU1Z0t4K3M3?=
 =?utf-8?B?Vi8xZkZxZXJ0eVpOZ1BqaXROQUtKdTlya2pYazVYNitrVFZwT3pXOUJMN25y?=
 =?utf-8?B?Qys3NW9rR0lGbDNNa0w1bUtZdDRYTVpXOG5nLzNidEpSUndMM2g0bjNQOHJW?=
 =?utf-8?B?ZHhmV2FZNUxVamRPUUJtaHlTMk92RHp1YUphV1A2VVRpOU5DdTJURnZBM1Jz?=
 =?utf-8?B?VGhjcHVyaEkrL0hkNUd5VTg5VmIwLzZCR3NkaE02ZjRNcHNqdHJmYTFIa0Ro?=
 =?utf-8?B?azV3MXFCdCtoVUdnQ2NDam05bGRqYkJ4KzVhSmRybUxaUHd0NCtXb3lUSjZj?=
 =?utf-8?B?UUwwOHlkcTkwdzJHSmJ3bkhNNFRtOE04VVNZT28zdmZhOFFIaDJ3REJqK2xR?=
 =?utf-8?B?U21iejdQUVczY1NOcEh2TmxwcVBwZlRET2g1QkFhRHZxQVZ2QmQvc2taZVJm?=
 =?utf-8?B?MzV3eW9CN01jMXRaQTV5WnA1V1hjU1k3c2tVbngwSUVvaFRpVmVIQ0xjVmxG?=
 =?utf-8?B?UWtUY1k2OWRrQmVnd2VHaWw5SnhaRythV0E2SThkUmpMR1MvZHA3bThsa2Zo?=
 =?utf-8?B?RXdTbjV2ME5UeG5rUk1Ia3Y3S0R4NnkyUUhjK1U4RWhuVXp0K0RKdVNuSm1X?=
 =?utf-8?B?QXJ2N3pqWG5KeXVWbnF6YnlUSmI1MHI4aWhWWGZXMThyT21VK1A5Qm9hbUcw?=
 =?utf-8?B?QWxxS0JlTjNyNDlnUnhTWENkRWpKbWNqdE53VmgzRHhKa0ExZHVESEJVS1BI?=
 =?utf-8?B?QXVIakxMd01lQ2ZvL1pQaVFmdEttS2dFYlBqejlod1VaaUZVYUdSejduMW9C?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 727fef6c-a28e-44ca-f976-08dce916ced5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 10:32:14.9701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVXEKXCCClLRcvJhHTc5FqsYOxG5yD6sk7fa5GfU3VLM02bNLxQvHh2XuaMQFntp92y03M4nHCY+XHdhb4+S0xwY40qw0E5u6J2IuRwlSn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8103
X-OriginatorOrg: intel.com

Similar to regular resizable BAR, VF BAR can also be resized, e.g. by
the system firmware, or the PCI subsystem itself.
Add the capability ID and restore it as a part of IOV state.
See PCIe r4.0, sec 9.3.7.4.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/pci/iov.c             | 29 ++++++++++++++++++++++++++++-
 include/uapi/linux/pci_regs.h |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index aaa33e8dc4c97..fd5c059b29c13 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2009 Intel Corporation, Yu Zhao <yu.zhao@intel.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/export.h>
@@ -862,6 +863,30 @@ static void sriov_release(struct pci_dev *dev)
 	dev->sriov = NULL;
 }
 
+static void sriov_restore_vf_rebar_state(struct pci_dev *dev)
+{
+	unsigned int pos, nbars, i;
+	u32 ctrl;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VF_REBAR);
+	if (!pos)
+		return;
+
+	pci_read_config_dword(dev, pos + PCI_REBAR_CTRL, &ctrl);
+	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
+
+	for (i = 0; i < nbars; i++, pos += 8) {
+		int bar_idx, size;
+
+		pci_read_config_dword(dev, pos + PCI_REBAR_CTRL, &ctrl);
+		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
+		size = pci_rebar_bytes_to_size(dev->sriov->barsz[bar_idx]);
+		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
+		ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
+		pci_write_config_dword(dev, pos + PCI_REBAR_CTRL, ctrl);
+	}
+}
+
 static void sriov_restore_state(struct pci_dev *dev)
 {
 	int i;
@@ -1021,8 +1046,10 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
  */
 void pci_restore_iov_state(struct pci_dev *dev)
 {
-	if (dev->is_physfn)
+	if (dev->is_physfn) {
+		sriov_restore_vf_rebar_state(dev);
 		sriov_restore_state(dev);
+	}
 }
 
 /**
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 12323b3334a9c..a0cf701c4c3af 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -740,6 +740,7 @@
 #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
 #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
 #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
+#define PCI_EXT_CAP_ID_VF_REBAR 0x24	/* VF Resizable BAR */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
-- 
2.47.0



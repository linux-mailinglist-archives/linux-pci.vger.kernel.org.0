Return-Path: <linux-pci+bounces-32080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6ADB04764
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 20:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68234A0C02
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 18:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8838426C3AE;
	Mon, 14 Jul 2025 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6gurO1L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EEC266B52
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752517630; cv=fail; b=Rx55GvsnnpKt4yi2538wDP5LZ2VygB4+1Z6GNuz9jJQc0HMxHJr0JdO6shlq2essXaFgzHG+N9rU5XBs4N79yhXsvhD+kD4TUuAwLYUUur2kbfSRjZqFzY5Din7LMJdfyfyqDaiQnovDEQZrEdqSFGVAJEoJeMVnC6N+qFQURnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752517630; c=relaxed/simple;
	bh=ylwUOQ0Oxac59QPxFH2g8L8BhEjS/0Gpa+l80ZApGCc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=cWlKfxMebieHr9u4XaMlMGLySyttEHz1FBde6uODrkGWCanNqC3eeVraXNWpMcOXRThn3fgJNitYU0LUpBQEPNyK0OjPNIimbPS/1jKGHPrBotFFxNL6pCee+Q+b6QNVt4SohrJvyHbmnqSg8NNGSK8jyXnBBotps9T1ILDoiLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6gurO1L; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752517629; x=1784053629;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ylwUOQ0Oxac59QPxFH2g8L8BhEjS/0Gpa+l80ZApGCc=;
  b=I6gurO1LtKIANbEcHwg9kBq3ZrJnXUboyTCyiCEaPtH5oNuQTnPO+cka
   t8CR9TMl4bCc+0xmPuLVwjZkopydbW90niqvy78phGjXMcl+Nlvey+vt5
   NXFO9ksNWLTO9zCSWszCfiIyOiA6X5fFoppgEGKEZbr50CTN1VCwZ3gOg
   R6naMzrff/elmhfqMq1bKN+EvzHZl1qz55qOi3ouMB8aPa/wCmpsGa68U
   whLvfE2U0jrPjc4YY6rXkus0gIom+KmjSGtHjkS+hDo57IytwT94ANHDG
   1qtsQTA7qg2KH76RpKjiu5l2STf7RAGCtZy91MzUw2PcRIs8geCZFqL0G
   A==;
X-CSE-ConnectionGUID: fB4c+Y56TP6feApmoM8ekA==
X-CSE-MsgGUID: brKP/nZqSFOH+iDmTnXilA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54655716"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="54655716"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 11:27:08 -0700
X-CSE-ConnectionGUID: XtN5mv5fSDCdqDZt+3Iz4w==
X-CSE-MsgGUID: uv5GP1DuRHudLsi7GONvPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="180703925"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 11:27:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 14 Jul 2025 11:26:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 14 Jul 2025 11:26:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 11:26:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPj137OB/B79GR1Rjv4UkFSECDQSIvNdA7x4GeHLGj1jO1v7qsQ0pHh/eURiY2FIhMF+eL3LNnB06qokjbpgqO3GOI0uDz1WxB9ckjN6DPADldQdUHYzdbvQa8JQrS1fdBPs8s10kk5T4EvvPnWXUu/T9TAwD/D8VH8aj8YGUJ/Z+MHHDPdqpO6joG1KXHGyusqePkZZa+JcPxgq5UL7gfgFyzBxMbhbpQBkQBxdj/2ZiS82vhHp1kkgpKX4s/0c1t/8/n2EIJ2Afj2YOt+jUHRXviwjdpUFd0ginbC3s0poKuUPd2eR65ZpVeltw4JaTyIJYU4NO3dRAywno/D3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oh3XHCIXXeaojK+yXl5Up5ltufh9Q2FOXHlwiOio7cc=;
 b=nt4hf0mKuN4v97O/ETrlwgnGYSz0q/iZEl2O9gSEqOPiCMZOgH2qhlwQ94TAZLHhvpodiA3E635WxqzngA2iUHJiVS+q99+eauR+UIjp7lgBV8V5zm1+fPQGJS2YfH+xPGe4hiBlr+3qd8roksE4Zmzo/A3Xoefsm0upj7PqKhX1AW4erKeOHVc5e/S3VSknKOPky/XY5D1gY6kitMxYMnv1aNPIZDB24Kjaitg+6R5cwhH1YqJUCTWermBCjWqCvuoFgiH5lXq6NWc0w1HtA/nJFNLp4RCr9zM8BgGATlg4utY/n6cIy17GRmU73g2sTEiO9hC6UOs9XEOlja7VIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPF2F49754B6.namprd11.prod.outlook.com (2603:10b6:f:fc02::1a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 14 Jul
 2025 18:25:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 18:25:58 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 14 Jul 2025 11:25:56 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Yilun Xu <yilun.xu@linux.intel.com>
Message-ID: <68754bb42e053_25d31002b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250617150434.00003a91@huawei.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-9-dan.j.williams@intel.com>
 <20250617150434.00003a91@huawei.com>
Subject: Re: [PATCH v3 08/13] PCI/IDE: Add IDE establishment helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPF2F49754B6:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da5bf70-507a-4fb9-6cda-08ddc303e0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFVIMDlnQUFzZWlWWVprN3RUbDV2QmVPN0dBWThvOXYyQ0lpNkcrT3NRR01z?=
 =?utf-8?B?cUVhWjlqcytqbUYyeExIMGs4WTRLdWdjQlBhNTRDOWE2blV2bUFzbkVVd0Q4?=
 =?utf-8?B?am9Wd0hXT3RPZ1lBeUtzN3dZZUxCeU9YdSswVXNrazFWNFJ2NXBSVEM4ajNo?=
 =?utf-8?B?aHh2ZXZHUFQ1OXFGWjFZZ3BFSmJwT1I4SW9DOHo3SUZQMkhxcUdFMk80Njhj?=
 =?utf-8?B?WjVHTFFNaG9sR0hkQ0dQVlhXWXU0T3pDcmM3SmxyeVFpMDl4SkxxLzRtZlJP?=
 =?utf-8?B?c1IvVzQwUkZSZ0pqVlZlbEYxenF1dXVYby9LdE84bjdQT2QwSzVlMzNhaXZB?=
 =?utf-8?B?M1VWdzI4UGxYRExnMHZYS3B1elBKREE1Z3F3UUJZMTFVUmFTbDkvZFRZZ2tr?=
 =?utf-8?B?M045dnVTajE3UmpkaFYzQU01RnhSTjBMNXFoK3doSWtJaXVDMzZ3YWxGY0d3?=
 =?utf-8?B?SUlDVEFrcFl5Z3NNV1lXSGRzSGRhL2VrTjdLNTEwTVpVVkdlY0VOUzEwTnBp?=
 =?utf-8?B?c3dCQzZ3MHNQak1JVGNURVNCcXRuNDdPWEhFL0xSZFFJNkpVZ09zZE93ZFJl?=
 =?utf-8?B?dzA5R3BndVBsUy9UdnVlVTJzZjN6Z21PU3pkL2F6Nm56VVc0SkxOYWZTNi9V?=
 =?utf-8?B?Rjc0dlhQT2V2VFJlVVVGcGY5T0I0QWlsVG00eDU0YmVzOVI3a3hST0ZiY2Ux?=
 =?utf-8?B?bm1qdnVPemliemxuSG9xQTVmOWtHQU9iRStqSWZuRDdPanpKQm91NmVpRTZi?=
 =?utf-8?B?YXJxeVZzS0kvYTVPemJ1VGpmU3hIYk1lTk9tbmhib3ZIeExvdWtNYTNkQWR3?=
 =?utf-8?B?eUhrUjU1Y1pCYWNjWjFPRlkvT2NmUU45QUlPWUdkSTFySVdwMXBLa05yeW1I?=
 =?utf-8?B?Z3FXSlVEQS81Y2h6Z0ZXVExIR1YzQjU3elQ3ZTgvWXJaTVRWdzZtRmt3N1pt?=
 =?utf-8?B?V3ppYjNPbEp6bk5SSXNDN3BlL2RTWVJtUjlaeklOUTY1YkYzRjFvRjJwT2hS?=
 =?utf-8?B?OFZYOUZQVktUVHNtdmU4ZjBDOWJrVWtJd1lRVXpITlJnWG1GOTBWMFBpMzhH?=
 =?utf-8?B?VEZVdnU3QmlEWDc1aFBjWWk4ZDZjeVQ1azZXRFF6WnhWVUdBZ2dBWXdFVm54?=
 =?utf-8?B?UE9kQU9HUGJxZ0dFK1dieXhPY000TGllcmdFMGVZZkRWL1dGUmhiOTJtUisz?=
 =?utf-8?B?T2pjVlJNbC9UdnJydWliRktCUTlma0I1VVdCM1BsMVZXZ2RnSDRTQ0p5Yi9x?=
 =?utf-8?B?c3UvWWV6VUdrTmtRVG9mUFBocHV0QnovYkJ5M0hmNUZrS3VDTUlEMEhodUlH?=
 =?utf-8?B?aFVZQVpnNjM4a08xdVZlMEVrN1JGb1ROZ2YvTmFQMng1alhVQkFKVndtWFdm?=
 =?utf-8?B?eDRBSG1tc1ZORnFyUXNJOW1MSVN2TXd6MnZ6aHBZcVZVdVhXWjh6RHIrTWxO?=
 =?utf-8?B?a25WU1lkVS8wTDM5U2hMYlJvM3QyVy85YmE3MEhPZnVPdXVzeHJJN3RtOE5i?=
 =?utf-8?B?Y1BhVU1ucm9vVmdqUlZ0bWhsYmpNNWlldnFBUmNBRUlFRmFjUWR1QTVQL1JV?=
 =?utf-8?B?QmlYNS9lTnlJZlNzT2t2Z2FHVDhibkJjZnpPY2F5UFNnOFk3YnN3ek56OFNO?=
 =?utf-8?B?aTN3dXNHNnA4UFA1aDQ3aE16b3JDSjRvU3Z4bzhnREtZeFhWb0RRazFId1Rm?=
 =?utf-8?B?UHJzQWFCanA3RDhnMUVDcnNJVXVCSm5la1Z6c1g0YnNhQk5LMXNRdkNCQU00?=
 =?utf-8?B?SU1Xb0trdzlOeTUzOTMxcnFJSHhMMUJmRkhuWFZ0aTl3QTJESkNPZVE0Tklv?=
 =?utf-8?B?WE94OHNBbjA1VzkwMlIrTXZJUDhUTlZSZUQzUjNzcXB5Wno5RVkwUHJ5ZjBO?=
 =?utf-8?B?TC9mZWpRbnZtbmk2TVA4SS9yQUNBOFoyTTVRTGNvTDVkbVpOUWlxaG5mb0ND?=
 =?utf-8?Q?v+TVIcmlX4g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clpyRUhoRUlaSEp6aktzREwwc2V4dDAvaURIWGkwQ1hNdGRUdnM3TjZOT3g3?=
 =?utf-8?B?TkxtZi9xUkhhRWZZNWZWNTNvdGNJRUxMcERtTHlWeTYyMFN4NzduSzJLM25u?=
 =?utf-8?B?eWFXQjBtblFLUVVRbVpKS3UydjNsckRCTyt2dWROZTIzZnFzM2JQc084UEZF?=
 =?utf-8?B?bFMrNUdlRHFiazBxanU5THQ1aVdieEtkTi9XY0JsL3RuaHBhcmxmV2I2QUZS?=
 =?utf-8?B?NGFvdDZqWFpxcXAxZ2E3L3JUSzJrVjhDN2doOElNUEFveFEzZTlNa1MybzF2?=
 =?utf-8?B?VDB5L0VmWmU4Wm12ekNqUjFRSWp4S01aVHFzWTV5QWFWNVM3NFBVQ3RNaTlp?=
 =?utf-8?B?bnIwNGJqN0FqVDMxeDdHYU1LOFR0N1BPKzNlRWtNcVhCcEM0MFFGMmgrT0l6?=
 =?utf-8?B?ZnF6aDlIMEhYYTc1K2dsNXFvWkY5eUwzMVlwa3lhNzZQM3dOWU9WT1pEQ0RT?=
 =?utf-8?B?MHU4Tk02MXUxejVja2ZsbmM0NHlwcG5rSDhhejhIV0RYS1hpZ21Mc1BnMmtU?=
 =?utf-8?B?Tjd5V3M2NkNlUFdiMUloWmsrd3IyOEM4TWVXdkhHSWhpVGFFWURwVlpVaXB5?=
 =?utf-8?B?OU4ySGxUT0NjQ3RzWi9rRGFFTTI3UUtEZ2FCRFAweURyTnRYUzF4VTA5dDZL?=
 =?utf-8?B?cmlWanFXc2xnenhCdExwdmtOdm9YRDU3ZjIxUUZyOHBtODFYRmdjSDBxbVlK?=
 =?utf-8?B?UlRocktOUmhuOEZobTBTanpxTWx3ckYwOWNyMmZPZUQ1Q1hXaWxqbFExUUhl?=
 =?utf-8?B?cytkL2x3VzlUaUJhTmdrNUh2TVdseDJIaXFkdjc3MjhLZkNvYlFQb2MrNmVT?=
 =?utf-8?B?bU5yeWJvM3N3MXZDOEwyTCsrcUUrZnlQam9UZHpBT0pIc1BKYi9aUFRYaFVk?=
 =?utf-8?B?Q0hkZmN2TmE2cG04ejFIS0JGdHpaTGtRVXVvdGthaitVeUhtM2doZzNNOS96?=
 =?utf-8?B?US91S3YzZ0xNVVRzanpwbXNoSGlWRUVBdTdoa2xLTkNmcGNxSkNSZVFQWTd4?=
 =?utf-8?B?NnBlODI3MkZHT2ZQUXkyODhkc0ErVVhETzNSMDRYU1U1RzFMWmFmRU1UWjZk?=
 =?utf-8?B?bkF4Um1MaEVtdmhhSGZMWG9qREZkR25Gb21Idm03dUtQOVpWclZmNFVWRDJv?=
 =?utf-8?B?d09IMFNFWk5rSWV3Q0pTVThWK24vd1VxK202djYwSldQOG1vWUlYUUxRK0ZL?=
 =?utf-8?B?T0tibUFVNnJZdXZueVdCaEgyc1hMN2pjWTA3V0xBNE9wL3FwQ2dlVWRPMmtK?=
 =?utf-8?B?YVJFOHNZa1hlQm9VeklmMEpDRWxaNWd4ZnZmOWVOWlhlWVJvYUZKbS84RzRS?=
 =?utf-8?B?b2U4S3JBRkl3YmJnOHVpVUhaTi9ZTFR4ZXZmNWFPUytuM3dPbXpES3Bhd1hQ?=
 =?utf-8?B?bGFZNDV0dXd0aGVob0lNalJHNGhkR21lV0NrbGs5RHZqRDB3RWlNK08wVGRv?=
 =?utf-8?B?Q0lRL2tONU1TLzlkdVpNd1FqRWtoV0c5eDkva0tnQ2k3TldEa2VmQjMxTGlN?=
 =?utf-8?B?MUNQTEFlYm5SZWhOVGYvVlowbyt3UHNic0xOaHhXYXV5Zm5aUHpKMHExM0ky?=
 =?utf-8?B?cXVEL2pHMmxWWGpBSXh0eFdocjR1Q05iNlpPM09hdTE2M0IxOTBlcFh5d0NR?=
 =?utf-8?B?Rkd2dG9KYUlQdjI5N284dmJzZFpoMEY4d1BtV1dxMU5UZk92VlhucjdqNlZY?=
 =?utf-8?B?VVdJZGNyQjBFYlpoUkhDVXRoWThBakJXNDB3MVUvYjBSS2lpT2ZvK1g3Y2tn?=
 =?utf-8?B?c1VvZFNzbTFMSG9aUXJ4NkYrNkdGYnpyYmpjZ28yM3MxU2Nvc3Y0T2tNUkl2?=
 =?utf-8?B?cDNOa3FQMCtuMFJ3VW9tRGtqVERXSmlEcDRLS1dYZ09jdVNzNmtHbE1VMnA5?=
 =?utf-8?B?TGNRM2RGVDFhUmlBOGxnNEdSZTNlY21nakNZcXNLRUJGZTJPQ25WZ3QxRWk3?=
 =?utf-8?B?UHRHZ2l2ZSttUlNUN1hmYW1MeDRpQkJxTzRMSWNpZmNWS21ZRUluT3NvRkFu?=
 =?utf-8?B?OENJaXloZFdBeFB1MmxEZ0J0Zy9tOGZ3YjNTVklhUEQzaEY2N3pIM0dXN2w4?=
 =?utf-8?B?SlRYT2pUaHBsSjRRcG12TVNQb2ZlN2RwVnFVUEFzdlZXVzlLL0dleWNkK3N0?=
 =?utf-8?B?dDdYd0E0OW9WNTFIUXlVdW1sQXh6TzBuWTRmWUViVXQrMHV3aHkvMzZyY0ZY?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da5bf70-507a-4fb9-6cda-08ddc303e0bd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 18:25:58.1478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwZrsvFjTucmpF1q3GBP8N/t3483ewBoaUvAiOlNnQLGsVNM1OdSymn35z10YOYhr2op1GzNeZUGntNXIo3/GuwmZyoP086VLMV7gR3lA3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2F49754B6
X-OriginatorOrg: intel.com


Jonathan Cameron wrote:
> On Thu, 15 May 2025 22:47:27 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > There are two components to establishing an encrypted link, provisioning
> > the stream in Partner Port config-space, and programming the keys into
> > the link layer via IDE_KM (IDE Key Management). This new library,
> > drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
> > driver, is saved for later.
> > 
> > With the platform TSM implementations of SEV-TIO and TDX Connect in mind
> > this library abstracts small differences in those implementations. For
> > example, TDX Connect handles Root Port register setup while SEV-TIO
> > expects System Software to update the Root Port registers. This is the
> > rationale for fine-grained 'setup' + 'enable' verbs.
> > 
> > The other design detail for TSM-coordinated IDE establishment is that
> > the TSM may manage allocation of Stream IDs, this is why the Stream ID
> > value is passed in to pci_ide_stream_setup().
> > 
> > The flow is:
> > 
> > pci_ide_stream_alloc()
> >   Allocate a Selective IDE Stream Register Block in each Partner Port
> >   (Endpoint + Root Port), and reserve a host bridge / platform stream
> >   slot. Gather Partner Port specific stream settings like Requester ID.
> > pci_ide_stream_register()
> >   Publish the stream in sysfs after allocating a Stream ID. In the TSM
> >   case the TSM allocates the Stream ID for the Partner Port pair.
> > pci_ide_stream_setup()
> >   Program the stream settings to a Partner Port. Caller is responsible
> >   for optionally calling this for the Root Port as well if the TSM
> >   implementation requires it.
> > pci_ide_stream_enable()
> >   Try to run the stream after IDE_KM.
> > 
> > In support of system administrators auditing where platform, Root Port,
> > and Endpoint IDE stream resources are being spent, the allocated stream
> > is reflected as a symlink from the host bridge to the endpoint with the
> > name:
> > 
> >     stream%d.%d.%d:%s
> > 
> > Where the tuple of integers reflects the allocated platform, Root Port,
> > and Endpoint stream index (Selective IDE Stream Register Block) values,
> > and the %s is the endpoint device name.
> > 
> > Thanks to Wu Hao for a draft implementation of this infrastructure.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> > Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> > Co-developed-by: Yilun Xu <yilun.xu@linux.intel.com>
> > Signed-off-by: Yilun Xu <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> A few little comments inline.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  .../ABI/testing/sysfs-devices-pci-host-bridge |  38 ++
> >  MAINTAINERS                                   |   1 +
> >  drivers/pci/ide.c                             | 366 ++++++++++++++++++
> >  include/linux/pci-ide.h                       |  76 ++++
> >  include/linux/pci.h                           |   6 +
> >  include/uapi/linux/pci_regs.h                 |   2 +
> >  6 files changed, 489 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> >  create mode 100644 include/linux/pci-ide.h
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> > new file mode 100644
> > index 000000000000..d592b68c7333
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> > @@ -0,0 +1,38 @@
> > +What:		/sys/devices/pciDDDD:BB
> > +		/sys/devices/.../pciDDDD:BB
> > +Date:		December, 2024
> > +Contact:	linux-pci@vger.kernel.org
> > +Description:
> > +		A PCI host bridge device parents a PCI bus device topology. PCI
> > +		controllers may also parent host bridges. The DDDD:BB format
> > +		conveys the PCI domain (ACPI segment) number and root bus number
> > +		(in hexadecimal) of the host bridge. Note that the domain number
> > +		may be larger than the 16-bits that the "DDDD" format implies
> > +		for emulated host-bridges.
> > +
> > +What:		pciDDDD:BB/firmware_node
> > +Date:		December, 2024
> > +Contact:	linux-pci@vger.kernel.org
> > +Description:
> > +		(RO) Symlink to the platform firmware device object "companion"
> > +		of the host bridge. For example, an ACPI device with an _HID of
> > +		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00). See
> > +		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
> > +		format.
> 
> No problem with this documentation but not I think related to this patch and
> could go upstream before this?

Sure, given there are a few other things in this series that could go upstream
in advance of the TSM bits, I will pull this and those out.

> 
> > +
> > +What:		pciDDDD:BB/streamH.R.E:DDDD:BB:DD:F
> > +Date:		December, 2024
> > +Contact:	linux-pci@vger.kernel.org
> > +Description:
> > +		(RO) When a platform has established a secure connection, PCIe
> > +		IDE, between two Partner Ports, this symlink appears. The
> > +		primary function is to account the stream slot / resources
> > +		consumed in each of the (H)ost bridge, (R)oot Port and
> > +		(E)ndpoint that will be freed when invoking the tsm/disconnect
> > +		flow. The link points to the endpoint PCI device at domain:DDDD
> > +		bus:BB device:DD function:F. Where R and E represent the
> > +		assigned Selective IDE Stream Register Block in the Root Port
> > +		and Endpoint, and H represents a platform specific pool of
> > +		stream resources shared by the Root Ports in a host bridge.  See
> > +		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
> > +		format.
> 
> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > index 98a51596e329..a529926647f4 100644
> > --- a/drivers/pci/ide.c
> > +++ b/drivers/pci/ide.c
> 
> > +/**
> > + * pci_ide_stream_enable() - after setup, enable the stream
> > + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> > + * @ide: registered and setup IDE settings descriptor
> > + *
> > + * Activate the stream by writing to the Selective IDE Stream Control Register.
> > + */
> > +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
> > +{
> > +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> > +	int pos;
> > +	u32 val;
> > +
> > +	if (!settings)
> > +		return -ENXIO;
> > +
> > +	pos = sel_ide_offset(pdev, settings);
> > +
> > +	set_ide_sel_ctl(pdev, ide, pos, true);
> > +
> > +	pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
> > +	if (FIELD_GET(PCI_IDE_SEL_STS_STATE_MASK, val) !=
> > +	    PCI_IDE_SEL_STS_STATE_SECURE)
> > +		return -ENXIO;
> 
> Trivial but blank line here would I think help readability a tiny bit.

Ack.

> 
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_ide_stream_enable);
> 
> > diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> > new file mode 100644
> > index 000000000000..0753c3cd752a
> > --- /dev/null
> > +++ b/include/linux/pci-ide.h
> > @@ -0,0 +1,76 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> > +
> > +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> > +
> > +#ifndef __PCI_IDE_H__
> > +#define __PCI_IDE_H__
> > +
> > +#include <linux/range.h>
> 
> Needed?  I'm guessing it was and isn't any more.

Yup, good catch.

> > +
> > +#define SEL_ADDR1_LOWER_MASK GENMASK(31, 20)
> > +#define SEL_ADDR_UPPER_MASK GENMASK_ULL(63, 32)
> > +#define PREP_PCI_IDE_SEL_ADDR1(base, limit)                    \
> 
> ADDR_1 would be more consistent.
> 
> However, unless we are going to see a lot of these I'd personally prefer
> to see this lot inline in the code.
> 
> > +	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |             \
> > +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,          \
> > +		    FIELD_GET(SEL_ADDR1_LOWER_MASK, (base))) | \
> 
> This is a case I'd just not use FIELD_PREP / GET for. Just ends up
> confusing and needs definitions that make little sense on their own.
> 	lower_32_bits(base) & PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK
> perhaps.
> 
> > +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,         \
> > +		    FIELD_GET(SEL_ADDR1_LOWER_MASK, (limit))))
> 
> Maybe use upper_32_bits() for this one.
> 
> However it is an odd macro and I can't immediately find where it is used
> so maybe just drop it?

It was in an earlier rev, but I dropped it for simplicity. For now,
there is no address limitations within the the stream.

> 
> > +
> > +#define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
> > +	(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
> > +	 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, (base)) | \
> > +	 FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, (domain)))
> This one I'd prefer to see inline.
> 
> > +/**
> > + * struct pci_ide_partner - Per port IDE Stream settings
> > + * @rid_start: Partner Port Requester ID range start
> > + * @rid_start: Partner Port Requester ID range end
> > + * @stream_index: Selective IDE Stream Register Block selection
> > + */
> > +struct pci_ide_partner {
> > +	u16 rid_start;
> > +	u16 rid_end;
> > +	u8 stream_index;
> > +};
> > +
> > +/**
> > + * struct pci_ide - PCIe Selective IDE Stream descriptor
> > + * @pdev: PCIe Endpoint for the stream
> > + * @partner: settings for both partner ports in a stream
> > + * @host_bridge_stream: track platform Stream index
> 
> Why the capital S?  Seems a little inconsistent across different comments.

So this was deliberate, but does indeed look strange. Bjorn has asked,
and I agree with him, that specification terms be capitalized. So the
"Stream index" is the PCI defined number that gets programmed into
hardware registers for a Selective IDE Stream, and "stream" is the name
of the related Linux software collateral.

That is indeed too subtle. I think adding the full Selective IDE Stream
for those cases will help distinguish.


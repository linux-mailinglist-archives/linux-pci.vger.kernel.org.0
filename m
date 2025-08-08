Return-Path: <linux-pci+bounces-33646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D74B1F11F
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 00:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874B93A221F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 22:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CCB22424E;
	Fri,  8 Aug 2025 22:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTYMKn+k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FE91C8633;
	Fri,  8 Aug 2025 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754693484; cv=fail; b=pysrsXDa36s+9rjYbvKM5bIdhwChR4CWpUL0pDlJumWil/ONHI4tbgOY//S60A/53KdiNmFzmSrzSfrLSwBLKDuGRwpAs1hb3VqymlrmwTPJ7FftkPlfqOHRw3tXAwdCR3SejzxWfOEbm7p2cZ69zY8Ko/rhGG9XUmfQxYZEk38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754693484; c=relaxed/simple;
	bh=bA/PV/r2ZE8Cxwt/QtEcHTpDJ/7uiDVvvpNqvqVsHEE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=mHx54dfDeBkKKyPYP1OHPa1LpURIBcmFqNehnmZwJBtRUDUpohto1WeVzYgGQizlmXKXpvDIcWK5RVqKwIwx8tvv0iXH7hCcbxOTc49+ZY+qcb1Zh/kFvmPSJIubkrupmI6a0QuiUDp8B2IrGforA2YpN286fbnvy0y/NHgHCYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTYMKn+k; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754693483; x=1786229483;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=bA/PV/r2ZE8Cxwt/QtEcHTpDJ/7uiDVvvpNqvqVsHEE=;
  b=QTYMKn+kOI1eYY3Rtsmh/NXLT9TKdXDUvZiny/l7WvPxW2fTqpiNtu/F
   +fCLDrhkP8iKdcS/otGQfbGzfN2J6CRWinOVDGU5lNkCj+2Ax5vI2Tc2i
   D3piNJ4GS+KczzNzS0/S9j8XMIYQL/oGdMjRrYUjFbhkA/N+/83HTeozz
   +0OHe30+noZ+JIr/688gwawRf1pwyPB9vgjzBUpj+RqEZbhsZCo0Lgzvh
   yeWNdJ6fnfZ+5a854qZmGlUfS+FfZm7CNX6b+l2i16HM/GNJrSmK6k5to
   /CGjZAEOtmuW2Jo1Yc/PftScFE4v8FMmVgsXH36nfAdUbeVnD19S6a5R3
   w==;
X-CSE-ConnectionGUID: OHc6fKOWT+ut8D2hHVCNNg==
X-CSE-MsgGUID: L1PDfC8TR7C08vTktFWgnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="68502890"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68502890"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 15:51:22 -0700
X-CSE-ConnectionGUID: ovyRC2a8RmmhOFwl1b8yuQ==
X-CSE-MsgGUID: Z1/sbHJVQ8CYUqyQUh16mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165756632"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 15:51:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 15:51:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 15:51:19 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.83)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 15:51:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R28JHWqhigg5gRYMHyTiZmMqfS34VVf/XI0Hz3y/zC8DxA1WoLI61cE/FL9dRRXc2XWWLhsPOLFaoRFoWxYhwqIllSRQ1R54v/F2+HNXScyRNaeBabRLihLgr0ZBXhEVb9V4V5inA0c4PAJNUVqJwBei0OKV/2EIAhElp+DDTmiIjAQMyAekSRKuW9XvFRoTdO12+1ayBvCBGINL3gqlEiPhphp5VO91KwEt3qJCpSWYP6xxeRLZoTjPiNCUNizBMeYfr7677q8Q4/Ja+5GkQEwpspyKiHF6bHJrwBWAD+mEd6snXJrjk4//NKd6rNXJA85uKPY4EYUvIUrefC9M/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPmfP/GnbcU2xDI3nhfz6axLJLHpnSyx3anKBJS0ySk=;
 b=hOs8gxTLbo4srHDNbSVjsAsODUmriY62Iyktd9fKwDCRuqJ8tA3BxWr16XyCKcnH77SRQZkU9p5NEftzRbSEbx3ymatBKYXlrS8S+o1vri+jK3JrJaf5Sb6t9vSRtHE7rEAGPAbhufaTBc1Jd/kLBIO79R1I+WXIE50LudQVuDYSdcs/aFsSoXDGViHOnyYXHPfEiFOwNc037e+20kBneRSFkRwS1ajkzwybCPq3i5h/zhjwRBfyiA7HifR8eC9wT4FwEqaT8VaTY/2e4PdF2/hLSwZsNdylufvZlAVdMp9spYGTT1Ip/aqscO+XpjGWWQSk7FRBTUeW1fy/B3vkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7166.namprd11.prod.outlook.com (2603:10b6:510:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 22:51:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 22:51:17 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 8 Aug 2025 15:51:15 -0700
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Message-ID: <68967f6365895_cff9910017@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250807212716.GA62016@bhelgaas>
References: <20250717183358.1332417-5-dan.j.williams@intel.com>
 <20250807212716.GA62016@bhelgaas>
Subject: Re: [PATCH v4 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:332::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 651971f9-3474-4003-25bb-08ddd6ce157d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDk3eEtvczN3QUZSdHBzbHZ0TUJCWURJeERuUkg2YUhhM0R2VG84YStBYVUy?=
 =?utf-8?B?QVpRcFJyOWNhdzM2bGNMa3dvZGduRFdtcGZSRkwwNlozQjJoaHJPcEdCT2Nm?=
 =?utf-8?B?bVgva3FBZHJuRDlacmZXa3diaGJUMndtZ2MwK2dtbWlGeUQrUU9iV2FWQ3V6?=
 =?utf-8?B?aFhIWlI4d0F6bXkzMnR0d0FHZ2JnWTZZRGRJbkhUdUhxcGNVVkx5aUlSTUgx?=
 =?utf-8?B?bUdBeHJBT05mcWJuVUl5TmNyamVLVlhMWHNscDdIS09yQm9kWUg5T0ZFY1d6?=
 =?utf-8?B?dFVQYlNZRXBkZ05lcHM1Szc3SWFoSDFHSXhoMHgvbmlCODVpOWgxUlFHRnJE?=
 =?utf-8?B?YnFKSUM1c2ZOQzJpSUg4d2lyQTJzbGRtZFF0WDBWWG56YmtNakxmVWtXRlR2?=
 =?utf-8?B?bXl6NkEwcHdGSUtzRFlJSEQrU1ZDZGcyeW1RL1BucGtLYm92NTRuZVpLbHl0?=
 =?utf-8?B?cDkwbUNOQUU5VlNlSWQ4WEpkbjhaSUtlanc1QXV6aDlxMEFWRi9yNi96c0Fu?=
 =?utf-8?B?TE5ScU95RXhBZi9lYUpBb2JuaDlpWE03VENHN3c3MDZuSVZ2MDZnMzF4bXJX?=
 =?utf-8?B?MU9iTDJzWUFoeFp1TEowM0cvWER3NFVWRTFyUGdOaG1NMm9YWk1Wc3Y4ZGhW?=
 =?utf-8?B?RGV5dFZZUVFkR1pUYkg0cktubDNkbmxEU2RzSEVtaEZrTlZtK1BGTGxHbnpu?=
 =?utf-8?B?Q2I5dkNiSHd6MUFPVk81d0FjcWVQcUhKOGdlKzhldkRmWnVzY2g4R1NEVUNl?=
 =?utf-8?B?c1drdGJZdU9QVE0zSC9BK0dZVm9TMW5lL2VZMEl1Q1RpaldHMFVKZG5hNzI4?=
 =?utf-8?B?djZ4UE1ZdUZSeEJ6VnllczVqQUt2TGQ4M0t6b2hyQnBud1cxSjR0dFFheXlP?=
 =?utf-8?B?djBuMzZkb2U3WmNtSVdMUG9LRDFOZmVrNSs0ZmV6OXBGVGIyd1pibVNBb1NN?=
 =?utf-8?B?dUhGZ25PMzRhSHdhdTRvbEttMXdoL1Q3T2FCSEZqanh0Q3l3cUpNS3dwclBI?=
 =?utf-8?B?eXNudlJ5d2tOZWdyL21LUGZqK2dmT0t5SWZnVUptUURwdWxHK0YybVU5ZHJu?=
 =?utf-8?B?NmxLcmIzZTdnQ3hHbk05QVREREUwd3FWaFZCNXE2NkZZcWhxRE8xNVVxOFZr?=
 =?utf-8?B?dG8xV3hmaVBYT2VybmpKbkFRQjZPNG0wY29Dd3lWckhCLys3ajBjZkxRL0dh?=
 =?utf-8?B?VlBTRG9ldkROaVl0dmo3R0lGelkxb0dhYUlBL2pxYnhDL3UyZ2VTbXFUMjNP?=
 =?utf-8?B?Ym9OdVBaclRSRWVxL0dQR0tCOXlHZzhsNHF1Tk1HN2thWSsxSFpoTzZlcDVS?=
 =?utf-8?B?c3hQb09raUgzb09PTURKTUNUdmtyeklKdCtESXVQMC9MQWZKeUEyank5bzE4?=
 =?utf-8?B?c3BtNy92aEV1d2c2anVRbFNKL2ZHYkQ4TXhOS0JpWHVkNlFvVTNWeFR6TmZO?=
 =?utf-8?B?TGFRQzNza2RaaWZjSmw0Rjh1VzFZcm1PanR0bzU3em9pOWVkT1Q3aGIyWlQz?=
 =?utf-8?B?cU51aWVvQ2E3SW9JajVWR0lya2VQUEEwK3o5M1E5eXN0a0FLRUk2WjNrTW1G?=
 =?utf-8?B?YlUvaC9iUENvT2pRUC9OODRXUERLUXhHR281TE5tSE5ROVZOcFBHL3NUdHNN?=
 =?utf-8?B?c2o3OGJmWXBWZTk2TVc2ZlA1bU1aeUhkVFZYMXVXM1dVYVhnMTZwckQ4MElk?=
 =?utf-8?B?dDR5RjlERE1pdjFhSE55UE9pRzJ6ZTlkUzJRTTNINU1pSnM3MG1uT0JRN0Qy?=
 =?utf-8?B?b3FOS0UvNlJiZEF1WXVlby9zYzJZcVhpVGRJV0p1czFKb2NCbWZMMm1hYlg2?=
 =?utf-8?B?VGFHZWRvZisxUDNONVFuY205MmhSSG80alF3d1ozRXFRYlJ1ZFhob0t1MEhZ?=
 =?utf-8?B?OHFlZ0R6WG9wUlF6aGVlZEVRai85Q3JUK2pFcjR2ZjBpMFZDeXh1K2IrNFRl?=
 =?utf-8?Q?YdhDGOaD57M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWVPQ3k2STc3T1FLNGk2VzJLYStLWUJFNnlzeExIRTIrRFlSek1ZMWxsd3VC?=
 =?utf-8?B?NGJUTGw4aTZUSUw0MUg3YWQwS0grZ2EyYXU4OW1BeXVjNHBqVUJFLzlRMm5r?=
 =?utf-8?B?b1VPV00xbFZRKzlFUUplcStaeDNUQlM0ZVZ6djRFZ1g4K01tcndWQkZtcGsx?=
 =?utf-8?B?b3VPMFRxc0wrZ1QwWW9MWlNDWFR6MkJDY2V6RysvNTJKZFdSd0ZaQWRTRiti?=
 =?utf-8?B?K1dCMzRkd0RRQkRWeUEyclJzT0VTYUFHV0d6M0cxenRzQUl6dmFGR0swM0FU?=
 =?utf-8?B?MmtzRElYUHdSb3NHUGVxRHVRQVpjajZUWDFndEY5bS9lQU9ZZzB1WWl3VTUy?=
 =?utf-8?B?SnJCaDFsZWZYV2RWNXlMcm1jWWluNHU1WEx3MHl5SUJkOGVEcGVRUnk1eGlX?=
 =?utf-8?B?blpsWHNQNnhHMWwzRjRTd3Y0dXdCQTlEQ2ZBTDZYNGJZWmZjMTFiT0psS1dW?=
 =?utf-8?B?MDFjSjcxdXJwdmRTZ29Cdno1NFZaa0ZkcUZYbjdYNDFkWDM0eDh2alVwTHpo?=
 =?utf-8?B?b2dFTGIvT0JqNy9QYVdza05ncmlFOFZyU2RaNm1aYWlycG44aUZ4SzVJU3g5?=
 =?utf-8?B?aldGMWZNRlVmRVFCdDRDRnNLb0JvMVY2Y3lybWpaOERkV0l3dFlXYTdmdkMr?=
 =?utf-8?B?cUlGRkJINXFUS0pLTXVwL3pqUkNlNmNDdGd5c3NJSXpUbllKcXpaSzRyTmUz?=
 =?utf-8?B?Y0NReFRjT3AzTFpKSWlRQlJ5RnBiVHNCQ0g0WEtyTlE5TTQ0RHR5VHBQNGd3?=
 =?utf-8?B?L1VnOE5KNHdCTnNKc1NucEx2MXZBT0hiaFhySTVnUU5XV1A0LzRiSjFiMGlF?=
 =?utf-8?B?MDlBM2Rpdjh1RkRhN1FMWk1jL0NiamtKZmFDTUh4Z1JlRWRjSUJONTN2UXRO?=
 =?utf-8?B?dnRDSmswQThHRVA2N3ByZEZSR3FoQVE1UjhuWFdCTFpqdVVoNW8rVlkxS1NO?=
 =?utf-8?B?blRTL0gxbThBdUp3TGFuNi9CZGw3eXhPQTVYa2NHVWc5ZjlaVHVoYVhEVWZo?=
 =?utf-8?B?U2x4M2kvL2VVMHZTYU9HVmlMUjBRd09lYzdFaXBBM1FvK1JCTDNEZ2xWNTZi?=
 =?utf-8?B?RUJMZnNlYmg4TnhIbTNES0NLMVNJNnJWTHNuRkdKQnVKR2MweVVhS3dWejg5?=
 =?utf-8?B?SEtsVzRGNW94elRtVjI3MmdqTWxYZ1lpS2dUY0lOOS96Q3NTTGNScjVvbWl4?=
 =?utf-8?B?NkkrZFptQ2hyS214L0hTSlFnaUt2WENUQ0pvbUFLa1hhOFYvdHAvNS8vN3Nj?=
 =?utf-8?B?Y1dOZzAwZkpBbHRrUlBRM3lwa0Rja2FRbzlSWkpTckdGWWczVzMrYjA2cnll?=
 =?utf-8?B?aXo4MlVTTU5mL3pmK29CVnFtcFc4SWZrWTd5U1F4ZFFzbUNVVVo3bE1PNjYw?=
 =?utf-8?B?OEcrMmd0a0doeDFCTjlSckhETjV4ZCtMMHZtVDV0ZjJ1Wm5YOFVKcHdRN01R?=
 =?utf-8?B?eGVwZjg2VHEvN2VmZDl3ekcyZXVNckhLa1dYd1pLREFrbXNiUjF4RDFyeWF6?=
 =?utf-8?B?OUQ2RWxNMWU1a0ZKaTdmcDhYdkdvSHE1YjBzcDJ3ci9YZzJSRm10Y09PM3BG?=
 =?utf-8?B?V3ZOMGw2VlhidVUxakpDN2hKTk83T05YcjNNYmJtcnVtUXZCa1FvSlZvWklE?=
 =?utf-8?B?cFpMbmxXRFhxUzI3OGZDNjI1SkhFR2dtUnZQNEJaSXJZdFF3WFVMakxyc2NE?=
 =?utf-8?B?ZGR6RlpVcUtWVE5lT1gzdnhtU1RzVkRWblFaTHhGSy9CNlhGbEEwS3phcUZk?=
 =?utf-8?B?ZEJKUnY5NGJMMzlwaVJZUzcwTFZwaGdYQm9XczBGVFZZS3dmS25Fb2hWWERO?=
 =?utf-8?B?cHNqRG9tMTdGRnNSVC9WMHNQTWhnRHJzcnRDN25tS0FWbTRNUDUyRElDZlNx?=
 =?utf-8?B?V09NZDhyU2lHbnZpcEhEeXRmbjUzNlBCa2pIMWR3T3VrUVhJWWtXTTduQ3FP?=
 =?utf-8?B?dUdhWlE1THhRbFFmNU5CWW9VclRQMnRYejA5NHBUTXRHT05zYS9UWUFIWVc1?=
 =?utf-8?B?dGxUWDJEWGZ3OXorTXVzL2lrU2FOV2lvTnJVWC8zTHIxOElUT3NPUENIb2wz?=
 =?utf-8?B?N0p1K0ltSHhSMXo3czdFakRTWGttMExiMGFkSUM1SnFUMzRDK3poVm9qeDZP?=
 =?utf-8?B?OEhhU2tBcUJQcUxkbVk4aXNrQTAwcVFKaGljNDRuYjlLV0tWTUtqdEhRZGlh?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 651971f9-3474-4003-25bb-08ddd6ce157d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 22:51:17.0867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GE/n/pvDIrN5VU/WF+uJZ9r5M4AFyyZ//uwOyJv1irpwux1rByeao000yEu65lyzdAVePxXhXB5eZnQ9OpgxtCRlNldSH6I1g3Ex7+Awmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Thu, Jul 17, 2025 at 11:33:52AM -0700, Dan Williams wrote:
> > The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> > Environment (TEE) Device Interface Security Protocol (TDISP).  This
> > protocol definition builds upon Component Measurement and Authentication
> > (CMA), and link Integrity and Data Encryption (IDE). It adds support for
> > assigning devices (PCI physical or virtual function) to a confidential
> > VM such that the assigned device is enabled to access guest private
> > memory protected by technologies like Intel TDX, AMD SEV-SNP, RISCV
> > COVE, or ARM CCA.
> 
> Previous patches reference PCIe r6.2.  Personally I would change them
> all the citations to r7.0, since that's out now and (I assume)
> includes everything.  I guess you said "introduced in r6.1," which is
> not the same as "introduced in r7.0," but I'm not sure how relevant it
> is to know that very first revision.

Ack, looks like the section numbers have not changed which makes it easier.

> > The operations that can be executed against a PCI device are split into
> > 2 mutually exclusive operation sets, "Link" and "Security" (struct
> 
> s/2/two/  Old skool, but you obviously pay attention to details like
> that :)

I only recently gave up the fight against 2^H^H two spaces after a
period, fixed.

> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > +What:		/sys/bus/pci/devices/.../tsm/
> > +Contact:	linux-coco@lists.linux.dev
> > +Description:
> > +		This directory only appears if a physical device function
> > +		supports authentication (PCIe CMA-SPDM), interface security
> > +		(PCIe TDISP), and is accepted for secure operation by the
> > +		platform TSM driver. This attribute directory appears
> > +		dynamically after the platform TSM driver loads. So, only after
> > +		the /sys/class/tsm/tsm0 device arrives can tools assume that
> > +		devices without a tsm/ attribute directory will never have one,
> > +		before that, the security capabilities of the device relative to
> > +		the platform TSM are unknown. See
> > +		Documentation/ABI/testing/sysfs-class-tsm.
> 
> s/never have one,/never have one;/

yes.

> 
> > +++ b/drivers/pci/tsm.c
> > +#define dev_fmt(fmt) "TSM: " fmt
> 
> Include "PCI" for context?

Sure.

> 
> > + * Provide a read/write lock against the init / exit of pdev tsm
> > + * capabilities and arrival/departure of a tsm instance
> 
> s/tsm/TSM/ in comments.

Got it.

> > +static void pci_tsm_walk_fns(struct pci_dev *pdev,
> > +			     int (*cb)(struct pci_dev *pdev, void *data),
> > +			     void *data)
> > +{
> > +	struct pci_dev *fn;
> > +	int i;
> > +
> > +	/* walk virtual functions */
> > +        for (i = 0; i < pci_num_vf(pdev); i++) {
> > +		fn = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> > +						 pci_iov_virtfn_bus(pdev, i),
> > +						 pci_iov_virtfn_devfn(pdev, i));
> > +		if (call_cb_put(fn, data, cb))
> > +			return;
> > +        }
> > +
> > +	/* walk subordinate physical functions */
> > +	for (i = 1; i < 8; i++) {
> > +		fn = pci_get_slot(pdev->bus,
> > +				  PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> > +		if (call_cb_put(fn, data, cb))
> > +			return;
> > +	}
> > +
> > +	/* walk downstream devices */
> > +        if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM)
> > +                return;
> > +
> > +        if (!is_dsm(pdev))
> > +                return;
> > +
> > +        pci_walk_bus(pdev->subordinate, cb, data);
> 
> What's the difference between all this and just pci_walk_bus() of
> pdev->subordinate?  Are VFs not included in that walk?  Maybe a
> hint here would be useful.

Right, ->subordinate is only managed for actual bridge devices. PFs do
use one or more 'struct pci_bus *' instances for their VFs, but do not
set ->subordinate I assume becuase of that "or more" case. See the NULL
@bridge parameter to pci_add_new_bus() in virtfn_add_bus(). With that
there is no clean way I see to walk all the virtfn buses of a PF, so
fall back to a pci_get_domain_bus_and_slot() walk.

I will add a note to this effect as I had to do some digging here to be
sure.

> > +static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> > +{
> > +	int rc;
> > +	struct pci_tsm_pf0 *tsm_pf0;
> > +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> > +	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(pdev);
> > +
> > +	if (!pci_tsm)
> > +		return -ENXIO;
> > +
> > +	pdev->tsm = pci_tsm;
> > +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> > +
> > +	ACQUIRE(mutex_intr, lock)(&tsm_pf0->lock);
> > +	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
> > +		return rc;
> > +
> > +	rc = ops->connect(pdev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	pdev->tsm = no_free_ptr(pci_tsm);
> > +
> > +	/*
> > +	 * Now that the DSM is established, probe() all the potential
> > +	 * dependent functions. Failure to probe a function is not fatal
> > +	 * to connect(), it just disables subsequent security operations
> > +	 * for that function.
> > +	 */
> > +	pci_tsm_probe_fns(pdev);
> 
> Makes me wonder what happens if a device is hot-added in the
> hierarchy.  I guess nothing.  Is that what we want?  What would be the
> flow if we *did* want to do something?  I guess disconnect and connect
> again?

If a subfunction is found after the 'connect' event, like late enable of
SR-IOV capability, then the resulting pci_device_add() for that should
lookup and perform the ->probe() at that time.

> > + * Find the PCI Device instance that serves as the Device Security
> > + * Manger (DSM) for @pdev. Note that no additional reference is held for
> 
> s/Manger/Manager/

...could have swore I ran checkpatch, but indeed it flags this.

Fixed, along with the others.
 
> > +struct pci_tsm_ops {
> > +	/*
> > +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
> > +	 * @probe: probe device for tsm link operation readiness, setup
> > +	 *	   DSM context
> 
> s/tsm link/TSM link/
> 
> > +	 * struct pci_tsm_security_ops - Manage the security state of the function
> > +	 * @sec_probe: probe device for tsm security operation
> > +	 *	       readiness, setup security context
> 
> s/for tsm/for TSM/
> 
> > + * struct pci_tsm - Core TSM context for a given PCIe endpoint
> > + * @pdev: Back ref to device function, distinguishes type of pci_tsm context
> > + * @dsm: PCI Device Security Manager for link operations on @pdev.
> 
> Extra period at end, unlike others.

Fixed the above.

> 
> > + * @ops: Link Confidentiality or Device Function Security operations
> 
> > +static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
> > +{
> > +	if (!pci_is_pcie(pdev))
> > +		return false;
> > +
> > +	if (pdev->is_virtfn)
> > +		return false;
> > +
> > +	/*
> > +	 * Allow for a Device Security Manager (DSM) associated with function0
> > +	 * of an Endpoint to coordinate TDISP requests for other functions
> > +	 * (physical or virtual) of the device, or allow for an Upstream Port
> > +	 * DSM to accept TDISP requests for switch Downstream Endpoints.
> 
> What exactly is a "switch Downstream Endpoint"?  Do you mean a "Switch
> Downstream Port"?  Or an Endpoint that is downstream of a Switch?

Endpoint that is downstream of a Switch. I will clarify the comment.


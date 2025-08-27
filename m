Return-Path: <linux-pci+bounces-34851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C278B378DA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EEF77B2B37
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B74930DD23;
	Wed, 27 Aug 2025 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMHpIS9y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4830DEA5
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266700; cv=fail; b=OA/+YT5Q/uMEwMYJPa4YTX47/WaZDuQzNFJvI5mXF/6xKYoyGciqDhitrj9nwDfiYh+nCP+2UFKjVwhGCUQal1pCL8FReC8AyhQOIRJqylaCERXNMGiKa5ImXVc3tqVVri1dn7OqLcCiVGPvAu188ol2PihJv7mKNnbw3GZbj9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266700; c=relaxed/simple;
	bh=Draw7+Afd+OgxdTi9YnGnaeDspzRvWY7U4fdiDrIPyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BcQF7qfZgCs9P9Sol16ft8lSNddGWf9kNknb3AVMLkes+9SwMIgqy7blC+VTM7MecYDcWzBCafVfe5iJ1sxwONyy75pOqnRaJeO0IBq26XTlnuyGSFg/WTzt2NvcPE9OwrNttmbOC4/wSvELvph8JKxQ9VsxW7xk2F5JBRU0aUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMHpIS9y; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266698; x=1787802698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Draw7+Afd+OgxdTi9YnGnaeDspzRvWY7U4fdiDrIPyY=;
  b=NMHpIS9yzKKi9M5RZRVMaLpwFx2eyxRwanvDPszKJs2vHUo+qLAIt1Ck
   6VCzJuSDl1EWBKYVIEBlixcRq9I0VE+Lnsl4Bd+duInljSo/tLJZMfbpW
   ZHw12X/kr5L1v9kHe2G1OqMkXSgGaj59Hu3xWfYsnPGPUWdo4iX1VTWkk
   1NWURSXkyCccO/ZEky1UClec1Q2SIYu8f7iMM4xK+1P8Jbhrs34YG2JMq
   +4OQA7HMhidADBUA9UQbCiaJRXcqHHBJN6bBgP3SecClH4hCIAkohRgKg
   oA6YNVtjFK+4Wl8Mh4Bxo7j6rvV9udpRsGqSLclGkB1eCT0v39TPjr9E6
   w==;
X-CSE-ConnectionGUID: 2L5aC+LCT6SIfVDeTTbMPw==
X-CSE-MsgGUID: lj1DjEjSToGRpuD7ugIYYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62159143"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62159143"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:38 -0700
X-CSE-ConnectionGUID: Z+EgKVOnTteUZbplY6dJVw==
X-CSE-MsgGUID: opij3KNVTyG4bhcz2jwLBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169685113"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:51:37 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.72)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbL5GI/J0DwZBYHcDgOlh7Acy1Nw/UCyUmVrEoSZ1dD1N/XnFHiwYIgi8BW2fNFJmYrwGFVk99/YrLMdQk0SLWpzXlIajRhO7TxYGRZRJAsVAIGvoCWEOgXlCa1vSVwBuJ5d3Vf0qGHsSV9+T5vkFVbri2eiUCB73k/tFvz1UPMPXKgoT8EA+402icKlEw6NSSoYnZFOe873NrubMg4oypBEeDgWKF/sRJEvLh6Ar5bzSVWDoQPqemloYLjKMBZYMa6UyhrtXNOoGWTtSNAsfVpetEx4oyJafhO2o+7DW6QVp9P0QaNjrUfEvMfUO0bwgO+cE10ndiHD9AZ/QOuQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZioefYmX4w4/v/d9Fz7UmHzBiqdL+2VqPu51k7aP4fc=;
 b=X/iWTTBipCdv8QyB9CoFJtdjHiFvJDTpHwFRtJOEQ/DhEXRtWOiRqh2GBqmh9O4SSuJt1RKL3qrUjWoYyqZxS4fOeykbi+66UYaxxfE2Y8zwIFWhtZddprQIuFzOOZdkM6BO2/TKdsciz44Te2r7O3voFORkU0957Y7ZVGdIMQivGW6/uthphYAg8ssaOQZwmmRJ4mK3XLy5bq130UCzIUQuHTbHJtAYiY4hYe9qjq5AAadHzrTv3iznhCQI6sKfCjXc3V/+/2aGiz7rYSiLIpd/dDYvVEu0/3Zel4h79Hzm3n66gWa8hT+EMm3NuZahFWYP29dYCtveH3dU2YTtRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 03:51:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:51:34 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Samuel Ortiz <sameo@rivosinc.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>
Subject: [PATCH v5 06/10] PCI: Add PCIe Device 3 Extended Capability enumeration
Date: Tue, 26 Aug 2025 20:51:22 -0700
Message-ID: <20250827035126.1356683-7-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827035126.1356683-1-dan.j.williams@intel.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:907:1::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa2cc32-f9b1-4c33-f72b-08dde51d0413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUNpdUZyRFBNY0lya0lxanNmNmFEd2FLbkxUZysxMWl1MnJFT2lHdUZ6emUx?=
 =?utf-8?B?OGI4eVlBcUErTnM5UnhEQmdwejcvWGZKVVBOdm9tQmVZV0hjSTJrcFJHS1pQ?=
 =?utf-8?B?UDJkeHN4OVRFVCtZWm1hVXljcWd1SmhlSHhtL2ZVUW0zNXpQYnZVNUdJRFVJ?=
 =?utf-8?B?ckx5MllidE1FSlpPZVJrcGM1OTE1aFBzRU1ObGk4R01FVFV6R1VOYll5Ly9x?=
 =?utf-8?B?aXZ4K3VZczhJUXNaaXdIUDcxK3RacTc2Sm11SUVKWHU0TkFQcGsrZUw4NURG?=
 =?utf-8?B?Rzc0Z2Z2NGtGc1NvZXRyK3QxTXdCZGpXb2d6WDQ1VjEvdlJxdytBQnBWbVhS?=
 =?utf-8?B?RmNTeGswdGR1RGNEY2VPdVdublFyVjZMSGVzVW9qTnh4cUd4M29FVFROZE1S?=
 =?utf-8?B?Si85blZpdldnenNrL1FWMnk2eTZVcm1nS0ptZnJYam4zeWVnN25NQW1BMGgx?=
 =?utf-8?B?OFVuVU9LWEtpbnFrTnBodEErWkJ1a0hZdmNwMVlCL0x1d0I5Nlo2TGVRZlcx?=
 =?utf-8?B?NmMvMi9ONGduY2dMUXJSc3c5RE1ra01RSktseFBOTkxLVVFVVk41SUN4eDlM?=
 =?utf-8?B?TUJYZVpEMDJKdmgzc3c3aXp3TkRqSisxZDFxRUlUT2Jhc1h0RS9oZWZXOHBl?=
 =?utf-8?B?aEFMRU9VL1ZDN29aa0trNVdEQTRUcTB2VXg1MjU3aXlsSXBwQkJzVVZmelc3?=
 =?utf-8?B?alZLRUc1N1krN2NXVTdJVWgrOGtzaUNtSWRmaHVtYjJCY1RlZDdCalQyNWRX?=
 =?utf-8?B?TDhUbjBpTDROMENYV29sZWExNjlhMXkySmNFT09haDNEMllBbjE3UDZ0N1lB?=
 =?utf-8?B?SmNSSi96TzVJSVh0UzlXRHVqWmVIYWRUV3lwajlXVkhoQTZtaG1HWnN2czVz?=
 =?utf-8?B?SzFNa2FkNm5FRjZ6SzdqZTVMNnN4dTFHdWNsU0dCY2JiS3RoQ1I0cVBFQXpL?=
 =?utf-8?B?TE9KbGxMVHpPb2FOOVlqYXUzYU95OGZNajR6cDI3UEdLdHl2SWwrSC9wZXFO?=
 =?utf-8?B?a0p0eXdOeGRqNWtTdjN1akJHSm5VVGpUdlRSajFZRkdveHdDT2d1WVp3VlhO?=
 =?utf-8?B?N0ROcmZERGoyamovK2NTdkVaT1NIRW83My83WHBuKzJEMEZyTzREMUgreGxE?=
 =?utf-8?B?bFBuNmNLZjRVWmdDNHFFU2FXQ3YrMUxiZ0VsM0hyci9XMFU2ZFhUaCtIaHJN?=
 =?utf-8?B?cHM3OXN0WFdFN1pDZGdYeWozLzdvNTFLczhVVVhkaGVMQzZIY292TFJtQWVK?=
 =?utf-8?B?RGM5djl1MXVsTkFWYTBFMHlGK0lMcnNJRE41SXFsbXdpbmFZVjBEL3pGOWVR?=
 =?utf-8?B?c2lxOTcyc0ZIRlhBQ1IwTHRrQzc3QTR0RnQyQUpveDcvbG93bkZCVlZtM2Ja?=
 =?utf-8?B?L0t5QnhHaUc1aWJqUHhiM0FKSFc1WTlteTU4aVp4UGJ1ODc5NERTNXdWb2tM?=
 =?utf-8?B?TUE3TXovdWp6aFV6UnNjNHZob0Z2NjJ1cGUrSU1pbTQ5aU5LK3pJVlJoTkdi?=
 =?utf-8?B?cmdCNjJCTmE0eEptRUJPNElqakRjM0luMUtER1l3VWZ1dzNFajg2Q0Jlc0VN?=
 =?utf-8?B?NXY3QmVpSHlzNkVscCt6TllvVXduVlYydkx5bm8wNi9QRFlZUkpuT2VKZWs0?=
 =?utf-8?B?V2FnK1N3dG9pU1RaRHJRbllieHBzd2RyUDV5YXRUN211TTVTaVRldEp6Q2sz?=
 =?utf-8?B?TlhYam9ZbklISDdwN2ZmUDd4d2phVGhUMlZ5SGlieElHcFlCejU0cXZoblJn?=
 =?utf-8?B?Q0QrRFRydkw3aXF6dml3NTlMd2F6eDdsald1T2ZmN3k1L2t0bzFTYW04Ykw2?=
 =?utf-8?B?ckRBc0xOcThGYmZWajA0cmFMS2M3cnVKaFdwTlBXUmRNWkgvck16YnBYSmho?=
 =?utf-8?B?NHJSeDZDOFJkbTEyTkRvL0NDa2hRZVBFTkpuQnZneFkzVEtjVDBzRmxpN2pF?=
 =?utf-8?Q?un81Je+gfAw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0FTclNQV051am1UT3dUZWlzSXdiYVdrWXp2dHBjdFA4VHJBTGVyWUhiUmFw?=
 =?utf-8?B?Mi9qS1hDYnFZM3lEK3JuWG9hYU1qTXdXeHlabk1LYllTd2hxTXF6TmRrVW1r?=
 =?utf-8?B?dW51WHExZGVYVCt4MkRoYUx0NDZiZjQ2N2hzc0ZKeWtWWWdqcmZRSFZQanBM?=
 =?utf-8?B?bWxWNHV1cm0zT1NUNmJCcWZ3eUpQQnNZUUdqdUZKWWdQVzJiZGFydGhzVlVI?=
 =?utf-8?B?cC9nWDNSY1I2L05PYmdwOXlVc0o4T3lpNGdBQkExQjlENDZXNjV6U3RBZWpn?=
 =?utf-8?B?QnBRUjBqMmpXeE0vWkVsaHVVM05TVllraU5Zb0w0TkpKNitxbTVsZWRwYzIy?=
 =?utf-8?B?N1VFMGMyMHdOYXkycW9KKzBPSVhacE5ZU0VRbklmZ0pra1hZaSs0MTFwLzh3?=
 =?utf-8?B?YThZVUlnM3pyRFFBbGhDN3BHZ2dUNU9XSzIvUHhpMVdlY0JLcDFObWd6OGgz?=
 =?utf-8?B?VXkrOHZHeENsNXVtNU93bWVDYU1wUkt1eGQvTDZmUnk4R1RQT1ZHeU01Nysz?=
 =?utf-8?B?c0l2cTFaODhicFhJdHpIU3M1ZjZ1UW43VXJLVGZ6RmdvampPR21HcWtlVWRK?=
 =?utf-8?B?eXVvZFVMOWdjRG5wZ0psTThrWnZ4bnBRWHlaM21VSWlhZGV5Y3hkL2h4R0Fi?=
 =?utf-8?B?UW45SUI3d0VoU1ljNW1aQUZ4NWt3RStLZmZOVmU0VXZhd3FYa0VkU0E2SmFH?=
 =?utf-8?B?dCtjSCtzZEVMSHgyMlJGVDNoRTNrdVFRblV4NXV0cG1jYnNhbzAyb0xWcjgr?=
 =?utf-8?B?ek05NjluRVF1WlF1eFFEU3dMb3M0emovMC8vaENrYlpmOEVqckxkb2srQWkz?=
 =?utf-8?B?VGNRd2p3ZlB2YWtYYi85MlRtNWhBTGZQdlRRSlJtSUZubEs0YTVwdnliYjgr?=
 =?utf-8?B?OVNwTzFleWZwVkdZenh3NDJocW0zUVRUOGRlNzF2VGt4ajlTZksreUxER0hr?=
 =?utf-8?B?aWJTczI3VE5KZFU2cmRiWVF2OHJTdDQ5NHhnNTFrWkgvWHBUTVljdmwvOW8z?=
 =?utf-8?B?bGd4SkxUdVhaTEk0NEttYlRONEhnd0YzMmNuOGVPeFMvYVV3STJqZjhrRnUr?=
 =?utf-8?B?RWhxWGdvL3cyK1NLNG5mUk5SK3AraEJSemwvWVJQQWljMUxobXpYZVd6YnFK?=
 =?utf-8?B?L0I4YkFuWVZmUys3UUZPK0l3VnVwQWkrdHB2TFJjZ3NpeStVOUMvQ2RsbG0x?=
 =?utf-8?B?RHB5QWhEdHFQNG5OZ05GMWh0RTFtdVNCRHI4VVlZVU15bGQ0RGdET1gzVG5Z?=
 =?utf-8?B?RTdDS0lWOFdkbWJuMGJIWUt6WVZIdUlDZDRCOVRDeXY4OXE4NUFZc09YMEV0?=
 =?utf-8?B?WmpuYk1zM3dMYTlNbEZPTzNFMk9VWGU4S0k1N3hQYTkreVpzRXMrVlM1alJ6?=
 =?utf-8?B?YlE5SHYzRDVZdEdwQlJXOVZFYldpSGo5MVoreDBLd1gvaUFlQUhIVThKakNt?=
 =?utf-8?B?aEVOZTM2WXlPMnJ0bVcrMjd0RzVnbGJ3eGVtUUtUbFEzd2xkWjFETDZuSFN2?=
 =?utf-8?B?aDhzWUVrNFpodTI3MWxBbjFkb0tGeGNBOHlNTHUrNXNoVWZseW04b1BwbVZY?=
 =?utf-8?B?Z2hUN3NpSmk2ZTFFN0dwYUpha1k1YkNPa2E1VDF2bWVoUFZoNHRnNWNJZzFP?=
 =?utf-8?B?azdBTWdoSDBUT3VUL0FFeDNORDVkdHRkUVQ4aFYxNVIwR3FpakluSEhpYWtW?=
 =?utf-8?B?aWlZK3RHU1d0dDNqTVk0VnlPN0NReHBJOUFsMFlVSmtob2lQSXdtRE1abFJV?=
 =?utf-8?B?WURBQVNZNFk5K3dLL000aDBMS1JYNllOVGhsYnZVYnZIckY1OHZHd1RrS0Jj?=
 =?utf-8?B?MkZ4RkttRmxOOWlGcTdDTkdHVTMxbVd1ZXlWRlY2NWNqL3FWWkdNaXc5bzBI?=
 =?utf-8?B?S0ZlMGtkMEkycy9zVk53ejJkWDBobzZLemZhZWUwYVpydFhaL0dwTE55RE1G?=
 =?utf-8?B?UUtyb3BuZ3NyVFUvaDN1eHVpMkJrNFZWaFpXQzVsNlh6T0tGcXpxeGtIMk9Z?=
 =?utf-8?B?UTB0UHNjZ0M1dFZVeFZZOS9NVkkxYUEwdXhtMWQvbFdpQlkzRFNOVjA1K0lR?=
 =?utf-8?B?SjZsUTQyVnNhMWtvaG1aQ1VleUFVUzBJMjVjOE1PS0w2WEJmVCt6eHQrbGxw?=
 =?utf-8?B?aDBsMFp2TVdtN25veDZXMGJvamkzbTlzNDZvTy9wSkcwSXR1bmVMQzgydkVw?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa2cc32-f9b1-4c33-f72b-08dde51d0413
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:51:34.3384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Za57NVqephWYbxLxFKo8+yCwUtRUDuLcEUi/s2Vd3H8d8xUXsM1ovTt96nT+P0w238jKFBN69A5JV9/Dyg3xX9iwaNvvBDPFMSMwUX/KN7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

PCIe r7.0 Section 7.7.9 Device 3 Extended Capability Structure, defines the
canonical location for determining the Flit Mode of a device. This status
is a dependency for PCIe IDE enabling. Add a new fm_enabled flag to 'struct
pci_dev'.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/probe.c           | 12 ++++++++++++
 include/linux/pci.h           |  1 +
 include/uapi/linux/pci_regs.h |  7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7207f9a76a3e..6e308199001c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2271,6 +2271,17 @@ int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 	return 0;
 }
 
+static void pci_dev3_init(struct pci_dev *pdev)
+{
+	u16 cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DEV3);
+	u32 val = 0;
+
+	if (!cap)
+		return;
+	pci_read_config_dword(pdev, cap + PCI_DEV3_STA, &val);
+	pdev->fm_enabled = !!(val & PCI_DEV3_STA_SEGMENT);
+}
+
 /**
  * pcie_relaxed_ordering_enabled - Probe for PCIe relaxed ordering enable
  * @dev: PCI device to query
@@ -2642,6 +2653,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_doe_init(dev);		/* Data Object Exchange */
 	pci_tph_init(dev);		/* TLP Processing Hints */
 	pci_rebar_init(dev);		/* Resizable BAR */
+	pci_dev3_init(dev);		/* Device 3 capabilities */
 	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
 
 	pcie_report_downtraining(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 78c1e208d441..d3880a4f175e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -449,6 +449,7 @@ struct pci_dev {
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
 	unsigned int	tph_enabled:1;		/* TLP Processing Hints */
+	unsigned int	fm_enabled:1;		/* Flit Mode (segment captured) */
 	unsigned int	is_managed:1;		/* Managed via devres */
 	unsigned int	is_msi_managed:1;	/* MSI release via devres installed */
 	unsigned int	needs_freset:1;		/* Requires fundamental reset */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 4a32387c3c4a..ad99ecdc8ac5 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -752,6 +752,7 @@
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
+#define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
 #define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
 #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
@@ -1236,6 +1237,12 @@
 /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
 
+/* Device 3 Extended Capability */
+#define PCI_DEV3_CAP		0x04	/* Device 3 Capabilities Register */
+#define PCI_DEV3_CTL		0x08	/* Device 3 Control Register */
+#define PCI_DEV3_STA		0x0c	/* Device 3 Status Register */
+#define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */
+
 /* Compute Express Link (CXL r3.1, sec 8.1.5) */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
-- 
2.50.1



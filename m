Return-Path: <linux-pci+bounces-27823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A18AB959A
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C93FA03B9B
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 05:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2C5221F04;
	Fri, 16 May 2025 05:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWE4gLwk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1B62206B7
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 05:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374473; cv=fail; b=OJh7wR1kVdtV1gvM3LKCT+GSFAHrmcJBnmNsn2ybpd73gR/iHspEEsTZ+bAnGUen9VLyIrpLC1au4dc6y5Aa4hGzORG3ulI/gLO2VCWkePC1BREB2+zh8JHtFIiEUHYfcep2N/+xpourSm0nBrrZOuBUlh7oUMNmBy71K5w0T+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374473; c=relaxed/simple;
	bh=jjcsJVBlartGtfRjp/SZjmBdLZnzhqYRwyP/oQrVo8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WGN0R0CDNueg9YYIYjT/KQ3GGJWv19hu3qzU1CxJIjXMSB13Pgiz1jx4Zntd7QS/eYWced35idYufIHNSJt1ALmg5f4jRadRTVTb337LgrSef/Zty3OJxDqQ065dwKmsjWP72stBuLjevt/68ybM3BZh1JYVMAa4MzrpwUA+i+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWE4gLwk; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747374471; x=1778910471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jjcsJVBlartGtfRjp/SZjmBdLZnzhqYRwyP/oQrVo8U=;
  b=IWE4gLwkk3a+muO4R6wDYwFsG8JzqA9JA9Tvdg1k9EFWpw4Nv4qsDwPs
   WjT44Qh2x2ObjrPZAZLMm5eYneQ5R0np/vz9ZL1GjRSC/bd2dHbA23A+t
   czNNuGUNQH8n0vNthU7eq5aEjrW3LJxZya4bXPAvZUehlhdi7cKSQpdlU
   Jil4Reyh7+jXWco3iyuWJQbTcDZk0799v/3VWhRooyn3uiMDKoRoP118m
   trbRgvgIS8EHRX67/BzBB4q6FVgEd4gqHB+8GF93jSYXAGC5PUUa2wnF6
   M0TdZUcIdHaQpFolqiP0zM9h+qMqImW/0TU+0KAvQjLTVsReMx56fBKzW
   A==;
X-CSE-ConnectionGUID: u93U06IxTKq+D0UXRglmIA==
X-CSE-MsgGUID: 55sEq6b2QT2I/46y9ezg1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36952774"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="36952774"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:47:50 -0700
X-CSE-ConnectionGUID: 4xehCHZtQdKB+TH+uYtzrA==
X-CSE-MsgGUID: +mf+acKRSQ2DCJ0iLeu3Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="169654634"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:47:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 22:47:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 22:47:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 22:47:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ua7uJT7i9rdfPcK5J8uf8zq1A6+pEF8wDuUVP16baUknBMP2I92vcXgrSIPu/WcdzVCX4KkswHlTrjUut/5NoiVtn6hagZJuj+oGDcoM0BBK8fRNsfIxvOFZauq9ljEymFZM3R/CMXvPakntoiwIWPpbHTflZrUWOheGKC4xACdTj2zayo0XCBWsoclTpzk3ZT0Jcxv7OYVQuws0Jm9JPSrmZEUs2YO31Sh3Q8ipCIjUy18BLAEpJFgBiBRvy/dGYz3Q+vojet9vkmzAqHiM+u4HLgCycAHdpank/4ej4R0M2hzFyPPVn9Yn432tCyXezOaYurbSHXhevF9WpIlrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qmajn4kLoXhIEwWjN+6HKT0+REt8VFVnICzZQkznjk=;
 b=rBEKpxAy12ODhg5CwJ6BGNwKekT2TyqHVAp+UpMtm6In698nyKHr9vOxcjJdAMlvzvJp5iG87XJZGKNpwjro3oINtsHpIlqBOhufSmhyk+8SEyJ0bTbtkm5s/kyocLtLoEKzH9OwPTGaRgzAfIfMI3Xs/RpwI2CwH2gZpjYsl2X9y7uOftdjMcKgvaEASM1mmOvEnFzdg8/EvKVxRae4N/K2RGz3/KIm6U0Ar+ozJbt6jXQZDXK9atldfR4jjLBzappVup6TitEqGnVwRLDh0iltvsUv+gB4mBd/k8rBgqJK9QRNcN19S+mzAMF0AQNuU9H7I4JulxKqbfi9xqUYEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 05:47:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 05:47:44 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v3 07/13] PCI: Add PCIe Device 3 Extended Capability enumeration
Date: Thu, 15 May 2025 22:47:26 -0700
Message-ID: <20250516054732.2055093-8-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516054732.2055093-1-dan.j.williams@intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0098.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::39) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f32540-f112-4e76-5f8f-08dd943d2df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0FtS1NhVDRiN01xMXh2OXQyT2pMMG1nRTFDSnpWdWxuaUVhNis1Q2J2YVB5?=
 =?utf-8?B?R2FCYmJCZzZqcnhBcC8ySE5MMk9zcXZJVm5ONU1oZnoxKzYvc3Erb1lLTXpV?=
 =?utf-8?B?VlVrOVhZbGFyNVJMbThFZUcyajM4SW90VHhSKzhZVXV2RXVBajVlWE04VVJU?=
 =?utf-8?B?QlMvNjBNRWs2OHZXM2VBQXNuM1orVTNKZXg3TW9xUGk5dzczK2FlMksxWEt2?=
 =?utf-8?B?VHFQeHFNbFJ4d2huUnY2Mi9XekpVSGZXMGxodjdaS05tbzc4bWdCaUVnSUg4?=
 =?utf-8?B?ZFpKU2QwOXg5OXN0dUllcDZsMmd1elJQbHk3V1hzK3lkV2RCM08xVGg1ZHRa?=
 =?utf-8?B?SVN0NkdNa05ORFpHTnYxNzU3R0FHOTFTWWZhVGUrUGdGNUJDTmNFdmRqUWFZ?=
 =?utf-8?B?M2lpb0RhcHJucjFCMGZvby8wTFhaeGVqdVgzTVp6dk9MNWFVb2pnWnBreTk1?=
 =?utf-8?B?bHkra0RuLzdoM1kwcWdXeGtud0FzcUpSc3BCaUE0VlhpT011NkZLRTc5dko0?=
 =?utf-8?B?Tk96WXVCeUpqeGVSa2FpR1VOeUhMVzdTQTZjZ2JTV1NDY25OR1lvemtUMnZz?=
 =?utf-8?B?U1FDRkxJSzVmdWNnV0VvbXlPcjhsZGwrYUNuL1NXbEV3TWpYT3ljODRKdUlE?=
 =?utf-8?B?SmF2QU5wa0VCNUo5M1RWNXN4SFFQTDJtM1VNeHIwNTgyZ2N6SyttQm4zbkhD?=
 =?utf-8?B?dkFHZzNNWkxzSWMvUmRmSG1WeStISjJWNlF3dWVud3lrMTFVZ0ExYTM0NGNO?=
 =?utf-8?B?T2EycTAvNVJRWG8yN2Fla085RWhBMVFtZ1dYRFMxWEY3OVM3WTZINFdzbXhP?=
 =?utf-8?B?dVpuSEVPMENTaTlYT0tibVA2bHBsOEJyWHVqbVpnNkxwTFoxZHptL2RvTGoz?=
 =?utf-8?B?RzRCWDFEQVVJek1RNGNuZUdLa2ZJTDQxaXhzSVpta2RHbUxuN0N0azlRMGNo?=
 =?utf-8?B?OTlkdWFhZFFHTzVhUXNGd2kvMlkrUHcrVS91LzZkNHRFVno3Y3I0WTZsQzhN?=
 =?utf-8?B?eDBvN1BtRDBtaFhhbERhSHJaZEZXWUYyWGw2dGNFSmdycWRkdUJ4VEJMd2VW?=
 =?utf-8?B?djVFR2lnby9lV2pFV285RDJTZkFqVmJiWHVOMzl2QmdqVHRLNm8vMk1FVU9F?=
 =?utf-8?B?RE1ESDV4enVlVXgyK2xQdk1QaVByNWdNMXpJQ0l5VGxxOVp2ZVZHbzFiVS9r?=
 =?utf-8?B?ZXlQT3VBTU9NS3FMOTRnUGdVdVVsMzZyQ2RrNDY2SzczNU5NMVpUbFVVK05l?=
 =?utf-8?B?YVVVM0lqUDVMbVlDc3hKRFQ4anBPSXVVMVU5a29YRW4wcTRwVEN1dFc1dXFM?=
 =?utf-8?B?NWVjazk3WHpyY3VSYkJqY1lNSU81cWgwYnhwbjZKQ3FEaHVsZmNRWElNNHd2?=
 =?utf-8?B?S0xNbFNSSHpNY2ZTM05GSEREUnVkbEp2dmJaWEM5VkhLR0l6T0NGSGluSzZ2?=
 =?utf-8?B?WVFIV29KVkkvQTdTN1JPRGlwU0dMVmw5SzlEY2FmWXQ4blRGUnQ0K1lxZWsr?=
 =?utf-8?B?bWtiS1RiUk4xT2p3bmU1WWRKengydSttcEovVEFTU05zV0xvL0RQdnUyQjgr?=
 =?utf-8?B?eVlQTERQYjZxdGx6a2gxcG9MTXF3RDd0K3VvRmwvMW1Vd0lLcFhweVFJMXBR?=
 =?utf-8?B?NjEwaEJuVUpjNGE5ZS8xb0ljcjRud1Z4TTBRam5ZU3k1ak92STB6cmtXdUIy?=
 =?utf-8?B?a2dSZWVKZFVzdkNGa2NqS2gxVTVER0xNcHR1ZjRSSEVMQlJCMDNOWEVQcnNz?=
 =?utf-8?B?UCtVckpLMGQxc3l0R2JsNDhTY09WaGF1aWlocEpKMmdUdEV3amdQVm9LbEV4?=
 =?utf-8?B?OHdIdjNLWjRoblNGQ3lGU0JUak9sZ1d6aU1zZGd1YStCaXBvTEd1SW5FcWtR?=
 =?utf-8?B?Y2gxOW90NDIvb2ViSC8xVXJJRFhzOVphYk9URzFiZXd2ZGEzU2RleVVaUE5O?=
 =?utf-8?Q?3yKZ7o0DXVk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEx6aG9UZnEvZVI1V1pZWjliMkFaVjdLVnQ5aWlwdkM3WVBnM0hFTHdSVnRX?=
 =?utf-8?B?U2Nsa0w2NXJnZSt3VElnUXRyZ0tsbWFuL0Q2eUVCU1dPUnNCMkR3SXQrMnI4?=
 =?utf-8?B?b1crSUJHTFpLL3hGSE9scnhFNDFGUm14UVNzTjI2dFJWRklseE5ZNW5VTHpr?=
 =?utf-8?B?clJyQWt5OGdNVm1ZZC9yd2Z0djdnaWp6UjAvNmw1ejF1aFFIQkRLYWs4SzBv?=
 =?utf-8?B?UUQ0cDBoNzFJMGp1eUEzTDRYdnpPYkZsU3p6ZlhCRTdUOFJyRURLMGFZOGJr?=
 =?utf-8?B?cXVJRG16a21OejlnOHRJWjJsSHluRmhKbXpGQWE4T1JoQU9GS0lPSTBNa2Rl?=
 =?utf-8?B?SWRRbUJ3WnAwSEVWZ1lpRkVrWGFNU1JRRVRJcCsvNVRzaklWQ3RTdVdXbnQr?=
 =?utf-8?B?Y0xrZGFGLzNFampKWVQzYlRFWTIwM3ZYSVZzZ0R1bklKZy95NmFvakc1eWVS?=
 =?utf-8?B?VkRUbXZZM21WdGpSNitSOTVYNkdmdC8vZjBlV0J5TitCUE5pckdTaG5EMm5J?=
 =?utf-8?B?THFiM1ZsbysydStaQ3FhZVU2dUdvMitPTU53LzVoWjh0bU41MXhOeURIVGJw?=
 =?utf-8?B?Tnc1SDA5eS9QVHlJZjJYV3pQdGtIaTg2ZmJldWIzNmxtR1NYWlRweGM2VkFj?=
 =?utf-8?B?Ujk2dlhUcWJHZFdCR2NuS0FpaDM5S25GNUhXUEwvdHlmR2F1citzcFFoamp3?=
 =?utf-8?B?N0cyNERXVXNyNnc5bVdOQ05Ddk40NEk1ZTN5YURUUXNSQjdWMHNCSDZGdFhu?=
 =?utf-8?B?QU5jQ0hYNm5OamVjTkVXOUpaMFRFQnVDV2JNdGVWYnVSU2tTR3BDNVJDQnF6?=
 =?utf-8?B?VjBzVkxyeDVwK2RLcGlraUtKSXY4N3hrTEZLN2R5NkYxWmFVdDNmQUhGcVNj?=
 =?utf-8?B?SnVBVWs5U1czRkh6b1NmM09lVlFCR2xmbXFQRlUyVFJ1cEZPQVZYS05FMjFm?=
 =?utf-8?B?WmJCOU1WdTlUZ3h3eXdLVGpzU09KNlVTbjJ5NmpuU21LQ3NIVkNpcytjc3NJ?=
 =?utf-8?B?aDB4MEFDcmFhQXh2Y1AxYXNQZjNUdXU4T3VGWS9ONHVPMW9FZkFPNndxMUtn?=
 =?utf-8?B?ak1nd3hLU3ljVndsY0ljSDI5QVFGLzBKYnE2ZDBkNkJZekgrT0VhYkVmVTc0?=
 =?utf-8?B?ZFQxS0h3TXFFY0hFZWhqNjQ5Z2R2ZDBtSmk1Nng5KzlGYnh1bUxMUTlMcWFa?=
 =?utf-8?B?WlZoamYwUE9QTjJVd2JmbDFWd2pZY2RLSC9KeUdJTjQ2N2xZV2RIUmE1ZDdD?=
 =?utf-8?B?clQxWFBoc3A5c25QRWtDK0hYWXJGdDBzdFBhM3gvTmlPQU43SDB3djAvNGw3?=
 =?utf-8?B?Y0VFQVJVNDJNZWpobDQ5ejJPamQ5Zmt0ZlJXTFIrcmptenRVVVlGL3Jhbk5U?=
 =?utf-8?B?bzZ1SkhIWGJvQU1oaGx3cDc4RW5JczhlRlNLVVhZa3FUZk1oRWZENUFSK3Z5?=
 =?utf-8?B?b1l0VTZLUlV5dXhIYWIwVUx5d0xiZ0xYY0VJaVdRQVNiczRyMmtZWngyQStH?=
 =?utf-8?B?QkVOS0xNTWdsRjUxa1FKb3FJWUlQUm9EY2V2MG44V3Q0UEhwdk9GR1F0WnBa?=
 =?utf-8?B?b25WanBWUHlQQ2lSZ1RZYVBkcDlqQlBMY2VhWjhkWkpuWFRjWHZCbzB5RndJ?=
 =?utf-8?B?a3VtVWVaZEl6VGtwQ3cyMlZPckhHOThEbjIrdW01enUxeThLd2ZQbVJYeWhQ?=
 =?utf-8?B?RERjWEtibDc0NmJ4TWNuZ0RzZVJUN3ZKcG5lZ1VCSzh4aHJxaER5UnY2WEs5?=
 =?utf-8?B?WThackNYc0NDRGpnOUxGTlRzM2N6WENweE00eEpNL1Y4cVQ5QTVyU2lRQUwv?=
 =?utf-8?B?QzBqek43a3dtdFhnWktPUitsem50NjVGYW1MMnVEYjVweFhnK05IVXhVTGgx?=
 =?utf-8?B?OTRNWFVnVVRpUXM3bDVPaWtnbXUva244RkswWndhS2hML2RQajF4LzVMbmlU?=
 =?utf-8?B?aXZrcC91V0VRNTJpQ1hLUmZ0YlJqMzBtSElJQ2w4RHJWbklGNFZMZlYzZUt3?=
 =?utf-8?B?R0xBeEIvckFqRS80YW1saWVWVkNDeG1wekZyVnJtV1ZCT1dBVHNDZG9MTUg5?=
 =?utf-8?B?Q0FGL0FtRTRrc21FcGgwOGhlb2oxQUh6K2N0YlBpL2FDWXRGUS8rWlVqNEtz?=
 =?utf-8?B?YXhYV01ReUkrRUJ0Y3BQSitTSEFVTWk0d2drbHVPY0VTVlZIaUdpSFovVnNQ?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f32540-f112-4e76-5f8f-08dd943d2df1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:47:44.2651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoMwmvD0mePX/PyzowoVICnF5eJO2qdhXqjBMaQwIr3Dt26qrbYvZqzjfg1ys2du2NTWcitzwan4uw3cpsfJRbpAZaWYXrNfelez3kKeVzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
X-OriginatorOrg: intel.com

PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
enumerates new link capabilities and status added for Gen 6 devices. One
of the link details enumerated in that register block is the "Segment
Captured" status in the Device Status 3 register. That status is
relevant for enabling IDE (Integrity & Data Encryption) whereby
Selective IDE streams can be limited to a given Requester ID range
within a given segment.

If a device has captured its Segment value then it knows that PCIe Flit
Mode is enabled via all links in the path that a configuration write
traversed. IDE establishment requires that "Segment Base" in
IDE RID Association Register 2 (PCIe 6.2 Section 7.9.26.5.4.2) be
programmed if the RID association mechanism is in effect.

When / if IDE + Flit Mode capable devices arrive, the PCI core needs to
setup the segment base when using the RID association facility, but no
known deployments today depend on this.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/probe.c           | 12 ++++++++++++
 include/linux/pci.h           |  1 +
 include/uapi/linux/pci_regs.h |  7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e4a7bb8b415f..56704e851224 100644
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
@@ -2625,6 +2636,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_doe_init(dev);		/* Data Object Exchange */
 	pci_tph_init(dev);		/* TLP Processing Hints */
 	pci_rebar_init(dev);		/* Resizable BAR */
+	pci_dev3_init(dev);		/* Device 3 capabilities */
 	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
 	pci_tsm_init(dev);		/* TEE Security Manager connection */
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8962bf133316..d8dd315d8b4c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -444,6 +444,7 @@ struct pci_dev {
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
 	unsigned int	tph_enabled:1;		/* TLP Processing Hints */
+	unsigned int	fm_enabled:1;		/* Flit Mode (segment captured) */
 	unsigned int	is_managed:1;		/* Managed via devres */
 	unsigned int	is_msi_managed:1;	/* MSI release via devres installed */
 	unsigned int	needs_freset:1;		/* Requires fundamental reset */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 7e9a6a130711..670314666fdd 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -751,6 +751,7 @@
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
+#define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
 #define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
 
@@ -1217,6 +1218,12 @@
 /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
 
+/* Device 3 Extended Capability */
+#define PCI_DEV3_CAP		0x4	/* Device 3 Capabilities Register */
+#define PCI_DEV3_CTL		0x8	/* Device 3 Control Register */
+#define PCI_DEV3_STA		0xc	/* Device 3 Status Register */
+#define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */
+
 /* Compute Express Link (CXL r3.1, sec 8.1.5) */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
-- 
2.49.0



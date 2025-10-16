Return-Path: <linux-pci+bounces-38396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57450BE579E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 22:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104A83BCFB7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 20:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF4821CA00;
	Thu, 16 Oct 2025 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8L2A0GA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79A1534EC;
	Thu, 16 Oct 2025 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648341; cv=fail; b=ZEcpkunwuuos/qlGqnQm8xP3CFUb0hzPn0qKrZPi+TxC+EOXofB8i+k7bW5XYBgmEpc3BZR22TLVebNQtspjjv58h0CDyV4YBr+RDUkptPGCPfphgsB0Kr0/VRa+HQhuKH3qovH5Mnipoq2+ZWt1bH4k1DnIFdk15iEGgptVkkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648341; c=relaxed/simple;
	bh=g0PXiiwj6/jPcIFEXZZT1HXQbR04+PRx//GVbUzWJlI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=FNRoDLlyqf/6X175rvUhvXHTR42Okk5jGwCgWWqynTeFvqeKTOgfQi9L4+f7zph170iCmgbJ+gvMhNiEM0myHAoWmna7sCVPqBTZHk0wVTC9UbxXfEDk1th2pHpRPCX0QgJq0bjWSeT8zFGLhXt0zaplApdxxDZhStjpUX4f6Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8L2A0GA; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760648339; x=1792184339;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=g0PXiiwj6/jPcIFEXZZT1HXQbR04+PRx//GVbUzWJlI=;
  b=l8L2A0GANaCh1l5nYaeoqkAv+ioihvrp1XU7sF2mCsy42UUUK7jz2QVS
   KpKSsHgQfduzQ4bhckgZM3xECZ6UJnoRgQq/4UllcEfmvGQFUgqOEJ8q1
   l0QjMMy06aG4av91lt3n04fB6xs1ZUe8lToguMWXNs+FNIPWCLr0SJm4D
   XzVOZGCwzjeUW1tzYXlPwvBOFI5xv8p78QJXNB32BgM9LwjyBaU8PYu2A
   Cbm+3Tya8yu33rMQpVdPCkUNWzIb0qTFnwGB2mXCym/YM0V1HMQKzLHDq
   KHcpDlkY41IgU2HdZIqT/g3JvPz6oPYkkB/kw6e/YR6Hb3YP99XrLi7bt
   g==;
X-CSE-ConnectionGUID: m1cJoNPhSPm4wH1uf9wMWw==
X-CSE-MsgGUID: nvr/+3YkT1W7b8WvgTXwNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73141140"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="73141140"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 13:58:54 -0700
X-CSE-ConnectionGUID: AuC+QMRDRgufsoShJ92VKA==
X-CSE-MsgGUID: cyHsQq9CQ9KMkQlWzk1QfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182963909"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 13:58:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 13:58:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 13:58:52 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 13:58:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0/DSOgMwsvI6SZU6baUcycospf/mjENzz9968bn2JQY+d7oXtjVgW2GuyxjBWj8vqympSh0uaOhlEJ+jDQeg4ZatoyU/anayUZhuQcLGI9UfACbxfVe+whpAOfK5MN0FtJt89tJWssoYZKtVm136xeg2tKzGBPg6MRtyGNtPKinrEASY/qUlHAr/ei4XTUcREEqpCKkYhJ8c20x3iA5PZB1ivQr684h9OS5PkZ4WEgfo+8hVs2qzk3yBOwIkSrIRiO0TYzhm049AACI4rfKzDjcAqupsuGeA47FXw5rCb5cbpN5CHIJ2a/GEKlvxt7SD0cN0UT/S8sQoSUFxlxPag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKlBdFULINIua52t4Ew7MjGyaWaib+o6ocPcUgDrTqY=;
 b=thCVcaqkffn2uaZekgCqHmDa7iDWnaNCrCV0cvIFCU0R61lJd7pge4WvCo3aCKHPyyROU+zQA/JyTLRbkK/a7+y5sYlfcfUDVrhCA8Ckez5FKGjJ76S1lSEQpcSZsWsxcH7sYzaHqFc4Ec3tQBDSmjsQ0I93DNAs6Bo4BBi4t8CQ8iGeQny2oeLEsDlPvivIWj++jk8rfpnEdc/gR4oqhY+kNPFjoVtbWnOGjEa1NEC+loFboq1zRbiwJ02Re47wKFu/kxmq+pMIWpDkXOygAeIc0P4vvhAvrbr+h3WvRfTw76xey1E5tI8kkBl4pMjWwC+rYzP/0J0nxGH1dZdkeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7795.namprd11.prod.outlook.com (2603:10b6:610:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 20:58:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 20:58:47 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 16 Oct 2025 13:58:45 -0700
To: "Rafael J. Wysocki" <rafael@kernel.org>, <dan.j.williams@intel.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>,
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Linux PM <linux-pm@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, "Alex
 Williamson" <alex.williamson@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Message-ID: <68f15c85b1781_2a2010086@dwillia2-mobl4.notmuch>
In-Reply-To: <CAJZ5v0iZJFQeBhA7tM-sWuJDtisvrHGjPPdQHrC-eXXF1xJpbA@mail.gmail.com>
References: <3925484.kQq0lBPeGt@rafael.j.wysocki>
 <cc21a74c-905f-4223-95a8-d747ef763081@baylibre.com>
 <875xce7m11.wl-tiwai@suse.de>
 <12765144.O9o76ZdvQC@rafael.j.wysocki>
 <68f14b5b6a92_2a2b10018@dwillia2-mobl4.notmuch>
 <CAJZ5v0iZJFQeBhA7tM-sWuJDtisvrHGjPPdQHrC-eXXF1xJpbA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] PM: runtime: Introduce
 PM_RUNTIME_ACQUIRE_OR_FAIL() macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:a03:114::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc7093d-8d6a-4fe6-22e9-08de0cf6ccc2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXJiREpkeW1CYTNpU3I0THl4OFlkZFN5SDZlWFJBTjZNQjVTdHZuQ3VsMXNo?=
 =?utf-8?B?R2F5alJIUDNQSjJhWmdOb250NTlXOGxTT2pNaGN0Q2ZHeXM1cUY0bFNmbDJO?=
 =?utf-8?B?RWR0c0gySXlvY3dwN2sxeFFNbkw1NkFHTE9NQkl2allaQVRJcGlSTWNZOW56?=
 =?utf-8?B?ZzZYUDV4dENqRW5SWDh6SXVZNEc1OVh1YWZ1by9NbG0vcWoxWlZsZGpQbys4?=
 =?utf-8?B?ZHRLMDRjN1RRb0tVdkE2ZGlSRGZpTGMwM0IvQ2RsWDVsSHJQWW5COXlNcjNI?=
 =?utf-8?B?SzFELzJDVmlEOGF5SktZWG9sZTgyRHExcHZ4T3BGTGJZTjkyL1ZDVFYvRVlp?=
 =?utf-8?B?ZEY5SXdiWnUzTHoxMzFDOXF4R1p4S3hlMjQ4c25NN3cxUWwxVElZUVRneU0v?=
 =?utf-8?B?SUxHMjBFUVBLSXJjeXo3Yjc0bHZoL2I5K2pFVWZ5VjlJOW1rbHNpcU5qL0w3?=
 =?utf-8?B?eFVaNm95UVFoY002dzBUQmh0QlJjb0ZIcWtCOXpVNVZ5WXVJclViam1PeDdt?=
 =?utf-8?B?OEhCdU90WW1STWIzRkQwVDNYMU1JSjBYQ0tNRHhMZFc2T2hMYk1DZnRENlRN?=
 =?utf-8?B?d0JrZm9uTFNOY3lxbGVLQnZnNEk3QXFBM0xGZ1hmTitVcmFCK0xRcDNBUXpw?=
 =?utf-8?B?VEZUckpqeE1SWWhlUytpc0tBOW9CUkNtNGxodVozL1hiSlB1anMvUG5GSjZu?=
 =?utf-8?B?N1VnZ29HYzVEL2dnSzVvc3o0Q1B1K3A4THhjSC9hUmhYcGkvSm5qM0pPcmsw?=
 =?utf-8?B?S2hkajJLaURJZkZDT3BCUitPaFBuZElwNnI1YzFEaTc3eGEwQmJudzJsT0g5?=
 =?utf-8?B?KzFYV2xSeGFKcjlvTnlWc3djQm5aeDRMUEtxU1lwa2pkc25tR3dhTDlLL3M4?=
 =?utf-8?B?TVkvWnplQVF2aEM2YThPQ1d0bXoyNWIvRVVRTzNRUGJjVGJ5SFRwRW9qeVhY?=
 =?utf-8?B?QXhVdjdpWG1DbzY4Q1FHOGhZb24zR1lVdXdvSy9MajhaSCtGNmdkM3NYRXNk?=
 =?utf-8?B?WGV1RUd2MG1XOHpHR2ZjdWNQUGFkL21JeVdiTFpUMXc2ZzNYUHNHc0Z4S3RS?=
 =?utf-8?B?QnpZNVMxV3FvWXNNNWlNWGN5V2N0UTQ3eHJ6anRxRGlycnBSRDVVMVRkZzAr?=
 =?utf-8?B?SkwxQ1RRalJOcmJuNktVSEYyaEprKzF5NE9RdFRXR2NoSnE2RGhWYy82UFR1?=
 =?utf-8?B?ME9hRXV4UjRiaDZyb251ZnBkc3F5QTVYcHBjOVRyWFdWSkJpMUtIZk5vZFFO?=
 =?utf-8?B?aytMTW5uV2VZMEhwMUdlbjRETzZFZ1ZMbzRHZkc4RlpFOWxHakF0M1k0ZEhK?=
 =?utf-8?B?MjhZdVpCUkZtY1Y3ZjROMEowbUNyTHIzMUdLbm5OVEd1bDh4aGUvZlVoaGVv?=
 =?utf-8?B?MCtybWFYZTk2UnZUem9TN0g2eXA3ZDNtcll4ZVN3eVF1aXNRWkh3dFRJeGMr?=
 =?utf-8?B?NTlWcU41Wnl2bVJBZW9vNkpHU3d5SWkyc0YxOUU2VURJTkFzUGs2aDlIaWNY?=
 =?utf-8?B?MlJOLzdteERuU1FpYWRuaUlsL0RzRlJnMnhXaHpYNlVJYlhZd2RkdjF3SHlV?=
 =?utf-8?B?c3E0bVFER2hjQ0h4LzRyekp1TEZEZGlwd296SGlHTjk3L1Zwai9QV3N0VVFT?=
 =?utf-8?B?TFpZckxKT1BFYk1nODNXb2dkZ1BtU3BaZnJNREQvRzViRlpzUkV2OGdpSzMy?=
 =?utf-8?B?aU5MUzVla3pKYWhyTUVXUC9OZFkxSCtFaTkzY0h5Y0hWSGJteXhBNUxXRVlB?=
 =?utf-8?B?SjZwQTl2V01FbklWMXBtenZFYU1kM0hBVmV2VXVCa2kremJzZXBFMEZzMyt5?=
 =?utf-8?B?NklBL1FMbzVBVHhlQi9vbkZhTEU2b2twd2JCSU0reUFoVCtrdnFQMU16cU5n?=
 =?utf-8?B?NzV2eG9DWDJYNFl2ZUFkdDlFcWpvOWZtdmdkNDNJNFNhbWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHUxaGRBS2FyVzBoVXMrWEFNVnRkbWtEZTQ1dVlUQkdQaHRXQnpteUNjNlZ6?=
 =?utf-8?B?UlcrNU90bUdBS0dkRHJyOFhlalJIUFVnc29rcnRJZXpTdE9Hd2RTSko2bVpD?=
 =?utf-8?B?UFlneC9IVUVKTG5YaUFiNlFMVERSbTgzb25FNVJLS0VPSndFQTRQUHpQSmRG?=
 =?utf-8?B?MG1HVmljZUg3UFNnaGZyL09WbUZaK3owV0JPYjZYRmtJd2dXWG1hWHRFdmNS?=
 =?utf-8?B?blY1T1J1STlmc0dQeEdCZGVseXRjcWRwQU5CaWRCaDlUQ0FDWE1jQzAxaGRo?=
 =?utf-8?B?M1RxcUgvQ0pPVzUxWGk3MFpObTlRNWlEdSttc01RTVJZWUtnV0lWRC80alFw?=
 =?utf-8?B?QVp5RTFIclJUZEx4blJ6SExkZXh4SDZpbWpCYkZ2L0p3N0I4Vy9nVHE5amJv?=
 =?utf-8?B?TlkzWGNsR1NtWlkwS3RkV2FnS3VuT3AzWkM5SEZIZ3VWb0FYUGJkQjVoRHM0?=
 =?utf-8?B?TjJZelVucXBhK1h2b3FsNUtKQXVJSlFMNlI5aTB3dXMybjFzU2puc2x4dE1N?=
 =?utf-8?B?bUJPM1JOUkYvekt5ZXQ2N3orZS9aTlN5ekhwNkNReVlKUndEWE5vUEFiUjJK?=
 =?utf-8?B?bHBESUIvb1dwQkV6RFNvQ0ZsLzdhTkpvY3p4KzF1R3FoOWhRVTVzNk52bnF0?=
 =?utf-8?B?NnV2dUlWUVhDbmdxU0xwelNuTzdZK21HQzg5MnJXSlF3K3YrYlBuNEFwdnlO?=
 =?utf-8?B?cHBrUFNodWtPc3YreEFrNGRiWk9GQWtuNkxReEtybkdESGl1ajNybDljbU9Q?=
 =?utf-8?B?cGVFbmVtTlFaQkg1YVppMzJGbmU5UUc1SlN0TnFyenZUUURMWElLVDVqTENv?=
 =?utf-8?B?VFI0MjhoZk05TjIvcEdmZnZjY3l1Q0Iya0l6SVlQTXFLcWRmWXlLN0ZNb1FE?=
 =?utf-8?B?bC82TTlGeGtBSllzRXdZMU1uWU1LNzUvUlBadFdKSTlyR3RLQ0RDcFNadDcz?=
 =?utf-8?B?Y2ZScTRzQVY0M0gxSWlIaE1kK2hQQTNLUlZ6RVJSeXlKYmRtcTAyakRXczB6?=
 =?utf-8?B?RkFaVCtxS0c2VzdYaEgwUlZseWNSeWIxSVY2Vld2R2d3OFlublFnZzlqUzBH?=
 =?utf-8?B?YXhGcmRCSWdqLzBqZkhpYVRLTzQ2dEVXSldNTE9PZmhibDJoMEVZUk9BNnZH?=
 =?utf-8?B?NWRrQVYwWFpzbUVOYnZNNkNGWGVFdmIxT1NUclR5SG51b05TLzlFa3llcFJO?=
 =?utf-8?B?bURNWlhEMVpxUENtOW4wZTY0VDVERHRrNGVGdGxZeWZHTlRrQ2Jyc1FqSXVE?=
 =?utf-8?B?QzFOeDF1Q3NndHZrVVloSUxCUXFwejhQdDRydnYxN21wd05BbmgrTTVDVmZW?=
 =?utf-8?B?ZEt4RzVla09oU3lqT2FOTzFHRy9tNDQyZGZIVjg5MEJKYTl5TCtiSkJDS3RM?=
 =?utf-8?B?dU1QRW93QzRmdFV0OTh4cklqU3lYSHVrZGplZUQzKzVxOWRkNGEzZ3BEd1Jl?=
 =?utf-8?B?aVNGbFVUYTQwUUppRkNuLytZa293NVR5U3pHeS9LWEREdW1JanBuUjU0V2RL?=
 =?utf-8?B?aWVidk8zWFdiSWtKcGlsWHFpd3JVYmwySklPZzYvbXRtTE1mMDBqb2lUSzRp?=
 =?utf-8?B?QTVTWHZkdXNFNXkrVEl0YkdHc0VwV0xScGxxOC9IQnYwY21jNHF4MVNkVnRj?=
 =?utf-8?B?WksrYnNWYkluWElHVmIxNGFNQm9VaytzZGU0aEU1UzBMbW9uRkZ1VTdhdmRh?=
 =?utf-8?B?QnB3Yk9KL3ZuVDl4K1UybW5rNU5HaDRhTlZ2am4zbEl3WllDQlZyandUMjE4?=
 =?utf-8?B?cTduR1loa1BiRU5uc1A1Y0hhRWt2cWVqSS8wODloVXFLR2Y3ZHdSMFpaLzJ1?=
 =?utf-8?B?Y1hLVW9OelpBQ0J1b0FpcCtoWENDYUxySzlydE9wWXk4eHBSRnYzbkNQQlp5?=
 =?utf-8?B?N2N0MFB4YmF4MkRuVlNyV2tvME80TVZ6QnYxaWJ5UzU4Uk1WQWUvQUo1VTQ3?=
 =?utf-8?B?NHhmV3RGZkU3UFk2Ym9ubFVPdVRrMFVJb3hZNkVYZFJtUGwwL1JyUExZNWhR?=
 =?utf-8?B?RGt0K1dLUGF5QnNDakFKNmJYM0tud2pTYTNXUmRFS3hmTHpHaUVob0lqSm9E?=
 =?utf-8?B?b3lHTyt2RlEwN1E4QnY2bUQyME4rYmp1YjhUdjh1VTZhVkhncDA4UVJvTlRO?=
 =?utf-8?B?eTlNYmkxdjdjZ3YySStNV3pkb0NiTVVLOVpCZk8xVUpFbDMvdFNlVFpzbDc3?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc7093d-8d6a-4fe6-22e9-08de0cf6ccc2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 20:58:47.2063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlvYs01+EAsHUfYHTp6IOw5UWAZuFLnjiEipXEnVhE96UvCdzufcFzC4Joa8MVPTJF6I8yq5hoX9wYW8vHdimneATk2nfaMX0oYEldb9KJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7795
X-OriginatorOrg: intel.com

Rafael J. Wysocki wrote:
> On Thu, Oct 16, 2025 at 9:45=E2=80=AFPM <dan.j.williams@intel.com> wrote:
> >
> > Rafael J. Wysocki wrote:
> > [..]
> > > > > [1]: https://lore.kernel.org/all/CAHk-=3Dwhn07tnDosPfn+UcAtWHBcLg=
=3DKqA16SHVv0GV4t8P1fHw@mail.gmail.com/
> > > >
> > > > Yeah, I myself also find it suboptimal, hence it wasn't really
> > > > proposed...  It's a limit of macro, unfortunately.
> > >
> > > The macro from the $subject patch can be split along the lines of the=
 appended
> > > patch to avoid the "disgusting syntax" issue, although it then become=
s less
> > > attractive as far as I'm concerned.  It still allows the details unre=
lated to
> > > the rest of the code to be hidden though.
> > >
> > > ---
> > >  drivers/acpi/acpi_tad.c |   10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > --- a/drivers/acpi/acpi_tad.c
> > > +++ b/drivers/acpi/acpi_tad.c
> > > @@ -31,6 +31,12 @@ MODULE_DESCRIPTION("ACPI Time and Alarm
> > >  MODULE_LICENSE("GPL v2");
> > >  MODULE_AUTHOR("Rafael J. Wysocki");
> > >
> > > +#define PM_RUNTIME_ACQUIRE_ACTIVE(dev)       \
> > > +     ACQUIRE(pm_runtime_active_try, pm_runtime_active_guard_var)(dev=
)
> > > +
> > > +#define PM_RUNTIME_ACQUIRE_ACTIVE_ERR        \
> > > +     ACQUIRE_ERR(pm_runtime_active_try, &pm_runtime_active_guard_var=
)
> > > +
> > >  /* ACPI TAD capability flags (ACPI 6.2, Section 9.18.2) */
> > >  #define ACPI_TAD_AC_WAKE     BIT(0)
> > >  #define ACPI_TAD_DC_WAKE     BIT(1)
> > > @@ -264,8 +270,8 @@ static int acpi_tad_wake_set(struct devi
> > >       args[0].integer.value =3D timer_id;
> > >       args[1].integer.value =3D value;
> > >
> > > -     ACQUIRE(pm_runtime_active_try, pm)(dev);
> > > -     if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> > > +     PM_RUNTIME_ACQUIRE_ACTIVE(dev);
> > > +     if (PM_RUNTIME_ACQUIRE_ACTIVE_ERR)
> > >               return -ENXIO;
> >
> > This defeats one of the other motivations for ACQUIRE() vs
> > scoped_cond_guard() in that it drops the error code from
> > pm_runtime_active_try.
>=20
> No, it doesn't.  PM_RUNTIME_ACQUIRE_ACTIVE_ERR is that error code.  Or
> did I misunderstand what you said?

Oh, what I am saying is that pm_runtime_get_active() returns a distinct
error code like -EACCES or -EINPROGRESS etc. The
PM_RUNTIME_ACQUIRE_ACTIVE_ERR proposal ignores that value and open codes
returning -ENXIO.

> > Maybe it is the case that failure is always -ENXIO, but from a
> > future code evolution standpoint do you want to commit to always
> > translating _try errors to a local error code?
>=20
> No, I don't.
>=20
> > Btw, was acpi_tad_wake_set() buggy previously for ignoring
> > pm_runtime_get_sync() errors, or is it a regression risk now for
> > honoring errors?
>=20
> You may call it buggy strictly speaking, but it just assumed that if
> the runtime resume failed, the subsequent operation would just fail
> either, so -EIO would be returned to the caller.
>=20
> This change allows distinguishing resume errors from I/O errors.

Ah, ok, makes sense.=


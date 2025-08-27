Return-Path: <linux-pci+bounces-34858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A30B378E2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340287B35DD
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B0E30498F;
	Wed, 27 Aug 2025 03:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tb7mCAgt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0324304BDB
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266790; cv=fail; b=DIjlFNYTcTzopPgaHse38Ff0jwom0DvEVU5UXAbuKKL0A4QVdswV8VIhZUWkDfaVXDh60kiKVMdZ8Uxi2sz0ywUtZT3F7oN3uQgeBYqPoEFTfB1iSAUfu3mHVj4XFu1Bk/xqtvH/59Jap0aUep67k9Gcs+B8r+ntDaVItIS/YnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266790; c=relaxed/simple;
	bh=w3ibPdAscMcZRKeHtB2JJ0qF/e8i2MxQKUid+JNJUaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fCxmapfLjPcAldSW7pX2LDb0tGLiqr/Z78Uaj2HO71xx08UKa2LKz3TkgEfDSJLvhlTmzD+Rz8ovLp29cvvRgw1nHzwVWuekxkBYXnxF4uhpgVKWtJUVhBvgg0CeObwNPv08h2pj7dJWhqlxSoVkeK4EOab+ifiFzm5RqLJ5RnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tb7mCAgt; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266788; x=1787802788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=w3ibPdAscMcZRKeHtB2JJ0qF/e8i2MxQKUid+JNJUaI=;
  b=Tb7mCAgtjMmGQH8a2slhB6De3EF7ldT6SrDY7gEm0SuZx1jB5A3daRwp
   6UkQGdSknvraVHUi6/1fcNjEbUhBu+voikiuVBIaUFIWTQbxFDardJRkm
   heKijtIzzNvfMIDk0A1+MBoKLLTdYJaeqVzKw4uIy+0IubCPd3LX2tGIu
   4sld4Kj05NBAqRKE5rMPZ5rNe6X/MQ5QFUcmIUt6SkuOvgFGpf//HAyqP
   8cltY+rhJVYGLFtDAZg/dG7Bnv5nX/tL5za9o46Zh7vkyJeozlH9SoDc1
   xoenh+qMYz0OopFXJX76hedThMfKJoKaQpWO0Ftcr01vy0LgZ68PH5VXZ
   Q==;
X-CSE-ConnectionGUID: y+EFN66ZQs+hHs1MioOepg==
X-CSE-MsgGUID: HF/SV9UBQ+i5FNAcOBuL6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69106488"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69106488"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:07 -0700
X-CSE-ConnectionGUID: tkSDSaqYSvy1tAcIo+Cddw==
X-CSE-MsgGUID: ScAa/WWWTTWH6brZH9OqFw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:53:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.60)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RybdNahnq/kExmk11vBuSFADBewWDfpimWd5ll9DKIrQf5jW73WdlgRDWWFf5uKfRyuvgFN9egj/a0z1NNfk/BRkE6No0TSd4RNaT/UAF6utzEejeH9T8YSFFcZAj7yuN5B/5IKz5Sw4sSjZxxLBtsgPNtP32mnFU0pIHCUd58hhY/osyTw2MA/h4EJUZ/LG+aLaBs4DPGtV3V9+cmDkgZnNlIkh8xAZ309SX2YBkoPc9uWp4xlJe+3ErEFEBo96qqktYBPNmJ2AUnEZ616PMj3EV3jcLlo08KOzgZSqVxAwyfjz3b7w46h+acWjv2NFdKzEmWKXTdTOnn9Vyc7+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEeBK89GJIcmcYoQ9shIau0HvdQDtx6Vp59t6fa0AeU=;
 b=PYqT80Yj8KAbYmNU5XdJW49O/PVLQqr+jcdBRlbsYtvCnWWKf9vfTH+4Ma45BZbEbYSgvPvr644Ku9d7bLxraS+Rm02agS5h1f4GWwx19J385hbopH0iIMmbGdXouqaamkdegI4vXVjj2eX219u/wbuli03zNZHQcSKtPv+LLc5VCYgDTYVdvVxDZq2dzoAfmGbWE5gCyI/MXwhUyy1+1QorLgWv95kXLhb2wZgKdrf18IZjCP6Cmp2jbWLRgUjk9LexEPgi0wi7GCDJAvkTXI4QB4FW285B82MV7hy9/yCj4Xn0usac4TRGH3MtCVlA1loTh5tA/jcgNnNMawWfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 03:53:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:53:04 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>, Samuel Ortiz <sameo@rivosinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 3/7] device core: Introduce confidential device acceptance
Date: Tue, 26 Aug 2025 20:52:55 -0700
Message-ID: <20250827035259.1356758-4-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827035259.1356758-1-dan.j.williams@intel.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:303:8d::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: d10af951-2262-4ab2-4a7b-08dde51d39b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kK53lxN19q41xU2rlMBpraVY9XN+HaWBacFHaO8QAikxi2sflN14MZgTRzcS?=
 =?us-ascii?Q?ku5LeL5/nsb4nRJxR4E3gior08Zzxisu6LxIbWSk5OMZDFT4emuXezkFQq+q?=
 =?us-ascii?Q?hcnl0fzUyeQ5Ja+JaKRTy0Bu0ZzwdQy1ocyvhChrSNFw3y4+OUKLdih2Bnxp?=
 =?us-ascii?Q?wU0gdbpHhm9SEs9SebNgY64do4tzSt/v8AF9sU61BQGeZqglKjgZNdi0DlkL?=
 =?us-ascii?Q?fFp78alwGZu15RtV9PtP7qwVvSiasviLmk7RK2HLvFCOIOGj8TW9U0ivyX2V?=
 =?us-ascii?Q?ptaymh4F7+hhnDG7KRs325E9hvhw1q5zOE/l761QAc1E/WM/wegAkKtnYtM9?=
 =?us-ascii?Q?YweEyC2TlvcKp/CJrd+vkFqaM0Ohqv8gbQo4fhH3VKfuLBmrF5lLf+Cmr+sF?=
 =?us-ascii?Q?PSL8Gd1p+L2yPA3ChwaK6PbB2/saMXs84S97BIqFFCgY1QuHPP2XygOpetlf?=
 =?us-ascii?Q?Lm61sOIO8P6mp9/M9WHMrgqki72xRbvju8p3SvapUXKrR5Y8IrlglO+bFsRq?=
 =?us-ascii?Q?Utr1E4jd8Pi0nuJ58Kg7E2YCVIWBE9Zfn4o03hl9Qt585Vz1RUFylICjSiQq?=
 =?us-ascii?Q?i/83H0IC5j7bKAq0G1Gf9qq4OKA82suMlInsztm+G0wRa3tXLnykCBBX5krK?=
 =?us-ascii?Q?q1hwYS06bnxNme+qfmvAKL8Kl/qbDqZ0n17XrlqDrGkGAYR77dp/g05orV4k?=
 =?us-ascii?Q?VWskMVw7pbM2cmADHM9VS5O4nOm2YFP5ud7ueQtjCeTM6LM2oQTGE32BJc+M?=
 =?us-ascii?Q?E+ExEbczVLBA958wytAQrxPeUqGBtiIeN9YTGRX0ezFOgJsa5K2JwuLAqRos?=
 =?us-ascii?Q?Z2mfDmEQ2DNHUVnkzxK8xiWA5LGIIJGFjyBmIeJFEcfedPMxThlBwGgmCMtm?=
 =?us-ascii?Q?oMO0ayZ5KygiObEc8VHrjJiyPpmKtApG0ReLnS9pl9qUm0LP7oeiI6bANItd?=
 =?us-ascii?Q?yRzDwmZfUjjBB4WWUvC9VuMH9IOH+VPbW8wP080zC7DGV+XMFuOSQM+Xvm+R?=
 =?us-ascii?Q?impnOpg5PTGpgNLeugBkqC1c7+rMC0NZH0kMqjQBCrrHq87z7QZAxotUoREi?=
 =?us-ascii?Q?bgF3yb9E+FKwdgFeJebtmf1rSiL5qccoPCs3+1NZ/8r1a93RvYbyRlNBjbvF?=
 =?us-ascii?Q?I+GuZI82yhy1PDFCkkLn4Mf02TpVRumW+nNd01JR8XGcVR0Ro59QY0RWfggb?=
 =?us-ascii?Q?YoQrVQhDYEthUuR2SKXSRpxNN+JeKOXECclUXoqfKgJxXrtLWskkOIuxvNT4?=
 =?us-ascii?Q?64JecGl4hWYHVFXA29WIpZytONOZMf07Ncrf6YTDc7OXhwR8hcjLyoRKzjCd?=
 =?us-ascii?Q?MbI3RP4YAZe232B+EdiCl3gG9hHAPFQMy3aWKwLZBM61ZniRA7NikHc5szu6?=
 =?us-ascii?Q?HevT3k90b+fRo8omrNTedW2gytFyuq2zq3B2OWb8xWp4y/wwqC6cSktmVqId?=
 =?us-ascii?Q?RmWbdf4NMRk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2xhiwutVyVKWksDvJNZhJ+nNCjkccoYQT6li803nCKziP+Z+3wpwfuXaxSCh?=
 =?us-ascii?Q?Qu6mt/59uF7mOTnqF9Md7MEZDWs0hhRciEh/LO2mAt4PpulkCAk+MfCmDTpJ?=
 =?us-ascii?Q?TwSchEueiskYebc+YEon6g+7GWyMxIg9DBiSBo3V2JzzRdMk65wuMwVEUKKq?=
 =?us-ascii?Q?Prv7VpiRo48NXP3jjKhwmsGtbj3kZvppod/L8IlX6DEqSyCkd1aagzga0xy0?=
 =?us-ascii?Q?O0LeHWJEM7UyiiFNZ94vkQmxydgY94qwN+csB4qx5uOu3aPfmz3aFHjbbN2A?=
 =?us-ascii?Q?aH48Ud3ZXYVAgIXycihcPmQkT5Y9onKscNhHwhY/Bqw1xeBZVB2No9dItIGb?=
 =?us-ascii?Q?R6X87+1/RU/neSDXwfusIhA8PdmXtzG1KVCsMkpUDk2s6Zdo7mBrL1Z6ayY+?=
 =?us-ascii?Q?Z+2YtwCwthq1I8o1NO5DwuLYUAQnjcegM8wmDtEE6ebLSE9actJn/Hug+lxr?=
 =?us-ascii?Q?vHhZ9oAgI2NBru5Szpw8LMK2NR4D2A3mr3s/EGo+5q7K7GK6lCjoD2lUWvtq?=
 =?us-ascii?Q?BXzNhUa646I9B4aGzaZEsavMD65F6piQAvbKP+QvF0ilUplh3KObqnPcn7JM?=
 =?us-ascii?Q?JXdO9rUakHvZkazk9zSxfjoG+IBAo9mYD1CN04Sm/Hg7TkwwLDp9tpdaaWqH?=
 =?us-ascii?Q?EaAiQr0+pJdbigiJ/DW2Fjx1tdjQX98nA7p09WG1baDeV/AB4BFRaPRHpt+r?=
 =?us-ascii?Q?pcsqOz3cHTha9ZndMZ5lA2Vk355RQ5dECqf5yTgQ6nHWuivqzXhbaLPF2vyu?=
 =?us-ascii?Q?S6qMMjrEOIhdvN15r9rbbPOxGcTawfLcu6BelAzOtFkatLP3AGEntCBptIU2?=
 =?us-ascii?Q?vc+CiF7Dcu4lHyhN1xXQPj7nXEiOJZfQUlf7ba78J83Qu8AvahmPr6Cxeyw0?=
 =?us-ascii?Q?/PydZ7YJMYwTKm6OVA9w+iyChSLLSwQn5T+0K9G15wjgdkcSUEbpieLAYw8k?=
 =?us-ascii?Q?3xQYK0cGFL5fuYO0j5nI3J90y7Fxb7qf524b+OIS9Qp83ZVPiTUIJZO4IVem?=
 =?us-ascii?Q?HYiqzQjVV6GVWMgt4aeXZc1cFwFtb5UB00z5msICoKdmX4vpNz84Uriw58uZ?=
 =?us-ascii?Q?8TJHAsBeMyZ1iUKS8PP3STSD2Runzw8izsVgwuWkW8GXetbQmF6L/pyCZh9c?=
 =?us-ascii?Q?ENQuWX2xlrRFxXh79t0rw5JBqp0SeW2gancZRRYBQHmA2axcUfrvQUUv5lSk?=
 =?us-ascii?Q?AaswKDV9FXTnhMqFIAwAFOeqlc33ZDEBDCb+h0KbKE6anIuhO/ovPjuaWtdt?=
 =?us-ascii?Q?5ZTGd9AO2KnLx36yKyKzGVtc1E9NHCJ3XTBI6pXQpiHnU6v2PxVHcorF2CrN?=
 =?us-ascii?Q?aaLC8DuiTZPZgmYn3m9uc+vSjLaP3ftHYCGBCWf83bJujn04LY/zkZBw6IAT?=
 =?us-ascii?Q?rybhpobDm7vr02NMg5Tpp6VAubx1FxN18qTdIlnonoMVMtLClsPtyKB3zI7E?=
 =?us-ascii?Q?XkGmpSDSGIbgfvpniUefcnuYEMsL9ASGk0odgRoO2Cy9ToLYJMXGgyQjosg6?=
 =?us-ascii?Q?U1G9IOuT8FKTO3+jITEbIQsIbEOss49SRG6A4gz+MA8JeEIofKkFn5ohN64q?=
 =?us-ascii?Q?qmT5nB0k0yGyNQb1I80WT5km9s8KO8Kv048+i7UKITsWjZHuo52m6ZMsjmIK?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d10af951-2262-4ab2-4a7b-08dde51d39b1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:53:04.2536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpVzrkXZ+jmvk6dMoJB/wVHJ+iLUAyM2mKY3wzCFzt4yMMf/wsJ4TgJYhuYfdOO89BndReqtME3db1TN82B6uBe94U9vpF3yi5Qgw2eZhTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6170
X-OriginatorOrg: intel.com

Of the many problems to solve with PCIe Trusted Execution Environment
Device Interface Security Protocol (TDISP) support, this is among the most
fraught. New device core infrastructure demands a high degree of scrutiny
especially when touching the long standing kernel policy that the kernel
trusts devices by default. Previous adjacent proposals in this space (e.g.
device filter, no bounce buffer flag...) have not moved forward.

So, what is this new 'struct device_private' mechanism, how is it different
from previous attempts, and why not a bus-device-type specific mechanism
(e.g.  pci_dev::untrusted, usb_device::authorized, tb_switch::authorized,
etc...)?

TEE acceptance is not a state that random modules should be allowed to
change in the common case. A device entering the accepted state is a
violent operation. Pre-existing MMIO and DMA mappings can not survive this
event. The device_cc_accept() and device_cc_reject() helpers (where "cc" ==
"confidential computing") coordinate with driver attachment and are only
meant for core-kernel bus drivers like the PCI core.

Driver interactions with the "accepted" state are similar to driver
interactions with the driver-core probe deferral mechanism (also managed in
'struct device_private'). TEE I/O aware drivers are responsible for
preparing the device for acceptance and then waiting for the accept event.
That maps cleanly to the probe deferral mechanism and device_cc_probe()
helps coordinates that handoff.

When the device enters the TEE, other subsystems need to behave
differently. For example, the IOMMU/DMA mapping subsystem needs to switch
DMA mapping requests from SWIOTLB bounce buffering to direct-DMA to private
memory. That device state is communicated via device_cc_accepted() in a
common way.

The observation is that PCI is not the only bus that has designs on
interacting with a TEE acceptance state. The "adjacent proposals" mentioned
before include platform firmware and embedded buses that want to accept
devices into the TEE. A bus-type-specific flag would be an ongoing
maintenance burden for each new bus that adds TEE acceptance support.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Roman Kisel <romank@linux.microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/Kconfig   |  4 ++
 drivers/base/Makefile  |  1 +
 drivers/base/base.h    |  5 +++
 drivers/base/coco.c    | 96 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h | 28 ++++++++++++
 5 files changed, 134 insertions(+)
 create mode 100644 drivers/base/coco.c

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 064eb52ff7e2..311e5377bd70 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -243,4 +243,8 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
 	  command line option on every system/board your kernel is expected to
 	  work on.
 
+config CONFIDENTIAL_DEVICES
+	depends on ARCH_HAS_CC_PLATFORM
+	bool
+
 endmenu
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 8074a10183dc..e11052cd5253 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
 obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
 obj-$(CONFIG_ACPI) += physical_location.o
+obj-$(CONFIG_CONFIDENTIAL_DEVICES) += coco.o
 
 obj-y			+= test/
 
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 123031a757d9..e4eec07675aa 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -98,6 +98,8 @@ struct driver_private {
  *	the device; typically because it depends on another driver getting
  *	probed first.
  * @async_driver - pointer to device driver awaiting probe via async_probe
+ * @cc_accepted - track the TEE acceptance state of the device for deferred
+ *	probing, MMIO mapping type, and SWIOTLB bypass for private memory DMA.
  * @device - pointer back to the struct device that this structure is
  * associated with.
  * @dead - This device is currently either in the process of or has been
@@ -115,6 +117,9 @@ struct device_private {
 	struct list_head deferred_probe;
 	const struct device_driver *async_driver;
 	char *deferred_probe_reason;
+#ifdef CONFIG_CONFIDENTIAL_DEVICES
+	bool cc_accepted;
+#endif
 	struct device *device;
 	u8 dead:1;
 };
diff --git a/drivers/base/coco.c b/drivers/base/coco.c
new file mode 100644
index 000000000000..97c22d0e9247
--- /dev/null
+++ b/drivers/base/coco.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/lockdep.h>
+#include "base.h"
+
+/*
+ * Confidential devices implement encrypted + integrity protected MMIO and have
+ * the ability to issue DMA to encrypted + integrity protected System RAM. The
+ * device_cc_*() helpers aid buses in setting the acceptance state, drivers in
+ * preparing and probing the acceptance state, and other kernel subsystem in
+ * augmenting behavior in the presence of accepted devices (e.g.
+ * ioremap_encrypted()).
+ */
+
+/**
+ * device_cc_accept(): Mark a device as accepted for TEE operation
+ * @dev: device to accept
+ *
+ * Confidential bus drivers use this helper to accept devices at initial
+ * enumeration, or dynamically one attestation has been performed.
+ *
+ * Given that moving a device into confidential / private operation implicates
+ * any of MMIO mapping attributes, physical address, and IOMMU mappings this
+ * transition must be done while the device is idle (driver detached).
+ *
+ * This is an internal helper for buses not device drivers.
+ */
+int device_cc_accept(struct device *dev)
+{
+	lockdep_assert_held(&dev->mutex);
+
+	if (dev->driver)
+		return -EBUSY;
+	dev->p->cc_accepted = true;
+
+	return 0;
+}
+
+int device_cc_reject(struct device *dev)
+{
+	lockdep_assert_held(&dev->mutex);
+
+	if (dev->driver)
+		return -EBUSY;
+	dev->p->cc_accepted = false;
+
+	return 0;
+}
+
+/**
+ * device_cc_accepted(): Get the TEE operational state of a device
+ * @dev: device to check
+ *
+ * Various subsystems, mm/ioremap, drivers/iommu, drivers/vfio, kernel/dma...
+ * need to augment their behavior in the presence of confidential devices. This
+ * simple, deliberately not exported, helper is for those built-in consumers.
+ *
+ * This is an internal helper for subsystems not device drivers.
+ */
+bool device_cc_accepted(struct device *dev)
+{
+	return dev->p->cc_accepted;
+}
+
+/**
+ * device_cc_probe(): Coordinate dynamic acceptance with a device driver
+ * @dev: device to defer probing while acceptance pending
+ *
+ * Dynamically accepted devices may need a driver to perform initial
+ * configuration to get the device into a state where it can be accepted. Use
+ * this helper to exit driver probe at that partial device-init point and log
+ * this TEE acceptance specific deferral reason.
+ *
+ * This is an exported helper for device drivers that need to coordinate device
+ * configuration state and acceptance.
+ */
+int device_cc_probe(struct device *dev)
+{
+	/*
+	 * See work_on_cpu() in local_pci_probe() for one reason why
+	 * lockdep_assert_held() can not be used here.
+	 */
+	WARN_ON_ONCE(!mutex_is_locked(&dev->mutex));
+
+	if (!dev->driver)
+		return -EINVAL;
+
+	if (dev->p->cc_accepted)
+		return 0;
+
+	dev_err_probe(dev, -EPROBE_DEFER, "TEE acceptance pending\n");
+
+	return -EPROBE_DEFER;
+}
+EXPORT_SYMBOL_GPL(device_cc_probe);
diff --git a/include/linux/device.h b/include/linux/device.h
index 0470d19da7f2..43d072866949 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1207,6 +1207,34 @@ static inline bool device_link_test(const struct device_link *link, u32 flags)
 	return !!(link->flags & flags);
 }
 
+/* Confidential Device state helpers */
+#ifdef CONFIG_CONFIDENTIAL_DEVICES
+int device_cc_accept(struct device *dev);
+int device_cc_reject(struct device *dev);
+int device_cc_probe(struct device *dev);
+bool device_cc_accepted(struct device *dev);
+#else
+static inline int device_cc_accept(struct device *dev)
+{
+	lockdep_assert_held(&dev->mutex);
+	return 0;
+}
+static inline int device_cc_reject(struct device *dev)
+{
+	lockdep_assert_held(&dev->mutex);
+	return 0;
+}
+static inline int device_cc_probe(struct device *dev)
+{
+	lockdep_assert_held(&dev->mutex);
+	return 0;
+}
+static inline bool device_cc_accepted(struct device *dev)
+{
+	return false;
+}
+#endif /* CONFIG_CONFIDENTIAL_DEVICES */
+
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
-- 
2.50.1



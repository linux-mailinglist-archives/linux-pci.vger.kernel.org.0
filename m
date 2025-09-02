Return-Path: <linux-pci+bounces-35310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F33B3F7EE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 10:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D71F178BFB
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 08:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081682E88B5;
	Tue,  2 Sep 2025 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWXv6+7J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E292E6100;
	Tue,  2 Sep 2025 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800660; cv=fail; b=fgdXe7IQPmP4Qeq37YscnINU8pX7Xa/m1crEIZLJHfpcNNi19mugsRnQ1Mwj+V4Mo51tKMOeuDboXHbrzLZ0vsb7COzeGQxin0B1lTBLa+I+L7mHLFAkOZpbt1/8IxBlspOJKhGalQdmUedutSdv5hERfz/7IkiHMck7iNpkf/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800660; c=relaxed/simple;
	bh=S/4M+jTZ7acTRxExpd19yzx6sbI/LcfWSVffJhNCXc0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ACuA+7XWBuhb885RpQ+aDs4UsMH7oGIKDGcYrtxRXcWtld1rGk6+YVywEUM+I0I2fmLr35RMQ9zdt/eXLSIh6MmqdTs1cpyhYo1QNpLyrjxI+jrffXKsnY+WysuH/A9S9ulgmH4rj4cyP4rW2CLlsYk+hqEwWaVphdcsM5qaMOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWXv6+7J; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756800659; x=1788336659;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S/4M+jTZ7acTRxExpd19yzx6sbI/LcfWSVffJhNCXc0=;
  b=VWXv6+7JrL/fkJbTyZNYF2Lq43R8oiQE/kWdOQ2Os+8HHR6WQjurXstx
   6ykMHJorahh+H4qxEKmBDX3NY3EkaUZBBvh8xF7AeOf+zKBpKCu8Hc6Xx
   gnU/O86BaLG7gnpx/1mdZoJ8mybxoOrdyggNsa0b9q01hS+BTXxMAPGmV
   TNPQ7zBQIocaZPGUDGAiRX+nGr/AFiM4VjmMDPvJRBm/27oq5SESN4e3j
   Gkug54ec6XTO/z4o1DhqHZQDdhOiKbLWuFYlVaLYPqdTzUAvSaf44Zzun
   bG6oepiQG+iI51S4tHckxdvB9TFZ7awQtqG//Fjn4tZXfV0xmWJEMmO+u
   Q==;
X-CSE-ConnectionGUID: 7EuVLy+cSXmq3bD8BFetIQ==
X-CSE-MsgGUID: hTHsqmtmR+u9kHOzTOC+mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="61700340"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="61700340"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 01:10:55 -0700
X-CSE-ConnectionGUID: jR2DcXH1TQG5FAcfUsYlUw==
X-CSE-MsgGUID: /Og5jNxiTRmt2FUcD2/qJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="176532541"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 01:10:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 01:10:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 01:10:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.58)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 01:10:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+bEoiP1ueN2u4APRLIQr6WajSENKz5g1y3K+JZvkB3ibBygxAkLYOq7OcO6cVaGMti3ZPEoVnLW2i3KNC1b6O7AM/0UJ4jURsND8UW42kDErVEMhxHCe/ytkAAmcaPKeu+TbUyqs3ujETD/6uuRqFxOrYcJUeAIKpXUnn4+WYp7mnGvFI7e58OWlIJ08YieRDjTL0fO8rtGrnvOAr9SJnG8C/AXMvwaNtmwa1lhTFM2ow4dTL8S8X43chfw1DLZns9ZPWl/QwpXs7PqWNlhjbpShA6QrK1//wABsLcgb1znKF/VM6TTjKvom2vdXtz54Ej2ZUI95xlTa51qzXnD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoN71rHXB4JGrY8IaMrRD8NL8BUbew4N7ppY0RFDGh8=;
 b=LV1G100IeTv4GZud4YrH+9I8Q6PTSHTsbBihj71x4Adib4OGdvIVXgYmcf7eNvhBIKqe95/Gx5BaWNCmvaiOeAsUyCxmpJV1UN4G2endy+1nSkBsWnN1gAh2lUjW12+KocBkMTmGAr7WR5r2MSJsIwKEzeQT38bMpxnG2iEwDwfL8Gb/PAtYkzMfkxIRQZ2vQkqeRd36nKDEbq2phnUXIHxKDTi88n1ZkIZF+xbFj6wgVwloG737x7J9StMm1X0CElgX68vHTyfxfH0O7Xfj+YdhtWi6Fds8cwLySkO7HaocN4Qt8JHG/oLaD1Vp39uMCHtN5Kia1caqxy9miN/JOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:10:48 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%7]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 08:10:48 +0000
Message-ID: <a8cd620b-a3bd-4350-b2bd-741bfb0e8a96@intel.com>
Date: Tue, 2 Sep 2025 13:40:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <anshuman.gupta@intel.com>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250529111654.3140766-1-badal.nilawar@intel.com>
 <20250529111654.3140766-2-badal.nilawar@intel.com>
 <CAJZ5v0h7BENMDCOHVD6ZdF7o1OwE=RAOzkC0+r+G=-3qpjfn0Q@mail.gmail.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <CAJZ5v0h7BENMDCOHVD6ZdF7o1OwE=RAOzkC0+r+G=-3qpjfn0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::6) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|IA0PR11MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: fec5babf-506e-4a42-8c89-08dde9f83920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjVjdUx5RjRXMTV2Mml4THh2M3JERThXS0dMSlVUMHh3ZUlVWTRWVU1DM1pT?=
 =?utf-8?B?UmJXdXBaak96U3JGdkx6SUlpYlFhazdwL2tHZVF1a2ttLzZmQUdDZFJ4bEdS?=
 =?utf-8?B?bWxrTWpKU1F5VzhFdkcrd3cwVHpPMmt4bm5FamQ3cTZLTXhBMjBMUVoxbkx5?=
 =?utf-8?B?dXZZVlQ0alc5WkFSUk9WL043V2thWXc1c3pUSWR6bjcxZVpKampIblpQQXRv?=
 =?utf-8?B?eEdBR09Rcjh2SkI4bzByTlVvNGdQdlpaUzZVWDRvVXk5ejFOS2RrMlVMbE9q?=
 =?utf-8?B?OVcrRDgyY0I1RDQ3d1pUNWlFa3JlTEkyZk9YWkRrN1pCMDFMQUpZam1zYlJI?=
 =?utf-8?B?eGNNUzUvTUNlM0ZaazlmalhUTVoxLzZaNmlXZzdqSzhwL1RxdlEyalEydHZr?=
 =?utf-8?B?V0gwNGdIWGdtSWpWMlR3L2RFaFRFK0ZoZWVLbEtEY25UYUJpdktIZU5Ta1dH?=
 =?utf-8?B?REtFc3NSY2R1U1pETjIvMUFYU1ViWENPSEh6WjdudEFIbm02VUp2cENTVTdj?=
 =?utf-8?B?dUxrWDk0K3l2N1NROTZwVC9tM3ZSb0lRa3pmTjE0RFBaWXo4YWtvbFBsYUxY?=
 =?utf-8?B?UU84eU5mSXpCdUF1Y2NIenlXYWh3RDBsTS85VjZ4azJGN2NGejcxY1VmbXY1?=
 =?utf-8?B?MWdaeTIvdFZ6bHVSZUJxb3ZEU3k2SnJ1aDk2UGtvTU9XQVptQzhJaURCUzh1?=
 =?utf-8?B?bUhFdllGdUFQTlZ6Z0pYVmEwak96eVdHNFFUZ2RNcHEzL3Y4ZjlrNmZPQWt1?=
 =?utf-8?B?UEJwTzdtTWRlUFVMa3RaSkxQUkZtWTlKVW5XRi9tNWJ2enNWWGcxNlpwUS9w?=
 =?utf-8?B?T3pzbkE0a0JXR1YrSlp4M2ZqVm9ZZ1cxbjRMQ2FXY1pBN1RlR3FKVWNYQ3FZ?=
 =?utf-8?B?OHF6eWlBbDlZb3dYYldYQnVvRVRYczFUYjFCK0FiY3ZTbFNYeEpqV3hndG8v?=
 =?utf-8?B?SWN5aHBtVWRqTVFzT2FJWnNOQTFRdWorRm1sOTdzM2loQS9hODFDdzh2YnRt?=
 =?utf-8?B?RGxTcG55a3VOY1lmUzNOK1Bwang4dnVVVWFsMmpTUVNEaHd2aHZGMFdQalcx?=
 =?utf-8?B?TE13VHhHNjh0YlB0ajh1eE1zdFRlL2pQbHJ3UFdQbGhXUTlqVkxjRzAveUxC?=
 =?utf-8?B?ZURSNzR1S3pSTWh3WndFZUVGeVlteW5zT3JlLzRrV20zZUlBeStMSmswbVE2?=
 =?utf-8?B?SXZ1RWp3b1FkZDNIQjVYdUlQcUR4aGN2MzdEUEJGQXJkMlF5UHd5TE9sR2dp?=
 =?utf-8?B?eWxPK21xNUh3cWc1MW9UWnBYTkJ1dFV3NkhuZmJOdzJqU3l6OUkwN2JLb0Qx?=
 =?utf-8?B?QWplMzNVZ212VDE5NzRqekRTOFFqdTkxYVcreHI5YWhMNTFpdFZOS0JFdEdG?=
 =?utf-8?B?SyttZ1RYdUtGMU03U0Y4bGEzUTJjekdvQm43RFEycFlIeTJWSlF3T3FSaE00?=
 =?utf-8?B?MU9nSnVSY1p2a0hQZHNKay8rcWJwK1hJU3lZSzQrUHpCN2VEekl2bmszSUg5?=
 =?utf-8?B?WXlCZm9GUGZXZFQ3M0liY2tLZzhLZGV3QnpXRVpaUEhCL1EwcjJ5Z0U1bkRP?=
 =?utf-8?B?SkJtMzR5aTVKazBFTDQ3dWpkZ1BSYk1CWlZMbTdkcFNjZUtEVkVHVFpUcXNk?=
 =?utf-8?B?SU0vWStXZGxraXczOXVPelA2WWVKL0s5aFhKREFqaFkrTzBlNlRFeFN5Zldy?=
 =?utf-8?B?bVA2ZXlWWGNsV3dkZlhrMkNnZnRHTHRWTWQ1QStleXIvcVp6ZDR6MmdmenBR?=
 =?utf-8?B?ZW42Nk0raG8zUUdoQVl1YzU0cmV6QkZKV1VmYzEwZkFwU1dyUkFsMGUraUQv?=
 =?utf-8?B?b1FyN2J2VlE4R242NjdWZTBmbUdRY2ZtUmVTblp2RTlGM2k3R2dPOGh6V1lV?=
 =?utf-8?B?dHIzTzRucnExdjRSMDRBSmRCTXo2azA5cDJYZmtIQlN3Szc5SVc2bkVEbGZl?=
 =?utf-8?Q?kaJN0qKi5n4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDBOaGZSODd2cTVTaTZKWDdWcU1LdFlPM3p3dTd6VnMwK0hvUk1Wc21JOTNk?=
 =?utf-8?B?VTRLUVphTDY3STloOEZKNDFma2tWdzNxTVhJR2dmd0p6UVN2SjRGZUpoUkdL?=
 =?utf-8?B?SXlndUxzM2M0VUNGSXZZaTVtZ2ZGVDY0UHNaVnpoUmFEQVRMc3NESWJRZXVG?=
 =?utf-8?B?TjFPQXc0TGRYeFhpR2NXeE9pRG14RThLbW90QWpaNE9NWTRsdlNlRFl5Ly9q?=
 =?utf-8?B?ZXhHd3pPWnFGNHNvdkdiU2h4bXNwMUlqMTJucVZ4cHlyK2hkUE42dHZKclor?=
 =?utf-8?B?WXR5N3dRRWtLdEF3Wi8zRDlYRXZxU1B1eU1acTd4WHVrRmkwTWFNR2RNWXNE?=
 =?utf-8?B?dXV2cVREOU9XR2UxNENtN29HdXljSkJ3bUY2ZHFuSm9SeFQ0VlFvNWI2UG9F?=
 =?utf-8?B?VEU1RU5WYmFpR3NnSWJ3NTk2NGVmVVVIUGJ0YVpnUkttVVQ3cTBoczZvMms4?=
 =?utf-8?B?WTF0cldMK2hJUGNsYlRNRUZYajFXSjdIM3hoTSt2cWgreWlyWkk5SklFTzdU?=
 =?utf-8?B?bktPQmVkVk9EMjZQb2o0bWxLN1Jidk02TmQrb0UyNFRzVHBmMytFSGdJOVJa?=
 =?utf-8?B?RkYzQVgzR0I2U0RlVWM3bDFYQmN5djNTR1lmR1g5Ky9ibjNUaTlqVXU0UlA2?=
 =?utf-8?B?NlhaSmkxVDVMQkdPeXhLRTVuS1czRGk2eFJ0bThXNmZoY2VyMVNnOFFtU2Ro?=
 =?utf-8?B?eTdRQTBxdTVnalArMDhBRHUrSnRPeURXTlBnNUFiUWNJNTM5RjNQTnNuV09i?=
 =?utf-8?B?VFE1VEwvcFBjMHc3UnR1L2VyUFFoc3o0VUFZNDdaN3RmYzAyZGpZcHVtMUZ3?=
 =?utf-8?B?V0RpR3BtMW1Ca0pYYnI3Y0xwcDkwUFJhNmEzMWFqcHJmbWM0QWh2b2dmTlVy?=
 =?utf-8?B?NThIVTJNT1AxMXgrTCs5azNNVGJraHBvU0ZGWkR0cFhmSmhkQW1DQkNOZUt1?=
 =?utf-8?B?U2tuOHZQVHdPVmJBQkY3c1lpTnc0N0ZDK2xuU1hKYkFscmM2TlNmeTEwNC81?=
 =?utf-8?B?cThpZTBnb08wN0VMbnVIQVBoRG0xVTd4TmlJdGZqWnIvTWIycU9jcWZDOVhG?=
 =?utf-8?B?QWVsNzJQZkk5UUViOXJoamVpcG1DT09iL2FCejJjYitBWlBVbEU2YVZvOUNY?=
 =?utf-8?B?YXVoOFJneHJ4a2FOZTJjYTN6cmZTYmRyY29MUW9yeERyVVNpazY2a29kb01I?=
 =?utf-8?B?N1E3WUxCb1pCY2tsK2EvaXJkcnN5T0dnUndQaTNVc2kvbHlwOFQyeDdycnVp?=
 =?utf-8?B?SkozQnE3UnJZNkh6VWtEZWx0Z09Bak5hb1Rjd09USGlNYXE5TFZUNC9wcEdq?=
 =?utf-8?B?RnNLY2hXVkwvYXd6VXlMVnN2ckp4S0JBNVpVNHFFeUR0WlBEc0VWUnB3a1NJ?=
 =?utf-8?B?dEhaQkwxcmdzYVFiM29vc0FCUXJDL3ZqbllCY2loQ1dtYnhkM0EwR2lVZndF?=
 =?utf-8?B?SU5PU1h1VUFkc09uUmJCeHZianZDUEZzVldPa3EvNGwxU3I5OE5zWjlrWCtS?=
 =?utf-8?B?V0VqcmJXVjV3YWpmVWw4cTJaTGU5NmJ2V05RSjJjS2EyQ2dRT2E5WUFaU2xO?=
 =?utf-8?B?VG9wUFc5aG5sNlVmeHF4aDdCR3lkOE5hUmoxNU1ZMXZRNlJKaEcrZkJESGxz?=
 =?utf-8?B?aUd4WWs0K2ROeEwxNDFnUERnaVRWZng0NW0rdExIYVVvWjVaNGF5djhXOU5E?=
 =?utf-8?B?MnI5MHBZNzFBSk9kWCtTWEI2ejN2eGl6RmJiT1J4QUEwRUtvNkhDK2VMMGM0?=
 =?utf-8?B?TmR6VWxJcEUzVVZzSk0vUnpQODU0dWJzbGJnYlZpbjdNdTlOSk1SY3FYa2Q3?=
 =?utf-8?B?VjlEa0xtN1FzVU9SMHA0ZVpHODJScEdjRlhGTlRiZ1JNMTUwYU82MG9DbmhD?=
 =?utf-8?B?ZEZDWEpyL0lzWXlXay9EZnk3UXM5YXUxNUh1SCt3dVZmV1cxekxwekdWRzBV?=
 =?utf-8?B?TXhuWStxc2t3NXRTU3ZENXplQlloS29MQk5PVUoxR0hxejRtSytRcElpQlcy?=
 =?utf-8?B?OEpPOTg1SnZNclB6VVZJZTN6V0lHRURtdXJoTGR6ZThiQmRMVm9RY1U1UmxQ?=
 =?utf-8?B?ZjREMnFvN3U1SXBLQjhUT0dOZWQ0YjErOTNOd0tySnJkb1RjR2hJcmM2L2o4?=
 =?utf-8?B?Mm1TdGdZbEFOR0llQ0NEMFNJRjZkZkxsUU03dkFOd09RNmp0UGNNWVJsNjB6?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fec5babf-506e-4a42-8c89-08dde9f83920
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:10:47.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZtl39g5N5osAFlOBKnMpOOSjvNtrW0/Bd72NGxhwxNkIO11zo3qWPqYTrsY3Vvm3C16P1Y9VResdSwZpqBWZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
X-OriginatorOrg: intel.com


On 02-07-2025 16:38, Rafael J. Wysocki wrote:
> On Thu, May 29, 2025 at 1:14 PM Badal Nilawar <badal.nilawar@intel.com> wrote:
>> From: Anshuman Gupta <anshuman.gupta@intel.com>
>>
>> Implement _DSM method 0Ah according to PCI firmware specifications,
>> section 4.6.10 Rev 3.3., to request auxilary power needed for the
>> device when in D3Cold.
>>
>> Note that this implementation assumes only a single device below the
>> Downstream Port will request for Aux Power Limit under a given
>> Root Port because it does not track and aggregate requests
>> from all child devices below the Downstream Port as required
>> by Section 4.6.10 Rev 3.3.
>>
>> One possible mitigation would be only allowing only first PCIe
>> Non-Bridge Endpoint Function 0 driver to call_DSM method 0Ah.
>>
>> Signed-off-by: Varun Gupta <varun.gupta@intel.com>
> What's this S-o-b for?
>
>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>> ---
>> V2(Bjorn/Rafael):
>>    - Call acpi_dsm_check() to find method 0Ah supported
>>    - Return retry interval to caller
>> V3(Kuppuswamy)
>>    - Add NULL check for retry interval
>> ---
>>   drivers/pci/pci-acpi.c   | 87 ++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci-acpi.h |  8 ++++
>>   2 files changed, 95 insertions(+)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index af370628e583..87f30910a5f1 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1421,6 +1421,93 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>>          ACPI_FREE(obj);
>>   }
>>
>> +/**
>> + * pci_acpi_request_d3cold_aux_power - Request aux power while device is in D3Cold
>> + * @dev: PCI device instance
>> + * @requested_power: Requested auxiliary power in milliwatts
>> + * @retry_interval: Retry interval returned by platform to retry auxiliary
>> + *                  power request
>> + *
>> + * This function sends a request to the host BIOS via root port ACPI _DSM Function 0Ah
>> + * for the auxiliary power needed by the PCI device when it is in D3Cold.
>> + * It checks and evaluates the _DSM (Device Specific Method) to request the auxiliary
>> + * power and handles the response accordingly.
>> + *
>> + * This function shall be only called by 1st non-bridge Endpoint driver
>> + * on Function 0. For a Multi-Function Device, the driver for Function 0 is
>> + * required to report an aggregate power requirement covering all
>> + * functions contained within the device.
>> + *
>> + * Return: Returns 0 on success and errno on failure.
>> + */
>> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>> +                                     u32 *retry_interval)
>> +{
>> +       union acpi_object in_obj = {
>> +               .integer.type = ACPI_TYPE_INTEGER,
>> +               .integer.value = requested_power,
>> +       };
>> +
>> +       union acpi_object *out_obj;
>> +       acpi_handle handle;
>> +       int result, ret = -EINVAL;
>> +
>> +       if (!dev || !retry_interval)
>> +               return -EINVAL;
>> +
>> +       handle = ACPI_HANDLE(&dev->dev);
>> +       if (!handle)
>> +               return -EINVAL;
>> +
>> +       if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4, 1 << DSM_PCI_D3COLD_AUX_POWER_LIMIT)) {
>> +               pci_dbg(dev, "ACPI _DSM 0%Xh not supported\n", DSM_PCI_D3COLD_AUX_POWER_LIMIT);
>> +               return -ENODEV;
>> +       }
>> +
>> +       out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
>> +                                         DSM_PCI_D3COLD_AUX_POWER_LIMIT,
>> +                                         &in_obj, ACPI_TYPE_INTEGER);
>> +       if (!out_obj)
>> +               return -EINVAL;
>> +
>> +       result = out_obj->integer.value;
>> +       if (retry_interval)
>> +               *retry_interval = 0;
>> +
>> +       switch (result) {
>> +       case 0x0:
> It would be better to use an enum for the possible return values.

Sure I will use enum, something like

typedef enum {
     AUX_PWR_REQ_DENIED               = 0x0,
     AUX_PWR_REQ_GRANTED              = 0x1,
     AUX_PWR_REQ_NO_MAIN_PWR_REMOVAL  = 0x2
} AUX_PWR_REQ_STATUS;

>
>> +               pci_dbg(dev, "D3cold Aux Power %u mW request denied\n",
>> +                       requested_power);
>> +               break;
>> +       case 0x1:
>> +               pci_info(dev, "D3cold Aux Power request granted: %u mW\n",
>> +                        requested_power);
>> +               ret = 0;
>> +               break;
>> +       case 0x2:
>> +               pci_info(dev, "D3cold Aux Power: Main power won't be removed\n");
>> +               ret = -EBUSY;
>> +               break;
>> +       default:
>> +               if (result >= 0x11 && result <= 0x1F) {
> if (!(result & ~0x1F))

This will pick result = 0x10 as well, that's why checking the range 0x11 
- 0x1F.

> I think, and it would be better to use a symbol for this mask (and below too).
I will add an enum for the retry interval range — something like 
AUX_PWR_REQ_RETRY_INT_MIN and AUX_PWR_REQ_RETRY_INT_MAX for 0x11 and 0x1F.

>
>> +                       if (retry_interval) {
> This has been checked already and is guaranteed to be nonzero at this point.

Sure.

Thanks,
Badal

>
>> +                               *retry_interval = result & 0xF;
>> +                               pci_warn(dev, "D3cold Aux Power request needs retry interval: %u seconds\n",
>> +                                        *retry_interval);
>> +                               ret = -EAGAIN;
>> +                       }
>> +               } else {
>> +                       pci_err(dev, "D3cold Aux Power: Reserved or unsupported response: 0x%x\n",
>> +                               result);
>> +               }
>> +               break;
>> +       }
>> +
>> +       ACPI_FREE(out_obj);
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
>> +
>>   static void pci_acpi_set_external_facing(struct pci_dev *dev)
>>   {
>>          u8 val;
>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>> index 078225b514d4..6079306ad754 100644
>> --- a/include/linux/pci-acpi.h
>> +++ b/include/linux/pci-acpi.h
>> @@ -121,6 +121,7 @@ extern const guid_t pci_acpi_dsm_guid;
>>   #define DSM_PCI_DEVICE_NAME                    0x07
>>   #define DSM_PCI_POWER_ON_RESET_DELAY           0x08
>>   #define DSM_PCI_DEVICE_READINESS_DURATIONS     0x09
>> +#define DSM_PCI_D3COLD_AUX_POWER_LIMIT         0x0A
>>
>>   #ifdef CONFIG_PCIE_EDR
>>   void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
>> @@ -132,10 +133,17 @@ static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
>>
>>   int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
>>   void pci_acpi_clear_companion_lookup_hook(void);
>> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>> +                                     u32 *retry_interval);
>>
>>   #else  /* CONFIG_ACPI */
>>   static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>>   static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
>> +static inline int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>> +                                                   u32 *retry_interval)
>> +{
>> +       return -EOPNOTSUPP;
>> +}
>>   #endif /* CONFIG_ACPI */
>>
>>   #endif /* _PCI_ACPI_H_ */
>> --


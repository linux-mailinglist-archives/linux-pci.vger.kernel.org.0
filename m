Return-Path: <linux-pci+bounces-22034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A7BA4013F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 21:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18CA019C13EF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 20:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C412C200114;
	Fri, 21 Feb 2025 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdTuhPAo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DF01DC985
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170556; cv=fail; b=kZIJ6BBYlhBTPsB3igwsmJb6ApwkGv8gd2HEf4Dbw+uEG4zEpaD4xBDron91vot4d7HUYhKrV4KWQBFWxZioTkvir0hER+ltLWD699HPMmR63C9xyNQHe7qmUVzZPrbtEExj7aBEP009L7Mj+VTBeAtptMyMnQjecEvJfSZSV0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170556; c=relaxed/simple;
	bh=8333mn2HfMEJJRMv1NnKh5fgDM+/jv1EESEfbFI4GUI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CtkYYUYh/+k35qV3jg0B09epK2+EMCAcIztp1jGhzZsan3Go7KtraNRrcP/yVuZB5DqVg6LFsrlXBlZEufLsVZKg27Whzki1MXO44PHG1xVUTcQNUslxFj4Iw62VpRUOWB+ppESODQcb0V2bvhCcKbunn/oP6EbRDJx8UF9hQXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdTuhPAo; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740170554; x=1771706554;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8333mn2HfMEJJRMv1NnKh5fgDM+/jv1EESEfbFI4GUI=;
  b=JdTuhPAoBZaaU6axrk0k5XIKDKRN6XpVJQr1DNhs017x4JqEaVUTu8BD
   7EaVjTpE9YfLHY/6FAuAJlk+2ITMS4Btd7pCr02JXOk/r7uiU4zp7ORBD
   WRY3+TQKeq6MitYWhBlrFhW9FOxOikxGAoj7dXde2cf5YEfqmo+I3tFtf
   ItCi/LTuH4OUDOHdgp3Y858a2/mHMpd8Y1MDB/Q+nrxb+etFTtBO1aox6
   B7H72yCuWuQHLaxyPW3snsVZwa7u9U/MSWm/cdQ0tz58N7+2xiC8t4Kh1
   ox3Zenau3sLpxS9W2he8WwTHZt9Nyychh3xTweImiQgP1EReHR8jec9K1
   w==;
X-CSE-ConnectionGUID: MbNEAaLaRVmgTzz5yzTDGg==
X-CSE-MsgGUID: sCdzDYc4QumPyH85HuBUHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="40192790"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="40192790"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 12:42:33 -0800
X-CSE-ConnectionGUID: g0aob+0UTtKiOcvPKNLnPg==
X-CSE-MsgGUID: CSTSMCl0QE6T9Sekc18Osw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="120097523"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2025 12:42:33 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Feb 2025 12:42:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 12:42:32 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 12:42:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEAy76Biy4fLd3cZGaNnBfNfcWosJLp7zdJVjZlr7W9UHox+DpXkDnWQxOaIASakzMlP9LjFwfb28Zv+g4vGo3y5klMssQpFbkx+cOJ3PQPA9crvJqUpOfa8eOQx+lDRskVrEfj71rbIJDZj6aaIveXJOC4IGbO1Qr/TSZEDPOng1DBgxSI5uqjo6xq4AuxTFZo6hvcQj1ixuPcghf7yr9H7fRsNELaidBBpWgzfH1uPx7CXKX4CbI5wlvGPmPSolDOB0gvWz8hgyiH8KZ0/dOU8CjSAHbAagZ6dX6d4ebIpO1YhaoIDgmEMYXIXQrDhT28QvH8RLbEgQygaO3aklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngRDkI1Jz4L5Lnz8Hf/FeF4TDtGJkfHbyifEYpnZVnE=;
 b=QDnFdfdJWVxgQe9pWOBJI6cOuuPQIetvR2To4XsfF5HhkroJkAy5D14Rz7ernoEYY9dalOJVXcXq+fD8XGel+av100rMfUEc6E8KqLYPFktZhYBpQhzedwvO3gvguk20CyEBnqBLqua5uvdb6OlEWlZ7lUC9KzX7J1pD2+10OJFsTCYoQbCzCoYY8NOaBbhoUgmStf4xKkVnA/PPLDhSQOqp9l9eF9aZBverxT86WpaCCJzO92d+/K8ztvjYqabx4laJEQgdC8rSOVyK1tfbHbBzAyIAAMtRhzdySloPoPtW/xj1W2HkCH5JMD87o3evJGBroglvSBFT3L9GMvWdlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 20:42:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 20:42:29 +0000
Date: Fri, 21 Feb 2025 12:42:26 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <67b8e5328fd41_2d2c294e5@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
X-ClientProxiedBy: MW4PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:303:8d::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e26d9c5-7f51-4e20-8bb5-08dd52b841c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0W7mEHxkNMG/5Uv/wWGOEnOdNelIhRhjDyd+eIHYWuPFOmfywDsCnWZxWkPY?=
 =?us-ascii?Q?D4AjPu22V9/CfyDJKPtVXTirKjIpKRcbQ5wUY5yQCSLLCiyeB7r+P8ncj7qe?=
 =?us-ascii?Q?xvG2CfruBJZrmkcd3KR9/kA6Q92OaA3Na5P99ThUNSvD41Q0OgefJx6Oq/S9?=
 =?us-ascii?Q?4XLI1j6/oDT2hpWt8clYiEmhS6ovCd+3pAJ67yge1beBxSDlCXIrW3kWLzHm?=
 =?us-ascii?Q?8p4/PJczezsW2KOVvjW4V9dc3+exq6ZwFDoHrSXaQ200ScRuOrB4Ojbvc1mw?=
 =?us-ascii?Q?eOhmbuvxpzcaxc30HfFq2IaHdfJKjH5wK32ktMwIdib9/Y19nP5f5TYsI3/m?=
 =?us-ascii?Q?x4lZ0QkCbduSNNInF9Q5lxVcfIqtAapLCEsx9YH8Qppyunf62v1MdR/Ps3yd?=
 =?us-ascii?Q?PAIc4ADkjZd7wrUPbKioZP2yXIORWPT5TZsjDH69QqXZ2o5wpPgKBuXFfqxP?=
 =?us-ascii?Q?DS3bmBIopwH59XRAZNCq7he0YmxR2/wUn7xezaavdCoBBTtfNUSEO8NcgqYa?=
 =?us-ascii?Q?gndqXPWP0x04XjVShr+J3EplDCBrNY2svA7XJtt5eDBXi6pJHPPPFzcR3XBO?=
 =?us-ascii?Q?KiXu7I/m3QrmCFWylbuO+d4kON1FrUWFxJhFeYNjwkz5ayRTSZ5aLltppFcN?=
 =?us-ascii?Q?TQ/qIAYkLDKg4V8nIznFlHiiNiwsukI/vOgHv5a9IutTfBlhJ4G5cA88EfKD?=
 =?us-ascii?Q?+BoAyB/82nut0ItC1eknGnhb9kfFj43KYMfuP764sSn3teNXhEwcMLg9X48X?=
 =?us-ascii?Q?s+jvYk8Vw+68W7AWmbLPvHAXxUjCwk4pU1swZB4XuSUtE3L6EnXVOoGoTcDV?=
 =?us-ascii?Q?Zahb5aGbqcsS+CH0HaMaFqsb/iI6w4Hu815taUFVv9xC/B/cO7YP1NTxDzHc?=
 =?us-ascii?Q?R7xZHySErwY/EqD2p7l+RK5DKyPqokbxUbUnzcuiVVQh4XHXvHWD3s+bpZnO?=
 =?us-ascii?Q?7dYiiobe20DE6OtrzqM6Wp+/2aeeEgVgYSG1r1G3ysA8X+x+1OCkUMVuXTsQ?=
 =?us-ascii?Q?Y6uVsLrOYQUuKCly/As7l95qiARbRNgPwHjjO5Y87xVdxCB6dHKigba9z/HD?=
 =?us-ascii?Q?yccAuGZmLxrRQU2B66r39X50eoH/+YxFzv5xPOPdrw/hwjvsx2l1A3kuD5rS?=
 =?us-ascii?Q?l2ZGa8kVycwtPoUvTF/41In84BVbQv7k8xjRjNUr0iV9sMFE/Ry9p7p+8bxa?=
 =?us-ascii?Q?IWmuSdRUsAlBlD4NiSNIoSU4BO8iIdKxoQErWIVOGFcMeMoi23wBKd+q+DVW?=
 =?us-ascii?Q?YR4s5+UUe6F7vjob1TQtWAwI6tcIcYAqsqKws5weXdst6PbhlmOZjwab8lyR?=
 =?us-ascii?Q?htL+ApZipxnefhXUbTuZRnkl36XEs8diCiYm+sjw+L9Rpyz7W/XF1Z3uR8FN?=
 =?us-ascii?Q?C9CBaeHmJM/J32uPI5y9p4VK1ZsW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jvvuzzg0PGiX6/F/ENbRlBRNEvs/Zl+8mBYFxAxKG2jnWntq1JsAFHMG9TgI?=
 =?us-ascii?Q?tTrbbOVeBMXtd73LwAB9j1JGwigTC0hSzXD4UpexO/kMAw5JCBoWHO2JRW4A?=
 =?us-ascii?Q?26Cft/nYC1pbZ3Ukgk0FYI0vjXtslDt16CFaoRO9wUBydlg7i9fnda6RaOPu?=
 =?us-ascii?Q?tJdUg7w5x/CYDhwFr0hcBTFoLj22oz09NMAp3Zb5swj/ONJ40ZU/3Dbe9Iv6?=
 =?us-ascii?Q?/up/m6BFGXqlwRktzYRcPkDIXWU+b3LCjs0Tz2nQ059X+5tzCi6fvW76x+B5?=
 =?us-ascii?Q?qTM5MS7VZafu7034K//eUs0m9LZtGiIjVLPUyJv1tOmUyMf6ZljI6W5NO8B3?=
 =?us-ascii?Q?WpqPAfszYxvmK0ti6bg56FflP5Nwz8aDD40g/eGyoYrdL09FwPfP/3DoToTQ?=
 =?us-ascii?Q?zc3RteHegTiQV1bYkMkeeq8guYzl3oCx00ELQE0MT8+XdW0mp3uHUKVJF2NH?=
 =?us-ascii?Q?tgQW7DqXgxxdSWWrstD9/1IVWkdLyaJiFQ4SDL7OpeKpWf4MSzg2+CIOhIO5?=
 =?us-ascii?Q?4O17HirbUSY2Jc+tqQGbUTRI6yYuFMS7r/1E0E+3ozaYMLuvoXy+F+wjFTDh?=
 =?us-ascii?Q?ZFpx//JHIpqbdau64olU0RsIGGBC7CjKWtMLvN1/Iv1YHcjXkgE5v74LazJ3?=
 =?us-ascii?Q?/JaYS3w2WdB6E57xTiCp/SKnps1GJq+OScIqnVyVQj0cd1PoWN06Qpe86Ljl?=
 =?us-ascii?Q?Lry85lRCtIGsdVGNCoyloqtN8Nyyb+ckdi+Uow/i0y9DPVSFUFBzHQQoFIdI?=
 =?us-ascii?Q?6mK2Dz5+V2/2IExB/tqh4oSwysSIe5iK7aBSmzuDlBM0u4nU5xhHscMZCubh?=
 =?us-ascii?Q?3w2yYzKQ7nbJ0AIvusK8LpX/eg3THvAu73E3Kf9spAYGeMFexXn5jCHN8kmv?=
 =?us-ascii?Q?isXFXoadpuhRS81Rdvc2WlxpR8GscEeip0cE2Jfbv0eBtfnY3uABeZq+NUB3?=
 =?us-ascii?Q?YrUpKvIfRlBDH2dOdv7uQ34FPsPLDjdMsQWGal1PtlSXci2UzbVF/hsgCjtO?=
 =?us-ascii?Q?bxP3ci6uMiaQcT+rpCf8tltfzC67pEt2IlhKp5lHCNNSOI/7AfQUSazym0ra?=
 =?us-ascii?Q?aVlTTMFzDG+DQ7gBJe47fwww10wnADKlXqaBurDqyZBGWIxWgLaRRIGPkiXe?=
 =?us-ascii?Q?GcAXgcegLQVOO3tOqZ4t9MGg715I817PnfszZ0xmlkKYP9PEgucIWvzRTblk?=
 =?us-ascii?Q?VzkKnLcBdK0KBzIMfaQIi4qqCajwIljpI8aHz4jsBgC47g4ymv7lYynO73r4?=
 =?us-ascii?Q?9n5pkNCpaFwKryhRgjIblGPCzy5EjY7/JqDvj/lrhx8I/XCbqRtXEzcLlEGP?=
 =?us-ascii?Q?BaPzR5vJ6mk6QGC4LKAgQdLiqxlNNXxs5P4ov/WgaFQki97EJGXDYfRiabis?=
 =?us-ascii?Q?yDyseoIafpWdTYxMWTN4BkAKwCECryq9MK6enyJArs3kVgrJ0EDif1JC+Flu?=
 =?us-ascii?Q?4/12Gz3VhmY/WEKEfuoMydCZLV1X2QK/U5JsfVUv59lrJi/GS0NdDZUfxtWr?=
 =?us-ascii?Q?cqYlH0vy8RXqtIY1/D4A+vGLSyj6X8zM8mq/oV8DIvdQ4zkLZrBADC+2b4Fq?=
 =?us-ascii?Q?FTcUddAqpgafryeD01HxArchpjf+aVN0q72wdxMVSEpzb2mOwov21GWd46VZ?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e26d9c5-7f51-4e20-8bb5-08dd52b841c2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 20:42:28.9397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8oPwNtlF2BPlfrgaETCa2qfVnYZHV0qlM7vWoNjhjJhJwOJ6ZwzRe66+aIDBCOfVktoy000hI+uXUFic8S5i1LHTv5S+yDVeder2bSc+IM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6238
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> On 6/12/24 09:23, Dan Williams wrote:
> > The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> > Environment (TEE) Device Interface Security Protocol (TDISP).  This
> > interface definition builds upon Component Measurement and
> > Authentication (CMA), and link Integrity and Data Encryption (IDE). It
> > adds support for assigning devices (PCI physical or virtual function) to
> > a confidential VM such that the assigned device is enabled to access
> > guest private memory protected by technologies like Intel TDX, AMD
> > SEV-SNP, RISCV COVE, or ARM CCA.
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
> > to pci-sysfs. The work in progress CONFIG_PCI_CMA (software
> > kernel-native PCI authentication) that can depend on a local to the PCI
> > core implementation, CONFIG_PCI_TSM needs to be prepared for late
> > loading of the platform TSM driver. Consider that the TSM driver may
> > itself be a PCI driver. Userspace can watch /sys/class/tsm/tsm0/uevent
> > to know when the PCI core has TSM services enabled.
> > 
> > The common verbs that the low-level TSM drivers implement are defined by
> > 'struct pci_tsm_ops'. For now only 'connect' and 'disconnect' are
> > defined for secure session and IDE establishment. The 'probe' and
> > 'remove' operations setup per-device context representing the device's
> > security manager (DSM). Note that there is only one DSM expected per
> > physical PCI function, and that coordinates a variable number of
> > assignable interfaces to CVMs.
> > 
> > The locking allows for multiple devices to be executing commands
> > simultaneously, one outstanding command per-device and an rwsem flushes
> > all in-flight commands when a TSM low-level driver/device is removed.
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
> >   Documentation/ABI/testing/sysfs-bus-pci |   42 ++++
> >   MAINTAINERS                             |    2
> >   drivers/pci/Kconfig                     |   13 +
> >   drivers/pci/Makefile                    |    1
> >   drivers/pci/pci-sysfs.c                 |    4
> >   drivers/pci/pci.h                       |   10 +
> >   drivers/pci/probe.c                     |    1
> >   drivers/pci/remove.c                    |    3
> >   drivers/pci/tsm.c                       |  293 +++++++++++++++++++++++++++++++
> >   drivers/virt/coco/host/tsm-core.c       |   19 ++
> 
> It is sooo small, make me wonder why we need it at all...

I expect it to grow as more common cross-vendor host TSM functionality
is added.

> > +static int pci_tsm_connect(struct pci_dev *pdev)
> > +{
> > +	struct pci_tsm *pci_tsm = pdev->tsm;
> > +	int rc;
> > +
> > +	lockdep_assert_held(&pci_tsm_rwsem);
> > +	if_not_guard(mutex_intr, &pci_tsm->lock)
> > +		return -EINTR;
> > +
> > +	if (pci_tsm->state >= PCI_TSM_CONNECT)
> > +		return 0;
> > +	if (pci_tsm->state < PCI_TSM_INIT)
> > +		return -ENXIO;
> > +
> > +	rc = tsm_ops->connect(pdev);
> 
> I thought ages ago it was suggested that DOE/SPDM loop happens in a 
> common place and not in the platform driver implementing 
> tsm_ops->connect() (but I may have missed the point then).

That's still the plan, but I would expect that to be a common helper
that TSM drivers can use and does not need to be enforced as a midlayer
detail in pci/tsm.c. We can add that to pci/doe.c or somewhere more
appropriate for SPDM transport helpers.

[..]
> > diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> > new file mode 100644
> > index 000000000000..beb0d68129bc
> > --- /dev/null
> > +++ b/include/linux/pci-tsm.h
> > @@ -0,0 +1,83 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __PCI_TSM_H
> > +#define __PCI_TSM_H
> > +#include <linux/mutex.h>
> > +
> > +struct pci_dev;
> > +
> > +/**
> > + * struct pci_dsm - Device Security Manager context
> > + * @pdev: physical device back pointer
> > + */
> > +struct pci_dsm {
> > +	struct pci_dev *pdev;
> > +};
> > +
> > +enum pci_tsm_state {
> > +	PCI_TSM_ERR = -1,
> > +	PCI_TSM_INIT,
> > +	PCI_TSM_CONNECT,
> > +};
> > +
> > +/**
> > + * struct pci_tsm - Platform TSM transport context
> > + * @state: reflect device initialized, connected, or bound
> > + * @lock: protect @state vs pci_tsm_ops invocation
> > + * @doe_mb: PCIe Data Object Exchange mailbox
> > + * @dsm: TSM driver device context established by pci_tsm_ops.probe
> > + */
> > +struct pci_tsm {
> > +	enum pci_tsm_state state;
> > +	struct mutex lock;
> > +	struct pci_doe_mb *doe_mb;
> > +	struct pci_dsm *dsm;
> > +};
> 
> doe_mb and state look are device's attribures so will look more 
> appropriate in pci_dsm ("d" from "dsm" is "device"), and pci_tsm would 
> be some intimate knowledge of the ccp.ko (==PSP) about PCI PFs ("t" == 
> "TEE" == TCB == PSP). Or I got it all wrong?

I typed up a long reply only to realize I think this can be made simpler
by only having one common context and drop this subtle 'struct pci_dsm'
distinction.

So, 'struct pci_tsm' is just the common core context / handle for
drivers/pci/tsm.c to communicate with low level TSM driver
implementation. It is allocated by pci_tsm_ops->probe() and freed by
pci_tsm_ops->remove().

A low-level TSM driver can optionally wrap that core context with its
own data, i.e. enforce a container_of() relationship between the core
context and the low level context.

[..]
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 50811b7655dd..a0900e7d2012 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -535,6 +535,9 @@ struct pci_dev {
> >   	u16		ide_cap;	/* Link Integrity & Data Encryption */
> >   	u16		sel_ide_cap;	/* - Selective Stream register block */
> >   	int		nr_ide_mem;	/* - Address range limits for streams */
> > +#endif
> > +#ifdef CONFIG_PCI_TSM
> > +	struct pci_tsm *tsm;		/* TSM operation state */
> >   #endif
> >   	u16		acs_cap;	/* ACS Capability offset */
> >   	u8		supported_speeds; /* Supported Link Speeds Vector */
> > diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> > index 1a97459fc23e..46b9a0c6ea4e 100644
> > --- a/include/linux/tsm.h
> > +++ b/include/linux/tsm.h
> > @@ -111,7 +111,9 @@ struct tsm_report_ops {
> >   int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
> >   int tsm_report_unregister(const struct tsm_report_ops *ops);
> >   struct tsm_subsys;
> > +struct pci_tsm_ops;
> >   struct tsm_subsys *tsm_register(struct device *parent,
> > -				const struct attribute_group **groups);
> > +				const struct attribute_group **groups,
> > +				const struct pci_tsm_ops *ops);
> >   void tsm_unregister(struct tsm_subsys *subsys);
> >   #endif /* __TSM_H */
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index 9635b27d2485..19bba65a262c 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -499,6 +499,7 @@
> >   #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
> >   #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
> >   #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
> > +#define  PCI_EXP_DEVCAP_TEE     0x40000000 /* TEE I/O (TDISP) Support */
> >   #define PCI_EXP_DEVCTL		0x08	/* Device Control */
> >   #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
> >   #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
> > 
> 
> 
> I am trying to wrap my head around your tsm. here is what I got in my tree:
> https://github.com/aik/linux/blob/tsm/include/linux/tsm.h
> 
> Shortly:
> 
> drivers/virt/coco/tsm.ko does sysfs (including "connect" and "bind" to 
> control and "certs"/"report" to attest) and implements tsm_dev/tsm_tdi, 
> it does not know pci_dev;
> 
> drivers/pci/tsm-pci.ko creates/destroys tsm_dev/tsm_dev using tsm.ko;
> 
> drivers/crypto/ccp/ccp.ko (the PSP guy) registers:
> - tsm_subsys in tsm.ko (which does "connect" and "bind" and
> - tsm_bus_subsys in tsm-pci.ko (which does "spdm_forward")
> ccp.ko knows about pci_dev and whatever else comes in the future, and 
> ccp.ko's "connect" implementation calls the IDE library (I am adopting 
> yours now, with some tweaks).
> 
> tsm-dev and tsm-tdi embed struct dev each and are added as children to 
> PCI devices: no hide/show attrs, no additional TSM pointer in struct 
> device or pci_dev, looks like:

The motivation for building awareness of device-security properties
natively into 'struct pci_dev' is the recognition that TSM-based
security is not the only model that Linux needs to contend. The TSM
flow is a superset of PCI-CMA and maybe PCI-IDE in the future (although
Intel seems to be the only architecture that has a concept of allowing
IDE establishment without a TSM).

I understand your motivations to make all of TSM functionality bolted
onto the side of the PCI core. It has some nice properties. However, I
think that is a SEV-TIO centric view of the world. PCI device security
attributes are PCI device attributes and have reason to exist with and
without a TSM. In other words, certificates and measurements should not
be placed behind a TSM ABI because certificates and measurements are
expected to have a native PCI-CMA ABI.

It would be a useful property if software written to retrieve
measurement and certificate chains did that relative to the PCI dev
independent of TSM presence.

> aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm-tdi/tdi:0000:e1:04.0/
> device  power  subsystem  tsm_report  tsm_report_user  tsm_tdi_bind 
> tsm_tdi_status  tsm_tdi_status_user  uevent
> 
> aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm_dev/
> device  power  subsystem  tsm_certs  tsm_cert_slot  tsm_certs_user 
> tsm_dev_connect  tsm_dev_status  tsm_meas  tsm_meas_user  uevent
> 
> aik@sc ~> ls /sys/class/tsm/tsm0/
> device  power  stream0:0000:e1:00.0  subsystem  uevent
> 
> aik@sc ~> ls /sys/class/tsm-dev/
> tdev:0000:c0:01.1  tdev:0000:e0:01.1  tdev:0000:e1:00.0
> 
> aik@sc ~> ls /sys/class/tsm-tdi/
> tdi:0000:c0:01.1  tdi:0000:e0:01.1  tdi:0000:e1:00.0  tdi:0000:e1:04.0 
> tdi:0000:e1:04.1  tdi:0000:e1:04.2  tdi:0000:e1:04.3

Right, so I remain unconvinced that Linux needs to contend with new "tsm"
class devs vs PCI device objects with security properties especially
when those security properties have a "TSM" and non-"TSM" flavor.


Return-Path: <linux-pci+bounces-22059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C01A403F3
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 01:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60508175C46
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D14C1E48A;
	Sat, 22 Feb 2025 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvFnKpy0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3D8C147
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183352; cv=fail; b=jVHxMYZDYdne6YsEc8pL8yD7n5OOZ//TQu0bZINXnf1IshUL2UkSwgq3N0UG7b0SbEA/geGwf/NM8ME83ZdERNx3DdmwL6tKZ0mW/H1PXRfnh3K8zveHLDFoSVglhSDmDsWXSLbc/XruTeIFwpNdF72jREIpQtPLzYnaYW0P2lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183352; c=relaxed/simple;
	bh=P/n+/RDU056vkZTU0t3Lt7SCcIxGb+wMQUy+1oh2p7U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QWt3ungov6YRar5ddJ1B5AqYc2BeGlYCtj8gCrl8aSIQjWeVFGMKWRXFcXQy67jdsQQ1dkqR/c2s81YH4uF+FdEPYHBYn1qg5ecXhn2bnGjHdnfu+7QKR3zI+GQzM5jvujXfNyv10E7vaCjPU6p6a+hRpks8O4y7DWE/zS1q0Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvFnKpy0; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740183351; x=1771719351;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=P/n+/RDU056vkZTU0t3Lt7SCcIxGb+wMQUy+1oh2p7U=;
  b=RvFnKpy01Xrg0HogDeTq7yZHePa6+Qq1BgqK0RRQ3ZjjLrVsZHDRMOkk
   kjOSF85MuuUR+G1AralfvlMiNmuZLpsCbunqwFmN712MMuH636QhQQyn+
   X3sT0Jd9KHG3dq3meX6CR+y1A1EF48lcnCfpo/KxjtgpN3WCL2fbEVABn
   1gq08YOHZJkZfK7cUpu9c+zRd+SaqRGotVZc1NJ5DOC4Mxb/JnCirMdSt
   eNLw774KBiUdE0YQsNvgkKjXhUZE5ngPo143OL6M+OAQfYzUEN+elV5AZ
   ljExUzn47NOsKCnry3//CRXzD6tez/i33mrS4b+17IzY4Gj/oEdOqmAZ4
   w==;
X-CSE-ConnectionGUID: Ll5LLqxwQaOVOHNBNF4Pcg==
X-CSE-MsgGUID: bpouGDTrSvCj/td9DegT+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="58564018"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="58564018"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:15:50 -0800
X-CSE-ConnectionGUID: q23XLoWNRAmOjfdnIFTGOw==
X-CSE-MsgGUID: 7G7sa9drSK6Kgg/r8cmbMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120753694"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:15:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 16:15:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 16:15:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 16:15:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6D0QqhX8net+kuCvSlD/Ttj/lTdxez8ymzUYM2/SPZW+I4ChTt2w11zWKZzuAIa20ZzRvMoOqbhZsMaTl+H+OHhSpjbBnc2ADROxfsc8zNRcAkBFA9SfAfIqiK5X6jLELcq4fBkiKAq7YxJkfVjzoBmRmeATvomNaMRhzZesypXLckSZxAWI8RFUayDW7OMLZJox6aLpeFGYgdLbX1ve1RfYpXg6tQeXjKeTaz1gng7q9a9izKfadMbCqLlIEOQtTQhlo1L3aFaBqLfdL3InmqzS3cvf9bgjE3q3mdoFY/mMKCML75tg//jAS8dowp6Z4As5PP+ut+a2qQUV0O05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmzMOKynPnEBWjwfKyJN5b2gmkuPZKjKT7GZLvVmpkE=;
 b=yI/Trz/P94552GG6U9E7Vla3CKE3/HtJWtnXsCaKmka5k6DAM4rgK7ukYvIvNrRafwxJ7FuB2AtVI5ZO/IiQ60JtemdhGyNE0OQzbBBAEyDrdpfQsBZyDBV5+mDtHidFJFGgCSwQRmQXvo1QeCd6T/ZpMSTiY27cYBD2YaO0r+sxQP8/CSt2N4WSoMejZN+TVVwN5w48NXeg6VvQ09WNl60NiqhiIylL44G8YbhVpbsWtqQwxXAPQLWj7lzsKmxmLYQDEvewKdo2dnjvt7JxzFDc0DmPKgp65ZHYJQ/fIeLx/xDSHLDK8ibcUltbLTys7+NoIj7IqIvt0JYfxorIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8113.namprd11.prod.outlook.com (2603:10b6:8:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Sat, 22 Feb
 2025 00:15:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.015; Sat, 22 Feb 2025
 00:15:47 +0000
Date: Fri, 21 Feb 2025 16:15:42 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, "Samuel
 Ortiz" <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, <linux-pci@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 07/11] PCI: Add PCIe Device 3 Extended Capability
 enumeration
Message-ID: <67b9172eb5eca_2d2c294b4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241210192140.GA3079633@bhelgaas>
 <c7fce545-e369-0dba-fbbe-3d90b67e5cfb@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7fce545-e369-0dba-fbbe-3d90b67e5cfb@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0213.namprd04.prod.outlook.com
 (2603:10b6:303:87::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: eee63e58-f448-4074-db19-08dd52d60e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?hIKKoEcB9lyC19nUuL6cUzS+E7QBK0hhSKfWp9BFGljKUJ2QlnZiJmbxFs?=
 =?iso-8859-1?Q?G+h9R4xDCVlxAeY6wzfntffXPqv5tto3CPo+9xASEeeZcOXnMX7hEFLIOY?=
 =?iso-8859-1?Q?0tr9P9zZkLu3eeO+U6/F+jud8lQYFHDtToapyWvVyyVNsdydkjZhqPl0Yr?=
 =?iso-8859-1?Q?iV/1DEhpZ/gJJhbK4mk/cbO+r2DfB7GJS/g/tb2Kz7VXMvgx3zJrZRZYFI?=
 =?iso-8859-1?Q?AjhH0XcGIu3jvVm13u77EyUva7yV+wfejt3/2Aaxafq61wQ1HRDQTC8URQ?=
 =?iso-8859-1?Q?CzBFCeM41M6Ybsj1gzVTcyDL71+HR/VbM5/E5wre+BawiLz/hCfQnnMyhq?=
 =?iso-8859-1?Q?tg5O/lwQPS3CTUG6n0hwiQ4rCICWYU550uo9GvYwgBHYea1EIsPYRPbgC5?=
 =?iso-8859-1?Q?/seISTYUD0fx/R2sRI6YMoa4i7+8n8GltXg/+UB2nEJMot2EmdYXE+Sw+l?=
 =?iso-8859-1?Q?8fnZplqM35uEmC8pue+67LMH1foccFzT25HORRkXlNP6By/zZbHh9Kf/af?=
 =?iso-8859-1?Q?A7sh2F89dTeLFTng4eY3zEOgXFsKkGTa72H3Vd6jAqUKQAHCvte2IxuHTi?=
 =?iso-8859-1?Q?etjS4yLV4FxgdIL1JOAVaQsB87WbByBhl/vBgXQ2lMKBVyzmOVN3Z2Pywx?=
 =?iso-8859-1?Q?6C0NQ2GOQx/V9plW5EVXt5/G4IbXBKM5znLEomJmzXLnn9F8UNF3ejhB2y?=
 =?iso-8859-1?Q?apEVsGlFPCvwUZlg9xiCJhWUY2YIIeb1sdsdTqoudXzJumgUTPCXbz1+j5?=
 =?iso-8859-1?Q?ZIAXqt4V77gfhlPnLmm5ERRexxaNZMelZyxHwKzINpKm2G3X6QrTGqdZrR?=
 =?iso-8859-1?Q?YInZci7JFvImmrdbK8Fi9EieW94VbbeWc21AMSXP2F2Ks9KmH5z6kuI2y4?=
 =?iso-8859-1?Q?6hw+Wt4Q8lwTt78dJjpPz+p/elceWQ1oXgqla8HLrFFgZX30pjg25OoUcx?=
 =?iso-8859-1?Q?4Szm0FkEyOBl1BjhQPM+fmGf8AaPb2vIuL5PVoAfSnFOPbntebGrn5KXw/?=
 =?iso-8859-1?Q?P3Xnof4xrK4M9z67PLXdGHApevJ39Zvd3GjYzGo/Luu7355gFSUkANNkzi?=
 =?iso-8859-1?Q?Df59If6FNM3mNW6osepIIowomRYB3EEDkuTFlkQRYfLZXBvXL71qi9nWAf?=
 =?iso-8859-1?Q?d5SxjEdi5A4hM1jO4b8PIals8QXvLmo2J8UbAUlcz7rFjCLIw6gcaV4FWv?=
 =?iso-8859-1?Q?zg4TVRvMXkFLMKBnuo0Eq6G1PBn0esoISXzxZYzDk1W6rOJL6XaWmayQah?=
 =?iso-8859-1?Q?7BRkJwFEnBZAij5K4XnWDnyHxJgDk3XI1dW60rxG9G/GdZIqm5bA7oA67p?=
 =?iso-8859-1?Q?H4JS1z7Xkdfy0Tmwdy9iGuOyDTHp48CPZmt4hc0RQ1xW+zuFa1KCBAgYO4?=
 =?iso-8859-1?Q?AJmmsrobxG/zZ018uBXWxK9k9zrGBViy3w54nNY6Jsoc5lHui72HLeVc4e?=
 =?iso-8859-1?Q?+qX2gTeS+ZArYi1H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?EwIUFhoJHRVqHkw1T/pxIt5BsnKPoupfUz/W5gFSX7/PxLJrFDgjAUGdca?=
 =?iso-8859-1?Q?sPOi96N3f3hxsnrVpwQTS7O9wzYZRaL3sBc46NXZA6vPY1FGhUqvwS3cOB?=
 =?iso-8859-1?Q?lPgMjV+rOPVh2nJxruDVlkX+gWvCLV889Wyo5SfPLIem3f4ulsGplWN1/0?=
 =?iso-8859-1?Q?pvTknH4ZYs0/2vHy9AokwwnIgjUPGM3LHqJqiz3jjaiAynZICAWcr2V4Vp?=
 =?iso-8859-1?Q?sjO53BDbTLz/gSxuVdOWTuOJI88LxbcUQGyxXrv8nMJ7u4scaZZDUOO2+i?=
 =?iso-8859-1?Q?VHGFXO4Y4E8jaQHuKE6SxrdGwx/Lmkj1ojTeC7d+Xqh2qAMm/p3J3CSoQh?=
 =?iso-8859-1?Q?kUTBzJBQIn94/fcEAdEwkW4WLzDDj67WXYH4ELliBKGsKC+P3ZNNVHhYrH?=
 =?iso-8859-1?Q?gXBxMzIWJsnaEgDLiu9BARU15BG/978sdmCkrwlPJ/uw4/p3RFnSVlVyqk?=
 =?iso-8859-1?Q?6L59cYM7HLmIcc9VLo1ZIMrEJGs8RB1JK8RIff7f70OkncBH+3ikWO9GW/?=
 =?iso-8859-1?Q?uvj6PsKA6xADqxMcUrYmPGc1kHBXvTx9fRpuUTl9NTw996PaL9IR2REMWz?=
 =?iso-8859-1?Q?IuIcfC778H4cTsbXToMWAV9B9nU7m7R1t0If0Gt2lzTQ/raJuzQIT2dzHW?=
 =?iso-8859-1?Q?ZPTSjV/jgH+nxCLoGFcglqwhclWdltoShRvCiYtlaK0Hk3r+t2uPiTrUuc?=
 =?iso-8859-1?Q?FlZwdxd+Mrr8Clkz06/9JhNc6ovVmDqOkBXU+LZMc4xJLe2dqPTpNyTGeS?=
 =?iso-8859-1?Q?r02HdoTYzeRA/hSRRqBcYlvkJibSpt4siiK1HIZyzGFLH1vZAf9Deh9dyt?=
 =?iso-8859-1?Q?U28Asq87N8VZkvpc1ttRtb93FX2rSHUyFtYgwrcmCF70QMhe8w0Eh9y8P6?=
 =?iso-8859-1?Q?aaO6djkisUfhdhY9fX0w9HZfrVwPqqhdcbmNvLifjL9yKx8LmC3SD+1BHs?=
 =?iso-8859-1?Q?9B4uzwKqFihpemRBeoxeJiVhfEDED4ZWsqPvqHk0B5Jw7HSoavRfpzfuVk?=
 =?iso-8859-1?Q?r0EzQoHqdHukSyA65MlL2HnKxzUfPS3OwCfgTa4gTUM5ix3V6DHu8Buynp?=
 =?iso-8859-1?Q?atsIcJTSYO7tch2G7L+pIeFU9RiupphlrDgUWUBy2BaPPDKZHib/mMo5V1?=
 =?iso-8859-1?Q?viH0pG1YNMfgRsOSNQ6VYeuCCcgfbjsxK2j6AWG91YR6pQD9hAILY4gMsV?=
 =?iso-8859-1?Q?4+OWRL8mqPKBA7/LIpL0wuV1dZqSsrUqHYnbEcMffBYDAj9pHV0EuJI9X9?=
 =?iso-8859-1?Q?eBmIxxjMziazaON3KibpAxNHMw56cIDMbsvKQCiDuysV5YCks4xuyx74b6?=
 =?iso-8859-1?Q?98Otc3XgYqqNKfCvSP7Py+Rp7TYDCn/eMFhJoZQmIrYVdTeuVK9O1Gn+y5?=
 =?iso-8859-1?Q?my8onBOKjG6uvkNE55IHoBsjXGMBUifVa6uAkRoRExf99GmNGZjYv4KIzp?=
 =?iso-8859-1?Q?M+tjffJBc1iI7Fj++KmZfXqxbJMc3E56IOZxA0Lup9IheBmTpFeYbNg/hN?=
 =?iso-8859-1?Q?CnjMxn4uwX1i1ScqpKMu5BTSoptdDkAoDBD0tNJovUZEGDSCbURuj15KUo?=
 =?iso-8859-1?Q?G8g9yCoGzoZD3zFUbmwuROkswcf7OWCYVqjaoqfai0uGgKmEUaCWaj+0uu?=
 =?iso-8859-1?Q?TW9A/Ue68n9aj9RxKQXt5A/BE4RkjirOh36+yDkssyIMKvldxTscauXQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eee63e58-f448-4074-db19-08dd52d60e30
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 00:15:47.2255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TOEZG6P7NFNe5B4vhH80ObEJd+4ogGb2OzIOs8elQlu3j2+wmo0PnLif+RxOruFm4p1yt7hEovd5jsQ8zOgp3N/aCdSGcHaOxAmETbyhhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8113
X-OriginatorOrg: intel.com

Ilpo Järvinen wrote:
> On Tue, 10 Dec 2024, Bjorn Helgaas wrote:
> 
> > On Thu, Dec 05, 2024 at 02:23:56PM -0800, Dan Williams wrote:
> > > PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
> > > enumerates new link capabilities and status added for Gen 6 devices. One
> > > of the link details enumerated in that register block is the "Segment
> > > Captured" status in the Device Status 3 register. That status is
> > > relevant for enabling IDE (Integrity & Data Encryption) whereby
> > > Selective IDE streams can be limited to a given requester id range
> > > within a given segment.
> > 
> > s/requester id/Requester ID/ to match spec usage
> > 
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -749,6 +749,7 @@
> > >  #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
> > >  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
> > >  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> > > +#define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
> > 
> > It doesn't look like lspci knows about this; is there something in
> > progress to add that?
> > 
> > https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/lib/header.h?id=v3.13.0#n257
> 
> Hi,
> 
> I've two patches lying around that add a few Flit mode related fields 
> and Dev3 into lspci, although the latter patch doesn't exactly have all 
> the fields from Dev3 but at least it would be a good start for many 
> things.
> 
> I think I'll just post them as is and see where it goes.

Oh, good to hear (the dangers of replying to patch feedback in response
order unfortunately means I missed this in my earlier reply). Please
copy me on those patches so I can keep track of that discussion.


Return-Path: <linux-pci+bounces-22065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 925EAA4049B
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 02:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7F73BFFEB
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 01:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615FC194080;
	Sat, 22 Feb 2025 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6ZisnWH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D207374C4
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740186933; cv=fail; b=BeDAviGbQEVmqCnBcdN0AY/Yu1FwyZe7ItE1Q2KmpG7D8E+tTck5gvwr9Ejq/gcVh10jYjTWZPNhywNsaPuZ+eiP7LFZnWVqT/2ioUxQgTfM0q/uf3YQIGh8OZg2ce/my0m6kjMNFvJ8IQim8h9PPq/nwGUBpZhSSoYmPxH4yuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740186933; c=relaxed/simple;
	bh=6zJNwEoKaeUfu0t9QE4haUAfLya+6LHUx9Z3yj24j68=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qg2wC7QU1RQwSWbiAnMUaxiER4HA7jADNl3uggr8gjC3Ug7MHy2aAnmAHt266yTfR34hWP6Jx6u2Z2TnEl0xPIx+AZjSAjdX9O7urVwj3GKbPDoUcfQAFcCO4OHAEtWM6lGXj5EukojnTFwmc7XW4ABBJtfoV0UOrBTKZpJ0Ga4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6ZisnWH; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740186931; x=1771722931;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6zJNwEoKaeUfu0t9QE4haUAfLya+6LHUx9Z3yj24j68=;
  b=f6ZisnWHGEX6zcWLpzPZcgC4U+JXPaFYyqaL9qmr6E+CDHpi1S6UGEb+
   sd+DDLX289pFPZ0hbbmDa73f4oIxFQ/OdZrN5pu/ZKgMKxdoiYQxWHjj7
   stIGYc8PHMqcydWckF5AU2WzRMuMYLIk34x5xSnq9wMGE23fpABFB/HxU
   aMYKqjUh7XH72jgNRvDBDatN1ngEl0IPjw8VTfi7kR1s83xDrqSlEAkho
   hE5SnYYrfAuZP0h+GAApEpnOVSki0HYewDVgcZ+huSWKMzrcj9VPdcg0y
   cj/E1y42j509lI+EjWffGiyLKV0vt0hpFecKFlirya/SxQkKuh8U2EaA/
   Q==;
X-CSE-ConnectionGUID: urDoh5KgTi+gU5vnU38z/g==
X-CSE-MsgGUID: M2eGUdzGShuNhe4BdZVdlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52447472"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52447472"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 17:15:31 -0800
X-CSE-ConnectionGUID: 786IZgxoQVCJNbczGfjmHA==
X-CSE-MsgGUID: gtKP5ALvSXapysANISSsUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="146367160"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 17:15:30 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 17:15:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 17:15:30 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 17:15:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MexuzP7oSA1EszF1qR+v29JZRe+yEkTK3Gr0EGnlAINbAlW6whvjKhrDjKQAqge30WVRa60qtO0g6HfQ/3dCOlEx7WoCWZyozF7UXOZ486pnbpL7PXDDoq7R+wfcI4FOpIpNOI58gGk8OUdxzQW2DHJqjkzdU2bnXBAyEwVdRvvOfCxG0LoXGNRSB0cET7USrayCqJSqwxq9qtLtFhAk4gt5vrgDc/EMY9x6MFOTM1Vqif2o9htHEAVF79bkrutSILmwRrBcbxIVnVVcgQwHPXdJTTHYaV774w/UwM+QLp9KNU6JaP9VgZK7YY4j8Ivml8KwzNzeG02KWcwrYv8ZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPiDXYiO8YIS4W9QAwdAtMAJRmVCq0IKGcOqrnQ/NtE=;
 b=e5UuR0IOtUvA3o3TFgGP8AfAE2+AvOZt0US3qIJ0UldB7axvqCf0Tb5Ai8MhZWMQMx+7OxxXujp27/c+6ITYX+sGRI0vLdey51B4EekFpphj2iRsh/jHdxk11dk/wORop9nj92g7x/8U4f4zEPtisYCfHXM2HipF4TenSPMcYqiinw52IW2LbNDLKiKk8cQeuxNxaRGJWMRek70SKT5LSksp1nw3dKQsVYAWF19vjfHg6/AiF22l7Ua1DyEzQ4stOIGYfemmpylpHQjmUho0sQsq9Hm9dzhFENz5Sr95zUrpNf4qFKfNQw4r/P0by2Kpnt8CyTCyI37Wco/pvnQ0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8111.namprd11.prod.outlook.com (2603:10b6:806:2e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Sat, 22 Feb
 2025 01:15:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.015; Sat, 22 Feb 2025
 01:15:27 +0000
Date: Fri, 21 Feb 2025 17:15:24 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <67b9252c8cac0_1c530f29484@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <Z1qx2nAHbZN72Ljf@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z1qx2nAHbZN72Ljf@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: MW4PR04CA0140.namprd04.prod.outlook.com
 (2603:10b6:303:84::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec00b02-0247-498b-de9a-08dd52de63de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lrHxQnxwL2Ko1dMxs0bahdqx9MIvL/+o/hthE3aOZ4D25AfGbrl17g7RalWL?=
 =?us-ascii?Q?i6N91sebJkeGBuOzeetmFUzXMGm6JnvBcAP2PhdmuB/PTwF2kABlRX78YW6F?=
 =?us-ascii?Q?F1gcIFYL/h7pKGboEf8PW2tnmq8iWUWLdNb7b1j1PgT+jvBmO1QPp3Jym2qy?=
 =?us-ascii?Q?xR8QKDZRGjFWTsJhwDi29VnSFs+Meg2RGKyqCOg6OI9AXILXPSlosmf7Gkew?=
 =?us-ascii?Q?gemGMMEfbOZ2jB5gdcyKmuZTBpek1YF8JfcvjooOocz94PBr3XSicxKBJrDA?=
 =?us-ascii?Q?+Q/S78yWetMLHFXhSMyZrvkrSGVkC1ZyEdb4HcGpXpXGsaKD25ka81xvlN/l?=
 =?us-ascii?Q?YaNo6ZUogpcCZL2xAnKwtmSemELAE4vZI3M0UR7hkITMV637G4Ff8fuW9Y1d?=
 =?us-ascii?Q?o3arFN2lFkh4iWELeykt3bclGYjA6nSWHyDtQ/VlPcw4DlIL0hR1f1FxYmC2?=
 =?us-ascii?Q?2LBmGwY71GJd+syZ2RjFitYMmJ599VFdPN5Gnn59eEqIp9yuQ1hrOddVJb2K?=
 =?us-ascii?Q?Xs7zoV89N7K2xcQ/xLVevJk0lQ+rO8Lfr3ao4Bh2agz1Y7ZR9yrLCu2OoDoE?=
 =?us-ascii?Q?f2yaCYZyobM7+Q4xRtQDubovVA/NRYf19zuxDL2ube6aLQ0x4eVuPjLb2zCq?=
 =?us-ascii?Q?JYVFMo/8vaEhtaQKubDO0P+6y9VgIndCC38s6iVhhsTgfa1lviQXug3fmjb3?=
 =?us-ascii?Q?jTaKJ4Mu+Vzm48X74haRN+hNv5FfNqSzFSHDkTmS6G/IwIrUBld7SaBnzC9v?=
 =?us-ascii?Q?432vUYK1wDV5oDrQ04xXQxLoq+EAYaZNJbA+/NFKOpo2MuWWCgndWSASPEZi?=
 =?us-ascii?Q?w7nYIDcHWOpnfULU4rS/fAUADeqXQx4+6NInnBfGRYhgOPIKosRaSMfs/s7i?=
 =?us-ascii?Q?jDOvoQKxDFqefTAdYRhp9pXPFRLl9ZRGYPXZK1Y1m7WNndt5B71UtUduCypo?=
 =?us-ascii?Q?ziRfZiQ81fPhvK46+h/MDoqlxwSl6riSyV3eaQBVpVHLz7T7of5JTqNPJbqW?=
 =?us-ascii?Q?B6ABUHP/Rj4duIbP3RUPjE/8897pcTGroy972efGfmkXDbSteLIjeVHLwbo/?=
 =?us-ascii?Q?nMCq62nv5F/c2inMKWm89zQRZjxMGj0sgNPB89lHatOFSeRdN6fkVibKHKB8?=
 =?us-ascii?Q?pt5OK2y4ZkCYp0ANUOGCAtKzXxEvC3CMyaNTWFFy97wnerkodINonQASYuNE?=
 =?us-ascii?Q?zkcnJCKKbkzJp1KUAnvl71ZCbBKWBy9X4CoPDRYQhrmOcT4Sjpqgs/nXik8p?=
 =?us-ascii?Q?3R1F4kH1ApzpOSERf2x6EYNCJ1n7vB2ksGA+k7rF885nfERVBp3yn+tq3isY?=
 =?us-ascii?Q?mAMJQxm3bwzLiyR/YO0chx/EMxbRnJSomvZ7djsH7amOmDm3GnHblUVuCHCD?=
 =?us-ascii?Q?PWKyXNaOJMs9cm+i5DwTZLQmpAwJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PwFsImSOVKy6QZRfx8RtN3BBLgZsxZUaDT6TggyNPHkXUNrMka0zx1mOUigL?=
 =?us-ascii?Q?U6VEmj8z0gWCjqI4KqS13FoKv4A9yuzHbaIRfsvYrB2ycq8KdV5QeMJRRmzv?=
 =?us-ascii?Q?HtZ9x6pbHuTxSiSxT6n75FB5sQ6HfJvwKgB0v+0PpodrGOTlB7Zg8uotlAV+?=
 =?us-ascii?Q?kPH9Ll/okNL35oP7efeYCDSy6Qm+BQWGdwB3Hzbgb2KyPpk+ZXrlMqjg9tiV?=
 =?us-ascii?Q?5u3gINDwwPaTKkR9z3f6a9xzSsR4Qx0ZRXge1wCwFxPvLkGusJi69UxtnH4r?=
 =?us-ascii?Q?mW6hf6cY4N4oQ8wQCeqQVbrCo7f30dqNTg90x4JxXnD814zSkAZqtK9tpS2X?=
 =?us-ascii?Q?PIdtPK9pSzcNzLZUMW2PIu2ZS0PuAgZ6GLAPSgctJ8inB7NWWbw4WlLEF/uU?=
 =?us-ascii?Q?10JqVTK5VwXLx5lBdcVHBVYOLA53TDrqVlgzEwFrQQPjQz3/ELXJPGCOxEKZ?=
 =?us-ascii?Q?wLjvKbHJ+jDGYcatNL8uTjpxgHlsT6VeUCGi1SUuhr/ci2qujh3zfMTi22q9?=
 =?us-ascii?Q?BH+cqLGeSHre6zkwMGI2hLGPtjJObz+gvKj4gQLS5xNrq17RjluTxWax8auU?=
 =?us-ascii?Q?vuTnY3PDcCMaZ6AbfiYk+2+QE+2PY87OkzDFZUP8y5xNBZelyUNSJghwGzqd?=
 =?us-ascii?Q?JHsknp/kW+8PDEPw/tmb4jcznxMNivKMJidzceDRkk+Qzf/sgYOZXCTg59PW?=
 =?us-ascii?Q?5k5zsbw5pcVQvcRf6oxljPINlQ26KMHAQ7E+EOzte7T7mGCRT3ErrUrxbjAp?=
 =?us-ascii?Q?GhRFyWnbg7bKCLHT6j5uk5HxtNHrk3Y+cCgeKYUcgziau9ZFd1m6/ZfNjlP+?=
 =?us-ascii?Q?IXhGwAnzbiIFnCO8KRWbtiktOioyS8l3sTzhPFUMWItB37C5aI8fJu5HHVdE?=
 =?us-ascii?Q?WjjOO0SHhM0T8emStMqFdfyHJNvD1YYTPFpvVngNjGBN5Wj6LpTuDeMBaLKb?=
 =?us-ascii?Q?HQcZtFafk1kYNfTcE9GAl30VCS7BQyHgt/NFtEkrYKLOAHZ7ndWdewLgynuk?=
 =?us-ascii?Q?x68mQkw/3HqV9AyR0i4shzK0H3ET2ikdZdIWuPp1839puDAVF++l5ttcmjru?=
 =?us-ascii?Q?LIq8Jb41KnsGWoKBKtiez62wnfK4INLpgvWDM5dpH2JsqErX2UO4UnZ+Ibx4?=
 =?us-ascii?Q?wO66uBI5wYMnhJn/52GMNsVs53T8JorOwj9nWvSxLpxfGm7DQ7HsxhqjTXVi?=
 =?us-ascii?Q?aFSfw7p6UJnr1uR8OqXeqrCH7zeR+bUgTZ0N2LAJLheaZmGJ7vN9pUhZX/VS?=
 =?us-ascii?Q?fojZN5hC2cYnrkuwUHpla1tnNxTdwmWu+TPvocrO3GNIpg7UpNSZS0eyrOvX?=
 =?us-ascii?Q?vMKVN/PO2kSIyNfKylj5Zl1bjbh1Yqy20BvKywfpYOXxWcXOyKJMSvAqAzNI?=
 =?us-ascii?Q?t+WPXfoGRtCIUyYu1ybbEVwtJBqlbcMIiRm6qDFLNC34shM4nfeevad4JdGl?=
 =?us-ascii?Q?oWXNJFE24fsbCJp43sAdRXg1qIpe0KW5un+yKqsk4ZtI//6fF7BcHkoPYCqk?=
 =?us-ascii?Q?2zXIM9UkX+MBBq0DvdLcVXZXBLHrv6YVjnIk8ZD4QWOt/ZigBeKIsNDLXBgE?=
 =?us-ascii?Q?m53UzsZvxADmJuso9pJl9axXSCWOfQMHXduiy4bgJmq4vzhkcZ6xc7qd4sx+?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec00b02-0247-498b-de9a-08dd52de63de
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 01:15:26.9302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EedRO0BWMnVIpWImQuLF9Yle3TgfcXP5/VaCMbEkwZxPKkg3z2jfim7BVOLVbnpUl5t16xjwOTlm5cGJqpup/2URpm4DcfauorKqLdCYuwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8111
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> > +static int pci_tsm_disconnect(struct pci_dev *pdev)
> > +{
> > +	struct pci_tsm *pci_tsm = pdev->tsm;
> > +
> > +	lockdep_assert_held(&pci_tsm_rwsem);
> > +	if_not_guard(mutex_intr, &pci_tsm->lock)
> > +		return -EINTR;
> > +
> > +	if (pci_tsm->state < PCI_TSM_CONNECT)
> > +		return 0;
> > +	if (pci_tsm->state < PCI_TSM_INIT)
> > +		return -ENXIO;
> 
> Check PCI_TSM_INIT first, or this condition will never hit.
> 
>   if (pci_tsm->state < PCI_TSM_INIT)
> 	return -ENXIO;
>   if (pci_tsm->state < PCI_TSM_CONNECT)
> 	return 0;
> 
> I suggest the same sequence for pci_tsm_connect().

Good catch, fixed.

[..]
> > +
> > +static void __pci_tsm_init(struct pci_dev *pdev)
> > +{
> > +	bool tee_cap;
> > +
> > +	if (!is_physical_endpoint(pdev))
> > +		return;
> 
> This Filters out virtual functions, just because not ready for support,
> is it?

Do you see a need for PCI core to notify the TSM driver about the
arrival of VF devices?

My expectation is that a VF TDI communicates with the TSM driver
relative to its PF.

> > +
> > +	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
> > +
> > +	if (!(pdev->ide_cap || tee_cap))
> > +		return;
> > +
> > +	lockdep_assert_held_write(&pci_tsm_rwsem);
> > +	if (!tsm_ops)
> > +		return;
> > +
> > +	struct pci_tsm *pci_tsm __free(kfree) = kzalloc(sizeof(*pci_tsm), GFP_KERNEL);
> > +	if (!pci_tsm)
> > +		return;
> > +
> > +	/*
> > +	 * If a physical device has any security capabilities it may be
> > +	 * a candidate to connect with the platform TSM
> > +	 */
> > +	struct pci_dsm *dsm __free(dsm_remove) = tsm_ops->probe(pdev);
> 
> IIUC, pdev->tsm should be for every pci function (physical or virtual),
> pdev->tsm->dsm should be only for physical functions, is it?

Per above I was only expecting physical function, but the bind flow
might introduce the need for per function (phyiscal or virtual) TDI
context. I expect that is separate from the PF pdev->tsm context.


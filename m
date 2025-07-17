Return-Path: <linux-pci+bounces-32443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C24B0940F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 20:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70793A6F99
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A322F9481;
	Thu, 17 Jul 2025 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxGH6kd7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693D221517C;
	Thu, 17 Jul 2025 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777290; cv=fail; b=rWhXxjBDkyRJXIUJ4P3CAtUIvUYtGgCbu7nAPsvvWBkjYbVrB1hiYivEUJv8w5r2asSiKoB9D8U2+JcMVkVmEmSsDlak+DVg16mqO0NoFCdDKL2Ysl6RcCcnB/qR9HAIwJFn/twlmvv16yJ/g0WaJVNQZ6TPxvK0A2KVwvb0dzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777290; c=relaxed/simple;
	bh=OzmZ3WVmANJ3UqcHkNzjPS0mBztfFjyvokbXohdU7es=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uFT35GIdFSSxdUFWgx/QQSH5lViohjRlmp7qHHg30HmLVqiv85reNFYy2ICa0dJWlVulDSOadoZauXkKKS2U9hmgEqYsqId6rN9Sl7+JUdB6znh4jDPLZ0LrNovlKLUlZWOBzZnRbN4Bp8BtaM7SdssL7xHywBXbwIwHALWg0b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxGH6kd7; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752777289; x=1784313289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=OzmZ3WVmANJ3UqcHkNzjPS0mBztfFjyvokbXohdU7es=;
  b=YxGH6kd7rrpE9yfzsM6VnzDvoW55PxkURFN8Wu7ZLE677RFZFaKroKYr
   tri5odyQsZ/Z1o8bASR3gJXYGkkxfVTDcUX8ZNUjW8HG0tAEi8fWBCOf0
   CjWYvOKKXjUrnPTHb76DYOXIO/c/pptj6/2GyLJMYCFznY7ROz4/Doc3C
   m18gjryU58jfTV/rhheKfXSwf441kXgIIgNzLWMgijgqbjejwvtmgZtd9
   ui4V2VXFxqFqchi3OBvOm/SQNiHhHQjVnVM8sGQ6JcbXmmkqf6azsCM8B
   fio1m7zr3Oj834mnyMo6nOX951ymvYH6LmCs8xVTbvethzbHORLLd26L1
   A==;
X-CSE-ConnectionGUID: QpttjgdXQTSP4K8kbs9/pw==
X-CSE-MsgGUID: ROQA/e/pRCmCuRZn4YCl1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54924225"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54924225"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:48 -0700
X-CSE-ConnectionGUID: 0nRIKxt0TeCqAb3J8mkrzQ==
X-CSE-MsgGUID: AAScje5YTHaPit4sAtMhDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="157254744"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:34:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.59)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZTUt38bHLolan3OVOmQM3yDs62/T+NaQmrHErKH1uyxCkIyWc1jw+0nYr1rXLrX/FTfh8/AhSzujNEjamGHGbuATTMDI488xRDEoZNDdCs4N6jKz1DY71H5a+okx5Oh8KdA7n6H/Wz0RiBZXxsLE87cjHae9GCoGqITM7ixswriOo5UOH4RnL9Xj46lako4B8QsVZrG2M+f3k5N1AGPzFTE47XT812GGnfv8DYVJCCMhzNaAUkOuq34IZbBv+K9XnyUwFUc5vQ4n4yO14+OozuqLjR2P9q6fRj80dbT0mEbcNoSyCItv8EoPIOgupSU5+Y7A3aSMPFuvHEBbXvPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds93xq326as/PJpfQFUperXm9g6Vb6UItCoDD8Y++LE=;
 b=CP+nprRn+dYgux3EFVreAy2Ai+rJnAHJh1r7zmQg+n8Zn2Fr69gh/R/UoFujnXWQgb/wMpFC+0a0ny83h/icDfkNZTZGIrA9WWnSHyPhW70r/bsY7t0AiqqwDTP1FC8LZHVlzm1WZCBnZ50Wg7UWYlJpXEfd8+VrSMLaVwIteZTxtHcymzI0RMJlVWXzu45PuXwAY0hW/+UmnivYUC9WaD+m8HZy2q0j7AQ41lvxuV3u4loVzgs2yxZ1GFheHKILlCZGfiXyoNktWJn30gIepMi2vW8WycC9El6KpgcATktxMipYi8RUj5GUmOSygJeosXPvN2Q7wTrrwu7yrFokXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7066.namprd11.prod.outlook.com (2603:10b6:806:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 18:34:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 18:34:06 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Subject: [PATCH v4 04/10] PCI/TSM: Authenticate devices via platform TSM
Date: Thu, 17 Jul 2025 11:33:52 -0700
Message-ID: <20250717183358.1332417-5-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717183358.1332417-1-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: c7650587-f11c-4bac-df51-08ddc56082c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fC32xoTSR6Iw6Cx6XyIqo50MG3RBdCZnCagfosP1VQDJkuoAymYzG8iO9hTv?=
 =?us-ascii?Q?9GOCfT5oy9ncS/4S9LNLdvWHXJEGvlpotl3nEZIlg4/2x59HCl/SbGS9e8lC?=
 =?us-ascii?Q?RUUwk5/Wy2yz7e4Jfc2Gk6zFbCJnKimRGQn+kXxqlkl6kRMwdqxXt1ijiO7w?=
 =?us-ascii?Q?YExWFSE62Frkp0SFC84Pz/XjYTXYtf29HZypx5mYW2MDw4Wkf8zp6rCE/F5t?=
 =?us-ascii?Q?tLAEgjcOWT3YUvR3+WZdc6DnFAG8zwGHX3hgcEoXhrcYfQZhEH4xKN6X8HgB?=
 =?us-ascii?Q?grkNUoT6YoG++ArwGZ2+Z9KtB35Kvs/7ga2D2PfXHky0mRNkusrASxDJolJ4?=
 =?us-ascii?Q?zv4RiBF76JRcz18nwvEpU6+0Gb7iO7j5nGNT7SdfnAxtGgxTd48eXf+6e5nJ?=
 =?us-ascii?Q?TtXMUJLo1cXVZ4eGZos1KrPuoMRLUooJhdf5FEYiYF+YTVZfh/DCqUVdCcal?=
 =?us-ascii?Q?bkdZOiHNxPh7vy2UsT4gtYIRzIM8dohm2CdXnFhBO0FRVN1XUZVkdnB7kBZW?=
 =?us-ascii?Q?dcPS/jagRo+YBhkcNFVAoupKAVNU1eL8jpQU/+fLQK7+RRjwXjyMs3W+ANyl?=
 =?us-ascii?Q?Pag2ckBitvhIQzvlEORE8qqGbbbI83xloP8ED0KnXO0X+2XOoQgYsXv2/EEQ?=
 =?us-ascii?Q?UowzJgKjvtZeVLyb121hMRr0P6rmoDyseKzzUcF8xrFwJZMYpdN0uHs90dXx?=
 =?us-ascii?Q?220sqrIdr+P3XX9TA/NPgHcne4K+F3WAjrwcWAPZyWY+hZq0yeZCgCF14iKy?=
 =?us-ascii?Q?yu5LFeuoeODxCaGDs1F7vl6jJtD/h3G7gkGhmzqv3wOxDMTXPrJjdXBShzpC?=
 =?us-ascii?Q?w1FCXIG3DJba50ZOFSAgE9HZwC3omAh+orK1QJyU9KeZ6v2nyWQvawtK6LMr?=
 =?us-ascii?Q?p9dWXo5YrbA5E1bZ/9Tsm59YpLWjw9R4ZmeE9vFlTqjfGBPn+TBsdyhHj/27?=
 =?us-ascii?Q?jZJh3myKahuYR5zDAMDLtBMsjQ0I1sbcTnruSg8mo8r8cOJY/JjGFvWD3LAP?=
 =?us-ascii?Q?Yn/HJiP7J9r+WevniiJy1xeV5Q9SPso/0cODSnuaSOVDbqgfbOhRYResAdS1?=
 =?us-ascii?Q?2Cz0XB6BqNWs261eSwj09GJZSEv1ytNYPyyVM5YtsodeOMwbNDwRbt4L6lrt?=
 =?us-ascii?Q?eEvOSPmyIku081m8W1ZCmNbNVDk4iijg603ZxRgGqaxirviRBalQ9/ZlrXYR?=
 =?us-ascii?Q?wSMmFljvYGySSBvYjx1GUteUP5qDVSywXYah2rtQUqqxm/OV1ctW1NigdIEi?=
 =?us-ascii?Q?bVNNUs92l9xG74XE+lHoVKsAsC5p3Skn2DHZBbT7hMgpqjWNuFIAlnEpxVWp?=
 =?us-ascii?Q?YX+UcppSY0qjI5F+QWsWEpTxGb2lW6Qm8kRt3ivqgfYOb4s+6BGqBGxpFHfH?=
 =?us-ascii?Q?Fo6/JlsACkO2cbdL1dhUir7lXNfeYO9QCaqnMvmKxwK/OA4SCVI66kuYCTKU?=
 =?us-ascii?Q?Q7+bs5gi1CU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NYMZSBdCdn/u6tlbEQoeYEuIhOc5giLE1RSbT2szrcp4wwCsVmDkTzxstOU9?=
 =?us-ascii?Q?4ayB1vGmKv6RVAYAlyhv5KIySblclgTWfjiMNw/76QT7xLJyJJF4gf9tMwlq?=
 =?us-ascii?Q?+/z+7jzdos1s1KzniFVD0exUajbmvehj8Qh00JKzA1czDwtK37z/FP1KpR9I?=
 =?us-ascii?Q?+OCnA6RXKTuJF6lNfgbMnt5/RSrjpV6v4uHR0F5uQemaCabFzAjbFIzRR2L5?=
 =?us-ascii?Q?7gYevCKzb7l+qZg9Yy0+MJRrLgX6t9g0cLDKWEJwM3uPU6e6JuQlY+UjR9Fj?=
 =?us-ascii?Q?wO+F0qM51ebR/XbpO1Iz7gQKl5Hj+32C5JcGHR5nTF0JAxHGY57scYPsVJf+?=
 =?us-ascii?Q?Vx64orh+KMeK9tM2SNoil3rP6toZnwpTV4uG9C0ZMubSlijdRL6d3Drwek9t?=
 =?us-ascii?Q?hVhFEeMaPQfXV47nGQaf95p/iBNAi0ST3Z/bNhSAE+DXrEurbjRLZtdqtOMK?=
 =?us-ascii?Q?dyYeIYwSbwpjkMBCm5aBjGLAzTIoHkPO0pXma7yFReKLqTrPsodV0MyMuD8k?=
 =?us-ascii?Q?yhHxtODRAfJkJf3uacHRiHGUmUGVeyJUBWB/8nRKgPZRaSUZ9li/7Nly3RIF?=
 =?us-ascii?Q?H67j+PyksxEYqc0Tfa4vx93rjurB3r+ivejtMtzwiN3j8cWbT5o95oRGNZIw?=
 =?us-ascii?Q?RwBVJ+n2P/J5zvq+b6oCOxKkvfsEU13Etl+YvtHHOiMQIlu9eus1DMnhNGR1?=
 =?us-ascii?Q?9v745p0QLKHblkm9mlPmXEDzWDfztltSR7p7+SkC2RHZLM1mV0klG/IgKDDd?=
 =?us-ascii?Q?qpy2W9Z02EPkbPJhOLkoNJWVfeeBSTvY1IocOmjp4FoAfu5ep8GD6eYvrVzw?=
 =?us-ascii?Q?kM2qYWXR0A2zlK6i0moVanS5F2KY/D10vR8bsyX3RopJKxSPUIKkvbw8yWQE?=
 =?us-ascii?Q?swjsUireavlyCfyWV9CAsM6UhyfUqO0Gy3a69vREV5Vs6qLTPPwC8FetAwL0?=
 =?us-ascii?Q?aDuYzWiYp3cQZSUUcdkmYe7pUBeVQ4X/GqHskXZlMDrBfvfPgB7Op+42gG06?=
 =?us-ascii?Q?PGN30sUTK/xsAH9zWjDm3fq31o8HXHE2HEm0aH6AtEmclXp484KPNyh7z7rX?=
 =?us-ascii?Q?Gg1SHT+uU63cM90KToHOj2d3mBQJUBwq7s8huYc/pOvKmW8iUqKwPyQV1F02?=
 =?us-ascii?Q?TvaP6a4l4FnFvoz59ou+C3IkPC4/bZKnxSBAIBM3tfW0a1NauKmFJAgmS5mS?=
 =?us-ascii?Q?ERxwelB4RaDe7CJ2S6k2lx/WpW2BbI2foY8LL0qnW5kAiV508HSECHOtg4LF?=
 =?us-ascii?Q?bNdmajtKx1p5i04gS5TrkdQHWmmEulkYU3sjaqSWMmQgsR5rTENAcUxMNx7/?=
 =?us-ascii?Q?OfhhKLK8/1vDay2/s7MqzTSghBmEHboGpL/CWjrfcweaa+Katky8JjcxZPn7?=
 =?us-ascii?Q?DQaSDXFWINAmUGTbkQpAKU70WBTeHezNik0sL+chwGYlAysmKdr/TymiDqY5?=
 =?us-ascii?Q?rulIjseNrl7GhdeII5FKKMYMUM+hHFMU3ItKGZIWLReRPeKar0OSpKBaTCwg?=
 =?us-ascii?Q?e8TG7ih8D9OPIQMUEflChj+WJA+1QzqtcmRuJc4SinD0LWuc5N96W21Y4I3K?=
 =?us-ascii?Q?4QVky7KI8EhGwQuUTB1f1r0CAFgcgyrBVuCld5t5H8M28kU//L4J9LrMJqDL?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7650587-f11c-4bac-df51-08ddc56082c3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:34:05.9643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbbPsBm5pQmFe3Qvlrd8mgkU3sAhu1AQcETSIdBFuku9C7o/FyHU0u0krXoX9i4W+ixkTBTQLCTDN+tlzOcBnj8N2jsMkK7FpbnuN+7G1WI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
X-OriginatorOrg: intel.com

The PCIe 6.1 specification, section 11, introduces the Trusted Execution
Environment (TEE) Device Interface Security Protocol (TDISP).  This
protocol definition builds upon Component Measurement and Authentication
(CMA), and link Integrity and Data Encryption (IDE). It adds support for
assigning devices (PCI physical or virtual function) to a confidential
VM such that the assigned device is enabled to access guest private
memory protected by technologies like Intel TDX, AMD SEV-SNP, RISCV
COVE, or ARM CCA.

The "TSM" (TEE Security Manager) is a concept in the TDISP specification
of an agent that mediates between a "DSM" (Device Security Manager) and
system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
to setup link security and assign devices. A confidential VM uses TSM
ABIs to transition an assigned device into the TDISP "RUN" state and
validate its configuration. From a Linux perspective the TSM abstracts
many of the details of TDISP, IDE, and CMA. Some of those details leak
through at times, but for the most part TDISP is an internal
implementation detail of the TSM.

CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
Userspace can watch for the arrival of a "TSM" device,
/sys/class/tsm/tsm0/uevent KOBJ_CHANGE, to know when the PCI core has
initialized TSM services.

The operations that can be executed against a PCI device are split into
2 mutually exclusive operation sets, "Link" and "Security" (struct
pci_tsm_{link,security}_ops). The "Link" operations manage physical link
security properties and communication with the device's Device Security
Manager firmware. These are the host side operations in TDISP. The
"Security" operations coordinate the security state of the assigned
virtual device (TDI). These are the guest side operations in TDISP. Only
link management operations are defined at this stage and placeholders
provided for the security operations.

The locking allows for multiple devices to be executing commands
simultaneously, one outstanding command per-device and an rwsem
synchronizes the implementation relative to TSM
registration/unregistration events.

Thanks to Wu Hao for his work on an early draft of this support.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  51 +++
 Documentation/driver-api/pci/index.rst  |   1 +
 Documentation/driver-api/pci/tsm.rst    |  12 +
 MAINTAINERS                             |   4 +-
 drivers/pci/Kconfig                     |  14 +
 drivers/pci/Makefile                    |   1 +
 drivers/pci/pci-sysfs.c                 |   4 +
 drivers/pci/pci.h                       |   8 +
 drivers/pci/remove.c                    |   3 +
 drivers/pci/tsm.c                       | 554 ++++++++++++++++++++++++
 drivers/virt/coco/tsm-core.c            |  61 ++-
 include/linux/pci-tsm.h                 | 158 +++++++
 include/linux/pci.h                     |   3 +
 include/linux/tsm.h                     |   8 +-
 include/uapi/linux/pci_regs.h           |   1 +
 15 files changed, 879 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/driver-api/pci/tsm.rst
 create mode 100644 drivers/pci/tsm.c
 create mode 100644 include/linux/pci-tsm.h

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 69f952fffec7..99315fbfbe10 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -612,3 +612,54 @@ Description:
 
 		  # ls doe_features
 		  0001:01        0001:02        doe_discovery
+
+What:		/sys/bus/pci/devices/.../tsm/
+Contact:	linux-coco@lists.linux.dev
+Description:
+		This directory only appears if a physical device function
+		supports authentication (PCIe CMA-SPDM), interface security
+		(PCIe TDISP), and is accepted for secure operation by the
+		platform TSM driver. This attribute directory appears
+		dynamically after the platform TSM driver loads. So, only after
+		the /sys/class/tsm/tsm0 device arrives can tools assume that
+		devices without a tsm/ attribute directory will never have one,
+		before that, the security capabilities of the device relative to
+		the platform TSM are unknown. See
+		Documentation/ABI/testing/sysfs-class-tsm.
+
+What:		/sys/bus/pci/devices/.../tsm/connect
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RW) Write the name of a TSM (TEE Security Manager) device from
+		/sys/class/tsm to this file to establish a connection with the
+		device.  This typically includes an SPDM (DMTF Security
+		Protocols and Data Models) session over PCIe DOE (Data Object
+		Exchange) and may also include PCIe IDE (Integrity and Data
+		Encryption) establishment. Reads from this attribute return the
+		name of the connected TSM or the empty string if not
+		connected. A TSM device signals its readiness to accept PCI
+		connection via a KOBJ_CHANGE event.
+
+What:		/sys/bus/pci/devices/.../tsm/disconnect
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) Write '1' or 'true' to this attribute to disconnect it from
+		a previous TSM connection.
+
+What:		/sys/bus/pci/devices/.../authenticated
+Contact:	linux-pci@vger.kernel.org
+Description:
+		When the device's tsm/ directory is present device
+		authentication (PCIe CMA-SPDM) and link encryption (PCIe IDE)
+		are handled by the platform TSM (TEE Security Manager). When the
+		tsm/ directory is not present this attribute reflects only the
+		native CMA-SPDM authentication state with the kernel's
+		certificate store.
+
+		If the attribute is not present, it indicates that
+		authentication is unsupported by the device, or the TSM has no
+		available authentication methods for the device.
+
+		When present and the tsm/ attribute directory is present, the
+		authenticated attribute is an alias for the device 'connect'
+		state. See the 'tsm/connect' attribute for more details.
diff --git a/Documentation/driver-api/pci/index.rst b/Documentation/driver-api/pci/index.rst
index a38e475cdbe3..9e1b801d0f74 100644
--- a/Documentation/driver-api/pci/index.rst
+++ b/Documentation/driver-api/pci/index.rst
@@ -10,6 +10,7 @@ The Linux PCI driver implementer's API guide
 
    pci
    p2pdma
+   tsm
 
 .. only::  subproject and html
 
diff --git a/Documentation/driver-api/pci/tsm.rst b/Documentation/driver-api/pci/tsm.rst
new file mode 100644
index 000000000000..59b94d79a4f2
--- /dev/null
+++ b/Documentation/driver-api/pci/tsm.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+========================================================
+PCI Trusted Execution Environment Security Manager (TSM)
+========================================================
+
+.. kernel-doc:: include/linux/pci-tsm.h
+   :internal:
+
+.. kernel-doc:: drivers/pci/tsm.c
+   :export:
diff --git a/MAINTAINERS b/MAINTAINERS
index cfa3fb8772d2..8cb7ee9270d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25247,8 +25247,10 @@ L:	linux-coco@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm-report
 F:	Documentation/driver-api/coco/
+F:	Documentation/driver-api/pci/tsm.rst
+F:	drivers/pci/tsm.c
 F:	drivers/virt/coco/guest/
-F:	include/linux/tsm*.h
+F:	include/linux/*tsm*.h
 F:	samples/tsm-mr/
 
 TRUSTED SERVICES TEE DRIVER
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 4bd75d8b9b86..700addee8f62 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -136,6 +136,20 @@ config PCI_IDE_STREAM_MAX
 	  platform capability for the foreseeable future is 4 to 8 streams. Bump
 	  this value up if you have an expert testing need.
 
+config PCI_TSM
+	bool "PCI TSM: Device security protocol support"
+	select PCI_IDE
+	select PCI_DOE
+	help
+	  The TEE (Trusted Execution Environment) Device Interface
+	  Security Protocol (TDISP) defines a "TSM" as a platform agent
+	  that manages device authentication, link encryption, link
+	  integrity protection, and assignment of PCI device functions
+	  (virtual or physical) to confidential computing VMs that can
+	  access (DMA) guest private memory.
+
+	  Enable a platform TSM driver to use this capability.
+
 config PCI_DOE
 	bool "Enable PCI Data Object Exchange (DOE) support"
 	help
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 6612256fd37d..2c545f877062 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_IDE)		+= ide.o
+obj-$(CONFIG_PCI_TSM)		+= tsm.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 268c69daa4d5..23cbf6c8796a 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1815,6 +1815,10 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 #ifdef CONFIG_PCI_DOE
 	&pci_doe_sysfs_group,
+#endif
+#ifdef CONFIG_PCI_TSM
+	&pci_tsm_auth_attr_group,
+	&pci_tsm_pf0_attr_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1c223c79634f..3b282c24dde8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -521,6 +521,14 @@ void pci_ide_init(struct pci_dev *dev);
 static inline void pci_ide_init(struct pci_dev *dev) { }
 #endif
 
+#ifdef CONFIG_PCI_TSM
+void pci_tsm_destroy(struct pci_dev *pdev);
+extern const struct attribute_group pci_tsm_pf0_attr_group;
+extern const struct attribute_group pci_tsm_auth_attr_group;
+#else
+static inline void pci_tsm_destroy(struct pci_dev *pdev) { }
+#endif
+
 /**
  * pci_dev_set_io_state - Set the new error state if possible.
  *
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 445afdfa6498..21851c13becd 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -55,6 +55,9 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
 
+	/* before device_del() to keep config cycle access */
+	pci_tsm_destroy(dev);
+
 	device_del(&dev->dev);
 
 	down_write(&pci_bus_sem);
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
new file mode 100644
index 000000000000..0784cc436dd3
--- /dev/null
+++ b/drivers/pci/tsm.c
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TEE Security Manager for the TEE Device Interface Security Protocol
+ * (TDISP, PCIe r6.1 sec 11)
+ *
+ * Copyright(c) 2024 Intel Corporation. All rights reserved.
+ */
+
+#define dev_fmt(fmt) "TSM: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/xarray.h>
+#include <linux/sysfs.h>
+
+#include <linux/tsm.h>
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include <linux/pci-tsm.h>
+#include "pci.h"
+
+/*
+ * Provide a read/write lock against the init / exit of pdev tsm
+ * capabilities and arrival/departure of a tsm instance
+ */
+static DECLARE_RWSEM(pci_tsm_rwsem);
+static int pci_tsm_count;
+
+static inline bool is_dsm(struct pci_dev *pdev)
+{
+	return pdev->tsm && pdev->tsm->dsm == pdev;
+}
+
+static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *pci_tsm)
+{
+	struct pci_dev *pdev = pci_tsm->pdev;
+
+	if (!is_pci_tsm_pf0(pdev) || !is_dsm(pdev)) {
+		dev_WARN_ONCE(&pdev->dev, 1, "invalid context object\n");
+		return NULL;
+	}
+
+	return container_of(pci_tsm, struct pci_tsm_pf0, tsm);
+}
+
+static void tsm_remove(struct pci_tsm *tsm)
+{
+	struct pci_dev *pdev;
+
+	if (!tsm)
+		return;
+
+	pdev = tsm->pdev;
+	tsm->ops->remove(tsm);
+	pdev->tsm = NULL;
+}
+DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
+
+static int call_cb_put(struct pci_dev *pdev, void *data,
+		       int (*cb)(struct pci_dev *pdev, void *data))
+{
+	int rc;
+
+	if (!pdev)
+		return 0;
+	rc = cb(pdev, data);
+	pci_dev_put(pdev);
+	return rc;
+}
+
+static void pci_tsm_walk_fns(struct pci_dev *pdev,
+			     int (*cb)(struct pci_dev *pdev, void *data),
+			     void *data)
+{
+	struct pci_dev *fn;
+	int i;
+
+	/* walk virtual functions */
+        for (i = 0; i < pci_num_vf(pdev); i++) {
+		fn = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+						 pci_iov_virtfn_bus(pdev, i),
+						 pci_iov_virtfn_devfn(pdev, i));
+		if (call_cb_put(fn, data, cb))
+			return;
+        }
+
+	/* walk subordinate physical functions */
+	for (i = 1; i < 8; i++) {
+		fn = pci_get_slot(pdev->bus,
+				  PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
+		if (call_cb_put(fn, data, cb))
+			return;
+	}
+
+	/* walk downstream devices */
+        if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM)
+                return;
+
+        if (!is_dsm(pdev))
+                return;
+
+        pci_walk_bus(pdev->subordinate, cb, data);
+}
+
+static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
+				     int (*cb)(struct pci_dev *pdev,
+					       void *data),
+				     void *data)
+{
+	struct pci_dev *fn;
+	int i;
+
+	/* reverse walk virtual functions */
+	for (i = pci_num_vf(pdev) - 1; i >= 0; i--) {
+		fn = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+						 pci_iov_virtfn_bus(pdev, i),
+						 pci_iov_virtfn_devfn(pdev, i));
+		if (call_cb_put(fn, data, cb))
+			return;
+	}
+
+	/* reverse walk subordinate physical functions */
+	for (i = 7; i >= 1; i--) {
+		fn = pci_get_slot(pdev->bus,
+				  PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
+		if (call_cb_put(fn, data, cb))
+			return;
+	}
+
+	/* reverse walk downstream devices */
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM)
+		return;
+
+	if (!is_dsm(pdev))
+		return;
+
+	pci_walk_bus_reverse(pdev->subordinate, cb, data);
+}
+
+static int probe_fn(struct pci_dev *pdev, void *dsm)
+{
+	struct pci_dev *dsm_dev = dsm;
+	const struct pci_tsm_ops *ops = dsm_dev->tsm->ops;
+
+	pdev->tsm = ops->probe(pdev);
+	pci_dbg(pdev, "setup tsm context: dsm: %s status: %s\n",
+		pci_name(dsm_dev), pdev->tsm ? "success" : "failed");
+	return 0;
+}
+
+static void pci_tsm_probe_fns(struct pci_dev *dsm)
+{
+	pci_tsm_walk_fns(dsm, probe_fn, dsm);
+}
+
+static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
+{
+	int rc;
+	struct pci_tsm_pf0 *tsm_pf0;
+	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
+	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(pdev);
+
+	if (!pci_tsm)
+		return -ENXIO;
+
+	pdev->tsm = pci_tsm;
+	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+
+	ACQUIRE(mutex_intr, lock)(&tsm_pf0->lock);
+	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
+		return rc;
+
+	rc = ops->connect(pdev);
+	if (rc)
+		return rc;
+
+	pdev->tsm = no_free_ptr(pci_tsm);
+
+	/*
+	 * Now that the DSM is established, probe() all the potential
+	 * dependent functions. Failure to probe a function is not fatal
+	 * to connect(), it just disables subsequent security operations
+	 * for that function.
+	 */
+	pci_tsm_probe_fns(pdev);
+	return 0;
+}
+
+static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
+		return rc;
+
+	if (!pdev->tsm)
+		return sysfs_emit(buf, "\n");
+
+	return sysfs_emit(buf, "%s\n", tsm_name(pdev->tsm->ops->owner));
+}
+
+static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t len)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	const struct pci_tsm_ops *ops;
+	struct tsm_dev *tsm_dev;
+	int rc, id;
+
+	rc = sscanf(buf, "tsm%d\n", &id);
+	if (rc != 1)
+		return -EINVAL;
+
+	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
+		return rc;
+
+	if (pdev->tsm)
+		return -EBUSY;
+
+	tsm_dev = find_tsm_dev(id);
+	if (!tsm_dev)
+		return -ENXIO;
+
+	ops = tsm_pci_ops(tsm_dev);
+	if (!ops || !ops->connect || !ops->probe)
+		return -ENXIO;
+
+	rc = pci_tsm_connect(pdev, tsm_dev);
+	if (rc)
+		return rc;
+	return len;
+}
+static DEVICE_ATTR_RW(connect);
+
+static int remove_fn(struct pci_dev *pdev, void *data)
+{
+	tsm_remove(pdev->tsm);
+	return 0;
+}
+
+static void pci_tsm_remove_fns(struct pci_dev *dsm)
+{
+	pci_tsm_walk_fns_reverse(dsm, remove_fn, NULL);
+}
+
+static void __pci_tsm_disconnect(struct pci_dev *pdev)
+{
+	struct pci_tsm_pf0 *tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+	const struct pci_tsm_ops *ops = pdev->tsm->ops;
+
+	/* disconnect is not interruptible */
+	guard(mutex)(&tsm_pf0->lock);
+	pci_tsm_remove_fns(pdev);
+	ops->disconnect(pdev);
+}
+
+static void pci_tsm_disconnect(struct pci_dev *pdev)
+{
+	__pci_tsm_disconnect(pdev);
+	tsm_remove(pdev->tsm);
+}
+
+static ssize_t disconnect_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t len)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	bool disconnect;
+	int rc;
+
+	rc = kstrtobool(buf, &disconnect);
+	if (rc)
+		return rc;
+	if (!disconnect)
+		return -EINVAL;
+
+	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
+		return rc;
+
+	if (!pdev->tsm)
+		return -ENXIO;
+
+	pci_tsm_disconnect(pdev);
+	return len;
+}
+static DEVICE_ATTR_WO(disconnect);
+
+static bool pci_tsm_pf0_group_visible(struct kobject *kobj)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return pci_tsm_count && is_pci_tsm_pf0(pdev);
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_pf0);
+
+static struct attribute *pci_tsm_pf0_attrs[] = {
+	&dev_attr_connect.attr,
+	&dev_attr_disconnect.attr,
+	NULL
+};
+
+const struct attribute_group pci_tsm_pf0_attr_group = {
+	.name = "tsm",
+	.attrs = pci_tsm_pf0_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_pf0),
+};
+
+static ssize_t authenticated_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	/*
+	 * When device authentication is TSM owned, 'authenticated' is
+	 * identical to the connect state.
+	 */
+	return connect_show(dev, attr, buf);
+}
+static DEVICE_ATTR_RO(authenticated);
+
+static struct attribute *pci_tsm_auth_attrs[] = {
+	&dev_attr_authenticated.attr,
+	NULL
+};
+
+const struct attribute_group pci_tsm_auth_attr_group = {
+	.attrs = pci_tsm_auth_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_pf0),
+};
+
+/*
+ * Retrieve physical function0 device whether it has TEE capability or not
+ */
+static struct pci_dev *pf0_dev_get(struct pci_dev *pdev)
+{
+	struct pci_dev *pf_dev = pci_physfn(pdev);
+
+	if (PCI_FUNC(pf_dev->devfn) == 0)
+		return pci_dev_get(pf_dev);
+
+	return pci_get_slot(pf_dev->bus,
+			    pf_dev->devfn - PCI_FUNC(pf_dev->devfn));
+}
+
+/*
+ * Find the PCI Device instance that serves as the Device Security
+ * Manger (DSM) for @pdev. Note that no additional reference is held for
+ * the resulting device because @pdev always has a longer registered
+ * lifetime than its DSM by virtue of being a child of or identical to
+ * its DSM.
+ */
+static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
+{
+	struct pci_dev *uport_pf0;
+
+	if (is_pci_tsm_pf0(pdev))
+		return pdev;
+
+	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
+	if (!pf0)
+		return NULL;
+
+	if (is_dsm(pf0))
+		return pf0;
+
+	/*
+	 * For cases where a switch may be hosting TDISP services on
+	 * behalf of downstream devices, check the first usptream port
+	 * relative to this endpoint.
+         */
+	if (!pdev->dev.parent || !pdev->dev.parent->parent)
+		return NULL;
+
+	uport_pf0 = to_pci_dev(pdev->dev.parent->parent);
+	if (is_dsm(uport_pf0))
+		return uport_pf0;
+	return NULL;
+}
+
+/**
+ * pci_tsm_constructor() - base 'struct pci_tsm' initialization
+ * @pdev: The PCI device
+ * @tsm: context to initialize
+ * @ops: PCI operations provided by the TSM
+ */
+int pci_tsm_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
+			const struct pci_tsm_ops *ops)
+{
+	tsm->pdev = pdev;
+	tsm->ops = ops;
+	tsm->dsm = find_dsm_dev(pdev);
+	if (!tsm->dsm) {
+		pci_warn(pdev, "failed to find Device Security Manager\n");
+		return -ENXIO;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_constructor);
+
+/**
+ * pci_tsm_pf0_constructor() - common 'struct pci_tsm_pf0' initialization
+ * @pdev: Physical Function 0 PCI device (as indicated by is_pci_tsm_pf0())
+ * @tsm: context to initialize
+ */
+int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
+			    const struct pci_tsm_ops *ops)
+{
+	struct tsm_dev *tsm_dev = ops->owner;
+
+	mutex_init(&tsm->lock);
+	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+					   PCI_DOE_PROTO_CMA);
+	if (!tsm->doe_mb) {
+		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
+		return -ENODEV;
+	}
+
+	if (tsm_pci_group(tsm_dev))
+		sysfs_merge_group(&pdev->dev.kobj, tsm_pci_group(tsm_dev));
+
+	return pci_tsm_constructor(pdev, &tsm->tsm, ops);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_pf0_constructor);
+
+void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *pf0_tsm)
+{
+	struct pci_tsm *tsm = &pf0_tsm->tsm;
+	struct pci_dev *pdev = tsm->pdev;
+	struct tsm_dev *tsm_dev = tsm->ops->owner;
+
+	if (tsm_pci_group(tsm_dev))
+		sysfs_unmerge_group(&pdev->dev.kobj, tsm_pci_group(tsm_dev));
+	mutex_destroy(&pf0_tsm->lock);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_pf0_destructor);
+
+static void pf0_sysfs_enable(struct pci_dev *pdev)
+{
+	pci_dbg(pdev, "Device Security Manager detected (%s%s )\n",
+		pdev->ide_cap ? " ide" : "",
+		pdev->devcap & PCI_EXP_DEVCAP_TEE ? " tee" : "");
+
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_pf0_attr_group);
+}
+
+int pci_tsm_register(struct tsm_dev *tsm_dev)
+{
+	const struct pci_tsm_ops *ops;
+	struct pci_dev *pdev = NULL;
+
+	if (!tsm_dev)
+		return -EINVAL;
+
+	/*
+	 * The TSM device must have pci_ops, and only implement one of link_ops
+	 * or sec_ops.
+	 */
+	ops = tsm_pci_ops(tsm_dev);
+	if (!ops)
+		return -EINVAL;
+
+	if (!ops->probe && !ops->sec_probe)
+		return -EINVAL;
+
+	if (ops->probe && ops->sec_probe)
+		return -EINVAL;
+
+	guard(rwsem_write)(&pci_tsm_rwsem);
+
+	pci_tsm_count++;
+
+	/* PCI/TSM sysfs already enabled? */
+	if (pci_tsm_count > 1)
+		return 0;
+
+	for_each_pci_dev(pdev)
+		if (is_pci_tsm_pf0(pdev))
+			pf0_sysfs_enable(pdev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_register);
+
+/**
+ * __pci_tsm_destroy() - destroy the TSM context for @pdev
+ * @pdev: device to cleanup
+ * @tsm_dev: TSM context if a TSM device is being removed, NULL if
+ * 	     @pdev is being removed.
+ *
+ * At device removal or TSM unregistration all established context
+ * with the TSM is torn down. Additionally, if there are no more TSMs
+ * registered, the PCI tsm/ sysfs attributes are hidden.
+ */
+static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
+{
+	struct pci_tsm *tsm = pdev->tsm;
+
+	lockdep_assert_held_write(&pci_tsm_rwsem);
+
+	if (tsm_dev && is_pci_tsm_pf0(pdev) && !pci_tsm_count) {
+		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
+		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_pf0_attr_group);
+	}
+
+	if (!tsm)
+		return;
+
+	if (!tsm_dev)
+		tsm_dev = tsm->ops->owner;
+	else if (tsm_dev != tsm->ops->owner)
+		return;
+
+	if (is_pci_tsm_pf0(pdev))
+		pci_tsm_disconnect(pdev);
+	else
+		tsm_remove(pdev->tsm);
+}
+
+void pci_tsm_destroy(struct pci_dev *pdev)
+{
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	__pci_tsm_destroy(pdev, NULL);
+}
+
+void pci_tsm_unregister(struct tsm_dev *tsm_dev)
+{
+	struct pci_dev *pdev = NULL;
+
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	pci_tsm_count--;
+	for_each_pci_dev_reverse(pdev)
+		__pci_tsm_destroy(pdev, tsm_dev);
+}
+
+int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
+			 const void *req, size_t req_sz, void *resp,
+			 size_t resp_sz)
+{
+	struct pci_tsm_pf0 *tsm;
+
+	if (!pdev->tsm || !is_pci_tsm_pf0(pdev))
+		return -ENXIO;
+
+	tsm = to_pci_tsm_pf0(pdev->tsm);
+	if (!tsm->doe_mb)
+		return -ENXIO;
+
+	return pci_doe(tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req, req_sz,
+		       resp, resp_sz);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index 1f53b9049e2d..093824dc68dd 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cleanup.h>
+#include <linux/pci-tsm.h>
 
 static struct class *tsm_class;
 static DECLARE_RWSEM(tsm_rwsem);
@@ -17,8 +18,39 @@ static DEFINE_IDR(tsm_idr);
 struct tsm_dev {
 	struct device dev;
 	int id;
+	const struct pci_tsm_ops *pci_ops;
+	const struct attribute_group *group;
 };
 
+const char *tsm_name(const struct tsm_dev *tsm_dev)
+{
+	return dev_name(&tsm_dev->dev);
+}
+
+/*
+ * Caller responsible for ensuring it does not race tsm_dev
+ * unregistration.
+ */
+struct tsm_dev *find_tsm_dev(int id)
+{
+	guard(rcu)();
+	return idr_find(&tsm_idr, id);
+}
+
+const struct pci_tsm_ops *tsm_pci_ops(const struct tsm_dev *tsm_dev)
+{
+	if (!tsm_dev)
+		return NULL;
+	return tsm_dev->pci_ops;
+}
+
+const struct attribute_group *tsm_pci_group(const struct tsm_dev *tsm_dev)
+{
+	if (!tsm_dev)
+		return NULL;
+	return tsm_dev->group;
+}
+
 static struct tsm_dev *alloc_tsm_dev(struct device *parent,
 				     const struct attribute_group **groups)
 {
@@ -44,6 +76,29 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent,
 	return no_free_ptr(tsm_dev);
 }
 
+static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
+						 struct pci_tsm_ops *pci_ops)
+{
+	int rc;
+
+	if (!pci_ops)
+		return tsm_dev;
+
+	pci_ops->owner = tsm_dev;
+	tsm_dev->pci_ops = pci_ops;
+	rc = pci_tsm_register(tsm_dev);
+	if (rc) {
+		dev_err(tsm_dev->dev.parent,
+			"PCI/TSM registration failure: %d\n", rc);
+		device_unregister(&tsm_dev->dev);
+		return ERR_PTR(rc);
+	}
+
+	/* Notify TSM userspace that PCI/TSM operations are now possible */
+	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
+	return tsm_dev;
+}
+
 static void put_tsm_dev(struct tsm_dev *tsm_dev)
 {
 	if (!IS_ERR_OR_NULL(tsm_dev))
@@ -54,7 +109,8 @@ DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
 	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
 
 struct tsm_dev *tsm_register(struct device *parent,
-			     const struct attribute_group **groups)
+			     const struct attribute_group **groups,
+			     struct pci_tsm_ops *pci_ops)
 {
 	struct tsm_dev *tsm_dev __free(put_tsm_dev) =
 		alloc_tsm_dev(parent, groups);
@@ -73,12 +129,13 @@ struct tsm_dev *tsm_register(struct device *parent,
 	if (rc)
 		return ERR_PTR(rc);
 
-	return no_free_ptr(tsm_dev);
+	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
 }
 EXPORT_SYMBOL_GPL(tsm_register);
 
 void tsm_unregister(struct tsm_dev *tsm_dev)
 {
+	pci_tsm_unregister(tsm_dev);
 	device_unregister(&tsm_dev->dev);
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
new file mode 100644
index 000000000000..f370c022fac4
--- /dev/null
+++ b/include/linux/pci-tsm.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PCI_TSM_H
+#define __PCI_TSM_H
+#include <linux/mutex.h>
+#include <linux/pci.h>
+
+struct pci_tsm;
+
+/*
+ * struct pci_tsm_ops - manage confidential links and security state
+ * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
+ * 	      Provide a secure session transport for TDISP state management
+ * 	      (typically bare metal physical function operations).
+ * @sec_ops: Lock, unlock, and interrogate the security state of the
+ *	     function via the platform TSM (typically virtual function
+ *	     operations).
+ * @owner: Back reference to the TSM device that owns this instance.
+ *
+ * This operations are mutually exclusive either a tsm_dev instance
+ * manages phyiscal link properties or it manages function security
+ * states like TDISP lock/unlock.
+ */
+struct pci_tsm_ops {
+	/*
+	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
+	 * @probe: probe device for tsm link operation readiness, setup
+	 *	   DSM context
+	 * @remove: destroy DSM context
+	 * @connect: establish / validate a secure connection (e.g. IDE)
+	 *	     with the device
+	 * @disconnect: teardown the secure link
+	 *
+	 * @probe and @remove run in pci_tsm_rwsem held for write context. All
+	 * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
+	 * for read.
+	 */
+	struct_group_tagged(pci_tsm_link_ops, link_ops,
+		struct pci_tsm *(*probe)(struct pci_dev *pdev);
+		void (*remove)(struct pci_tsm *tsm);
+		int (*connect)(struct pci_dev *pdev);
+		void (*disconnect)(struct pci_dev *pdev);
+	);
+
+	/*
+	 * struct pci_tsm_security_ops - Manage the security state of the function
+	 * @sec_probe: probe device for tsm security operation
+	 *	       readiness, setup security context
+	 * @sec_remove: destroy security context
+	 *
+	 * @sec_probe and @sec_remove run in pci_tsm_rwsem held for
+	 * write context. All other ops run under the @pdev->tsm->lock
+	 * mutex and pci_tsm_rwsem held for read.
+	 */
+	struct_group_tagged(pci_tsm_security_ops, ops,
+		struct pci_tsm *(*sec_probe)(struct pci_dev *pdev);
+		void (*sec_remove)(struct pci_tsm *tsm);
+	);
+	struct tsm_dev *owner;
+};
+
+/**
+ * struct pci_tsm - Core TSM context for a given PCIe endpoint
+ * @pdev: Back ref to device function, distinguishes type of pci_tsm context
+ * @dsm: PCI Device Security Manager for link operations on @pdev.
+ * @ops: Link Confidentiality or Device Function Security operations
+ *
+ * This structure is wrapped by low level TSM driver data and returned
+ * by probe()/sec_probe(), it is freed by the corresponding
+ * remove()/sec_remove().
+ *
+ * For link operations it serves to cache the association between a
+ * Device Security Manager (DSM) and the functions that manager can
+ * assign to a TVM.  That can be "self", for assigning function0 of a
+ * TEE I/O device, a sub-function (SR-IOV virtual function, or
+ * non-function0 multifunction-device), or a downstream endpoint (PCIe
+ * upstream switch-port as DSM).
+ */
+struct pci_tsm {
+	struct pci_dev *pdev;
+	struct pci_dev *dsm;
+	const struct pci_tsm_ops *ops;
+};
+
+/**
+ * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
+ * @tsm: generic core "tsm" context
+ * @lock: protect @state vs pci_tsm_ops invocation
+ * @doe_mb: PCIe Data Object Exchange mailbox
+ */
+struct pci_tsm_pf0 {
+	struct pci_tsm tsm;
+	struct mutex lock;
+	struct pci_doe_mb *doe_mb;
+};
+
+/* physical function0 and capable of 'connect' */
+static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
+{
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	if (pdev->is_virtfn)
+		return false;
+
+	/*
+	 * Allow for a Device Security Manager (DSM) associated with function0
+	 * of an Endpoint to coordinate TDISP requests for other functions
+	 * (physical or virtual) of the device, or allow for an Upstream Port
+	 * DSM to accept TDISP requests for switch Downstream Endpoints.
+	 */
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ENDPOINT:
+	case PCI_EXP_TYPE_UPSTREAM:
+	case PCI_EXP_TYPE_RC_END:
+		if (pdev->ide_cap || (pdev->devcap & PCI_EXP_DEVCAP_TEE))
+			break;
+		fallthrough;
+	default:
+		return false;
+	}
+
+	return PCI_FUNC(pdev->devfn) == 0;
+}
+
+enum pci_doe_proto {
+	PCI_DOE_PROTO_CMA = 1,
+	PCI_DOE_PROTO_SSESSION = 2,
+};
+
+#ifdef CONFIG_PCI_TSM
+struct tsm_dev;
+int pci_tsm_register(struct tsm_dev *tsm_dev);
+void pci_tsm_unregister(struct tsm_dev *tsm_dev);
+int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
+			 const void *req, size_t req_sz, void *resp,
+			 size_t resp_sz);
+int pci_tsm_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
+			const struct pci_tsm_ops *ops);
+int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
+			    const struct pci_tsm_ops *ops);
+void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
+#else
+static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
+{
+	return 0;
+}
+static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
+{
+}
+static inline int pci_tsm_doe_transfer(struct pci_dev *pdev,
+				       enum pci_doe_proto type, const void *req,
+				       size_t req_sz, void *resp,
+				       size_t resp_sz)
+{
+	return -ENOENT;
+}
+#endif
+#endif /*__PCI_TSM_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b8bca0711967..0e5703fad0f6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -539,6 +539,9 @@ struct pci_dev {
 	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
 	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
 	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
+#endif
+#ifdef CONFIG_PCI_TSM
+	struct pci_tsm *tsm;		/* TSM operation state */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
 	u8		supported_speeds; /* Supported Link Speeds Vector */
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index a90b40b1b13c..ce95589a5d5b 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -111,7 +111,13 @@ struct tsm_report_ops {
 int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
 struct tsm_dev;
+struct pci_tsm_ops;
 struct tsm_dev *tsm_register(struct device *parent,
-			     const struct attribute_group **groups);
+			     const struct attribute_group **groups,
+			     struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_dev *tsm_dev);
+const char *tsm_name(const struct tsm_dev *tsm_dev);
+struct tsm_dev *find_tsm_dev(int id);
+const struct pci_tsm_ops *tsm_pci_ops(const struct tsm_dev *tsm_dev);
+const struct attribute_group *tsm_pci_group(const struct tsm_dev *tsm_dev);
 #endif /* __TSM_H */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ab4ebf0f8a46..1b991a88c19c 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -500,6 +500,7 @@
 #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
 #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
 #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
+#define  PCI_EXP_DEVCAP_TEE     0x40000000 /* TEE I/O (TDISP) Support */
 #define PCI_EXP_DEVCTL		0x08	/* Device Control */
 #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
 #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
-- 
2.50.1



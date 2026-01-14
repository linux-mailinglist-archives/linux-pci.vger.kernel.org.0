Return-Path: <linux-pci+bounces-44772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DC7D201ED
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC48D3001FDF
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818A73A35A0;
	Wed, 14 Jan 2026 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbMp+OH0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F1D3A1E8B;
	Wed, 14 Jan 2026 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407307; cv=fail; b=HhhVxDV9P9M9YmP+pzqEsex3WMbaabL5zcS08SL+dCE+Pc7U+/ai7xzCGDtKGF8gdjytk8GjnqGHFVBDBh6YDEocG7V+Im/xA2ABIu8kyys0H0IiHofaBGjoFFBvclJTiD50fJbmo0taAzBWYyk34PiqOVbWF7tj0HIWu1kOHZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407307; c=relaxed/simple;
	bh=aWFPxn83/JyN5zkFEy0hEIa4TJ+JgKw6S25sRhxrod0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=dcBwjurdrFsUTkEojG6WKFzR/twQ9TODNjw69rLCtW7wSvdgEVJopw+B0kGmBXhjMJjZr16a5aAhyV3RW33xJOkMCGp86kaiOmpoppq5fwmBYFilw7u5s2rGx3Uw/MgaN/deNYu3MWxzV8gxvDAi2DHaZSNxvmT31bLxRktMCrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbMp+OH0; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768407304; x=1799943304;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=aWFPxn83/JyN5zkFEy0hEIa4TJ+JgKw6S25sRhxrod0=;
  b=LbMp+OH0klgXuTP3rt9YjSabezeLXkB1twOZeqsxuRa1gNZjGuYORKnf
   qR+V528caUrzas2zqXB2LunE6HVv44ZZfXnZeRm5TV4pGwabF0wcuosWh
   gIT5VNb9678fUHH0hJxLlAszK6CRhJWVfOr1h8CDv7dOOfvUDbZJ44Coo
   0d4n1HguEc8EaXA+KJpHf6z/0WK8qaZWQqFBuBkIx7kbu4TNNKyY4/3W5
   wdN5sEucXxj6oEyMQ4Lod0dJg98tJws01e4jhrOcSv+SqG0cd7nurKaZw
   /qC+wv8+ZwTMsUWoqfhcV+xo3PQoa0IPhxvq/xI+67yDSPQtYqxuC4eL1
   w==;
X-CSE-ConnectionGUID: 0nNJMpUhRmqcwdctTSa3DA==
X-CSE-MsgGUID: 79brP4tuS/y+aMNZcf0n5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69445278"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69445278"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 08:15:04 -0800
X-CSE-ConnectionGUID: 8pqpYVxVTJSwx06iCzuEeQ==
X-CSE-MsgGUID: Ow3HXS/cSK+u3a/5Q+cEGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="209766353"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 08:15:04 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 08:15:03 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 08:15:03 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.18)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 08:15:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvRlP3drrDVfamxT480da3LVGacP5/Yd36eb0+KSHmlhnOrUW+HHOfjQpfr4pS4EJH88hgABFcKgPO/l4faKUc4iO2DOw3thBrrvWmwE+2Gi+whdjyNIMkVcXRv8edxt5akInVN1TwABIQxCFNUsGUTxBYGM+Q/99EGawq7L+QUG4bSn79ntCojvk6PWmufTWIgtKTtGeTD3RME16b5rn1KDQIPq98P2g1qdKRUCtNnAHR/9miQKPAQfwFdE8e0/VazRUJpc9unv5ePXSFGhb44CXPlEAUd1O/fQWZjd/pLy++ft8eqnLWApCvjdRYgYbFnI7GZ6GRMhwx0U2ffdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JZtxWlEvgtFlj4EqCc88BB52BSRLoCRXwzOiqoFDso=;
 b=pxcCnghBCrpkMKFLzP6smHCNpHLfVGQ0TjtY7iIuuI3hHSebNDzQF62eSUHbiWhuo+3hUQ1mb7IQ+n7vq2ifJzueKkm722RLdbGK9yQfK789yKAWMacPICgcljZchAUrktzqoSiSyQG6Qza3itcBuP9lf02Bh0H5j+K1Q1f8aaN9NSRKYoddeqF5sG+RSyMlOKaDu4kV2pB6V/3oaB6EQ1BtUsVqOfBM1lfDJK8mo2Hx6cloudEKQ9jMFcKRMORaZo+da9aVp9ehKpVe01arHj5vnBJM0ojZ7h5ZY++bsC+X5xoILZuH2ioKcfq1Wb4z5md9W5DSMjen3kfnfBLApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4925.namprd11.prod.outlook.com (2603:10b6:a03:2df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:15:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 16:15:01 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 14 Jan 2026 08:15:00 -0800
To: Bjorn Helgaas <helgaas@kernel.org>, Li Ming <ming.li@zohomail.com>
CC: <dan.j.williams@intel.com>, <linux-pci@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Message-ID: <6967c10429f19_34d2a10027@dwillia2-mobl4.notmuch>
In-Reply-To: <20260113191003.GA776139@bhelgaas>
References: <20260111073823.486665-1-ming.li@zohomail.com>
 <20260113191003.GA776139@bhelgaas>
Subject: Re: [PATCH 1/1] PCI/IDE: Fix reading a wrong reg for unused sel
 stream initialization
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0064.namprd17.prod.outlook.com
 (2603:10b6:a03:167::41) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4925:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b7fe34-9ad0-4142-fbdc-08de538811e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFJNa2l6T0ZZRTMyYkUza212emEyT3RIa1BNTEtPemQ1Q3J3MHg4ZzJnUGl5?=
 =?utf-8?B?TjNMU3RiZTNDMldxQUdSZUsyTnU2cHAwSGIramhBZDRkbXBxb25ucmhXc0ZK?=
 =?utf-8?B?aFZyQWhrRElsclFZNnJnb04yQmkyUEs4Yjk2cTFPaVZxSGhnS2pyc0JrUnZE?=
 =?utf-8?B?YUh2cFNxRTVPcGVrY1NYc1Y2NE1JbWcrVGwxWnRFcjhxRVM5OTJRU0JyeWxU?=
 =?utf-8?B?ZE5SY0s0M3RiaHcvQWNTcGZCbXY3UFl3dXk1T1ZocDBPVWhBS3dSMGt0cCt4?=
 =?utf-8?B?c2ZZV1dWcEJjTFVURUxWMi9tdkd5N0tXN0pUaW1nMlZ3YXd4N09YSEtYZ29j?=
 =?utf-8?B?dDBkb1FzWHpLck02dlNyZHB0MDh2NldZbU5pTFRoNWZUWHB5T2o4YU1KblpU?=
 =?utf-8?B?VHNMK1VlVk5STStFcXJMaEp6eDRHUzRXQnNVZng5VDlYMTFyMkk1YWo4ZEFz?=
 =?utf-8?B?ZWdWZzJ0Y09tSk9DSFJDdTlZTEU5bDU2SCs2OGFWZklqNjlPVUE2aXNLYWor?=
 =?utf-8?B?aVQxWC81a3ZOWG52dms2L0JmQ0MxVTJDQXBqZFFaRmRsZElJQkdZM1E3L3N0?=
 =?utf-8?B?bWNwR0xxOGUxcit5T3JtN1psZTJpRnhrZzR0WUQrS3ZER3pXVms2NjFtcmdq?=
 =?utf-8?B?VFExK05seVpRSW9KUzBCVGRyZnFZVklxMmVGeUc1amJOcU9pSVA2SEF3OXZJ?=
 =?utf-8?B?MzBndTlLWnNwemFaNlplTDFtaFJsaWs5eldCb0szSnV6UWwyQmI2R052THZQ?=
 =?utf-8?B?UFhXdHFQazdkRmRJRTN1c3dOUkxnaXEySFJwemZUcWUrZ2NJL0JOT3FEOS9x?=
 =?utf-8?B?RlRLRCtDbGtGR1dlWG9BR3VualU3VHFVRFZvVU5YcWltcUVuaHBjWTRhMjV5?=
 =?utf-8?B?YVZncUttR01icGNwemloTi9lMzFTc2hOT3lqYzlTOFVCaGxURHpIT1JkY1ox?=
 =?utf-8?B?TkJkbm9VWG5yc240dmZJZ2lXanpFRGN3bVlmeXk4QktFK0hWVVJFZ1dPMzN1?=
 =?utf-8?B?SFpjQkdBMzdFbUtLbjIzWkZtZWYvVHJON1RPRU9LQ1UwRE9JWjhESGEwZDNl?=
 =?utf-8?B?UWloUDR5Y05wMWdzMEF4eUFIL3h5TGk3ZmlMMUN0RTAxRHFyc1FrOFRxZWU1?=
 =?utf-8?B?MVBrRmRsY2pIUERQa3pncDRFV0RGTW5XaXVUZWtmNlFnUmkzVnVWTHdaZUlr?=
 =?utf-8?B?OVVGSXdIQkM5L0xIVk9FM2lDZmt2REtCaHMvcGlpbGt1cmVCY3RUY3plNjBH?=
 =?utf-8?B?UHB5NmwyZTBSL09WT3FDMGp5VjRJSUhzblJJeTVsWE45V3EzazJiWlFQU1h4?=
 =?utf-8?B?Y3g2L2g1R28rZ3VDdVZ6NHBUdTV4N2RCejIxRWxQM1g3OHBHOWpLdDM5aURW?=
 =?utf-8?B?eU8vekh6V0xYVW5iOHdXc1IrSU90NmFqOWFXWlo0ZlFqZFdQRFAwMElXd2Q0?=
 =?utf-8?B?R2sxNTF4cjVpUXpmbnpHeHl5S0FqWFlTc1huSW1BVi81YStsZDd0T0p5UXRM?=
 =?utf-8?B?RXVkOENqSThiQ3FVL0JRaDVNMUFQTC9tUlJCd21UWHhjZWphU0xyWHhJbUZG?=
 =?utf-8?B?TTVSYnJtR1JjaStCL1UwaTdsY2xiMDVhRXF2eGp1UWpDRHlqVkZEN0VTZ0l6?=
 =?utf-8?B?amVzZzRnaW91VW5sKzhtMmR6UkdKK282M2cyN29tdTlKTFM2Y2Q1aVhvVXhW?=
 =?utf-8?B?R1ZVeGZJeG9iS1hReWFzTWlzSzZZWS8xSVhQRXdyOWhoSVYwNzhFeDBSUld3?=
 =?utf-8?B?SnJqcSt1cWdmVy9yYlR3b3FWWjB4YUo4ekhnWTMyR2x0Y0ZOYW0yZE12QzRJ?=
 =?utf-8?B?QVlTTEZUVlVoeE1Va0h2MmY0aWMzNlM0S0wxVWcveko3OEk4K2d5cEhVc2FK?=
 =?utf-8?B?MnNZUU5jekUrUDJyTEYyN0tWa25pUlV1STZVUWJxR2hxUTE3OXd6ZUFLdDVM?=
 =?utf-8?B?eXdCMTYxRm9qMlMzMDdhazJJRlBkMzJpWHVWMHdwZmY5ZHY0WGt2QVNtd3Ru?=
 =?utf-8?B?c0dLYkl0dHVGS0M1czdQcVhZdUlEZjZPNGFmdVFuTEhwNUJIS08yMVdlcE1H?=
 =?utf-8?B?V29kYy9KbTM5alk2TjYwSTFIYWc0QlQ3MkVvUkFhYzlLYytBb1E0bURIYmoz?=
 =?utf-8?Q?EOD8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVZaWVlGbk84dmVKRld2aXlHYWM0czc0eG5Tbm5uS0cybXNFbWtHc3hOU0Yv?=
 =?utf-8?B?T2hkV3Bra01rc1BQbTc1RzNGdXhFdEFUd2l0VnlJNHRxeTBPRnNSaXNHdDBt?=
 =?utf-8?B?b0NMd0JwUFNaWHFXbXduK29SZ2l4QjllTDQ4MFBTTjZYbG9JUDZWYy9qYWdD?=
 =?utf-8?B?V1BWMEU3dUlHSmJHdldCRlhEeURBTmFXdWY3a2htWjh2cWNENVNzLzNXMmVy?=
 =?utf-8?B?Z1l4NFNQTlE2THJmanBBZGxhYjZxUithc2lBNG8xSklJcU1IdDVnSFFOcHlC?=
 =?utf-8?B?R2dKKzN3QlNVdVN6eEtSdUJscElpYVJzSE5QUXFvWTkzTlhUeHQ0S2hxMVdV?=
 =?utf-8?B?cEpEUjlDamN1WEx4SFJFU3Qrelpzd1JFbEpMRjkyY3ZWL01HTDVRZDVidjBL?=
 =?utf-8?B?SmxuK2tERnNWcUhEckdXUnFTN0pBUkp1TXl6Z2hPaUpoT0k2VXZzdTl5TGgz?=
 =?utf-8?B?WUdlQTNoQk1ycUdDYkpWSmdVYTB0RWR5SytZcFZWRGlKb1RQdjN5bFMvb1pk?=
 =?utf-8?B?dldCbEU2aWVGTzMzMmJaeEpkeWEwR1pJc3hsczZOQzNaSWsxeFpHalBCWWU3?=
 =?utf-8?B?cVR5aE5vaHdxckJIRWh4SE5ZTnFEYnl3M0RuTDJVVmtob0Z4RFAxOGJuZmMx?=
 =?utf-8?B?ZFF3dU9YL1Q0QXdxbmk4SU5uQlJmOEIxVlpYZGpIMnpZSmdWSG1EQWdwa3RR?=
 =?utf-8?B?M0NxWVNIK3B5NUxzQ0dnK0JQTEhINzFrNDNicVY2dU1FNFRpQjlIaW5FL1lQ?=
 =?utf-8?B?Q3hBdm82Rytncjg0RFhWa3BrUFVnUmN6OHdJOU9KaUtKNEM1VzlHVkZSbFBx?=
 =?utf-8?B?N3BkN2Jub0RrdVV4NWkwT1lKdVozakNHYW5ZTVFaUG1BL3JRS1V2MWF5VVhF?=
 =?utf-8?B?V0xRM1I1VUgxQlkxUytuZy9JRjVHd2tYZDgybmtpd1hPSjAwcXc1bUR2N2Ny?=
 =?utf-8?B?Zk9qTjZOejVFWnhIaFBHYzdsamJTVld5NFBVcE1CWERhbEk2b1ltSTJ6aXRj?=
 =?utf-8?B?Mnk1OUFWdnd1UGZBL3NzV3BFaThDVXNXNmlLdi9uZ05Qb0FLODlBU3NlZUFX?=
 =?utf-8?B?aU0yRi8wdzB0ODBzcHZPbmttVUorMk1VTkNvbDgvYXFxc0RNelhWVWdUVnVp?=
 =?utf-8?B?OEk2MXlOY3hhOUVnQ1dybGlRTUk2Qko0NlBFVlVMYWsxdEhPVGNSZldGenNJ?=
 =?utf-8?B?K0dzeVprbjVrV2orRnJlZkg2UWl4Skc1a2NCNnk1a2w0dXp3cGdHb1BLVzFM?=
 =?utf-8?B?aldBYW5aQ1hva0xHSFAwUXVpOGR2TmhBV2ZtTDZBQjUzeTI2OGFSVklVOUYv?=
 =?utf-8?B?MmRHWVBReDdCLzFYT2lpVzlMbXVseFpGSy85YnNQL0d1SHB5NzIxYjVyUDFs?=
 =?utf-8?B?TmRnbzVkVFo0bFhrU0NJR0tYTytLN0xXVnB0Qzlwa01rZStjaEdpUE1KaUNI?=
 =?utf-8?B?bXJITk9CVDhXdVpjWUJ1RHpYTmI0d2NPZ2lYQXoxY0RjaG5CUDR1TXA5blpE?=
 =?utf-8?B?c0RGWENhbzk2UnBFVHN0bE5wSVVIV09mTTVSdHR2aWZvMG5vTmFNVVU1T1JU?=
 =?utf-8?B?N2hKSWx2QVlKRWI2UlRmSWRDU0l6V3FxdWlndW5NamFRc0NQazZGNGhJSitF?=
 =?utf-8?B?Vkg2WWlQaS9GZUJYWWhqeURKa3VWREgvT0JCNVBzUFFibXlwMy94dytiZitF?=
 =?utf-8?B?VFdrU01FNHZOOVBBalFwa0JtazBwa3cyMk1YQjFqUXpjMzdiU25OSmpSV1NX?=
 =?utf-8?B?VlZkQ1RZa3ZMQzM5VkltaC94MnBIOHo2TkZjeUk5ZHFmaDlrbUlKSnN2N0Z0?=
 =?utf-8?B?eHB2RkpKSlVFY053T1QwVHZPVjBCdzdDdVpleVNoWkF5M1RNWm4rT2VaQWJT?=
 =?utf-8?B?ejV5Y1VZeVZ5cmduUnVZQ3NYMEFPQnZGakpSUjRjRk9tbXVqZnNVWHFrUUJu?=
 =?utf-8?B?OXF2L0xSL2E4dWZtUWVoWW5zejcvcGlyTVQ0Syt4Vk9MM1RFQ0liTU1sWnBU?=
 =?utf-8?B?L0RzM0l4Y2NEMzNscDN5K21NSjVXbVZOb1Y5WUpqWDRDZmtLQ3laaDdab2Fs?=
 =?utf-8?B?ZjVmMjRyK05yanBmZm9lVkQ0MXV0cEx0QkpYK2hKYjRrb25sOVQzOWdmOEMz?=
 =?utf-8?B?QlA3cDFhdmt0RWdZelRrZ2s3bmVtQVNBN2N4a1dCeVdVT3NaVmlHaGZXVWJm?=
 =?utf-8?B?aGk4bDh2NFJYVE1QTG1OUGZ4Ym05bmpGb1QxMUVoLytqMkt3WVJtd1FLdWtt?=
 =?utf-8?B?RGNnU244RjJtZFdJY20yWkZxS0xRWEJ1Q1MwR1UxODJMejJ0ZHRKTVJiWDNM?=
 =?utf-8?B?d2lCemxRcHpJUUd2bEVld1dXSU1KN1AvMENFeERlNitxbkhYd2p3Y2l3RkUr?=
 =?utf-8?Q?b9Y9+9gKNENuu02A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b7fe34-9ad0-4142-fbdc-08de538811e2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:15:01.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNCKDBZCio7DTDTH6R/jxk61XSbPNK7zILkIdYFliOh8bc6QtOAeZHBLBg4nx/QVblXLGNya/kEAoxTfWTP4zKK0RJcO7/32zZR89V7elzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4925
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Sun, Jan 11, 2026 at 03:38:23PM +0800, Li Ming wrote:
> > During pci_ide_init(), it will write PCI_ID_RESERVED_STREAM_ID into all
> > unused selective IDE stream blocks. In a selective IDE stream block, IDE
> > stream ID field is in selective IDE stream control register instead of
> > selective IDE stream capability register.
> > 
> > Fixes: 079115370d00 ("PCI/IDE: Initialize an ID for all IDE streams")
> > Signed-off-by: Li Ming <ming.li@zohomail.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Dan, I assume you'll take this?  It looks like you've merged
> everything to do with ide.c.

Yes, I have cleared some CXL backlog from over the holidays and will get
this queued.


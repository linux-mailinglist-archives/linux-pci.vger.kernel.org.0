Return-Path: <linux-pci+bounces-41190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB89C5A2D5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 22:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F9D0353048
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 21:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D561324710;
	Thu, 13 Nov 2025 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKWBtE6Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92335957;
	Thu, 13 Nov 2025 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763070167; cv=fail; b=ZsdNrm7dv+mRIR2t3dzU0pm5gTEyKmOy26PoyGXaHqMxucNxITBaSNurwtn2PF+dJu42nQ1S/D2oKP6gSKsQ6bYF5jsPTFYLCj2DrQcBbaFsJhcZNeN60Y8lGDjDYGtwb12xPlcvaCFhrpC7MTtv3u9naepFAeMXyxnTjort2HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763070167; c=relaxed/simple;
	bh=7/C+2a6W2DK8BZTe/E9F7ZyFa7SSYlQDD+NVidlQ/eA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QAOR8QHwLYxBoPrc0m5VIpIVVjbuzmn94TSyqKfo7gsz918XOQHrWyDHXPRj4XXX2gFJ5Pao8cjn06+jxDL5Is47aFVgGPpXbLmlmkyaASUgQl7nDHb69PJXOVGyCn3Po9uhc5DaVDoTav97xycifAYVTkUx/OhI6Gdhv2LQHlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKWBtE6Q; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763070166; x=1794606166;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7/C+2a6W2DK8BZTe/E9F7ZyFa7SSYlQDD+NVidlQ/eA=;
  b=NKWBtE6Qsw6GBvRe/eYVGngpewr8YjyVdhMYp41/3x0DGejEQg3iGNaN
   XECBkqPeU3a1W7GHikk1Pcst8hrRqly8NiKAkM9lxKi0BQTq92aL2wMvP
   OvKSk6Vl1Jt/e2I8az0GKAeohCphd86DBdMs2CSxYkV8bpDRxBmkj4N0t
   lQvqZsCPAw/T01DTwlGJ7VjEeSl0c/X3Yoj6dzDkQXI8fF4DCpRkA9kiv
   hOm7y7E3Z6b049d6a2BX/0kQz2jdQEdYaKFKeugh+jsAIbwPMCUACyNbJ
   3WAKL8ZUhVt6FHFSe5QLNmLxaGhRkUbvDatZNenoW7U/M1dXXyhzSmv3v
   g==;
X-CSE-ConnectionGUID: vwKjfeesSImPqT/Ow+za7Q==
X-CSE-MsgGUID: OJVHILUHRPiR2Pdx5+aVag==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="76507553"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="76507553"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 13:42:45 -0800
X-CSE-ConnectionGUID: tjcMLp5tTAW5eIs/gxpTTg==
X-CSE-MsgGUID: XH/bz04DSUG6b8RMXpzqkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="194594695"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 13:42:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 13:42:43 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 13:42:43 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 13:42:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYp65ZgBa+7avQe6Ac7HsgGB7kNJHcY+z5YR/QNgIyVrzrKcNCG5ROPlGrxQhLDqvA5NrI5OhHplpLw80F1tPNRWdB+U9VJB526NGqXcN3KNNDb5SzdKy4m/slCVCYuhKlt3npioNdylgYhpTzJj/cnhk56+9cjVDcVlKKuczmlEmfI9PEOwE6qlPWuLHLpv6HA2StpdbbsuU+olO1ECYZexOFHtZVzK3lhgEBDtwxToq2pducZrHlHfL5FA9y9B5sQESrDcODnM9YX3wFqJd/dyc+kVDRniAG/vOVJ7VEA0JiaTGmYOGXeiqFEZhdH7sXoKvg3nrJde0L0guUsEzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvy3sjKoTEjnyRuE86HvGyZKkl+IqLraclTL5G944cE=;
 b=L4IVCTlwC6bLLI2nVqGxZWLoGFC7ay8TY1l/SDRd/IAGw5n5/80H50cKtJSWzyORw5abF8bAO2NlclRgkuSgHaMepw4KUwkcBxuyZW6zJUP2cIKpVwbS3NiK3a86dCC2KCWnaC3eNwe2Usp4uhIeoZOMYq0Rr2TRU+QzPi619tkXHVkrsFOGKWr8QGQbOOymuQzSMuU37J1LN8sC4+HpNBezDpRsE2cMhiSO6F5J+adazvHa8A3kRy9G4HQJj+h/1S8Gr0PlpHM8A8mW4HUihEBeSeunqe4N7/xOnNhD8dd5hRn7ci3dWTosRUHLDCD3DD/1n0t4dWxjEhYe1CIASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH8PR11MB7094.namprd11.prod.outlook.com (2603:10b6:510:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.14; Thu, 13 Nov
 2025 21:42:39 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 21:42:39 +0000
Date: Thu, 13 Nov 2025 13:42:30 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [RESEND v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check
 for bound driver
Message-ID: <aRZQxoK2AjPKLkqV@aschofie-mobl2.lan>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-18-terry.bowman@amd.com>
 <aRL08Y8g35xAzGLA@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRL08Y8g35xAzGLA@aschofie-mobl2.lan>
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH8PR11MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf3a822-f136-4a7b-c8a7-08de22fd916e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KRqsb+tvLFRFnS/PCq1FL6T6mywvbOg4MTELg3oRpJVhQhKuyGZlh/sgZrkw?=
 =?us-ascii?Q?LwVGs3psl6zCW0VHZIdsI4iT0jrH5pyKDrHAd8ZTXH53cFbGoPD0B8pUv/rB?=
 =?us-ascii?Q?d4erWLuH7xAU60/L6Vq6rdG0+0tPmfvvbK4cogA4byk7s5Lzkfrv7ssTLZ34?=
 =?us-ascii?Q?enffrsU91aJXmeVnCr2buHTD96tTMWcMxJoCg4AcSye3b/M8YnA5vd7fsDRR?=
 =?us-ascii?Q?y1oiRSb54fMArgF1y56xHbvixEQfGnNCswlu9vcXqrJqxByztJTM1QV0Jqjo?=
 =?us-ascii?Q?+iuDQe4OFo7j22c5ifSAMz5+RLV5xpH1uurwkgjt4qqN43YltS96BhB2UrUs?=
 =?us-ascii?Q?WM9B6zypc42V9/fhMhxR1S/Yv6LYkGTHd+f/XCSV0fJEbLYnWhu3JZbFeAJ8?=
 =?us-ascii?Q?qvExBQy2+g/uo5jn0ZhWAS+emqB6USdLnzdQPFG6/TxastFr6Se+o4uoHPlG?=
 =?us-ascii?Q?Ki5+BhOgAygsDDrYZc9gQsFYry0h1rbwdH+Iu9JWA4vlPMYdDn2Ivmgn7KZi?=
 =?us-ascii?Q?8tIbIcZICIDSxaAUgY19UKBWfUB2hRevKt2UcngnycDBzv9DFcD8CkUcZPU9?=
 =?us-ascii?Q?wb4F9k/CF8WdS11ttjL1f12mZoGAggd2kfcB9pwVsQgMbctfUuLHRE65STr+?=
 =?us-ascii?Q?ETkEjB3C6Zdp+i/2Juzx4GcVzPmo1qUVsxZeJO21Wk7ezT1o3IwSvkcAjGZp?=
 =?us-ascii?Q?lrOMdAXwzbIYWjbELoSWOwDUtRftXu8OFsAbClgnse26jrEfFn+V+Z+YGJj1?=
 =?us-ascii?Q?5iVMiSxFu7vNQkApLPmpsdAdlg1lygcWTEzRKfO4iE8AhMNKDIzVTx7WPFXN?=
 =?us-ascii?Q?gmfEiUb68/0E4ymP4mbDeqH2lnSUmZn+QCi/p9um/rgxB1ru3XPTG+fqaXyX?=
 =?us-ascii?Q?I0xYXASOtcIxVcoNYRedKRzcRyWK3M4BFqT5Sl0+5BwE1DXKMFm7AK41zc40?=
 =?us-ascii?Q?384iHnXIFH37nTgJ3tTwJ3MKKXkIgZbV6Oe98rJ6ylMhkHEHebTUVe9f+QfQ?=
 =?us-ascii?Q?UbbPLDqzXNthk+5gBtkLtpQhLa3V0qhMtBZUSAkZhwzBDO5g6j3H+IsIe+cL?=
 =?us-ascii?Q?7KFmNYc27YuZBG3QmQXmyNDV3C8K4BXaCsD0JyvM/gr6NdL1ZLApjaCe2sUe?=
 =?us-ascii?Q?dc9pSYxDEEYKZTnwtUVQoxTkCkS6GRlQucrb3BNnFMEYiKCRtR7kg4iNuVMh?=
 =?us-ascii?Q?P9m56CZlYt7OsQ1QQLSRhTghh+ZW5L2eATKiTGp1Ug+C4NE72FoH4D+E3dNM?=
 =?us-ascii?Q?rv2tpd14ytZC4K+xcMH7SOU+32PWDopoGEWvPP+m1niOmt2FQtTq1SsJW2T6?=
 =?us-ascii?Q?yVRL5KCvJoAdhLLFD5ue/RSQwr2cuinsY6e4KS3DXFtWeqBhG03bOEGw7Ai7?=
 =?us-ascii?Q?nY4LC+nKP9djG/hkrvuf8fvhwmozyAuLCOihDqBVzn8KYuoEAbwNt/JVIqLZ?=
 =?us-ascii?Q?M7K+/QU3uP6LZA+Q8egxWevBOPMCPN9a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZIE7ZTYt02KDLEiaZUMjwnAlaKoHztmOSZxzdfcsOSHdxRJhs2E+NCzWIxOZ?=
 =?us-ascii?Q?rN4Yjx5qDkwxCYtP+G8lzoqOCB0iJaiQntnEu2e8FO/+ibFgM8o0VNp/Z+d+?=
 =?us-ascii?Q?avGZg/R3NJZ+k63ySiRyj/7JzhmA0iBsIn/EGHJTiVg6I7G53bpHDrGoj5H0?=
 =?us-ascii?Q?a84ih/12LXXJUq5HHiHwrXP7HUHF0uAjK6U7abGJBTtlbY8XYZrq2RgIwZxy?=
 =?us-ascii?Q?msqt7EPQ8XmkcyO8RhaI0XEZzBqxRq+mI8/3PY1WX1GsH8jfIFgd0arW/UcB?=
 =?us-ascii?Q?Ap+OD/2Co5zkUiY0cd7v77zq4bFequH4ABiqU8EveiWvWTeiyANmuw7E7gOT?=
 =?us-ascii?Q?DLu6ALexFSkvWVvaQ5uKPaliPuSMsbYqx6UJhE+0JtIZRaMlGJ5zyZZFl0BQ?=
 =?us-ascii?Q?G8Tk7VjnenID4zI3F4+0pTCfRhW6yvDQd2gIg8MAjSIWlktbF2CdLIlFYdYp?=
 =?us-ascii?Q?Bw5i6zj2auZASXFqv6p1dOAAIwyV1BGLEiV2Opq88fgZQGEVFc4Ke5gurt02?=
 =?us-ascii?Q?H/6vS+aFmTt7e5InBE9hni/y4oGKb1ywBo95Bkg7NbYP3+EG+hR0uJKrczPt?=
 =?us-ascii?Q?wCF3wZKUYgCdj/YCMZUuK7VMzXUCWGZ8JAz4/KnobLOVawwHC9mn+j+DpH+A?=
 =?us-ascii?Q?FTH/OkvEdaxaTomLa+gNdq1x53FoLaL+EqFyPY15Hd3AOWTB44l4imZ4S4yL?=
 =?us-ascii?Q?N9INXrDjyS4gV4oDXN+vmACKFdMUUSfrrALcU2OXEpxjww2A/14r9NyUmvB5?=
 =?us-ascii?Q?RwBdWkp/j8gfeXzQnymXUA64kxlaSDA8VcNLPnBSdy469yUUg2h5ldG5E5Ok?=
 =?us-ascii?Q?yEstlogFQW7aMaKvLMM/ckJ3cZ7Z24Xm2Twms3Om32bueh2nRl1+lBN7hIT+?=
 =?us-ascii?Q?aACwLi17wj/X52XUuRdbTovo40YE2WEh2+NPD6a7vweL5dGEKFvg5vj8tBUh?=
 =?us-ascii?Q?T954pp1iA6cms6ZU3FAP3+3MXtJsvhAhcdmttE7+MrLtY/tvmb5tmllIuqhy?=
 =?us-ascii?Q?RaeKWC8GJmSNC3GKtLVhec+y7KZ3bv3PKzg+HLyV0+ic2JpwblFpqr3DSYz0?=
 =?us-ascii?Q?7mkA6yF7VyJtH6r96K3xqj9kjVsd2JEi7QHzVW0f7xHLEZSXCHCY7m5k4NH8?=
 =?us-ascii?Q?xKsTOd9wAKv3d3OXihHKEQtoApfzwNxGLO8r0jLfTaSynRi2GmvjB2OiBO03?=
 =?us-ascii?Q?EORmevUkswNuE+TmgqXz7n6SXCHfwOP5O3PtbN/chigsLwS0/YfiexbMqpYv?=
 =?us-ascii?Q?RilZyISs5BhW4R9JIe0Zos285UJObiqmU9l1ZPXZ1kZQvamPlmxB0OBKu+v+?=
 =?us-ascii?Q?OW+vkCycAtayrLdU4MamPhgmi8bdpeX7QJcKinc8lcB5gYno8kkoXd/h3XT7?=
 =?us-ascii?Q?tIl2k+83imFaXRu63moln2EFUcmF5Iis48RaRQUjOYVyGjPNX2hXtNHO2QCk?=
 =?us-ascii?Q?JcduUFqjXE0Mz+pHRR8yqfbn6JZbRTfzFfv2vrUPLVWtav9qhruajqlxw/d8?=
 =?us-ascii?Q?r+c3EvYmV1fQ5fkXfnNdqKlFmHHclkvt0Y20f6Gkjvcqz/UA5sm6bFVuESSL?=
 =?us-ascii?Q?S4nHz5cppObsH50wwx3MaN1eci7xaFJOzqlZXXdG3zqMMsX4BrzwnM3nzWut?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf3a822-f136-4a7b-c8a7-08de22fd916e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 21:42:39.7547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZS1wmSPiQigQP8XlzBQFPMezJw9de3AKiuIZLtaF5qmmvTBqwWXqUBbWDBRyp8mS8k7z9WPjxjEcwLVKGSf3KUJxIch+Gy7DRBwTiKMxAV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7094
X-OriginatorOrg: intel.com

On Tue, Nov 11, 2025 at 12:33:53AM -0800, Alison Schofield wrote:
> On Tue, Nov 04, 2025 at 11:02:57AM -0600, Terry Bowman wrote:
> > CXL devices handle protocol errors via driver-specific callbacks rather
> > than the generic pci_driver::err_handlers by default. The callbacks are
> > implemented in the cxl_pci driver and are not part of struct pci_driver, so
> > cxl_core must verify that a device is actually bound to the cxl_pci
> > module's driver before invoking the callbacks (the device could be bound
> > to another driver, e.g. VFIO).
> > 
> > However, cxl_core can not reference symbols in the cxl_pci module because
> > it creates a circular dependency. This prevents cxl_core from checking the
> > EP's bound driver and calling the callbacks.
> > 
> > To fix this, move drivers/cxl/pci.c into drivers/cxl/core/pci_drv.c and
> > build it as part of the cxl_core module. Compile into cxl_core using
> > CXL_PCI and CXL_CORE Kconfig dependencies. This removes the standalone
> > cxl_pci module, consolidates the cxl_pci driver code into cxl_core, and
> > eliminates the circular dependency so cxl_core can safely perform
> > bound-driver checks and invoke the CXL PCI callbacks.
> > 
> > Introduce cxl_pci_drv_bound() to return boolean depending on if the PCI EP
> > parameter is bound to a CXL driver instance. This will be used in future
> > patch when dequeuing work from the kfifo.
> 
> This one was troublesome in cxl-test, more circular dependencies.
> I noticed you and GregP chatting about it, so I simply remove it from
> the set for now (made all callsites true).
> 
> With it gone, the set builds cxl-test and passes the test suite.
> I'll watch what happens with this one, and can take another look at
> the cxl-test issues if they persist.

Hi Terry -

I took another look, suspecting the circle issue started with the
move of pci.c into the core, and not necessarily your new additions.
There are two functions that are wrapped in cxl-test and now with
this move are being called from the core and creating the 'circle':

cxl_await_media_ready()
cxl_rcd_component_reg_phys()

Both those need the 'restrict' method, like for Patch 14.

Once that is resolved, the new function cxl_pci_drv_bound()
seems like it needs mocking and will require the same treatment.

Suggest doing it in separate patches. First patch does the move
and the cxl-test work.  Then a second patch adds the new function
and it's cxl-test support.

--Alison


> 
> A bit below...
> 
> snip
> 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/core/pci_drv.c
> > similarity index 99%
> > rename from drivers/cxl/pci.c
> > rename to drivers/cxl/core/pci_drv.c
> > index bd95be1f3d5c..06f2fd993cb0 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/core/pci_drv.c
> 
> Needs:
> +#include "core.h"
> 
> Compiler is warning: no previous prototypes.
> 
> snip
> 


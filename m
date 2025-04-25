Return-Path: <linux-pci+bounces-26791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01534A9D460
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 23:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765679E706D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C26C21CC49;
	Fri, 25 Apr 2025 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNmmS8LS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AD020C000
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617408; cv=fail; b=XPap07ePcKEdBfKduW5Rp3l3TVfSc998R8cHctbvcLT47ctJuQi/cpnlFq5uyJK2l7l1KmKEfb3zfNPC1y2DGh39/9I8M/xebMi3KScdD5dDiU4kR1g5z62kE5Yf+p6/E8Q5MFZDgACfKdOBbQCqNKobcQ2qyqFfqpZrVSgU7xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617408; c=relaxed/simple;
	bh=EqDOBJ2xYK+l7boDIh127VdOF+MWad9Y/pmHIiA2MkM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kakxb8zMDOpApi0o33Ib+VZXC5PTZYfhSkApmEwLZ83A7L/nA6RNZdaN2Y0LUHiJvF+x5LKx4JHCc8CBjS4Cds96SrpjewOCz1u2RRlxxzy0rgui8iYgaovKPDoBdiSFhBNY8cCj7clnV3XMW7V9P58wqf940fB/xLCprhTycE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNmmS8LS; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745617407; x=1777153407;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=EqDOBJ2xYK+l7boDIh127VdOF+MWad9Y/pmHIiA2MkM=;
  b=KNmmS8LSDlISeQan10tfmGvyN2IfAxSs75WoGwT9JnBzb2BnoBvLhlPd
   XjPdz+sr3IJjxPVVMMVUppxkbDXAlsf/iNWslyLT8pgoZh/4DM/lpxHry
   KjT6Jw/ZGZhCU3IpZcWuMnis2+p0MV/AsBYyEJRFlIOnpxo/MSbR9h3QM
   oIYCbivfWzA3xlaoHYYTeoFkn9aEdjf/rSmY0eae/5TuIu9SMRHWGAqGO
   tKF5NYkUUarvayz13x7rVUDtiYezEplUFBVn2BjKALS/R8ZigZIwgd63h
   1Oz3DznHgPXJO6UvfRR9rIjQCYV0FRSAlBtEw2xzGvtac4hphbIksP72f
   g==;
X-CSE-ConnectionGUID: 8jnfTGAnSZ6YiBY8XJJlKQ==
X-CSE-MsgGUID: ij7t5lzhRU24NfJXdc6/Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="50959063"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="50959063"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 14:43:27 -0700
X-CSE-ConnectionGUID: HWt9G2W1SjK6xee9hItajQ==
X-CSE-MsgGUID: fDsnY9RKTzG0qPxN3UmCrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="132994452"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 14:43:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 25 Apr 2025 14:43:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 25 Apr 2025 14:43:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 25 Apr 2025 14:43:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5evjgoannsi+/2f5Y2X8zZURaloV6x3i5RgoSECRum3gl6ERxt+4TS+e0+CqddaJwwz6MJk++EB8GGvysH6ZeuilA8zpHxVxjiR41JTItcTGHrnphDVXBiMHef/4djXV63RP6KOjwzEIKICheQihjj8R5cCHL2YYY1YA9scD70PokeO4qDuygEyPHp75kJ0aqTo1utPOKrtVdUTNaSngKkl4QreEniZoaqlPbI9NgUVb8p3IMyLkXCUIa3YPDv05uXtruhMTL3lwmBolXCux7xRfcLc6SUyZourn4ij6HYG43ZmfT2uNEU2I7qNyTN/bUgMRROfrgsGzWeQBtTxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xI88XfP3s2BCTZ38IIet2EwcZsSHmwbABt+fA14G4U=;
 b=HfmoIYEdgRsImuWutP8HjCK126Epv6L7RVUDYwAivnwzk7jOsZ76JnQlBwwlM08I85dZvsqfnqZxKLIvfLPf78emBoJ1GtoS9n6Spvq7Ao/yOrtM793XJePKd39HhBx11daULEmPGdgFnTJh6QC0NjS14BdKtY399JAcRpjeio8PmTT9idglz0lCsuA0zKIW2/rCX2lZOhyraQkrxqwoFWGAqe1rMT+9NdIvxis5O12LSFfZ2rPupm1I5ioZPlotyumwwxJF5raIXUlxsuqPg59jUih5UWURFmZQlN4lkTroJ2r2PV38QQg5lWKL0XbVJ8pxBmQiGbu/RFH0FazY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB7157.namprd11.prod.outlook.com (2603:10b6:806:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 21:42:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Fri, 25 Apr 2025
 21:42:54 +0000
Date: Fri, 25 Apr 2025 14:42:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<gregkh@linuxfoundation.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <680c01dbe98b2_1d5229497@dwillia2-xfh.jf.intel.com.notmuch>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107250147.1288555.16948528371146013276.stgit@dwillia2-xfh.jf.intel.com>
 <e4be5f20-c3f5-47aa-aa8b-1ac714a0f238@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4be5f20-c3f5-47aa-aa8b-1ac714a0f238@amd.com>
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e92bf5-0156-4fa7-e420-08dd84422314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWQzVDJQcGVYMFpqQkZwVU1WU1o1cm9CTngwR3RBQ2R2UXBiMGs4VHlDM1gx?=
 =?utf-8?B?U1pmaDBNeXZkME42ZlZqTlpTODJFa2xSOGtrOFZTbGVxUlVIQXhabHU3TnQw?=
 =?utf-8?B?YWpVMUczZ1IxTHdCSXFsL0RKdXVTcTZCNHN3c0JQcGpWeUlmWFR4OVlmV0k3?=
 =?utf-8?B?OGNxd2JBTEtONncxNXlXcUVJNEpRTjhoVGNNMkx4Q25ZaG1kTXZuQ1JDZVpK?=
 =?utf-8?B?eVVCdWo0VVJrNUhzMlhoRHgrd0NyU2Q1M3FDY3VJMFUycmhnalVFUjZ4Qk52?=
 =?utf-8?B?cFd1Tm5HQm1ObXNKMU82NkgwWHBlZjF3YnBtd1VVQk5jWmJ6OHZsZlFRMVhG?=
 =?utf-8?B?Z3A3NmtTaTBFRmFXeUhjWkQ2dHZ2Wll2NHltY3hjc2lYTmlvdE92UzBtMDBY?=
 =?utf-8?B?cldyY2hSN0VzeGVDOVhLc2s4MVFtNUlkYWRSK050Qk9KaEFoUDBaL1VxM0U5?=
 =?utf-8?B?YnM1azZCUEJSNUdWTmQ1d2VzU2tkZ3dBNC9qNFh5WmExd3F2aUpWZ1pjQkJ0?=
 =?utf-8?B?UW9iQWR6NnNBTWxRN1NkdlVkWVFScTAvVzBBTTJFT2JOWjloTURyeERzVGNy?=
 =?utf-8?B?VXZueU9NeGtMK0xncUFMNWFuSXJQK1hmQ1lBNzEyTUJYQ0hmMmk2cWpkVEtI?=
 =?utf-8?B?M0kzQkpEcStQZ2NCYnE2b3RWRWR2WmErb3FyZDlTemQwWXdzeHZCNkpDQTd6?=
 =?utf-8?B?RUcwRmYxcUNnT0dwL09IaFY5b1NMNGIxNGE4dEZIeFVwMDkzaS8wL1doOGlS?=
 =?utf-8?B?b1dGdVFPV1JvZ3I1MlIyL2c3U052bCt5Rkh1c2ZJTEsrdTZIc1lJTTQ0STV2?=
 =?utf-8?B?OWxzSEtrQXFMTEtjeUdXbk1xK2lXeitSd0hYOHVQRWN1SklXS1gwTW5rb1lm?=
 =?utf-8?B?c1VZUVZTQ3FXV21Ec2s3YWd5RHRWalVTbWJxOHRqZWhWSzAvZEx2NWF3cVA5?=
 =?utf-8?B?aGpGT0tBQ2FYenpJcXI4ZHg4UlhzcC9lZnd6dkJhK1JzLzJoREJybEJ6WXlD?=
 =?utf-8?B?djZTbllLWXhSQUswQnVQSGtNOXVDUi9LWW1RTGVPaEhvTWdwaG1RNEhueFEv?=
 =?utf-8?B?ZFZsRkUzNnJ6VkFZKzlneWZPR0hVRlVaUDA5SUhGUmV5eHd0MkxEZzk0Smdl?=
 =?utf-8?B?Tjc3NG83ck5lb1Ntc0lPNDBuUm43VEFQVkJLaktZQUJqS3Z5SWRSOTRjeHNt?=
 =?utf-8?B?VmZhY2tzc3NibWlQbnNPQ0dYSjBMTkVHclZjTVRGbWNnUzBKWk14azhiemhT?=
 =?utf-8?B?SEsvOU0yTEdvVmNBQlBTK29zbkZULzVxQWg0dklLZk5WQUlJNi9KZmZuRHB2?=
 =?utf-8?B?RlI2WDVLL0gvQmErMDY0UWFsQmFzRFhMaEJ3N2hJSkhhTUZ1dUlxRTRwamp3?=
 =?utf-8?B?TnZsbG1DMnpMRVc2LzdUcG9UVE1VY3dFZmZoem1BdmQzZXNmNnV2OVdVNVBR?=
 =?utf-8?B?MTV4SXd1Y0t4cXg4aDlJTXExTERPWDRZbEIybEM2eCthbUNMNDdNMEY2a2h1?=
 =?utf-8?B?NytlNXJEeHBza0RLaTFVMVhvS2ZYZU1rOFhGWUlvb0NGNXB6bjdMM20wcGhH?=
 =?utf-8?B?K21JNFhNazg1OHdOZTZHcVM3U25qeFBTeHJ2eHhjZThiWG1xV3ozSm0xS3A0?=
 =?utf-8?B?MWdQcEdPV2xZWGVUODBJOEZNNktvRXRUNWFScjlMQzNNbkpDdDlta0s4S1VQ?=
 =?utf-8?B?MHdkcG1Gb1NOczcwR3lmVkNoOGMyeDVEMnFYbHhMN2RGZUxHRmR0ejlTQzVU?=
 =?utf-8?B?WWE5aHpnMXcvdFpaTk5VNlRnL0J5NkFBWVVKeDR0UEQ4eDAwUjV1S3ZpZW5l?=
 =?utf-8?B?Qzk4S3ltRm8zcVdWRlZVYWUwOUpoWEJpRlh0TFA1SlA3MHFaN0pLazdnNG91?=
 =?utf-8?B?VkhNeTk1MmU2d2FRU2tlWGRKMjFvRmxGOFluZzlnbEJTY051ZEhVUkM1N2xT?=
 =?utf-8?Q?p7Z9tf/kt4Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3dWRVhXdDdhbXFPOG9JWi9vZGxWei9jNUZJTkRzRGRLWHpaMGZ1SnNLeTVQ?=
 =?utf-8?B?SFV0amw0Rk5DWGc2R2RQZzBWMENLTHA4SENkM0lSZUN0YmorM3lPRkJHMWRV?=
 =?utf-8?B?NCtQLzNQcWw1ZnRSRDVhUXN1UW5RbjFNTzU3YzZUZCtBQmRZcVZXbUlxNytI?=
 =?utf-8?B?R29RM1VSRWNTaE5hYS9iSk5xb3BscnZXYTNoSmxxVDg4bDVvVzYreGpNQVR0?=
 =?utf-8?B?RXM1eFNxS0tFck9JUy8wcldKeE9ScnRqcWk0a1c5R1F5VnJyemdodEcvYVo1?=
 =?utf-8?B?d3RJaGdTRGRPT2VqM1JaNUF4QWZsWTNVRGVxeVBLQ1VrdEVhK25kSlVMeGJE?=
 =?utf-8?B?Wm1GQnkzZlpyN05vcHRGbHJ1YjlzQm1uYk1MSWRWVVJuZWZVV1BFRTFrSzBy?=
 =?utf-8?B?NW1pQWU4YnZEc3pVdW5JV1VTenh4eFlBYkNNSldsdGlxc0graVg0SFVPMVBR?=
 =?utf-8?B?cmJvdzgydnozdU45THZGVE9PK1Q4UTBBMmJDZ2lud2MyZ2dDc1hNK2h2QjFN?=
 =?utf-8?B?ejk3UWxxSGRCbVAzeUNOWGFUclBsZjMvQys4RUU3R3h6NUZSc2pEcEpKQmF1?=
 =?utf-8?B?RDZGMExhdlpUTHU4NVlkQ0RpRnBqeVEwK3QxdWFFaHlydUVhbFBFcDZYbS9y?=
 =?utf-8?B?c3h3NitNNkVPWFo0eE9RTFZMSVJmcnU4VkpTZTRqR1FDTDRkUCtEd0JKVEJN?=
 =?utf-8?B?TmxlU0t0SkIzei9wOTdyREdXYzFYZkVPNkkzUkdrNE8rYmZrcm9LMCt4S1lh?=
 =?utf-8?B?cmxBaHZBbHFDakNndFJSWVo2NityVVV6SkorM0xqQnd6Z0Vwc2FreWpmWVlB?=
 =?utf-8?B?QTVyR1A0SGFjMW40ejZ4N0p0MWlaQndXTTBsTlpPenk0TTdPbExmendWREMr?=
 =?utf-8?B?SElpZXVLdUFjMEZQRWVGNEhpU3VXcVRUMTYrOWx3YXpoOGgwdlhFcmFVVWRm?=
 =?utf-8?B?Um04NGNOc21wWU1panRCTXpsa005bHJIWS90MVRVaWNzYnlVYkxHb0VKYnJZ?=
 =?utf-8?B?WndvTDRwUVVsMTJhckRVazlpWjlaNG5aNXVIRkliOVowWEFtdDlYV2twdXJZ?=
 =?utf-8?B?bWs1VTl4QytJK3lJd2JPd3lIU3ozcDBuaE9URFgyV3RPeG1GMkJkdThDMndH?=
 =?utf-8?B?dHBzQ3ZjZnRFVXdwaHJIWThMSG9aVEpaaVpXWnhhdCs2RTlPZE14RTVCalVH?=
 =?utf-8?B?Vmw2WmpKRFpnelBEN29NSDB1Tkg0L3hGV1NuaVZ3YUU5dW84QlJOQ2FDQUtS?=
 =?utf-8?B?ZGo4bUNDRXl5dEcySzRsSklkZ3E4MlRzRm82UkZrYWRRdFFUS3kySytleTc4?=
 =?utf-8?B?RGdZVEFBVU1ObFRZemEwN3FHQWYyTzhxc0ZTejJJa0hnSDk2Z0Z3Y2svSTgv?=
 =?utf-8?B?K2IzOVY4OTV1c2lVS3llOEh4azIxWG5jN1M3SFc3R21vZmNiYWJrREg4d1BL?=
 =?utf-8?B?L2thSFErbnhhZnpmcjdzZ0hmOEJmRngxRVduWVlnb2cxVWY5WUFRQzhiamRW?=
 =?utf-8?B?NGlKTStFWFhvOG05L3pKVFlxVnRSMFFxcnVUTXU3VlpZaVFrbmR1YzE4RUxV?=
 =?utf-8?B?NlU5SVl4UTY5RjBKZGZnYm1ESHErWDNTZDY2YmQvNmVsZit0b1o5ZjNNb20y?=
 =?utf-8?B?KzZRTnNJUnNFU1BjdTVLOUtUZWV0dElaQkUxRnZ6RzJaMFRNQUpOeXZHdjZS?=
 =?utf-8?B?bjEvNVMyamVZMFoxWkhjSnV6U0JyamZpREVDSW0rblBMRVRsUGxKblA3ZnhM?=
 =?utf-8?B?RmNZVnIycXRNdVNwNEM4c2RqWHpsd3N2SndoYzJUZnUyQ2tBRi94NmlvV0pZ?=
 =?utf-8?B?VnQ1MHY1Z0JmLzRUcjhRZkxWZkZ4TDMwckZ6cXpiZzZiai94U2U1YW9nSTVk?=
 =?utf-8?B?RjdtYmk0amlWSUs4aDhMZnEveXFYTmpRTGc3UitSQmR1NTRjSGtxV1pFTzZC?=
 =?utf-8?B?Sm5tVDNuQ3FQaFAxb2xCZVMvWVhCenJUenJuRjI0NnJ5TjljQkY0NUtVWDNy?=
 =?utf-8?B?R2N1NnhKakZXYjFXUmkycFFmcGpYMXZvb3VlQkV1dzlPb2l0VVMxdHRlTTNu?=
 =?utf-8?B?ZDFlSVh4S3ExQkkyeFY0eEhWVldqM05qZjdxK2lZdm40ZTRObmFaOE1mSVpG?=
 =?utf-8?B?U0hkYUZuanpuOWtud3hpNUNVSVM5TG92cDIzOFBaZFRZU3dERUUzUFBBeEFa?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e92bf5-0156-4fa7-e420-08dd84422314
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 21:42:54.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQhCiPR2ViRWaWeesXl8YAsV2Zhdqbet6VSDtG4izu0oCcXNbXc1ETZvCG9pKk3d6exz22ExoyrfZ9zkQcZCeKtyMNuf++1UyaXB01S9C/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7157
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> Doing it in one go as you suggest works with one of my devices but not 
> the other.
> 
> And to make things "clear", the spec also says:
> ===
> It is strongly recommended to complete key programming for a Stream 
> before Setting the Enable bit in the IDE Extended Capability entry for 
> that Stream.
> ◦ It is permitted, but strongly not recommended, to Set the Enable bit 
> in the IDE Extended Capability entry for a Stream prior to the 
> completion of key programming for that Stream
> ====
> 
> So are we going to do "permitted" or not "not recommended" (== 
> recommended)? Thanks,

So the spec is only talking about the key programming not the control
register, but if a device wants the control register to have everything
but "enable" set, that seems reasonable to me. Does this work for that
device?

diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 2b5295615a3a..4657138d3a7a 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -344,6 +344,18 @@ static struct pci_ide_partner *to_settings(struct pci_dev *pdev, struct pci_ide
 	}
 }
 
+static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide, int pos,
+			    bool enable)
+{
+	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_EN, enable);
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
+}
+
 /**
  * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
  * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
@@ -371,6 +383,12 @@ void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
 
 	val = PREP_PCI_IDE_SEL_RID_2(settings->rid_start, ide_domain(pdev));
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
+
+	/*
+	 * Setup control register early for devices that expect
+	 * stream_id is set during key programming.
+	 */
+	set_ide_sel_ctl(pdev, ide, pos, false);
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
 
@@ -411,7 +429,6 @@ void pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
 {
 	struct pci_ide_partner *settings = to_settings(pdev, ide);
 	int pos;
-	u32 val;
 
 	if (!settings)
 		return;
@@ -419,12 +436,7 @@ void pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
 	pos = sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
 			     pdev->nr_ide_mem);
 
-	val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
-	      FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |
-	      FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
-	      FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
-	      FIELD_PREP(PCI_IDE_SEL_CTL_EN, 1);
-	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
+	set_ide_sel_ctl(pdev, ide, pos, true);
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_enable);
 


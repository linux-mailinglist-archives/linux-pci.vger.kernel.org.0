Return-Path: <linux-pci+bounces-22592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE28A48942
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 20:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22FD188823B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 19:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7805826E96A;
	Thu, 27 Feb 2025 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ey6BYF75"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A04C1E832D
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686005; cv=fail; b=iwY8effD+Bwmqpfqnt+ogfLpXF4hUaZE4tc/5JEN8LlVNFH2JhacXjM1SYwjFiTg5I9yp2R9wd2qUNZEnd1RcptW6u8J2TcL8T+H751gf89Sw+1kZoWcnfok6i80ldd63ILV9NEG+QPe5dR8h22W/LXSSffwID/ARHsBO5gMpdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686005; c=relaxed/simple;
	bh=g1e01cnl77im5UxwZyRjlA5yEGPNqVwFBU2BzkptpGI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=imPNxTJpiw4GGHaw7x2aAVs39GmGyxszpIvII4ohDTA1KtXR8AW5JaoZGL2Iqjqa8yrS8aZ3Ol0d5effcTdIgFrubbheFC+P5SR1z+Rm4Fhmpq8uju927FNqmNBmomZ5l3AJ/rewOJRG4Lm6d81EalH1ugSapd6VVDafe56wIR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ey6BYF75; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740686004; x=1772222004;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=g1e01cnl77im5UxwZyRjlA5yEGPNqVwFBU2BzkptpGI=;
  b=ey6BYF756XCfFlrDMFdv9uPxUP7L1/o4T9fQq5fqkCMPq1vF1LLfVhB5
   WCU6SlEsstTtExmDVi8rAzBZ0fji7DP2kNNaItsnxs2fkDJbVjTRvkwKy
   1ZWYj6781a+Yp8fdoVuizDABV/Z7gOoh0OJuEVLCYRihTgLDPCgeIIUSV
   QjcM5sGIrsyotchlpXYawzmHqEYik9re/fAPYrqhJH/7MBEAKwFtLxLK0
   0VIEFXQ2MoMFtnWEZKogjNjYcAVKX5LVF+aCcJc5SNDpgaQjr9+ucdOwC
   p5i167+S+qwtJNDFOtk3F7rVb3EVQ2OxGReqSqVOqsjUB4GtJie0fU6Er
   g==;
X-CSE-ConnectionGUID: sddXuG9uTUyMRcJqRwwAMg==
X-CSE-MsgGUID: aEqjrk9HQNCyIBMgWrGAug==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="53007624"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="53007624"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 11:53:23 -0800
X-CSE-ConnectionGUID: oooBFZV8TRGUyHvuqz5JLg==
X-CSE-MsgGUID: jxJAXwaiTJKTBFniaR3SEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117782686"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 11:53:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 11:53:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 11:53:21 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 11:53:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nqnlmjh47m/6m39HpmEfDHKAWQ9BSKNCuugmiBka8wLvgPCezzZqJE3MNLLQlVbnxbybz61lqRhB438hfBNt7sGHvRNlvCbMyuI/TXijysrpphYBseDmALZCPh9YzJaK1SLOEtgDrMYgMV/7dyVGDiM54cyryW3LznqT2/RpokbCZcHgre9S8NS7tNXSTTJP3BNvGabn/Z/iLmCKNcM+PmMwPZmAQPibz2SYkAjHpnjGHpX+SnImoHIg6SeISrbVc/M2rTVzKGkP1nHZoCY4TBqMOd1OmDi7HmJA5PQLT4dFtapC7aNsaMIxFHgINwXODn/PMQQekcH5bXYgiQ+OSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXRXM6TzxaZx7IRSgOMChdhJLKX8Va74W/13cOBfT/c=;
 b=TRMKLl8CSDH6AXTG9Vx3ivU8DSZ5r1t+Ew1BFuH/cKq+yZH70QgsgEx2pXLgOuMjfR/WAfLKVQobmvu+YnNrQUdvlIgJmymdb02gBW17EbOcx3hSPFJVF1M9xr0Yk5mrVYsMir6pk5//ljaF3CmQvj02FC6m2LZT8wYAoLmKcR2xAgQ+uJOKAkxH6CHFC4lGIOk75jFet4lYoLiOJF/kBtKVRfJNJxZsjD/Zzm/KyZcS1JD96AVARmUpz/cmg5PYalWIKpWtoVBbL9nZ2p3Nvz3XSicNZzXFi7FYDEOXId9b55eQSNRTAqyQSAQ0ZMHmQ5E36J9kET4WWvt3RW497Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7011.namprd11.prod.outlook.com (2603:10b6:930:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 19:53:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 19:53:19 +0000
Date: Thu, 27 Feb 2025 11:53:17 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Xu Yilun
	<yilun.xu@linux.intel.com>
CC: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>, Lukas Wunner
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <67c0c2ad14955_1a7f294d5@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
 <yq5aeczrww9j.fsf@kernel.org>
 <Z71umSkkyV0rAC25@yilunxu-OptiPlex-7050>
 <yq5a4j0gc3fp.fsf@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yq5a4j0gc3fp.fsf@kernel.org>
X-ClientProxiedBy: MW4PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:303:16d::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bea0a7-7139-4e9f-22cb-08dd5768623a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aEd5sy6wV/SUwn+LZQDGc15+j2dU6yHnKihlCBAItc5o0bp4vI/2HY3NFSri?=
 =?us-ascii?Q?d+3gIWRLmZtGQ8v6b3dmzp7WFaxJ5ODwXcEwdekUB9SVHGkh2MUqdSMUkyo7?=
 =?us-ascii?Q?sAWYYpjRZs4Gu9eT2yc5btbYDkWoH2iLOD1h0LCCnmsAPjkPG08TWB70rN4S?=
 =?us-ascii?Q?xVp4W7gFKoxmKx4jhe/vLV6nRgp1cujoNhnTVQFfdOW993o7eKD5DH9ln6UE?=
 =?us-ascii?Q?T2wl+SS707uGB9aY/uS1ATTufGhzujN2StcLVGvRsgU7trT2/PjliRwzoXMS?=
 =?us-ascii?Q?bFTVTqNbe+tgWk0VO4Jkg16XBeZ/7o2rEPjTSf805FgAWZsfHxGi2r9JSYgh?=
 =?us-ascii?Q?Dn8WGI1I+724tgXS4jRxt+DRx2RlGAWTMql0ZaV3uyi/YI27alYNNxQt9K8g?=
 =?us-ascii?Q?HWuM5DKpNMz/ZgBh4S0NU3XvSEAaOrWRxQXXHSPUpOHQvqhoxyQ3QXNNeAuk?=
 =?us-ascii?Q?1GH0xsmWKz1kuLb5TZlOtYKUYgO35KNRoBp9Rc0iBVNUiRpvtgRlklf+T8Ja?=
 =?us-ascii?Q?L3ToirAasW1HfwqF5FVs2KKL+B384vqvqnv032noGadGMqN10kx7cQd365iM?=
 =?us-ascii?Q?rkxx1i+4iNk1it4xkrIFwSBE7AN+kt9KoJK2qYI9L9un1L1jHksVlktAD1ev?=
 =?us-ascii?Q?44GM+iOJ3mn3INVmlyiml0KqCO4B0rC/a7Ox+wLYX7BiT7PFn6i3VGSBgsSD?=
 =?us-ascii?Q?EuVkb6K2OY0aKNQllCS7u9zhGv4SdtlkADWEeiTwUW7S9wo+aMvi226DsGw1?=
 =?us-ascii?Q?K3NoSdBdg0S3R+WIJiijwFC/E539aPOpanFcSEQbG4r83k07s0X2OkPPiys/?=
 =?us-ascii?Q?QB2BFJrFcd/6yD4fofdYdMdF3imemNP9xcFm+1ztjfIPQQ5nLAe6fsib4UcS?=
 =?us-ascii?Q?676/JiareWPcllE0SnXTzf88ubgIlmyZyic4TF8hSuaClmjO7wfVOKfLPyQw?=
 =?us-ascii?Q?2YfNJ2KzuhhphOz70ifQAz/5V5AVR0xCiyljwrrr3PgDJxd61EiOCSSSLx/P?=
 =?us-ascii?Q?pfMQi765nkMZwdCAmRWgJYdbX4kkzW53p4Y0ldIDSc+7CmMxpUQllYkNf+AT?=
 =?us-ascii?Q?LqLPPvn3RhGo+e/nu91VvHbUm5fnqn3AsebayK8Om4G6SUxrDtCQlPBxEfye?=
 =?us-ascii?Q?/kDv7OMxV03thkB26tZfcoW7rBqDBkaRIM6M/KYdCZF2MWtL4G6oW2dGJJe4?=
 =?us-ascii?Q?EwlJ1ZXyd3ynkWsFER12tqNce1Ms14CPN+Mbl2+R+DnnLAzsc8mwqdCrLCa/?=
 =?us-ascii?Q?i12yQ2oC3PM4DoemP5WZ54QzpYAhj8/PLgIzd6VZlyVpdz3ZNOUd7nQtBi1Z?=
 =?us-ascii?Q?kmHdir+M3eSt84u7byvvNvDW89Y/V+edFG9DOFL3Ah6AXLANDuDYvuUt1ghY?=
 =?us-ascii?Q?Wyju5OWyOgGXXomHjeGqHF5FfOpI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xT4XCILpY1ly7bv1nOamvIp1opsqlqKk2/B5NEl71HyK4i+jQIWzA4RqjOi1?=
 =?us-ascii?Q?qorafQ4C/RU26HTNY2o4/A+Pcs3hJpyREOoW5t+GZpDFHAKdxOVljgIncnce?=
 =?us-ascii?Q?zLZzbuLgT3y/fCXtUmJiDQ78Yfksag5oTgDHOa1wUkVzyhc1mxsqWzVl9AdA?=
 =?us-ascii?Q?p6bhLIf4yjHLjTBL++PdNRLWAScmfygitFomPg6//cgbgFj4tGVwKlqOdwEz?=
 =?us-ascii?Q?5KE2QlplMyaXbb4+VDUqhrvDNMGrOr91kaBEwC3YZdL2ttculnZ2/gZ+VxMg?=
 =?us-ascii?Q?VlgR05tUoShCadBDCnU7a9ELudZP3dkvEq3o4cGeSIBFE3Uf+ufOKZfSz2vY?=
 =?us-ascii?Q?7GxtZIqjWGxdM6qCMwxkmkRm3cpWQ0efeMkfh2rHfqwdPa2sCrn8FpEzi6qa?=
 =?us-ascii?Q?ukZ0I1V9rzF/f+GEGFWpHxMMm8mgYJCaj1mWDRUeayBGH3mVGjsrz0vsAMik?=
 =?us-ascii?Q?7/Z2HLGMTrByPxFWAbDhNDfBlIsLr2guFgf8ZRhWkKVSjlI+WAfopDV1NlIU?=
 =?us-ascii?Q?6wT4d7jyy1hICQM96zgvoikbE4r0fvgcCc6MfGcVHQplVLiVYRFcHSM/JNup?=
 =?us-ascii?Q?sepRS8VWiq+LCrxBz30LHofxekGATiyZDuWFq8PdmyAYLQSAd5lF7bFWF0Y9?=
 =?us-ascii?Q?QoIEN2XtJ5+78pYke8TCpQjrxyctijkNh1DwDe0TJLC7LlFyVR0smq8g4+/F?=
 =?us-ascii?Q?CobYloEfe4rOhv/RXdn96/KWV0lyFeURBrtaly95gAePURi6iUQ1Qpx3BXSN?=
 =?us-ascii?Q?+V1NzDQpuLarJLugCmtcyE+8xyE4X4bC8C9eWSphTy5SKnytrgm5p2tdK2lH?=
 =?us-ascii?Q?P6y5257R1CNt1XToTiXDxdBW2qILrJ+ESDrv+qAThJbdzgO5y3WYijvIk59C?=
 =?us-ascii?Q?CTXzv6YSWpiiU4aWHJlWrehR2d6tCW6jM0fNgTzVxMYOj45o/SiaeveN91X6?=
 =?us-ascii?Q?lKYogh/8UBCejcbDdh5MI+VF3KxDERNq+LlIS8GAE4g4173FgQBj/iww9Q4e?=
 =?us-ascii?Q?oKpx0q0nq1MeswXh1isfyFse5A1pAQSYI/DJa6rvcyzWQWalYb00F7NOnVub?=
 =?us-ascii?Q?BupGCmfRsrop7kQaAySlz0I5HuNTXVe8JIex4onx2YU0HqIsDaIdTmmU+FnO?=
 =?us-ascii?Q?R5NCYm+aiPRgw2RXNhTPs4rndN28JbElN161a6S1EB3Q/p6sdiwnnFsoUs4p?=
 =?us-ascii?Q?P4AxDUGkYIYO8mr7rrB9LVx1zGLPyIVFvNTylVwiFln4oGVb9uJlJRDEDF7X?=
 =?us-ascii?Q?5o02qcJbbDRJJ2uqOxoBOK649+SWUi/q/Vw7PwNSUM+s+qExSDncQ2f9mIfC?=
 =?us-ascii?Q?XgOvpgGbAP8sDCdcRo4aAypjxXDWGSIxmoKDamAp7NWlxb/WVYh0ZjyrNMZ8?=
 =?us-ascii?Q?e5aTRPXLMFUKTDQG6wJG4pG5JCjXy6g0n4XvgXxY9glZx5l19rGcAR9kbDCG?=
 =?us-ascii?Q?gng9NbmXqlWbVx+juihyLBtvg8Uzeuvo+g9bW28QHUXt/I2jHv0cx6J5i+ft?=
 =?us-ascii?Q?UeISevJk3v6t/DTSfcT3aM+UcZeUrdJN30RJy3JL2WJgAqf+nLZhdkB4ucon?=
 =?us-ascii?Q?/F7mr5k6opgKYS6kuJ2DBiL40k9MRtRFms/BMerc4ScycEOzClzfif7ZkjRc?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bea0a7-7139-4e9f-22cb-08dd5768623a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 19:53:19.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQp/08S6yN0zeAqRtL9B7g2kojdO3ByjlY44YtknZPK7J5FxX7U8Ub/S5+Ib7BurEmjO6i/PbPfGQEVxIdPwtyvmXutGg7AW/rtRtBaNogc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7011
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Xu Yilun <yilun.xu@linux.intel.com> writes:
> 
> > On Fri, Feb 21, 2025 at 01:43:28PM +0530, Aneesh Kumar K.V wrote:
> >> Alexey Kardashevskiy <aik@amd.com> writes:
> >> 
> >> ....
> >> 
> >> >
> >> > I am trying to wrap my head around your tsm. here is what I got in my tree:
> >> > https://github.com/aik/linux/blob/tsm/include/linux/tsm.h
> >> >
> >> > Shortly:
> >> >
> >> > drivers/virt/coco/tsm.ko does sysfs (including "connect" and "bind" to 
> >> > control and "certs"/"report" to attest) and implements tsm_dev/tsm_tdi, 
> >> > it does not know pci_dev;
> >> >
> >> > drivers/pci/tsm-pci.ko creates/destroys tsm_dev/tsm_dev using tsm.ko;
> >> >
> >> > drivers/crypto/ccp/ccp.ko (the PSP guy) registers:
> >> > - tsm_subsys in tsm.ko (which does "connect" and "bind" and
> >> > - tsm_bus_subsys in tsm-pci.ko (which does "spdm_forward")
> >> > ccp.ko knows about pci_dev and whatever else comes in the future, and 
> >> > ccp.ko's "connect" implementation calls the IDE library (I am adopting 
> >> > yours now, with some tweaks).
> >> >
> >> > tsm-dev and tsm-tdi embed struct dev each and are added as children to 
> >> > PCI devices: no hide/show attrs, no additional TSM pointer in struct 
> >> > device or pci_dev, looks like:
> >> >
> >> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm-tdi/tdi:0000:e1:04.0/
> >> > device  power  subsystem  tsm_report  tsm_report_user  tsm_tdi_bind 
> >> > tsm_tdi_status  tsm_tdi_status_user  uevent
> >> >
> >> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm_dev/
> >> > device  power  subsystem  tsm_certs  tsm_cert_slot  tsm_certs_user 
> >> > tsm_dev_connect  tsm_dev_status  tsm_meas  tsm_meas_user  uevent
> >> >
> >> > aik@sc ~> ls /sys/class/tsm/tsm0/
> >> > device  power  stream0:0000:e1:00.0  subsystem  uevent
> >> >
> >> > aik@sc ~> ls /sys/class/tsm-dev/
> >> > tdev:0000:c0:01.1  tdev:0000:e0:01.1  tdev:0000:e1:00.0
> >> >
> >> > aik@sc ~> ls /sys/class/tsm-tdi/
> >> > tdi:0000:c0:01.1  tdi:0000:e0:01.1  tdi:0000:e1:00.0  tdi:0000:e1:04.0 
> >> > tdi:0000:e1:04.1  tdi:0000:e1:04.2  tdi:0000:e1:04.3
> >> >
> >> >
> >> > SPDM forwarding seems a bus-agnostic concept, "connect" is a PCI thing 
> >> > but pci_dev is only needed for DOE/IDE.
> >> >
> >> > Or is separating struct pci_dev from struct device not worth it and most 
> >> > of it should go to tsm-pci.ko? Then what is left for tsm.ko? Thanks,
> >> >
> >> 
> >> For the Arm CCA DA, I have structured the flow as follows. I am
> >> currently refining my changes to prepare them for posting. I am using
> >> tsm-core in both the host and guest. There is no bind interface at the
> >> sysfs level; instead, it is managed via the KVM ioctl
> >> 
> >> Host:
> >> step 1.
> >> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
> >> echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
> >> echo ${DEVICE} > /sys/bus/pci/drivers_probe
> >> 
> >> step 2.
> >> echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect
> >> 
> >> step 3.
> >> using VMM to make the new KVM_SET_DEVICE_ATTR ioctl
> >> 
> >> +		dev_num = vfio_devices[i].dev_hdr.dev_num;
> >> +		/* kvmtool only do 0 domain, 0 bus and 0 function devices. */
> >> +		guest_bdf = (0ULL << 32) | (0 << 16) | dev_num << 11 | (0 << 8);
> >> +
> >> +		struct kvm_vfio_tsm_bind param = {
> >> +			.guest_rid = guest_bdf,
> >> +			.devfd = vfio_devices[i].fd,
> >> +		};
> >> +		struct kvm_device_attr attr = {
> >> +			.group = KVM_DEV_VFIO_DEVICE,
> >> +			.attr = KVM_DEV_VFIO_DEVICE_TDI_BIND,
> >> +			.addr = (__u64)&param,
> >> +		};
> >> +
> >> +		if (ioctl(kvm_vfio_device, KVM_SET_DEVICE_ATTR, &attr)) {
> >> +			pr_err("Failed KVM_SET_DEVICE_ATTR for KVM_DEV_VFIO_DEVICE");
> >> +			return -ENODEV;
> >> +		}
> >> +
> >
> > I think bind (which brings device to a LOCKED state, no MMIO, no DMA)
> > cannot be a driver agnostic behavior. So I think it should be a VFIO
> > ioctl.
> >
> 
> For the current CCA implementation bind is equivalent to VDEV_CREATE
> which doesn't mark the device LOCKED. Marking the device LOCKED is
> driven by the guest as shown in the steps below.

I plan to switch focus to the bind flow after we achieve consensus on
the base TSM framework pieces, but my initial reaction is that
separating "bind" from "lock" is a finer grained state transition than
has been discussed previously. There are end use cases that justify
exposing LOCKED vs RUN in the ABI, but could point to the use case for
separating the BOUND vs LOCKED states?

> >> Now in the guest we follow the below steps
> >> 
> >> step 1:
> >> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
> >> 
> >> step 2: Move the device to TDISP LOCK state
> >> echo 1 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
> >> echo 3 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
> >
> > Reuse the 'connect' interface? I think it conceptually brings chaos. Is
> > it better we create a new interface?
> >
> 
> I was looking at converting these numbers to strings.
> "1" -> connect
> "2" -> lock

I have been modeling Host-side "connect" as IDE establishment on the PF
while Guest-side "connect" arranges for "bind+lock" on an assigned
function / TDI. Do we really need to expose "lock" as an explicit state
vs interpret what "connect" means in the different contexts?

> "3" -> run
> 
> >> step 3: Moves the device to TDISP RUN state
> >> echo 4 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
> >
> > Could you elaborate what '1'/'3'/'4' stand for?
> >
> 
> As mentioned above, them move the device to different TDISP state.
> 
> I will reply to this patch with my early RFC chnages for tsm framework.
> I am not yet ready to share the CCA backend changes. But I assume having
> the tsm framework changes alone can be useful?

Yes. There are so many moving pieces and multiple vendors that the only
way to make progress here is to wrestle the common pieces into a form
that all vendors can agree. Feel free to extend the samples/devsec/
implementation to demonstrate flows that CCA needs. The idea is that
sample implementation serves as both a reference implementation and a
simple smoke test for all the common core pieces.


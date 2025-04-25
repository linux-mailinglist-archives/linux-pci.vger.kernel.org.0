Return-Path: <linux-pci+bounces-26790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 680C1A9D3C9
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 23:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1931C0152A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 21:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B47C151990;
	Fri, 25 Apr 2025 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwXGXmyl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202DD20E710
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615015; cv=fail; b=NfNu7099BGcX3ESDWUpRVb8hx77iUEKlgddwMhuVHAiEx6lyJn9NsbvX2TWKQcxsb7/OjVnaUCKGpL/YFo3u1VJauJVtczDvCeOpvQAjFErPsBHI8VyhGCi8NqkNCN1zft5k4RA+UmWcThmG5SDMvEij8MMbfyLlehWE6lJwwlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615015; c=relaxed/simple;
	bh=+s/Y5fxhlETfE26T7rHG5QP5Ep3P4bn3Ng5XkiLL4Ac=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eLwrqSCE0u4xTlLl8S8KiB3Yg4uXwojtwmpLFyPUWgLIWraF0R0stGMmwCqIXXVWdjtYDzh60phXLImynpOI6MQoMnKfmMAGc+UKh7WVt5/8hJdfFmI8xNShwDCPk0OXAa59GnJR9XBR9eidlgBU4QzfIU+oUKwZiMHQ14aTfkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwXGXmyl; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745615013; x=1777151013;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+s/Y5fxhlETfE26T7rHG5QP5Ep3P4bn3Ng5XkiLL4Ac=;
  b=CwXGXmyl8Aln8UpWZNcWzEPpHdvQ/nUm+eGIGTKgrgsi/3nInU+ROJK+
   OlZYbBBqMvsqBaCymFk8jK0lwDm1Ma35kAoUzehw//8wajOTQEymoQ0qj
   I4Rr/ZIA8liX3vCZu2libCZNTJCs2uDpaXat42LCWY2iVN/6mXt1hBTJB
   QEYneLJptHdSWajzUvJJA+4HVdVcsTlaTtyFFC6K6x4dLP1i7yoWK3u/m
   fLvWc2RCnriFC1iX03oZguuDV3Gj3OjNUaFedGMhMxvrjVKoinhPbmPfx
   WL0CFhpkOVl/trxdP2sCGGtuN6gyC6/DY3XtQa0R8F62PztODkqLC7UHl
   g==;
X-CSE-ConnectionGUID: BZi/s2cvTWqA6Xi7zZpR1A==
X-CSE-MsgGUID: aXsbCkPvSo6ZAgMkG9HKnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="47162289"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="47162289"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 14:03:31 -0700
X-CSE-ConnectionGUID: +zqt7BbhTEiYlyR7wkPmJw==
X-CSE-MsgGUID: R9WPH912T92qc0VBZJtkyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="137981995"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 14:03:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 25 Apr 2025 14:03:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 25 Apr 2025 14:03:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 25 Apr 2025 14:03:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMMBg1GskT1xqRaLs4TrlipNU7wrmdBiInsz4TREk0RCLXOKLCgG/vww6AkQ/Pbj6f1qP4h3bWic1aI7L86fqq46kIwMGAyzUcvDleHGRrPIjHu2I96JANcSQJuaY6WnwqykIiQ9tmiyfL1BX34Pvo17UY0hO7Rw8OgKo8ZJnWCzQfT/8r7b9e5+W4SzrFye3v4BOpQZ07qGXZpmXPfkHXYhVuyiJBoOdxin50jaPft9DXX0bkGSL41oh2aiRobzNnZCGinJFXu39k1bgs5hhodB8ALGrCkdifQm3aw76npQj9VIMt55lj0S1BkHnOk37isqOIJtqIFIiZwcyMj0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbVp9jBw6LinxRGAmHhtR1mSS6pkRlsB/gmQWT5ylB8=;
 b=RMAjR6nCF3x2zjZqBPyo+t0ZmeVC62CZ1oaHCkCRfgUJb/7wOVi7+Cag0PymZ+C8Dd/yodgsBnHEEXK0plT3Kf9K1pxaWkPQeMQs9QUk2OcQVioxTYQKaY/yRXRFZAVrMSXNBUTj5sUkOl3zTXYcuRjWtMPhz8KTIVMT1Gx/Zn2FRvx6EyD27JSqZymrTdFsI+e8zRus2gG0ZTpv4TRzRx4P8q8XH5J2FIXaPoCYJMMLBmwu4zUJeooMNlZHJRmkeNHIMYcqXd9eio8R7fMbmCNvoYblUjcCIJCtNCT88UR15uR/ylowvn4Sl1Vq0O8zgjOjkRjqA1msNf2Fxj0UPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6834.namprd11.prod.outlook.com (2603:10b6:510:1ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 21:03:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Fri, 25 Apr 2025
 21:03:22 +0000
Date: Fri, 25 Apr 2025 14:03:19 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>
CC: Yilun Xu <yilun.xu@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <gregkh@linuxfoundation.org>,
	<linux-pci@vger.kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v2 04/11] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Message-ID: <680bf897ad3f3_1d52294b2@dwillia2-xfh.jf.intel.com.notmuch>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107247873.1288555.8934248700370548272.stgit@dwillia2-xfh.jf.intel.com>
 <yq5aa59sglvl.fsf@kernel.org>
 <114ef970-0603-4084-9bd7-6b25be54cef9@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <114ef970-0603-4084-9bd7-6b25be54cef9@amd.com>
X-ClientProxiedBy: MW4PR03CA0327.namprd03.prod.outlook.com
 (2603:10b6:303:dd::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 63812005-b21e-40df-96a6-08dd843c9cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k8ubDoAvn/4WXrnUiNEMcq9q1D0HuQvX3bcBzSGr/o2PeKCPPcbsujocqnCN?=
 =?us-ascii?Q?A5tCciuA8+8AbEHLYmtEvGcrvYHn8XyWclMMhjy5QRz7cFK+kuABzgzjHWrs?=
 =?us-ascii?Q?ZEZSRuVmllDGZfsqduCfOZrjOWh9OR/5r3JHWHNM5/FQFpTk9td3HjOQiIr0?=
 =?us-ascii?Q?pVmuRIQVZquo+WPC7Lg6Go565jeOEOwMzRwqG1ERLI7xyvE914WdLSf+rg/q?=
 =?us-ascii?Q?yTjnO28EYGmTsR+128shOYdHmCyc6MBW//CRirHwRIatjamfoSYGCnhP5duR?=
 =?us-ascii?Q?+Lp3PFawvT80QW7j/Bcjju8t9Jzy5NVU8HF8r8ss0G4yVLGDha98SP43Zhv6?=
 =?us-ascii?Q?KS8mYcKUs1Dez12D2SyxTrXu15H/kOdPZSPUkZ68aFgL53Rv54i7y5qbyugL?=
 =?us-ascii?Q?FVoJyViFnAzusSy2/iB+Q2sjjsZ7Or/+jxgJgkl8lSHyrsci294qsmXnumY/?=
 =?us-ascii?Q?faABPKKzh90wpSMp0FYK4X+AbUA6njq+tFffwyyurxise4QpTv6kWRK2AvrA?=
 =?us-ascii?Q?wvQyphOUMc+gAzhvDzb183l0rCwCGZTOJ2+Z3QzwzkCz5YqDWIW7a4D2ANhR?=
 =?us-ascii?Q?mpqlVy5eceDstKngNb3GjS+tFAGozUx37oNvuY5avSGqzFWOFIhyE6yw+Gpg?=
 =?us-ascii?Q?otRqcLsgtb5T0Mv0tlKSMiSTcmAEu6/q9TFES1p9+ewGDI6QrxAaM6YYcEMy?=
 =?us-ascii?Q?Lwyrgqaw9lR/zE/Y+GgcKNH6AiZEGbKVIlBV/Udyb5s1icC6bUeHfnM4olwV?=
 =?us-ascii?Q?mXy/TNqnRiStWsPgdUSy2PaPEzBTdhN7GD0tqczATA4HaG4Zb9nSPTpenhFv?=
 =?us-ascii?Q?db7lpYAybOhPZLlbLKCRsQlXu6RxW/Xxy8QM7PRKSzPHScGRZoouzcbC4J1q?=
 =?us-ascii?Q?W8GCWG0N2N2ItOF0vPsVG2i7zNfhuKFHPOV2oDpJ+GNqoOUmPda4PSHMYJUn?=
 =?us-ascii?Q?doqQ8f+BnHLgeW1fFOEONL7ORBv1c7lX4pdSm9EKb59SvF4Pqj1aLpbM0NZr?=
 =?us-ascii?Q?MBABPEHi+95mF3m7EytzuKCPUw3Pio7H7cH+Rq9fWFLNoWKeqoaeASfqIw/z?=
 =?us-ascii?Q?zy03wxHO5GnK0pHV4UtBL5YOVkpN0rIS3tbWSuMyq5poszLSzZwL70cnKsSx?=
 =?us-ascii?Q?jDTpUAwUXqF/cBmRVEJBtO1c9IUsrvCM3K5T/CQ4x2Penc1DOH/1XXj/jEJ8?=
 =?us-ascii?Q?ThWQ+HX+6mEHVDWB8EhAdg23zM+5I8HpXE5lh+5wxjxcEH6ARCw0uzguTO+H?=
 =?us-ascii?Q?FvxkwiPI5Qs/9MssloyA6fQZJblDkBxvu5G03sXCHGsdWUqmcUrUNYFd7tR0?=
 =?us-ascii?Q?dgQFySJhxA5I0EaHOqk6j3H6OTz7Sc4MVIMq+2M0aSd7ED1spsiXf3fAwElz?=
 =?us-ascii?Q?VQ1jR6ceInEkBZRrQb2SDEGiHJZ7CP3VNprht8A7F02dTBxo0rRWtsPkxUge?=
 =?us-ascii?Q?smgOmD8r8Uo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iMSgx7Gcxzu52NgW/WpjOOKJG1/KOa+z5N4ptNoDiRYFjKJrjWDh/6Iq0LeX?=
 =?us-ascii?Q?KJ4xtBSLjQ8Y0bIPx9fDr0lCIbf2de44S2q+ExNf9aIJjchzgdLhpfEmFU/J?=
 =?us-ascii?Q?iL6WQbduzDZ8R/YDdyNttTFKbmrAdAmHW7LvLgGbpMMPVr/LPLcrfDS9M1kz?=
 =?us-ascii?Q?ekC4zVnuZ5rHRpZ+xzsQ6vcTt0ikjl1DuT3gItIEMuSx9nTU8z/DcE/Oxitj?=
 =?us-ascii?Q?xouMXpf/k96roSlavQkdHcWPseYcFR0g++kN4IEZwOepHza7rho2UzstHU3q?=
 =?us-ascii?Q?G8jSWhsY8olxsgh/xQWmErjdIkUM83aJyaW/7KTZwjprvUdAyVGnG317+XVQ?=
 =?us-ascii?Q?YlPLzD8ZV176ija85nEgNS6/cEDQruKWqd0L7eRt8oP5UnSS784HWZHn8sIv?=
 =?us-ascii?Q?2GTwkXqKcsYKpwvrL+Xq2+rtrdCM9wAiD5pyOD+HKNfjhV+HKbA943u0nz57?=
 =?us-ascii?Q?R0ipSpvz69yXM0J+zH7v+faAhmghKFVXmHIh8nvGSR3FgKrh1mSo7vaK3xFi?=
 =?us-ascii?Q?fX/evP5CT2BdN2U73O7M9Zgw7n7R6lwUG/jLnhzqTzJ83MB4blQYD7h3Z7nK?=
 =?us-ascii?Q?3lwmu5ewbTgmqMfp0f4P0NvbiW4wuZp0CCo7VnTYm6GnA34GhpAT8VaE8ePE?=
 =?us-ascii?Q?qqX2sFTTdw9H1NHMULcqXK3/+epSN8fUB7hxaTYPoUVTxrT1JViswBx54lDH?=
 =?us-ascii?Q?42hmpleocB1+Iv3WU2cNoCqBN8GFxu6DhTr8fc8MvU3O225W/wl7QM516QAU?=
 =?us-ascii?Q?pGOFEbyKkcOyxNy9n56L3RqG7wE5xjSGt7Vtbti1005mPwbl0Su37SEchdnB?=
 =?us-ascii?Q?NkUelkRrc6l+76O3y6BcJmdV/U94m6O2ySbhQliFvVaIkBg3vFuoxFdx80v0?=
 =?us-ascii?Q?Z+Y3E0ajzpktcviOlC72TRo5f3iN9F8Id6DCHNeOfFD56PUd59fwFQxm03ZO?=
 =?us-ascii?Q?NblyDHi95Wj5w/SMqKlscZGQf62Glk51i2eX4EIaiCWyaorQIieIhUIdHlHr?=
 =?us-ascii?Q?P1BuNaQu5cUK1xTc45fbiGTJzUNmqQmG5+D1/eCthSUZrO7ILalb4Ls+bCs+?=
 =?us-ascii?Q?7NpcnNHoBx/3KFU1tUlwMBWJNgU9aMsoHdL91xQp4QtMZuI5T0UBwMwF9Q74?=
 =?us-ascii?Q?sxXiR9FFkCSPA+99ImexaVRbe/Kq2SaGRQL1OWSZt3GecXe5l5AFos17ISro?=
 =?us-ascii?Q?RSmV+LUvb9bt68E73meco6Nz49KK5AAbEFbJ/33vZ2ylvSGgsJosjIISWPCu?=
 =?us-ascii?Q?ohtyyRnyDSGyIPDtlu1lqfKng3z2U931QNG6SQNymeKYd/zX0ciSx70bCqkf?=
 =?us-ascii?Q?oZDcG6cdFlzHtpIX4HjSN8ZSC8ZUCycLSI8xep610dVIippWYjEDQYfFb4PF?=
 =?us-ascii?Q?whiGmVF0k8n5tFzIg7M0H2UYtq1H5vam/yJY4ouvfVFJca66qHY/bTdD3dPT?=
 =?us-ascii?Q?U4NSu5mthxvjwksV/N4EM+jqgiw90ML9iRxnAeQdThWSE6nXrMoqIiCS0pzD?=
 =?us-ascii?Q?jziKl+yajN6nYNyCIgcQy3sVpZYPJsMZ8xEAQrpp0g7UCyDhKXcamTijT0GF?=
 =?us-ascii?Q?gExTzZM4ntJ+I2iLaa/G3MMDn+XB4ZpjXv+U8d0VllUSjUpDWQ+UPDEEUAYV?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63812005-b21e-40df-96a6-08dd843c9cb3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 21:03:22.0496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1359w3N+VWOlWX4CrsVnwnrhQm4VajMHa1Tz0qiNUetxjnEaX0H9EZBmFc4XsTIW9FK/MRmY/RnL/A8DgfQqTNaL53yHdaksKPKIwWzS//Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6834
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> On 11/3/25 16:46, Aneesh Kumar K.V wrote:
> > Dan Williams <dan.j.williams@intel.com> writes:
[..]
> >> +		nr_ide_mem = nr_assoc;
> >>
> > 
> > What is the purpose of the loop?
> 
> It is to be able to implement sel_ide_offset() as simple as:
> 
> offset = PCI_IDE_LINK_STREAM_0 + nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE +
> stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
> 
> as each stream can potentially have different "Number of Address 
> Association Register Blocks" (which we do not want for some reason).

The cost to spec writers of allowing more degrees of freedom is zero.
The cost of supporting it in system-software is non-zero.

It is useful to test that implementations have a practical need to
maximize their complexity. That testing serves 2 purposes, it either
stops the complexity from being realized, or otherwise puts the burden
on the vendor who thinks they need that to come back and fixup the
implementation.

Meanwhile we get the relief of living in a slightly less complicated
world, if only for a moment.


Return-Path: <linux-pci+bounces-35794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE60B50CFF
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 07:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292281C26564
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 05:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8568726CE06;
	Wed, 10 Sep 2025 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftOEr7ZW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F2B1DDDD
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 05:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757480959; cv=fail; b=q4WG5OG0xnmtoE3BJf5kRLfg1g1h7B0imjnBN9UjJDh7GO6XOWl5uMkTtl51M8JMklZRW/MRlwAT3I00qU6aE2AMRttOcJ7b0WRTPD9M4x/XofHOtK3cvL3pUOWfn9VjK9ayu4zH5cSVRT083SXh6NapiFciMNSRe19+YNJ5HLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757480959; c=relaxed/simple;
	bh=0H1qKBpIIUeoSqdInNaJkuIvGPWEHrc0j+VAuXEgiNw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=CrrJrOp8ym52i2ZIpCcqd+S8nbYun1TPpRQQCBpCpsK9A//LUqi5UAfGzUzLc06ojaekiffj2VBnhB3Q3LtnQgeb0Mqrprp/g1tGnRsMRRc2uYVWBV9dWTWe48kenvOaPrdt3PcYEi5MeuHHeSfsPjk+Ie7xuQ35VRUfF8WG4tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftOEr7ZW; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757480957; x=1789016957;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=0H1qKBpIIUeoSqdInNaJkuIvGPWEHrc0j+VAuXEgiNw=;
  b=ftOEr7ZW3FfGYJIFUmR7Xb7myWxsmA8gc2rwBC+/zAv+NHY3cdEDriCI
   uYRzYqlPzriMcHqUBzwpCPhnYx1x6P4ZDrM152QfelpTfZmO+O9E6K2lE
   5JzN7OlLu3OsSVxj95oYJttB65rwqlVmwjSnDHdp6oweMcJhWEmNxOufO
   0m8oyuNlk1RcOYUXPf809CJGtTNoXJif5HlcBe4vkhTBhTHTFen+l1NmY
   rq4YvuSTKC9lOk/HCa2/7HuowU2HjW/+D8+jG7W76gydnfNmMyttewpZS
   TIKQIc6zZxUsIF8+MAXx4QA0Ep2Qy6HHxenyp27VKzAd+4+pu8/3lC17g
   Q==;
X-CSE-ConnectionGUID: HrjbwcMmT5C7wmY/wt5ZCQ==
X-CSE-MsgGUID: 9g8ZaaIKRUCsHLXPPUSNfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63610843"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63610843"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 22:09:16 -0700
X-CSE-ConnectionGUID: jTWR6v9DStiH2n4JdAPKeg==
X-CSE-MsgGUID: OyaN32mNQ12dhyvyZl3RVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="172878857"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 22:09:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 22:09:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 22:09:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 22:09:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxyqtXGAcWPpotyPIjyR2wrS1OYoH4vHUAKRFs7t9klp+F472l6Xf9xccR8D6/kq/ed1Gu8MEwFCxzgugNGyowNGGhNNUgCTI+L3X+PHhEKHMs870ypsQ+JxoEgC32eZnlIrsaJukmhUErCGvHYpCtYs+A4Qy8i8CqCRkPbkSViI+TZ/N7FWW1f+XnJCaT2OuAyGsDlH4uCObU1z1vHVOq4gK0o5q263F6/5aMxusfRYWoSB0kbBlTVRV067dCVk0LwwFXkaegV78ltHu6r6ICe8uAQuzt2hfU4ZHh2EQKKVFIPrShROmZj2Pb5YvOPV5n5mKzrLypvBCtN/Fh5qTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22g64/7lrkkmBe/ev/M+crW+8H16BzjVDatCLVpdHHc=;
 b=piCY+v3SMHzYd+133vHrvU3b7OpRDos4TUA0v8w99jw0bVrQVVswqKI3w12m5K3t8wpJIHttMpPzk9l/RDQE2JxmGPqv+pMBu6LIXyWleqeq/DkMuKIKmtjgEhaGmpaNzaoHcHJ0h2Ut9w1+/tv+xShpH/XvSGdumu8a8z9R4/KQDDWjlVQvX2NOrv/sGAw0yBryAXwsPFvPNcYbAnebsCmxjHE+PEqZWLbqjDIJEul2qVQuvqMjCPqk7+gFvtxtNh6LyDUvVes/FndXHZLqHAHQEqs85jNCwIJBinhr2KfZg4w8RPMzHHppltyHsOHlj7vTPvK6oQbes9bF8hue3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8044.namprd11.prod.outlook.com (2603:10b6:806:2ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:09:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 05:09:12 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 9 Sep 2025 22:09:18 -0700
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aik@amd.com>
Message-ID: <68c107feafb26_5addd10084@dwillia2-mobl4.notmuch>
In-Reply-To: <yq5ay0qv1s66.fsf@kernel.org>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-2-dan.j.williams@intel.com>
 <yq5ay0qv1s66.fsf@kernel.org>
Subject: Re: [PATCH 1/7] PCI/TSM: Add pci_tsm_{bind,unbind}() methods for
 instantiating TDIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef631df-83cd-4e44-6dd5-08ddf0282e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEFxS05IbWYyaEovWnFFWXEyYlcxM2NTMXBOSzBWcmVHT1NPMzZxUHhGNnlU?=
 =?utf-8?B?Sm9xWFJXVjVONTVEakp6K2VDa1RHU2NJS3VINUcxNmplRkdLOGt1bkdZU0tF?=
 =?utf-8?B?MFNvd0dVK084WitaM1FHK0d1QUdxOVFmdFR2RmdTMFVaUTJ6T0xXbUFzWlNZ?=
 =?utf-8?B?c0JVdWpFcGwybHFVcUdXM0FlQVYrenlBdlRua25zb09aZW12cUhzeElOUHZa?=
 =?utf-8?B?ajFxNEZJYmE3aUYxTUVjOTQraFFwTm9NSGtYMzhwbUFoVUtnRzJQV2hQZWNU?=
 =?utf-8?B?aE51SDM2eEZqczZCOFpmK3NxMW9GbUhMVUhPZVQxaDBVVnE0bHh4S203UzMy?=
 =?utf-8?B?K2ZSRGNSYUREcjJHTzRqd1FnV3hmMmUrWS9EOThrb2R1Kzl2ZkM1S1k5cVNk?=
 =?utf-8?B?REVXb0ZvR1ZNbUV6QW1kSTJBeGNwcHh2M0NQZm0yMkhwcGtoL2JRNXovdlZR?=
 =?utf-8?B?SU40WEg2MWJJYzlpVy9pQ2ZyZTY0YzhTUVhMN2YzS3loRDhBekQxY3lEVkZH?=
 =?utf-8?B?S3R0OXVRNXRrVTBJdUxXaDdUdUoxTTA2R3ZqNmJKdmdvQjRTYUJqMzJEN29K?=
 =?utf-8?B?ZnZrbVFSY2hMa1hJUGlSK0QrdlhjdmFJaHd3VjlLcEtxc1puMjk4UjFlVUxU?=
 =?utf-8?B?bU41MmdlUU5CdUJweWx1UWpnZjZTekhWR3lBNzUzZmo5TCtlNVFBcGJ5c3Vz?=
 =?utf-8?B?Slk1ZExMMkorQ2tScTRDbVFyL3ZYK2QvV25jSStpK0ZWaW96NEYzcFJmYjNE?=
 =?utf-8?B?c2VRREd2a3diUXM5WDRoQWpDeGMvNDl2eVdlU0ZsNVNsLzdiYURaUFdBV1hC?=
 =?utf-8?B?dWV1dTd0V1pvSElSQlc3MEtCTTRMRVJPOW43Y2VOQUFBekRpSG5xYUREcEha?=
 =?utf-8?B?UC82SGhSaGlGRGozaUNTR1JEOUsxWlRnTzhHdXE2RVZibnRwb3Fkd25zdnVu?=
 =?utf-8?B?YnZraFFjVTJtMUFHZTlxTlpHSjh6VEZWM0FEMUVJb3ZKUkRTVTVTQ3ZKMmJU?=
 =?utf-8?B?ZXk3M0NBajZ6ZmdTd2lPdUdOQmhXcEptMXUyZmdtTnRIWWRGTWRPbEg1Y0tJ?=
 =?utf-8?B?QUxwVGREd1cvZ2dXY0M3YldGYkk1SlNTMmJYcm84TEVXQVVBN2lVdnJ3OHgx?=
 =?utf-8?B?bjhiY3hMMHRISXM4MjhRTncvUmh4azNDVUl2K3U3c3BDOWw0WVVFcUM5Nko2?=
 =?utf-8?B?OWxaWEJXaDNpMCttV041Zm1rRXRnTzdlNTVMaC9qRVMxaW5zZEFIdFBFMUlE?=
 =?utf-8?B?UjR1UjV3OVRvWlR6RHNPY3ZFckI2K0Qwam1PdExXc2t1RjQ1amdGV2RucFha?=
 =?utf-8?B?aVovakgrNFAyQi8rcURzZnU3UEIzRnpQMjN3Q1lvVU5vR0NaUnVFT3QyVmQ4?=
 =?utf-8?B?TnlsUDQwOE1pdldwVXBZQ3R0c1RPS1dnZThVc3VYczZtbURrSXVHeEs2bmNM?=
 =?utf-8?B?R08rWjNhc3ZXZHZvY1kyQ2FXeHBiblJPeExoVVcrUFdncjZQdUZmZE1OSEY3?=
 =?utf-8?B?NlNmYTNOTytwd0JDcGVBVnRRenh5RDMzTkxuQjl4TDRYajBid2pLaVNFMUdG?=
 =?utf-8?B?MFF0clpqdjhocGwzdS8xRHE0dWY0Tjl5cEs2RXdXMlNSajN5RUtlVG1rZ1NY?=
 =?utf-8?B?TnFLWHlBSVNVT3ltY0IySDhhZkhwUVBaRWk0RktLMUFYQWI4NzE2UjVWYk9j?=
 =?utf-8?B?R1RaZVk5MHFuNC8rR1pzbml1eW5jdS9ISzBsV1MwTS9KMUNTaHY5QmJseTg3?=
 =?utf-8?B?NTVhb2pheXhIUmxpV3JwNm9ZaTlPNEJ0cHlrbEQwOGR0THlpVlAyUWtQOGo1?=
 =?utf-8?B?b1VpS1VIRkZacFRGLzZCeElqdWxOT3lsaW1QS0ZXWHN5K3psUHFIU3FnU0h4?=
 =?utf-8?B?KzlSTWhsaXBnUVBreGttbWtlNkxmWFg3ekcvODVxOEtpaUh1VHBtWFlVWnMw?=
 =?utf-8?Q?lvsWUs+PnSA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?by9tcFZMN0JmUXJHanhaSFQxc1ArbW01QS9WeHdkTG0wZ2xlMXlNWUtEVVNl?=
 =?utf-8?B?RGlyQU1seUYvOEpTRGc2Q2VWTGJJTFU1bmJHWVBIRTk5NEczOEhDM1RESE9C?=
 =?utf-8?B?Yk5aT0t2OG5qcllSSjZxL3NrRnFKY0NyU0RrUU9CYnVwVUtIU3VzQ0dNSGtE?=
 =?utf-8?B?TTg4RkRRVE1weHpsZ0pvUWhTRXRQRlNnQkdoSUFtRWVlNjFQeTFvbEJONktt?=
 =?utf-8?B?SkhFeEdmRnJVVVFJdTRyVzFackNvR0x5cVRyQ3hkOGVlYzBCR29WT0dmbThn?=
 =?utf-8?B?Z095TDJub1lFaHIzdXl2d3czZnZ6Zmw4eWJ0Q0pnVjdGQm5mOFZzVkJWS1k0?=
 =?utf-8?B?alNkNisyWS9PQnBFRnA3UlhMN01IaGphUDBDNEliT3UwVGYwSWhDOCtvNEIz?=
 =?utf-8?B?NFFMbEo4RmMxek4zdHQ3T2w5Y0ZzekFsZkkvTDk4RGNtU1llSEFDb0xpMkpu?=
 =?utf-8?B?aWo0NXNmWGg5eGlZNEN2TEJ4U0crRFlTQ0ZrdmVjSCtRSzdhWWZ5bGxYdjcv?=
 =?utf-8?B?K0ZSQ2pRNWFyRDNXbWhXNTROKzkxNVBJSFp0Y2ZxMUQ1UmlSYWF6dDV1cUNN?=
 =?utf-8?B?MWJQcjB4RmhXT1R1YXFKT3BqUW41eWsweEIwK1FjakdsZWFRSXRCeEpMRURj?=
 =?utf-8?B?L0ZoR1MyMjVkYnlEQnplcHRwRUcvMWEycW1EcWpGT1F3dmFZckJSTTBOUU1h?=
 =?utf-8?B?N1Q5dmJLQ3JTdlFsOUdYdGRJMzVmQm5obHdENkVNKzRrY2p3UlpzSy8vRTRr?=
 =?utf-8?B?NGtGSTdxblJoZ0NKWWw5VE1GQlJBLzYxWFc1UXNOQi9EN1N4cW1WbG8zYjNj?=
 =?utf-8?B?eXc2djJvQkJ6eW84U1hPT2tsU25YbHBhT1JoK282dTR5b2FnL2E4clhGQ3Fs?=
 =?utf-8?B?bXVicVJ6cFdvMjF0ZlpDcjN3OWVUWktrVDk4d0NBbzZEVjR2NVVybWZ4dlBE?=
 =?utf-8?B?YkJNWk9PVEE1cWZDSGF5R0JXZVlHMVZTY25WRHJTVDVPNk1hUWQrM2VySmNH?=
 =?utf-8?B?VjNIKzM3L0RqWDAzRWlzTUJaM2UvNVBiaUpwUnlZa09NaHhndkhzTmVrdXlR?=
 =?utf-8?B?d0Q0VU9nNVlGNmxJT3hZSE5DTXR1WjVGelBCdEtQdm1QN3lSVDN6bmtOWEIw?=
 =?utf-8?B?NHVYRXZIdy9ZcGpZQTBTdHlZeDVVVDZrN1BZcHMrMkRpRjNrRzFuQnJNR0JN?=
 =?utf-8?B?WjZvL2oxeGlPeGUwdEJBM0FZUCtsTTB5K00xYUloTFZYcm5DdTluRjM5d2Iz?=
 =?utf-8?B?UC9UM2tKT1dTbzJrTThIQlhSVzJUSVIzaFF3bEhqQmtXaHJYdGQzSVZvSzZU?=
 =?utf-8?B?TC9JWFcyZVp3TStJMWFXYUQ3bG42Y3IwbUtrb1RhRzh3SzM4dlU4Q1lrbWcy?=
 =?utf-8?B?WS9GNlFpVmxIMUEvanJsRDZuT2hJS0FnUzI2UGNmNVJyMWNmMm4vUG9TRXJW?=
 =?utf-8?B?UE9qeDVCLy9POW9GMnpxQ2Zqd1R4dmZDanhXZXhCb29Zb0JzRmRBQnAyOHUy?=
 =?utf-8?B?UzB1SzR0anpLeVFZTWs0cklXL2xhVm5GUUF6dUJ1QUVLVnV4KzFNaHdoTm9j?=
 =?utf-8?B?ZWtwMjQydnNXQkNwcnV1SUVrSCtiMEZ6Tk9iRUt4aitLK29xZVZ5S216Lys1?=
 =?utf-8?B?amhtNUpJeUkzOTYzNnp6Rkw5WGZ2WSsvUFVkSjFGdVpLZTdaU0FNb201VXFI?=
 =?utf-8?B?dWEyY3poYUJ4a0pTdjRodW9vb3kwY21YRjU1NTNrdXA5U01BSDNHRjg5aWov?=
 =?utf-8?B?UHZTQ2IzMVNhK3lLYjVxTndJNUpZUHE4S1JwdmQ5Q3B6MThJQ2k2bDFBY3RN?=
 =?utf-8?B?S0s4bzRvdlRFTjAxSXd5WUt6QUU0TWJYT0hPc1J1eDdtZmpOcFlkWUsvQXdT?=
 =?utf-8?B?am1yclg0cU1CTmpubnBma081NTJxV1FWWkZjY3VrVU1VTkdPV1I1UTdsK2hB?=
 =?utf-8?B?UXFwUHgrYzNYK3hzSld0TzRXbW1RQlZQVFZLc2xYZjd5TWJxcWJXVEtnMk5D?=
 =?utf-8?B?NUE3WVdmcHd5enlNQ0RiY1FPTDJWYUdzQzk2R0dLaDM1MEVtdEVET2VnZTlX?=
 =?utf-8?B?Nld6aGp0MzJkTnlORTBxRGw1eWluMEsxdncvTUxpZWRMZmNZZGxEWlZ6eXlW?=
 =?utf-8?B?TWk1TmhZcE1JM1hSU2RLdVNMTk5uOUZtbHVIUlo2WEZveFJ6azZTWjB1RFZm?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef631df-83cd-4e44-6dd5-08ddf0282e96
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:09:12.8948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTwuu/zUudnHYaQsx9OFzmPFo5hYGHty7d/UigUZnuwB2M7AnRXHiY6/5G7fH4f5g2PcHGZWdVy56JPBafuCgZYP8RkrTl3aGbHysi5kxTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8044
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> ...
> 
> > +/**
> > + * pci_tsm_bind() - Bind @pdev as a TDI for @kvm
> > + * @pdev: PCI device function to bind
> > + * @kvm: Private memory attach context
> > + * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
> > + *
> > + * Returns 0 on success, or a negative error code on failure.
> > + *
> > + * Context: Caller is responsible for constraining the bind lifetime to the
> > + * registered state of the device. For example, pci_tsm_bind() /
> > + * pci_tsm_unbind() limited to the VFIO driver bound state of the device.
> > + */
> > +int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
> > +{
> > +	const struct pci_tsm_ops *ops;
> > +	struct pci_tsm_pf0 *tsm_pf0;
> > +	struct pci_tdi *tdi;
> > +
> > +	if (!kvm)
> > +		return -EINVAL;
> > +
> > +	guard(rwsem_read)(&pci_tsm_rwsem);
> > +
> > +	if (!pdev->tsm)
> > +		return -EINVAL;
> > +
> > +	ops = pdev->tsm->ops;
> > +
> > +	if (!is_link_tsm(ops->owner))
> > +		return -ENXIO;
> > +
> > +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> > +	guard(mutex)(&tsm_pf0->lock);
> > +
> > +	/* Resolve races to bind a TDI */
> > +	if (pdev->tsm->tdi) {
> > +		if (pdev->tsm->tdi->kvm == kvm)
> > +			return 0;
> > +		else
> > +			return -EBUSY;
> > +	}
> > +
> > +	tdi = ops->bind(pdev, kvm, tdi_id);
> > +	if (IS_ERR(tdi))
> > +		return PTR_ERR(tdi);
> > +
> > +	pdev->tsm->tdi = tdi;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_tsm_bind);
> > +
> 
> Are we missing assigning pdev and kvm in the above function? 
> 
> modified   drivers/pci/tsm.c
> @@ -356,6 +356,8 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
>  	if (IS_ERR(tdi))
>  		return PTR_ERR(tdi);
>  
> +	tdi->pdev = pdev;
> +	tdi->kvm = kvm;

Indeed, but I think I will keep this as the same "constructor" pattern
so it is the TSM driver's job to make sure 'struct pci_tdi' is fully
initialized when ->bind() returns.

This is one of the oversights of not having a ->bind() flow yet in
samples/devsec/.

-- 8< --
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 4688ddbc0b33..125c682d2e08 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -519,6 +519,20 @@ static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
 	return NULL;
 }
 
+/**
+ * pci_tsm_tdi_constructor() - base 'struct pci_tdi' initialization for link TSMs
+ * @pdev: The PCI device
+ * @tsm: context to initialize
+ * @ops: PCI link operations provided by the TSM
+ */
+void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
+			     struct kvm *kvm)
+{
+	tdi->pdev = pdev;
+	tdi->kvm = kvm;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_tdi_constructor);
+
 /**
  * pci_tsm_link_constructor() - base 'struct pci_tsm' initialization for link TSMs
  * @pdev: The PCI device
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 61c947ff8735..7eae8a1a2853 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -161,6 +161,8 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 			 size_t req_sz, void *resp, size_t resp_sz);
 int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
 void pci_tsm_unbind(struct pci_dev *pdev);
+void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
+			     struct kvm *kvm);
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 {


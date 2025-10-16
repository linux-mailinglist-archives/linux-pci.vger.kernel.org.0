Return-Path: <linux-pci+bounces-38393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3F3BE5448
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 21:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED361A668BC
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 19:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D0143169;
	Thu, 16 Oct 2025 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wi0QEGhT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065D20ED;
	Thu, 16 Oct 2025 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643940; cv=fail; b=nH5tZY9hjy1cq1597meKSAITkJCYE+uVLv8C3uuO6q36p4XREneovHrsTR5QfF6Xj7rKGTkmVJsTG+AE64/qJ1ebpGVDjwrs/qLI5qd8R/WWebEHqB/xN1hwlKfOVbVVe1tq5vskt0FRcXor0mmmCa1CLJqdAGXAOV9j9D/Ru7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643940; c=relaxed/simple;
	bh=gISZfSqZvPoRYkQtI13Wo4D8rJX2FGVYow2Od7xRPu8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=BQ4nI1BsVEyqteBjC/XlR9rr+WGCkfJFSwNORXxdxX6ba3GLffNAZybTcKH2qNM0a0KqZr/IUHyVzyvAq/P4zc3mCzCVg1YZfdQkuIVOXLQtAYtkbHLiJFCdfoMq38dsFh7d9ybhBqtUZHuen2q+XoNTlQAJ9c2SaPPIGG9jHHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wi0QEGhT; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760643939; x=1792179939;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=gISZfSqZvPoRYkQtI13Wo4D8rJX2FGVYow2Od7xRPu8=;
  b=Wi0QEGhTLKzRDSkbZGyxwLAuHn39FJGblOxS3DN2y3WabUIChVUkcPmt
   0K0ynQTcZjf71mdMto74wI/ZF7j7D55DKYswa7N2W23/v5C6dVQcy9zHI
   2Ur9jEC8SKSu4YEqcUD60Y1wftz7HZPDrWhvhkXTwTrjB3A1kdcHbUead
   yo/aHvQO/xuYx1Mp4nFCDixY9KKy9qGJlxA8D1HmLoR7ZAw+iaTMz7Stq
   v/ofjEkDDt4M1YzN1voNt2mOqAN7fi1ajcLtSLp+qHzwFDY52aR+kwXr7
   oDbqckCd3p/N7ovJ3K7t+durdtzaX9E/tmviZtsn7oinbip/ScDMD/Wkj
   g==;
X-CSE-ConnectionGUID: MAfDbRuHTFyah2YKYHmSpg==
X-CSE-MsgGUID: nCrF/bRgR8yEgEx/kUMAfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="66499168"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="66499168"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 12:45:38 -0700
X-CSE-ConnectionGUID: k1MUfMKnRi+fH35mAjkQ6Q==
X-CSE-MsgGUID: Lj8HDjXRR5Okid2WLHBKrQ==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 12:45:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 12:45:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 12:45:37 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 12:45:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJN9eDly6qj03xfOcfbECEFZ08HcLQrvf6xEZOQhMuyjekwCrAqVonJe/HbHuqOoM9M0RsoslsBk3h/KqTwYEM7pKaNZtQ9PbX9QmqTqPFkF2gzwwxyPLgRe6O/03NxVfMstizQbTHjwbZYvIvxQ5XAhqUBd7udTuYqU7oh//Nm1If4CeDGwzzHgkhiCyyHZAuZQhzQqSwBm3P5kyf6bE41sUgfPPQ9TxtYk8nT27HoqjJRqfc4hlajZbD6TIQ/FSAHl6dQ/XBqY+NCq9PLoaINSskUiLNpK/UWwCgMzCHHPOUp0xNm/o++7e2I2MQOjVDvK46wZe8YHZZt2D2EzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUjvcl0mqAl3LtjnroKL6fwWqukE1VGmrF7skDs7JDU=;
 b=rLuvT0QeGqIXY5kfLJruEv8nAzE2+iQdlLKSQk/ZKqdRKaPL3bTm5meK7VNEAKA6toRIgUTOUpBS0Runbjra5fZezCUx46Gz3ANNsV7uiDaazme4d6DVWCmmnCoY62a8jlw3QlcFTLgpW/eZP4POPvvK4jQZYGjyYbpyeaE6TsxQFeon48EEMpqO9AjDSf2I/kez8LAczZa7i5exvGjN6mAwkgGCtB2CxEucF25YsSVRkX4xqZXgEbovk3ML8FdyE1DoRrjWCBv/026Ga4MdqCZQMLsGquo1rM7hd5o0lrRxJsB0n0nzsfC73uLVApGPE2RB8lMbWVcZwvnpQrwk9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5784.namprd11.prod.outlook.com (2603:10b6:510:129::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 19:45:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 19:45:32 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 16 Oct 2025 12:45:31 -0700
To: "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>
CC: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Linux PM <linux-pm@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, "Alex
 Williamson" <alex.williamson@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>
Message-ID: <68f14b5b6a92_2a2b10018@dwillia2-mobl4.notmuch>
In-Reply-To: <12765144.O9o76ZdvQC@rafael.j.wysocki>
References: <3925484.kQq0lBPeGt@rafael.j.wysocki>
 <cc21a74c-905f-4223-95a8-d747ef763081@baylibre.com>
 <875xce7m11.wl-tiwai@suse.de>
 <12765144.O9o76ZdvQC@rafael.j.wysocki>
Subject: Re: [PATCH v1 1/3] PM: runtime: Introduce
 PM_RUNTIME_ACQUIRE_OR_FAIL() macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cbf71d-351f-45d8-0499-08de0cec918e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zi9XRlZ2R0NlbDZ4TXhwN0hKN0xaNVg2Ni85UGNTNjEydG1sNDVMb09laTFv?=
 =?utf-8?B?dkRFVkdTMlNVa3FkM0NtZ3h5M3c0SHMvRFhaaFhKbnE3Y215RW9uVHBaOUN3?=
 =?utf-8?B?SlBWOHB3dmFidGNId0VYdFVrTVc3MzV3QmtCSG5zMnZJTUJ3YVFFWm9RZ2FO?=
 =?utf-8?B?c3JSU2pBOGIwMk9wSTlTUFV4UkRGeFJ3NWdGcDM0R3l1YlhQWTV3cy81cTNJ?=
 =?utf-8?B?ZUQ1ZWw5NjlzNHNzNlU0RGtRYXhtaVhScXJxbE9zMFhlTklhK1ZVS2loTUNr?=
 =?utf-8?B?T0VuaVNES3lueDAvQ1piYmRhYm9DM1IrQzlzL1hMVTlsSTBkU0J5MUdkRFFL?=
 =?utf-8?B?eXo3bzV6My83Z1c2TTlsUG5EWktQT1NCVjM3MjB1N0RiSWwrMlZLWVJJcFhG?=
 =?utf-8?B?R2t5T2VTb3BLQ3BrYXNVRVdWMFowZzF3SVlXamlEWFp0WmRmdTFDaExvWlpn?=
 =?utf-8?B?TDRCai95alpVZmJzQVhUYnBjVW5STmZ6R3hna2ZzaTVVcHJ2SHZOUDJ3UVla?=
 =?utf-8?B?K211R25RK045cTd6eWQva3NGbURKd3RZYlRqM3hpUEJJd3RxNlQ1TmowRjNv?=
 =?utf-8?B?ZzRkZmMrVWFaSGtJbnZBSVNTOVJOWTZEbDVBeEpGbndpS1V2WTRLclFLODhz?=
 =?utf-8?B?aXZOS0xOUEtxUUl4U0s3Z1hkdU5xV1NBb1BWbGtNR2VTSXhIVmkxOGg4Z0pF?=
 =?utf-8?B?VFZQUUk1ZE9oTjJyVmlFc0hsUWNUMkhkRmtraFJwZ3ZpUnFpcE8wYm1jcW5P?=
 =?utf-8?B?cHNYeTg1dHNiSVNqRmJXVzBiR3BPQnZwQ3RaYmw4SEZZVndKa01sL0t4TDBx?=
 =?utf-8?B?eEF3UldOVmJlT1g4NHBEdTY4YTVOODNtMXJnTHhlWC9IcVdNUlhLeE9HTDJS?=
 =?utf-8?B?WVo0RkE0QlVTb1lPZkQrZFR3WkxqS0V5Z21nZlR5MGVvd3ltMk1MUFROaHpH?=
 =?utf-8?B?WlFOc1NVVnZTUnphbnJpMkNUcnRhOUVDODR1S0tBd0w2dVd6eTBQZSt2eFpi?=
 =?utf-8?B?TVhneUtRbHJFWEpSZXpCRW84Q1ZScXlrK1lpdExqclpZMTJKLzJEZzltNmtF?=
 =?utf-8?B?WFlHYlJiYXhhR3RjdERoU0I2Z2xIblpxUndTeU4vN21WWjUySDR5Mm9EOHJu?=
 =?utf-8?B?d2Job1R3amNIYjllejFxaFZXMS9ScXBSTmh3Zzgxbys0ZzVvNmF6R2dZcXZD?=
 =?utf-8?B?cEFFTXdkS3ZhZUJERk5lUklscHpDWkI3amNIMEJrQlhQeEVSRms4UFVxNk5G?=
 =?utf-8?B?U2ptZFA3dEZJN1F1c0dYUnhudXFxMHIrTVFNU1ZpZWQ0OWlRV0lUeVI2YjVJ?=
 =?utf-8?B?WExncHlSN0pjRUNML0MrbjdXREF4T3U5K1hDcWoxY01ETGw1Z3hUS2tiQUpo?=
 =?utf-8?B?WTlJWWVieFdLUVJqVlgyVHR1MzFnU3JoQm9MeHdkTnQrbmRVMDFGSHBxL2Rx?=
 =?utf-8?B?eHFhNnhlWnVxbUJyV2ZSYmVSSzdvTXFLTWQ2V1BjaU5xY0lUVWZjK3lRTnMy?=
 =?utf-8?B?WXlvYWJJSnNLdDhJUy9IMlFoZ2JPR01ZN2hYTWtkK3k2MVZaV3pjb0dWTm1G?=
 =?utf-8?B?bjg3bE8rNW51enQybnc1c3Jaak1vejNWTFJCVlRteEQyYWRkTFhyTjRGOGdF?=
 =?utf-8?B?alJRYmgvMWUwUWlNMG1DQmNjblpxNkdSRm41aDdLbHZjQW1DamY0YXc2a081?=
 =?utf-8?B?MkQ4WHIzaW8wUWh1cEtuaXFxZ0kwYlhlT1hPS2hEQnkxYVRORmtGYXFSVE5s?=
 =?utf-8?B?S1lPb0UxbzN2VStRd2Z4eTcrNzU4dG5Pbllnb0FHYnYrM3FvR0dKbXVqMFRw?=
 =?utf-8?B?em1nQjF6dS94dGRBNXoyZ09Xc2l1K0tleFV4WDR6MEhkOWVwM2tZZ2JlVjdr?=
 =?utf-8?B?Y2xKTXluVDd5S001UkpLUkVPUm5mRDdxaGdLQkRxMTNuUXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3RWRnQreFVDYzZXa0h2SEM0VUJSdjU0V2NVdWIwbWdnSzVYM0NVOFF1MXFG?=
 =?utf-8?B?cnFpL0prUVVPK2RYNEErRmZRU3JjUThLWktzd080d3dMMUpQdnBPTnNpRnht?=
 =?utf-8?B?RWpzbERMalgvV09oUnJmUFNpQUlBWUdCb0dkUnpQaTBlNDRkc3JNZEw4dUk0?=
 =?utf-8?B?WmUrcWlFajNFYldoMzd4S0drSUxoYm9RMysvVzFidVVXQ1VobGxlNGlSRzRx?=
 =?utf-8?B?WVVqTlQ1R1puTjI0STFyNk9tOERZZ29pSXdpbkVULzJFVlloTmVkMzFOQWUw?=
 =?utf-8?B?dDdYay9kRzdYSUZ3ZEpUdVo4UUZDeTl4WnlwSmtyNU1GVzZGVnJNMWUzcXE5?=
 =?utf-8?B?MVFqQmtiNGk5R0d5clRKNEFMUkRhSWVOS1FmSnpmV3lCU2VmaXlwVGFubDhE?=
 =?utf-8?B?RkVtWnMzY01MU0lZQzIvdmFsYzhpeU9GOVNWMG5QblBXTFplR2Q4YnR2SUQr?=
 =?utf-8?B?aFk2MUFnK0FrakdEWHRJVzhOTkJNaGtnUXJmandWTVpiV3JiQnRPdlk3VjFQ?=
 =?utf-8?B?Ym10Ynd5Nk5uZWtaRXBQdVlyQ0pabkp1dFZHMm1JMkg0MDkzY0djOXZCQ1ZV?=
 =?utf-8?B?YnN6cHlHbjhCWjA5REZmN255N2ZVU0FDZm1OZXhid05CWGxSL3A1QUEwUm1n?=
 =?utf-8?B?MFhXTXlFQXF3OXkvSlllcmZ4VmZ5UU92TEtYeWdLOEUwTFptV3EvZEhQYWMw?=
 =?utf-8?B?RDRiYWMwQW9lQW5YVXN3bUlhdXpicHh6bzQ4bGlURnZrYmdEUysyK3VqT3N3?=
 =?utf-8?B?OGkzVUhNOWdOUk9hb1UxdDRCa1FtUVBYSC9lVzh2YTNJbGJzbmJkbjNsU3ht?=
 =?utf-8?B?NXNQeFhxdk9LVWxWVFpzdFdtZU5RNGZFT3RJTE55eU5rNmFNR2t2dms0N0Rn?=
 =?utf-8?B?dWxhcjdONE95Wng4ODl2SFQzNVkyVGpWSlpYRFpZMk5BS2JRUklYVURNN1Vw?=
 =?utf-8?B?NGlGcUlTRisvZktqQUhPem5vZldXT2VPYnlVQ2dXOWw0aUFOempTZFNVblpl?=
 =?utf-8?B?cDBPUEhoKzFHZ2g2MG9EQ3ViWnp0a1ZhSGN4SHZKTXNsVGRyMG1QaHB6UkRP?=
 =?utf-8?B?K2VZMTlSZ3dJZlN4RVdkYjJzNHNITnNpdzFPV2R2SHlWeUxHQUIzbmQ2ZzVm?=
 =?utf-8?B?NC9mM0JVVFFjVTAvWUQ5RVlsNzFDWGxBanpGd3hTcDh3ZVYyMFBRN3JEcHFM?=
 =?utf-8?B?SXBZakZlSjFLNk96N1pMeUJkMWdJMllMSys5RWhtdmgxTFVCdDZHbDU0QnpK?=
 =?utf-8?B?TUxoL2hmdUw0TGllMXROdmRKZVpMcFdMbFBuSzljSVBFU2xiRnlhcGZITXZK?=
 =?utf-8?B?b0NTcHp2SW80NExBdHFwUUVRcy9QUEN2RzBsSnVIVG9GREZERHV1ZmZER1Jz?=
 =?utf-8?B?UERZaERoekxncWpRSkY4bmlOS0hDdWVPV2ovSC9DVjZXZXdNYzQ2RWhhZjdW?=
 =?utf-8?B?cldDZGVHa0h2cUJmK2xxanBFLzVWN2QzRVE4d25QRExDS0tKc1RvU2lkeW9y?=
 =?utf-8?B?OTZ2b0RKUTNpVit6QkFHekozRFBlQURMVFI0a1hKMGlqMERULzU3ODVocVds?=
 =?utf-8?B?VXlaaHdkckVuZHJuQ2pQd0tPUWlqanRyRjFuUGhSTWFGZ1JKRmhFZUhFWUpY?=
 =?utf-8?B?ZS9GSmd0bHJWZFYxYjdmRFhXK1JXTGd1R01GVzJlU2UrQi94VWpSckRCM2J1?=
 =?utf-8?B?bmd3WUJyQU5nTDhXMENPTnNiZ3lyVzBxY2t1bWN0WVN5T0VNcHVWMURHbVJj?=
 =?utf-8?B?UWFrYm9XV3BhTkwyVmRWUEpqY1RvZ3haMDFlb2lQOWcyWVMzdi9ucUo2K0k5?=
 =?utf-8?B?NDhsVXVuNDcvZmRRUWdZWXB2akpucWFIZGplSDlBRDJtSUo5S2hzRlJ4VXBY?=
 =?utf-8?B?QWJqcEtJQ0tna0NZTkNKMVpPakx4THhWSk5SNFBRMHUwand4L1BIZllMeUxI?=
 =?utf-8?B?eGJ6Um4wdjV6MmUxWkVGckt6MCtrN1h4SjZOSmVkbTh3dXl0ejhDdDlwSFBs?=
 =?utf-8?B?UHpVSmpadmdyRXl6U2E2ZmFZMjd6Ny9SdVlyMWhaay9mdXdlY0dRRmNGODd5?=
 =?utf-8?B?dmpsZVozUUhjRGxkS0VhUUJMaEJ2bGg0RmVMTXl2SlBHU0RlYzliUjdlUERJ?=
 =?utf-8?B?dnZ1R2tldS9kU2FmVEU5UFdpU1oyL2FMMFUrMXBhK1ZDTnBPMTdSZkdLakc3?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cbf71d-351f-45d8-0499-08de0cec918e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 19:45:32.9200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mvuKa9+0jmu4fWSfx6clFwtrv1f3iJraSzG1X6iz7NjcVHmrrHKN2gNTD4b2m34umefWDeqPshhkGgXKZgdBKow2N8E38mvf8k7bc/RkTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5784
X-OriginatorOrg: intel.com

Rafael J. Wysocki wrote:
[..]
> > > [1]: https://lore.kernel.org/all/CAHk-=whn07tnDosPfn+UcAtWHBcLg=KqA16SHVv0GV4t8P1fHw@mail.gmail.com/
> > 
> > Yeah, I myself also find it suboptimal, hence it wasn't really
> > proposed...  It's a limit of macro, unfortunately.
> 
> The macro from the $subject patch can be split along the lines of the appended
> patch to avoid the "disgusting syntax" issue, although it then becomes less
> attractive as far as I'm concerned.  It still allows the details unrelated to
> the rest of the code to be hidden though.
> 
> ---
>  drivers/acpi/acpi_tad.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -31,6 +31,12 @@ MODULE_DESCRIPTION("ACPI Time and Alarm
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Rafael J. Wysocki");
>  
> +#define PM_RUNTIME_ACQUIRE_ACTIVE(dev)	\
> +	ACQUIRE(pm_runtime_active_try, pm_runtime_active_guard_var)(dev)
> +
> +#define PM_RUNTIME_ACQUIRE_ACTIVE_ERR	\
> +	ACQUIRE_ERR(pm_runtime_active_try, &pm_runtime_active_guard_var)
> +
>  /* ACPI TAD capability flags (ACPI 6.2, Section 9.18.2) */
>  #define ACPI_TAD_AC_WAKE	BIT(0)
>  #define ACPI_TAD_DC_WAKE	BIT(1)
> @@ -264,8 +270,8 @@ static int acpi_tad_wake_set(struct devi
>  	args[0].integer.value = timer_id;
>  	args[1].integer.value = value;
>  
> -	ACQUIRE(pm_runtime_active_try, pm)(dev);
> -	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> +	PM_RUNTIME_ACQUIRE_ACTIVE(dev);
> +	if (PM_RUNTIME_ACQUIRE_ACTIVE_ERR)
>  		return -ENXIO;

This defeats one of the other motivations for ACQUIRE() vs
scoped_cond_guard() in that it drops the error code from
pm_runtime_active_try. Maybe it is the case that failure is always
-ENXIO, but from a future code evolution standpoint do you want to
commit to always translating _try errors to a local error code?

Btw, was acpi_tad_wake_set() buggy previously for ignoring
pm_runtime_get_sync() errors, or is it a regression risk now for
honoring errors?


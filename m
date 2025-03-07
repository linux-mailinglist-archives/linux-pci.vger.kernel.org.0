Return-Path: <linux-pci+bounces-23151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFB8A57316
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 21:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692891897A5D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 20:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BFA25742E;
	Fri,  7 Mar 2025 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdIeBYT9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF372512E1;
	Fri,  7 Mar 2025 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741380688; cv=fail; b=KGPAAeMbbiaxM5Se7NIfIRql90LA5x3ctSMtoAd2ahTuMg9thm7lgMoH+NIw98KHZLg1+gt94UcbBjKRU9rq0tm92akVgkTt1PFmmMdZOh7LtmEPoDpwqOAG0mBMHM5qFF3YIiUl26n3iMvSQd6R5zhQxO13CvrkKOSakKzEGK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741380688; c=relaxed/simple;
	bh=oN9S/xK35xzmZZkIptOViEPLGSuEZSCn7l0EHNRMI+w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y7UZv0wvUVWegBsBB8DZPmtpv9o8xpJNYxl+V5X/CPJkTFv4gSFU5oOaevJLBi/7CvdI/k0KEK5BDOqVPJGlKmokdUIcTsbIg0hcIPAW/C/IiQX5d39mf39qQ0V4a46AUCVFTW09JDpdci6Lx+uDuOlWxpgrU3jjICjfFpHBa5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdIeBYT9; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741380686; x=1772916686;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=oN9S/xK35xzmZZkIptOViEPLGSuEZSCn7l0EHNRMI+w=;
  b=MdIeBYT9H2S26al74vo6ZXTOkuV64Xtl0jT94afEMwcho04ri4U7LMs1
   Aa5KtOW2A6YUZ94whiKLGpiLE8WPDiyXJXlahwuDWnm0oZnountYis/Rh
   WWyb2xK2SeoHTelpvo7ea0+5zLlo5jutmoFccJrUL716j9RMzjjGFU2uM
   et/qSNjLjbGiDWXs0ug+GR1XBloVIHe7+Ju4hxD2MZlSDIW+OuaHwOEva
   gwxN3K+Hs/eeJy3DTz+YXnebiUjse6uSUl/7CbubETiwokPPagUNYzsTX
   8IPEr8OhADFERfLujv+OB1O3diCgbq5Ee1NL5KI1VQdYAbBmLeF8mVGA6
   Q==;
X-CSE-ConnectionGUID: AmvpxHdDSCq0emCOkQUuKg==
X-CSE-MsgGUID: n0tOV+qYQGa8xSBvxkzQuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42297576"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42297576"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:51:26 -0800
X-CSE-ConnectionGUID: qbYOcHklSDSVCZ9gUIKThQ==
X-CSE-MsgGUID: xjythkdLQrCpBUyYqMBP5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="150225860"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:51:26 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 12:51:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 12:51:25 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 12:51:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+wNRUyqybL9qQTNbqGwgqilF6HPnFvUVYUpkRAaSqEQpafCQjwTJw2eIpLYieQM1n/5AEQHwPZE33+lu7XujAMlFHxgVNuZkPMxNMXTaRhohXGM3n2Z0vfXZwtxqgZQ2IUWxc9Rtt0cRvxAV+UMNZB9PJNCDfpYYZlBc932NaDJLPuZFTymkczMnzSq0yVfGLh3SRSVuW62p3f4oQ4ikqT49HgnXFgFL5KtWPW6zZSOd99oOg1cCeTLvJJiqIP1tFi+Hn11Nk0oWSLjFFuUjnByKTlU2aODMd5laIIIQilpbm5gdYHNr0Y4R28V8I4p6r6cmOj7uad5msW47y+N0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AS7OIJd1N2+0HGRQj1BLep/HGvdVBCL3qW9plIXqTg=;
 b=jCjqKMR063OQr7I4tqFmDS+GphrIfbrA1K7dlqP/SvIZtP6FSBkaw7nvOFL5J6mXQt/aavj7LqRTX5Sy0fMIqwGFYatHpLwBfk4rwjk8kJoWlxKHdi/7aKbsx5bOSjLlDr+gnQ5owrqgHPbaskCayYI4hxAO0gIuo4ZsyBhz0/Fxd3ReICvZg0iwipwV8nrl9nsFlZ3H4fEhTuceHxxbjfPoSDsqAQkZhhvhkG1Fk8bOSTNv1ZiDzl53a2fOQVQMoa1PjotErl9WudIfns4ZVHU+Qt4JWuOjOdJyR8z7ayh32vGKyCJQDBPPtMLWUSBSxuSDLy175Qg+1+sapirgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4959.namprd11.prod.outlook.com (2603:10b6:a03:2de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.23; Fri, 7 Mar
 2025 20:50:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:50:41 +0000
Date: Fri, 7 Mar 2025 12:50:38 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Message-ID: <67cb5c1ee3a98_1a7f29499@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250304211428.GA258044@bhelgaas>
 <ef29ceb3-9aa6-f4ca-014e-3f005a9b4beb@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef29ceb3-9aa6-f4ca-014e-3f005a9b4beb@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:303:85::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3267e5-5de2-4ee2-a2bf-08dd5db9b8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?i/HbrX8HLEZC+sRGNYuiHNVQ2AgKegUXQ4+Ev6hO24eeNuyjW71/3J/DRf?=
 =?iso-8859-1?Q?qGpVx/eI2ug77Wyw01m/gZSKeWQocPVOaXkLkaVnKzBStyaqcM5qF9PEM5?=
 =?iso-8859-1?Q?M6e7CVxirB3gTKBGrVYKv1Rxcx+/UxTVn9eckEgulDQCH/VTyCVM0wmGRG?=
 =?iso-8859-1?Q?WzMXy73IxiXQ5rl3nGT4llGmA89cCBHWbkQXKwUZEdUG7ebhaRFFz7HE1t?=
 =?iso-8859-1?Q?LQpEYExNhqabmHAdDJtgAB+tHFmVlD3HeJ0jZjn1Xt+B5TO34y33fBFGrH?=
 =?iso-8859-1?Q?+hskiHaCOtv6mTmEKEct+xObyklsSE/tXhRGCJjeW5+XDrgK0/YtMyhkyV?=
 =?iso-8859-1?Q?AcgtkC6ZCYIDELLGBK+nDqSwZqQIfHRSPdQf0/TussCIPEMhWwtTE6mWKI?=
 =?iso-8859-1?Q?neu6q32dC2WHQ3ZQONs3DIDIMoy8X3L8aDB4bGK6qRDayhEzYA5KgG2A5f?=
 =?iso-8859-1?Q?v5tONUNssPnkC1GjplcG79bGVfhYpP9hhDNc+keEXO8wLVFbK3Ik3Raewe?=
 =?iso-8859-1?Q?uehwEvER6wMy7/aPE53Ve2yXtH3xbyGT8ba0uedYLt17qbMheeB/Z6+6Rl?=
 =?iso-8859-1?Q?g0HJcUukhzNv0f0+r1Qd8tzrKOGCTB8hD4lRUOY5VLw79hZ8qi2nMQGQXw?=
 =?iso-8859-1?Q?lbGEikaPnVx+mJP1SjXbz8uEWdWuxsl0YJGTLfw49lY9/S4LGT55klHDfi?=
 =?iso-8859-1?Q?vAl/HcRocMm9RfBudHF+9a04N6eypmrSokM/vbaUBc1suVbWi+ktyjpK1k?=
 =?iso-8859-1?Q?WcpP7YF5JhzoqJjG+Ro020EpmF2U6CW51scM5cCgLxDRBayerllaJIZOg8?=
 =?iso-8859-1?Q?8g9DxrB+coIXO9F/Tlff3PYXIu4En0YKXlnylSUfvYKdcqd6mcrl7hoDf8?=
 =?iso-8859-1?Q?bi2pYRD1DxcaLjIraAfH8hRyo6vhp6YJuPeJBYAFKLsxbzPhum9o2QdkVY?=
 =?iso-8859-1?Q?/xMtR+vODkJszhp36kGHRjkdfnMO5Mi1Bo4QKtNgxE53vTrxV6q48nn0MG?=
 =?iso-8859-1?Q?2fDA18BRVyoq2yz1CwOCCSBBrdZ2Yzu6yEW63mixyZaS2T24eghmQrohSA?=
 =?iso-8859-1?Q?i0xkaIZ7CQvVK5Y1YjfO9ohg8oR794DhtBu1Ggf/aFZhOY36GwUlQ7WOzx?=
 =?iso-8859-1?Q?ySTTtoZYTNlmpjoNR5TlJJ3LCyutIWt/V9h3mOxYiPs9iBAyUasPXIapto?=
 =?iso-8859-1?Q?FPB8dPhgKdXEfwDtLCTFDPKBbzuaEbePdUyW1W1O7+lJrfWpNum4ULYxwn?=
 =?iso-8859-1?Q?Eo9rxHT6XLvE4OSoQIEI+l53Vrq/hDI7bpV63BJ/ONdJpgE3W09P7JlO9K?=
 =?iso-8859-1?Q?0lsSsZOVZ+lr2LlsTdemL6aX/PgSCkCOJ0Pp0E7dIRyOuBG8VTQSrupLia?=
 =?iso-8859-1?Q?JTCq2fzc5lzqfHmFVTFewAk1o+9Hi+gZjEgAyMirB4MRC9DolcJdKCUbmW?=
 =?iso-8859-1?Q?rwWWDChoX4MXsFLt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?miyCb9eMHwQ4p1mm5LsWVS4RwGh99SPra5m1vqQy6x9nVI2kNaxs4UKpw+?=
 =?iso-8859-1?Q?4GhwrS6d+t9u4bSJQVyeO0CaqlV6h9KASf1kepdVfOWKF8tkuQwW+1u0Ce?=
 =?iso-8859-1?Q?OO/oxTLfW+/6QFeobrN8qP07afBflCpMO/Tu2OQf5XEQOxfp8JDt9RZhNI?=
 =?iso-8859-1?Q?BvEPBi9AwUIYI3K16vwdoU0qLCdQI6OYiKNeCMq6WM65QxRpgqXruTtVrF?=
 =?iso-8859-1?Q?GUdD8ReaRFWEdYuEbV91qSNKNlt/KWvTNtsVG3gQqGFGX9G/iU5fgG/hGk?=
 =?iso-8859-1?Q?QOsVWC7/PlFBFfdyyMuMej/wUYgOvqhDqx4Jpsc5c9luuQ3N9UEM5O71Rs?=
 =?iso-8859-1?Q?LFiLT8Yff8WYlPZp2BUXR49GAIkVGn1b293SRFRU2hA2VR19bq196KAKAJ?=
 =?iso-8859-1?Q?5Q8AoqRrQ+tCBEvTse3CBg0eL6Q0wblhY/nnse3bYjCYHh35p7FaaFk8mb?=
 =?iso-8859-1?Q?/Zldapt/gsGF30MPjEuPTGel4Vxxp1qO5GAAarfVl0Ad5htbol5ryeJuBg?=
 =?iso-8859-1?Q?6gztNtj+ug6LL/ATqkmQ7zCRKHEMLGhgFcvpM1z/a2NLNW/zsjoEuYOHuJ?=
 =?iso-8859-1?Q?WJPqBFKASbjpJDl/DmgBaYIvfWyX2We0Nb6Y58SVyJei9nGtyFMiWAzZcY?=
 =?iso-8859-1?Q?9IC/6lqVgQrjzviUx3grHa6Tw9lS4BQc/BDAFn92X7nTTs9iNzQz7Q9+2t?=
 =?iso-8859-1?Q?oNP0Dl8h8sbDXsxSefBWUW9Zzf3z9cmlwZE4dXJ5xnQpMXENp31GAYF47a?=
 =?iso-8859-1?Q?pxRXdxknt81ZCx1kIDG9B2JF2339sdwLoAW/74Pb/7XJUo3jZ0awdfreiQ?=
 =?iso-8859-1?Q?FGxVNrdQuDbLiuh+r9c2qiJ8tUFHLG2HRQKUxrrhnSxjfGJ/SVPdL/PeMQ?=
 =?iso-8859-1?Q?MOuR/4PDP/V3LGs8QyW5vSQj/54kvbpOPc7oVNeiZ4sWf+SdE4931vERsh?=
 =?iso-8859-1?Q?ohdq9w2XfqRXkyHpZo8iD9myqrDbk9He5vdthajxigt8tVky4dcdbMm/20?=
 =?iso-8859-1?Q?TpBtU0xnwCNn9P+yw4Zr1i0oQdUmhv7WhCQ3H6keVz2N9GCpmqqPXCpsN0?=
 =?iso-8859-1?Q?jxpgHrzNgl3qLs/LUHhV55XLJ+hR0sXkW2ykUD/KkxEv1Sj/lFrs05zNvv?=
 =?iso-8859-1?Q?eXdH+wrCTqUJwTny11NQmrYk4STbevtneyml1xAvx4msnmxDOGBlhyu7rx?=
 =?iso-8859-1?Q?DdWbJcBber/MRyd+R3x/fiC9KvgaR3KGUlmUEe0Xj2+rbSJQOtdgu2njlU?=
 =?iso-8859-1?Q?YNHl7G3lZfkyUYfKItQV5h6H/L4LM0z7lrZ4UEuzkrSWL00LX7I2qaOorL?=
 =?iso-8859-1?Q?iubtwDhADVUj1U7Kb56dfqEw8CMmC/HVS7Xstl4zPGTaKPaxsxEURq51JW?=
 =?iso-8859-1?Q?RRyflSx4zQx7b2Mhf23yzmM4gdl6qFVbrWPSfLG/yMK02U4HxmMhb0Xmv/?=
 =?iso-8859-1?Q?0M2ylHjuR+HthEJws3q/Lz0ZCZc20VWuPxuA11fd6Nkt8LKxwe41smgIQt?=
 =?iso-8859-1?Q?mAuJez5i/bcwlbLnKCuwxh+v8QVv3A4N62JhBuiSOsIqgBXmlM7aptISpj?=
 =?iso-8859-1?Q?JYX/ZYbKkd5qu/hXdzXp0Iicvi6W/f56hN0sg/Gv6RPOHkmy+wrCApJG8t?=
 =?iso-8859-1?Q?24MOhY9gHhjVaVIMmAWO1vY5G8/4A07dnKwmhVlFax1snQmUHP0R1taA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3267e5-5de2-4ee2-a2bf-08dd5db9b8d5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:50:40.9976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iux2GhFxEy+23dzbmT2eoIBW9pXsgX9GbSDAx1MNdmw30SHwJoUBUHRoF5zyHs1bvWQLIFdK3v7nkU0jMwO7PkDfCIL2V9FONeipZdXtPqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4959
X-OriginatorOrg: intel.com

Ilpo Järvinen wrote:
> On Tue, 4 Mar 2025, Bjorn Helgaas wrote:
> 
> > On Tue, Mar 04, 2025 at 03:51:08PM +0200, Ilpo Järvinen wrote:
> > > Disallow Extended Tags and Max Read Request Size (MRRS) larger than
> > > 128B for devices under Xeon 6 Root Ports if the Root Port is bifurcated
> > > to x2. Also, 10-Bit Tag Requester should be disallowed for device
> > > underneath these Root Ports but there is currently no 10-Bit Tag
> > > support in the kernel.
> > > 
> > > The normal path that writes MRRS is through
> > > pcie_bus_configure_settings() -> pcie_bus_configure_set() ->
> > > pcie_write_mrrs() and contains a few early returns that are based on
> > > the value of pcie_bus_config. Overriding such checks with the host
> > > bridge flag check on each level seems messy. Thus, simply ensure MRRS
> > > is always written in pci_configure_device() if a device requiring the
> > > quirk is detected.
> > 
> > This is kind of weird.  It's apparently not an erratum in the sense
> > that something doesn't *work*, just something for "optimized PCIe
> > performance"?
> > 
> > What are we supposed to do with this?  Add similar quirks for every
> > random PCI controller?  Scratching my head about what this means for
> > the future.
> > 
> > What bad things happen if we *don't* do this?  Is this something we
> > could/should rely on BIOS to configure for us?
> 
> Even if BIOS configures this (I'm under impression they already do, I 
> had problem in finding a configuration in our lab on which this patch
> had some effect). But my kernel was built with CONFIG_PCIE_BUS_DEFAULT, if 
> I set that to CONFIG_PCIE_BUS_PERFORMANCE, what BIOS did will be 
> overwritten.

The observation is that while linux only overrides Maximum Read Request
Size with PCIE_BUS_PERFORMANCE, it always overrides
PCI_EXP_DEVCTL_EXT_TAG.

> One option would be to drop the changes to drivers/pci/probe.c which is 
> there to force MRRS is always written (in this v1). That case should be 
> coverable with BIOS configuration but changes into pcie_set_readrq() seems 
> necessary to prevent Linux overwriting the configuration made by the BIOS. 
> Unless there's going to some other mechanism to tell kernel it should keep 
> hands from from these values as suggested by Dan.

The problem is determining when the BIOS has made an affirmative step to
limit the settings to defaults, vs expecting the OS to optimize the
settings because performance matters less in pre-OS runtime.


Return-Path: <linux-pci+bounces-22897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA3A4EB2A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 19:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C843A1889A9F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92232208964;
	Tue,  4 Mar 2025 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwWpAJqD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F5281371
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111167; cv=fail; b=uc9/ScUJ/LV+/gRrNvbhdGxK5H0E8pOpjMDI2Zy5HowfiaZZeuiWxP0VDlwzf7sMgFSr5n1CaAQRIlma4O1gvbx7UfbtH+RmztU+A79r2Gmurnh7tLnY87FRJOO26YfUEvsfMBdEBS6d5hgI24exEBFgMbiLi7/iyfxYdr4mpxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111167; c=relaxed/simple;
	bh=J+KN9QNIOKRZWb4V8Z1YbXIn8dyyvb0dTHuxrBPgAN8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WrQ+iwMzuIvTcR6fOvNyKLtbuYo/PoW6QjB/i02ooMsudG8SeG5XnSSVJnfDiyNs0MdZVdsdYTWxwr84n9yRqhG8PPA4TjUpn7OJirlUNG6piL/iG7+1WG8Sd4PyXydNMCMo/xt9/jqisbuwR66ioQkHDW+scQ+xcTswL/aQgig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwWpAJqD; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741111166; x=1772647166;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=J+KN9QNIOKRZWb4V8Z1YbXIn8dyyvb0dTHuxrBPgAN8=;
  b=LwWpAJqDXVg3crHwSisXIlbzfQHeTZUorJGxikWpjshB9L3ZJdON+GMh
   PPxetAjVwxcRTpEYCfGNsUJvVJGd1rXi2qqS4hfy2H1uZwyzSNSNAB+Ro
   mzg/09HgRJds+Lgubs0GJZvtSodiUYDEchkRasRg+pszM4yflcJ2yxUpd
   uAC7HQh8/aZYdQpXZ3ZoudMfViC4Zwxi3ySc+Cg1w9TmM6F1CjaQugxTA
   6oxmZd0Gsz0sHb9KuoF1ag2MJ7VX43F8cJd88nR6d+qs8UBcnwhTY2qCB
   CD3KtStAlYo0DmypcSbwwCSEtfDfEqoWFeSRc0M1Kk8cgVmWiD460Mafe
   A==;
X-CSE-ConnectionGUID: lOzZCDI7SxeUp7tKxAY6oA==
X-CSE-MsgGUID: eB+9bX9/QCqMh8TxAT3Gxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42170216"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="42170216"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 09:59:24 -0800
X-CSE-ConnectionGUID: g17nXfVXSlW4+y7qGBcIzA==
X-CSE-MsgGUID: asSwZriyRTioo8cKIaaT9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="118457695"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 09:59:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 09:59:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 09:59:22 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 09:59:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyEO8n0lHYGk8brcuEhgA17U8qhNPp0LD+myOpUDMqw9bOqL2g6t71sUW537dIhEyKAUmLIxgCYInK4X101p1KYJXZORtdK3aEhGV3XAeB9HB27caLM66wnVU7DE64crnv0zuQISxplcxl2s1EWYkj3gvzb6qjEXb4HwEqRDy7usXwgfj+DomvSuG3W5tePrb1qZ03+JuxRktTHdV/tM7aUe5DEI0Kzt7sv5SHQC5xu4izfATEmQI5STR+gUV5E3hQEfSyPshjuDOsrr/9n4enC3L3+4yMVgOOAFaOI84Soz9dcrbvGBjC9BqvDrVKGbTi29y2k+IgLCORdhKc6wOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+KN9QNIOKRZWb4V8Z1YbXIn8dyyvb0dTHuxrBPgAN8=;
 b=WLGN/5Qy7rxRDZIOndJ8Xuc8XJljFNvApen/RxEhhtog0i2vPrEg6TRgYrP22IAu06GVDr7/flwllmqft5HCEbDF5NS82LwR5CxXedDLN7xvLNDIjID/Xa28hOkiStWBpBhokrSXxdfDyqXgvNykSyQ/mSPrU/y+8y/RouJOF3ZHoYokKY0Sk/sVTyn4hCCAtlEAnalW9bmnV5siJUn5YBiYHm9kCNti2DbqLMkduTL8iL3AX6sTKj9SjX8nUyL7xvk3kQZXfgHeT65bLEDo3NBJxjroeUfNCeXo+6WtyWi7S1cpE5vX7+NuuUJG2g91lmNoOLJ1es63AewJ3llHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6036.namprd11.prod.outlook.com (2603:10b6:208:377::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 17:59:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 17:59:15 +0000
Date: Tue, 4 Mar 2025 09:59:12 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-coco@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <67c73f70c8fb7_24b64294d4@dwillia2-xfh.jf.intel.com.notmuch>
References: <Z32H2Tzd1UHCQEt5@yilunxu-OptiPlex-7050>
 <d71dd5c5-4c20-4e8e-abaa-fe2cdea4f3b2@amd.com>
 <Z4A/g5Yyu4Whncuu@yilunxu-OptiPlex-7050>
 <a11c82c3-b5fb-48d9-8c95-047ac4503dc6@amd.com>
 <67bd098f4dcd1_1a7729449@dwillia2-xfh.jf.intel.com.notmuch>
 <cf2f615d-2a28-45ec-8bb9-563c2a5bde73@amd.com>
 <67c11ed38ff8_1a7729458@dwillia2-xfh.jf.intel.com.notmuch>
 <8c091787-9275-40db-9167-af270dc5bb8e@amd.com>
 <67c6501494901_1a7f2941b@dwillia2-xfh.jf.intel.com.notmuch>
 <bd5d59bc-6a60-47fa-b7f3-da3272309740@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bd5d59bc-6a60-47fa-b7f3-da3272309740@amd.com>
X-ClientProxiedBy: MW4PR03CA0317.namprd03.prod.outlook.com
 (2603:10b6:303:dd::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe32e76-b924-4642-8cde-08dd5b4646d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bAvBdvYz0Usl1vxlU4Ht/cORrHkRTmEVkS0KUMaN+O+s+7oqzmZgZqrym2Th?=
 =?us-ascii?Q?lBzJ9Tpmr6fZmA5S1KVh3qo/mcY0alOp3gCQfj0iDr85y4VclqNZWEsmR3e5?=
 =?us-ascii?Q?gtz4uUo35oa/JAhHVGE9Xj6pKrjvR/0EcYzaJBiISfH9Zwl4uP+RdJjh8jjJ?=
 =?us-ascii?Q?XtwVv7MNksYl+mSeVUAiQefQRL8MfWFSyt9m5DWkjgnSiuc6uL0sI9c4XAO4?=
 =?us-ascii?Q?TUyi1PnKq4QJp/Boby1fF0EybVEWiebx6fv/GWAlGAJbQQmpqTfFqBBnvcP5?=
 =?us-ascii?Q?10oXGN8XM0c9T66GAYOllWBMlj57PXxi3ftz/rdkoGNWXr479gBXOdEGi+3Q?=
 =?us-ascii?Q?oUaUk+ooFUZOAdD6v41a43G9BczDHam9SvQ9zivl5/DmwUyZyIR+w3Qafkpr?=
 =?us-ascii?Q?dlv+nXzho86s0fCozwU8U6l0laWC3zclLfi+xVBUsamNIlZS/HEC+0WzpTVc?=
 =?us-ascii?Q?My7iqd/yTUaJHNRbM5xp1u0Rwyoo1sTN9HAeaJy697JiLCQ0SNH7awGuNAnE?=
 =?us-ascii?Q?ZcHOxao+0apMPdSYva5v/QjNx3n09YfQjMxPjgotJ9r4lVPPTa1a7oUuQ7TP?=
 =?us-ascii?Q?WI64XxeOXas64c1KW+rbx1SBdcSfeNWUnJOm9U/Y21NuyZJSKffV40Ta08uF?=
 =?us-ascii?Q?YKLgok6PBSnWjFelpFyJVHUb9NkGEzXX0KfDxEN570WrMt91650dY2sN4HHO?=
 =?us-ascii?Q?Klwi3RvYEVsGz7G1ha5qQpK109YUkLmoDsQE8ngfVrqywzFgXtWiDo3kBiAd?=
 =?us-ascii?Q?MsaCA3eaTjUToGcUPKlmMfUPEdd9aRGL1QpYGny2+EUnJ/1jTKsp3yaXmfBN?=
 =?us-ascii?Q?E5JcQuiBrxePQ8Ss6iibKJxlAVkyCvLNgWU7Lq+QTrCvFnoNRVy0gnODOQIJ?=
 =?us-ascii?Q?0enMXXYC72unFbg6P38Cf8UotLuIRKeHvW5gTYqnu8j3ayxD0QEWjs9lQ/Ly?=
 =?us-ascii?Q?uTgEzdbZg33uaSQU7GMJaanaceH5PEBfkZN5WxH55YTmErSO7kqhVWaDhqJp?=
 =?us-ascii?Q?OM4HXBsuJnwVvO4/j3AQTYjEJ0pjr+rI3N4DOJmQ2TqTP2FpbXShjgbyeFzx?=
 =?us-ascii?Q?KWWZIzT1ZhJRggkHgYN4/KtcrU4djgK1kfLX98YNWuxvR5jTvRPU0HivG9Le?=
 =?us-ascii?Q?B0IFeIhPZETRBYxmCMheVjGNco8fp61yCMyWdzO0cSZwoxe9ZgcfK+nikPPl?=
 =?us-ascii?Q?2jQZk6nLGr8WShJe1WubqITJu3M80ELYxiwxsaahw5KOXTpqvpxLq4Yznw+A?=
 =?us-ascii?Q?SgeU/+PvhboheZAF7TihnHMK446DSgKCyUwJ/OVStlP+pTf5NjZjdxhm6KZu?=
 =?us-ascii?Q?u7UTBn/r4uwggEtL50HxxaBzMtSPkZsksKMM9Kgbqi99JVZJ7KHbRljX+5XV?=
 =?us-ascii?Q?VAFWaY+HO+liJQwD0jX3JJPaE9Dh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QaPP5GYgojXGk1PzzHPM54y3E5g8F1MbA/50PTnpwSZweT1LMb4lY9MuftcG?=
 =?us-ascii?Q?2g/o7kNgvIO+NcgOth1qvH2sjGg3r2qFu7hxDbPjnEqvsHp7Bi48Ef9HzpU9?=
 =?us-ascii?Q?qg4GJmwV9Z8P4q1XRm9ayeXWf8KuOimUjhZkg+ye+u/9am/7xpPxQqUinCcW?=
 =?us-ascii?Q?cK/0juiRxU30Tl1TVAtDe8Qbej8UpGEUk5FtgKDQixCpl9b34it7qqC+U565?=
 =?us-ascii?Q?9dhCuS55M297w9KWVkg8lDjojmMpKyL1LMTUSWflfwkeSwz4yo+NCJSWLjGO?=
 =?us-ascii?Q?Wf0/w1ttoO3MwOjzAV/BGpdvbTviB960unq9p26jJLKhGLszhQdD8yytpx9Z?=
 =?us-ascii?Q?cunBwW7M4uiK4if5Y7v79lB16zeV3NwtYSZDngfrHR3BMx3fRTn9wu+KVC0p?=
 =?us-ascii?Q?Vta6q958NN+fsxW0kqVzqQR7YWwJQcWXYr1Y8bDSYoED+FNEEoYG6HZmvfy6?=
 =?us-ascii?Q?G7TFQTrWCHEXC+l8pa7M8gPWMRWyL1dz+PIsyXLw5yEXHLkn+A7TfieZDr8t?=
 =?us-ascii?Q?YcnBT+Bq95Qe6ihs8v5lwAA5e3DLM0vg0XewO4twyqmMY50MsiZrIvjouKpc?=
 =?us-ascii?Q?uecrf58Ukg4JlAtkpE7q4XDmLHj0uc3hgGFUWleKYCM4GgqQZ8+0gYnuQq7m?=
 =?us-ascii?Q?MuB07OyYcRtUI1UrltOOJQsL8UX0PO3HlKzovbsexnGyx3c81Xoijpt3VH3/?=
 =?us-ascii?Q?QqmdHpl+/2FXHazEMR/WSbbm2WG+4I43XGesvjoVHvDXhWrixSarnR5Z3mFS?=
 =?us-ascii?Q?OkBsATVIuh4cpqzgWDI9DLTC0yQQtnORTsfbu9X3C9TitOLGT7cEEAhW2oYr?=
 =?us-ascii?Q?DoHyEUeDFKm1ppxym5NJt3LYZlh6EIqivJGXSznXUm32BJh/o3tbKDk+atJj?=
 =?us-ascii?Q?n/cBjCSKninvWiGEN6HH0ukfecn3NLzSM/LWTQQJFmI3x8AGfKkHhjFy1iAT?=
 =?us-ascii?Q?/v5dC3fLcekklExhTJygylb7bRkbIC0ZYXffiZFABUlRaocdCvX//zDwYfl0?=
 =?us-ascii?Q?AGW63fy+G5iluAj9m6INP1N8HJrtVhdLz6Us7TYQfFdCWsi01tM08DXIgQpg?=
 =?us-ascii?Q?ZdCnycoZb8Aiy9vxifI+4BI/M3YHAAETvxm3aXT6PpF4dTc4S3sFK2V3tXel?=
 =?us-ascii?Q?HLIqjP3+FHilw5I7crN5BnxmJM/Cd77G0AgSe+uQWHnwOegtgJmE0feJYTde?=
 =?us-ascii?Q?jFieZa3HoDqHqFporZCrXp46mUoNGb7XFDTieQobj9nGSQmILDHMT/VQ5YLo?=
 =?us-ascii?Q?bQqAbNjAhA05kj8Xn68mqkLzzmJbSRjh6zbr9ygS1s/r7O5O49Uont0D9GLD?=
 =?us-ascii?Q?CLqhn+kFFeJQX42VqItA5xfetl6pXqg9fsbMNUrKY/YIWACNU+FhYCXWWID6?=
 =?us-ascii?Q?Q+koQtqlLBwXnHydRfgks8g5674EdiXpzh/0w4RdJMLZvYyB2VTfe/hpifP9?=
 =?us-ascii?Q?Y80/2GrFVIanpDhSRz56EIkmZYtv51ObCC5b+yWD2blRdMghdXCOa2W0sJ6B?=
 =?us-ascii?Q?OID7h0rca+byPujCl0LYUUh+oSx3eeKRlV/FdKYXaqhfAhoNm9K5KIApVCnP?=
 =?us-ascii?Q?Adz97f//imx+j4euWTIZw2Dc96KyXmi+m3dtYg8DfaYQlV9QWOgEYFOUII0e?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe32e76-b924-4642-8cde-08dd5b4646d8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:59:15.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8zessICP0LLzTmD7wuDpPoDEdVoSwt0IK8LV0hNnceA58AR+i8RWzXtfQ+tMWkl3QLXThOKzoK8Q+X5aH6t8zL0dBJXVvP5+yg19X2sSnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6036
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> (self educating now)
> So CXL.io is not a thing, or not going to support TSP?
> Wiki mentions IO registers and DMA, not relevant here why? Thanks,

CXL.io is outside of TSP.

CXL.io IDE is a nearly identical programming model to PCIe IDE (some
edge constraints are different). So unless and until there is a solid
use case to cause the kernel to consider PCIe Link Stream IDE, then
CXL.io IDE can also live in a "Selective IDE Stream only, for now"
world.


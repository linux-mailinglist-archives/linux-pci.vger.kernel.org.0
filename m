Return-Path: <linux-pci+bounces-5902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BB489CD08
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 22:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8B7283B76
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 20:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E21146D6F;
	Mon,  8 Apr 2024 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2GMRjY/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1081B5FB8F;
	Mon,  8 Apr 2024 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609130; cv=fail; b=PUCq0ukt2iyD7u1HFnbxRXxExoXQnCy8fnhLAEsUu2RxmmgOLuIck77QE53V0AkcK7GVaA0LuDy+U7D2lYf5qhQEw55CZfbbw+ehOAqjWlB//NRxQwiY8t+lczJWkghFk5UCD7LFM7z0To5AKgUS8L5IlQU7WvUwNgQSkhBgUE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609130; c=relaxed/simple;
	bh=IguVjPHhdPzyLg97u/gnGOE62s60FErOlyBfQDV3904=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZvbSVv6Bu709Z5t+bBNJJ35L1j3P3/4QdsSdXYimkbRd/FHDy52lWWrP8+/A+Veq5J/Lp04T6XlIfLJplPBitXh0IGQO+dxrx5t1Ge3LcqprN+UJQhojkyWMe7LIjv+ixgOPj0RVItYyoG2wz7Fxupt6vtYA0mnRjixsVhKHBUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2GMRjY/; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712609128; x=1744145128;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IguVjPHhdPzyLg97u/gnGOE62s60FErOlyBfQDV3904=;
  b=d2GMRjY/jvZScRD3LtmlynUZYU0Qx8GV6k/c6DrM22wNhT7l5bSgRKvR
   u5qsHIOhZDW//WL7zSTyzFrNIRwNsAQXEaKFm+j91Ef1N6tNyIHPfii3S
   bepZRTfyWwO5KPh8vNvbsFVy3U2HSueYdC2tbWhOBybP1xmLGJrykQYGZ
   4gION/qzztkZNoN2i5Wv+aCIZYBX+dC5ulO67n88U1HEbt9O51qrBENiC
   RK/f/XQH1LwDWQoZ/fUw8N7hc4ETpLANvfpy8WcUOd7C5cmjmkd/HfEju
   KWD6f8RWs4NNV/1RYzO+RqryAcmHrbGq2Yi1AOlfmU2nG4v37Z/kuiHRI
   A==;
X-CSE-ConnectionGUID: GnibU8ovR3urVv2zoeCewA==
X-CSE-MsgGUID: N8TYVy7QRXObUrBI/wHubw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7778460"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7778460"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 13:45:27 -0700
X-CSE-ConnectionGUID: F3RaqTKHRaiEr+kNwqLfTg==
X-CSE-MsgGUID: uVzxuaj0RJyc+dSkK/3+Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19915286"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 13:45:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 13:45:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 13:45:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 13:45:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R84yF+PShgZvouxGFWrfwzeb4daMF2iYh+lB+B9M+Cqe+f7o2hJ0qwTqJlUeakpVIe7aTBleBZEd+frjMRT+zFxBfekCAWUPPGYamfw0XOEUNE678hCQxQ9KOs0oTJCENhtAe1OhaZKqCB+LbhLIZOp+PYI/am3uMTUwZ924K2Er1B7rXvbGsTH/z5whKbuPHXd0jGWftNwdeI4dw3P5LH3D/iS2JWkh6EktysKnHcsTX4hdXW5vtyEnajGsVBmLhrIXMsM49X2L6odtsS4GmbZWx0fTwRMzuLtKM6YkfXN8wVWjGWgUiJkcvflt53ZKvyMhquRHpxiveNMJnRJsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xkk97vrvoyAAGLTc4JdFtqq0p/oKPSQkVD7gmm2EmMg=;
 b=Y/6V4ldcyvFBt7i1CUFcBk52GsDPw2fN9TcMmnwad/WbuR7LBDY2An4MPrjSppdl/TK3QYfKrY4/P25DHTMTnWKlACGvGRQ5Rnce0rf5b2DTE4NhgXeskC1PtjYLZ8HVE4/Rp5MdwzTxyixmcgFUbbFCrL+OWf58f0C8DtWQGHCZZWo+A7A88mR1Htm19fHqQWJCpp/9atRa457ngfD8789pY6TJg8xYUIVXWbHE3chIsrSB1Mc30BV/OJDe65ZpzoOnps6+E5bzspZ5BVU7ogcr4jx3DH3wzXlUwWx/a1eICBoYZryFo7XyxamxsIGkRzrgd3cWx+CjrH/ndikYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8456.namprd11.prod.outlook.com (2603:10b6:510:2fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 20:45:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Mon, 8 Apr 2024
 20:45:16 +0000
Date: Mon, 8 Apr 2024 13:45:14 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: PJ Waskiewicz <ppwaskie@kernel.org>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
Message-ID: <6614575a1c15c_2583ad29476@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240407210526.8500-1-ppwaskie@kernel.org>
 <ZhMP-NBMb387KD4Y@wunner.de>
 <ZhNQa8wAflycciNA@snoopy>
 <20240408093422.000062d9@Huawei.com>
 <ZhRFsUiDieY+HhfV@snoopy>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZhRFsUiDieY+HhfV@snoopy>
X-ClientProxiedBy: MW3PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:303:2b::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8456:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HJeYLHtkuUyphyjhXAi3LlFjiMprvvogTcd+7fTP8wFs9HZ4A6oIFrveAhGJWzgk8X4W2QxOyfdKkKyPOm8Up6OpiDaYkKlJzHZz4KJu8eQODYE5Oo+YiwY8YHytfy743ei6z2E3T4ySB9iwFQAe2xTRrbey57QEC0/s6zZtu+Tl4fkm2thz7AGqpvabPDDKVoHQColE2KHxBcOBlkfEbiNgYV3JtFDUncHlOK7K2VPv8Oem0mUB7IVbml22BQomTB48z6rIToA2Xd9Jc29iNotzas4qa0fXYsk1RrzntZON5J/5XayWB1YTnsXfgKjQdiRTpscHP0npaj3CzTwrXgAj4umqUgLty+e54UitL6hkVnNWl6Tvhsdgzdma9TEVpGvVbNQg9DncOL3KzFp5u4FIo/lXe56ZIyyFV6cLFFpnjcqJSFy+c9pDo2Gr6etifW3U/ILL8Z4oSGsMJdUugg+1qEQ/H58bKz8SJANGp5f0mROy0zM0xuKS2n2/ZsJS7wGcsYhzE7DyonzwPiRBXJC9PNip1OUbLW1VbXYV/YHG+OtHJZzXZwrXHpuqQfPo1b2AVDYKl+IYUTk9GgHp/c97efXngVA4/RhnttYsM8VQ4GaA+IBeshdKAljaLIrNTWgXXHzF/KEpzAL1bBgwKEZXiqAP5nq5cminHz4I78=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qbzErlEW8kj/za9P3Cev7NHvceuXfpFEW17uX83hDDdxYaaBefx8YgGqLNYE?=
 =?us-ascii?Q?VQ2WoboFgqF4+Q9rpWLmJyu3ms84ljmelpUXqCIb4FZERb155iHvzh7907CS?=
 =?us-ascii?Q?1x9UU/SYLKfxC/NjTV+UvnmnQ92lfU+x7jRlkTVstk3fMgl6Hyo8s0VEqeew?=
 =?us-ascii?Q?6LM0cemPYzKdtkffTkWRxk3WtfXCFA5dQi18OmA66sBryCDDcJLA3GcUgf6G?=
 =?us-ascii?Q?+wn9iGVo3Jl2ZY9gDntjWkuPnesVgpCkzyaOftASeImXsBhUG83f6lwINCcg?=
 =?us-ascii?Q?Fqkq1otuMbQp4PN8EMrVBLzwK0ZJRsTknDUA7Ad5jlp/QMsf4fgxSY7nH+YY?=
 =?us-ascii?Q?cUylYl3zX/oRyKW45DvBSKUHoUbqDaa7iBhH/9DekcSt5vq37Rjc4pjnfcBD?=
 =?us-ascii?Q?Lxl6hvbqQCaDHZdgoGSsoxc8eU/Soxrvud8cQ2wLHf/pFAxKZYBiOp/O1a6E?=
 =?us-ascii?Q?p7hgZ+SNAb2by7wB6dz4xCX18HwX65vVnQC4QHEqvGhN4MErbjuFTsDZwUD4?=
 =?us-ascii?Q?2HTqQ82UNGrMgl0MP8HWC7jDJ5rc94cyRSx3GWzRUYQ7umLJ6rfs4X9AU6jd?=
 =?us-ascii?Q?Yw+j7XBOpHD21kGZ5sLyesR1GyrzW9VkwLDjf5kbaQLdXmB+5xKmrpjW2y/g?=
 =?us-ascii?Q?YWM6/LEXx1dzXiARdoXkichBM8ywhqacJimTAvbGs3jtvMNbbeNwOhU3GeLd?=
 =?us-ascii?Q?ODns55t5wno4Sp0gRIUOSUti6Kvq+zhKQe3zWc0ZFdWkpS5GUAfsMkeyU+qp?=
 =?us-ascii?Q?wI7bIGGc08uF7YE/oI6YoYvztUji0iZ9d8cjceWe+K8uXHbifgj29yYS6Yl2?=
 =?us-ascii?Q?tLe57zA/uCYc4AL9Fq0fTLPivt2yLwNwpO+w79ZN/YkBC6irbFWzZP87KMFM?=
 =?us-ascii?Q?/7Sa2EYfN1HT7WRpsccJeHFf3q8Ff52C8rCyeNuGgELO97PISGgTMuuyR6Oi?=
 =?us-ascii?Q?I89zHzOomQ3biE73AJGcRmAMGibK0RBboo1lLc5pCysqGLRcfQgOEY20jzhH?=
 =?us-ascii?Q?qAUrV6YpNxgALOzCA9TeOh0RHu1VKSQebk9kqPoecJdTrzDyuyFIeoJPdnX2?=
 =?us-ascii?Q?qrN0deuOV2G4nhV6A0MmrUm+hUXUWhNlXiD2z6QS+wVhGZsNToPiCMnPQQ17?=
 =?us-ascii?Q?eqrgnTD+xyv5eSdD4R9hcCQDF4q7mPI419Hbt9IK/PpCh0nIGDa9Pa2D4psz?=
 =?us-ascii?Q?pveicfDDfgqMKK0r74JPypbY3D3bx+id8UUVE8gFe+6hrpJeer1Aj3FvObrX?=
 =?us-ascii?Q?Y+s56n3k7E59j0s3CP2rw0DvQtZka1NPGTAN3vpea7HLzKjXas78un8jJvNa?=
 =?us-ascii?Q?ZFFFID/jzj+2fpd4ceRZBetkkkcHD+6TuQiqJ/958hyzAuZL1hIktOwwURU2?=
 =?us-ascii?Q?mNcmDaktZJyc10t24+nDxw9ejN7gvhWK1AzhpF/pNR/3b1RBucNgkiAx+mCc?=
 =?us-ascii?Q?Lp8MckIboZPfv0/iWPqwALK1FvhzNP5DOyxZII4I0WEBs9CsbQ9SKCp0F1Xd?=
 =?us-ascii?Q?c/1HTc0NHDd/HEUyKcRK5Boy7vzYzW7TOxDHDTpi7WuEi8PH7veHHBaPyWiL?=
 =?us-ascii?Q?IKuvNxOvbSe/nPl7rfY4map2UpHBu418b1vAAYunhGH74tRFAZlcFcOJt2ZN?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bcb3d1-9b6c-4c78-ae7f-08dc580ccbd6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 20:45:16.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9tXYTLhXXXyDgCdGoZ29CIyv1RKXVFOCAzledDqe3nkm6FUFzUL4ZYF3WKeFEM5jcFNFnud+vCduA1OYRLJw1Hntc+Dyhj+t9A9og+nrN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8456
X-OriginatorOrg: intel.com

PJ Waskiewicz wrote:
[..]
> > Other than that seems reasonable to hint it is probably a bios
> > bug - however I wonder how many other cases we should do this for and
> > whether it is worth the effort of marking them all?
> 
> I can confirm this was definitely a BIOS bug in this particular case.
> The vendor spun a quick test BIOS for us to test on an EMR and SPR host,
> and the _UID's were finally correct.  I could successfully walk the CEDT
> and get to the CAPS structs I was after (link speed, bus width, etc.).

Oh, in that case I think there's no need to worry about a Linux quirk.

I do think cxl_acpi has multiple overlapping failure cases when what you
really want to know is whether:

   "CXL host bridge can be found in CEDT.CHBS"

Turns out that straightforward message is aleady a driver message, but
it gets skipped in this case. So, I am thinking of cleanup /
clarification along the following lines:

1/ Lean on the existing cxl_get_chbs() validation paths to report on
errors

2/ Include the device-name rather than the UID since if UID is
unreliable it does not help you communicate with your BIOS vendor. I.e.
give a breadcrumb for the BIOS engineer to match the AML device name
with the CEDT content.

3/ Do not fail driver load on a single host-bridge parsing failure

4/ These are all cxl_acpi driver init events, so consistently use the
ACPI0017 device, and the cxl_acpi driver, as the originator of the error
message.

Would this clarification have saved you time with the debug?

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 32091379a97b..5a70d7312c64 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -511,29 +511,26 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
 	return 0;
 }
 
-static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
-			struct cxl_chbs_context *ctx)
+static void cxl_get_chbs(struct device *dev, struct acpi_device *hb,
+			 struct cxl_chbs_context *ctx)
 {
-	unsigned long long uid;
 	int rc;
 
-	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
-	if (rc != AE_OK) {
-		dev_err(dev, "unable to retrieve _UID\n");
-		return -ENOENT;
-	}
-
-	dev_dbg(dev, "UID found: %lld\n", uid);
-	*ctx = (struct cxl_chbs_context) {
+	*ctx = (struct cxl_chbs_context){
 		.dev = dev,
-		.uid = uid,
 		.base = CXL_RESOURCE_NONE,
 		.cxl_version = UINT_MAX,
 	};
 
-	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter, ctx);
+	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL,
+				   &ctx->uid);
+	if (rc != AE_OK) {
+		dev_dbg(dev, "unable to retrieve _UID\n");
+		return;
+	}
 
-	return 0;
+	dev_dbg(dev, "UID found: %lld\n", ctx->uid);
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter, ctx);
 }
 
 static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
@@ -561,7 +558,6 @@ static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
 static int add_host_bridge_dport(struct device *match, void *arg)
 {
 	int ret;
-	acpi_status rc;
 	struct device *bridge;
 	struct cxl_dport *dport;
 	struct cxl_chbs_context ctx;
@@ -573,19 +569,16 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	if (!hb)
 		return 0;
 
-	rc = cxl_get_chbs(match, hb, &ctx);
-	if (rc)
-		return rc;
-
+	cxl_get_chbs(match, hb, &ctx);
 	if (ctx.cxl_version == UINT_MAX) {
-		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n",
-			 ctx.uid);
+		dev_err(host, FW_BUG "No CHBS found for Host Bridge (%s)\n",
+			dev_name(match));
 		return 0;
 	}
 
 	if (ctx.base == CXL_RESOURCE_NONE) {
-		dev_warn(match, "CHBS invalid for Host Bridge (UID %lld)\n",
-			 ctx.uid);
+		dev_err(host, FW_BUG "CHBS invalid for Host Bridge (%s)\n",
+			dev_name(match));
 		return 0;
 	}
 
@@ -650,13 +643,11 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 		return 0;
 	}
 
-	rc = cxl_get_chbs(match, hb, &ctx);
-	if (rc)
-		return rc;
-
+	cxl_get_chbs(match, hb, &ctx);
 	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
-		dev_warn(bridge,
-			 "CXL CHBS version mismatch, skip port registration\n");
+		dev_err(host,
+			FW_BUG "CXL CHBS version mismatch, skip port registration for %s\n",
+			dev_name(match));
 		return 0;
 	}
 


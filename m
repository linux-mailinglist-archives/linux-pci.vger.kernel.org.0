Return-Path: <linux-pci+bounces-5302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E177188F4DC
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 02:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBAA1C260F1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 01:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3585B1804A;
	Thu, 28 Mar 2024 01:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6j2PTnv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C541798F;
	Thu, 28 Mar 2024 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590201; cv=fail; b=pISabdnk2s/j9jVBNNcIVg6bptZ4eRRcFMEJ7cdKedbxgRARP5RwcIVBFENtNBGgJXzJPR1/u6uOLwdTIUL8Lm2R5xOnpElaornRLmj+5q/nkKDulIfHFjdrj++LX9BKUWYGCDrHIU6IpXX+4ryR4cpjLVIGMEy+KmXGC6p057A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590201; c=relaxed/simple;
	bh=KhWK3/bUuR/Znl9GylXLMPu6MRT/JT8uxfFj5VWmU98=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aMlYko+jPZb4Dn8Zsu7C93Jxy2CXuY7cXeDC7l04WzNhaDgz4v3jZxQ/5Qxlpkm4Cwb5wU/LAb4TAdpFEbiNQbSNwF8OdvaHnYElifPNt0q7HODizSnSTuZ0BRYKAfLCm82b13FUgX0xr6wHWOvtiQfMIi+YeKF6YwnPVXjJKZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6j2PTnv; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711590199; x=1743126199;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KhWK3/bUuR/Znl9GylXLMPu6MRT/JT8uxfFj5VWmU98=;
  b=h6j2PTnv2P5FjcLkD+Nh+UPeYrswwz96U+Oev4sm2eBMyPEhxjEQHNnn
   fXU2QNRWyUkYme7+XlpQi6uH6s7kNeRffkNGN5uVyHgYrefkyRee/hTa3
   anByn7m6dgUIf4eTFLSJF2HLUHVFYE9Ny587HvWOsiXNMKIvndgh9BDF6
   c0dIxCrSbJYh8ALoZZSn3TBRV/6sRHAGeQuL+eIjPaPd8xIjVv091yB+M
   S2AcLbOE9wi9NolbRjohZ5iwhy/7jhVqX1ia4dufUZIRJ1VzMoER6qost
   zY6ZiKepntOVYPzKlFhhsLHNZrUA9dDkrIOMvV877N2VWEC1Hk5Ka86MQ
   A==;
X-CSE-ConnectionGUID: AlCqWuhtTTWZ2au3ZgDxAQ==
X-CSE-MsgGUID: ClQj+ledQ026VQlVKuUPEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6915312"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6915312"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 18:43:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="17108669"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 18:43:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 18:43:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 18:43:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 18:43:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECjTkrm3gymjmYAP5qUmq754GL7ghqHYU1fHPjKW5z8wG9DLpuFIfmjn93FvqFvVV1jg1xYm2OBqvc8fT7GxEfw4Y7U8yPPNGRU8cfsjDiFvPxgoV4bL/JfrpK5wfWLF/k348PhevnJpC34OkX0SH3v3f2fPcVjWk6hCKYLmdA7r32aNN2A+NSrzwGrl7t3uBAPI/+qQDhtow1hEkh9yAhSsHgwOTv5/4dKjxC3njawbKKleALs2KGJS0uLQPBvdl4WJg6mEGKSL/2C7i15x3mmuDKbpJL3WoY+2rsjrVCVzgFIaCWfJ9CazCRTftpnt853GS7UP1+8h4WcjExd3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4EVnkcag23VbbmRU89QULEegm90HGwZD8hseNnzVW8=;
 b=TPcTifW31RZfiO8Tdy7dVuT8sE0/iuCEaJsSmdcTgSGL6aPiOoHc3e6Bcy20UhLoztjqktruxzTI3tMPczZKN2J8OROxuFRxdj9S5qvPzoGOu1zDMMX8UaVJPs6tjvD2oDJz+W5LMU818cJLOE5shzXWYrIGgx9dR0b3JQcr2PiwJ0UIVFTvRZoSGwHhXapTO6+mH6hStU2iiB196QDDCa0u68ACOlD5S03e4Mywy43CpGvzDiyR5U1FNUAyZ9i6BK0/6+I+VqxYXabZJ5bm4LwZ7tY25uu6MQ342Apy68FyUMxP00ZxOJfyO5gyDNzCtLQQkayxgPgrKnuA3LdDjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8506.namprd11.prod.outlook.com (2603:10b6:408:1bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 01:43:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 01:43:09 +0000
Date: Wed, 27 Mar 2024 18:43:05 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>
Subject: RE: [PATCH v2 1/3] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <6604cb299ac50_7702a2946d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240325235914.1897647-1-dave.jiang@intel.com>
 <20240325235914.1897647-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240325235914.1897647-2-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:303:8c::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b09c4b7-e3bf-4ffe-a7da-08dc4ec86bfe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GQRQzwh7BDbHc0oHAXAoMnNzcVrKEZ6OgKIGB95tp40nyyo3Qe9CO8kCV5rV/qyavJS4g8Q+6wM1xkoMlktIhJkZBHE456NWkEnI+WTm2Uk32dZlGvF19JideHQ2sZxExP+hv1Decyf+IZhQFncgpNMiWShnBaG4POb+lDy097g/JwA7Zbn8GxTL7NA9RfEHiLhHKIOux5BIpOuXUWKWnI7TfFj4LYzU734sgwQb0gHZt3amyk21ZhOVYVlDgouWOxWHTVcLtsicpRS26j5nvq/deaxGDoA4t9wpMB92Pp7H0tDN+U3WHZPEjXgpHlOuQosJoxckLKF9ks9XpcydRkzNgXXwIMdfJWq+qrvJqN5RJDJbSsTXji6I/o6f07jT7/7d0GmvVfhFtGY5tQa8lJDsG/CGcYEH3EYGUCc9kO+w2hb2sWuad15QS0qAQhnHeJi1fur2NEcQ9zbcqa7wD8nJyHT4pQrKmY8y0XfmB89Bm0Q1sXO5u9xapgplZzx+KRKj3wsUFjvk+iEW4X4FJrLPJw2yHxNdJHjeLR5m/ZqbJsOXEBLGlJc6gfRAjVc0jqz4hcMUGx15kLCb1FNjljpcptjEW0fLNqRmNMWHGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lZDIVoOQj+9mTnBkCBphT45pufikHMKCjHq/KMjieRFetRNX+kX+xAsQT+8H?=
 =?us-ascii?Q?LcRiUeEtu7XUz25ZR2ZRN0LBU6EWCcCscJy6sV036XG4dRE0FQd95ImcQWzI?=
 =?us-ascii?Q?J97xCtcEfcYjFKKZZSN7VOfBHPDP0opciU5qlHh95mhM+JVtIpo6ay7/27Sb?=
 =?us-ascii?Q?eM8l8STapwDrsAujg9UCqiyvTx9iNHm2cR0OxUnIaVOJRxefQWqWuGrkC7Qx?=
 =?us-ascii?Q?CqFfXF2W4A6uYEW72qlPaKU3xpH5jfn6VYuQ5Lcmx+LHkxTeUpUnNTlE6/qc?=
 =?us-ascii?Q?k6hHA0XrpzuDKMCSrqupV7J44nS15LVBChxI5/I3iMV1sOphPRIIl0QMWqqn?=
 =?us-ascii?Q?NXwAjJnQhTsQJD6JKiiy1/jiq0dTreSMnDmLtA5u4m8Du1bPdeewsiCy6z0p?=
 =?us-ascii?Q?c+1RMnPxx/V7DYmaQL5IsdSugg10F4cTnpgfeMz8VZtw+CPeHazxZpdOi55A?=
 =?us-ascii?Q?UY/pRsXXaDqY5u9kp+NE9MgMP9Bk5FkAEPXc1MsWtp58Ul0KhbpQwAw3cWW3?=
 =?us-ascii?Q?BJVp265+/KRWXnW0ES/396gtUs6A7EsrPb4/AbtyBWyCQsmySN22qIyiXNcR?=
 =?us-ascii?Q?y/pBkng3IBlKyOugwwjZdak0UKLao35Qwd/ymZLxM4IekUpXOe2zjIipWLyQ?=
 =?us-ascii?Q?b4RE+nUY1cXa04HWgZloijIAJNEoqTKvCTh20/N9T04qgHGiQTN/Zb7zpvsN?=
 =?us-ascii?Q?lOeBHPyDUYAHPifKpj7FGOhgBARbZA/f6htUnzVeriY4NkcB8ynmclDAQixz?=
 =?us-ascii?Q?57+Ezq50IdhVx11F8ccdEkcC9iAYAO+IxSy50vKzQDcoEURBJCHbdehIROcT?=
 =?us-ascii?Q?kLoT2/bzGu3OpnymTTElgOJcQxCGtRk1ul182ESUet2LFUdKqu4UDZtZDrlc?=
 =?us-ascii?Q?j+c7QhMqqATc8oZbMC2LtQ8bHzXYYsB3csDZIRw/nK78jXiltgxUEzzdXNiw?=
 =?us-ascii?Q?Ky/yKHt2Sq8gziYk8o5q7W39Z0g3rABPIlzBmKA9qll7i/VjnPsky6p4gU/o?=
 =?us-ascii?Q?K+quGgaGZvvFnEy23Muon7LNH/141ea/GRNgPe8xBhRZ0o/aTwHGfusnrzU7?=
 =?us-ascii?Q?2IQQAMv9QVaIp89VD/LFwWgrSiRStl79syr698O91uJgQPHAzHv0N7MFpltH?=
 =?us-ascii?Q?T3CoTHRVzqXUhBipuPz/XesIR4JNhQHRFEo5m79Kt/Oslti1c6+TIUvX5SM0?=
 =?us-ascii?Q?sN4ZOJiSFoxKrpMRZCIWFnlAWvDKvu7rKwsMAEtU9xWho0VJBPwVenTXCX33?=
 =?us-ascii?Q?93qLZ9VtaY8dmFKOynqRuM/P/hbal9NCfy91MMzYu2VKeGzeKBsnxfqNxRid?=
 =?us-ascii?Q?JnImjWQprBD2LBpaxQ4wPvHNfV8EaRnZjyOKuaMjhpngVsuhiyjOOLcF3Iy4?=
 =?us-ascii?Q?+4/q/E9kVq4TBAGnzrYdEgjQeQ4i1DE+/IJE2XxnI5X8SLFZA8YAu07x0EQH?=
 =?us-ascii?Q?LssaTbJF7I8+Mar7lpb9bzRRSTsk+tl4Npg4Q/qiKJ5WQpq6W2bMyUMB9Cet?=
 =?us-ascii?Q?xoDyehYSxE58E3gZ3OURBM0YFPsmKPas1Tm5gNl+s/Hir3iw+Jnohycnjy7g?=
 =?us-ascii?Q?15sQv2EUmeIQRCOOt/vQoXCMwCqpmOz1nXpeL+njRiwlDbcbEXB6iSYzwrJ+?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b09c4b7-e3bf-4ffe-a7da-08dc4ec86bfe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 01:43:09.3776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1KDCXxR60a74lU9XRvd+9lpMFNnFwBULMWycNAGre26t0d4g0VGjRRZC40gLDoZ3hD2Xea1N8PVVd3e5HqV8oHZg9Jq3GuioR1xOKtOJRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8506
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Per CXL spec r3.1 8.1.5.2, secondary bus reset is masked unless the
> "Unmask SBR" bit is set. Add a check to the PCI secondary bus reset
> path to fail the CXL SBR request if the "Unmask SBR" bit is clear in
> the CXL Port Control Extensions register by returning -ENOTTY.
> 
> With the current behavior, the bus_reset would appear to have executed
> successfully, however the operation is actually masked if the "Unmask
> SBR" bit is set with the default value. The intention is to inform the
> user that SBR for the CXL device is masked and will not go through.
> 
> The expectation is that if a user overrides the "Unmask SBR" via a
> user tool such as setpci then they can trigger a bus reset successfully.
> 
> Link: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
[..]
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e5f243dd4288..259e5d6538bb 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4927,10 +4927,55 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>  }
>  
> +static bool pci_is_cxl(struct pci_dev *dev)
> +{
> +	return pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
> +					 CXL_DVSEC_PCIE_DEVICE);
> +}
> +
> +static bool is_cxl_port_sbr_masked(struct pci_dev *dev)
> +{
> +	int dvsec;
> +	u16 reg;
> +	int rc;
> +
> +	/*
> +	 * No DVSEC found, must not be CXL port.
> +	 */

This comment is unfortunately not correct. Per CXL 9.12.3 "Enumerating
CXL RPs and DSPs", the CXL_DVSEC_PCIE_PORT disappears when no endpoint
is connected. So the comment should be:

/*
 * No DVSEC found, either is not a CXL port, or not connected in which
 * case mask state is a nop (CXL 3.1 9.12.3 "Enumerating CXL RPs and DSPs") 
 */

> +	dvsec = pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_PORT);
> +	if (!dvsec)
> +		return false;
> +
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_PORT_CONTROL, &reg);
> +	if (rc)
> +		return true;

If the link gets disconnected after the above check but before reading
the register the value returned *should* be 0xffff which should
naturally indicate that reset is not masked.


Return-Path: <linux-pci+bounces-5907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1CA89CDC2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 23:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE2F5B2229D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 21:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE321487E9;
	Mon,  8 Apr 2024 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqtkPsoB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B691442F3;
	Mon,  8 Apr 2024 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612616; cv=fail; b=jBMRM1yx6qNVo98EeJAmR0BEFpPdAxp+bYcppefkPlebenSf6pv5yy71UKUyKo+0BBlJjUOY8LMW+ua1TsVh5Z0Nj56BEAYkJXdwUtxqNObXnfNeoiQvPc3f+FNWbDOLiExhxQJcYb4vXfTsZcW6dXW9JlWVaoxNKpU+6Kb6MAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612616; c=relaxed/simple;
	bh=wqcu3lI4M2WTxeWaygTNk4NM5MW31h7N0veO/ngBC0I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j4QG52SqsV1c2Tk667+SnbKJRbHayRNEgGtCWx76Z36VIjQ3Lbu45ERJ29REIDHvNf/0EawxF8h0c44OxG6WXmRx+frmHr/hWy+evEJ+MgWehG6nKQvz2CJw1OTJ5K1OR3B17HGt4bd/7niiiuF8B3/Jl8gTz9Z+iH5pGwqR97M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqtkPsoB; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712612614; x=1744148614;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wqcu3lI4M2WTxeWaygTNk4NM5MW31h7N0veO/ngBC0I=;
  b=MqtkPsoBJ+q741PyCHU3X4Nf0geligBLLDx1riijqUVGlEtt1Oh92exn
   prvziFIz7Ji4cOPZzvMGkJbR9PGzg2zEnxjx93Koz7IWFIkF3JHMOkBtQ
   y6ibqe9rq8dkbJkSJoJNXsXCwR0NkmvJoJAQWcg46GP/v+gmOquUAh0nn
   ihhFUYQrR4+JrWL6J6qx9ePBBWTNPVBlqkXfYYh1gjvUuMXwE4D+Kpj1j
   AblLi29gKfmhmh7AeIFYtnQcsDoEkOpg6CAWXrN06JNHYEPlfcSgUmS7v
   uoRKs+e7TxdFjcuBrCBt9Q7ghtcRCKGboI9xpYyZGN4HqYEtxvI2eHR2r
   Q==;
X-CSE-ConnectionGUID: CrHfZOcMTO6rX07CYDylbA==
X-CSE-MsgGUID: sH83xUcDS8qwSsnI11LYtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7779168"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7779168"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 14:43:32 -0700
X-CSE-ConnectionGUID: XezNREhmTFe3Pv4IArKvcA==
X-CSE-MsgGUID: 5sk4YAOjQHWogJ2EbRE/Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="51007657"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 14:43:32 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 14:43:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 14:43:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 14:43:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTfcc6U19EKYSBtY7bC9BSUrNIMKDbX6NzkMVZ0NoGNoISM1fasuIY3pH4xbOfpXVG1JVctoKlL9LC9UcJmOnVOwguuQprM8SCyo86eW+S5ZdbcOLrvKnVFoIIL1gRj/jZhGF1lHwz5mdWbxiEXph3GyO3vObzKAFBSf5ubjuhK0vO2LIhDt6ddpWgPkuFx4fGRXWnQIPGcFf+yUDlusAXN1rnayWrR1f+3Y/4CGxQ5iGSxYF3RvKJHisTwLufsKcw0wl9XHL/WwrUYImVUKSajKkPKG3nZ6OfF5Wa1IE8iIu+9PFJ6f4ocf7jcmwDgwGFAu/3BOGSPxZaFyhGCHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3E/gVAn2lJKZAtEpch0ISnDCQ2chmlSC6SWKvCQV5dg=;
 b=OtS7aIZnkHaCVe575mHPlaYjuJNNYKTQPnL970J+1u+enc/YfV400+G5ZE8xqRZb9vFtzvVnCvAw1Bj580b0m5weWS3yLFQJU4Hb/BZBzuMcW1okkxLJ/bQN/2U+lrqdTOLnh+IKsoG9Sv2eBqz23Hjmqt4coIf4KHwAQJVfOnNx9dGc8HQeEHXRB8zGdpena8ZFVXh+5zPpJB+0AeB/8XDijDuUCqx0D0vx7IsYW1wHZRG+xxwsZYSsm5vkfroEWhr3rI8IwFP3UzeU1yMBQVYBJzHYemVAaHRRQobdp2n1hEp5Jsbdg0hz4zcgB9NE5szW41A/pYIahcTjH1jnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB8166.namprd11.prod.outlook.com (2603:10b6:610:182::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Mon, 8 Apr
 2024 21:43:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Mon, 8 Apr 2024
 21:43:29 +0000
Date: Mon, 8 Apr 2024 14:43:27 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>, "'Dan
 Williams'" <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>
Subject: RE: [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link status
Message-ID: <661464ff8492a_2583ad29419@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-2-kobayashi.da-06@fujitsu.com>
 <6603275faabc_4a98a29470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <OSAPR01MB7182912D196E74F55BE1A55FBA3B2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
 <OSAPR01MB7182D299E092B96C43B7FBAEBA3D2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
 <OSAPR01MB7182F74119B93BB6D944C1B1BA032@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OSAPR01MB7182F74119B93BB6D944C1B1BA032@OSAPR01MB7182.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MW4PR04CA0043.namprd04.prod.outlook.com
 (2603:10b6:303:6a::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB8166:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVaPbGV+EMyw2i1FR0qteQIYCH7Ysqjj/biHy8kuCHEQyKjM94WN7cvxS4XS7pxR+KiypSlxe7n1smjrTgUUzZ5H4MHP/LAWjCh9gcDOsVKMyVgrJAR95jTi/ruPyevs+kxKH1KqTGHPUpdVSHPNaeT7JIRn1zwEyud+QOhdsKQUUj67JE5ItotSMJigbc0IUUkPFK0DgzREpmm7Y6xWtLy5LV2OLtvfpPD6wOH6LdKxy3tGoRnAyZeCHmkRBZreOdYwbbEFWAkY7AXIuD6G2e9/QGqR/VQ59ZATkvIYHb9kalhjMQzv8CSBCjZr5lMhqPlgKo4Jfjjqst0XrAcixAbL7ky/Zn1Lh8DZkmn0Untggxezq54EMthuJaH1HrHZcwPDmjzx7k/OjCmCdNRx2r3Ct5bzN1YY0XLj4/XUYBJGLml/X6T2k57JLmcpNVB3jIEqTUISOgC6gmqYmbnIlRsskp+teTk0HiwwEvA8VLJV0s8tp+isw7U52WIfjqiKEI9q7iis6ftI5xfRFmBty7QosQ98WK2wGyEGwdw9FiPqedpXMZ+It4INSISTFIFLVx2hHLhTPtm5dTenmurssRbFnPBHowWZrU1OxkxCsrW/SVB3ym4HVT6jZ9OQ6Hh9J8WOuv0TmAdzaLMqMODX7nOrGIp0MU8wA5mES3T5960=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AD3Zc9t1zrknpxao6V2VqFeNJj0fBhylpABrSjFkK2kv7UE8dTfQaIi+MG/a?=
 =?us-ascii?Q?SQmQS0SEqWO0ITVC/1Y1w47RTzgDQ6njWHfPruC6PG18LaAUZvXAOITllqtA?=
 =?us-ascii?Q?JwV12ysMGp5J/x3/JX2dSPPVd0Vhg9t8Q5SSz/zm+zEXBnbBCxyizAastqnR?=
 =?us-ascii?Q?Ib+WtNmiiRtGNXJpVDS8PIFg4h5Lg9fMchQXeYiVBMvNndD23Xb0Xz2LKdMv?=
 =?us-ascii?Q?fT9glk6iQHBaLtpK/n8GsGatm+cGUxehcfcaubvYPiftDNlHjvO1YgLmYKXL?=
 =?us-ascii?Q?hNjVAILc6Uah2KYgEyU2JchgPVEmLo6duPUy9itM1Z0ljlQTMf0a5TfzFU2B?=
 =?us-ascii?Q?sibYMrLSN+KHVV2TyuBtPZ0r/ZptQcc1vvx5ey7sM4YAPMFh3P4srsQcccJk?=
 =?us-ascii?Q?bQd4jX7AI+UmUBfjIq5rDjSHHomsoAofRPTRHSyPIQURjgTGT3Bw5rsiExCi?=
 =?us-ascii?Q?dMioHi0Kywn79ykuf1U8rZ0YHHck44zE+HwFhpXjrgRGN5DBoU5E8X2vrzay?=
 =?us-ascii?Q?fRgYcMpcR+n201jj+Udrm1NW71Coh2nmsNeQ9oTt6ScbU7adsKBEd37VUawQ?=
 =?us-ascii?Q?UqquLgJ+ohEhq22QfnojKUIcjPq0A6e3HC3XRsJVIh16cjkRW+VAe75sByxU?=
 =?us-ascii?Q?Gnc0QxrwBqIQmxDkgLryzV8jwuzv3LrlK5vna4L3pc0ZoiLZYX9dzReLoED0?=
 =?us-ascii?Q?P4bClQjH1l+Kys6mNQEauyyDPzYujCPOOMsFgpHHn5sdP9ywU4eN8a70VEyv?=
 =?us-ascii?Q?e41q6mK7O2ub0jRBOkMF9mU2L3/cjW69cxuPSBXh6pY4aI6E4d63xmQnkt3y?=
 =?us-ascii?Q?Uar46713t4KmhZlT+EmtsSHDpqNTQhY4W3zHLOLuaZ4dFHkkwu+K93HDld8f?=
 =?us-ascii?Q?qE/2VbwyzxVgxn72WaSdOvKgxs+YZqnmtw3Iyph/yMug6Uy0hAX31tJZ7a5Z?=
 =?us-ascii?Q?LsKonZwCyGI7KvKR1avPOu6PlBDpwvnqIk2VLMjMbVoITrHb+ddEhhpdalgN?=
 =?us-ascii?Q?Hn9P3FIIL2csOjDGC4dnykwvWj9zhQ8+pvr+B/JS7HyBFzN6Zli3E2h/rjnb?=
 =?us-ascii?Q?Qrw+95QjTQeWpyY6k89QS/9/zD8uzqHynZwPD8CQe2LoYKxl24MNns2Ystq6?=
 =?us-ascii?Q?3spoL3y5heQCPC7ncB/YwWGun2+6sMhD1CnTZ3goNUab71EeLL7g7qPZyOoP?=
 =?us-ascii?Q?W6k/lE046gJRBDo7h0rQrQKwle+8eZfQL1G02LVPaD+O3IJmuFscz93qiNRI?=
 =?us-ascii?Q?oEEDn2MBIHfhzCZxXxqscviI+impWCDiS8iNc0oqsbKUbMRdGPEHafpXYLL4?=
 =?us-ascii?Q?vx7OhnGrgrCmeDzWTrnmhUucZSh8qx9zdWJmjN4MCTuDLoUP+DUiLu2ddZfh?=
 =?us-ascii?Q?vtCdGlonE3NyVQdmyvRTPnVv+ayN43RPKUyou27kbsB6+riFEunuVGD7ziKz?=
 =?us-ascii?Q?ISyKCYjpB4Hp5Zds3UlUTZiVodQFW7CjsglPEbXFKUdvEEfmU0DiJR7uCLVd?=
 =?us-ascii?Q?XaOXt1G3kMEFifqTcps2phIl9lUEcBXHcYgFNX7NpZt7Ho3uetMaS1SJtBLC?=
 =?us-ascii?Q?UH6byCjZ1FMRI/7jEmndR9DnNuKwWOadbcHkQV/ZQEGPmxXFf3JDiHXEpyCb?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c52a8185-4d67-4e06-5093-08dc5814edff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 21:43:29.6219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odMjy3MReCZG/bECyuGgHldzglyZnDhuA2mqeaW52algHylMUt8UvgCXqzf/dirkMsd/axrgyKX/2wBoTdmoOSQIXeeVRHRUxA6H6tiQlrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8166
X-OriginatorOrg: intel.com

Daisuke Kobayashi (Fujitsu) wrote:
[..]
> I would like to report on some additional findings.
> The process of registering cxl_rcd_groups to struct pci_driver.driver.dev_groups seems
> to not generate a file in sysfs when looking at the contents of the module_pci_driver() macro.

Oh, apologies, and thanks for taking a deeper look. The failure is
because my suggested example led you astray. I suggested this:

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..eec04f103aa8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -971,6 +971,7 @@ static struct pci_driver cxl_pci_driver = {
        .err_handler            = &cxl_error_handlers,
        .driver = {
                .probe_type     = PROBE_PREFER_ASYNCHRONOUS,
+               .dev_groups     = cxl_rcd_groups,
        },
 }; 


...the correct place to put it is here:

@@ -969,6 +969,7 @@ static struct pci_driver cxl_pci_driver = {
        .id_table               = cxl_mem_pci_tbl,
        .probe                  = cxl_pci_probe,
        .err_handler            = &cxl_error_handlers,
+       .dev_groups             = cxl_rcd_groups,
        .driver = {
                .probe_type     = PROBE_PREFER_ASYNCHRONOUS,
        },


...otherwise __pci_register_driver() will overwrite it. This is a subtle
bug given probe_type is directly initialized in .driver.

> For this feature, I think it would be best to output the values to a directory
> of /sys/bus/pci/devices/<pci-addr>/. To output to this directory, the attribute would
> need to be registered to pci_dev.dev.
> My current understanding is that the best way to do this would be to register the attribute
> with device_add_groups(&pdev->dev, cxl_rcd_groups) on probe and remove the files with

No, the dynamic sysfs registration APIs should be avoided when possible.
The above fix is what you need.


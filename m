Return-Path: <linux-pci+bounces-5903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2992A89CD96
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 23:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944B21F25316
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 21:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ED914831C;
	Mon,  8 Apr 2024 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uqvkw2Co"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743E0495CB;
	Mon,  8 Apr 2024 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611958; cv=fail; b=kzFkF3T8r6BEQiFf6uFrL04RBMAbTxwMxY7FEXR2LuALVqTITOkrgosPMNisQq6q6ax1cXl4o3g1AbQJ6Y20ayjAPh/hKKSW27dJqrmaEC+ds4dFwTagxOxdSOoThVvLRhvqxuVRYahihfgmLTzE6agdI2b4OwzvH1132TEhvSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611958; c=relaxed/simple;
	bh=Zg7YeL5Enrb48bnlmb1LykF47sNfHAmKNEnVVIYupk8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WamuMGa8Gprc8JoSOb8fDmTY5B0zFtxgVuNPsNpC2qbalqH73SwxqzEuVAPSR7D8rsN9ZJFTaVa/0TzYVWtotWjozOd8+Sdjy+zoPSWp26KgGeTr6uE9805JjBhy+U5Jo34FaDk3RPKNKWwv1wc4Ic0fOKKj/xHsv+eelxBKQNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uqvkw2Co; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712611956; x=1744147956;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Zg7YeL5Enrb48bnlmb1LykF47sNfHAmKNEnVVIYupk8=;
  b=Uqvkw2CoFz917ejefnbeirCNp+/35eRiqZQ03mDs50LXmrggf3IcKuW7
   6BfQxIlSvA1PeQqUN4FR7J1ZFhKBFFIQwJlqpM6REu9a0pOU1EClT0gOp
   L6w4NzSq++ghxcu5/FPzWuLaMQwiADT+hswHJDyif2j8lijNPrDwBXbH8
   cKD+wfz99HxolvhaIIKJwt9c5cYKigHJU6MUFvChLVL83uWB3Rl8Hlu0k
   geGlaA00VJw7eTpHLlzIWSxewm97wfAfRg3VeXBXfnfndI1T2aiCtQwnj
   ftLNBPmaNcDlDiZKeu9sDZu1CA9dZK6xsHYivwkOx9KTIWypb21ev2DDB
   g==;
X-CSE-ConnectionGUID: jZxbrFG7TnmifVNVpAKzdg==
X-CSE-MsgGUID: yPx6IhZeTkeaT50Kw+50Kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7824331"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7824331"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 14:32:36 -0700
X-CSE-ConnectionGUID: zOSKt626QombCgqqRo4B5A==
X-CSE-MsgGUID: DX4wmwLsSyeQeGVtUqy3QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="24721542"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 14:32:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 14:32:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 14:32:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 14:32:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 14:32:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLZzdPNi5LpHiNjmwGUHilz3bX6oUTmB+DMTjY4wZ68cWVQ22wxI2/TvH4YpFxJV1pL6RNk0ivBynfYVepLEemoNW43BL83s+HPwDN3azwlv+8ha/SrL+iVZO07x4sSkshY1b0cEsc+LlacvdgQQsKygg2OL5Be3ngIA0vFl5MjCH+V0WcD3S/r2Q2BXL1DcRlfM2PFPI8zJoCc2fhkL0ODHOJ81awF0ULZamW4+oMUXKR9ob4uM6hEH4uJfMpxWCpsgLw80ychmbcgaixlZN8XvjmVP6xWo4/bbqGVP6g+45UxVlhrmOMMHJo0RS8TPBJBMeU0B6UcqbK3u2NHsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH/G8JEAHxJ23IbhdYAkcyJJsBrJuP5kWm+DVm88dUQ=;
 b=gxCP+R6MxPd0X6F8LDGWaGosjtIBfGJdvpEm7CZnbaVzpVo4cs8dp0Frbln1WM8OXXuWRQFm5QHFY3ouMSYFCljDaDalJ9jmRVs3qbWI+uzV/qcm9mWnJhzhBr/esyczlUJXJJa7rrfjXsWTzMpPX+kHi5RBPH5vjB3f4qrEglD80sCvC43aT93BZhgIlxluNQ+Tax3ehFUYH4Tacg7VT6wysCS+H97rp2M2DYjbEHxSaA4z+iYWb1VHMA+OcDSZ5yjwbUC6elo7WoTpE5e8cRqxLaJSdV7SCGiCW4z3NJSA+rHNFd0bPO6+3z/AaQxrvwKwXJZ/Xkz2Huk7KpCpoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7052.namprd11.prod.outlook.com (2603:10b6:510:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 8 Apr
 2024 21:32:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Mon, 8 Apr 2024
 21:32:33 +0000
Date: Mon, 8 Apr 2024 14:32:30 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>, "'Dan
 Williams'" <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>
Subject: RE: [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link status
Message-ID: <6614626ec2274_2583ad29447@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-2-kobayashi.da-06@fujitsu.com>
 <6603275faabc_4a98a29470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <OSAPR01MB7182912D196E74F55BE1A55FBA3B2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
 <OSAPR01MB7182D299E092B96C43B7FBAEBA3D2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OSAPR01MB7182D299E092B96C43B7FBAEBA3D2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MW4PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:303:b6::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7052:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpQ5Ewh3UiT9qv0zDY9OqAzt2GMl5kIKq+4SOWPx4elnacLjUM0uDV81Yy+mKTSArUi9N4CUeyvhz4zjEWMBN/T82rYe7mvWzql4NbasmhF4kMcUWQNuxgWoryCBVkTSbeag0QXismCmf353k2qoyhCjcJtz+P2t8e8NCurf8FCuZGb5PD17BggKv4p53mHy5qgzHyKAQLYndYOYH9zfJVkIeVxTxHULnXkydMSjuIengo7verREV0j1Iexbp7qCywogvN3FtzK3npyJoTr6k5PBpvDx98WBKocTr2OpVvcXk62TeZ+j7dsopsl8GgfLJx+VFZBbLK8BGPu+91XgbrRx79ZrX/TKH5x8nHZJNuyhLTt8JUxnYlCSpQ/VPkFhCY7PyggVkrL7j2/mF7EmeIDSpb0F7K/ZjktUaDAdTr0ynq0tV2msLn212A2RmvkRKB+C+gAOf8npoToYv6B7I4JFmVArdZKUzZpnswriGDkYh461oidX559ZJPFmRtWBNZVg8E4DHqPgCk1+oK4gv5cncinOcvKDprgljkc/er+0eio1cJt5hudmAo6VuUuqtjVilWIAEbHAfZozBU7GQJJrWutsOdAGb58WzSXuW0GbfcIFyqDie1xkdWiiMsiAljiix37yx7VyxlTEvz5SfsOhya4A5kFNwyHU5zGwFmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xilbtgujZaGpyHU08cF4qd//0fVkYLoSNhZUMR8lm+H/h+f9e2zhqGg3tOdY?=
 =?us-ascii?Q?Spnnh4i2s9TaDHMvowCov/lgFOxFnFSMZRUojn+/xjbCWactS137sXUsfmZh?=
 =?us-ascii?Q?Z7I+qQGH3W+cfLtTNUzBQmmuDFRzRlYj6ac0CHqGs3YWS7uqXPwReKmXTdHB?=
 =?us-ascii?Q?fBh3Ol41DRJ88PQKBXX8axXzzwKtPNN5aVqAXYnX6laBRy8GOpgdR3pictPg?=
 =?us-ascii?Q?TKvAPmbj/yLzIm5TbTgARmqr8yfU8hrsSCkks/ACaG7/O0+QvT/zYLxLF671?=
 =?us-ascii?Q?ff0dbic1yHRZtx8Cja7M4tWIpqU766mWJP5OiXlZClmFhTaOJmCEB2D8Gb1W?=
 =?us-ascii?Q?5rXgmpNwFjf75zcejkQkgRrvpHDsyq3RYDJag/XurqayKBwnnxUniLKpVUi1?=
 =?us-ascii?Q?WrIucouhws4gEo1FMExhcZtobozJj7fssJ8qeO5Shb/jwWTfqmPS6y36bnp0?=
 =?us-ascii?Q?bl+KeLXzqX09322+D+TnOPDxOWn6FtoqiLMEBgDKa1fDE1DccXoUxUBzrSlh?=
 =?us-ascii?Q?zTNnGRJXjDEtcNeHWhw82cQ694jJwfs47S+AM8Ygk2foYUUuI4L4sU+18lUq?=
 =?us-ascii?Q?jrHfu0DeGy6Gq3HOzoTWeHG7BlolGOAJ1lPt0dyE8EL+94Xhu31c0TrLv7hs?=
 =?us-ascii?Q?F12IWb2/cNf8ITWGWt+p+USv3TzWi3t1gEc4Vsmp0TVmCS9Rhzy73GV9EfxK?=
 =?us-ascii?Q?ccCudDKiaY7btnxCAx2/nIjjxKQzxNm7QolEDoaewYO/lQU5FUD4H7QMjZq9?=
 =?us-ascii?Q?d2fHoAXSbDj6uSeW/H4+zWlZhiRvWhG5ygCDdZwWHQsdB8+HpEoujR1RfOyp?=
 =?us-ascii?Q?Eem2nI3U5559X5sCT8E96A9E6PNyK9BtEpdAppDH29ASXgKPEmXmWnWCtS6T?=
 =?us-ascii?Q?r62tQQu/4fooNdZogSTk+I+3+oLXQpqLZsnZMYSvvqgzbsTYmXlGvVX+JMCB?=
 =?us-ascii?Q?LOwBt8sPjowm4iv8PE9j3XCzeDQY27Pu1yZVKJWSEwTQ+ggIIIS/B/TFMitq?=
 =?us-ascii?Q?Mk3jxLLbfEKoZA7uVnM8dPZaZefXwKh1ss9VmVWxEjlBx7wk13BQBd/Arikq?=
 =?us-ascii?Q?PZJ6ZP8YSR5/V4qG524OV3/h4KO4Taqox63LsM40ZeV3r1RwLOC8/Ll8YMKg?=
 =?us-ascii?Q?kIU6UvyqLFyizN7vJVlvj0bBDGLB9GBr2WIYk6EEH8P6XmOf7c0Tr3l0SZNI?=
 =?us-ascii?Q?/JqbFT+4T132CWo39uMDggOr5OCqExCzt41/Om+G1Fz5O9Ljx4oUkQyjzAPp?=
 =?us-ascii?Q?0hF9gfA3FbWWNJ5xJw2P8bYi1JaZjNg8PYH8RLyHm/w7IOd3pIvzEqNT8YIa?=
 =?us-ascii?Q?q/XwmKpxqCGpk1RljY9+RplY8X/VBCGfN9uQXkIW+3Vn5DbZPo67X4i4KRaI?=
 =?us-ascii?Q?p/Wx0rWGYMGczpya1AEYULewM79bz11XCrK5aHDx2UqCqpgaVeSv16H5tge7?=
 =?us-ascii?Q?NpZ1RAyGUzK50xZbeMrmZYnDG9jY2In2PvgaFA+Mtf70Fqa9bzksXA+ySVXn?=
 =?us-ascii?Q?4MzwxqxQF5ajC5ouX5AWs0TCGMypuSb2cMlADUM7o22d0Z4jPTaaWCk+0sxA?=
 =?us-ascii?Q?oZNM5rvAK/oFdxxJMP+rSZ8wqOmif6PFVez1PKtJyA811fLAh5VpioB5+qyI?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf251a2-d94b-4b6b-b378-08dc58136697
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 21:32:33.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRCFmTWNbd3gVCy+ED77YW5h86BEDbeLMUPVmKCuXJH0wkLzr2kn+Mu5g3AIfIx1dKu/1k78wd/8MeZ+kEtdB3DBotthhtVndzk2ztJsamQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7052
X-OriginatorOrg: intel.com

Daisuke Kobayashi (Fujitsu) wrote:
[..]
> > Thank you for pointing it out. Remove these calls.
> > 
> If you are aware of the cause, I would appreciate your insight. 
> In my environment, when I removed this device_create_file(), 
> the file was not generated in sysfs. Therefore, I have not been 
> able to remove this manual procedure at the moment. Is there a 
> possibility that simply registering with 
> struct pci_driver.driver.groups will not generate a sysfs file?

Be careful, are you assigning cxl_rcd_groups to
"pci_driver.driver.groups", or "pci_driver.driver.dev_groups"?
"dev_groups" adds them to the PCI device object, "groups" adds them to
the *driver* object (/sys/bus/pci/drivers/cxl_pci/$files).


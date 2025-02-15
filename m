Return-Path: <linux-pci+bounces-21536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23893A369ED
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 01:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4457F3B1DA5
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 00:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4832837B;
	Sat, 15 Feb 2025 00:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eY0stf0/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13523BB;
	Sat, 15 Feb 2025 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578869; cv=fail; b=FKTdRSMC7cyymzcRuNkxjTk+jJZrJdzxo7qE4dmYjpKBKHO3VI4Af24Ti5dqf8FmQk2RuTSCzoBzdK+x3Qh99T0N6pMo5h6BEXULl5ta4xlZFhknIu2lfXyWmM5lKxmKarAUlGFGc9+rauFKmvFjHIU+/vGTYRdUGRta7aK8MwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578869; c=relaxed/simple;
	bh=1Tft0BlxsM8To8Yyjcw2h1Nt2RCVbzcuB3mm9Mee3rE=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y0d0B8xoPA7eTPOE/vxnN/I6Oj7qFJkyac0n+OnqRlr/yMTIbfaU+uL+3n1rtKL7lUSXpOG2Y4DmkP4NqwStQMo8qvcg8HZjQANDeLXRCem1P8cDXoWT2tAPWxZxPmn7UypZo2VYcO7zPfwluGx4Ruxc3Tq4dwNyKXnESbL2ASc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eY0stf0/; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739578866; x=1771114866;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=1Tft0BlxsM8To8Yyjcw2h1Nt2RCVbzcuB3mm9Mee3rE=;
  b=eY0stf0/2Zt7rCR89SFmgNvITizINkf/+WKNRa5xS/40yx3bCSfGjavG
   9Y6duL/uK662EZ+WjTgbZ2NnmFy8TZakAPhvRzNfruDPOd/dzj0Rejs7e
   wRDzY7g4/d2+6oWLZBclrYwTcfLJxCu+1gqiP0pG/Fgk9A7chw6Phrfeb
   3SA7fhejYae0Pq+0CjX9aAZTGTsqGlGLkR88mUN2dw9TtP86hGXKTXEoS
   7CebErAefsyYQ/p+42VWLxe+I6fkr5YHzsf1/C7fc5Iug6xwPy3pZH/wE
   jFjOTWQBCcb/ZGS8MDVz/ZBZiQYHYygZ09sBkpIEo++bsXZEpXmd5+gCd
   w==;
X-CSE-ConnectionGUID: T2wXlMwoSC+dPT7IUJ/RDg==
X-CSE-MsgGUID: sHBBdo2TRp64P65BAVvJvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="43173548"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="43173548"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 16:21:04 -0800
X-CSE-ConnectionGUID: hMy9+P3aSY66n7mz/i2caw==
X-CSE-MsgGUID: K/0OzuTTRPihHGqpRUDJxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="114223036"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 16:21:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 16:21:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 16:21:03 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 16:21:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTp8gh9WkNuR5olmgF5sAvS47ixVuckI+5kiLKWZrbmjnp2NIXZ8VWK703Z+Eh+uslxs2vCvdvket2+x9pTd9Q9i+kW0Y93tlGTFbqqCAaG5bdr7IQZp0USrhnM9NjyvpqGZFSa6rHGZFOSjzf7NoD2Sjd86XJghfE6F/7CT99f/YeWgkFDZfmyPR8NmUpA3x0kEbPL2GVsYQDvxP/Xj5VEzhhVpqTBYUH2SbEr/JfvylMSb+fGz7A0aIw+rIhwdJaU5I89KRQlWbeAcqI8wZ3SJYJJ/61xfEqf57/jUG37sIxL74PyOaQZe95889P0lDioJMjgMrhmswTlKZSZzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMDAHYeksrUclYqpiGaU5UnNeKYBj5HwH57CSy6RxyA=;
 b=Ii5/+0Xv0wdp2fo8WuN0+D+wPpaJydolm1W/wAnQnFtL6LwMBZAunhXa05haPW5YpR74CCOrVoI+SE4f5pTba5l/wybHP+6tFQNoyg4UrS5Rp91dZV3JcH6rJtM6P8EyU8L95XFXwF4kRTBlu9iS+Mkn4r5bA1aoiLHFOUMKpFVioxd3Kd4xMYbge4UZfrJ6pNoTU32njBUi+ipYScu8G8+jRyoAY2py6jUBT/BzZyA1LyPscNGQY8i8x+aMs33MM9WpcejFCox70FEPVZMYnfuU9a8bnC8Nkp7fpZ7X0X+gIetvjvw0jTWsFH8Y8guZeHbIRqDIDEf5ek81SUGfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5117.namprd11.prod.outlook.com (2603:10b6:a03:2d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Sat, 15 Feb
 2025 00:20:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.017; Sat, 15 Feb 2025
 00:20:18 +0000
Date: Fri, 14 Feb 2025 16:20:14 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 12/17] cxl/pci: Add error handler for CXL PCIe Port
 RAS errors
Message-ID: <67afddbec62a8_2d2c294a4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-13-terry.bowman@amd.com>
 <67aea8002a005_2d1e29466@dwillia2-xfh.jf.intel.com.notmuch>
 <408f6acb-108b-4225-81ac-4f17a6486020@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <408f6acb-108b-4225-81ac-4f17a6486020@amd.com>
X-ClientProxiedBy: MW4PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:303:b7::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5117:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d88a2f-5d78-4400-a7ba-08dd4d5686b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bGjWZqf7ze+4jVT9OntNu+mzxNRRQgHksMP0WvFCGE7KaE7MQBq8KD6TX++a?=
 =?us-ascii?Q?rDdy4CTECA6Yv4Ehw0DSyQvMUOdoTLXf+5JyOVHyXphgJKNXlUAIi3MTlcKj?=
 =?us-ascii?Q?VEMkdSZ6rV/g6JXge8ah1duceCSSFdrLo5hYNJlkcbKBtc8rdtAbSN9tRhIC?=
 =?us-ascii?Q?PsEEf94OwzNMNJEF4bN4hM/YXS/KlczswOIv0HI8TyDM0QjBY+s+QvhzS+pr?=
 =?us-ascii?Q?Ec/uOV1prsGc+iFNs4+w81LkCxKuYTK5y4bEMeZ+RYANgKSPemCyqElgftxT?=
 =?us-ascii?Q?PyxLdOoPUFO9WXdPDCiOjaCYISzkYU6+cdHm3c8al68ZEWjkDZocqubqiGRE?=
 =?us-ascii?Q?2hOTUR6f1tf0RKsUfkh2gTJKVGN/gXS531LK56m0qIfX0r8W+IVAwG/SRjGg?=
 =?us-ascii?Q?Hc90zsmu+5dop03GdmADnb7rGf7g9w5d48fUjTpEh9j8fMM1CzQPkYjfO+UU?=
 =?us-ascii?Q?MArjfzVuBTKyvi4JxRNl3h6K0C1OBZSgH8KrbzZ/IXNre+Fu5zLvlQDyMMZz?=
 =?us-ascii?Q?BGkURcE/NZU4kevIj1+J5KcCIydQKKZUMO1A+/Cz6ufn2EjYr/pCBebGOJ/L?=
 =?us-ascii?Q?CAfQwc/qcT+97RkoIDkRR+GEK6k++ZVeRwqR19qHSKTroEooTAL96rdUIEFB?=
 =?us-ascii?Q?+86VvDht4icegn0MMKczKsuEW8+mlXMVkbJyStafq1UyaTcXdqESILPi4AwI?=
 =?us-ascii?Q?AkjQyYEVF+QjJ40L9uHF1m4IIIlaH92Jx2l1XBM+tfJO13qV6Kl0MUE5e5Lu?=
 =?us-ascii?Q?2xlcSx9OWR6X64c2fveKlSdDzNmdtGOZbdFnDM1u1Qp34Ob+ou7PA2qJBudP?=
 =?us-ascii?Q?4PvX6UQGxSANyeqAMSQx5Hn+ICkDhh7v2M/5Q0twAma1sw90uLcdkLyWoLeV?=
 =?us-ascii?Q?LMNJWjLF/rGddTIE2QLSWGO3R1P5orMzAT+uSkdDWT37hRtYiuHM7jW3B5E2?=
 =?us-ascii?Q?Ma26oiyHV58zN6fqN1IRs9wx6gHMsbI9U5OIv6IMeMaYEikMaYxOMkgaIlDp?=
 =?us-ascii?Q?AlS/9L1ow/4KXeZhS9jzqi3DLOj3wEJ89weFCHfX4FUfWNoSpBNv+8jS+8wG?=
 =?us-ascii?Q?GRz5awtckjt7GZ4zarPNXNgdm/Ha/3H0ZQelk+oSC+X/knZ2g/Zh5AbVmqXn?=
 =?us-ascii?Q?RrEMkpCx9RMb0+ROAFuHcTT9emIjh2ALw/1c924Zzh35QWHz1QAfJN0IAxFr?=
 =?us-ascii?Q?MfY9BOH3UXwPeSdjqhrnzqR7+i76S2mdYR+5sKzZFjSiReNoD3z4hJdqwnIB?=
 =?us-ascii?Q?XwlcTdY6vYpyAaLNtlXmm4XYOmBe1x8/z5QrHojhfamrK3Zsw1TAjInw+9io?=
 =?us-ascii?Q?JTtCoNiVRXiAlyCcrzURfrJEENt5a+Ejz4oNGJg7Jt96u+OxIDt19kiKOztm?=
 =?us-ascii?Q?/NBMcnZYBuQnPIrxRaMEu7kiFRNsJbzZvFMLMmzqZkznC6pFc9jUn//LOl9b?=
 =?us-ascii?Q?kAubnYLHTOo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nv2XPT1VuMXKoI1F0Ivq5fSvw8tAFCb7X4ys9hOZoKPBsTrSnP2erMrITguH?=
 =?us-ascii?Q?GFdQnV4sLWxr0ctT/6hkOCR5+uVTYwTFrAa99iDn/hVrVC043yKN5Q9+H7kB?=
 =?us-ascii?Q?BLSH7o4tVBhIRImHl9rW2BWyfAlTNhY/yiDPtnprUIUaycK96WQdJr+nFtE9?=
 =?us-ascii?Q?TTIcWUBtFpmHhOvtC6LEG9UVnatbMHltME6kg2V6lnOz8A5v1xvYNv/D41tS?=
 =?us-ascii?Q?/czpafjjMQmwt+klVMIufAX1XkirIq7bvTvu05so2lT6zVAZemvI3dHAHjiq?=
 =?us-ascii?Q?v5jeMTEQjW/x9KO7L9BWCUXHcRAw58E4oAV46Q7NpJxD/dGSAsJYgQvW3koF?=
 =?us-ascii?Q?87HabpPIVEb2gDQf30H92xXPqFrdzA7GeKZpQjItGQsxbdH/hr0Epkwac2yL?=
 =?us-ascii?Q?yEZ18coE3ew3Pf8Spl00pXnU/C/Z49Zq6yQW9IMl9t9kgJlleSsOqtUZbB6B?=
 =?us-ascii?Q?6YPPsthWpvX/Y9P5jv/iX1GliyZX6TfO+L3+3RVQj2DfdjXQo7yzcpVXwDDn?=
 =?us-ascii?Q?pyR4kwVAxd+VoGV0AnC5VIYkb5OTtHpJMhfRbRsPqSoPqWuv5y0Pc7MioxT7?=
 =?us-ascii?Q?G7zGVzYufEPLN6rQRGsXhyw2/flUMXYAP2oHwZHbvj1EsP3F2spm/Ar4/Udr?=
 =?us-ascii?Q?qizn9dXKZ0sfocr4IE4lYrKIva2lZki8NzIHgaBQ1GMfhOeidTidLzEo9sqy?=
 =?us-ascii?Q?Q6Ur6rpMJMCtgKWKnKtDlHv+CLjFvwiI6gfi0SYkix/wrVSjO9Zkt0CMXcRD?=
 =?us-ascii?Q?Irx7T6lz7tLp8ddGowvRqxH9edctH/nkm+M/CcP179zaOfZAAZM3vjzsuZVA?=
 =?us-ascii?Q?aYPlZxicnr2QYH1cfKYXW789+jgqkBNmUJsxnfaQAZ3MoUV2ouIejcse4hkt?=
 =?us-ascii?Q?nSUVkYhc8lS3vhqLOWylscQQEFvZfguRlVq3EuNrh9KFc7Jn9zGyBN3rqKHW?=
 =?us-ascii?Q?C2bHdJhevOEDRqfdocgyISgx+yZQMY/lO8cvuThxDrhlcm7wRCfKx/G+hzVP?=
 =?us-ascii?Q?cDPby1Zv7jfpNqQNb31a8Ht4PO/7uEDj++wOQ2xNSmpwOSBxWBPa5sQ7LbDO?=
 =?us-ascii?Q?cKPre0da5e/FxjKLrVVZkNIn99CKLV14xSfbJbp4e8/Ah/mRXaIxxeFBIPos?=
 =?us-ascii?Q?cSj48dAt4dpvafhrSoSy7F/+nsS1Fnx2AKKLsuDZS+UI7prFkI/GzM+k/Ruj?=
 =?us-ascii?Q?JJcAAlq+3Uu1Tl0mECF2jrcycE9QLFf1gLGBcZhEcBSv2IYBZ6kpEZ05+IVN?=
 =?us-ascii?Q?hOId2z5gZ+PveTL+OzbWO1yIYNTcnUw+Y0bmpF9jQYONZn/n69yfCy4kwVOZ?=
 =?us-ascii?Q?K2yXA3X+r1UzAtKoHUnG2tzLeqA3ruB3W1/TldP7qnHq5AatCnNDKSvsLNz4?=
 =?us-ascii?Q?oae5/YzZnvM3R6YBr4aBQzYTtvic6nYPaeJUieG+05UEt7kEVJRJ6qLy1wSh?=
 =?us-ascii?Q?5LxKGLEyBQDOFusaMsmKhsQ5bPR/ACdmKBFoqVhkuH3q3ImVyAEJ+wwzTVe4?=
 =?us-ascii?Q?BW4LQQPntL/JONl6viFcUkA7X6AWVKiS6VDZ6tyRMTkZlOFr1qB+1qBEUWVb?=
 =?us-ascii?Q?5ezcFVSqy1nM6d+MwO1mGnCqbzBXmy8tGSRwpZmprSqzjgKK1RbFn+m2orHn?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d88a2f-5d78-4400-a7ba-08dd4d5686b4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2025 00:20:18.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdXBBwxXbMHs9fJoGNM3KCLM3/dPPzdzka0sRQkGLMJh4zlh/1t8lmXkZuWWZshiMaEaWIFctkn9pieADFSq1ioIGyqf4EgoKhpW7i9BdUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5117
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
[..]
> > Ok, so here is where the trouble I was alluding to earlier begins. At
> > this point we leave this scope which means @port will have its reference
> > dropped and may be freed by the time the caller tries to use it.
> >
> > Additionally, @ras_base is only valid while @port->dev.driver is set. In
> > this set, cxl_do_recovery() is only holding the device lock of @pdev
> > which means nothing synchronizes against @ras_base pointing to garbage
> > because a cxl_port was unbound / unplugged / disabled while error
> > recovery was running.
> >
> > Both of those problems go away if upon entry to ->error_detected() it
> > can already be assumed that the context holds both a 'struct cxl_port'
> > object reference, and the device_lock() for that object.
> 
> I think the question is will there be much gained by taking the lock
> earlier? The difference between the current implementation and the
> proposed would be when the reference (or lock) is taken: cxl_report_error()
> or cxl_port_error_detected()/cxl_port_cor_error_detected(). It's only a
> few function calls difference but the biggest difference is in the CXL
> topology search without reference or lock protection (you point at here).

My point is that this series is holding the *wrong* device_lock():

I.e.:

> +static int cxl_report_error_detected(struct pci_dev *dev, void *data)
> +{
> +       const struct cxl_error_handlers *cxl_err_handler;
> +       pci_ers_result_t vote, *result = data;
> +       struct pci_driver *pdrv;
> +
> +       device_lock(&dev->dev);

This lock against the PCI device does nothing to protect against unbind events for the cxl_port
object...

> +       pdrv = dev->driver; 
> +       if (!pdrv || !pdrv->cxl_err_handler ||
> +           !pdrv->cxl_err_handler->error_detected) 
> +               goto out;
> +
> +       cxl_err_handler = pdrv->cxl_err_handler;
> +       vote = cxl_err_handler->error_detected(dev);

...subsequently any usage of @ras_base in this ->error_detected() is
racy.

> +       *result = merge_result(*result, vote); 
> +out:
> +       device_unlock(&dev->dev); 

[..]
> Which directory do you see the CXL error handling and support landing
> in: pci/pcie/ or cxl/core/ or elsewhere ?

In cxl/core/, that's the only place that understands CXL port topology
and the lifetime rules for dport RAS register mappings.

> Should we consider submitting this patchset first and then adding the CXL
> kfifo changes you mention? It sounds like we need this for FW-first and
> could be reused to solve the OS-first issue (time without a lock).

The problem is that the PCI core is always built-in and the CXL core is
modular. Without a kfifo() and a registration scheme the CXL core could
not remain modular.

> Or, if you like I can start to add the CXL kfifo changes now.

I feel like there's enough examples of kfifo in error handling to make
this not too burdensome, but let me know if you disagree. Otherwise,
would need to spend the time to figure out how to keep the test
environment functioning (cxl-test depends on modular core builds).


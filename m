Return-Path: <linux-pci+bounces-5028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAA08875FF
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 01:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53523281C25
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 00:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C51437C;
	Sat, 23 Mar 2024 00:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7RJa3zi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1D97F;
	Sat, 23 Mar 2024 00:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711153065; cv=fail; b=l6N679660/yPs/NK/tmgebF7a6v9D3F67a7FqP33bJvIL3ozfYhLXrD1aiA6TdtwqI1ZVx2m6NSHGOfcPmWo676uFCqOhS6nOvpvPyofnMWGR8iWuYkg8jQGO+Ds5ul2NVLY4yM+eXc7mhleJ3s41WeUJIdxpHJwj8l19moiwuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711153065; c=relaxed/simple;
	bh=ZtKBLB8eDt+56ui+BCwpdNRuGUSDSpmBGV7gu0tr00I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V1z52il2ky/qq/K6Wi5AATTH6KR+GuHXaB0I0LFjs7m3pB+tyNjQKI0w6vh3DHZoJTxqT9EDVVTkYA8Bn7hp3nZlo9L/jkXmFxtVMsuJo2vC3oJi0rln95u7t/1BL2QCPfu/GvP7rj2kpkx80VhX4PC9hh/JzXNBaO3t3C26Lt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7RJa3zi; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711153063; x=1742689063;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZtKBLB8eDt+56ui+BCwpdNRuGUSDSpmBGV7gu0tr00I=;
  b=i7RJa3ziKO0kZkWoPUKg/UT9KK6ihSVQ4B8tqX+NaZGQDhDqC8VoDCYV
   NfRCkPj5z6hbFZ+CCNdnos3TAW5AS8qFWTkumVB5+uv6Clp61cVARJptD
   dEtdd6eNPwoVVNe00iXqQKx5ar+lFmDNLniQtgjclqClzeml55bSlfGR3
   Hkw30dQoqBGpW4AexNVrI9WRIX9TRlEZ63dbFGVTo3dvPhUjLnRqnEuwS
   2/n2SXgYd4yID3/oaVma2tycbWenbnw0QY3r3P/cY3/Jluf7lgD+9+P8x
   ZbwpvMkzuHDholewkqIdn4rpmCRqSqNgZ2BoxLvarnb5vgRWRSBb1hXa9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="23711927"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="23711927"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 17:17:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="14979845"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 17:17:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 17:17:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 17:17:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 17:17:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j33H9dQlOjAS0QcFSdwhNg553lGt+pKTgXtaIzIb1z92wBgt8YVg9RRWNtHvNJDcnFPXH/NTGn87K0Z488EHRx1qaWSKZQ2pjtjngcy1WwJmENyfP+xfPPovKBGIlQG9ktWycrjWWGy1oIzRJ/ASXiWaSFpjtC9XKNIaLuGZhtvR2fjAFPvP3OSpTKmX9+ON0rh0rJLhnWbo8tWGgRO3YED6/CJYOtr7HnS2r6W/5bPAMlFWQUdY1eN+Opa+ccmYTl6PlstbyBrZHq4FR2JCAn1NHS0SSbu3hmpcPu06Zc7QotZce715oGAuefPlXE3dqfaQ9dmUPT6HX3K51r7ajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mz1vWrpD4d194oHM88iKgenwnNhcpFXCvnaMHbRYmK0=;
 b=DY1sRC9DiTGaApnno6W3HFbQ/3JaZRDbgsT+QhlI0Ch+uMiB/Q6J4yXFxpL/Ryq1TrEMDnmyyt93vbFswTLLKXQe2iaQYmAMQJCBtPNM4AQk6JIfNp8SL6T/KJNHYpuNtCnmF5vUtYJrvU+ku99pEApYdeWBnamQpnJYfiHAZt9c3ojA3Zvern2AynEIseVwkWyVLBf78UQ3prL90+/iuN654nfD/l5Q7lZdsGXtKdVn+WqnAr6LBVmWiUOiLARjWLSdHic3ICTjY6qgUdOBFXiHoAr5S+y8czYSBv05vG/VthyFc9i3A9zkuoEOkQzluunRtdsnImEmSDU1BjOV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Sat, 23 Mar
 2024 00:17:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.023; Sat, 23 Mar 2024
 00:17:33 +0000
Date: Fri, 22 Mar 2024 17:17:30 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, Ilpo =?iso-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, "Wunner, Lukas" <lukas.wunner@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH] cleanup: Add usage and style documentation
Message-ID: <65fe1f9aadf51_2690d2948f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
 <BN9PR11MB52764D455B465E7C69F3A4C38C312@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764D455B465E7C69F3A4C38C312@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: bd26b5bc-b00d-48ec-7b9c-08dc4acea2ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kkJPu+aPTg9sSzNiXXw99/wMNfnLUyCBa4ZKdhBCZzZueeejeWuNHSvXwq+b1WBt+rYoD1eYAG60bILSznYV5UNwXKgS3pKWcgxPf/FqtQHiIXM1JfkQTlPH32Zep2/8MWJ/fztol8zK6eM4H8eltgoJLl9X7aeHTyEV6U3m83R/0DQ0u5Zy9iZFB9VHalaU7RJLU7uKGc4b2yblooax4M5nJ0ehP3tyI+PXGmvOQH1JCmtNYEwKJ/IBDzSeZIBembQ2qV/bRjQmWFq1dmGvsMbjqU42AUqf1Dm9fC78LyY8pTKeaoLfrtUiikT/9r6UCtjMbQGNY5Bzvivi75hR3NYH8iAJNwi2fMGREvbK7/6tuGavILIeMlpdMlwt+0xM/w4JolpwvGt7syDkDu2SIvDFqbuzo1tWEkymw4XxvCKwYa5EH/S60tRjSjPFcl8PwLAQzh1lK9/MCDe+GTCUixP0mSoBI1izzhK+Y4u0t/6ibu9MITD5SrnTUJjNCIP7EQQg1zL/U13PbN5quwUOyUDcUbwfvbzgPKT89oYn0pw9ZjEoO1wDEg1pWeBsaiEAMFUHQqAWVx3XmLcN++SnllgYbkrzfhV55uWjidRembbhYuagfSig+t66S3FaSDmqGxnGJPZf7s1wg8UTFN3KlnJIr2DpVVlBVEsUfLOsNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d1hyCasr4EK7bzOhmW4yHiNseQqqhtt21cuq9nEY5P1SdyyuMX/kZU9Csuci?=
 =?us-ascii?Q?QNsUo86EzEMvkIPYW+4/zOykrgHhTbCcknCjd0wniZ8FT98vhS6afsft+B0d?=
 =?us-ascii?Q?PyIlUA/kUJFDsu3G80ftV/JTa/dbxvl17u9tHSPKGy+seaeKvyUt5xdHLf6E?=
 =?us-ascii?Q?B8Dp3nJgXmCu5R/nmxJfRVDQhhMr+TywrK3wpjerWzMlh6bVpkXxpPeVV/NJ?=
 =?us-ascii?Q?/QQcxvHKpwnEMmGSZZvxgjVCu0K5OosfZxY5ACAvtJIwFYbn1+6jFSW7a7dk?=
 =?us-ascii?Q?2/3cyDqlbPj+zvQ1i9mvnfJoGBsVwDCWBRoTGFeBgXUWID6C8y7GrYpuSssM?=
 =?us-ascii?Q?/azQ9lo7ielaarlUL8EEPT4PkKY56Eh27HlFEeUlhYDZeMoFx+101QNBWkHh?=
 =?us-ascii?Q?cuhdTlOd0fBpwrZY09f79qoIkURKAenahOK4+5FDcmK8K9fF3raLNzMQ8imZ?=
 =?us-ascii?Q?49Yf+9PE3Id3K7Yb6y1RbT6qVI4x25CGKbOaI/bTfR5blkjQGL4rJF59o3U4?=
 =?us-ascii?Q?/GX2WraKfn+lASP8UXhiwtbunPme36jdeKZF8jThKLqpOCkQroFzTizMMzTN?=
 =?us-ascii?Q?I88fqvvo+bqDmu3fnXJL6KQJ6kbqMOjI4uHxyUo/dZ4zIo5Wu6KR4S83JBZM?=
 =?us-ascii?Q?teTXrNygrDSx0k59+ULeIzF1/Y8/UTM2zZBHy8M+E6+f5c3pGa/y8sFT2vMz?=
 =?us-ascii?Q?dU1rr+xyNRFlg6aAPdu4jILsx5iE8Rhd8DSzxHYW7VqiiELTrlNkhdIaLhRx?=
 =?us-ascii?Q?qAe9iYUSo1Fqi7NnOdRBjf5gRQ2U5is9ia7eQfg6N+8CaodXwmCL1ggWiFwh?=
 =?us-ascii?Q?uyqopswZ+8KlIvd+nxzQL/i2RfoEbWJk0nmIY4Den+oIGZOcjAJk03oGT9g7?=
 =?us-ascii?Q?/kjCm4671MdqIHsM+gDihpWLQKZjcH4fLLjSyKD9YOqngDVJIyRu+LxEetJs?=
 =?us-ascii?Q?mbBjt+WW86AHeQ6Lq951fZFSmcr1CZSyzpVdQJ9lmDXlIWg5DeiUb6MDvY5g?=
 =?us-ascii?Q?iIUY4x5yFzyAWf9jf1QvFI7NLSCCKh1vE1yazHYSxFMV31/Jo3qAPt6cfhSk?=
 =?us-ascii?Q?cii4q9oDrPEV03Vy1hF8W0nPNBzsaFG4lck+jQnFoiKL9LoTPgzdwTnv24uh?=
 =?us-ascii?Q?WvHYKPddanSEpzDA9UaV6n8LtMzSVjajI2PGz9rhd9foIkAa08QRkuYre/oE?=
 =?us-ascii?Q?SMTwVf2cRI7cImoHGrtbuc94IYo9hNL7G9K69T/P29ZDWiIYM8kIEeF9ZLjt?=
 =?us-ascii?Q?IyLsZSLO7fKV2hiDMb0a/Hv+AxkIMXp+sEAqQO3TVGvqRTe6b5BAdor6iz/F?=
 =?us-ascii?Q?n7eTUKtXiGRio+IIhgGUuBzFknMlBr0CFMMzgEa6zvUNcnf4BUzNmAmkT+Vp?=
 =?us-ascii?Q?93VV54ATgy8+e67cB5GIqIpzsko+KDD43/4eqGsYCEaemniyjqpHwN4UjlZR?=
 =?us-ascii?Q?4kfKD7nJkEBqwoLDChDl4j9RA73vbJEQFjxBgd+MbsMNBGCvVT3JRuJI/aBs?=
 =?us-ascii?Q?g5ezdO6eQYF12LmzL4eXta6/razr1KagE4anl230Evsav9dDgMiS7IH+kXTI?=
 =?us-ascii?Q?vhEmWZxYQc5ItQ9LUXfDV/Q96sjsIOoF1FXzRQ+7HC1Xika2N6ELzA6/U5Ok?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd26b5bc-b00d-48ec-7b9c-08dc4acea2ac
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2024 00:17:33.4774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /q8ltKH0m/4ReaGxOUZJcvt3T2or3nvpweWH0fr5N2I70NKnefb5FHA7y5bY02sQhBqDSJQ3k0PvFwVBw8eCOuaIMf+mnrAgeEoiqMO0WA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6318
X-OriginatorOrg: intel.com

Tian, Kevin wrote:
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Thursday, March 21, 2024 6:05 AM
> > + *
> > + * Note that unwind order is dictated by declaration order. That
> > + * contraindicates a pattern like the following:
> > + *
> > + * .. code-block:: c
> > + *
> > + *	int num, ret = 0;
> > + *	struct pci_dev *bridge = ctrl->pcie->port;
> > + *	struct pci_bus *parent = bridge->subordinate;
> > + *	struct pci_dev *dev __free(pci_dev_put) = NULL;
> > + *
> > + *	pci_lock_rescan_remove();
> > + *
> > + *	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
> > + *
> > + * In this case @dev is declared in x-mas tree style in a preamble
> > + * declaration block. That is problematic because it destroys the
> > + * compiler's ability to infer proper unwind order. If other cleanup
> > + * helpers appeared in such a function that depended on @dev being live
> > + * to complete their unwind then using the "struct obj_type *obj
> > + * __free(...) = NULL" style is an anti-pattern that potentially causes
> > + * a use-after-free bug. Instead, the expectation is this conversion:
> > + *
> 
> an example of dependent cleanup helpers might be helpful to
> better understand this expectation?

The simplest example I can think of to show the danger of the
"__free(...) = NULL" causing cleanup inter-dependency problems is the
following:

---
LIST_HEAD(list);
DEFINE_MUTEX(lock);

struct object {
        struct list_head node;
};

static struct object *alloc_add(void)
{
        struct object *obj;

        lockdep_assert_held(&lock);
        obj = kfree(sizeof(*obj), GFP_KERNEL);
        if (obj) {
                LIST_HEAD_INIT(&obj->node);
		list_add(obj->node, &list):
	}
        return obj;
}

static void remove_free(struct object *obj)
{
        lockdep_assert_held(&lock);
        list_del(&obj->node);
        kfree(obj);
}

DEFINE_FREE(remove_free, struct object *, if (_T) remove_free(_T))
static int init(void)
{
        struct object *obj __free(remove_free) = NULL;
        int err;

        guard(mutex)(lock);
        obj = alloc_add();

        if (!obj)
                return -ENOMEM;

        err = other_init(obj);
        if (err)
                return err; // remove_free() called without the lock!!

        no_free_ptr(obj);
        return 0;
}
---

The fix for this bug is to replace the "__free(...) = NULL" pattern and
move the assignment to the declaration.

        guard(mutex)(lock);
        struct object *obj __free(remove_free) = alloc_add();

...so the compiler can observe LIFO order on the unwind. Yes, no one
should write code like this, all of the init should happen before
assigning to a list, but hopefully it illustrates the point.


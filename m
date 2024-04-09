Return-Path: <linux-pci+bounces-5962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58B989E217
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 20:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C23B24F94
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CD585276;
	Tue,  9 Apr 2024 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQe3AUUS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD5F15574A;
	Tue,  9 Apr 2024 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712685906; cv=fail; b=slj6gQaWV+FLw+MsqX+HKAit6WkoeXsW7KRauZ4dEMZ8RBYzIoGWGyQGjj+h5JCIytgk35GIK9H5G1zpuZtKlZzZJUnUc2726pMpY7+60KdjXprX9v6UbH0VPBQkp1ZBOwv5a0DXl1eXrc8wZU8/bDDmncS+StTYpqXIUS1kUfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712685906; c=relaxed/simple;
	bh=xJLn2XwHpvklUnfTayyg00BgVl+XIjtNuRH6jjKWN3o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yn0FuRr5Q9zCA0En114DLXC4c0UL/egHirJvgHpOduXEze8JFzr7mNDKSf/lvQ3zy+2EOk+u606GJtRaJQBFNsnsCwbMrIDnpgDp7n0cRsAPT6DXTyDOOKS2zH6WmwalwUN9AFq6aiXd1RqCEonwaTN8YhzZ+5VvxyZ82pfMpnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CQe3AUUS; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712685905; x=1744221905;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xJLn2XwHpvklUnfTayyg00BgVl+XIjtNuRH6jjKWN3o=;
  b=CQe3AUUSgebbkzkcI4RTTjtm72zEDbGW4LTH6/YejGtvpuWwstYVtR4n
   JJfF5DL4bqDc9Lphw7po/cqgNQKWb6sYMFbHAhXgNMTHPHBsOtd2l73tw
   5fcO6quTypsESxywWx60Ot7ITvjorcJ4um0QMxrCU75gf3cU2VND4CRle
   toUo58c8hOLh8v18VwnFL/CWmY4yPHxEdD1TX+ffOrWDG7kxm3Pt19TCs
   8mNIjdXHfl1fuAJdewOl0pXiZK+fwS9yQpOtiFEjb0OwJfeDQY9IyK8uk
   1KX87D1Em4HaZUz2bBTqf8PYhmOd9XxKQKpJj6cMxj4vz95jrmwBOqKK3
   A==;
X-CSE-ConnectionGUID: 1dnu+J4qTGWr5aIT9hZQww==
X-CSE-MsgGUID: JNXoB/72TwaSf2H1nvl3Gw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19168951"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19168951"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 11:05:04 -0700
X-CSE-ConnectionGUID: 9J9K48AITSSI7DiXHhIftA==
X-CSE-MsgGUID: qLvrBeoQQvWfyNkEg0deLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51294166"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 11:05:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 11:05:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 11:05:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 11:05:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9Te3DB7koAG7quxjDNAU9++468LQjfdTz+KsbuvdXxPGdEvuJx9Xc3Ex4k0KBbnLzjXvZRtRAcVK0mSQfjQzUyqNx78oVfdFYMQqzWL78R8+VzZ1ZrM/o4VMm7Ie6MmSAEQnkazzXf1GL73kmkxnI1XiOIgURy7AkVsrQYfMttvMUaA1d+4/LLzLtZhczPIumeNkTCzLhAFkb2Bql6jqI//LTCOXOpzk3zQQ5s3nQWm+IOkcBRtAZjTyGDvOjKYisrR0p6h6SsxmfoWYDlFhb833y2AwnuqWUVwInvvMrzuthTReDWbKkN9dKpzycS6E7q2vC7+4AXcka9DUSvZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDfCYvAoUojb2cKd1PLWbEt01y8jRtbBUFgFDaNUNkU=;
 b=QfuHKqRdfD4GH0rNLTB0SPv7ZlsChG30+5kptpHJbNMfbP4E8B1td1WN/dKdERyUn4bX8ammKyS3j+HHaM7gmX8Lx62Bvn1rga3L7SGedrkqqAgxTGoQQqnhz622xGFvSzWPpVLqc2UrV/LehQg5NeR90rxih4Ejk7pPl2milxxiS/70L5b3mdnk1sg6Dg1m06wy83wavkU72K+NOBQWXeNfm3vSWqfzExQJFuhms73do8qIUgzEATF6QMQUL8yFYGonUjqGLzkaFpbAuv0cgf0ktnd6SE62jVzd6hP6/MCKHJgVQF+QtQxR8zlqZvjLLNAkJ78ZGfvFIrCjshgLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5105.namprd11.prod.outlook.com (2603:10b6:303:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 18:05:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Tue, 9 Apr 2024
 18:05:01 +0000
Date: Tue, 9 Apr 2024 11:04:58 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Kobayashi,Daisuke"
	<kobayashi.da-06@fujitsu.com>
CC: <kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>, <linux-pci@vger.kernel.org>, <mj@ucw.cz>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v4 3/3] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Message-ID: <6615834a6df52_24596294c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240409073528.13214-4-kobayashi.da-06@fujitsu.com>
 <20240409150540.GA2076036@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240409150540.GA2076036@bhelgaas>
X-ClientProxiedBy: MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5105:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JX9NWu/kuilvXQ0qJ6Renr/c7emWjz31de20DqU/UwT0BHkPt8dmzi53woOuBsS0tfpftzi1FKOlAvt0VBDfvSPDrTHYaVYr/icFDclDsU5yAaG/+1HBrz0FpQlIQW+EG3PGdn2KEf5knLTJLpptzRjCIJiyC7vOMlyNXUtjJ/i9+kZaRtrzc7BQWgmrp5HHQPZSkWJUED/PFwhzN60/e4uFnZjumd1IuaKAtOiRQbXHzwYJEwFgVV4vO/Ork+wtDYnvMThAXG/ejZIVxK5NiWUbasIhDZdhDuRAcGbmmFMZuEeVcb99Zy+AjE5hze0jKfjStl8LlGtDhOS6N5jei4jaC9GXYGhFkT1O4zbyes8CtkJesoUAAypzbnHXyqKiXdtvx72tzC24t9N+y8W/0ttPs+FJEm74lq+RW/XHBUaX4SCcTzUPm27QWbJPt/pHOViDnbYWUkuzm3KEg9aO4rsyFgEfKi17daSM5miuEuSivHHKsIfS+BnGs+2WXy4g8b97IuRsHjcA84d8Xs6hyAx/BEKQSLMlGitCU8DFO8K9ZyTobhb+57Z75q/lsC6jnhdUIuqLCcHLaFqJbzPfI8UQKsuxaR6iOlmoJeoULFDa1Ey49KI4BSko3pf9VDUjxj4KZoYdiD4Vg8uKnc4WfQ6Rh6XIXdOtxoeFXyGXIjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SM17wG5qL12B3lx7FZ/YQsyYyIoTeW3T8C2V30/UQ/efzmCvBgmzt4/p6COU?=
 =?us-ascii?Q?cLpXZFccJT3c51Px9vmBhQODMpjE7lIZ4VpG8YdR4nZSEEcB6YvwFMfs+9kl?=
 =?us-ascii?Q?K6OtrApG4PLxR52xXz1Iuj0AjtXWd1l6JbmQy2qYL76h2qB27umwHb4sfXcU?=
 =?us-ascii?Q?fv3DkrK+W3gP3ZXkk38E4xdl22cC5WmSZKmBM/Qeo4pQlCcm68RcZAvgAXOR?=
 =?us-ascii?Q?i4NZRsbtpyr5vcfvbDAPKSeRtF92/uVANIZQQUj/bP9g6QbWiwRlOVgNMZo2?=
 =?us-ascii?Q?AwSfFTx+NC1dlGHwsMO1xofo+jOZPuhMyhDgsYqSs3oKn+V6arusWWjSb++a?=
 =?us-ascii?Q?PjhJruT+oPtQ/TZ7AKtQx4BByphWM7VhS6oOqT5qQC/xQLd+JTinjyssQyj9?=
 =?us-ascii?Q?w1+IdjhEcGYqQhaWtaciE3dyh740WZZTNJNBtnNv/h/H20YBxeVh3YJwwPmt?=
 =?us-ascii?Q?J3+jr8jKfdL1dm5bcbsABNGnbcsMCfdT6YrGJrYnjkz40p1DCCCzaVWGhlEV?=
 =?us-ascii?Q?p1sHtyTdq3Zk5C6GGpWwHnn8QIQwTi+a9ylj7ji8nFJ02m0vbgbACWovO9OI?=
 =?us-ascii?Q?NZVDvmwvsq9F/m7lc20hwPSJyZ/1mzFzWrsRMGlFH59Z6k+b4GXbU5D9Q8cs?=
 =?us-ascii?Q?vqQ1eCo0mVlBWT7DDw6iJU2RuvUoTJBzgcBxX7AIFwa80w/L37xvfp7biSvM?=
 =?us-ascii?Q?9ThQtHcyNYtlzuUkMYV8exn5vgu8aRGRFcAH/rVX7RO2/NoSF4534rv3saon?=
 =?us-ascii?Q?GNTbDtIc19Kwe6wPf0SZUXk2DyEh6FL/vrp+FROK156Q2EtznPyKWpMpAyBY?=
 =?us-ascii?Q?7K+aCCip2Y3KFdVEZ37ZrfOzgC2mKGTJ8uqvfLfT1Ji0pYZOScKJPX636Rpi?=
 =?us-ascii?Q?T0SLfiydPm80LUdcbwzpeLLTjJ9DMs88i4TdHQ2CaviVU/wvTMA12xFsxrK7?=
 =?us-ascii?Q?+FLOkczQ6RTjkztJ7GKyitiedsZyv1krm2A3uBGfYu7Jud2zhYQOSM48X1IA?=
 =?us-ascii?Q?p/SAWULE7Y/xLJ1DJCF4qHxOX4nj5uB5AVtQ5Tp5CTk10/JJXrNQDzjeCEAe?=
 =?us-ascii?Q?nL6XE6b8l7mpqy6yWH9YpxPwxOPuy2cX5V0LAe5vEEpjh0hGW3ZJpgl53Vyw?=
 =?us-ascii?Q?lshmK32X/a7bMJsjEQZTiwnNxxfLkimykPbLdEFUpK+jlH9MK9EbR7rJOYVl?=
 =?us-ascii?Q?4n96w0SpYvTp/75fdG0NnNng6k4jIcSjmIuBZIaLzJ2A0Qsc7m69pncjq0X/?=
 =?us-ascii?Q?dyKFEE+RegySztLIUQdFblworxSP38hwD+mM1RYKKsgIowJ201WCmiaiKt2h?=
 =?us-ascii?Q?FxeDHsU0PkTO6Bp5pbCfsmLPVqNCza5OA9bqTc0BDrc8BXr5PZtcND8B3FF+?=
 =?us-ascii?Q?ZXlHIZ/766AJ+kzJAXH8/wmRdN2mpNAEm5Aa5HeldQHh+dabys5Cs4mCpVmk?=
 =?us-ascii?Q?SFCus6uEsduDWAa3LBN4Wkz5eyb2h7ilcGHOqLxZPzmJeN/wzK7rKhJY0bxo?=
 =?us-ascii?Q?yI6q8MYpkrGiWgepqbNIWuwN/I7YT0LCkggzC1qtjBAsP6mORB0XuRwGAzOu?=
 =?us-ascii?Q?ulCx9KpvUkxvNk0j7rd9aMn2BrXiHN15iuPk7WV34sLUmiQWdgEfWku5oLk6?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a96910-f245-4a9b-f031-08dc58bf9314
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 18:05:01.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSU+k310mbSwrzwnFmad+iWi3k+dOep4d/GW/uaCX4m2hne4dsYJ7vHzPaP7thyJipTAbAXUaT2Nn4fMbXCSJZsVOl1dwtkCw8LfFENJx10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5105
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Tue, Apr 09, 2024 at 04:35:28PM +0900, Kobayashi,Daisuke wrote:
> > Add sysfs attribute for CXL 1.1 device link status to the cxl pci device.
> > 
> > In CXL1.1, the link status of the device is included in the RCRB mapped to
> > the memory mapped register area. Critically, that arrangement makes the link
> > status and control registers invisible to existing PCI user tooling.
> 
> Idle thought: PCIe does define RCRB, even pre-CXL.  Maybe the PCI core
> should be enhanced to comprehend RCRB directly?

It depends on if this slow drip of features continues, and it seems that
PCIe base RCRB is scoped to a single device/port whereas CXL appears to
extend it to merge the endpoint config space and root-port config space
into a double-sized RCRB area.

I.e. there will continue to be CXL specifics involved.

Also, this is a one-generation-quirk as CXL 2.0+ hosts drop this awkward
RCRB arrangement.

> > +static ssize_t rcd_link_status_show(struct device *dev,
> > +				   struct device_attribute *attr, char *buf)
> > +{
> > +	struct cxl_port *port;
> > +	struct cxl_dport *dport;
> > +	struct device *parent = dev->parent;
> > +	struct pci_dev *parent_pdev = to_pci_dev(parent);
> > +
> > +	port = cxl_pci_find_port(parent_pdev, &dport);
> > +	if (!port)
> > +		return -EINVAL;
> > +
> > +	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkstatus);
> 
> Is it really what you want to capture PCI_EXP_LNKSTA once at
> enumeration-time and expose that static value forever?  I assume
> status bits can change over time, so I would naively expect that you
> want the *current* value, not just a value from the distant past.

I expect this should copy what is done for aer_cap where that single
RCRB capability block is cached for future access. That said many of the
link status change events would also cause the device to be rescanned
and that value is refreshed once per driver bind event.


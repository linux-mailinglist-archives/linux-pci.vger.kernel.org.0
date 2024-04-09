Return-Path: <linux-pci+bounces-5980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B215C89E528
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 23:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E69283F94
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 21:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27140158A0C;
	Tue,  9 Apr 2024 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLt5Md9t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26C156F40;
	Tue,  9 Apr 2024 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699251; cv=fail; b=S5alsuCuGPRW/o/5sFM+CEq+tGULFv7vwlcAkwyzrUi9+I7NdCl5CgmBkf/W/TE4ck/P3dmLRTg1TObaGuLr/kuQ8r/7LA7jf0dbnR3a9ug2Cqt64NbStsBUsss87xJff3f77qjotBnjcd8lcqkO+euY6RajlUP97uLL01DUQFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699251; c=relaxed/simple;
	bh=MZhBUIJLrA5/brjRm62yV98EqszaVu2sMhisFnb5Pdo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jY/KbjoqRnLUSg7xjWKX6uqMyPT+OHXKQUiulUnvIMGsStJRvrUkf4LPYL/x+WQtWkajGgHNlM63rQvyPkeaWgV3J5/a/Fh6boP6g01LTeKoj2kvL0XaxA3oqssgKONuFLhGud6PEhVRQWnC6vCe287kzpf1fW4ptRbbI5oqEkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLt5Md9t; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712699249; x=1744235249;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MZhBUIJLrA5/brjRm62yV98EqszaVu2sMhisFnb5Pdo=;
  b=gLt5Md9tvLdWg7s3eftoyUMhXsEJLJLS2IrQK8b+i2tO3zU/6MTFkoFB
   c/VHpDX/N2ZqORAjAsSZ/pycMxrCSoWzzL9baVS9x+xKlsd1MQtsHomfz
   p4jUtZNLAJJR548+6KSchwfZD4RqQJDSLYtwAb2m6t+0stJxQK/JOf7oB
   SGaHD8i2CA+e2qcKfQHPVNMQO5kW/0EJ/0ydfxsScuuvBvG22li6WwrJp
   fN3bEeiA2aFDtDzDHWjkrlO63mrUdxKkfi9Syw0zcNTPtI2mL3i4ad3SH
   ks/izr7PIdb8VKrNOfXHPNwqs5lnvNaRQjsV8m/ITtSHFUjP/z8Mm3mwQ
   Q==;
X-CSE-ConnectionGUID: cxHs/6rbTS6DakPt3czaDQ==
X-CSE-MsgGUID: 37XYR8McTIGmvm0Z1nKjag==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19422683"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19422683"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 14:47:28 -0700
X-CSE-ConnectionGUID: SmrUpv01RRCF+NVwJtr0JQ==
X-CSE-MsgGUID: WGlNbeGzRba/JNbWAkBK4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="57797745"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 14:47:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 14:47:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 14:47:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 14:47:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 14:47:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzhgWixW9YZXgYYtwzKcoJcyB1Ux8AAnq5zQ6AfhlPVO+sosHwu5Gbr6Xss2TehtkS/f9AvJslkqkoYjOC7ZXexVD10bB6A6c4AzLMRWv6/UBvlDdPaYMzaAb7ACSYF3O1W2yiapL3eZmZ794O7vqbKEDOlILSJ7jm0fGX7bGZHpMVx6Ev23R1ZkPFhOVD94LCWCqs9e4hEejuum+T6BmxAUYWYEzYWJvCAfwE/Q2lhVn0OlwpFxI+/UBr0Hb1vaZmC+czDK6GnQQwsx+m+it22dBSKeNWaXm+hGWZQ5Qp09f+5soF+fyv+38X2tEXP/DyiTFXW5DobF0oBw90c1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO5SOU8aDiuXPzUyDx1rdo9uBQMPmKY4pHG0tx0o/PY=;
 b=OiIDZ9ghgbBSNAYw43/bPEkwHl+RXhcW6zhlPJbGC3Of/UrtzXpl8+/uJOVZke+NBv+mrkDPUWemUjB0Smu3U3JoP/UyL9m85cqhrNW5AJJ21NvCHJSEdXNlFSqb4gi5BFc7dNXjXTaTN1W4PAquPYq0bTZO+ysjTqmHvb7Yr1sDIditdeFtRKrKrgKHPXdppC2wX7L+BAY/aZrRmoGeDFr1zDbrRXORRrowOXY8bm68RztlTLPOJlZqjq3dESERMaMIRKIhqZPyn/VIYHJtghaIrT5CoRaCoERQq0xzr+W8KcN3OVGE5oS6bqXbCpe1DW9qYDq78iARdRsdtBc5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7466.namprd11.prod.outlook.com (2603:10b6:806:34c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 21:47:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Tue, 9 Apr 2024
 21:47:25 +0000
Date: Tue, 9 Apr 2024 14:47:23 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, "Kobayashi,Daisuke"
	<kobayashi.da-06@fujitsu.com>, <kobayashi.da-06@jp.fujitsu.com>,
	<linux-cxl@vger.kernel.org>
CC: <y-goto@fujitsu.com>, <linux-pci@vger.kernel.org>, <mj@ucw.cz>,
	<dan.j.williams@intel.com>, "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: RE: [PATCH v4 3/3] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Message-ID: <6615b76b16371_2583ad2945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240409073528.13214-1-kobayashi.da-06@fujitsu.com>
 <20240409073528.13214-4-kobayashi.da-06@fujitsu.com>
 <6615b424e055f_2583ad2945c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6615b424e055f_2583ad2945c@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0244.namprd04.prod.outlook.com
 (2603:10b6:303:88::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7466:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aC6mhqI3F6GAK6elu/PNm25otdEzkTi5mdT8udBUImG8AQUu/RAwGyLYlBAPGZb5/K/T3gduT2uTLi4jkQH+D58MAG0nGJhN+We5lI/2cXnETwTyPxDWGxF+6Czwrrewcn8l38vSvkN4hJgsuUHZjIK6ple7Tgc7i6lh+SAYYuh/rAtQVS3J+Jda39Ueuzs2tHNIzs5RSWE/K+4AfZWPElKY7lHev1BiDv7P8QGLQUR7Py8vdkn+bCevpH5KfgucWuPQ12ifdjfIp2q0TYo4WQBc8NysUZQMo1xt8k2PTSt5pBq4KtV4RSauGj/8wcvJSi9jw1eES6aYJVtsw1TrpT+eLVPN4wqDuqyMfgY8Jy51YHFMSxNvFMY1RxZfgBEYYxLJ/WCkSv7JH5eiz2QWPVriOousvyU1cbOLqzsVa3k3Rm47WSVdIdgqg7J+s60DL/L9ZJQTgIHtUG5anvwx5l/fAhaZxCq0SFGuk/eZtxihpeFw2iS6QhtcSdmnn4LG8OQm2DDh5dgqK8cN+YYVZvVD32h8W0YYjoK5buEI+gWWkPdVN0vs6te8aZXxP4lN7EltmiQq8+e4bFLJdJmeb4vTVDqg/PCu7H4EWQW8LUYtVJYUlSDiA5d/IaMMIREwZALuGVspGTq1XkQ9OQc7vOoyjnLXoomeveBsipWUd2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wnjOsCIVrN7mGA1oi9EtYJSHO9g7k3HBrluRCtz309IerktcZ6h2PnJLFscc?=
 =?us-ascii?Q?qoU126LHXJ9FwAS+CNzJfJzCFQCJJQ4Nxz1QnQzYS3WsHgSk27FzguP8vp9E?=
 =?us-ascii?Q?ioGtFXZ+zLLCQmeSrrlR3KYznkKBi7fw1wz4hcqD5b+xDAxbxPQx0SIklkPh?=
 =?us-ascii?Q?cwociLJevQ9o+Obfq5R7NqgsOSOFyC22LvzEI/BFsYbZTwqhrRO8XzPfqpn9?=
 =?us-ascii?Q?woWQSiFQ3uFsPcw59W0iAG9CLaEKtS7vTr+mxO3SHo2h09xvaR61plBUbXUc?=
 =?us-ascii?Q?XqwPJw+cKBzqn3iD9niBw2qzSa+p/svSdQ5nbhL3Ydz8riD/YbhIcAwxBkyQ?=
 =?us-ascii?Q?WS/6mYsZUv4PtrRd6aGJU6bC1a/kmyZoveIMtT19GArW1tqF/nJJOOQrfuuN?=
 =?us-ascii?Q?GJLuF+J/AvImldkIaAsnm3cX/c5pSDDy2sc3RSfWVINHqae+54sNWxLZFlBx?=
 =?us-ascii?Q?8CgweNdAAPQKRY9Sd7Lps30O40dJAZKDrHdcQ0LNrn5Kp5vF8oEoIgz+5pIc?=
 =?us-ascii?Q?SdQ3rbKUjznM6Hsme83mAXavyG0d0iXCUP338RYKhnwVX+/2Ygi2gG6s5CJu?=
 =?us-ascii?Q?/w/IYffJl434gl1ZEWBxicq983RX7z0upbILMHEJBo5zW2/mZMV2tQ7pTXEf?=
 =?us-ascii?Q?krPBbPHEI4ajywHkF+5GS2cahd8KKysp01j8Ga3VzS+808WvmgTDesXede47?=
 =?us-ascii?Q?HtoVzCatCIK77iGrE79dBze/5gBsVoUBL9J2ZgbV0+CuAIsrHvqsj6/beLaf?=
 =?us-ascii?Q?5WAK++ztXl16sIuTk9VBzDRH2E7q+IM/KWb7oxo39VYt23LmvqH95EC2hf4i?=
 =?us-ascii?Q?TtL+CiyDLI5RDyRS+rXIirXsjUyIf17GEJK4NiXqLaLu548x4sjzbiRYm8xR?=
 =?us-ascii?Q?lu4WlalPsP4t5Pcph3wkfu8BTwUyjHCQTzVQeF6geSzpCCdnuS5ItuysXnGS?=
 =?us-ascii?Q?+ofBCWkxdI58WD1w+edvjzh7ORJKof8lXu5OtVPDH6szcqtwiBO+1UhvF6O6?=
 =?us-ascii?Q?aEXbRLeHDq13gkHWiD1BDELZQa+dt8uDJuFcsY5Cn9v08+tydyeZKiL2Hb3w?=
 =?us-ascii?Q?mXT9NPN18XgZ0Vi4Qtra7GsHmKP9gyENR25t2XGTyRxTDcQvMcaCP4nuRIW4?=
 =?us-ascii?Q?OivJk3cPXqONW9a/n2y9dDY53T+QEW5YPQFen+I+MIy5yK/y+SZ0ONd2Af9R?=
 =?us-ascii?Q?8xIdAcs+9fkqK2ukn5F0oeJF4VaDGjl+d8lFhWfrLzbWsou53EbvkKfD9mOZ?=
 =?us-ascii?Q?HdY13wpiekbRmlwoIjB8H2GhjE1GcpjuRuaAkav3ZLJH/XREzlxiU/1ed8JL?=
 =?us-ascii?Q?0/mWI6vH9d3xpam1Gh51hP0wngUgkUXVNJj1n8E5I0cUObHMtxa6s7K/Ferf?=
 =?us-ascii?Q?BnzRKj49nkJHqZvvltK8QP3OOoeGf7GVugCr00ANYsnp7JFcQgnnn6OgHAQ5?=
 =?us-ascii?Q?slFejRdgtYi/X6mo2U1/d+9n004GFwm/816nPlHAbsjV2x9oQXZzULfD9fdM?=
 =?us-ascii?Q?C1T22rDERKvLb80yc3yePYMpkf2xuLRZyi6Wk/NQ2b8ERIgtHdNah1yb7lBp?=
 =?us-ascii?Q?7tPuRl7IqSTPRy3v0Bff08VnEopXJNJb+L0z+XOUW8wq1fnWcwWWw4l8J/e4?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e12e7e5-5dd5-42be-4c76-08dc58dea4ca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 21:47:25.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/xiHchqUuF83IFtq27ZLn6RAW4L51ycCbvGJLG8AsnnkzRj6S7Y9kyGcZVCzUdQ2dCIYoDReEdgnB1aKaxF8Eg1ObcjeYy3Q3AWyR7o7G0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7466
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Kobayashi,Daisuke wrote:
> > Add sysfs attribute for CXL 1.1 device link status to the cxl pci device.
> > 
> > In CXL1.1, the link status of the device is included in the RCRB mapped to
> > the memory mapped register area. Critically, that arrangement makes the link
> > status and control registers invisible to existing PCI user tooling.
> > 
> > Export those registers via sysfs with the expectation that PCI user
> > tooling will alternatively look for these sysfs files when attempting to
> > access to these CXL 1.1 endpoints registers.
> > 
> > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> > ---
> >  drivers/cxl/pci.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> > 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 2ff361e756d6..0ff15738b1ba 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
[..]
> 3/ The port corresponding to a memdev can disappear at any time so you
> need to do the same validation the cxl_mem_probe() does to keep the port
> active during the register access:
> 
> 	guard(device)(&port->dev);
> 	if (!port->dev.driver)
> 		return -ENXIO;

Apologies, I made a mistake here. Copy how cxl_mem_probe() accesses the
dport.

	endpoint_parent = port->uport_dev;
	guard(device)(&endpoint_parent->dev);
	if (!endpoint_parent->driver)
		return -ENXIO;


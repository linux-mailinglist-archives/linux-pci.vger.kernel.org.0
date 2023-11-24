Return-Path: <linux-pci+bounces-150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D38D7F6B33
	for <lists+linux-pci@lfdr.de>; Fri, 24 Nov 2023 05:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578AC280EBA
	for <lists+linux-pci@lfdr.de>; Fri, 24 Nov 2023 04:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C1615B7;
	Fri, 24 Nov 2023 04:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpF7J+Uc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48939120
	for <linux-pci@vger.kernel.org>; Thu, 23 Nov 2023 20:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700799425; x=1732335425;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4CHlGdsILOvwu1gkWs4xzLsKFmoXytSF54cmCeQ3VJM=;
  b=WpF7J+Ucj+caHJXi9AOq2NEl3JU3mmMVKFE7oHRgRWlL4gObGHxmfuVY
   MtMDICsGLjGiHVTR6bNH8uiSToLXnBnjcGWJqll6782IBMNgkjQJmLp/O
   LLwOHDKfCTXrok8gIZT/kyoNucrTvfSfouzYl9y5O+N77mvCu4Pww04jC
   7UxyeO0WvjWsGavZeTycBxQqGbTXYLUQqJLfjW0WfB/G07bSWAT1paSX4
   IYHbUOwZwGi90DKxsQ7fZagHvl9WD2k+vpCdNmtB6uHrCgJEFuz6LH7LR
   v7t4ZuFbzPZOsOfT3/cdwUdoysWZ9K0OekkvGba79EDuvYgisXD5H3OcP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5512617"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="5512617"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 20:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="743761945"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="743761945"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 20:17:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 20:17:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 20:17:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 20:17:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ia2192vTr91OTTgtIUCe8eFechrFMSc1HhQo8awVKyWy0/snlOs/QxoO6Oqnm3xYBSPWJE6UWOClyrLWvJ7bnKrPfTdKmE8jG9+p92nbp2dahb9yTKneOpzIkWVb3Ue0s7BrU4/XR06uMAYfqnaO0Z3F81yYHc6OtYocnuRByamINPpA4DblrBvGHoEauPZfwv//1JUnAFtvqG6UBAU7HggHfo1Oka4NyMNfOK0FWrsLLExtaVnjVb5KgccOKxoWdxjOliNyaSuuf+pvK6G6e1rv+2RpAGATsxN3zcZRDkv3DzhoZi4NPLtMVd3A4NR79Wwu1zY3pEk3B/HATt0rfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2j9QX7ye6DG62p+EL/kHs1g/JSCQdeaKnSbe/G9FgY=;
 b=oNiYYDZB5vOtklmSbL5Dquz9aMXkIHxmbBG0ZK1mfHhSUS00rtoAIZWezyOB1z1hLeChlqXx9zhDrTcoJ58PWziqlhLhPquV+LgWATWv/1PdZUVBuVeamoaCSndQJCR9yC2Aj1aSW5YTqGG1cr62AFnRcFVYEOEYUBndfLvbSK2SqqO14NMOXkL02Ug2hOaYSUtTsCzVf9lgIo3agd/snvdeZDpEsFPptzQPrXAL6gnCsos4dtsdEE9kI2uD//aR2vz+t7hIzw3WHD0yQzlEz9Mn1usfUrt3sVjKUOBFq01ydu2DI5XapXnAk6X1bO8n35fXetXTWEcIeYrywcNfnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 04:17:00 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 04:17:00 +0000
Date: Fri, 24 Nov 2023 12:16:49 +0800
From: Philip Li <philip.li@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	"Will Deacon" <will@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	<kernel@pengutronix.de>, <linux-pci@vger.kernel.org>, <lkp@intel.com>
Subject: Re: [PATCH] PCI: host-generic: Convert to platform remove callback
 returning void
Message-ID: <ZWAjsbrjcA2zWN9x@rli9-mobl>
References: <20231123171236.tksz4lhpj5jbwfxm@pengutronix.de>
 <20231124032535.GA351419@bhelgaas>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124032535.GA351419@bhelgaas>
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|MN6PR11MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 865c86b1-3aca-4377-e178-08dbeca4336e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUZ7ZJtYFPtnDuET6BD/K3Z9+zbztwfaWPGZC3ykdfQzx9V9q+7l7jmcqJ1VPoz/bRSFSUzVYUOAFgncsC3EF+c9NMJPa/SRe8/uQykEkzv1Yz8PIVm5h3BbqFbL/c6giaf8dyvzUZ6K/JSNKnXkx9O6jpw42+JDN4Oy7eko+x9Y/OovRDxV2r70t/iuSveJuJ7e0S/8qKi2rH8Vn4H+QwFYc+iiBXwHKGlxB4bnZmTRsOEVXoopK3M29XO7/9Ti8gA09ZyX0PnO96ICgC0ufdJC5sFJewBibDlo6ywnn7yb51qWjPWSEXEDsFNHYoyIIyCTafwn7nmOvAJbh6wSAKPvWI7boQrC8LcaEBWdk2STC6JavhTolVMqyKKJEWAbLzrKqrUKB0uwLsIwdnlnjnJNAyO8Wufcyr9tSiJlfN2X2MIIU6EijXDc67ln/YjlECxbakgqznIVlyhhFyycDv3kRpmRZz8AB6Br/SPxMTGV/2I0oSs3QIGSeMKuukJDA2L80y5qxPXNqh7A4YPer+7RPQEB3ih+DqVdWScSM3hXmi++pasJXrMnM1m139WUoXyVaOfem45Z+mcNvuhqFQEGeji71VVNz85btrTlElc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(33716001)(82960400001)(316002)(54906003)(9686003)(6512007)(6916009)(107886003)(66476007)(66556008)(66946007)(86362001)(5660300002)(66574015)(26005)(8676002)(4326008)(83380400001)(2906002)(8936002)(6666004)(6506007)(44832011)(41300700001)(6486002)(478600001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mx+d/ydLV8bbTPJjoHs3xl3IWCR3pSg/CDzEpUMLuiKQ0BUbur5cDI2yaq?=
 =?iso-8859-1?Q?KD/Ot4y3RsGk4SmrJXJUlLaUe+N5znEUoI1zlrozVSrNWKLXVfzrji4IfH?=
 =?iso-8859-1?Q?6Lo5+ZjnP9qTlXjQYku6g9pfJMAGPRUWu3omALU+IyyfBLgG0l3x92pLrZ?=
 =?iso-8859-1?Q?8PUQ3nt/zdV2XzyxKII1E8aI7+wW50GtcF6WMF+SPfG9CLJ6KOyG6gNgsf?=
 =?iso-8859-1?Q?gJxbpYRhMCUmgMYOdIokgiFuCNzHe7vPICvEQaM50Sr2T4vxhBCjQCf3qs?=
 =?iso-8859-1?Q?V5tdWfoWDvbJz4Qm0VwC87uezCedXIwOd6s/KzYuO+nNTVInoHN+xA7Ndg?=
 =?iso-8859-1?Q?KGiEo8K7MavzmV1kLm/YeqxCTHrhYRGZOTKaWyrcujPpzTfZSHHWCLVS9m?=
 =?iso-8859-1?Q?gTIs1mGC97APeeyqWQ/bh5JwJWKRzRDPl9QPxu/YYquzNboXbUk8zZAl+g?=
 =?iso-8859-1?Q?GMqPH3vIuGO/Z3QrMW4cDy4EC1tI49q+QBz9CppwLzaC+o4KB67HVNSgwl?=
 =?iso-8859-1?Q?GkDnKOEfQkBsc6Iw5magajqCN2RqcHKFhpLxzGuzVgdE26i8lqUuQEpXRM?=
 =?iso-8859-1?Q?fJWqQ7sjRCWk4T5N2h4k9KvmcPckBsjJhlKhgis6MQTAtBkbemI2hdhHPh?=
 =?iso-8859-1?Q?46r0hJgCmWQyFGvycla1PN8YusYbGPpCWu8NTCJo3p5mo7M+vAJi1ZgRTH?=
 =?iso-8859-1?Q?8cq78CrYx/2LMXCT6Rs3Z5hebqQ76uIfUjJ475sFd/xlp2LHVyRdlr5kl9?=
 =?iso-8859-1?Q?yvSifs4ec+BhQvxbk1zMD7O2ZA52DbEzafF0cFNLWhHEnh8FpjzkE5HPsn?=
 =?iso-8859-1?Q?g0MH1N9dPfth8SbR0sceV532Gak8FSAvf7pnTViz8LJjEgXg9un+FWza5l?=
 =?iso-8859-1?Q?+F/XkOcAbz49kuNXpUbq0PYte6X8NvI9cSML60GuS9gFH5DgsSaywYhq20?=
 =?iso-8859-1?Q?uacr8cu4thjcXy1g1oxrs6eM1woyFelq3hiqU3jWH6nwa5nFcWsZOqjfRi?=
 =?iso-8859-1?Q?93fcf349OSP8DsfrNXzhsx3OGzfuUbpGY30/M3y4qGuhKwe5sH74zAOeq4?=
 =?iso-8859-1?Q?nhE7KBI/WngYYB/GiGlYORGVDVsKFCZBfGH8aASeDECTsaYRqxHa0JO5Ps?=
 =?iso-8859-1?Q?HthyNsXcsvnvJmIKZ/59ab91t3/4pioR0aHHFTqEktItVt35p9gL8UfzU/?=
 =?iso-8859-1?Q?lvIzOLH9xeLbiQMMTHzHD2Em1m+kljr3sY7CV5rXAWFyXue1/Kuat09yj2?=
 =?iso-8859-1?Q?/Gy0S8oOD+vF9Xh+7y2Hi/3UPNFqrMguN58ACy4OhXM1BfVyEoGNdAxLu6?=
 =?iso-8859-1?Q?AqP0C3SzU6bli8I4K+vbBv4wvhdu2xV1ewMlkqMyBZC8SXIsn2wnZEt4X4?=
 =?iso-8859-1?Q?Kv4ra9tainJsQGsN1fPm+oMqnC0yBTXl812ZkPf71+wp3vONkrt3SknyYC?=
 =?iso-8859-1?Q?rnLgNkEo6vVrtO2DgrRD/TwLMSg9jtxStrgKoxk01m/KDy7kp6/eGz/ECV?=
 =?iso-8859-1?Q?RqgZbWzcYeCJ0aIvsQiGxmRDuersmQJw2pOXLIl6qqtpJeHMBmcRU18wTq?=
 =?iso-8859-1?Q?RTSD47ADhVw4FXX3Qc65l+ZYGPV0ItsEWJx9D6Lt5NVRPM3UDaR3QWfxSd?=
 =?iso-8859-1?Q?rV8u0IukSSF2nGOEH0sEprHnYiKq+ZdGh+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 865c86b1-3aca-4377-e178-08dbeca4336e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 04:16:59.6284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJjmQe+taUbTXdOjjmbmdHvMJgfxoV2++1+NkyVhkm03wLxsN2/WjpTKeT7oIoZte6ELpGRiSZ9DnqC0Ll7ZMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8241
X-OriginatorOrg: intel.com

On Thu, Nov 23, 2023 at 09:25:35PM -0600, Bjorn Helgaas wrote:
> [+to lkp]
> 
> On Thu, Nov 23, 2023 at 06:12:36PM +0100, Uwe Kleine-König wrote:
> > On Mon, Nov 20, 2023 at 03:56:18PM -0600, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > On Fri, 20 Oct 2023 11:21:07 +0200, Uwe Kleine-König wrote:
> > > > The .remove() callback for a platform driver returns an int which makes
> > > > many driver authors wrongly assume it's possible to do error handling by
> > > > returning an error code.  However the value returned is (mostly) ignored
> > > > and this typically results in resource leaks. To improve here there is a
> > > > quest to make the remove callback return void. In the first step of this
> > > > quest all drivers are converted to .remove_new() which already returns
> > > > void.
> > > > 
> > > > [...]
> > > 
> > > Applied to "enumeration" for v6.8, thanks!
> > > 
> > > [1/1] PCI: host-generic: Convert to platform remove callback returning void
> > >       commit: d9dcdb4531fe39ce48919ef8c2c9369ee49f3ad2
> > 
> > Thanks! This branch isn't included in next. Is this on purpose?
> 
> To reduce the workload of the folks maintaining "next", I wait for the
> 0-day bot to build test a branch before merging it into the PCI "next"
> branch.
> 
> That usually takes a couple days after I push a branch to the
> kernel.org repo.  I have these branches that are currently waiting to
> be put into next:
> 
>   ecam            pushed 11/20     bot response 11/22
>   resource        pushed 11/20     no bot response yet
>   enumeration     pushed 11/20     no bot response yet
>   p2pdma          pushed 11/20     no bot response yet
>   switchtec       pushed 11/22     no bot response yet
> 
> Not sure if the 0-day bot is slower than usual right now, but I cc'd
> the LKP folks in case something is wrong.

Sorry about the recent slowness, Bjorn. This is our side problem, we met some
issues and the whole cluster can't achieve its usual utilization. We are still
working on resolving the issues, the report time would be delayed, though hard
to tell right now the accurate time.

We will check the status of these branches, if they are in low risk, we will
send our the current test status.

> 
> Bjorn
> 


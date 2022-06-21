Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D86553BB6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 22:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353090AbiFUUi7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 16:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354290AbiFUUiy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 16:38:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058AE205F6;
        Tue, 21 Jun 2022 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655843930; x=1687379930;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UWia94RiD/2MzSX70GIEiNSooZYWxu9Qt95qHKI/kxY=;
  b=YOU+xsEsyz0EQP360mkZZwVObC4qYSHUeBEaBbbfTT5eXXglKoHsR7O8
   WR8iM9pXCUvSq3xhBTanpGJ3W+uN9pqPQ8lwHfq7KHGzDw5mTsWwLMwvC
   8Or+WbZ6VfKTq9HjfqhzZ8r6NUN4iQy4nuNyaNTD4rS20LEDqfWmCq8Ux
   qy4ifTbYybhTiOOdxZZ556fXEBs+0hdDvVN51qHjcpHNmZ2xUf6bcCziK
   igiWwz2R4YZKViiOUhSLSXQmqUd7lMLSOEoBb1xUa3xNRq8MiQxAvx6eL
   8Ukt8eDu7On7RLKqWv6GWipWEGi4F8Pu6AbFNjDE/I7Dsir7qsmG8x+RW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="344223650"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="344223650"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 13:38:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="677179650"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jun 2022 13:38:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 13:38:48 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 13:38:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 21 Jun 2022 13:38:48 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 21 Jun 2022 13:38:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uho1pbSazmXDKuHdUiJfPAVOfFpQ2qmMy+fohtXzU6PHErhOnUqKEkIDuM9/AkOYYBvCOgURNJGtCCF2+AQwAFPiQLTeNUzIXvyPtDgjoSatQV52MVY1YDVCnWnMENpbBwrwBoPIaNhAhK2Li+SiVzxwQQohxR1rxCXkGOvjNNwlemyXuRor+CoK3X5s3MPFr/OKCXTIFcuSy0UmTTqejfARZ7G0IicIa7zxfYD7vCn/JWr0eAJo6pFor9W7F4vO4quRGhGTaI3AFDlTwzbduwblwwLmu/eQqV+dSdAUZcAbA2k6yr/7egYLS9/kV1puF0HOrf4QCTNjpZe26epoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlbcvG4hC+UIgEgYmQpiz3j8NI2GQu5x7T2zha6pu7g=;
 b=PEGdNa2Eabbre/QIqi3pd2uVjZKuPQrpKYKCcMHy7koiRe7W4roup8Qnjckwa52bUeAH6Zrhc6mvl2bAjnKB5n1u20AqCsarKvGjiQb5rsBCa5YPG3GPaxKoXJ6eaCY4pDO07NUPRhZksgG3X3ZThfgTcHwu0hkriHcOktsM9S9b/h8JSMqWEVu7UN1oDH52zpEcj3/d/QZfOlpRo4RGAIAfUMhoMlissVzbpHUiiCNuMVWpKGiFwiwHukc37Uve9EixyOYWlnrSPvBCwRxmAXbjv2B/hfuyZW6IBHv+omuoyvi4ZaNBR3NB2/+MdQxrKWRV04qgckn2nNf7qlSjBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 SN6PR11MB2957.namprd11.prod.outlook.com (2603:10b6:805:cd::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.20; Tue, 21 Jun 2022 20:38:46 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Tue, 21 Jun 2022
 20:38:46 +0000
Date:   Tue, 21 Jun 2022 13:38:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 5/8] cxl/port: Read CDAT table
Message-ID: <YrIsUIyTt8XLiMMZ@iweiny-desk3>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-6-ira.weiny@intel.com>
 <62ad1fb69d742_8920729490@dwillia2-xfh.notmuch>
 <62b2178bdcf5d_89207294ac@dwillia2-xfh.notmuch>
 <20220621193427.GA25003@wunner.de>
 <62b21eefaf9ef_89207294e4@dwillia2-xfh.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62b21eefaf9ef_89207294e4@dwillia2-xfh.notmuch>
X-ClientProxiedBy: BL0PR02CA0073.namprd02.prod.outlook.com
 (2603:10b6:208:51::14) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8618d73a-01c8-4e83-8e8c-08da53c609db
X-MS-TrafficTypeDiagnostic: SN6PR11MB2957:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB295770F161020BE0057F465DF7B39@SN6PR11MB2957.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lq/t3cz1u8hjUeKY6aDEf+SlDt1x0C5jtKrlHOzqYWhyQ/Gooehk8YLQBCHTQ2sntJR/mzETkJXEHe3VTF3lssSl2gZSFGqXGtIK6NJvXcrpnEdIkC3D6bhaQ+t9c2pm/i4m2Xgo7gxQfv0A/+Q5licy63AxyrJ2FEJiY63Ik4nCLqXcR88207ou60wX8ZFMwWtgYBCjaHDslfsNmb0mibtjUfx46qK69qUr3mYuVUXDUFVSxeppL3eY9UTkPPpFFOWhj114pJZ6crVcI6WJuJHYDGR7xelMVZHhdjYu/jW31MZP3QDeMLRm8efJ4gIce0j6QiBk1Pyi1kLLf8CeYkrE4usb0mcvc44y64h/yGwziwam+t6QdUzQGfmfM2HmtsoRHModhF2g76HrEsrJhvybw4+bZhSCdMndnbDY43iX5i0D44u7Axjf0gkhhHUUGhGmctiDuPwEV7j8JBybpAZqyU1fCZeCov6ySQi/7nfYXna8rxB+H+aZU9X8dDZqPmN9Ub631aP2AaDmbNqt3Dgdu3XRV2KNU//CeqVTLlbtnKuJsLD6YkEwEVY1snEgWvNj78oHAtdQ6gk+ZOBFis84gtD/1H82kNN8refcQ1IMa05iUjN5xAZjutPZM8iakrgWDqS/fK4P2qagSyKjOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(136003)(39860400002)(346002)(396003)(186003)(66556008)(4326008)(6636002)(6666004)(8676002)(66946007)(6506007)(82960400001)(66476007)(41300700001)(26005)(83380400001)(9686003)(6512007)(478600001)(33716001)(6862004)(86362001)(54906003)(6486002)(38100700002)(8936002)(2906002)(316002)(44832011)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mx1+WGQnCsAGPSWDH/tgXPh+kWmpvlL+PQlLelGMEUUd7lUM34tY9p2scpzw?=
 =?us-ascii?Q?BuDNhCk5hBartOr6Mns1XmohcBMASNz8bswrFgoMiRDKKUkOZRm9T214oZTV?=
 =?us-ascii?Q?fkl+ppAzZJb+vUC68XJSU551GaJOz+LKye666waUPlAMUAmQCJ6mH7GcVCYu?=
 =?us-ascii?Q?5P6FTmiqoUeiQ/xnc/AdweQAKwDtso6ZBizKPhxIfmrIZFL++0hP02Y+S2TA?=
 =?us-ascii?Q?exHlfXl7JzcklKFYGSxzSIiI6oYgZJcNj/3USyeznWXcZutkxmm2p7CNKHFk?=
 =?us-ascii?Q?EH8GU3NKPbu6GZ50Q47xLYZo5UQGOfDbsQeW2iDSxC6eZ8az0tSZbTRbFTon?=
 =?us-ascii?Q?0gW0ZGiqz12QmL432op9yPzzobS/a3xxQXyphlvDXGT2mfbuFrXoCKBrnWNT?=
 =?us-ascii?Q?MmhaF0erah1srn1Np7g5EokP7miuyecRdSuM4uGLqmW3EVIAK50+mQ7Bc2Fa?=
 =?us-ascii?Q?PXVKTqnCKQbgAOGDyem7nwJqFnNHgidS/wKuC0gjUyxTzxM7R9vniFNCvO3P?=
 =?us-ascii?Q?TGX3YO6AWRocBsuxn2061XymOqXcDCTPooxfamd+/nstHRFg5To+B6/EtkYA?=
 =?us-ascii?Q?VoUiRhf01sMN1MurNhqzzOBZeIVCEzt2uoKRTJw8LXoXm1Kj7HU3I95lx0A3?=
 =?us-ascii?Q?Rx1Utdx56XGLKCFi2KYvVGUiDBhYMyrFrjvxFallI0jgaB28N/I8xQLemcLs?=
 =?us-ascii?Q?T+Z4vhZvNF5WDv7LtXN/3kkwPlgDygnuDaGx/04XW33oRyaAhtDhumbva6rl?=
 =?us-ascii?Q?mvIB5hfsRZFPJP5QiSZaOT/NsgsM/owu0jpLd+BzUkBpUQiDe5snzMFt/pl8?=
 =?us-ascii?Q?W72+c3MyO6DtGGr6cYkjT+q5y6Pr2Hz6bo32DIr2VK/imYGRq3WN1JNVyAGr?=
 =?us-ascii?Q?/NRugztJkK5ZLm5VNd3NCkJayXpM20GmBcgkhDCtPCnnWD0kxuEy9dIwfBzk?=
 =?us-ascii?Q?+of9xmm9Fr5bz1/xl+kWMJ7TcVkhq1QSsezohs8tZgm/ynTCMapqDlSsluV/?=
 =?us-ascii?Q?M1WqAtYODf8U7rlnAdhmUXqOXyLYmFaklMYREKEJNWEY2y18CkYavnr2xtKk?=
 =?us-ascii?Q?wByZz+dFsDYNarRE+JGaeL/SrSAsz06+PtVmW5cixsvBsIhFKD4td7lOQb59?=
 =?us-ascii?Q?06IkdIIU6x6ccdlfiSYoifw8OdCf0/ZdTQzTg1FckqknEAuGQ1aQVrhQNlvP?=
 =?us-ascii?Q?M4BBGLi2lz3E+7X6as9Zg/N1b0mhkVQDqkMRHeb0zelV48uX9n4IodEhcFA/?=
 =?us-ascii?Q?s/iHU99E9QAm3aKOZjnUbVr/CwBgamx6R2uH1L/05GFeVUPJ4onM8+s226fs?=
 =?us-ascii?Q?/TeP6wI9vAolqq5+fJb5NiHoUI24REyTT9SF+LbYTpQeRjFkwi6j2BvBp2Pq?=
 =?us-ascii?Q?GgyChWGrrGJ50nDDOCvsbv+YEG2dHdHF+RDDMIP5zBv0PBwCJw+XK3EukfX8?=
 =?us-ascii?Q?qe8DjvYy3kry3FUTYtoXqcdwPVPk97P03Iz7mAbiW7rxWy4KrDhPCfjXsWdP?=
 =?us-ascii?Q?weKVsXv5T65GklmF1xF/CW0tg/NkO+28jhX/eOAxr4khPChWhC+Q9uG/wHtR?=
 =?us-ascii?Q?4SY+swwdSUcCu+ipPz4Cmdbqx6xOwdR7fSJjZywDGh7LLurqr0Uj0NdS35DT?=
 =?us-ascii?Q?sVckjRAgkqerkvHb23pj0PZJPk5bFMBbH0swblKmIoB6/gu1WUT/4UrjuuZT?=
 =?us-ascii?Q?bUA6rkNg2GE43mh75YjvRlxCjxrjNpP6/bowH1oS1ATiDk4ldrxSJ2d+H3XP?=
 =?us-ascii?Q?iKp3DmTpFg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8618d73a-01c8-4e83-8e8c-08da53c609db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 20:38:46.1453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuLfFb0IMUJgE6eS62VXnR7k0Q2uIvqd0bnV7+X7bZp9fQ655cCGy+1T9PAh0ho5bmtm58X3EAiO9bCPASN5TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2957
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 12:41:35PM -0700, Dan Williams wrote:
> Lukas Wunner wrote:
> > On Tue, Jun 21, 2022 at 12:10:03PM -0700, Dan Williams wrote:
> > > It is really the interrupt setup that makes this an awkward fit all
> > > around. The PCI core knows how to handle capabilities with interrupts,
> > > but only for PCIe port services. DOE is both a PCIe port service *and*
> > > and "endpoint service" like VPD (pci_vpd_init()). The more I think about
> > > this the closer I get to the recommendation from Lukas which is that
> > > DOE is more like pci_vpd_init() than pci_aer_init(), or a custom
> > > enabling per driver.
> > > 
> > > If the DOE enumeration moves to a sub-function of
> > > pci_init_capabilities() then the cxl_pci and/or cxl_port drivers just
> > > look those up and use them. The DOE instances would remain in polled
> > > mode unless and until a PCI driver added interrupt support late. In
> > > other words, DOE can follow the VPD init model as long as interrupts are
> > > not involved, and if interrupts are desired it requires late allocation
> > > of IRQ vectors.
> > 
> > Thomas Gleixner has been working on dynamic allocation of MSI-X vectors.
> > We should probably just build on that and let the PCI core allocate
> > vectors for DOE mailboxes independently from drivers.
> > 
> > To conserve vectors, I'd delay allocation for a DOE mailbox until
> > it is first used.  There may be mailboxes that are never used.
> > 
> > DOE requires MSI-X or MSI.  We could probably leave MSI unsupported
> > until a device with broken MSI-X support shows up.  I envision that
> > with MSI, the onus is on the driver to allocate vectors for mailboxes
> > it intends to use and it would then have to "donate" those vectors
> > to the PCI core via a library function.
> > 
> > As for portdrv, that's a driver but Bjorn has expressed a desire
> > for a long time to move its functionality into the PCI core.
> > It shouldn't be allowed to unbind portdrv via sysfs and thus break
> > DPC etc, as is currently possible.
> > 
> > The question with regards to this series is, do we get *something*
> > merged and perfect it over time once it's in the tree, or do we
> > keep iterating on the mailing list.

That is what I was going for by allocating the vectors in the CXL driver where
they happen to be used right now.  But I mentioned in the commit message that I
don't think that is where they should live long term.

> > I deliberately only provided
> > a single, comprehensive review and then stayed mum because I feel
> > bad for Ira having to keep reacting to more and more feedback
> > despite being at v11 already (or v12?  I've lost count).
> > Particularly because I suspect (I might be mistaken) that Ira's
> > natural habitat is actually CXL not PCI, so it might be a burden for him.

I'm always willing to learn more (PCI) but yes CXL is my focus.  I've never
modified the PCI layers so I am out of my element there.

> > I'd be fine to implement suggestions I've made myself after Ira's
> > series lands.  No need for him to keep iterating ad infinitum.
> 
> Yeah, sounds good. If the dynamic IRQ allocation support is on its way
> then lets leave interrupt support out of the current DOE series and just
> focus on getting polled mode going with the enumeration coming from the
> PCI core.

I've taken some time to look at the dynamic allocation stuff but I've not
internalized it nor figured out how to integrate it into the PCI/CXL layers.

> That seems the shortest path to get something landed and
> enables incremental improvement. Then the messiness of DOE interrupt
> allocation and pcie_port_drv reworks can be saved for PCI core folks.

Yes I think getting rid of the IRQ stuff for this round would help.  There has
been a lot of discussion around it and I'm still not fully happy with it where
it stands.  So I'll split it out for now.  If someone wants to pick it up that
would be great or I can work on a more central place.

Ira

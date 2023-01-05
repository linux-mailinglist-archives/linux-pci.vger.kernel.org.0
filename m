Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A9B65F5FC
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 22:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjAEVne (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 16:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbjAEVn1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 16:43:27 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B47671BF;
        Thu,  5 Jan 2023 13:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672955006; x=1704491006;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kNWeLbszZ6k6RG/8RR7RNJzsDbL2QMpJw9JtfcKB4Xo=;
  b=L8V5VB6ZkolhBp7EZP7soXTlUmIxx0BelDPdWhfQs7dUcEoJyWbgCmmL
   hZc8sWnCTkVbYsJqCyo1tQTHNC+NspBKT0jzrb5ZohtRUSCGL32tdkLFx
   GfFOszh2zvE8dczw0BwU/A5O3Y/j4dZN1ndq68lC58SxNV2CcsFjKfO5r
   Y1BV8BhMlSzN/5BEVCGinjVpRa8qDDa7jeD0fU2q75vket2YAz6Xenryx
   BXIIVFYWAGWJ3kXa+64DbLLzmV0bas+OaH+rv2/Cy6hGPyofbpcMhADq/
   C8rT+aqliRrpgZ4nsiCYWldvidnmAF2J2D+AP1y9PJU3urdDLIT29xxXG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="321041541"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="321041541"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:43:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="798062788"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="798062788"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jan 2023 13:43:26 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 13:43:26 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 13:43:25 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 13:43:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 13:43:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBxG+2WPrSm4AGuHG+vo51cb5erFCH50mvEB1AH4GM4xGm3IX1QMn+9L2wrGtvipKlq4EFT00jGPcx4U6Qb6oUKIGI4T3HTa74OxzDBtfLAiSfanflF/B3iAeDnYPRsFW1mnjUCqnVcsOrNCbtV18UGg49eRSnTAYwGgu6P1AMKNEcSQMjlOZyp/weN6h0esKZP8fzh/5EiIDcUU2Sxl5vMoPhIjCLZx42ZncIEEOMt3yJ8TqmkTS3FE1xmVFac+ZGGgPPoHMB9zmhy/Jk5Izf2c1EfzDL4ZBukGs60XaV8BweqHLLVjgDi8SBMDnH+JuKfPmC3Hnhi+PO8en0PvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOssdlGM/ak1uXGICRrSPvM4/s6B6ZA7Z7vx0zvwVsk=;
 b=Jz6Yiv+UxV/OJ2WBMUaqf3SytJz81VFxw61m5GE60dsWOZ9mTDd/1w9n6J1yF7AH0oIynu39i2jDm85ifBuED4aolZU1UB+smtML3FhMIFUdN5Kyk+kOJXxQxkUSgS9+17pzTf5M92Y5KLWqhyX2KICgWaUl9LYNo/8+58b1JqRc2z2EeN0CC8bwuuVv3ej7yavfSfylBXRpDnibRCKTC0k7vePMAcohLOOqhL1+XU3hdY5jrHIVdl533qTTAks4hYaEIv4mTsMdTaGq/KM2FlhxKwq904719UWzLR+Lf8aTJVqou443GkI7/haobdzvqd7cKxdwGd0rX4fx66NS8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA1PR11MB8151.namprd11.prod.outlook.com
 (2603:10b6:208:44d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 21:43:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 21:43:23 +0000
Date:   Thu, 5 Jan 2023 13:43:20 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "kernelorg@undead.fr" <kernelorg@undead.fr>,
        "kjhambrick@gmail.com" <kjhambrick@gmail.com>,
        "2lprbe78@duck.com" <2lprbe78@duck.com>,
        "nicholas.johnson-opensource@outlook.com.au" 
        <nicholas.johnson-opensource@outlook.com.au>,
        "benoitg@coeus.ca" <benoitg@coeus.ca>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "wse@tuxedocomputers.com" <wse@tuxedocomputers.com>,
        "mumblingdrunkard@protonmail.com" <mumblingdrunkard@protonmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Box, David E" <david.e.box@intel.com>,
        "Sun, Yunying" <yunying.sun@intel.com>
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <63b7447883c75_51741294e5@dwillia2-xfh.jf.intel.com.notmuch>
References: <63b73f24c1a_517412943a@dwillia2-xfh.jf.intel.com.notmuch>
 <20230105213541.GA1171476@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230105213541.GA1171476@bhelgaas>
X-ClientProxiedBy: SJ0PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|IA1PR11MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d36546-0fc1-47cb-2455-08daef65de99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgWgJhyTQPb01QyEhCgpuT4/asPpsC9D6l1saMkTsEeOdoTrDpdUaZUAAfBhChNd9sGmhSLgIcH3fXqymmgz82xxrVOHMg+vSnEowDu15Bm5AqIULbQ/aYeVd1xjTMITtSGMpAIHxENBgIOJ+1GwKbHvlgp3x+RY2A55NT5m+bD3n/+4bgRcpMPDXG+Tk2qyKAutDE+larf8pgTZHOttM7JEaCk0CGDAXdeuO6I9ZSyuNyVB1vG0bu/FP14pK3peQFBTMNDzElfw2dLx051mo53IUcoWV2B5VuxNr77aY3qRUrQCDpX51y9STYZjE5Nw0hAZAK91NrBhNaeDUyFOhTZll76PyTi8zmkjebbs9OV4IGz7G+ArXECYpjRKX2IiPCTBo9P6z0N9EpfPcbkdYZqc0AGSDBEyw8EzBjVsY0ZuULOyFJMUnCUPijtE0IgkJiD6BE90byhI+Lrbxthu3/3ZpuqsHx2f4d3AQuBIOPi3yTdO3IHXWc1sBbg+Oug34rgyVr3pFv9HdlDX25w8g3c4e/PiP+njeTlsMmHD90oAKxPXj+jjZDa8AzxLpNWRvaJ9jlEKghg4ndQBQxcLYqiCdgjD8DN+GJbXi4edvOXz21x8iZpjdvDy5tz2CLXErO0bA7u0VfTU9wgOGhwYMOO3ZYNYJmI0ujrzUQZ7UJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199015)(5660300002)(2906002)(8676002)(7416002)(966005)(4326008)(41300700001)(8936002)(316002)(66476007)(66946007)(54906003)(110136005)(478600001)(66556008)(6486002)(186003)(9686003)(6512007)(26005)(6506007)(83380400001)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6/vpgrx4wsDqXc0AME4tprkly6BEydwl67GfZh4KR4LppaNq4iOG/KnQ5Ytf?=
 =?us-ascii?Q?ibiAtkl3lNXGQkAsLerJFPeVvBSFahdK33ymGEtH8OfzYUTkfy9ObQM+LyQV?=
 =?us-ascii?Q?1oDPmCO9E7yh8Wz/Xz1dBxfxqc5lczivVLyB3tlKqEa6NXNrs4B/qFH1evR9?=
 =?us-ascii?Q?4+3ff7uImNKP5sa91DM6AKYXrseVD4l8Er5hZYqXULxij+/nKZY/UQsDEXkN?=
 =?us-ascii?Q?eD7AIHXpxJnHhBraNQMCwhU2c8rpm+B5DMNwhLFugflf3k4j5oCEMRuLlKUA?=
 =?us-ascii?Q?4Bx3dR/d+5OHjbbjBNpc5Uo8IWqah65cAf1eSOkMsgaoQeIQJueSrKNqfCnQ?=
 =?us-ascii?Q?cXLLChJxAsHw4YgFCHQP3DkrVVUwxnN8JFIfzenVXNEPAHTkVWR6G3xqwZVO?=
 =?us-ascii?Q?eTvn8n4a2cSGETFxrJ2HpRDXVFxJy1EfnzCZUIZn7lp+AcmsRvFBAdAHY91X?=
 =?us-ascii?Q?5tZ1MU3K1oxaBlJ0lcfV2AAn9aln3+svj4fq9eMeoZjl7776IZbPEgsTwiGl?=
 =?us-ascii?Q?/0XINFjNM1vtwZH63wPGQXeTkEz+TYr/MhvZRrAqi6BkBs2ctjZfn6atUNXY?=
 =?us-ascii?Q?6MRDKfsbuMiTeSt88eOy8sLTF4LSWZB2efEF0EG0At6HrlBT3GOebou7JVRb?=
 =?us-ascii?Q?nGfJ5mgGvw+tyFIGExcZ8RXPc+N8IegUMaskMtsuhJZVjpSUZcpCstmC3Yxy?=
 =?us-ascii?Q?HwGzw9Gfd6Yua1jS9VNlI0IxTxhyJSU3KrHKki0m7YmfUVeabBiwmA1oks7O?=
 =?us-ascii?Q?6t8HalaWbi9H/7F4QpZRUU3sjia4VP3xhVPVlPpgREoqr0KcaZ8RWxciiTgC?=
 =?us-ascii?Q?0TzL5AVkJ4DbbCy8obh5gTy9wYOApBTtpVfSNlox5tZGGKqzQ8Hh4xdCI9wu?=
 =?us-ascii?Q?5RHQlIHQIP7MixDwbvF7srEt04GEdxBnXScemQPuMER9/rI/S9plUFZ6mCKq?=
 =?us-ascii?Q?mZVJLtnieaZzkGHvVcItGkE4gZ+cmRHk3YGDL/M7tO8ll7LrA6/n1PsLkaOK?=
 =?us-ascii?Q?QvLFGVxPHCY3rMS0dmOTtstMFPyot3M+gjRSnqbevWXqPq+OudihL3nW4F11?=
 =?us-ascii?Q?18ef0kJgLRD8jt3/aFNiHTz38pMMdC6AxQ8wv8Fpi1XSTiLGg+enY1HB8+PI?=
 =?us-ascii?Q?YpovKf9EhxHuKBDN41d47Sz5g8xUYSsDj9P/y0FUGELFbAaxdsemuCtp8eqO?=
 =?us-ascii?Q?T1hxZyCGHlbe0FvIZ0eAAo+jtWZhhXJWEoAm66t12SBIbDWmGxl3oxgVLh3g?=
 =?us-ascii?Q?/9B9ChqP0nQG8q76QImIVjNBNbwPPHhrOHt6lqyTrSVhoFCMqhPu+r59llgM?=
 =?us-ascii?Q?PPYLPvbysPAizkGpr+JKBuLMe6WTUwVUsa7ki0OfL6lPnlQSTaYdeB24BEDn?=
 =?us-ascii?Q?baEE+2YnZJRjT+/VKPXI3FZDDghNXFjX2Dkx41VYfVO73cCHyzXSVXXq9WTp?=
 =?us-ascii?Q?mpDzkv3+amYZ6yBgsJmehJp+s3cyVuWRxZuMYRCGJEj65tHZjRlPhOvCmG33?=
 =?us-ascii?Q?lp0kVPgPiZ673V/BSUW4wgFjSRu5r7ejE4blu55fjHRNCQSTf8CyUM5FXLb7?=
 =?us-ascii?Q?YdfFZpDUyUTCc5fZV/jztaiqYlmZ0E2KNTMyuF15pjq2O88eszBUkeiDTTAT?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d36546-0fc1-47cb-2455-08daef65de99
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 21:43:23.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19po8UXYZZYtnNh686oK8ocug6CFYz7WfVpDOn8YPKt35IVQbFud5jssTdR8mp7baozTHeAcNY31udLPJhACqlszUbcb/9WitxDsSA5OVhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8151
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas wrote:
> On Thu, Jan 05, 2023 at 01:20:36PM -0800, Dan Williams wrote:
> > Bjorn Helgaas wrote:
> > > On Thu, Jan 05, 2023 at 11:44:28AM -0800, Dan Williams wrote:
> > > > Bjorn Helgaas wrote:
> > > 
> > > > > Apparently the only mention of [mem 0x80000000-0x8fffffff] in the
> > > > > firmware/kernel interface is as an EfiMemoryMappedIO region.
> > > > > 
> > > > > I think this is a firmware bug, but obviously we're going to have to
> > > > > figure out a way around it.
> > > > 
> > > > Definitely an ambiguity / conflict, but not sure it is a bug when you
> > > > look at from the perspective of how would an EFI runtime service use
> > > > ECAM/MMCONFIG space? 
> > > 
> > > I think it's perfectly fine for firmware to advertise ECAM space as an
> > > EfiMemoryMappedIO region via EFI GetMemoryMap() because it certainly
> > > makes sense that EFI runtime services would use config space.
> > > 
> > > My understanding is that the OS should learn about device address
> > > space via ACPI _CRS, not GetMemoryMap().  The MCFG spec (PCI Firmware
> > > Spec, r3.3, sec 4.1.2) requires ECAM space to be reserved via a
> > > PNP0C02 motherboard device _CRS.
> > > 
> > > So what I think *is* a bug is that this firmware doesn't report the
> > > ECAM space via PNP0C02 _CRS.
> > > 
> > > If somebody thinks the lack of this reservation is not a bug, I would
> > > love to hear ideas about how Linux *should* be handling this.  There
> > > are many variations on how firmware does things like this, and it's
> > > been a nightmare trying to figure out something that works with all of
> > > them.
> > 
> > I am trying to get a statement from a BIOS person, but in the meantime I
> > am confused by this lead in sentence of Note 2 in "PCI Firmware Spec
> > v3.2 Table 4-2: MCFG Table to Support Enhanced Configuration Space
> > Access":
> > 
> >     If the operating system does not natively comprehend reserving the MMCFG
> >     region, the MMCFG region must be reserved by firmware. The address range
> >     reported in the MCFG table or by _CBA method (see Section 4.1.3) must be
> >     reserved by declaring a motherboard resource...
> > 
> > Which seems to say it is ok for the OS to treat MMCFG space as reserved
> > by default. It certainly fails the Robustness Principle for the BIOS to
> > *assume* that the OS can natively comprehend that reservation, but it
> > seems Linux is in its rights to make that assumption.
> 
> I read "OS natively comprehends MMCFG space" as meaning "the OS has
> device-specific knowledge of the PCI host bridge and the associated
> MMCFG space." But in that case, the OS wouldn't need MCFG at all, so
> maybe I'm not reading it right.
> 
> There must have been some reason for that sentence, e.g., some system
> that didn't or couldn't report MMCFG via PNP0C02 _CBA, but it sure
> makes a mess of what could have been a simple "range must be reserved"
> statement.
> 
> > > > Would it be enough to add this clarification in "EFI 2.9 Table 7-6
> > > > Memory Type Usage after ExitBootServices()"?
> > > > 
> > > > s/This memory is not used by the OS./This memory is not used by the OS,
> > > > unless ACPI declares it for another purpose./
> > > 
> > > I guess the idea is that MCFG is a form of "ACPI declaring it"?  I
> > > don't have an explicit citation for it, but I infer at [1] that ACPI
> > > static tables are second-class citizens and not intended as a way of
> > > reserving address space because that would lead to problems booting
> > > old OSes on firmware that provides new tables unknown to the OS.
> > 
> > Ah, true, certainly for new stuff, but what about MCFG specifically?
> > What harm is there an assuming that MMCONFIG intersecting with
> > EfiMemoryMappedIO shall be treated as reserved for MMCONFIG usage.
> 
> Probably none, and I think that's what we'll have to do.  Ugh.
> Another random special-case rule.
> 
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/acpi-info.rst?id=v6.1#n32

I am still holding out that a BIOS developer can either say "whoops,
populating MMCONFIG in _CRS was overlooked", or point out "if you take
the derivative of the PCI spec, multiply it be the inverse of the EFI
spec and then take the cross-product with the ACPI spec then the memory
type comes out as implicitly reserved".

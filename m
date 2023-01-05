Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E7965F59F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 22:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbjAEVU6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 16:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjAEVUo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 16:20:44 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1EF61450;
        Thu,  5 Jan 2023 13:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672953643; x=1704489643;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=09uu5kvJb+bNFia4S54H+qsFgtxXWrxYNUP8kD22YP8=;
  b=fF/K3MchoztPxn2yJlIQgGPL1jR7pu3X/PEKVJWSnjJ60dszX76K8yTb
   BRZbLNHs6swSozEQGgOR0PQyWxn+4mBTX0IWIsfmcakMSY+t7w6UtgIjb
   iQZigStSYQXLlZ95ZkyOAMy9N4MbBgRHE0GKObNZ6XneViejdRsBDNU4T
   XoM6ViGCEm5Y7V/kI7VY8j/WOYmJxbCxqlRCZ02YZCCnJ/bHeSYlUXDHc
   bId1eR5Pi2+8SAiBhJUv9w1+uHsM6Azh7tKpy0PeTGG2nQV2igFduz+QF
   0KFfqjHPe1U/mgMnOysgkOCJoOSLQWjSX+bAha42r0z6TG5C1JDi7g3Nu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="305848036"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="305848036"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="605684307"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="605684307"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2023 13:20:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 13:20:41 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 13:20:41 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 13:20:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwdgSH/AcOiKx+sMVnEAJoACIJ7ZDR6lRdsYw6lELSGJPB4iah1rowtS8QwAJqIa8VVFeTYNiadEhVuusnrS256vbyuRiwyQg/LYACj08Lng7roPsILrRZEK3pRnavRMf7l+vFhln+735k2njPq+8j+mZMk6aq35iKJ4e14dCDqLrC6knDNXt7iXb6mnZ4/7/9Lzw8e+BSjOdryqEb7CQXJFPP6n4K+NeJZRTIeOo69tFgWY4n+5fy9fM0XZ//ZivR/YznlgyxFttiysO414Co3juXrT0S3BTuFnprxLaOGFJC/qmfzjvCeUMs2omzUi6VVkaA9tQTQwZJpwhmBw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeqonrWpoWY+VVWrcy8uGR293hW2Gaw+2bfYF2LdUwA=;
 b=gl99fTBZO0jrAV1vpf3dWzgzVU6QJLqeYeatkOHphXW4nV/IsdyzHHCRDpEBZM5dATmPzOzX7cIgajGp/jVft3F7V+m2fivXT3778KTzNjxhlN2762xA6DWbUHvN3FGkT6lXf1ztSW9nkYxrXTp8Ev0vr5Se10xJGEZubfufDWt5z1yDIslRIjjFrUwfNX4ohkRWA63YXvI1XRT1yJrpg6EIfioGnRh2ZYindYW3vd/tQuLZPCjodmfRLoPy3Ws+EtF0YBKcivWnVHGwfbWWGRLwbgvyCCw8GNkoIvjQYQMhpcLq0ltv66767Y777rqiGwElLonXQVN5YwvC8zijFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA3PR11MB7533.namprd11.prod.outlook.com
 (2603:10b6:806:306::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 21:20:39 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 21:20:39 +0000
Date:   Thu, 5 Jan 2023 13:20:36 -0800
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
Message-ID: <63b73f24c1a_517412943a@dwillia2-xfh.jf.intel.com.notmuch>
References: <63b7289cb7439_5174129445@dwillia2-xfh.jf.intel.com.notmuch>
 <20230105202324.GA1165237@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230105202324.GA1165237@bhelgaas>
X-ClientProxiedBy: BYAPR08CA0062.namprd08.prod.outlook.com
 (2603:10b6:a03:117::39) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA3PR11MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: cceecb78-ea2e-4b60-c522-08daef62b176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkrRI3IEPo3QXGC7jEYeaVICw0FWDGtBjus1NCKx6Bw+9p7NjTbTItPLeNt6kJpPXogubo67Y9pDfFa2m9yKWkSUeu9gN0CqCNmt6wWecTsBJ1+Z+4BP8l+ajQ833Kwat/R3hRWTOWNlgczKEDYwo2xiEshS0o+eaLLAbn8oKeOurBWD0yuOt5TJnH53Dh2DvRwufIRpe9ojy9euaH1h9J1tWCSZPwmKSCZWfMgAd48J0k5SPBkXpatjEXxFbdlV5fwmctuZo/FMcjxzPyPDM5CE9S2fI8wifMU63F/w7JHTvFXp6zTEUv7Ij5J1/62oiLWFIlOBLTyfHuc55CzkNxtF4ya7hbfv1aXdpeAQ//uobJo/tZgDR3qcnVKo6hBFVrSly3JHa0MzMfYhIosZ5AEkS02IzYwuk3gJjggrbfQmf0HNJNEc+FGCUT4BDjFMXH8I4m3MhMfXpMvzJJk9JEgW0EF1A9XBucHtQRKOG6tYn0J1c8T8ep5uuObWW3H13T9sX6bjQLVF8kymFVPmBCFeKz6GdYbNkeBhljaJ7TAxFzI3A10AsPPFb8rrC8Z5r7wzzWFckzJICQh9Re0I8rdRlL0Nf3wpBsCJEvHkqfRW6x+bp8lfJfdKSEPke9oQi81+ulUzZl1w1D0wOfRvyAV2sp48BqEsBhKl7n91kv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(54906003)(186003)(110136005)(26005)(6666004)(66476007)(6486002)(66946007)(66556008)(9686003)(478600001)(6512007)(966005)(83380400001)(8676002)(8936002)(7416002)(5660300002)(41300700001)(2906002)(4326008)(316002)(82960400001)(86362001)(6506007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3j9TgjWsa22NRzR0q6Sc2yvegtF39ObC0W/outJ8L4XvuwX853Tt2PwJNu44?=
 =?us-ascii?Q?kdk+ErnlK2zIB+mO8VJHCB5NbP1ijGLEGMZGSBx+TW8xddAih5Q//rfrqpFj?=
 =?us-ascii?Q?LKuwz76ijEdCQtiE9tCwvzedkHyqj8HexLgGovE8rTMrNVSwb/G8FcS8HNSG?=
 =?us-ascii?Q?aKym1tvDPPC5hbChqcR8Ur1pUMuiLi3QlU1dsf4qbSL0sQFfOxfht5EKtrbM?=
 =?us-ascii?Q?to5oj88o9Hn0aHtjqZP8yqR64gvMZLr9zpRyOdOm/WSrrr/uX4He2SxV5UNq?=
 =?us-ascii?Q?MzksIF5dXsWC+29OVcIZApU4Dngo/xP5QZ9qYEMyiqjAW37H6k4JZpcu7B9s?=
 =?us-ascii?Q?vu3ZZ0qBm1cI+s1DFmNcdmjQWyWupa7bNiwNhVmLCNGTZAyfKmPgtEEMNMSO?=
 =?us-ascii?Q?VuYneuesFXl5x5oKJ0XgZK3QuVonXIsrHZcDRdJl1UXthpsmrGEto9dThmaM?=
 =?us-ascii?Q?VuBrqJqBLhF24UPLOAtu+LfG23C5Bfn6sqEc3dfhXXFDI4u28U/Wb0bwbM6t?=
 =?us-ascii?Q?kx03HER5YI9svNYr8wPNWFQAHqwPtmCRyKAyPhfc7GkufgIFxxGQcaFL5D8z?=
 =?us-ascii?Q?XCG2rRhHmOPSz/Lwa27eHTmpklru8xGzdimtj+QWZlOvsL4zP71dAnhut1Qm?=
 =?us-ascii?Q?OMBtCfrmCNHT+p8ykDhuJsUe/MJIzOAw/O8VKuH6WNI/f34ql1rsr3yKX5vV?=
 =?us-ascii?Q?ycX7+/jPbbGEZJ3KFdrxJgmT9nFItq6E7s3yxISfFRSfdsnc6RGlK6nKtuL6?=
 =?us-ascii?Q?WVJqKv1pHZTNcIaGGgFQAhyXCw2iByFgzuw6G8QHErgFmhlGkWFFSVh00k/p?=
 =?us-ascii?Q?GctL82YKQKMp3H61rSYDhbeOoR6wy5UP9MOHGgSGPA6Bfl8ZBQfHtm/2FEBL?=
 =?us-ascii?Q?fvaDbZTGj6fxrfenxoCsgxopuBOc4JnhYJrJLoBYHmNrPF5s58489VoDXces?=
 =?us-ascii?Q?3tK1dSxEWy7Ii2DzhoGiKkra8IAp6i2rNJHuSgwmsS0gklDQteKtpIBUJSHu?=
 =?us-ascii?Q?Un2iN8UwXWQ1veDYeAtb6SVOCZom7DtLismPUEoa62EULfVHAZgDUUDLAlU4?=
 =?us-ascii?Q?NBDG2EvV9tbN10glaZzY/O69wPNeXWm79fG96UKblwYxKR2pFCnPPAvX2Q4i?=
 =?us-ascii?Q?y6EOvEhOTg0OGpYpitZJEt0X0Nnwznp/KRaBlSZ0jt/RmmJNEbWnZuRvc0b/?=
 =?us-ascii?Q?AJba4Laa8Pd7A58ft0xa5ILXfK/kmob4RZkQPhxWVf7NZ1g7J8dAvh1aJ4Uv?=
 =?us-ascii?Q?PVfUwyvJI8S4wo3Wg3Mj3dJCo7vhQmlx+v3+oiiZ+vcEZlMgOfonkBT8eglO?=
 =?us-ascii?Q?T4gvEWR6FtpArshMzeYLt60x2sNNTeuIDH7p6Z1tyrjHtHHjrs6Ic/qO8Hp7?=
 =?us-ascii?Q?J1aBN4ZygOKbbxyfcGhFCKOkegeb2RqKtQeBDftXSROvFAcaNyoSEnCjwZdN?=
 =?us-ascii?Q?6qkz9K5Zf74twZ9Y2IsUw7HddMPKc7wcki+eLY9YUJ5XA7oNHee7JJbt7jwz?=
 =?us-ascii?Q?UpD5gRHs18OM5J/2AiLb9KpFX8ZPI7GKR0G5tT/R25M99ubbgu206HE9O6BY?=
 =?us-ascii?Q?kiYijkFqRh0KvId4bOEEVALRpFF+I7geMDuaadA2QA8+4jK8xISDDmGA/vok?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cceecb78-ea2e-4b60-c522-08daef62b176
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 21:20:39.1093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwaAbkEnl4iALqm9g3UcBLJWhhVhCQ64fBsLg4VIeSbgklMP/T+Ddq5ngqnQIVjwfuTjc5va2q/EpuQWYYV+lYYq6GNl/JA9RHHIzaI1tvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7533
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas wrote:
> On Thu, Jan 05, 2023 at 11:44:28AM -0800, Dan Williams wrote:
> > Bjorn Helgaas wrote:
> 
> > > Apparently the only mention of [mem 0x80000000-0x8fffffff] in the
> > > firmware/kernel interface is as an EfiMemoryMappedIO region.
> > > 
> > > I think this is a firmware bug, but obviously we're going to have to
> > > figure out a way around it.
> > 
> > Definitely an ambiguity / conflict, but not sure it is a bug when you
> > look at from the perspective of how would an EFI runtime service use
> > ECAM/MMCONFIG space? 
> 
> I think it's perfectly fine for firmware to advertise ECAM space as an
> EfiMemoryMappedIO region via EFI GetMemoryMap() because it certainly
> makes sense that EFI runtime services would use config space.
> 
> My understanding is that the OS should learn about device address
> space via ACPI _CRS, not GetMemoryMap().  The MCFG spec (PCI Firmware
> Spec, r3.3, sec 4.1.2) requires ECAM space to be reserved via a
> PNP0C02 motherboard device _CRS.
> 
> So what I think *is* a bug is that this firmware doesn't report the
> ECAM space via PNP0C02 _CRS.
> 
> If somebody thinks the lack of this reservation is not a bug, I would
> love to hear ideas about how Linux *should* be handling this.  There
> are many variations on how firmware does things like this, and it's
> been a nightmare trying to figure out something that works with all of
> them.

I am trying to get a statement from a BIOS person, but in the meantime I
am confused by this lead in sentence of Note 2 in "PCI Firmware Spec
v3.2 Table 4-2: MCFG Table to Support Enhanced Configuration Space
Access":

    If the operating system does not natively comprehend reserving the MMCFG
    region, the MMCFG region must be reserved by firmware. The address range
    reported in the MCFG table or by _CBA method (see Section 4.1.3) must be
    reserved by declaring a motherboard resource...

Which seems to say it is ok for the OS to treat MMCFG space as reserved
by default. It certainly fails the Robustness Principle for the BIOS to
*assume* that the OS can natively comprehend that reservation, but it
seems Linux is in its rights to make that assumption.

> 
> > Would it be enough to add this clarification in "EFI 2.9 Table 7-6
> > Memory Type Usage after ExitBootServices()"?
> > 
> > s/This memory is not used by the OS./This memory is not used by the OS,
> > unless ACPI declares it for another purpose./
> 
> I guess the idea is that MCFG is a form of "ACPI declaring it"?  I
> don't have an explicit citation for it, but I infer at [1] that ACPI
> static tables are second-class citizens and not intended as a way of
> reserving address space because that would lead to problems booting
> old OSes on firmware that provides new tables unknown to the OS.

Ah, true, certainly for new stuff, but what about MCFG specifically?
What harm is there an assuming that MMCONFIG intersecting with
EfiMemoryMappedIO shall be treated as reserved for MMCONFIG usage.

> 
> Bjorn
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/acpi-info.rst?id=v6.1#n32



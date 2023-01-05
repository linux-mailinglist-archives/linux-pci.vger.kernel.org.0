Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9220565F4C5
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 20:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjAETor (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 14:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbjAEToj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 14:44:39 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AA85F8E;
        Thu,  5 Jan 2023 11:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672947877; x=1704483877;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8VMLRwZlnfV8oNpd8pigWOAH5y6p24zIjoYnY70yor4=;
  b=IxACEqjNhljgPslskFreSDd0S8WQU6eNjcJrCLQmbwZL/7XJsvH8iwGD
   6zIbZSaRtkTFPXM6lBXJ6wgBUOkJ/Z04xODsrsETg0IYTVHSa0gq4VsbA
   jydKtnhUIrRLkuyEPf0cNPqwnJxL4cAZzZSeDbUC7EysbBn8aQ9d5CXvr
   sU7ADhP+Npw8arLncSM3WgP9Jew7zXWXxCym/gs2i50wQZr+ZVu7j1gUe
   mdK+HWbTQgb76V3eszYqDco1H/mFijQmwioTRxxNF7JUNZzY1ZiZEKr2x
   2UXBW/4KjJhCFqbq8IyuOCdkRY7KeUVktZC9L7A3OsXvwjLmhAY4+A7mT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="321017360"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="321017360"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 11:44:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="984426232"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="984426232"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jan 2023 11:44:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 11:44:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 11:44:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 11:44:34 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 11:44:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTLT/ahGqSJ5nkj+OC7WskxjznTZQlZjrrsxrgZ8JLovH199isbDpLy+6zf97n0XiIh/IHCrcIz8CjxFe2hoY5/6RYoZrVvAi8o0b6p2/ENLBbL1EYiBi3v1U1zb6Cxf9mQB62mn0GzZRUqEPz2w02cmTeD5P/jpmw+yddr/2Hn+MbXfDU/S6l4WNXRNqh6pYFQbnbu35s9RxtlBJnmKVKjE4U4b6WnNbXe3IsP1FjmoY2DVnS/y/vxbFkkmoQt9v8e620MhveKKAmgyxRQ3M+aBHydTcbIKbj506Njmes8CGIYmrf2WKZhgs6/LQhUWNIVBc0QBVcnlzMilfvPrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlPlyT33tog4opNDqgaoLY0EJjZWk9ZU10q/2BNfwn4=;
 b=XjXYQiznLR6p1WNUAxNQ/XF5ABrkKuMoRE2IOVvB8FiEAQH57PtACXYw/IZhZiWnY50Zxwx1pqXOVMwYaLOVt+6fPQsfOfiD9L/ISxJMc6myc8OvO7u2oFVvhcnuZFG7mn2WbCTugJ4aVgUaAPZKhXZ2N4CU62yCzHia0ki/rdAB18bWzVsCnLPZpG9JzzgPSm87JAKCDc06zl7vGsX8GchY9d5lzDt/qZXRA1T5rkHUaBWdviDonLrUP4cpTQcyWwTZsk9NZRuwhOC2YBrhi/Y6rTUC7QM7ZHLTrlEltOhVEwJM8WEIIQoqboivOFVtGW17D5fRQq6E8oZbTwGnGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL1PR11MB5544.namprd11.prod.outlook.com
 (2603:10b6:208:314::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:44:32 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:44:32 +0000
Date:   Thu, 5 Jan 2023 11:44:28 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>
CC:     "Liang, Kan" <kan.liang@linux.intel.com>,
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
Message-ID: <63b7289cb7439_5174129445@dwillia2-xfh.jf.intel.com.notmuch>
References: <SJ1PR11MB6083C504335B2DE1B31C440CFCFA9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230105182950.GA1158496@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230105182950.GA1158496@bhelgaas>
X-ClientProxiedBy: BYAPR11CA0101.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::42) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BL1PR11MB5544:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f74010-0172-4373-8c1b-08daef5543ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4Es4JsuT1w8ktwXhZ+55qRpRMqxw5B4GrqSxmKdMjhJnyngFNDWIMtAZg8EsvSOOSfCTY9P5kcw7jxeUl1Y94KuQ7Q+OLG0YQAz9vmV0gWOwtYqMEHIgUqpi94JTwYaHtuDtwZlykmDNAvg1PgZmUXPTJ3y+Y68hvJ6kzSXcCePnGhtoaKm9FwoSBH+W/JFLf7/yY/U0yysLZcoqIKxo2keP55r3xpA+lXAEOd/4JtuC4K4raYIfk+6wM5lE7zklT/7cdoVwzYDPLaqH0+Vg/DAT2dnWAiqInRjki15BJ+p3zFPBSJnlYB9/lFVTYWGTlnH1aGvN2HT5xuFslD8boKFXbiMs+1SasShsuMX2nRIhd8YBUSVUHkP3wXGGs+SgEUH7akmWrDJsxbiOGfvDe28xCp7rG+dVKu2lYk5Zkn/X8HGzcaVHQxa432qdhoCygOuODJAdpHmC6pJUJ4pYMzBbSoT0RMu88ZMBafHz3SqAQOTxwTlALYimULeEXoYDUDYHBEbUXm++P1h3yKrmZ+fitNvhdSGUw9Km587937351igJMp13gHnTrB5VqHwxSLf6BXXblvEFkK2Mr4HLV2QeCqdy94e8vxW1CgO4X+JD83IEMixkD/OyOS96QaxtAKhTCNab50AAKHPUrc+fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199015)(316002)(186003)(6512007)(6486002)(26005)(478600001)(9686003)(86362001)(6506007)(6636002)(110136005)(54906003)(6666004)(41300700001)(8936002)(2906002)(66476007)(83380400001)(8676002)(4326008)(82960400001)(7416002)(66946007)(66556008)(5660300002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aah7PS6aJXLGNgof43wV+mn15/vcQ/s5afhUQbnjFIKtEB++x1AkL/KHvPaK?=
 =?us-ascii?Q?KrTH1tpP/tty5voQeWz6N//yt6/2SC0G5UMf9c5LuhKcyonhYg+qP0/kUjAe?=
 =?us-ascii?Q?KLuKFEerBv8DdXMZIyUOGqJ/CRDJidDBvjzZ/lYP19j7LivZEggvtp3Nil43?=
 =?us-ascii?Q?vP1klhSvAD2dEMHo2BJfU1Kks9ryowKhs9lDfyvdUJGOJrgqj83yR21EwMXQ?=
 =?us-ascii?Q?T0BFFb6Mc9fkLYbfb65kiFNuMkiojnq+jOOkmnQlC6g94rs3iv3UNLrxPllN?=
 =?us-ascii?Q?zRmSbSM0X1KdTFp7SdvaoEOqGigDOAU8lZH7GQTfFEHKdlvnPVFzVQmk5vOw?=
 =?us-ascii?Q?WLRYDONHz/fUt0fcYzhAC3E4AyY47vteta7P7X5/XU/be/0pxdtJ9+KlmpJ9?=
 =?us-ascii?Q?vXKfg5tKxkX56Mrt87T/L05Kk+Vzs1Im3+/yAtWQczbZY99qVwzl02g4umEm?=
 =?us-ascii?Q?f69t+ZBWE3f8/qgxoLTfn2U3UPEFzQLtFUsCMulgCfxcysZDXneCxVYLZ7nu?=
 =?us-ascii?Q?LxRR2c4J+zdNhLYt/no3Cujc6pFOF+xQhD7yIDdf2NR8Kos9qK2pmuPgsikh?=
 =?us-ascii?Q?as7tiPvpKUjvGEJ8Bpio+dAj0PYsXoofKNWFKDwAvqvy/VApAz3gU5+9BU4j?=
 =?us-ascii?Q?4QJU7c0fzZBvtJPv26PBBEZLpDg7S9C3R0U3L8QHcozd6Wst3UwNYrSJ0zit?=
 =?us-ascii?Q?QTkDYeuxlUhXBGgnrCOa8HV5k1loeSnLn7LL74BwExQuPM+HGpW5srj+1pX+?=
 =?us-ascii?Q?Xypp+MRTXwxr+25x1X57lRZGez2VRJ0ZTNHimnG8FO+F91xaV2QnpJaGXONC?=
 =?us-ascii?Q?6Yy9iL7QniPClMwx6cHMgoRg3Np3fowqEn/tIMXC0RoD6clgCvK8+BtCKDgM?=
 =?us-ascii?Q?4maVDx/2i3K0X+OFCJHZK3LcUf6TZgv6Dw+XG8UsO7DYne1ewBLXYn8+KOCI?=
 =?us-ascii?Q?5PGB7ujFUuSPBK2Ks/B2/iM+HvPZMU0bIVdvguD5KW+oOD+Et6QcOr6XMYQI?=
 =?us-ascii?Q?YtKExATnH9qXlq9K07oglqSkDOfhWHWoBB5W6KNeWmwNFN5rbZ/qRQF0vK8n?=
 =?us-ascii?Q?a6P3ksKsejKYc2ed+yAWmGLt3I8HRN2pREbpP2rg5XL8Z0Kx2asI4ru8yFBn?=
 =?us-ascii?Q?GuCT6T3OT/shf2kVazQCHJKoXBnGSIhTYNJwfp55Xd1pG01YNrxyoU5uHF0Q?=
 =?us-ascii?Q?t6dLHBXEgPBT/bYImRBNFEW/k3rPw9irjrUYl39ty09a3ue+wYSHRzLVUk5C?=
 =?us-ascii?Q?KXAvz8LD4tcIKnXl+ZkX4h4FNXP6rrvuLqTE1y1nXx0E2Wer7fxyCZ/axrra?=
 =?us-ascii?Q?xNGrDGdYFLTafsDy4nCwvjMXsk6fb+Vxa7ScJXcxmC9ZpXW+D9HXrn8tT8K6?=
 =?us-ascii?Q?nZm9sFMxEAoNjNaFcX58BsH7msceff6YUt04ZPit+LKPm2UsX7Z4guxuoB3R?=
 =?us-ascii?Q?WgRgH5vH2NHNZCCmlJLNE6EAMLGwCdgqDS53uMvfa49ldroeajJXotILu6oP?=
 =?us-ascii?Q?fujYMRXDurCghhDqjKa91yhpSUW+AuDM7ut+TJlo8/N3Om/ATE4y9xhkYLse?=
 =?us-ascii?Q?Rie9xLBPEnE65pIMbOF+nmw6RB6DPSITQFthH1Py5x6A1VfD+jDUSSS9xrx+?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f74010-0172-4373-8c1b-08daef5543ed
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 19:44:31.9902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54ONQkSPaf3MVjfcxx6cLLlNJIIOlh20Fb4aRFZFnPpU+c4cy0aXvzbGDnBY/JTdSMEjGvo5ynm6YB5+mHDTO++J5tFj5bXsC8h1MHf5qNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5544
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
> On Thu, Jan 05, 2023 at 06:04:52PM +0000, Luck, Tony wrote:
> > > Hi Tony, can you share a dmesg log?  Does it look like the same thing
> > > Kan reported, where the ECAM space is reported only via an
> > > EfiMemoryMappedIO region and is not otherwise reserved by firmware?
> > 
> > Attached are serial logs. "broken" is the one from v6.2-rc2, "revert" is the
> > one with your commit reverted.
> > 
> > I don't see the string "ECAM" in either of them.
> 
> Yeah, "ECAM" is what the PCIe spec calls it, but Linux logging uses
> "MMCONFIG".  Probably should change that.
> 
> Anyway, your dmesg log shows the same problem:
> 
>   DMI: Intel Corporation BRICKLAND/BRICKLAND, BIOS BRBDXSD1.86B.0338.V01.1603162127 03/16/2016
>   efi: Remove mem48: MMIO range=[0x80000000-0x8fffffff] (256MB) from e820 map
>   PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
>   [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
>   PCI: not using MMCONFIG
>   acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
> 
> Apparently the only mention of [mem 0x80000000-0x8fffffff] in the
> firmware/kernel interface is as an EfiMemoryMappedIO region.
> 
> I think this is a firmware bug, but obviously we're going to have to
> figure out a way around it.

Definitely an ambiguity / conflict, but not sure it is a bug when you
look at from the perspective of how would an EFI runtime service use
ECAM/MMCONFIG space? 

Would it be enough to add this clarification in "EFI 2.9 Table 7-6
Memory Type Usage after ExitBootServices()"?

s/This memory is not used by the OS./This memory is not used by the OS,
unless ACPI declares it for another puporse./

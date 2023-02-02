Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED66168887C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 21:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjBBUpf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 15:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjBBUpK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 15:45:10 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52BF44A2;
        Thu,  2 Feb 2023 12:45:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFYICSOnbs0PQ4h6IQLnXyey4BfOAfJ6YlYMDYJZtfLbQTzdK/R9kk70WHpZTCS8WWyui6NtmzMHDpbXRdGRoTrXF52N4fNVaviszbfXE4asYbPIolicy/5kCZgC8JGZKld5MEIVmqEnyZbHTbWPm5qEOyQCcz4ZffFCG8Fp506k5OZswxWol8jp7r9AiDkYFCkBlCQc6A4U19bNb2quxStlF+UBBVVxiwvxBU0UVHI7TS44sDJX/4EJQFX5o2+LoLqfazM5sOXFIcxYVJcAMZCZvCtouyrmEWp0o54MAHQBfEWGMBnV6YrR2qkUfNCxNTsdyeFaLqNgyIQ1G1J10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sc/EkkgzaTbVSegKJWR0go/aHsDna1tV7OAYzPGrfqA=;
 b=Os0h6EgSbsBEZUedVdUjchpkV2sQLoig71utd1jiHVhh7c8SWUpx2BAj8jV9Uw10mNP96ii49zyZC4Yis1y2PnIakm5SloNvhi5K3wct8WoiFrppmI7myvjsk0scpHaJ1J1vbYKiBH57e+ROlAun8o8hZQM6wa44m0175Rb4SN+Dkn4rRWuQrHUZjT5o7XxxingO+Q/2a9n1Ddph0mMr1R6CM/LygtBRRBxEb9tQqAOUimOvtjO0BWPpSsRHwXzQbR3f1R2UzwyewkZwL0p0yNPAajRCiRz5W0h/HhOwf9SwDQ+b1sJrbDZBC7Yi6nySLs6bHOi8Oz+y8Zcc7QtYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc/EkkgzaTbVSegKJWR0go/aHsDna1tV7OAYzPGrfqA=;
 b=sRJ/lLu+fqm+hDN02YnWLTaHKpecdEyn32hepBODxH1LvuJHFCarKqh8xiBi5i0zMSotMApp+OK/xLSdk58EpujJbRE1cSN06laLx4+Q2wFwdplPFuyw9kI1gTe7OEn38yzxUPt7ShjoTXExJKHoZRMITvK0RWVgdZTH2+f3j695DW7EUh9xH5LYdMvSfcB65rR8y+gBNE3tPPu+E98X8bCi1pQyvHzj4Hbkx09uThp4ZazjwRoHJ6pW+ClcA34EpFvdTBYvIp/wcihjpy/S4LNsGcgO/gKLJ3L6epsFGCHWgCtZ1H+HwW+vuL6VoeiJ+zSla7iIUrsOmywEkP9/sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Thu, 2 Feb
 2023 20:45:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Thu, 2 Feb 2023
 20:45:06 +0000
Date:   Thu, 2 Feb 2023 16:45:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Message-ID: <Y9wg0Znc0tRWj4O9@nvidia.com>
References: <b75a5a94-a962-f88e-149e-7d23982a7ad2@linux.intel.com>
 <20230202201249.GA1963053@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202201249.GA1963053@bhelgaas>
X-ClientProxiedBy: BL0PR01CA0017.prod.exchangelabs.com (2603:10b6:208:71::30)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dcb0ae0-6456-42b2-346a-08db055e5e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kPbdDFrWeRLt2Ls/j7Yt0x5WH9XMK+4f1TYNdu94TIt++JCG23hlkonadHeahgCXPkq9rJJpOgT59w5V8JhLmrVQZG37lD273BNSBnTEi2JAZAxkW22VfitPBkSC9GxA88CKnKh726SQTr90CPF0YVzn8Nh7a2ecCEUvl9dstqtRDE1vLeHl9m9LgpxqfTyXmA+w7W6wGyTbiH9Kqg2vkBo/6lISNl0wiYdpvQg/rixI2bCwxlvR3WGxznodsMQODPGxKCiZHhJ3bH4XfaoQrndSk1gS7JVYbYN113Z8nlLEQ8ACm5W3LgzX3D5b6kamCGBpcaujKWth3LEM3slm70FfonDcGb2h2rx7BNaiQg26hkUT2jd6H4DbaC/EJsTNd+3zuoSwZRVnGEp14IF9uN067aeQKl5zsQvjvg3XNkk9tiRYjcMnyAT/FVv4Mps1OCgrEzNUje/csrgXqILjhd7TWszJnjnOa+Xbq0mKc9rKM+WucrvRG/sH0xFLqm25quoe2R9antbR6/gVxkfNh9+gJVOFpSs9ws/ztzUm2gTaOvfGQVycoW78mRs1NTcEfHYl0ST/0oPWosmoZXGsIRsxxit8jwXq3dZu3200mxX9P+8o+hmRjqbN6chCatipI0RQHOh2VDBmw5U251apPJKceisRkw0NcrVm5XjwJ4kq6CX25KQ7IYPrIXTgkU5/pBGBSIqMF5DixH1/sc9m3ZeScniJNR+utUVhWs6TSyc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199018)(966005)(2906002)(186003)(36756003)(6512007)(54906003)(26005)(316002)(2616005)(66946007)(6506007)(66556008)(66476007)(478600001)(86362001)(4326008)(5660300002)(6916009)(41300700001)(8936002)(6486002)(8676002)(38100700002)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nQ32V47ARvPgWnRGknLAGWNHs7PZn8y04q9UmhKezspY4DRiMgGSWYGTNpw3?=
 =?us-ascii?Q?8T+Z4LhrijgHLqNSi50e60qKsQkgZM2gy/+zKRJFFEU99edozNs5oEvEdMuT?=
 =?us-ascii?Q?6ULmquSfNiO5lVE5neQrdq52HkXi7/VkmZyestVXl7E4wrNIW0+6oNd7A150?=
 =?us-ascii?Q?SZRuFd4MKUG6AZMXt/HA5HPwc0jrOyIxERaOdPK7H820Zij0wOCIlepeh6G8?=
 =?us-ascii?Q?P5Nra/Ye8UM55fcG+xQBTIqppYtrFFNTvJMEZ958hLzFvMqsGdzLq6FyD55B?=
 =?us-ascii?Q?PtmiZ1j3I3VntF4zwg2iWRGwnpVndOPReUf455Fdo5fRsc33rALVZ4p1Huft?=
 =?us-ascii?Q?qwmOdAmpFQpAmJNlr5/uRr30+1Wpa+gaaToVNwOqHQ0Fn0xZg2ANyFmRWNG9?=
 =?us-ascii?Q?VzfmXWv8IasI9R4IKayB71ZBC1SvcBWz44O3+QO73IbfwSOwsUxucDzSDYhi?=
 =?us-ascii?Q?Rao0ZQcb6zUmEcJr+HcMTJ+Kcizqy2OG/MHcFZp2WOEIPtj1x2nG9keltNGX?=
 =?us-ascii?Q?v7okEnEbufcx8UcJ287GeJ6U/M5jtEXZHqnoJjvjv0IPdYU609IqJkIL7Pld?=
 =?us-ascii?Q?JWlMVdcas6Sk5+FC3WNng2ROML5Wb4cB9sRQjpcRHiOpbIqkxXDSyjqtvrcd?=
 =?us-ascii?Q?0I37QV0fHDjUa4tbY6Rd3V7fqld7xW1CB0dXOHerumMDU85ksNA/ZsX69rsX?=
 =?us-ascii?Q?x1Y6Nw26Xb9o3afMELn51fUFaWiYFsLyOqAnlSKXq9i3FFOH2hP1askGulOQ?=
 =?us-ascii?Q?Co2oT4I4NwYguvUuxQe69QHDQm8EhJbmYHHf9YoXmkeIIqjXIb4WB2fIRz0n?=
 =?us-ascii?Q?NThb7e/liELazLqLT39PDfx0NamRplN99T8jLRTof5t1NmgdRjL73RmPPzpH?=
 =?us-ascii?Q?21JqSEI9k1cRFoMyJ/WCGCxLpg/Fe1PfuQQVxjbwCoBvhUVHWPa8kVAHQkrr?=
 =?us-ascii?Q?iJk4uLBKbU6AF9iKOdGnlZkbb9VpeIUoMAjTbjnbsN/vWX5k0GOqRKQIGbwt?=
 =?us-ascii?Q?O99VBg4NXok2qhqCi2znO5AdjflNQVxqMEcnOQhaHoHCZU1cQ6ajqgYKOw5o?=
 =?us-ascii?Q?In+Fh6l8Sx7IT+FLodm90Mmayg4fGO2Pysnw52yWvlR8hSJEBVI8gSaC4WjV?=
 =?us-ascii?Q?UVs2WzjVbTXevSoJIQHQzyRtbHNsPKTjuzdWpf+Ga3zkkMRilu24vJORQvjW?=
 =?us-ascii?Q?NkJwxCzKSX8cbdlycmyMFNKXu0bizS4ouPdBsEdd9yziidCTgrPW6P5I/YLF?=
 =?us-ascii?Q?iomhhWP7SJxVOsQ2B+YHe3FTeoeiYNPFY/XlH0TYc3g/RtVkT1jlTn5iJD5b?=
 =?us-ascii?Q?8RARvo8UqeUq46jSAfIhnaK6uj/2dSYnZL5AutDX2NROooWp5SvfEjHa3ZQt?=
 =?us-ascii?Q?kjN7VKns87Z2PjGulXBZ1U0jd8LlDRGZFykllHhW3wtu6gFdkoQU2X4Vp4Ak?=
 =?us-ascii?Q?VuOwGyrOrdXyDCBeTRqtWmOP1nwdATKPx7HPXA+AxEVJ78OowpmCuRwymNCr?=
 =?us-ascii?Q?HPWkhz4MPb5STdDG0x8yc8F86hTiA22sYtrK7GDFDa70gTaAQgVsJmKJ4uMJ?=
 =?us-ascii?Q?2EmnEtJEmpOLtiFrdbN2M/byOw4slMesZ9wquak2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcb0ae0-6456-42b2-346a-08db055e5e0b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 20:45:06.7632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sablJoe/ahA3dZ79L3wTYaT+dlra+BJua4KQMZXhir9Ikh44NWaMl4wkWyxlM/ol
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 02, 2023 at 02:12:49PM -0600, Bjorn Helgaas wrote:
> [Joerg, you may be able to answer this.  Patch under discussion is:
> https://lore.kernel.org/r/20230114073420.759989-1-baolu.lu@linux.intel.com]
> 
> On Thu, Feb 02, 2023 at 11:08:25AM +0800, Baolu Lu wrote:
> > ...
> 
> > ACS is unnecessary for the devices that only use translated memory request
> > for PASID. All translated addresses are granted by the Linux kernel which
> > ensures that such addresses will never be in a P2P address, i.e., it's not
> > contained in any bridge aperture, will *always* be routed toward the RC.
> 
> Re 201007ef707a ("PCI: Enable PASID only when ACS RR & UF enabled on
> upstream path"), does that commit actually *fix* anything?  I wonder
> whether we could revert it completely.
> 
> The intent of 201007ef707a is to use ACS to prevent misrouting, which
> would happen if a TLP contained an address that *looked* like a PCI
> bus address, i.e., it was inside a host bridge aperture, but was
> *intended* to reach an IOMMU or main memory directly.

Yes.

> 201007ef707a only affects pci_enable_pasid(), so I think we already
> avoid this misrouting by restricting DMA address allocation for both
> non-IOMMU scenarios and non-PASID IOMMU scenarios.

There is no restriction on DMA address allocation with PASID.

The typical PASID use case is to point the PASID at the CPU page table
and then all VA's are fair game by userspace. There is no carve out
like the DMA API has to protect from bus address confusion.
 
> So what about PASID mappings, e.g., consider a mapping of (Requester
> ID, PASID, Untranslated Address) -> Translated Address?  If either the
> Untranslated Address or the Translated Address looks like a PCI bus
> address, a Memory Request or Translation Request could be misrouted.

The PCI rules are a bit complicated:
 - A simple MemRd/Wr with a PASID will be routed according to the
   address. This can be mis-routed
 - A ATS translation request with a PASID is always routed to the host
   bridge
 - A MemRd/Wr with Translated set and no PASID is always routed to the
   correct destination, even if that is not the host bridge

> Do IOMMUs allocate (PASID, Untranslated Addresses) that look like PCI
> bus addresses?

Yes, because it is mapped to a mm_struct userspace can use any mmap to
access any valid address as an IOVA and thus PASID tagged translation
must never become confused with bus addresses.

Further, and worse, the common use model for PASID SVA is for
userspace to directly submit IOVA to the device for operation. If
userspace can submit a hostile IOVA and cause DMA to reach something
that is not the host bridge then system security is completely
wrecked.

So, as an API in Linux we felt it was best to only enable PASID if
PASID is secure and truely isolated, otherwise leave PASID off. The
use cases for insecure PASID seem small.

Jason

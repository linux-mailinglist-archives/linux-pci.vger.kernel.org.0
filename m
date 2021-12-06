Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352A746994D
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 15:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344619AbhLFOrf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 09:47:35 -0500
Received: from mail-co1nam11on2073.outbound.protection.outlook.com ([40.107.220.73]:40896
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344474AbhLFOrQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Dec 2021 09:47:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1kCNn5SRr5wn8G8svUlJeunx6ruAZHBa5ueFngc6TAyPB5tDubOZhiu+1FmmnKTcsycjIfxTXhgNJQ0VE5OZ0grLoWHeqM/tzTC7aC2OYMbgnIWU/HqeLlJlG2QfR1T8XZPb4pEy54IepK9ZMLEcqNIDb3oXoJVGHEeRTaNQfzRPE8GoC5ayc+fyeRjdC1Vr7K0JAPdBmWSXMOUmI4tONMzOzj1dTHz95ss7LvKOrBQS/Rf8YRRTZS3f04cHWhTj8lX246jP1/A+R5K+B+cmkinLEJ5l6jZbmUs4ADaZDavzZZ1mKpKPm5Ji+5xTViL8vi8mo5NjnDpYRtAiCP6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvLO2e8tfQbCvqjkjhdknlVxZI+DudhinJjTBysuwa0=;
 b=jPFL9IXrfZz+++yawJN0aW0DbzWbZX52U7yZKI11C3fVAlf/7ALbGvqW/Qsxb5f5EiIUh3Ufr7AXpSwQL/OaWQpu0qQTWk0HnKW/jo371a+jIhKt/+Ug8PvbXD7qln9Z3yY5N0v8BBZ2h8EE4bqiAGdY/kTG5NybWy+oV7W7J0Ua3N3+4h1xlQZC0ye6I6JxjHoRnU3eI/FnbAX9I574FGXpZ4mMq4Pca2xlOfKyxc73k7NvJNrA5iaOGz3iJcOUv6J47zcin/D+gMWC0G1yTFS6rNuehoTezygcLPreymULoCcCGd7n/45KAww4DfoG62TvOeX9nKYgIEO8BWacdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvLO2e8tfQbCvqjkjhdknlVxZI+DudhinJjTBysuwa0=;
 b=U7YIHgwmphYCoHiagf1vrS768P2qZw4vFqkcbFySp1NPIZ8GGrazJBVESc8f5j3AL8RXqgliZuMrRnl+kleipCApPmlhAkNOR9JDfUpDszEKjwYtpUH/swwMYcR53lPE6AOiYqBNfJwCnEZJFRv/hxDm0BO4jBQavenlgFTOEFYU0DwtBOI4YnHoKMUlA6x4ak2zeLPBUlOiebVGnIe0k3QtSSqaBotxflag9PDHBsfIZ3FHRGUbBV+S+HLQDyooHrFdOvK0lEEl/9U2f3V6XjZ5MiM3GdDLIukuKE/gS4m/GA91TucST4CchBfL7PWnf9scbKk+HeiVggZPxSEOKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 14:43:45 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 14:43:45 +0000
Date:   Mon, 6 Dec 2021 10:43:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211206144344.GA4670@nvidia.com>
References: <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com>
 <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com>
 <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com>
 <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
 <87v9044fkb.ffs@tglx>
 <87o85v3znb.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o85v3znb.ffs@tglx>
X-ClientProxiedBy: MN2PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:208:134::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:208:134::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Mon, 6 Dec 2021 14:43:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muFDU-008wiJ-Ej; Mon, 06 Dec 2021 10:43:44 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1af8853-c827-4790-04f8-08d9b8c6ce50
X-MS-TrafficTypeDiagnostic: BL1PR12MB5143:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51430652F42404506CD6C3E1C26D9@BL1PR12MB5143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8jn/0k7Z4GwdhRqJq4xJgoJ8Wps59c87PU5fMawFm6i0qBiIgKZEKgTnuXo7QnN7EAyihn8LK2sWx9PKbCtcV8a4+b5dZJXaKc5o1rmSDO9zJEZ+W4MFzTUxbKTzw1GzcYLt9mhm88lOikayhG7vdRGszYj6BT+WhqybPb4nCdAgZhN/RAl0Zi9yIqYfFnfMpe43vBuC867d+J06eN1aoNlCR3dfBMXVDKZ3RTUCdA6UVJULC1/PeeIJAb8vS6ahcot7L7AQXA0MihUXpo+gDRXr3svn5FZEwF1CI9NvfVwqwz5HvZN3uuuKS+gQdAoN3HxA1f40K7TOz+X/BnrHK5Nk9fjIW8uVLaI1v6PFIcOmpq3R2ClcMpUCRM0ivUnyXUaYX2nmc1W9IoDjCM3CFSvBkp80fMhau8NfV1BZ29rKNSBi2QRUCPwUON7DMYdzaOdGMXR4hQMMk0j4nFlsupIPt5YSC3N2qhGw7l5IAw8DEII6aMnE0IKU6/eIwIHfwSIvTFKTSUi6B2ZNvCpRWH2WDrh53yWAmfFfveh+IDSXZ7Eu/GUe1oE2usfXZAGlAZXOp8lL3TKYxStRxWiC+O1oJyzex2w7ZXaJDSqlthLFm7JPYYWtfZoRCw+VEcDSzIElqAYc4QB3q/4F4++iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9786002)(83380400001)(9746002)(5660300002)(316002)(66476007)(38100700002)(66946007)(2906002)(2616005)(36756003)(8936002)(8676002)(66556008)(4326008)(33656002)(86362001)(508600001)(1076003)(7416002)(426003)(6916009)(26005)(54906003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xtjaTW3LbxKPwaytrsRpiiLLvoXvUioT5dq3d5nuY2rvR0LbFclXy4IU8J+W?=
 =?us-ascii?Q?RN1z4T7jmUkOqSU4IjKjyfaMpWlwI7Mqg7+Q2um5DeND/+RTLt5owmc64szt?=
 =?us-ascii?Q?1V3NlQWZx28wK9vlWtjSeiU1kPaNUrgSielK9fEGS6Odw3Y1EWw7MA4Y0z72?=
 =?us-ascii?Q?zgcOfec2U99y5tHFhmKfFfvUtNno9LQlBK7tYDtrhJ8s+FNAdAb4o1A68050?=
 =?us-ascii?Q?m3Xb/REprEGLRJAYAPNBJL1Nkcq8sTHKFJO8mfWVD3+M9bfgG9Ipa+oa69uH?=
 =?us-ascii?Q?7i43I+O4MKwt+55ZuggdnggzPYxeYLwXcncX9GDbYn+LvEI6JzXRkTEiBnHQ?=
 =?us-ascii?Q?hlBpvV0FNNRgg/GK7W9i5RM+HdOaLaEYBXYoTXKgpi43CWSPfFqgdy5ty4Ty?=
 =?us-ascii?Q?6jr43LntIQ+xZP1RETX3FH6ugs22VYR4VtjSyOPVXRu2obsB2Huj3o1lq/ZK?=
 =?us-ascii?Q?mgqfI1NkHffDfLNxM5wVQZ5gGQaz+gX1GGr9u9vjHLILTqlIjg1GYlF8+XHW?=
 =?us-ascii?Q?erWtqycfabCT43Jy6eUYLmX3SXrHdHwKvcbhJhflae3WC7NuQG21+euU+E+u?=
 =?us-ascii?Q?n7mV2WsgtJVxJqh7o1TAt7kUb+5hGvpmZnXKwy4WotjHD1z9dM4mMLhsrEOM?=
 =?us-ascii?Q?68umlOSPacVahTcARu7tdvPHfJNdGnGJqSOsSMfVDvK4Qxr+T8Ytx6BNEDni?=
 =?us-ascii?Q?EbFYbKUpZKRpTcbBpQTT8uF44OUy3Af4wgi9L4OJjMQwrQl61FDOBoDEDvGb?=
 =?us-ascii?Q?HHR0bfrSnmpYOdxfYNanNJ8/sceRRA1bfkOefPkkzV9n553Pk/TOU4APXW1a?=
 =?us-ascii?Q?PirFnRoFzpu5FPPS+Bz5/HuVBSC5lP4e3yy4vwhbcaPNl2daAu5AFZgj29kf?=
 =?us-ascii?Q?I6//e1rqv1e6NpdwpnJ0ztnCn/r6avW4xYV1eCYZZlK4C7OW+cAror5aQXru?=
 =?us-ascii?Q?W4czXR5UkqcHRQ9y4bcGlfoBExh21FUtojCgJgZLoiwNY2BO2f5o77/ZPKE3?=
 =?us-ascii?Q?A0tAoU09s8us+jStH1MrdY3YYMmIAvEhO2fkQFRirhFY8gIoykYEUSGQsJdW?=
 =?us-ascii?Q?NIW0UuG45d3DRhhkYSsU0uVlntW2MZ4/qr5DhRisiRGRHAh5qWrqMfz1oZWe?=
 =?us-ascii?Q?jGa8Y5/yRsTya9DveSdhwa9xCy3x0UXfWlEtD9QnNNpbh/XjpXTC/XK5DHnJ?=
 =?us-ascii?Q?IE6gu8oYMZN9kx2gEqKA1HG3kKiei0yeJgxPIvF/YRy/spe0VyXABvOAGmhs?=
 =?us-ascii?Q?NeqMUlrWE9RNa3PDADDCTRku8v+zThIyhB4EElfhrAsLihtexLWvepzf6e6f?=
 =?us-ascii?Q?hIW7SBtFK5ciFubBnu+oEJdi/5C29jB2Zn0XgQTEerEt3jwgfJFyncbC7qjS?=
 =?us-ascii?Q?O5tqnGNUZu5OgI3ryASeib7Q7LPqFMWxwYSfesfk25uFcyITaVWt1qPcEmG/?=
 =?us-ascii?Q?SI5ULFGPcI0hfIWpBNuvRrFI5oSqJqZlEwbJXBHzWLfnbN/KhHoQ1DyyrwQx?=
 =?us-ascii?Q?BWhhv1fd8m62r1kt5c+awaXb0w7DatVmIf6A7kTe7eNKRiXOQEvjFy59YtAf?=
 =?us-ascii?Q?O3Z+2QY8LtgGLnXUbxA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1af8853-c827-4790-04f8-08d9b8c6ce50
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 14:43:45.7146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBg/pblg7MWgcGJvI4KoWN0Dspl/GMRU2QnG2cLMRAMpD396xwdUl740pHFKLRzK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 05, 2021 at 03:16:40PM +0100, Thomas Gleixner wrote:
> On Sat, Dec 04 2021 at 15:20, Thomas Gleixner wrote:
> > On Fri, Dec 03 2021 at 12:41, Jason Gunthorpe wrote:
> > So I need to break that up in a way which caters for both cases, but
> > does neither create a special case for PCI nor for the rest of the
> > universe, i.e. the 1:1 case has to be a subset of the 1:2 case which
> > means all of it is common case. With that solved the storage question
> > becomes a nobrainer.
> >
> > When I looked at it again yesterday while writing mail, I went back to
> > my notes and found the loose ends where I left off. Let me go back and
> > start over from there.
> 
> I found out why I stopped looking at it. I came from a similar point of
> view what you were suggesting:
> 
> >> If IMS == MSI, then couldn't we conceptually have the dev->irqdomain
> >> completely unable to handle IMS/MSI/MSI-X at all, and instead, when
> >> the driver asks for PCI MSI access we create a new hierarchical
> >> irqdomain and link it to a MSI chip_ops or a MSI-X chip_ops - just as
> >> you outlined for IMS?  (again, not saying to do this, but let's ask if
> >> that makes more sense than the current configuration)
> 
> Which I shot down with:
> 
> > That's not really a good idea because dev->irqdomain is a generic
> > mechanism and not restricted to the PCI use case. Special casing it for
> > PCI is just wrong. Special casing it for all use cases just to please
> > PCI is equally wrong. There is a world outside of PCI and x86. 
> 
> That argument is actually only partially correct.

I'm not sure I understood your reply? I think we are both agreeing
that dev->irqdomain wants to be a generic mechanism?

I'd say that today we've special cased it to handle PCI. IMHO that is
exactly what pci_msi_create_irq_domain() is doing - it replaces the
chip ops with ops that can *ONLY* do PCI MSI and so dev->irqdomain
becomes PCI only and non-generic.

> After studying my notes and some more code (sigh), it looks feasible
> under certain assumptions, constraints and consequences.
> 
> Assumptions:
> 
>   1) The irqdomain pointer of PCI devices which is set up during device
>      discovery is not used by anything else than infrastructure which
>      knows how to handle it.
> 
>      Of course there is no guarantee, but I'm not that horrified about
>      it anymore after chasing the exposure with yet more coccinelle
>      scripts.

OK


> Constraints:
> 
>   1) This is strictly opt-in and depends on hierarchical irqdomains.

OK

>      That means that devices which depend on IMS won't work on anything
>      which is not up to date.

OK - I think any pressure to get platforms to update their code is
only positive.
 
>   2) Guest support is strictly opt-in
> 
>      The underlying architecture/subarchitecture specific irqdomain has
>      to detect at setup time (eventually early boot), whether the
>      underlying hypervisor supports it.
> 
>      The only reasonable way to support that is the availability of
>      interrupt remapping via vIOMMU, as we discussed before.

This is talking about IMS specifically because of the legacy issue
where the MSI addr/data pair inside a guest is often completely fake?

>   4) The resulting irqdomain hierarchy would ideally look like this:
> 
>      VECTOR -> [IOMMU, ROUTING, ...] -> PCI/[MSI/MSI-X/IMS] domains

OK, this matches where I have come from as well
 
>      That does not work in all cases due to architecture and host
>      controller constraints, so we might end up with:
> 
>            VECTOR -> IOMMU -> SHIM -> PCI/[MSI/MSI-X/IMS] domains

OK - I dont' know enough about the architecture/controller details to
imagine what SHIM is, but if it allows keeping the PCI code as purely
PCI code, then great

>   5) The design rules for the device specific IMS irqdomains have to be
>      documented and enforced to the extent possible.
> 
>      Rules which I have in my notes as of today:
> 
>        - The device specific IMS irq chip / irqdomain has to be strictly
>          separated from the rest of the driver code and can only
>          interact via the irq chip data which is either per interrupt or
>          per device.

It seems OK with the observaion that IDXD and mlx5 will both need to
set 'per-interrupt' data before provisioning the IRQ

>          I have some ideas how to enforce these things to go into
>          drivers/irqchip/ so they are exposed to scrutiny and not
>          burried in some "my device is special" driver code and applied
>          by subsystem maintainers before anyone can even look at it. 

Means more modules, but OK
 
>        - The irqchip callbacks which can be implemented by these top
>          level domains are going to be restricted.

OK - I think it is great that the driver will see a special ops struct
that is 'ops for device's MSI addr/data pair storage'. It makes it
really clear what it is

>        - For the irqchip callbacks which are allowed/required the rules
>          vs. following down the hierarchy need to be defined and
>          enforced.

The driver should be the ultimate origin of the interrupt so it is
always end-point in the hierarchy, opposite the CPU?

I would hope the driver doesn't have an exposure to hierarchy?
 
>        - To achieve that the registration interface will not be based on
>          struct irq_chip. This will be a new representation and the core
>          will convert that into a proper irq chip which fits into the
>          hierarchy. This provides one central place where the hierarchy
>          requirements can be handled as they depend on the underlying
>          MSI domain (IOMMU, SHIM, etc.). Otherwise any change on that
>          would require to chase the IMS irqchips all over the place.

OK, I like this too.

So we have a new concept: 'device MSI storage ops'

Put them along with the xarray holding the msi_descs and you've got my
msi_table :)

 
>   2) The device centric storage concept will stay as it does not make
>      any sense to push it towards drivers and what's worse it would be a
>      major pain vs. the not yet up to the task irqdomains and the legacy
>      architecture backends to change that. I really have no interrest to
>      make the legacy code
> 
>      It also makes sense because the interrupts are strictly tied to the
>      device. They cannot originate from some disconnected layer of thin
>      air.
> 
>      Sorry Jason, no tables for you. :)

How does the driver select with 'device MSI storage ops' it is
requesting a MSI for ?

>   1) I'm going to post part 1-3 of the series once more with the fallout
>      and review comments addressed.

OK, I didn't see anything in there that was making anything harder in
this direction
 
>   5) Implement an IMS user.
> 
>      The obvious candidate which should be halfways accessible is the
>      ath11 PCI driver which falls into that category.

Aiiee:

drivers/net/wireless/ath/ath11k/pci.c:  ab_pci->msi_ep_base_data = msi_desc->msg.data;

So, we already have two in-tree PCI IMS devices!!

Agree this makes a lot of sense to focus on some first steps

Along with NTB which is in the same general camp

Thanksm
Jason

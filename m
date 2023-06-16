Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596C17334B1
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 17:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345844AbjFPP2A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 11:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345470AbjFPP17 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 11:27:59 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52AA30C3;
        Fri, 16 Jun 2023 08:27:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-25ea635570eso703809a91.3;
        Fri, 16 Jun 2023 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686929278; x=1689521278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63uzoQ1syV2Wjj6k2aLXBVP/jt/qcihxF/TXUIXFfKY=;
        b=R/vvsw6dO5+cd7ZMkmRQW1awaW1LiARa5ShXvyQZiznK439y0ndjzpS1hW4Q/NPfty
         GujoNKgYSSFSbBaPbO+4OCa53Jobm17h0ZsAhjYFou+2QS2xVVcToyP066k1A3eKMGN+
         loUIPuql9zflzJn5TL/6D8fKmyz9y89xShKxHGkCliPDd08iIqtt11jSW0teRSlFgLTR
         3RWM4WfWaJ4wA6Ik1Zv9YqY1fwsRBTm8Q7+gsfJynbBzx7OL5tCfur7rw8EZdHVe3BKs
         pL6iHWf+WkcF4LDp3osGs5E+yEmzl+hmV9OxXRuNaUo0sVMIavCb1Dnuk0Ymat0T9gqf
         4uPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686929278; x=1689521278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63uzoQ1syV2Wjj6k2aLXBVP/jt/qcihxF/TXUIXFfKY=;
        b=GZ1H8+CD8YkqulceAjmCwliQeje2N57gImZoBLc29RwMM2guIQOQqHPEawI854i3iL
         4/shilEdDn66J5F3D4fdXtFVRdt2M0a6luZfqd/9NQWeryk1RYTMRBiEoFfrEyq1K9Fm
         SFC+fW7iofYlr2dEB78qejX94FS1b/8HdJlz8Vrb5t/lkyH+hwFTU72Y61u5D0HbNA9i
         5ybm4TlQzl9injx3ub6UmDIV08QWGUqZ+l6YHJ2AcZDIcB/GI5EbBS6sDYD6i4nRpuyi
         tTx3cVU9yUN3rvPpl4v1YAFR7edlbe8na5NbYdgnD/GfdYaQAPmT9MCWEP+RZWAlWpcD
         iS1Q==
X-Gm-Message-State: AC+VfDxZZ2Fa68qXemg4zMhA4nmup7R/YP+8d/fjPz1UtjX5qFcD7atk
        mpr8KQ750PrCscBzr8Ih9BnzFG1ku/GCd3ZJoZM=
X-Google-Smtp-Source: ACHHUZ7ggszHILJHBCELxrQm3UBlmG1caxb6nfkSLisF+66VB9JrJhRoC4YcIxZ7claF4N14nncmru4ukHL/5Q8h3T4=
X-Received: by 2002:a17:90a:6c63:b0:25b:fbdc:dd8 with SMTP id
 x90-20020a17090a6c6300b0025bfbdc0dd8mr1902431pjj.24.1686929277972; Fri, 16
 Jun 2023 08:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com> <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com>
 <ZIiRK2Dzl2/9Jqle@ziepe.ca> <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZIxTmGU4a5dniEY3@nvidia.com>
In-Reply-To: <ZIxTmGU4a5dniEY3@nvidia.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 16 Jun 2023 08:27:21 -0700
Message-ID: <CAKgT0UfmdOOPSD5YvpHnh1A02URn9zxVLbyXJM_67On7xojLcA@mail.gmail.com>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 16, 2023 at 5:20=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Jun 16, 2023 at 08:39:46AM +0000, Tian, Kevin wrote:
> > +Alex
> >
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, June 13, 2023 11:54 PM
> > >
> > > On Thu, Jun 08, 2023 at 04:28:24PM +0100, Robin Murphy wrote:
> > >
> > > > > The iova_reserve_pci_windows() you've seen is for kernel DMA inte=
rfaces
> > > > > which is not related to peer-to-peer accesses.
> > > >
> > > > Right, in general the IOMMU driver cannot be held responsible for
> > > whatever
> > > > might happen upstream of the IOMMU input.
> > >
> > > The driver yes, but..
> > >
> > > > The DMA layer carves PCI windows out of its IOVA space
> > > > unconditionally because we know that they *might* be problematic,
> > > > and we don't have any specific constraints on our IOVA layout so
> > > > it's no big deal to just sacrifice some space for simplicity.
> > >
> > > This is a problem for everything using UNMANAGED domains. If the iomm=
u
> > > API user picks an IOVA it should be able to expect it to work. If the
> > > intereconnect fails to allow it to work then this has to be discovere=
d
> > > otherwise UNAMANGED domains are not usable at all.
> > >
> > > Eg vfio and iommufd are also in trouble on these configurations.
> > >
> >
> > If those PCI windows are problematic e.g. due to ACS they belong to
> > a single iommu group. If a vfio user opens all the devices in that grou=
p
> > then it can discover and reserve those windows in its IOVA space.
>
> How? We don't even exclude the single device's BAR if there is no ACS?

The issue here was a defective ACS on a PCIe switch.

> > The problem is that the user may not open all the devices then
> > currently there is no way for it to know the windows on those
> > unopened devices.
> >
> > Curious why nobody complains about this gap before this thread...
>
> Probably because it only matters if you have a real PCIe switch in the
> system, which is pretty rare.

So just FYI I am pretty sure we have a partitioned PCIe switch that
has FW issues. Specifically it doesn't seem to be honoring the
Redirect Request bit so what is happening is that we are seeing
requests that are supposed to be going to the root complex/IOMMU
getting redirected to an NVMe device that was on the same physical
PCIe switch. We are in the process of getting that sorted out now and
are using the forcedac option in the meantime to keep the IOMMU out of
the 32b address space that was causing the issue.

The reason for my original request is more about the user experience
of trying to figure out what is reserved and what isn't. It seems like
the IOVA will have reservations that are not visible to the end user.
So when I go looking through the reserved_regions in sysfs it just
lists the MSI regions that are reserved, and maybe some regions such
as the memory for USB. while in reality we may be reserving IOVA
regions in iova_reserve_pci_windows that will not be exposed without
having to add probes or adding some printk debugging.

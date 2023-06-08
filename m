Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BDA728603
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 19:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjFHRLf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 13:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjFHRLe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 13:11:34 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4862136;
        Thu,  8 Jun 2023 10:11:33 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-256422ad25dso496623a91.0;
        Thu, 08 Jun 2023 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686244292; x=1688836292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0Xr4K9cnwEpUv2AEzAchReOMWS0DSH3sD0+mXFGpWo=;
        b=RTmafsJXiePGF8irS2bY69S+2DNvF7JkfDRkolowy2mCdE04SytlAbWK6TFybEi5u1
         7yrCDn711JWYYfrjeb5DKoiOFsw74XM9+jCGBupXNL5JKYfdWCuYUfL8fJNqMZB63Grh
         luI/ZWF9Tz8lT5rOzyW3HzwDFiu/M5GFY/KR4VguUrwB8h/ileAoXKoG5CqDjtKDekKZ
         J9kzFhUogqtKYYGM4qMG2+wZHbnPzG91KAMuTqqQC6wqsN80GlilfUrmn4AI1i2W3Uem
         dXo3LJk3bzJjDLtlGTeyQKlOLTKJuhhYxtISKDWHRTxlWg3Ny379NQbbBArDJ90RfrVY
         2roA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686244292; x=1688836292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0Xr4K9cnwEpUv2AEzAchReOMWS0DSH3sD0+mXFGpWo=;
        b=X0pmfTahP5zi1avzeBPyVEVJrjOfm/5xz/H4ksrh4j1qKJjLuH4s/5ov85ci4xJSdu
         DREg8pPoyG0NmSaiXd4M5jVIg0js4/krotyalD+Jdi5TXMDkU2Ch8EPdX5INWwU26vE5
         Q/rfR97ZhFAukgW+VaBbyBIxYliuiItb7dFqW8aNHbW2KaZLDExEC5yL6eDu46aH014U
         RObEuS9SRJFQ7A/JKcmDJq7OdyN6B7ory1Bs6iYn8yX24sJ7lQri7Nt2ZzgygDmeCJXR
         l0l1XvMKD8xdapGGYPLKQJUSWruHTs0TG9E1GwY4XZEgvqYqJGQvvIJueKPqLdcIxJYP
         dXqg==
X-Gm-Message-State: AC+VfDyoVpKl1MiZ+7hk9tNA2Aa2gX0ynvkoQAf66dCd9HveRtNI01qq
        thItNL6xyrUbHQjVXhVEZDt58EgW5HYRpiJHjTSsbxQQzDo=
X-Google-Smtp-Source: ACHHUZ4sdjpiZcRrkp65Zj15eLf3o8W8T5TXQT0V1GcFJoTVDeImzDv5CpwKS97p0BlwMInw+BM/CWE+sxtaETQfxB4=
X-Received: by 2002:a17:90b:811:b0:259:3f3c:99cc with SMTP id
 bk17-20020a17090b081100b002593f3c99ccmr4366962pjb.21.1686244291715; Thu, 08
 Jun 2023 10:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com> <CAKgT0UcE5bUe7ChytSyUWEkyqdwnNR1k_rcfyykPPWJ=ZzsdRg@mail.gmail.com>
 <ZIH1/e2OcCuD7DEi@araj-dh-work>
In-Reply-To: <ZIH1/e2OcCuD7DEi@araj-dh-work>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 8 Jun 2023 10:10:54 -0700
Message-ID: <CAKgT0UfTzExYZGNCEXCJaS7huWDxwoC3Z_2JCzJHAgr9Qyxmsg@mail.gmail.com>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
To:     Ashok Raj <ashok_raj@linux.intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev,
        Ashok Raj <ashok.raj@intel.com>
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

On Thu, Jun 8, 2023 at 8:40=E2=80=AFAM Ashok Raj <ashok_raj@linux.intel.com=
> wrote:
>
> On Thu, Jun 08, 2023 at 07:33:31AM -0700, Alexander Duyck wrote:
> > On Wed, Jun 7, 2023 at 8:05=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.c=
om> wrote:
> > >
> > > On 6/8/23 7:03 AM, Alexander Duyck wrote:
> > > > On Wed, Jun 7, 2023 at 3:40=E2=80=AFPM Alexander Duyck
> > > > <alexander.duyck@gmail.com> wrote:
> > > >>
> > > >> I am running into a DMA issue that appears to be a conflict betwee=
n
> > > >> ACS and IOMMU. As per the documentation I can find, the IOMMU is
> > > >> supposed to create reserved regions for MSI and the memory window
> > > >> behind the root port. However looking at reserved_regions I am not
> > > >> seeing that. I only see the reservation for the MSI.
> > > >>
> > > >> So for example with an enabled NIC and iommu enabled w/o passthru =
I am seeing:
> > > >> # cat /sys/bus/pci/devices/0000\:83\:00.0/iommu_group/reserved_reg=
ions
> > > >> 0x00000000fee00000 0x00000000feefffff msi
> > > >>
> > > >> Shouldn't there also be a memory window for the region behind the =
root
> > > >> port to prevent any possible peer-to-peer access?
> > > >
> > > > Since the iommu portion of the email bounced I figured I would fix
> > > > that and provide some additional info.
> > > >
> > > > I added some instrumentation to the kernel to dump the resources fo=
und
> > > > in iova_reserve_pci_windows. From what I can tell it is finding the
> > > > correct resources for the Memory and Prefetchable regions behind th=
e
> > > > root port. It seems to be calling reserve_iova which is successfull=
y
> > > > allocating an iova to reserve the region.
> > > >
> > > > However still no luck on why it isn't showing up in reserved_region=
s.
> > >
> > > Perhaps I can ask the opposite question, why it should show up in
> > > reserve_regions? Why does the iommu subsystem block any possible peer=
-
> > > to-peer DMA access? Isn't that a decision of the device driver.
> > >
> > > The iova_reserve_pci_windows() you've seen is for kernel DMA interfac=
es
> > > which is not related to peer-to-peer accesses.
> >
> > The problem is if the IOVA overlaps with the physical addresses of
> > other devices that can be routed to via ACS redirect. As such if ACS
> > redirect is enabled a host IOVA could be directed to another device on
> > the switch instead. To prevent that we need to reserve those addresses
> > to avoid address space collisions.

Our test case is just to perform DMA to/from the host on one device on
a switch and what we are seeing is that when we hit an IOVA that
matches up with the physical address of the neighboring devices BAR0
then we are seeing an AER followed by a hot reset.

> Any untranslated address from a device must be forwarded to the IOMMU whe=
n
> ACS is enabled correct?I guess if you want true p2p, then you would need
> to map so that the hpa turns into the peer address.. but its always a rou=
nd
> trip to IOMMU.

This assumes all parts are doing the Request Redirect "correctly". In
our case there is a PCIe switch we are trying to debug and we have a
few working theories. One concern I have is that the switch may be
throwing an ACS violation for us using an address that matches a
neighboring device instead of redirecting it to the upstream port. If
we pull the switch and just run on the root complex the issue seems to
be resolved so I started poking into the code which led me to the
documentation pointing out what is supposed to be reserved based on
the root complex and MSI regions.

As a part of going down that rabbit hole I realized that the
reserved_regions seems to only list the MSI reservation. However after
digging a bit deeper it seems like there is code to reserve the memory
behind the root complex in the IOVA but it doesn't look like that is
visible anywhere and is the piece I am currently trying to sort out.
What I am working on is trying to figure out if the system that is
failing is actually reserving that memory region in the IOVA, or if
that is somehow not happening in our test setup.

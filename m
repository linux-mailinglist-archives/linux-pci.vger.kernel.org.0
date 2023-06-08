Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B6B728702
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 20:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjFHSQc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 14:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjFHSQc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 14:16:32 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFBD2709;
        Thu,  8 Jun 2023 11:16:29 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77797beb42dso45033939f.2;
        Thu, 08 Jun 2023 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686248189; x=1688840189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dZE6f/Fvt9bX12/umBKYpGotal25L2oiGZhvdB1lQs=;
        b=LnNOYAtatL7DrkJpBJaaoIPyjspIfTltSQluWMWnqkoo662zXT7xiFL/59r/AkOJ0a
         +1twxNPMhgRVcs2gBd1LMu1OyEFz5uxmeJHW1Dibf5A6/TtwQI7YGL790R8klLGgFVB7
         VC7bPndag6EC0NK2uyO+jcvF8Q7IBwFCMQdwrRMggH3EoksMUkoqPLHW/32AyNdvnHYW
         6OAWiql6VK2miAb9+yCKT4yw/kn/TpYTeVBwSgyIDhjo4DgAt1vj5co3H2Ud5btwAozX
         RGNSRvGO1E7J0p5/7+/Z6rMb0H+r6tmmVmmBeMvK3T7Ntd2jof0y8EplAoUewm99hx0x
         1VzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686248189; x=1688840189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dZE6f/Fvt9bX12/umBKYpGotal25L2oiGZhvdB1lQs=;
        b=YLCbAeRHVeeJclvzR/RujkDtSmgmMAC5t5wZpSeKEl9tKczaGi1v67xm89WAdAd0Pl
         tPzr8h5sAHm+SfuCyoTnaK7BiUXAeNkZTQrERNHYSiJ4Vu3KqbArnDS+UqkqgU9KDE5/
         0n7kYdoNjItefgzAfEtG51AHkPc1DcA1VTRfuQrCiBOxRxunneoPA/JWWqu8KjjaT1GW
         Qrx+JzdpIog5V2c68Vkr72cUAanHUizXf0UPDfIO/Jmwd8JIgIT4NkPbbFr9kOeq2p64
         uq1L5eAvQo119+jgtfvPBR1DHPYAKqfKsC99CQZTiSOTvhAeAxlpGdkZFiRdpg6AEFWS
         w9SA==
X-Gm-Message-State: AC+VfDzUbGp7oMl3DSHwJDwAm0URVbp7/GMqMDX7bE55dcVDk4NW+p2N
        ZlgcLxavIjmIzuHDdjq+gP5goQ6Iqyv4CPX4ums=
X-Google-Smtp-Source: ACHHUZ7TyfNDlZ8WVOfrcirBR8KmLgf1C++aMYwdlC7qo/8hO7OfS9EImpuRoG0vFSucS4XNB/wG+zwfxLGIzPFJnqI=
X-Received: by 2002:a92:d9cf:0:b0:32b:1536:f3e9 with SMTP id
 n15-20020a92d9cf000000b0032b1536f3e9mr10424449ilq.18.1686248188772; Thu, 08
 Jun 2023 11:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com> <CAKgT0UcE5bUe7ChytSyUWEkyqdwnNR1k_rcfyykPPWJ=ZzsdRg@mail.gmail.com>
 <ZIH1/e2OcCuD7DEi@araj-dh-work> <CAKgT0UfTzExYZGNCEXCJaS7huWDxwoC3Z_2JCzJHAgr9Qyxmsg@mail.gmail.com>
 <ZIIVR2+rGemC7wlF@a4bf019067fa.jf.intel.com>
In-Reply-To: <ZIIVR2+rGemC7wlF@a4bf019067fa.jf.intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 8 Jun 2023 11:15:52 -0700
Message-ID: <CAKgT0Ue6xhwtRvk+sBUeinx4_mgPDoeyxLQ_2hrAVOeFMsxC6g@mail.gmail.com>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Ashok Raj <ashok_raj@linux.intel.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev
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

On Thu, Jun 8, 2023 at 10:52=E2=80=AFAM Ashok Raj <ashok.raj@intel.com> wro=
te:
>
> On Thu, Jun 08, 2023 at 10:10:54AM -0700, Alexander Duyck wrote:
> > On Thu, Jun 8, 2023 at 8:40=E2=80=AFAM Ashok Raj <ashok_raj@linux.intel=
.com> wrote:
> > >
> > > On Thu, Jun 08, 2023 at 07:33:31AM -0700, Alexander Duyck wrote:
> > > > On Wed, Jun 7, 2023 at 8:05=E2=80=AFPM Baolu Lu <baolu.lu@linux.int=
el.com> wrote:
> > > > >
> > > > > On 6/8/23 7:03 AM, Alexander Duyck wrote:
> > > > > > On Wed, Jun 7, 2023 at 3:40=E2=80=AFPM Alexander Duyck
> > > > > > <alexander.duyck@gmail.com> wrote:
> > > > > >>
> > > > > >> I am running into a DMA issue that appears to be a conflict be=
tween
> > > > > >> ACS and IOMMU. As per the documentation I can find, the IOMMU =
is
> > > > > >> supposed to create reserved regions for MSI and the memory win=
dow
> > > > > >> behind the root port. However looking at reserved_regions I am=
 not
> > > > > >> seeing that. I only see the reservation for the MSI.
> > > > > >>
> > > > > >> So for example with an enabled NIC and iommu enabled w/o passt=
hru I am seeing:
> > > > > >> # cat /sys/bus/pci/devices/0000\:83\:00.0/iommu_group/reserved=
_regions
> > > > > >> 0x00000000fee00000 0x00000000feefffff msi
> > > > > >>
> > > > > >> Shouldn't there also be a memory window for the region behind =
the root
> > > > > >> port to prevent any possible peer-to-peer access?
> > > > > >
> > > > > > Since the iommu portion of the email bounced I figured I would =
fix
> > > > > > that and provide some additional info.
> > > > > >
> > > > > > I added some instrumentation to the kernel to dump the resource=
s found
> > > > > > in iova_reserve_pci_windows. From what I can tell it is finding=
 the
> > > > > > correct resources for the Memory and Prefetchable regions behin=
d the
> > > > > > root port. It seems to be calling reserve_iova which is success=
fully
> > > > > > allocating an iova to reserve the region.
> > > > > >
> > > > > > However still no luck on why it isn't showing up in reserved_re=
gions.
> > > > >
> > > > > Perhaps I can ask the opposite question, why it should show up in
> > > > > reserve_regions? Why does the iommu subsystem block any possible =
peer-
> > > > > to-peer DMA access? Isn't that a decision of the device driver.
> > > > >
> > > > > The iova_reserve_pci_windows() you've seen is for kernel DMA inte=
rfaces
> > > > > which is not related to peer-to-peer accesses.
> > > >
> > > > The problem is if the IOVA overlaps with the physical addresses of
> > > > other devices that can be routed to via ACS redirect. As such if AC=
S
> > > > redirect is enabled a host IOVA could be directed to another device=
 on
> > > > the switch instead. To prevent that we need to reserve those addres=
ses
> > > > to avoid address space collisions.
> >
> > Our test case is just to perform DMA to/from the host on one device on
> > a switch and what we are seeing is that when we hit an IOVA that
> > matches up with the physical address of the neighboring devices BAR0
> > then we are seeing an AER followed by a hot reset.
>
> ACS is always confusing.. Does your NIC have a DTLB?

No. It is using the IOMMU for all address translation. I am also
pushing back on the test being used as well. It is always possible
they have implemented something incorrectly and are overrunning a
buffer going into the reserved IOVA region and the overlap is just a
coincidence.

> If request redirect is set, and the Egress is enabled, then all
> transactions should go upstream to the root-port->IOMMU before being
> served.
>
> In my 6.0 spec its in 6.12.3 ACS Peer-to-Peer Control Interactions?
>
> And maybe lspci would show how things are setup in the switch?

We were setting the Redirect Request only, no Egress. I agree, based
on the config everything should just go upstream. However if we
eliminate the switch or put things in passthrough mode the problem
goes away.

> >
> > > Any untranslated address from a device must be forwarded to the IOMMU=
 when
> > > ACS is enabled correct?I guess if you want true p2p, then you would n=
eed
> > > to map so that the hpa turns into the peer address.. but its always a=
 round
> > > trip to IOMMU.
> >
> > This assumes all parts are doing the Request Redirect "correctly". In
> > our case there is a PCIe switch we are trying to debug and we have a
> > few working theories. One concern I have is that the switch may be
> > throwing an ACS violation for us using an address that matches a
> > neighboring device instead of redirecting it to the upstream port. If
> > we pull the switch and just run on the root complex the issue seems to
> > be resolved so I started poking into the code which led me to the
> > documentation pointing out what is supposed to be reserved based on
> > the root complex and MSI regions.
> >
> > As a part of going down that rabbit hole I realized that the
> > reserved_regions seems to only list the MSI reservation. However after
> > digging a bit deeper it seems like there is code to reserve the memory
> > behind the root complex in the IOVA but it doesn't look like that is
> > visible anywhere and is the piece I am currently trying to sort out.
> > What I am working on is trying to figure out if the system that is
> > failing is actually reserving that memory region in the IOVA, or if
> > that is somehow not happening in our test setup.
>
> I suspect with IOMMU, there is no need to pluck holes like we do for the
> MSI. In very early code in IOMMU i vaguely recall we did that, but our
> knowledge on ACS was weak. (not that has improved :-)).

The hole has to do mostly with avoiding any possibility of misrouting
things, or at least that was my understanding after reading it.

> Knowing how the switch and root ports are setup with forwarding may help
> with some clues.  The easy option is maybe forcibly adding to the reserve=
d
> range may help to see if you don't see the ACS violation.
>
> Baolu might have some better ideas.

I'm working with the team having the issue to try and verify that now.
In theory it should already be reserved so I am working with them to
check that.

Thanks,

- Alex

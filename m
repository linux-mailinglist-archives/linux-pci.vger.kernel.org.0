Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D303F1E2A03
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 20:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgEZS1E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 14:27:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57033 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729298AbgEZS1E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 14:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590517621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ax77LQGS6LyswNoHPKq4ajIwd1zVpERIFMSwmKnqS4Y=;
        b=MB0X7jjj4/cdiadYZOmpck6vh05i7zKWALaQKPSNfcodwmIK9a3XK0xNf1g+/No8pEJ0ZW
        ydDDlwMdQYUsqDIOs5WZB4TOtD96dAzojrefhHCMRHUUhy4oF3904tgPEdNFYtx+x+5ug4
        ZJeZm7ovwX24TSmOJCRnteNjItFrBgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-f_e1aYZSMkGGMdw6_HUzVA-1; Tue, 26 May 2020 14:26:57 -0400
X-MC-Unique: f_e1aYZSMkGGMdw6_HUzVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13CF4107ACF5;
        Tue, 26 May 2020 18:26:56 +0000 (UTC)
Received: from x1.home (ovpn-114-203.phx2.redhat.com [10.3.114.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C3326FB6E;
        Tue, 26 May 2020 18:26:55 +0000 (UTC)
Date:   Tue, 26 May 2020 12:26:54 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Darrel Goeddel <DGoeddel@forcepoint.com>,
        Mark Scott <mscott@forcepoint.com>,
        Romil Sharma <rsharma@forcepoint.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: Relax ACS requirement for RCiEP devices.
Message-ID: <20200526122654.7ac087b3@x1.home>
In-Reply-To: <20200526180648.GC35892@otc-nc-03>
References: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
        <20200504231936.2bc07fe3@x1.home>
        <20200505061107.GA22974@araj-mobl1.jf.intel.com>
        <20200505080514.01153835@x1.home>
        <20200505145605.GA13690@otc-nc-03>
        <20200505093414.6bae52e0@x1.home>
        <20200526180648.GC35892@otc-nc-03>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 26 May 2020 11:06:48 -0700
"Raj, Ashok" <ashok.raj@intel.com> wrote:

> Hi Alex,
>=20
> I was able to find better language in the IOMMU spec that gaurantees=20
> the behavior we need. See below.
>=20
>=20
> On Tue, May 05, 2020 at 09:34:14AM -0600, Alex Williamson wrote:
> > On Tue, 5 May 2020 07:56:06 -0700
> > "Raj, Ashok" <ashok.raj@intel.com> wrote:
> >  =20
> > > On Tue, May 05, 2020 at 08:05:14AM -0600, Alex Williamson wrote: =20
> > > > On Mon, 4 May 2020 23:11:07 -0700
> > > > "Raj, Ashok" <ashok.raj@intel.com> wrote:
> > > >    =20
> > > > > Hi Alex
> > > > >=20
> > > > > + Joerg, accidently missed in the Cc.
> > > > >=20
> > > > > On Mon, May 04, 2020 at 11:19:36PM -0600, Alex Williamson wrote: =
  =20
> > > > > > On Mon,  4 May 2020 21:42:16 -0700
> > > > > > Ashok Raj <ashok.raj@intel.com> wrote:
> > > > > >      =20
> > > > > > > PCIe Spec recommends we can relax ACS requirement for RCIEP d=
evices.
> > > > > > >=20
> > > > > > > PCIe 5.0 Specification.
> > > > > > > 6.12 Access Control Services (ACS)
> > > > > > > Implementation of ACS in RCiEPs is permitted but not required=
. It is
> > > > > > > explicitly permitted that, within a single Root Complex, some=
 RCiEPs
> > > > > > > implement ACS and some do not. It is strongly recommended tha=
t Root Complex
> > > > > > > implementations ensure that all accesses originating from RCi=
EPs
> > > > > > > (PFs and VFs) without ACS capability are first subjected to p=
rocessing by
> > > > > > > the Translation Agent (TA) in the Root Complex before further=
 decoding and
> > > > > > > processing. The details of such Root Complex handling are out=
side the scope
> > > > > > > of this specification.
> > > > > > >    =20
> > > > > >=20
> > > > > > Is the language here really strong enough to make this change? =
 ACS is
> > > > > > an optional feature, so being permitted but not required is rat=
her
> > > > > > meaningless.  The spec is also specifically avoiding the words =
"must"
> > > > > > or "shall" and even when emphasized with "strongly", we still o=
nly have
> > > > > > a recommendation that may or may not be honored.  This seems li=
ke a
> > > > > > weak basis for assuming that RCiEPs universally honor this
> > > > > > recommendation.  Thanks,
> > > > > >      =20
> > > > >=20
> > > > > We are speaking about PCIe spec, where people write it about 5 ye=
ars ahead
> > > > > and every vendor tries to massage their product behavior with vag=
ue
> > > > > words like this..  :)
> > > > >=20
> > > > > But honestly for any any RCiEP, or even integrated endpoints, the=
re=20
> > > > > is no way to send them except up north. These aren't behind a RP.=
   =20
> > > >=20
> > > > But they are multi-function devices and the spec doesn't define rou=
ting
> > > > within multifunction packages.  A single function RCiEP will alread=
y be
> > > > assumed isolated within its own group.   =20
> > >=20
> > > That's right. The other two devices only have legacy PCI headers. So=
=20
> > > they can't claim to be RCiEP's but just integrated endpoints. The leg=
acy
> > > devices don't even have a PCIe header.
> > >=20
> > > I honestly don't know why these are groped as MFD's in the first plac=
e.
> > >  =20
> > > >     =20
> > > > > I did check with couple folks who are part of the SIG, and seem t=
o agree
> > > > > that ACS treatment for RCiEP's doesn't mean much.=20
> > > > >=20
> > > > > I understand the language isn't strong, but it doesn't seem like =
ACS should
> > > > > be a strong requirement for RCiEP's and reasonable to relax.
> > > > >=20
> > > > > What are your thoughts?    =20
> > > >=20
> > > > I think hardware vendors have ACS at their disposal to clarify when
> > > > isolation is provided, otherwise vendors can submit quirks, but I d=
on't
> > > > see that the "strongly recommended" phrasing is sufficient to assume
> > > > isolation between multifunction RCiEPs.  Thanks,   =20
> > >=20
> > > You point is that integrated MFD endpoints, without ACS, there is no=
=20
> > > gaurantee to SW that they are isolated.
> > >=20
> > > As far as a quirk, do you think:
> > > 	- a cmdline optput for integrated endpoints, and RCiEP's suffice?
> > > 	  along with a compile time default that is strict enforcement
> > > 	- typical vid/did type exception list?
> > >=20
> > > A more generic way to ask for exception would be scalable until we ca=
n stop
> > > those type of integrated devices. Or we need to maintain these device=
 lists
> > > for eternity.  =20
> >=20
> > I don't think the language in the spec is anything sufficient to handle
> > RCiEP uniquely.  We've previously rejected kernel command line opt-outs
> > for ACS, and the extent to which those patches still float around the
> > user community and are blindly used to separate IOMMU groups are a
> > testament to the failure of this approach.  Users do not have a basis
> > for enabling this sort of opt-out.  The benefit is obvious in the IOMMU
> > grouping, but the risk is entirely unknown.  A kconfig option is even
> > worse as that means if you consume a downstream kernel, the downstream
> > maintainers might have decided universally that isolation is less
> > important than functionality. =20
>=20
> We discussed this internally, and Intel vt-d spec does spell out clearly=
=20
> in Section 3.16 Root-Complex Peer to Peer Considerations. The spec clearly
> calls out that all p2p must be done on translated addresses and therefore
> must go through the IOMMU.
>=20
> I suppose they should also have some similar platform gauranteed behavior
> for RCiEP's or MFD's *Must* behave as follows. The language is strict and
> when IOMMU is enabled in the platform, everything is sent up north to the
> IOMMU agent.
>=20
> 3.16 Root-Complex Peer to Peer Considerations
> When DMA remapping is enabled, peer-to-peer requests through the
> Root-Complex must be handled
> as follows:
> =E2=80=A2 The input address in the request is translated (through first-l=
evel,
>   second-level or nested translation) to a host physical address (HPA).
>   The address decoding for peer addresses must be done only on the=20
>   translated HPA. Hardware implementations are free to further limit=20
>   peer-to-peer accesses to specific host physical address regions=20
>   (or to completely disallow peer-forwarding of translated requests).
> =E2=80=A2 Since address translation changes the contents (address field) =
of the PCI
>   Express Transaction Layer Packet (TLP), for PCI Express peer-to-peer=20
>   requests with ECRC, the Root-Complex hardware must use the new ECRC=20
>   (re-computed with the translated address) if it decides to forward=20
>   the TLP as a peer request.
> =E2=80=A2 Root-ports, and multi-function root-complex integrated endpoint=
s, may
>   support additional peerto-peer control features by supporting PCI Expre=
ss
>   Access Control Services (ACS) capability. Refer to ACS capability in=20
>   PCI Express specifications for details.

That sounds like it might be a reasonable basis for quirking all RCiEPs
on VT-d platforms if Intel is willing to stand behind it.  Thanks,

Alex


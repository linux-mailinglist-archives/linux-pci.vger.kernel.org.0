Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0571314BD86
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2020 17:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgA1QRN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jan 2020 11:17:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40547 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbgA1QRM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jan 2020 11:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580228231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uptct9L7oDr7as2Rox5ti4kkjwTSa4Vhf1QDW6/EMrc=;
        b=iGXjGkhGnnLkxPkk/kmJ6z9zyCw5FtI9W0mW1F8N8GZy7ikSOwGOYJ78eMbqAX2LNDfxGp
        w+KSHdAhS4cSgKLdTCAlvZu9i5eYLwTq9rIB7kWoI8O/JBhGcxqwYG9YxzxnlKR2/6Nsle
        GQIo1pTf0xKMLuQiIRI5h1//YKgoRhw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-2lVwnxP2PtmP-8vaGI4aSg-1; Tue, 28 Jan 2020 11:17:01 -0500
X-MC-Unique: 2lVwnxP2PtmP-8vaGI4aSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DBBF8010C7;
        Tue, 28 Jan 2020 16:17:00 +0000 (UTC)
Received: from x1.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4430F60C18;
        Tue, 28 Jan 2020 16:16:59 +0000 (UTC)
Date:   Tue, 28 Jan 2020 09:16:58 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Skidanov, Alexey" <alexey.skidanov@intel.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Heilper, Anat" <anat.heilper@intel.com>,
        "Zadicario, Guy" <guy.zadicario@intel.com>
Subject: Re: Disabling ACS for peer-to-peer support
Message-ID: <20200128091658.21682d6e@x1.home>
In-Reply-To: <BYAPR11MB2917B3A25964230EEE61F779EE0A0@BYAPR11MB2917.namprd11.prod.outlook.com>
References: <BYAPR11MB29171883468FD79722FF3652EE0B0@BYAPR11MB2917.namprd11.prod.outlook.com>
        <3b62f9d6-5b93-e252-3419-3fe5307f7935@amd.com>
        <c09a2da5-25e5-445c-3f34-ca6c96686130@deltatee.com>
        <1f3f0f67-865b-0657-da17-896c7b1053fb@amd.com>
        <66ed4842-348d-5bb0-52ba-0236f91ef935@deltatee.com>
        <BYAPR11MB2917B3A25964230EEE61F779EE0A0@BYAPR11MB2917.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 28 Jan 2020 07:13:01 +0000
"Skidanov, Alexey" <alexey.skidanov@intel.com> wrote:

> >On 2020-01-27 12:12 p.m., Christian K=C3=B6nig wrote: =20
> >> Am 27.01.20 um 17:58 schrieb Logan Gunthorpe: =20
> >>>
> >>> On 2020-01-27 1:18 a.m., Christian K=C3=B6nig wrote: =20
> >>>> Am 27.01.20 um 08:18 schrieb Skidanov, Alexey: =20
> >>>>> Hello,
> >>>>>
> >>>>> I have recently found the below commit to disabling ACS bits. Using=
 kernel parameter =20
> >is pretty simple but requires to know in advance which devices might be =
participated in
> >peer-to-peer sessions. =20
> >>>>>
> >>>>>    Why we can't disable the ACS bits *after* the driver is initiali=
zed (and there is a =20
> >request to connect between two peers) and not *during* device discoverin=
g?. =20
> >>>> That's exactly what was initially proposed but we have seen hardware
> >>>> which reacts allergic to disabling those bits on the fly. =20
> >>> I wasn't aware of that and haven't seen anything like that.
> >>> =20
> >>>> Please read up the discussion on the mailing list leading to this pa=
tch. =20
> >>> The issue was the IOMMU code does not allow for any kind of dynamic
> >>> changes in the groups devices are assigned in. In theory, this could =
be
> >>> possible but you'd still at least have to unbind the devices from the=
ir
> >>> driver because you definitely can't change the IOMMU group while there
> >>> are DMA requests in flight. Ultimately it's easier for most use cases=
 to
> >>> just disable it on boot. =20
> >>
> >> As far as I know you can't change the ACS bit either when there are
> >> transactions in flight on the affected devices/bridges. =20
> >
> >No, I think the ACS bits are fine to change at any time. I've never had
> >any issue changing them. The problem is the act of changing them changes
> >the isolation between the devices which means the IOMMU groups have to
> >change.
> >
> >It's certainly possible today to just use setpci to adjust those bits at
> >any time. It just means the isolation the IOMMU is expecting will be
> >wrong and that may mean you broke the security between VMs on your machi=
ne.
> > =20
>=20
> According to the PCIe spec, there are two mechanisms to deal with isolati=
on:
> - Redirected Request Validation logic within the RC and
> - ACS P2P Egress Control
> So anyone who cares about the isolation must use at least one of these me=
chanisms.=20
> I would expect that on VM creation, the above mechanisms will be configur=
ed appropriately.=20

Redirected Request Validation within the RC presumes that transactions
make it to the RC, and thus implies things like Upstream Forwarding,
Request Redirection, and Completion Redirection.  I think much of the
desire for P2P wants to avoid the RC entirely.  Also, this Redirected
Request Validation logic and control of it is not part of the PCIe
spec.  P2P Egress Control only allows blocking of P2P between select
downstream ports.  AIUI this is used in conjunction with P2P Direct
Translation to limit which direct translated paths are available to a
device.  DT on its own implies ATS, which has questionable isolation
security (ie. susceptible to an exploitable endpoint).  IIRC, it's also
been rejected in previous discussions that we could simply wait for
hardware that supports ATS and DT to build the direct P2P paths
desired.  There are also some arguable benefits to IOMMU isolation for
non-VM use cases, so let's not put blinders on to those aspects.

> >> Otherwise what could happen is that the response of an transaction tak=
es
> >> a different path than the request. That in turn can result in quite a
> >> bunch of ordering problem on the PCIe bus.
> >>
> >> But the idea of unbinding a device, changing the bit and rebinding it
> >> would probably work. =20
> >
> >Well, no, you can't just change the bit, you have to change the IOMMU
> >group the device belongs to. Right now, we don't have any interface to
> >do that except during scanning at boot.

Right, and groups potentially contain multiple devices and multiple
groups might be dependent on the isolation of a given interconnect,
which means the scope of modifying that grouping may involve unrelated
devices and drivers, which feeds into that boot-time restriction.  We
could do runtime modification, but it seems to imply quiescing DMA
among unrelated drivers, which probably means the simplest solution is
unbinding an entire hierarchy of drivers, soft unplugging the devices,
and re-scanning with a different ACS policy, which in practice may not
have a lot of benefit vs rebooting.  Thanks,

Alex


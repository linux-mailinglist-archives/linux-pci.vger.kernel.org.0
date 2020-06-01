Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F811EB160
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 23:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgFAV5D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 17:57:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49847 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729727AbgFAV5D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 17:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591048621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+8x7s6vw7v2g1Fw/ZCFRr/iC2dQUap8Sq6pXb0oimto=;
        b=Ib0rTkWKq93ANdMZxSrFWt9hlzJBNPfznqBtBgL9WkMa1D/iabx4kcv5D+dVwsBWrh1W5b
        eL2oAFc7lEEqjh4nX1MAP0QSP5ExPJsFRMiwkmRBcl4suS1XqJn/vtpN3AeIgypwT6bN3u
        ALusu1edC04ThFWuDzCwsF7h7l7a+Hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-128NCfkrMMyJcvUPflPFvg-1; Mon, 01 Jun 2020 17:56:59 -0400
X-MC-Unique: 128NCfkrMMyJcvUPflPFvg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32C69100A8E7;
        Mon,  1 Jun 2020 21:56:57 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E137A19C4F;
        Mon,  1 Jun 2020 21:56:55 +0000 (UTC)
Date:   Mon, 1 Jun 2020 15:56:55 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Darrel Goeddel <DGoeddel@forcepoint.com>,
        Mark Scott <mscott@forcepoint.com>,
        Romil Sharma <rsharma@forcepoint.com>
Subject: Re: [PATCH] PCI: Relax ACS requirement for Intel RCiEP devices.
Message-ID: <20200601155655.1519bc86@x1.home>
In-Reply-To: <20200601214023.GA15310@otc-nc-03>
References: <1590699462-7131-1-git-send-email-ashok.raj@intel.com>
        <20200601212519.GA758937@bjorn-Precision-5520>
        <20200601214023.GA15310@otc-nc-03>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 1 Jun 2020 14:40:23 -0700
"Raj, Ashok" <ashok.raj@intel.com> wrote:

> On Mon, Jun 01, 2020 at 04:25:19PM -0500, Bjorn Helgaas wrote:
> > On Thu, May 28, 2020 at 01:57:42PM -0700, Ashok Raj wrote: =20
> > > All Intel platforms guarantee that all root complex implementations
> > > must send transactions up to IOMMU for address translations. Hence for
> > > RCiEP devices that are Vendor ID Intel, can claim exception for lack =
of
> > > ACS support.
> > >=20
> > >=20
> > > 3.16 Root-Complex Peer to Peer Considerations
> > > When DMA remapping is enabled, peer-to-peer requests through the
> > > Root-Complex must be handled
> > > as follows:
> > > =E2=80=A2 The input address in the request is translated (through fir=
st-level,
> > >   second-level or nested translation) to a host physical address (HPA=
).
> > >   The address decoding for peer addresses must be done only on the
> > >   translated HPA. Hardware implementations are free to further limit
> > >   peer-to-peer accesses to specific host physical address regions
> > >   (or to completely disallow peer-forwarding of translated requests).
> > > =E2=80=A2 Since address translation changes the contents (address fie=
ld) of
> > >   the PCI Express Transaction Layer Packet (TLP), for PCI Express
> > >   peer-to-peer requests with ECRC, the Root-Complex hardware must use
> > >   the new ECRC (re-computed with the translated address) if it
> > >   decides to forward the TLP as a peer request.
> > > =E2=80=A2 Root-ports, and multi-function root-complex integrated endp=
oints, may
> > >   support additional peerto-peer control features by supporting PCI E=
xpress
> > >   Access Control Services (ACS) capability. Refer to ACS capability in
> > >   PCI Express specifications for details.
> > >=20
> > > Since Linux didn't give special treatment to allow this exception, ce=
rtain
> > > RCiEP MFD devices are getting grouped in a single iommu group. This
> > > doesn't permit a single device to be assigned to a guest for instance.
> > >=20
> > > In one vendor system: Device 14.x were grouped in a single IOMMU grou=
p.
> > >=20
> > > /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> > > /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> > > /sys/kernel/iommu_groups/5/devices/0000:00:14.3
> > >=20
> > > After the patch:
> > > /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> > > /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> > > /sys/kernel/iommu_groups/6/devices/0000:00:14.3 <<< new group
> > >=20
> > > 14.0 and 14.2 are integrated devices, but legacy end points.
> > > Whereas 14.3 was a PCIe compliant RCiEP.
> > >=20
> > > 00:14.3 Network controller: Intel Corporation Device 9df0 (rev 30)
> > > Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI=
 00
> > >=20
> > > This permits assigning this device to a guest VM.
> > >=20
> > > Fixes: f096c061f552 ("iommu: Rework iommu_group_get_for_pci_dev()")
> > > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > > To: Joerg Roedel <joro@8bytes.org>
> > > To: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: iommu@lists.linux-foundation.org
> > > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Darrel Goeddel <DGoeddel@forcepoint.com>
> > > Cc: Mark Scott <mscott@forcepoint.com>,
> > > Cc: Romil Sharma <rsharma@forcepoint.com>
> > > Cc: Ashok Raj <ashok.raj@intel.com> =20
> >=20
> > Tentatively applied to pci/virtualization for v5.8, thanks!
> >=20
> > The spec says this handling must apply "when DMA remapping is
> > enabled".  The patch does not check whether DMA remapping is enabled.
> >=20
> > Is there any case where DMA remapping is *not* enabled, and we rely on
> > this patch to tell us whether the device is isolated?  It sounds like
> > it may give the wrong answer in such a case?
> >=20
> > Can you confirm that I don't need to worry about this?   =20
>=20
> I think all of this makes sense only when DMA remapping is enabled.
> Otherwise there is no enforcement for isolation.=20

Yep, without an IOMMU all devices operate in the same IOVA space and we
have no isolation.  We only enable ACS when an IOMMU driver requests it
and it's only used by IOMMU code to determine IOMMU grouping of
devices.  Thanks,

Alex


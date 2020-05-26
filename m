Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4507E1E336B
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 01:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391188AbgEZXHY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 19:07:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32551 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404484AbgEZXHY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 19:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590534442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/cPDNnfZwS0saAPWel+OCX7+QFUn/80dLbmwhQAzY0=;
        b=DGE/PK5PCGhpMETXVTAdZF73maXyN+vC/QqWWm3aMvssmQTIYbQux2AhSvxqrG/LABLK57
        IHUVm0RPdiZ+2Qbr/Y7M/3Z0URGRntMn8vyfnO374Rif3dL7FMBDcURdtdz1RGoLqVQN2D
        rVYNZ5iS5i66d69hEaDSS95v88rBcEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-_XID7VbqOomQugx1txeZ1A-1; Tue, 26 May 2020 19:07:18 -0400
X-MC-Unique: _XID7VbqOomQugx1txeZ1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFA28107ACCD;
        Tue, 26 May 2020 23:07:16 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA6A460C47;
        Tue, 26 May 2020 23:07:15 +0000 (UTC)
Date:   Tue, 26 May 2020 17:07:15 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Darrel Goeddel <DGoeddel@forcepoint.com>,
        Mark Scott <mscott@forcepoint.com>,
        Romil Sharma <rsharma@forcepoint.com>
Subject: Re: [PATCH] iommu: Relax ACS requirement for Intel RCiEP devices.
Message-ID: <20200526170715.18c0ee98@x1.home>
In-Reply-To: <1590531455-19757-1-git-send-email-ashok.raj@intel.com>
References: <1590531455-19757-1-git-send-email-ashok.raj@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 26 May 2020 15:17:35 -0700
Ashok Raj <ashok.raj@intel.com> wrote:

> All Intel platforms guarantee that all root complex implementations
> must send transactions up to IOMMU for address translations. Hence for
> RCiEP devices that are Vendor ID Intel, can claim exception for lack of
> ACS support.
>=20
>=20
> 3.16 Root-Complex Peer to Peer Considerations
> When DMA remapping is enabled, peer-to-peer requests through the
> Root-Complex must be handled
> as follows:
> =E2=80=A2 The input address in the request is translated (through first-l=
evel,
>   second-level or nested translation) to a host physical address (HPA).
>   The address decoding for peer addresses must be done only on the
>   translated HPA. Hardware implementations are free to further limit
>   peer-to-peer accesses to specific host physical address regions
>   (or to completely disallow peer-forwarding of translated requests).
> =E2=80=A2 Since address translation changes the contents (address field) =
of
>   the PCI Express Transaction Layer Packet (TLP), for PCI Express
>   peer-to-peer requests with ECRC, the Root-Complex hardware must use
>   the new ECRC (re-computed with the translated address) if it
>   decides to forward the TLP as a peer request.
> =E2=80=A2 Root-ports, and multi-function root-complex integrated endpoint=
s, may
>   support additional peerto-peer control features by supporting PCI Expre=
ss
>   Access Control Services (ACS) capability. Refer to ACS capability in
>   PCI Express specifications for details.
>=20
> Since Linux didn't give special treatment to allow this exception, certain
> RCiEP MFD devices are getting grouped in a single iommu group. This
> doesn't permit a single device to be assigned to a guest for instance.
>=20
> In one vendor system: Device 14.x were grouped in a single IOMMU group.
>=20
> /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> /sys/kernel/iommu_groups/5/devices/0000:00:14.3
>=20
> After the patch:
> /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> /sys/kernel/iommu_groups/6/devices/0000:00:14.3 <<< new group
>=20
> 14.0 and 14.2 are integrated devices, but legacy end points.
> Whereas 14.3 was a PCIe compliant RCiEP.
>=20
> 00:14.3 Network controller: Intel Corporation Device 9df0 (rev 30)
> Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
>=20
> This permits assigning this device to a guest VM.
>=20
> Fixes: f096c061f552 ("iommu: Rework iommu_group_get_for_pci_dev()")
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> To: Joerg Roedel <joro@8bytes.org>
> To: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Darrel Goeddel <DGoeddel@forcepoint.com>
> Cc: Mark Scott <mscott@forcepoint.com>,
> Cc: Romil Sharma <rsharma@forcepoint.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> ---
>  drivers/iommu/iommu.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2b471419e26c..31b595dfedde 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1187,7 +1187,18 @@ static struct iommu_group *get_pci_function_alias_=
group(struct pci_dev *pdev,
>  	struct pci_dev *tmp =3D NULL;
>  	struct iommu_group *group;
> =20
> -	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
> +	/*
> +	 * Intel VT-d Specification Section 3.16, Root-Complex Peer to Peer
> +	 * Considerations manadate that all transactions in RCiEP's and
> +	 * even Integrated MFD's *must* be sent up to the IOMMU. P2P is
> +	 * only possible on translated addresses. This gives enough
> +	 * guarantee that such devices can be forgiven for lack of ACS
> +	 * support.
> +	 */
> +	if (!pdev->multifunction ||
> +	    (pdev->vendor =3D=3D PCI_VENDOR_ID_INTEL &&
> +	     pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_RC_END) ||
> +	     pci_acs_enabled(pdev, REQ_ACS_FLAGS))
>  		return NULL;
> =20
>  	for_each_pci_dev(tmp) {

Hi Ashok,

As this is an Intel/VT-d standard, not a PCIe standard, why not
implement this in pci_dev_specific_acs_enabled() with all the other
quirks?  Thanks,

Alex


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BE61E6DCD
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 23:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436662AbgE1Vig (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 17:38:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40562 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2436603AbgE1Vie (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2020 17:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590701911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MbsA++b9/YQf0c8XVRARDqrsuyImeixJij3EPZWrlZg=;
        b=e964r0qCaRukarUAco6F4XsHmIryB0zfMpZCLQqlwo1NlSpz6IqGcepH+yYtBn9a2wBZ/I
        yWdlv7KsonjpQOf6FLkLavCyEJkhQR8eyx8FHFrCk09AiYI4as2hTSdL1+xqn83FDxP7kx
        UduBQ1OXXRTiKxZEzQsSvLbqRAX1jZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-ChD0PkExNeeUshi1V09zKw-1; Thu, 28 May 2020 17:38:29 -0400
X-MC-Unique: ChD0PkExNeeUshi1V09zKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2BDB107ACCA;
        Thu, 28 May 2020 21:38:27 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A20A760C80;
        Thu, 28 May 2020 21:38:26 +0000 (UTC)
Date:   Thu, 28 May 2020 15:38:26 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Darrel Goeddel <DGoeddel@forcepoint.com>,
        Mark Scott <mscott@forcepoint.com>,
        Romil Sharma <rsharma@forcepoint.com>
Subject: Re: [PATCH] PCI: Relax ACS requirement for Intel RCiEP devices.
Message-ID: <20200528153826.257a0145@x1.home>
In-Reply-To: <1590699462-7131-1-git-send-email-ashok.raj@intel.com>
References: <1590699462-7131-1-git-send-email-ashok.raj@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 May 2020 13:57:42 -0700
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

I don't really understand this Fixes tag.  This seems like a feature,
not a fix.  If you want it in stable releases as a feature, request it
via Cc: stable@vger.kernel.org.  I'd drop that tag, that's my nit.
Otherwise:

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

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
> v2: Moved functionality from iommu to pci quirks - Alex Williamson
>=20
>  drivers/pci/quirks.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 28c9a2409c50..63373ca0a3fe 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4682,6 +4682,20 @@ static int pci_quirk_mf_endpoint_acs(struct pci_de=
v *dev, u16 acs_flags)
>  		PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
>  }
> =20
> +static int pci_quirk_rciep_acs(struct pci_dev *dev, u16 acs_flags)
> +{
> +	/*
> +	 * RCiEP's are required to allow p2p only on translated addresses.
> +	 * Refer to Intel VT-d specification Section 3.16 Root-Complex Peer
> +	 * to Peer Considerations
> +	 */
> +	if (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_RC_END)
> +		return -ENOTTY;
> +
> +	return pci_acs_ctrl_enabled(acs_flags,
> +		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
> +}
> +
>  static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
>  {
>  	/*
> @@ -4764,6 +4778,7 @@ static const struct pci_dev_acs_enabled {
>  	/* I219 */
>  	{ PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
> +	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_rciep_acs },
>  	/* QCOM QDF2xxx root ports */
>  	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
>  	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },


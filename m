Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD63FD0E9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 23:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKNWZ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 17:25:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35222 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726319AbfKNWZ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Nov 2019 17:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573770358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JFvCKKCME4ZFQvtrs0t1Gfy6trGPDpcpBtzp744x92M=;
        b=UpMUi0RurHTynxN4MLW6i8EAjyOdNVfezJ4fKXWyz8MukOV7ghFlySPYv6T49rdBJ/f6Fp
        XucIrDFTBnfb94U1FqoIMCdo9xsPHJuJfopod8Vio9rdb2dAJgcO5t0ddvQ4Jxj7vGBgIY
        QYBbOjiXYc5e+it6TgxHbxzv3RtZ/Fc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-cykXuMMsPeSpJpLPLaC7NQ-1; Thu, 14 Nov 2019 17:25:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 273C5802426;
        Thu, 14 Nov 2019 22:25:52 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D20F6106C;
        Thu, 14 Nov 2019 22:25:51 +0000 (UTC)
Date:   Thu, 14 Nov 2019 15:25:51 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        George Cherian <george.cherian@marvell.com>,
        Robert Richter <rrichter@marvell.com>, Feng Kan <fkan@apm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Abhinav Ratna <abhinav.ratna@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: Unify ACS quirk desired vs provided checking
Message-ID: <20191114152551.2a0bc37e@x1.home>
In-Reply-To: <20191114220601.261647-3-helgaas@kernel.org>
References: <20191114220601.261647-1-helgaas@kernel.org>
        <20191114220601.261647-3-helgaas@kernel.org>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: cykXuMMsPeSpJpLPLaC7NQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Nov 2019 16:06:01 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Most of the ACS quirks have a similar pattern of:
>=20
>   acs_flags &=3D ~( <controls provided by this device> );
>   return acs_flags ? 0 : 1;
>=20
> Pull this out into a helper function to simplify the quirks slightly.  Th=
e
> helper function is also a convenient place for comments about what the li=
st
> of ACS controls means.  No functional change intended.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/quirks.c | 67 +++++++++++++++++++++++++++++---------------
>  1 file changed, 45 insertions(+), 22 deletions(-)

Much cleaner, and looks equivalent to me.  For both:

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

Thanks!

>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 59f73d084e1d..9a1051071a81 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4296,6 +4296,24 @@ static void quirk_chelsio_T5_disable_root_port_att=
ributes(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>  =09=09=09 quirk_chelsio_T5_disable_root_port_attributes);
> =20
> +/*
> + * pci_acs_ctrl_enabled - compare desired ACS controls with those provid=
ed
> + *=09=09=09  by a device
> + * @acs_ctrl_req: Bitmask of desired ACS controls
> + * @acs_ctrl_ena: Bitmask of ACS controls enabled or provided implicitly=
 by
> + *=09=09  the hardware design
> + *
> + * Return 1 if all ACS controls in the @acs_ctrl_req bitmask are include=
d
> + * in @acs_ctrl_ena, i.e., the device provides all the access controls t=
he
> + * caller desires.  Return 0 otherwise.
> + */
> +static int pci_acs_ctrl_enabled(u16 acs_ctrl_req, u16 acs_ctrl_ena)
> +{
> +=09if ((acs_ctrl_req & acs_ctrl_ena) =3D=3D acs_ctrl_req)
> +=09=09return 1;
> +=09return 0;
> +}
> +
>  /*
>   * AMD has indicated that the devices below do not support peer-to-peer
>   * in any system where they are found in the southbridge with an AMD
> @@ -4339,7 +4357,7 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev=
, u16 acs_flags)
>  =09/* Filter out flags not applicable to multifunction */
>  =09acs_flags &=3D (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC | PCI_ACS_DT);
> =20
> -=09return acs_flags & ~(PCI_ACS_RR | PCI_ACS_CR) ? 0 : 1;
> +=09return pci_acs_ctrl_enabled(acs_flags, PCI_ACS_RR | PCI_ACS_CR);
>  #else
>  =09return -ENODEV;
>  #endif
> @@ -4377,9 +4395,8 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev=
, u16 acs_flags)
>  =09 * hardware implements and enables equivalent ACS functionality for
>  =09 * these flags.
>  =09 */
> -=09acs_flags &=3D ~(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
> -
> -=09return acs_flags ? 0 : 1;
> +=09return pci_acs_ctrl_enabled(acs_flags,
> +=09=09PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  }
> =20
>  static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
> @@ -4389,9 +4406,8 @@ static int pci_quirk_xgene_acs(struct pci_dev *dev,=
 u16 acs_flags)
>  =09 * transactions with others, allowing masking out these bits as if th=
ey
>  =09 * were unimplemented in the ACS capability.
>  =09 */
> -=09acs_flags &=3D ~(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
> -
> -=09return acs_flags ? 0 : 1;
> +=09return pci_acs_ctrl_enabled(acs_flags,
> +=09=09PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  }
> =20
>  /*
> @@ -4443,17 +4459,16 @@ static bool pci_quirk_intel_pch_acs_match(struct =
pci_dev *dev)
>  =09return false;
>  }
> =20
> -#define INTEL_PCH_ACS_FLAGS (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_=
ACS_UF)
> -
>  static int pci_quirk_intel_pch_acs(struct pci_dev *dev, u16 acs_flags)
>  {
>  =09if (!pci_quirk_intel_pch_acs_match(dev))
>  =09=09return -ENOTTY;
> =20
>  =09if (dev->dev_flags & PCI_DEV_FLAGS_ACS_ENABLED_QUIRK)
> -=09=09acs_flags &=3D ~(INTEL_PCH_ACS_FLAGS);
> +=09=09return pci_acs_ctrl_enabled(acs_flags,
> +=09=09=09PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
> =20
> -=09return acs_flags ? 0 : 1;
> +=09return pci_acs_ctrl_enabled(acs_flags, 0);
>  }
> =20
>  /*
> @@ -4468,9 +4483,8 @@ static int pci_quirk_intel_pch_acs(struct pci_dev *=
dev, u16 acs_flags)
>   */
>  static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
>  {
> -=09acs_flags &=3D ~(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
> -
> -=09return acs_flags ? 0 : 1;
> +=09return pci_acs_ctrl_enabled(acs_flags,
> +=09=09PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  }
> =20
>  static int pci_quirk_al_acs(struct pci_dev *dev, u16 acs_flags)
> @@ -4571,7 +4585,7 @@ static int pci_quirk_intel_spt_pch_acs(struct pci_d=
ev *dev, u16 acs_flags)
> =20
>  =09pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
> =20
> -=09return acs_flags & ~ctrl ? 0 : 1;
> +=09return pci_acs_ctrl_enabled(acs_flags, ctrl);
>  }
> =20
>  static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
> @@ -4585,10 +4599,9 @@ static int pci_quirk_mf_endpoint_acs(struct pci_de=
v *dev, u16 acs_flags)
>  =09 * perform peer-to-peer with other functions, allowing us to mask out
>  =09 * these bits as if they were unimplemented in the ACS capability.
>  =09 */
> -=09acs_flags &=3D ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
> -=09=09       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
> -
> -=09return acs_flags ? 0 : 1;
> +=09return pci_acs_ctrl_enabled(acs_flags,
> +=09=09PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
> +=09=09PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
>  }
> =20
>  static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
> @@ -4599,9 +4612,8 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev, =
u16 acs_flags)
>  =09 * Allow each Root Port to be in a separate IOMMU group by masking
>  =09 * SV/RR/CR/UF bits.
>  =09 */
> -=09acs_flags &=3D ~(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
> -
> -=09return acs_flags ? 0 : 1;
> +=09return pci_acs_ctrl_enabled(acs_flags,
> +=09=09PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  }
> =20
>  static const struct pci_dev_acs_enabled {
> @@ -4703,6 +4715,17 @@ static const struct pci_dev_acs_enabled {
>  =09{ 0 }
>  };
> =20
> +/*
> + * pci_dev_specific_acs_enabled - check whether device provides ACS cont=
rols
> + * @dev:=09PCI device
> + * @acs_flags:=09Bitmask of desired ACS controls
> + *
> + * Returns:
> + *   -ENOTTY:=09No quirk applies to this device; we can't tell whether t=
he
> + *=09=09device provides the desired controls
> + *   0:=09=09Device does not provide all the desired controls
> + *   >0:=09Device provides all the controls in @acs_flags
> + */
>  int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags)
>  {
>  =09const struct pci_dev_acs_enabled *i;


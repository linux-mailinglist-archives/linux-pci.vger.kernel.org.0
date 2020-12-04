Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DD12CECB5
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 12:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgLDLGA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 06:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgLDLF7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2020 06:05:59 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D009C0613D1;
        Fri,  4 Dec 2020 03:05:19 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id 7so8132913ejm.0;
        Fri, 04 Dec 2020 03:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MwGzR1Y28JX67nWNoCvzrPLy/dODrJVdWJSsCQE6qHk=;
        b=Zj+TtVYtA+yGfOZlb+PYiCbxi5CfWudF6F8OFqrCpfrYfdIF5VtkZ2dsjUVQbp1Hgu
         UbvcvA7idCnSl7CIYHA9oJoegkR9e90knPTu2xDjqubPYiMPOP7kmd9xTeiCKzHKXwKW
         uuq5kTtDXktodf2Q9rSfd2CILoLx3IUbcb0IiTmC5yQvU1eHGgBvhWhpqLbczZ5bRdJi
         IUryE/712YRdQLpUlYebR3m61+BPZLFTkoyfq5n1HTqL47fLEqgKBVJ+YXbU5yf6wVUq
         L8qSX5jP4xBju5SZcfAf/DCymLVeiC2LGfM/xRlwHn3L819n7gFuRpgqQkvvB67+5DZg
         0Y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MwGzR1Y28JX67nWNoCvzrPLy/dODrJVdWJSsCQE6qHk=;
        b=BleJWi8p+sHkkaEoqvjcS4JylojzpCNTinCPQX6LfRSMI8+1OUdliBWo8Vs2bUzSFz
         FuLmrW8VgmrHJctCqEsncPcungYKcJ0YWCVWrGtWSuT6ub3XjZ3B7OsL4tEimGxPmqS+
         HUgCzNYnqfJQ69x8+ELU1JuCXgT7GqMVTq1JYopfXJKsvbfQXclctllqjT3a/0nxX3nw
         0/R/RAMCyftp8QHvW2LSu4cO6rRMXaoLORCTVsZzNqgVgnbuGfsHqDZS0Dw4gE+tDclQ
         zuvT2IFx29MP3XUlA5fWV32BL6LkR9eJi2EuVQqxK4cxW9lEWTqoom/KVnS18bR8Q4my
         NApg==
X-Gm-Message-State: AOAM530aMprxo6BHPQBq5CH0TrtqAQnB/vLi6ZvKw1eUOAY8ff2i345X
        dONXecaAunT8rC0vG89Il8g=
X-Google-Smtp-Source: ABdhPJw9rcNBp67mh5SB4w7LqkCdkTY63HZyzW2/ujSbu9V0qKNt4EM3J5yoKjbXghVLjlIHyllI2w==
X-Received: by 2002:a17:906:d931:: with SMTP id rn17mr6376898ejb.308.1607079917996;
        Fri, 04 Dec 2020 03:05:17 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id a10sm2601878ejk.92.2020.12.04.03.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 03:05:16 -0800 (PST)
Date:   Fri, 4 Dec 2020 12:05:15 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Kishore <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/3] PCI/MSI: Move MSI/MSI-X init to msi.c
Message-ID: <X8oX61zRwV7ykLAy@ulmo>
References: <20201203185110.1583077-1-helgaas@kernel.org>
 <20201203185110.1583077-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c381iuSK8tOo+HzI"
Content-Disposition: inline
In-Reply-To: <20201203185110.1583077-2-helgaas@kernel.org>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--c381iuSK8tOo+HzI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2020 at 12:51:08PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Move pci_msi_setup_pci_dev(), which disables MSI and MSI-X interrupts, fr=
om
> probe.c to msi.c so it's with all the other MSI code and more consistent
> with other capability initialization.  This means we must compile msi.c
> always, even without CONFIG_PCI_MSI, so wrap the rest of msi.c in an #ifd=
ef
> and adjust the Makefile accordingly.  No functional change intended.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/Makefile |  3 +--
>  drivers/pci/msi.c    | 36 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h    |  2 ++
>  drivers/pci/probe.c  | 21 ++-------------------
>  4 files changed, 41 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 522d2b974e91..11cc79411e2d 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -5,7 +5,7 @@
>  obj-$(CONFIG_PCI)		+=3D access.o bus.o probe.o host-bridge.o \
>  				   remove.o pci.o pci-driver.o search.o \
>  				   pci-sysfs.o rom.o setup-res.o irq.o vpd.o \
> -				   setup-bus.o vc.o mmap.o setup-irq.o
> +				   setup-bus.o vc.o mmap.o setup-irq.o msi.o
> =20
>  obj-$(CONFIG_PCI)		+=3D pcie/
> =20
> @@ -18,7 +18,6 @@ endif
>  obj-$(CONFIG_OF)		+=3D of.o
>  obj-$(CONFIG_PCI_QUIRKS)	+=3D quirks.o
>  obj-$(CONFIG_HOTPLUG_PCI)	+=3D hotplug/
> -obj-$(CONFIG_PCI_MSI)		+=3D msi.o
>  obj-$(CONFIG_PCI_ATS)		+=3D ats.o
>  obj-$(CONFIG_PCI_IOV)		+=3D iov.o
>  obj-$(CONFIG_PCI_BRIDGE_EMUL)	+=3D pci-bridge-emul.o
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index d52d118979a6..555791c0ee1a 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -26,6 +26,8 @@
> =20
>  #include "pci.h"
> =20
> +#ifdef CONFIG_MSI
> +
>  static int pci_msi_enable =3D 1;
>  int pci_msi_ignore_mask;
> =20
> @@ -1577,3 +1579,37 @@ bool pci_dev_has_special_msi_domain(struct pci_dev=
 *pdev)
>  }
> =20
>  #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
> +#endif /* CONFIG_PCI_MSI */
> +
> +void pci_msi_init(struct pci_dev *dev)
> +{
> +	u16 ctrl;
> +
> +	/*
> +	 * Disable the MSI hardware to avoid screaming interrupts
> +	 * during boot.  This is the power on reset default so
> +	 * usually this should be a noop.
> +	 */
> +	dev->msi_cap =3D pci_find_capability(dev, PCI_CAP_ID_MSI);
> +	if (!dev->msi_cap)
> +		return;
> +
> +	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &ctrl);
> +	if (ctrl & PCI_MSI_FLAGS_ENABLE)
> +		pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS,
> +				      ctrl & ~PCI_MSI_FLAGS_ENABLE);
> +}

The old code used the pci_msi_set_enable() helper here...

> +
> +void pci_msix_init(struct pci_dev *dev)
> +{
> +	u16 ctrl;
> +
> +	dev->msix_cap =3D pci_find_capability(dev, PCI_CAP_ID_MSIX);
> +	if (!dev->msix_cap)
> +		return;
> +
> +	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
> +	if (ctrl & PCI_MSIX_FLAGS_ENABLE)
> +		pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
> +				      ctrl & ~PCI_MSIX_FLAGS_ENABLE);
> +}

=2E.. and pci_msix_clear_and_set_ctrl() here. I like your version here
better because it avoids the unnecessary write in case the flag isn't
set. But it got me thinking if perhaps the helpers aren't very useful
and perhaps should be dropped in favour of open-coded variants.
Especially since there seem to be only 4 and 6 occurrences of them after
this patch.

Anyway, this patch looks correct to me and is a nice improvement, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--c381iuSK8tOo+HzI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/KF+gACgkQ3SOs138+
s6F4uQ/8C2+QVUpFTfG5aaAddWNsh4xfZDlWQPPSw9HeOsh5lU9W3yRi/11bTFOY
3W1pLmCP/WdVli6Qen3bOLQKOqin6WPg0U1uBs17HPHFVC++CaJVJhtt8hRWcBCA
wCHNn15XDFM2QvDlhkLXZzFFTilgHfIG3W53d5IxxLRx6ShZEmlhK6zKzgSuIIT+
nvYe8XIUnqwYLk5Tkj7l+M/1YVkfLQE2vRqaP99IUpiuYj/KKUIYTAqEeDIf2fqw
XhgroNY2SRWGt6Wl/+/Go+CkwGrDYHvbV7guhRtj432vX8PWmvpOoEHZSL93FzAu
wKtgHkXavsDvP6XTju/zAF+dGVGsW9+K2LNsyJUI/JUb9+DcykOu+7msGnWuu31Z
uPeUrULqPvl3nxMKmiDVAUoDSYHcX7ZbXwGSlY7mS/aYY33JaMoXE4ChddFJ0TMx
iLwxC5Alw149ecYJ485bd4NDJS9/rqceoQTLhqzqKSy0hHw01FY85OrfrHYtoYxa
/fxmkT4ck6tsGfODBrHAIb26hQ/Qa4thAAcQ7SJetudqaUO2ymUB/uwJCfyWN114
I9x+j5lVpLl5lZxVlJRLXfAlPZp8jFfeXGOilZVj26mxpZUjj6ltlW1Oilbe3RWR
29lY++h/2LX8kJM59jyf2zh72nuiHVOPioEqbWEWZXGC6t5TClo=
=4zX2
-----END PGP SIGNATURE-----

--c381iuSK8tOo+HzI--

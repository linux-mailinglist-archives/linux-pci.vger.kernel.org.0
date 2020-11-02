Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7404D2A2CF8
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 15:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgKBO1y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 09:27:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:56981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgKBO1y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Nov 2020 09:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604327244;
        bh=AcU6jbrx1riv+Wdlt3eWYyaQWzNIBJIHnijeALTKPwg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TA22Kf8Su+5fPlV+NmRLldPyD0XDaR8d0CkbARd/ntxyoKf+nuM8PhCBWVQccUFL6
         ytCU01NVMarR30I5FrpzMc0YIxAkFGuL/I9l+QeK45S2vcpaIUx49mFQ1PaStwiUfU
         bfJOy3XeyFqyiaw64i0/bCI9XhEBt3GMphYRu5Dc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [185.76.97.212] ([185.76.97.212]) by web-mail.gmx.net
 (3c-app-gmx-bap57.server.lan [172.19.172.127]) (via HTTP); Mon, 2 Nov 2020
 15:27:23 +0100
MIME-Version: 1.0
Message-ID: <trinity-769ccf2c-6962-4e27-8a78-619cd16fab25-1604327243865@3c-app-gmx-bap57>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Aw: Re:  Re:  Re: [PATCH] pci: mediatek: fix warning in msi.h
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 2 Nov 2020 15:27:23 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <336d6588567949029c52ecfbb87660c1@kernel.org>
References: <20201031140330.83768-1-linux@fw-web.de>
 <878sbm9icl.fsf@nanos.tec.linutronix.de>
 <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de>
 <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22>
 <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08>
 <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de>
 <df5565a2f1e821041c7c531ad52a3344@kernel.org>
 <trinity-4313623b-1adf-4cc3-8b50-2d0593669995-1604318207058@3c-app-gmx-bap57>
 <336d6588567949029c52ecfbb87660c1@kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:yby5m6QFQy2Reuk7SqSaUU1Eu/PTwr1ZUMBtAMxlDwxvkbPolpmCM+cXzUiu8lzFk6TcY
 VFSSJGXqKyPUGl8Dvr519WpTTtnT+x96enLFcyvMgi1yDXqTcnXnE9e/O8p2NKZA475lS7P/wkGP
 IktsqpRoisIw2h8RIbfCWBceIKpt0QwpHqRiiiA0qld/PxLkY7YnD2Xobm6rhK3BBzCNhpbV9s75
 Y8emVf2EmfxQimQmXLVM7a/v+NH0z4LChYnLtqkSEVfOkbnzCAHlJLtIu8/+JxryRkHG7VUX3VzJ
 q0=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jzhFKPbKFHY=:BO8Lhdoqk5kdjdCQ+5k5o4
 Pl0A+jnhBAluOiuqmz4W9n0Er09cRvKrCbWqZESIOeZ9YuogllZ4uEfvtwSw5b8GWubmTBSNk
 9VGsRgIx1uZKcVI3veiiDCjrO+azUfx3gbHZ22lzYeWqVZ6efJoFxhtrJMECSfaYJ4JBg8cR+
 agwFjakbG6pSoYOswIiXuk82rMcvzUWy0f9Z28RFOdn/+Tm3tvccgOG32Lkaf+inGrQer2Tmf
 JQ1dkfnMUADKc1pWIZyj7HooqeHorxG48kZ7VjGrMuEzrdChSyo8eEQZkJywASNJZsxw/No8U
 I8isKlNAi4wiEJzsbyRrvHZMlYnPz6Gr4bxsyqXI9B8BTISQMW1odi3ZitfX6rW0xKVHkLm58
 zjhAkJy9RK35E16eKXHsobRLzextP1MBU07v+nqknHQvSMkvmJls0ya2rrlo5H+ZhH3MIxZGC
 VL/tp7IVd6dXiIPKQge8UIUdiIvLUOj74p2+fvpyKkSAEPDbKg8nGWlr/eEAp8eKDBw35q5sS
 8wo7AvD0BNarVAMnv0BF/G0jI4ho7BEWcklvK5eT+WEkQVWZ9Y2AgNJy1utLUexaRUOKWBPfZ
 vj8g8anfj3C00=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Gesendet: Montag, 02. November 2020 um 14:58 Uhr
> Von: "Marc Zyngier" <maz@kernel.org>

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index d15c881e2e7e..5bb1306162c7 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -387,10 +387,20 @@ static ssize_t msi_bus_store(struct device *dev,
> struct device_attribute *attr,
>   		return count;
>   	}
>
> -	if (val)
> +	if (val) {
> +		/*
> +		 * If there is no possibility for this bus to deal with
> +		 * MSIs, then allowing them to be requested would lead to
> +		 * the kernel complaining loudly. In this situation, don't
> +		 * let userspace mess things up.
> +		 */
> +		if (!pci_bus_is_msi_capable(subordinate))
> +			return -EINVAL;
> +
>   		subordinate->bus_flags &=3D ~PCI_BUS_FLAGS_NO_MSI;
> -	else
> +	} else {
>   		subordinate->bus_flags |=3D PCI_BUS_FLAGS_NO_MSI;
> +	}
>
>   	dev_info(&subordinate->dev, "MSI/MSI-X %s for future drivers of
> devices on this bus\n",
>   		 val ? "allowed" : "disallowed");
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4289030b0fff..28861cc6435a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -871,6 +871,8 @@ static void pci_set_bus_msi_domain(struct pci_bus
> *bus)
>   		d =3D pci_host_bridge_msi_domain(b);
>
>   	dev_set_msi_domain(&bus->dev, d);
> +	if (!pci_bus_is_msi_capable(bus))
> +		bus->bus_flags |=3D PCI_BUS_FLAGS_NO_MSI;
>   }
>
>   static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 22207a79762c..6aadb863dff4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2333,6 +2333,12 @@ pci_host_bridge_acpi_msi_domain(struct pci_bus
> *bus) { return NULL; }
>   static inline bool pci_pr3_present(struct pci_dev *pdev) { return
> false; }
>   #endif
>
> +static inline bool pci_bus_is_msi_capable(struct pci_bus *bus)
> +{
> +	return (IS_ENABLED(CONFIG_PCI_MSI_ARCH_FALLBACKS) ||
> +		dev_get_msi_domain(&bus->dev));
> +}
> +
>   #ifdef CONFIG_EEH
>   static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
>   {

Hi,

this Patch seems to work well too...no warning, pcie-card and hdd recogniz=
ed

regards Frank

Return-Path: <linux-pci+bounces-30127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB5CADF68D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 20:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 742EF7AB19A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755932F9493;
	Wed, 18 Jun 2025 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VDMklQ9R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE622F49E0
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273104; cv=none; b=tOT8y6LYmERFc1fcELhhykJY9VMwRe0ns8XMuuayddAS3DLWmTFMb1QcEGYcTotL4w7+ces1gMs8OBAhm3mP/15tRZ4xV30Capw8kQJi31KSkffXe+pbKHXKv2tUEjtd0qd0Dz9dfni7F39Sy0njUZ3pC7Poz7jwqkQ/5al0Qtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273104; c=relaxed/simple;
	bh=d9PCGcv1LFGXTnoz8aR6sbdVmtrBoR/U5nLVdlX0znA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oss3B7BUWhfuMs59KbCZXzjpxj6T83rm0Yk5sK6jd+nQXwIUMRkboubKxNV2nUXxgKMSvoaZv51DmjdFrR9CueUo7HidhMMwcd5CzBIYts/xKmHg6QsINURiDXOdu1ss4ukikKVHUx1NXYIMfZQShxgbOBpdnGfGDTypSyc1JEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VDMklQ9R; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so1276880e87.1
        for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 11:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750273100; x=1750877900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qmw9PEoQiIrV2ZziIyqd5KeanMW/zwaf1+mQ9+VCQt8=;
        b=VDMklQ9RqysccZB94MvhIY3K5qsVtRonZmQcoIcx6BGhtVU/tzeIryARSDxm0PTTs7
         Zdur5YYdyWkO9mfHzMI53lmdbg6YEpU6JPsUBIm/WIs0+kbg0mw85cjZBxlsropZoiVL
         9VAyNmQ77NI2IZzrhtXIkgQ+MidzvSC/R3C6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750273100; x=1750877900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmw9PEoQiIrV2ZziIyqd5KeanMW/zwaf1+mQ9+VCQt8=;
        b=KLhzoQ4f2EXXTAYjbyfzMBueEmuArlsSmW5KbaS+VJj9Nn+GRidlOaAKzHU/1+vaY3
         RF76+Uuq6/OCPlUWt7HACyBRR5+iKYCU+LpvY9xmzAnP8Ej9SHnWaVthue9x70qWQdC5
         cQPRVx6OdEMzolYUpSduOV1O1FcvCT8Qdi37Hi/uiAf7pwmDXfEvs0a5uKkv3IxDNpGp
         Gb302AeQPRQ29PBZVMZaJZQYUe7YtFTFDm2MKV3uxSyJVDAT92xqMsQa/DCjwQyBF8VP
         SZ/231urunsCKLN61MloVwEGXTrFy000HFphC4EDkOctSwCUlyKXwF8xiKvdK6EYIW+p
         Rxrw==
X-Forwarded-Encrypted: i=1; AJvYcCVphWxTJstgH+GQZ+FAnwBMz+7Qgju9ROw9nLJl5N2yN2bPoYrsIOePcTmbL7rkjCEBloxfNe+r208=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR2XCuH/O9Qzz9VIgM+43VQsWA1++aco8DHudOGM1Wh6QRJvZG
	WDLQlsFJ9gMJEIQ8PkJ5MHPULsHcdb8g/PR105CTV1VoAMMDH17ayH18TXUzghbz7TOiKXDXnbG
	1s4WGjYw8KH57Zmt+ha9t84nQRGLMGz001Cd2U1b6C1I/M9baFdhX5Q==
X-Gm-Gg: ASbGncvnmYIhjN+7sg2q2x6NIONwPRkc1IQy0dSCeZm45eEUBm3oP5q/ND+j2Qr0pQ2
	21wWLDsS1BEtPwHdgQrR9bi1QdTFxTKeokh60gxy0OdT5nMh/mTlk9nl6NbUu7QdUHzDkzu2obL
	EAthNYhKxYuxjBlc2r4rj+XfK9Q8kf4AA6PEVdRSlqaEZD
X-Google-Smtp-Source: AGHT+IGYurP8k2LEh7vwdS9rEUPjzfZDQNT4fopSCpl/Z7g8cNeQVl4GT7t1d/nQ7i+qJw1zjE0AiHSdGRY9PL9W0Gs=
X-Received: by 2002:a05:6512:308a:b0:553:2375:c6e8 with SMTP id
 2adb3069b0e04-553d97b0066mr302318e87.1.1750273100197; Wed, 18 Jun 2025
 11:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616053209.13045-1-mani@kernel.org>
In-Reply-To: <20250616053209.13045-1-mani@kernel.org>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 18 Jun 2025 14:58:08 -0400
X-Gm-Features: AX0GCFvBc2eY84r4JbOye0QGCUK6b1ep-B-W5GIi9a1SA21NGoNAGrRIDgNdODw
Message-ID: <CA+-6iNyE_6yES6rQZgiuvTE7hg+COjgkNkx2mwCF6K-4kEOuOw@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device()
 definition to drivers/pci/pwrctrl/
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, brgl@bgdev.pl, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lukas@wunner.de, 
	Bjorn Helgaas <helgaas@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006db5570637dd3618"

--0000000000006db5570637dd3618
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 1:32=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> pci_pwrctrl_create_device() is a PWRCTRL framework API. So it should be
> built only when CONFIG_PWRCTRL is enabled. Currently, it is built
> independently of CONFIG_PWRCTRL. This creates enumeration failure on
> platforms like brcmstb using out-of-tree devicetree that describes the
> power supplies for endpoints in the PCIe child node, but doesn't use
> PWRCTRL framework to manage the supplies. The controller driver itself
> manages the supplies.
>
> But in any case, the API should be built only when CONFIG_PWRCTRL is
> enabled. So move its definition to drivers/pci/pwrctrl/core.c and provide
> a stub in drivers/pci/pci.h when CONFIG_PWRCTRL is not enabled. This also
> fixes the enumeration issues on the affected platforms.
>
> Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pc=
i_scan_device()")
> Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
> Closes: https://lore.kernel.org/r/CA+-6iNwgaByXEYD3j=3D-+H_PKAxXRU78svPMR=
HDKKci8AGXAUPg@mail.gmail.com
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>
> Changes in v3:

Hi Mani,

Thanks for working on this.  How/where should I be applying these
patches?  I've been using torvald's latest master but I get failed
hunks and have to manually fix them up.

At any rate I'll be testing whatever you are posting.

Thanks,
Jim Quinilan
Broadcom STB/CM

>
> * Used IS_ENABLED instead of ifdef in drivers/pci/pci.h (Sathyanarayanan)
>
> Changes in v2:
>
> * Dropped the unused headers from probe.c (Lukas)
>
>  drivers/pci/pci.h          |  8 ++++++++
>  drivers/pci/probe.c        | 32 --------------------------------
>  drivers/pci/pwrctrl/core.c | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12215ee72afb..22df9e2bfda6 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1159,4 +1159,12 @@ static inline int pci_msix_write_tph_tag(struct pc=
i_dev *pdev, unsigned int inde
>         (PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
>          PCI_CONF1_EXT_REG(reg))
>
> +#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
> +struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus,
> +                                                 int devfn);
> +#else
> +static inline struct platform_device *
> +pci_pwrctrl_create_device(struct pci_bus *bus, int devfn) { return NULL;=
 }
> +#endif
> +
>  #endif /* DRIVERS_PCI_H */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..478e217928a6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -9,8 +9,6 @@
>  #include <linux/pci.h>
>  #include <linux/msi.h>
>  #include <linux/of_pci.h>
> -#include <linux/of_platform.h>
> -#include <linux/platform_device.h>
>  #include <linux/pci_hotplug.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -2508,36 +2506,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bu=
s, int devfn, u32 *l,
>  }
>  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
>
> -static struct platform_device *pci_pwrctrl_create_device(struct pci_bus =
*bus, int devfn)
> -{
> -       struct pci_host_bridge *host =3D pci_find_host_bridge(bus);
> -       struct platform_device *pdev;
> -       struct device_node *np;
> -
> -       np =3D of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
> -       if (!np || of_find_device_by_node(np))
> -               return NULL;
> -
> -       /*
> -        * First check whether the pwrctrl device really needs to be crea=
ted or
> -        * not. This is decided based on at least one of the power suppli=
es
> -        * being defined in the devicetree node of the device.
> -        */
> -       if (!of_pci_supply_present(np)) {
> -               pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name)=
;
> -               return NULL;
> -       }
> -
> -       /* Now create the pwrctrl device */
> -       pdev =3D of_platform_device_create(np, NULL, &host->dev);
> -       if (!pdev) {
> -               pr_err("PCI/pwrctrl: Failed to create pwrctrl device for =
node: %s\n", np->name);
> -               return NULL;
> -       }
> -
> -       return pdev;
> -}
> -
>  /*
>   * Read the config data for a PCI device, sanity-check it,
>   * and fill in the dev structure.
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 6bdbfed584d6..20585b2c3681 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -6,11 +6,47 @@
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/pci-pwrctrl.h>
> +#include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
>
> +#include "../pci.h"
> +
> +struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, i=
nt devfn)
> +{
> +       struct pci_host_bridge *host =3D pci_find_host_bridge(bus);
> +       struct platform_device *pdev;
> +       struct device_node *np;
> +
> +       np =3D of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
> +       if (!np || of_find_device_by_node(np))
> +               return NULL;
> +
> +       /*
> +        * First check whether the pwrctrl device really needs to be crea=
ted or
> +        * not. This is decided based on at least one of the power suppli=
es
> +        * being defined in the devicetree node of the device.
> +        */
> +       if (!of_pci_supply_present(np)) {
> +               pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name)=
;
> +               return NULL;
> +       }
> +
> +       /* Now create the pwrctrl device */
> +       pdev =3D of_platform_device_create(np, NULL, &host->dev);
> +       if (!pdev) {
> +               pr_err("PCI/pwrctrl: Failed to create pwrctrl device for =
node: %s\n", np->name);
> +               return NULL;
> +       }
> +
> +       return pdev;
> +}
> +
>  static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long a=
ction,
>                               void *data)
>  {
> --
> 2.43.0
>

--0000000000006db5570637dd3618
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICYDCC
AlwCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBkuobZrltCfHzUYSfIgPs+rNnJawkp
84P+nWGBHOE9czAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA2
MTgxODU4MjBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQCH1sj34cajNeF65q6Uf+LITKrzvFCD9pI6MB/rxO2xsSZWEU72sMfJYkaNdRhQfqpK
3SHacDnF0+2wkKOJxrySj2CrM23gH7xUOHmanRDcrOgWbykEqzV/ywJJ6uHj3m3G3h6ynTuk8aq5
ZSRP64HN0nN6OCjxzAhQYT4KeHrosjvsNo2G1kToaeQJMIirIYd7AWxfCWv2pKq2UpeVP7aTu8oN
yYsRP27zvYmUdpL2xYijSFfKIxp6NAhZZh4iz91BvJk+PDynUiACiDr7jTkTf6/Vtvgz1rBQ0wko
hnqtRO6rfCHxZsB8SNJfGB871dHrzzzzRv+ygp72T2V2sOlZ
--0000000000006db5570637dd3618--


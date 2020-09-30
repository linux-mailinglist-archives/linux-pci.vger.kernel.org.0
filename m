Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB05627F3B2
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 22:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbgI3U6B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 16:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3U6A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 16:58:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5EDC061755
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 13:58:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so3275103wrl.12
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 13:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TEG7+syMGZRzDHfSmhwf9+sUwtWQLpStwYCGc8NzPk=;
        b=EPUYhrEJzzv4I1ZIh8wYTf92rjgnLjUkMnldCMokQbAkoQI/b1vWhbZXBwfNCMyqZ2
         SpdJnjOUknhyr6OmrP/pRLG0ohQHcyArh+hDfbnXWYtITf1/TzBwnsEAe7rFWD3q9RQv
         75WLE1SwFBZSbkl8HQ/NTzzkEuPg411n1uBE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TEG7+syMGZRzDHfSmhwf9+sUwtWQLpStwYCGc8NzPk=;
        b=SQ6PTmzQG471Kf/+r3+zMpPJ5aOa2Bwo2tEGgUQTVsEYRHqO97kpk54MGELFVV5GfJ
         UJ4yJhdtsM1wAjOFd7CtHNFSk09xltEBNtPVp6w9U5ObVe47tbSMTvcvADUm5eifEoIX
         zSfxg4AT+/vBGHuRcdFyiL8x9t2QG4DlHXgtXL/WzREt5xs/Sh0Zp9nWZkrZoXBpyOe5
         MV+xiTrmlRdmX4kqaKqLD2sstx2gLedCWeMTIfdxXEfH2f5yJMAi2Daj7sCSVC8sLphC
         aNxcN8QIKsPuDsh41u3fFbOCA/yCKo6Vy+/WitChcfW9URVyBZ+i8rASgZlv9LQRFbQO
         k+wA==
X-Gm-Message-State: AOAM5311OhH0FUrp9uC7Azhf1PV5p7EMnZJa0fKTPu/Hks8K5mClOxOC
        ts/CDnVU3Br02gBxQPtBKoCOHqjwQU8udRi3Rj6avw==
X-Google-Smtp-Source: ABdhPJzEFsY5hh/bzWc6Lxv6emAlJFtCGJei9L3x5+7hR4gyDZsbc7adBnkyCIsxL/H/6iCQexb+5KkMRGGt5I3sfB8=
X-Received: by 2002:adf:e711:: with SMTP id c17mr5065542wrm.359.1601499478716;
 Wed, 30 Sep 2020 13:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200928194651.5393-2-james.quinlan@broadcom.com> <20200929213153.GA2578412@bjorn-Precision-5520>
In-Reply-To: <20200929213153.GA2578412@bjorn-Precision-5520>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 30 Sep 2020 16:57:47 -0400
Message-ID: <CA+-6iNwWtJTOdj2Fw-AgjVFRFAZrZ+vvTCOmMEiiYHvbcrap+w@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/1] PCI: pcie_bus_config can be set at build time
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008f8d2305b08e276a"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000008f8d2305b08e276a
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 29, 2020 at 5:31 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Sep 28, 2020 at 03:46:51PM -0400, Jim Quinlan wrote:
> > The Kconfig is modified so that the pcie_bus_config setting can be done at
> > build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  The
> > pci_bus_config setting may still be overridden by the bootline param.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>
> Applied to pci/enumeration for v5.10, thanks!
>
> I tweaked the help texts and made the Kconfig stuff depend on
> CONFIG_EXPERT.  Will that still be enough for what you need?  I'm
> worried that users will get themselves in trouble if they fiddle with
> things without really understanding what's going on.

Hi Bjorn,

I didn't even know about CONFIG_EXPERT -- makes sense and looks good to me!

Thanks much,
Jim Quinlan
Broadcom STB

>
> Here's what I applied:
>
>
> commit 2a87f534d198 ("PCI: Add Kconfig options for pcie_bus_config")
> Author: Jim Quinlan <james.quinlan@broadcom.com>
> Date:   Mon Sep 28 15:46:51 2020 -0400
>
>     PCI: Add Kconfig options for pcie_bus_config
>
>     Add Kconfig options for changing the default pcie_bus_config in the same
>     manner as the CONFIG_PCIEASPM_XXXX choice.  The pci_bus_config setting may
>     still be overridden by kernel command-line parameters, e.g.,
>     "pci=pcie_bus_tune_off".
>
>     [bhelgaas: depend on EXPERT, tweak help texts]
>     Link: https://lore.kernel.org/r/20200928194651.5393-2-james.quinlan@broadcom.com
>     Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 4bef5c2bae9f..d323b25ae27e 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -187,6 +187,68 @@ config PCI_HYPERV
>           The PCI device frontend driver allows the kernel to import arbitrary
>           PCI devices from a PCI backend to support PCI driver domains.
>
> +choice
> +       prompt "PCI Express hierarchy optimization setting"
> +       default PCIE_BUS_DEFAULT
> +       depends on PCI && EXPERT
> +       help
> +         MPS (Max Payload Size) and MRRS (Max Read Request Size) are PCIe
> +         device parameters that affect performance and the ability to
> +         support hotplug and peer-to-peer DMA.
> +
> +         The following choices set the MPS and MRRS optimization strategy
> +         at compile-time.  The choices are the same as those offered for
> +         the kernel command-line parameter 'pci', i.e.,
> +         'pci=pcie_bus_tune_off', 'pci=pcie_bus_safe',
> +         'pci=pcie_bus_perf', and 'pci=pcie_bus_peer2peer'.
> +
> +         This is a compile-time setting and can be overridden by the above
> +         command-line parameters.  If unsure, choose PCIE_BUS_DEFAULT.
> +
> +config PCIE_BUS_TUNE_OFF
> +       bool "Tune Off"
> +       depends on PCI
> +       help
> +         Use the BIOS defaults; don't touch MPS at all.  This is the same
> +         as booting with 'pci=pcie_bus_tune_off'.
> +
> +config PCIE_BUS_DEFAULT
> +       bool "Default"
> +       depends on PCI
> +       help
> +         Default choice; ensure that the MPS matches upstream bridge.
> +
> +config PCIE_BUS_SAFE
> +       bool "Safe"
> +       depends on PCI
> +       help
> +         Use largest MPS that boot-time devices support.  If you have a
> +         closed system with no possibility of adding new devices, this
> +         will use the largest MPS that's supported by all devices.  This
> +         is the same as booting with 'pci=pcie_bus_safe'.
> +
> +config PCIE_BUS_PERFORMANCE
> +       bool "Performance"
> +       depends on PCI
> +       help
> +         Use MPS and MRRS for best performance.  Ensure that a given
> +         device's MPS is no larger than its parent MPS, which allows us to
> +         keep all switches/bridges to the max MPS supported by their
> +         parent.  This is the same as booting with 'pci=pcie_bus_perf'.
> +
> +config PCIE_BUS_PEER2PEER
> +       bool "Peer2peer"
> +       depends on PCI
> +       help
> +         Set MPS = 128 for all devices.  MPS configuration effected by the
> +         other options could cause the MPS on one root port to be
> +         different than that of the MPS on another, which may cause
> +         hot-added devices or peer-to-peer DMA to fail.  Set MPS to the
> +         smallest possible value (128B) system-wide to avoid these issues.
> +         This is the same as booting with 'pci=pcie_bus_peer2peer'.
> +
> +endchoice
> +
>  source "drivers/pci/hotplug/Kconfig"
>  source "drivers/pci/controller/Kconfig"
>  source "drivers/pci/endpoint/Kconfig"
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a458c46d7e39..49b66ba7c874 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -101,7 +101,19 @@ unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
>  #define DEFAULT_HOTPLUG_BUS_SIZE       1
>  unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
>
> +
> +/* PCIE bus config, can be overridden by bootline param */
> +#ifdef CONFIG_PCIE_BUS_TUNE_OFF
> +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
> +#elif defined CONFIG_PCIE_BUS_SAFE
> +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_SAFE;
> +#elif defined CONFIG_PCIE_BUS_PERFORMANCE
> +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PERFORMANCE;
> +#elif defined CONFIG_PCIE_BUS_PEER2PEER
> +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PEER2PEER;
> +#else
>  enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
> +#endif
>
>  /*
>   * The default CLS is used if arch didn't set CLS explicitly and not

--0000000000008f8d2305b08e276a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKlyjnxfqZv3
rGdWIYXZf/zVYBsj3s6HT7UQf/UwbCDHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMDkzMDIwNTc1OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBbJfcb0gCqAPqk5u/WD1E6uBPyl/iZ
7Go+OaC5etlKMhGgqrF1cHFHDargVG7qssIw2t1s3aD8I7kwjSd8Rfdt8Y0mc0MaYa4YUH+d+SZg
YY1djYk7DFtIJrTNFIw1nleN1qKsTLXDBYV8tFX9tzXFif5yuoKwwuHN2sWm1usmW7uKkot82PTF
dcYZnkShKBtI2doobmmm3vedbrXe+SVYQpjH13wl8YTa4+BVfPT2fCrQGiblac21VDyheeAJqEF0
Lc5cvINU99gDmtYRKs5Yxht59XIrihihF4q48p//hn+rXcNWInVokv3y2UaSKbebiFC49fLpe+C7
pDXz2LUT
--0000000000008f8d2305b08e276a--

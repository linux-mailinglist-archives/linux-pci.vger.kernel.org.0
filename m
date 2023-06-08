Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35828728A0F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 23:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFHVPl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 17:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjFHVPl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 17:15:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62BF2D51
        for <linux-pci@vger.kernel.org>; Thu,  8 Jun 2023 14:15:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6d7abe9a4so8071695e9.2
        for <linux-pci@vger.kernel.org>; Thu, 08 Jun 2023 14:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686258936; x=1688850936;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGo6q8CFqycxdwIyk4qofu5T89TIlzpWnCT0fOn4bI8=;
        b=GUiJeaLZgpWbV2cTJz3J1yxO2yqIk1th92KYq0TskycOEvHWobfjJe4P77agrc78Dk
         C6Q+pCKw4/NC6FPrjG+YK+HvEPLG5+/bspk+uttiILYDUZRr1XPf4NlDnq+W/oUzq4oQ
         9sYvzx7FZ6oBqGEau+ouxr6F8eRPRa9JfupmDFskDO1N/gcDabhwzW/y/beMXWRbZjBU
         W2OTL0CfqxAWJiNxwUcZw25fIrcoPhqbaEg3QLdDZ1ndj9y28j6YnFLzyy4OMcBCvNRN
         MVVvRhpfyJi+Vz2UB41p89ACyPFqsfxrIbB9iZQ1qaAjhjIJbEDUjihMVlnmMqpAxSFK
         qAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686258936; x=1688850936;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGo6q8CFqycxdwIyk4qofu5T89TIlzpWnCT0fOn4bI8=;
        b=JlSiZAD9qtxMqbphnK99xAEZPHECru1INUEtr0LB2eBBIz5jj86Z4cMEclR2Nc5iaJ
         S2Yg5m+HwVyMBZwZnfo64FAjrXLR5pYf+UgCSTpubRhOgg8R57AVQF+Fdl9V32p8+9/F
         HkAaE02HugR2HZWQFSqa3/xqgGPslToPDJDQBm2ulDG3NUKMjh3S01iUP7brwtlGArxP
         T1NLXag9MpZnP4DNDCJmRhBd5MM0gBk/B/p+3QkowFjCUHsI2BrwKx1Ss+pWfoucHvyC
         T7MES3OM2/qaJ8JLZCJQJGUDncq7iEipArkZp0Nk6KGPQRuphBjFiktKZ5pYVZcJlcWR
         TMFg==
X-Gm-Message-State: AC+VfDx2t/3D+AisEDh8YGXBHOqrNHpUt7F0JaRZ/CHCZm8FIVBIMxeh
        Whj8NySbHJPwgkdlbq7nKhRwgAOOcHY=
X-Google-Smtp-Source: ACHHUZ5MK1gLh/HxZEatPenvQZgf4mM4f0IVhVFm46KddJWEm3cHoBaR5PtDzVsC1oHHCv+/Uwj+HQ==
X-Received: by 2002:a05:600c:3797:b0:3f7:3699:c294 with SMTP id o23-20020a05600c379700b003f73699c294mr2113060wmr.29.1686258935945;
        Thu, 08 Jun 2023 14:15:35 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:103:11d0:c065:4df7:cfe1:b2cc])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c22d100b003f8044b3436sm300900wmg.23.2023.06.08.14.15.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2023 14:15:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: Old Asus doesn't seem to support MSI
From:   Damien Dejean <dam.dejean@gmail.com>
In-Reply-To: <20230608162105.GA1195684@bhelgaas>
Date:   Thu, 8 Jun 2023 23:15:24 +0200
Cc:     linux-pci@vger.kernel.org,
        =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <83D038E9-B36D-4200-8A1E-C6B1EA6FE0E4@gmail.com>
References: <20230608162105.GA1195684@bhelgaas>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> 1) Krzysztof found a slightly newer BIOS for your system [1].  It's
> conceivable that could help.

I already updated the laptop with this BIOS but it changed nothing.

> 2) If you happen to have Windows, AIDA64 [2] can tell us whether it
> uses MSI.

I don=E2=80=99t have Windows available on this laptop anymore, however =
if I find a way to install it I=E2=80=99ll do, if I can run AIDA that =
will help.

Before doing the quirk I found a lead. At the time the laptop was =
released there was a small linux system running on it called =C2=AB Asus =
Express Gate =C2=BB. The sources are available on the same website that =
you and Krzysztof pointed out. The kernel used was pretty old (2.6.25.4) =
however I found some interesting information:

- the kernel configuration contains the following configuration for PCI:
  CONFIG_PCI=3Dy
  CONFIG_PCI_GOANY=3Dy
  CONFIG_PCI_BIOS=3Dy
  CONFIG_PCI_DIRECT=3Dy
  CONFIG_PCI_MMCONFIG=3Dy
  CONFIG_PCI_DOMAINS=3Dy
  CONFIG_ARCH_SUPPORTS_MSI=3Dy
  CONFIG_PCI_MSI=3Dy
  CONFIG_PCI_LEGACY=3Dy
  CONFIG_HT_IRQ=3Dy
  CONFIG_ISA_DMA_API=3Dy
  So I guess MSI is expected to work.

- there=E2=80=99s another patch provided:

diff -Naurp linux-2.6.25.4/drivers/acpi/osl.c =
linux-2.6.25.4-mod/drivers/acpi/osl.c
--- linux-2.6.25.4/drivers/acpi/osl.c	2008-05-15 23:00:12.000000000 =
+0800
+++ linux-2.6.25.4-mod/drivers/acpi/osl.c	2008-09-08 =
11:31:38.000000000 +0800
@@ -132,7 +132,7 @@ static char osi_additional_string[OSI_ST
  * not ignore it will require a kernel source update to
  * add a DMI entry, or a boot-time "acpi_osi=3DLinux" invocation.
  */
-#define OSI_LINUX_ENABLE 0
+#define OSI_LINUX_ENABLE 1
=20
 static struct osi_linux {
 	unsigned int	enable:1;

I=E2=80=99m not sure to understand exactly what it does, but do you =
think that adding api_osi=3DLinux would help ?

Damien


> Le 8 juin 2023 =C3=A0 18:21, Bjorn Helgaas <helgaas@kernel.org> a =
=C3=A9crit :
>=20
> [+cc Krzysztof]
>=20
> On Thu, Jun 08, 2023 at 09:57:32AM +0200, Damien Dejean wrote:
>> Thanks for digging into this!
>>=20
>>> It's also conceivable that MSI used to work in older kernels, but we
>>> broke something by v5.10.  Do you know whether any old kernels ever
>>> worked without "pci=3Dnomsi=E2=80=9D?
>>=20
>> I remember trying older linux distributions (Debian oldstable,
>> kernel 4.19) and some older Ubuntu(s) but I don=E2=80=99t remember =
any of
>> them working. Plus, the Ubuntu wiki pages and various post replies
>> to =E2=80=9C=E2=80=A6 Linux is not working on my x73sl laptop=E2=80=9D =
are always suggesting
>> the pci=3Dnomsi option, so I guess the problem exists since a while.
>=20
> OK, more ideas:
>=20
> 1) Krzysztof found a slightly newer BIOS for your system [1].  It's
> conceivable that could help.
>=20
> 2) If you happen to have Windows, AIDA64 [2] can tell us whether it
> uses MSI.
>=20
> 3) I'm inclined to add the attached quirk, which disables MSI on any
> machine with this chipset.  Should fix your ASUS X73SL, and could also
> fix other platforms with the same chipset.  May slow down other
> platforms where MSI *does* work.
>=20
> 4) If needed, we could make the quirk specific to ASUS X73SL.
>=20
> Bjorn
>=20
> [1] https://www.asus.com/us/supportonly/x73sl/helpdesk_bios/
> [2] https://www.aida64.com/downloads
>=20
>=20
> commit 240bbd06303f ("PCI: Disable MSI on SiS 671")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Jun 8 10:13:11 2023 -0500
>=20
>    PCI: Disable MSI on SiS 671
>=20
>    Damien reports that MSI doesn't work on the SiS 671 chipset, at =
least on
>    this platform:
>=20
>      DMI: ASUSTeK Computer Inc.  F70SL/F70SL     , BIOS 211     =
02/18/2009
>      pci 0000:00:00.0: [1039:0671] type 00 class 0x060000
>=20
>    This prevents devices, e.g., NVIDIA GeForce 9300M GS GPU and an =
Atheros
>    mini PCIe wifi adapter, from working.  Disable MSI completely on =
any
>    platform with this chipset.
>=20
>    I assume MSI *does* work on Windows on this platform, so there may =
be a
>    chipset driver or something that configures it.  It's possible that =
MSI
>    does work on different platforms with SiS 671, so if anybody cares, =
we
>    *could* make this specific to the ASUS F70SL.
>=20
>    Link: =
https://lore.kernel.org/r/19F46F0C-E9C8-489E-8AA5-2A16E13A6FE9@gmail.com
>    Reported-by: Damien Dejean <dam.dejean@gmail.com>
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f4e2a88729fd..adc58ce82d76 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2585,6 +2585,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, =
PCI_DEVICE_ID_VIA_VT3336, quirk_disab
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3351, =
quirk_disable_all_msi);
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3364, =
quirk_disable_all_msi);
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8380_0, =
quirk_disable_all_msi);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI, 0x0671, =
quirk_disable_all_msi);
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI, 0x0761, =
quirk_disable_all_msi);
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa5e3, =
quirk_disable_all_msi);
>=20


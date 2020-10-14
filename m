Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0295E28DB32
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 10:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgJNIZD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 04:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbgJNITf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2020 04:19:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE97C05112C;
        Wed, 14 Oct 2020 01:00:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a3so3442690ejy.11;
        Wed, 14 Oct 2020 01:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8cAshw9w9g+tb5Wga6crJkHmZaZvSDhk98YhcxthM3g=;
        b=Gw1+k6GaIZIOqOScQ2WBuYIWesxGm1IIlTnWn3DPl5FPq/MC5CcCjV9+eik/2N5fO+
         BP+YHo9PbSxbQ+URpvt4NSPqIxbH2GEHYnJuBNUjhDA6/VnavJxF4z+Gg4zCMH1uW7DA
         o4n3oziqf2INvMG/1Z35vw4mSUloHw0RgnVHfgm4hMIzP1YQ4Pt+12eGSzZvJA5SZsV/
         amXvbThF7HCQoiKgAKgbk9gB4Avmldyvx69BEXEMCId6/0QV1r8nvVn7HBXRFapdaPgb
         12XwQMLJ0BFv2l1iIDqsk9M4Q/koDEZ2XWPO+5mhS0m53TUa5XStubu6UL+YpxOwP/ap
         IIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8cAshw9w9g+tb5Wga6crJkHmZaZvSDhk98YhcxthM3g=;
        b=bndgkcDA0iOeTbtaeQ1EAV0GNTQ/Pwn+41EFp8P7O86FXfcQ9wMSzDELWWv6xzoIE5
         4jBEw5wcXAVxh3UfFenQShWMehi0tpYZQssYo4lXjDWbkVFudqcMPHIcMuSpsT9p1nyS
         hspDvPExTWwDMvd8bn/+sDhulXgp7qH0SQxY2vPoCdfhwSooueEHX4OCH7CoXGqVhMHF
         mxnNT4xAmbW+B6IoalxbZMS3eEOv7kgMrNi+awtxdPyxS0zM9bAnkgr5qQ6FMFgzCOyi
         lXDMWdQwdtHNai02M5lVSZndJfJEqPlONx9MvMfXNVX/8guLIXoJQ4gDeOI9QCjGL3qb
         YBhQ==
X-Gm-Message-State: AOAM533pgAJoHMaVzvZv0K03Kx8kRNkd/NGT94UFyQeRYvaMugZoefuq
        Fzvry9C3gPk5DlPWrJbMLRDJJeBHDM3lwbRlSiI=
X-Google-Smtp-Source: ABdhPJxkH9r6BW9EGqcYbZTg0uRIMpguiE/ZlQJjnRiOA896kinPXGtVBYwALXHHySAjYv6Ik2073C0XAilbo3RAFJs=
X-Received: by 2002:a17:906:745:: with SMTP id z5mr4212217ejb.408.1602662415913;
 Wed, 14 Oct 2020 01:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20201012210522.GA86612@otc-nc-03> <9b7db59d-832c-1c21-90b6-1676ea9058ce@linux.intel.com>
In-Reply-To: <9b7db59d-832c-1c21-90b6-1676ea9058ce@linux.intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Wed, 14 Oct 2020 16:00:04 +0800
Message-ID: <CAKF3qh0tykZV9-wrxqg-n1r-m+J1YL2L-s2j+wSPVRPw9k2sPA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PCI/ERR: Call pci_bus_reset() before calling
 ->slot_reset() callback
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        sathyanarayanan.nkuppuswamy@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please fix the building issue.

drivers/pci/pcie/err.c:144:25: error: static declaration of
=E2=80=98pcie_do_fatal_recovery=E2=80=99 follows non-static declaration
 static pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
                         ^~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/pci/pcie/err.c:21:
drivers/pci/pcie/../pci.h:560:18: note: previous declaration of
=E2=80=98pcie_do_fatal_recovery=E2=80=99 was here
 pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
                  ^~~~~~~~~~~~~~~~~~~~~~
drivers/pci/pcie/err.c:144:25: warning: =E2=80=98pcie_do_fatal_recovery=E2=
=80=99
defined but not used [-Wunused-function]
 static pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,


Thanks,
Ethan

On Tue, Oct 13, 2020 at 10:18 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 10/12/20 2:05 PM, Raj, Ashok wrote:
> > On Sun, Oct 11, 2020 at 10:03:40PM -0700, sathyanarayanan.nkuppuswamy@g=
mail.com wrote:
> >> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.int=
el.com>
> >>
> >> Currently if report_error_detected() or report_mmio_enabled()
> >> functions requests PCI_ERS_RESULT_NEED_RESET, current
> >> pcie_do_recovery() implementation does not do the requested
> >> explicit device reset, but instead just calls the
> >> report_slot_reset() on all affected devices. Notifying about the
> >> reset via report_slot_reset() without doing the actual device
> >> reset is incorrect. So call pci_bus_reset() before triggering
> >> ->slot_reset() callback.
> >>
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@=
linux.intel.com>
> >> ---
> >>   drivers/pci/pcie/err.c | 6 +-----
> >>   1 file changed, 1 insertion(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> >> index c543f419d8f9..067c58728b88 100644
> >> --- a/drivers/pci/pcie/err.c
> >> +++ b/drivers/pci/pcie/err.c
> >> @@ -181,11 +181,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev =
*dev,
> >>      }
> >>
> >>      if (status =3D=3D PCI_ERS_RESULT_NEED_RESET) {
> >> -            /*
> >> -             * TODO: Should call platform-specific
> >> -             * functions to reset slot before calling
> >> -             * drivers' slot_reset callbacks?
> >> -             */
> >> +            pci_reset_bus(dev);
> >
> > pci_reset_bus() returns an error, do you need to consult that before
> > unconditionally setting PCI_ERS_RESULT_RECOVERED?
> Good point. I will fix this in next version.
> >
> >>              status =3D PCI_ERS_RESULT_RECOVERED;
> >>              pci_dbg(dev, "broadcast slot_reset message\n");
> >>              pci_walk_bus(bus, report_slot_reset, &status);
> >> --
> >> 2.17.1
> >>
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer

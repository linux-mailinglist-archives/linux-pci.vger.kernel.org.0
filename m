Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8193F2D08
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 15:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbhHTNVO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 09:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238228AbhHTNVO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Aug 2021 09:21:14 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F58C061575;
        Fri, 20 Aug 2021 06:20:36 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id k65so18737309yba.13;
        Fri, 20 Aug 2021 06:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4mPqaVlukDDFG+TscWvZ4jnQjqXu0/EIxO1u7KNhy0=;
        b=PJnfuZLqvqSpkXanRFW2UmTJJht/11VW6Oka5UdEdlA3NYzaKL0rABICyHhxLLiXy5
         9djhU/pW+liBA7D76sI98/fqLIN6mpphtaxa6op3ZxBTnzGgoAUgOx6HGsqs3Tl7csQQ
         xKWgIoPemM8icLv71gHIkO6t4e2//w6oKfKOiVqgqPLQAEsDCSL3ltkj+2AjbAo1PEvQ
         4SfXRiKjlG7BohxhfkRFyR89zFWPSBeZHMT/Ncp5j0F//fr7TAm+rAj4HLblLHk2b1Vz
         Dlvnf4yxjcN6A4w1GITV6XyUWkGZI2ZAW1hpXgBPmVeJTh3lJisF5gml9ZkRbmXSMUpP
         VRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4mPqaVlukDDFG+TscWvZ4jnQjqXu0/EIxO1u7KNhy0=;
        b=fGE9llWp/wvC+PnhL/GLbccEjsgcx5SNX58G4npyqk8rRSVtanh75ts2PEUThNf3Jk
         YksS18qGm4QbH6EUo08CzyDRto+maL2//IRncARIGQMLajNILf3LDVPeRBwKrX9hdEzr
         2nX6tSrMfZ5LaeL9aV//EEMrzICduYWeGCv5LXrAR62TDeoan29OTspGD66CfXNVZyOQ
         ZSyxqHGOOzFVsdcVTmauEyw48IWenAxDUiuCRepqN7+gmPN3eFQAWQvU+1s02UTiInPY
         soyoU4ciAEfR8PrTLtdWxWrj3UdK8piwIYg9Ge7lBm/XdOxTtTLYIEc3N3OfPwpbHkrN
         hluw==
X-Gm-Message-State: AOAM532ut7tSjwabtimxfSlrkzbHPhOX43MLEbihb9Tmh6jQOiGRHVCm
        hPLMWR76KDRFTjn3ZVKRRUpdLnVaw9I6pzZ9CLg=
X-Google-Smtp-Source: ABdhPJys2DSaGtqoT8h5EA1qRXRHCanUJcUbZJPKuRoDWhujTTxSyElBX/p4G++f9TqaK96euKD5PLV2w7l4/jsfI1I=
X-Received: by 2002:a25:f310:: with SMTP id c16mr23596476ybs.464.1629465635574;
 Fri, 20 Aug 2021 06:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210819145114.21074-1-lukas.bulwahn@gmail.com> <20210819150703.GA3204796@bjorn-Precision-5520>
In-Reply-To: <20210819150703.GA3204796@bjorn-Precision-5520>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 20 Aug 2021 15:20:32 +0200
Message-ID: <CAKXUXMw4TRocPRb2ROOBbGSGBVv5_y+bE-2koiEr-=b+skfzSg@mail.gmail.com>
Subject: Re: [PATCH] mei: improve Denverton HSM & IFSI support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 19, 2021 at 5:07 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Alex]
>
> On Thu, Aug 19, 2021 at 04:51:14PM +0200, Lukas Bulwahn wrote:
> > The Intel Denverton chip provides HSM & IFSI. In order to access
> > HSM & IFSI at the same time, provide two HECI hardware IDs for accessing.
> >
> > Suggested-by: Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.com>
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Tomas, please pick this quick helpful extension for the hardware.
> >
> >  drivers/misc/mei/hw-me-regs.h | 3 ++-
> >  drivers/misc/mei/pci-me.c     | 1 +
> >  drivers/pci/quirks.c          | 3 +++
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
> > index cb34925e10f1..c1c41912bb72 100644
> > --- a/drivers/misc/mei/hw-me-regs.h
> > +++ b/drivers/misc/mei/hw-me-regs.h
> > @@ -68,7 +68,8 @@
> >  #define MEI_DEV_ID_BXT_M      0x1A9A  /* Broxton M */
> >  #define MEI_DEV_ID_APL_I      0x5A9A  /* Apollo Lake I */
> >
> > -#define MEI_DEV_ID_DNV_IE     0x19E5  /* Denverton IE */
> > +#define MEI_DEV_ID_DNV_IE    0x19E5  /* Denverton for HECI1 - IFSI */
> > +#define MEI_DEV_ID_DNV_IE_2  0x19E6  /* Denverton 2 for HECI2 - HSM */
> >
> >  #define MEI_DEV_ID_GLK        0x319A  /* Gemini Lake */
> >
> > diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
> > index c3393b383e59..30827cd2a1c2 100644
> > --- a/drivers/misc/mei/pci-me.c
> > +++ b/drivers/misc/mei/pci-me.c
> > @@ -77,6 +77,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
> >       {MEI_PCI_DEVICE(MEI_DEV_ID_APL_I, MEI_ME_PCH8_CFG)},
> >
> >       {MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE, MEI_ME_PCH8_CFG)},
> > +     {MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE_2, MEI_ME_PCH8_SPS_CFG)},
> >
> >       {MEI_PCI_DEVICE(MEI_DEV_ID_GLK, MEI_ME_PCH8_CFG)},
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 6899d6b198af..2ab767ef8469 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4842,6 +4842,9 @@ static const struct pci_dev_acs_enabled {
> >       { PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
> >       { PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
> >       { PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_rciep_acs },
> > +     /* Denverton */
> > +     { PCI_VENDOR_ID_INTEL, 0x19e5, pci_quirk_mf_endpoint_acs },
> > +     { PCI_VENDOR_ID_INTEL, 0x19e6, pci_quirk_mf_endpoint_acs },
>
> This looks like it should be a separate patch with a commit log that
> explains it.  For example, see these:
>
>   db2f77e2bd99 ("PCI: Add ACS quirk for Broadcom BCM57414 NIC")
>   3247bd10a450 ("PCI: Add ACS quirk for Intel Root Complex Integrated Endpoints")
>   299bd044a6f3 ("PCI: Add ACS quirk for Zhaoxin Root/Downstream Ports")
>   0325837c51cb ("PCI: Add ACS quirk for Zhaoxin multi-function devices")
>   76e67e9e0f0f ("PCI: Add ACS quirk for Amazon Annapurna Labs root ports")
>   46b2c32df7a4 ("PCI: Add ACS quirk for iProc PAXB")
>   01926f6b321b ("PCI: Add ACS quirk for HXT SD4800")
>
> It should be acked by somebody at Intel since this quirk relies on
> behavior of the device for VM security.
>

Bjorn, I will happily split this into two patches and follow the
general conventions as soon as we have somebody at Intel to confirm on
this email thread that the proposal basically makes sense or if this
is actually flawed and why (although it was initially proposed by
somebody at Intel in another off-list discussion).

Lukas

> >       /* QCOM QDF2xxx root ports */
> >       { PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
> >       { PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
> > --
> > 2.26.2
> >

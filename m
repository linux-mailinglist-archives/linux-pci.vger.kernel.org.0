Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDCA281663
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 17:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgJBPTd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 11:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBPTc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 11:19:32 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D3720719
        for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2020 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601651972;
        bh=E2ngZAd35qBennRnW6fv5FkHLqEzVHge407a/V5mMVk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sYwhyOfvQyTOcoetWhJii+kiSV1ZISC+rsriTr09WTGxArcd++sl+0dmd/5SlXtF0
         Uxjf6rViIsUeQC1TlqzCYrKR13XBoJzvVqIfqrR5ps5z7PjYnBBaxDeWsYAQmHSLK7
         VueduubVCJWfm9DXYHymhIQCfg0OeFrobxn6vFvM=
Received: by mail-ot1-f45.google.com with SMTP id a2so1677316otr.11
        for <linux-pci@vger.kernel.org>; Fri, 02 Oct 2020 08:19:32 -0700 (PDT)
X-Gm-Message-State: AOAM533rnsOYSeB/TMzTeEEdOsrjY2f0tezo28MenroOIyAby/ZFNLqx
        3KfV9hnUuiIhlo+zlacnmjlFDvyIVey3pUd8og==
X-Google-Smtp-Source: ABdhPJwhOTVyhWpPHWrhiSMfF989zYSN5QbgjiBlVYyQ7zgHV41356AfwRXbnda+pRI2reqHy7bYG0TEDPf7y9uc3/U=
X-Received: by 2002:a9d:7998:: with SMTP id h24mr2143035otm.192.1601651971437;
 Fri, 02 Oct 2020 08:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201001220244.1271878-1-kw@linux.com>
In-Reply-To: <20201001220244.1271878-1-kw@linux.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 2 Oct 2020 10:19:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJn3uhHgnWeStyADCntJFbG4WpgFW1MAcYR9W3m4o2P=g@mail.gmail.com>
Message-ID: <CAL_JsqJn3uhHgnWeStyADCntJFbG4WpgFW1MAcYR9W3m4o2P=g@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Unify ECAM constants in native PCI Express drivers
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 1, 2020 at 5:02 PM Krzysztof Wilczy=C5=84ski <kw@linux.com> wro=
te:
>
> Unify ECAM-related constants into a single set of standard constants
> defining memory address shift values for the byte-level address that can
> be used when accessing the PCI Express Configuration Space, and then
> move native PCI Express controller drivers to use newly introduced
> definitions retiring any driver-specific ones.
>
> The ECAM ("Enhanced Configuration Access Mechanism") is defined by the
> PCI Express specification (see PCI Express Base Specification, Revision
> 5.0, Version 1.0, Section 7.2.2, p. 676), thus most hardware should
> implement it the same way.  Most of the native PCI Express controller
> drivers define their ECAM-related constants, many of these could be
> shared, or use open-coded values when setting the .bus_shift field of
> the struct pci_ecam_ops.
>
> All of the newly added constants should remove ambiguity and reduce the
> number of open-coded values, and also correlate more strongly with the
> descriptions in the aforementioned specification (see Table 7-1
> "Enhanced Configuration Address Mapping", p. 677).
>
> There is no change to functionality.
>
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kw@linux.com>
> ---
> Changes in v3:
>   Updated commit message wording.
>   Updated regarding custom ECAM bus shift values and concerning PCI base
>   configuration space access for Type 1 access.
>   Refactored rockchip_pcie_rd_other_conf() and rockchip_pcie_wr_other_con=
f()
>   and removed the "busdev" variable.
>   Removed surplus "relbus" variable from nwl_pcie_map_bus() and
>   xilinx_pcie_map_bus().
>   Renamed the PCIE_ECAM_ADDR() macro to PCIE_ECAM_OFFSET().
>
> Changes in v2:
>   Use PCIE_ECAM_ADDR macro when computing ECAM address offset, but drop
>   PCI_SLOT and PCI_FUNC macros from the PCIE_ECAM_ADDR macro in favour
>   of using a single value for the device/function.
>
>  drivers/pci/controller/dwc/pcie-al.c        |  8 ++----
>  drivers/pci/controller/dwc/pcie-hisi.c      |  4 +--
>  drivers/pci/controller/pci-host-generic.c   |  4 +--
>  drivers/pci/controller/pci-thunder-ecam.c   |  2 +-
>  drivers/pci/controller/pci-thunder-pem.c    | 13 +++++++--
>  drivers/pci/controller/pci-xgene.c          | 13 +++++++--
>  drivers/pci/controller/pcie-rockchip-host.c | 27 +++++++++--------
>  drivers/pci/controller/pcie-rockchip.h      |  8 +-----
>  drivers/pci/controller/pcie-tango.c         |  2 +-
>  drivers/pci/controller/pcie-xilinx-nwl.c    |  9 ++----
>  drivers/pci/controller/pcie-xilinx.c        | 11 ++-----
>  drivers/pci/ecam.c                          |  4 +--
>  include/linux/pci-ecam.h                    | 32 +++++++++++++++++++++

What about vmd which I mentioned? I also found iproc and brcmstb are
ECAM (well, same shifts, but indirect addressing).

[...]

> +/*
> + * Enhanced Configuration Access Mechanism (ECAM)
> + *
> + * N.B. This is a non-standard platform-specific ECAM bus shift value.  =
For
> + * standard values defined in the PCI Express Base Specification see
> + * include/linux/pci-ecam.h.
> + */
> +#define XGENE_PCIE_ECAM_BUS_SHIFT      16

Isn't this just CAM? Though perhaps CAM on PCIe is not standard...

For CAM, there's also tegra, ftpci100, mvebu, and versatile. I think
I'd drop CAM from this patch and do all of those in a separate patch.

Rob

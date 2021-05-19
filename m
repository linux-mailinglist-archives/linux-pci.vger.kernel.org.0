Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DE6389439
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 18:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347415AbhESQ60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 12:58:26 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:36675 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237249AbhESQ60 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 12:58:26 -0400
Received: by mail-wr1-f43.google.com with SMTP id c14so12980813wrx.3;
        Wed, 19 May 2021 09:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=K1tSOOTiBF9/AaE/FAMk0G5YNwOF5SfPK3oSsE5qaSI=;
        b=ABCubQvN5ptYBRClf6dm0UP1ao6r1afeJI8zGWEUReqldjoGXnaZ/WIS5NBWpaiNQR
         2ipICoR2iaOwveXsSgo4Ytje6MVyrmCopTe7mAM/ro/k157UtGGtl/t7poGYdw2d5bit
         bbDuMYG5iEITSWfb9It2vlVm1vXhmH4jD9PD3LaFftI3KMibd6DmRVykxFNSZfPSkhGx
         eHiPEdT3CMc+5GUB4Ka+9f26nxyw8E+vEUZ47KXjhcyNN8nvKWdBHCptSOl0ZekBg3XR
         mzTx+JrJB89z+LeGSTKArwb7y0a4OvbBIZS4/fZR4pdcO8gKdCvFjhUf+Bc4UKaAMTpg
         WJJQ==
X-Gm-Message-State: AOAM531l3WKH69br4MmV2aWqAI3Ch9n0sIDOx3Xumr9TCjJEZjaToqwX
        BKo0JUnAzfjXkuoqAGr29VM=
X-Google-Smtp-Source: ABdhPJzzW8h+H51GKS3JbP93VaOcVYYNrsg9YzgTdH1Pc1YLvctraCr+UoKFEpTxu+657BQfTEoR1w==
X-Received: by 2002:a5d:6445:: with SMTP id d5mr16010564wrw.235.1621443425279;
        Wed, 19 May 2021 09:57:05 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id i11sm26841560wrq.26.2021.05.19.09.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 09:57:04 -0700 (PDT)
Date:   Wed, 19 May 2021 18:57:03 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Fix building Tegra194 PCIe driver
Message-ID: <20210519165703.GA589057@rocinante.localdomain>
References: <20210519163403.212362-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210519163403.212362-1-jonathanh@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jon,

> Commit 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
> errata") caused a couple build regressions for the Tegra194 PCIe driver
> which are:
> 
> 1. The Tegra194 PCIe driver can no longer be built as a module. This
>    was caused by removing the Makefile entry to build the pcie-tegra.c
>    based upon the CONFIG_PCIE_TEGRA194 option. Therefore, restore this
>    so that we can build the driver as a module if ACPI support is not
>    enabled in the kernel.
> 2. If CONFIG_PCIE_TEGRA194 is configured to build the driver as a
>    module, at the same time that CONFIG_ACPI and CONFIG_PCI_QUIRKS are
>    selected to build the driver into the kernel, then the necessary
>    functions in the driver to probe and remove the device when booting
>    with device-tree and not compiled into to the driver. This prevents
>    the PCIe devices being probed when booting with device-tree. Fix this
>    by using the IS_ENABLED() macro.

Thank you for fixing this!  Much appreciated.

There are also few build time warnings related to these changes you
mention above, as per:

  drivers/pci/controller/dwc/pcie-tegra194.c:259:18: warning: ‘event_cntr_data_offset’ defined but not used [-Wunused-const-variable=]
  drivers/pci/controller/dwc/pcie-tegra194.c:250:18: warning: ‘event_cntr_ctrl_offset’ defined but not used [-Wunused-const-variable=]
  drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning: ‘pcie_gen_freq’ defined but not used [-Wunused-const-variable=]

We could bill two birds with one stone, so to speak, and move these
variables into the block behind the CONFIG_PCIE_TEGRA194 and
CONFIG_PCIEASPM guards respectively, so that these symbols are no longer
unused.

Also, since this change fixes and issue introduced in a different
commit, then it would be prudent to add the "Fixes:" tag.

Krzysztof

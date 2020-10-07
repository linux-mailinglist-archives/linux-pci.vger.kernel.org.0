Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E0228661E
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 19:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgJGRlW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 13:41:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37505 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgJGRlW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 13:41:22 -0400
Received: by mail-oi1-f195.google.com with SMTP id t77so3360435oie.4;
        Wed, 07 Oct 2020 10:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2tkejhV+QuFeIWOyFwduIfZWNAaS8WIxtLLItp9kA84=;
        b=L151bja/s2zb73U7gBm/c3OSxCePybbayb9duBOIdWPXSMd9PZXNfsLbAarpMRRFi7
         HN326jClVhXF8gHoLLNoLngjoiQwI/CQRddN8ANLocE3KLIFu97NootDe3/3JFNNa5wl
         xKTYz365lpeP7KmosfwEBcZR1xjMRu099OW4r/2Vm+fspWWigea/AKJSOJ5KSeOJpTTK
         2eivzL3VaUrFYPT+Pm77/El/DlyI8VehJEPTQzoZf/U9TLP/eNOf3MTQfKnYHUtOzDHq
         auackWy8ANgrKWeEk71LGP+sHbwSJlb8mUElVm1T5Is4P2EWHFUqMTrBVOrvi0VfbpSM
         p0jg==
X-Gm-Message-State: AOAM530g+5Kinw0S7dtS9ancWXIjGM2p6GveLh+Nu6esSFajp2dfWrzy
        aejGyFdSCPXrakSRyfsLzan6iYCDadHM
X-Google-Smtp-Source: ABdhPJxy4/uInRR/gtoRZx5s94r1PKrLbTZqexPwokp6bMvw8z07Hv/IAIrmZFrzABmlkeIG7hXUGQ==
X-Received: by 2002:aca:d17:: with SMTP id 23mr2722546oin.9.1602092481310;
        Wed, 07 Oct 2020 10:41:21 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g7sm2027896otk.56.2020.10.07.10.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 10:41:20 -0700 (PDT)
Received: (nullmailer pid 432483 invoked by uid 1000);
        Wed, 07 Oct 2020 17:41:19 -0000
Date:   Wed, 7 Oct 2020 12:41:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] PCI: dwc: Fix MSI page leakage in suspend/resume
Message-ID: <20201007174119.GA376477@bogus>
References: <20200930091205.792d6c7c@xhacker.debian>
 <20200930091449.50ae0caf@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930091449.50ae0caf@xhacker.debian>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 30, 2020 at 09:15:25AM +0800, Jisheng Zhang wrote:
> Currently, dw_pcie_msi_init() allocates and maps page for msi, then
> program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
> may lose power during suspend-to-RAM, so when we resume, we want to
> redo the latter but not the former. If designware based driver (for
> example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
> msi page will be leaked.
> 
> As pointed out by Rob and Ard, there's no need to allocate a page for
> the MSI address, we could use an address in the driver data.
> 
> To avoid map the MSI msg again during resume, we move the map MSI msg
> from dw_pcie_msi_init() to dw_pcie_host_init().
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 18 ++++++++++-
>  .../pci/controller/dwc/pcie-designware-host.c | 32 +++++++++----------
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
>  3 files changed, 34 insertions(+), 18 deletions(-)

I'm working on some larger MSI clean-ups which should eliminate the 
dra7xx addition, but this is good enough for now.

Reviewed-by: Rob Herring <robh@kernel.org>

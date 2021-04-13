Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B22935DC6D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 12:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbhDMKVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 06:21:55 -0400
Received: from foss.arm.com ([217.140.110.172]:39938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241408AbhDMKVv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 06:21:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 562CE106F;
        Tue, 13 Apr 2021 03:21:30 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3981D3F73B;
        Tue, 13 Apr 2021 03:21:29 -0700 (PDT)
Date:   Tue, 13 Apr 2021 11:21:24 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH] PCI: dwc: move dw_pcie_iatu_detect() after host_init
 callback
Message-ID: <20210413102124.GA22755@lpieralisi>
References: <20210407131255.702054-1-dmitry.baryshkov@linaro.org>
 <CAA8EJpooq2-vw19YKeiFxWoM-=6DwnhjF+8M7sSACgjqdnHznw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpooq2-vw19YKeiFxWoM-=6DwnhjF+8M7sSACgjqdnHznw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 07, 2021 at 04:37:15PM +0300, Dmitry Baryshkov wrote:
> Hi,
> 
> On Wed, 7 Apr 2021 at 16:12, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > The commit 9ea483375ded ("PCI: dwc: Move forward the iATU detection
> > process") broke PCIe support on Qualcomm SM8250 (and maybe other
> > platforms) since it moves the call to dw_pcie_iatu_detect() at the
> > beginning of the dw_pcie_host_init(), before ops->host_init() callback.
> > Accessing PCIe registers at this point causes the board to reboot since
> > not all clocks are enabled, making PCIe registers unavailable.
> >
> > Move dw_pcie_iatu_detect() call after calling ops->host_init() callback,
> > so that all register are accessible.
> >
> > Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > Fixes: 9ea483375ded ("PCI: dwc: Move forward the iATU detection process")
> 
> Please disregard the Fixes: tag here, the patch in question came to me
> from a local tree, which I failed to notice.
> The patch still applies on top of the previously dropped patch (and it
> is the same fix as the one proposed for exynos by Marek Szyprowski at
> https://lore.kernel.org/linux-pci/b777ab31-e0b9-bbc0-9631-72b93097919e@samsung.com/.

Ok. Can you integrate Bjorn's changes (reported in the thread above) to
the commit log and resend it with Marek in CC so that I can merge it
please ?

Thanks,
Lorenzo

> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 52f6887179cd..24192b40e3a2 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -319,8 +319,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >                         return PTR_ERR(pci->dbi_base);
> >         }
> >
> > -       dw_pcie_iatu_detect(pci);
> > -
> >         bridge = devm_pci_alloc_host_bridge(dev, 0);
> >         if (!bridge)
> >                 return -ENOMEM;
> > @@ -400,6 +398,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >                 if (ret)
> >                         goto err_free_msi;
> >         }
> > +       dw_pcie_iatu_detect(pci);
> >
> >         dw_pcie_setup_rc(pp);
> >         dw_pcie_msi_init(pp);
> > --
> > 2.30.2
> >
> 
> 
> -- 
> With best wishes
> Dmitry

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC24B3E2184
	for <lists+linux-pci@lfdr.de>; Fri,  6 Aug 2021 04:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbhHFCbF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 22:31:05 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:50840 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbhHFCbE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Aug 2021 22:31:04 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 1762UM0Z018226; Fri, 6 Aug 2021 11:30:22 +0900
X-Iguazu-Qid: 2wHH6p2Z55RWRMUUb5
X-Iguazu-QSIG: v=2; s=0; t=1628217021; q=2wHH6p2Z55RWRMUUb5; m=XhIfeWvlkywXvJV7VPOP/gYb0Hv37lf82puMh8EKdu8=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1110) id 1762UJYa001048
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 6 Aug 2021 11:30:20 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id BB69910013E;
        Fri,  6 Aug 2021 11:30:19 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 1762UJOf000469;
        Fri, 6 Aug 2021 11:30:19 +0900
Date:   Fri, 6 Aug 2021 11:30:17 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] PCI: visconti: Add Toshiba Visconti PCIe host
 controller driver
X-TSB-HOP: ON
Message-ID: <20210806023017.jtd3uk3p7fgupy4m@toshiba.co.jp>
References: <20210723221421.113575-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210723221421.113575-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210805105908.GA19244@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805105908.GA19244@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thank you for your review.

On Thu, Aug 05, 2021 at 11:59:08AM +0100, Lorenzo Pieralisi wrote:
> On Sat, Jul 24, 2021 at 07:14:20AM +0900, Nobuhiro Iwamatsu wrote:
> > Add support to PCIe RC controller on Toshiba Visconti ARM SoCs. PCIe
> > controller is based of Synopsys DesignWare PCIe core.
> > 
> > This patch does not yet use the clock framework to control the clock.
> > This will be replaced in the future.
> 
> This is not relevant information. I expect the commit log to describe
> the change and the reasons behind the choices.

OK, I will drop this sentence.

> 
> Speaking of which, I'd like to understand what
> 
> > This patch does not yet use the clock framework to control the clock.
> 
> means and why it can't be done within this series.

Visconti5 has a clock control IP, but the driver for this is still under
development and has not been applied into mainline. Instead, the clock
for this driver is running using DT's fixed-clock. This will be
replaced by a clock driver.

> 
> > Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > 
> > ---
> >  drivers/pci/controller/dwc/Kconfig         |   9 +
> >  drivers/pci/controller/dwc/Makefile        |   1 +
> >  drivers/pci/controller/dwc/pcie-visconti.c | 333 +++++++++++++++++++++
> >  3 files changed, 343 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-visconti.c
> > 

<snip>

> > +
> > +static int
> > +visconti_add_pcie_port(struct visconti_pcie *pcie, struct platform_device *pdev)
> 
> Nit: don't split lines like this, it is better to keep return value
> type and function name in one single line.
> 
> Do it like this:
> 
> static int visconti_add_pcie_port(struct visconti_pcie *pcie,
>  				  struct platform_device *pdev)
> 

OK, I will fix in v6.

> Lorenzo
> 


Best regards,
  Nobuhiro


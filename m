Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D530C308FA0
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 22:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhA2VvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 16:51:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231169AbhA2VvH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jan 2021 16:51:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E617064D7F;
        Fri, 29 Jan 2021 21:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611957026;
        bh=vQA5KzxHuphY6TPIp7lU22R5TOoyWqbkWLYbeBGkZ14=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UoNG+jLwHxo8QHqOKgSc3rRnkDlQ48CKxbj5S472I3pSBMHB+pYY6LbtgVf2RR/dQ
         BH843idb7uW5lm9u2xOM+0jkB6Wu0da5NE1Xkf33zENWqdyuvJ7Cfpo6deSIqjYReI
         EsdxLraGuWnG4DAsxHUeOKoMlLZbPeFakfAg5UBIkSPLGSwlRmwHkbYw4JNLpcw27y
         ngYygTweOJDXyPOe3+CO2/lLnSTEpQmZshSc2Z9DiVq+zZy/YAS4D026oQmZizVksS
         mxlXPZaqHJpJyl2uk4Mr3eLA5JPLgE/W5O/Z5U9v57QIJjEgFrN/YQWAxcQXMYKsu4
         S+s7lnurqdnqQ==
Date:   Fri, 29 Jan 2021 15:50:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] pcie-qcom: provide a way to power up qca6390 chip
 on RB5 platform
Message-ID: <20210129215024.GA113900@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da0ac373-4edb-0230-b264-49697fa3d86a@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 29, 2021 at 06:45:21AM +0300, Dmitry Baryshkov wrote:
> On 28/01/2021 22:26, Rob Herring wrote:
> > On Thu, Jan 28, 2021 at 11:52 AM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > > 
> > > Some Qualcomm platforms require to power up an external device before
> > > probing the PCI bus. E.g. on RB5 platform the QCA6390 WiFi/BT chip needs
> > > to be powered up before PCIe0 bus is probed. Add a quirk to the
> > > respective PCIe root bridge to attach to the power domain if one is
> > > required, so that the QCA chip is started before scanning the PCIe bus.
> > 
> > This is solving a generic problem in a specific driver. It needs to be
> > solved for any PCI host and any device.
> 
> Ack. I see your point here.
> 
> As this would require porting code from powerpc/spark of-pci code and
> changing pcie port driver to apply power supply before bus probing happens,
> I'd also ask for the comments from PCI maintainers. Will that solution be
> acceptable to you?

I can't say without seeing the code.  I don't know enough about this
scenario to envision how it might look.

I guess the QCA6390 is a PCIe device?  Why does it need to be powered
up before probing?  Shouldn't we get a link-up interrupt when it is
powered up so we could probe it then?

Nit: when changing any file, please take a look at the commit history
and make yours match, e.g.,

  pcie-qcom: provide a way to power up qca6390 chip on RB5 platform

does not look like:

  PCI: qcom: Add support for configuring BDF to SID mapping for SM8250
  PCI: qcom: Add SM8250 SoC support
  PCI: qcom: Make sure PCIe is reset before init for rev 2.1.0
  PCI: qcom: Replace define with standard value
  PCI: qcom: Support pci speed set for ipq806x
  PCI: qcom: Add ipq8064 rev2 variant

Also, if you capitalize it as "QCA6390" in the commit log, do it the
same in the subject.

> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 21 +++++++++++++++++++++
> > >   1 file changed, 21 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index ab21aa01c95d..eb73c8540d4d 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -20,6 +20,7 @@
> > >   #include <linux/of_device.h>
> > >   #include <linux/of_gpio.h>
> > >   #include <linux/pci.h>
> > > +#include <linux/pm_domain.h>
> > >   #include <linux/pm_runtime.h>
> > >   #include <linux/platform_device.h>
> > >   #include <linux/phy/phy.h>
> > > @@ -1568,6 +1569,26 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
> > >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
> > >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
> > > 
> > > +static void qcom_fixup_power(struct pci_dev *dev)
> > > +{
> > > +       int ret;
> > > +       struct pcie_port *pp = dev->bus->sysdata;
> > > +       struct dw_pcie *pci;
> > > +
> > > +       if (!pci_is_root_bus(dev->bus))
> > > +               return;
> > > +
> > > +       ret = dev_pm_domain_attach(&dev->dev, true);
> > > +       if (ret < 0 || !dev->dev.pm_domain)
> > > +               return;
> > > +
> > > +       pci = to_dw_pcie_from_pp(pp);
> > > +       dev_info(&dev->dev, "Bus powered up, waiting for link to come up\n");
> > > +
> > > +       dw_pcie_wait_for_link(pci);
> > > +}
> > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x010b, qcom_fixup_power);
> > > +
> > >   static struct platform_driver qcom_pcie_driver = {
> > >          .probe = qcom_pcie_probe,
> > >          .driver = {
> > > --
> > > 2.29.2
> > > 
> 
> 
> -- 
> With best wishes
> Dmitry

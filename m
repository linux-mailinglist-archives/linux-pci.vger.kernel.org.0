Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C85A309031
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 23:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhA2WkE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 17:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhA2WkD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jan 2021 17:40:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACFE564DE2;
        Fri, 29 Jan 2021 22:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611959962;
        bh=gtCH5GZfQI8MluIOyF7uQerflv2m5cA28eg7Y4tpMqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H52nN0Lx35wvxyic37gQ6tDCZni9I59sR/0qRVv/tZxHwN4saXI9D7zpenw/booif
         Fxs+nMFJ8ld3c9CcBe/TYanpmu4mbx8LosV4RI6RXZlvDu8nqHQlsRJR6NBK45qJWF
         wzAlFK0fQ51GBYvgOg5PfL/7/NXkQgrWX5jPzczO70WfRDYD9VrbbFVhI3Vwhi/Zae
         snzmlOxiyuZia+bOQ6EQQOHepypBIEiqs8578zipjZFbPR/iRauJdbeh+gATUMvpbP
         XBomInTx1qMPjlm1i8MPDzU7ufYeYjT7zjB759D+qNqQvQkdbKfPlDMBfIvgxXhhoT
         EYKjHBHvxZHlA==
Date:   Fri, 29 Jan 2021 16:39:19 -0600
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] pcie-qcom: provide a way to power up qca6390 chip
 on RB5 platform
Message-ID: <20210129223919.GA119695@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoPsv5tfsaiJq4UnBYt3o+gJanWzy8aaZRK=V8yOk3mJQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 30, 2021 at 01:19:10AM +0300, Dmitry Baryshkov wrote:
> On Sat, 30 Jan 2021 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jan 29, 2021 at 06:45:21AM +0300, Dmitry Baryshkov wrote:
> > > On 28/01/2021 22:26, Rob Herring wrote:
> > > > On Thu, Jan 28, 2021 at 11:52 AM Dmitry Baryshkov
> > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > >
> > > > > Some Qualcomm platforms require to power up an external device before
> > > > > probing the PCI bus. E.g. on RB5 platform the QCA6390 WiFi/BT chip needs
> > > > > to be powered up before PCIe0 bus is probed. Add a quirk to the
> > > > > respective PCIe root bridge to attach to the power domain if one is
> > > > > required, so that the QCA chip is started before scanning the PCIe bus.
> > > >
> > > > This is solving a generic problem in a specific driver. It needs to be
> > > > solved for any PCI host and any device.
> > >
> > > Ack. I see your point here.
> > >
> > > As this would require porting code from powerpc/spark of-pci code and
> > > changing pcie port driver to apply power supply before bus probing happens,
> > > I'd also ask for the comments from PCI maintainers. Will that solution be
> > > acceptable to you?
> >
> > I can't say without seeing the code.  I don't know enough about this
> > scenario to envision how it might look.
> >
> > I guess the QCA6390 is a PCIe device?  Why does it need to be powered
> > up before probing?  Shouldn't we get a link-up interrupt when it is
> > powered up so we could probe it then?
> 
> Not quite. QCA6390 is a multifunction device, with PCIe and serial
> parts. It has internal power regulators which once enabled will
> powerup the PCIe, serial and radio parts. There is no need to manage
> regulators. Once enabled they will automatically handle device
> suspend/resume, etc.

OK, just elaborate on this a bit in the commit log so the topology
makes sense to someone with no prior knowledge of QCA6390.

Bjorn

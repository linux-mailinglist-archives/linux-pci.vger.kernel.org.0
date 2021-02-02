Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6F530CE05
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 22:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhBBViZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 16:38:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229838AbhBBViU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 16:38:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A41E64F6C;
        Tue,  2 Feb 2021 21:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612301859;
        bh=WQhFymcBJwzSaKny5e8069HtAAW5hqy+8n2aqdMz048=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zae7Br13c5qyuL8W6zJpv8V5zipTOmy/wkOop5dfviX8ALns9Z48pAfPwGsKD2JbT
         AiIZQKTJVgzB2yUaKD4i50dHqkRXrUp5uXibaMxYiD+6c1xhUYKPYIExm6orgE7t+m
         EMyNRS7VV5KXJ5ocub0T0eP0s95ipUBkrqgybCGtDAfyIhH4BP9I+9YTtS7PSQy5JW
         oM9UsHdXvgE2RpyRRgnUrL72qGU7MG7k/8N/CXxrqE3RZ4vq/AtZNJZrbih2y5mqwb
         daVOaIqLSPkmazacJJmV/L2eOOX6g/j7sU/RNQa+MOvQrD4r1S411JDCXjTYzvNDj5
         MBls8BwOY7eZw==
Received: by mail-ej1-f48.google.com with SMTP id rv9so32244995ejb.13;
        Tue, 02 Feb 2021 13:37:39 -0800 (PST)
X-Gm-Message-State: AOAM5328IHThMxaEILT10ckh0BXHPJ1qEJ0296lTTghuGqz+wD4GZRrI
        wtlcnEHOURsOQzSXjN+gEVRi3HQKs+EuXOv17g==
X-Google-Smtp-Source: ABdhPJwIIgQCzPuZgFkyhNc4/zoVa5ocVqi/rlJjRFNwra+uhcF11cZdf3H9V3XHnlWPyCm+S2X5jR7dra91NEpaIL8=
X-Received: by 2002:a17:906:958f:: with SMTP id r15mr16853ejx.360.1612301857659;
 Tue, 02 Feb 2021 13:37:37 -0800 (PST)
MIME-Version: 1.0
References: <da0ac373-4edb-0230-b264-49697fa3d86a@linaro.org>
 <20210129215024.GA113900@bjorn-Precision-5520> <CAA8EJpoPsv5tfsaiJq4UnBYt3o+gJanWzy8aaZRK=V8yOk3mJQ@mail.gmail.com>
 <YBTYKLi81Cf65yUB@builder.lan> <CAA8EJprwBKbGrh-BjrzkQTxoboUi470wYcn-gTBHdNQ1Af7DKA@mail.gmail.com>
 <YBmsjDiKnpQjYeQh@builder.lan>
In-Reply-To: <YBmsjDiKnpQjYeQh@builder.lan>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 2 Feb 2021 15:37:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJoKEVUs0f7rP87M3Wh6yVvB-bYi7vBprti8hoim3-e-A@mail.gmail.com>
Message-ID: <CAL_JsqJoKEVUs0f7rP87M3Wh6yVvB-bYi7vBprti8hoim3-e-A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] pcie-qcom: provide a way to power up qca6390 chip
 on RB5 platform
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Gross <agross@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 2, 2021 at 1:48 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Sat 30 Jan 10:14 CST 2021, Dmitry Baryshkov wrote:
>
> > On Sat, 30 Jan 2021 at 06:53, Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > On Fri 29 Jan 16:19 CST 2021, Dmitry Baryshkov wrote:
> > >
> > > > On Sat, 30 Jan 2021 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > >
> > > > > On Fri, Jan 29, 2021 at 06:45:21AM +0300, Dmitry Baryshkov wrote:
> > > > > > On 28/01/2021 22:26, Rob Herring wrote:
> > > > > > > On Thu, Jan 28, 2021 at 11:52 AM Dmitry Baryshkov
> > > > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Some Qualcomm platforms require to power up an external device before
> > > > > > > > probing the PCI bus. E.g. on RB5 platform the QCA6390 WiFi/BT chip needs
> > > > > > > > to be powered up before PCIe0 bus is probed. Add a quirk to the
> > > > > > > > respective PCIe root bridge to attach to the power domain if one is
> > > > > > > > required, so that the QCA chip is started before scanning the PCIe bus.
> > > > > > >
> > > > > > > This is solving a generic problem in a specific driver. It needs to be
> > > > > > > solved for any PCI host and any device.
> > > > > >
> > > > > > Ack. I see your point here.
> > > > > >
> > > > > > As this would require porting code from powerpc/spark of-pci code and
> > > > > > changing pcie port driver to apply power supply before bus probing happens,
> > > > > > I'd also ask for the comments from PCI maintainers. Will that solution be
> > > > > > acceptable to you?
> > > > >
> > > > > I can't say without seeing the code.  I don't know enough about this
> > > > > scenario to envision how it might look.
> > > > >
> > > > > I guess the QCA6390 is a PCIe device?  Why does it need to be powered
> > > > > up before probing?  Shouldn't we get a link-up interrupt when it is
> > > > > powered up so we could probe it then?
> > > >
> > > > Not quite. QCA6390 is a multifunction device, with PCIe and serial
> > > > parts. It has internal power regulators which once enabled will
> > > > powerup the PCIe, serial and radio parts. There is no need to manage
> > > > regulators. Once enabled they will automatically handle device
> > > > suspend/resume, etc.
> > > >
> > >
> > > So what you're saying is that if either the PCI controller or bluetooth
> > > driver probes these regulators will be turned on, indefinitely?
> > >
> > > If so, why do we need a driver to turn them on, rather than just mark
> > > them as always-on?
> > >
> > > What's the timing requirement wrt regulators vs WL_EN/BT_EN?
> >
> > According to the documentation I have, they must be enabled right
> > after enabling powering the chip and they must stay enabled all the
> > time.
> >
>
> So presumably just marking these things always-on and flipping the GPIO
> statically won't be good enough due to the lack of control over the
> timing.
>
> This really do look like a simplified case of what we see with the
> PCIe attached modems, where similar requirements are provided, but also
> the ability to perform a device specific reset sequence in case the
> hardware has locked up. I'm slightly worried about the ability of
> extending your power-domain model to handle the restart operation
> though.

I think this is an abuse of 'power-domains'. Just define the
regulators in both WiFi and BT nodes and have each driver enable them.
They're refcounted. If that's still not enough control over the power
sequencing, then create a 3rd entity to do it, but that doesn't need
to leak into DT. You already have all the information you need.

Rob

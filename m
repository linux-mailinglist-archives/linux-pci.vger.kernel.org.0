Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528893091D0
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jan 2021 05:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhA3EQT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 23:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbhA3DyL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jan 2021 22:54:11 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9735C0617AA
        for <linux-pci@vger.kernel.org>; Fri, 29 Jan 2021 19:53:15 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id n7so12232055oic.11
        for <linux-pci@vger.kernel.org>; Fri, 29 Jan 2021 19:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+1Tr4rpoXF+/sZZ5I0T9ItoAjN7uH4k91FkmXDfmqTI=;
        b=YaVkxLhL9Og3Yb8W+oDoOXxN13APSECdFqxwrv3HjAvWe2YN2Z3PiYnTHBzJh2kkUP
         p0AX6fbNVDG48OH4OBAADYquGku6kRDm1IRKF+4DCLmF313OKGU9FYdvbejVmBACZx9l
         dIg3Hv5WnPqMh1TuoKOMf5Qc7P65zgjKNGL1BOEzjWvC7zWfSylQyygWobhMK6i+ElO3
         uElPPoje+Q4ULXoqisyvFaZOLHg1vIhvMK1fC+joP3V+A0+hUU7VAQd/DymaxWVDMcBp
         KCfJ1/hrvLbKhRLFvHKL4dP0u2yRBOdBm0E5HCGmNda0G8iYag+5Pokhb693FE2HzfSk
         MmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+1Tr4rpoXF+/sZZ5I0T9ItoAjN7uH4k91FkmXDfmqTI=;
        b=smr8BfXOyA5XxdJ8KwtjzzLABefKsPDkZxccVLMSAIvOT1cs3NX/iPRrYcf7yK4KZV
         85p3HmGT7AmHM4qCYC/OT0KaHKNaDHH7UNBGHnJ7HpORugyojyXJm9WBzpiNcT5nEeUD
         T3J1o2JsYllyjzhfK/nKUQPyNKfB7QRUYYoSyGIsCrga9g6wVq0g0dnEU7rxXM6dw0Vf
         ceNQDeBBdHZWS5ZHLnGonQuOmaUSkl5i7q+z4SZpqXiON7C5zFTTj/zpzZucJ88brjko
         4w6mufWzAd1FFRkZOxdTcsC/3Rk27mOpm26t6Th/BNLiq5+NvX/5+Babu3EO1NHEIonh
         rkvQ==
X-Gm-Message-State: AOAM532zRJ4jmFYWTdGEDeybRIbWoDeemjcUbWVdTT2hGilTWjhmkNoH
        2lkinKloPtGjS23cb8/elGv7bw==
X-Google-Smtp-Source: ABdhPJyp8AUBdeEWbdmaLLvG3bP+gJFmEw0C4fEYwy/ThnxsTpe/Zz3E/Pq16ARiR2JpAZT2ER2lYw==
X-Received: by 2002:aca:d486:: with SMTP id l128mr4518873oig.70.1611978795094;
        Fri, 29 Jan 2021 19:53:15 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d11sm2810650oon.21.2021.01.29.19.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 19:53:14 -0800 (PST)
Date:   Fri, 29 Jan 2021 21:53:12 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH v2 3/5] pcie-qcom: provide a way to power up qca6390 chip
 on RB5 platform
Message-ID: <YBTYKLi81Cf65yUB@builder.lan>
References: <da0ac373-4edb-0230-b264-49697fa3d86a@linaro.org>
 <20210129215024.GA113900@bjorn-Precision-5520>
 <CAA8EJpoPsv5tfsaiJq4UnBYt3o+gJanWzy8aaZRK=V8yOk3mJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoPsv5tfsaiJq4UnBYt3o+gJanWzy8aaZRK=V8yOk3mJQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri 29 Jan 16:19 CST 2021, Dmitry Baryshkov wrote:

> On Sat, 30 Jan 2021 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
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
> 

So what you're saying is that if either the PCI controller or bluetooth
driver probes these regulators will be turned on, indefinitely?

If so, why do we need a driver to turn them on, rather than just mark
them as always-on?

What's the timing requirement wrt regulators vs WL_EN/BT_EN?

Regards,
Bjorn A

> I'm not sure about link-up interrupt. I've just lightly tested using
> PCIe HP on this port, getting no interrupts from it.
> If I manually rescan the bus after enabling the qca6390 device (e.g.
> via sysfs), it gets enabled, but then I see PCIe link errors (most
> probably because the PCIe link was not retrained after the device
> comes up).
> 
> > Nit: when changing any file, please take a look at the commit history
> > and make yours match, e.g.,
> >
> >   pcie-qcom: provide a way to power up qca6390 chip on RB5 platform
> >
> > does not look like:
> 
> Ack.
> 
> 
> -- 
> With best wishes
> Dmitry

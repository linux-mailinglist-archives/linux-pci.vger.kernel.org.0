Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9AD30968F
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jan 2021 17:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhA3QPo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Jan 2021 11:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhA3QPV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jan 2021 11:15:21 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC53C061786
        for <linux-pci@vger.kernel.org>; Sat, 30 Jan 2021 08:14:52 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id r77so11873892qka.12
        for <linux-pci@vger.kernel.org>; Sat, 30 Jan 2021 08:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZW9/30ZgBdjsQF6ELbAndLfZM5KKodhdtFyYrqkzGHo=;
        b=aK4pYBjPylxJwoy9KBdrEeHpbtFm4YSFEZu2cql7L3iZT9UP9Ooj8Ds95rVv8HbRPn
         ZN+sQRolh7iN7/vu7L45CCzoPgV6z1NN/fwRD3jgLKUxnpGz9yJBTC0DChSsPT0ISsCA
         4JVsnuGavXGPZb74fGnZHQP98fguwcCGlS0uNzr66QQekDwazpeNs397kcqQT1Uw27Z9
         77WIYxnEI5gBgg1Yfhv72YgM7wewytpWawXpsGd7yG/LcEj95Tx4ny/6AgOj3zQaLPap
         jZ4hROph4FxAx/pThCzrfqfhVhqQp/N9uwXLcKvcqwLig7SoMv7hIGdCDY52azJAx7Ty
         uzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZW9/30ZgBdjsQF6ELbAndLfZM5KKodhdtFyYrqkzGHo=;
        b=YOwaczTirTgtxHcYqof4ptGYwI4PP6fCOSDnzuBol1pXuvvJSsf7p/xlf87+JRLomb
         foEdkfUHW78Myy/dzJCvp25UvIqAF5XgV0yobbHYUvdiK054KT5jh/71t9gdaNuEnksC
         7qZ6pc/9G2X9YS+MJEDexmWOEIhTrh8z8CWG68nthyjCUqeulqHrIQclDRFL9C9ufcRb
         JXj7d4coRuFTUPWpuelfWaJ2NuIqOKniSNXcWpj16OEC6nRQT26a6RvWRu6l9EJUw7pE
         LAsir27QtZC8x+Ii3AisqgDVP4eocAwUyVV69nh76t2TTnV+DrZmeNH4ZvNgSZ8bMN4O
         nPGQ==
X-Gm-Message-State: AOAM531l9WpBQbKfbaOS1mG38lSedFlMOQHt9AIIo5q0PP8zJwer6zVj
        1hIMA2R04xcIpT1QvyGMAGXbMR1jMu18Ld0tgCz+lA==
X-Google-Smtp-Source: ABdhPJzvVeT3yCHYO+uMeT1uDgk9TA//Bi2FqW9hASqtRKvrKij9Kcpks2iKouQWcQQi0mlWAR74RX2cK4uYhok4x0w=
X-Received: by 2002:a37:af46:: with SMTP id y67mr8534573qke.434.1612023291329;
 Sat, 30 Jan 2021 08:14:51 -0800 (PST)
MIME-Version: 1.0
References: <da0ac373-4edb-0230-b264-49697fa3d86a@linaro.org>
 <20210129215024.GA113900@bjorn-Precision-5520> <CAA8EJpoPsv5tfsaiJq4UnBYt3o+gJanWzy8aaZRK=V8yOk3mJQ@mail.gmail.com>
 <YBTYKLi81Cf65yUB@builder.lan>
In-Reply-To: <YBTYKLi81Cf65yUB@builder.lan>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 30 Jan 2021 19:14:40 +0300
Message-ID: <CAA8EJprwBKbGrh-BjrzkQTxoboUi470wYcn-gTBHdNQ1Af7DKA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] pcie-qcom: provide a way to power up qca6390 chip
 on RB5 platform
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 30 Jan 2021 at 06:53, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 29 Jan 16:19 CST 2021, Dmitry Baryshkov wrote:
>
> > On Sat, 30 Jan 2021 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Fri, Jan 29, 2021 at 06:45:21AM +0300, Dmitry Baryshkov wrote:
> > > > On 28/01/2021 22:26, Rob Herring wrote:
> > > > > On Thu, Jan 28, 2021 at 11:52 AM Dmitry Baryshkov
> > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > >
> > > > > > Some Qualcomm platforms require to power up an external device before
> > > > > > probing the PCI bus. E.g. on RB5 platform the QCA6390 WiFi/BT chip needs
> > > > > > to be powered up before PCIe0 bus is probed. Add a quirk to the
> > > > > > respective PCIe root bridge to attach to the power domain if one is
> > > > > > required, so that the QCA chip is started before scanning the PCIe bus.
> > > > >
> > > > > This is solving a generic problem in a specific driver. It needs to be
> > > > > solved for any PCI host and any device.
> > > >
> > > > Ack. I see your point here.
> > > >
> > > > As this would require porting code from powerpc/spark of-pci code and
> > > > changing pcie port driver to apply power supply before bus probing happens,
> > > > I'd also ask for the comments from PCI maintainers. Will that solution be
> > > > acceptable to you?
> > >
> > > I can't say without seeing the code.  I don't know enough about this
> > > scenario to envision how it might look.
> > >
> > > I guess the QCA6390 is a PCIe device?  Why does it need to be powered
> > > up before probing?  Shouldn't we get a link-up interrupt when it is
> > > powered up so we could probe it then?
> >
> > Not quite. QCA6390 is a multifunction device, with PCIe and serial
> > parts. It has internal power regulators which once enabled will
> > powerup the PCIe, serial and radio parts. There is no need to manage
> > regulators. Once enabled they will automatically handle device
> > suspend/resume, etc.
> >
>
> So what you're saying is that if either the PCI controller or bluetooth
> driver probes these regulators will be turned on, indefinitely?
>
> If so, why do we need a driver to turn them on, rather than just mark
> them as always-on?
>
> What's the timing requirement wrt regulators vs WL_EN/BT_EN?

According to the documentation I have, they must be enabled right
after enabling powering the chip and they must stay enabled all the
time.




-- 
With best wishes
Dmitry

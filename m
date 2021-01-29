Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493FF308FFE
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 23:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhA2WUN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 17:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbhA2WUC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jan 2021 17:20:02 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92DEC061756
        for <linux-pci@vger.kernel.org>; Fri, 29 Jan 2021 14:19:21 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 19so10347626qkh.3
        for <linux-pci@vger.kernel.org>; Fri, 29 Jan 2021 14:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVJSk/hfc058Boi6CmUOZdn8/0GbF4wuD5mw1Do2viE=;
        b=oTErFdI6eKFeNDH6YSzbE8/JPhkaRdqklITZ3wzhls1A9TGe6bkovNVrzcK3HkTyHf
         FpMi+Mqrxha9yVMuQWY1pM3WvHDY78L33bJNkVlP5sb2Sps9DfZFpXHCAT4ilYi79GJe
         mC28xZonf8wDFb8+rSsXbSPlzGKvcQlhesMJNWNnDHq6M0BL2PcYgSHHPEvq6cHZalTs
         xr6w5xmW/R2yADVc987TG72LaxWeU3YtZIgyUnDnAvjgrij9Iwh2Z/t6U/gusi+DSfom
         dhA9/aGUN5n4+f8zEMlBJu0IeX066d5KZU9oEsohSYEMJCaSXIUNEO+t+ENBP9RmiK+q
         2iPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVJSk/hfc058Boi6CmUOZdn8/0GbF4wuD5mw1Do2viE=;
        b=qXvqdlcIeMSUcvLLW07+A1xeF0krF+7UdWcLL8mJ8KxOu2j49ooO+jrARfMl6NOuJA
         h6V78t4bE2L84xubO7zVoY8Z2jPpodeC7VtQh9jQ3N5MqCF5LWRgMRa0ld0EWIKmolkT
         fH8JKprCqDNYzXKBgubs0ZtymwgvL1xT+fJlKjhW9nyUw9+y90jc0pFCFK8xvm7/nl5G
         wWyH+hqxMroxA6TyogcnZ5cIP7afneVdwIhR+cK5O5YebsdAfua1/vYS2p4Ncxja4xvH
         vkjPuziB8qkYKHjtbxlSYqJtSvOLsG1Je3WTYar7hEzIO+p9Mz57wgVS7PPoDKRMu+KW
         AH7Q==
X-Gm-Message-State: AOAM530hX/lD4GPUCdnoduAhAa41OBYWmkkDdgkoaajLpguZEMW5a7zy
        dqpP6jPFObxpNo4efAjQ5t10mKlkBCFbrriGvHV8aA==
X-Google-Smtp-Source: ABdhPJxVZbeVYLBgr5uE1mvuI7LDXkWcITnDA7F9lO03rYYyA2YIuAYn0Yi6zcFHI1hjVidvboapNw5pXEemk1yF9/M=
X-Received: by 2002:a37:a9d6:: with SMTP id s205mr6321887qke.162.1611958761060;
 Fri, 29 Jan 2021 14:19:21 -0800 (PST)
MIME-Version: 1.0
References: <da0ac373-4edb-0230-b264-49697fa3d86a@linaro.org> <20210129215024.GA113900@bjorn-Precision-5520>
In-Reply-To: <20210129215024.GA113900@bjorn-Precision-5520>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 30 Jan 2021 01:19:10 +0300
Message-ID: <CAA8EJpoPsv5tfsaiJq4UnBYt3o+gJanWzy8aaZRK=V8yOk3mJQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] pcie-qcom: provide a way to power up qca6390 chip
 on RB5 platform
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 30 Jan 2021 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jan 29, 2021 at 06:45:21AM +0300, Dmitry Baryshkov wrote:
> > On 28/01/2021 22:26, Rob Herring wrote:
> > > On Thu, Jan 28, 2021 at 11:52 AM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > Some Qualcomm platforms require to power up an external device before
> > > > probing the PCI bus. E.g. on RB5 platform the QCA6390 WiFi/BT chip needs
> > > > to be powered up before PCIe0 bus is probed. Add a quirk to the
> > > > respective PCIe root bridge to attach to the power domain if one is
> > > > required, so that the QCA chip is started before scanning the PCIe bus.
> > >
> > > This is solving a generic problem in a specific driver. It needs to be
> > > solved for any PCI host and any device.
> >
> > Ack. I see your point here.
> >
> > As this would require porting code from powerpc/spark of-pci code and
> > changing pcie port driver to apply power supply before bus probing happens,
> > I'd also ask for the comments from PCI maintainers. Will that solution be
> > acceptable to you?
>
> I can't say without seeing the code.  I don't know enough about this
> scenario to envision how it might look.
>
> I guess the QCA6390 is a PCIe device?  Why does it need to be powered
> up before probing?  Shouldn't we get a link-up interrupt when it is
> powered up so we could probe it then?

Not quite. QCA6390 is a multifunction device, with PCIe and serial
parts. It has internal power regulators which once enabled will
powerup the PCIe, serial and radio parts. There is no need to manage
regulators. Once enabled they will automatically handle device
suspend/resume, etc.

I'm not sure about link-up interrupt. I've just lightly tested using
PCIe HP on this port, getting no interrupts from it.
If I manually rescan the bus after enabling the qca6390 device (e.g.
via sysfs), it gets enabled, but then I see PCIe link errors (most
probably because the PCIe link was not retrained after the device
comes up).

> Nit: when changing any file, please take a look at the commit history
> and make yours match, e.g.,
>
>   pcie-qcom: provide a way to power up qca6390 chip on RB5 platform
>
> does not look like:

Ack.


-- 
With best wishes
Dmitry

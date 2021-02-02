Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EE630CC47
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 20:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbhBBTuM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 14:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240137AbhBBTtL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 14:49:11 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DF3C061573
        for <linux-pci@vger.kernel.org>; Tue,  2 Feb 2021 11:48:31 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id k142so9645410oib.7
        for <linux-pci@vger.kernel.org>; Tue, 02 Feb 2021 11:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZSXnsXOh3hBwQ0FBMh5iVZ9JTSULSvhbn6nE2ip4xGU=;
        b=ZUrCz+B1eGiuxlVYw+vA2x/efphepCu8o71osANOPPpf4+fFruvqtUjr4CEaJTPofL
         Qr7/U7HE6MO6wYuDZcFbYFAYUbgwLwhA00TTDWsR3PMSyOBwgD0k6PQOc1Z1j7YzME+/
         vXmE3O6flEaUv2HFMrjnMnowunrZfdOP1tynDGMCOOZsd0KZBQXtvELYQNAQpUJoWMYj
         9WhjCKFI1TiwFuJC8YwppSM9T9xouL/jAyhb9dU709pvBMcIfwsXVIzYVBgkDePnBbk/
         5lEysnoAz5Y+TnA59cZa+CFrcdYHFHo6YriuEzM8pcF9tI2+WgcTOI1EI+kCBY9VcDLA
         Yhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZSXnsXOh3hBwQ0FBMh5iVZ9JTSULSvhbn6nE2ip4xGU=;
        b=ecdkzCWJcVzN7cD7shyy2POCCEDcP4wosjGyev81jNAWlTClIUckp4KTRNsHYD6I0p
         HENBKwJtEvU7LmDgnffkx1w088Yu6XTU610TUQDowt/LXlw4N2VGE/RKUt/0v3RWgykz
         8t8TVBQtqSkuQ+T/uaz6rjmQ8tgVAiD0mMTqIGdoRTwjpACAbE1w3Rk4uHu8i57mceK8
         yjhMpFq0IHVeeNVd1Oo2DuXHBJ1+N5BvfEN96xycDPS/Bcu/96bXXDwTeUVtUHUJ3qRw
         5+v+ESpa/Ukf8op99DSv771pXzlakppdcauHfjC8Dnbb1MXhRdJ+2RuLuxV4ed7oNIJ/
         WHaQ==
X-Gm-Message-State: AOAM531z39864ae8voITyBv4cdSShSdeqg5S1nPURJvt/691TjDaKetr
        3QNjA78kFy4afXNU59ZrVvyUVg==
X-Google-Smtp-Source: ABdhPJxMbOKdnb0NsWQpRqJsWqS2ZPHN8kvdgzsSEVMxwE9+RCz70zlYR/Iv9MWqZYfjLu5EhXTMdg==
X-Received: by 2002:aca:a905:: with SMTP id s5mr3717098oie.5.1612295310681;
        Tue, 02 Feb 2021 11:48:30 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r7sm2468593oih.31.2021.02.02.11.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 11:48:30 -0800 (PST)
Date:   Tue, 2 Feb 2021 13:48:28 -0600
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
Message-ID: <YBmsjDiKnpQjYeQh@builder.lan>
References: <da0ac373-4edb-0230-b264-49697fa3d86a@linaro.org>
 <20210129215024.GA113900@bjorn-Precision-5520>
 <CAA8EJpoPsv5tfsaiJq4UnBYt3o+gJanWzy8aaZRK=V8yOk3mJQ@mail.gmail.com>
 <YBTYKLi81Cf65yUB@builder.lan>
 <CAA8EJprwBKbGrh-BjrzkQTxoboUi470wYcn-gTBHdNQ1Af7DKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprwBKbGrh-BjrzkQTxoboUi470wYcn-gTBHdNQ1Af7DKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat 30 Jan 10:14 CST 2021, Dmitry Baryshkov wrote:

> On Sat, 30 Jan 2021 at 06:53, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Fri 29 Jan 16:19 CST 2021, Dmitry Baryshkov wrote:
> >
> > > On Sat, 30 Jan 2021 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > On Fri, Jan 29, 2021 at 06:45:21AM +0300, Dmitry Baryshkov wrote:
> > > > > On 28/01/2021 22:26, Rob Herring wrote:
> > > > > > On Thu, Jan 28, 2021 at 11:52 AM Dmitry Baryshkov
> > > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > > >
> > > > > > > Some Qualcomm platforms require to power up an external device before
> > > > > > > probing the PCI bus. E.g. on RB5 platform the QCA6390 WiFi/BT chip needs
> > > > > > > to be powered up before PCIe0 bus is probed. Add a quirk to the
> > > > > > > respective PCIe root bridge to attach to the power domain if one is
> > > > > > > required, so that the QCA chip is started before scanning the PCIe bus.
> > > > > >
> > > > > > This is solving a generic problem in a specific driver. It needs to be
> > > > > > solved for any PCI host and any device.
> > > > >
> > > > > Ack. I see your point here.
> > > > >
> > > > > As this would require porting code from powerpc/spark of-pci code and
> > > > > changing pcie port driver to apply power supply before bus probing happens,
> > > > > I'd also ask for the comments from PCI maintainers. Will that solution be
> > > > > acceptable to you?
> > > >
> > > > I can't say without seeing the code.  I don't know enough about this
> > > > scenario to envision how it might look.
> > > >
> > > > I guess the QCA6390 is a PCIe device?  Why does it need to be powered
> > > > up before probing?  Shouldn't we get a link-up interrupt when it is
> > > > powered up so we could probe it then?
> > >
> > > Not quite. QCA6390 is a multifunction device, with PCIe and serial
> > > parts. It has internal power regulators which once enabled will
> > > powerup the PCIe, serial and radio parts. There is no need to manage
> > > regulators. Once enabled they will automatically handle device
> > > suspend/resume, etc.
> > >
> >
> > So what you're saying is that if either the PCI controller or bluetooth
> > driver probes these regulators will be turned on, indefinitely?
> >
> > If so, why do we need a driver to turn them on, rather than just mark
> > them as always-on?
> >
> > What's the timing requirement wrt regulators vs WL_EN/BT_EN?
> 
> According to the documentation I have, they must be enabled right
> after enabling powering the chip and they must stay enabled all the
> time.
> 

So presumably just marking these things always-on and flipping the GPIO
statically won't be good enough due to the lack of control over the
timing.

This really do look like a simplified case of what we see with the
PCIe attached modems, where similar requirements are provided, but also
the ability to perform a device specific reset sequence in case the
hardware has locked up. I'm slightly worried about the ability of
extending your power-domain model to handle the restart operation
though.

Regards,
Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D3F30CE35
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 22:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbhBBVvk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 16:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhBBVvh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 16:51:37 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DD3C061573
        for <linux-pci@vger.kernel.org>; Tue,  2 Feb 2021 13:50:56 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id j8so5535335oon.3
        for <linux-pci@vger.kernel.org>; Tue, 02 Feb 2021 13:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0kAvPlYbK2MoK6J2M4VB8aAoYja4iRJVl217ecqHS/M=;
        b=TdhEHCPKXXE10yUfrZQXXXYlAcYAm892Ap8QZ9AzljcQu07SHGtPQNNYh4Q/v8UYYk
         PiG4j2T7NHoMqPB+c49sk0YENnztQlT9XqeQ2395hb6rY5IEs1hQT8325ZkpwjtnD0LD
         Vwb8iIlhG8/SLn9tvFCsFcrmRKVpLkn2YwrhXeF78OkNw+se5xSHQHvNU3CsfgKG9FaV
         YTj35hwZuOWUyAJZ5e+Wy5z+o3F8CMc15IB60Zzzt6x8lLw1w1pKyKKhuu8IZkoQbFq+
         kbiLZzLsWUDfraAPh5zgKYN28vNYG5WxwNeNf7ab6//sWGlal65rbmmLgoKH++R2kUTK
         8D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0kAvPlYbK2MoK6J2M4VB8aAoYja4iRJVl217ecqHS/M=;
        b=QCTxQAnjeo7mzSEfbfg5Ug7CkzT5H7DKAnagYK1sodIasN/o7qExKPTG81AuzT3OzD
         V2ayCh+sPzV2c09ZAO+bU+VtkpwPAnm/XzfTSaMgK7w2mkXz3q/YfeM6xs6xDTvc6wLs
         JQ1IjmDvmPwK7enNADEhuK6brIhGk/Aymtfihtw82IwJaJ7U6fVjCvO0+H2QQgtKH8hs
         KqKX/7UW1bIHdwXsijpZbtqWgzSdp1Nii1W1tMhGN/mzZH3eeKs/VpIhbqevc97cEsLO
         Rb5aPwUC8PeY4RoCNRy5lwK+lHWCnqYbbY7MSC/41a+x7KGKWozGJ4aETo5Ry3vdjgxP
         WRfQ==
X-Gm-Message-State: AOAM533VFIMDETUzqjMNW+pX7olNN7M35iQzNgWmLcZOQjixHUlie5B9
        8zMB7DLbCCKOV5OqWqMjfC8NF1eGi//ePg==
X-Google-Smtp-Source: ABdhPJyPMNl9tGCICri+o+7UQ3JI+A7lU6DMaekFZimyL5l1Ie99Gh7PA6f5Luaja14ryJABk3D06g==
X-Received: by 2002:a4a:970b:: with SMTP id u11mr17039184ooi.79.1612302656147;
        Tue, 02 Feb 2021 13:50:56 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c2sm19995ooo.17.2021.02.02.13.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 13:50:55 -0800 (PST)
Date:   Tue, 2 Feb 2021 15:50:53 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
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
Subject: Re: [PATCH v2 3/5] pcie-qcom: provide a way to power up qca6390 chip
 on RB5 platform
Message-ID: <YBnJPWWQyRV4HtLa@builder.lan>
References: <da0ac373-4edb-0230-b264-49697fa3d86a@linaro.org>
 <20210129215024.GA113900@bjorn-Precision-5520>
 <CAA8EJpoPsv5tfsaiJq4UnBYt3o+gJanWzy8aaZRK=V8yOk3mJQ@mail.gmail.com>
 <YBTYKLi81Cf65yUB@builder.lan>
 <CAA8EJprwBKbGrh-BjrzkQTxoboUi470wYcn-gTBHdNQ1Af7DKA@mail.gmail.com>
 <YBmsjDiKnpQjYeQh@builder.lan>
 <CAL_JsqJoKEVUs0f7rP87M3Wh6yVvB-bYi7vBprti8hoim3-e-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJoKEVUs0f7rP87M3Wh6yVvB-bYi7vBprti8hoim3-e-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue 02 Feb 15:37 CST 2021, Rob Herring wrote:

> On Tue, Feb 2, 2021 at 1:48 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Sat 30 Jan 10:14 CST 2021, Dmitry Baryshkov wrote:
> >
> > > On Sat, 30 Jan 2021 at 06:53, Bjorn Andersson
> > > <bjorn.andersson@linaro.org> wrote:
> > > >
> > > > On Fri 29 Jan 16:19 CST 2021, Dmitry Baryshkov wrote:
> > > >
> > > > > On Sat, 30 Jan 2021 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Jan 29, 2021 at 06:45:21AM +0300, Dmitry Baryshkov wrote:
> > > > > > > On 28/01/2021 22:26, Rob Herring wrote:
> > > > > > > > On Thu, Jan 28, 2021 at 11:52 AM Dmitry Baryshkov
> > > > > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Some Qualcomm platforms require to power up an external device before
> > > > > > > > > probing the PCI bus. E.g. on RB5 platform the QCA6390 WiFi/BT chip needs
> > > > > > > > > to be powered up before PCIe0 bus is probed. Add a quirk to the
> > > > > > > > > respective PCIe root bridge to attach to the power domain if one is
> > > > > > > > > required, so that the QCA chip is started before scanning the PCIe bus.
> > > > > > > >
> > > > > > > > This is solving a generic problem in a specific driver. It needs to be
> > > > > > > > solved for any PCI host and any device.
> > > > > > >
> > > > > > > Ack. I see your point here.
> > > > > > >
> > > > > > > As this would require porting code from powerpc/spark of-pci code and
> > > > > > > changing pcie port driver to apply power supply before bus probing happens,
> > > > > > > I'd also ask for the comments from PCI maintainers. Will that solution be
> > > > > > > acceptable to you?
> > > > > >
> > > > > > I can't say without seeing the code.  I don't know enough about this
> > > > > > scenario to envision how it might look.
> > > > > >
> > > > > > I guess the QCA6390 is a PCIe device?  Why does it need to be powered
> > > > > > up before probing?  Shouldn't we get a link-up interrupt when it is
> > > > > > powered up so we could probe it then?
> > > > >
> > > > > Not quite. QCA6390 is a multifunction device, with PCIe and serial
> > > > > parts. It has internal power regulators which once enabled will
> > > > > powerup the PCIe, serial and radio parts. There is no need to manage
> > > > > regulators. Once enabled they will automatically handle device
> > > > > suspend/resume, etc.
> > > > >
> > > >
> > > > So what you're saying is that if either the PCI controller or bluetooth
> > > > driver probes these regulators will be turned on, indefinitely?
> > > >
> > > > If so, why do we need a driver to turn them on, rather than just mark
> > > > them as always-on?
> > > >
> > > > What's the timing requirement wrt regulators vs WL_EN/BT_EN?
> > >
> > > According to the documentation I have, they must be enabled right
> > > after enabling powering the chip and they must stay enabled all the
> > > time.
> > >
> >
> > So presumably just marking these things always-on and flipping the GPIO
> > statically won't be good enough due to the lack of control over the
> > timing.
> >
> > This really do look like a simplified case of what we see with the
> > PCIe attached modems, where similar requirements are provided, but also
> > the ability to perform a device specific reset sequence in case the
> > hardware has locked up. I'm slightly worried about the ability of
> > extending your power-domain model to handle the restart operation
> > though.
> 
> I think this is an abuse of 'power-domains'. Just define the
> regulators in both WiFi and BT nodes and have each driver enable them.
> They're refcounted. If that's still not enough control over the power
> sequencing, then create a 3rd entity to do it, but that doesn't need
> to leak into DT. You already have all the information you need.
> 

As Dmitry explained he still need to pull the two GPIOs high after
enabling the regulators, but before scanning the PCI or serdev buses.

I was thinking something along the lines you suggest, but I've not been
able to come up with something that will guarantee the ordering of the
events.

Regards,
Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975A845AF35
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 23:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbhKWWjw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 17:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhKWWjv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 17:39:51 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFDEC061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 14:36:43 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x5so756662pfr.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 14:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1stxAQaJMQ5uNT0h90s9ZiMnlvnROVdKPv81CN21oI=;
        b=g7uNTz0Gf8RFtyINdye0ogz27ivKZwS1j/5ETeDW4WWUNcVvq1XYSVv7OvNk7/Eqg4
         wroSTt8iKE0IvcajR0oRieACVGqrVcRiROuS25fk8ppFMfZF2VK5wZc+1xgJyVNass7d
         4+Q2Cie3GFli3hqmF+UKqxuFVt2VSpplc/fLgs6++iFebSrAQ4RWgPrgQYFMlcbGhz5Y
         vg1S265dZ1ywjPXA2DKTKYcFT6UfVAipLyA5AWg5VYjmWHT8E8kM6HHNGbauFgHd19fP
         psr/4g1FcBvn5ZsfuEGACIAB3KegkuA5OMc4wE4CHE9ZvWpW/RHsHszjK8zyzWmAnw+3
         abFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1stxAQaJMQ5uNT0h90s9ZiMnlvnROVdKPv81CN21oI=;
        b=EnyCfDyw92RE8JgGC2Bw/XNQrCGdQ4Sw3lAw/FK1Y5F0A51lWwnjiP7c13/5tK7w5B
         /vFH0RvENp4hijwG8au1vVn//AweXTow9rCiuvqkvpVYYQkjL3ItIhAwH4Pzw6z9jyg6
         8cZAum4+qebFyjCq4kyPWAyoibygSQdlnFK6IwKp5GRoxsAAvNSFGqrapc0zP4btceyj
         8XWQxBLmOhDqsLDgKmmnH2zU97tu0Fk/zqvKboeaJuMxaRWLr+yvaFBzVJx1ngFV5vVJ
         LaSGMmU09Q7Mlr4cOlHW9EEAx7Rc/2m5KLXWsFbJikjpmlT07c8q4oEk9TRLa7U6wioJ
         hPeg==
X-Gm-Message-State: AOAM532SLT4l82PdQdkdytntTbn7GchlikXf4EEFpNMvrxAdPrFoNHvz
        wxt3aeWP5mmYmrS4Ru7rt5G73yebfa3dZwkOJrlv9A==
X-Google-Smtp-Source: ABdhPJyD+CR+jWo0jKsLqS2tqEjW8yAC9Xwqm/Ma1K63/+YZiyZGn+87pUhZovsJcLbBFBUxM4lIut8fuHMJ/tQsNrg=
X-Received: by 2002:a63:8141:: with SMTP id t62mr4423911pgd.5.1637707002691;
 Tue, 23 Nov 2021 14:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-21-ben.widawsky@intel.com>
 <20211123182128.GA2230781@bhelgaas> <20211123220315.itoh4izu56yrrjlh@intel.com>
In-Reply-To: <20211123220315.itoh4izu56yrrjlh@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 14:36:32 -0800
Message-ID: <CAPcyv4h7h3oJTEorMhL6MMD5FYbSxaWs6tb3-w=JWxhR=j77+A@mail.gmail.com>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 23, 2021 at 2:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> > I hope this driver is not modeled on the PCI portdrv.  IMO, that was a
> > design error, and the "port service drivers" (PME, hotplug, AER, etc)
> > should be directly integrated into the PCI core instead of pretending
> > to be independent drivers.
>
> I'd like to understand a bit about why you think it was a design error. The port
> driver is intended to be a port services driver, however I see the services
> provided as quite different than the ones you mention. The primary service
> cxl_port will provide from here on out is the ability to manage HDM decoder
> resources for a port. Other independent drivers that want to use HDM decoder
> resources would rely on the port driver for this.
>
> It could be in CXL core just the same, but I don't see too much of a benefit
> since the code would be almost identical. One nice aspect of having the port
> driver outside of CXL core is it would allow CXL devices which do not need port
> services (type-1 and probably type-2) to not need to load the port driver. We do
> not have examples of such devices today but there's good evidence they are being
> built. Whether or not they will even want CXL core is another topic up for
> debate however.
>
> I admit Dan and I did discuss putting this in either its own port driver, or
> within core as a port driver. My inclination is, less is more in CXL core; but
> perhaps you will be able to change my mind.

No, I don't think Bjorn is talking about whether the driver is
integrated into cxl_core.ko vs its own cxl_port.ko. IIUC this goes
back to the original contention about have /sys/bus/cxl at all:

https://lore.kernel.org/r/CAPcyv4iu8D-hJoujLXw8a4myS7trOE1FcUhESLB_imGMECVfrg@mail.gmail.com

Unlike pcieportdrv where the functionality is bounded to a single
device instance with relatively simpler hierarchical coordination of
the memory space and services. CXL interleaving is both a foreign
concept to the PCIE core and an awkward fit for the pci_bus_type
device model. CXL uses the cxl_bus_type and bus drivers to coordinate
CXL operations that have cross PCI device implications.

Outside of that I think the auxiliary device driver model, of which
the PCIE portdrv model is an open-coded form, is a useful construct
for separation of concerns. That said, I do want to hear more about
what trouble it has caused though to make sure that CXL does not trip
over the same issues longer term.

[..]
> > > +static void rescan_ports(struct work_struct *work)
> > > +{
> > > +   if (bus_rescan_devices(&cxl_bus_type))
> > > +           pr_warn("Failed to rescan\n");
> >
> > Needs some context.  A bare "Failed to rescan" in the dmesg log
> > without a clue about who emitted it is really annoying.
> >
> > Maybe you defined pr_fmt() somewhere; I couldn't find it easily.
> >
>
> I actually didn't know about pr_fmt() trick, so thanks for that. I'll improve
> this message to be more useful and contextual.

I am skeptical that this implementation of the workqueue properly
synchronizes with workqueue shutdown concerns, but I have not had a
chance to dig in too deep on this patchset.

Regardless, it is not worth reporting a rescan failure, because those
are to be expected here. The rescan attempts to rescan when a
constraint changes, there is no guarantee that all constraints are met
just because one constraint changed, so rescan failures
(device_attach() failures) are not interesting to report. The
individual driver probe failure reporting is sufficient.

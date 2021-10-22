Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C7D437976
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 17:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhJVPDc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 11:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhJVPDc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 11:03:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE626C061766
        for <linux-pci@vger.kernel.org>; Fri, 22 Oct 2021 08:01:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l38-20020a05600c1d2600b0030d80c3667aso2693226wms.5
        for <linux-pci@vger.kernel.org>; Fri, 22 Oct 2021 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GIPpv6Q0RJFERejdEdswNrUDirFtVwEww7SCPVpfCjQ=;
        b=O4Vxj1rjyTbXhumLouMUWEvAckNJE/a15KBm+8m57gyA9GZFix4TLEWN6e1KUFHIUz
         z5y57C92vtUV+Z7ZXLcg7SXc2cTMnAH4Dz4UrlNCuMaG9dztkQlbkuShtxJPUKgaOWB9
         JCO8j/8yvLOCsEgrPoygGB7dHNU2+DynHUvdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GIPpv6Q0RJFERejdEdswNrUDirFtVwEww7SCPVpfCjQ=;
        b=GUk6+BP4j6wb1+q7wlH+oUBtqAfJZipVopiUF61fm4K9lHKbKvdjTuEuvgduNJHGBc
         /Qg7pj1RGDntuqYuq51UVawLF6BVy14mzXOA69Rqf0t7zW0TpX42e0O0jkXnva4IOB8B
         jfuEcX5LxIosERkAnPiBTRp/RNxHTIk4d/6jWHTWrQuAzRAlYS+SlOLbXPfwXlFaFzy7
         RtO75ejLk+cOcuKrGl4+B8QLJNaJ/ixnStugS/Uu//mc8Jb00DBVWcTrjvUU2XXdqkaq
         kV6Vu5nX7z2yOpmfSUc1RghUqgpp+6mTFg/UM4Z/v44eN2Kqt6g6NVfAbByJ0AMMekoz
         vdiw==
X-Gm-Message-State: AOAM530HdTluELj8Z7yF1GOGp+/+saygxMxPxA1kXB5fK5yh9P4xFvWq
        3yUavFq53yHNIpVkO0pi5d5Z5/YehkruPZvDp+Gjsw==
X-Google-Smtp-Source: ABdhPJwdTb3qaUKpHim2L/0QLli2VruHSN+i3ykNrqX/FYTJ6n/dl0342/3LFdfNM66K/9xy/EhQsx/gyziYM4uYGSQ=
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr30503767wmr.48.1634914872995;
 Fri, 22 Oct 2021 08:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211022140714.28767-1-jim2101024@gmail.com> <20211022140714.28767-3-jim2101024@gmail.com>
 <YXLL8IPz2LcNqEj4@kroah.com>
In-Reply-To: <YXLL8IPz2LcNqEj4@kroah.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 22 Oct 2021 11:01:01 -0400
Message-ID: <CA+-6iNxPN0+Ge5AES-pChQvjM9OKeT__fy-nrE5obwJ0QcY1vw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] PCI: allow for callback to prepare nascent subdev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Rajat Jain <rajatja@google.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Claire Chang <tientzu@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 22, 2021 at 10:34 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 22, 2021 at 10:06:55AM -0400, Jim Quinlan wrote:
> > We would like the Broadcom STB PCIe root complex driver to be able to turn
> > off/on regulators[1] that provide power to endpoint[2] devices.  Typically,
> > the drivers of these endpoint devices are stock Linux drivers that are not
> > aware that these regulator(s) exist and must be turned on for the driver to
> > be probed.  The simple solution of course is to turn these regulators on at
> > boot and keep them on.  However, this solution does not satisfy at least
> > three of our usage modes:
> >
> > 1. For example, one customer uses multiple PCIe controllers, but wants the
> > ability to, by script, turn any or all of them by and their subdevices off
> > to save power, e.g. when in battery mode.
> >
> > 2. Another example is when a watchdog script discovers that an endpoint
> > device is in an unresponsive state and would like to unbind, power toggle,
> > and re-bind just the PCIe endpoint and controller.
> >
> > 3. Of course we also want power turned off during suspend mode.  However,
> > some endpoint devices may be able to "wake" during suspend and we need to
> > recognise this case and veto the nominal act of turning off its regulator.
> > Such is the case with Wake-on-LAN and Wake-on-WLAN support where PCIe
> > end-point device needs to be kept powered on in order to receive network
> > packets and wake-up the system.
> >
> > In all of these cases it is advantageous for the PCIe controller to govern
> > the turning off/on the regulators needed by the endpoint device.  The first
> > two cases can be done by simply unbinding and binding the PCIe controller,
> > if the controller has control of these regulators.
> >
> > This commit solves the "chicken-and-egg" problem by providing a callback to
> > the RC driver when a downstream device is "discovered" by inspecting its
> > DT, and allowing said driver to allocate the device object prematurely in
> > order to get the regulator(s) and turn them on before the device's ID is
> > read.
> >
> > [1] These regulators typically govern the actual power supply to the
> >     endpoint chip.  Sometimes they may be a the official PCIe socket
> >     power -- such as 3.3v or aux-3.3v.  Sometimes they are truly
> >     the regulator(s) that supply power to the EP chip.
> >
> > [2] The 99% configuration of our boards is a single endpoint device
> >     attached to the PCIe controller.  I use the term endpoint but it could
> >     possible mean a switch as well.
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  drivers/base/core.c    |  5 +++++
> >  drivers/pci/probe.c    | 47 ++++++++++++++++++++++++++++++++----------
> >  include/linux/device.h |  3 +++
> >  include/linux/pci.h    |  3 +++
> >  4 files changed, 47 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 249da496581a..62d9ac123ae5 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2864,6 +2864,10 @@ static void klist_children_put(struct klist_node *n)
> >   */
> >  void device_initialize(struct device *dev)
> >  {
> > +     /* Return if this has been called already. */
> > +     if (dev->device_initialized)
> > +             return;
> > +
>
> Ick, no!  Who would ever be calling this function more than once?  That
> "should" be impossible.
>
> This function should only be called by a bus when it first creates the
> structure and before anything is done with it.  As the bus itself
> controls the creation, it already "knows" when the structure was
> initialzed so it should not have to be called again.



>
> Please fix the bus logic that requires this, it is broken.
Got it, thanks for the prompt reply.

JimQ
>
> Consider this a NACK for this patch, sorry.
>
> greg k-h

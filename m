Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212A4216268
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 01:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgGFXlT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 19:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgGFXlT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 19:41:19 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFFDC08C5DF
        for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2020 16:41:18 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e8so13450168ljb.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2020 16:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qj0obXfHw+PyCzXxfPBrAWthmmsaPQNxN4o0aIsqBxY=;
        b=e4ZoJPfJCzUv6JiW/ZtKDNwoYQa+BkxY90CNz+S6LE9+7RRt6w4/OAJaTtKXSYhbbF
         oYS0eHWn6OMcxWzbDErcbfbew+X7a6zOBBM6D7f3BIbOaa3bo7kz7TEWGRTKU+1SMROJ
         Uwh+5IvhJYVUsrx3MhOx+3bLdeW7f6pDZsALQBMQiwWMlGokj2qDJ33L/f/aRPXd/Yec
         r7GUTyQDIUkMC7W5jzQUw97nbmg4R/8kNhWAmD/VgGQab7U+hMRgK/zmuD6xQSw28Ovt
         /77UzmwH9JzQPTeu0U2tUJjGo+FYeTGxCf8Ec8gnCy1loG1SpwudA757MIn0qLMe6X2I
         O63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qj0obXfHw+PyCzXxfPBrAWthmmsaPQNxN4o0aIsqBxY=;
        b=YDXjW7orCzvTyTV0st+J58ifMf+DScmqW2C5Cj3HgDIjVAuulWeB+Z54MNP4/4OM3E
         rxwecLjT59dvmE4fsP/Eg0GI3XQg/f2b30N4babCiYka/Oh+w4dlBY9lstTlLvJ0fDbP
         RmKQbq3cauy4P5D86sJEBePWVRt3M9icmd99ET4b0uUaOmhpr/a2lWJ2c6jbbkCsYG+0
         KEuqM1Bpoo+4Paz0HlmQa2N2EGtO/ZqAu5w1HMmF547J/9k5UGwu7laH/eil8wgKP2zV
         GlGyPeWnoAjLPsDZRioqxAEl8v/sfowFr0WhQMpwuMr1HcHQhf360XZdNPLOCi0JaRAA
         ATTw==
X-Gm-Message-State: AOAM5327O4W3rRY7Mrg9bayFaM267ZyiiU1CPMmCDNKK/bn6k0LVBx8T
        fbU8ispFcNkaMQbd4A3qodRF5Wnd+0nwl7rtWO4zsA==
X-Google-Smtp-Source: ABdhPJyJE3f+I6Cf0x7ChQa/hx1i7/Jjwak0JpIGwoSbWZNYPbEKzMKAPHJY1Bta2Hsh06yLSlYqq3OVhVwzS1hDg9w=
X-Received: by 2002:a2e:858e:: with SMTP id b14mr30029014lji.301.1594078876784;
 Mon, 06 Jul 2020 16:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6FhWyZOJvkrPcHacyvJucGMupOpL=Jm8BpyO7wPrZ_DQA@mail.gmail.com>
 <20200706233040.GA169334@bjorn-Precision-5520>
In-Reply-To: <20200706233040.GA169334@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 6 Jul 2020 16:40:40 -0700
Message-ID: <CACK8Z6F9zGrOAQ9QQ0Wjt9zbPk3cPnjSTvoZsS_i_Rd0H6Uiiw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] PCI: Set "untrusted" flag for truly external
 devices only
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

On Mon, Jul 6, 2020 at 4:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Jul 06, 2020 at 03:31:47PM -0700, Rajat Jain wrote:
> > On Mon, Jul 6, 2020 at 9:38 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Mon, Jun 29, 2020 at 09:49:38PM -0700, Rajat Jain wrote:
>
> > > > -static void pci_acpi_set_untrusted(struct pci_dev *dev)
> > > > +static void pci_acpi_set_external_facing(struct pci_dev *dev)
> > > >  {
> > > >       u8 val;
> > > >
> > > > -     if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> > > > +     if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
> > > > +         pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
> > >
> > > This looks like a change worthy of its own patch.  We used to look for
> > > "ExternalFacingPort" only on Root Ports; now we'll also do it for
> > > Switch Downstream Ports.
> >
> > Can do. (please see below)
> >
> > > Can you include DT and ACPI spec references if they exist?  I found
> > > this mention:
> > > https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> > > which actually says it should only be implemented for Root Ports.
> >
> > I actually have no references. It seems to me that the microsoft spec
> > assumes that all external ports must be implemented on root ports, but
> > I think it would be equally fair for systems with PCIe switches to
> > implement one on one of their switch downstream ports. I don't have an
> > immediate use of this anyway, so if you think this should rather wait
> > unless someone really has this case, this can wait. Let me know.
>
> I agree that it "makes sense" to pay attention to this property no
> matter where it appears, but since that Microsoft doc went to the
> trouble to restrict it to Root Ports, I think we should leave this
> as-is and only look for it in the Root Port.  Otherwise Linux will
> accept something Windows will reject, and that seems like a needless
> difference.
>
> We can at least include the above link to the Microsoft doc in the
> commit log.

Will do.

>
> > > It also mentions a "DmaProperty" that looks related.  Maybe Linux
> > > should also pay attention to this?
> >
> > Interesting. Since this is not in use currently by the kernel as well
> > as not exposed by (our) BIOS, I don't have an immediate use case for
> > this. I'd like to defer this for later (as-the-need-arises).
>
> I agree, you can defer this until you see a need for it.  I just
> pointed it out in case it would be useful to you.
>
> > > > +     /*
> > > > +      * Devices are marked as external-facing using info from platform
> > > > +      * (ACPI / devicetree). An external-facing device is still an internal
> > > > +      * trusted device, but it faces external untrusted devices. Thus any
> > > > +      * devices enumerated downstream an external-facing device is marked
> > > > +      * as untrusted.
> > >
> > > This comment has a subject/verb agreement problem.
> >
> > I assume you meant s/is/are/ in last sentence. Will do.
>
> Right.  There's also something wrong with "enumerated downstream an".

I'm apparently really bad at English :-). This is what I have in my
latest patch I am about to send out:

"Thus any device enumerated downstream an external-facing device, is
marked as untrusted."

Are you suggesting s/an/a/ ? Please let me know what you would like to
see and I'd copy it as-is :-)

Thanks!

Rajat

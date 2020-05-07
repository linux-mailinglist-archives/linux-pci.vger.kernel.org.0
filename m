Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5D81C8AAE
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 14:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgEGMYu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 08:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725923AbgEGMYt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 08:24:49 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D52C05BD43
        for <linux-pci@vger.kernel.org>; Thu,  7 May 2020 05:24:49 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id j8so329502iog.13
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2020 05:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=xfIlSnOQy3CR4jNlb8aE97dXOuPyWJPOGrlRnKVaPnI=;
        b=WB+J4PuV0AbOAXmMxMVAJ7BeeVwWt26/KwH3lIAoXHq3te4HOGAu0Dna89hXzoThbM
         wb+J+T4ertElZeiPav3rwCjK04Iqfl4ryrxHjFUVzDi9SIqRbWdN4C+c5Xn9QZerboLR
         dgl2d13+wUbgBbDehPwGr8uvoSNNwWmZxcp9MYvsa5IwAawMzK+Js1NUmQW/bSEM8t5F
         pAVtMTHxHWhlVch+CfMqIXPBJrVnPuR3HRZnuz6UeQ0doYHbuBUgURdN1hc1Hq0DDisQ
         vPf4r2G1tqZnb2xBWQOC2O9GNklkPSSwh2uenXGNOzCd2XvN/5DwwsGnE4CBTtwxFoF6
         jGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=xfIlSnOQy3CR4jNlb8aE97dXOuPyWJPOGrlRnKVaPnI=;
        b=EyuOS+o4nto/f6mX9FkRV9+KvrbdcCn5MuW7KkOc+qzaHCeGsA+Sye4BSgr+ed9Wqe
         Fo4vmvQ3E7ufXPh+PeTd6EWEHO9z0uZp5o/MsF5TlYToze5NJiZn1MHQY6jCkHmNnMhA
         xEj31Idtu79NV6DxrdMyRqNzwolnYBFKeYrlPTLI3OQdRJHabnKQyEQc4hi8H+BX8K9H
         cDaoy1yM4WJW63p9gWe09kSOZCM7CvBfAKv1UMPZCrnVPMS23OF0UCND0lnRft2hv7ar
         AjASwl2i8Rsq8UZYJkZG09hWGMwlQtgEJ5KlnpBgfMZTUyOxP1jrsu9cFZHu3AJ3B+6N
         bXCw==
X-Gm-Message-State: AGi0PuYJbu+ckHZtJGL2WAgrPbwSgQVyOSOjro86wwa4152plE5rKS+/
        U2H5egz5/gFX8YkH/FYQ4zsrUTLx2oxb6VYJ9LE=
X-Google-Smtp-Source: APiQypL8y7F+XSclNV6i0vv9/2qqSSy2GrkzQfT5AQ7GxdtdhCu/F4BnNv2yjX0zRW6CxCHCL4ulk9OGkFTaEHyA4aw=
X-Received: by 2002:a02:966a:: with SMTP id c97mr13741776jai.106.1588854289094;
 Thu, 07 May 2020 05:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200416083245.73957-1-mika.westerberg@linux.intel.com>
 <20200506224228.GA458845@bjorn-Precision-5520> <20200507114553.GH487496@lahna.fi.intel.com>
In-Reply-To: <20200507114553.GH487496@lahna.fi.intel.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Thu, 7 May 2020 07:24:37 -0500
Message-ID: <CABhMZUVsYUc7o-LLSdy1XzD55zTJk74A6JdSftHdxVJs2-LWFQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Do not use pcie_get_speed_cap() to determine when to
 start waiting
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 7, 2020 at 6:45 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Wed, May 06, 2020 at 05:42:28PM -0500, Bjorn Helgaas wrote:
> > On Thu, Apr 16, 2020 at 11:32:45AM +0300, Mika Westerberg wrote:
> > > Kai-Heng Feng reported that it takes long time (>1s) to resume
> > > Thunderbolt connected PCIe devices from both runtime suspend and system
> > > sleep (s2idle).
> > >
> > > These PCIe downstream ports the second link capability (PCI_EXP_LNKCAP2)
> > > announces support for speeds > 5 GT/s but it is then capped by the
> > > second link control (PCI_EXP_LNKCTL2) register to 2.5 GT/s. This
> > > possiblity was not considered in pci_bridge_wait_for_secondary_bus() so
> > > it ended up waiting for 1100 ms as these ports do not support active
> > > link layer reporting either.
> > >
> > > PCIe spec 5.0 section 6.6.1 mandates that we must wait minimum of 100 ms
> > > before sending configuration request to the device below, if the port
> > > does not support speeds > 5 GT/s, and if it does we first need to wait
> > > for the data link layer to become active before waiting for that 100 ms.
> > >
> > > PCIe spec 5.0 section 7.5.3.6 further says that all downstream ports
> > > that support speeds > 5 GT/s must support active link layer reporting so
> > > instead of looking for the speed we can check for the active link layer
> > > reporting capability and determine how to wait based on that (as they go
> > > hand in hand).
> >
> > I can't quite tell what the defect is here.
> >
> > I assume you're talking about this text from sec 6.6.1:
> >
> >   - With a Downstream Port that does not support Link speeds greater
> >     than 5.0 GT/s, software must wait a minimum of 100 ms before
> >     sending a Configuration Request to the device immediately below
> >     that Port.
> >
> >   - With a Downstream Port that supports Link speeds greater than 5.0
> >     GT/s, software must wait a minimum of 100 ms after Link training
> >     completes before sending a Configuration Request to the device
> >     immediately below that Port. Software can determine when Link
> >     training completes by polling the Data Link Layer Link Active bit
> >     or by setting up an associated interrupt (see Section 6.7.3.3 ).
> >
> > I don't understand what Link Control 2 has to do with this.  The spec
> > talks about ports *supporting* certain link speeds, which sounds to me
> > like the Link Capabilities.  It doesn't say anything about the current
> > or target link speed.
>
> PCIe 5.0 page 764 recommends using Supported Link Speeds Vector in Link
> Capabilities 2 register and that's what pcie_get_speed_cap() is doing.
>
> However, we can avoid figuring the speed altogether by checking the
> dev->link_active_reporting instead because that needs to be implemented
> by all Downstream Ports that supports speeds > 5 GT/s (PCIe 5.0 page 735).

I understand that part.  But the code as-is matches sec 6.6.1, which
makes it easy to understand.  Checking link_active_reporting instead
makes it harder to understand because it makes it one step removed
from 6.6.1.  And link_active_reporting must be set for ports that
support > 5 GT/s, but it must *also* be set in some hotplug cases, so
that further complicates the connection between it and 6.6.1.

And apparently there's an actual defect, and I don't understand what
that is yet.  It sounds like we agree that pcie_get_speed_cap() is
doing the right thing.  Is there something in
pci_bridge_wait_for_secondary_bus() that doesn't match sec 6.6.1?

Bjorn

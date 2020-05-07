Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E107C1C8C6F
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 15:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgEGNdk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726641AbgEGNdj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 09:33:39 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A682EC05BD43
        for <linux-pci@vger.kernel.org>; Thu,  7 May 2020 06:33:39 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id x2so784313ilp.13
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2020 06:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=RUqYCU/As210pSVRMdsAhyv6FzY20O+pJHpU4YuDJC4=;
        b=FmncjyIH1vYatWPpib7O+UQed96HVQIACNr7X8N/JyqIW8fIiNIVgbS7jPNhOMFk4I
         uCDNVf61L3oazvEJfQJBd/C7fk1RVVKzTWZIA8ntcbcmYrTGsUcDwYNqcJxkT99h44vy
         fVSm95ZXc2WW9YUDMhi5M88aVqlxU10M2r995HaoVV57TMffOudyoVu9jvsXRx7ZOfKL
         x0zuV1LUX4cFls8MY2ek098t6/+/8mAr7/HJ2kFB75f26tzqyoBO9lZmGaH+W78qz3nn
         F/kxAHUD17DUqGGZo/4/eHRHuukr40i6g75E2R1ve6bmXoqmI8df6w9C+SV9RYuRYtVS
         nGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=RUqYCU/As210pSVRMdsAhyv6FzY20O+pJHpU4YuDJC4=;
        b=eneI5NzvdaApO+2GaVePzjG8n0rVhCjr+4gofx24a5UeGR7c82qmxFAbljSXvaEfJ5
         YuOyyeZWv+83D17zvFNRhka9xHKnRqfqdazeMzz2YE/dxevdciDNLSRCsQZDUga6kTIY
         qFPhjQmQAdRdUJJxuVdAhAB3gFmEbQ+CZdJ0R9AAtSDw5rT8ADG5KHoetBXYfypJr+VU
         d2r1lPjHf7vvBgJIE4rlZDZdIMVEqXGZpMQd6FO1IlbTSWrFuEP5XmvCBvCQvXHEHuaD
         q8iLZtQ499Dd6penEniAyyHY7qbxXJ2Pzs2VbGAdwpsS9A1u22WZciRN7CZwKO3pekV5
         Ez3Q==
X-Gm-Message-State: AGi0PubhtpGod4TAOOOTERkbDKOx9kVCUEVgTsW9FjSQDg3E2vQGfcFx
        xhmkHg7+stRQnW6DUg3kuMv54Obx4RWzkcLGvzECA5kJ
X-Google-Smtp-Source: APiQypKv7tSx4jC4/Q10Sj4qFecdnyk8P19gFxOcKW9Zzi9dyAXZ6yXHgLFmp8GzmqdCAxzYyY0raaiGeSXEZ6r6ejY=
X-Received: by 2002:a92:3c4d:: with SMTP id j74mr14631678ila.10.1588858418868;
 Thu, 07 May 2020 06:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200416083245.73957-1-mika.westerberg@linux.intel.com>
 <20200506224228.GA458845@bjorn-Precision-5520> <20200507114553.GH487496@lahna.fi.intel.com>
 <CABhMZUVsYUc7o-LLSdy1XzD55zTJk74A6JdSftHdxVJs2-LWFQ@mail.gmail.com> <20200507123558.GS487496@lahna.fi.intel.com>
In-Reply-To: <20200507123558.GS487496@lahna.fi.intel.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Thu, 7 May 2020 08:33:27 -0500
Message-ID: <CABhMZUVqH-4Qkf=P2gDBdQQR8rqs3R2r5_YkFnspmUO6qe-jDQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Do not use pcie_get_speed_cap() to determine when to
 start waiting
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bjorn@helgaas.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 7, 2020 at 7:36 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, May 07, 2020 at 07:24:37AM -0500, Bjorn Helgaas wrote:
> > On Thu, May 7, 2020 at 6:45 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Wed, May 06, 2020 at 05:42:28PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Apr 16, 2020 at 11:32:45AM +0300, Mika Westerberg wrote:
> > > > > Kai-Heng Feng reported that it takes long time (>1s) to resume
> > > > > Thunderbolt connected PCIe devices from both runtime suspend and system
> > > > > sleep (s2idle).
> > > > >
> > > > > These PCIe downstream ports the second link capability (PCI_EXP_LNKCAP2)
> > > > > announces support for speeds > 5 GT/s but it is then capped by the
> > > > > second link control (PCI_EXP_LNKCTL2) register to 2.5 GT/s. This
> > > > > possiblity was not considered in pci_bridge_wait_for_secondary_bus() so
> > > > > it ended up waiting for 1100 ms as these ports do not support active
> > > > > link layer reporting either.
> > > > >
> > > > > PCIe spec 5.0 section 6.6.1 mandates that we must wait minimum of 100 ms
> > > > > before sending configuration request to the device below, if the port
> > > > > does not support speeds > 5 GT/s, and if it does we first need to wait
> > > > > for the data link layer to become active before waiting for that 100 ms.
> > > > >
> > > > > PCIe spec 5.0 section 7.5.3.6 further says that all downstream ports
> > > > > that support speeds > 5 GT/s must support active link layer reporting so
> > > > > instead of looking for the speed we can check for the active link layer
> > > > > reporting capability and determine how to wait based on that (as they go
> > > > > hand in hand).
> > > >
> > > > I can't quite tell what the defect is here.
> > > >
> > > > I assume you're talking about this text from sec 6.6.1:
> > > >
> > > >   - With a Downstream Port that does not support Link speeds greater
> > > >     than 5.0 GT/s, software must wait a minimum of 100 ms before
> > > >     sending a Configuration Request to the device immediately below
> > > >     that Port.
> > > >
> > > >   - With a Downstream Port that supports Link speeds greater than 5.0
> > > >     GT/s, software must wait a minimum of 100 ms after Link training
> > > >     completes before sending a Configuration Request to the device
> > > >     immediately below that Port. Software can determine when Link
> > > >     training completes by polling the Data Link Layer Link Active bit
> > > >     or by setting up an associated interrupt (see Section 6.7.3.3 ).
> > > >
> > > > I don't understand what Link Control 2 has to do with this.  The spec
> > > > talks about ports *supporting* certain link speeds, which sounds to me
> > > > like the Link Capabilities.  It doesn't say anything about the current
> > > > or target link speed.
> > >
> > > PCIe 5.0 page 764 recommends using Supported Link Speeds Vector in Link
> > > Capabilities 2 register and that's what pcie_get_speed_cap() is doing.
> > >
> > > However, we can avoid figuring the speed altogether by checking the
> > > dev->link_active_reporting instead because that needs to be implemented
> > > by all Downstream Ports that supports speeds > 5 GT/s (PCIe 5.0 page 735).
> >
> > I understand that part.  But the code as-is matches sec 6.6.1, which
> > makes it easy to understand.  Checking link_active_reporting instead
> > makes it harder to understand because it makes it one step removed
> > from 6.6.1.  And link_active_reporting must be set for ports that
> > support > 5 GT/s, but it must *also* be set in some hotplug cases, so
> > that further complicates the connection between it and 6.6.1.
> >
> > And apparently there's an actual defect, and I don't understand what
> > that is yet.  It sounds like we agree that pcie_get_speed_cap() is
> > doing the right thing.  Is there something in
> > pci_bridge_wait_for_secondary_bus() that doesn't match sec 6.6.1?
>
> The defect is that some downstream PCIe ports on a system Kai-Heng is
> using have Supported Link Speeds Vector with > 5GT/s and it does not
> support active link reporting so the currect code ends up waiting 1100 ms
> slowing down resume time.

That sounds like a hardware defect that should be worked around with a
quirk or something.  If we just restructure the code to avoid the
problem, we're likely to reintroduce it later because there's no hint
in the code about this problem.

> The Target Link Speed of this port (in Link Control 2) has the speed
> capped to 2.5 GT/s.

I saw you mentioned this before, but I don't understand yet why it's
relevant.  The spec says "supported,", not "current" or "target".

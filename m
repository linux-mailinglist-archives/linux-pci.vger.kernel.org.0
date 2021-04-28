Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E79E36D72A
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 14:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhD1MW0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 08:22:26 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:39462 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbhD1MWZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Apr 2021 08:22:25 -0400
Received: by mail-oi1-f171.google.com with SMTP id i81so62846338oif.6;
        Wed, 28 Apr 2021 05:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRxkUo+PRbe+x5wLLv3keLeEPMkJ2hxH1SQXgu1ocjk=;
        b=Tvfv2ymW+DV6C/paqY38g+8stelqtlDmdpxOFAMTLj9ElU6eUEzjceL6i82YjTlAfb
         aloQ8n5YkyWdiyGTjJYsJJQc+zMbKT4vHoHp18Ro3EMT8fodkgQeSroGi3lua9adC9aC
         FnfqCGazJWKqDKNIU/v+GH06YDdHvXGhLxuPbLeOcSHQi4ioUPQsQrbPK5X9xbBGGs0D
         9PcS/al0gxmdXFSe1ARIRi7GFsg+dCpBgp/EnacobG33yU/1s81858BifPL/IO1Wgo70
         267erXTpmEydZM3V4jgFbkBec7L4j6S4yXjpk2c1IcyeHI3Xt5aE9D8SJLAuBcci5OZg
         0ahA==
X-Gm-Message-State: AOAM530KlMoJP6byqnL98IN/B+50zvcWT+OjuDMlzKYP/1knvNv5BVFQ
        nuDrqDAXr5r+6KPIaJdWYfjV9LFIzcV1OBqMo4I=
X-Google-Smtp-Source: ABdhPJxOhMz6a0QlMskPlWjNHUPGrH1Vn78FLKH0qxpCwG0EW2c/SIcnZsKBhMYvQD1e2UvBb9Jr9em/bmGCLMLK8jk=
X-Received: by 2002:aca:bc89:: with SMTP id m131mr20193642oif.71.1619612500595;
 Wed, 28 Apr 2021 05:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210424021631.1972022-1-rajatja@google.com> <20210424021631.1972022-2-rajatja@google.com>
 <d53c72949d81db9f092a9aecb49bf56b47727738.camel@suse.com> <CAJZ5v0iNrSFjhmTE8K-JrO07kJon3ikhatbg0Jg2hs+x-frDJg@mail.gmail.com>
 <79b994f2476249498797e1784f735fd7@AcuMS.aculab.com> <21c6b5002c5ad36cd7fe0bb849f5eba12a614bca.camel@suse.com>
 <b5e031652f144ab6accbe553566676c9@AcuMS.aculab.com> <0601e45130495b152bec04eee4a50e302db4cfd2.camel@suse.com>
In-Reply-To: <0601e45130495b152bec04eee4a50e302db4cfd2.camel@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Apr 2021 14:21:27 +0200
Message-ID: <CAJZ5v0jEbjRSGPdfwvegawin5_N=m-UoP+Wa99EQ-QmkusiBCg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pci: Support "removable" attribute for PCI devices
To:     Oliver Neukum <oneukum@suse.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 28, 2021 at 8:57 AM Oliver Neukum <oneukum@suse.com> wrote:
>
> Am Dienstag, den 27.04.2021, 12:59 +0000 schrieb David Laight:
> > From: Oliver Neukum
> > > Sent: 27 April 2021 13:00
>
> > > that is true for those options, but not for the style
> > > of PCI hotplug which requires you to push a button and wait
> > > for the blinking light.
> >
> > True, I remember some of those PCI hotplug chassis from 25 years ago.
> > ISTR we did get the removal events working (SVR4/Unixware) but I
> > don't remember the relevant chassis ever being sold.
> > In spite of the marketing hype I suspect it was only ever possible
> > to remove a completely working board and replace it with an
> > exactly equivalent one.
> >
> > In any case those chassis are not 'surprise removal'.
> >
> > More modern drivers are less likely to crash (and burn?) when
> > a PCI read returns ~0u.
> > But I suspect an awful lot really don't handle surprise removal
> > very well at all.
>
> So you are saying that these systems are so rare that it should be
> handled  as special cases if at all?

In principle, in the wake of Thunderbolt every PCI driver handling
PCIe devices needs to be able to deal with a device that's gone away
without notice, because in principle any PCIe device can be included
into a Thunderbolt docking station which may go away as a whole
without notice.

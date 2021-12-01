Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE30465732
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 21:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhLAUh2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 15:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhLAUh1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 15:37:27 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAEAC061574;
        Wed,  1 Dec 2021 12:34:05 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id o1so51650547uap.4;
        Wed, 01 Dec 2021 12:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFDSxAe4zieD9ox/kw/aNvI2HKK0wvah3wl0OX9Z/8U=;
        b=dftyc8WNE/srbEFYfl2nKQeGFI5R33/mohWCbBqQAR92OBzW9HcaRBVXpO7Ytkldf4
         vDx8H5rqFx4C/O1l5P0T/klb+LTluK4aKCX4T3huElBdWjy0UXyC45JIvQDNuMjCNTRd
         sHA/k/EMreUaiX4q1umf3i1UwiZseX/6UN7+3JvsPDxYjrCedtRgdy3R3zH+Kj/pbHOc
         Zb4/5KVGPE+0AgQ9nqFTRn/VIndQFMFr49gM/IGjwFQsGM9Au3bVGcKhwxUF0eG1JPwc
         0aLSwEnGsx0oEPSkCLbT83TYJyq9OCVfRVZrpljTLODJCW0WJmzdtTqYoME4DSlUwkDF
         cLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFDSxAe4zieD9ox/kw/aNvI2HKK0wvah3wl0OX9Z/8U=;
        b=IhB8lh7ddctCNDoz9CTNEMYwa51toKq6BJIfdk+hMs9AgAf7AbbgpZb2h9dY9P2Lss
         7+f7awFX4H7+qG91gAlWpxIiqngK/ImGsvDpW7CpqExeKDaJRHCPN8P5TKz8LUmA/fcX
         Kf8nk7NVbr0ONPE68Zqo17akoF3dzGczHS++xZYGBWvFy/pG4Uu5HmqMoin63GvNWZb/
         KYhn7DkizQgS/rEQ8TlVr5bnlG2yltPnHxePJuSsGTlGiUj37hXbwhIPHTsdKVfFkp2i
         XPy1rXPtJi1kVr3ElMuMMJ3QGiPe65Jv+x+atXshXBHSBS/z1sRLgmRBAMO8eqfvnAYL
         PTMQ==
X-Gm-Message-State: AOAM533jssOZV8L9G2MoLeSbJrQsrQKJEE1koA0E+lKn3nu4yeAlhxxm
        6qUTqZOHoU+3bA5ufS9fGsyvh7mmx/lohqUOXek865hy
X-Google-Smtp-Source: ABdhPJyNqS8LEKCgH0nRlVUi2AKVxf7yIkV4MQGW9eiVI7lC2yz2yQI71HacsoK7/rjztnW9qk1pLdWZk+vrqFloQoU=
X-Received: by 2002:a05:6102:c4d:: with SMTP id y13mr10919342vss.43.1638390844521;
 Wed, 01 Dec 2021 12:34:04 -0800 (PST)
MIME-Version: 1.0
References: <20211115070809.15529-6-sergio.paracuellos@gmail.com> <20211201201202.GA2831888@bhelgaas>
In-Reply-To: <20211201201202.GA2831888@bhelgaas>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 1 Dec 2021 21:33:53 +0100
Message-ID: <CAMhs-H9NdkBDjq4A+2bLt2KUmkTPw_dpvRDo8Wb58Z7B5WvN1Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI: mt7621: Kconfig: completely enable driver for 'COMPILE_TEST'
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 1, 2021 at 9:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> For subject:
>
>   PCI: mt7621: Allow COMPILE_TEST for all arches

Understood, thanks.

Best regards,
    Sergio Paracuellos
>
> On Mon, Nov 15, 2021 at 08:08:09AM +0100, Sergio Paracuellos wrote:
> > Since all MIPS specific code has been moved from the controller driver side
> > there is no more stoppers to enable the driver to be completely enable for
> > 'COMPILE_TEST'. Hence, remove MIPS conditional statement.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  drivers/pci/controller/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > index e917bb3652bb..105ec7dcccc9 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -332,7 +332,7 @@ config PCIE_APPLE
> >
> >  config PCIE_MT7621
> >       tristate "MediaTek MT7621 PCIe Controller"
> > -     depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
> > +     depends on (RALINK && SOC_MT7621) || COMPILE_TEST
> >       select PHY_MT7621_PCI
> >       default SOC_MT7621
> >       help
> > --
> > 2.33.0
> >

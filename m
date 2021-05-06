Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFD4375D12
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 00:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhEFWIj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 18:08:39 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:44951 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhEFWIj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 May 2021 18:08:39 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id A671E100DECA6;
        Fri,  7 May 2021 00:07:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 72EE94F24F; Fri,  7 May 2021 00:07:38 +0200 (CEST)
Date:   Fri, 7 May 2021 00:07:38 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on
 s2idle
Message-ID: <20210506220738.GA2150@wunner.de>
References: <20210506173820.21876-1-Hi-Angel@yandex.ru>
 <20210506214842.GA1436993@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506214842.GA1436993@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 06, 2021 at 04:48:42PM -0500, Bjorn Helgaas wrote:
> On Thu, May 06, 2021 at 08:38:20PM +0300, Konstantin Kharlamov wrote:
> > On Macbook 2013 resuming from s2idle results in external monitor no
> > longer being detected, and dmesg having errors like:
> > 
> >     pcieport 0000:06:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> > 
> > and a stacktrace. The reason turned out that the hw that the quirk
> > powers off does not get powered on back on resume.
> 
> quirk_apple_poweroff_thunderbolt() was added in 2014 by 1df5172c5c25
> ("PCI: Suspend/resume quirks for Apple thunderbolt").  It claims
> "power is automatically restored before resume," so there must be
> something special about s2idle that prevents the power-on.

With s2idle, the machine isn't suspended via ACPI, so the AML code
which powers the controller off isn't executed.  The dance to prepare
the controller for power-off consequently isn't necessary but rather
harmful.

To get the same power savings as with ACPI suspend, the controller
needs to be powered off via runtime suspend.  I posted patches for
that back in 2016.  I'm using them on my laptop, they need some
polishing and rebasing before I can repost them due to massive
changes that have happened in the thunderbolt driver in the meantime.
Without these patches, the controller sucks 1.5W of power in s2idle.

> Obviously the *hardware* hasn't changed since 1df5172c5c25.  Is s2idle
> something that wasn't tested back then, or is this problem connected
> to an s2idle change since then?  Can we identify a commit that
> introduced this problem?  That would help with backporting or stable
> tags.

Yes I believe the quirk predates the introduction of s2idle by a couple
of years.

> > Signed-off-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

The patch looks fine to me.

Thanks,

Lukas

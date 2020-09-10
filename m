Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E0426399B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 03:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgIJB6b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 21:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730172AbgIJBza (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Sep 2020 21:55:30 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D772220D;
        Thu, 10 Sep 2020 01:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599699628;
        bh=kQwPz8fwRd0SLd7ZBev0DNqTLAsOJ5rAyPsQNJ5LVHU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Pd6aiAptEYFVlfzgX4+ihMoDnmI5jqSZqCrsdiBYFoS1aUjW5Vz1d6rm1XyQtveJb
         N2Xqh/levS4HKRjspA61XXYTOJrM7ycKnk3TnohLuyWWw/JnaGJU+pV3dmxLoZImsv
         LtbbMjG1aP+Ii/yzAD+lppey2+SV9P1GYgWOLTa8=
Date:   Wed, 9 Sep 2020 20:00:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Ben Skeggs <bskeggs@redhat.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add a quirk to skip 1000 ms default link activation
 delay on some devices
Message-ID: <20200910010026.GA743553@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907084349.GZ2495@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 07, 2020 at 11:43:49AM +0300, Mika Westerberg wrote:
> On Thu, Sep 03, 2020 at 01:11:22PM -0500, Bjorn Helgaas wrote:
> > On Mon, Aug 31, 2020 at 12:31:47PM +0300, Mika Westerberg wrote:
> > > Kai-Heng Feng reported that it takes a long time (> 1 s) to resume
> > > Thunderbolt-connected devices from both runtime suspend and system sleep
> > > (s2idle).
> > > 
> > > This was because some Downstream Ports that support > 5 GT/s do not also
> > > support Data Link Layer Link Active reporting.  Per PCIe r5.0 sec 6.6.1:
> > > 
> > >   With a Downstream Port that supports Link speeds greater than 5.0 GT/s,
> > >   software must wait a minimum of 100 ms after Link training completes
> > >   before sending a Configuration Request to the device immediately below
> > >   that Port. Software can determine when Link training completes by
> > >   polling the Data Link Layer Link Active bit or by setting up an
> > >   associated interrupt (see Section 6.7.3.3).
> > > 
> > > Sec 7.5.3.6 requires such Ports to support DLL Link Active reporting,
> > > but at least the Intel JHL6240 Thunderbolt 3 Bridge [8086:15c0] and
> > > Intel JHL7540 Thunderbolt 3 Bridge [8086:15e7, 8086:15ea, 8086:15ef] do
> > > not.
> > 
> > Is there any erratum about this?  I'm just hoping to avoid the
> > maintenance hassle of adding new devices to the quirk.  If Intel
> > acknowledges this as a defect and has a plan to fix it, that would
> > help a lot.  If they *don't* think it's a defect, then maybe they have
> > a hint about how we should handle this generically.
> 
> I don't think there is any public documentation about these chips so
> probably no errata either. I did ask our TBT HW folks about this but so
> far did not get any answer.

Huh.  AFAICT this is a non-fatal issue -- the only problem is that
resume takes longer than it should.  The fix is somewhat ugly, both
because we have to maintain a list of affected devices, and because it
clutters a generic code path that is already quite complicated.

That's all to say that I'm not very happy about this and am not in a
huge hurry to apply it.  Intel is usually pretty good about following
the PCIe spec and documenting issues when they occur.  For some reason
TBT seems like an exception.

I don't maintain the TBT-specific stuff, so I personally don't care
all that much about that.  But this issue is plain PCIe, nothing to do
with TBT.  Kai-Heng, you, and I have all spent a lot time trying to
figure this out, and it makes me sad that Intel isn't giving us any
help.

Can you please ask them again?

Bjorn

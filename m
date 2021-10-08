Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D782242686F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 13:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbhJHLFm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 07:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240232AbhJHLFk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 07:05:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F42A60F22;
        Fri,  8 Oct 2021 11:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633691024;
        bh=ixdCbhywvm1Wi4A4wpGRQmw9ye9p0Hu4zSlmnqfGsUw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Xf06oiU+lyN9XB/0ZXlvhKLcGJDAGLFDrXh9BJL615nyXZcCwcfWr1eSHrAIgLQnG
         Ovu1UnO/PZ2+q94rcl9lhbsQyYZNmSUkr6pWzyaKGOz77VnimPJ0KFYtZ8v89RmT/n
         d9lqlzNwU6rDLwJ8jO8eSD/C/Z5Ah/UT8XkaCWYqEBAFT5v8Fpr3ppWQ4RRGb/5Hb6
         a+pJANbKOXtxr6tu3+vJQkv+ciADIPcc5E7yqYxTUkLFh5K8iANqVJKnP059551eEL
         DtQ2uL9K/Xf+zN+aEnBMDXXeq7YpBdROJLGR9DNJrPoP1JT7ADfGYvVorXmWQEO5ka
         wy9FRRXKRah9w==
Date:   Fri, 8 Oct 2021 06:03:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelvin.Cao@microchip.com
Cc:     kurt.schwemmer@microsemi.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kelvincao@outlook.com,
        logang@deltatee.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Message-ID: <20211008110342.GA1314227@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37d0615c8a9a5e7c55527f4d478a0e707292c1ec.camel@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 08, 2021 at 12:06:18AM +0000, Kelvin.Cao@microchip.com wrote:
> On Thu, 2021-10-07 at 16:23 -0500, Bjorn Helgaas wrote:
> > On Wed, Oct 06, 2021 at 09:27:49PM +0000, Kelvin.Cao@microchip.com
> > wrote:
> > > On Wed, 2021-10-06 at 15:20 -0500, Bjorn Helgaas wrote:
> > > > On Wed, Oct 06, 2021 at 07:00:55PM +0000, 
> > > > Kelvin.Cao@microchip.com
> > > > wrote:
> > > > So wait, you mean you just intentionally ask the firmware to
> > > > reset, knowing that the device will be unusable until the user
> > > > reboots or does a manual rescan?  And the way to improve this is
> > > > for the driver to report an error to the user instead of hanging?
> > > > I *guess* that might be some sort of improvement, but seems like
> > > > a
> > > > pretty small one.
> > > 
> > > Yes, however, I believe it's something our users really like to
> > > have...  With this, they can do their user space
> > > programming/scripting more easily in a synchronous fashion.
> > > 
> > > > >   - The firwmare crashes and doesn't respond, which normally is
> > > > >   the reason for users to issue a firmware reset command to try
> > > > >   to recover it via either the driver or a sideband interface.
> > > > >   The firmware may not be able to recover by a reset in some
> > > > >   extream situations like hardware errors, so that an error
> > > > >   return is probably all the users can get before another level
> > > > >   of recovery happens.
> > > > > 
> > > > > So I'd think this patch is still making the driver better in
> > > > > some way.
> > 
> > OK.  I still think the fact that all these different mechanisms can
> > reset the device behind your back and make the switch and anything on
> > the other side of it just stop working is ..., well, let's just say
> > it's quite surprising to me.
> 
> Actually there're mechanisms like permission control to limit what
> people can do in the firmware, so I guess it's not as bad as it sounds
> like. 
> > 
> > Well, at least this isn't quite so much a mystery anymore and maybe
> > we
> > can improve the commit log.  E.g., maybe something like this:
> > 
> >   A firmware hard reset may be initiated by various mechanisms
> >   including a UART interface, TWI sideband interface from BMC, MRPC
> >   command from userspace, etc.  The switchtec management driver is
> >   unaware of these resets.
> > 
> >   The reset clears PCI state including the BARs and Memory Space
> >   Enable bits, so the device no longer responds to the MMIO accesses
> >   the driver uses to operate it.
> > 
> >   MMIO reads to the device will fail with a PCIe error.  When the
> > root
> >   complex handles that error, it typically fabricates ~0 data to
> >   complete the CPU read.
> > 
> >   Check for this sort of error by reading the device ID from MMIO
> >   space.  This ID can never be ~0, so if we see that value, it
> >   probably means the PCIe Memory Read failed and we should return an
> >   error indication to the application using the switchtec driver.
> 
> It looks good to me, the commit log removes the ambiguity. Let me know
> if you prefer a v2 patchset with the updated commit log and naming
> issue fix.

Yes, if you post a v2 of this patch, I'll update my pci/switchtec
branch with it.  Thanks for your patience!

Bjorn

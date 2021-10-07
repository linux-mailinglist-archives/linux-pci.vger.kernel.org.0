Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD93425EB1
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 23:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbhJGVZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 17:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240809AbhJGVZN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 17:25:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82F77610C8;
        Thu,  7 Oct 2021 21:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633641798;
        bh=m67+Gx4edZFG0e9kSDkWEw4xwNUlK0EfQcB0SoTjt9I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VJOMqaIFS8KPiVv7kGoClh3ku2N9QZcf4xZXiaMyidEX706SoLnDy0U8drfaL8xOG
         Yi6JWg38Pe4Rg804YQE6aC6VlcjlGF309PgkhAk+479MtyHtT6VPX46es7mb1FFwUe
         D2qi7PClHiYWFaFwo+Lu9fCXwGqaWliw0Iq/QWoY9QlIi7VBGtynz9K8+OW9mYBzuN
         APVewmcgE+KFUuaCm/m36rLMBiZKunGvlKdbWWEAvUzEvcmAerTkDGMLjiw4WVY0L5
         X2ZIc4aOwVET80UOlyl8c0cqlzWx2ZXw8BV2ARXDOIC7nyF1GgUlJBYt0EO+ZGyu5U
         fVuMGNmG4CM4Q==
Date:   Thu, 7 Oct 2021 16:23:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelvin.Cao@microchip.com
Cc:     kurt.schwemmer@microsemi.com, bhelgaas@google.com,
        kelvincao@outlook.com, logang@deltatee.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Message-ID: <20211007212317.GA1268429@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54263d552d05f2fae706e83aa4c2b31b1983b0e2.camel@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 06, 2021 at 09:27:49PM +0000, Kelvin.Cao@microchip.com wrote:
> On Wed, 2021-10-06 at 15:20 -0500, Bjorn Helgaas wrote:
> > On Wed, Oct 06, 2021 at 07:00:55PM +0000, Kelvin.Cao@microchip.com
> > wrote:

> > So wait, you mean you just intentionally ask the firmware to
> > reset, knowing that the device will be unusable until the user
> > reboots or does a manual rescan?  And the way to improve this is
> > for the driver to report an error to the user instead of hanging?
> > I *guess* that might be some sort of improvement, but seems like a
> > pretty small one.
> 
> Yes, however, I believe it's something our users really like to
> have...  With this, they can do their user space
> programming/scripting more easily in a synchronous fashion.
> 
> > >   - The firwmare crashes and doesn't respond, which normally is
> > >   the reason for users to issue a firmware reset command to try
> > >   to recover it via either the driver or a sideband interface.
> > >   The firmware may not be able to recover by a reset in some
> > >   extream situations like hardware errors, so that an error
> > >   return is probably all the users can get before another level
> > >   of recovery happens.
> > > 
> > > So I'd think this patch is still making the driver better in
> > > some way.

OK.  I still think the fact that all these different mechanisms can
reset the device behind your back and make the switch and anything on
the other side of it just stop working is ..., well, let's just say
it's quite surprising to me.

Well, at least this isn't quite so much a mystery anymore and maybe we
can improve the commit log.  E.g., maybe something like this:

  A firmware hard reset may be initiated by various mechanisms
  including a UART interface, TWI sideband interface from BMC, MRPC
  command from userspace, etc.  The switchtec management driver is
  unaware of these resets.

  The reset clears PCI state including the BARs and Memory Space
  Enable bits, so the device no longer responds to the MMIO accesses
  the driver uses to operate it.

  MMIO reads to the device will fail with a PCIe error.  When the root
  complex handles that error, it typically fabricates ~0 data to
  complete the CPU read.

  Check for this sort of error by reading the device ID from MMIO
  space.  This ID can never be ~0, so if we see that value, it
  probably means the PCIe Memory Read failed and we should return an
  error indication to the application using the switchtec driver.

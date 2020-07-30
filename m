Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA13233706
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 18:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgG3QpD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 12:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbgG3QpD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jul 2020 12:45:03 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E489206F5;
        Thu, 30 Jul 2020 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596127502;
        bh=ZHv49bRPUMc8wtqHmDDXY167SM8hCdQeAcjRFf6RGUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=J6wuVBg/QSGnSMbRxcVnjyEtVvOa02ubGczlviZgxT7DRV1gn+TmqNUDQ2+85yaXV
         rROxCduJ6BfYQ2DoJwFyHypyGfZ5dpIuHSJE3A8tdK0hrtqtW29xsqrJWqwxb/vG+M
         /ZJcWfFFGbJHBnJ7bM2JVleuIYHT38G3nX2zDv40=
Date:   Thu, 30 Jul 2020 11:45:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
        f.fainelli@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] PCI: iproc: Stop using generic config read/write
 functions
Message-ID: <20200730164500.GA2046343@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c0d88e-8aa0-c0a4-52f7-c9ae9fc5f495@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 30, 2020 at 09:36:14AM -0700, Ray Jui wrote:
> On 7/30/2020 9:09 AM, Bjorn Helgaas wrote:
> > On Thu, Jul 30, 2020 at 03:37:46PM +1200, Mark Tomlinson wrote:
> >> The pci_generic_config_write32() function will give warning messages
> >> whenever writing less than 4 bytes at a time. As there is nothing we can
> >> do about this without changing the hardware, the message is just a
> >> nuisance. So instead of using the generic functions, use the functions
> >> that have already been written for reading/writing the config registers.
> > 
> > The reason that pci_generic_config_write32() message is there is
> > because, as the message says, a read/modify/write may corrupt bits in
> > adjacent registers.  
> > 
> > It makes me a little queasy to do these read/modify/write sequences
> > silently.  A generic driver doing an 8- or 16-bit config write has no
> > idea that the write may corrupt an adjacent register.  That leads to
> > bugs that are very difficult to debug and only reproducible on iProc.
> > 
> > The ratelimiting on the current pci_generic_config_write32() message
> > is based on the call site, not on the device.  That's not ideal: we
> > may emit several messages for device A, trigger ratelimiting, then do
> > a write for device B that doesn't generate a message.
> > 
> > I think it would be better to have a warning once per device, so if
> > XYZ device has a problem and we look at the dmesg log, we would find a
> > single message for device XYZ as a hint.  Would that reduce the
> > nuisance level enough?
> 
> I'm in favor of this. I agree with you that we do need the warnings
> because some PCIe config registers that are read/write to clear.
> 
> But the current amount of warning messages generated from these config
> register access is quite massive and often concerns the users who are
> less familiar with the reason/purpose of the warnings. We were asked
> about these warnings by multiple customers. People freaked out when they
> see "corrupt" in the warning messages, :)

Yeah, I'm sure they would.  Hopefully the message makes it all the way
back to the hardware designers ;)

> Limiting the warning to once per device seems to be a reasonable
> compromise to me.

We (you, I mean :)) could also look at the particular warnings.  If
they're triggered by PCI core writes that are 8- or 16-bits when they
*could* be 32-bits, it might make sense to widen them.  I know there
are places that do 8-bit writes to 16-bit registers; maybe there are
similar ones to 32-bit registers.

Bjorn

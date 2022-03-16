Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33A64DBA05
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 22:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242268AbiCPVRG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 17:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237814AbiCPVRG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 17:17:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602AE1CFCF;
        Wed, 16 Mar 2022 14:15:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF4CC61526;
        Wed, 16 Mar 2022 21:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AD4C340EC;
        Wed, 16 Mar 2022 21:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647465350;
        bh=SCnj01khQKDFlY7lVfCpTjScv0OrXH8OcizFwNnrj7o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TT5+7h3EeBdk9ofVVp0NEo58xPGhOJ3BZljU2ft3arcZY2tuEwynuF6ml2RBY2mNz
         lhStU6khrk0BQFRfvO1QFNkppfxOpIjzXfBT1jqU2+W9tnSS6Tmbkmn6rVhf1ZXOc3
         bzwC4OniGdrW+JclipWVGr7qj06vvNlrwPXUduW25+TlOUIKEoOtRJQvZjEBWUKkh1
         7GJYN6xAHZi/hMGM2Zh5V+J2IuvgigD86cG5NycpOvRPRErx0geOZPkzdE3mkOxfUe
         ZdeDT8D5XkGTvHGIg676FqknBHNgzNXj3A8JXsk9nFS5yY4JF7b/BmzcLKNvpT96fL
         rvrBVxYXY+JoQ==
Date:   Wed, 16 Mar 2022 16:15:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, micklorain@protonmail.com,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v1 1/1] PCI: Enable INTx quirk for ATI PCIe-USB adapter
Message-ID: <20220316211548.GA677098@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjIMY1/r15xj65pZ@smile.fi.intel.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex]

On Wed, Mar 16, 2022 at 06:12:19PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 16, 2022 at 06:52:09AM -0500, Bjorn Helgaas wrote:
> > On Wed, Mar 16, 2022 at 12:27:57PM +0200, Andy Shevchenko wrote:
> > > On Tue, Mar 15, 2022 at 03:22:31PM -0500, Bjorn Helgaas wrote:
> > > > On Tue, Mar 15, 2022 at 12:09:08PM +0200, Andy Shevchenko wrote:
> > > > > On Mon, Mar 14, 2022 at 02:42:53PM -0500, Bjorn Helgaas wrote:
> > > > > > On Mon, Mar 14, 2022 at 12:14:48PM +0200, Andy Shevchenko wrote:
> > > > > > > ATI PCIe-USB adapter advertises MSI, but it doesn't work
> > > > > > > if INTx is disabled.  Enable the respective quirk as
> > > > > > > it's done for other ATI devices on this chipset,
> > > > > > > 
> > > > > > > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on
> > > > > > > PCI devices")

> > > > Anyway, I applied this to pci/msi for v5.18 with the following
> > > > commit log:
> > > > 
> > > >     PCI: Disable broken MSI on ATI SB600 USB adapters
> > > > 
> > > >     Some ATI SB600 USB adapters advertise MSI, but MSI doesn't
> > > >     work if INTx is disabled.  Disable MSI on these adapters.
> > > 
> > > But IIUC MSI is _not_ disabled. That's why I have issued this
> > > version of the patch with different commit message. Did I
> > > misunderstand something?
> > 
> > Oh, right, of course.  Sorry, I was asleep at the wheel.
> 
> Are you going to fix that?

Yes, of course, I'll do something with the commit message after we
figure out how to handle PCI_COMMAND_INTX_DISABLE.

> > I guess it's just that for these devices, we don't disable INTx
> > when enabling MSI.  I can't remember why we disable INTx when
> > enabling MSI, but it raises the question of whether it's better to
> > leave INTx enabled or to just disable use of MSI completely.
> 
> It's required by specification to disable INTx if I read 6.1.4.3
> Enabling Operation correctly.

Thanks for the reference; I was looking for something like that.  But
I don't think this section requires us to set
PCI_COMMAND_INTX_DISABLE.  For the benefit of folks without the spec,
PCIe r6.0, sec 6.1.4.3 says:

  To maintain backward compatibility, the MSI Enable bit in the
  Message Control Register for MSI and the MSI-X Enable bit in the
  Message Control Register for MSI-X are each Clear by default (MSI
  and MSI-X are both disabled). System configuration software Sets one
  of these bits to enable either MSI or MSI-X, but never both
  simultaneously. Behavior is undefined if both MSI and MSI-X are
  enabled simultaneously. Software disabling either mechanism during
  active operation may result in the Function dropping pending
  interrupt conditions or failing to recognize new interrupt
  conditions. While enabled for MSI or MSI-X operation, a Function is
  prohibited from using INTx interrupts (if implemented) to request
  service (MSI, MSI-X, and INTx are mutually exclusive).

The only *software* constraints I see are (1) software must never
enable both MSI and MSI-X simultaneously, and (2) if software disables
MSI or MSI-X during active operation, the Function may fail to
generate an interrupt when it should.

I read the last sentence as a constraint on the *hardware*: if either
MSI or MSI-X is enabled, the Function is not allowed to use INTx,
regardless of the state of PCI_COMMAND_INTX_DISABLE.

I searched the spec for "Interrupt Disable", looking for situations
where software might be *required* to set it, but I didn't see
anything.

I suspect "Interrupt Disable" was intended to help the OS stop all
activity from a device during hot-plug or reconfiguration, as hinted
at in sec 6.4, "Device Synchronization":

  The ability of the driver and/or system software to block new
  Requests from the device is supported by the Bus Master Enable,
  SERR# Enable, and Interrupt Disable bits in the Command register
  (Section 7.5.1.1.3) of each device Function, and other such control
  bits.

So I'm trying to figure out why when enabling MSI we need to set
PCI_COMMAND_INTX_DISABLE for most devices, but it's safe to skip that
for these quirked devices.

Bjorn

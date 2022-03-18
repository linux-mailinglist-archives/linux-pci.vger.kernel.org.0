Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F634DDF49
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 17:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbiCRQtH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 12:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiCRQtE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 12:49:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EFE2F09F6;
        Fri, 18 Mar 2022 09:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8A05B821BD;
        Fri, 18 Mar 2022 16:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA48C340E8;
        Fri, 18 Mar 2022 16:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647622062;
        bh=YUFT5u1FeXv5hXDLhIL7XgE3OYqFqFNIcMaARLccIIw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kYoO3qh0w0xWRjXusTea/pKrQf6FkPqFdhEFSanFDKg9rkB0G/ItfKJKgiuGpZWCC
         k7cQ/epocZq1Su/kIG76o4pTnnjTBlLi/ITyDiqWs76SfKEwaVrtcHGCoFAsmWTk+c
         t1bJvr7bQIhEf130sbSZB48FtsdMR77+c8F4FPw/ygcXqws/XTrWK7d0mrIdDF2Bdm
         JR2fygLxGtI1frXubU7ciOzdSGyhUKBY09WBW7kGyQELLJLFFkvPbjSFZSDLkNyTKT
         MKuWNjBvALXkjsg9kp/qSNplTRjcE+10k50uZqEgSJRUSXrY7QPQPf6GqyqKR5rfVK
         3yBD/vnkpPh3Q==
Date:   Fri, 18 Mar 2022 11:47:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        micklorain@protonmail.com,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v1 1/1] PCI: Enable INTx quirk for ATI PCIe-USB adapter
Message-ID: <20220318164740.GA816988@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Veb4BqcGW=sCXEfrJ2ksvnXmjN-XZ5L6ttcQ8SJneg27w@mail.gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 18, 2022 at 12:42:18PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 17, 2022 at 11:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Mar 17, 2022 at 10:59:28AM +0200, Andy Shevchenko wrote:
> > > On Wed, Mar 16, 2022 at 04:15:48PM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Mar 16, 2022 at 06:12:19PM +0200, Andy Shevchenko wrote:
> > > > > On Wed, Mar 16, 2022 at 06:52:09AM -0500, Bjorn Helgaas wrote:
> > > > > > On Wed, Mar 16, 2022 at 12:27:57PM +0200, Andy Shevchenko wrote:
> > > > > > > On Tue, Mar 15, 2022 at 03:22:31PM -0500, Bjorn Helgaas wrote:
> > > > > > > > On Tue, Mar 15, 2022 at 12:09:08PM +0200, Andy Shevchenko wrote:
> > > > > > > > > On Mon, Mar 14, 2022 at 02:42:53PM -0500, Bjorn Helgaas wrote:
> > > > > > > > > > On Mon, Mar 14, 2022 at 12:14:48PM +0200, Andy Shevchenko wrote:
> > > > > > > > > > > ATI PCIe-USB adapter advertises MSI, but it doesn't work
> > > > > > > > > > > if INTx is disabled.  Enable the respective quirk as
> > > > > > > > > > > it's done for other ATI devices on this chipset,
> > > > > > > > > > >
> > > > > > > > > > > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on
> > > > > > > > > > > PCI devices")
> > > >
> > > > > > > > Anyway, I applied this to pci/msi for v5.18 with the following
> > > > > > > > commit log:
> > > > > > > >
> > > > > > > >     PCI: Disable broken MSI on ATI SB600 USB adapters
> > > > > > > >
> > > > > > > >     Some ATI SB600 USB adapters advertise MSI, but MSI doesn't
> > > > > > > >     work if INTx is disabled.  Disable MSI on these adapters.
> > > > > > >
> > > > > > > But IIUC MSI is _not_ disabled. That's why I have issued this
> > > > > > > version of the patch with different commit message. Did I
> > > > > > > misunderstand something?
> > > > > >
> > > > > > Oh, right, of course.  Sorry, I was asleep at the wheel.
> > > > >
> > > > > Are you going to fix that?
> > > >
> > > > Yes, of course, I'll do something with the commit message after we
> > > > figure out how to handle PCI_COMMAND_INTX_DISABLE.
> > > >
> > > > > > I guess it's just that for these devices, we don't disable INTx
> > > > > > when enabling MSI.  I can't remember why we disable INTx when
> > > > > > enabling MSI, but it raises the question of whether it's better to
> > > > > > leave INTx enabled or to just disable use of MSI completely.
> > > > >
> > > > > It's required by specification to disable INTx if I read 6.1.4.3
> > > > > Enabling Operation correctly.
> > > >
> > > > Thanks for the reference; I was looking for something like that.  But
> > > > I don't think this section requires us to set
> > > > PCI_COMMAND_INTX_DISABLE.  For the benefit of folks without the spec,
> > > > PCIe r6.0, sec 6.1.4.3 says:
> > > >
> > > >   To maintain backward compatibility, the MSI Enable bit in the
> > > >   Message Control Register for MSI and the MSI-X Enable bit in the
> > > >   Message Control Register for MSI-X are each Clear by default (MSI
> > > >   and MSI-X are both disabled). System configuration software Sets one
> > > >   of these bits to enable either MSI or MSI-X, but never both
> > > >   simultaneously. Behavior is undefined if both MSI and MSI-X are
> > > >   enabled simultaneously. Software disabling either mechanism during
> > > >   active operation may result in the Function dropping pending
> > > >   interrupt conditions or failing to recognize new interrupt
> > > >   conditions. While enabled for MSI or MSI-X operation, a Function is
> > > >   prohibited from using INTx interrupts (if implemented) to request
> > > >   service (MSI, MSI-X, and INTx are mutually exclusive).
> > > >
> > > > The only *software* constraints I see are (1) software must never
> > > > enable both MSI and MSI-X simultaneously, and (2) if software disables
> > > > MSI or MSI-X during active operation, the Function may fail to
> > > > generate an interrupt when it should.
> > > >
> > > > I read the last sentence as a constraint on the *hardware*: if either
> > > > MSI or MSI-X is enabled, the Function is not allowed to use INTx,
> > > > regardless of the state of PCI_COMMAND_INTX_DISABLE.
> > > >
> > > > I searched the spec for "Interrupt Disable", looking for situations
> > > > where software might be *required* to set it, but I didn't see
> > > > anything.
> > > >
> > > > I suspect "Interrupt Disable" was intended to help the OS stop all
> > > > activity from a device during hot-plug or reconfiguration, as hinted
> > > > at in sec 6.4, "Device Synchronization":
> > > >
> > > >   The ability of the driver and/or system software to block new
> > > >   Requests from the device is supported by the Bus Master Enable,
> > > >   SERR# Enable, and Interrupt Disable bits in the Command register
> > > >   (Section 7.5.1.1.3) of each device Function, and other such control
> > > >   bits.
> > > >
> > > > So I'm trying to figure out why when enabling MSI we need to set
> > > > PCI_COMMAND_INTX_DISABLE for most devices, but it's safe to skip that
> > > > for these quirked devices.
> > >
> > > I guess it's wrong wording in the last paragraph. It's not safe, but it's
> > > _required_ since HW doesn't follow PCI specification that clearly says:
> > > "MSI, MSI-X, and INTx are mutually exclusive".
> >
> > I agree there's a defect in these SB600 devices.  My guess is that
> > PCI_COMMAND_INTX_DISABLE actually disables both INTx and MSI, when
> > it's only supposed to disable INTx.
> >
> > I'm pretty sure the spec doesn't actually require software to set
> > Interrupt Disable when enabling MSI, since MSI was added in PCI r2.2,
> > which included this text in sec 6.8.2:
> >
> >   System configuration software sets [the MSI Enable] bit to enable
> >   MSI. ...  Once enabled, a function is prohibited from using its
> >   INTx# pin (if implemented) to request service (MSI and INTx# are
> >   mutually exclusive).
> >
> > and Interrupt Disable was added later, in PCI r2.3, with no mention of
> > a connection with MSI.  All the specs from PCI r2.2 to PCIe r6.0
> > include the text above about not using INTx# if MSI or MSI-X is
> > enabled, but that's not the same as requiring software to set
> > Interrupt Disable.  Linux has set Interrupt Disable when enabling MSI
> > ever since MSI support was added [1], so I would hesitate to change
> > that even though I don't think it's required.
> 
> Thanks for diving into the history of the specification. What I learnt
> about any of the specifications is that it usually has a lot of
> implications that are only understandable (known) to the specification
> author(s). This gives a room of misinterpretation. In any case I
> usually apply my common sense denominator, so I try to go with the
> straight logic. In this case it seems to me that keeping both enabled
> is illogical and Linux does the right thing (means the author of the
> Linux kernel implementation is on the same page with me).
> 
> > What I don't like about PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG is that it
> > changes the generic code path in a sort of random way, i.e., this
> > device becomes yet another special case in how we handle Interrupt
> > Disable.
> >
> > What would you think about just setting pdev->no_msi instead, so we
> > don't try to use MSI at all on these devices?  I think that's what we
> > did before 306c54d0edb6.
> 
> Yes, we did. But why should we go this way if it already established a
> special case disregarding my patch(es)? If you want to do that you
> need to explain why other devices on the same chipset should enable
> MSI and what's wrong with enabling MSI on the USB devices. My
> understanding is that the MSI is a good thing to have due to
> performance benefits and taking into account other devices that have
> already been using it on the other devices of the same chipset tells
> me that's okay. Moreover, the reporter of the bug confirmed that MSI
> works for them after applying this quirk fix.

I agree that MSI is generally to be preferred over INTx.  In this
case, it's an old USB device and I don't think there's any real
performance benefit.

The problem with enabling MSI on these USB devices is that the generic
MSI code doesn't work correctly.  Since we've been using them without
MSI in the past, and they have some defect that makes MSI not work
correctly, it seems like the simplest solution is to avoid using MSI,
something like the patch below.

Would I prefer the same for all the other existing users of
PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG?  Yes.  Enough to change the status
quo, which would be a performance regression, and potentially break
something?  Probably not.

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d2dd6a6cda60..c0e6b031bb5d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2675,6 +2675,18 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SERVERWORKS,
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8132_BRIDGE,
 			 ht_enable_msi_mapping);
 
+static void quirk_no_msi(struct pci_dev *dev)
+{
+	pci_info(dev, "Disabling MSI to avoid hardware defect\n");
+	dev->no_msi = 1;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4386, quirk_no_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4387, quirk_no_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4388, quirk_no_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4389, quirk_no_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x438a, quirk_no_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x438b, quirk_no_msi);
+
 /*
  * The P5N32-SLI motherboards from Asus have a problem with MSI
  * for the MCP55 NIC. It is not yet determined whether the MSI problem

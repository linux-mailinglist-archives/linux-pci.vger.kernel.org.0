Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752AC733FA5
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jun 2023 10:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjFQIbM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Jun 2023 04:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjFQIbL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Jun 2023 04:31:11 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B019A10CF;
        Sat, 17 Jun 2023 01:31:10 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 09213100D941B;
        Sat, 17 Jun 2023 10:31:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C86FE1D5B80; Sat, 17 Jun 2023 10:31:08 +0200 (CEST)
Date:   Sat, 17 Jun 2023 10:31:08 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v1] PCI: pciehp: Make sure DPC trigger status is reset in
 PDC handler
Message-ID: <20230617083108.GB26803@wunner.de>
References: <20230615062559.1268404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230615183550.GA9773@wunner.de>
 <713d71dc-c4a5-cd7b-2deb-343c244dd14d@linux.intel.com>
 <20230616090635.GA17565@wunner.de>
 <c2d0c925-ffe1-4431-2d39-8cd6919486f0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2d0c925-ffe1-4431-2d39-8cd6919486f0@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 16, 2023 at 04:27:33PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 6/16/23 2:06 AM, Lukas Wunner wrote:
> > On Thu, Jun 15, 2023 at 04:03:54PM -0700, Sathyanarayanan Kuppuswamy wrote:
> >> On 6/15/23 11:35 AM, Lukas Wunner wrote:
> >>> On Wed, Jun 14, 2023 at 11:25:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >>>> During the EDR-based DPC recovery process, for devices with persistent
> >>>> issues, the firmware may choose not to handle the DPC error and leave
> >>>> the port in DPC triggered state. In such scenarios, if the user
> >>>> replaces the faulty device with a new one, the OS is expected to clear
> >>>> the DPC trigger status in the hotplug error handler to enable the new
> >>>> device enumeration.
> > [...]
> >>> pciehp_unconfigure_device() seems like a more appropriate place to me.
> >>
> >> I initially thought to add it there. Spec also recommends clearing it
> >> when removing the device. But I wasn't sure if pciehp_unconfigure_device()
> >> would be called only during device removal.
> > 
> > It is.
> 
> Do you know how pciehp_unconfigure_device() will be called when the device is
> removed? Is it due to a DLLSC event or a PDC state change? If it is DLLSC,
> pciehp_unconfigure_device() may not be called because we ignore the DLLSC
> event if there is an active DPC trigger.

A DLLSC event is only ignored by pciehp if successful recovery
from DPC was possible.  In that case, the device in the slot is
still the *same*.

And you're saying in the commit message that you seek to fix the
case when "the user replaces the faulty device with a *new* one".

So for your goal, ignored DLLSC events shouldn't be relevant.

As to your question, pciehp_ist() doesn't really differentiate
between PDC and DLLSC events.  If either of them occurs,
the slot is brought down through pciehp_handle_presence_or_link_change().

And that will end up in pciehp_unconfigure_device().

I think right at the end of that function, after
pci_unlock_rescan_remove() would be a good place to perform
cleanup of the hotplug port before a newly hotplugged device
can be handled.

Smita's clearing of ARI Forwarding Enable, AtomicOp Requester Enable
and 10-Bit Tag Requester Enable could be done as well at the end of
pciehp_unconfigure_device().


> > We need to differentiate between two cases:
> > 
> > (1) DPC handled by firmware, hotplug handled by OS:
> > 
> >     In this case clearing DPC trigger status from pciehp device removal
> >     code path seems reasonable.  But it must be constrained to
> >     !host_bridge->native_dpc.
> 
> Agree.

The crucial thing here is that the dpc driver isn't bound to the
port if DPC is handled by firmware.  Hence there's no chance of
racing with dpc_reset_link() and it's safe to clear DPC trigger
status from pciehp.


> > (2) DPC handled by OS:
> > 
> >     In this case clearing DPC trigger status from pciehp could race with
> >     the dpc interrupt handler so must not be done.  Instead, I recommend
> 
> If we clear the DPC trigger status in the DLLSC state change handler, I
> agree there could be a race. However, if we clear the DPC trigger in the
> PDC state change handler, I believe it will not race because the device
> has already been removed. Is my understanding correct?

Unfortunately it's not guaranteed that dpc_reset_link() is finished
when pciehp brings down the slot.

So clearing DPC trigger status can only be done safely from the dpc
driver itself (if DPC is handled natively by the OS).

Thanks,

Lukas

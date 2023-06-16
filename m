Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9C1732B14
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 11:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243299AbjFPJIi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 05:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243492AbjFPJIR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 05:08:17 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938BF3AB5;
        Fri, 16 Jun 2023 02:06:37 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9252030004531;
        Fri, 16 Jun 2023 11:06:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8535B11DB42; Fri, 16 Jun 2023 11:06:35 +0200 (CEST)
Date:   Fri, 16 Jun 2023 11:06:35 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v1] PCI: pciehp: Make sure DPC trigger status is reset in
 PDC handler
Message-ID: <20230616090635.GA17565@wunner.de>
References: <20230615062559.1268404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230615183550.GA9773@wunner.de>
 <713d71dc-c4a5-cd7b-2deb-343c244dd14d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <713d71dc-c4a5-cd7b-2deb-343c244dd14d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[cc += Smita]

On Thu, Jun 15, 2023 at 04:03:54PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 6/15/23 11:35 AM, Lukas Wunner wrote:
> > On Wed, Jun 14, 2023 at 11:25:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > During the EDR-based DPC recovery process, for devices with persistent
> > > issues, the firmware may choose not to handle the DPC error and leave
> > > the port in DPC triggered state. In such scenarios, if the user
> > > replaces the faulty device with a new one, the OS is expected to clear
> > > the DPC trigger status in the hotplug error handler to enable the new
> > > device enumeration.
[...]
> > 
> > pciehp_unconfigure_device() seems like a more appropriate place to me.
> > 
> 
> I initially thought to add it there. Spec also recommends clearing it
> when removing the device. But I wasn't sure if pciehp_unconfigure_device()
> would be called only during device removal.

It is.


> > > More details about this issue can be found in PCIe
> > > firmware specification, r3.3, sec titled "DPC Event Handling"
> > > Implementation note.
> > 
> > That Implementation Note contains a lot of text and a fairly complex
> > flow chart. If you could point to specific paragraphs or numbers in
> > the Implementation Note that would make life easier for a reviewer
> > to make the connection between your code and the spec.
> 
> It is the text at the end of the flowchart. Copied it here for reference.
> 
> For devices with persistent errors, a port may be kept in the DPC triggered
> state (disabled) to keep those devices from continuing to generate errors.
> For hot-plug slots, the errant device may be removed and replaced with a new
> device.
> If the DPC trigger state is not cleared, then the port above the newly
> inserted device will still be disabled and will be non-operational.
> Therefore, operating systems may need to modify their hot-plug interrupt
> handling code to clear DPC Trigger Status when a device is removed so that
> a subsequent insertion will succeed.

Please add that excerpt to the commit message.


> > This may run concurrently to dpc_reset_link(), so I'd expect that
> > you need some kind of serialization.  What happens if pciehp clears
> > trigger status behind the DPC driver's back while it is handling an
> > error?
> 
> Currently, we only call pci_dpc_reset_trigger() in PDC interrupt handler.
> 
> Do you think there would be a race between error handler and PDC handler?

Yes I think so.

We need to differentiate between two cases:

(1) DPC handled by firmware, hotplug handled by OS:

    In this case clearing DPC trigger status from pciehp device removal
    code path seems reasonable.  But it must be constrained to
    !host_bridge->native_dpc.

(2) DPC handled by OS:

    In this case clearing DPC trigger status from pciehp could race with
    the dpc interrupt handler so must not be done.  Instead, I recommend
    clearing trigger status from the dpc interrupt handler.  You should
    see a Surprise Down error handled by the dpc interrupt handler.
    Make sure DPC trigger status is *always* cleared in that case.
    
    Note that Smita Koralahalli is currently working on something similar:
    
    https://lore.kernel.org/linux-pci/20230418210526.36514-2-Smita.KoralahalliChannabasappa@amd.com/

    (@Smita sorry for the delay, I'll get to your patches ASAP.)

I recommend splitting the two cases above into two commits, one for
firmware-handled DPC and one for OS-native DPC.  IIUC, you only need
the former to address Dell's finding.

Thanks,

Lukas

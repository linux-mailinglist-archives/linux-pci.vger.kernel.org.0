Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F36373613
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 10:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhEEIMq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 04:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhEEIMq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 04:12:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81A5561078;
        Wed,  5 May 2021 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620202310;
        bh=2laNnaXDtXu5mpdO9hMOxhzvS3BWXU53ZPRV+2GL3xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvB3jtbocymI5+N/cmAdFfshGMT2Gqlj33c1jFLXzQnjjrpzhGwcsAjkEjAVW6tEq
         fV79+JTOntOEO1Nnrzd8y6W3i8Ft22A2cjnCUOnzaOuSoqYAMloBdFLn3K3xI/Qj5i
         UMI2kz6tCK9CnRILxn8n3BWwxwEG03bi/Ktl3VbQ=
Date:   Wed, 5 May 2021 10:11:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: `quirk_usb_handoff_xhci` takes 60 ms with ASM1042
Message-ID: <YJJTQzJS/8Loz8kV@kroah.com>
References: <eed7681d-2bbf-b3a5-4ee3-729b614545bf@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eed7681d-2bbf-b3a5-4ee3-729b614545bf@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 05, 2021 at 09:57:44AM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On an Asus F2A85-M PRO, BIOS 6601 11/25/2014, with an ASM1042 SuperSpeed USB
> Host Controller [1b21:1042], and the xHCI drivers built as modules
> 
>     CONFIG_USB_XHCI_PCI=m
>     CONFIG_USB_XHCI_HCD=m
> 
> `quirk_usb_handoff_xhci` takes 60 ms, which is 15 % of the time to reaching
> `run_init_process()`. I addded some prints, showing the f
> 
>     [    0.308841] pci 0000:03:00.0: PCI->APIC IRQ transform: INT A -> IRQ
> 17
>     [    0.369858] pci 0000:03:00.0: handshake done with timeout = 0
>     [    0.369862] pci 0000:03:00.0: hc_init reached
>     [    0.369865] pci 0000:03:00.0: second handshake done
>     [    0.369869] pci 0000:03:00.0: third handshake done
>     [    0.369909] pci 0000:03:00.0: quirk_usb_early_handoff+0x0/0x670 took
> 59661 usecs
>     […]
>     [    0.415223] Run /lib/systemd/systemd as init process
> 
> Is there a way to optimize this, or move it out “the hot path”?

That's the hardware taking so long, all that function does is make some
PCI calls to the device.  If the driver is built as a module, there
should not be any "hot path" here as the module is loaded async when the
device is discovered, right?

What is waiting for this module to load in order to cause your init to
stall?  Perhaps fix your initramfs logic or build the driver into the
kernel itself to take it off of this "load all the modules and wait"
path?

thanks,

greg k-h

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CC93A09D3
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 04:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhFICOc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 22:14:32 -0400
Received: from netrider.rowland.org ([192.131.102.5]:56697 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231699AbhFICOc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 22:14:32 -0400
Received: (qmail 1828243 invoked by uid 1000); 8 Jun 2021 22:12:37 -0400
Date:   Tue, 8 Jun 2021 22:12:37 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        ierturk@ieee.org
Subject: Re: Strange problem with USB device
Message-ID: <20210609021237.GA1826754@rowland.harvard.edu>
References: <cfc37ce0-823e-0d19-f5d7-fcd571a94943@lwfinger.net>
 <20210608182038.GA1812516@rowland.harvard.edu>
 <a7c7ba62-a74f-d7db-bfd9-4f6c8e25e0b8@lwfinger.net>
 <20210608185314.GB1812516@rowland.harvard.edu>
 <960057be-ef17-49e7-adba-ba2929d3a01f@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960057be-ef17-49e7-adba-ba2929d3a01f@lwfinger.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 08, 2021 at 03:56:11PM -0500, Larry Finger wrote:
> On 6/8/21 1:53 PM, Alan Stern wrote:
> > I don't get it.  If this is a PCIe device, why should it appear
> > on a USB bus?  Wouldn't you expect it to show up as a PCI device
> > on a PCI bus instead?
> > 
> 
> I do not know the internal details, but Realtek packages a PCIe wifi
> device and a bluetooth USB device in the same package. Intel does the
> same thing on my Wireless 7260.
> 
> My lsusb shows:
> Bus 003 Device 002: ID 8087:8000 Intel Corp. Integrated Rate Matching Hub
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 001 Device 002: ID 8087:8008 Intel Corp. Integrated Rate Matching Hub
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 002 Device 004: ID 8087:07dc Intel Corp. Bluetooth wireless interface
> Bus 002 Device 003: ID 0bda:c822 Realtek Semiconductor Corp. Bluetooth Radio
> Bus 002 Device 002: ID 04f2:b3b2 Chicony Electronics Co., Ltd TOSHIBA
> Web Camera - FHD
> Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> I have no devices plugged into a USB port.

Okay, now I get the picture.  The Intel PCIe card contains an 
EHCI USB host controller plus a couple of on-board USB Bluetooth 
devices and an on-board USB webcam, in addition to the PCIe wifi 
device.

Which means you're looking at the problem all wrong.  It isn't a 
USB problem at all; it's a PCI problem.  Namely, why doesn't the 
system detect the USB host controller on the PCIe board?

I have added the PCI maintainer and mailing list to the CC.  
Maybe they can help shed some light.

The original Suse Bugzilla report:

	https://bugzilla.suse.com/show_bug.cgi?id=1186889

shows the Realtek board at PCI address 0000:03:00.0, but there's 
no mention of a USB host controller on that board.  The only host 
controller on the system is the one at address 0000:00:14.0, 
which is xHCI and is directly on the motherboard.

Furthermore, there's no trace of any mention of an EHCI USB host 
controller in the system log.  So maybe the board has to be told 
somehow to turn that controller on before it will show up, and 
the rtw_8822ce driver isn't giving the appropriate order.

Can the bug reporter get information from Windows about the USB 
host controllers, and in particular, the one on the RTL8822 
board?

Alan Stern

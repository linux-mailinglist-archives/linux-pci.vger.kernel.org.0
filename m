Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1C8882C0
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 20:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436693AbfHISik (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 14:38:40 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:51331 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407437AbfHISik (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 14:38:40 -0400
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Aug 2019 14:38:39 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 76C062800935A;
        Fri,  9 Aug 2019 20:28:52 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 42430DFE15; Fri,  9 Aug 2019 20:28:52 +0200 (CEST)
Date:   Fri, 9 Aug 2019 20:28:52 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: Re: [PATCH] PCI: pciehp: Avoid returning prematurely from sysfs
 requests
Message-ID: <20190809182852.rkkhng7d5m5xf3tp@wunner.de>
References: <4174210466e27eb7e2243dd1d801d5f75baaffd8.1565345211.git.lukas@wunner.de>
 <f26a6667-5474-895f-f9ba-1f812c44270e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f26a6667-5474-895f-f9ba-1f812c44270e@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 09, 2019 at 10:28:15AM -0700, sathyanarayanan kuppuswamy wrote:
> On 8/9/19 3:28 AM, Lukas Wunner wrote:
> > A sysfs request to enable or disable a PCIe hotplug slot should not
> > return before it has been carried out.  That is sought to be achieved
> > by waiting until the controller's "pending_events" have been cleared.
> > 
> > However the IRQ thread pciehp_ist() clears the "pending_events" before
> > it acts on them.  If pciehp_sysfs_enable_slot() / _disable_slot() happen
> > to check the "pending_events" after they have been cleared but while
> > pciehp_ist() is still running, the functions may return prematurely
> > with an incorrect return value.
> 
> Can this be fixed by changing the sequence of clearing the pending_events in
> pciehp_ist() ?

It can't.  The processing logic is such that pciehp_ist() atomically
removes bits from pending_events and acts upon them.  Simultaneously, new
events may be queued up by adding bits to pending_events (through a
hardirq handled by pciehp_isr(), through a sysfs request, etc).
Those will be handled in an additional iteration of pciehp_ist().

If I'd delay removing bits from pending_events, I then couldn't tell if
new events have accumulated while others have been processed.
E.g. a PDS event may occur while another one is being processed.
The second PDS events may signify a card removal immediately after
the card has been brought up.  It's crucial not to lose the second PDS
event but act properly on it by bringing the slot down again.

This way of processing events also allows me to easily filter events.
E.g. we tolerate link flaps occurring during the first 100 ms after
enabling the slot simply by atomically removing bits from pending_events
at a certain point.  See commit 6c35a1ac3da6 ("PCI: pciehp: Tolerate
initially unstable link").

Now what I *could* do would be to make the events currently being
processed public, e.g. by adding an "atomic_t current_events" to
struct controller.  Then I could wait in pciehp_sysfs_enable_slot() /
_disable_slot() until both "pending_events" and "current_events"
becomes empty.  But it would basically amount to the same as this patch,
and we don't really need to know *which* events are being processed,
only the *fact* that events are being processed.

Let me know if you have further questions regarding the pciehp
processing logic.

Thanks,

Lukas

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20019269614
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 22:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgINUJK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 16:09:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40237 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725978AbgINUJJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 16:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600114147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5FNGxLw414IlgmqLwQ0FdJNXlkKOR5HmcdZlQQAZx0A=;
        b=ZkBRHspxQ5HTqccs0ojS0rPcUxAPbtIhNLhHwXIWw7xh6bDARIZZZvWcLy9CnQj9ZKcptR
        Tzz1WbC9Yec6M/lxZoAp4TeRImt9s7/erP25lZytOSW2ioKsYf5DUPUkBOvq5lvOiGYbGj
        ldjah0ZuDCq4ocij1z9BdvpOjk+6LDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-ZtfOeI4BNh2U3JbulCR8dw-1; Mon, 14 Sep 2020 16:09:05 -0400
X-MC-Unique: ZtfOeI4BNh2U3JbulCR8dw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5537B1017DC3;
        Mon, 14 Sep 2020 20:09:01 +0000 (UTC)
Received: from zim (ovpn-112-96.phx2.redhat.com [10.3.112.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04A895D994;
        Mon, 14 Sep 2020 20:09:00 +0000 (UTC)
Date:   Mon, 14 Sep 2020 14:08:59 -0600
From:   Myron Stowe <mstowe@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        klimov.linux@gmail.com
Subject: Re: PCIe hot-plug issue: Failed to check link status
Message-ID: <20200914140859.3fb0db2b@zim>
In-Reply-To: <20200910132440.GA1661@wunner.de>
References: <20200908085726.54509090@zim>
        <20200910132440.GA1661@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 10 Sep 2020 15:24:40 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Tue, Sep 08, 2020 at 08:57:26AM -0600, Myron Stowe wrote:
> > On a system with a Mellanox Technologies MT27800 Family [ConnectX-5]
> > NIC controller containing a power button, hot-plug fails to function
> > properly.  
> [...]
> > https://bugzilla.kernel.org/show_bug.cgi?id=209113  
> 
> Thanks for the report.
> 
> So in the dmesg output you've provided, the card is already inserted
> when the machine boots.  At 233 seconds, the Attention Button is
> pressed twice within 200 msec (the second press cancels the first).
> At 235 sec, the button is pressed again and after 5 sec the slot is
> brought down. So far so good.
> 
> At 291 sec the button is pressed but bringup of the slot fails.
> What happens here is, pciehp notices that upon the button press,
> a card is already present in the slot.  So for convenience,
> instead of waiting the full 5 sec, it attempts to bring up the slot
> immediately.  That fails because Data Link Layer Link Active isn't
> set within 1 sec.
> 
> The difference to v4.18 is that back then, pciehp waited the full
> 5 sec before bringing up the slot.
> 
> Per PCIe r4.0 sec 6.7.1.8:
> 
>     After turning power on, software must wait for a Data Link Layer
>     State Changed event, as described in Section 6.7.3.3.
> 
> And per sec 6.7.3.3:
> 
>     The Data Link Layer State Changed event must occur within 1 second
>     of the event that initiates the hot-insertion. If a power
> controller is supported, the time out interval is measured from when
> software initiated a write to the Slot Control register to turn on
> the power. [...] Software is allowed to time out on a hot add
> operation if the Data Link Layer State Changed event does not occur
> within 1 second.
> 
> So we adhere to the spec regarding the timeout between enabling power
> and waiting for DLLLA.  We do not exactly adhere to the spec regarding
> the 5 sec delay between button press and acting on it.  But I can't
> really imagine that's the problem.
> 
> As a shot in the dark, could you amend pcie_wait_for_link_delay()
> in drivers/pci/pci.c and increase the "timeout = 1000" a little?
> Maybe more than 1 sec is necessary in this case between enabling
> power and timing out for lack of a link?
> 
> The v4.18 output you've provided in the bugzilla is incomplete and
> lacks time stamps.  Could you provide it in full?

Hi Lukas,

I got back a full 'dmesg' log, with the hot-plug event included, from
the earlier, working scenario, kernel.  It's attached to the BZ as
"dmesg log of v3.10+ showing successful hot-plug event".  Note the
v3.10 basis as I was incorrect before in thinking the working case was
from a v4.18 basis. For this case, the hot-plug event starts 113
seconds in.

As for your "shot in the dark", the reporters doubled the timeout value
in pcie_wait_for_link_delay() and had positive results.  The 'dmesg'
log from that testing is also attached to the BZ as "dmesg log of
v5.8.8 with increased timeout".  So it looks as if this specific
controller is not adhering to the Data Link Layer State Changed event
within the specified time.


There was an earlier attachment of a couple of 'dmesg' logs that you
can ignore (i.e., dmesg with timestamp for RHEL...).

Myron

> 
> Thanks,
> 
> Lukas
> 


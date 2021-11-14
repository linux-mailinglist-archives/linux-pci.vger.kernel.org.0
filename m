Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E9744F9E2
	for <lists+linux-pci@lfdr.de>; Sun, 14 Nov 2021 19:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhKNSJE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Nov 2021 13:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKNSJD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Nov 2021 13:09:03 -0500
X-Greylist: delayed 5166 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 Nov 2021 10:06:07 PST
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15855C061746;
        Sun, 14 Nov 2021 10:06:05 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 647C0100D940E;
        Sun, 14 Nov 2021 19:06:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 434BE2BC2E5; Sun, 14 Nov 2021 19:06:04 +0100 (CET)
Date:   Sun, 14 Nov 2021 19:06:04 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pciehp: fast unplug for virtual machines
Message-ID: <20211114180604.GA23907@wunner.de>
References: <20211111090225.946381-1-kraxel@redhat.com>
 <20211114163958.GA7211@wunner.de>
 <20211114122249-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114122249-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 14, 2021 at 12:24:43PM -0500, Michael S. Tsirkin wrote:
> On Sun, Nov 14, 2021 at 05:39:58PM +0100, Lukas Wunner wrote:
> > Why does virtual hardware implement the Attention Button if it's
> > perceived as annoying?  Just amend qemu so that it doesn't advertise
> > presence of an Attention Button to get rid of the delay.  (Clear the
> > Attention Button Present bit in the Slot Capabilities register.)
> 
> Because we want ability to request device removal from outside the
> guest.

Please elaborate.  Does "outside the guest" mean on the host?
How do you represent the Attention Button outside the guest
and route events through to the guest?


> > An Attention Button doesn't make any sense for virtual hardware
> > except to test or debug support for it in the kernel.  Just make
> > presence of the Attention Button optional and be done with it.
> > 
> > You'll still be able to bring down the slot in software via the
> > "remove" attribute in sysfs.
> 
> This requires guest specific code though. Emulating the attention button
> works in a guest independent way.

It sounds like you're using the Attention Button because it does
almost, but not quite what you want for your specific use case.
Now you're trying to change its behavior in a way that deviates
from the spec to align it with your use case.

Why don't you just trigger surprise-removal from outside the guest?

Thanks,

Lukas

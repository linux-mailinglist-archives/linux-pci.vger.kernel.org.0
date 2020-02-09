Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F6E156A84
	for <lists+linux-pci@lfdr.de>; Sun,  9 Feb 2020 14:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgBINId (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Feb 2020 08:08:33 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:57277 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgBINId (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Feb 2020 08:08:33 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 977BB2800A29A;
        Sun,  9 Feb 2020 14:08:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5C2C5DA4BE; Sun,  9 Feb 2020 14:08:31 +0100 (CET)
Date:   Sun, 9 Feb 2020 14:08:31 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Enzo Matsumiya <ematsumiya@suse.de>,
        kbusch@kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Make sure pciehp_isr clears interrupt
 events
Message-ID: <20200209130831.lfrfylascfzh4d4y@wunner.de>
References: <20200129005151.GA247355@google.com>
 <97162f37-9cde-d349-52e0-c1aaa70ec7a9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97162f37-9cde-d349-52e0-c1aaa70ec7a9@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 29, 2020 at 03:55:21PM -0600, Stuart Hayes wrote:
> On 1/28/20 6:51 PM, Bjorn Helgaas wrote:
> > I don't understand this limit of six.  We clear a status bit above,
> > but what's to prevent that same bit from being set again after we read
> > it but before we write it?
> 
> I think the nature of the status bits (power fault, link active, etc)
> means that they shouldn't be toggling at a high frequency, and there are
> only six status bits that can cause this interrupt, which is why I chose
> six.  But it is really just an arbitrary number that should be larger
> than any non-broken system would ever get to, just to safeguard against
> getting stuck in the ISR.

From v4.9 until v4.18 we already had a loop which did what you're
trying to achieve here.  It was added by commit fad214b0aa72
("PCI: pciehp: Process all hotplug events before looking for new ones").

v4.9 is an LTS stable kernel, it's being used a lot and noone ever
complained about the ISR getting stuck.  So it seems safe to me to
drop the limit of six.  It can be added later if issues do get
reported.

I'm sorry that I dropped the loop when refactoring the code for v4.19.
The commit message made it seem that the loop was necessary because we
might otherwise miss events.  However my refactoring made the code *cope*
with missed events, so the loop seemed unnecessary.  I didn't realize
that the loop is also necessary to avoid missing *interrupts* in the
MSI case.

Thanks,

Lukas

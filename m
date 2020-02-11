Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127751599CA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 20:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgBKTbh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 14:31:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgBKTbg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Feb 2020 14:31:36 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4DB120708;
        Tue, 11 Feb 2020 19:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581449496;
        bh=r7k/XMqw3qY2ty8pnv4vptYRuDKiNSxERWglxSVb+RU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i/iFTTtAtW7jaP7DtT7TPE82Dal8u5Lwr/KfVJcxzdq4932X4z1POjZk63pSp9os2
         uQq814+X0GnMHoZtR7xB2mimHftCb3PlprWlt+RpiE/x5O7cqf9vHLKZ6dWJbTu8NG
         DZyRvOUoPBNWeydeovDHf49HRrfZN+J+V+uio9sY=
Date:   Tue, 11 Feb 2020 13:31:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Libor Pechacek <lpechacek@suse.cz>
Subject: Re: [PATCH v4 0/3] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Message-ID: <20200211193132.GA228644@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211143202.2sgryye4m234pymq@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 11, 2020 at 03:32:02PM +0100, Lukas Wunner wrote:
> On Tue, Feb 11, 2020 at 08:14:44AM -0600, Bjorn Helgaas wrote:
> > I'm a little confused about why pci_hp_initialize()/
> > __pci_hp_initialize()/pci_hp_register()/__pci_hp_register() is such a
> > rat's nest with hotplug drivers using a mix of them.
> 
> This is modeled after device registration, which can be done either
> in two steps (device_initialize() + device_add()) or in 1 step
> (device_register()).
> 
> So it's either pci_hp_initialize() + pci_hp_add() or pci_hp_register().
> 
> The rationale is provided in the commit message of 51bbf9bee34f
> ("PCI: hotplug: Demidlayer registration with the core").

Thanks for the pointer.  I wrote that down in case I ever try to
figure that out in the future.  Obviously I haven't looked at this in
any detail, but it seems like the sort of thing that all the hotplug
drivers should do the same way regardless of their internal structure,
and the slot concept seems pretty integral to the bridge leading to
it.  Maybe this is a somehow a consequence of the hotplug drivers
being separated from the enumeration path.  Or maybe the slot part
could be split out from the hotplug drivers and done during
enumeration.  Just blue sky thinking, I don't pretend to have done
any actual research here.

Bjorn

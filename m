Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDFEE194DA
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 23:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEIVo6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 17:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfEIVo6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 17:44:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9FAF217D7;
        Thu,  9 May 2019 21:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557438298;
        bh=Kj740DwY+FRhrciLQQbonW6nNI9xuhneZMyp80mfXNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zoOl8LeaDLy5d/um9PqvzzIdTN6giV7zytwYeyMpsX+eS8pqY6X/Kl8DtKtzC8pzC
         Ms+60O1tixpxD83Hx8x1V8O1u2JYAv89OkWozp3OlOe5CWx9oao3EfdUAxpn32c2/A
         s2xTVRHP8R9VNqf2IpQqoQdhtxa240/W6VC7fhE0=
Date:   Thu, 9 May 2019 16:44:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/10] PCI/AER: Log messages with pci_dev, not pcie_device
Message-ID: <20190509214454.GE235064@google.com>
References: <20190509141456.223614-1-helgaas@kernel.org>
 <20190509141456.223614-5-helgaas@kernel.org>
 <CAHp75Vfk0gftuSMQBzZUgoeBPLeUOUkcdKJFbXKq3-joDgT0fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vfk0gftuSMQBzZUgoeBPLeUOUkcdKJFbXKq3-joDgT0fw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 09, 2019 at 08:42:10PM +0300, Andy Shevchenko wrote:
> On Thu, May 9, 2019 at 5:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Log messages with pci_dev, not pcie_device.  Factor out common message
> > prefixes with dev_fmt().
> >
> > Example output change:
> >
> >   - aer 0000:00:00.0:pci002: AER enabled with IRQ ...
> >   + pcieport 0000:00:00.0: AER: enabled with IRQ ...
> 
> > +               pci_err(port, "request AER IRQ %d failed\n",
> >                         dev->irq);
> 
> Possible to be on one line?

Yep, fixed this in a previous patch.

> > +                       pci_warn(edev->port,
> > +                                "AER service is not initialized\n");
> 
> checkpatch won't complain if it would be on one line.

Right, thanks, fixed this too.

Bjorn

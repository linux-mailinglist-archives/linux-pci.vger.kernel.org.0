Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B054270AD
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 20:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhJHS1X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 14:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhJHS1V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 14:27:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F108460F9D;
        Fri,  8 Oct 2021 18:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633717526;
        bh=iC/h3aiUcytVYRe2zTb8f9AgkuyTJM44W4jRd7yPuRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kh7q9Pwn462xjsy9yADINxXHInbs8u5TxCOXxd2q9go69YSoL2FvxKaurnG/JN2L9
         b9SY01g6Gmmi6ndy5Try/UGhFuDV6DHoQVIBEc0p5o93GVq5O0aOEnh34vXz2uySko
         OBp+b3oYoSbBSFEzzjM8EtkgbuDiBIdAwXFk0qfRCwe6dGhX93qP1yFNm4dKeI1Voh
         E4PnXRj7CPOHnH0DoHMU6UuFzb0TpPyP7u5Lm2/FmdcC8ZbWfKFC0ZnL3Ga6BwdS1H
         swMdwZ0MohdJEt4zbwEDpkPC2kG+TftoCzYAhLjqLs0J8ZzTJ0x62FWvFkgzDIcdYE
         QrmdDJqOgSH6Q==
Date:   Fri, 8 Oct 2021 13:25:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     kelvin.cao@microchip.com, kurt.schwemmer@microsemi.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kelvincao@outlook.com
Subject: Re: [PATCH 0/5] Switchtec Fixes and Improvements
Message-ID: <20211008182524.GA1361129@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e60010f3-f803-e60b-3412-346ccc11a0fb@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 08, 2021 at 11:23:46AM -0600, Logan Gunthorpe wrote:
> On 2021-10-08 11:05 a.m., Bjorn Helgaas wrote:
> > On Fri, Sep 24, 2021 at 11:08:37AM +0000, kelvin.cao@microchip.com wrote:
> >> From: Kelvin Cao <kelvin.cao@microchip.com>
> >>
> >> Hi,
> >>
> >> Please find a bunch of patches for the switchtec driver collected over the
> >> last few months.
> > 
> > Question: Is there a reason this driver should be in drivers/pci/?
> > 
> > It doesn't use any internal PCI core interfaces, e.g., it doesn't
> > include drivers/pci/pci.h, and AFAICT it's really just a driver for a
> > PCI device that happens to be a switch.
> > 
> > I don't really *care* that it's in drivers/pci; I rely on Kurt and
> > Logan to review changes.  The only problem it presents for me is that
> > I have to write merge commit logs for the changes.  You'd think that
> > would be trivial, but since I don't know much about the driver, it
> > does end up being work for me.
> 
> We did discuss this when it was originally merged.

Thanks, I thought I remembered talking about it, but didn't bother to
dig it up.

> The main reason we want it in the PCI tree is so that it's in a sensible
> spot in the Kconfig hierarchy (under PCI support). Seeing it is still
> PCI hardware. Dropping it into the miscellaneous devices mess (or
> similar) is less than desirable. Moreover, it's not like the maintainers
> for misc have any additional knowledge that would make them better
> qualified to merge these changes. In fact, I'm sure they'd have less
> knowledge and we wouldn't have gotten to the bottom of this last issue
> if it had been a different maintainer.
> 
> In the future I'll try to be more careful in my reviews to ensure we
> have a better understanding and clearer commit messages. If there's
> anything else we can do to make your job easier, please let us know.

Oh, please don't take this as me complaining about anybody's reviews!
I honestly just look for your or Kurt's ack.  I think I just need to
be a little less fixated on writing the merge commit logs :)

Bjorn

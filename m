Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB4318CBC
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 14:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhBKNxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 08:53:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232209AbhBKNvE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 08:51:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7001564DEE;
        Thu, 11 Feb 2021 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613051423;
        bh=nUEOcLqrzKg5CyO+vrW0EqVb8j+pGBzbBM0qhVT59gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oXbnJpK/xC69DxpJSGMG2EnE5vwukgTO5p3bBraiF+vC1eqLAsE3KXXHyzGpl08X3
         9RaybwRZlkO4g9maLZcNlzL4eSk0Q9/m2yyaNF2rRxwjZtxO2E5p/BgOvJ1WqtHP9f
         uPaViPkyVKFf6z5+71cwoEjAiDwism54/Ayh+Fhs4iEmr/Km3tLUofFEEwDJBO8LPN
         awxeafvXrOKwZ+KsmlwSR/BUMsEJ1kOZ263KqwN/1S3pYFPXCPtstF7NbcKOVOS1ig
         /gEXhjXjVLsBIIKa1khJ6xoyd3SJ7SzVfPGjS2sxgKyMj9xKrIYoHAUmtq5vUS9vBl
         9ZeJHc0nJyy7Q==
Date:   Thu, 11 Feb 2021 15:50:19 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 1/6] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <20210211135019.GI1275163@unreal>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <02835da8fc8c9293fecbe666a8db3fb79276fdde.1613034397.git.gustavo.pimentel@synopsys.com>
 <20210211114243.GH1275163@unreal>
 <YCUjzeR1ZMX2uVH7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCUjzeR1ZMX2uVH7@kroah.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 01:32:13PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 11, 2021 at 01:42:43PM +0200, Leon Romanovsky wrote:
> > On Thu, Feb 11, 2021 at 10:08:38AM +0100, Gustavo Pimentel wrote:
> > > Add Synopsys DesignWare xData IP driver. This driver enables/disables
> > > the PCI traffic generator module pertain to the Synopsys DesignWare
> > > prototype.
> > >
> > > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > ---
> > >  drivers/misc/dw-xdata-pcie.c | 394 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 394 insertions(+)
> > >  create mode 100644 drivers/misc/dw-xdata-pcie.c
> >
> > <...>
> >
> > > +MODULE_LICENSE("GPL v2");
> >
> > "GPL" and not "GPL v2".
>
> There is no difference, please go read module.h.

I read and this is why I said it.
Documentation/process/license-rules.rst: "It exists for historic reasons."

Historic, for me, means that new code is better do not use this.

Thanks

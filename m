Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A322444E1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 08:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgHNGLJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 02:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgHNGLI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Aug 2020 02:11:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73B0B20708;
        Fri, 14 Aug 2020 06:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597385468;
        bh=sXqxn17Ji4agz3DcSXOOpYy8haJnA9Hug1dQgMfh6LA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fjkvJBkNFtRmFsrkuQO3mQq9UPvk/L+JCX3yfli0s3CgT/bnDh+LDirmFLmjNxLBk
         4myKFL0kMUEsAvSY7GF/d7xVQy9P8IjZKuSfS2CwEsSs2qMMi6Z94COImcbBbttqBu
         llok/yhehuEZmnKBjdiAuUdk8J3ehd3s5APM7W0Q=
Date:   Fri, 14 Aug 2020 08:11:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, robh@kernel.org,
        wahrenst@gmx.net, p.zabel@pengutronix.de,
        andy.shevchenko@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        mathias.nyman@linux.intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v5 0/9] Raspberry Pi 4 USB firmware initialization rework
Message-ID: <20200814061105.GG1409566@kroah.com>
References: <20200629161845.6021-1-nsaenzjulienne@suse.de>
 <a6aecb7a4d270cb23430d25850c85a332555af55.camel@suse.de>
 <01e4b87c-d287-fd72-9f9c-545539127a50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e4b87c-d287-fd72-9f9c-545539127a50@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 13, 2020 at 12:17:49PM -0700, Florian Fainelli wrote:
> 
> 
> On 8/13/2020 3:01 AM, Nicolas Saenz Julienne wrote:
> > Hi everyone.
> > 
> > On Mon, 2020-06-29 at 18:18 +0200, Nicolas Saenz Julienne wrote:
> > > On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> > > loaded directly from an EEPROM or, if not present, by the SoC's
> > > co-processor, VideoCore. This series reworks how we handle this.
> > > 
> > > The previous solution makes use of PCI quirks and exporting platform
> > > specific functions. Albeit functional it feels pretty shoehorned. This
> > > proposes an alternative way of handling the triggering of the xHCI chip
> > > initialization trough means of a reset controller.
> > > 
> > > The benefits are pretty evident: less platform churn in core xHCI code,
> > > and no explicit device dependency management in pcie-brcmstb.
> > > 
> > > Note that patch #1 depends on another series[1], that was just applied
> > > into the clk maintainer's tree.
> > > 
> > > The series is based on v5.8-rc3
> > > 
> > > v3: https://www.spinics.net/lists/arm-kernel/msg813612.html
> > > v2: https://lkml.org/lkml/2020/6/9/875
> > > v1: https://lore.kernel.org/linux-usb/20200608192701.18355-1-nsaenzjulienne@suse.de/T/#t
> > > 
> > > [1] https://lore.kernel.org/linux-clk/159304773261.62212.983376627029743900@swboyd.mtv.corp.google.com/T/#t
> > > 
> > > ---
> > 
> > We were waiting on a dependency to be merged upstream to get this. They are now
> > in, so could we move things forward?
> > 
> > I can take the device tree patches, I guess philipp can take the reset
> > controller code. But I'm not so sure who should be taking the PCI/USB
> > counterparts.
> 
> Should we route everything through the USB tree since that is where the
> changes that do require synchronization with other subsystems and DTS is
> needed the most?
> -- 
> Florian

That's fine with me, if everyone else is ok with it :)

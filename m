Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF32E248379
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 13:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHRLDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 07:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgHRLDX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Aug 2020 07:03:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B109C2067C;
        Tue, 18 Aug 2020 11:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597748602;
        bh=aM76h0LVRWD/VLaNlIvaLamCRS32rZ9tXaBBf7SqjKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xz+KBqCsqtyyNaFLl9EC9cWvB075M+HVY4v7aNwfI6vFva6s2DbNBy3ym7dpepa/G
         ODNgxQ8gjopHuSd1fg0KlxpT1DTBAl5NUYCcNKBK4VRJBV73kd6osQAXp161bnqMrQ
         F66WXUNy9iNq54bXz8NiYpLKpBYgjX8be+T77SVM=
Date:   Tue, 18 Aug 2020 13:03:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, robh@kernel.org,
        wahrenst@gmx.net, p.zabel@pengutronix.de,
        andy.shevchenko@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        mathias.nyman@linux.intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v5 0/9] Raspberry Pi 4 USB firmware initialization rework
Message-ID: <20200818110332.GA167428@kroah.com>
References: <20200629161845.6021-1-nsaenzjulienne@suse.de>
 <a6aecb7a4d270cb23430d25850c85a332555af55.camel@suse.de>
 <01e4b87c-d287-fd72-9f9c-545539127a50@gmail.com>
 <20200814061105.GG1409566@kroah.com>
 <21baf85fa476f62a56895d77fa76dc0d73c1b3a0.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21baf85fa476f62a56895d77fa76dc0d73c1b3a0.camel@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 14, 2020 at 12:04:05PM +0200, Nicolas Saenz Julienne wrote:
> On Fri, 2020-08-14 at 08:11 +0200, Greg KH wrote:
> > On Thu, Aug 13, 2020 at 12:17:49PM -0700, Florian Fainelli wrote:
> > > 
> > > On 8/13/2020 3:01 AM, Nicolas Saenz Julienne wrote:
> > > > Hi everyone.
> > > > 
> > > > On Mon, 2020-06-29 at 18:18 +0200, Nicolas Saenz Julienne wrote:
> > > > > On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> > > > > loaded directly from an EEPROM or, if not present, by the SoC's
> > > > > co-processor, VideoCore. This series reworks how we handle this.
> > > > > 
> > > > > The previous solution makes use of PCI quirks and exporting platform
> > > > > specific functions. Albeit functional it feels pretty shoehorned. This
> > > > > proposes an alternative way of handling the triggering of the xHCI chip
> > > > > initialization trough means of a reset controller.
> > > > > 
> > > > > The benefits are pretty evident: less platform churn in core xHCI code,
> > > > > and no explicit device dependency management in pcie-brcmstb.
> > > > > 
> > > > > Note that patch #1 depends on another series[1], that was just applied
> > > > > into the clk maintainer's tree.
> > > > > 
> > > > > The series is based on v5.8-rc3
> > > > > 
> > > > > v3: https://www.spinics.net/lists/arm-kernel/msg813612.html
> > > > > v2: https://lkml.org/lkml/2020/6/9/875
> > > > > v1: https://lore.kernel.org/linux-usb/20200608192701.18355-1-nsaenzjulienne@suse.de/T/#t
> > > > > 
> > > > > [1] https://lore.kernel.org/linux-clk/159304773261.62212.983376627029743900@swboyd.mtv.corp.google.com/T/#t
> > > > > 
> > > > > ---
> > > > 
> > > > We were waiting on a dependency to be merged upstream to get this. They are now
> > > > in, so could we move things forward?
> > > > 
> > > > I can take the device tree patches, I guess philipp can take the reset
> > > > controller code. But I'm not so sure who should be taking the PCI/USB
> > > > counterparts.
> > > 
> > > Should we route everything through the USB tree since that is where the
> > > changes that do require synchronization with other subsystems and DTS is
> > > needed the most?
> > > -- 
> > > Florian
> > 
> > That's fine with me, if everyone else is ok with it :)
> 
> Sounds good to me.

All now queued up, thanks for sticking with this!

greg k-h

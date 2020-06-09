Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848191F3A48
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 14:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgFIMAW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 9 Jun 2020 08:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgFIMAV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 08:00:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D3DC03E97C
        for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2020 05:00:20 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jicvD-0006J2-Ev; Tue, 09 Jun 2020 14:00:03 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jicv9-00033i-Mm; Tue, 09 Jun 2020 13:59:59 +0200
Message-ID: <73fdeca7b651252f7907635e97f9f9b31e702868.camel@pengutronix.de>
Subject: Re: [PATCH 5/9] usb: xhci-pci: Add support for reset controllers
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        gregkh@linuxfoundation.org, wahrenst@gmx.net, robh@kernel.org,
        mathias.nyman@linux.intel.com, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     lorenzo.pieralisi@arm.com, tim.gover@raspberrypi.org,
        helgaas@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 13:59:59 +0200
In-Reply-To: <382b81937757de570a83ba4ff9276221c0bba547.camel@suse.de>
References: <20200608192701.18355-1-nsaenzjulienne@suse.de>
         <20200608192701.18355-6-nsaenzjulienne@suse.de>
         <5d3200cc-17cc-026f-1dfe-c10ec949f9ad@gmail.com>
         <382b81937757de570a83ba4ff9276221c0bba547.camel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nicolas,

On Tue, 2020-06-09 at 13:18 +0200, Nicolas Saenz Julienne wrote:
> Hi Florian, thanks for the reviews!
> 
> On Mon, 2020-06-08 at 12:43 -0700, Florian Fainelli wrote:
> > On 6/8/2020 12:26 PM, Nicolas Saenz Julienne wrote:
> > > Some atypical users of xhci-pci might need to manually reset their xHCI
> > > controller before starting the HCD setup. Check if a reset controller
> > > device is available to the PCI bus and trigger a reset.
> > > 
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > ---
> > >  drivers/usb/host/xhci-pci.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > > index ef513c2fb843..45f70facdfcd 100644
> > > --- a/drivers/usb/host/xhci-pci.c
> > > +++ b/drivers/usb/host/xhci-pci.c
[...]
> > > @@ -347,6 +349,13 @@ static int xhci_pci_probe(struct pci_dev *dev, const
> > > struct pci_device_id *id)
> > >  			return retval;
> > >  	}
> > >  
> > > +	reset = devm_reset_control_get(&dev->bus->dev, NULL);
> > 
> > Should not this be devm_reset_control_get_optional()?
> 
> Yes, you're right.

Please use devm_reset_control_get_optional_exclusive() while you're at
it.

regards
Philipp

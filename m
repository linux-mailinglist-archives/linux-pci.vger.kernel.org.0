Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD6D2FA06F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 13:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404215AbhARMlF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 07:41:05 -0500
Received: from foss.arm.com ([217.140.110.172]:34910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404179AbhARMk7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jan 2021 07:40:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59A0A31B;
        Mon, 18 Jan 2021 04:40:10 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D7FD3F719;
        Mon, 18 Jan 2021 04:40:09 -0800 (PST)
Date:   Mon, 18 Jan 2021 12:40:03 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Phil Elwell <phil@raspberrypi.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: brcmstb: Restore initial fundamental reset
Message-ID: <20210118124003.GA12967@e121166-lin.cambridge.arm.com>
References: <20201112172709.1817-1-phil@raspberrypi.com>
 <CA+-6iNwH3v78QhQOFpsXfA4hgUo9TXJaF4hy_imA60iQ2a3bMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNwH3v78QhQOFpsXfA4hgUo9TXJaF4hy_imA60iQ2a3bMg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 12, 2020 at 01:38:13PM -0500, Jim Quinlan wrote:
> On Thu, Nov 12, 2020 at 12:27 PM Phil Elwell <phil@raspberrypi.com> wrote:
> >
> > Commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
> > replaced a single reset function with a pointer to one of two
> > implementations, but also removed the call asserting the reset
> > at the start of brcm_pcie_setup. Doing so breaks Raspberry Pis with
> > VL805 XHCI controllers lacking dedicated SPI EEPROMs, which have been
> > used for USB booting but then need to be reset so that the kernel
> > can reconfigure them. The lack of a reset causes the firmware's loading
> > of the EEPROM image to RAM to fail, breaking USB for the kernel.
> >
> > Fixes: commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
> >
> > Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> > Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> > Changes in v2:
> >   - Exclude BCM7278 from the initial reset
> >   - Ack from Nicolas
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index bea86899bd5d..83aa85bfe8e3 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -869,6 +869,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >
> >         /* Reset the bridge */
> >         pcie->bridge_sw_init_set(pcie, 1);
> > +
> > +       /* Assert the fundemental reset, except on BCM7278 */
> > +       if (pcie->type != BCM7278)
> > +               pcie->perst_set(pcie, 1);
> I'm okay with this although I  would rather it not be needed.

Can I merge this patch as is then ?

Thanks,
Lorenzo

> Regards,
> Jim
> > +
> >         usleep_range(100, 200);
> >
> >         /* Take the bridge out of reset */
> > --
> > 2.25.1
> >



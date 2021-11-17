Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC55454E8A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 21:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhKQUcD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 15:32:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230461AbhKQUcB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 15:32:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E12726101C;
        Wed, 17 Nov 2021 20:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637180942;
        bh=E7Xqx7+Vg8jNNUkoeKrmpbXyXZbGKa01vFND7BArLlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IhSHNeA2YN0FvdEVHehRjIvHU6XVmRc5K0M8q4V1PtI1cNigkxf5CnzKPV8z66amU
         zu9KjXxwSiWnJwvr9Zu/NCReh/eN/rovh4aymEMTopxBZp9H7/DZFtiUHjf191AjdB
         aDbQiFZ43+Xyo/jyKc+gN8J71D/L/eCpjCBSXwW+7tjr9idecMfs0re61teRhMMlfD
         eD29mMM6461M6c5Ox4XnMcflMMoONd0PjGaX44Q+q/e+yX+8zcAum977wTB8jKhDqK
         C1iDw/Sg8Mynmh5KGv/Z9VpIG1FYl4n1ditx8dLjcsjxNokhZjXGcQs595u89KhLaw
         MZWvHqQSP96+Q==
Received: by pali.im (Postfix)
        id 6DDC145C; Wed, 17 Nov 2021 21:28:59 +0100 (CET)
Date:   Wed, 17 Nov 2021 21:28:59 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        kernel-team@android.com, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: apple: Reset the port for 100ms on probe
Message-ID: <20211117202859.2m5sqwz6xsjgldji@pali>
References: <20211117160053.232158-1-maz@kernel.org>
 <20211117201245.GA1768803@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117201245.GA1768803@bhelgaas>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Wednesday 17 November 2021 14:12:45 Bjorn Helgaas wrote:
> [+cc Pali]
> 
> On Wed, Nov 17, 2021 at 04:00:53PM +0000, Marc Zyngier wrote:
> > While the Apple PCIe driver works correctly when directly booted
> > from the firmware, it fails to initialise when the kernel is booted
> > from a bootloader using PCIe such as u-boot.
> > 
> > That's beacuse we're missing a proper reset of the port (we only
> > clear the reset, but never assert it).
> 
> s/beacuse/because/
> 
> > Bring the port back to life by wiggling the #PERST pin for 100ms
> > (as per the spec).
> 
> I cc'd Pali because I think he's interested in consolidating or
> somehow rationalizing delays like this.
> 
> If we have a specific spec reference here, I think it would help that
> effort.  I *think* it's PCIe r5.0, sec 6.6.1, which mentions the 100ms
> along with some additional constraints, like waiting 100ms after Link
> training completes for ports that support > 5.0 GT/s, whether
> Readiness Notifications are used, and CRS Software Visiblity.

This is not 100ms timeout "after link training completes".

Timeout in this patch is between flipping PERST# signal, so timeout
means how long needs to be endpoint card in reset state. And this
timeout cannot be controller specific. In past I have tried to find this
timeout in specifications, I was not able. Some summary is in my email:
https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/

So I would like to know, why was chosen 100ms for msleep() in this
patch?

> > Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/controller/pcie-apple.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> > index 1bf4d75b61be..bbea5f6e0a68 100644
> > --- a/drivers/pci/controller/pcie-apple.c
> > +++ b/drivers/pci/controller/pcie-apple.c
> > @@ -543,6 +543,9 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	/* Hold #PERST for 100ms as per the spec */
> > +	gpiod_set_value(reset, 0);
> > +	msleep(100);
> >  	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
> >  	gpiod_set_value(reset, 1);
> >  
> > -- 
> > 2.30.2
> > 

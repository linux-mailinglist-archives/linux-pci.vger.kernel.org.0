Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580B9455890
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 11:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245500AbhKRKHW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 18 Nov 2021 05:07:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245645AbhKRKFe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Nov 2021 05:05:34 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4EAA61B3A;
        Thu, 18 Nov 2021 10:02:33 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mneEw-006HaY-Ss; Thu, 18 Nov 2021 10:02:31 +0000
Date:   Thu, 18 Nov 2021 10:01:58 +0000
Message-ID: <87o86h7pex.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        kernel-team@android.com, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: apple: Reset the port for 100ms on probe
In-Reply-To: <20211117202859.2m5sqwz6xsjgldji@pali>
References: <20211117160053.232158-1-maz@kernel.org>
        <20211117201245.GA1768803@bhelgaas>
        <20211117202859.2m5sqwz6xsjgldji@pali>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: pali@kernel.org, helgaas@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, kernel-team@android.com, alyssa@rosenzweig.io, lorenzo.pieralisi@arm.com, bhelgaas@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 17 Nov 2021 20:28:59 +0000,
Pali Rohár <pali@kernel.org> wrote:
> 
> Hello!
> 
> On Wednesday 17 November 2021 14:12:45 Bjorn Helgaas wrote:
> > [+cc Pali]
> > 
> > On Wed, Nov 17, 2021 at 04:00:53PM +0000, Marc Zyngier wrote:
> > > While the Apple PCIe driver works correctly when directly booted
> > > from the firmware, it fails to initialise when the kernel is booted
> > > from a bootloader using PCIe such as u-boot.
> > > 
> > > That's beacuse we're missing a proper reset of the port (we only
> > > clear the reset, but never assert it).
> > 
> > s/beacuse/because/
> > 
> > > Bring the port back to life by wiggling the #PERST pin for 100ms
> > > (as per the spec).
> > 
> > I cc'd Pali because I think he's interested in consolidating or
> > somehow rationalizing delays like this.
> > 
> > If we have a specific spec reference here, I think it would help that
> > effort.  I *think* it's PCIe r5.0, sec 6.6.1, which mentions the 100ms
> > along with some additional constraints, like waiting 100ms after Link
> > training completes for ports that support > 5.0 GT/s, whether
> > Readiness Notifications are used, and CRS Software Visiblity.
> 
> This is not 100ms timeout "after link training completes".
> 
> Timeout in this patch is between flipping PERST# signal, so timeout
> means how long needs to be endpoint card in reset state. And this
> timeout cannot be controller specific. In past I have tried to find this
> timeout in specifications, I was not able. Some summary is in my email:
> https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
> 
> So I would like to know, why was chosen 100ms for msleep() in this
> patch?

Excellent question. I went back to my notes (and the spec), and it
looks like I have mistakenly conflated *two* delays here:

- The post-#PERST delay, which is 100ms, and which is *not* what this
  patch is doing while it really should be doing it. This is
  documented in the base PCIe spec (in Rev 2.0, this is part of
  6.6.1). The amusing part is that on this HW, it seems that only the
  delay from the falling edge matters (which is why I didn't spot the
  issue).

- The duration of the power-on #PERST assertion (Tpvperl), which is
  also 100ms, and documented in the PCIe Card Electromechanical
  Specification (Rev 1.0a, 2.2 and 2.2.1).

There is also a third delay (Tperst-clk) which represents the time
required for the clock to ramp up before releasing #PERST. No, there
is no value associated with this.

Having come to my senses, and with these constraints in mind, this is
what I currently have in my tree:

	/* Engage #PERST */
	gpiod_set_value(reset, 0);

	ret = apple_pcie_setup_refclk(pcie, port);
	if (ret < 0)
		return ret;

	/* Hold #PERST for 100ms as per the electromechanical spec */
	msleep(100);
	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
	gpiod_set_value(reset, 1);
	/* Wait for 100ms after #PERST deassertion before anothing else */
	msleep(100);

Yes, this is totally overkill, as I assume that each port has gone
through a complete power-off and is only slowly coming back from the
dead.

In practice, I can completely remove the initial Tpvperl delay (we
have been powered-on for a long time already, and the clock is stable
when we come back from setting it up), and cut the second one by half
without observing any ill effect (though I feel safer keeping it to
its nominal value).

If nobody screams, I'll respin something shortly.

	M.

-- 
Without deviation from the norm, progress is not possible.

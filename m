Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB6621B9C4
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 17:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGJPpC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 11:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgGJPpB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 11:45:01 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C39A9207BB;
        Fri, 10 Jul 2020 15:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594395900;
        bh=aZgrSQGTi/bQbYJefPXIilrLr45TJZVsRzp7BllPX7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ch7jbZ/QZp6L1XHiRFzuIY/1k/SJDSCGA6fhAI4zb+wgUdVtpwHhSo/Yo3S7s0JT5
         zTzNmvXIpR2XUQJlg07dtnhDpdYPxpz23diAvmQbfAUNpq+0SGka5LcqyEXj9VRbUX
         2GoGYb3ZT30G4dOASxK104ejlEBdLB2vpKjlThRA=
Received: by pali.im (Postfix)
        id 882DA1514; Fri, 10 Jul 2020 17:44:58 +0200 (CEST)
Date:   Fri, 10 Jul 2020 17:44:58 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Don't touch PCIe registers if no card
 connected
Message-ID: <20200710154458.bntk7cgewvxmubf4@pali>
References: <20200528143141.29956-1-pali@kernel.org>
 <20200702083036.12230-1-pali@kernel.org>
 <20200709113509.GB19638@e121166-lin.cambridge.arm.com>
 <20200709122208.rmfeuu6zgbwh3fr5@pali>
 <20200709144701.GA21760@e121166-lin.cambridge.arm.com>
 <20200709150959.wq6zfkcy4m6hvvpl@pali>
 <20200710091800.GA3419@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710091800.GA3419@e121166-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 10 July 2020 10:18:00 Lorenzo Pieralisi wrote:
> I would be very grateful if you could describe what happens in HW
> when these conditions trigger - I would like to understand if this
> issue is aardvark specific or it isn't.

Hello Lorenzo! We are not sure what is the problem and where it happens.

There are more issues which happens randomly or under some specific
conditions.

I can reproduce following issue: Connect Compex WLE900VX card, configure
aardvark to gen2 mode. And then card is detected only after the first
link training. If kernel tries to retrain link again (e.g. via ASPM
code) then card is not detected anymore. To detect it again it is needed
to reset card via PERST# signal (assert PERST#, wait, de-assert PERST#).
PCI warm, hot or function reset does not help. When aardvark is
configured in gen1 mode then card is detected fine also after multiple
link training.

Above problem does not happen with Compex WLE200VX (ath9k) or Compex
WLE1216V5-20 cards.

Sometimes WLE900VX card disappear from the bus during usage. It just
stop communicates with ath10k driver and aardvark does not see link.

Another issue which happens for WLE900VX, WLE600VX and WLE1216VS-20 (but
not for WLE200VX): Linux kernel can detect these cards only if it issues
card reset via PERST# signal and start link training (via standard pcie
endpoint register PCI_EXP_LNKCTL/PCI_EXP_LNKCTL_RL) immediately after
enable link training in aardvark (via aardvark specific LINK_TRAINING_EN
bit). If there is e.g. 100ms delay between enabling link training and
setting PCI_EXP_LNKCTL_RL bit then these cards are not detected.

Also issuing reset via PERST# signal is required to detect these cards
if either board was rebooted (not started from cold power off state) or
if U-Boot touched/initialized PCIe aardvark.

WLE200VX works fine also after doing second or third link training and
also works without need to issue reset via PERST# signal.

And WLE900VX card is not detected even after resetting it via PERST#
signal if aardvark link training (LINK_TRAINING_EN bit) was enabled
prior toggling PERST#. PERST# signal is controlled via GPIO.

When I put WLE900VX card into board with uses mvebu PCI driver (not
aardvak) then card is working fine, there is no need to issue card reset
via PERST#, no need to explicitly set gen mode and card is also working
after more link training.

So basically I have no idea why it happens or where is the problem,
either in aardvark or in cards or on both places. As you can see each of
tested card has different set problems.

Today I tested card from different vendor but with same Qualcomm chip as
is in WLE900VX and I observe same behavior as from Compex WLE900VX. So
it looks like that card vendor does not have to matter, important is
wifi chip inside.

I read in kernel bugzilla that WLE600VX and WLE900VX cards are buggy and
more people have problems with them. But issues described in kernel
bugzilla (like card is reporting incorrect PCI device id) I'm not
observing.

If you have any idea how to either debug these problems or come up with
idea where could be the problem, please let me know.

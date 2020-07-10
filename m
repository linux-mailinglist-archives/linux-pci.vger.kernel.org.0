Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351FA21BDA5
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 21:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGJTaH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 15:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgGJTaH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 15:30:07 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 637F72076A;
        Fri, 10 Jul 2020 19:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594409406;
        bh=HKUsObJTxAzGIdEMpdjrd4x7q3Pjx/3zWOsbyKi8J8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4lsMVUp03tGaCM4yusSTbgfcwdNY0Vg1sMxofe1XOXmiemJxVvz40mZTTs1U2y65
         +zn9BzjIgGMIGogaR4VxJVPj5Im+hbb95iECFrVENJHa5RO0Umio8o5mW7fJSzS/yv
         +KA5KmHrdV96d3kzJdUIUpj2irSPpLGB7Q7mBbbc=
Received: by pali.im (Postfix)
        id 2019A1514; Fri, 10 Jul 2020 21:30:04 +0200 (CEST)
Date:   Fri, 10 Jul 2020 21:30:03 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Don't touch PCIe registers if no card
 connected
Message-ID: <20200710193003.2lt3i5ocy5kk3b3p@pali>
References: <20200710154458.bntk7cgewvxmubf4@pali>
 <20200710160828.GA63389@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200710160828.GA63389@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 10 July 2020 11:08:28 Bjorn Helgaas wrote:
> On Fri, Jul 10, 2020 at 05:44:58PM +0200, Pali Rohár wrote:
> > I can reproduce following issue: Connect Compex WLE900VX card, configure
> > aardvark to gen2 mode. And then card is detected only after the first
> > link training. If kernel tries to retrain link again (e.g. via ASPM
> > code) then card is not detected anymore. 
> 
> Somebody should go over the ASPM retrain link code and the PCIe spec
> with a fine-toothed comb.  Maybe we're doing something wrong there.

I think this is not ASPM related as card simply disappear just after
flipping PCI_EXP_LNKCTL_RL bit second time without changing ASPM bits.

> Or maybe aardvark has some hardware issue and we need some sort of
> quirk to work around it.

It is possible that this is aardvark issue. As I said I really do not
know.

In aardvark driver there is already merged workaround for this issue:
driver force gen1 aardvark mode for gen1 card.

> > Another issue which happens for WLE900VX, WLE600VX and WLE1216VS-20 (but
> > not for WLE200VX): Linux kernel can detect these cards only if it issues
> > card reset via PERST# signal and start link training (via standard pcie
> > endpoint register PCI_EXP_LNKCTL/PCI_EXP_LNKCTL_RL)
> 
> I think you mean "downstream port" (not "endpoint") register?

Yes.

> PCI_EXP_LNKCTL_RL is only applicable to *downstream ports* (root ports
> or switch downstream ports) and is reserved for endpoints.
> 
> > immediately after
> > enable link training in aardvark (via aardvark specific LINK_TRAINING_EN
> > bit). If there is e.g. 100ms delay between enabling link training and
> > setting PCI_EXP_LNKCTL_RL bit then these cards are not detected.
> 
> This sounds problematic.  Hardware should not be dependent on the
> software being "fast enough".  In general we should be able to insert
> arbitrary delays at any point without breaking anything.

Yes, it is problematic. For example following commit broke those cards:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f4c7d053d7f77cd5c1a1ba7c7ce085ddba13d1d7

And this commit fixed it (just msleep was moved to different stage):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6964494582f56a3882c2c53b0edbfe99eb32b2e1

But we somehow need to deal with it until we find root cause.

Basically additional sleep in aardvark init phase can break WLE900VX
cards, but not WLE200VX.

And because WLE900VX works fine with pci-mvebu and WLE200VX works fine
with pci-aardvark we cannot deduce from it if problem for combination of
WLE900VX and aardvark is in WLE900VX or in aardvark.

> But I have the impression that aardvark requires more software
> hand-holding that most hardware does.  If it imposes timing
> requirements on the software, that *should* be documented in the
> aardvark spec.

There is absolutely nothing regarding to timings in documentation which
I saw. In documentation are just instructions/steps how to init PCI
subsystem and it is basically advk_pcie_setup_hw() function.

> > I read in kernel bugzilla that WLE600VX and WLE900VX cards are buggy and
> > more people have problems with them. But issues described in kernel
> > bugzilla (like card is reporting incorrect PCI device id) I'm not
> > observing.
> 
> Pointer?

Hm... I cannot find right now pointer to bugzilla, but I have pointer to
ath9k-devel mailing list with that incorrect device id:

https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html

> Is the incorrect device ID 0xffff?

No, incorrect device ID in that case is 0xabcd and vendor ID is correct
(Qualcomm).

> That could be a symptom
> of a PCIe error.  If we read a device ID that's something other than
> 0, 0xffff, or the correct ID, that would be really weird.  Even 0
> would be really strange.

It is strange and also reason why discussion on that list is long.

As I said, I'm not seeing that problem with wrong device ID.

But I know people who are observing same problem on different boards
(which do not use aardvark) as described in above mailing list thread
with Compex ath10k cards.

> I suspect these wifi cards are a little special because they probably
> play unusual games with power for airplane mode and the like.

This is another/different problem and is already "documented" in kernel
bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=84821#c52

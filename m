Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EAB21BE50
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 22:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGJUIG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 16:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgGJUIG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 16:08:06 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BA8F2076A;
        Fri, 10 Jul 2020 20:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594411685;
        bh=qAHikyX4usyEt9YaUhLVPyfSr7erjUkLzDKfxsW/idw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F8UkNMPQ+9Y3843RBYkKHxced1/m2Ia4VnGs/51Qytls9UeYESnXzd8CoE8FrMxCQ
         VqRlwy7unDqDctZU/HTaPqQLerVDBq+PJA7hyP8KyMtR6zUSnAYQTYL6/X36V1Iygu
         bhxnKMeKNvSwi9Z/NXYMfnRcyLTBMW/3ybjH4L68=
Date:   Fri, 10 Jul 2020 15:08:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Don't touch PCIe registers if no card
 connected
Message-ID: <20200710200803.GA75998@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200710193003.2lt3i5ocy5kk3b3p@pali>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 10, 2020 at 09:30:03PM +0200, Pali Rohár wrote:
> On Friday 10 July 2020 11:08:28 Bjorn Helgaas wrote:
> > On Fri, Jul 10, 2020 at 05:44:58PM +0200, Pali Rohár wrote:
> > > I can reproduce following issue: Connect Compex WLE900VX card, configure
> > > aardvark to gen2 mode. And then card is detected only after the first
> > > link training. If kernel tries to retrain link again (e.g. via ASPM
> > > code) then card is not detected anymore. 
> > 
> > Somebody should go over the ASPM retrain link code and the PCIe spec
> > with a fine-toothed comb.  Maybe we're doing something wrong there.
> 
> I think this is not ASPM related as card simply disappear just after
> flipping PCI_EXP_LNKCTL_RL bit second time without changing ASPM bits.

Right.  The retrain code in aspm.c doesn't really have anything in
particular to do with ASPM and it should probably be moved elsewhere.
So I think the problem may be related to retrain and the delays after
it in general, not to ASPM.

> There is absolutely nothing regarding to timings in documentation which
> I saw. In documentation are just instructions/steps how to init PCI
> subsystem and it is basically advk_pcie_setup_hw() function.
> 
> > > I read in kernel bugzilla that WLE600VX and WLE900VX cards are buggy and
> > > more people have problems with them. But issues described in kernel
> > > bugzilla (like card is reporting incorrect PCI device id) I'm not
> > > observing.
> 
> Hm... I cannot find right now pointer to bugzilla, but I have pointer to
> ath9k-devel mailing list with that incorrect device id:
> 
> https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html
> 
> > Is the incorrect device ID 0xffff?
> 
> No, incorrect device ID in that case is 0xabcd and vendor ID is correct
> (Qualcomm).

From a quick look at that thread, it sounds like the device isn't
quite ready yet.  In that case, it's supposed to respond with Config
Request Retry Status, and Linux is supposed to wait longer and retry.
But I don't think Linux does that quite correctly, so it could be
either a hardware problem or Linux being broken.  But I guess that's
not the current problem so I don't want to go down that rathole right
now.

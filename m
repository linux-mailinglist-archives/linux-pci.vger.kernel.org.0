Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A9F21BA57
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 18:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGJQIb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 12:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbgGJQIb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 12:08:31 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E2482078D;
        Fri, 10 Jul 2020 16:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594397310;
        bh=vC1vGxiGyID9V8iW+BxRHqjSMbf0Sz/SFWTTjr0xW9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O7T5JxThg2lij9AUFeH0M/ZWnvO3yBMFs5WxD4DWKoI9kx0z5XJcjj6Qfmd9G8txW
         XtNnbdLbjp/tNA5CnlRAPyoRB+eaD92YxtkJRTt50rajYNfoI6SI/vJrAVBXA2ICmH
         FKk5HwYebDBnR9I8ixaOPxym7PrdG3mIGJZtcgU8=
Date:   Fri, 10 Jul 2020 11:08:28 -0500
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
Message-ID: <20200710160828.GA63389@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200710154458.bntk7cgewvxmubf4@pali>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 10, 2020 at 05:44:58PM +0200, Pali Rohár wrote:
> I can reproduce following issue: Connect Compex WLE900VX card, configure
> aardvark to gen2 mode. And then card is detected only after the first
> link training. If kernel tries to retrain link again (e.g. via ASPM
> code) then card is not detected anymore. 

Somebody should go over the ASPM retrain link code and the PCIe spec
with a fine-toothed comb.  Maybe we're doing something wrong there.
Or maybe aardvark has some hardware issue and we need some sort of
quirk to work around it.

> Another issue which happens for WLE900VX, WLE600VX and WLE1216VS-20 (but
> not for WLE200VX): Linux kernel can detect these cards only if it issues
> card reset via PERST# signal and start link training (via standard pcie
> endpoint register PCI_EXP_LNKCTL/PCI_EXP_LNKCTL_RL)

I think you mean "downstream port" (not "endpoint") register?
PCI_EXP_LNKCTL_RL is only applicable to *downstream ports* (root ports
or switch downstream ports) and is reserved for endpoints.

> immediately after
> enable link training in aardvark (via aardvark specific LINK_TRAINING_EN
> bit). If there is e.g. 100ms delay between enabling link training and
> setting PCI_EXP_LNKCTL_RL bit then these cards are not detected.

This sounds problematic.  Hardware should not be dependent on the
software being "fast enough".  In general we should be able to insert
arbitrary delays at any point without breaking anything.

But I have the impression that aardvark requires more software
hand-holding that most hardware does.  If it imposes timing
requirements on the software, that *should* be documented in the
aardvark spec.

> I read in kernel bugzilla that WLE600VX and WLE900VX cards are buggy and
> more people have problems with them. But issues described in kernel
> bugzilla (like card is reporting incorrect PCI device id) I'm not
> observing.

Pointer?  Is the incorrect device ID 0xffff?  That could be a symptom
of a PCIe error.  If we read a device ID that's something other than
0, 0xffff, or the correct ID, that would be really weird.  Even 0
would be really strange.

I suspect these wifi cards are a little special because they probably
play unusual games with power for airplane mode and the like.

Bjorn

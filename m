Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF3943E6BD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 19:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhJ1RDR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 28 Oct 2021 13:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhJ1RDQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 13:03:16 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC31D61040;
        Thu, 28 Oct 2021 17:00:49 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mg8lj-002GLr-Ev; Thu, 28 Oct 2021 18:00:47 +0100
Date:   Thu, 28 Oct 2021 18:00:47 +0100
Message-ID: <87o8799j9c.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 10/14] PCI: aardvark: Enable MSI-X support
In-Reply-To: <20211028182514.65a94c8e@thinkpad>
References: <20211012164145.14126-1-kabel@kernel.org>
        <20211012164145.14126-11-kabel@kernel.org>
        <20211027141246.GA27543@lpieralisi>
        <20211027142307.lrrix5yfvroxl747@pali>
        <20211028110835.GA1846@lpieralisi>
        <20211028111302.gfd73ifoyudttpee@pali>
        <20211028113030.GA2026@lpieralisi>
        <20211028113724.gm6zhqt7qcyxtgkq@pali>
        <87r1c59nqf.wl-maz@kernel.org>
        <20211028175150.7faa6481@thinkpad>
        <20211028182514.65a94c8e@thinkpad>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kabel@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com, pali@kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 Oct 2021 17:25:14 +0100,
Marek Behún <kabel@kernel.org> wrote:
> 
> On Thu, 28 Oct 2021 17:51:50 +0200
> Marek Behún <kabel@kernel.org> wrote:
> 
> > Marc, we have ~70 patches ready for the aardvark controller driver.
> > 
> > It is patch 53 [1] that converts the old irq_find_mapping() +
> > generic_handle_irq() API to the new API, so it isn't that Pali did
> > not address your comments, it is that, due to convenience, he addressed
> > them in a later patch.
> > 
> > The last time Pali sent a larger number of paches (in a previous
> > version, which was 42 patches [1]), it was requested that we split the
> > series into smaller sets, so that it is easier to merge.
> > 
> > Since then some more changes accumulated, resulting in the current ~70
> > patches, which I have been sending in smaller batches.
> > 
> > I could rebase the entire thing so that the patch changing the usage of
> > the old irq_find_mapping() + generic_handle_irq() API is first. But
> > that would require rebasing and testing all the patches one by one,
> > since the patches in-between touch everything almost everything else.
> > 
> > If it is really that problematic to review the changes while they use
> > the old API, please let me know and I will rebase it. But if you could
> > find it in yourself to review the patches with old API usage, it would
> > really save a lot of time and the result will be the same, to your
> > satisfaction.
> 
> Lorenzo, Marc, Bjorn,
> 
> I have one more question.
> 
> Pali prepared the ~70 patches so that fixes come first, and
> new features / changes to new API later.
> 
> He did it in this way so that the patches could be then conventiently
> backported to stable versions - were we to first change the API usage
> to the new API, and then fix the ~20 IRQ related things, we would
> afterwards have to backport the fixes by rewriting them one by one.
> 
> Is this really how we should do this? Should we ignore stable while
> developing for master, regardless of how much other work would need to
> be spent by backporting to master, even if it could be much simpler by
> applying the patches in master in another order?

I already replied to that in August. Upstream is the primary
development target. If you want to backport patches, do them and make
the changes required so that they are correct for whatever kernel you
target. Stable doesn't matter to upstream at all.

	M.

-- 
Without deviation from the norm, progress is not possible.

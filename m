Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDE748CE0C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 22:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiALVzX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 16:55:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36214 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbiALVzX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 16:55:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDD8861A81
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 21:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD05C36AE9;
        Wed, 12 Jan 2022 21:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642024521;
        bh=bBtkV3sEFTsAWDR0FMFFMJNPzdkzZ3zm+ACM+/I24eY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dEC5/kVjFD5NCHJS3fCZfDpojZ1r9pDIPK3k7gvRumPX2Cqt3Cj0N7BlB9sORz5se
         gIvUj37XeJy/xzFZuolPJioVAoD4iwzHETn7wCeZJIWq3W3JwwBCT3GOxEDDAQy4Lo
         EswSMXziji+jkv7mYvk1UeWqOFIKRuvwyQ7ac+E5Qx43B05ShrcacQ1k5+Rb60IeM9
         tlwo6wnZzN1bTyxTiiXy7uSD/99MNCqgkqwhep3iPG7ZBIpteuwfQqTSaF3tzDcpnW
         lqbdWAg4M/ZQc61m8r0v01bnzY1RzawUkNsAVDDYPNPaBIJ5FEu/GKnFLKwnuPerWV
         ScazDeypOPuBw==
Date:   Wed, 12 Jan 2022 15:55:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jim Quinlan <jim2101024@gmail.com>, james.quinlan@broadcom.com,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] fixup! PCI: brcmstb: Add control of subdevice voltage
 regulators
Message-ID: <20220112215519.GA287022@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112215000.GA4972@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 10:50:00PM +0100, Lukas Wunner wrote:
> On Wed, Jan 12, 2022 at 06:00:11PM +0000, Lorenzo Pieralisi wrote:
> > On Wed, Jan 12, 2022 at 11:51:06AM -0600, Bjorn Helgaas wrote:
> > > On Tue, Jan 11, 2022 at 08:31:00PM -0500, Jim Quinlan wrote:
> > > What's this connected to?  Is this a fix for a patch that has already
> > > been merged?  If so, which one?  If it's a standalone thing, it needs
> > > a commit log and a Signed-off-by.  Actually, that would be good in any
> > > case.  Maybe a lore link to the relevant patch?
> > 
> > I was about to reply. It is a fixup for one of the branches I am
> > queueing for v5.17 (pci/brcmstb), I can either squash that it myself or
> > you can do it, provided that Jim gives us the commit id this is actually
> > fixing (or a lore link to the patch posting so that we can infer the
> > commit to fix).
> 
> If you apply the patch to the pci/host/brcmstb branch with "git am"
> as usual, then execute "git rebase --autosquash v5.16-rc1",
> git will automatically figure out the commit id this patch is fixing,
> fold it into the commit and rebase the remainder of the branch on top
> of it.

Wow!  That's ... amazing.  Or something :)

I already did it the old-fashioned way, but I'll try to remember this
trick for next time.

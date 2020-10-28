Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A68029DF56
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 02:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgJ2BAq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 21:00:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731538AbgJ1WR2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:28 -0400
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 269762479E;
        Wed, 28 Oct 2020 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603896131;
        bh=88+t9yPMavqyxiSvxf19GshamHH2dqzO8poEj1X9XPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aT30wqPKA4OSxY1Bj8lj189K3MYdwdNNUFFgTd2C9gsNTETdHl3x9ojJ3iT7Qaorf
         5FZhIKobgcpGFSX39s8JZFW6Uj7/29CkIC5/NN70iNn0+KjesjRYvj+9v8/+8QxLCA
         LuePCNK8FZxu60CcGsVA6wzhM6heDGnNLgTwHeUI=
Date:   Wed, 28 Oct 2020 09:42:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        vtolkm@googlemail.com
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201028144209.GA315566@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2jqmq0i.fsf@toke.dk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 28, 2020 at 02:36:13PM +0100, Toke Høiland-Jørgensen wrote:
> Toke Høiland-Jørgensen <toke@redhat.com> writes:
> 
> > Bjorn Helgaas <helgaas@kernel.org> writes:
> >
> >> [+cc vtolkm]
> >>
> >> On Tue, Oct 27, 2020 at 04:43:20PM +0100, Toke Høiland-Jørgensen wrote:
> >>> Hi everyone
> >>> 
> >>> I'm trying to get a mainline kernel to run on my Turris Omnia, and am
> >>> having some trouble getting the PCI bus to work correctly. Specifically,
> >>> I'm running a 5.10-rc1 kernel (torvalds/master as of this moment), with
> >>> the resource request fix[0] applied on top.
> >>> 
> >>> The kernel boots fine, and the patch in [0] makes the PCI devices show
> >>> up. But I'm still getting initialisation errors like these:
> >>> 
> >>> [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0xe0000004 != 0xffffffff)
> >>> [    1.632714] pci 0000:01:00.0: BAR 0: error updating (high 0x000000 != 0xffffffff)
> >>> [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0xe0200004 != 0xffffffff)
> >>> [    1.632750] pci 0000:02:00.0: BAR 0: error updating (high 0x000000 != 0xffffffff)
> >>> 
> >>> and the WiFi drivers fail to initialise with what appears to me to be
> >>> errors related to the bus rather than to the drivers themselves:
> >>> 
> >>> [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by this driver
> >>> [    3.517049] ath: phy0: Unable to initialize hardware; initialization status: -95
> >>> [    3.524473] ath9k 0000:01:00.0: Failed to initialize device
> >>> [    3.530081] ath9k: probe of 0000:01:00.0 failed with error -95
> >>> [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: failed with rc=134
> >>> [    3.543049] pci 0000:00:02.0: enabling device (0140 -> 0142)
> >>> [    3.548735] ath10k_pci 0000:02:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> >>> [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up device : -110
> >>> [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed with error -110
> >>> 
> >>> lspci looks OK, though:
> >>> 
> >>> # lspci
> >>> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
> >>> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
> >>> 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
> >>> 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) (rev 01)
> >>> 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter (rev ff)
> >>> 
> >>> Does anyone have any clue what could be going on here? Is this a bug, or
> >>> did I miss something in my config or other initialisation? I've tried
> >>> with both the stock u-boot distributed with the board, and with an
> >>> upstream u-boot from latest master; doesn't seem to make any different.
> >>
> >> Can you try turning off CONFIG_PCIEASPM?  We had a similar recent
> >> report at https://bugzilla.kernel.org/show_bug.cgi?id=209833 but I
> >> don't think we have a fix yet.
> >
> > Yes! Turning that off does indeed help! Thanks a bunch :)
> >
> > You mention that bisecting this would be helpful - I can try that
> > tomorrow; any idea when this was last working?
> 
> OK, so I tried to bisect this, but, erm, I couldn't find a working
> revision to start from? I went all the way back to 4.10 (which is the
> first version to include the device tree file for the Omnia), and even
> on that, the wireless cards were failing to initialise with ASPM
> enabled...

I have no personal experience with this device; all I know is that the
bugzilla suggests that it worked in v5.4, which isn't much help.

Possibly the apparent regression was really a .config change, i.e.,
CONFIG_PCIEASPM was disabled in the v5.4 kernel vtolkm@ tested and it
"worked" but got enabled later and it started failing?

Maybe the debug patch below would be worth trying to see if it makes
any difference?  If it *does* help, try omitting the first hunk to see
if we just need to apply the quirk_enable_clear_retrain_link() quirk.

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ac0557a305af..afe7fa1d54d6 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -103,7 +103,7 @@ static const char *policy_str[] = {
 	[POLICY_POWER_SUPERSAVE] = "powersupersave"
 };
 
-#define LINK_RETRAIN_TIMEOUT HZ
+#define LINK_RETRAIN_TIMEOUT (10*HZ)
 
 static int policy_to_aspm_state(struct pcie_link_state *link)
 {
@@ -201,7 +201,7 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
 	reg16 |= PCI_EXP_LNKCTL_RL;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
-	if (parent->clear_retrain_link) {
+	if (1 || parent->clear_retrain_link) {
 		/*
 		 * Due to an erratum in some devices the Retrain Link bit
 		 * needs to be cleared again manually to allow the link

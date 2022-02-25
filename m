Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DCC4C4648
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 14:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiBYN1i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 08:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiBYN1i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 08:27:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C003C7DA82
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 05:27:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C04861D41
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 13:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763E3C340E7;
        Fri, 25 Feb 2022 13:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645795624;
        bh=fgudwGgujN7n8+7ucdsczhITRgfgLcuRkLVC7d/cbfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzKfu4FggnUVOwagUMZOXaYaId+0HHTsByz0eugjad+0XfvLLb5gRxpGwUrffyQlM
         KSbV2mHddtcGTxmaZpQcj42a790hzRYxZ449NH48Z7T+wSXVA678plN3BVA7jpIBbO
         KdrAs4p/CWAdfBIc3SwIw8gnJI/2zX+RNQWUH39koAVd7wLAOapPosANfJI5tcGiAS
         Y7OHpVwYZlYVg29r9bg0lTHR8houOTWavYSsLPTMff/1ZAkL0FkBftn+9jkHyfHmzP
         WMbrqsDULgkto6URG8yC6aQTuQMSNIV+DMPWFtlu1L/s7r96Da6k7IaYslu8V8Nhvh
         6Ij+nVGcCUW7A==
Received: by pali.im (Postfix)
        id D0C757EF; Fri, 25 Feb 2022 14:27:01 +0100 (CET)
Date:   Fri, 25 Feb 2022 14:27:01 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marcel Menzel <mail@mcl.gg>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: Kernel 5.16.3 and above fails to detect PCIe devices on Turris
 Omnia (Armada 385 / mvebu)
Message-ID: <20220225132701.fzqbvynueho2res2@pali>
References: <d4dd76f4-19e4-c35a-bd46-6e014707402e@mcl.gg>
 <20220224162532.GA274119@bhelgaas>
 <20220224172136.ydx4wu7avmfq4ndt@pali>
 <3db2e80c-76aa-2f93-7be2-d2c34283289d@mcl.gg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3db2e80c-76aa-2f93-7be2-d2c34283289d@mcl.gg>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 25 February 2022 14:12:30 Marcel Menzel wrote:
> Am 24.02.2022 um 18:21 schrieb Pali Rohár:
> > On Thursday 24 February 2022 10:25:32 Bjorn Helgaas wrote:
> > > On Thu, Feb 24, 2022 at 05:00:30PM +0100, Marcel Menzel wrote:
> > > > +linux-pci
> > > > 
> > > > Am 24.02.2022 um 14:52 schrieb Marcel Menzel:
> > > > > Am 24.02.2022 um 14:09 schrieb Marcel Menzel:
> > > > > > Hello,
> > > > > > 
> > > > > > When upgrading from kernel 5.16.2 to a newer version (tried 5.16.3
> > > > > > and 5.16.10 with unchanged .config), the Kernel fails to detect both
> > > > > > my installed mPCIe WiFi cards in my Turris Omnia (newer version,
> > > > > > silver case, GPIO pins installed again).
> > > > > > I have two Mediatek MT7915 based cards installed. I also tried with
> > > > > > one Atheros at9k and one ath10k based card, yielding the same
> > > > > > result. On a Kernel version newer than 5.16.2, all cards aren't
> > > > > > getting recognized correctly.
> > > > > > 
> > > > > > Before 5.16.3 I also had to disable PCIe ASPM via boot aragument,
> > > > > > otherwise the WiFi drivers would complain about weird device
> > > > > > behaviors and failing to initialize them, but re-enabling it does
> > > > > > not yield any different results.
> > > Please try this commit, which is headed to mainline today:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=c49ae619905eebd3f54598a84e4cd2bd58ba8fe9
> > > 
> > > This commit should fix the PCI enumeration problem.
> > It should fix that regression. If not, please let me know.
> Can confirm this patch solving the issue. Many thanks!

Perfect!

> > > If you still have
> > > to disable ASPM, that sounds like a separate problem that we should
> > > also try to debug.
> > This is different and known issue and **not** related to ASPM. I spend
> > some time on it, initially I thought it is bug in Atheros cards, but now
> > I'm in impression that this is issue in Marvell PCIe HW that link
> > retraining (required step of ASPM) triggers either Link Down or Hot
> > Reset which triggers another Atheros issue (this one is already
> > documented in kernel pci quirks code).
> > 
> > I will try to implement some workaround for this but requirement is to
> > have all new improvements in pci-mvebu.c + pci-aardvark.c drivers... and
> > review process is slow. So it would not be before all those changes are
> > reviewed and merged.
> Removing "pcie_aspm=off" works for my MT7915E based cards, having had no
> issues so far. So it doesn't seem to be an issue with the Marvell hardware
> itself at least.

That is probably because MT7915E card does not trigger that issue. But
I think issue is really in Marvell hardware.

> Regarding Atheros cards: I disabled it back then for my Atheros AR9582 &
> QCA9880 cards and never re-enabled it when I switched to the MT7915E cards,
> which I forgot to mention in my first mail, sorry!
> I put those two cards back into the device to test it, and the same problem
> occurs why I disabled it back then. The router completely freezes while
> booting with this as the last log lines (gathered via serial):
> 
> [   10.400986] ath9k 0000:02:00.0: can't change power state from D3cold to
> D0 (config space inaccessible)
> [   10.466924] ath10k_pci 0000:03:00.0: can't change power state from D3cold
> to D0 (config space inaccessible)
> [   10.613847] ath10k_pci 0000:03:00.0: failed to wake up device : -110

At this stage there is no link with the card. But kernel does not know
it as there is missing implementation for DLLSC interrupt in pci-mvebu.c
driver. We need DLLSC support for debugging this issue.

For another Marvell driver (pci-aardvark.c) there is already pending
patch for review which adds DLLSC interrupt support:
https://lore.kernel.org/linux-pci/20220220193346.23789-9-kabel@kernel.org/

So on Armada 3720 platforms it is possible to start debugging it.

I have (experimental) DLLSC support prepared also for pci-mvebu.c but it
depends on summary interrupt which is in missing in irq-armada-370-xp.c:
https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-mvebu

So without that summary interrupt in irq-armada-370-xp.c driver it is
not possible to get information about it in pci-mvebu.c driver.

> [   10.622944] usb 1-1: New USB device found, idVendor=0cf3, idProduct=3004,
> bcdDevice= 0.02
> [   10.635092] usb 1-1: New USB device strings: Mfr=0, Product=0,
> SerialNumber=0
> [   10.659930] ath10k_pci: probe of 0000:03:00.0 failed with error -110
> 
> This seems to be another topic however. I'd be glad to test and try to debug
> fixes and / or gather additional information on my hardware regarding this
> problem.

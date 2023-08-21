Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A77830C6
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 21:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjHUTLG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 15:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjHUTLE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 15:11:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B392E5B
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 12:10:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC47D6133F
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 19:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8284C433C7;
        Mon, 21 Aug 2023 19:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692645057;
        bh=2muyo106Vd8pmINTrMd1YhKfAiK5OBu5XlLXu5kqLco=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jnPkiBgCFj7KO/FWFKUX/bEp2F9ms2WsojH3UkqZ/zsAlOBNFb6RVC5B2eEF8Dnmc
         WCCYfAQznGyO/Dp0eElO2jEYXa7XInWVwcliQOwaNtSGSBBD4ULP7ukCCYm3RvFq3/
         c/VR2xCsFiKiILSj/wq2CQHF8rDuhxVSC+Nj5TM92vBy3IxiMLVX/97LxzS6vZiwIE
         aLhk20tSOTexbmP5chcTiQHSgH8GIkLSe1eecUHG4H6dNYFG+mMlsfv0VLxlsBUX96
         LCI1RAmqHPELCzRhtv4/uKc+RuDe35j0chH91CKTIgdYA7ROFtnuOqF00N+wxoD0XP
         +cMiKophjY76Q==
Date:   Mon, 21 Aug 2023 14:10:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kamil Paral <kparal@redhat.com>
Cc:     linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        mika.westerberg@linux.intel.com, bhelgaas@google.com,
        chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230821191055.GA362994@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 21, 2023 at 12:39:02PM +0200, Kamil Paral wrote:
> = Summary =
> A Thinkpad T480s laptop with a Thinkpad Thunderbolt 3 Dock connected
> can no longer resume from suspend. The problem was introduced in
> e8b908146d44 "PCI/PM: Increase wait time after resume".
> 
> = Detailed description =
> When running a kernel containing the identified commit and trying to
> resume the laptop from sleep, the laptop's power light changes from
> blinking (sleep state) to shining (running state), but the display
> stays black and it doesn't respond to any keyboard input, nor to
> ping/ssh, and no logs are written to the disk (which means I don't
> know how to gather error logs). It needs to be force-rebooted. I
> bisected the kernel and identified the commit which causes this
> behavior. I used the vanilla kernel with a Fedora kernel config.
> 
> The reproducer is:
> 1. Connect the dock to the laptop.
> 2. Boot the laptop (in my case, to the gdm).
> 3. Suspend the laptop.
> 4. Resume the laptop. This is successful before the identified commit
> (the last tested good commit was cc8a983d0fce), and unsuccessful
> (black screen, frozen system) after the identified commit
> (e8b908146d44).
> 
> The reproducibility is 100%, I tested it many many times in a row.
> 
> When the dock is unplugged, suspend and resume works as expected. When
> I connect a different laptop to the dock (Thinkpad P1 gen3), I don't
> see any resume failure. So this is somehow related to the particular
> combination of Thinkpad T480s and Thinkpad Thunderbolt 3 Dock. The
> dock is running the latest firmware.

Thanks very much for the report.

Wow, this is super interesting.  e8b908146d44 literally just increases
a timeout; the complete patch is:

   static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
   {
  -       pci_bridge_wait_for_secondary_bus(pci_dev, "resume", PCI_RESET_WAIT);
  +       pci_bridge_wait_for_secondary_bus(pci_dev, "resume",
  +                                         PCIE_RESET_READY_POLL_MS);

Increasing a timeout should never cause a failure like this, so
there must be something really unexpected going on.

> I also tested "pcie_aspm=off",
> and that allows the laptop to resume properly, but then there's a race
> condition whether devices on the dock are visible to the OS or not
> after resume, so this is not useful even just as a workaround.

Wow, also shocking.  I see you have lspci output attached to the RH
bugzilla, but it doesn't include the details.  Would you mind
collecting the output of "sudo lspci -vv" both with and without
"pcie_aspm=off"?  No need to try suspend/resume to collect these.

Also, what does this race condition look like?  Dock devices are
visible before suspend, but sometimes none of them are visible *after*
resume?  We don't re-enumerate on resume, so does this mean they still
appear in lspci output but they just don't work?

If you can collect the complete dmesg log and "sudo lspci -vv" output
after a resume when the dock devices aren't visible, maybe there would
be a clue there.

> I already created a downstream Fedora bug report in Red Hat Bugzilla:
> https://bugzilla.redhat.com/show_bug.cgi?id=2230357
> 
> lspci of the laptop:
> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1982541
> git bisect log:
> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1983351
> 
> 
> The commit which broke resume is the following:
> 
> e8b908146d44310473e43b3382eca126e12d279c is the first bad commit
> commit e8b908146d44310473e43b3382eca126e12d279c
> Author: Mika Westerberg <mika.westerberg.com>
> Date:   Tue Apr 4 08:27:13 2023 +0300
> 
>     PCI/PM: Increase wait time after resume
> 
>     PCIe r6.0 sec 6.6.1 prescribes that a device must be able to respond to
>     config requests within 1.0 s (PCI_RESET_WAIT) after exiting conventional
>     reset and this same delay is prescribed when coming out of D3cold (as that
>     involves reset too).
> 
>     A device that requires more than 1 second to initialize after reset may
>     respond to config requests with Request Retry Status completions (sec
>     2.3.1), and we accommodate that in Linux with a 60 second cap
>     (PCIE_RESET_READY_POLL_MS).
> 
>     Previously we waited up to PCIE_RESET_READY_POLL_MS only in the reset code
>     path, not in the resume path.  However, a device has surfaced, namely Intel
>     Titan Ridge xHCI, which requires a longer delay also in the resume code
>     path.
> 
>     Make the resume code path to use this same extended delay as the reset
>     path.
> 
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=216728
>     Link: https://lore.kernel.org/r/20230404052714.51315-2-mika.westerberg@linux.intel.com
>     Reported-by: Chris Chiu <chris.chiu>
>     Signed-off-by: Mika Westerberg <mika.westerberg.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas>
>     Cc: Lukas Wunner <lukas>
> 
>  drivers/pci/pci-driver.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> 
> I'm happy to add further details, perform additional debugging, or
> test some experimental patches in order to resolve this regression.
> Please CC me in your replies, I'm not subscribed to this list. Thank
> you!
> Kamil Páral
> 
> 
> #regzbot introduced: e8b908146d44
> 

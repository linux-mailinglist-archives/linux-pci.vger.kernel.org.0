Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D3E4ED47C
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 09:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiCaHNI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 03:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiCaHMy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 03:12:54 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CE5944A38;
        Thu, 31 Mar 2022 00:10:52 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8937A92009E; Thu, 31 Mar 2022 09:10:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 81ADF92009D;
        Thu, 31 Mar 2022 08:10:51 +0100 (BST)
Date:   Thu, 31 Mar 2022 08:10:51 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Arnd Bergmann <arnd@kernel.org>, Nikolai Zhubr <zhubr.2@gmail.com>,
        Michal Necasek <mnecasek@yahoo.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] x86/PCI: Improve $PIR and add $IRT PIRQ routing
 support
Message-ID: <alpine.DEB.2.21.2203301619340.22465@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

 This is an updated patch series with a fix applied to what is now 3/5 for 
a bug that was reported by Dmitry (thanks!) having triggered with his 
x86-64 setup and then nailed down by Linus (also thanks!).  Additionally 
as suggested by Linus a fix has been added, for a preexisting problem with 
the routing table not being verified to stay whole within the BIOS memory 
range, that has become 1/5, expanding the whole series from 4 to 5 changes 
now.  In the course of that addition a couple of coding style issues have 
been consumed, shrinking what has now become 5/5.  The cover letter has 
been updated accordingly throughout.

 First 1/5 handles $PIR PIRQ routing tables that lack router device
information, fixing the inability to route interrupts with a system using 
the SiS85C497 ISA bridge.

 Then 2/5 adds support for the $IRT PIRQ routing table format invented by 
AMI before Microsoft has come up with its own $PIR format.  These formats 
are very similar to each other, but the $IRT format does not provide for 
router device information, so this change relies on 1/5.  It has turned 
out needed to route interrupts with a system using the ALi M1487 ISA Bus 
Controller device, discussed earlier on in a discussion thread around: 
<https://lore.kernel.org/linux-pci/61377A45.8030003@gmail.com/>.  This 
change has been verified with an artificially created $IRT table.

 Then 3/5 adds a range check for 

 Then 3/4 corrects our link value interpretation for said M1487 device 
according to Nikolai's findings with his system reported here: 
<https://lore.kernel.org/linux-pci/61428EDF.9030203@gmail.com/>.

 Finally 4/4 corrects a couple of coding style issues around though not 
immediately within code changed by 2/4 so as to make the style consistent.

 See individual change descriptions for further details.

 Credit to Michal (cc-ed) for helping me chase documentation for the
$IRT table format.

 Please apply.

  Maciej

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B95A4863AC
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 12:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbiAFLYE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 06:24:04 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:38540 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238405AbiAFLYD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 06:24:03 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 5F53E92009C; Thu,  6 Jan 2022 12:24:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 5906092009B;
        Thu,  6 Jan 2022 11:24:01 +0000 (GMT)
Date:   Thu, 6 Jan 2022 11:24:01 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Arnd Bergmann <arnd@kernel.org>,
        Michal Necasek <mnecasek@yahoo.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] x86/PCI: Improve $PIR and add $IRT PIRQ routing
 support
Message-ID: <alpine.DEB.2.21.2201021821480.56863@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

 This is a new patch series made around a discrete patch submitted earlier 
on that has gone nowhere, which is now 1/4.  That change handles $PIR PIRQ 
routing tables that lack router device information, fixing the inability 
to route interrupts with a system using the SiS85C497 ISA bridge.  It has 
been minimally updated from v1 by including router device information 
reported with the change description, and by adding Nikolai's Tested-by 
annotation.

 Then 2/4 adds support for the $IRT PIRQ routing table format invented by 
AMI before Microsoft has come up with its own $PIR format.  These formats 
are very similar to each other, but the $IRT format does not provide for 
router device information, so this change relies on 1/4.  It has turned 
out needed to route interrupts with a system using the ALi M1487 ISA Bus 
Controller device, discussed earlier on in a discussion thread around: 
<https://lore.kernel.org/linux-pci/61377A45.8030003@gmail.com/>.  This 
change has been verified with an artificially created $IRT table and 
hopefully Nikolai will be able to verify this code with his system as 
well.

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

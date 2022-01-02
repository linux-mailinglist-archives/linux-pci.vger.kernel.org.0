Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE002482D2E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jan 2022 00:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiABXc4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Jan 2022 18:32:56 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:38400 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiABXcy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Jan 2022 18:32:54 -0500
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Jan 2022 18:32:53 EST
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id DBD2E9200C1; Mon,  3 Jan 2022 00:24:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id D8CD09200BF;
        Sun,  2 Jan 2022 23:24:19 +0000 (GMT)
Date:   Sun, 2 Jan 2022 23:24:19 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] x86/PCI: Odd generic PIRQ router improvements
Message-ID: <alpine.DEB.2.21.2201020142430.56863@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

 Resending as this has gone into void.  Also there is a context dependency 
with a change developed later possibly causing a merge conflict, so to 
make it easier to queue the incoming patches I have folded the follow-up 
change into this series, expanding it to 4 patches from the original 3 and 
mechanically regenerating according to upstream changes.  I have updated 
the cover letter accordingly.

 While working on the SiS85C497 PIRQ router I have noticed an odd
phenomenon with my venerable Tyan Tomcat IV S1564D board, where the PCI 
INTD# line of the USB host controller included as function 3 of the PIIX3 
southbridge cannot be routed in the `noapic' mode.  As it turns out the 
reason for this is the BIOS has two individual entries in its PIRQ table 
for two of its three functions, and the wrong one is chosen for routing 
said line.

 Strictly speaking this violates the PCI BIOS specification, but it can be 
easily worked around while preserving the semantics for compliant systems.

 Therefore I have come up with this patch series, which addresses this 
problem with 3/4, adds function reporting to the debug PIRQ table dump 
with 2/4 and also prints a usable physical memory address of the PIRQ 
table in a debug message with 1/4.

 Then 4/4 follows, addressing the inability to use a PIRQ table to route 
interrupts for devices placed behind PCI-to-PCI bridges on option cards, 
and especially where the BIOS has failed to enumerate the whole bus tree 
in the first place.

 See individual change descriptions for further details.

 Please apply.

  Maciej

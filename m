Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF34483193
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jan 2022 14:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiACNrZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jan 2022 08:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiACNrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jan 2022 08:47:25 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12874C061761;
        Mon,  3 Jan 2022 05:47:25 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 3279B92009C; Mon,  3 Jan 2022 14:47:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2E00392009B;
        Mon,  3 Jan 2022 13:47:24 +0000 (GMT)
Date:   Mon, 3 Jan 2022 13:47:24 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/PCI: SiS PIRQ router updates
In-Reply-To: <61D2D9B5.7080401@gmail.com>
Message-ID: <alpine.DEB.2.21.2201031338470.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201022040130.56863@angie.orcam.me.uk> <61D2D9B5.7080401@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 3 Jan 2022, Nikolai Zhubr wrote:

> One peculiarity with my specific board is that I had to also patch ROM BIOS
> because it included some non-standard $IRT table instead of $PIR table. With
> that in place, it now Just Works.

 I have a patch in the queue for $IRT table support too, according to your 
and some later findings about it.  Just waiting for an ack off-list from 
someone, so I'll hopefully post it sometime this week.  Sadly I've been 
quite loaded with higher-priority stuff recently meaning I can't dedicate 
so much time to these patches as I would like to.  We'll get there though 
sooner or later.

 Thanks for your confirmation as to the usability of these changes.

  Maciej

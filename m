Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7DE4A5A7F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 11:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbiBAKtx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 05:49:53 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:44272 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiBAKtx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 05:49:53 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8F06692009C; Tue,  1 Feb 2022 11:49:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 87F0292009B;
        Tue,  1 Feb 2022 10:49:51 +0000 (GMT)
Date:   Tue, 1 Feb 2022 10:49:51 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PING][PATCH v2 0/4] x86/PCI: Odd generic PIRQ router improvements
In-Reply-To: <20220106232528.GA334563@bhelgaas>
Message-ID: <alpine.DEB.2.21.2202010108590.58572@angie.orcam.me.uk>
References: <20220106232528.GA334563@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 6 Jan 2022, Bjorn Helgaas wrote:

> On Sun, Jan 02, 2022 at 11:24:19PM +0000, Maciej W. Rozycki wrote:
> > 
> >  Resending as this has gone into void.  Also there is a context dependency 
> > with a change developed later possibly causing a merge conflict, so to 
> > make it easier to queue the incoming patches I have folded the follow-up 
> > change into this series, expanding it to 4 patches from the original 3 and 
> > mechanically regenerating according to upstream changes.  I have updated 
> > the cover letter accordingly.
> 
> I'm assuming the x86/IRQ folks will handle this, too.

 Ping for:

<https://lore.kernel.org/lkml/alpine.DEB.2.21.2201020142430.56863@angie.orcam.me.uk/>.

 Series re-verified against 5.17-rc2.  Thank you for your input, Bjorn!

  Maciej

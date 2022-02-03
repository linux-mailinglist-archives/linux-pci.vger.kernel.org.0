Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B594A8C3A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 20:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353684AbiBCTJW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 14:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353676AbiBCTJV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 14:09:21 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8B29C061714;
        Thu,  3 Feb 2022 11:09:20 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BBF1F92009C; Thu,  3 Feb 2022 20:09:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B4C4E92009B;
        Thu,  3 Feb 2022 19:09:19 +0000 (GMT)
Date:   Thu, 3 Feb 2022 19:09:19 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Brent Spillner <spillner@acm.org>
cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/PCI: Improve log message when IRQ cannot be
 identified
In-Reply-To: <CAGwJgaNcWA9bP4LjJRSefUhQ0eUM5xYWz8MMg7NjXgHB3+jMCQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2202031858490.34636@angie.orcam.me.uk>
References: <CAGwJgaMDJH-rhsc9+_vj1vjj6XLigvqVYLdu-6TgrDNxGpTubA@mail.gmail.com> <20220202224239.GA49678@bhelgaas> <CAGwJgaNcWA9bP4LjJRSefUhQ0eUM5xYWz8MMg7NjXgHB3+jMCQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 3 Feb 2022, Brent Spillner wrote:

> > If your system has ACPI, I think "pci=biosirq" and "acpi=noirq" are at
> > best distractions from finding the real problem.
> 
> ...except when the cause is indeed buggy ACPI firmware, which is
> presumably the only reason these options exist in the first place.

 The former is really for us missing a PIRQ router or for a BIOS missing a 
$PIR table.  I have been posting patches recently to add support for some 
of such systems identified.  Those are all pre-ACPI, possibly long before, 
i.e. early to late 1990s (486 and P5/P54C Pentium and similar systems), 
and I think the option was added before we had ACPI support too.  I have a 
couple of pre-ACPI x86 systems too, which are quirky to say the least even 
though they were the quality systems of the time from reputable vendors.

 FWIW,

  Maciej

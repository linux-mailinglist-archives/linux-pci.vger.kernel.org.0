Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E6D4A5160
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 22:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351109AbiAaVWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 16:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344273AbiAaVWQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 16:22:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5BAC061714;
        Mon, 31 Jan 2022 13:22:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 895C661551;
        Mon, 31 Jan 2022 21:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A0FC340E8;
        Mon, 31 Jan 2022 21:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643664134;
        bh=OQPPff+VNVexuaIwDaQ8HqPGB/uPTD1j/rHAOfVFiMI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AqZHizyBRhG45rzMuoD+Vra5tgjAeeehuwfA1tAof3XNzN3+W73/AReushgs8nHJv
         rdN3NoLN+/A2aoHNVFDI6247LmTPJKEKJRqiAjWOWORKVYhV0f4jiTbMmIuW0yEGIj
         0EaLG3/olUiI360YFxQsJ5S8jEcTojbtyLczP1JHSsuHbjLe4VI6Wzx/MsWfMiEkN0
         jAg1ZUCHUjDPr54OZoi2/Wtx1XRJqLjJXgGYLhGFhqtFzzStAFk1j5U9NvLVZrIE2F
         ehJyQXKpqRu/+4efAI80IS8kNoxOXdG4LKgQdK0fZYScmo4W03CFTWnmntK7j4KveY
         8/N73vQ1uMtLA==
Date:   Mon, 31 Jan 2022 15:22:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Brent Spillner <spillner@acm.org>, bhelgaas@google.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch:x86:pci:irq.c: Improve log message when IRQ cannot
 be identified
Message-ID: <20220131212213.GA510910@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f820849-6940-4271-e678-1ae037cdfb64@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 28, 2022 at 01:36:53PM -0800, Dave Hansen wrote:
> On 1/28/22 12:48, Brent Spillner wrote:
> > It seems like the multiline string literal is your main pain point--- would
> > 
> > +#ifdef CONFIG_ACPI
> > +                       if (acpi_noirq)
> > +                               msg = "; consider removing acpi=noirq";
> > +                       else
> > +                               msg = "; recommend verifying UEFI/BIOS
> > IRQ options";
> > +#else
> > +                       msg = "; recommend verifying UEFI/BIOS IRQ
> > options or enabling ACPI";
> > +#endif
> > 
> > be OK without going to IS_ENABLED()?  (Personally, I think the #ifdef
> > style is more readable.)
> 
> I think that's _better_ than what was in the patch.  But, even with it,
> I still think the #ifdef mess borders on unreadable.
> 
> But, if Bjorn likes it, then go for it. :)

I was hoping to avoid commenting at all ;)

I'm a little bit averse to suggesting *any* command-line options
because users shouldn't have to use options like these.  It would be
better if we got a bug report and could fix the bug or add a quirk to
work around a firmware issue automatically.

If a user finds a command-line option that "works," the problem is
solved as far as they are concerned, but it doesn't help the next
person who trips over it.

I think pci_acpi_init() should warn when "acpi=noirq" was used because
the only reason to use it should be to work around a firmware defect,
and ideally, we could make a quirk to do that.  Maybe the doc should
suggest a bug report.

What does "verifying UEFI/BIOS IRQ options" mean?  I could go look at
the BIOS setup menu, but I would have no idea what to look for, so the
only thing I could do would be to try randomly changing IRQ-related
things.  If that happens to hit on a working configuration, I might
be happy, but it wouldn't help the next person at all.  I'd rather see
a bug report.  Then we could at least try to make a quirk so no
command line option would be needed.

Bjorn

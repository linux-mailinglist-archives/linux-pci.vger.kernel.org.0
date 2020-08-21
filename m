Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103B424E406
	for <lists+linux-pci@lfdr.de>; Sat, 22 Aug 2020 01:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgHUXwt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 19:52:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59470 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHUXwr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 19:52:47 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598053964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+LZCecR158RlHm3Lfth6ASLtXm3kGC9vvr84iJ8MvX8=;
        b=xZsKT6+dHTeL/lPigJTJYxz10V5jp4mNkl4ys/Z1+RQa2aOyMCwJ0A9QGvZ+gtLEU2rlOt
        w9ZkLky8Zf8dQgL59I+NSKflohKRF4aEGsbOV7+0oXvtRe8KnhKhibYsAQsJJfgI7w2XNA
        zUMuX/W1n1W0geuTAbFGJ1K+Uyutpby/+hG50EyUJqr1aro5r5FdZfRhNZ2nxUDcS4X7g6
        rfbaQW+/f9sSwjisuSHue5r3wlfGuZFDNHSPtxW6nY3x5d/ivg/fELnDG0tMatQXTlE+VT
        ORFQYAnqvWTDHElBmHM9mS70rdctzqqQlyWDMHZ9ZV9WoYiV4LNuT+UuNHaA2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598053964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+LZCecR158RlHm3Lfth6ASLtXm3kGC9vvr84iJ8MvX8=;
        b=DVVyWJbpQAVeIGWvbb0PJSl2YfWN/KZCi3QwxtKS4FEVVEGQqao4CMhOsFBZuiWK+UdRPN
        tXMkbWltoox6BoAw==
To:     Randy Dunlap <rdunlap@infradead.org>,
        Adam Borowski <kilobyte@angband.pl>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] x86/pci: don't set acpi stuff if !CONFIG_ACPI
In-Reply-To: <85e70752-8034-ab95-f6b4-018c7086edad@infradead.org>
References: <20200820125320.9967-1-kilobyte@angband.pl> <87y2m7rc4a.fsf@nanos.tec.linutronix.de> <20200821203232.GA2187@angband.pl> <85e70752-8034-ab95-f6b4-018c7086edad@infradead.org>
Date:   Sat, 22 Aug 2020 01:52:44 +0200
Message-ID: <87mu2nr1yr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 21 2020 at 14:19, Randy Dunlap wrote:
> On 8/21/20 1:32 PM, Adam Borowski wrote:
>> If I understand Randy Dunlap correctly, he already sent a pair of patches
>> that do what you want.

I replied before reading Randy's reply. Old habit of reading stuff from
top and not getting biased by other peoples replies before doing so. Is
most of the time the correct approach, but sometimes it would be better
to do it the other way round :)

> I did, but I sent them to the Xen and PCI maintainers,
> not the x86 maintainers, but I will happily resend this patch.
> The Xen patch has already been applied whereas the patch
> to intel_mid_pci.c is in limbo. :(
>
> Thomas, do you want me to send it to you/X86 people?
> (with 2 Reviewed-by: additions)

Sure, but usually Bjorn handles the x86/pci/ stuff.

As I trust you, here is a blind

  Acked-by: Thomas Gleixner <tglx@linutronix.de>

just in case.

Thanks,

        tglx

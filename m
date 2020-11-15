Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA462B386B
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 20:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgKOTSC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 14:18:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36654 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgKOTSC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2020 14:18:02 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605467881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CLnGu8lb5LNXF3wcoVZ3vJRrTXJjdROaGVrW8S5oQhA=;
        b=O/XE1m2MKFlT8xZf1Cq6Po1Gmac/E8iDwHur8LM3eSeCywQZwDx2Out46Q533GwOaXAIKR
        WkfIAx9v3DWYMBbt798kLTr7J1mhpTTD/y/GtchWmGoW8aXUQ7md3ZZn78RIEhvWcEc9QS
        JqFF0Vn3s8Lrwa3Ru3UPo1ROZgGn9TK07F51ySN9fTcWK2w/lJuXIQNRrYaTT8ii6qrhWB
        lf6dijSSu0nQRpa5lseE058OFXnYWGSdhpCPpxfVHZ7T1S58ssoSl19E2urYfx9seP8lek
        7M1Ntp90BB0NqB9WDnNi8I7hWvRKRXl3ak6HweMbCC0iLegtlmSUDkbSNPIw7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605467881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CLnGu8lb5LNXF3wcoVZ3vJRrTXJjdROaGVrW8S5oQhA=;
        b=iEidRvNc0brKUtlWaXD2pf4gXMXSsUxGARxc5nIk7yhvgrAIMK9rWDg11U8CLbXtcSgVhI
        DpgYmmuxdwp2uBDg==
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        kernelfans@gmail.com, andi@firstfloor.org, hpa@zytor.com,
        bhe@redhat.com, x86@kernel.org, okaya@kernel.org, mingo@redhat.com,
        jay.vosburgh@canonical.com, dyoung@redhat.com,
        gavin.guo@canonical.com,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>, bp@alien8.de,
        bhelgaas@google.com, shan.gavin@linux.alibaba.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@gpiccoli.net,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        ddstreet@canonical.com, vgoyal@redhat.com
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
In-Reply-To: <20201115170158.GA27152@wunner.de>
References: <20201114212215.GA1194074@bjorn-Precision-5520> <87v9e6n2b2.fsf@x220.int.ebiederm.org> <87sg9almmg.fsf@x220.int.ebiederm.org> <874klqac40.fsf@nanos.tec.linutronix.de> <20201115170158.GA27152@wunner.de>
Date:   Sun, 15 Nov 2020 20:18:00 +0100
Message-ID: <87k0um8m53.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 15 2020 at 18:01, Lukas Wunner wrote:
> On Sun, Nov 15, 2020 at 04:11:43PM +0100, Thomas Gleixner wrote:
>> Unfortunately there is no way to tell the APIC "Mask vector X" and the
>> dump kernel does neither know which device it comes from nor does it
>> have enumerated PCI completely which would reset the device and shutup
>> the spew. Due to the interrupt storm it does not get that far.
>
> Can't we just set DisINTx, clear MSI Enable and clear MSI-X Enable
> on all active PCI devices in the crashing kernel before starting the
> crash kernel?  So that the crash kernel starts with a clean slate?
>
> Guilherme's original patches from 2018 iterate over all 256 PCI buses.
> That might impact boot time negatively.  The reason he has to do that
> is because the crashing kernel doesn't know which devices exist and
> which have interrupts enabled.  However the crashing kernel has that
> information.  It should either disable interrupts itself or pass the
> necessary information to the crashing kernel as setup_data or whatever.

As I explained before: The problem with doing anything between crashing
and starting the crash kernel is reducing the chance of actually
starting it. The kernel crashed for whatever reason, so it's in a
completely undefined state.

Ergo there is no 'just do something'. You really have to think hard
about what can be done safely with the least probability of running into
another problem.

Thanks,

        tglx



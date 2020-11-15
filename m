Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DF32B3707
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 18:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgKORLS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 12:11:18 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:40751 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgKORLS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2020 12:11:18 -0500
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Nov 2020 12:11:17 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 75C88100E2006;
        Sun, 15 Nov 2020 18:01:58 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 61A271BCF3; Sun, 15 Nov 2020 18:01:58 +0100 (CET)
Date:   Sun, 15 Nov 2020 18:01:58 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Message-ID: <20201115170158.GA27152@wunner.de>
References: <20201114212215.GA1194074@bjorn-Precision-5520>
 <87v9e6n2b2.fsf@x220.int.ebiederm.org>
 <87sg9almmg.fsf@x220.int.ebiederm.org>
 <874klqac40.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874klqac40.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 15, 2020 at 04:11:43PM +0100, Thomas Gleixner wrote:
> Unfortunately there is no way to tell the APIC "Mask vector X" and the
> dump kernel does neither know which device it comes from nor does it
> have enumerated PCI completely which would reset the device and shutup
> the spew. Due to the interrupt storm it does not get that far.

Can't we just set DisINTx, clear MSI Enable and clear MSI-X Enable
on all active PCI devices in the crashing kernel before starting the
crash kernel?  So that the crash kernel starts with a clean slate?

Guilherme's original patches from 2018 iterate over all 256 PCI buses.
That might impact boot time negatively.  The reason he has to do that
is because the crashing kernel doesn't know which devices exist and
which have interrupts enabled.  However the crashing kernel has that
information.  It should either disable interrupts itself or pass the
necessary information to the crashing kernel as setup_data or whatever.

Guilherme's patches add a "clearmsi" command line parameter.  I guess
the idea is that the parameter is always passed to the crash kernel
but the patches don't do that, which seems odd.

Thanks,

Lukas

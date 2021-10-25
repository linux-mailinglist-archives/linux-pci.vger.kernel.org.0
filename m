Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEAC43934A
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 12:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhJYKFS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 06:05:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59796 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232676AbhJYKFS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 06:05:18 -0400
Received: from zn.tnic (p200300ec2f0f4e00d22405724977670e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4e00:d224:572:4977:670e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D69F1EC04EE;
        Mon, 25 Oct 2021 12:02:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635156175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VROD/COb1dL/OTdUDk7Wr4EIAQvPOoqzPadBFiERlkM=;
        b=nuMp5lccls1KJPQHadmttrue2PiFtNZm3CW2YOMdGvE8NhdtrsCMlXL3hV7eZtyfhnS7RH
        VozToVrH2f308NOqHwamVRUJtpzIZ35nJsjQXf9c5os8jGHy9zJSDT2h/nB2YG8dNTBJEb
        4vA/To3lEtuyBD9t4OmBv1caEiJKnYM=
Date:   Mon, 25 Oct 2021 12:02:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] x86/PCI: Fix compile errors when CONFIG_PCI is disabled
Message-ID: <YXaAzVJGRabW7b9K@zn.tnic>
References: <20211020102102.86577-1-hdegoede@redhat.com>
 <YXZ92/QxiGq2mM/R@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXZ92/QxiGq2mM/R@lahna>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 25, 2021 at 12:50:19PM +0300, Mika Westerberg wrote:
> On Wed, Oct 20, 2021 at 12:21:02PM +0200, Hans de Goede wrote:
> > arch/x86/include/asm/pci_x86.h uses a number of data -types and defines
> > without including the headers which define these.
> > 
> > Instead so far it has been relying on files including it including the
> > necessary headers first.
> > 
> > Recently a include <asm/pci_x86.h> was added to arch/x86/kernel/resource.c
> > which does not include the necessary headers first.
> > 
> > Add the missing includes to arch/x86/include/asm/pci_x86.h to fix the
> > compile errors (with certain .config-s) when it is included from
> > arch/x86/kernel/resource.c.
> > 
> > Fixes: f10507a66e36 ("x86/PCI: Ignore E820 reservations for bridge windows on newer systems")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

IIRC, this was squashed into the Fixes: patch:

https://lore.kernel.org/r/20211020211455.GA2641031@bhelgaas

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EA22C8EF4
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 21:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgK3UVE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 15:21:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbgK3UVD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 15:21:03 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B61002074A;
        Mon, 30 Nov 2020 20:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606767623;
        bh=Hpw2PczhkHKDUohGu9XA63kRRhtANavoFBG2MTLhVsc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=14GJ1kfJP79EuRWnEWpkjplbRdQEr2yEuwUFqoeMhBuFu/pZOoZlnmhFB+2AiV0Ox
         0Yx5w3Ul1+9cvDZuK0cUf4/SHE8pZKmS3dezRIDuV+Eonv0fk4sal360j9EwH7bFZC
         YRnclvcW+amj9EQzbXlXBgyuuhTrzOiiqItWZzbM=
Date:   Mon, 30 Nov 2020 14:20:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Guilherme Piccoli <gpiccoli@canonical.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>, lukas@wunner.de,
        linux-pci@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>,
        Baoquan He <bhe@redhat.com>, x86@kernel.org,
        Sinan Kaya <okaya@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Dave Young <dyoung@redhat.com>,
        Gavin Guo <gavin.guo@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Streetman <ddstreet@canonical.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
Message-ID: <20201130202021.GA1106292@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHD1Q_yfFYrfAEHTA3mW25hK9DFFYnKQ2_1HCEnL4m=bc=rLfg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 18, 2020 at 07:36:08PM -0300, Guilherme Piccoli wrote:
> Thanks a lot Bjorn! I confess except for PPC64 Server machines, I
> never saw other "domains" or segments. Is it common in x86 to have
> that? The early_quirks() are restricted to the first segment, no
> matter how many host bridges we have in segment 0000?

I don't know whether it's *common* to have multiple domains on x86,
but they're definitely used on large systems.  This includes some
lspci info from an HPE Superdome Flex system:
https://lore.kernel.org/lkml/5350E02A-6457-41A8-8F33-AF67BFDAEE3E@fb.com/

The early quirks in arch/x86/kernel/early-quirks.c (not the
DECLARE_PCI_FIXUP_EARLY quirks in drivers/pci/quirks.c) are restricted
to segment 0, no matter how many host bridges there are.  This is
because they use read_pci_config_16(), which uses a config access
mechanism that has no provision for a segment number.

Bjorn

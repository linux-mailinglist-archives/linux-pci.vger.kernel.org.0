Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198FB4A5A85
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 11:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiBAKuO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 05:50:14 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:44306 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbiBAKuN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 05:50:13 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id A872C92009C; Tue,  1 Feb 2022 11:50:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id A273092009B;
        Tue,  1 Feb 2022 10:50:11 +0000 (GMT)
Date:   Tue, 1 Feb 2022 10:50:11 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PING][PATCH v2 0/2] x86/PCI: SiS PIRQ router updates
In-Reply-To: <20220106232552.GA334613@bhelgaas>
Message-ID: <alpine.DEB.2.21.2202010131530.58572@angie.orcam.me.uk>
References: <20220106232552.GA334613@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 6 Jan 2022, Bjorn Helgaas wrote:

> On Sun, Jan 02, 2022 at 11:24:59PM +0000, Maciej W. Rozycki wrote:
> > 
> >  Reposting as this has gone nowhere.  Regenerated for line changes and 
> > with Nikolai's Tested-by annotation for 2/2, which now have been verified 
> > in combination with generic PIRQ router updates posted separately (there's 
> > no ordering dependency between the two patch series).
> 
> I assume the x86/IRQ folks will handle this, too.

 Ping for:

<https://lore.kernel.org/lkml/alpine.DEB.2.21.2201022040130.56863@angie.orcam.me.uk/>.

 Series re-verified against 5.17-rc2.  Thank you for your input, Bjorn!

  Maciej

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CFC4A5A81
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 11:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiBAKuF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 05:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiBAKuD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 05:50:03 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0E6BC061714;
        Tue,  1 Feb 2022 02:50:03 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id CEA0692009D; Tue,  1 Feb 2022 11:50:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id C852E92009B;
        Tue,  1 Feb 2022 10:50:00 +0000 (GMT)
Date:   Tue, 1 Feb 2022 10:50:00 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PING][PATCH v3] x86/PCI: Add support for the Intel 82378ZB/82379AB
 (SIO/SIO.A) PIRQ router
In-Reply-To: <20220106232456.GA334344@bhelgaas>
Message-ID: <alpine.DEB.2.21.2202010128560.58572@angie.orcam.me.uk>
References: <20220106232456.GA334344@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 6 Jan 2022, Bjorn Helgaas wrote:

> >  Reposting as it seems to have been missed and now needs to be regenerated 
> > to resolve a merge conflict with a later change that did make it.
> > 
> >  Please apply.
> 
> No objection from me, but I know zero about this code, so I'll let the
> x86/IRQ guys deal with this.

 Ping for:
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2201022030220.56863@angie.orcam.me.uk/>.

 Patch re-verified against 5.17-rc2.  Thank you for your input, Bjorn!

  Maciej


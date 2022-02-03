Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEA54A824B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 11:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiBCK2y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 05:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiBCK2x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 05:28:53 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A0A3C061714;
        Thu,  3 Feb 2022 02:28:53 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id DCAE592009C; Thu,  3 Feb 2022 11:28:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id D684B92009B;
        Thu,  3 Feb 2022 10:28:50 +0000 (GMT)
Date:   Thu, 3 Feb 2022 10:28:50 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        Michal Necasek <mnecasek@yahoo.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] x86/PCI: Improve $PIR and add $IRT PIRQ routing
 support
In-Reply-To: <87sft1vano.ffs@tglx>
Message-ID: <alpine.DEB.2.21.2202031028220.34636@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201021821480.56863@angie.orcam.me.uk> <87sft1vano.ffs@tglx>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2 Feb 2022, Thomas Gleixner wrote:

> >  This is a new patch series made around a discrete patch submitted earlier 
> > on that has gone nowhere, which is now 1/4.  That change handles $PIR
> > PIRQ
> 
> sorry for ignoring this due to stack overflow. I'll go over it later
> today.

 Great, thanks!

  Maciej

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178783D8B5B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 12:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhG1KEk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhG1KEk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jul 2021 06:04:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B8C061757;
        Wed, 28 Jul 2021 03:04:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627466677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TkHd2f4fC/74J+JKUk+4OaEyf2hpuX0DoqcIuoep3hU=;
        b=RfzmdcSZ1gvdH4+gbaDqeETPGo9b32ue2BP7VTvwFsv6efvPeGtIS2oOyD9zuquvmch17P
        X0MEt7Gee/x828/X+vxEYxPxz1i+u/3beedH1HG6jKdlaISh/wAmjXGNXYUznsvl04TmN+
        WCk18WpjDKIFGlP9NCfudWELRjpK4kRPTpKgK8abpzmWEcJ+XIZHAc2opiwN8mJcY/s/+O
        Iw/rvsrcZmTnSfzltljVcueURRY2DraI3uQYK5QB0TGYbFV4Tm6qTKSHPPvwZOhM8RJ+l/
        B01/M3ZH5kTZ1ggdlyTwuwHSBbOV2XAnpxkslBHVGOlTSz2ZSC2n8DjO/4rb5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627466677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TkHd2f4fC/74J+JKUk+4OaEyf2hpuX0DoqcIuoep3hU=;
        b=2YEyF/PBVedVWzyRDGXOOq65MLCywIkrPeCWfhiy65v8L3CxJzcz3K3V10DAba5JZRXP5H
        555Wp/iqAYV20eCg==
To:     Marc Zyngier <maz@kernel.org>
Cc:     "Raj\, Ashok" <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Tian <kevin.tian@intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [patch 2/8] PCI/MSI: Mask all unused MSI-X entries
In-Reply-To: <8735s631hq.wl-maz@kernel.org>
References: <20210721191126.274946280@linutronix.de> <20210721192650.268814107@linutronix.de> <20210721222313.GC676232@otc-nc-03> <87zgufnuks.ffs@nanos.tec.linutronix.de> <8735s631hq.wl-maz@kernel.org>
Date:   Wed, 28 Jul 2021 12:04:37 +0200
Message-ID: <87eebi3gay.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 22 2021 at 14:46, Marc Zyngier wrote:
> On Wed, 21 Jul 2021 23:57:55 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> msix_mask_all() is invoked before the msi descriptors are
>> allocated. msi_desc::masked is actually a misnomer because it's not like
>> the name suggests a boolean representing the masked state. It's caching
>> the content of the PCI_MSIX_ENTRY_VECTOR_CTRL part of the corresponding
>> table entry. Right now this is just using bit 0 (the mask bit), but is
>> that true forever? So we actually should rename that member to
>> vector_ctrl or such.
>
> To follow-up with this forward looking statement, should we only keep
> bit 0 when reading PCI_MSIX_ENTRY_VECTOR_CTRL? I.e.:
>
> 	entry->masked = (readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL) &
> 			 PCI_MSIX_ENTRY_CTRL_MASKBIT);
>
> Or do we want to cache the whole register? In which case I'm all for
> the suggesting renaming (though 'masked' is shared with the old-school
> multi-MSI).

We want to cache the whole register because that's what we need to write
when the mask bit is toggled.

Thanks,

        tglx

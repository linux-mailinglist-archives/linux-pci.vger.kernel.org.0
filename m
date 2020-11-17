Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8692D2B6EBF
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 20:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgKQTe0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 14:34:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50236 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKQTeZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 14:34:25 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605641663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zPOq2Gof25KoyGTbil/CYi0lyxMBn0WxrZqz+oT1E5A=;
        b=PQPRExsKgi88p9KsUpyG9up506cAUOROacfRqMm62eqdoAvUKx6i7yr+Yp3eZtfo1xWdBk
        pUuw2OHDqm+vX9HTNAjal5MUuOF2sBs2M5/0JkLsdzpYxbkbz6bXMrGZyjSm2kkATLdOBY
        HYcuiVNlNHjIChCDf4gtFy0dpBbBDuO+DpKqHVUGrbWPTvPWabxVU7so4G0Gt6lV8WFtom
        Jo+MYPrgKPZLLuhkDERYqXDmmGF29Exte52haBdjBv5Zw5Bp5dT5IjAd7C+OEGgr85+fvQ
        T0jTpKf++eb3tkq4jPfViasWN/08q54fAT0lFEE1u8JqETnvOrR52LhSQtE0Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605641663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zPOq2Gof25KoyGTbil/CYi0lyxMBn0WxrZqz+oT1E5A=;
        b=/SsNrCoqoGbx8Sxq048YeIHsiS2Dnfzgqok1cMtqOL8LNNePCmP53qWrQT6beORsfmlCKB
        cucJM1rH7pGwCcDw==
To:     David Woodhouse <dwmw2@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>, lukas@wunner.de,
        linux-pci@vger.kernel.org, kernelfans@gmail.com,
        andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org,
        okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com,
        dyoung@redhat.com, gavin.guo@canonical.com, bp@alien8.de,
        bhelgaas@google.com, Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@gpiccoli.net,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        ddstreet@canonical.com, vgoyal@redhat.com
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
In-Reply-To: <f0d35834054cc1ac77ac0e6b68e84d62de3c48f7.camel@infradead.org>
References: <20201117001907.GA1342260@bjorn-Precision-5520> <87h7poeqqn.fsf@x220.int.ebiederm.org> <873618xqaa.fsf@nanos.tec.linutronix.de> <f0d35834054cc1ac77ac0e6b68e84d62de3c48f7.camel@infradead.org>
Date:   Tue, 17 Nov 2020 20:34:23 +0100
Message-ID: <87wnyjwzeo.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 17 2020 at 12:19, David Woodhouse wrote:
> On Tue, 2020-11-17 at 10:53 +0100, Thomas Gleixner wrote:
>> But that does not solve the problem either simply because then the IOMMU
>> will catch the rogue MSIs and you get an interrupt storm on the IOMMU
>> error interrupt.
>
> Not if you can tell the IOMMU to stop reporting those errors.
>
> We can easily do it per-device for DMA errors; not quite sure what
> granularity we have for interrupts. Perhaps the Intel IOMMU only lets
> you set the Fault Processing Disable bit per IRTE entry, and you still
> get faults for Compatibility Format interrupts? Not sure about AMD...

It looks like the fault (DMAR) and event (AMD) interrupts can be
disabled in the IOMMU. That might help to bridge the gap until the PCI
bus is scanned in full glory and the devices can be shut up for real.

If we make this conditional for a crash dump kernel that might do the
trick.

Lot's of _might_ there :)

Thanks

        tglx






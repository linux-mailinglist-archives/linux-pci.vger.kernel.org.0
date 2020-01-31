Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F3214F334
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 21:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgAaUdT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 15:33:19 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39964 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgAaUdS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2020 15:33:18 -0500
Received: by mail-lf1-f67.google.com with SMTP id c23so5779233lfi.7
        for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2020 12:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/H8kLH2v9jt9+oV/BTdgW+V7p3YELEgt+i45cxuZ9vE=;
        b=X6f8OU6k/Or52a60fPVQDww5Ni1iSrGpR0eC4eNSpLj+TYB1kspe42WeoZBaaA1AA6
         e0ayrN9lnGLpEnDT8OZ6UOtmry7e2qMKXiT+QLw/gskL7WSkgMDOvQt7OMWWH7eNhOql
         JwhHDRPs43e2tpAHNY7uAoxS5+xWIKBK1jF9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/H8kLH2v9jt9+oV/BTdgW+V7p3YELEgt+i45cxuZ9vE=;
        b=X9/p7zsgo0BSWTtlYbX/Vvoz8t1lyLMES/D/Q9K01oazpheD1oy/z0Bq9BxCICA73u
         eVQ3+CU+ONp+UituWNmzP2SEG7mXTEYSUGiuNzANLoPnbntTzIS5+uJnU8bKAN8f0B5L
         JtB/mVWsJYRt11o1ocYiwPxrPxCET1pUTFlwY4nfw6YRaT3nBfIw54cdhMFftm2pEh1q
         1WOpNF1k/d4GQ5SwJKPRQzQTEWPyhzFoawl1AR7k0NWCCMiy/lBqceCGtBBpd3Jl+Xqx
         9XKFk2STZfS/5eHv3IGV4mBM7obHgdWlE250o/vxDBacD9H21boEdIZXMqR7quSB4huj
         XO8g==
X-Gm-Message-State: APjAAAXHQqKNLseVXvrUrwFqQqeY9Ib1y7o+zl+VTImUuccyEZExhjlh
        JIk2jqHDelGzI08Trf7hVJFh/kGlM2w=
X-Google-Smtp-Source: APXvYqw+vWx1Tqi7DrVKk6qlxcRreaZBHW3ltvOx6a0OanotqBrp5/I9K7vZNPJ+0pakQ0aNHWe2Ag==
X-Received: by 2002:a19:be93:: with SMTP id o141mr6341559lff.181.1580502795801;
        Fri, 31 Jan 2020 12:33:15 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id r20sm5100844lfi.91.2020.01.31.12.33.14
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 12:33:15 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id x14so8378238ljd.13
        for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2020 12:33:14 -0800 (PST)
X-Received: by 2002:a2e:3e10:: with SMTP id l16mr6784769lja.286.1580502794229;
 Fri, 31 Jan 2020 12:33:14 -0800 (PST)
MIME-Version: 1.0
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com>
 <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
 <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de>
 <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com>
 <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
 <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com>
 <87d0b82a9o.fsf@nanos.tec.linutronix.de> <CAE=gft7C5HTmcTLsXqXbCtcYDeKG6bCJ0gmgwVNc0PDHLJ5y_A@mail.gmail.com>
 <878slwmpu9.fsf@nanos.tec.linutronix.de> <87imkv63yf.fsf@nanos.tec.linutronix.de>
 <CAE=gft7Gu0ah4qcbsEB1X+kUMagCzPR+cdCfn2caofcGV+tBjA@mail.gmail.com>
 <87pnf342pr.fsf@nanos.tec.linutronix.de> <CAE=gft69hQcbmT46b1T8eLdPFyb9Pp-sDYd5JfPsZ2JWL4PXqQ@mail.gmail.com>
 <877e1a2d11.fsf@nanos.tec.linutronix.de> <CAE=gft7mLAU3G+f8gi_etRSpUijoCh7_6ni9Ob2JqjW7Q1n3yQ@mail.gmail.com>
 <874kwd3lbn.fsf@nanos.tec.linutronix.de> <CAE=gft52iBTJyyvDTXeHdEYnpSSROvrQsweuXjd6OuaLO47ACw@mail.gmail.com>
 <87lfpn50id.fsf@nanos.tec.linutronix.de> <87imkr4s7n.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87imkr4s7n.fsf@nanos.tec.linutronix.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 31 Jan 2020 12:32:37 -0800
X-Gmail-Original-Message-ID: <CAE=gft4cGYL7jHLqcGCU9J_efHs5dd+QyP8NfW5iSZCoi-SVOg@mail.gmail.com>
Message-ID: <CAE=gft4cGYL7jHLqcGCU9J_efHs5dd+QyP8NfW5iSZCoi-SVOg@mail.gmail.com>
Subject: Re: [PATCH V2] x86/apic/msi: Plug non-maskable MSI affinity race
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 31, 2020 at 6:27 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Thomas Gleixner <tglx@linutronix.de> writes:
>
> Evan tracked down a subtle race between the update of the MSI message and
> the device raising an interrupt internally on PCI devices which do not
> support MSI masking. The update of the MSI message is non-atomic and
> consists of either 2 or 3 sequential 32bit wide writes to the PCI config
> space.
>
>    - Write address low 32bits
>    - Write address high 32bits (If supported by device)
>    - Write data
>
> When an interrupt is migrated then both address and data might change, so
> the kernel attempts to mask the MSI interrupt first. But for MSI masking is
> optional, so there exist devices which do not provide it. That means that
> if the device raises an interrupt internally between the writes and MSI
> message is sent built from half updated state.
>
> On x86 this can lead to spurious interrupts on the wrong interrupt
> vector when the affinity setting changes both address and data. As a
> consequence the device interrupt can be lost causing the device to
> become stuck or malfunctioning.
>
> Evan tried to handle that by disabling MSI accross an MSI message
> update. That's not feasible because disabling MSI has issues on its own:
>
>  If MSI is disabled the PCI device is routing an interrupt to the legacy
>  INTx mechanism. The INTx delivery can be disabled, but the disablement is
>  not working on all devices.
>
>  Some devices lose interrupts when both MSI and INTx delivery are disabled.
>
> Another way to solve this would be to enforce the allocation of the same
> vector on all CPUs in the system for this kind of screwed devices. That
> could be done, but it would bring back the vector space exhaustion problems
> which got solved a few years ago.
>
> Fortunately the high address (if supported by the device) is only relevant
> when X2APIC is enabled which implies interrupt remapping. In the interrupt
> remapping case the affinity setting is happening at the interrupt remapping
> unit and the PCI MSI message is programmed only once when the PCI device is
> initialized.
>
> That makes it possible to solve it with a two step update:
>
>   1) Target the MSI msg to the new vector on the current target CPU
>
>   2) Target the MSI msg to the new vector on the new target CPU
>
> In both cases writing the MSI message is only changing a single 32bit word
> which prevents the issue of inconsistency.
>
> After writing the final destination it is necessary to check whether the
> device issued an interrupt while the intermediate state #1 (new vector,
> current CPU) was in effect.
>
> This is possible because the affinity change is always happening on the
> current target CPU. The code runs with interrupts disabled, so the
> interrupt can be detected by checking the IRR of the local APIC. If the
> vector is pending in the IRR then the interrupt is retriggered on the new
> target CPU by sending an IPI for the associated vector on the target CPU.
>
> This can cause spurious interrupts on both the local and the new target
> CPU.
>
>  1) If the new vector is not in use on the local CPU and the device
>     affected by the affinity change raised an interrupt during the
>     transitional state (step #1 above) then interrupt entry code will
>     ignore that spurious interrupt. The vector is marked so that the
>     'No irq handler for vector' warning is supressed once.
>
>  2) If the new vector is in use already on the local CPU then the IRR check
>     might see an pending interrupt from the device which is using this
>     vector. The IPI to the new target CPU will then invoke the handler of
>     the device, which got the affinity change, even if that device did not
>     issue an interrupt
>
>  3) If the new vector is in use already on the local CPU and the device
>     affected by the affinity change raised an interrupt during the
>     transitional state (step #1 above) then the handler of the device which
>     uses that vector on the local CPU will be invoked.
>
> #1 is uninteresting and has no unintended side effects. #2 and #3 might
> expose issues in device driver interrupt handlers which are not prepared to
> handle a spurious interrupt correctly. This not a regression, it's just
> exposing something which was already broken as spurious interrupts can
> happen for a lot of reasons and all driver handlers need to be able to deal
> with them.
>
> Reported-by: Evan Green <evgreen@chromium.org>
> Debugged-by: Evan Green <evgreen@chromium.org>                                                                                        Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Heh, thanks for the credit. Something weird happened on this line with
your signoff, though.
I've been running this on my system for a few hours with no issues
(normal repro in <1 minute). So,

Tested-by: Evan Green <evgreen@chromium.org>

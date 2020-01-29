Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D8414D00F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 19:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgA2SCA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 13:02:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39785 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgA2SCA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2020 13:02:00 -0500
Received: by mail-lf1-f67.google.com with SMTP id t23so320820lfk.6
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2020 10:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v49qSJDDhvOaRsBI9gc+tYZ4RfGmEGHF1xKb4v6wLhw=;
        b=XIzrCznP9I3gq08sozdu3CWZBayLW7ZkHxJeQxM+XmEdLhqmWxUHfD3rocLMQ2MXdY
         XP89vxP5NvtBFfL7hPVxhlhj6bl9yyT13nUd5CkifWcfrpdgAF6+hihMrGBflE4yVM5k
         2HJWDzCDAQp8LGiZCQ9KXSJ8hZULCEJiiM0ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v49qSJDDhvOaRsBI9gc+tYZ4RfGmEGHF1xKb4v6wLhw=;
        b=BdO+6qNhQHVLRW0FXkLBZ0sy0BT9Xv6pmNwcwdK2eskFSRC6/kGn4Lf9L5ov9Gpphb
         iviGYfGs8GKt42E9FS7C40mVZjhJRRjp7B118mPaqTmBrZ4mdKpzGFfZEcS8aDDyfy4Q
         x9EkVLiU3qJFkmVOzDJa1DGioJDRrmvpmqmCRjiGHInAocedTheFtAn4WIq5wzFlIl0x
         lzNq4ZzR1k0PMR0Ig51p5/ysRUBGKbxM5gPmlE8aXC4oUmNTJVMSXslDEZ9F+QBK5B2N
         Mq9qJaznDv3nS5w0KQb4UJla8nnoBEwjVRF8H+h2zxdoFR9Bv1H79AnRpFsTlSeg/oPd
         eqvA==
X-Gm-Message-State: APjAAAU8TNSYii2nWfjOvqtfpiHq0c9CFmuFMXFm57JlLoWrl8KQxDLx
        xKrT8vnsVaoKQ+3/uvNQo1n+vaQeFM4=
X-Google-Smtp-Source: APXvYqyIdDPCACdZrqRHFMObBGsL5ApNYtlffXCkI6mlMNVoeGBT65lCxKmntHMVxpyjivpb/6EiGQ==
X-Received: by 2002:ac2:555c:: with SMTP id l28mr288555lfk.52.1580320916608;
        Wed, 29 Jan 2020 10:01:56 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id y11sm1745247lfc.27.2020.01.29.10.01.36
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 10:01:37 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id b15so330909lfc.4
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2020 10:01:36 -0800 (PST)
X-Received: by 2002:a19:c205:: with SMTP id l5mr259903lfc.159.1580320896113;
 Wed, 29 Jan 2020 10:01:36 -0800 (PST)
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
 <CAE=gft7Gu0ah4qcbsEB1X+kUMagCzPR+cdCfn2caofcGV+tBjA@mail.gmail.com> <87pnf342pr.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87pnf342pr.fsf@nanos.tec.linutronix.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 29 Jan 2020 10:00:59 -0800
X-Gmail-Original-Message-ID: <CAE=gft69hQcbmT46b1T8eLdPFyb9Pp-sDYd5JfPsZ2JWL4PXqQ@mail.gmail.com>
Message-ID: <CAE=gft69hQcbmT46b1T8eLdPFyb9Pp-sDYd5JfPsZ2JWL4PXqQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
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

On Tue, Jan 28, 2020 at 2:48 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Evan,
>
> Evan Green <evgreen@chromium.org> writes:
> > On Tue, Jan 28, 2020 at 6:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> The patch is only lightly tested, but so far it survived.
> >>
> >
> > Hi Thomas,
> > Thanks for the patch, I gave it a try. I get the following splat, then a hang:
> >
> > [   62.238406]        CPU0
> > [   62.241135]        ----
> > [   62.243863]   lock(vector_lock);
> > [   62.247467]   lock(vector_lock);
> > [   62.251071]
> > [   62.251071]  *** DEADLOCK ***
> > [   62.251071]
> > [   62.257687]  May be due to missing lock nesting notation
> > [   62.257687]
> > [   62.265274] 2 locks held by migration/1/17:
> > [   62.269946]  #0: 00000000cfa9d8c3 (&irq_desc_lock_class){-.-.}, at:
> > irq_migrate_all_off_this_cpu+0x44/0x28f
> > [   62.280846]  #1: 000000006885da2d (vector_lock){-.-.}, at:
> > msi_set_affinity+0x13c/0x27b
> > [   62.289801]
> > [   62.289801] stack backtrace:
> > [   62.294669] CPU: 1 PID: 17 Comm: migration/1 Not tainted 4.19.96 #2
> > [   62.310713] Call Trace:
> > [   62.313446]  dump_stack+0xac/0x11e
> > [   62.317255]  __lock_acquire+0x64f/0x19bc
> > [   62.321646]  ? find_held_lock+0x3d/0xb8
> > [   62.325936]  ? pci_conf1_write+0x4f/0xdf
> > [   62.330320]  lock_acquire+0x1b2/0x1fa
> > [   62.334413]  ? apic_retrigger_irq+0x31/0x63
> > [   62.339097]  _raw_spin_lock_irqsave+0x51/0x7d
> > [   62.343972]  ? apic_retrigger_irq+0x31/0x63
> > [   62.348646]  apic_retrigger_irq+0x31/0x63
> > [   62.353124]  msi_set_affinity+0x25a/0x27b
>
> Bah. I'm sure I looked at that call chain, noticed the double vector
> lock and then forgot. Delta patch below.

It's working well with the delta patch, been running for about an hour
with no issues.
-Evan

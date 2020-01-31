Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F379914F3F2
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 22:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgAaVpp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 16:45:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56684 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgAaVpo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2020 16:45:44 -0500
Received: from 51.26-246-81.adsl-static.isp.belgacom.be ([81.246.26.51] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ixe6f-0005eR-6Z; Fri, 31 Jan 2020 22:45:41 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id BE110105BDC; Fri, 31 Jan 2020 22:45:35 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Evan Green <evgreen@chromium.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V2] x86/apic/msi: Plug non-maskable MSI affinity race
In-Reply-To: <CAE=gft4cGYL7jHLqcGCU9J_efHs5dd+QyP8NfW5iSZCoi-SVOg@mail.gmail.com>
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
 <87y2tytv5i.fsf@nanos.tec.linutronix.de>
 <87eevqkpgn.fsf@nanos.tec.linutronix.de>
 <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com>
 <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
 <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com>
 <87d0b82a9o.fsf@nanos.tec.linutronix.de>
 <CAE=gft7C5HTmcTLsXqXbCtcYDeKG6bCJ0gmgwVNc0PDHLJ5y_A@mail.gmail.com>
 <878slwmpu9.fsf@nanos.tec.linutronix.de>
 <87imkv63yf.fsf@nanos.tec.linutronix.de>
 <CAE=gft7Gu0ah4qcbsEB1X+kUMagCzPR+cdCfn2caofcGV+tBjA@mail.gmail.com>
 <87pnf342pr.fsf@nanos.tec.linutronix.de>
 <CAE=gft69hQcbmT46b1T8eLdPFyb9Pp-sDYd5JfPsZ2JWL4PXqQ@mail.gmail.com>
 <877e1a2d11.fsf@nanos.tec.linutronix.de>
 <CAE=gft7mLAU3G+f8gi_etRSpUijoCh7_6ni9Ob2JqjW7Q1n3yQ@mail.gmail.com>
 <874kwd3lbn.fsf@nanos.tec.linutronix.de>
 <CAE=gft52iBTJyyvDTXeHdEYnpSSROvrQsweuXjd6OuaLO47ACw@mail.gmail.com>
 <87lfpn50id.fsf@nanos.tec.linutronix.de>
 <87imkr4s7n.fsf@nanos.tec.linutronix.de>
 <CAE=gft4cGYL7jHLqcGCU9J_efHs5dd+QyP8NfW5iSZCoi-SVOg@mail.gmail.com>
Date:   Fri, 31 Jan 2020 22:45:35 +0100
Message-ID: <87d0azuwow.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Evan Green <evgreen@chromium.org> writes:
> On Fri, Jan 31, 2020 at 6:27 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> #1 is uninteresting and has no unintended side effects. #2 and #3 might
>> expose issues in device driver interrupt handlers which are not prepared to
>> handle a spurious interrupt correctly. This not a regression, it's just
>> exposing something which was already broken as spurious interrupts can
>> happen for a lot of reasons and all driver handlers need to be able to deal
>> with them.
>>
>> Reported-by: Evan Green <evgreen@chromium.org>
>> Debugged-by: Evan Green <evgreen@chromium.org>                                                                                        Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> Heh, thanks for the credit.

Thanks for the detective work and the persistance to convince me!

> Something weird happened on this line with your signoff, though.

Yeah. No idea how I fatfingered that.

> I've been running this on my system for a few hours with no issues
> (normal repro in <1 minute). So,
>
> Tested-by: Evan Green <evgreen@chromium.org>

Thanks for confirmation!

       tglx

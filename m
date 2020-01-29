Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D31114D23A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 22:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgA2VBJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 16:01:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51920 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbgA2VBI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2020 16:01:08 -0500
Received: from 51.26-246-81.adsl-static.isp.belgacom.be ([81.246.26.51] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iwuSO-0006I8-S8; Wed, 29 Jan 2020 22:01:05 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 02740105CFD; Wed, 29 Jan 2020 22:00:58 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Evan Green <evgreen@chromium.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
In-Reply-To: <CAE=gft69hQcbmT46b1T8eLdPFyb9Pp-sDYd5JfPsZ2JWL4PXqQ@mail.gmail.com>
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid> <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com> <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com> <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de> <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com> <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com> <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com> <87d0b82a9o.fsf@nanos.tec.linutronix.de> <CAE=gft7C5HTmcTLsXqXbCtcYDeKG6bCJ0gmgwVNc0PDHLJ5y_A@mail.gmail.com> <878slwmpu9.fsf@nanos.tec.linutronix.de> <87imkv63yf.fsf@nanos.tec.linutronix.de> <CAE=gft7Gu0ah4qcbsEB1X+kUMagCzPR+cdCfn2caofcGV+tBjA@mail.gmail.com> <87pnf342pr.fsf@nanos.tec.linutronix.de> <CAE=gft69hQcbmT46b1T8eLdPFyb9Pp-sDYd5JfPsZ2JWL4PXqQ@mail.gmail.com>
Date:   Wed, 29 Jan 2020 22:00:58 +0100
Message-ID: <877e1a2d11.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Evan,

Evan Green <evgreen@chromium.org> writes:
> On Tue, Jan 28, 2020 at 2:48 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Bah. I'm sure I looked at that call chain, noticed the double vector
>> lock and then forgot. Delta patch below.
>
> It's working well with the delta patch, been running for about an hour
> with no issues.

thanks for the info and for testing!

Could you please add some instrumentation to see how often this stuff
actually triggers spurious interrupts?

Thanks,

        tglx

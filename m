Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391811872C0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 19:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbgCPSwf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 14:52:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52668 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732298AbgCPSwf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 14:52:35 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jDuqT-0003hb-PO; Mon, 16 Mar 2020 19:52:13 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id EB5B21013B2; Mon, 16 Mar 2020 19:52:12 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/9] pci/switchtec: Don't abuse completion wait queue for poll
In-Reply-To: <9213d617-207e-da4e-094a-45ae587fdc98@deltatee.com>
References: <20200313174701.148376-1-bigeasy@linutronix.de> <20200313174701.148376-4-bigeasy@linutronix.de> <4d3a997d-ced4-3dbe-d766-0b1e9fc35b29@deltatee.com> <87sgibeqcs.fsf@nanos.tec.linutronix.de> <9213d617-207e-da4e-094a-45ae587fdc98@deltatee.com>
Date:   Mon, 16 Mar 2020 19:52:12 +0100
Message-ID: <871rpsdter.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Logan Gunthorpe <logang@deltatee.com> writes:
> On 2020-03-13 6:23 p.m., Thomas Gleixner wrote:
> I'm in awe at the lack of professionalism in your emails. If you
> bothered to edit out the ad hominems, you might have noticed that nobody
> has yet described how the poll interface fails here (with
> EPOLLEXCLUSIVE) or how replacing one wait queue for another fixes the
> purported problem.

I merily stated an opinion, but if you consider this an ad hominem
attack, then let me ensure you this wasn't my intention and accept my
apology.

Thanks,

        tglx

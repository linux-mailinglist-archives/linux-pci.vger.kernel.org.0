Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391F8187727
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 01:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbgCQA4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 20:56:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53161 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733119AbgCQA4O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 20:56:14 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jE0Wg-0007YB-AC; Tue, 17 Mar 2020 01:56:10 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id BA8A0101161; Tue, 17 Mar 2020 01:56:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] PCI/switchtec: Fix init_completion race condition with poll_wait()
In-Reply-To: <20200313183608.2646-1-logang@deltatee.com>
References: <20200313183608.2646-1-logang@deltatee.com>
Date:   Tue, 17 Mar 2020 01:56:09 +0100
Message-ID: <87mu8fdck6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Logan,

Logan Gunthorpe <logang@deltatee.com> writes:

> The call to init_completion() in mrpc_queue_cmd() can theoretically
> race with the call to poll_wait() in switchtec_dev_poll().
>
>   poll()			write()
>     switchtec_dev_poll()   	  switchtec_dev_write()
>       poll_wait(&s->comp.wait);      mrpc_queue_cmd()
> 			               init_completion(&s->comp)
> 				         init_waitqueue_head(&s->comp.wait)

just a nitpick. As you took the liberty to copy the description of the
race, which was btw. disovered by me, verbatim from a changelog written
by someone else w/o providing the courtesy of linking to that original
analysis, allow me the liberty to add the missing link:

Link: https://lore.kernel.org/lkml/20200313174701.148376-4-bigeasy@linutronix.de

> To my knowledge, no one has hit this bug, but we should fix it for
> correctness.

s/,but we should fix/.Fix/ ?

> Fix this by using reinit_completion() instead of init_completion() in
> mrpc_queue_cmd().
>
> Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

@Bjorn: Can you please hold off on this for a few days until we sorted
        out the remaining issues to avoid potential merge conflicts
        vs. the completion series?

Thanks,

        tglx

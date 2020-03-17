Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F036E187BB4
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 10:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgCQJFL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 05:05:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53647 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgCQJFL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 05:05:11 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jE89p-0004bp-Tc; Tue, 17 Mar 2020 10:05:06 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id BF3EF101161; Tue, 17 Mar 2020 10:05:04 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] PCI/switchtec: Fix init_completion race condition with poll_wait()
In-Reply-To: <38781f88-32df-e89a-7d00-fd2fcc097497@deltatee.com>
References: <20200313183608.2646-1-logang@deltatee.com> <87mu8fdck6.fsf@nanos.tec.linutronix.de> <38781f88-32df-e89a-7d00-fd2fcc097497@deltatee.com>
Date:   Tue, 17 Mar 2020 10:05:04 +0100
Message-ID: <87k13jcpxb.fsf@nanos.tec.linutronix.de>
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
> On 2020-03-16 6:56 p.m., Thomas Gleixner wrote:
>> @Bjorn: Can you please hold off on this for a few days until we sorted
>>         out the remaining issues to avoid potential merge conflicts
>>         vs. the completion series?
>
> I'd suggest simply rebasing the completion patch on this patch, or a
> patch like it. Then we'll have the proper bug fix commit and there won't
> be a conflict.

The conflict is not a question of rebasing or not. The conflict arises
when this patch is routed through PCI simply because then the rest of
the completion work is stuck until this hits mainline.

Thanks,

        tglx

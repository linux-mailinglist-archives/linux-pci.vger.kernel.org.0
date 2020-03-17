Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2905618776C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 02:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733188AbgCQBZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 21:25:17 -0400
Received: from ale.deltatee.com ([207.54.116.67]:55060 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733017AbgCQBZQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Mar 2020 21:25:16 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jE0yo-0008I8-Hx; Mon, 16 Mar 2020 19:25:15 -0600
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20200313183608.2646-1-logang@deltatee.com>
 <87mu8fdck6.fsf@nanos.tec.linutronix.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <38781f88-32df-e89a-7d00-fd2fcc097497@deltatee.com>
Date:   Mon, 16 Mar 2020 19:25:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87mu8fdck6.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: bigeasy@linutronix.de, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,SURBL_BLOCKED,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH] PCI/switchtec: Fix init_completion race condition with
 poll_wait()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-03-16 6:56 p.m., Thomas Gleixner wrote:
> Logan,
> 
> Logan Gunthorpe <logang@deltatee.com> writes:
> 
>> The call to init_completion() in mrpc_queue_cmd() can theoretically
>> race with the call to poll_wait() in switchtec_dev_poll().
>>
>>   poll()			write()
>>     switchtec_dev_poll()   	  switchtec_dev_write()
>>       poll_wait(&s->comp.wait);      mrpc_queue_cmd()
>> 			               init_completion(&s->comp)
>> 				         init_waitqueue_head(&s->comp.wait)
> 
> just a nitpick. As you took the liberty to copy the description of the
> race, which was btw. disovered by me, verbatim from a changelog written
> by someone else w/o providing the courtesy of linking to that original
> analysis, allow me the liberty to add the missing link:
>
> Link: https://lore.kernel.org/lkml/20200313174701.148376-4-bigeasy@linutronix.de

Well, I just copied the call chain. I had no way to know you were the
one who discovered the bug given the way it was presented to me. And the
original patch didn't include much in the way of analysis of the bug,
just "It's Racy".

I didn't deliberately omit the link, it just never occurred to me to add
it. In retrospect, I should have included it, sorry about that.

>> To my knowledge, no one has hit this bug, but we should fix it for
>> correctness.
> 
> s/,but we should fix/.Fix/ ?

Yes, that's an improvement.

>> Fix this by using reinit_completion() instead of init_completion() in
>> mrpc_queue_cmd().
>>
>> Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
>> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks.

> @Bjorn: Can you please hold off on this for a few days until we sorted
>         out the remaining issues to avoid potential merge conflicts
>         vs. the completion series?

I'd suggest simply rebasing the completion patch on this patch, or a
patch like it. Then we'll have the proper bug fix commit and there won't
be a conflict.

Logan

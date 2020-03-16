Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFE0187347
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 20:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbgCPTZP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 15:25:15 -0400
Received: from ale.deltatee.com ([207.54.116.67]:51002 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732366AbgCPTZP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Mar 2020 15:25:15 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jDvM7-0002Tq-EK; Mon, 16 Mar 2020 13:24:56 -0600
To:     Thomas Gleixner <tglx@linutronix.de>,
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
References: <20200313174701.148376-1-bigeasy@linutronix.de>
 <20200313174701.148376-4-bigeasy@linutronix.de>
 <4d3a997d-ced4-3dbe-d766-0b1e9fc35b29@deltatee.com>
 <87sgibeqcs.fsf@nanos.tec.linutronix.de>
 <9213d617-207e-da4e-094a-45ae587fdc98@deltatee.com>
 <871rpsdter.fsf@nanos.tec.linutronix.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <66997357-37db-b7ca-b6e8-0f6a17e09308@deltatee.com>
Date:   Mon, 16 Mar 2020 13:24:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <871rpsdter.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, bhelgaas@google.com, kurt.schwemmer@microsemi.com, torvalds@linux-foundation.org, rostedt@goodmis.org, joel@joelfernandes.org, paulmck@kernel.org, will@kernel.org, mingo@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, bigeasy@linutronix.de, tglx@linutronix.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_EXCLUSIVE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH 3/9] pci/switchtec: Don't abuse completion wait queue for
 poll
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-03-16 12:52 p.m., Thomas Gleixner wrote:
> Logan Gunthorpe <logang@deltatee.com> writes:
>> On 2020-03-13 6:23 p.m., Thomas Gleixner wrote:
>> I'm in awe at the lack of professionalism in your emails. If you
>> bothered to edit out the ad hominems, you might have noticed that nobody
>> has yet described how the poll interface fails here (with
>> EPOLLEXCLUSIVE) or how replacing one wait queue for another fixes the
>> purported problem.
> 
> I merily stated an opinion, but if you consider this an ad hominem
> attack, then let me ensure you this wasn't my intention and accept my
> apology.

A technical opinion, and a valid argument, does *not* involve telling me
what my decision process was ("You decided this was smart to do"), or
mocking it as "hillarious" (sic).

Your actual opinion was drowned out by these attacks. And, while valid,
your opinion is very much subjective and I, personally, disagree with it.

I accept your apology and hope this doesn't happen again.

Thanks,

Logan

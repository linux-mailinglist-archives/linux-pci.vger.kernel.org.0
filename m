Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3698420B6C5
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgFZRUp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jun 2020 13:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgFZRUp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jun 2020 13:20:45 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71286C03E979;
        Fri, 26 Jun 2020 10:20:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 730261573479B;
        Fri, 26 Jun 2020 10:20:41 -0700 (PDT)
Date:   Fri, 26 Jun 2020 10:20:38 -0700 (PDT)
Message-Id: <20200626.102038.1298513542272393362.davem@davemloft.net>
To:     peterz@infradead.org
Cc:     nitesh@redhat.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, frederic@kernel.org,
        mtosatti@redhat.com, juri.lelli@redhat.com, abelits@marvell.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        jinyuqi@huawei.com, zhangshaokun@hisilicon.com
Subject: Re: [Patch v4 3/3] net: Restrict receive packets queuing to
 housekeeping CPUs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200626111401.GE4817@hirez.programming.kicks-ass.net>
References: <20200625223443.2684-1-nitesh@redhat.com>
        <20200625223443.2684-4-nitesh@redhat.com>
        <20200626111401.GE4817@hirez.programming.kicks-ass.net>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 26 Jun 2020 10:20:42 -0700 (PDT)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 26 Jun 2020 13:14:01 +0200

> On Thu, Jun 25, 2020 at 06:34:43PM -0400, Nitesh Narayan Lal wrote:
>> From: Alex Belits <abelits@marvell.com>
>> 
>> With the existing implementation of store_rps_map(), packets are queued
>> in the receive path on the backlog queues of other CPUs irrespective of
>> whether they are isolated or not. This could add a latency overhead to
>> any RT workload that is running on the same CPU.
>> 
>> Ensure that store_rps_map() only uses available housekeeping CPUs for
>> storing the rps_map.
>> 
>> Signed-off-by: Alex Belits <abelits@marvell.com>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> 
> Dave, ACK if I route this?

No problem:

Acked-by: David S. Miller <davem@davemloft.net>

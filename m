Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0D120B047
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 13:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgFZLPN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jun 2020 07:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgFZLPM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jun 2020 07:15:12 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67792C08C5C1;
        Fri, 26 Jun 2020 04:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OPLtbx4nSF+ZifTe6YUf/6ZKs4PvGHfV1P1Ne1BmY9I=; b=TMYZ5TM8uqJMUmW9EMBU5X0XlE
        sUmdCj+Le5O1RirUulvCJzrbBODVkrm5WB3Fi6gddS74hf5+7pDgxsKNeXGmDGnEu8Uf8Ot6TLeci
        akXaxHdpV7kgkX9h7CtRRKqp/P5O0h52RTuZxSwPT7v3EGZwKop0NY5fv7tde7yLI/49+/1euM6v7
        5NpixGyi9vvjrq07AnGsrKu8CUaX++A4o/8WlEbsQtr7TrhMyjyfGDFoMPm8cOFokts0iU9Poaauk
        txHL3rMCuuB1pfOKI5qzsaxY2UJUFHZ+Ia0iCTOuH/wv4YseBtGfGa4Vhi6we2tYnvd4fAASDKWKI
        8x7yR3mA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jomJ1-0006Uh-4s; Fri, 26 Jun 2020 11:14:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 07704301DFC;
        Fri, 26 Jun 2020 13:14:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F78329C9595E; Fri, 26 Jun 2020 13:14:01 +0200 (CEST)
Date:   Fri, 26 Jun 2020 13:14:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        tglx@linutronix.de, davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com, jinyuqi@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [Patch v4 3/3] net: Restrict receive packets queuing to
 housekeeping CPUs
Message-ID: <20200626111401.GE4817@hirez.programming.kicks-ass.net>
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-4-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625223443.2684-4-nitesh@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 25, 2020 at 06:34:43PM -0400, Nitesh Narayan Lal wrote:
> From: Alex Belits <abelits@marvell.com>
> 
> With the existing implementation of store_rps_map(), packets are queued
> in the receive path on the backlog queues of other CPUs irrespective of
> whether they are isolated or not. This could add a latency overhead to
> any RT workload that is running on the same CPU.
> 
> Ensure that store_rps_map() only uses available housekeeping CPUs for
> storing the rps_map.
> 
> Signed-off-by: Alex Belits <abelits@marvell.com>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>

Dave, ACK if I route this?

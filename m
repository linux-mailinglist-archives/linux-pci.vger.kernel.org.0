Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFFF2070D7
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 12:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390189AbgFXKJE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 06:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbgFXKJD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 06:09:03 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73957C061573;
        Wed, 24 Jun 2020 03:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fbvRV6I4MBKKb4K8TrGIAwzpXd/13MRtwyrauhi7npU=; b=Q6kqbVLJjFSnrHUaLUDHBxAx2J
        DP6uYFxBRY0BI9u/Mz+o8baPWJMqA2bYcFOIYiMN118gIMH2twE8hwHR+0crdqL51FEV+V/QqZBkU
        Hdv70Aeymlqi94y7LpZ5VelzI7DcQXJMOr95LJQaYuq9Zqoo2YTtMR/MU5eV/pL5CiWWzCctczM/o
        DBd9gzUMQ0QbAfAjKbQnJtmqVn42N4tEnLz7UvalJSZ2z3kJRDM7TTqIlrX0CryIGb9Hn987ZQhOg
        sE6aZBlqkpFRJk3dnFNMsC2I9KOVuppRzHwfn8z9a2qa+0O1dc0VYkuVxLN5tYYLAZojlKNwUO/cw
        1AzLNyiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo2KC-0004Cq-9D; Wed, 24 Jun 2020 10:08:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3AD79300261;
        Wed, 24 Jun 2020 12:08:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB40D20D94FEC; Wed, 24 Jun 2020 12:08:06 +0200 (CEST)
Date:   Wed, 24 Jun 2020 12:08:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        tglx@linutronix.de, davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com
Subject: Re: [PATCH v3 0/3] Preventing job distribution to isolated CPUs
Message-ID: <20200624100806.GE4800@hirez.programming.kicks-ass.net>
References: <20200623192331.215557-1-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623192331.215557-1-nitesh@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 23, 2020 at 03:23:28PM -0400, Nitesh Narayan Lal wrote:
> This patch-set is originated from one of the patches that have been
> posted earlier as a part of "Task_isolation" mode [1] patch series
> by Alex Belits <abelits@marvell.com>. There are only a couple of
> changes that I am proposing in this patch-set compared to what Alex
> has posted earlier.

> 
> Alex Belits (3):
>   lib: Restrict cpumask_local_spread to houskeeping CPUs
>   PCI: Restrict probe functions to housekeeping CPUs
>   net: Restrict receive packets queuing to housekeeping CPUs
> 
>  drivers/pci/pci-driver.c |  5 ++++-
>  lib/cpumask.c            | 16 +++++++++++-----
>  net/core/net-sysfs.c     | 10 +++++++++-
>  3 files changed, 24 insertions(+), 7 deletions(-)

This looks reasonable to me; who is expected to merge this? Should I
take it through the scheduler tree like most of the nohz_full, or what
do we do?

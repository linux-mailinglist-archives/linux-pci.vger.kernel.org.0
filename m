Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BB8210102
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 02:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgGAAcr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 20:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgGAAcr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 20:32:47 -0400
Received: from X1 (071-093-078-081.res.spectrum.com [71.93.78.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4403620771;
        Wed,  1 Jul 2020 00:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593563566;
        bh=Gb3KlTuWaOGWGE1Hbxb0Bp5nifCf6yHJW4gy9mIWqpg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N6wiuw9CNrj943TnC25HzHVfwVDUqfkTO9umUC7BnDi0GwsA6qQvOA1B3MOOeaYeH
         J2mwVukPEyUovq5ZioYa60MdMmj+7ZuZwfQYqMb2s0l6op2ZSzuYR+uvrNSaWSlEjO
         KFdL/I3qs8PKakRTLXAVdAeCArn82z62Nt3tmcb0=
Date:   Tue, 30 Jun 2020 17:32:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        peterz@infradead.org, frederic@kernel.org, mtosatti@redhat.com,
        juri.lelli@redhat.com, abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        tglx@linutronix.de, davem@davemloft.net, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        jinyuqi@huawei.com, zhangshaokun@hisilicon.com
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to
 houskeeping CPUs
Message-Id: <20200630173244.eef158fb09dca3cc1e2e63b1@linux-foundation.org>
In-Reply-To: <8054aff1-544d-80de-456f-c3e244233419@redhat.com>
References: <20200625223443.2684-1-nitesh@redhat.com>
        <20200625223443.2684-2-nitesh@redhat.com>
        <8054aff1-544d-80de-456f-c3e244233419@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 29 Jun 2020 12:11:25 -0400 Nitesh Narayan Lal <nitesh@redhat.com> wrote:

> 
> On 6/25/20 6:34 PM, Nitesh Narayan Lal wrote:
> > From: Alex Belits <abelits@marvell.com>
> >
> > The current implementation of cpumask_local_spread() does not respect the
> > isolated CPUs, i.e., even if a CPU has been isolated for Real-Time task,
> > it will return it to the caller for pinning of its IRQ threads. Having
> > these unwanted IRQ threads on an isolated CPU adds up to a latency
> > overhead.
> >
> > Restrict the CPUs that are returned for spreading IRQs only to the
> > available housekeeping CPUs.
> >
> > Signed-off-by: Alex Belits <abelits@marvell.com>
> > Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> 
> Hi Peter,
> 
> I just realized that Yuqi jin's patch [1] that modifies cpumask_local_spread is
> lying in linux-next.
> Should I do a re-post by re-basing the patches on the top of linux-next?
> 
> [1]
> https://lore.kernel.org/lkml/1582768688-2314-1-git-send-email-zhangshaokun@hisilicon.com/

This patch has had some review difficulties and has been pending for
quite some time.  I suggest you base your work on mainline and that we
ask Yuqi jin to rebase on that, if I don't feel confident doing it,


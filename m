Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12E450C7A8
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 07:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiDWFqe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 01:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiDWFqd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 01:46:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6D864716;
        Fri, 22 Apr 2022 22:43:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7331568AFE; Sat, 23 Apr 2022 07:43:32 +0200 (CEST)
Date:   Sat, 23 Apr 2022 07:43:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "brookxu.cn" <brookxu.cn@gmail.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, tglx@linutronix.de, frederic@kernel.org
Subject: Re: [RFC PATCH] nvme-pci: allowed to modify IRQ affinity in
 latency sensitive scenarios
Message-ID: <20220423054331.GA17823@lst.de>
References: <1650625106-30272-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650625106-30272-1-git-send-email-brookxu.cn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 22, 2022 at 06:58:26PM +0800, brookxu.cn wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> In most cases, setting the affinity through managed IRQ is a better
> choice. But in some scenarios that use isolcpus, such as DPDK, because
> managed IRQ does not distinguish between housekeeping CPU and isolated
> CPU when selecting CPU, this will cause IO interrupts triggered by
> housekeeping CPU to be routed to isolated CPU, which will affect the
> tasks running on isolated CPU. commit 11ea68f553e2 ("genirq,
> sched/isolation: Isolate from handling managed interrupts") tries to
> fix this in a best effort way. However, in a real production environment,
> latency-sensitive business needs more of a deterministic result. So,
> similar to the mpt3sas driver, we might can add a module parameter
> smp_affinity_enable to the Nvme driver.

This kind of boilerplate code in random drivers is not sustainable.

I really think we need to handle this whole housekeeping CPU case in
common code.  That is designed CPUs as housekeeping vs non-housekeeping
and let the generic affinity assignment code deal with it and solve
it for all drivers using the proper affinity masks instead of having
random slighty overrides in all drivers anyone ever wants to use in
such a system.

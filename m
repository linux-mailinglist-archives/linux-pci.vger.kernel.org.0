Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9C063236D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 14:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiKUN2b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 08:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiKUN2C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 08:28:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F7D9A5CB;
        Mon, 21 Nov 2022 05:28:00 -0800 (PST)
Date:   Mon, 21 Nov 2022 14:27:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669037279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZklvIesdxDmu7Qaf/ZiJjhEu1yDVY6FbfODT00EzTs=;
        b=jHhAbGIU73MpaMN6C4c9x0AtTJCHXZp5Cf00BYBrhSC+Ly7FFmzaJqhpCQpDBpb3AIHBLb
        fahaXVPu8tZUHnGU0qAl92sdYb5P0YBW4ntnVXWjAaBTnxwZ2ghHuEQ9GMsZjiHFVlfE/u
        nO++mU0Wk265n3LKz2wAxlNlVves/eyPuU2hZ/KLFIPHhqrZd7K7Ff/t5oMZjCtrjcKY1j
        aSxSHpPp8N6czJqlXBwTT2a+Kb1LaxHIWhrCmhBqn6pf68a/zJy32bQodg1vb68BIOiiF9
        4xL/d15rmNDaS5LnXrj94cMSK654/eaDT7pL+r5mpORW3YYUPnJ6acDt++d/kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669037279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZklvIesdxDmu7Qaf/ZiJjhEu1yDVY6FbfODT00EzTs=;
        b=ShpeAfvPGHu9rWHY0jctqqz6LnNPUUmyhwPfLv1gdlKXUOuraTJm1BKSNIIeigpMPhdLbI
        TXbBKmBfgKh4SuAA==
From:   "Ahmed S. Darwish" <darwi@linutronix.de>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-doc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] PCI/MSI: api: Use bullet lists in kernel-doc comments
Message-ID: <Y3t83uo/TZzxc1nL@lx-t490>
References: <20221121184100.0974cc35@canb.auug.org.au>
 <20221121101245.23544-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121101245.23544-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 21, 2022 at 05:12:45PM +0700, Bagas Sanjaya wrote:
>   * @flags:    One or more of:
> - *            %PCI_IRQ_MSIX      Allow trying MSI-X vector allocations
> - *            %PCI_IRQ_MSI       Allow trying MSI vector allocations
> - *            %PCI_IRQ_LEGACY    Allow trying legacy INTx interrupts, if
> - *                               and only if @min_vecs == 1
> - *            %PCI_IRQ_AFFINITY  Auto-manage IRQs affinity by spreading
> - *                               the vectors around available CPUs
> + *
> + *            * %PCI_IRQ_MSIX - Allow trying MSI-X vector allocations
> + *            * %PCI_IRQ_MSI - Allow trying MSI vector allocations
> + *
> + *            * %PCI_IRQ_LEGACY - Allow trying legacy INTx interrupts, if
> + *              and only if @min_vecs == 1
> + *
> + *            * %PCI_IRQ_AFFINITY - Auto-manage IRQs affinity by spreading
> + *              the vectors around available CPUs
...
> - *       meanings, depending on interrupt mode
> - *         MSI-X        the index in the MSI-X vector table
> - *         MSI          the index of the enabled MSI vectors
> - *         INTx         must be 0
> + *       meanings, depending on interrupt mode:
> + *
> + *         * MSI-X - the index in the MSI-X vector table
> + *         * MSI - the index of the enabled MSI vectors
> + *         * INTx - must be 0

Sorry for the trouble.

While at it, can we please keep the alignment in the original patch?
This is supposed to be pretty too for people who look at the C code
(most of the actual readers).

That is:

 + *
 + *            * %PCI_IRQ_MSIX     -  Allow trying MSI-X vector allocations
 + *            * %PCI_IRQ_MSI      -  Allow trying MSI vector allocations
 + *            * %PCI_IRQ_LEGACY   -  Allow trying legacy INTx interrupts, if
 + *              and only if @min_vecs == 1
 + *            * %PCI_IRQ_AFFINITY - Auto-manage IRQs affinity by spreading
 + *              the vectors around available CPUs

and:

> + *       meanings, depending on interrupt mode:
> + *
> + *         * MSI-X - the index in the MSI-X vector table
> + *         * MSI   - the index of the enabled MSI vectors
> + *         * INTx  - must be 0

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH

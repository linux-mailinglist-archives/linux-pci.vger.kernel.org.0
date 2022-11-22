Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66226334FA
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 06:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiKVF5R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 00:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiKVF4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 00:56:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D462EF00;
        Mon, 21 Nov 2022 21:56:35 -0800 (PST)
Date:   Tue, 22 Nov 2022 06:56:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669096593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QNTsxF40xWKZoDBnjmTlY9Dq7N5CAn/b84v7kd9HJBs=;
        b=cpGj0Q2ad8aMqVKTFWYLQYwfkPzgOa1KStujrZj32eBOhpAMRTc6PWKI7RLGXhB7ICjMhZ
        xRj28bG+MnmgBcURxgIc21H+YbZaJJ54SVKAd4ibNRu0obVS/LZcTkqPE4IwOleSJLKkVo
        e9wYSQNI+9C4IK6z9NVq6dZA1sQemWu9SUFQFfIxglMQJ9MhchKjulzziMIDa637ZFbcby
        1skN+bB2gWx7jSSHjKk1KzL1JOV7Mig0WsAHlMD2hRFgKNha7uvVFz/nCVrMzogkIxhYjc
        wOSR4gp/nyjDRdiLbdcnow7xaJE4x57KJZSUA5S5C1OkKWi1hYXCFHrMidJqrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669096593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QNTsxF40xWKZoDBnjmTlY9Dq7N5CAn/b84v7kd9HJBs=;
        b=WabF+tyHdg/1qLX6L+dAL0z3d6L4v5CfWJ/MZuSx5MTUt+zYE+Zhwg36VJbNUIIlhCIvgd
        r83qiB76K9H6RuCw==
From:   "Ahmed S. Darwish" <darwi@linutronix.de>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-doc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] PCI/MSI: api: Use bullet lists in kernel-doc comments
Message-ID: <Y3xkj/3G4JxgXlal@lx-t490>
References: <20221121184100.0974cc35@canb.auug.org.au>
 <20221121101245.23544-1-bagasdotme@gmail.com>
 <Y3t83uo/TZzxc1nL@lx-t490>
 <Y3xFV2IkUlRWPdCd@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3xFV2IkUlRWPdCd@debian.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 22, 2022 at 10:43:19AM +0700, Bagas Sanjaya wrote:
>
> For the list above, no, since if the alignment is kept, like:
>

NAK.

Below patch works properly on my side, no Sphinx errors and proper HTML
view, while still keeping proper-alignment in the C code.

Sorry, you're too focusing on the HTML side.

Making the C code readable, not just the HTML output, is quite
important.

=>

From: Bagas Sanjaya <bagasdotme@gmail.com>

Use bullet-list RST syntax for kernel-doc parameters' flags and
interrupt mode descriptions. Otherwise Sphinx produces "Unexpected
identation" errors and warnings.

Link: https://lore.kernel.org/r/20221121101245.23544-1-bagasdotme@gmail.com
Fixes: 5c0997dc33ac24 ("PCI/MSI: Move pci_alloc_irq_vectors() to api.c")
Fixes: 017239c8db2093 ("PCI/MSI: Move pci_irq_vector() to api.c")
Fixes: be37b8428b7b77 ("PCI/MSI: Move pci_irq_get_affinity() to api.c")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
[darwi@linutronix.de: Match subject-line with other subystem commits]
[darwi@linutronix.de: Remove verbose Sphinx log from commit log]
[darwi@linutronix.de: For C kernel-doc comments legibility, keep
 the flags and interrupt mode descriptions aligned.]
Acked-by: Ahmed S. Darwish <darwi@linutronix.de>
---

 drivers/pci/msi/api.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index dfcaa77108de..6c0c0f3ad3b8 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -209,12 +209,15 @@ EXPORT_SYMBOL(pci_disable_msix);
  * @min_vecs: minimum required number of vectors (must be >= 1)
  * @max_vecs: maximum desired number of vectors
  * @flags:    One or more of:
- *            %PCI_IRQ_MSIX      Allow trying MSI-X vector allocations
- *            %PCI_IRQ_MSI       Allow trying MSI vector allocations
- *            %PCI_IRQ_LEGACY    Allow trying legacy INTx interrupts, if
- *                               and only if @min_vecs == 1
- *            %PCI_IRQ_AFFINITY  Auto-manage IRQs affinity by spreading
- *                               the vectors around available CPUs
+ *
+ *            * %PCI_IRQ_MSIX      Allow trying MSI-X vector allocations
+ *            * %PCI_IRQ_MSI       Allow trying MSI vector allocations
+ *
+ *            * %PCI_IRQ_LEGACY    Allow trying legacy INTx interrupts, if
+ *              and only if @min_vecs == 1
+ *
+ *            * %PCI_IRQ_AFFINITY  Auto-manage IRQs affinity by spreading
+ *              the vectors around available CPUs
  *
  * Allocate up to @max_vecs interrupt vectors on device. MSI-X irq
  * vector allocation has a higher precedence over plain MSI, which has a
@@ -299,10 +302,11 @@ EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
  * pci_irq_vector() - Get Linux IRQ number of a device interrupt vector
  * @dev: the PCI device to operate on
  * @nr:  device-relative interrupt vector index (0-based); has different
- *       meanings, depending on interrupt mode
- *         MSI-X        the index in the MSI-X vector table
- *         MSI          the index of the enabled MSI vectors
- *         INTx         must be 0
+ *       meanings, depending on interrupt mode:
+ *
+ *         * MSI-X     the index in the MSI-X vector table
+ *         * MSI       the index of the enabled MSI vectors
+ *         * INTx      must be 0
  *
  * Return: the Linux IRQ number, or -EINVAL if @nr is out of range
  */
@@ -322,10 +326,11 @@ EXPORT_SYMBOL(pci_irq_vector);
  * pci_irq_get_affinity() - Get a device interrupt vector affinity
  * @dev: the PCI device to operate on
  * @nr:  device-relative interrupt vector index (0-based); has different
- *       meanings, depending on interrupt mode
- *         MSI-X        the index in the MSI-X vector table
- *         MSI          the index of the enabled MSI vectors
- *         INTx         must be 0
+ *       meanings, depending on interrupt mode:
+ *
+ *         * MSI-X     the index in the MSI-X vector table
+ *         * MSI       the index of the enabled MSI vectors
+ *         * INTx      must be 0
  *
  * Return: MSI/MSI-X vector affinity, NULL if @nr is out of range or if
  * the MSI(-X) vector was allocated without explicit affinity
--
2.38.1

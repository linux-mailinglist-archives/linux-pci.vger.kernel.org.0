Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41426DA1D2
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 21:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjDFTqd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 15:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDFTqc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 15:46:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8383DFF;
        Thu,  6 Apr 2023 12:46:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680810390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=77vIMcrU+91zXs0NeSN3g0pNEiGDOVtOUc7dZTKdVsY=;
        b=FQUFheAv7NzNQ0S+NH40CLVmxxY2SyQ8b17hNqO4EljOKnPbQPPzFy+zlWku6aQ7wukro3
        sXTMMq6pA/DsKx6zprDilpXlT7LMBUZbSp9c202Tnty3ht3QAvL5hvb+riQs+kW2ab1PXt
        X9bbtjteFg7xp9qXttltkqh3ZWof+X8y6IH2WpEQGRRTUueH7In3sFpq94Tck6WYk5xLSj
        7lvpDz/3SUGEdvE1th1d1IZE7fM3wBNggR+J4xML/MGd6wXa09dO7J+lXP09d+818lVcCz
        t6w63L60Vs3KQcsGuLFRUCSp+FygjxcA+7sLJ1JBozZXOJkOKydRVirGGuhVgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680810390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=77vIMcrU+91zXs0NeSN3g0pNEiGDOVtOUc7dZTKdVsY=;
        b=1ulrUTHUxWarWSQQALjgGN5D7LRkd8/uB0t4itsuI+sUD3/BPHvL6ntoHsIUYsiiZYxxpX
        wQnY1YacIFxFvnBg==
To:     Bjorn Helgaas <helgaas@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: revert bab65e48cb064 PCI/MSI Sanitize MSI-X checks
In-Reply-To: <20230406150742.GA3703273@bhelgaas>
References: <20230406150742.GA3703273@bhelgaas>
Date:   Thu, 06 Apr 2023 21:46:29 +0200
Message-ID: <87edowrdyi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 06 2023 at 10:07, Bjorn Helgaas wrote:
> On Thu, Apr 06, 2023 at 11:05:14AM +0000, David Laight wrote:
> Thanks for the report!  bab65e48cb06 ("PCI/MSI: Sanitize MSI-X
> checks") appeared in v6.2-rc1, so this is a recent regression and it
> would be good to fix it for v6.3.
>
> bab65e48cb06 only touches drivers/pci/msi/msi.c, but since it didn't
> go through the PCI tree, I'll let Thomas handle any revert (or better,
> an improvement to pci_msix_validate_entries()) since he wrote and
> applied the original.

Right. The fix is trivial as the hardware size check in this validation
function is pointless.

The point is that for a range allocation with and entries array, _all_
entries up to max_vec must be correct independent of the actual hardware
size.

So the fix is simply removing the hardware size check from the
validation function.

The hardware size checking happens afterwards anyway.

Thanks,

        tglx
---
 drivers/pci/msi/msi.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -750,8 +750,7 @@ static int msix_capability_init(struct p
 	return ret;
 }
 
-static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry *entries,
-				      int nvec, int hwsize)
+static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry *entries, int nvev)
 {
 	bool nogap;
 	int i, j;
@@ -762,10 +761,6 @@ static bool pci_msix_validate_entries(st
 	nogap = pci_msi_domain_supports(dev, MSI_FLAG_MSIX_CONTIGUOUS, DENY_LEGACY);
 
 	for (i = 0; i < nvec; i++) {
-		/* Entry within hardware limit? */
-		if (entries[i].entry >= hwsize)
-			return false;
-
 		/* Check for duplicate entries */
 		for (j = i + 1; j < nvec; j++) {
 			if (entries[i].entry == entries[j].entry)
@@ -805,7 +800,7 @@ int __pci_enable_msix_range(struct pci_d
 	if (hwsize < 0)
 		return hwsize;
 
-	if (!pci_msix_validate_entries(dev, entries, nvec, hwsize))
+	if (!pci_msix_validate_entries(dev, entries, nvec))
 		return -EINVAL;
 
 	if (hwsize < nvec) {

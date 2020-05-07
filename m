Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF001C9A43
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 21:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEGTBS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 15:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGTBS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 15:01:18 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F2912083B;
        Thu,  7 May 2020 19:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588878077;
        bh=Bd9ng0ejT5N0guis1pv/eylwB+4g3fX/7CGGNiSv4ns=;
        h=Date:From:To:Cc:Subject:From;
        b=K9d07fSnZ94nYK4zmbNDVzIrF6tgyErVnZUYBrXhugNE/ywoecfMuGXt9YpBaXCQC
         HtAZHWFFviBG1b8/8rkAWY3CaQxa9ZCM20CFYZQHTWL4DUWXFYrELuqcOr50D3wckM
         DUH3q20sCUwcbSd18JfFmWd9/EW7iqTl/itSkzVQ=
Date:   Thu, 7 May 2020 14:05:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Replace zero-length array with flexible-array
Message-ID: <20200507190544.GA15633@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/pci/pci.c   |    2 +-
 include/linux/pci.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 595fcf59843f..bb78f580814e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1578,7 +1578,7 @@ EXPORT_SYMBOL(pci_restore_state);
 
 struct pci_saved_state {
 	u32 config_space[16];
-	struct pci_cap_saved_data cap[0];
+	struct pci_cap_saved_data cap[];
 };
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cdf5676..0453ee458ab1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -279,7 +279,7 @@ struct pci_cap_saved_data {
 	u16		cap_nr;
 	bool		cap_extended;
 	unsigned int	size;
-	u32		data[0];
+	u32		data[];
 };
 
 struct pci_cap_saved_state {
@@ -532,7 +532,7 @@ struct pci_host_bridge {
 			resource_size_t start,
 			resource_size_t size,
 			resource_size_t align);
-	unsigned long	private[0] ____cacheline_aligned;
+	unsigned long	private[] ____cacheline_aligned;
 };
 
 #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)


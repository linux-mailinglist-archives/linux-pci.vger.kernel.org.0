Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A097B49A7
	for <lists+linux-pci@lfdr.de>; Sun,  1 Oct 2023 23:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjJAVJJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Oct 2023 17:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjJAVJJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Oct 2023 17:09:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B54CBF;
        Sun,  1 Oct 2023 14:09:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F79C433C7;
        Sun,  1 Oct 2023 21:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696194546;
        bh=KlpsTUbvJ/T3JQMeSxp6/dgvFP7eP+U9AV1bcVV6PP0=;
        h=Date:From:To:Cc:Subject:From;
        b=IkTJexmQrS6lFMoEvE68sJw8EwkmmMhbHx0qcxU8M9m3i6FnVbp5hSSh3YNxhwG7s
         VJ0NroEzoyK+n+dKuNwwvnruRe0hioND27AReoy80kzCUM9Tqwmop46j1H1G5qUzb2
         mWiTPlTEgfq6Tz8ZqRnNrxJKmDbMs4PexTD3XY3aJ3Zaig4Rqa3JHDpS7pRuvvpMBC
         AG/T3jo+VqFuPR/Tm9bwNeGH+jh3a0b20qVGjfDdDg8i5UmfJIWLB9QPpXJW8rO0Gl
         Qc7ODBciOQHZz+ziLfmv91qrXKdXgjBrloxAGWo/H8HWFnFM9t0vmWEny/zXiCw6zz
         oHGNIqbElVGJA==
Date:   Sun, 1 Oct 2023 23:08:59 +0200
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] PCI/P2PDMA: Fix undefined behavior bug in struct
 pci_p2pdma_pagemap
Message-ID: <ZRnf6wVOu0IJQ2Ok@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

`struct dev_pagemap` is a flexible structure, which means that it
contains a flexible-array member at the bottom. This could potentially
lead to an overwrite of the objects following `pgmap` in `struct
pci_p2pdma_pagemap`, when `nr_range > 1`.

Fix this by placing the declaration of object `pgmap` at the end of
`struct pci_p2pdma_pagemap`.

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

Fixes: 0afea3814358 ("PCI/P2PDMA: Add provider's pci_dev to pci_p2pdma_pagemap struct")
Fixes: a6e6fe6549f6 ("PCI/P2PDMA: Introduce private pagemap structure")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/pci/p2pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index fa7370f9561a..ab34d3d36a64 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -28,9 +28,9 @@ struct pci_p2pdma {
 };
 
 struct pci_p2pdma_pagemap {
-	struct dev_pagemap pgmap;
 	struct pci_dev *provider;
 	u64 bus_offset;
+	struct dev_pagemap pgmap;
 };
 
 static struct pci_p2pdma_pagemap *to_p2p_pgmap(struct dev_pagemap *pgmap)
-- 
2.34.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99B07B5ACF
	for <lists+linux-pci@lfdr.de>; Mon,  2 Oct 2023 21:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbjJBTEY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Oct 2023 15:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbjJBTEX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2023 15:04:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E540AC;
        Mon,  2 Oct 2023 12:04:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B99C433C9;
        Mon,  2 Oct 2023 19:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696273460;
        bh=VEsg6fqTYDhVGFa0jJFgmDsU8/UVfT6A/kgPl1u/lKg=;
        h=Date:From:To:Cc:Subject:From;
        b=QF68u+gMvrufyxKFrnkBWEMr0/SzIT2kIX44C9Mo0AZB2WHDANcLRhPD3Ge7Whh81
         s/argLonEHJVRZu4OnmpvlpQMlad4AHnzvOGTN9YsMF9UAQdYNF1Aa69gyZJ5aGFpA
         kQ+/DP/j/lSjkIrY2i34ifMUrkMrSxISkfiB1V9dDo7iPzH0mwlKuRn6kYhcf0Yk67
         LZWolKmOQbIvzX/wL2//a9Fbe508gumHrFqp1kcf8av3dMjgBLSzpLeWYrtzqdZVp/
         a5CNv3ruL7MoM55v+p3K316nThNK2MT2WWTxLuttyS1j0gWsM+tWksFg4asxAdLW6X
         nbXHL5DhWNykA==
Date:   Mon, 2 Oct 2023 21:04:15 +0200
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] PCI/P2PDMA: Fix potential undefined behavior bug in
 struct pci_p2pdma_pagemap
Message-ID: <ZRsUL/hATNruwtla@work>
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
pci_p2pdma_pagemap`, when `nr_range > 1`. This is currently not the
case (notice that `nr_range` is hardcoded to `1`), however as commit
b7b3c01b1915 ("mm/memremap_pages: support multiple ranges per invocation")
mentions in the subject line, this code can `support multiple
ranges per invocation`. So, we'd better prevent any problems that may
arise in the future.

Fix this by placing the declaration of object `pgmap` at the end of
`struct pci_p2pdma_pagemap`.

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Remove `Fixes:` tags. (Logan Gunthorpe)
 - Update changelog text. Make it clear that `nr_range` is hardcoded to `1`
   (Logan Gunthorpe)
 - Update subject.
 - Add Logan's RB.

v1:
 Link: https://lore.kernel.org/linux-hardening/ZRnf6wVOu0IJQ2Ok@work/

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


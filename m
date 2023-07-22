Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B8275DF4B
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jul 2023 01:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGVXZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jul 2023 19:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGVXZP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jul 2023 19:25:15 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D501119A6
        for <linux-pci@vger.kernel.org>; Sat, 22 Jul 2023 16:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ZI1rx+BD/ilin0/NRtZDSz3iiOgdzXGOIXLdu8xHh9Q=; b=ATVLvw/4vffWNT0C0kA/6d1Cwu
        rC4TgYZAS3Dsm6BA+Xjn8nctjNVRfc8WOv2GOUYZjncfUy9wglN8XEFcS1dDgEieQ3JnUMPzqRiwW
        1i/E8ylSASwInBI7SSV1zj6oRhsegFkcx5jlwpqYQRoW4qnoAUY8S75QzMdNjk1IdLTikNveUOdiV
        KVrDMM2gC7QAuYgkM3K19uyJVpMlKmerB24hP5PyRDGxLcv8ZxAUaXbFM2084tAefm7G7nLo3nTcK
        xkRkWdF8B6tqAB/XozVygkbUxHvBqB33mDurHUJUvVr73saagyPtv3Fbw3j67LUsvF0HdXCVTKnVS
        1mcpPH/g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1qNLj4-0001Hu-KT; Sun, 23 Jul 2023 01:09:26 +0200
Received: from [136.25.87.181] (helo=lars-desktop.lan)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1qNLj3-000OAF-V0; Sun, 23 Jul 2023 01:09:26 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org,
        mhi@lists.linux.dev, ntb@lists.linux.dev,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] PCI: endpoint: pci-epf-ntb: Constify pci_epf_ops
Date:   Sat, 22 Jul 2023 16:08:46 -0700
Message-Id: <20230722230848.589428-3-lars@metafoo.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230722230848.589428-1-lars@metafoo.de>
References: <20230722230848.589428-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26977/Sat Jul 22 09:27:56 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_epf_ops struct for the PCI endpoint ntb driver is never modified.
Mark it as const so it can be placed in the read-only section.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 9aac2c6f3bb9..630181469720 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -2099,7 +2099,7 @@ static int epf_ntb_probe(struct pci_epf *epf,
 	return 0;
 }
 
-static struct pci_epf_ops epf_ntb_ops = {
+static const struct pci_epf_ops epf_ntb_ops = {
 	.bind	= epf_ntb_bind,
 	.unbind	= epf_ntb_unbind,
 	.add_cfs = epf_ntb_add_cfs,
-- 
2.39.2


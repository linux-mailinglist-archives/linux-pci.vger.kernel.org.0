Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE1575DF4D
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jul 2023 01:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjGVXZ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jul 2023 19:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGVXZ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jul 2023 19:25:26 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39DA19A6
        for <linux-pci@vger.kernel.org>; Sat, 22 Jul 2023 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=HcEhnsl8OXwy3Xs9hLEzxmJ6HcVgVNWkjJo3dbzOO5Q=; b=IVCPKHEh+ttWqGkq+pTDFKeIkB
        AIbC1xsqR9iS+vKzOcA3M3iPtH2a5ApleaLZEDylT6fXXXfyvbFEGZehKS44Tua43niJlbFniDkEy
        j2F/TvC/ZNNHKCiXteZ0YylnwNKg6lHYY8wWdRzeQSexTTEAoq7ZQB9G+gXEwb1OHhu27zUz5N0iv
        q8epuJzT5GmQwV3RSZUR012s9hkT75HzyxrF3pXZNnXgIyAvL4dW74yUnmzzUL7SejWHK4chdjmFH
        GxWHHp4tVmpU16vr73dnYuDdK+MBZVnY8sJ3M3SIuVSFlcqpXnggp66gcRHTGv2YweWjsfSdfymBn
        3Vx+eLRw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1qNLj7-0001I7-0k; Sun, 23 Jul 2023 01:09:29 +0200
Received: from [136.25.87.181] (helo=lars-desktop.lan)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1qNLj6-000OAF-Bw; Sun, 23 Jul 2023 01:09:28 +0200
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
Subject: [PATCH 4/5] PCI: endpoint: pci-epf-vntb: Constify pci_epf_ops
Date:   Sat, 22 Jul 2023 16:08:47 -0700
Message-Id: <20230722230848.589428-4-lars@metafoo.de>
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

The pci_epf_ops struct for the PCI endpoint vntb driver is never modified.
Mark it as const so it can be placed in the read-only section.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c8b423c3c26e..ff4b43af4487 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1387,7 +1387,7 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 }
 
 // EPF driver probe
-static struct pci_epf_ops epf_ntb_ops = {
+static const struct pci_epf_ops epf_ntb_ops = {
 	.bind   = epf_ntb_bind,
 	.unbind = epf_ntb_unbind,
 	.add_cfs = epf_ntb_add_cfs,
-- 
2.39.2


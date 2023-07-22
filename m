Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3CA75DF4F
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jul 2023 01:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjGVXZg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jul 2023 19:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGVXZg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jul 2023 19:25:36 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4729319AA
        for <linux-pci@vger.kernel.org>; Sat, 22 Jul 2023 16:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=16+9MAyNoSQKEieZmAwZixbnYFiVC7jOK/H2DuJG9OY=; b=kzYeoRuJyrp7az29WjCNbamE24
        VUOHmHAi2iRhMrOUd+bC/B/ELjhvJbQQ6wAc2DuGSzJ1uO/VFoWMIJ+tiaNgItxl/9rvce9QsU+vm
        KMiadrmYiI+km/8oDovA5lwOvqZ0U1UPHSQPDXCHlB0j51NLlxJEEkdHDE2tfG9XhQ9bVB39uDf3U
        1SvONzc3XQrLcD3PoquU0UegmwKvxhzAtq+bVjXV7ozyaoYub8cs6bm3ANHzg2TrbXWLhQ/oGqqK8
        13u5mOHkJbeTqVn2I56ZgVcjqcUBH223nRReaxY7Vog2l8R8G8GBrfAGZMhQx/hbzbdgAWSirhYA7
        IcDYI2Dw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1qNLj9-0001IJ-FZ; Sun, 23 Jul 2023 01:09:31 +0200
Received: from [136.25.87.181] (helo=lars-desktop.lan)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1qNLj8-000OAF-PI; Sun, 23 Jul 2023 01:09:31 +0200
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
Subject: [PATCH 5/5] PCI: endpoint: pci-epf-test: Constify pci_epf_ops
Date:   Sat, 22 Jul 2023 16:08:48 -0700
Message-Id: <20230722230848.589428-5-lars@metafoo.de>
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

The pci_epf_ops struct for the PCI endpoint test driver is never modified.
Mark it as const so it can be placed in the read-only section.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 1f0d2b84296a..7cc1c5c70afc 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -973,7 +973,7 @@ static int pci_epf_test_probe(struct pci_epf *epf,
 	return 0;
 }
 
-static struct pci_epf_ops ops = {
+static const struct pci_epf_ops ops = {
 	.unbind	= pci_epf_test_unbind,
 	.bind	= pci_epf_test_bind,
 };
-- 
2.39.2


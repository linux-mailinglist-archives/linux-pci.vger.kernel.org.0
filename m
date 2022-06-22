Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C2D554132
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 06:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356662AbiFVEJq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 00:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356415AbiFVEJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 00:09:44 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D1533E12
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 21:09:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cv13so12184443pjb.4
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 21:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8a9fQe0ScUZXLADDjkAaIEciBfbUGtcUKGKu69KZMM4=;
        b=7a9sqZhMOrv9d1Jj341zLdUTERsmX6EN2EHXL/bVu+aZI0rYc7SwMfe5uAzleJE7AC
         KTT5ZW8437miJClVcneVmWBI284Oy/5EQ1tvhWhvDOGgZEO1r+Hg1y2h49B+YQQkJ3Gw
         PdiF7Ex6AkO31fCwcw2KzlKgKoUmHDuKSbs9izymzbHBQDd3TvW5cv73P4hCK43B4V0S
         XeVeCgQbsH7UjGoO1aEsCNCk0BLL/c8L6LGcXVPtOIuH1y3cTD/tS+diI+hFFYCgZBDn
         pF7mpXS9cn7iRet5TtZGWq76Mcrp+nN/JWsDNCQ4CFxCExFHiufGsOkoif/neF97AXKL
         62Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8a9fQe0ScUZXLADDjkAaIEciBfbUGtcUKGKu69KZMM4=;
        b=NsTtcs5B8/mumlH/o5CDg+ZQGUrWXRZGxVkFdqeZ47VAKisCcaJSUmnHxZC8+pS/Do
         4ncaxlN+nYemqDQPGWyL6bHt3X9OBU5tVjGFxb6lRGcqAt8iWMZ8MEnPdtluC0DJdz6i
         Rj+IqUpTPARdkC/78uy1miD241lzZ8K7hn0oncNT7OKf2DUxNH+D/H5Eiw3zhQ7LdbAh
         h9WOKXUu6MQnioy1+Q0u5eWfhPbZoQNUG7ac5DkaFKSgibdm1r958RvcJD3F1SmRFbpX
         cq6zpZiR2Zp1B8umtaZ+2Zq7Nls0g4oBRahLvpmpNd9MBuVK1N9xXErqhsuUP5HdcNo/
         cc1A==
X-Gm-Message-State: AJIora8RsZeBw+eOF6Ic1pkffSLkOGYGse/XfodaYJMRFLYo4rLIlxOw
        mfvHhg5ebJJf2AF0mx5gMxorLg==
X-Google-Smtp-Source: AGRyM1vL1GLWjsczHaaLN5PR2rW/9O0ybvtd8lSdJZdNWzfrMKxeLJnajmjkvuQO/HjOZY2VZaAzMQ==
X-Received: by 2002:a17:902:728f:b0:168:b18e:9e0d with SMTP id d15-20020a170902728f00b00168b18e9e0dmr31386280pll.174.1655870982569;
        Tue, 21 Jun 2022 21:09:42 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id p19-20020a639513000000b0040ceac94813sm2853749pgd.67.2022.06.21.21.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:09:41 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski=20?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Chen <lchen@ambarella.com>, Shunsuke Mie <mie@igel.co.jp>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Don't stop EP controller by EP function
Date:   Wed, 22 Jun 2022 13:09:24 +0900
Message-Id: <20220622040924.113279-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For multi-function endpoint device, an ep function shouldn't stop EP
controller. Nomally the controller is stopped via configfs.

Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function to test PCI")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 5b833f00e980..a5ed779b0a51 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -627,7 +627,6 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 
 	cancel_delayed_work(&epf_test->cmd_handler);
 	pci_epf_test_clean_dma_chan(epf_test);
-	pci_epc_stop(epc);
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		epf_bar = &epf->bar[bar];
 
-- 
2.17.1


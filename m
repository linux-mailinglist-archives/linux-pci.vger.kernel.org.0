Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C4B6A4C10
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 21:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjB0UNt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 15:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjB0UNs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 15:13:48 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCE7E047
        for <linux-pci@vger.kernel.org>; Mon, 27 Feb 2023 12:13:45 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536d63d17dbso163523277b3.22
        for <linux-pci@vger.kernel.org>; Mon, 27 Feb 2023 12:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677528824;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nmlIErxvJ/qbv99e3RyuUqGXVI43bD2n1Gm1fevJHfs=;
        b=JVf0+K1AQOjlsWVWOWXtCxpV0Z8nZHCt5dVb6dPFPeJURIcwKMkRhuq0xW/IuuVF1M
         MeIKjPnsLuBNAi6JoLrgrGpKfch9k8Vm8UMD0I+Bexp9AZOijRX5l6TfuP3Xuk9TlCZh
         yj26F+7Y1XVQkFg0dES0YvxftYgFavXCGpEVprROjKOH7AdaSxrS4+TvdPCjhX+uziyJ
         I9ipWb81c9MJHZuDdTbxZ/9GTq8mBtx/MIQur8Rlj/IkK1WfvbpU/VDOuQymbqNph6Us
         uv9Vc/LKrvsv3zKprmLsNNGT6X69oawK634jP5ymtngc3zdxriXocdJ7C73O2WfyAe6q
         kltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677528824;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmlIErxvJ/qbv99e3RyuUqGXVI43bD2n1Gm1fevJHfs=;
        b=sNMOPFQshIrhj8AhPdl0LmAHga+Cu0dXGl/wC721dnnR483NNHUiPbySnbvM8D3Tk8
         Olj/n77DmTp/Tjd97K9CePckrXmRrifAAWxizcetxdVVy+kiEgBQK1ZhUYlfQ3+gRlOJ
         s1mE+BvZlHsZioLda/7Ey2jlKdFFKm0OKDlcuZ6AIjOnaRlT2/K2+eViVPaZG/Dr6WBM
         UDvr/tXlkmm0Mp8QGwm5IGS+qugKkD5PLyPo5c4FBWEz+CIeDQJd2MPFPFuES221VSnZ
         h/4Nltd7ScObGJyof+8sKuBXvY2dhz7K1HWih/guTsiMJdAXg02sjgk4zhaSEV+dYXp3
         CpWA==
X-Gm-Message-State: AO0yUKWMxNF73wlu/4JJs/9DqkUOslkNam2m3wwhRl2PwSU9m35hgKg/
        rWHuIo29waVwr9vL/957qBu+vYXSbqk=
X-Google-Smtp-Source: AK7set/i7+SV2BqlyMgd56xCPTNGI+GszPhqzhymtNC5SLiEuwVk3Xe2jSYLnErdIdnQrhZodOdEfIzdaWY=
X-Received: from sdalvi-android.chi.corp.google.com ([2620:15c:2:a:d5ec:77cd:bac0:2239])
 (user=sdalvi job=sendgmr) by 2002:a81:ae43:0:b0:52e:b48f:7349 with SMTP id
 g3-20020a81ae43000000b0052eb48f7349mr11136237ywk.6.1677528824505; Mon, 27 Feb
 2023 12:13:44 -0800 (PST)
Date:   Mon, 27 Feb 2023 14:13:40 -0600
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227201340.2087605-1-sdalvi@google.com>
Subject: [PATCH v2] PCI: dwc: Wait for link up only if link is started
From:   Sajid Dalvi <sdalvi@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Sajid Dalvi <sdalvi@google.com>, kernel-team@android.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In dw_pcie_host_init() regardless of whether the link has been started
or not, the code waits for the link to come up. Even in cases where
start_link() is not defined the code ends up spinning in a loop for 1
second. Since in some systems dw_pcie_host_init() gets called during
probe, this one second loop for each pcie interface instance ends up
extending the boot time.

Call trace when start_link() is not defined:
dw_pcie_wait_for_link << spins in a loop for 1 second
dw_pcie_host_init

Signed-off-by: Sajid Dalvi <sdalvi@google.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819..9709f69f173e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -489,10 +489,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		ret = dw_pcie_start_link(pci);
 		if (ret)
 			goto err_remove_edma;
-	}
 
-	/* Ignore errors, the link may come up later */
-	dw_pcie_wait_for_link(pci);
+		/* Ignore errors, the link may come up later */
+		dw_pcie_wait_for_link(pci);
+	}
 
 	bridge->sysdata = pp;
 
-- 
2.39.2.722.g9855ee24e9-goog


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD946D6AD3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 19:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjDDRl5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 13:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjDDRl4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 13:41:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A884DAF
        for <linux-pci@vger.kernel.org>; Tue,  4 Apr 2023 10:41:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c67-20020a254e46000000b00b88f1fd158fso4714384ybb.17
        for <linux-pci@vger.kernel.org>; Tue, 04 Apr 2023 10:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680630115;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oPoPIuqgLuTvwyYpu86xIAI8ibbCU+bB6C79MUB9j+M=;
        b=KgLZbKw3X6e6U8+nWN1rfvhJn9IeJcusdWGqGWkC/wl037qByxfXikUpJgxyjwLJRu
         82cjYbSNmK/jZ+WnEj2icei2DTo69PcUpoWHAERCvk/MrL0juD0gzXgkWGSfCTC/Pg9T
         coNrhoxfCCXtlRjcoAg9nJ2EgutzMaj9ULngAg21IMRKH6p61RV0iEB+yDvA5MZsHQKP
         g9gGuDgCVkA1y5Mnd2aNR8f3jQohGldj6ekx4AVpvBs6MDNoGJvPjCTg1bjKZctHYjIN
         4B0Av/xb0TiuWvIDxG1PftsIbSic3cNhI9vbIfVHHzEHU++TtIwKR1P4SFQ3EEYIyh+B
         ssdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680630115;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oPoPIuqgLuTvwyYpu86xIAI8ibbCU+bB6C79MUB9j+M=;
        b=Rz9siU+OQGyUviRLEw9uYOmPRKbtpBaT3MeXfBdCyCatV5fzQsMC0GUfcF8zwT5upd
         PLOHqXIyce3jH9s3y3xhFAileuz429cUjHGybAc5Sm5iQWEr82KDI3GmlheSPGUVewPG
         +R79EuMVZAqN/MetokUIHz8hTOTJ8Bx0A0v8ZZ8kx9QoYcUUJIxs8HydiCpxSHhbOOzF
         3eOissYDZlBb10YT9zRo99Z7Sf6/8C3b1HbhrtJD/BO1RIneNTRa9q/7yYe7SwVyYwzE
         MAiPzKuSpYQPfkt7qsxyUk8OFoYVwKaWLXTvCAy+Yrn2RYPjhjTGJox24PQeCFybr8Sv
         X5jQ==
X-Gm-Message-State: AAQBX9eBnJ1fGCylp0rINEmZUfTXux4Ma+O18KRaZm9Wt+Yc6katfIlh
        H9BBcLrFWB6aTzg8A7m/Z9nzTL7Y3JLLw84ZSw==
X-Google-Smtp-Source: AKy350aebtC2Ba6s2QThXX/LN5u2aT1mEgmtjtPie5DIeXRT8bOOlSsBAeWAxCfuQbQ36MkSqtcXDNnczcG42uwKXw==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:cb8d:0:b0:b72:fff0:2f7f with SMTP
 id b135-20020a25cb8d000000b00b72fff02f7fmr81206ybg.4.1680630114943; Tue, 04
 Apr 2023 10:41:54 -0700 (PDT)
Date:   Tue,  4 Apr 2023 23:11:41 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230404174141.4091634-1-ajayagarwal@google.com>
Subject: [PATCH] PCI: dwc: Allow platform driver to skip the wait for link
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Rob Herring <robh@kernel.org>, nikhilnd@google.com,
        manugautam@google.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently as a part of device probe, the driver waits for the
link to come up for up to 1 second. If the link training is not
enabled by default or as a part of host_init, then this wait for
the link can be skipped to save the 1 second of wait time.

Allow the platform driver to skip this wait for the link up by
setting a flag `skip_wait_for_link`. This flag will be false by
default, thereby preserving the legacy behavior for existing
platform drivers.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++++--
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819..3425eb17b467 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -491,8 +491,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_remove_edma;
 	}
 
-	/* Ignore errors, the link may come up later */
-	dw_pcie_wait_for_link(pci);
+	/*
+	 * If the platform driver sets `skip_wait_for_link` because it knows the
+	 * link will not be up, do not wait for it. Save 1 sec of wait time.
+	 * Else, test for the link. Ignore errors, the link may come up later
+	 */
+	if (!pp->skip_wait_for_link)
+		dw_pcie_wait_for_link(pci);
 
 	bridge->sysdata = pp;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 79713ce075cc..f8f6dad5c948 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -297,6 +297,7 @@ struct dw_pcie_host_ops {
 struct dw_pcie_rp {
 	bool			has_msi_ctrl:1;
 	bool			cfg0_io_shared:1;
+	bool			skip_wait_for_link:1;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
 	u32			cfg0_size;
-- 
2.40.0.348.gf938b09366-goog


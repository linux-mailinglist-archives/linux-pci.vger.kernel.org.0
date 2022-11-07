Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E213261F7AF
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 16:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiKGPcG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 10:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiKGPcE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 10:32:04 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D17E1F9D6;
        Mon,  7 Nov 2022 07:32:04 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id b11so10920472pjp.2;
        Mon, 07 Nov 2022 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZs6+8Cv8xWSPLX0Qi/Fzkt7aGwFHCvaqnCns2dt4ww=;
        b=kq1tirL/q/Rt3zlWfS2mBj0DhFo6mQZihF3KKzgY8JayWJDl/BRHOgMxk0eMXeV/IG
         p1ykC0yxcCQwC0qADvGNLmg+YNmw6b7JwdNR2DH232OQejpRYxPnTAPusk1qPoKA9PT8
         JjiwFDfAho0y2PN3VvybhhBVLF6Raf//lkIWBvlBAUTu45pOjsX+EuN4ZqjhcAjB30xp
         +s8TYOFSxcbi2ZYkCTqJpEk03BNvXhgf1d3+htmJnZ582m+E9cdxeIbp6FHcHM8suYNc
         70M8K8wqfFQbfrGJDnvonNgRfqE8yBlPiqjYSUlWggTf98oeZ6tx5BI080i+iWiMETOB
         fBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZs6+8Cv8xWSPLX0Qi/Fzkt7aGwFHCvaqnCns2dt4ww=;
        b=xk3OaACBWaljM7q5f2OhQzx8zPcNJsN2lezNNizVy0UxH3RfymcBy29w2npIvan2s0
         CaWCYeM6LhL/vChDDHrrjzaAmDCUeBPWpLT5Zp74cGt16MxDrmnvtzvBIda/jrRzWEtJ
         LgzfUnoBN8Ar+x6+KLRPiJN8q7RDRdf3G2lFV60YjRm9R1Bxi1cf+EuCula8IvoLfqI1
         8P1J8YVxbdlgDmWbn3J7VKpxXdsBMBR5X3/3Bbhmqtqh0jyE7Vq0ln6BwP3N0vPbpM5z
         a7NEvGj1rl0Eg+bg3qKO4yFvlvxY5HWjWLlIjqV5KdSml4sIaxzeOBoNALpLnNe05987
         5MKA==
X-Gm-Message-State: ACrzQf3x0XWgZRyYg6wBBkuzX+SL5iVirhegyRxUucv6DRij0cv2fkqo
        492hGcvRSEVwvXW+6iSrW8w=
X-Google-Smtp-Source: AMsMyM7+bEs1K6hPHyWAboG/pBYceVbCj2JlGjW/S4S9NkMToyenmq/pX00pHk8BjJQX5YriWrdqWQ==
X-Received: by 2002:a17:902:a383:b0:187:34f6:439d with SMTP id x3-20020a170902a38300b0018734f6439dmr35090489pla.35.1667835123572;
        Mon, 07 Nov 2022 07:32:03 -0800 (PST)
Received: from junjun.localdomain ([113.140.248.157])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b00180a7ff78ccsm5139343plg.126.2022.11.07.07.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:32:03 -0800 (PST)
From:   JunDong Song <jundongsong1@gmail.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org
Cc:     robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        JunDong Song <jundongsong1@gmail.com>
Subject: [PATCH 2/2] PCI: dwc-host: Add a warning to prevent invalid values
Date:   Mon,  7 Nov 2022 23:31:08 +0800
Message-Id: <20221107153108.5770-2-jundongsong1@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107153108.5770-1-jundongsong1@gmail.com>
References: <20221107153108.5770-1-jundongsong1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_pci_get_max_link_speed() may return a negative value,
causing the controller to not set the speed correctly.
Add a warning in case the driver engineer misses it.

Signed-off-by: JunDong Song <jundongsong1@gmail.com>
---

When I use the pcie dwc driver, the controller speed is abnormal,
but it has not been detected because of the @max-link-speed error,
so I think I need to return an error or warning here.

Thanks.

 drivers/pci/controller/dwc/pcie-designware-host.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 39f3b37d4..0103b9a63 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -429,8 +429,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->io_base = pci_pio_to_address(win->res->start);
 	}
 
-	if (pci->link_gen < 1)
+	if (pci->link_gen < 1) {
 		pci->link_gen = of_pci_get_max_link_speed(np);
+		if (unlikely(pci->link_gen < 0))
+			dev_warn(dev, "Failed to get max link speed\n");
+	}
 
 	/* Set default bus ops */
 	bridge->ops = &dw_pcie_ops;
-- 
2.25.1


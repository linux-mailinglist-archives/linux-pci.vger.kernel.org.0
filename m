Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1409628879
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 19:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiKNSmc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 13:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiKNSma (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 13:42:30 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E35C27FC5;
        Mon, 14 Nov 2022 10:42:30 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id q9so11844796pfg.5;
        Mon, 14 Nov 2022 10:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpTIatzX4u0/HTzbO8qsPMYL1u0QJMJqvc+Ay+4dShg=;
        b=oN+4b9T+Dew1mTgGEMv9v9FGxRc9HQYBG2w0r75hfEZbSYdp48q14k6Pgbs14/03J/
         3g9/jxgfkSV32KvT6B1q7GeWDLFoU5mzEVv7y3kRTsFVn5FLr9PeGNpPBHtM13HG//95
         qtBOBxti2sTb4tCSH340vG3TeYxZ22+ImmeokryBGDCUKe0+hAAs9eIw5r6+45QfmzJj
         ecJ4aoF6+YekNk+Qyq+pIE6pJXFOE9kw5YEnTxomRWo/wvZF5yGN4cvfr/u2MTLUsbtT
         YzVsmh2/EzQlUWaUJmxe+m94vTHK+/DC3NQibibmwfHuQpb1zIyoMYWxm+FyS9ezqH2Q
         YwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpTIatzX4u0/HTzbO8qsPMYL1u0QJMJqvc+Ay+4dShg=;
        b=PWjVhRwK93z1sfbUGrVCszWERm5yzrXND/qrM+m7cWcbgabi+X76SzxH8rLx461wXf
         KwNwJFR3g5g/RoQ/swYdjfa/Z69NWsvRQiI4qmrUK9y5NptpQnqUQ+Iegn+HG1nZuB66
         tG+tHsPiSiv3S0ObuoNZmRaiX+Dd8NTez85c54pTqwXeKlogvzEIDcfF7ZumoyS5vM1q
         wi/CjMjwCHKRUrQGUIZuY61zS0FlPBtCubsO3iY+49SZSHDK6JsujYGsvJQETq4yrW4g
         eypcklchk0DPJMl+UGy9pnFBlzXdSKmynBa6RBRu2q9SQHfK7OBV40mkoiewqa5Gfn4d
         dt3A==
X-Gm-Message-State: ANoB5plzvqZZWLZ4R1yfk5u5y+taTRz4gxuWkO185Ne7A2sC6ucaEyGX
        xL2QaHaj9VGgCaFt2+A8VRO6Rc1acXk=
X-Google-Smtp-Source: AA0mqf6kHjQZNow4sM/pm272u3Td0bf10ylBH/gZBS3wr5AONc9syi+cyupcpd1CF+jL1Wbc0+OhXg==
X-Received: by 2002:a05:6a00:c8b:b0:56e:d7f4:3c49 with SMTP id a11-20020a056a000c8b00b0056ed7f43c49mr15014102pfv.50.1668451349537;
        Mon, 14 Nov 2022 10:42:29 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5c17:fc5a:f127:5bb5])
        by smtp.gmail.com with ESMTPSA id c27-20020a631c5b000000b0046ec7beb53esm6203376pgm.8.2022.11.14.10.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 10:42:28 -0800 (PST)
Date:   Mon, 14 Nov 2022 10:42:25 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH] PCI: aardvark: switch to using devm_gpiod_get_optional()
Message-ID: <Y3KMEZFv6dpxA+Gv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Switch the driver to the generic version of gpiod API (and away from
OF-specific variant), so that we can stop exporting
devm_gpiod_get_from_of_node().

Acked-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2:
 - collected reviewed-by/acked-by tags
 - updated commit description to remove incorrect assumption of why
   devm_gpiod_get_from_of_node() was used in the first place

This is the last user of devm_gpiod_get_from_of_node() in the mainline
(next), it would be great to have it in so that we can remove the API in
the next release cycle.

Thanks!


 drivers/pci/controller/pci-aardvark.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index ba36bbc5897d..5ecfac23c9fc 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1859,20 +1859,19 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
-						       "reset-gpios", 0,
-						       GPIOD_OUT_LOW,
-						       "pcie1-reset");
+	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	ret = PTR_ERR_OR_ZERO(pcie->reset_gpio);
 	if (ret) {
-		if (ret == -ENOENT) {
-			pcie->reset_gpio = NULL;
-		} else {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "Failed to get reset-gpio: %i\n",
-					ret);
-			return ret;
-		}
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get reset-gpio: %i\n",
+				ret);
+		return ret;
+	}
+
+	ret = gpiod_set_consumer_name(pcie->reset_gpio, "pcie1-reset");
+	if (ret) {
+		dev_err(dev, "Failed to set reset gpio name: %d\n", ret);
+		return ret;
 	}
 
 	ret = of_pci_get_max_link_speed(dev->of_node);
-- 
2.38.1.431.g37b22c650d-goog


-- 
Dmitry

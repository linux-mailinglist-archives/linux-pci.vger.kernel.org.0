Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 058FC1A3D78
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 02:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgDJArw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 20:47:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44124 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgDJArv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 20:47:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id cb27so513623edb.11;
        Thu, 09 Apr 2020 17:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aeb6WaCv9+BqBEPfkzxDMWuTT6GpZmxwwCdelm77Gbc=;
        b=GAo1LCkscF+/t0GiJq5CqFhSJsAXoQCLXRI5K8wZlBDeenlGWbDDYRzgLHCR6NkbvL
         FOG8Jfcted4yeKOiTk+PjwUn16uZbLtfT7AAkLNkaYiQ9cIX+yQJx9Fq5TNKkwd8Yz4z
         OWvEaDD4aHUYV8/2bMW4HIyKtekvS5cDUdT801CK04XSzh8ddz3eDq8PzmpO1+Xv2w41
         sYrSN9KHWYWg1bU7Y3pGrvdW1V+KlI2KUW1QxKGZcMNuyMi3jeGCWhFP8aBTAMTyHpO4
         ETcztWRl11jYuTq4HqeYvSBhSjZQgwZau5fpgXnAn77d/+JMHRxDSMUiav8i/GfQejlm
         staA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aeb6WaCv9+BqBEPfkzxDMWuTT6GpZmxwwCdelm77Gbc=;
        b=AA2eyH8o1+RxOomJtEJnysNxJflI1Ln3dIDrl1TTRQRZM2t4eybagjLqS6rsUZ9D5z
         dswsEAHjWUwp641La+GMXcsTw4GoakS7RX6YZlk1oVleTGDdNAJ6NwOWPl6xODwqPVqi
         KAhbQglWtgrH4uLSPQF5XOtl1VvpPuJaA9A7thcaeJu/h40AxRDETdnTSushHLKQ23Wh
         rD+3ZfaAdLPFzXI6iW5qqpqfiHTLGde4LG/B4hb9V8kWJPulXFk4mgY57t7U8Lc3hyZU
         LyTvr+bnkZPnImx4wgJmD09Y37iGQJbIEf2oQmcbWlZDefdpy8oh6Di/wPOe0RxY336s
         cvJQ==
X-Gm-Message-State: AGi0Pub+70NKdoSxDmYYmvo0cMfPrgumAPLYiff1W3k7C4gBc7fMUndz
        filTKB0VplWZUTwtUnQOYbr9vd/9z+bQm49Y
X-Google-Smtp-Source: APiQypIdEyfEOx5q5eI9Aq9XOBio5duIss+ITVGGn0sW+sZmX/FPNCSsU+kshlb3ePbWwBuwIagx3Q==
X-Received: by 2002:aa7:c559:: with SMTP id s25mr2671184edr.2.1586479669036;
        Thu, 09 Apr 2020 17:47:49 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host117-205-dynamic.180-80-r.retail.telecomitalia.it. [80.180.205.117])
        by smtp.googlemail.com with ESMTPSA id z16sm30523edm.52.2020.04.09.17.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 17:47:48 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] devicetree: bindings: pci: document tx-deempth tx swing and rx-eq property
Date:   Fri, 10 Apr 2020 02:47:35 +0200
Message-Id: <20200410004738.19668-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200410004738.19668-1-ansuelsmth@gmail.com>
References: <20200410004738.19668-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document tx-deempth, tx swing and rx-eq property property used on some
device (qcom ipq806x or imx6q) to tune and fix init error of the pci
bridge.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/pci/pci.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 29bcbd88f457..df37486f1853 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -24,6 +24,24 @@ driver implementation may support the following properties:
    unsupported link speed, for instance, trying to do training for
    unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
    for gen2, and '1' for gen1. Any other values are invalid.
+- tx-deemph-gen1
+   If present this property will tune the Transmit De-Emphasis level for GEN1 if
+   supported by the driver.
+- tx-deemph-gen2-3p5db
+   If present this property will tune the Transmit De-Emphasis level for GEN2 in
+   3.5db band if supported by the driver.
+- tx-deempth-gen2-6db
+   If present this property will tune the Transmit De-Emphasis level for GEN2 in
+   6db band if supported by the driver.
+- tx-swing-full
+   If present this property will tune the Tx Swing Full value if supported by the
+   driver.
+- tx-swing-low
+   If present this property will tune the Tx Swing Low value if supported by the
+   driver.
+- rx-equalization
+   If present this property will tune the Rx equalization value if supported by
+   the driver.
 - reset-gpios:
    If present this property specifies PERST# GPIO. Host drivers can parse the
    GPIO and apply fundamental reset to endpoints.
-- 
2.25.1


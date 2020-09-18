Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F94F26FCA9
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 14:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRMiG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 08:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIRMiG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 08:38:06 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C4DC06174A;
        Fri, 18 Sep 2020 05:38:06 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q13so7870145ejo.9;
        Fri, 18 Sep 2020 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=C3L8FHC8pVB+ke5fyumGQXGBhyh3niEL0JqYDFP4IUg=;
        b=hK4Fhn5Y9TdVvaMfz4AtRVBo7Y83REpfZNwEV+UGzTp5QdfsucZPO+UgzrVnyinhNd
         vm6Ir8ZokovYeBMciEYP0Re8apuTkOCOPfpkiEs1ZCXUVoIueZ92a429K3z3WRq1xyHJ
         vJzb3sZk7+ACtOz8RLB4ugzJN0nfrKbtnPV9V817ZJ1tnYwUH62nqQr3McHjiE1wjetJ
         0ElGoxky1jwn83UCkFQ8Njio0/mOePLvZ0aXJ4Fozit+LhiPDMgaF8OIFopS2IKa2euu
         /ZI4izaE27PCh1oW1xHqCGWOYoQSu3HAcbFfTu5P8S85XMCKP9QPg8uaRSAXfPYqO9Ax
         /D1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=C3L8FHC8pVB+ke5fyumGQXGBhyh3niEL0JqYDFP4IUg=;
        b=XMxQFtTwa59ywcxUOY9Kn7CeGbJEThj9eIEeCx75aeBmgGVTtd5kDDy5efV8I1kbm3
         glVSi6QpGJ17GSO+5N3fvWM45hYFVfA9Dsd+FGzf0G6lxf/wWKUIT+kA+WhFloGrnZW1
         JnyJE0MQIpDKBiPHqr2kXI1daSzybKMUj5xk7yywa+nTo4X+sLgR0W/Mpvsf4bA662Ti
         9VC2t+ATjMrSgGKtuzj2Azegc7YcPbqZC4u3tTLCT5T0v8HyaXy1NWgWfgTPTqYY6oy2
         8uhInk6/AxT5fzg6la+Y/E5+yVdVh9S6wZBCtVuq3O2wBlADTFTBuGB43I6/hI7RCUSG
         mZAg==
X-Gm-Message-State: AOAM533ei6EwcIR4Lban0LkievOr/6wMyUBlo+dIA8DeQR+DZjODcOn5
        WlYYqxp81OAVGyFpKpSAInI=
X-Google-Smtp-Source: ABdhPJzL3EoERf6TmjAo3oDojMrpAPFkGZHMjAxd/QPbR1R96f+ZpYd6SUhl2mZIdDtpA3A2FzKXfw==
X-Received: by 2002:a17:906:c447:: with SMTP id ck7mr35103009ejb.358.1600432684853;
        Fri, 18 Sep 2020 05:38:04 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b904:dd4c:75d6:3bdd:1167:483e])
        by smtp.gmail.com with ESMTPSA id la17sm2244789ejb.62.2020.09.18.05.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 05:38:04 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com
Subject: [PATCH] PCI: kirin: Return -EPROBE_DEFER in case the gpio isn't ready
Date:   Fri, 18 Sep 2020 14:38:00 +0200
Message-Id: <20200918123800.19983-1-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

PCI driver might be probed before the gpiochip, so, of_get_named_gpio()
can return -EPROBE_DEFER. And let kirin_pcie_probe() directly return
-ENODEV, which will result in the PCIe probe failure and the PCIe
will not be probed again after the gpiochip driver is loaded.

Fix the above issue by letting kirin_pcie_probe() return -EPROBE_DEFER in
such a case.

Fixes: 6e0832fa432e ("PCI: Collect all native drivers under drivers/pci/controller")
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index e496f51e0152..74b88d158072 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -507,8 +507,12 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 
 	kirin_pcie->gpio_id_reset = of_get_named_gpio(dev->of_node,
 						      "reset-gpios", 0);
-	if (kirin_pcie->gpio_id_reset < 0)
+	if (kirin_pcie->gpio_id_reset == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (!gpio_is_valid(kirin_pcie->gpio_id_reset)) {
+		dev_err(dev, "unable to get a valid gpio pin\n");
 		return -ENODEV;
+	}
 
 	ret = kirin_pcie_power_on(kirin_pcie);
 	if (ret)
-- 
2.17.1


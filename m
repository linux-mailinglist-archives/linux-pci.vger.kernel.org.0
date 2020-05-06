Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFD11C6761
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 07:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgEFFVn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 01:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725771AbgEFFVm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2020 01:21:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BB8C061A0F;
        Tue,  5 May 2020 22:21:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so946356wma.4;
        Tue, 05 May 2020 22:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h0iQI1iKMcPBV71I0g0LMiicdhg13r/twgoexAQYjOg=;
        b=msl6k3xUOP10ZQIrXYCaMFC2eKJGRBqIerIoJac6rmTcPojb5Amlk5NSjGXfAbSLrp
         DWpQMdcDVsOq36HanaHkqt7E/lp2zVW1oivOFY/qts17Xl25PZv4GqbBBjfczdyLzsuy
         waEtAer881cl93H0GnivxsSJzfcr0vH5BKMRiPoBUbE0Lc9GXlxAjaVDQ7v5WEf97NTS
         DZg7QOHdbliVz5LqPk0Pi9gMF+8QY8gy2icTnL0nj/7DiH8i+6PKQTf/76cNq2WDxOMb
         nebvdY5pYh0zzDDt9S6IodHoVQA2HZi/YaHZ9p4Mo8hvF2Y/akMSm4vp7nUvQm6TNcEV
         WIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h0iQI1iKMcPBV71I0g0LMiicdhg13r/twgoexAQYjOg=;
        b=VrLx9NYIW+OQPFPV1Iq/a13Ba4uM1h5vqeLi+McsDD8L+VggRnLXmWxdHdJn08OTnx
         exhyiGn0Nw23o2aFG4A+tkHbvChYFpf+C3g6x3iBZCbgn2yvwLQF/4I74i5HksT2ZH6o
         Ik78jhxJSUJHaNjz/AQS6bJVdYQLsqU423jjd/79RJzoiQDoDtHJzP00eTtoGijFPBqn
         9vNirrDyNh4D6csjASbLb0mw2oTtnq8THHi/OrR3XT1TySQPtPfRjkS29pZdkmwjPjlZ
         LfMcZeWcINxCFKThXmasi4kspYNDkvTADvYYOvA8NInsLJkkU3a2J1Jr47OYlu4n5agG
         Wr/g==
X-Gm-Message-State: AGi0PubxOFrB1oxSfWLb4TZSHbUYCWBXRiwQW2EnOw4fZRJFSUJgakvL
        JOS0R/dNYnYTLaQIaKGq+dnwL3Cslj8=
X-Google-Smtp-Source: APiQypKagx74+kFJPZfSSYCvqwjyzlhtiJgX+PfEa4CrNrzTZMNBMRv1S6YPTwKV7XdGDQHsk90mOw==
X-Received: by 2002:a7b:c0cb:: with SMTP id s11mr2555917wmh.180.1588742501192;
        Tue, 05 May 2020 22:21:41 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2df1:2500:bc2e:80a7:2be5:2fcf])
        by smtp.gmail.com with ESMTPSA id z16sm873707wrl.0.2020.05.05.22.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 22:21:40 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 RESEND] MAINTAINERS: correct typo in new NXP LAYERSCAPE GEN4
Date:   Wed,  6 May 2020 07:21:30 +0200
Message-Id: <20200506052130.5780-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 3edeb49525bb ("dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4
controller") includes a new entry in MAINTAINERS, but slipped in a typo in
one of the file entries.

Hence, since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: \
    drivers/pci/controller/mobibeil/pcie-layerscape-gen4.c

Correct the typo in PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Rob, please pick this patch (it is not urgent, though).

v1: https://lore.kernel.org/lkml/20200314142559.13505-1-lukas.bulwahn@gmail.com/
  - already received: Reviewed-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
  - Bjorn Helgaas' suggestion to squash this into commit 3edeb49525bb
    ("dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4 controller") before
    merging upstream did not happen.

v1 -> v2:
  - v1 does not apply after reordering MAINTAINERS, i.e., commit 4400b7d68f6e
    ("MAINTAINERS: sort entries by entry name") and commit 3b50142d8528
    ("MAINTAINERS: sort field names for all entries").
  - PATCH v2 applies on v5.7-rc1 now. Please pick v2 instead of v1.

v2-resend:
  - resend of v2: https://lore.kernel.org/lkml/20200413070649.7014-1-lukas.bulwahn@gmail.com/ 
  - still applies to v5.7-rc4 and next-20200505

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..0fd27329e6f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12941,7 +12941,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
-F:	drivers/pci/controller/mobibeil/pcie-layerscape-gen4.c
+F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
 
 PCI DRIVER FOR RENESAS R-CAR
 M:	Marek Vasut <marek.vasut+renesas@gmail.com>
-- 
2.17.1


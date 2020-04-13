Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE8551A636A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 09:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgDMHHH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 03:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbgDMHHH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Apr 2020 03:07:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0816C008651;
        Mon, 13 Apr 2020 00:07:05 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 65so9217289wrl.1;
        Mon, 13 Apr 2020 00:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AAv/DZIIqObpFGeuaX2msSUs1tzPRF/Ik5oZ/oe4Msw=;
        b=GxPUIOQc1pkI91EKUzGLU+h8wVXFyWA+PWpEfNbqlfBG6isc+YN+GtlVCFModDU+lU
         3/xJ0tGwG8EnhevVYL1Xm1vzZxBEhJcOX0/0e+AJ+yqet4iyAXxQJDTcuTonUc140Hwv
         5x/dbuMt4LhpHeRKNlAbMomCi2Z1qig2UJ7oGWp1AdmXAwse5kj1xiQWknMQDVAsDHaS
         BGEzUPwQas933q7whObeYE30gOYv8dzjUrp3uPTeg8kEhDS0Hj7WGqAgbsN97IZaED+z
         SllAMWJ516LMKa1PNwXKwG3FJqnAqRSR51jhKd7WJEspSjUQ/ZX0MQGVRHiMJqwV4iSr
         IdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AAv/DZIIqObpFGeuaX2msSUs1tzPRF/Ik5oZ/oe4Msw=;
        b=saNOb+C5mz0FP1Brds8n5OCQkJ4tdV92Y6dlQCNxxy8oFob9T64DZtoU4iYlebMlTZ
         4CMbVtFFsel0Y7o0Jv0sEj33+LVSP+/iiwrM2hP3z+Yj/i+dJ9CzG1QbY73CjWIQp+da
         gP6kKoUC9pmsQtvQEW1o1b9K/LgFE/yQyghrbe9FVdan4prEvq4d7SrhI4qTmgwUEMd4
         ft5u5EYtPcoAJ3bBInqln75DA+WtOAtaj40RBIPHljPQlHos6m1XWdEP/ZZouKtOoIfP
         cO+o03u/TaBJwAaqzz9OdiJ7KDpDFkVJIwCRZCP5DIqNk7kuBhtAOYMr8qZjcJ5g9SZN
         EJpQ==
X-Gm-Message-State: AGi0PuYlC24tNHgTv1nT7wPjyUGOGsFClUxL6KH+xcpaDSqgg8dBEJCN
        sCUk+zyfSl74hAnZHF/5Bu4=
X-Google-Smtp-Source: APiQypLTafHisWQ43wHE8ka6qzevNdAkeaCgrnVZbGgzHgnjRaYxOf9JhrdyAQuGeO8eF3HBAoDsWg==
X-Received: by 2002:adf:cd12:: with SMTP id w18mr17078764wrm.311.1586761624661;
        Mon, 13 Apr 2020 00:07:04 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2da9:2f00:c0be:812e:7fb0:ebe0])
        by smtp.gmail.com with ESMTPSA id q18sm7173352wmj.11.2020.04.13.00.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 00:07:03 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] MAINTAINERS: correct typo in new NXP LAYERSCAPE GEN4
Date:   Mon, 13 Apr 2020 09:06:49 +0200
Message-Id: <20200413070649.7014-1-lukas.bulwahn@gmail.com>
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


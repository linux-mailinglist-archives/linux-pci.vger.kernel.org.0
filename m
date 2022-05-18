Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4001752C39A
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 21:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbiERTmU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 15:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242069AbiERTmU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 15:42:20 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477686EB0B;
        Wed, 18 May 2022 12:42:18 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id x12so3046579pgj.7;
        Wed, 18 May 2022 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=rT3oa73xcTkbyKbZvAP0rpZLJAssviOZM8Y3RSNfhUQ=;
        b=Ss0uYNtLa/8IAbmW7eG22wtU/AKDcZo0H8gGz7YaF4Ovo9vKLt54KXvbcgtxQJOleU
         Xi+Vhb2Wh6NnGTPcZ3Z/ZGpCZPyo1bf+8RaUpsVuNpKNvi3I1jWcd+UXTiKTRdzs9FcL
         Uv7vTo1Nl7ls5uKRTDJsqYbdVT1kiFLzN79sCJgxOFZ+Sti9Hf7vmId/GaBtxGQ6qYme
         8FjJitq/w28r2fHj9WE/Ug/I0CFOsQtUajwnfkSBBfYx70M+0oKLNYQ4zP/7HCa0obXn
         NSYavvW/iA6xo12wU7/HpoTvG8b/WZsZ1bh/ZCn1vxUxTtAYjA6op9I211wnFYET1l/V
         XzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rT3oa73xcTkbyKbZvAP0rpZLJAssviOZM8Y3RSNfhUQ=;
        b=CWLTnSmkfrIj3XBrM/Jy/aGZYh09KwXu2uXrCWKUdhqfW4YS4ccyBQAeD7VbHREtvX
         qlscXyIjgD5hlmO/dKM6LvLaveF8oOsiOx7w4fMAhIv3/+XXlgh+TmDprk7VpxDgFwqg
         2kwPZ/3AIOzLtxkKsiDtQ13lL4lcUxCvK1R5tMHEoty3ULSfxIH1bZq5fvo8iAyBODn5
         0oTWwMMiEon9r78ogeZnz4BmE9YbN8zAjc6cYlNIUuJcHz+Y1Z+P/kKZ0ZFvxCi4cWd/
         ildbpkLHsTHEfzZlZaoSbVMm68Z2x98lqZ3ENJaOcuFj64uKC6IA5ewPMLitu5LrQPPw
         JRHA==
X-Gm-Message-State: AOAM533nygbGUgDG9b5A3ndYY5A2bzaF/9tZ52L+rDYrAm8poPX7RBap
        xt1C+661s5A79WaQHiEH6yzoj9KiaRawsQ==
X-Google-Smtp-Source: ABdhPJy4GhpCLByKZa531OCaCG0BJCwsLPGSG/QCgnluQs4C2+MuSZJQ77ZaPIdIhvXGTjUla7eSnA==
X-Received: by 2002:a62:f901:0:b0:518:307a:b392 with SMTP id o1-20020a62f901000000b00518307ab392mr949450pfh.44.1652902937630;
        Wed, 18 May 2022 12:42:17 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id g10-20020a62f94a000000b0050dc762815esm2362469pfm.56.2022.05.18.12.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 12:42:17 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, james.dutton@gmail.com,
        kibi@debian.org, bcm-kernel-feedback-list@broadcom.com,
        jim2101024@gmail.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe linkup
Date:   Wed, 18 May 2022 15:42:11 -0400
Message-Id: <20220518194211.20143-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")

introduced a regression on the PCIe RPi4 Compute Module.  If the PCIe
endpoint node described in [2] was missing, no linkup would be attempted,
and subsequent accesses would cause a panic because this particular PCIe HW
causes a CPU abort on illegal accesses (instead of returning 0xffffffff).

We fix this by allowing the DT endpoint subnode to be missing.  This is
important for platforms like the CM4 which have a standard PCIe socket and
the endpoint device is unknown.

Please do not accept this commit until someone with a CM4 has tested
this solution; I have only emulated the problem and fix on different
platform.

Note that a bisection identified

commit 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")

as the first failing commit.  This commit is a regression, but is unrelated
and was fixed by a subsequent commit in the original patchset.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=215925
[2] Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml

Fixes: 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
Fixes: 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215925
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index ba5c120816b2..adca74e235cb 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -540,16 +540,18 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
 
 static int brcm_pcie_add_bus(struct pci_bus *bus)
 {
-	struct device *dev = &bus->dev;
 	struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
 	int ret;
 
-	if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
+	/* Only busno==1 requires us to linkup */
+	if ((int)bus->number != 1)
 		return 0;
 
 	ret = pci_subdev_regulators_add_bus(bus);
-	if (ret)
+	if (ret) {
+		pcie->refusal_mode = true;
 		return ret;
+	}
 
 	/* Grab the regulators for suspend/resume */
 	pcie->sr = bus->dev.driver_data;

base-commit: ef1302160bfb19f804451d0e919266703501c875
prerequisite-patch-id: 23a425390a4226bd70bbff459148c80f5e28379c
prerequisite-patch-id: e3f2875124b46b2b1cf9ea28883bf0c864b79479
prerequisite-patch-id: 9cdd706ee2038c7b393c4d65ff76a1873df1ca03
prerequisite-patch-id: 332ac90be6e4e4110e27bdd1caaff212c129f547
prerequisite-patch-id: 32a74f87cbfe9e8d52c34a4edeee6d271925665a
prerequisite-patch-id: f57cdf7ec7080bb8c95782bc7c3ec672db8ec1ce
prerequisite-patch-id: 18dc9236aed47f708f5c854afd832f3c80be5ea7
prerequisite-patch-id: dd147c6854c4ca12a9a8bd4f5714968a59d60e4e
-- 
2.17.1


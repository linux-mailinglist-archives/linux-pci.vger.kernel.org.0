Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0593318586A
	for <lists+linux-pci@lfdr.de>; Sun, 15 Mar 2020 03:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgCOCHR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Mar 2020 22:07:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34735 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgCOCHQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Mar 2020 22:07:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id i24so13505641eds.1;
        Sat, 14 Mar 2020 19:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=owNdHbXOWvXX+OlxzZcv65vzJGoyLsxbbtN7CwBZUdI=;
        b=MeALrmArJtRbuiamFVBTOFlHV4itXzG5e8wOZhzp68mdH9SHNTMTC4ozlazK8OxMF8
         zKdTSjVj40QQY2vPxc0ESGrfym+h6/rk/Gb6wx2jbAVven+pAHY9+d8d9Cc9+WJrvzHX
         pUlq3KoqK+GXX7lqf3w9udtpZ6EIMz8q+r7V9d7bB1fjPAZv15DyNmQ4sauXIhPkhXsh
         oUFZ3dwmI7skBYGeGjsYPwSD7zsIII3Kffz3BIaXjSpB1w+Akk7yCwA6Rwj2A1Zm6VsM
         Epf03zpI6QxSBN0SzFGjoFL6RxhWl3HCs14VOFKaFon7EfpwNe5kh/z6WXQADNUzeGaZ
         TZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=owNdHbXOWvXX+OlxzZcv65vzJGoyLsxbbtN7CwBZUdI=;
        b=TEGdCApc7hXJ6lRliZ16q+GrwRmG93k/YoUPoCJ9n8Dp6+dnPhKqe4m05ikvzus1F+
         bLw8y4n9KLtiR3uajgo6o0HhSaxV0ev7MYr+B5Hin2pLIy30B4O/5in/DedDEHih8ZZe
         PUWjrsXBRGcPyozKCuP91VWTGBi5aMvorZQvjrijfBx7MdMAtoGXO0mIHTiFhYH2Rkwh
         cE+E3MzwtK+1zabHa9JQhTSoszCdfJVKkXIkPjLj29CKTEWPNU9eERTxh8hxeAJqrxc4
         9sgAjwrkvwCqbOsLe1XWASDiixm5t9LbC+MZF5K2ecGAo70+JX/vrEga4uGcrwwjm/AU
         xbDw==
X-Gm-Message-State: ANhLgQ19xJNSBFdDpis7bnMWQ+akZY9DeKTjO7iIg2HGx1SWcCBEYGEG
        AVAXJfxbi9baBDdvF9owL8IILfTe
X-Google-Smtp-Source: ADFU+vsoCpaYAcicq37YrSeOXYcEWIKD99iwmm+7yeuQpkomIFb41onnAG26ZzpxMyrKYrbL8FB2qg==
X-Received: by 2002:a17:906:54b:: with SMTP id k11mr16615900eja.179.1584195978147;
        Sat, 14 Mar 2020 07:26:18 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d83:b000:18:83ff:47cd:7417])
        by smtp.gmail.com with ESMTPSA id v13sm751777edr.88.2020.03.14.07.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 07:26:17 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: correct typo in new NXP LAYERSCAPE GEN4
Date:   Sat, 14 Mar 2020 15:25:59 +0100
Message-Id: <20200314142559.13505-1-lukas.bulwahn@gmail.com>
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
applies cleanly on next-20200313

Hou, please ack.
Rob, please pick this patch (it is not urgent, though).

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32a95d162f06..77eede976d0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12858,7 +12858,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
-F:	drivers/pci/controller/mobibeil/pcie-layerscape-gen4.c
+F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
 
 PCI DRIVER FOR GENERIC OF HOSTS
 M:	Will Deacon <will@kernel.org>

base-commit: 2e602db729948ce577bf07e2b113f2aa806b62c7
-- 
2.17.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A5D3F0E60
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 00:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhHRWvR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Aug 2021 18:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbhHRWvQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Aug 2021 18:51:16 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62B3C061764;
        Wed, 18 Aug 2021 15:50:41 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k24so3921131pgh.8;
        Wed, 18 Aug 2021 15:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=ZG1sxfcg11eb+OlhxMU3WYQIQAOCwbVF4xLfvljFf/A=;
        b=J0VGbyJ9f9WnKCM9m6kd4tA3/GNbolIFi0eRzsamX2lVjd/+Ga6BCQDsG2D6OE4FZt
         fzCL0YHOAlY81/Jiax4P85k30vSqyvmuDX+1AUqDwVjV3cCW3gmpVpdHlawO0sBDEmVG
         5e/jTJqY5AfYJuWpijOy/TM02Ot2tPtSI9ViTynxdh4rueOtpCPb+yNp/wzzLMCE4nAT
         3B0SLjfCfdg5CktM0YU3g/+ofxvjN7/igRgxrPMLZwt0b+F/HqrL4l3jZkYG6nnAjsFr
         ab4bZFVB1nhBk+HwoKKlKQbUFmVaPT7pyjsiTeN3D7SVLfflSaWZeTD92l0PU/p/Ie1B
         uGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ZG1sxfcg11eb+OlhxMU3WYQIQAOCwbVF4xLfvljFf/A=;
        b=Pab7HZgRcUiB3Gr1rI/JN6FbF4coF1CjmvAC5R/95k1C4C8atR/NpXdTENZAAnh3Uj
         FRt/fRd81TBXog/Al+OQExHv6c5KQH/AwSSTYUnpn6XDjPmJz8GysHB7OSsjzUXhcPZa
         WWRD95kvtDikZDjLMDOwzH/8QU8fTHAduSHtDI6GxqGi2ihdTNswqXNtVj9IDs1QvGKU
         O7SubqNisf2n2iNVXjnIuEO0OiNYiJQwDqKPWARqXd/c6VC+MVkWC861aWwojh6l0LD5
         B6m/dp9Z6VojbFrs9UzheU5RSTwN5c1/uNsTmFyQ4nQ0QAZstiQmRggQYFFnpxVtiKge
         Zhjg==
X-Gm-Message-State: AOAM532keDEB5D/LPleMXEOI46NeN1Zp1opdYevKT/T2Mfo+jwDh+yJc
        PQ++YCKSvi+n3YtdO9RDcVaZ7RDYR1WJtA==
X-Google-Smtp-Source: ABdhPJwQn2EmY+UXC8ggAxAppXzzNmAuFQxI60I0slSETzIP9XvM5dWOpB3pALC4y1xjpbGz6ZhoOQ==
X-Received: by 2002:a63:d910:: with SMTP id r16mr10943274pgg.318.1629327040920;
        Wed, 18 Aug 2021 15:50:40 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id h25sm839963pfo.68.2021.08.18.15.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 15:50:40 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        f.fainelli@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        jim2101024@gmail.com
Subject: [PATCH v1] MAINTAINERS: new entry for Broadcom STB PCIe driver
Date:   Wed, 18 Aug 2021 18:50:30 -0400
Message-Id: <20210818225031.8502-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The two files listed are also covered by

"BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"

which covers the Raspberry Pi specifics of the PCIe driver.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc0ceef87b73..0f5c8832ae49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3809,6 +3809,16 @@ L:	bcm-kernel-feedback-list@broadcom.com
 S:	Maintained
 F:	drivers/mtd/nand/raw/brcmnand/
 
+BROADCOM STB PCIE DRIVER
+M:	Jim Quinlan <jim2101024@gmail.com>
+M:	Nicolas Saenz Julienne <nsaenz@kernel.org>
+M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	bcm-kernel-feedback-list@broadcom.com
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+F:	drivers/pci/controller/pcie-brcmstb.c
+
 BROADCOM SYSTEMPORT ETHERNET DRIVER
 M:	Florian Fainelli <f.fainelli@gmail.com>
 L:	bcm-kernel-feedback-list@broadcom.com
-- 
2.17.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075DC466CFA
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 23:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbhLBWjg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 17:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239088AbhLBWjf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 17:39:35 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1912AC06174A;
        Thu,  2 Dec 2021 14:36:13 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so933065pjb.1;
        Thu, 02 Dec 2021 14:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nAYeNDvhgDILO8lux5iSfJYMw3kenwEJyvnf9qyQGHY=;
        b=dk9JFHkmHdKrSkr93JaABRmJlytvDl/PdTmdWSrmiRZTD3caX04RaPvbiiINcKEcOV
         amRtieAZ6db571P8cTk5I+ArMvnfhcZJmkVEFRZPVfor3MrLlONqU3gG5Hq2JwYTdvID
         Ugd/Bhk9pxmEoKcAd5NUxTBIM+McbMGIPYzZzYaixSjky8Y9B8AY1Otctpc8/tXkRgLX
         mwcT9CKX13NSNtlOyIRMFgnqP1W+Px92DL9hUkn/UuH/Z72L0ybvN9xnwMHOQ5sI7MUX
         1FwEusE27ZKg6xWvEsgrPy+GlubHjbzzI5xGxFhTdqJmVFiUXQDqrr1yaqa7ugqKnGvi
         ZSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nAYeNDvhgDILO8lux5iSfJYMw3kenwEJyvnf9qyQGHY=;
        b=TbqhZXMO9f+nucLWsA/wPBHeMiqkza8CFFp9rGbaXgyLnSdABwONNJQrYIrD+JlKWE
         gbDSi+WWjEiA+P3lYRC+pAPqQVpoUritpNas8Fbe+FaqKr209CmNZ1K6SLQ46Dz1EfXJ
         TsaABUJ3STjtqUYAnULr2TKCgR00PHPM094jBd+c+/XxXNOpGs7rfOMXIcpRdvmIBvhy
         PURlO/KYYluGDmp34ntSDOwARh+GbcGv02gkTrm1630DKVX8i3+EQbcY9Gqd/t3zhk8I
         G+qN3sqXC28tBgQ6yqcX6gqBZBkJviwpRXn8BTt5GhtPeydRIduDf0hJ14Iz57SLuuNd
         poKg==
X-Gm-Message-State: AOAM531KNbTBHrkmfBgDQYInAFuMQyjQjeFwSI+FbfwWqFrJWqeqPNy7
        /neXSlYXbJxdGMcCuSRFobr4VNgmXWQ=
X-Google-Smtp-Source: ABdhPJzWiCEYVzvMY11bnTFeDDpQl/Ef63/fx3srX8uWojUPNH1LJHpa+wYtCA11gLyzNBz8zu2rJg==
X-Received: by 2002:a17:90a:7d09:: with SMTP id g9mr9141036pjl.199.1638484572260;
        Thu, 02 Dec 2021 14:36:12 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h18sm790996pfh.172.2021.12.02.14.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:36:11 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Jim Quinlan <jim2101024@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-pci@vger.kernel.org (open list:BROADCOM STB PCIE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dt-bindings: PCI: brcmstb: compatible is required
Date:   Thu,  2 Dec 2021 14:36:09 -0800
Message-Id: <20211202223609.1171452-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The compatible property is required, make sure the binding documents it
as such.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 1fe102743f82..7c24d711b377 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -76,6 +76,7 @@ properties:
       maxItems: 3
 
 required:
+  - compatible
   - reg
   - ranges
   - dma-ranges
-- 
2.25.1

